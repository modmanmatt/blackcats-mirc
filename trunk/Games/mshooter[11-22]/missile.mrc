; Missile shooter, by visionz (g_baril@sympatico.ca)
; 
; I give you full rights with this addon, you can modify it, use parts of it and claim it yours
;
; Have fun! 
;
; 
;

menu menubar,channel {
  Games
  .Missle shooter
  ..Launch { missile }
  ..-
  ..Uninstall
  ...Are you sure?
  ....Yes
  .....Unload me! { .unload -rs $shortfn($script) }
}



alias missile {
  missile.init
  missile.start_loop
}

alias missile.start_loop {
  .timerMissile 1 0 missile.loop 
}

alias missile.init {
  if ($window(@missile)) missile.die

  hmake missile 100

  window -hfp @missile.stars1 0 0 500 500
  window -hfp @missile.stars2 0 0 500 500
  window -hfp @missile.stars3 0 0 500 500
  window -hfp @missile.buf 0 0 500 500

  window -dhofp @missile 0 0 500 500

  hadd missile color.text $rgb(255,255,255)
  hadd missile color.shadow $rgb(0,0,0)
  hadd missile color.back $rgb(0,128,192)
  hadd missile color.back2 $rgb(0,32,48)
  hadd missile color.contour $rgb(255,255,255)

  tokenize 44 $rgb($hget(missile,color.back))
  hadd missile color.back_invert $rgb($calc(255 - $1),$calc(255 - $2),$calc(255 - $3))

  tokenize 44 $rgb($hget(missile,color.back2))
  hadd missile color.back2_invert $rgb($calc(255 - $1),$calc(255 - $2),$calc(255 - $3))

  hadd missile missilePower 1

  hadd missile graph 3
  hadd missile showfps 0
  hadd missile pause 1
  hadd missile menuPos 1
  hadd missile homingVel 6
  hadd missile starsNumber 400
  hadd missile deadAt 0
  hadd missile finalExplosion 0

  ; pour pas que le joueur puisse faire des actions (souris)..
  ;  hadd missile noUserAction 1

  ; difficulté: de 0 à 6
  hadd missile diff 3

  ; le nombre de missile
  hadd missile missileN 1

  ; le premier missile à afficher
  hadd missile missileP 1

  hadd missile level 1
  hadd missile points 0


  missile.degrade @missile.buf $hget(missile,color.back_invert) $hget(missile,color.back2_invert) 0 0 189 160
  missile.degrade @missile.buf $hget(missile,color.back_invert) $hget(missile,color.back2_invert) 0 170 500 250


  missile.generateBackground

  missile.initFps
}

; @win color1 color2 x y w h
alias missile.degrade {
  var %win = $1
  var %x = $4, %y = $5, %w = $6, %h = $7
  var %rgb1 = $rgb($2), %rgb2 = $rgb($3)
  var %r1 = $gettok(%rgb1,1,44), %g1 = $gettok(%rgb1,2,44), %b1 = $gettok(%rgb1,3,44)
  var %r2 = $gettok(%rgb2,1,44), %g2 = $gettok(%rgb2,2,44), %b2 = $gettok(%rgb2,3,44)
  var %r.inc = $calc((%r2 - %r1) / %w), %g.inc = $calc((%g2 - %g1) / %w), %b.inc = $calc((%b2 - %b1) / %w)
  var %y2 = $calc(%y + %h)
  while (%x <= %w) {
    drawline -r %win $rgb(%r1,%g1,%b1) 1 %x %y %x %y2
    inc %r1 %r.inc
    inc %g1 %g.inc
    inc %b1 %b.inc
    inc %x
  }
}

