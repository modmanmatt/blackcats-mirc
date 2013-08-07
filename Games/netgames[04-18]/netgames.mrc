;=========================================
;-----------------------------------------
; Net Games by KiX (kixdagr8@hotmail.com)
;  With MDX.dll by Dragonzap
;   And nhtmln_2.92.dll by Dan
;-----------------------------------------
;=========================================
dialog gms {
  title "Net Games"
  size -1 -1 338 245
  option dbu
  list 1, 0 3 53 206, size
  list 2, 55 233 283 11, size
  list 3, 3 219 47 10, size
  button "Button", 4, 57 5 278 225
  check "Mute", 6, 15 231 22 10
  box "", 7, 55 0 282 232
  box "Volume", 8, 0 210 53 34
  button "OK", 999, 9999 9999 0 0, ok
  menu "Options", 9
  item "Add a Game", 10, 9
  item "Edit Url", 11, 9
  item "Delete a Game", 12, 9
  item break, 99, 9
  item "On top", 15, 9
  menu "Help", 13
  item "Read Me!", 14, 13
}
dialog agms {
  title "Add a Game"
  size -1 -1 184 46
  option dbu
  edit "", 1, 3 13 48 12, autohs
  edit "", 2, 56 13 122 12, autohs
  button "Add", 4, 67 32 23 12, disable
  button "Apply", 5, 67 32 23 12, hide disable
  button "Cancel", 6, 92 32 23 12, cancel
  box "Game Name", 7, 0 3 54 26
  box "Url to Game", 8, 53 3 129 26
}
Alias -l agms.a { diopengms agms }
Alias -l agms.e { if (!$did(gms,1).sel) { var %e = $input(You must select a game,o,Error) | halt } 
  diopengms agms | did -h agms 4 | did -v agms 5 
  var %f = $+(",$scriptdirdata\games.dat,"),%l = $calc($did(gms,1).sel - 1),%r = $read(%f,n,%l),%n = $gettok(%r,1,135),%u = $gettok(%r,2,135)
  did -ra agms 1 %n | did -ra agms 2 %u | did -e agms 5 
}
Alias -l gms.a { 
  var %f = $+(",$scriptdirdata\games.dat,"),%n = $did(agms,1).text,%u = $did(agms,2).text
  if (%n) && (%u) { write %f %n $+ $chr(135) $+ %u | if ($dialog(gms)) { gms.l gms } | did -b agms 4 | did -rf agms 2,1 }
  if (!%n) { var %e = $input(Error,o,You must Enter a Game Name) | did -f agms 1 | did -b agms 4 | halt }
  if (!%u) { var %e = $input(Error,o,You must Enter a URL) | did -f agms 2 | did -b agms 4 | halt }
}
Alias -l gms.e {
  var %f = $+(",$scriptdirdata\games.dat,"),%l = $calc($did(gms,1).sel - 1),%r = $read(%f,n,%l),%n = $gettok(%r,1,135),%u = $gettok(%r,2,135)
  if (%n) && (%u) && (%l) { write -dl $+ %l %f | .timerGMSA 1 1 gms.a }
  if (!%n) { var %e = $input(Error,o,You must Enter a Game Name) | did -f agms 1 | did -b agms 4 | halt }
  if (!%u) { var %e = $input(Error,o,You must Enter a URL) | did -f agms 2 | did -b agms 4 | halt }
}
Alias -l gms.d { 
  var %l = $did(gms,1).sel,%f = $+(",$scriptdirdata\games.dat,")
  if (!%l) { var %e = $input(You must select a game to delete,o,Error) | halt }
  if ($input(Delete Game,n,You Sure?) = $true) && (%l) { write -dl $+ $calc(%l - 1) %f | dialog -ve gms }
  gms.l gms
}
On *:dialog:agms:edit:1:{ if ($did($dname,1).text) && ($did($dname,2).text) { did -e $dname 4 } | else { did -b $dname 4 } }
On *:dialog:agms:edit:2:{ if ($did($dname,1).text) && ($did($dname,2).text) { did -e $dname 4 } | else { did -b $dname 4 } }
On *:dialog:agms:sclick:4:{ gms.a } 
On *:dialog:agms:sclick:5:{ gms.e }
menu channel {
  - 
  Games
  .Net Games:netgames 
}
Alias netgames { diopengms gms }
Alias -l diopengms { if ($dialog($1) != $null) { dialog -ve $1 } | else { dialog -md $1 $1 } } 
Alias -l diread { var %d = $1,%i = $2,%p = $3 | if (!$4) { var %t = 32 } | if ($4) { var %t = $4 } | if ($gettok($did(%d,%i).seltext,%p,%t)) { return $gettok($did(%d,%i).seltext,%p,%t) } | else { return $null } }
Alias -l mdx_fullpath { return $+(",$scriptdirmdx.dll,") }
Alias -l mdx { dll $mdx_fullpath $1- }
Alias -l mdxinit { dll $mdx_fullpath SetMircVersion $version | dll $mdx_fullpath MarkDialog $dname }
Alias -l gms { dll $+(",$scriptdirnHTMLn_2.92.dll,") $1- } 
Alias -l gamego { gms attach $window(@ngames).hwnd | if ($1-) { gms navigate $1- } }
Alias -l mdxgms { 
  mdxinit
  mdx SetControlMDX $dname 1 ListView report rowselect single > $scriptdirviews.mdx
  mdx SetControlMDX $dname 2 StatusBar > $scriptdirbars.mdx
  mdx SetBorderStyle $dname 2 windowedge
  mdx SetControlMDX $dname 3 TrackBar TrackBar tooltips noticks nwticks > $scriptdirbars.mdx
  mdx SetBorderStyle $dname 3 windowedge
  mdx SetControlMDX $dname 4 Window > $scriptdirdialog.mdx
  window -hB @ngames 0 0 0 0 
  did -a $dname 4 grab $window(@ngames).hwnd @ngames
  did -i $dname 2 1 setparts 300 600
  did -i $dname 2 2 Current Game:
  did -i $dname 2 3 Status:
  did -i $dname 3 1 params $vol(master) 0 65535 * * * * 16
  did -i $dname 3 1 tipText Volume: $round($calc(($vol(master) / 65535) * 100),0) $+ $chr(37)
  did -i $dname 3 1 tickfreq 1
  did -i $dname 1 1 headerdims 100
  if ($vol(master).mute == $true) { did -c gms 6 }
  gamego $scriptdirnetgames.htm | gms.l gms
}
Alias -l game.d { 
  var %l = $did($dname,1).sel,%f = $+(",$scriptdirdata\games.dat,")
  if ($input(Confirm Delete,n,Delete?,You Sure?) = $true) && (%l) { write -dl $+ $calc(%l - 1) %f } 
  gms.l gms
}
On *:dialog:gms:close:0:{ if ($dialog(agms)) { dialog -x agms } }
;Start up
;--------
On *:dialog:gms:init:0:{ mdxgms }
;Game List
;---------
Alias -l gms.l { var %f = $+(",$scriptdirdata\games.dat,"),%l = 1 | did -r $1 1 | while (%l <= $lines(%f)) { var %d = $read(%f,n,%l) | did -a $1 1 $gettok(%d,1,135) | inc %l } | did -i $1 1 1 headertext - $+ $lines($+(",$scriptdirdata\games.dat,")) $+ - Games }

