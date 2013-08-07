; mIRC-Hangman v1.0 by Darkie
; Simple hangman game

;:: events ::
on *:LOAD: { 
  echo 2 -s *** mIRC-Hangman loaded.  Type /hangman to play or right click and select mIRC-hangman -> Play *** 
  set %hangman-bg 0 | set %hangman-info 4 | set %hangman-text 1 | set %hangman-line 1
}
on *:KEYDOWN:@hangman:*: {
  var %c = $hget(hangman,word),%l = $keychar,%done
  if (%l isalpha) {
    if ($hget(hangman,playagain)) { 
      if (%l == y) hangman 
      else { window -c @hangman }
      return
    }
    var %d = $hget(hangman,word)
    while (%d) {
      var %c = $left(%d,1),%d = $right(%d,-1)
      if (%c == %l) { hadd hangman %l revealed | var %done = yes }
    }
    if (!%done) { hadd hangman %l wrong }
    var %d = $hget(hangman,word)
    while (%d) {
      var %c = $left(%d,1),%d = $right(%d,-1)
      if (%c == $chr(32)) { var %space = yes }
      elseif ($hget(hangman,%c) == revealed) { var %putup = %putup $+ %c | unset %space }
      else { var %putup = %putup $+ _ }
    }
    var %d = $hget(hangman,word)
    if ( %putup == %d ) { hadd -m hangman win 1 }
  }
}
on *:UNLOAD: { hfree -w hangman | unset %hangman-* | echo 2 -s *** Hangman unloaded.  Thanx for using my creations =) *** }

;:: aliases ::
alias hangman {
  hfree -w hangman
  window -podzk0 +tbLn @hangman 50 50 500 300
  while (!$hget(hangman,word)) { hadd -m hangman word $remove($read($scriptdirwords.dat),$chr(32)) }
  .timerupdhang -m 0 100 updhang
}
alias updhang {
  if (!$window(@hangman)) { timer $+ $ctimer off | return }
  clear -n @hangman
  drawrect -nf @hangman %hangman-bg 1 0 0 $window(@hangman).w $window(@hangman).h
  if ($hget(hangman,lose)) {
    drawtext -nf @hangman %hangman-info "Comic Sans MS" 36 216 157 You lose!
    drawtext -nf @hangman %hangman-text "Comic Sans MS" 18 216 197 Wanna play again?
    $hangline(1) | $hangline(2) | $hangline(3) | $hangline(4) | $hangline(5)
    var %putup = $hget(hangman,word)
    hadd -m hangman playagain $true
  }
  elseif ($hget(hangman,win)) {
    drawtext -nf @hangman %hangman-info "Comic Sans MS" 36 216 157 You win!
    drawtext -nf @hangman %hangman-text "Comic Sans MS" 18 216 197 Wanna play again?
    $hangline(1) | $hangline(2) | $hangline(3) | $hangline(4) | $hangline(5)
    var %d = $hget(hangman,word)
    while (%d) {
      var %c = $left(%d,1),%d = $right(%d,-1)
      var %putup = %putup %c
    }
    hadd -m hangman playagain $true
    var %nodrawhang = yes
  }
  else {
    var %d = $hget(hangman,word)
    while (%d) {
      var %c = $left(%d,1),%d = $right(%d,-1)
      if (%c == $chr(32)) { var %space = yes }
      elseif ($hget(hangman,%c) == revealed) { var %putup = %putup $+($iif(%space,$chr(32)),%c) | unset %space }
      else { var %putup = %putup _ }
    }
    var %i = 1,%wrong = 0
    while ($hget(hangman,%i).item) {
      var %c = $ifmatch
      if ($hget(hangman,%c) == wrong) { inc %wrong 1 | var %wrongl = $addtok(%wrongl,$chr(32) $+ %c,44) }
      if (%wrong) { $hangline(%wrong) }
      inc %i
    }
  }
  if (!%nodrawhang) {
    drawline -n @hangman %hangman-line 1 4 256 120 256
    drawline -n @hangman %hangman-line 1 18 256 18 50 120 50
    drawline -n @hangman %hangman-line 1 65 50 65 60
  }
  drawtext -nf @hangman %hangman-info "Comic Sans MS" 36 0 0 Hangman!
  drawtext -nf @hangman %hangman-text "Comic Sans MS" 24 200 50 %putup
  if (%wrongl) { drawtext -nf @hangman %hangman-text "Comic Sans MS" 24 190 120 %wrongl }
  drawpic @hangman
}
alias -l hangline {
  if ($1 == 1) { return drawrect -ne @hangman %hangman-line 1 40 60 50 50 }
  if ($1 == 2) { return drawline -n @hangman %hangman-line 1 65 110 65 200 }
  if ($1 == 3) { return drawline -n @hangman %hangman-line 1 65 200 32 250 }
  if ($1 == 4) { return drawline -n @hangman %hangman-line 1 65 200 98 250 }
  if ($1 == 5) { return drawline -n @hangman %hangman-line 1 30 139 100 139 }
  if ($1 == 6) { return hadd -m hangman lose 1 }
}
alias hangreveal {
  var %r
  var %d = $hget(hangman,word)
  while (%d) {
    var %c = $left(%d,1),%d = $right(%d,-1)
    if ($hget(hangman,%c) == revealed) { inc %r }
  }
  return %ro
}

