;queue manager 2004
alias qmanager {
  if $dialog(qmannew) == $null /dialog -md qmannew qmannew
  else /dialog -iev qmannew qmannew
}


;==================================
; DIALOG .. DIALOG .. DIALOG ..
;==================================

dialog qmannew {
  title "qmanager 2004 ©"
  size -1 -1 396 286
  option dbu
  icon $mircdiricon\920.ico, 0

  ; // -------------------------- //
  ; // -- Tab(Outgoing queues) -- //
  ; // -------------------------- //
  tab "Outgoing Queues", 1, 2 0 392 270
  list 2, 191 70 200 161, tab 1 size extsel
  edit "", 11, 198 46 173 9, tab 1 autohs
  edit "", 21, 198 37 173 9, tab 1 autohs
  box Files, 42, 150 30 243 210, tab 1
  text "Queues:", 23, 174 39 22 9, tab 1
  text "System:", 25, 174 48 23 9, tab 1
  text "Size:", 1015, 174 57 23 9, tab 1
  edit "", 1016, 198 53 173 9, tab 1 autohs read
  box "Choose Nick", 36, 4 30 56 159, tab 1
  list 100, 7 38 50 149, tab 1 sort size
  edit "",16, 7 190 50 10, tab 1
  button "Move Up", 4, 153 80 37 10, tab 1
  button "Move Down", 5, 153 90 37 10, tab 1
  button "Move Top", 44, 153 70 37 10, tab 1
  button "Move Bottom", 55, 153 100 37 10, tab 1
  button "Send Queue", 56, 153 110 37 10, tab 1
  button "Send Next", 57, 153 120 37 10, tab 1
  button "Remove", 3, 153 150 37 10, tab 1
  button "Update", 6, 153 160 37 10, tab 1
  button "Add-s", 7, 150 170 30 10, hide tab 1
  button "Add-m", 204, 150 180 30 10, hide tab 1
  button "Done", 200, 150 190 30 10, hide tab 1 ok
  button "save", 201, 153 200 37 10, tab 1
  button "Restore", 202, 153 210 37 10, tab 1
  button "Browse", 30, 153 220 37 10, tab 1
  link "Active Sends", 2000, 65 115 70 20, tab 1
  box "Queue Info", 2007, 63 30 85 79, tab 1
  text "Max Queues", 2008, 66 38 30 8, tab 1
  text "Max Queues", 2009, 66 48 30 8, tab 1
  text "Max Sends", 2010, 66 58 30 8, tab 1
  text "Max Sends", 2011, 66 68 30 8, tab 1
  text "Ad-Delay", 2012, 66 78 30 8, tab 1
  text "Max-Serves", 2013, 66 88 30 8, tab 1
  text "Adve Chans", 2014, 66 98 30 8, tab 1
  edit "", 2015, 98 37 36 10, tab 1 
  edit "", 2016, 98 47 36 10, tab 1 
  edit "", 2018, 98 57 36 10, tab 1 
  edit "", 2017, 98 67 36 10, tab 1 
  edit "", 2019, 98 77 36 10, tab 1 
  edit "", 2020, 98 87 36 10, tab 1
  edit "", 2021, 98 97 45 10, tab 1 read
  link "Set", 2022, 136 38 10 7, tab 1
  link "Set", 2023, 136 48 10 7, tab 1
  link "Set", 2024, 136 58 10 7, tab 1
  link "Set", 2025, 136 68 10 7, tab 1
  link "Set", 2026, 136 78 10 7, tab 1
  link "Set", 2027, 136 88 10 7, tab 1
  button "Update-list", 2032, 5 18 54 10, tab 1
  button "start", 2033, 10 215 30 10, tab 1

  ; // ----------------------- //
  ; // -- Tab(Select Files) -- //
  ; // ----------------------- //
  tab "Select Files", 300
  list 110, 27 49 361 196, tab 300 size extsel
  box "Queue Files", 20, 7 41 383 228, tab 300
  radio "Drives", 205, 150 18 25 19, hide tab 300
  button "Browse", 206, 180 22 30 10, hide tab 300
  edit "", 207, 220 22 50 10, hide tab 300

  ; // --------------------------------------------- //
  ; // -- Tab(Active Sends/Gets & DCC Tracif Logs-- //
  ; // --------------------------------------------- //
  tab " Active Sends/Gets && DCC Traffic Logs", 400
  ;text "progress bar", 2030, 10 256 377 10, tab 400
  ;text "Progress :", 2001, 10 246 27 10, tab 400
  ;text "", 2002, 95 246 27 9, tab 400
  ;text "Amount Sent:", 2003, 62 246 45 9, tab 400
  ;text "", 2004, 39 246 21 9, tab 400
  ;text "Speed:", 2005, 139 246 19 9, tab 400
  ;text "", 2006, 160 246 100 9, tab 400
  ;list 2028, 7 20 50 81, tab 400 size extsel
  ;list 2029, 58 20 330 81, tab 400 size extsel
  ;link "Refresh list", 2031, 8 105 37 20, tab 400
  list 2034, 10 30 70 96, tab 400 size
  box "DCC Traffic", 2035, 7 22 77 108, tab 400
  box "DCC Information", 2036, 90 22 300 108, tab 400
  text "Nickname:", 2037, 100 35 27 8, tab 400
  text "IP:", 2038, 100 55 25 8, tab 400
  text "Sent/Received:", 2040, 100 65 38 8,tab 400
  text "Path:", 2041, 100 75 25 8,tab 400
  text "Open Time:", 2042, 100 85 29 8,tab 400
  text "Size:", 2043, 100 95 25 8, tab 400
  text "Speed/s:", 2044, 100 105 25 8, tab 400
  text "File Name:", 2045, 100 45 28 8, tab 400
  text "Completion:", 2046, 100 115 32 8, tab 400
  text "", 2047, 140 115 100 9, tab 400
  edit "", 2048, 140 35 100 9, tab 400 read autohs
  edit "", 2049, 140 45 100 9, tab 400 read autohs
  edit "", 2050, 140 55 100 9, tab 400 read autohs
  edit "", 2051, 140 65 100 9, tab 400 read autohs
  edit "", 2052, 140 75 180 9, tab 400 read autohs
  edit "", 2053, 140 85 100 9, tab 400 read autohs
  edit "", 2054, 140 95 100 9, tab 400 read autohs
  edit "", 2055, 140 105 100 9, tab 400 read autohs
  text "%", 2056, 240 115 32 8, tab 400
  list 2057, 11 144 375 97, tab 400 size
  box "DCC Traffic Log", 2058, 7 136 383 130, tab 400
  button "Sent", 2060, 11 244 93 18, tab 400
  button "Recieved", 2061, 106 244 92 18, tab 400
  button "Failed Sends", 2062, 201 244 92 18, tab 400
  button "Failed Gets", 2063, 296 244 90 18, tab 400
  ;list 2064, 8 159 359 82, tab 400 size
  ;list 2065, 8 159 359 82, tab 400 size
  ;list 2066, 8 159 359 82, tab 400 size


  link "faq , help & support of new explorer ", 60, 5 275 89 8
  button "add", 208, 300 274 41 10
  button "", 500, 0 0 0 0
  button "Close", 45, 349 274 41 10, cancel
}
on *:dialog:qmannew:*:*:{
  mdx SetMircVersion $version
  mdx MarkDialog qmannew 

  if ($devent == init) { qmu | did -m $dname 11 | did -e $dname 16,21 | set %qm-sel 1
    set %chanman1 #tsz | set %chanman2 #newbies | /did -c qmannew 205
    did -ra qmannew 2000 you have currently $send(0) active sends and $get(0) active gets | did -ra qmannew 2015 $readini($mircdirSystem\Fserve.ini,Fserve,Max.Queues.Each)
    did -ra qmannew 2016 $readini($mircdirSystem\Fserve.ini,Fserve,Max.Queues.Total) | did -ra qmannew 2018 $readini($mircdirSystem\Fserve.ini,Fserve,Max.Sends.Each)
    did -ra qmannew 2017 $readini($mircdirSystem\Fserve.ini,Fserve,Max.Sends.Total) | did -ra qmannew 2019 $readini($mircdirSystem\Fserve.ini,Fserve,Ad.Delay)
    did -ra qmannew 2020 $readini($mircdirSystem\Fserve.ini,Fserve,Max.Serve) | did -ra qmannew 2021 $readini($mircdirSystem\Fserve.ini,Fserve,Channels) | serverinfo1 | sendnicks
    mdx SetControlMDX qmannew 500 positioner size maxbox minbox > $mircdir $+ dialog.mdx
    mdx SetControlMDX 2047 progressbar smooth > $mircdir $+ Ctl_gen.mdx
    mdx SetControlMDX 2034 treeview haslines showsel hasbuttons > $mircdirviews.mdx
    ;mdx SetColor 2048,2049,2050,2051,2052,2053,2054,2055 textbg $rgb(230,230,208)
    ;mdx SetColor 2048,2049,2050,2051,2052,2053,2054,2055 background $rgb(255,255,255)
    mdx SetControlMDX 2057 Listview report showsel rowselect single > $mircdirviews.mdx
    did -i qmannew 2057 1 headerdims 110:1 150:2 400:3
    did -i qmannew 2057 1 headertext Nickname $chr(9) Date $chr(9) Filename

  }

  if ($devent == sclick) {
    if ($did isnum 17-18) { did -h $dname $queue_grp( [ $replace($remtok(17 18,$did,1,32),$chr(32),$chr(44))  ) | did -v $dname $queue_grp($did) }
    ;if ($did == 3) { queue.del $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) | ques5 }
    if ($did == 3) { .remove qmannew.ini | queue.del $did($dname,2).sel | ques5 }
    if ($did == 1) { .timergtmon* off }
    if ($did == 45) { unset %chanman1 | unset %chanman2 | .timergtmon* off }
    if ($did == 1) { .timergtmon* off }
    if ($did == 300) { .timergtmon* off }
    if ($did == 400) { .timergtmon2 0 1 load.gtmon }
    ;if ($did == 500) { .timergtmon* off }
    if ($did == 100) { mdx SetColor 16 text $rgb(0,191,50) | did -ra $dname 16 $did(100).seltext | writeini qnick.ini nick nick $did(100).seltext }
    if ($did == 2022) { w.set Fserve Max.Queues.Each $vnum($did($dname,2015).text,4) }
    if ($did == 2023) { w.set Fserve Max.Queues.Total $vnum($did($dname,2016).text,10) }
    if ($did == 2024) { w.set Fserve Max.Sends.Each $vnum($did($dname,2018).text,1) }
    if ($did == 2025) { w.set Fserve Max.Sends.Total $vnum($did($dname,2017).text,2) }
    if ($did == 2026) { w.set Fserve Ad.Delay $vnum($did($dname,2012).text,5) }
    if ($did == 2027) { w.set Fserve Max.Serve $vnum($did($dname,2020).text,4) }
    if ($did == 2000) { did -fu qmannew 400 | .timergtmon2 0 1 load.gtmon }
    if ($did == 2028) { minealso }
    if ($did == 2031) { did -ra qmannew 2000 you have $send(0) active sends | did -r qmannew 2028 | did -r qmannew 2029 | .remove sends.ini | mine }
    if ($did == 2032) { did -r qmannew 100 | sendnicks }
    if ($did == 2060) { if ($isfile(dcctrafficsent.txt) == $true) { loadbuf -ro qmannew 2057 dcctrafficsent.txt | mdx SetColor 2057 text $rgb(171,138,226) } }
    if ($did == 2061) { if ($isfile(dcctrafficrecieved.txt) == $true) { loadbuf -ro qmannew 2057 dcctrafficrecieved.txt } }
    if ($did == 2062) { if ($isfile(dcctrafficsendfail.txt) == $true) { loadbuf -ro qmannew 2057 dcctrafficsendfail.txt } }
    if ($did == 2063) { if ($isfile(dcctrafficgetfail.txt) == $true) { loadbuf -ro qmannew 2057 dcctrafficgetfail.txt } }
    if ($did == 2034) {
      if ($did(2034,1,1)) {
        tokenize 32 $did(2034,1,1) 
        if ($5) {
          %gtmons = $calc($4 - 1) $calc($5 - 1)
          loadinf.gtmon %gtmons 
          .timergtmon -m 0 200 loadinf.gtmon %gtmons 
        }
      }
    }
    if ($did == 4) {
      if (($did($dname,2).sel > 1) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        dec %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        .remove qmannew.ini | qmu | ques5
      }
    }
    if ($did == 44) {
      if (($did($dname,2).sel > 1) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        :qmtop
        dec %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        dec %Queue.From
        if (%Queue.To > 1) { goto qmtop }
        .remove qmannew.ini | qmu | ques5
      }
    }
    if ($did == 5) {
      if (($did($dname,2).sel < $did($dname,2).lines) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        inc %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        .remove qmannew.ini | qmu | ques5
      }
    }
    if ($did == 55) {
      if (($did($dname,2).sel < $did($dname,2).lines) && ($did($dname,2).sel isnum)) {
        set %Queue.From $did($dname,2).sel
        set %Queue.To %Queue.From
        :qmbottom
        inc %Queue.To
        set %Queue.tmp %Queue. [ $+ [ %Queue.From ] ]
        %Queue. [ $+ [ %Queue.From ] ] = %Queue. [ $+ [ %Queue.To ] ]
        %Queue. [ $+ [ %Queue.To ] ] = %Queue.tmp
        inc %Queue.From
        if (%Queue.From < $did($dname,2).lines) { goto qmbottom }
        .remove qmannew.ini | qmu | ques5
      }
    }
    if ($did == 30) {
      ;;;if ($did(205).state == 1) { /did -r qmannew 110 | echo 4You have got this amount of files = $findfile($$?="enter other drive name IE c:",$$?="enter a search name IE *.rar or full name",0,did -a qmannew 110 $1-) } | /did -fu qmannew 300
      if ($did(205).state == 1) { /did -r qmannew 110 | echo 4You have got this amount of files = $findfile($sdir(c:\,Choose a directory, or press cancel),*.*,0,did -a qmannew 110 $1-) } | /did -fu qmannew 300
    }
    if ($did == 56 ) {
      if ( $did(2).sel != $null ) {
        dcc send $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] , 2 , 32 ) " $+ $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] , 3- , 32 ) $+ " | did -ra qmannew 2000 you have $send(0) active sends and $get(0) active gets

        ;        queue.Mydel $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35))
      }
    }
    if ($did == 57  ) { 
      if ( %Queue.1 != $null ) {
        dcc send $gettok(%Queue.1,2,32) " $+ $gettok(%Queue.1,3-,32) $+ " | did -ra qmannew 2000 you have $send(0) active sends and $get(0) active gets
        ;        queue.Mydel 1
      }
      ;if ( $send(0) < $r.set(Fserve,Max.Sends.Total)) {
      ;  .timer 1 0 queue.send | .timerquesendTemp 1 2 did -ra $dname 50 $queue(0) $+ / $+ $r.set(Fserve, Max.Queues.Total)
      ;} 
      ;else {
      ; aecho Max Send Exceeded !
      ;}
    }
    if (($did == 2) || ($did == 4) || ($did == 5)) {
      ;qmu
      ;did -f $dname 2 %qm-sel
      did -ra $dname 11 $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,1,32)
      did -ra $dname 16 $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,2,32) 
      did -ra $dname 21 $gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,3-,32)
      var %s = $file($gettok(%Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] ,3-,32)).size
      if %s < 1000 { did -ra $dname 1016 %s B }
      elseif %s < 1000000 { did -ra $dname 1016 $round($calc(%s / 1000),2) KB }
      elseif %s < 1000000000 { did -ra $dname 1016 $round($calc(%s / 1000000),2) MB }
      else { did -ra $dname 1016 $round($calc(%s / 1000000000),2) GB }
    }
    if ($did == 6) { .remove qmannew.ini | %Queue. [ $+ [ $remove($gettok($did($dname,2,$did($dname,2).sel),2,32),$chr(35)) ] ] = $did($dname,11) $did($dname,16) $did($dname,21) | ques5 }
    if ($did == 7) { queue.add Fserve $did($dname,16) $did($dname,21) }
    ;if ($did == 30) { .timer 1 0 did -ra $dname 21 $!$dll(fileselect.dll,FileSelectOld,<directory>) }
    if ($did == 201) { .remove qmannew.ini | ques5 }
    if ($did == 208) { trying | /did -fu qmannew 1 | .remove qmannew.ini | ques5 }
    if ($did == 202) { 
      if ($exists(qmannew.ini) == $false) { echo -a 8 you sent all ques before disconnect }
      elseif ($exists(qmannew.ini) == $true) { restore2 }
    }
    ;if ($did == 204) { ;;;ques5 | ;/writeini -n qmannew5.ini Queue $did($dname,16) $did($dname,21) }
  }
}

