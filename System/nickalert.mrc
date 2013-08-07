dialog NickHighlight2 {
  title "NickAlert Extended Information"
  size -1 -1 170 238
  option dbu

  box "Nickname", 1, 47 -1 67 19
  edit "", 2, 52 7 59 10, read center

  box "Address", 3, 0 17 170 33
  edit "", 4, 8 24 155 10, read autohs center
  combo 5, 85 36 60 60, size drop
  text "Address format:", 6, 38 38 39 8

  box "Time", 7, 0 52 170 23
  combo 9, 35 61 50 50, size drop
  edit "", 10, 96 61 50 10, read center
  text "TimeZone :", 8, 4 63 27 8

  box "Message", 11, 0 76 170 135
  list 12, 3 83 165 126, read multi autovs

  box "Other Information", 13, 0 211 170 27
  text "Server :", 14, 20 217 20 8
  text "Network :", 15, 75 217 24 8
  text "Channel :", 16, 130 217 23 8
  edit "", 17, 3 226 50 10, read center
  edit "", 18, 60 226 50 10, read center
  edit "", 19, 116 226 50 10, read center
}
dialog NickHighlight {
  title "NickAlert v1.0 [ /nickalert ]"
  size -1 -1 400 315
  option pixels

  button "Options",1,250 290 50 20
  list 2,0 0 400 295
  button "Clear List",3,150 290 100 20
  button "stop song",4,50 290 100 20
}
dialog NickHighlight_options {
  title "NickAlert Options"
  size -1 -1 175 100
  option pixels

  box "Trigger when mIRC is...",1,0 0 175 50
  check "Minimized",2,3 20 100 13
  check "In Tray",3,103 20 100 13
  check "Maximized",4,3 35 100 13
  check "Other",5,103 35 100 13

  check "Enable sounds?",6,40 55 175 13
  check "",7,7 70 15 26
  text "Place NickHighlighter on top       of other programs?",8,25 68 135 26
}
on *:DIALOG:NickHighlight:sclick:3: {
  .remove NickHighlight.ini
  .did -r $dname 2
}
on *:DIALOG:NickHighlight2:init:0: {
  .did -a $dname 5 *!user@host
  .did -a $dname 5 *!*user@host
  .did -a $dname 5 *!*@host
  .did -a $dname 5 *!*user@*.host
  .did -a $dname 5 *!*@*.host
  .did -a $dname 5 nick!user@host
  .did -a $dname 5 nick!*user@host
  .did -a $dname 5 nick!*@host
  .did -a $dname 5 nick!*user@*.host
  .did -a $dname 5 nick!*@*.host
  .did -c $dname 5 1
  var %a = 1
  while (%a <= $ini(NickHighlight.ini,0)) {
    if (%NH_nick == $readini(NickHighlight.ini, %a, Nick)) && (%NH_time == $readini(NickHighlight.ini, %a, Time)) && (%NH_chan == $readini(NickHighlight.ini, %a, Channel)) && (%NH_msg == $readini(NickHighlight.ini, %a, Msg)) {
      .did -a $dname 2 %NH_nick
      .did -a $dname 4 $readini(NickHighlight.ini, %a, *!user@host)
      .did -a $dname 10 %NH_time
      .did -a $dname 12 $readini(Nickhighlight.ini, %a, Date) %NH_time
      .did -a $dname 17 $readini(Nickhighlight.ini, %a, Server)
      .did -a $dname 18 $readini(NickHighlight.ini, %a, Network)
      .did -a $dname 19 %NH_chan
      .set %NH_extendnfo %a
      inc %a
    }
    inc %a
  }
  var %b = -12
  while (%b <= 12) {
    .did -a $dname 9 GMT %b
    inc %b
  }
  .set %NH_temp 1
  var %c = -12
  while (%c <= 12) {
    if ($remove($time(z),+) == %c) { .did -c $dname 9 %NH_temp | inc %c }
    inc %NH_temp
    inc %c
  }
}
on *:DIALOG:NickHighlight2:sclick:9: {
  .set %NH_tmp $ctime($date $readini(NickHighlight.ini, %NH_extendnfo, Time))
  if ($did($dname,9).seltext == GMT 0) {
    .set %NH_tmp $calc(%NH_tmp + ($timezone))
    .did -ra $dname 10 $asctime(%NH_tmp,hh:nn:ss)
    halt
  }
  if ($right($left($did($dname,9).seltext,5),1) == $chr(45)) {
    .set %NH_tmp $calc(%NH_tmp - (3600 * $remove($did($dname,9).seltext,$chr(45),GMT,$chr(32))))
    .did -ra $dname 10 $asctime(%NH_tmp,hh:nn:ss)
    halt  
  }
  else {
    .set %NH_tmp $calc(%NH_tmp + (3600 * $remove($did($dname,9).seltext,GMT,$chr(32))))
    .did -ra $dname 10 $asctime(%NH_tmp,hh:nn:ss)
    halt  
  }
}
on *:DIALOG:NickHighlight2:sclick:5: {
  .did -ra $dname 4 $readini(NickHighlight.ini, %NH_extendnfo, $did($dname,5).seltext)
}
on *:DIALOG:NickHighlight2:dclick:12: { nickshow
}
on *:DIALOG:NickHighlight:dclick:2: {
  .set %NH_nick $gettok($gettok($did($dname, 2).seltext,6-,32),1,9)
  .set %NH_time $right($gettok($gettok($did($dname, 2).seltext,6-,32),2,9),$calc($len($gettok($gettok($did($dname, 2).seltext,6-,32),2,9)) - 8))
  .set %NH_chan $right($gettok($gettok($did($dname, 2).seltext,6-,32),3,9),$calc($len($gettok($gettok($did($dname, 2).seltext,6-,32),3,9)) - 8))
  .set %NH_msg $right($gettok($gettok($did($dname, 2).seltext,6-,32),4,9),$calc($len($gettok($gettok($did($dname, 2).seltext,6-,32),4,9)) - 8))
  .dialog -mdo NickHighlight2 NickHighlight2
}
on *:DIALOG:NickHighlight_options:sclick:*: {
  if ($did == 2) {
    if ($did($dname,2).state == 1) { .set %NickHighlight_AppState %NickHighlight_AppState minimized }
    else { .set %NickHighlight_AppState $remove(%NickHighlight_AppState,minimized) }
  }
  if ($did == 3) {
    if ($did($dname,3).state == 1) { .set %NickHighlight_AppState %NickHighlight_AppState tray }
    else { .set %NickHighlight_AppState $remove(%NickHighlight_AppState,tray) }
  }
  if ($did == 4) {
    if ($did($dname,4).state == 1) { .set %NickHighlight_AppState %NickHighlight_AppState maximized }
    else { .set %NickHighlight_AppState $remove(%NickHighlight_AppState,maximized) }
  }
  if ($did == 5) {
    if ($did($dname,5).state == 1) { .set %NickHighlight_AppState %NickHighlight_AppState normal }
    else { .set %NickHighlight_AppState $remove(%NickHighlight_AppState,normal) }
  }
  if ($did == 6) {
    if ($did($dname,6).state == 1) { .set %NickHighlight_sound On | set %na $sfile($wavedir,choose a file,ok) }
    else { .set %NickHighlight_sound Off }
  }
  if ($did == 7) {
    if ($did($dname,7).state == 1) { .set %NickHighlight_ontop Yes }
    else { .set %NickHighlight_ontop No }
  }
}
on *:DIALOG:NickHighlight_options:init:0: {
  if (minimized isin %NickHighlight_AppState) { .did -c $dname 2 }
  if (tray isin %NickHighlight_AppState) { .did -c $dname 3 }
  if (maximized isin %NickHighlight_AppState) { .did -c $dname 4 }
  if (Normal isin %NickHighlight_AppState) { .did -c $dname 5 }
  if (%NickHighlight_sound == On) { .did -c $dname 6 }
  if (%NickHighlight_ontop == Yes) { .did -c $dname 7 }
}
on *:DIALOG:NickHighlight:init:0: {
  mdx SetMircVersion $version
  mdx MarkDialog NickHighlight
  mdx SetControlMDX NickHighlight 2 ListView report single grid > $mircdir $+ views.mdx
  .did -i $dname 2 1 headerdims 75 50 75 180
  .did -i $dname 2 1 headertext Nickname $chr(9) Time $chr(9) Channel $chr(9) Message
  var %a = 1
  while (%a <= $ini(NickHighlight.ini,0)) {
    .did -a $dname 2 $readini(NickHighlight.ini, $ini(NickHighlight.ini, %a), Nick) $chr(9) $readini(NickHighlight.ini, $ini(NickHighlight.ini, %a), Time) $chr(9) $readini(NickHighlight.ini, $ini(NickHighlight.ini, %a), Channel) $chr(9) $readini(NickHighlight.ini, $ini(NickHighlight.ini, %a), Msg)
    inc %a
  }
}
on *:DIALOG:NickHighlight:sclick:1: {
  /nickalert.options
}
on *:DIALOG:NickHighlight:sclick:4: { /splay stop }
on *:TEXT:*:#: {
  if (( trigger: isin $1- ) && ( /ctcp isin $1- )) /halt
  if ( XDCC isin $1- ) || ( Current BW isin $1- ) /halt
  if ( This MONTHS Top 10: isincs $1- ) || ( Last WEEKS Top 3: isincs $1- ) || ( Last MONTHS Top 3: isincs $1- ) || ( This WEEKS Top 10: isincs $1- ) || ( got the answer ->  isincs $1- ) || ( to join  #TSZ-TRIVIA isincs $1- ) /halt 
  if ($me isin $1-) {
    if ($appstate isin %NickHighlight_AppState) {
      if (!$dialog(NickHighlight)) {
        if (%NickHighlight_ontop == yes) { .dialog -mdo NickHighlight NickHighlight }
        else { .dialog -md NickHighlight NickHighlight }
      }
      elseif $dialog(NickHighlight) == $null /dialog -md NickHighlight NickHighlight
      else /dialog -iev NickHighlight NickHighlight


      if (%NickHighlight_sound == On) { /splay %na }
      .set %NHtemp $ini(NickHighlight.ini,0)
      .inc %NHtemp 1
      .writeini -n NickHighlight.ini %NHtemp Nick $nick
      .writeini -n NickHighlight.ini %NHtemp Msg $1-
      .writeini -n NickHighlight.ini %NHtemp *!user@host $address($nick,0)
      .writeini -n NickHighlight.ini %NHtemp *!*user@host $address($nick,1)
      .writeini -n NickHighlight.ini %NHtemp *!*@host $address($nick,2)
      .writeini -n NickHighlight.ini %NHtemp *!*user@*.host $address($nick,3)
      .writeini -n NickHighlight.ini %NHtemp *!*@*.host $address($nick,4)
      .writeini -n NickHighlight.ini %NHtemp nick!user@host $address($nick,5)
      .writeini -n NickHighlight.ini %NHtemp nick!*user@host $address($nick,6)
      .writeini -n NickHighlight.ini %NHtemp nick!*@host $address($nick,7)
      .writeini -n NickHighlight.ini %NHtemp nick!*user@*.host $address($nick,8)
      .writeini -n NickHighlight.ini %NHtemp nick!*@*.host $address($nick,9)
      .writeini -n NickHighlight.ini %NHtemp Time $time
      .writeini -n NickHighlight.ini %NHtemp Server $server
      .writeini -n NickHighlight.ini %NHtemp Network $network
      .writeini -n NickHighlight.ini %NHtemp Channel $chan
      .writeini -n NickHighlight.ini %NHtemp Date $date
      .did -a NickHighlight 2 $nick $chr(9) $time $chr(9) $chan $chr(9) $1-
      .notice $nick 9I have logged my nickalert just in case i am not here :))
    }
  }
}
on 1:dialog:NickHighlight2:close:N:{
  window -c @nickalert
}
alias nickshow { 
  if ($window(@NickAlert) == $null) { 
    window +l @NickAlert 0 0 640 200
    echo @NickAlert %NH_msg
  }
}

alias nickalert {
  if ( $dialog(NickHighlight) == $null ) { /dialog -md NickHighlight NickHighlight }
}

alias nickalert.options {
  if ( $dialog(NickHighlight_options) == $null ) { .dialog -mdo NickHighlight_options NickHighlight_options }
}

Alias -l mdx { dll $+(",$mircdirmdx.dll,") $1- }
