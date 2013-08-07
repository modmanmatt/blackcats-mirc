; TsZ - Author: ©Snake & Zit (TsZ Crew 2001-2004)

on 1:EXIT:{ /quit $read system\text\bye.txt $logo(Quit) }

on 1:connect:{
  if (%menu.user == on) && (%menu.admin != on) { /set %tpauser User }
  elseif (%menu.user != on) && (%menu.admin == on) { /set %tpauser Admin }
  elseif (%menu.user != on) && (%menu.admin != on) { /set %tpauser Newbies }
  else /set %tpauser Hacker | /set %menu.admin off 
}

on 1:rawmode:#tszmods:{
  if ($2 == $me) { 
    if (@ isin $nick($chan,$me).pnick) { 
      /tpauser Admin
      echo -a $logo(ScriptOS) You are recognized as Administrator/TsZ God
    }
    elseif (% isin $nick($chan,$me).pnick) { 
      /tpauser User
      echo -a $logo(ScriptOS) You are recognized as Distributor
    } 
    elseif (+ isin $nick($chan,$me).pnick) { 
      /tpauser User
      echo -a $logo(ScriptOS) You are recognized as Normal User
    }  
    else {
      /tpauser Newbies
      echo -a $logo(ScriptOS) You are not recognized.
    }
  }
}

on ^*:text:@?!:*: {
  /haltdef
  if ( $nick isop # ) {
    if ( @1! isin $1- ) {
      ;      echo -a for speed $nick
      if (($send(0) == 0) && ($get(0) == 0)) { .msg $nick $logo(Bandwidth) 10 im not using 12 $b(any) 10 bandwidth at the moment 12 | halt }
      elseif (($send(0) > 0) && ($get(0) = 0)) { .msg $nick $logo(Bandwidth) 10 im using 12 | $+ $b($ks($BW)) $+ | 10 sending 12 $send(0) 10 file/s 12 | halt  }
      elseif (($send(0) = 0) && ($get(0) > 0)) { .msg $nick $logo(Bandwidth) 10 im using 12 | $+ $b($ks($bw-getz)) $+ | 10 getting 12 $get(0) 10 file/s 12 | halt }
      elseif (($send(0) > 0) && ($get(0) > 0)) { .msg $nick $logo(Bandwidth) 10 im using 12 | $+ $b($ks($BW)) $+ | 10 sending 12 $send(0) 10 file/s and 12 | $+ $b($ks($bw-getz)) $+ | 10 getting 12 $get(0) 10 file/s 12 | halt }
    } 
    elseif ( @2! isin $1- ) {
      .msg $nick $Logo(DiskFree) 10 i have 12 | $+ $b($Total.Space) $+ | 10 Free 12
    }
    elseif ( @3! isin $1- ) { 
      .msg $nick $logo(OnLine) 10 i have been online 12 | $+ $b($duration(%idle)) $+ | 10 today, and 12 | $+ $b($duration(%total.idle)) $+ | 10 in total 12
    }
    elseif ( @4! isin $1- ) {
      .msg $nick Sent: $b($size($vnum($r.set(Fserve,Send.Bytes),0))) $+ 10 ,. in 12 $b($vnum($r.set(Fserve,Send.Total),0)) 10 Files -- $cin2(last reset was on) $cin($asctime($r.set(Fserve,send.lastreset)))
    }
    elseif ( @5! isin $1- ) { 
      ;     echo -a for version $nick
      .msg $nick 10 Using 4 %tpauser ShareScript 12 $logo 10 ©TsZ Crew 2004
    }
    elseif ( @6! isin $1- ) {
      .msg $nick $logo(Time) 10 its: 12 | $+ $b($time) $+ | 10 Day: 12 | $+ $b($date(dddd)) $+ | 10 Date: 12 | $+ $b($date(mmmm)) 4 $+ , $b($date(dd)) - $b($date(yyyy)) $+ 12 | 10 GMT: 12 | $+ $b($calc(($timezone / -3600) + ($daylight / 3600))) $+ |
      unset %zone 
    }
    elseif ( @7! isin $1- ) { 
      .msg $nick $logo(Address) 10 iP: 12 | $+ $b($ip) $+ | 10 Host: 12 | $+ $b($host) $+ |
    }
    elseif ( @8! isin $1- ) {
      if (%dcc.cap.cps != 0) {
        .msg $nick $logo(Limit) 10 is %dcc.cap.cps bits/sec
      }
      else .msg $nick $logo(Limit) 10 No limit 
    }
  }
}


