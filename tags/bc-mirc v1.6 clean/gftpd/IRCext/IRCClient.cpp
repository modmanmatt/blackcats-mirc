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


// IRCClient.cpp: implementation of the CIRCClient class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "IRCext.h"
#include "IRCClient.h"
#include "IRCdefines.h"
#include "../api/gftpapi.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

#define SocketSendString(__Data) { m_Socket.SendStringWait(__Data, FALSE); m_App->m_DebugDlg.AddString("SENT: " + __Data);}

#define MyReadStringText(_handle_,_cstring_,_result_) { \
	GString tmpGString; \
	_result_ = ReadStringText(_handle_, tmpGString); \
	_cstring_ = (LPCSTR)tmpGString; \
}

CIRCClient::CIRCClient()
{
	m_ThreadDone = NULL;
	m_App = NULL;
	m_DoneMutex = NULL;
	m_TriggerMutex = CreateMutex(NULL, FALSE, NULL);
	m_ChannelMutex = CreateMutex(NULL, FALSE, NULL);
	m_Mutex = CreateMutex(NULL, FALSE, NULL);
	m_IALMutex = CreateMutex(NULL, FALSE, NULL);
	m_CommandMutex = CreateMutex(NULL, FALSE, NULL);
	m_ChannelModified = FALSE;
	WaitForSingleObject(m_Mutex, INFINITE);
	m_NewNick = FALSE;
	ReleaseMutex(m_Mutex);
	SetEnabled(FALSE);
	m_Reload = FALSE;
}

CIRCClient::~CIRCClient()
{
	CloseHandle(m_ChannelMutex);
	CloseHandle(m_Mutex);
	CloseHandle(m_IALMutex);
	CloseHandle(m_TriggerMutex);
	CloseHandle(m_CommandMutex);
}

BOOL CIRCClient::GetEnabled()
{
	WaitForSingleObject(m_Mutex, INFINITE);
	BOOL result = m_Enabled;
	ReleaseMutex(m_Mutex);
	return result;
}

void CIRCClient::SetEnabled(BOOL enabled)
{
	WaitForSingleObject(m_Mutex, INFINITE);
	m_Enabled = enabled;
	ReleaseMutex(m_Mutex);
}

CString CIRCClient::GetServerList()
{
	WaitForSingleObject(m_Mutex, INFINITE);
	CString result = m_ServerList;
	ReleaseMutex(m_Mutex);
	return result;
}

void CIRCClient::SetServerList(CString list)
{
	WaitForSingleObject(m_Mutex, INFINITE);
	if (m_ServerList != list)
	{
		m_ServerList = list;
		m_Reload = TRUE;
	}
	ReleaseMutex(m_Mutex);
}


void CIRCClient::SetUserNick(CString user, CString nick)
{
	WaitForSingleObject(m_Mutex, INFINITE);
	m_User = user;
	m_Nick = nick;
	m_NewNick = TRUE;
	ReleaseMutex(m_Mutex);
}

CString CIRCClient::GetUser()
{
	WaitForSingleObject(m_Mutex, INFINITE);
	CString val = m_User;
	ReleaseMutex(m_Mutex);
	return val;
}

CString CIRCClient::GetNick()
{
	WaitForSingleObject(m_Mutex, INFINITE);
	CString val = m_Nick;
	ReleaseMutex(m_Mutex);
	return val;
}

void CIRCClient::Create(BOOL *donePtr, HANDLE doneMutex, CIRCextApp *app)
{
	m_ThreadDone = donePtr;
	m_App = app;
	m_DoneMutex = doneMutex;
}

void CIRCClient::Begin()
{
	ASSERT(m_App);
	m_ServerIndex = -1;
	InitServerList();
	Init();
	StateMachine();
}

void CIRCClient::Init()
{
	/* Setup Ident Server */
	CString DbgMsg;
	m_IdentListenSocket.Create(113);
	DbgMsg.Format("Ident Created: %d\n", m_IdentListenSocket.GetLastError());
	TRACE(DbgMsg);
	m_App->m_DebugDlg.AddString(DbgMsg);
	DbgMsg.Format("Ident Listen: %d\n", m_IdentListenSocket.GetLastError());
	m_IdentListenSocket.Listen();
	TRACE(DbgMsg);
	m_App->m_DebugDlg.AddString(DbgMsg);

	m_IRCState = STATE_INVALID;
	m_IdentState = STATE_IDLE;
}

