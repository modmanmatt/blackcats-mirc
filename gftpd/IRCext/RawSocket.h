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


// RawSocket.h: interface for the CRawSocket class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_RAWSOCKET_H__0FA96461_C2BE_11D2_86B3_004F49069218__INCLUDED_)
#define AFX_RAWSOCKET_H__0FA96461_C2BE_11D2_86B3_004F49069218__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CFtpServerSocket;

#define SD_RECV 0
#define SD_SEND 1
#define SD_BOTH 2

#ifdef _MFC_VER
#define CSTRING_PARSE_SUPPORT
#define CSTRING_SUPPORT
#define FTP_SUPPORT
#endif

class CRawSocket  
{
public:
	// Initialization and Creation
	CRawSocket();
	virtual ~CRawSocket();

	BOOL Create(UINT port = 0);
	BOOL Socket(int Type = SOCK_STREAM, int Protocol = 0);
	BOOL Bind(UINT port = 0);
	int AsyncSelect(HWND wnd, UINT msg, long event = FD_READ);

	BOOL Shutdown(int how = SD_SEND);
	BOOL CloseSocket();

	// State Information
	enum CState { Invalid, Created, Connecting, Connected, Listening, Closing };
	CState GetState(){return State;};

	// Connections
	BOOL Connect(LPCSTR address, UINT port);
	BOOL Listen(UINT backlog = 5);
	BOOL Accept(CRawSocket &socket, UINT timeout = 30);
	BOOL AcceptReady();

	// Data transfer
	BOOL Broadcast(LPCSTR data, LONG len, UINT port);
	BOOL SendDataReady();
	BOOL RecvDataReady();
	BOOL Receive(LPSTR buffer, LONG len, LONG &amountRead);
	BOOL Send(LPCSTR data, LONG len, LONG &amountSent);
	BOOL BlockSend(LPCSTR data, LONG len, LONG &amountSent);

	// Information
#ifdef CSTRING_SUPPORT
	BOOL GetSockName(CString &buffer, UINT &port);
	static CString ForwardDNS(CString name);
	static CString ReverseDNS(CString ip);
#endif
	BOOL GetSockName(LPSTR buffer, UINT len, UINT &port);
	DWORD GetLastError(){ return LastError;};
	static BOOL GetLocalIP(LPSTR ipAddr, int Index = 0); 
								// Buffer must be >= 16 chars
	static void GetHostName(LPSTR hostname, int length);
	LPSTR GetErrorString(DWORD Error);

	// Low Level
	BOOL Attach(SOCKET sock);
	SOCKET Detach();

#ifdef CSTRING_PARSE_SUPPORT
	void ParseString(CString data);
	BOOL StringReady(){ return (Strings.GetCount() > 0); };
	CString RemoveString();
	static int GetResponseCode(CString data);
	int WaitForResponse(UINT timeout = 30, CStringArray *responseStr = 0);
#endif

	// Multithreaded Transfers
	enum CMode { ModeUnknown, ModeTXString, ModeTXFile, ModeRXFile };
	BOOL IsComplete(){return ThreadDone();};

#ifdef FTP_SUPPORT
	BOOL SendString(CString string, BOOL autoClose);
	BOOL SendStringWait(CString string, BOOL autoClose);
	BOOL ReceiveFile(LPCSTR Filename, BOOL BinaryMode, BOOL autoClose, BOOL append = false);
	BOOL SendFile(LPCSTR Filename, BOOL BinaryMode, 
		DWORD RestartMarker, BOOL autoClose);
	BOOL GetAppend(){return Append;};
	void SetAppend(BOOL append){Append = append;};
	void SetTempPath(CString path){m_TempPath = path;};
#endif

protected:
	// Construction
	void Init();

	// Information
	void SetLastError(DWORD error);

	// String parsing
#ifdef CSTRING_PARSE_SUPPORT
	CObList Strings;
	CString WorkingString;
#endif

#ifdef FTP_SUPPORT
	BOOL ThreadDone();
	static UINT StaticThreadFunction( LPVOID pParam );
	UINT ThreadFunction();
	void SendStrThread();
	void SendFileThread();
	void RecvFileThread();
#endif

	// Socket Management
	HANDLE Mutex;
	SOCKET m_Socket;
	DWORD LastError;
	CState State;

