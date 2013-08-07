on *:load: {
  if ($exists($scriptdir $+ acrobmp) == $false) {
    .mkdir $scriptdir $+ acrobmp\
    .rename $scriptdir $+ 3.jpg $scriptdir $+ acrobmp\ $+ 3.jpg
    .rename $scriptdir $+ 2.jpg $scriptdir $+ acrobmp\ $+ 2.jpg
    .rename $scriptdir $+ acro.ico $scriptdir $+ acrobmp\ $+ acro.ico
    .rename $scriptdir $+ acro.ico $scriptdir $+ acrobmp\ $+ about.ico
    set %acronc.sbmp 0
    :start_sbmp
    if (%acronc.sbmp > 16 ) goto end_sbmp
    .rename $scriptdir $+ %acronc.sbmp $+ .bmp $scriptdir $+ acrobmp\ $+ %acronc.sbmp $+ .bmp
    inc %acronc.sbmp
    goto start_sbmp
    :end_sbmp
  }
  echo 8,1 Acronyms script 1.3 loaded! 
}

alias acronc.loadini {
  set %acronc.acs    $readini($replace($script,.mrc,.ini),acroset,acs)
  set %acronc.acl    $readini($replace($script,.mrc,.ini),acroset,acl)
  set %acronc.ac3    $readini($replace($script,.mrc,.ini),acroset,ac3)
  set %acronc.ac4    $readini($replace($script,.mrc,.ini),acroset,ac4)
  set %acronc.ac5    $readini($replace($script,.mrc,.ini),acroset,ac5)
  set %acronc.ac6    $readini($replace($script,.mrc,.ini),acroset,ac6)
  set %acronc.acul   $readini($replace($script,.mrc,.ini),acroset,acul)
  set %acronc.acison $readini($replace($script,.mrc,.ini),general,acison)
  set %acronc.acbld  $readini($replace($script,.mrc,.ini),acroset,acbld)
}

alias acronc.init {
  .acronc.loadini
  if (%acronc.acs == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset acs 2
  }
  if (%acronc.acl == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset acl 7
  }
  if (%acronc.ac3 == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac3 8
  }
  if (%acronc.ac4 == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac4 9
  }
  if (%acronc.ac5 == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac5 8
  }
  if (%acronc.ac6 == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac6 8
  }
  if (%acronc.acul == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset acul 1
  }
  if (%acronc.acbld == $null) {
    .writeini -n $replace($script,.mrc,.ini) acroset acbld 1
  }
  if (%acronc.acison == $null) {
    .writeini -n $replace($script,.mrc,.ini) general acison 1
  }
}

on *:dialog:acronc:sclick:2224: {
  .acronc.loadini
  clear @Example
  if ($window(@Disp)) clear @Example
  else window -ado @Example $calc(($window(-1).w / 2) - 200) 120 400 50
  aline @Example $replace($did(10).text,<<, $+ %acronc.ac6,>>, $+ %acronc.acl,<, $+ %acronc.ac5,>, $+ %acronc.acl,[[[, $+ %acronc.ac3,]]], $+ %acronc.acl,[[, $+ %acronc.ac4,]], $+ %acronc.acl,[, $+ %acronc.acs $+ $iif(%acronc.acbld == 1,,) $+ $iif(%acronc.acul == 1,,),],$iif(%acronc.acul == 1,,) $+ $iif(%acronc.acbld == 1,,) $+  $+ %acronc.acl)
}

alias acronc.ac.switch {
  .acronc.loadini
  if (%acronc.acison == $null || %acronc.acison == 0) {
    .writeini -n " $+ $replace($script,.mrc,.ini) $+ " general acison 1
  }
  else {
    .writeini -n " $+ $replace($script,.mrc,.ini) $+ " general acison 0
  }
}

on *:start: {
  .acronc.init
  .acronc.loadini
}

alias acronc {
  acronc.loadini
  if ($dialog(acronc)) {
    echo -a 4.::Acro4::. is already running
    dialog -v acronc acronc
  }
  else { dialog -md acronc acronc }
}

