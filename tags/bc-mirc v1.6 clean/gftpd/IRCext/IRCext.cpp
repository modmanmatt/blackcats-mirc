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


// IRCext.cpp : Defines the initialization routines for the DLL.
//

#include "stdafx.h"
#include "IRCext.h"
#include <process.h>

/* Must include the following files */
#include "..\api\PlugInTypes.h"
#include "..\api\GFtpAPI.h"
#include "RawSocket.h"
#include "ConfigureDlg.h"
#include "EventMsgDlg.h"
#include "KickRulesDlg.h"

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

CConfigureDlg *ConfigureDlg;
CKickRulesDlg *KickRulesDlg;
CEventMsgDlg *EventMsgDlg;

#define MyReadString(_handle_,_cstring_) { \
	GString tmpGString; \
	ReadString(_handle_, tmpGString); \
	_cstring_ = (LPCSTR)tmpGString; \
}

/////////////////////////////////////////////////////////////////////////////
// CIRCextApp

BEGIN_MESSAGE_MAP(CIRCextApp, CWinApp)
	//{{AFX_MSG_MAP(CIRCextApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CIRCextApp construction

CIRCextApp::CIRCextApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CIRCextApp object

CIRCextApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CIRCextApp initialization

UINT __stdcall IRCThread(LPVOID lpParameter);
//DWORD WINAPI IRCThread(LPVOID lpParameter);

CAdInfoArray Ads;
HANDLE AdsMutex;

CKickRuleArray Rules;
HANDLE RulesMutex;

CString LastAdmin;
bool FirstTime;

void LoadSettings();
BOOL CIRCextApp::InitInstance()
{
	if (!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
		return FALSE;
	}

	gSetAppPath();
	LoadSettings();

	m_DebugDlg.Create(IDD_DEBUGDLG_DIALOG);
//	m_DebugDlg.ShowWindow(SW_SHOW);

	ThreadDone = FALSE;
	TRACE("Starting IRC Thread\n");
	Mutex = CreateMutex(NULL, FALSE, NULL);
	AdsMutex = CreateMutex(NULL, FALSE, NULL);
	RulesMutex = CreateMutex(NULL, FALSE, NULL);

	m_IRCClient.Create(&ThreadDone, &Mutex, this);

#if(0)
	HANDLE tempThread = ::CreateThread(NULL, 0, IRCThread, (LPVOID)this, 0, &ThreadID);
#else
	HANDLE tempThread = (LPVOID)_beginthreadex( NULL, 0, IRCThread, (LPVOID)this, 0, (UINT*)&ThreadID);
#endif
	DuplicateHandle(GetCurrentProcess(), tempThread, 
		GetCurrentProcess(), &Thread, 0, FALSE, DUPLICATE_SAME_ACCESS);
/*	Thread = AfxBeginThread(IRCThread, (LPVOID)this, 0, 0, CREATE_SUSPENDED, NULL);
	TRACE("Thread Begin Done\n");*/
	if (Thread)
	{
		TRACE("Thread Started %ld\n", Thread);
//		Thread->m_bAutoDelete = FALSE;
//		Thread->ResumeThread();
	}

	CloseHandle(tempThread);

	ConfigureDlg = new CConfigureDlg();
	KickRulesDlg = new CKickRulesDlg();
	EventMsgDlg = new CEventMsgDlg();

	FirstTime = true;

	TRACE("IRC Init Done\n");

	return TRUE;
}

int CIRCextApp::ExitInstance() 
{
	delete ConfigureDlg;
	delete KickRulesDlg;
	delete EventMsgDlg;

	WaitForSingleObject(Mutex, INFINITE);
	ThreadDone = TRUE;
	ReleaseMutex(Mutex);

//	GetExitCodeThread(Thread->m_hThread, &ExitCode);
//	WaitForSingleObject(Thread, INFINITE);
	::CloseHandle(Thread);
	/*
	GetExitCodeThread(Thread, &ExitCode);
	while (ExitCode == STILL_ACTIVE)
	{
		Sleep(250);
//		GetExitCodeThread(Thread->m_hThread, &ExitCode);
		GetExitCodeThread(Thread, &ExitCode);
	}
	*/
	CloseHandle(Mutex);
	CloseHandle(AdsMutex);
	CloseHandle(RulesMutex);

	m_DebugDlg.DestroyWindow();

	return CWinApp::ExitInstance();
}

