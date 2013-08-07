
;// ------------------------------------------------------------ //
;// --------- TsZ Reader --------------------------------------- //
;// ------------------------------------------------------------ //

alias reader {
  var %find = 0
  var %sizefile = $file($1)
  var %N = 4096
  var %S = 0

  if (%sizefile > 0) {
    while (%S < %sizefile) {
      bread $1 %S %N &text1
      var %S = %S + %N 

      var %lenght = $bvar(&text1,0)
      var %start = 0
      var %pos = $bfind(&text1,%start,13 10)

      while (%pos != 0) && (%start != %lenght) {
        var %pos = $bfind(&text1,%start,13 10)
        if %pos == 0 break

        var %start = %pos  
        inc %start
        inc %find
      }
    }
    if (%lenght != %start) {  
      inc %find
    }
  }

  set %readertitle $nopath($1)

  /dialog -mdao reader reader
  did -o reader 3 1 %find lines

  var %i = 1
  while (%i <= %find) {
    /did -i reader 2 %i $read -n -l %i $1
    inc %i
  }
}

dialog Reader {
  title TsZ Reader %readertitle
  option pixels
  size -1 -1 400 500
  list 2,0 30 400 450 ,vsbar
  text "lines" , 3,350 10 50 20
  button "Close" ,1,170 470 60 20 ,ok
}

;// ------------------------------------------------------------ //
;// --------- VOTE SCRIPT -------------------------------------- //
;// ------------------------------------------------------------ //

menu channel {
  -
  $ifadmin(Vote)
  .Make Vote:/vote
  .Cancel Vote:/stopvote
  :.Vote Result:/result
}
alias vote {
  .enable #Vote
  /set %kerdes $?="Your vote question:"
  /set %chan.vote $chan
  /set %vote on
  /set %igen 0
  /set %nem 0
  /msg %chan.vote $logo(Vote) OPEN 10 The ask is:4 %kerdes
  /msg %chan.vote 10 Answer with !yes or !no
  /msg %chan.vote 10 You have 2 minutes to answer !
  .timer1 1 60 /msg %chan.vote $logo(Vote) 1 minute for vote end ! The ask is:4 %kerdes
  .timer2 1 90 /msg %chan.vote $logo(Vote) 30 secondes for vote end !  The ask is:4 %kerdes
  .timer3 1 120 /msg %chan.vote $logo(Vote) END 10 The result is:
  .timer4 1 120 .unset %vote
  .timer5 1 120 .disable #Vote
  .timer6 1 120 result
}
alias stopvote {
  .disable #Vote
  .timer1 off
  .timer2 off
  .timer3 off
  .timer4 off
  .timer6 off
  .rlevel 5
  msg %chan.vote $logo(Vote) Aborted ..
  .unset %vote
  .unset %chan.vote
}
alias result {
  set %pourcentoui $calc(%igen * 100 / (%igen + %nem))
  set %pourcentnon $calc(%nem * 100 / (%nem + %igen))
  if ( %igen == "" ) set %pourcentoui 0
  if ( %nem == 0 ) set %pourcentnon 0
  /msg %chan.vote 10 %igen YES [[ $+ %pourcentoui $+ % $+ ]]
  /msg %chan.vote 10 %nem NO [[ $+ %pourcentnon $+ % $+ ]]
  .unset %chan.vote
  .rlevel 5
}
#Vote off
on 5:text:!yes:%chan.vote:{
  .notice $nick $logo(Vote) 10 You have already voted | halt
}
on 5:text:!no:%chan.vote:{
  .notice $nick $logo(Vote) 10 You have already voted | halt
}

on 1:text:!yes:%chan.vote:{
  if (%vote == off) halt
  else { /set %igen %igen + 1 
    .notice $nick $logo(Vote) 10 Answer accepted (Yes) %igen have answered Yes.
    .guser 5 $nick 2
  }
}
on 1:text:!no:%chan.vote:{
  if (%vote == off) halt
  else { /set %nem %nem + 1 
    .notice $nick $logo(Vote) 10 Answer accepted (No) %nem have answered No.
    .guser 5 $nick 2
  }
}
#Vote End

;// ------------------------------------------------------------ //
;// --------- NETSPLIT SCRIPT ---------------------------------- //
;// ------------------------------------------------------------ //

on ^!*:QUIT: {
  if (((. isin $1) && (. isin $2) && ($3 == $null))) {
    var %netsplitServer1 = $deltok($1,2-3,46), %netsplitServer2 = $deltok($2,2-3,46)
    if (%netsplit- [ $+ [ $1 $+ @ [ $+ [ $2 ] ] ] ] == $null) {
      inc %netsplitCount
      set -u30 %netsplit- [ $+ [ $1 $+ @ [ $+ [ $2 ] ] ] ] 1
    if (%netsplitWarning) amsg NetSplit ( $+ %netsplitServer1 <- %netsplitServer2 ( $+ %netsplitCount $+ ))    }
    if (%netsplitQuit) {
      haltdef
      var %indx = 1
      while ($comchan($nick,%indx)) {
        echo $colour(quit) $ifmatch *** $nick has left IRC (NetSplit ( $+ %netsplitServer1 <- %netsplitServer2 ( $+ $iif(%netsplitCount,%netsplitCount,1) $+ )))
        inc %indx
      }
    }
    if ((%netsplitCloseMsg) && ($query($nick))) {
      echo $colour(quit) $ifmatch *** $nick has left IRC (NetSplit ( $+ %netsplitServer1 <- %netsplitServer2 ( $+ $iif(%netsplitCount,%netsplitCount,1) $+ )))
      close -m $nick
    }
    if (%netsplitCloseDCCSends) close -s $nick
    if (%netsplitCloseDCCGets) close -g $nick
    if (%netsplitCloseDCCChats) close -c $nick
    if (%netsplitCloseDCCFservs) close -f $nick
  }
}
alias nsabout {
  echo -a $logo(NetSplit) BC MIRC v1.65 Clean

}

;// ------------------------------------------------------------ //
;// --------- SHITLIST SCRIPT ---------------------------------- //
;// ------------------------------------------------------------ //

#Shitlister on
dialog Shitlist {
  title "Shitlist"
  size -1 -1 90 145
  option dbu

  tab "Add", 1, 5 5 80 110
  tab "Del", 2
  tab "Edit", 3 

  ;Add Tab
  edit "Channel", 4, 10 25 25 10, read tab 1
  combo 5, 35 25 45 100, dropdown sort autohs tab 1

  edit "Nick", 6, 10 35 25 10, read tab 1
  combo 7, 35 35 45 100, dropdown sort autohs tab 1

  edit "Address", 8, 10 45 25 10, read tab 1
  combo 9, 35 45 45 100, dropdown autohs tab 1

  edit "On", 10, 10 55 25 10, read tab 1
  combo 11, 35 55 45 100, dropdown sort autohs tab 1

  box "Information" 23, 10 70 70 45, tab 1
  edit "", 24, 15 80 60 30, multi read autohs tab 1


  ;Del Tab
  box "Nick",12, 10 25 70 45, tab 2 
  list 13, 15 35 60 40, sort autohs tab 2

  box "Information" 14, 10 70 70 45, tab 2
  edit "", 15, 15 80 60 30, multi read autohs tab 2

  ;Edit Tab
  box "Nick",16, 10 25 70 45, tab 3
  list 17, 15 35 60 40, sort autohs tab 3

  box "Information" 18, 10 70 70 45, tab 3

  edit "Address", 19, 15 80 25 10, read tab 3
  combo 20, 40 80 35 100, dropdown tab 3

  edit "On", 21, 15 90 25 10, read tab 3
  combo 22, 40 90 35 100, dropdown tab 3

  edit "Status", 30, 15 100 25 10, read tab 3
  combo 31, 40 100 35 100, dropdown tab 3

  check "Notice when?", 25, 5 125 42 10
  button "Add", 26, 49 125 20 10
  button "Del", 27, 49 125 20 10
  button "Update", 28, 49 125 20 10
  button "Done", 29, 70 125 20 10, ok
}

on *:DIALOG:shitlist:sclick:1: {
  did -h shitlist 27,28
  did -v shitlist 26
}
on *:DIALOG:shitlist:sclick:2: {
  did -h shitlist 26,28
  did -v shitlist 27
  if ($exists(shitlist.ini) != $true) { write -c shitlist.ini | goto done }
  unset %temp*
  set %temp1 $readini shitlist.ini Settings NOSL 
  did -r shitlist 13
  if (%temp1 == $null) { goto done }
  :start
  inc %temp2
  if (%temp2 > %temp1) { goto done }
  did -a shitlist 13 %temp2 $+ . $readini Shitlist.ini [ $readini Shitlist.ini Shitlisted %temp2 ] Nick
  goto start
  :done
  unset %temp*
}
on *:DIALOG:shitlist:sclick:3: {
  did -h shitlist 26,27
  did -v shitlist 28
  unset %temp*
  if ($exists(shitlist.ini) != $true) { write -c shitlist.ini | goto done }
  set %temp1 $readini shitlist.ini Settings NOSL 
  did -r shitlist 17
  if (%temp1 == $null) { goto done }
  :start
  inc %temp2
  if (%temp2 > %temp1) { goto done }
  did -a shitlist 17 %temp2 $+ . $readini Shitlist.ini [ $readini Shitlist.ini Shitlisted %temp2 ] Nick
  goto start
  :done
  unset %temp*
}
on *:DIALOG:shitlist:init:*: {
  did -h shitlist 27,28
  did -v shitlist 26
  unset %temp*
  set %temp1 $chan(0)
  :start
  inc %temp2
  if (%temp2 > %temp1) goto done
  did -a shitlist 5,11,22 $chan(%temp2)
  goto start
  :done
  did -a shitlist 11,22 All Channels...
  did -a shitlist 24 Nick: $crlf $+  Address: $crlf $+ Channel(s): $crlf $+ Status: Inactive
  did -a shitlist 31 Active
  did -a shitlist 31 Inactive
  if ($readini shitlist.ini Settings Notice == $true) { did -c shitlist 25 }
}
on *:DIALOG:shitlist:sclick:5: {
  if ($did(5) == $null) { halt }
  did -r shitlist 7
  .ial on
  .enable #HideWho
  who $did(5)
  unset %temp*
  set %temp1 $nick($did(5),0)
  :start
  inc %temp2
  if (%temp2 > %temp1) goto done
  did -a shitlist 7 $nick($did(5),%temp2)
  goto start
  :done
  unset %temp*
}

