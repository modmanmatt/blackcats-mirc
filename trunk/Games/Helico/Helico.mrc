;Helico Game v1.3
;Created by Raynor
;Special Thanks to visionz
;2005

on *:start:{
  $iif(!$hget(helicoscore),hmake helicoscore 100)
  hload helicoscore " $+ $scriptdirhelicoscore.hash"
}

on *:load:{
  echo -a To lunch the game, you need to type /helico or simply navigate in the status's popups
  echo -a ©Raynor 2005
  $iif(!$hget(helicoscore),hmake helicoscore 100)
}

on *:unload:{
  echo -a Thanks to try Helico Game !
  $iif($hget(helicoscore),hfree helicoscore)
}

alias helico {
  var %w = 800
  var %h = 600

  _initHashtable

  hload helicoscore " $+ $scriptdirhelicoscore.hash"

  hadd helico render.w %w
  hadd helico render.h %h

  hadd helico p.f 0
  hadd helico p.t $ticks
  hadd helico p.fps 0

  hadd helico iterations 4
  hadd helico interval 0

  hadd helico sounds 1
  hadd helico skybg 0
  hadd helico pause 1
  hadd helico brick 1

  window -c @helico
  window -Cdfp @helico 0 0 %w %h

  _initialization %w %h

  .timerhelico -m 1 0 _loop
}

menu menubar,channel {
  Games
  .Helico
  ..Lunch Helico:helico
  ..Top scores list:_topscore
  ..Uninstall Helico
  ...Yes:unload -rs Helico.mrc
  ...No:halt
}

on *:close:@helico:{
  unset %h
  unset %y
  unset %x
  unset %r
  unset %u
  unset %br
  unset %x*
  splay -w stop
  .timerhelico off

  hsave helicoscore " $+ $scriptdirhelicoscore.hash"
  hfree helico

  window -c @HHelico
  window -c @HHHelico
  window -c @Sky
}


alias _initHashtable {
  if ($hget(helico)) hfree helico
  hmake helico 1000
  $iif(!$hget(helicoscore),hmake helicoscore 100)
}


alias _IncFrameCount {
  hinc helico p.f

  if ($calc($ticks - $hget(helico,p.t)) > 2000) {
    hadd helico p.fps $int($calc($hget(helico,p.f) / 2))
    hadd helico p.f 0
    hadd helico p.t $ticks
  }

}

alias _loop {
  var %i = 0, %iterations = $hget(helico,iterations), %interval = $hget(helico,interval)
  hadd helico render.w $window(@helico).dw
  hadd helico render.h $window(@helico).dh
  var %w = $hget(helico,render.w), %h = $hget(helico,render.h)
  while (%i < %iterations) {
    if ($window(@helico).state != minimized) {
      $iif($hget(helico,skybg),drawcopy -n @Sky 0 0 800 600 @Helico 0 0,drawrect -nrf @helico 0 1 0 0 %w %h)
      _handleKeyval
      _render %w %h
      _incFrameCount
      drawtext -nr @helico 16777215 arial 10 10 10 $hget(helico,p.fps) fps
      drawdot @helico
    }
    inc %i
  }

  .timerhelico -m 1 %interval _loop
}

on *:KEYDOWN:@Helico:*:{
  if $keyval == 80 && $hget(helico,start) {
    if $hget(helico,pause) { hadd helico pause 0 | .timerhelico off | splay -w stop } 
    else { hadd helico pause 1 | .timerhelico -m 1 0 _loop | drawrect -nrf @helico 0 1 30 360 0 20 }
  }
}

alias _handleKeyval {
  if ($hget(helico,_mousedown)) {
    MOUSE_HOLDSCLICK $2 $3
    hadd helico sclick 1
  }
}

