on *:LOAD:{
  set %ttt.w 0
  set %ttt.l 0
  set %ttt.gamem pc
  set %ttt.sound on
  echo -a Loaded Boom! TicTacToe v2.0 by X3Man
  echo -a To run the game type /TicTacToe or use the menu
}
alias TicTacToe tttt
alias tttt {
  window -dhapk0 $+ $iif(!%ttt.wx,C) +dt $ttt $iif(!%ttt.wx,0 0,%ttt.wx %ttt.wy) $calc( 300 + 10 ) $calc( 300 + 5 + 100 )
  drawrect $ttt 0 1 -5 -25 $calc( 300 + 10 ) $calc( 300 + 5 + 100 )
  drawrect -r $ttt $rgb(100,100,100) 1 -4 -24 $calc( 300 + 9 ) $calc( 300 + 5 + 99 )
  drawrect -f $ttt 14 1 -4 -24 $calc( 300 + 8 ) $calc( 300 + 5 + 98 )
  drawrect $ttt 1 1 -4 -24 $calc( 300 + 8 ) 18
  drawrect -rf $ttt $rgb(100,100,100) 1 -4 -24 $calc( 300 + 8 ) 17
  drawtext $ttt 1 Fixedsys 15 15 -23 Boom! TicTacToe
  drawline -r $ttt $rgb(50,50,50) 1 16 1 16 19
  drawdot $ttt 1 5 6 -14
  drawr2 1 X
  drawr2 2 _
  drawr2 3 O
  drawr2 4 S
  if ($1 == 1) {
    set %ttt.game on
    drawtext $ttt 1 Fixedsys 15 $calc( ( 300 - 10 - $width(Please wait,Fixedsys,15) ) / 2 ) $calc( 300 + 55 ) Please wait...
    dbut 5 $calc( 300 + 55 ) $calc( 300 - 10 ) 20 End  Game
    var %min = -1
    while (%min < 4) {
      inc %min
      var %min2 = -1
      while (%min2 < 4) {
        inc %min2
        if ((%min == 0) || (%min == 4) || (%min2 == 0) || (%min2 == 4)) {
          set %sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] 1
        }
        else {
          set %sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] 0
          drawrect $ttt 15 1 $calc( %min * 100 - 100 ) $calc( %min2 * 100 - 100 ) 100 100
        }
      }
    }
    drawrect -f $ttt 14 1 3 $calc( $1 * 15 + 50 ) $calc( %maxt.x * 15 + 4 ) 20
    set %ttt.turn $iif(%ttt.gamem != mp,1,$iif(!%ttt.mp,2,1))
    drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 1,You,Opponent)
    drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 20 ) You: 0
    drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 35 ) Opponent: 0
    set %ttt.you 0
    set %ttt.opp 0
    set %ttt.turnb $iif(%ttt.gamem != mp,1,$iif(!%ttt.mp,2,1))
  }
  else {
    set %ttt.game off
    dbut 5 $calc( 300 + 55 ) $calc( 300 - 10 ) 20 Start Game
    drawlogo
  }
}

