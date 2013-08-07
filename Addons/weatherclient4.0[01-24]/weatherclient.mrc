on *:load: {
  if ($version != 6.16) {
  if (!$input(Weather client $wc.ver is only tested for mIRC 6.16.  You are using mIRC $version $+ .  Load anyway?,yq,Weather client $wc.ver)) { unload -rs $+(",$script,") } }
  echo -aci1 info * /weather: Weather client $wc.ver loaded
}

alias wconfig { weather $+(-config:,$1-) }
dialog wconfig {
  title "Weather client setup"
  size -1 -1 177 145
  option dbu
  button "Ok", 1, 97 131 37 12, default ok
  button "Cancel", 2, 137 131 37 12, cancel
  tab "General", 3, 2 2 172 125
  radio "English Imperial", 4, 21 30 47 10, tab 3
  radio "Metric", 5, 76 30 26 10, tab 3
  radio "Both", 6, 133 30 23 10, tab 3
  check "Suppress default display when using -signal.", 7, 21 78 125 10, tab 3
  check "Enable network logging", 8, 21 105 65 10, tab 3
  box "Units", 9, 15 20 146 24, tab 3
  text "When using the -signal flag, it is possible to suppress the default local output.", 10, 21 57 140 15, tab 3
  box "Logging", 11, 15 95 146 24, tab 3
  box "Signal event", 12, 15 48 146 43, tab 3
  tab "Bot", 13
  check "Reply by msg", 14, 21 38 44 10, tab 13
  check "Reply by notice", 15, 21 47 47 10, tab 13
  check "Hide requests/replies", 16, 21 56 60 10, tab 13
  check "Allow in channels", 17, 21 71 53 10, tab 13
  check "Allow in queries", 18, 21 80 48 10, tab 13
  list 19, 99 29 59 44, tab 13 size
  edit "", 20, 39 23 44 11, tab 13
  text "Trigger:", 21, 20 25 19 8, tab 13
  box "Ignore these channels:", 22, 96 20 65 71, tab 13
  button "Add", 23, 100 75 28 12, tab 13
  button "Del", 24, 130 75 28 12, tab 13
  text "Allow", 25, 22 105 13 8, tab 13
  edit "", 26, 36 103 21 11, tab 13 center
  text "requests every", 27, 59 105 35 8, tab 13
  edit "", 28, 95 103 21 11, tab 13 center
  text "seconds.", 29, 118 105 25 8, tab 13
  box "Spam/Flood control", 30, 15 93 146 26, tab 13
  tab "Proxy", 31
  check "Use HTTP proxy", 32, 29 26 53 10, tab 31
  box "Proxy-Authorization: Basic", 33, 30 71 116 48, tab 31
  text "Hostname:", 34, 47 47 26 8, tab 31
  edit "", 35, 75 44 63 11, tab 31
  text "Port:", 36, 62 59 11 8, tab 31
  edit "", 37, 75 56 26 11, tab 31
  text "User ID:", 38, 55 89 20 8, tab 31
  edit "", 39, 75 86 52 11, tab 31
  text "Password:", 40, 50 101 25 8, tab 31
  edit "", 41, 75 98 52 11, tab 31 pass
  tab "Display", 42
  edit "", 43, 15 23 146 83, tab 42 multi return hsbar vsbar
  text "", 44, 15 113 40 8, tab 42
  button "Property reference", 45, 110 111 51 12, tab 42
  ;tab "Updates", 46
  ;box "", 47, -1 -2 180 180
  ;menu "&Menu", 48
}