; level_number
alias missile.init_level {

  hadd missile shotFired 0
  hadd missile shotNice 0
  hadd missile shotPerfect 0
  hadd missile shotInARow 0

  hadd missile bonus $r(10000,30000)
  hadd missile BonusOnScreen 0
  hadd missile levelStart $ticks

  hadd missile showIntro 1

  hadd missile doneExplosion 0
  hadd missile flee 0
  hadd missile targetX 240
  hadd missile targetY 240
  hadd missile targetAngle 0.1234

  ; ------------couleur-------speed-size-energy--fleevel-nb of missiles-nb of homing--vectors definition
  var %level1 = $rgb(255,0,0)   1    40    15       1.0      30              2        10;1.5707 30;0 43;-2.356 43;2.356 30;0
  var %level1.story = Two years ago, a professor has invented a super-morphable-spaceship. Unfortunally, it was stolen by an evil dude who want to control the space. You have to protect the space from this mad man by destroying his ship!

  var %level2 = $rgb(255,0,0)   2    40    25       1.1      30              3        0;0 15;.785 20;0 46;-2.356 46;2.356 20;0 15;-.785 3;0
  var %level2.story = Congratulation! You have successfully destroyed the ship. However, the ship has born again from his ashes and he is now more powerfull. Destroy it again, maybe it will be his last breath!

  var %level3 = $rgb(255,0,0)   3    40    45       1.2      40              4        0;0 30;.785 15;-.785 46;-2.356 46;2.356 15;.785 30;-.785
  var %level3.story = Hum, we have a problem! It seems that each time you destroy the ship, it gets more powerful. We will absolutely have to find a solution! But if we don't stop it, it will allow the madman to take control over the space! You will have to destroy it again while we search for a better solution...

  var %level4 = $rgb(255,0,0)   3    40    55       1.3      40              5        0;0 30;.785 10;0 10;-1.57 46;-2.356 46;2.356 10;1.57 10;0 30;-.785
  var %level4.story = Hello again, we still didn't find any solution to completely destroy the ship. But do you know that you can fire homing missiles by [right-clicking] your mouse button? Try it out on the new form of the ship! 

  var %level5 = $rgb(255,0,0)   4    40    65       1.4      50              6        5;.785 25;.785 10;0 10;-1.57 46;-2.356 46;2.356 10;1.57 10;0 25;-.785 10;1.57 10;0 10;-1.57
  var %level5.story = Still searching! Don't lose confidence! The more accurate you are while shooting the ship, the more points you get. Shooting a 'Perfect' missile gives you more points than shooting a 'Nice' missile.

  var %level6 = $rgb(255,0,0)   4    45    70       1.5      50              7        5;.785 25;.785 10;0 10;-1.57 46;-2.356 46;2.356 10;1.57 10;0 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level6.story = I think we are coming near to a solution for our ship problem. One of our technician found that the ship is made from meteoride, which can be destroyed using a piece of the same product. Collect a piece of the ship when you will destroy it!

  var %level7 = $rgb(255,0,0)   5    45    80       1.6      55              8        5;.785 25;.785 10;0 10;-1.57 32;-2.356 20;3.14159 32;2.356 10;1.57 10;0 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level7.story = We have received the piece of meteoride that you sent us. Our technicians are currently analysing it to find how to produce the perfect weapon. Continue attacking it in the mean time, else it will take control over the space!

  var %level8 = $rgb(255,0,0)   5    45    100       1.7      55              8        5;.785 25;.785 14;-.7853 10;-2.356 10;-1.57 8;2.356 13;-2.356 20;3.14159 13;2.356 8;-2.356 10;1.57 10;2.356 14;.785 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level8.story = Still working on the ultimate weapon. Do you know that the more hit-in-a-row you do, the more points you score? Try not to miss your shot!

  var %level9 = $rgb(255,0,0)   5    45    125       1.9      57              10       5;.785 25;.785 14;-.7853 10;-2.356 10;-1.57 8;2.356 13;-2.356 5;3.14159 12;-2 12;2 5;3.14159 13;2.356 8;-2.356 10;1.57 10;2.356 14;.785 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level9.story = Our technicians finally found how to make the ultimate weapon and they have installed it on your ship. Try it out!
  var %level9.inc = 10

  var %level10 = $rgb(255,0,0)  6    45    500       2.1      57              10       5;.785 25;.785 10;0 10;-1.57 10;-2.356 10;-1.57 8;2.356 13;-2.356 6;3.14159 12;-2 12;2 6;3.14159 13;2.356 8;-2.356 10;1.57 10;2.356 10;1.57 10;0 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level10.story = Wow, that is truly a powerfull weapon! Unfortunally, I guess we under-estimated the ship's power because the weapon we designed isn't enough powerfull to completely destroy the ship. Wait, we will try to design a new one.

  var %level11 = $rgb(255,0,0)  6    50    700       2.3      57              15       5;.785 25;.785 10;0 45;-1.57 10;3.14159 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 10;3.14159 45;1.57 10;0 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level11.story = Dude, this isn't an easy task, believe me. All of our technicians are on the job and they can't get it done right now, you will have to hold back the ship once again.

  var %level12 = $rgb(255,0,0)  6    50    900       2.5      57              15       5;.785 25;.785 10;0 45;-1.57 7;-2.35 7;2.35 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 7;-2.35 7;2.35 45;1.57 10;0 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level12.story = Crrr. Crrr .. Dude Crrr .. can't ... Crrrr speak ... Crrr ship ... Crr intercepting ... Crrrr ... communications.. .. Crrr

  var %level13 = $rgb(255,0,0)  7    50    1200      2.7      57              20       5;.785 25;.785 14;-.785 34;-1.57 7;-2.35 7;2.35 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 7;-2.35 7;2.35 34;1.57 14;.785 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level13.story = Finally, we have the communication back. We are sorry about that, the ship was intercepting our communications and messing around with it. Keep the ship down again please!

  var %level14 = $rgb(255,0,0)  10   60    25000     3.5      57              57       5;.785 25;.785 14;-.785 34;-1.57 25;-2.35 8;2.35 19;.785 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 19;-.78 8;-2.35 25;2.35 34;1.57 14;.785 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  var %level14.story = We have found how to create the ultimate weapon and we have installed it on your ship. Finally you will be able to destroy it for good!
  var %level14.inc = 20


  ;  20;3.14159 10;1.57 8;-.785398 10;0 20;1.57 27;-.785398 10;0 8;-.785398 8;-2.356194 10;3.14159 27;-2.356194 20;1.57 10;3.14159 8;-2.356194 16;1.57

  ; reset les missiles pour ne pas rester ak les anciens dans un nouveau niveau
  hadd missile missileN 1
  hadd missile missileP 1

  var %currentlevel = $eval($+(%,level,$1),2)


  if (%currentlevel) {
    hadd missile level.color $gettok(%currentLevel,1,32)
    hadd missile level.vel $gettok(%currentLevel,2,32)
    hadd missile level.eSize $gettok(%currentLevel,3,32)
    hadd missile level.energy $gettok(%currentLevel,4,32)
    hadd missile level.maxEnergy $gettok(%currentLevel,4,32)
    hadd missile level.fleeVel $gettok(%currentLEvel,5,32)
    hadd missile level.missile $gettok(%currentLevel,6,32)
    hadd missile level.homing $gettok(%currentLevel,7,32)
    hadd missile level.vect $gettok(%currentLevel,8-,32)

    hadd missile missilePower $calc($hget(missile,missilePower) + $eval($+(%,level,$1,.inc),2))

    hadd missile level.intro $eval($+(%,level,$1,.story),2)
    hadd missile win 0
    hadd missile deadAt 0
    hadd missile pause 0
    hadd missile inGame 1
  }
  else {
    hadd missile win 0
    hadd missile Congrats 1
  }
}


alias missile.generateBackground {
  drawrect -rf @missile.stars1 16777215 1 0 0 500 500
  drawrect -rf @missile.stars2 16777215 1 0 0 500 500
  drawrect -rf @missile.stars3 16777215 1 0 0 500 500

  var %stars = $int($calc($hget(missile,starsNumber) / 3))
  while (%stars) {
    drawdot -r @missile.stars1 $rgb(0,0,0) 1 $r(0,499) $r(0,499)
    drawdot -r @missile.stars2 $rgb(64,64,64) 1 $r(0,499) $r(0,499)
    drawdot -r @missile.stars3 $rgb(128,128,128) 2 $r(0,499) $r(0,499)

    dec %stars
  }
}

alias missile.initFps {
  hadd missile frameCount 0
  hadd missile fps n/a
  hadd missile frameStart $ticks
}

alias missile.die {
  .timerMissile off
  hfree missile
  window -c @missile.stars1
  window -c @missile.stars2
  window -c @missile.stars3
  window -c @missile.buf
  window -c @missile
}

on *:close:@missile:{
  missile.die
}


alias missile.loop {


  drawrect -rnf @missile 0 1 0 0 500 500

  if (($window(@missile).state != minimized) && (!$hget(missile,pause))) {
    missile.render @missile 500 500
  }
  else {
    missile.render_pause_screen @missile
  }

  if ($hget(missile,showfps)) drawtext -nr @missile $rgb(255,255,255) arial 12 5 480 $missile.calcFps fps

  drawdot @missile
  .timerMissile -o 1 0 missile.loop  
}


