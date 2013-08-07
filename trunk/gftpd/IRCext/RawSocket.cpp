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


// RawSocket.cpp: implementation of the CRawSocket class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "RawSocket.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CRawSocket::CRawSocket()
{
	Mutex = CreateMutex(NULL, FALSE, NULL);
#ifdef FTP_SUPPORT
	_Filename = NULL;
#endif
	Init();
}

void CRawSocket::Init()
{
	AsyncWnd = NULL;
	AsyncMsg = 0;
	AsyncEvent = 0;
	m_Socket = NULL;
	State = Invalid;
	LastError = 0;
#ifdef FTP_SUPPORT
	//	FileSent = FALSE;
	//	DataSent = FALSE;
	hFile = INVALID_HANDLE_VALUE;

	SetSpeedLimit(0);
	SetFilename(NULL);
	SetDisconnect(FALSE, "");
	SetPosition(0);
	SetTotal(0);
	SetIdleTimeValid(FALSE);
	SetAppend(FALSE);
	SetSuccess(0);
	m_Thread = NULL;
	SetSpeed(0);
	SetSpeedValid(FALSE);
#endif
}

void CRawSocket::SetLastError(DWORD error)
{
	LastError = error;
	if ((error != WSAEWOULDBLOCK) && error)
		TRACE("RawSocket Error %ld\r\n", error);
}


CRawSocket::~CRawSocket()
{
	CloseSocket();
#ifdef FTP_SUPPORT
	SetFilename(NULL);
#endif
	CloseHandle(Mutex);
	Mutex = NULL;

#ifdef FTP_SUPPORT
	SetDisconnect(TRUE, "Destructor Shutdown");
	while (!ThreadDone())
		Sleep(50);
#endif
}

BOOL CRawSocket::Socket(int Type, int Protocol)
{
	AsyncDisable();
	ASSERT(!m_Socket);
	m_Socket = socket(PF_INET, Type, Protocol);
	if (m_Socket == INVALID_SOCKET)
	{
		SetLastError(::GetLastError());
		m_Socket = NULL;
	}
	else
		State = Created;
	AsyncEnable();
	return (m_Socket != 0);
}

BOOL CRawSocket::CloseSocket()
{
	AsyncDisable();
	if (m_Socket)
	{
		State = Closing;
		if (closesocket(m_Socket))
		{
			SetLastError(::GetLastError());
		}
		else
			State = Invalid;
		m_Socket = NULL;
		State = Invalid;
	}
	AsyncEnable();
	return (LastError == 0);
}

BOOL CRawSocket::Connect(LPCSTR address, UINT port)
{
	ASSERT(address != NULL);
	AsyncDisable();

	State = Connecting;
	SOCKADDR_IN sockAddr = {0};

	sockAddr.sin_family = AF_INET;
	sockAddr.sin_addr.s_addr = inet_addr(address);

	if (sockAddr.sin_addr.s_addr == INADDR_NONE)
	{
		LPHOSTENT lphost;
		lphost = gethostbyname(address);
		if (lphost != NULL)
			sockAddr.sin_addr.s_addr = ((LPIN_ADDR)lphost->h_addr)->s_addr;
		else
		{
			SetLastError(WSAEINVAL);
			State = Created;
			AsyncEnable();
			return FALSE;
		}
	}

	sockAddr.sin_port = htons((u_short)port);
	if (connect(m_Socket, (SOCKADDR*)&sockAddr, sizeof(sockAddr)) != 0)
	{
		SetLastError(::GetLastError());
		State = Created;
	}
	else
		State = Connected;
	AsyncEnable();
	return (LastError == 0);
}

BOOL CRawSocket::Listen(UINT backlog)
{
	ASSERT(m_Socket);
	AsyncDisable();
	
	State = Listening;
	
	if (listen(m_Socket, backlog) != 0)
	{
		State = Created;
	}
	SetLastError(::GetLastError());
	AsyncEnable();
	return (LastError == 0);
}

BOOL CRawSocket::Accept(CRawSocket &socket, UINT timeout)
{
	ASSERT(m_Socket);
	AsyncDisable();
	socket.CloseSocket();

	fd_set fdData;
	timeval tval = {0};
	tval.tv_sec = timeout;

	FD_ZERO(&fdData);
	FD_SET(m_Socket, &fdData);

	BOOL Timeout = TRUE;
	if (select(0, &fdData, 0, 0, &tval) > 0)
	{
		Timeout = FALSE;
		SOCKET acceptedSocket = accept(m_Socket, NULL, 0);
		if (acceptedSocket == INVALID_SOCKET)
			SetLastError(::GetLastError());
		else
		{
			socket.m_Socket = acceptedSocket;
			socket.State = Connected;
		}
	}
		
	AsyncEnable();
	return ((LastError == 0) && !Timeout);
}

