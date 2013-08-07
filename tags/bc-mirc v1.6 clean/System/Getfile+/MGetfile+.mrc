on 1:load: { 
  if ( $version < 6.11 ) {
    echo -s 5*** This addon needs mirc 6.11 or later. File $+(",$script,") will be unloaded now
    .unload -rs $+(",$script,") | halt
  }
  else { 
    echo -s 05*** Addon MGetfile+ 1.19 (Multiple Download Manager) loaded correctly.02 by12 [Niko]02 
  }
}


alias -l _mgfmdxini {
  var %a = $_mgfmdxdll(SetMircVersion,$version) | if ($gettok(%a,1,32) == error) { echo -s %a | dialog -x $1 }
  else { var %a = $_mgfmdxdll(MarkDialog,$1) | if ($gettok(%a,1,32) == error) { echo -s %a | dialog -x $1 } }
}
alias -l _mgfmdxdll { return $dll( $shortfn($scriptdirdlls\mdx.dll),$1,$2- ) }
alias -l _mgfviewsdll { return $dll( $shortfn($scriptdirdlls\mdx.dll) ,$1,$2- > $shortfn($scriptdirdlls\views.mdx) )  }
alias -l _mgfbarsdll { return $dll( $shortfn($scriptdirdlls\mdx.dll) ,$1,$2- > $shortfn($scriptdirdlls\bars.mdx) )  }

