;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          8 Ball ©Loafer357           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
on *:load:8ball.init
menu menubar,channel {
  -
  Games
  .8-Ball:/dialog -m 8bd 8bd
}
.alias -l 8ball.init {
  set %8me $?"Main nickname: "
  set %8bb 0
  set %8ball on
  set %8custom 0
  set %8ballresponse 0
  set %8meth 1
  set %8c1 15,1
  set %8c2 12
  set %8cc1 15
  set %8cc2 1
  echo 2 -a ©2005 Loafer357 : 8-Ball script Loaded!!
  echo 2 -a Check your channel pop-ups to get started.
}
.on 1:unload:{
  unset %8ballresponse
  unset %8bb
  unset %8bb2
  unset %8bdmm
  unset %8c1
  unset %8c2
  unset %8cc1
  unset %8cc2
  unset %8chan
  unset %8custom
  unset %8ed
  unset %8edt
  unset %8me
  unset %8meth
  unset %8nick
  unset %8x
  echo 2 -a 8-Ball script Unloaded.
}
.alias -l unload8 {
  unload -rs 8ball.mrc
}
.alias -l 8on {
  amsg  $+ %8c1 8Ball has been enabled Syntax: !8ball question.
}
.alias -l custon {
  amsg  $+ %8c1 Adding you're own custom 8ball responses is now enabled. Syntax: !add8ball newresponse
}
.alias -l colorcode { return $gettok(White.Black.Dark Blue.Green.Light Red.Dark Red.Purple.Orange.Yellow.Light Green.Teal.Cyan.Blue.Pink.Grey.Light Grey,$calc($1 + 1),$asc(.)) }
.alias 8b {
  msg $chan !8ball $1-
  If ($1- = $null) {
    msg $chan  $+ %8c2 $+ ...You didn't type anything.
    return
  }
  If ($me = %8me) { 
    msg $chan  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ball.txt,n)  
  }
}
.dialog 8bd {
  title "8 Ball"
  size -1 -1 340 328
  icon 1, 274 0 66 66, $scriptdir8ball.bmp, 0, Noborder, Top, Right, 
  text "8 Ball by Loafer357 ©2005", 2, 95 28 151 19, Center, 
  icon 3, 0 0 66 66, $scriptdir8ball.bmp, 0, Noborder, Top, Left, 
  button "Ok", 4, 136 272 60 23, Ok, 
  box "Settings", 5, 41 85 251 166, 
  check "Allow Custom Response", 6, 52 123 134 13, 
  check "On/Off", 7, 52 105 54 13, 
  box "Auto/Manual", 8, 51 138 151 61, 
  radio "Auto Respond", 9, 56 155 89 17, 
  radio "Manual Response", 10, 56 174 120 17, 
  button "Unload", 11, 60 213 90 23,  Cancel,
  list  12, 206 117 80 88, 
  text "All Responses", 13, 213 98 93.6040268456376 18,
  button "Extra's", 14, 180 213 90 23,
}
.alias -l init {
  if (%8ball = On) { did -c 8bd 7 }
  if (%8custom = 1) { did -c 8bd 6 }
  if (%8ballresponse = 0) { did -c 8bd 9 }
  if (%8ballresponse = 1) { did -c 8bd 10 }
  did -r 8bd 12
  %8bb = $lines($scriptdir8ball.txt)
  if (%8bb = 0) { goto none }
  set %8bb2 1
  did -i 8bd 12 %8bb2 $read($scriptdir8ball.txt,n,%8bb2)
  :start
  if (%8bb2 = %8bb) { goto end }
  /inc %8bb2 1
  did -i 8bd 12 %8bb2 $read($scriptdir8ball.txt,n,%8bb2)
  goto start
  :none
  did -i 8bd 12 1 8ball.txt 
  did -i 8bd 12 2 is empty. 
  did -i 8bd 12 3 
  did -i 8bd 12 4 No Responses
  :end
}
.on *:dialog:8bd:*:*:{
  If ($devent == init) init
  If ($devent == sclick) {
    if ($did == 7) {
      if (%8ball = On) { set %8ball Off | goto a }
      if (%8ball = Off) { set %8ball On | 8on | goto a }    
    }
    :a
    if ($did == 6) {
      if (%8custom = 1) { set %8custom 0 | goto b }
      if (%8custom = 0) {
        set %8custom 1 
        custon
        goto b 
      }
    }
    :b
    if ($did == 9) { set %8ballresponse 0 }
    if ($did == 10) { set %8ballresponse 1 }
    if ($did == 11) {
      if ($?!=" Really Unload?") { unload8 }
    }
    if ($did == 14) { dialog -m 8extra 8extra }
  }
}
.dialog 8extra {
  title "8-Ball Extra's"
  size -1 -1 238 317
  icon 1, 0 0 66 66, $scriptdir8ball.bmp, 0, Top, Left, 
  text "8-Ball Extra's", 2, 96 30 89 19, 
  box "Extra's", 3, 28 75 181 195, 
  box "Respond Method", 9, 32 195 172 70,
  edit %8me, 4, 73 110 89 19, autohs %8me 
  text "Change Main Username", 5, 61 91 150 19, 
  button "Change Color Output", 6, 59 138 120 23,
  button "Manage Response List", 8, 52 168 135 23, 
  button "Ok", 7, 85 282 60 23, Ok,
  radio "Respond via Channel", 10, 39 210 135 17, 
  radio "Respond via Query", 11, 39 228 135 17, 
  radio "Respond via Notice", 12, 39 246 135 17,
}
.on *:dialog:8extra:*:*:{
  If ($devent == init) {
    if (%8meth = 1) { did -c 8extra 10 }
    if (%8meth = 2) { did -c 8extra 11 }
    if (%8meth = 3) { did -c 8extra 12 }
  }
  If ($devent == sclick) {
    if ($did == 7) { var %s 1 | init }
    if ($did == 6) { dialog -m 8bcs 8bcs }
    if ($did == 8) { dialog -m 8list 8list }
    if ($did == 10) { set %8meth 1 }
    if ($did == 11) { set %8meth 2 }
    if ($did == 12) { set %8meth 3 }
  }
}
.dialog 8bcs {
  title "8-Ball Colors"
  size -1 -1 240 227
  combo  1, 75 57 89 21, drop,
  text "Response Color", 2, 83 35 89 19, 
  text "Main Colors", 3, 93 90 89 19,
  combo  4, 11 115 89 21, drop,
  combo  5, 140 115 89 21, drop,
  button "Ok", 6, 74 185 89 23, ok,
  button "Echo Colors -> Active", 7, 60 155 120 19, 
  box "Set colors of msg, 8Ball Response: No    etc...", 8, 0 10 239 135,
} 
.on *:dialog:8bcs:*:*:{
  If ($devent == init) {
    var %i = 0
    while (%i <= 15) {
      did -a 8bcs 1,4,5 $colorcode(%i)
      inc %i
    }
    did -c 8bcs 1 $calc(%8c2 + 1)
    did -c 8bcs 4 $calc(%8cc1 + 1)
    did -c 8bcs 5 $calc(%8cc2 + 1)
  }
  If ($devent == sclick) {
    If ($did = 1) { set %8c2 $calc($did($did).sel - 1) }
    If ($did = 4) { set %8cc1 $calc($did($did).sel - 1) | set %8c1 $calc($did($did).sel - 1) $+ , $+ %8cc2 }
    If ($did = 5) { set %8cc2 $calc($did($did).sel - 1) | set %8c1 %8cc1 $+ , $+ $calc($did($did).sel - 1) }
    If ($did = 7) { echo -a  $+ %8c1 8Ball Response: $+ %8c2 Colors. }
  }
}
.dialog 8list {
  title "8-Ball Response List"
  size -1 -1 627 600
  list  1, 5 4 619 566, 
  text "Double click a response to delete it.", 2, 5 576 170 19, 
  button "Add A Response", 3, 210 573 89 23,
  button "Close", 4, 534 573 89 23, Ok, 
  button "Edit Response", 5, 330 573 89 23,
}
.alias -l delinit {
  did -r 8list 1
  %8bb = $lines($scriptdir8ball.txt)
  set %8bb2 1
  if (%8bb = 0) { goto none }
  did -i 8list 1 %8bb2 1: $+ $read($scriptdir8ball.txt,n,%8bb2)
  :start
  if (%8bb2 = %8bb) { goto end }
  /inc %8bb2 1
  did -i 8list 1 %8bb2 %8bb2 $+ : $+ $read($scriptdir8ball.txt,n,%8bb2)
  goto start
  :none
  did -i 8list 1 1 8ball.txt is empty. (No Responses)
  :end
}
.on *:dialog:8list:*:*:{
  If ($devent == init) delinit
  If ($devent == sclick) {
    If ($did = 5) {
      If ($did(1).sel) {
        set %8x $did(1).sel
        set %8ed $read($scriptdir8ball.txt,%8x)
        dialog -m 8edit 8edit
      }
    }
    If ($did = 3) {
      write " $+ $scriptdir8ball.txt $+ " $?"New Response: "
      delinit
    }
  }
  If ($devent == dclick) {
    If ($did = 1) {
      If ($did(1).sel) {
        var %x = $did(1).sel
        write -dl $+ %x " $+ $scriptdir $+ 8ball.txt $+ "
        delinit
      }
    }
  }
}
.dialog 8edit {
  title "Edit Response"
  size -1 -1 268 106
  edit %8ed, 1, 44 41 161 19,
  button "Ok", 2, 9 73 89 23, ok,
  button "Cancel", 3, 166 73 89 23, cancel, 
  text "Modify the response then click ok.", 4, 43 13 181 19
}
.on *:dialog:8edit:*:*:{
  If ($devent == edit) {
    If ($did = 1) {
      set %8edt $did(1).text
    }
  }
  If ($devent == sclick) {
    If ($did = 2) {
      write -l $+ %8x " $+ $scriptdir8ball.txt $+ " %8edt
      delinit
    }
    If ($did = 3) {
      write -l $+ %8x " $+ $scriptdir8ball.txt $+ " %8ed
    }
  }
}
.dialog 8bdm {
  title "Manual"
  size -1 -1 159 120
  button "Yes", 1, 14 55 50 50, 
  button "No", 2, 96 55 50 50, 
  text "Select Response", 3, 40 20 89.5973154362416 19, 
}
.on *:dialog:8bdm:*:*:{
  If ($devent == sclick) {
    if ($did == 1) { set %8bdmm 1 | manrespond }
    if ($did == 2) { set %8bdmm 2 | manrespond }
  }
}
.alias -l manrespond {
  If (%8meth = 1) { 
    If (%8bdmm = 1) { msg %8chan  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ballY.txt) } 
    If (%8bdmm = 2) { msg %8chan  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ballN.txt) }
  }
  If (%8meth = 2) { 
    If (%8bdmm = 1) { msg %8nick  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ballY.txt) } 
    If (%8bdmm = 2) { msg %8nick  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ballN.txt) }
  }
  If (%8meth = 3) { 
    If (%8bdmm = 1) { notice %8nick  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ballY.txt) } 
    If (%8bdmm = 2) { notice %8nick  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ballN.txt) }
  }
}
.on *:TEXT:!8ball*:*:{  
  If (%8ball = Off) { notice $nick 8-Ball is currently disabled. | return }
  If (%8ball = On) {  
    If (%8ballresponse = 1) {
      %8chan = $chan
      %8nick = $nick
      dialog -m 8bdm 8bdm
      return
    }
    If (%8ballresponse = 0) {  
      If ($chan != $active) { 
        echo -a  $+ %8c1 $nick $chan $1 : $2-
      }
      If (%8meth = 1) {
        If ($2- = $null) {
          msg $chan  $+ %8c2 $+ ...You didn't type anything.
          return
        }
        If ($me = %8me) { 
          msg $chan  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ball.txt,n)  
        }
      }
      If (%8meth = 2) {
        If ($2- = $null) {
          .msg $nick  $+ %8c2 $+ ...You didn't type anything.
          return
        }
        If ($me = %8me) {
          msg $nick  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ball.txt,n)  
        }
      }
      If (%8meth = 3) {
        If ($2- = $null) {
          .notice $nick  $+ %8c2 $+ ...You didn't type anything.
          return
        }
        If ($me = %8me) {
          notice $nick  $+ %8c1 8Ball Response: $+ %8c2 $read($scriptdir8ball.txt,n)  
        }
      }
    }
  }
}
.on *:TEXT:!add8ball*:*:{
  If (%8custom = 1) {
    .notice $nick 8Ball : Added response: $2-
    /write " $+ $scriptdir8ball.txt $+ " $2- (Added by: $nick $+ )
    return
  }
  .notice $nick Adding custom responses is currently disabled.
}