BOOL CRawSocket::Send(LPCSTR data, LONG len, LONG &amountSent)
{
	amountSent = 0;

	if (!m_Socket)
		return FALSE;
	AsyncDisable();

	if (SendDataReady())
	{
		if (data)
		{
			if (len == -1)
				len = strlen(data);
			u_long Value = 1;
			if (ioctlsocket(m_Socket, FIONBIO, &Value) == 0)
			{
				if ((amountSent = send(m_Socket, data, len, 0)) == SOCKET_ERROR)
				{
					SetLastError(::GetLastError());
					switch (LastError)
					{
					case WSAEWOULDBLOCK:
						SetLastError(0);
						amountSent = 0;
						break;
					case WSAECONNRESET:
						CloseSocket();
						break;
					}
				}
				Value = 0;
				ioctlsocket(m_Socket, FIONBIO, &Value);
			}
			else
			{
				SetLastError(::GetLastError());
				switch (LastError)
				{
				case WSAECONNRESET:
					CloseSocket();
					break;
				}
			}
		}
	}
	AsyncEnable();
	return (LastError == 0);
}

BOOL CRawSocket::BlockSend(LPCSTR data, LONG len, LONG &amountSent)
{
	amountSent = 0;
	
	if (!m_Socket)
		return FALSE;
	AsyncDisable();
	
	if (data)
	{
		if (len == -1)
			len = strlen(data);
		
		if ((amountSent = send(m_Socket, data, len, 0)) == SOCKET_ERROR)
		{
			SetLastError(::GetLastError());
			switch (LastError)
			{
			case WSAEWOULDBLOCK:
				SetLastError(0);
				amountSent = 0;
				break;
			case WSAECONNRESET:
				CloseSocket();
				break;
			}
		}
	}

	AsyncEnable();
	return (LastError == 0);
}

BOOL CRawSocket::Receive(LPSTR buffer, LONG len, LONG &AmountRead)
{
	AmountRead = 0;

	if (!m_Socket)
		return FALSE;
	ASSERT(buffer);
	AsyncDisable();

	if (RecvDataReady())
	{
		if ((AmountRead = recv(m_Socket, buffer, len, 0)) <= 0)
		{
			AmountRead = 0;
			SetLastError(::GetLastError());
			switch (LastError)
			{
			case WSAEMSGSIZE:
				SetLastError(0);
				break;
			case 0:
			case WSAECONNRESET:
				CloseSocket();
				break;
			}
		}
	}
	AsyncEnable();
	return (LastError == 0);
}

BOOL CRawSocket::SendDataReady()
{
	if (!m_Socket)
		return FALSE;

	fd_set fdData;
	timeval tval = {0};

	FD_ZERO(&fdData);
	FD_SET(m_Socket, &fdData);

	if (select(0, 0, &fdData, 0, &tval) > 0)
		return TRUE;
	else
	{
		SetLastError(::GetLastError());
		return FALSE;
	}
}

BOOL CRawSocket::RecvDataReady()
{
	if (!m_Socket)
		return FALSE;

	fd_set fdData;
	timeval tval = {0};

	FD_ZERO(&fdData);
	FD_SET(m_Socket, &fdData);

	if (select(0, &fdData, 0, 0, &tval) > 0)
		return TRUE;
	else
	{
		SetLastError(::GetLastError());
		return FALSE;
	}
}

#ifdef CSTRING_SUPPORT
BOOL CRawSocket::GetSockName(CString &buffer, UINT &port)
{
	BOOL Success;
	Success = GetSockName(buffer.GetBuffer(1024), 1024, port);
	buffer.ReleaseBuffer();
	return Success;
}
#endif

BOOL CRawSocket::GetSockName(LPSTR buffer, UINT len, UINT &port)
{
	ASSERT(m_Socket);
	SOCKADDR_IN sockAddr = {0};

	int nSockAddrLen = sizeof(sockAddr);
	if (getsockname(m_Socket, (SOCKADDR*)&sockAddr, &nSockAddrLen) == 0)
	{
		port = ntohs(sockAddr.sin_port);
		lstrcpyn(buffer, inet_ntoa(sockAddr.sin_addr), len);
	}
	else
		SetLastError(::GetLastError());
	return (LastError == 0);
}

SOCKET CRawSocket::Detach()
{
	SOCKET dSocket = m_Socket;
#ifdef FTP_SUPPORT
	if (hFile != INVALID_HANDLE_VALUE)
		CloseHandle(hFile);
#endif
	Init();
	return dSocket;
}

BOOL CRawSocket::Create(UINT port)
{
	return Socket() && Bind(port);
}

BOOL CRawSocket::Bind(UINT port)
{
	SOCKADDR_IN sockAddr = {0};
	sockAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	sockAddr.sin_family = AF_INET;
	sockAddr.sin_port = htons((u_short)port);

	if (bind(m_Socket, (SOCKADDR*)&sockAddr, sizeof(SOCKADDR_IN)) == 0)
	{
		State = Created;
	}

	SetLastError(::GetLastError());
	return (LastError == 0);
}

#ifdef FTP_SUPPORT
BOOL CRawSocket::SendStringWait(CString string, BOOL autoClose)
{
	SendString(string, autoClose);
	while (!IsComplete())
		Sleep(50);

	return FALSE;
}

