;  TSZ FTP v1.01
;  Basic Usage: "/ftp sitename" or "/ftp site username password"
;  All commands can be access through the popups
;  
;  --
;if ($gettok($gettok($read($mircdirftp\ftpgetqueues.txt,1),3,9),1,58) == %tszftp.currentftp ) echo -a done
;$Remove2
;//echo -a $remove2(This is not a snippet,not,1) - This will then echo "This is a snippet"
;$remove2(<string>,<substring>,<N>,...)[.cs] - The .cs will make it case-sensitive
alias remove2 {
  var %a = 1,%b = $gettok($1,1-,32)
  while (%a < $0) {
    inc %a
    var %c = $gettok($($+($,%a),2),1-,32)
    inc %a
    var %d = $gettok($($+($,%a),2),1-,32)
    if ($iif($prop == cs, $poscs(%b,%c,%d), $pos(%b,%c,%d))) var %b = $mid(%b,1,$iif($v1 != 1, $calc($v1 - 1))) $+ $mid(%b,$calc($v1 + $len(%c)),$len(%b))
  }
  return %b
}

alias ftpclienttt {
  client | messages
}
alias messages {
  if $dialog(servers) == $null { /dialog -m servers servers }
  ;else { /dialog -x servers servers | dialog -m servers servers }
}
alias client {
  if $dialog(ftpclient) == $null { /dialog -mdie ftpclient ftpclient }
  ;else { /dialog -x ftpclient ftpclient | dialog -mdie ftpclient ftpclient }
}

alias tszftp.profiles {
  if ($dialog(profiles) == $null) { /dialog -mdie profiles profiles }
  else { /dialog -v profiles }
}

alias modesss {
  if $dialog(modes) == $null { /dialog -mdie modes modes }
  else { dialog -iev modes modes }
}
dialog ftpclient {
  title "TSZ FTP v1.02"
  size 350 100 681 679
  option pixels
  box "Your D/L directory", 1, 10 10 330 393
  box "Your Ftp directory", 2, 350 10 310 393
  box "progress bar", 3, 8 586 670 67
  link "comment/report bug", 4, 8 658 109 17
  list 5, 400 30 255 362, size extsel
  list 6, 15 30 275 340, size extsel
  text "0 0 100", 7, 16 609 587 15
  list 1078, 360 30 35 66, size
  list 1079, 360 335 35 16, size
  list 1080, 295 30 35 66, size
  list 1081, 295 300 35 16, size
  text "Progress:", 447, 18 624 50 12
  text "Size:", 457, 193 624 30 12
  text "Time:", 467, 328 624 30 12
  text "Speed:", 477, 450 624 35 12
  text "File:", 487, 143 664 30 12
  text "", 497, 68 624 100 12
  text "", 507, 223 624 100 12
  text "", 517, 358 624 55 12
  text "", 527, 485 624 90 12
  text "", 537, 173 664 500 12
  text "%", 547, 605 609 60 12
  edit "", 28, 15 375 275 18, disable
  button "", 1000, 0 0 0 0, hide ok
  box "Getting Queue", 8, 350 415 310 127
  list 9, 355 435 300 100, size
  box "Sending Queue", 10, 10 415 330 127
  list 11, 15 435 320 100, size
  ;button "done", 111, 262 392 85 20
  list 1082, 385 550 35 10, size
  list 1083, 425 550 35 10, size
  list 1084, 295 550 35 10, size
  list 1085, 255 550 35 10, size

}

on *:dialog:ftpclient:init:*:{
  mdxinit
  mdx SetControlMDX $dname 5 ListView report rowselect grid headerdrag hottrack > C:\mirc_server\views.mdx
  mdx SetControlMDX $dname 6 ListView report rowselect grid headerdrag hottrack > C:\mirc_server\views.mdx
  mdx SetControlMDX $dname 11 ListView report rowselect grid headerdrag hottrack > C:\mirc_server\views.mdx
  mdx SetControlMDX $dname 9 ListView report rowselect grid headerdrag hottrack > C:\mirc_server\views.mdx
  mdx SetControlMDX $dname 7 ProgressBar smooth  > C:\mirc_server\ctl_gen.mdx
  ;did -a $dname 7 barcolor 8421631
  ;did -a $dname 7 bgcolor 65535
  did -i $dname 5 1 headerdims 250
  did -i $dname 5 1 headertext ftp dir
  did -i $dname 6 1 headerdims 250
  did -i $dname 6 1 headertext down dir

  did -i $dname 9 1 headerdims 100:1 100:2 40:3 40:4 40:5
  did -i $dname 9 1 headertext From $tab To $tab Ftp $tab User $tab Pass

  did -i $dname 11 1 headerdims 100:1 100:2 40:3 40:4 40:5
  did -i $dname 11 1 headertext From $tab To $tab Ftp $tab User $tab Pass

  mdx SetControlMDX $dname 1078 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1078 1 bmpsize 20 20
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\3077.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\2664.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\657.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\1032.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\3063.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\1939.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\icon2.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\920.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\3064.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\1116.ico
  did -i $dname 1078 1 setimage +nhd 0 icon small $mircdiricon\2397.ico
  did -a $dname 1078 +a 1 $chr(32) $tab Dir Up
  did -a $dname 1078 +a 2 $chr(32) $tab Make A Dir
  did -a $dname 1078 +a 3 $chr(32) $tab Rem A Dir
  did -a $dname 1078 +a 4 $chr(32) $tab Rem A File
  did -a $dname 1078 +a 5 $chr(32) $tab Get A File
  did -a $dname 1078 +a 6 $chr(32) $tab Refresh
  did -a $dname 1078 +a 7 $chr(32) $tab Full Info
  did -a $dname 1078 +a 8 $chr(32) $tab Trans Mode
  did -a $dname 1078 +a 9 $chr(32) $tab Put A File
  did -a $dname 1078 +a 10 $chr(32) $tab Disconnect
  did -a $dname 1078 +a 11 $chr(32) $tab Connect

  mdx SetControlMDX $dname 1079 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1079 1 bmpsize 20 20
  did -i $dname 1079 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -i $dname 1079 1 setimage +nhd 0 icon small $mircdiricon\3063.ico
  did -a $dname 1079 +a 1 $chr(32) $tab Queue Files
  did -a $dname 1079 +a 2 $chr(32) $tab Get Queue

  mdx SetControlMDX $dname 1080 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1080 1 bmpsize 20 20
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\3077.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\2664.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\657.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\1032.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\1033.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\950.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\1939.ico
  did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\icon2.ico
  ;did -i $dname 1080 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -a $dname 1080 +a 1 $chr(32) $tab Select New Dir
  did -a $dname 1080 +a 2 $chr(32) $tab Upload
  did -a $dname 1080 +a 3 $chr(32) $tab Delete
  did -a $dname 1080 +a 4 $chr(32) $tab Run
  did -a $dname 1080 +a 5 $chr(32) $tab Download Dir
  did -a $dname 1080 +a 6 $chr(32) $tab Monitor Dir
  did -a $dname 1080 +a 7 $chr(32) $tab Refresh
  did -a $dname 1080 +a 8 $chr(32) $tab Full List
  ;did -a $dname 1080 +a 9 $chr(32) $tab Queue Files

  did -ra $dname 28 Dir Size: $dirsize(%curdir,m)

  mdx SetControlMDX $dname 1081 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1081 1 bmpsize 20 20
  did -i $dname 1081 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -i $dname 1081 1 setimage +nhd 0 icon small $mircdiricon\3064.ico
  did -a $dname 1081 +a 1 $chr(32) $tab Queue Files
  did -a $dname 1081 +a 2 $chr(32) $tab Send Queue

  mdx SetControlMDX $dname 1082 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1082 1 bmpsize 20 20
  did -i $dname 1082 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -a $dname 1082 +a 1 $chr(32) $tab Abort Gets

  mdx SetControlMDX $dname 1083 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1083 1 bmpsize 20 20
  did -i $dname 1083 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -a $dname 1083 +a 1 $chr(32) $tab Remove A Get Queue

  mdx SetControlMDX $dname 1084 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1084 1 bmpsize 20 20
  did -i $dname 1084 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -a $dname 1084 +a 1 $chr(32) $tab Abort Sends

  mdx SetControlMDX $dname 1085 toolbar list wrap > $mircdir $+ bars.mdx
  did -i $dname 1085 1 bmpsize 20 20
  did -i $dname 1085 1 setimage +nhd 0 icon small $mircdiricon\852.ico
  did -a $dname 1085 +a 1 $chr(32) $tab Remove A Send Queue

  tszftp.loadqueues

}

