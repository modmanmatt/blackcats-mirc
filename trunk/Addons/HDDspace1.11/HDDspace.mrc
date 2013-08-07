;------------------------------
; Name    : HDDspace
; Version : 1.11
; Author  : cP|Leif
; Contact : #serske @ Quakenet
;------------------------------



alias HDDspace {
  ; Returns diskspacing information on all or specific disks
  ; Syntax: /HDDspace %disk
  ;   where %disk is optional (default = all)


  ; Errorchecking:
  if ($numtok(%HDDspaceColors,32) != 5)       return $dialog(HDDspaceSettings,HDDspaceSettings)
  if ($numtok(%HDDspaceColors,44) != 6)       return $dialog(HDDspaceSettings,HDDspaceSettings)
  if ($numtok(%HDDspaceDiskInterval,32) != 2) return $dialog(HDDspaceSettings,HDDspaceSettings)

  ; Change Settings?
  if (($1 == settings) || ($1 == setup)) return $dialog(HDDspaceSettings,HDDspaceSettings)

  ; Settings
  var %i   = $asc($gettok(%HDDspaceDiskInterval,1,32))
  var %j   = $asc($gettok(%HDDspaceDiskInterval,2,32))

  var %c1  =  $+ $gettok(%HDDspaceColors,1,32)
  var %c2  =  $+ $gettok(%HDDspaceColors,2,32)
  var %c3  =  $+ $gettok(%HDDspaceColors,3,32)

  var %cp1 = $gettok(%HDDspaceColors,4,32)
  var %cp2 = $gettok(%HDDspaceColors,5,32)

  ; Messagemode
  if (($active ischan) || ($query($active))) {
    var %msgmode = msg $active
  }
  else {
    var %msgmode = echo -s
  }

  ; Variables
  var %d
  var %free
  var %total
  var %percent

  ; Disktype
  if ($1 != $null) {
    if (($asc($upper($1)) < $asc(A)) || ($asc($upper($1)) > $asc(Z))) {
      echo * ERROR - HDDspace : % $+ disk needs to be drive letter (A-Z)
      halt
    }
    elseif ($disk($1).type != fixed) {
      echo * ERROR - HDDspace : $1 is not a fixed disk or does not exist
      halt
    }
    else {
      %i = $asc($1)
      %j = $asc($1)
    }
  }

  [ %msgmode ] %c1 HDD's $spacing(8) Free $spacing(6) Total $spacing(1) Usage $spacing(1) 1 $+ $chr(169) cP $+ $chr(124) $+ Leif 

  while (%i <= %j) {
    %d = $upper($chr(%i))
    if $disk(%d).type == fixed {
      [ %msgmode ] %c2 %d $+ : $spacing(3) $pad($suffix($disk(%d).free),12) $pad($suffix($disk(%d).size),12) $spacing(1) $progressbar($calc(1 - ($disk(%d).free / $disk(%d).size)), [ %cp1 ] ) $+ %c2 $pad($roundfix($calc(100 - ($disk(%d).free / $disk(%d).size * 100)),2) $+ %,6) 
      %free  = $calc(%free + $disk(%d).free)
      %total = $calc(%total + $disk(%d).size)
    }
    inc %i
  }

  if ($1 == $null) {
    %percent = $calc(1 - (%free / %total))
    [ %msgmode ] %c3 Total: $pad($suffix(%free),12) $pad($suffix(%total),12) $spacing(1) $progressbar(%percent, [ %cp2 ] ) $+ %c3 $pad($roundfix($calc(%percent * 100),2) $+ %,6) 
  }

}



alias spacing {
  ; Returns a string of white spaces (ASCII char 160)
  ; Syntax: $spacing(%n)
  ;
  return $str($chr(160),$$1)
}

alias progressbar {
  ; Returns a graphical progresbar with optional colors as a string
  ; Syntax : $progressbar(%value, %bgcolor, %color, %length)
  ;   where %length is optional (default = 10)
  ;
  var %length = $4
  if (%length == $null) %length = 10
  var %percent = $round($calc($$1 * %length),0)
  var %partOne = $str($chr(4),%percent)
  if (%percent < %length) var %partTwo =  $+ $$3 $+ $str($chr(4),$calc(%length - %percent))
  return  $+ $$2 $+ %partOne $+ %partTwo
}

alias suffix {
  ; Formats bytes with apropriate suffix
  ; Syntax: $suffix(%bytes)
  ;
  var %value
  var %type
  if ($1 >= $calc(2^40)) {
    %value = $calc($1 / 2^40)
    %type = TB
  }
  elseif ($1 >= $calc(2^30)) {
    %value = $calc($1 / 2^30)
    %type = GB
  }
  elseif ($1 >= $calc(2^20)) {
    %value = $calc($1 / 2^20)
    %type = MB
  }
  elseif ($1 >= $calc(2^10)) {
    %value = $calc($1 / 2^10)
    %type = kB
  }
  else {
    %value = $1
    %type = byte(s)
  }
  return $roundfix(%value,2) %type
}

alias roundfix {
  ; Returns number with fixed number deciamals
  ; Syntax: $roundfix(%number, %decimals)
  ;   where %decimals > 0
  ;
  var %value = $round($$1,$$2)
  if ($pos(%value,.,0) == 0) {
    %value = %value $+ . $+ $str(0,$$2)
  }
  else {
    %value = $left(%value $+ $str(0,$$2),$calc($pos(%value,.,1) + $$2))
    if (. isin $right(%value,2)) {
      %value = %value $+ 0
    }
  }
  return %value
}

