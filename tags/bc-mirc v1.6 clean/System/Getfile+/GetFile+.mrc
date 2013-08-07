on 1:load: { 
  if ( $version < 6.11 ) {
    echo -s 5*** This addon needs mirc 6.11 or later. File $+(",$script,") will be unloaded now.
    .unload -rs $+(",$script,") | halt
  }
  else { 
    echo -s 05*** Addon Getfile+ loaded correctly.02 by12 [Niko]  02** To run it using command line type04 /getfile+ /? 02**
    set %getfile+.opc $getfile+_set
  }
}

on 1:unload: { unset %getfile+.opc | unset %getfile+.last }
on 1:exit:{ unset %getfile+.last }

menu status,channel,menubar,@getfile+.x* {
  -
  Getfile+
  .General Options : { getfile+ /o }
  .Help Commands: { getfile+ /? }
  .-
  .$iif($isalias(mgetfile+),Download Manager) : { mgetfile+ }
  -
}

alias -l getfile+_opc { dialog $iif($dialog(getfile+_opc) != $null, -ver ,-am getfile+_opc ) getfile+_opc }

dialog getfile+_opc {
  title " General Options"
  size -1 -1 146 112
  option dbu
  icon $mgetfile+_icos(opciones.ico), 0
  tab "General", 1, 4 1 137 93
  check "Enable Proxy", 20, 17 77 46 9, tab 1
  box "Proxy HTTP (Method GET)", 9, 10 49 125 40, tab 1
  text "Host", 13, 18 58 76 7, tab 1 center
  text "Port", 14, 102 58 25 7, tab 1 center
  edit "", 21, 16 65 80 10, tab 1 autohs center
  edit "", 22, 100 65 28 10, tab 1 autohs center
  check "Max simultaneous download number:", 5, 13 38 98 10, hide disable tab 1
  combo 12, 113 38 21 80, hide disable tab 1 size drop
  check "Start new downloads paused", 15, 13 28 82 10, hide disable tab 1
  check "Show log of connections ( @getfile+.xnn )", 75, 13 18 113 10, hide disable tab 1
  tab "FTP", 2
  check "Use passive mode (Firewall/Router ok)", 40, 13 36 104 10, tab 2
  combo 41, 25 69 34 80, tab 2 size edit drop
  combo 43, 79 69 34 80, tab 2 size edit drop
  box "Port range in active mode", 6, 10 49 125 40, tab 2
  text "From", 7, 27 61 23 7, tab 2 center
  text "To", 8, 81 61 23 7, tab 2 center
  scroll "", 42, 61 67 8 14, tab 2 range 1 15000 left
  scroll "", 44, 115 67 8 14, tab 2 range 1 15000 left
  tab "HTTP", 4
  text "(nothing)", 3, 58 46 25 8, tab 4 center
  button "Ok", 10, 43 98 28 11, ok
  button "Cancel", 11, 75 98 28 11, cancel
}

alias -l getfile+_set { return 0 10000 11000 0 217.172.71.30 8080 1 2 0 0 }
; %getfile+.opc = (1)modo pasivo (2)puertoini (3)puertofinal (4)usar_proxy (5)proxy_ip (6)proxy_puerto (7)Limitar (8)Límite (9)UrlPausa

on 1:dialog:getfile+_opc:init:0: {
  if (!%getfile+.opc) { set %getfile+.opc $getfile+_set }
  didtok $dname 41,43 44 100,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,8000,10000,12000,14000
  didtok $dname 12 44 1,2,3,4,5,6,7,8,9,10

  if (!$gettok(%getfile+.opc,1,32)) { did -c $dname 40 | did -b $dname 41,42,43,44 }

  if ($didwm($dname,41,$gettok(%getfile+.opc,2,32))) { did -c $dname 41 $ifmatch }
  else { did -o $dname 41 0 $gettok(%getfile+.opc,2,32) }
  if ($didwm($dname,43,$gettok(%getfile+.opc,3,32))) { did -c $dname 43 $ifmatch }
  else { did -o $dname 43 0 $gettok(%getfile+.opc,3,32) }

  if ($gettok(%getfile+.opc,4,32)) { did -c $dname 20 } | else { did -b $dname 21,22 }
  if ($gettok(%getfile+.opc,5,32)) { did -a $dname 21 $ifmatch }
  if ($gettok(%getfile+.opc,6,32) isnum 1-65536) { did -a $dname 22 $ifmatch }
  if ($gettok(%getfile+.opc,7,32)) { did -c $dname 5 }

  if ($didwm($dname,12,$gettok(%getfile+.opc,8,32))) { did -c $dname 12 $ifmatch } | else { did -c $dname 12 3 }

  if ($gettok(%getfile+.opc,9,32)) { did -c $dname 15 }
  if ($gettok(%getfile+.opc,10,32)) { did -c $dname 75 }

  did -c $dname 42 $calc(15001 - $did($dname,41,0).text) | did -c $dname 44 $calc(15001 - $did($dname,43,0).text)
}

on 1:dialog:getfile+_opc:sclick:10: { 
  var %d41 = $iif($gettok($did(41,0).text,1-,32) isnum 1-,$ifmatch) | var %d43 = $iif($gettok($did(43,0).text,1-,32) isnum 1-,$ifmatch)
  var %d21 = $iif($gettok($did(21).text,1-,32) ,$ifmatch,0) | var %d22 = $iif($gettok($did(22).text,1-,32) isnum 1-65536,$ifmatch,0)
  set %getfile+.opc $iif($did(40).state,0,1) $iif(%d41 < %d43,%d41 %d43,10000 11000) $iif($did(20).state,1,0) %d21 %d22 $&
    $iif($did(5).state,1,0) $did(12).text $iif($did(15).state,1,0) $iif($did(75).state,1,0)
}

