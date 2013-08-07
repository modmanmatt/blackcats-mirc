dialog dl {
  size -1 -1 630 300
  ;title "Log Manager 2002 ©The Playstation Area"
  title "Log Manager 2004 @The Sharing Zone"
  button "Close",1, 525 260 75 20, OK default
  tab "Recieved",200, 5 5 620 290
  tab "Sent",201
  tab "Failed Gets",202
  tab "Failed Sends",203

  box "Downloaded Files",2, 15 33 600 200, tab200
  list 3, 20 49 590 195, tab200 extsel
  text "Total Downloaded:",5, 440 240 120 20, tab200
  text "- Double-Click a line to view that file.",7, 16 260 230 20, tab200
  edit "",6, 545 235 55 20, autohs center read, tab200
  button "Clear all",4, 435 260 75 20, tab200 default
  ;button "Delete File",36, 345 260 75 20, tab200 default

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

on *:dialog:dl:init:0: {

  mdx SetMircVersion $version
  mdx MarkDialog dl

  mdx SetControlMDX 3 Listview report showsel rowselect single > $mircdirviews.mdx
  did -i dl 3 1 headerdims 110:1 150:2 300:3
  did -i dl 3 1 headertext Nickname $chr(9) Date $chr(9) Filename

  mdx SetControlMDX 11 Listview report showsel rowselect single > $mircdirviews.mdx
  did -i dl 11 1 headerdims 110:1 150:2 300:3
  did -i dl 11 1 headertext Nickname $chr(9) Date $chr(9) Filename

  mdx SetControlMDX 21 Listview report showsel rowselect single > $mircdirviews.mdx
  did -i dl 21 1 headerdims 110:1 150:2 300:3
  did -i dl 21 1 headertext Nickname $chr(9) Date $chr(9) Filename

  mdx SetControlMDX 31 Listview report showsel rowselect single > $mircdirviews.mdx
  did -i dl 31 1 headerdims 110:1 150:2 300:3
  did -i dl 31 1 headertext Nickname $chr(9) Date $chr(9) Filename

  loadbuf -o $dname 3 $mircdirdcctrafficrecieved.txt
  /did -ra $dname 6 $lines($mircdirdcctrafficrecieved.txt)

  loadbuf -o $dname 11 $mircdirdcctrafficsent.txt
  /did -ra $dname 14 $lines($mircdirdcctrafficsent.txt)

  loadbuf -o $dname 21 $mircdirdcctrafficgetfail.txt
  /did -ra $dname 24 $lines($mircdirdcctrafficgetfail.txt)

  loadbuf -o $dname 31 $mircdirdcctrafficsendfail.txt
  /did -ra $dname 34 $lines($mircdirdcctrafficsendfail.txt)

}

on *:dialog:dl:dclick:*: { 
  if ($did == 3 && $isfile($gettok($did($dname,3,$did(3).sel).text,7-,32))) { 
    if ($right($gettok($did($dname,3,$did(3).sel).text,7-,32),4) == .nfo) { run $mircdirtools\nfoviewer\nfoviewer $shortfn($gettok($did($dname,3,$did(3).sel).text,7-,32)) }
    elseif ($right($gettok($did($dname,3,$did(3).sel).text,7-,32),4) == .sfv) { run $mircdirtools\pdsfv\pdsfv $shortfn($gettok($did($dname,3,$did(3).sel).text,7-,32)) }
    else run $gettok($did($dname,3,$did(3).sel).text,7-,32)
  } 
}

on *:dialog:dl:sclick:*: { 
  if ($did == 4) { 
    write -c $mircdirdcctrafficrecieved.txt
    did -r dl 3
    loadbuf -o $dname 3 $mircdirdcctrafficrecieved.txt
    /did -ra $dname 6 $lines($mircdirdcctrafficrecieved.txt)
  } 
  elseif ($did == 12) { 
    write -c $mircdirdcctrafficsent.txt
    did -r dl 11
    loadbuf -o $dname 11 $mircdirdcctrafficsent.txt
    /did -ra $dname 14 $lines($mircdirdcctrafficsent.txt)
  }
  elseif ($did == 22) {
    write -c $mircdirdcctrafficgetfail.txt
    did -r dl 21
    loadbuf -o $dname 21 $mircdirdcctrafficgetfail.txt
    /did -ra $dname 24 $lines($mircdirdcctrafficgetfail.txt)
  }
  elseif ($did == 32) {
    write -c $mircdirdcctrafficsendfail.txt
    did -r dl 31
    loadbuf -o $dname 31 $mircdirdcctrafficsendfail.txt
    /did -ra $dname 34 $lines($mircdirdcctrafficsendfail.txt)
  }
  ;  elseif ($did == 36) {
  ;    if $isfile($gettok($did($dname,3,$did(3).sel).text,7-,32)) {
  ;      if ($?!="Are you sure you want to delete this file? $crlf If you press YES, this file completly removed.") {
  ;        remove $gettok($did($dname,3,$did(3).sel).text,7-,32)
  ;        write -dl $+ $did($dname,3).sel system\downloads.txt 
  ;        loadbuf -o $dname 3 $mircdirdcctrafficrecieved.txt
  ;        /did -ra $dname 6 $lines($mircdirdcctrafficrecieved.txt)
  ;      }
  ;    }
  ;  }  
}

