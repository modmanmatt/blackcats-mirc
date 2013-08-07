on 1:input:#: {
  if ((%window.services == on) && ($1 == /msg) && (($2 == ChanServ) || ($2 == BotServ) || ($2 == NickServ) || ($2 == OperServ) || ($2 == MemoServ))) {
    if ($window(@Services) == $null) window -es @Services 0 0 600 200
    echo @services $timestamp $bl $+  $+ %nick.colours.m $+ $nick $+  $+ $br $bl $+  $+ %nick.colours.m $+ $2 $+  $+ $br $$3-
    /.msg $2-
    halt
  }
  if ($sets(misc,nc) == on) {
    if ($1 == $chr(43)) {
      var %i = 1
      %isspace = 0
      while (%i <= $len($2-)) {
        %randcol = $rand(2,15)
        if (%randcol < 10) { %randcol = 0 $+ %randcol }
        if ($mid($2-,%i,1) == $chr(32)) { %isspace = 1 }
        if (%isspace == 1) {
          %text = %text  $+ %randcol $+ $mid($2-,%i,1)
          %isspace = 0
        }
        else { %text = %text $+  $+ %randcol $+ $mid($2-,%i,1) }
        inc %i
      }
      msg $active %text
      unset %i
      unset %text
      unset %randcol
      unset %isspace
      halt
    }

    %nick.special = $null
    if (($len($1) > 1) && ($right($1,1) == $chr(43))) { %nick.special = colour }
    if (($len($1) > 1) && ($right($1,1) == $chr(59))) { %nick.special = brackets }
    if (%nick.special != $null) {
      set %ncthemessage $2-
      if ($cnick($left($1,$calc($len($1) - 1))) ison $active) {
        ncmsgstyles
      }
    }
  }
}
alias cnick {
  set -u0 %foundnicks 0
  set -u0 %i 0
  :looping
  inc %i
  if ($nick($chan,%i) == $null) { goto end }
  if ($1 isin $nick(#,%i)) { inc %foundnicks | set -u0 %nicksfound $nick($chan,%i) }
  goto looping
  :end
  if (%foundnicks == 1) { set %ncnickname %nicksfound | return %nicksfound }
  if (%foundnicks > 1) {
    set %i 0
    set %foundnicks 0
    open.NCDialog
    did -b NCDialog 3
    :looping2
    inc %i
    if ($nick($chan,%i) == $null) { goto end2 }
    if ($1 isin $nick(#,%i)) { inc %foundnicks | did -a NCDialog 2 $nick($chan,%i) }
    goto looping2
    :end2
    did -e NCDialog 3
    did -c NCDialog 2 1
    halt
  }
  else {
    echo -a 5[4No Nicks Matching $1 $+ 5]
    halt
  }
}
alias -l CutHead {
  return $right($$1-,$calc($pos($$1-,=,1) * -1))
}
alias -l open.NCDialog {
  if ($dialog(NCDialog) != $null)  { dialog -v NCDialog NCDialog | echo -a 4Multiple dialog is in use, Please close it and try again! | halt }
  else { dialog -m NCDialog NCDialog }
}

dialog NCDialog {
  title "Multiple Nick Found Matching"
  size -1 -1 210 146
  text "Choose the nickname that you want to send the message to:", 1, 10 10 180 30
  list 2, 10 40 190 70
  button "&OK",3, 10 113 90 25, ok
  button "&Cancel",4, 110 113 90 25, cancel
}

alias ncmsgstyles {
  %text = $null
  if (%nick.special == colour) {
    %i = 1
    while (%i <= $len(%ncnickname)) {
      %text = %text $+  $+ $rand(2,15) $+ $mid(%ncnickname,%i,1)
      inc %i
    }
    msg $active  $+ %text $+  %ncthemessage
  }
  elseif (%nick.special == brackets) {
    msg $active  $+ $sets(viz,ADV.text) $+ %nick.message.brackets.left $+  $+ $sets(viz,ADV.info) $+ %ncnickname $+  $+ $sets(viz,ADV.text) $+ %nick.message.brackets.right $+  %ncthemessage
  }
  if (%foundnicks > 1) did -x NCDialog
  unset %text
  unset %ncnickname
  unset %nick.special
  unset %ncthemessage
  unset %foundnicks
  halt
}

on 1:dialog:NCDialog:sclick:3: {
  set %ncnickname $did(2,$did(2).sel)
  ncmsgstyles
}
on 1:dialog:NCDialog:dclick:2: {
  set %ncnickname $did(2,$did(2).sel)
  ncmsgstyles
}
