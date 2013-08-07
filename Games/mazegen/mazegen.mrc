on *:load:{ if $version < 5.8) { echo -s you need atleast version 5.8 or later to run this game. unloading... | unload -rs mazegen\mazegen.mrc }
  else { echo MazeGenerator v1.0 loaded. Author: Xander Ramos email: tinorknitz@yahoo.com
    echo right click on your status window and look for MazeGenerator. you can also find MazeGenerator on your menubar.
echo this script generates 'random' maze puzzles. enjoy.Ü } }

alias m.defaults { set %ma.dfclty 3 | set %ma.width 21 | set %ma.lengtha 1 | set %ma.length $calc(%ma.width + %ma.lengtha)
set %ma.key 3 | set %ma.bc 1 | set %ma.pc 0 | set %ma.players 1 }

alias xandermaze {
  unset %m.*
  ;just in case the values are incorrectly set
  if (%ma.dfclty > 15) || (%ma.dfclty < 3) || (%ma.dfclty == $null) { set %ma.dfclty 3 }
  if (%ma.key > 10) || (%ma.key == $null) || (%ma.key < 0) { set %ma.key 3 }
  if (%ma.lengtha > 9) || (%ma.lengtha < 1) || (%ma.lengtha == $null) { set %ma.lengtha 1 }
  if (%ma.width > 45) || (%ma.width < 15) || (%ma.width == $null) { set %ma.width 21 }
  if ($calc(%ma.length - %ma.width) <= 0) || ($calc(%ma.length - %ma.width) > 9) { set %ma.length $calc(%ma.width + 1) }
  set %ma.length $calc(%ma.width + %ma.lengtha)
  if (%ma.bc == $null) || (%ma.bc < 0) || (%ma.bc > 14) { set %ma.bc 1 }
  if (%ma.pc == $null) || (%ma.pc < 0) || (%ma.pc > 14) { set %ma.pc 0 }
  if (%ma.bc == %ma.pc) { echo background and pipe cannot be of the same color. changing back to defaults... | set %ma.bc 1 | set %ma.pc 0 }
  if (%ma.players <= 0) || (%ma.players > 2) { set %ma.players 1 }
  if (%ma.players == 1) { unset %ma.keyleft2 | unset %ma.you }
  set %ma.keyleft %ma.key
  if (%ma.players == 2) { set %ma.keyleft2 %ma.key }
  set %m.c 0

  if (%ma.pc == 0) { set %ma.border 16777215 }
  elseif (%ma.pc == 1) { set %ma.border 0 }
  elseif (%ma.pc == 3) { set %ma.border 37632 }
  elseif (%ma.pc == 6) { set %ma.border 10223772 }
  elseif (%ma.pc == 14) { set %ma.border 8355711 }
  else { halt }

  :start
  window -c @maze_menu
  window -c @maze_credits
  window -c @maze
  window -pdo +d @maze 1 1 1000 705
  clear @maze
  ;TAENA! bket ayaw gumana ng write -c $+($mircdir,maze.txt) tsk tsk.. hmm..
  write -c mazegen\maze.txt
  drawfill @maze %ma.bc 1 10 10
  drawline @maze 1 60 1 690 1000 690
  drawline @maze 0 2 1 660 1010 660
  drawtext @maze 0 arial 15 190 665 MazeGenerator v1.0
  drawtext @maze 0 arial 15 184 680 Author: Xander Ramos
  drawline @maze 0 2 520 660 520 705
  drawline @maze 0 2 165 660 165 705
  drawline @maze 0 2 350 660 350 705
  drawrect @maze 0 1 980 1 15 15
  drawrect @maze 0 1 965 1 15 15
  drawline @maze 0 2 967 12 977 12
  drawline @maze 0 2 982 3 993 13
  drawline @maze 0 2 982 13 993 3
  drawrect @maze 0 2 1 1 25 18
  drawtext -b @maze 0 1 arial 13 2 2 Esc

  ;---------------------------------
  ;generate random maze
  ;---------------------------------
  set %m.ctr2 %ma.dfclty
  set %m.ctr 0
  set %m.percom $abs($round($calc(((%m.ctr2 / %ma.dfclty) * 100) - 100),0))

  while (%m.ctr2 > 0) {
    drawline @maze 1 20 560 683 990 683
    drawtext @maze 0 arial 15 570 675 Generating Random Maze. Please wait...  %m.percom $+ % completed.
    set %m.x 458
    set %m.y 328
    set %m.prevdir 0

    while (%m.x > 35) && (%m.y > 30) && (%m.x < 940) && (%m.y < 630) {

      if (%m.prevdir == 0) { set %m.dir $rand(1,4) }
      if (%m.prevdir == 4) { set %m.dir $rand(1,4) | while (%m.dir == 2) && ($rand(1,5) > 1) { set %m.dir $rand(1,4) } }
      if (%m.prevdir == 3) { set %m.dir $rand(1,4) | while (%m.dir == 1) && ($rand(1,5) > 1) { set %m.dir $rand(1,4) } }
      if (%m.prevdir == 2) { set %m.dir $rand(1,4) | while (%m.dir == 4) && ($rand(1,5) > 1) { set %m.dir $rand(1,4) } }
      if (%m.prevdir == 1) { set %m.dir $rand(1,4) | while (%m.dir == 3) && ($rand(1,5) > 1) { set %m.dir $rand(1,4) } }      

      if (%m.dir == 1) {
        set %m.y $calc(%m.y - %ma.length) 
        if ($read(mazegen\maze.txt, s, $+(%m.x,.,%m.y)) == $null) {
          drawline -n @maze %ma.pc %ma.width %m.x $calc(%m.y + %ma.length) %m.x %m.y
          write mazegen\maze.txt $+(%m.x,.,%m.y,$chr(32),%m.dir)
          set %m.prevdir 1
        }
        else { $iif($rand(1,100) == 1, drawline -n @maze %ma.pc %ma.width %m.x $calc(%m.y + %ma.length) %m.x %m.y, continue) }
      }
      if (%m.dir == 2) {
        set %m.x $calc(%m.x + %ma.length) 
        if ($read(mazegen\maze.txt, s, $+(%m.x,.,%m.y)) == $null) {
          drawline -n @maze %ma.pc %ma.width $calc(%m.x - %ma.length) %m.y %m.x %m.y
          write mazegen\maze.txt $+(%m.x,.,%m.y,$chr(32),%m.dir)
          set %m.prevdir 2 
        }
        else { $iif($rand(1,100) == 1, drawline -n @maze %ma.pc %ma.width $calc(%m.x - %ma.length) %m.y %m.x %m.y, continue) }
      }
      if (%m.dir == 3) {
        set %m.y $calc(%m.y + %ma.length) 
        if ($read(mazegen\maze.txt, s, $+(%m.x,.,%m.y)) == $null) {
          drawline -n @maze %ma.pc %ma.width %m.x $calc(%m.y - %ma.length) %m.x %m.y
          write mazegen\maze.txt $+(%m.x,.,%m.y,$chr(32),%m.dir)
          set %m.prevdir 3
        }
        else { $iif($rand(1,100) == 1, drawline -n @maze %ma.pc %ma.width %m.x $calc(%m.y - %ma.length) %m.x %m.y, continue) }
      }
      if (%m.dir == 4) {
        set %m.x $calc(%m.x - %ma.length) 
        if ($read(mazegen\maze.txt, s, $+(%m.x,.,%m.y)) == $null) {
          drawline -n @maze %ma.pc %ma.width $calc(%m.x + %ma.length) %m.y %m.x %m.y
          write mazegen\maze.txt $+(%m.x,.,%m.y,$chr(32),%m.dir)
          set %m.prevdir 4
        }
        else { $iif($rand(1,100) == 1, drawline -n @maze %ma.pc %ma.width $calc(%m.x + %ma.length) %m.y %m.x %m.y, continue) }
      }
    }
    write mazegen\maze.txt %m.ctr2 %m.x %m.y
    dec %m.ctr2
    inc %m.ctr
    set %m.percom $abs($round($calc(((%m.ctr2 / %ma.dfclty) * 100) - 100),0))
    drawline @maze 1 20 560 683 990 683
    drawtext @maze 0 arial 15 570 675 Generating Random Maze. Please wait...  %m.percom $+ % completed.
  }
  drawline @maze
  drawline @maze 1 20 560 683 950 683

  ;------------------------
  ;eto ung mga dulo
  ;------------------------
  while (%m.ctr > 0) {
    set $+(%,m.pse,%m.ctr) $read(mazegen\maze.txt, s, %m.ctr)
    dec %m.ctr
  }

  ;-------------------------------------------------------------------
  ;math part, computation ng distance ng mga dulo
  ;distance of x and y muna
  ;-------------------------------------------------------------------
  set %m.ctrsub 1
  set %m.decctr $calc($var(%m.pse*) - %m.ctrsub)
  set %m.xander 0
  :discom
  set %m.ctr $calc($var(%m.pse*) - %m.xander)
  set %m.mctr 1
  while (%m.decctr > 0 ) {
    set $+(%,m.dis,%m.xander,%m.mctr) $abs($calc($gettok($var(%m.pse*,%m.ctr).value,1,32) - $gettok($var(%m.pse*,$calc(%m.ctr - %m.mctr)).value,1,32))) $&
      $abs($calc($gettok($var(%m.pse*,%m.ctr).value,2,32) - $gettok($var(%m.pse*,$calc(%m.ctr - %m.mctr)).value,2,32)))
    inc %m.mctr
    dec %m.decctr
  }
  inc %m.xander
  inc %m.ctrsub
  set %m.decctr $calc($var(%m.pse*) - %m.ctrsub)
  if (%m.decctr > 0) { goto discom } 

  ;--------------------------------------------------------------------
  ;computation ng hypotenuse (tama ba isfell? hehe)
  ;--------------------------------------------------------------------
  set %m.ctr $var(%m.dis*)
  while (%m.ctr > 0 ) {
    set $+(%,m.hyp,%m.ctr) $round($calc(((($gettok($var(%m.dis*,%m.ctr).value,1,32)) ^ 2) + (($gettok($var(%m.dis*,%m.ctr).value,2,32)) ^ 2)) ^ (1/2)),2)
    dec %m.ctr
  }

  ;---------------------------
  ;sorting hypotenuse
  ;---------------------------
  set %m.ctr $var(%m.hyp*)
  while (%m.ctr > 0) {
    set %m.allhyp $instok(%m.allhyp,$var(%m.hyp*,%m.ctr).value,$calc($numtok(%m.allhyp,32) + 1),32)
    dec %m.ctr
  }
  set %m.longest $findtok(%m.allhyp,$gettok($sorttok(%m.allhyp,32,nr),1,32),1,32)

  ;------------------------------
  ;determining start/end
  ;------------------------------
  set %m.ctrsub 1
  set %m.patx 1
  set %m.paty %m.patx
  set %m.ctr $calc($var(%m.pse*) - %m.ctrsub)
  :pattern
  while (%m.ctr > 0) {
    set %m.pattern $instok(%m.pattern,$+(%m.patx,.,$calc(%m.patx + %m.paty)),$calc($numtok(%m.pattern,32) + 1),32)
    dec %m.ctr
    inc %m.paty
  }
  inc %m.patx
  set %m.paty 1
  inc %m.ctrsub
  set %m.ctr $calc($var(%m.pse*) - %m.ctrsub)
  if (%m.ctr > 0) { goto pattern }

  set %m.start $gettok($gettok(%m.pattern,%m.longest,32),2,46)
  set %m.end $gettok($gettok(%m.pattern,%m.longest,32),1,46)

  set %m.sc $read(mazegen\maze.txt, s, %m.start)
  set %ma.ec $read(mazegen\maze.txt, s, %m.end)
  if (%m.sc == %ma.ec) { goto start }

  drawdot @maze 4 7 %ma.ec
  drawdot @maze 7 4 %m.sc

  set %ma.me %m.sc
  if (%ma.players == 2) { set %ma.you %m.sc }

  ;------------------
  ;placing keys
  ;------------------
  unset %ma.keyscoor
  unset %ma.rectscoor
  while ($numtok(%ma.keyscoor,44) < $iif(%ma.players == 2, $calc(%ma.key * 2), %ma.key)) {
    :key
    set %m.randkey $read(mazegen\maze.txt)
    if ($numtok(%m.randkey, 32) == 3) { goto key }
    set %m.tempcoor $gettok(%m.randkey,1,46) $mid($gettok(%m.randkey,1,32),$calc($len($gettok(%m.randkey,1,46))+2))
    if (%m.tempcoor == %ma.ec) { goto key }
    if (%m.tempcoor == %m.sc) { goto key }
    set %ma.keyscoor $addtok(%ma.keyscoor,$gettok(%m.randkey,1,46) $mid($gettok(%m.randkey,1,32),$calc($len($gettok(%m.randkey,1,46))+2)),44)
    set %ma.rectscoor $addtok(%ma.rectscoor,$calc($gettok(%m.randkey,1,46)-6) $+ $chr(44) $+ $calc($mid($gettok(%m.randkey,1,32),$calc($len($gettok(%m.randkey,1,46))+2))-6) $+ $chr(44) $+ 9 $+ $chr(44) $+ 9,46)
    drawdot @maze $iif(%ma.pc == 12, 4, 12) 4 $gettok(%m.randkey,1,46) $mid($gettok(%m.randkey,1,32),$calc($len($gettok(%m.randkey,1,46))+2))
    drawrect -e @maze $iif(%ma.pc == 4, 1, 4) 1 $calc($gettok(%m.randkey,1,46)-6) $calc($mid($gettok(%m.randkey,1,32),$calc($len($gettok(%m.randkey,1,46))+2))-6) 9 9
  }
  drawtext @maze 0 arial 15 70 680 Keys Left: %ma.keyleft
  drawdot @maze 12 4 55 692
  drawrect -e @maze 4 1 49 686 9 9
  .enable #cursorkeydown1

  if (%ma.players == 2) {
    drawtext @maze 0 arial 15 420 680 Keys Left: %ma.keyleft2
    drawdot @maze 12 4 405 692
    drawrect -e @maze 4 1 399 686 9 9
    .enable #cursorkeydown2
  }
  unset %m.*

}


