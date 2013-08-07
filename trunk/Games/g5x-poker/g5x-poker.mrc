
; ------------------------------------------------------------------------------------------------------------------
; g5x-poker version 2.69 designed and coded by gorefiend.
; g5x-poker is a poker game for mIRC with an optional strip poker mode.
; ------------------------------------------------------------------------------------------------------------------
; Type /g5x-poker (*command to start the game)
;
; » Read the readme.html for more informations on the game play.
; » Total or partial reproduction of g5x-poker script is totally forbidden
; without my permission!
;

on *:load: {
  linesep | var %pt = " $+ $scriptdirimages\do-not-edit.txt $+ " | write -c %pt
  var %w = $findfile(" $+ $scriptdirimages $+ ",*.jpg,0,1,write %pt $nopath($1-)) | write -dsback.jpg %pt
  echo -at g5x-poker version 2.69 loaded. | $iif($version < 6.03,echo -at mIRC 6.03 or above might be needed for the game to function properly.)
  echo -at Type /g5x-poker to start the game. | linesep
}
on *:unload: { linesep | unset %g5xset.* | echo -at g5x-poker version 2.69 unloaded. | echo -at All g5x-poker variables have been cleared, thanks for playing this game ;) . | linesep }

alias g5x-poker {
  window -c @g5x-poker | window -dphk0Ca +nt @g5x-poker -1 -1 750 500 " $+ $scriptdirtemp\spade.ico $+ "
  renwin @g5x-poker @g5x-poker - Welcome to g5x-poker game, enjoy the game!
  var %a = 1, %b = 310, %c = 0, %d2 = drawtext -brp @g5x-poker $g5x.ctxt2 Tahoma -8, $&
    %d3 = drawtext -brp @g5x-poker $g5x.ctxt3 Tahoma -8, %d4 = drawtext -brp @g5x-poker $g5x.ctxt4 Tahoma -8

  drawrect -rf @g5x-poker $rgb(50,100,50) 1 0 0 750 500 | drawrect -rf @g5x-poker $rgb(30,80,30) 1 365 62 500 400
  drawrect -r @g5x-poker $rgb(30,80,30) 1 15 44 332 418 | drawrect -r @g5x-poker $rgb(50,100,50) 1 387 230 333 20
  drawrect -rf @g5x-poker $rgb(40,90,40) 1 365 266 355 10
  drawtext -brp @g5x-poker $g5x.ctxt Tahoma -8 532 15 g5x-poker version 2.69 by gorefiend.
  drawtext -brp @g5x-poker $g5x.ctxt Tahoma -9 532 15 g
  drawline -r @g5x-poker $rgb(200,200,200) 1 0 28 536 28 | drawline -r @g5x-poker $rgb(135,135,135) 1 539 28 718 28
  while (%c <= 345) { drawline -r @g5x-poker $rgb(50,100,50) 1 $calc(%c *1.05) 28 $calc(%c +17) 28 | inc %c 12 }
  while (%a <= 5) { drawrect -r @g5x-poker $rgb(50,100,50) 1 $calc((%a *55)+395) 201 47 17 | inc %a }

  %d2 368 40 game status: Ready to start a new game! | %d3 390 70 total winnings: $ 10050 | %d3 390 202 place bet:
  %d3 467 202 $5 | %d3 518 202 $10 | %d3 574 202 $15 | %d3 629 202 $25 | %d3 683 202 $50 | %d3 645 232 DEAL Now!

  %d4 390 290 grade reward: | %d4 390 310 grade 1 » $ 2000 | %d4 390 325 grade 2 » $ 4000 | %d4 390 340 grade 3 » $ 7000 | %d4 390 355 grade 4 » $ 10000

  %d4 390 380 grade reached: | g5x.grade 0 | g5x.gradepic 0

  %d4 515 290 hand: | %d4 515 310 royal flush | %d4 515 325 straight flush | %d4 515 340 four of a kind | %d4 515 355 full house | %d4 515 370 flush | %d4 515 385 straight | %d4 515 400 three of a kind
  %d4 515 415 two pairs | %d4 515 430 jacks or better

  %d4 610 290 return: | %d4 610 310 1 : 500 | %d4 610 325 1 : 250 | %d4 610 340 1 : 100 | %d4 610 355 1 : 50 | %d4 610 370 1 : 20
  %d4 610 385 1 : 15 | %d4 610 400 1 : 4 | %d4 610 415 1 : 3 | %d4 610 430 1 : 2

  while (%b <= 430) { drawtext -brp @g5x-poker $g5x.ctxt5 Tahoma -8 663 %b more info... | inc %b 15 }
  set %g5xset.snd on | set %g5xset.snd2 on | set %g5xset.dealturn 1 | set %g5xset.betsum 10050 | set %g5xset.strip off | unset %g5xset.oppo | g5x.cbetsel 2 | g5x.flipback
}