void CIRCClient::InitServerList()
{
	m_Servers.RemoveAll();
	HANDLE File = OpenOptionFileRead(GetServerList());
	if (File == INVALID_HANDLE_VALUE)
		return;

	CString Value;
	BOOL Result;

	MyReadStringText(File, Value, Result); 
	while (Result)
	{
		CString Server = Value.SpanExcluding(":");
		Value = Value.Mid(Server.GetLength());
		Value.TrimLeft(":");

		if (Server.GetLength())
		{
			long Port = atol(Value);
			if (Port == 0)
			{
				m_Servers.Add(CServer(Server, 6666));
				m_Servers.Add(CServer(Server, 6667));
				m_Servers.Add(CServer(Server, 6668));
				m_Servers.Add(CServer(Server, 6669));
			}
			else
				m_Servers.Add(CServer(Server, Port));
		}

		MyReadStringText(File, Value, Result); 
	}

	CloseHandle(File);
//	if ((m_ServerIndex < 0) || (m_ServerIndex >= m_Servers.GetSize()))
		m_ServerIndex = m_Servers.GetSize() - 1;
}

BOOL CIRCClient::GetThreadDone()
{
	WaitForSingleObject(m_DoneMutex, INFINITE);
	BOOL val = *m_ThreadDone;
	ReleaseMutex(m_DoneMutex);
	return val;
}

void CIRCClient::SetThreadDone(BOOL done)
{
	WaitForSingleObject(m_DoneMutex, INFINITE);
	*m_ThreadDone = done;
	ReleaseMutex(m_DoneMutex);
}

void CIRCClient::Join(CString channel)
{
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	BOOL Already = FALSE;
	for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		if (m_ChannelList.GetAt(Index).m_Channel == channel)
			Already = TRUE;
	}
	if (!Already)
	{
		m_ChannelList.Add(CChannel(channel, FALSE, FALSE));
		m_ChannelModified = TRUE;
		IALRemoveChannelAll(channel);
	}
	ReleaseMutex(m_ChannelMutex);
}

void CIRCClient::Part(CString channel)
{
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		if (m_ChannelList.GetAt(Index).m_Channel == channel)
		{
			CChannel Channel = m_ChannelList.GetAt(Index);
			Channel.m_Parting = TRUE;
			m_ChannelList.SetAt(Index, Channel);
			m_ChannelModified = TRUE;
			IALRemoveChannelAll(channel);
		}
	}
	ReleaseMutex(m_ChannelMutex);
}

void CIRCClient::AddUserCount(CString Channel, int Count)
{
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		CChannel ChannelObj = m_ChannelList.GetAt(Index);
		if (ChannelObj.m_Channel == Channel)
		{
			ChannelObj.m_Count += Count;
			m_ChannelList.SetAt(Index, ChannelObj);
		}
	}
	ReleaseMutex(m_ChannelMutex);
}

void CIRCClient::IncUserCount(CString Channel)
{
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		CChannel ChannelObj = m_ChannelList.GetAt(Index);
		if ((ChannelObj.m_Channel == Channel) && ChannelObj.m_CountValid)
		{
			ChannelObj.m_Count++;
			m_ChannelList.SetAt(Index, ChannelObj);
		}
	}
	ReleaseMutex(m_ChannelMutex);
}

void CIRCClient::DecUserCount(CString Channel)
{
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		CChannel ChannelObj = m_ChannelList.GetAt(Index);
		if ((ChannelObj.m_Channel == Channel) && ChannelObj.m_CountValid)
		{
			ChannelObj.m_Count--;
			m_ChannelList.SetAt(Index, ChannelObj);
		}
	}
	ReleaseMutex(m_ChannelMutex);
}

