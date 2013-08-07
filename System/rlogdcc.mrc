dialog dl {
  size -1 -1 630 300
  title "Log Manager 2002 ©The Playstation Area"
  button "Close",1, 525 260 75 20, OK default
  tab "Downloaded",200, 5 5 620 290
  tab "Sended",201
  tab "Failed Gets",202
  tab "Failed Sends",203

  box "Downloaded Files",2, 15 33 600 200, tab200
  list 3, 20 49 590 195, tab200 extsel
  text "Total Downloaded:",5, 440 240 120 20, tab200
  text "- Double-Click a line to view that file.",7, 16 260 230 20, tab200
  edit "",6, 545 235 55 20, autohs center read, tab200
  button "Clear All",4, 435 260 75 20, tab200 default
  button "Delete File",36, 345 260 75 20, tab200 default

  box "Uploaded Files",10, 15 33 600 200, tab201
  list 11, 20 49 590 195, tab201
  button "Clear All",12, 435 260 75 20, tab201 default
  text "Total Uploaded:",13, 450 240 110 20, tab201
  edit "",14, 545 235 55 20, autohs center read, tab201

  box "Failed Downloads",20, 15 33 600 200, tab202
  list 21, 20 49 590 195, tab202
  button "Clear All",22, 435 260 75 20, tab202 default
  text "Total Failed Downloads:",23, 410 240 150 20, tab202
  edit "",24, 545 235 55 20, autohs center read, tab202
  ;  text "TpA",25, 16 235 180 20, tab202

  box "Failed Uploads",30, 15 33 600 200, tab203
  list 31, 20 49 590 195, tab203
  button "Clear All",32, 435 260 75 20, tab203 default
  text "Total Failed Uploads:",33, 420 240 140 20, tab203
  edit "",34, 545 235 55 20, autohs center read, tab203
  ;  text "TpA",35, 16 235 180 20, tab203
}
alias memostart {
  set %tempMemo 0
  :loop
  inc %tempMemo 1
  if ($read -l $+ %tempMemo %MemoTxt == $null) { goto end }
  .memoserv send $read -l $+ %tempMemo %MemoTxt %MemoMsg
  goto loop
  :end
}
alias refresh_dl { 
  if (%tempdl == $null) { set %rcvd.d 0 }
  did -r dl 3
  did -ra $dname 6 $lines(system\downloads.txt) 
  set %tempdl 0
  :loop
  inc %tempdl 1
  if ($read -l $+ %tempdl system\downloads.txt == $null) { goto end }
  did -a dl 3 $read -l $+ %tempdl system\downloads.txt
  goto loop
  :end
  did -c dl 3 1

}
on *:dialog:dl:init:0: {
  if (%tempdl == $null) { set %rcvd.d 0 }
  did -ra $dname 6 $lines(system\downloads.txt) 
  set %tempdl 0
  :loop
  inc %tempdl 1
  if ($read -l $+ %tempdl system\downloads.txt == $null) { goto end }
  did -a dl 3 $read -l $+ %tempdl system\downloads.txt
  goto loop
  :end
  unset %tempdl
  if (%tempul == $null) { set %upd.d 0 }
  did -ra $dname 14 $lines(system\uploads.txt) 
  set %tempdl 0
  :loop2
  inc %tempdl 1
  if ($read -l $+ %tempdl system\uploads.txt == $null) { goto end2 }
  did -a dl 11 $read -l $+ %tempdl system\uploads.txt
  goto loop2
  :end2
  unset %tempdl
  if (%tempfaildl == $null) { set %fail.dl 0 }
  did -ra $dname 24 $lines(system\failget.txt) 
  set %tempdl 0
  :loop3
  inc %tempdl 1
  if ($read -l $+ %tempdl system\failget.txt == $null) { goto end3 }
  did -a dl 21 $read -l $+ %tempdl system\failget.txt
  goto loop3
  :end3
  unset %tempdl
  if (%tempfailsend == $null) { set %fail.send 0 }
  did -ra $dname 34 $lines(system\failsend.txt) 
  set %tempdl 0
  :loop4
  inc %tempdl 1
  if ($read -l $+ %tempdl system\failsend.txt == $null) { goto end4 }
  did -a dl 31 $read -l $+ %tempdl system\failsend.txt
  goto loop4
  :end4
  unset %tempdl
}
on *:dialog:dl:dclick:*: { 
  if ($did == 3) { 
    if ($right($gettok($did($dname,3,$did(3).sel).text,7-,32),4) == .nfo) { run $mircdirtools\nfoviewer\nfoviewer $shortfn($gettok($did($dname,3,$did(3).sel).text,7-,32)) }
    elseif ($right($gettok($did($dname,3,$did(3).sel).text,7-,32),4) == .sfv) { run $mircdirtools\pdsfv\pdsfv $shortfn($gettok($did($dname,3,$did(3).sel).text,7-,32)) }
    else run $gettok($did($dname,3,$did(3).sel).text,7-,32)
  } 
}
on *:dialog:dl:sclick:*: { 
  if ($did == 4) { write -c system\downloads.txt | did -r dl 3 | set %rcvd.d 0 | did -ra $dname 6 %rcvd.d } 
  if ($did == 12) { write -c system\uploads.txt | did -r dl 11 | set %upd 0 | did -ra $dname 14 %upd }
  if ($did == 22) { write -c system\failget.txt | did -r dl 21 | set %fail.dl 0 | did -ra $dname 24 %fail.dl }
  if ($did == 32) { write -c system\failsend.txt | did -r dl 31 | set %fail.send 0 | did -ra $dname 34 %fail.send }
  if ($did == 36) { if ($?!="Are you sure you want to delete this file? $crlf If you press YES, this file completly removed.") {
      remove $gettok($did($dname,3,$did(3).sel).text,7-,32)
      write -dl $+ $did($dname,3).sel system\downloads.txt 
      refresh_dl
    }
  }  
}