;------------------------------
;keydown key acquired
;------------------------------

alias m.keydown {
  set %m.ctr 1
  while (%m.ctr <= $numtok(%ma.rectscoor,46)) {
    set %m.x $gettok(%ma.me,1,32)
    set %m.y $gettok(%ma.me,2,32)
    tokenize 44 $gettok(%ma.rectscoor,%m.ctr,46)
    if ($inrect(%m.x,%m.y,$1,$2,$3,$4) == $true) && (%ma.keyleft > 0) { drawrect -fe @maze %ma.pc 1 $1 $2 $3 $4
      ;splay $+($mircdir,mazegen,\,move.wav)
      set %ma.rectscoor $deltok(%ma.rectscoor,%m.ctr,46)
      set %ma.keyscoor $deltok(%ma.keyscoor,%m.ctr,44)
      set %ma.keyleft $calc(%ma.keyleft - 1)
      drawline @maze 1 20 70 689 150 689
      drawtext @maze 0 arial 15 70 680 Keys Left: %ma.keyleft
      drawline @maze 1 20 560 683 990 683
      drawtext @maze 0 arial 15 570 675 Player 1 obtained key.
      .timermazegetkey1 1 3 drawline @maze 1 20 560 683 990 683
    }
    inc %m.ctr
  }
}