BOOL CRawSocket::SendString(CString string, BOOL autoClose)
{
	ASSERT(!m_Thread);

	m_Mode = ModeTXString;
	m_Data = string;
	m_AutoClose = autoClose;

	m_Thread =  AfxBeginThread( StaticThreadFunction, (LPVOID)this, 
		THREAD_PRIORITY_ABOVE_NORMAL, 0, CREATE_SUSPENDED);
	m_Thread->m_bAutoDelete = FALSE;
	m_Thread->ResumeThread();

	return FALSE;
}

BOOL CRawSocket::SendFile(LPCSTR filename, BOOL BinaryMode, DWORD RestartMarker, BOOL autoClose)
{
	ASSERT(!m_Thread);

	m_Mode = ModeTXFile;
	SetFilename(filename);
	m_BinaryThread = BinaryMode;
	m_RestartThread = RestartMarker;
	m_AutoClose = autoClose;

	m_Thread =  AfxBeginThread( StaticThreadFunction, (LPVOID)this, 
		THREAD_PRIORITY_ABOVE_NORMAL, 0, CREATE_SUSPENDED);
	m_Thread->m_bAutoDelete = FALSE;
	m_Thread->ResumeThread();

	return FALSE;
}

BOOL CRawSocket::ReceiveFile(LPCSTR filename, BOOL BinaryMode, BOOL autoClose, BOOL append)
{
	ASSERT(!m_Thread);

	SetAppend(append);

	m_Mode = ModeRXFile;
	SetFilename(filename);
	m_BinaryThread = BinaryMode;
	m_AutoClose = autoClose;

	m_Thread =  AfxBeginThread( StaticThreadFunction, (LPVOID)this, 
		THREAD_PRIORITY_ABOVE_NORMAL, 0, CREATE_SUSPENDED);
	m_Thread->m_bAutoDelete = FALSE;
	m_Thread->ResumeThread();

	return FALSE;
}

void CRawSocket::SetFilename(LPCSTR filename)
{
	WaitForSingleObject(Mutex, INFINITE);
	if (_Filename)
		delete _Filename;
	_Filename = 0;
	if (filename)
	{
		_Filename = new char[strlen(filename) + 1];
		lstrcpy(_Filename, filename);
	}
	ReleaseMutex(Mutex);
}

DWORD CRawSocket::GetFilename(LPSTR filename, DWORD len)
{
	DWORD Length = 0;
	WaitForSingleObject(Mutex, INFINITE);
	if (filename)
	{
		ASSERT(len);
		if (_Filename)
		{
			lstrcpyn(filename, _Filename, len);
			Length = lstrlen(_Filename);
		}
		else
		{
			filename[0] = 0;
			Length = 0;
		}
	}
	else
	{
		if (_Filename)
			Length = lstrlen(_Filename);
	}
	ReleaseMutex(Mutex);
	return Length;
}

CString CRawSocket::GetFilename()
{
	CString Filename;
	WaitForSingleObject(Mutex, INFINITE);
	Filename = _Filename;
	ReleaseMutex(Mutex);
	return Filename;
}

void CRawSocket::SetIdleTime(CTime time)
{
	WaitForSingleObject(Mutex, INFINITE);
	_IdleTime = time;
	ReleaseMutex(Mutex);
}

void CRawSocket::SetIdleTimeValid(BOOL valid)
{
	WaitForSingleObject(Mutex, INFINITE);
	_IdleTimeValid = valid;
	ReleaseMutex(Mutex);
}

BOOL CRawSocket::GetIdleTimeValid()
{
	WaitForSingleObject(Mutex, INFINITE);
	BOOL valid = _IdleTimeValid;
	ReleaseMutex(Mutex);
	return valid;
}

CTime CRawSocket::GetIdleTime()
{
	CTime Temp;
	WaitForSingleObject(Mutex, INFINITE);
	Temp = _IdleTimeValid ? _IdleTime : CTime::GetCurrentTime();
	ReleaseMutex(Mutex);
	return Temp;
}

CString CRawSocket::GetDisconnectMsg()
{
	CString val;
	WaitForSingleObject(Mutex, INFINITE);
	val = _DisconnectMsg;
	ReleaseMutex(Mutex);
	return val;
}

BOOL CRawSocket::GetDisconnect()
{
	BOOL val;
	WaitForSingleObject(Mutex, INFINITE);
	val = _Disconnect;
	ReleaseMutex(Mutex);
	return val;
}

void CRawSocket::SetDisconnect(BOOL val, CString msg)
{
	WaitForSingleObject(Mutex, INFINITE);
	_DisconnectMsg = msg;
	_Disconnect = val;
	ReleaseMutex(Mutex);
}
#endif

BOOL CRawSocket::Attach(SOCKET sock)
{
	State = Connected;
	m_Socket = sock;
	return TRUE;
}

BOOL CRawSocket::Shutdown(int how)
{
	AsyncDisable();
	int Result = 0;
	if (State != Invalid)
	{
		Result = shutdown(m_Socket, how);
		if (Result == SOCKET_ERROR)
		{
			TRACE("Socket shutdown error %d\n", WSAGetLastError());
		}
	}
	AsyncEnable();
	return (Result == 0);
}

BOOL CRawSocket::AcceptReady()
{
	return RecvDataReady();
}

