; //----------------------------------//
; //----- XDCC DIALOG TABLES ---------//
; //----------------------------------//

dialog xdcc {
  title "Xdcc Server 1.11c - by "
  size -1 -1 360 407
  option pixels
  box "Available packs", 1, 5 5 350 214
  list 2, 10 23 260 184, size
  button "Pack Info", 7, 275 25 70 20
  button "Change Pack", 6, 275 55 70 20
  button "Add Pack", 8, 275 85 70 20
  button "Clear All", 5, 275 115 70 20
  button "Remove file", 11, 275 138 70 20
  button "dcc-serv", 10, 275 160 70 20
  button "Close", 9, 275 185 70 20, ok
  box "Options", 3, 5 226 350 177
  check "XDCC Server Status - OFF", 4, 159 240 188 20
  check "XDCC Advertisement - OFF", 12, 159 258 188 20
  text "Advertise delay (minutes):", 13, 140 281 129 16
  text "Min CPS (0 = disable):", 14, 141 304 130 16
  text "Max CPS (0 = disable):", 15, 140 327 133 16
  edit "", 16, 275 279 75 19
  edit "", 17, 275 303 75 19
  edit "", 18, 276 326 74 19
  button "Save settings", 19, 140 371 209 25
  text "Number of slots:", 20, 139 348 135 16
  edit "", 21, 276 346 74 21
  box "Advertise on channels", 22, 14 244 122 152
  combo 24, 21 288 106 101, size
  button "Add", 25, 22 261 50 23
  button "Rem", 27, 73 261 53 23
}

dialog xinf {
  title "Xdcc Server 1.11c - Pack info"
  size -1 -1 360 120
  box "", 1, 5 5 350 110
  button "Close", 15, 280 90 70 20, ok
  text "", 3, 15 35 350 32
  text "", 5, 15 65 120 22
}

; //----------------------------------//
; //----- ON XDCC DIALOG EVENTS ------//
; //----------------------------------//

on *:dialog:xdcc:init:*: { 
  %xdcc.y = 1 
  While (%xdcc.y <= $xdcc(packs)) {
    %xdcc.x = pack $+ %xdcc.y 
    did -a xdcc 2 $nopath($xdcp(%xdcc.x,filepath)) 
    inc %xdcc.y 
  }
  if $xdcc(status) == on { did -c $dname 4 | /did -ra $dname 4 XDCC Server Status - ON }
  else { did -u $dname 4 | /did -ra $dname 4 XDCC Server Status - OFF }

  if $xdcc(advertisement) == on { did -c $dname 12 | /did -ra $dname 12 XDCC Advertisement - ON }
  else { did -u $dname 12 | /did -ra $dname 12 XDCC Advertisement - OFF }

  /did -ra $dname 16 $xdcc(addelay)
  /did -ra $dname 17 $xdcc(mincps)
  /did -ra $dname 18 $xdcc(maxcps)
  /did -ra $dname 21 $xdcc(maxslots)

  /did -r $dname 24
  var %i = 1
  while %i <= $xdcc_nchan {
    did -a $dname 24 $xdcc_gchan(%i)
    inc %i
  }
}

