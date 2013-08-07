dialog fileServer {
  title "Disable Features"
  size -1 -1 260 210
  option dbu
  box "FservInfo                                                        ", 1, 2 3 254 204
  button  "Hide", 10, 215 15 25 10, ok, tab 1        
  button    "#", 11, 10 30 20 10, default tab 1    
  button    "Nick", 12, 30 30 40 10, default tab 1       
  button    "File", 13, 70 30 120 10, default tab 1      
  button    "CPS", 14, 190 30 35 10, default tab 1 
  list        15, 10 40 20 50,  tab 1  
  text       "Bandwidth in use", 16, 70 187 50 10, tab 1   
  list        17, 70 195 40 15, tab 1                               
  list        18, 30 40 40 50, tab 1                              
  list        19, 70 40 120 50, tab 1                             
  list        20, 190 40 35 50, tab 1                        
  list       21, 225 40 25 50, tab 1   
  button    "%",    22, 225 30 25 10, default tab 1                        
  text     "Gets", 24, 124 83 15 7, tab 1
  text       "Sends", 25, 122 20 15 10, tab 1                 
  list        26, 10 90 20 50, tab 1                             
  list        27, 30 90 40 50, tab 1                              
  list        28, 70 90 120 50, tab 1                             
  list        29, 190 90 35 50, tab 1                             
  list        30, 225 90 25 50, tab 1    
  list        31, 10 195 30 15, tab 1                                                                                  
  text       "Fserve slots in use" 32, 10 187 50 10, tab 1                                                                                         
  button  "Send Next Queue", 39, 20 15 45 10, tab 1, hide       
  list        43, 10 141 240 50, tab 1  
  text      "Status Window", 44, 120 133 40 8, tab 1   
  button  "Refresh", 45, 188 15 25 10,  tab 1      
  edit        "",46, 130 195 30 10, tab 1, hide 
  text       "Min Cps", 47, 130 187 50 10, tab1, hide     
  check    "", 48, 120 195 10 10, tab 1, hide                         
  text      "Queues", 49, 170 187 30 10, tab 1  
  list         50, 170 195 20 15, tab1                              
  text      "Channel Stats", 51, 205 187 40 7, tab 1        
  list       52, 205 195 20 15, tab 1                      
}
alias dOn { if ($dialog(dFserver != $null ) { return $true } | else { return $false } } 
alias queue.Myadd { queue.exists $1- | if ($result isnum) { return $result } | set -u0 %~queue-ac 0 | :start | inc %~queue-ac 1 | if (%Queue. [ $+ [ %~queue-ac ] ] == $null) { set %Queue. [ $+ [ %~queue-ac ] ] $1- | unset %~queue-ac | qmuMine } | else { goto start } }
alias queue.Mydel { if ($isnum($1) == $true) { set -u0 %~queue-dc $calc($1 - 1) | :start | inc %~queue-dc 1 | set %Queue. [ $+ [ %~queue-dc ] ] | if (%Queue. [ $+ [ $calc(%~queue-dc + 1) ] ] == $null) { unset %~queue-dc | qmuMine } | else { set %Queue. [ $+ [ %~queue-dc ] ] %Queue. [ $+ [ $calc(%~queue-dc + 1) ] ] | goto start } } }
alias qmuMine if ($dialog(dFserver) != $null) { did -r dFserver 201,204,206,209 | set %~qmu 0 | :start | inc %~qmu 1 | if (%Queue. [ $+ [ %~qmu ] ] == $null) { unset %~qmu  } | else { did -a dFserver 201 Queue $chr(35) $+ %~qmu | goto start } } 
alias qnu { if ($2 != $null) { set %~qnu 0 | :start | inc %~qnu 1 | if ($queue(%~qnu) == $null) { unset %~qnu | qmuMine } | else { if ($gettok($queue(%~qnu),2,32) == $1) { queue.rep %~qnu $gettok($queue(%~qnu),1,32) $2 $gettok($queue(%~qnu),3-,32) } | goto start } } }
alias checkForTransfers {  
  if ( $send(0) != 0 || $get(0) != 0 ) { .timerCheckForTransfers off | .timerFS 0 1 fserverAlias }
  if ( $dialog(dFserver) == $null ) { .timerCheckForTransfers off } | else { did -o dFserver 31 1 $fserv(0) +$ / +$ $vnum($r.set(Fserve,Max.Serve),4) } 
  if ( $gettok($r.set(Fserve,Channels),1,44) != All ) {
    did -ra dFserver 51 $gettok($r.set(Fserve,Channels),1,44)  
    did -ra dFserver 52 $nick($gettok($r.set(Fserve,Channels),1,44),0) 
  }
  else {
    did -ra dFserver 51 All Chans
    did -ra dFserver 52 n/a
  }
}
alias clearFserveWindow {
  .timerFS off         
  did -r dFserver 15 
  did -r dFserver 18 
  did -r dFserver 19 
  did -r dFserver 20 
  did -r dFserver 21  
  did -r dFserver 26
  did -r dFserver 27 
  did -r dFserver 28  
  did -r dFserver 29
  did -r dFserver 30
  did -r dFserver 17
  if ( $send(0) != 0 || $get(0) != 0 ) { .timerFS 0 1 fserverAlias }
}
alias fserverAlias {
  if ( $dialog(0) == 0 ) { .timerFS off }
  if (( $dialog(0) == 1) && ( $dialog(1) == dialogs)) { .timerFS off }
  if ( $send(0) == 0 && $get(0) == 0  ) { .timerFS off | clearFserveWindow | .timerCheckForTransfers 0 1 checkForTransfers }
  ; Set counter to number of sends
  set %countSends  $send(0) 
  if ( $send(0) != 0 ) {  
    if ( %countSendsHold != $send(0) || %countGetsHold != $get(0) ) {       
      set %countSendsHold $send(0) 
      set %countGetsHold $get(0) 
      clearFserveWindow
    }
    :loop   
    did -o dFserver 15 %countSends %countSends
    did -o dFserver 18 %countSends $send( %countSends )
    did -o dFserver 19 %countSends $send( %countSends ).file -->send
    did -o dFserver 20 %countSends $send( %countSends ).cps
    dde mIRC DDE Command $send( %countSends )        $send( %countSends ).file -->send      $send( %countSends ).cps      $send( %countSends ).pc
    did -o dFserver 21 %countSends $send( %countSends ).pc
    set %countSendsTotal $calc( %countSendsTotal + $send(%countSends).cps )
    dec %countSends
    if (%countSends > 0) goto loop
  }
  set %countGets $get(0)
  if ( $get(0) != 0  ) {
    :loops          
    did -o dFserver 26 %countGets %countGets
    did -o dFserver 27 %countGets $get( %countGets ) 
    did -o dFserver 28 %countGets $get( %countGets ).file <--get
    did -o dFserver 29 %countGets $get( %countGets ).cps
    did -o dFserver 30 %countGets $get( %countGets ).pc
    set %countGetsTotal $calc( %countGetsTotal + $get(%countGets ).cps )
    dec %countGets
    if (%countGets > 0) goto loops
  } 
  if ( $gettok($r.set(Fserve,Channels),1,44) != All ) {
    did -ra dFserver 51 $gettok($r.set(Fserve,Channels),1,44)  
    did -ra dFserver 52 $nick($gettok($r.set(Fserve,Channels),1,44),0) 
  }
  else {
    did -ra dFserver 51 All Chans
    did -ra dFserver 52 n/a
  }
  did -ra dFserver 50 $queue(0) $+ / $+ $r.set(Fserve, Max.Queues.Total)  
  did -ra dFserver 31  $fserv(0) $+ / $+ $vnum($r.set(Fserve,Max.Serve),4)
  did -ra dFserver 17  $calc(%countGetsTotal + %countSendsTotal)
  unset %countGetsTotal %countSendsTotal
}
on *:dialog:General:*:*:{
  if ($devent == sclick) {
    if ( $dialog(dFserver) != $null ) {
      if ( $did == 30 ) {
        if ($did($dname,30).state == 1) { did -ra dFserver 46 $r.set(Min.Cps, Rate) | did -c dFserver 48 } | else { did -ra dFserver 46 off | did -u dFserver 48 }
      }    
    }
  }
  if ($devent == edit ) {
    if ( $did == 32 ) { did -ra dFserver 46 $did($dname, 32).text }

  }
}

on *:dialog:Fserve:*:*:{
  if ( $dialog(dFserver) != $null ) {  
    if ($devent == edit ) {
      if ($did == 24) { did -ra dFserver 50 $did(dFserver, 201).lines $+ / $+ $did($dname, 24).text }
    }
  }
}
on *:dialog:Fserver:*:*:{
  if ( $devent == dclick ) {
    if ( $did == 15 ) {
      set %kickedNick $send($did($dname,15).sel)
      close -s %kickedNick 
      close -s %kickedNick 
      close -s %kickedNick
      did -i $dname 43 1 %kickedNick was kicked from the server
      unset %kickedNick
    }
  }
  if ( $devent == sclick ) {
    if ($did == 48 ) {
      if ($did($dname,48).state == 1) { 
        w.set Min.Cps Status On
        did -ra dFserver 46 $r.set(Min.Cps, Rate)  
      } 
      else {
        w.set Min.Cps Status Off 
        did -ra dFserver 46 off  
      }
    }
    if ($did == 45 ) { 
      clearFserveWindow
      did -r $dname 43
      if ( $r.set(Min.Cps,Status) == On ) { 
        did -ra $dname 46 $r.set(Min.Cps,Rate) 
      } 
      else { 
        did -o $dname 46 $r.set(Min.Cps,Status) 
      }      
    } 
    if ($did == 39) { .timer 1 0 queue.send | .timerquesendTemp 1 2 did -ra $dname 50 $did($dname, 201).lines $+ / $+ $r.set(Fserve, Max.Queues.Total) } 
  }   
  if ( $devent == edit ) {
    if ( $did == 46) {
      w.set Min.Cps Rate $did($dname, 46).text
    }
  }

  if ( $devent == init ) {   
    if ( $did == 0 ) {
      if ( $gettok($r.set(Fserve,Channels),1,44) != All ) {
        did -ra dFserver 51 $gettok($r.set(Fserve,Channels),1,44)  
        did -ra dFserver 52 $nick($gettok($r.set(Fserve,Channels),1,44),0) 
      }
      else {
        did -ra dFserver 51 All Chans
        did -ra dFserver 52 n/a
      } 
      set %countSendsHold $send(0) 
      set %countGetsHold $get(0) 
      fserverAlias 
      did -ra dFserver 50 $queue(0) $+ / $+ $r.set(Fserve, Max.Queues.Total)   
      if ( $r.set(Min.Cps, Status) == On ) { 
        did -a $dname 46 $r.set(Min.Cps,Rate)  
        did -ec $dname 48 
      } 
      else { 
        did -a $dname 46 $r.set(Min.Cps,Status)  
        did -eu $dname 48
      } 
      if (($r.set(Fserve,Banlist) == Empty) || ($r.set(Fserve,Banlist) == $null)) { } | else { dla $dname 301 $r.set(Fserve,Banlist) }
      did -o dFserver 31 1 $fserv(0) +$ / +$ $vnum($r.set(Fserve,Max.Serve),4)
      if ($r.set(Fserve,Status) == On   ) {
        if ( $timer(Fserve) != $null ) {           
          did -a dFserver 43 2001 is on with an ad delay of  $r.set(Fserve,Ad.Delay) minutes to $r.set(Fserve, Channels) 
        }
        else {  
          did -a dFserver 43 2001 is silently on with no ad, people can't access the fserve with triggers, queues will send
        }
      }
      if ($r.set(Fserve,Status) == Off ) {  
        did -i $dname 43 1 ShadowGold is not started 
      }
      did -a $dname 43  There are currently $send(0) $+ / $+ $r.set(Fserve, Max.Sends.Total ) send/s and $get(0) get/s in progress
    }
  }
}
on 1:FILESENT:*:if ($dialog(fileserver) != $null)  { clearFserveWindow }
on 1:FILERCVD:*:if ($dialog(fileserver) != $null)  { clearFserveWindow }
on 1:SENDFAIL:*:if ($dialog(fileserver) != $null)  { clearFserveWindow }
on 1:GETFAIL:*:if ($dialog(fileserver) != $null)  { clearFserveWindow  }