;Game Go
;-------
Alias -l gameinit { 
  var %l = $calc($did(gms,1).sel - 1),%f = $+(",$scriptdirdata\games.dat,"),%u = $gettok($read(%f,n,%l),2,135),%g = $diread(gms,1,6-)
  gms navigate %u | did -o $dname 2 2 Current Game: %g | did -o $dname 2 3 Status: Ready for Play 
}
On *:dialog:gms:dclick:1:{ gameinit }

;Volume/mute
;-----------
On *:dialog:gms:sclick:3:{ 
  if ($vol(master).mute == $true) { vol -vu2 | did -u gms 6 }
  var %eu = $diread(gms,3,9-),%v = $diread(gms,3,1)
  if (%v <= 1) { vol -v 0 } | else { vol -v %v }
  did -i gms 3 1 tipText Volume: $round($calc(($vol(master) / 65535) * 100),0) $+ $chr(37)
}
On *:dialog:gms:sclick:6:{ if ($vol(master).mute == $false) { vol -vu1 | did -c gms 6 | halt } | else { vol -vu2 | did -u gms 6 | halt } }
On *:dialog:gms:menu:10:{ agms.a }
On *:dialog:gms:menu:11:{ agms.e }
On *:dialog:gms:menu:12:{ gms.d }
On *:dialog:gms:menu:14:{ run $+(",$scriptdirreadme.txt,") }
On *:dialog:gms:menu:15:{ if ($did(gms,15).state == 1) { did -u gms 15 | dialog -n gms | halt } | else { did -c gms 15 | dialog -o gms | halt } }

____________
;End of File