;  alias size {
;    if ($1- == $null) { return N/A }
;    if ($1- !isnum) { var %size = $lof($1-) } | else { var %size = $1- }
;    if (%size <= 1024) { return %size Bytes }
;    set %size $calc(%size / 1024)
;    if %size < 1000 { return $round(%size,0) $+ Kb }
;    set %size $calc(%size / 1024)
;    if %size < 1000 { return $round(%size,2) $+ Mb }
;    set %size $calc(%size / 1024)
;    if %size < 1000 { return $round(%size,3) $+ Gb }
;    set %size $calc(%size / 1024)
;    if %size < 1000 { return $round(%size,3) $+ Tb }
;    set %size $calc(%size / 1024)
;    if %size < 1000 { return $round(%size,3) $+ Pb }
;    return Unknown
;  }

dialog sentc {
  title "2001 Preset Sentences"
  size -1 -1 580 360
  text "You can create your own sentences so that MIRC will store these sentences into its memory. This makes things easier for you when you always need to type the same sentence to the different people." ,1,10 10 450 40,style(left)
  box "Please fill in your sentences: ",50,10 53 530 275,style
  text "Sentence 1:",2,20 70 65 20,style(left)
  combo 3,85 70 445 20,style(edit)
  text "Sentence 2:",4,20 95 65 20,style(left)
  combo 5,85 95 445 20,style(edit)
  text "Sentence 3:",6,20 120 65 20,style(left)
  combo 7,85 120 445 20,style(edit)
  text "Sentence 4:",8,20 145 65 20,style(left)
  combo 9,85 145 445 20,style(edit)
  text "Sentence 5:",10,20 170 65 20,style(left)
  combo 11,85 170 445 20,style(edit)
  text "Sentence 6:",12,20 195 65 20,style(left)
  combo 13,85 195 445 20,style(edit)
  text "Sentence 7:",14,20 220 65 20,style(left)
  combo 15,85 220 445 20,style(edit)
  text "Sentence 8:",16,20 245 65 20,style(left)
  combo 17,85 245 445 20,style(edit)
  text "Sentence 9:",18,20 270 65 20,style(left)
  combo 19,85 270 445 20,style(edit)
  text "Sentence 10:",20,20 295 65 20,style(left)
  combo 21,85 295 445 20,style(edit)
  button "Clear all",82,310 335 70 20,style(edit)
  button "Save",80,390 335 70 20,style(ok)
  button "Cancel",81,470 335 70 20,style(cancel)
}
on 1:dialog:sentc:*:80:{
  if ($did(sentc,3).text != Type your sentence here) { set %sentence1 $did(sentc,3).text }
  if ($did(sentc,5).text != Type your sentence here) { set %sentence2 $did(sentc,5).text }
  if ($did(sentc,7).text != Type your sentence here) { set %sentence3 $did(sentc,7).text }
  if ($did(sentc,9).text != Type your sentence here) { set %sentence4 $did(sentc,9).text }
  if ($did(sentc,11).text != Type your sentence here) { set %sentence5 $did(sentc,11).text }
  if ($did(sentc,13).text != Type your sentence here) { set %sentence6 $did(sentc,13).text }
  if ($did(sentc,15).text != Type your sentence here) { set %sentence7 $did(sentc,15).text }
  if ($did(sentc,17).text != Type your sentence here) { set %sentence8 $did(sentc,17).text }
  if ($did(sentc,19).text != Type your sentence here) { set %sentence9 $did(sentc,19).text }
  if ($did(sentc,20).text != Type your sentence here) { set %sentence10 $did(sentc,21).text }
  if ($did(sentc,3).text == Type your sentence here) { unset %sentence1 }
  if ($did(sentc,5).text == Type your sentence here) { unset %sentence2 }
  if ($did(sentc,7).text == Type your sentence here) { unset %sentence3 }
  if ($did(sentc,9).text == Type your sentence here) { unset %sentence4 }
  if ($did(sentc,11).text == Type your sentence here) { unset %sentence5 }
  if ($did(sentc,13).text == Type your sentence here) { unset %sentence6 }
  if ($did(sentc,15).text == Type your sentence here) { unset %sentence7 }
  if ($did(sentc,17).text == Type your sentence here) { unset %sentence8 }
  if ($did(sentc,19).text == Type your sentence here) { unset %sentence9 }
  if ($did(sentc,21).text == Type your sentence here) { unset %sentence10 }

}
on 1:dialog:sentc:*:79: {
  userinfo
}
on 1:dialog:sentc:*:82: {
  unset %sentence1
  unset %sentence2
  unset %sentence3
  unset %sentence4
  unset %sentence5
  unset %sentence6
  unset %sentence7
  unset %sentence8
  unset %sentence9
  unset %sentence10
  did -ci sentc 3 1 Type your sentence here
  did -ci sentc 5 1 Type your sentence here
  did -ci sentc 7 1 Type your sentence here
  did -ci sentc 9 1 Type your sentence here
  did -ci sentc 11 1 Type your sentence here
  did -ci sentc 13 1 Type your sentence here
  did -ci sentc 15 1 Type your sentence here
  did -ci sentc 17 1 Type your sentence here
  did -ci sentc 19 1 Type your sentence here
  did -ci sentc 21 1 Type your sentence here
}
