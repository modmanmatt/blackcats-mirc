# Microsoft Developer Studio Project File - Name="IRCext" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=IRCext - Win32 Debug BoundsChecker
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "IRCext.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "IRCext.mak" CFG="IRCext - Win32 Debug BoundsChecker"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "IRCext - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "IRCext - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "IRCext - Win32 Debug BoundsChecker" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "IRCext - Win32 Release"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_WINDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /I "..\api" /I "." /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_WINDLL" /D "_MBCS" /D "_USRDLL" /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 ..\api\gsock.lib /nologo /subsystem:windows /dll /map /machine:I386 /out:"../Release/IRCext.dll" /ALIGN:4096
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "IRCext - Win32 Debug"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_WINDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /I "..\api" /I "." /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_WINDLL" /D "_MBCS" /D "_USRDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 ..\api\gsockd.lib /nologo /subsystem:windows /dll /map /debug /machine:I386 /out:"../Debug/IRCext.dll" /pdbtype:sept

!ELSEIF  "$(CFG)" == "IRCext - Win32 Debug BoundsChecker"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "IRCext___Win32_Debug_BoundsChecker"
# PROP BASE Intermediate_Dir "IRCext___Win32_Debug_BoundsChecker"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "IRCext___Win32_Debug_BoundsChecker"
# PROP Intermediate_Dir "IRCext___Win32_Debug_BoundsChecker"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_WINDLL" /D "_MBCS" /D "_USRDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "..\api" /I "." /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_WINDLL" /D "_MBCS" /D "_USRDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /dll /debug /machine:I386 /out:"../Debug/IRCext.dll" /pdbtype:sept
# ADD LINK32 ..\rawsocket\obj\debug\gsock.lib /nologo /subsystem:windows /dll /debug /machine:I386 /out:"../Debug/IRCext.dll" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "IRCext - Win32 Release"
# Name "IRCext - Win32 Debug"
# Name "IRCext - Win32 Debug BoundsChecker"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\ConfigureDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\DebugDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\EventMsgDlg.cpp
# End Source File
# Begin Source File

SOURCE=..\api\GFtpAPI.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\IRCClient.cpp
# End Source File
# Begin Source File

SOURCE=.\IrcEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\IRCext.cpp
# End Source File
# Begin Source File

SOURCE=.\IRCext.def
# End Source File
# Begin Source File

SOURCE=.\IRCext.rc
# End Source File
# Begin Source File

SOURCE=.\KickRulesDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\OutputWnd.cpp
# End Source File
# Begin Source File

SOURCE=.\PasswordHopDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\RawSocket.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\ConfigureDlg.h
# End Source File
# Begin Source File

SOURCE=.\DebugDlg.h
# End Source File
# Begin Source File

SOURCE=.\EventMsgDlg.h
# End Source File
# Begin Source File

SOURCE=..\api\GFtpAPI.h
# End Source File
# Begin Source File

SOURCE=.\IRCClient.h
# End Source File
# Begin Source File

SOURCE=.\IRCdefines.h
# End Source File
# Begin Source File

SOURCE=.\IrcEdit.h
# End Source File
# Begin Source File

SOURCE=.\IRCext.h
# End Source File
# Begin Source File

SOURCE=.\KickRulesDlg.h
# End Source File
# Begin Source File

SOURCE=.\OutputWnd.h
# End Source File
# Begin Source File

SOURCE=.\PasswordHopDlg.h
# End Source File
# Begin Source File

SOURCE=..\api\PlugInTypes.h
# End Source File
# Begin Source File

SOURCE=.\RawSocket.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\IRCext.rc2
# End Source File
# End Group
# End Target
# End Project
