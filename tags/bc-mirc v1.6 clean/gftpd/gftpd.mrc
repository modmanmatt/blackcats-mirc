;;;GuildFTPD install/reinstall Script ver 0.998-2.0.5 by EZJohnson
;;;Questions/Comments visit http://www.guildftpd.com

on *:load: {
  if ($version < 6) {
  echo -s FATAL ERROR! you are installing on mIRC Version $version
  echo -s This Script will not function correctly under 5.x versions of mIRC
  echo -s Please upgrade your mIRC and try installing again
  echo -s *** Installation Halted ***
  halt   
  }
  elseif ($version < 6.01) { 
  echo -s WARNING! you are installing on mIRC Version $version
  echo -s Certain portions of the scripts may not function correctly
  echo -s under mIRC prior to 6.01, it is recommended you upgrade
  }
  set %zzGFTPDAdBackup %GFTPad
  if (%GFTPDddename == $null) { set %GFTPDddename GuildFTPd }
  set %zzGFTPDddename %GFTPDddename
  unset %GFTP*
  set %GFTPad %zzGFTPDAdBackup
  unset %zzGFTPDAdBackup
  set %GFTPDddename %zzGFTPDddename
  unset %zzGFTPDddename
  writeini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename %GFTPDddename
  if ($exists(Gftpd\stats.txt) == $false) { .write -c Gftpd\stats.txt }
  if ($exists(Gftpd\gftpd.users) == $false) { .write -c Gftpd\gftpd.users }

    if ($script(Gftpd/gftpdr1.mrc) == $null) {
   .load -rs Gftpd/gftpdr1.mrc
  }
  if ($script(Gftpd/gftpdr1.mrc) != $null) {
   .unload -rs Gftpd/gftpdr1.mrc
   .load -rs Gftpd/gftpdr1.mrc
  }
  if ($script(Gftpd/gftpda1.mrc) == $null) {
   .load -as Gftpd/gftpda1.ini
  }
  if ($script(Gftpd/gftpda1.mrc) != $null) {
   .unload -as Gftpd/gftpda1.ini
   .load -as Gftpd/gftpda1.ini
  }
  GFTPDfirstload
  .unload -rs gftpd.mrc
}