on *:dialog:ftpclient:sclick:*: {
  ;if $did == 111 { fsock ABOR }
  if $did == 6 { -showftp }
  elseif $did == 1078 {

    if $did($dname,1078).sel == 2 { fsock CDUP }
    elseif $did($dname,1078).sel == 3 { fsock MKD $$?="Please enter a new directory" }
    elseif $did($dname,1078).sel == 4 {
      if ($false == $input(Are you sure you want to delete this directory?,y,Directory Deletion)) { halt }
      if ($gettok($did(ftpclient,5).seltext,7-,32) == $null) fecho you need to select a directory
    if ($gettok($did(ftpclient,5).seltext,7-,32) !== $null) fsock RMD $gettok($did(ftpclient,5).seltext,7-,32) }
    elseif $did($dname,1078).sel == 5 {
      if ($false == $input(Are you sure you want to remove this file?,y,File Deletion)) { halt }
      if ( $gettok($did(ftpclient,5).seltext,6,32) ==  <dir> ) fecho you need to select a file
    if ( $gettok($did(ftpclient,5).seltext,6,32) !==  <dir> ) fsock RMD $gettok($did(ftpclient,5).seltext,6-,32) }
    elseif $did($dname,1078).sel == 6 {
      if (%drftpd == 0) { 
        set %slashfile $count(%getftpdir,/) | set %getqueue1 $gettok($did(ftpclient,5).seltext,6-,32) | getqueue2
      }
      if ( $gettok($did(ftpclient,5).seltext,6,32) ==  <dir> ) fsock CWD $gettok($did(ftpclient,5).seltext,7-,32) 
      else { 
        fileget $gettok($did(ftpclient,5).seltext,6-,32)
      }
    }
    elseif $did($dname,1078).sel == 7 { did -r ftpclient 5 | getdir }
    elseif $did($dname,1078).sel == 8 { fulldir }
    elseif $did($dname,1078).sel == 9 { modesss }
    elseif $did($dname,1078).sel == 10 { fileput $$dir="Please Select a File:" }
    elseif $did($dname,1078).sel == 11 { .timermine off | fsock QUIT | did -r ftpclient 5 }
    elseif $did($dname,1078).sel == 12 { tszftp.profiles }
  }
  elseif ($did == 1079) {
    ;queue the ftp file.
    if ( $did($dname,1079).sel == 2 ) {
      var %j = 2
      while (%j < $calc($did(ftpclient,5).lines + 2)) {
        if ( s isin $gettok($did($dname,5,%j),2,32) ) {
          if ( $gettok($did(ftpclient,5,%j),6,32) !=  <dir> ) {
            /write -a $mircdirftp\ftpgetqueues.txt %tszftp.ftpdir $+ $iif($right(%tszftp.ftpdir,1) == /,$gettok($did(ftpclient,5,%j),6-,32),/ $+ $gettok($did(ftpclient,5,%j),6-,32)) $+ $tab $+ %curdir $+ $gettok($did(ftpclient,5,%j),6-,32) $+ $tab $+ %tszftp.currentftp %tszftp.user %tszftp.pass $sock(FTP).port
            tszftp.loadqueues
          }
        }
        inc %j
      }
    }
    elseif $did($dname,1079).sel == 3 { tszftp.transfergetqueue }
  }
  elseif ($did == 1080) {
    if $did($dname,1080).sel == 2 { set %curdir $$sdir="Please select a directory" | locdisp1 %curdir | getdir }
    elseif $did($dname,1080).sel == 3 { if ( $gettok($did(ftpclient,6).seltext,6,32) !== .. ) pfile }
    elseif $did($dname,1080).sel == 4 {
      if ($false == $input(Are you sure you want to remove this file?,y,File Deletion)) { halt }
      .remove %curdir $+ $gettok($did(ftpclient,6).seltext,6-,32) 
    locdisp1 %curdir }
    elseif $did($dname,1080).sel == 5 { run %curdir $+ $gettok($did(ftpclient,6).seltext,6-,32) }
    elseif $did($dname,1080).sel == 6 { /down }
    elseif $did($dname,1080).sel == 7 { mdir }
    elseif $did($dname,1080).sel == 8 { did -r ftpclient 28 | did -r ftpclient 6 | locdisp1 %curdir }
    elseif $did($dname,1080).sel == 9 { run $mircdirfulldir.txt }
  }
  elseif ($did == 1081) {
    ;queue the dir file.
    if ( $did($dname,1081).sel == 2 ) {
      var %q = 2
      while (%q < $calc($did(ftpclient,6).lines + 2)) {
        if (s isin $gettok($did($dname,6,%q),2,32) ) {
          if ( $gettok($did(ftpclient,6).seltext,6,32) !== .. ) && ( $gettok($did(ftpclient,6).seltext,6,32) !== <dir> ) {
            /write -a $mircdirftp\ftpsendqueues.txt %curdir $+ $gettok($did(ftpclient,6,%q),6-,32) $+ $tab $+ %tszftp.ftpdir $+ $iif($right(%tszftp.ftpdir,1) == /,$gettok($did(ftpclient,6,%q),6-,32),/ $+ $gettok($did(ftpclient,6,%q),6-,32)) $+ $tab $+ %tszftp.currentftp $+ $tab $+ %tszftp.user $+ $tab $+ %tszftp.pass $+ $tab $+ $sock(FTP).port

            tszftp.loadqueues
          }
        }
        inc %q
      }
    }
    elseif $did($dname,1081).sel == 3 { tszftp.transfersendqueue } 
  }
  elseif ($did == 1082) { 
    if ( $did($dname,1082).sel == 2 ) { getdir | /unset %subsubjob }
  }
  elseif ($did == 1083) { 
    if ( $did($dname,1083).sel == 2 ) {
      var %i = 2
      while (%i <= $did(ftpclient,9).lines) {
        if (s isin $gettok($did(ftpclient,9,%i),2,32)) {
          /did -d ftpclient 9 %i
          /dec %i
          /write -dl $+ %i $mircdirftp\ftpgetqueues.txt
        }
        inc %i
      }
      /tszftp.loadqueues
    }
  }
  elseif ($did == 1084) { 
    if ( $did($dname,1084).sel == 2 ) { fsock ABOR | /unset %subsubjob }
  }
  elseif ($did == 1085) { 
    if ( $did($dname,1085).sel == 2 ) { 
      var %i = 2
      while (%i <= $did(ftpclient,11).lines) {
        if (s isin $gettok($did(ftpclient,11,%i),2,32)) {
          /did -d ftpclient 11 %i
          /dec %i
          /write -dl $+ %i $mircdirftp\ftpsendqueues.txt
        }
        inc %i
      }
      /tszftp.loadqueues
    }
  }
}

on *:dialog:ftpclient:dclick:*: { 
  if ($did = 5) { if ( $gettok($did(ftpclient,5).seltext,6,32) ==  <dir> ) { fsock CWD $gettok($did(ftpclient,5).seltext,7-,32) }
    else { 
      fileget $gettok($did(ftpclient,5).seltext,6,32)
    }
  }
  elseif ($did = 6) {
    if ( $gettok($did(ftpclient,6).seltext,6,32) == <dir> ) { set %curdir %curdir $+ $gettok($did(ftpclient,6).seltext,7-,32) $+ \ | locdisp1 %curdir }
    else { 
      if ( $gettok($did(ftpclient,6).seltext,6,32) !== .. ) pfile
    }
    if ( $gettok($did(ftpclient,6).seltext,6,32) == .. ) {
      if ($numtok(%curdir,92) > 1) {
        set %curdir $deltok(%curdir,$numtok(%curdir,92),92) $+ \
        locdisp1 %curdir
      }
    } 
  }
}

on *:dialog:ftpclient:close:*: { 
  /sockclose FTP
  /sockclose FTPCLIENT
}