on 1:dialog:getfile+_opc:sclick:20: { did $iif($did(20).state,-e,-b) $dname 21,22 }
on 1:dialog:getfile+_opc:sclick:40: { did $iif($did(40).state,-b,-e) $dname 41,42,43,44 }

on 1:dialog:getfile+_opc:edit:41: { if ($did(41,0).text isnum 1-15000) { did -c $dname 42 $calc(15001 - $did(41,0).text) } }
on 1:dialog:getfile+_opc:edit:43: { if ($did(43,0).text isnum 1-15000) { did -c $dname 44 $calc(15001 - $did(43,0).text) } }

on 1:dialog:getfile+_opc:sclick:41: { did -c $dname 42 $calc(15001 - $did(41).seltext) }
on 1:dialog:getfile+_opc:sclick:43: { did -c $dname 44 $calc(15001 - $did(43).seltext) }

on 1:dialog:getfile+_opc:scroll:42: { did -o $dname 41 0 $calc(15001 - $did(42).sel) }
on 1:dialog:getfile+_opc:scroll:44: { did -o $dname 43 0 $calc(15001 - $did(44).sel) }

; ############## Sockets FTP Download ##############

on 1:socklisten:getfile+.f??b_: {
  sockaccept $left($sockname,-1) | sockmark $left($sockname,-1) $sock($left($sockname,-2)).mark | sockclose $sockname 
} 

on 1:sockread:getfile+.f??b: {
  tokenize 9 $sock($sockname).mark
  if ($sockerr) { Getfile+Err $9 $21 $sockname $+($left($sockname,-1),*) Error: Problems reading socket. }
  else {
    sockread &t | var %c = $4 | var %j = 1
    while (%j && $sockbr) {
      .fwrite -b $9 &t | var %signal = 0
      if ($ferr > 0) {
        if ($4 != %c) { sockmark $sockname $puttok($sock($sockname).mark,%c,4,9) | var %signal = 1 }
        var %j = 0 | Getfile+Err $9 $21 $sockname $+($left($sockname,-1),*) Error: Can't write target file (disk full?).
      }
      else {
        var %l = $bvar(&t,0) | var %c = $calc(%c + %l)
        if ( ($5 == %c) || !$eval($+(%,$sockname),2) ) { set -u1 $+(%,$sockname) 1 | var %signal = 1 }
        sockread &t
      }
      if (%signal) {
        if ($21) { getfile+.logp $9 $2 %c $3 }
        .SIGNAL -n GETFILE+_UPD $chr9+($9,%c,$calc($ticks - $6),$2,$3,$fopen($9).fname,$+($10,$13,$15),$19) | if (!$sock($sockname)) { var %j = 0 }
      }
    }
    if (%j == 1)  { sockmark $sockname $puttok($sock($sockname).mark,%c,4,9) }
  }
}

on 1:sockclose:getfile+.f??b: {
  tokenize 9 $sock($sockname).mark 
  if ( ($4 == $5) && (($5 != 0) || ($3 == 0)) ) { Getfile+Ok $9 $21 $sockname $+($left($sockname,-1),*) 0 ¡Completed!  } 
  else {
    getfile+Err $9 $21 $sockname $+($left($sockname,-1),*) Error: $iif($4 == 0,Server has closed conection.,Download interrupted.) 
  }
}

on 1:sockwrite:getfile+.f??b: {
  if ($sockerr > 0) {
    tokenize 9 $sock($sockname).mark | Getfile+Err $9 $21 $sockname $+($left($sockname,-1),*) Error: Problems writing on socket. 
  } 
}

on 1:sockopen:getfile+.f??b: {
  var %s = $left($sockname,-1) | tokenize 9 $sock(%s).mark
  if ($sockerr > 0) { Getfile+Err $9 $21 %s $+(%s,*) Error: Problems connecting ftp (File).  } 
  else {
    var %wv = $getfile+.loge($21,sockwrite -tn %s,$9,REST $iif($8 == 1,$7,0))
  }
} 

; ########### Sockets FTP List ############

on 1:sockopen:getfile+.f??d: {
  var %s = $left($sockname,-1) | tokenize 9 $sock(%s).mark
  if ($sockerr > 0) { Getfile+Err $9 $21 %s $+(%s,*) Error: Problems connecting ftp (List).  } 
  else {
    if ($21) { getfile+.logd $9 Retrieving file information... }
    var %wv = $getfile+.loge($21,sockwrite -tn %s,$9,list $15)
  }
} 

on 1:sockwrite:getfile+.f??d: {
  if ($sockerr > 0) {
    tokenize 9 $sock($sockname).mark | Getfile+Err $9 $21 $+($left($sockname,-1),*) Error: Problems writing on socket.
  } 
}

on 1:socklisten:getfile+.f??d_: {
  sockaccept $left($sockname,-1) | sockmark $left($sockname,-1) $sock($left($sockname,-2)).mark | sockclose $sockname 
} 