dialog acronc {
  title "Acronym version 1.4 [ /acronc ]"
  icon acrobmp\acro.ico
  size -1 -1 290 200
  option dbu 
  tab "Acro", 100, 3 1 283 165
  tab "Help", 300

  edit "", 3000, 72 25 130 110, read multi return autohs autovs vsbar, tab 300
  list 2000, 10 25 51 110, size, tab 300
  box "Topics", 1001, 5 17 62 125, tab 300

  text "Acronym ", 113, 203 100 70 8, tab 300 disable center
  text "- By BombermanGriff && RobyOne", 114, 205 108 70 28, tab 300 disable center
  icon 70, 254 80 32 32, $scriptdir $+ acrobmp\acro.ico , tab 300
  icon 68,198 1 57 75, $scriptdir $+ acrobmp\3.jpg , tab 300
  icon 69,237 1 57 75, $scriptdir $+ acrobmp\2.jpg , tab 300
  button "BombermanGriff"  8, 205 60 45 12, tab 300
  button "RobyOne" 48, 251 60 30 12, tab 300

  button "&OK" 7, 247 169 30 12, OK 
  button "Acro Off" 60, 177 169 30 12,

  text "Select an acronym to Edit/Delete :" 55, 10 67 100 12, tab 100 
  box "Add/Edit/Delete acronyms" 56, 10 17 260 48, tab 100 
  button "&New" 4, 15 48 30 12, tab 100
  button "&Add" 6, 50 48 30 12, tab 100
  button "&Delete" 5, 85 48 30 12, tab 100 
  button "Test" 2224, 120 48 30 12, tab 100
  button "[" 20, 155 21 10 12, tab 100
  button "]" 21, 165 21 10 12, tab 100
  button "[[" 22, 175 21 10 12, tab 100
  button "]]" 23, 185 21 10 12, tab 100
  button "[[[" 24, 195 21 10 12, tab 100
  button "]]]" 25, 205 21 10 12, tab 100
  button "<" 26, 215 21 10 12, tab 100
  button ">" 27, 225 21 10 12, tab 100
  button "<<" 28, 235 21 10 12, tab 100
  button ">>" 29, 245 21 10 12, tab 100

  list 80, 10 75 195 73, tab 100 hsbar vsbar sort

  text "Acronym" 90, 15 25 30 10, tab 100
  edit "brb" 9, 15 33 45 12, autohs tab 100
  text "Becomes" 91, 60 25 30 10, tab 100
  edit "[b]e [r]ight [b]ack" 10, 60 33 205 12, autohs tab 100
  button "ascii " , 115 , 245 48 20 12, tab 100
  box "Font Settings" 223, 208 67 62 95, tab 100
  box "Styles" 224, 212 75 54 30, tab 100
  box "Colors" 225, 212 108 54 50, tab 100
  icon 11, 211 110 20 20, $scriptdiracrobmp\0.bmp, tab 100
  icon 12, 211 120 20 20, $scriptdiracrobmp\0.bmp, tab 100
  icon 441, 234 110 20 20, $scriptdiracrobmp\0.bmp, tab 100
  icon 442, 234 120 20 20, $scriptdiracrobmp\0.bmp, tab 100
  icon 443, 211 130 20 20, $scriptdiracrobmp\0.bmp, tab 100
  icon 444, 234 130 20 20, $scriptdiracrobmp\0.bmp, tab 100

  text " .." 134, 228 117 10 15, tab 100
  text "[..]" 135, 228 127 10 15, tab 100
  text " [[..]]" 136, 251 117 17 15, tab 100
  text "[[[..]]]" 137, 251 127 17 15, tab 100
  text "<.>" 138, 228 137 10 15, tab 100
  text "<<.>>" 139, 251 137 17 15, tab 100

  check "under&line",13, 218 83 40 10, tab 100
  check "bold",131, 218 93 40 10, tab 100

  list 503, 295 15 80 135
  text "Doubleclick on an item to copy to edit box", 505, 290 148 60 15
  button "Close", 504, 358 149 20 12

  box "ASCII List" 500, 290 6 88 140

  menu "&File", 101
  item "Exit", 206, 101, cancel

  menu "&Options", 204
  item "On/Off Acro", 118, 204

  menu "&Help", 203
}

alias -l _asciimake {
  var %a = 36
  while (%a < 256) { did -a acronc 503 %a $+ : $chr(%a) | inc %a }
}
on *:dialog:acronc:dclick:503: var %a = $did(acronc,503,$did(acronc,503).sel) | .did -a acronc 10 $gettok(%a,2,32)

on *:dialog:acronc:sclick:4:{
  .did -r acronc  9
  .did -r acronc 10
}

on *:dialog:acronc:sclick:5:{
  if ($readini($replace($script,.mrc,.ini),singkat,$did(9).text) == $null) { halt }
  .remini -n $replace($script,.mrc,.ini) singkat $did(9).text
  .did -r acronc  9
  .did -r acronc 10
  .did -r acronc 80
  .loadbuf -otsingkat acronc 80 " $+ $replace($script,.mrc,.ini) $+ "
  .did -z acronc 80 
}

