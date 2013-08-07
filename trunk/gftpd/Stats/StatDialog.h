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


#if !defined(AFX_STATDIALOG_H__F6627CEF_49DE_4731_A966_4F807181574F__INCLUDED_)
#define AFX_STATDIALOG_H__F6627CEF_49DE_4731_A966_4F807181574F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StatDialog.h : header file
//

#include "ChartWnd.h"
#include "StatDataStruct.h"

/////////////////////////////////////////////////////////////////////////////
// CStatDialog dialog

class CStatDialog : public CDialog
{
// Construction
public:
	CStringArray m_UserArray;
	CStringArray m_GroupArray;
	CStatDialog(CWnd* pParent = NULL);   // standard constructor

	CChartWnd m_ChartWnd;
	
	void (*m_StatCallback)(CStatDataStruct *, long, LPCSTR, LPCSTR, CStringArray*, CStringArray*);
	CString m_User;
	CString m_Group;

	CStatDataStruct m_FullStat;
	CStatDataStruct m_PastWeekStat;
	CStatDataStruct m_Past24HoursStat;
	CStatDataStruct m_Past8HoursStat;
	CStatDataStruct m_Past4HoursStat;
	CStatDataStruct m_PastHourStat;

	void GetStats(LPCSTR user, LPCSTR group);
// Dialog Data
	//{{AFX_DATA(CStatDialog)
	enum { IDD = IDD_STAT_DIALOG };
	CComboBox	m_UserList;
	CComboBox	m_GroupList;
	CTabCtrl	m_GraphTab;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStatDialog)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	void UpdatePlots();
	void FillUserGroupList();

	// Generated message map functions
	//{{AFX_MSG(CStatDialog)
	virtual BOOL OnInitDialog();
	afx_msg void OnSelchangeGraphtab(NMHDR* pNMHDR, LRESULT* pResult);
	virtual void OnOK();
	afx_msg void OnSelchangeGroup();
	afx_msg void OnSelchangeUser();
	afx_msg void OnClose();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STATDIALOG_H__F6627CEF_49DE_4731_A966_4F807181574F__INCLUDED_)