on ^*:NOTICE:*:*: {
  if (I Have removed my queues isincs $1-) { .remove qmannew.ini | ques5 }
  if (I Have added some queues isincs $1-) { .remove qmannew.ini | ques5 }
  if (I failed to send the file isincs $1-) { queue.add Fserve $gettok($1-,9,32) $gettok($1-,7,32) | .remove qmannew.ini | ques5 }
}
on *:filercvd:*:{ write " $+ $mircdirdcctrafficrecieved.txt $+ " $nick $chr(9) $fulldate $chr(9) $filename $get($nick).pc $+ % | halt }

on *:FILESENT:*.*:{ .timer 1 1 queue.send | write " $+ $mircdirdcctrafficsent.txt $+ " $nick $chr(9) $fulldate $chr(9) $filename $send($nick).pc $+ % | halt }

on *:SENDFAIL:*.*:{ .timer 1 1 queue.send | notice $me I failed to send the file $filename to $nick | write " $+ $mircdirdcctrafficsendfail.txt $+ " $nick $chr(9) $fulldate $chr(9) $filename $send($nick).pc $+ % | halt }  

on *:GETFAIL:*.*:{ write " $+ $mircdirdcctrafficgetfail.txt $+ " $nick $chr(9) $fulldate $chr(9) $filename $get($nick).pc $+ % | halt }