alias missile.render_Pause_Screen {
  var %color.back = $hget(missile,color.back), %color.back_invert = $hget(missile,color.back_invert)
  var %color.text = $hget(missile,color.text), %color.shadow = $hget(missile,color.shadow)
  var %color.contour = $hget(missile,color.contour)

  if (!$hget(missile,inGame)) {
    var %graph = $hget(missile,graph)
    var %menuPos = $hget(missile,menuPos)

    missile.render_background $1

    if (%graph == 3) {
      var %startY = $calc(%menuPos * 30 + 120)
      drawcopy -rin @missile.buf 0 0 189 $calc(%startY - 129) $1 161 130
      drawcopy -rin @missile.buf 0 0 189 $calc(144 - (%startY - 120)) $1 161 $calc(%starty + 25)
      shape.render $1 %color.contour 0 0 $calc(($ticks / 5) % 550 - 25) 80 2 20;3.14159 10;1.57 8;-.785398 10;0 20;1.57 27;-.785398 10;0 8;-.785398 8;-2.356194 10;3.14159 27;-2.356194 20;1.57 10;3.14159 8;-2.356194 16;1.57
      shape.render $1 %color.contour 0 $calc($ticks / 150) 173 $calc(%menuPos * 30 + 132) 4 6;2.3 12;-1.2 12;1.2 12;-2.5 12;0 13;2.5

      drawtext -rn $1 %color.back arial 30 154 60 Missile Shooter
      drawtext -rn $1 %color.back arial 30 158 60 Missile Shooter
      drawtext -rn $1 %color.back arial 30 156 58 Missile Shooter
      drawtext -rn $1 %color.back arial 30 156 62 Missile Shooter

      ; shadows des éléments du menu
      drawtext -rn $1 %color.shadow arial 20 207 151 Start game
      drawtext -rn $1 %color.shadow arial 20 191 181 Difficulty:
      drawtext -nr $1 %color.shadow arial 12 276 186 $gettok(Baby.Easiest.Easy.Normal.Hard.Hardcore.Impossible,$calc($hget(missile,diff) + 1),46)
      drawtext -rn $1 %color.shadow arial 20 186 211 Graphics:
      drawtext -nr $1 %color.shadow arial 12 276 216 $gettok(Low.Normal.High,$hget(missile,graph),46)
      drawtext -rn $1 %color.shadow arial 20 236 241 Exit

    }
    elseif (%graph == 2) {
      drawrect -nrif $1 %color.back_invert 1 161 130 189 160
      drawrect -nrif $1 %color.back_invert 1 162 $calc(%menuPos * 30 + 120) 187 25
      shape.render $1 %color.contour 0 0 $calc(($ticks / 5) % 550 - 25) 80 2 20;3.14159 10;1.57 8;-.785398 10;0 20;1.57 27;-.785398 10;0 8;-.785398 8;-2.356194 10;3.14159 27;-2.356194 20;1.57 10;3.14159 8;-2.356194 16;1.57

      drawtext -rn $1 %color.back arial 30 154 60 Missile Shooter
      drawtext -rn $1 %color.back arial 30 158 60 Missile Shooter
    }
    else {
      drawrect -nrf $1 %color.back 1 161 130 189 160
      drawrect -nrif $1 %color.back_invert 1 162 $calc(%menuPos * 30 + 120) 187 25
    }

    drawrect -nr $1 %color.contour 1 161 130 189 160
    drawrect -nr $1 %color.contour 1 161 $calc(%menuPos * 30 + 120) 189 25


    drawtext -rn $1 %color.text arial 30 156 60 Missile Shooter
    drawtext -rn $1 %color.text arial 20 205 150 Start game
    drawtext -rn $1 %color.text arial 20 190 180 Difficulty:
    drawtext -nr $1 %color.text arial 12 275 185 $gettok(Baby.Easiest.Easy.Normal.Hard.Hardcore.Impossible,$calc($hget(missile,diff) + 1),46)
    drawtext -rnf $1 %color.text arial 20 185 210 Graphics:
    drawtext -nr $1 %color.text arial 12 275 215 $gettok(Low.Normal.High,$hget(missile,graph),46)
    drawtext -rnf $1 %color.text arial 20 235 240 Exit

    var %msg = creation.of.visionz
    if (%graph > 2) {
      var %i = 1, %t = $len(%msg), %y, %s
      while (%i <= %t) {
        %s = $sin($calc(($ticks + %i * 80) / 200))
        %y = $calc(%s * 10 + 470)
        drawtext -nr $1 $rgb(0,$abs($calc(%s * 255)),255) fixedsys 10 $calc(355 + %i * 7) %y $mid(%msg,%i,1)
        inc %r 4
        inc %g 10
        inc %i
      }
    }
    else {
      drawtext -nr $1 %color.text fixedsys 10 340 480 %msg
    }
  }
  elseif ($hget(missile,win)) {
    missile.render_scorecard $1
  }
  elseif ($hget(missile,Congrats)) {
    missile.render_congrats $1
  }
  else {
    drawtext -r $1 %color.text arial 20 225 230 Pause
  }
}





alias missile.render_congrats {
  var %color.text = $hget(missile,color.text)
  var %color.contour = $hget(missile,color.contour)
  var %color.back = $hget(missile,color.back)
  missile.render_background $1

  ; shape.render $1 %color.contour 0 0 260 250 2 200;.78 300;3.1415 300;-1.57 300;0 300;1.57
  ;  shape.render $1 %color.contour 0 0 300 150 2 0;0 100;2.356 100;-2.356 100;-.785 100;3.14159 100;-2.356 100;2.356 100;3.14159 100;.785

  shape.render $1 %color.contour 0 $calc($ticks / 150) 150 62 4 6;2.3 12;-1.2 12;1.2 12;-2.5 12;0 13;2.5
  shape.render $1 %color.contour 0 $calc($ticks / 150) 360 62 4 6;2.3 12;-1.2 12;1.2 12;-2.5 12;0 13;2.5


  shape.render $1 %color.contour 0 0 250 250 22 76;1.45 200;.785398 400;-1.9634 400;1.9634 400;-0.7853 260;3.14159 204;.785398
  shape.render $1 %color.back 0 0 250 250 18 76;1.45 200;.785398 400;-1.9634 400;1.9634 400;-0.7853 260;3.14159 204;.785398
  drawtext -rn $1 %color.text arial 20 20 20 Congrats you have saved the space from the evil-ship
  drawtext -rn $1 %color.text arial 20 163 50 Final score: $hget(missile,points)

}



