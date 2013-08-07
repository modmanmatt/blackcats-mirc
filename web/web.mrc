on *:load:set %currenturl http://www.mircscripts.org | set %webontop off | set %webhotlinks on | echo -a :: Web Experience v6 by: contr0l loaded.. Usage: /web or /web www.bleh.com or /web last to goto the last page you visited.
on *:unload:unset %currenturl | unset %webontop | unset %startaddy | unset %searchsite | unset %iil | unset %il2 | unset %lasturl | unset %manualfavspath | unset %importdir | echo -s :: Thx for trying contr0l's Web Experience v6!
menu menubar,channel,status,nicklist,chat,query {
  -
  Web Experience:web
  -
}
;Aliases
alias -l getcode .sockopen getcode $gettok($1-,2,47) 80 | %site1 = $gettok($1-,2,47) | %site = $iif($+(/,$gettok($1-,3-,47)),$ifmatch,/)
alias -l webh { if (!$dialog(webh)) { dialog -am webh webh } }
alias -l wbo { if ($dialog(wbo)) { dialog -x wbo | dialog -am wbo wbo } | else dialog -am wbo wbo }
alias -l webtime { if ($dialog(wbc)) { did -i wbc 26 4 2 $asctime(hh:nn:sstt) } }
alias -l fav { if (!$dialog(fav)) { dialog -am fav fav } }
alias -l wmdll { return $dll($+(",$scriptdirdlls\,winmenu.dll,"),$1,$2-) }
alias -l hdll return $+(",$scriptdirdlls\,nHTMLn_2.92.dll,")
alias -l c { if ($disk(c:)) { return c:\ } | else return $left($mircdir,3) }
alias -l currentuser { 
  .comopen Reg WScript.Shell
  var %n $com(reg,RegRead,3,bstr,HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\Favorites)
  var %t3 = $com(Reg).result
  .comclose Reg
  return $gettok(%t3,3,92)
}
alias -l popup.newitem dll $popdll AddItem $$1-
alias wbc { if (!$dialog(wbc)) { dialog -am wbc wbc } }
alias -l popup tokenize 32 $dll($popdll,Popup,$1-) | if ($isid) return $1- | $iif($4- != did not select a menu item,$4-)
;nhtml alias
alias web.h {
  if (progress_change isin $1-) {
    if ($dialog(wbc)) {
      var %webpr $gettok($1-,3,32)
      if (%webpr == 50) { did -i wbc 26 3 0 $str(|,1) }
      if (%webpr == 100) { did -i wbc 26 3 0 $str(|,5) }
      if (%webpr == 200) { did -i wbc 26 3 0 $str(|,8) }
      if (%webpr == 300) { did -i wbc 26 3 0 $str(|,12) }
      if (%webpr == 400) { did -i wbc 26 3 0 $str(|,16) }
      if (%webpr == 500) { did -i wbc 26 3 0 $str(|,18) }
      if (%webpr == 600) { did -i wbc 26 3 0 $str(|,20) }
      if (%webpr == 700) { did -i wbc 26 3 0 $str(|,22) }
      if (%webpr == 0) && ($gettok($1-,5,32) == 0) { did -i wbc 26 3 0 [- Web Experience -] }
      elseif (%webpr == 1000) && ($gettok($1-,5,32) == 1000) { did -i wbc 26 3 0 [- Web Experience -] }
    }
  }
  if ($2 == document_complete) { if ($dialog(wbc)) { set %currenturl $3- | set %lasturl $3- | dscroll wbc 1 10 115 $dll($hdll,name,$window(@web).hwnd) | titlebar @web $+([,$dll($hdll,name,$window(@web).hwnd),]) | did -ra wbc 18 %currenturl | if (!$read($s"(his.txt), w, $+(*,%currenturl,*))) { if ($lines($s"(his.txt)) < 15) { write $s"(his.txt) %currenturl | var %w = $wmdll(WMSetItem,%hsmen >  $calc(%il2 + $calc(%iil + 1)) 0 %currenturl) } | else { write -c $s"(his.txt) } } } }
  if ($2 == status_change) { if ($dialog(wbc)) { did -i wbc 26 2 1 $3- } }
  return S_OK
}
alias -l s_ok { return }
alias -l new.menu dll $popdll New $1-
alias -l webtranslist {
  new.menu wbot 8 8
  var %wtl popup.newitem wbot end
  %wtl English to French $cr web $webtrans(en_fr)
  %wtl English to German $cr web $webtrans(en_de)
  %wtl English to Italian $cr web $webtrans(en_it)
  %wtl English to Japanese $cr web $webtrans(en_ja)
  %wtl English to Korean $cr web $webtrans(en_ko)
  %wtl English to Portugese $cr web $webtrans(en_pt)
  %wtl English to Spanish $cr web $webtrans(en_es)
  %wtl Chinese to English $cr web $webtrans(zh_en)
  %wtl French to English $cr web $webtrans(fr_en)
  %wtl French to German $cr web $webtrans(fr_de)
  %wtl German to English $cr web $webtrans(de_en)
  %wtl German to French $cr web $webtrans(de_fr)
  %wtl Italian to English $cr web $webtrans(it_en)
  %wtl Japanese to English $cr web $webtrans(ja_en)
  %wtl Korean to English $cr web $webtrans(ko_en)
  %wtl Portugese to English $cr web $webtrans(pt_en)
  %wtl Spanish to English $cr web $webtrans(es_en)
  %wtl Russian to English $cr web $webtrans(ru_en)
  popup wbot $mouse.dx $mouse.dy

}
alias -l webtrans { return http://babelfish.altavista.com/babelfish/urlload?url=http%3A%2F%2F $+ %currenturl $+ &lp= $+ $1 $+ &tt=url }

alias web {
  if (!$window(web)) {
    if (!$1) {
      web.iono %urladdy
    }
    elseif ($1) {
      if ($1 == last) {
        web.iono %lasturl
      }
      elseif ($1 != last) {
        set -u5 %urladdy $1
        web.iono %urladdy
      }
    }
  }
  elseif ($window(web)) { .window -c @web | .timer -m 1 1 web $1 }
}
alias -l web.iono {
  ;open @web window
  window -Cpdza $+ $iif(%webontop == on,o,u) @web $scriptdiricons\ $+ web_bow.ico
  wbc
  var %w = $wmdll(WMMark,$window(@web).hwnd @web)
  var %wsi = WMSetItem
  var %wsm = WMSetSubMenu
  var %wcm = WMCreateSubMenu
  var %hmenu = $wmdll(WMCreateMenuBar,$window(@web).hwnd)
  %hmenu = $gettok(%hmenu,2,32)
  var %hsmenu = $wmdll(%wcm,.)
  %hsmenu = $gettok(%hsmenu,2,32)
  var %w = $wmdll(%wsi,%hsmenu > 1 0 Back)
  var %w = $wmdll(%wsi,%hsmenu > 2 0 Forward)
  var %w = $wmdll(%wsi,%hsmenu > 3 0 Stop)
  var %w = $wmdll(%wsi,%hsmenu > 0 0 -)
  var %w = $wmdll(%wsi,%hsmenu > 4 0 Home)
  var %w = $wmdll(%wsi,%hsmenu > 5 0 Search)
  var %w = $wmdll(%wsi,%hsmenu > 0 0 -)
  var %w = $wmdll(%wsi,%hsmenu > 6 0 Refresh)
  var %hsmenu7 = $wmdll(%wcm,.)
  %hsmenu7 = $gettok(%hsmenu7,2,32)
  var %w = $wmdll(%wsi,%hsmenu7 > 7 0 View-Source)
  var %hsmenu2 = $wmdll(%wcm,.)
  %hsmenu2 = $gettok(%hsmenu2,2,32)
  var %w = $wmdll(%wsi,%hsmenu2 > 8 0 en_fr)
  var %w = $wmdll(%wsi,%hsmenu2 > 9 0 en_de)
  var %w = $wmdll(%wsi,%hsmenu2 > 10 0 en_it)
  var %w = $wmdll(%wsi,%hsmenu2 > 11 0 en_ja)
  var %w = $wmdll(%wsi,%hsmenu2 > 12 0 en_ko)
  var %w = $wmdll(%wsi,%hsmenu2 > 13 0 en_pt)
  var %w = $wmdll(%wsi,%hsmenu2 > 14 0 en_es)
  var %w = $wmdll(%wsi,%hsmenu2 > 15 0 ch_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 16 0 fr_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 17 0 fr_de)
  var %w = $wmdll(%wsi,%hsmenu2 > 18 0 de_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 19 0 de_fr)
  var %w = $wmdll(%wsi,%hsmenu2 > 20 0 it_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 21 0 ja_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 22 0 ko_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 23 0 pt_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 24 0 es_en)
  var %w = $wmdll(%wsi,%hsmenu2 > 25 0 ru_en)
  var %hsmenu3 = $wmdll(%wcm,.)
  %hsmenu3 = $gettok(%hsmenu3,2,32)
  var %w = $wmdll(%wsi,%hsmenu3 > 26 $iif(%web.zoom == 25,3,0) 25%)
  var %w = $wmdll(%wsi,%hsmenu3 > 27 $iif(%web.zoom == 50,3,0) 50%)
  var %w = $wmdll(%wsi,%hsmenu3 > 28 $iif(%web.zoom == 75,3,0) 75%)
  var %w = $wmdll(%wsi,%hsmenu3 > 29 $iif(%web.zoom == 100,3,0) 100%)
  var %hsmenu4 = $wmdll(%wcm,.)
  %hsmenu4 = $gettok(%hsmenu4,2,32)
  var %w = $wmdll(%wsi,%hsmenu4 > 30 0 Add-A-Favorite)
  var %w = $wmdll(%wsi,%hsmenu4 > 31 0 Clear-Favorites)
  var %w = $wmdll(%wsi,%hsmenu4 > 0 0 -)
  var %ii 1, %il 32, %f $+(",$scriptdir,favs.txt,") | while (%ii <= $lines(%f)) { 
    var %w = $wmdll(%wsi,%hsmenu4 > %il 0 $read(%f,%ii))
    inc %ii
    inc %il
  }
  var %hsmenu5 = $wmdll(%wcm,.)
  %hsmenu5 = $gettok(%hsmenu5,2,32)
  var %w = $wmdll(%wsi,%hsmenu5 > $calc(%il + 1) 0 Clear-History)
  var %w = $wmdll(%wsi,%hsmenu5 > 0 0 -)
  var %ii2 1, %il2 $calc(%il + 2), %f2 $+(",$scriptdir,his.txt,") | while (%ii2 <= $lines(%f2)) { 
    var %w = $wmdll(%wsi,%hsmenu5 > %il2 0 $read(%f2,%ii2))
    inc %ii2
    inc %il2
  }
  set %hsmen %hsmenu5
  set %hsmen3 %hsmenu3
  set %iil %il
  set %il2 %il2
  var %w = $wmdll(%wsm,%hmenu > %hsmenu Navigation)
  var %w = $wmdll(%wsm,%hmenu > %hsmenu7 Source)
  var %w = $wmdll(%wsm,%hmenu > %hsmenu2 Translation)
  var %w = $wmdll(%wsm,%hmenu > %hsmenu3 Zoom/FontSize)
  var %w = $wmdll(%wsm,%hmenu > %hsmenu4 Favorites)
  var %w = $wmdll(%wsm,%hmenu > %hsmenu5 History)
  var %w = $wmdll(WMSetMenu,$window(@web).hwnd > %hmenu)
  var %t = $dll($hdll,attach,$window(@web).hwnd)
  var %k = $dll($hdll,handler,web.h)
  var %r = $dll($hdll,navigate,$iif($1 != $null,$1,%startaddy))
  .timerweb 0 1 webtime
  window -a @web
}
alias -l popup.destroy dll $popdll Destroy $$1
alias -l s" return $+(",$scriptdir,$1,")
alias -l popdll return $s"(dlls\popups.dll)
alias -l favspath {
  set %manualfavspath $$sdir($c,Find your Favorites Folder for IE,Ok)
  if ($isdir(%manualfavspath)) {
    set %importdir %manualfavspath
    if ($findfile(%importdir,*.url,0) != 0) {
      var %d = 1
      while (%d <= $findfile(%importdir,*.url,0)) {
        var %tempfindfile = $findfile(%importdir,*.url,%d,0)
        if (!$read($s"(favs.txt), w, * $+ $remove($read(%tempfindfile, 2),BASEURL=,URL=) $+ *)) {
          write $s"(favs.txt) $remove($read(%tempfindfile, 2),BASEURL=,URL=) $remove($nopath(%tempfindfile),.url)
        }
        inc %d
      }
      wbo
      did -ra wbo 10 Import Complete!
      web %currenturl
    }
    else echo -s No url files located in the specified dir. Rerun the import, and choose another dir.
  }
}

alias -l clearfavs {
  if ($lines($s"(favs.txt)) != 0) {
    write -c $s"(favs.txt)
    wbo
    web %currenturl
    .timer 1 .1 did -ra wbo 10 Favorites Successfully Cleared!
  }
}
alias -l removefav {
  if ($gettok($read($s"(favs.txt), w, * $+ $gettok($did(5).seltext,6,32) $+ *),1,32) == $gettok($did(5).seltext,6,32)) {
    write -ds $+ $gettok($did(5).seltext,6,32) $s"(favs.txt)
    wbo
    web %currenturl
    did -ra wbo 10 Favorite Successfully Removed!
  }
}
alias -l loadfavs {
  if ($lines($s"(favs.txt)) != 0) {
    wbo
    var %e = 1
    while (%e <= $lines($s"(favs.txt))) {
      did -a wbo 5 0 0 0 0 $gettok($read($s"(favs.txt) ,%e),1,32) $chr(9) $gettok($read($s"(favs.txt) ,%e),2-,32)
      inc %e
    }
  }
}
alias -l loadfavs2 {
  if ($lines($s"(favs.txt)) != 0) {
    var %e = 1
    while (%e <= $lines($s"(favs.txt))) {
      did -a wbo 5 0 0 0 0 $gettok($read($s"(favs.txt) ,%e),1,32) $chr(9) $gettok($read($s"(favs.txt) ,%e),2-,32)
      inc %e
    }
  }
}
;control dialog
dialog wbc {
  title "[- Web Experience v6 -]"
  size -1 -1 295 41
  option dbu
  icon $scriptdiricons\ $+ web_bow.ico
  text "Address:", 19, 1 13 23 8, center
  list 26, 0 31 296 10, size
  button "", 28, 0 0 1 1
  text "Google Search:", 7, 1 23 39 8
  edit "", 8, 39 22 64 9
  list 2, 0 0 295 13, size
  list 3, 243 11 52 11, size
  edit "", 1, 103 22 192 9, read
  edit "", 18, 25 11 218 11, autohs
  button "", 50, 0 0 1 1, hide default
}
on *:dialog:wbc:*:*: {
  if ($devent == init) {
    dll $s"(dlls\mdx.dll) SetMircVersion $version
    dll $s"(dlls\mdx.dll) MarkDialog $dname
    dll $s"(dlls\mdx.dll) SetControlMDX $dname 26 StatusBar > $scriptdirdlls\ $+ bars.mdx
    dll $s"(dlls\mdx.dll) SetControlMDX $dname 28 positioner minbox > $scriptdirdlls\ $+ dialog.mdx
    dll $s"(dlls\mdx.dll) SetControlMDX $dname 2 ToolBar nodivider flat list > $scriptdirdlls\ $+ bars.mdx
    dll $s"(dlls\mdx.dll) SetControlMDX $dname 3 ToolBar nodivider flat list > $scriptdirdlls\ $+ bars.mdx
    dll $s"(dlls\mdx.dll) SetBorderStyle $dname 26 noborder
    dll $s"(dlls\mdx.dll) SetBorderStyle $dname 2
    dll $s"(dlls\mdx.dll) SetBorderStyle $dname 3
    did -i $dname 26 1 setparts 398 504 589 -1
    did -i $dname 2 1 bmpsize  16 16
    var %didi did -i $dname 2 1 setimage 0 icon small
    %didi 0, $+ $scriptdiricons\ $+ web_left.ico
    %didi 0, $+ $scriptdiricons\ $+ web_right.ico
    %didi 0, $+ $scriptdiricons\ $+ web_stop.ico
    %didi 0, $+ $scriptdiricons\ $+ web_refresh.ico
    %didi 0, $+ $scriptdiricons\ $+ web_home.ico
    %didi 0, $+ $scriptdiricons\ $+ web_search.ico
    %didi 0, $+ $scriptdiricons\ $+ web_printer.ico
    %didi 0, $+ $scriptdiricons\ $+ web_trans.ico
    %didi 0, $+ $scriptdiricons\ $+ web_options.ico
    didtok -a $dname 2 59 +a 1 Back $+ $chr(9) $+ Goes Back a Page;+a 2 Forward $+ $chr(9) $+ Goes Forward a Page;+a 3 Stop $+ $chr(9) $+ Stops loading current page;+a 4 Refresh $+ $chr(9) $+ Refreshes current page;-;+a 5 Home $+ $chr(9) $+ Goto HomePage;+a 6 Search $+ $chr(9) $+ Goto search site;-;+a 7 Print $+ $chr(9) $+ Print current page;+a 8 Translate $+ $chr(9) $+ Translate current page;-;+a 9 Options $+ $chr(9) $+ Options/Favorites
    did -i $dname 3 1 bmpsize  16 16
    did -i $dname 3 1 setimage 0 icon small 0, $+ $scriptdiricons\ $+ web_go.ico
    did -i $dname 3 1 setimage 0 icon small 0, $+ $scriptdiricons\ $+ web_fav.ico
    didtok -a $dname 3 59 +a 1 Go $+ $chr(9) $+ Go!;-;+a 2 Add $+ $chr(9) $+ Add to Favorites
    var %h $+($scriptdir,blue.ico)
    did -i $dname 26 1 seticon 0 small 0, $+ $scriptdiricons\ $+ web_statusbar.ico
    did -i $dname 26 1 seticon 0 small 0, $+ $scriptdiricons\ $+ web_clock.ico
    set %web.zoom 25
    did -f $dname 18
  }
  if ($devent == sclick) {
    if ($did == 2) {
      var %d $did(2).sel
      if (%d == 2) { var %g = $dll($hdll,back,1) }
      if (%d == 3) { var %h = $dll($hdll,forward,1) }
      if (%d == 4) { var %i = $dll($hdll,stop,$window(@web).hwnd) }
      if (%d == 5) { var %j = $dll($hdll,refresh,1) }
      if (%d == 7) { web %startaddy }
      if (%d == 8) { web %searchsite }
      if (%d == 10) { var %v = $dll($hdll,print,$window(@web).hwnd) }
      if (%d == 11) { webtranslist }
      if (%d == 13) { wbo }
    }
    if ($did == 3) {
      var %e $did(3).sel
      if (%e == 2) {
        if ($did(8)) { web http://www.google.com/search?hl=en&lr=&ie=UTF-8&oe=UTF-8&q= $+ $replace($did(8),$chr(32),+) | did -r wbc 8 }
        else { if ($did(18)) { web $did(18) } } 
      }
      elseif (%e == 4) { fav }
    }
    if ($did == 12) { webh }
    if ($did == 50) {
      if ($did(8)) { web http://www.google.com/search?hl=en&lr=&ie=UTF-8&oe=UTF-8&q= $+ $replace($did(8),$chr(32),+) | did -r wbc 8 }
      else { if ($did(18)) { web $did(18) } } 
    }
  }
  if ($devent == close) {
    var %t = $dll($hdll,detach,$window(@web).hwnd)
    if ($window(@web)) { window -c @web }
    .timerweb off
    .unset %DOS.Misc-Dialog-Marquee-*
  }
}
;options dialog
dialog -l wbo {
  title "[- Web Options -]"
  size -1 -1 132 144
  option dbu
  box "", 1, 0 -2 132 146
  text "Starting Address:", 2, 2 3 44 8
  edit "", 3, 47 2 84 10, autohs center
  box "Favorites", 4, 2 46 128 84
  list 5, 3 53 126 67, size
  button "Ok", 7, 96 130 34 12
  text "Search Page:", 8, 2 13 34 8
  edit "", 9, 38 12 92 10, autohs center
  text "", 10, 4 121 124 8, center
  button "Import Favs from IE", 11, 2 130 62 12
  button "Help", 12, 64 130 32 12
  check "Keep Browser Window Ontop of other windows", 13, 4 24 125 10
  box "", 14, 1 41 130 4
  check "Open url hotlinks in Web Experience", 15, 4 33 118 10
  box "", 16, 1 20 130 4
}

on *:dialog:wbo:*:*: {
  if ($devent == init) {
    dll $s"(dlls\mdx.dll) SetMircVersion $version
    dll $s"(dlls\mdx.dll) MarkDialog $dname
    dll $s"(dlls\mdx.dll) SetDialog wbo style title noborder 
    dll $s"(dlls\mdx.dll) SetControlMDX $dname 5 listview single grid showsel rowselect report > $scriptdirdlls\ $+ views.mdx
    did -i $dname 5 1 setbkg url tile $scriptdiricons\ $+ baby.jpg
    did -i $dname 5 1 headerdims 160:1 250:2
    did -i $dname 5 1 headertext URL $chr(9) Description $chr(9)
    if (!%startaddy) { set %startaddy www.mircscripts.org }
    did -a $dname 3 %startaddy
    if (!%searchsite) { set %searchsite www.yahoo.com }
    did -a $dname 9 %searchsite
    if (%webontop == on) { did -c $dname 13 }
    if (%webhotlinks == on) { did -c $dname 15 }
    loadfavs2
    if (%web.fa) { did -ra $dname 10 %web.fa | unset %web.fa }
    elseif (!%web.fa) { did -ra $dname 10 Double Click or Right Click }
  }
  if ($devent == dclick) {
    if ($did == 5) {
      web $gettok($did(5).seltext,6,32)
    }
  }
  if ($devent == sclick) {
    if ($did == 5) {
      if ($gettok($did(wbo,5,1),1,32) == rclick) && ($did(5).sel) {
        new.menu wbo 8 8
        popup.newitem wbo end Goto Url $cr web $gettok($did(5).seltext,6,32)
        popup.newitem wbo end
        popup.newitem wbo end Add A Favorite $cr fav
        popup.newitem wbo end
        popup.newitem wbo end Copy Url to Clipboard $cr clipboard $gettok($did(5).seltext,6,32)
        popup.newitem wbo end
        popup.newitem wbo end Remove Selected $cr removefav
        popup.newitem wbo end Clear All Favorites $cr clearfavs
        popup wbo $mouse.dx $mouse.dy
      }
      if ($gettok($did(wbo,5,1),1,32) == rclick) && (!$did(5).sel) && ($did(wbo,5).lines == 1) {
        new.menu wboo 8 8
        popup.newitem wboo end Add A Favorite $cr fav
        popup wboo $mouse.dx $mouse.dy
      }
      if ($gettok($did(wbo,5,1),1,32) == rclick) && (!$did(5).sel) && ($did(wbo,5).lines > 1) {
        new.menu wbooo 8 8
        popup.newitem wbooo end Add A Favorite $cr fav
        popup.newitem wbooo end
        popup.newitem wbooo end Clear All Favorites $cr clearfavs
        popup wbooo $mouse.dx $mouse.dy
      }
    }
    if ($did == 7) {
      if (!$did(3)) { set %startaddy www.mircscripts.org }
      elseif ($did(3)) { set %startaddy $did(3).text }
      if (!$did(9)) { set %searchsite www.yahoo.com }
      elseif ($did(9)) { set %searchsite $did(9).text }
      dialog -x $dname
    }
    if ($did == 11) {
      if ($isdir($+(",$c,Documents and Settings\,$currentuser,\Favorites,"))) {
        set %importdir $+(",$c,Documents and Settings\,$currentuser,\Favorites,")
        var %g = 1
        while (%g <= $findfile(%importdir,*.url,0)) {
          var %tempfindfile = $findfile(%importdir,*.url,%g)
          if (!$read($s"(favs.txt), w, * $+ $remove($read(%tempfindfile, 2),BASEURL=,URL=) $+ *)) {
            write $s"(favs.txt) $remove($read(%tempfindfile, 2),BASEURL=,URL=) $remove($nopath(%tempfindfile),.url)
          }  
          inc %g
        }
        wbo
        did -ra wbo 10 Import Complete!
      }
      elseif (!$isdir($+(",$c,Documents and Settings\,$currentuser,\Favorites,"))) { echo -s Web Experience couldn't locate your favorites. Please select your favorites folder (for IE). | .timer 1 3 favspath }
    }
    if ($did == 12) { webh }
    if ($did == 13) { if (%webontop == on) { set %webontop off | web %currenturl } | elseif (%webontop == off) || (!%webontop) { set %webontop on | web %currenturl } }
    if ($did == 15) { if (%webhotlinks == on) { set %webhotlinks off | .disable #webhotlinks } | elseif (%webhotlinks == off) || (!%webhotlinks) { set %webhotlinks on | .enable #webhotlinks } }
  }
}
;add favorites dialog
dialog -l fav {
  title "[- Add To Favorites -]"
  size -1 -1 131 36
  option dbu
  icon $scriptdiricons\ $+ web_bow.ico
  edit "", 1, 31 1 101 10, autohs center
  text "URL:", 2, 1 2 30 8, center
  text "Description:", 3, 1 12 30 8, center
  edit "", 4, 31 11 101 10, autohs center
  button "Ok", 5, 1 22 63 12, ok
  button "Cancel", 6, 67 22 63 12
  box "", 7, 0 18 131 17
  box "", 8, 65 19 1 15
}
on *:dialog:fav:init:0:{ 
  did -ra $dname 1 %currenturl
  did -ra $dname 4 $dll($hdll,name,$window(@web).hwnd)
}
on *:dialog:fav:sclick:5:{
  if ($did(1)) && ($did(4)) {
    if (!$read($s"(favs.txt), w, $+(*,$did(1),*))) {
      write $s"(favs.txt) $did(1) $did(4)
      set %web.fa Favorite Successfully Added!
      web %currenturl
      .timer 1 .1 wbo
    }
    else {
      set %web.fa Favorite Already Exists!
      web %currenturl
      .timer 1 .1 wbo
    }
  }
}

on *:dialog:fav:sclick:6:{ dialog -x $dname }
;help dialog
dialog -l webh {
  title "[- Web Experience Help -]"
  size -1 -1 206 138
  option dbu
  icon $scriptdiricons\ $+ web_bow.ico
  box "", 1, 0 0 205 126
  edit "", 2, 2 5 201 119, read multi return vsbar
  link "Web Experience v6", 3, 31 129 60 8, center
  box "", 4, 107 124 98 14
  button Ok, 5, 108 128 96 9
}
on *:dialog:webh:init:0:{
  did -a $dname 2 [- Web Experience v6 -] $crlf
  did -a $dname 2 by: contr0l $crlf
  did -a $dname 2 $chr(32) $crlf
  did -a $dname 2 Basic Usage: $crlf
  did -a $dname 2 [ /web to open it, and goto home page]  $crlf
  did -a $dname 2 [ /web www.bleh.com to open it, and goto www.bleh.com]  $crlf
  did -a $dname 2 [ /web last to open it, and goto the last page you visited]  $crlf
  did -a $dname 2 Tips: $crlf
  did -a $dname 2 [ /wbc opens just the control dialog, no content window ]  $crlf
  did -a $dname 2 [ The home page is set to www.mircscripts.org , and the default search site is yahoo.com. Those can both be changed via the options dialog]  $crlf
  did -a $dname 2 [ You can add the current url to your favorites by clicking the add button, if it already existed, it wont readd]  $crlf
  did -a $dname 2 [ There is a right click menu in the favorites area, which has 2 options. If you have something selected in the list, there will be a more extensive menu. If nothing is selected, there is less options]  $crlf
  did -a $dname 2 [- EOF -] $crlf
  did -f $dname 1
}
on *:dialog:webh:sclick:3:{ mailto:contr0l@comcast.net?subject=About your newest Web Experience... }
on *:dialog:webh:sclick:5:{ dialog -x $dname }
on *:close:@web: {
  var %t = $dll($hdll,detach,$window(@web).hwnd)
  .timerweb off
  if ($dialog(wbc)) { dialog -x wbc }
  .unset %DOS.Misc-Dialog-Marquee-*
}
#webhotlinks on
on ^*:hotlink:*www.*:*:{ if ($numtok($1-,46) >= 2) { return } }
on *:hotlink:*www.*:*:{ if ($numtok($1-,46) >= 2) { web $1- } }
on ^*:hotlink:*//*:*:{ if (*://* iswm $1-) && ($numtok($1-,47) >= 2) { return } }
on *:hotlink:*//*:*:{ if (*://* iswm $1-) && ($numtok($1-,47) >= 2) { web $1- } }
#webhotlinks end
;View Source function
;thx e2ekiel for helping me on this function
on *:sockopen:getcode*: { if (!$sockerr) { var %fweb $+(",$scriptdirsrc.txt,") | .fopen -no getcode %fweb | sockwrite -n $sockname GET %site HTTP/1.1 | sockwrite -n $sockname Host: %site1 | sockwrite -n $sockname Connection: close | sockwrite -n $sockname $crlf } }
on *:sockread:getcode*: {
  sockread %a
  if (*<html* iswm $strip(%a)) || (*<head>* iswm $strip(%a)) { set %ww 1 }
  if (%ww) { if ($strip(%a) != $null) { if (!$ferr) { if ($len($strip(%a)) <= 312) { .fwrite -n getcode $strip(%a) } } } }
}
on *:sockclose:getcode*: { if ($fopen(getcode)) { .fclose getcode | unset %ww | if ($lines($s"(src.txt)) == 0) { write $s"(src.txt) Source code couldn't be retrieved. } | run $s"(src.txt) } }

;winmenu signals
ON *:SIGNAL:WMENU: { 
  var %gt = $gettok($1-,2,32)
  if (%gt == 1) { var %g = $dll($hdll,back,1) }
  if (%gt == 2) { var %g = $dll($hdll,forward,1) }
  if (%gt == 3) { var %g = $dll($hdll,stop,$window(@web).hwnd) }
  if (%gt == 4) { web %startaddy }
  if (%gt == 5) { web %searchsite }
  if (%gt == 6) { var %g = $dll($hdll,refresh,1) }
  if (%gt == 7) { getcode %currenturl }
  if (%gt == 8) { web $webtrans(en_fr) }
  if (%gt == 9) { web $webtrans(en_de) }
  if (%gt == 10) { web $webtrans(en_it) }
  if (%gt == 11) { web $webtrans(en_ja) }
  if (%gt == 12) { web $webtrans(en_ko) }
  if (%gt == 13) { web $webtrans(en_pt) }
  if (%gt == 14) { web $webtrans(en_es) }
  if (%gt == 15) { web $webtrans(zh_en) }
  if (%gt == 16) { web $webtrans(fr_en) }
  if (%gt == 17) { web $webtrans(fr_de) }
  if (%gt == 18) { web $webtrans(de_en) }
  if (%gt == 19) { web $webtrans(de_fr) }
  if (%gt == 20) { web $webtrans(it_en) }
  if (%gt == 21) { web $webtrans(ja_en) }
  if (%gt == 22) { web $webtrans(ko_en) }
  if (%gt == 23) { web $webtrans(pt_en) }
  if (%gt == 24) { web $webtrans(es_en) }
  if (%gt == 25) { web $webtrans(ru_en) }
  if (%gt == 26) { var %g = $dll($hdll,zoom,1) | set %web.zoom 25 | web %currenturl }
  if (%gt == 27) { var %g = $dll($hdll,zoom,2) | set %web.zoom 50 | web %currenturl }
  if (%gt == 28) { var %g = $dll($hdll,zoom,3) | set %web.zoom 75 | web %currenturl }
  if (%gt == 29) { var %g = $dll($hdll,zoom,4) | set %web.zoom 100 | web %currenturl }
  if (%gt == 30) { fav }
  if (%gt == 31) { write -c $s"(favs.txt) | web %currenturl }
  if (%gt > 31) && (%gt <= %iil) { web $read($+(",$scriptdir,favs.txt,"),$calc(%gt - 31)) }
  if (%gt == $calc(%iil + 1)) { write -c $+(",$scriptdir,his.txt,") | web %currenturl } 
  if (%gt > $calc(%iil + 1)) { web $read($+(",$scriptdir,his.txt,"),$calc(%gt - $calc(%iil + 1))) }
}

;// below is not my code, props to who wrote it, from clanx's site
;scrolls text on dialog
alias dscroll { if ( $2 == $null ) { $Error(Dialog-Marquee, Variables- Missing variables needed to scroll marquee) | halt }
  if ( 0 >= $3 ) { .timer $+ _Dialog-Marquee- $+ $1 $+ . $+ $2 off | halt } | set %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ . ] ] [ $+ [ $2 ] ] 0
  set %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $chr(160) $+ $5-
  set %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ ~ ] ] [ $+ [ $2 ] ] 0 | :loop | if ( $len( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] ) >= $4 ) { goto end }
  inc %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ ~ ] ] [ $+ [ $2 ] ] | %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] = $chr(160) $+ %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ]
  goto loop | :end | %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] = $replace( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] , $chr(32), $chr(160))
  %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] = %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] $+ %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ]
  .timer $+ _Dialog-Marquee- $+ $1 $+ . $+ $2 -m 0 $calc( 840 / $3 ) $!_Dialog-Marque2( $1 , $2 , $4 , $len( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] ) )
}
alias _Dialog-Marque2 { if ( $dialog($1) == $null ) { dscroll $1 $2 0 0 0 | halt } | inc %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ . ] ] [ $+ [ $2 ] ] | did -r $1 $2
  if ( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ . ] ] [ $+ [ $2 ] ] > $4 ) { %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ ` ] ] [ $+ [ $2 ] ] = $calc( $4 - $3 - 1)
    %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] = $right( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] , %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ ` ] ] [ $+ [ $2 ] ] ) $+ $left( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] , $3 )
    %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ . ] ] [ $+ [ $2 ] ] = $calc( $3 + 1 )
  }
  if ($dialog($1)) { did -a $1 $2 $iif( $mid( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] , $calc( $4 - %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ . ] ] [ $+ [ $2 ] ] ),1) == $chr(160),$chr(160)) $+ $mid( %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ _ ] ] [ $+ [ $2 ] ] , $calc( $4 - %DOS.Misc-Dialog-Marquee- [ $+ [ $1 ] ] [ $+ [ . ] ] [ $+ [ $2 ] ] ), $3) }
}
