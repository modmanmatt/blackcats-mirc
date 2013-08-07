;===================================================
; IMDb Movie Search v2.05 by Meij <meijie@gmail.com>
;===================================================

on *:LOAD: {
  echo -ts IMDb Movie Search v2.05: Successfully loaded - Type /_imdb to configure.
  if ($version < 6.17) echo -ts IMDb Movie Search v2.05: Running in compatability mode, mIRC v6.17 or newer is recommended.
}
on *:UNLOAD: {
  if ($timer(_imdb)) .timer_imdb off
  unset %_imdb.*
  hfree -w _imdb.*
  echo -ts IMDb Movie Search v2.05: Successfully unloaded.
}
on *:START: {
  if ($version < 6.17) .enable #_imdb_compat
}
on *:TEXT:*:#: { if ($_ban($+($nick,!,$address))) && ($_trigger($1)) _input $2- }
on *:INPUT:#: { if ($_trigger($1)) _input $2- }
on *:SOCKOPEN:_imdb.*: {
  var %sn = $sockname, %u
  if ($_sget(%sn, state) == 0) var %u = $+(/find?s=,$iif($_sget(%sn, opt_movies),tt,nm),&q=,$_encode($_sget(%sn, search)))
  elseif ($_sget(%sn, url)) {
    noop $regex($_sget(%sn, url), ^http://(?:.+?\.|)imdb.com(/[a-zA-Z0-9]+/[a-z]+[0-9]+(?:/.*?|))$)
    var %u = $regml(1)
  }
  if (!%u) {
    _cset %sn error Invalid URL
    _parse %sn error
    sockclose %sn
    _cleanup %sn
    return
  }
  sockwrite -nt %sn GET %u HTTP/1.0
  sockwrite -nt %sn Accept-Language: en-us
  sockwrite -nt %sn User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10
  sockwrite -nt %sn Referer: http://www.imdb.com/search
  sockwrite -nt %sn Host: www.imdb.com
  sockwrite -nt %sn Connection: close
  sockwrite -t %sn $str($crlf, 2)
}
on *:SOCKREAD:_imdb.*: {
  var %sn = $sockname
  if ($sockerr > 0) return
  :nextread
  sockread &x
  if ($sockbr == 0) return
  if ($bvar(&x, 1, 7).text == HTTP/1.) {
    var %r $bvar(&x, 1, $calc($bfind(&x, 1, $cr) - 1)).text
    if ($gettok(%r, 2, 32) != 200) && ($gettok(%r, 2, 32) != 302) {
      _cset %sn error %r
      _parse %sn error
      sockclose %sn
      _cleanup $sn
      return
    }
  }
  if ($bfind(&x,1,$crlf $+ Location:) > 0) {
    if ($regex($bvar(&x,$ifmatch,800).text, Location: (.[^ $+ $crlf $+ ]+))) {
      if ($hget(%sn)) { hfree %sn }
      sockclose %sn
      _sopen %sn
      _sset %sn state $iif($_sget(%sn, opt_movies), 1, 3)
      _sset %sn url $gettok($regml(1), 1, 63)
      return
    }
  }
  hadd -mbu300 %sn $_item(%sn) &x
  goto nextread
}
on *:SOCKCLOSE:_imdb.*: { _main $sockname }

;
; Main HTML Parsing Alias
;
alias -l _main {
  var %i 1, %sn $1
  bunset &x
  while ($hget(%sn, %i).item) {
    noop $hget(%sn, %i, &x.d)
    bcopy &x $calc($bvar(&x, 0) + 1) &x.d 1 -1
    inc %i
  }
  bunset &x.d
  if ($hget(%sn)) hfree %sn
  if ($bvar(&x, 0) == 0) {
    _cset %sn error No data received on socket!
    _parse %sn error
    _cleanup $sn
    return
  }
  if ($_sget(%sn, state) == 0) {
    var %i 0, %p 1
    if ($_sget(%sn, opt_exact)) var %p = $bfind(&x, %p, <b>Titles (Exact Matches)</b>)
    var %p = $bfind(&x, $iif(%p, %p, 1), <table>)
    while ($regex(one, $bvar(&x, %p, 850).text, <td valign="top">(?:<img[^<]*>)?(?:<br>)?<a href="([^"]+)"[^>]*>([^<]+)</a> (?:\x28)?([\d\w/]+)?(?:\x29)?(?: <.[^>]+>\x28([\w\s][^\x2C\x29]+))?)) {
      inc %i
      if (!$_sget(%sn, opt_results)) {
        if ($hget(%sn)) hfree %sn
        sockclose %sn
        _sopen %sn
        _sset %sn state $iif($_sget(%sn, opt_movies), 1, 3)
        _sset %sn url http://www.imdb.com $+ $gettok($regml(one, 1), 1, 63)
        return
      }
      var %_y = $iif($regml(one, 3) isnum || !$regml(one, 4), 3, 4)
      var %_t = $iif($regml(one, 3) isnum, 4, 3)
      _cset %sn num %i
      _cset %sn title $_regexp($regml(one, 2)) $iif($regml(one, 4), ( $+ $regml(one, %_t) $+ ))
      _cset %sn url http://www.imdb.com $+ $gettok($regml(one, 1), 1, 63)
      _cset %sn year $iif($regml(one, %_y), $ifmatch, n/a)
      _parse %sn list
      _cfree %sn
      if ($_sget(%sn, opt_results) == %i) break
      var %p = $bfind(&x, $calc(%p + 10), <tr>)
    }
    if (%i == 0) _parse %sn none
    elseif (%i != $_sget(%sn, opt_results)) {
      _cset %sn found %i
      _parse %sn miss
    }
  }
  elseif ($_sget(%sn, state) == 1) {
    var %p 1
    if ($_extract(%p, &x, &title, <h1 class="header">) != -1) {
      var %p = $v1
      var %_b = $replace($bvar(&title, 1, 850).text, $lf, )
      if ($regex(title, %_b, <h1 class="header">(.*?)<span>\x28(.*?)\x29</span>(.*?)?</h1>)) {
        var %t = $_regexp($regml(title, 1))
        var %y = $_regexp($regml(title, 2))
        _cset %sn title %t
        _cset %sn year %y
      }
    }
    _cset %sn url $_sget(%sn, url)
    _cset %sn rating Awaiting 5 votes.
    _cset %sn rating_votes 0 votes
    ; Rating
    if ($_extract(%p, &x, &rating, <span class="rating-rating">) != -1) {
      var %p = $v1
      var %_b = $bvar(&rating, 1, 850).text
      if ($regex(rating, %_b, ([0-9\.]+)<span> )) {
        _cset %sn rating $+($regml(rating, 1),/10)
        _cset %sn rating_bar $_rating($regml(rating, 1))
      }
    }
    ; Votes
    if ($bfind(&x, %p, id="star-bar-user-rate") != 0) {
      var %p = $v1
      var %_b = $bvar(&x, %p, 850).text
      if ($regex(rating_votes, %_b, <a[^>]*>(.*?)</a>)) {
        _cset %sn rating_votes $regml(rating_votes, 1)
      }
    }
    ; Extra
    if ($_extract(%p, &x, &rating, <a href="http://www.imdb.com/chart/) != -1) {
      var %p = $v1
      var %_b = $bvar(&rating, 1, 850).text
      if ($regex(rating_extra, %_b, <strong>(.+?)</strong>)) {
        _cset %sn rating_extra $iif($regml(rating_extra, 1), - $_regexp($regml(rating_extra, 1))))
      }
    }
    ; Cast
    var %p = $bfind(&x, 0, <table class="cast_list">)
    if (%p > 0) {
      var %e = $bfind(&x, %p, </table>), %i = 0, %m = $null, %c = $_ini(set, maxcast)
      while ($regex(cast, $replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), <td class="name">.*?href="(.[^>]+)">(.+?)</a>)) && (%p < %e) {
        if (%i == %c) { var %m = $+(%m,$chr(44),$chr(32), ...) | break }
        var %m = $iif(%m != $null, $+(%m,$chr(44) )) $regml(cast, 2)
        var %p = $calc($bfind(&x, %p, <td class="name">) + 1)
        inc %i
      }
      _cset %sn cast %m
    }
    ; Dynamic Content - Reset pointer
    var %p = 1
    var %p = $bfind(&x, %p, <h4 class="inline">)
    while ($regex(one, $replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), <h4 class="inline">(.+?)</h4>)) {
      var %t = $lower($remove($_regexp($regml(one, 1)),:)), %t = $replace(%t, $chr(32), _), %m
      if (%t == year) %t = years
      if ($regex(one, $replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), </h4>(.+?)</div>)) {
        _cset %sn %t $_regexp($regml(one, 1))
        if (direct* iswm %t) { _cset %sn directed_by $_regexp($regml(one, 1)) }
        elseif (writ* iswm %t) { _cset %sn writing_credits $_regexp($regml(one, 1)) }
        elseif (genres == %t) { _cset %sn genre $_regexp($regml(one, 1)) }
        elseif (taglines == %t) { _cset %sn tagline $_regexp($regml(one, 1)) }
      }
      var %p = $bfind(&x, $calc(%p + 1), <h4 class="inline">)
    }
    if ($_sget(%sn, opt_boxoffice) == $true) {
      var %url = $_sget(%sn, url)
      sockclose %sn
      _sopen %sn
      _sset %sn state 2
      _sset %sn url $+(%url,$iif($right(%url, 1) != /,/),business)
      return
    }
    _parse %sn movie
  }
  elseif ($_sget(%sn, state) == 2) {
    var %p = $bfind(&x, 0, <h5>)
    while ($regex($replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), <h5>(.+?)</h5>)) {
      var %c = $replace($lower($_regexp($regml(1))), $chr(32), _)
      if ($regex($replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), </h5>(.+?)<br/>)) {
        var %d = $regml(1)
        if ($regex(%d, (.+?) \((.+?)\)(?: \((.+?)\)(?: \(([0-9,]+) .+?\)|)|))) && (%c != budget)  {
          _cset %sn %c $+ _value $regml(1)
          _cset %sn %c $+ _region $regml(2)
          if ($regml(3)) _cset %sn %c $+ _date $_regexp($ifmatch)
          if ($regml(4)) _cset %sn %c $+ _screens $ifmatch
        }
        else _cset %sn %c $_regexp(%d)
      }
      var %p = $bfind(&x, $calc(%p + 1), <h5>)
    }
    _parse %sn movie
    _cleanup %sn
  }
  elseif ($_sget(%sn, state) == 3) {
    var %p = $bfind(&x, 1, <h1 class="header">)
    if ($regex($bvar(&x, %p, 850).text, <h1 class="header">(.[^<]*)</h1>)) {
      _cset %sn name $_regexp($regml(1))
      _cset %sn url $_sget(%sn, url)
    }
    if ($_extract(%p, &x, &bio, <td id="overview-top">) != -1) {
      if ($regex(bio, $replace($bvar(&bio, 1, 850).text, $cr, $chr(32), $lf, $chr(32)), <p>(.*?)</p>)) {
        _cset %sn mini_biography $_regexp($regml(bio, 1))
      }
    }
    var %p = $bfind(&x, %p, <h4 class="inline">)
    while ($regex(one, $replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), <h4 class="inline">(.+?)</h4>)) {
      var %t = $lower($remove($_regexp($regml(one, 1)),:)), %t = $replace(%t, $chr(32), _), %m
      if ($regex(one, $replace($bvar(&x, %p, 850).text, $cr, $chr(32), $lf, $chr(32)), </h4>(.+?)</div>)) {
        _cset %sn %t $_regexp($regml(one, 1))
      }
      var %p = $bfind(&x, $calc(%p + 1), <h4 class="inline">)
    }
    _parse %sn cast
  }
  _cleanup %sn
}

