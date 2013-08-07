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


// StatDialog.cpp : implementation file
//

#include "stdafx.h"
#include "stats.h"
#include "StatDialog.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define GET_MAX(__p1__,__p2__) ((__p1__ > __p2__) ? (__p1__) : (__p2__))
#define GET_AVG(__base__,__member__,__member2__) \
	((__base__.__member2__) ? (__base__.__member__ / __base__.__member2__) : 0 )

#define STAT_FIND_MAX(__member__,__max__) { \
	long __max__ = m_PastHourStat.##__member__; \
	__max__ = GET_MAX(m_Past4HoursStat.##__member__,__max__); \
	__max__ = GET_MAX(m_Past8HoursStat.##__member__,__max__); \
	__max__ = GET_MAX(m_Past24HoursStat.##__member__,__max__); \
	__max__ = GET_MAX(m_PastWeekStat.##__member__,__max__); \
	__max__ = GET_MAX(m_FullStat.##__member__,__max__); \
	__max__ = __max__ * 11 / 10 + 4; __max__ &= ~0x3; \
	m_ChartWnd.SetChartFromToValue(0,(float)__max__,4); }

#define STAT_FIND_AVG_MAX(__member__,__member2__,__max__) { \
	long __max__ = GET_AVG(m_PastHourStat,__member__,__member2__); \
	__max__ = GET_MAX(GET_AVG(m_Past4HoursStat,__member__,__member2__),__max__); \
	__max__ = GET_MAX(GET_AVG(m_Past8HoursStat,__member__,__member2__),__max__); \
	__max__ = GET_MAX(GET_AVG(m_Past24HoursStat,__member__,__member2__),__max__); \
	__max__ = GET_MAX(GET_AVG(m_PastWeekStat,__member__,__member2__),__max__); \
	__max__ = GET_MAX(GET_AVG(m_FullStat,__member__,__member2__),__max__); \
	__max__ = __max__ * 11 / 10 + 4; __max__ &= ~0x3; \
	m_ChartWnd.SetChartFromToValue(0,(float)__max__,4); }

#define STAT_ADD_PLOTS(__member__) \
	STAT_FIND_MAX(__member__,_Max); \
	m_ChartWnd.Flush(); \
	m_ChartWnd.AddChartItem("Past Hour",m_PastHourStat.__member__,RGB(0,0,128),3); \
	m_ChartWnd.AddChartItem("Past 4 Hours",m_Past4HoursStat.__member__,RGB(128,0,0),3); \
	m_ChartWnd.AddChartItem("Past 8 Hours",m_Past8HoursStat.__member__,RGB(0,128,0),3); \
	m_ChartWnd.AddChartItem("Past 24 Hours",m_Past24HoursStat.__member__,RGB(0,0,0),3); \
	m_ChartWnd.AddChartItem("Past Week",m_PastWeekStat.__member__,RGB(0,128,128),3); \
	m_ChartWnd.AddChartItem("Forever",m_FullStat.__member__,RGB(128,128,0),3); \
	m_ChartWnd.ReCalculating(); \
	m_ChartWnd.RefreshWindow();

#define STAT_ADD_AVG_PLOTS(__member__,__member_div__) \
	STAT_FIND_AVG_MAX(__member__,__member_div__,_Max); \
	m_ChartWnd.Flush(); \
	m_ChartWnd.AddChartItem("Past Hour",GET_AVG(m_PastHourStat,__member__,__member_div__),RGB(0,0,128),3); \
	m_ChartWnd.AddChartItem("Past 4 Hours",GET_AVG(m_Past4HoursStat,__member__,__member_div__),RGB(128,0,0),3); \
	m_ChartWnd.AddChartItem("Past 8 Hours",GET_AVG(m_Past8HoursStat,__member__,__member_div__),RGB(0,128,0),3); \
	m_ChartWnd.AddChartItem("Past 24 Hours",GET_AVG(m_Past24HoursStat,__member__,__member_div__),RGB(0,0,0),3); \
	m_ChartWnd.AddChartItem("Past Week",GET_AVG(m_PastWeekStat,__member__,__member_div__),RGB(0,128,128),3); \
	m_ChartWnd.AddChartItem("Forever",GET_AVG(m_FullStat,__member__,__member_div__),RGB(128,128,0),3); \
	m_ChartWnd.ReCalculating(); \
	m_ChartWnd.RefreshWindow();

/////////////////////////////////////////////////////////////////////////////
// CStatDialog dialog


CStatDialog::CStatDialog(CWnd* pParent /*=NULL*/)
	: CDialog(CStatDialog::IDD, pParent)
{
	//{{AFX_DATA_INIT(CStatDialog)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CStatDialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CStatDialog)
	DDX_Control(pDX, IDC_USER, m_UserList);
	DDX_Control(pDX, IDC_GROUP, m_GroupList);
	DDX_Control(pDX, IDC_GRAPHTAB, m_GraphTab);
	//}}AFX_DATA_MAP

      DDX_Control(pDX, IDC_GRAPH, m_ChartWnd);
}


BEGIN_MESSAGE_MAP(CStatDialog, CDialog)
	//{{AFX_MSG_MAP(CStatDialog)
	ON_NOTIFY(TCN_SELCHANGE, IDC_GRAPHTAB, OnSelchangeGraphtab)
	ON_CBN_SELCHANGE(IDC_GROUP, OnSelchangeGroup)
	ON_CBN_SELCHANGE(IDC_USER, OnSelchangeUser)
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStatDialog message handlers

BOOL CStatDialog::OnInitDialog() 
{
	CDialog::OnInitDialog();

//	m_Graph.SubclassWindow( GetDlgItem(IDC_GRAPH)->m_hWnd );

#if(0)
	RECT CtrlRect, DlgRect;

	GetDlgItem(IDC_GRAPH)->GetWindowRect(&CtrlRect);
	GetDlgItem(IDC_GRAPH)->DestroyWindow();
	GetWindowRect(&DlgRect);

	CRect NewRect = CtrlRect;
	NewRect.OffsetRect(-CRect(DlgRect).TopLeft());

	m_Graph.Create("LINE_CHART_CTRL", "", WS_VISIBLE | WS_CHILD, 
		NewRect, this, IDC_GRAPH);
	
	m_Graph.Add(RGB(0,255,0),100, 0, "Connections");
#endif

#if (_MFC_VER > 0x0421)
	m_GraphTab.InsertItem(0, "Logins");
	m_GraphTab.InsertItem(1, "Login Duration");
	m_GraphTab.InsertItem(2, "Login Duration Avg.");
	m_GraphTab.InsertItem(3, "Password Failures");
	m_GraphTab.InsertItem(4, "Download Count");
	m_GraphTab.InsertItem(5, "Download Size");
	m_GraphTab.InsertItem(6, "Download Duration");
	m_GraphTab.InsertItem(7, "Upload Count");
	m_GraphTab.InsertItem(8, "Upload Size");
	m_GraphTab.InsertItem(9, "Upload Duration");
#else
	TC_ITEM tcItem;
	tcItem.mask = TCIF_TEXT;
	tcItem.pszText = "Logins";
	m_GraphTab.InsertItem(0, &tcItem);
	tcItem.pszText = "Login Duration";
	m_GraphTab.InsertItem(1, &tcItem);
	tcItem.pszText = "Login Duration Avg.";
	m_GraphTab.InsertItem(2, &tcItem);
	m_GraphTab.InsertItem(3, &tcItem);
	m_GraphTab.InsertItem(4, &tcItem);
	m_GraphTab.InsertItem(5, &tcItem);
	m_GraphTab.InsertItem(6, &tcItem);
	m_GraphTab.InsertItem(7, &tcItem);
	m_GraphTab.InsertItem(8, &tcItem);
	m_GraphTab.InsertItem(9, &tcItem);
#endif

//	CImageList* ImageList = new CImageList();
//    ImageList->Create(MAKEINTRESOURCE(IDB_BITMAP_2), 22, 1, RGB(192,192,192));
//	m_ChartWnd.SetImageList(ImageList);

	m_ChartWnd.SetUserColTitle("Logins");

	m_StatCallback(&m_FullStat, -1, "", "", &m_GroupArray, &m_UserArray);
	FillUserGroupList();
	GetStats(m_User, m_Group);
	STAT_ADD_PLOTS(LoginCount);

    m_ChartWnd.EnableTitleTips();

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CStatDialog::GetStats(LPCSTR user, LPCSTR group)
{
	m_StatCallback(&m_FullStat, -1, user, group, 0, 0);
	m_StatCallback(&m_PastWeekStat, 24*7, user, group, 0, 0);
	m_StatCallback(&m_Past24HoursStat, 24, user, group, 0, 0);
	m_StatCallback(&m_Past8HoursStat, 8, user, group, 0, 0);
	m_StatCallback(&m_Past4HoursStat, 4, user, group, 0, 0);
	m_StatCallback(&m_PastHourStat, 1, user, group, 0, 0);
}

void CStatDialog::OnSelchangeGraphtab(NMHDR* pNMHDR, LRESULT* pResult) 
{
	UpdatePlots();
	
	*pResult = 0;
}

void CStatDialog::OnOK() 
{
	CDialog::OnOK();

	DestroyWindow();
}

void CStatDialog::FillUserGroupList()
{
	int Index;
	m_GroupList.AddString("<<ALL>>");
	m_UserList.AddString("<<ALL>>");
	for (Index = 0 ; Index < m_GroupArray.GetSize() ; Index++)
		m_GroupList.AddString(m_GroupArray.GetAt(Index));
	for (Index = 0 ; Index < m_UserArray.GetSize() ; Index++)
		m_UserList.AddString(m_UserArray.GetAt(Index));

	if (m_GroupList.GetCurSel() < 0)
		m_GroupList.SetCurSel(0);
	if (m_UserList.GetCurSel() < 0)
		m_UserList.SetCurSel(0);
}


void CStatDialog::OnSelchangeGroup() 
{
	m_GroupList.GetLBText(m_GroupList.GetCurSel(), m_Group);
	if (m_Group.CompareNoCase("<<ALL>>") == 0)
		m_Group = "";
	UpdatePlots();
}

void CStatDialog::OnSelchangeUser() 
{
	m_UserList.GetLBText(m_UserList.GetCurSel(), m_User);
	if (m_User.CompareNoCase("<<ALL>>") == 0)
		m_User = "";
	UpdatePlots();
}

void CStatDialog::UpdatePlots()
{
	GetStats(m_User, m_Group);

	switch (m_GraphTab.GetCurSel())
	{
	default:
	case 0:
		m_ChartWnd.SetUserColTitle("Logins");
		STAT_ADD_PLOTS(LoginCount);
		break;
	case 1: /* Total connect time */
		m_ChartWnd.SetUserColTitle("Seconds");
		STAT_ADD_PLOTS(ConnectionDuration);
		break;
	case 2: /* Average connect time */
		m_ChartWnd.SetUserColTitle("Seconds");
		STAT_ADD_AVG_PLOTS(ConnectionDuration,ConnectionCount);
		break;
	case 3: 
		m_ChartWnd.SetUserColTitle("Failures");
		STAT_ADD_PLOTS(WrongPassCount);
		break;
	case 4:
		m_ChartWnd.SetUserColTitle("Count");
		STAT_ADD_PLOTS(DownloadCount);
		break;
	case 5:
		m_ChartWnd.SetUserColTitle("Size (kb)");
		STAT_ADD_PLOTS(DownloadKilobytes);
		break;
	case 6:
		m_ChartWnd.SetUserColTitle("Seconds");
		STAT_ADD_PLOTS(DownloadDuration);
		break;
	case 7:
		m_ChartWnd.SetUserColTitle("Count");
		STAT_ADD_PLOTS(UploadCount);
		break;
	case 8:
		m_ChartWnd.SetUserColTitle("Size (kb)");
		STAT_ADD_PLOTS(UploadKilobytes);
		break;
	case 9:
		m_ChartWnd.SetUserColTitle("Seconds");
		STAT_ADD_PLOTS(UploadDuration);
		break;
	}
}

void CStatDialog::OnClose() 
{
	CDialog::OnClose();

	DestroyWindow();
}
