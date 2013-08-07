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


// PasswordHopDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IRCext.h"
#include "PasswordHopDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPasswordHopDlg dialog


CPasswordHopDlg::CPasswordHopDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPasswordHopDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPasswordHopDlg)
	m_Rate = 0;
	//}}AFX_DATA_INIT
}


void CPasswordHopDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPasswordHopDlg)
	DDX_Control(pDX, IDC_ACCOUNTS, m_AccountList);
	DDX_Control(pDX, IDC_ACCOUNT, m_Account);
	DDX_Text(pDX, IDC_RATE, m_Rate);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPasswordHopDlg, CDialog)
	//{{AFX_MSG_MAP(CPasswordHopDlg)
	ON_BN_CLICKED(IDC_UPDATE, OnUpdate)
	ON_BN_CLICKED(IDC_REMOVE, OnRemove)
	ON_BN_CLICKED(IDC_ADD, OnAdd)
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPasswordHopDlg message handlers

void CPasswordHopDlg::OnUpdate() 
{
	// TODO: Add your control notification handler code here
	
}

void CPasswordHopDlg::OnRemove() 
{
	// TODO: Add your control notification handler code here
	
}

void CPasswordHopDlg::OnAdd() 
{
	// TODO: Add your control notification handler code here
	
}

void CPasswordHopDlg::OnClose() 
{
	CDialog::OnClose();
	DestroyWindow();
}