CStringArray Vars, VarValue;

struct CEventMsgs
{
	CString MakeDir;
	CString MakeDirChannels;

	CString Upload;
	CString UploadChannels;

	CString Download;
	CString DownloadChannels;

	CString Login;
	CString LoginChannels;

	CString Logout;
	CString LogoutChannels;
} EventMsgs;

void AddVar(CString var, CString strVal);
void AddVar(CString var, int val)
{
	CString strVal;
	strVal.Format("%d", val);
	AddVar(var, strVal);
}

void AddVar(CString var, CString strVal)
{
	BOOL Found = FALSE;
	for (int Index = 0 ; (Index < Vars.GetSize()) && !Found ; Index++)
	{
		if (Vars.GetAt(Index) == var)
		{
			Found = TRUE;
			VarValue.SetAt(Index, strVal);
		}
	}
	if (!Found)
	{
		Vars.Add(var);
		VarValue.Add(strVal);
	}
}

CString EvaluateString(CString mask)
{
	for (int Index = 0 ; Index < Vars.GetSize() ; Index++)
		mask.Replace(Vars.GetAt(Index), VarValue.GetAt(Index));

	mask.Replace("%%", "__internal_percent__");

	mask += " ";
	int ind = mask.Find("%");
	while (ind >= 0)
	{
		CString field = mask.Mid(ind);
		field = field.SpanExcluding(" \r\n");
		mask.Replace(field + " ", "0 ");
		mask.Replace(field + "\r\n", "0\r\n");
		mask.Replace(field + "\n", "0\n");
		mask.Replace(field + "\r", "0\r");
		ind = mask.Find("%");
	}

	mask.Replace("__internal_percent__", "%");
	mask.TrimRight();
	return mask;
}

#define AddIrcCommand(__cmd) ((CIRCextApp*)AfxGetApp())->m_IRCClient.AddCommand(__cmd)
#define ShowLog ((CIRCextApp*)AfxGetApp())->m_DebugDlg.ShowWindow(SW_SHOW)
#define HideLog ((CIRCextApp*)AfxGetApp())->m_DebugDlg.ShowWindow(SW_HIDE)
#define LogVisible (((CIRCextApp*)AfxGetApp())->m_DebugDlg.IsWindowVisible())