alias pad {
  ; Pads the string with white spaces (see $spacing function) on optional sides
  ; Syntax: $pad(%string, %mode)
  ;   where %mode is optional (default = left)
  ;
  var %len = $len($strip($1))
  if (($3 == left) || ($3 == $null)) return $spacing($calc($$2 - %len)) $+ $1
  if  ($3 == right)                  return $1 $+ $spacing($calc($$2 - %len))
  if  ($3 == both)                   return $spacing($int($calc($$2 / 2 - %len / 2))) $+ $1 $+ $spacing($calc($2 - $int($calc($2 / 2 + %len / 2))))
}



menu status,menubar,channel,query {
  -
  Addons
  .HDD's
  ..All:/HDDspace
  ..-
  ..DiskC:/HDDspace C
  ..DiskE:/HDDspace E
  ..DiskF:/HDDspace F
  ..DiskG:/HDDspace G
  ..DiskH:/HDDspace H
  ..-
  ..other...:/HDDspace $$?=disk? (A-Z)
  -
}
menu menubar {

  Settings
  .HDDspace Settings...:/dialog -m HDDspaceSettings HDDspaceSettings

}


dialog HDDspaceSettings {

  title    "HDDspace Settings"
  icon     $mircexe, 18
  size     -1 -1 150 150
  option   dbu

  box     "Colors",      101,   5  3 140 73

  text    "Foreground",   11,  46 10  45 10
  text    "Background",   12,  96 10  45 10

  text    "Header",       13,  10 22  45 10
  combo                    1,  45 20  45 10, drop
  combo                    2,  95 20  45 10, drop

  text    "Body",         14,  10 32  45 10
  combo                    3,  45 30  45 10, drop
  combo                    4,  95 30  45 10, drop

  text    "Totals",       15,  10 42  45 10
  combo                    5,  45 40  45 10, drop
  combo                    6,  95 40  45 10, drop

  text    "Progressbars", 16,  10 52  45 10
  combo                    7,  45 50  45 10, drop
  combo                    8,  95 50  45 10, drop

  text    "Tot.Progress", 17,  10 62  45 10
  combo                    9,  45 60  45 10, drop
  combo                   10,  95 60  45 10, drop


  box     "Advanced",                           123,   5  80 140 43

  text    "Diskinterval (default = C-Z):",       31,  10  90 150 10
  text    "The script searches for fixed disks", 32,  15 100 150 10
  text    "from",                                33,  15 110  20 10
  edit    "C",                                   21,  30 108  10 10, center, limit 1
  text    "to",                                  34,  45 110  20 10
  edit    "Z",                                   22,  55 108  10 10, center, limit 1


  button  "OK",     41,  35 130 36 12, default, ok
  button  "Cancel", 42,  80 130 36 12, cancel

}

on 1:dialog:HDDspaceSettings:init:*: {
  var %colors     =  0 White   1 Black   2 DarkBlue  3 Green       4 Red       5 Brown
  %colors = %colors  6 Purple  7 Orange  8 Yellow    9 LightGreen 10 DarkCyan 11 Cyan
  %colors = %colors 12 Blue   13 Pink   14 DarkGrey 15 Grey

  didtok $dname 1,2,3,4,5,6,7,8,9,10 32 %colors

  var %i = 1
  var %ii = 1
  while (%ii < 11) {
    did -c $dname %ii $calc($gettok($gettok(%HDDspaceColors,%i,32),1,44) + 1)
    did -c $dname $calc(%ii + 1) $calc($gettok($gettok(%HDDspaceColors,%i,32),2,44) + 1)
    inc %i
    inc %ii 2
  }

  did -o $dname 21 1 $gettok(%HDDspaceDiskInterval,1,32)
  did -o $dname 22 1 $gettok(%HDDspaceDiskInterval,2,32)

  if (($did($dname,21) < A) || ($did($dname,21) > Z)) did -o $dname 21 1 C
  if (($did($dname,22) < A) || ($did($dname,22) > Z)) did -o $dname 22 1 Z


}

on 1:dialog:HDDspaceSettings:edit:21,22: {
  ; Validate editboxes
  if ($len($did($dname,$did)) > 0) {
    did -o $dname $did 1 $upper($did($dname,$did))
    if (($did($dname,$did) < A) || ($did($dname,$did) > Z)) did -r $dname $did
  }
}

on 1:dialog:HDDspaceSettings:sclick:41: {
  ; on Dialog OK

  set %HDDspaceColors
  set %HDDspaceDiskInterval

  var %i = 1
  while (%i < 11) {
    %HDDspaceColors = %HDDspaceColors $round($did($dname,%i,0)) $+ ,
    %HDDspaceColors = %HDDspaceColors $+ $round($did($dname,$calc(%i + 1),0))
    inc %i 2
  }

  %HDDspaceDiskInterval = $did($dname,21) $did($dname,22)
}

on 1:load: {
  set %HDDspaceColors 0,15 0,14 0,10 9,15 9,15
  set %HDDspaceDiskInterval C Z
  echo 4 -a HDDspace addon loaded!
  echo 4 -a Entering setup...
  return $dialog(HDDspaceSettings,HDDspaceSettings)
}

on 1:unload: {
  unset %HDDspaceColors
  unset %HDDspaceDiskInterval
  echo 4 -a HDDspace addon unloaded!
}