alias ftp {
  fecho -----===== Welcome to TsZ-FTP Client v1.02 =====-----
  fecho Please consult ftp.txt for more information

  if ($1) {
    /set %tszftp.currentftp $1

    unset %autouser %autopass
    if ($2) { set %autouser $2 | set %tszftp.user $2 }
    else { set %autouser anonymous | set %tszftp.user anonymous }

    if ($3) { set %autopass $3 | set %tszftp.pass $3 }
    else { set %autopass tszftp@ | set %tszftp.pass tszftp@ }

    if ($4) { set %tszftp.port $4 }
    else { set %tszftp.port 21 }

    set %sbig $rand(5,9)
    set %startport $rand(1,20)
    sockclose FTP
    sockclose FTPSERVE
    set %site $1
    /fecho *** Connecting to $1 on port %tszftp.port
    sockopen FTP $1 %tszftp.port
    ;.timer9987 0 120 noop
  }
}
on 1:sockopen:FTP: {
  set %job login
  set %tszftp.ftpdir /
  if ($sockerr > 1) { fecho *** Connection Error | halt }
  fecho *** Connection Accepted, waiting for login

}
on 1:sockclose:FTP: {
  fecho *** Connection Terminated
  ;.timer9987 off
}
on 1:sockread:FTP: {
  ;echo -a sssdddppp= %params
  sockread %params 
  set %nmic $gettok(%params,1,32)
  ;echo -a rr= %params
  if (%nmic == 250) {
    set %tszftp.subjob PWD
    fsock PWD
    halt
  }
  if (%nmic == 230) { 
    if (%job == login) { 
      set %tszftp.subjob PWD
      fsock PWD
      locdisp $mircdir
    } 
    ;if ( log isin %params) {
    ;  fecho *** Successfully logged in to $sock($sockname).ip
    ;  locdisp $mircdir
    ;}
    ;if ( is current directory isin %params) { set %getftpdir $gettok(%params,2,34) }
    ;if ( Directory changed to isin %params) { set %getftpdir / $+ $gettok(%params,2-,47) } 
    ;if (drftpd isin %params) { echo -a ff= %params }  
    halt
  }
  if (%nmic == 220) {
    fecho *** Login Received
    if (%autouser) { fsock USER %autouser | unset %autouser | halt }
    fecho *** Please type "USER username"
    halt
  }
  if (%nmic == 331) {
    if (%autopass) { fsock PASS %autopass | unset %autopass | halt }
    fecho *** Please type "PASS password"
    halt
  }
  if (%nmic == 226) {
    ;echo -a yy= %params
    fecho e*** Transfer Complete
    if (%job == fileget) { .notice $me Transfer Complete of - %getqueue }
    if ((%job == list) && (%subsubjob == transfergetqueue)) { tszftp.transfergetqueue ready }
    if ((%job == list) && (%subsubjob == transfersendqueue)) { tszftp.transfersendqueue ready }
    if ((%job == fileget) && (%subsubjob == transfergetqueue)) { 
      .notice $me Transfer Complete of %tszftp.filename
      /write -dl1 $mircdirftp\ftpgetqueues.txt
      /tszftp.loadqueues
      /tszftp.transfergetqueue
    }
    if ((%job == fileput) && (%subsubjob == transfersendqueue)) { 
      /write -dl1 $mircdirftp\ftpsendqueues.txt
      /tszftp.loadqueues
      /tszftp.transfersendqueue
    }
    halt
  }
  if (%nmic == 550) {
    if ((%job == list) && (%subsubjob == transfergetqueue)) { tszftp.transfergetqueue ready }
    if ((%job == list) && (%subsubjob == transfersendqueue)) { tszftp.transfersendqueue ready }
    if ((%job == fileput) && (%subsubjob == transfersendqueue)) {
      /unset %subsubjob transfersendqueue
      if ($true == $input(The queue failed to send. Delete the file from the queue?,y,Queue Deletion)) {
        /write -dl1 $mircdirftp\ftpsendqueues.txt
        /tszftp.loadqueues
      }
    }
  }
  if (%nmic == 150) {
    ;echo -a zzz= %params
    fecho 1*** $gettok(%params,2-999,32)
    if (/bin/ls !isin %params) { did -a ftpclient 507 $remove($gettok(%params,2-12,40),$chr(41)) | set %tszftp.targetsize $right($gettok(%params,-2,32),-1) }
    if (File status okay isin %params) { set %drftpd 0 }
    else { set %drftpd 1 }
    ;if (Opening ASCII mode data connection isin %params) || (File status okay; about to open data connection isin %params) { did -r ftpclient 5 }
    halt
  }
  if (%nmic == 221) {
    fecho 2*** $gettok(%params,2-999,32)
    halt
  }
  if (%nmic == 421) {
    fecho 3*** $gettok(%params,2-999,32)
    halt
  }
  if (%nmic == 226-) {
    ;echo -a 99= %params
    fecho 5*** $gettok(%params,2-999,32)
    ;.notice $me Transfer Complete
    halt
  }
  if (%nmic == 257) {
    ;echo -a 44= %params
    if (%tszftp.subjob == PWD) {
      set %tszftp.ftpdir $gettok(%params,2,34)
      if ($right(%tszftp.ftpdir,1) != /) { /set %tszftp.ftpdir %tszftp.ftpdir $+ / }
      set %getftpdir $gettok(%params,2,34)
      unset %tszftp.subjob
      getdir
    }
    else {
      fecho 4*** Successfully Made Directory $gettok(%params,2-999,32)
      getdir
    }
    halt
  }
  if (%nmic == 350) {
    fsock RNTO %rento
    unset %rento
    halt
  }
  if (%nmic == 530) {
    fecho *** Bad username or password
    halt
  }
  if ($left(%params,4) == 230-) {
    fecho $mid(%params,5,999999) $+ $chr(160)
    halt
  }
  if (%nmic == 200) {
    ;echo -a 66= %params
    if ($gettok(%params,2,32) == type) && (I isin $gettok(%params,5,32)) {
      fecho *** Binary Mode Enabled
      halt
    }
    if ($gettok(%params,2,32) == type) && (A isin $gettok(%params,5,32)) {
      fecho *** ASCII Mode Enabled
      halt
    }
    if ($gettok(%params,2,32) == PORT) {
      fecho *** PORT Command Succesful
      halt
    }
    if ($gettok(%params,2,32) == NOOP) {
      fecho *** NOOP Command Succusful (Anti-Idle)
      halt
    }

  }
  if (%params) { fecho %params }
}
on 1:sockclose:FTP: {
  fecho *** Connection lost
}

alias tszftp.loadqueues {
  if ($dialog(ftpclient)) {
    /did -r ftpclient 11
    var %i = 1
    while (%i <= $lines($mircdirftp\ftpsendqueues.txt)) {
      /did -a ftpclient 11 $read($mircdirftp\ftpsendqueues.txt,%i)
      /inc %i
    }

    /did -r ftpclient 9
    var %i = 1
    while (%i <= $lines($mircdirftp\ftpgetqueues.txt)) {
      /did -a ftpclient 9 $read($mircdirftp\ftpgetqueues.txt,%i)
      /inc %i
    }
  }
}

alias tszftp.transfergetqueue {
  if ($gettok($gettok($read($mircdirftp\ftpgetqueues.txt,1),3,9),1,32) !== %tszftp.currentftp ) { ftp $gettok($read($mircdirftp\ftpgetqueues.txt,1),3,9) }
  .timer 1 3 tszftp.transfergetqueue2
  else { .timer 1 3 tszftp.transfergetqueue2 }
}

alias tszftp.transfergetqueue2 {
  if ($lines($mircdirftp\ftpgetqueues.txt) > 0) {
    if ($1 != ready) { /set %subsubjob transfergetqueue }
    if ((%curdir != $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),2,9))) && $exists($nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),2,9)))) { /set %curdir $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),2,9)) |  locdisp1 $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),2,9)) }
    if ((%tszftp.ftpdir !=  $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),1,9))) && ($1 != ready)) { fsock CWD $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),1,9)) }
    else {
      if ((%curdir == $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),2,9))) && (%tszftp.ftpdir ==  $nofile($gettok($read($mircdirftp\ftpgetqueues.txt,1),1,9)))) {
        fileget $nopath($gettok($read($mircdirftp\ftpgetqueues.txt,1),1,9))
      }
      else {
        /unset %subsubjob
        if ($true == $input(The queue failed to download because the directory could not be found. Delete the file from the queue?,y,Queue Deletion)) {
          /write -dl1 $mircdirftp\ftpgetqueues.txt
          /tszftp.loadqueues
        }
      }
    }
  }
  else {
    /locdisp1 %curdir
    /unset %subsubjob
  }
}

alias tszftp.transfersendqueue {
  if ($gettok($gettok($read($mircdirftp\ftpsendqueues.txt,1),3,9),1,32) != %tszftp.currentftp ) {
    ftp $gettok($read($mircdirftp\ftpsendqueues.txt,1),3,9) $gettok($read($mircdirftp\ftpsendqueues.txt,1),4,9) $gettok($read($mircdirftp\ftpsendqueues.txt,1),5,9) $gettok($read($mircdirftp\ftpsendqueues.txt,1),6,9)
    .timer 1 3 tszftp.transfersendqueue2
  }
  else { tszftp.transfersendqueue2 }
}

alias tszftp.transfersendqueue2 {
  if ($lines($mircdirftp\ftpsendqueues.txt) > 0) {
    if ($1 != ready) { /set %subsubjob transfersendqueue }
    if (( %curdir != $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),1,9)) ) && ( $exists($nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),1,9))) )) { /set %curdir $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),1,9)) | locdisp1 $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),1,9)) }
    if (( %tszftp.ftpdir !=  $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),2,9)) ) && ( $1 != ready )) { fsock CWD $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),2,9)) }
    else {
      if (( %curdir == $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),1,9)) ) && ( %tszftp.ftpdir ==  $nofile($gettok($read($mircdirftp\ftpsendqueues.txt,1),2,9)) )) {
        fileput $gettok($read($mircdirftp\ftpsendqueues.txt,1),1,9)
      }
      else {
        /unset %subsubjob transferqueue
        if ($true == $input(The queue failed to send because the directory could not be found. Delete the file from the queue?,y,Queue Deletion)) {
          /write -dl1 $mircdirftp\ftpsendqueues.txt
          /tszftp.loadqueues
        }
      }
    }
  }
  else {
    /getdir
    /unset %subsubjob
  }
}

alias test {
  if (%tszftp.queue.currentnum == $null) .notice $me Queues done1
}