on *:DIALOG:shitlist:sclick:7: {
  did -r shitlist 9
  unset %temp*
  set %temp1 20
  :start
  inc %temp2
  if (%temp2 > %temp1) goto done
  if ((%temp2 > 4) && (%temp2 < 10)) goto start
  if ((%temp2 > 14) && (%temp2 < 21)) goto start
  did -a shitlist 9 $address($did(7),%temp2)
  goto start
  :done
  unset %temp*
  did -r shitlist 24
  did -a shitlist 24 Nick: $did(7) $crlf $+ Address: $did(9) $crlf $+ Channel(s): $did(11) $crlf $+ Status: Inactive
}

on *:DIALOG:shitlist:sclick:9: {
  did -r shitlist 24
  did -a shitlist 24 Nick: $did(7) $crlf $+ Address: $did(9) $crlf $+ Channel(s): $did(11) $crlf $+ Status: Inactive
}
on *:DIALOG:shitlist:sclick:11: {
  did -r shitlist 24
  did -a shitlist 24 Nick: $did(7) $crlf $+ Address: $did(9) $crlf $+ Channel(s): $did(11) $crlf $+ Status: Inactive
}

on *:DIALOG:shitlist:sclick:26: {
  if (($did(5) == $null) || ($did(7) == $null) || ($did(9) == $null) || ($did(11) == $null)) { goto done }
  if ($exists(shitlist.ini) == $false) { write -c shitlist.ini }
  if ($did(25).state == 1) { writeini shitlist.ini Settings Notice $true }
  if ($did(25).state == 0) { writeini shitlist.ini Settings Notice $false }
  if ($readini shitlist.ini Settings Notice == $true) { .notice $did(7,$did(7).sel) You've been added to my shitlist on $did(11,$did(11).sel) congrats! }
  writeini shitlist.ini Shitlisted $shitlistnumber $slac($did(9,$did(9).sel))
  writeini shitlist.ini $slac($did(9,$did(9).sel)) Nick $did(7,$did(7).sel)
  writeini shitlist.ini $slac($did(9,$did(9).sel)) Address $did(9,$did(9).sel)
  writeini shitlist.ini $slac($did(9,$did(9).sel)) Channels $did(11,$did(11).sel)
  writeini shitlist.ini $slac($did(9,$did(9).sel)) Status Active
  mode $did(11,$did(11).sel) +b $did(9,$did(9).sel) 
  kick $did(11,$did(11).sel) $did(7,$did(7).sel) $logo(Shitlist) $b($kicktext)
  did -r shitlist 24
  did -a shitlist 24 Nick: $did(7) $crlf $+ Address: $did(9) $crlf $+ Channel(s): $did(11) $crlf $+ Status: Active
  :done
}
on *:DIALOG:shitlist:sclick:28: {
  if ($did(17,$did(17).sel) == $null) { goto done }
  if ($did(25).state == 1) { writeini shitlist.ini Settings Notice $true }
  if ($did(25).state == 0) { writeini shitlist.ini Settings Notice $false }
  unset %temp*
  set %temp1 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Nick
  set %temp2 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Address
  set %temp2 $slacb(%temp2)
  set %temp3 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Channels
  set %temp4 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Status
  remini shitlist.ini $slac(%temp2)
  if ($did(20) == $null) { writeini shitlist.ini Shitlisted $did(17).sel $slac(%temp2) }
  if ($did(20) != $null) { writeini shitlist.ini Shitlisted $did(17).sel $slac($did(20)) }
  set %temp2 $readini shitlist.ini Shitlisted $did(17).sel 
  writeini shitlist.ini [ %temp2 ] Nick %temp1
  writeini shitlist.ini [ %temp2 ] Address %temp2
  if ($did(22) == $null) { writeini shitlist.ini [ %temp2 ] Channels %temp3 }
  if ($did(22) != $null) { writeini shitlist.ini [ %temp2 ] Channels $did(22) }
  if ($did(31) == $null) { writeini shitlist.ini [ %temp2 ] Status %temp4 }
  if ($did(31) != $null) { writeini shitlist.ini [ %temp2 ] Status $did(31) }
  :done
}
on *:DIALOG:shitlist:sclick:13: {
  unset %temp*
  set %temp1 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Nick
  set %temp2 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Address
  set %temp2 $slacb(%temp2)
  set %temp3 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Channels
  set %temp4 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Status
  did -r shitlist 15
  did -a shitlist 15 Nick: %temp1 $crlf $+ Address: %temp2 $crlf $+ Channel(s): %temp3 $crlf $+ Status: %temp4
  unset %temp*
}

on *:DIALOG:shitlist:sclick:17: {
  unset %temp*
  set %temp2 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Address
  set %temp2 $slacb(%temp2)
  set %temp3 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Channels
  set %temp4 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Status
  did -r shitlist 20,22
  unset %temp*
  set %temp1 14
  set %temp3 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(17).sel ] Nick
  .enable #HIDEWHO
  .who %temp3
  .disable #HIDEWHO
  :start
  inc %temp2
  if (%temp2 > %temp1) goto done
  if ((%temp2 > 4) && (%temp2 < 10)) goto start
  did -a shitlist 20 $address(%temp3,%temp2)
  goto start
  :done
  unset %temp*
  set %temp1 $chan(0)
  :start2
  inc %temp2
  if (%temp2 > %temp1) { goto done2 }
  did -a shitlist 22 $chan(%temp2) 
  goto start2
  :done2
  did -a shitlist 22 All Channels...
  unset %temp*
}

