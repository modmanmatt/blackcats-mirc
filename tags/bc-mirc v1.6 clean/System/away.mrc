
alias aws {
  if $dialog(AwaySystem) == $null { /dialog -m Awaysystem Awaysystem }
}

dialog Awaysystem {
  title "Away System [ /aws ]"
  size -1 -1 121 133
  option dbu
  tab "Away", 4, 0 0 120 132
  button "Set Away", 1, 2 118 37 12, tab 4
  button "Set Back", 2, 41 118 37 12, tab 4
  button "Close", 3, 79 118 38 12, tab 4
  list 6, 5 37 94 35, tab 4 size
  box "Away Messages", 7, 2 16 116 60, tab 4
  button "+", 8, 101 25 14 12, tab 4
  button "-", 9, 101 39 14 12, tab 4
  edit "", 10, 5 25 94 11, tab 4
  box "Settings", 11, 2 78 116 38, tab 4
  text "Reason:", 12, 6 88 29 8, tab 4
  text "Nick suffix:", 13, 6 101 29 8, tab 4
  edit "", 14, 38 87 76 10, tab 4
  edit "", 15, 38 100 75 10, tab 4
  tab "Options", 5
  check "Enable public away message", 16, 3 18 113 10, tab 5
  radio "In active channel only", 17, 12 30 101 10, tab 5
  radio "In all channels", 18, 12 41 105 10, tab 5
  check "Remind away status when my nick is written", 19, 3 52 113 10, tab 5
  check "Set away after", 20, 3 64 48 10, tab 5
  edit "30", 21, 51 65 16 10, tab 5
  text "minutes of ideling.", 22, 69 66 48 8, tab 5
  check "Set back on input.", 23, 3 76 114 10, tab 5
  check "Enable quary logging", 24, 3 87 105 10, tab 5
  button "View Log", 25, 2 118 37 12, tab 5
  check "Enable Pager", 26, 3 99 102 10, tab 5
}

on *:dialog:AwaySystem:init:0:{
  if $readini($mircdirSystem\Settings.ini,aways,nicksuffix) != $null {
    /did -ra $dname 15 $readini($mircdirSystem\Settings.ini,aways,nicksuffix)
  }

  if $away == $true { /did -b $dname 1 }
  else { /did -b $dname 2 }

  var %i = 1
  while %i <= $ini($mircdirSystem\Settings.ini,aways,0) {
    if awaymessage isin $ini($mircdirSystem\Settings.ini,aways,%i) {
      /did -a $dname 6 $readini($mircdirSystem\Settings.ini,aways,$ini($mircdirSystem\Settings.ini,aways,%i))
    }
    inc %i
  }

  if $readini($mircdirSystem\Settings.ini,aways,public) == on {
    /did -c $dname 16
  }
  else {
    /did -b $dname 17
    /did -b $dname 18
  }
  if $readini($mircdirSystem\Settings.ini,aways,publics) == active {
    /did -c $dname 17
    /did -u $dname 18
  }
  elseif $readini($mircdirSystem\Settings.ini,aways,publics) == all {
    /did -u $dname 17
    /did -c $dname 18
  }

  if $readini($mircdirSystem\Settings.ini,aways,remind) == on {
    /did -c $dname 19
  }

  if $readini($mircdirSystem\Settings.ini,aways,idle) == on {
    /did -c $dname 20
  }
  else {
    /did -b $dname 21
  }
  if $readini($mircdirSystem\Settings.ini,aways,idlemin) != $null {
    /did -ra $dname 21 $readini($mircdirSystem\Settings.ini,aways,idlemin)
  }

  if $readini($mircdirSystem\Settings.ini,aways,input) == on {
    /did -c $dname 23
  }

  if $readini($mircdirSystem\Settings.ini,aways,logging) == on {
    /did -c $dname 24
  }

  if $readini($mircdirSystem\Settings.ini,aways,pager) == on {
    /did -c $dname 26
  }
}