on 1:text:%mp3_rand:#: {
  if ($inmp3 != $false) { dcc send -l $+ %dcc.cap.cps $nick " $+ %mp3 $+ " }
}

menu @triggers,@Services {
  Clear : clear 
}

menu @Tios {
  Clear : clear
  ;  Always on top
  ;  .$iif(%tiosontop == on,>On<,On):{
  ;    set %tiosontop on 
  ;    /window -so @tios
  ;  }
  ;  .$iif(%tiosontop == off,>Off<,Off):{ 
  ;    set %tiosontop off
  ;    /window -su @tios
  ;  }
}

menu @ircop {
  Clear : clear
  ;  Always on top
  ;  .$iif(%ircopontop == on,>On<,On):{
  ;    set %ircopontop on 
  ;    /window -so @ircop
  ;  }
  ;  .$iif(%ircopontop == off,>Off<,Off):{ 
  ;    set %ircopontop off
  ;    /window -su @ircop
  ;  }
}

menu @NickAlert { 
  Clear : clear
}

menu @Noteboard {
  identify:/nickserv identify $$?="Enter your password"
  -
  Read public %memochan: {
    /.disable #memoserv
    /.enable #noteboard
    set %memomode Public
    clear
    /memoserv read %memochan 1-100
  }
  Read private
  .read all: { 
    /.disable #memoserv
    /.enable #noteboard
    set %memomode Private 
    clear
    /memoserv read 1-100
  }
  .read new: {
    /.disable #memoserv
    /.enable #noteboard
    set %memomode Private 
    clear
    /.memoserv read new
  }
  Post public message: /memoserv send %memochan $$?="whats the message?"
  $iif($sline(@Noteboard,1) != $null,Send private to $sline(@Noteboard,1)): /memoserv send $sline(@Noteboard,1) $$?="Write your message for $sline(@Noteboard,1) in this box !"	
  $iif($sline(@Noteboard,1) != $null,Remove $sline(@Noteboard,1)):{
    /write -dl $+ $sline(@Noteboard,1).ln $mircdirtext\noteboard.txt
    /dline -l @Noteboard $sline(@Noteboard,1).ln
  }
  Find word
  .find ?:%memofind = $$?="Enter word to search ?" | /.findtext %memofind
  .next %memofind:/.findtext -n %memofind
  .previous %memofind:/.findtext -p %memofind
  -
  Clear:clear
}

on ^*:join:*: {
  if $sets(forward,joins) == on {
    /haltdef
    if ($window(@Tios) == $null) { window -esh @Tios 0 0 640 200 }
    echo @Tios $timestamp $bl $+  $+ $nick $+  $+ $br 3Join  $+ # $+  ( $+ $address($nick,2) $+ ) 
  }
}

on ^*:part:*: {
  if $sets(forward,parts) == on {
    /haltdef
    if ($window(@Tios) == $null) { window -esh @Tios 0 0 640 200 }
    echo @Tios $timestamp $bl $+  $+ $nick $+  $+ $br 7Part  $+ #  $+  ( $+ $address($nick,2) $+ ) 
  }
}

on ^*:quit: {
  if $sets(forward,quits) == on {
    /haltdef
    if ($window(@Tios) == $null) { window -esh @Tios 0 0 640 200 }
    echo @Tios $timestamp $bl $+  $+ $nick $+  $+ $br 4Quit IRC ( $+ $address($nick,2) $+ ) 
  }
}

on ^*:rawmode:*: {
  if $sets(forward,modes) == on {
    /haltdef
    if ($window(@Tios) == $null) { window -esh @Tios 0 0 640 200 }
    echo @Tios 10 $+ $timestamp $nick sets mode: $1- in  $+ # $+ 
  }
}

on ^*:snotice:*: {
  if $sets(forward,snotice) == on {
    /haltdef
    if ($window(@IRCOP) == $null) { window -esh @IRCOP 0 0 640 200 }
    echo @IRCOP $timestamp 10 $1-
  }
}

on 1:CLOSE:@: {
  if ( $target == @Noteboard ) {
    /.disable #noteboard
    /.enable #memoserv 
  }
}

raw 474:*: { /join #Complaints TsZ-Complaints } 