alias qmu { if ($dialog(qmannew) != $null) { did -r qmannew 2,11,16,21,1016 | set %~qmu 0 | :start | inc %~qmu 1 | if (%Queue. [ $+ [ %~qmu ] ] == $null) { unset %~qmu } | else { did -a qmannew 2 Queue $chr(35) $+ %~qmu | goto start } } }
alias queue.del { if ($isnum($1) == $true) { set -u0 %~queue-dc $calc($1 - 1) | :start | inc %~queue-dc 1 | set %Queue. [ $+ [ %~queue-dc ] ] | if (%Queue. [ $+ [ $calc(%~queue-dc + 1) ] ] == $null) { unset %~queue-dc | qmu } | else { set %Queue. [ $+ [ %~queue-dc ] ] %Queue. [ $+ [ $calc(%~queue-dc + 1) ] ] | goto start } } } 
alias queue.add { queue.exists $1- | if ($result isnum) { return $result } | set -u0 %~queue-ac 0 | :start | inc %~queue-ac 1 | if (%Queue. [ $+ [ %~queue-ac ] ] == $null) { set %Queue. [ $+ [ %~queue-ac ] ] $1- | unset %~queue-ac | qmu } | else { goto start } }
alias queue.exists { set -u0 %~queue-ec 0 | :start | inc %~queue-ec 1 | if (%Queue. [ $+ [ %~queue-ec ] ] != $null) { if (%Queue. [ $+ [ %~queue-ec ] ] == $1-) { return %~queue-ec } | goto start } }

