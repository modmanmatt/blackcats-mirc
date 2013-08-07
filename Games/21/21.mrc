alias -l v21 return v0.01 beta

;black jack 
;0.01b

;events
on 1:LOAD:echo $color(info) -s * Game loaded, type /21
on 1:UNLOAD:unset %21-*
on 1:MIDIEND:{
  if ($window(@Black)) {
    set %21.mname $findfile($scriptdir,*.mid,$r(1,5))
    splay -m $shortfn(%21.mname)
    drawtext -r @Black2 $rgb(250,250,250) Arial 9 18 5 $remove($replace($nopath(%21-mname),$chr(95),$chr(32)),.mid)
  }
}
on 1:CLOSE:@Black:{
  window -c @Black2
  window -c @Black3
  window -c @Black4
  if ($inmidi) splay -m stop
  if ($timer(VU)) .timerVU off
  unset %21.*
}

;draws
;/drawclosecard @ <X Y>
alias -l drawclosecard {
  drawrect -frd $1 $rgb(250,250,250) 1 $2 $3 50 80 10 10
  drawrect -rd $1 $rgb(0,0,0) 1 $2 $3 50 80 10 10
  drawrect -rf $1 $rgb(255,100,100) 1 $calc($2 +5) $calc($3 +5) 40 70
  set %x 0
  while (%x < 35) {
    drawrect -rf $1 $rgb($calc(255- %x),0,0) 1 $calc($2 +5) $calc($3 +5+ %x) 40 1
    drawrect -rf $1 $rgb($calc(200- %x),0,0) 1 $calc($2 +5) $calc($3 +75- %x) 40 1
    if (%x < 20) {
      drawrect -rf $1 $rgb($calc(100+ %x),0,0) 1 $calc($2 +6+ %x) $calc($3 +5) 1 70
      drawrect -rf $1 $rgb($calc(50+ %x),0,0) 1 $calc($2 +44- %x) $calc($3 +5) 1 70
    }
    inc %x 2
  }
}
;/drawcard @ <X Y> <CARTA> <NAIPE>
alias -l drawcard {
  drawrect -frd $1 $rgb(250,250,250) 1 $2 $3 50 80 10 10
  drawrect -rd $1 $rgb(0,0,0) 1 $2 $3 50 80 10 10
  set %21.temp3 $replace($4,10,B,11,J,12,Q,13,K,1,A,B,10)
  set %21.temp2 $iif($5 isin 31,0,255)
  drawtext -ro $1 $rgb(%21.temp2,0,0) $calc($2 +5) $calc($3 +5) %21.temp3
  drawtext -ro $1 $rgb(%21.temp2,0,0) $calc($2 + $iif($len(%21.temp3) = 2,27,35)) $calc($3 + 60) %21.temp3
  drawpic -t $1 $rgb(255,0,255) $calc($2 +16) $calc($3 +31) $calc(($5 -1) *15) 0 15 15 $shortfn($scriptdir21.bmp)
}
;/drawbutton @ <X Y W H> <NAME>
alias -l drawbutton {
  drawrect -rf $1 $rgb(0,50,0) 1 $calc($2 +3) $calc($3 +3) $4 $5
  drawrect -rf $1 $rgb(100,0,0) 1 $2 $3 $4 $5
  drawrect -r $1 $rgb(200,0,0) 1 $2 $3 $4 $5
  drawrect -r $1 $rgb(150,0,0) 1 $calc($2 +1) $calc($3 +1) $calc($4 -1) $calc($5 -1)
  drawline -r $1 $rgb(50,0,0) 1 $calc($2 +1) $calc($3 + $5 -1) $calc($2 + $4) $calc($3 + $5 -1)
  drawline -r $1 $rgb(0,0,0) 1 $2 $calc($3 + $5) $calc($2 + $4) $calc($3 + $5)
  drawline -r $1 $rgb(50,0,0) 1 $calc($2 + $4 -1) $calc($3 +1) $calc($2 + $4 -1) $calc($3 + $5 -1)
  drawline -r $1 $rgb(0,0,0) 1 $calc($2 + $4) $3 $calc($2 + $4) $calc($3 + $5 +1)
  set %21.temp1 $calc((($5 -15)/2)+ $3)
  set %21.temp2 $calc((($4 - $width($6-,arial,12,b))/2)+ $2)
  drawtext -ro @Black2 $rgb(0,0,0) arail 12 $calc(%21.temp2 +1) $calc(%21.temp1 +1) $6-
  drawtext -ro @Black2 $rgb(250,250,250) arail 12 %21.temp2 %21.temp1 $6-
}
;/drawdisbut @ <X Y W H> <NAME>
alias -l drawdisbut {
  drawrect -rf $1 $rgb(0,50,0) 1 $calc($2 +3) $calc($3 +3) $4 $5
  drawrect -rf $1 $rgb(100,100,100) 1 $2 $3 $4 $5
  drawrect -r $1 $rgb(200,200,200) 1 $2 $3 $4 $5
  drawrect -r $1 $rgb(150,150,150) 1 $calc($2 +1) $calc($3 +1) $calc($4 -1) $calc($5 -1)
  drawline -r $1 $rgb(50,50,50) 1 $calc($2 +1) $calc($3 + $5 -1) $calc($2 + $4) $calc($3 + $5 -1)
  drawline -r $1 $rgb(0,0,0) 1 $2 $calc($3 + $5) $calc($2 + $4) $calc($3 + $5)
  drawline -r $1 $rgb(50,50,50) 1 $calc($2 + $4 -1) $calc($3 +1) $calc($2 + $4 -1) $calc($3 + $5 -1)
  drawline -r $1 $rgb(0,0,0) 1 $calc($2 + $4) $3 $calc($2 + $4) $calc($3 + $5 +1)
  set %21.temp1 $calc((($5 -15)/2)+ $3)
  set %21.temp2 $calc((($4 - $width($6-,arial,12,b))/2)+ $2)
  drawtext -ro @Black2 $rgb(200,200,200) arail 12 $calc(%21.temp2 +1) $calc(%21.temp1 +1) $6-
  drawtext -ro @Black2 $rgb(60,60,60) arail 12 %21.temp2 %21.temp1 $6-
}
;/drawclickd @ <X Y W H> <NAME>
alias -l drawclickd {
  drawrect -rf $1 $rgb(0,100,0) 1 $2 $3 $4 $5
  drawrect -rf $1 $rgb(0,50,0) 1 $calc($2 +3) $calc($3 +3) $4 $5
  drawrect -rf $1 $rgb(100,0,0) 1 $2 $3 $4 $5
  drawrect -r $1 $rgb(0,0,0) 1 $2 $3 $4 $5
  drawrect -r $1 $rgb(50,0,0) 1 $calc($2 +1) $calc($3 +1) $calc($4 -1) $calc($5 -1)
  drawline -r $1 $rgb(50,0,0) 1 $calc($2 +1) $calc($3 + $5 -1) $calc($2 + $4) $calc($3 + $5 -1)
  drawline -r $1 $rgb(0,0,0) 1 $2 $calc($3 + $5) $calc($2 + $4) $calc($3 + $5)
  drawline -r $1 $rgb(50,0,0) 1 $calc($2 + $4 -1) $calc($3 +1) $calc($2 + $4 -1) $calc($3 + $5 -1)
  drawline -r $1 $rgb(0,0,0) 1 $calc($2 + $4) $3 $calc($2 + $4) $calc($3 + $5 +1)
  set %21.temp1 $calc((($5 -15)/2)+ $3)
  set %21.temp2 $calc((($4 - $width($6-,arial,12,b))/2)+ $2)
  drawtext -ro @Black2 $rgb(250,250,250) arail 12 $calc(%21.temp2 +1) $calc(%21.temp1 +1) $6-
}

