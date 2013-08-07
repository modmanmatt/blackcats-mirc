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


// StatDataStruct.cpp: implementation of the CStatDataStruct class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "stats.h"
#include "StatDataStruct.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CStatDataStruct::CStatDataStruct()
{
	Clear();
}

CStatDataStruct::~CStatDataStruct()
{

}

void CStatDataStruct::Clear()
{
	ConnectionCount = 0;
	LoginCount = 0;
	ConnectionDuration = 0;
	WrongPassCount = 0;
	TooManyCount = 0;

	BannedCount = 0;

	UploadCount = 0;
	DownloadCount = 0;
	UploadKilobytes = 0;
	DownloadKilobytes = 0;
	UploadDuration = 0;
	DownloadDuration = 0;

	User = "";
	Group = "";
}

CStatDataStruct CStatDataStruct::operator =(CStatDataStruct &ref)
{
	ConnectionCount = ref.ConnectionCount;
	LoginCount = ref.LoginCount;
	ConnectionDuration = ref.ConnectionDuration;
	WrongPassCount = ref.WrongPassCount;
	TooManyCount = ref.TooManyCount;

	BannedCount = ref.BannedCount;

	UploadCount = ref.UploadCount;
	DownloadCount = ref.DownloadCount;
	UploadKilobytes = ref.UploadKilobytes;
	DownloadKilobytes = ref.DownloadKilobytes;
	UploadDuration = ref.UploadDuration;
	DownloadDuration = ref.DownloadDuration;

	User = ref.User;
	Group = ref.Group;

	return *this;
}

CStatDataStruct CStatDataStruct::operator +=(CStatDataStruct &ref)
{
	ConnectionCount += ref.ConnectionCount;
	LoginCount += ref.LoginCount;
	ConnectionDuration += ref.ConnectionDuration;
	WrongPassCount += ref.WrongPassCount;
	TooManyCount += ref.TooManyCount;

	BannedCount += ref.BannedCount;

	UploadCount += ref.UploadCount;
	DownloadCount += ref.DownloadCount;
	UploadKilobytes += ref.UploadKilobytes;
	DownloadKilobytes += ref.DownloadKilobytes;
	UploadDuration += ref.UploadDuration;
	DownloadDuration += ref.DownloadDuration;

	return *this;
}