;alias qmu {
;  if ($dialog(qmannew) != $null) {
;    did -r qmannew 2,11,16,21
;    var %i = 1
;    while %i <= $calc( $ini($mircdirqmannew.ini,queues,0) / 3) {
;      did -a qmannew 2 Queue $chr(35) $+ %i
;      inc %i
;    }
;  }
;}

;alias queue.del {
;  var %i = 1
;  var %num = 0
;  while %i <= $calc( $ini($mircdirqmannew.ini,queues,0) / 3) {
;    if $readini($mircdirqmannew.ini,queues,file $+ %i) == $3- && $readini($mircdirqmannew.ini,queues,system $+ %i) == $2 && $readini($mircdirqmannew.ini,queues,nick $+ %i) == $1 {
;      %num = %i
;    }
;    inc %i
;  }
;  if %num != 0 {
;    var %i = %num
;    var %num = $calc( $ini($mircdirqmannew.ini,queues,0) / 3)
;    while %i <= %num {
;      /remini $mircdirqmannew.ini queues file $+ %i
;      /remini $mircdirqmannew.ini queues nick $+ %i
;      /remini $mircdirqmannew.ini queues system $+ %i
;      if %i < %num {
;        /writeini $mircdirqmannew.ini queues file $+ %i $readini($mircdirqmannew.ini,queues,file $+ $calc(%i + 1))
;        /writeini $mircdirqmannew.ini queues nick $+ %i $readini($mircdirqmannew.ini,queues,nick $+ $calc(%i + 1))
;        /writeini $mircdirqmannew.ini queues system $+ %i $readini($mircdirqmannew.ini,queues,system $+ $calc(%i + 1))
;      }
;      inc %i
;    }
;  }
;}