WORD CALLBACK HandleEventHook(RFTPEventStr* pEventStruc)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
//	char Msg[1024];
	CString TempStr;
	int TempInt;

	gftpdSetCallbackWnd(pEventStruc->hWindow);

	AddVar("$ip", pEventStruc->LocalIP);
	AddVar("%GFTPloginip", pEventStruc->ClientIP);
	AddVar("%GFTPloginname", pEventStruc->User);
	AddVar("%GFTPlogingroup", pEventStruc->Group);
	TempStr = ((CIRCextApp*)AfxGetApp())->m_IRCClient.IALGetUserNick(pEventStruc->ClientIP);
	AddVar("%GFTPloginnick", TempStr);

	switch (pEventStruc->Event)
	{
	case EVNT_Connect:
/*		sprintf(Msg, "/oftpConnection %s <<REVDNS %s>>", 
			pEventStruc->ClientIP, pEventStruc->ClientIP);
		gftpdDoDDEPoke(Msg);*/
		TempStr = ((CIRCextApp*)AfxGetApp())->m_IRCClient.IALGetUserNick(pEventStruc->ClientIP);
		gftpdSetNick(pEventStruc->ClientIP, TempStr);
		break;
	case EVNT_MakeDir:
		TempStr = pEventStruc->AuxOne;
		TempInt = TempStr.ReverseFind('\\');
		if (TempInt >= 0)
		{
			TempStr = TempStr.Mid(TempInt);
			TempStr.TrimLeft("\\");
		}
		AddVar("%GFTPfilename", (LPCSTR)TempStr);
		AddVar("%GFTPpathname", pEventStruc->AuxOne);
		AddVar("%GFTPvpathname", pEventStruc->AuxTwo);
		AddVar("%GFTPfileduration", pEventStruc->Duration / 1000);
		AddVar("%GFTPfilesize", pEventStruc->Size);

		((CIRCextApp*)AfxGetApp())->m_IRCClient.SendMsgToChannels(EvaluateString(EventMsgs.MakeDir), EventMsgs.MakeDirChannels);
		break;
	case EVNT_EndUp:
		TempStr = pEventStruc->AuxOne;
		TempInt = TempStr.ReverseFind('\\');
		if (TempInt >= 0)
		{
			TempStr = TempStr.Mid(TempInt);
			TempStr.TrimLeft("\\");
		}
		AddVar("%GFTPfilename", (LPCSTR)TempStr);
		AddVar("%GFTPpathname", pEventStruc->AuxOne);
		AddVar("%GFTPvpathname", pEventStruc->AuxTwo);
		AddVar("%GFTPfileduration", pEventStruc->Duration / 1000);
		AddVar("%GFTPfilesize", pEventStruc->Size);

		((CIRCextApp*)AfxGetApp())->m_IRCClient.SendMsgToChannels(EvaluateString(EventMsgs.Upload), EventMsgs.UploadChannels);
		break;
	case EVNT_EndDown:
		TempStr = pEventStruc->AuxOne;
		TempInt = TempStr.ReverseFind('\\');
		if (TempInt >= 0)
		{
			TempStr = TempStr.Mid(TempInt);
			TempStr.TrimLeft("\\");
		}
		AddVar("%GFTPfilename", (LPCSTR)TempStr);
		AddVar("%GFTPpathname", pEventStruc->AuxOne);
		AddVar("%GFTPvpathname", pEventStruc->AuxTwo);
		AddVar("%GFTPfileduration", pEventStruc->Duration / 1000);
		AddVar("%GFTPfilesize", pEventStruc->Size);

		((CIRCextApp*)AfxGetApp())->m_IRCClient.SendMsgToChannels(EvaluateString(EventMsgs.Download), EventMsgs.DownloadChannels);
		break;
	}
	return REVNT_None;
}

UINT Timer15;
CString GetAdminNick()
{
	CString AdminNick = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetDuplicateLocalNick();
	if (AdminNick.GetLength() == 0)
	{
		AdminNick = LastAdmin;
	}
	else
		LastAdmin = AdminNick;
	
	if (AdminNick.GetLength() != 0)
	{
		// Did our PRIVMSG go through?
		if (AdminNick.CompareNoCase(((CIRCextApp*)AfxGetApp())->m_IRCClient.GetLastBadNick()) == 0)
		{
			AdminNick = "";
			LastAdmin = "";
		}
	}

	return "" /*AdminNick*/;
}

void CheckChannels()
{
	CString AdminNick = GetAdminNick();

	for (int Index = 0 ; Index < Ads.GetSize() ; Index++)
	{
		CAdInfo Ad = Ads.GetAt(Index);
		CString Channel = Ad.Channels;
		// Join the channel

		if ((AdminNick.GetLength() == 0) && // Don't join if the admin is on.
			(Ad.Enable))					// Don't join if not enabled					
		{
			((CIRCextApp*)AfxGetApp())->m_IRCClient.Join(Channel);
			BOOL Found  = FALSE;
			for (int CurIndex = 0 ; CurIndex < ((CIRCextApp*)AfxGetApp())->m_CurrentChannels.GetSize() ; CurIndex++)
			{
				CString CurChannel = ((CIRCextApp*)AfxGetApp())->m_CurrentChannels.GetAt(CurIndex);
				if (CurChannel == Channel)
					Found = TRUE;
			}
			if (!Found)
			{
				((CIRCextApp*)AfxGetApp())->m_CurrentChannels.Add(Channel);
				TRACE("Joining %s\n", Channel);
			}
		}
	}
	for (int CurIndex = 0 ; CurIndex < ((CIRCextApp*)AfxGetApp())->m_CurrentChannels.GetSize() ; CurIndex++)
	{
		CString CurChannel = ((CIRCextApp*)AfxGetApp())->m_CurrentChannels.GetAt(CurIndex);
		BOOL Found  = FALSE;
		for (int Index = 0 ; Index < Ads.GetSize() ; Index++)
		{
			CAdInfo Ad = Ads.GetAt(Index);
			CString Channel = Ad.Channels;
			if ((CurChannel == Channel) && (Ad.Enable))
				Found = TRUE;
		}
		if ((!Found) ||						// Leave if no ad for this channel
			(AdminNick.GetLength() != 0))	// Leave if admin is on.
		{
			// Leave the channel
			((CIRCextApp*)AfxGetApp())->m_IRCClient.Part(CurChannel);
			((CIRCextApp*)AfxGetApp())->m_CurrentChannels.RemoveAt(CurIndex--);
			TRACE("Leaving %s\n", CurChannel);
		}
	}
}