menu @helico {
  sclick {
    MOUSE_SCLICK $mouse.x $mouse.y
    hadd helico _mousedown 1 $mouse.x $mouse.y
  }
  uclick {
    MOUSE_UCLICK $mouse.x $mouse.y
    hadd helico _mousedown 0
  }
  dclick {
    MOUSE_DCLICK $mouse.x $mouse.y
    hadd helico _mousedown 1 $mouse.x $mouse.y
  }
  $iif($hget(helico,sounds),Deactivate the sounds,Activate the sounds) $+ : hadd helico sounds $iif($hget(helico,sounds),0,1)
  $iif($hget(helico,skybg),Deactivate the background,Activate the background) $+ :hadd helico skybg $iif($hget(helico,skybg),0,1)
  $iif($hget(helico,brick),Deactivate the brick mode,Activate the brick mode) $+ :if !$hget(helico,start) { if $hget(helico,brick) { hadd helico brick 0 } | else { hadd helico brick 1 } } | else echo -a You need to wait until the game is over
  Difficulty
  .Speed 1:hadd helico difficulty 1
  .Speed 2:hadd helico difficulty 2
  .Speed 3:hadd helico difficulty 3
  .Speed 4:hadd helico difficulty 4
  .Speed 5:hadd helico difficulty 5
  .Speed 6:hadd helico difficulty 6
  .Speed 7:hadd helico difficulty 7
  .Speed 8:hadd helico difficulty 8
  .Speed 9:hadd helico difficulty 9
  .Speed 10:hadd helico difficulty 10
  Speed of the ascent
  .Speed 1:hadd helico up 1
  .Speed 2:hadd helico up 2
  .Speed 3:hadd helico up 3
  .Speed 4:hadd helico up 4
  .Speed 5:hadd helico up 5
  Iterations
  .Slow:hadd helico iterations 1
  .Middle:hadd helico iterations 3
  .Fast:hadd helico iterations 5
  .Very Fast:hadd helico iterations 10
  -
  List of the best scores:_topscore
  $iif($hget(helico,pause),Pause (P),Resume (P)) $+ :if $hget(helico,start) { if $hget(helico,pause) { hadd helico pause 0 | .timerhelico off | splay -w stop } | else { hadd helico pause 1 | .timerhelico -m 1 0 _loop } }
}

alias skybackground {
  var %z 1,%m 1
  while (%z <= 800) {
    drawpic -n @Sky %z 20 " $+ $scriptdirimg\sky.bmp"
    inc %z 75
  }
  while (%m <= 600) {
    drawcopy -n @Sky 0 20 800 75 @Sky 0 %m
    inc %m 75
  }
}

alias _initialization {
  window -hfpb +d @HHelico 0 0 800 67
  drawpic -c @HHelico 0 0 " $+ $scriptdirimg\Helico Chipset.bmp"

  window -fhpb +d @HHHelico 0 0 230 230
  drawpic -c @HHHelico 0 0 219 0 230 27 " $+ $scriptdirimg\Helico Chipset.bmp"
  drawrot @HHHelico 270 0 0 230 26

  window -fhpb +d @Sky 0 0 800 600
  skybackground

  hadd helico sounds 1
  set %y 300
  set %x 800
  set %h 800
  set %x2 800
  set %x3 20
  set %x5 1
  set %br 1

  set %r $r(30,400)
  set %u $r(150,250)
}

alias -l _rewind {
  set %x 800
  set %r $r($iif($hget(helico,brick),$calc(%br +10),%x3),400)
  set %u $r(150,250)
}

alias -l _rewind2 {
  set %x2 800
  inc %x3 5
}

alias -l _rewind3 {
  set %x5 1
  inc %br 17
}

alias -l _rewind4 {
  set %h 800
  set %u $r(150,250)
  set %r $r($calc(%br +10),400)
}

alias -l _crash {
  $iif($hget(helico,sounds),splay -w " $+ $scriptdirsounds\sound3.wav")
  $iif($hget(helicoscore,best) < $hget(helico,p.distance),hadd helicoscore best $hget(helico,p.distance))
  _topsort
  set %y 300
  hadd helico start 0
  _initialization
}

alias -l _begin {
  if (!$hget(helico,start)) {
    drawcopy -ntr @HHelico 0 0 0 110 50 @Helico 200 %y
    drawtext -nr @helico 255 arial 30 650 20 ©Raynor
    drawtext -nr @helico 255 arial 40 60 200 Click to start...
    drawtext -nr @helico 255 arial 15 300 30 Right click to access the options
    drawtext -nr @helico 255 arial 30 120 450 Maintain the mouse pushed to rise,
    drawtext -nr @helico 255 arial 30 120 480 slacken to go down.
    drawtext -nr @helico 16777215 arial 20 10 573 Distance covered: 0
    hadd helico p.distance 0
    drawtext -nr @helico 16777215 arial 20 670 573 Record: $hget(helicoscore,best)
  }
}