alias missile.render_scorecard {
  var %color.back = $hget(missile,color.back), %color.back_invert = $hget(missile,color.back_invert)
  var %color.text = $hget(missile,color.text), %color.shadow = $hget(missile,color.shadow)
  var %color.contour = $hget(missile,color.contour)

  var %graph = $hget(missile,graph)
  missile.render_background $1

  var %win = $1

  if (%graph > 1) {
    drawtext -rn %win %color.back arial 30 82 40 You have defeated the level!
    drawtext -rn %win %color.back arial 30 86 40 You have defeated the level!
  }
  if (%graph > 2) {
    drawtext -rn %win %color.back arial 30 84 38 You have defeated the level!
    drawtext -rn %win %color.back arial 30 84 42 You have defeated the level!
  }

  drawtext -rn %win %color.text arial 30 84 40 You have defeated the level!
  if (%graph == 3) {
    drawcopy -rifn @missile.buf 0 170 250 200 %win 135 120
  }
  elseif (%graph == 2) drawrect -rifn %win %color.back_invert 1 135 120 250 200
  else drawrect -rfn %win %color.back 1 135 120 250 200

  drawrect -rn %win %color.contour 1 135 120 250 200

  var %firedShot = $hget(missile,shotFired)
  var %Perfect = $hget(missile,shotperfect)
  var %nice = $hget(missile,shotnice)

  var %ranking = Baby.n00b.Amateur.Cool.Crazy.Pro.Amazing.Perfect
  var %total = $calc($int($calc(((%perfect + %nice) / %firedShot) * 7)) + 1)

  if (%graph > 2) {
    drawtext -rn %win %color.shadow arial 16 152 142 Shot fired: 
    drawtext -rn %win %color.shadow arial 14 307 145 $base(%firedShot,10,10,3) |
    drawtext -rn %win %color.shadow arial 14 342 145 100%

    drawtext -rn %win %color.shadow arial 16 152 172 Perfect shot: 
    drawtext -rn %win %color.shadow arial 14 307 175 $base(%perfect,10,10,3) |
    drawtext -rn %win %color.shadow arial 14 342 175 $round($calc(%perfect / %firedShot * 100),1) $+ %

    drawtext -rn %win %color.shadow arial 16 152 202 Nice shot:
    drawtext -rn %win %color.shadow arial 14 307 205 $base(%nice,10,10,3) |
    drawtext -rn %win %color.shadow arial 14 342 205 $round($calc(%nice / %firedShot * 100),1) $+ %

    drawtext -rn %win %color.shadow arial 16 152 232 Missed shot:
    drawtext -rn %win %color.shadow arial 14 307 235 $base($calc(%firedShot - %perfect - %nice),10,10,3) |
    drawtext -rn %win %color.shadow arial 14 342 235 $round($calc((%firedShot - %perfect - %nice) / %firedShot * 100),1) $+ %

    drawtext -rn %win %color.shadow arial 16 152 272 Ranking:
    drawtext -rn %win %color.shadow arial 14 282 275 $gettok(%ranking,%total,46) shooter
  }

  drawtext -rn %win %color.text arial 16 150 140 Shot fired: 
  drawtext -rn %win %color.text arial 14 305 143 $base(%firedShot,10,10,3) |
  drawtext -rn %win %color.text arial 14 340 143 100%

  drawtext -rn %win %color.text arial 16 150 170 Perfect shot: 
  drawtext -rn %win %color.text arial 14 305 173 $base(%perfect,10,10,3) |
  drawtext -rn %win %color.text arial 14 340 173 $round($calc(%perfect / %firedShot * 100),1) $+ %

  drawtext -rn %win %color.text arial 16 150 200 Nice shot:
  drawtext -rn %win %color.text arial 14 305 203 $base(%nice,10,10,3) |
  drawtext -rn %win %color.text arial 14 340 203 $round($calc(%nice / %firedShot * 100),1) $+ %

  drawtext -rn %win %color.text arial 16 150 230 Missed shot:
  drawtext -rn %win %color.text arial 14 305 233 $base($calc(%firedShot - %perfect - %nice),10,10,3) |
  drawtext -rn %win %color.text arial 14 340 233 $round($calc((%firedShot - %perfect - %nice) / %firedShot * 100),1) $+ %

  drawtext -rn %win %color.text arial 16 150 270 Ranking:
  drawtext -rn %win %color.text arial 14 280 273 $gettok(%ranking,%total,46) shooter
  if ($calc($ticks - $hget(missile,win.start)) > 3000) {
    drawtext -rn %win %color.text arial 12 350 480 Click anywhere to continue
  }
}

alias missile.calcFps {
  hinc missile frameCount
  if ($calc($ticks - $hget(missile,frameStart)) > 1000) {
    hadd missile fps $hget(missile,frameCount)
    hadd missile frameCount 0
    hadd missile frameStart $ticks
  }
  return $int($hget(missile,fps))
}




alias missile.render {

  hadd missile flee 0





  missile.handle_mouse_move $hget(missile,mouse.x) $hget(missile,mouse.y)
  missile.render_background $1
  missile.handle_homing $1
  missile.handle_missiles $1
  missile.handle_explosion $1
  missile.handle_traj $1

  if (!$hget(missile,showIntro)) {
    missile.handle_enemy $1
    missile.handle_bonus $1
  }

  missile.render_interface $1
  missile.render_message $1


  ;  shape.render $1 16777215 0 0 100 100 2 5;.785 25;.785 10;0 45;-1.57 7;-2.35 7;2.35 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 7;-2.35 7;2.35 45;1.57 10;0 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  ;  shape.render $1 16777215 0 0 200 100 2 5;.785 25;.785 14;-.785 34;-1.57 7;-2.35 7;2.35 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 7;-2.35 7;2.35 34;1.57 14;.785 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57
  ;  shape.render $1 16777215 0 0 300 100 2 5;.785 25;.785 14;-.785 34;-1.57 25;-2.35 8;2.35 19;.785 25;1.57 13;-2.356 8;3.14159 12;-2 12;2 8;3.14159 13;2.356 25;-1.57 19;-.78 8;-2.35 25;2.35 34;1.57 14;.785 25;-.785 10;1.57 7;.78 7;-.78 10;-1.57

}

alias missile.handle_bonus {
  if ($hget(missile,bonusOnScreen)) {
    var %x = $hget(missile,bonus.x)
    inc %x 1
    %y = $calc($sin($calc($ticks / 500)) * 100 + 250)
    missile.render_bonus $1 %x %y
    hadd missile bonus.x %x
    hadd missile bonus.y %y
    if (%x > 520) {
      hadd missile bonusOnScreen 0
      var %nextBonus = $r(10000,20000)
      if ($hget(missile,fastBonus)) %nextBonus = 200
      hadd missile bonus $calc($ticks - $hget(missile,levelstart) + %nextBonus)
    }
  }
  else {
    if ($calc($ticks - $hget(missile,levelstart)) > $hget(missile,bonus)) {

      hadd missile Bonus.x -100
      hadd missile Bonus.y 240
      hadd missile BonusOnScreen 1
    }
  }

}

;x y
alias missile.render_bonus {

  var %size = $calc($sin($calc(($ticks % 500) / 500)) * 20 + 5), %color.back = $hget(missile,color.back)
  drawdot -rin $1 $rgb(0,0,0) %size $2 $3
  drawdot -rin $1 %color.back $calc(%size - 1) $2 $3
  drawdot -rin $1 %color.back $calc(%size - 5) $2 $3
  drawdot -rin $1 $rgb(0,0,0) $calc(%size - 6) $2 $3
  drawtext -rn $1 $hget(missile,color.text) arial 12 $calc($2 - 22) $calc($3 - 35) BoNuS!
}



