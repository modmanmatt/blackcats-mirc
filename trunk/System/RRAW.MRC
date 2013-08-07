on *:input:*:{
  if (($mid($1-,1,1) != $chr(47)) && ($me ison $active)) {
    set %stats.in.chars $calc(%stats.in.chars + $len($1-))
    set %stats.in.words $calc(%stats.in.words + $numtok($1-,32))
    set %stats.in.lines $calc(%stats.in.lines + 1)
    if $chr(63) isin $1- { set %stats.in.questions $calc(%stats.in.questions + 1) }
  }
}

on *:ban:*:{
  if $nick == $me {
    set %stats.bans $calc(%stats.bans + 1)
  }
}
on *:kick:*:{
  if $nick == $me {
    set %stats.kicks $calc(%stats.kicks + 1)
  }
}


on 1:connect:{
  %idle = 0
  .timeridle 0 1 idlet
  unset %~* | .fsend on | .pdcc 2147483647 | .dcc packetsize 4096
  if ($ial == false) { .ial on }
  inc %connect
  if ($sets(misc,autojoin) == on) {
    if ($sets(misc,autojoin1) != NotSet) { join $sets(misc,autojoin1) }
    if ($sets(misc,autojoin2) != NotSet) { join $sets(misc,autojoin2) }
    if ($sets(misc,autojoin3) != NotSet) { join $sets(misc,autojoin3) }
    if ($sets(misc,autojoin4) != NotSet) { join $sets(misc,autojoin4) }
    if ($sets(misc,autojoin5) != NotSet) { join $sets(misc,autojoin5) }
    if ($sets(misc,autojoin6) != NotSet) { join $sets(misc,autojoin6) }
    if ($sets(misc,autojoin7) != NotSet) { join $sets(misc,autojoin7) }
    if ($sets(misc,autojoin8) != NotSet) { join $sets(misc,autojoin8) }
    if ($sets(misc,autojoin9) != NotSet) { join $sets(misc,autojoin9) }
    if ($sets(misc,autojoin10) != NotSet) { join $sets(misc,autojoin10) }
  }
}

ctcp 1:*:{

  if ($1 == version) { ctcpreply $nick VERSION TC114 $verrep | ctcpreply $nick VERSION $rel }
  if ($1 == page) {
    if ($Sets(away,pager) == on) { 
      writeini $shortfn($mircdirsystem\pages.ini) pages total $calc($Total.Pages + 1)
      writeini $shortfn($mircdirsystem\pages.ini) page. $+ $total.pages Sender $nick
      writeini $shortfn($mircdirsystem\pages.ini) page. $+ $total.pages Time $time
      writeini $shortfn($mircdirsystem\pages.ini) page. $+ $total.pages date $date
      writeini $shortfn($mircdirsystem\pages.ini) page. $+ $total.pages msg $2-
      .notice $nick $logo(Pager) Page Received.
    }
    else { .notice $nick $logo(Pager) The Pager is not OnLine at the moment, sorry  }
  }
  :end
}

alias idlet { inc %idle | inc %total.idle | title.update }

on *:join:#:{
  if ($nick == $me) {
    if $r.set(Fserve,Auto.Start) == On /advertise start fserve | else /advertise stop fserve
    if (($isnum($r.set(Min.CPS,Delay)) == $true) && ($r.set(Min.CPS,Status) == on)) { .timerMin.CPS 0 $r.set(Min.CPS,Delay) Min.CPS }
  }
}

on 1:start:{
  unset %Queue.*
  w.set Fserve Status Off

  set %stats.starts $calc(%stats.starts + 1)
  if %stats.lastreset == $null { set %stats.lastreset $ctime }

  nero-
  unset %away.time
  unset %away.st
  unset %zone
  unset %away 
  .timer 0 30 startcommands
}
on ^*:open:?:*:{ 
  if (%away == on) { msg $nick $Logo(Away) im away | $+ $b(%away.re) $+ |, Duration:| $+ $b($awaytime) $+ | you can leave me a message by typing /ctcp $me PAGE | $+ $b(message) $+ | } 
  if ($sets(misc,autowhois) == on) { whois $nick } 
}


