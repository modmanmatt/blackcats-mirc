/*The source to some plug-ins have been provided
to allow you to help improve and add to the 
abilities of the server. The original code is property
of GuildFTPd and is for the explicit use of you,
the end user, for use with GuildFTPd.

Redistribution or reuse of any parts or whole
of the program code is only authorized when
credit or a reference is provided within your
program or program documentation  that the
code is an original component of GuildFTPd.

Downloading and using any source to any plug-in
assumes your agreement to these guidelines.

By downloading any of these source code archives,
you agree to these established terms. If you do not
agree to the terms outlined, you are restricted from
downloading them. 
We welcome any submitted improvements to any
of the original plug-ins or brand new plug-ins. 
Any such plug-ins will be considered for
distribution on the GuildFTPd website. 
Should we post your plug-in, we will also provide
due credit to you for your work.*/

// Stats.cpp : Defines the initialization routines for the DLL.
//

#include "stdafx.h"
#include "Stats.h"

#include "..\api\PlugInTypes.h"
#include "..\api\GFtpAPI.h"

#include "StatDialog.h"
#include "StatDataStruct.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//
//	Note!
//
//		If this DLL is dynamically linked against the MFC
//		DLLs, any functions exported from this DLL which
//		call into MFC must have the AFX_MANAGE_STATE macro
//		added at the very beginning of the function.
//
//		For example:
//
//		extern "C" BOOL PASCAL EXPORT ExportedFunction()
//		{
//			AFX_MANAGE_STATE(AfxGetStaticModuleState());
//			// normal function body here
//		}
//
//		It is very important that this macro appear in each
//		function, prior to any calls into MFC.  This means that
//		it must appear as the first statement within the 
//		function, even before any object variable declarations
//		as their constructors may generate calls into the MFC
//		DLL.
//
//		Please see MFC Technical Notes 33 and 58 for additional
//		details.
//

/////////////////////////////////////////////////////////////////////////////
// CStatsApp

BEGIN_MESSAGE_MAP(CStatsApp, CWinApp)
	//{{AFX_MSG_MAP(CStatsApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStatsApp construction

CStatsApp::CStatsApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CStatsApp object

CStatsApp theApp;

char ResultStatic[2048]; // Static result area
long Seconds;
char *StatPath;
char *TempPath;


CStatDataStruct StatData;

CStatDialog *StatDlg;

BOOL CStatsApp::InitInstance() 
{
	Seconds = 0;
	gSetAppPath();

	StatPath = new char[lstrlen(gAppPath) + 32];
	lstrcpy(StatPath, gAppPath);
	lstrcat(StatPath, "stats.log");

	TempPath = new char[lstrlen(gAppPath) + 32];
	lstrcpy(TempPath, gAppPath);
	lstrcat(TempPath, "stats.tmp");
	
	StatDlg = new CStatDialog();
	return CWinApp::InitInstance();
}

void FlushStats(char *srcFile);

int CStatsApp::ExitInstance() 
{
	delete StatDlg;

	FlushStats(StatPath);

	if (StatPath)
		delete [] StatPath;
	if (TempPath)
		delete [] TempPath;
	
	return CWinApp::ExitInstance();
}


char FileReadBuffer[2049]; 
char *FileReadPtr;
unsigned long FileReadLength;

void InitStatLine()
{
	FileReadPtr = FileReadBuffer;
	FileReadLength = 0;
}

BOOL GetStatLine(HANDLE hFile)
{
	DWORD BytesRead;
	BOOL Result = TRUE;

	/* Fill up the buffer */
	if (FileReadLength < 2048)
	{
		ReadFile(hFile, &FileReadBuffer[FileReadLength], 2048 - FileReadLength, &BytesRead, NULL);
		FileReadLength += BytesRead;
		FileReadBuffer[FileReadLength] = 0;
	}

	/* Find the CR/LF */
	size_t position = strcspn( FileReadPtr, "\n" );

	if ((lstrlen(FileReadPtr) > 0) && (position < (FileReadLength - (FileReadPtr - FileReadBuffer) )))
	{
		lstrcpyn(ResultStatic, FileReadPtr, position + 1 + 1);
		FileReadPtr += (position + 1);
	}
	else
	{
		/* error */
		Result = FALSE;
	}

	if (FileReadPtr >= &FileReadBuffer[1024])
	{
		memmove(FileReadBuffer, &FileReadBuffer[1024], 1024);
		FileReadPtr -= 1024;
		FileReadLength -= 1024;
	}

	return Result;
}

char StatLineTok[512];