;alias queue.add {
;  var %i = $calc( $ini($mircdirqmannew.ini,queues,0) / 3)
;
;  /writeini $mircdirqmannew.ini queues nick $+ $calc(%i + 1) $1
;  /writeini $mircdirqmannew.ini queues system $+ $calc(%i + 1) $2
;  /writeini $mircdirqmannew.ini queues file $+ $calc(%i + 1) $3-
;}

;alias queue.exists {
;  var %exists = $false
;  var %i = 1
;  while %i <= $calc( $ini($mircdirqmannew.ini,queues,0) / 3) {
;    if $readini($mircdirqmannew.ini,queues,file $+ %i) == $3- && $readini($mircdirqmannew.ini,queues,system $+ %i) == $2 && $readini($mircdirqmannew.ini,queues,nick $+ %i) == $1 {
;      %exists = $true
;    }
;    inc %i
;  }
;  return %exists
;}

alias serverinfo1 {
  /mdx SetColor qmannew 2015,2016,2017,2018,2019,2020,2021 background $rgb(0,200,50) | /mdx SetColor qmannew 2015,2016,2017,2018,2019,2020,2021 textbg $rgb(0,200,50) 
}
alias trying {
  /tokenize $asc($tab) $did($dname,110,$did($dname,110).sel).text
  if ($gettok($2,5-,32) != DIR) {
    /var %sel = 1
    while  ( %sel <= $did($dname,110,0).sel ) {
      /tokenize $asc($tab) $did($dname,110,$did($dname,110,%sel).sel).text
      ;;var %qnick = $did($dname,16) 
      var %filename = $gettok($1,1-,32)
      if $filtered == 0 {
        ;;/write all.txt %qnick %filename 
      }
      ;else {
      ;var %read = $read(all.txt,-nw, * $+ %filename $+ *)
      ;%read = $puttok(%read,$did(qmannew,22).text,5,$asc(:))
      ;%read = $puttok(%read,$did(qmannew,24).text,6,$asc(:))
      ;/write -l $gettok($did(qmannew,48,1).text,1,32) manager1.txt %read
      ;}
      queue.add Fserve $gettok($readini(qnick.ini,nick,nick),1,61) %filename
      /inc %sel
    }
    ;;.msg = $+ $did($dname,3).text queues
  }
  else { .msg = $+ $did($dname,16).text cd $gettok($1,6-,32) | did -r $dname 110 | /unset %countdir | .msg = $+ $did($dname,16).text dir }
}
alias restore2 {
  var %lines = $ini(qmannew.ini,0)
  var %i = 1
  while %i <= %lines {
    ;echo -a $readini($gettok(qmannew.ini Queue $+ %i),1,61))
    queue.add Fserve $gettok($readini(qmannew.ini,Queue $+ %i,Fserve),1,61) 
    echo -a 8ques set before disconnect are Queue $+ %i $gettok($readini(qmannew.ini,Queue $+ %i,Fserve),1,61) 
    inc %i
  }
  ;did -c qmannew 203 1
}
alias ques5 {
  var %i = 0
  while %i <= 1000 {
    if (%Queue. [ $+ [ %i ] ] ) {
      ;;;/write qmannew5.txt Queue %i %Queue. [ $+ [ %i ] ] 
      /writeini -n qmannew.ini Queue $+ %i %Queue. [ $+ [ %i ] ]
      ;;;/write qmannew.txt Queue $+ %i %Queue. [ $+ [ %i ] ] 
    }
    inc %i
  }
}
alias sendnicks {
  mdx SetColor 100 text $rgb(245,0,0)
  var %nickman1 = $nick(%chanman1,0)
  while (%nickman1) { 
    did -a qmannew 100 $nick(%chanman1,%nickman1) 
    dec %nickman1
  }

  var %nickman2 = $nick(%chanman2,0)
  while (%nickman2) {
    if ( $didwm($dname,100,$nick(%chanman2,%nickman2),1) == 0 ) {
      did -a qmannew 100 $nick(%chanman2,%nickman2) 
    }
    dec %nickman2 
  }
}
alias load.gtmon {
  did -r qmannew 2034
  did -i qmannew 2034 1 cb root
  did -a qmannew 2034 +eb 1 1 DCC Sends
  did -i qmannew 2034 1 cb last
  var %x = 1 | while ($send(%x)) { did -a qmannew 2034 + 2 2 $send(%x) | inc %x } | unset %x
  did -i qmannew 2034 1 cb root
  did -a qmannew 2034 +eb 3 3 DCC Gets
  did -i qmannew 2034 1 cb last
  var %x = 1 | while ($get(%x)) { did -a qmannew 2034 + 4 4 $get(%x) | inc %x } | unset %x
}