#ifdef CSTRING_PARSE_SUPPORT
void CRawSocket::ParseString(CString data)
{
	int Difference;
	do 
	{
		CString Temp2 = data.SpanExcluding("\r\n");
		
		WorkingString = WorkingString + Temp2;
		
		Difference = data.GetLength() - Temp2.GetLength();
		
		if (Difference != 0)
		{
//			DebugLog(WorkingString);
			Strings.AddTail((CObject*)new CString(WorkingString));
			WorkingString = CString("");
			if (Difference > 1)
				data = data.Mid(data.GetLength() - Difference);
			else
				data = CString("");
			while (data.GetLength() && ((data[0] == '\r') || (data[0] == '\n')))
				data = data.Mid(1);
		}
	}
	while (Difference && data.GetLength());
}

CString CRawSocket::RemoveString()
{		
	CString *String = (CString*)Strings.RemoveHead();
	CString Result = *String;
	delete String;
	return Result;
}

int CRawSocket::GetResponseCode(CString data)
{
	int Response = -1;

	if ((data.GetLength() > 3) && (data[3] == ' ') && (atol(data)))
		Response = atol((LPCSTR)data.Left(3));

	return Response;
}

int CRawSocket::WaitForResponse(UINT timeout, CStringArray *responseStr)
{
	int Response = -1;
	BOOL TimedOut = FALSE;
	CString Buffer;
	LONG AmountRead;

	while ((Response == -1) && !TimedOut)
	{
		if (RecvDataReady())
		{
			if (Receive(Buffer.GetBuffer(512), 512, AmountRead))
			{
				Buffer.ReleaseBuffer(512);
				ParseString(Buffer);
				while (StringReady() && (Response == -1))
				{
					CString Temp = RemoveString();
					if (responseStr)
						responseStr->Add(Temp);
					Response = GetResponseCode(Temp);
				}
			}
			else
			{
				Buffer.ReleaseBuffer(1);
			}
		}
		else
		{
			Sleep(100);
		}
	}
	return Response;
}

#endif

#ifdef FTP_SUPPORT
UINT CRawSocket::StaticThreadFunction( LPVOID pParam )
{
	CRawSocket *Socket = (CRawSocket*)pParam;
	return Socket->ThreadFunction();
}

void CRawSocket::SendStrThread()
{
	CString string = m_Data;
	BOOL Success = TRUE;

	DWORD BufferSize = 1024;
	BigBuffer = new char[BufferSize + 1];
	DWORD AmountRead;

	SetIdleTime(CTime::GetCurrentTime());
	SetIdleTimeValid(TRUE);
	SetPosition(0);

	AmountRead = (BufferSize > (DWORD)string.GetLength()) ? string.GetLength() : BufferSize;
	lstrcpyn(BigBuffer, string, AmountRead + 1);
	if ((DWORD)string.GetLength() == AmountRead)
		string = "";
	else
		string = string.Mid(AmountRead);
	SetPosition(GetPosition() + AmountRead);

	UINT BufferIndex = 0;
	LONG SendAmount = 0;
		
	while (Success && (AmountRead > 0) && !GetDisconnect())
	{
		while (AmountRead && Success && !GetDisconnect())
		{
			if  (Send(&BigBuffer[BufferIndex], AmountRead, SendAmount))
			{
				BufferIndex += SendAmount;
				AmountRead -= SendAmount;
			}
			else
				Success = FALSE;
//			PumpWaitingMessages();
			if (AmountRead && Success)
				Sleep(50);
		}
		
		BufferIndex = 0;
		if (Success)
		{
			if (!GetDisconnect())
			{
				SetIdleTime(CTime::GetCurrentTime());

				AmountRead = (BufferSize > (DWORD)string.GetLength()) ? string.GetLength() : BufferSize;
				if (AmountRead)
				{
					lstrcpyn(BigBuffer, string, AmountRead + 1);
					if ((DWORD)string.GetLength() == AmountRead)
						string = "";
					else
						string = string.Mid(AmountRead);
					SetPosition(GetPosition() + AmountRead);
				}
			}
		}
	}
	
	SetIdleTimeValid(FALSE);
	delete [] BigBuffer;
	
	Success = GetDisconnect() ? FALSE : Success;
	SetSuccess(Success ? 0 : -1);

	if (m_AutoClose)
		CloseSocket();
}

#define SWAP_LPSTR(__A,__B) { \
	(__A) = (LPSTR)((DWORD)(__A) ^ (DWORD)(__B)); \
	(__A) = (LPSTR)((DWORD)(__B) ^ (DWORD)(__A)); \
	(__A) = (LPSTR)((DWORD)(__A) ^ (DWORD)(__B)); }

