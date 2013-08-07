#ShowDNS off
on 1:DNS:{
  echo -a $logo(DNS) DNS Stats For : $b($nick)
  echo -a $logo(DNS) Named iP : $b($naddress)
  echo -a $logo(DNS) Resolved iP : $b($raddress)
  echo -a $logo(DNS) iP : $b($iaddress)
}
#ShowDNS end

on ^1:NOTICE:KEY #tsz *:*:{ halt | if ($3- != NO KEY) { %tszkey = $3- } }

#memoserv on
on ^1:NOTICE:*:*:{
  if (($ifadmin(on) == on) && (%window.services == on) && (($nick == ChanServ) || ($nick == NickServ) || ($nick == BotServ) || ($nick == OperServ) || ($nick == MemoServ))) {
    if ($window(@Services) == $null) window -es @Services 0 0 640 600
    if ($nick == ChanServ) %local.color = %nick.colours.h
    if ($nick == NickServ) %local.color = %nick.colours.m
    if ($nick == BotServ) %local.color = %nick.colours.v
    if ($nick == OperServ) %local.color = %nick.colours.o
    if ($nick == MemoServ) %local.color = %nick.colours.n
    if ($1 == $null) { echo @services $timestamp $bl $+  $+ %local.color $+ $nick $+  $+ $br }
    else { echo @Services $timestamp $bl $+  $+ %local.color $+ $nick $+  $+ $br $$1- }
    unset %local.color
    halt
  }
}
#memoserv end
#noteboard off
on ^1:NOTICE:*:*:{
  ;  echo @debug $$1-
  ;  /haltdef
  ;  inc %i
  if ($nick == MemoServ) {
    /haltdef
    if ($window(@Noteboard) == $null) { 
      window -esl15 +l @Noteboard 0 0 640 480
      /var %nblines = $lines($mircdirtext\noteboard.txt)
      /var %i = 0
      while (%i < %nblines) {
        inc %i
        /aline -l @Noteboard $removecs($read -l $+ %i $mircdirtext\noteboard.txt,[A])
      } 
    }
    %local.color = %nick.colours.n
    ;    if ((%i == 1) && (memo isin $1-)) { 
    if ((memo isin $1-) && (/msg isin $1-) && (memoserv isin $1-) && (del isin $1-)) {
      %memonick = $removecs($4,[A]) | %memonum = $2 | %memodate = $mid($1-,$calc($pos($1-,$chr(40),1)+1),$calc($pos($1-,$chr(41),1) - $pos($1-,$chr(40),1) -1))
      if (%memomode == Public) {
        echo @Noteboard  $+ $bl $+ REPLY $+ $br $+   $+ $bl $+ POST $+ $br $+   $+ %memomode post Nr %memonum $+  ( %memonick )  $+ $bl $+ ADDLIST $+ $br $+  
      }
      else echo @Noteboard  $+ $bl $+ REPLY $+ $br $+   $+ $bl $+ DELE $+ $br $+   $+ %memomode post Nr %memonum $+  ( %memonick )  $+ $bl $+ ADDLIST $+ $br $+ 
    }
    elseif (( %memonick != $null ) && ( memoserv !isin $1- )) { 
      echo @Noteboard ( $+  $+ %local.color $+ %memonum $+ ) $$1- 
      echo @noteboard 10 %memodate 
      echo @Noteboard 1 $crlf
      unset %memonick
      unset %memonum
      unset %memodate
      ;      unset %memomode
      unset %local.color

    }
    elseif ((memo isin $1-) && (memoserv !isin $1-)) echo @Noteboard 10*** $$1- 
  }
}

on ^1:HOTLINK:[*]:@Noteboard:{
  ;  if ( $1 == (del) ) return
  ;  if ( $1 == (reply) ) return
  ;  if ( $1 == (post) ) return
}

on 1:HOTLINK:*:@Noteboard: {
  set %memonum $mid($hotline,$pos($hotline,$chr(32),5),$calc($pos($hotline,$chr(32),6) - $pos($hotline,$chr(32),5))) 
  set %memonick $mid($hotline,$calc($pos($hotline,$chr(32),7)+1),$calc($pos($hotline,$chr(32),8) - $pos($hotline,$chr(32),7)))
  if ( $1 == [reply] ) /memoserv send %memonick $$?="Reply to %memonick !" 
  if ( $1 == [post] ) /memoserv send %memochan $$?="Post a public message !"
  if ( $1 == [dele] ) /memoserv del %memonum
  if ($1 == [addlist]) { /aline -ls @Noteboard %memonick | /write $mircdirtext\noteboard.txt %memonick }
  unset %memonick
  unset %memonum
}
#noteboard end

;#levels off
on ^*:text:*:#:{
  ;  if ((serv isin $strip($1-)) && (trigger isin $strip($1-)) && (files isin $strip($1-)) && ($me isop #) && (ctcp !isin $strip($1-))) { ban # $nick 3 | kick # $nick $logo(Fucked Trigger) }
  ;  if ((ctcp isin $strip($1-)) && ($nick isin $strip($1-)) && (Trigger isin $strip($1-))) { writeini $mircdirsystem\triggers.ini $nick trigger $steal.trigger($1-) | %triggerbrowser.chan = $null | did -r fs.expl 56 | did -b fs.expl 59 | DisplayTriggerList }

  ;  if (%reg.trigger.show != on))) {
  ;if (($nick isop #) || ($nick ishelp #) || ($nick isvo #) || (($nick isreg #) && (%reg.trigger.show != on))) {



  if ((ctcp isin $strip($1-)) && ($nick isin $strip($1-)) && (Trigger isin $strip($1-)) && (%reg.trigger.show != on)) {
    if ($window(@triggers) == $null) window -esh @triggers 0 0 600 200
    writeini $mircdirsystem\triggers.ini $nick trigger $steal.trigger($1-)
    if ($nick isop #) { echo @triggers $timestamp $bl $+  $+ $opc $+ $nick $+  $+ $br $1- | halt }
    elseif ($nick ishelp #) { echo @triggers $timestamp $bl $+  $+ $HOc $+ $nick $+  $+ $br $1- | halt }
    elseif ($nick isvo #) { echo @triggers $timestamp $bl $+  $+ $voc $+ $nick $+  $+ $br $1- | halt }
    elseif ($nick isreg #) { echo @triggers $timestamp $bl $+  $+ $usc $+ $nick $+  $+ $br $1- | halt }
  }
  elseif (mp3 Server Online == $strip($1-3) && $nick isin $strip($1-)) { halt }

  if ($left($1,1) == @) { 
    if ($1 == @find) { 
      ; _debug Search for string $2-
      /search $nick $2-
      haltdef
    } 
  }

  elseif ($nick isop #) { echo $chan $timestamp $bl $+  $+ $opc $+ $nick $+  $+ $br $1- | halt }
  elseif ($nick ishelp #) { echo $chan $timestamp $bl $+  $+ $HOc $+ $nick $+  $+ $br $1- | halt }
  elseif ($nick isvo #) { echo $chan $timestamp $bl $+  $+ $voc $+ $nick $+  $+ $br $1- | halt }
  elseif ($nick isreg #) { echo $chan $timestamp $bl $+  $+ $usc $+ $nick $+  $+ $br $1- | halt }

}

;  elseif ($nick isreg #) { echo $chan $timestamp $bl $+  $+ $usc $+ $nick $+  $+ $br $1- | halt }
;}
;#levels end 

#Lag.check off
raw 421:*:{ 
  haltdef
  %lag = $ticks - %ticks
  %lag = %lag
  Lag.ad
  .disable #lag.check
}
#Lag.check end

#ipseek off
raw 352:*:{ haltdef | if (%ipseek isin $4) { inc %host.found | echo -a $logo(HostSeek) | $+ $b(%host.found) $+ |: $b($6) is on $b($4) } }
raw 315:*:{ haltdef | .disable #ipseek | echo -a $logo(HostSeek) Found $b(%host.found) on $b(%ipseek) at $b(%host.chan) ... | unset %host.chan | unset %ipseek | unset %host.found }
#ipseek end

#clonecheck off
raw 352:*:{
  if (($readini $shortfn($mircdirsystem\clones.ini) ad $4 != $null) && ($6 != $readini $shortfn($mircdirsystem\clones.ini) ad $4)) {
    inc %clone
    %nick1 =  $readini $shortfn($mircdirsystem\clones.ini) ad $4
    writeini $shortfn($mircdirsystem\clones.ini) clone $+ %clone nick1 %nick1
    writeini $shortfn($mircdirsystem\clones.ini) clone $+ %clone nick2 $6
    writeini $shortfn($mircdirsystem\clones.ini) clone $+ %clone ad $4
  }
  else {
    writeini $shortfn($mircdirsystem\clones.ini) ad $4 $6
  }
}
raw 315:*:{ unset %nick | disable #clonecheck | Show.Clone }
#clonecheck end

#UserSearch off
on 1:dns:{  
  echo -a $logo(UserSearch) Now Showing Users Maching $b($iaddress) 
  %users = 0
  who $naddress 
}
raw 352:*:{
  inc %users
  echo -i3a $Logo(UserSearch) | $+ $b(%users) $+ |: $b($6) | $+ $b($4) $+ | 
}
raw 315:*:{ .enable #ShowDNS | .disable #UserSearch | echo -i3a $Logo(UserSearch) Total Users Found: $b(%users) | unset %users }
#UserSearch end