alias missile.render_message {
  var %start = $hget(missile,message.start)
  if ($calc($ticks - %start) > 2500) {
    hadd missile message.start 0
  }
  else {
    var %y = $hget(missile,message.y)
    drawtext -nr $1 $hget(missile,color.text) "comic sans ms" 16 $hget(missile,message.x) %y $hget(missile,message.msg)
    var %diff = $calc($ticks - %start)
    if (%diff <= 1750) dec %y $calc(((1750 - %diff) / 800) ^ 2)
    ; else inc %y $calc(((%diff - 700) / 400) ^2)
    hadd missile message.y %y
  }

  if ($hget(missile,showIntro)) {
    var %intro = $hget(missile,level.intro)

    var %color.back = $hget(missile,color.back), %color.back_invert = $hget(missile,color.back_invert)
    var %color.text = $hget(missile,color.text), %color.shadow = $hget(missile,color.shadow)
    var %color.contour = $hget(missile,color.contour)

    var %graph = $hget(missile,graph)
    if (%graph == 3) {
      drawcopy -nri @missile.buf 0 170 430 110 $1 10 380
    }
    elseif (%graph == 2) {
      drawrect -nifr $1 %color.back_invert 1 10 380 430 110
    }
    else {
      drawrect -nfr $1 %color.back 1 10 380 430 110
    }

    drawrect -nr $1 %color.contour 1 10 380 430 110

    drawrect -nfr $1 0 1 20 390 410 90
    drawrect -nr $1 %color.contour 1 20 390 410 90

    drawtext -nr $1 %color.text arial 11 10 366 Message:
    if ($len(%intro)) {

      var %i = 1, %t = $wrap(%intro,arial,11,400,0)
      while (%i <= %t) {
        drawtext -nr $1 %color.text arial 11 30 $calc(380 + %i * 20) $wrap(%intro,arial,11,400,%i)
        inc %i
      }
      if ($calc($ticks - $hget(missile,levelstart)) > 2000) {
        drawtext -nr $1 %color.text arial 9 335 478 [Click anywhere to start]
      }
    }
    else {
      drawtext -nr $1 %color.text arial 11 30 400 You have to destroy the ship to pass the level!
    }
  }
}

alias missile.render_interface {
  var %color.back = $hget(missile,color.back), %color.back_invert = $hget(missile,color.back_invert)
  var %color.text = $hget(missile,color.text), %color.shadow = $hget(missile,color.shadow)
  var %color.contour = $hget(missile,color.contour)

  var %graph = $hget(missile,graph)

  var %maxEnergy = $hget(missile,level.maxEnergy)
  var %energy = $hget(missile,level.energy)

  var %value = $int($calc((%energy / %maxEnergy) * 98))
  var %y = $calc(386 + (%maxEnergy - %energy) * (98 / %maxEnergy))
  var %g = $int($calc(255 - (%value / 98 * 255))), %r = $calc(255 - %g)

  if (%graph == 3) {
    drawcopy -rin @missile.buf 0 170 480 40 $1 10 10
    drawrect -nifr $1 %color.back_invert 1 450 380 40 110
    drawrect -nifr $1 %color.back_invert 1 456 386 28 98
    drawrect -nfr $1 0 1 314 17 169 12
    drawrect -nfr $1 0 1 314 32 169 12
  }
  elseif (%graph == 2) {
    drawrect -nifr $1 %color.back_invert 1 10 10 480 40
    drawrect -nifr $1 %color.back_invert 1 450 380 40 110
    drawrect -nifr $1 %color.back_invert 1 456 386 28 98
    drawrect -nifr $1 %color.back_invert 1 314 17 169 12
    drawrect -nifr $1 %color.back_invert 1 314 32 169 12
  }
  else {
    drawrect -nfr $1 %color.back 1 10 10 480 40
    drawrect -nfr $1 %color.back 1 450 380 40 110
    drawrect -nrf $1 %color.back 1 456 386 28 98
  }

  if (%graph > 2) {
    drawtext -nr $1 %color.shadow arial 14 261 15 Missiles 
    drawtext -nr $1 %color.shadow arial 14 261 30 Homing
    drawtext -nr $1 %color.shadow arial 14 17 15 Points:
    drawtext -rn $1 %color.shadow arial 14 67 15 $base($hget(missile,points),10,10,8)
    drawtext -nr $1 %color.shadow arial 14 17 30 Level:
    drawtext -rn $1 %color.shadow arial 14 102 30 $base($hget(missile,level),10,10,3)
  }

  drawrect -nr $1 %color.contour 1 10 10 480 40
  drawrect -nr $1 %color.contour 1 450 380 40 110

  if (%value) {
    if (%graph > 1) drawrect -rfin $1 $rgb(%r,%g,255) 1 456 %y 28 %value
    else drawrect -rfn $1 $rgb(%g,%r,0) 1 456 %y 28 %value
    drawline -rn $1 0 1 456 %y 484 %y
  }

  drawtext -rn $1 %color.text arial 11 453 366 Enemy
  drawrect -rn $1 0 1 456 386 28 98

  drawtext -nr $1 %color.text arial 14 260 14 Missiles
  var %missile = $str(|,$hget(missile,level.missile))
  if (%missile) drawtext -nr $1 %color.text arial 14 307 14 : %missile

  drawtext -nr $1 %color.text arial 14 260 29 Homing 
  var %homing = $str(|,$hget(missile,level.homing))
  if (%homing) drawtext -nr $1 %color.text arial 14 307 29 : %homing


  drawrect -rn $1 %color.contour 1 314 17 169 12
  drawrect -rn $1 %color.contour 1 314 32 169 12

  drawtext -rn $1 %color.text arial 14 16 14 Points:
  drawtext -rn $1 %color.text arial 14 66 14 $base($hget(missile,points),10,10,8)

  drawtext -rn $1 %color.text arial 14 16 29 Level:
  drawtext -rn $1 %color.text arial 14 101 29 $base($hget(missile,level),10,10,3)

  var %code = $hget(missile,code)
  if (%code) drawtext -nr $1 %color.text arial 14 300 480 : %code
}


alias missile.handle_mouse_move {
  if ($hget(missile,traj)) {
    var %x1 = $hget(missile,traj.x), %y1 = $hget(missile,traj.y)

    var %length = $int($sqrt($calc(($1 - %x1) ^2 + ($2 - %y1) ^2)))
    if (%length < 10) %length = 10
    hadd missile traj.a $atan2($calc($1 - %x1),$calc($2 - %y1))
    hadd missile traj.l %length
  }

  var %flee = $missile.verify_is_danger_near($1,$2,$hget(missile,targetX),$hget(missile,targetY),$hget(missile,level.eSize))
  hadd missile flee $or($hget(missile,flee),%flee)

  /*
  if (%flee) {
    hadd missile Danger.x $1
    hadd missile Danger.y $2
  }
  */
}


alias missile.render_background {
  var %graph = $hget(missile,graph)

  if (%graph > 2) {
    var %bgPos = $calc(0 - $ticks / 20 % 500)
    drawcopy -nir @missile.stars1 $abs(%bgPos) 0 $calc(500 + %bgPos) 500 $1 0 0
    drawcopy -nir @missile.stars1 0 0 $abs(%bgPos) 500 $1 $calc(500 + %bgPos) 0
  }
  if (%graph > 1) {
    var %bgPos = $calc(0 - $ticks / 15 % 500)
    drawcopy -nir @missile.stars2 $abs(%bgPos) 0 $calc(500 + %bgPos) 500 $1 0 0
    drawcopy -nir @missile.stars2 0 0 $abs(%bgPos) 500 $1 $calc(500 + %bgPos) 0
  }
  var %bgPos = $calc(0 - $ticks / 10 % 500)
  drawcopy -nir @missile.stars3 $abs(%bgPos) 0 $calc(500 + %bgPos) 500 $1 0 0
  drawcopy -nir @missile.stars3 0 0 $abs(%bgPos) 500 $1 $calc(500 + %bgPos) 0

}