void CRawSocket::SendFileThread()
{

	ASSERT(hFile == INVALID_HANDLE_VALUE);
	FileSent = FALSE;

	BOOL Success = TRUE;
	BOOL DeleteTemp = FALSE;
	UINT BackCount = 0;
	DWORD SpeedLimit = GetSpeedLimit() * 1000;

	CString FilenameStr = GetFilename();
	CString DriveLetter = FilenameStr.SpanExcluding("\\/");
	DriveLetter += "\\";

	if (GetDriveType(DriveLetter) == DRIVE_CDROM)
	{
		CString TempFilename;
		LPSTR TempFilenameBuffer = TempFilename.GetBuffer(MAX_PATH + 1);
		GetTempFileName(m_TempPath, "ftp", 0, TempFilenameBuffer);
		TempFilename.ReleaseBuffer();
		Success = CopyFile(FilenameStr, TempFilename, FALSE);
		FilenameStr = TempFilename;
		DeleteTemp = TRUE;
	}

	if (Success)
	{
		hFile = CreateFile(FilenameStr, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);

		if (hFile == INVALID_HANDLE_VALUE)
			Success = FALSE;
	}

	SetTotal(GetFileSize(hFile, NULL));
	SetPosition(0);

	DWORD BufferSize = 16384 * 5;
	BigBuffer = new char[BufferSize];
	DWORD AmountRead;

	SetIdleTime(CTime::GetCurrentTime());
	SetIdleTimeValid(FALSE);
	BOOL TempItemTimeValid = FALSE;

	CTime StartTime = CTime::GetCurrentTime();

	if (m_RestartThread > 0)
	{
		SetFilePointer(hFile, m_RestartThread, NULL, FILE_BEGIN);
		SetPosition(m_RestartThread);
	}

	DWORD BlockSize = 1024;
	DWORD MaxBlockSize = BufferSize;

	if (SpeedLimit && SpeedLimit < BufferSize)
		MaxBlockSize = SpeedLimit / 10;


	/* Speed calc vars */
	BOOL DoSpeedCalc = FALSE;
	DWORD SpeedValidCount = 0;
	BOOL SpeedValid = FALSE;
	double Speed = 0.0;

#define FILT_SIZE 4
	DWORD LastTicks[FILT_SIZE], SpeedBytes = 0, LastSpeedBytes[FILT_SIZE];
	int FiltInd = 0;

	/* Speed calc init */
	SetSpeedValid(FALSE);
	SetSpeed(0);

	
	for (FiltInd = 0 ; FiltInd < FILT_SIZE ; FiltInd++)
	{
		LastTicks[FiltInd] = ::GetTickCount() - 1; // ms
		LastSpeedBytes[FiltInd] = 0;
	}

	FiltInd = 0;

	if (Success)
	{
		Success = ReadFile(hFile, BigBuffer, BufferSize, &AmountRead, NULL);

		UINT BufferIndex = 0;
		LONG SendAmount = 0;

		BOOL TempDisconnect = FALSE;
		
		while (Success && (AmountRead > 0) && !TempDisconnect)
		{
#if(0)
			if ((LastTicks[FiltInd] - GetTickCount()) > 1000)
			{
				LastTicks[FiltInd] = ::GetTickCount() - 1; // ms
				LastSpeedBytes[FiltInd] = SpeedBytes;
				
				FiltInd = (FiltInd + 1) % FILT_SIZE;
			}
#endif
			BOOL TempExit = FALSE;
			while (AmountRead && Success && !TempDisconnect && !TempExit)
			{
				if  (BlockSend(&BigBuffer[BufferIndex], (AmountRead < BlockSize) ? AmountRead : BlockSize, SendAmount))
				{
					/* Update speed bytes */
					SpeedBytes += SendAmount;

					if (SendDataReady())
					{
						if (BlockSize < MaxBlockSize)
						{
							BlockSize = BlockSize * 2;
							if (BlockSize > MaxBlockSize)
								BlockSize = MaxBlockSize;
						}
					}
					else
					{
						/* Now we know we filled the buffers up, so start */
						if (!DoSpeedCalc)
						{
							DoSpeedCalc = TRUE;
							SpeedBytes = 0; 
							for (FiltInd = 0 ; FiltInd < FILT_SIZE ; FiltInd++)
							{
								LastTicks[FiltInd] = ::GetTickCount() - 1; // ms
								LastSpeedBytes[FiltInd] = 0;
							}
							FiltInd = 0;
						}

						/* Filled up buffers, so we got time to check disconnect */
						TempDisconnect = GetDisconnect();
					}

					BufferIndex += SendAmount;
					AmountRead -= SendAmount;
				}
				else
				{
					Success = FALSE;
					CString FailMsg;
					FailMsg.Format("Failed socket write. %ld", LastError);
					SetDisconnect(TRUE, FailMsg);
				}

				SetPosition(GetPosition() + SendAmount);

				if (!SendAmount)
				{
					if (!TempItemTimeValid)
					{
						TempItemTimeValid = TRUE;
						SetIdleTime(CTime::GetCurrentTime());
						SetIdleTimeValid(TRUE);
					}
					else
					{
						TempDisconnect = GetDisconnect();
						Sleep(50);
//						PumpWaitingMessages();
					}
				}
				else
				{
					if (TempItemTimeValid)
					{
						SetIdleTimeValid(FALSE);
						TempItemTimeValid = FALSE;
					}
				}

				if (DoSpeedCalc)
				{
					double NewSpeed;

					NewSpeed = (SpeedBytes - LastSpeedBytes[FiltInd]) * 1000.0 / 
						(GetTickCount() - LastTicks[FiltInd]);
					Speed = ((Speed * 9) + (NewSpeed * 1)) / 10.0;

					while (SpeedLimit && (Speed > (SpeedLimit)) && !TempDisconnect)
					{
						Sleep(100);

						NewSpeed = (SpeedBytes - LastSpeedBytes[FiltInd]) * 1000.0 / 
							(GetTickCount() - LastTicks[FiltInd]);
						Speed = ((Speed * 9) + (NewSpeed * 1)) / 10.0;
//						SetSpeed(Speed);

						TempDisconnect = GetDisconnect();
					}
				}

			}

			/* If after 5 seconds, go ahead and start speed timing */
			if (!DoSpeedCalc && ((GetTickCount() - LastTicks[FiltInd]) > 5000))
			{
				DoSpeedCalc = TRUE;
				SpeedBytes = 0; 
				for (FiltInd = 0 ; FiltInd < FILT_SIZE ; FiltInd++)
				{
					LastTicks[FiltInd] = ::GetTickCount() - 1; // ms
					LastSpeedBytes[FiltInd] = 0;
				}
				FiltInd = 0;
			}

			/* Set speed, but not urgent, so don't wait around */
			if (WaitForSingleObject( Mutex, 0) == WAIT_OBJECT_0)
			{
				SetSpeed((DWORD)(Speed + 0.5));
				ReleaseMutex(Mutex);
			}

			if (!SpeedValid && Speed)
			{
				SpeedValid = TRUE;
				SetSpeedValid(SpeedValid);
			}

			BufferIndex = 0;
			BackCount++;
			if (Success)
			{
				/* If we are so fast that we don't get to check this when
				   buffers are full, check it every so often any way */
				if (!(BackCount % 25))
					TempDisconnect = GetDisconnect();

				if (!TempDisconnect && !AmountRead)
				{
					Success = ReadFile(hFile, BigBuffer, BufferSize, &AmountRead, NULL);

//					SetPosition(GetPosition() + AmountRead);
					if (!Success)
						SetDisconnect(TRUE, "Failed file read.");
				}
			}
			else
				TRACE("ReadFileError %d\n", GetLastError());
		}
	}

	SetIdleTimeValid(FALSE);
	delete [] BigBuffer;

	if (hFile != INVALID_HANDLE_VALUE)
	{
		CloseHandle(hFile);
		hFile = INVALID_HANDLE_VALUE;
	}
	
	Success = GetDisconnect() ? FALSE : Success;

	//SetFilename(NULL);

	if (DeleteTemp)
	{
		SetFileAttributes(FilenameStr, FILE_ATTRIBUTE_NORMAL);
		if (!DeleteFile(FilenameStr))
			TRACE("DeleteFile Fail %d\n", GetLastError());
	}

	SetSpeed(0);
	SetSpeedValid(FALSE);

	if (m_AutoClose)
		CloseSocket();
	m_Success = Success ? 0 : -1;
}

