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


// KickRulesDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IRCext.h"
#include "KickRulesDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CKickRulesDlg dialog


CKickRulesDlg::CKickRulesDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CKickRulesDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CKickRulesDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	m_RulesMutex = NULL;
	m_Rules = NULL;
}


void CKickRulesDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CKickRulesDlg)
	DDX_Control(pDX, IDC_RULES_LIST, m_RulesList);
	DDX_Control(pDX, IDC_CHANNEL, m_Channel);
	DDX_Control(pDX, IDC_ACCOUNT, m_Account);
	//}}AFX_DATA_MAP

	if (pDX->m_bSaveAndValidate)
		GetData();
}


BEGIN_MESSAGE_MAP(CKickRulesDlg, CDialog)
	//{{AFX_MSG_MAP(CKickRulesDlg)
	ON_BN_CLICKED(IDC_UPDATE, OnUpdate)
	ON_BN_CLICKED(IDC_REMOVE, OnRemove)
	ON_BN_CLICKED(IDC_ADD, OnAdd)
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CKickRulesDlg message handlers

void CKickRulesDlg::OnUpdate() 
{
	POSITION Pos = m_RulesList.GetFirstSelectedItemPosition();
	int Index = m_RulesList.GetNextSelectedItem(Pos);

	CString Text;
	m_Account.GetWindowText(Text);
	m_RulesList.SetItemText(Index, 1, Text);
	m_Channel.GetWindowText(Text);
	m_RulesList.SetItemText(Index, 2, Text);
}

void CKickRulesDlg::OnRemove() 
{
	POSITION Pos = m_RulesList.GetFirstSelectedItemPosition();
	int Index = m_RulesList.GetNextSelectedItem(Pos);
	m_RulesList.DeleteItem(Index);

	for (Index = 0 ; Index < m_RulesList.GetItemCount() ; Index++)
	{
		int ItemNo = Index + 1;
		CString ItemNoStr;
		ItemNoStr.Format("%d", ItemNo);
		m_RulesList.SetItemText(Index, 0, ItemNoStr);
		m_RulesList.SetItemData(Index, ItemNo);
	}

	m_RulesList.RedrawWindow();

	m_Account.SetWindowText("");
	m_Channel.SetWindowText("");
}

void CKickRulesDlg::OnAdd() 
{
	int ItemNo = m_RulesList.GetItemCount() + 1;
	CString ItemNoStr;
	ItemNoStr.Format("%d", ItemNo);
	int Index = m_RulesList.InsertItem(ItemNo, ItemNoStr);
	m_RulesList.SetItemData(Index, ItemNo);
	CString Text;
	m_Account.GetWindowText(Text);
	m_RulesList.SetItemText(Index, 1, Text);
	m_Channel.GetWindowText(Text);
	m_RulesList.SetItemText(Index, 2, Text);
}

void CKickRulesDlg::SetRulesPtr(CKickRuleArray *ptr, HANDLE mutex)
{
	m_RulesMutex = mutex;
	m_Rules = ptr;
}

BOOL CKickRulesDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_RulesList.InsertColumn(0, "No.", LVCFMT_LEFT, 30);
	m_RulesList.InsertColumn(1, "Account", LVCFMT_LEFT, 75);
	m_RulesList.InsertColumn(2, "Channel", LVCFMT_LEFT, 75);

	SetData();
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CKickRulesDlg::SetData()
{
	WaitForSingleObject(m_RulesMutex, INFINITE);
	for (int Index = 0 ; Index < m_Rules->GetSize() ; Index++)
	{
		CKickRule Rule = m_Rules->GetAt(Index);
		int ItemNo = Index + 1;
		CString ItemNoStr;
		ItemNoStr.Format("%d", ItemNo);
	
		int InsertIndex = m_RulesList.InsertItem(ItemNo, ItemNoStr);
		m_RulesList.SetItemData(InsertIndex, ItemNo);
		m_RulesList.SetItemText(InsertIndex, 1, Rule.m_Account);
		m_RulesList.SetItemText(InsertIndex, 2, Rule.m_Channel);
	}
	ReleaseMutex(m_RulesMutex);
}

void CKickRulesDlg::GetData()
{
	WaitForSingleObject(m_RulesMutex, INFINITE);
	m_Rules->RemoveAll();
	CKickRule Rule;
	for (int Index = 0 ; Index < m_RulesList.GetItemCount() ; Index++)
	{
		Rule.m_Account = m_RulesList.GetItemText(Index, 1);
		Rule.m_Channel = m_RulesList.GetItemText(Index, 2);
		m_Rules->Add(Rule);
	}
	ReleaseMutex(m_RulesMutex);
}

void CKickRulesDlg::OnOK() 
{
	CDialog::OnOK();
	m_OnOkCallback();
	DestroyWindow();
}

void CKickRulesDlg::OnClose() 
{
	CDialog::OnClose();
	DestroyWindow();
}
