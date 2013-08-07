on @*:TEXT:*:#tsz:123-seeya $nick $chan $1-
on @*:ACTION:*:#tsz:123-seeya $nick $chan $1- 
on @*:NOTICE:*:#tsz:123-seeya $nick $chan $1-

;unsorted aliases
alias cenwin return $int($calc(($window(-3).w - $1) / 2)) $int($calc(($window(-3).h - $2) / 2)) $1 $2

alias mice return $inrect($mouse.x, $mouse.y, $1, $2, $3, $4)
alias doit {
  writeini $mircdirsystem\settings.ini viz Nick.Ops $nckc(o) $2 $nick($2, $1)
  writeini $mircdirsystem\settings.ini viz Nick.HalfOps $nckc(h) $2 $nick($2, $1)
  writeini $mircdirsystem\settings.ini viz Nick.Voices $nckc(v) $2 $nick($2, $1)
  writeini $mircdirsystem\settings.ini viz Nick.users $nckc(n) $2 $nick($2, $1)
}

alias _doubleclick {
  var %plopup = $gettok(JoinChan ListUsers Nick Reconnect Usermode!Whois DCCChat Ping Clear!OpNotice Ch.Central NewTopic Clear!Whois Query DCCChat QuickKick QuickBan!Whois Query DCCChat Ping,$1,33)
  if ($_cfgi(dc. [ $+ [ $1 ] ] ) isnum) {
    if (($mouse.key & 2) || ($mouse.key & 4)) _qp-go 104 _doubleclick² $+ $1 $+ $2 $+ $3 %plopup 1.
    else _doubleclick² $1 $2 $3 $_cfgi(dc. [ $+ [ $1 ] ] ) 1 0.
  }
  else _qp-go 104 _doubleclick² $+ $1 $+ $2 $+ $3 %plopup 
}
alias _doubleclick² {
  if ($4 == $null) return
  if (($1 == 2) || ($1 == 5)) var %bit = 4
  else var %bit = 5
  if (%_plopup. [ $+ [ %bit ] ] == 1) {
    var %plopup = $gettok(JoinChan ListUsers Nick Reconnect Usermode!Whois DCCChat Ping Clear!OpNotice Ch.Central New ClearTopic!Whois Query DCCChat QuickKick QuickBan!Whois Query DCCChat Ping,$1,33)
    _cfgw dc. $+ $1 $4
    return
  }
  if (%_plopup. [ $+ [ %bit ] ] == 0) _cfgw dc. $+ $1
  goto $1 $+ $4
  :20 | :40 | :50 | whois $3 | return
  :41 | :51 | query $3 | return
  :21 | :42 | :52 | dcc chat $3 | return
  :43 | kick $2 $3 $logo(*uNF*) | return
  :44 | ban $2 $3 3 | kick $2 $3 $logo(*w00t*) | return
  :22 | :53 | if (=* iswm $2) dcp $3 | else ping $3 | return
  :30 | onotice $active $b(@notice) $$?"op notice?" | return 
  :31 | if ($5) channel | else { _getcc | set -u1 %.olde $editbox($3) | editbox -n $3 %.cmdchar $+ channel | .timer -o 1 0 editbox $3 % $+ .olde } | return
  :32 | topic $3 $$?"topic" | return
  :23 | :33 | if (=* iswm $2) clear Chat $3 | else clear $3 | return
  :10 | j $$?"channel to join" | return
  :11 | lusers | return
  :12 | nick $$?"new nick" | return
  :13 | server $$?"server to connect to" | return
  :14 | tsz_option.umode | return
}
alias _getcc set -u1 %.cmdchar $readini -n $mircini text commandchar
alias _cfgw if ($2 != $null) writeini config\ $+ %!user $+ \config.ini cfg $1 $2- | else remini config\ $+ %!user $+ \config.ini cfg $$1
alias _cfgi return $readini -n config\ $+ %!user $+ \config.ini cfg $1
alias _qp-go {
  .timer.qpfin off
  window -c @¶
  window -fphkdo +fL @¶ $calc($mouse.dx - ($1 / 2)) $calc($mouse.dy - 1) $1 $calc($numtok($3-,32) * 20) @quikpck
  drawrect -nfr @¶ $rgb(face) 1 0 0 $1 200
  var %text,%y = 0 | :loopy
  %text = $_p2s($gettok($3-,$calc(%y + 1),32))
  if ($left(%text,1) isin 01) {
    %_plopup. [ $+ [ %y ] ] = $ifmatch
    drawrect -nr @¶ $rgb(hilight) 1 4 $calc(20 * %y + 4) 12 12
    drawline -nr @¶ $rgb(shadow) 1 4 $calc(20 * %y + 15) 4 $calc(20 * %y + 4) 15 $calc(20 * %y + 4)
    if ($left(%text,1) == 1) drawtext -nro @¶ $rgb(text) arial 21 5 $calc(20 * %y - 1) ×
    %text = $right(%text,-1)
  }
  drawtext -nr @¶ $rgb(text) "ms sans serif" 14 24 $calc(%y * 20 + 3) %text
  inc %y | if (%y < $numtok($3-,32)) goto loopy
  %_qpgo = $2
  %.skipit = 1
  .timer.sk@¶ -mo 1 0 unset % $+ .skipit
  drawdot @¶
  window -a @¶
  .timer.qp@¶ -mo 0 100 if (($active != @¶) || ($appactive == $!false)) _qp-fin @¶
}
alias _p2s return $replace($1-,,$chr(32))
alias dcp {
  if ($1) {
    var %who
    if (=* iswm $1) %who = $right($1,-1) | else %who = $1
    if ($chat(%who) != %who) _error DCC ping (/dcp) is only for DCC chats.Use /ping for channels or queries.
    .msg = $+ %who PING 0 $+ $ticks
    dispr = $+ %who $:x $:s(DCC PING) sent to $:t(%who)
  }
  else {
    if (=* !iswm $active) _error DCC ping (/dcp) is only for DCC chats.Use /ping for channels or queries.
    .msg $active PING 0 $+ $ticks
    dispa $:x $:s(DCC PING) sent to $:t($remove($active,=))
  }
}
alias _qp-fin {
  var %do = $_p2s(%_qpgo) $2
  unset %_qpgo
  window -c @¶ | .timer.qp@¶ off
  .timer.qpfin -mo 1 0 unset %_plopup.*
  %do
}
menu @quikpck {
  sclick:_qcp $leftwin $mouse.x $mouse.y $mouse.key $window($leftwin).dw $window($leftwin).title
  mouse:if (%.skipit) return | _qcp $leftwin $mouse.x $mouse.y $mouse.key $window($leftwin).dw $window($leftwin).title
  dclick:_qcp $leftwin $mouse.x $mouse.y $mouse.key $window($leftwin).dw $window($leftwin).title
  uclick:{
    if ($numtok($window($leftwin).title,32) < 1) return
    _qcp $leftwin $mouse.x $mouse.y $mouse.key $window($leftwin).dw $window($leftwin).title
    if (%_plopup. [ $+ [ $result ] ] isnum) {
      %_plopup. [ $+ [ $result ] ] = 1 - $ifmatch
      if ($ifmatch) drawrect -fr $leftwin $rgb(face) 1 5 $calc(20 * $result + 5) 10 10
      else drawtext -ro $leftwin $rgb(text) arial 21 5 $calc(20 * $result - 1) ×
    }
    else _qp-fin $leftwin $gettok($window($leftwin).title,1,32)
  }
  leave:_qcp $leftwin -20 -20 $mouse.key $window($leftwin).dw $window($leftwin).title
}
alias -l _qcp {
  var %y = $int($calc($3 / 20))
  if (($6 != %y) || ($4 != $7)) {
    if ($6 != $null) {
      if ($7 & 1) {
        if (%_plopup. [ $+ [ $6 ] ] isnum) {
          drawrect -nr $1 $rgb(hilight) 1 4 $calc(20 * $6 + 4) 12 12
          drawline -nr $1 $rgb(shadow) 1 4 $calc(20 * $6 + 15) 4 $calc(20 * $6 + 4) 15 $calc(20 * $6 + 4)
        }
        drawscroll -n $1 -1 -1 16 $calc(20 * $6 + 1) $calc($5 - 17) 18
      }
      drawrect -nr $1 $rgb(face) 1 0 $calc(20 * $6) $5 20
    }
    if ($2 >= 0) {
      if ($4 & 1) {
        if (%_plopup. [ $+ [ %y ] ] isnum) drawrect -nr $1 $rgb(face) 1 4 $calc(20 * %y + 4) 12 12
        drawscroll -n $1 1 1 16 $calc(20 * %y + 1) $calc($5 - 17) 18
      }
      drawrect -nr $1 $rgb($iif($4 & 1,hilight,shadow)) 1 0 $calc(20 * %y) $5 20
      drawline -nr $1 $rgb($iif($4 & 1,shadow,hilight)) 1 0 $calc(20 * %y + 19) 0 $calc(20 * %y) $calc($5 - 1) $calc(20 * %y)
      titlebar $1 %y $4
    }
    else titlebar $1
    drawdot $1
  }
  return %y
}