on *:dialog:AwaySystem:sclick:*:{
  ;//-- "Set Away" button
  if $did == 1 {
    if $did($dname,14) != $null { /away_set $did($dname,14) }
    else { /away_set .... }
    /did -b $dname 1
    /did -e $dname 2
  }
  ;//-- "Set Back" button
  elseif $did == 2 {
    /away_back
    /did -e $dname 1
    /did -b $dname 2
  }
  ;//-- "Close" button
  elseif $did == 3 {
    /dialog -x AwaySystem
  }
  ;//-- "+" button
  elseif $did == 8 {
    if $did($dname,10) != $null {
      /did -a $dname 6 $did($dname,10)
      /did -r $dname 10
    }

    var %i = 1
    while %i <= $ini($mircdirSystem\Settings.ini,aways,0) {
      if awaymessage isin $ini($mircdirSystem\Settings.ini,aways,%i) {
        /remini $mircdirSystem\Settings.ini aways $ini($mircdirSystem\Settings.ini,aways,%i)
        dec %i
      }
      inc %i
    }

    var %i = 1
    while %i <= $did($dname,6).lines {
      /writeini $mircdirSystem\Settings.ini aways awaymessage $+ %i $did($dname,6,%i)
      inc %i
    }
  }
  ;//-- "-" button
  elseif $did == 9 {
    if $did($dname,6).seltext != $null {
      /did -d $dname 6 $did($dname,6).sel
    }

    var %i = 1
    while %i <= $ini($mircdirSystem\Settings.ini,aways,0) {
      if awaymessage isin $ini($mircdirSystem\Settings.ini,aways,%i) {
        /remini $mircdirSystem\Settings.ini aways $ini($mircdirSystem\Settings.ini,aways,%i)
        dec %i
      }
      inc %i
    }

    var %i = 1
    while %i <= $did($dname,6).lines {
      /writeini $mircdirSystem\Settings.ini aways awaymessage $+ %i $did($dname,6,%i)
      inc %i
    }
  }
  elseif $did == 6 {
    if $did($dname,6).seltext != $null {
      /did -ra $dname 14 $did($dname,6).seltext
    }
  }
  ;//-- "Enable public away message" checkbutton
  elseif $did == 16 {
    if $did($dname,16).state == 1 {
      /writeini $mircdirSystem\Settings.ini aways public on
      /did -e $dname 17
      /did -e $dname 18
      if $readini($mircdirSystem\Settings.ini,aways,publics) == active {
        /did -c $dname 17
        /did -u $dname 18
      }
      elseif $readini($mircdirSystem\Settings.ini,aways,publics) == all {
        /did -u $dname 17
        /did -c $dname 18
      }
    }
    else {
      /writeini $mircdirSystem\Settings.ini aways public off
      /did -b $dname 17
      /did -b $dname 18
    }
  }
  ;//-- "In active channel only" and "In all channels" radio buttons.
  elseif $did == 17 || $did == 18 {
    if $did($dname,17).state == 1 {
      /writeini $mircdirSystem\Settings.ini aways publics active
    }
    elseif $did($dname,18).state == 1 {
      /writeini $mircdirSystem\Settings.ini aways publics all
    }
  }
  ;// -- "Remind away status when my nick is written" check button
  elseif $did == 19 {
    if $did($dname,19).state == 1 {
      /writeini $mircdirSystem\Settings.ini aways remind on
    }
    else {
      /writeini $mircdirSystem\Settings.ini aways remind off
    }
  }
  ;//-- "Set away after xx minutes of ideling" check button
  elseif $did == 20 {
    if $did($dname,20).state == 1 {
      /did -e $dname 21
      /writeini $mircdirSystem\Settings.ini aways idle on
    }
    else {
      /did -b $dname 21
      /writeini $mircdirSystem\Settings.ini aways idle off
    }
  }
  ;//-- "Set back on input" check button
  elseif $did == 23 {
    if $did($dname,23).state == 1 { /writeini $mircdirSystem\Settings.ini aways input on }
    else { /writeini $mircdirSystem\Settings.ini aways input off }
  }
  ;//-- "Enable quary loggin" check button
  if $did == 24 {
    if $did($dname,24).state == 1 { /writeini $mircdirSystem\Settings.ini aways logging on }
    else { /writeini $mircdirSystem\Settings.ini aways logging off }
  }

  if $did == 25 {
    if ($window(@Away_Logging) == $null) { window -s @Away_Logging 0 0 640 200 }
    else { /clear @Away_Logging | /window -a @Away_Logging }
    if $lines($mircdirlogging.txt) > 0 {
      /loadbuf @Away_Logging $mircdirlogging.txt
    }
    else {
      /echo @Away_Logging You have no logged messages.
    }
  }
  if $did == 26 { 
    if $did($dname,26).state == 1 { /writeini $mircdirSystem\Settings.ini aways pager on }
    else { /writeini $mircdirSystem\Settings.ini aways pager off }
  }
}

on *:dialog:AwaySystem:edit:*:{
  ;//-- "Reason" edit box
  if $did == 14 {
    /did -u $dname 6
  }
  ;//-- "Nick suffix" edit box
  elseif $did == 15 {
    if $did($dname,$did) == $null {
      /remini $mircdirSystem\Settings.ini aways nicksuffix
    }
    else {
      /writeini $mircdirSystem\Settings.ini aways nicksuffix $did($dname,$did)
    }
  }
  ;//-- "Idle minutes" edit box
  elseif $did == 21 {
    if $did($dname,$did) == $null { /writeini $mircdirSystem\Settings.ini aways idlemin $did($dname,$did) }
    else { /writeini $mircdirSystem\Settings.ini aways idlemin $did($dname,$did) }
  }
}