void CIRCClient::IALRemoveChannelAll(CString Channel)
{
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int ialIndex = 0 ; ialIndex < m_IAL.GetSize() ; ialIndex++)
	{
		if (m_IAL.GetAt(ialIndex).m_Channel == Channel)
			m_IAL.RemoveAt(ialIndex--);
	}
	ReleaseMutex(m_IALMutex);
}

void CIRCClient::IALRemoveAll(CString Source)
{
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if (ialEntry.m_User == Source)
		{
			DecUserCount(ialEntry.m_Channel);
			m_IAL.RemoveAt(Index--);
		}
	}
	ReleaseMutex(m_IALMutex);
}

void CIRCClient::IALUpdateAll(CString Source, CString NewSource)
{
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if (ialEntry.m_User == Source)
		{
			ialEntry.m_User == NewSource;
			m_IAL.SetAt(Index, ialEntry);
		}
	}
	ReleaseMutex(m_IALMutex);
}

int CIRCClient::GetUserCount(CString Channel)
{
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	int UserCount = -1;
	for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		CChannel ChannelObj = m_ChannelList.GetAt(Index);
		if (ChannelObj.m_Channel == Channel)
		{
			UserCount = ChannelObj.m_Count;
		}
	}
	ReleaseMutex(m_ChannelMutex);
	return UserCount;
}

BOOL CIRCClient::IsIPinChannel(CString ip, CString channel)
{
	BOOL Found = FALSE;
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if ((ialEntry.m_IP == ip) && (ialEntry.m_Channel == channel))
			Found = TRUE;
	}
	ReleaseMutex(m_IALMutex);

	// if IAL is not up to date, then assume they are in the channel
	int UserCount,IALUserCount;
	UserCount = GetUserCount(channel);
	IALUserCount = GetIALUserCount(channel);

	if (UserCount != IALUserCount)
		Found = TRUE;

	// if we are not in the channel, then they might be.  assume yes
	BOOL InChannel = FALSE;
	WaitForSingleObject(m_ChannelMutex, INFINITE);
	for (Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
	{
		if (m_ChannelList.GetAt(Index).m_Channel == channel)
			InChannel = TRUE;
	}
	ReleaseMutex(m_ChannelMutex);

	if (!InChannel)
		Found = TRUE;

	// if we are logging in from localhost, then let in no matter what
	if (ip == "127.0.0.1")
		Found = TRUE;

	return Found;
}

void CIRCClient::IALRemove(CString Source, CString Channel)
{
	// Remove from IAL Source,Channel
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if ((ialEntry.m_User == Source) && (ialEntry.m_Channel == Channel))
			m_IAL.RemoveAt(Index--);
	}
	ReleaseMutex(m_IALMutex);
}

void CIRCClient::IALRemoveNick(CString Nick, CString Channel)
{
	// Remove from IAL Source,Channel
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		CString ialNick = ialEntry.m_User.SpanExcluding("!");
		if ((ialNick == Nick) && (ialEntry.m_Channel == Channel))
			m_IAL.RemoveAt(Index--);
	}
	ReleaseMutex(m_IALMutex);
}

void CIRCClient::IALAdd(CString Source, CString Channel)
{
	// Add to IAL Source,Channel
	WaitForSingleObject(m_IALMutex, INFINITE);
	BOOL Found = FALSE;
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if ((ialEntry.m_User == Source) && (ialEntry.m_Channel == Channel))
			Found = TRUE;
	}
	if (!Found)
	{
		CString HostName = Source.SpanExcluding("@");
		HostName = Source.Mid(HostName.GetLength());
		HostName.TrimLeft("@");
		m_IAL.Add(CIALEntry(Source, CRawSocket::ForwardDNS(HostName), Channel));
	}
	ReleaseMutex(m_IALMutex);
}

int CIRCClient::GetIALUserCount(CString Channel)
{
	int UserCount = 0;
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; Index < m_IAL.GetSize() ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if (ialEntry.m_Channel == Channel)
			UserCount++;
	}
	ReleaseMutex(m_IALMutex);
	return UserCount;
}

