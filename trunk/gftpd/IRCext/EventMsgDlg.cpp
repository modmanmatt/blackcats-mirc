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


// EventMsgDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ircext.h"
#include "EventMsgDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEventMsgDlg dialog


CEventMsgDlg::CEventMsgDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CEventMsgDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CEventMsgDlg)
	m_DownloadChannels = _T("");
	m_LoginChannels = _T("");
	m_LogoutChannels = _T("");
	m_UploadChannels = _T("");
	m_DownloadMsg = _T("");
	m_LoginMsg = _T("");
	m_LogoutMsg = _T("");
	m_UploadMsg = _T("");
	m_MakeDirChannels = _T("");
	m_MakeDirMsg = _T("");
	//}}AFX_DATA_INIT
}


void CEventMsgDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CEventMsgDlg)
	DDX_Text(pDX, IDC_DOWNLOAD_CHANNELS, m_DownloadChannels);
	DDX_Text(pDX, IDC_LOGIN_CHANNELS, m_LoginChannels);
	DDX_Text(pDX, IDC_LOGOUT_CHANNELS, m_LogoutChannels);
	DDX_Text(pDX, IDC_UPLOAD_CHANNELS, m_UploadChannels);
	DDX_Text(pDX, IDC_DOWNLOAD_MSG, m_DownloadMsg);
	DDX_Text(pDX, IDC_LOGIN_MSG, m_LoginMsg);
	DDX_Text(pDX, IDC_LOGOUT_MSG, m_LogoutMsg);
	DDX_Text(pDX, IDC_UPLOAD_MSG, m_UploadMsg);
	DDX_Text(pDX, IDC_MAKEDIR_CHANNELS, m_MakeDirChannels);
	DDX_Text(pDX, IDC_MAKEDIR_MSG, m_MakeDirMsg);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CEventMsgDlg, CDialog)
	//{{AFX_MSG_MAP(CEventMsgDlg)
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CEventMsgDlg message handlers

BOOL CEventMsgDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_LoginEdit.SubclassDlgItem(IDC_LOGIN_MSG, this);
	m_LogoutEdit.SubclassDlgItem(IDC_LOGOUT_MSG, this);
	m_DownloadEdit.SubclassDlgItem(IDC_DOWNLOAD_MSG, this);
	m_UploadEdit.SubclassDlgItem(IDC_UPLOAD_MSG, this);
	m_MakeDirEdit.SubclassDlgItem(IDC_MAKEDIR_MSG, this);
	
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CEventMsgDlg::OnOK() 
{
	CDialog::OnOK();
	m_OnOkCallback();
	DestroyWindow();
}

void CEventMsgDlg::OnCancel() 
{
	CDialog::OnCancel();
	DestroyWindow();
}

void CEventMsgDlg::OnClose() 
{
	CDialog::OnClose();
	DestroyWindow();
}