BOOL ParseStatLine(SYSTEMTIME *localTime, CStatDataStruct *statData, BOOL checkTime)
{
	localTime->wDayOfWeek = 0;
	localTime->wSecond = 0;
	localTime->wMilliseconds = 0;

	lstrcpy(StatLineTok, ResultStatic);

	char *Token = strtok(StatLineTok, "-");
	if (!Token)
		return FALSE;
	if (checkTime)
	{
		if ((WORD)atol(Token) != localTime->wMinute)
			return FALSE;
	}
	else
		localTime->wMinute = (WORD)atol(Token);

	Token = strtok(NULL, "-");
	if (!Token)
		return FALSE;
	if (checkTime)
	{
		if ((WORD)atol(Token) != localTime->wHour)
			return FALSE;
	}
	else
		localTime->wHour = (WORD)atol(Token);

	Token = strtok(NULL, "-");
	if (!Token)
		return FALSE;
	if (checkTime)
	{
		if ((WORD)atol(Token) != localTime->wDay)
			return FALSE;
	}
	else
		localTime->wDay = (WORD)atol(Token);

	Token = strtok(NULL, "-");
	if (!Token)
		return FALSE;
	if (checkTime)
	{
		if ((WORD)atol(Token) != localTime->wMonth)
			return FALSE;
	}
	else
		localTime->wMonth = (WORD)atol(Token);

	Token = strtok(NULL, ":");
	if (!Token)
		return FALSE;
	if (checkTime)
	{
		if ((WORD)atol(Token) != localTime->wYear)
			return FALSE;
	}
	else
		localTime->wYear= (WORD)atol(Token);

	Token = strtok(NULL, ":");
	if (!Token)
		return FALSE;
	if (checkTime && (statData->User.CompareNoCase("*") != 0))
	{
		if (statData->User.CompareNoCase(Token) != 0)
			return FALSE;
	}
	else
		statData->User = Token;

	if(statData->User.CompareNoCase("*") == 0)
		statData->User = "";

	Token = strtok(NULL, ":");
	if (!Token)
		return FALSE;
	if (checkTime && (statData->Group.CompareNoCase("*") != 0))
	{
		if (statData->Group.CompareNoCase(Token) != 0)
			return FALSE;
	}
	else
		statData->Group = Token;

	if(statData->Group.CompareNoCase("*") == 0)
		statData->Group = "";

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->ConnectionCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->LoginCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->ConnectionDuration += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->WrongPassCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->TooManyCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->BannedCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->UploadCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->DownloadCount += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->UploadKilobytes += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->DownloadKilobytes += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->UploadDuration += atol(Token);

	Token = strtok(NULL, ",");
	if (!Token)
		return FALSE;
	statData->DownloadDuration += atol(Token);

	return TRUE;
}

void WriteStatLine(HANDLE outFile, SYSTEMTIME *localTime, CStatDataStruct *statData)
{
	char Buffer[512];
	DWORD BytesWritten;

	if ((localTime->wMinute == 0) || (localTime->wDay == 0) || (localTime->wMonth == 0) || (localTime->wYear == 0))
		return;

	if ((statData->ConnectionCount == 0) &&
		(statData->LoginCount == 0) && 
		(statData->ConnectionDuration == 0) && 
		(statData->WrongPassCount == 0) &&
		(statData->TooManyCount == 0) && 
		(statData->BannedCount == 0) && 
		(statData->UploadCount == 0) && 
		(statData->DownloadCount == 0) && 
		(statData->UploadKilobytes == 0) &&
		(statData->DownloadKilobytes == 0) && 
		(statData->UploadDuration == 0) && 
		(statData->DownloadDuration == 0))
		return;

	wsprintf(Buffer, "%d-%d-%d-%d-%d:%s:%s:%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		localTime->wMinute, localTime->wHour, localTime->wDay, localTime->wMonth, localTime->wYear,
		(lstrlen(statData->User) == 0) ? "?" : (LPCSTR)statData->User,
		(lstrlen(statData->Group) == 0) ? "?" : (LPCSTR)statData->Group,
		statData->ConnectionCount, 
		statData->LoginCount, 
		statData->ConnectionDuration, 
		statData->WrongPassCount,
		statData->TooManyCount, 
		statData->BannedCount, 
		statData->UploadCount, 
		statData->DownloadCount, 
		statData->UploadKilobytes,
		statData->DownloadKilobytes, 
		statData->UploadDuration, 
		statData->DownloadDuration);

		WriteFile(outFile, Buffer, lstrlen(Buffer), &BytesWritten, NULL);
}