alias mgetfile+ {
  if ($version < 6.11) { echo -s <Addon MGETFILE+> mIRC required version: 6.11 , installed version: $version $+ . I can't continue. }
  elseif ($isalias(getfile+)) { dialog $iif($dialog(mgetfile+_d) != $null, -ver , -dm mgetfile+_d ) mgetfile+_d }
  else { echo -s <Addon MGETFILE+> Getfile+ not installed, i can't continue. }
}
alias mgetfile+_icos { return $shortfn($+($scriptdirimagenes\,$1-)) }

;################# Dialogs #####################

dialog mgetfile+.url {
  title " Url"
  size -1 -1 223 36
  option dbu,notheme
  icon $mgetfile+_icos(url.ico), 0
  edit "", 1, 5 6 214 10, result autohs
  button "Ok", 10, 79 21 29 12, ok
  button "Cancel", 11, 111 21 28 12, cancel
}

on *:dialog:mgetfile+.url:init:*: {
  if (($cb(0) == 1) && ($cb(1).len < 254) && ($numtok($remove($cb(1),://),47) > 1)) { did -o $dname 1 1 $cb(1) }
}

dialog mgetfile+.error {
  title " Attention"
  size -1 -1 140 50
  option dbu,notheme
  icon $mgetfile+_icos(info.ico), 0
  text "", 2, 5 5 131 27
  button "Ok", 1, 56 34 28 12, ok
}

dialog mgetfile+.about {
  title " About"
  size -1 -1 160 75
  option dbu
  icon $mgetfile+_icos(about.ico), 0
  button "Ok", 1, 66 60 28 12, ok
  text "English version translated by Mefisto", 3, 6 47 89 8
  link "http://www.averno.org", 17, 97 47 60 8
  link "http://mircaddons.webcindario.com", 11, 32 36 86 8
  link "http://www.escripting.org", 15, 32 27 65 8
  text "Updates:", 8, 6 27 23 8
  link "E-Mail", 10, 118 5 15 8
  text "MGetfile+ 1.19   by [Niko]", 7, 38 5 76 8, center
  text "Multiple Download Manager", 9, 36 15 80 8, center
  text "(spanish)", 2, 134 5 23 8
}


on *:dialog:mgetfile+.about:sclick:10: { run mailto:niko11@eresmas.com }
on *:dialog:mgetfile+.about:sclick:11: { url -n http://mircaddons.webcindario.com }
on *:dialog:mgetfile+.about:sclick:17: { url -n http://www.averno.org }
on *:dialog:mgetfile+.about:sclick:15: { url -n http://www.escripting.org }

dialog mgetfile+.leyenda {
  title " Legend"
  size -1 -1 124 84
  option dbu,notheme
  icon $mgetfile+_icos(leyenda.ico), 0
  icon 1, 7 5 16 16,  $mgetfile+_icos(gris.ico), 0
  icon 2, 7 24 16 16,  $mgetfile+_icos(amarill0.ico), 0
  icon 3, 7 43 16 16,  $mgetfile+_icos(amarillo.ico), 0
  icon 4, 7 62 16 16,  $mgetfile+_icos(verde0.ico), 0
  icon 5, 65 5 16 16,  $mgetfile+_icos(verde.ico), 0
  icon 6, 65 24 16 16,  $mgetfile+_icos(ok.ico), 0
  icon 7, 65 43 16 16,  $mgetfile+_icos(ok0.ico), 0
  icon 8, 64 62 16 16,  $mgetfile+_icos(rojo.ico), 0
  text "Pause", 9, 26 10 35 8
  text "Connected", 10, 26 67 35 8
  text "Downloading", 11, 84 10 35 8
  text "Completed", 12, 84 29 35 8
  text "On queue", 13, 26 28 35 8
  text "Error", 14, 84 67 35 8
  text "Connecting", 15, 26 48 35 8
  text "¿Completed?", 16, 84 48 35 8
}

dialog mgetfile+.detalles {
  title " Information"
  size -1 -1 257 91
  option dbu,notheme
  icon $mgetfile+_icos(detalles.ico), 0
  text "", 7, 8 67 243 18
  text "", 22, 30 11 208 8
  text "", 24, 39 20 199 8, hide disable
  text "N/A", 12, 27 40 220 8
  text "", 14, 238 0 4 4, hide
  button "c", 21, 240 10 9 9
  button "c", 23, 240 19 9 9, hide disable
  box "Link (url) ", 2, 3 2 250 30
  box "File", 5, 3 32 251 27
  box "Status", 1, 3 59 251 29
  text "N/A", 15, 27 49 199 8
  text "Name:", 3, 8 40 18 8
  text "Date:", 4, 8 49 18 8
  text "Original:", 6, 8 11 21 8
  text "Redirection: ", 8, 8 20 30 8, hide disable
  button "/run", 10, 234 48 16 9, hide disable
}

on *:dialog:mgetfile+.detalles:init:0: {
  did -o $dname 14 1 $did(mgetfile+_d,1,1).sel | var %date = $mgf+i($did(14).text,8,5-)
  if (%date != -) { did -o $dname 15 1 %date }
  did -o $dname 22 1 $mgf+i($did(14).text,9,5-) | did -o $dname 24 1 $mgf+i($did(14).text,10,5-)
  if (($did(24).text != -) && ($did(22).text != $did(24).text)) { did -ev $dname 8,24,23 }
  var %ico = $mgf+i($did(14).text,1,3) , %filein = $did(mgetfile+_d,3,$did(14).text).text , %fileout = $mgf+i($did(14).text,1,6-)
  var %e = Paused.,Waiting on queue.,Connecting to server.,Connected to server.,Downloading to disk.,File downloaded.
  var %f2 = $+($did(mgetfile+_d,19).text,%fileout) 
  if ((%ico isin 67) && $isfile(%f2)) { did -o $dname 12 1 %fileout  , Size : $bytes($file(%f2).size,b) bytes ( $+ $bytes($file(%f2).size,3).suf $+ ) | did -ev $dname 10 }                                                                                       
  elseif ($isfile($+($did(mgetfile+_d,19).text,%filein))) { did -o $dname 12 1 %filein (Temporary name, will be renamed after download) }
  if (%ico == 8) {
    var %error = $did(mgetfile+_d,14,$did(14).text).text
    did -o $dname 7 1 Error while downloading. Description: $iif($gettok(%error,1,32) == Error:,$gettok(%error,2-,32),%error)
  }
  elseif (%ico == 7) { did -o $dname 7 1 File downloaded, can't verify file size because server has not sent information about file size. }
  else { did -o $dname 7 1 $gettok(%e,%ico,44) }
}

on *:dialog:mgetfile+.detalles:sclick:10: { var %file = $+($did(mgetfile+_d,19).text,$mgf+i($did(14).text,1,6-)) | if ($isfile(%file)) { run $+(",%file,") } }

on *:dialog:mgetfile+.detalles:sclick:21,23: { clipboard $did($calc($did + 1)).text }

dialog mgetfile+.dellist {
  title " Attention"
  size -1 -1 146 51
  option dbu,notheme
  icon $mgetfile+_icos(borrar.ico), 0
  text "Data on selected items of download list will be deleted.", 2, 5 4 137 16
  button "Ok", 1, 41 36 28 12, ok
  button "Cancel", 4, 73 36 28 12, cancel
  check "Delete incomplete files too", 3, 5 22 130 10
  text "2", 5, 113 36 15 9, hide disable result center
}

on *:dialog:mgetfile+.dellist:init:0: { did -c $dname 3 }
on *:dialog:mgetfile+.dellist:sclick:1: { did -o $dname 5 1 $iif($did(3).state,2,1) }
on *:dialog:mgetfile+.dellist:sclick:4: { did -o $dname 5 1 0 }

dialog mgetfile+_d {
  title " Download Manager 1.19 [/MGetfile+]                                                   by [Niko]"
  size -1 -1 303 137
  option dbu,notheme
  icon $mgetfile+_icos(centro.ico), 0
  list 5, 2 2 212 16, size
  list 1, 2 25 299 110, size extsel
  list 21, 306 24 37 90, size hsbar
  text "Target:", 18, 4 17 20 8
  text "19", 19, 25 17 273 8
  button "Cancel", 2, 269 2 22 9, hide disable cancel
  list 3, 342 24 50 90, size hsbar
  list 7, 391 24 35 89, size hsbar
  text "ID", 6, 311 16 25 8, center
  text "Time", 8, 390 16 25 8, center
  text "Error", 10, 421 16 56 8, center
  text "File", 11, 344 16 39 8, center
  list 14, 425 24 65 89, size hsbar vsbar
  text "0", 4, 234 3 14 8, hide center
  text "", 15, 218 3 14 8, hide center
  text "0", 17, 249 3 17 8, hide center
}


;490 303

on 1:dialog:mgetfile+_d:init:0: {
  _mgfmdxini $dname 
  _mgfbarsdll SetControlMDX  $dname 5 toolbar list nodivider arrows flat nodivider noresize push wrap
  _mgfmdxdll SetBorderStyle $dname 5 | _mgfviewsdll SetControlMDX $dname 1 listview showsel rowselect report
  did -i $dname 1 1 headerdims  177:1 64:2 69:3 64:4 62:5 62:6 78:7 191:8 315:9 315:10
  did -i $dname 1 1 headertext $+(Name,$chr(9),+c Size,$chr(9),+c Completed,$chr(9),+c Percent,$chr(9),+c Time,$chr(9),+c Remaining,$chr(9),+c Speed,$chr(9),+c Date,$chr(9),+c Original link,$chr(9),+c Final link)
  did -i $dname 5 1 bmpsize 16 16
  var %ico = play.ico pause.ico nuevo.ico borrar.ico arriba.ico abajo.ico leyenda.ico destino.ico abrir.ico opciones.ico salir.ico lst.ico about.ico | var %i = 1
  while ($gettok(%ico,%i,32) != $null) { did -i $dname 5 1 setimage 0 icon small $mgetfile+_icos($ifmatch) | inc %i }

  did -a $dname 5 +a 1 $chr(9) $+ Start | did -a $dname 5 +a 2 $chr(9) $+ Pause
  did -a $dname 5 +a -
  did -a $dname 5 +a 12 $chr(9) $+ Load .lst 
  did -a $dname 5 +a - 
  did -a $dname 5 +a 3 $chr(9) $+ New | did -a $dname 5 +a 4 $chr(9) $+ Delete
  did -a $dname 5 +a -
  did -a $dname 5 +a 5 $chr(9) $+ Up | did -a $dname 5 +a 6 $chr(9) $+ Down
  did -a $dname 5 +a -
  did -a $dname 5 +a 7 $chr(9) $+ Legend
  did -a $dname 5 +a -
  did -a $dname 5 +a 8 $chr(9) $+ Choose Download Folder | did -a $dname 5 +a 9 $chr(9) $+ Open Download Folder
  did -a $dname 5 +a -
  did -a $dname 5 +a 10 $chr(9) $+ Options
  did -a $dname 5 +a -
  did -a $dname 5 +a 13 $chr(9) $+ About
  did -a $dname 5 +a -
  did -a $dname 5 +a 11 $chr(9) $+ Exit

  var %ico = gris.ico amarill0.ico amarillo.ico verde0.ico verde.ico ok.ico ok0.ico rojo.ico | var %i = 0 , %j = $numtok(%ico,32)
  while (%i < %j) { inc %i | did -i $dname 1 1 seticon list $mgetfile+_icos($gettok(%ico,%i,32)) }

  if (!$isdir(%mgetfile+.dir)) { set %mgetfile+.dir $getdir } | did -o $dname 19 1 %mgetfile+.dir | if (!%getfile+.opc) { getfile+ /o+ }

  var %file = $+($scriptdir,mgetfile+.dat) | var %l = $iif($isfile(%file),$lines(%file),0)
  if (%l > 5) {
    didtok $dname 21 32 $read(%file,1) | didtok $dname 3 32 $read(%file,2) | didtok $dname 7 32 $read(%file,3) | didtok $dname  14 9 $read(%file,4)
    loadbuf $+(6-,%l) -o $dname 1 $+(",%file,")
  }
  else { did -a $dname 21,3,7,14 - }
  did -o $dname 15 1 C:\
  mgetfile+_limit
}

on *:dialog:mgetfile+_d:close:0: {
  var %file = $+($scriptdir,mgetfile+.dat)
  did -u $dname 1 | did -o $dname 4 1 1 | var %i = $did($dname,21).lines | while (%i > 1) { mgetfile+_parar %i 1 | dec %i }
  write -c $+(",%file,") | write $+(",%file,") - $iif($did(3).lines > 1,$str($+($chr(32),0),$calc($did(3).lines - 1))) | write $+(",%file,") $didtok($dname,3,32)
  write $+(",%file,") $didtok($dname,7,32) | write $+(",%file,") $didtok($dname,14,9) 
  savebuf -ao $dname 1 $+(",%file,")
}

on 1:dialog:mgetfile+_d:dclick:1: {
  if ($did(1,0).sel == 1) {
    if (!$dialog(mgetfile+.detalles)) { dialog -am mgetfile+.detalles mgetfile+.detalles | did -o mgetfile+.detalles 14 1 $did(1,1).sel }
  }
}

on 1:dialog:mgetfile+_d:sclick:5: {
  var %sel = $gettok($did($dname,$did).seltext,2,32)
  if (%sel == 1) {
    if ($did(1,0).sel > 0) {
      var %i = $ifmatch
      while (%i > 0) {
        var %sel = $did(1,%i).sel | var %ico = $mgf+i(%sel,1,3)
        if (%ico isin 18) { var %z = $mgetfile+_chico(%sel,2) | did -o $dname 14 %sel 0 }
        dec %i 
      }
      mgetfile+_limit 
    }
  }
  elseif (%sel == 2) {
    if ($did(1,0).sel > 0) { var %i = $ifmatch | while (%i > 0) { mgetfile+_parar $did(1,%i).sel 0 | dec %i } | mgetfile+_limit }
  }
  elseif (%sel == 3) {
    if (!$dialog(mgetfile+.url)) {
      var %url = $dialog(mgetfile+.url,mgetfile+.url,-4)
      if (%url) {
        if ($len(%url) < 254) { mgetfile+_add %url | if (!$gettok(%getfile+.opc,9,32)) { mgetfile+_limit } }
        else { 
          if (!$dialog(mgetfile+.error)) {
            dialog -am mgetfile+.error mgetfile+.error | did -o mgetfile+.error 2 1 This download manager can't only work with urls with less than 253 chars.
          }
        }
      }
    }
  }
  elseif (%sel == 4) {
    if ($did(1,0).sel > 0) {
      var %i = $ifmatch
      if (!$dialog(mgetfile+.dellist)) {
        var %delete = $dialog(mgetfile+.dellist,mgetfile+.dellist,-4) 
        if (%delete isnum 1-2) {
          did -o $dname 17 1 1 | while (%i > 0) { mgetfile+_del $did(1,%i).sel $iif(%delete == 2,1,0) | dec %i } | did -o $dname 17 1 0
          mgetfile+_limit 
        }
      }
    }
  }
  elseif (%sel == 5) {
    if ($did(1,0).sel > 0) {
      var %j = $ifmatch , %i = 0
      while (%i < %j) {
        inc %i 
        if ( ($did(1,%i).sel > 2) && ( (%i == 1) || ($did(1,$calc(%i - 1)).sel != $calc($did(1,%i).sel - 1))) ) {
          var %sel = $did(1,%i).sel | mgetfile+_chline $dname %sel $calc(%sel - 1)
        }
      }
    }
  }
  elseif (%sel == 6) { 
    if ($did(1,0).sel > 0) {
      var %i = $ifmatch
      while (%i > 0) {
        if ( ($did(1,%i).sel < $did(1).lines) && ( (%i == $did(1,0).sel) || ($did(1,$calc(%i + 1)).sel != $calc($did(1,%i).sel + 1))) ) {
          var %sel = $did(1,%i).sel | mgetfile+_chline $dname %sel $calc(%sel + 1)
        }
        dec %i 
      }
    }
  }
  elseif (%sel == 7) {
    if (!$dialog(mgetfile+.leyenda)) { dialog -am mgetfile+.leyenda mgetfile+.leyenda }
  }
  elseif (%sel == 8) {
    if ($did(1).lines > 1) {
      if (!$dialog(mgetfile+.error)) {
        dialog -am mgetfile+.error mgetfile+.error | did -o mgetfile+.error 2 1 Download list must be clear to change download folder.
      }
    }
    else {
      var %dir = $iif($isdir($did(19).text),$did(19).text,$getdir) | var %dir = $sdir(%dir,Select a folder for downloads) 
      if (%dir != $null) { did -o $dname 19 1 %dir | set %mgetfile+.dir %dir }
    }
  }
  elseif (%sel == 9) { run $+(",%mgetfile+.dir,") }
  elseif (%sel == 10) { getfile+ /o+ }
  elseif (%sel == 11) { dialog -c $dname }
  elseif (%sel == 12) {
    if ($sfile($+($did(15).text,*.lst),Select a file with link list,Cargar) != $null) {
      var %file = $ifmatch | var %Lines = $lines(%file) | did -o $dname 15 1 $nofile(%file)
      if (($file(%file).size > 7000) || (%Lines > 100)) {
        if (!$dialog(mgetfile+.error)) {
          dialog -am mgetfile+.error mgetfile+.error | did -o mgetfile+.error 2 1 File you have selected is too big or it has too many lines (Protection against manager block).
        }
      }
      elseif (%Lines > 0) {
        var %i = 0
        while (%i < %Lines) { inc %i | mgetfile+_add $read(%file,%i) }
        if (!$gettok(%getfile+.opc,9,32)) { mgetfile+_limit }
      }
    }
  }
  elseif (%sel == 13) {
    if (!$dialog(mgetfile+.about)) { dialog -am mgetfile+.about mgetfile+.about }
  }
}
;################ SIGNALS de GETFILE+ ######################

;$1 = id ; $2 = bajado ; $3 = Tiempo (mseg.) ; $4 = bytes iniciales fichero ; $5 = Tamaño ; $6 = Nombre Fichero ; $7 = Url ; $8 = fecha
on *:signal:GETFILE+_UPD: {
  if ($dialog(mgetfile+_d)) {
    tokenize 9 $1-
    if ($didwm(mgetfile+_d,21,$1)) {
      var %l = $ifmatch |  var %v = $calc(1000 * $2 / $3) | if ((%v > $5) && ($5 != -1)) { var %v = $5 }
      var %z = $mgetfile+_chico(%l,5,$+($chr(160),$gettok($gettok($7,-1,47),1,63)),$iif($5 == -1,??,$bytes($5,3).suf),$bytes($calc($4 + $2),3).suf,$iif($5 == -1,??,$+($round($calc(100 * ($2 + $4)/ $5),1),%)),$duration($int($calc( ($3 / 1000) + $did(mgetfile+_d,7,%l).text)),3),$iif($5 == -1,??,$duration($calc(($5 - ($4 + $2)) / %v),3)),$+($bytes(%v,3).suf,/,seg),$8,$mgf+i(%l,9,5-),$7).upd
      if ($dialog(mgetfile+_d).h < 200) { mgetfile+_restante }
    }
  }
}


;$1 = id ; $2 = bajado ; $3 = Tiempo (mseg.) ; $4 = bytes iniciales ; $5 = bytes totales fichero, -1 si el server HTTP no informó del tamaño del fichero ; $6 = Nombre Fichero ; $7 = Url ; $8 = fecha
on *:signal:GETFILE+_OK: {
  if ($dialog(mgetfile+_d)) {
    tokenize 9 $1-
    if ($didwm(mgetfile+_d,21,$1)) {
      var %l = $ifmatch | beep 2 80 | var %file = $mgetfile+_file($gettok($gettok($7,-1,47),1,63))
      did -o mgetfile+_d 7 %l  $int($calc( ($3 / 1000) + $did(mgetfile+_d,7,%l).text )) | did -o mgetfile+_d 21 %l 0
      var %z = $mgetfile+_chico(%l,$iif($5 == -1,7,6),%file)
      if ($dialog(mgetfile+_d).h < 200) { mgetfile+_restante }
      .rename $+(",$6,") $+(",$nofile($6),%file,") | if (!$exists($6)) { did -o mgetfile+_d 3 %l 0 }
      mgetfile+_limit
    }
  }
}

;$1 = id ; $2 = bajado ; $3 = Tiempo (mseg.) ; $4 = bytes iniciales ; $5 = bytes totales fichero ; $6 = Nombre Fichero ; $7 = Url ; $8 = fecha ; $9 = 1 ó 0 según si se hizo o no alguna operación en el HD ; $10- = Descripción del error
on *:signal:GETFILE+_ERR: { 
  if ($dialog(mgetfile+_d)) {
    tokenize 9 $1-
    if ($didwm(mgetfile+_d,21,$1)) {
      var %l = $ifmatch | if ( (cancelada !isin $10- ) || (!$did(mgetfile+_d,4).text && !$did(mgetfile+_d,17).text) ) { beep 1 }
      mgetfile+_parado %l $iif(cancelada isin $10-,$iif($did(mgetfile+_d,4).text,2,1),8) $int($calc( ($3 / 1000) + $did(mgetfile+_d,7,%l).text )) $10- 
      if ($dialog(mgetfile+_d).h < 200) { mgetfile+_restante }
      mgetfile+_limit 
    }
  }
}

;$1 = id ; $2 = reservado ; $3 = ¿Proxy? ; $4 = Host ; $5 = Puerto ; $6 = Nombre Fichero ; $7 = Url 
on *:signal:GETFILE+_CONNECT: {
  if ($dialog(mgetfile+_d)) {
    tokenize 9 $1-
    if ($didwm(mgetfile+_d,21,$1)) {
      var %l = $ifmatch | var %z = $mgetfile+_chico(%l,4)
      if ($dialog(mgetfile+_d).h < 200) { mgetfile+_restante }
    }
  }
}

; ################## Alias #########################3

; $1 = Linea , $2 = icono , $3 = File , $4 = Size , $5 = completado , $6 = % , $7 = Tiempo , $8 = Restante , $9 = Vel , $10 = Fecha , $11 = Url , $12- = UrlF
alias -l mgetfile+_chico {
  if (s isin $gettok($did(mgetfile+_d,1,$1).text,2,32)) { var %sel = 1 | did -uk mgetfile+_d 1 $1 } | else { var %sel = 0 }
  if ($prop) { did -o mgetfile+_d 1 $1 1 + $2 0 0 $3 $chr(9) $4 $chr(9) $5 $chr(9) $6 $chr(9) $7 $chr(9) $8 $chr(9) $9 $chr(9) $10 $chr(9) $11 $chr(9) $12- }
  else {
    did -o mgetfile+_d 1 $1 1 + $iif($2,$2,$mgf+i($1,1,3)) $iif($3,$3,$mgf+i($1,1,6-)) $chr(9) $iif($4,$4,$mgf+i($1,2,5-)) $chr(9) $iif($5,$5,$mgf+i($1,3,5-)) $chr(9) $iif($6,$6,$mgf+i($1,4,5-)) $chr(9) $iif($7,$7,$mgf+i($1,5,5-)) $chr(9) $iif($8,$8,$mgf+i($1,6,5-)) $chr(9) $iif($9,$9,$mgf+i($1,7,5-)) $chr(9) $iif($10,$10,$mgf+i($1,8,5-)) $chr(9) $iif($11,$11,$mgf+i($1,9,5-)) $chr(9) $iif($12,$12-,$mgf+i($1,10,5-)) 
  }
  if (%sel == 1) { did -ck mgetfile+_d 1 $1 }
}

; $mgf+i(2,1,3) $mgf+i(2,1,6-) $mgf+i(2,2,5-)  $mgf+i(2,3,5-) $mgf+i(2,4,5-) $mgf+i(2,5,5-) $mgf+i(2,6,5-) $mgf+i(2,7,5-) $mgf+i(2,8,5-) $mgf+i(2,9,5-) $mgf+i(2,10,5-)
;        icono             fichero            tamaño         completado       porcentaje          tiempo           restante          velocidad            fecha                url             urlf

; $1 = Linea , $2 = num1 , $3 = num2
alias -l mgf+i { return $iif($gettok($gettok($did(mgetfile+_d,1,$1).text,$2,9),$3,32),$ifmatch,??)  }

; $1 = línea , $2 = Volver cola (no pausar)
alias -l mgetfile+_parar {
  if ($did(mgetfile+_d,21,$1).text) {
    var %j = $getfile+close($did(mgetfile+_d,21,$1).text)
    if (%j == 0) { mgetfile+_parado $1 $iif($did(mgetfile+_d,4).text,2,1) $duration($mgf+i($1,5,5-)) Unexpected error. } 
  }
  elseif (!$did(mgetfile+_d,4).text) { var %ico = $mgf+i($1,1,3) | if (%ico isin 28) { var %z = $mgetfile+_chico($1,1) } }
}

; $1 = línea , $2 = icono , $3 = Tiempo total , $4- = mensaje
alias -l mgetfile+_parado {
  var %z = $mgetfile+_chico($1,$2,$null,$null,$null,$null,$duration($3,3),-,-,$null,$null,$null)
  did -o mgetfile+_d 21 $1 0 | if ($4 != $null) { did -o mgetfile+_d 14 $1 $4- } | if ($3 isnum 1-) { did -o mgetfile+_d 7 $1 $3 }
}

; $1 = linea
alias -l mgetfile+_play {
  var %url = $mgf+i($1,9,5-) | var %file = $+($did(mgetfile+_d,19).text,$did(mgetfile+_d,3,$1).text)
  if ($gettok(%getfile+.opc,10,32)) { var %id = $getfile+(%url,%file).al } | else { var %id = $getfile+(%url,%file).a }
  if ($gettok(%id,1,32) == Error:) { var %z = $mgetfile+_chico($1,8) | did -o mgetfile+_d 14 $1 %id }
  else { var %z = $mgetfile+_chico($1,3) | did -o mgetfile+_d 21 $1 %id }
}

;-------------------------------
; $1- = url
alias mgetfile+_url  { if ($dialog(mgetfile+_d)) { mgetfile+_add $1- } }

; $1- = url
alias -l mgetfile+_add {
  if (($len($1-) < 254) && ($numtok($remove($1-,://),47) > 1)) {
    var %file = $gettok($gettok($1-,-1,47),1,63) 
    did -a mgetfile+_d 1 1 + $iif($gettok(%getfile+.opc,9,32),1,2) 0 0 $+($chr(160),%file) $chr(9) - $chr(9) 0kb $chr(9) 0%  $chr(9) $duration(0,3) $chr(9) - $chr(9) - $chr(9) - $chr(9) $1- $chr(9) -
    did -a mgetfile+_d 21,7,14 0 | did -a mgetfile+_d 3 $mgetfile+_file(%file,.gf!)
  }
}

; $1 = linea , $2 = Borrar fichero
alias -l mgetfile+_del {
  var %ico = $mgf+i($1,1,3)
  if (%ico isin 345) {  if ($did(mgetfile+_d,21,$1).text) { getfile+close $did(mgetfile+_d,21,$1).text }  }
  if ($2 && (%ico !isin 67)) { 
    var %file = $+($did(mgetfile+_d,19).text,$did(mgetfile+_d,3,$1).text) | if ($isfile(%file)) { .remove $+(",%file,") }
  }
  did -d mgetfile+_d 1,21,3,7,14 $1 
}

; $1 = dialog , $2 = linea sel. , $3 = linea
alias -l mgetfile+_chline {
  var %linea = $did($1,1,$3).text
  did -uk $1 1 $2 | did -o $1 1 $3 $did($1,1,$2).text | did -ck $1 1 $3 | did -o $1 1 $2 %linea
  var %linea = $did($1,21,$3).text | did -o $1 21 $3 $did(21,$2).text | did -o $1 21 $2 %linea
  var %linea = $did($1,3,$3).text | did -o $1 3 $3 $did($1,3,$2).text | did -o $1 3 $2 %linea
  var %linea = $did($1,7,$3).text | did -o $1 7 $3 $did($1,7,$2).text | did -o $1 7 $2 %linea
  var %linea = $did($1,14,$3).text | did -o $1 14 $3 $did($1,14,$2).text | did -o $1 14 $2 %linea
}

; %getfile+.opc = (1)modo pasivo (2)puertoini (3)puertofinal (4)usar_proxy (5)proxy_ip (6)proxy_puerto (7)Limitar (8)Límite
alias mgetfile+_limit {
  if (!$did(mgetfile+_d,4).text) {
    var %i = 1 , %j = $did(mgetfile+_d,1).lines | var %activados = $wildtok($didtok(mgetfile+_d,21,32),getfile+.x*,0,32)
    var %limitar = $gettok(%getfile+.opc,7,32) | var %limite = $gettok(%getfile+.opc,8,32)
    while ( (%i < %j) && (!%limitar || (%activados < %limite)) ) { 
      inc %i | if ($mgf+i(%i,1,3) == 2) { mgetfile+_play %i | inc %activados }
    }
  }
}
;-------------------------------
; $1 = name file , $2 = ¿.gf!?
alias -l mgetfile+_file {
  var %i = 0 | var %file = $+($did(mgetfile+_d,19).text,$1,$2)
  while ($exists(%file) || $didwm(mgetfile+_d,3,$nopath(%file)) ) {
    inc %i | var %file = $+($did(mgetfile+_d,19).text,$mgf+pu($1,$iif($2,$chr($calc(%i + 96)),%i)),$2) 
  }
  return $nopath(%file) 
}
;$1 = nombre fichero , $2 indice
alias -l mgf+pu {
  var %l = 0, %i = 1 | while ( $pos($1,.,%i) ) { var %l = $ifmatch | inc %i }
  if (%l > 0) { return $+($left($1,$calc(%l - 1)),$chr(40),$2,$chr(41),$mid($1,%l)) }
  else { return $+($1,$chr(40),$2,$chr(41)) }
}

alias -l mgetfile+_restante {
  var %i = 2 , %t = 0 , %n = 0
  while ($didwm(mgetfile+_d,21,getfile+*,%i)) { var %i = $ifmatch | var %t2 = $mgf+i(%i,6,5-) | inc %i | inc %n | if ($duration(%t2) > %t) { var %t = $ifmatch }  }
  if (%n == 0) { dialog -t mgetfile+_d $chr(160) $+ Download Manager [/MGetfile+] }
  else { dialog -t mgetfile+_d $+($chr(160),[,$iif(%t == 0,??:??:??,$duration(%t,3)),]) $+($chr(40),%n,$chr(41)) }
}

on *:dialog:mgetfile+_d:active:*: { if ($dialog($dname).h < 200) { mgetfile+_restante } | else { dialog -t $dname $chr(160) $+ Download Manager [/MGetfile+] } }

on *:dialog:getfile+_opc:close:0: { if ($dialog(mgetfile+_d)) { mgetfile+_limit } }