;rungame
alias 21 {
  .enable #MENU21
  window -Ckpdh +btn @Black 0 0 400 250 | titlebar @Black Jack
  drawfill -r @Black $rgb(0,100,0) 1 1 1
  drawtext -r @Black $RGB(250,250,250) Arial 9 5 5 Loading...
  window -hp +d @Black2 0 0 $calc($window(@Black).bw +2) $calc($window(@Black).bh +2)
  window -hp +d @Black3 0 0 $calc($window(@Black).bw +2) $calc($window(@Black).bh +2)
  window -hp +d @Black4 0 0 $calc($window(@Black).bw +2) $calc($window(@Black).bh +2)
  var %a = 50,%b = 5
  while (%a < 115) { drawline -r @Black3 $rgb(0,%a,0) 5 %b -5 -5 %b | inc %a 1 | inc %b 10 }
  if (%21-mname != off) set %21-mname $findfile($scriptdir,*.mid,$r(1,5))
  %21-grana = 1000 | %21.aposta = 0 | %21.bs = button,disbut,disbut,disbut | %21.Tim_Maia = 21 by fnt
  21make 1 | 21copy
  if (%21-mname != off) splay -m $shortfn(%21-mname)
}

;auxeng
alias -l id21 {
  if ($isid) {
    return $iif($calc($replace($remove($replace($1-,10,x,11,x,12,x,13,x,1.,11.),.1,.2,.3,.4),$chr(32),+,x,10)) < 22,$ifmatch,$calc($replace($remove($replace($1-,10,x,11,x,12,x,13,x),.1,.2,.3,.4),$chr(32),+,x,10)))
  }
  elseif ($1 = ihh) {
    set %21.bs $puttok($puttok($puttok(%21.bs,disbut,3,44),disbut,4,44),button,1,44)
    titlebar @Black $replace($window(@Black).title,Jack -,Jack - YOU LOSE -)
    set %21.aposta 000
    unset %21.Tim_Maia
    if (%21-grana = 0) .timerVU -m 1 500 21make 5
    else .timerVU -m 1 500 21make
  }
  elseif ($1 = eee) {
    set %21.bs $puttok($puttok($puttok(%21.bs,disbut,3,44),disbut,4,44),button,1,44)
    titlebar @Black $replace($window(@Black).title,Jack -,Jack - YOU WIN -)
    inc %21-grana $calc(%21.aposta *2)
    set %21.aposta 000
    unset %21.Tim_Maia
    .timerVU -m 1 500 21make
  }
}
alias -l 21bbbbb {
  draw $+ $gettok(%21.bs,1,44) @Black2 310 50 70 18 bet
  draw $+ $gettok(%21.bs,2,44) @Black2 310 130 70 18 start
  draw $+ $gettok(%21.bs,3,44) @Black2 310 170 70 18 hit
  draw $+ $gettok(%21.bs,4,44) @Black2 310 195 70 18 stand
}
alias -l 21endgame {
  if (%21.eg < $gettok(%21.cc,0,32)) {
    drawcard @Black2 $calc(76+( %21.eg *30)) 36 $replace($gettok(%21.cc,$calc(%21.eg +1),32),.,$chr(32))
    21copy | inc %21.eg
    set %x 1 | unset %y | while (%x <= %21.eg) { set %y %y $gettok(%21.cc,%x,32) | inc %x }
    titlebar @Black Jack - You: $id21(%21.mc) - Dealer: $id21(%y)
  }
  else {
    .timerVU off
    titlebar @Black Jack - You: $id21(%21.mc) - Dealer: $id21(%21.cc)
    if ($id21(%21.cc) > 21) { id21 eee }
    elseif ($id21(%21.cc) > $id21(%21.mc)) { id21 ihh }
    else { id21 eee }
  }
}
alias -l 21buycard {
  if ($1) {
    :renato_russo
    tokenize 32 $+($r(1,13),.,$r(1,4))
    if (!$findtok(%21.mc,$1,0,32)) && (!$findtok(%21.cc,$1,0,32)) set %21.cc %21.cc $1
    else goto renato_russo
  }
  else {
    :chico_buarque
    tokenize 32 $+($r(1,13),.,$r(1,4))
    if (!$findtok(%21.mc,$1,0,32)) && (!$findtok(%21.cc,$1,0,32)) set %21.mc %21.mc $1
    else goto chico_buarque
  }
}