alias -l _extract {
  var %p $1, %_ih = $false
  if (!$2) return -3
  if ($3) bunset $3
  if (!$regex(extract, $4, <(\w+))) return -2
  var %_rs = $4, %_re = $+(</,$regml(extract, 1),>), %_rc = $+(<,$regml(extract, 1))
  var %_s = $bfind($2, %p, %_rs).text, %_p = %_s, %_e = %_s
  if (%_s == 0) return -1
  ; if there are no closing tags present, we've either got html not xml or invalid (x)html.
  if ($bfind($2, %p, %_re).text == 0) var %_ih = $true
  if ($5) var %_re = $5
  if ($6) var %_rc = $6
  while ($bfind($2, %_p, %_rc).text > 0) {
    var %_v1 = $v1, %_p = $calc(%_v1 + 1)
    if ((%_ih) && ($bfind($2, %_p, %_rc).text > 0)) {
      var %_e = $v1, %_et = %_e
      break
    }
    if ((%_v1 < %_e) || (%_e == %_s)) var %_e = $bfind($2, $calc(%_e + 1), %_re).text, %_et = $calc(%_e + $len(%_re))
    else break
  }
  if ($3) bcopy -c $3 1 $2 %_s $calc(%_et - %_s)
  return $iif(%_e > 0, %_et, 0)
}