void CollapseStatFile(char *srcFile, char *dstFile)
{
	HANDLE StatFile = CreateFile(srcFile, GENERIC_READ, FILE_SHARE_READ, 
		NULL, OPEN_EXISTING, 0, NULL);
	HANDLE OutFile = CreateFile(dstFile, GENERIC_WRITE, FILE_SHARE_READ, 
		NULL, CREATE_ALWAYS, 0, NULL);

	if ((StatFile != INVALID_HANDLE_VALUE) && 
		(OutFile != INVALID_HANDLE_VALUE))
	{
		BOOL FirstPass = TRUE;
		CStatDataStruct statData;
		statData.Clear();
		InitStatLine();

		SYSTEMTIME LocalTime;
		while (GetStatLine(StatFile))
		{
			//MessageBox(NULL, ResultStatic, "DEBUG", MB_OK);
			if (!ParseStatLine(&LocalTime, &statData, !FirstPass))
			{
				WriteStatLine(OutFile, &LocalTime, &statData);
				statData.Clear();
				ParseStatLine(&LocalTime, &statData, FALSE);
			}
			
			FirstPass = FALSE;
		}

		WriteStatLine(OutFile, &LocalTime, &statData);
	}

	if (StatFile != INVALID_HANDLE_VALUE)
		CloseHandle(StatFile);
	if (OutFile != INVALID_HANDLE_VALUE)
		CloseHandle(OutFile);

	CopyFile(dstFile, srcFile, FALSE);
}

void FlushStats(char *srcFile)
{
	HANDLE StatFile = CreateFile(srcFile, GENERIC_READ | GENERIC_WRITE, 
		FILE_SHARE_READ, NULL, OPEN_ALWAYS, 0, NULL);

	if (StatFile != INVALID_HANDLE_VALUE)
	{
		SYSTEMTIME LocalTime;

		GetLocalTime(&LocalTime);

		SetFilePointer(StatFile, 0, 0, FILE_END);
		WriteStatLine(StatFile, &LocalTime, &StatData);

		CloseHandle(StatFile);

		StatData.Clear();
	}
}

void CheckPastDays(SYSTEMTIME *dataTime, CStatDataStruct *tmpData, 
				   CStatDataStruct *statData, long pastHours)
{
	CTime Now = CTime::GetCurrentTime();
	CTime Then(*dataTime);

	CTimeSpan Span = Now - Then;

	int Hours = Span.GetTotalHours();

	if ((pastHours < 0) || (pastHours > Hours))
	{
		*statData +=  *tmpData;
	}
}

void AddGroupUser(CStringArray *groupArray, CStringArray *userArray, CStatDataStruct *tmpData)
{
	if (groupArray && userArray)
	{
		bool Found = false;
		for (int Index = 0 ; Index < groupArray->GetSize() ; Index++)
			if (groupArray->GetAt(Index).CompareNoCase(tmpData->Group) == 0)
				Found = true;

		if (!Found && tmpData->Group.GetLength() && tmpData->Group.CompareNoCase("?"))
			groupArray->Add(tmpData->Group);

		Found = false;
		for (Index = 0 ; Index < userArray->GetSize() ; Index++)
			if (userArray->GetAt(Index).CompareNoCase(tmpData->User) == 0)
				Found = true;

		if (!Found && tmpData->User.GetLength() && tmpData->User.CompareNoCase("?"))
			userArray->Add(tmpData->User);
	}
}

void GetTotalStats(CStatDataStruct *statData, long pastHours, LPCSTR user, LPCSTR group, CStringArray *groupArray = 0, CStringArray *userArray = 0)
{
	statData->Clear();
	CStatDataStruct tmpData;

	HANDLE StatFile = CreateFile(StatPath, GENERIC_READ, FILE_SHARE_READ, 
		NULL, OPEN_EXISTING, 0, NULL);

	if (StatFile != INVALID_HANDLE_VALUE)
	{
		BOOL FirstPass = TRUE;
		InitStatLine();
		tmpData.Clear();

		SYSTEMTIME LocalTime = {0};
		while (GetStatLine(StatFile))
		{
			if (!ParseStatLine(&LocalTime, &tmpData, !FirstPass))
			{
				AddGroupUser(groupArray, userArray, &tmpData);

				if ((lstrlen(user) == 0) || (tmpData.User.CompareNoCase(user) == 0))
					if ((lstrlen(group) == 0) || (tmpData.Group.CompareNoCase(group) == 0))
						CheckPastDays(&LocalTime, &tmpData, statData, pastHours);
				tmpData.Clear();
				ParseStatLine(&LocalTime, &tmpData, FALSE);
			}
			
			FirstPass = FALSE;
		}

		if ((lstrlen(user) == 0) || (tmpData.User.CompareNoCase(user) == 0))
			if ((lstrlen(group) == 0) || (tmpData.Group.CompareNoCase(group) == 0))
				CheckPastDays(&LocalTime, &tmpData, statData, pastHours);
		AddGroupUser(groupArray, userArray, &tmpData);
	}

	if (StatFile != INVALID_HANDLE_VALUE)
		CloseHandle(StatFile);
}