alias missile.handle_traj {
  if ($hget(missile,traj)) {
    var %x = $hget(missile,traj.x), %y = $hget(missile,traj.y), %length = $hget(missile,traj.l), %angle = $hget(missile,traj.a)
    var %x2 = $calc(%x + $cos(%angle) * %length), %y2 = $calc(%y + $sin(%angle) * %length)
    var %graph = $hget(missile,graph)    

    if (%graph == 1)  drawline -rn $1 $hget(missile,color.contour) 2 %x %y %x2 %y2
    elseif (%graph == 2) shape.render $1 $hget(missile,color.contour) 0 %angle %x2 %y2 1 1;0 %length $+ ; $+ 3.14159 10;.7853 14;-1.57 10;2.356
    else shape.render $1 $hget(missile,color.contour) 0 %angle %x2 %y2 1 20;0 5;1.57 %length $+ ; $+ 3.14159 5;1.57 10;4 10;5.5 5;1.57 %length $+ ; $+ 0
  }
}



alias missile.handle_explosion {
  var %targetX = $hget(missile,targetX), %targetY =  $hget(missile,targetY), %eSize = $hget(missile,level.eSize)

  if ($hget(missile,explosion)) {
    if ($calc($ticks - $ifmatch) > 500) hadd missile explosion 0
    var %size = $r(15,35)
    shape.render $1 $rgb($r(200,255),$r(0,255),0) 0 $calc($ticks / 150) $r($calc(%targetX - %eSize),$calc(%targetX + %eSize)) $r($calc(%targetY - %eSize),$calc(%targetY + %eSize)) 4 6;2.3 12;-1.2 12;1.2 12;-2.5 12;0 13;2.5

  }
  elseif ($hget(missile,finalExplosion)) {
    var %size = $r(15,55)
    drawrect -nref $1 $rgb($r(200,255),$r(0,150),0) 1 $r($calc(%targetX - %eSize),$calc(%targetX + %eSize)) $r($calc(%targetY - %eSize),$calc(%targetY + %eSize)) %size %size
    shape.render $1 $rgb($r(200,255),$r(0,255),0) 0 $calc($ticks / 150) $r($calc(%targetX - %eSize),$calc(%targetX + %eSize)) $r($calc(%targetY - %eSize),$calc(%targetY + %eSize)) 4 6;2.3 12;-1.2 12;1.2 12;-2.5 12;0 13;2.5
  }

  :error
  reseterror
}

alias missile.handle_homing {
  var %targetX = $hget(missile,targetX), %targetY =  $hget(missile,targetY), %eSize = $hget(missile,level.eSize)

  if ($hget(missile,homing)) {

    var %x = $hget(missile,x), %y = $hget(missile,y), %angle = $hget(missile,angle), %vel = $hget(missile,vel)
    missile.render_missile $1 %angle %x %y 1

    var %DestAngle = $atan2($calc(%x - %targetx),$calc(%y - %targety))
    if (%vel) {
      if (%angle < %destAngle) inc %angle .1
      if (%angle > %destAngle) dec %angle .1
    }

    dec %x $calc(%vel * $cos(%angle))
    dec %y $calc(%vel * $sin(%angle))

    if (%x < 0) %x = 500
    if (%x > 500) %x = 0
    if (%y < 0) %y = 500
    if (%y > 500) %y = 0

    hadd missile x %x
    hadd missile y %y

    hadd missile angle %angle

    var %flee = $missile.verify_is_danger_near(%x,%y,%targetX,%targetY,%eSize)
    hadd missile flee $or($hget(missile,flee),%flee)

    /*
    if (%flee) {
      hadd missile Danger.X %x
      hadd missile Danger.Y %y
    }
    */

    if ($calc($ticks - $hget(missile,homingstart)) > 2500) {
      dec %vel 0.025
      if (%vel < .2) {
        %vel = 0
        .timer 1 1 missile.kill_homing
      }
      hadd missile vel %vel
    }

    if ($missile.verify_collision(%x,%y,%targetX,%targetY,%eSize)) {
      hadd missile Message.Start $ticks
      hadd missile Message.x %targetX
      hadd missile Message.y %targetY

      missile.hit_enemy

      var %msg
      var %inarow = $hget(missile,shotInARow)
      if (%inARow > 1) %msg = $+($chr(40),%InARow,x,$chr(41))

      if (($ifmatch > 6) && ($ifmatch < 14)) {
        hadd missile message.msg Perfect %msg
        hinc missile shotPerfect
      }
      else {
        hadd missile message.msg Nice %msg
        hinc missile shotNice
      }



      hadd missile homing 0     
      hadd missile flee 0
    }
  }
}


alias missile.kill_homing {
  hadd missile shotInARow 0
  hadd missile Homing 0
}


alias missile.handle_enemy {
  var %targetX = $hget(missile,targetX), %targetY = $hget(missile,targetY), %targetAngle = $hget(missile,targetAngle), %targetVel = $hget(missile,level.vel)
  var %flee = $hget(missile,flee), %diff = $hget(missile,diff), %dead = $hget(missile,deadAt)

  shape.render $1 $hgeT(missile,level.color) 0 $calc(%targetAngle + 1.57) %targetX %targetY 2 $hget(missile,level.vect)

  if ((%flee) && (!%dead)) {
    ;    var %danger.X = $hget(missile,danger.x), %danger.y = $hget(missile,danger.y)
    ;    var %dest_angle = $calc($atan2($calc(%danger.x - %targetX),$calc(%danger.y - %targetY)) + $pi)

    ;    drawtext -nr $1 16777215 arial 30 0 100 dest = %dest_angle target = %targetangle
    ; drawtext -nr $1 16777215 arial 30 0 150 diff = $calc(%dest_angle - %targetAngle)

    ; %targetAngle = $calc(%dest_angle + $pi)
    ; if (%targetAngle < %dest_angle) inc %targetAngle .1

    inc %targetVel $calc($hget(missile,level.fleeVel) * %diff)
    inc %targetAngle .1
  }


  inc %targetX $calc(%targetVel * $cos(%targetAngle))
  inc %targetY $calc(%targetVel * $sin(%targetAngle))

  if (%targetX > 500) %targetX = 0
  elseif (%targetX < 0) %targetX = 500

  if (%TargetY < 0) %targetY = 500
  elseif (%targetY > 500) %targetY = 0

  if (%dead) {
    var %vel = $hget(missile,level.vel)
    dec %vel .01
    if (%vel < 0) {
      %vel = 0
      if (!$hget(missile,doneExplosion)) {
        .timer 1 1 hadd missile finalExplosion 1
        .timer 1 4 missile.win_level
        hadd missile doneExplosion 1
      }
    }
    hadd missile level.vel %vel
  }

  if (!$inrect(%targetX,%targetY,25,25,450,450)) {

    dec %targetAngle 0.05

    if (%targetAngle < 0) %targetAngle = 6.283185
    if (%targetAngle > 6.283185) %targetAngle = 0
  }

  hadd missile targetAngle %targetAngle

  hadd missile targetX %targetX
  hadd missile targetY %targetY
  ; hadd missile targetX $mouse.x
  ; hadd missile targeTY $mouse.y
}

