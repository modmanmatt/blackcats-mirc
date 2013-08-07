alias xpoker {
  if (!%_xp.hs) {
    set %_xp.hs 0
  }
  if (!%_xp.color) {
    set %_xp.color green
  }
  if (!%_xp.snds) {
    set %_xp.snds y
  }
  set %_xp.us ""
  set %_xp.uc ""
  set %_xp.ccrd ""
  set %_xp.cards 2-D;3-D;4-D;5-D;6-D;7-D;8-D;9-D;10-D;J-D;Q-D;K-D;A-D;2-H;3-H;4-H;5-H;6-H;7-H;8-H;9-H;10-H;J-H;Q-H;K-H;A-H;2-C;3-C;4-C;5-C;6-C;7-C;8-C;9-C;10-C;J-C;Q-C;K-C;A-C;2-S;3-S;4-S;5-S;6-S;7-S;8-S;9-S;10-S;J-S;Q-S;K-S;A-S
  set %_xp.r1          
  set %_xp.r2          
  set %_xp.r3          
  set %_xp.r4          
  set %_xp.r5          
  set %_xp.eh ""
  unset %_xp.d1
  unset %_xp.d2
  window -adhpk0 +etn @Excess Poker 10 10 600 500
  drawrect -fr @Excess Poker $xpcolor(1) 1 0 0 600 500
  drawrect -fr @Excess Poker $xpcolor(2) 1 180 7 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 306 7 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 117 95 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 243 95 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 369 95 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 180 183 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 306 183 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 117 271 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 243 271 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 369 271 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 180 359 60 85
  drawrect -fr @Excess Poker $xpcolor(2) 1 306 359 60 85  
  set %_xp.ccrd $gettok(%_xp.cards,$r(1,$numtok(%_xp.cards,59)),59)
  if ($gettok(%_xp.ccrd,2,45) == H) || ($gettok(%_xp.ccrd,2,45) == D) {
    set %_xp.s $ifmatch
    set %_xp.c $rgb(255,0,0)
  }
  if ($gettok(%_xp.ccrd,2,45) == S) || ($gettok(%_xp.ccrd,2,45) == C) {
    set %_xp.s $ifmatch
    set %_xp.c $rgb(0,0,0)
  }
  drawota 
  drawcb
}
alias drawcb {
  drawrect -fr @Excess Poker $rgb(200,0,0) 1 117 460 60 9
  drawrect -fr @Excess Poker $rgb(222,0,0) 1 124 462 46 5
  drawrect -fr @Excess Poker $rgb(0,128,0) 1 243 460 60 9
  drawrect -fr @Excess Poker $rgb(0,150,0) 1 250 462 46 5
  drawrect -fr @Excess Poker $rgb(0,0,200) 1 369 460 60 9
  drawrect -fr @Excess Poker $rgb(0,0,222) 1 376 462 46 5
  drawrect -fr @Excess Poker $rgb(200,200,0) 1 180 460 60 9
  drawrect -fr @Excess Poker $rgb(222,222,0) 1 187 462 46 5
  drawrect -fr @Excess Poker $rgb(128,128,128) 1 306 460 60 9
  drawrect -fr @Excess Poker $rgb(150,150,150) 1 313 462 46 5
}
alias drawota {
  drawrect -fr @Excess Poker $xpcolor(1) 1 0 0 112 471
  drawrect -fr @Excess Poker $xpcolor(1) 1 438 0 158 471  
  drawtext -r @Excess Poker $rgb(255,0,0) Broadway 25 11 5 E
  drawtext -r @Excess Poker $rgb(255,255,255) Broadway 25 30 5 xcess
  drawtext -r @Excess Poker $rgb(0,0,0) Broadway 25 11 25 P
  drawtext -r @Excess Poker $rgb(255,255,255) Broadway 25 30 25 oker
  drawline -r @Excess Poker $rgb(255,255,255) 3 8 4 24 4
  drawline -r @Excess Poker $rgb(255,255,255) 3 8 4 8 20
  drawline -r @Excess Poker $rgb(255,255,255) 3 102 67 84 67
  drawline -r @Excess Poker $rgb(255,255,255) 3 102 67 102 51
  drawline -r @Excess Poker $rgb(0,0,0) 1 20 4 102 4 102 55
  drawline -r @Excess Poker $rgb(0,0,0) 1 8 16 8 67 88 67
  ;drawrect -dr @Excess Poker $rgb(255,255,255) 1 8 4 96 62
  ;drawrect -dr @Excess Poker $rgb(0,0,0) 1 9 5 95 61
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 12 21 50 By: fugitive
  drawrect -dr @Excess Poker $rgb(0,0,0) 1 27 85 60 86 8 8
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 185 Final Score:
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 205 0
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 225 High Score:
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 245 %_xp.hs
  drawrect -r @Excess Poker $rgb(0,0,0) 1 115 5 316 441
  drawline -r @Excess Poker $rgb(0,0,0) 1 178 5 178 446
  drawline -r @Excess Poker $rgb(0,0,0) 1 241 5 241 446
  drawline -r @Excess Poker $rgb(0,0,0) 1 304 5 304 446
  drawline -r @Excess Poker $rgb(0,0,0) 1 367 5 367 446 
  drawline -r @Excess Poker $rgb(0,0,0) 1 115 93 431 93
  drawline -r @Excess Poker $rgb(0,0,0) 1 115 181 431 181
  drawline -r @Excess Poker $rgb(0,0,0) 1 115 269 431 269
  drawline -r @Excess Poker $rgb(0,0,0) 1 115 357 431 357
  drawline -r @Excess Poker $rgb(255,255,255) 3 17 421 17 427
  drawline -r @Excess Poker $rgb(255,255,255) 3 17 421 23 421
  drawline -r @Excess Poker $rgb(255,255,255) 3 93 447 93 441
  drawline -r @Excess Poker $rgb(255,255,255) 3 93 447 87 447
  drawline -r @Excess Poker $rgb(0,0,0) 1 21 421 93 421 93 445 
  drawline -r @Excess Poker $rgb(0,0,0) 1 17 425 17 447 91 447
  ;drawrect -dr @Excess Poker $rgb(255,255,255) 1 17 421 76 26 8 8
  ;drawrect -dr @Excess Poker $rgb(0,0,0) 1 18 422 75 25 8 8
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 60 248 Reset
  drawdot -r @Excess Poker $rgb(255,255,255) 3 58 250
  drawdot -r @Excess Poker $rgb(255,255,255) 3 95 262
  drawline -r @Excess Poker $rgb(0,0,0) 1 57 248 93 248 93 260
  drawline -r @Excess Poker $rgb(0,0,0) 1 56 249 56 261 93 261
  drawrect -r @Excess Poker $rgb(0,0,0) 1 17 456 10 10
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 12 35 453 Sounds
  $iif(%_xp.snds == y,drawtext -r @Excess Poker $rgb(255,255,255) Wingdings 14 18 454 ü)
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 12 21 426 New Game
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 440 5 Instructions:
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 21 After opening this window,
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 35 just start placing your cards
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 49 where you want them.
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 440 63 Point of game:
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 77 To score the highest amount
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 91 of points possible.
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 440 105 How?
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 119 By strategically placing
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 133 your cards to make the
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 147 best possible poker hand
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 161 out of the five rows, five
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 447 175 columns, and two diagonals.
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 440 310 Point values:
  drawtext -r @Excess Poker $rgb(255,0,0) Verdana 10 447 324 9. Royal Flush:
  drawtext -r @Excess Poker $rgb(225,30,0) Verdana 10 447 338 8. Straight Flush:
  drawtext -r @Excess Poker $rgb(195,60,0) Verdana 10 447 352 7. Four of a Kind:
  drawtext -r @Excess Poker $rgb(165,90,0) Verdana 10 447 366 6. Full House:
  drawtext -r @Excess Poker $rgb(135,120,0) Verdana 10 447 380 5. Flush:
  drawtext -r @Excess Poker $rgb(105,150,0) Verdana 10 447 394 4. Straight:
  drawtext -r @Excess Poker $rgb(85,180,0) Verdana 10 447 408 3. Three of a Kind:
  drawtext -r @Excess Poker $rgb(55,210,0) Verdana 10 447 422 2. Two Pair:
  drawtext -r @Excess Poker $rgb(0,255,0) Verdana 10 447 436 1. Pair:
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 324 500
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 338 325
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 352 225
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 366 110
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 380 75
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 394 55
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 408 40
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 422 30
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 544 436 10
  drawline -r @Excess Poker $rgb(0,0,0) 1 445 212 445 196 496 196 496 212
  drawrect -r @Excess Poker $rgb(0,0,0) 1 440 212 135 92
  drawline -r @Excess Poker $rgb(0,0,0) 1 507 212 507 303  
  drawtext -r @Excess Poker $rgb(255,255,255) Verdana 12 448 197 Discard 
  drawrect -fdr @Excess Poker $rgb(255,255,255) 1 29 87 56 82 8 8
  if ($gettok(%_xp.ccrd,2,45) == H) || ($gettok(%_xp.ccrd,2,45) == D) {
    set %_xp.s $ifmatch
    set %_xp.c $rgb(255,0,0)
  }
  if ($gettok(%_xp.ccrd,2,45) == S) || ($gettok(%_xp.ccrd,2,45) == C) {
    set %_xp.s $ifmatch
    set %_xp.c $rgb(0,0,0)
  }  
  drawtext -r @Excess Poker %_xp.c Broadway 30 33 91 $gettok(%_xp.ccrd,1,45)
  drawtext -r @Excess Poker %_xp.c Symbol 30 61 131 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
  drawrect -r @Excess Poker $rgb(0,0,0) 1 115 458 316 13
  drawline -r @Excess Poker $rgb(0,0,0) 1 178 458 178 471
  drawline -r @Excess Poker $rgb(0,0,0) 1 241 458 241 471
  drawline -r @Excess Poker $rgb(0,0,0) 1 304 458 304 471
  drawline -r @Excess Poker $rgb(0,0,0) 1 367 458 367 471
}
alias endgame {
  if ($numtok(%_xp.r1,45) == 6) && ($numtok(%_xp.r2,45) == 6) && ($numtok(%_xp.r3,45) == 6) && ($numtok(%_xp.r4,45) == 6) && ($numtok(%_xp.r5,45) == 6) {
    return y
  }
}
alias detcolor {
  if ($1 == op) {
    return $rgb(0,255,0)
  }
  if ($1 == tp) {
    return $rgb(55,210,0)
  }
  if ($1 == tk) {
    return $rgb(85,180,0)
  }
  if ($1 == st) {
    return $rgb(115,150,0)
  }
  if ($1 == fl) {
    return $rgb(145,120,0)
  }
  if ($1 == fh) {
    return $rgb(175,90,0)
  }
  if ($1 == fk) {
    return $rgb(205,60,0)
  }
  if ($1 == sf) {
    return $rgb(235,30,0)
  }
  if ($1 == rf) {
    return $rgb(255,0,0)
  }
}
alias drawarrow {
  var %_xp.ctr = 1
  while (%_xp.ctr <= $gettok(%_xp.eh,0,59)) {
    if ($left($gettok(%_xp.eh,%_xp.ctr,59),1) == r) {
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 1) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 46 411 46
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 46 396 36
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 46 396 56
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 431 40 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 2) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 134 411 134
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 134 396 124
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 134 396 144
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 431 128 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 3) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 222 411 222
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 222 396 212
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 222 396 232
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 431 216 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 4) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 310 411 310
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 310 396 300
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 310 396 320
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 431 304 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 5) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 398 411 398
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 398 396 388
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 398 396 408
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 431 392 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
    }
    if ($left($gettok(%_xp.eh,%_xp.ctr,59),1) == c) {
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 1) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 146 25 146 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 146 426 156 411
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 146 426 136 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 146 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 2) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 209 25 209 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 209 426 219 411
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 209 426 199 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 209 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 3) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 272 25 272 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 272 426 282 411
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 272 426 262 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 272 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 4) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 335 25 335 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 335 426 345 411
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 335 426 325 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 335 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 5) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 398 25 398 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 398 426 408 411
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 398 426 388 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 398 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
    }
    if ($left($gettok(%_xp.eh,%_xp.ctr,59),1) == d) {
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 1) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 25 411 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 426 396 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 426 411 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 432 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
      if ($mid($gettok(%_xp.eh,%_xp.ctr,59),2,1) == 2) {
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 411 25 135 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 426 150 426
        drawline -r @Excess Poker $detcolor($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2)) 2 135 426 135 411
        drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 108 446 $replace($mid($gettok(%_xp.eh,%_xp.ctr,59),4,2),rf,9,sf,8,fk,7,fh,6,fl,5,st,4,tk,3,tp,2,op,1)
      }
    }
    inc %_xp.ctr 1
  }
}
alias xpcolor {
  if (%_xp.color == green) {
    if ($1 == 1) {
      return $rgb(0,128,0)
    }
    elseif ($1 == 2) {
      return $rgb(0,150,0)
    }
  }
  elseif (%_xp.color == red) {
    if ($1 == 1) {
      return $rgb(200,0,0)
    }
    elseif ($1 == 2) {
      return $rgb(222,0,0)
    }
  }
  elseif (%_xp.color == blue) {
    if ($1 == 1) {
      return $rgb(0,0,200)
    }
    elseif ($1 == 2) {
      return $rgb(0,0,222)
    }
  }
  elseif (%_xp.color == yellow) {
    if ($1 == 1) {
      return $rgb(200,200,0)
    }
    elseif ($1 == 2) {
      return $rgb(222,222,0)
    }
  }
  elseif (%_xp.color == gray) {
    if ($1 == 1) {
      return $rgb(128,128,128)
    }
    elseif ($1 == 2) {
      return $rgb(150,150,150)
    }
  }
}
alias drawdccc {
  if ($gettok($2,2,45) == H) || ($gettok($2,2,45) == D) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(255,0,0)
  }
  elseif ($gettok($2,2,45) == S) || ($gettok($2,2,45) == C) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(0,0,0)
  }
  if ($1 == 1) {
    drawrect -dfr @Excess Poker $rgb(255,255,255) 1 443 215 61 86 8 8
    drawtext -r @Excess Poker %_xp.c Broadway 30 445 217 $gettok($2,1,45)
    drawtext -r @Excess Poker %_xp.c Symbol 30 473 257 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
  }
  elseif ($1 == 2) {
    drawrect -dfr @Excess Poker $rgb(255,255,255) 1 511 215 61 86 8 8
    drawtext -r @Excess Poker %_xp.c Broadway 30 513 217 $gettok($2,1,45)
    drawtext -r @Excess Poker %_xp.c Symbol 30 541 257 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
  }
}
alias drawdiscard {
  if (%_xp.d1) && (%_xp.d2) {
    halt
  }
  if ($endgame) {
    halt
  }
  if (%_xp.d1) && ($1 == 1) {
    halt
  }
  if (%_xp.d2) && ($1 == 2) {
    halt
  }
  if ($gettok($2,2,45) == H) || ($gettok($2,2,45) == D) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(255,0,0)
  }
  if ($gettok($2,2,45) == S) || ($gettok($2,2,45) == C) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(0,0,0)
  }
  if ($1 == 1) {
    drawrect -dfr @Excess Poker $rgb(255,255,255) 1 443 215 61 86 8 8
    drawtext -r @Excess Poker %_xp.c Broadway 30 445 217 $gettok($2,1,45)
    drawtext -r @Excess Poker %_xp.c Symbol 30 473 257 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
    set %_xp.d1 $2
  }
  elseif ($1 == 2) {
    drawrect -dfr @Excess Poker $rgb(255,255,255) 1 511 215 61 86 8 8
    drawtext -r @Excess Poker %_xp.c Broadway 30 513 217 $gettok($2,1,45)
    drawtext -r @Excess Poker %_xp.c Symbol 30 541 257 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
    set %_xp.d2 $2
  }
  set %_xp.cards $remtok(%_xp.cards,%_xp.ccrd,59)
  set %_xp.ccrd $gettok(%_xp.cards,$r(1,$numtok(%_xp.cards,59)),59)
  if ($gettok(%_xp.ccrd,2,45) == H) || ($gettok(%_xp.ccrd,2,45) == D) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(255,0,0)
  }
  if ($gettok(%_xp.ccrd,2,45) == S) || ($gettok(%_xp.ccrd,2,45) == C) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(0,0,0)
  }
  drawrect -fdr @Excess Poker $rgb(255,255,255) 1 29 87 56 82 8 8
  drawtext -r @Excess Poker %_xp.c Broadway 30 33 91 $gettok(%_xp.ccrd,1,45)
  drawtext -r @Excess Poker %_xp.c Symbol 30 61 131 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
}
alias drawcard {
  if ($wildtok(%_xp.us,$1,0,59) > 0) {
    halt 
  }
  set %_xp.us $addtok(%_xp.us,$1,59)
  set %_xp.uc $addtok(%_xp.uc,$2,59)
  set $+(%,_xp.,r,$gettok($1,1,45)) $puttok($eval($+(%,_xp.,r,$gettok($1,1,45)),2),$2,$gettok($1,2,45),32)
  var %_xp.x = $calc(119 + (63*($gettok($1,2,45) -1)))
  var %_xp.y = $calc(8 + (88*($gettok($1,1,45) -1)))
  if ($gettok($2,2,45) == H) || ($gettok($2,2,45) == D) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(255,0,0)
  }
  if ($gettok($2,2,45) == S) || ($gettok($2,2,45) == C) {
    var %_xp.s = $ifmatch
    var %_xp.c = $rgb(0,0,0)
  }
  drawrect -fdr @Excess Poker $rgb(255,255,255) 1 %_xp.x %_xp.y 56 82 8 8
  drawtext -r @Excess Poker %_xp.c Broadway 30 $calc(%_xp.x +2) $calc(%_xp.y +2) $gettok($2,1,45)
  drawtext -r @Excess Poker %_xp.c Symbol 30 $calc(%_xp.x + 30) $calc(%_xp.y + 42) $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
  set %_xp.cards $remtok(%_xp.cards,%_xp.ccrd,59)
  if (!$endgame) {
    set %_xp.ccrd $gettok(%_xp.cards,$r(1,$numtok(%_xp.cards,59)),59)
    if ($gettok(%_xp.ccrd,2,45) == H) || ($gettok(%_xp.ccrd,2,45) == D) {
      var %_xp.s = $ifmatch
      var %_xp.c = $rgb(255,0,0)
    }
    if ($gettok(%_xp.ccrd,2,45) == S) || ($gettok(%_xp.ccrd,2,45) == C) {
      var %_xp.s = $ifmatch
      var %_xp.c = $rgb(0,0,0)
    }
    drawrect -fdr @Excess Poker $rgb(255,255,255) 1 29 87 56 82 8 8
    drawtext -r @Excess Poker %_xp.c Broadway 30 33 91 $gettok(%_xp.ccrd,1,45)
    drawtext -r @Excess Poker %_xp.c Symbol 30 61 131 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
  }
  if ($endgame) {
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 305 Calculating...
    drawrect -r @Excess Poker $rgb(255,255,255) 1 10 333 100 10
    chkhnds
    drawrect -fdr @Excess Poker $xpcolor(1) 1 29 87 56 82 8 8
    drawrect -fr @Excess Poker $xpcolor(1) 1 12 205 42 18
    drawrect -fr @Excess Poker $xpcolor(1) 1 12 245 42 18
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 205 %_xp.ls
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 245 %_xp.hs
    drawrect -fr @Excess Poker $xpcolor(1) 1 12 305 94 18
    drawrect -fr @Excess Poker $xpcolor(1) 1 8 270 105 137
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 270 Score: %_xp.ls
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 284 500x %_xp.n.rf = $calc(500*(%_xp.n.rf))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 298 325x %_xp.n.sf = $calc(325*(%_xp.n.sf))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 312 225x %_xp.n.fk = $calc(225*(%_xp.n.fk))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 326 110x %_xp.n.fh = $calc(110*(%_xp.n.fh))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 340 75x %_xp.n.fl = $calc(75*(%_xp.n.fl))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 354 55x %_xp.n.st = $calc(55*(%_xp.n.st))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 368 40x %_xp.n.tk = $calc(40*(%_xp.n.tk))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 382 30x %_xp.n.tp = $calc(30*(%_xp.n.tp))
    drawtext -r @Excess Poker $rgb(255,255,255) Verdana 10 12 396 10x %_xp.n.op = $calc(10*(%_xp.n.op))
  }
}
alias xpgetpos {
  return $calc(116 + (63*($gettok($1,2,45) -1))) $calc(6 + (88*($gettok($1,1,45) -1)))
}
alias xpisevenr {
  return $iif(. !isin $calc($gettok($1,1,45) /2),y)
}
alias xpisevenc {
  return $iif(. !isin $calc($gettok($1,2,45) /2),y)
}
alias xpfomo {
  if ($xpisevenr(%_xp.mr)) && ($xpisevenc(%_xp.mr)) {
    return $xpcolor(1)
  }
  if (!$xpisevenr(%_xp.mr)) && (!$xpisevenc(%_xp.mr)) {
    return $xpcolor(1)
  }
  if ($xpisevenr(%_xp.mr)) && (!$xpisevenc(%_xp.mr)) {
    return $xpcolor(2)
  }
  if (!$xpisevenr(%_xp.mr)) && ($xpisevenc(%_xp.mr)) {
    return $xpcolor(2)
  }
}
menu @Excess Poker {
  mouse:{
    if ($inrect($mouse.x,$mouse.y,116,6,61,86)) {
      if (1-1 !isin %_xp.us) && (%_xp.mr != 1-1) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 1-1
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 115 5 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 119 8 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,180,6,61,86)) {
      if (1-2 !isin %_xp.us) && (%_xp.mr != 1-2) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 1-2
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 179 5 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 182 8 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,243,6,61,86)) {
      if (1-3 !isin %_xp.us) && (%_xp.mr != 1-3) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 1-3
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 242 5 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 245 8 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,306,6,61,86)) {
      if (1-4 !isin %_xp.us) && (%_xp.mr != 1-4) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 1-4
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 305 5 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 308 8 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,369,6,61,86)) {
      if (1-5 !isin %_xp.us) && (%_xp.mr != 1-5) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 1-5
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 368 5 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 371 8 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,116,95,61,86)) {
      if (2-1 !isin %_xp.us) && (%_xp.mr != 2-1) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 2-1
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 116 94 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 119 96 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,180,95,61,86)) {
      if (2-2 !isin %_xp.us) && (%_xp.mr != 2-2) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 2-2
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 179 94 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 182 96 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,243,95,61,86)) {
      if (2-3 !isin %_xp.us) && (%_xp.mr != 2-3) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 2-3
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 242 94 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 245 96 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,306,95,61,86)) {
      if (2-4 !isin %_xp.us) && (%_xp.mr != 2-4) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 2-4
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 305 94 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 308 96 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,369,95,61,86)) {
      if (2-5 !isin %_xp.us) && (%_xp.mr != 2-5) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 2-5
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 368 94 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 371 96 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,116,183,61,86)) {
      if (3-1 !isin %_xp.us) && (%_xp.mr != 3-1) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 3-1
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 116 182 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 119 184 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,180,183,61,86)) {
      if (3-2 !isin %_xp.us) && (%_xp.mr != 3-2) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 3-2
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 179 182 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 182 184 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,243,183,61,86)) {
      if (3-3 !isin %_xp.us) && (%_xp.mr != 3-3) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 3-3
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 242 182 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 245 184 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,306,183,61,86)) {
      if (3-4 !isin %_xp.us) && (%_xp.mr != 3-4) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 3-4
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 305 182 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 308 184 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,369,183,61,86)) {
      if (3-5 !isin %_xp.us) && (%_xp.mr != 3-5) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 3-5
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 368 182 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 371 184 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,116,271,61,86)) {
      if (4-1 !isin %_xp.us) && (%_xp.mr != 4-1) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 4-1
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 116 270 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 119 272 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,180,271,61,86)) {
      if (4-2 !isin %_xp.us) && (%_xp.mr != 4-2) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 4-2
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 179 270 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 182 272 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,243,271,61,86)) {
      if (4-3 !isin %_xp.us) && (%_xp.mr != 4-3) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 4-3
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 242 270 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 245 272 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,306,271,61,86)) {
      if (4-4 !isin %_xp.us) && (%_xp.mr != 4-4) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 4-4
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 305 270 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 308 272 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,369,271,61,86)) {
      if (4-5 !isin %_xp.us) && (%_xp.mr != 4-5) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 4-5
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 368 270 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 371 272 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,116,359,61,86)) {
      if (5-1 !isin %_xp.us) && (%_xp.mr != 5-1) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 5-1
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 116 358 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 119 360 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,180,359,61,86)) {
      if (5-2 !isin %_xp.us) && (%_xp.mr != 5-2) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 5-2
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 179 358 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 182 360 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,243,359,61,86)) {
      if (5-3 !isin %_xp.us) && (%_xp.mr != 5-3) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 5-3
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 242 358 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 245 360 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,306,359,61,86)) {
      if (5-4 !isin %_xp.us) && (%_xp.mr != 5-4) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 5-4
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 305 358 63 88
        drawrect -dfr @Excess Poker $xpcolor(2) 1 308 360 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if ($inrect($mouse.x,$mouse.y,369,359,61,86)) {
      if (5-5 !isin %_xp.us) && (%_xp.mr != 5-5) {
        $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
        set %_xp.mr 5-5
        drawrect -fr @Excess Poker $rgb(0,0,0) 1 368 358 63 88
        drawrect -dfr @Excess Poker $xpcolor(1) 1 371 360 56 82 8 8
        $iif(%_xp.snds == y,splay -w $mircdirGames\_xp\hover.wav)
      }
    }
    if (!$inrect($mouse.x,$mouse.y,115,5,316,441)) {
      $iif(%_xp.mr !isin %_xp.us,drawrect -fr @Excess Poker $xpfomo 1 $xpgetpos(%_xp.mr) 62 87)
      unset %_xp.mr
    }
  }
  sclick:{
    if ($inrect($mouse.x,$mouse.y,56,248,37,12)) {
      set %_xp.hs 0
      drawrect -fr @Excess Poker $xpcolor(1) 1 12 245 42 18
      drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 245 %_xp.hs
    }
    if ($inrect($mouse.x,$mouse.y,17,456,10,10)) {
      if (%_xp.snds == n) {
        drawtext -r @Excess Poker $rgb(255,255,255) Wingdings 14 18 454 ü
        set %_xp.snds y
      }
      elseif (%_xp.snds == y) {
        drawrect -fr @Excess Poker $xpcolor(1) 1 17 454 12 12
        drawrect -r @Excess Poker $rgb(0,0,0) 1 17 456 10 10
        set %_xp.snds n
      }
    }
    if ($inrect($mouse.x,$mouse.y,17,421,76,26)) {
      set %_xp.cards 2-D;3-D;4-D;5-D;6-D;7-D;8-D;9-D;10-D;J-D;Q-D;K-D;A-D;2-H;3-H;4-H;5-H;6-H;7-H;8-H;9-H;10-H;J-H;Q-H;K-H;A-H;2-C;3-C;4-C;5-C;6-C;7-C;8-C;9-C;10-C;J-C;Q-C;K-C;A-C;2-S;3-S;4-S;5-S;6-S;7-S;8-S;9-S;10-S;J-S;Q-S;K-S;A-S
      set %_xp.ccrd $gettok(%_xp.cards,$r(1,$numtok(%_xp.cards,59)),59)
      set %_xp.eh ""
      drawrect -fr @Excess Poker $xpcolor(1) 1 12 205 42 18
      drawrect -fr @Excess Poker $xpcolor(1) 1 12 245 42 18
      drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 205 0
      drawtext -r @Excess Poker $rgb(255,255,255) Verdana 15 12 245 %_xp.hs
      drawrect -fr @Excess Poker $xpcolor(1) 1 108 4 331 453
      drawrect -fr @Excess Poker $xpcolor(2) 1 180 7 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 306 7 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 117 95 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 243 95 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 369 95 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 180 183 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 306 183 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 117 271 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 243 271 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 369 271 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 180 359 60 85
      drawrect -fr @Excess Poker $xpcolor(2) 1 306 359 60 85
      drawrect -r @Excess Poker $rgb(0,0,0) 1 115 5 316 441
      drawline -r @Excess Poker $rgb(0,0,0) 1 178 5 178 446
      drawline -r @Excess Poker $rgb(0,0,0) 1 241 5 241 446
      drawline -r @Excess Poker $rgb(0,0,0) 1 304 5 304 446
      drawline -r @Excess Poker $rgb(0,0,0) 1 367 5 367 446 
      drawline -r @Excess Poker $rgb(0,0,0) 1 115 93 431 93
      drawline -r @Excess Poker $rgb(0,0,0) 1 115 181 431 181
      drawline -r @Excess Poker $rgb(0,0,0) 1 115 269 431 269
      drawline -r @Excess Poker $rgb(0,0,0) 1 115 357 431 357
      drawrect -fr @Excess Poker $xpcolor(1) 1 8 270 100 137
      unset %_xp.d1
      unset %_xp.d2
      unset %_xp.mr
      set %_xp.us ""
      set %_xp.uc ""
      set %_xp.r1          
      set %_xp.r2          
      set %_xp.r3          
      set %_xp.r4          
      set %_xp.r5          
      if ($gettok(%_xp.ccrd,2,45) == H) || ($gettok(%_xp.ccrd,2,45) == D) {
        var %_xp.s = $ifmatch
        var %_xp.c = $rgb(255,0,0)
      }
      if ($gettok(%_xp.ccrd,2,45) == S) || ($gettok(%_xp.ccrd,2,45) == C) {
        var %_xp.s = $ifmatch
        var %_xp.c = $rgb(0,0,0)
      }
      drawrect -fdr @Excess Poker $rgb(255,255,255) 1 29 87 56 82 8 8
      drawtext -r @Excess Poker %_xp.c Broadway 30 33 91 $gettok(%_xp.ccrd,1,45)
      drawtext -r @Excess Poker %_xp.c Symbol 30 61 131 $replace(%_xp.s,C,§,D,¨,H,©,S,ª)
      drawrect -fr @Excess Poker $xpcolor(1) 1 443 215 61 86
      drawrect -fr @Excess Poker $xpcolor(1) 1 511 215 61 86
    }
    if ($inrect($mouse.x,$mouse.y,117,460,60,9)) {
      drawreplace -r @Excess Poker $xpcolor(1) $rgb(200,0,0) 0 0 600 500
      drawreplace -r @Excess Poker $xpcolor(2) $rgb(222,0,0) 0 0 600 500
      set %_xp.color red
      drawcb
      drawota
      $iif(%_xp.d1,drawdccc 1 %_xp.d1)
      $iif(%_xp.d2,drawdccc 2 %_xp.d2)
    }
    if ($inrect($mouse.x,$mouse.y,180,460,60,9)) {
      drawreplace -r @Excess Poker $xpcolor(1) $rgb(200,200,0) 0 0 600 500
      drawreplace -r @Excess Poker $xpcolor(2) $rgb(222,222,0) 0 0 600 500
      set %_xp.color yellow
      drawcb
      drawota
      $iif(%_xp.d1,drawdccc 1 %_xp.d1)
      $iif(%_xp.d2,drawdccc 2 %_xp.d2)
    }
    if ($inrect($mouse.x,$mouse.y,243,460,60,9)) {
      drawreplace -r @Excess Poker $xpcolor(1) $rgb(0,128,0) 0 0 600 500
      drawreplace -r @Excess Poker $xpcolor(2) $rgb(0,150,0) 0 0 600 500
      set %_xp.color green
      drawcb
      drawota
      $iif(%_xp.d1,drawdccc 1 %_xp.d1)
      $iif(%_xp.d2,drawdccc 2 %_xp.d2)
    }
    if ($inrect($mouse.x,$mouse.y,306,460,60,9)) {
      drawreplace -r @Excess Poker $xpcolor(1) $rgb(128,128,128) 0 0 600 500
      drawreplace -r @Excess Poker $xpcolor(2) $rgb(150,150,150) 0 0 600 500
      set %_xp.color gray
      drawcb
      drawota
      $iif(%_xp.d1,drawdccc 1 %_xp.d1)
      $iif(%_xp.d2,drawdccc 2 %_xp.d2)
    }
    if ($inrect($mouse.x,$mouse.y,369,460,60,9)) {
      drawreplace -r @Excess Poker $xpcolor(1) $rgb(0,0,200) 0 0 600 500
      drawreplace -r @Excess Poker $xpcolor(2) $rgb(0,0,222) 0 0 600 500
      set %_xp.color blue
      drawcb
      drawota
      $iif(%_xp.d1,drawdccc 1 %_xp.d1)
      $iif(%_xp.d2,drawdccc 2 %_xp.d2)
    }
    if ($inrect($mouse.x,$mouse.y,116,6,61,86)) {
      if (1-1 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 116 6 62 87
      drawcard 1-1 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,180,6,61,86)) {
      if (1-2 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 179 6 62 87
      drawcard 1-2 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,243,6,61,86)) {
      if (1-3 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 242 6 62 87
      drawcard 1-3 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,306,6,61,86)) {
      if (1-4 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 305 6 62 87
      drawcard 1-4 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,369,6,61,86)) {
      if (1-5 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 368 6 62 87
      drawcard 1-5 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,116,95,61,86)) {
      if (2-1 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 116 94 62 87
      drawcard 2-1 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,180,95,61,86)) {
      if (2-2 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 179 94 62 87
      drawcard 2-2 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,243,95,61,86)) {
      if (2-3 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 242 94 62 87
      drawcard 2-3 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,306,95,61,86)) {
      if (2-4 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 305 94 62 87
      drawcard 2-4 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,369,95,61,86)) {
      if (2-5 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 368 94 62 87
      drawcard 2-5 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,116,183,61,86)) {
      if (3-1 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 116 182 62 87
      drawcard 3-1 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,180,183,61,86)) {
      if (3-2 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 179 182 62 87
      drawcard 3-2 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,243,183,61,86)) {
      if (3-3 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 242 182 62 87
      drawcard 3-3 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,306,183,61,86)) {
      if (3-4 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 305 182 62 87
      drawcard 3-4 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,369,183,61,86)) {
      if (3-5 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 368 182 62 87
      drawcard 3-5 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,116,271,61,86)) {
      if (4-1 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 116 270 62 87
      drawcard 4-1 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,180,271,61,86)) {
      if (4-2 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 179 270 62 87
      drawcard 4-2 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,243,271,61,86)) {
      if (4-3 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 242 270 62 87
      drawcard 4-3 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,306,271,61,86)) {
      if (4-4 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 305 270 62 87
      drawcard 4-4 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,369,271,61,86)) {
      if (4-5 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 368 270 62 87
      drawcard 4-5 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,116,359,61,86)) {
      if (5-1 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 116 358 62 87
      drawcard 5-1 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,180,359,61,86)) {
      if (5-2 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 179 358 62 87
      drawcard 5-2 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,243,359,61,86)) {
      if (5-3 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 242 358 62 87
      drawcard 5-3 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,306,359,61,86)) {
      if (5-4 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(2) 1 305 358 62 87
      drawcard 5-4 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,369,359,61,86)) {
      if (5-5 isin %_xp.us) {
        halt
      }
      drawrect -fr @Excess Poker $xpcolor(1) 1 368 358 62 87
      drawcard 5-5 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,443,215,61,86)) {
      drawdiscard 1 %_xp.ccrd
    }
    if ($inrect($mouse.x,$mouse.y,510,215,61,86)) {
      drawdiscard 2 %_xp.ccrd
    }
  }
}
alias crd {
  if ($left($1,1) == r) {
    return $crdr($1,$2,$3)
  }
  elseif ($left($1,1) == c) {
    return $crdc($1,$2,$3) 
  }
  elseif ($left($1,1) == d) {
    return $crdd($1,$2,$3) 
  }
}
alias crdr {
  if ($3 == s) {
    return $gettok($gettok($eval($+($eval(%_xp.,0),$1),2),$2,32),2,45)
  }
  elseif ($3 == v) {
    return $replace($gettok($gettok($eval($+($eval(%_xp.,0),$1),2),$2,32),1,45),J,11,Q,12,K,13,A,14)
  }
}
alias crdc {
  if ($3 == s) {
    return $crd($+(r,$2),$right($1,1),s)
  }
  elseif ($3 == v) {
    return $crd($+(r,$2),$right($1,1),v)
  }
}
alias crdd {
  var %_xp.d1 = $+($crd(r1,1,v),-,$crd(r1,1,s)) $+($crd(r2,2,v),-,$crd(r2,2,s)) $+($crd(r3,3,v),-,$crd(r3,3,s)) $+($crd(r4,4,v),-,$crd(r4,4,s)) $+($crd(r5,5,v),-,$crd(r5,5,s))
  var %_xp.d2 = $+($crd(r1,5,v),-,$crd(r1,5,s)) $+($crd(r2,4,v),-,$crd(r2,4,s)) $+($crd(r3,3,v),-,$crd(r3,3,s)) $+($crd(r4,2,v),-,$crd(r4,2,s)) $+($crd(r5,1,v),-,$crd(r5,1,s))
  if ($3 == s) {
    if ($1 == d1) {
      return $gettok($gettok(%_xp.d1,$2,32),2,45)
    }
    elseif ($1 == d2) {
      return $gettok($gettok(%_xp.d2,$2,32),2,45)
    }
  }
  elseif ($3 == v) {
    if ($1 == d1) {
      return $gettok($gettok(%_xp.d1,$2,32),1,45)
    }
    elseif ($1 == d2) {
      return $gettok($gettok(%_xp.d2,$2,32),1,45)
    }
  }
}
alias ifstrt {
  if ($calc($gettok($sorttok($1-,32,n),5,32) - $gettok($sorttok($1-,32,n),4,32)) == 1) && ($calc($gettok($sorttok($1-,32,n),4,32) - $gettok($sorttok($1-,32,n),3,32)) == 1) && ($calc($gettok($sorttok($1-,32,n),3,32) - $gettok($sorttok($1-,32,n),2,32)) == 1) && ($calc($gettok($sorttok($1-,32,n),2,32) - $gettok($sorttok($1-,32,n),1,32)) == 1) {
    return y
  }
}
alias iffk {
  var %_xp.x = 2
  while (%_xp.x <= 14) {
    if ($wildtok($1-,%_xp.x,0,32) == 4) {
      return y
    }
    inc %_xp.x 1
  }
}
alias iftk {
  var %_xp.x = 2
  while (%_xp.x <= 14) {
    if ($wildtok($1-,%_xp.x,0,32) == 3) {
      return y
    }
    inc %_xp.x 1
  }
}
alias iffh {
  var %_xp.x = 2
  var %_xp.y = $1-
  while (%_xp.x <= 14) {
    if ($wildtok(%_xp.y,%_xp.x,0,32) == 3) {
      var %_xp.z = 1
      while (%_xp.z <= 3) {
        var %_xp.y = $remtok(%_xp.y,%_xp.x,1,32)
        inc %_xp.z 1
      }
      var %_xp.x2 = 2
      while (%_xp.x2 <= 14) {
        if ($wildtok(%_xp.y,%_xp.x2,0,32) == 2) {
          return y
        }
        inc %_xp.x2 1
      }
    }
    inc %_xp.x 1
  }
}
alias iftp {
  var %_xp.x = 2
  while (%_xp.x <= 14) {
    if ($wildtok($1-,%_xp.x,0,32) == 2) {
      var %_xp.y = 2
      while (%_xp.y <= 14) {
        if ($wildtok($1-,%_xp.y,0,32) == 2) && (%_xp.y != %_xp.x) {
          return y
        }
        inc %_xp.y 1
      }
    }
    inc %_xp.x 1
  }
}
alias ifop {
  var %_xp.x = 2
  while (%_xp.x <= 14) {
    if ($wildtok($1-,%_xp.x,0,32) == 2) {
      return y
    }
    inc %_xp.x 1
  }
}
alias chkhnds {
  var %_xp.hnds = r1;r2;r3;r4;r5;c1;c2;c3;c4;c5;d1;d2
  var %_xp.pts = 0
  set %_xp.n.rf 0
  set %_xp.n.sf 0
  set %_xp.n.fk 0
  set %_xp.n.fh 0
  set %_xp.n.fl 0
  set %_xp.n.st 0
  set %_xp.n.tk 0
  set %_xp.n.tp 0
  set %_xp.n.op 0
  ;Royal Flush
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 11 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 11 335 11%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.rfv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    var %_xp.rfs = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,s)
    if ($sorttok(%_xp.rfv,32,n) == 10 11 12 13 14) {
      if ($wildtok(%_xp.rfs,S,0,32) == 5) || ($wildtok(%_xp.rfs,D,0,32) == 5) || ($wildtok(%_xp.rfs,H,0,32) == 5) || ($wildtok(%_xp.rfs,C,0,32) == 5) {
        set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) rf,1,59)
        var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
        var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
        var %_xp.pts = $calc(%_xp.pts + 500)
        set %_xp.n.rf $calc(%_xp.n.rf + 1)
      }
    }
    inc %_xp.ctr 1
  }
  ;Straight Flush
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 22 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 22 335 22%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.sfv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    var %_xp.sfs = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,s)
    if ($gettok($sorttok(%_xp.sfv,32,n),5,32) == 14) && ($gettok($sorttok(%_xp.sfv,32,n),1-4,32) == 2 3 4 5) {
      if ($wildtok(%_xp.sfs,S,0,32) == 5) || ($wildtok(%_xp.sfs,D,0,32) == 5) || ($wildtok(%_xp.sfs,H,0,32) == 5) || ($wildtok(%_xp.sfs,C,0,32) == 5) {
        set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) sf,1,59)
        var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
        var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
        var %_xp.pts = $calc(%_xp.pts + 325)
        set %_xp.n.sf $calc(%_xp.n.sf + 1)
      }
    }
    if ($ifstrt($crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)) == y) {
      if ($wildtok(%_xp.sfs,S,0,32) == 5) || ($wildtok(%_xp.sfs,D,0,32) == 5) || ($wildtok(%_xp.sfs,H,0,32) == 5) || ($wildtok(%_xp.sfs,C,0,32) == 5) {
        set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) sf,1,59)
        var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
        var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
        var %_xp.pts = $calc(%_xp.pts + 325)
        set %_xp.n.sf $calc(%_xp.n.sf + 1)
      }
    }
    inc %_xp.ctr 1
  }
  ;Four Of A Kind
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 33 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 33 335 33%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.fkv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    if ($iffk(%_xp.fkv) == y) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) fk,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 225)
      set %_xp.n.fk $calc(%_xp.n.fk + 1)
    }
    inc %_xp.ctr 1
  }
  ;Full House
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 44 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 44 335 44%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.fhv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    if ($iffh(%_xp.fhv) == y) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) fh,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 110)
      set %_xp.n.fh $calc(%_xp.n.fh + 1)
    }
    inc %_xp.ctr 1
  }
  ;Flush
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 55 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 55 335 55%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.fls = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,s) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,s)
    if ($wildtok(%_xp.fls,S,0,32) == 5) || ($wildtok(%_xp.fls,D,0,32) == 5) || ($wildtok(%_xp.fls,H,0,32) == 5) || ($wildtok(%_xp.fls,C,0,32) == 5) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) fl,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 75)
      set %_xp.n.fl $calc(%_xp.n.fl + 1)
    }
    inc %_xp.ctr 1
  }
  ;Straight
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 66 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 66 335 66%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.stv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    if ($gettok($sorttok(%_xp.stv,32,n),5,32) == 14) && ($gettok($sorttok(%_xp.stv,32,n),1-4,32) == 2 3 4 5) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) st,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 55)
      set %_xp.n.st $calc(%_xp.n.st + 1)
    }
    if ($ifstrt($crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)) == y) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) st,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 55)
      set %_xp.n.st $calc(%_xp.n.st + 1)
    }
    inc %_xp.ctr 1
  }
  ;Three Of A Kind
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 77 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 77 335 77%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.tkv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    if ($iftk(%_xp.tkv) == y) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) tk,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 40)
      set %_xp.n.tk $calc(%_xp.n.tk + 1)
    }
    inc %_xp.ctr 1
  }
  ;Two Pair
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 88 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 88 335 88%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.tpv = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    if ($iftp(%_xp.tpv) == y) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) tp,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 30)
      set %_xp.n.tp $calc(%_xp.n.tp + 1)
    }
    inc %_xp.ctr 1
  }
  ;One Pair
  drawrect -fr @Excess Poker $rgb(0,0,0) 1 11 334 98 8
  drawtext -r @Excess Poker $xpcolor(1) Verdana 5 98 335 99%
  var %_xp.ctr = 1
  while (%_xp.ctr <= $numtok(%_xp.hnds,59)) {
    var %_xp.tov = $crd($gettok(%_xp.hnds,%_xp.ctr,59),1,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),2,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),3,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),4,v) $crd($gettok(%_xp.hnds,%_xp.ctr,59),5,v)
    if ($ifop(%_xp.tov) == y) {
      set %_xp.eh $instok(%_xp.eh,$gettok(%_xp.hnds,%_xp.ctr,59) op,1,59)
      var %_xp.hnds = $remtok(%_xp.hnds,$gettok(%_xp.hnds,%_xp.ctr,59),59)
      var %_xp.hnds = $instok(%_xp.hnds, ,1,59)
      var %_xp.pts = $calc(%_xp.pts + 10)
      set %_xp.n.op $calc(%_xp.n.op + 1)
    }
    inc %_xp.ctr 1
  }
  set %_xp.ls %_xp.pts
  if (%_xp.pts > %_xp.hs) {
    set %_xp.hs %_xp.pts
    $iif(%_xp.snds == y,splay -w $mircdir_xp\highscore.wav)
  }
  drawarrow
}
on 1:CLOSE:@Excess Poker:{
  unset %_xp.mr
  unset %_xp.d1
  unset %_xp.d2
}
menu menubar,status {
  Games
  .Excess Poker
  ..Open:xpoker
  ..Unload-Remove
  ...Confirm Unload:unload -rs excesspoker.mrc
}
on 1:UNLOAD:unset %_xp.*
on 1:LOAD:{
  echo -s Thank you for downloading Excess Poker.
  echo -s To play, type /xpoker or right click on any channel and go to Excess Poker
}
