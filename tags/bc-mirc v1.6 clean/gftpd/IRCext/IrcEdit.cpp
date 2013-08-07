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


// IrcEdit.cpp : implementation file
//

#include "stdafx.h"
#include "ircext.h"
#include "IrcEdit.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CIrcEdit

CIrcEdit::CIrcEdit()
{
	m_ColorEdit = false;
}

CIrcEdit::~CIrcEdit()
{
}


BEGIN_MESSAGE_MAP(CIrcEdit, CEdit)
	//{{AFX_MSG_MAP(CIrcEdit)
	ON_WM_CHAR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CIrcEdit message handlers

void CIrcEdit::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	switch (nChar)
	{
	case 0x0b:
		{
			CString new_text(0x03, nRepCnt);
			ReplaceSel(new_text, TRUE);
			m_ColorEdit = true;
		}
		break;
	case VK_SPACE:
		CEdit::OnChar(nChar, nRepCnt, nFlags);
	case VK_ESCAPE:
		m_ColorEdit = false;
		break;
	default:
		CEdit::OnChar(nChar, nRepCnt, nFlags);
		break;
	}
}