on 1:sockread:getfile+.f??d: {
  var %id = $gettok($sock($sockname).mark,9,9) | var %log = $gettok($sock($sockname).mark,21,9)
  if ($sockerr) { Getfile+Err %id %log $sockname $+($left($sockname,-1),*) Error: Problems reading socket. }
  else {
    var %t | sockread %t | var %f = $gettok($gettok($sock($sockname).mark,15,9),-1,47) | var %date
    while ($sockbr) {
      tokenize 32 %t | var %wv = $getfile+.logc(%log,0,%id,%t) 
      if ( $regex($1,^.([r-][w-][x-]){3}$) ) {
        if ( ($0 > 8) && (%f == $gettok($9-,-1,47)) ) {
          var %date = $+($asctime($6-8,ddd),$chr(44)) $7 $6  $iif(: isin $8,$date(yyyy) $8,$8)
        } 
        elseif ( ($0 > 7) && (%f == $gettok($8-,-1,47)) ) { var %date = $+($asctime($ctime(Feb 20 2002),ddd),$chr(44)) $6 $5 $7 }
      }
      elseif ($3 isnum) { 
        if (%f == $gettok($4-,-1,47)) {
          if ($ctime($1-2)) { var %date = $+( $asctime( $ctime($1-2) ,ddd) ,$chr(44)) $asctime( $ctime($1-2) ,dd mmm yyyy HH:nn:ss) }
          else { var %date = $1-2 }
        }
      }
      sockread %t 
    }
    if (%date) { sockmark $left($sockname,-1) $puttok($sock($sockname).mark,%date,19,9) }
  }
}

; ################ Sockets FTP ##############

on 1:sockwrite:getfile+.f??: {
  if ($sockerr > 0) { 
    tokenize 9 $sock($sockname).mark | Getfile+Err $9 $21 $sockname $+($sockname,*) Error: Problems writing on socket. 
  } 
}
on 1:sockclose:getfile+.f??: {
  tokenize 9 $sock($sockname).mark
  if ($1 != OK) { Getfile+Err $9 $21 $sockname $+($sockname,*) Error: Server FTP has closed the connection. }
}