alias missile.win_level {
  hadd missile win.start $ticks
  hadd missile finalExplosion 0
  hadd missile win 1
  hadd missile pause 1
}


alias missile.handle_missiles {
  var %i = $hget(missile,missilep), %t = $hget(missile,missilen), %targetX = $hget(missile,targetX), %targetY = $hget(missile,targetY), %eSize = $hget(missile,level.eSize)

  var %flee = $hget(missile,flee)

  while (%i < %t) {
    if ($hget(missile,$+(missile.,%i))) {
      var %x = $hget(missile,$+(missile.,%i,.x)), %y = $hget(missile,$+(missile.,%i,.y))
      var %angle = $hget(missile,$+(missile.,%i,.a)), %vel = $hget(missile,$+(missile.,%i,.vel))
      missile.render_missile $1 %angle %x %y

      inc %x $calc(%vel * $cos(%angle))
      inc %y $calc(%vel * $sin(%angle))

      hadd missile $+(missile.,%i,.x) %x
      hadd missile $+(missile.,%i,.y) %y

      ; si le missile est hors borne
      if (!$inrect(%x,%y,0,0,500,500)) {
        hadd missile shotInARow 0
        hadd missile flee 0
        hadd missile $+(missile.,%i) 0
        hinc missile missilep
      }

      var %dangernear = $missile.verify_is_danger_near(%x,%y,%targetX,%targetY,%eSize)
      %flee = $or(%flee,%dangernear)
      /*
      if (%flee) {
        hadd missile danger.x %x
        hadd missile danger.y %y
      }
      */
      if ($hget(missile,bonusOnScreen)) {
        if ($missile.verify_collision(%x,%y,$hget(missile,bonus.x),$hget(missile,bonus.y),40,40)) {

          var %r = $r(1,4)

          hadd missile Message.Start $ticks
          hadd missile Message.x $hget(missile,bonus.x)
          hadd missile Message.y $hget(missile,bonus.y)

          ; bonus
          if (%r <= 2) {
            hinc missile missilePower
            hadd missile message.msg +1 missile power
          }
          elseif (%r == 3) { 
            var %miss = $hget(missile,level.missile) 
            inc %miss 20
            if (%miss > 56) %miss = 56
            hadd missile level.missile %miss

            hadd missile message.msg +20 missiles
          }
          elseif (%r == 4) {
            var %miss = $hget(missile,level.homing) 
            inc %miss 5
            if (%miss > 56) %miss = 56
            hadd missile level.homing %miss
            hadd missile message.msg +5 homing missiles
          }

          hadd missile BonusOnScreen 0
          var %nextBonus = $r(30000,60000)
          if ($hget(missile,fastBonus)) %nextBonus = 200
          hadd missile bonus $calc($ticks - $hget(missile,levelstart) + %nextBonus)

          hadd missile $+(missile.,%i) 0
          hinc missile missilep

        }
      }

      if ($missile.verify_collision(%x,%y,%targetX,%targetY,%eSize)) {
        hadd missile Message.Start $ticks
        hadd missile Message.x %targetX
        hadd missile Message.y %targetY

        var %msg
        var %inarow = $hget(missile,shotInARow)
        if (%inARow > 1) %msg = $+($chr(40),%InARow,x,$chr(41))

        if (($ifmatch > 6) && ($ifmatch < 14)) {
          hadd missile message.msg Perfect %msg
          hinc missile shotPerfect
        }
        else {
          hadd missile message.msg Nice %msg
          hinc missile shotNice
        }

        hadd missile $+(missile.,%i) 0
        hinc missile missilep
        hadd missile flee 0
        missile.hit_enemy 
      }
    }
    inc %i
  }

  hadd missile flee %flee
}



alias missile.hit_enemy {
  var %missilePower = $hget(missile,missilePower)
  var %hp = $hget(missile,level.energy)
  dec %hp %missilePower

  hinc missile shotInARow

  var %shotInARow = $hget(missile,shotInARow)

  if (%hp <= 0) {
    ; enemy is dead!

    ; donne 50 points par missile restant et 100 points par homing missile restant
    hinc missile points $calc(($hget(missile,level.missile) * 50) + ($hget(missile,level.homing) * 100))
    hadd missile deadAt $ticks

    %hp = 0
  }

  hadd missile level.energy %hp
  hinc missile points $calc((%missilePower * 100) + (%shotInARow * 50))

  hadd missile explosion $ticks
}


; x y boss_x boss_y size
alias missile.verify_is_danger_near {
  var %eSize = $5, %eSizeDiv2 = $calc($5 / 2), %eSizePlus = $calc(%eSize + (40 * $hget(missile,diff)))
  var %eSizePlusDiv2 = $calc(%eSizePlus / 2)
  if ($inrect($1,$2,$calc($3 - %eSizePlusDiv2),$calc($4 - %eSizePlusDiv2),%eSizePlus,%eSizePlus)) {
    return 1
  }
  return 0

}

; x y boss_x boss_y size
alias missile.verify_collision {
  var %halfsize = $calc($5 / 2), %x = $calc($3 - %halfsize), %y = $calc($4 - %halfsize)
  if ($inrect($1,$2,%x,%y,$5,$5)) {
    return $int($calc((($1 - %x) / $5 * 10) + (($2 - %y) / $5 * 10)))
  }
  return 0
}




; win angle x y [homing]
alias missile.render_missile {

  var %angle = $2, %x = $3, %y = $4, %power = $hget(missile,missilePower)
  drawline -rn $1 $rgb(255,255,255) $calc(%power + 2) %x %y $calc(%x - 15 * $cos(%angle)) $calc(%y - 15 * $sin(%angle))
  if ($hget(missile,graph) > 1) {
    drawline -rn $1 $rgb(0,255,0) %power %x %y $calc(%x - 15 * $cos(%angle)) $calc(%y - 15 * $sin(%angle))
    if ($5) drawline -rn $1 $calc($ticks % 255) %power %x %y $calc(%x - 5 * $cos(%angle)) $calc(%y - 5 * $sin(%angle))
  }
}



; x y
alias atan2 {
  var %x = $1, %y = $2
  if (%x == 0) %x = .1
  var %a = $atan($calc(%y / %x))
  if (%x < 0) inc %a $pi

  ;  if (%x > 0) return $atan($calc(%y / %x))
  ;  else return $calc(3.14156 + $atan($calc(%y / %x)))
  return %a
}