on *:dialog:xdcc:sclick:*: { 
  if ($did = 10) { /dialog -x xdcc xdcc | fserve_config }

  if ($did = 11) {
    if $did($dname,2).seltext != $null {
      var %i = 1
      while %i <= $ini($mircdirXDCC\XDCC.ini,0) {
        if $nopath($readini($mircdirXDCC\XDCC.ini,$ini($mircdirXDCC\XDCC.ini,%i),filepath)) == $did($dname,2).seltext {
          /remini $mircdirXDCC\XDCC.ini $ini($mircdirXDCC\XDCC.ini,%i)
          /did -d $dname 2 $did($dname,2).sel
          /writeini $mircdirXDCC\XDCC.ini xserver packs $iif($xdcc(packs) > 0,$calc($xdcc(packs) - 1),0)
          %i = $ini($mircdirXDCC\XDCC.ini,0)
        }
        inc %i
      }
      .copy -o $mircdirXDCC\XDCC.ini $mircdirXDCC\temp_XDCC.ini
      var %i = 1
      while %i <= $ini($mircdirXDCC\XDCC.ini,0) {
        if pack isin $ini($mircdirXDCC\XDCC.ini,%i) {
          /remini $mircdirXDCC\XDCC.ini $ini($mircdirXDCC\XDCC.ini,%i)
        }
        inc %i
      }

      var %i = 1
      var %j = 0
      while %i <= $ini($mircdirXDCC\temp_XDCC.ini,0) {
        if pack isin $ini($mircdirXDCC\temp_XDCC.ini,%i) {
          inc %j
          /writeini $mircdirXDCC\XDCC.ini pack $+ %j filepath $readini($mircdirXDCC\temp_XDCC.ini,$ini($mircdirXDCC\temp_XDCC.ini,%i),filepath)
          /writeini $mircdirXDCC\XDCC.ini pack $+ %j download $readini($mircdirXDCC\temp_XDCC.ini,$ini($mircdirXDCC\temp_XDCC.ini,%i),download)
          /writeini $mircdirXDCC\XDCC.ini pack $+ %j colour $readini($mircdirXDCC\temp_XDCC.ini,$ini($mircdirXDCC\temp_XDCC.ini,%i),colour)
        }
        inc %i
      }
      .remove $mircdirXDCC\temp_XDCC.ini
    }
  }

  ;if ($did = 11) { remini $mircdirxdcc\xdcc.ini pack $+ $did(xdcc,2).sel | writeini $mircdirxdcc\xdcc.ini xserver packs $calc($xdcc(packs) - 1) | refreshall }

  if ($did = 5) { 
    xdcc_del 
  } 
  if ($did = 6) { 
    .timer -m 1 1 xdcc_edt $$did(2).sel 
  } 
  if ($did = 7) { 
    .timer -m 1 1 xdcc_inf $$did(2).sel 
  } 
  if ($did = 8) { 
    .timer -m 1 1 xdcc_add 
  }
  if ($did == 4 || $did == 12) {
    if $did($dname,4).state == 1 { /did -ra $dname 4 XDCC Server Status - ON }
    else { /did -ra $dname 4 XDCC Server Status - OFF }

    if $did($dname,12).state == 1 { /did -ra $dname 12 XDCC Advertisement - ON }
    else { /did -ra $dname 12 XDCC Advertisement - OFF }
  }

  if $did == 19 {
    .timerxdccadv off
    .timerxdccadv 0 $calc(60*$xdcc(addelay)) xdcc_adv

    if $did($dname,4).state == 1 { if $xdcc(status != on) { xdcc_on } }
    else { if $xdcc(status != off) { xdcc_off } }

    if $did($dname,12).state == 1 { writeini $mircdirxdcc\xdcc.ini xserver advertisement on }
    else { writeini $mircdirxdcc\xdcc.ini xserver advertisement off }

    writeini $mircdirxdcc\xdcc.ini xserver addelay $calc($did($dname,16))
    writeini $mircdirxdcc\xdcc.ini xserver mincps $calc($did($dname,17))
    writeini $mircdirxdcc\xdcc.ini xserver maxcps $calc($did($dname,18))
    writeini $mircdirxdcc\xdcc.ini xserver maxslots $calc($did($dname,21))

    /xdcc_cchan
    var %i = 1
    while %i <= $did($dname,24).lines {
      /xdcc_achan $did($dname,24,%i)
      inc %i
    }
  }
  if $did == 25 {
    if ($did($dname,24).sel == $null && $did($dname,24).text != $null && $chr(35) isin $did($dname,24).text) { did -a $dname 24 $did($dname,24).text | did -c $dname 24 $did($dname,24).lines }
  }
  if $did == 27 {
    if ($did($dname,24).sel isnum) { did -d $dname 24 $did($dname,24).sel | did -c $dname 24 $did($dname,24).lines }
  }
}

on *:dialog:xinf:init:*: { 
  %xdcc.z = pack $+ $did(xdcc,2).sel 
  did -a xinf 1 Info %xdcc.z 
  did -a xinf 3 File: $xdcp(%xdcc.z,filepath) 
  did -a xinf 5 Downloads: $xdcp(%xdcc.z,download) 
}