alias _render {
  _begin
  if ($hget(helico,start)) {

    $iif(%y <= $calc(%br +15),_crash)
    $iif(%y >= 533,_crash)

    if !$hget(helico,brick) {
      drawrect -rnf @Helico 37632 1 1 1 800 %x3
      $iif(%x2 > 50,drawrect -rnf @Helico 37632 1 %x2 1 800 %x3,_rewind2)
      dec %x2 $hget(helico,difficulty)

      $iif(%x > 100,drawrect -nrf @Helico 37632 1 %x %r 40 %u,_rewind)
      dec %x 2

      drawrect -rnf @Helico 37632 1 1 570 800 30

    }

    else {

      if $inrect(200,%y,%h,%r,26,%u) || $inrect(250,%y,%h,%r,26,%u) || $inrect(290,%y,%h,%r,26,%u) || $inrect(200,$calc(%y +50),%h,%r,26,%u) || $inrect(250,$calc(%y +50),%h,%r,26,%u) || $inrect(290,$calc(%y +50),%h,%r,26,%u) { _crash }

      $iif(%x5 < 1300,drawcopy -ntr @HHelico 0 0 50 800 17 @Helico 0 %br,_rewind3)
      inc %x5 $hget(helico,difficulty)

      drawcopy -ntr @HHelico 0 0 50 800 17 @Helico 0 582

      $iif(%h > 100,drawcopy -ntr @HHHelico 0 0 0 26 %u @Helico %h %r,_rewind4)
      dec %h $hget(helico,difficulty)

    }

    if ($hget(helico,sclick)) {
      if (($getdot(@Helico,200,%y) != 37632) && ($getdot(@Helico,200,$calc(%y +50)) != 37632) && ($getdot(@Helico,310,%y) != 37632) && ($getdot(@Helico,310,$calc(%y +50)) != 37632) && ($getdot(@Helico,260,%y) != 37632) && ($getdot(@Helico,260,$calc(%y +50)) != 37632)) {

        drawcopy -ntr @HHelico 0 110 0 108 50 @Helico 200 %y
      }
      else {
        $iif($hget(helico,sounds),splay -w stop)
        _crash
      }
    }

    else {
      if (($getdot(@Helico,200,%y) != 37632) && ($getdot(@Helico,200,$calc(%y +50)) != 37632) && ($getdot(@Helico,310,%y) != 37632) && ($getdot(@Helico,310,$calc(%y +50)) != 37632) && ($getdot(@Helico,260,%y) != 37632) && ($getdot(@Helico,260,$calc(%y +50)) != 37632)) {

        inc %y $hget(helico,up)
        drawcopy -tnr @HHelico 0 0 0 110 50 @Helico 200 %y
      }
      else { 
        splay -w stop
        _crash
      }
    }

    drawtext -nr @helico 16777215 arial 20 10 573 Distance covered: $hget(helico,p.distance) KM
    hinc helico p.distance 1
    drawtext -nr @helico 16777215 arial 20 670 573 Record: $hget(helicoscore,best)
  }
}

alias MOUSE_SCLICK {
  if $hget(helico,pause) {
    if !$hget(helico,start) { 
      hadd helico start 1
      $iif($hget(helico,sounds),splay -w " $+ $scriptdirsounds\sound1.wav") 
    }
    else {
      $iif($hget(helico,sounds),splay -w " $+ $scriptdirsounds\sound1.wav") 
    }
  }
}
alias MOUSE_DCLICK { if ($hget(helico,sclick)) { hadd helico sclick 1 } | else { hadd helico sclick 0  } }
alias MOUSE_UCLICK { if $hget(helico,start) { $iif($hget(helico,sounds),splay -w stop) | hadd helico sclick 0 } }
alias MOUSE_HOLDSCLICK { if $hget(helico,start) { hadd helico sclick 1 | dec %y $hget(helico,up) } }