alias m.keydown2 {
  set %m.ctr 1
  while (%m.ctr <= $numtok(%ma.rectscoor,46)) {
    set %m.x $gettok(%ma.you,1,32)
    set %m.y $gettok(%ma.you,2,32)
    tokenize 44 $gettok(%ma.rectscoor,%m.ctr,46)
    if ($inrect(%m.x,%m.y,$1,$2,$3,$4) == $true) && (%ma.keyleft2 > 0) { drawrect -fe @maze %ma.pc 1 $1 $2 $3 $4
      ;splay $+($mircdir,mazegen,\,move.wav)
      set %ma.rectscoor $deltok(%ma.rectscoor,%m.ctr,46)
      set %ma.keyscoor $deltok(%ma.keyscoor,%m.ctr,44)
      set %ma.keyleft2 $calc(%ma.keyleft2 - 1)
      drawline @maze 1 20 420 689 500 689
      drawtext @maze 0 arial 15 420 680 Keys Left: %ma.keyleft2
      drawline @maze 1 20 560 683 990 683
      drawtext @maze 0 arial 15 570 675 Player 2 obtained key.
      .timermazegetkey2 1 3 drawline @maze 1 20 560 683 990 683
    }
    inc %m.ctr
  }
}

;--------------------
;mouse getkey
;--------------------

alias m.sclick {
  if (%m.c == 1) {
    set %m.ctr 1
    while (%m.ctr <= $numtok(%ma.rectscoor,46)) {
      set %m.x $mouse.x
      set %m.y $mouse.y
      tokenize 44 $gettok(%ma.rectscoor,%m.ctr,46)
      if ($inrect(%m.x,%m.y,$1,$2,$3,$4) == $true) && (%ma.keyleft > 0) { drawrect -fe @maze %ma.pc 1 $1 $2 $3 $4
        splay $+($mircdir,mazegen,\,getkey.wav)
        set %ma.rectscoor $deltok(%ma.rectscoor,%m.ctr,46)
        set %ma.keyscoor $deltok(%ma.keyscoor,%m.ctr,44)
        set %ma.keyleft $calc(%ma.keyleft - 1)
        drawline @maze 1 20 70 689 150 689
        drawtext @maze 0 arial 15 70 680 Keys Left: %ma.keyleft
        drawline @maze 1 20 560 683 990 683
        drawtext @maze 0 arial 15 570 675 Player 1 obtained key.
        .timermazegetkey1 1 3 drawline @maze 1 20 560 683 990 683
      }
      inc %m.ctr
  } }
  if ($inrect($mouse.x,$mouse.y,980,1,15,15) == $true) { $iif($?!="Quit Game?" == $true, window -c @maze, halt) }
  if ($inrect($mouse.x,$mouse.y,965,1,15,15) == $true) { window -n @maze }
}

alias m.rclick {
  if (%m.c == 1) {
    set %m.ctr 1
    while (%m.ctr <= $numtok(%ma.rectscoor,46)) {
      set %m.x $mouse.x
      set %m.y $mouse.y
      tokenize 44 $gettok(%ma.rectscoor,%m.ctr,46)
      if ($inrect(%m.x,%m.y,$1,$2,$3,$4) == $true) && (%ma.keyleft2 > 0) { drawrect -fe @maze %ma.pc 1 $1 $2 $3 $4
        splay $+($mircdir,mazegen,\,getkey.wav)
        set %ma.rectscoor $deltok(%ma.rectscoor,%m.ctr,46)
        set %ma.keyscoor $deltok(%ma.keyscoor,%m.ctr,44)
        set %ma.keyleft2 $calc(%ma.keyleft2 - 1)
        drawline @maze 1 20 420 689 500 689
        drawtext @maze 0 arial 15 420 680 Keys Left: %ma.keyleft2
        drawline @maze 1 20 560 683 990 683
        drawtext @maze 0 arial 15 570 675 Player 2 obtained key.
        .timermazegetkey2 1 3 drawline @maze 1 20 560 683 990 683
      }
      inc %m.ctr
  } }
}

