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


#if !defined(AFX_IRCEDIT_H__07B6C8FB_34F3_4465_BAAB_362479BB4D68__INCLUDED_)
#define AFX_IRCEDIT_H__07B6C8FB_34F3_4465_BAAB_362479BB4D68__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// IrcEdit.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CIrcEdit window

class CIrcEdit : public CEdit
{
// Construction
public:
	CIrcEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CIrcEdit)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CIrcEdit();

	// Generated message map functions
protected:
	bool m_ColorEdit;
	//{{AFX_MSG(CIrcEdit)
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_IRCEDIT_H__07B6C8FB_34F3_4465_BAAB_362479BB4D68__INCLUDED_)
