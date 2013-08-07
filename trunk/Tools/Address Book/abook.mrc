;; Adressbook v1.1 (Multilang)
;; © 2004 Christopher Ruﬂ 

on *:dialog:addressbook:close:*:{ savecurrent | hfree -w kontakt* }
on *:dialog:addressbook:init:0:{
  setyear
  setmonth
  setday
  checkpic 
  if ($exists($scriptdirabook\tmp.bmp)) { did -g $dname 33 " $+ $scriptdirabook\tmp.bmp" }
  elseif ($exists($scriptdirabook\logo.bmp)) { did -g $dname 33 " $+ $scriptdirabook\logo.bmp" }
  tokenize 124 $lng(abook,location2)
  did -a $dname 38 $*
  if ($version < 6.15) { 
    did -ra $a 43 $lng(error,version)
    did -b $a 43
  }
  mdxl
  mdx SetControlMDX $dname 44,45 ListView report grid sortascending showsel rowselect infotip > $views
  did -i $a 44,45 1 headerdims 1:1 1:2 1:3 1:4 1:5 1:6 1:7 1:8 1:9 1:10 1:11 1:12
  did -i $a 44,45 1 headertext +r 0 $lng(head,1) 	+l 0 $lng(head,2) 	+l 0 $lng(head,3) 	+l 0 $lng(head,14) 	+l 0 $lng(head,4) 	+r 0 $lng(head,5) 	+l 0 $lng(head,6) 	+l 0 $lng(head,7) 	+l 0 $lng(head,8) 	+l 0 $lng(head,9) 	+l 0 $lng(head,10) 	+l 0 $lng(head,11)
  if ($isdir($hget(abook.lang,open))) { open $hget(abook.lang,open) }
  did -i $a 44,45 1 headerdims autoheader:all
}
on *:dialog:addressbook:menu:*:{
  if ($did == 4) { open }
  if ($did == 9) { new }
  if ($findtok(51 52 53,$did,1,32)) { did -f $dname $gettok(12 11 13,$ifmatch,32) | if ($did == 53) { did -f $a 47 } }
  if ($did == 54) { ahelp }
  if ($did == 55) { about }
  if ($did == 6) { abook.lng }
  if ($dialog($a).w >= 600) {
    if ($did(24).sel) {
      if ($did == 48) { newcon }
      if ($did == 49) { delcon }
      if ($did == 61) { export }
      if ($did == 5) { close }
    }
  }
}
on *:dialog:addressbook:sclick:*:{
  if ($did == 24) { _loadsel }
  if ($did(24).sel) {
    if ($did == 33) { selpic }
    if ($did == 57) { _savesel }
    if ($did == 59) { clr -s }
    if ($did == 14) { newcon }
    if ($did == 15) { delcon }
    if ($did == 43) { clip }
    if ($did == 22) { if (*?@?* iswm $did(31)) { run mailto: $+ $did(31) } | else { beep } }
    if ($did == 58) { search }
    if ($did == 13) { did -f $a 47 }
    var %x = $did(63).sel
    if ($istok(64 65,$did,32)) { setday $did($a,63).sel }
  }
}
on *:dialog:addressbook:dclick:44,45:{
  if ($istok(44 45,$did,32)) {
    var %x = $didwm($a,24,$gettok($gettok($did($a,$did).seltext,6,32),1,9) '*')
    if (%x) { did -c $a 24 %x }
  }
  did -f $a 12 | _loadsel
  did -f $a 26
}