on *:dialog:acronc:sclick:6:{
  if (($did(9).text == $null) || ($did(10).text == $null)) { halt }
  .writeini -n $replace($script,.mrc,.ini) singkat $did(9).text $did(10).text
  .did -r acronc 80
  .loadbuf -otsingkat acronc 80 " $+ $replace($script,.mrc,.ini) $+ "
  .did -z acronc 80 
}

on *:dialog:acronc:sclick:7:{
  .acronc.loadini
}

on *:dialog:acronc:sclick:20:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ [ $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}

on *:dialog:acronc:sclick:21:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ ] $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}

on *:dialog:acronc:sclick:22:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ [[ $+ [[ $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}

on *:dialog:acronc:sclick:23:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ ]] $+ ]] $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}

on *:dialog:acronc:sclick:24:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ [[[ $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}

on *:dialog:acronc:sclick:25:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ ]]] $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}
on *:dialog:acronc:sclick:26:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ < $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}
on *:dialog:acronc:sclick:27:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ > $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}
on *:dialog:acronc:sclick:28:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ << $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}
on *:dialog:acronc:sclick:29:{
  .did -o acronc 10 1 $left($did(10).text,$did(10).selstart) $+ >> $+ $right($did(10).text,$calc($len($did(10).text)-$did(10).selstart))
}
on *:dialog:acronc:sclick:60:{
  acronc.ac.switch
  acronc.loadini
  .did -ra acronc 60 $iif(%acronc.acison == 1,Acro Off,Acro On)
  if (%acronc.acison != 1) { .did -b acronc 4,6,5,2224,115,11,12,13,131,9,10,80 }
  else { .did -e acronc 4,6,5,2224,115,11,12,13,131,9,10,80 } 
}

on *:dialog:acronc:init:0:{
  did -g $dname 11 " $+ $scriptdiracrobmp\ $+ %acronc.acl $+ .bmp $+ "
  did -g $dname 12 " $+ $scriptdiracrobmp\ $+ %acronc.acs $+ .bmp $+ "
  did -g $dname 441 " $+ $scriptdiracrobmp\ $+ %acronc.ac4 $+ .bmp $+ "
  did -g $dname 442 " $+ $scriptdiracrobmp\ $+ %acronc.ac3 $+ .bmp $+ "
  did -g $dname 443 " $+ $scriptdiracrobmp\ $+ %acronc.ac5 $+ .bmp $+ "
  did -g $dname 444 " $+ $scriptdiracrobmp\ $+ %acronc.ac6 $+ .bmp $+ "

  _asciimake

  did -a acronc 2000 Acronyms
  did -a acronc 2000 $chr(43) $+ Add/Edit/Delete
  did -a acronc 2000 $chr(43) $+ Font Settings
  did -a acronc 2000
  did -a acronc 2000 $chr(43) $+ Authors
  did -a acronc 2000

  acronc-readme

  .acronc.loadini
  .did $iif(%acronc.acul == 1,-c,-u) acronc 13
  .did $iif(%acronc.acbld == 1,-c,-u) acronc 131
  .did -ra acronc 60 $iif(%acronc.acison == 1,Acro Off,Acro On)

  if (%acronc.acison != 1) { .did -b acronc 4,6,5,2224,115,11,12,13,131,9,10,80 }
  else { .did -e acronc 4,6,5,2224,115,11,12,13,131,9,10,80 } 

  .loadbuf -otsingkat acronc 80 " $+ $replace($script,.mrc,.ini) $+ "
  .did -z acronc 80
}

alias acronc-acro {
  did -r acronc 3000
  loadbuf 1-30 -o acronc 3000 " $+ $scriptdir $+ acronc-help.txt $+ "
}
alias acronc-Settings {
  did -r acronc 3000
  loadbuf 31-53 -o acronc 3000 " $+ $scriptdir $+ acronc-help.txt $+ "
}
alias acronc-readme {
  did -r acronc 3000
  loadbuf -o acronc 3000 " $+ $scriptdir $+ acronc-help.txt $+ "
}
on *:dialog:acronc:sclick:2000:{
  if ($did(2000).sel == 2) { acronc-acro }
  if ($did(2000).sel == 3) { acronc-Settings }
  if ($did(2000).sel == 5) { _about2 }
}