alias m.cheat {
  $iif($?="Cheat: Enter Password: Hint: cute" == xander, set -u0 %m.ac 1, set -u0 %m.ac 0)
  if (%m.ac == 1) { $iif($?!="Are you sure cute si xander? Ü" == $true, set %m.c 1, set %m.c 0) }
  if (%m.c == 1) {
    drawline @maze 1 20 560 683 990 683
    drawtext @maze 0 arial 15 570 675 Cheats enabled! | .timermaze2 1 4 drawline @maze 1 20 560 683 990 683
    .timermaze3 1 5 drawtext @maze 0 arial 15 570 675 LeftClick to get 1P keys and RightClick to get 2P keys | .timermaze4 1 20 drawline @maze 1 20 560 683 990 683
    .timermaze5 1 21 drawtext @maze 0 arial 15 570 675 Cheats are now Disabled. | .timermaze6 1 26 drawline @maze 1 20 560 683 990 683
    .timermaze7 1 21 unset %m.c
  }
}

;--------------------
;option window
;--------------------
alias m.options {

  if (%ma.dfclty > 15) || (%ma.dfclty < 3) || (%ma.dfclty == $null) { set %ma.dfclty 3 }
  if (%ma.key > 10) || (%ma.key == $null) || (%ma.key < 0) { set %ma.key 3 }
  if (%ma.lengtha > 9) || (%ma.lengtha < 1) || (%ma.lengtha == $null) { set %ma.lengtha 1 }
  if (%ma.width > 45) || (%ma.width < 15) || (%ma.width == $null) { set %ma.width 21 }
  if ($calc(%ma.length - %ma.width) <= 0) || ($calc(%ma.length - %ma.width) > 9) { set %ma.length $calc(%ma.width + 1) }
  set %ma.length $calc(%ma.width + %ma.lengtha)
  if (%ma.bc == $null) || (%ma.bc < 0) || (%ma.bc > 14) { set %ma.bc 1 }
  if (%ma.pc == $null) || (%ma.pc < 0) || (%ma.pc > 14) { set %ma.pc 0 }
  if (%ma.bc == %ma.pc) { echo background and pipe cannot be of the same color. changing back to defaults... | set %ma.bc 1 | set %ma.pc 0 }
  if (%ma.players <= 0) || (%ma.players > 2) || (%ma.players == $null) { set %ma.players 1 }
  if (%ma.players == 1) { unset %ma.keyleft2 | unset %ma.you }
  set %ma.keyleft %ma.key
  if (%ma.players == 2) { set %ma.keyleft2 %ma.key }
  set %m.c 0

  if (%ma.dfclty == 3) { set %m.optlevel easy }
  if (%ma.dfclty == 6) { set %m.optlevel moderate }
  if (%ma.dfclty == 10) { set %m.optlevel hard }
  if (%ma.dfclty == 15) { set %m.optlevel expert }

  if (%ma.width == 15) { set %m.optwidth 1 }
  if (%ma.width == 21) { set %m.optwidth 2 }
  if (%ma.width == 25) { set %m.optwidth 3 }
  if (%ma.width == 35) { set %m.optwidth 4 }
  if (%ma.width == 45) { set %m.optwidth 5 }

  if (%ma.lengtha == 1) { set %m.optlength 5 }
  if (%ma.lengtha == 3) { set %m.optlength 4 }
  if (%ma.lengtha == 5) { set %m.optlength 3 }
  if (%ma.lengtha == 7) { set %m.optlength 2 }
  if (%ma.lengtha == 9) { set %m.optlength 1 }

  window -c @maze
  window -c @maze_credits
  window -c @maze_menu
  window -pdok0C +f @maze_menu 1 1 500 520
  drawfill @maze_menu 15 15 1 1

  drawrect @maze_menu 0 2 1 1 25 18
  drawtext -b @maze_menu 0 1 arial 13 2 2 Esc

  drawtext -pb @maze_menu 1 15 arial 30 95 15 M  a  z  e  G  e  n  e  r  a  t  o  r
  drawrect -df @maze_menu 10 2 150 70 200 40
  drawtext -b @maze_menu 1 10 arial 20 200 80 New Game
  drawrect -df @maze_menu 10 2 30 111 262 278
  drawtext -b @maze_menu 1 10 arial 20 115 120 Options
  drawrect -df @maze_menu 10 2 293 111 170 278
  drawtext -b @maze_menu 1 10 arial 20 355 120 Help
  drawrect -df @maze_menu 10 2 150 390 200 40
  drawtext -b @maze_menu 1 10 arial 20 215 400 Credits
  drawrect -df @maze_menu 10 2 150 431 200 40
  drawtext -b @maze_menu 1 10 arial 20 200 440 Quit Game

  drawtext -pb @maze_menu 1 10 arial 15 50 160 Level
  drawtext -pb @maze_menu 1 10 arial 15 50 185 No. of Keys
  drawtext -pb @maze_menu 1 10 arial 15 50 210 Pipe Thickness
  drawtext -pb @maze_menu 1 10 arial 15 50 235 Pipe Density
  drawtext -pb @maze_menu 1 10 arial 15 50 260 Background Color
  drawtext -pb @maze_menu 1 10 arial 15 50 285 Pipe Color
  drawtext -pb @maze_menu 1 10 arial 15 50 310 No. of Players
  drawline @maze_menu 15 1 29 343 293 343
  drawtext -pb @maze_menu 1 10 arial 15 50 360 Load Defaults
  drawtext -pb @maze_menu 1 10 arial 15 300 160 Keyboard Shortcuts
  drawtext -pb @maze_menu 1 10 arial 15 350 185 Player1 Player2
  drawtext -pb @maze_menu 1 10 arial 15 300 210 Up | drawtext -b @maze_menu 1 10 arial 15 370 210 Up | drawtext -b @maze_menu 1 10 arial 15 420 210 W
  drawtext -pb @maze_menu 1 10 arial 15 300 235 Down | drawtext -b @maze_menu 1 10 arial 15 370 235 Down | drawtext -b @maze_menu 1 10 arial 15 420 235 S
  drawtext -pb @maze_menu 1 10 arial 15 300 260 Left | drawtext -b @maze_menu 1 10 arial 15 370 260 Left | drawtext -b @maze_menu 1 10 arial 15 420 260 A
  drawtext -pb @maze_menu 1 10 arial 15 300 285 Right | drawtext -b @maze_menu 1 10 arial 15 370 285 Right | drawtext -b @maze_menu 1 10 arial 15 420 285 D
  drawtext -pb @maze_menu 1 10 arial 15 300 310 New Game | drawtext -b @maze_menu 1 10 arial 15 390 310 F2
  drawtext -pb @maze_menu 1 10 arial 15 300 335 Minimize Window | drawtext -b @maze_menu 1 10 arial 15 435 335 M
  drawtext -pb @maze_menu 1 10 arial 15 300 360 Quit Game | drawtext -b @maze_menu 1 10 arial 15 390 360 F9
  drawtext -pb @maze_menu 1 15 arial 12 40 490 4IMPORTANT Note: This game is coded to run on 1024x768 Screen Resolution.

  drawrect @maze_menu 4 1 99 159 12 20 | drawrect @maze_menu 4 1 194 159 12 20
  drawtext -b @maze_menu 1 15 arial 15 100 160 < | drawtext -b @maze_menu 1 15 arial 15 195 160 >
  drawtext -b @maze_menu 1 10 arial 15 120 160 %m.optlevel
  drawrect @maze_menu 4 1 139 184 12 20 | drawrect @maze_menu 4 1 189 184 12 20
  drawtext -b @maze_menu 1 15 arial 15 140 185 < | drawtext -b @maze_menu 1 15 arial 15 190 185 >
  drawtext -b @maze_menu 1 10 arial 15 160 185 %ma.key
  drawrect @maze_menu 4 1 169 209 12 20 | drawrect @maze_menu 4 1 209 209 12 20
  drawtext -b @maze_menu 1 15 arial 15 170 210 < | drawtext -b @maze_menu 1 15 arial 15 210 210 >
  drawtext -b @maze_menu 1 10 arial 15 190 210 %m.optwidth
  drawrect @maze_menu 4 1 149 234 12 20 | drawrect @maze_menu 4 1 189 234 12 20
  drawtext -b @maze_menu 1 15 arial 15 150 235 < | drawtext -b @maze_menu 1 15 arial 15 190 235 >
  drawtext -b @maze_menu 1 10 arial 15 170 235 %m.optlength

  drawrect -f @maze_menu 0 2 195 260 15 15 | drawrect -f @maze_menu 1 2 213 260 15 15 | drawrect -f @maze_menu 3 2 231 260 15 15 | drawrect -f @maze_menu 6 2 249 260 15 15 | drawrect -f @maze_menu 14 2 267 260 15 15
  drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16
  drawrect -f @maze_menu 0 2 135 285 15 15 | drawrect -f @maze_menu 1 2 153 285 15 15 | drawrect -f @maze_menu 3 2 171 285 15 15 | drawrect -f @maze_menu 6 2 189 285 15 15 | drawrect -f @maze_menu 14 2 207 285 15 15
  drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16

  drawrect @maze_menu $iif(%ma.players == 1, 4, 15) 1 164 309 10 20
  drawtext -b @maze_menu 1 15 arial 15 165 310 1
  drawrect @maze_menu $iif(%ma.players == 2, 4, 15) 1 179 309 10 20
  drawtext -b @maze_menu 1 15 arial 15 180 310 2

  drawrect -f @maze_menu 15 2 160 360 15 15
  drawrect @maze_menu 4 1 159 359 16 16

}

