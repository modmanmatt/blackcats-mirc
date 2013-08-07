alias qmanager {
  /dialog -mravd Queue_Manager Queue_Manager
}
;alias Queuemanager_Control {
;  /dialog -mravd Queue_Manager Queue_Manager
;}

dialog Queue_Manager {
  title "Queue Manager 2002 ©The Playstation Area"
  size -1 -1 242 239
  option dbu
  list 2, 1 4 189 199, size
  button "Move Up", 4, 197 26 37 10
  button "Move Down", 5, 197 39 37 10
  button "Move Top", 44, 197 14 37 10
  button "Move Bottom", 55, 197 51 37 10
  button "Send Queue", 56, 197 63 37 10
  button "Send Next", 57, 197 75 37 10
  box " Arrange ", 350, 194 4 45 87
  box "Edit Queues", 300, 0 203 190 34
  button "Remove", 3, 66 223 30 10
  button "Update", 6, 97 223 30 10
  button "Add", 7, 128 223 30 10
  button "Done", 200, 159 223 30 10, ok
  text "File-System", 10, 202 95 27 6
  edit "", 11, 194 102 44 11, autohs
  text "Nickname", 15, 202 116 27 6
  edit "", 21, 3 210 160 11, autohs
  button "Browse", 30, 164 210 25 10
  edit "",16, 195 124 44 10
  text "Nicklist", 101, 202 136 27 6
  list 100, 195 144 44 90, size 
}

on *:dialog:Queue_Manager:*:*:{
  if ($devent == init) { qmu | did -m $dname 11 | did -e $dname 16,21 | set %qm-sel 1 | 
    set %chanman1 #tsz | set %chanman2 #newbies

    var %nickman1 = $nick(%chanman1,0)
    while (%nickman1) { 
      did -a Queue_Manager 100 $nick(%chanman1,%nickman1) | /write nicks.txt $nick(%chanman1,%nickman1)
      dec %nickman1
    }

    var %nickman2 = $nick(%chanman2,0)
    while (%nickman2) {
      if ( $didwm($dname,100,$nick(%chanman2,%nickman2),1) == 0 ) {
        did -a Queue_Manager 100 $nick(%chanman2,%nickman2) | /write nicks.txt $nick(%chanman2,%nickman2) 
      }
      dec %nickman2 
    }
  }

  if ($devent == sclick) {
    if ($did isnum 17-18) { did -h $dname $queue_grp( [ $replace($remtok(17 18,$did,1,32),$chr(32),$chr(44))  ) | did -v $dname $queue_grp($did) }
    ;if ($did == 3) { queue.del $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) }
    if ($did == 3) { queue.del $did($dname,2).sel }
    if ($did == 200) { unset %chanman1 | unset %chanman2  }
    if ($did == 100) { did -ra $dname 16 $did(100).seltext }
    if ($did == 4) {
      if (($did($dname,2).sel > 1) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        dec %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        qmu
      }
    }
    if ($did == 44) {
      if (($did($dname,2).sel > 1) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        :qmtop
        dec %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        dec %Queue.From
        if (%Queue.To > 1) { goto qmtop }
        qmu
      }
    }
    if ($did == 5) {
      if (($did($dname,2).sel < $did($dname,2).lines) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        inc %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        qmu
      }
    }
    if ($did == 55) {
      if (($did($dname,2).sel < $did($dname,2).lines) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        :qmbottom
        inc %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        inc %Queue.From
        if (%Queue.From < $did($dname,2).lines) { goto qmbottom }
        qmu
      }
    }
    if ($did == 56 ) {
      if ( $did(2).sel != $null ) {
        dcc send $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] , 2 , 32 ) " $+ $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] , 3- , 32 ) $+ "

        ;        queue.Mydel $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35))
      }
    }
    if ($did == 57  ) { 
      if ( %Queue.1 != $null ) {
        dcc send $gettok(%Queue.1,2,32) " $+ $gettok(%Queue.1,3-,32) $+ "
        ;        queue.Mydel 1
      }
      ;if ( $send(0) < $r.set(Fserve,Max.Sends.Total)) {
      ;  .timer 1 0 queue.send | .timerquesendTemp 1 2 did -ra $dname 50 $queue(0) $+ / $+ $r.set(Fserve, Max.Queues.Total)
      ;} 
      ;else {
      ; aecho Max Send Exceeded !
      ;}
    }
    if (($did == 2) || ($did == 4) || ($did == 5)) {
      ;qmu
      ;did -f $dname 2 %qm-sel
      did -ra $dname 11 $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,1,32)
      did -ra $dname 16 $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,2,32)
      did -ra $dname 21 $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,3-,32)
    }
    if ($did == 6) { %Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] = $did($dname,11) $did($dname,16) $did($dname,21) }
    if ($did == 7) { queue.add Fserve $did($dname,16) $did($dname,21) }
    if ($did == 30) { .timer 1 0 did -ra $dname 21 $!$dir="Select File" *.* }
  }
}

alias qmu { if ($dialog(Queue_Manager) != $null) { did -r Queue_Manager 2,11,16,21 | set %~qmu 0 | :start | inc %~qmu 1 | if (%Queue. [ $+ [ %~qmu ] ] == $null) { unset %~qmu } | else { did -a Queue_Manager 2 Queue $chr(35) $+ %~qmu | goto start } } }
alias queue.del { if ($isnum($1) == $true) { set -u0 %~queue-dc $calc($1 - 1) | :start | inc %~queue-dc 1 | set %Queue. [ $+ [ %~queue-dc ] ] | if (%Queue. [ $+ [ $calc(%~queue-dc + 1) ] ] == $null) { unset %~queue-dc | qmu } | else { set %Queue. [ $+ [ %~queue-dc ] ] %Queue. [ $+ [ $calc(%~queue-dc + 1) ] ] | goto start } } }
alias queue.add { queue.exists $1- | if ($result isnum) { return $result } | set -u0 %~queue-ac 0 | :start | inc %~queue-ac 1 | if (%Queue. [ $+ [ %~queue-ac ] ] == $null) { set %Queue. [ $+ [ %~queue-ac ] ] $1- | unset %~queue-ac | qmu } | else { goto start } }
alias queue.exists { set -u0 %~queue-ec 0 | :start | inc %~queue-ec 1 | if (%Queue. [ $+ [ %~queue-ec ] ] != $null) { if (%Queue. [ $+ [ %~queue-ec ] ] == $1-) { return %~queue-ec } | goto start } }