CString CIRCClient::IALGetUserNick(CString ip)
{
	CString nick;

	int UserCount = 0;
	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; (Index < m_IAL.GetSize()) && (nick.GetLength() == 0) ; Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		if (ialEntry.m_IP == ip)
			nick = ialEntry.m_User.SpanExcluding("!");
	}
	ReleaseMutex(m_IALMutex);
	return nick;
}

void CIRCClient::StateMachine()
{
	while (!GetThreadDone())
	{
		switch (m_IRCState)
		{
		case STATE_NOSERVERS:
			Sleep(1000);
			WaitForSingleObject(m_Mutex, INFINITE);
			if (m_Reload)
			{
				m_IRCState = STATE_INVALID;
				InitServerList();
				m_Reload = FALSE;
			}
			ReleaseMutex(m_Mutex);
			break;
		case STATE_NEXTSERVER:
			if (m_ServerIndex == 0)
				m_ServerIndex = m_Servers.GetSize() - 1;
			else
				m_ServerIndex--;
			m_IRCState = STATE_INVALID;

		case STATE_INVALID:
			WaitForSingleObject(m_ChannelMutex, INFINITE);
			{
				for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
				{
					CChannel Channel = m_ChannelList.GetAt(Index);
					Channel.m_Joined = FALSE;
					m_ChannelList.SetAt(Index, Channel);
				}
			}
			m_ChannelModified = TRUE;
			ReleaseMutex(m_ChannelMutex);

			m_Socket.CloseSocket();

			if (m_Servers.GetSize() < 1)
			{
				m_IRCState = STATE_NOSERVERS;
				m_App->m_DebugDlg.AddString("No servers to connect to\r\n");
			}
			else
			{
				if (GetEnabled())
				{
					m_Socket.Create();
					if (m_Socket.GetState() == CRawSocket::Created)
						m_IRCState = STATE_IDLE;
				}
			}
			break;
		case STATE_IDLE:
			m_App->m_DebugDlg.AddString("Connecting to " + m_Servers.GetAt(m_ServerIndex).Host + "...");
			m_Socket.Connect(m_Servers.GetAt(m_ServerIndex).Host, m_Servers.GetAt(m_ServerIndex).Port);
			if (m_Socket.GetState() == CRawSocket::Connected)
			{
				m_App->m_DebugDlg.AddString("Connected");
				m_IRCState = STATE_SENDNICK;

				while (CommandAvailable())
					CString Command = GetCommand();
			}
			else
			{
				m_App->m_DebugDlg.AddString("Failed to connect.");
				m_IRCState = STATE_NEXTSERVER;
			}
			break;
		case STATE_SENDNICK:
			WaitForSingleObject(m_Mutex, INFINITE);
			m_NewNick = FALSE;
			m_App->m_DebugDlg.AddString("Setting Nick and User");
			m_Socket.SendStringWait("NICK " + m_Nick + "\r\n", FALSE);
			m_Socket.SendStringWait("USER " + (m_User.GetLength() ? m_User : "user") + " host server :" + 
				(m_User.GetLength() ? m_User : "user") + "\r\n", FALSE);
			m_IRCState = STATE_CHECKCONNECT;
			ReleaseMutex(m_Mutex);
			break;
		case STATE_CHECKCONNECT:
			m_App->m_DebugDlg.AddString("Sending VERSION");
			m_Socket.SendStringWait("VERSION\r\n", FALSE);
			m_IRCState = STATE_VERSIONWAIT;
			break;
		case STATE_VERSIONWAIT:
			if (m_Socket.GetState() != CRawSocket::Connected)
				m_IRCState = STATE_NEXTSERVER;
			break;
		case STATE_CONNECTED:
//			int UserCount,IALUserCount;
			//UserCount = GetUserCount("#warezguild");
			//IALUserCount = GetIALUserCount("#warezguild");

			while (CommandAvailable())
			{
				CString Command = GetCommand();
				m_App->m_DebugDlg.AddString("COMMAND: " + Command);
				m_Socket.SendStringWait(Command, FALSE);
			}
			if (m_Socket.GetState() != CRawSocket::Connected)
				m_IRCState = STATE_INVALID;
			if (!GetEnabled())
				m_IRCState = STATE_INVALID;
			
			WaitForSingleObject(m_ChannelMutex, INFINITE);
			if (m_ChannelModified)
			{
				for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
				{
					CChannel Channel = m_ChannelList.GetAt(Index);
					if (Channel.m_Parting)
					{
						if (Channel.m_Joined)
						{
							m_Socket.SendStringWait("PART " + Channel.m_Channel + "\r\n", FALSE);
							Channel.m_Joined = FALSE;
						}

						IALRemoveChannelAll(Channel.m_Channel);

						m_ChannelList.RemoveAt(Index--);
					}
					else
					{
						if (!Channel.m_Joined)
						{
							m_Socket.SendStringWait("JOIN " + Channel.m_Channel + "\r\n", FALSE);
							m_Socket.SendStringWait("WHO " + Channel.m_Channel + "\r\n", FALSE);
							Channel.m_Joined = TRUE;
							Channel.m_Count = 0;
							Channel.m_CountValid = FALSE;
							m_ChannelList.SetAt(Index, Channel);
						}
					}
				}
				m_ChannelModified = FALSE;
			}
			ReleaseMutex(m_ChannelMutex);

			WaitForSingleObject(m_Mutex, INFINITE);
			if (m_NewNick)
				m_IRCState = STATE_SENDNICK;
			if (m_Reload)
			{
				m_IRCState = STATE_INVALID;
				m_Reload = FALSE;
			}
			ReleaseMutex(m_Mutex);
			break;
		}
		
		switch (m_IdentState)
		{
		case STATE_IDLE:
			if (m_IdentListenSocket.AcceptReady())
			{
				if (m_IdentListenSocket.Accept(m_IdentSocket))
				{
					TRACE("Ident Accepted: %d\n", m_IdentListenSocket.GetLastError());
					m_IdentState = STATE_CONNECTED;
				}
				else
					TRACE("Ident Accept Failed: %d\n", m_IdentListenSocket.GetLastError());
			}
			break;
		case STATE_CONNECTED:
			if (m_IdentSocket.RecvDataReady())
			{
				char Buffer[1024];
				LONG AmountRead;
				if (m_IdentSocket.Receive(Buffer, 1024, AmountRead))
				{
					CString Temp(Buffer, AmountRead);
					m_IdentSocket.ParseString(Temp);
					TRACE("Ident:  " + Temp + "\n");
					Temp.Replace("\n", "\r\n");
					m_App->m_DebugDlg.AddString("Ident: " + Temp);
				}
			}
			
			if (m_IdentSocket.GetLastError())
				m_IdentSocket.CloseSocket();
			
			while (m_IdentSocket.StringReady())
			{
				CString Request = m_IdentSocket.RemoveString();
				// <port-on-server> , <port-on-client> : <resp-type> : <add-info>
				CString Response = Request + " : USERID : WIN32 : " + GetUser() + " \r\n";
				// CString Response = Request + " : ERROR : INVALID-PORT | NO-USER | HIDDEN-USER | UNKNOWN-ERROR \r\n"
				m_IdentSocket.SendStringWait(Response, FALSE);
			}
			if (m_IdentSocket.GetState() != CRawSocket::Connected)
				m_IdentState = STATE_IDLE;
			break;
		}
		
		if (m_Socket.RecvDataReady())
		{
			char Buffer[1024];
			LONG AmountRead;
			if (m_Socket.Receive(Buffer, 1024, AmountRead))
			{
				CString Temp(Buffer, AmountRead);
				m_Socket.ParseString(Temp);
				Temp.Replace("\n", "\r\n");
				m_App->m_DebugDlg.AddString(Temp);
			}
		}
		
		if (m_Socket.GetLastError())
		{
			m_App->m_DebugDlg.AddString("Closing IRC socket.");
			m_Socket.CloseSocket();
			if (m_IRCState != STATE_CONNECTED)
			{
				m_IRCState = STATE_NEXTSERVER;
			}
		}
		
		while (m_Socket.StringReady())
		{
			CString Incoming = m_Socket.RemoveString();
			CString Source;
			if (Incoming.Left(1) == ":")
			{
				Source = Incoming.SpanExcluding(" ");
				Incoming = Incoming.Mid(Source.GetLength());
				Source.TrimLeft(":");
				Incoming.TrimLeft(" ");
			}
			
			long ResultCode = atol(Incoming.SpanExcluding(" "));
			if (ResultCode != 0)
			{
				CString Temp = Incoming.SpanExcluding(" ");
				Incoming = Incoming.Mid(Temp.GetLength());
				Incoming.TrimLeft(" ");
			}
			
			switch (ResultCode)
			{
			case 0:
				if (Incoming.Left(4).CompareNoCase("PING") == 0)
				{
					CString PingHost = Incoming.SpanExcluding(" ");
					PingHost = Incoming.Mid(PingHost.GetLength());

					CString Response = "PONG "+ PingHost + "\r\n";
					SocketSendString(Response);
				}
				if (Incoming.Left(4).CompareNoCase("JOIN") == 0)
				{
					CString Channel = Incoming.SpanExcluding(" ");
					Channel = Incoming.Mid(Channel.GetLength());
					Channel.TrimLeft(" :");

					IALAdd(Source, Channel);
					IncUserCount(Channel);
				}
				if (Incoming.Left(4).CompareNoCase("KICK") == 0)
				{
					CString Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" ");

					Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" ");
					CString KickNick = Incoming.SpanExcluding(" ");

					if (KickNick == GetNick())
					{
						WaitForSingleObject(m_ChannelMutex, INFINITE);
						{
							for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
							{
								CChannel ChannelObj = m_ChannelList.GetAt(Index);
								if (ChannelObj.m_Channel == Channel)
								{
									ChannelObj.m_Joined = FALSE;
									m_ChannelList.SetAt(Index, ChannelObj);
									m_ChannelModified = TRUE;
								}
							}
						}
						ReleaseMutex(m_ChannelMutex);

						IALRemoveChannelAll(Channel);
					}
					else
					{
						// Remove from IAL Source,Channel
						IALRemoveNick(KickNick, Channel);
						DecUserCount(Channel);
					}
				}
				if (Incoming.Left(4).CompareNoCase("PART") == 0)
				{
					CString Channel = Incoming.SpanExcluding(" ");
					Channel = Incoming.Mid(Channel.GetLength());
					Channel.TrimLeft(" ");
					// Remove from IAL Source,Channel
					IALRemove(Source, Channel);
					DecUserCount(Channel);
				}
				if (Incoming.Left(4).CompareNoCase("QUIT") == 0)
				{
					// Remove from IAL Source,Channel
					IALRemoveAll(Source);
				}
				if (Incoming.Left(4).CompareNoCase("NICK") == 0)
				{
					CString NewNick = Incoming.SpanExcluding(" ");
					NewNick = Incoming.Mid(NewNick.GetLength());
					NewNick.TrimLeft(" :");

					CString NewSource = Source.SpanExcluding("!");
					NewSource = Source.Mid(NewSource.GetLength());
					NewSource = NewNick + NewSource;

					IALUpdateAll(Source, NewSource);
				}
				if (Incoming.Left(7).CompareNoCase("PRIVMSG") == 0)
				{
					CString Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" ");

					Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" ");
					CString Msg = Incoming;
					Msg.TrimLeft(":");

					CString Reply;
					if (GetTriggerReply(Channel, Msg, Reply))
						SendMsgToChannels(Reply, Source.SpanExcluding("!"));
				}
				break;
			case ERR_NOSUCHNICK: 
				{
					CString BadNick = Incoming.SpanExcluding(" ");
					BadNick = Incoming.Mid(BadNick.GetLength());
					BadNick.TrimLeft(" :");

					BadNick = BadNick.SpanExcluding(" ");
					WaitForSingleObject(m_Mutex, INFINITE);
					m_LastBadNick = BadNick;
					ReleaseMutex(m_Mutex);
				}
				break;
				/* Version responses */
			case ERR_NOSUCHSERVER:
				m_Socket.CloseSocket();
				break;
			case RPL_VERSION:
				if (m_IRCState == STATE_VERSIONWAIT)
				{
					m_App->m_DebugDlg.AddString("Got ver. response.");
					m_IRCState = STATE_CONNECTED;
				}
				break;
				/* WHO responses */
			case RPL_WHOREPLY: /* "<channel> <user> <host> <server> <nick> \
				<H|G>[*][@|+] :<hopcount> <real name>" */
				{
					CString Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" ");
					
					Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" ");
					
					CString User = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(User.GetLength());
					Incoming.TrimLeft(" ");
					
					CString HostName = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(HostName.GetLength());
					Incoming.TrimLeft(" ");
					
					CString Server = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Server.GetLength());
					Incoming.TrimLeft(" ");
					
					CString Nick = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Nick.GetLength());
					Incoming.TrimLeft(" ");
					
					IALAdd(Nick + "!" + User + "@" + HostName, Channel);
				}
				break;
			case RPL_ENDOFWHO:
				break;
				/* NAME responses */
			case RPL_NAMREPLY: /* "<channel> :[[@|+]<nick> [[@|+]<nick> [...]]]" */
				{
					int Count = 0;
					CString Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" =:@+");

					Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" :");

					while (Incoming.GetLength() > 0)
					{
						CString Nick = Incoming.SpanExcluding(" ");
						Incoming = Incoming.Mid(Nick.GetLength());
						Incoming.TrimLeft(" ");
						Count++;
					}

					AddUserCount(Channel, Count);
				}
				break;
			case RPL_ENDOFNAMES:
				{
					CString Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" =:");

					Channel = Incoming.SpanExcluding(" ");
					Incoming = Incoming.Mid(Channel.GetLength());
					Incoming.TrimLeft(" :");

					WaitForSingleObject(m_ChannelMutex, INFINITE);
					for (int Index = 0 ; Index < m_ChannelList.GetSize() ; Index++)
					{
						CChannel ChannelObj = m_ChannelList.GetAt(Index);
						if (ChannelObj.m_Channel == Channel)
						{
							ChannelObj.m_CountValid = TRUE;
							m_ChannelList.SetAt(Index, ChannelObj);
						}
					}
					ReleaseMutex(m_ChannelMutex);
				}
				break;
				/* JOIN responses */
			case ERR_NEEDMOREPARAMS: 
			case ERR_BANNEDFROMCHAN:
			case ERR_INVITEONLYCHAN:            
			case ERR_BADCHANNELKEY:
			case ERR_CHANNELISFULL:             
			case ERR_NOSUCHCHANNEL:               
			case ERR_TOOMANYCHANNELS:
				break;
			case RPL_TOPIC: /* "<channel> :<topic>" */
