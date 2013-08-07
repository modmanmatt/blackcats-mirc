alias fserve_config {
  /dialog -mravd fserve fserve
}
dialog fserve {
  title "Fserv Trigger Setup"
  size -1 -1 577 345
  option pixels
  tab "General", 1, 5 4 572 315
  button "xdcc-serv", 2000, 20 30 65 23, tab 1
  box "Max Sends:", 13, 118 185 83 74, tab 1
  text "Each:", 14, 128 208 35 13, tab 1
  edit "", 15, 163 205 28 22, tab 1
  text "Total:", 16, 128 230 35 13, tab 1
  edit "", 17, 163 227 28 22, tab 1
  box "Max Queues:", 18, 118 110 83 74, tab 1
  text "Each:", 19, 128 133 35 13, tab 1
  edit "", 20, 163 130 28 22, tab 1
  text "Total:", 21, 128 155 35 13, tab 1
  edit "", 22, 163 152 28 22, tab 1
  check "Enable on Start", 23, 120 60 100 15, disable tab 1
  text "Max Users:", 24, 244 88 60 13, tab 1
  edit "", 25, 300 86 28 22, tab 1
  text "Ad Delay:", 26, 250 60 75 13, tab 1
  edit "", 27, 300 58 28 22, tab 1
  text "Note:", 28, 80 284 30 13, tab 1
  edit "", 29, 110 281 285 22, tab 1
  box "Advertising Channels:", 30, 211 110 180 140, tab 1
  combo 31, 221 130 115 100, tab 1
  check "All Channels", 32, 221 227 80 15, tab 1
  button "Add", 33, 341 157 40 22, tab 1
  button "Rem", 34, 341 179 40 22, tab 1
  check "Enabled", 35, 145 80 60 15, hide tab 1
  text "Trigger:", 36, 100 80 35 13, hide tab 1
  check "Fserv started", 37, 120 36 100 20, tab 1
  tab "Trigger 1", 2
  check "Enabled", 200, 300 30 60 15, disable tab 2
  text "newbies:", 201, 255 30 40 13, disable tab 2
  edit "", 202, 99 50 280 23, disable tab 2
  box "Sharing directory 1", 203, 100 110 280 100, tab 2
  text "Root:", 204, 105 125 100 13, tab 2
  edit "", 205, 110 138 240 22, tab 2 autohs
  button "...", 206, 355 139 20 20, disable tab 2
  text "Welcome File:", 207, 105 165 100 13, tab 2
  edit "", 208, 110 178 240 22, tab 2 autohs
  button "...", 209, 355 179 20 20, tab 2
  check "Enabled", 210, 145 30 60 15, disable tab 2
  text "Trigger:", 211, 100 30 35 13, disable tab 2
  text "Incoming directory should be changed in mirc option. Goto main menu->View options... then go to the DCC tab->Folders and edit the default folder to the directory you want to have as a incoming directory.", 38, 390 118 180 94, tab 2
  tab "Trigger 2", 3
  check "Enabled", 300, 300 30 60 15, tab 3
  text "newbies:", 301, 255 30 40 13, tab 3
  edit "", 302, 99 50 280 23, tab 3
  box "Sharing directory 2", 303, 100 110 280 100, tab 3
  text "Root:", 304, 105 125 100 13, tab 3
  edit "", 305, 110 138 240 22, tab 3 autohs
  button "...", 306, 355 139 20 20, tab 3
  text "Welcome File:", 307, 105 165 100 13, tab 3
  edit "", 308, 110 178 240 22, tab 3 autohs
  button "...", 309, 355 179 20 20, tab 3
  check "Enabled", 310, 145 30 60 15, tab 3
  text "Trigger:", 311, 100 30 35 13, tab 3
  tab "Trigger 3", 4
  check "Enabled", 400, 300 30 60 15, tab 4
  text "newbies:", 401, 255 30 40 13, tab 4
  edit "", 402, 99 50 280 23, tab 4
  box "Sharing directory 3", 403, 100 110 280 100, tab 4
  text "Root:", 404, 105 125 100 13, tab 4
  edit "", 405, 110 138 240 22, tab 4 autohs
  button "...", 406, 355 139 20 20, tab 4
  text "Welcome File:", 407, 105 165 100 13, tab 4
  edit "", 408, 110 178 240 22, tab 4 autohs
  button "...", 409, 355 179 20 20, tab 4
  check "Enabled", 410, 145 30 60 15, tab 4
  text "Trigger:", 411, 100 30 35 13, tab 4
  tab "Trigger 4", 5
  check "Enabled", 500, 300 30 60 15, tab 5
  text "newbies:", 501, 255 30 40 13, tab 5
  edit "", 502, 99 50 280 23, tab 5
  box "Sharing directory 4", 503, 100 110 280 100, tab 5
  text "Root:", 504, 105 125 100 13, tab 5
  edit "", 505, 110 138 240 22, tab 5 autohs
  button "...", 506, 355 139 20 20, tab 5
  text "Welcome File:", 507, 105 165 100 13, tab 5
  edit "", 508, 110 178 240 22, tab 5 autohs
  button "...", 509, 355 179 20 20, tab 5
  check "Enabled", 510, 145 30 60 15, tab 5
  text "Trigger:", 511, 100 30 35 13, tab 5
  tab "Trigger 5", 6
  check "Enabled", 600, 300 30 60 15, tab 6
  text "newbies:", 601, 255 30 40 13, tab 6
  edit "", 602, 99 50 280 23, tab 6
  box "Sharing directory 5", 603, 100 110 280 100, tab 6
  text "Root:", 604, 105 125 100 13, tab 6
  edit "", 605, 110 138 240 22, tab 6 autohs
  button "...", 606, 355 139 20 20, tab 6
  text "Welcome File:", 607, 105 165 100 13, tab 6
  edit "", 608, 110 178 240 22, tab 6 autohs
  button "...", 609, 355 179 20 20, tab 6
  check "Enabled", 610, 145 30 60 15, tab 6
  text "Trigger:", 611, 100 30 35 13, tab 6
  tab "Trigger 6", 7
  check "Enabled", 700, 300 30 60 15, tab 7
  text "newbies:", 701, 255 30 40 13, tab 7
  edit "", 702, 99 50 280 23, tab 7
  box "Sharing directory 6", 703, 100 110 280 100, tab 7
  text "Root:", 704, 105 125 100 13, tab 7
  edit "", 705, 110 138 240 22, tab 7 autohs
  button "...", 706, 355 139 20 20, tab 7
  text "Welcome File:", 707, 105 165 100 13, tab 7
  edit "", 708, 110 178 240 22, tab 7 autohs
  button "...", 709, 355 179 20 20, tab 7
  check "Enabled", 710, 145 30 60 15, tab 7
  text "Trigger:", 711, 100 30 35 13, tab 7
  tab "Trigger 7", 8
  check "Enabled", 800, 300 30 60 15, tab 8
  text "newbies:", 801, 255 30 40 13, tab 8
  edit "", 802, 99 50 280 23, tab 8
  box "Sharing directory 7", 803, 100 110 280 100, tab 8
  text "Root:", 804, 105 125 100 13, tab 8
  edit "", 805, 110 138 240 22, tab 8 autohs
  button "...", 806, 355 139 20 20, tab 8
  text "Welcome File:", 807, 105 165 100 13, tab 8
  edit "", 808, 110 178 240 22, tab 8 autohs
  button "...", 809, 355 179 20 20, tab 8
  check "Enabled", 810, 145 30 60 15, tab 8
  text "Trigger:", 811, 100 30 35 13, tab 8
  tab "Trigger 8", 9
  check "Enabled", 900, 300 30 60 15, tab 9
  text "newbies:", 901, 255 30 40 13, tab 9
  edit "", 902, 99 50 280 23, tab 9
  box "Sharing directory 8", 903, 100 110 280 100, tab 9
  text "Root:", 904, 105 125 100 13, tab 9
  edit "", 905, 110 138 240 22, tab 9 autohs
  button "...", 906, 355 139 20 20, tab 9
  text "Welcome File:", 907, 105 165 100 13, tab 9
  edit "", 908, 110 178 240 22, tab 9 autohs
  button "...", 909, 355 179 20 20, tab 9
  check "Enabled", 910, 145 30 60 15, tab 9
  text "Trigger:", 911, 100 30 35 13, tab 9
  tab "Trigger 9", 10
  check "Enabled", 1000, 300 30 60 15, tab 10
  text "newbies:", 1001, 255 30 40 13, tab 10
  edit "", 1002, 99 50 280 23, tab 10
  box "Sharing directory 9", 1003, 100 110 280 100, tab 10
  text "Root:", 1004, 105 125 100 13, tab 10
  edit "", 1005, 110 138 240 22, tab 10 autohs
  button "...", 1006, 355 139 20 20, tab 10
  text "Welcome File:", 1007, 105 165 100 13, tab 10
  edit "", 1008, 110 178 240 22, tab 10 autohs
  button "...", 1009, 355 179 20 20, tab 10
  check "Enabled", 1010, 145 30 60 15, tab 10
  text "Trigger:", 1011, 100 30 35 13, tab 10
  tab "Trigger 10", 11
  check "Enabled", 1100, 216 37 60 15, tab 11
  text "newbies:", 1101, 171 37 40 13, tab 11
  edit "", 1102, 15 57 280 23, tab 11
  box "Sharing directory 10", 1103, 16 117 280 100, tab 11
  text "Root:", 1104, 21 132 100 13, tab 11
  edit "", 1105, 26 145 240 22, tab 11 autohs
  button "...", 1106, 271 146 20 20, tab 11
  text "Welcome File:", 1107, 21 172 100 13, tab 11
  edit "", 1108, 26 185 240 22, tab 11 autohs
  button "...", 1109, 271 186 20 20, tab 11
  check "Enabled", 1110, 61 37 60 15, tab 11
  text "Trigger:", 1111, 16 37 35 13, tab 11
  box "Trigger specific advertise channels", 39, 368 39 197 255, tab 11
  check "Use generel advertise channels", 40, 377 173 179 18, tab 11
  combo 41, 378 62 152 106, tab 11 size
  button "+", 42, 536 62 20 20, tab 11
  button "-", 43, 536 85 20 20, tab 11
  text "Check the 'Use general advertise channels' if you want the advertise channels to be the ones in general tab. You can use + and - infornt of channels if you want add or remove advertise channels from the general ones", 44, 376 195 179 98, tab 11
  tab "Stats", 12
  box "Stats:", 1265, 115 174 241 140, tab 12
  text "Record CPS:", 1270, 125 197 65 13, tab 12
  edit "", 1271, 200 193 146 22, tab 12 center
  text "Bytes Sent:", 1272, 125 219 65 13, tab 12
  edit "", 1273, 200 216 146 22, tab 12 center
  text "Files Sent:", 1274, 125 231 65 13, tab 12
  edit "", 1275, 200 238 146 22, tab 12 center
  text "Failed Sends:", 1276, 125 263 65 13, tab 12
  edit "", 1277, 200 260 146 22, tab 12 center
  text "Accessed:", 1278, 125 285 65 13, tab 12
  edit "", 1279, 200 283 146 22, tab 12 center
  box "Reset", 1285, 183 51 105 127, tab 12
  check "Record CPS", 1286, 191 68 90 20, tab 12 push
  check "Bytes Sent", 1287, 191 88 90 20, tab 12 push
  check "Files Sent", 1288, 191 108 90 20, tab 12 push
  check "Failed Sends", 1289, 191 128 90 20, tab 12 push
  check "Accessed", 1290, 191 148 90 20, tab 12 push
  button "OK", 100, 100 319 65 23, ok
  button "Cancel", 101, 180 319 65 23, cancel
  button "Refresh", 102, 260 319 65 23
}

