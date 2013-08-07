;=========================Alarm Clock=============================
;This Add on  wrote  just  for your  advantage , I   want  to share 
;some  useful  code   that  may be need  for your  script , you  can
;use any if you like , If you like give me a credit
;                                     Niceboy-DvD
;- All most  Code take from  my script 
; Nice Script : http://risedvd.tripod.com
; Thanks  for dragonzap and website www.mircscript.org
;if  you have any bugs  or comments  Please  Send an email  for me 
; dvd21us@yahoo.com
;or  contact me at  Website http://www.mircscript.org  nick Niceboy
;
;==========================================================================


;-------------- you can modify your File's Path  here ----------------
alias -l  dl { return " $+ $scriptdirmdx.dll $+ " }
alias -l  gmdx { return  $scriptdirctl_gen.mdx  }
;------------------------------------------------------------------------

;----------------may be you want change location some other files-----------------
alias -l other.r  return $readini " $+ $scriptdirconf.ini $+ " Alarm $1
alias -l other.w  {
  if  $2 !=  $null { writeini " $+ $scriptdirconf.ini $+ " Alarm $1 $2- } 
  else remini " $+ $scriptdirconf.ini $+ " Alarm $1-
}
alias -l helpfile { return " $+ $scriptdirclock.xxx $+ " }

;-----------------------------------------------------------------------------------


;-----------------------------------------------------------------------------------
;menu bar, 
menu status,menubar {
  MIRC Tools
  .Alarm Clock:NAlarm
}
;--------------------------------Change alias ?--------------------------------------
;I use this  alias a lot  to call a  dialog /dd <table name> [para]

alias -l  dd {  if  !$dialog($1) { .Timer 1 0 dialog  $iif($2,$2,-mar) $1 $1 } | else { dialog -ve $1 } }
;main command

alias nalarm dd clock -m
alias Unload_NAlarm  {
  .TimerNalarm off
  unload -rs " $+ $script $+ "
}
;---------------------------------------------------------------------------------------
dialog clock {
  title "Alarm clock"
  size -1 -1 161 163
  option dbu
  edit "", 3, 58 12 8 9, right
  button "!", 33, 58 12 8 9, hide
  edit ":", 5, 66 12 3 9
  edit "", 4, 69 12 9 9, hide
  button "!", 34, 69 12 9 9
  edit "", 8, 78 12 9 9, hide
  button "!", 38, 78 12 9 9
  edit "", 2, 89 12 10 10
  box "", 6, 57 8 30 14
  box "Set", 7, 6 4 148 46
  box "Options", 9, 6 56 148 83
  check "Allow Sound Ramping", 10, 23 96 65 10
  check "Loop Sound", 11, 23 83 40 11
  edit "", 12, 66 84 43 10
  text "Times", 13, 113 85 20 8
  button "OK", 14, 17 144 31 12, ok
  button "Start Alarm", 15, 60 144 31 12
  button "Select Sound", 17, 65 68 37 10
  button "Play It", 18, 113 68 20 10
  button "help", 19, 103 144 31 12
  radio "Alarm Time :", 1, 14 12 38 10
  radio "About ", 29, 14 27 25 11
  check "Auto Start", 21, 14 122 50 10
  box "", 16, 43 25 23 14
  edit "", 20, 44 29 8 9, right
  button "!", 22, 44 29 8 9, hide
  edit ":", 23, 52 29 3 9
  edit "", 24, 55 29 9 9, hide
  button "!", 25, 55 29 9 9
  edit "", 28, 66 28 10 10
  text "Later", 26, 80 29 17 8
  text "Hour:Min", 27, 41 40 22 9, disable
  check "Alarm Sound", 30, 14 68 47 10
  check "Alarm Message", 31, 14 108 48 11
  button "Set Msg", 32, 65 109 37 10
}

