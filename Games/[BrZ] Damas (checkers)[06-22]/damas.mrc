on *:load:if ($version < 6.02) { echo $colour(i) *** You need version mIRC 6.02 or higher | echo $colour(i) *** Addon will be unloaded | unload -rs $+(",$script,") | return } | echo $colour(i) *** Addon 1[3B12r8Z1] Damas v1.0 | echo $colour(i) *** by O_Rei_Da_Praia | echo $colour(i) *** Successfully loaded | echo $colour(i) *** WARNING! Before playing for the 1st time, read damas.txt topic: 3- Catching | set %dama.tam 40 | set %dama.opc s s s | set %dama.theme 0 16777215 32767 43520 13619151 255 13816530 verdana | dama.ab
on *:unload:unset %dama* | .timer.dama* off | echo $colour(i) *** Addon 1[3B12r8Z1] Damas v1.0 unloaded!

menu menubar,status {
  -
  Games
  .[Checkers] Damas
  ..Play:dama
  ..-
  ..Theme:th
  ..$iif(!$isfile($+(",$scriptdirdamas.txt")),$style(2)) Help:run $+(",$scriptdirdamas.txt")
  ..About:dama.ab
  ..-
  ..Unload:if ($$?!"Do you really want to unload $crlf $+ [BrZ] Damas v1.0 by O_Rei_Da_Praia?") { .unload -rs $+(",$script",) }
}