alias -l drr {
  if (($1 >= 1) && ($1 <= %maxt.x) && ($2 >= 1) && ($2 <= %maxt.y)) {
    drawrect -f $ttt 14 1 $ceil($calc( $1 * 15 - 15 )) $ceil($calc( $2 * 15 - 15 )) 15 15
    drawrect $ttt 0 1 $ceil($calc( $1 * 15 - 15 )) $ceil($calc( $2 * 15 - 15 )) 15 15
  }
}
alias -l drawr {
  if ($2 >= 1) {
    drawrect -f $ttt 0 1 $calc( $1 * 50 - 50 ) $calc( $2 * 50 - 50 ) 15 15
    drawrect -f $ttt $3 1 $calc( $1 * 50 - 50 ) $calc( $2 * 50 - 50 ) 13 13
  }
}
alias -l dbut {

  drawrect -f $ttt 15 1 $1 $2 $3 $4
  drawrect $ttt 0 2 $1 $2 $calc( $3 - 2 ) $calc( $4 - 2 )
  drawrect -r $ttt $rgb(100,100,100) 2 $calc( $1 + 2 ) $calc( $2 + 2 ) $calc( $3 - 2 ) $calc( $4 - 2 )
  drawrect -fr $ttt $rgb(150,150,150) 1 $calc( $1 + 2 ) $calc( $2 + 2 ) $calc( $3 - 4 ) $calc( $4 - 4 )

  drawtext $ttt 1 Fixedsys 15 $calc( $1 + ( $3 - $width($5-,Fixedsys,15) ) / 2 ) $calc( $2 + ( $4 - $height($5-,Fixedsys,15) ) / 2 ) $5-
}
alias -l dbut2 {

  drawrect -f $tttm 15 1 $1 $2 $3 $4
  drawrect $tttm 0 2 $1 $2 $calc( $3 - 2 ) $calc( $4 - 2 )
  drawrect -r $tttm $rgb(100,100,100) 2 $calc( $1 + 2 ) $calc( $2 + 2 ) $calc( $3 - 2 ) $calc( $4 - 2 )
  drawrect -fr $tttm $rgb(150,150,150) 1 $calc( $1 + 2 ) $calc( $2 + 2 ) $calc( $3 - 4 ) $calc( $4 - 4 )

  drawtext $tttm 1 Fixedsys 15 $calc( $1 + ( $3 - $width($5-,Fixedsys,15) ) / 2 ) $calc( $2 + ( $4 - $height($5-,Fixedsys,15) ) / 2 ) $5-
}
alias -l drawr2 {
  drawrect -f $ttt 15 1 $calc( 300 + 10 - $1 * 16 - 5 ) -24 16 16
  drawrect $ttt 0 2 $calc( 300 - $1 * 16 + 10 - 5 ) -24 14 14
  drawrect -r $ttt $rgb(100,100,100) 2 $calc( 300 + 10 - $1 * 16 - 3 ) -22 14 14
  drawrect -fr $ttt $rgb(150,150,150) 1 $calc( 300 + 10 - $1 * 16 - 3 ) -22 12 12
  drawtext $ttt 1 Fixedsys 12 $calc( 300 + 5 - $1 * 16 + ( 16 - $width($2,Fixedsys,12) ) / 2 ) $calc( -24 + ( 16 - $height($2,Fixedsys,12) ) / 2 ) $2
}
alias -l ttt return @TicTacToe
alias drawlogo dlogo $ttt $color(1) -1 $calc( 300 + 2 ) -5 $color(15) $color(0) $calc( 300 + 80 ) $color(1) $color(14) $rgb(175,175,175) $rgb(100,100,100) TicTacToe
alias -l dlogo { set %dlmin 0 | .timerdlogo -m 35 10 dlogo2 $1- }
alias -l dlogo2 { inc %dlmin | drawrect -r $1 $2 1 $calc( $3 + $4 / 2 ) $5 2 %dlmin | { if (%dlmin == 35) { set %dlmin 0 | .timerdlogo2 -m $calc( $4 / 2 ) 1 dlogo3 $1- } } }
alias -l dlogo3 {
  inc %dlmin
  drawrect -r $1 $2 2 $calc( $3 + $4 / 2 - %dlmin  ) $calc( $5 + 5 ) $calc( %dlmin * 2 ) 30
  drawrect -r $1 $6 1 $calc( $3 + $4 / 2 - %dlmin + 2 ) $calc( $5 + 5 + 2 ) $calc( %dlmin * 2 - 4 ) 26
  if (%dlmin == $int($calc( $4 / 2 ))) {
    drawtext -r $1 $7 Tahoma 25 $calc( $3 + $4 / 2 - $width(Boom,Tahoma,25) / 2 ) $calc( $5 + 20 - $height(Boom,Tahoma,25) / 2 ) Boom!
    drawline -r $1 $9 1 $calc( $3 + 5 ) $calc( $5 + $8 - 10 ) $calc( $3 + $4 + 5 ) $calc( $5 + $8 - 10 )
    drawrect -r $1 $9 1 $calc( $3 + $4 / 2 - $width($13-,Tahoma,18) / 2 - 5 ) $calc( $5 + $8 - 20 - 25 ) $calc( 10 + $width($13-,Tahoma,18) ) 20
    drawrect -rf $1 $10 1 $calc( $3 + $4 / 2 - $width($13-,Tahoma,18) / 2 + 1 - 5 ) $calc( $5 + $8 - 20 - 25 + 1 ) $calc( 10 + $width($13-,Tahoma,18) - 2 ) 18
    drawtext -r $1 $11 Tahoma 18 $calc( $3 + $4 / 2 - $width($13-,Tahoma,18) / 2 + 1 ) $calc( $5 + $8 - 20 - 25 + 1 - 4 ) $13-
    set %dlmin 0
    while (%dlmin < $calc( ( $5 + $8 - 45 ) - ( $5 + 35 ) - 2 )) {
      inc %dlmin 3
      drawline -r $1 $12 1 $calc( $3 + $4 / 2 - $width($13-,Tahoma,18) / 2 + 1 ) $calc( $5 + $8 - 20 - %dlmin ) $calc( $3 + $4 / 2 - $width($13-,Tahoma,18) / 2 + 1 + $calc( 10 + $width($13-,Tahoma,18) ) ) $calc( $5 + $8 - 20 - %dlmin )
    }
  }
}
alias -l drawrect {
  if ($left($1,1) == -) drawrect $1 $2 $3 $4 $calc( 5 + $5 ) $calc( 25 + $6 ) $7 $8
  else drawrect $1 $2 $3 $calc( 5 + $4 ) $calc( 25 + $5 ) $6 $7
}
alias -l drawdot {
  if ($left($1,1) == -) drawdot $1 $2 $3 $4 $calc( 5 + $5 ) $calc( 25 + $6 )
  else drawdot $1 $2 $3 $calc( 5 + $4 ) $calc( 25 + $5 )
}