on *:dialog:wconfig:init:0 {
  did -c $dname $replace($wc.units,i,4,m,5,b,6)
  did $iif($wc.sighalt,-c,-u) $dname 7
  did $iif($wc.socklog,-c,-u) $dname 8

  if ($wc.trigger) did -ra $dname 20 $v1
  did $iif($istok($wc.sendtype,text,44),-c,-u) $dname 14
  did $iif($istok($wc.sendtype,notice,44),-c,-u) $dname 15
  did $iif($wc.silent,-c,-u) $dname 16
  did $iif($wc.chan,-c,-u) $dname 17
  did $iif($wc.query,-c,-u) $dname 18
  tokenize 44 $wc.bchans
  var %wc $0
  while (%wc > 1) { did -a $dname 19 $($+($,%wc),2) | dec %wc }
  if ($gettok($wc.maxcon,1,32)) did -ra $dname 26 $v1 | set %wc.wconfig.26 $v1
  did -ra $dname 27 $iif($gettok($wc.maxcon,1,32) != 1,requests,request) every
  if ($gettok($wc.maxcon,2,32)) did -ra $dname 28 $v1 | set %wc.wconfig.28 $v1
  did -ra $dname 29 $+(second,$iif($gettok($wc.maxcon,2,32) != 1,s),.)

  did $iif($wc.proxy,-c,-u) $dname 32
  if ($gettok($wc.proxaddr,1,32)) did -ra $dname 35 $v1
  if ($gettok($wc.proxaddr,2,32)) did -ra $dname 37 $v1 | set %wc.wconfig.37 $v1
  if ($gettok($decode($gettok($wc.proxaddr,3,32),m),1,58)) did -ra $dname 39 $v1
  if ($gettok($decode($gettok($wc.proxaddr,3,32),m),2,58)) did -ra $dname 41 $v1

  var %wc 1
  while (%wc <= $ini($wc.ini,output,0)) {
    did -a $dname 43 $replace($readini($wc.ini,n,output,$+(n,%wc)),<b>,,<u>,,<r>,,<k>,,<o>,) $+ $iif(%wc != $ini($wc.ini,output,0),$crlf)
    inc %wc
  }
  did -a $dname 44 Lines: $did($dname,43).lines
}

on *:dialog:wconfig:edit:*: {
  if ($did == 26) {
    wc.enum $dname 26 $did($dname,26)
    did -ra $dname 27 $iif($did($dname,26) != 1 && $v1 isnum,requests,request) every
  }
  if ($did == 28) {
    wc.enum $dname 28 $did($dname,28)
    did -ra $dname 29 $+(second,$iif($did($dname,28) != 1 && $v1 isnum,s),.)
  }
  if ($did == 37) { if (!$did($dname,37)) { set %wc.wconfig.37 } | wc.enum $dname 37 $did($dname,37) }
  if ($did == 43) { if (%wc.wconfig.44 != $did($dname,43).lines) { did -ra $dname 44 Lines: $did($dname,43).lines } | set %wc.wconfig.44 $did($dname,43).lines }
}

on *:dialog:wconfig:dclick:*: { if ($did == 19) { .timerwc -m 1 1 did -o $dname 19 $did($dname,19).sel $$input(Channel name:,ueq,Edit channel,$did($dname,19).seltext) } }

on *:dialog:wconfig:sclick:*: {
  if ($did == 1) {
    wc.units $+($iif($did($dname,4).state,i),$iif($did($dname,5).state,m),$iif($did($dname,6).state,b))
    wc.sighalt $did($dname,7).state
    wc.socklog $did($dname,8).state
    wc.trigger $iif($did($dname,20).text,$v1,!weather)
    wc.sendtype $iif($did($dname,14).state,-a,-d) text
    wc.sendtype $iif($did($dname,15).state,-a,-d) notice
    wc.silent $did($dname,16).state
    wc.chan $did($dname,17).state
    wc.query $did($dname,18).state
    var %wc $did($dname,19).lines
    writeini $wc.ini settings bchans -
    while (%wc) { wc.bchans -a $did($dname,19,%wc) | dec %wc }
    wc.maxcon $did($dname,26) $did($dname,28)
    wc.proxy $iif($did($dname,32).state && $did($dname,35).text && $did($dname,37).text,1,0)
    wc.proxaddr $iif($did($dname,35).text && $did($dname,37).text,$did($dname,35).text $did($dname,37).text,$($chr(32),0) $($chr(32),0)) $iif($did($dname,35).text && $did($dname,37).text && $did($dname,39).text && $did($dname,41).text,$did($dname,39).text $did($dname,41).text)

    remini $wc.ini output
    var %wc 1
    while (%wc <= $did($dname,43).lines) {
      if ($did($dname,43,%wc)) { writeini $wc.ini output $+(n,%wc) $replace($v1,,<b>,,<u>,,<r>,,<k>,,<o>) }
      inc %wc
    }
    unset %wc.wconfig.*
  }
  if ($did == 2) { unset %wc.wconfig.* }
  if ($did == 23) { .timerwc -m 1 1 did -a $dname 19 $$input(Channel name:,ueq,Add channel) }
  if ($did == 24) { var %wc.wconfig.19 $$did($dname,19).sel | did -d $dname 19 %wc.wconfig.19 | did -c $dname 19 $iif($calc(%wc.wconfig.19 - 1),$v1,1) }
  if ($did == 45) { .timerwc -m 1 1 return $$input($+($str($chr(32),100),$wc.pr1,$wc.pr2,$wc.pr3),oui,Property reference for $($wc($1,N),0)) }
}