typedef void (SiteCmdHandlerFunct)(RFTPEventStr *);

struct SiteCmdInfoStruct
{
	const char* Cmd;
	SiteCmdHandlerFunct* SiteCmdHandler;
	const char* HelpText;
	long NeedAdmin;
};

SiteCmdInfoStruct SiteCmdInfo[]; 

void OnHelp(RFTPEventStr* pEventStruc)
{
	char *Token = strtok(NULL, " ");
	char *TempCmd = new char[32];

	if (!Token || lstrcmpi(Token, "") == 0)
	{
		int cmd_index = 0;
		pEventStruc->Misc2 = 1;

		while (SiteCmdInfo[cmd_index].Cmd)
		{
			if ((cmd_index % 4) == 0)
				lstrcat(pEventStruc->pReplyText, "\r\n   ");

			lstrcpy(TempCmd, SiteCmdInfo[cmd_index].Cmd);
			lstrcat(TempCmd, "          ");
			TempCmd[10] = 0;

			lstrcat(pEventStruc->pReplyText, TempCmd);
			lstrcat(pEventStruc->pReplyText, "\t");
			cmd_index++;
		}
	}
	else
	{
		int cmd_index = 0;

		while (SiteCmdInfo[cmd_index].Cmd)
		{
			if (lstrcmpi(Token, SiteCmdInfo[cmd_index].Cmd) == 0)
			{
				if (SiteCmdInfo[cmd_index].HelpText)
				{
					lstrcpy(pEventStruc->pReplyText, "214 ");
					lstrcat(pEventStruc->pReplyText, SiteCmdInfo[cmd_index].HelpText);
				}
				break;
			}

			cmd_index++;
		}

		if (!SiteCmdInfo[cmd_index].Cmd && lstrlen(pEventStruc->pReplyText) == 0)
			pEventStruc->pReplyText = "214 'SITE' command not understood.";
	}

	delete [] TempCmd;
}

SiteCmdInfoStruct SiteCmdInfo[] = 
{
	{ "Test", &OnHelp, "Test desc", 0 },
	{ "Help", &OnHelp, NULL, 0 },
	{ NULL, NULL, NULL }
};
/********************************************************
*
* Stats to save:
*
* PER CONNECTION:
*
*	Duration of connection
*	Kilobytes uploaded per connection.
*	Kilobytes downloaded per connection.
*	Connection upload speed.
*	Account name.
*	Group name.
*
* PER FILE:
*
*	File sizes.
*	Transfer speed.
*	Upload or Download.
*
* MISC:
*
*	Banned: IP
*	WrongPass: IP
*	TooMany: IP
*	
********************************************************/

WORD CALLBACK HandleEventHook(RFTPEventStr* pEventStruc)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	BOOL Result = REVNT_None;
	char *Token;

#if (_MFC_VER > 0x0421)
	gftpdSetCallbackWnd(pEventStruc->hWindow);