void CRawSocket::RecvFileThread()
{

	ASSERT(hFile == INVALID_HANDLE_VALUE);
	FileSent = FALSE;
	if (GetAppend())
		hFile = CreateFile(GetFilename(), GENERIC_WRITE, 0, NULL, OPEN_ALWAYS, 0, NULL);
	else
		hFile = CreateFile(GetFilename(), GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, 0, NULL);
	SetPosition(0);
	SetTotal(GetPosition());

	if (GetAppend())
	{
		SetFilePointer(hFile, 0, NULL, FILE_END);
		SetPosition(GetFileSize(hFile, NULL));
	}

	DWORD AmountRead;
	DWORD BufferSize = 16384;
	BigBuffer = new char[BufferSize];

//	BOOL Success = ReadFile(hFile, BigBuffer, BufferSize, &AmountRead, NULL);
	UINT BufferIndex = 0;
	LONG SendAmount;
	BOOL Success = TRUE;

	SetIdleTime(CTime::GetCurrentTime());
	SetIdleTimeValid(FALSE);
	BOOL TempItemTimeValid = FALSE;
	BOOL Finished = FALSE;

	BOOL TempDisconnect = FALSE;
	UINT BackCount = 0;

	/* Speed calc init */
#define FILT_SIZE 4
	DWORD LastTicks = ::GetTickCount() - 1;
	DWORD SpeedBytes = 0;
	DWORD LastSpeedBytes = 0;
	double Speed = 0.0;
	BOOL SpeedValid = FALSE;
	SetSpeedValid(FALSE);
	SetSpeed(0);

	do
	{
		if (!Receive(BigBuffer, BufferSize, SendAmount))
		{
			Finished = TRUE;
			if (GetLastError() && (GetLastError() != WSAECONNRESET))
			{
				Success = FALSE;
				CString FailMsg;
				FailMsg.Format("Failed socket read. %ld", LastError);
				SetDisconnect(TRUE, FailMsg);
			}
		}
		else
		{
			BackCount++;
			SpeedBytes += SendAmount;
			if (!(BackCount % 25))
				TempDisconnect = GetDisconnect();

			if (SendAmount)
			{
				if (TempItemTimeValid)
				{
					TempItemTimeValid = FALSE;
					SetIdleTimeValid(FALSE);
				}
				Success = WriteFile(hFile, BigBuffer, SendAmount, &AmountRead, NULL);
				if (!Success)
					SetDisconnect(TRUE, "File write error.");
				SetPosition(GetPosition() + AmountRead);
				SetTotal(GetPosition());
			}
			else
			{
				if (!TempItemTimeValid)
				{
					SetIdleTime(CTime::GetCurrentTime());
					SetIdleTimeValid(TRUE);
					TempItemTimeValid = TRUE;
				}
				else
				{
					TempDisconnect = GetDisconnect();
					Sleep(50);
//					PumpWaitingMessages();
				}
			}

			double NewSpeed;
			
			NewSpeed = (SpeedBytes - LastSpeedBytes) * 1000.0 / 
				(GetTickCount() - LastTicks);
			Speed = ((Speed * 9) + (NewSpeed * 1)) / 10.0;

			if (!SpeedValid)
			{
				SetSpeedValid(TRUE);
				SetSpeed((DWORD)(Speed + 0.5));
				SpeedValid = TRUE;
			}
		}
	}
	while (!Finished && Success && !TempDisconnect);

	SetIdleTimeValid(FALSE);

	delete [] BigBuffer;
	CloseHandle(hFile);

	hFile = INVALID_HANDLE_VALUE;

	Success = GetDisconnect() ? FALSE : Success;

	//SetFilename(NULL);
	SetAppend(FALSE);

	if (m_AutoClose)
		CloseSocket();
	m_Success = Success ? 0 : -1;
}