//				Channel = Incoming.SpanExcluding(":");
//				m_ChannelList.Add(Channel);
				break;
				/* PART responses */
//			case ERR_NEEDMOREPARAMS:
//			case ERR_NOSUCHCHANNEL:
			case ERR_NOTONCHANNEL:
				break;
				/* USER responses */
//			case ERR_NEEDMOREPARAMS:
			case ERR_ALREADYREGISTRED:
				break;
				/* NICK responses */
			case ERR_NONICKNAMEGIVEN:
			case ERR_ERRONEUSNICKNAME:
			case ERR_NICKCOLLISION:
			case ERR_NICKNAMEINUSE:
				CString MyNick;
				MyNick = GetNick();
				if (MyNick.GetLength() < 9)
					MyNick += "^";
				else
				{
					if (((MyNick[8] >= 'A') && (MyNick[8] < 'Z')) ||
						((MyNick[8] >= 'a') && (MyNick[8] < 'z')) ||
						((MyNick[8] >= '0') && (MyNick[8] < '9')))
					{
						MyNick.SetAt(8, MyNick[8] + 1);
					}
					else
					{
						if (MyNick[8] == '9')
							MyNick.SetAt(8, 'A');
						else
						{
							if (MyNick[8] == 'Z')
								MyNick.SetAt(8, 'a');
							else
								MyNick.SetAt(8, '0');
						}
					}
				}
				m_IRCState = STATE_SENDNICK;
				SetUserNick(GetUser(), MyNick);
				break;
			}
		}
	Sleep(500);
	}
}


