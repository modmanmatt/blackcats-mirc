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


// ConfigureDlg.cpp : implementation file
//

#include "stdafx.h"
#include "IRCext.h"
#include "ConfigureDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CConfigureDlg dialog


CConfigureDlg::CConfigureDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CConfigureDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CConfigureDlg)
	m_User = _T("");
	m_Nick = _T("");
	m_GlobalEnable = FALSE;
	m_ServerList = _T("");
	//}}AFX_DATA_INIT
}


void CConfigureDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CConfigureDlg)
	DDX_Control(pDX, IDC_TRIGGERTEXT, m_TriggerText);
	DDX_Control(pDX, IDC_AD_ENABLE, m_Enable);
	DDX_Control(pDX, IDC_TIMER, m_Timer);
	DDX_Control(pDX, IDC_CHANNELS, m_Channels);
	DDX_Control(pDX, IDC_TIMERLIST, m_TimerList);
	DDX_Text(pDX, IDC_USER, m_User);
	DDX_Text(pDX, IDC_NICK, m_Nick);
	DDX_Check(pDX, IDC_GLOBAL_ENABLE, m_GlobalEnable);
	DDX_Text(pDX, IDC_SERVER_LIST, m_ServerList);
	//}}AFX_DATA_MAP

	if (pDX->m_bSaveAndValidate)
		GetData();
}


BEGIN_MESSAGE_MAP(CConfigureDlg, CDialog)
	//{{AFX_MSG_MAP(CConfigureDlg)
	ON_BN_CLICKED(IDC_ADD, OnAdd)
	ON_BN_CLICKED(IDC_REMOVE, OnRemove)
	ON_NOTIFY(NM_CLICK, IDC_TIMERLIST, OnClickTimerlist)
	ON_BN_CLICKED(IDC_UPDATE, OnUpdate)
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CConfigureDlg message handlers

#define COL_NUMBER 0
#define COL_CHANNELS 1
#define COL_TIMER 2
#define COL_ENABLED 3
#define COL_AD 4
#define COL_TRIGGERTEXT 5
#define COL_TRIGGERAD 6

void CConfigureDlg::OnAdd() 
{
	int ItemNo = m_TimerList.GetItemCount() + 1;
	CString ItemNoStr;
	ItemNoStr.Format("%d", ItemNo);
	int Index = m_TimerList.InsertItem(ItemNo, ItemNoStr);
	m_TimerList.SetItemData(Index, ItemNo);
	CString Text;
	m_Channels.GetWindowText(Text);
	m_TimerList.SetItemText(Index, COL_CHANNELS, Text);
	m_Timer.GetWindowText(Text);
	m_TimerList.SetItemText(Index, COL_TIMER, Text);
	m_Ad.GetWindowText(Text);
	m_TimerList.SetItemText(Index, COL_AD, Text);
	m_TimerList.SetItemText(Index, COL_ENABLED, m_Enable.GetCheck() ? "Enabled" : "Disabled");
	m_TriggerText.GetWindowText(Text);
	m_TimerList.SetItemText(Index, COL_TRIGGERTEXT, Text);
	m_TriggerAd.GetWindowText(Text);
	m_TimerList.SetItemText(Index, COL_TRIGGERAD, Text);
}

void CConfigureDlg::OnRemove() 
{
	POSITION Pos = m_TimerList.GetFirstSelectedItemPosition();
	int Index = m_TimerList.GetNextSelectedItem(Pos);
	m_TimerList.DeleteItem(Index);

	for (Index = 0 ; Index < m_TimerList.GetItemCount() ; Index++)
	{
		int ItemNo = Index + 1;
		CString ItemNoStr;
		ItemNoStr.Format("%d", ItemNo);
		m_TimerList.SetItemText(Index, 0, ItemNoStr);
		m_TimerList.SetItemData(Index, ItemNo);
	}

	m_TimerList.RedrawWindow();

	m_Channels.SetWindowText("");
	m_Timer.SetWindowText("");
	m_Ad.SetWindowText("");
	m_Enable.SetCheck(TRUE);
}

BOOL CConfigureDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	m_Ad.SubclassDlgItem(IDC_MSG, this);
	m_TriggerAd.SubclassDlgItem(IDC_TRIGGER_AD, this);

	m_TimerList.InsertColumn(0, "No.", LVCFMT_LEFT, 30);
	m_TimerList.InsertColumn(1, "Channels", LVCFMT_LEFT, 70);
	m_TimerList.InsertColumn(2, "Timer", LVCFMT_LEFT, 50);
	m_TimerList.InsertColumn(3, "Enabled", LVCFMT_LEFT, 50);
	m_TimerList.InsertColumn(4, "Ad", LVCFMT_LEFT, 200);
	m_TimerList.InsertColumn(5, "Trigger", LVCFMT_LEFT, 50);
	m_TimerList.InsertColumn(6, "Trigger Ad", LVCFMT_LEFT, 200);

	SetData();
	