menu @g5x-poker {
  sclick: {
    ; cards functions
    if ($inrect($mouse.x,$mouse.y,388,95,60,92)) {
      if (%g5xset.dealturn == 2) { if (%g5xset.flipped1 == no) { g5x.repcrd 1 back.jpg | set %g5xset.flipped1 yes } | else { g5x.repcrd 1 %g5xset.flipread1 | set %g5xset.flipped1 no } | g5x.snd }
    }
    elseif ($inrect($mouse.x,$mouse.y,456,95,60,92)) {
      if (%g5xset.dealturn == 2) { if (%g5xset.flipped2 == no) { g5x.repcrd 2 back.jpg | set %g5xset.flipped2 yes } | else { g5x.repcrd 2 %g5xset.flipread2 | set %g5xset.flipped2 no } | g5x.snd }
    }
    elseif ($inrect($mouse.x,$mouse.y,524,95,60,92)) {
      if (%g5xset.dealturn == 2) { if (%g5xset.flipped3 == no) { g5x.repcrd 3 back.jpg | set %g5xset.flipped3 yes } | else { g5x.repcrd 3 %g5xset.flipread3 | set %g5xset.flipped3 no } | g5x.snd }
    }
    elseif ($inrect($mouse.x,$mouse.y,592,95,60,92)) {
      if (%g5xset.dealturn == 2) { if (%g5xset.flipped4 == no) { g5x.repcrd 4 back.jpg | set %g5xset.flipped4 yes } | else { g5x.repcrd 4 %g5xset.flipread4 | set %g5xset.flipped4 no } | g5x.snd }
    }
    elseif ($inrect($mouse.x,$mouse.y,660,95,60,92)) {
      if (%g5xset.dealturn == 2) { if (%g5xset.flipped5 == no) { g5x.repcrd 5 back.jpg | set %g5xset.flipped5 yes } | else { g5x.repcrd 5 %g5xset.flipread5 | set %g5xset.flipped5 no } | g5x.snd }
    }

    ; bet buttons functions
    elseif ($inrect($mouse.x,$mouse.y,451,202,45,15)) { g5x.cbet | g5x.cbetsel 1 } | elseif ($inrect($mouse.x,$mouse.y,506,202,45,15)) { g5x.cbet | g5x.cbetsel 2 }
    elseif ($inrect($mouse.x,$mouse.y,561,202,45,15)) { g5x.cbet | g5x.cbetsel 3 } | elseif ($inrect($mouse.x,$mouse.y,616,202,45,15)) { g5x.cbet | g5x.cbetsel 4 }
    elseif ($inrect($mouse.x,$mouse.y,671,202,45,15)) { g5x.cbet | g5x.cbetsel 5 }

    ; deal button functions
    elseif ($inrect($mouse.x,$mouse.y,388,231,331,18)) { g5x.cdealsel | g5x.deal }

    ; more info functions
    elseif ($inrect($mouse.x,$mouse.y,660,331,60,111)) { url -an " $+ $scriptdirreadme.html#pokerrules $+ " }
  }
  uclick: { if ($inrect($mouse.x,$mouse.y,388,231,331,18)) { g5x.cdeal } | else g5x.cdeal }
  leave: { g5x.cdeal }

  ; drop-down menu
  Start a &New Game: g5x-poker
  -
  &Game Options: g5x.dpoker
  &Sounds Options
  .&Enable all Sounds : { set %g5xset.snd on | set %g5xset.snd2 on }
  .&Disable all Sounds *greatly speeds up game* : { set %g5xset.snd off | set %g5xset.snd2 off }
  .-
  .&Win Sound is $iif(%g5xset.snd2 == on,Enabled [Disable sound],Disabled [Enable sound]) : { $iif(%g5xset.snd2 == on,set %g5xset.snd2 off,set %g5xset.snd2 on) }
  .&Card Flip Sound is $iif(%g5xset.snd == on,Enabled [Disable sound],Disabled [Enable sound]) : { $iif(%g5xset.snd == on,set %g5xset.snd off,set %g5xset.snd on) }
  Set Game &Mode
  .Strip Poker mode is $iif(%g5xset.strip == on,ON [turn &OFF],OFF [turn &ON]) : { $iif(%g5xset.strip == on,set %g5xset.strip off,set %g5xset.strip on) }
  -
  &Picture Manager : g5x.picman
  -
  &Help
  .Info about the &Poker Rules: { url -an " $+ $scriptdirreadme.html#pokerrules $+ " }
  .-
  .Info about the &Game: { url -an " $+ $scriptdirreadme.html#game $+ " }
  .Info about the Game version &History: { url -an " $+ $scriptdirreadme.html#version $+ " }
}