on *:dialog:acronc:edit:9:{
  if ($right($did(9).text,1) == $chr(32)) {
    .did -r acronc 9
    .did -ra acronc 10 sorry! space not allowed!
    .timerclear10 -o 1 1 { .did -r acronc 10 }
    halt
  }
  .did -ra acronc 10 $readini($replace($script,.mrc,.ini),singkat,$did(9).text))
}

on *:dialog:acronc:sclick:8,68,70:{
  .run mailto:bmg_163@hotmail.com
}

on *:dialog:acronc:sclick:48,69:{
  .run mailto:dueerre@hotmail.com
}

on *:dialog:acronc:sclick:11,12,441,442,443,444:{
  if ($dialog(acronc.cl) != $null) { dialog -x acronc.cl }
  set %acronc.did $did
  .acronc.cl
}

on *:dialog:acronc:sclick:13:{
  .writeini -n $replace($script,.mrc,.ini) acroset acul $did(13).state
}

on *:dialog:acronc:sclick:131:{
  .writeini -n $replace($script,.mrc,.ini) acroset acbld $did(131).state
}

on *:dialog:acronc:sclick:80:{
  .set %acronc.txts $did(acronc,80).seltext
  if ($numtok(%acronc.txts,61) <= 1) { halt }
  .did -ra acronc 9 $gettok(%acronc.txts,1,61)
  .did -ra acronc 10 $readini($replace($script,.mrc,.ini),singkat,$did(9).text))
}

alias acronc.cl dialog -mdo acronc.cl acronc.cl

dialog acronc.cl {
  title "Pick a color"
  icon acrobmp\acro.ico
  size -1 -1 166 46
  icon 1, 3 3 20 20, $scriptdir $+ acrobmp\0.bmp
  icon 2, 23 3 20 20, $scriptdir $+ acrobmp\1.bmp
  icon 3, 43 3 20 20, $scriptdir $+ acrobmp\2.bmp
  icon 4, 63 3 20 20, $scriptdir $+ acrobmp\3.bmp
  icon 5, 83 3 20 20, $scriptdir $+ acrobmp\4.bmp
  icon 6, 103 3 20 20, $scriptdir $+ acrobmp\5.bmp
  icon 7, 123 3 20 20, $scriptdir $+ acrobmp\6.bmp
  icon 8, 143 3 20 20, $scriptdir $+ acrobmp\7.bmp
  icon 9, 3 23 20 20, $scriptdir $+ acrobmp\8.bmp
  icon 10, 23 23 20 20, $scriptdir $+ acrobmp\9.bmp
  icon 11, 43 23 20 20, $scriptdir $+ acrobmp\10.bmp
  icon 12, 63 23 20 20, $scriptdir $+ acrobmp\11.bmp
  icon 13, 83 23 20 20, $scriptdir $+ acrobmp\12.bmp
  icon 14, 103 23 20 20, $scriptdir $+ acrobmp\13.bmp
  icon 15, 123 23 20 20, $scriptdir $+ acrobmp\14.bmp
  icon 16, 143 23 20 20, $scriptdir $+ acrobmp\15.bmp
  button "ok", 200, 10 10 10 10, ok hide
}

on *:dialog:acronc.cl:sclick:*: { 
  %acronc.num = $did - 1
  %acronc.pick = $scriptdir $+ acrobmp\ $+ %acronc.num $+ .bmp
  .did -g acronc %acronc.did %acronc.pick
  if (%acronc.did == 11) {
    .writeini -n $replace($script,.mrc,.ini) acroset acl %acronc.num
  }
  if (%acronc.did == 12) {
    .writeini -n $replace($script,.mrc,.ini) acroset acs %acronc.num
  }
  if (%acronc.did == 441) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac4 %acronc.num
  }
  if (%acronc.did == 442) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac3 %acronc.num
  }
  if (%acronc.did == 443) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac5 %acronc.num
  }
  if (%acronc.did == 444) {
    .writeini -n $replace($script,.mrc,.ini) acroset ac6 %acronc.num
  }
  unset %acronc.did
  dialog -x acronc.cl
  .acronc.loadini
}