UINT CRawSocket::ThreadFunction()
{
	switch (m_Mode)
	{
	case ModeTXString:
		SendStrThread();
		break;
	case ModeTXFile:
		SendFileThread();
		break;
	case ModeRXFile:
		RecvFileThread();
		break;
	}

	return 0;
}


BOOL CRawSocket::ThreadDone()
{
	DWORD ExitCode;
	BOOL Done = TRUE;
	if (m_Thread)
	{
		GetExitCodeThread(m_Thread->m_hThread, &ExitCode);
		Done = (ExitCode != STILL_ACTIVE);
		if (Done)
		{
			delete m_Thread;
			m_Thread = NULL;
		}
	}
	return Done;
}
#endif

BOOL CRawSocket::Broadcast(LPCSTR data, LONG len, UINT port)
{
	AsyncDisable();
	SOCKADDR_IN sockAddr = {0};

	sockAddr.sin_family = AF_INET;
	sockAddr.sin_addr.s_addr = INADDR_BROADCAST;
	sockAddr.sin_port = htons((u_short)port);

	if (sendto(m_Socket, data, len, 0, (SOCKADDR*)&sockAddr, 
		sizeof(SOCKADDR_IN)) == SOCKET_ERROR)
	{
		SetLastError(::GetLastError());
		switch (LastError)
		{
		case WSAECONNRESET:
			CloseSocket();
			break;
		case WSAEACCES:
			{
				BOOL Value = TRUE;
				setsockopt(m_Socket, SOL_SOCKET, SO_BROADCAST,
					(LPCSTR)&Value, sizeof(BOOL));
				LastError = 0;
				Broadcast(data, len, port);
			}
			break;
		}
	}
	AsyncEnable();
	return (LastError == 0);
}

#ifdef ASYNC_MODE
int CRawSocket::AsyncDisable()
{
	int Result = -1;
	if (AsyncWnd)
	{
		Result = WSAAsyncSelect(m_Socket, AsyncWnd, AsyncMsg, 0);
		u_long Value = 0;
		ioctlsocket(m_Socket, FIONBIO, &Value);
	}
	return Result;
}

int CRawSocket::AsyncEnable()
{
	int Result = -1;
	if (AsyncWnd && AsyncEvent)
	{
		Result = WSAAsyncSelect(m_Socket, AsyncWnd, AsyncMsg, AsyncEvent);
	}
	return Result;
}

int CRawSocket::AsyncSelect(HWND wnd, UINT msg, long event)
{
	AsyncWnd = wnd;
	AsyncMsg = msg;
	AsyncEvent = event;

	return AsyncEnable();
}
#endif

/*
#define FD_READ          (1 << FD_READ_BIT)
#define FD_WRITE         (1 << FD_WRITE_BIT)
#define FD_OOB           (1 << FD_OOB_BIT)
#define FD_ACCEPT        (1 << FD_ACCEPT_BIT)
#define FD_CONNECT       (1 << FD_CONNECT_BIT)
#define FD_CLOSE         (1 << FD_CLOSE_BIT)
*/

