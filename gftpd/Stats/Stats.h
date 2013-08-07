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


// Stats.h : main header file for the STATS DLL
//

#if !defined(AFX_STATS_H__FD767628_D577_11D3_986D_0008C702F22F__INCLUDED_)
#define AFX_STATS_H__FD767628_D577_11D3_986D_0008C702F22F__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CStatsApp
// See Stats.cpp for the implementation of this class
//

class CStatsApp : public CWinApp
{
public:
	CStatsApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStatsApp)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	//}}AFX_VIRTUAL

	//{{AFX_MSG(CStatsApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STATS_H__FD767628_D577_11D3_986D_0008C702F22F__INCLUDED_)