;:: menus ::
menu status,menubar,channel,query {
  Games 
  .HangMan
  ..Play: hangman
  ..Edit word list: run notepad $scriptdirwords.dat
  ..Set colours: dialog -m hmcol hmcol
  ..Unload: unload -rs $script
}
dialog -l hmcol {
  title "Colours"
  size -1 -1 70 50
  option dbu

  text "Background", 1, 0 1 30 9
  text "Information", 2, 0 11 30 9
  text "Lines", 3, 0 21 30 9
  text "Text", 4, 0 31 30 9
  button "Ok", 5, 20 40 30 10, ok

  combo 6, 30 0 40 40, size vsbar drop
  combo 7, 30 10 40 40, size vsbar drop
  combo 8, 30 20 40 40, size vsbar drop
  combo 9, 30 30 40 40, size vsbar drop
}
on *:DIALOG:hmcol:*:*: {
  if ($devent == init) {
    var %d = 00 - White
    var %d = $addtok(%d,01 - Black,44)
    var %d = $addtok(%d,02 - Blue,44)
    var %d = $addtok(%d,03 - Green,44)
    var %d = $addtok(%d,04 - Red,44)
    var %d = $addtok(%d,05 - Brown,44)
    var %d = $addtok(%d,06 - Purple,44)
    var %d = $addtok(%d,07 - Orange,44)
    var %d = $addtok(%d,08 - Yellow,44)
    var %d = $addtok(%d,09 - Light Green,44)
    var %d = $addtok(%d,10 - Blue-Green,44)
    var %d = $addtok(%d,11 - Cyan,44)
    var %d = $addtok(%d,12 - Light Blue,44)
    var %d = $addtok(%d,13 - Pink,44)
    var %d = $addtok(%d,14 - Dark Grey,44)
    var %d = $addtok(%d,15 - Light Grey,44)
    didtok hmcol 6 44 %d
    didtok hmcol 7 44 %d
    didtok hmcol 8 44 %d
    didtok hmcol 9 44 %d

    did -c hmcol 6 $calc(%hangman-bg + 1)
    did -c hmcol 7 $calc(%hangman-info + 1)
    did -c hmcol 8 $calc(%hangman-line + 1)
    did -c hmcol 9 $calc(%hangman-text + 1)
  }
  if ($devent == sclick) && ($did isnum 5) {
    set %hangman-bg $calc($did(hmcol,6).sel - 1)
    set %hangman-info $calc($did(hmcol,7).sel - 1)
    set %hangman-line $calc($did(hmcol,8).sel - 1)
    set %hangman-text $calc($did(hmcol,9).sel - 1)
  }
}