alias -l drawtext {
  if ($left($1,1) == -) drawtext $1 $2 $3 $4 $5 $calc( 5 + $6 ) $calc( 25 + $7 ) $8-
  else drawtext $1 $2 $3 $4 $calc( 5 + $5 ) $calc( 25 + $6 ) $7-
}
alias -l ttthw {
  window -dahpk0 +dt $ttth $calc( $window($ttt).x + 300 - $width($2-,Fixedsys,15) ) $calc( $window($ttt).y - 20 ) $calc( 10 + $width($2-,Fixedsys,15) ) 20
  dbut3 -5 -25 $calc( 10 + $width($2-,Fixedsys,15) ) 20 $2-
  window -a $ttt
  set %ttth.n $1
}
alias -l dbut3 {
  drawrect -f $ttth 15 1 $1 $2 $3 $4
  drawrect $ttth 0 2 $1 $2 $calc( $3 - 2 ) $calc( $4 - 2 )
  drawrect -r $ttth $rgb(100,100,100) 2 $calc( $1 + 2 ) $calc( $2 + 2 ) $calc( $3 - 2 ) $calc( $4 - 2 )
  drawrect -fr $ttth $rgb(150,150,150) 1 $calc( $1 + 2 ) $calc( $2 + 2 ) $calc( $3 - 4 ) $calc( $4 - 4 )
  drawtext $ttth 1 Fixedsys 15 $calc( $1 + ( $3 - $width($5-,Fixedsys,15) ) / 2 ) $calc( $2 + ( $4 - $height($5-,Fixedsys,15) ) / 2 ) $5-
}
;alias -l splay if (%ttt.sound == on) splay $scriptdir $+ \ $+ $1
alias -l ttth return @TicTacToeH
alias -l tttcl {
  if (%ttt.mp) { set %ttt.gamem %ttt.mp | unset %ttt.mp }
  var %min = -1
  while (%min < 4) {
    inc %min
    var %min2 = -1
    while (%min2 < 4) {
      inc %min2
      unset %sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ]
    }
  }
  unset %ttt.you
  unset %ttt.opp
  unset %ttt.turnb
  unset %ttt.turn
  unset %ttt.ny
  unset %ttt.nx
  unset %ttt.int
  unset %ttt.obj
  unset %ttt.currx
  unset %ttt.curry
  unset %tttn.m
  unset %tttn.x
  unset %tttn.y
  unset %ttt.objn
  unset %ttt.points
  unset %inctime
  unset %maxt.x
  unset %maxt.y
  unset %ttt.game
  unset %ttt.mx
  unset %ttt.my
  unset %min
  unset %dlmin
  unset %ttt.mmx
  unset %ttt.mmy
  unset %tttm.x
  unset %tttm.y
  unset %ttth.n
  unset %ttt.mmx
  unset %ttt.mmy
  unset %ttth.n
  window -c $ttt
  if ($timer(dlogo)) .timerdlogo off
  if ($timer(dlogo2)) .timerdlogo2 off
  if ($timer(tttnew)) .timertttnew off
  if ($window($tttm)) window -c $tttm
  if ($window($ttth)) window -c $ttth
}
alias -l getx return $ceil($calc( ( $1 - 5 ) / 100 ))
alias -l gety return $ceil($calc( ( $1 - 25 ) / 100 ))
alias -l drawx {
  drawline $ttt $3 10 $calc( 5 + $1 * 100 - 100 + 15 ) $calc( 25 + $2 * 100 - 100 + 15 ) $calc( 5 + $1 * 100 - 100 + 85 ) $calc( 25 + $2 * 100 - 100 + 85 )
  drawline $ttt $3 10 $calc( 5 + $1 * 100 - 100 + 15 ) $calc( 25 + $2 * 100 - 100 + 85 ) $calc( 5 + $1 * 100 - 100 + 85 ) $calc( 25 + $2 * 100 - 100 + 15 )
}
alias -l drawo {
  drawdot $ttt $3 35 $calc( $1 * 100 - 100 + 52 ) $calc( $2 * 100 - 100 + 50 )
  drawdot $ttt 14 25 $calc( $1 * 100 - 100 + 52 ) $calc( $2 * 100 - 100 + 50 )
}
alias -l ttt.put {
  if (%ttt.sound == on) .timersplayopp -m 1 150 splay -p $+($scriptdir,tttopp.mp3)
  var %min = 0
  var %ttt.bl = 0
  while (%min < 3) {
    inc %min
    var %min2 = 0
    var %ttt.pcr = 0
    while (%min2 < 3) {
      inc %min2
      if (%sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] == 2) inc %ttt.pcr
    }
    if (%ttt.pcr == 2) {
      var %min2 = 0
      while (%min2 < 3) {
        inc %min2
        if (%sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] == 0) {
          drawo %min2 %min 0
          set %sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] 2
          inc %ttt.bl
          drawline $ttt 15 5 55 $calc( %min * 100 - 25 ) 255 $calc( %min * 100 - 25 )
          break
        }
      }
    }
    if (!%ttt.bl) {
      var %min2 = 0
      var %ttt.pcr = 0
      while (%min2 < 3) {
        inc %min2
        if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == 2) inc %ttt.pcr
      }
      if (%ttt.pcr == 2) {
        var %min2 = 0
        while (%min2 < 3) {
          inc %min2
          if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == 0) {
            drawo %min %min2 0
            set %sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] 2
            inc %ttt.bl
            drawline $ttt 15 5 $calc( %min * 100 - 45 ) 75 $calc( %min * 100 - 45 ) 275
            break
          }
        }
      }
    }
    if (%ttt.bl) break
  }
  if (!%ttt.bl) {
    var %min = 0
    var %ttt.pcr = 0
    while (%min < 3) {
      inc %min
      if (%sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] == 2) inc %ttt.pcr
    }
    if (%ttt.pcr == 2) {
      var %min = 0
      while (%min < 3) {
        inc %min
        if (%sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] == 0) {
          drawo %min $calc( 4 - %min ) 0
          drawline $ttt 15 5 55 275 255 75
          set %sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] 2
          inc %ttt.bl
          break
        }
      }
    }
  }
  if (!%ttt.bl) {
    var %min = 0
    var %ttt.pcr = 0
    while (%min < 3) {
      inc %min
      if (%sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] == 2) inc %ttt.pcr
    }
    if (%ttt.pcr == 2) {
      var %min = 0
      while (%min < 3) {
        inc %min
        if (%sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] == 0) {
          drawo %min %min 0
          drawline $ttt 15 5 55 75 255 275
          set %sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] 2
          inc %ttt.bl
          break
        }
      }
    }
  }
  if (!%ttt.bl) {
    var %min = 0
    var %ttt.bl = 0
    while (%min < 3) {
      inc %min
      var %min2 = 0
      var %ttt.pcr = 0
      while (%min2 < 3) {
        inc %min2
        if (%sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] == 1) inc %ttt.pcr
      }
      if (%ttt.pcr == 2) {
        var %min2 = 0
        while (%min2 < 3) {
          inc %min2
          if (%sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] == 0) {
            drawo %min2 %min 0
            set %sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] 2
            inc %ttt.bl
            break
          }
        }
      }
      if (!%ttt.bl) {
        var %min2 = 0
        var %ttt.pcr = 0
        while (%min2 < 3) {
          inc %min2
          if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == 1) inc %ttt.pcr
        }
        if (%ttt.pcr == 2) {
          var %min2 = 0
          while (%min2 < 3) {
            inc %min2
            if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == 0) {
              drawo %min %min2 0
              set %sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] 2
              inc %ttt.bl
              break
            }
          }
        }
      }
      if (%ttt.bl) break
    }
    if (!%ttt.bl) {
      var %min = 0
      var %ttt.pcr = 0
      while (%min < 3) {
        inc %min
        if (%sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] == 1) inc %ttt.pcr
      }
      if (%ttt.pcr == 2) {
        var %min = 0
        while (%min < 3) {
          inc %min
          if (%sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] == 0) {
            drawo %min $calc( 4 - %min ) 0
            set %sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] 2
            inc %ttt.bl
            break
          }
        }
      }
    }
    if (!%ttt.bl) {
      var %min = 0
      var %ttt.pcr = 0
      while (%min < 3) {
        inc %min
        if (%sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] == 1) inc %ttt.pcr
      }
      if (%ttt.pcr == 2) {
        var %min = 0
        while (%min < 3) {
          inc %min
          if (%sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] == 0) {
            drawo %min %min 0
            set %sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] 2
            inc %ttt.bl
            break
          }
        }
      }
    }
    if (!$ttt.chall) {
      set %ttt.turn 1
      drawtext $ttt 14 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 2,You,Opponent)
      drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 1,You,Opponent)
    }
    else ttt.win
  }
  else ttt.win 2
  if (!%ttt.bl) {
    :rand
    var %ttt.randx = $rand(1,3)
    var %ttt.randy = $rand(1,3)
    if (%sq6. [ $+ [ %ttt.randx ] $+ . $+ [ %ttt.randy ] ]) goto rand
    drawo %ttt.randx %ttt.randy 0
    set %sq6. [ $+ [ %ttt.randx ] $+ . $+ [ %ttt.randy ] ] 2
    if (!$ttt.chall) {
      set %ttt.turn 1
      drawtext $ttt 14 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 2,You,Opponent)
      drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 1,You,Opponent)
    }
    else ttt.win
  }
}
alias -l splayend if (%ttt.sound == on) splay -p $+($scriptdir,ttt,$iif($1 == 1,win,$iif($1 == 2,end,equ)),.mp3)
alias -l ttt.win {
  if ($1) {
    if (%ttt.gamem != 2) inc %ttt. [ $+ [ $iif($1 == 1,w,l) ] ]
    set %ttt.turn 0
    drawtext $ttt 14 Fixedsys 15 0 $calc( 305 + 15 * $1 ) $iif($1 == 1,You: %ttt.you,Opponent: %ttt.opp)
    inc %ttt. [ $+ [ $iif($1 == 1,you,opp) ] ]
    drawtext $ttt 1 Fixedsys 15 0 $calc( 305 + 15 * $1 ) $iif($1 == 1,You: %ttt.you,Opponent: %ttt.opp)
  }
  .timertttplat -m 1 550 splayend $1
  .timertttnew 1 3 ttt.new $1
}
alias -l ttt.new {
  set %ttt.turn 0
  var %min = 0
  var %ttt.wyou = 0
  var %ttt.wopp = 0
  while (%min < 3) {
    inc %min
    var %min2 = 0
    while (%min2 < 3) {
      inc %min2
      if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == 1) inc %ttt.wyou
      if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == 2) inc %ttt.wopp
      set %sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] 0
      drawrect -f $ttt 14 1 $calc( %min2 * 100 - 100 ) $calc( %min * 100 - 100 ) 100 100
      drawrect $ttt 15 1 $calc( %min2 * 100 - 100 ) $calc( %min * 100 - 100 ) 100 100
    }
  }
  set %ttt.turn $iif(%ttt.turnb == 1,2,1)
  set %ttt.turnb $iif(%ttt.turnb == 1,2,1)
  if ((%ttt.turn == 2) && (%ttt.gamem == pc)) ttt.put
  drawtext $ttt 14 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 2,You,Opponent)
  drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 1,You,Opponent)
}
alias -l ttt.chall {
  var %ttt.chall = 0
  var %min = 0
  while (%min < 3) {
    inc %min
    var %min2 = 0
    while (%min2 < 3) {
      inc %min2
      if (!%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ]) inc %ttt.chall
    }
  }
  return $iif(%ttt.chall,0,1)
}
alias -l ttt.chline {
  var %min = 0
  var %ttt.bl = 0
  var %ttt.youd1 0
  var %ttt.youd2 0
  while (%min < 3) {
    inc %min
    var %ttt.your 0
    var %ttt.youc 0
    var %min2 = 0
    while (%min2 < 3) {
      inc %min2
      if (%sq6. [ $+ [ %min2 ] $+ . $+ [ %min ] ] == $1) inc %ttt.your
      if (%sq6. [ $+ [ %min ] $+ . $+ [ %min2 ] ] == $1) inc %ttt.youc
    }
    if (%ttt.your == 3) {
      drawline $ttt 15 5 55 $calc( %min * 100 - 25 ) 255 $calc( %min * 100 - 25 )
      var %ttt.bl = 1
    }
    if (%ttt.youc == 3) {
      drawline $ttt 15 5 $calc( %min * 100 - 45 ) 75 $calc( %min * 100 - 45 ) 275
      var %ttt.bl = 1
    }
    if (%sq6. [ $+ [ %min ] $+ . $+ [ $calc( 4 - %min ) ] ] == $1) inc %ttt.youd1
    if (%sq6. [ $+ [ %min ] $+ . $+ [ %min ] ] == $1) inc %ttt.youd2
  }
  if (%ttt.youd1 == 3) {
    drawline $ttt 15 5 55 275 255 75
    var %ttt.bl = 1
  }
  if (%ttt.youd2 == 3) {
    drawline $ttt 15 5 55 75 255 275
    var %ttt.bl = 1
  }
  return %ttt.bl
}
menu @TicTacToe {
  mouse:{
    if (%ttt.moove == on) {
      window $ttt $calc( $window($ttt).x + ( $mouse.x - %ttt.mx ) ) $calc( $window($ttt).y + ( $mouse.y - %ttt.my ) )
      set %ttt.mx $mouse.x
      set %ttt.my $mouse.y
    }
    if ($inrect($mouse.x,$mouse.y,0,0,18,18)) ttttmenu
    if (($mouse.x > 100) || ($mouse.y > 20)) if ($window($tttm)) window -c $tttm
    set %ttt.mmx $mouse.x
    set %ttt.mmy $mouse.y
    if (!$window($ttth)) {
      if ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 16 ),1,16,16)) ttthw 1 Close
      elseif ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 2 * 16 ),1,16,16)) ttthw 2 Minimize
      elseif ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 3 * 16 ),1,16,16)) ttthw 3 $iif($window($ttt).ontop,Remove,Set) window's OnTop Setting
      elseif ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 4 * 16 ),1,16,16)) ttthw 4 Set sound $iif(%ttt.sound == on,off,on)
    }
    else {
      if ((!$inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 16 ),1,16,16)) && (%ttth.n == 1)) window -c $ttth
      elseif ((!$inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 2 * 16 ),1,16,16)) && (%ttth.n == 2)) window -c $ttth
      elseif ((!$inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 3 * 16 ),1,16,16)) && (%ttth.n == 3)) window -c $ttth
      elseif ((!$inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 4 * 16 ),1,16,16)) && (%ttth.n == 4)) window -c $ttth
    }
    if ((%ttt.game == on) && ($inrect($mouse.x,$mouse.y,5,25,300,300))) {
      if (%ttt.turn == 1) {
        if (($getx(%ttt.nx) != $getx($mouse.x)) || ($gety(%ttt.ny) != $gety($mouse.y))) {
          if (!%sq6. [ $+ [ $getx(%ttt.nx) ] $+ . $+  [ $gety(%ttt.ny) ] ]) drawx $getx(%ttt.nx) $gety(%ttt.ny) 14
          if (!%sq6. [ $+ [ $getx($mouse.x) ] $+ . $+  [ $gety($mouse.y) ] ]) drawx $getx($mouse.x) $gety($mouse.y) 15
          set %ttt.nx $mouse.x
          set %ttt.ny $mouse.y
        }
      }
      if ((%ttt.turn == 2) && (%ttt.gamem == 2)) {
        if (($getx(%ttt.nx) != $getx($mouse.x)) || ($gety(%ttt.ny) != $gety($mouse.y))) {
          if (!%sq6. [ $+ [ $getx(%ttt.nx) ] $+ . $+  [ $gety(%ttt.ny) ] ]) drawo $getx(%ttt.nx) $gety(%ttt.ny) 14
          if (!%sq6. [ $+ [ $getx($mouse.x) ] $+ . $+  [ $gety($mouse.y) ] ]) drawo $getx($mouse.x) $gety($mouse.y) 15
          set %ttt.nx $mouse.x
          set %ttt.ny $mouse.y
        }
      }
    }
  }
  sclick:{
    if ((%ttt.game == on) && ($inrect($mouse.x,$mouse.y,5,25,300,300))) {
      if (%ttt.turn == 1) {
        drawx $getx(%ttt.nx) $gety(%ttt.ny) 1
        if (%ttt.sound == on) splay -p $+($scriptdir,tttme.mp3)
        set %sq6. [ $+ [ $getx(%ttt.nx) ] $+ . $+ [ $gety(%ttt.ny) ] ] 1
        if ($ttt.chline(1)) ttt.win 1
        else {
          if ($ttt.chall) ttt.win
          else {
            set %ttt.turn 2
            drawtext $ttt 14 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 2,You,Opponent)
            drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 1,You,Opponent)
            if (%ttt.gamem == pc) ttt.put
          }
        }
        if (%ttt.gamem == mp) sockwrite -n tttt %ttt.nx %ttt.ny
        unset %ttt.nx
        unset %ttt.ny
      }
      elseif ((%ttt.turn == 2) && (%ttt.gamem == 2)) {
        drawo $getx(%ttt.nx) $gety(%ttt.ny) 0
        set %sq6. [ $+ [ $getx(%ttt.nx) ] $+ . $+ [ $gety(%ttt.ny) ] ] 2
        if ($ttt.chline(2)) ttt.win 2
        else {
          if ($ttt.chall) ttt.win
          else {
            set %ttt.turn 1
            drawtext $ttt 14 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 2,You,Opponent)
            drawtext $ttt 1 Fixedsys 15 0 $calc( 300 + 5 ) Next: $iif(%ttt.turn == 1,You,Opponent)
          }
        }
        unset %ttt.nx
        unset %ttt.ny
      }
    }
    if (($mouse.y > 325) && ($inrect($mouse.x,$mouse.y,10,380,290,20))) {
      if (%ttt.game == on) {
        if (%ttt.gamem == mp) {
          sockwrite -n tttt end
          sockclose ttt
          sockclose tttt
        }
        tttcl
        tttt
      }
      else {
        if (%ttt.gamem != mp) {
          tttcl
          tttt 1
        }
        else {
          var %ttt.nick $input(Enter nickname to play with:,e)
          if (%ttt.nick) {
            socklisten ttt 324
            .notice %ttt.nick ttt.play $ip
          }
        }
      }
    }
    if ($mouse.y < 20) {
      if ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 16 ),1,16,16)) {
        if ((%ttt.gamem == mp) && (%ttt.game == on)) {
          sockwrite -n tttt end
          sockclose ttt
          sockclose tttt
        }
        tttcl
      }
      elseif ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 2 * 16 ),1,16,16)) window -n $ttt
      elseif ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 3 * 16 ),1,16,16)) window - $+ $iif($window($ttt).ontop,u,o) $ttt
      elseif ($inrect($mouse.x,$mouse.y,$calc( 300 + 10 - 4 * 16 ),1,16,16)) set %ttt.sound $iif(%ttt.sound == on,off,on)
      else {
        set %ttt.moove on
        set %ttt.mx $mouse.x
        set %ttt.my $mouse.y
      }
    }
  }
  leave:{
    if ((%ttt.mmx < 100) && (%ttt.mmx > 0) && (%ttt.mmy < 20)) { if ($window($tttm)) window -a $tttm }
    else if ($window($tttm)) window -c $tttm
    if ($window($ttth)) window -c $ttth
  }
  uclick:if (%ttt.moove == on) { unset %ttt.moove | set %ttt.wx $window($ttt).x | set %ttt.wy $window($ttt).y }
}
dialog ttt.cm {
  size -1 -1 260 105
  title Boom! TicTacToe Mode Changer
  radio Human vs Computer,1,5 5 250 20
  radio Human vs Human,2,6 30 250 20
  radio Multiplayer (You vs somebody from IRC),3,5 55 250 20
  button OK,4,5 80 250 20,ok
}
on *:DIALOG:ttt.cm:init:*:did -c ttt.cm $iif(%ttt.gamem == pc,1,$iif(%ttt.gamem == 2,2,3))
on *:DIALOG:ttt.cm:sclick:*:{
  if ($did == 1) set %ttt.gamem pc
  if ($did == 2) set %ttt.gamem 2
  if ($did == 3) set %ttt.gamem mp
  if ($did == 4) tttt
}
dialog ttt.st {
  size -1 -1 150 45
  text Wins: %ttt.w,1,5 5 140 15
  text Loses: %ttt.l,2,5 25 140 15
}
menu menubar,status {
  Games
  .TicTacToe
  ..Run:TicTacToe
  ..Change Mode:dialog -m ttt.cm ttt.cm
  ..Statistics:dialog -m ttt.st ttt.st
  ..Help:ttt.help
}
alias ttt.help run $+($scriptdir,tttreadme.txt)
menu @TicTacToeMenu {
  leave:{
    if ($mouse.y < 60) window -c $tttm
    else window -a $ttt
  }
  sclick:{
    if ($mouse.y < 20) ttt.help
    elseif ($mouse.y < 40) dialog -m ttt.st ttt.st
    elseif ($mouse.y < 60) {
      if ((%ttt.gamem == mp) && (%ttt.game == on)) {
        sockwrite -n tttt end
        sockclose ttt
        sockclose tttt
      }
      tttcl
      dialog -m ttt.cm ttt.cm
    }
  }
  mouse:{ set %tttm.x $mouse.x | set %tttm.y $mouse.y }
}
alias -l tttm return @TicTacToeMenu
alias -l ttttmenu { { if ($window($tttm) != $null) return } | window -dhapk0 +dt $tttm $window($ttt).x $calc( $window($ttt).y - 60 ) 100 60 | dbut2 -5 -25 100 20 Help | dbut2 -5 -5 100 20 Statistics | dbut2 -5 15 100 20 Change Mode | window -a $ttt }
on *:Socklisten:ttt:{
  tttcl
  tttt 1
  sockaccept tttt
  sockclose ttt
}
on *:sockread:tttt:{
  if ($sockerr > 0) return
  sockread %ttt.read
  if (%ttt.read == end) { sockclose tttt | tttcl | tttt | unset %ttt.read | return }
  drawo $getx($gettok(%ttt.read,1,32)) $gety($gettok(%ttt.read,2,32)) 0
  set %sq6. [ $+ [ $getx($gettok(%ttt.read,1,32)) ] $+ . $+ [ $gety($gettok(%ttt.read,2,32)) ] ] 2
  if ($ttt.chline(2)) ttt.win 2
  else set %ttt.turn 1
  unset %ttt.read
}
on ^*:NOTICE:*:?:{
  if ($1 == ttt.play) { set %ttt.nickk $nick | set %ttt.address $2 | dialog -m ttt.play ttt.play | haltdef }
  if ($1- == ttt no) { sockclose ttt | set %ttt.nickk $nick | dialog -m ttt.ref ttt.ref | unset %ttt.nickk | haltdef }
}
dialog ttt.ref {
  size -1 -1 250 25
  text %ttt.nickk refused to play with you.,1,5 5 240 15,center
}
dialog ttt.play {
  size -1 -1 360 55
  text %ttt.nickk wants to play with you. Do you wish to play?,1,5 5 350 15, center
  button Yes,2,5 30 175 20
  button No,3,180 30 175 20
}
on *:DIALOG:ttt.play:sclick:*:{
  if ($did != 0) {
    if ($did == 2) {
      set %ttt.mp %ttt.gamem
      set %ttt.gamem mp
      tttt 1
      sockopen ttt %ttt.address 324
    }
    if ($did == 3) {
      .notice %ttt.nickk ttt no
    }
    unset %ttt.address
    unset %ttt.nickk
    dialog -c ttt.play
  }
}
on *:SOCKOPEN:ttt:sockrename ttt tttt
on *:QUIT:{
  if ($nick == $me) {
    if ((%ttt.gamem == mp) && (%ttt.game == on)) {
      sockwrite -n tttt end
      sockclose tttt
    }
  }
}
on *:EXIT:{
  if ((%ttt.gamem == mp) && (%ttt.game == on)) {
    sockwrite -n tttt end
    sockclose tttt
  }
}