LPSTR CRawSocket::GetErrorString(DWORD Error)
{
	LPSTR ErrorString = "Unknown Error";
	switch (Error)
	{
	case WSAEINTR:
		ErrorString = "WSAEINTR";
		break;
/*
#define WSAEINTR                (WSABASEERR+4)
#define WSAEBADF                (WSABASEERR+9)
#define WSAEACCES               (WSABASEERR+13)
#define WSAEFAULT               (WSABASEERR+14)
#define WSAEINVAL               (WSABASEERR+22)
#define WSAEMFILE               (WSABASEERR+24)
#define WSAEWOULDBLOCK          (WSABASEERR+35)
#define WSAEINPROGRESS          (WSABASEERR+36)
#define WSAEALREADY             (WSABASEERR+37)
#define WSAENOTSOCK             (WSABASEERR+38)
#define WSAEDESTADDRREQ         (WSABASEERR+39)
#define WSAEMSGSIZE             (WSABASEERR+40)
#define WSAEPROTOTYPE           (WSABASEERR+41)
#define WSAENOPROTOOPT          (WSABASEERR+42)
#define WSAEPROTONOSUPPORT      (WSABASEERR+43)
#define WSAESOCKTNOSUPPORT      (WSABASEERR+44)
#define WSAEOPNOTSUPP           (WSABASEERR+45)
#define WSAEPFNOSUPPORT         (WSABASEERR+46)
#define WSAEAFNOSUPPORT         (WSABASEERR+47)
#define WSAEADDRINUSE           (WSABASEERR+48)
#define WSAEADDRNOTAVAIL        (WSABASEERR+49)
#define WSAENETDOWN             (WSABASEERR+50)
#define WSAENETUNREACH          (WSABASEERR+51)
#define WSAENETRESET            (WSABASEERR+52)
#define WSAECONNABORTED         (WSABASEERR+53)
#define WSAECONNRESET           (WSABASEERR+54)
#define WSAENOBUFS              (WSABASEERR+55)
#define WSAEISCONN              (WSABASEERR+56)
#define WSAENOTCONN             (WSABASEERR+57)
#define WSAESHUTDOWN            (WSABASEERR+58)
#define WSAETOOMANYREFS         (WSABASEERR+59)
#define WSAETIMEDOUT            (WSABASEERR+60)
#define WSAECONNREFUSED         (WSABASEERR+61)
#define WSAELOOP                (WSABASEERR+62)
#define WSAENAMETOOLONG         (WSABASEERR+63)
#define WSAEHOSTDOWN            (WSABASEERR+64)
#define WSAEHOSTUNREACH         (WSABASEERR+65)
#define WSAENOTEMPTY            (WSABASEERR+66)
#define WSAEPROCLIM             (WSABASEERR+67)
#define WSAEUSERS               (WSABASEERR+68)
#define WSAEDQUOT               (WSABASEERR+69)
#define WSAESTALE               (WSABASEERR+70)
#define WSAEREMOTE              (WSABASEERR+71)
#define WSASYSNOTREADY          (WSABASEERR+91)
#define WSAVERNOTSUPPORTED      (WSABASEERR+92)
#define WSANOTINITIALISED       (WSABASEERR+93)
#define WSAEDISCON              (WSABASEERR+101)
#define WSAENOMORE              (WSABASEERR+102)
#define WSAECANCELLED           (WSABASEERR+103)
#define WSAEINVALIDPROCTABLE    (WSABASEERR+104)
#define WSAEINVALIDPROVIDER     (WSABASEERR+105)
#define WSAEPROVIDERFAILEDINIT  (WSABASEERR+106)
#define WSASYSCALLFAILURE       (WSABASEERR+107)
#define WSASERVICE_NOT_FOUND    (WSABASEERR+108)
#define WSATYPE_NOT_FOUND       (WSABASEERR+109)
#define WSA_E_NO_MORE           (WSABASEERR+110)
#define WSA_E_CANCELLED         (WSABASEERR+111)
#define WSAEREFUSED             (WSABASEERR+112)
*/
	default:
		break;
	}
	return ErrorString;
}


void CRawSocket::GetHostName(LPSTR hostname, int length)
{
	gethostname(hostname, length);
}

BOOL CRawSocket::GetLocalIP(LPSTR ipAddr, int Index)
{
	BOOL Success = FALSE;
	HOSTENT *HostEnt;
	char HostNameBuffer[512];
	gethostname(HostNameBuffer, 512);
	HostEnt = gethostbyname(HostNameBuffer);

	int Offset = 0;
	while (HostEnt->h_addr_list[Offset] && (Offset != Index))
		Offset++;
	if (HostEnt->h_addr_list[Offset])
	{
		unsigned char *IP = (unsigned char*)
			HostEnt->h_addr_list[Offset];
		wsprintf(ipAddr, "%d.%d.%d.%d", IP[0], IP[1], IP[2], IP[3]);
		Success = TRUE;
	}
	return Success;
}

CString CRawSocket::ForwardDNS(CString name)
{
	CString Result;
	LPHOSTENT hostent = gethostbyname(name);
	if (hostent)
		Result = inet_ntoa(*(LPIN_ADDR)hostent->h_addr);
	else
		Result = "unknown";
	return Result;
}

CString CRawSocket::ReverseDNS(CString ip)
{
	CString Result;
	unsigned long ipaddr = inet_addr(ip);
	HOSTENT *hostent = gethostbyaddr((LPCSTR)&ipaddr, sizeof(ipaddr), AF_INET);
	if (hostent)
		Result = hostent->h_name;
	else
		Result = "unknown";
	return Result;
}