;; aliases
alias abook { if ($1 == -d) { !abook } | else { addressbook } }
alias addressbook {
  if (!$exists($lng)) { 
    $left($input(Language file not found! $crlf $+ Please select a language File.,adiog,Error!),0)
    lng $$sfile($scriptdirabook\lang\*.lng,Select file:,Use)
  }
  elseif (!$script(abook.dlg.mrc)) {
    write -c " $+ $scriptdirabook\abook.dlg.mrc"
    window -hn @tmp
    var %x = $lines($scriptdirabook\abook.dat),%i = 0
    while (%i < %x) {
      inc %i
      aline @tmp $read($scriptdirabook\abook.dat,%i)
    }
    savebuf @tmp " $+ $scriptdirabook\abook.dlg.mrc"
    window -c @tmp
    if ($script(abook.dlg.mrc)) { !.unload -rs abook.dlg.mrc }
    !.load -rs " $+ $scriptdirabook\abook.dlg.mrc"
    .timer 1 0 addressbook
  }
  else {
    if ($dialog($a)) { dialog -v $a }
    else {
      dialog -m $a $a
      set %_abook.w $iif($r(1,0),20,$iif($r(1,0),10,5))
      .timerabook.w -m 0 1 abook.w %_abook.w
    }
  }
}
alias -l abook.w {
  if ((!$dialog($a)) || (%_abook.w >= 605)) { .timerabook.w off | %_abook.h = $1 | .timerabook.h -m 0 1 abook.h $1 | return }
  x.y | dialog -s $a %_abook.x %_abook.y %_abook.w 0
  inc %_abook.w $1
}
alias -l abook.h {
  if ((!$dialog($a)) || (%_abook.h >= 425)) { .timerabook.h off | unset %_abook.? | return }
  x.y | dialog -s $a %_abook.x %_abook.y $calc(%_abook.w - $1) %_abook.h
  inc %_abook.h $1
}
alias -l x.y {
  %_abook.x = $int($calc(($window(-1).w / 2) - ($dialog($a).w /2)))
  %_abook.y = $int($calc(($window(-1).h / 2) - ($dialog($a).h /2)))
}
alias -l year return $asctime(yyyy)
alias -l age {
  var %ta = $calc(($ctime - $ctime($$1)) / 31557600),var %x = 0
  if ($gettok($1,3,46) < 1970) { var %x = $calc(1970 - $gettok($1,3,46)) }
  return $int($calc(%ta + %x))
}
alias -l setday {
  did -r $a 63
  var %f = 1:31;2:28/29;3:31;4:30;5:31;6:30;7:31;8:31;9:30;10:31;11:30;12:31
  var %1 = 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28
  var %2 = 29
  var %3 = 29,30
  var %4 = 29,30,31
  var %x = $gettok(%f,$did($a,64).sel,59)
  var %d = $gettok(%x,2,58)
  if ($left(%x,2) == 2:) {
    if (4 // $did($a,65)) { var %d = $gettok(%d,2,47) }
    else { var %d = $gettok(%d,1,47) }
  }
  didtok $a 63 44 %1 $+ $chr(44) $+ $iif(%d == 29,%2,$iif(%d == 30,%3,$iif(%d == 31,%4)))
  var %d = $iif($1,$1,$asctime(d))
  did -c $a 63 $iif($did($a,63,%d),%d,$did($a,63).lines)
}
alias -l setmonth {
  if (!$1) {
    did -r $a 64
    didtok $a 64 44 $lng(abook,month)
  }
  did -c $a 64 $iif($1,$1,$asctime(m))
}
alias -l setyear {
  if (!$1) {
    did -r $a 65
    var %x = 2000,%y = $year
    while (%y > %x) { did -a $a 65 %y | dec %y }
    didtok $a 65 32 2000 1999 1998 1997 1996 1995 1994 1993 1992 1991 1990 1989 1988 1987 1986 1985 1984 1983 1982 1981 1980 1979 1978 1977 1976 1975 1974 1973 1972 1971 1970 1969 1968 1967 1966 1965 1964 1963 1962 1961 1960 1959 1958 1957 1956 1955 1954 1953 1952 1951 1950 1949 1948 1947 1946 1945 1944 1943 1942 1941 1940 1939 1938 1937 1936 1935 1934 1933 1932 1931 1930 1929 1928 1927 1926 1925 1924 1923 1922 1921 1920 1919 1918 1917 1916 1915 1914 1913 1912 1911 1910 1909 1908 1907 1906 1905 1904 1903 1902 1901 1900
  }
  did -c $a 65 $iif($1,$findtok($didtok($a,65,32),$1,1,32),1)
}
alias -l open {
  savecurrent
  :reselect
  var %x = $iif($isdir($1-),$1-,$$sdir(C:\,$lng(question,loading),$lng(question,loading1)))
  if ($findfile(%x,kontakt,1,0)) {
    hfree -w kontakt*
    clr
    hmake kontakt
    hload kontakt " $+ $findfile(%x,kontakt,1,0) $+ "
    hadd kontakt path $left(%x,-1)
    dialog -t $a $lng(abook,titlebar) - %x
    hadd -m abook.lang open %x
    did -r $a 24
    var %x = $findfile(%x,kontakt.*,0,1,_load $nopath($1-) $1-)
    did -i $a 44,45 1 headerdims autoheader:all
    if (!$did($a,24,1)) { newcon }
    write -c " $+ $scriptdirabook\lang.hsh"
    hsave abook.lang " $+ $scriptdirabook\lang.hsh"
    did -c $a 24 1 
    _loadsel
  }
  else { 
    -error " $+ %x $+ " $lng(error,nolist)
    goto reselect
  }
}
alias -l close {
  did -r $a 24,26,27,28,29,30,31,32,39,40,41,44,45,47
  did -g $a 33 " $+ $scriptdirabook\tmp.bmp"
  hdel abook.lang open
  write -c " $+ $scriptdirabook\lang.hsh"
  hsave abook.lang " $+ $scriptdirabook\lang.hsh"
  dialog -t $a $lng(abook,titlebar)
}
alias -l search {
  did -r $a 45
  if ($did($a,47)) {
    var %x = $did($a,44).sel
    did -c $a 44 1
    filter -ior $+(2-,$did($a,44).lines) $a 44 $a 45 $+(*,$replace($did($a,47),$chr(32),*),*)
    did -c $a 44 %x
  }
  did -i $a 45 1 headerdims autoheader:all
}
alias -l selpic {
  checkpic
  var %p = $sfile(C:\*.jpg,$lng(question,selpic),$lng(question,selpic1))
  did -g $a 33 " $+ $iif(%p,%p,$scriptdirabook\tmp.bmp) $+ "
}
alias -l newcon {
  hinc kontakt cid
  hsave kontakt $+(",$hget(kontakt,path),\,kontakt")
  did -a $a 24 $+($chr(35),$hget(kontakt,cid) ',$chr(44) ,')
  did -c $a 24 $didwm($a,24,$+($chr(35),$hget(kontakt,cid) '*'))
  hmake kontakt. $+ $hget(kontakt,cid)
  hsave kontakt. $+ $hget(kontakt,cid) $+(",$hget(kontakt,path),\,kontakt.,$hget(kontakt,cid),")
  clr -s
  tokenize 32 $+(kontakt.,$hget(kontakt,cid))
  did -a $a 44 $t($chr(35) $+ $gettok($1,2,46),$hget($1,name),$hget($1,firstname),$iif($hget($1,bday),$int($age($hget($1,bday))),---),$hget($1,street),$hget($1,zip),$hget($1,city),$hget($1,title),$hget($1,firma),$hget($1,phone),$hget($1,mail),$hget($1,region))
}
alias -l delcon {
  var %id = kontakt. $+ $right($gettok($did($a,24).seltext,1,32),-1)
  var %oldname = $hget(%id,name),%oldfirstname = $hget(%id,firstname),%oldmail = $hget(%id,mail),%oldregion = $hget(%id,region)
  var %x = $+(*+*0*0*0*,$gettok($did($a,24).seltext,1,32),$chr(9),*,%oldname,*,%oldfirstname,*,%oldmail,*,%oldregion,*)
  did -d $a 44 $didwm($a,44,%x)
  did -d $a 24 $did($a,24).sel
  did -c $a 24 1
  !.remove $+(",$hget(kontakt,path),\,%id,")
  hfree %id
  if (!$did($a,24).lines) { newcon }
  _loadsel
}
alias -l _loadsel {
  clr -s
  var %id = kontakt. $+ $right($gettok($did($a,24).seltext,1,32),-1)
  var %l = 26:name 27:firstname 28:title 29:firma 30:phone 31:mail 32:note 39:street 40:zip 41:city
  var %x = $numtok(%l,32)
  while (%x) {
    var %c = $gettok(%l,%x,32),%1 = $gettok(%c,1,58),%2 = $gettok(%c,2,58)
    if ($hget(%id,%2)) { did -a $a %1 $hget(%id,%2) }
    dec %x
  }
  :r
  var %r = $didwm($a,38,$hget(%id,region))
  if (!%r && $hget(%id,region)) { did -a $a 38 $hget(%id,region) | goto r }
  did -c $a 38 $iif(%r,%r,1)
  if ($hget(%id,pic)) {
    if ($exists($hget(%id,pic))) { did -g $a 33 $+(",$hget(%id,pic),") }
    else { did -g $a 33 " $+ $scriptdirabook\tmp2.bmp" }
  }
  var %bday = $$hget(%id,bday)
  tokenize 46 %bday
  setyear $3
  setmonth $2
  setday $1
}
alias -l _savesel {
  var %id = kontakt. $+ $right($gettok($did($a,24).seltext,1,32),-1)
  var %l = 26:name 27:firstname 28:title 29:firma 30:phone 31:mail 32:note 38:region 39:street 40:zip 41:city
  var %oldname = $hget(%id,name),%oldfirstname = $hget(%id,firstname),%oldmail = $hget(%id,mail),%oldregion = $hget(%id,region)
  var %x = $numtok(%l,32)
  while (%x) {
    var %c = $gettok(%l,%x,32),%1 = $gettok(%c,1,58),%2 = $gettok(%c,2,58)
    hadd -m %id %2 $did($a,%1)
    dec %x
  }
  hadd -m %id pic $gettok($did($a,33),2-,32)
  var %date =  $did(63).sel $+ . $+ $did(64).sel $+ . $+ $did(65).seltext
  if (%date != $date(d.m.yyyy)) { hadd -m %id bday %date }
  elseif ($hget(%id,bday)) { hdel %id bday }
  var %f = $+(",$hget(kontakt,path),\,%id,")
  var %c = $did($a,24).sel
  did -o $a 24 %c $+($chr(35),$gettok(%id,2,46) ',$hget(%id,name),$chr(44) $hget(%id,firstname),')
  did -c $a 24 %c
  write -c %f
  hsave %id %f
  var %x = $+(*+*0*0*0*,$gettok($did($a,24).seltext,1,32),*,%oldname,*,%oldfirstname,*,%oldmail,*,%oldregion,*)
  did -d $a 44 $didwm($a,44,%x)
  tokenize 32 %id
  did -a $a 44 $t($chr(35) $+ $gettok($1,2,46),$hget($1,name),$hget($1,firstname),$iif($hget($1,bday),$int($age($hget($1,bday))),---),$hget($1,street),$hget($1,zip),$hget($1,city),$hget($1,title),$hget($1,firma),$hget($1,phone),$hget($1,mail),$hget($1,region))
  did -i $a 44,45 1 headerdims autoheader:all
}
alias -l clr {
  if (!$istok(" $+ $scriptdirabook\tmp.bmp" " $+ $scriptdirabook\tmp2.bmp",$gettok($did($a,33),2,32),32)) { checkpic | did -g $a 33 " $+ $scriptdirabook\tmp.bmp" }
  if ($1 == -s) { did -r $a 26,27,28,29,30,31,32,39,40,41 }
  else { did -r $a 24,26,27,28,29,30,31,32,39,40,41,44,45,47 }
  did -c $a 38 1
  setyear $asctime(yyyy)
  setmonth
  setday
}
alias -l _load {
  if ($gettok($1,2,46) isnum) {
    hmake $1
    hload $1 " $+ $2- $+ "
    did -a $a 24 $+($chr(35),$gettok($1,2,46) ',$hget($1,name),$chr(44) $hget($1,firstname),')
    did -a $a 44 $t($chr(35) $+ $gettok($1,2,46),$hget($1,name),$hget($1,firstname),$iif($hget($1,bday),$int($age($hget($1,bday))),---),$hget($1,street),$hget($1,zip),$hget($1,city),$hget($1,title),$hget($1,firma),$hget($1,phone),$hget($1,mail),$hget($1,region))
  }
}
alias -l a { if ($isid) { return addressbook } | else { addressbook } }
alias -l -yesno { if ($input($1,adiyg,Frage)) { $2 } }
alias -l -error { $left($input($1-,adiog,Fehler),0) }
alias -l clear {
  if (\ !isin $1-) && (| !isin $1-) && (/ !isin $1-) && (: !isin $1-) && (* !isin $1-) && (? !isin $1-) && (" !isin $1-) && (< !isin $1-) && (> !isin $1-) { return $true }
  else { return $false }
}
alias -l createnew {
  if ($hget(kontakt,0).item) { hfree -w kontakt* }
  hmake kontakt
  var %f = " $+ $1- $+ \kontakt $+ "
  write -c %f
  hadd kontakt created $asctime
  hadd kontakt path $1-
  hsave -o kontakt %f
  dialog -t $a $lng(abook,titlebar) - $1- $+ \
  a
}
alias -l specialdir {
  if ($1) {
    var %com $+(c,$ticks)
    .comopen %com WScript.Shell
    if $comerr { return }
    var %g = $com(%com,SpecialFolders,3,uint,$$1),%f = $com(%com).result 
    .comclose %com 
    return %f
  }
}
alias -l savecurrent {
  var %f = $hget(kontakt,path)
  var %x = $hget(0).item
  while (%x) {
    if (kontakt.* iswm $hget(%x)) {
      %c = $+(",%f,\,$hget(%x),")
      write -c %c
      hsave $hget(%x) %c
    }
    dec %x
  }
}
alias -l dosdir {
  var %x = $ticks,%p = $$1,%f = c:\dos.txt,%r = $iif($2 isnum,$2,1),%r = %r * 1000
  if ($com(dos $+ %x)) { .comclose dos $+ %x }
  .comopen dos $+ %x WScript.Shell
  if !$comerr { .comclose dos $+ %x $com(dos $+ %x,Run,3,bstr,$+(%,comspec%) /c echo $1- > %f,uint,0,bool,true) }
  var %x = $read(%f,n,1) | .remove %f | return %x
}
alias remdir { 
  var %f = $findfile($$1-,*,0,!.remove " $+ $1- $+ ")
  window -hn @b | %f = $finddir($$1-,*,0,aline @b $1-) | %f = $line(@b,0)
  while (%f) { dec %f | !.rmdir " $+ $line(@b,%f) $+ " }
  window -c @b | !.rmdir " $+ $1- $+ "
}
alias -l checkpic {
  if (!$exists($scriptdirabook\)) { mkdir abook }
  if ($exists($scriptdirabook\tmp.bmp)) { !.remove " $+ $scriptdirabook\tmp.bmp" }
  if ($window(@picwin)) { window -c @picwin }
  var %@ = @picwin,%f = " $+ $scriptdirabook\logo.bmp"
  if (* !iswm $window(%@)) window -BhCfpk +bLf %@ -1 -1 120 120
  drawrect -frn %@ 16777215 0 0 0 120 120
  var %w = $pic(%f).width
  var %h = $pic(%f).height
  if ($exists(%f)) { 
    if (%h > 80) { %w = $int($calc(%w / %h * 80)) | %h = 80 }
    drawpic -sm @picwin $calc(60 - (%w /2)) 2 %w %h %f 
    var %tpos1 $calc(%h +2),%tpos2 $calc(%h +13)
  }
  else {
    var %tpos1 30,%tpos2 41
  }
  drawtext -rn %@ 0 "Arial" 11 4 %tpos1 $lng(pic,title)
  drawtext -rn %@ 0 "Arial" 11 4 %tpos2 $lng(pic,title2)
  drawpic %@
  drawsave %@ " $+ $scriptdirabook\tmp.bmp"
  if ($exists($scriptdirabook\tmp2.bmp)) { !.remove " $+ $scriptdirabook\tmp2.bmp" }
  drawtext -rno %@ 255 "Arial" 11 4 $calc(%tpos2 +11) $lng(pic,warn)
  drawpic %@
  drawsave %@ " $+ $scriptdirabook\tmp2.bmp"
  window -c %@
}
alias -l new {
  savecurrent
  unset %r
  var %x = $$sdir(C:\,$lng(question,save),$lng(question,save1))
  :retype
  var %i = $$input($lng(question,save2),eg,$lng(question,save3),$lng(abook,titlebar))
  if ($clear(%i)) { var %x = $+(%x,%i) }
  else { -error $lng(error,evilchars) | goto retype }
  var %i = 1
  while ($specialdir(%i)) {
    if (%x == $specialdir(%i)) { -error $lng(error,systemdir) | goto retype }
    inc %i
  }
  tokenize 124 $+($dosdir($+(%,windir%)),|,$dosdir($+(%,temp%)))
  %i = $0
  while (%i) {
    if (%x == $($+($,%i),2)) { -error $lng(error,systemdir) | goto retype }
    dec %i
  }
  if ($exists(%x)) { $-yesno($lng(question,deldir),set %r 1)  }
  if ($exists(%x)) && (%r) { 
    remdir %x
    mkdir " $+ %x $+ "
    createnew %x
  }
  elseif (!$exists(%x)) { mkdir " $+ %x $+ " | createnew %x }
  else { -error $lng(error,cantcreate) }
  clr
  newcon
  unset %r
}
alias -l getopt {
  var %opt = $+(-,$1), %regex = /\s? $+ %opt (\S+)/
  if (!$prop) && ($regex($2-,%regex)) return $regml(1)
  if ($prop == bool) && ($istok($2-,%opt,32)) return $true
  return $false
}
;; MDX
alias -l mdx dll " $+ $scriptdirabook\mdx.dll" $1-
alias -l views return $scriptdirabook\views.mdx
alias -l mdxl mdx SetMircVersion $version | mdx MarkDialog $dname 
alias -l t {
  if ($1) { var %i = 0,%x = $0,%t | while (%i < %x) { inc %i | %t = $+($iif(%t,%t $+ $chr(9)),+ 0 0 0 $($+($,%i),2)) } | return %t }
  else return $chr(9)
}


;; about
alias -l about { if ($dialog(addressbook)) { var %x = $dialog(about,about,-4) } }
on *:dialog:about:sclick:*:{ 
  if ($did == 1) { run mailto:Sephiroth@leech-world.de?subject=Addressbook, Commets, Bugs, Critic and so on }
  else { dialog -c about }
}


;; clipboard
on *:dialog:clip:init:0:{
  did -a clip 1 $lng(clip,break)
  tokenize 32 $lng(head,8) $lng(head,9) $lng(head,10) $lng(head,11) $lng(head,13)
  did -a clip 1 $*
  tokenize 32 $lng(clip,break) $lng(clip,break) $lng(head,7) $lng(clip,break) $lng(head,3) $lng(head,2) $lng(clip,break) $lng(head,4) $lng(clip,break) $lng(clip,break) $lng(head,5) $lng(head,6) $lng(clip,break) $lng(clip,break)
  var %x = $0
  while (%x) {
    did -i clip 2 1 $($+($,%x),2)
    dec %x
  }
  did -c clip 1 1
  did -c clip 2 1
  gp
}
on *:dialog:clip:sclick:*:{
  if ($did(clip,1).sel) {
    if ($did == 3) { did -a clip 2 $did(clip,1).seltext | if ($did(clip,1).seltext != $lng(clip,break)) { did -d clip 1 $did(clip,1).sel } | did -c clip 1 1 | gp }
  }
  if ($did(clip,2).sel) {
    if ($did == 4) { if ($did(clip,2).seltext != $lng(clip,break)) { did -a clip 1 $did(clip,2).seltext } | did -d clip 2 $did(clip,2).sel | did -c clip 2 1 | gp }
    if ($did == 5) { move -1 | gp }
    if ($did == 6) { move +1 | gp }
  }
  if ($did == 11) { while ($did(clip,1,2)) { did -a clip 2 $did(clip,1,2) | did -d clip 1 2 } | did -c clip 2 1 | did -c clip 1 1 | gp }
  if ($did == 12) { while ($did(clip,2,1)) { if ($did(clip,2,1) != $lng(clip,break)) { did -a clip 1 $did(clip,2,1) } | did -d clip 2 1 } | did -c clip 1 1 | gp }
  if ($did == 9) { var %id = kontakt. $+ $right($gettok($did($a,24).seltext,1,32),-1) | clipboard $$replacex($didtok(clip,2,32),$lng(clip,break),$crlf,$lng(head,7),$hget(%id,title),$lng(head,3),$hget(%id,firstname),$lng(head,2),$hget(%id,Name),$lng(head,4),$hget(%id,street),$lng(head,5),$hget(%id,zip),$lng(head,6),$hget(%id,city),$lng(head,8),$hget(%id,firma),$lng(head,9),$hget(%id,phone),$lng(head,10),$hget(%id,mail),$lng(head,11),$hget(%id,region)) }
}
alias -l move {
  if ($did(2).sel) { 
    var %l = $ifmatch,%o = $did(2,%l),%nl = $calc(%l $1)
    if (%nl > $did(2).lines) { %nl = $did(2).lines | beep } | elseif (!%nl) { %nl = 1 | beep }
    did -d $dname 2 %l | did -i $dname 2 %nl %o | did -c $dname 2 $didwm(2,%o,%nl)
  }
}
alias -l gp { did -ra clip 13 $$replacex($didtok(clip,2,32),$lng(clip,break),$crlf,$lng(head,7),Mr,$lng(head,3),Mad,$lng(head,2),Cow,$lng(head,4),Cowstreet 7,$lng(head,5),$r(10000,99999),$lng(head,6),Ranch,$lng(head,8),Cow & Co.,$lng(head,9),911,$lng(head,10),cow@ran.ch,$lng(head,11),Somewhere,$lng(head,13),$asctime(dd.mm.yyyy)) }
alias -l clip { _savesel | var %x = $dialog(clip,clip,-4) }


;; export
alias -l export { var %x = $dialog(export,export,-4) }
on *:dialog:export:init:0:{ 
  var %x = 0
  while ($lng(export,format $+ %x)) {
    did -a export 4 $lng(export,format $+ %x)
    inc %x
  }
  did -c export 4 1
}
on *:dialog:export:sclick:1:{
  :resel
  unset %u
  var %x = $$sfile($+(C:\,$nopath($hget(kontakt,path)),.,$gettok(txt csv,$did(4).sel,32)),$lng(question,export),$lng(question,export1))
  ;var %x = $$sfile($+(C:\,$nopath($hget(kontakt,path)),.,$gettok(txt csv,$did(4).sel,32)),Export,Export)
  if ($exists(%x)) { $-yesno($lng(question,overwrite),set %u 1) }
  if ($exists(%x)) && (!%u) { goto resel }
  exp $gettok(txtexp csvexp,$did(4).sel,32) %x
  dialog -c export
  unset %u
}
alias -l exp {
  write -c " $+ $2- $+ "
  var %x = 0,%i = $hget(0)
  while (%x < %i) {
    inc %x
    %y = $hget(%x)
    if (kontakt.* iswm %y) {
      if ($gettok(%y,2,46) isnum) {
        $1 $hget(%x) $2-
      }
    }
  }
}
alias -l txtexp {
  var %w = write $+(",$2-,")
  %w $lng(abook,title) $iif($hget($1,title),$ifmatch,$chr(32))
  %w $left($lng(abook,name),-1) $+ , $lng(abook,surname) $hget($1,name) $+ , $hget($1,firstname)
  %w $lng(abook,street) $hget($1,street)
  %w $left($lng(abook,zip),-1) $lng(abook,city) $hget($1,zip) $hget($1,city)
  %w $lng(abook,region) $iif($hget($1,region) != $gettok($lng(abook,location2),1,124),$hget($1,region))
  %w $lng(abook,firm) $hget($1,firma)
  %w $lng(abook,phone) $hget($1,phone)
  %w $lng(abook,email) $hget($1,mail)
  %w $lng(abook,note) $hget($1,note)
  %w $lng(abook,bday) $hget($1,bday)
  %w $crlf $+ $crlf
}
alias -l csvexp {
  var %w = write $+(",$2-,")
  if (!$read($2-,1)) { %w $+($lng(head,2),;,$lng(head,3),;,$lng(head,7),;,$lng(head,4),;,$lng(head,5),;,$lng(head,6),;,$lng(head,11),;,$lng(head,8),;,$lng(head,9),;,$lng(head,10),;,$lng(head,13),;,$lng(head,12)) }
  %w $+($hget($1,name),;,$hget($1,firstname),;,$hget($1,title),;,$hget($1,street),;,$hget($1,zip),;,$hget($1,city),;,$iif($hget($1,region) != $gettok($lng(abook,location2),1,124),$hget($1,region)),;,$hget($1,firma),;,$hget($1,phone),;,$hget($1,mail),;,$hget($1,bday),;,$hget($1,note))
}


;; help
alias -l ahelp { dialog $iif($dialog(ahelp),-v,-m) ahelp ahelp }

;; language aliases
alias -l lng {
  var %t = abook.lang
  if (!$hget(%t)) {
    hmake %t
    if ($isfile($scriptdirabook\lang.hsh)) { hload %t " $+ $scriptdirabook\lang.hsh" }
    else { hadd -m %t lf " $+ $scriptdirabook\lang\en(uk).lng" | hsave %t " $+ $scriptdirabook\lang.hsh" }
  }
  if ($isid) {
    if (!$1) { return $hget(%t,lf) }
    else { return $readini($hget(%t,lf),$1,$$2) }
  }
  else {
    if ($dialog(ahelp)) { dialog -x ahelp }
    if ($dialog(export)) { dialog -x export }
    if ($dialog(clip)) { dialog -x clip }
    if ($dialog(about)) { dialog -x about }
    if ($dialog(addressbook)) { dialog -x addressbook }
    hadd %t lf " $+ $1- $+ "
    write -c " $+ $scriptdirabook\lang.hsh"
    hsave %t " $+ $scriptdirabook\lang.hsh"
    var %f = $hget(%t,lf)
    $left($input(Loaded file %f $crlf $crlf $+ Language: $iif($readini(%f,info,lang),$ifmatch,not found) $crlf $crlf $+ Author: $iif($readini(%f,info,author),$ifmatch,not found),adiog,Language changed),0)
    if ($dialog(abook)) { dialog -c abook }
    if ($script(abook.dlg.mrc)) { !.unload -rs abook.dlg.mrc }
    abook
  }
}
alias abook.lng {
  var %x = $$sfile($scriptdirabook\lang\*.lng,Please select a language File.,Select)
  lng %x
}

;load unload event
on *:unload:{
  if ($dialog(ahelp)) { dialog -x ahelp }
  if ($dialog(export)) { dialog -x export }
  if ($dialog(clip)) { dialog -x clip }
  if ($dialog(about)) { dialog -x about }
  if ($dialog(addressbook)) { dialog -x addressbook }
  if ($script(abook.dlg.mrc)) { .unload -rs " $+ $ifmatch $+ " }
}
on *:load:{
  if ($version < 6) { echo -ag * You need at least mIRC 6.0 to use this addon. | .unload -rs " $+ $script $+ " }
  else {
    if (!$isfile($scriptdirabook\abook.dlg.mrc)) { abook.lng }
    echo $color(info2) -ag * Type /abook or /addressbook to open the addressbook
  }
}