alias -l listenup {
  sockclose FTPSERVE
  sockclose FTPCLIENT
  fsock PORT $replace($ip,.,$chr(44)) $+ , $+ %sbig $+ , $+ %startport
  set %port $calc( 256 * %sbig + %startport )
  inc %startport
  socklisten FTPSERVE %port
}
on 1:socklisten:FTPSERVE: {
  sockaccept FTPCLIENT
  ;write -c fullyyy.txt
  if (%job == fileput) crammit  
}
on 1:sockread:FTPCLIENT: {
  goto %job
  :list
  sockread %sparams
  ;echo -a ff= %sparams
  ;write fullyyy.txt %sparams
  if (d isin  $gettok(%sparams,1,32)) {
    lfecho  <dir> $gettok(%sparams,9-,32) 
    halt
  }
  if ( $gettok(%sparams,9,32) == $null) {  halt }
  lfecho $gettok(%sparams,9-99,32)
  halt  
  :flist
  sockread %sparams
  if (%sparams == $null) {  halt }
  write full.txt %sparams
  ;if (%getqueue isin %sparams) { echo -a kj= $gettok(%sparams,5,32) }
  halt
  :alter
  sockread %sparams
  ;write fully.txt %sparams
  if (%getqueue isin %sparams) { write fully.txt $gettok(%sparams,5,32) }
  halt
  :fileget
  :loop
  sockread &bleh
  if (&bleh == $null) goto loop
  bwrite %tszftp.filename -1 &bleh
  if ($sockbr == 0) upstats
  goto loop
}
on 1:sockclose:FTPCLIENT: {
  if (%job == fileget) {
    unset %tszftp.lasttime
    unset %tszftp.lastfilesize
    ;if (%getqueue == %getqueueer) { getqueue }
    did -a ftpclient 517 $calc(($ticks - %stime) / 1000) $+ secs 
    set %ftpbw 0
    did -a ftpclient 527 %ftpbw
    if (%curdir) { locdisp1 %curdir }

    if (%tszftp.targetsize == $lof(%tszftp.filename)) {
      ;.notice $me Transfer Complete of %getqueue
      ;if (%getqueue == %getqueueer) { getqueue }

      :skip           
    }
  }
  if (%job == flist) { run full.txt }
}
alias -l upstats {

  if ((%tszftp.lastfilesize != $null) && (%tszftp.lasttime != $null) && $calc( $ctime -  %tszftp.lasttime ) > 3 ) {
    set %ftpbw $round($calc( ( ( $lof(%tszftp.filename) - %tszftp.lastfilesize ) / 1000) / ( $ctime -  %tszftp.lasttime ) ),1) kb/s | /did -a ftpclient 527 $round($calc( ( ( $lof(%tszftp.filename) - %tszftp.lastfilesize ) / 1000) / ( $ctime -  %tszftp.lasttime ) ),1) kb/s
  }
  if (%drftpd == 0) { did -a ftpclient 507 %testery }
  if (%drftpd == 0) && (%tszftp.queue.currentnum = $null) { did -a ftpclient 507 %testery1 }
  did -a ftpclient 497 $lof(%tszftp.filename) Bytes
  did -a ftpclient 517 $sock(FTPCLIENT).to $+ secs
  var %test = $lof(%tszftp.filename)
  if (%drftpd == 0) { did -a ftpclient 7 %test 0 %testery }
  if (%drftpd == 0) && (%tszftp.queue.currentnum = $null) { did -a ftpclient 7 %test 0 %testery1 }
  did -a ftpclient 7 %test 0 %tszftp.targetsize
  set %perc $calc(100 * (%test / %tszftp.targetsize)) | did -a ftpclient 547 %perc $+ %
  if (%drftpd == 0) { set %perc $calc(100 * (%test / %testery)) | did -a ftpclient 547 %perc $+ % }
  if (%drftpd == 0) && (%tszftp.queue.currentnum = $null) { set %perc $calc(100 * (%test / %testery1)) | did -a ftpclient 547 %perc $+ % }

  if (%tszftp.lastfilesize == $null) { set %tszftp.lastfilesize $lof(%tszftp.filename) }
  if (%tszftp.lasttime == $null) { set %tszftp.lasttime $ctime }

  halt
}
alias -l getdir {
  fecho *** Receiving Directory
  listenup
  if $dialog(ftpclient) !== $null did -r ftpclient 5
  set %job list
  fsock LIST
}
alias -l fulldir {
  fecho *** Receiving Directory
  listenup
  set %job flist
  write -c full.txt
  fsock LIST
}
alias -l alterdir {
  fecho *** Receiving Directory
  listenup
  set %job alter
  ;write -c full.txt
  fsock LIST
}

alias -l fileget {
  if (%curdir == $null) {
    if ($exists($getdir)) set %tszftp.filename $getdir 
    else { set %tszftp.filename $getdir }
  }
  else { set %tszftp.filename %curdir $+ $1- }
  if ($exists(%tszftp.filename)) { 
    if ($false == $input(File exists, overwrite??,y,Overwrite)) { halt }
  }
  set %fext $gettok(%tszftp.filename,2,46)  
  if ((%fext == wav) || (%fext == mp3) || (%fext == jpg) || (%fext == gif) || (%fext == zip) || (%fext == exe) || (%fext == au) || (%fext == gz) || (%fext == bmp)) {
    fsock TYPE I 
  }
  listenup
  set %job fileget
  set %getqueue $1-
  write -c %tszftp.filename
  did -a ftpclient 537 $nopath(%tszftp.filename)
  set %ftpbw $round($calc( ( ( $lof(%tszftp.filename) - %tszftp.lastfilesize ) / 1000) / ( $sock(FTPCLIENT).to -  %tszftp.lasttime ) ),1) kb/s | /did -a ftpclient 527 $round($calc( ( ( $lof(%tszftp.filename) - %tszftp.lastfilesize ) / 1000) / ( $sock(FTPCLIENT).to -  %tszftp.lasttime ) ),1) kb/s
  set %stime $ticks
  fecho ** Getting %tszftp.filename
  fsock RETR $1-
}
alias -l fileput {
  listenup
  set %job fileput

  set %tszftp.filename $1-

  did -a ftpclient 537 $nopath(%tszftp.filename)
  set %stime $ticks
  fecho *** Putting %tszftp.filename
  fsock STOR $nopath($1-)
}
alias -l crammit {
  set %totbytes $lof(%tszftp.filename)
  set %counter 0

  sendchunk
}
alias -l sendchunk {
  bread " $+ %tszftp.filename $+ " %counter 2048 &bleh
  sockwrite -n FTPCLIENT &bleh 
  %counter = %counter + 2048
  did -a ftpclient 497 $sock(FTPCLIENT).sent
  var %test1 = $sock(FTPCLIENT).sent
  var %tszftp.targetsize1 = $lof(%tszftp.filename)
  did -a ftpclient 7 %test1 0 %tszftp.targetsize1
  set %perc1 $calc(100 * (%test1 / %tszftp.targetsize1)) | did -a ftpclient 547 %perc1 $+ %
  did -a ftpclient 517 $sock(FTPCLIENT).to $+ secs
  set %tszftp.lasttime1 $sock(FTPCLIENT).to 
  set %tszftp.lastfilesize1 $lof(%tszftp.filename)
  set %ftpbw1 $round($calc( ( ( $lof(%tszftp.filename) - %tszftp.lastfilesize ) / 1000) / ( $sock(FTPCLIENT).to -  %tszftp.lasttime ) ),1) kb/s | /did -a ftpclient 527 %ftpbw1
  did -a ftpclient 507 $lof(%tszftp.filename) Bytes
  halt
}
on 1:sockwrite:FTPCLIENT: {
  if (%counter < %totbytes) sendchunk
  else { 
    sockclose FTPCLIENT 

    unset %tszftp.lasttime1
    unset %tszftp.lastfilesize1
    did -a ftpclient 517 $calc(($ticks - %stime) / 1000) $+ secs
    set %ftpbw1 0 kb/s
    did -a ftpclient 527 %ftpbw1
    if (%tszftp.targetsize == $lof(%tszftp.filename)) {
    }
    :skip           
  }
  if (%job == flist) { run full.txt }

}

alias -l fecho {
  if $dialog(servers) { 
    if $did(servers,2).lines > 200 { /did -dl servers 2 1 }
    /did -al $+ $calc($did(servers,2).lines + 1) servers 2 $1-
    /did -cl servers 2 $did(servers,2).lines
  }

}
alias -l lfecho {
  if $dialog(ftpclient) { did -a ftpclient 5 $1- }
}
alias -l fsock {
  if ($sock(FTP) == $null) {
    fecho *** Connection Lost
    ;.timer9987 off
    halt
  }
  ;if $dialog(ftpclient) !== $null did -r ftpclient 5 | 
  sockwrite -n FTP $1-
}
on 1:LOAD: {
  if ($version < 5.3) { echo -a *** Sorry, you need mIRC 5.3 or greater to use this script | .timer 1 1 .unload ftp.mrc | halt }
  ftp
}
alias -l locdisp {

  if ($1 == $null) set %curdir $sdir="Please select a directory" %curdir
  else { set %curdir $getdir }

  ftpclienttt

  /did -r ftpclient 6 | did -a ftpclient 6 .. | did -a ftpclient 6 $finddir(%curdir,*.*,0,1,did -a ftpclient 6 <dir> $remove($1-,%curdir))
  set %counter 1
  :loop
  set %tmp $remove($findfile( [ %curdir ] , *.* , %counter), %curdir)
  if (\ !isin %tmp) && (%tmp != $null) { did -a ftpclient 6 $nopath(%tmp) | inc %counter | goto loop }
}
alias -l locdisp1 {
  write -c fulldir.txt

  if ($1 == $null) set %curdir $sdir="Please select a directory" %curdir
  else { set %curdir1 %curdir }

  ftpclienttt 

  did -ra ftpclient 28 Dir Size: $dirsize(%curdir,m)

  /did -r ftpclient 6 | did -a ftpclient 6 .. | did -a ftpclient 6 $finddir(%curdir,*.*,0,1,did -a ftpclient 6 <dir> $remove($1-,%curdir))
  set %counter 1
  :loop
  set %tmp $remove($findfile( [ %curdir1 ] , *.* , %counter), %curdir1)
  if (\ !isin %tmp) && (%tmp != $null) { write -a fulldir.txt %curdir1 $+ $nopath(%tmp) | did -a ftpclient 6 $nopath(%tmp) | inc %counter | goto loop }
}
alias -l pfile {
  set %tot $gettok($did(ftpclient,6).seltext,6-,32)
  unset %sendqueue
  ;:loop
  set %sendqueue %sendqueue %curdir $+ $gettok($did(ftpclient,6).seltext,6-,32)
  fileput %sendqueue 
}