	// Async members (window messages)
	HWND AsyncWnd;
	UINT AsyncMsg;
	long AsyncEvent;
#ifdef ASYNC_MODE
	int AsyncEnable();
	int AsyncDisable();
#else
	inline int AsyncEnable() {return -1;};
	inline int AsyncDisable() {return -1;};
#endif

	// Multithreaded transfers
#ifdef FTP_SUPPORT
	HANDLE hFile;   // Move this to the local threads
	BOOL FileSent;  // Move this to the local threads
	BOOL DataSent;  // Move this too
	char * BigBuffer;  // Move this too
	BOOL Append;
	int m_Success;
	CWinThread *m_Thread;
	CMode m_Mode;
	CString m_Data;
	BOOL m_BinaryThread;
	DWORD m_RestartThread;
#endif


private:
	// Thread-safe data.  Must be accessed through methods
#ifdef FTP_SUPPORT
	CString m_TempPath;
	LPSTR _Filename;
	BOOL _Disconnect;
	CString _DisconnectMsg;
	UINT _Position;
	UINT _Total;
	CTime _IdleTime;
	BOOL _IdleTimeValid;
	DWORD _SpeedLimit;
	DWORD _MinSpeed;
	BOOL m_AutoClose;
	DWORD _Speed;
	BOOL _SpeedValid;
#endif
public:
	// Thread-safe access methods
#ifdef FTP_SUPPORT
	BOOL GetIdleTimeValid();
	void SetIdleTimeValid(BOOL valid);
	void SetIdleTime(CTime time);
	CTime GetIdleTime();

	void SetFilename(LPCSTR filename);
	DWORD GetFilename(LPSTR filename, DWORD len);
#ifdef CSTRING_SUPPORT
	CString GetFilename();
#endif

	BOOL GetDisconnect();
	CString GetDisconnectMsg();
	void SetDisconnect(BOOL val, CString msg);

	int GetSuccess()
		{ int val; WaitForSingleObject(Mutex, INFINITE); 
		val = m_Success; ReleaseMutex(Mutex); return val;};
	void SetSuccess(int val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		m_Success = val; ReleaseMutex(Mutex);};

	UINT GetPosition()
		{ UINT val; WaitForSingleObject(Mutex, INFINITE); 
		val = _Position; ReleaseMutex(Mutex); return val;};
	void SetPosition(UINT val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		_Position = val; ReleaseMutex(Mutex);};

	void SetMinSpeed(DWORD val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		_MinSpeed = val; ReleaseMutex(Mutex);};
	DWORD GetMinSpeed()
		{ UINT val; WaitForSingleObject(Mutex, INFINITE); 
		val = _MinSpeed; ReleaseMutex(Mutex); return val;};

	DWORD GetSpeedLimit()
		{ UINT val; WaitForSingleObject(Mutex, INFINITE); 
		val = _SpeedLimit; ReleaseMutex(Mutex); return val;};
	void SetSpeedLimit(DWORD val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		_SpeedLimit = val; ReleaseMutex(Mutex);};

	DWORD GetSpeedBytes()
		{ UINT val; WaitForSingleObject(Mutex, INFINITE); 
		val = _Speed; ReleaseMutex(Mutex); return val;};
	DWORD GetSpeed()
		{ UINT val; WaitForSingleObject(Mutex, INFINITE); 
		val = ((_Speed + 500) / 1000); ReleaseMutex(Mutex); return val;};
	void SetSpeed(DWORD val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		_Speed = val; ReleaseMutex(Mutex);};

	BOOL GetSpeedValid()
		{ BOOL val; WaitForSingleObject(Mutex, INFINITE); 
		val = _SpeedValid; ReleaseMutex(Mutex); return val;};
	void SetSpeedValid(BOOL val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		_SpeedValid = val; ReleaseMutex(Mutex);};

	UINT GetTotal()
		{ UINT val; WaitForSingleObject(Mutex, INFINITE); 
		val = _Total; ReleaseMutex(Mutex); return val;};
	void SetTotal(UINT val)
		{ WaitForSingleObject(Mutex, INFINITE); 
		_Total = val; ReleaseMutex(Mutex);};

#endif
};

#endif // !defined(AFX_RAWSOCKET_H__0FA96461_C2BE_11D2_86B3_004F49069218__INCLUDED_)