alias shape.render {
  var %i = 1, %s, %a, %lx = $5, %ly = $6, %h, %todraw
  while ($gettok($8-,%i,32)) {
    %s = $gettok($v1,1,59)
    %a = $calc($4 + $gettok($v1,2,59))
    %lx = $calc(%lx + $cos(%a) * %s)
    %ly = $calc(%ly + $sin(%a) * %s)
    %todraw = %todraw %lx %ly
    inc %i
  }
  ;  drawdot -nr $1 $2 2 $5 $6
  drawline -rn $1 $2 $7 %todraw
  if ($3) drawfill -rn $1 $2 $2 $5 $6
}


menu @missile {
  sclick {
    if ((!$hget(missile,pause)) && (!$hget(missile,showIntro))) {
      hadd missile traj 1
      hadd missile traj.x $mouse.x
      hadd missile traj.y $mouse.y
      hadd missile traj.l 10
      hadd missile traj.a 0
    }
    elseif ($hget(missile,win)) {
      if ($calc($ticks - $hget(missile,win.start)) > 3000) {
        hinc missile level
        missile.init_level $hget(missile,level)
      }
    }
    elseif ($hget(missile,showIntro)) {
      if ($calc($ticks - $hget(missile,levelStart)) > 2000) {
        hadd missile showIntro 0

        hadd missile Message.Start $ticks
        hadd missile Message.x 200
        hadd missile Message.y 300
        hadd missile message.msg Entering level $hget(missile,level)
      }
    }
  }
  uclick {
    if ((!$hget(missile,pause)) && (!$hget(missile,showIntro))) {

      if ($hget(missile,traj) && ($hget(missile,level.missile) > 0)) {
        var %x1 = $hget(missile,traj.x), %y1 = $hget(missile,traj.y)
        var %length = $int($sqrt($calc(($mouse.x - %x1) ^2 + ($mouse.y - %y1) ^2)))
        var %angle = $atan2($calc($mouse.x - %x1),$calc($mouse.y - %y1))

        var %n = $hget(missile,missileN)

        hadd missile $+(missile.,%n) 1

        hadd missile $+(missile.,%n,.x) $calc(%x1 + $cos(%angle) * %length)
        hadd missile $+(missile.,%n,.y) $calc(%y1 + $sin(%angle) * %length)
        hadd missile $+(missile.,%n,.a) $calc(%angle + $pi)
        hadd missile $+(missile.,%n,.vel) $int($calc(%length / 20 + 1))

        hdec missile level.missile
        hinc missile shotFired
        hinc missile missileN

      }

      hadd missile traj 0
    }
  }
  leave {

  }
  mouse {
    hadd missile mouse.x $mouse.x
    hadd missile mouse.y $mouse.y
  }

  rclick {
    if ((!$hget(missile,pause)) && (!$hget(missile,showIntro))) {


      if (($hget(missile,level.homing) > 0) && (!$hget(missile,homing))) {
        var %x = $mouse.x, %y = $mouse.y
        var %targetX = $hget(missile,targetX), %targetY = $hget(missile,targetY)

        hadd missile homing 1

        hadd missile homingstart $ticks

        hadd missile x %x
        hadd missile y %y

        hadd missile vel $hget(missile,homingVel)

        hdec missile level.homing
        hinc missile shotFired
        hadd missile angle $atan2($calc(%x - %targetx),$calc(%y - %targety))
      }
    }
  }

}




on *:keydown:@missile:*:{
  var %code = $hget(missile,code), %pause = $hget(missile,pause)

  if (($keyval == 27) && (!$keyrpt)) {
    if ($hget(missile,inGame)) {
      if (%pause) hadd missile pause 0
      else hadd missile pause 1
    }
  }

  if (!%pause) {
    if ($keyval == 13) {
      if (%code == fullm) hadd missile level.missile 56
      if (%code == fullh) hadd missile level.homing 56
      if (%code == morepower) hinc missile missilePower
      if (%code == fullpower) hadd missile missilePower 50
      if (%code == lesspower) hdec missile missilepower
      if (%code == nopower) hadd missile missilepower 1
      if (%code == showfps) hadd missile showfps 1
      if (%code == hidefps) hadd missile showfps 0
      if (%code == pause) hadd missile pause 1
      if (%code == ultrahoming) hadd missile homingvel 20
      if (%code == fullenergy) hadd missile level.energy $hget(missile,level.maxEnergy)
      if (%code == highq) hadd missile graph 3
      if (%code == medq) hadd missile graph 2
      if (%code == lowq) hadd missile graph 1
      if (%code == fastbonus) {
        hadd missile bonus 1
        hadd missile fastbonus 1
      }
      if (%code == nofastbonus) hadd missile fastbonus 0
      if (%code == lotsastars) {
        hadd missile starsnumber 20000
        missile.generatebackground
      }
      if (%code == minstars) {
        hadd missile starsnumber 1000
        missile.generatebackground
      }
      if (%code == fullall) {
        hadd missile level.missile 56
        hadd missile level.homing 56
      }  
      if (%code == win) {
        missile.win_level
      }

      var %code
      hadd missile code %code
    }
    elseif ($keyval == 8) {
      if ($len(%code) == 1) {
        var %code
      }
      elseif ($len(%code) > 1) {
        %code = $mid(%code,1,$calc($len(%code) - 1))
      }

      hadd missile code %code
    }
    else {
      if (($keyval >= 65) && ($keyval <= 90)) {
        %code = %code $+ $keychar
        hadd missile code %code
      }
    }
  }
  if ((%pause) && (!$hget(missile,inGame))) {
    var %menuPos = $hget(missile,menuPOs)
    if ($keyval == 38) {
      if (%menuPos > 1) dec %menuPos
    }
    elseif ($keyval == 40) {
      if (%menuPos < 4) inc %menuPos
    }
    hadd missile menuPos %menuPos


    var %diff = $hget(missile,diff)
    if (($keyval == 37) && (%menuPos == 2)) {
      if (%diff > 0) dec %diff
    }
    if (($keyval == 39) && (%menuPos == 2)) {
      if (%diff < 6) inc %diff
    }
    hadd missile diff %diff
    var %graph = $hget(missile,graph)
    if (($keyval == 37) && (%menuPos == 3)) {
      if (%graph > 1) dec %graph
    }
    if (($keyval == 39) && (%menuPos == 3)) {
      if (%graph < 3) inc %graph
    }
    hadd missile graph %graph
    if ($keyval == 13) {
      if (%menuPos == 1) {
        missile.init_level $hget(missile,level)
      }
      elseif (%menuPos == 2) {
        ;        hadd missile diff $calc((%diff + 1) % 7)
      }
      elseif (%menuPos == 3) {
      }
      elseif (%menuPos == 4) {
        missile.die
      }
    }
  }
}








;