on 1:sockopen:getfile+.f??: {
  tokenize 9 $sock($sockname).mark
  if ($sockerr) { Getfile+Err $9 $21 $sockname 0 Error: Can't launch connection. }
  else {
    if ($21) { getfile+.logd $9 Connected. }
    .SIGNAL -n GETFILE+_CONNECT $chr9+($9,0,0,$13,$14,$+($17,$18),$+($10,$13,$15))
    if ( ($ip == $null) || ($ip == 127.0.0.1) || ($gettok($ip,1-2,46) == 192.168) ) { .localinfo $iif($status == connected,-u,-h) } 
  }
}

on 1:sockread:getfile+.f??: {
  tokenize 9 $sock($sockname).mark
  if ($sockerr) { Getfile+Err $9 $21 $sockname $+($sockname,*) Error: Problems reading socket. }
  else {
    var %t | sockread %t | var %c = $gettok(%t,1,32) | var %wv = $getfile+.logc($21,0,$9,%t)
    if (%c isnum) {
      if (%c == 220) {
        if ($21) { getfile+.logd $9 Connected. Sending user and password... }
        var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,user $11)
        sockmark $sockname $puttok($sock($sockname).mark,user,1,9)
      }
      elseif (%c == 331) {
        if ($21) { getfile+.logd $9 Connected (user ok) }
        var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,pass $12)
        sockmark $sockname $puttok($sock($sockname).mark,pass,1,9)
      }
      elseif (%c == 230) {
        if ($21) { getfile+.logd $9 Connected (password ok) }
        var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Type I)
        sockmark $sockname $puttok($sock($sockname).mark,TypeSize,1,9)
      }
      elseif (%c == 350) {
        var %r = $iif($remove($gettok(%t,4,32),.) isnum 0-,$ifmatch,$7)
        sockmark $sockname $chr9+(Retr,%r,$3,0,$calc($3 - %r),$ticks,$gettok($sock($sockname).mark,7-,9))
        var %or = $iif($8 == 1, $iif($2 == $7,1,-1), $iif($8 == 2,2,0) )
        .SIGNAL -n GETFILE+_INIT $chr9+($9,0,0,%r,$3,$+($17,$18),$+($10,$13,$15),$19,%or)
        if ($sock($sockname)) {
          if ($8 == 0) { .fopen -n $9 $+(",$17,$18,") }
          elseif (($8 == 2) || (%r != $7)) { .fopen -o $9 $+(",$17,$18,") }
          else { .fopen $9 $+(",$17,$18,") | .fseek $9 %r }
          if ($ferr > 0) { Getfile+Err $9 $21 $sockname $+($sockname,*) Error: File can't be opened. }
          else {
            sockmark $sockname $puttok($sock($sockname).mark,1,22,9)
            var %or = $iif($8 == 1, $iif(%r == $7, (resuming from position $bytes($7,b) $+ ) , (resume not available) ), $iif($8 == 2, (overwriting) ) )
            if ((($1 == PASVB) || ($1 == PortB)) && $sock($+($sockname,b))) { sockmark $+($sockname,b) $sock($sockname).mark }
            if ($21) { getfile+.logd $9 Initiating download...  %or }
            var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,RETR $15)
          }
        }
      }
      elseif (%c == 213) {  
        if ($21) { getfile+.logd $9 File found on the server. } | var %tam = $gettok(%t,2,32)
        sockmark $sockname $puttok($sock($sockname).mark,%tam,3,9)
        if (($8 == 1) && (%tam <= $7)) { 
          Getfile+Err $9 $21 $sockname $+($sockname,*) Error: File size on server is smaller or similar. 
        }
        else {
          var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Type A)
          sockmark $sockname $puttok($sock($sockname).mark,TypeA,1,9)
        }
      }
      elseif (%c == 200) {
        if ($1 == TypeSize) { 
          var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,SIZE $15)
          sockmark $sockname $puttok($sock($sockname).mark,Size,1,9)
        }
        elseif ($1 == TypeA) { 
          if ($gettok(%getfile+.opc,1,32)) {
            var %p = $getfile+.port($gettok(%getfile+.opc,2,32),$gettok(%getfile+.opc,3,32))
            if (%p > 0) {
              var %s = $+($sockname,d_)
              if ($21) { getfile+.logd $9 Retrieving list ( $+ active mode $+ $chr(44) port %p $+ ) }
              socklisten %s %p
              var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,PORT $+($replace($ip,.,$chr(44)),$chr(44),$getfile+.port2(%p)))
              sockmark $sockname $puttok($sock($sockname).mark,PortD,1,9) | sockmark $sockname $puttok($sock($sockname).mark,%p,23,9)
            }
            else { Getfile+Err $9 $21 $sockname $+($sockname,*) Error: No open port found. }
          }
          else {
            if ($21) { getfile+.logd $9 Retrieving list (passive mode) }
            sockmark $sockname $puttok($sock($sockname).mark,PASVD,1,9)
            var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,PASV)
          }
        }
        elseif ($1 == TypeI) { 
          if ($gettok(%getfile+.opc,1,32)) {
            var %p = $getfile+.port($gettok(%getfile+.opc,2,32),$gettok(%getfile+.opc,3,32),$23)
            if (%p > 0) {
              var %s = $+($sockname,b_)
              if ($21) { getfile+.logd $9 Retrieving File ( $+ active mode $+ $chr(44) port %p $+ ) }
              socklisten %s %p 
              var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,PORT $+($replace($ip,.,$chr(44)),$chr(44),$getfile+.port2(%p)))
              sockmark $sockname $puttok($sock($sockname).mark,PortB,1,9)
            }
            else { Getfile+Err $9 $21 $sockname $+($sockname,*) Error: No open port found. }
          }
          else {
            if ($21) { getfile+.logd $9 Retrieving file (passive mode) }
            sockmark $sockname $puttok($sock($sockname).mark,PASVB,1,9) 
            var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,PASV)
          }
        }
        elseif ($1 == PortD) {
          if ($21) { getfile+.logd $9 Retrieving file information... }
          var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,list $15)
        }
        elseif (($1 == PortB) || ($1 == PASVB)) {
          var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,REST $iif($8 == 1,$7,0))
        }
      }
      elseif (%c == 226) {
        if (($1 == PortD) || ($1 == PASVD)) {
          if ($21) { getfile+.logd $9 Received information. }
          var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Type I)
          sockmark $sockname $puttok($sock($sockname).mark,TypeI,1,9)
        }
        elseif ($1 == RETR) { 
          var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,quit)
          sockmark $sockname $puttok($sock($sockname).mark,Quit,1,9) 
        }
      }
      elseif (%c == 227) {
        var %ipp = $mid($gettok(%t,-1,32),2,-1) | var %ip = $replace($gettok(%ipp,1-4,44),$chr(44),.)
        var %p = $calc(($gettok(%ipp,5,44) * 256) + $gettok(%ipp,6,44)) | var %s = $+($sockname,$iif($1 == PASVD,d,b))
        if ($21) { getfile+.logd $9 Passive mode acepted $+ $chr(44) ip %ip $chr(44) port %p }
        sockopen %s %ip %p | sockmark %s $sock($sockname).mark
      }
      elseif ((%c == 221) && ($1 == Quit)) { sockmark $sockname $puttok($sock($sockname).mark,OK,1,9) }
      elseif (!$istok(150 125 220,%c,32)) {
        Getfile+Err $9 $21 $sockname $+($sockname,*) Error: $iif($gettok(%t,2-,32) != $null, $ifmatch,$iif(%c == 421,Too many users.,%c))
      }
    }
  }
}

; ################# Sockets HTTP ################

on 1:sockwrite:getfile+.h*: {
  if ($sockerr > 0) {
    tokenize 9 $sock($sockname).mark | Getfile+Err $9 $21 $sockname $sockname Error: Problems writing on socket.
  }
}

on 1:sockclose:getfile+.h*: {
  tokenize 9 $sock($sockname).mark
  if ($left($1,1) != 3) {
    if ($22 == 0) { Getfile+Err $9 $21 $sockname 0 Error: Server has closed conection.  }
    else {
      if ($3 == -1) {
        if ($21) { getfile+.logp $9 $2 $4 $3 }
        .SIGNAL -n GETFILE+_UPD $chr9+($9,$4,$calc($ticks - $6),$2,$3,$fopen($9).fname,$+($10,$13,$15),$19)
        if ($sock($sockname)) { Getfile+Ok $9 $21 $sockname 0 1 ¿Completed? }
      }
      elseif ($4 == $5) { Getfile+Ok $9 $21 $sockname 0 0 ¡Completed!  }
      else { Getfile+Err $9 $21 $sockname 0 Error: Download interrupted. }
    }
  }
}

