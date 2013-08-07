menu menubar {
  BC PC Tools
  .FileZilla
  ..Launch FileZilla FTP:/run $mircdirfilezilla\filezilla.exe
  .-
  .Utorrent
  ..Utorrent Launch :run C:/mirc_server/Addons/Utorrent/utorrent-1.6.1-beta-build-483.exe
  ..Easy Setup Guide :run C:/mirc_server/Addons/uTorrent/Easy Setup Guide.txt
  ..Utorrent Website :/run http://www.utorrent.com/
  .-
  .Verify files: set -u1 %sfv $dir="Select SFV file to verify" $getdir*.sfv | if (%sfv != $null) run $mircdirtools\pdsfv\pdsfv $shortfn(%sfv)
  .Make SFV: run $mircdirtools\pdsfv\pdsfv.exe
  .Unrar iso/files: { 
    set %rar $dir="Select Any Packed file to unpack" $getdir*.*
    if (%rar != $null) { 
      set %unpackdir $sdir($nofile(%rar),-- Select directory for unpack this file) 
    }
    if (%unpackdir != $null) {
      run $mircdirtools\unrar e $shortfn(%rar) $shortfn(%unpackdir)
    }
    .timerunset 1 2 { unset %rar | unset %unpackdir }
  }
  .Read Nfo: set -u1 %nfo $dir="Select NFO file to read" $getdir*.nfo | if (%nfo != $null) run $mircdirtools\nfoviewer\nfoviewer $shortfn(%nfo)
  .EA boot Fixing:run $mircdirtools\adr\adr_patcher.exe
  .PPF Patcher:run $mircdirtools\ppf\ppf-o-matic3.exe
  ;.libmad MPEG audio Player
  ;..0.1 beta: /echo MPEG [1,2,2.5] layer [1,2,3] player using libmad - CTRL-C to stop
  ;..-
  ;..Play: set %mp3 $dir="Select a MPEG audio file" $mp3fileget(%mp3dirplay) | if (%mp3 != $null) run $mircdirtools\madplay\madplay -Q $shortfn(%mp3)
  .Burn CD
  ..BIN/CUE: set -u1 %cue $dir="Select CUE file to burn" $getdir*.cue | if (%cue != $null) run $mircdirtools\burning\fireburner\fireburner $shortfn(%cue)
  ..ISO: set -u1 %iso $dir="Select ISO file to burn" $getdir*.iso | if (%iso != $null) run $mircdirtools\burning\fireburner\fireburner $shortfn(%iso)
  ..-
  ..Register Fireburner:run regedit /s $mircdirtools\burning\fireburner\fireburner_key_reg.reg
  .-
  .Port scanner:/portscanip
  .Ip to Nick:/zmodem.ipc
  .-
  .$iif($script(gftpdr1.mrc) == $null,Load GuildFTPD,$null):/load -rs gftpd\gftpd.mrc
  .$iif($script(gftpdr1.mrc) != $null,GuildFTPD,$null)
  ..Configure:GFTPDCustomize
  ..Help
  ...Popups Help:GFTPDHelp.win gftpd\popups.help
  ...Colors Configure Window: GFTPDHelp.win gftpd\colors.help
  ...Port Configure Window: GFTPDHelp.win gftpd\ports.help
  ...Main Configure Window: GFTPDHelp.win gftpd\config.help
  ...Variable Help: GFTPDHelp.win gftpd\var.help
  ..-
  ..Re-Open Lost @GuildFTPD Window:GFTPDWinOpen
  ..Start GuildFTPD :{ run $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDdir $+ guildftpd.exe }
  ..-
  ..Unload GFTPDScripts: { unload -as gftpd\gftpda1.ini | unload -rs gftpd\gftpdr1.mrc }
  .-
}