alias loadinf.gtmon {
  if ($1 == 1) {
    mdx SetColor 2048,2049,2050,2051,2052,2053,2054,2055,2056 text $rgb(245,0,0)
    did -a qmannew 2047 BarColor $rgb(245,0,0)
    did -ra qmannew 2040 Sent
    did -ra qmannew 2048 $send($2)
    did -ra qmannew 2049 $send($2).file
    did -ra qmannew 2050 $send($2).ip
    did -ra qmannew 2051 $bytes($send($2).sent,k) kb
    did -ra qmannew 2052 $send($2).path $+ $send($2).file
    did -ra qmannew 2053 $duration($send($2).secs)
    did -ra qmannew 2054 $bytes($send($2).size,k) kb
    did -ra qmannew 2055 $bytes($send($2).cps,k) kb
    did -ra qmannew 2056 $send($2).pc $+ %
    did -a qmannew 2047 $send($2).sent 0 $send($2).size
  }
  else if ($1 == 2) {
    mdx SetColor 2048,2049,2050,2051,2052,2053,2054,2055,2056 text $rgb(0,0,250)
    did -a qmannew 2047 BarColor $rgb(0,138,0)
    did -ra qmannew 2040 Received
    did -ra qmannew 2048 $get($2)
    did -ra qmannew 2049 $get($2).file
    did -ra qmannew 2050 $get($2).ip
    did -ra qmannew 2051 $bytes($get($2).rcvd,k) kb
    did -ra qmannew 2052 $get($2).path $+ $get($2).file
    did -ra qmannew 2053 $duration($get($2).secs) secs
    did -ra qmannew 2054 $bytes($get($2).size,k) kb
    did -ra qmannew 2055 $bytes($get($2).cps,k) kb
    did -ra qmannew 2056 $get($2).pc $+ %
    did -a qmannew 2047 $get($2).rcvd 0 $get($2).size
  }
}