on *:dialog:fserve:*:*:{
  if ($devent == init) {
    did -c $dname 1
    did -ra $dname 15 $vnum($r.set(Fserve,Max.Sends.Each),1)
    did -ra $dname 17 $vnum($r.set(Fserve,Max.Sends.Total),2)
    did -ra $dname 20 $vnum($r.set(Fserve,Max.Queues.Each),4)
    did -ra $dname 22 $vnum($r.set(Fserve,Max.Queues.Total),10)
    if ($r.set(Fserve,Auto.Start) == On) { did -c $dname 23 }
    if ($r.set(Fserve,Status) == On) { did -c $dname 37 }
    did -ra $dname 25 $vnum($r.set(Fserve,Max.Serve),4)
    did -ra $dname 27 $vnum($r.set(Fserve,Ad.Delay),5)
    did -ra $dname 29 $r.set(Fserve,Note)
    if ($r.set(Fserve,Channels) == All) { did -c $dname 32 | did -b $dname 31,33,34 }
    else { dla $dname 31 $r.set(Fserve,Channels) }
    if ($r.set(Fserve.1,Status) == On) { did -c $dname 35 }

    ;; Begin dyerseve Code
    did -c $dname 200 
    ;; End dyerseve Code

    did -ra $dname 202 $r.set(Fserve.1,Trigger)
    did -mra $dname 205 $getdir
    ;did -mra $dname 205 $r.set(Fserve.1,Root.Dir)
    did -mra $dname 208 $isset($r.set(Fserve.1,Welcome.File),None)
    did -c $dname 210 

    ;; Begin dyerseve Code
    if ($r.set(Fserve.2,VOP) == On) { did -c $dname 300 }
    ;; End dyerseve Code

    did -ra $dname 302 $r.set(Fserve.2,Trigger)
    did -mra $dname 305 $r.set(Fserve.2,Root.Dir)
    did -mra $dname 308 $isset($r.set(Fserve.2,Welcome.File),None)
    if ($r.set(Fserve.2,Status) == On) { did -c $dname 310 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.3,VOP) == On) { did -c $dname 400 }
    ;; End dyerseve Code

    did -ra $dname 402 $r.set(Fserve.3,Trigger)
    did -mra $dname 405 $r.set(Fserve.3,Root.Dir)
    did -mra $dname 408 $isset($r.set(Fserve.3,Welcome.File),None)
    if ($r.set(Fserve.3,Status) == On) { did -c $dname 410 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.4,VOP) == On) { did -c $dname 500 }
    ;; End dyerseve Code

    did -ra $dname 502 $r.set(Fserve.4,Trigger)
    did -mra $dname 505 $r.set(Fserve.4,Root.Dir)
    did -mra $dname 508 $isset($r.set(Fserve.4,Welcome.File),None)
    if ($r.set(Fserve.4,Status) == On) { did -c $dname 510 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.5,VOP) == On) { did -c $dname 600 }
    ;; End dyerseve Code

    did -ra $dname 602 $r.set(Fserve.5,Trigger)
    did -mra $dname 605 $r.set(Fserve.5,Root.Dir)
    did -mra $dname 608 $isset($r.set(Fserve.5,Welcome.File),None)
    if ($r.set(Fserve.5,Status) == On) { did -c $dname 610 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.6,VOP) == On) { did -c $dname 700 }
    ;; End dyerseve Code

    did -ra $dname 702 $r.set(Fserve.6,Trigger)
    did -mra $dname 705 $r.set(Fserve.6,Root.Dir)
    did -mra $dname 708 $isset($r.set(Fserve.6,Welcome.File),None)
    if ($r.set(Fserve.6,Status) == On) { did -c $dname 710 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.7,VOP) == On) { did -c $dname 800 }
    ;; End dyerseve Code

    did -ra $dname 802 $r.set(Fserve.7,Trigger)
    did -mra $dname 805 $r.set(Fserve.7,Root.Dir)
    did -mra $dname 808 $isset($r.set(Fserve.7,Welcome.File),None)
    if ($r.set(Fserve.7,Status) == On) { did -c $dname 810 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.8,VOP) == On) { did -c $dname 900 }
    ;; End dyerseve Code

    did -ra $dname 902 $r.set(Fserve.8,Trigger)
    did -mra $dname 905 $r.set(Fserve.8,Root.Dir)
    did -mra $dname 908 $isset($r.set(Fserve.8,Welcome.File),None)
    if ($r.set(Fserve.8,Status) == On) { did -c $dname 910 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.9,VOP) == On) { did -c $dname 1000 }
    ;; End dyerseve Code

    did -ra $dname 1002 $r.set(Fserve.9,Trigger)
    did -mra $dname 1005 $r.set(Fserve.9,Root.Dir)
    did -mra $dname 1008 $isset($r.set(Fserve.9,Welcome.File),None)
    if ($r.set(Fserve.9,Status) == On) { did -c $dname 1010 }

    ;; Begin dyerseve Code
    if ($r.set(Fserve.10,VOP) == On) { did -c $dname 1100 }
    ;; End dyerseve Code

    did -ra $dname 1102 $r.set(Fserve.10,Trigger)
    did -mra $dname 1105 $r.set(Fserve.10,Root.Dir)
    did -mra $dname 1108 $isset($r.set(Fserve.10,Welcome.File),None)

    if ($r.set(Fserve.10,UseGeneralAdvChan) == On) { did -c $dname 40 }
    else { did -u $dname 40 }

    var %i = 1
    while (%i <= $numtok($r.set(Fserve.10,adchannels),44)) {
      /did -a $dname 41 $gettok($r.set(Fserve.10,adchannels),%i,44)
      inc %i
    }

    if ($r.set(Fserve.10,Status) == On) { did -c $dname 1110 }


    did -mra $dname 1271 $vnum($gettok($r.set(Fserve,Record.CPS),1,32),0) by $isset($gettok($r.set(Fserve,Record.CPS),2-,32))
    did -mra $dname 1273 $size($r.set(Fserve,Send.Bytes))
    did -mra $dname 1275 $vnum($r.set(Fserve,Send.Total),0)
    did -mra $dname 1277 $vnum($r.set(Fserve,Send.Fails),0)
    did -mra $dname 1279 $vnum($r.set(Fserve,Access),0)

  }
  if ($devent == sclick) {
    if ($did == 32) { if ($did($dname,$did).state == 1) { did -b $dname 31,33,34 } | else { did -e $dname 31,33,34 } }
    if ($did == 33) && ($did($dname,31).sel == $null) && ($did($dname,31).text != $null) { did -a $dname 31 $vc($did($dname,31).text) | did -c $dname 31 $did($dname,31).lines }
    if ($did == 34) && ($did($dname,31).sel isnum) { did -d $dname 31 $did($dname,31).sel }
    if ($did == 206) { .timer 1 0 did -ra $dname 205 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  209) { .timer 1 0 did -ra $dname 208 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 306) { .timer 1 0 did -ra $dname 305 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  309) { .timer 1 0 did -ra $dname 308 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 406) { .timer 1 0 did -ra $dname 405 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  409) { .timer 1 0 did -ra $dname 408 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 506) { .timer 1 0 did -ra $dname 505 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  509) { .timer 1 0 did -ra $dname 508 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 606) { .timer 1 0 did -ra $dname 605 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  609) { .timer 1 0 did -ra $dname 608 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 706) { .timer 1 0 did -ra $dname 705 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  709) { .timer 1 0 did -ra $dname 708 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 806) { .timer 1 0 did -ra $dname 805 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  809) { .timer 1 0 did -ra $dname 808 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 906) { .timer 1 0 did -ra $dname 905 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  909) { .timer 1 0 did -ra $dname 908 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 1006) { .timer 1 0 did -ra $dname 1005 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  1009) { .timer 1 0 did -ra $dname 1008 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 1106) { .timer 1 0 did -ra $dname 1105 $!shortfn( $chr(91) $!$sdir="Choose Root Directory" *.* $chr(93) ) }
    if ($did ==  1109) { .timer 1 0 did -ra $dname 1108 $!isset($lower( $chr(91) $!shortfn( $chr(91) $!dir="Choose Welcome File (Cancel = None)" *.txt $chr(93) ) $chr(93) ),None) }
    if ($did == 42) {
      if ($did(fserve,41) != $null) {
        /did -a fserve 41 $did(fserve,41)
      }
    }
    if ($did == 43) {
      if ($did(fserve,41).sel != $null) {
        /did -d fserve 41 $did(fserve,41).sel
      }
    }
    if ($did ==  2000) { /dialog -x fserve fserve | xdcc_dlg }
    if (($did == 100) || ($did == 102)) {

      w.set Fserve Max.Sends.Each $vnum($did($dname,15).text,1)
      w.set Fserve Max.Sends.Total $vnum($did($dname,17).text,2)
      w.set Fserve Max.Queues.Each $vnum($did($dname,20).text,4)
      w.set Fserve Max.Queues.Total $vnum($did($dname,22).text,10)
      if ($did($dname,23).state == 1) { w.set Fserve Auto.Start On } | else { w.set Fserve Auto.Start Off }
      if ($did($dname,37).state == 1) { w.set Fserve Status On } | else { w.set Fserve Status Off }
      w.set Fserve Max.Serve $vnum($did($dname,25).text,4)
      w.set Fserve Ad.Delay $vnum($did($dname,27).text,5)
      if ($did($dname,32).state == 1) || ($did($dname,31).lines == 0) { w.set Fserve Channels All } | else { dls $dname 31 w.set Fserve Channels }
      w.set Fserve Note $isset($did($dname,29).text,Just type the Trigger!)
      if ($did($dname,35).state == 1) { w.set Fserve.1 Status On } | else { w.set Fserve.1 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,200).state == 1) { w.set Fserve.1 VOP On } | else { w.set Fserve.1 VOP Off }
      ;; End dyerseve code

      w.set Fserve.1 Trigger $isset($did($dname,202).text,-=INCOMING=-)
      w.set Fserve.1 Root.Dir $getdir
      ;w.set Fserve.1 Root.Dir $isset($did($dname,205).text,$shortfn($mircdirdownload))
      w.set Fserve.1 Welcome.File $isset($did($dname,208).text,None)
      if ($did($dname,210).state == 1) { w.set Fserve.1 Status On } | else { w.set Fserve.1 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,300).state == 1) { w.set Fserve.2 VOP On } | else { w.set Fserve.2 VOP Off }
      ;; End dyerseve code

      w.set Fserve.2 Trigger $isset($did($dname,302).text,!trigger-2)
      w.set Fserve.2 Root.Dir $isset($did($dname,305).text,$shortfn($mircdirdownload))
      w.set Fserve.2 Welcome.File $isset($did($dname,308).text,None)
      if ($did($dname,310).state == 1) { w.set Fserve.2 Status On } | else { w.set Fserve.2 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,400).state == 1) { w.set Fserve.3 VOP On } | else { w.set Fserve.3 VOP Off }
      ;; End dyerseve code

      w.set Fserve.3 Trigger $isset($did($dname,402).text,!trigger-3)
      w.set Fserve.3 Root.Dir $isset($did($dname,405).text,$shortfn($mircdirdownload))
      w.set Fserve.3 Welcome.File $isset($did($dname,408).text,None)
      if ($did($dname,410).state == 1) { w.set Fserve.3 Status On } | else { w.set Fserve.3 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,500).state == 1) { w.set Fserve.4 VOP On } | else { w.set Fserve.4 VOP Off }
      ;; End dyerseve code

      w.set Fserve.4 Trigger $isset($did($dname,502).text,!trigger-4)
      w.set Fserve.4 Root.Dir $isset($did($dname,505).text,$shortfn($mircdirdownload))
      w.set Fserve.4 Welcome.File $isset($did($dname,508).text,None)
      if ($did($dname,510).state == 1) { w.set Fserve.4 Status On } | else { w.set Fserve.4 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,600).state == 1) { w.set Fserve.5 VOP On } | else { w.set Fserve.5 VOP Off }
      ;; End dyerseve code

      w.set Fserve.5 Trigger $isset($did($dname,602).text,!trigger-5)
      w.set Fserve.5 Root.Dir $isset($did($dname,605).text,$shortfn($mircdirdownload))
      w.set Fserve.5 Welcome.File $isset($did($dname,608).text,None)
      if ($did($dname,610).state == 1) { w.set Fserve.5 Status On } | else { w.set Fserve.5 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,700).state == 1) { w.set Fserve.6 VOP On } | else { w.set Fserve.6 VOP Off }
      ;; End dyerseve code

      w.set Fserve.6 Trigger $isset($did($dname,702).text,!trigger-6)
      w.set Fserve.6 Root.Dir $isset($did($dname,705).text,$shortfn($mircdirdownload))
      w.set Fserve.6 Welcome.File $isset($did($dname,708).text,None)
      if ($did($dname,710).state == 1) { w.set Fserve.6 Status On } | else { w.set Fserve.6 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,800).state == 1) { w.set Fserve.7 VOP On } | else { w.set Fserve.7 VOP Off }
      ;; End dyerseve code

      w.set Fserve.7 Trigger $isset($did($dname,802).text,!trigger-7)
      w.set Fserve.7 Root.Dir $isset($did($dname,805).text,$shortfn($mircdirdownload))
      w.set Fserve.7 Welcome.File $isset($did($dname,808).text,None)
      if ($did($dname,810).state == 1) { w.set Fserve.7 Status On } | else { w.set Fserve.7 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,900).state == 1) { w.set Fserve.8 VOP On } | else { w.set Fserve.8 VOP Off }
      ;; End dyerseve code

      w.set Fserve.8 Trigger $isset($did($dname,902).text,!trigger-8)
      w.set Fserve.8 Root.Dir $isset($did($dname,905).text,$shortfn($mircdirdownload))
      w.set Fserve.8 Welcome.File $isset($did($dname,908).text,None)
      if ($did($dname,910).state == 1) { w.set Fserve.8 Status On } | else { w.set Fserve.8 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,1000).state == 1) { w.set Fserve.9 VOP On } | else { w.set Fserve.9 VOP Off }
      ;; End dyerseve code

      w.set Fserve.9 Trigger $isset($did($dname,1002).text,!trigger-9)
      w.set Fserve.9 Root.Dir $isset($did($dname,1005).text,$shortfn($mircdirdownload))
      w.set Fserve.9 Welcome.File $isset($did($dname,1008).text,None)
      if ($did($dname,1010).state == 1) { w.set Fserve.9 Status On } | else { w.set Fserve.9 Status Off }

      ;; Begin dyerseve code
      if ($did($dname,1100).state == 1) { w.set Fserve.10 VOP On } | else { w.set Fserve.10 VOP Off }
      if ($did($dname,40).state == 1) { w.set Fserve.10 UseGeneralAdvChan On }
      else { w.set Fserve.10 UseGeneralAdvChan Off }
      ;; End dyerseve code

      w.set Fserve.10 Trigger $isset($did($dname,1102).text,!trigger-10)
      w.set Fserve.10 Root.Dir $isset($did($dname,1105).text,$shortfn($mircdirdownload))
      w.set Fserve.10 Welcome.File $isset($did($dname,1108).text,None)

      /remini $mircdirSystem\Fserve.ini Fserve.10 adchannels
      if ($mid($did($dname,41,1),1,1) == $chr(43) || $mid($did($dname,41,1),1,1) == $chr(45)) {
        /w.set Fserve.10 adchannels $did($dname,41,1)
      }
      var %i = 2
      while (%i <= $did($dname,41).lines) {
        if ($mid($did($dname,41,%i),1,1) == $chr(43) || $mid($did($dname,41,%i),1,1) == $chr(45)) {
          /w.set Fserve.10 adchannels , $+ $did($dname,41,%i)
        }
        inc %i
      }

      if ($did($dname,1110).state == 1) { w.set Fserve.10 Status On } | else { w.set Fserve.10 Status Off }

      if ($did($dname,1286).state == 1) { w.set Fserve Record.CPS 0 n/a }
      if ($did($dname,1287).state == 1) { w.set Fserve Send.Bytes 0 | w.set Fserve send.lastreset $ctime }
      if ($did($dname,1288).state == 1) { w.set Fserve Send.Total 0 }
      if ($did($dname,1289).state == 1) { w.set Fserve Send.Fails 0 }
      if ($did($dname,1290).state == 1) { w.set Fserve Access 0 }

      ;refresh on press apply button 
      { advertise stop fserve } { advertise start fserve }
    }
  }
}
on *:connect: .initfserv

