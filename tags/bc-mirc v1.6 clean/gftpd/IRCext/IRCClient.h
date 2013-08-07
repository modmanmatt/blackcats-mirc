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


// IRCClient.h: interface for the CIRCClient class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_IRCCLIENT_H__B18F7950_16F5_11D3_ACEA_004F49069218__INCLUDED_)
#define AFX_IRCCLIENT_H__B18F7950_16F5_11D3_ACEA_004F49069218__INCLUDED_

#include "RawSocket.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "afxtempl.h"
#include "afxmt.h"
//#include "IRCext.h"

class CServer
{
public:
	CServer(CString host = "", UINT port = 0){Host = host; Port = port;};

	CString Host;
	UINT Port;
};

class CChannel
{
public:
	CChannel(CString channel = "", BOOL joined = FALSE, BOOL parting = FALSE)
		{m_Channel = channel; m_Joined = joined; m_Parting = parting; 
		m_Count = 0; m_CountValid = FALSE;};

	CString m_Channel;
	BOOL m_Joined;
	BOOL m_Parting;
	int m_Count;
	BOOL m_CountValid;
};

class CIALEntry
{
public:
	CIALEntry(CString user = "", CString ip = "", CString channel = "")
		{m_User = user; m_IP = ip; m_Channel = channel;};

	CString m_User;
	CString m_IP;
	CString m_Channel;
};

typedef CArray<CServer,CServer> CServerArray;
typedef CArray<CChannel,CChannel> CChannelList;
typedef CArray<CIALEntry,CIALEntry> CIAL;

#define STATE_INVALID 0
#define STATE_IDLE 1
#define STATE_SENDNICK 2
#define STATE_CONNECTED 3
#define STATE_CHECKCONNECT 4
#define STATE_VERSIONWAIT 5
#define STATE_NEXTSERVER 6
#define STATE_NOSERVERS 7

class CIRCextApp;

class CIRCClient  
{
public:
	CString IALGetUserNick(CString ip);
	void AddTriggerPair(CString channel, CString trigger, CString reply);
	void ClearTriggerData();
	void ReleaseTriggerData();
	void LockTriggerData();
	CString GetLastBadNick();
	CString GetDuplicateLocalNick();
	BOOL IsIPinChannel(CString ip, CString channel);
	void Join(CString channel);
	void Part(CString channel);
	CString GetUser();
	CString GetNick();
	void SetUserNick(CString user, CString nick);
	void Create(BOOL *donePtr, HANDLE doneMutex, CIRCextApp *app);
	void Begin();
	CIRCClient();
	virtual ~CIRCClient();

	BOOL GetThreadDone();
	void SetThreadDone(BOOL done);
	BOOL GetEnabled();
	void SetEnabled(BOOL enabled);
	CString GetServerList();
	void SetServerList(CString list);

	void SendMsgToChannels(CString Msg, CString Channels);
	BOOL CommandAvailable();
	CString GetCommand();
	void AddCommand(CString command);
protected:
	CStringArray m_TriggerChannels;
	CStringArray m_TriggerReply;
	CStringArray m_TriggerText;
	bool GetTriggerReply(CString channel, CString msg, CString &reply);
	void IALUpdateAll(CString Source, CString NewSource);
	void IALRemoveChannelAll(CString Source);
	void IALRemoveAll(CString Source);
	void IncUserCount(CString Channel);
	void DecUserCount(CString Channel);
	int GetUserCount(CString Channel);
	int GetIALUserCount(CString Channel);
	void IALRemove(CString Source, CString Channel);
	void IALRemoveNick(CString Nick, CString Channel);
	void IALAdd(CString Source, CString Channel);
	void AddUserCount(CString Channel, int Count);
	CIRCextApp* m_App;
	UINT m_IdentState;
	UINT m_IRCState;
	void StateMachine();
	BOOL *m_ThreadDone;
	UINT m_ServerIndex;
	CServerArray m_Servers;
	void InitServerList();
	void Init();
	CRawSocket m_Socket;
	CRawSocket m_IdentListenSocket;
	CRawSocket m_IdentSocket;
	CString m_User;
	CString m_Nick;
	BOOL m_NewNick;
	CString m_LastBadNick;

	CChannelList m_ChannelList;
	BOOL m_ChannelModified;

	BOOL m_Enabled;
	CString m_ServerList;
	BOOL m_Reload;

	CIAL m_IAL;

	HANDLE m_TriggerMutex;
	HANDLE m_DoneMutex;
	HANDLE m_Mutex;
	HANDLE m_ChannelMutex;
	HANDLE m_IALMutex;

	CStringArray m_Commands;
	HANDLE m_CommandMutex;
};

#endif // !defined(AFX_IRCCLIENT_H__B18F7950_16F5_11D3_ACEA_004F49069218__INCLUDED_)