; //----------------------------------//
; //----- ON XDCC EVENTS -------------//
; //----------------------------------//

on *:connect:{
  if ($xdcc(status) == on) { .timerxdccadv 0 $calc(60*$xdcc(addelay)) xdcc_adv | xdcc_adv }
}

on *:sendfail:*:{
  .notice $nick Your send of $nopath($filename) was interrupted.
  if ($xdcc(maxslots) > $send(0)) {  
    /xdcc_hurry
  }
}

on *:filesent:*:{
  writeini $mircdirxdcc\xdcc.ini xserver fullsent $calc($xdcc(fullsent) + 1)
  .notice $nick Your send of $nopath($filename) was successfully completed.
  if ($xdcc(maxslots) > $send(0)) {
    /xdcc_hurry
  }
}

ctcp 1:xdcc: { 
  %xdcc.y = 1
  if ($xdcc(status) != on) {
    .notice $nick Xdcc server is OFF. Try again later. 
    halt 
  } 
  if ($2 == list) {
    writeini $mircdirxdcc\xdcc.ini xserver access $calc($xdcc(access) + 1)
    .notice $nick 3############ There are $xdcc(packs) packs available ############
    .notice $nick 3Type: 4/ctcp $me xdcc send #x 3to get the pack you want.  3MinCPS: $+ 7 ( $+ $xdcc(mincps) $+ )  
    While (%xdcc.y <= $xdcc(packs))  {
      %xdcc.x = pack $+ %xdcc.y
      .notice $nick 7 $+ $chr(35) $+ %xdcc.y 3( 7 $+ $nopath($xdcp(%xdcc.x,filepath)) $+ 3 ) $file($xdcp(%xdcc.x,filepath)).size $+ b
      inc %xdcc.y
    }
    .notice $nick 3############# XDCC Server 1.11c -  by ME #############
  }
  if ($2 == send) {
    if ($send(0) >= $xdcc(maxslots)) {
      %xdcc.unitsav = min  
      %xdcc.leftsav = 999999
      %xdcc.timeunit = min
      %xdcc.z = 1
      While (%xdcc.z <= $send(0)) {
        %xdcc.timeleft = $calc((($send(%xdcc.z).size - $send(%xdcc.z).sent) / $send(%xdcc.z).cps) / 60)
        if (%xdcc.timeleft < 1) {
          %xdcc.timeleft = $calc(%xdcc.timeleft * 60)
          %xdcc.timeunit = sec
        }    
        if ((%xdcc.timeleft < %xdcc.leftsav) && (%xdcc.timeunit == %xdcc.unitsav)) {
          %xdcc.leftsav = %xdcc.timeleft
        }
        elseif (%xdcc.timeunit == sec) {
          %xdcc.leftsav = %xdcc.timeleft
          %xdcc.unitsav = %xdcc.unitsav
        } 
        inc %xdcc.z
      }
      .notice $nick There is no slot available. Try again in $round(%xdcc.leftsav,0) %xdcc.unitsav $+ . (subject to change)      
      halt
    }
    %xdcc.x = $remove($3,$chr(35))
    if (%xdcc.x !isnum) {
      .notice $nick ERROR - The pack identifier must be numeric. Ex: #3
      halt 
    } 
    if (%xdcc.x > $xdcc(packs)) {
      .notice $nick ERROR - You asked for a pack that doesn't exist. Correct the pack number, then try again
      halt 
    } 
    %xdcc.y = pack $+ %xdcc.x 
    dcc send $nick $xdcp(%xdcc.y,filepath)
    writeini $mircdirxdcc\xdcc.ini xserver sent $calc($xdcc(sent) + 1)
    writeini $mircdirxdcc\xdcc.ini %xdcc.y download $calc($xdcp(%xdcc.y,download) + 1) 
    .timerxdccccps 0 300 xdcc_chkcps
  }
}

ctcp 1:version:?:.notice $nick I'm using XDCC Server 1.11c by