on 1:sockopen:getfile+.h*: {
  tokenize 9 $sock($sockname).mark
  if ($sockerr) { Getfile+Err $9 $21 $sockname 0 Error: Can't connect. $iif($21,(proxy)) }
  else {
    var %proxy = $iif($16, $+(1,$chr(9),$replace($16,$chr(32),$chr(9))) , $+(0,$chr(9),$13,$chr(9),$14) )
    .SIGNAL -n GETFILE+_CONNECT $chr9+($9,0,%proxy,$+($17,$18),$+($10,$13,$15))
    if ($sock($sockname)) {
      if ($21) { getfile+.logd $9 Connected. Sending request... }
      if ($16) { 
        var %ll = GET $+($10,$iif($11,$+($11,:,$12,@)),$13,$iif($10 == ftp://,$iif($14 != 21,$+(:,$14)),$iif($14 != 80,$+(:,$14))),$iif($10 == ftp://,$15,$urlchang+($15).c)) HTTP/1.0 
        var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,%ll)
      }
      else { var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,GET $urlchang+($15).c  HTTP/1.0) }
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Host: $13)
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Accept: */*)
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Referer: $posult+($+($10,$13,$15),/))
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Range: $+(bytes=,$iif($8 == 1,$7,0),-))
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,User-Agent: Opera for ever)
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Pragma: no-cache)
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Cache-Control: no-cache)
      if ($11) { var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Authorization: Basic $encode($+($11,:,$12),m)) }
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,Connection: close)
      var %wv = $getfile+.loge($21,sockwrite -tn $sockname,$9,$null)
      sockmark $sockname $puttok($sock($sockname).mark,$ticks,6,9) 
    }
  }
}

on 1:sockread:getfile+.h*: {
  var %id = $gettok($sock($sockname).mark,9,9) | var %log = $gettok($sock($sockname).mark,21,9)
  if ($sockerr) { Getfile+Err %id %log $sockname $sockname Error: Problems reading socket. }
  else {
    if ($gettok($sock($sockname).mark,1,9) != -1 ) { var %t | sockread %t | var %j = 0 }
    else { sockread &t | tokenize 9 $sock($sockname).mark | var %c = $4 | var %j = -1 }
    while ( (%j != 1) && $sockbr ) {
      if (%j == 0) {
        var %wv = $getfile+.logc(%log,0,%id,%t)
        if (%t == $null) {
          sockmark $sockname $puttok($sock($sockname).mark,-1,1,9) | var %j = -1 | tokenize 9 $sock($sockname).mark
          var %c = $4 | var %or = $iif($8 == 1, $iif($2 == $7,1,-1), $iif($8 == 2,2,0) )
          .SIGNAL -n GETFILE+_INIT $chr9+($9,$4,$iif($6 > 0,$calc($ticks - $6),0),$2,$3,$+($17,$18),$+($10,$13,$15),$19,%or)
          if ($sock($sockname)) {
            if ($8 == 0) { .fopen -n $9 $+(",$17,$18,") }
            elseif (($8 == 2) || ($2 != $7)) { .fopen -o $9 $+(",$17,$18,") }
            else { .fopen $9 $+(",$17,$18,") | .fseek $9 $2 }
            if ($ferr > 0) { var %j = 1 | Getfile+Err $9 $21 $sockname $sockname Error: File can't be opened. }
            else {
              sockmark $sockname $puttok($sock($sockname).mark,1,22,9)
              var %or = $iif($8 == 1, $iif($2 == $7, (resuming from position $bytes($2,b) $+ ) , (resume not available) ), $iif($8 == 2, (overwriting) ) )
              if (%log) { getfile+.logd $9 Initiating download...  %or }
              sockread &t
            }
          }
          else { var %j = 1 }
        }
        else {
          tokenize 32 %t 
          if ( $left($1,5) == HTTP/ ) {
            if ( ($2 == 206) || ($2 == 200) || ($left($2,1) == 3) ) { sockmark $sockname $puttok($sock($sockname).mark,$2,1,9) }
            else { Getfile+Err %id %log $sockname $sockname Error: $2- | var %j = 1 }
          }
          elseif ($1 == Location:) {
            if (($left($2-,7) != http://) && ($left($2-,6) != ftp://)) {
              var %b = $gettok($sock($sockname).mark,15,9) | var %b = $iif($left($2-,1) != /,$+($posult+(%b,/),/,$2-),$2-)
              var %b = $+($gettok($sock($sockname).mark,10-14,9),$chr(9),%b)
            } 
            else { var %b = $getfile+.url($2-) }
            if ($gettok(%b,1,32) == Error:) {
              Getfile+Err %id %log $sockname $sockname Error: $gettok($sock($sockname).mark,1,9) Changed location. | var %j = 1 
            }
            else {
              if ( (ftp://* iswm $2-) && ($numtok($gettok($sock($sockname).mark,16,9),32) != 2) ) { 
                var %socket = $+(getfile+.f,$right($sockname,2))
              }
              else { var %socket = $sockname }
              var %name = $gettok($gettok($sock($sockname).mark,15,9),-1,46)
              var %b = $chr9+(0,$gettok($sock($sockname).mark,2-9,9),%b,$gettok($sock($sockname).mark,16-,9)) | tokenize 9 %b 
              if (%log) { getfile+.logd %id File location has changed. Connecting... ( $+ $iif($16,$replace($16,$chr(32),:),$+($13,:,$14)) $+ ) }
              var %j = 1
              .timer 1 0 getfile+.con %socket $iif($16,$ifmatch,$13 $14) %b 
            }
          }
          elseif ($1 == Content-Length:) {
            sockmark $sockname $puttok($sock($sockname).mark,$2,5,9)
            if ( $gettok($sock($sockname).mark,1,9) == 200 ) {
              sockmark $sockname $puttok($sock($sockname).mark,$2,3,9)
              if ($gettok($sock($sockname).mark,8,9) == 1) { 
                if ($2 <= $gettok($sock($sockname).mark,7,9))  {
                  Getfile+Err %id %log $sockname $sockname Error: File size on server is smaller or similar. | var %j = 1 
                }
              }
            }
          }
          elseif ($1 == Content-Range:) {
            var %i = $gettok($3,1,45) | var %tm = $gettok($3,-1,47)
            if (($gettok($sock($sockname).mark,8,9) == 1) && (%tm <= $gettok($sock($sockname).mark,7,9))) {
              Getfile+Err %id %log $sockname $sockname Error: File size on server is smaller or similar. | var %j = 1
            }                                                                                      
            else { sockmark $sockname $puttok($sock($sockname).mark,%i,2,9) | sockmark $sockname $puttok($sock($sockname).mark,%tm,3,9) }
          }
          elseif ($1 == Content-Type:) {
            var %s15 = $gettok($sock($sockname).mark,15,9)
            var %s15 = $iif($numtok(%s15,46) > 1,$left($gettok(%s15,-1,46),3))
            if ( ($gettok($2,1,59) == text/html) && !$istok(php txt htm html asp,%s15,32) && !$gettok($sock($sockname).mark,20,9) && ($left($gettok($sock($sockname).mark,1,9),1) != 3) ) {
              Getfile+Err %id %log $sockname $sockname Error: Server sends informative html. | var %j = 1
            }
          }
          elseif ($1 == Date:) { sockmark $sockname $puttok($sock($sockname).mark,$2-,19,9) }
          elseif ($1 == Last-Modified:) { sockmark $sockname $puttok($sock($sockname).mark,$2-,19,9) }
          if (%j == 1) { if ($sock($sockname)) { sockclose $sockname } } | else { sockread %t }
        }
      }
      elseif (%j == -1) {
        .fwrite -b $9 &t | var %signal = 0
        if ($ferr > 0) {
          if ($4 != %c) { sockmark $sockname $puttok($sock($sockname).mark,%c,4,9) | var %signal = 1 }
          var %j = 1 | Getfile+Err $9 $21 $sockname $sockname Error: Can't write target file (disk full?). 
        }
        else {
          var %l = $bvar(&t,0) | var %c = $calc(%c + %l)
          if ( ($5 == %c) || !$eval($+(%,$sockname),2) ) { set -u1 $+(%,$sockname) 1 | var %signal = 1 } 
          sockread &t 
        }
        if (%signal) {
          if ($21) { getfile+.logp $9 $2 %c $3 }
          .SIGNAL -n GETFILE+_UPD $chr9+($9,%c,$calc($ticks - $6),$2,$3,$fopen($9).fname,$+($10,$13,$15),$19) | if (!$sock($sockname)) { var %j = 1 }
        }
      }
    }
    if (%j == -1) { sockmark $sockname $puttok($sock($sockname).mark,%c,4,9) }
  }
}

; ($1)estado ($2)inicio ($3)tamaño ($4)bajado ($5)bajar ($6)ticks / ($7)tamres ($8)opcres / ($9) id/fopen
; ($10)ftp/http ($11)urllogin ($12)urlpassword ($13)urlhost ($14)urlpuerto  ($15)urlfichero / ($16)(ProxyHost ProxyPort)
; ($17) Carpeta ($18) File  / ($19) Fecha ($20) Ignorar html ($21) Log ($22) Abortar

; ###################### Alias ##################

; $1 = sockname , $2 = web , $3 = Puerto , $4- = mark
alias -l getfile+.con { sockopen $1 $2 $3 | sockmark $1 $4- }

alias -l posult+ {
  var %l = 0, %i = 1 | while ( $pos($1,$2,%i) ) { var %l = $ifmatch | inc %i } | if (%l > 0) { return $left($1,$calc(%l - 1)) } | else { return $1 }
}
alias -l urlchang+ {
  if ($prop == c) { 
    var %i = 0, %j = $len($1-) , %l
    while (%i < %j) { 
      inc %i | var %c = $mid($1-,%i,1) 
      if ( ($asc(%c) < 33) || ($asc(%c) > 126) || $pos({}|\^~[]#`,%c,1) ) { var %l = $+(%l,%,$base($asc(%c),10,16,2))  }  |  else { var %l = $+(%l,%c) }
    }
    return  %l
  }
  elseif ($prop == d) { 
    var %l = $1-  
    while ($pos(%l,%,1)) { var %k = $ifmatch | var %l = $+($mid(%l,1,$calc(%k - 1)),$chr($base($mid(%l,$calc(%k + 1),2),16,10)),$mid(%l,$calc(%k + 3)))  }  
    return  %l
  }
  else { return $1- }
}

; Return = Nombre del siguiente número de sock libre
alias -l getfile+.free {
  var %i = $iif(%getfile+.last isnum 1-97,$calc(%getfile+.last + 1),1) | var %n = $+($1,$iif(%i < 10,0),%i)
  while ( $sock($+(getfile+.?,%n,*),0) || $fopen($+(getfile+.x,%n)) ) { inc %i | var %n = $+($1,$iif(%i < 10,0),%i) } 
  set %getfile+.last %i
  return $iif(%i isnum 1-99,%n,0)
}

alias -l getfile+.port {
  var %i = $rand($1,$2) , %j = 0
  while ( (%j < 50) && (!$portfree(%i) || (%i == $3)) ) { inc %j | var %i = $rand($1,$2) } | return $iif(%j >= 50,0,%i) 
}

alias -l getfile+.port2 { var %p1 = $calc($1 % 256) | var %p2 = $calc( ($1 - %p1) / 256 ) | return $+(%p2,$chr(44),%p1) }

alias getfile+close {
  var %abierto = 0
  if (getfile+.x?? iswm $1) {
    var %s = $+(getfile+.?,$right($1,2),*) 
    if ($sock(%s,0)) {
      var %s = $mid($sock(%s,1),1,12) | var %sockmark = $+(%s,$iif($sock($+(%s,b)),b))
      Getfile+Err $1 $gettok($sock(%sockmark).mark,21,9) %sockmark $+(%s,*) Descarga cancelada. | var %abierto = 1 
    }
    if ($fopen($1)) { .fclose $1 }
  }
  return %abierto
}

alias getfile+close.all {
  var %i = $sock($+(getfile+.*),0) 
  while (%i > 0) { var %s = $sock($+(getfile+.*),%i) | var %id = $+(getfile+.x,$mid(%s,11,2)) | getfile+close %id | dec %i } 
  .fclose getfile+.x*
}

alias getfile+ { 
  if ($0 == 0) { echo -a 02getfile+ - Type 12/getfile+ /? to see the available help or 12/getfile+ /o to modify the options. }
  else {
    if ($1- == /o) { getfile+_opc }
    elseif ($1- == /o+) {
      if ($dialog(mgetfile+_d)) { getfile+_opc | did -ve getfile+_opc 5,12,15,75 | dialog -t getfile+_opc $chr(160) $+ Options (Generals + Download Manager) } 
    }
    elseif ($1- == /?) { 
      echo -a - | echo 01 Usage:
      echo -a                  02 1- getfile+ [-options] url [target] 
      echo -a                  02 2- var % $+ v = $ $+ getfile+(url,target).options
      echo -a   05- url is the link to the file to be downloaded.
      echo -a   05- target is optional, by default is the Getdir on mIRC (DCC usually).
      echo -a   05- Options:
      echo -a      a -> Resume , o -> Overwrite. If files exists, this selects what addon will do. If both "oa" are indicated, "o" has preference.
      echo -a      d -> Forces direct download. If not indicated a proxy HTTP will be used if it was especified on getfile+ configuration.
      echo -a      l  -> Show download log on a @window (named @Getfile+.Xnn,where Getfile+.Xnn is the local identifier of the download)
      echo -a      i  -> Ignores check to detect if HTTP server sends an informative html file. Use it carefully.
      echo -a   05- with option 2 you can look % $+ v to know if an error was returned. If it was it will be returned on the form $&
        14Error: <reason> , else it will return local identifier Getfile+.Xnn of the download.
      echo -a   05.Examples: 1) Getfile+ -ol http://usuarios.lycos.es/addonsmirc/files/nksbot.zip c:\socketsbots.zip and $&
        2) var % $+ a = $ $+ Getfile+(http://usuarios.lycos.es/addonsmirc/files/nksbot.zip,c:\socketsbots.zip).ol
      echo -a Note: Using command line format (/getfile+) both url and download path supports spaces on their name if they are enclosed with "". 
      echo -a -General options can be set using the dialog /getfile+ /o
      echo -a -
    }
    else { 
      var %parametros = $regex($1-,/"(.*?)"\s|"(.*?)"?$|([^ ]+)\s|([^ ]+)$/g)
      if ($isid) { var %opcion = $prop , %url = $1 , %dest = $2 }
      else { 
        if ($left($regml(1),1) == -) { var %opcion = $mid($regml(1),2) , %url = $regml(2) , %dest = $regml(3) }
        else { var %opcion , %url = $regml(1) , %dest = $regml(2) } 
      }
      if ( ($left(%url,7) != http://) && ($left(%url,6) != ftp://) ) { var %url = $+($iif($left(%url,4) == ftp.,ftp,http),://,%url) }
      var %siexiste = $iif(o isin %opcion,o,$iif(a isin %opcion,a)) | var %urlm = $getfile+.url(%url)
      var %log = $iif(l isin %opcion,1,0) | var %ihtml = $iif(i isin %opcion,1,0)
      if ( $gettok(%urlm,1,32) == Error: ) { return %urlm }
      else {
        var %name = $gettok($gettok(%urlm,-1,47),-1,63) | var %file = $getfile+.file(%dest,%name)
        if ( $gettok(%file,1,32) == Error: ) { return %file }
        else { 
          if ($isfile(%file)) { var %q = $iif(%siexiste == a,$chr9+($file(%file).size,1),$iif(%siexiste == o,$chr9+(0,2))) }
          else { var %q = $chr9+(0,0) }
          if (%q == $null) { return Error: File exists and you have not selected resume or overwrite mode. }
          else {
            var %proxy = $iif((d !isin %opcion) && $gettok(%getfile+.opc,4,32) && $gettok(%getfile+.opc,5,32) && $gettok(%getfile+.opc,6,32),$gettok(%getfile+.opc,5,32) $gettok(%getfile+.opc,6,32),0)
            var %tipo = $+(getfile+.,$iif(%proxy,h,$left(%urlm,1))) | var %free = $getfile+.free
            if (%free) {
              var %socket = $+(%tipo,%free) | var %id = $+(getfile+.x,%free)
              var %sockmark  = $chr9+(0,0,-1,0,0,0,%q,%id,%urlm,%proxy,$nofile(%file),$nopath(%file),0,%ihtml,%log,0,0)
              tokenize 9 %sockmark | sockopen %socket $iif(%proxy,%proxy,$13 $14) | sockmark %socket %sockmark
              if ($21) {
                if ($window($+(@,$9)) == $null) { window -en $+(@,$9) }
                titlebar $+(@,$9) $+($10,$13,$15) | echo $+(@,$9) - | echo $+(@,$9)  (•) Downloading $+($10,$13,$15)
                getfile+.logd $9 Connecting... ( $+ $iif($16,$replace($16,$chr(32),:),$+($13,:,$14)) $+ ) 
              }
              return %id
            }
            else { return Error: No name sockets available. }
          }
        }
      }
    }
  }
}

alias -l getfile+.url {
  if ($isid && $0) {
    if ( ($right($1,1) == /) || ($gettok($1,3,47) == $null) ) { return Error: File not selected. }
    elseif (http://* iswm $1) { var %login = 0 | var %pass = 0 | var %port = 80  }
    elseif (ftp://* iswm $1) { var %login = anonymous | var %pass = mi@email.es | var %port 21 }
    else { return Error: Url not found. }
    var %host = $gettok($1,2,47)
    if ($chr(32) isin %host) { return Error: Invalid Host Name. }
    else {
      if ( $numtok(%host,64) > 1 ) {
        var %login = $deltok(%host,-1,64) | var %host = $gettok(%host,-1,64)
        if ( $numtok(%login,58) > 1 ) { var %pass = $deltok(%login,1,58) | var %login = $gettok(%login,1,58) } | else { return Error: Invalid Login/Password. }
      }
      if ( $numtok(%host,58) > 1) {
        if ($gettok(%host,2-,58) isnum 1-) { var %port = $ifmatch | var %host = $gettok(%host,1,58) } | else { return Error: Invalid Port. } 
      }
      return $chr9+($+($gettok($1,1,47),//),%login,%pass,%host,%port,$+(/,$gettok($1,3-,47)))
    }
  }
}

; $1 = ruta\¿fichero? , $2 = ¿fichero?
alias -l getfile+.file {
  if ($1 == $null) { return $+($getdir($2),$2) } | elseif ($isdir($1)) { return $+($1,$iif($right($1,1) != \,\),$2) }
  else {
    if ( $nofile($1) == $null) { return $+($getdir($1),$1) } | elseif ($isdir($nofile($1))) { return $1 }
    else { return Error: Download Folder $+(",$nofile($1),") doesn`t exist. }
  }
}

alias -l chr9+ { var %i = 0 , %j = $0 , %l | while (%i < %j) { inc %i | var %l = $+(%l,$iif(%i > 1,$chr(9)),$eval($+($,%i),2)) } | return %l }

; $1 = id , $2- = texto
alias -l getfile+.logd { if ($window($+(@,$1))) { echo $+(@,$1) 04 (i) Status: $2- } }

; $1 = id , $2 = inicio , $3 = descargado , $4 = total
alias -l getfile+.logp {
  if ( $window($+(@,$1)) ) {
    var %n = $line($+(@,$1),0)
    var %l = $+($bytes($calc($2 + $3),3).suf,/,$iif($4 > 0,$bytes($4,3).suf,??)) $+($chr(40),$iif($4 > 0,$round($calc(100 * ($2 + $3)/ $4),1),??),%,$chr(41))
    if ( (%n > 0) && ($gettok($line($+(@,$1),%n),4,32) == Downloading...) ) {
      rline $+(@,$1) %n 04 (i) Status: Downloading... %l 
    }
    else { echo $+(@,$1) 04 (i) Status: Downloading... %l }
  } 
}

alias -l getfile+.logc { if ($1 && $window($+(@,$3))) { echo $+(@,$3) 12 -> Received: $4- } }
; $1 = %log , $2 = comando , $3 = id , $4- = texto
alias -l getfile+.loge { if ($1 && $window($+(@,$3))) { echo $+(@,$3) 02 <- Sent: $4- } | $2 $4- }

; $1 = id , $2 = log , $3 = marksocket ,  $4 = CerrarSocket , $5 = reintentar , $6- = Mensaje
alias -l Getfile+Ok { 
  var %s = $sock($3).mark | if ($2) { getfile+.logd $1 $6- }
  if ($4 && $sock($4,0)) { sockclose $4 } | if ($fopen($1)) { .fclose $1 }
  if (%s != $null) {
    var %url = $+($gettok(%s,10,9),$gettok(%s,13,9),$gettok(%s,15,9))
    .SIGNAL -n GETFILE+_OK $chr9+($1,$gettok(%s,4,9),$calc($ticks - $gettok(%s,6,9)),$gettok(%s,2,9),$gettok(%s,3,9),$+($gettok(%s,17,9),$gettok(%s,18,9)),%url ,$gettok(%s,19,9)) 
  }
}

; $1 = id , $2 = log , $3 = Marksocket , $4 = CerrarSocket , $5- = Mensaje
alias -l Getfile+Err {
  var %s = $sock($3).mark | if ($2) { getfile+.logd $1 $5- }
  if ($4 && $sock($4,0)) { sockclose $4 } | if ($fopen($1)) { .fclose $1 }
  if (%s != $null) {
    var %url = $+($gettok(%s,10,9),$gettok(%s,13,9),$gettok(%s,15,9)) | var %t = $gettok(%s,6,9) 
    .SIGNAL -n GETFILE+_ERR $chr9+($1,$gettok(%s,4,9),$iif(%t > 0,$calc($ticks - %t),0),$gettok(%s,2,9),$gettok(%s,3,9),$+($gettok(%s,17,9),$gettok(%s,18,9)),%url,$gettok(%s,19,9),$gettok(%s,22,9),$5-) 
  }
}
