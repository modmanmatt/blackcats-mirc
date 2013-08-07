;;;GuildFTPD Script ver 0.998-2.0.5 by EZJohnson
;;;Dialog design by EZJohnson and MrLitil
;;;Questions/Comments visit http://www.guildftpd.com

;;;################################################EVENTS##########################################################
on *:load: { .disable #showdns }

on *:start: {
  GFTPDWinOpen
  %GFTPDddename = $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename
  .write -c Gftpd\stats.txt clean
  .write -d Gftpd\stats.txt
}

#GFTPDwho off
raw 352:*: { haltdef }

raw 315:*: { 
  haltdef
  .disable #GFTPDwho
}
#GFTPDwho end

on *:connect: { 
  GFTPDStart
  %GFTPDddename = $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename
}

on *:nick: { 
  %GFTPChan1 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan1))
  %GFTPChan2 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan2))
  %GFTPChan3 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan3))
  %GFTPChan4 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan4))
  %GFTPChan5 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan5))
  %GFTPChan6 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan6))
  %GFTPChan7 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan7))
  %GFTPChan8 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan8))
  %GFTPChan9 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan9))
  %GFTPChan10 = $GFTPDncsplit(chan,$readini(Gftpd/Gftpd.ini,GFTPDDlg,Chan10))
  if ($newnick ison %GFTPChan1) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan2) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan3) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan4) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan5) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan6) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan7) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan8) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan9) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  elseif ($newnick ison %GFTPChan10) && ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
    dline -l @GuildFTPD $GFTPDgetline(@GuildFTPD,$nick,1) 
    aline -ln @GuildFTPD $newnick 
  } 
  unset %GFTPChan*
  unset %GFTPcntr
}

on *:quit: {
  if ($readini(gftpd\gftpd.ini,gftpddlg,graceperiod) != $null) && ($readini(gftpd\gftpd.ini,gftpddlg,graceperiod) != 0) {
    if ($GFTPDgetline(@GuildFTPD,$nick,1) != $null) {
      write gftpd\gftpd.users $gettok($line(@GuildFTPD,$GFTPDgetline(@GuildFTPD,$nick,1),1),3-6,32)
      .timer 1 $readini(gftpd\gftpd.ini,gftpddlg,graceperiod) write -ds $+ $gettok($line(@GuildFTPD,$GFTPDgetline(@GuildFTPD,$nick,1),1),3-6,32) gftpd\gftpd.users
    }
  }
}

ctcp *:*:*: {
  %GFTPInfoColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg InfoColor
  %GFTPNickColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg NickColor
  if ($1 == $GFTPDstats) && ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDstatsenable) == 1) {
    gftpdlog GFTPDstats: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor stats
    .msg $nick [Current Identified Users]: $gn
    .msg $nick [Total Users]: $gt [Total Download]: $gd [Total Upload]: $gu [Total Aggregate Bandwidth]: $gb 
    .msg $nick $ezdisks
  }
  if ($1 == $GFTPDadmin) && ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadminenable) == 1) {
    gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor chat
    dcc chat $nick
    set %GFTPDAdminNick $nick
  }
  unset %GFTPInfoColor
  unset %GFTPNickColor
}

on *:open:=: {
  %GFTPInfoColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg InfoColor
  %GFTPNickColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg NickColor
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadminenable) == 1) && ($nick == %GFTPDAdminNick) {
    gftpdlog Remote Admin: $+ %GFTPNickColor $nick chat $+ %GFTPInfoColor established
    .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) Type $+ %GFTPInfoColor .gftpdhelp for list of commands
  }
  unset %GFTPInfoColor
  unset %GFTPNickColor
}

on *:chat:*: {
  %GFTPInfoColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg InfoColor
  %GFTPNickColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg NickColor
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadminenable) == 1) && ($nick == %GFTPDAdminNick) {
    if ($1 == .gftpdhelp) {
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) List of commands:
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93)  $+ %GFTPInfoColor .users - list users on ftpd
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93)  $+ %GFTPInfoColor .kick - kick user
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93)  $+ %GFTPInfoColor .ban - ban user
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93)  $+ %GFTPInfoColor .bans - list bans
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93)  $+ %GFTPInfoColor .unban - unban ip
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93)  $+ %GFTPInfoColor .quit - close chat securely
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) End of commands
    }
    if ($1 == .quit) {
      gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor $1
      unset %GFTPDAdminNick
      close -c $nick
    }
    if ($1 == .users) {
      gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor $1
      set %gftptemplines $line(@guildftpd,0,1)
      if (%gftptemplines == 0) {
        unset %gftptemplines
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) No Users Online
        return
      }
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) %gftptemplines Users Online:
      while (%gftptemplines > 0) {
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) User $chr(35) $+ %gftptemplines  $+ %GFTPInfoColor $line(@guildftpd,%gftptemplines,1)
        dec %gftptemplines
      }
      unset %gftptemplines
    }
    if ($1 == .bans) {
      gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor $1
      set %GFTPcntr 1
      %GFTPbfile = $readini Gftpd/Gftpd.ini GFTPDDlg BanFile
      set %GFTPip $read -l $+ %GFTPcntr %GFTPbfile
      if (%GFTPip == $null) {
        unset %gftpip
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) There are no bans
        return
      }
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) $lines(%GFTPbfile) Bans:
      :readbansloop
      if (%GFTPip != $null) {
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) Ban $chr(35) $+ %GFTPcntr ip: $+ %GFTPInfoColor $gettok(%GFTPip,1,58) time: $+ %GFTPInfoColor $gettok(%GFTPip,2,58) mins
        inc %GFTPcntr 1
        set %GFTPip $read -l $+ %GFTPcntr %GFTPbfile
        goto readbansloop
      }
      unset %GFTPbfile
      unset %GFTPcntr
      unset %GFTPip
    }
    if ($1 == .kick) {
      if ($2 == $null) { 
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) Usage: $+ %GFTPInfoColor .kick <nick|ip> <msg>
        return
      }
      gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor $1 $2 with reason: $+ %GFTPInfoColor $3-
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) kicking $+ %GFTPInfoColor $2 with msg $+ %GFTPInfoColor $3-
      gftpdkick $2-
    }
    if ($1 == .ban) {
      if ($3 == $null) { 
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) Usage: $+ %GFTPInfoColor .ban <nick|ip> <time in mins> <msg>
        return
      }
      gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor $1 $2 for $+ %GFTPInfoColor $3 mins with reason: $+ %GFTPInfoColor $4-
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) banning $+ %GFTPInfoColor $2 for $+ %GFTPInfoColor $3 mins with msg $+ %GFTPInfoColor $4-
      gftpdban $2-
    }
    if ($1 == .unban) {
      if ($2 == $null) { 
        .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) Usage: $+ %GFTPInfoColor .unban <ip>
        return
      }
      gftpdlog Remote Admin: $+ %GFTPNickColor $nick requested $+ %GFTPInfoColor $1 $2
      .msg =$nick $chr(91) $+ $asctime(hh:nntt) $+ $chr(93) unbanning $+ %GFTPInfoColor $2
      dde %GFTPDddename unbanuser "" $2
      GFTPDUnbannedIP $2
    }
  }
  unset %GFTPInfoColor
  unset %GFTPNickColor
}