on *:dialog:clock:init:0 {
  dll $dl SetMircVersion $version
  dll $dl MarkDialog $dname
  dll $dl SetBorderStyle clock 5,3,4,2,8,20,22,23,24,25,28 noborder
  dll $dl SetControlMDX 34,38,25 text  > $gmdx
  dll $dl SetControlMDX 33,22 text right > $gmdx
  dll $dl SetColor 33,34,38,22,25  background $rgb(255,255,255)
  dll $dl SetColor 33,34,38,22,25 textbg $rgb(255,255,255)
  dll $dl SetControlMDX  2,28 UpDown wrap> $gmdx
  did -a clock 33,3 $iif($other.r(Alarm.Hour) != $null ,$ifmatch,12)
  did -a clock 34,4 $iif($other.r(Alarm.Min)  != $null  ,$ifmatch,00)
  did -a clock 20,22 $iif($other.r(Alarm.Hour1)  != $null   ,$ifmatch,12)
  did -a clock 24,25 $iif($other.r(Alarm.Min1)  != $null ,$ifmatch,00)
  did -a clock 38,8 $iif($other.r(Alarm.AP)  != $null ,$ifmatch,AM)
  if $other.r(Alarm.Ramp) { did -c clock 10 }
  if $other.r(Alarm.Loop) { did -c clock 11 } | else { did -b clock  10 }
  if $other.r(Alarm.Method)  { did -c clock 1 } | else { did -c clock 29 }
  if $other.r(Alarm.start) { did -c clock 21 }
  did -a clock 12 $iif($other.r(Alarm.Times) != $null ,$ifmatch,Endless)
  if ($did(12) != Endless) && ($did(12) < 5 ) {  did -b clock 10 }
  did -i clock 2 1 0 0 12 10 1:1,2:3
  did -f clock 3 |   set %clock.active 3 |   did -i clock 2 1 $did(3)
  did -i clock 28 1 0 0 12 10 1:1,2:3
  set %clock.active1 20 |   did -i clock 28 1 $did(20) 
  if $other.r(Alarm.sound) { if (!$isfile($ifmatch)) { other.w alarm.sound | did -b clock 18 } }
  else {  did -b clock 18 }
  elseif %Nalarm.runsound { did -ar clock 18 Stop }
  if $timer(NAlarm) { did -ar clock 15 Stop Alarm }
  if $other.r(Alarm.Esound) { did -c clock 30 } | else { did -b clock 10,11,12,17,18,13 }
  if $other.r(Alarm.Emsg ) { did -c clock 31 }
}
on *:dialog:clock:edit:*: {
  if $did = 2 { 
    if %clock.active = 8 {  did -ar  clock 8 $iif($gettok($did(2),1,32) ,PM,AM) }
    else   did -ar  clock %clock.active  $iif(%clock.active = 4,$clock.digit($gettok($did(2),1,32)),$gettok($did(2),1,32))
  }
  elseif $did = 28 { did -ar  clock %clock.active1  $iif(%clock.active1 = 24,$clock.digit($gettok($did(28),1,32)),$gettok($did(28),1,32))  }
  elseif $did = 3 {
    if $did(3) isnum { if ($did(3) > 12) || ($did(3) < 0) { did -ar clock 3 12 } |   did -i clock 2 1 $did(3) }
    else  did -r clock 3
  }
  elseif $did = 20 {
    if $did(20) isnum { if ($did(20) > 12) || ($did(20) < 0) { did -ar clock 20 12 } |   did -i clock 28 1 $did(20) }
    else  did -r clock 20
  }
  elseif $did = 4 {
    if $did(4) isnum  {  if ($did(4) > 60) || ($did(4) < 0)  { did -ar clock 4 60 } |  did -i clock 2 1 $did(4) }  
    else  did -r clock 4  
  }
  elseif $did = 24 {
    if $did(24) isnum  {  if ($did(24) > 60) || ($did(24) < 0)  { did -ar clock 24 60 } |  did -i clock 28 1 $did(24) }  
    else  did -r clock 24  
  }
  elseif $did = 8 {
    if $did(8) = A { did -ar clock 8 AM | did -i clock 2 1 1 } | elseif  $did(8) = P { did -ar clock 8  PM | did -i clock 2 2 }
    else { did -r clock 8 }
  }
  elseif  $did = 12 { 
    if (($did(12) != Endless) && ($did(12) < 5 )) || (!$did(11).state) { did -b clock 10 } | else  did -e clock 10
  }
}
on *:dialog:clock:close:0: {  unset %clock.active* }
on *:dialog:clock:sclick:*: {
  if $did = 33 { 
    did -vf clock 3 | did -h clock 33,4,8 | did -av clock 34   $did(4) | did -av clock 38 $did(8)
    set %clock.active 3
    did -i clock 2 1 0 0 12 10 1:1,2:3
    did -i clock 2 1 $did(3)
  }
  elseif $did = 22 { 
    did -vf clock 20 | did -h clock 22,24 | did -av clock 25   $did(24)
    set %clock.active1 20
    did -i clock 28 1 0 0 12 10 1:1,2:3
    did -i clock 28 1 $did(20)
  }
  elseif $did = 34 { 
    did -vf clock 4 | did -h clock 34,3,8 | did -av clock 33  $did(3)  | did -av clock 38 $did(8)
    set %clock.active 4
    did -i clock 2 1 0 0 60 10 1:1,2:5,5:10
    did -i clock 2 1 $did(4)
  }
  elseif $did = 25 { 
    did -vf clock 24 | did -h clock 25,20 | did -av clock 22  $did(20) 
    set %clock.active1 24
    did -i clock 28 1 0 0 60 10 1:1,2:5,5:10
    did -i clock 28 1 $did(24)
  }
  elseif $did = 38 { 
    did -vf clock 8 | did -h clock 38,3,4 | did -av clock 33  $did(3)  | did -av clock 34 $did(4)
    set %clock.active 8
    did -i clock 2 1 0 0 1 10 0:1
    did -i clock 2 1 $iif($did(8) = AM,0,1)
  }
  elseif $did = 11 { 
    if (($did(12) != Endless) && ($did(12) < 5 )) || (!$did(11).state) { did -b clock 10 } | else  did -e clock 10
  }
  elseif $did = 14 { Alarm.save   }
  elseif $did = 17 {
    var %s $$sfile($mircdirmp3\*.mp3,Select a file,Open) 
    if $isfile(%s) { other.w Alarm.sound %s | did -e clock 18 } 
    else {  Tberror File not Found : $nopath(%s)    | return }
  } 
  elseif $did = 18 {
    if $did(18) = Play It { .splay $+(",$other.r(Alarm.Sound),")   | set %Nalarm.testsound $true  | did -ar clock 18 Stop   }
    else { 
      .Splay stop | did -ar clock 18 Play It | unset %Nalarm.testsound
      if %Nalarm.runsound {  unset %Nalarm.runsound  %Nalarm.old.Times | if %Nalarm.old.master { Alarm.reset.vol }   }
    }
  }
  elseif $did = 19 { dialog -ma clockhelp clockhelp }
  elseif $did = 30 {
    if !$did(30).state && !$did(31).state {  did -c clock 30 } 
    else {
      did $iif($did(30).state,-e,-b) clock  10,11,12,17,13 
      if ($other.r(Alarm.sound)) { did -e clock 18  }
    }
  }
  elseif $did = 31 { if !$did(30).state && !$did(31).state {  did -c clock 31 } }
  elseif  $did = 32  { other.w Alarm.msg $$input(Enter your Alarm Message:,33,Alarm,$other.r(Alarm.msg)) }
  elseif $did = 15 { 
    if $did(15) = Stop Alarm {
      .TimerNAlarm off | did -ar clock 15 Start Alarm 
      .Splay Stop |      if %Nalarm.old.master { Alarm.reset.vol } | unset %Nalarm.runsound %Nalarm.old.Times
    }
    else {
      if $did(1).state {
        if $clock.changetime($did(3),$did(4),$did(8)) {  .TimerNAlarm -oi $ifmatch 1 1 Alarm.bell | did -ar clock 15 Stop Alarm } 
        else Tberror Please fill in your Alarm Time
      }
      else { 
        if (($did(24) != $null) || ($did(20) != $null)) { .TimerNAlarm -oi 1  $calc(($did(20) * 60 + $did(24))*60)  Alarm.bell  | did -ar clock 15 Stop Alarm }
        else Tberror Please fill in About Time
      }
    }
  }
}
alias -l Alarm.save {
  other.w Alarm.Hour $did(Clock,3) |     other.w Alarm.Min $did(Clock,4)
  other.w Alarm.Hour1 $did(Clock,20) |     other.w Alarm.Min1 $did(Clock,24)
  other.w Alarm.AP $did(Clock,8)    |     other.w Alarm.Loop $did(Clock,11).state
  other.w Alarm.Times $iif($did(Clock,12) isnum,$did(Clock,12),EndLess)
  other.w Alarm.Ramp  $did(Clock,10).state  |   other.w Alarm.method $did(Clock,1).state
  other.w Alarm.sel $did(Clock,20).sel | other.w Alarm.start $did(Clock,21).state 
  other.w Alarm.Esound $did(clock,30).state  | other.w Alarm.Emsg $did(clock,31).state
}
alias -l Alarm.bell { 
  if %Nalarm.old.master { Alarm.reset.vol }
  var %tmp.emsg,%tmp.esound ,%tmp.ramp
  if $dialog(clock) {    
    did -ar clock 15 Start Alarm |   %tmp.emsg = $did(clock,31).state   
    %tmp.esound = $did(clock,30).state
    if ($did(clock,11).state)  set %Nalarm.old.Times $iif($did(Clock,12) isnum,$did(Clock,12),1000000) 
    if (($did(clock,12) != Endless) && ($did(clock,12) < 5 )) || (!$did(clock,11).state) { %tmp.ramp = $false } 
    elseif  ($did(clock,10).state) %tmp.ramp = $true
  }
  else { 
    %tmp.emsg = $other.r(Alarm.Emsg) 
    %tmp.esound = $other.r(Alarm.esound)
    if ($other.r(Alarm.Loop))  set %Nalarm.old.Times $iif($other.r(Alarm.Times) isnum,$other.r(Alarm.Times),1000000)  
    if (($other.r(Alarm.Times) != Endless) && ($other.r(Alarm.Times) < 5 )) || (!$other.r(Alarm.Loop)) { %tmp.ramp = $false } 
    elseif  ($other.r(Alarm.Ramp)) %tmp.ramp = $true
  }
  if %tmp.emsg { set  %tmp.msg  $iif($other.r(Alarm.msg),$ifmatch,Your Time have come)  | dd dlgtime -mdo  }
  if %tmp.esound { 
    if $isfile($other.r(Alarm.Sound)) {
      .splay $+(",$other.r(Alarm.Sound),")   | set %Nalarm.runsound $True
      if $dialog(clock) {  did -ar clock 18 Stop }
      if  %tmp.ramp { 
        set %Nalarm.old.master $vol(master)  | set %Nalarm.old.wave $vol(wave)
        vol -v 2621.4 | .TimerNalarm.ramp 0 5 Alarm.ramp 
      }
    }
    else {
      if (!$other.r(Alarm.sound)) Tberror Sound could not play,Please Select a Sound First
      else Tberror File not Found : $nopath($other.r(Alarm.Sound)) 
      unset %Nlarm.old.Times
    }
  }
}
alias -l alarm.ramp { 
  if ($vol(master) !== 65536) {   vol -v $calc($vol(master) + 1310.7)   }
  elseif ($vol(wave) !== 65535) { vol -w $calc($vol(wave) + 1310.7)  }
  else  .TimerNalarm.ramp off
}
alias -l clock.digit { if $1 isnum 0-9 { return $+(0,$1) } | return $1 }
alias  clock.changetime {
  if ($3 = $null) || ($2 = $null) || ($1 = $null) {  return $false }
  if ($3 = AM) { var %h = $iif($1 = 12 ,0,$1) }
  if ($3 = PM) { var %h = $iif($1 = 12 ,12,$calc($1 +12))  }
  return  $+(%h,:,$2)
}
dialog Clockhelp {
  title "Help"
  size -1 -1 292 152
  option dbu
  button , 3, 0 0 0 0, hide cancel
  button &OK, 4, 239 127 37 12, default ok
  tab "Usage", 1, 7 1 276 142
  tab "Description",5
  tab "Contact",6
  edit , 2, 16 20 259 103,  read multi hsbar vsbar
}