/*	CRect Rect;
	m_AdHolder.GetWindowRect(Rect);
	ScreenToClient(Rect);
	m_Ad.Create(NULL, NULL, WS_CHILD | WS_VISIBLE, Rect, this, 137);
*/
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CConfigureDlg::OnClickTimerlist(NMHDR* pNMHDR, LRESULT* pResult) 
{
	POSITION Pos = m_TimerList.GetFirstSelectedItemPosition();
	int Index = m_TimerList.GetNextSelectedItem(Pos);

	m_Channels.SetWindowText(m_TimerList.GetItemText(Index, COL_CHANNELS));
	m_Timer.SetWindowText(m_TimerList.GetItemText(Index, COL_TIMER));
	m_Enable.SetCheck(m_TimerList.GetItemText(Index, COL_ENABLED).Compare("Enabled") == 0);
	m_Ad.SetWindowText(m_TimerList.GetItemText(Index, COL_AD));
	m_TriggerText.SetWindowText(m_TimerList.GetItemText(Index, COL_TRIGGERTEXT));
	m_TriggerAd.SetWindowText(m_TimerList.GetItemText(Index, COL_TRIGGERAD));
	
	*pResult = 0;
}

void CConfigureDlg::SetData()
{
	WaitForSingleObject(m_AdInfoMutex, INFINITE);
	for (int Index = 0 ; Index < m_AdPtr->GetSize() ; Index++)
	{
		CAdInfo Ad = m_AdPtr->GetAt(Index);
		int ItemNo = Index + 1;
		CString ItemNoStr;
		ItemNoStr.Format("%d", ItemNo);
	
		int InsertIndex = m_TimerList.InsertItem(ItemNo, ItemNoStr);
		m_TimerList.SetItemData(InsertIndex, ItemNo);
		m_TimerList.SetItemText(InsertIndex, COL_CHANNELS, Ad.Channels);
		CString TimerStr;
		TimerStr.Format("%d", Ad.Timer);
		m_TimerList.SetItemText(InsertIndex, COL_TIMER, TimerStr);
		m_TimerList.SetItemText(InsertIndex, COL_AD, Ad.Ad);
		CString EnableStr;
		EnableStr = Ad.Enable ? "Enabled" : "Disabled";
		m_TimerList.SetItemText(InsertIndex, COL_ENABLED, EnableStr);
		m_TimerList.SetItemText(InsertIndex, COL_TRIGGERTEXT, Ad.TriggerText);
		m_TimerList.SetItemText(InsertIndex, COL_TRIGGERAD, Ad.TriggerAd);
	}
	ReleaseMutex(m_AdInfoMutex);
}

void CConfigureDlg::GetData()
{
	WaitForSingleObject(m_AdInfoMutex, INFINITE);
	m_AdPtr->RemoveAll();
	CAdInfo Ad;
	for (int Index = 0 ; Index < m_TimerList.GetItemCount() ; Index++)
	{
		Ad.Channels = m_TimerList.GetItemText(Index, COL_CHANNELS);
		Ad.Timer = atol(m_TimerList.GetItemText(Index, COL_TIMER));
		Ad.Ad = m_TimerList.GetItemText(Index, COL_AD);
		Ad.Enable = (m_TimerList.GetItemText(Index, COL_ENABLED).Compare("Enabled") == 0) ? 1 : 0;
		Ad.TriggerText = m_TimerList.GetItemText(Index, COL_TRIGGERTEXT);
		Ad.TriggerAd = m_TimerList.GetItemText(Index, COL_TRIGGERAD);
		m_AdPtr->Add(Ad);
	}
	ReleaseMutex(m_AdInfoMutex);
}

void CConfigureDlg::OnUpdate() 
{
	POSITION Pos = m_TimerList.GetFirstSelectedItemPosition();
	int Index = m_TimerList.GetNextSelectedItem(Pos);

	if (Index >= 0)
	{
		CString Text;
		m_Channels.GetWindowText(Text);
		m_TimerList.SetItemText(Index, COL_CHANNELS, Text);
		m_Timer.GetWindowText(Text);
		m_TimerList.SetItemText(Index, COL_TIMER, Text);
		m_Ad.GetWindowText(Text);
		m_TimerList.SetItemText(Index, COL_AD, Text);
		m_TimerList.SetItemText(Index, COL_ENABLED, m_Enable.GetCheck() ? "Enabled" : "Disabled");
		m_TriggerText.GetWindowText(Text);
		m_TimerList.SetItemText(Index, COL_TRIGGERTEXT, Text);
		m_TriggerAd.GetWindowText(Text);
		m_TimerList.SetItemText(Index, COL_TRIGGERAD, Text);
	}

	m_TimerList.RedrawWindow();
}

void CConfigureDlg::OnOK() 
{
	CDialog::OnOK();
	m_OnOkCallback();
	DestroyWindow();
}

void CConfigureDlg::OnClose() 
{
	CDialog::OnClose();
	DestroyWindow();
}