;-------------------
;mouse events 
;-------------------
menu @maze_menu {
  sclick:{ if ($inrect($mouse.x,$mouse.y,150,70,200,40) == $true) { $iif($?!="Start New Game?" == $true, xandermaze, halt) | window -c @maze_menu | window -c @maze_credits }
    if ($inrect($mouse.x,$mouse.y,150,431,200,40) == $true) { $iif($?!="Quit Game?" == $true, window -c @maze, halt) | window -c @maze_menu } 
    if ($inrect($mouse.x,$mouse.y,1,1,25,18) == $true) { window -c @maze_menu }
    if ($inrect($mouse.x,$mouse.y,99,159,12,20) == $true) { if (%ma.dfclty == 3) { halt }
      elseif (%ma.dfclty == 6) { set %ma.dfclty 3 | set %m.optlevel easy }
      elseif (%ma.dfclty == 10) { set %ma.dfclty 6 | set %m.optlevel moderate }
      elseif (%ma.dfclty == 15) { set %ma.dfclty 10 | set %m.optlevel hard }
    else { halt } | drawrect -f @maze_menu 10 1 120 160 70 20 | drawtext -b @maze_menu 1 10 arial 15 120 160 %m.optlevel }
    if ($inrect($mouse.x,$mouse.y,194,159,12,20) == $true) { if (%ma.dfclty == 3) { set %ma.dfclty 6 | set %m.optlevel moderate }
      elseif (%ma.dfclty == 6) { set %ma.dfclty 10 | set %m.optlevel hard }
      elseif (%ma.dfclty == 10) { set %ma.dfclty 15 | set %m.optlevel expert }
      elseif (%ma.dfclty == 15) { halt }
    else { halt } | drawrect -f @maze_menu 10 1 120 160 70 20 | drawtext -b @maze_menu 1 10 arial 15 120 160 %m.optlevel }
    if ($inrect($mouse.x,$mouse.y,139,184,12,20) == $true) { if (%ma.key > 0) { set %ma.key $calc(%ma.key - 1) }
    else { halt } | drawrect -f @maze_menu 10 1 160 185 25 20 | drawtext -b @maze_menu 1 10 arial 15 160 185 %ma.key }
    if ($inrect($mouse.x,$mouse.y,189,184,12,20) == $true) { if (%ma.key < 10) { set %ma.key $calc(%ma.key + 1) }
    else { halt } | drawrect -f @maze_menu 10 1 160 185 25 20 | drawtext -b @maze_menu 1 10 arial 15 160 185 %ma.key }
    if ($inrect($mouse.x,$mouse.y,169,209,12,20) == $true) { if (%ma.width == 15) { halt }
      elseif (%ma.width == 21) { set %ma.width 15 | set %m.optwidth 1 }
      elseif (%ma.width == 25) { set %ma.width 21 | set %m.optwidth 2 }
      elseif (%ma.width == 35) { set %ma.width 25 | set %m.optwidth 3 }
      elseif (%ma.width == 45) { set %ma.width 35 | set %m.optwidth 4 }
    else { halt } | drawrect -f @maze_menu 10 1 190 210 15 20 | drawtext -b @maze_menu 1 10 arial 15 190 210 %m.optwidth }
    if ($inrect($mouse.x,$mouse.y,209,209,12,20) == $true) { if (%ma.width == 15) { set %ma.width 21 | set %m.optwidth 2 }
      elseif (%ma.width == 21) { set %ma.width 25 | set %m.optwidth 3 }
      elseif (%ma.width == 25) { set %ma.width 35 | set %m.optwidth 4 }
      elseif (%ma.width == 35) { set %ma.width 45 | set %m.optwidth 5 }
      elseif (%ma.width == 45) { halt }
    else { halt } | drawrect -f @maze_menu 10 1 190 210 15 20 | drawtext -b @maze_menu 1 10 arial 15 190 210 %m.optwidth }
    if ($inrect($mouse.x,$mouse.y,149,234,12,20) == $true) { if (%ma.lengtha == 1) { set %ma.lengtha 3 | set %m.optlength 4 }
      elseif (%ma.lengtha == 3) { set %ma.lengtha 5 | set %m.optlength 3 } 
      elseif (%ma.lengtha == 5) { set %ma.lengtha 7 | set %m.optlength 2 }
      elseif (%ma.lengtha == 7) { set %ma.lengtha 9 | set %m.optlength 1 }
      elseif (%ma.lengtha == 9) { halt }
    else { halt } | drawrect -f @maze_menu 10 1 170 235 15 20 | drawtext -b @maze_menu 1 10 arial 15 170 235 %m.optlength }
    if ($inrect($mouse.x,$mouse.y,189,234,12,20) == $true) { if (%ma.lengtha == 1) { halt }
      elseif (%ma.lengtha == 3) { set %ma.lengtha 1 | set %m.optlength 5 } 
      elseif (%ma.lengtha == 5) { set %ma.lengtha 3 | set %m.optlength 4 }
      elseif (%ma.lengtha == 7) { set %ma.lengtha 5 | set %m.optlength 3 }
      elseif (%ma.lengtha == 9) { set %ma.lengtha 7 | set %m.optlength 2 }
    else { halt } | drawrect -f @maze_menu 10 1 170 235 15 20 | drawtext -b @maze_menu 1 10 arial 15 170 235 %m.optlength }
    if ($inrect($mouse.x,$mouse.y,195,260,15,15) == $true) { if (%ma.bc == 0) { halt }
    else { set %ma.bc 0 | drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16 } }
    if ($inrect($mouse.x,$mouse.y,213,260,15,15) == $true) { if (%ma.bc == 1) { halt }
    else { set %ma.bc 1 | drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16 } }
    if ($inrect($mouse.x,$mouse.y,231,260,15,15) == $true) { if (%ma.bc == 3) { halt }
    else { set %ma.bc 3 | drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16 } }
    if ($inrect($mouse.x,$mouse.y,249,260,15,15) == $true) { if (%ma.bc == 6) { halt }
    else { set %ma.bc 6 | drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16 } }
    if ($inrect($mouse.x,$mouse.y,267,260,15,15) == $true) { if (%ma.bc == 14) { halt }
    else { set %ma.bc 14 | drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16 } }
    if ($inrect($mouse.x,$mouse.y,135,285,15,15) == $true) { if (%ma.pc == 0) { halt }
    else { set %ma.pc 0 | drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16 } }
    if ($inrect($mouse.x,$mouse.y,153,285,15,15) == $true) { if (%ma.pc == 1) { halt }
    else { set %ma.pc 1 | drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16 } }
    if ($inrect($mouse.x,$mouse.y,171,285,15,15) == $true) { if (%ma.pc == 3) { halt }
    else { set %ma.pc 3 | drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16 } }
    if ($inrect($mouse.x,$mouse.y,189,285,15,15) == $true) { if (%ma.pc == 6) { halt }
    else { set %ma.pc 6 | drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16 } }
    if ($inrect($mouse.x,$mouse.y,207,285,15,15) == $true) { if (%ma.pc == 14) { halt }
    else { set %ma.pc 14 | drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16 } }
    if ($inrect($mouse.x,$mouse.y,164,309,10,20) == $true) { set %ma.players 1 | drawrect @maze_menu $iif(%ma.players == 1, 4, 15) 1 164 309 10 20 | drawrect @maze_menu $iif(%ma.players == 2, 4, 15) 1 179 309 10 20 }
    if ($inrect($mouse.x,$mouse.y,179,309,10,20) == $true) { set %ma.players 2 | drawrect @maze_menu $iif(%ma.players == 1, 4, 15) 1 164 309 10 20 | drawrect @maze_menu $iif(%ma.players == 2, 4, 15) 1 179 309 10 20 }
    if ($inrect($mouse.x,$mouse.y,160,360,15,15) == $true) { m.defaults | set %m.optlevel easy | set %ma.key 3 | set %m.optwidth 2 | set %m.optlength 5
      drawrect -f @maze_menu 10 1 120 160 70 20 | drawtext -b @maze_menu 1 10 arial 15 120 160 %m.optlevel
      drawrect -f @maze_menu 10 1 160 185 25 20 | drawtext -b @maze_menu 1 10 arial 15 160 185 %ma.key
      drawrect -f @maze_menu 10 1 190 210 15 20 | drawtext -b @maze_menu 1 10 arial 15 190 210 %m.optwidth
      drawrect -f @maze_menu 10 1 170 235 15 20 | drawtext -b @maze_menu 1 10 arial 15 170 235 %m.optlength
      drawrect @maze_menu $iif(%ma.bc == 0, 4, 0) 1 194 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 1, 4, 1) 1 212 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 3, 4, 3) 1 230 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 6, 4, 6) 1 248 259 16 16 | drawrect @maze_menu $iif(%ma.bc == 14, 4, 14) 1 266 259 16 16
      drawrect @maze_menu $iif(%ma.pc == 0, 4, 0) 1 134 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 1, 4, 1) 1 152 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 3, 4, 3) 1 170 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 6, 4, 6) 1 188 284 16 16 | drawrect @maze_menu $iif(%ma.pc == 14, 4, 14) 1 206 284 16 16
    drawrect @maze_menu $iif(%ma.players == 1, 4, 15) 1 164 309 10 20 | drawrect @maze_menu $iif(%ma.players == 2, 4, 15) 1 179 309 10 20 }
    if ($inrect($mouse.x,$mouse.y,150,390,200,40) == $true) { m.credits }
  }
}