void UpdateTriggers()
{
	WaitForSingleObject(AdsMutex, INFINITE);

	((CIRCextApp*)AfxGetApp())->m_IRCClient.LockTriggerData();
	((CIRCextApp*)AfxGetApp())->m_IRCClient.ClearTriggerData();
	for (int Index = 0 ; Index < Ads.GetSize() ; Index++)
	{
		CAdInfo Ad = Ads.GetAt(Index);
		((CIRCextApp*)AfxGetApp())->m_IRCClient.AddTriggerPair(
			Ad.Channels, Ad.TriggerText, EvaluateString(Ad.TriggerAd));
	}
	((CIRCextApp*)AfxGetApp())->m_IRCClient.ReleaseTriggerData();
	ReleaseMutex(AdsMutex);
}

void SaveSettings();
void LoadSettings()
{
	CString User, Nick;
	UINT Count;
	CAdInfo Ad;
	CKickRule Rule;
//	MessageBox(0,"WARNING:  using the built in IRC client may violate some channel rules. Make sure you know the rules of your channels before using.","Warning:", MB_OK);

	HANDLE File = OpenOptionFileRead("ircext.opt");
	if (File == INVALID_HANDLE_VALUE)
	{
//		AfxMessageBox("WARNING:  using the built in IRC client may violate some channel rules.  "\
//			"Make sure you know the rules of your channels before using.", MB_OK, 0);
		SaveSettings();

		((CIRCextApp*)AfxGetApp())->m_IRCClient.SetUserNick("you", "you");
		((CIRCextApp*)AfxGetApp())->m_IRCClient.SetServerList("efnet-servers.opt");
		return;
	}

	// Load User and Nick
	MyReadString(File, User);
	MyReadString(File, Nick);
	((CIRCextApp*)AfxGetApp())->m_IRCClient.SetUserNick(User, Nick);
	
	WaitForSingleObject(AdsMutex, INFINITE);
	Ads.RemoveAll();

	UINT Version = 1;
	// Read Count
	ReadInt(File, Count);

	if (Count == 0xFFFFFFFF)
	{
		ReadInt(File, Version);
		ReadInt(File, Count);
	}

	for (UINT Index = 0 ; Index < Count ; Index++)
	{
		// Load Ad.Channels
		MyReadString(File, Ad.Channels);
		// Load Ad.Timer
		ReadInt(File, Ad.Timer);
		// Load Ad.Ad
		MyReadString(File, Ad.Ad);
		// Load Ad.Enable
		ReadInt(File, Ad.Enable);
		if (Version > 1)
		{
		// Load Ad.TriggerText
		MyReadString(File, Ad.TriggerText);
		// Load Ad.TriggerAd
		MyReadString(File, Ad.TriggerAd);
		}
		else
		{
			Ad.TriggerAd = "";
			Ad.TriggerAd = "";
		}
		Ads.Add(Ad);
	}
	ReleaseMutex(AdsMutex);

	UpdateTriggers();

	WaitForSingleObject(RulesMutex, INFINITE);
	Rules.RemoveAll();

	// Read Count
	ReadInt(File, Count);
	for (Index = 0 ; Index < Count ; Index++)
	{
		// Load Rule.m_Account
		MyReadString(File, Rule.m_Account);
		// Load Rule.m_Channel
		MyReadString(File, Rule.m_Channel);
		Rules.Add(Rule);
	}
	ReleaseMutex(RulesMutex);

	if (Version >= 3)
	{
		MyReadString(File, EventMsgs.Upload);
		MyReadString(File, EventMsgs.UploadChannels);

		MyReadString(File, EventMsgs.Download);
		MyReadString(File, EventMsgs.DownloadChannels);

		MyReadString(File, EventMsgs.Login);
		MyReadString(File, EventMsgs.LoginChannels);

		MyReadString(File, EventMsgs.Logout);
		MyReadString(File, EventMsgs.LogoutChannels);
	}

	if (Version >= 4)
	{
		MyReadString(File, EventMsgs.MakeDir);
		MyReadString(File, EventMsgs.MakeDirChannels);
	}

	CString ServerList = "servers.opt";
	if (Version >= 5)
	{
		UINT Enabled;
		ReadInt(File, Enabled);
		((CIRCextApp*)AfxGetApp())->m_IRCClient.SetEnabled(Enabled);
		MyReadString(File, ServerList);
	}

	((CIRCextApp*)AfxGetApp())->m_IRCClient.SetServerList(ServerList);

	CloseHandle(File);
}

