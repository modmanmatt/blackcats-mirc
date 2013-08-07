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


// DebugDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IRCext.h"
#include "DebugDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDebugDlg dialog


#define LOG_BUFFER_SIZE 1000

CDebugDlg::CDebugDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDebugDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDebugDlg)
	//}}AFX_DATA_INIT

//	LogData = LocalAlloc(LMEM_MOVEABLE, LOG_BUFFER_SIZE);
}

CDebugDlg::~CDebugDlg()
{
//	LocalFree(LogData);
}

void CDebugDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDebugDlg)
	DDX_Control(pDX, IDC_OUTPUT, m_Output);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDebugDlg, CDialog)
	//{{AFX_MSG_MAP(CDebugDlg)
	ON_BN_CLICKED(IDC_HIDE, OnHide)
	ON_BN_CLICKED(IDC_CLEAR, OnClear)
	ON_WM_CREATE()
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDebugDlg message handlers

void CDebugDlg::OnHide() 
{
	ShowWindow(SW_HIDE);
}

void CDebugDlg::OnClear() 
{
//	m_Log.SetWindowText("");
	m_OutputWnd.ClearBuffer();
}

void CDebugDlg::AddString(LPCSTR string)
{
/*	CString LogText;
	int CurrentLine = m_Log.GetFirstVisibleLine();
	m_Log.GetWindowText(LogText);
	LogText += string;
	LogText = LogText.Right(LOG_BUFFER_SIZE);
	m_Log.SetWindowText(LogText);
	m_Log.LineScroll(Lines, 0);*/
	CString String = string;
	while (String.GetLength())
	{
		CString Temp = String.SpanExcluding("\r\n");
		m_OutputWnd.AddLine(Temp);
		String = String.Mid(Temp.GetLength());
		String.TrimLeft("\r");
		if (String.GetLength() && (String[0] == '\n'))
			String = String.Mid(1);
	}
}

BOOL CDebugDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

/*	HLOCAL Temp = m_Log.GetHandle();
	m_Log.SetHandle(LogData);
	if (Temp)
		LocalFree(Temp);*/
	
	CRect Rect;
	m_Output.GetWindowRect(Rect);
	ScreenToClient(Rect);
	m_OutputWnd.Create(NULL, NULL, WS_CHILD | WS_VISIBLE, Rect, this, 137);
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

int CDebugDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	return 0;
}

void CDebugDlg::OnClose() 
{
	CDialog::OnClose();
	DestroyWindow();
}