menu status,channel,menubar {
  Addons
  .Weather client $wc.ver $+ $chr(9) $+ /weather
  ..Check weather: weather $$input(Search by 'city $+ $chr(44) state'. $crlf $+ Or $+ $chr(44) use '-s 5-digit INTL station ID'.,ueq,Weather client $wc.ver)
  ..View readme: $iif($isfile($scriptdirreadme-weather.txt),run $scriptdirreadme-weather.txt,return $input($scriptdirreadme-weather.txt is missing.,oh,File not found))
  ..-
  ..Options
  ...General...: wconfig
  ...Bot...: wconfig bot
  ...Proxy...: wconfig proxy
  ...Display...: wconfig display
  ...-
  ...Uninstall: if ($$input(Do you want to unload Weather client $wc.ver $+ ?,yw,Unload)) { unset %w.* | unload -rs $+(",$script,") }
}

menu @wc.* {
  Save as: savebuf $active $$sfile($+(",$scriptdir,$right($active,-1),.log"),Save as,Save)
  Close: window -c $active
}

alias weather {
  :verytop
  if ($isid) { return $wc.localwthr }
  if (!$1-) && ($wc.localwthr) && (!%wc.trigger) { tokenize 32 $wc.localwthr }
  var %wc.str $1-
  :top
  var %wc.d $0
  while (%wc.d) {
    if ($($+($,%wc.d),2) == -i) { var %wc.u i | tokenize 32 $remtok($1-,$v1,32) | goto top }
    if ($($+($,%wc.d),2) == -m) { var %wc.u m | tokenize 32 $remtok($1-,$v1,32) | goto top }
    if ($($+($,%wc.d),2) == -b) { var %wc.u b | tokenize 32 $remtok($1-,$v1,32) | goto top }
    if ($($+($,%wc.d),2) == -s) { var %wc.p s | tokenize 32 $remtok($1-,$v1,32) | goto top }
    if (!%wc.trigger) {
      if ($($+($,%wc.d),2) == -d) { tokenize 32 $remtok($1-,$v1,32) | wc.localwthr $remtok(%wc.str,$v1,32) | if (!$remtok(%wc.str,-d,32)) { echo -ac info * /weather: unset default string | return } | goto top }
      if ($gettok($($+($,%wc.d),2),1,58) == -signal) { set %wc.s.tmp 1 $iif($numtok($($+($,%wc.d),2),58) > 1,$gettok($($+($,%wc.d),2),2,58)) | var %wc.s %wc.s.tmp | unset %wc.s.tmp | tokenize 32 $remtok($1-,$($+($,%wc.d),2),32) | goto top }
      if ($gettok($($+($,%wc.d),2),1,58) == -config) { var %wc.cfg 1 | if (!$dialog(wconfig)) { dialog -md wconfig wconfig } | dialog -v wconfig | if ($istok(general.bot.proxy.display,$gettok($($+($,%wc.d),2),2,58),46)) { did -f wconfig $replace($gettok($($+($,%wc.d),2),2,58),general,4,bot,13,proxy,31,display,42) } | tokenize 32 $remtok($1-,$($+($,%wc.d),2),32) | goto top }
    }
    dec %wc.d
  }
  if ($1) {
    var %wc $ticks
    set $+(%,wc.,%wc,.settings) $+($iif(%wc.u,$v1,$wc.units),$chr(44),$iif(%wc.p,$v1,n),$chr(44),$iif(%wc.trigger,$v1,- - -),$chr(44),$iif(%wc.s,1,0) $iif($gettok(%wc.s,2,32),$v1),$chr(44),$w.url($1-))
    sockopen $+(wc.,%wc,.) $iif($wc.proxy && $wc.proxaddr,$wc.proxaddr,mobile.wunderground.com 80)
  }
  if (!$1) && (!%wc.cfg) {
    if ($wc.localwthr) { tokenize 32 %wc.str $wc.localwthr | goto verytop }
    if (!$wc.localwthr) { echo -ac info * /weather: insufficient parameters }
  }
  if (%wc.trigger) { if (!$timer(wc.maxcon)) { .timerwc.maxcon -o 1 $gettok($wc.maxcon,2,32) wc.mxc } | unset %wc.trigger }
}