;TOP SCORE WINDOW
alias _topscore {
  $iif(!$window(@Score),window -CBpkdh +d @Score 0 0 400 146)
  drawrect -r @Score $rgb(0,0,128) 1 0 0 400 146 0 0 400 19
  drawrect -rf @Score $rgb(0,102,151) 1 2 2 396 15
  drawrect -rf @Score $rgb(0,64,128) 1 1 19 398 126

  drawline -r @Score $rgb(0,255,255) 1 1 1 398 1 1 1 1 18
  drawline -r @Score $rgb(1,73,97) 1 2 17 398 17 398 17 398 1
  drawline -r @Score $rgb(1,73,97) 1 380 2 380 17
  drawline -r @Score $rgb(0,64,128) 1 381 2 381 17
  drawline -r @Score $rgb(0,255,255) 1 382 2 382 17

  drawrect -rf @Score $rgb(0,102,151) 1 264 30 120 15
  drawrect -r @Score $rgb(0,0,128) 1 263 29 122 17

  drawtext -ro @Score $rgb(0,255,255) Webdings 13 384 0 r
  drawtext -ro @Score $rgb(1,73,97) Webdings 13 383 0 r
  drawtext -ro @Score $rgb(1,73,97) Webdings 13 366 0 1
  drawtext -ro @Score $rgb(0,255,255) Webdings 13 350 0 6
  drawtext -ro @Score $rgb(1,73,97) Webdings 13 349 0 6
  drawtext -ro @Score $rgb(1,73,97) default 10 7 3 List of your best scores
  drawtext -ro @Score $rgb(0,255,255) default 10 6 3 List of your best scores

  drawcopy @Score 263 29 122 17 @Score 9 29
  drawcopy @Score 263 29 122 17 @Score 136 29

  drawcopy @Score 380 2 3 15 @Score 363 2
  drawcopy @Score 380 2 3 15 @Score 346 2

  drawtext -ro @Score $rgb(1,73,97) default 10 42 32 Classification
  drawtext -ro @Score $rgb(0,255,255) default 10 40 30 Classification

  drawtext -ro @Score $rgb(1,73,97) default 10 178 32 Nickname
  drawtext -ro @Score $rgb(0,255,255) default 10 176 30 Nickname

  drawtext -ro @Score $rgb(1,73,97) default 10 310 32 Score
  drawtext -ro @Score $rgb(0,255,255) default 10 308 30 Score

  var %a 1,%o 50
  while (%o <= 380) {
    drawtext -ro @Score $rgb(1,73,97) default 10 68 %o %a
    drawtext -ro @Score $rgb(0,255,255) default 10 66 $calc(%o -2) %a

    drawtext -ro @Score $rgb(1,73,97) default 10 323 %o $iif(!$hget(helicoscore,best $+ %a),0,$hget(helicoscore,best $+ %a))
    drawtext -ro @Score $rgb(0,255,255) default 10 321 $calc(%o -2) $iif(!$hget(helicoscore,best $+ %a),0,$hget(helicoscore,best $+ %a))

    drawtext -ro @Score $rgb(1,73,97) default 10 188 %o $iif(!$hget(helicoscore,name $+ %a),Aucun,$hget(helicoscore,name $+ %a))
    drawtext -ro @Score $rgb(0,255,255) default 10 186 $calc(%o -2) $iif(!$hget(helicoscore,name $+ %a),Aucun,$hget(helicoscore,name $+ %a))

    inc %o 20
    inc %a
  }

}


alias -l score.move {
  if ($window(@Score)) window @Score $calc($mouse.dx - $1) $calc($mouse.dy - $2)
  if ($mouse.key & 1) .timer $+ $ticks -m 1 0 score.move $1-
}