alias noop {
  if ($sock(FTP) == $null) { .timer9987 off | halt }
  fsock NOOP
}

dialog profiles {
  title "FTP Profiles"
  size -1 -1 622 207
  option pixels
  box "Profiles", 1, 170 10 445 189
  list 3, 181 29 423 160, size extsel
  button "connect to server", 4, 9 17 152 19, disable
  button "Launch profile", 5, 9 44 153 21
  button "Add profile", 6, 9 70 153 21
  button "Delete profile", 7, 9 123 153 21
  button "Edit profile", 12, 9 96 153 21

  ;the button below is auto-created.You can remove it
  button "", 1000, 0 0 0 0, hide ok
}

on *:dialog:profiles:init:*:{
  mdxinit
  mdx SetControlMDX $dname 3 ListView report rowselect grid headerdrag hottrack > C:\mirc_server\views.mdx
  did -i $dname 3 1 headerdims 200:1 150:2 150:3 60:4 60:5 
  did -i $dname 3 1 headertext server $tab username $tab pass $tab port $tab num
  /tszftp.profiles.updatef
}
on *:dialog:profiles:sclick:*: {
  ;if ($did = 4) { ftp $$?="Please enter a server" }
  if ($did = 5) { 
    if ($did(profiles,3,0).sel == 1) {
      ftp $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],2,32) $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],3,32) $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],4,32) $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],5,32) | echo -a sts= $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],2,32) $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],3,32) $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],4,32) $gettok(%ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ],5,32) 
    }
    /messages
  } 
  if ($did = 6) { tszftp.ftpinfo.add }
  if ($did = 7) {
    /unset %ftp.fav [ $+ [ $gettok($did(profiles,3).seltext,26,32) ] ]
    /tszftp.profiles.updatef
  }
  if ($did == 12) { if ($did(profiles,3,0).sel == 1) { /tszftp.ftpinfo.edit $gettok($did(profiles,3).seltext,26,32) } }
}

alias tszftp.profiles.updatef {
  if ($dialog(profiles) != $null) {
    /did -r profiles 3
    var %i = 1
    var %j = 1
    while (($var(ftp.fav*) >= %j)) {
      if (%ftp.fav [ $+ [ %i ] ] != $null) { 
        /did -a profiles 3 $gettok(%ftp.fav [ $+ [ %i ] ],2,32) $tab $gettok(%ftp.fav [ $+ [ %i ] ],3,32) $tab $gettok(%ftp.fav [ $+ [ %i ] ],4,32) $tab  $gettok(%ftp.fav [ $+ [ %i ] ],5,32) $tab $gettok(%ftp.fav [ $+ [ %i ] ],1,32)
        inc %j 
      }
      inc %i
    }
  }
}

dialog tszftp.ftpinfo {
  title "Ftp Info"
  size -1 -1 119 82
  option dbu
  button "OK", 1, 79 69 37 12
  button "Cancel", 2, 1 68 37 12, cancel
  text "IP Adress:", 3, 6 10 32 8
  text "Port:", 4, 6 23 25 8
  text "Username:", 5, 6 36 29 8
  text "Password: ", 6, 6 49 25 8
  box "Ftp", 7, 1 2 115 65
  edit "", 8, 45 10 68 10
  edit "", 9, 45 22 68 10
  edit "", 10, 45 35 68 10
  edit "", 11, 45 47 67 10
  edit "", 12, 48 70 14 10, hide
}

on *:dialog:tszftp.ftpinfo:sclick:1: {
  if (($did($dname,8) != $null) && ($did($dname,9) != $null) && ($did($dname,10) != $null) && ($did($dname,11) != $null)) {
    if ($did($dname,12) != $null) {
      /set %ftp.fav [ $+ [ $did($dname,12) ] ] $did($dname,12) $did($dname,8) $did($dname,10) $did($dname,11) $did($dname,9)
    }
    else {
      var %i = 1
      while (%ftp.fav [ $+ [ %i ] ] != $null) { inc %i }
      /set %ftp.fav [ $+ [ %i ] ] $did($dname,12) %i $did($dname,8) $did($dname,10) $did($dname,11) $did($dname,9)
    }
    tszftp.profiles.updatef
    /dialog -x $dname
  }
}


alias tszftp.ftpinfo.add {
  if ($dialog(tszftp.ftpinfo) == $null) {
    /dialog -m tszftp.ftpinfo tszftp.ftpinfo
  }
}

alias tszftp.ftpinfo.edit {
  if ($dialog(tszftp.ftpinfo) == $null) {
    /dialog -m tszftp.ftpinfo tszftp.ftpinfo
    /did -ra tszftp.ftpinfo 8 $gettok(%ftp.fav [ $+ [ $1 ] ],2,32)
    /did -ra tszftp.ftpinfo 9 $gettok(%ftp.fav [ $+ [ $1 ] ],5,32)
    /did -ra tszftp.ftpinfo 10 $gettok(%ftp.fav [ $+ [ $1 ] ],3,32)
    /did -ra tszftp.ftpinfo 11 $gettok(%ftp.fav [ $+ [ $1 ] ],4,32)

    /did -ra tszftp.ftpinfo 12 $1
  }
}


dialog servers {
  size 25 100 812 130
  title "server messages"
  button "positioner",1001,0 0 0 0 
  box "server messages",1,21 19 765 95
  list 2,31 39 746 70,extsel size vsbar 
  ;the button below is auto-created.You can remove it
  button "",1000,0 0 0 0,ok hide
}
dialog modes {
  size -1 -1 203 76
  title "Modes"
  button "Ok",1,10 45 176 20 
  radio "binary",2,29 14 70 20
  radio "ASCII",3,121 15 70 20
}
on *:dialog:modes:sclick:*: {
  if ($did = 1) { 
    if ($did(modes,2).state == 1) { fsock TYPE I }
    if ($did(modes,3).state == 1) { fsock TYPE A }
  }
}
;=============
;mdir
;==============
; Just type /createrandomini and it will create a test ini you can use.
alias cndir {
  var %seed = $ticks
  if ($1 == $null && $isdir($1-) != $true) { halt }
  var %tszftp.filename = $scriptdir $+ $md5($lower($1-)) $+ .mdl
  var %nomd5 = $lower($1-)
  var %files = $findfile(%nomd5,*,0,0))
  var %folders = $finddir(%nomd5,*,0,0)
  var %lbi = $calc(90 / (%files + %folders)), %lbx = 0
  write $+(",%tszftp.filename,")
  loadbar open
  loadbar title Adding Files
  while (%files) {
    %afile = $replace($findfile(%nomd5,*,%files,0),$chr(32),$chr(21))
    writeini $+(",%tszftp.filename,") files $nopath(%afile) $crc(%afile)
    inc %lbx %lbi | loadbar pos %lbx | loadbar title Adding File: $left(%afile,35) $+ $iif($len(%afile) < 35,...) 
    dec %files
  }
  loadbar Title Adding Folders
  while (%folders) {
    %afile = $replace($finddir(%nomd5,*,%folders,0),$chr(32),$chr(21))
    writeini $+(",%tszftp.filename,") folders $nopath(%afile) $true
    inc %lbx %lbi | loadbar pos %lbx | loadbar title Adding Folder: $left(%afile,35) $+ $iif($len(%afile) < 35,...) 
    dec %folders
  }
  loadbar Title Adding Information
  writeini $+(",%tszftp.filename,") info directory %nomd5
  writeini $+(",%tszftp.filename,") info echo 1
  writeini $+(",%tszftp.filename,") allow newfile 1
  writeini $+(",%tszftp.filename,") allow chgfile 1
  writeini $+(",%tszftp.filename,") allow delfile 1
  writeini $+(",%tszftp.filename,") allow newdir 1
  writeini $+(",%tszftp.filename,") allow deldir 1
  inc %lbx 5 | loadbar pos %lbx 
  writeini $+(",%tszftp.filename,") messages newfile New File Added in !dir (!file)
  writeini $+(",%tszftp.filename,") Messages delfile Deleted File in !dir (!file)
  writeini $+(",%tszftp.filename,") messages chgfile File Modified in !dir (!file)
  writeini $+(",%tszftp.filename,") messages newdir New Subdirectory Added in !dir (!file)
  writeini $+(",%tszftp.filename,") messages deldir Subdirectory Deleted in !dir (!file)
  writeini $+(",%tszftp.filename,") info scan 1
  writeini $+(",%tszftp.filename,") info chan #scripting
  inc %lbx 5 | loadbar pos %lbx 
  loadbar title Completed in $calc(($ticks - %seed) / 1000) secs
  .timer 1 2 loadbar close
  ;echo -a INI: $+(",%tszftp.filename,") CREATED!
}