on *:start:{
  if $xdcc(status) == $null { writeini $mircdirxdcc\xdcc.ini xserver status off }
  if $xdcc(advertisement) == $null { writeini $mircdirxdcc\xdcc.ini xserver advertisement off }
  if $xdcc(addelay) == $null { writeini $mircdirxdcc\xdcc.ini xserver addelay 2 }
  if $xdcc(maxcps) == $null { writeini $mircdirxdcc\xdcc.ini xserver maxcps 0 }
  if $xdcc(mincps) == $null { writeini $mircdirxdcc\xdcc.ini xserver mincps 0 }
  if $xdcc(maxslots) == $null { writeini $mircdirxdcc\xdcc.ini xserver maxslots 3 }
  if $xdcc(servchan1) == $null { writeini $mircdirxdcc\xdcc.ini xserver servchan1 #tsz-xdcc }
}

; //----------------------------------//
; //-------- XDCC ALIASES ------------//
; //----------------------------------//

alias xdcc_dlg dialog -m xdcc xdcc 
alias xdcc_inf dialog -m xinf xinf
alias xdcc return $readini $mircdirxdcc\xdcc.ini xserver $1
alias xdcp return $readini $mircdirxdcc\xdcc.ini $1 $2

alias xdcc_on {
  if ($xdcc(status) == on) {
    /echo -a 8XDCC Server is already ON
    halt
  }

  writeini $mircdirxdcc\xdcc.ini xserver status on 
  /echo -a 8XDCC Server has been enabled 
}

alias xdcc_off {
  writeini $mircdirxdcc\xdcc.ini xserver status off 
  .timerxdccccps off 

  /echo -a 8Xdcc Server has been disabled 

  unset %xdcc.*
}

alias xdcc_stats {
  /echo -a 8############ 7XDCC Server Stats 8############
  /echo -a 8Number of XDCC list : $+ 8 $xdcc(access)
  /echo -a 8Number of XDCC send : $+ 8 $xdcc(sent)
  /echo -a 8Number of successfull send : $+ 8 $xdcc(fullsent)
  /echo -a 8############ 7XDCC Server Stats 8############

}

alias xdcc_chkcps {
  %xdcc.x = 1
  While (%xdcc.x <= $send(0)) {
    if ($send(%xdcc.x).cps < $xdcc(mincps) && $xdcc(mincps) > 0) {
      .notice $send(%xdcc.x) 3Your DCC Transfer has dropped below the minimum of  $+ 7 $xdcc(mincps) CPS3 and has been terminated.
      .notice $send(%xdcc.x) You will not have access to the XDCC Server for the next 5 minutes.
      ignore -tu300 $send(%xdcc.x)    
      if ($xdcc(maxslots) > $send(0)) {
        /xdcc_hurry
      }
      close -s $send(%xdcc.x)       
      if ($send(0) == 0) {   
        .timerxdccccps off
        halt
      }
    }
    inc %xdcc.x
  }
} 

alias xdcc_add { 
  %xdcc.x = $calc($xdcc(packs) + 1) 
  writeini $mircdirxdcc\xdcc.ini pack $+ %xdcc.x filepath $$dir="Which file to add?" 
  writeini $mircdirxdcc\xdcc.ini pack $+ %xdcc.x download 0 
  writeini $mircdirxdcc\xdcc.ini pack $+ %xdcc.x colour $$?"what colour for line 12=film 4=game 8=music 13=prawn"
  writeini $mircdirxdcc\xdcc.ini xserver packs $calc($xdcc(packs) + 1) 
  if $dialog(xdcc) { %xdcc.z = pack $+ %xdcc.x 
    did -a xdcc 2 $nopath($xdcp(%xdcc.z,filepath)) 
  } 
}

alias xdcc_edt {
  %xdcc.x = $1 
  writeini $mircdirxdcc\xdcc.ini pack $+ %xdcc.x filepath $$dir="Which file to add?" 
  writeini $mircdirxdcc\xdcc.ini pack $+ %xdcc.x download 0  
  %xdcc.z = pack $+ %xdcc.x 
  did -o xdcc 2 $1 $nopath($xdcp(%xdcc.z,filepath))                      
}

alias xdcc_del {
  %xdcc.x = 1
  While (%xdcc.x <= $xdcc(packs)) {
    %xdcc.y = pack $+ %xdcc.x
    remini $mircdirxdcc\xdcc.ini %xdcc.y
    inc %xdcc.x 
  }
  did -r xdcc 2
  writeini $mircdirxdcc\xdcc.ini xserver packs 0 
}

alias refreshall {
  if $dialog(xdcc) { /dialog -x xdcc xdcc | xdcc_dlg

  } 
}

;Return the number of xdcc serv channels
alias xdcc_nchan {
  var %i = 1
  var %num = 0
  while %i <= $ini($mircdirxdcc\xdcc.ini,xserver,0) {
    if servchan isin $ini($mircdirxdcc\xdcc.ini,xserver,%i) { inc %num }
    inc %i
  }

  return %num
}

; Clear the xdcc serv channels
alias xdcc_cchan {
  while $xdcc_nchan > 0 {
    .remini $mircdirxdcc\xdcc.ini xserver servchan $+ $xdcc_nchan
  }
}

; Add a xdcc serv channel
alias xdcc_achan {
  var %i = 1
  var %found = $false
  while %i <= $xdcc_nchan {
    if $1 == $readini($mircdirxdcc\xdcc.ini,xserver,servchan $+ %i) { %found = $true }
    inc %i
  }

  if ($chr(35) isin $1 && %found == $false) {
    /writeini $mircdirxdcc\xdcc.ini xserver servchan $+ $calc(1+$xdcc_nchan) $1
  }
}

; Get the Nth xdcc serv channel
alias xdcc_gchan {
  if $readini($mircdirxdcc\xdcc.ini,xserver,servchan $+ $1) != $null { return $readini($mircdirxdcc\xdcc.ini,xserver,servchan $+ $1) }
  else { return #notfound }
}

alias xdcc_hurry {
  var %i = 1
  while %i <= $xdcc_nchan {
    if $me ison $xdcc_gchan(%i) {
      msg $xdcc_gchan(%i) 3One slot available on XDCC Server. 7Hurry up!
      msg $xdcc_gchan(%i) 3Type 7/ctcp $me xdcc list 3to list the $xdcc(packs) packs available
    }
    inc %i
  }
}

alias xdcc_adv {
  if ($xdcc(advertisement) == on && $xdcc(status) == on) {
    var %i = 1
    while %i <= $xdcc_nchan {
      if $me ison $xdcc_gchan(%i) {
        %xdcc.y = 1
        msg $xdcc_gchan(%i) 11############ « There are $xdcc(packs) packs available » ############
        msg $xdcc_gchan(%i) 0** 0XDCC Server Active 0Sends:« $+ $send(0) $+ / $+ $xdcc(maxslots) $+ » «Min cps: $+ $xdcc(mincps) $+ KB/s» «Max cps: $+ $xdcc(maxcps) $+ KB/s»
        msg $xdcc_gchan(%i) 0** 0Current BW:« $+ $ks($BW)K $+ » 0Record CPS:« $+ $vnum($gettok($r.set(Fserve,Record.CPS),1,32),0) $+ cps by $isset($gettok($r.set(Fserve,Record.CPS),2-,32)) $+ »
        msg $xdcc_gchan(%i) 0** 12blue 0are = movies 4red 0are = games 8yellow 0are = music 13purple 0are = prawn 0** 
        While (%xdcc.y <= $xdcc(packs))  {
          %xdcc.x = pack $+ %xdcc.y
          msg $xdcc_gchan(%i) 0 $+ $chr(35) $+ %xdcc.y 0« $+ $bytes($file($xdcp(%xdcc.x,filepath)).size,m3).suf $+ »  $+ $xdcp(%xdcc.x,colour) $nopath($xdcp(%xdcc.x,filepath)) $+ 0 - ( $+ $xdcp(%xdcc.x,download) gets)  
          inc %xdcc.y
        }
        msg $xdcc_gchan(%i) 0Type: 4/ctcp $me xdcc send #x 0to get the pack you want.
        msg $xdcc_gchan(%i) 0** 8 14°8¨¨°15º8© 13The 15Sharing 4Zone 8©15º15°8¨¨0 **
        msg $xdcc_gchan(%i) 11############# $+ $me $+ 's XDCC Server 1.11c -  by BombermanGriff #############
      }
      inc %i
    }
  }
}