CString CIRCClient::GetDuplicateLocalNick()
{
	// Remove from IAL Source,Channel
	CString MyNick = GetNick();
	CString OtherNick;

	WaitForSingleObject(m_IALMutex, INFINITE);
	for (int Index = 0 ; (Index < m_IAL.GetSize() && (OtherNick.GetLength() == 0)); Index++)
	{
		CIALEntry ialEntry = m_IAL.GetAt(Index);
		CString ialNick = ialEntry.m_User.SpanExcluding("!");
		CString LocalIP;
		UINT LocalPort;
		if (m_Socket.GetState() == CRawSocket::Connected)
			m_Socket.GetSockName(LocalIP, LocalPort);

		if ((ialEntry.m_IP == LocalIP) && (ialNick != MyNick))
			OtherNick = ialNick;
	}
	ReleaseMutex(m_IALMutex);

	return OtherNick;
}

CString CIRCClient::GetLastBadNick()
{
	WaitForSingleObject(m_Mutex, INFINITE);
	CString BadNick = m_LastBadNick;
	m_LastBadNick = "";
	ReleaseMutex(m_Mutex);
	return BadNick;
}

bool CIRCClient::GetTriggerReply(CString channel, CString msg, CString &reply)
{
	bool result = false;
	if (msg.GetLength() == 0)
		return false;

	WaitForSingleObject(m_TriggerMutex, INFINITE);
	for (int Index = 0 ; (Index < m_TriggerText.GetSize()) && !result ; Index++)
	{
		if ((m_TriggerChannels.GetAt(Index) == channel) &&
			(m_TriggerText.GetAt(Index) == msg))
		{
			result = true;
			reply = m_TriggerReply.GetAt(Index);
		}
	}
	ReleaseMutex(m_TriggerMutex);
	return result;
}