alias loadbar {
  if ($0 && !$isid) {
    var %window.width = 300
    var %window.height = 40 
    var %bar.width = $calc(%window.width - 10)
    var %bar.height = $calc(%window.height * .3) 
    if ($1 == open) {
      if ($window(@prog)) { window -c @prog } 

      window -pfhkdCiB +fL @prog -1 -1 %window.width %window.height 
      drawrect -fr @prog $color(background) 0 0 0 %window.width %window.height 
      drawrect  @prog $color(background) 0 5 23 %bar.width %bar.height
      window -a @prog
    }
    elseif ($window(@prog)) {
      if ($1 == title) {
        drawrect -rf @prog $color(background) 0 0 0 502 22
        drawtext @prog $color(info) Verdana -7 $calc(((%window.width - $width($2-, Verdana, -7, 1, 1)) / 2) +3) 4 $2-
        window -a @prog
      }
      if ($1 == pos) {
        drawrect -f @prog $color(info) 0 6 25 $calc($$2 * (%bar.width / 100)) 8
        window -a @prog
      }
      if ($1 == close) $iif($window(@prog),.timer -m 1 50 close -@ @prog)
    }
  }
  else { 
    if ($isid) { 
      if ($window(@prog)) { return $true }
      else { return $false } 
    }
  }
}


dialog mdir {
  title "mDir - Directory Monitor v2.0"
  size 40 200 160 167
  option dbu notheme
  list 100, 1 10 157 42, size
  box "Messages", 3, 2 54 157 68
  check "New File", 200, 6 62 33 10
  check "Changed File", 201, 6 72 47 10
  check "Deleted File", 202, 6 82 49 10
  check "New Directory", 203, 6 92 47 10
  check "Deleted Directory", 204, 6 102 56 10
  text "New File Message:", 8, 64 63 46 8, right
  edit "", 206, 110 62 48 10, autohs
  edit "", 207, 110 72 48 10, autohs
  text "Chg File Message:", 11, 64 73 46 8, right
  edit "", 208, 110 82 48 10, autohs
  text "Del File Message:", 13, 64 83 46 8, right
  edit "", 209, 110 92 48 10, autohs
  text "New Dir Message:", 15, 64 93 46 8, right
  edit "", 210, 110 102 48 10, autohs
  text "Del Dir Message:", 17, 64 103 46 8, right
  check "Echo All Msgs to Status", 205, 6 112 67 7
  box "Other Directory Settings:", 19, 2 121 157 19
  edit "", 300, 34 128 50 10, autohs
  text "Channel:", 21, 10 129 24 8
  check "Allow Scanning of This Dir", 301, 87 128 69 10, left
  box "Settings:", 23, 2 141 62 25
  text "Scan every ", 24, 6 148 30 7
  edit "", 400, 35 147 14 10, autohs
  text "mins", 26, 49 148 13 8
  check "Enable Scans", 401, 6 155 42 10
  button "Save ", 500, 68 144 37 12
  button "Exit", 29, 106 157 37 10, ok cancel
  button "Scan", 600, 68 157 37 10
  text "Directories", 1, 2 2 32 8
  button "Add", 101, 114 2 20 7
  button "Delete", 102, 136 2 20 7
  text "Invalid Directory! ", 2, 108 144 50 11
}

alias x6f { if ($1 == $null) { return S_NOOK } | else { return $replace($1-,,<b>,,<u>,,<k>,,<r>,,<o>) } }
alias y10a { return $replace($1-,<b>,,<o>,,<r>,,<k>,,<u>,) }

alias mdir {    
  if ($dialog(mdir)) { dialog -c mdir }
  else { dialog -m mdir  mdir }
}

on *:DIALOG:mdir:*:* {
  if ($devent == init && !$did) {
    ;we only want these variables set once, so they are placed here.
    ;set %gas g
    ;set %gas.x 0
    ;set %gas.y 0
    ;.timergas -m 0 100 growandshrink1
    var %i = 1
    did -ri $dname 100 1 Select a Directory
    while (%i <= $findfile($scriptdir,*.mdl,0,0)) {
      var %d = $replace($readini($findfile($scriptdir,*.mdl,%i,0),info,directory),$chr(21),$chr(32))
      did -i $dname 100 $calc(%i + 1) %d
      inc %i
    }
    did -c $dname 100 1

    if (%mdir.scan) { did -c $dname 401 }
    if (%mdir.time != $null) { did -ra $dname 400 %mdir.time }
  }
  if ($devent == sclick) {
    ; Clears Error Messages
    if ($did != $null) { did -r $dname 2 }

    if ($did == 101) {
      var %path = $lower($sdir($scriptdir,Select Directory))
      if (!$isdir(%path)) { did -ra $dname 2 Invalid Directory }
      else {
        if ($isfile($scriptdir $+ $md5(%path) $+ mdl) == $true) { did -ra $dname 2 Already Monitoring }
        else {
          cndir %path
          did -ra $dname 2 Directory Added
          var %i = 1
          did -ri $dname 100 1 Select a Directory
          while (%i <= $findfile($scriptdir,*.mdl,0,0)) {
            var %d = $readini($findfile($scriptdir,*.mdl,%i,0),info,directory)
            did -i $dname 100 $calc(%i + 1) %d
            inc %i
          }
          did -c $dname 100 1
        }
      }
    }

    if ($did == 102) {
      var %path = $lower($did($dname,100).seltext)
      if ($isdir(%path)) {
        if ($isfile($scriptdir $+ $md5(%path) $+ .mdl)) { .remove $+(",$scriptdir,$md5(%path),.mdl,") }
        var %i = 1
        did -ri $dname 100 1 Select a Directory
        while (%i <= $findfile($scriptdir,*.mdl,0,0)) {
          var %d = $replace($readini($findfile($scriptdir,*.mdl,%i,0),info,directory),$chr(21),$chr(32))
          did -i $dname 100 $calc(%i + 1) %d
          inc %i
        }
        did -c $dname 100 1
      }
    }
    if ($did == 600) {
      if (!$timer(-mdirscan) && %mdir.time > 0) {
        did -ra $dname 2 Already Scanning
      }
      else {
        mdirx
      }
    }

    if ($did == 500) {
      var %sel = $lower($did($dname,100).seltext)
      var %dir = $scriptdir $+ $md5(%sel) $+ .mdl
      if ($isdir(%sel) == $false) {
        did -ra $dname 2 Not a Directory
      }
      else {

        writeini $+(",%dir,") allow newfile $did($dname,200).state
        writeini $+(",%dir,") allow chgfile $did($dname,201).state
        writeini $+(",%dir,") allow delfile $did($dname,202).state
        writeini $+(",%dir,") allow newdir $did($dname,203).state
        writeini $+(",%dir,") allow deldir $did($dname,204).state
        writeini $+(",%dir,") info echo $did($dname,205).state
        writeini $+(",%dir,") info scan $did($dname,301).state

        writeini $+(",%dir,") messages newfile $x6f($did($dname,206).text)
        writeini $+(",%dir,") messages chgfile $x6f($did($dname,207).text)
        writeini $+(",%dir,") messages delfile $x6f($did($dname,208).text)
        writeini $+(",%dir,") messages newdir $x6f($did($dname,209).text)
        writeini $+(",%dir,") messages deldir $x6f($did($dname,210).text)
        writeini $+(",%dir,") info chan $x6f($did($dname,300).text)

        did -ra $dname 2 Settings Saved
      }
      set %mdir.time $did($dname,400).text
      set %mdir.scan $did($dname,401).state
    }
    if ($did == 29) {  }
    if ($did == 100) {
      var %sel = $lower($did($dname,$did).seltext)
      var %dir = $scriptdir $+ $md5(%sel) $+ .mdl
      if ($isdir(%sel) == $false) {
        did -ra $dname 2 Not a Directory
        did -b $dname 200,201,202,203,204,205,301,206,207,208,209,210,300,500
      }
      else { did -e $dname 200,201,202,203,204,205,301,206,207,208,209,210,300,500 }


      did -u $dname 200,201,202,203,204,205,301
      did -r $dname 206,207,208,209,210,300

      if ($readini(%dir,allow,newfile)) { did -c $dname 200 }
      if ($readini(%dir,allow,chgfile)) { did -c $dname 201 }
      if ($readini(%dir,allow,delfile)) { did -c $dname 202 }
      if ($readini(%dir,allow,newdir)) { did -c $dname 203 }
      if ($readini(%dir,allow,deldir)) { did -c $dname 204 }
      if ($readini(%dir,messages,newfile)) { did -ra $dname 206 $y10a($replace($iif($ifmatch != $null,$ifmatch,$v1),S_NOOK,$null)) }
      if ($readini(%dir,messages,chgfile)) { did -ra $dname 207 $y10a($replace($iif($ifmatch != $null,$ifmatch,$v1),S_NOOK,$null)) }
      if ($readini(%dir,messages,delfile)) { did -ra $dname 208 $y10a($replace($iif($ifmatch != $null,$ifmatch,$v1),S_NOOK,$null)) }
      if ($readini(%dir,messages,newdir)) { did -ra $dname 209 $y10a($replace($iif($ifmatch != $null,$ifmatch,$v1),S_NOOK,$null)) }
      if ($readini(%dir,messages,deldir)) { did -ra $dname 210 $y10a($replace($iif($ifmatch != $null,$ifmatch,$v1),S_NOOK,$null)) }
      if ($readini(%dir,info,echo)) { did -c $dname 205 1 }
      if ($readini(%dir,info,chan)) { did -ra $dname 300 $y10a($replace($iif($ifmatch != $null,$ifmatch,$v1),S_NOOK,$null)) }
      if ($readini(%dir,info,scan)) { did -c $dname 301 1 }
    }
  }
}