#define VERSION 5

void SaveSettings()
{
	HANDLE File = OpenOptionFileWrite("ircext.opt");
	if (File == INVALID_HANDLE_VALUE)
		return;

	CString User = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetUser();
	CString Nick = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetNick();

	// Save User and Nick
	WriteString(File, User);
	WriteString(File, Nick);

	WaitForSingleObject(AdsMutex, INFINITE);

	// Write Ads.GetSize()
	WriteInt(File, (UINT)0xFFFFFFFF);
	WriteInt(File, (UINT)VERSION);
	WriteInt(File, (UINT)Ads.GetSize());
	for (int Index = 0 ; Index < Ads.GetSize() ; Index++)
	{
		CAdInfo Ad = Ads.GetAt(Index);
		// Save Ad.Channels
		WriteString(File, Ad.Channels);
		// Save Ad.Timer
		WriteInt(File, Ad.Timer);
		// Save Ad.Ad
		WriteString(File, Ad.Ad);
		// Save Ad.Enable
		WriteInt(File, Ad.Enable);
		// Save Ad.TriggerText
		WriteString(File, Ad.TriggerText);
		// Save Ad.TriggerAd
		WriteString(File, Ad.TriggerAd);
	}
	ReleaseMutex(AdsMutex);

	WaitForSingleObject(RulesMutex, INFINITE);

	// Write Rules->GetSize()
	WriteInt(File, (UINT)Rules.GetSize());
	for (Index = 0 ; Index < Rules.GetSize() ; Index++)
	{
		CKickRule Rule = Rules.GetAt(Index);
		// Save Rule.m_Account
		WriteString(File, Rule.m_Account);
		// Save Rule.m_Channel
		WriteString(File, Rule.m_Channel);
	}
	ReleaseMutex(RulesMutex);

	WriteString(File, EventMsgs.Upload);
	WriteString(File, EventMsgs.UploadChannels);

	WriteString(File, EventMsgs.Download);
	WriteString(File, EventMsgs.DownloadChannels);

	WriteString(File, EventMsgs.Login);
	WriteString(File, EventMsgs.LoginChannels);

	WriteString(File, EventMsgs.Logout);
	WriteString(File, EventMsgs.LogoutChannels);

	WriteString(File, EventMsgs.MakeDir);
	WriteString(File, EventMsgs.MakeDirChannels);

	UINT Enabled = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetEnabled();
	WriteInt(File, Enabled);

	WriteString(File, ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetServerList());
	CloseHandle(File);
}

void OnConfigureUpdate()
{
	((CIRCextApp*)AfxGetApp())->m_IRCClient.SetUserNick(ConfigureDlg->m_User, ConfigureDlg->m_Nick);
	((CIRCextApp*)AfxGetApp())->m_IRCClient.SetEnabled(ConfigureDlg->m_GlobalEnable);
	((CIRCextApp*)AfxGetApp())->m_IRCClient.SetServerList(ConfigureDlg->m_ServerList);
	UpdateTriggers();
	SaveSettings(); 
}