#endif

	switch (pEventStruc->Event)
	{
		case EVNT_Connect:
			StatData.ConnectionCount++;
			break;
		case EVNT_Close:
			StatData.ConnectionDuration += (pEventStruc->Duration);
			break;
		case EVNT_BouncedIP:
			break;
		case EVNT_TooMany:
			StatData.TooManyCount++;
			break;
		case EVNT_WrongPass:
			StatData.WrongPassCount++;
			break;
		case EVNT_TimeOut:
			break;
		case EVNT_Login:
			StatData.LoginCount++;
			break;
		case EVNT_StartUp:
			break;
		case EVNT_EndUp:
			StatData.UploadCount++;
			StatData.UploadKilobytes += (pEventStruc->Size / 1000);
			StatData.UploadDuration += (pEventStruc->Duration / 1000);
			break;
		case EVNT_StartDown:
			break;
		case EVNT_EndDown:
			StatData.DownloadCount++;
			StatData.DownloadKilobytes += (pEventStruc->Size / 1000);
			StatData.DownloadDuration += (pEventStruc->Duration / 1000);
			break;
		case EVNT_AbortUp:
		case EVNT_AbortDown:
		case EVNT_Rename:
		case EVNT_DelFile:
		case EVNT_DelDir:
		case EVNT_ChgDir:
		case EVNT_MakeDir:
		case EVNT_HookDown:
		case EVNT_HookUp:
		case EVNT_HookAppend:
		case EVNT_HookUnique:
		case EVNT_HookRename:
		case EVNT_HookDelFile:
		case EVNT_HookDelDir:
		case EVNT_HookMkd:
			break;
		case EVNT_HookSite:
			{
			char TempCommand[256];
			strcpy(TempCommand, pEventStruc->AuxOne);
			Token = strtok(TempCommand, " ");
			if (pEventStruc->pReplyText) 		
				strcpy(ResultStatic, pEventStruc->pReplyText);
			else
				ResultStatic[0] = 0;
			pEventStruc->pReplyText = ResultStatic;

			int cmd_index = 0;

			while (SiteCmdInfo[cmd_index].Cmd)
			{
				if (lstrcmpi(Token, SiteCmdInfo[cmd_index].Cmd) == 0)
				{
					if (SiteCmdInfo[cmd_index].NeedAdmin && (pEventStruc->Misc1 == 0))
						pEventStruc->pReplyText = "214 'SITE' command requires administrator privileges.";
					else
						SiteCmdInfo[cmd_index].SiteCmdHandler(pEventStruc);

					Result = REVNT_Proceed_Result;
					break;
				}
				cmd_index++;
			}
			}

			break;
		case EVNT_HookChgDir:
			break;
		case EVNT_None:
		case EVNT_IPName:
		default:
			break;
	}

	StatData.User = pEventStruc->User;
	StatData.Group = pEventStruc->Group;
	FlushStats(StatPath);
	return Result;
}

WORD CALLBACK HandleGFTPDEventHook(RFTPEventStr* pEventStruc)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	BOOL Result = REVNT_None;

#if (_MFC_VER > 0x0421)
	gftpdSetCallbackWnd(pEventStruc->hWindow);
#endif

	switch (pEventStruc->Event)
	{
		case EVNT_gftpdNewPass:
			break;
		case EVNT_gftpdBannedIP:
			StatData.BannedCount++;
			break;
		case EVNT_gftpdUnbannedIP:
		case EVNT_gftpdUpdate:
		case EVNT_gftpdPortUpdate:
		case EVNT_gftpdPortChange:
		case EVNT_gftpdStartUpdate:
		case EVNT_gftpdConnUpdate:
		case EVNT_gftpdDDERecv:
		case EVNT_gftpdClose:
		case EVNT_gftpdLogin:
			break;
		case EVNT_gftpMenuItem:

			FlushStats(StatPath);
			CollapseStatFile(StatPath, TempPath);

			switch (pEventStruc->Duration)
			{
			case 1:
				break;
			case 0:
				{
					if (!::IsWindow(StatDlg->m_hWnd))
					{
						CWnd Parent;
						Parent.Attach(pEventStruc->hWindow);

						CStatDataStruct AllStats, PastWeek, Past24Hours, Past8Hours, Past4Hours, PastHour;

						StatDlg->m_StatCallback = GetTotalStats;
						StatDlg->m_FullStat = AllStats;
						StatDlg->m_PastWeekStat = PastWeek;
						StatDlg->m_Past24HoursStat = Past24Hours;
						StatDlg->m_Past8HoursStat = Past8Hours;
						StatDlg->m_Past4HoursStat = Past4Hours;
						StatDlg->m_PastHourStat = PastHour;
						StatDlg->Create((UINT)IDD_STAT_DIALOG, &Parent);
						StatDlg->ShowWindow(SW_SHOW);
						Parent.Detach();
					}
				}
			default:
				break;
			}
			break;
		case EVNT_gftpGetMenuItem:
			switch (pEventStruc->Duration)
			{
			case 1:
				strcpy(pEventStruc->AuxOne, "Stats\\Configure...");
				break;
			case 0:
				strcpy(pEventStruc->AuxOne, "Stats\\Display...");
				break;
			case -1:
				pEventStruc->Size = 1;
			default:
				pEventStruc->AuxOne[0] = 0;
				break;
			}
			break;
		case EVNT_gftp15Secs:
			/* Make sure we are always mod 15 */
			Seconds = ((Seconds / 15) + 1) * 15;

			/* Once a minute, commit to disk */
			//if ((Seconds % 60) == 0)
			//	FlushStats(StatPath);

			/* Once an hour, clean up the log file */
			if ((Seconds % (60 * 60)) == 0)
			{
				CollapseStatFile(StatPath, TempPath);
			}
		default:
			break;
	};

	return Result;
}