;
; Main Input Alias
;
alias -l _input {
  if (!$_chan($chan)) || (!$_ini(set, online)) return
  var %fs = $_ini(set, flood_seconds), %fn = $_ini(set, flood_number)
  if (%fn > 0) && (%fs > 0) {
    if (%_imdb.flood. [ $+ [ $+($cid,.,$chan) ] ] == $null) { set $+(-u,%fs) %_imdb.flood. [ $+ [ $+($cid,.,$chan) ] ] 1 }
    elseif (%_imdb.flood. [ $+ [ $+($cid,.,$chan) ] ] < %fn) inc %_imdb.flood. [ $+ [ $+($cid,.,$chan) ] ]
    else return
  }
  elseif (%fe == 1) echo -ta [IMDb] Error: invalid flood settings. flood prevention disabled!
  var %i 1, %_cb = $iif($_ini(set, boxoffice), $true, $false), %_cc $false
  while (%i <= $0) {
    var %cs = $gettok($1-, %i, 32)
    if ($left(%cs, 1) != -) break
    var %cj 0, %cl = $len(%cs)
    while (%cj < %cl) {
      inc %cj | var %cp = $mid(%cs, %cj, 1), %cd
      if (%cp == -) continue
      if ($regex($mid(%cs, $calc(%cj + 1)), ^([\d]+))) { var %cd = $regml(1) | inc %cj $len(%cd) }
      ; Work around for mIRC < 6.3 /var bug.
      var %_t = $iif($len(%cd) > 0, %cd, $true), %_c [ $+ [ %cp ] ] %_t
    }
    inc %i
  }
  var %_cm = $iif($_ini(set, exact), $iif(%_cm, $false, $true), $iif(%_cm, $true, $false))
  var %t = $gettok($1-, $+(%i,-), 32)
  if (!%t) {
    _msg $chan $cid $nick 4 IMDb Movie Search v2.05 by Meij <meijie@gmail.com>
    _msg $chan $cid $nick 4 Usage: $_ini(set, trigger) [options] <search>
    _msg $chan $cid $nick 4 Options:
    _msg $chan $cid $nick 4      Matching: -m (switch between popular & exact searching) $+($chr(40),state: $iif(%_cm == $true,exact,popular),$chr(41))
    _msg $chan $cid $nick 4      Box Office: -b (include budget/screens/gross) $+($chr(40),state: $iif(%_cb == $true,on,off),$chr(41))
    _msg $chan $cid $nick 4      Cast & Crew: -c (search for actors/actresses/film makers and crew)
    _msg $chan $cid $nick 4      List Results: -lN (where N is the number of results to list)
    _msg $chan $cid $nick 4 Example: $_ini(set, trigger) -cl5 Keira
    return
  }
  if (%_cl !isnum) var %_cl 0
  if ($_ini(set, max) < %l) var %l $ifmatch
  var %sn = $_sopen
  ; state:
  ;  0 = listing results
  ;  1 = movie info
  ;  2 = extended movie info
  ;  3 = cast / crew info
  if ($regex(%t, ^http://(?:.+?\.|)imdb.com/[a-zA-Z0-9]+/([a-z]+)[0-9]+(?:/|)$)) {
    _sset %sn state $iif($regml(1) == tt, 1, 3)
    _sset %sn url %t
  }
  else {
    _sset %sn state 0
    _sset %sn search %t
  }
  _sset %sn chan $chan
  _sset %sn scid $cid
  _sset %sn nick $nick
  _sset %sn opt_movies $iif(!%_cc, $true, $false)
  _sset %sn opt_results %_cl
  _sset %sn opt_boxoffice %_cb
  _sset %sn opt_exact %_cm
}

;
; Queue Aliases
;
alias -l _info {
  if ($1 isnum) {
    if (%_imdb.queue. $+ [ $1 ]) && ($1 > 0) return %_imdb.queue. [ $+ [ $1 ] ]
    elseif ($1 == 0) return $var(%_imdb.queue.*)
  }
}
alias -l _msg {
  set %_imdb.queue. [ $+ [ $calc($_info(0) + 1) ] ] $1-
  ; Added a 1 millisecond timer to the first _say to fix a bug with FiSH.
  if (!$timer(_imdb)) { .timer -m 1 1 _say | .timer_imdb -m 0 2000 _say }
}
alias -l _say {
  var %i 1
  if (%_imdb.queue. [ $+ [ %i ] ]) {
    tokenize 32 %_imdb.queue. [ $+ [ %i ] ]
    scid $2
    if ($3 ison $1) && ($me ison $1) && ($5) {
      if ($4 == 1) msg $1 $5-
      elseif ($4 == 2) .msg $3 $5-
      elseif ($4 == 3) notice $1 $5-
      else .notice $3 $5-
    }
    unset %_imdb.queue. [ $+ [ %i ] ] | var %h $calc(%i + 1)
    while (%_imdb.queue. [ $+ [ %h ] ]) { set %_imdb.queue. [ $+ [ $calc(%h - 1) ] ] %_imdb.queue. [ $+ [ %h ] ] | unset %_imdb.queue. [ $+ [ %h ] ] | inc %h }
  }
  else .timer_imdb off
}

;
; Socket Aliases
;
alias -l _sopen {
  if (!$1) {
    :name
    var %sn = $+(_imdb.,$md5($ticks))
    if ($sock(%sn)) || ($hget(%sn $+ _settings)) goto name
  }
  else var %sn = $1

  if ($_ini(set, proxy)) {
    if ($_ini(set, host)) && ($_ini(set, port)) sockopen %sn $_ini(set, host) $_ini(set, port)
    else echo -ta [IMDb] Error: please specify a hostname and port number in the proxy settings
  }
  else sockopen %sn www.imdb.com 80

  return %sn
}

alias -l _sset { hadd -mcu300 $1 $+ _settings $$2 $3- }
alias -l _sget {
  if ($prop == unset) return $hget($1 $+ _settings, $$2).unset
  else return $hget($1 $+ _settings, $$2)
}
alias -l _sfree { hfree $$1 $+ _settings }

;
; Cookie Aliases
;
alias -l _cset { hadd -mcu300 $1 $+ _cookies $$2 $3- }
alias -l _cget {
  if ($prop == item) && ($2 isnum) return $hget($1 $+ _cookies, $$2).item
  elseif ($prop == data) && ($2 isnum) return $hget($1 $+ _cookies, $$2).data
}
alias -l _cfree { hfree $$1 $+ _cookies }

;
; Misc Aliases
;
alias -l _ban {
  var %i 1
  while (%i <= $ini($scriptdirimdb.set, ban, 0)) {
    var %x = $readini($scriptdirimdb.set, n, ban, $ini($scriptdirimdb.set, ban, %i))
    if ($1 isnum) && ($1 == %i) return %x
    elseif (%x iswm $1) return 0
    inc %i
  }
  return $iif($1 == 0,$calc(%i - 1), 1)
}
alias -l _item {
  var %i 1
  while ($hget($1,%i).item) inc %i
  return %i
}
alias -l _rating {
  var %s = $ceil($1), %i 1
  while (%i <= 10) { if (%i <= %s) { var %z $+(%z,7*) } | else { var %z $+(%z,14*) } | inc %i }
  return $+(11[,%z,11])
}
alias -l _regexp {
  var %i 1, %l quot 34|lt 60|lg 62|amp 38|nbsp 32|ndash 45, %m $replace($1, $cr, $chr(32), $lf, $chr(32))
  while ($regex(two, %m, /(&#(\d{1,3});)/s)) { var %m = $replace(%m, $regml(two, 1), $chr($regml(two, 2))) }
  noop $regsub(three, %m, /(?:<span[^>]*>\x7C</span>[\s\t]*)?(<span[^>]*>[\s\t]*)?<a [^>]*>(See more|see all|Full episode list|See full bio)</a>.*/gi,, %m)
  noop $regsub(three, %m, /<[^>]+>/g,$chr(32), %m)
  noop $regsub(three, %m, /See[^\w]+why[^\w]+on[^\w]+IMDbPro.*/g,, %m)
  while (%i <= $gettok(%l,0,124)) {
    var %t = $gettok(%l,%i,124)
    noop $regsub(three, %m, $+(/&,$gettok(%t,1,32),;/g), $chr($gettok(%t,2,32)), %m)
    inc %i
  }
  noop $regsub(three, %m, /&[^;]+;/g,, %m)
  return $replace($remove(%m, (WGA)), $chr(160), $chr(32), $chr(124), $chr(47))
}
alias -l _mode { return $iif($_ini(set, msgmode), $ifmatch, 1) }
alias -l _encode {
  var %s, %p = $len($1-)
  while (%p) {
    if ($mid($1-,%p,1) isalnum) %s = $+($ifmatch,%s)
    else %s = $+(%,$base($asc($mid($1-,%p,1)),10,16),%s)
    dec %p
  }
  return %s
}
alias -l _ini {
  if ($isid) return $readini($scriptdirimdb.set, n, $1, $$2)
  elseif ($3) writeini $+(",$scriptdir,imdb.set,") $1 $2 $$3-
  else remini $+(",$scriptdir,imdb.set,") $$1 $2
}
alias -l _trigger {
  if ($1 == $_ini(set, trigger)) return 1
  return 0
}
alias -l _chan {
  if ($_ini(set, all)) { return 1 }
  var %i 1, %l $_ini(set, networks)
  while (%i <= $gettok(%l, 0, 44)) {
    var %n = $gettok(%l, %i, 44)
    if (%n == $network) {
      var %j 1
      while (%j <= $gettok($_ini(set, $+(.,%n)), 0, 44)) {
        var %c = $gettok($_ini(set, $+(.,%n)), %j, 44)
        if (%c == $1) return 1
        inc %j
      }
    }
    inc %i
  }
}
alias -l _cleanup { hfree -w $$1 $+ * }

;
; Output Parsing Aliases
;
alias -l _mini {
  var %i 1, %l
  while (%i <= $ini($scriptdirimdb.set, $1, 0)) {
    var %m = $ini($scriptdirimdb.set, $1, %i)
    if ($iif($3,$3-,*) iswm %m) var %l = $addtok(%l, %m, 44)
    inc %i
  }
  var %l = $sorttok(%l, 44)
  return $iif($2 == 0, $gettok(%l, 0, 44), $gettok(%l, $2, 44))
}
alias -l _codes {
  var %i 1, %o $$1-, %r = $+(/&b\^/g 2|/&u\^/g 31|/&o\^/g 15|/&k\^/g 3|/&r\^/g 22)
  while (%i <= $gettok(%r, 0, 124)) {
    var %t = $gettok(%r, %i, 124)
    noop $regsub(%o, $gettok(%t, 1, 32), $iif($gettok(%t, 2, 32) isnum, $chr($ifmatch), $ifmatch), %o)
    inc %i
  }
  return %o
}
alias -l _parse {
  var %i 1, %m $+($2,_), %sn = $1
  var %chan = $_sget(%sn, chan), %scid = $_sget(%sn, scid), %nick = $_sget(%sn, nick)
  _cset %sn chan %chan
  _cset %sn nick %nick
  _cset %sn limit $_sget(%sn, opt_results)
  _cset %sn search $_sget(%sn, search)
  while (%i <= $_mini(outp, 0, %m $+ *)) {
    var %l = $_codes($_ini(outp, %m $+ %i)), %j 1, %o %l
    while (%j <= $_cget(%sn, 0).item) {
      noop $regsub(%o, $+(/&(!)?,$_cget(%sn, %j).item,\^/g), $replace($_cget(%sn, %j).data, $chr(36), $cr), %o)
      inc %j
    }
    inc %i
    if ($regex(%l, /&[^&]*?\^/g) != $regex(%o, /&[^&]*?\^/g)) {
      noop $regsub(%o,/&[^!][^&]*?\^/g,n/a, %o)
      noop $regsub(%o,/&[^&]*?\^/g,, %o)
      _msg %chan %scid %nick $_mode $replace(%o, $cr, $chr(36))
    }
  }
}

;
; Dialog Stuff
;
alias _imdb { if (!$dialog(_imdb)) { dialog -m _imdb _imdb } }
alias -l _replace { return $replace($$1-, $chr(2), &b^, $chr(31), &u^, $chr(15), &o^, $chr(3), &k^, $chr(22), &r^)) }
dialog -l _imdb {
  title "IMDb Movie Search v2.05"
  icon imdb.ico, 0
  size -1 -1 362 248
  option pixels notheme
  tab "General", 1, -2 1 366 258
  tab "Theme", 20
  tab "Bans", 17
  tab "Misc", 27
  box "Proxy", 34, 6 26 348 76, tab 27
  combo 2, 256 42 100 86, tab 1 size drop
  combo 3, 6 42 120 144, tab 1 size
  combo 4, 130 42 120 144, tab 1 size
  edit "", 6, 255 80 102 22, tab 1
  text "Trigger:", 7, 258 66 40 14, tab 1
  text "Channels:", 8, 132 26 48 14, tab 1
  text "Networks:", 9, 8 26 50 14, tab 1
  button "+", 10, 132 187 20 20, tab 1
  button "-", 11, 156 187 20 20, tab 1
  button "+", 12, 6 187 20 20, tab 1
  button "-", 13, 30 187 20 20, tab 1
  check "All", 14, 218 186 32 20, tab 1 left
  check "Enable", 15, 300 222 52 19, left
  text "Message Mode:", 16, 258 26 78 14, tab 1
  button "Done", 5, 144 217 72 24, ok
  combo 18, 6 42 120 120, tab 20 size drop
  text "", 19, 252 42 102 16, tab 20 hide
  edit "", 22, 5 62 351 146, tab 20 autohs autovs multi return vsbar
  text "Type:", 23, 8 26 33 14, tab 20
  combo 21, 6 42 348 144, tab 17 size
  text "Host Mask:", 24, 8 26 56 14, tab 17
  button "-", 25, 30 187 20 20, tab 17
  button "+", 26, 6 187 20 20, tab 17
  text "Host:", 29, 14 40 28 14, tab 27 right
  edit "", 30, 12 55 272 22, tab 27
  text "Port:", 31, 288 40 26 14, tab 27 right
  edit "", 32, 286 55 60 22, tab 27
  check "Enable", 33, 293 78 52 18, tab 27 left
  box "Defaults", 28, 6 106 349 98, tab 27
  text "Max Results:", 35, 14 122 69 14, tab 27
  edit "", 36, 12 137 81 22, tab 27 right
  edit "", 37, 12 176 81 22, tab 27 right
  text "Max Cast:", 38, 14 161 55 14, tab 27
  check "Show", 39, 131 138 63 17, tab 27
  text "Box Office:", 40, 131 122 62 14, tab 27
  text "Matching:", 41, 131 161 63 14, tab 27
  combo 42, 131 176 100 60, tab 27 drop
  edit "", 43, 250 137 81 22, tab 27 right
  edit "", 44, 250 176 81 22, tab 27 right
  scroll "", 45, 331 137 17 21, tab 27 left range 0 2
  scroll "", 46, 331 175 17 21, tab 27 left range 0 2
  text "Flood Count:", 47, 250 122 69 14, tab 27
  text "Flood Period:", 48, 250 161 67 14, tab 27
  scroll "", 49, 93 137 17 21, tab 27 left range 0 2
  scroll "", 50, 93 176 17 21, tab 27 left range 0 2
}
on *:DIALOG:_imdb:*:*: {
  if ($devent == init) {
    ; General
    if ($_ini(set, online)) did -c $dname 15
    didtok $dname 2 44 Message (C),Message (P),Notice (C),Notice (P)
    did -c $dname 2 $iif($_ini(set, msgmode),$ifmatch,1)
    did -ra $dname 6 $_ini(set, trigger)
    didtok $dname 3 44 $_ini(set, networks)
    if ($did($dname, 3).lines > 0) didtok $dname 4 44 $_ini(set, . $+ $did($dname, 3, 1))
    if ($_ini(set, all)) { did -c $dname 14 | did -b $dname 3,4,10,11,12,13 }
    ; Theme
    did -r $dname 18,22,19
    didtok $dname 18 44 Movie,Cast,List,None,Miss,Error
    did -c $dname 18 1
    var %i 1, %n $_mini(outp, 0, movie_*)
    while (%i <= %n) {
      var %o = $+(%o,$_ini(outp, movie_ $+ %i),$iif(%i != %n,$crlf))
      inc %i
    }
    did -a $dname 22 %o
    did -j $dname 22
    did -c $dname 22 1
    did -a $dname 19 $did($dname, 18).text
    ; Bans
    var %i 1
    while (%i <= $_ban(0)) { did -a $dname 21 $_ban(%i) | inc %i }
    ; Proxy
    did -a $dname 30 $_ini(set, host)
    did -a $dname 32 $_ini(set, port)
    if (!$_ini(set, proxy)) || (!$_ini(set, host)) || (!$_ini(set, port)) did -b $dname 30,32
    else did -c $dname 33
    ; Defaults
    did -c $dname 45,46,49,50 1
    didtok $dname 42 44 Popular,Exact
    did -c $dname 42 $iif($_ini(set, exact), 2, 1)
    did -a $dname 36 $_ini(set, max)
    did -a $dname 37 $_ini(set, maxcast)
    if ($_ini(set, boxoffice)) did -c $dname 39
    did -a $dname 43 $_ini(set, flood_number)
    did -a $dname 44 $_ini(set, flood_seconds)
  }
  ; Theme Saving
  if ((($devent == sclick) && ($did == 18)) || ($devent == close)) && ($did($dname, 22).edited) {
    var %m = $+($lower($did($dname, 19).text),_*)
    var %i 1, %t = $_mini(outp, 0, %m)
    while (%i <= %t) { _ini outp $_mini(outp, 1, %m) | inc %i }
    var %i 1
    while (%i <= $did($dname, 22).lines) {
      var %m = $+($lower($did($dname, 19).text),_,%i)
      var %t = $did($dname, 22, %i).text
      if (%t) { _ini outp %m $_replace(%t) | inc %i }
      else did -d $dname 22 %i
    }
  }
  if ($devent == scroll) {
    ; Misc
    var %i 1, %s = 45 43 46 44 49 36 50 37, %sc = $gettok(%s, 0 ,32)
    while (%i < %sc) { if ($did == $gettok(%s, %i, 32)) { var %t = $gettok(%s, $calc(%i + 1), 32) | break } | inc %i 2 }
    if (!%t) return
    var %x = $did($dname, %t).text
    if (%x !isnum) var %x = 0
    if ($did($dname, $did).sel == 0) var %x = $calc(%x + 1)
    else var %x = $calc(%x - 1)
    if (%x < 0) var %x 0
    did -ra $dname %t %x
    did -c $dname $did 1
  }
  if ($devent == sclick) {
    ; General
    if ($did == 2) _ini set msgmode $did($dname, 2).sel
    if ($did == 15) _ini set online $did($dname, 15).state
    if ($did == 14) {
      _ini set all $did($dname, 14).state
      if ($did($dname, 14).state == 1) {
        did -u $dname 3
        did -b $dname 3,4,10,11,12,13
      }
      else {
        did -e $dname 3,4,10,11,12,13
        if ($did($dname, 3, 1).text) {
          did -c $dname 3 1
          did -r $dname 4
          didtok $dname 4 44 $_ini(set, . $+ $did($dname, 3, 1))
        }
        did -f $dname 3
      }
    }
    if ($did == 3) && ($did($dname, 3).sel isnum) {
      did -r $dname 4
      did -d $dname 4 0
      didtok $dname 4 44 $_ini(set, . $+ $did($dname, 3, $did($dname, 3).sel))
    }
    if ($did == 4) && ($did($dname, 3).sel == 0) did -c $dname 3 1
    if ($did == 12) || ($did == 13) {
      did -r $dname 4
      did -d $dname 4 0
      if ($did == 12) && (!$did($dname, 3).sel) && ($did($dname, 3).text) {
        did -a $dname 3 $did($dname, 3).text
        did -c $dname 3 $did($dname, 3).lines
        _ini set networks $didtok($dname, 3, 44)
        didtok $dname 4 44 $_ini(set, . $+ $did($dname, 3).text)
      }
      if ($did == 13) && ($did($dname, 3).sel isnum) {
        var %s = $did($dname, 3).sel
        did -d $dname 3 %s
        _ini set networks $didtok($dname, 3, 44)
        while (%s > 0) { if ($did($dname, 3,%s).text) { did -c $dname 3 %s | didtok $dname 4 44 $_ini(set, . $+ $did($dname, 3, %s)) | break } | dec %s }
      }
      did -f $dname 3
    }
    if ($did == 10) && (!$did($dname, 4).sel) && ($did($dname, 4).text) && ($did($dname, 3).seltext) {
      var %t $did($dname, 4).text
      did -a $dname 4 $iif($left(%t, 1) != $chr(35),$+($chr(35),%t),%t)
      did -c $dname 4 $did($dname, 4).lines
      _ini set $+(.,$did($dname, 3).seltext) $didtok($dname, 4, 44)
      did -f $dname 4
    }
    if ($did == 11) && ($did($dname, 4).sel isnum) {
      var %s $did($dname, 4).sel
      did -d $dname 4 %s
      _ini set $+(.,$did($dname, 3).seltext) $didtok($dname, 4, 44)
      while (%s > 0) { if ($did($dname, 4,%s).text) { did -c $dname 4 %s | break } | dec %s }
      did -f $dname 4
    }
    ; Theme
    if ($did == 18) {
      did -ra $dname 19 $did($dname, 18).text
      did -r $dname 22
      var %i 1, %n $_mini(outp, 0, $+($did($dname, 18).seltext,_*))
      while (%i <= %n) {
        var %s = $_mini(outp, %i, $+($did($dname, 18).seltext,_*))
        var %o = $+(%o,$_ini(outp, %s),$iif(%i != %n,$crlf))
        inc %i
      }
      did -a $dname 22 %o
      did -j $dname 22
      did -c $dname 22 1
    }
    ; Proxy
    if ($did == 33) {
      _ini set proxy $did($dname, 33).state
      if ($did($dname, 33).state == 1) did -e $dname 30,32
      else did -b $dname 30,32
    }
    ; Bans
    if ($did == 26) && ($did($dname, 21).text) {
      did -a $dname 21 $did($dname, 21).text
      did -c $dname 21 $did($dname, 21).lines
      did -f $dname 21
    }
    if ($did == 25) && ($did($dname, 21).sel) {
      var %s $did($dname, 21).sel
      did -d $dname 21 %s
      while (%s > 0) { if ($did($dname, 21, %s).text) { did -c $dname 21 %s | break } | dec %s }
      did -f $dname 21
    }
    ; Defaults
    if ($did == 39) _ini set boxoffice $did($dname, 39).state
    if ($did == 42) _ini set exact $iif($did($dname, 42).sel == 2, 1, 0)
  }
  if ($devent == close) {
    ; General
    if ($did($dname, 6).text) _ini set trigger $iif($gettok($did($dname,6).text, 1, 32),$ifmatch,!imdb)
    ; Bans
    _ini ban
    var %i 1
    while (%i <= $did($dname, 21).lines) { _ini ban %i $did($dname, 21, %i) | inc %i }
    ; Proxy
    if (!$did($dname, 32).text isnum) { _ini set host $did($dname, 30).text | _ini set port $did($dname, 32).text }
    ; Defaults
    if ($did($dname, 36).text isnum) _ini set max $did($dname, 36).text
    if ($did($dname, 37).text isnum) _ini set maxcast $did($dname, 37).text
    if ($did($dname, 43).text isnum) _ini set flood_number $did($dname, 43).text
    if ($did($dname, 44).text isnum) _ini set flood_seconds $did($dname, 44).text
  }
}

#_imdb_compat on

alias -l noop .echo -q $1-

#_imdb_compat end