void OnKickUpdate()
{
	SaveSettings(); 
}

void OnEventUpdate()
{
	EventMsgs.LoginChannels = EventMsgDlg->m_LoginChannels;
	EventMsgs.LogoutChannels = EventMsgDlg->m_LogoutChannels;
	EventMsgs.DownloadChannels = EventMsgDlg->m_DownloadChannels;
	EventMsgs.UploadChannels = EventMsgDlg->m_UploadChannels;
	EventMsgs.MakeDirChannels = EventMsgDlg->m_MakeDirChannels;
	EventMsgs.Login = EventMsgDlg->m_LoginMsg;
	EventMsgs.Logout = EventMsgDlg->m_LogoutMsg;
	EventMsgs.Download = EventMsgDlg->m_DownloadMsg;
	EventMsgs.Upload = EventMsgDlg->m_UploadMsg;
	EventMsgs.MakeDir = EventMsgDlg->m_MakeDirMsg;
	
	SaveSettings(); 
}

WORD CALLBACK HandleGFTPDEventHook(RFTPEventStr* pEventStruc)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
//	DWORD MaxConn, MaxIPConn;
//	char Msg[1024];
	CString TempStr;

	gftpdSetCallbackWnd(pEventStruc->hWindow);

	AddVar("$ip", pEventStruc->LocalIP);
	AddVar("%GFTPloginip", pEventStruc->ClientIP);
	AddVar("%GFTPloginname", pEventStruc->User);
	AddVar("%GFTPlogingroup", pEventStruc->Group);
	TempStr = ((CIRCextApp*)AfxGetApp())->m_IRCClient.IALGetUserNick(pEventStruc->ClientIP);
	AddVar("%GFTPloginnick", TempStr);

	switch (pEventStruc->Event)
	{
	case EVNT_gftpdStartUpdate:
		// pEventStruc->Duration, pEventStruc->AuxOne, pEventStruc->AuxTwo
		// Port, Status, Version
		TRACE("Start Event\n");
		AddVar("%GFTPmainport", pEventStruc->Duration);

		Timer15 = 0;
		
		CheckChannels();
		UpdateTriggers();
		break;
	case EVNT_gftpdUpdate:
		// pEventStruc->Duration, pEventStruc->Size, pEventStruc->AuxOne,
		// Port, NoConn, Status
		AddVar("%GFTPmainport", pEventStruc->Duration);
		gftpdDoPortUpdate();
		UpdateTriggers();
		break;
	case EVNT_gftpdUserUpdate:
		AddVar("%GFTPpass" + CString(pEventStruc->User), pEventStruc->AuxOne);
		break;
	case EVNT_gftpdNewPass:
		// pEventStruc->User, pEventStruc->AuxOne, pEventStruc->AuxTwo
		// OldName, NewName, Pass
		AddVar("%GFTPpass" + CString(pEventStruc->AuxOne), 
			pEventStruc->AuxTwo);
		UpdateTriggers();
		break;
	case EVNT_gftpdPortUpdate:
	case EVNT_gftpdPortChange:
		// pEventStruc->AuxOne, pEventStruc->Duration
		// Name, Port
		AddVar("%GFTPport" + CString(pEventStruc->AuxOne), pEventStruc->Duration);
		UpdateTriggers();
		break;
	case EVNT_gftpdConnUpdate:
		// pEventStruc->SessionID, pEventStruc->User, 
		// pEventStruc->AuxOne, pEventStruc->AuxTwo
		// ID, User, IP, State
		break;
	case EVNT_gftpdClose:
		// pEventStruc->User, pEventStruc->ClientIP, pEventStruc->Duration, 
		// pEventStruc->AuxOne, pEventStruc->Size, pEventStruc->AuxTwo
		// User, IP, Conn,
		// MaxConn, IPConn, MaxIPConn
		AddVar("%GFTPconns" + CString(pEventStruc->User), 
			pEventStruc->Duration);
		AddVar("%GFTPmaxconns" + CString(pEventStruc->User), 
			pEventStruc->AuxOne);
		UpdateTriggers();

		((CIRCextApp*)AfxGetApp())->m_IRCClient.SendMsgToChannels(EvaluateString(EventMsgs.Logout), EventMsgs.LogoutChannels);
		break;
	case EVNT_gftpdLogin:
		// pEventStruc->User, pEventStruc->ClientIP, pEventStruc->Duration, 
		// pEventStruc->AuxOne, pEventStruc->Size, pEventStruc->AuxTwo
		// User, IP, Conn,
		// MaxConn, IPConn, MaxIPConn
		AddVar("%GFTPconns" + CString(pEventStruc->User), 
			pEventStruc->Duration);
		AddVar("%GFTPmaxconns" + CString(pEventStruc->User), 
			pEventStruc->AuxOne);

		{
			BOOL Kick = TRUE;
			BOOL HaveRule = FALSE;
			for (int Index = 0 ; Index < Rules.GetSize() ; Index++)
			{
				CKickRule Rule = Rules.GetAt(Index);
				if (Rule.m_Account.CompareNoCase(pEventStruc->User) == 0)
				{
					// Found a rule.
					HaveRule = TRUE;
					if (((CIRCextApp*)AfxGetApp())->m_IRCClient.IsIPinChannel(
						pEventStruc->ClientIP, Rule.m_Channel))
					{
						Kick = FALSE;
					}
				}
			}

			if (HaveRule && Kick)
			{
				// Kick user (use ID to make sure we get the exact login).
				CString IDString;
				IDString.Format("%d", pEventStruc->SessionID);
				gftpdKickUser(IDString);
			}
		}
		UpdateTriggers();

		((CIRCextApp*)AfxGetApp())->m_IRCClient.SendMsgToChannels(EvaluateString(EventMsgs.Login), EventMsgs.LoginChannels);
		break;
	case EVNT_gftp15Secs:
		{
			if (FirstTime)
			{
				gftpdUpdate();
				gftpdDoPortUpdate();
				FirstTime = false;
			}
			WaitForSingleObject(AdsMutex, INFINITE);
			CheckChannels();
			for (int Index = 0 ; Index < Ads.GetSize() ; Index++)
			{
				CAdInfo Ad = Ads.GetAt(Index);
				if (Ad.Timer && Ad.Enable)
				{
					if (Ad.Timer < 15)
						Ad.Timer = 15;

					if ((Timer15 % (Ad.Timer / 15)) == 0)
					{
						CString AdminNick = GetAdminNick();
						
						if (AdminNick.GetLength() == 0) // Admin is not on
						{
							((CIRCextApp*)AfxGetApp())->m_IRCClient.SendMsgToChannels(
								EvaluateString(Ad.Ad), Ad.Channels);
						}
						else // Admin is on
						{
							AddIrcCommand("PRIVMSG " + AdminNick + " :" + 
								CString("REPOST:") +  Ad.Channels + ":" + 
								EvaluateString(Ad.Ad) + "\r\n");
						}
					}
				}
			}
			ReleaseMutex(AdsMutex);
			Timer15++;
		}
		UpdateTriggers();
		break;
	case EVNT_gftpMenuItem:
		{
		CWnd Parent;
		Parent.Attach(pEventStruc->hWindow);

		switch (pEventStruc->Duration)
		{
		case 0:
			{
				if (!::IsWindow(ConfigureDlg->m_hWnd)) 
				{
					ConfigureDlg->SetAdPtr(&Ads, AdsMutex);
					ConfigureDlg->m_User = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetUser();
					ConfigureDlg->m_Nick = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetNick();
					ConfigureDlg->m_GlobalEnable = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetEnabled();
					ConfigureDlg->m_ServerList = ((CIRCextApp*)AfxGetApp())->m_IRCClient.GetServerList();
					ConfigureDlg->m_OnOkCallback = OnConfigureUpdate;
					ConfigureDlg->Create(IDD_CONFIGUREDLG_DIALOG, &Parent);
					ConfigureDlg->ShowWindow(SW_SHOW);
				}
			}
			break;
		case 1:
			{
				if (!::IsWindow(KickRulesDlg->m_hWnd)) 
				{
					KickRulesDlg->SetRulesPtr(&Rules, RulesMutex);
					KickRulesDlg->m_OnOkCallback = OnKickUpdate;
					KickRulesDlg->Create(IDD_KICKRULES, &Parent);
					KickRulesDlg->ShowWindow(SW_SHOW);
				}
			}
			break;
		case 2:
			{
//				CPasswordHopDlg Dlg;
//				Dlg.SetRulesPtr(&Rules, RulesMutex);
//				Dlg.DoModal();
				if (!::IsWindow(EventMsgDlg->m_hWnd)) 
				{
					EventMsgDlg->m_LoginChannels = EventMsgs.LoginChannels;
					EventMsgDlg->m_LogoutChannels = EventMsgs.LogoutChannels;
					EventMsgDlg->m_DownloadChannels = EventMsgs.DownloadChannels;
					EventMsgDlg->m_UploadChannels = EventMsgs.UploadChannels;
					EventMsgDlg->m_MakeDirChannels = EventMsgs.MakeDirChannels;
					EventMsgDlg->m_LoginMsg = EventMsgs.Login;
					EventMsgDlg->m_LogoutMsg = EventMsgs.Logout;
					EventMsgDlg->m_DownloadMsg = EventMsgs.Download;
					EventMsgDlg->m_UploadMsg = EventMsgs.Upload;
					EventMsgDlg->m_MakeDirMsg = EventMsgs.MakeDir;
					EventMsgDlg->m_OnOkCallback = OnEventUpdate;
					EventMsgDlg->Create(IDD_EVENT_MSG, &Parent);
					EventMsgDlg->ShowWindow(SW_SHOW);
				}
			}
			break;
		case 3:
			if (!LogVisible)
				ShowLog;
			else
				HideLog;
			break;
		default:
			break;
		}

		Parent.Detach();
		}
		break;
	case EVNT_gftpGetMenuItem:
		// pEventStruc->Duration, 
		// pEventStruc->AuxOne, pEventStruc->Size
		// Incoming index (-1 = count)
		// MenuItem, MenuCount returned
		switch (pEventStruc->Duration)
		{
		case 0:
			strcpy(pEventStruc->AuxOne, "IRC\\Configure...");
			break;
		case 1:
			strcpy(pEventStruc->AuxOne, "IRC\\Kick...");
			break;
		case 2:
//			strcpy(pEventStruc->AuxOne, "IRC\\Password Hopping...");
			strcpy(pEventStruc->AuxOne, "IRC\\Event Text...");
			break;
		case 3:
			strcpy(pEventStruc->AuxOne, "IRC\\Log...");
			break;
		case -1:
			pEventStruc->Size = 4;
			break;
		default:
			pEventStruc->AuxOne[0] = 0;
			break;
		}
		break;
/*	
	case EVNT_gftpdBannedIP:
		sprintf(Msg, "/oftpBannedIP %s <<REVDNS %s>> %d %s", 
			pEventStruc->AuxOne, pEventStruc->AuxOne, pEventStruc->Duration, 
			pEventStruc->AuxTwo);
		gftpdDoDDEPoke(Msg);
		break;
	case EVNT_gftpdUnbannedIP:
		sprintf(Msg, "/oftpUnbannedIP %s <<REVDNS %s>> %s", 
			pEventStruc->AuxOne, pEventStruc->AuxOne, pEventStruc->AuxTwo);
		gftpdDoDDEPoke(Msg);
		break;
	case EVNT_gftpdDDERecv:
		DDERecv(pEventStruc->AuxOne);
		break;*/
	default:
		break;
	};
	return REVNT_None;
}

//DWORD WINAPI IRCThread(LPVOID lpParameter)
UINT __stdcall IRCThread(LPVOID lpParameter)
{
	CIRCextApp* App = (CIRCextApp*)lpParameter;

	CIRCClient &IRCClient = App->m_IRCClient;
	IRCClient.Begin();

	return 0;
}
 