alias m.credits {
  window -pdok0C +f @maze_credits 1 1 500 520
  drawfill @maze_credits 15 15 1 1
  drawrect @maze_credits 0 2 1 1 25 18
  drawtext -b @maze_credits 0 1 arial 13 2 2 Esc
  drawtext -pb @maze_credits 1 15 arial 30 95 15 M  a  z  e  G  e  n  e  r  a  t  o  r
  drawtext -b @maze_credits 4 15 arial 20 200 80 Author
  drawtext -pb @maze_credits 1 15 arial 17 170 110 Xander Ramos
  drawtext -b @maze_credits 4 15 arial 20 170 160 Game Testers
  drawtext -pb @maze_credits 1 15 arial 13 150 190 (mga pamangkin ko lol.Ü)
  drawtext -pb @maze_credits 1 15 arial 17 135 220 Danielle Alexandrei (12yo)
  drawtext -pb @maze_credits 1 15 arial 17 143 250 Pauline Alexandrei (6yo)
  drawtext -pb @maze_credits 1 15 arial 17 180 280 Rizabeth (9yo)
  drawtext -pb @maze_credits 1 15 arial 17 181 310 Michael (13yo)
  drawtext -b @maze_credits 4 15 arial 20 155 360 Acknowledgement
  drawtext -pb @maze_credits 1 15 arial 17 50 400 Thanks to the Game Testers for their hard work in
  drawtext -pb @maze_credits 1 15 arial 17 50 420 catching bugs. (yeah right)
  drawtext -pb @maze_credits 1 15 arial 17 50 440 and to uhm.. to me, for contributing everything.Ü
  drawtext -b @maze_credits 1 15 arial 15 330 480 tinorknitz@yahoo.com
}