void CIRCClient::LockTriggerData()
{
	WaitForSingleObject(m_TriggerMutex, INFINITE);
}

void CIRCClient::ReleaseTriggerData()
{
	ReleaseMutex(m_TriggerMutex);
}

void CIRCClient::ClearTriggerData()
{
	m_TriggerText.RemoveAll();
	m_TriggerReply.RemoveAll();
	m_TriggerChannels.RemoveAll();
}

void CIRCClient::AddTriggerPair(CString channel, CString trigger, CString reply)
{
	if (trigger.GetLength() && reply.GetLength())
	{
		m_TriggerText.Add(trigger);
		m_TriggerReply.Add(reply);
		m_TriggerChannels.Add(channel);
	}
}

void CIRCClient::SendMsgToChannels(CString Msg, CString Channels)
{
	int index;
	
	while (Channels.GetLength())
	{
		CString WorkingMsg = Msg;
		CString TempMsg;
		TempMsg = WorkingMsg.SpanExcluding("\r\n");
		while (TempMsg.GetLength() > 0)
		{
			AddCommand("PRIVMSG " + Channels.SpanExcluding(",") + " :" + 
				TempMsg + "\r\n");

			WorkingMsg = WorkingMsg.Mid(TempMsg.GetLength());
			WorkingMsg.TrimLeft("\r\n");
			TempMsg = WorkingMsg.SpanExcluding("\r\n");
		}

		index = Channels.Find(",");
		if (index >= 0)
		{
			Channels = Channels.Mid(index);
			Channels.TrimLeft(",");
		}
		else
			Channels = "";
	}
}

BOOL CIRCClient::CommandAvailable()
{
	WaitForSingleObject(m_CommandMutex, INFINITE);
	BOOL Available = (m_Commands.GetSize() > 0);
	ReleaseMutex(m_CommandMutex);
	return Available;
}

CString CIRCClient::GetCommand()
{
	WaitForSingleObject(m_CommandMutex, INFINITE);
	CString Command = m_Commands.GetAt(0);
	m_Commands.RemoveAt(0);
	ReleaseMutex(m_CommandMutex);
	return Command;
}

void CIRCClient::AddCommand(CString command)
{
	WaitForSingleObject(m_CommandMutex, INFINITE);
	m_Commands.Add(command);
	ReleaseMutex(m_CommandMutex);
}