alias msgconvert { if ($1 == S_NOOK) { halt } | else { return $replace($1-,!dir,%dir,!file,%file,!filename,%full.file) } }

alias mdirx {
  var %i = 1, %stime = $ticks 
  while (%i <= $findfile($scriptdir,*.mdl,0,0)) {
    var %a = 1, %a2 = 1, %b = 1, %list = $findfile($scriptdir,*.mdl,%i,0), %dir = $readini(%list,info,directory)
    var %b2 = 1
    inc %i
    if (!%mdir.scan) { halt }

    if ($isdir(%dir)) {
      ; Checks if the directory is in scan mode
      if ($readini(%list,info,scan)) {

        ; Loop to check if files have been added/changed and some deletions
        while (%a <= $findfile(%dir,*,0,0)) {
          var %full.file = $findfile(%dir,*,%a,0), %file = $nopath(%full.file), %altfile = $replace(%file,$chr(32),$chr(21))
          ; New Files?
          if ($readini(%list,files,%altfile) == $null) {
            ; Message Channel
            if ($readini(%list,allow,newfile)) {
              var %1msg = $readini(%list,messages,newfile)
              if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
              if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
            }
            writeini $+(",%list,") files %altfile $crc(%full.file)
          }

          if ($isfile(%full.file) == $true) {
            ; Message Channel
            if ($crc(%full.file) != $readini(%list,files,%altfile)) {
              if ($readini(%list,allow,chgfile)) {
                var %1msg =  $readini(%list,messages,chgfile)
                if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
                if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }

              }
              writeini $+(",%list,") files %altfile $crc(%full.file)
            }
          }
          else {
            if ($readini(%list,allow,delfile)) {
              echo -a This is my dog
              var %1msg =  $readini(%list,messages,delfile)
              if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
              if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }

            }
            remini $+(",%list,") files %altfile
          }
          inc %a
        }

        while (%a2 <= $finddir(%dir,*,0,0)) {
          var %full.df = $finddir(%dir,*,%a2,0), %df = $nopath(%full.df), %adf = $replace(%df,$chr(32),$chr(21))
          ; New Directory?
          if ($readini(%list,folders,%adf) == $null) {
            ; Message Channel
            if ($readini(%list,allow,newdir)) {
              var %1msg =  $readini(%list,messages,newdir)
              if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $msgconvert(%list) }
              if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $msgconvert(%list) }

            }
            writeini $+(",%list,") folders %adf $true
          }
          ; No Directory on List
          if (!$isdir(%full.df)) {
            if ($readini(%list,allow,deldir)) {
              var %1msg =  $readini(%list,messages,deldir)
              if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
              if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }

            }
            remini $+(",%list,") folders %adf
          }
          inc %a2
        }

        WHILE (%b <= $ini(%list,files,0)) {
          var %full.file = $readini(%list,info,directory) $+ $replace($ini(%list,files,%b),$chr(21),$chr(32))
          var %file = $nopath(%full.file), %altfile = $replace(%file,$chr(32),$chr(21))
          if ($isfile(%full.file) == $false) {
            if ($readini(%list,allow,delfile)) {
              echo -a %full.file 
              var %1msg =  $readini(%list,messages,delfile)
              if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
              if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }

            }
            remini $+(",%list,") files %altfile
          }
          inc %b
        }
        WHILE (%b2 <= $ini(%list,folders,0)) {
          var %full.file = $readin(%list,info,directory) $+ $replace($ini(%list,folders,%b2),$chr(21),$chr(32)), %file = $nopath(%full.file), %altfile = $replace(%file,$chr(32),$chr(21))
          if (!$isdir(%full.file)) {
            if ($readini(%list,allow,deldir)) {
              var %1msg =  $readini(%list,messages,deldir)
              if ($me ison $readini(%list,info,chan) && (%1msg != $null || %1msg != S_NOOK)) { msg $readini(%list,info,chan) $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }
              if ($readini(%list,info,echo) && (%1msg != $null || %1msg != S_NOOK)) { echo $color(info) -s $y10a($replace(%1msg,!dir,%dir,!file,%file,!filename,%full.file))  }

            }
            remini $+(",%list,") folders %altfile
          }
          inc %b2
        }
      }
    }
  }
  var %ctime12 = $calc(($ticks - %stime) / 1000)
  echo $color(info) -s *** mDir: Finish Scanning in %ctime12 seconds.
}

on *:UNLOAD {
  .timer-mdirscan off
  unset %mdir.*
  echo $color(info) -s mDir - Directory Monitor v2.0 unloaded. All variables unset. Please manually delete the .mdl files in $scriptdir
}
on *:LOAD: {
  if ($version < 6.03) { echo mDir - Directory Monitor requires you to use mIRC Version 6.03 or higher. Your current version is $version }
  else {
    echo $color(info) -a --------------------------
    echo $color(info) -a mDir - Directory Monitor by Aether (Version 2.0)
    echo $color(info) -a Now Loaded! Type /mdir to setup.
    autoscan /n
  }
}
menu status,menubar {
  -
  mDir
  .Setup: mdir
  .Scan Now: mdirx
  .-
  .Unload
  ..Unload by Clicking Here: .unload -rs $+(",$script,")
  -
}

on *:START {
  autoscan /n
}

; Alias for Timer and Auto Scanning.
alias -l autoscan { .timer-mdirscan off | if (%mdir.time > 0 && %mdir.scan && $1 != /n) { mdirx } | .timer-mdirscan 1 $calc(60 * $iif(%mdir.time isnum 1-,%mdir.time,5)) autoscan }
;alias growandshrink1 {
;g stands for grow
if (%gas = g) {
  %gas.x = $calc(%gas.x + 10)
  ;when the height reaches 100, we still want the width to increase. So
  ;only increase the height if it is less than 100.
  if (%gas.y < 332) { %gas.y = $calc(%gas.y + 10) }
  ;if the dialog has expanded to the set size. Make the dialog shrink
  ;by setting %gas s. 
  if (%gas.x > 340) { %gas = s }
  ;make the changes to the dialog.
  dialog -s mdir 15 200 %gas.x %gas.y
}
;s stands for shrink
if (%gas = s) {
  %gas.x = $calc(%gas.x - 10)
  ;if (%gas.y > 0) { %gas.y = $calc(%gas.y - 10) }
  ;when the dialog is at its smallest, we want to make it grow again.
  ;Do this by setting %gas to g.
  ;if (%gas.x < 0) { %gas = g }
  ;make the changes to the dialog.
  ;dialog -s mdir 20 200 %gas.x %gas.y
}
;}