;--------
;alias mineto {
;.timerminealso -om 0 500 minealso 
;.timerminealso -m 0 5 did -a qmannew 2030 $send($gettok($did($dname,2028).seltext,2,32)).pc 0 99 | did -a qmannew 2004 $send($gettok($did($dname,2028).seltext,2,32)).pc $+ % | did -a qmannew 2006 $round($calc($send($gettok($did($dname,2028).seltext,2,32)).cps / 1024),2) K $+ / $+ s | did -a qmannew 2002 $bytes($send($gettok($did($dname,2028).seltext,2,32)).sent,m3).suf
;}
;alias minealso {
;echo %send $+ $did($dname,2028).seltext
;if $did($dname,2028).seltext $1- {
;did -a qmannew 2004 $send($gettok($did($dname,2028).seltext,2,32)).pc $+ % 
;did -a qmannew 2006 $round($calc($send($gettok($did($dname,2028).seltext,2,32)).cps / 1024),2) K $+ / $+ s 
;did -a qmannew 2002 $bytes($send($gettok($did($dname,2028).seltext,2,32)).sent,m3).suf 
;did -a qmannew 2030 $send($gettok($did($dname,2028).seltext,2,32)).pc 0 99
;}
;else {
;/did -a qmannew 2030 0
;/did -r qmannew 2004,2006,2002
;/halt
;}

;}
;alias mine {
;echo -a $send(0)
;if ($send(0) == 0) { halt }
;var %i 1
;while (%i <= $send(0)) {
;var %sent $send(%i).sent
;var %total $send(%i).size
;var %speed $send(%i).cps
;var %eta $duration($calc((%total - %sent) / %speed))
;/writeini -n sends.ini $send(%i) $+ %i File $send(%i).path $+ $send(%i).file To $send(%i) Size $bytes($send(%i).size,m3).suf
;did -a qmannew 2029 File $send(%i).path $+ $send(%i).file Size $bytes($send(%i).size,m3).suf ETA %eta 
;;Sent $bytes($send(%i).sent,m3).suf Done $send(%i).pc Rate $round($calc($send(%i).cps / 1024),2) K $+ / $+ s  
;did -a qmannew 2028 $send(%i) %i | set % $+ $send(%i) %i
;inc %i
;}
;}