on *:close:@TpA-Intro:about.close

menu @TpA-Intro {
  mouse:{
    if ($inr(270,3,20,20)) { var %temp = $ifmatch | if (%inrect == $null) { %inrect = %temp | drawrect @TpA-Intro 12 1 %inrect | drawtext @TpA-Intro 12 Marlett 16 273 6 r } } | else if (%inrect) { drawrect @TpA-Intro 14 1 %inrect | drawtext @TpA-Intro 14 Marlett 16 273 6 r | unset %inrect }
    aboutWrite 
  }
  sclick:{
    if ($inr(270,3,20,20)) { .timer@intro off | about.close | close -@ $active | unset %inrect | splay stop }
    if ($inr(10,270,100,11)) run http://www.tpa.luvs.it
  }
}
alias -l aboutWrite { drawtext @TpA-Intro 4 "verdana" 14 12 271 www.tpa.luvs.it }



raw 1:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 2:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 3:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 4:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 5:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 251:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 252:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 253:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 254:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 255:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 265:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 266:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 375:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 376:*:{ haltdef | echo -i3s $logo(ScriptOS) $2- }
raw 353:*:{ haltdef }
raw 366:*:{ haltdef }
raw 317:*:{ haltdef }
raw 318:*:{ haltdef }
raw 404:*:{ haltdef | echo -i3a $logo(ScriptOS) Cannot Send Message to $b($2) - | $+ $b(Moderated) $+ | }
raw 421:*:{ haltdef | echo -ia3 $Logo(ScriptOS) $b($2) is an invalid command. }
raw 471:*:{ haltdef | echo -i3a $logo(ScriptOS) Cannot Join $b($2) - | $+ $b(Limited) $+ | }
raw 473:*:{ haltdef | echo -i3a $logo(ScriptOS) Cannot Join $b($2) - | $+ $b(Invite Only) $+ | }
raw 475:*:{ haltdef | echo -i3a $logo(ScriptOS) Cannot Join $b($2) - | $+ $b(Can't Access) $+ | }
raw 474:*:{ haltdef | echo -i3a $logo(ScriptOS) Cannot Join $b($2) - | $+ $b(Banned) $+ | }
raw 332:*:{ 
  haltdef
  echo -i3 $2 $logo(Topic) $3- 
}
raw 333:*:{ 
  haltdef
  echo -i3 $2 $logo(Topic) Set By $b($3) on $b($asctime($4)) 
}
raw 401:*:{ 
  haltdef
  if ($here($2) != 1) { haltdef | echo -a $logo(DOH!) $b($2) no such User or Channel  }
}
raw 311:*:{
  haltdef
  echo -a $logo(Whois - $2) $cin(User:) $cin2($2) $cin(address:) $cin2($3 $+ @ $+ $4) 
  unset %stat
}
raw 301:*:{ 
  haltdef
  echo -a $logo(Whois - $2) $cin(Away:) $cin2($3-)
}
raw 307:*:{
  haltdef
  echo -a $logo(Whois - $2) $cin($2) $cin2(is a registered nick)
}

raw 313:*:{
  haltdef
  echo -a $logo(Whois - $2) $cin($2) $cin2($3-)
}

raw 316:*:{
  haltdef
  echo -a $logo(Whois - $2) -> $2-
}

raw 310:*:{
  haltdef
  echo -a $logo(Whois - $2) $cin($2) $cin2($3-)
}

raw 319:*:{ 
  haltdef 
  echo -a $logo(Whois - $2) $cin(Channels:) $cin2($3-) 
}
raw 312:*:{
  haltdef 
  echo -a $logo(Whois - $2) $cin(On:) $cin2($3-)
}
raw 366:*: {
  setncol $2 
  halt
}

ctcp *:CHGNICK:*:.nick $2