on *:input:*: {
  if ($left($1-,1) != $readini(mirc.ini,text,commandchar) || $1 == /me) {
    if (Status Window isin $active || $server == $null) { set %eo 1 }
    else { unset %eo }
    if ($left($1-,1) isin @!) { $iif(%eo == 1,echo -a ,msg $active) $1- | halt }

    if (%acronc.acison == 0) {
      if ($1 != /me) { $iif(%eo == 1,echo -a ,msg $active ) $1- }
      else {
        /me $replace($1-,/me,) 
      }
      halt
    }
    else { set %input.text $1- }

    set %input.count 0
    while (%input.count < $numtok(%input.text,32)) {
      inc %input.count

      if ($left($gettok(%input.text,%input.count,32),1) != ") {
        set %kata $readini($replace($script,.mrc,.ini),singkat,$gettok(%input.text,%input.count,32))       
      }
      else { unset %kata }

      if (%kata != $null) {
        %kata = $replace(%kata,[[[, $+ %acronc.ac3,]]], $+ %acronc.acl)
        %kata = $replace(%kata,[[, $+ %acronc.ac4,]], $+ %acronc.acl)
        %kata = $replace(%kata,<<, $+ %acronc.ac6,>>, $+ %acronc.acl)
        %kata = $replace(%kata,<, $+ %acronc.ac5,>, $+ %acronc.acl)
        %input.text1 = %input.text1 $+ $chr(32) $+  $+ %acronc.acl $+ $replace(%kata,[, $+ %acronc.acs $+ $iif(%acronc.acbld == 1,,) $+ $iif(%acronc.acul == 1,,),],$iif(%acronc.acul == 1,,) $+ $iif(%acronc.acbld == 1,,) $+  $+ %acronc.acl) $+ 
      }
      else {
        set %input.rep $gettok(%input.text,%input.count,32)
        %input.text1 = %input.text1 $+ $chr(32) $+ $iif(($right(%input.rep,2) == -2) && ($calc(%input.rep) == 0), $+ %acronc.acl $+ $replace(%input.rep,-2,-) $+ $replace(%input.rep,-2,) $+ ,%input.rep)
      }
    }

    if ($1 != /me) { $iif(%eo == 1,echo -a , msg $active ) %input.text1 }
    else {
      /me $replace(%input.text1,/me,) 
    }
    unset %input.count
    unset %input.text1
    unset %input.text
    unset %eo
    unset %kata
    halt
  }
}

alias _about2 dialog -md _about2 _about2

dialog _about2 {
  title "Acronym version 1.4"
  size -1 -1 1 1
  icon acrobmp\about.ico
  text "", 1, 50 20 150 15 
  icon 71, 10 8 32 32, $scriptdir $+ acrobmp\about.ico
  button "Copyright© 2003 All rights reserved", 2, 10 60 280 50, center
  text "Website:", 3, 10 134 50 15
  edit "http://tpamirc.tripod.com", 4, 60 130 150 22, autohs read
  button "Visit!", 5, 220 130 50 22, center
  edit "", 6, 10 160 280 80, read multi return autohs autovs
  box "", 7, -10 40 320 210
  button "Close", 200, 120 260 60 30, ok
}

on *:dialog:_about2:init:*: {
  did -o _about2 6 1 Credits: | did -o _about2 6 2 This script was 100% made! 
  did -o _about2 6 3  remade by RobyOne and BombermanGriff | did -o _about2 6 4  100% credit goes to US! haha
  did -o _about2 6 5  made by us for you's | did -a _about2 1 reScripted By him and me 
  %.anim._i = 0 | .timer_anim -m 0 1 _about2.anim
}

on *:dialog:_about2:sclick:2:.timer 1 0 echo -a 8,1 Using more than 100 lines from this script is considered stealing script whether modified or not. You can use any less than 100 lines of this script, but must give us credit. We do not allow anyone to translate this script to any language! 

on *:dialog:_about2:sclick:5:.url http://tpamirc.tripod.com

alias _about2.anim {
  if (($dialog(_about2) == $null) || (%.anim._i > 150)) { .timer_anim off | unset %.anim.tmp* %.anim._i | return }
  :1 | %.anim.tmpx = $calc(($window(-1).w / 2) - %.anim._i) | %.anim.tmpy = $calc(($window(-1).h / 2) - %.anim._i) | %.anim.tmpw = $calc(%.anim._i * 2) | %.anim.tmph = $calc(%.anim._i * 2)
  dialog -s _about2 %.anim.tmpx %.anim.tmpy %.anim.tmpw %.anim.tmph | inc %.anim._i 5
}

on *:dialog:acronc:sclick:115:{ /dialog -srb acronc -1 -1  400 173 | .did -b acronc 115 }

on *:dialog:acronc:sclick:504:{ /dialog -srb acronc -1 -1 280 200 | .did -e acronc 115 }

on *:JOIN:#tsz-trivia:{ set %acronc.acison 0 | .writeini -n $replace($script,.mrc,.ini) general acison 0 }

on *:part:#tsz-trivia:{ set %acronc.acison 1 | .writeini -n $replace($script,.mrc,.ini) general acison 1 }
