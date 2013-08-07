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


#if !defined(AFX_CONFIGUREDLG_H__1679BD46_F354_11D2_AE8A_004F49069218__INCLUDED_)
#define AFX_CONFIGUREDLG_H__1679BD46_F354_11D2_AE8A_004F49069218__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ConfigureDlg.h : header file
//

#include "afxtempl.h"
#include "IrcEdit.h"	// Added by ClassView

class CAdInfo
{
public:
	CAdInfo(){};
	~CAdInfo(){};

	CString TriggerAd;
	CString TriggerText;
	CString Ad;
	CString Channels;
	UINT Timer;
	UINT Enable;
};

typedef CArray<CAdInfo,CAdInfo> CAdInfoArray;

/////////////////////////////////////////////////////////////////////////////
// CConfigureDlg dialog

class CConfigureDlg : public CDialog
{
// Construction
public:
	CIrcEdit m_TriggerAd;
	CIrcEdit m_Ad;
	void SetAdPtr(CAdInfoArray* Ads, HANDLE Mutex){m_AdPtr = Ads; m_AdInfoMutex = Mutex;};
	void (*m_OnOkCallback)(void);

	CConfigureDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CConfigureDlg)
	enum { IDD = IDD_CONFIGUREDLG_DIALOG };
	CEdit	m_TriggerText;
	CButton	m_Enable;
	CEdit	m_Timer;
	CEdit	m_Channels;
	CListCtrl	m_TimerList;
	CString	m_User;
	CString	m_Nick;
	BOOL	m_GlobalEnable;
	CString	m_ServerList;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CConfigureDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	void SetData();
	void GetData();
	CAdInfoArray *m_AdPtr;
	HANDLE m_AdInfoMutex;

	// Generated message map functions
	//{{AFX_MSG(CConfigureDlg)
	afx_msg void OnAdd();
	afx_msg void OnRemove();
	virtual BOOL OnInitDialog();
	afx_msg void OnClickTimerlist(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnUpdate();
	virtual void OnOK();
	afx_msg void OnClose();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONFIGUREDLG_H__1679BD46_F354_11D2_AE8A_004F49069218__INCLUDED_)