on *:DIALOG:shitlist:sclick:27: {
  if ($did(13,$did(13).sel) == $null) { goto done }
  if ($did(25).state == 1) { writeini shitlist.ini Settings Notice $true }
  if ($did(25).state == 0) { writeini shitlist.ini Settings Notice $false }
  set %temp1 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Nick
  set %temp2 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Address
  set %temp2 $slacb(%temp2)
  set %temp3 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Channels
  set %temp4 $readini shitlist.ini [ $readini shitlist.ini Shitlisted $did(13).sel ] Status
  if ($readini shitlist.ini Settings Notice == $true) { .notice %temp1 You've been deleted from my shitlist, shithead! }
  writeini shitlist.ini $slac(%temp2) Status Inactive
  did -r shitlist 15
  did -a shitlist 15 Nick: %temp1 $crlf $+ Address: %temp2 $crlf $+ Channel(s): %temp3 $crlf $+ Status: Inactive
  :done
}

alias slac {
  set %tempaddress $replace($1-,$chr(42),$chr(164))
  return %tempaddress
}
alias slacb {
  set %tempaddress $replace($1-,$chr(164),$chr(42))
  return %tempaddress
}

alias shitlistnumber { 
  if ($readini shitlist.ini Settings NOSL == $null) { writeini shitlist.ini Settings NOSL 0 }
  set %shitlist.temp $readini shitlist.ini Settings NOSL
  inc %shitlist.temp 
  writeini shitlist.ini Settings NOSL %shitlist.temp
  return %shitlist.temp
}
#Shitlister End
menu nicklist {
  Shitlist
  . $shit1(Turn Shitlist On): .enable #Shitlister
  . $shit2(Turn Shitlist Off): .disable #Shitlister
  . $shit2(Shitlist Editor): dialog -m shitlist shitlist
}
alias shit1 { if ($group(#Shitlister) != On) { halt } }
alias shit2 { if ($group(#Shitlister) == On) { halt } }


;// ------------------------------------------------------------ //
;// --------- RANDOM SCRIPT --  -------------------------------- //
;// ------------------------------------------------------------ //

menu nicklist,query {
  Random
  .Blond Jokes:/me says to12 $$1 $read $mircdirtext\blondes.txt
  .Ever Wonder:/me says to12 $$1 $read $mircdirtext\things.txt
  .Addict:/me says to12 $$1 $read $mircdirtext\addict.txt
  .Insults:/me says to12 $$1 $read $mircdirtext\insult.txt
  .Pickup Lines:/me says to12 $$1 $read $mircdirtext\pickups.txt
}

;// ------------------------------------------------------------ //
;// --------- TOOLS DIALOG ------------------------------------- //
;// ------------------------------------------------------------ //

alias tools dialog -m tools tools

dialog tools {
  title "Tools"
  size -1 -1 345 220
  box "Web Browser",1, 10 10 150 70
  button "Exit", 17, 260 190 70 25,ok
  button "explorer",2, 20 35 60 25
  button "netscape",3, 90 35 60 25
  box "Socks",4, 10 90 150 120
  button "port scanner",5, 25 110 120 25
  button "run telnet",6, 25 140 120 25
  button "ip configuration",7,25 170 120 25
  box "Windows",8, 170 10 165 165
  button "calculator",9, 185 30 60 25
  button "wordpad",10, 260 30 60 25
  button "paint",11, 185 65 60 25
  button "notepad",12, 260 65 60 25
  button "ms-dos",13,185 100 60 25
  button "cd-player",14,260 100 60 25
  button "char-map",15,185 135 60 25
  button "explorer",16,260 135 60 25
}

on *:dialog:tools:sclick:2:run iexplore 
on *:dialog:tools:sclick:3:run netscape 
on *:dialog:tools:sclick:5:pscanip
on *:dialog:tools:sclick:6:run telnet 
on *:dialog:tools:sclick:7:{ 
  if ($os == 98) { run winipcfg }
  if ($os == 95) { run winipcfg }
  else run ipconfig
}
on *:dialog:tools:sclick:9:run calc
on *:dialog:tools:sclick:10:run wordpad
on *:dialog:tools:sclick:11:run mspaint
on *:dialog:tools:sclick:12:run notepad
on *:dialog:tools:sclick:13:run command
on *:dialog:tools:sclick:14:run cdplayer
on *:dialog:tools:sclick:15:run charmap
on *:dialog:tools:sclick:16:run explorer.exe

alias tools1 {
  /dialog -mravd tools tools
}

;// ------------------------------------------------------------ //
;// --------- DIALOGS DIALOG ----------------------------------- //
;// ------------------------------------------------------------ //

alias dialogs dialog -omt dialogs dialogs

dialog dialogs {
  size 400 30 421 18
  title "Option Control"
  button "tbro",2, 1 1 35 17
  button "qman",5, 36 1 35 17
  button "fser",6, 71 1 35 17
  button "ftp",7,106 1 35 17
  button "umod",9, 141 1 35 17
  button "tool",10, 176 1 35 17
  button "away",11, 211 1 35 17
  button "set",12, 246 1 35 17
  button "nick",13,281 1 35 17
  button "page",14,316 1 35 17
  button "ncol",15,351 1 35 17
  button "ip2n",16,386 1 35 17
  button "Exit", 17, 421 1 35 17,ok, hide
}

on *:dialog:dialogs:sclick:2:f1
on *:dialog:dialogs:sclick:5:f2
on *:dialog:dialogs:sclick:6:f3 
on *:dialog:dialogs:sclick:7:f4
on *:dialog:dialogs:sclick:9:f6
on *:dialog:dialogs:sclick:10:f7
on *:dialog:dialogs:sclick:11:f8
on *:dialog:dialogs:sclick:12:f9
on *:dialog:dialogs:sclick:13:f10
on *:dialog:dialogs:sclick:14:sf1
on *:dialog:dialogs:sclick:15:sf2
on *:dialog:dialogs:sclick:16:sf3

alias optioncontrol {
  /dialog -mravd dialogs dialogs
}



;// ------------------------------------------------------------ //
;// --------- SETTINGS DIALOG ---------------------------------- //
;// ------------------------------------------------------------ //

alias Settings_config {
  /dialog -mravd Settings Settings
}

alias cfg { Settings_config }

dialog Settings {
  title "TSZ Script - Settings Window"
  size -1 -1 559 295
  option pixels
  check "On - auto join", 300, 14 239 132 20
  text "enter -> #channel key", 501, 14 20 132 16, center
  edit "", 400, 12 37 135 20, center
  edit "", 401, 12 57 135 20, center
  edit "", 402, 12 77 135 20, center
  edit "", 403, 12 97 135 20, center
  edit "", 404, 12 117 135 20, center
  edit "", 405, 12 137 135 20, center
  edit "", 406, 12 157 135 20, center
  edit "", 407, 12 177 135 20, center
  edit "", 408, 12 197 135 20, center
  edit "", 409, 12 217 135 20, center
  check "On - Auto identify", 302, 169 23 138 13
  text "Pass:", 411, 168 44 35 16
  edit "", 350, 206 41 105 20
  box "Stuff", 278, 161 227 160 40
  check ":Nick:", 279, 167 241 50 20
  check "(Nick)", 280, 217 241 50 20
  check "[Nick]", 287, 268 241 49 20
  check "Auto Whois on chat", 306, 331 47 128 13
  check "Launch option control strip on startup", 311, 331 64 207 13
  check "Random colored text when first char is +", 270, 331 28 219 13
  button "Away Settings", 55, 307 272 75 20
  button "Fserve Setup", 27, 149 272 75 20
  button "Nick colors", 66, 450 272 63 20
  button "Close", 1, 516 272 40 20, ok
  box "Auto join channels", 2, 2 5 156 263
  box "Auto identify", 3, 162 6 158 66
  box "Forward to window @Tios", 4, 161 81 158 96
  check "Joins", 5, 170 95 100 20
  check "Parts", 6, 170 115 100 20
  check "Quits", 7, 170 134 100 20
  check "Mode changes", 8, 170 155 100 20
  box "Forward to window @IRCOP", 9, 161 182 158 39
  check "Server notices", 10, 169 197 140 20
  box "Misc", 11, 325 7 231 79
  button "Ftp ad setup", 12, 228 272 75 20
  box "Programs", 13, 325 92 230 45
  text "FlashFXP", 14, 333 109 50 16
  button "Set...", 15, 390 107 158 20
  button "NickAlert", 16, 386 272 61 20
  box "Auto-Thanks", 17, 326 144 228 61
  check "Thx for op", 18, 333 161 80 20
  check "Thx for halfop", 19, 333 182 92 20
  check "Thx for voice", 20, 452 161 92 20
}





on 1:dialog:settings:init:*:{ 
  if ($sets(misc,autojoin1) != notset) { did -a settings 400 $sets(misc,autojoin1) }
  if ($sets(misc,autojoin2) != notset) { did -a settings 401 $sets(misc,autojoin2) }
  if ($sets(misc,autojoin3) != notset) { did -a settings 402 $sets(misc,autojoin3) }
  if ($sets(misc,autojoin4) != notset) { did -a settings 403 $sets(misc,autojoin4) }
  if ($sets(misc,autojoin5) != notset) { did -a settings 404 $sets(misc,autojoin5) }
  if ($sets(misc,autojoin6) != notset) { did -a settings 405 $sets(misc,autojoin6) }
  if ($sets(misc,autojoin7) != notset) { did -a settings 406 $sets(misc,autojoin7) }
  if ($sets(misc,autojoin8) != notset) { did -a settings 407 $sets(misc,autojoin8) }
  if ($sets(misc,autojoin9) != notset) { did -a settings 408 $sets(misc,autojoin9) }
  if ($sets(misc,autojoin10) != notset) { did -a settings 409 $sets(misc,autojoin10) }

  if ($sets(misc,autojoin) == on) { did -c settings 300 }
  if ($sets(misc,autowhois) == on) { did -c settings 306 }
  if ($sets(misc,strip) == on) { did -c settings 311 }
  if ($sets(nick,aidentify) == on) { did -c settings 302 }
  if ($sets(misc,nc) == on) { did -c settings 270 }
  if ($sets(misc,barrackl) == $chr(40)) { did -c settings 280 }
  if ($sets(misc,barrackl) == $chr(58)) { did -c settings 279 } 
  if ($sets(misc,barrackl) == $chr(91)) { did -c settings 287 }
  if ($sets(forward,joins) == on) { did -c $dname 5 }
  if ($sets(forward,parts) == on) { did -c $dname 6 }
  if ($sets(forward,quits) == on) { did -c $dname 7 }
  if ($sets(forward,modes) == on) { did -c $dname 8 }
  if ($sets(forward,snotice) == on) { did -c $dname 10 }

  if ($sets(autothx,op) == on) { did -c $dname 18 }
  if ($sets(autothx,halfop) == on) { did -c $dname 19 }
  if ($sets(autothx,voice) == on) { did -c $dname 20 }

  if ($sets(programs,flashfxp) != NotSet) { /did -ra $dname 15 $iif($len($sets(programs,flashfxp)) > 28, ... $+ $right($sets(programs,flashfxp),28), $sets(programs,flashfxp)) }

  did -a settings 350 $sets(nick,pass)
}
on 1:dialog:settings:sclick:5:{ /CSet forward joins $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:6:{ /CSet forward parts $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:7:{ /CSet forward quits $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:8:{ /CSet forward modes $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:10:{ /CSet forward snotice $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:18:{ /CSet autothx op $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:19:{ /CSet autothx halfop $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:20:{ /CSet autothx voice $iif($did($dname,$did).state == 1,on,off) }
on 1:dialog:settings:sclick:15:{ 
  /CSet programs flashfxp $$sfile($iif($isdir(C:\Program files\FlashFXP\) == $false,$iif($isdir(C:\) == $false,C:\,$mircdir),C:\Program Files\FlashFXP\) $+ *.exe,Select the FlashFXP exe)
  if ($sets(programs,flashfxp) != NotSet) { /did -ra $dname 15 $iif($len($sets(programs,flashfxp)) > 28, ... $+ $right($sets(programs,flashfxp),28), $sets(programs,flashfxp)) }
}
on 1:dialog:settings:sclick:55:{ aws }
on 1:dialog:settings:sclick:16:{ /nickalert.options }
on 1:dialog:settings:sclick:279:{ SetBarr 279 } 
on 1:dialog:settings:sclick:280:{ SetBarr 280 } 
on 1:dialog:settings:sclick:287:{ SetBarr 287 } 
on 1:dialog:settings:edit:400:{ setchan 400 1 }
on 1:dialog:settings:edit:401:{ setchan 401 2 }
on 1:dialog:settings:edit:402:{ setchan 402 3 }
on 1:dialog:settings:edit:403:{ setchan 403 4 }
on 1:dialog:settings:edit:404:{ setchan 404 5 }
on 1:dialog:settings:edit:405:{ setchan 405 6 }
on 1:dialog:settings:edit:406:{ setchan 406 7 }
on 1:dialog:settings:edit:407:{ setchan 407 8 }
on 1:dialog:settings:edit:408:{ setchan 408 9 }
on 1:dialog:settings:edit:409:{ setchan 409 10 }
on 1:dialog:settings:edit:350:{ /CSet nick pass $did(settings,350) }
on 1:dialog:settings:sclick:300:{ ReCheckBox settings 300 misc autojoin }
on 1:dialog:settings:sclick:302:{ ReCheckBox settings 302 nick aidentify }
on 1:dialog:settings:sclick:270:{ ReCheckBox settings 270 misc nc }
on 1:dialog:settings:sclick:311:{ ReCheckBox settings 311 misc strip }
on 1:dialog:settings:sclick:306:{ ReCheckBox settings 306 misc autowhois }
on 1:dialog:settings:sclick:66:{ tsz_option.ncol }
on 1:dialog:settings:sclick:27:{ fserve_config }
on 1:dialog:settings:sclick:12:{ ftp_config }
on 1:dialog:settings:edit:68:{ %add.delay = $did(settings,68) * 60 }

on *:CONNECT:{
  if $sets(nick,aidentify) == on && $sets(nick,pass) != NotSet {
    /nickserv identify $sets(nick,pass)
  }
  if $sets(misc,autojoin) == on {
    var %i = 1
    while %i <= 10 {
      if ($sets(misc,autojoin $+ %i) != notset) { /join $sets(misc,autojoin $+ %i) }
      inc %i
    }
  }
}


;// ------------------------------------------------------------ //
;// --------- PAGER DIALOG ------------------------------------- //
;// ------------------------------------------------------------ //


dialog Pager {
  title "Pager window"
  size -1 -1 300 275
  combo 3, 5 5 100 400, drop
  text "From:",4, 5 30 30 13, left
  text "Sender",5,36 30 50 13, left
  text "Date:",6,90 30 30 13, left
  text "Date",7,121 30 50 13, left
  text "Time:",8,175 30 30 13, left
  text "Time",9,206 30 50 13, left
  edit "Message Text",2, 5 50 290 160, multi 
  button "Del Page",11,90 212 60 20, Ok
  button "Del All Pages",10,155 212 90 20, Ok
  button "Close",1,255 212 40 20, Ok  
}

on 1:dialog:Pager:init:0:{ List.Pages }
on 1:dialog:Pager:sclick:3:{ Show.Page }
on 1:dialog:Pager:sclick:10:{ .Remove $shortfn($mircdirsystem\pages.ini) | List.Pages }
on 1:dialog:Pager:sclick:11:{ Rem.page $did(pager,3).sel }


alias pager1 {
  /dialog -mravd Pager Pager
}

;// ------------------------------------------------------------ //
;// --------- ERROR DIALOG ------------------------------------- //
;// ------------------------------------------------------------ //

dialog Error {
  title "Error"
  size -1 -1 300 100
  text "Error:",6,5 5  40 13, left
  text %error,5,5 20 280 55, left
  button "Ok",1, 5 75 290 20, Ok
}


;// ------------------------------------------------------------ //
;// --------- ABOUT DIALOG ------------------------------------- //
;// ------------------------------------------------------------ //

alias kaloom { 
  /dialog -mda kaloom kaloom
}

dialog kaloom {
  title "About"
  size -1 -1 200 180
  text "The Sharing Zone",739, 50 77 180 13 ,tab 27
  icon 732, 0 0 200 75 ,$mircdirsystem\graphics\tsz.bmp, noborder ,tab 28
  icon 733, 6 95 35 40 ,$mircdirsystem\graphics\v1.bmp, noborder ,tab 28
  icon 734, 44 95 35 40 ,$mircdirsystem\graphics\v2.bmp, noborder ,tab 28
  icon 735, 82 95 35 40 ,$mircdirsystem\graphics\v3.bmp, noborder ,tab 28
  icon 736, 120 95 35 40 ,$mircdirsystem\graphics\v4.bmp, noborder ,tab 28
  icon 737, 158 95 35 40 ,$mircdirsystem\graphics\v5.bmp, noborder ,tab 28
  button "Close" ,1,69 155 60 20 ,ok
}

;// ------------------------------------------------------------ //
;// --------- PORTSCAN DIALOG ---------------------------------- //
;// ------------------------------------------------------------ //

alias portscanip {
  /dialog -mravd pscanip pscanip
}

dialog pscanip {
  title "Port Scan"
  size -1 -1 330 330
  box "", 250, 10 10 310 300
  text "Scan", 1, 20 24 50 15
  edit "127.0.0.1", 2, 50 22 195 20, autohs
  text "Start Port", 3, 20 45 50 15
  edit "1", 4, 70 43 50 20, autohs
  text "Stop Port", 5, 20 65 50 15
  edit "65536", 6, 70 63 50 20, autohs
  text "Delay (ms)", 7, 140 45 55 15
  edit "50", 8, 195 43 50 20, autohs
  text "Open Socks", 9, 130 65 62 15
  edit "0", 10, 195 63 50 20, autohs
  button "Halt", 11, 250 50 55 25
  button "Start", 12, 250 22 55 25
  list 13, 20 85 290 150, extsel
  check "Save To", 14, 20 237 62 15
  edit "", 15, 85 235 225 20
  button "Clear Scan", 16, 20 270 90 30
  button "Exit", 17, 220 270 90 30, ok
}


on 1:dialog:pscanip:init:0:{
  did -b pscanip 10
  did -ra pscanip 15 $scriptdirscanlog.log
  if (%PScan.Address  != $null) { did -ra pscanip 2 %PScan.Address }
  if (%PScan.StartPort != $null) { did -ra pscanip 4 %PScan.StartPort }
  if (%PScan.StopPort != $null) { did -ra pscanip 6 %PScan.StopPort }
}
on 1:dialog:pscanip:sclick:*:{
  if ($did == 12) { .timerpsocks 0 1 pscan.sockupd | pscan.dis -b | did -b pscanip 14 | did -b pscanip 15 | pscan.sv Scanning host ( $+ $did(pscanip,2) $+ ) | set %PScan.StartPort $did(pscanip,4) | set %PScan.StopPort $did(pscanip,6) | set %PScan.Address $did(pscanip,2) | pscan.start begin }
  if ($did == 11) { .timerpsocks off | if ($sock(PScan*,0) != 0) { pscan.dis -e | did -e pscanip 14 | did -e pscanip 15 | pscan.sv Scan halted on port ( $+ %pscn.count $+ ) | .timerpscan* off | sockclose PScan* | did -ra pscanip 10 0 } }
  if ($did == 16) { did -r pscanip 13 }
}

on 1:sockopen:pscan*:if ($sockerr) return | pscan.sv $sock($sockname).port :CONNECTED
on 1:sockclose:pscan*:pscan.sv $sock($sockname).port :CLOSED
on 1:sockread:pscan*:{
  if ($sockerr > 0) return
  :nextread
  sockread % $+ $sockname
  if ($sockbr == 0) return
  if (% [ $+ [ $sockname ] ] == $null) % [ $+ [ $sockname ] ] = -
  pscan.sv $sock($sockname).port : $+ % [ $+ [ $sockname ] ]
  goto nextread
}

alias pscan.sv {
  did -a pscanip 13 $1-
  if ($did(pscanip,14).state == 1) { write $did(pscanip,15) $1- }
}
alias pscan.dis {
  set %pscn.dis.tmp $1
  set %pscn.dis.nm 0
  :disable
  inc %pscn.dis.nm 2
  if (%pscn.dis.nm == 10) { goto disable }
  did %pscn.dis.tmp pscanip %pscn.dis.nm
  if (%pscn.dis.nm < 12) { goto disable }
}

alias pscanip dialog -m pscanip pscanip
alias pscan {
  if ($dialog(pscanip) == $null) { dialog -m pscanip pscanip }
}
alias pscan.open {
  if ($dialog(pscanip) != $null) {
    sockopen $1-
    pscan.start
  }
}
alias pscan.sockupd {
  if $dialog(pscanip) != $null { did -ra pscanip 10 $sock(pscan*,0) }
  else {
    if ($did == 11) {
      .timerpsocks off
      if ($sock(PScan*,0) != 0) {
        pscan.dis -e
        .timerpscan* off
        sockclose PScan*
      }
    }
  }
}
alias pscan.start {
  if ($dialog(pscanip) != $null) {
    if ($1 == begin) { if (%PScan.StartPort == 0) set %PScan.StartPort 1 | set %Pscn.sock PScan $+ %PScan.StartPort | set %PScn.count %PScan.StartPort | sockopen %Pscn.sock %PScan.Address %PScan.StartPort }
    inc %PScn.count 1
    did -ra pscanip 4 %PScn.count
    set %PScan.StartPort %PScn.count
    set %Pscn.sock PScan $+ %Pscn.count
    if (%PScn.count <= %PScan.StopPort) { .timerpscan [ $+ [ %PScn.count ] ] -m 1 $did(pscanip,8) pscan.open %Pscn.sock %PScan.Address %PScn.count }
  }
}


;// ------------------------------------------------------------ //
;// --------- IP2NICK DIALOG ----------------------------------- //
;// ------------------------------------------------------------ //


alias Zmodem.ipc {
  set %Zmodem.ip2nick $ip
  if (%Zmodem.ip2nick == $null) { set %Zmodem.ip2nick 127.0.0.1 | goto next }
  set %Zmodem.ip2nick $ip
  :next
  set %Zmodem.ip2nick.res <N/A>
  set %Zmodem.ip2nick.searching on
  dialog -mravd IP ipc
}
alias -l Zmodem.e {
  echo @Zmodem.ip2nick.help $chr(160) $chr(160) $1-
}
alias -l Zmodem.b {
  echo @Zmodem.ip2nick.help $chr(160)
}
alias -l Zmodem.t {
  echo @Zmodem.ip2nick.help  $+ $1 $+  $+ $2
}
dialog ipc {
  title "IP To Nick Search"
  size -1 -1 355 55
  button "E&xit", 1, 230 30 60 20, cancel
  text "IP", 2, 1 1 75 16, center
  edit %Zmodem.ip2nick, 3, 76 1 150 20
  text "Resolved Nick", 4, 1 30 75 16, center
  edit %Zmodem.ip2nick.res, 5, 76 30 150 20, read
  button "&Convert", 6, 230 1 60 20
  button "Clear &All", 9, 295 1 60 20
  button "&Stop", 10, 295 30 60 20
}
on *:dialog:IP:sclick:1: {
  unset %Zmodem.ip2nick %Zmodem.ip2nick.res
  .disable #Zmodem.IPtoNick
}
on *:dialog:IP:edit:3: {
  set %Zmodem.ip2nick $did($dname,$did)
}
on *:dialog:IP:sclick:6: {
  if (%Zmodem.ip2nick == $null) { did -r IP 5 | did -a IP 5 No Ip Specified | goto end }
  if ($len(%zmodem.ip2nick) >= 7) && ($len(%zmodem.ip2nick) <= 15) { goto next }
  goto invalid.length
  :next
  set %Zmodem.ip2nick.searching on
  .enable #Zmodem.IPtoNick
  .dns %Zmodem.ip2nick
  dialog -t $dname Looking For The Owner Of: %Zmodem.ip2nick
  goto end

  :invalid.length
  dialog -t $dname Sorry, invalid IP Address!
  :end
}
on *:dialog:IP:sclick:9: {
  set %Zmodem.ip2nick $ip
  set %Zmodem.ip2nick.res <N/A>
  did -r $dname 3
  did -a $dname 3 %Zmodem.ip2nick
  did -r $dname 5
  did -a $dname 5 %Zmodem.ip2nick.res
  set %Zmodem.ip2nick.searching off
  dialog -t $dname IP To Nick Search
}
on *:dialog:IP:sclick:10: {
  set %Zmodem.ip2nick.searching off
  .disable #Zmodem.IPtoNick
  dialog -t $dname Stopped Searching
}
menu @Zmodem.ip2nick.help {
  dclick:window -c @Zmodem.ip2nick.help 
  Close:window -c @Zmodem.ip2nick.help 
}

#Zmodem.IPtoNick off
on *:dns: {
  if ($raddress == $null) && (%Zmodem.ip2nick.searching == on) { set %Zmodem.ip2nick.res Cannot Retrieve | .disable #Zmodem.IPtoNickZmodem.IpToNick | halt }  
  else {
    if (%Zmodem.ip2nick.searching == on) { .who $naddress }
    halt
  }
}
raw 352:*: {  if (%Zmodem.ip2nick.searching == on) { set %Zmodem.ip2nick.res $6 | did -r IP 5 | did -a IP 5 %Zmodem.ip2nick.res | echo -a Resolved Nick: %Zmodem.ip2nick.res | dialog -t IP Search Successfull! | halt } }
raw 315:*: {  if (%Zmodem.ip2nick.searching == on) { .disable #Zmodem.IPtoNickZmodem.IPtoNick | halt } }

#Zmodem.IPtoNick end



;// ------------------------------------------------------------ //
;// --------- TOPIC HISTORY SCRIPT ----------------------------- //
;// ------------------------------------------------------------ //

menu @Topic_history {
  Clear History for this channel:{
    if $gettok($strip($line(@Topic_history,1)),1,32) != $null {
      /cleartopichistory $gettok($strip($line(@Topic_history,1)),1,32)
      /clear
    }
  }
}

on 1:TOPIC:*:{ 
  if $1- != $null { 
    /settopichistory $chan $1-  $+ ( $+ $nick $+ )
  }
}



;// ------------------------------------------------------------ //
;// --------- TSZ CODETALK ------------------------------------- //
;// ------------------------------------------------------------ //

; TpA - Author: ©Snake & Zit (TpA Crew 2001-2002)

on 1:text:*:#:{
  if (<-> isin $1-) { uncx $2- }
  return
}
alias /code /cx $1-
alias /cx {  
  %text = $replace($1-,a,Ñ) | %text = $replace(%text,A,Ñ)
  %text = $replace(%text,b,Û) | %text = $replace(%text,g,4)
  %text = $replace(%text,c,È) | %text = $replace(%text,d,à)
  %text = $replace(%text,e,á) | %text = $replace(%text,E,â)
  %text = $replace(%text,i,ã) | %text = $replace(%text,e,5)
  %text = $replace(%text,m,å) | %text = $replace(%text,n,ñ)
  %text = $replace(%text,o,æ) | %text = $replace(%text,O,é)
  %text = $replace(%text,p,2) | %text = $replace(%text,w,ò)
  %text = $replace(%text,W,ô) | %text = $replace(%text,f,ê)
  %text = $replace(%text,F,Ú) | %text = $replace(%text,k,+)
  %text = $replace(%text,r,Õ) | %text = $replace(%text,s,ë )
  %text = $replace(%text,t,ó) | %text = $replace(%text,T,ð)
  %text = $replace(%text,u,1) | %text = $replace(%text,y,õ)
  %text = $replace(%text,?,¿) | %text = $replace(%text,z,7)
  %text = $replace(%text,h,$) | %text = $replace(%text,j,^)
  %text = $replace(%text,v,`) | %text = $replace(%text,x,=)
  %text = $replace(%text,l,8) | %text = $replace(%text,!,¡) 
  msg $Active <-> %text 
  unset %text
}
alias /uncx {  
  %text = $replace($1-,Ñ,a) | %text = $replace(%text,Ñ,A)
  %text = $replace(%text,Û,b) | %text = $replace(%text,4,g)
  %text = $replace(%text,È,c) | %text = $replace(%text,à,d)
  %text = $replace(%text,á,e) | %text = $replace(%text,â,E)
  %text = $replace(%text,ã,i) | %text = $replace(%text,5,e)
  %text = $replace(%text,å,m) | %text = $replace(%text,ñ,n)
  %text = $replace(%text,æ,o) | %text = $replace(%text,é,O)
  %text = $replace(%text,2,p) | %text = $replace(%text,ò,w)
  %text = $replace(%text,ô,W) | %text = $replace(%text,ê,f)
  %text = $replace(%text,Ú,F) | %text = $replace(%text,+,k)
  %text = $replace(%text,Õ,r) | %text = $replace(%text,ë,s )
  %text = $replace(%text,ó,t) | %text = $replace(%text,ð,T)
  %text = $replace(%text,1,u) | %text = $replace(%text,õ,y)
  %text = $replace(%text,¿,?) | %text = $replace(%text,7,z)
  %text = $replace(%text,$,h) | %text = $replace(%text,^,j)
  %text = $replace(%text,`,v) | %text = $replace(%text,=,x)
  %text = $replace(%text,8,l) | %text = $replace(%text,¡,!)
  echo 4 $Active < $+ $nick $+ > %text 12[04 $+ TSZ Codetalk $+ 12]  
  unset %text
}

; // ----------------------------------------------- //
; // ------------------ NICKCOLOR SCRIPT ----------- //
; // ----------------------------------------------- //
dialog tszoption {
  title "Option"
  size -1 -1 156 129
  option dbu
  tab "Nick colors", 1, 1 0 153 127
  box "Nick", 5, 4 17 148 21, tab 1
  box "@Ops", 6, 4 38 148 21, tab 1
  box "%Halfops", 7, 4 59 148 21, tab 1
  box "+Voices", 8, 4 81 148 21, tab 1
  box "Normal", 9, 4 104 148 21, tab 1
  text "Nick", 10, 8 26 55 8, tab 1 center
  text "@Ops", 11, 8 47 55 8, tab 1 center
  combo 12, 84 24 65 120, tab 1 size drop
  text "%Halfops", 13, 8 68 55 8, tab 1 center
  text "+Voices", 14, 8 90 55 8, tab 1 center
  text "Normal", 15, 8 113 55 8, tab 1 center
  combo 16, 84 43 65 120, tab 1 size drop
  combo 17, 84 66 65 120, tab 1 size drop
  combo 18, 84 86 65 120, tab 1 size drop
  combo 19, 84 111 65 120, tab 1 size drop
  text "", 20, 65 26 17 8, tab 1
  text "", 21, 65 47 17 8, tab 1
  text "", 22, 65 68 17 8, tab 1
  text "", 23, 65 90 17 8, tab 1
  text "", 24, 65 113 17 8, tab 1
  tab "Away", 2
  tab "User modes", 3
  box "User modes", 25, 7 18 67 93, tab 3
  check "Invisible", 26, 14 30 43 10, tab 3
  check "Wallops", 27, 14 46 50 10, tab 3
  check "Global notice", 28, 14 62 50 10, tab 3
  check "Server notice", 29, 14 76 50 10, tab 3
  button "Default settings", 30, 11 92 56 12, tab 3
  tab "Ignores", 4
  list 31, 4 51 147 73, tab 4 size
  box "Set ignore modes for a user", 32, 4 14 146 35, tab 4
  text "Nick:", 33, 8 23 15 8, tab 4
  check "Private", 34, 86 19 30 10, tab 4
  check "Channel", 35, 86 28 33 10, tab 4
  check "Notice", 36, 86 37 33 10, tab 4
  check "CTCP", 37, 119 20 29 10, tab 4
  check "Invite", 38, 119 29 28 10, tab 4
  check "DCC", 39, 119 37 26 10, tab 4
  edit "", 40, 26 22 50 10, tab 4
  button "Add / Change", 41, 6 35 77 11, tab 4
}

; ////---------------/////
; ////-- On Dialog --/////
; ////---------------/////

on *:dialog:tszoption:init:0:{

  /mdx SetMircVersion $version
  /mdx MarkDialog $dname

  ; ////-- COLOR NICKS --////

  /mdx SetColor $dname 10,11,13,14,15 background $c2rgb($color(Listbox))
  /mdx SetColor $dname 10,11,13,14,15 textbg $c2rgb($color(Listbox))
  /mdx SetColor $dname 10 text $c2rgb(%nick.colours.m)
  /mdx SetColor $dname 11 text $c2rgb(%nick.colours.o)
  /mdx SetColor $dname 13 text $c2rgb(%nick.colours.h)
  /mdx SetColor $dname 14 text $c2rgb(%nick.colours.v)
  /mdx SetColor $dname 15 text $c2rgb(%nick.colours.n)

  /mdx SetColor $dname 20 background $c2rgb(%nick.colours.m)
  /mdx SetColor $dname 21 background $c2rgb(%nick.colours.o)
  /mdx SetColor $dname 22 background $c2rgb(%nick.colours.h)
  /mdx SetColor $dname 23 background $c2rgb(%nick.colours.v)
  /mdx SetColor $dname 24 background $c2rgb(%nick.colours.n)

  /did -ra $dname 5 $me
  /did -ra $dname 10 $me

  /did -a $dname 12 White (0)
  /did -a $dname 12 Black (1)
  /did -a $dname 12 Navy (2)
  /did -a $dname 12 Green (3)
  /did -a $dname 12 Red (4)
  /did -a $dname 12 Maroon (5)
  /did -a $dname 12 Purple (6)
  /did -a $dname 12 Orange (7)
  /did -a $dname 12 Yellow (8)
  /did -a $dname 12 L. Green (9)
  /did -a $dname 12 Turkiz (10)
  /did -a $dname 12 L. Blue (11)
  /did -a $dname 12 Blue (12)
  /did -a $dname 12 Pink (13)
  /did -a $dname 12 Gray (14)
  /did -a $dname 12 Silver (15)

  /did -a $dname 16 White (0)
  /did -a $dname 16 Black (1)
  /did -a $dname 16 Navy (2)
  /did -a $dname 16 Green (3)
  /did -a $dname 16 Red (4)
  /did -a $dname 16 Maroon (5)
  /did -a $dname 16 Purple (6)
  /did -a $dname 16 Orange (7)
  /did -a $dname 16 Yellow (8)
  /did -a $dname 16 L. Green (9)
  /did -a $dname 16 Turkiz (10)
  /did -a $dname 16 L. Blue (11)
  /did -a $dname 16 Blue (12)
  /did -a $dname 16 Pink (13)
  /did -a $dname 16 Gray (14)
  /did -a $dname 16 Silver (15)

  /did -a $dname 17 White (0)
  /did -a $dname 17 Black (1)
  /did -a $dname 17 Navy (2)
  /did -a $dname 17 Green (3)
  /did -a $dname 17 Red (4)
  /did -a $dname 17 Maroon (5)
  /did -a $dname 17 Purple (6)
  /did -a $dname 17 Orange (7)
  /did -a $dname 17 Yellow (8)
  /did -a $dname 17 L. Green (9)
  /did -a $dname 17 Turkiz (10)
  /did -a $dname 17 L. Blue (11)
  /did -a $dname 17 Blue (12)
  /did -a $dname 17 Pink (13)
  /did -a $dname 17 Gray (14)
  /did -a $dname 17 Silver (15)

  /did -a $dname 18 White (0)
  /did -a $dname 18 Black (1)
  /did -a $dname 18 Navy (2)
  /did -a $dname 18 Green (3)
  /did -a $dname 18 Red (4)
  /did -a $dname 18 Maroon (5)
  /did -a $dname 18 Purple (6)
  /did -a $dname 18 Orange (7)
  /did -a $dname 18 Yellow (8)
  /did -a $dname 18 L. Green (9)
  /did -a $dname 18 Turkiz (10)
  /did -a $dname 18 L. Blue (11)
  /did -a $dname 18 Blue (12)
  /did -a $dname 18 Pink (13)
  /did -a $dname 18 Gray (14)
  /did -a $dname 18 Silver (15)

  /did -a $dname 19 White (0)
  /did -a $dname 19 Black (1)
  /did -a $dname 19 Navy (2)
  /did -a $dname 19 Green (3)
  /did -a $dname 19 Red (4)
  /did -a $dname 19 Maroon (5)
  /did -a $dname 19 Purple (6)
  /did -a $dname 19 Orange (7)
  /did -a $dname 19 Yellow (8)
  /did -a $dname 19 L. Green (9)
  /did -a $dname 19 Turkiz (10)
  /did -a $dname 19 L. Blue (11)
  /did -a $dname 19 Blue (12)
  /did -a $dname 19 Pink (13)
  /did -a $dname 19 Gray (14)
  /did -a $dname 19 Silver (15)

  /did -c $dname 12 $calc($nckc(m) + 1)
  /did -c $dname 16 $calc($nckc(o) + 1)
  /did -c $dname 17 $calc($nckc(h) + 1)
  /did -c $dname 18 $calc($nckc(v) + 1)
  /did -c $dname 19 $calc($nckc(n) + 1)

  ; ////-- USER MODES --////

  if (i isin $usermode) { did -c $dname 26 }
  else { did -u $dname 26 }

  if (w isin $usermode) { did -c $dname 27 }
  else { did -u $dname 27 }

  if (g isin $usermode) { did -c $dname 28 }
  else { did -u $dname 28 }

  if (s isin $usermode) { did -c $dname 29 } 
  else { did -u $dname 29 }

  ; ////-- IGNORES --////

  var %i = 1
  while %i <= $ignore(0) {
    if $gettok($ignore(%i),1,33) != $chr(42) {
      did -a $dname 31 $gettok($ignore(%i),1,33) - $ignore(%i).type
    }
    inc %i
  }

}

on *:dialog:tszoption:sclick:*:{

  ; ////-- COLOR NICKS --////

  if $did == 12 { set %nick.colours.m $calc($did($dname,$did).sel - 1) | setaccol }
  elseif $did == 16 { set %nick.colours.o $calc($did($dname,$did).sel - 1) | setaccol }
  elseif $did == 17 { set %nick.colours.h $calc($did($dname,$did).sel - 1) | setaccol }
  elseif $did == 18 { set %nick.colours.v $calc($did($dname,$did).sel - 1) | setaccol }
  elseif $did == 19 { set %nick.colours.n $calc($did($dname,$did).sel - 1) | setaccol }

  /mdx SetMircVersion $version
  /mdx MarkDialog $dname
  if ($did == 12 || $did == 16 || $did == 17 || $did == 18 || $did == 19) {

    /mdx SetColor $dname 10,11,13,14,15 background $rgb(0,0,0)
    /mdx SetColor $dname 10,11,13,14,15 textbg $rgb(0,0,0)
    /mdx SetColor $dname 10 text $c2rgb(%nick.colours.m)
    /mdx SetColor $dname 11 text $c2rgb(%nick.colours.o)
    /mdx SetColor $dname 13 text $c2rgb(%nick.colours.h)
    /mdx SetColor $dname 14 text $c2rgb(%nick.colours.v)
    /mdx SetColor $dname 15 text $c2rgb(%nick.colours.n)

    /mdx SetColor $dname 20 background $c2rgb(%nick.colours.m)
    /mdx SetColor $dname 21 background $c2rgb(%nick.colours.o)
    /mdx SetColor $dname 22 background $c2rgb(%nick.colours.h)
    /mdx SetColor $dname 23 background $c2rgb(%nick.colours.v)
    /mdx SetColor $dname 24 background $c2rgb(%nick.colours.n)
  }

  ; ////-- USER MODES --////
  if $did == 26 {
    if $did($dname,26).state { mode $me +i  }
    else { mode $me -i }
  }
  elseif $did == 27 {
    if $did($dname,27).state { mode $me +w  }
    else { mode $me -w }
  }
  elseif $did == 28 { 
    if $did($dname,28).state { mode $me +g  } 
    else { mode $me -g }
  }
  elseif $did == 29 {
    if $did($dname,29).state { mode $me +s  } 
    else { mode $me -s }
  }
  elseif $did == 30 {
    mode $me +iw
    mode $me -gs
    did -c $dname 26
    did -c $dname 27
    did -u $dname 28
    did -u $dname 29
  }

  ; ////-- IGNORES --////

  elseif $did == 31 {
    if $did($dname,$did).sel != $null {
      /did -ra $dname 40 $gettok($did($dname,$did).seltext,1,32)

      if dcc isin $gettok($did($dname,$did).seltext,3,32) { did -c $dname 39 }
      else { did -u $dname 39 }

      if invite isin $gettok($did($dname,$did).seltext,3,32) { did -c $dname 38 }
      else { did -u $dname 38 }

      if private isin $gettok($did($dname,$did).seltext,3,32) { did -c $dname 34 }
      else { did -u $dname 34 }

      if channel isin $gettok($did($dname,$did).seltext,3,32) { did -c $dname 35 }
      else { did -u $dname 35 }

      if notice isin $gettok($did($dname,$did).seltext,3,32) { did -c $dname 36 }
      else { did -u $dname 36 }

      if ctcp isin $gettok($did($dname,$did).seltext,3,32) { did -c $dname 37 }
      else { did -u $dname 37 }
    }
  }
  elseif $did == 41 {
    if ($did($dname,40) != $null && ($did(34).state || $did(35).state || $did(36).state || $did(37).state || $did(38).state || $did(39).state)) {
      var %mode = -w
      if $did(34).state { %mode = %mode $+ p }
      if $did(35).state { %mode = %mode $+ c }
      if $did(36).state { %mode = %mode $+ n }
      if $did(37).state { %mode = %mode $+ t }
      if $did(38).state { %mode = %mode $+ i }
      if $did(39).state { %mode = %mode $+ d }

      .ignore %mode $did($dname,40)

      did -r $dname 31

      var %i = 1
      while %i <= $ignore(0) {
        if $gettok($ignore(%i),1,33) != $chr(42) {
          did -a $dname 31 $gettok($ignore(%i),1,33) - $ignore(%i).type
        }
        inc %i
      }
    }
  }
}

on *:dialog:tszoption:dclick:*:{

  ; ////-- IGNORES --////

  if $did == 31 {
    if $did($dname,$did).sel != $null {
      .ignore -rw $gettok($did($dname,$did).seltext,1,32)

      did -r $dname 31

      var %i = 1
      while %i <= $ignore(0) {
        if $gettok($ignore(%i),1,33) != $chr(42) {
          did -a $dname 31 $gettok($ignore(%i),1,33) - $ignore(%i).type
        }
        inc %i
      }

    }
  }
}


; ////-- Nick colors - misc on events --////

on *:deop:#: .timer 1 1 cl $opnick $chan $!ncol( [ $opnick ] , [ $chan ] )
on *:serverop:#: .timer 1 1 cl $opnick $chan $!ncol( [ $opnick ] , [ $chan ] )
on *:dehelp:#: .timer 1 1 cl $opnick $chan $!ncol( [ $opnick ] , [ $chan ] )
on *:devoice:#: .timer 1 1 cl $vnick $chan $!ncol( [ $vnick ] , [ $chan ] )

on *:op:#:{
  ; ////-- COLOR NICKS --////
  .timer 1 1 cl $opnick $chan $!ncol( [ $opnick ] , [ $chan ] )

  ; ////-- AUTO-THX --////
  if (($sets(autothx,op) == on) && ($me == $opnick)) { /msg $chan Thanks for the Op $nick }
}

on *:help:#:{
  ; ////-- COLOR NICKS --////
  .timer 1 1 cl $opnick $chan $!ncol( [ $opnick ] , [ $chan ] )

  ; ////-- AUTO-THX --////
  if (($sets(autothx,halfop) == on) && ($me == $opnick)) { /msg $chan Thanks for the HalfOp $nick }
}

on *:voice:#:{
  ; ////-- COLOR NICKS --////
  .timer 1 1 cl $vnick $chan $!ncol( [ $vnick ] , [ $chan ] )

  ; ////-- AUTO-THX --////
  if (($sets(autothx,voice) == on) && ($me == $opnick)) { /msg $chan Thanks for the Voice $nick }
}

; ////-- Nick color aliases --////
alias setncol {
  if $chan($1) != $null {
    var %i = 1
    while %i <= $nick($1,0) {
      cline $ncol($nick($1,%i),$1) $1 %i
      inc %i
    }  
  }
}
alias setaccol {
  var %c = 1
  while %c <= $chan(0) {
    setncol $chan(%c)
    inc %c
  }
}

alias nckc return %nick.colours. [ $+ [ $1 ] ]

alias cl {
  if ($1 !ison $2) return
  else cline $3-
}

alias ncol {
  if ($1 == $me) return $nckc(m) $2 $nick($2, $1)
  if ($1 isop $2) return $nckc(o) $2 $nick($2, $1)
  if ($1 ishelp $2) return $nckc(h) $2 $nick($2, $1)
  if ($1 isvo $2) return $nckc(v) $2 $nick($2, $1)
  return $nckc(n) $2 $nick($2, $1)
}

; ////-- Common aliases --////

alias tsz_option {
  if $dialog(tszoption) == $null { /dialog -m tszoption tszoption }
}

alias tsz_option.ncol {
  /tsz_option
  did -f tszoption 1
}

alias tsz_option.umode { 
  /tsz_option
  did -f tszoption 3
}

alias tsz_option.away {
  /tsz_option
  did -f tszoption 2
}

alias tsz_option.ignore {
  /tsz_option
  did -f tszoption 4
}


on 1:dialog:error:init:0:{ unset %error }

alias SetCN {
  if ($did(cs,1).state == 1) {
    CSet misc nickcolor on
    did -c cs 1 
  }
  else { 
    Cset misc nickcolor  off 
    did -u cs 1
  }
}

alias CheckClr {
  if ($sets(misc,nickcolor) == on) { did -c cs 1 } 
}

alias SClr {
  if ($1 isnum) { LoadError Please Select A Color Parameter to Change ... | STOP }
  if $1 = EditBox.Text { //colour EditBox Text $2 }
  elseif $1 = ListBox.Text { //colour ListBox Text $2 }
  elseif $1 = EditBox { //colour EditBox $2 }
  elseif $1 = ListBox { //colour ListBox $2 }
  elseif $1 = Normal.Text { //colour Normal Text $2 }
  elseif $1 = Nick.Text { //colour Nick Text $2 }
  elseif $1 = info.Text { //colour info Text $2 }
  elseif $1 = info2.Text { //colour info2 Text $2 }
  elseif $1 = join.Text { //colour join Text $2 }
  elseif $1 = part.Text { //colour part Text $2 }
  elseif $1 = kick.Text { //colour kick Text $2 }
  elseif $1 = Quit.Text { //colour Quit Text $2 }
  elseif $1 = wallops.Text { //colour wallops Text $2 }
  elseif $1 = notice.Text { //colour Notice Text $2 }
  elseif $1 = mode.Text { //colour mode Text $2 }
  elseif $1 = invite.Text { //colour invite Text $2 }
  elseif $1 = action.Text { //colour action Text $2 }
  elseif $1 = ctcp.text { //colour ctcp text $2 }
  elseif $1 = notify.text { //colour notify text $2 }
  elseif $1 = highlight.text { //colour highlight text $2 }
  elseif $1 = Own.Text { //colour Own Text $2 }
  elseif $1 = BackGround { //colour BackGround $2 }
  else { writeini $shortfn($mircdirsystem\settings.ini) viz $1 $2 }
  DecClr $1 $3
}

alias DecClr {
  %clr = $readini $shortfn($mircdirsystem\settings.ini) viz $1 
  did -u CS 10 
  did -u CS 11 
  did -u CS 12 
  did -u CS 13 
  did -u CS 14 
  did -u CS 15 
  did -u CS 16 
  did -u CS 17 
  did -u CS 18 
  did -u CS 19 
  did -u CS 20 
  did -u CS 21 
  did -u CS 22
  did -u CS 23
  did -u CS 24
  did -u CS 25 

  if (%clr == 0) { did -c CS 10 }
  if (%clr == 1) { did -c CS 11 }
  if (%clr == 2) { did -c CS 12 }
  if (%clr == 3) { did -c CS 13 }
  if (%clr == 4) { did -c CS 14 }
  if (%clr == 5) { did -c CS 15 }
  if (%clr == 6) { did -c CS 16 }
  if (%clr == 7) { did -c CS 17 }
  if (%clr == 8) { did -c CS 18 }
  if (%clr == 9) { did -c CS 19 }
  if (%clr == 10) {  did -c CS 20 }
  if (%clr == 11) { did -c CS 21 }
  if (%clr == 12) { did -c CS 22 }
  if (%clr == 13) { did -c CS 23 }
  if (%clr == 14) { did -c CS 24 }
  if (%clr == 15) { did -c CS 25 }
  unset %Clr  
}

alias OPc { return $readini $shortfn($mircdirsystem\settings.ini) viz Nick.ops }
alias HOc { return $readini $shortfn($mircdirsystem\settings.ini) viz Nick.HalfOps }
alias VOc { return $readini $shortfn($mircdirsystem\settings.ini) viz Nick.voices }
alias USc { return $readini $shortfn($mircdirsystem\settings.ini) viz Nick.users }
alias EBc { return $color(Editbox text) }
alias NFc { return $color(Notify text) }
alias ACc { return $color(Action text) }
alias CTc { return $color(Ctcp text) }
alias MOc { return $color(Mode text) }
alias PAc { return $color(Part Text) }
alias JOc { return $color(Join text) }
alias KKc { return $color(Kick text) }
alias Nic { return $color(Notice text) }
alias HTc { return $color(Other text) }
alias WOc { return $color(Wallops text) }

alias cIN {
  if $1- != $null {
    return 4 $+  $+ $1- $+ 
  }
  else { return 4 }
}

alias cIN2 { 
  if $1- != $null {
    return 10 $+  $+ $1- $+ 
  }
  else { return 10 }
}

alias dinc { return $color(Info text) }
alias iN2c { return $color(Info2 text) }
alias Vic { return $color(Invite text) }
alias HLc { return $color(Highlight text) }
alias BGc { return $color(Background) }
alias OTc { return $color(Own text) }
alias NTc { return $color(Normal text) }
alias Boc { return $color(Editbox) }
alias LBc { return $read(Listxox) }
alias LBTc { return $color(Listbox text) }
alias BRc { return $readini $shortfn($mircdirsystem\settings.ini) viz Barracks }
alias NCc { return $readini $shortfn($mircdirsystem\settings.ini) viz Nick } 
alias ADT { return $readini $shortfn($mircdirsystem\settings.ini) viz ADV.Text }
alias ADi { return $readini $shortfn($mircdirsystem\settings.ini) viz ADV.info }

alias SaveC {
  %File = $shortfn($mircdirsystem\settings.ini)
  writeini %file viz Own.Text $OTc
  writeini %file viz Nick.Text $NTc
  writeini %file viz Background $BGc
  writeini %file viz EditBox.Text $EBc
  writeini %file viz ListBox.Text $LBTc
  writeini %file viz EditBox $BOc
  writeini %file viz ListBox $LBc
  writeini %file viz Nick.Ops $opc
  writeini %file viz Nick.HalfOps $hoc
  writeini %file viz Nick.voices $voc
  writeini %file viz Nick.users $usc
  writeini %file viz Nick $Ncc
  writeini %file viz Barracks $BRc
  writeini %file viz action.Text $ACc
  writeini %file viz notify.Text $NFc
  writeini %file viz ctcp.Text $CTc
  writeini %file viz highlight.Text $HLc
  writeini %file viz info.Text $dinc
  writeini %file viz info2.Text $iN2c
  writeini %file viz invite.Text $Vic
  writeini %file viz notice.Text $Nic
  writeini %file viz wallops.Text $WOc
  writeini %file viz kick.Text $KKc
  writeini %file viz part.Text $PAc
  writeini %file viz join.Text $JOc
  writeini %file viz mode.Text $MOc
  writeini %file viz other.text $HTc
  writeini %file viz ADV.text $ADT
  writeini %file viz ADV.info $ADi
  unset %file
}

; // ----------------------------------------------- //
; // ------------------ STATS SCRIPT --------------- //
; // ----------------------------------------------- //

alias scst {
  if $dialog(statistics) == $null { /dialog -m statistics statistics }
}

dialog statistics {
  title "Script stats"
  size -1 -1 318 352
  option pixels
  tab "Input", 33, 2 3 312 324
  text "Words written", 2, 12 115 92 16, tab 33
  text "Lines written", 3, 11 200 95 16, tab 33
  text "Questions asked", 4, 11 283 95 16, tab 33
  text "0", 5, 139 33 86 16, tab 33 right
  text "0", 6, 139 53 86 16, tab 33 right
  text "0", 7, 139 73 86 16, tab 33 right
  text "0", 8, 139 94 86 16, tab 33 right
  text "0", 9, 139 114 86 16, tab 33 right
  text "total", 10, 231 33 50 16, tab 33
  text "per word", 11, 231 53 50 16, tab 33
  text "per line", 12, 231 73 50 16, tab 33
  text "per minute", 13, 231 94 59 16, tab 33
  text "total", 14, 231 114 80 16, tab 33
  text "0", 15, 139 135 86 16, tab 33 right
  text "chars per word", 16, 231 135 80 16, tab 33
  text "per line", 17, 231 156 71 16, tab 33
  text "0", 18, 139 156 86 16, tab 33 right
  text "per minute", 19, 231 177 71 16, tab 33
  text "0", 20, 139 177 86 16, tab 33 right
  text "total", 21, 231 199 71 16, tab 33
  text "0", 22, 139 199 86 16, tab 33 right
  text "words per line", 23, 231 220 71 16, tab 33
  text "0", 24, 139 220 86 16, tab 33 right
  text "chars per line", 25, 231 241 71 16, tab 33
  text "0", 26, 139 241 86 16, tab 33 right
  text "per minute", 27, 231 262 71 16, tab 33
  text "0", 28, 139 262 86 16, tab 33 right
  text "total", 29, 231 283 71 16, tab 33
  text "0", 30, 139 283 86 16, tab 33 right
  text "of total lines", 31, 231 304 71 16, tab 33
  text "0", 32, 139 304 86 16, tab 33 right
  text "Chars written", 1, 11 33 98 16, tab 33
  tab "Misc", 34
  text "Script starts", 35, 9 37 98 16, tab 34
  text "0", 36, 137 37 86 16, tab 34 right
  text "total", 37, 229 37 50 16, tab 34
  text "per day", 38, 229 57 50 16, tab 34
  text "0", 39, 137 57 86 16, tab 34 right
  text "0", 40, 137 77 86 16, tab 34 right
  text "total", 41, 229 77 50 16, tab 34
  text "per day", 42, 229 98 59 16, tab 34
  text "0", 43, 137 98 86 16, tab 34 right
  text "0", 44, 137 118 86 16, tab 34 right
  text "total", 45, 229 118 80 16, tab 34
  text "Users kicked", 46, 9 78 92 16, tab 34
  text "per day", 47, 229 138 80 16, tab 34
  text "0", 48, 137 138 86 16, tab 34 right
  text "Users banned", 49, 9 118 92 16, tab 34
  button "Close", 50, 239 327 75 21, ok
  button "Reset", 51, 159 328 75 20
}



on *:dialog:statistics:init:0:{
  /stats_update
}

alias stats_reset {
  set %stats.starts 0
  set %stats.bans 0
  set %stats.kicks 0
  set %stats.in.chars 0
  set %stats.in.words 0
  set %stats.in.lines 0
  set %stats.in.questions 0
  set %stats.lastreset $ctime
}

alias stats_update {
  /did -ra statistics 5 $round($calc(%stats.in.chars),3)
  /did -ra statistics 6 $round($calc(%stats.in.chars / %stats.in.words),3)
  /did -ra statistics 7 $round($calc(%stats.in.chars / %stats.in.lines),3)
  if (($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)) { /did -ra statistics 8 0.001 }
  else { /did -ra statistics 8 $round($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ),3) }

  /did -ra statistics 9 $round($calc(%stats.in.words),3)
  /did -ra statistics 15 $round($calc(%stats.in.chars / %stats.in.words),3)
  /did -ra statistics 18 $round($calc(%stats.in.words / %stats.in.lines),3)
  if (($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)) { /did -ra statistics 20 0.001 }
  else { /did -ra statistics 20 $round($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ),3) }

  /did -ra statistics 22 $round($calc(%stats.in.lines),3)
  /did -ra statistics 24 $round($calc(%stats.in.words / %stats.in.lines ),3)
  /did -ra statistics 26 $round($calc(%stats.in.chars / %stats.in.lines),3)
  if (($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)) { /did -ra statistics 28 0.001 }
  else { /did -ra statistics 28 $round($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ),3) }

  /did -ra statistics 30 $round($calc(%stats.in.questions),3)
  if $round($calc(%stats.in.questions / %stats.in.lines),1) <= 0.001 && $round($calc(%stats.in.questions / %stats.in.lines),1) != 0 { /did -ra statistics 32 0.1% }
  else { /did -ra statistics 32 $round($calc(100 * (%stats.in.questions / %stats.in.lines)),1) $+ % }

  /did -ra statistics 36 $round($calc(%stats.starts))
  if (($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)) { /did -ra statistics 39 0.001 }
  else { /did -ra statistics 39 $round($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3) }

  /did -ra statistics 40 $round($calc(%stats.kicks))
  if (($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)) { /did -ra statistics 43 0.001 }
  else { /did -ra statistics 43 $round($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3) }

  /did -ra statistics 44 $round($calc(%stats.bans))
  if (($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)) { /did -ra statistics 48 0.001 }
  else { /did -ra statistics 48 $round($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3) }
}

alias stats_view {
  /echo -a $logo(Script stats for user $me)
  /echo -a $cin(-------------------------------------)
  /echo -a $logo(Misc stats)
  /echo -a $cin2(Script starts:) $cin( %stats.starts ) $cin2(--- Starts per day:) $cin($iif((($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)),0.001,$round($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3)))
  /echo -a $cin2(Kicks:) $cin(%stats.kicks) $cin2(--- kicks per day) $cin($iif((($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)),0.001,$round($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3)))
  /echo -a $cin2(Bans:) $cin(%stats.bans) $cin2(--- bans per day) $cin($iif((($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)),0.001,$round($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3)))
  /echo -a $cin(-------------------------------------)
  /echo -a $logo(Input stats)
  /echo -a $cin2(Chars written:) $cin(%stats.in.chars)
  /echo -a $cin2(------ per word:) $cin($round($calc(%stats.in.chars / %stats.in.words),3))
  /echo -a $cin2(------ per line:) $cin($round($calc(%stats.in.chars / %stats.in.lines),3))
  /echo -a $cin2(------ per minute:) $cin($iif((($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)),0.001,$round($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ),3)))
  /echo -a $cin2(Words written:) $cin(%stats.in.words)
  /echo -a $cin2(------ chars per word:) $cin($round($calc(%stats.in.chars / %stats.in.words),3))
  /echo -a $cin2(------ per line:) $cin($round($calc(%stats.in.words / %stats.in.lines),3))
  /echo -a $cin2(------ per minute:) $cin($iif((($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)),0.001,$round($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ),3)))
  /echo -a $cin2(Lines written:) $cin(%stats.in.lines)
  /echo -a $cin2(------ words per line:) $cin($round($calc(%stats.in.words / %stats.in.lines ),3))
  /echo -a $cin2(------ chars per line:) $cin($round($calc(%stats.in.chars / %stats.in.lines),3))
  /echo -a $cin2(------ per minute:) $cin($iif((($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)),0.001,$round($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ),3)))
  /echo -a $cin2(Questions asked:) $cin($round($calc(%stats.in.questions),3))
  /echo -a $cin2(------ of total lines:) $cin($iif($round($calc(%stats.in.questions / %stats.in.lines),1) <= 0.001 && $round($calc(%stats.in.questions / %stats.in.lines),1) != 0,0.1,$round($calc(100 * ( %stats.in.questions / %stats.in.lines )),1)) $+ %)
  /echo -a $cin(-------------------------------------)
}

alias stats_show {
  if $me ison $active {
    /msg $active $logo(Script stats for user $me)
    /msg $active $cin(-------------------------------------)
    /msg $active $logo(Misc stats)
    /msg $active $cin2(Script starts:) $cin( %stats.starts ) $cin2(--- Starts per day:) $cin($iif((($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)),0.001,$round($calc( %stats.starts / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3)))
    /msg $active $cin2(Kicks:) $cin(%stats.kicks) $cin2(--- kicks per day) $cin($iif((($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)),0.001,$round($calc( %stats.kicks / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3)))
    /msg $active $cin2(Bans:) $cin(%stats.bans) $cin2(--- bans per day) $cin($iif((($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ) <= 0.001) && ($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ) != 0)),0.001,$round($calc( %stats.bans / ( ( $ctime - %stats.lastreset ) / 86400 ) ),3)))
    /msg $active $cin(-------------------------------------)
    /msg $active $logo(Input stats)
    /msg $active $cin2(Chars written:) $cin(%stats.in.chars)
    /msg $active $cin2(------ per word:) $cin($round($calc(%stats.in.chars / %stats.in.words),3))
    /msg $active $cin2(------ per line:) $cin($round($calc(%stats.in.chars / %stats.in.lines),3))
    /msg $active $cin2(------ per minute:) $cin($iif((($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)),0.001,$round($calc( %stats.in.chars / ( ( $ctime - %stats.lastreset ) / 60 ) ),3)))
    /msg $active $cin2(Words written:) $cin(%stats.in.words)
    /msg $active $cin2(------ chars per word:) $cin($round($calc(%stats.in.chars / %stats.in.words),3))
    /msg $active $cin2(------ per line:) $cin($round($calc(%stats.in.words / %stats.in.lines),3))
    /msg $active $cin2(------ per minute:) $cin($iif((($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)),0.001,$round($calc( %stats.in.words / ( ( $ctime - %stats.lastreset ) / 60 ) ),3)))
    /msg $active $cin2(Lines written:) $cin(%stats.in.lines)
    /msg $active $cin2(------ words per line:) $cin($round($calc(%stats.in.words / %stats.in.lines ),3))
    /msg $active $cin2(------ chars per line:) $cin($round($calc(%stats.in.chars / %stats.in.lines),3))
    /msg $active $cin2(------ per minute:) $cin($iif((($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ) <= 0.001) && ($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ) != 0)),0.001,$round($calc( %stats.in.lines / ( ( $ctime - %stats.lastreset ) / 60 ) ),3)))
    /msg $active $cin2(Questions asked:) $cin($round($calc(%stats.in.questions),3))
    /msg $active $cin2(------ of total lines:) $cin($iif($round($calc(%stats.in.questions / %stats.in.lines),1) <= 0.001 && $round($calc(%stats.in.questions / %stats.in.lines),1) != 0,0.1,$round($calc(100 * ( %stats.in.questions / %stats.in.lines )),1)) $+ %)
    /msg $active $cin(-------------------------------------)
  }
}

on *:dialog:statistics:sclick:51:{
  /stats_reset
  /stats_update
}



;//////////////////////////////////////////////
;//----------- ON JOIN --------------------- //
;//////////////////////////////////////////////

on *:JOIN:*:{

  ;//-- For topic history
  .timer 1 4 settopichistory $chan

  ;//-- For nickcolor
  if ($nick == $me) { .timer 1 10 setncol # }
  else { .timer 1 1 cl $nick $chan $!ncol( [ $nick ] , [ $chan ] ) }

  ;//-- For shitlister script
  if $group(#Shitlister) == on {
    unset %temp*
    if ($exists(shitlist.ini) == $false) { write -c shitlist.ini | goto done }
    set %temp1 $readini Shitlist.ini Settings NOSL
    if (%temp1 == $null) { goto done }
    :start
    inc %temp2
    if (%temp2 > %temp1) { goto done }
    set %temp3 $readini Shitlist.ini Shitlisted %temp2
    set %temp3 $slacb(%temp3)
    if (%temp3 ISWM $address($nick,0)) {
      set %temp4 $readini Shitlist.ini $slac(%temp3) Channels
      if ((%temp4 == $chan) || (%temp4 == All Channels...)) { 
        set %temp5 $readini Shitlist.ini $slac(%temp3) Status
        if (%temp5 == Active) { 
          mode $chan +b %temp3
          kick $chan $nick $logo(Shitlist) $b($kicktext)
          goto done
        }
      }
    }
    goto start
    :done
    unset %temp*
  }
}

on *:START:{
  ;//-- Settings dialog
  if ($sets(forward,joins) == NotSet) { /CSet forward joins on }
  if ($sets(forward,parts) == NotSet) { /CSet forward parts on }
  if ($sets(forward,quits) == NotSet) { /CSet forward quits on }
  if ($sets(forward,modes) == NotSet) { /CSet forward modes on }
  if ($sets(forward,snotice) == NotSet) { /CSet forward snotice on }
  if ($sets(misc,strip) == on) { /optioncontrol }

  ;//-- For nickcolor script
  .timer 0 3600 setaccol
}

on *:LOAD: {
  ;//-- For the netsplit script
  if ($version < 5.7) {
    echo -a *** Sorry but this netsplit detector requires 5.7x or greater,
    echo -a $str($chr(160),3) it's recommended that you upgrade to the
    echo -a $str($chr(160),3) current version of mIRC, http://www.mirc.com/get.html
    echo -a $str($chr(160),3) this add-on will now unload...Seeya!
  }
  else {
    echo -a *** Thanx for trying out NetSplit v1.1. If you'd like more info on this addon type /nsabout.
    echo -a *** Starting setup...
    %netsplitWarning = $?!="Would you like to warn others of a NetSplit? (This is discouraged as it uses amsg, and might annoy ops!)"
    %netsplitQuit = $?!="Would you like to use this add-on's custom quit? (Only affects splits)"
    echo -a *** Setup complete. See channel popups for other options.
  }
}
