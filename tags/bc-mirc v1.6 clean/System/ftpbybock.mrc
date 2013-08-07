alias ftp_config {
  /dialog -mravd FTPbyBOCK FTPbyBOCK
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; START ON *

on *:START:{
  /echo -a You are using $logo(FTP)
  /set %ftpon off
}

on *:CONNECT:{
  if ( %ftponstartup == on ) { /ftpstart }
}

on *:DISCONNECT: { /set %ftpon off }

on *:TEXT:!list:%ftpchan1,%ftpchan2,%ftpchan3,%ftpchan4:{
  if (($nick isvo $chan) || ($nick ishelp $chan) || ($nick isop $chan)) {
    if ( %ftpon == off ) { goto finall }
    if ( %style == 1 ) { goto style1s }
    if ( %style == 2 ) { goto style2s }
    :style1s
    if ( %address == IP ) { goto atyle1adIPs }
    .notice $nick  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ (ONLINE!)  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ %address $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Description:  $+ %ftpcol2 $+ ( $+ %note $+ ) $logo(FTP)
    goto finall
    :atyle1adIPs
    .notice $nick  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ (ONLINE!)  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ $ip $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Description:  $+ %ftpcol2 $+ ( $+ %note $+ ) $logo(FTP)
    goto finall
    :style2s
    if ( %address == IP ) { goto atyle2adIPs }
    .notice $nick  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE!  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ %address  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Description:  $+ %ftpcol2 $+ %note $logo(FTP)
    goto finall
    :atyle2adIPs
    .notice $nick  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE!  $+ %ftpcol1 $+ Address: $+ %ftpcol2 $ip  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Description:  $+ %ftpcol2 $+ %note $logo(FTP)
    :finall
  }
}

on 1:text:@find *:%ftpchan1,%ftpchan2,%ftpchan3,%ftpchan4:{
  if (($nick isvo $chan) || ($nick ishelp $chan) || ($nick isop $chan)) { 
    if ( %atfind == n ) { goto gaguga }
    if ( %ftpon == off ) { goto gaguga }
    set %needfile $2-

    if ($exists( $findfile( %rootftp ,%needfile, 1 ) ) == $true) { 
      .msg $nick $logo(FTPsearch) $+  I have %needfile on my ftp at
      .msg $nick  $+ $findfile( %rootftp ,%needfile, 1 ) 
      .msg $nick  10 Address ( 6 %address 10 ) Port ( 6 %port 10 ) User ( 6  %login 10 ) Pass ( 6 %pass 10 ) 
    }
    if ($exists( $findfile( %rootftp ,$2-, 2 ) ) == $true) {
      .msg $nick  $+ %ftpcol2 $+ $findfile( %rootftp ,%needfile, 2 )
    }
    if ($exists( $findfile( %rootftp ,$2-, 3 ) ) == $true) {
      .msg $nick  $+ %ftpcol2 $+ $findfile( %rootftp ,%needfile, 3 ) 
      .timer 1 5 .msg $nick Please Specific filename: too many results.
    }
    if ($exists( $findfile( %rootftp ,%needfile, 1 ) ) == $false) {
      .msg $nick $logo(FTPSearch) $+  $+  Sorry, i dont have that file. 
    }
    :gaguga
  }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ON *

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  START DIALOG

dialog FTPbyBOCK {
  title "Advertise FTP Config"
  size -1 -1 302 171
  option dbu
  box "General Settings", 1, 3 3 190 123
  box "Extra Settings", 2, 197 3 100 50
  icon 90, 195 112 104 37, $mircdirsystem\graphics\ftp.bmp, 0, noborder
  text "Advertise FTP Version 2.0b is used for people who having problems with setting up Fserve ports because of router or Internet Service Provider problems. This is only to advertise FTP info, you need to setup a FTP server first. Use Serv-U or BulletProff FTP Server.", 3, 195 57 105 52
  box "Channels", 4, 3 129 190 40
  box "IP settings", 5, 6 12 70 70
  box "Login Info", 435, 6 86 70 34
  box "Speed", 834, 79 12 110 50
  box "Note", 814, 79 65 110 55
  text "Else type in the IP here:", 324, 12 34 70 10
  text "Port:", 756, 12 57 70 10
  text "Login:", 545, 12 96 70 10
  text "Pass:", 546, 12 108 70 10
  text "FTP Connection Speed:", 874, 84 21 70 10
  text "Number of max. users allowed:", 864, 84 40 90 10
  text "Describe what's on your ftp:", 869, 84 75 90 10
  text "You should also tell if passive mode should be enable to enter your ftp.", 269, 85 98 96 19
  text "Channel 1:", 700, 7 139 70 10
  text "Channel 2:", 701, 7 153 70 10
  text "Channel 3:", 702, 90 139 70 10
  text "Channel 4:", 703, 90 153 70 10
  text "FTP Root Dir:", 291, 205 35 90 10
  button "Click for own IP", 100, 12 22 55 10
  edit "", 101, 12 44 57 10
  edit "", 102, 12 65 57 10
  edit "", 103, 30 95 40 10
  edit "", 104, 30 107 40 10
  edit "", 105, 84 29 50 10
  edit "", 106, 84 48 50 10
  edit "", 107, 84 85 100 10
  edit "", 111, 35 138 50 10
  edit "", 112, 35 152 50 10
  edit "", 113, 119 138 50 10
  edit "", 114, 119 152 50 10
  check "Start on connect", 121, 205 9 88 15
  check "Use @find like c:\ftp\ps2", 122, 205 20 87 15
  edit "", 123, 240 34 50 10
  button "Set Style", 999, 197 103 100 10, hide ok
  button "OK", 900, 196 153 50 15, ok
  button "Cancel", 901, 248 153 50 15, cancel
}

on *:DIALOG:FTPbyBOCK:edit:*: {
  if ($did == 101) { 
  set %address $did(101).text }
  if ($did == 102) { 
  set %port $did(102).text }
  if ($did == 103) { 
  set %login $did(103).text }
  if ($did == 104) { 
  set %pass $did(104).text }
  if ($did == 105) { 
  set %speed $did(105).text }
  if ($did == 106) { 
  set %mnumber $did(106).text }
  if ($did == 107) { 
  set %note $did(107).text }
  set %ftpchan1 $did(111).text 
  set %ftpchan2 $did(112).text 
  set %ftpchan3 $did(113).text 
  set %ftpchan4 $did(114).text 
  ;  if ($did == 110) { 
  ;  set %delay $did(110).text }
  if ($did == 123) { 
  set %rootftp $did(123).text }
}

on *:DIALOG:FTPbyBOCK:sclick:*: {
  ;this event reacts when a mouse clicks once on an item. 
  if ($did == 100) {
  set %address IP }
  if ($did == 999) {
  Style }
  if ($did == 122) {
    if (%atfind == on ) { unset %atfind | halt }
    if (%atfind == $null ) { set %atfind on | halt }
  }
  if ($did == 121) {
    if (%ftponstartup == on ) { unset %ftponstartup | halt }
    if (%ftponstartup == $null ) { set %ftponstartup on | halt }
  }
}

on *:DIALOG:FTPbyBOCK:init:0: {
  if (%address == IP ) { did -a FTPbyBOCK 101 Your IP | goto next }
  if (%address != $null ) { did -a FTPbyBOCK 101 %address }
  :next
  if (%port != $null ) { did -a FTPbyBOCK 102 %port }
  if (%login != $null ) { did -a FTPbyBOCK 103 %login }
  if (%pass != $null ) { did -a FTPbyBOCK 104 %pass }
  if (%speed != $null ) { did -a FTPbyBOCK 105 %speed }
  if (%mnumber != $null ) { did -a FTPbyBOCK 106 %mnumber }
  if (%note != $null ) { did -a FTPbyBOCK 107 %note }
  ;  if (%delay != $null ) { did -a FTPbyBOCK 110 %delay }
  if (%ftpchan1 != $null ) { did -a FTPbyBOCK 111 %ftpchan1 }
  if (%ftpchan2 != $null ) { did -a FTPbyBOCK 112 %ftpchan2 }
  if (%ftpchan3 != $null ) { did -a FTPbyBOCK 113 %ftpchan3 }
  if (%ftpchan4 != $null ) { did -a FTPbyBOCK 114 %ftpchan4 }
  if (%rootftp != $null ) { did -a FTPbyBOCK 123 %rootftp }
  if (%ftponstartup == on) { did -c FTPbyBOCK 121 }
  if (%atfind == on) { did -c FTPbyBOCK 122 }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  END DIALOG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ALIASES

alias style {
  /clear -a
  /echo -a What-to-enter:
  /echo -a Enter the first color for your Script
  /echo -a 1,0 0 0,1 1 0,2 2 0,3 3 0,4 4 0,5 5 0,6 6 0,7 7 1,8 8 1,9 9 0,10 10 1,11 11 0,12 12 0,13 13 0,14 14 1,15 15 
  /set %ftpcol1 $?="Enter the first color here:"
  /clear -a
  /echo -a What-to-enter:
  /echo -a Enter the second color for your Script
  /echo -a 1,0 0 0,1 1 0,2 2 0,3 3 0,4 4 0,5 5 0,6 6 0,7 7 1,8 8 1,9 9 0,10 10 1,11 11 0,12 12 0,13 13 0,14 14 1,15 15 
  /set %ftpcol2 $?="Enter the second color here:"
  /clear -a
  /echo -a  Style:
  /echo -a Style 1:
  if ( %address == IP ) { goto xman }
  //echo -a  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ (ONLINE!)  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ %address $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  goto finish
  :xman
  //echo -a  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ (ONLINE!)  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ $ip $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  :finish
  /echo -a Style 2:
  if ( %address == IP ) { goto xman2 }
  //echo -a  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE!  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ %address  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  goto finish2
  :xman2
  //echo -a  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE!  $+ %ftpcol1 $+ Address: $+ %ftpcol2 $ip  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  :finish2
  :initialize
  /set %style $?="Enter nuber of style here:"
}

alias ftpsay {
    if ( %style == 1 ) { goto style1h }
  if ( %style == 2 ) { goto style2h }
  :style1h
  if ( %address == IP ) { goto atyle1adIPh }
  .notice $me   $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan1 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ %address $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  if ( %ftpchan2 == $null ) { goto endah }
  .timer 1 8 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan2 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ %address $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  if ( %ftpchan3 == $null ) { goto endah }
  .timer 1 12 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan3 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ %address $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  if ( %ftpchan4 == $null ) { goto endah }
  .timer 1 16 .notice $me   $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan4 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ %address $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  halt
  :atyle1adIPh
  .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan1 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ $ip $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  if ( %ftpchan2 == $null ) { goto endah }
  .timer 1 8 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan2 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ $ip $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  if ( %ftpchan3 == $null ) { goto endah }
  .timer 1 12 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan3 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ $ip $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  if ( %ftpchan4 == $null ) { goto endah }
  .timer 1 16 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ( ONLINE! on %ftpchan4 )  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ ( $+ $ip $+ )  $+ %ftpcol1 $+ Port:  $+ %ftpcol2 $+ ( $+ %port $+ )  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ ( $+ %login $+ / $+ %pass $+ )  $+ %ftpcol1 $+ Max users:  $+ %ftpcol2 $+ ( $+ %mnumber $+ )  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ ( $+ %speed $+ )  $+ %ftpcol1 $+ Note:  $+ %ftpcol2 $+ ( $+ %note $+ ) $+ $logo(FTP)
  halt
  :style2h
  if ( %address == IP ) { goto atyle2adIPh }
  .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan1  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ %address  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  if ( %ftpchan2 == $null ) { goto endah }
  .timer 1 8 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan2  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ %address  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  if ( %ftpchan3 == $null ) { goto endah }
  .timer 1 12 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan3  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ %address  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  if ( %ftpchan4 == $null ) { goto endah }
  .timer 1 16 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan4  $+ %ftpcol1 $+ Address:  $+ %ftpcol2 $+ %address  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  halt
  :atyle2adIPh
  .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan1  $+ %ftpcol1 $+ Address: $+ %ftpcol2 $ip  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  if ( %ftpchan2 == $null ) { goto endah }
  .timer 1 8 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan2  $+ %ftpcol1 $+ Address: $+ %ftpcol2 $ip  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  if ( %ftpchan3 == $null ) { goto endah }
  .timer 1 12 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan3  $+ %ftpcol1 $+ Address: $+ %ftpcol2 $ip  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  if ( %ftpchan4 == $null ) { goto endah }
  .timer 1 16 .notice $me  $+ %ftpcol1 $+ FTP:  $+ %ftpcol2 $+ ONLINE! on %ftpchan4  $+ %ftpcol1 $+ Address: $+ %ftpcol2 $ip  $+ %ftpcol1 $+ Port: $+ %ftpcol2 %port  $+ %ftpcol1 $+ Login/Pass:  $+ %ftpcol2 $+ %login $+ / $+ %pass  $+ %ftpcol1 $+ Max users: $+ %ftpcol2 %mnumber  $+ %ftpcol1 $+ Speed:  $+ %ftpcol2 $+ %speed  $+ %ftpcol1 $+ Note:  $+ %note $+ $logo(FTP)
  :endah
}

alias ftpstart {
  /set %ftpon on
  //echo -a  $+ %ftpcol1 $+ The FTP server has been Started. Now Advertising in channel(s):  $+ %ftpcol2 $+ %ftpchan1 %ftpchan2 %ftpchan3 %ftpchan4 
  .timer 1 5 /join %ftpchan1
  if ( %ftpchan2 != $null ) { .timer 1 10 join %ftpchan2 }
  if ( %ftpchan3 != $null ) { .timer 1 15 join %ftpchan3 }
  if ( %ftpchan4 != $null ) { .timer 1 20 join %ftpchan4 }
  ;.timerfor_ftp 0 %delay /ftpsay
}

alias ftpoff {
  /set %ftpon off
  ;.timerfor_ftp off
  /echo -a  $+ %ftpcol1 $+ The FTP server advert has been stopped
}


alias ftpquiet {
  .timerfor_ftp
  //echo -a  $+ %ftpcol1 $+ The FTP server has been Started in QUIET mode. Now Advertising in channel(s):  $+ %ftpcol2 $+ %ftpchan1 %ftpchan2 %ftpchan3 %ftpchan4 
  /set %ftpon on
}

;;;;;;;;; rest