alias -l opc if ($isid) return $gettok(%dama.opc,$1,32) | set %dama.opc $puttok(%dama.opc,$2,$1,32)
alias -l flash if ($opc(3) = s) { flash $1- }
alias -l th if ($isid) return $gettok(%dama.theme,$1,32) | dialog $iif($dialog(dama.t),-v,-m) dama.t dama.t
alias -l t return $iif(%dama.tam > 24,$ifmatch,25) * 8
alias -l sw sockwrite -tn dama $1-
alias -l dr drawrect $1 @dama $2-
alias -l dl drawline $1 @dama $2-
alias -l dt drawtext $1 @dama $2-
alias -l dd drawdot @dama
alias dama {
  if (!%dama.tam) { set %dama.tam 40 } | if (!$opc(3)) { set %dama.opc s s s } | if (!%dama.theme) || ($numtok(%dama.theme,32) < 8) { set %dama.theme 0 16777215 32767 43520 13619151 255 13816530 verdana }
  window -c @dama | window -peakCB +lt @Dama 1 1 $calc($t + 125) $calc($t + 166) | dama.desconectar
  titlebar @dama - by O_Rei_Da_Praia | drawfill -r @dama $th(7) 1 1 1
  vars | draw | drawchat | .timer.dama.painel off | painel
  dchat -t *** [3B8r12Z] Damas v1.0 - by O_Rei_Da_Praia
  dchat -t *** Right-Click for options
}
alias -l drawchat {
  dr -frn $th(7) 1 5 $calc($t + 12) $calc($t + 110) 110
  dr -n 1 2 5 $calc($t + 12) $calc($t + 110) 110
  dl -n 1 2 $calc($t + 101) $calc($t + 14) $calc($t + 101) $calc($t + 120)
  dl -n 1 2 $calc($t + 101) $calc($t + 27) $calc($t + 112) $calc($t + 27)
  dl -n 1 2 $calc($t + 101) $calc($t + 107) $calc($t + 112) $calc($t + 107)
  chatset 12
  dr -fn 14 1 $calc($t + 102) $calc($t + 28) 11 11
  dr -n 15 1 $calc($t + 102) $calc($t + 28) 11 11
  dt -brn 0 $th(7) tahoma 9 10 $calc($t + 9) $chr(160) Chat $chr(160)
  dd | write -c $+(",$scriptdir,dama.log,") | set %dama.chat 0
}
alias -l chatset {
  if (1 isin $1) {
    dr -fr $th(7) 1 $calc($t + 102) $calc($t + 14) 11 12
    dl -nr 255 1 $calc($t + 104) $calc($t + 19) $calc($t + 108) $calc($t + 15)
    dl -nr 255 1 $calc($t + 107) $calc($t + 16) $calc($t + 111) $calc($t + 20)
    dl -nr 255 1 $calc($t + 107) $calc($t + 17) $calc($t + 107) $calc($t + 24)
  }
  if (2 isin $1) {
    dr -fr $th(7) 1 $calc($t + 102) $calc($t + 108) 11 12
    dl -nr 255 1 $calc($t + 104) $calc($t + 114) $calc($t + 108) $calc($t + 118)
    dl -nr 255 1 $calc($t + 107) $calc($t + 117) $calc($t + 111) $calc($t + 113)
    dl -nr 255 1 $calc($t + 107) $calc($t + 110) $calc($t + 107) $calc($t + 118)
  }
}
alias -l dchat {
  var %f = $+(",$scriptdir,dama.log,") | var %t' = $calc($t + 6) | var %f2 = $+(",$th(8-),")
  if (($1 = -c) || ($2 = -b)) && (!%dama.chat) return
  if ($1 = -c) {
    if (%dama.chat = 1) return
    dec %dama.chat
    dr -fnr $th(7) 1 7 $calc($t + 18) $calc($t + 93) 102
    var %x = 1
    while (%x <= 6) {
      var %t = $read(%f,$calc(%dama.chat - %x + 1))
      if (%t) dt -pbrnc 0 $th(7) %f2 10 10 $calc(%t' + (16 * (7 - %x))) $calc($t + 90) 17 %t
      inc %x
    }
  }
  elseif ($1 = -b) {
    if (%dama.chat = $lines(%f)) return
    inc %dama.chat
    dr -fnr $th(7) 1 7 $calc($t + 18) $calc($t + 93) 102
    var %x = 6
    while (%x > 0) {
      var %t = $read(%f,$calc(%dama.chat - %x + 1))
      if (%t) dt -pbrnc 0 $th(7) %f2 10 10 $calc(%t' + (16 * (7 - %x))) $calc($t + 90) 17 %t
      dec %x
    }
  }
  else {
    var %a = $iif(%dama.chat = $lines(%f),a) | var %x = 1 | var %t = $iif(($opc(2) = s) && ($1 != -t),$timestamp)
    while ($wrap(%t $iif($1 = -t,$2-,$1-),$remove(%f2,"),10,$calc($t + 92),0,%x)) {
      var %i = $ifmatch
      if (%a) {
        drawscroll @dama 0 -16 7 $calc($t + 18) $calc($t + 93) 102
        dr -frn $th(7) 1 8 $calc($t + 99) $calc($t + 92) 20
        dt -pbrn 0 $th(7) %f2 10 10 $calc(%t' + (16 * 6)) %i
        inc %dama.chat
      }
      write %f %i | inc %x
    }
  }
  dama.sb | dd
}

alias -l dama.sb {
  var %cx = 5 | var %cy = $calc($t + 12) | var %l = $calc($t + 100)
  var %d = $calc(67 / ($lines($+(",$scriptdir,dama.log,")) -1))
  var %x = $calc(%d * $calc(%dama.chat - 1))
  if (%dama.chat = $lines($+(",$scriptdir,dama.log,"))) { var %x = 67 }
  dr -fr $th(7) 1 $calc(%cx + %l - 3) $calc(%cy + 14 + 2) 11 78
  dr -f 14 1 $calc(%cx + %l - 3) $calc(%cy + 14 + 2 + %x) 11 11
  dr -r $th(7) 1 $calc(%cx + %l - 3) $calc(%cy + 14 + 2 + %x) 11 11
}
alias -l vars {
  set %dama.mov | set %dama.jogada | set %dama.vez 1 | set %dama.cap | set %dama.cap2
  set %dama.p1 | set %dama.p2 | set %dama.pd1 | set %dama.pd2 | set %dama.tempo 0 0
  set %dama.s.list | set %dama.s.eu | set %dama.s | set %dama.pl2 Player 2
  set %dama.ping
}
alias -l draw {
  var %x 0,%y 0,%t %dama.tam,%p $calc(80 * (%t / 100))
  dr -rn 0 2 5 5 $calc(%t * 8 + 4) $calc(%t * 8 + 4)
  while (%y < 8) {
    dr -frn $iif(2 // %y,$iif(2 // %x,$th(1),$th(2)),$iif(2 // %x,$th(2),$th(1))) 1 $calc(%x * %t + 7) $calc(%y * %t + 7) %t %t
    inc %x | if (%x > 7) { inc %y | var %x = 0 }
  }
  var %x = 0
  while (%x < 7) {
    drawpeca -n $calc(%x + 2) 1 2 | drawpeca -n $calc(%x + 1) 2 2 | drawpeca -n $calc(%x + 2) 3 2
    set %dama.p2 %dama.p2 $+($calc(%x +2),.,1) | set %dama.p2 %dama.p2 $+($calc(%x + 1),.,2) | set %dama.p2 %dama.p2 $+($calc(%x +2),.,3)
    drawpeca -n $calc(%x + 1) 6 1 | drawpeca -n $calc(%x + 2) 7 1 | drawpeca -n $calc(%x + 1) 8 1
    set %dama.p1 %dama.p1 $+($calc(%x + 1),.,6) | set %dama.p1 %dama.p1 $+($calc(%x +2),.,7) | set %dama.p1 %dama.p1 $+($calc(%x + 1),.,8)
    inc %x 2
  } | dd
}
menu @dama {
  uclick:if (%dama.chat.set) { .timer.dama.sb off | chatset %dama.chat.set | dd | set %dama.chat.set }
  leave:if (%dama.chat.set) { .timer.dama.sb off | chatset %dama.chat.set | dd | set %dama.chat.set }
  sclick:{
    var %x = $calc($t + 102) | var %y = $calc($t + 14) | var %y' = %y + 94 | var %t = %dama.tam
    if $inrect($mouse.x,$mouse.y,%x,%y,11,12) {
      dchat -c | .timer.dama.sb -h 0 500 .timer.dama.sb -h 0 100 dchat -c
      drawscroll @dama 1 1 $calc($t + 102) $calc($t + 14) 11 12 | set %dama.chat.set 1
    }
    if $inrect($mouse.x,$mouse.y,%x,%y',11,12) {
      dchat -b | .timer.dama.sb -h 0 500 .timer.dama.sb -h 0 100 dchat -b
      drawscroll @dama 1 1 $calc($t + 102) $calc($t + 108) 11 12 | set %dama.chat.set 2
    }
    if (!$inrect($mouse.x,$mouse.y,7,7,$calc(%t * 8),$calc(%t * 8))) { return }
    if (%dama.s) && (%dama.s.eu != %dama.vez) { return }
    var %x $int($calc(($mouse.x - 7) / %t + 1)),%y $int($calc(($mouse.y - 7) / %t + 1))
    var %x' $gettok(%dama.mov,1,46),%y' $gettok(%dama.mov,2,46)
    tokenize 32 %x' %y' %x %y %dama.vez %t $+(%x',.,%y') $+(%x,.,%y)
    var %p $calc(80 * ($6 / 100)),%c $calc(55 * ($6 / 100)),%d $calc(25 * ($6 / 100))
    if (%dama.mov) && (%dama.mov != $8) {
      if ($istok($dama.cap($7,$5,mov,abcd),$8,32)) {
        if (%dama.cap) || (%dama.cap2) { return }
        if (%y > %y') { var %* = t } | if (%y < %y') { var %* = y }
        if (($5 = 1) && (%* = t)) || (($5 = 2) && (%* = y)) && (!$istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { return }
        goto a
      }
      elseif ($istok($dama.cap($7,$5,dmov,abcd),$8,32)) {
        if (%dama.cap) || (%dama.cap2) || (!$istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { return }
        :a
        jogada
        if (%dama.jogada) { drawpeca $iif($dama.g($gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32),peca) = dama,-d) $gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32) $iif(%dama.vez = 1,2,1) }
        dr -fr $th(2) 1 $calc((%x' -1) * $6 + 7) $calc((%y' -1) * $6 + 7) $6 $6
        jogada $1-4
        drawpeca $iif($dama.g($1-2,peca) = dama,-d) $3-4 | dd
        set %dama.p [ $+ [ $5 ] ] $remtok(%dama.p [ $+ [ $5 ] ],$7,32) $8
        if (($5 = 1) && (%y = 1)) || (($5 = 2) && (%y = 8)) && (!$istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { set %dama.pd [ $+ [ $5 ] ] %dama.pd [ $+ [ $5 ] ] $8 | dr -re 0 1 $calc(( %x -1 ) * $6 + %d + 6) $calc((%y -1) * $6 + %d + 6) %c %c }
        if ($istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { set %dama.pd [ $+ [ $5 ] ] $reptok(%dama.pd [ $+ [ $5 ] ],$7,$8,1,32) }
        set %dama.vez $iif($5 = 1,2,1) | set %dama.mov | set %dama.cap2 $dama.ck(%dama.vez,pd) 
        if (%dama.s) { sw move $1-4 }
      }
      else {
        var %f,%p
        if (%x > %x') { var %h = d } | if (%x < %x') { var %h = e }
        if (%y > %y') { var %d = b } | if (%y < %y') { var %d = c }
        if (%h = e) { if (%d = c) { var %a = a } | else { var %a = c } }
        else { if (%d = c) { var %a = b } | else { var %a = d } }
        if ($istok($dama.cap($7,$5,p,abcd),$8,32)) {
          if ($dama.cap($7,$5,d,abcd)) { if ($istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { goto t } | goto q }
          else goto q
        }
        if ($istok($dama.cap($7,$5,d,abcd),$8,32)) {
          if (!$istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { return } | :t
          var %b = $dama.ck2($7,$5,$remove(abcd,$iif(%a = a,d,$iif(%a = d,a,$iif(%a = b,c,$iif(%a = c,b))))))
          if (!$istok(%b,$8,32)) && (%a) { return }
          var %f = s
        }
        if (%f = s) { :q
          if (%x > %x') { var %h = d } | if (%x < %x') { var %h = e }
          if (%y > %y') { var %d = b } | if (%y < %y') { var %d = c }
          if (%h = e) { if (%d = c) { var %a = a } | else { var %a = c } }
          else { if (%d = c) { var %a = b } | else { var %a = d } }
          var %p = $dama.cap($+(%x',.,%y'),%dama.vez,peca,%a)
          tokenize 32 %x' %y' $replace(%p,.,$chr(32)) %x %y %dama.vez $iif(%dama.vez = 1,2,1) %t
          set %dama.p [ $+ [ $8 ] ] $remtok(%dama.p [ $+ [ $8 ] ],$+($3,.,$4),32)
          set %dama.p [ $+ [ $7 ] ] $remtok(%dama.p [ $+ [ $7 ] ],$+($1,.,$2),32) $+($5,.,$6)
          set %dama.pd [ $+ [ $8 ] ] $remtok(%dama.pd [ $+ [ $8 ] ],$+($3,.,$4),32)
          if (!%dama.cap) jogada
          if (%dama.jogada) { drawpeca $iif($dama.g($gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32),peca) = dama,-d) $gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32) $iif(%dama.vez = 1,2,1) } | dd
          dr -fr $th(2) 1 $calc(($1 -1) * $9 + 7) $calc(($2 -1) * $9 + 7) $9 $9
          dr -fr $th(2) 1 $calc(($3 -1) * $9 + 7) $calc(($4 -1) * $9 + 7) $9 $9
          dr -fr $th(2) 1 $calc(($5 -1) * $9 + 7) $calc(($6 -1) * $9 + 7) $9 $9
          if (($7 = 1) && ($6 = 1)) || (($7 = 2) && ($6 = 8)) && (!$istok(%dama.pd [ $+ [ $7 ] ],$+($1,.,$2),32)) { set %dama.pd [ $+ [ $7 ] ] %dama.pd [ $+ [ $7 ] ] $+($5,.,$6) | dr -re 0 1 $calc(($5 -1) * $9 + (25 * ($9 / 100)) + 6) $calc(($6 -1) * $9 + (25 * ($9 / 100)) + 6) $calc(55 * ($9 / 100)) $calc(55 * ($9 / 100)) }
          if ($istok(%dama.pd [ $+ [ $7 ] ],$+($1,.,$2),32)) { set %dama.pd [ $+ [ $7 ] ] $reptok(%dama.pd [ $+ [ $7 ] ],$+($1,.,$2),$+($5,.,$6),1,32) }
          if (!%dama.p1) || (!%dama.p2) { dama.venc $iif(%dama.p1,1,2) }
          if ($dama.cap($+($5,.,$6),$7,peca,abcd)) {
            if ($dama.cap($+($5,.,$6),$7,p,abcd)) {
              var %t = %dama.cap
              jogada $iif(%t,-a) $1-6
              set %dama.mov $+($5,.,$6) | set %dama.cap s
              drawpeca $iif($dama.g($5 $6,peca) = dama,-d) $5 $6
              dr -efi 1 1 $calc(($5 -1) * $9 + 7 + $calc(($9 - 80 * ($9 / 100)) / 2) -1) $calc(($6 -1) * $9 + 7 + $calc(($9 - 80 * ($9 / 100)) / 2) -1) $calc(80 * ($9 / 100) + 1) $calc(80 * ($9 / 100) + 1)
              if (%dama.s) { sw come $iif(%t,-a,-b) $1-6 }
            }
            elseif ($dama.cap($+($5,.,$6),$7,d,abcd)) && ($istok(%dama.pd [ $+ [ $7 ] ],$+($5,.,$6),32)) {
              var %t = %dama.cap
              jogada $iif(%t,-a) $1-6
              set %dama.mov $+($5,.,$6) | set %dama.cap s
              drawpeca $iif($dama.g($5 $6,peca) = dama,-d) $5 $6
              dr -efi 1 1 $calc(($5 -1) * $9 + 7 + $calc(($9 - 80 * ($9 / 100)) / 2) -1) $calc(($6 -1) * $9 + 7 + $calc(($9 - 80 * ($9 / 100)) / 2) -1) $calc(80 * ($9 / 100) + 1) $calc(80 * ($9 / 100) + 1)
              if (%dama.s) { sw come $iif(%t,-a,-b) $1-6 }
            }
            else { goto y }
          }
          else { 
            :y
            if (%dama.s) { sw come $iif(%dama.cap,-c) $1-6 }
            jogada $iif(%dama.cap,-a) $1-6 | drawpeca $iif($dama.g($5 $6,peca) = dama,-d) $5 $6
            set %dama.mov | set %dama.vez $8 | set %dama.cap | set %dama.cap2 $dama.ck(%dama.vez,pd)
          }
        }
      }
      return
    }
    if (%dama.cap) return
    if ((2 // $calc(%x +1)) && (2 // $calc(%y +1))) || ((2 // %x) && (2 // %y)) { return }
    if (!$istok(%dama.p [ $+ [ %dama.vez ] ],$+(%x,.,%y),32)) { return }
    if (!$timer(.dama.painel)) { .timer.dama.painel -h 0 250 painel }
    set %dama.mov $iif($+(%x,.,%y) != %dama.mov,$ifmatch)
    dr -efi 1 1 $calc((%x -1) * %t + 7 + $calc((%t - 80 * (%t / 100)) / 2) -1) $calc((%y -1) * %t + 7 + $calc((%t - 80 * (%t / 100)) / 2) -1) $calc(80 * (%t / 100) + 1) $calc(80 * (%t / 100) + 1)
  }
  New:if ($$?!"Do you want to restart the game?") { if (%dama.s) { sw novo $iif($$?!"Will you start playing?",2,1) } | else { vars | draw | .timer.dama.painel off | painel } }
  -
  $iif(%dama.s,$style(2)) Wait for connections:dama.esperar
  $iif(%dama.s,$style(2)) Connect:dama.conectar
  $iif(!%dama.s,$style(2)) Disconnect:dama.desconectar
  -
  Options
  .$iif($opc(1) = s,$style(1)) Mark movements:if ($opc(1) = s) { jogada | var %x = $gettok(%dama.jogada,-2,32) | var %y = $gettok(%dama.jogada,-1,32) | if (%x) && (%y) { drawpeca $iif($dama.g(%x %y,peca) = dama,-d) %x %y $iif(%dama.vez = 1,2,1) } | set %dama.jogada } | dd | opc 1 $iif($opc(1) = s,n,s)
  .$iif($opc(2) = s,$style(1)) Timestamp:opc 2 $iif($opc(2) = s,n,s)
  .$iif($opc(3) = s,$style(1)) Flash:opc 3 $iif($opc(3) = s,n,s)
  .-
  .$iif(!%dama.s,$style(2)) Beep the opponent:sw beep
  .Theme:th
  .Board Size:var %x = $$?"What's the size? Actual: %dama.tam " | if (%x isnum 5- 70) { if ($$?!"You have to restart. $crlf $+ Restart?") { sockclose dama* | set %dama.tam %x | dama } }
  .Chat Font:set %dama.theme $gettok(%dama.theme,1-7,32) $$?"What's the font? Actual: $th(8-) " | if ($!) { inc %dama.chat | dchat -c }
  .Clear chat:drawchat
  -
  $iif(!$isfile($+(",$scriptdirdamas.txt")),$style(2)) Help:run $+(",$scriptdirdamas.txt")
  About:dama.ab
  -
  Exit:if (%dama.s) { if (!$$?!"Do you want to disconnect?") { return } } | dama.desconectar | window -c @dama
}

alias -l jogada {
  if ($opc(1) != s) return
  var %a | if ($1 = -a) { var %a = s | tokenize 32 $2- }
  var %t = %dama.tam
  if (!$1) {
    tokenize 32 %dama.jogada | if (!$1) { return }
    if ($0 = 4) {
      dr -frn $th(2) 1 $calc(($1 - 1) * %t + 7) $calc(($2 - 1) * %t + 7) %t %t
      dr -frn $th(2) 1 $calc(($3 - 1) * %t + 7) $calc(($4 - 1) * %t + 7) %t %t
    }
    elseif ($0 = 6) {
      dr -frn $th(2) 1 $calc(($1 - 1) * %t + 7) $calc(($2 - 1) * %t + 7) %t %t
      dr -frn $th(2) 1 $calc(($3 - 1) * %t + 7) $calc(($4 - 1) * %t + 7) %t %t
      dr -frn $th(2) 1 $calc(($5 - 1) * %t + 7) $calc(($6 - 1) * %t + 7) %t %t
    }
    else {
      var %x = 1
      while $gettok(%dama.jogada,%x,32) {
        dr -fr $th(2) 1 $calc(($ [ $+ [ %x ] ] - 1) * %t + 7) $calc(($ [ $+ [ $calc(%x +1) ] ] - 1) * %t + 7) %t %t
        inc %x 2
      }
    }
  }
  else {
    if ($0 = 4) {
      dr -fr $th(5) 1 $calc(($1 - 1) * %t + 7) $calc(($2 - 1) * %t + 7) %t %t
      dr -fr $th(5) 1 $calc(($3 - 1) * %t + 7) $calc(($4 - 1) * %t + 7) %t %t
      set %dama.jogada $1-4
    }
    if ($0 = 6) {
      dr -fr $th(5) 1 $calc(($1 - 1) * %t + 7) $calc(($2 - 1) * %t + 7) %t %t
      dr -fr $th(6) 1 $calc(($3 - 1) * %t + 7) $calc(($4 - 1) * %t + 7) %t %t
      dr -fr $th(5) 1 $calc(($5 - 1) * %t + 7) $calc(($6 - 1) * %t + 7) %t %t
      set %dama.jogada $iif(%a,%dama.jogada $3-6,$1-6)
    }
  }
}
alias -l dama.cap {
  tokenize 32 $1 $2 $iif($2 = 1,2,1) $3 $4 $5
  var %1 $gettok($1,1,46),%2 $gettok($1,2,46)
  var %a $calc(%1 - 1),%a' = $calc(8 - %1)
  var %b $calc(%2 - 1),%b' = $calc(8 - %2)
  var %peca1,%peca2,%peca3,%peca4 | var %p1,%p2,%p3,%p4 | var %d1,%d2,%d3,%d4 | var %mov1,%mov2,%mov3,%mov4
  var %y = $iif(%a > %b,%b,%a) | var %x 1,%z,%p
  while (%x <= %y) {
    var %c = $calc(%1 - %x) $+ . $+ $calc(%2 - %x)
    if ($istok(%dama.p [ $+ [ $2 ] ],%c,32)) { break }
    elseif ($istok(%dama.p [ $+ [ $3 ] ],%c,32)) { if (%z = s) { break } | var %z = s | var %p = %c | goto 1 }
    else { if (%z != s) { if (%mov1) { var %dmov1 = %mov1 %dmov1 %c } | else { var %mov1 = %c } } }
    if (%z = s) { var %peca1 = %p | if (%x < 3) { var %p1 = %c } | else { var %d1 = %d1 %c } }
    :1 | inc %x
  }
  var %y = $iif(%a' > %b,%b,%a') | var %x 1,%z,%p
  while (%x <= %y) {
    var %c = $calc(%1 + %x) $+ . $+ $calc(%2 - %x)
    if ($istok(%dama.p [ $+ [ $2 ] ],%c,32)) { break }
    elseif ($istok(%dama.p [ $+ [ $3 ] ],%c,32)) { if (%z = s) { break } | var %z = s | var %p = %c | goto 2 }
    else { if (%z != s) { if (%mov2) { var %dmov2 = %mov2 %dmov2 %c } | else { var %mov2 = %c } } }
    if (%z = s) { var %peca2 = %p | if (%x < 3) { var %p2 = %c } | else { var %d2 = %d2 %c } }
    :2 | inc %x
  }
  var %y = $iif(%a > %b',%b',%a) | var %x 1,%z,%p
  while (%x <= %y) {
    var %c = $calc(%1 - %x) $+ . $+ $calc(%2 + %x)
    if ($istok(%dama.p [ $+ [ $2 ] ],%c,32)) { break }
    elseif ($istok(%dama.p [ $+ [ $3 ] ],%c,32)) { if (%z = s) { break } | var %z = s | var %p = %c | goto 3 }
    else { if (%z != s) { if (%mov3) { var %dmov3 = %mov3 %dmov3 %c } | else { var %mov3 = %c } } }
    if (%z = s) { var %peca3 = %p | if (%x < 3) { var %p3 = %c } | else { var %d3 = %d3 %c } }
    :3 | inc %x
  }
  var %y = $iif(%a' > %b',%b',%a') | var %x 1,%z,%p
  while (%x <= %y) {
    var %c = $calc(%1 + %x) $+ . $+ $calc(%2 + %x)
    if ($istok(%dama.p [ $+ [ $2 ] ],%c,32)) { break }
    elseif ($istok(%dama.p [ $+ [ $3 ] ],%c,32)) { if (%z = s) { break } | var %z = s | var %p = %c | goto 4 }
    else { if (%z != s) { if (%mov4) { var %dmov4 = %mov4 %dmov4 %c } | else { var %mov4 = %c } } }
    if (%z = s) { var %peca4 = %p | if (%x < 3) { var %p4 = %c } | else { var %d4 = %d4 %c } }
    :4 | inc %x
  }
  goto $4
  :peca | return $iif(a isin $5,%peca1) $iif(b isin $5,%peca2) $iif(c isin $5,%peca3) $iif(d isin $5,%peca4)
  :p | return $iif(a isin $5,%p1) $iif(b isin $5,%p2) $iif(c isin $5,%p3) $iif(d isin $5,%p4)
  :d | return $iif(a isin $5,%d1) $iif(b isin $5,%d2) $iif(c isin $5,%d3) $iif(d isin $5,%d4)
  :mov | return $iif(a isin $5,%mov1) $iif(b isin $5,%mov2) $iif(c isin $5,%mov3) $iif(d isin $5,%mov4)
  :dmov | return $iif(a isin $5,%dmov1) $iif(b isin $5,%dmov2) $iif(c isin $5,%dmov3) $iif(d isin $5,%dmov4)
}
alias -l dama.ck {
  var %x 1,%p,%d,%f
  while ($gettok(%dama.p [ $+ [ $1 ] ],%x,32)) {
    var %i = $ifmatch | var %p = %p $dama.cap(%i,$1,p,abcd)
    if ($dama.cap(%i,$1,d,abcd)) {
      var %i' = $ifmatch
      var %z = 1 | while ($gettok(%i',%z,32)) { if ($istok(%dama.pd [ $+ [ $1 ] ],%i,32)) { var %d = %d $gettok(%i',%z,32) } | inc %z }
    }
    inc %x
  }
  if (p isin $2) { var %f = %p }
  if (d isin $2) { var %f = %f %d }
  return %f
}
alias -l dama.ck2 {
  var %x = 1 | var %y = $dama.cap($1,$2,p,abcd) $dama.cap($1,$2,d,$3) | var %a,%b
  while ($gettok(%y,%x,32)) {
    var %i = $ifmatch
    if ($numtok($dama.cap(%i,$2,peca,$3),32)) { var %a = %a %i } | else var %b = %b %i
    inc %x
  }
  return $iif(%a,%a,%b)
}
alias -l drawpeca {
  var %a,%n | if ($1 = -d) { var %a = s | tokenize 32 $2- } | if ($1 = -n) { var %n = n | tokenize 32 $2- }
  var %t %dama.tam,%p $calc(80 * (%t / 100)),%d $calc(25 * (%t / 100)),%d2 $calc(55 * (%t / 100)) | var %c = $iif($iif($3,$3,%dama.vez) = 1,$th(3),$th(4))
  dr -efr $+ %n %c 1 $calc(%t * ($1 - 1) + 7 + ((%t - %p) / 2)) $calc(%t * ($2 - 1) + 7 + ((%t - %p) / 2)) %p %p
  if (%a) { dr -er $+ %n 0 1 $calc(($1 -1) * %t + %d + 6) $calc(($2 -1) * %t + %d + 6) %d2 %d2 }
}
alias -l painel {
  if (!$window(@dama)) { .timer.dama.painel off | return }
  var %v %dama.vez,%c $iif(%v = 1,$th(3),0),%c2 $iif(%v = 1,0,$th(4))
  set %dama.tempo $puttok(%dama.tempo,$calc($gettok(%dama.tempo,%v,32) + 0.25),%v,32)
  var %p1 = $iif(%dama.s,$iif(%dama.s.eu = 1,$me,%dama.pl2),$me) | var %p2 = $iif(%p1 = $me,%dama.pl2,$me)
  dr -frn $th(7) 1 $calc($t + 12) 3 106 66
  dr -frn $th(7) 1 $calc($t + 12) $calc($t - 57) 106 66
  dr -rn %c2 1 $calc($t + 15) 5 100 62
  dr -rn %c 1 $calc($t + 15) $calc($t - 53) 100 62
  dt -rbcno %c2 $th(7) verdana 12 $iif($calc(($t + 15) + $painel.(%p2,1)) > $calc($t + 15),$ifmatch,$calc($t + 16)) 10 98 22 %p2
  dt -rbcno %c $th(7) verdana 12 $iif($calc(($t + 15) + $painel.(%p1,1)) > $calc($t + 15),$ifmatch,$calc($t + 16)) $calc($t - 47) 98 22 %p1
  var %t1 $dama.tempo($gettok(%dama.tempo,2,32)),%t2 $dama.tempo($gettok(%dama.tempo,1,32))
  dt -rbno %c2 $th(7) verdana 12 $calc($t + 15 + $painel.(%t1)) 29 %t1
  dt -rbno %c $th(7) verdana 12 $calc($t + 15 + $painel.(%t2)) $calc($t - 29) %t2
  var %t1 Catches: $calc(12 - $numtok(%dama.p1,32)),%t2 Catches: $calc(12 - $numtok(%dama.p2,32))
  dt -rbno %c2 $th(7) verdana 12 $calc($t + 15 + $painel.(%t1)) 46 %t1
  dt -rbno %c $th(7) verdana 12 $calc($t + 15 + $painel.(%t2)) $calc($t - 12) %t2 | dd
}
alias -l painel. return $calc((100 - $width($1,verdana,12,$2)) / 2)
alias -l dama.venc {
  .timer.dama.painel off
  if ($1 = 1) drawreplace -r @dama $th(7) $rgb(0,255,0) $calc($t + 15) $calc($t - 53) 100 62
  if ($1 = 2) drawreplace -r @dama $th(7) $rgb(0,255,0) $calc($t + 15) 5 100 62
}
alias -l dama.g {
  tokenize 32 $replace($1,$chr(32),.) $2-
  goto $2
  :peca | if ($istok(%dama.pd1 %dama.pd2,$1,32)) { return dama } | elseif ($istok(%dama.p1 %dama.p2,$1,32)) { return peca } | return
}
alias -l dama.tempo {
  var %1 = $int($1)
  var %m = $int($calc(%1 / 60)) | var %m = $right(00 $+ %m,$iif($len(%m) > 1,$ifmatch,2))
  var %s = $calc(%1 % 60) | var %s = $right(00 $+ %s,2)
  return $+(%m,:,%s)
}
alias -l dama.conectar sockclose dama* | sockopen dama $iif($1,$1,$$?"IP:") 1 | set %dama.s connecting | dchat Connecting with $! $+ ...
alias -l dama.esperar sockclose dama* | set %dama.s.list $iif($$?!"Will you start?",1,2) | set %dama.s waiting the opponent | socklisten dama. 1 | dchat Waiting...
alias -l dama.desconectar titlebar @dama - by O_Rei_Da_Praia | if (%dama.s) { sockclose dama* | dchat Disconnected. $1- | flash Dama! Disconnected | set %dama.s | set %dama.s.eu | set %dama.s.list | set %dama.pl2 Player 2 | .timer.dama.painel off | .timer.dama.ping off | .timer.dama.pingtimeout off }
on *:socklisten:dama.:{
  sockaccept dama | sockclose dama. | dchat Connected | var %x = %dama.s.list
  vars | draw
  set %dama.vez 1 | if (%x = 1) { sw ini eu $me | set %dama.s.eu 1 | dchat Go! You start... } | else { sw ini vc $me | set %dama.s.eu 2 | dchat Go! Waiting for the opponent movement... }
  set %dama.s socket | set %dama.tempo 0 0 | if (!$timer(.dama.painel)) { .timer.dama.painel -h 0 250 painel }
  flash Dama! Connected
  .timer.dama.ping 0 10 dama.ping
}
alias -l dama.ping sw ping | set %dama.ping $ticks | .timer.dama.pingtimeout 1 60 dama.pingtimeout
alias -l dama.pingtimeout dama.desconectar Ping Time Out!
on *:sockopen:dama:{
  if (!$sockerr) { dchat Connected | set %dama.s socket | .timer.dama.ping 0 10 dama.ping | sw nick $me }
  else { sockclose dama | dchat Connection error! | set %dama.s | set %dama.s.eu | set %dama.s.list | .timer.dama.painel off }
}
on *:sockread:dama:{
  sockread %x | tokenize 32 %x
  var %a,%b,%c
  if ($1 = fala) { dchat $2- }
  if ($1 = beep) { beep | flash Beep! }
  if ($1 = nick) { set %dama.pl2 $2 }
  if ($1 = ini) { vars | draw | if (!$timer(.dama.painel)) { .timer.dama.painel -h 0 250 painel } | if ($2 = vc) { set %dama.s.eu 1 | dchat Started! You play } | else { set %dama.s.eu 2 | dchat Started! Waiting while opponent plays... } | set %dama.s socket | set %dama.pl2 $3 | set %dama.tempo 0 0 }
  if ($1 = novo) { if ($$?!"Player 2 wants to restart game. $iif($2 = 2,He,You) will start. Accept?") { sw novo_aceita $iif($2 = 2,1,2) | vars | draw | set %dama.s socket | set %dama.s.eu $2 | set %dama.vez 1 | dchat You accepted restart the game. Game was restarted! | set %dama.tempo 0 0 } | else { sw novo_recusa } }
  if ($1 = novo_aceita) { vars | draw | set %dama.s socket | set %dama.s.eu $2 | set %dama.vez 1 | dchat Your opponent accepted restart the game. Game restarted! | set %dama.tempo 0 0 }
  if ($1 = novo_recusa) { dchat Your opponent refused restart game! }
  if ($1 = ping) { sw pong }
  if ($1 = pong) { titlebar @dama - by O_Rei_Da_Praia - Lag: $calc(($ticks - %dama.ping) / 1000) $+ s $str($chr(160),4) | .timer.dama.pingtimeout off }
  if ($1 = move) {
    tokenize 32 $2-5 %dama.vez %dama.tam $+($2,.,$3) $+($4,.,$5)
    jogada
    if (%dama.jogada) { drawpeca $iif($dama.g($gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32),peca) = dama,-d) $gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32) $iif(%dama.vez = 1,2,1) } | dd
    dr -fr $th(2) 1 $calc(($1 -1) * $6 + 7) $calc(($2 -1) * $6 + 7) $6 $6
    jogada $1-4
    drawpeca $iif($dama.g($1 $2,peca) = dama,-d) $3 $4
    set %dama.p [ $+ [ $5 ] ] $remtok(%dama.p [ $+ [ $5 ] ],$7,32) $8
    if (($5 = 1) && ($4 = 1)) || (($5 = 2) && ($4 = 8)) && (!$istok(%dama.pd [ $+ [ $5 ] ],$7,32)) {
      set %dama.pd [ $+ [ $5 ] ] %dama.pd [ $+ [ $5 ] ] $8
      drawpeca -d $3 $4
    }
    if ($istok(%dama.pd [ $+ [ $5 ] ],$7,32)) { set %dama.pd [ $+ [ $5 ] ] $reptok(%dama.pd [ $+ [ $5 ] ],$7,$8,1,32) }
    set %dama.vez $iif($5 = 1,2,1) | set %dama.mov | set %dama.cap2 $dama.ck(%dama.vez,pd) 
    flash Dama! Your Turn!
  }
  if ($1 = come) {
    if ($2 = -a) { var %a = s | tokenize 32 $1 $3- }
    if ($2 = -b) { var %b = s | tokenize 32 $1 $3- }
    if ($2 = -c) { var %c = s | tokenize 32 $1 $3- }
    tokenize 32 $2-7 %dama.vez $iif(%dama.vez = 1,2,1) %dama.tam
    if ((!%a) && (!%c)) || (%b) { jogada }
    if ((!%a) && (!%b)) || (%c) { flash Dama! Your turn }
    if (%dama.jogada) { drawpeca $iif($dama.g($gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32),peca) = dama,-d) $gettok(%dama.jogada,-2,32) $gettok(%dama.jogada,-1,32) $8 } | dd
    dr -fr $th(2) 1 $calc(($1 -1) * $9 + 7) $calc(($2 -1) * $9 + 7) $9 $9
    dr -fr $th(2) 1 $calc(($3 -1) * $9 + 7) $calc(($4 -1) * $9 + 7) $9 $9
    dr -fr $th(2) 1 $calc(($5 -1) * $9 + 7) $calc(($6 -1) * $9 + 7) $9 $9
    if ($istok(%dama.pd [ $+ [ $7 ] ],$+($1,.,$2),32)) { set %dama.pd [ $+ [ $7 ] ] $reptok(%dama.pd [ $+ [ $7 ] ],$+($1,.,$2),$+($5,.,$6),1,32) }
    jogada $iif((%a) || (%c),-a) $1-6
    drawpeca $iif($dama.g($5 $6,peca) = dama,-d) $5 $6
    set %dama.p [ $+ [ $8 ] ] $remtok(%dama.p [ $+ [ $8 ] ],$+($3,.,$4),32)
    set %dama.p [ $+ [ $7 ] ] $remtok(%dama.p [ $+ [ $7 ] ],$+($1,.,$2),32) $+($5,.,$6)
    set %dama.pd [ $+ [ $8 ] ] $remtok(%dama.pd [ $+ [ $8 ] ],$+($3,.,$4),32)
    if (($7 = 1) && ($6 = 1)) || (($7 = 2) && ($6 = 8)) && (!$istok(%dama.pd [ $+ [ $7 ] ],$+($1,.,$2),32)) {
      set %dama.pd [ $+ [ $7 ] ] %dama.pd [ $+ [ $7 ] ] $+($5,.,$6)
      drawpeca -d $5 $6
    }
    if ((%b) || (%a)) && (!%c) { dr -efi 1 1 $calc(($5 -1) * $9 + 7 + $calc(($9 - 80 * ($9 / 100)) / 2) -1) $calc(($6 -1) * $9 + 7 + $calc(($9 - 80 * ($9 / 100)) / 2) -1) $calc(80 * ($9 / 100) + 1) $calc(80 * ($9 / 100) + 1) }
    if (!%dama.p1) || (!%dama.p2) { dama.venc $iif(%dama.p1,1,2) }
    if ((!%a) && (!%b)) || (%c) { set %dama.mov | set %dama.cap | set %dama.vez $8 | set %dama.cap2 $dama.ck(%dama.vez,pd) }
  }
}
on *:sockclose:dama:dama.desconectar
on *:close:@dama:dama.desconectar
on *:input:@dama:if ($left($1,1) != /) { dchat $+(<,$me,>) $1- | if (%dama.s) { sw fala $+(<,$me,>) $1- } }
alias -l dama.preview {
  tokenize 32 %dama.theme-
  window -phC +d @dama.preview 0 0 130 145
  drawfill -r @dama.preview $7 1 1 1
  drawrect -r @dama.preview 0 1 3 3 122 122
  var %x 0,%y 0,%t 15,%p $calc(80 * (10 / 100))
  while (%y < 8) {
    drawrect -fr @dama.preview $iif(2 // %y,$iif(2 // %x,$1,$2),$iif(2 // %x,$2,$1)) 1 $calc(%x * %t + 4) $calc(%y * %t + 4) %t %t
    inc %x | if (%x > 7) { inc %y | var %x = 0 }
  }
  var %x = 0
  while (%x < 7) {
    var %p $calc(80 * (%t / 100)),%d $calc(25 * (%t / 100)),%d2 $calc(55 * (%t / 100))
    drawrect -efr @dama.preview $4 1 $calc(%t * ($calc(%x + 2) - 1) + 4 + ((%t - %p) / 2)) $calc(%t * (1 - 1) + 4 + ((%t - %p) / 2)) %p %p
    drawrect -efr @dama.preview $4 1 $calc(%t * ($calc(%x + 1) - 1) + 4 + ((%t - %p) / 2)) $calc(%t * (2 - 1) + 4 + ((%t - %p) / 2)) %p %p
    drawrect -efr @dama.preview $4 1 $calc(%t * ($calc(%x + 2) - 1) + 4 + ((%t - %p) / 2)) $calc(%t * (3 - 1) + 4 + ((%t - %p) / 2)) %p %p
    drawrect -efr @dama.preview $3 1 $calc(%t * ($calc(%x + 1) - 1) + 4 + ((%t - %p) / 2)) $calc(%t * (6 - 1) + 4 + ((%t - %p) / 2)) %p %p
    drawrect -efr @dama.preview $3 1 $calc(%t * ($calc(%x + 2) - 1) + 4 + ((%t - %p) / 2)) $calc(%t * (7 - 1) + 4 + ((%t - %p) / 2)) %p %p
    drawrect -efr @dama.preview $3 1 $calc(%t * ($calc(%x + 1) - 1) + 4 + ((%t - %p) / 2)) $calc(%t * (8 - 1) + 4 + ((%t - %p) / 2)) %p %p
    inc %x 2
  }
  drawrect -fr @dama.preview $5 1 $calc(6 * %t + 4) $calc(3 * %t + 4) %t %t
  drawrect -fr @dama.preview $5 1 $calc(7 * %t + 4) $calc(4 * %t + 4) %t %t
  drawrect -fr @dama.preview $5 1 $calc(2 * %t + 4) $calc(3 * %t + 4) %t %t
  drawrect -fr @dama.preview $6 1 $calc(3 * %t + 4) $calc(4 * %t + 4) %t %t
  drawrect -fr @dama.preview $5 1 $calc(4 * %t + 4) $calc(5 * %t + 4) %t %t
  drawsave @dama.preview dama.preview.bmp
  did -g dama.t 9 dama.preview.bmp
  window -c @dama.preview
}
dialog dama.t {
  title "Dama - by O_Rei_Da_Praia"
  size -1 -1 379 203
  box "Theme", 1, 4 4 372 166
  combo 2, 32 26 138 124, drop
  scroll "", 3, 12 60 176 22,range 255 horizontal
  text "", 4, 191 66 37 13
  scroll "", 5, 12 97 176 22,range 255 horizontal
  text "", 6, 191 104 37 13
  scroll "", 7, 12 134 176 22,range 255 horizontal
  text "", 8, 191 142 37 13
  icon 9, 239 16 131 146
  button "Default", 10, 58 175 79 24,
  button "Save", 11, 150 175 79 24,ok
  button "Cancel", 12, 242 175 79 24,cancel
}
on *:dialog:dama.t:*:*:{
  if ($devent = init) {
    set %dama.theme- %dama.theme
    didtok dama.t 2 58 Squares1:Squares2:Player 1:Player 2:Movement Marker:Catch Marker:Background
    did -c dama.t 2 1 | dama.preview | goto a
  }
  if ($devent = sclick) {
    if ($did = 2) { goto a }
    if ($did = 10) {
      set %dama.theme- 0 16777215 32767 43520 13619151 255 13816530 verdana | dama.preview | :a
      tokenize 44 $rgb($gettok(%dama.theme-,$did(2).sel,32))
      did -a dama.t 4 R: $1 | did -a dama.t 6 G: $2 | did -a dama.t 8 B: $3
      did -c dama.t 3 $1 | did -c dama.t 5 $2 | did -c dama.t 7 $3
    }
    if ($did = 11) {
      if ($window(@dama)) { if ($$?!"You have to restart to change theme. Restart?") { dama.desconectar | set %dama.theme %dama.theme- | dama | return } }
      else { set %dama.theme %dama.theme- | return }
      halt
    }
  }
  if ($devent = scroll) {
    did -ra dama.t 4 R: $did(3).sel | did -ra dama.t 6 G: $did(5).sel | did -ra dama.t 8 B: $did(7).sel
    set %dama.theme- $puttok(%dama.theme-,$rgb($did(3).sel,$did(5).sel,$did(7).sel),$did(2).sel,32)
    dama.preview
  }
  if ($devent = close) { unset %dama.theme- }
}
alias dama.ab {
  window -ph +lt @dama.ab2 -1 -1 207 137
  drawrect @dama.ab2 1 2 5 5 190 104
  drawfill @dama.ab2 15 1 20 20
  drawtext -pb @dama.ab2 1 15 verdana 14 36 18 [3B8r12Z] Damas v1.0
  drawtext @dama.ab2 1 verdana 14 33 48 by O_Rei_Da_Praia
  drawtext @dama.ab2 1 verdana 14 40 78 www.brz.rg3.net
  window -pakC +lt @Dama.ab -1 -1 207 137
  titlebar @dama.ab by O_Rei_Da_Praia
  set %dama.ab.x 8 | .timer.dama.ab -h 0 20 dama.ab.
}
alias -l dama.ab. {
  drawcopy -n @dama.ab2 7 7 186 100 @dama.ab 7 %dama.ab.x
  drawrect -n @dama.ab 14 2 5 5 190 104
  drawfill -n @dama.ab 0 14 1 1
  drawdot @dama.ab
  dec %dama.ab.x
  if (%dama.ab.x < -100) { set %dama.ab.x 110 }
}
menu @dama.ab {
  sclick:window -c @dama.ab | window -c @dama.ab2 | .timer.dama.ab off
}
on *:close:@dama.ab:window -c @dama.ab2 | .timer.dama.ab off
