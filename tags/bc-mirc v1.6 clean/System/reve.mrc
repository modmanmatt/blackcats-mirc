on ^*:serv:*:{
  if (ACTION * iswm $1-) { echo $colour(action) = $+ $nick $ts * $nick $visible($gettok($gettok($1-,1-,1),2-,32)) }
  elseif ($1- != $null) { echo = $+ $nick $ts  $+ $sets(viz,ADV.text) $+ < $+ $nick $+  $+ $sets(viz,ADV.text) $+ > $visible($1-) }
  if ($istok($remove($level($mask($fulladdress,3)),$chr(61)),30,44) == $true) { close -f $nick }
  elseif (($1- != s) && ($1- != c) && ($1- != bye) && ($1- != exit) && ($1 != read) && ($1- != quit) && ($1 != dir) && ($1- != ls) && ($1 != cd) && ($1 != cd..)) {
    if (($1 == Who) && ($2 == $null)) {
      if ($fserv(2) == $null) { msg =$nick $logo(It's just you and me lamer) }
      else {
        if ($fserv(0) == 2) { msg =$nick $logo(There is 1 other user on) }
        elseif ($fserv(0) >= 3) { msg =$nick  $+ $sets(viz,ADV.text) $+ There are $calc($fserv(0) - 1) other users online. }
        set %~fserve-w1 0
        set %~fserve-w2 0
        :whostart
        inc %~fserve-w1 1
        inc %~fserve-w2 1
        if ($fserv(%~fserve-w1) == $nick) { inc %~fserve-w1 1 }
        elseif ($fserv(%~fserve-w1) == $null) { unset %~fserve-w1 %~fserve-w2 }
        else { msg =$nick  $+ $sets(viz,ADV.text) $+ User $chr(35) $+ %~fserve-w2 $+ :  $fserv(%~fserve-w1)  $+ $sets(viz,ADV.info) $+ - $+ $fserv(%~fserve-w1).status $+ - | goto whostart }
      }
    }
    elseif (($1 == Stats) && ($2 == $null)) {
      msg =$nick $logo(File Server Stats)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(Logins,$vnum($r.set(Fserve,Access),0))
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(Files Sent,$vnum($r.set(Fserve,Send.Total),0))
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(Bytes Sent,$size($vnum($r.set(Fserve,Send.Bytes),0)))
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(Send Fails,$vnum($r.set(Fserve,Send.Fails),0))
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(Record CPS, [ [ $size($vnum($gettok($r.set(Fserve,Record.CPS),1,32),0)) $+ /s by $isset($gettok($r.set(Fserve,Record.CPS),2-,32)) ] ] )
    }
    elseif (($1 == Sends) && ($2 == $null)) {
      if ($send(0) == 0) { msg =$nick $logo(There are no sends) }
      else {
        if ($send(0) == 1) { msg =$nick $logo(There is 1 send in progress) }
        elseif ($send(0) > 1) { msg =$nick  $+ $sets(viz,ADV.text) $+ There are $send(0) sends in progress. }
        set %~fserve-s 0
        :sendstart
        inc %~fserve-s 1
        if ($send(%~fserve-s) == $null) { unset %~fserve-s }
        else { msg =$nick $logo(Send) $chr(35) $+ %~fserve-s $+ : $b($send(%~fserve-s)) has $send(%~fserve-s).pc $+ % of $b($send(%~fserve-s).file) | $+ $size($send(%~fserve-s).size) $+ | at $b($size($send(%~fserve-s).cps) $+ /s) | goto sendstart }
      }
    }
    elseif (($1 == Queues) && ($2 == $null)) {
      if ($queue(0) == 0) { msg =$nick $logo(There are no queues) }
      else {
        if ($queue(0) == 1) { msg =$nick $logo(There is 1 queue) }
        elseif ($queue(0) > 1) { msg =$nick  $+ $sets(viz,ADV.text) $+ There are $queue(0) queues waiting. }
        set %~fserve-q 0
        :queuestart
        inc %~fserve-q 1
        if ($queue(%~fserve-q) == $null) { unset %~fserve-q }
        else { msg =$nick $logo(Queue) $chr(35) $+ %~fserve-q $+ : $b($gettok($queue(%~fserve-q),2,32)) queued  $+ $sets(viz,ADV.info) $+ $nopath($gettok($queue(%~fserve-q),3-,32)) $b($size($lof($gettok($queue(%~fserve-q),3-,32)))) $+ . | goto queuestart }
      }
    }
    elseif (($1 == Clr_queues) && ($2 == $null)) {
      if ($queue.nick($nick) == 0) { msg =$nick $logo(You don't have any queues) }
      else {
        set %~fserve-cq 0
        :clr_queue-start-1
        inc %~fserve-cq 1
        :clr_queue-start-2
        if ($queue(%~fserve-cq) == $null) { unset %~fserve-cq | halt }
        elseif ($gettok($queue(%~fserve-cq),2,32) == $nick) { msg =$nick $logo(Remove)  $+ $sets(viz,ADV.info) $+ $nopath($gettok($queue(%~fserve-cq),3-,32)) $b($size($lof($gettok($queue(%~fserve-cq),3-,32)))) from your queue. | queue.del %~fserve-cq | goto clr_queue-start-2 }
        else { goto clr_queue-start-1 }
      }
    }
    elseif (($1 == Help) && ($2 == $null)) {
      msg =$nick $logo(File Server Help Menu)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(cd,Change your current directory [cd <directory|..>])
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(dir,List all the files in current directory)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(ls,List all the files in current directory [wide])
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(get,Gets file from the file server [get <filename>])
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(read,Reads file from file server [read <filename>])
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(stats,Shows file server statistics)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(who,Shows a list of who is connected)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(sends,Shows a list of current sends)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(queues,Shows a list of waiting queues)
      msg =$nick  $+ $sets(viz,ADV.text) $+ $sv(clr_queues,Deletes all of your queues from server)
    }
    elseif ($1 == GET) { 
      if ($2 == $null) { msg =$nick $logo(Syntax: get <filename>) }
      elseif (\ isin $2-) { msg =$nick $logo(Sorry) $b(you are not allowed to get files from other directories.) }
      else {
        set %~fserve-fn $fserv($nick).cd $+ \ [ $+ [ $2- ] ]
        if ($isfile(%~fserve-fn) != $true) { msg =$nick $logo(Invalid Filename) }
        ;*** send little file ***
        elseif ($file(%~fserve-fn) < 300000) { dcc send $nick " $+ %~fserve-fn $+ " | msg =$nick $logo(Quick sending) $nopath(%~fserve-fn) $b($size($file(%~fserve-fn).size)) $+ . } 
        :*** end send litle file ***
        elseif ($send(0) >= $r.set(Fserve,Max.Sends.Total)) {
          if ($queue(0) >= $r.set(Fserve,Max.Queues.Total)) { msg =$nick $logo(Sorry) $b(there are too many send in progress right now and all the queue slots are in use.)  If you want to see more info on the current sends type sends. }
          elseif ($queue.nick($nick) >= $r.set(Fserve,Max.Queues.Each)) { msg =$nick $logo(Sorry) $b(there are too many sends in progress right now and you have used all your queue slots.  If you still want to get a file please wait for one to finish and try again.) }
          else {
            queue.add Fserve $nick %~fserve-fn
            ;nick.ip
            /set % $+ $nick $fserv($nick).ip
            if ($result isnum) { msg =$nick $logo(Sorry) $b(that queue already exists in queue slot) $b(try and get another file next time.) }
            else { msg =$nick $logo(Queuing) $+  $+ $sets(viz,ADV.info) $nopath(%~fserve-fn) | $size($file(%~fserve-fn).size) |.  It has been placed in queue slot $chr(35) $+ $queue(0) $+ , it will send when sends are available. }
          }
        }
        elseif ($send.nick($nick) >= $r.set(Fserve,Max.Sends.Each)) {
          if ($queue(0) >= $r.set(Fserve,Max.Queues.Total)) { msg =$nick $logo(Sorry) $b(you have too many transfers right now and all the queue slots are in use.  If you want to see more info on the current sends type sends.) }
          elseif ($queue.nick($nick) >= $r.set(Fserve,Max.Queues.Each)) { msg =$nick $logo(Sorry) $b(you have too many transfers right now and you have used all your queue slots.  If you still want to get a file please wait for one to finish and try again.) }
          else {
            queue.add Fserve $nick %~fserve-fn
            ;nick.ip
            /set % $+ $nick $fserv($nick).ip
            if ($result isnum) { msg =$nick $logo(Sorry) $b(that queue already exists in queue slot $chr(35) $+ $result $+ , try and get another file next time.) }
            else { msg =$nick $logo(Queuing) $nopath(%~fserve-fn) $b($size($file(%~fserve-fn).size)) $+ .  It has been placed in queue slot $chr(35) $+ $queue(0) $+ , it will send when sends are available. }
          }
        }
        else { dcc send -l $+ %dcc.cap.cps $nick " $+ %~fserve-fn $+ " | msg =$nick $logo(sending) $nopath(%~fserve-fn) $b($size($file(%~fserve-fn).size)) $+ . }
      }
      unset %~fserve-fn
    }
    elseif ($r.set(Fserve,Fserve.Chat) == On) {
      if ($window(@Fserve.Chat) == $null) { window -enk @Fserve.Chat $r.winpos(@Fserve.Chat) @Fserve.Chat }
      titlebar @Fserve.Chat - Type messages in the box to talk with fserve users.
      if (ACTION * iswm $1-) { aline -ph $colour(action) @Fserve.Chat $ts * $nick $visible($gettok($gettok($1-,1-,1),2-,32)) }
      else { aline -ph @Fserve.Chat $ts  $+ $sets(viz,ADV.text) $+ < $+ $nick $+  $+ $sets(viz,ADV.text) $+ > $visible($1-) }
      if ($fserv(0) > 1) {
        set %~fserve-p 0
        :start
        inc %~fserve-p 1
        if ($fserv(%~fserve-p) == $null) { unset %~fserve-p }
        elseif (($fserv(%~fserve-p) == $nick) || ($fserv(%~fserve-p).status == waiting) || ($fserv(%~fserve-p).status == inactive)) { goto start }
        elseif (ACTION * iswm $1-) { msg = $+ $fserv(%~fserve-p) * $nick $gettok($gettok($1-,1-,1),2-,32) | goto start }
        else { msg = $+ $fserv(%~fserve-p) < $+ $nick $+ > $1- | goto start }
      }
    }
    haltdef
  }
}

on *:open:!:{ 
  w.set Fserve Access $calc( [ $r.set(Fserve,Access) ] + 1)
  msg =$nick  $+ $sets(viz,ADV.text) $+ $logo(File Server)
  msg =$nick  $+ $sets(viz,ADV.text) This File Server has been accessed  $+ $sets(viz,ADV.info) $+ $r.set(Fserve,Access) $+  $+ $sets(viz,ADV.text) times.
  msg =$nick  $+ $sets(viz,ADV.text) Commands:  $+ $sets(viz,ADV.info) $+ cd $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ ls $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ dir $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ read $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ get $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ stats $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ who $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ sends $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ queues $+  $+ $sets(viz,ADV.text) $+ ,  $+ $sets(viz,ADV.info) $+ clr_queues
  msg =$nick  $+ $sets(viz,ADV.text) To get more info about these commands, type  $+ $sets(viz,ADV.info) $+ help $+  $+ $sets(viz,ADV.text) $+ .
  msg =$nick  $+ $sets(viz,ADV.text) $+ -
}
on ^*:kick:#:{
  close -fs $knick
}

on @*!:ban:#: {
  if ($banmask iswm $address($me,5)) {  
    mode $chan -o $nick | .raw mode $chan -b+b $banmask $address($nick,2)
    kick $chan $nick $logo(bad move)
  }  
}

on 1:chat:*\*.*]:{ .enable #DirListing }