alias initfserv {
  if ($r.set(Fserve,Auto.Start) == off) || ($1 == force) {
    writeini $mircdirsystem\fserve.ini fserve auto.start on 
  }
  if ($r.set(Fserve,Status) == off) || ($1 == force) {
    writeini $mircdirsystem\fserve.ini fserve status on 
  }
  if ($r.set(fserve.1,welcome.file) == $null) || ($lower isin $r.set(fserve.1,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.1,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.1 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.2,welcome.file) == $null) || ($lower isin $r.set(fserve.2,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.2,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.2 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.3,welcome.file) == $null) || ($lower isin $r.set(fserve.3,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.3,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.3 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.4,welcome.file) == $null) || ($lower isin $r.set(fserve.4,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.4,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.4 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.5,welcome.file) == $null) || ($lower isin $r.set(fserve.5,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.5,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.5 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.6,welcome.file) == $null) || ($lower isin $r.set(fserve.6,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.6,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.6 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.7,welcome.file) == $null) || ($lower isin $r.set(fserve.7,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.7,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.7 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.8,welcome.file) == $null) || ($lower isin $r.set(fserve.8,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.8,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.8 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.9,welcome.file) == $null) || ($lower isin $r.set(fserve.9,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.9,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.9 welcome.file $mircdir $+ welcome.txt
  }
  if ($r.set(fserve.10,welcome.file) == $null) || ($lower isin $r.set(fserve.10,welcome.file)) || ($1 == force) || $isfile($r.set(fserve.10,welcome.file)) {
    writeini $mircdirsystem\fserve.ini fserve.10 welcome.file $mircdir $+ welcome.txt
  }
}
ctcp 1:*:{

  if ($1- == $r.set(Fserve.10,Trigger)) {
    var %isinchannel = $false

    if ($r.set(Fserve.10,UseGeneralAdvChan) == On) {
      if ($r.set(Fserve,Channels) == All) {
        var %i = 1
        while (%i <= $chan(0)) {
          if (($nick ison $chan(%i)) && ($findtok($r.set(Fserve.10,adchannels),- $+ $chan(%i),1,44) == $null)) {
            %isinchannel = $true
          }
          inc %i
        }
      }
      else {
        var %i = 1
        while (%i <= $numtok($r.set(Fserve,Channels),44)) {
          if (($nick ison $gettok($r.set(Fserve,Channels),%i,44)) && ($findtok($r.set(Fserve.10,adchannels),- $+ $gettok($r.set(Fserve,Channels),%i,44),1,44) == $null)) {
            %isinchannel = $true
          }
          inc %i
        }
      }
    }
    if %isinchannel == $false {
      var %i = 1
      while (%i <= $numtok($r.set(Fserve.10,adchannels),44)) {
          if (($nick ison $right($gettok($r.set(Fserve.10,adchannels),%i,44),-1)) && ($mid($gettok($r.set(Fserve.10,adchannels),%i,44),1,1) == $chr(43))) {
            %isinchannel = $true
          }
        inc %i
      }
    }

    if ((%isinchannel == $false)) {
      notice $nick  $+ $sets(viz,ADV.text) $+ Sorry, you don't have rights to access this trigger.
      halt
    }
  }
  
  ;  if ( fservban isin $level($nick) ) { .msg $nick You are banned from my serv !! | /halt }

  ;if ($nick isreg %channel1) var %useris = reg
  ;if ($nick isvo %channel1) var %useris = voice
  ;if ($nick ishelp %channel1) var %useris = halfop
  if ($nick ison %channel1) var %useris = op
  if ($nick !ison %channel1) var %useris = voice 
  ;if ($me isreg %channel1) var %meis = reg
  ;if ($me isvo %channel1) var %meis = voice
  ;if ($me ishelp %channel1) var %meis = halfop
  if ($me ison %channel1) var %meis = op

  ; _debug user is %useris & me i'm %meis

  if (%meis == op) && ((%useris == halfop) || (%useris == op)) { var %allowed = on }
  elseif ((%meis == halfop) || (%meis == voice)) && (%useris != reg) { var %allowed = on }
  elseif (%meis == reg) { var %allowed = on }
  else var %allowed = off

  ; _debug server is %allowed

  ;  if $level($nick) == fservallow { var %allowed = on }

  if ($1- == $r.set(Fserve.1,Trigger)) || ($1- == $r.set(Fserve.2,Trigger)) || ($1- == $r.set(Fserve.3,Trigger)) || ($1- == $r.set(Fserve.4,Trigger)) || ($1- == $r.set(Fserve.5,Trigger)) || ($1- == $r.set(Fserve.6,Trigger)) || ($1- == $r.set(Fserve.7,Trigger)) || ($1- == $r.set(Fserve.8,Trigger)) || ($1- == $r.set(Fserve.9,Trigger)) || ($1- == $r.set(Fserve.10,Trigger)) {
    if ($r.set(Fserve,Status) != On) { .notice $nick  $+ $sets(viz,ADV.text) $+ Sorry, The file server is currently down. }
    elseif ($fserv(0) >= $r.set(Fserve,Max.Serve)) { .notice $nick  $+ $sets(viz,ADV.text) $+ Sorry, but the file server is full. }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.1,Trigger)) && ($r.set(Fserve.1,Status) == On) { fserve $nick 99 $getdir $r.set(Fserve.1,Welcome.File) }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.1,Trigger)) && ($r.set(Fserve.1,Status) == On) && ($r.set(Fserve.1,VOP) == On) { fserve $nick 99 $getdir $r.set(Fserve.1,Welcome.File) }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.2,Trigger)) && ($r.set(Fserve.2,Status) == On) { fserve.start $nick 2 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.2,Trigger)) && ($r.set(Fserve.2,Status) == On) && ($r.set(Fserve.2,VOP) == On) { fserve.start $nick 2 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.3,Trigger)) && ($r.set(Fserve.3,Status) == On) { fserve.start $nick 3 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.3,Trigger)) && ($r.set(Fserve.3,Status) == On) && ($r.set(Fserve.3,VOP) == On) { fserve.start $nick 3 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.4,Trigger)) && ($r.set(Fserve.4,Status) == On) { fserve.start $nick 4 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.4,Trigger)) && ($r.set(Fserve.4,Status) == On) && ($r.set(Fserve.4,VOP) == On) { fserve.start $nick 4 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.5,Trigger)) && ($r.set(Fserve.5,Status) == On) { fserve.start $nick 5 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.5,Trigger)) && ($r.set(Fserve.5,Status) == On) && ($r.set(Fserve.5,VOP) == On) { fserve.start $nick 5 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.6,Trigger)) && ($r.set(Fserve.6,Status) == On) { fserve.start $nick 6 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.6,Trigger)) && ($r.set(Fserve.6,Status) == On) && ($r.set(Fserve.6,VOP) == On) { fserve.start $nick 6 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.7,Trigger)) && ($r.set(Fserve.7,Status) == On) { fserve.start $nick 7 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.7,Trigger)) && ($r.set(Fserve.7,Status) == On) && ($r.set(Fserve.7,VOP) == On) { fserve.start $nick 7 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.8,Trigger)) && ($r.set(Fserve.8,Status) == On) { fserve.start $nick 8 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.8,Trigger)) && ($r.set(Fserve.8,Status) == On) && ($r.set(Fserve.8,VOP) == On) { fserve.start $nick 8 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.9,Trigger)) && ($r.set(Fserve.9,Status) == On) { fserve.start $nick 9 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.9,Trigger)) && ($r.set(Fserve.9,Status) == On) && ($r.set(Fserve.9,VOP) == On) { fserve.start $nick 9 }

    elseif (%allowed = on) && ($1- == $r.set(Fserve.10,Trigger)) && ($r.set(Fserve.10,Status) == On) { fserve.start $nick 10 }
    elseif (%allowed = off) && (%useris == voice) && ($1- == $r.set(Fserve.10,Trigger)) && ($r.set(Fserve.10,Status) == On) && ($r.set(Fserve.10,VOP) == On) { fserve.start $nick 10 }

    elseif (%allowed == off) { notice $nick  $+ $sets(viz,ADV.text) $+ Sorry, you don't have rights to access this Restricted Area.4you need to be in main channel to access these :)) }

    else { notice $nick  $+ $sets(viz,ADV.text) $+ Sorry, an error has occured !. }
    ;; End dyerseve Code
  }
}

on *:start:{
  if ($r.set(fserve,send.lastreset) == $null) { /w.set fserve send.lastreset $ctime }
  if ($r.set(Fserve.10,UseGeneralAdvChan) == $null) { /w.set Fserve.10 UseGeneralAdvChan On }
}

;on *:start: { 
;  /run attrib $mircdirmirc.ini -r +a -s -h
;  if ($gettok($readini($mircdirmirc.ini,-n,options,n4),3,44) == 1) { echo -a DCCserver Failure ! go to menu 8DCC > send uncheck "8Fill spaces" and send a file to anyone for validate the setting , else ask Snake59 about it .thx! }
;}