alias -l g5x.deal {
  var %a = 1, %rt = " $+ $scriptdirtemp\temp.txt $+ "
  if (%g5xset.dealturn == 1) {
    set %g5xset.flipped1 no | set %g5xset.flipped2 no | set %g5xset.flipped3 no | set %g5xset.flipped4 no | set %g5xset.flipped5 no
    g5x.create | g5x.flipback | g5x.status Ready to start a new game!
    while (%a <= 5) {
      var %num = $r(1,$lines(%rt)), %read = $read(%rt,%num) | set %g5xset.flipread $+ %a %read | g5x.repcrd %a %read | g5x.snd | write -dl $+ %num %rt | inc %a
    }
    set %g5xset.betsum $calc(%g5xset.betsum - %g5xset.bet) | g5x.money %g5xset.betsum
    set %g5xset.beturn %g5xset.bet | set %g5xset.dealturn 2 | g5x.status Select any cards you want to drop...
  }
  else {
    if ((%g5xset.flipped1 == no) && (%g5xset.flipped2 == no) && (%g5xset.flipped3 == no) && (%g5xset.flipped4 == no) && (%g5xset.flipped5 == no)) { g5x.dealcalc }
    else {
      if (%g5xset.flipped1 == yes) { var %num = $r(1,$lines(%rt)), %read = $read(%rt,%num) | set %g5xset.flipread1 %read | g5x.repcrd 1 %read | g5x.snd | write -dl $+ %num %rt }
      if (%g5xset.flipped2 == yes) { var %num = $r(1,$lines(%rt)), %read = $read(%rt,%num) | set %g5xset.flipread2 %read | g5x.repcrd 2 %read | g5x.snd | write -dl $+ %num %rt }
      if (%g5xset.flipped3 == yes) { var %num = $r(1,$lines(%rt)), %read = $read(%rt,%num) | set %g5xset.flipread3 %read | g5x.repcrd 3 %read | g5x.snd | write -dl $+ %num %rt }
      if (%g5xset.flipped4 == yes) { var %num = $r(1,$lines(%rt)), %read = $read(%rt,%num) | set %g5xset.flipread4 %read | g5x.repcrd 4 %read | g5x.snd | write -dl $+ %num %rt }
      if (%g5xset.flipped5 == yes) { var %num = $r(1,$lines(%rt)), %read = $read(%rt,%num) | set %g5xset.flipread5 %read | g5x.repcrd 5 %read | g5x.snd | write -dl $+ %num %rt }
      g5x.dealcalc
    }
    set %g5xset.dealturn 1
  }
}
alias -l g5x.dealcalc {
  var %cvr1 = $right($remove(%g5xset.flipread1,.jpg),1), %check
  var %card1 = $remove(%g5xset.flipread1,.jpg), %card2 = $remove(%g5xset.flipread2,.jpg), $&
    %card3 = $remove(%g5xset.flipread3,.jpg), %card4 = $remove(%g5xset.flipread4,.jpg), %card5 = $remove(%g5xset.flipread5,.jpg)
  var %rankcard1 = $gettok(%card1,1,45), %rankcard2 = $gettok(%card2,1,45), %rankcard3 = $gettok(%card3,1,45), $&
    %rankcard4 = $gettok(%card4,1,45), %rankcard5 = $gettok(%card5,1,45)
  var %plainum = %rankcard1 %rankcard2 %rankcard3 %rankcard4 %rankcard5
  var %pnum = $matchtok(%plainum,%rankcard1,0,32) $matchtok(%plainum,%rankcard2,0,32) $&
    $matchtok(%plainum,%rankcard3,0,32) $matchtok(%plainum,%rankcard4,0,32) $matchtok(%plainum,%rankcard5,0,32)
  var %nsort = $sorttok(%plainum,32,nr)

  ; cards of the same suit
  if ((%cvr1 isin %card1) && (%cvr1 isin %card2) && (%cvr1 isin %card3) && (%cvr1 isin %card4) && (%cvr1 isin %card5)) {

    ; check for royal flush
    if (%nsort == Q K J A 10) { var %check = royalflush }

    ; check for straight flush
    elseif (%nsort == Q K J 10 9) { var %check = straightflush }
    elseif (%nsort == Q J 10 9 8) { var %check = straightflush }
    elseif (%nsort == J 10 9 8 7) { var %check = straightflush }
    elseif (%nsort == 10 9 8 7 6) { var %check = straightflush }
    elseif (%nsort == 9 8 7 6 5) { var %check = straightflush }
    elseif (%nsort == 8 7 6 5 4) { var %check = straightflush }
    elseif (%nsort == 7 6 5 4 3) { var %check = straightflush }
    elseif (%nsort == 6 5 4 3 2) { var %check = straightflush }
    elseif (%nsort == A 5 4 3 2) { var %check = straightflush }

    ; check for flush
    else { var %check = flush }
  }

  ; cards of the different suit
  else {
    ; check for four of a kind
    if (($matchtok(%plainum,%rankcard1,0,32) == 4) || ($matchtok(%plainum,%rankcard2,0,32) == 4)) { var %check = fourofakind }

    elseif (($matchtok(%plainum,%rankcard1,0,32) == 3) || ($matchtok(%plainum,%rankcard2,0,32) == 3) || ($matchtok(%plainum,%rankcard3,0,32) == 3)) {

      ; check for full house
      if (($matchtok(%plainum,%rankcard1,0,32) == 2) || ($matchtok(%plainum,%rankcard2,0,32) == 2) || ($matchtok(%plainum,%rankcard3,0,32) == 2) || ($matchtok(%plainum,%rankcard4,0,32) == 2)) {
        var %check = fullhouse
      }

      ; check for three of a kind
      else { var %check = threeofakind }
    }

    ; check for straight
    elseif (%nsort == Q K J A 10) { var %check = straight }
    elseif (%nsort == Q K J 10 9) { var %check = straight }
    elseif (%nsort == Q J 10 9 8) { var %check = straight }
    elseif (%nsort == J 10 9 8 7) { var %check = straight }
    elseif (%nsort == 10 9 8 7 6) { var %check = straight }
    elseif (%nsort == 9 8 7 6 5) { var %check = straight }
    elseif (%nsort == 8 7 6 5 4) { var %check = straight }
    elseif (%nsort == 7 6 5 4 3) { var %check = straight }
    elseif (%nsort == 6 5 4 3 2) { var %check = straight }
    elseif (%nsort == A 5 4 3 2) { var %check = straight }

    ; check for two pair
    elseif ($matchtok(%pnum,2,0,32) == 4) { var %check = twopair }

    ; check for jacks or better
    else {
      if (($matchtok(%plainum,A,0,32) == 2) || ($matchtok(%plainum,K,0,32) == 2) || ($matchtok(%plainum,Q,0,32) == 2) || ($matchtok(%plainum,J,0,32) == 2)) { var %check = jacksorbetter }
    }
  }

  ; ifcheck for winnings
  if (%check) {
    if (%check == royalflush) { var %cashe = $calc(%g5xset.beturn *500) | g5x.status You won a Royal flush! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == straightflush) { var %cashe = $calc(%g5xset.beturn *250) | g5x.status You won a Straight flush! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == fourofakind) { var %cashe = $calc(%g5xset.beturn *100) | g5x.status You won Four of a kind! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == fullhouse) { var %cashe = $calc(%g5xset.beturn *50) | g5x.status You won a Full house! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == flush) { var %cashe = $calc(%g5xset.beturn *20) | g5x.status You won a Flush! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == straight) { var %cashe = $calc(%g5xset.beturn *15) | g5x.status You won a Straight! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == threeofakind) { var %cashe = $calc(%g5xset.beturn *4) | g5x.status You won Three of a kind! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == twopair) { var %cashe = $calc(%g5xset.beturn *3) | g5x.status You won Two pairs! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    elseif (%check == jacksorbetter) { var %cashe = $calc(%g5xset.beturn *2) | g5x.status You won Jacks or better! $ %cashe | set %g5xset.betsum $calc(%g5xset.betsum + %cashe) | g5x.money %g5xset.betsum }
    g5x.snd2
  }
  else { g5x.status You won nothing! }

  ; ifcheck for grading
  if (%g5xset.betsum < 2000) { g5x.grade 0 | g5x.gradepic 0 | g5x.ifcheck 0 }
  elseif ((%g5xset.betsum >= 2000) && (%g5xset.betsum < 4000)) { g5x.grade 1 | g5x.gradepic 1 | g5x.ifcheck 1 }
  elseif ((%g5xset.betsum >= 4000) && (%g5xset.betsum < 7000)) { g5x.grade 2 | g5x.gradepic 2 | g5x.ifcheck 2 }
  elseif ((%g5xset.betsum >= 7000) && (%g5xset.betsum < 10000)) { g5x.grade 3 | g5x.gradepic 3 | g5x.ifcheck 3 }
  elseif (%g5xset.betsum >= 10000) { g5x.grade 4 | g5x.gradepic 4 | g5x.ifcheck 4 }
}
alias -l g5x.ifcheck {
  var %xip = " $+ $scriptdirdownloaded\index.ini $+ "
  if ((%g5xset.strip == on) && (%g5xset.oppo) && ($ini(%xip,%g5xset.oppo) != 0)) {
    var %xp = " $+ $scriptdirdownloaded\ $+ $replace($nopath($readini(%xip,%g5xset.oppo,$1)),.g5x,.jpg) $+ "
    if (!$exists(%xp)) { g5x.down $readini(%xip,%g5xset.oppo,$1) | g5x.msg Downloading picture $1 , please wait... }
    elseif (%g5xset.xp != $nopath(%xp)) { set %g5xset.xp $nopath(%xp) | g5x.loadpic %g5xset.xp }
  }
}
alias -l g5x.create { .copy -o " $+ $scriptdirimages\do-not-edit.txt $+ " " $+ $scriptdirtemp\temp.txt $+ " }
alias -l g5x.flipback { var %a = 1 | while (%a <= 5) { drawpic -c @g5x-poker $calc((%a *68)+320) 95 " $+ $scriptdirimages\back.jpg $+ " | g5x.snd | inc %a } }
alias -l g5x.status { drawrect -rf @g5x-poker $rgb(50,100,50) 1 362 38 500 20 | drawtext -brp @g5x-poker $g5x.ctxt2 Tahoma -8 368 40 game status: $1- }
alias -l g5x.money { drawrect -rf @g5x-poker $rgb(30,80,30) 1 381 67 500 20 | drawtext -brp @g5x-poker $g5x.ctxt3 Tahoma -8 390 70 total winnings: $ $1- }
alias -l g5x.cbet { var %d = drawreplace -r @g5x-poker $rgb(50,100,50) $rgb(30,80,30) | %d 451 202 45 15 | %d 506 202 45 15 | %d 561 202 45 15 | %d 616 202 45 15 | %d 671 202 45 15 }
alias -l g5x.cbetsel {
  var %d = drawreplace -r @g5x-poker $rgb(30,80,30) $rgb(50,100,50) | if ($1 == 1) { %d 451 202 45 15 | set %g5xset.bet 5 }
  elseif ($1 == 2) { %d 506 202 45 15 | set %g5xset.bet 10 } | elseif ($1 == 3) { %d 561 202 45 15 | set %g5xset.bet 15 }
  elseif ($1 == 4) { %d 616 202 45 15 | set %g5xset.bet 25 } | else { %d 671 202 45 15 | set %g5xset.bet 50 }
}
alias -l g5x.grade { drawtext -brp @g5x-poker $g5x.ctxt5 Tahoma -8 390 395 » grade $1 }
alias -l g5x.gradepic { drawtext -brp @g5x-poker $g5x.ctxt5 Tahoma -8 390 410 » reward picture $1 }
alias -l g5x.loadpic { drawpic -c @g5x-poker 16 45 " $+ $scriptdirdownloaded\ $+ $1 $+ " }
alias -l g5x.dec { .rename %g5xset.openfile $replace(%g5xset.openfile,.g5x,.jpg) | bwrite $replace(%g5xset.openfile,.g5x,.jpg) 1 Øÿà }
alias -l g5x.msg { drawrect -rf @g5x-poker $rgb(50,50,50) 1 17 438 328 22 | drawtext -brp @g5x-poker $rgb(140,150,140) $rgb(50,50,50) Tahoma -8 24 442  $1- }
alias -l g5x.ljpg { g5x.dec | g5x.loadpic $replace($nopath(%g5xset.openfile),.g5x,.jpg) }
alias -l g5x.cdeal { drawreplace -r @g5x-poker $rgb(25,75,25) $rgb(30,80,30) 388 231 331 18 }
alias -l g5x.cdealsel { drawreplace -r @g5x-poker $rgb(30,80,30) $rgb(25,75,25) 388 231 331 18 }
alias -l g5x.ctxt { return $rgb(200,200,200) $rgb(50,100,50) }
alias -l g5x.ctxt2 { return $rgb(180,180,180) $rgb(50,100,50) }
alias -l g5x.ctxt3 { return $rgb(180,180,180) $rgb(30,80,30) }
alias -l g5x.ctxt4 { return $rgb(140,150,140) $rgb(30,80,30) }
alias -l g5x.ctxt5 { return $rgb(164,120,73) $rgb(30,80,30) }
alias -l g5x.snd { $iif(%g5xset.snd == on,.splay " $+ $scriptdirtemp\flip.wav $+ ") }
alias -l g5x.snd2 { $iif(%g5xset.snd2 == on,.splay " $+ $scriptdirtemp\win.wav $+ ") }
alias -l g5x.repcrd {
  if ($1 == 1) { drawpic -c @g5x-poker 388 95 " $+ $scriptdirimages\ $+ $2 $+ " } | elseif ($1 == 2) { drawpic -c @g5x-poker 456 95 " $+ $scriptdirimages\ $+ $2 $+ " }
  elseif ($1 == 3) { drawpic -c @g5x-poker 524 95 " $+ $scriptdirimages\ $+ $2 $+ " } | elseif ($1 == 4) { drawpic -c @g5x-poker 592 95 " $+ $scriptdirimages\ $+ $2 $+ " }
  else { drawpic -c @g5x-poker 660 95 " $+ $scriptdirimages\ $+ $2 $+ " }
}
alias -l g5x.down { set %g5xset.downdomain $gettok($1-,2,47) | set %g5xset.downpath $nofile($gettok($1-,3-,47)) | set %g5xset.downfile $nopath($1-) | sockopen g5x.down %g5xset.downdomain 80 }
on *:sockopen:g5x.down: {
  if ($sockerr > 0) { g5x.msg Unable to connect... please get connected to Internet. | sockclose g5x.down | return }
  set %g5xset.down 0 | sockwrite -n $sockname GET $+(/ $+ %g5xset.downpath,%g5xset.downfile) HTTP/1.1
  sockwrite -n $sockname Accept-Language: en-us | sockwrite -n $sockname Connection: keep-alive
  sockwrite -n $sockname User-Agent: Mozilla/?? | sockwrite -n $sockname Host: %g5xset.downdomain | sockwrite $sockname $crlf
}
on *:sockread:g5x.down: {
  set %g5xset.openfile " $+ $scriptdirdownloaded\ $+ %g5xset.downfile $+ "
  if (%g5xset.down == 0) { sockread %data | if ($len(%data) < 4) { inc %g5xset.down } } | elseif (%g5xset.down == 1) { sockread 8192 &bin | bwrite %g5xset.openfile -1 &bin }
}
on *:sockclose:g5x.down: {
  if (index.ini isin %g5xset.openfile) {
    if ($dialog(g5xpoker)) {
      var %a = 1 | did -r g5xpoker 1
      while (%a <= $ini(" $+ $scriptdirdownloaded\index.ini $+ ",0)) { did -a g5xpoker 1 $ini(" $+ $scriptdirdownloaded\index.ini $+ ",%a) | inc %a } | did -e g5xpoker 3 | did -c g5xpoker 1 1
      g5x.msg Data Received , please select a Girl for play now!
    }
  }
  elseif (.g5x isin %g5xset.openfile) { g5x.ljpg }
}
on *:dialog:g5xpoker:*:*: {
  if ($devent == init) { $iif(%g5xset.strip == off,did -b g5xpoker 2) }
  if ($devent == sclick) {
    if ($did == 2) { if (%g5xset.strip == on) { .remove " $+ $scriptdirdownloaded\index.ini $+ " | g5x.down http://www.ifrance.com/gorefiend/g5x-poker/index.ini } | g5x.msg Checking for New Girls , please wait... }
    if ($did == 3) { if ($did(g5xpoker,1,1)) { set %g5xset.oppo $did(g5xpoker,1,$did(g5xpoker,1).sel) | set %g5xset.betsum 100 | g5x.msg You have selected %g5xset.oppo , please Deal Now! } }
  }
}
alias -l g5x.dpoker { if ($dialog(g5xpoker)) { dialog -ve g5xpoker g5xpoker } | else { dialog -mdo g5xpoker g5xpoker } }
dialog g5xpoker {
  title "g5x-poker Game Options."
  size -1 -1 150 40
  option dbu
  icon $scriptdirtemp\spade.ico , 0
  list 1, 7 8 67 26, size
  button "&Check for New Girls", 2, 78 9 65 11
  button "&Select for play", 3, 78 23 65 10, disable flat
  box "", 4, 2 0 146 38
}
dialog g5xpicman {
  title "g5x-poker Picture Manager."
  size -1 -1 135 59
  option dbu
  icon $scriptdirtemp\spade.ico , 0
  list 1, 7 8 67 45, sort size
  button "&View picture", 2, 78 9 50 11, disable
  button "&Delete picture", 3, 78 23 50 10, disable flat
  box "", 4, 2 0 131 57
  button "Delete &All", 5, 78 43 50 10, disable flat
}
alias -l g5x.picman { if ($dialog(g5xpicman)) { dialog -ve g5xpicman g5xpicman } | else { dialog -mdo g5xpicman g5xpicman } }
on *:dialog:g5xpicman:*:*: {
  if ($devent == init) { var %f = $findfile(" $+ $scriptdirdownloaded $+ ",*.jpg,0,1,did -a g5xpicman 1 $nopath($1-)) | if (%f != 0) { did -e g5xpicman 2 | did -e g5xpicman 3 | did -e g5xpicman 5 | did -c g5xpicman 1 1 } }
  if ($devent == sclick) {
    var %x = $did(g5xpicman,1,$did(g5xpicman,1).sel)
    if ($did == 2) {
      window -c @g5x-pic | window -dphk0Ca +nt @g5x-pic -1 -1 330 416 " $+ $scriptdirtemp\spade.ico $+ " | renwin @g5x-pic @g5x-pic - Viewing ' $+ %x $+ ' | drawpic @g5x-pic 0 0 " $+ $scriptdirdownloaded\ $+ %x $+ "
    }
    if ($did == 3) { .remove " $+ $scriptdirdownloaded\ $+ %x $+ " | did -d g5xpicman 1 $did(g5xpicman,1).sel | did -c g5xpicman 1 1 }
    if ($did == 5) { var %f = $findfile(" $+ $scriptdirdownloaded $+ ",*.jpg,0,1,.remove " $+ $1- $+ ") | did -r g5xpicman 1 }
  }
}
on *:keydown:@g5x-poker:*: {
  if ($keyval == 27) { window -n @g5x-poker } | elseif ($keyval == 65) { set %g5xset.strip on } | elseif ($keyval == 67) { window -c @g5x-poker }
  elseif ($keyval == 78) { g5x-poker } | elseif ($keyval == 79) { g5x.dpoker } | elseif ($keyval == 90) { set %g5xset.strip off } | elseif ($keyval == 80) { g5x.picman }
  elseif ($keyval == 68) { set %g5xset.snd off | set %g5xset.snd2 off } | elseif ($keyval == 69) { set %g5xset.snd on | set %g5xset.snd2 on }
  elseif ($keyval == 70) { $iif(%g5xset.snd == on,set %g5xset.snd off,set %g5xset.snd on) } | elseif ($keyval == 87) { $iif(%g5xset.snd2 == on,set %g5xset.snd2 off,set %g5xset.snd2 on) }
}
menu menubar,channel,query,status {
  MIRC Games
  .poker-g&5x
  ..Load g&5x-poker:g5x-poker
  ..-
  ..Info about the &Poker Rules: { url -an " $+ $scriptdirreadme.html#pokerrules $+ " }
  ..Info about the &Game: { url -an " $+ $scriptdirreadme.html#game $+ " }
  ..Info about the Game version &History: { url -an " $+ $scriptdirreadme.html#version $+ " }
  -
}

;