menu @Score {
  sclick:{
    if ($inrect($mouse.x,$mouse.y,383,2,14,15))  { drawtext -ro @Score $rgb(0,102,151) Webdings 13 383 0 r | drawtext -ro @Score $rgb(1,73,97) Webdings 13 384 0 r }
    elseif ($inrect($mouse.x,$mouse.y,349,2,14,15)) { drawtext -ro @Score $rgb(0,102,151) Webdings 13 349 0 6 | drawtext -ro @Score $rgb(1,73,97) Webdings 13 350 0 6 }
    if ($mouse.y < 18) && ($mouse.y > 1) && ($mouse.x < 346) { score.move $calc($mouse.dx - $window($active).x) $calc($mouse.dy - $window($active).y) }
  }
  uclick:{ 
    drawtext -ro @Score $rgb(0,255,255) Webdings 13 384 0 r | drawtext -ro @Score $rgb(1,73,97) Webdings 13 383 0 r
    drawtext -ro @Score $rgb(0,255,255) Webdings 13 350 0 6 | drawtext -ro @Score $rgb(1,73,97) Webdings 13 349 0 6
    if ($inrect($mouse.x,$mouse.y,383,2,14,15))  { window -c @Score }
    if ($inrect($mouse.x,$mouse.y,349,2,14,15)) { window -n @Score }
  }
  leave:{ drawtext -ro @Score $rgb(0,255,255) Webdings 13 384 0 r | drawtext -ro @Score $rgb(1,73,97) Webdings 13 383 0 r | drawtext -ro @Score $rgb(0,255,255) Webdings 13 350 0 6 | drawtext -ro @Score $rgb(1,73,97) Webdings 13 349 0 6 }
}

;ALIAS DE GESTION DU TOP SCORE
alias _topsort {

  if $hget(helico,p.distance) > $hget(helicoscore,best1) {
    hadd helicoscore name5 $hget(helicoscore,name4)
    hadd helicoscore best5 $hget(helicoscore,best4)
    hadd helicoscore name4 $hget(helicoscore,name3)
    hadd helicoscore best4 $hget(helicoscore,best3)
    hadd helicoscore name3 $hget(helicoscore,name2)
    hadd helicoscore best3 $hget(helicoscore,best2)
    hadd helicoscore name2 $hget(helicoscore,name1)
    hadd helicoscore best2 $hget(helicoscore,best1)
    hadd helicoscore best1 $hget(helico,p.distance)
    hadd helicoscore name1 $iif(!$input(Write your nickname,1,New record !!!,$hget(helicoscore,name1)),None,$$!)
    goto end
  }

  if $hget(helico,p.distance) > $hget(helicoscore,best2) {
    hadd helicoscore name5 $hget(helicoscore,name4)
    hadd helicoscore best5 $hget(helicoscore,best4)
    hadd helicoscore name4 $hget(helicoscore,name3)
    hadd helicoscore best4 $hget(helicoscore,best3)
    hadd helicoscore name3 $hget(helicoscore,name2)
    hadd helicoscore best3 $hget(helicoscore,best2)
    hadd helicoscore best2 $hget(helico,p.distance)
    hadd helicoscore name2 $iif(!$input(Write your nickname,1,Second place,$hget(helicoscore,name1)),None,$$!)
    goto end
  }

  if $hget(helico,p.distance) > $hget(helicoscore,best3) {
    hadd helicoscore name5 $hget(helicoscore,name4)
    hadd helicoscore best5 $hget(helicoscore,best4)
    hadd helicoscore name4 $hget(helicoscore,name3)
    hadd helicoscore best4 $hget(helicoscore,best3)
    hadd helicoscore best3 $hget(helico,p.distance)
    hadd helicoscore name3 $iif(!$input(Write your nickname,1,Third place,$hget(helicoscore,name1)),None,$$!)
    goto end
  }

  if $hget(helico,p.distance) > $hget(helicoscore,best4) {
    hadd helicoscore name5 $hget(helicoscore,name4)
    hadd helicoscore best5 $hget(helicoscore,best4)
    hadd helicoscore best4 $hget(helico,p.distance)
    hadd helicoscore name4 $iif(!$input(Write your nickname,1,Fourth place,$hget(helicoscore,name1)),None,$$!)
    goto end
  }

  if $hget(helico,p.distance) > $hget(helicoscore,best5) {
    hadd helicoscore best5 $hget(helico,p.distance)
    hadd helicoscore name5 $iif(!$input(Write your nickname,1,Fifth place,$hget(helicoscore,name1)),None,$$!)
    goto end
  }
  :end
  hsave helicoscore " $+ $scriptdirhelicoscore.hash"
  window -a @Helico
}
;eof