;copywintowin
alias -l 21copy {
  drawcopy @Black3 0 0 $window(@Black).bw $window(@Black).bh @Black4 0 0
  drawcopy -t @Black2 $rgb(0,100,0) 0 0 $window(@Black).bw $window(@Black).bh @Black4 0 0
  drawcopy @Black4 0 0 $window(@Black).bw $window(@Black).bh @Black 0 0
}

;drawengine
alias -l 21make {
  drawfill -r @Black2 $rgb(0,100,0) 1 1 1
  if (%21-mname != off) drawtext -r @Black2 $rgb(250,250,250) Webdings 20 5 -2 X
  else drawtext -r @Black2 $rgb(180,180,180) Webdings 20 5 -2 X
  if (%21-mname != off) drawtext -r @Black2 $rgb(250,250,250) Arial 9 18 5 $remove($replace($nopath(%21-mname),$chr(95),$chr(32)),.mid)
  set %21.temp1 $calc(367 - $width(%21-grana,arial,32,B))
  drawtext -ro @Black2 $rgb(0,50,0) Arial 32 $calc(%21.temp1 +1) 5 $+($chr(36),%21-grana)
  drawtext -ro @Black2 $rgb(250,250,250) Arial 32 $calc(%21.temp1 -1) 3 $+($chr(36),%21-grana)
  drawtext -r @Black2 $rgb(0,50,0) Fixedsys 8 335 83 bet
  drawtext -r @Black2 $rgb(250,250,250) Fixedsys 8 334 82 bet
  drawtext -r @Black2 $rgb(0,50,0) Fixedsys 8 330 98 $CHR(36) $+ $iif(%21.aposta,$ifmatch,000)
  drawtext -r @Black2 $rgb(220,250,220) Fixedsys 8 329 97 $CHR(36) $+ $iif(%21.aposta,$ifmatch,000)
  21bbbbb | %x = 10
  while (%x < 16) { drawrect -rd @Black2 $rgb(10,10,10) 1 %x $calc(%x +20) 50 80 10 10 | inc %x }
  drawclosecard @Black2 16 36
  if ($1 = 1) && (%21.Tim_Maia) {
    ;ing version don't have instructions
  }
  elseif ($1 = 2) {
    set %21.ax 0
    while (%21.ax < 91) && ($window(@Black)) {
      drawrect -rf @Black2 $rgb(0,100,0) 1 62 36 100 80
      drawrect -fr @Black2 $rgb(0,100,0) 1 16 113 65 100
      drawclosecard @Black2 16 36
      if (%21.ax < 61) drawclosecard @Black2 $calc(16+ %21.ax) 36
      else drawclosecard @Black2 76 36
      drawclosecard @Black2 16 $calc(36+ %21.ax)
      inc %21.ax 5 | 21copy
    }
    tokenize 46 $+(%21.mc,.,%21.cc)
    drawcard @Black2 16 126 $1 $2
    drawcard @Black2 76 36 $3 $4
    21copy | titlebar @Black Jack - You: $id21(%21.mc) - Dealer: $id21(%21.cc)
  }
  elseif ($1 = 3) {
    if ($gettok(%21.mc,0,32) > 8) {
      set %21.bs $puttok(%21.bs,disbut,3,44)
      drawdisbut @Black2 310 170 70 18 hit
    }
    drawcard @Black2 76 36 $replace(%21.cc,$chr(46),$chr(32)) | set %21.temp6 0
    while (%21.temp6 < $gettok(%21.mc,0,32)) {
      set %21.temp5 $gettok(%21.mc,$calc(%21.temp6 +1),32)
      drawcard @Black2 $calc(16+( %21.temp6 *30)) 126 $gettok(%21.temp5,1,46) $gettok(%21.temp5,2,46)
      inc %21.temp6
    }
    titlebar @Black Jack - You: $id21(%21.mc) - Dealer: $id21(%21.cc)
    if ($id21(%21.mc) > 21) id21 ihh
    elseif ($id21(%21.mc) = 21) id21 eee
    21copy
  }
  elseif ($1 = 4) {
    set %21.temp6 0
    while (%21.temp6 < $gettok(%21.mc,0,32)) {
      set %21.temp5 $gettok(%21.mc,$calc(%21.temp6 +1),32)
      drawcard @Black2 $calc(16+( %21.temp6 *30)) 126 $gettok(%21.temp5,1,46) $gettok(%21.temp5,2,46)
      inc %21.temp6
    }
    set %21.temp3 $calc($replace(%21.mc,$chr(32),+))
    while ($id21(%21.cc) <= $id21(%21.mc)) { 21buycard Cássia Eller }
    drawcard @Black2 76 36 $replace($gettok(%21.cc,1,32),$chr(46),$chr(32))
    21copy | set %21.eg 1
    .timerVU -m 0 500 21endgame
  }
  elseif ($1 = 5) {
    .disable #MENU21 | titlebar @Black Jack - Game Over
    set %21.bs $puttok($puttok($puttok($puttok(%21.bs,disbut,1,44),disbut,2,44),disbut,3,44),disbut,4,44)
    drawrect -rf @Black2 $rgb(0,0,0) 1 0 0 $window(@Black).bw $window(@Black).bh
    drawtext -ro @Black2 $rgb(250,250,250) Arial 32 99 93 GAME OVER
    21copy
  }
  else 21copy
}

