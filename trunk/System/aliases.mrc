nick {
  if ($1 != $null) {
    /nick $1
    if ($2 != $null) { /.nickserv identify $2 }
  }
  else { /echo # Your current nick is $me }

}
nickservid { 
  /.msg nickserv $1- 
  /.msg tsz2nickserv $1-
}
nickserv { 
  if (register isin $1) { /.msg nickserv $1- 
    /.msg tsz2nickserv $1-
  }
  if (cat !ison #blackcats) || (%tsz2 == on) { /.msg tsz2nickserv $1-
  }
  if (cat ison #blackcats) { /.msg nickserv $1-
  }
}

chanserv {
  if (register isin $1)  { /.msg chanserv $1- 
    /.msg tsz2chanserv $1-
  }
  if (cat !ison #blackcats) || (%tsz2 == on) { /.msg tsz2chanserv $1-
  }
  if (cat ison #blackcats) { /.msg chanserv $1-
  }
}
memoserv {
  if (cat !ison #blackcats) || (%tsz2 == on) { /.msg tsz2memoserv $1-
  }
  else { /.msg memoserv $1-
  }
}

botserv {
  if (cat !ison #blackcats) || (%tsz2 == on) { /.msg tsz2botserv $1-
  }
  else { /.msg botserv $1-
  }
}

operserv {
  if (cat !ison #blackcats) || (%tsz2 == on) { /.msg tsz2operserv $1-
  }
  else { /.msg operserv $1-
  }
}


ri { return $readini -n $1 $2 $3- }
ic { if ($address($1,5) == $null) { error $$1 $+ 's mask is not in the Internal Address List, please make sure you have a common channel and type /who $$1 $+ . | halt } }
rpunct { return $replace($strip($1-,burc),$chr(33),$chr(32),$chr(34),$chr(32),$chr(39),$chr(32),$chr(40),$chr(32),$chr(41),$chr(32),$chr(44),$chr(32),$chr(45),$chr(32),$chr(46),$chr(32),$chr(47),$chr(32),$chr(58),$chr(32),$chr(59),$chr(32),$chr(60),$chr(32),$chr(62),$chr(32),$chr(63),$chr(32),$chr(91),$chr(32),$chr(92),$chr(32),$chr(93),$chr(32),$chr(94),$chr(32),$chr(95),$chr(32),$chr(96),$chr(32),$chr(123),$chr(32),$chr(124),$chr(32),$chr(125),$chr(32)) }
ecomc { if ($1 isnum) && ($3 != $null) { set %~ecomc 0 | :start | inc %~ecomc 1 | if ($comchan($2,%~ecomc) == $null) { unset %~ecomc } | else { echo $1 $comchan($2,%~ecomc) $3- | goto start } } }
close if ($1 == $null) { echo -a  $+ $colour(info) $+ * /close: insufficient parameters | halt } | close $1- | if (-*s* iswm $1) { queue.send }
tag { return  $+ $sets(viz,ADV.text) $+ | $+  $+ $sets(viz,ADV.info) $+ $chr(37) $+  $+ $sets(viz,ADV.text) $+ | }
aecho { if ($left($active,1) == @) { secho $1- } | else { echo -a  $+ $sets(viz,ADV.text) $+ | $+  $+ $sets(viz,ADV.info) $+ $chr(37) $+  $+ $sets(viz,ADV.text) $+ | $1- } }
secho { echo -s  $+ $sets(viz,ADV.text) $+ | $+  $+ $sets(viz,ADV.info) $+ $chr(37) $+  $+ $sets(viz,ADV.text) $+ | $1- }
bracket { if ($1- != $null) { return  $+ $sets(viz,ADV.text) $+ | $+ $sets(viz,ADV.info) $+ $1- $+  $+ $sets(viz,ADV.text) $+ | } }
border { if ($1- != $null) { return $chr(91) $+ $1- $+ $chr(93) } }
svs { return  $+ $sets(viz,ADV.text) $+ $1 $+ : $+ $sets(viz,ADV.info) $+  $+ $2- $+  $+  $+ $sets(viz,ADV.text) $+ . } 
sv { return  $+ $sets(viz,ADV.text) $+ $1 $+ : $+  $+ $sets(viz,ADV.info) $+ $2- }
vs { return  $+ $sets(viz,ADV.info) $+ $1- }
isnum { if ($1 isnum) && (($1 >= 1) || (($1 == $2) && ($2 isnum) && ($2 >= 0))) { return $true } | else { return $false } }
vnum { if ($1 == $null) { return $iif($isnum($2,0) == $true,$2,1) } | set -u0 %~isnum 0 | :start | inc %~isnum 1 | if ($mid($1,%~isnum,1) == $null) { if ($isnum($1) == $true) { return $1 } | else { return $iif($isnum($2,0) == $true,$2,1) } } | elseif ($mid($1,%~isnum,1) !isnum) { if ($mid($1,$calc(%~isnum - 1),1) == $null) { return $iif($isnum($2,0) == $true,$2,1) } | elseif ($isnum($mid($1,1,$calc(%~isnum - 1))) == $true) { return $mid($1,1,$calc(%~isnum - 1)) } | else { return $iif($isnum($2,0) == $true,$2,1) } } | else { goto start } }
isset { if ($1 == $null) && ($2- == $null) { return n/a } | elseif ($1 == $null) && ($2 != $null) { return $2- } | else { return $1 } }
size { if ($1 < 0) || ($1 !isnum) { return n/a } | if ($round($calc($1 / 1000000000000),2) >= 1) { return $round($calc($1 / 1099511627776),2) $+ Tb } | if ($round($calc($1 / 1000000000),2) >= 1) { return $round($calc($1 / 1073741824),2) $+ Gb } | if ($round($calc($1 / 1000000),1) >= 1) { return $round($calc($1 / 1048576),1) $+ Mb } | if ($round($calc($1 / 1000),1) >= 1) { return $round($calc($1 / 1024),1) $+ Kb } | return $int($1) $+ b }
dopen { if ($2 != $null) { if ($dialog($1) == $null) { dialog -m $1 $2 } | else { dialog -v $1 $2 } } }
cw { return $int($calc(( [ $window(-3).w ] - ( [ $window(-3).w ] * (3/4)))/2)) $int($calc(( [ $window(-3).h ] - ( [ $window(-3).h ] * (3/4)))/2)) $int($calc( [ $window(-3).w ] * (3/4))) $int($calc( [ $window(-3).h ] * (3/4))) }
color { if ($1 isnum 0-15) { if ($1 == 0) { return White } | if ($1 == 1) { return Black } | if ($1 == 2) { return Blue } | if ($1 == 3) { return Green } | if ($1 == 4) { return Red } | if ($1 == 5) { return Brown } | if ($1 == 6) { return Purple } | if ($1 == 7) { return Orange } | if ($1 == 8) { return Yellow } | if ($1 == 9) { return Light Green } | if ($1 == 10) { return Cyan } | if ($1 == 11) { return Light Cyan } | if ($1 == 12) { return Royal Blue } | if ($1 == 13) { return Pink } | if ($1 == 14) { return Grey } | if ($1 == 15) { return Light Grey } } }
vc { if ($left($1,1) != $chr(35)) { return $chr(35) $+ $1- } | else { return $1- } }
visible { if ($colour(back) == 1) { return $replace($1-,10,42,11,43,12,44,13,45,14,46,15,47,16,00,17,01,18,02,19,03,20,04,21,05,22,06,23,07,24,08,25,09,1,14,01,14,2,12,02,12,5,04,05,04) } | elseif ($colour(back) == 0) { return $replace($1-,00,32,01,33,02,34,03,35,04,36,05,37,06,38,07,39,08,40,09,41,8,39,40,39,9,35,41,35,11,10,0,14,32,14) } | else { return $1-  } }
percent { if ($1 isnum) && ($2 isnum) { return $round($calc(($1 / $2) * 100),2) $+ $chr(37) } }
dla { if ($3 != $null) { set %~dlg-c 0 | :start | inc %~dlg-c 1 | if ($gettok($3-,%~dlg-c,44) == $null) { unset %~dlg-c } | else { did -a $1 $2 $gettok($3-,%~dlg-c,44) | goto start } } }
dls { if ($3 != $null) { set %~dlg-c 0 | :start | inc %~dlg-c 1 | if ($did($1,$2,%~dlg-c).text == $null) { $3- $gettok(%~dlg-data,1-,44) | unset %~dlg-c %~dlg-data } | else { set %~dlg-data %~dlg-data $+ , $+ $did($1,$2,%~dlg-c).text | goto start } } }
ordinal { if ($isnum($1) == $true) { if (($right($1,2) isnum 11-19) || ($right($1,1) == 0) || ($right($1,1) isnum 4-9)) { return $1 $+ th } | if ($right($1,1) == 1) { return $1 $+ st } | if ($right($1,1) == 2) { return $1 $+ nd } | if ($right($1,1) == 3) { return $1 $+ rd } } }
dopall { set %~dopall 0 | :start | inc %~dopall 1 | if ($chan(%~dopall) == $null) { unset %~dopall } | elseif ($me isop $chan(%~dopall)) { mode $chan(%~dopall) -o+v $me $me | goto start } | else { goto start } }
opall { set %~opall 0 | :start | inc %~opall 1 | if ($chan(%~opall) == $null) { unset %~opall } | elseif ($me !isop $chan(%~opall)) { .ChanServ OP $chan(%~opall) $me | goto start } | else { goto start } }
on { return $chr(62) }
off { return $chr(160) $+ $chr(160) }
c { if ($1 isnum 1-2) && ($r.set(Colors,Colors) == On) && ($r.set(Colors,Color. [ $+ [ $1 ] ] ) isnum) { return $chr(3) $+ $tds($r.set(Colors,Color. [ $+ [ $1 ] ] )) } }
tds { if ($1 isnum) { return $iif($len($1) == 1,0) $+ $1 } }
w.set { if ($3 != $null) { writeini -n system\fserve.ini $1 $2 $strip($3-,burc) } }
r.set { if ($2 != $null) { return $readini -n system\fserve.ini $1 $2 } }
d.set { if ($2 != $null) { remini system\fserve.ini $1 $2 } }
t.set { if ($2 != $null) { return /ctcp $me $readini -n system\fserve.ini $1 $2 } }
allchk { if ($1 == $null) { return All } | else { return $1- } }
admsg { 
  if ($2 != $null) {
    if ($window(@triggers) == $null) window -esh @triggers 0 0 600 200
    echo @triggers $timestamp < $+ $me $+ > $2-
    if ($1 == All) { amsg $2- }
    else {
      set %~admsg 0
      :start
      inc %~admsg 1
      if ($gettok($1,%~admsg,44) != $null) {
        if ($me ison $gettok($1,%~admsg,44)) {
          .msg $gettok($1,%~admsg,44) $2-
        }
        goto start
      }
      else { unset %~admsg }
    }
  }
  else { error Syntax: /admsg <channel1,channel2,etc> <msg> }
}
amsg { if ($1 != $null) { set %~amsg 0 | :start | inc %~amsg 1 | if ($chan(%~amsg) == $null) { unset %~amsg } | elseif ($me ison $chan(%~amsg)) { msg $chan(%~amsg) $1- | goto start } | else { goto start } } | else { error Syntax: /amsg <msg> } }
ame {
  if ($1 != $null) { 
    set %~ame 0
    :start
    inc %~ame 1
    if ($chan(%~ame) == $null) {
      unset %~ame
    }
    elseif ($me ison $chan(%~ame)) {
      describe $chan(%~ame) $1-
      goto start
    }
    else {
      goto start
    }
  }
  else {
    error Syntax: /ame <msg>
  }
}
send.nick { if ($1 != $null) { if ($send($1) == $null) { return 0 } | set -u0 %~send-nc 0 | set -u0 %~send-nt 0 | :start | inc %~send-nc 1 | if ($send(%~send-nc) == $null) { return %~send-nt } | if ($send(%~send-nc) == $1) { inc %~send-nt 1 } | goto start } }
min.cps {
  if ($send(0) > 0) && ($r.set(Min.CPS,Status) == On) && ($r.set(Min.CPS,Rate) isnum) { 
    set %~mincps-c $calc($send(0) + 1) 
    :start 
    dec %~mincps-c 1
    if (%~mincps-c < 1) {
      unset %~mincps-c | return
    } 
    elseif (($send(%~mincps-c).cps < $r.set(Min.CPS,Rate)) && ($send(%~mincps-c).cps != $null) && ($send(%~mincps-c).cps != 0) && ($send(%~mincps-c).cps != n/a)) { 
      ;      echo -a $send(%~mincps-c) had their send stopped because their CPS was  $+ $sets(viz,ADV.info) $+ $send(%~mincps-c).cps $+  $+ $sets(viz,ADV.text) when minimum allowed is  $+ $sets(viz,ADV.info) $+ $r.set(Min.CPS,Rate) $+  $+ $sets(viz,ADV.text) $+ . 
      echo -a 10 $+ $send(%~mincps-c)  $+ $sets(viz,ADV.text) $+ had their send stopped because their CPS was  $+ $sets(viz,ADV.info) $send(%~mincps-c).cps $+  $+ $sets(viz,ADV.text) when minimum allowed is  $+ $sets(viz,ADV.info) $r.set(Min.CPS,Rate) $+  $+ $sets(viz,ADV.info) $+ cps. 
      if ($comchan($send(%~mincps-c),1) != $null) { 
        .notice $send(%~mincps-c)  $+ $sets(viz,ADV.text) $+ Your sends have stopped because one of your sends were going at  $+ $sets(viz,ADV.info) $send(%~mincps-c).cps $+  $+ $sets(viz,ADV.text) cps when minimum allowed is  $+ $sets(viz,ADV.info) $r.set(Min.CPS,Rate) $+  $+ $sets(viz,ADV.info) $+ cps.
      } 
      close -s $send(%~mincps-c)
    } 
    goto start 
  }
}
tch { if ($2 != $null) { set %~tch 0 | :start | inc %~tch 1 | if ($comchan($1,%~tch) == $null) { unset %~tch | return $false } | else { if ($findtok($2,$comchan($1,%~tch),1,44) isnum) { unset %~tch | return $true } | else { goto start } } } }
tc {
  if ($2 == Fserve) { if ($r.set(Fserve,Status) == On) { if ($r.set(Fserve,Channels) == All) { if ($comchan($1,1) != $null) { return $true } | else { return $false } } | if ($tch($1,$r.set(Fserve,Channels)) == $true) { return $true } | else { return $false } } | else { return $false } }
  else { return $false }
}
queue { if ($1 isnum 0) { set -u0 %~queue-c 0 | :start | inc %~queue-c 1 | if (%Queue. [ $+ [ %~queue-c ] ] == $null) { return $calc(%~queue-c - 1) } | goto start | :end | unset %~queue-c } | elseif ($isnum($1) == $true) { return %Queue. [ $+ [ $1 ] ] } }
queue.nick { if ($1 != $null) { if ($queue(0) == 0) { return 0 } | set -u0 %~queue-nc 0 | set -u0 %~queue-nt 0 | :start | inc %~queue-nc 1 | if (%~queue-nc > $queue(0)) { return %~queue-nt } | if ($gettok($queue(%~queue-nc),2,32) == $1) { inc %~queue-nt 1 } | goto start } }
queue.timeout {
  set %queuetimeout 1 
  .timerqueue -o 1 300 queue.send
}
queue.send {
  :queue
  if ($queue(0) > 0) && ($r.set(Fserve,Max.Sends.Total) > $send(0)) {
    set %~queue-sc 0
    :start
    inc %~queue-sc 1
    if (%~queue-sc > $queue(0)) { unset %~queue-sc }
    else {
      if ($gettok($queue(%~queue-sc),1,32) == Fserve) {
        if (($tc($gettok($queue(%~queue-sc),2,32),Fserve) == $false) && ( %queuetimeout == $null )) { 
          queue.timeout
          /halt
        }
        else goto continue
        :continue        
        if ($tc($gettok($queue(%~queue-sc),2,32),Fserve) == $false) { queue.del %~queue-sc | unset %~queue-sc | goto queue }
        if (($r.set(Fserve,Max.Sends.Total) > $send(0)) && ($r.set(Fserve,Max.Sends.Each) > $send.nick($gettok($queue(%~queue-sc),2,32)))) { goto send }
      }
      goto start
      :send
      /unset %queuetimeout
      ;dcc send -l $+ %dcc.cap.cps % [ $+ [ $gettok($queue(%~queue-sc),2,32) ] ] " $+ $gettok($queue(%~queue-sc),3-,32) $+ " | queue.del %~queue-sc | unset %~queue-sc | goto queue
      dcc send -l $+ %dcc.cap.cps $gettok($queue(%~queue-sc),2,32) " $+ $gettok($queue(%~queue-sc),3-,32) $+ " | queue.del %~queue-sc | unset %~queue-sc | goto queue
    }
  }
}
queue.rep { if ($isnum($1) == $true) && ($queue(0) >= $1) && ($2 != $null) { set %Queue. [ $+ [ $1 ] ] $2- } }
qnu { if ($2 != $null) { set %~qnu 0 | :start | inc %~qnu 1 | if ($queue(%~qnu) == $null) { unset %~qnu | qmu } | else { if ($gettok($queue(%~qnu),2,32) == $1) { queue.rep %~qnu $gettok($queue(%~qnu),1,32) $2 $gettok($queue(%~qnu),3-,32) } | goto start } } }
check {
  if ($1 == Fserve) { if ($check.h(fserve) != $null) { error You didn't set any of the folllowing required items correctly to start the File Server. $bracket($left($check.h(Fserve),-5)) } }
}
check.h {
  elseif ($1 == Fserve) { return $iif($isnum($r.set(Fserve,Max.Sends.Total)) != $true,MaxSendsTotal) $iif($isnum($r.set(Fserve,Max.Sends.Each)) != $true,Max Sends Each & ) $+ $iif($isnum($r.set(Fserve,Max.Queues.Total)) != $true,MaxQueuesTotal) $iif($isnum($r.set(Fserve,Max.Queues.Each)) != $true,Max Queues Each & ) $+ $iif($r.set(Fserve,Note) == $null,Note & ) $+ $iif($fserve.ad.triggers.h == $null,Active Triggers & ) }
}
ad { advertise $1- }
advertise {
  if ($2 == Fserve) {
    if ($1 == Start) { 
      w.set Fserve Status On 
      if ($isnum($r.set(Fserve,Ad.Delay)) == $true) { 
        .timerFserve -o 0 $calc( [ $r.set(Fserve,Ad.Delay) ] * 60) fserve.ad
      } 
      fserve.ad
      if (($isnum($r.set(Min.CPS,Delay)) == $true) && ($r.set(Min.CPS,Status) == on)) { 
        .timerMin.CPS 0 $r.set(Min.CPS,Delay) Min.CPS
      }
    } 
    if ($1 == Stop) { w.set Fserve Status Off | .timerFserve Off }
    if ($1 == Silent) { if ($check.h(fserve) != $null) { check fserve } | else { w.set Fserve Status On } }
    if ($1 == Say) { if ($check.h(fserve) != $null) { check fserve } | else { w.set Fserve Status On | say $fserve.ad.temp } }
  }
  else { error Syntax: /advertise <start|stop|silent|say> fserve  }
}
fserve.ad { if (($server != $null) && ($r.set(Fserve,Status) == On)) { admsg $allchk($r.set(Fserve,Channels)) $strip($fserve.ad.temp) } }
fserve.start { 
  if ($2 != $null) { 
    if ($r.set(Fserve. [ $+ [ $2 ] ] ,Welcome.File) == None) || ($r.set(Fserve. [ $+ [ $2 ] ] ,Welcome.File) == $null) || ($isfile($r.set(Fserve. [ $+ [ $2 ] ] ,Welcome.File)) == $false) {
      fserve $1 99 $r.set(Fserve. [ $+ [ $2 ] ] ,Root.Dir)
    }
    else { 
      fserve $1 99 $r.set(Fserve. [ $+ [ $2 ] ] ,Root.Dir) $r.set(Fserve. [ $+ [ $2 ] ] ,Welcome.File)
    }
  }
}
fserve_grp {
  unset %~grp
  if ($istok($1-,1,32) == $true) { set %~grp %~grp $+ ,10,11,12,13,14,20,21,22,23,24,32,40,41,45,46,50,51,60,61,62,63,64 }
  if ($istok($1-,2,32) == $true) { set %~grp %~grp $+ ,70,71,72,75,76,77,78,80,81,82,572,573 }
  if ($istok($1-,3,32) == $true) { set %~grp %~grp $+ ,90,91,92,95,96,97,98,100,101,102,574,575 }
  if ($istok($1-,4,32) == $true) { set %~grp %~grp $+ ,110,111,112,115,116,117,118,120,121,122,576,577 }
  if ($istok($1-,5,32) == $true) { set %~grp %~grp $+ ,130,131,132,135,136,137,138,140,141,142,578,579 }
  if ($istok($1-,6,32) == $true) { set %~grp %~grp $+ ,150,151,152,155,156,157,158,160,161,162,580,581 }
  if ($istok($1-,7,32) == $true) { set %~grp %~grp $+ ,165,170,171,172,173,174,175,176,177,178,179,185,186,187,188,189,190 }
  set -u0 %~grp %~grp
  return $gettok(%~grp,1-,44)
}

oldsets {
  %old.sets = $$hfile="select settings.ini(polaris) or fserve.ini(shadow)" c:\*.ini
  %old.access = $readini %old.sets fserve access
  w.set fserve access %old.access
  %old.Send.Bytes = $readini %old.sets fserve Send.Bytes
  w.set fserve send.bytes %old.Send.Bytes
}
packit {
  set %add.delay 1200
  set %UpTime.Rec 0 
  set %connect 0
  set %stats.starts 0
  set %auto.voice off
  set %intro 0
  set %idle 0
  set %total.idle 0
  unset %botpass
  set %about.text 1
  set %nick.colours.o 12
  set %nick.colours.v 4
  set %nick.colours.m 8
  set %nick.colours.n 16
  set %nick.colours.h 0
  doit
}
cenwin return and now
umode dialog -m umode umode
mp3fileget { return $1 $+ *.mp3 }

about {
  return 5,1|1,5|4,5|5,4|7,4|4,7|8,7|7,8|0,8|8,0|4,0 %BCuser ShareScript $logo ©BlackCats-Games 2010 By Camaro350 8,0|0,8|7,8|8,7|4,7|7,4|5,4|4,5|1,5|5,1|9,1
}
tpauser {
  if ($1 != $null) {
    if ($1 == Admin) { /set %menu.admin on | /set %menu.user on | /set %tpauser Admin }
    elseif ($1 == User) { /set %menu.user on | /set %menu.admin off | /set %tpauser User }
    elseif ($1 == Newbies) { /set %menu.admin off | /set %menu.user off | /set %tpauser Newbies }
  }
  else echo -a 10 Syntax: /tpauser [Admin|User|Newbies] 
}

nero- {
  if ((%stats.starts != 1) && ($sets(misc,timestamp) == on)) { dialogs }
  if (0 isin %intro) about
  if (0 !isin %intro) {
    echo -si3 $logo 
    echo -si3 $logo 4,2 Welcome to BlackCats-Games (BC) on mIRC 
    echo -si3 $logo 
    echo -si3 $logo 4,2 You are using Version $logo $+ 
    echo -si3 $logo 4,2 Developed By Camaro350 (cam350@gmail.com)    
    echo -si3 $logo 4,2 You Have Started this script: $+ $b(%stats.starts) $b(Times) $+ 
    echo -si3 $logo 4,2 and you have connected: $+ $b(%connect) $b(Times) $+  
    echo -si3 $logo 4,2 Script url: http://blackcats-games.net 
    echo -si3 $logo 
    echo -si3 $logo 4,2 Thanks to the BC Crew and all active members   
    echo -si3 $logo 4,2 Special Thanks to Camaro350 for making this possible 
    echo -si3 $logo 4,2 Mod The Planet.. It's a life style!          
    echo -si3 $logo
    echo -si3 $logo
    /ShowKi



  }
}
nero-- {
  if $?!="use the launch strip(say yes :P)?" { dialogs } 
  if $?!="do you wish to save gigs served and accesses from your old script?" { oldsets }
}
b { 
  if (($1- == $null) || ($1- == $false)) { return  $+ $sets(viz,ADV.info) $+  $+ n/a $+  $+ $sets(viz,ADV.text) }
  else { return  $+ $sets(viz,ADV.info) $+  $+ $1- $+  $+ $sets(viz,ADV.text) }
}
bbb { 
  if (($1- == $null) || ($1- == $false)) { return  $+ $sets(viz,ADV.info) $+  $+ n/a $+  $+ $sets(viz,ADV.text) }
  else { return  $+ $sets(viz,ADV.text) $+  $+ $1- $+  $+  $+ $sets(viz,ADV.info) }
}

BL { return  $+ $sets(misc,barrackl) $+  }
BR { return  $+ $sets(misc,barrackr) $+  }
CTC unset %total.cps
ChanStats {
  if ($1 == echo) { 
    echo -a $logo(ChanStats) $cin2(Total:) $cin($nick(#,0))
    echo -a $logo(ChanStats) $cin2(Opped:) $cin($opnick(#,0,o)) $cin2(- $chr(40)) $+ $cin($left($calc(($opnick(#,0,o) * 100) / $nick(#,0)),4) $+ %)) $+ $cin2($chr(41))
    echo -a $logo(ChanStats) $cin2(HalfOpped:) $cin($hnick(#,0,h,o)) $cin2(- $chr(40)) $+ $cin($left($calc(($hnick(#,0,h,o) * 100) / $nick(#,0)),4) $+ %) $+ $cin2($chr(41))
    echo -a $logo(ChanStats) $cin2(Voiced:) $cin($vnick(#,0,v,ohr)) $cin2(- $chr(40)) $+ $cin($left($calc(($vnick(#,0,v,ohr) * 100) / $nick(#,0)),4) $+ %) $+ $cin2($chr(41))
    echo -a $logo(ChanStats) $cin2(Regular:) $cin($nick(#,0,r)) $cin2(- $chr(40)) $+ $cin($left($calc(($nick(#,0,r) * 100) / $nick(#,0)),4) $+ %) $+ $cin2($chr(41))
    echo -a $logo(ChanStats) $cin2(Modes:) $cin($iif($chan(#).mode == $null,N/A,$chan(#).mode))
  }
  if ($1 == message) { 
    msg # $logo(ChanStats) $cin2(Total:) $cin($nick(#,0))
    msg # $logo(ChanStats) $cin2(Opped:) $cin($opnick(#,0,o)) $cin2(- $chr(40)) $+ $cin($left($calc(($opnick(#,0,o) * 100) / $nick(#,0)),4) $+ %)) $+ $cin2($chr(41))
    msg # $logo(ChanStats) $cin2(HalfOpped:) $cin($hnick(#,0,h,o)) $cin2(- $chr(40)) $+ $cin($left($calc(($hnick(#,0,h,o) * 100) / $nick(#,0)),4) $+ %) $+ $cin2($chr(41))
    msg # $logo(ChanStats) $cin2(Voiced:) $cin($vnick(#,0,v,ohr)) $cin2(- $chr(40)) $+ $cin($left($calc(($vnick(#,0,v,ohr) * 100) / $nick(#,0)),4) $+ %) $+ $cin2($chr(41))
    msg # $logo(ChanStats) $cin2(Regular:) $cin($nick(#,0,r)) $cin2(- $chr(40)) $+ $cin($left($calc(($nick(#,0,r) * 100) / $nick(#,0)),4) $+ %) $+ $cin2($chr(41))
    msg # $logo(ChanStats) $cin2(Modes:) $cin($iif($chan(#).mode == $null,N/A,$chan(#).mode))
  }
}
f { return  $+ $sets(viz,ADV.text) $+ $1- }
;F1 use_triggerbrowser
F1 .f.ex 1
F2 qmanager
F3 fserve_config
F4 ftp_config
F5 tszftp.profiles
F6 tsz_option.umode
F7 tools1
F8 aws
F9 settings_config
F10 reader rules.txt
F11 reader version.txt
F12 kaloom
SF1 pager1
SF2 tsz_option.ncol
SF3 zmodem.ipc
;SF4 advflopro
;SF5 asx
SF6 portscanip
SF7 tsz_option.ncol
;SF12 intro
gzver { return $readini $ShortFn($mircdirsystem\settings.ini) misc ver }
kb ban # $1 3 | kick # $1 $2-
KB.ALL.CHANS { 
  %ChanCount = 0
  :start
  inc %ChanCount
  if (%ChanCount > $chan(0)) { goto end }
  if ($me isop $chan(%ChanCount)) { /mode $chan(%ChanCount) +b $1 3 | /kick $chan(%ChanCount) $1 $2- }
  goto start
  :end
  unset %ChanCount
}
KDur { return $replace($duration($1-),wks ,ws!,wk ,w!,days ,ds!,day ,d!,hrs ,hs!,hr ,h!,mins ,ms!,min ,m!,secs ,s's!,sec ,s!)) }
n {
  if ($1 == #) notice # $logo(notice) $2-
  else notice $1 $logo(NickNotice) $2-
}
osys { return Windoze $+ $os }
on2 { onotice $active 14,1-!!-Attention-!!-15,2 $1- 14,1 $me Has Spoken }
on onotice $active $b(@notice) $1-
progie { return $readini $ShortFn($mircdirsystem\settings.ini) progies $1 }
rejoin { 
  part $1 $2-
  .timerCy 1 2 join $1 
}
sets {
  if ($readini $ShortFN($mircdirsystem\settings.ini) $1 $2 == $null) { return NotSet }
  if ($readini $ShortFN($mircdirsystem\settings.ini) $1 $2 !== $null) { return $readini $mircdirsystem\settings.ini $1 $2 }
}
Show.Credits {
  echo -a $logo(Credits) $cin2(all the creds fly at:)
  echo -a $logo(Credits) $cin2(The BC - Blackcats-Games Team)

}
Show.FKeys {
  echo -a $Logo(FKeys) FKeys in This Version of $Logo
  echo -a $Logo(FKeys) | $+ $b(F1) $+ |: Triggerbrowser
  echo -a $Logo(FKeys) | $+ $b(F2) $+ |: Queue Manager
  echo -a $Logo(FKeys) | $+ $b(F3) $+ |: Fserve Config
  echo -a $Logo(FKeys) | $+ $b(F4) $+ |: FTP Config
  echo -a $Logo(FKeys) | $+ $b(F5) $+ |: TSZ Ftp
  echo -a $Logo(FKeys) | $+ $b(F6) $+ |: User Modes
  echo -a $Logo(FKeys) | $+ $b(F7) $+ |: Tools
  echo -a $Logo(FKeys) | $+ $b(F8) $+ |: Away System
  echo -a $Logo(FKeys) | $+ $b(F9) $+ |: Settings
  echo -a $Logo(FKeys) | $+ $b(F10) $+ |: Rules
  echo -a $Logo(FKeys) | $+ $b(F11) $+ |: Version History
  echo -a $Logo(FKeys) | $+ $b(F12) $+ |: About
  echo -a $Logo(FKeys) | $+ $b(shiftF1) $+ |: Pager
  echo -a $Logo(FKeys) | $+ $b(shiftF2) $+ |: Nick Colors
  echo -a $Logo(FKeys) | $+ $b(shiftF3) $+ |: IP 2 Nick
  ;echo -a $Logo(FKeys) | $+ $b(shiftF4) $+ |: Advanced Flood Protection
  ;echo -a $Logo(FKeys) | $+ $b(shiftF5) $+ |: Input Request
  echo -a $Logo(FKeys) | $+ $b(shiftF6) $+ |: Port Scan IP
  echo -a $Logo(FKeys) | $+ $b(shiftF7) $+ |: Nick Color
  ;echo -a $Logo(FKeys) | $+ $b(shiftF12) $+ |: Show Intro
}
SendLeft { return $duration($calc(($send($1).size - $send($1).sent) / $send($1).cps)) }
SortFile {
  if ($isdir($getdir $+ \ $+ $date(mm-dd-yy)) != $true) { .mkdir $getdir $+ $date(mm-dd-yy)  }
  .rename $1- $getdir $+ $date(mm-dd-yy) $+ \ $+ $nopath($1-)
}
Total.Space { return $size($calc($disk(c:).free + $disk(d:).free + $disk(e:).free + $disk(f:).free + $disk(g:).free + $disk(h:).free)) }
verrep return $read system\ver.txt
View.DownLoads {
  window @Downloads
  clear @DownLoads
  %count = 0
  echo -i3 @DownLoads  $+ $ADT $+ Files Found:| $+ $b($findfile($getdir,*,0)) $+ |
  :start
  inc %count
  if (%count > $findfile($getdir,*,0)) { goto end }
  echo -i3 @DownLoads  $+ $ADT $+ Name:| $b($findfile($getdir,*,%count)) | Size:| $+ $b($size($lof($findfile($getdir,*,%count)))) $+ | Time:| $+ $b($asctime($file($findfile($getdir,*,%count)).mtime)) $+ |
  goto start
  :end
  unset %count
}
CSet { writeini $ShortFN($mircdirsystem\settings.ini) $1 $2 $3- }
uCset { remini $ShortFN($mircdirsystem\settings.ini) $1 $2 }
ifin { 
  if ($1 isin $2) { return somth: }
  if ($1 isop $2) { return 2 }
  if ($1 isvo $2) { return 3 }
  if ($1 ishelp $2) { return 2 }
}
nada { }
ifme { if ($snick($active,1) == $me) { return $1- } }
ifop { if ($me isop $1) { return $2- } }
ifhalfop { if (($me ishelp $1) && ($me !isop $1)) { return $2- } }
;ifopfunc { if (($me isop $1) || ($me ishelp $1) || (%menu.admin == on)) { return $2- } }
ifopfunc { if ($me isop $1) { return $2- } }
ifadmin { if (%menu.admin == on) { return $1- } }
ifchan { if ($chan != $null) { return $1- } }
kicktext { return $read $mircdirsystem\text\kick.txt }
SiPSeek {
  .enable #ipseek 
  %host.chan = $1
  %host.found = 0
  %ipseek = $2
  who $1
  echo -a $logo(HostSeek) Now looking for hosts muchs $b(%ipseek) on $b($1)
}
op mode # +ooo $1 $2 $3
dop mode # -ooo $1 $2 $3
j join #$1 $2-
p part #
w whois $1
k kick # $1
q query $1
send dcc send %len $2
chat dcc chat $1
ping ctcp $1 ping


bd {
  drawrect -rnf $2 $rgb(face) 1 $3-6
  drawtext -rn $2 $rgb(text) "MS Sans Serif" 13 $calc($3 + ($5 - $width($7-,"MS Sans Serif",13,0,0)) / 2 + $iif($1 = -i,2,1)) $calc($4 + ($6 - 10) / 2 - $iif($1 = -i,0,1)) $7-
  if ($remove($1,-) isin nh) { 3d -rn $2 $rgb(face) $rgb(frame) $3-6 | 3d -rn $2 $rgb(hilight) $rgb(shadow) $add($3,1) $add($4,1) $sub($5,2) $sub($6,2) }
  else drawrect -rn $2 $rgb(shadow) 1 $3-6 | if ($remove($1,-) isin in) drawrect -rn $2 $rgb($iif($1 = -i,frame,face)) 1 $sub($3,1) $sub($4,1) $add($5,2) $add($6,2)
}
3d drawrect $1-2 $4 1 $5- | drawline $1-3 1 $5 $calc($6 + $8 - 1) $5-6 $calc($5 + $7) $6
mwin return $int($calc(( [ $window(-3).w ] - $1) / 2)) $int($calc(( [ $window(-3).h ] - $2) / 2))
window var %.2desktop = $wildtok($1-,@*,1,32) | if ((-* iswm $1) && ($istok($i(windows,desktop),%.2desktop,44))) window $1 $+ d $2- | else window $1-
inr tokenize 32 $1- | if ($inrect($mouse.x,$mouse.y,$1,$2,$3,$4)) return $1-4
mult return $calc($1 * $2)
sub return $calc($1 - $2)
add return $calc($1 + $2)
wi whois $$1
AwayTime { return $duration($int($calc(($ticks - %away.ticks) / 1000))) }
awaynick {
  if ($sets(away,nick) == NotSet) { return $me $+ -X }
  else { return $sets(away,nick) }
}
List.Pages {
  did -r pager 3
  %count = 0
  :start
  inc %count
  if ((%count > $total.pages) || ($total.pages == $null)) { goto end }
  did -a pager 3 Page. $+ %count
  goto start
  :end
  unset %count
}
Rem.Page {
  %count = $1
  %count1 = $1
  :start
  inc %count1
  if (%count1 > $total.pages) { goto end }
  writeini $shortfn($mircdirsystem\pages.ini) page. $+ %count Sender $Page.sender(%count1)
  writeini $shortfn($mircdirsystem\pages.ini) page. $+ %count date $Page.date(%count1)
  writeini $shortfn($mircdirsystem\pages.ini) page. $+ %count time $Page.time(%count1)
  writeini $shortfn($mircdirsystem\pages.ini) page. $+ %count msg $Page.msg(%count1)
  remini $shortfn($mircdirsystem\pages.ini) page. $+ %count1
  inc %count
  goto start
  :end
  unset %count
  unset %count1
  writeini $shortfn($mircdirsystem\pages.ini) pages total $calc($Total.Pages - 1)
  list.pages
}
if.pager.on { if ($sets(away,pager) == on) { return - Pager:| $+ $b(/Ctcp) $b($me) $b(Page <Message>) $+ | } }
Page.Sender { return $readini $shortfn($mircdirsystem\pages.ini) page. $+ $1 Sender }
Page.Date { return $readini $shortfn($mircdirsystem\pages.ini) page. $+ $1 Date }
Page.Time { return $readini $shortfn($mircdirsystem\pages.ini) page. $+ $1 Time }
Page.Msg { return $readini $shortfn($mircdirsystem\pages.ini) page. $+ $1 Msg }
Total.Pages { 
  if ($readini $shortfn($mircdirsystem\pages.ini) pages total != $null) { return $readini $shortfn($mircdirsystem\pages.ini) pages total } 
  else { return 0 } 
}
Show.Page {
  did -r Pager 5
  did -r Pager 7
  did -r Pager 9
  did -r Pager 2
  did -a Pager 5 $Page.Sender($did(pager,3).sel)
  did -a Pager 7 $Page.Date($did(pager,3).sel)
  did -a Pager 9 $Page.Time($did(pager,3).sel)
  did -a Pager 2 $Page.Msg($did(pager,3).sel)
}
Load.Away.Dialog { 
  %away.nick = $sets(away,nick) 
  %away.indday = $calc($sets(away,ind) / 60) 
  %away.sdday = $calc($sets(away,sd) / 60) 
  %away.icq = $sets(away,icq)
  %away.email = $sets(away,email)
  %away.delay = $sets(away,delay) / 60
  dialog -m away away
  unset %away.delay 
  unset %away.nick
  unset %away.indday
  unset %away.sdday
  unset %away.icq
  unset %away.email
}
Load.Away.Settings {
  if ($sets(away,inactive) == on) {
    did -c away 6 
  }
  else { did -h away 7 | did -h away 8 }  
  if ($sets(away,start) == on) {
    did -c away 9  
  }
  else { did -h away 10 | did -h away 11 } 
  if ($sets(away,pager) == on) { did -c away 4 }
  if ($sets(away,-o+v) == on) { did -c away 66 }
}
startcommands {
  if (($sets(away,inactive) == on) || ($sets(away,start) == on)) { 
    checkaway 
  }
}
checkaway {
  if ($sets(away,start) == on) {
    inc %away.st
    if (%away.st >= $sets(away,sd)) { 
      GoAway Auto away after %duration(%away.st) Mins 
    }
  }
  if ($sets(away,inactive) == on) { 
    inc %away.ind
    if (%away.ind == $sets(away,ind)) { 
      GoAway Auto away after $duration(%away.ind) Mins 
    } 
  }
}

BW-Getz {
  if ($Get(0) > 0) {
    %count = 0
    %total.cps = 0
    :start
    inc %count
    if (%count > $Get(0)) { goto end }
    if ($Get(%count).cps !== n/a) { 
      inc %total.cps $Get(%count).cps
      goto start
      :end
      unset %count
      return $ks(%total.cps)
      CTC
    } 
  }
  else { return 0 }
}
CTC unset %total.cps
BW {
  if ($send(0) > 0) {
    %count = 0
    %total.cps = 0
    :start
    inc %count
    if (%count > $send(0)) { goto end }
    if ($send(%count).cps != n/a) { 
      inc %total.cps $send(%count).cps
      if ($send(%count).cps > %dcc.rec.cps) { /set %dcc.rec.cps $send(%count).cps }
      goto start
      :end
      unset %count
      return $ks(%total.cps)
      CTC
    } 
  }
  else { return 0 }
}
ks { 
  if ($1 !isnum) { return $1 | halt }
  return $left($calc($1 / 1024),4) $+ Kb/s 
}
SUK { return $readini $mircdirsystem\suk.ini $2 $1 }
Shut.Up.Kick {
  kick $1 $2  $logo(Kick) i told you shut up!
  Rem.suk $1 $2
}
Add.SUK { writeini $mircdirsystem\suk.ini $1 $2 on | msg $1 $logo(Kick) $2 has been added to $b(Shut Up Kick!) }
Rem.SUK { remini $mircdirsystem\suk.ini $1 $2 }
ShowKi {
  echo -ai3 $logo Sent: $b($size($vnum($r.set(Fserve,Send.Bytes),0))) $+ ,. in $b($vnum($r.set(Fserve,Send.Total),0)) Files
  echo -ai3 $logo Fserv Accessed: $b($vnum($r.set(Fserve,Access),0)) Times
  echo -ai3 $logo Version : $b($gzver)
  echo -ai3 $logo Nick: $b($me) E-Mail: $b($email) 
  echo -ai3 $logo Loaded Remotes: $b($script(0)) Aliases Loaded: $b($alias(0))
  echo -ai3 $logo Ignore(s): $b($ignore(0)) Nofity(s): $b($notify(0)) 
  echo -ai3 $logo Up Time: Current:| $+ $b($duration($calc($ticks / 1000))) $+ | - Record:| $+ $b($duration(%UpTime.Rec)) $+ |
  echo -ai3 $logo OS:| $+ $b($osys) $+ |
  echo -ai3 $logo Time:| $+ $b($time) $+ | - On:| $+ $b($date) $+ |
  unset %zone
}
Lag.Check {
  %lag = 0
  %chan = $1 
  %ticks = $ticks
  .enable #lag.check
}
lag.ad {
  echo -ai3 $logo(Lag) Server:| $+ $b($server) $+ | - Port:| $+ $b($port)) $+ | - LagTime:| $+ $b($calc(%lag / 1000)) $b(Secs) $+ |
  unset %lag
  unset %ticks
  unset %chan
}
StartUSearch {
  .enable #UserSearch
  dns $$?="Enter Hostname, Nickname Or iP address"
  .disable #ShowDNS
}
Show.Clone {
  %count = 0
  echo -a $logo(CloneSeek) Now Listing $b(%clone) found on $b(%clone.chan)
  :start
  inc %count
  if (%count > %clone) { goto end }
  echo -a $logo(CloneSeek) | $+ $b(%count) $+ |: $b($CN(%count,1)) and $b($CN(%count,2)) | $+ $B($CA(%count)) $+ |
  goto start
  :end
  unset %count
  unset %clone
  unset %clone.chan
  .remove $shortfn($mircdirsystem\clones.ini)
}
Clone.Check.Start {
  .Enable #clonecheck
  %clone.chan = $1
  %clone = 0
  who $1
}
CN { return $readini $shortfn($mircdirsystem\clones.ini) clone $+ $1 nick $+ $2 }
CA { return $readini $shortfn($mircdirsystem\clones.ini) clone $+ $1 ad } 
dyn.nicklist {
  if ($1 = current.isopped) && ($snick($active,1) isop $active) { return -o $snick($active,1) }
  elseif ($1 = current.is.notopped) && ($snick($active,1) !isop $active) { return +o $snick($active,1) }
  elseif ($1 = current.is.halfopped) && ($snick($active,1) ishelp $active) { return -h $snick($active,1) }
  elseif ($1 = current.is.nothalfopped) && ($snick($active,1) !ishelp $active) { return +h $snick($active,1) }
  elseif ($1 = current.is.voiced) && ($snick($active,1) isvo $active) { return -v $snick($active,1) }
  elseif ($1 = current.is.notvoiced) && ($snick($active,1) !isvo $active) { return +v $snick($active,1) }
}
SetBarr {
  if ($1 == 279) {
    did -u settings 280
    did -u settings 287
    did -c settings 279
    CSet misc barrackl $chr(58)
    CSet misc barrackr $chr(58)
  }
  if ($1 == 280) {
    did -u settings 279
    did -u settings 287
    did -c settings 280
    CSet misc barrackl $chr(40)
    CSet misc barrackr $chr(41)
  }
  if ($1 == 287) {
    did -u settings 280
    did -u settings 279
    did -c settings 287
    CSet misc barrackl $chr(91)
    CSet misc barrackr $chr(93)
  }
}
ReCheckBox {
  ; $1 = Dialog name $2 = iD Number $3 = Set Fam (eg: Misc) $4 = Set Parameter (Eg: AWhois) 
  if ($did($1,$2).state == 1) { 
    CSet $3 $4 on 
    if ($4 = notify) { .notify on }
  } 
  else { 
    CSet $3 $4 Off 
    if ($4 = notify) { .notify off }
  } 
}
RCC {
  ; $1 = dialog name $2 = UnCheck Radio $3 = Check Radio
  did -u $1 $2
  did -c $1 $3
}
SetOO {
  ; this is to set somthing On or Off
  ; $1 = ground name (eg: misc) $2 = sets name (eg: autojoin[x] $3 = Status , on or off 
  CSet $1 $2 $3
}
SetChan {
  if ($did(settings,$1) == $null) { CSet misc autojoin $+ $2 NotSet }
  else { CSet misc autojoin $+ $2 $did(settings,$1) }
}
AddNotify {
  if ($$?!="Would You Like to Add A Note For This User ?" == $true) { %note = $$?="Enter Note(s)" }
  .notify $1 %note
  if (%note != $null) { echo -a $logo(Notify) User $b($1) has been added to notify list with the note $b(%note) }
  else { echo -a $logo(Notify) User $b($1) has been added to notify list with the note $b(%note) } 
  unset %note
}
zone {
  if ($calc($timezone / -3600) > 0) { return + $+ $calc($timezone / -3600) $+ :00 GMT }
  if ($calc($timezone / -3600) < 0) { return $calc($timezone / -3600) $+ :00 GMT }
}
Bandwidth {
  if (($send(0) == 0) && ($get(0) == 0)) { return 0 | halt }
  if (($send(0) > 0) && ($get(0) = 0)) { return Sending: $+ $ks($BW) | halt  }
  if (($send(0) = 0) && ($get(0) > 0)) { return Getting: $+ $ks($bw-getz) | halt }
  else return Sending: $+ $ks($BW) Getting: $+ $ks($bw-getz) 
}

ifDir {
  %countls = 0
  %Dir = 1
  :start
  inc %countls
  if (%countls == $len($1-)) { goto end }
  if ($asc($mid($1-,%countls,1)) !== $asc($upper($mid($1-,%countls,1)))) { %Dir = No | goto end }
  goto start
  :end
  unset %countls
  if (%dir isnum) { return $true } 
}
OnlySize {
  %count = $len($1-)
  :start
  dec %count
  if (%count < 0) { goto end }
  if ($mid($1-,%count,1) == $chr(32)) { return $right($1-,$calc($len($1-) - %count)) | unset %count | goto end }
  goto start
  :end
  unset %count
}

OnlyFile {
  %count = $len($1-)
  :start
  dec %count
  if (%count < 0) { goto end }
  if ($mid($1-,%count,1) == $chr(32)) { return $left($1-,%count) | unset %count | goto end }
  goto start
  :end
  unset %count
}
ascii { return $replace($upper($1-),AE,Æ,A,å,B,ß,C,Ç,D,Ð,E,Ë,f,f,G,g,H,H,I,î,J,J,K,k,L,|,M,m,N,ñ,O,ö,P,þ,Q,¶,R,®,S,§,T,t,U,ü,V,V,W,w,X,×,Y,¥,Z,z,1,¹,2,²,3,³) }
rel { return BlackCats-MIRC v1.6.6 Clean }
Logo {
  if ($1- !== $Null) { return  $+ $sets(viz,ADV.text) $+ ×| $+ $b(BC) $+ $b(|) $+  $+ $b($1-) $+ |× }
  if ($1- == $Null) { return  $+ $sets(viz,adv.text) $+ ×| $+ $b( $rel ) $+ |× }
}
cool { 
  if ($?!"do you want to edit ×|TpA|Fserv|×" == $true) set %f.1 $$?="replace the word Fserv with?"
  else set %f.1 Fserve
  if ($?!"do you want to edit Snagged" == $true) set %f.3 $$?="replace the word Snagged with?"
  else set %f.3 Snagged
  if ($?!"do you want to edit Files" == $true) set %f.4 $$?="replace the word files with?"
  else set %f.4 file
  if ($?!"do you want to edit Min" == $true) set %f.5 $$?="replace the word Min with?"
  else set %f.5 Min
  if ($?!"do you want to edit Record" == $true) set %f.6 $$?="replace the word Record with?"
  else set %f.6 Record
  if ($?!"do you want to edit Online" == $true) set %f.7 $$?="replace the word Online with?"
  else set %f.7 Online
  if ($?!"do you want to edit Sends" == $true) set %f.8 $$?="replace the word Sends with?"
  else set %f.8 Sends
  if ($?!"do you want to edit Queues" == $true) set %f.9 $$?="replace the word Queues with?"
  else set %f.9 Queues
  if ($?!"do you want to edit Accessed" == $true) set %f.10 $$?="replace the word Accessed with?"
  else set %f.10 Accessed
  if ($?!"do you want to edit Note" == $true) set %f.11 $$?="replace the word Note with?"
  else set %f.11 Note
  if ($?!"do you want to edit Max" == $true) set %f.12 $$?="replace the word Max with?"
  else set %f.12 Max
  if ($?!"do you want to edit Current" == $true) set %f.13 $$?="replace the word Current with?"
  else set %f.13 Current
}
;fserve.ad.temp { if ($fserve.ad.triggers.h != $null) { return $logo(%f.1) $fserve.ad.triggers $fserve.ad.snagged $fserve.ad.min.cps $fserve.ad.record.cps $cpues $cca $fserve.ad.on $fserve.ad.sends $fserve.ad.queues $fserve.ad.access $fserve.ad.note } }
fserve.ad.temp { if ($fserve.ad.triggers.h != $null) { return $logo(%f.1) $fserve.ad.triggers $fserve.ad.snagged $fserve.ad.min.cps $fserve.ad.record.cps $cpues $cca $fserve.ad.on $fserve.ad.sends $fserve.ad.queues $fserve.ad.access $fserve.ad.note } }
;fserve.ad.temp2 { return $logo(%f.1) $fserve.ad.snagged $fserve.ad.min.cps $fserve.ad.record.cps $cpues $cca $fserve.ad.on $fserve.ad.sends $fserve.ad.queues $fserve.ad.access $fserve.ad.note }
;DONT CHANGE THE WORD TRIGGER FOR AUTO VOICE AND TRIGGER BROWSER
;DONT CHANGE THE WORD TRIGGER FOR AUTO VOICE AND TRIGGER BROWSER
;DONT CHANGE THE WORD TRIGGER FOR AUTO VOICE AND TRIGGER BROWSER
fserve.ad.triggers { return Trigger $+ : [ $b($fserve.ad.triggers.h) ] }
;DONT CHANGE THE WORD TRIGGER FOR AUTO VOICE AND TRIGGER BROWSER
;DONT CHANGE THE WORD TRIGGER FOR AUTO VOICE AND TRIGGER BROWSER
;DONT CHANGE THE WORD TRIGGER FOR AUTO VOICE AND TRIGGER BROWSER
fserve.ad.triggers.h { 
  set %fuck $bbb(and))
  return $iif($r.set(Fserve.1,Status) == On,$t.set(Fserve.1,Trigger)) $iif($r.set(Fserve.2,Status) == On,%fuck $t.set(Fserve.2,Trigger)) $iif($r.set(Fserve.3,Status) == On,%fuck $t.set(Fserve.3,Trigger)) $iif($r.set(Fserve.4,Status) == On,%fuck $t.set(Fserve.4,Trigger)) $iif($r.set(Fserve.5,Status) == On,%fuck $t.set(Fserve.5,Trigger)) $iif($r.set(Fserve.6,Status) == On,%fuck $t.set(Fserve.6,Trigger)) $iif($r.set(Fserve.7,Status) == On,%fuck $t.set(Fserve.7,Trigger)) $iif($r.set(Fserve.8,Status) == On,%fuck $t.set(Fserve.8,Trigger)) $iif($r.set(Fserve.9,Status) == On,%fuck $t.set(Fserve.9,Trigger)) $iif($r.set(Fserve.10,Status) == On,%fuck $t.set(Fserve.10,Trigger))
}
fserve.ad.snagged { return $svs(%f.3, [ [ $size($vnum($r.set(Fserve,Send.Bytes),0)) / $vnum($r.set(Fserve,Send.Total),0) %f.4 ] ] [ $+ [ $iif($vnum($r.set(Fserve,Send.Total),0) != 1,s) ] ] ) }
fserve.ad.min.cps { if ($r.set(Min.CPS,Rate) isnum) && ($isnum($r.set(Min.CPS,Delay)) == $true) && ($r.set(Min.CPS,Status) == On) { return $svs(%f.5, [ [ $size($vnum($r.set(Min.CPS,Rate),0)) $+ /s ] ] ) } }
fserve.ad.record.cps { return $svs(%f.6, [ [ $size($vnum($gettok($r.set(Fserve,Record.CPS),1,32),0)) $+ /s by $isset($gettok($r.set(Fserve,Record.CPS),2,32)) ] ] ) }
fserve.ad.on { return $svs(%f.7, [ [ $fserv(0) ] $+ ] / [ $+ [ $vnum($r.set(Fserve,Max.Serve),0) ] ] ) }
fserve.ad.sends { return $svs(%f.8, [ [ $send(0) ] $+ ] / [ $+ [ $vnum($r.set(Fserve,Max.Sends.Total),0) ] ] ) }
fserve.ad.queues { return $svs(%f.9, [ [ $queue(0) ] $+ ] / [ $+ [ $vnum($r.set(Fserve,Max.Queues.Total),0) ] ] ) }
fserve.ad.access { return $svs(%f.10, [ [ $vnum($r.set(Fserve,Access),0) times ] ] ) }
fserve.ad.note { return $svs(%f.11,$isset($left($r.set(Fserve,Note),75))) }
LoadError { %error = $1- | dialog -m error error }
CCa { if (%dcc.cap.cps isnum) { return %f.12 $+ : $+ $b($ks(%dcc.cap.cps)) } }
;CPUes { if ($BW != 0) { return %f.13 $+ : $+ $b($bw) } }
CPUes { return %f.13 $+ : $+ $b($bw) }
123-seeya {
  if (($1 isreg $2) && (%reg.badwords.kick == on)) {
    if (($SUK($1,$2) == on) && ($me isop $2)) { Shut.Up.Kick $2 $1 }
    if (trade isin $strip($3-)) {
      if (%reg.badwords.ban == on) ban -u3 $2 $1 3
      kick $2 $1 $logo(no trading)
    }
    if (($chr(35) isin $strip($3-)) && (join isin $strip($3-)) && (TpA !isin $strip($3-))) {
      if (%reg.badwords.ban == on) ban -u3 $2 $1 3
      kick $2 $1 $logo(dont advertise other channels in here)
    }
    if (($left($3-,1) == !) && ($left($3-,2))) {
      if (%reg.badwords.ban == on) ban -u3 $2 $1 3
      kick $2 $1 $logo(no !triggers)    
    }
  }
}
UpTime {
  if (%UpTime.Rec == $null) %UpTime.Rec = 0
  if ($calc($ticks / 1000) > %UpTime.Rec) { %UpTime.Rec = $calc($ticks / 1000) }
  return Current:| $+ $b($duration($calc($ticks / 1000))) $+ | - Record:| $+ $b($duration(%UpTime.Rec)) $+ | - OS:| $+ $b($osys) $+ |
} 
ComeBack {
  if ($total.pages > 0) echo -a3| $logo(pager) $total.pages received while away. (F2 to check pages)
  .away
  unset %away
  .timerWAdv off
  .timerAT off
  .nick %tnick
  unset %tnick
  unset %count 
  amsg $logo(back) I Was Away:| $+ $b(%away.re) $+ | - Duration:| $+ $b($AwayTime) $+ |
  unset %away.*
}
icqad { if ($sets(away,icq) != NotSet) { return - iCQ:| $+ $b($sets(away,icq)) $+ | } }
emlad { if ($sets(away,email) != NotSet) { return - E-Mail:| $+ $b($sets(away,email)) $+ | } }
AwayADV { amsg $logo(Away) i am away:| $+ $b(%away.re) $+ | - duration:| $+ $b($away.time) $+ | $if.pager.on $icqad $emlad }
GoAway {
  .away $1-
  if ($sets(away,-o+v) == on) {
    %count = 0
    :start
    inc %count
    if (%count > $chan(0)) { goto end }
    if ($me isop $chan(%count)) { .mode $chan(%count) +v-o $me $me } 
    goto start
    :end
    unset %count
  }
  unset %away.*
  %away = on
  %away.re = $1-
  %away.ticks = $ticks
  amsg $logo(Away) Reason:| $+ $b(%away.re) $+ |
  %tnick = $me
  .nick $awaynick
}
title.update {
  if ($chr(35) isin $active) { set %.active.c $active }
  ;  .titlebar $logo($me) -=- %.active.c -=- T: $+ $nick($active,0) +o: $+ $opnick($active,0,o) +h: $+ $hnick($active,0,h,o) +v: $+ $vnick($active,0,v,ohr) reg: $+ $rnick($active,0,r) -=- $time -=- $bandwidth -=- $server -=-
  .titlebar $me -=- %.active.c -=- T: $+ $nick($active,0) +o: $+ $opnick($active,0,o) +h: $+ $hnick($active,0,h,o) +v: $+ $vnick($active,0,v,ohr) reg: $+ $rnick($active,0,r) -=- $time -=- $bandwidth -=- $server -=-
}


packit {
  set %add.delay 1200
  set %UpTime.Rec 0 
  set %connect 0
  set %stats.starts 0
  set %auto.voice off
  set %intro 0
  set %idle 0
  set %total.idle 0
  unset %botpass
  set %about.text 1
  set %nick.colours.o 12
  set %nick.colours.v 4
  set %nick.colours.m 8
  set %nick.colours.n 16
  set %nick.colours.h 0
  doit
}
;RandomDelayVoiceServer { if ($1 isreg $2) mode $2 +v $1 }
/memsentence {
  dialog -m sentc sentc
  if ( %sentence1 == $null ) { did -ci sentc 3 1 Type your sentence here }
  if ( %sentence2 == $null ) { did -ci sentc 5 1 Type your sentence here }
  if ( %sentence3 == $null ) { did -ci sentc 7 1 Type your sentence here }
  if ( %sentence4 == $null ) { did -ci sentc 9 1 Type your sentence here }
  if ( %sentence5 == $null ) { did -ci sentc 11 1 Type your sentence here }
  if ( %sentence6 == $null ) { did -ci sentc 13 1 Type your sentence here }
  if ( %sentence7 == $null ) { did -ci sentc 15 1 Type your sentence here }
  if ( %sentence8 == $null ) { did -ci sentc 17 1 Type your sentence here }
  if ( %sentence9 == $null ) { did -ci sentc 19 1 Type your sentence here }
  if ( %sentence10 == $null ) { did -ci sentc 21 1 Type your sentence here }
  if ( %sentence1 != $null )  { did -ci sentc 3 1 %sentence1 }
  if ( %sentence2 != $null )  { did -ci sentc 5 1 %sentence2 }
  if ( %sentence3 != $null )  { did -ci sentc 7 1 %sentence3 }
  if ( %sentence4 != $null )  { did -ci sentc 9 1 %sentence4 }
  if ( %sentence5 != $null )  { did -ci sentc 11 1 %sentence5 }
  if ( %sentence6 != $null )  { did -ci sentc 13 1 %sentence6 }
  if ( %sentence7 != $null )  { did -ci sentc 15 1 %sentence7 }
  if ( %sentence8 != $null )  { did -ci sentc 17 1 %sentence8 }
  if ( %sentence9 != $null )  { did -ci sentc 19 1 %sentence9 }
  if ( %sentence10 != $null )  { did -ci sentc 21 1 %sentence10 }
  did -t sentc 80 1
}
/sentence1 {
  if ( %sentence1 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence1 != $null ) { /say %sentence1 }
}
/sentence2 {
  if ( %sentence2 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence2 != $null ) { /say %sentence2 }
}
/sentence3 {
  if ( %sentence3 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence3 != $null ) { /say %sentence3 }
}
/sentence4 {
  if ( %sentence4 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence4 != $null ) { /say %sentence4 }
}
/sentence5 {
  if ( %sentence5 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence5 != $null ) { /say %sentence5 }
}
/sentence6 {
  if ( %sentence6 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence6 != $null ) { /say %sentence6 }
}
/sentence7 {
  if ( %sentence7 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence7 != $null ) { /say %sentence7 }
}
/sentence8 {
  if ( %sentence8 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence8 != $null ) { /say %sentence8 }
}
/sentence9 {
  if ( %sentence9 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence9 != $null ) { /say %sentence9 }
}
/sentence10 {
  if ( %sentence10 == $null ) { /echo 3 %echomsg2 }
  if ( %sentence10 != $null ) { /say %sentence10 }
}
/calc /set %mbs $round($calc($calc($file(%drop.file1).size /1024)/1024),2) mb | /inc %sentmbs %mbs

fchan {
  join $$1 $+ $chr(160) $+ @ $+ $$2
}

c2rgb {
  if $1 == 0 { return $rgb(255,255,255) }
  elseif $1 == 1 { return $rgb(0,0,0) }
  elseif $1 == 2 { return $rgb(0,0,127) }
  elseif $1 == 3 { return $rgb(0,147,0) }
  elseif $1 == 4 { return $rgb(255,0,0) }
  elseif $1 == 5 { return $rgb(127,0,0) }
  elseif $1 == 6 { return $rgb(156,0,156) }
  elseif $1 == 7 { return $rgb(252,127,0) }
  elseif $1 == 8 { return $rgb(255,255,0) }
  elseif $1 == 9 { return $rgb(0,252,0) }
  elseif $1 == 10 { return $rgb(0,147,147) }
  elseif $1 == 11 { return $rgb(0,255,255) }
  elseif $1 == 12 { return $rgb(0,0,252) }
  elseif $1 == 13 { return $rgb(255,0,255) }
  elseif $1 == 14 { return $rgb(127,127,127) }
  elseif $1 == 15 { return $rgb(210,210,210) }
  else { return $rgb(0,0,0) }
}

hdd { return $iif($disk($1).type == fixed,( $+ $1 $round($calc($disk($1).free / 1073741824),2) $+ GB Free $+ $chr(41) $+ $chr(32)),$null) }

ictime {
  me $logo(Time) $cin(its:) $cin2($time) $cin(Day:) $cin2($date(dddd)) $cin(Date:) $cin2($date(mmmm) $+ , $date(dd) $date(yyyy)) $cin(GMT:) $cin2($calc(($timezone / -3600) + ($daylight / 3600)))
  unset %zone
}
ictimeself {
  echo $logo(Time) $cin(its:) $cin2($time) $cin(Day:) $cin2($date(dddd)) $cin(Date:) $cin2($date(mmmm) $+ , $date(dd) $date(yyyy)) $cin(GMT:) $cin2($calc(($timezone / -3600) + ($daylight / 3600)))
  unset %zone
}

iuptime { me $logo(Uptime) $cin2($uptime(system,1)) }
iuptimeself { echo $logo(Uptime) $cin2($uptime(system,1)) }

ni { me $logo(Network Interfaces) $cin2($dll(moo.dll,interfaceinfo,_)) }
niself { echo $logo(Network Interfaces) $cin2($dll(moo.dll,interfaceinfo,_)) }


mbmself {
  getmbm5info
  echo -a $logo 2mbm5info[ $+ $result $+ ]
}

settings {
  if $1 != $null { return $mircdirSystem\Settings\ $+ $1 }
  else { return $mircdirSystem\Settings\ }
}

mdxinit {
  dll " $+ $mircdir $+ mdx.dll $+ " SetMircVersion $version
  dll " $+ $mircdir $+ mdx.dll  $+ " MarkDialog $dname
}

mdx {
  var %dll = $mircdir $+ mdx.dll
  return $dll(%dll,$1,$2-)
}

mdx.page {
  var %dname, %did
  if ($0 = 1) {
    set %dname $dname
    set %did $1
  }
  else {
    set %dname $1
    set %did $2
  }
  did -i %dname %did 1 page $prop
  return $gettok($did(%dname, %did, 1), 3-, 32)
}



settopichistory {
  if $1- != $null {
    var %topic = $null
    if $chan($1-) != $null {
      if $chan($1-).topic != $null { %topic = $1- $chan($1-).topic   $+ (Unknown) }
    }
    else {
      %topic = $1-
    }

    if %topic != $null {
      if $lines($mircdirSystem\settings\topichistory.txt) == 0 {
        /write -a $mircdirSystem\settings\topichistory.txt %topic
      }
      else {
        var %i = $lines($mircdirSystem\settings\topichistory.txt)
        var %found = $false
        while %i >= 1 {
          if $gettok($read($mircdirSystem\settings\topichistory.txt,%i),1,32) == $1 {
            %found = $true
            if $gettok($read($mircdirSystem\settings\topichistory.txt,%i),1- $+ $calc($numtok($read($mircdirSystem\settings\topichistory.txt,%i),32) - 1),32) != $gettok(%topic,1- $+ $calc($numtok(%topic,32) - 1),32) {
              /write -a $mircdirSystem\settings\topichistory.txt %topic
            }
            %i = 0
          }
          dec %i
        }
        if %found == $false { /write -a $mircdirSystem\settings\topichistory.txt %topic }
      }
    }
  }
}

outputtopichistory {
  /var %i = 0
  if ($window(@Topic_history) == $null) { window -s @Topic_history 0 0 640 200 }
  else { /clear @Topic_history | /window -a @Topic_history }
  while (%i <= $lines($mircdirSystem\settings\topichistory.txt)) {
    inc %i
    if $gettok($read($mircdirSystem\settings\topichistory.txt,nl,%i),1,32) == $1- { 
      echo @topic_history $read($mircdirSystem\settings\topichistory.txt,nl,%i)
    }
  }
}

cleartopichistory {
  var %i = 1
  while %i <= $lines($mircdirSystem\settings\topichistory.txt) {
    if $gettok($read($mircdirSystem\settings\topichistory.txt,%i),1,32) == $1 {
      /write -dl $+ %i $mircdirSystem\settings\topichistory.txt
      dec %i
    }
    inc %i
  }
}

comchans {
  var %tmp = $comchan($1,1)
  var %i = 2
  while %i <= $comchan($1,0) {
    %tmp = %tmp $+ , $comchan($1,%i)
    inc %i
  }

  return %tmp
}

AddtoChanFolder {
  if ($isChannel($1)) {
    var %loc = n $+ $ini($shortfn($mircini),chanfolder,0)
    var %entry = $1, $+ $iif($2- != $null,$chr(34) $+ $2- $chr(34),$chr(34) $+ Added from Invision Menu $+ $chr(34)) $+ ,, $+ $iNetwork $+ ,1 
    w.mirc chanfolder %loc %entry
    echo $1 was added to the Channels Folder to Auto-Join on connect. 
  }
}
w.mirc { if ($3 != $null) { writeini -n $shortfn($mircini) $1 $2 $strip($3-,burc) } }
isChannel { if $left($1,1) == $chr(35) || $left($1,1) == $chr(38) || $left($1,1) == $chr(43) { return $true } | else { return $false } }

cmdexe {
  if ($istok(95 98 ME,$os,32)) { return command }
  else { return cmd }
}

tracert { run $cmdexe /K tracert $$gettok($1-,1,58) }

fsi {
  me $logo(Fserv Info for user $me) 
  me $logo(Fserv Status) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Status))
  me $logo(Accessed) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Access) times)
  me $logo(Max Sends) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Max.Sends.Total))
  me $logo(Max Queues) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Max.Queues.Total))
  me $logo(Transfer Record) $cin2($round($calc($gettok($readini($mircdirSystem\Fserve.ini,np,Fserve,Record.CPS),1,32)/1000),2) kb/s by $gettok($readini($mircdirSystem\Fserve.ini,np,Fserve,Record.CPS),2,32))
  me $logo(Last reset of sent) $cin2($asctime($r.set(fserve,send.lastreset)))
  me $logo(Sent) $cin2($size($readini($mircdirSystem\Fserve.ini,np,Fserve,Send.Bytes)) in $readini($mircdirSystem\Fserve.ini,np,Fserve,Send.Total) files)
  me $logo(Fserv note) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Note))
  me $logo(Current Gets) $cin2($get(0))
  me $logo(Current Sends) $cin2($send(0))
}

fsis {
  echo -a $logo(Fserv Info for user $me) 
  echo -a $logo(Fserv Status) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Status))
  echo -a $logo(Accessed) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Access) times)
  echo -a $logo(Max Sends) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Max.Sends.Total))
  echo -a $logo(Max Queues) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Max.Queues.Total))
  echo -a $logo(Transfer Record) $cin2($round($calc($gettok($readini($mircdirSystem\Fserve.ini,np,Fserve,Record.CPS),1,32)/1000),2) kb/s by $gettok($readini($mircdirSystem\Fserve.ini,np,Fserve,Record.CPS),2,32))
  echo -a $logo(Last reset of sent) $cin2($asctime($r.set(fserve,send.lastreset)))
  echo -a $logo(Sent) $cin2($size($readini($mircdirSystem\Fserve.ini,np,Fserve,Send.Bytes)) in $readini($mircdirSystem\Fserve.ini,np,Fserve,Send.Total) files)
  echo -a $logo(Fserv note) $cin2($readini($mircdirSystem\Fserve.ini,np,Fserve,Note))
  echo -a $logo(Current Gets) $cin2($get(0))
  echo -a $logo(Current Sends) $cin2($send(0))
}

fxpstat {
  /fxpfxp
  /fxpdown
  /fxpup
}


fxpfxp {

  if ($isfile($sets(programs,flashfxp)) == $false) { 
    /CSet programs flashfxp $$sfile($iif($isdir(C:\Program files\FlashFXP\) == $false,$iif($isdir(C:\) == $false,C:\,$mircdir),C:\Program Files\FlashFXP\) $+ *.exe,Select the FlashFXP exe)
  }
  if ($isfile($sets(programs,flashfxp)) == $false) { return }
  %flashfxppath = $nofile($sets(programs,flashfxp))

  %flashfxpbytes = $readini %flashfxppath $+ stats.dat #total# X
  %flashfxpdate2 = $readini " $+ %flashfxppath $+ stats.dat" #Total# LR
  %flashfxpdate2 = $left(%flashfxpdate2,5)
  %flashfxpdate2 = $calc((%flashfxpdate2 - 25569) * 86400) 
  %flashfxpdate1 = $asctime(%flashfxpdate2,d mmm yyyy)
  %flashfxpratekbps = $round($calc((%flashfxpbytes / 1024) / ($ctime - %flashfxpdate2)),3)
  %flashfxpratembpm = $round($calc((%flashfxpbytes / 1024 / 1024) / (($ctime - %flashfxpdate2) / 60 / 60 / 24)),3)

  /say $cin2(I have FXP'ed) $cin($size(%flashfxpbytes)) $cin2(with FlashFXP since) $cin(%flashfxpdate1) $cin2(- That's an average of) $cin(%flashfxpratekbps) $cin2(KB/s or) $cin(%flashfxpratembpm) $cin2(MB/day) -
}

fxpup {
  if ($isfile($sets(programs,flashfxp)) == $false) { 
    /CSet programs flashfxp $$sfile($iif($isdir(C:\Program files\FlashFXP\) == $false,$iif($isdir(C:\) == $false,C:\,$mircdir),C:\Program Files\FlashFXP\) $+ *.exe,Select the FlashFXP exe)
  }
  if ($isfile($sets(programs,flashfxp)) == $false) { return }
  %flashfxppath = $nofile($sets(programs,flashfxp))

  %flashupbytes = $readini %flashfxppath $+ stats.dat #total# FU
  %flashfxpdate2 = $readini " $+ %flashfxppath $+ stats.dat" #Total# LR
  %flashfxpdate2 = $left(%flashfxpdate2,5)
  %flashfxpdate2 = $calc((%flashfxpdate2 - 25569) * 86400) 
  %flashfxpdate1 = $asctime(%flashfxpdate2,d mmm yyyy)
  %flashupratekbps = $round($calc((%flashupbytes / 1024) / ($ctime - %flashfxpdate2)),3)
  %flashupratembpm = $round($calc((%flashupbytes / 1024 / 1024) / (($ctime - %flashfxpdate2) / 60 / 60 / 24)),3)

  /say $cin2(- I have uploaded) $cin($size(%flashupbytes)) $cin2(with FlashFXP since) $cin(%flashfxpdate1) $cin2(- That's an average of) $cin(%flashupratekbps) $cin2(KB/s or) $cin(%flashupratembpm) $cin2(MB/day -)
}

fxpdown {
  if ($isfile($sets(programs,flashfxp)) == $false) { 
    /CSet programs flashfxp $$sfile($iif($isdir(C:\Program files\FlashFXP\) == $false,$iif($isdir(C:\) == $false,C:\,$mircdir),C:\Program Files\FlashFXP\) $+ *.exe,Select the FlashFXP exe)
  }
  if ($isfile($sets(programs,flashfxp)) == $false) { return }
  %flashfxppath = $nofile($sets(programs,flashfxp))

  %flashdnbytes = $readini %flashfxppath $+ stats.dat #total# FD
  %flashfxpdate2 = $readini " $+ %flashfxppath $+ stats.dat" #Total# LR
  %flashfxpdate2 = $left(%flashfxpdate2,5)
  %flashfxpdate2 = $calc((%flashfxpdate2 - 25569) * 86400) 
  %flashfxpdate1 = $asctime(%flashfxpdate2,d mmm yyyy)
  %flashdnratekbps = $round($calc((%flashdnbytes / 1024) / ($ctime - %flashfxpdate2)),3)
  %flashdnratembpm = $round($calc((%flashdnbytes / 1024 / 1024) / (($ctime - %flashfxpdate2) / 60 / 60 / 24)),3)

  /say $cin2(- I have downloaded) $cin($size(%flashdnbytes)) $cin2(with FlashFXP since) $cin(%flashfxpdate1) $cin2(- That's an average of) $cin(%flashdnratekbps) $cin2(KB/s or) $cin(%flashdnratembpm) $cin2(MB/day -)
}
mooi {
  if ($1 == name) { return $wmiget(Win32_ComputerSystem).Name }
  if ($1 == ostitle) { return $wmiget(Win32_OperatingSystem).Caption }
  if ($1 == ossp) { return $wmiget(Win32_OperatingSystem).CSDVersion }
  if ($1 == osver) { return $wmiget(Win32_OperatingSystem).Version }
  if ($1 == osinstall) { return $asctime($ctime($iif($wmiget(Win32_OperatingSystem).InstallDate,$+($mid($ifmatch,7,2),/,$mid($ifmatch,5,2),/,$mid($ifmatch,1,4)) $+($mid($ifmatch,9,2),:,$mid($ifmatch,11,2),:,$mid($ifmatch,13,2))))) }
  if ($1 == up) { return $uptime(system,3) }
  if ($1 == cpuname) { return $wmiget(Win32_Processor).Name }
  if ($1 == cpuspeed) { return $+($wmiget(Win32_Processor).CurrentClockSpeed,MHz) }
  if ($1 == cpuload) { return $+($wmiget(Win32_Processor).LoadPercentage,% Load) }
  if ($1 == cputotal) { return $wmiget(Win32_ComputerSystem).NumberOfProcessors }
  if ($1 == gfxmake) { return $wmiget(Win32_VideoController).AdapterCompatibility }
  if ($1 == gfxproc) { return $wmiget(Win32_VideoController).VideoProcessor }
  if ($1 == gfxram) { return $bytes($wmiget(Win32_VideoController).AdapterRam).3 $+ MB }
  if ($1 == res) { return $+($wmiget(Win32_VideoController).currenthorizontalresolution,x,$wmiget(Win32_VideoController).currentverticalresolution) }
  if ($1 == resbit) { return $wmiget(Win32_VideoController).currentbitsperpixel $+ bit }
  if ($1 == resrate) { return $wmiget(Win32_VideoController).currentrefreshrate $+ Hz }
  if ($1 == rammax) { return $round($calc($wmiget(Win32_LogicalMemoryConfiguration).TotalPhysicalMemory / 1024),2) }
  if ($1 == ramuse) { return $bytes($wmiget(Win32_PerfRawData_PerfOS_Memory).AvailableBytes).3 }
  if ($1 == netname) { return $wmiget(Win32_PerfRawData_Tcpip_NetworkInterface).Name }
  if ($1 == netspeed) { return $calc($wmiget(Win32_PerfRawData_Tcpip_NetworkInterface).CurrentBandwidth / 1000000) $+ MB/s }
  if ($1 == netin) { return $bytes($wmiget(Win32_PerfRawData_Tcpip_NetworkInterface).BytesReceivedPersec).suf }
  if ($1 == netout) { return $bytes($wmiget(Win32_PerfRawData_Tcpip_NetworkInterface).BytesSentPersec).suf }
  if ($1 == hdd) { var %i 1 | while (%i <= $disk(0)) { if ($disk(%i).type == fixed) var %var %var $disk(%i).path $+($bytes($disk(%i).free).suf,/,$bytes($disk(%i).size).suf Free) | inc %i } | return %var }
  if ($1 == sound) { return $wmiget(Win32_SoundDevice).Name }
  if ($1 == mobo) { return $wmiget(Win32_BaseBoard).Manufacturer $wmiget(Win32_BaseBoard).Product }
}
wmiget {
  var %com = cominfo, %com2 = cominfo2, %com3 = cominfo3
  if ($com(%com)) { .comclose %com }
  if ($com(%com2)) { .comclose %com2 }
  if ($com(%com3)) { .comclose %com3 }
  .comopen %com WbemScripting.SWbemLocator
  var %x = $com(%com,ConnectServer,3,dispatch* %com2), %x = $com(%com2,ExecQuery,3,bstr*,select $prop from $1,dispatch* %com3), %x = $comval(%com3,$iif($2,$2,1),$prop)
  if ($com(%com)) { .comclose %com }
  if ($com(%com2)) { .comclose %com2 }
  if ($com(%com3)) { .comclose %com3 }
  return %x
}
brak return $+($chr(40),$1-,$chr(41))
moof {
  if ($1 == os) { return $moos($1) $mooi(ostitle) - $mooi(ossp) $brak($mooi(osver)) }
  if ($1 == up) { return $moos($1) $duration($mooi(up)) }
  if ($1 == cpu) { return $moos($1) $mooi(cpuname) at $mooi(cpuspeed) $brak($mooi(cpuload)) }
  if ($1 == gfx) { return $moos($1) $mooi(gfxmake) $mooi(gfxproc) $mooi(gfxram) }
  if ($1 == res) { return $moos($1) $mooi($1) $mooi(resbit) $mooi(resrate) }
  if ($1 == ram) { var %moo.rammax = $mooi(rammax) | var %moo.ramuse = $mooi(ramuse) | return $moos($1) $+($round($calc(%moo.rammax - %moo.ramuse),0),/,%moo.rammax,MB) $+($chr(40),$round($calc((%moo.rammax - %moo.ramuse) / %moo.rammax * 100),2),%,$chr(41)) }
  if ($1 == hdd) { return $moos($1) $mooi(hdd) }
  if ($1 == net) { return $moos($1) $iif($mooi(netname),$ifmatch - $mooi(netspeed) $mooi(netin) In $mooi(netout) Out, ) }
  elseif ($mooi($1)) { return $moos($1) $ifmatch }
}
moor return Info of my pc: $iif($mooi(name), $moof(os) $moof(up) $moof(cpu) $moof(gfx) $moof(res) $moof(ram) $moof(hdd) $moof(net),lookup error)
moo {
  if (!$1) { $iif($chan,msg $chan,say) $moor | return }
  if ($1 == echo) { echo -a $moor | return }
  if ($moof($1)) { var %moo.var $ifmatch | $iif($chan,msg $chan,say) Info: %moo.var }
}
moover return test 
moos return $+(,$1,:)
moo.banchans return #blackcats