on *:dialog:Clockhelp:init:0:{
  if (!$isfile($helpfile))  did -a clockhelp 2 Help-File, helpfile \clock.xxx , not found 
  else {    loadbuf -otUsage Clockhelp 2 $helpfile  }
}
on *:dialog:Clockhelp:sclick:*:{
  if (!$isfile($helpfile))  did -a clockhelp 2 Help-File, helpfile \clock.xxx , not found 
  else   {
    if $did = 1 { did -r clockhelp 2 |   loadbuf -otUsage  Clockhelp 2 $helpfile  }
    if $did = 5 { did -r clockhelp 2 |   loadbuf -otdescription Clockhelp 2 $helpfile  }
    if $did = 6 {  did -r clockhelp 2 |   loadbuf -otcontact Clockhelp 2 $helpfile }
  }
}
alias -l  Alarm.reset.vol {
  .TimerNalarm.ramp  off
  vol -v %Nalarm.old.master  | vol -w %Nalarm.old.wave | unset %Nalarm.old.master %Nalarm.old.wave 
}
on *:WAVEEND: {
  if %Nalarm.testsound {      if $dialog(clock) { did -ar clock 18 play It } | unset %Nalarm.testsound }
  if %Nalarm.runsound  { 
    if (%Nalarm.old.Times) { .splay $+(",$other.r(Alarm.Sound),")  | dec %Nalarm.old.Times }
    else {
      unset %Nalarm.runsound  %Nalarm.old.Times | if %Nalarm.old.master { Alarm.reset.vol } 
      if $dialog(clock) { did -ar clock 18 play It }
    }
  }
}
on *:MP3END: {
  if %Nalarm.testsound {      if $dialog(clock) { did -ar clock 18 play It } | unset %Nalarm.testsound }
  if %Nalarm.runsound  { 
    if (%Nalarm.old.Times) { .splay $+(",$other.r(Alarm.Sound),")  | dec %Nalarm.old.Times }
    else {
      unset %Nalarm.runsound  %Nalarm.old.Times | if %Nalarm.old.master { Alarm.reset.vol } 
      if $dialog(clock) { did -ar clock 18 play It }
    }
  }
}
on *:start:{ 
  if $other.r(alarm.start) {
    unset %Nalarm.* 
    if $other.r(Alarm.method) {
      if $clock.changetime($other.r(alarm.hour),$other.r(alarm.min),$other.r(alarm.ap)) { 
        var %f $ifmatch
        TbInfo  Alarm has been Active at %f
        .TimerNAlarm -oi %f 1 1 Alarm.bell 
      } 
      else Tberror Please fill in your Alarm Time
    }
    else { 
      if (($other.r(alarm.hour1) != $null) || ($other.r(alarm.min1) != $null)) { 
        TbInfo Alarm has been Active About $other.r(alarm.hour1) hour(s) and $other.r(alarm.min1) minutes Later
        .TimerNAlarm -oi 1 $calc(($other.r(alarm.hour1) * 60 + $other.r(alarm.min1))*60)    Alarm.bell   
      }
      else Tberror  Please fill in About Time
    }
  }
}
dialog dlgTime {
  title "Alarm "
  size -1 -1 141 35
  option dbu
  text "", 2, 2 6 130 26, center
  button "&OK", 3, 55 23 29 10, default ok
}
on *:dialog:dlgTime:init:*:{ did -o dlgTime 2 1 %tmp.msg |  unset %tmp.msg  }