menu menubar,status {
  -
  Games
  .&Black Jack
  ..Play it! [/21]:21
  ..-
  ..Author...:{
    window -Ckpdh +btn @About 0 0 220 215
    drawfill -r @About $rgb(0,100,0) 1 1 1
    drawtext -ro @About $RGB(250,250,250) fixedsys 10 5 5 Black Jack Game
    drawtext -r @About $RGB(250,250,250) fixedsys 10 5 20 $v21
    drawclosecard @About 5 45
    drawclosecard @About 35 45
    drawcard @About 65 45 1 1
    drawcard @About 95 45 1 2
    drawcard @About 125 45 1 3
    drawcard @About 155 45 1 4
    drawtext -r @About $RGB(250,250,250) fixedsys 8 5 135 by fnt (fantal@email.com)
    drawtext -r @About $RGB(250,250,250) fixedsys 8 29 150 irc: irc.brasnet.org
    drawtext -r @About $RGB(250,250,250) fixedsys 8 69 165 join #besteam
  }
}

#MENU21 on
menu @Black {
  sclick:{
    if ($mouse.x > 4) && ($mouse.y > 2) && ($mouse.x < 18) && ($mouse.y < 19) {
      drawrect -rf @Black2 $rgb(0,100,0) 1 0 0 200 25
      if ($inmidi) {
        splay -m stop | set %21-mname off
        drawtext -r @Black2 $rgb(180,180,180) Webdings 20 5 -2 X
      }
      else {
        set %21-mname $findfile($scriptdir,*.mid,$r(1,5)) | splay -m $shortfn(%21-mname)
        drawtext -r @Black2 $rgb(250,250,250) Webdings 20 5 -2 X
        drawtext -r @Black2 $rgb(250,250,250) Arial 9 18 5 $remove($replace($nopath(%21-mname),$chr(95),$chr(32)),.mid)
      }
      21copy
    }
    if ($mouse.x > 311) && ($mouse.y > 50) && ($mouse.x < 382) && ($mouse.y < 69) {
      if ($gettok(%21.bs,1,44) == button) {
        drawclickd @Black2 310 50 70 18 bet
        21copy | set %21.temp4 a
      }
      else beep
    }
    if ($mouse.x > 310) && ($mouse.y > 130) && ($mouse.x < 381) && ($mouse.y < 149) {
      if ($gettok(%21.bs,2,44) == button) {
        drawclickd @Black2 310 130 70 18 start
        21copy | set %21.temp4 b
      }
      else beep
    }
    if ($mouse.x > 311) && ($mouse.y > 170) && ($mouse.x < 384) && ($mouse.y < 191) {
      if ($gettok(%21.bs,3,44) == button) {
        drawclickd @Black2 310 170 70 18 hit
        21copy | set %21.temp4 c
      }
      else beep
    }
    if ($mouse.x > 310) && ($mouse.y > 194) && ($mouse.x < 383) && ($mouse.y < 216) {
      if ($gettok(%21.bs,4,44) == button) {
        drawclickd @Black2 310 195 70 18 stand
        21copy | set %21.temp4 d
      }
      else beep
    }
    ;echo if ($mouse.x > $mouse.x $+ ) && ($mouse.y > $mouse.y $+ )
  }
  uclick:{
    ;echo && ($mouse.x < $mouse.x $+ ) && ($mouse.y < $mouse.y $+ )

    if (%21.temp4 == a) {
      drawbutton @Black2 310 50 70 18 bet
      dec %21-grana 100
      inc %21.aposta 100
      if ($gettok(%21.bs,2,44) != button) set %21.bs $puttok(%21.bs,button,2,44)
      if (%21-grana < 100) || (%21.aposta > 899) set %21.bs $puttok(%21.bs,disbut,1,44)
      21make 1
    }
    if (%21.temp4 == b) {
      drawbutton @Black2 310 130 70 18 start
      set %21.bs $puttok($puttok($puttok($puttok(%21.bs,disbut,1,44),disbut,2,44),button,3,44),button,4,44)
      set %21.mc $+($r(1,13),.,$r(1,4))
      :toktok
      tokenize 32 $+($r(1,13),.,$r(1,4))
      if (!$findtok(%21.mc,$1,0,32)) set %21.cc $1
      else goto toktok
      21make 2
    }
    if (%21.temp4 == c) {
      drawbutton @Black2 310 170 70 18 hit
      21buycard
      21make 3
    }
    if (%21.temp4 == d) {
      drawbutton @Black2 310 195 70 18 stand
      set %21.bs $puttok($puttok(%21.bs,disbut,3,44),disbut,4,44)
      21make 4
    }
    21copy
    unset %21.temp4
  }
  leave:{
    unset %21.temp4
    21bbbbb
    21copy
  }
}
#MENU21 end