menu @maze_credits {
  sclick: if ($inrect($mouse.x,$mouse.y,1,1,25,18) == $true) { window -c @maze_credits }
}

;----------
;popup
;----------
menu status,menubar {
  MIRC Games
  .Maze Generator
  ..MazeGenerator:m.options
}

menu @maze {
  sclick:m.sclick | if ($inrect($mouse.x,$mouse.y,167,663,180,37) == $true) { m.cheat } | if ($inrect($mouse.x,$mouse.y,1,1,25,18) == $true) { $iif($?!="This will end current game. Go to Main menu? $crlf $+ Click No to return to Game." == $true, m.options, halt) }
  rclick:m.rclick
}

;------------------------------
;controlling the players
;------------------------------

#cursorkeydown1 on
on *:keydown:@maze:37,38,39,40:{
  var %m.lehalf = $round($calc(%ma.length / 2),0)

  if ($keyval == 37) { if ($getdot(@maze,$calc($gettok(%ma.me,1,32) - %m.lehalf),$gettok(%ma.me,2,32)) == %ma.border) || (($getdot(@maze,$calc($gettok(%ma.me,1,32) - %m.lehalf),$gettok(%ma.me,2,32)) == 255) && (%ma.keyleft == 0)) || ($getdot(@maze,$calc($gettok(%ma.me,1,32) - %m.lehalf),$gettok(%ma.me,2,32)) == 16515072) || ($getdot(@maze,$calc($gettok(%ma.me,1,32) - %m.lehalf),$gettok(%ma.me,2,32)) == 127) {
      if ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft > 0) { 
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $calc($gettok(%ma.me,1,32) - %m.lehalf) $gettok(%ma.me,2,32)
      drawdot @maze 7 4 %ma.me }
      elseif ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft == 0) {
        drawdot @maze 12 4 %ma.me
        set %ma.me $calc($gettok(%ma.me,1,32) - %m.lehalf) $gettok(%ma.me,2,32)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $calc($gettok(%ma.me,1,32) - %m.lehalf) $gettok(%ma.me,2,32)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($calc($gettok(%ma.me,1,32) + %m.lehalf) $gettok(%ma.me,2,32) == %ma.you) {
      drawdot @maze 5 4 %ma.you
    drawdot @maze 7 4 %ma.me }
  }

  if ($keyval == 38) { if ($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) - %m.lehalf)) == %ma.border) || (($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) - %m.lehalf)) == 255) && (%ma.keyleft == 0)) || ($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) - %m.lehalf)) == 16515072) || ($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) - %m.lehalf)) == 127) {
      if ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft > 0) { 
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) - %m.lehalf)
      drawdot @maze 7 4 %ma.me }
      elseif ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft == 0) {
        drawdot @maze 12 4 %ma.me
        set %ma.me $gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) - %m.lehalf)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) - %m.lehalf)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) + %m.lehalf) == %ma.you) {
      drawdot @maze 5 4 %ma.you
    drawdot @maze 7 4 %ma.me }
  }

  if ($keyval == 39) { if ($getdot(@maze,$calc($gettok(%ma.me,1,32) + %m.lehalf),$gettok(%ma.me,2,32)) == %ma.border) || (($getdot(@maze,$calc($gettok(%ma.me,1,32) + %m.lehalf),$gettok(%ma.me,2,32)) == 255) && (%ma.keyleft == 0)) || ($getdot(@maze,$calc($gettok(%ma.me,1,32) + %m.lehalf),$gettok(%ma.me,2,32)) == 16515072) || ($getdot(@maze,$calc($gettok(%ma.me,1,32) + %m.lehalf),$gettok(%ma.me,2,32)) == 127) {
      if ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft > 0) { 
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $calc($gettok(%ma.me,1,32) + %m.lehalf) $gettok(%ma.me,2,32)
      drawdot @maze 7 4 %ma.me }
      elseif ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft == 0) {
        drawdot @maze 12 4 %ma.me
        set %ma.me $calc($gettok(%ma.me,1,32) + %m.lehalf) $gettok(%ma.me,2,32)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $calc($gettok(%ma.me,1,32) + %m.lehalf) $gettok(%ma.me,2,32)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($calc($gettok(%ma.me,1,32) - %m.lehalf) $gettok(%ma.me,2,32) == %ma.you) {
      drawdot @maze 5 4 %ma.you
    drawdot @maze 7 4 %ma.me }
  }

  if ($keyval == 40) { if ($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) + %m.lehalf)) == %ma.border) || (($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) + %m.lehalf)) == 255) && (%ma.keyleft == 0)) || ($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) + %m.lehalf)) == 16515072) || ($getdot(@maze,$gettok(%ma.me,1,32),$calc($gettok(%ma.me,2,32) + %m.lehalf)) == 127) {
      if ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft > 0) { 
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) + %m.lehalf)
      drawdot @maze 7 4 %ma.me }
      elseif ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft == 0) {
        drawdot @maze 12 4 %ma.me
        set %ma.me $gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) + %m.lehalf)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.me
        set %ma.me $gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) + %m.lehalf)
        drawdot @maze 7 4 %ma.me
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($gettok(%ma.me,1,32) $calc($gettok(%ma.me,2,32) - %m.lehalf) == %ma.you) {
      drawdot @maze 5 4 %ma.you
    drawdot @maze 7 4 %ma.me }
  }
  if ($findtok(%ma.keyscoor,%ma.me,1,44) != $null) && (%ma.keyleft > 0) { m.keydown | drawdot @maze 7 4 %ma.me | splay -w $+($mircdir,mazegen,\,getkey.wav) }
  if (%ma.me == %ma.ec) { splay -w $+($mircdir,mazegen,\,mazecompleted.wav)
    .disable #cursorkeydown1
    .disable #cursorkeydown2
    drawline @maze 1 20 560 683 990 683
    drawtext @maze 0 arial 15 570 675 Player 1 Wins!!!
    .timermaze* off
  .unset %m.* }
}
#cursorkeydown1 end

