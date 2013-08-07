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


// StatDataStruct.h: interface for the CStatDataStruct class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_STATDATASTRUCT_H__F905FE00_E0FB_49F9_B03A_C193817D450F__INCLUDED_)
#define AFX_STATDATASTRUCT_H__F905FE00_E0FB_49F9_B03A_C193817D450F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CStatDataStruct  
{
public:
	CStatDataStruct();
	virtual ~CStatDataStruct();

	CStatDataStruct operator = (CStatDataStruct &ref);
	CStatDataStruct operator += (CStatDataStruct &ref);

	void Clear();

	long ConnectionCount;
	long LoginCount;
	long ConnectionDuration;
	long WrongPassCount;
	long TooManyCount;

	long BannedCount;

	long UploadCount;
	long DownloadCount;
	long UploadKilobytes;
	long DownloadKilobytes;
	long UploadDuration;
	long DownloadDuration;

	CString User;
	CString Group;
};

#endif // !defined(AFX_STATDATASTRUCT_H__F905FE00_E0FB_49F9_B03A_C193817D450F__INCLUDED_)
