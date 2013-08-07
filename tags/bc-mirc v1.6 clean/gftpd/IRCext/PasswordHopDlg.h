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


#if !defined(AFX_PASSWORDHOPDLG_H__DE90E880_1B13_11D3_832B_004F49069218__INCLUDED_)
#define AFX_PASSWORDHOPDLG_H__DE90E880_1B13_11D3_832B_004F49069218__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// PasswordHopDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CPasswordHopDlg dialog

class CPasswordHopDlg : public CDialog
{
// Construction
public:
	CPasswordHopDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CPasswordHopDlg)
	enum { IDD = IDD_PASSWORD_HOP };
	CListCtrl	m_AccountList;
	CEdit	m_Account;
	int		m_Rate;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPasswordHopDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CPasswordHopDlg)
	afx_msg void OnUpdate();
	afx_msg void OnRemove();
	afx_msg void OnAdd();
	afx_msg void OnClose();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PASSWORDHOPDLG_H__DE90E880_1B13_11D3_832B_004F49069218__INCLUDED_)