alias  Tberror {
  .echo -q $input($1-,260,Alarm Error) 
  if $dialog($dname) { dialog -ve $dname }
}
alias  TbInfo {
  .echo -q $input($1-,196,Alarm Info) 
  if $dialog($dname) { dialog -ve $dname }
}
on *:load:{
  if $version < 6 {  
    echo ------------------------------------------------------------------------------
    echo -a 4 I'm not test This Addon  on your version : $version (< 6.03), May be It'll not run .. use it at your own risk.
    echo -------------------------------------------------------------------------------
  }
  echo 4 Alarm Clock 1.0
  etopic To  use Alarm Clock , Open it on menu bar or status,or channel
  etopic Quick Command : 3/Nalarm  $chr(3) $+ $color(info) Open dialog
  etopic ------------: 3/Unload_NAlarm  $chr(3) $+ $color(info)  Unload it
  echo $chr(3) $+ $color(notice) About
  etopic if you have any suggestion, please  send an email to : dvd21us@yahoo.com  
  etopic Open Alarm dialog button Help  ( or  readme.txt )  for more information 
  echo $chr(3) $+ $color(notice) Other
  etopic Thanks for Dragonzap ,mIRCScript website and you! 
  etopic sorry for my bad English , and  Error Codes or any mistake 
}
alias -l etopic  { echo -s  $chr(3) $+ $color(info) $+ ... $+ $1-  }
;============================EOF=========================
