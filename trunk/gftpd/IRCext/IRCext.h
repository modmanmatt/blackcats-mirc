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


// IRCext.h : main header file for the IRCEXT DLL
//

#if !defined(AFX_IRCEXT_H__459F129D_F127_11D2_AE89_004F49069218__INCLUDED_)
#define AFX_IRCEXT_H__459F129D_F127_11D2_AE89_004F49069218__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols
#include "DebugDlg.h"	// Added by ClassView
#include "IRCClient.h"	// Added by ClassView
#include "afxtempl.h"	// Added by ClassView

/////////////////////////////////////////////////////////////////////////////
// CIRCextApp
// See IRCext.cpp for the implementation of this class
//

typedef CArray<CString,CString> CChannelArray;

class CIRCextApp : public CWinApp
{
public:
	CIRCClient m_IRCClient;
	CChannelArray m_CurrentChannels;
//	CWinThread *Thread;
	CDebugDlg m_DebugDlg;
	HANDLE Thread;
	DWORD ThreadID;
	HANDLE Mutex;
	BOOL ThreadDone;

	CIRCextApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CIRCextApp)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	//}}AFX_VIRTUAL

	//{{AFX_MSG(CIRCextApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_IRCEXT_H__459F129D_F127_11D2_AE89_004F49069218__INCLUDED_)