on ^*:open:?:*: { tokenize 32 $strip($1-) | wc.trig text $iif($chan,$v1,$nick) $nick $1 $$2- | if (%wc) { unset %wc | haltdef } }
on ^*:text:*:*: { tokenize 32 $strip($1-) | wc.trig $event $iif($chan,$v1,$nick) $nick $1 $$2- | if (%wc) { unset %wc | haltdef } }
on ^*:notice:*:*: { tokenize 32 $strip($1-) | wc.trig $event $iif($chan,$v1,$nick) $nick $1 $$2- | if (%wc) { unset %wc | haltdef } }

alias wc.trig {
  if ($istok($wc.sendtype,$1,44)) && ($strip($remove($4,$chr(32)),burco) == $wc.trigger) && ($var(%wc.*.settings,0) < $gettok($wc.maxcon,1,32)) {
    if ($2 !ischan) && (!$wc.query) { return }
    if ($2 ischan) && (!$wc.chan) || ($istok($wc.bchans,$2,44)) { return }
    set %wc.trigger $+($iif($wc.silent,.),$replace($1,text,msg,action,describe)) $2 $3
    weather $5-
    if ($wc.silent) { set %wc 1 }
  }
}

alias -l wc.pr1 { return $+(Property,$str($chr(9),3),Value,$crlf,$crlf,ci,$str($chr(9),3),city,$crlf,up,$str($chr(9),3),update time,$crlf,ob,$str($chr(9),3),observation station,$crlf,conditions,$str($chr(9),2),conditions,$crlf,temperature,$str($chr(9),2),temperature,$crlf,windchill,$str($chr(9),2),windchill,$crlf,visibility,$str($chr(9),3),visibility,$crlf,uv,$str($chr(9),3),uv,$crlf,wind,$str($chr(9),3),wind,$crlf,humidity,$str($chr(9),3),humidity,$crlf,dewpoint,$str($chr(9),2),dewpoint) }
alias -l wc.pr2 { return $+($crlf,pressure,$str($chr(9),2),pressure,$crlf,clouds,$str($chr(9),3),clouds,$crlf,yesterdaysmaximum,$chr(9),yesterday's max temperature,$crlf,yesterdaysminimum,$chr(9),yesterday's min temperature,$crlf,dd,$str($chr(9),3),yesterday's heating/cooling,$crlf,$str($chr(9),3),degree days,$crlf,ddv,$str($chr(9),3),degree day value,$crlf,sunrise,$str($chr(9),3),sunrise,$crlf,sunset,$str($chr(9),3),sunset,$crlf,moonrise,$str($chr(9),2),moonrise) }
alias -l wc.pr3 { return $+($crlf,moonset,$str($chr(9),2),moonset,$crlf,moonphase,$str($chr(9),2),moonphase,$crlf,nick,$str($chr(9),3),user's nickname,$crlf,fcu,$str($chr(9),3),forecast update time,$crlf,fcd,$str($chr(9),3),forecast day N,$crlf,fci,$str($chr(9),3),forecast info for day N,$crlf,alert,$str($chr(9),3),severe weather alert,$crlf,$crlf,Example: $($wc($1).temperature,0) returns the temperature.,$crlf,'N' is only used for forecasts.) }
;alias wc.enum { tokenize 32 $1 $2 $3 | if ($3 isnum) && (. !isin $3) && ($left($3,1) != 0) { set $+(%,wc.,$1,.,$2) $3 } | did -ra $1-2 $($+(%,wc.,$1,.,$2),2) }
alias wc.enum { tokenize 32 $1- | if ($3- isnum) && (. !isin $3-) && ($left($3-,1) != 0) && ($numtok($3-,32) < 2) { set $+(%,wc.,$1,.,$2) $3- } | did -ra $1-2 $($+(%,wc.,$1,.,$2),2) }
alias wc.ver { return 4.0 }
;alias wc.ini { return $sys.ini }
alias wc.ini { return $+(",$scriptdirweatherclient.ini,") }
alias wc.units { if (!$isid) { writeini $wc.ini settings units $$1 } | if ($isid) { return $readini($wc.ini,settings,units) } }
alias wc.sendtype { if (!$isid) { writeini $wc.ini settings sendtype $iif($1 == -a,$addtok($readini($wc.ini,settings,sendtype),$$2,44),$iif($deltok($readini($wc.ini,settings,sendtype),$findtok($readini($wc.ini,settings,sendtype),$$2,1,44),44),$v1,-)) } | if ($isid) { return $readini($wc.ini,settings,sendtype) } }
alias wc.silent { if (!$isid) { writeini $wc.ini settings silent $$1 } | if ($isid) { return $readini($wc.ini,settings,silent) } }
alias wc.trigger { if (!$isid) { writeini $wc.ini settings trigger $$1 } | if ($isid) { return $readini($wc.ini,settings,trigger) } }
alias wc.proxy { if (!$isid) { writeini $wc.ini settings proxy $$1 } | if ($isid) { return $readini($wc.ini,settings,proxy) } }
alias wc.proxaddr { if (!$isid) { writeini $wc.ini settings proxaddr $1 $$2 $iif($4,$encode($+($3,:,$4),m)) } | if ($isid) { return $readini($wc.ini,settings,proxaddr) } }
alias wc.maxcon { if (!$isid) { writeini $wc.ini settings maxcon $1 $$2 | .timerwc.maxcon off | wc.mxc } | if ($isid) { return $readini($wc.ini,settings,maxcon) } }
alias wc.sighalt { if (!$isid) { writeini $wc.ini settings sighalt $$1 } | if ($isid) { return $readini($wc.ini,settings,sighalt) } }
alias wc.socklog { if (!$isid) { writeini $wc.ini settings socklog $$1 } | if ($isid) { return $readini($wc.ini,settings,socklog) } }
alias wc.query { if (!$isid) { writeini $wc.ini settings query $$1 } | if ($isid) { return $readini($wc.ini,settings,query) } }
alias wc.chan { if (!$isid) { writeini $wc.ini settings chan $$1 } | if ($isid) { return $readini($wc.ini,settings,chan) } }
alias wc.bchans { if (!$isid) { writeini $wc.ini settings bchans $iif($1 == -a,$addtok($readini($wc.ini,settings,bchans),$$2,44),$iif($deltok($readini($wc.ini,settings,bchans),$findtok($readini($wc.ini,settings,bchans),$$2,1,44),44),$v1,-)) } | if ($isid) { return $readini($wc.ini,settings,bchans) } }
alias wc.sockwrite { sockwrite $1- | if ($window($+(@,$2))) { aline $+(@,$2) $2 -> $3- } }
alias wc.localwthr { if (!$isid) { $iif($1-,writeini,remini) $wc.ini settings localwthr $1- } | if ($isid) { return $readini($wc.ini,settings,localwthr) } }

alias wc.mxc {
  var %wc $var(%wc.*.settings,0)
  while (%wc) {
    tokenize 46 $($var(%wc.*.settings,%wc),1)
    if (!$sock($+(wc.,$2,.))) unset $($var(%wc.*.settings,%wc),1), $($var(%wc.*.err,%wc),1) 
    dec %wc
  }
}

alias -l w.url { return $replace($$1-,$chr(32),+,$chr(44),$+($chr(37),2C)) }
alias -l w.rhtml { var %a, %b = $regsub($1-,/<[^<]+>/g,$chr(32),%a) | return $remove($replace(%a,&#176;,$chr(32),&nbsp;,$chr(32),&deg;,$chr(32)),$chr(9)) }
alias wc {
  if ($istok(ci.up.ob.temperature.windchill.humidity.dewpoint.wind.pressure.conditions.visibility.uv.clouds.yesterdaysmaximum.yesterdaysminimum.dd.ddv.sunrise.sunset.moonrise.moonset.moonphase.fcu.fcd.fci.alert.nick,$prop,46)) {
    if ($prop == fcu) { return $gettok($gettok($hget($1,f.0),1,1),4-,32) }
    if ($prop == fcd) { return $gettok($hget($1,$+(f.,$2)),1,1) }
    if ($prop == fci) { return $gettok($hget($1,$+(f.,$2)),2,1) }
    if ($prop == nick) { tokenize 32 $gettok($($+(%,$1,settings),2),3,44) | return $iif($remove($3-,-),$3) }
    if ($remove($hget($1,$prop),-,at,$chr(32))) {
      var %wc.u $gettok($($+(%,$1,settings),2),1,44)
      if (/ !isin $hget($1,$prop)) || (%wc.u == b) { return $replace($hget($1,$prop),$+($chr(32),m,$chr(32)),$+($chr(32),m,$chr(44),$chr(32))) }
      if (/ isin $hget($1,$prop)) {
        tokenize 32 $replace($hget($1,$prop),km/h,kph)
        var %wc = $1-, %wc.i = 1
        tokenize 47 $1-
        !.echo -q $regex(wc,%wc,/(\S+\s\S+\s?\/\s?\S+\s\S+)/g)
        while ($regml(wc,%wc.i)) {
          if (%wc.i == 1) { set %wc $iif($numtok($($+($,%wc.i),2),32) > 2,$gettok($($+($,%wc.i),2),$+(1,-,$calc($numtok($($+($,%wc.i),2),32) - 2)),32)) $iif(%wc.u == i,$gettok($regml(wc,%wc.i),1,47),$gettok($regml(wc,%wc.i),2,47)) }
          if (%wc.i != 1) { set %wc %wc $+ $chr(44) $iif($numtok($($+($,%wc.i),2),32) > 4,$gettok($($+($,%wc.i),2),$+(3,-,$calc($numtok($($+($,%wc.i),2),32) - 2)),32)) $iif(%wc.u == i,$gettok($regml(wc,%wc.i),1,47),$gettok($regml(wc,%wc.i),2,47)) }
          inc %wc.i
        }
        return %wc
      }
    }
  }
}

alias wc.out {
  if ($2 != return) {
    if ($($+(%,$sockname,err),2)) { $2-4 $iif($wc($1).nick,$v1,* /weather) $+ : $wc.err($($+(%,$sockname,err),2)) }
    if (!$($+(%,$sockname,err),2)) {
      var %i 1
      while (%i <= $ini($wc.ini,output,0)) {
        set %wc $readini($wc.ini,output,$+(n,%i))
        if (%wc) && ($left(%wc,1) != $chr(59)) { $2- $replace(%wc,<b>,,<u>,,<r>,,<k>,,<o>,) }
        inc %i
      }
      unset %wc
    }
  }
}

alias wc.err {
  tokenize 32 $1-
  if ($1 == httperr) { return $2- }
  if ($1 == notfound) { return City not found }
  if ($1 == toomany) { return Please narrow your search or search by INTL station ID }
}

on *:sockopen:wc.*: {
  if ($gettok($sockname,2,46) isnum) {
    tokenize 44 $($+(%,$sockname,settings),2)
    hmake $sockname 5
    if ($sockerr) { echo -aci1 info * /weather: socket error $+($chr(40),$sockerr,$chr(41)) | unset $+(%,$sockname,*) | hfree $sockname | return }
    if ($wc.socklog) { window -l $+(@,$sockname) }
    wc.sockwrite -n $sockname GET $+($iif($wc.proxy && $wc.proxaddr,http://mobile.wunderground.com:80),$iif($2 == s,/auto/mobile_metric/global/stations/ $+ $5- $+ .html,/cgi-bin/findweather/getForecast?brand=mobile&query= $+ $5-)) HTTP/1.0
    wc.sockwrite -n $sockname Accept: */*
    wc.sockwrite -n $sockname Accept-Language: en-us
    wc.sockwrite -n $sockname Accept-Encoding: gzip, deflate
    wc.sockwrite -n $sockname User-Agent: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)
    wc.sockwrite -n $sockname Host: mobile.wunderground.com
    if ($wc.proxy) {
      wc.sockwrite -n $sockname Cache-Control: no-store, no-cache
      wc.sockwrite -n $sockname Pragma: no-cache
      if ($gettok($wc.proxaddr,3,32)) { wc.sockwrite -n $sockname Proxy-Authorization: Basic $v1 }
      wc.sockwrite -n $sockname Proxy-Connection: close
    }
    wc.sockwrite -n $sockname
  }
}

on *:sockread:wc.*: {
  if ($sockerr) { echo -aci1 info * /weather: socket error $+($chr(40),$sockerr,$chr(41)) | unset $+(%,$sockname,*) | hfree $sockname | return }
  if ($gettok($sockname,2,46) isnum) {

    var %w.buf
    sockread %w.buf
    if ($wc.socklog) && $window($+(@,$sockname)) { aline $v1 $sockname <- %w.buf }
    tokenize 32 $w.rhtml(%w.buf)
    if (HTTP/* iswm $1) && ($2 != 200) { set $+(%,$sockname,err) httperr $1- }
    if (*<th>Place: Temperature</th>* iswm %w.buf) { set $+(%,$sockname,err) toomany }
    if (*city not found* iswm %w.buf) { set $+(%,$sockname,err) notfound }
    if (!$($+(%,$sockname,err),2)) {
      ;city
      if (<title>* forecast</title> iswm %w.buf) && (!%w.err) { hadd $sockname ci $($+($,1-,$calc($0 - $iif($($+($,$calc($0 - 1)),2) == &,3,1))),2) }

      ;update, obs
      if (*<b>*</b>*) && ($($+(%,$sockname,up),2)) && ($left($1,1) != $chr(44)) { hadd $sockname ob $iif($1-,$iif($right($1-,1) == $chr(44),$left($1-,-1),$1-),-) | unset $+(%,$sockname,up) }
      if (*Updated: * iswm %w.buf) { if ($2- != observed at) { hadd $sockname up $2 $+ $lower($left($3,1)) $left($6,3) $left($7,-1) $right($8,2) } | set $+(%,$sockname,up) 1 }

      ;temp, windchill, dewpoint, wind, pressure, vis, clouds, ymax, ymin
      if (*</td>* iswm %w.buf) && ($($+(%,$sockname,te),2)) { hadd $sockname $iif($right($($+(%,$sockname,te),2),3) == $+($chr(58),$chr(32),-),$remove($($+(%,$sockname,te),2),$v1),$iif($1-,$($+(%,$sockname,te),2) $1-,$($+(%,$sockname,te),2))) | unset $+(%,$sockname,te) }
      if ($($+(%,$sockname,te),2)) { set $+(%,$sockname,te) $($+(%,$sockname,te),2) $1- }
      if ($istok(temperature.windchill.dew point.wind.pressure.visibility.uv.clouds.yesterday's maximum.yesterday's minimum,$1-,46)) { set $+(%,$sockname,te) $remove($1-,',$chr(32)) }

      ;humidity, conditions
      if ($istok(humidity.conditions,$1-,46)) { set $+(%,$sockname,hu) $1- }
      if (*<b>*</b>* iswm %w.buf) && ($($+(%,$sockname,hu),2)) { hadd $sockname $($+(%,$sockname,hu),2) $1- | unset $+(%,$sockname,hu) }

      ;yhd, ycd
      if (*<tr><td>* iswm %w.buf) && ($($+(%,$sockname,dd),2)) { if ($gettok($($+(%,$sockname,dd),2),2,32) != N/A) { hadd $sockname dd $gettok($($+(%,$sockname,dd),2),1,32) | hadd $sockname ddv $gettok($($+(%,$sockname,dd),2),2-,32) } | unset $+(%,$sockname,dd) }
      if ($($+(%,$sockname,dd),2)) { set $+(%,$sockname,dd) $($+(%,$sockname,dd),2) $1- }
      if (*Yesterday's * Degree Days* iswmcs %w.buf) { set $+(%,$sockname,dd) $2 }
    }
    ;sunrise, sunset
    if ($istok(sunrise.sunset,$1,46)) { hadd $sockname $1- }

    ;moonrise, moonset, moonphase
    if ($istok(moon rise.moon set.moon phase,$1-2,46)) { hadd $sockname $remove($1-2,$chr(32)) $3- }

    ;forecasts
    if (*<b>Forecast as of*</b>* iswm %w.buf) { set $+(%,$sockname,fc) 1 }
    if (*<font color="#ff0000">* iswm %w.buf) && ($($+(%,$sockname,fc),2)) { hadd $sockname alert $1- }
    if (*<b>*</b>* iswm %w.buf) && ($($+(%,$sockname,fc),2)) {
      if ($remove($($+(%,$sockname,fcd),2),$chr(32))) { hadd $sockname $+(f.,$calc($hfind($sockname,f.*,0,w) - 1)) $hget($sockname,$+(f.,$calc($hfind($sockname,f.*,0,w) - 1))) $+ $($+(%,$sockname,fcd),2) }
      if (*<b>Forecast as of*</b>* iswm %w.buf) && ($hfind($sockname,f.*,0,w)) { hadd $sockname f.0 $1- | goto fend }
      hadd $sockname $+(f.,$hfind($sockname,f.*,0,w)) $1- $+ $chr(1)
      :fend
      unset $+(%,$sockname,fcd)
    }
    if (*<b>*</b>* !iswm %w.buf) && ($($+(%,$sockname,fc),2)) { set $+(%,$sockname,fcd) $($+(%,$sockname,fcd),2) $1- }
    if (*</table>* iswm %w.buf) && ($($+(%,$sockname,fc),2)) { hadd $sockname $+(f.,$calc($hfind($sockname,f.*,0,w) - 1)) $hget($sockname,$+(f.,$calc($hfind($sockname,f.*,0,w) - 1))) $+ $($+(%,$sockname,fcd),2) | unset $+(%,$sockname,fc*) }
  }
}

on *:sockclose:wc.*: {
  if ($gettok($sockname,2,46) isnum) {
    wc.out $sockname $iif($gettok($($+(%,$sockname,settings),2),3,44) == - - -,$iif($wc.sighalt && $gettok($gettok($($+(%,$sockname,settings),2),4,44),1,32),return,echo -aci1 info),$gettok($v1,1-2,32))
    if ($gettok($gettok($($+(%,$sockname,settings),2),4,44),1,32)) { .signal -n $iif($gettok($gettok($($+(%,$sockname,settings),2),4,44),2,32),$v1,$sockname) $sockname $iif($($+(%,$sockname,err),2),$v1,ok) }
    hfree $sockname
    if ($gettok($($+(%,$sockname,settings),2),3,44) == - - -) { unset $+(%,$sockname,*) }
  }
}
