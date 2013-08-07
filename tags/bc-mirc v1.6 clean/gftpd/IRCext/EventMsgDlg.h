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


#if !defined(AFX_EVENTMSGDLG_H__4D6C68BC_8318_47AE_8590_0D45BD5E62BB__INCLUDED_)
#define AFX_EVENTMSGDLG_H__4D6C68BC_8318_47AE_8590_0D45BD5E62BB__INCLUDED_

#include "IrcEdit.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// EventMsgDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CEventMsgDlg dialog

class CEventMsgDlg : public CDialog
{
// Construction
public:
	CEventMsgDlg(CWnd* pParent = NULL);   // standard constructor
	void (*m_OnOkCallback)(void);

// Dialog Data
	//{{AFX_DATA(CEventMsgDlg)
	enum { IDD = IDD_EVENT_MSG };
	CString	m_DownloadChannels;
	CString	m_LoginChannels;
	CString	m_LogoutChannels;
	CString	m_UploadChannels;
	CString	m_DownloadMsg;
	CString	m_LoginMsg;
	CString	m_LogoutMsg;
	CString	m_UploadMsg;
	CString	m_MakeDirChannels;
	CString	m_MakeDirMsg;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEventMsgDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	CIrcEdit m_LoginEdit;
	CIrcEdit m_LogoutEdit;
	CIrcEdit m_DownloadEdit;
	CIrcEdit m_UploadEdit;
	CIrcEdit m_MakeDirEdit;

	// Generated message map functions
	//{{AFX_MSG(CEventMsgDlg)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnClose();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_EVENTMSGDLG_H__4D6C68BC_8318_47AE_8590_0D45BD5E62BB__INCLUDED_)