on *:close:=: {
  %GFTPInfoColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg InfoColor
  %GFTPNickColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg NickColor
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadminenable) == 1) && ($nick == %GFTPDAdminNick) {
    gftpdlog Remote Admin: $+ %GFTPNickColor $nick chat $+ %GFTPInfoColor exited without .quit
    unset %GFTPDAdminNick
  }
  unset %GFTPInfoColor
  unset %GFTPNickColor
}


;;;############################################MENUS##############################################################

menu @GuildFTPD {
  dclick: {
    if ($sline(@guildftpd,1) != $null) && (. !isin $gettok($sline(@guildftpd,1),1,46)) { query $gettok($sline(@guildftpd,1),2,32) }
  }
  Nicklist Admin
  .Copy IP: { 
    if ($1 != $null) && (. isin $1-) { clipboard $3 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) Selected Item is not an IP address }
  }
  .Query: {
    if ($1 != $null) && (. !isin $1) { query $1 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) Selected Item is not a Nick }
  }
  .Mass Stuff
  ..Mass Notice: {
    if ($sline(@guildftpd,0) != 0) && ($sline(@guildftpd,0) != $null) { 
      set %gftptempmsg $$?="Enter text to notice"
      if (%gftptempmsg == $null) { return }
      set %gftpdtnn $sline(@guildftpd,0)
      while (%gftpdtnn > 0) {
        if (. !isin $gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46)) && ($gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46) != $null) {
          .notice $gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46) %gftptempmsg
        }
        dec %gftpdtnn
      }
      unset %gftptnn
      unset %gftptempmsg
    }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "mass notice" in the Nicklist }
  }
  ..Mass Msg: {
    if ($sline(@guildftpd,0) != 0) && ($sline(@guildftpd,0) != $null) { 
      set %gftptempmsg $$?="Enter text to msg"
      if (%gftptempmsg == $null) { return }
      set %gftpdtnn $sline(@guildftpd,0)
      while (%gftpdtnn > 0) {
        if (. !isin $gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46)) && ($gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46) != $null) {
          .msg $gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46) %gftptempmsg
        }
        dec %gftpdtnn
      }
      unset %gftptnn
      unset %gftptempmsg
    }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "mass msg" in the Nicklist }
  }
  ..Mass Kick: {
    if ($sline(@guildftpd,0) != 0) && ($sline(@guildftpd,0) != $null) { 
      set %gftptempmsg $$?="Enter kick msg"
      set %gftpdtnn $sline(@guildftpd,0)
      while (%gftpdtnn > 0) {
        if ($gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46) != $null) {
          GFTPDkick $gettok($replace($sline(@guildftpd,%gftpdtnn),$chr(32),$chr(46)),1,46) %gftptempmsg
        }
        dec %gftpdtnn
      }
      unset %gftptnn
      unset %gftptempmsg
    }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "mass kick" in the Nicklist }
  }
  .Kick: { 
    if ($1 != $null) { GFTPDkick $1 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "kick" in the Nicklist }
  }
  .Kick /w Reason: { 
    if ($1 != $null) { GFTPDkick $1 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "kick" in the Nicklist }
  }
  .Bans
  ..Ban Forever: { 
    if ($1 != $null) { GFTPDban $1 0 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (5): {
    if ($1 != $null) { GFTPDban $1 5 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
    ..Ban Minutes (10): {
    }
    if ($1 != $null) { GFTPDban $1 10 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
    ..Ban Minutes (15): {
    }
    if ($1 != $null) { GFTPDban $1 15 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (30): {
    if ($1 != $null) { GFTPDban $1 30 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (45): {
    if ($1 != $null) { GFTPDban $1 45 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (60): {
    if ($1 != $null) { GFTPDban $1 60 }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (?): {
    if ($1 != $null) { GFTPDban $1 $$?="Duration In Minutes?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  .Bans /w reason
  ..Ban Forever: { 
    if ($1 != $null) { GFTPDban $1 0 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (5): {
    if ($1 != $null) { GFTPDban $1 5 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (10): {
    if ($1 != $null) { GFTPDban $1 10 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (15): {
    if ($1 != $null) { GFTPDban $1 15 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (30): {
    if ($1 != $null) { GFTPDban $1 30 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (45): {
    if ($1 != $null) { GFTPDban $1 45 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (60): {
    if ($1 != $null) { GFTPDban $1 60 $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  ..Ban Minutes (?): {
    if ($1 != $null) { GFTPDban $1 $$?="Duration In Minutes?" $$?="Enter kick message?" }
    else { gftpdlog Nicklist PopUp:  $+ $readini(Gftpd/Gftpd.ini,GFTPDColorDlg,InfoColor) You must use "ban" in the Nicklist }
  }
  -
  Status Update:GFTPDStatusUpdate
  Clear Window:window -c @GuildFTPD | GFTPDWinOpen | GFTPDStatusUpdate
  -
  Configure:GFTPDCustomize
  Help
  .Popups Help:GFTPDHelp.win gftpd\popups.help
  .Colors Configure Window: GFTPDHelp.win gftpd\colors.help
  .Port Configure Window: GFTPDHelp.win gftpd\ports.help
  .Main Configure Window: GFTPDHelp.win gftpd\config.help
  .Variable Help: GFTPDHelp.win gftpd\var.help
  -
  Start GuildFTPD :{ run $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDdir $+ guildftpd.exe }
}

;;;####################################################DIALOGS####################################################################

dialog GFTPDDlg {
  title "GuildFTPD"
  size -1 -1 600 410
  button "Ok",62, 210 375 50 20 , OK, DEFAULT 
  button "Apply",63, 288 375 50 20,
  button "Cancel",61, 365 375 50 20, CANCEL 
  tab "Monitoring" 500,5 0 595 410
  tab "FTP ad" 501
  tab "Colors" 502
  tab "Advanced" 503
  tab "Remote Admin" 505
  tab "About" 504
  box "Credits:",910, 145 80 320 230, tab 504
  text "GuildFTPDScript 0.998-2.0.5 Multi-server by EZJohnson" 911, 155 100 350 15, tab 504
  text "Dialog (re)design by EZJohnson and MrLitil" 915, 155 120 350 15, tab 504
  text "Based on single server scripts by BMF and 2MuchC0ffeeman" 912, 155 140 350 15, tab 504
  text "Questions/Comments visit:" 913, 155 160 125 15, tab 504
  link "http://www.guildftpd.com" 914, 285 160 350 15, tab 504
  icon 916, 200 180 210 120, gftpd\gftpd.bmp, 20 ( noborder top left ) tab 504
  box "DCC Chat Remote Admin",1000, 145 80 320 230, tab 505
  edit "",1001, 210 100 90 21,autohs tab 505
  text "Trigger:",1002, 160 103 40 15,left tab 505
  check "Enable",1003, 170 130 80 15,right tab 505
  box "Banlist",130,10 25 185 365, tab 500
  text "xxx.xxx.xxx.xxx",137,23 35 190 20, tab 500
  text "Time (min)",144, 133 35 190 20, tab 500
  list 131,20 50 100 240, tab 500
  list 136, 130 50 55 240, tab 500
  button "Add",132, 30 290 60 20, tab 500
  button "Remove",133, 115 290 60 20, tab 500
  text "IP To Ban:"134, 20 320 95 15, tab 500
  edit "",135, 20 335 95 20, tab 500
  text "Time? (Min)",138, 125 320 60 15, tab 500
  edit "",139, 125 335 60 20, tab 500
  text "Use 0 Ban Time For Perm Bans",140, 28 365 150 15, tab 500
  box "",141,20 356 165 25, tab 500
  box "Check Only These Logins:",90, 205 200 220 135, tab 500
  list 92, 215 220 125 80,sort tab 500
  button "Add",93, 350 245 56 20, tab 500
  button "Remove",94, 350 275 56 20, tab 500
  text "Enter login to add:", 95, 215 288 90 20, tab 500
  edit "", 96, 215 305 150 20, tab 500
  check "Enable", 97, 350 220 60 15, tab 500
  box "Channel Monitoring:",5,205 25 390 170, tab 500
  text "Channels to Monitor (10 max):",51, 215 40 155 15,left tab 500
  list 150, 215 57 165 80,sort tab 500
  text "Enter channel and network to add:", 151, 215 140 180 20, tab 500
  edit "",52,215 160 105 21, autohs tab 500
  edit "",53,335 160 105 21, autohs tab 500
  button "Add",152, 390 62 56 20, tab 500
  button "Remove",153, 390 92 56 20, tab 500
  text "GuildFTPD DDE Service Name:", 160, 440 40 150 20, tab 500
  edit "",161,455 60 120 21, autohs tab 500
  check "Kick if not in channel",44, 455 83 135 15,right tab 500
  check "Must be voice or op",43, 455 108 135 15,right tab 500
  check "Ban if not in channel",45, 455 130 135 15,right tab 500
  text "Ban Duration (min):",41, 455 151 125 15,left tab 500
  edit "",42, 550 148 30 21, autohs tab 500
  check "Allow leave after login",46, 455 170 135 15, right tab 500
  box "Fast User DL Speed:",7, 435 200 160 50, tab 500
  text "Speed (kBps):",71, 465 220 80 15,left tab 500
  edit "", 72, 550 217 35 21,autohs tab 500
  box "Kick/Ban Grace period:",17, 435 260 160 50, tab 500
  edit "", 171, 550 280 35 21,autohs tab 500
  text "Time (Secs):",18, 465 283 80 15,left tab 500
  box "CTCP Stats:",19, 435 315 160 75, tab 500
  edit "", 271, 490 335 90 21,autohs tab 500
  text "Trigger:",20, 440 338 40 15,left tab 500
  check "Enable",21, 455 365 80 15,right tab 500
  box "Advertisement:",4,10 25 585 378, tab 501
  edit "",32,20 45 565 80, autovs multi tab 501
  check "Enable",64, 483 136 59 15,left tab 501
  text "Repeat Rate in seconds:",33, 60 136 130 15,left tab 501
  edit "",34, 185 133 50 20, autohs tab 501
  list 600, 20 160 565 210, tab 501
  box "@GuildFTPD Info",480,40 50 150 255,group tab 502
  radio "Yellow",401, 65 70 70 15, tab 502
  radio "Red",402, 65 85 70 15, tab 502
  radio "Green",403, 65 100 70 15, tab 502
  radio "Teal",404, 65 115 70 15, tab 502
  radio "Light Blue",405, 65 130 70 15, tab 502
  radio "Dark Green",406, 65 145 70 15, tab 502
  radio "Blue",407, 65 160 70 15, tab 502
  radio "Dark Blue",408, 65 175 70 15, tab 502
  radio "Purple",409, 65 190 70 15, tab 502
  radio "Brown",410, 65 205 70 15, tab 502
  radio "Grey",411, 65 220 70 15, tab 502
  radio "Dark Grey",412, 65 235 70 15, tab 502
  radio "Black",413, 65 250 70 15, tab 502
  radio "White",414, 65 265 70 15, tab 502
  radio "Orange",415, 65 280 70 15, tab 502
  box "@GuildFTPD Nick/IP",481,220 50 150 255,group tab 502
  radio "Yellow",416, 245 70 100 15, tab 502
  radio "Red",417, 245 85 100 15, tab 502
  radio "Green",418, 245 100 100 15, tab 502
  radio "Teal",419, 245 115 100 15, tab 502
  radio "Light Blue",420, 245 130 100 15, tab 502
  radio "Dark Green",421, 245 145 100 15, tab 502
  radio "Blue",422, 245 160 100 15, tab 502
  radio "Dark Blue",423, 245 175 100 15, tab 502
  radio "Purple",424, 245 190 100 15, tab 502
  radio "Brown",425, 245 205 100 15, tab 502
  radio "Grey",426, 245 220 100 15, tab 502
  radio "Dark Grey",427, 245 235 100 15, tab 502
  radio "Black",428, 245 250 100 15, tab 502
  radio "White",429, 245 265 100 15, tab 502
  radio "Orange",430, 245 280 100 15, tab 502
  box "@GuildFTPD Fast Users",482, 404 50 150 255,group tab 502
  radio "Yellow",431, 430 70 100 15, tab 502
  radio "Red",432, 430 85 100 15, tab 502
  radio "Green",433, 430 100 100 15, tab 502
  radio "Teal",434, 430 115 100 15, tab 502
  radio "Light Blue",435, 430 130 100 15, tab 502
  radio "Dark Green",436, 430 145 100 15, tab 502
  radio "Blue",437, 430 160 100 15, tab 502
  radio "Dark Blue",438, 430 175 100 15, tab 502
  radio "Purple",439, 430 190 100 15, tab 502
  radio "Brown",440, 430 205 100 15, tab 502
  radio "Grey",441, 430 220 100 15, tab 502
  radio "Dark Grey",442, 430 235 100 15, tab 502
  radio "Black",443, 430 250 100 15, tab 502
  radio "White",444, 430 265 100 15, tab 502
  radio "Orange",445, 430 280 100 15, tab 502
  box "Password Hopping:",109, 390 25 205 185, tab 503
  list 115, 395 45 140 100 ,sort tab 503
  button "Add",116, 540 60 50 20, tab 503
  button "Remove",117, 540 95 50 20, tab 503
  text "Login to add:",119, 408 140 80 20, tab 503
  edit "",120,475 136 115 20, tab 503
  text "Password Mask:",110, 395 165 80 15, tab 503
  edit "",111, 475 161 115 20, tab 503
  text "Hop Rate (min):", 112, 395 190 100 15, tab 503
  edit "",113, 475 185 32 20, autohs tab 503          
  check "Real Words?", 114, 515 190 75 15,left tab 503
  box "Port Hopping:",310, 10 25 160 120, tab 503
  text "Minimum Port:",311, 20 45 130 15,left, tab 503
  edit "",312, 120 45 45 21, autohs tab 503
  text "Maximum Port:",313, 20 70 130 15,left tab 503
  edit "",314, 120 68 45 21, autohs tab 503
  text "Hop rate (min):",315, 20 95 130 15,left tab 503
  edit "",316, 120 92 45 21, autohs tab 503
  check "Enable Port Hopping?",317, 33 120 120 15,right tab 503
  box "Current System Port:",320,10 160 160 50, tab 503
  text "Port:",321, 20 180 80 15,left tab 503
  edit "",322, 120 177 45 21, autohs tab 503
  box "Multiport Configuration:",330, 175 25 210 185, tab 503
  text "Account ID:", 331, 190 45 100 15, tab 503
  list 332, 185 60 110 100, tab 503
  text "Port:", 333, 310 45 50 15, tab 503
  list 334, 305 60 70 100, tab 503
  text "ID:",335, 185 155 20 15, tab 503
  edit "", 336, 204 151 105 21, tab 503
  text "Port:", 337, 185 185 25 15, tab 503
  edit "",338, 212 182 45 21, tab 503
  button "Add",339, 325 151 50 20, tab 503
  button "Remove",340, 325 182 50 20, tab 503
  button "Change",341, 265 182 50 20, tab 503
  box "PrivIPs (Enter ip x.x.x.x Wildcards OK use x.x.* NOT x.x.*.* ):",710, 10 220 320 145, tab 503
  list 711, 30 240 130 125, tab 503
  button "Add",712, 180 295 130 21, tab 503
  button "Remove",713, 180 320 130 21, tab 503
  edit "" 714, 180 255 130 21, tab 503
  box "Logging:",810, 335 220 260 145, tab 503
  check "Enable Logging?",811, 365 245 100 15, tab 503
  check "Date Logfiles?",812, 365 270 100 15, tab 503
  button "Change Log Folder:",813, 365 300 130 21, tab 503
  edit "" 814, 365 325 200 21, tab 503
}

on 1:dialog:GFTPDDlg:init:0: {
  GFTPDreadusers dialog
  %GFTPTemp = $readini Gftpd/Gftpd.ini GFTPDDlg NotExemptList
  if (%GFTPTemp != $null) {
    %GFTPcntr = 1
    :exinloop
    did -o GFTPDDlg 92 %GFTPcntr $gettok(%GFTPTemp, %GFTPcntr, 32)
    inc %GFTPcntr   
    if (%GFTPcntr <= $numtok(%GFTPTemp, 32)) { goto exinloop }
    unset %GFTPTemp
  }
  %GFTPTemp = $readini Gftpd/Gftpd.ini GFTPDDlg PassHopList
  if (%GFTPTemp != $null) {
    %GFTPcntr = 1
    :psinloop
    did -o GFTPDDlg 115 %GFTPcntr $gettok(%GFTPTemp, %GFTPcntr, 32)
    inc %GFTPcntr   
    if (%GFTPcntr <= $numtok(%GFTPTemp, 32)) { goto psinloop }
    unset %GFTPTemp
  }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg ExemptEnable == 1) { did -c GFTPDDlg 97 } 
  else { did -u GFTPDDlg 97 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg AdEnable == 1) { did -c GFTPDDlg 64 }
  else { did -u GFTPDDlg 64 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg KickNotOnChan == 1) { did -c GFTPDDlg 44 }
  else { did -u GFTPDDlg 44 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg VoicedOnChan == 1) { did -c GFTPDDlg 43 }
  else { did -u GFTPDDlg 43 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg BanNotOnChan == 1) { did -c GFTPDDlg 45 }
  else { did -u GFTPDDlg 45 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg LeaveAfter == 1) { did -c GFTPDDlg 46 }
  else { did -u GFTPDDlg 46 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg RealWords == 1) { did -c GFTPDDlg 114 }
  else { did -u GFTPDDlg 114 }
  did -o GFTPDDlg 111 1 $readini Gftpd/Gftpd.ini GFTPDDlg PassMask
  did -o GFTPDDlg 113 1 $readini Gftpd/Gftpd.ini GFTPDDlg PassHopRate
  did -o GFTPDDlg 42 1 $readini Gftpd/Gftpd.ini GFTPDDlg NotOnChanBanDur
  did -o GFTPDDlg 32 1 %GFTPad
  did -o GFTPDDlg 34 1 $readini Gftpd/Gftpd.ini GFTPDDlg AdTimer
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan1 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan1 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan2 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan2 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan3 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan3 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan4 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan4 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan5 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan5 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan6 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan6 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan7 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan7 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan8 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan8 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan9 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan9 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg Chan10 != $null) { did -a GFTPDDlg 150 $readini Gftpd/Gftpd.ini GFTPDDlg Chan10 }
  if ($readini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename != $null) { did -a GFTPDDlg 161 $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename }
  did -o GFTPDDlg 72 1 $readini Gftpd/Gftpd.ini GFTPDDlg FastKbs
  did -o GFTPDDlg 171 1 $readini Gftpd/Gftpd.ini GFTPDDlg GracePeriod
  GFTPDreadbans
  unset %GFTPcntr
  if ($readini Gftpd/Gftpd.ini GFTPDPortDlg PortHop == 1) { did -c GFTPDDlg 317 }
  else { did -u GFTPDDlg 317 }
  if ($readini Gftpd/Gftpd.ini GFTPDPortDlg MinPort != $null) { did -o GFTPDDlg 312 1 $readini Gftpd/Gftpd.ini GFTPDPortDlg MinPort }
  if ($readini Gftpd/Gftpd.ini GFTPDPortDlg MaxPort != $null) { did -o GFTPDDlg 314 1 $readini Gftpd/Gftpd.ini GFTPDPortDlg MaxPort }
  if ($readini Gftpd/Gftpd.ini GFTPDPortDlg PortHopRate != $null) { did -o GFTPDDlg 316 1 $readini Gftpd/Gftpd.ini GFTPDPortDlg PortHopRate }
  if ($readini Gftpd/Gftpd.ini GFTPDPortDlg MainPort != $null) { did -o GFTPDDlg 322 1 $readini Gftpd/Gftpd.ini GFTPDPortDlg MainPort }
  %GFTPMultiportList = $readini Gftpd/Gftpd.ini GFTPDPortDlg MultiportList  
  if (%GFTPMultiportList != $null) {
    %GFTPcntr = 1
    :multinloop
    did -a GFTPDDlg 332 $gettok(%GFTPMultiportList, %GFTPcntr, 32)
    did -a GFTPDDlg 334 $gettok(%GFTPMultiportList, $calc(%GFTPcntr + 1), 32)
    inc %GFTPcntr 2 
    if (%GFTPcntr <= $numtok(%GFTPMultiportList, 32)) { goto multinloop }
    unset %GFTPMultiportList
    unset %GFTPcntr
  }
  %GFTPInfoColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg InfoColor
  %GFTPNickColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg NickColor
  %GFTPFastUserColor = $readini Gftpd/Gftpd.ini GFTPDColorDlg FastUserColor
  if ( %GFTPInfoColor == 24 ) { did -c GFTPDDlg 401 }
  if ( %GFTPInfoColor == 20 ) { did -c GFTPDDlg 402 }
  if ( %GFTPInfoColor == 25 ) { did -c GFTPDDlg 403 }
  if ( %GFTPInfoColor == 26 ) { did -c GFTPDDlg 404 }
  if ( %GFTPInfoColor == 27 ) { did -c GFTPDDlg 405 }
  if ( %GFTPInfoColor == 19 ) { did -c GFTPDDlg 406 }
  if ( %GFTPInfoColor == 12 ) { did -c GFTPDDlg 407 }
  if ( %GFTPInfoColor == 18 ) { did -c GFTPDDlg 408 }
  if ( %GFTPInfoColor == 22 ) { did -c GFTPDDlg 409 }
  if ( %GFTPInfoColor == 21 ) { did -c GFTPDDlg 410 }
  if ( %GFTPInfoColor == 15 ) { did -c GFTPDDlg 411 }
  if ( %GFTPInfoColor == 14 ) { did -c GFTPDDlg 412 }
  if ( %GFTPInfoColor == 17 ) { did -c GFTPDDlg 413 }
  if ( %GFTPInfoColor == 16 ) { did -c GFTPDDlg 414 }
  if ( %GFTPInfoColor == 23 ) { did -c GFTPDDlg 415 }
  if ( %GFTPNickColor == 24 ) { did -c GFTPDDlg 416 }
  if ( %GFTPNickColor == 20 ) { did -c GFTPDDlg 417 }
  if ( %GFTPNickColor == 25 ) { did -c GFTPDDlg 418 }
  if ( %GFTPNickColor == 26 ) { did -c GFTPDDlg 419 }
  if ( %GFTPNickColor == 27 ) { did -c GFTPDDlg 420 }
  if ( %GFTPNickColor == 19 ) { did -c GFTPDDlg 421 }
  if ( %GFTPNickColor == 12 ) { did -c GFTPDDlg 422 }
  if ( %GFTPNickColor == 18 ) { did -c GFTPDDlg 423 }
  if ( %GFTPNickColor == 22 ) { did -c GFTPDDlg 424 }
  if ( %GFTPNickColor == 21 ) { did -c GFTPDDlg 425 }
  if ( %GFTPNickColor == 15 ) { did -c GFTPDDlg 426 }
  if ( %GFTPNickColor == 14 ) { did -c GFTPDDlg 427 }
  if ( %GFTPNickColor == 17 ) { did -c GFTPDDlg 428 }
  if ( %GFTPNickColor == 16 ) { did -c GFTPDDlg 429 }
  if ( %GFTPNickColor == 23 ) { did -c GFTPDDlg 430 }
  if ( %GFTPFastUserColor == 24 ) { did -c GFTPDDlg 431 }
  if ( %GFTPFastUserColor == 20 ) { did -c GFTPDDlg 432 }
  if ( %GFTPFastUserColor == 25 ) { did -c GFTPDDlg 433 }
  if ( %GFTPFastUserColor == 26 ) { did -c GFTPDDlg 434 }
  if ( %GFTPFastUserColor == 27 ) { did -c GFTPDDlg 435 }
  if ( %GFTPFastUserColor == 19 ) { did -c GFTPDDlg 436 }
  if ( %GFTPFastUserColor == 12 ) { did -c GFTPDDlg 437 }
  if ( %GFTPFastUserColor == 18 ) { did -c GFTPDDlg 438 }
  if ( %GFTPFastUserColor == 22 ) { did -c GFTPDDlg 439 }
  if ( %GFTPFastUserColor == 21 ) { did -c GFTPDDlg 440 }
  if ( %GFTPFastUserColor == 15 ) { did -c GFTPDDlg 441 }
  if ( %GFTPFastUserColor == 14 ) { did -c GFTPDDlg 442 }
  if ( %GFTPFastUserColor == 17 ) { did -c GFTPDDlg 443 }
  if ( %GFTPFastUserColor == 16 ) { did -c GFTPDDlg 444 }
  if ( %GFTPFastUserColor == 23 ) { did -c GFTPDDlg 445 }
  unset %GFTPFastUserColor
  unset %GFTPNickColor
  unset %GFTPInfoColor
  loadbuf 1- $+ $lines(gftpd\var.help) -po GFTPDDlg 600 gftpd\var.help
  if ($readini Gftpd/Gftpd.ini GFTPDLogDlg LogEnable == 1) { did -c GFTPDDlg 811 }
  else { did -u GFTPDDlg 811 }
  if ($readini Gftpd/Gftpd.ini GFTPDLogDlg DateLogs == 1) { did -c GFTPDDlg 812 }
  else { did -u GFTPDDlg 812 }
  if ($readini Gftpd/Gftpd.ini GFTPDLogDlg LogFolder != $null) { did -ma GFTPDDlg 814 $readini Gftpd/Gftpd.ini GFTPDLogDlg LogFolder }
  else { did -ma GFTPDDlg 814 Currently Unset }
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDstatsenable) == 1) { did -c GFTPDDlg 21 }
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDstats) != $null) { did -a GFTPDDlg 271 $readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDstats) } 
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadminenable) == 1) { did -c GFTPDDlg 1003 }
  if ($readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadmin) != $null) { did -a GFTPDDlg 1001 $readini(gftpd\gftpd.ini,GFTPDlogdlg,GFTPDadmin) } 
}

on 1:dialog:GFTPDDlg:sclick:*: { 
  if ($did == 116) {
    if ($did(GFTPDDlg, 120) != $null) { 
      did -a GFTPDDlg 115 $did(GFTPDDlg,120)
      did -r GFTPDDlg 120
    }
  }
  if ($did == 117) { 
    if ($did(GFTPDDlg,115,1).sel != $null) {
      did -d GFTPDDlg 115 $did(GFTPDDlg, 115, 1).sel
    }
  }
  if ($did == 94) { 
    if ($did(GFTPDDlg,92,1).sel != $null) {
      did -d GFTPDDlg 92 $did(GFTPDDlg, 92, 1).sel
    }
  }
  if ($did == 93) { 
    if ($did(GFTPDDlg, 96) != $null) { 
      did -a GFTPDDlg 92 $did(GFTPDDlg, 96)
      did -r GFTPDDlg 96
    }
  }
  if ($did == 131) { did -c GFTPDDlg 136 $did(GFTPDDlg,131,1).sel }
  if ($did == 136) { did -c GFTPDDlg 131 $did(GFTPDDlg,136,1).sel }
  if ($did == 153) { 
    if ($did(GFTPDDlg,150,1).sel != $null) {
      did -d GFTPDDlg 150 $did(GFTPDDlg, 150, 1).sel
    }
  }
  if ($did == 152) { 
    if ($did(GFTPDDlg, 52) != $null) && ($did(GFTPDDlg, 53) != $null) { 
      if ($did(GFTPDDlg,150).lines < 10) {
        if ($left($did(GFTPDDlg, 52),1) != $chr(35)) { did -a GFTPDDlg 150 $chr(35) $+ $did(GFTPDDlg, 52) $did(GFTPDDlg, 53) }
        else { did -a GFTPDDlg 150 $did(GFTPDDlg, 52) $did(GFTPDDlg, 53) }
        did -r GFTPDDlg 52
        did -r GFTPDDlg 53
      }
    }
  }
  if ($did == 914) { run iexplore http://www.guildftpd.com }
  if ($did == 339) && $did(336) != $null {
    did -a GFTPDDlg 332 $did(GFTPDDlg,336)
    did -a GFTPDDlg 334 $did(GFTPDDlg,338)
    dde %GFTPDddename setport "" $did(GFTPDDlg,336) $did(GFTPDDlg,338)
    did -r GFTPDDlg 336
    did -r GFTPDDlg 338
  }
  if ($did == 340) {
    if ($did(GFTPDDlg,332,$did(GFTPDDlg,332,1).sel) != $null) {
      dde %GFTPDddename setport "" $did(GFTPDDlg,332,$did(GFTPDDlg,332,1).sel) 0
      did -d GFTPDDlg 334 $did(GFTPDDlg,332,1).sel
      did -d GFTPDDlg 332 $did(GFTPDDlg,332,1).sel
    }
  }
  if ($did == 341) && ($did(GFTPDDlg,332,1).sel) && ($did(GFTPDDlg,338) isnum) {
    dde %GFTPDddename setport "" $did(GFTPDDlg,332,$did(GFTPDDlg,332,1).sel) $did(GFTPDDlg,338)
    did -o GFTPDDlg 334 $did(GFTPDDlg,334,1).sel $did(GFTPDDlg,338) 
  }
  if ($did == 62) || ($did == 63) || ($did == 65) || ($did == 66) {
    if ($did(21).state == 1) { writeini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDstatsenable 1 }
    if ($did(21).state == 0) { writeini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDstatsenable 0 }
    if ($did(271) != $null) { writeini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDstats $did(271) } 
    else { remini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDstats }
    if ($did(1003).state == 1) { writeini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDadminenable 1 }
    if ($did(1003).state == 0) { writeini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDadminenable 0 }
    if ($did(1001) != $null) { writeini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDadmin $did(1001) } 
    else { remini Gftpd/Gftpd.ini GFTPDlogDlg GFTPDadmin }
    writeini Gftpd/Gftpd.ini GFTPDPortDlg PortHop $did(GFTPDDlg,317).state
    if ($did(GFTPDDlg,314) != $null) { writeini Gftpd/Gftpd.ini GFTPDPortDlg MaxPort $did(GFTPDDlg,314) }
    elseif ($did(GFTPDDlg,314) == $null) { remini Gftpd/Gftpd.ini GFTPDPortDlg MaxPort }
    if ($did(GFTPDDlg,312) != $null) { writeini Gftpd/Gftpd.ini GFTPDPortDlg MinPort $did(GFTPDDlg,312) }
    elseif ($did(GFTPDDlg,312) == $null) { remini Gftpd/Gftpd.ini GFTPDPortDlg MinPort }
    if ($did(GFTPDDlg,316) != $null) { writeini Gftpd/Gftpd.ini GFTPDPortDlg PortHopRate $did(GFTPDDlg,316) }
    elseif ($did(GFTPDDlg,316) == $null) { remini Gftpd/Gftpd.ini GFTPDPortDlg PortHopRate }
    if ($did(GFTPDDlg,322) != $null) { 
      if ( $readini Gftpd/Gftpd.ini GFTPDPortDlg MainPort != $did(GFTPDDlg,322)) { 
        writeini Gftpd/Gftpd.ini GFTPDPortDlg MainPort $did(GFTPDDlg,322)
        dde %GFTPDddename setport "" $did(GFTPDDlg,322)
      }
    }
    %GFTPcntr = 1
    :multloop
    %GFTPMultiportList = %GFTPMultiportList $did(332, %GFTPcntr) $did(334,%GFTPcntr)
    inc %GFTPcntr 1
    if (%GFTPcntr <= $did(332).lines) { goto multloop } 
    if %GFTPMultiportList != $null { writeini Gftpd/Gftpd.ini GFTPDPortDlg MultiportList %GFTPMultiportList }
    else { remini Gftpd/Gftpd.ini GFTPDPortDlg MultiportList }
    unset %GFTPMultiportList
    unset %GFTPcntr
    GFTPDportrefresh
    if ( $did(401).state ) { %GFTPInfoColor = 24 }
    if ( $did(402).state ) { %GFTPInfoColor = 20 }
    if ( $did(403).state ) { %GFTPInfoColor = 25 }
    if ( $did(404).state ) { %GFTPInfoColor = 26 }
    if ( $did(405).state ) { %GFTPInfoColor = 27 }
    if ( $did(406).state ) { %GFTPInfoColor = 19 }
    if ( $did(407).state ) { %GFTPInfoColor = 12 }
    if ( $did(408).state ) { %GFTPInfoColor = 18 }
    if ( $did(409).state ) { %GFTPInfoColor = 22 }
    if ( $did(410).state ) { %GFTPInfoColor = 21 }
    if ( $did(411).state ) { %GFTPInfoColor = 15 }
    if ( $did(412).state ) { %GFTPInfoColor = 14 }
    if ( $did(413).state ) { %GFTPInfoColor = 17 }
    if ( $did(414).state ) { %GFTPInfoColor = 16 }
    if ( $did(415).state ) { %GFTPInfoColor = 23 }
    if ( $did(416).state ) { %GFTPNickColor = 24 }
    if ( $did(417).state ) { %GFTPNickColor = 20 }
    if ( $did(418).state ) { %GFTPNickColor = 25 }
    if ( $did(419).state ) { %GFTPNickColor = 26 }
    if ( $did(420).state ) { %GFTPNickColor = 27 }
    if ( $did(421).state ) { %GFTPNickColor = 19 }
    if ( $did(422).state ) { %GFTPNickColor = 12 }
    if ( $did(423).state ) { %GFTPNickColor = 18 }
    if ( $did(424).state ) { %GFTPNickColor = 22 }
    if ( $did(425).state ) { %GFTPNickColor = 21 }
    if ( $did(426).state ) { %GFTPNickColor = 15 }
    if ( $did(427).state ) { %GFTPNickColor = 14 }
    if ( $did(428).state ) { %GFTPNickColor = 17 }
    if ( $did(429).state ) { %GFTPNickColor = 16 }
    if ( $did(430).state ) { %GFTPNickColor = 23 }
    if ( $did(431).state ) { %GFTPFastUserColor = 24 }
    if ( $did(432).state ) { %GFTPFastUserColor = 20 }
    if ( $did(433).state ) { %GFTPFastUserColor = 25 }
    if ( $did(434).state ) { %GFTPFastUserColor = 26 }
    if ( $did(435).state ) { %GFTPFastUserColor = 27 }
    if ( $did(436).state ) { %GFTPFastUserColor = 19 }
    if ( $did(437).state ) { %GFTPFastUserColor = 12 }
    if ( $did(438).state ) { %GFTPFastUserColor = 18 }
    if ( $did(439).state ) { %GFTPFastUserColor = 22 }
    if ( $did(440).state ) { %GFTPFastUserColor = 21 }
    if ( $did(441).state ) { %GFTPFastUserColor = 15 }
    if ( $did(442).state ) { %GFTPFastUserColor = 14 }
    if ( $did(443).state ) { %GFTPFastUserColor = 17 }
    if ( $did(444).state ) { %GFTPFastUserColor = 16 }
    if ( $did(445).state ) { %GFTPFastUserColor = 23 } 
    if (%GFTPFastUserColor != $null) { writeini Gftpd/Gftpd.ini GFTPDColorDlg FastUserColor %GFTPFastUserColor }
    if (%GFTPNickColor != $null) { writeini Gftpd/Gftpd.ini GFTPDColorDlg NickColor %GFTPNickColor }
    if (%GFTPInfoColor != $null) { writeini Gftpd/Gftpd.ini GFTPDColorDlg InfoColor %GFTPInfoColor }
    unset %GFTPFastUserColor
    unset %GFTPNickColor
    unset %GFTPInfoColor
    if ($did(115).lines >= 1) { writeini Gftpd/Gftpd.ini GFTPDDlg PassHopEnable 1 }
    else { writeini Gftpd/Gftpd.ini GFTPDDlg PassHopEnable 0 }
    %GFTPcntr = 1
    unset %GFTPad
    :adloop
    %GFTPad = %GFTPad $did(GFTPDDlg, 32, %GFTPcntr)
    inc %GFTPcntr
    if (%GFTPcntr != $calc( 1 + $did(GFTPDDlg, 32).lines )) { goto adloop } 
    %GFTPcntr = 1
    unset %GFTPNotExemptList
    :exemptloop
    %GFTPNotExemptList = %GFTPNotExemptList $did(92, %GFTPcntr).text
    inc %GFTPcntr 1
    if (%GFTPcntr <= $did(GFTPDDlg, 92).lines) { goto exemptloop } 
    if (%GFTPNotExemptList != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg NotExemptList %GFTPNotExemptList }
    else { remini Gftpd/Gftpd.ini GFTPDDlg NotExemptList }
    unset %GFTPNotExemptList
    %GFTPcntr = 1
    unset %GFTPPassHopList
    :passloop
    %GFTPPassHopList = %GFTPPassHopList $did(115, %GFTPcntr).text
    inc %GFTPcntr 1
    if (%GFTPcntr <= $did(115).lines) { goto passloop }
    if (%GFTPPassHopList != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg PassHopList %GFTPPassHopList }
    else { remini Gftpd/Gftpd.ini GFTPDDlg PassHopList }
    unset %GFTPPassHopList
    if ($did(GFTPDDlg,150,1) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan1 $did(GFTPDDlg,150,1) }
    if ($did(GFTPDDlg,150,1) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan1 }
    if ($did(GFTPDDlg,150,2) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan2 $did(GFTPDDlg,150,2) }
    if ($did(GFTPDDlg,150,2) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan2 }
    if ($did(GFTPDDlg,150,3) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan3 $did(GFTPDDlg,150,3) }
    if ($did(GFTPDDlg,150,3) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan3 }
    if ($did(GFTPDDlg,150,4) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan4 $did(GFTPDDlg,150,4) }
    if ($did(GFTPDDlg,150,4) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan4 }
    if ($did(GFTPDDlg,150,5) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan5 $did(GFTPDDlg,150,5) }
    if ($did(GFTPDDlg,150,5) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan5 }
    if ($did(GFTPDDlg,150,6) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan6 $did(GFTPDDlg,150,6) }
    if ($did(GFTPDDlg,150,6) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan6 }
    if ($did(GFTPDDlg,150,7) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan7 $did(GFTPDDlg,150,7) }
    if ($did(GFTPDDlg,150,7) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan7 }
    if ($did(GFTPDDlg,150,8) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan8 $did(GFTPDDlg,150,8) }
    if ($did(GFTPDDlg,150,8) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan8 }
    if ($did(GFTPDDlg,150,9) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan9 $did(GFTPDDlg,150,9) }
    if ($did(GFTPDDlg,150,9) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan9 }
    if ($did(GFTPDDlg,150,10) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg Chan10 $did(GFTPDDlg,150,10) }
    if ($did(GFTPDDlg,150,10) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg Chan10 }
    writeini Gftpd/Gftpd.ini GFTPDDlg VoicedOnChan $did(GFTPDDlg, 43).state
    writeini Gftpd/Gftpd.ini GFTPDDlg KickNotOnChan $did(GFTPDDlg, 44).state
    writeini Gftpd/Gftpd.ini GFTPDDlg BanNotOnChan $did(GFTPDDlg, 45).state
    if ($did(GFTPDDlg, 42) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg NotOnChanBanDur $did(GFTPDDlg, 42) }
    if ($did(GFTPDDlg, 42) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg NotOnChanBanDur }
    writeini Gftpd/Gftpd.ini GFTPDDlg LeaveAfter $did(GFTPDDlg, 46).state
    writeini Gftpd/Gftpd.ini GFTPDDlg ExemptEnable $did(GFTPDDlg, 97).state
    if ($did(GFTPDDlg, 72) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg FastKbs $did(GFTPDDlg,72) }
    if ($did(GFTPDDlg, 72) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg FastKbs }
    if ($did(GFTPDDlg, 171) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg GracePeriod $did(GFTPDDlg,171) }
    if ($did(GFTPDDlg, 171) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg GracePeriod }
    if ($did(GFTPDDlg, 161) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename $did(GFTPDDlg,161) }
    if ($did(GFTPDDlg, 161) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename }
    %GFTPDddename = $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDddename
    if ($did(111) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg PassMask $did(111) }
    if ($did(111) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg PassMask }
    if ($did(113) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg PassHopRate $did(113) }
    if ($did(113) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg PassHopRate }
    writeini Gftpd/Gftpd.ini GFTPDDlg RealWords $did(114).state
    if ($did(GFTPDDlg, 34) != $null) { writeini Gftpd/Gftpd.ini GFTPDDlg AdTimer $did(GFTPDDlg,34) }
    if ($did(GFTPDDlg, 34) == $null) { remini Gftpd/Gftpd.ini GFTPDDlg AdTimer }
    writeini Gftpd/Gftpd.ini GFTPDDlg AdEnable $did(GFTPDDlg,64).state
    GFTPDsiterefresh 
    if ($did(GFTPDDlg,811).state == 0) { 
      remini Gftpd/Gftpd.ini GFTPDlogDlg LogEnable
      remini Gftpd/Gftpd.ini GFTPDlogDlg DateLogs
      remini Gftpd/Gftpd.ini GFTPDlogDlg LogFolder
    }
    else {
      writeini Gftpd/Gftpd.ini GFTPDlogDlg LogEnable $did(GFTPDDlg,811).state
      writeini Gftpd/Gftpd.ini GFTPDlogDlg DateLogs $did(GFTPDDlg,812).state
    }
  }
  if ($did == 133) { 
    if ($did(GFTPDDlg,131,$did(GFTPDDlg,131,1).sel) != $null) {
      dde %GFTPDddename unbanuser "" $did(GFTPDDlg,131,$did(GFTPDDlg,131,1).sel)
      GFTPDUnbannedIP $did(GFTPDDlg,131,$did(GFTPDDlg,131,1).sel)
      did -d GFTPDDlg 136 $did(GFTPDDlg,131,1).sel
      did -d GFTPDDlg 131 $did(GFTPDDlg, 131, 1).sel
    }
  }
  if ($did == 132) { 
    if ($numtok($did(GFTPDDlg,135),46) == 4) && ($did(GFTPDDlg,139) != $null) { 
      did -a GFTPDDlg 131 $did(GFTPDDlg, 135)
      did -a GFTPDDlg 136 $did(GFTPDDlg, 139)
      GFTPDban $did(GFTPDDlg, 135) $did(GFTPDDlg,139)
      did -r GFTPDDlg 135
      did -r GFTPDDlg 139
    } 
  }
  if ($did == 610) { GFTPDHelp.win gftpd\var.help }
  unset %GFTPcntr
  if ($did == 712) { 
    if ($did(GFTPDDlg,714) != $null) { 
      did -a GFTPDDlg 711 $did(GFTPDDlg, 714)
      write gftpd\gftpd.users $did(GFTPDDlg, 714)
      did -r GFTPDDlg 714
    } 
  }
  if ($did == 713) { 
    if ($did(GFTPDdlg,711,1).seltext != $null) { 
      set %GFTPcntr 1
      %GFTPufile = Gftpd/Gftpd.users
      set %GFTPip $read -l $+ %GFTPcntr %GFTPufile
      :userloop
      if (%GFTPip != $null) {
        if (%GFTPip == $did(GFTPDDlg,711,1).seltext) { write -dl $+ %GFTPcntr %GFTPufile }
        inc %GFTPcntr 1
        set %GFTPip $read -l $+ %GFTPcntr %GFTPufile
        goto userloop
      }
      unset %GFTPufile
      unset %GFTPcntr
      unset %GFTPip
      did -d GFTPDDlg 711 $did(GFTPDDlg,711,1).sel
    } 
  }
  if ($did == 813) { 
    if ($readini Gftpd/Gftpd.ini GFTPDLogDlg LogFolder != $null) {
      set %GFTPlogdir $sdir="Where Is GuildFTP's directory?" $readini Gftpd/Gftpd.ini GFTPDLogDlg LogFolder
    }
    else { set %GFTPlogdir $sdir="Where Is GuildFTP's directory?" c:\*.* }
    did -mr GFTPDDlg 814
    did -ma GFTPDDlg 814 %GFTPlogdir
    writeini Gftpd/Gftpd.ini GFTPDlogDlg LogFolder %GFTPlogdir
    unset %GFTPlogdir
  }
}

dialog GFTPDHelp {
  title "GFTPDHelp"
  size -1 -1 500 320
  list 2, 10 10 480 280
  button "&OK" 1, 220 290 60 20, ok
}

;;;EOF