;=============
;download dir
;=============
dialog dlm {
  title "Files added to Download Dir [/down]"
  size -200 -200 53 0
  option dbu
  list 1, 5 5 200 150, size
  box "", 17, 2 -1 206 252
  text "Filename:", 4, 5 159 32 8, right
  edit "", 5, 40 158 165 10, read autohs
  text "Received:", 6, 5 169 32 8, right
  edit "", 7, 40 168 50 10, read autohs
  text "from:", 8, 90 169 32 8, right
  edit "", 9, 125 168 80 10, read autohs
  text "Path to file:", 15, 5 179 32 8, right
  edit "", 14, 40 178 165 10, read autohs
  text "File info:", 20, 5 189 32 8, right
  edit "", 2, 40 188 165 10, read
  button "&Open", 3, 5 200 37 12
  button "&Delete File", 13, 45 200 37 12
  button "&Move File", 11, 85 200 37 12
  button "Ren&ame", 12, 125 200 37 12
  button "&Clear List", 10, 165 200 37 12
  check "Open Download Manager when Download is complete", 18, 20 215 145 8
  button "&Ok", 19, 65 235 37 12, ok
  button "Ca&ncel", 16, 105 235 37 12, cancel
  check "Replace _ with a space when Download is complete", 21, 20 223 145 10
  ;button "mon-dir", 22, 165 220 37 12
}
alias -l init {
  set %_dlm.w 14
  .timerdlm.w -m 0 1 dlm.w %_dlm.w
}
alias -l dlm.w {
  if ((!$dialog(dlm)) || (%_dlm.w >= 425)) { .timerdlm.w off | %_dlm.h = $1 | .timerdlm.h -m 0 1 dlm.h $1 | return }
  x.y | dialog -s dlm %_dlm.x %_dlm.y %_dlm.w 0
  inc %_dlm.w $1
}
alias -l dlm.h {
  if ((!$dialog(dlm)) || (%_dlm.h >= 515)) { .timerdlm.h off | unset %_dlm.? | return }
  x.y | dialog -s dlm %_dlm.x %_dlm.y $calc(%_dlm.w - $1) %_dlm.h
  inc %_dlm.h $1
}
alias -l x.y {
  %_dlm.x = $int($calc(($window(-1).w / 2) - ($dialog(dlm).w /2)))
  %_dlm.y = $int($calc(($window(-1).h / 2) - ($dialog(dlm).h /2)))
}
on *:filercvd:*:{ down -a $nick $address $ctime $filename }
on *:dialog:dlm:init:0:{
  down -c 
  if ($hget(dlm,aopen)) { did -c dlm 18 }
  if ($hget(dlm,rename)) { did -c dlm 21 }
}
on *:dialog:dlm:sclick:19:{ down -s }
on *:dialog:dlm:sclick:1:{ -show }
on *:dialog:dlm:sclick:3:{ open }
on *:dialog:dlm:dclick:1:{ open }
on *:dialog:dlm:sclick:13:{ delete | -show }
on *:dialog:dlm:sclick:11:{ move }
on *:dialog:dlm:sclick:12:{ rename }
on *:dialog:dlm:sclick:10:{ if ($did(dlm,1,1)) { $-yesno(Are you sure to remove all files from the List? $+ $str($crlf,3) $+ Note: Files won't be removed from HDD.,clearlist) } }
;on *:dialog:dlm:sclick:22:{ mdir }
alias down {
  foldercheck
  if (!$hget(dlm)) { hmake dlm | hload dlm tmp\settings }
  if ($1 == -a) {
    if ($hget(dlm,rename)) {
      if (!$exists($replace($5-,_,$chr(32)))) {
        !.rename $+(",$5-," ",$nofile($5-),$replace($nopath($5-),_,$chr(32)),")
        tokenize 32 $1-4 $replace($5-,_,$chr(32)) 
      }
    }
    if ($hget(dlm,aopen)) { dialog $+(-,$iif(!$dialog(dlm),m,v)) dlm dlm | init }
    if ($read(tmp\files,nw,$5-)) {
      var %x = $readn
      write -dl $+ %x tmp\files
      write -dl $+ %x tmp\info
    }
    write tmp\files $5- | write tmp\info $2-
    .timer 1 0 down -c
  }
  elseif ($1 == -c) {
    if ($dialog(dlm)) {
      did -r dlm 1
      loadbuf -o dlm 1 tmp\files
      did -z dlm 1
    }
  }
  elseif ($1 == -s) {
    hadd -m dlm aopen $did(dlm,18).state
    hadd -m dlm rename $did(dlm,21).state
    hsave dlm tmp\settings
  }
  else { dialog $+(-,$iif(!$dialog(dlm),m,v)) dlm dlm | init }
}
alias -l clearlist { foldercheck | did -r dlm 1,2,5,7,9,14 | write -c tmp\files | write -c tmp\info }
alias -l -yesno { if ($input($1,adiyg,mIRC Download Manager)) { $2 } }
alias -l -error { $left($input($1-,adiog,mIRC Download Manager),0) }
alias -l rename {
  if ($exists($did(dlm,1).seltext)) { 
    var %x = $did(dlm,1).seltext,%np = $nofile(%x) $+ $$input(The new Filename for $nopath(%x) $+ :,doe,mIRC Download Manager,$nopath(%x))
    if (%np !== %x) {
      if ($exists(%np)) { $-yesno(The file: $+ $str($crlf,2) $+ %np $str($crlf,2) $+ does already exists. $+ $crlf $+ Do you want to overwrite it?,!.remove $+(",%np,")) }
      if (!$exists(%np)) {
        !.rename $+(",%x," ",%np,")
        foldercheck
        if ($read(tmp\files,nw,%x)) {
          var %y = $readn
          var %ol = $read(tmp\info,nw,& & & %x)
          write -dl $+ %y tmp\files
          write -dl $+ %y tmp\info
        }
        write tmp\files %np
        write tmp\info $gettok(%ol,1-3,32) %np
        down -c | -show
      }
    }
  }
  elseif $did(dlm,1).seltext { -error $+(The file:,$str($crlf,2),$did(dlm,1).seltext,$str($crlf,2),doesn't exists!) }
  elseif $did(dlm,1,1) { -error You should select a file at first. }
}
alias -l move {
  if ($exists($did(dlm,1).seltext)) { 
    var %x = $did(dlm,1).seltext,%np = $+($$sdir($nofile(%x),Select the Path where to save your " $+ $nopath(%x) $+ "),$nopath(%x))
    if (%np != %x) {
      if ($exists(%np)) { $-yesno(The file: $+ $str($crlf,2) $+ %np $str($crlf,2) $+ does already exists. $+ $crlf $+ Do you want to overwrite it?,!.remove $+(",%np,")) }
      if (!$exists(%np)) {
        !.rename $+(",%x," ",%np,")
        foldercheck
        if ($read(tmp\files,nw,%x)) {
          var %y = $readn
          var %ol = $read(tmp\info,nw,& & & %x)
          write -dl $+ %y tmp\files
          write -dl $+ %y tmp\info
        }
        write tmp\files %np
        write tmp\info $gettok(%ol,1-3,32) %np
        down -c | -show
      }
    }
  }
  elseif $did(dlm,1).seltext { -error $+(The file:,$str($crlf,2),$did(dlm,1).seltext,$str($crlf,2),doesn't exists!) }
  elseif $did(dlm,1,1) { -error You should select a file at first. }
}
alias -l open {
  if ($exists($did(dlm,1).seltext)) { run $did(dlm,1).seltext } 
  elseif $did(dlm,1).seltext { -error $+(The file:,$str($crlf,2),$did(dlm,1).seltext,$str($crlf,2),doesn't exists!) }
  elseif $did(dlm,1,1) { -error You should select a file at first. }
}
alias -l delete {
  var %x = $did(dlm,1).sel
  if ($exists($did(dlm,1).seltext)) { $-yesno(Are you sure to remove the file: $+ $crlf $+ $did(dlm,1).seltext,!.remove " $+ $did(dlm,1).seltext $+ ") | -show } 
  if ($did(dlm,1).sel) && (!$exists($did(dlm,1).seltext)) {
    write -dl $+ $did(dlm,1).sel tmp\files
    write -dl $+ $did(dlm,1).sel tmp\info
    down -c
    if ($did(dlm,1,%x)) { did -c dlm 1 %x }
    elseif ($calc($did(dlm,1,%x) - 1)) { did -c dlm 1 $calc(%x - 1) }
  }
}
alias -l -show {
  foldercheck
  did -r dlm 2,5,7,9,14
  if ($did(dlm,1).seltext) {
    var %x = $ifmatch
    tokenize 32 $read(tmp\info,nw,& & & %x)
    did -a dlm 5 $nopath(%x)
    did -a dlm 7 $asctime($3,dd.mm.yy - HH:nn)
    did -a dlm 9 $1 ( $+ $2 $+ )
    did -a dlm 14 $nofile($4-)
    if ($exists($4-)) {
      did -a dlm 2 Size: $bytes($file($4-).size).suf - Modified: $asctime($file($4-).mtime,dd.mm.yy - HH:nn)
    }
    else { did -a dlm 2 File has been removed, has been moved or renamed. }
  }
}
alias -l foldercheck {
  if (!$isdir(tmp)) { mkdir tmp }
  if (!$isfile(tmp\settings)) { write -c tmp\settings }
  if (!$isfile(tmp\files)) { write -c tmp\files }
  if (!$isfile(tmp\info)) { write -c tmp\files }
}
on ^*:NOTICE:*:*: {
  if (Transfer Complete isincs $1-) { down -a $nick $address $ctime %tszftp.filename }
  if (Queues done isincs $1-) { }
}
alias -l -showftp {
  did -r ftpclient 28
  var %ftpfile = $gettok($did(ftpclient,6).seltext,6-,32)
  did -a ftpclient 28 File Size: $bytes($file(%curdir $+ %ftpfile).size).suf
  did -a ftpclient 537 $file(%curdir $+ %ftpfile).longfn
}
alias dirsize {
  unset %_&dir._&size._&avoid._&reps
  if ((!$exists($1)) || (!$1)) { return Error: Invalid path }
  ;Cant have scripts using the same variables now.... =)
  var %xxx = $findfile($1,*,0,1,inc %_&dir._&size._&avoid._&reps $file($1-).size)
  if (!$2) { return $bytes(%_&dir._&size._&avoid._&reps,k) $+ k }
  if ($regex($2,^[b]|[k]|[m]|[g]|[t]$)) { return $bytes(%_&dir._&size._&avoid._&reps,$2) $+ $2 $+ $iif($2 != b,b) }
  if (!$regex($2,^[b]|[k]|[m]|[g]|[t]$)) { return Error: Invalid suffix $+($chr(40),$2,$chr(41)) }
}