#cursorkeydown2 off
on *:keydown:@maze:65,87,68,83:{
  var %m.lehalf = $round($calc(%ma.length / 2),0)

  if ($keyval == 65) { if ($getdot(@maze,$calc($gettok(%ma.you,1,32) - %m.lehalf),$gettok(%ma.you,2,32)) == %ma.border) || (($getdot(@maze,$calc($gettok(%ma.you,1,32) - %m.lehalf),$gettok(%ma.you,2,32)) == 255) && (%ma.keyleft2 == 0)) || ($getdot(@maze,$calc($gettok(%ma.you,1,32) - %m.lehalf),$gettok(%ma.you,2,32)) == 16515072) || ($getdot(@maze,$calc($gettok(%ma.you,1,32) - %m.lehalf),$gettok(%ma.you,2,32)) == 32764) {
      if ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 > 0) { 
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $calc($gettok(%ma.you,1,32) - %m.lehalf) $gettok(%ma.you,2,32)
      drawdot @maze 5 4 %ma.you }
      elseif ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 == 0) {
        drawdot @maze 12 4 %ma.you
        set %ma.you $calc($gettok(%ma.you,1,32) - %m.lehalf) $gettok(%ma.you,2,32)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $calc($gettok(%ma.you,1,32) - %m.lehalf) $gettok(%ma.you,2,32)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($calc($gettok(%ma.you,1,32) + %m.lehalf) $gettok(%ma.you,2,32) == %ma.me) {
      drawdot @maze 7 4 %ma.me
    drawdot @maze 5 4 %ma.you }
  }

  if ($keyval == 87) { if ($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) - %m.lehalf)) == %ma.border) || (($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) - %m.lehalf)) == 255) && (%ma.keyleft2 == 0)) || ($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) - %m.lehalf)) == 16515072) || ($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) - %m.lehalf)) == 32764) {
      if ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 > 0) { 
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) - %m.lehalf)
      drawdot @maze 5 4 %ma.you }
      elseif ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 == 0) {
        drawdot @maze 12 4 %ma.you
        set %ma.you $gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) - %m.lehalf)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) - %m.lehalf)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) + %m.lehalf) == %ma.me) {
      drawdot @maze 7 4 %ma.me
    drawdot @maze 5 4 %ma.you }
  }

  if ($keyval == 68) { if ($getdot(@maze,$calc($gettok(%ma.you,1,32) + %m.lehalf),$gettok(%ma.you,2,32)) == %ma.border) || (($getdot(@maze,$calc($gettok(%ma.you,1,32) + %m.lehalf),$gettok(%ma.you,2,32)) == 255) && (%ma.keyleft2 == 0)) || ($getdot(@maze,$calc($gettok(%ma.you,1,32) + %m.lehalf),$gettok(%ma.you,2,32)) == 16515072) || ($getdot(@maze,$calc($gettok(%ma.you,1,32) + %m.lehalf),$gettok(%ma.you,2,32)) == 32764) {
      if ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 > 0) { 
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $calc($gettok(%ma.you,1,32) + %m.lehalf) $gettok(%ma.you,2,32)
      drawdot @maze 5 4 %ma.you }
      elseif ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 == 0) {
        drawdot @maze 12 4 %ma.you
        set %ma.you $calc($gettok(%ma.you,1,32) + %m.lehalf) $gettok(%ma.you,2,32)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $calc($gettok(%ma.you,1,32) + %m.lehalf) $gettok(%ma.you,2,32)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($calc($gettok(%ma.you,1,32) - %m.lehalf) $gettok(%ma.you,2,32) == %ma.me) {
      drawdot @maze 7 4 %ma.me
    drawdot @maze 5 4 %ma.you }
  }

  if ($keyval == 83) { if ($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) + %m.lehalf)) == %ma.border) || (($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) + %m.lehalf)) == 255) && (%ma.keyleft2 == 0)) || ($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) + %m.lehalf)) == 16515072) || ($getdot(@maze,$gettok(%ma.you,1,32),$calc($gettok(%ma.you,2,32) + %m.lehalf)) == 32764) {
      if ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 > 0) { 
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) + %m.lehalf)
      drawdot @maze 5 4 %ma.you }
      elseif ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 == 0) {
        drawdot @maze 12 4 %ma.you
        set %ma.you $gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) + %m.lehalf)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
      else {
        drawdot @maze %ma.pc 4 %ma.you
        set %ma.you $gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) + %m.lehalf)
        drawdot @maze 5 4 %ma.you
      splay -w $+($mircdir,mazegen,\,move.wav) }
    }
    else { splay -w $+($mircdir,mazegen,\,bump.wav)
    halt }
    if ($gettok(%ma.you,1,32) $calc($gettok(%ma.you,2,32) - %m.lehalf) == %ma.me) {
      drawdot @maze 7 4 %ma.me
    drawdot @maze 5 4 %ma.you }
  }
  if ($findtok(%ma.keyscoor,%ma.you,1,44) != $null) && (%ma.keyleft2 > 0) { m.keydown2 | drawdot @maze 5 4 %ma.you | splay -w $+($mircdir,mazegen,\,getkey.wav) }
  if (%ma.you == %ma.ec) { splay -w $+($mircdir,mazegen,\,mazecompleted.wav)
    .disable #cursorkeydown1
    .disable #cursorkeydown2
    drawline @maze 1 20 560 683 990 683
    drawtext @maze 0 arial 15 570 675 Player 2 Wins!!!
    .timermaze* off
  .unset %m.* }
}
#cursorkeydown2 end

on *:keydown:@maze:113,27,77,120: { 
  if ($keyval == 113) { $iif($?!="Start New Game?" == $true, xandermaze, halt) | window -c @maze_menu | window -c @maze_credits }
  if ($keyval == 27) { $iif($?!="This will end current game. Go to Main menu? $crlf $+ Click No to return to Game." == $true, m.options, halt) }
  if ($keyval == 77) { window -n @maze }
  if ($keyval == 120) { $iif($?!="Quit Game?" == $true, window -c @maze, halt) }
}

on *:keydown:@maze_menu:27:window -c @maze_menu
on *:keydown:@maze_credits:27:window -c @maze_credits