on *:start:{
  if $readini($mircdirSystem\Settings.ini,aways,nicksuffix) == $null {
    /writeini $mircdirSystem\Settings.ini aways nicksuffix [A]
  }
  if $readini($mircdirSystem\Settings.ini,aways,public) == $null {
    /writeini $mircdirSystem\Settings.ini aways public on
  }
  if $readini($mircdirSystem\Settings.ini,aways,publics) == $null {
    /writeini $mircdirSystem\Settings.ini aways publics all
  }
  if $readini($mircdirSystem\Settings.ini,aways,remind) == $null {
    /writeini $mircdirSystem\Settings.ini aways remind off
  }
  if $readini($mircdirSystem\Settings.ini,aways,idle) == $null {
    /writeini $mircdirSystem\Settings.ini aways idle off
  }
  if $readini($mircdirSystem\Settings.ini,aways,idlemin) == $null {
    //writeini $mircdirSystem\Settings.ini aways idlemin 30
  }
  if $readini($mircdirSystem\Settings.ini,aways,input) == $null {
    /writeini $mircdirSystem\Settings.ini aways input off
  }

  if $readini($mircdirSystem\Settings.ini,aways,logging) == $null {
    /writeini $mircdirSystem\Settings.ini aways logging off
  }
  if $readini($mircdirSystem\Settings.ini,aways,pager) == $null {
    /writeini $mircdirSystem\Settings.ini aways pager off
  }
  .timer 0 60 away_idle
}

on *:input:*:{
  if $away && $readini($mircdirSystem\Settings.ini,aways,input) == on {
    /away_back
  }
}

on *:text:*:#:{
  if $left($me,- $+ $len($readini($mircdirSystem\Settings.ini,aways,nicksuffix))) isin $1- {
    if $readini($mircdirSystem\Settings.ini,aways,remind) == on && $away {
      /msg $chan I am away at the moment Reason: $readini($mircdirSystem\Settings.ini,aways,lastawaymess) (Logging: $+ $away_logging $+ /Pager: $+ $away_pager $+ )
    }
  }
}

on *:text:*:?:{
  if $readini($mircdirSystem\Settings.ini,aways,logging) == on && $away {
    .notice $nick Is $b(Away) $+ : ( $+ $readini($mircdirSystem\Settings.ini,aways,lastawaymess) $+ ) Your Message(s) have been logged. (Logging: $+ $away_logging $+ /Pager: $+ $away_pager $+ )
    write $mircdir $+ logging.txt $timestamp < $+ $nick $+ > $1-
  }
}

ctcp 1:page: {
  if $away_pager && $away {
    .notice $nick Your Page Has Been Received.
    write $mircdir $+ page.txt $timestamp < $+ $nick $+ > $2-
  }
}

alias away_idle {
  if $readini($mircdirSystem\Settings.ini,aways,idle) == on && $readini($mircdirSystem\Settings.ini,aways,idlemin) != $null {
    if $calc($idle / 60) > $readini($mircdirSystem\Settings.ini,aways,idlemin) {
      /away_set idle...
    }
  }
}

alias away_logging {
  if $readini($mircdirSystem\Settings.ini,aways,logging) == on { return On }
  else { return Off }
}

alias away_pager {
  if $readini($mircdirSystem\Settings.ini,aways,pager) == on { return On }
  else { return Off }
}

alias away_set {
  /away $1-
  if $readini($mircdirSystem\Settings.ini,aways,nicksuffix) != $null {
    if $readini($mircdirSystem\Settings.ini,aways,nicksuffix) == $null {
      /remini $mircdirSystem\Settings.ini aways lastnicksuffix
    }
    else {
      /nick $me $+ $readini($mircdirSystem\Settings.ini,aways,nicksuffix)
      /writeini $mircdirSystem\Settings.ini aways lastnicksuffix $readini($mircdirSystem\Settings.ini,aways,nicksuffix)
    }
  }

  /writeini $mircdirSystem\Settings.ini aways lastawaymess $1-

  if $readini($mircdirSystem\Settings.ini,aways,public) == on {
    if $readini($mircdirSystem\Settings.ini,aways,publics) == active {
      if $active ischan {
        /msg $active Is now $b(Away) $+ : $1- (Logging: $+ $away_logging $+ /Pager: $+ $away_pager $+ )
      }
    }
    elseif $readini($mircdirSystem\Settings.ini,aways,publics) == all {
      /amsg Is now $b(Away) $+ : $1- (Logging: $+ $away_logging $+ /Pager: $+ $away_pager $+ )
    }
  }
}

alias away_back {
  if $away {
    var %away_time = $awaytime
    /away
    if $readini($mircdirSystem\Settings.ini,aways,lastnicksuffix) != $null {
      if $right($me,$len($readini($mircdirSystem\Settings.ini,aways,lastnicksuffix))) == $readini($mircdirSystem\Settings.ini,aways,lastnicksuffix) {
        /nick $left($me,- $+ $len($readini($mircdirSystem\Settings.ini,aways,lastnicksuffix)))
      }
    }
    if $readini($mircdirSystem\Settings.ini,aways,public) == on {
      if $readini($mircdirSystem\Settings.ini,aways,publics) == active {
        if $active ischan {
          /msg $active Is now $b(Back) From: ( $+ $readini($mircdirSystem\Settings.ini,aways,lastawaymess) $+ ) & was gone for: ( $+ $duration(%away_time) $+ ) Away System
        }
      }
      elseif $readini($mircdirSystem\Settings.ini,aways,publics) == all {
        /amsg Is now $b(Back) From: ( $+ $readini($mircdirSystem\Settings.ini,aways,lastawaymess) $+ ) & was gone for: ( $+ $duration(%away_time) $+ ) Away System
      }
    }
  }
}
