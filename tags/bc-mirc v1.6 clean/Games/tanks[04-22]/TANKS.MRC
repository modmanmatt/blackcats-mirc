on *:sockread:tanks:{
  var %tanks.O0OO0OO0, %tanks.O0OO0O0O
  if ($sockerr) {
    O0OOOOO0 $ifmatch $sockname sockread
    return
  }
  while ($sock($sockname)) {
    sockread %tanks.O0OO0OO0
    if ($sockbr !isnum 1-) return
    tokenize 32 %tanks.O0OO0OO0
    if ($1 == ver) {
      if ($2 != $tanksversion(1)) {
        if ($2 > $tanksversion(1)) O00O0000 The Tanks server has a newer version ( $+ $2 $+ ). Download the newest by typing $OO00O000(/downloadtanks) $+ .
        else O00O0000 The server has an older version ( $+ $2 $+ ). Your version is $tanksversion(1) $+ .
        OO000O0O
        continue
      }
      tokenize 32 $3-
    }
    if ($1 == O000OO0O) {
      while ($2) {
        tokenize 32 $2-
        aline @tanksO00000OO $1
      }
      if ($line(@tanksO00000OO,0) >= %tankswidth) {
        drawrect -rfn @Tanks %tanks.OOO0000O 1 0 0 %tankswidth %tanks.OO0OO0O0
        var %tanks.O0OO0O0O = 1, %tanks.O0000OO0 = 0
        while (%tanks.O0OO0O0O <= %tankswidth) {
          drawline -rn @Tanks %tanks.O0O0O00O 1 %tanks.O0000OO0 $line(@tanksO00000OO,%tanks.O0OO0O0O) %tanks.O0000OO0 %tanks.OO0OO0O0
          inc %tanks.O0OO0O0O
          inc %tanks.O0000OO0
        }
        %tanks.O0OOOOOO = O0000O00
        if (%tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] isnum) OOO00OOO
        O0OO000O O000O000
      }
      continue
    }
    elseif ($1 == O0000OO0) {
      filter -wwcx @tanksO00000OO @tanksO00000OO
      unset %tanks.O0OOOOOO
      %tanks.O00000O0 = $2
      if ($3 != 1) {
        O0O0000O
        tanks.alias.initvars
      }
    }
    elseif ($1 == O000O000) O0OO000O $1
    elseif ($1 == O000OO00) O0OO000O O00O00O0 $2
    elseif ($1 == O00O00O0) {
      var %tanks.O0000OO0 = $ctime - $2
      if (%tanks.O0000OO0) OOO0O0O0 O000O000 Your lag is $duration(%tanks.O0000OO0)
      else OOO0O0O0 O000O000 You have no lag
    }
    elseif ($1 == O00O0OO0) && (%tanks.O0OOOOOO == O0000O00) O0OOO000 0 $2-
    elseif ($1 == O00O0O0O) {
      %tanks.O00O0OO0 = $2
      %tanks.O00OO000 = $3
      %tanks.OO00O0O0 = $4
      %tanks.OO000000 = $5
      %tanks.O000O00O = $6
      %tanks.O0OO0OOO = $7
      %tanks.O0OOOO0O = $8
      %tanks.O00000O0 = $9
      OO0O0000
      OO0000OO
      if (%tanks.O0OOOOOO != O00000O0) {
        OO0000O0
        O000OO0O
        O0000000
        O000O00O
        drawdot @Tanks
      }
    }
    elseif ($1 == O00O000O) {
      %tanks.O00O000O [ $+ [ $4 ] ] = $2
      %tanks.O00OO0OO [ $+ [ $4 ] ] = $3
      O0OO0000 $4-
    }
    elseif ($1 == O00000O0) {
      if ($2) {
        %tanks.O0OO0OOO = $2
        %tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ] = $3
        %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ] = $4
      }
      OO0O00OO $5-
    }
    elseif ($1 == O00OO00O) O00O00OO $2-
    elseif ($1 == O00OOO0O) O00000OO $2-
    elseif ($1 == O00OO000) {
      %tanks.OO0OOOO0 = $calc(+$2)
      if (-99 > %tanks.OO0OOOO0) %tanks.OO0OOOO0 = $ifmatch
      elseif (99 < %tanks.OO0OOOO0) %tanks.OO0OOOO0 = $ifmatch
    }
    elseif ($1 == O000OOO0) && (%tanksnochat != 1) OOO0O0O0 O0000000 %tanks.O0OO0000 [ $+ [ $2 ] ] %tanks.O00OOOO0 [ $+ [ $2 ] ] $3-
    elseif ($1 == O0000O0O) && (%tanksnochat != 1) OOO0O0O0 O00000O0 %tanks.O0OO0000 [ $+ [ $2 ] ] %tanks.O00OOOO0 [ $+ [ $2 ] ] $3-
    elseif (%tanksnochat != 1) || ($2 == %tanks.OOO00OO0) || ($2 == 0) && ($1 == O00O0O00) O0O0O0OO $2-
    elseif ($1 == O000OOOO) {
      O00OOOOO 0 $2
      %tanks.O00OOOO00 = $3
      OO00OOO0
      close -@ @tanksO00000OO
      window -hl @tanksO00000OO
    }
    elseif ($1 == O0000O00) OO0OO00O $2-
    elseif ($1 == O00000OO) %tanksport = $2
    elseif ($1 == O000O0OO) OOO0O0O0 O0000OO0 $2-
    elseif ($1 == O00O0000) O000O0O0 $2-
    elseif ($1 == O000000O) OO0OO000 O000000O $2-
    elseif ($1 == O000O00O) OO0OO000 $2-
    elseif ($1 == O00O00OO) {
      if ($2) %tanks.OOO00OO0 = $2
      O00OO000 $3-
      if ($2) unset %tanks.O0OOOOOO
      else {
        O0000000
        drawdot @Tanks
        OO0O0000
      }
    }
    elseif ($1 == O00OO0O0) O0O00OO0 $2-
    elseif ($1 == O00OOO00) {
      O00O0000 The Tanks game at %tanksip is full.
      OO000O0O
    }
    elseif ($1 == O0000000) {
      O00O0000 Tanks: You're trying to reconnect too fast.
      OO000O0O
    }
    elseif ($1 == O000O0O0) {
      O00O0000 Tanks: You're banned from the server at %tanksip $+ .
      OO000O0O
    }
    elseif ($1 == O0000OOO) {
      O00O0000 Tanks: There is already a connection from your address.
      OO000O0O
    }
  }
}
alias -l O00OOO00 {
  if ($mouse.key & 2) || ($mouse.key & 4) && ($istok(O000000O O0000OOO O000O00O O000O0O0,$1,32)) return $1 $iif(%tanksinc == 1,5,1)
  return $1 %tanksinc
}
menu menubar,channel {
  Games
  . $iif($menu_,Tanks)
  ..$iif($server,Play &Tanks with [ $iif($1,$1,someone) ] ):{
    if ($1) tanks $1
    else tanks $$?="Tanks: Enter a nickname or IP address and port"
  }
  ..Pl&ay a private game (/tanks):tanks
  ..Start a t&emporary server (/tanks 0):tanks 0
  ..Start a &dedicated server (/tanksd):tanksd
  ..List Tanks &servers (/tanklist):tanklist
  ..-
  ..$O0O000O0(%tanksnoctcp,Disable Tanks &ctcp reply):%tanksnoctcp = $iif(%tanksnoctcp,0,1)
  ..$O0O000O0(%tanksnolisten,Ig&nore all Tanks requests):%tanksnolisten = $iif(%tanksnolisten,0,1)
  ..-
  ..&Version:abouttanks
  ..&Readme:tanksreadme
  ..-
  ..&Hide this menu:%tanksnomenu = 1
  ..&Uninstall Tanks:{
    if ($?!="Are you sure you want to unload Tanks and clear all of its variables?") {
      OOO0OO00
      unset %tanks*
      unload -rs tanks.mrc
    }
  }
}
alias -l OOO0O0OO {
  drawpic -c
  tokenize 32 15790320 0 8388608 32768 240 128 8388736 10526880 6316128 11579568 3158064 20644 15728640 16496 8421504 13684944 8388688 8411136 2121760
  close -@ @tanksO0000000
  if ($version < 5.71) window -pd @tanksO0000000
  else window -Bhp @tanksO0000000
  var %tanks.O00000OO = 0, %tanks.OO00000O
  while ($1 isnum) {
    drawdot -r @tanksO0000000 $1 0 1 1
    %tanks. [ $+ [ %tanks.O00000OO ] ] = $getdot(@tanksO0000000,1,1)
    tokenize 32 $2-
    inc %tanks.O00000OO
  }
  close -@ @tanksO0000000
  if (%tanks.14 == %tanks.8) %tanks.8 = $rgb(128,128,0)
}
on *:sockclose:tanks:{
  close -@ @Tanks request
  if ($window(@Tanks)) OOO0O0O0 O000O000 The server closed the connection
  else O00O0000 Tanks: Server closed the connection
  OO000O0O
}
alias -l OO0O00O0 {
  var %tanks.OO000O0O = $1, %tanks.O0OO0O0O = $2, %tanks.OO000O00 = $3, %tanks.OOO0OO0O = $4, %tanks.O00000OO = $5, %tanks.O000O000 = $6, %tanks.O00OOO0O = $7, %tanks.OO0O0O00 = $8, %tanks.OOO00O00 = $9, %tanks.OO00OO00 = $10, %tanks.O00O00O0 = $11-
  if ($dialog(tanklist)) && (%tanks.O00000OO isnum) && (%tanks.OO000O00 isnum) {
    if (/*tanks * iswm $did(tanklist,9,$did(tanklist,9).lines)) did -az tanklist 1,9 $str(-,198)
    did -az tanklist 1   $+ $iif(%tanks.OOO0OO0O,       Temp server: ,Dedicated server: ) %tanks.O0OO0O0O
    did -a tanklist 9 /tanks %tanks.OO000O0O %tanks.OO000O00
    var %tanks.O0000OO0 = did -az tanklist 1 $str( ,7) Settings/info: 
    if (%tanks.O00OOO0O) %tanks.O0000OO0 = %tanks.O0000OO0 Instagib     
    %tanks.O0000OO0 = %tanks.O0000OO0 $iif(%tanks.OO0O0O00,$iif(%tanks.OO0O0O00 == 1,Constant wind,Changing wind),No wind)     
    if (%tanks.OOO00O00) %tanks.O0000OO0 = %tanks.O0000OO0 $iif(%tanks.OOO00O00 == 1,Frag limit:,Round limit:) %tanks.OO00OO00     
    else %tanks.O0000OO0 = %tanks.O0000OO0 No limit     
    %tanks.O0000OO0 IP: %tanks.OO000O0O      Port: %tanks.OO000O00
    did -a tanklist 9 /tanks %tanks.OO000O0O %tanks.OO000O00
    var %tanks.OO0O0O0O = 0
    tokenize 32 %tanks.O00O00O0
    while (1) {
      var %tanks.O0000OO0 = 1
      while (%tanks.O0000OO0 == 1) || ($width($replace($ [ $+ 1- $+ [ %tanks.O0000OO0 ] ] ,$chr(32),    ),Tahoma,$iif($version < 5.91,13,11),0,0) < 450) && (* iswm $ [ $+ [ %tanks.O0000OO0 ] ] ) {
        inc %tanks.O0000OO0
      }
      dec %tanks.O0000OO0
      var %tanks.O0O00OO0 = $ [ $+ 1- $+ [ %tanks.O0000OO0 ] ]
      if (%tanks.OO0O0O0O) did -az tanklist 1 $str( ,30) $replace(%tanks.O0O00OO0,$chr(32),    )
      else did -az tanklist 1 $iif(?? iswm %tanks.O00000OO, ,   ) $+ $iif(?? iswm %tanks.O000O000, ,   ) %tanks.O00000OO / %tanks.O000O000  Players:  $replace(%tanks.O0O00OO0,$chr(32),    )
      did -a tanklist 9 /tanks %tanks.OO000O0O %tanks.OO000O00
      if (%tanks.O0000OO0) tokenize 32 $ [ $+ [ $calc(1+%tanks.O0000OO0) ] $+ ] -
      inc %tanks.OO0O0O0O
      if ($0 !isnum 1-) break
    }
    inc %tankslistcount %tanks.O00000OO
    %tanks.O0000OO0 = ( $+ %tankslistcount players total)
    dialog -t tanklist Tanks servers $iif(%tankslistcount,%tanks.O0000OO0)
  }
}
on *:sockclose:downloadtanks:OOO000OO
on *:dialog:tanksbots:init,sclick:*:{
  if ($devent == init) {
    did -o tanksbots 2 1 %tanksname
    did $iif(%tanksstopbots,-u,-c) tanksbots 18
    did $iif(%tankslvr,-c,-u) tanksbots 19
    did -r tanksbots 22,20
    var %tanks.OO000O0O = 1
    while (%tanks.OO000O0O <= %tanks.O000OOO0) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O0O ] ] isnum) && (%tanks.O00OO0OO [ $+ [ %tanks.OO000O0O ] ] isnum) {
        did -a tanksbots 20 %tanks.OO000O0O
        did -a tanksbots 22 %tanks.O00OOOO0 [ $+ [ %tanks.OO000O0O ] ]
      }
      inc %tanks.OO000O0O
    }
    OOO000O0
  }
  elseif ($did == 99) && ($dialog(tanksbots).focus == 2) || ($did == 3) {
    OO0OO0O0 $did(tanksbots,2)
    halt
  }
  elseif ($did isnum 12-17) OOO00000 $calc($did -12)
  elseif ($did == 18) {
    %tanksstopbots = 1 - $did(tanksbots,18).state
    O000O00O
  }
  elseif ($did == 19) %tankslvr = $did(tanksbots,19).state
  elseif ($did == 22) OOO000O0
  elseif ($did == 23) {
    if ($dialog(tankschat)) {
      dialog -ev tankschat
      return
    }
    var %tanks.O0OO0O0O = $dialog(tankschat,tanksname,-4)
    if ($did(tanksbots,22,1).sel) {
      var %tanks.O0000OO0 = $did(tanksbots,20,$ifmatch), %tanks.O0OO0O0O = $O0O00000($left(%tanks.O0OO0O0O,21),%tanks.O0000OO0)
      if (* iswm %tanks.O0OO0O0O) O0O0O0OO %tanks.O0000OO0 %tanks.O0OO0O0O
    }
  }
  elseif ($did == 24) O0000OO0 1
  elseif ($did == 25) {
    var %tanks.O0OO0O0O = $did(tanksbots,22,0).sel
    while ($did(tanksbots,22,%tanks.O0OO0O0O).sel) {
      var %tanks.OOO0OO0O = $did(tanksbots,22,%tanks.O0OO0O0O).sel
      var %tanks.O0000OO0 = $did(tanksbots,20,%tanks.OOO0OO0O)
      did -d tanksbots 20,22 %tanks.OOO0OO0O
      OO0OO000 %tanks.O0000OO0
      dec %tanks.O0OO0O0O
    }
    OOO000O0
  }
}
on *:sockread:tanklist*:{
  if ($sockname !isin tanklist2) return
  var %tanks.O0000OO0
  if ($sockerr) return
  while (1) {
    sockread %tanks.O0000OO0
    if ($sockbr !isnum 1-) return
    tokenize 32 %tanks.O0000OO0
    if ($sockname == tanklist) && (* !iswm $1-) {
      sockmark $sockname
      %tankslistcount = 0
      if (%tankslisting) && ($dialog(tanklist)) did -r tanklist 1,9,5
    }
    if ($sock($sockname).mark != wait) {
      if ($sockname == tanklist) {
        if ($1- == v) {
          abouttanks
          tanklistmsg You need the newest version of Tanks.
          return
        }
        if ($1- == vv) .downloadtanks
      }
      if (ip *.*.*.* iswm $1-2) && ($sock(tanks.*,0)) %tanksip = $2
      elseif (%tankslisting) && ($dialog(tanklist)) {
        if (<* iswm $1-) {
          if ($sockname == tanklist) {
            if (%tanksbackup) {
              unset %tanksbackup
              tanklistmsg Unable to connect.
            }
            else {
              %tanksbackup = 1
              socket tanklist2 tanks.ileet.net
              socket tanklist tanks.mircscripts.org
            }
          }
          else sockclose $sockname
          return
        }
        elseif ($sockname == tanklist) {
          if (rem ?* iswm $1-) {
            did -az tanklist 1 $2-
            did -a tanklist 9 rem
          }
          elseif (http://* ?* iswm $1-) {
            did -az tanklist 1 $2-
            did -a tanklist 9 $1
          }
          elseif (/*tanks* *?	?* iswm $1-) {
            did -az tanklist 1 $deltok($2-,1,9)
            did -a tanklist 9 $gettok($1-,1,9)
          }
          else OO0O00O0 $1-
        }
      }
      elseif ($sockname == tanklist) && (b? ?* iswm $1-) && ($window(@tanksO0000O00)) {
        aline @tanksO0000O00 $mid($1-,2)
        O0O0OO0O
        if ($1 == bm) dline @tanksO0000O00 $line(@tanksO0000O00,0)
      }
    }
  }
}
dialog tankschat {
  title "Tanks - Enter a message."
  option dbu
  size -1 -1 160 20
  edit "", 2, 4 5 122 11, autohs result limit 200
  button "&Send", 3, 131 5 25 11, ok
  list 1,0 0 0 0,hidedisable
}
on *:close:@Tanks request:OOO0OOO0 decline
on *:close:@tanksO000000O:OOO0OO00
alias -l OOO0OOOO {
  tokenize 32 %tanks.O0O0O000
  var %tanks.OO000O00, %tanks.O0000OO0 = -0.0065
  while (* !iswm %tanks.OO000O00) || (%tanks.O0000OO0 < $7) {
    inc %tanks.O0000OO0 .75
    if (%tanks.O0000OO0 > $7) %tanks.O0000OO0 = $7
    %tanks.OO000O00 = %tanks.OO000O00 $int($calc($1 +%tanks.O0000OO0 *($3 +$5 *%tanks.O0000OO0))) $int($calc($2 -1-%tanks.O0000OO0 *($4 -4.9*%tanks.O0000OO0)))
  }
  drawline -rn @Tanks %tanks.O0O00O00 2 $1-2 %tanks.OO000O00
  .timertanks.OO00O0O0 -om 1 1900 O0OO0OOO 4
}
alias -l O0OO0O0O OOO0OO0O action=remove
alias -l OOO00000 {
  var %tanks.OO000O00 = 1
  while (1) {
    var %tanks.OOO0OO0O = tanks. $+ %tanks.OO000O00
    if ($sock(%tanks.OOO0OO0O)) || (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) inc %tanks.OO000O00
    else break
  }
  if (%tanks.OO000O00 > %tanks.O000OOO0) return 1
  if ($1 !isnum 0-4) tokenize 32 $rand(0,4)
  else %tanksskill = $1
  %tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] = $1
  O0O00OO0 0 $1 %tanks.OO000O00 0 Skill  $+ $1
}
alias -l OOO00O0O {
  if ($window(@Tanks)) {
    OO0O0000
    OO0000OO
    OO0000O0
    O0000000
    O000O00O - $1
    OO000000
    if ($1 != 0) OO0O0O00
    else drawdot @Tanks
  }
}
alias -l OO0OO0O0 {
  var %tanks.OO000O00 = 1
  while (1) {
    var %tanks.OOO0OO0O = tanks. $+ %tanks.OO000O00
    if ($sock(%tanks.OOO0OO0O)) || (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) inc %tanks.OO000O00
    else break
  }
  if (%tanks.OO000O00 > %tanks.O000OOO0) return 1
  %tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] = 5
  if (%tanks.OOO00OO0 == 0) %tanks.OOO00OO0 = %tanks.OO000O00
  O0O00OO0 0 5 %tanks.OO000O00 $O0OOOOOO(%tankscolor) $O0O00000($iif($0,$1-,%tanks.O00OOOO0 [ $+ [ %tanks.OOO00OO0 ] ] ),%tanks.OO000O00)
}
alias -l O0OOO00O {
  drawpic -cnt @Tanks 16711935 206 409 202 26 110 23 %tanksbmp
  var %tanks.O0000OO0 = $O000000O
  if (%tanks.O0000OO0 < %tanks.O0OO0OOO) %tanks.O0000OO0 = %tanks.O0OO0OOO
  drawpic -cnt @Tanks 16711935 208 411 204 102 $calc(1+21*%tanks.O0000OO0) 19 %tanksbmp
  drawpic -cnt @Tanks 16711935 $calc(188+21*%tanks.O0OO0OOO) 416 $iif(%tanks.O0OOOO0O == %tanks.OOO00OO0,130 104,130 113) 20 9 %tanksbmp
}
alias -l OO0O0OOO {
  if ($dialog(tankschat)) {
    dialog -ev tankschat
    return
  }
  if ($0) var %tanks.O0OO0O0O = $1-
  else var %tanks.O0OO0O0O = $dialog(tankschat,tanksname,@Tanks)
  if (%tanks.OOO00OO0) %tanksname = %tanks.O0OO0O0O
  else %tanksserver = %tanks.O0OO0O0O
  %tanks.O0OO0O0O = $O0O00000($left(%tanks.O0OO0O0O,64),%tanks.OOO00OO0)
  if (* iswm %tanks.O0OO0O0O) {
    if ($sock(tanks)) O0OO000O O00O0O00 %tanks.O0OO0O0O
    else O0O0O0OO %tanks.OOO00OO0 %tanks.O0OO0O0O
  }
}
alias -l OO0OOO00 {
  if ($appactive) && ($active == @Tanks) return
  if (%tanks.OOO00OO0) && (* !iswm $sock(tanks.0)) {
    flash @Tanks
    window $iif($1,-g1,-g3) @Tanks
  }
}
dialog tanksname {
  title "Tanks name"
  option dbu
  size -1 -1 120 28
  text "Enter your new name:", 5, 4 3 54 7
  edit "", 2, 4 13 56 11, autohs result
  button "&Ok", 3, 63 13 25 11, ok default
  button "&Cancel", 4, 91 13 25 11, cancel
  list 1,0 0 0 0,disablehide
}
menu @Tank info {
  sclick:close -@ @Tank info
}
alias -l O0O000OO {
  if ($window($OO0OOOOO)) {
    window $OO0OOOOO $calc($mouse.dx -$1) $calc($mouse.dy -$2)
    if ($mouse.key & 1) .timertanks.OO0OOOOO -o 1 0 O0O000OO $1-
  }
}
alias -l O00OOOOO {
  if (, isin $2) var %tanks.OO00O00O = $getdot(@tanksO000000O, [ $2 ] )
  else var %tanks.OO00O00O = %tanks. [ $+ [ $2 ] ]
  %tanks.O0O0OO0O [ $+ [ $1 ] ] = $2
  if (%tanks.O0OO0000 [ $+ [ $1 ] ] == %tanks.OO00O00O) return return
  %tanks.O0OO0000 [ $+ [ $1 ] ] = %tanks.OO00O00O
}
alias -l O0OO0OO0 {
  if (%tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ] > 0) && (%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O) {
    var %tanks.O00000OO = %tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] , %tanks.O00O0O00 = 1 + %tanks.O00O00OO
    if ($1) drawrect -rfn @Tanks %tanks.OOO0000O 1 %tanks.OO00OO0O %tanks.O00O0O00 10 13
    %tanks.OO00OO0O = %tanks.O00000OO - $iif(%tanks.O00000OO > $calc(%tankswidth /2),5,6)
    drawpic -cnt @Tanks 16711935 %tanks.OO00OO0O %tanks.O00O0O00 120 104 10 13 %tanksbmp
    drawfill -srn @Tanks 7368816 16777215 $calc(5+%tanks.OO00OO0O) %tanks.O00O0O00
  }
}
alias -l O0O0000O {
  .timertanks.OO00O0O0 -e
  unset %tanks.O00O000O* %tanks.OO0OO0OO*
  if (%tanks.O0OOOOOO == O0000000) return
  unset %tanks.O0OOOOOO
  var %tanks.O00000OO = 0, %tanks.OO000O00 = %tanks.O000OOO0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) inc %tanks.O00000OO
    dec %tanks.OO000O00
  }
  if (%tanks.O00000OO < 2) {
    O00000OO
    return
  }
  if ($sock(tanks)) {
    %tanks.O0OOOOOO = O0000000
    return
  }
  var %tanks.O0OO0O0O = %tanks.O000OOO0, %tanks.O00O0OOO, %tanks.OO000O00 = $calc(300+25*%tanks.O00000OO)
  if (%tanks.O00O0OO0 & 1) %tanks.OO000O00 = 0
  while (%tanks.O0OO0O0O) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) {
      %tanks.OOO00O0O [ $+ [ %tanks.O0OO0O0O ] ] = 0
      %tanks.O0O00O0O [ $+ [ %tanks.O0OO0O0O ] ] = %tanks.OO000O00
      if (%tanks.O000O00O == 1) && (%tanks.O00OOO00 [ $+ [ %tanks.O0OO0O0O ] ] >= %tanks.OO000000) %tanks.O00O0OOO = 1
      elseif (%tanks.O000O00O == 2) && (%tanks.OO00O0O0 > %tanks.OO000000) %tanks.O00O0OOO = 1
    }
    dec %tanks.O0OO0O0O
  }
  if (%tanks.O00O0OOO) {
    unset %tanks.O0O00O0O*
    O00000OO
    return
  }
  %tanks.O00000O0 = $calc($rand(0,198)-99)
  var %tanks.OOO0OO0O, %tanks.OO000O00 = %tanks.O000OOO0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) %tanks.OOO0OO0O = %tanks.OO000O00 %tanks.OOO0OO0O
    dec %tanks.OO000O00
  }
  var %tanks.OO000O00 = $numtok(%tanks.OOO0OO0O,32), %tanks.O0OO0O00, %tanks.O0000OO0 = %tanks.OOO0OO0O, %tanks.OOO0OO0O
  while (%tanks.OO000O00) {
    %tanks.O0OO0O00 = $rand(1,$numtok(%tanks.O0000OO0,32))
    %tanks.OOO0OO0O = %tanks.OOO0OO0O $gettok(%tanks.O0000OO0,%tanks.O0OO0O00,32)
    %tanks.O0000OO0 = $deltok(%tanks.O0000OO0,%tanks.O0OO0O00,32)
    dec %tanks.OO000O00
  }
  var %tanks.OO000O00 = $numtok(%tanks.OOO0OO0O,32), %tanks.O00000OO = $int($calc(%tankswidth / $numtok(%tanks.OOO0OO0O,32))), %tanks.O0OO0O00, %tanks.O0OO0OO0 = $int($calc(%tanks.O00000OO /4))
  if ($calc((%tanks.O00000OO - 17) / 2) < %tanks.O0OO0OO0) %tanks.O0OO0OO0 = $ifmatch
  while (%tanks.OO000O00) {
    %tanks.O0OO0O0O = $int($calc(%tanks.O00000OO * %tanks.OO000O00 - %tanks.O00000OO / 2 + $rand(0,%tanks.O0OO0OO0) - %tanks.O0OO0OO0 / 2))
    if (%tanks.O0OO0O0O < 9) %tanks.O0OO0O0O = 9
    if ($calc(%tankswidth -8) <= %tanks.O0OO0O0O) %tanks.O0OO0O0O = $ifmatch
    %tanks.O0OO0O00 = $calc(%tanks.O0OO0O0O -8) %tanks.O0OO0O00
    %tanks.OO0O0OOO [ $+ [ $gettok(%tanks.OOO0OO0O,%tanks.OO000O00,32) ] ] = %tanks.O0OO0O0O
    dec %tanks.OO000O00
  }
  var %tanks.OO00OO00 = 0, %tanks.OO00O00O = $rand($calc(50+%tanks.O00O00OO),$calc(%tanks.OO0OO0O0 -80)), %tanks.OO000O0O = 0, %tanks.O00000OO = 1, %tanks.O00O0O00, %tanks.OO000O00 = 1, %tanks.O0000OO0 = $gettok(%tanks.O0OO0O00,1,32)
  %tanks.O0O0O0OO = %tanks.OO00O00O
  OO0O0000 Generating land...
  while (%tanks.O00000OO <= %tankswidth) {
    if (%tanks.O00000OO >= %tanks.O0000OO0) {
      if (%tanks.OO000O0O) %tanks.O0O0O0OO = %tanks.O0O0O0OO %tanks.O00O0O00 %tanks.OO000O0O
      %tanks.OO000O0O = 0
      %tanks.O00O0O00 = 0
      %tanks.OO00OO00 = 16
      %tanks.O0O000O0 [ $+ [ $gettok(%tanks.OOO0OO0O,%tanks.OO000O00,32) ] ] = $int(%tanks.OO00O00O) - 1
      inc %tanks.OO000O00
      %tanks.O0000OO0 = $gettok(%tanks.O0OO0O00,%tanks.OO000O00,32)
    }
    if (%tanks.OO000O0O >= %tanks.OO00OO00) || (%tanks.O00000OO == %tankswidth) {
      if (%tanks.OO000O0O) %tanks.O0O0O0OO = %tanks.O0O0O0OO %tanks.O00O0O00 %tanks.OO000O0O
      %tanks.OO000O0O = 0
      %tanks.O00O0O00 = $calc($rand(0,16)/5-1.6)
      %tanks.OO00OO00 = $rand(12,36)
    }
    if (%tanks.O00O0O00 < 0) && (%tanks.OO00O00O <= $calc(50+%tanks.O00O00OO)) {
      if (%tanks.OO000O0O) %tanks.O0O0O0OO = %tanks.O0O0O0OO %tanks.O00O0O00 %tanks.OO000O0O
      %tanks.OO000O0O = 0
      %tanks.O00O0O00 = $calc($rand(0,8)/5)
      %tanks.OO00OO00 = $rand(12,36)
    }
    if (%tanks.O00O0O00 > 0) && (%tanks.OO00O00O >= $calc(%tanks.OO0OO0O0 -50)) {
      if (%tanks.OO000O0O) %tanks.O0O0O0OO = %tanks.O0O0O0OO %tanks.O00O0O00 %tanks.OO000O0O
      %tanks.OO000O0O = 0
      %tanks.O00O0O00 = $calc(-$rand(0,8)/5)
      %tanks.OO00OO00 = $rand(12,36)
    }
    inc %tanks.OO00O00O %tanks.O00O0O00
    inc %tanks.OO000O0O
    inc %tanks.O00000OO
  }
  OO0O0000
  O0OO00OO
  if ($sock(tanks.*,0)) {
    var %tanks.OOO0OO00 = %tanks.O000OOO0
    while (%tanks.OOO0OO00) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.OOO0OO00 ] ] isnum) && (%tanks.OOO0OO00 != %tanks.OOO00OO0) O00OOOO0 %tanks.OOO0OO00
      dec %tanks.OOO0OO00
    }
  }
}
alias -l OO0O00OO {
  if (* !iswm $window(@Tanks)) return
  OO0O0000 Getting ready to fire...
  O000OO00
  drawdot @Tanks
  .timertanks.O0O0O00O off
  OO0000OO 1
  if (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] isnum 0-4) && (* !iswm $sock(tanks)) || (%tanks.O0OOOO0O == %tanks.OOO00OO0) && (* !iswm $1-) {
    if ($sock(tanks)) O0OO000O O000O000
  }
  if ($sock(tanks)) {
    if (* !iswm $1-) {
      O0OO000O O00000O0 %tanks.O0OO0OOO %tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ] %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ]
      OO0O0000 Waiting for server reply...
      %tanks.O0OOOOOO = O0000O00
      return
    }
    if (*\ %tanks.O0OOOO0O $O0OO0000(%tanks.O0OOOO0O) !iswm $1-) {
      var %tanks.O0000OO0 = $sock(tanks).ip ; %tanks.OOO00OO0 ; %tanks.O0OO000O ; %tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] ; $ifmatch ; $1-
      sockclose tanklist
      OOO0OO0O error= $+ $replace(%tanks.O0000OO0,$chr(32),$right(.%20,3))
      O0OO000O O000O00O Error
    }
  }
  elseif (%tanks.O0OOOO0O == %tanks.OOO00OO0) {
    var %tanks.O0000OO0 = %tanks.OO00OOO0 [ $+ [ %tanks.O0OOOO0O ] ] - 1
    %tanks.OO00OOO0 [ $+ [ %tanks.O0OOOO0O ] ] = $iif(%tanks.O0000OO0 < 0,0,%tanks.O0000OO0)
  }
  var %tanks.O0OO0O00 = $calc(%tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ] *3.14159/180)
  var %tanks.OO0OOO0O = $round($calc(%tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] $iif(%tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ] > $iif(%tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] > $calc(%tankswidth /2),89,90),-1,+1)+$cos(%tanks.O0OO0O00)*10),0)
  var %tanks.O0O0OOOO = $round($calc(%tanks.O0O000O0 [ $+ [ %tanks.O0OOOO0O ] ] -$sin(%tanks.O0OO0O00)*9-7),0)
  var %tanks.OO0O0O00 = $calc($iif(%tanks.O00OO000,%tanks.O00000O0,0) / 96), %tanks.OOO0OO0O = %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ] / 1.1, %tanks.OO00000O = %tanks.OOO0OO0O * $cos(%tanks.O0OO0O00), %tanks.OOO0OO0O = %tanks.OOO0OO0O * $sin(%tanks.O0OO0O00)
  $iif($0,OO0O00OO3,OO0O00OO2) %tanks.OO0OOO0O %tanks.O0O0OOOO %tanks.OO0O0O00 %tanks.OO00000O %tanks.OOO0OO0O -.1 0 0 $1-
}
alias -l OO0000OO {
  var %tanks.O00000OO = %tanks.O000OOO0
  while (%tanks.O00000OO) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.O00000OO ] ] isnum) {
      var %tanks.OO000O00 = %tanks.OO0OO000 [ $+ [ %tanks.O00000OO ] ] , %tanks.OOO00O00 = %tanks.O0OO00O0 [ $+ [ %tanks.O00000OO ] ]
      if (%tanks.O00O0OO0 & 1) %tanks.OOO00O00 = 100
      if (%tanks.OO000O00 < 0) %tanks.OO000O00 = 0
      if (%tanks.OO000O00 > %tanks.OOO00O00) %tanks.OO000O00 = %tanks.OOO00O00
      %tanks.OO0OO000 [ $+ [ %tanks.O00000OO ] ] = %tanks.OO000O00
      var %tanks.OO00000O = %tanks.O0O00O0O [ $+ [ %tanks.O00000OO ] ]
      if (%tanks.OO00000O < 0) %tanks.OO00000O = 0
      if (%tanks.OO00000O > 999) %tanks.OO00000O = 999
      %tanks.O0O00O0O [ $+ [ %tanks.O00000OO ] ] = %tanks.OO00000O
    }
    dec %tanks.O00000OO
  }
  if ($1) {
    if (%tanks.O0OO0OOO < 1) %tanks.O0OO0OOO = 1
    if ($O000000O < %tanks.O0OO0OOO) %tanks.O0OO0OOO = $ifmatch
  }
}
alias -l OOO0O0O0 {
  if (* !iswm $window(@Tanks)) return
  window -g3 @Tanks
  var %tanks.OO00O000, %tanks.O00OOO0O = 1
  if ($1 == -) {
    %tanks.O00OOO0O = 0
    tokenize 32 $2-
  }
  if ($1 == O000O0O0) {
    %tanks.OO00O000 = 1
    tokenize 32 O000O000 $2-
  }
  if ($1 == O0000OO0) tokenize 32 O000O000 $replace($4-,   ,%tanks.O00OOOO0 [ $+ [ $3 ] ] ,  ,%tanks.O00OOOO0 [ $+ [ $2 ] ] )
  var %tanks.O0OO0O00 = $1, %tanks.OO00000O, %tanks.O0000OO0, %tanks.O0OO0O0O, %tanks.OO0O0O00 = $calc(%tankschat.O00OO0O0 -19-%tankstahoma)
  if (%tanks.O0OO0O00 == O000O000) %tanks.O0000OO0 = $2-
  else %tanks.OO00000O = $2
  if (%tanks.O0OO0O00 == O0000O0O) %tanks.O0000OO0 = $3 joined the game $iif($4,(IP: [ [ $4 ] $+ ] ))
  elseif (%tanks.O0OO0O00 == O0000O00) {
    if ($istok(/me /em,$4,32)) {
      %tanks.O0OO0O00 = O000000O
      %tanks.O0000OO0 = (pmsg) -> * $+ $3 $+ * $5-
    }
    else %tanks.O0000OO0 = (pmsg) -> * $+ $3 $+ * $4-
  }
  elseif ($istok(O00000O0 O0000000,%tanks.O0OO0O00,32)) {
    if ($istok(/me /em,$4,32)) {
      %tanks.O0OO0O00 = O00000OO
      %tanks.O0000OO0 = * $3 $5-
    }
    else %tanks.O0000OO0 = < $+ $3 $+ > $4-
    if ($1 == O0000000) {
      if (%tanks.O0OO0O00 == O00000OO) %tanks.O0OO0O00 = O000000O
      %tanks.O0000OO0 = (pmsg) %tanks.O0000OO0
      OO0OOO00 1
    }
    if ($3 === %tanks.O00OOOO00) %tanks.O0000OO0 = (server) %tanks.O0000OO0
  }
  elseif (%tanks.O0OO0O00 == O000O00O) %tanks.O0000OO0 = $3 renamed to $4
  elseif (%tanks.O0OO0O00 == O000O0OO) {
    %tanks.OO00000O = %tanks.OO00000O $4
    %tanks.O0000OO0 = $3 changed color
  }
  elseif (%tanks.O0OO0O00 == O000OO00) {
    %tanks.O0000OO0 = $3 left the game $4- %tanks.OO000OOO
    if (* !iswm $3) return
  }
  elseif (%tanks.O0OO0O00 == O0000OOO) %tanks.O0000OO0 = $3 was kicked out $4- %tanks.OO000OOO
  %tanks.O0000OO0 = $strip(%tanks.O0000OO0)
  if (%tankslog) && (%tanks.OO00O000 != 1) {
    tokenize 32 %tanks.OO00000O %tanks.O0000OO0
    var %tanks.OO00OO00 = $2-
    if (%tanks.O0OO0O00 == O000O0OO) %tanks.OO00OO00 = $3-
    if (%tanks.O0OO0O00 == O000O000) %tanks.OO00OO00 = $1-
    if ($istok(O00000O0 O0000O00 O0000000 O00000OO,%tanks.O0OO0O00,32) != $true) %tanks.OO00OO00 = *** %tanks.OO00OO00
    write " $+ $scriptdir $+ tanks.log" $timestamp %tanks.OO00OO00
  }
  while ($len(%tanks.O0000OO0)) && (* iswm $remove(%tanks.O0000OO0, )) {
    %tanks.O0OO0O0O = 1
    while ($width($mid(%tanks.O0000OO0,1,%tanks.O0OO0O0O),%tankschat.O00O000O,%tankschat.O00O0O00,0,0) < %tanks.OO0O0O00) && (%tanks.O0OO0O0O <= $len(%tanks.O0000OO0)) {
      inc %tanks.O0OO0O0O
    }
    if ($asc($mid(%tanks.O0000OO0,%tanks.O0OO0O0O,1)) != 32) {
      dec %tanks.O0OO0O0O
      var %tanks.OO00OO00 = $left(%tanks.O0000OO0,%tanks.O0OO0O0O)
      if (%tanks.O0OO0O0O < $len(%tanks.O0000OO0)) && ($numtok(%tanks.OO00OO00,32) > 2) %tanks.O0OO0O0O = $pos(%tanks.OO00OO00,$chr(32),$count(%tanks.OO00OO00,$chr(32)))
    }
    O0O00O00 %tanks.O0OO0O00 %tanks.OO00000O $left(%tanks.O0000OO0,%tanks.O0OO0O0O)
    if ($asc($mid(%tanks.O0000OO0,%tanks.O0OO0O0O,1)) == 32) %tanks.O0000OO0 =   $right(%tanks.O0000OO0,$calc(0-%tanks.O0OO0O0O))
    else %tanks.O0000OO0 =    $+ $right(%tanks.O0000OO0,$calc(0-%tanks.O0OO0O0O))
  }
  if (%tanks.O00OOO0O) OO0O0O00
}
on *:keydown:@Tanks scores:*:if (* iswm $keychar) OO000OOO
on *:sockread:tanks.*:{
  var %tanks.O0OO0OO0, %tanks.OO000O00 = $deltok($sockname,1,46), %tanks.OO000O0O = $sock($sockname).ip, %tanks.OOO00O00 = $sock($sockname).mark
  if ($sockerr) {
    if ($gettok($sockname,2,46) isnum) OO0OO000 $ifmatch
    O0OOOOO0 $ifmatch $sockname sockread
    return
  }
  if (%tanks.OO000O00 !isnum) return
  while ($sock($sockname)) {
    sockread %tanks.O0OO0OO0
    if ($sockbr !isnum 1-) return
    tokenize 32 %tanks.O0OO0OO0
    if (O00OO0O0 $tanksversion(1) * * iswm $1-) {
      if (* iswm %tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] ) {
        OO0OO000 O000000O %tanks.OO000O00 (Join error)
        return
      }
      O0O00OO0 %tanks.OO000O00 $3 $O0O00000($left($4,%tanks.O0O0000O),%tanks.OO000O00)
      continue
    }
    elseif (* !iswm %tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] ) {
      O00OOO0O $sockname ver $tanksversion(1)
      return
    }
    if (%tanks.O0OOOO0O == %tanks.OO000O00) && ($1 != O00O00O0) O0O0O00O
    if ($1 == O000O000) %tanks.OOO00O0O [ $+ [ %tanks.OO000O00 ] ] = 1
    elseif ($1 == O00O00OO) O0O00OOO %tanks.OO000O00 O00O00OO 0 $O00O0O0O
    elseif ($1 == O00O0OO0) {
      if (%tanks.OO000O00 != %tanks.O0OOOO0O) continue
      O000OOOO %tanks.OO000O00 $1-
      O0OOO000 0 $2-
    }
    elseif ($1 == O00000O0) {
      if (%tanks.OO000O00 != %tanks.O0OOOO0O) || (%tanks.OOO00O0O [ $+ [ %tanks.OO000O00 ] ] != 1) continue
      %tanks.O0OO0OOO = $2
      %tanks.OO00O0OO [ $+ [ %tanks.OO000O00 ] ] = $3
      %tanks.OO0OO000 [ $+ [ %tanks.OO000O00 ] ] = $4
      var %tanks.O0000OO0 = %tanks.OO00OOO0 [ $+ [ %tanks.OO000O00 ] ] - 1
      %tanks.OO00OOO0 [ $+ [ %tanks.OO000O00 ] ] = $iif(%tanks.O0000OO0 < 0,0,%tanks.O0000OO0)
      OO0O00OO
    }
    elseif ($1 == O000O00O) OO0OO000 %tanks.OO000O00 $2-
    else {
      inc -z %tanks.OOO000OO [ $+ [ %tanks.OO000O00 ] ]
      if (%tanks.OOO000OO [ $+ [ %tanks.OO000O00 ] ] > 3) {
        inc -z %tanks.OOO000OO [ $+ [ %tanks.OO000O00 ] ] 10
        O0O00OOO %tanks.OO000O00 O000O0OO 0 0 Your message was not sent (too many too fast), please wait $duration($calc(%tanks.OOO000OO [ $+ [ %tanks.OO000O00 ] ] -3))
        continue
      }
    }
    if ($1 == O00O0000) && (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) && (%tanks.O0OOOOOO != O00000OO) && ($numtok(%tanks.O0OO000O,32) > 1) O000O0O0 %tanks.OO000O00 $iif(%tanks.O00O000O [ $+ [ %tanks.OO000O00 ] ] ,0,1)
    elseif ($1 == O000OO00) O0O00OOO %tanks.OO000O00 O00O00O0 $2
    elseif ($1 == O00O00O0) {
      var %tanks.O0000OO0 = $ctime - $2
      if (%tanks.O0000OO0) OOO0O0O0 O000O000 Lag for %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] is $duration(%tanks.O0000OO0)
      else OOO0O0O0 O000O000 There is no lag for %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ]
    }
    elseif ($1 == O0000O00) OO0OO00O %tanks.OO000O00 $2
    elseif ($1 == O00O0O00) {
      var %tanks.O0000OO0 = $left($O0O00000($2,%tanks.OO000O00),%tanks.O0O0000O)
      if (%tanks.OOO00O00) O0O00OOO %tanks.OO000O00 O00O0O00 %tanks.OO000O00 %tanks.O0000OO0
      else O0O0O0OO %tanks.OO000O00 %tanks.O0000OO0
    }
    elseif ($1 == O0000O0O) && (%tanks.OOO00O00 != 1) {
      OOO0O0O0 O00000O0 %tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] $left($2-,200)
      O000OOOO %tanks.OO000O00 O0000O0O %tanks.OO000O00 $left($2-,200)
    }
    elseif ($1 == O000OOO0) {
      var %tanks.O0000OO0 = 1
      while ($gettok($2,%tanks.O0000OO0,44) isnum) {
        var %tanks.OO00000O = $gettok($2,%tanks.O0000OO0,44), %tanks.OOO0OO0O = tanks. $+ %tanks.OO00000O, %tanks.O0OO0O0O
        if (%tanks.OOO00O00 != 1) || (%tanks.OO000O00 == %tanks.OO00000O) {
          if (* !iswm $sock(%tanks.OOO0OO0O)) || (%tanks.OO00000O == 0) %tanks.O0OO0O0O = 1
          else O0O00OOO %tanks.OO00000O O000OOO0 %tanks.OO000O00 $left($3-,200)
        }
        inc %tanks.O0000OO0
      }
      if (%tanks.O0OO0O0O) OOO0O0O0 O0000000 %tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] $3-
    }
  }
}
alias -l O000OO0O {
  tokenize 32 %tanks.O0OOOO0O %tanks.O0OO00O0 [ $+ [ %tanks.O0OOOO0O ] ] %tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ]
  if (%tanks.O00O0OO0 & 1) tokenize 32 $1 100 $3
  if ($3 !isnum) return
  OOOO0000 411 %tanks.OO0OO0OO [ $+ [ $1 ] ] $iif(%tanks.O00O0OO0 !& 1 && %tanks.OO0OO0OO [ $+ [ $1 ] ] > $2,1)
  OOOO0000 424 $2
  OOOO0000 440 $3 $iif(%tanks.O00O0OO0 & 1 || %tanks.OO0O000O [ $+ [ $1 ] ] >= 10 && $3 < 50 || $3 < 30,1)
}
alias -l OO00000O {
  if ($numtok(%tanks.O0OO000O,32) > 8) {
    drawpic -cnt @Tanks 16711935 4 383 0 0 36 17 %tanksbmp
    return
  }
  var %tanks.OO00000O = %tanks.O0OO0000 [ $+ [ %tanks.O0OOOO0O ] ]
  if (%tanks.OO00000O !isnum) return
  drawrect -rfn @Tanks %tanks.OO00000O 1 4 383 36 17
}
alias -l OO0OO000 {
  var %tanks.OO0O0O0O = O000OO00, %tanks.OOO0OO0O = O000O00O
  if ($1 == O000000O) {
    %tanks.OO0O0O0O = O0000OOO
    %tanks.OOO0OO0O = $1
    tokenize 32 $2-
  }
  if ($dialog(tanksbots)) {
    var %tanks.OO000O0O = $did(tanksbots,20).lines
    while (%tanks.OO000O0O) {
      if ($did(tanksbots,20,%tanks.OO000O0O) == $1) did -d tanksbots 20,22 %tanks.OO000O0O
      dec %tanks.OO000O0O
    }
    OOO000O0
  }
  if (%tanks.O0OO0000 [ $+ [ $1 ] ] isnum) && ($window(@Tanks)) {
    if ($sock(tanks. [ $+ [ $1 ] ] ).ip) %tanks.OO000OOO = (IP: $ifmatch $+ )
    else unset %tanks.OO000OOO
    OOO0O0O0 %tanks.OO0O0O0O %tanks.O0OO0000 [ $+ [ $1 ] ] %tanks.O00OOOO0 [ $+ [ $1 ] ] $2-
    var %tanks.O0000OO0 = %tanks.OO0O000O [ $+ [ $1 ] ] 
    %tanks.OO0O000O [ $+ [ $1 ] ] = 0
    OO000000
    unset %tanks.O0OO0000 [ $+ [ $1 ] ] %tanks.O00OOOO0 [ $+ [ $1 ] ] %tanks.O0O0OO0O [ $+ [ $1 ] ]
    O0000000
    if (%tanks.O0OOOOOO == O00000OO) O000O00O
    drawpic @Tanks
    var %tanks.OO000O0O = 1
    while (%tanks.OO0O000O [ $+ [ $gettok(%tanks.O0OO000O,%tanks.OO000O0O,32) ] ] > 0) {
      inc %tanks.OO000O0O
    }
    dec %tanks.OO000O0O
    if ($1 == %tanks.O0OOOO0O) && (%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O) {
      .timertanks.OO0O00OO2 off
      O0OOOO0O
    }
    elseif (%tanks.OO000O0O < 2) || ($OOO00O00) && (%tanks.O0000OO0 > 0) {
      if ($OOO00O00 > 1) O00000OO
      else O00O00OO
    }
    if ($1 == %tanks.OOO00OO0) {
      if ($sock(tanks)) {
        OO000O0O
        return
      }
      %tanks.OOO00OO0 = 0
    }
    if ($sock(tanks.*,0)) {
      O000OOOO $1 %tanks.OOO0OO0O $1-
      O00OOO0O tanks. $+ $1 %tanks.OOO0OO0O $1-
      O0OOO0O0
    }
  }
}
alias -l O0000OO0 {
  %tanks.OOO0OOO0 = $1
  if ($version != 6.02) window -h @tanksO0000O0O
  var %tanks.O0000OO0, %tanks.OO00000O = 1, %tanks.O0OO0O0O = $numtok(%tanks.O0O00000,32), %tanks.OO0O0O00 = $calc(94+8*%tanks.O0OOOOO0), %tanks.O000OOOO = $calc(20+8*%tanks.O0OOOO00)
  close -@ @Tanks color
  window -Bhdofpk +Ltf @Tanks color $int($calc($window(@Tanks).x +(%tankswidth -%tanks.OO0O0O00)/2)) $int($calc($window(@Tanks).y +(%tanksheight -%tanks.O000OOOO)/2)) %tanks.OO0O0O00 %tanks.O000OOOO
  drawrect -rfn @Tanks color %tanks.15 1 0 0 %tanks.OO0O0O00 %tanks.O000OOOO
  tokenize 32 %tanks.O0OOOOO0 %tanks.O0OOOO00
  if ($version < 6.02) tokenize 32 $calc($1 -1) $calc($2 -1)
  drawcopy -nt @tanksO000000O 16711935 0 0 $1-2 @Tanks color 10 10 $calc(8*%tanks.O0OOOOO0 -1) $calc(8*%tanks.O0OOOO00 -1)
  var %tanks.O00000OO = $calc(20+8*%tanks.O0OOOOO0), %tanks.O00O0O00 = $calc(8*%tanks.O0OOOO00 -54)
  drawtext -rn @Tanks color 0 Fixedsys 15 %tanks.O00000OO 10 Selected
  drawrect -r @Tanks color %tanks.14 1 %tanks.O00000OO %tanks.O00O0O00 64 64
  drawdot @Tanks color
  window -a @Tanks color
}
on *:keydown:@Tank info:*:{
  if ($keyval !isnum 16-17) window -c @Tank info
}
alias -l OO0O0OO0 {
  %tanks.OO00O0O0 = 1
  tokenize 32 %tanks.O0OO000O
  %tanks.O0OOOO0O = $ [ $+ [ $rand(1,$0) ] ]
  var %tanks.OOO0OO0O = tanks. $+ %tanks.O0OOOO0O
  if (* !iswm $sock(%tanks.OOO0OO0O)) && (* !iswm $sock(tanks)) {
    if (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] !isnum 0-4) %tanks.OOO00OO0 = %tanks.O0OOOO0O
  }
  while ($1) {
    O0OO0000 $1 $O0OO0000
    tokenize 32 $2-
  }
  O0O0000O
}
alias -l OO000O0O {
  if ($sock(tanks.0)) O0OO0O0O
  unset %tanks.O0OO0000*
  sockclose tanks
  sockclose tanks.*
  if ($window(@Tanks)) && ($1 != 1) {
    OOO0O0O0 O000O000 Game over
    unset %tanks.*
    %tanks.OO0OO0O0 = 311
  }
  else {
    close -@ @tanksO00000OO @Tanks color @tanksO000000O @Tank info @tanksO0000O00 @tanksO0000O0O @tanksO00000O0 @tanksO0000000
    unset %tankschat.* %tanksbmp %tankswidth %tanksheight %tanks.*
  }
  if ($window(@Tanks request)) OOO0O0OO
}
alias -l OOO0O00O {
  if (* !iswm $window(@Tanks)) return
  if (%tanks.O0OOOO0O == %tanks.OOO00OO0) && ($1 == 0) O0O0O00O 0
  var %tanks.O0OO0OO0 = .timertanks.OO000OO0 -om 1 200 .timertanks.OO000OO0 -om 0 50 OO000OO0, %tanks.OO00O000 = O000OOOO 81 440 77 57 131 16 17, %tanks.O00OOO0O = O0000O0O 99 440 95 57 131 16 17, %tanks.O00O0OOO = 0, %tanks.OO000O00 = $1, %tanks.OO000OO0 = %tanks.OO0O00O0, %tanks.O00O00O0 = $mouse.dx, %tanks.O0OOO0O0 = $mouse.dy, %tanks.O00000OO = $mouse.x, %tanks.O00O0O00 = $mouse.y, %tanks.OO000O0O, %tanks.OO00O00O, %tanks.O0OO0O00
  if ($mouse.key & 1) {
    %tanks.O00O0OOO = 1
    if ($inrect(%tanks.O00000OO,%tanks.O00O0O00,%tankschat.O00O0OO0,%tankschat.O00000OO,%tankschat.O00OO0O0,%tankschat.O00OO00O)) {
      var %tanks.OO00OO00 = $int($calc((%tanks.O00O0O00 -3-%tankschat.O00000OO)/13))
      if (%tanks.OO000O00 == 0) && ($mouse.key > 1) {
        %tankschat.O000OOO0 = $calc(%tankschat.O00O0O0O +11-%tanks.OO00OO00)
        %tankschat.O00OO0OO = %tankschat.O000OOO0
        if (%tanks.OO00OO00 < 11) && (%tankschat.O000OOO0 <= %tankschat.O00OO000) {
          %tankschat.O00OOO00
          %tankschat.O00OOO00 = drawrect -nrif @Tanks 0 1 $calc(16+%tankschat.O00O0OO0) $calc(3+%tankschat.O00000OO +13*%tanks.OO00OO00) $calc(%tankschat.O00OO0O0 -17) 13
          %tankschat.O00OOO00
          drawdot @Tanks
          %tankschat.O000O000 = 1
          unset %tankschat.O00O0O0Odown
        }
        else unset %tankschat.O00OOO00
      }
      elseif (%tankschat.O000O000) {
        if (%tanks.OO00OO00 > 10) %tanks.OO00OO00 = 10
        %tankschat.O00OO0OO = $calc(%tankschat.O00O0O0O +11-%tanks.OO00OO00)
        if (%tankschat.O00OO0OO > %tankschat.O000OOO0) %tankschat.O00OO0OO = %tankschat.O000OOO0
        %tankschat.O00OOO00
        %tankschat.O00OOO00 = drawrect -nrif @Tanks 0 1 $calc(16+%tankschat.O00O0OO0) $calc(3+%tankschat.O00000OO +13*(11+%tankschat.O00O0O0O -%tankschat.O000OOO0)) $calc(%tankschat.O00OO0O0 -17) $calc(13*(1+%tankschat.O000OOO0 -%tankschat.O00OO0OO))
        %tankschat.O00OOO00
        drawdot @Tanks
      }
    }
    elseif (%tankschat.O000O000) {
      %tankschat.O00OOO00
      unset %tankschat.O00OOO00
      drawdot @Tanks
    }
    if (%tankschat.O00O00O0) {
      var %tanks.O0000OO0 = %tankschat.O00O0O0O
      %tankschat.O00O0O0O = $int($calc(.5+%tankschat.O0000000 +(%tankschat.O00OO000 -11)*(%tankschat.O00O00O0 -%tanks.O00O0O00)/(%tankschat.O00000O0 -15)))
      if (%tankschat.O00O0O0O < $calc(%tankschat.O00OO000 -11)) {
        if (%tankschat.O00O0O0O < 0) %tankschat.O00O0O0O = 0
      }
      else %tankschat.O00O0O0O = %tankschat.O00OO000 - 11
      if (%tanks.O0000OO0 != %tankschat.O00O0O0O) OO0O0O00
    }
    if ($inrect(%tanks.O00000OO,%tanks.O00O0O00,%tankschat.O00O0000,%tankschat.O00000OO,15,%tankschat.O00OO00O)) {
      if ($inrect(%tanks.O00000OO,%tanks.O00O0O00,%tankschat.O00O0000,%tankschat.O000OO0O,15,15)) && (%tanks.OO000O00 == 0) {
        %tankschat.O00O00O0 = %tanks.O00O0O00
        %tankschat.O0000000 = %tankschat.O00O0O0O
      }
      if (%tankschat.O00O00O0 != 1) {
        if (%tanks.O00O0O00 >= %tankschat.O00O00OO) && (%tanks.O00O0O00 < %tankschat.O000OO0O) {
          if (%tanks.OO000O00 == 0) {
            %tankschat.O000O0OO = O00000OO
            O0O0OO00 11
            %tankschat.O0000O0O = 1
            %tanks.O0OO0OO0
          }
        }
        elseif (%tankschat.O000O0OO == O00000OO) OO000OO0 1
        elseif (%tanks.O00O0O00 < %tankschat.O000O00O) && (%tanks.O00O0O00 >= $calc(15+%tankschat.O000OO0O)) {
          if (%tanks.OO000O00 == 0) {
            %tankschat.O000O0OO = O000OO00
            O0O0OOO0 11
            %tankschat.O0000O0O = 1
            %tanks.O0OO0OO0
          }
        }
        elseif (%tankschat.O000O0OO == O000OO00) OO000OO0 1
      }
      if (%tanks.O00O0O00 < %tankschat.O00O00OO) {
        if (%tanks.OO000O00 == 0) {
          %tankschat.O000O0OO = O00O0000
          %tankschat.O0000O0O = 1
          O0O0OO00
          %tanks.O0OO0OO0
        }
      }
      elseif (%tankschat.O000O0OO == O00O0000) OO000OO0 1
      if (%tanks.O00O0O00 >= %tankschat.O000O00O) {
        if (%tanks.OO000O00 == 0) {
          %tankschat.O000O0OO = O0000O00
          %tankschat.O0000O0O = 1
          O0O0OOO0
          %tanks.O0OO0OO0
        }
      }
      elseif (%tankschat.O000O0OO == O0000O00) OO000OO0 1
    }
    elseif ($timer(tanks.OO000OO0)) OO000OO0 1
  }
  else {
    if (%tankschat.O000O000) {
      if (%tankschat.O00O0O0Odown) {
        unset %tankschat.O00O0O0Odown %tankschat.O00OOO00
        %tankschat.O00O0O0O = 0
        OO0O0O00
      }
      else {
        %tankschat.O00OOO00
        drawdot @Tanks
        unset %tankschat.O00OOO00
      }
      %tankschat.O000O000 = 0
      if ($inrect(%tanks.O00000OO,%tanks.O00O0O00,%tankschat.O00O0OO0,%tankschat.O00000OO,%tankschat.O00OO0O0,%tankschat.O00OO00O)) {
        var %tanks.OO00000O
        while (1) {
          var %tanks.O0000OO0 = $OOO0O000(%tankschat.O000OOO0)
          if ($left(%tanks.O0000OO0,6) == ***   ) %tanks.OO00000O = %tanks.OO00000O $+ $mid(%tanks.O0000OO0,7)
          elseif ($left(%tanks.O0000OO0,5) " == ***   ") %tanks.OO00000O = %tanks.OO00000O $mid(%tanks.O0000OO0,7)
          elseif (  * iswm %tanks.O0000OO0) %tanks.OO00000O = %tanks.OO00000O $+ $mid(%tanks.O0000OO0,3)
          elseif (  * iswm %tanks.O0000OO0) %tanks.OO00000O = %tanks.OO00000O $mid(%tanks.O0000OO0,3)
          elseif (* iswm %tanks.OO00000O) %tanks.OO00000O = %tanks.OO00000O $+ $crlf $+ %tanks.O0000OO0
          else %tanks.OO00000O = %tanks.O0000OO0
          if (%tankschat.O000OOO0 > %tankschat.O00OO0OO) dec %tankschat.O000OOO0
          else break
        }
        clipboard %tanks.OO00000O
      }
    }
    unset %tankschat.O000O0OO
    %tankschat.O00O00O0 = 0
    if ($timer(tanks.OO000OO0)) {
      OO000OO0 1
      .timertanks.OO000OO0 off
    }
  }
  if (%tanks.O0OOOOOO !isin O0000O00 O000000O O0000O0O) return
  if (%tanks.OO000O00 isnum) || ($mouse.key !& 1) && ($active == @Tanks) {
    if (%tanks.O00O0O00 < %tanks.OO0OO0O0) || ($inrect(%tanks.O00000OO,%tanks.O00O0O00,0,312,320,57)) {
      if ($appactive) O00OO00O %tanks.O00O00O0 %tanks.O0OOO0O0 %tanks.O00000OO %tanks.O00O0O00 %tanks.OO000O00
      return
    }
  }
  unset %tanks.O00O0000
  if ($version != 6.02) window -h @tanksO0000O0O
  if (%tanks.OO000OO0 < 1) && (%tanks.O00O0OOO < 1) return
  if (%tanks.O0OOOOOO == O0000O0O) {
    %tanks.O0OO0O00 = %tanks.OO00O000 %tanks.O00OOO0O
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000O0OO 206 409 0 0 0 110 23
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000000O 42 383 38 0 74 36 36
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O0000OOO 42 421 38 38 112 36 36
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000O00O 4 402 0 19 93 36 36
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000O0O0 80 402 76 19 93 36 36
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000OOO0 218 383 214 0 74 84 25
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000OO0O 218 433 214 50 124 84 24
  }
  if ($numtok(%tanks.O0OO000O,32) > 8) {
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O000O000 4 383 0 0 74 17 17
    %tanks.O0OO0O00 = %tanks.O0OO0O00 O00000O0 23 383 19 0 74 17 17
  }
  tokenize 32 %tanks.O0OO0O00
  while ($1) {
    %tanks.OO00O00O = $1
    if (%tanks.OO000OO0) && (%tanks.OO000OO0 != %tanks.OO00O00O) || (%tanksinc == $replace(%tanks.OO00O00O,O000OOOO,1,O0000O0O,5)) { }
    else {
      if ($inrect(%tanks.O00000OO,%tanks.O00O0O00,$2,$3,$7,$8)) %tanks.OO000O0O = 1
      else %tanks.OO000O0O = 0
      if (%tanks.OO00O00O == O000O0OO) {
        if (%tanks.OO000O0O) || (%tanks.OO0O00O0 == O000O0OO) && (%tanks.O00O0OOO) {
          var %tanks.O0000OO0 = 5
          if (%tanks.O00000OO < 229) %tanks.O0000OO0 = 1
          elseif (%tanks.O00000OO < 250) %tanks.O0000OO0 = 2
          elseif (%tanks.O00000OO < 271) %tanks.O0000OO0 = 3
          elseif (%tanks.O00000OO < 292) %tanks.O0000OO0 = 4
          if (%tanks.O0OO0OOO != %tanks.O0000OO0) O0OOO000 %tanks.OO00O00O $+ %tanks.O0000OO0
          %tanks.OO0O00O0 = O000O0OO
        }
      }
      elseif (%tanks.OO000O0O) && (%tanks.O00O0OOO) {
        drawpic -cnt @Tanks 16711935 $2-4 $6-8 %tanksbmp
        drawdot @Tanks
        %tanks.OO0O00O0 = %tanks.OO00O00O
      }
      elseif (%tanks.OO000OO0 == %tanks.OO00O00O) {
        if ($istok(O000OOOO O0000O0O,%tanks.OO000OO0,32)) && (%tanks.OO000O0O) && (%tanks.OO000O00) tokenize 32 $iif(%tanks.OO00O00O == O000OOOO,%tanks.O00OOO0O,%tanks.OO00O000)
        drawpic -cnt @Tanks 16711935 $2-5 $7-8 %tanksbmp
        drawdot @Tanks
      }
      if (%tanks.OO000O0O) && (%tanks.OO000O00) O0OOO000 $O00OOO00(%tanks.OO00O00O)
    }
    tokenize 32 $9-
  }
  if (%tanks.O00O0OOO) && (%tanks.OO0O00O0 == 0) %tanks.OO0O00O0 = \
  if (%tanks.O00O0OOO < 1) %tanks.OO0O00O0 = 0
}
alias tanks.init {
  if ($version < 5.7) {
    O00O0000 $tanksversion requires mIRC v5.7 or newer - $OO00O000(http://www.mirc.com/get.html)
    if ($?!="You need a newer version of mIRC to use Tanks.") O000O0OO run http://www.mirc.com/get.html
    unload -rs " $+ $script $+ "
  }
  if (%tanksnick) %tanksname = %tanksnick
  var %tanks.OOO00OOO = $scriptdir $+ tanksb.bmp
  if ($isfile(%tanks.OOO00OOO)) .remove " $+ %tanks.OOO00OOO $+ "
  if (%tanksautoscroll !isnum) %tanksautoscroll = 1
  if (%tanksforget !isnum) %tanksforget = 1
  if (%tankspublic !isnum) %tankspublic = 1
  %tanks.OOO00OOO = $scriptdir $+ tanks.txt
  var %tanks.O0000OO0 = $read -w"*Fixes and additions" " [ $+ [ %tanks.OOO00OOO ] $+ ] "
  if (%tanks.O0000OO0) {
    window -zBkdaC @Tanks versions -1 -1 -1 400 Fixedsys 15
    loadbuf $calc($readn - 1) $+ - $+ $calc($lines(%tanks.OOO00OOO)-2) @Tanks versions " $+ %tanks.OOO00OOO $+ "
  }
}
alias abouttanks {
  if ($dialog(abouttanks)) {
    dialog -e abouttanks
    return
  }
  dialog $iif(%tanksontop,-dmo,-dm) abouttanks abouttanks
}
alias -l OOOO0000 {
  if (%tanks.O0OOOOOO !isin O0000O00 O000000O O0000O0O) return
  drawrect -rfn @Tanks 0 1 172 $calc(1+$1) 25 13
  if ($2 isnum) drawtext -rn @Tanks $iif($3,10921638,16777215) Fixedsys 15 $calc(196-$width($2,fixedsys,15,0,0)) $1 $2
}
alias -l socket sockclose $1 | sockopen $1-2 80 | sockmark $1-2
alias -l O00O00O0 {
  var %tanks.O000OOOO = $iif(%tanks.O00O0OO0 & 1,122,136), %tanks.O00O0OOO = drawtext -rn @Tank info 0 Fixedsys 15 8, %tanks.O0OO0O00 = %tanks.OO00O0OO [ $+ [ $1 ] ]
  if ($window(@Tank info)) {
    window -c @Tank info
    return
  }
  if (%tanks.OO0O000O [ $+ [ $1 ] ] < 1) return
  window -Bhdofpk +Ltf @Tank info $int($calc(%tankswidth /2-52+$window(@Tanks).x)) $int($calc(%tanksheight /2-60+$window(@Tanks).y)) 104 %tanks.O000OOOO
  drawrect -rfn @Tank info %tanks.O0OO0000 [ $+ [ $1 ] ] 1 0 0 104 %tanks.O000OOOO
  drawrect -rfn @Tank info %tanks.15 1 3 3 98 $calc(%tanks.O000OOOO -6)
  drawtext -crn @Tank info 0 %tankschat.O000OO00 %tankschat.O00O0O00 8 8 88 13 %tanks.O00OOOO0 [ $+ [ $1 ] ]
  %tanks.O00O0OOO 24 Angle   $iif($calc(180-%tanks.O0OO0O00) < %tanks.O0OO0O00,$calc(180-%tanks.O0OO0O00),%tanks.O0OO0O00)
  %tanks.O00O0OOO 38 Power   %tanks.OO0OO000 [ $+ [ $1 ] ]
  %tanks.O00O0OOO 52 Prev.   %tanks.OO0OO0OO [ $+ [ $1 ] ]
  %tanks.O00O0OOO 66 Max.    $iif(%tanks.O00O0OO0 & 1,100,%tanks.O0OO00O0 [ $+ [ $1 ] ] )
  %tanks.O00O0OOO 84 Credits %tanks.O0O00O0O [ $+ [ $1 ] ]
  if (%tanks.O00O0OO0 !& 1) %tanks.O00O0OOO 98 Shield  %tanks.OO0O000O [ $+ [ $1 ] ]
  %tanks.O00O0OOO = Accuracy:  $calc(+$round($calc(100*%tanks.OO0O0OO0 [ $+ [ $1 ] ] /%tanks.OO0OOO00 [ $+ [ $1 ] ] ),0)) $+ %
  drawtext -rn @Tank info 0 %tankschat.O000OO00 %tankschat.O00O0O00 $calc(52-$width(%tanks.O00O0OOO,%tankschat.O00O000O,%tankschat.O00O0O00,0,0)/2) $iif(%tanks.O00O0OO0 & 1,101,115) %tanks.O00O0OOO
  drawdot @Tank info
}
menu @Tanks,@tanksO0000O0O {
  mouse:if ($menu != @tanksO0000O0O) OOO0O00O
  leave:if ($menu != @tanksO0000O0O) OOO0O00O
  sclick:{
    if ($menu == @tanksO0000O0O) O00O00O0 %tanks.O00O0000
    else OOO0O00O 0
  }
  dclick:{
    if ($menu != @tanksO0000O0O) {
      OOO0O00O 0
      if (%tanks.O0OOOOOO == O00000OO) if ($inrect($mouse.x,$mouse.y,0,380,320,80)) OO0O0OO0
    }
  }
  uclick:if ($menu != @tanksO0000O0O) OOO0O00O 1
  -
  $iif(%tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] isnum,Vie&w scores):.timertanks.OO000OOO -o 1 0 OO000OOO
  -
  $iif(* !iswm $sock(tanks),&Server settings):{
    if ($dialog(tanksserver)) dialog -ev $ifmatch
    else dialog $iif(%tanksontop,-dmo,-dm) tanksserver tanksserver
  }
  $iif(* !iswm $sock(tanks),&Bots && local players):{
    if ($dialog(tanksbots)) dialog -ev $ifmatch
    else dialog $iif(%tanksontop,-dmo,-dm) tanksbots tanksbots
  }
  -
  $iif($sock(tanks.0),$O0O000O0(%tankspublic,&Public server)):{
    %tankspublic = $iif(%tankspublic,0,1)
    if (%tankspublic) O0OOO0O0
    else O0OO0O0O
  }
  -
  &Commands
  .$iif($sock(tanks*,0) && %tanksip && %tanksport,Copy server IP &address && port to clipboard):clipboard %tanksip $+ : $+ %tanksport
  .$iif($sock(tanks.*,0),Change port for &server [ [ $+ [ %tanksport ] $+ ] ]):O00OO0O0 /port 0
  .$iif($sock(tanks),&Ping server):O0OO000O O000OO00 $ctime
  .$iif($sock(tanks.*,0),&Ping user...)
  ..$iif(%tanks.O0OO00001 isnum && $sock(tanks.1),%tanks.O00OOOO01):O0O00OOO 1 O000OO00 $ctime
  ..$iif(%tanks.O0OO00002 isnum && $sock(tanks.2),%tanks.O00OOOO02):O0O00OOO 2 O000OO00 $ctime
  ..$iif(%tanks.O0OO00003 isnum && $sock(tanks.3),%tanks.O00OOOO03):O0O00OOO 3 O000OO00 $ctime
  ..$iif(%tanks.O0OO00004 isnum && $sock(tanks.4),%tanks.O00OOOO04):O0O00OOO 4 O000OO00 $ctime
  ..$iif(%tanks.O0OO00005 isnum && $sock(tanks.5),%tanks.O00OOOO05):O0O00OOO 5 O000OO00 $ctime
  ..$iif(%tanks.O0OO00006 isnum && $sock(tanks.6),%tanks.O00OOOO06):O0O00OOO 6 O000OO00 $ctime
  ..$iif(%tanks.O0OO00007 isnum && $sock(tanks.7),%tanks.O00OOOO07):O0O00OOO 7 O000OO00 $ctime
  ..$iif(%tanks.O0OO00008 isnum && $sock(tanks.8),%tanks.O00OOOO08):O0O00OOO 8 O000OO00 $ctime
  ..$iif(%tanks.O0OO00009 isnum && $sock(tanks.9),%tanks.O00OOOO09):O0O00OOO 9 O000OO00 $ctime
  ..$iif(%tanks.O0OO000010 isnum && $sock(tanks.10),%tanks.O00OOOO010):O0O00OOO 10 O000OO00 $ctime
  ..$iif(%tanks.O0OO000011 isnum && $sock(tanks.11),%tanks.O00OOOO011):O0O00OOO 11 O000OO00 $ctime
  ..$iif(%tanks.O0OO000012 isnum && $sock(tanks.12),%tanks.O00OOOO012):O0O00OOO 12 O000OO00 $ctime
  ..$iif(%tanks.O0OO000013 isnum && $sock(tanks.13),%tanks.O00OOOO013):O0O00OOO 13 O000OO00 $ctime
  ..$iif(%tanks.O0OO000014 isnum && $sock(tanks.14),%tanks.O00OOOO014):O0O00OOO 14 O000OO00 $ctime
  ..$iif(%tanks.O0OO000015 isnum && $sock(tanks.15),%tanks.O00OOOO015):O0O00OOO 15 O000OO00 $ctime
  ..$iif(%tanks.O0OO000016 isnum && $sock(tanks.16),%tanks.O00OOOO016):O0O00OOO 16 O000OO00 $ctime
  ..$iif(%tanks.O0OO000017 isnum && $sock(tanks.17),%tanks.O00OOOO017):O0O00OOO 17 O000OO00 $ctime
  ..$iif(%tanks.O0OO000018 isnum && $sock(tanks.18),%tanks.O00OOOO018):O0O00OOO 18 O000OO00 $ctime
  ..$iif(%tanks.O0OO000019 isnum && $sock(tanks.19),%tanks.O00OOOO019):O0O00OOO 19 O000OO00 $ctime
  ..$iif(%tanks.O0OO000020 isnum && $sock(tanks.20),%tanks.O00OOOO020):O0O00OOO 20 O000OO00 $ctime
  ..$iif(%tanks.O0OO000021 isnum && $sock(tanks.21),%tanks.O00OOOO021):O0O00OOO 21 O000OO00 $ctime
  ..$iif(%tanks.O0OO000022 isnum && $sock(tanks.22),%tanks.O00OOOO022):O0O00OOO 22 O000OO00 $ctime
  ..$iif(%tanks.O0OO000023 isnum && $sock(tanks.23),%tanks.O00OOOO023):O0O00OOO 23 O000OO00 $ctime
  ..$iif(%tanks.O0OO000024 isnum && $sock(tanks.24),%tanks.O00OOOO024):O0O00OOO 24 O000OO00 $ctime
  ..$iif(%tanks.O0OO000025 isnum && $sock(tanks.25),%tanks.O00OOOO025):O0O00OOO 25 O000OO00 $ctime
  ..$iif(%tanks.O0OO000026 isnum && $sock(tanks.26),%tanks.O00OOOO026):O0O00OOO 26 O000OO00 $ctime
  ..$iif(%tanks.O0OO000027 isnum && $sock(tanks.27),%tanks.O00OOOO027):O0O00OOO 27 O000OO00 $ctime
  ..$iif(%tanks.O0OO000028 isnum && $sock(tanks.28),%tanks.O00OOOO028):O0O00OOO 28 O000OO00 $ctime
  ..$iif(%tanks.O0OO000029 isnum && $sock(tanks.29),%tanks.O00OOOO029):O0O00OOO 29 O000OO00 $ctime
  ..$iif(%tanks.O0OO000030 isnum && $sock(tanks.30),%tanks.O00OOOO030):O0O00OOO 30 O000OO00 $ctime
  ..$iif(%tanks.O0OO000031 isnum && $sock(tanks.31),%tanks.O00OOOO031):O0O00OOO 31 O000OO00 $ctime
  ..$iif(%tanks.O0OO000032 isnum && $sock(tanks.32),%tanks.O00OOOO032):O0O00OOO 32 O000OO00 $ctime
  ..-
  ..Ping &all users:O0OO000O O000OO00 $ctime
  .$iif($sock(tanks.*,0),&List IP addresses):{
    if ($version != 6.02) window -h @tanksO0000O0O
    var %tanks.OO0O0O00 = @Tanks IP addresses
    close -@ %tanks.OO0O0O00
    window $iif(%tanksontop,-fzdok0,-fzdk0) %tanks.OO0O0O00 -1 -1 420 $calc(36+16*$numtok(%tanks.O0OO000O,32)) Fixedsys 15
    aline %tanks.OO0O0O00 Server at %tanksip $+ : $+ %tanksport
    aline %tanks.OO0O0O00 -
    var %tanks.OO000O00 = %tanks.O000OOO0
    :0
    if (%tanks.OO000O00) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) && ($sock(tanks. [ $+ [ %tanks.OO000O00 ] ] )) iline %tanks.OO0O0O00 3 %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] $sock(tanks. [ $+ [ %tanks.OO000O00 ] ] ).ip
      dec %tanks.OO000O00
      goto 0
    }
  }
  .-
  .$iif($sock(tanks) && %tanks.OO0O000O [ $+ [ %tanks.OOO00OO0 ] ] > 0,Change your &vote to end this round):O0OO000O O00O0000
  .$iif(* !iswm $sock(tanks) && %tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O,&End this round):O00O00OO
  .$iif(* !iswm $sock(tanks) && %tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O,En&d current game):O00000OO
  .-
  .$iif(%tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] isnum,C&hange server name [ [ $+ [ %tanks.O00OOOO00 ] $+ ] ]):O00OO0O0 /sname
  .$iif(%tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] isnum && %tanks.OOO00OO0,Change &name [ [ $+ [ %tanks.O00OOOO0 [ $+ [ %tanks.OOO00OO0 ] ] ] $+ ] ]):OO0O0OOO
  .$iif(%tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] isnum,Change &color):O0000OO0
  .-
  .$iif($sock(tanks.*,0),&Kick user...)
  ..$iif(%tanks.O0OO00001 isnum,%tanks.O00OOOO01):OO0OO000 O000000O 1
  ..$iif(%tanks.O0OO00002 isnum,%tanks.O00OOOO02):OO0OO000 O000000O 2
  ..$iif(%tanks.O0OO00003 isnum,%tanks.O00OOOO03):OO0OO000 O000000O 3
  ..$iif(%tanks.O0OO00004 isnum,%tanks.O00OOOO04):OO0OO000 O000000O 4
  ..$iif(%tanks.O0OO00005 isnum,%tanks.O00OOOO05):OO0OO000 O000000O 5
  ..$iif(%tanks.O0OO00006 isnum,%tanks.O00OOOO06):OO0OO000 O000000O 6
  ..$iif(%tanks.O0OO00007 isnum,%tanks.O00OOOO07):OO0OO000 O000000O 7
  ..$iif(%tanks.O0OO00008 isnum,%tanks.O00OOOO08):OO0OO000 O000000O 8
  ..$iif(%tanks.O0OO00009 isnum,%tanks.O00OOOO09):OO0OO000 O000000O 9
  ..$iif(%tanks.O0OO000010 isnum,%tanks.O00OOOO010):OO0OO000 O000000O 10
  ..$iif(%tanks.O0OO000011 isnum,%tanks.O00OOOO011):OO0OO000 O000000O 11
  ..$iif(%tanks.O0OO000012 isnum,%tanks.O00OOOO012):OO0OO000 O000000O 12
  ..$iif(%tanks.O0OO000013 isnum,%tanks.O00OOOO013):OO0OO000 O000000O 13
  ..$iif(%tanks.O0OO000014 isnum,%tanks.O00OOOO014):OO0OO000 O000000O 14
  ..$iif(%tanks.O0OO000015 isnum,%tanks.O00OOOO015):OO0OO000 O000000O 15
  ..$iif(%tanks.O0OO000016 isnum,%tanks.O00OOOO016):OO0OO000 O000000O 16
  ..$iif(%tanks.O0OO000017 isnum,%tanks.O00OOOO017):OO0OO000 O000000O 17
  ..$iif(%tanks.O0OO000018 isnum,%tanks.O00OOOO018):OO0OO000 O000000O 18
  ..$iif(%tanks.O0OO000019 isnum,%tanks.O00OOOO019):OO0OO000 O000000O 19
  ..$iif(%tanks.O0OO000020 isnum,%tanks.O00OOOO020):OO0OO000 O000000O 20
  ..$iif(%tanks.O0OO000021 isnum,%tanks.O00OOOO021):OO0OO000 O000000O 21
  ..$iif(%tanks.O0OO000022 isnum,%tanks.O00OOOO022):OO0OO000 O000000O 22
  ..$iif(%tanks.O0OO000023 isnum,%tanks.O00OOOO023):OO0OO000 O000000O 23
  ..$iif(%tanks.O0OO000024 isnum,%tanks.O00OOOO024):OO0OO000 O000000O 24
  ..$iif(%tanks.O0OO000025 isnum,%tanks.O00OOOO025):OO0OO000 O000000O 25
  ..$iif(%tanks.O0OO000026 isnum,%tanks.O00OOOO026):OO0OO000 O000000O 26
  ..$iif(%tanks.O0OO000027 isnum,%tanks.O00OOOO027):OO0OO000 O000000O 27
  ..$iif(%tanks.O0OO000028 isnum,%tanks.O00OOOO028):OO0OO000 O000000O 28
  ..$iif(%tanks.O0OO000029 isnum,%tanks.O00OOOO029):OO0OO000 O000000O 29
  ..$iif(%tanks.O0OO000030 isnum,%tanks.O00OOOO030):OO0OO000 O000000O 30
  ..$iif(%tanks.O0OO000031 isnum,%tanks.O00OOOO031):OO0OO000 O000000O 31
  ..$iif(%tanks.O0OO000032 isnum,%tanks.O00OOOO032):OO0OO000 O000000O 32
  .$iif($sock(tanks.*,0),Edit &ban list):{
    if ($dialog(tanksban)) dialog -ev tanksban
    else dialog $iif(%tanksontop,-dmo,-dm) tanksban tanksban
  }
  Syst&em
  .$O0O000O0(-,%tanksforget) &Remember increment setting between rounds:%tanksforget = $iif(%tanksforget,0,1)
  .-
  .$O0O000O0(-,%tanksnosound) &Play sounds:%tanksnosound = $iif(%tanksnosound,0,1)
  .-
  .$O0O000O0(%tanks.O0000O0O) &Fast mode:%tanks.O0000O0O = $iif(%tanks.O0000O0O,0,1) | %tanksfast = %tanks.O0000O0O | .timertanks.OO00O0O0 -e
  .-
  .$O0O000O0(%tanksautoscroll,&Automatically scroll names list to active player):%tanksautoscroll = $iif(%tanksautoscroll,0,1)
  .$O0O000O0(%tankstahoma,Use the &Tahoma font):OOO0000O $iif(%tankstahoma,0,1)
  .$iif($sock(tanks),$O0O000O0(%tanksnochat,Disable &chat text && player names)):O0000OOO $iif(%tanksnochat,0,1)
  .$O0O000O0(%tankslog) &Log chat to tanks.log:%tankslog = $iif(%tankslog,0,1)
  .-
  .$O0O000O0(%tanksnoctcp,&Disable Tanks ctcp reply):%tanksnoctcp = $iif(%tanksnoctcp,0,1)
  .$O0O000O0(%tanksnolisten,&Ignore all Tanks requests):%tanksnolisten = $iif(%tanksnolisten,0,1)
  .-
  .$O0O000O0(-,%tanksnomenu) Show Tanks &menu in query, nicklist, and menubar:%tanksnomenu = $iif(%tanksnomenu,0,1)
  Win&dow
  .$O0O000O0($iif(%tankstitle & 1,1)) Show in titlebar $+ $chr(58)  &Round:%tankstitle = $iif(%tankstitle & 1,$bitoff(%tankstitle,1),$biton(%tankstitle,1)) | OO0O0000
  .$O0O000O0($iif(%tankstitle & 2,1)) Show in titlebar $+ $chr(58)  &Frags:%tankstitle = $iif(%tankstitle & 2,$bitoff(%tankstitle,2),$biton(%tankstitle,2)) | OO0O0000
  .$O0O000O0($iif(%tankstitle & 4,1)) Show in titlebar $+ $chr(58)  &Accuracy:%tankstitle = $iif(%tankstitle & 4,$bitoff(%tankstitle,3),$biton(%tankstitle,3)) | OO0O0000
  .$O0O000O0($iif(%tankstitle & 8,1)) Show in titlebar $+ $chr(58)  &Server name:%tankstitle = $iif(%tankstitle & 8,$bitoff(%tankstitle,4),$biton(%tankstitle,4)) | OO0O0000
  .-
  .$O0O000O0(-,%tanksnopop) &Un-minimize on your turn:%tanksnopop = $iif(%tanksnopop,0,1)
  .$O0O000O0(%tanksontop) &Window on top:%tanksontop = $iif(%tanksontop,0,1) | OO0OO0OO @Tanks
  .$O0O000O0(-,%tanksnoxy) R&emember window position:%tanksnoxy = $iif(%tanksnoxy,0,1)
  .-
  .$iif($sock(tanks.*,0) && $version != 6.02,Hi&de this window):window -h @Tanks
  -
  Versio&n:abouttanks
  &Readme:tanksreadme
  -
  Ser&ver list:tanklist
}
menu @Tanks request {
  mouse:O0O0OOOO
  leave:O0O0OOOO
  sclick:{
    var %tanks.O00000OO = $click(@Tanks request,$click(@Tanks request,0)).x, %tanks.O00O0O00 = $click(@Tanks request,$click(@Tanks request,0)).y
    if ($inrect(%tanks.O00000OO,%tanks.O00O0O00,16,24,39,15)) {
      close -@ @Tanks request
      OO000O0O
      sockopen tanks %tankstempip %tankstempport
    }
    elseif ($inrect(%tanks.O00000OO,%tanks.O00O0O00,64,24,31,15)) {
      close -@ @Tanks request
      OOO0OOO0 decline
    }
  }
}
alias tanksversion var %tanks.O0000OO0 = 2004.06.04 | if ($1) return %tanks.O0000OO0 | return Tanks [[ $+ %tanks.O0000OO0 $+ ]]
on *:sockopen:tanksversion:{
  if ($sockerr) {
    O00O000O Connection error $sockerr
    return
  }
  sockwrite -n $sockname GET /pdufilie/versions.txt HTTP/1.0
  sockwrite -n $sockname Accept: */*
  sockwrite -n $sockname Host: pages.cthome.net
  sockwrite -n $sockname
}
menu @Tanks scores {
  &Refresh:.timertanks.OO000OOO -o 1 0 OO000OOO
}
alias tankslist tanklist
alias -l O0O0OOOO {
  var %tanks.O00000OO = $mouse.x, %tanks.O00O0O00 = $mouse.y
  drawtext -rbn @Tanks request %tanks.0 $iif($inrect(%tanks.O00000OO,%tanks.O00O0O00,16,24,39,15),%tanks.12,%tanks.2) Fixedsys 15 16 24 [Yes]
  drawtext -rbn @Tanks request %tanks.0 $iif($inrect(%tanks.O00000OO,%tanks.O00O0O00,64,24,31,15),%tanks.12,%tanks.2) Fixedsys 15 64 24 [No]
  drawdot @Tanks request
}
alias -l O000O0OO .timertanks $+ $rand(0,999999) $+ $ticks -o 1 0 $1-
on *:dialog:tankschat:sclick:*:{
  if ($did == 1) did -f $dname 2
  elseif ($did == 3) && (* iswm %tanks.OO0OOOOO) {
    var %tanks.O00000OO, %tanks.O0OO0O0O, %tanks.OO000O00, %tanks.OOO0OO00
    while (1) {
      %tanks.O00000OO = $did($dname,1,1).sel
      if (%tanks.O00000OO) {
        %tanks.OO000O00 = $gettok(%tanks.OO0OOOOO,%tanks.O00000OO,32)
        %tanks.O0OO0O0O = $addtok(%tanks.O0OO0O0O,%tanks.OO000O00,44)
        did -uk $dname 1 %tanks.O00000OO
      }
      else break
    }
    %tanks.O000OO0O = %tanks.O0OO0O0O
    unset %tanks.OO0OOOOO
  }
}
alias -l O0O0OO0O {
  tokenize 32 %tanks.O0OO000O
  var %tanks.O0OO0OO0 = $1-
  while ($1) {
    var %tanks.OO000O0O = $iif(%tanks.O00OO0OO [ $+ [ $1 ] ] isnum,127.0.0.1,$sock(tanks. [ $+ [ $1 ] ] ).ip)
    if (%tanks.OO000O0O) O0000O00 $1 %tanks.OO000O0O %tanks.O00OOOO0 [ $+ [ $1 ] ]
    tokenize 32 $2-
  }
  if (%tanks.O0OO0OO0 != %tanks.O0OO000O) O0OOO0O0
}
alias -l tanks.alias.initvars {
  var %tanks.OO000O00 = %tanks.O000OOO0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      %tanks.OO00O0OO [ $+ [ %tanks.OO000O00 ] ] = $iif(%tanks.OO0O0OOO [ $+ [ %tanks.OO000O00 ] ] > $calc(%tankswidth /2),145,35)
      %tanks.OO0OO000 [ $+ [ %tanks.OO000O00 ] ] = 45
      %tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] = 11
      %tanks.O0OO00O0 [ $+ [ %tanks.OO000O00 ] ] = 100
      unset %tanks.OO0OO0OO [ $+ [ %tanks.OO000O00 ] ]
      if (%tanksforget) %tanksinc = 5
    }
    dec %tanks.OO000O00
  }
  %tanks.O0OO0OOO = 1
  OO0O0000 Drawing land...
}
on *:sockwrite:tanks.*.*:.timer -o 1 15 sockclose $sockname
alias -l OOO000OO {
  O000O0OO close -@ $OO0OOOOO
  if ($isfile($remove($O00O0OO0,"))) {
    O00O000O Installing...
    .timertankserror -o 1 0 O00O0000 An error occurred while downloading Tanks.
    run -n $O00O0OO0
    .timertankserror off
    O000O000 0 $window($OO0OOOOO).state
    :error
  }
}
alias -l OO0O0O00 {
  if (* !iswm $window(@Tanks)) || (%tankschat.O00O0OOO !isnum) return
  if (%tankschat.O00OO000 == 0) {
    OOO0O0O0 - O000O0O0 Right-click for commands and options
    if ($sock(tanks)) && (%tanksnochat) OOO0O0O0 - O000O0O0 Chat text and player names are disabled
    elseif ($sock(tanks.*,0)) || ($sock(tanks)) OOO0O0O0 - O000O0O0 Press 'T' to chat or 'M' to send a private message
    if (%tanksnochat != 1) || (* !iswm $sock(tanks)) && (%tanks.O0OO00000 isnum) OOO0O0O0 - $iif($timer(tanks.OOO0O0O0),O000O0O0,O000O000) Server is: %tanks.O00OOOO00
    %tankschat.O00OO000 = $line(@tanksO00000O0,0)
  }
  drawrect -fnr @Tanks %tankschat.O000OOOO 1 %tankschat.O00O0000 %tankschat.O00O00OO 15 %tankschat.O00000O0
  if (%tankschat.O00OO000 < 12) %tankschat.O000OO0O = %tanksheight + 15
  else {
    %tankschat.O000OO0O = $int($calc(%tanksheight -30-(%tankschat.O00000O0 -15)*%tankschat.O00O0O0O /(%tankschat.O00OO000 -11)))
    if (%tankschat.O000O0OO == O00000OO) drawrect -fnr @Tanks %tankschat.O000O0O0 1 %tankschat.O00O0000 %tankschat.O00O00OO 15 $calc(%tankschat.O000OO0O -%tankschat.O00O00OO)
    elseif (%tankschat.O000O0OO == O000OO00) drawrect -fnr @Tanks %tankschat.O000O0O0 1 %tankschat.O00O0000 %tankschat.O000OO0O 15 $calc(%tankschat.O000O00O -%tankschat.O000OO0O)
    drawpic -cn @Tanks %tankschat.O00O0000 %tankschat.O000OO0O 180 115 15 15 %tanksbmp
  }
  var %tanks.O00000OO = 150
  if (%tankschat.O000O0OO == O00O0000) && (%tankschat.O0000O0O) %tanks.O00000OO = 165
  drawpic -cn @Tanks %tankschat.O00O0000 %tankschat.O00000OO %tanks.O00000OO 115 15 15 %tanksbmp
  %tanks.O00000OO = 150
  if (%tankschat.O000O0OO == O0000O00) && (%tankschat.O0000O0O) %tanks.O00000OO = 165
  drawpic -cn @Tanks %tankschat.O00O0000 %tankschat.O000O00O %tanks.O00000OO 130 15 15 %tanksbmp
  var %tanks.O00000OO = %tankschat.O00O0OO0, %tanks.O0O0OOOO = %tankschat.O00000OO, %tanks.OO0O0O00 = %tankschat.O00OO0O0, %tanks.O000OOOO = %tankschat.O00OO00O, %tanks.OO00000O
  drawrect -rfn @Tanks %tankschat.O00O0OOO 1 %tanks.O00000OO %tanks.O0O0OOOO %tanks.OO0O0O00 %tanks.O000OOOO
  inc %tanks.O00000OO 3
  %tanks.OO0O0O00 = $calc(%tanks.OO0O0O00 -19-%tankstahoma)
  var %tanks.O00O0O00 = $calc(%tanks.O0O0OOOO -15+%tanks.O000OOOO), %tanks.OO0OOO0O = $calc(%tanks.O00000OO +14+%tankstahoma), %tanks.O0000OO0, %tanks.O0OO0O0O = %tankschat.O00O0O0O
  while (%tanks.O00O0O00 > %tanks.O0O0OOOO) {
    inc %tanks.O0OO0O0O
    tokenize 32 $line(@tanksO00000O0,%tanks.O0OO0O0O)
    if (* !iswm $1) {
      drawdot @Tanks
      return
    }
    if ($1 == O000O000) %tanks.O0000OO0 = $2-
    elseif ($1 == O000O0OO) %tanks.O0000OO0 = $4-
    else %tanks.O0000OO0 = $3-
    if ( * !iswm %tanks.O0000OO0) {
      if ($1 != O000O000) drawrect -rfn @Tanks $2 1 %tanks.O00000OO %tanks.O00O0O00 12 12
      drawpic -cnt @Tanks 16711935 %tanks.O00000OO %tanks.O00O0O00 $replace($1,O0000O0O,120,O000000O,132,O00000OO,132,O00000O0,132,O0000O00,132,O0000000,132,O000O00O,132,O000O0OO,144,O000OO00,156,O0000OOO,168,O000O000,180) 80 12 12 %tanksbmp
      if ($1 == O000O0OO) drawfill -srn @Tanks $3 16777215 $calc(10+%tanks.O00000OO) $calc(10+%tanks.O00O0O00)
    }
    if ($1 == O00000O0) %tanks.OO00000O = %tankschat.O0000OO0
    elseif ($istok(O0000000 O0000O00,$1,32)) %tanks.OO00000O = %tankschat.O0000O00
    elseif ($1 == O00000OO) %tanks.OO00000O = 6291520
    elseif ($1 == O000000O) %tanks.OO00000O = 8388688
    else %tanks.OO00000O = %tankschat.O000000O
    drawtext -nrc @Tanks %tanks.OO00000O %tankschat.O000OO00 %tankschat.O00O0O00 %tanks.OO0OOO0O $calc(%tanks.O00O0O00 -%tankstahoma) %tanks.OO0O0O00 13 %tanks.O0000OO0
    dec %tanks.O00O0O00 13
  }
  if (%tankschat.O000O000) %tankschat.O00OOO00
  drawdot @Tanks
}
on *:close:@tanksO00000O0:OOO0OO00
alias -l OO00OO00 {
  var %tanks.OO00000O = %tanks.O0OO0000 [ $+ [ $1 ] ] , %tanks.O00000OO = %tanks.OO0O0OOO [ $+ [ $1 ] ] , %tanks.O00O0O00 = %tanks.O0O000O0 [ $+ [ $1 ] ] , %tanks.O0O0OO00 = -8, %tanks.O000O000 = 9 + %tankswidth, %tanks.O0OO0O0O = %tanks.O000OOO0, %tanks.OOO0OO0O = %tanks.OO0O000O [ $+ [ $1 ] ] , %tanks.OO000O00 = 312, %tanks.O0OO0O00 = %tanks.OO00O0OO [ $+ [ $1 ] ]
  if (%tanks.OO00000O isnum) && (%tanks.O00000OO) { }
  else return
  while (%tanks.O0OO0O0O) {
    if (%tanks.OO0O000O [ $+ [ %tanks.O0OO0O0O ] ] > 0) && (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) && (%tanks.O0OO0O0O != $1) {
      var %tanks.O00O0OOO = %tanks.OO0O0OOO [ $+ [ %tanks.O0OO0O0O ] ]
      if (%tanks.O00O0OOO < %tanks.O00000OO) && (%tanks.O00O0OOO > %tanks.O0O0OO00) %tanks.O0O0OO00 = %tanks.O00O0OOO
      if (%tanks.O00O0OOO > %tanks.O00000OO) && (%tanks.O00O0OOO < %tanks.O000O000) %tanks.O000O000 = %tanks.O00O0OOO
    }
    dec %tanks.O0OO0O0O
  }
  inc %tanks.O0O0OO00 18
  dec %tanks.O000O000 18
  if (%tanks.OOO0OO0O < 1) {
    if (%tanks.OOO00000 [ $+ [ $1 ] ] ) return
    %tanks.OO00000O = %tanks.OOO0000O
    %tanks.OOO00000 [ $+ [ $1 ] ] = 1
  }
  else %tanks.OOO00000 [ $+ [ $1 ] ] = 0
  var %tanks.O0OO00OO = drawfill -srn @Tanks %tanks.OOO0000O %tanks.OO00000O, %tanks.OOO00OOO = drawfill -srn @Tanks %tanks.OO00000O 16777215
  %tanks.O0OO00OO %tanks.O00000OO %tanks.O00O0O00
  var %tanks.O00O00O0 = %tanks.O00000OO - 6, %tanks.OO0OOO0O = %tanks.O00000OO + 5, %tanks.O0O00OO0 = %tanks.O00000OO, %tanks.O00OO0O0 = %tanks.O00000OO + 1, %tanks.O00O0OOO, %tanks.O0OO0O0O = 1, %tanks.O0000OO0 = drawline -rn @Tanks 16777215 1
  if (%tanks.O0OO0O00 > $iif(%tanks.O00000OO > $calc(%tankswidth /2),89,90)) {
    inc %tanks.O00O00O0
    inc %tanks.OO0OOO0O
    dec %tanks.O0O00OO0 2
    dec %tanks.O00OO0O0 4
    inc %tanks.OO000O00 15
    %tanks.O0OO0O0O = -1
  }
  %tanks.O0OO0O00 = $calc(%tanks.O0OO0O00 *3.14159/180)
  var %tanks.OO00O000 = $round($calc(6*$cos(%tanks.O0OO0O00)),0), %tanks.O00OOO0O = $round($calc(7+6*$sin(%tanks.O0OO0O00)),0), %tanks.OOO0OO00, %tanks.OO000O0O = -1
  if ($2) %tanks.OOO0OO00 = return $1
  :1
  inc %tanks.OO000O0O
  drawrect -rnf @Tanks %tanks.OOO0000O 1 $calc(%tanks.O00000OO -6) $calc(%tanks.O00O0O00 -13) 11 12
  drawpic -cnt @Tanks 16711935 $calc(%tanks.O00000OO -8) $calc(%tanks.O00O0O00 -9) %tanks.OO000O00 0 15 10 %tanksbmp
  %tanks.O0000OO0 $calc(%tanks.O00OO0O0 +%tanks.OO00O000) $calc(1+%tanks.O00O0O00 -%tanks.O00OOO0O) %tanks.O00OO0O0 $calc(%tanks.O00O0O00 -6)
  %tanks.O0000OO0 $calc(%tanks.O0O00OO0 +%tanks.O0OO0O0O +%tanks.OO00O000) $calc(%tanks.O00O0O00 -%tanks.O00OOO0O) %tanks.O0O00OO0 $calc(%tanks.O00O0O00 -6)
  %tanks.O0000OO0 $calc(%tanks.O0O00OO0 +%tanks.OO00O000) $calc(%tanks.O00O0O00 -%tanks.O00OOO0O) %tanks.O0O00OO0 $calc(%tanks.O00O0O00 -7)
  %tanks.OOO00OOO %tanks.O00000OO %tanks.O00O0O00
  if (%tanks.OO00000O == %tanks.OOO0000O) {
    var %tanks.OO00OO00 = 21, %tanks.O0OOO0O0, %tanks.O000OOOO
    while (%tanks.OO00OO00) {
      %tanks.O0OOO0O0 = $calc(%tanks.O00000OO +%tanks.OO00OO00 -11)
      %tanks.O000OOOO = %tanks.O0OOO0O0 - 1
      drawline -rn @Tanks %tanks.O0O0O00O 1 %tanks.O000OOOO $line(@tanksO00000OO,%tanks.O0OOO0O0) %tanks.O000OOOO %tanks.OO0OO0O0
      dec %tanks.OO00OO00
    }
  }
  if (%tanks.OO000O0O) drawdot @Tanks
  if (%tanks.OOO0OO0O < 1) return
  var %tanks.OO00OO00 = $iif(%tanks.O00O0O00 >= $line(@tanksO00000OO,%tanks.O00O00O0),1), %tanks.O0OO0OO0 = $iif(%tanks.O00O0O00 >= $line(@tanksO00000OO,%tanks.OO0OOO0O),1)
  if (%tanks.OO00OO00) && (%tanks.O0OO0OO0) goto 3
  if (%tanks.O0OO0OO0) && (%tanks.O00O0OOO == O0000000) || ((%tanks.OO00OO00) && (%tanks.O00O0OOO == O000000O)) {
    %tanks.OOO0OO00
    %tanks.O0OO00OO %tanks.O00000OO %tanks.O00O0O00
    inc %tanks.O00O0O00
    goto 1
  }
  var %tanks.O0O0OOOO = 0 + $line(@tanksO00000OO,%tanks.O00000OO)
  if ($calc(2+%tanks.O00O0O00) > %tanks.O0O0OOOO) goto 3
  if (%tanks.O0OO0OO0) {
    if (%tanks.O00000OO > %tanks.O0O0OO00) {
      %tanks.OOO0OO00
      %tanks.O0OO00OO %tanks.O00000OO %tanks.O00O0O00
      dec %tanks.O0O00OO0
      dec %tanks.O00OO0O0
      dec %tanks.O00000OO
      dec %tanks.O00O00O0
      dec %tanks.OO0OOO0O
      %tanks.O00O0OOO = O000000O
      goto 1
    }
  }
  elseif (%tanks.OO00OO00) {
    if (%tanks.O00000OO < %tanks.O000O000) {
      %tanks.OOO0OO00
      %tanks.O0OO00OO %tanks.O00000OO %tanks.O00O0O00
      inc %tanks.O0O00OO0
      inc %tanks.O00OO0O0
      inc %tanks.O00000OO
      inc %tanks.O00O00O0
      inc %tanks.OO0OOO0O
      %tanks.O00O0OOO = O0000000
      goto 1
    }
  }
  elseif ($calc(2+%tanks.O00O0O00) < %tanks.O0O0OOOO) {
    %tanks.OOO0OO00
    %tanks.O0OO00OO %tanks.O00000OO %tanks.O00O0O00
    inc %tanks.O00O0O00 2
    goto 1
  }
  else {
    %tanks.OOO0OO00
    %tanks.O0OO00OO %tanks.O00000OO %tanks.O00O0O00
    inc %tanks.O00O0O00
    goto 1
  }
  :3
  %tanks.OO0O0OOO [ $+ [ $1 ] ] = %tanks.O00000OO
  %tanks.O0O000O0 [ $+ [ $1 ] ] = %tanks.O00O0O00
}
dialog abouttanks {
  title "Tanks"
  option dbu
  size -1 -1 72 77
  button "&Check for a new version"3,2 49 68 12
  button "Install &newest version"4,2 63 68 12
  edit ""1,2 2 68 17,centereadmulti
  button "&Website"99,2 21 33 12
  button "&Readme"97,37 21 33 12
  button ""98,0 0 0 0,okcancelhidden
  edit ""2,2 35 68 12,centeread
}
alias -l OO00O0O0 {
  if ($window(@Tanks)) && (* iswm %tanks.O0O00O00) && (* iswm %tanks.OOO0000O) {
    drawfill -nrs @Tanks %tanks.O0O00O00 %tanks.OOO0000O 0 0
    drawfill -nrs @Tanks %tanks.OOO0000O %tanks.O0O00O00 0 0
    drawfill -nrs @Tanks %tanks.O0O00O00 %tanks.OOO0000O 0 0
    drawfill -nrs @Tanks %tanks.OOO0000O %tanks.O0O00O00 0 0
    if (%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O) OO0000O0
  }
}
alias -l O0OOOOO0 {
  if ($1 == 3) O00O0000 Tanks $3- error (server not found)
  else O00O0000 Tanks $3- error $1 $sock($2).wsmsg
  sockclose $2
}
alias -l O000000O {
  var %tanks.O00000OO = %tanks.O0OOOO0O
  if ($1) %tanks.O00000OO = $1
  %tanks.O00000OO = $int($calc(%tanks.O0O00O0O [ $+ [ %tanks.O00000OO ] ] /25))
  if (%tanks.O00000OO < 1) return 1
  if (%tanks.O00000OO > 5) return 5
  return %tanks.O00000OO
}
alias tanks.chat O00OO0O0 $1-
alias -l OO000OOO {
  if ($version != 6.02) window -h @tanksO0000O0O
  var %tanks.OO00O000 = @tankscore, %tanks.O00OOO0O = @Tanks scores, %tanks.O0OO0O0O = $timer(tanks.OO000OOO), %tanks.OOO0OO00 = $window(%tanks.O00OOO0O).x $window(%tanks.O00OOO0O).y, %tanks.O0OO0OO0 = $numtok(%tanks.O0OO000O,32)
  close -@ %tanks.OO00O000
  window -hls %tanks.OO00O000
  var %tanks.OO000O00 = %tanks.O000OOO0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      var %tanks.O0OO0O00 = $calc($round($calc(100*%tanks.OO0O0OO0 [ $+ [ %tanks.OO000O00 ] ] /%tanks.OO0OOO00 [ $+ [ %tanks.OO000O00 ] ] ),0) +50000), %tanks.O00O0OOO = $calc(%tanks.OO0O0OO0 [ $+ [ %tanks.OO000O00 ] ] +50000), %tanks.O0000OO0 = $calc(%tanks.O000O0OO [ $+ [ %tanks.OO000O00 ] ] +50000), %tanks.OOO00OOO = $calc(%tanks.O00OOO00 [ $+ [ %tanks.OO000O00 ] ] +50000)
      if (\ 50000 50000 50000 50000 \ != \ %tanks.O0OO0O00 %tanks.O00O0OOO %tanks.O0000OO0 %tanks.OOO00OOO \) %tanks.O0OO0O0O = 1
      if ($sock(tanks.*,0)) || ($sock(tanks)) && (%tanks.O00O0OO0 !& 1) && (%tanks.O000O0OO [ $+ [ %tanks.OO000O00 ] ] < 5) %tanks.O0OO0O00 = 50000 !
      aline %tanks.OO00O000 $str(!,$calc(6-$len($gettok(%tanks.O0OO0O00,1,32)))) $+ %tanks.O0OO0O00 $str(!,$calc(6-$len(%tanks.O00O0OOO))) $+ %tanks.O00O0OOO $str(!,$calc(6-$len(%tanks.OOO00OOO))) $+ %tanks.OOO00OOO $str(!,$calc(6-$len(%tanks.O0000OO0))) $+ %tanks.O0000OO0 %tanks.OO000O00
    }
    dec %tanks.OO000O00
  }
  if ($line(%tanks.OO00O000,0)) && (%tanks.O0OO0O0O) {
    %tanks.O0OO0OO0 = 580 $calc(16 * $iif(%tanks.O0OO0OO0 < 8,8,%tanks.O0OO0OO0) + 20)
    if (* * iswm %tanks.OOO0OO00) {
      window -fa %tanks.O00OOO0O %tanks.OOO0OO00 %tanks.O0OO0OO0
      filter -wwcx %tanks.O00OOO0O %tanks.O00OOO0O
    }
    else window $iif(%tanksontop,-fzdok0,-fzdk0) %tanks.O00OOO0O -1 -1 %tanks.O0OO0OO0 Fixedsys 15
    while ($line(%tanks.OO00O000,0)) {
      %tanks.O0000OO0 = $line(%tanks.OO00O000,1)
      tokenize 32 $remove(%tanks.O0000OO0,!)
      if (* ! * iswm %tanks.O0000OO0) %tanks.O0OO0O00 = [Wait]
      else %tanks.O0OO0O00 = $calc($1 -50000) $+ %
      %tanks.O0000OO0 = iline %tanks.O00OOO0O 1 Accuracy: %tanks.O0OO0O00 $+ ; 
      if (%tanks.O00O0OO0 !& 1) %tanks.O0000OO0 = %tanks.O0000OO0 Damage: $calc($2 -50000) $+ ; 
      %tanks.O0000OO0 Frags: $calc($3 -50000) $+ ;  Turns: $calc($4 -50000) $+ ;  %tanks.O00OOOO0 [ $+ [ $5 ] ]
      dline %tanks.OO00O000 1
    }
    while (1) {
      aline %tanks.O00OOO0O  
      if ($line(%tanks.O00OOO0O,0) >= 9) break
    }
  }
  else close -@ %tanks.O00OOO0O
  close -@ %tanks.OO00O000
}
alias -l O0OO00OO {
  tanks.alias.initvars
  drawrect -rfn @Tanks %tanks.OOO0000O 1 0 0 %tankswidth %tanks.OO0OO0O0
  tokenize 32 . %tanks.O0O0O0OO
  var %tanks.O0OO0O0O, %tanks.OO00OO00 = 0, %tanks.OO00O00O = $2, %tanks.O000OOOO, %tanks.OO000O0O = 0, %tanks.O00000OO = 1, %tanks.OO0OOO0O = 0, %tanks.O00O0O00, %tanks.O00O0OOO = drawline -rn @Tanks %tanks.O0O0O00O 1
  while (%tanks.O00000OO <= %tankswidth) && (* iswm $2) {
    if (%tanks.OO000O0O >= %tanks.OO00OO00) || (%tanks.O00000OO == %tankswidth) {
      tokenize 32 $3-
      %tanks.O00O0O00 = $1
      %tanks.OO00OO00 = $2
      %tanks.OO000O0O = 0
    }
    %tanks.O000OOOO = $int(%tanks.OO00O00O)
    %tanks.O00O0OOO %tanks.OO0OOO0O %tanks.O000OOOO %tanks.OO0OOO0O %tanks.OO0OO0O0
    rline @tanksO00000OO %tanks.O00000OO %tanks.O000OOOO
    inc %tanks.OO00O00O %tanks.O00O0O00
    inc %tanks.O00000OO
    inc %tanks.OO000O0O
    inc %tanks.OO0OOO0O
  }
  OOO00OOO
}
alias -l O00O0O0O {
  var %tanks.OOO0OO0O = 0, %tanks.O0000OO0
  while (%tanks.OOO0OO0O <= %tanks.O000OOO0) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OOO0OO0O ] ] isnum) %tanks.O0000OO0 = %tanks.O0000OO0 %tanks.OOO0OO0O %tanks.O0O0OO0O [ $+ [ %tanks.OOO0OO0O ] ] %tanks.O00OOOO0 [ $+ [ %tanks.OOO0OO0O ] ]
    inc %tanks.OOO0OO0O
  }
  return %tanks.O0000OO0
}
alias -l O0OOOO0O {
  if (%tanks.O0OOOOOO) O000OO00
  :0
  var %tanks.OO000O00 = %tanks.O0OOOO0O + 1, %tanks.OO00OO00, %tanks.O0OO0O0O
  while (%tanks.OO000O00 <= %tanks.O000OOO0) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) %tanks.OO00OO00 = %tanks.OO00OO00 %tanks.OO000O00
    inc %tanks.OO000O00
  }
  %tanks.OO000O00 = 1
  while (%tanks.OO000O00 <= %tanks.O000OOO0) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) %tanks.O0OO0O0O = %tanks.O0OO0O0O %tanks.OO000O00
    inc %tanks.OO000O00
  }
  %tanks.OO00OO00 = %tanks.OO00OO00 %tanks.O0OO0O0O %tanks.O0OO0O0O
  %tanks.O0OO0O0O = 1
  while (%tanks.O0OO0O0O <= $numtok(%tanks.OO00OO00,32)) {
    %tanks.OO000O00 = $gettok(%tanks.OO00OO00,%tanks.O0OO0O0O,32)
    if (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) && (%tanks.OO000O00 != %tanks.O0OOOO0O) {
      %tanks.O0OOOO0O = %tanks.OO000O00
      break
    }
    if (%tanks.OO000O00 == %tanks.O0OOOO0O) {
      %tanks.O0OOOO0O = $gettok(%tanks.OO00OO00,$calc(1+%tanks.O0OO0O0O),32)
      break
    }
    inc %tanks.O0OO0O0O
  }
  var %tanks.OOO0OO0O = tanks. $+ %tanks.O0OOOO0O
  if (* !iswm $sock(%tanks.OOO0OO0O)) && (* !iswm $sock(tanks)) && (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] == 5) %tanks.OOO00OO0 = %tanks.O0OOOO0O
  if (%tanks.O00OO000 > 1) %tanks.O00000O0 = %tanks.OO0OOOO0
  OOO00O0O 1
  O0OO0OO0 1
  tokenize 32 %tanks.O0OO000O
  var %tanks.O0OO0O0O = 0
  while ($1) {
    if (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) inc %tanks.O0OO0O0O
    tokenize 32 $2-
  }
  if (%tanks.O0OO0O0O > 1) O00OO0OO
  if (%tanks.O0OO0O0O < 2) || ($OOO00O00) {
    if ($OOO00O00 > 1) {
      O00000OO
      return
    }
    else {
      O00O00OO
      return
    }
  }
  if (%tankslvr) {
    var %tanks.OO00000O = 0, %tanks.OOO0OO0O = 0
    tokenize 32 %tanks.O0OO000O
    while ($1) {
      if (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) && ($1 != %tanks.O0OOOO0O) {
        inc %tanks.OOO0OO0O
        if ($iif(%tanks.OO0O0OOO [ $+ [ $1 ] ] < $calc(%tankswidth /2),1,0) != $iif(%tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] < $calc(%tankswidth /2),1,0)) inc %tanks.OO00000O
      }
      tokenize 32 $2-
    }
    if (%tanks.OO00000O == 0) && (%tanks.OOO0OO0O) {
      %tanks.OO00000O = 1
      while (%tanks.OO00000O <= %tanks.O000OOO0) {
        if (%tanks.O0OO0000 [ $+ [ %tanks.OO00000O ] ] isnum) && (%tanks.O00OO0OO [ $+ [ %tanks.OO00000O ] ] isnum 0-4) && (%tanks.OO0O000O [ $+ [ %tanks.OO00000O ] ] > 0) && (%tanks.O00O000O [ $+ [ %tanks.OO00000O ] ] != 1) {
          if ($O000O0O0(%tanks.OO00000O,1)) return
        }
        inc %tanks.OO00000O
      }
      if ($timer(tanks.O0O00O0O)) .timertanks.O0O00O0O -om 1 $rand(10275,10400) O0O00O0O
    }
  }
}
alias -l OO0OO00O {
  var %tanks.OO00000O = $O0OOOOOO($2), %tanks.O0OO0O00 = %tanks.O0OO0000 [ $+ [ $1 ] ]
  if (%tanks.O0O0OO0O [ $+ [ $1 ] ] == %tanks.OO00000O) return
  if ($sock(tanks.*,0)) O0OO000O O0000O00 $1 %tanks.OO00000O
  $O00OOOOO($1,%tanks.OO00000O)
  if ($1 == %tanks.O0OOOO0O) O000O00O
  O0000000
  OO00OO00 $1
  OOO0O0O0 O000O0OO %tanks.O0OO0O00 %tanks.O00OOOO0 [ $+ [ $1 ] ] %tanks.O0OO0000 [ $+ [ $1 ] ]
}
alias -l OOO0OO0O {
  var %tanks.OO0O0O00 = 0
  if ($1 isnum) {
    %tanks.OO0O0O00 = $1
    tokenize 32 $2-
    if (%tanks.OO0O0O00 > 12500) sockclose tanklist
  }
  if (%tankspublic) && ($sock(tanks.0)) || (action=list* iswm $1) || ($1 == action=remove) || (error=* iswm $1) {
    %tankslisting = $iif(action=list* iswm $1,1,0)
    if ($sock(tanklist)) .timertanks.OOO0OO0O -m 1 250 OOO0OO0O $calc(250+%tanks.OO0O0O00) $1-
    else {
      if ($sock(tanks.0)) tokenize 32 $1- $+ &id= $+ %tanksid
      %tankslistsend = $1- $+ &remove= $+ %tanksremove
      if (%tanksbackup) {
        socket tanklist tanks.mircscripts.org
        socket tanklist2 tanks.ileet.net
      }
      else {
        socket tanklist tanks.ileet.net
        sockclose tanklist2
      }
    }
  }
}
alias -l O00O0000 echo $colour(i) -iat *** $1-
alias -l OOO0OOO0 {
  if ($1 == 0) !.notice $2 tanks $3-
  else !.notice %tankstempnick tanks $1-
}
alias -l OOO0000O {
  if ($1 isnum 0-1) %tankstahoma = $1
  if (%tankstahoma !isnum 0-1) %tankstahoma = 1
  if (%tankstahoma) {
    %tankschat.O00O0O00 = $iif($version < 5.91,13,11)
    %tankschat.O00O000O = Tahoma
    %tankschat.O000OO00 = "Tahoma"
  }
  else {
    %tankschat.O00O0O00 = $iif($version < 5.91,13,12)
    %tankschat.O00O000O = MS Sans Serif
    %tankschat.O000OO00 = "MS Sans Serif"
  }
  if ($1 isnum 0-1) {
    OO0O0O00
    O000O00O
    O0000000
    drawdot @Tanks
  }
}
alias tanksd {
  .timer_tanksd -o 1 0 return
  tanks $calc(+$1)
}
alias -l O0OOO0O0 {
  if (* !iswm $window(@Tanks)) return
  var %tanks.O0000OO0, %tanks.OO000O00 = %tanks.O000OOO0, %tanks.O0OO0O0O = 0, %tanks.OOO0OO0O = 0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      if (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] == 5) %tanks.OOO0OO0O = 1
      inc %tanks.O0OO0O0O
      if ($len(%tanks.O0000OO0) < 800) {
        var %tanks.OO000O0O = $sock(tanks. [ $+ [ %tanks.OO000O00 ] ] ).ip
        %tanks.O0000OO0 =   $iif(%tanks.OO000O0O,%tanks.OO000O0O,%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] ) $replace(%tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] ,%,$right(.%25,3),+,$right(.%2B,3),$chr(35),$right(.%23,3),&,$right(.%26,3)) %tanks.O0000OO0
      }
    }
    dec %tanks.OO000O00
  }
  %tanks.O0000OO0 = %tanks.O00OOOO00 %tanksport %tanks.OOO0OO0O %tanks.O0OO0O0O %tanksplayerlimit %tanks.O00O0OO0 %tanks.O00OO000 %tanks.O000O00O %tanks.OO000000 %tanks.O0000OO0
  OOO0OO0O action=add&game= $+ $replace(%tanks.O0000OO0,$chr(32),$right(.%20,3))
  if ($sock(tanks.0)) .timertanks.O0OOO0O0 -o 1 285 O0OOO0O0
}
alias -l O000O000 {
  if ($isfile($remove($O00O0OO0,")) != $true) || ($1 > 20) {
    if ($dialog(abouttanks)) dialog -c abouttanks
    if ($dialog(tanks)) dialog -c tanks
    if ($2 != hidden) .timer -o 1 0 tanks.init
    .reload -rs " $+ $script $+ "
  }
  else .timertanks -om 1 200 O000O000 $calc(1+$1) $2
}
alias -l O0O0O000 {
  if (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] isnum 0-4) {
    %tanks.O0000O00 [ $+ [ %tanks.O0OOOO0O ] ] = $1 - %tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ]
    %tanks.O000OO00 [ $+ [ %tanks.O0OOOO0O ] ] = $2 - %tanks.O0O000O0 [ $+ [ %tanks.O0OOOO0O ] ]
  }
  if (%tanks.O0OO0OOO == 1) var %tanks.O0000OO0 = 7 7 6 6 5 4 2
  elseif (%tanks.O0OO0OOO == 2) var %tanks.O0000OO0 = 12 12 12 11 11 10 10 9 8 7 5 3
  elseif (%tanks.O0OO0OOO == 3) var %tanks.O0000OO0 = 17 17 17 17 16 16 15 15 14 14 13 12 11 10 8 6 4
  elseif (%tanks.O0OO0OOO == 4) var %tanks.O0000OO0 = 22 22 22 22 21 21 21 20 20 20 19 18 18 17 16 15 14 13 11 10 7 4
  else var %tanks.O0000OO0 = 27 27 27 27 27 26 26 26 25 25 25 24 24 23 22 22 21 20 19 18 17 16 14 13 11 8 5
  var %tanks.OO000O0O = 1- $+ %tankswidth, %tanks.O00O00O0 = $numtok(%tanks.O0000OO0,32), %tanks.OO00OO00, %tanks.OO0OOO0O, %tanks.O0OOO0O0, %tanks.O0O0OOOO, %tanks.O0O0OOO0 = %tanks.OO0OO0O0 - 1
  while (%tanks.O00O00O0) {
    %tanks.O0OOO0O0 = $gettok(%tanks.O0000OO0,%tanks.O00O00O0,32)
    %tanks.OO0OOO0O = $1 + %tanks.O00O00O0
    if (%tanks.OO0OOO0O isnum %tanks.OO000O0O) {
      %tanks.OO00OO00 = $line(@tanksO00000OO,%tanks.OO0OOO0O)
      %tanks.O0O0OOOO = $2 + %tanks.O0OOO0O0
      if (%tanks.OO00OO00 < $calc($2 -%tanks.O0OOO0O0)) {
        if (%tanks.O0O0OOOO >= %tanks.O0O0OOO0) %tanks.OO00OO00 = $calc(%tanks.O0O0OOO0 +%tanks.OO00OO00 +%tanks.O0OOO0O0 -$2)
        else %tanks.OO00OO00 = $calc(%tanks.OO00OO00 +1+2*%tanks.O0OOO0O0)
      }
      elseif (%tanks.OO00OO00 <= %tanks.O0O0OOOO) %tanks.OO00OO00 = 1 + %tanks.O0O0OOOO
      if (%tanks.OO00OO00 > %tanks.O0O0OOO0) OO000O00 %tanks.OO0OOO0O %tanks.O0O0OOO0
      else OO000O00 %tanks.OO0OOO0O %tanks.OO00OO00
    }
    %tanks.OO0OOO0O = $1 - %tanks.O00O00O0
    if (%tanks.OO0OOO0O isnum %tanks.OO000O0O) {
      %tanks.OO00OO00 = $line(@tanksO00000OO,%tanks.OO0OOO0O)
      %tanks.O0O0OOOO = $2 + %tanks.O0OOO0O0
      if (%tanks.OO00OO00 < $calc($2 -%tanks.O0OOO0O0)) {
        if (%tanks.O0O0OOOO >= %tanks.O0O0OOO0) %tanks.OO00OO00 = $calc(%tanks.O0O0OOO0 +%tanks.OO00OO00 +%tanks.O0OOO0O0 -$2)
        else %tanks.OO00OO00 = $calc(%tanks.OO00OO00 +1+2*%tanks.O0OOO0O0)
      }
      elseif (%tanks.OO00OO00 <= %tanks.O0O0OOOO) %tanks.OO00OO00 = 1 + %tanks.O0O0OOOO
      if (%tanks.OO00OO00 > %tanks.O0O0OOO0) OO000O00 %tanks.OO0OOO0O %tanks.O0O0OOO0
      else OO000O00 %tanks.OO0OOO0O %tanks.OO00OO00
    }
    dec %tanks.O00O00O0
  }
  if ($1 isnum %tanks.OO000O0O) {
    %tanks.OO00OO00 = $line(@tanksO00000OO,$1)
    %tanks.O0O0OOOO = $2 + %tanks.O0OOO0O0
    if (%tanks.OO00OO00 < $calc($2 -%tanks.O0OOO0O0)) {
      if (%tanks.O0O0OOOO >= %tanks.O0O0OOO0) %tanks.OO00OO00 = $calc(%tanks.O0O0OOO0 +%tanks.OO00OO00 +%tanks.O0OOO0O0 -$2)
      else %tanks.OO00OO00 = $calc(%tanks.OO00OO00 +1+2*%tanks.O0OOO0O0)
    }
    elseif (%tanks.OO00OO00 <= %tanks.O0O0OOOO) %tanks.OO00OO00 = 1 + %tanks.O0O0OOOO
    if (%tanks.OO00OO00 > %tanks.O0O0OOO0) OO000O00 $1 %tanks.O0O0OOO0
    else OO000O00 $1 %tanks.OO00OO00
  }
  drawline -rn @Tanks %tanks.1 1 0 %tanks.OO0OO0O0 %tankswidth %tanks.OO0OO0O0
}
on *:dialog:tankschat:dclick:1:dialog -k $dname
ctcp *:tanks:if ($server) && (%tanksnoctcp != 1) && ($calc($ctime -%tanksctime) > 60) ctcpreply $nick Tanks $tanksversion(1)
alias -l O0O00OOO {
  var %tanks.OOO0OO0O = tanks. $+ $1
  if ($sock(%tanks.OOO0OO0O)) && ($1) && (%tanks.O0OO0000 [ $+ [ $1 ] ] isnum) sockwrite -tn %tanks.OOO0OO0O $2-
}
alias -l O0O0O0O0 {
  var %tanks.OO00000O = $getdot(@Tanks color,$1,$2), %tanks.O00000OO = $calc(20+8*%tanks.O0OOOOO0), %tanks.O00O0O00 = $calc(8*%tanks.O0OOOO00 -53)
  if ($3 != 1) if (%tanks.OO00000O == %tanks.15) return
  if ($1 < %tanks.O00000OO) {
    if ($3) drawrect -rf @Tanks color %tanks.OO00000O 1 $calc(1+%tanks.O00000OO) %tanks.O00O0O00 62 62
    return $int($calc(($1 -10)/8)) $+ , $+ $int($calc(($2 -10)/8))
  }
  elseif ($3) drawrect -rf @Tanks color %tanks.15 1 $calc(1+%tanks.O00000OO) %tanks.O00O0O00 62 62
}
on *:sockread:tanksversion:{
  var %tanks.O00O0OOO, %tanks.O0000OO0, %tanks.OOO00O00 = $tanksversion(1)
  if ($sockerr) {
    O00O000O Error $sockerr
    return
  }
  while (1) {
    sockread %tanks.O00O0OOO
    if ($sockbr !isnum 1-) return
    if (tanks * iswm %tanks.O00O0OOO) {
      %tanks.O0000OO0 = $gettok(%tanks.O00O0OOO,2,32)
      %tanks.O00O0OOO = $gettok(%tanks.O00O0OOO,3,32)
      if (%tanks.OOO00O00 != %tanks.O0000OO0) {
        abouttanks
        if (%tanks.O00O0OOO > $version) {
          O00O000O Newest requires mIRC %tanks.O00O0OOO
          return
        }
        O00O000O New: [ $+ %tanks.O0000OO0 $+ ]|New version of Tanks found! Download it by typing $OO00O000(/downloadtanks)
      }
      else O00O000O No new version
    }
  }
}
on ^*:notice:tanks *:*:{
  if ($2 == request) {
    haltdef
    if (%tanksnolisten) return
    var %tanks.OO0O0O0O = O00O0000 $nick wants to play a game of Tanks $+ $chr(44) but, %tanks.O0OO0O0O = OOO0OOO0 0 $nick
    if ($tanksversion(1) < $3) {
      %tanks.OO0O0O0O you have an older version.  Get the newest by typing ' $+ $OO00O000(/downloadtanks) $+ '.
      %tanks.O0OO0O0O old
    }
    elseif ($tanksversion(1) != $3) {
      %tanks.OO0O0O0O they have an older version.
      %tanks.O0OO0O0O new
    }
    elseif ($O0OOO0OO) {
      %tanks.OO0O0O0O Tanks is busy installing the newest version right now.
      %tanks.O0OO0O0O installing
    }
    elseif ($sock(tanks)) || ($sock(tanks.*,0)) %tanks.O0OO0O0O playing %tanksip %tanksport
    else {
      %tankstempip = $4
      %tankstempport = $5
      %tankstempnick = $nick
      OOO0O0OO
      var %tanks.O0000OO0 = Will you join $nick $+ 's game of Tanks?, %tanks.OO0O0O00 = $width(%tanks.O0000OO0,fixedsys,15,0,0) + 16
      OO0OO0OO @Tanks request -1 -1 %tanks.OO0O0O00 47 Fixedsys 15
      drawrect -rfn @Tanks request %tanks.15 1 0 0 %tanks.OO0O0O00 47
      drawtext -rbn @Tanks request %tanks.1 %tanks.15 Fixedsys 15 8 8 %tanks.O0000OO0
      O0O0OOOO
    }
    return
  }
  if ($nick == %tankstempnick) {
    if ($2 == playing) {
      if ($sock(tanks.*,0) > 1) || ($sock(tanks)) O00O0000 $nick is already playing Tanks at $3 $+ : $+ $4 $+ .
      else {
        OO000O0O
        tanks $3-4
      }
    }
    elseif ($2 == decline) O00O0000 $nick declined your Tanks invitation.
    elseif ($2 == installing) O00O0000 $nick is busy installing the new version of Tanks.
    elseif ($2 == ver) || ($2 == old) O00O0000 $nick has an older version of Tanks.
    elseif ($2 == new) O00O0000 $nick has a newer version of Tanks. Download the newest version by typing $OO00O000(/downloadtanks) $+ .
  }
  haltdef
}
alias -l OO000OO0 {
  if (* !iswm $window(@Tanks)) return
  if (%tankschat.O000O0OO == O00000OO) var %tanks.O00O0O00 = %tankschat.O00O00OO, %tanks.O000OOOO = %tankschat.O000OO0O - %tankschat.O00O00OO, %tanks.OO00000O = O0O0OO00 11
  elseif (%tankschat.O000O0OO == O000OO00) var %tanks.O00O0O00 = %tankschat.O000OO0O + 15, %tanks.O000OOOO = $calc(%tankschat.O000O00O -15-%tankschat.O000OO0O), %tanks.OO00000O = O0O0OOO0 11
  elseif (%tankschat.O000O0OO == O00O0000) var %tanks.O00O0O00 = %tankschat.O00000OO, %tanks.O000OOOO = 15, %tanks.OO00000O = O0O0OO00
  elseif (%tankschat.O000O0OO == O0000O00) var %tanks.O00O0O00 = %tankschat.O000O00O, %tanks.O000OOOO = 15, %tanks.OO00000O = O0O0OOO0
  if ($1 != 1) && ($inrect($mouse.x,$mouse.y,%tankschat.O00O0000,%tanks.O00O0O00,15,%tanks.O000OOOO)) {
    %tankschat.O0000O0O = 1
    %tanks.OO00000O
    return
  }
  %tankschat.O0000O0O = 0
  drawrect -fnr @Tanks %tankschat.O000OOOO 1 %tankschat.O00O0000 %tankschat.O00O00OO 15 %tankschat.O00000O0
  drawpic -cn @Tanks %tankschat.O00O0000 %tankschat.O000OO0O 180 115 15 15 %tanksbmp
  drawpic -cn @Tanks %tankschat.O00O0000 %tankschat.O00000OO 150 115 15 15 %tanksbmp
  drawpic -cn @Tanks %tankschat.O00O0000 %tankschat.O000O00O 150 130 15 15 %tanksbmp
  drawdot @Tanks
}
alias -l O0O00O0O {
  if (* !iswm $window(@Tanks)) || (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] !isnum 0-4) return
  var %tanks.OO00OO00, %tanks.OO00000O, %tanks.OO000O00 = %tanks.OO0OO0OO [ $+ [ %tanks.O0OOOO0O ] ] , %tanks.OO0O0O00 = $iif(%tanks.O00OO000,%tanks.O00000O0,0), %tanks.O0O00OO0 = %tanks.O0OOO00O. [ $+ [ %tanks.O0OOOO0O ] ] , %tanks.O00OO0O0, %tanks.O0OO0O00 = %tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ]
  if (%tanks.O0OO0000 [ $+ [ %tanks.O0O00OO0 ] ] !isnum) || (%tanks.OO0O000O [ $+ [ %tanks.O0O00OO0 ] ] < 1) || (%tanks.OO000O00 !isnum) {
    var %tanks.O0000OO0 = %tankslvr
    :0
    var %tanks.OOO0OO00
    tokenize 32 %tanks.O0OO000O
    while ($1) {
      if (%tanks.O0000OO0) && ($iif(%tanks.OO0O0OOO [ $+ [ $1 ] ] < $calc(%tankswidth /2),1,0) == $iif(%tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] < $calc(%tankswidth /2),1,0)) { }
      elseif (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) && ($1 != %tanks.O0OOOO0O) %tanks.OOO0OO00 = %tanks.OOO0OO00 $1
      tokenize 32 $2-
    }
    if ($numtok(%tanks.OOO0OO00,32)) {
      %tanks.O0O00OO0 = $gettok(%tanks.OOO0OO00,$rand(1,$numtok(%tanks.OOO0OO00,32)),32)
      %tanks.O0OOO00O. [ $+ [ %tanks.O0OOOO0O ] ] = %tanks.O0O00OO0
    }
    elseif (%tanks.O0000OO0) {
      %tanks.O0000OO0 = 0
      goto 0
    }
    %tanks.O00OO0O0 = 1
  }
  if (%tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] < %tanks.OO0O0OOO [ $+ [ %tanks.O0O00OO0 ] ] ) var %tanks.OO00OO00 = 1
  %tanks.OO00000O = $iif(%tanksmode & 1 && %tanks.O0OO0O00 < 4 || %tanks.O0OO0O00 == 0,$calc(53 + 9 * %tanks.O0OO0O00 / 3),66)
  %tanks.OO00000O = $iif(%tanks.OO00OO00 != 1,180-) %tanks.OO00000O + %tanks.OO0O0O00 / 99 * $iif($iif(%tanks.OO00OO00,$calc(0-%tanks.OO0O0O00),%tanks.OO0O0O00) > 0,17,14)
  %tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ] = $round($calc(%tanks.OO00000O),0)
  var %tanks.O00000OO = %tanks.OO0O0OOO [ $+ [ %tanks.O0O00OO0 ] ] - %tanks.OO0O0OOO [ $+ [ %tanks.O0OOOO0O ] ] , %tanks.O00O0O00 = %tanks.O0O000O0 [ $+ [ %tanks.O0O00OO0 ] ] - %tanks.O0O000O0 [ $+ [ %tanks.O0OOOO0O ] ]
  var %tanks.O00O00O0 = %tanks.O0000O00 [ $+ [ %tanks.O0OOOO0O ] ] - %tanks.O00000OO, %tanks.O0OOO0O0 = %tanks.O000OO00 [ $+ [ %tanks.O0OOOO0O ] ] - %tanks.O00O0O00
  if (%tanks.OO000O00 !isnum) || (%tanks.O00OO0O0) || ($calc($iif(%tanks.OO00OO00,0-) (%tanks.O00O00O0 + %tanks.O00000OO / 2)) > 0) {
    %tanks.O00O00O0 = 0
    %tanks.O0OOO0O0 = 0 - %tanks.O00O0O00
    %tanks.OO000O00 = $round($calc($iif(%tanksmode & 1 || %tanks.O0OO0O00 == 0,$calc(80 + 5 * %tanks.O0OO0O00),100) * $sqrt($abs($calc(%tanks.O00000OO / %tankswidth)))),0)
    %tanks.O00OO0O0 = 1
  }
  $iif(%tanks.OO00OO00,dec,inc) %tanks.OO000O00 $round($calc(%tanks.O00O00O0 / 8),0)
  inc %tanks.OO000O00 $round($calc(%tanks.O0OOO0O0 / 20),0)
  if (%tanks.O0OO0O00 == 0) inc %tanks.OO000O00 $iif($iif(%tanks.OO00OO00,$calc(0-%tanks.OO0O0O00),%tanks.OO0O0O00) > 0,$calc($rand(0,4) - 2),$calc($rand(0,6) - 3))
  if (%tanks.OO000O00 > 100) %tanks.OO000O00 = 100
  if (%tanks.OO000O00 < 0) %tanks.OO000O00 = 0
  if (%tanks.O00OO0O0 != 1) && (%tanks.O00O00O0 >= -40) && (%tanks.O00O00O0 <= 40) && (%tanks.O0OOO0O0 >= -38) && (%tanks.O0OOO0O0 <= 30) && (%tanks.OO000O00 isnum) {
    if (%tanks.O0OO0O00 == 2) %tanks.O0OO0OOO = $rand(1,3)
    if (%tanks.O0OO0O00 == 3) %tanks.O0OO0OOO = $rand(2,5)
    if (%tanks.O0OO0O00 == 4) %tanks.O0OO0OOO = 5
    if (%tanks.O0OO0OOO < 1) %tanks.O0OO0OOO = 1
    if ($O000000O < %tanks.O0OO0OOO) %tanks.O0OO0OOO = $ifmatch
  }
  tokenize 32 %tanks.O0OO000O
  %tanks.OO0O0O00 = 1
  while (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) {
    if ($1 != %tanks.O0OOOO0O) if ($O000000O($1) > %tanks.OO0O0O00) %tanks.OO0O0O00 = $ifmatch
    tokenize 32 $2-
  }
  var %tanks.OOO00O00 = %tanks.O0OO00O0 [ $+ [ %tanks.O0OOOO0O ] ]
  if (%tanks.O00O0OO0 & 1) %tanks.OOO00O00 = 100
  while (%tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ] <= %tanks.OO0O0O00) || (%tanks.OO000O00 > %tanks.OOO00O00) && (%tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] >= 30) && (%tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ] < 10) {
    O0OOO000 O000OOO0
    inc %tanks.OOO00O00 10
  }
  %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ] = %tanks.OO000O00
  OO0000OO 1
  OOO00O0O
  OO0O00OO
}
alias -l O00O000O {
  if ($dialog(abouttanks)) did -o abouttanks 2 1 $gettok($1-,1,124)
  elseif ($deltok($1-,1,124)) O00O0000 $ifmatch
}
alias -l OO0000O0 {
  if (%tanks.O0OOOOOO !isin O0000O00 O000000O O0000O0O) return
  drawrect -rfn @Tanks %tanks.OOO0000O 1 0 0 %tankswidth %tanks.O00O00OO
  if (%tanks.O00OO000 == 0) return
  var %tanks.O00O0OOO =   $iif(%tanks.O00OO000 == 2,Changing wind:,Wind:) $abs(%tanks.O00000O0)  , %tanks.OOO00O00 = $int($calc(%tankswidth /2)), %tanks.O00000OO = $int($calc(.5+(100+%tanks.O00000O0)/100*%tanks.OOO00O00))
  if (%tanks.O00000O0 < 0) drawtext -rn @Tanks %tanks.OO0O00OO Fixedsys 15 %tanks.OOO00O00 4 %tanks.O00O0OOO
  if (%tanks.O00000O0 > 0) drawtext -rn @Tanks %tanks.OO0O00OO Fixedsys 15 $calc(%tanks.OOO00O00 -$width(%tanks.O00O0OOO,fixedsys,15,0,0)) 4 %tanks.O00O0OOO
  if (%tanks.O00000O0) {
    drawline -rn @Tanks %tanks.OO0O00OO 1 %tanks.OOO00O00 6 %tanks.OOO00O00 17
    drawline -rn @Tanks %tanks.OO0O00OO 1 %tanks.OOO00O00 11 %tanks.O00000OO 11
    drawtext -rn @Tanks %tanks.OO0O00OO Fixedsys 15 $iif(%tanks.O00000O0 < 0,%tanks.O00000OO,$calc(%tanks.O00000OO -7)) 4 $iif(%tanks.O00000O0 < 0,<,>)
  }
}
alias -l OOO000O0 {
  if ($dialog(tanksbots)) {
    did $iif($did(tanksbots,22,0).sel == 1,-e,-b) tanksbots 23
    did $iif($did(tanksbots,22,0).sel,-e,-b) tanksbots 24,25
  }
}
alias -l O0000000 {
  if (* !iswm $window(@Tanks)) return
  var %tanks.OO000O00 = %tanks.O000OOO0, %tanks.OO00O000, %tanks.O00OOO0O, %tanks.OOO0OO0O = $iif($numtok(%tanks.O0OO000O,32) > 8,1,0)
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      if (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) %tanks.OO00O000 = %tanks.OO000O00 %tanks.OO00O000
      else %tanks.O00OOO0O = %tanks.OO000O00 %tanks.O00OOO0O
    }
    dec %tanks.OO000O00
  }
  %tanks.O0OO000O = %tanks.OO00O000 %tanks.O00OOO0O
  if (%tanksautoscroll) && (%tanks.O0000OOO != %tanks.O0OOOO0O %tanks.O0OO000O) {
    %tanks.O0000OOO = %tanks.O0OOOO0O %tanks.O0OO000O
    %tanks.OO000O00 = $findtok(%tanks.O0OO000O,%tanks.O0OOOO0O,1,32)
    while (%tanks.OO000O00 < $calc(%tanks.O0OOO0OO + 3)) {
      dec %tanks.O0OOO0OO %tanks.OOO0O000
    }
    while (%tanks.OO000O00 > $calc(%tanks.O0OOO0OO + 4)) || (%tanks.O0OOO0OO < 0) {
      inc %tanks.O0OOO0OO %tanks.OOO0O000
    }
  }
  var %tanks.O0OO0O0O = $numtok(%tanks.O0OO000O,32)
  while ($calc(9-%tanks.OOO0O000 +%tanks.O0OOO0OO) > %tanks.O0OO0O0O) && (%tanks.O0OOO0OO > 0) {
    dec %tanks.O0OOO0OO %tanks.OOO0O000
  }
  if (%tanks.OOO0OO0O != $iif(%tanks.O0OO0O0O > 8,1,0)) && (%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O) OO00000O
  drawrect -rfn @Tanks %tanks.15 1 0 312 320 57
  if (%tanks.OO00OO0O) O000OO00
  O0OO0OO0
  var %tanks.OO000O0O = 1, %tanks.OOO00O00 = $O000000O, %tanks.O0000000 = %tanks.0, %tanks.OOO0OO0O = %tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ]
  while (1) {
    var %tanks.OO000O00 = $gettok(%tanks.O0OO000O,%tanks.OO000O0O,32)
    if (%tanks.OO000O00) && (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) {
      if (%tanks.OO000O00 != %tanks.O0OOOO0O) && ($O000000O(%tanks.OO000O00) >= %tanks.OOO0OO0O) && (%tanks.OOO0OO0O > 0) {
        if (%tanks.O00O0OO0 !& 1) && (%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O) OO00OOOO %tanks.OO000O00 %tanks.4 !
        %tanks.O0000000 = %tanks.4
      }
      inc %tanks.OO000O0O
    }
    else break
  }
  %tanks.OO000O0O = 1
  while (1) {
    %tanks.OO000O00 = $gettok(%tanks.O0OO000O,$calc(%tanks.O0OOO0OO + %tanks.OO000O0O),32)
    if (%tanks.OO000O0O <= 8) && (%tanks.OO000O00) { }
    else break
    var %tanks.O0OO0O0O = 10, %tanks.OO000OO0 = %tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] , %tanks.O00000OO = $iif(%tanks.OO000O0O & 1,64,222), %tanks.O00O0O00 = $calc(320+13*$int($calc((%tanks.OO000O0O -1)/2))), %tanks.OO00000O = $iif(%tanks.OO000O00 == %tanks.O0OOOO0O,%tanks.O0000000,$iif(%tanks.OO000OO0 > %tanks.OOO00O00,%tanks.0,%tanks.4)), %tanks.O0000OO0 = $iif(%tanks.O00O000O [ $+ [ %tanks.OO000O00 ] ] && %tanks.OO000OO0 > 0 || %tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] isnum,14,0), %tanks.OOO0OO00 = $iif(%tanks.OO000O00 == %tanks.O0OOOO0O && %tanks.OO000OO0 > 0,%tanks.OO0000OO,%tanks.1)
    if (%tanks.OO000O00 == %tanks.O0OOOO0O) && (%tanks.OO000OO0 > 0) drawrect -rfn @Tanks %tanks.OOO0O0O0 1 $calc(10+%tanks.O00000OO) $calc(%tanks.O00O0O00 -6) 85 14
    drawrect -rnf @Tanks %tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] 1 $calc(%tanks.O00000OO -61) $calc(%tanks.O00O0O00 -5) 69 12
    drawpic -cnt @Tanks 16711935 $calc(%tanks.O00000OO -61) $calc(%tanks.O00O0O00 -5) 120 92 69 12 %tanksbmp
    if (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] == 5) {
      drawpic -cnt @Tanks 16711935 $calc(11+%tanks.O00000OO) $calc(%tanks.O00O0O00 -4) 190 92 12 10 %tanksbmp
      drawfill -srn @Tanks $iif(%tanks.OO000O00 == %tanks.O0OOOO0O && %tanks.OO000OO0 > 0,%tanks.15,%tanks.1) 16777215 $calc(11+%tanks.O00000OO) %tanks.O00O0O00 $calc(16+%tanks.O00000OO) %tanks.O00O0O00
    }
    elseif (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] isnum 0-4) {
      drawpic -cnt @Tanks 16711935 $calc(11+%tanks.O00000OO) $calc(%tanks.O00O0O00 -4) 180 104 12 10 %tanksbmp
      drawfill -srn @Tanks $iif(%tanks.OO000O00 == %tanks.O0OOOO0O && %tanks.OO000OO0 > 0,%tanks.15,%tanks.1) 16777215 $calc(11+%tanks.O00000OO) %tanks.O00O0O00 $calc(15+%tanks.O00000OO) %tanks.O00O0O00 $calc(15+%tanks.O00000OO) $calc(3+%tanks.O00O0O00)
    }
    elseif (%tanks.O0000OO0) {
      drawpic -cnt @Tanks 16711935 $calc(12+%tanks.O00000OO) $calc(%tanks.O00O0O00 -4) 192 104 10 10 %tanksbmp
      drawfill -srn @Tanks %tanks.OOO0OO00 16777215 $calc(13+%tanks.O00000OO) %tanks.O00O0O00
    }
    drawtext -crn @Tanks %tanks.OOO0OO00 %tankschat.O000OO00 %tankschat.O00O0O00 $calc(10+%tanks.O0000OO0 + %tanks.O00000OO + %tankstahoma) $calc(%tanks.O00O0O00 -6) $calc(83-%tanks.O0000OO0) 13 %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ]
    if (%tanks.OO000OO0 > 10) || (%tanks.O00O0OO0 & 1) {
      if (%tanks.OO000OO0 < 1) %tanks.OO00000O = %tanks.O0O0O0O0
      elseif (%tanks.O00O0OO0 & 1) %tanks.OO00000O = %tanks.0
      if (%tanks.O000O0O0) {
        dec %tanks.O00000OO 56
        drawline -rn @Tanks %tanks.OO00000O 1 %tanks.O00000OO %tanks.O00O0O00 $calc(59+%tanks.O00000OO) %tanks.O00O0O00
        inc %tanks.O00O0O00
        drawline -rn @Tanks %tanks.OO00000O 1 %tanks.O00000OO %tanks.O00O0O00 $calc(59+%tanks.O00000OO) %tanks.O00O0O00
      }
      else drawrect -rfn @Tanks %tanks.OO00000O 1 $calc(%tanks.O00000OO -56) %tanks.O00O0O00 59 2
    }
    else {
      :615fix
      if (%tanks.O0OO0O0O) {
        drawfill -rn @Tanks $iif(%tanks.OO000OO0 >= %tanks.O0OO0O0O,%tanks.OO00000O,%tanks.O0O0O0O0) 0 %tanks.O00000OO %tanks.O00O0O00
        dec %tanks.O00000OO 6
        dec %tanks.O0OO0O0O
        goto 615fix
      }
    }
    inc %tanks.OO000O0O
  }
  if (%tanks.O0OO0000 [ $+ [ %tanks.O0OOOO0O ] ] !isnum) return
  var %tanks.O0OO0O0O = 10, %tanks.OOO0OO0O = %tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ]
  drawrect -rfn @Tanks %tanks.OO0000O0 1 0 370 320 9
  if (%tanks.OOO0OO0O > 10) || (%tanks.O00O0OO0 & 1) {
    if (%tanks.OOO0OO0O < 1) %tanks.O0000000 = %tanks.OOO000O0
    elseif (%tanks.O00O0OO0 & 1) %tanks.O0000000 = %tanks.0
    drawrect -rfn @Tanks %tanks.O0000000 1 1 372 318 5
    return
  }
  while (%tanks.O0OO0O0O) {
    drawrect -rfn @Tanks $iif(%tanks.OOO0OO0O >= %tanks.O0OO0O0O,%tanks.O0000000,%tanks.OOO000O0) 1 $calc(32*%tanks.O0OO0O0O -31) 372 30 5
    dec %tanks.O0OO0O0O
  }
}
alias -l O00O0OO0 return " $+ $scriptdir $+ tanks.exe"
alias -l O0OOOO00 {
  var %tanks.O0000OO0 = %tanks.O00O0OO0 %tanks.O00OO000 %tanks.OO00O0O0 %tanks.OO000000 %tanks.O000O00O %tanks.O0OO0OOO %tanks.O0OOOO0O %tanks.O00000O0
  if ($1) O0O00OOO $1 O00O0O0O %tanks.O0000OO0
  else O0OO000O O00O0O0O %tanks.O0000OO0
}
alias -l O00OOO0O {
  if ($sock($1)) {
    var %tanks.O0OO0O0O = tanks.rand. $+ $ticks $+ $rand(0,999999)
    sockclose %tanks.O0OO0O0O
    sockrename $1 %tanks.O0OO0O0O
    sockwrite -tn %tanks.O0OO0O0O $2-
    .timer -o 1 30 sockclose %tanks.O0OO0O0O
  }
}
alias downloadtanks {
  if ($show) OOO0OO00
  $O0OOO0OO
  O00O000O Downloading...
  if ($show) window -BhaCdfopk0 +Ldf $OO0OOOOO -1 -1 152 24
  else window -h $OO0OOOOO
  OO0OOOOO
  sockopen downloadtanks pages.cthome.net 80
}
alias -l O0000O00 {
  var %tanks.OO00O00O, %tanks.OO000O00 = $1, %tanks.OO000O0O = $2, %tanks.O0OO0O0O = $3, %tanks.O00000OO = $line(@tanksO0000O00,0)
  while (%tanks.O00000OO) {
    tokenize 32 $line(@tanksO0000O00,%tanks.O00000OO)
    var %tanks.O00OOO0O = $iif($right($1,-1),(banned))
    if (n isin $1) && ($2 iswm %tanks.O0OO0O0O) {
      %tanks.OO00O00O = 1
      if (%tanks.O00OOO0O) && ($3) %tanks.OO00O00O = $iif($3 iswm %tanks.OO000O0O,1)
    }
    elseif (m isin $1) && ($2 iswm %tanks.OO000O0O) && (%tanks.OO000O00) sockmark tanks. $+ %tanks.OO000O00 1
    elseif (n !isin $1) && ($2 iswm %tanks.OO000O0O) %tanks.OO00O00O = 1
    if (%tanks.OO00O00O) && (%tanks.OO000O00) OO0OO000 $iif(%tanks.O00OOO0O || $4,O000000O) %tanks.OO000O00 %tanks.O00OOO0O
    else {
      dec %tanks.O00000OO
      continue
    }
    return return
  }
}
alias -l OO0OOOO0 {
  .timertanks* off
  %tanksremove = %tanksid
  %tanksid = $ticks
  if ($version == 6.02) window -hp @tanksO0000O0O
  else {
    var %tanks.O0000OO0 = $iif(%tanksnoxy || * * !iswm %tanksxy,-1 -1,%tanksxy)
    window -hBdfp +Ld @tanksO0000O0O %tanks.O0000OO0 100 17
    window -h @tanksO0000O0O %tanks.O0000OO0 100 17
  }
  window -hl @tanksO00000O0
  var %tanks.O00000OO, %tanks.O00O0O00, %tanks.OOO00OOO = $scriptdir $+ tanks.bmp
  OOO0O0OO
  if ($pic(%tanks.OOO00OOO).width $pic(%tanks.OOO00OOO).height != 367 148) {
    O00O0000 $iif($isfile(%tanks.OOO00OOO),Incorrect Tanks file:,Tanks file missing:) tanks.bmp
    OOO0OO00
    downloadtanks
    return return
  }
  %tanksbmp = " $+ %tanks.OOO00OOO $+ "
  %tanks.O0OOOOO0 = 30
  %tanks.O0OOOO00 = 10
  if (%tankstitle !isnum) %tankstitle = 15
  window -Bhpf +d @tanksO000000O -1 -1 %tanks.O0OOOOO0 %tanks.O0OOOO00
  window -f @tanksO000000O -1 -1 %tanks.O0OOOOO0 %tanks.O0OOOO00
  drawpic -c @tanksO000000O 0 0 150 104 %tanks.O0OOOOO0 %tanks.O0OOOO00 %tanksbmp
  %tanks.O0O00000 = 5 11 13 10 8 18 3 17 2 16 6
  %tankscolor = $O0OOOOOO(%tankscolor)
  %tanksname = $O0O00000(%tanksname,1)
  if (* !iswm %tanksserver) %tanksserver = %tanksname $+ 's server
  %tanksserver = $O0O00000(%tanksserver,0)
  window -hl @tanksO0000O00
  %tanks.OOO00OOO = $scriptdir $+ tanks.ban
  if ($isfile(%tanks.OOO00OOO)) loadbuf @tanksO0000O00 " $+ %tanks.OOO00OOO $+ "
  if (%tanksskill !isnum 0-4) %tanksskill = 4
  if (%tankscwind !isnum 0-2) %tankscwind = 1
  if (%tanksmode !isnum 0-1) %tanksmode = 0
  %tanks.O0000O0O = %tanksfast
  if (%tanksinc !isin 1 5) %tanksinc = 5
  if (%tankslimit !isnum 1-999) %tankslimit = 10
  if (%tankslimitmode !isnum 0-2) %tankslimitmode = 1
  %tanks.O00OO000 = %tankscwind
  %tanks.O00O0OO0 = %tanksmode
  %tanks.OO00O0O0 = 1
  %tanks.OO000000 = %tankslimit
  %tanks.O000O00O = %tankslimitmode
  %tanks.O0OO0OOO = 1
  %tanks.O0OOOO0O = 1
  %tanks.O00000O0 = 0
  %tanks.O000OOO0 = 32
  %tanks.O0OOO0OO = 0
  %tanks.OOO0O000 = 2
  if (%tanksplayerlimit !isnum 2-32) %tanksplayerlimit = 8
  %tankswidth = 641
  %tanksheight = 460
  %tanks.O00O00OO = 20
  %tanks.OO0OO0O0 = 311
  inc %tanksd
  if (%tanksd > $script(0)) %tanksd = 1
  %tanks.OO00OO0O = 0
  %tanks.O0O0000O = 21
  %tankschat.O00O0OO0 = 321
  %tankschat.O00000OO = 312
  %tankschat.O00OO0O0 = $calc(%tankswidth -15-%tankschat.O00O0OO0)
  %tankschat.O00OO00O = $calc(%tanksheight -%tankschat.O00000OO)
  %tankschat.O0000OOO = 11
  %tankschat.O00O0OOO = %tanks.15
  %tankschat.O0000OO0 = %tanks.1
  %tankschat.O0000O00 = %tanks.2
  %tankschat.O000000O = %tanks.8
  %tankschat.O000OOOO = 15000804
  %tankschat.O000O0O0 = 9342606
  %tankschat.O00O0000 = %tankswidth - 15
  %tankschat.O00O00OO = %tankschat.O00000OO + 15
  %tankschat.O00000O0 = %tankschat.O00OO00O - 30
  %tankschat.O000O00O = %tanksheight - 15
  %tankschat.O00O0O0O = 0
  %tankschat.O00OO000 = 0
  OOO0000O
  %tanks.O0O0O00O = $iif(%tanksground isnum,%tanksground,%tanks.14)
  %tanks.OOO0000O = $iif(%tankssky isnum,%tankssky,%tanks.15)
  %tanks.O0O00O00 = 11579568
  %tanks.OO0000OO = 16777215
  %tanks.OOO0O0O0 = 0
  %tanks.OO0O00OO = 7368816
  %tanks.OO0000O0 = %tanks.8
  %tanks.OOO000O0 = %tanks.1
  %tanks.O0O0O0O0 = %tanks.8
  close -@ @Tanks @tanksO00000OO
  var %tanks.OO000O00 = %tanks.O000OOO0
  while (%tanks.OO000O00) {
    O0OO0000 %tanks.OO000O00 $O0OO0000
    dec %tanks.OO000O00
  }
}
alias -l OO00OO0O {
  if (%tanksnosound) return
  !.splay " $+ $scriptdir $+ tanks $+ $1 $+ .wav"
}
alias -l O0OO0O00 {
  if ($1) inc %tanksport
  sockclose tanks.0
  .timertanks.O0OO0O00 -o 1 0 O0OO0O00 $calc(1+$1) $2
  socklisten tanks.0 %tanksport
  .timertanks.O0OO0O00 off
  O0OOO0O0
  if ($1) && ($version < 6.14) {
    OOO0O0O0 O000O000 Please ignore mIRC's error message. Tanks was testing the port and it was unavailable.
    OOO0O0O0 O000O000 Server running on port %tanksport
  }
  if ($2) return
  OOO0O0O0 O000O000 Server port has been changed to %tanksport
  :error
  if ($version >= 6.14) reseterror
}
on *:dialog:tanklist:init,sclick,dclick:*:{
  if ($devent == init) || ($did == 3) {
    %tankslisting = 1
    OOO0OO0O action=list
  }
  elseif ($devent == dclick) && ($did == 1) || ($did == 2) {
    tokenize 32 $did($dname,9,$did($dname,1).sel).text
    if (http://* iswm $1) {
      dialog -i $dname
      run $1
    }
    elseif (/*tanks* iswm $1) {
      dialog -i $dname
      $right($1-,-1)
    }
    halt
  }
  elseif ($did == 1) {
    tokenize 32 $did($dname,9,$did($dname,1,1).sel)
    if (/*tanks* iswm $1) did -o $dname 5 1 $1-
    elseif (http://* iswm $1) did -o $dname 5 1 $1
    else did -r $dname 5
  }
}
on *:sockread:downloadtanks:{
  while (1) {
    if ($sockerr) {
      O00O000O Error $sockerr |Error $sockerr when downloading Tanks
      return
    }
    tokenize 32 $sock($sockname).mark
    if ($2 != 0) break
    var %tanks.O0000OO0
    sockread %tanks.O0000OO0
    if ($sockbr) {
      if (Content-Length: * iswm %tanks.O0000OO0) sockmark $sockname $gettok(%tanks.O0000OO0,2,32) $2
      elseif (* !iswm %tanks.O0000OO0) {
        sockmark $sockname $1 $rand(1,16777215)
        break
      }
    }
  }
  while (1) {
    if (* !iswm $sock($sockname)) return
    sockread 4096 &b
    if ($sockbr !isnum 1-) return
    OO0OOOOO
    bwrite $O00O0OO0 -1 -1 &b
  }
}
alias -l O00OO00O {
  var %tanks.O00O00O0 = $1 - $3, %tanks.O0OOO0O0 = $2 - $4, %tanks.O00000OO = $3, %tanks.O00O0O00 = $4, %tanks.OO00000O = $5, %tanks.OO000O00
  tokenize 32 $gettok(%tanks.O0OO000O, [ [ $calc(1+%tanks.O0OOO0OO) ] $+ ] -,32)
  if (%tanks.O00O0O00 < %tanks.OO0OO0O0) {
    tokenize 32 %tanks.O0OO000O
    var %tanks.O0000OO0 = a
    while (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) {
      if ($calc((%tanks.OO0O0OOO [ $+ [ $1 ] ] -%tanks.O00000OO)^2+(%tanks.O0O000O0 [ $+ [ $1 ] ] -%tanks.O00O0O00)^2) < %tanks.O0000OO0) {
        %tanks.O0000OO0 = $ifmatch
        if (%tanks.O0000OO0 < 1600) %tanks.OO000O00 = $1
      }
      tokenize 32 $2-
    }
  }
  elseif (%tanks.O0OO0000 [ $+ [ $1 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,2,315,158,13)) %tanks.OO000O00 = $1
  elseif (%tanks.O0OO0000 [ $+ [ $2 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $2 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,160,315,158,13)) %tanks.OO000O00 = $2
  elseif (%tanks.O0OO0000 [ $+ [ $3 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $3 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,2,328,158,13)) %tanks.OO000O00 = $3
  elseif (%tanks.O0OO0000 [ $+ [ $4 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $4 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,160,328,158,13)) %tanks.OO000O00 = $4
  elseif (%tanks.O0OO0000 [ $+ [ $5 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $5 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,2,341,158,13)) %tanks.OO000O00 = $5
  elseif (%tanks.O0OO0000 [ $+ [ $6 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $6 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,160,341,158,13)) %tanks.OO000O00 = $6
  elseif (%tanks.O0OO0000 [ $+ [ $7 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $7 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,2,354,158,13)) %tanks.OO000O00 = $7
  elseif (%tanks.O0OO0000 [ $+ [ $8 ] ] isnum) && (%tanks.OO0O000O [ $+ [ $8 ] ] > 0) && ($inrect(%tanks.O00000OO,%tanks.O00O0O00,160,354,158,13)) %tanks.OO000O00 = $8
  if (%tanks.OO000O00) && (%tanks.OO00000O == 0) O00O00O0 %tanks.OO000O00
  if ($window(@Tank info)) || ($dialog(tanksbots).active) || ($dialog(tanksserver).active) || ($dialog(abouttanks).active) || ($dialog(tankschat).active) || ($dialog(tanklist).active) || ($dialog(tanksban).active) || (%tanks.OO000O00 !isnum) && ($version != 6.02) window -h @tanksO0000O0O
  if (%tanks.OO000O00 !isnum) || (%tanks.OO00000O == 0) {
    unset %tanks.O00O0000
    if (%tanks.OO00000O == 0) close -@ @Tanks color
    return
  }
  if ($version == 6.02) || (%tanks.OO000O00 == %tanks.O00O0000) || ($window(@Tank info)) return
  %tanks.O00O0000 = %tanks.OO000O00
  var %tanks.O0OO0O0O = %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] , %tanks.OO0O0O00 = $calc(7+$width(%tanks.O0OO0O0O,%tankschat.O00O000O,%tankschat.O00O0O00,0,0)), %tanks.O000OOOO = $iif(%tanks.O00O0OO0 & 1,17,23), %tanks.O00000OO0 = 3
  if (%tanks.OO0O0O00 < 37) && (%tanks.O000OOOO > 17) var %tanks.O00000OO0 = $int($calc(3 + (37 - %tanks.OO0O0O00) / 2)), %tanks.OO0O0O00 = 37
  var %tanks.O00000OO = $int($calc(%tanks.O00O00O0 + %tanks.OO0O0OOO [ $+ [ %tanks.OO000O00 ] ] - %tanks.OO0O0O00 / 2)), %tanks.O00O0O00 = $calc(%tanks.O0OOO0O0 + %tanks.O0O000O0 [ $+ [ %tanks.OO000O00 ] ] - $iif(%tanks.O000OOOO > 17,41,36))
  if (%tanks.O00000OO < %tanks.O00O00O0) %tanks.O00000OO = %tanks.O00O00O0
  if ($calc(%tanks.O00O00O0 + %tankswidth - %tanks.OO0O0O00) < %tanks.O00000OO) %tanks.O00000OO = $ifmatch
  window @tanksO0000O0O -1 -1 %tanks.OO0O0O00 %tanks.O000OOOO
  drawrect -rf @tanksO0000O0O %tanks.OOO0000O 1 0 0 %tanks.OO0O0O00 %tanks.O000OOOO
  window -o @tanksO0000O0O %tanks.O00000OO %tanks.O00O0O00 %tanks.OO0O0O00 %tanks.O000OOOO
  drawdot @Tanks
  drawrect -rn @tanksO0000O0O %tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] 1 0 0 %tanks.OO0O0O00 %tanks.O000OOOO
  drawtext -rn @tanksO0000O0O 0 %tankschat.O000OO00 %tankschat.O00O0O00 $calc(%tanks.O00000OO0 +%tankstahoma) 2 %tanks.O0OO0O0O
  if (%tanks.O000OOOO > 17) {
    if (%tanks.O00O0000 == %tanks.O0OOOO0O) {
      var %tanks.OO00000O = 1
      tokenize 32 %tanks.O0OO000O
      while (%tanks.OO0O000O [ $+ [ $1 ] ] > 0) {
        if ($1 != %tanks.O0OOOO0O) if ($O000000O($1) > %tanks.OO00000O) %tanks.OO00000O = $ifmatch
        tokenize 32 $2-
      }
    }
    else var %tanks.OO00000O = $O000000O
    %tanks.OO00000O = $iif(%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > %tanks.OO00000O,%tanks.0,255)
    var %tanks.O00000OO = $int($calc(%tanks.OO0O0O00 /2-15))
    if (%tanks.OO0O000O [ $+ [ %tanks.O00O0000 ] ] == 11) {
      drawrect -rnf @tanksO0000O0O %tanks.OO00000O 1 %tanks.O00000OO 16 31 4
      drawrect -rn @tanksO0000O0O %tanks.1 1 %tanks.O00000OO 16 31 4
    }
    else {
      drawrect -rnf @tanksO0000O0O %tanks.O0O0O0O0 1 %tanks.O00000OO 16 31 4
      drawrect -rnf @tanksO0000O0O %tanks.OO00000O 1 %tanks.O00000OO 16 $calc(%tanks.OO0O000O [ $+ [ %tanks.O00O0000 ] ] *3) 4
      drawpic -cnt @tanksO0000O0O 16711935 %tanks.O00000OO 16 120 76 31 4 %tanksbmp
      drawfill -srn @tanksO0000O0O %tanks.1 16777215 %tanks.O00000OO 16
    }
  }
  drawdot @tanksO0000O0O
}
alias -l OOO0O000 {
  tokenize 32 $line(@tanksO00000O0,%tankschat.O000OOO0)
  if ($1 == O000O000) return *** $2-
  if ($1 == O000O0OO) return *** $4-
  if ($istok(O000000O O00000OO O00000O0 O0000O00 O0000000,$1,32)) return $3-
  return *** $3-
}
on *:keydown:@tanks:*:{
  if (%tanks.O0OOOO0O == %tanks.OOO00OO0) O0O0O00O 0
  var %tanks.O0000OO0 = $keyval
  if ($mouse.key & 2) && (%tanks.O0000OO0 isnum 35-36) {
    if (%tanks.O0000OO0 == 35) %tankschat.O00O0O0O = 0
    else %tankschat.O00O0O0O = %tankschat.O00OO000 - 11
    if (%tankschat.O00O0O0O < 0) %tankschat.O00O0O0O = 0
    OO0O0O00
  }
  elseif (%tanks.O0OOOOOO %tanks.O0000OO0 == O00000OO 13) OO0O0OO0
  elseif (%tanks.O0OOOOOO == O0000O0O) O0OOO000 $O00OOO00($replace(%tanks.O0000OO0,38,O000000O,40,O0000OOO,37,O000O00O,39,O000O0O0,45,O000O0OO1,36,O000O0OO5,46,O0000000,35,O0000OO0,49,O000O0OO1,50,O000O0OO2,51,O000O0OO3,52,O000O0OO4,53,O000O0OO5,13,O000OO0O,32,O000OOO0,9,$iif(%tanksinc == 1,O0000O0O,O000OOOO)))
  if ($istok(84 89 77,%tanks.O0000OO0,32)) .timertanks.OO00O0OO -o 1 0 OO00O0OO $iif(%tanks.O0000OO0 == 77,1)
  elseif (%tanks.O0000OO0 == 33) O0O0OO00 $iif($mouse.key !& 2,11)
  elseif (%tanks.O0000OO0 == 34) O0O0OOO0 $iif($mouse.key !& 2,11)
  elseif (%tanks.O0000OO0 == 219) O0OOO000 O000O000
  elseif (%tanks.O0000OO0 == 221) O0OOO000 O00000O0
}
on *:sockopen:tanklist*:{
  if ($sockname !isin tanklist2) return
  if ($sockerr) {
    if (%tanksbackup) {
      unset %tanksbackup
      tanklistmsg Unable to connect.
    }
    else {
      %tanksbackup = 1
      socket tanklist2 tanks.ileet.net
      socket tanklist tanks.mircscripts.org
    }
    return
  }
  if (* !iswm %tanksname) %tanksname = $O0O00000(%tanksname,0)
  sockwrite -n $sockname GET /tanks.php?version= $+ $tanksversion(1) $+ &me= $+ $replace(%tanksname,%,$right(.%25,3),+,$right(.%2B,3),$chr(35),$right(.%23,3),&,$right(.%26,3),$chr(32),$right(.%20,3)) $+ &crc= $+ $crc($script) $+ & $+ %tankslistsend HTTP/1.0
  sockwrite -n $sockname IP: $ip
  sockwrite -n $sockname Tanks-server: %tanksserver
  sockwrite -n $sockname Version: $version
  sockwrite -n $sockname Accept: */*
  sockwrite -n $sockname Host: $sock(tanklist).mark
  sockwrite -n $sockname Connection: close
  sockwrite -n $sockname Cache-Control: no-cache
  sockwrite -n $sockname
  sockmark $sockname wait
  if ($sockname == tanklist) && (%tankslisting) && ($dialog(tanklist)) did -r tanklist 1,9,5
}
alias -l O0O0O00O {
  if ($sock(tanks.*,0)) && (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] !isnum 0-4) {
    var %tanks.OOO0OO0O = tanks. $+ %tanks.O0OOOO0O
    if ($1 == 0) && (* !iswm $sock(%tanks.OOO0OO0O)) || ($1 !isnum) .timertanks.O0O0O00O -o 1 $iif(%tanks.O00O0OO0 & 1,20,40) O0O0O00O %tanks.O0OOOO0O
    elseif ($1 == 0) {
      %tanks.OOO00O0O [ $+ [ %tanks.O0OOOO0O ] ] = 0
      O0O00OOO %tanks.O0OOOO0O O000O000
      .timertanks.O0O0O00O -o 1 $iif($sock(%tanks.OOO0OO0O),30,0) O0O0O00O %tanks.O0OOOO0O 1
    }
    elseif ($1 == %tanks.O0OOOO0O) && (%tanks.O0OOOOOO isin O0000O00 O0000O0O) && (%tanks.O0OO0000 [ $+ [ $1 ] ] isnum) {
      if ($2) {
        OO0OO000 O000000O %tanks.O0OOOO0O (Ping timeout)
        return
      }
      if (* !iswm $sock(%tanks.OOO0OO0O)) {
        var %tanks.OO000O0O = 1, %tanks.OO00000O = 0
        while ($gettok(%tanks.O0OO000O,%tanks.OO000O0O,32)) {
          if (%tanks.O00OO0OO [ $+ [ $gettok(%tanks.O0OO000O,%tanks.OO000O0O,32) ] ] !isnum) inc %tanks.OO00000O
          inc %tanks.OO000O0O
        }
        if (%tanks.OO00000O == 0) return
      }
      elseif (%tanks.OOO00O0O [ $+ [ $1 ] ] != 1) {
        .timertanks.O0O0O00O -o 1 30 O0O0O00O $1 1
        return
      }
      inc %tanks.OO00OOO0 [ $+ [ $1 ] ] 2
      if (%tanks.OO00OOO0 [ $+ [ $1 ] ] > 3) {
        unset %tanks.OO00OOO0 [ $+ [ $1 ] ]
        OO0OO000 O000000O $1 (Idle three times)
        return
      }
      var %tanks.O0000OO0 = $1 $1 Server $iif($sock(%tanks.OOO0OO0O),sent fire request to   ,forced    to fire) ( $+ $iif(%tanks.O00O0OO0 & 1,20,40) seconds idle)
      O0OO000O O000O0OO %tanks.O0000OO0
      OOO0O0O0 O0000OO0 %tanks.O0000OO0
      if ($sock(%tanks.OOO0OO0O)) {
        O0O00OOO $1 O00000O0
        .timertanks.O0O0O00O -o 1 15 O0O0O00O $1 1
      }
      else OO0O00OO
    }
  }
}
on *:sockopen:downloadtanks:{
  if ($sockerr) {
    O00O000O Connection error $sockerr |Connection error ( $+ $sockerr $+ ) when downloading Tanks
    close -@ $OO0OOOOO
    return
  }
  write -c $O00O0OO0
  sockmark $sockname 1 0
  sockwrite -n $sockname GET /pdufilie/irc/tanks.exe HTTP/1.0
  sockwrite -n $sockname Accept: */*
  sockwrite -n $sockname Host: pages.cthome.net
  sockwrite -n $sockname
}
on *:sockclose:tanks.*:if ($gettok($sockname,2,46) isnum) OO0OO000 $ifmatch
dialog tanksbots {
  title "Tanks bots and local players"
  size -1 -1 230 116
  option dbu
  box "Add local players", 1, 6 4 106 28
  edit "", 2, 13 14 59 12
  button "&Join", 3, 75 14 30 12
  box "Bots", 11, 6 40 106 65
  button "Skill 0", 12, 13 50 30 12
  button "Skill 1", 13, 44 50 30 12
  button "Skill 2", 14, 75 50 30 12
  button "Skill 3", 15, 13 65 30 12
  button "Skill 4", 16, 44 65 30 12
  button "R&andom", 17, 75 65 30 12
  check "Bots play on their own", 18, 13 80 66 10
  check "Bots play ''Left vs Right''", 19, 13 91 70 10
  box "Bots and local players", 21, 123 4 101 90
  list 22, 130 14 54 74, size extsel vsbar
  button "&Name...", 23, 187 14 30 12
  button "&Color...", 24, 187 28 30 12
  button "&Remove", 25, 187 42 30 12
  list 20, 187 56 30 32, hide size
  text "", 100, 0 0 0 0, hide
  button "Ok", 99, 194 100 30 12, ok
}
menu @tanksO00000OO {
  mouse:window -h @tanksO00000OO
  sclick:window -h @tanksO00000OO
}
alias -l O000OOO0 {
  var %tanks.O0OO0O00 = %tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ]
  if ($calc(180-%tanks.O0OO0O00) < %tanks.O0OO0O00) %tanks.O0OO0O00 = $ifmatch
  OOOO0000 385 %tanks.O0OO0O00
}
alias -l OO00OOOO if (%tanks.OO0O0OOO [ $+ [ $1 ] ] ) drawtext -brn @Tanks $2 %tanks.OOO0000O fixedsys 20 $calc(%tanks.OO0O0OOO [ $+ [ $1 ] ] -$iif(%tanks.OO0O0OOO [ $+ [ $1 ] ] > $calc(%tankswidth /2),0,1)-(5*$len($3))) %tanks.O00O00OO $iif(%tanks.O0OO0000 [ $+ [ $1 ] ] isnum,$3, )
alias -l O00OO0OO {
  O0OO0OO0
  unset %tanks.O0OOOOOO
  drawdot @Tanks
  var %tanks.OO000O00 = %tanks.O000OOO0, %tanks.O0OO0O0O = 0, %tanks.O000OOOO = 0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      if (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] !isnum 0-4) inc %tanks.O000OOOO
      inc %tanks.O0OO0O0O
    }
    dec %tanks.OO000O00
  }
  if (* !iswm $1) && (%tanks.O0OO0O0O > 1) {
    if (%tanks.O0OOOO0O == %tanks.OOO00OO0) {
      %tanks.O0OOOOOO = O000000O
      O000O0OO O0OO0OOO 3
    }
    elseif (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] isnum 0-4) && (* !iswm $sock(tanks)) {
      %tanks.O0OOOOOO = O0000O00
      .timertanks.O0O00O0O -om 1 $rand(275,400) O0O00O0O
    }
    else %tanks.O0OOOOOO = O0000O00
  }
  if (%tanks.O0OOOO0O == %tanks.OOO00OO0) {
    if (%tanksnopop != 1) && ($window(@Tanks).state == minimized) window -a @Tanks
    OO0OOO00 1
  }
  O0O0O00O 0
  if ($version != 6.02) {
    window -h @tanksO0000O0O
    unset %tanks.O00O0000
  }
  if (* !iswm $sock(tanks)) {
    %tanks.OO000O00 = 1
    while (%tanks.OO000O00 <= %tanks.O000OOO0) {
      var %tanks.OOO0OO0O = tanks. $+ %tanks.OO000O00
      if (* !iswm $sock(%tanks.OOO0OO0O)) && (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] !isnum) OO0OO000 %tanks.OO000O00 (Connection lost)
      inc %tanks.OO000O00
    }
  }
}
alias -l O00000OO {
  if ($sock(tanks.*,0)) O0OO000O O00OOO0O
  if (%tanks.O0OOOOOO != O0000000) unset %tanks.O0OOOOOO
  .timertanks.O0O00O0O off
  .timertanks.OO0O00OO2 off
  OOO00O0O 0
  if (%tanks.OOO00OO0 != 0) OO000OOO
}
on *:close:@tanksO00000OO:OOO0OO00
alias -l OOO00O00 {
  if ($sock(tanks)) return
  var %tanks.OO000O00 = %tanks.O000OOO0, %tanks.OO00000O = 0, %tanks.O000OOOO = 0, %tanks.O0000OO0 = 0, %tanks.OOO0OO0O = 0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      inc %tanks.OO00000O
      if (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) {
        inc %tanks.OOO0OO0O
        if (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] !isnum 0-4) inc %tanks.O000OOOO
        if (%tanks.O00O000O [ $+ [ %tanks.OO000O00 ] ] ) inc %tanks.O0000OO0
      }
    }
    dec %tanks.OO000O00
  }
  if (%tanks.OO00000O > 1) {
    if (%tanks.O000OOOO == 0) && (%tanksstopbots) return 2
    if (%tanks.O0000OO0 == 0) return
    if (%tankslvr) {
      if (%tanks.OOO0OO0O == %tanks.O0000OO0) return 1
    }
    elseif (%tanks.O000OOOO == %tanks.O0000OO0) return 1
  }
}
on *:active:*:{
  if ($target == @Tanks) {
    if ($lactive == @tanksO0000O0O) return
    close -@ @Tanks color @Tank info
    if ($version != 6.02) OO0OO0OO @Tanks
  }
  elseif ($istok($target,@tanksO0000O00.@tanksO00000O0.@tanksO00000OO.@tanksO000000O.@tanksO0000O0O,46)) {
    if ($target == @tanksO0000O0O) unset %tanks.O00O0000
    .timertankshide -o 1 0 window -h $target
  }
  elseif (%tanks.O00O0000) && ($version != 6.02) {
    unset %tanks.O00O0000
    window -h @tanksO0000O0O
  }
}
alias -l OOO00OO0 {
  did $iif($sock(tanks),-b,-e) tanksserver 105,106,9,10,11,12
  did $iif(%tanksmode & 1,-c,-u) tanksserver 4
  did $iif(%tankslimitmode,-c,-u) tanksserver 5
  did $iif($did(tanksserver,5).state,-e,-b) tanksserver 6,7
  did -o tanksserver 6 1  frag limit
  did -o tanksserver 6 2  round limit
  did -c tanksserver 6 $iif(%tankslimitmode == 2,2,1)
  did -o tanksserver 7 1 %tankslimit
  did -o tanksserver 8 1  No wind
  did -o tanksserver 8 2  Constant wind
  did -o tanksserver 8 3  Changing wind
  did -c tanksserver 8 $calc(1+%tankscwind)
  did -o tanksserver 9 1 %tanksplayerlimit
  did $iif(%tanksonecon,-u,-c) tanksserver 12
}
alias -l O000O00O {
  if (* !iswm $window(@Tanks)) return
  var %tanks.O00OOO0O = 1
  if ($1 == -) {
    tokenize 32 $2-
    %tanks.O00OOO0O = 0
  }
  %tanksxy = $window(@Tanks).x $window(@Tanks).y
  drawline -rn @Tanks %tanks.1 1 0 %tanks.OO0OO0O0 %tankswidth %tanks.OO0OO0O0
  drawline -rn @Tanks %tanks.1 1 320 %tanks.OO0OO0O0 320 %tanksheight
  var %tanks.OO000O00 = %tanks.O000OOO0, %tanks.O0OO0O0O = 0, %tanks.O0OO0O00 = 0, %tanks.OO00O00O = 0, %tanks.OO00000O = 0
  while (%tanks.OO000O00) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
      if (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) inc %tanks.O0OO0O00
      if (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] isnum 0-4) inc %tanks.OO00O00O
      elseif (%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] !isnum) inc %tanks.OO00000O
      inc %tanks.O0OO0O0O
    }
    dec %tanks.OO000O00
  }
  if (%tanks.O0OO0O0O < 2) unset %tanks.O0OOOOOO
  elseif (%tanks.O0OO0O00 == 1) || (* !iswm %tanks.O0OOOOOO) && (* !iswm $sock(tanks)) %tanks.O0OOOOOO = O00000OO
  if ($1) { }
  elseif (%tanks.O0OOOOOO !isin O0000O00 O000000O O0000O0O) {
    drawrect -rfn @Tanks %tanks.15 1 0 380 320 80
    if (%tanks.O0OOOOOO == O00000OO) {
      if (%tanks.OO00000O) OO0O0OO0
      elseif (%tanks.OO00O00O == %tanks.O0OO0O0O) && (%tanksstopbots) unset %tanks.O0OOOOOO
      else {
        drawtext -rn @Tanks %tanks.1 Fixedsys 15 56 404 Double-click here or press
        drawtext -rn @Tanks %tanks.1 Fixedsys 15 64 420 enter to start the game.
      }
      if (%tanks.O00OOO0O) drawdot @Tanks
    }
    return
  }
  var %tanks.OO00000O = %tanks.O0OO0000 [ $+ [ %tanks.O0OOOO0O ] ]
  if (%tanks.OO00000O !isnum) return
  drawrect -rfn @Tanks %tanks.OO00000O 1 0 380 320 80
  drawpic -cnt @Tanks 16711935 4 383 0 0 312 74 %tanksbmp
  O000OOO0
  OOOO0000 398 %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ]
  O000OO0O
  O0OOO00O
  drawpic -cnt @Tanks 16711935 81 440 77 $iif(%tanksinc == 1,131,57) 16 17 %tanksbmp
  drawpic -cnt @Tanks 16711935 99 440 95 $iif(%tanksinc == 1,57,131) 16 17 %tanksbmp
  if (%tanks.OOO00OO0 != %tanks.O0OOOO0O) {
    drawrect -rfn @Tanks %tanks.OO00000O 1 0 380 117 80 206 383 110 25 206 433 110 24
    drawpic -cn @Tanks 5 409 202 26 110 23 %tanksbmp
    drawrect -rfn @Tanks 0 1 7 411 106 19
    var %tanks.O0OO0O00 = $calc(+$round($calc(100*%tanks.OO0O0OO0 [ $+ [ %tanks.O0OOOO0O ] ] /%tanks.OO0OOO00 [ $+ [ %tanks.O0OOOO0O ] ] ),0)) $+ %
    drawtext -rn @Tanks 16777215 %tankschat.O000OO00 %tankschat.O00O0O00 $calc(11+%tankstahoma) $calc(414-%tankstahoma) Accuracy:
    drawtext -rn @Tanks 16777215 Fixedsys 15 $calc(108-$width(%tanks.O0OO0O00,fixedsys,15,0,0)) 413 %tanks.O0OO0O00
  }
  OO00000O
}
alias -l O0000OOO {
  if ($1 !isnum 0-1) return
  %tanksnochat = $1
  if ($1) {
    O00OO000 $O00O0O0O
    O0000000
    drawdot @Tanks
    OO0O0000
  }
  else O0OO000O O00O00OO
}
on *:dialog:abouttanks:init,sclick:*:{
  if ($devent == init) {
    did -a abouttanks 1 $tanksversion $+ $crlf $+ by Andy Dufilie
    tankscheck
  }
  if ($did == 3) tankscheck
  if ($did == 4) downloadtanks
  if ($did == 99) run http://pages.cthome.net/pdufilie/
  if ($did == 97) tanksreadme
}
on *:keydown:@tanksO0000O00,@tanksO00000O0,@tanksO00000OO,@tanksO0000O0O,@tanksO000000O:*:{
  if ($target == @tanksO0000O0O) unset %tanks.O00O0000
  window -h $target
}
alias -l O0O00O00 {
  iline @tanksO00000O0 1 $1-
  inc %tankschat.O00OO000
  if (%tankschat.O00O0O0O > 0) {
    inc %tankschat.O000OOO0
    inc %tankschat.O00OO0OO
    inc %tankschat.O00O0O0O
  }
  if (%tankschat.O0000000 > 0) inc %tankschat.O0000000
  if (%tankschat.O000O000) && (%tankschat.O00O0O0O == 0) {
    %tankschat.O00O0O0Odown = 1
    %tankschat.O00O0O0O = 1
    inc %tankschat.O000OOO0
    inc %tankschat.O00OO0OO
  }
}
on *:dialog:tanksban:init,sclick,edit:*:{
  var %tanks.O00O0OOO = $dname, %tanks.O00000OO = $did, %tanks.OOO00OOO, %tanks.OOO0OO0O
  if ($devent == init) {
    var %tanks.OO000O00 = %tanks.O000OOO0
    while (%tanks.OO000O00) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) {
        if ($sock(tanks. [ $+ [ %tanks.OO000O00 ] ] ).ip) {
          did -i %tanks.O00O0OOO 1 1 %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ]
          did -i %tanks.O00O0OOO 2 1 $ifmatch
        }
      }
      dec %tanks.OO000O00
    }
    did -c %tanks.O00O0OOO 3
    did -c %tanks.O00O0OOO 1 1
    %tanks.O00000OO = 1
    var %tanks.OO000O0O = $line(@tanksO0000O00,0)
    while (%tanks.OO000O0O) {
      var %tanks.O0000OO0 = $line(@tanksO0000O00,%tanks.OO000O0O)
      if (? * !iswm %tanks.O0000OO0) did -a %tanks.O00O0OOO 8 %tanks.O0000OO0
      dec %tanks.OO000O0O
    }
  }
  if (%tanks.O00000OO isnum 3-4) && ($did(%tanks.O00O0OOO,1,1).sel) {
    %tanks.O00000OO = 1
    %tanks.OOO00OOO = 1
  }
  if (%tanks.O00000OO isnum 1-2) {
    var %tanks.OO00OO00 = $did(%tanks.O00O0OOO,%tanks.O00000OO,1).sel, %tanks.O0000OO0 = 3 - %tanks.O00000OO
    if (%tanks.OO00OO00 != $did(%tanks.O00O0OOO,%tanks.O0000OO0,1).sel) %tanks.OOO00OOO = 1
  }
  if (%tanks.OOO00OOO) {
    did -c %tanks.O00O0OOO %tanks.O0000OO0 %tanks.OO00OO00
    did -o %tanks.O00O0OOO 5 1 $did(%tanks.O00O0OOO,$iif($did(%tanks.O00O0OOO,3).state,2,1),%tanks.OO00OO00)
    did -o %tanks.O00O0OOO 6 1 $did(%tanks.O00O0OOO,1,%tanks.OO00OO00) @ $did(%tanks.O00O0OOO,2,%tanks.OO00OO00)
  }
  if (%tanks.O00000OO == 9) {
    while ($did(%tanks.O00O0OOO,8,1).sel) {
      did -d %tanks.O00O0OOO 8 $did(%tanks.O00O0OOO,8,1).sel
    }
    %tanks.OOO0OO0O = 1
  }
  if (%tanks.O00000OO == 7) {
    var %tanks.OOO00O00 = $iif($did(%tanks.O00O0OOO,3).state,IP: ,Name: ) $$deltok($replace($did(%tanks.O00O0OOO,5),$chr(32), ),0,160)   ( $+ $did(%tanks.O00O0OOO,6) $+ )
    if ($didwm(%tanks.O00O0OOO,8,%tanks.OOO00O00,1) == 0) did -a %tanks.O00O0OOO 8 %tanks.OOO00O00
    %tanks.OOO0OO0O = 1
  }
  if (%tanks.OOO0OO0O) {
    filter -wwcx @tanksO0000O00 @tanksO0000O00
    %tanks.OOO0OO0O = $did(%tanks.O00O0OOO,8).lines
    while (%tanks.OOO0OO0O) {
      aline @tanksO0000O00 $did(%tanks.O00O0OOO,8,%tanks.OOO0OO0O)
      dec %tanks.OOO0OO0O
    }
    savebuf @tanksO0000O00 " $+ $scriptdir $+ tanks.ban"
    O0O0OO0O
  }
  if (%tanks.O00000OO == 7) halt
}
alias -l O00OOOO0 {
  var %tanks.O00OOO0O = 1
  if ($1 == -) {
    %tanks.O00OOO0O = 0
    tokenize 32 $2-
  }
  else {
    O0OOOO00 $1
    O0O00OOO $1 O0000OO0 %tanks.O00000O0 $2
  }
  var %tanks.OO000O00 = %tanks.O000OOO0, %tanks.OO0O0O00 = 1
  while (%tanks.OO000O00) {
    O0O00OOO $1 O00O000O $calc(+%tanks.O00O000O [ $+ [ %tanks.OO000O00 ] ] ) $iif(%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] isnum,%tanks.O00OO0OO [ $+ [ %tanks.OO000O00 ] ] ,-) %tanks.OO000O00 $O0OO0000(%tanks.OO000O00)
    dec %tanks.OO000O00
  }
  if (%tanks.O00OOO0O) {
    while (%tanks.OO0O0O00 <= %tankswidth) {
      O0O00OOO $1 O000OO0O $line(@tanksO00000OO,%tanks.OO0O0O00) $line(@tanksO00000OO,$calc(1+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(2+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(3+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(4+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(5+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(6+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(7+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(8+%tanks.OO0O0O00)) $line(@tanksO00000OO,$calc(9+%tanks.OO0O0O00))
      inc %tanks.OO0O0O00 10
    }
  }
}
alias -l OO0OOOOO {
  var %tanks.OO0O0O00 = @Downloading Tanks
  if ($isid) return %tanks.OO0O0O00
  if (* !iswm $window(%tanks.OO0O0O00)) {
    sockclose downloadtanks
    return
  }
  tokenize 32 $sock(downloadtanks).mark
  if ($window(%tanks.OO0O0O00).state != hidden) {
    drawrect -frn %tanks.OO0O0O00 0 1 0 0 152 24
    drawrect -rn %tanks.OO0O0O00 $calc(+$2) 1 0 0 152 24
    drawrect -frn %tanks.OO0O0O00 7368816 1 1 1 $calc(+$calc(150*$sock(downloadtanks).rcvd /$1)) 22
    drawtext -rn %tanks.OO0O0O00 12632256 Fixedsys 15 8 4 Downloading Tanks
    drawdot %tanks.OO0O0O00
  }
}
alias -l OOO0OO00 {
  %tanksxy = $window(@Tanks).x $window(@Tanks).y
  close -@ @Tanks
  if ($dialog(tanksban)) dialog -x tanksban
  if ($dialog(tankschat)) dialog -x tankschat
  if ($dialog(tanksbots)) dialog -x tanksbots
  if ($dialog(tanksserver)) dialog -x tanksserver
  .timertanks* off
  OO000O0O 1
  if (%tankslog) {
    write " $+ $scriptdir $+ tanks.log" - Session Close: $fulldate
    write " $+ $scriptdir $+ tanks.log" -
  }
}
on *:connect:%tanksctime = $ctime
on *:close:@tanksO0000O00:OOO0OO00
alias tankscheck {
  $O0OOO0OO
  O00O000O
  if ($sock(tanksversion).name) return
  O00O000O Checking...
  sockopen tanksversion pages.cthome.net 80
}
dialog tanksmsg {
  title "Tanks - Send a private message."
  option dbu
  size -1 -1 141 89
  text "Send to:"4,4 20 25 7
  list 1,27 19 88 66,hsbarvsbarsizextsel
  edit ""2,4 4 104 11, autohs result limit 200
  button "&Send" 3,112 4 25 11, ok
}
alias -l OO0O00OO3 {
  var %tanks.OO0OOO0O = $1, %tanks.O0O0OOOO = $2, %tanks.OO0O0O00 = $3, %tanks.OO00000O = $4, %tanks.OOO0OO0O = $5, %tanks.O0000OO0 = $6, %tanks.O0OOO000 = $7, %tanks.O0O00OOO = $8
  var %tanks.OO000O0O = %tanks.O0OOOO0O $O0OO0000(%tanks.O0OOOO0O)
  if (%tanks.O0OO0OOO > 1) dec %tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] $calc(25*%tanks.O0OO0OOO)
  tokenize 32 $9-
  O000O00O 1
  OO000000
  OO0O0000
  drawdot @Tanks
  inc %tanks.O000O0OO [ $+ [ %tanks.O0OOOO0O ] ]
  if (%tanks.O0000O0O != 1) OO00OO0O $iif(%tanks.O0OOOO0O != %tanks.OOO00OO0,g2,g1)
  var %tanks.O0O00OO0
  if ($0) var %tanks.OO0OOO0O = $1, %tanks.O0O0OOOO = $2, %tanks.O0OOO000 = $3, %tanks.O0O00OOO = $4, %tanks.O00OO0O0 = $5, %tanks.O0OO0OO0 = $6, %tanks.O00OO00O = $7-
  else {
    var %tanks.O0O00OO0, %tanks.O00OO0O0 = %tanks.O0000OO0, %tanks.O0OO0OO0 = 0, %tanks.O00OO00O = \, %tanks.O00O00O0 = 0, %tanks.O0OO0O0O = %tanks.O000OOO0
    while (%tanks.O0OO0O0O) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) {
        if (%tanks.OO0O000O [ $+ [ %tanks.O0OO0O0O ] ] > 0) {
          inc %tanks.O00O00O0
          if ($sqrt($calc((%tanks.OO0O0OOO [ $+ [ %tanks.O0OO0O0O ] ] $iif(%tanks.OO00O0OO [ $+ [ %tanks.O0OO0O0O ] ] > $iif(%tanks.OO0O0OOO [ $+ [ %tanks.O0OO0O0O ] ] > $calc(%tankswidth /2),89,90),+,-) .5-%tanks.O0OOO000)^2*(.9875+.0025*%tanks.O0OO0OOO)+(1.2228-.0286*%tanks.O0OO0OOO)*(%tanks.O0O000O0 [ $+ [ %tanks.O0OO0O0O ] ] -4-%tanks.O0O00OOO)^2)) <= $calc(9.9375+5.0625*%tanks.O0OO0OOO)) %tanks.O00OO00O = %tanks.O0OO0O0O %tanks.O00OO00O
        }
      }
      dec %tanks.O0OO0O0O
    }
    if (%tanks.O00OO000 > 1) {
      %tanks.OO0OOOO0 = $calc($rand(0,40)-20+%tanks.O00000O0)
      if (-99 > %tanks.OO0OOOO0) %tanks.OO0OOOO0 = $ifmatch
      elseif (99 < %tanks.OO0OOOO0) %tanks.OO0OOOO0 = $ifmatch
      O0OO000O O00OO000 %tanks.OO0OOOO0
    }
    %tanks.O0OO0O0O = $numtok(%tanks.O00OO00O,32)
    while (%tanks.O0OO0O0O) {
      if ($gettok(%tanks.O00OO00O,%tanks.O0OO0O0O,32) != %tanks.O0OOOO0O) inc %tanks.O0OO0OO0 $calc(($iif(%tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] < 150,3,1)+%tanks.O00O00O0)*%tanks.O0OO0OOO)
      dec %tanks.O0OO0O0O
    }
    var %tanks.OOO00O00 = %tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ]
    var %tanks.OO0OO00O = 1, %tanks.OOO0O00O = 1
    %tanks.O0OO0O0O = %tanks.O000OOO0
    while (%tanks.O0OO0O0O) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) {
        if (%tanks.OO0O000O [ $+ [ %tanks.O0OO0O0O ] ] < %tanks.OOO00O00) %tanks.OO0OO00O = 0
        elseif (%tanks.OO0O000O [ $+ [ %tanks.O0OO0O0O ] ] > %tanks.OOO00O00) %tanks.OOO0O00O = 0
      }
      dec %tanks.O0OO0O0O
    }
    if (%tanks.OOO0O00O) inc %tanks.O0OO0OO0 $calc(6+%tanks.O00O00O0)
    elseif (%tanks.OO0OO00O) inc %tanks.O0OO0OO0 $calc(11+%tanks.O00O00O0)
    else inc %tanks.O0OO0OO0 $calc(8+%tanks.O00O00O0)
    if (%tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] >= 150) dec %tanks.O0OO0OO0 6
    O0OO000O O00000O0 %tanks.O0OO0OOO %tanks.OO00O0OO [ $+ [ %tanks.O0OOOO0O ] ] %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ] %tanks.OO0OOO0O %tanks.O0O0OOOO %tanks.O0OOO000 %tanks.O0O00OOO %tanks.O00OO0O0 %tanks.O0OO0OO0 %tanks.O00OO00O %tanks.OO000O0O
  }
  inc %tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] %tanks.O0OO0OO0
  dec %tanks.OO0OOO0O
  var %tanks.O00000OO = %tanks.OO0OOO0O - 1, %tanks.O00O0O00 = %tanks.O0O0OOOO - 1
  if (%tanks.O0000O0O != 1) {
    %tanks.O0O00OO0 = $ticks
    while (1) {
      drawrect -rfn @Tanks %tanks.OOO0000O 1 %tanks.O00000OO %tanks.O00O0O00 3 3
      %tanks.O0000OO0 = $calc(($ticks -%tanks.O0O00OO0)/85)
      if (%tanks.O0000OO0 > %tanks.O00OO0O0) %tanks.O0000OO0 = %tanks.O00OO0O0
      %tanks.O00000OO = $round($calc(%tanks.OO0OOO0O -1+%tanks.O0000OO0 *(%tanks.OO00000O +%tanks.OO0O0O00 *%tanks.O0000OO0)),5)
      %tanks.O00O0O00 = $round($calc(%tanks.O0O0OOOO -1-%tanks.O0000OO0 *(%tanks.OOO0OO0O -4.9*%tanks.O0000OO0)),5)
      if (%tanks.O0000OO0 < %tanks.O00OO0O0) {
        drawpic -cnt @Tanks 16711935 %tanks.O00000OO %tanks.O00O0O00 342 0 3 3 %tanksbmp
        drawdot @Tanks
      }
      else break
    }
  }
  if (%tanks.O0000O0O) OO00O0O0
  %tanks.O0O0O000 = %tanks.OO0OOO0O %tanks.O0O0OOOO %tanks.OO00000O %tanks.OOO0OO0O %tanks.OO0O0O00 $calc(%tankswidth -1) %tanks.O00OO0O0 %tanks.O00000OO %tanks.O00O0O00
  if (%tanks.O0000O0O) OOO0OOOO
  tokenize 32 %tanks.O0OO0OOO %tanks.O0OOO000 %tanks.O0O00OOO
  var %tanks.O00000OO = $calc($2 -3-5*$1), %tanks.O00O0O00 = $calc($3 -2-5*$1)
  tokenize 32 $gettok(347 0 15 15.120 122 25 25.312 10 35 35.312 45 45 45.312 90 55 55,$1,46)
  var %tanks.O000OOOO = $4
  if ($calc(%tanks.O00O0O00 +%tanks.O000OOOO) >= %tanks.OO0OO0O0) %tanks.O000OOOO = $calc(%tanks.OO0OO0O0 -%tanks.O00O0O00)
  drawpic -cnt @Tanks 16711935 %tanks.O00000OO %tanks.O00O0O00 $1-3 %tanks.O000OOOO %tanksbmp
  drawdot @Tanks
  if (\* iswm %tanks.O00OO00O) OO00OO0O h1
  else OO00OO0O h2
  O0O0O000 %tanks.O0OOO000 %tanks.O0O00OOO
  if (%tanks.O0000O0O) OOO0OOOO
  inc %tanks.OO0OOO00 [ $+ [ %tanks.O0OOOO0O ] ] $iif(%tanks.O00O0OO0 & 1,1,%tanks.O0OO0OOO)
  tokenize 32 %tanks.O00OO00O
  var %tanks.O00000OO, %tanks.O00O0O00, %tanks.O0OO0O0O
  while ($1 isnum) {
    if (%tanks.OO0O000O [ $+ [ $1 ] ] == 11) inc %tanks.O0OO00O0 [ $+ [ $1 ] ] 5
    dec %tanks.OO0O000O [ $+ [ $1 ] ] %tanks.O0OO0OOO
    if (%tanks.O00O0OO0 & 1) %tanks.OO0O000O [ $+ [ $1 ] ] = 0
    var %tanks.OO000O00 = $calc(%tanks.O0OO00O0 [ $+ [ $1 ] ] -5*%tanks.O0OO0OOO)
    if (%tanks.OO000O00 < 50) %tanks.OO000O00 = 50
    %tanks.O0OO00O0 [ $+ [ $1 ] ] = %tanks.OO000O00
    $iif($1 == %tanks.O0OOOO0O,dec,inc) %tanks.OO0O0OO0 [ $+ [ %tanks.O0OOOO0O ] ] $iif(%tanks.O00O0OO0 & 1,1,%tanks.O0OO0OOO)
    if (%tanks.OO0O000O [ $+ [ $1 ] ] < 1) {
      $iif($1 == %tanks.O0OOOO0O,dec,inc) %tanks.O00OOO00 [ $+ [ %tanks.O0OOOO0O ] ]
      if (* !iswm $sock(tanks)) {
        if ($1 == %tanks.O0OOOO0O) var %tanks.OOO00O00 = |   tried to put the pin back in|   decided it was all too much|   fell asleep on the controls|   pushed the self-destruct button|   disintegrated|   pushed the wrong button|   saw the light|   crumbled|
        else var %tanks.OOO00O00 = |   pokes     with a stick|   showed     who's boss|   pounded     into the ground|   melted    |   blew     to bits|   recycles    |
        %tanks.OOO00O00 = $gettok(%tanks.OOO00O00,$rand(1,$numtok(%tanks.OOO00O00,124)),124)
        O0OO000O O000O0OO %tanks.O0OOOO0O $1 %tanks.OOO00O00
        OOO0O0O0 - O0000OO0 %tanks.O0OOOO0O $1 %tanks.OOO00O00
        if (%tanks.O000O00O == 1) && (%tanks.O00OOO00 [ $+ [ %tanks.O0OOOO0O ] ] == %tanks.OO000000) && ($1 != %tanks.O0OOOO0O) {
          var %tanks.O0000OO0 = %tanks.O0OOOO0O %tanks.O0OOOO0O    hit the frag limit
          O0OO000O O000O0OO %tanks.O0000OO0
          OOO0O0O0 - O0000OO0 %tanks.O0000OO0
        }
      }
      %tanks.OO000O00 = -20
      while (%tanks.OO000O00 <= 20) {
        %tanks.O0OO0O0O = %tanks.OO0O0OOO [ $+ [ $1 ] ] + %tanks.OO000O00
        if (%tanks.O0OO0O0O > 0) && (%tanks.O0OO0O0O <= %tankswidth) {
          %tanks.O00000OO = %tanks.O0OO0O0O - 1
          %tanks.O00O0O00 = $line(@tanksO00000OO,%tanks.O0OO0O0O)
          drawline -rn @Tanks %tanks.O0O0O00O 1 %tanks.O00000OO %tanks.O00O0O00 %tanks.O00000OO %tanks.OO0OO0O0
          if ($rand(0,1)) drawline -rn @Tanks %tanks.O0OO0000 [ $+ [ $1 ] ] 1 %tanks.O00000OO $calc(%tanks.O00O0O00 -$rand(1,2)) %tanks.O00000OO %tanks.O00O0O00
        }
        inc %tanks.OO000O00
      }
    }
    tokenize 32 $2-
  }
  %tanks.OO0OO0OO [ $+ [ %tanks.O0OOOO0O ] ] = %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ]
  %tanks.O0OO0OOO = 1
  OO0000OO
  O0OOOO0O
}
alias -l O000O0O0 {
  if ($sock(tanks.*,0)) O0OO000O O00O0000 $1-
  %tanks.O00O000O [ $+ [ $1 ] ] = $2
  O0000000
  OOO0O0O0 O000O000 %tanks.O00OOOO0 [ $+ [ $1 ] ] votes $iif($2,to,not to) end the round
  if ($OOO00O00) {
    if ($ifmatch > 1) O00000OO
    else O00O00OO
    return 1
  }
}
alias tanklist {
  if ($dialog(tanklist)) dialog -x tanklist
  dialog $iif(%tanksontop,-dmo,-dm) tanklist tanklist
}
alias -l O00OO0O0 {
  var %tanks.OOO00O00, %tanks.OO00O000 = $iif(%tanksnochat && $sock(tanks),0,1)
  if ($1 == /msg) && ($numtok($2,44)) && (%tanks.OO00O000) {
    if (* !iswm $3) return
    %tanks.OOO00O00 = 1
    var %tanks.O00000OO = $numtok($2,44), %tanks.OOO0OO00, %tanks.OO000O00
    while (%tanks.O00000OO) {
      %tanks.OO000O00 = $gettok($2,%tanks.O00000OO,44)
      if (* iswm %tanks.OOO0OO00) %tanks.OOO0OO00 = %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ] $+ ,  $+ %tanks.OOO0OO00
      else %tanks.OOO0OO00 = %tanks.O00OOOO0 [ $+ [ %tanks.OO000O00 ] ]
      dec %tanks.O00000OO
    }
    %tanks.O000OO0O = $2
    %tanks.OO0O0000 = %tanks.OOO0OO00
    tokenize 32 $3-
  }
  if (/ooh* iswm $1) {
    var %tanks.O0OO0OO0, %tanks.OO00OO00 = $rand(6,16), %tanks.O0000OO0 = $2-
    while ($len(%tanks.O0OO0OO0) < %tanks.OO00OO00) {
      %tanks.O0OO0OO0 = %tanks.O0OO0OO0 $+ $mid(oO,$rand(1,2),1)
    }
    tokenize 32 %tanks.O0OO0OO0 $+ $right($1,-4) %tanks.O0000OO0
  }
  if ($1 == /xyzzy) OOO0O0O0 O000O000 Something happened!
  elseif ($1 == /log) {
    if (/log on == $1-) {
      %tankslog = 1
      OOO0O0O0 O000O000 Logging is ON
    }
    elseif (/log off == $1-) {
      %tankslog = 0
      OOO0O0O0 O000O000 Logging is OFF
    }
    else OOO0O0O0 O000O000 Logging is $iif(%tankslog,ON,OFF)
  }
  elseif ($1 == /chat) {
    if ($sock(tanks)) {
      if (/chat on == $1-) {
        O0000OOO 0
        OOO0O0O0 O000O000 Chat is ON
      }
      elseif (/chat off == $1-) {
        O0000OOO 1
        OOO0O0O0 O000O000 Chat is OFF
      }
      else OOO0O0O0 O000O000 Chat is $iif(%tanksnochat,OFF,ON)
    }
    else OOO0O0O0 O000O000 The /chat [on|off] command is only available for clients connected to a server
  }
  elseif ($1 == /color) {
    if ($2 == 0) var %tanks.O0OO0O0O = $gettok($remtok(%tanks.O0O00000,%tanks.O0O0OO0O [ $+ [ %tanks.OOO00OO0 ] ] ,1,32),$rand(1,$calc($numtok(%tanks.O0O00000,32)-1)),32)
    else var %tanks.O0OO0O0O = $gettok(%tanks.O0O00000,$2,32)
    if (%tanks.O0OO0O0O) {
      %tankscolor = %tanks.O0OO0O0O
      if ($sock(tanks)) O0OO000O O0000O00 %tanks.O0OO0O0O
      else OO0OO00O %tanks.OOO00OO0 %tanks.O0OO0O0O
    }
    else O0000OO0
  }
  elseif ($istok(/sname /snick,$1,32)) {
    if ($sock(tanks)) %tanksserver = $2-
    else {
      var %tanks.O0000OO0 = %tanks.OOO00OO0
      %tanks.OOO00OO0 = 0
      OO0O0OOO $2-
      %tanks.OOO00OO0 = %tanks.O0000OO0
    }
  }
  elseif ($istok(/name /nick,$1,32)) && (%tanks.OO00O000) OO0O0OOO $2-
  elseif ($1 == /clear) {
    window -c @tanksO00000O0
    window -hl @tanksO00000O0
    %tankschat.O00O0O0O = 0
    %tankschat.O00OO000 = 0
    .timertanks.OOO0O0O0 -o 1 0 return
    OO0O0O00
  }
  elseif ($1 == /vote) {
    if (* !iswm $sock(tanks)) {
      if (%tanks.OOO00OO0 isnum 1-) {
        O000O0O0 %tanks.OOO00OO0 $iif(%tanks.O00O000O [ $+ [ %tanks.OOO00OO0 ] ] ,0,1)
        if (%tanks.O00O000O [ $+ [ %tanks.OOO00OO0 ] ] ) OOO0O0O0 O000O000 Type /end to end the round without voting
      }
      else OOO0O0O0 O000O000 Type /end to end the round
    }
    if ($sock(tanks)) && (%tanks.OO0O000O [ $+ [ %tanks.OOO00OO0 ] ] > 0) && ($numtok(%tanks.O0OO000O,32) > 1) O0OO000O O00O0000
    elseif ($sock(tanks)) OOO0O0O0 O000O000 You can't vote
  }
  elseif ($1 == /port) {
    if ($2 !isnum) || ($sock(tanks.*,0) == 0) OOO0O0O0 O000O000 Server port is %tanksport
    else {
      if ($2 !isnum 1-65534) {
        window -n @Tanks
        tokenize 32 /port $?="Enter new server port:"
        if (* !iswm $window(@Tanks)) return
        window -a @Tanks
        if ($2 !isnum 1-65534) return
      }
      %tankssavedport = $2
      if (%tanksport == $2) return
      %tanksport = $2
      O0OO000O O00000OO %tanksport
      O0OO0O00
    }
  }
  elseif ($1 == /end) && (* !iswm $sock(tanks)) {
    if (%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O) O00O00OO
  }
  elseif ($1 == /bot) || ($1 == /skill) && (* !iswm $sock(tanks)) {
    if ($OOO00000($2)) OOO0O0O0 O000O000 The game is full
  }
  elseif ($1 == /nobots) || ($1 == /nobot) && (* !iswm $sock(tanks)) {
    var %tanks.O0OO0O0O = 1
    while (%tanks.O0OO0O0O <= %tanks.O000OOO0) {
      if (%tanks.O00OO0OO [ $+ [ %tanks.O0OO0O0O ] ] isnum 0-4) OO0OO000 %tanks.O0OO0O0O
      inc %tanks.O0OO0O0O
    }
  }
  elseif ($1 == /join) && (* !iswm $sock(tanks)) {
    if ($OO0OO0O0($iif($0 > 1,$2-,%tanksname))) OOO0O0O0 O000O000 The game is full
  }
  elseif ($istok(/bot /nobots /end /join,$1,32)) OOO0O0O0 O000O000 Only the server can use the $1 command
  elseif ($1 == /ping) O0OO000O O000OO00 $ctime
  elseif ($istok(/list /tanklist /tankslist,$1,32)) tanklist
  elseif ($1 == /quit) {
    if ($sock(tanks)) O0OO000O O000O00O
    elseif (%tanks.OOO00OO0 != 0) OO0OO000 %tanks.OOO00OO0
    else OOO0O0O0 O000O000 Use /exit to close Tanks
  }
  elseif ($1 == /exit) OOO0OO00
  elseif ($istok(/help /about /readme,$1,32)) tanksreadme
  elseif (%tanks.OOO00O00) && ($0) {
    var %tanks.O0OO0O0O, %tanks.OOO0OO0O = %tanks.O000OOO0
    while (%tanks.OOO0OO0O >= 0) {
      if ($istok(%tanks.O000OO0O,%tanks.OOO0OO0O,44)) && (%tanks.O0OO0000 [ $+ [ %tanks.OOO0OO0O ] ] isnum) {
        %tanks.O0OO0O0O = 1
        if (* !iswm $sock(tanks)) O0O00OOO %tanks.OOO0OO0O O000OOO0 %tanks.OOO00OO0 $1-
      }
      dec %tanks.OOO0OO0O
    }
    if (%tanks.O0OO0O0O) {
      OOO0O0O0 O0000O00 %tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] %tanks.OO0O0000 $1-
      if ($sock(tanks)) O0OO000O O000OOO0 %tanks.O000OO0O $1-
    }
  }
  elseif ($0) && (%tanks.OOO00O00 != 1) && (%tanks.OO00O000) {
    if ($sock(tanks)) O0OO000O O0000O0O $1-
    else O0OO000O O0000O0O %tanks.OOO00OO0 $1-
    OOO0O0O0 O00000O0 %tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] %tanks.O00OOOO0 [ $+ [ %tanks.OOO00OO0 ] ] $1-
  }
}
alias -l menu_ if (%tanksnomenu) return | return 1
alias -l O0OO0000 {
  if ($isid) {
    if ($1) return %tanks.OO0O0OOO [ $+ [ $1 ] ] %tanks.O0O000O0 [ $+ [ $1 ] ] %tanks.OO00O0OO [ $+ [ $1 ] ] %tanks.OO0OO000 [ $+ [ $1 ] ] %tanks.O0OO00O0 [ $+ [ $1 ] ] %tanks.OO0O000O [ $+ [ $1 ] ] %tanks.O0O00O0O [ $+ [ $1 ] ] %tanks.O00OOO00 [ $+ [ $1 ] ] %tanks.OO0O0OO0 [ $+ [ $1 ] ] %tanks.OO0OOO00 [ $+ [ $1 ] ] %tanks.O000O0OO [ $+ [ $1 ] ]
    return 0 0 0 0 0 0 0 0 0 0 0
  }
  %tanks.OO0O0OOO [ $+ [ $1 ] ] = $2
  %tanks.O0O000O0 [ $+ [ $1 ] ] = $3
  %tanks.OO00O0OO [ $+ [ $1 ] ] = $4
  %tanks.OO0OO000 [ $+ [ $1 ] ] = $5
  %tanks.O0OO00O0 [ $+ [ $1 ] ] = $6
  %tanks.OO0O000O [ $+ [ $1 ] ] = $7
  %tanks.O0O00O0O [ $+ [ $1 ] ] = $8
  %tanks.O00OOO00 [ $+ [ $1 ] ] = $9
  %tanks.OO0O0OO0 [ $+ [ $1 ] ] = $10
  %tanks.OO0OOO00 [ $+ [ $1 ] ] = $11
  %tanks.O000O0OO [ $+ [ $1 ] ] = $12
}
alias -l tanklistmsg {
  sockclose tanklist
  if (* !iswm $dialog(tanklist)) return
  did -rz tanklist 1,9,5
  did -a tanklist 1  
  did -a tanklist 1     $1-
  did -a tanklist 1  
  did -a tanklist 9 rem
  did -a tanklist 9 rem
  did -a tanklist 9 rem
}
alias -l OOO00OOO {
  %tanks.O0OOOOOO = O0000O00
  OOO00O0O 0
  OO00OO0O h1
  unset %tanks.O0OOOOOO
  O00OO0OO
}
menu @Downloading Tanks {
  sclick:O0O000OO $calc($mouse.dx -$window($OO0OOOOO).x) $calc($mouse.dy -$window($OO0OOOOO).y)
  &Cancel:{
    close -@ $OO0OOOOO
    sockclose downloadtanks
  }
}
on *:dialog:tankschat:init:0:{
  if (%tanks.OO0OOOOO) {
    unset %tanks.OO0OOOOO
    var %tanks.O0OO0O0O = %tanks.O000OOO0
    while (%tanks.O0OO0O0O >= 0) {
      var %tanks.OOO0OO0O = tanks. $+ %tanks.O0OO0O0O
      if ($sock(tanks)) || ($sock(%tanks.OOO0OO0O)) && (%tanks.O0OO0O0O != %tanks.OOO00OO0) && (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) && (%tanks.O00OO0OO [ $+ [ %tanks.O0OO0O0O ] ] !isnum 0-4) {
        did -i $dname 1 1 $iif(%tanks.O0OO0O0O == 0,(server)) %tanks.O00OOOO0 [ $+ [ %tanks.O0OO0O0O ] ]
        %tanks.OO0OOOOO = %tanks.O0OO0O0O %tanks.OO0OOOOO
        if ($istok(%tanks.O000OO0O,%tanks.O0OO0O0O,44)) did -ck $dname 1 1
      }
      dec %tanks.O0OO0O0O
    }
    if ($did($dname,1,1).sel !isnum 1-99) did -c $dname 1 1
  }
  did -f $dname 2
}
alias -l OO0O00OO2 {
  var %tanks.O0000OO0 = $6, %tanks.OO00000O = 10
  while (1) {
    inc %tanks.O0000OO0 .0935
    var %tanks.O0OOO000 = $round($calc($1 +%tanks.O0000OO0 *($4 +$3 *%tanks.O0000OO0)),0)
    if (%tanks.O0OOO000 < 1) var %tanks.O00000OO = 1
    elseif (%tanks.O0OOO000 > %tankswidth) var %tanks.O00000OO = %tankswidth
    else var %tanks.O00000OO = %tanks.O0OOO000
    var %tanks.O0O00OOO = $round($calc($2 -%tanks.O0000OO0 *($5 -4.915*%tanks.O0000OO0)),0)
    if (%tanks.O0O00OOO < 0) %tanks.O0O00OOO = 0
    elseif (%tanks.O0O00OOO > %tanks.OO0OO0O0) %tanks.O0O00OOO = %tanks.OO0OO0O0
    if (%tanks.O0O00OOO >= %tanks.O00O00OO) {
      if (%tanks.O0O00OOO >= %tanks.OO0OO0O0) break
      if ($calc(1+%tanks.O0O00OOO) >= $line(@tanksO00000OO,%tanks.O00000OO)) break
      var %tanks.OO000O0O = 1
      :615fix
      var %tanks.OO000O00 = $gettok(%tanks.O0OO000O,%tanks.OO000O0O,32)
      if (%tanks.OO000O00) && (%tanks.OO0O000O [ $+ [ %tanks.OO000O00 ] ] > 0) {
        if ($inrect(%tanks.O00000OO,%tanks.O0O00OOO,$calc(%tanks.OO0O0OOO [ $+ [ %tanks.OO000O00 ] ] -7),$calc(%tanks.O0O000O0 [ $+ [ %tanks.OO000O00 ] ] -9),15,10)) goto 0
        inc %tanks.OO000O0O
        goto 615fix
      }
    }
    dec %tanks.OO00000O
    if (%tanks.OO00000O < 1) {
      .timertanks.OO0O00OO2 -o 1 0 OO0O00OO2 $1-5 %tanks.O0000OO0
      return
    }
  }
  :0
  OO0O00OO3 $1-5 $calc(%tanks.O0000OO0 -.0935) %tanks.O0OOO000 %tanks.O0O00OOO
}
alias -l OO0OO0OO {
  var %tanks.OO00000O = window $iif(%tanksontop,-o,-u) $1
  if ($2-) {
    O000O0OO O0OO0OOO 2 $1 %tanks.OO00000O
    if (%tanks.0 !isnum) $OO0OOOO0
    window -hzBdfkp +ntf $1-
    if (%tankslog) write " $+ $scriptdir $+ tanks.log" - Session Start: $fulldate
    if ($1 == @Tanks) {
      drawrect -rf @Tanks %tanks.1 1 0 0 %tankswidth %tanksheight
      var %tanks.OOO00OOO = Verdana, %tanks.OOO0OO0O = $iif($version > 5.9,50,60), %tanks.O0000OO0 = " $+ %tanks.OOO00OOO $+ " %tanks.OOO0OO0O, %tanks.O00000OO = $int($calc(2+(%tankswidth -$width(Tanks,%tanks.OOO00OOO,%tanks.OOO0OO0O,0,0))/2))
      var %tanks.O000OOOO = $height(Tanks,%tanks.OOO00OOO,%tanks.OOO0OO0O), %tanks.O00O0O00 = $int($calc((%tanks.OO0OO0O0 -%tanks.O000OOOO)/2)), %tanks.OO00000O = %tanks.O00O0O00 + 2
      drawtext -rn @Tanks %tanks.8 %tanks.O0000OO0 %tanks.O00000OO %tanks.OO00000O Tanks | dec %tanks.O00000OO | dec %tanks.OO00000O
      drawtext -rn @Tanks %tanks.14 %tanks.O0000OO0 %tanks.O00000OO %tanks.OO00000O Tanks | dec %tanks.O00000OO | dec %tanks.OO00000O
      drawtext -rn @Tanks %tanks.9 %tanks.O0000OO0 %tanks.O00000OO %tanks.OO00000O Tanks | dec %tanks.O00000OO | dec %tanks.OO00000O
      drawtext -rn @Tanks %tanks.15 %tanks.O0000OO0 %tanks.O00000OO %tanks.OO00000O Tanks | dec %tanks.O00000OO | dec %tanks.OO00000O
      drawtext -rn @Tanks 16777215 %tanks.O0000OO0 %tanks.O00000OO %tanks.OO00000O Tanks | window -hl @tanksO00000OO
      tokenize 122 nnnvqnomnkmmknzunoonqznqomnlomnlplzttnlsnnqzmjnlkkznsnlqkzrvniqnoonszuenvknmmnkomqnzruomnlomnlplziooonqzxongrnppnqlpjnzwinrooqnnhzslmnmonvzmhrnzoknoznpntzqenwzqenoznpntzulmolnmmnkompnoonojn
      %tanks.O00000OO = $int($calc((%tankswidth -85)/2))
      inc %tanks.O00O0O00 %tanks.O000OOOO
      while ($1) {
        var %tanks.OO00000O = 1, %tanks.OOO0OO0O = drawline -rn @Tanks %tanks.14 1
        while (%tanks.OO00000O < $len($1)) {
          inc %tanks.O00000OO $calc($asc($mid($1,%tanks.OO00000O,1)) - 110) | inc %tanks.OO00000O
          inc %tanks.O00O0O00 $calc($asc($mid($1,%tanks.OO00000O,1)) - 110) | inc %tanks.OO00000O
          %tanks.OOO0OO0O = %tanks.OOO0OO0O %tanks.O00000OO %tanks.O00O0O00
        }
        %tanks.OOO0OO0O
        tokenize 32 $2-
      }
      drawpic @Tanks
      var %tanks.O00000OO = %tankswidth
      while (%tanks.O00000OO) {
        aline @tanksO00000OO 0
        dec %tanks.O00000OO
      }
    }
  }
  else %tanks.OO00000O
}
alias -l OO00OOO0 OO0OO0OO @Tanks $iif(%tanksnoxy || * * !iswm %tanksxy,-1 -1,%tanksxy) %tankswidth %tanksheight Fixedsys 15
alias -l O000OO00 {
  if ($window(@Tanks)) {
    drawrect -rfn @Tanks %tanks.OOO0000O 1 0 %tanks.O00O00OO %tankswidth 16
    if ($timer(tanks.OO00O0O0)) OOO0OOOO
  }
}
on *:close:@tanksO0000O0O:OOO0OO00
alias tanks {
  if (* !iswm $window(@Tanks)) OO000O0O
  else {
    window -a @Tanks
    if (* !iswm $1) return
  }
  $O0OOO0OO
  tokenize 32 $replace($1-,:,$chr(32))
  if (. isin $1) || ($1 isnum) && ($1 !ischan) && ($2 isnum 1-) {
    if ($1 isnum) tokenize 32 $longip($1) $2
    %tanksip = $1
    %tanksport = $2
    OO000O0O
    sockopen tanks %tanksip %tanksport
    O00O0000 Tanks: Connecting to %tanksip $+ : $+ %tanksport . . .
    return
  }
  if ($sock(tanks.*,0)) && ($1 isnum 1-65534) O00OO0O0 /port $1
  var %tanks.O00OOO0O = $1, %tanks.OO000O00 = 1
  if ($1 == $me) tokenize 32 $2-
  elseif ($1 !isnum) && (. !isin $1) && ($1) {
    if (* !iswm $server) || (* !iswm $ip) {
      O00O0000 Tanks: You are not connected to IRC.
      return
    }
    %tankstempnick = $1
    OOO0OOO0 request $tanksversion(1) %tanksip %tanksport
    O00O0000 Tanks invitation sent to $1 $+ .
    %tanks.OO000O00 = 0
    tokenize 32 $2-
  }
  if ($sock(tanks.*,0)) || ($sock(tanks)) return
  OO000O0O
  $OO0OOOO0
  tankscheck
  %tanks.OOO00OO0 = 0
  %tanks.O00OOOO00 = %tanksserver
  O00OOOOO 0 %tankscolor
  if (* !iswm $timer(_tanksd)) {
    %tanks.OOO00OO0 = 1
    O00OOOOO 1 %tankscolor
    %tanks.O00OO0OO1 = 5
    %tanks.O00OOOO01 = $O0O00000(%tanksname,1)
    O0OO0000 1 $O0OO0000
  }
  if (* !iswm %tanks.O00OOO0O) {
    OOO00000 %tanksskill
    %tankspublic = 0
  }
  else %tankspublic = %tanks.OO000O00
  OO00OOO0
  OOO00O0O
  sockclose tanks.0
  %tanksip = $ip
  if (%tankssavedport !isnum 1-65534) %tankssavedport = $rand(3000,60000)
  if ($1 isnum 1-65534) %tankssavedport = $1
  %tanksport = %tankssavedport
  O0OO0O00 0 1
  OO0O0000
}
on *:load:tanks.init
on *:appactive:{
  if ($version != 6.02) && (%tanks.O00O0000) {
    unset %tanks.O00O0000
    window -h @tanksO0000O0O
  }
}
alias -l O0O000O0 {
  if ($1 == -) tokenize 32 $iif($2,0,1) $3-
  if ($version < 5.9) return $iif($1,[×] ,[  ] ) $2-
  return $style($1) $2-
}
dialog tanklist {
  title "Tanks servers"
  option dbu
  size -1 -1 316 222
  list 1, 3 3 310 201, sizehsbarvsbar
  button "&Go" 2, 196 207 37 12, ok
  button "&Refresh" 3, 236 207 37 12
  button "&Close" 4, 276 207 37 12, cancel
  edit "" 5, 3 207 189 12, read
  list 9, 0 0 0 0, disablehide
}
alias -l OO00O000 return  $+ $colour(h) $+ $1- $+ 
alias -l OO000000 {
  var %tanks.OO000O00 = %tanks.O000OOO0, %tanks.O0OO0OO0
  while (%tanks.OO000O00) {
    %tanks.O0OO0OO0 = %tanks.O0OO0OO0 $OO00OO00(%tanks.OO000O00,1)
    dec %tanks.OO000O00
  }
  tokenize 32 %tanks.O0OO0OO0
  while ($1) {
    OO00OO00 $1
    tokenize 32 $2-
  }
}
on *:close:@Tanks:OOO0OO00
alias -l OO000O00 {
  var %tanks.O00000OO = $1 - 1
  drawline -rn @Tanks %tanks.OOO0000O 1 %tanks.O00000OO %tanks.O00O00OO %tanks.O00000OO $2
  drawline -rn @Tanks %tanks.O0O0O00O 1 %tanks.O00000OO $2 %tanks.O00000OO %tanks.OO0OO0O0
  rline @tanksO00000OO $1 $2
}
alias -l O0O0OOO0 {
  if (%tankschat.O000O000) return
  var %tanks.O00000OO = %tankschat.O00O0O0O
  dec %tankschat.O00O0O0O $1
  if (%tankschat.O00O0O0O < 0) %tankschat.O00O0O0O = 0
  if (%tanks.O00000OO != %tankschat.O00O0O0O) OO0O0O00
}
on *:sockopen:tanks:{
  if ($sockerr) {
    O0OOOOO0 $ifmatch $sockname connection
    return
  }
  $OO0OOOO0
  O0OO000O O00OO0O0 $tanksversion(1) %tankscolor %tanksname
  %tanks.O0OOOOOO = O00000O0
}
menu @Tanks color {
  mouse:if ($window(@Tanks color)) O0O0O0O0 $mouse.x $mouse.y 1
  leave:O0O0O0O0 0 0 1
  sclick:{
    var %tanks.OO00000O = $O0O0O0O0($click(@Tanks color,$click(@Tanks color,0)).x,$click(@Tanks color,$click(@Tanks color,0)).y)
    if (%tanks.OO00000O) {
      close -@ @Tanks color @1
      if (%tanks.OOO0OOO0 != 1) %tankscolor = %tanks.OO00000O
      if ($sock(tanks)) O0OO000O O0000O00 %tanks.OO00000O
      elseif (%tanks.OOO0OOO0) {
        unset %tanks.OOO0OOO0
        if ($dialog(tanksbots)) {
          var %tanks.OO000O0O = 1
          :0
          if ($did(tanksbots,22,%tanks.OO000O0O).sel) {
            OO0OO00O $did(tanksbots,20,$did(tanksbots,22,%tanks.OO000O0O).sel) %tanks.OO00000O
            inc %tanks.OO000O0O
            goto 0
          }
        }
      }
      else OO0OO00O %tanks.OOO00OO0 %tanks.OO00000O
    }
  }
}
alias -l O0O0O0OO {
  if (* !iswm $2) || (%tanks.O00OOOO0 [ $+ [ $1 ] ] === $2) return
  if ($dialog(tanksbots)) {
    var %tanks.OO000O0O = $did(tanksbots,20).lines
    while (%tanks.OO000O0O) {
      if ($did(tanksbots,20,%tanks.OO000O0O) == $1) did $iif($did(tanksbots,22,%tanks.OO000O0O).state,-ock,-o) tanksbots 22 %tanks.OO000O0O $2
      dec %tanks.OO000O0O
    }
  }
  var %tanks.OO000O00 = %tanks.O00OOOO0 [ $+ [ $1 ] ]
  if ($1 == 0) %tanks.OO000O00 = (server)  $+ %tanks.OO000O00
  %tanks.O00OOOO0 [ $+ [ $1 ] ] = $2
  if ($1 < 2) && (%tanks.OOO00OO0 == 0) OO0O0000
  O0OOO0O0
  O0000000
  OO0O0000
  OOO0O0O0 O000O00O %tanks.O0OO0000 [ $+ [ $1 ] ] %tanks.OO000O00 $2
  if ($sock(tanks.*,0)) {
    O0OO000O O00O0O00 $1 $2
    O0O0OO0O
  }
}
alias tanksreadme {
  var %tanks.OOO00OOO = $scriptdir $+ tanks.txt
  if ($isfile(%tanks.OOO00OOO)) run " $+ %tanks.OOO00OOO $+ "
  else run http://pages.cthome.net/pdufilie/irc/tanks.txt
}
alias -l OO0O000O {
  if (%tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] >= 30) && (%tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ] < 10) && (%tanks.O00O0OO0 !& 1) {
    dec %tanks.O0O00O0O [ $+ [ %tanks.O0OOOO0O ] ] 30
    inc %tanks.OO0O000O [ $+ [ %tanks.O0OOOO0O ] ]
    var %tanks.O0000OO0 = $calc(%tanks.O0OO00O0 [ $+ [ %tanks.O0OOOO0O ] ] +10)
    if (100 < %tanks.O0000OO0) %tanks.O0000OO0 = $ifmatch
    %tanks.O0OO00O0 [ $+ [ %tanks.O0OOOO0O ] ] = %tanks.O0000OO0
    if ($O000000O < %tanks.O0OO0OOO) %tanks.O0OO0OOO = $ifmatch
    O000O00O
    O0000000
    drawdot @Tanks
  }
}
on *:socklisten:tanks.0:{
  var %tanks.O00000OO = 1, %tanks.OOO0OO0O, %tanks.O0000OO0
  if ($sockerr) {
    O0OOOOO0 $ifmatch tanks.0 socket listening
    return
  }
  while (1) {
    %tanks.OOO0OO0O = tanks. $+ %tanks.O00000OO
    if ($sock(%tanks.OOO0OO0O)) || (%tanks.O0OO0000 [ $+ [ %tanks.O00000OO ] ] isnum) inc %tanks.O00000OO
    else break
  }
  sockaccept %tanks.OOO0OO0O
  var %tanks.OO000O0O = $sock(%tanks.OOO0OO0O).ip, %tanks.OO00000O = tanksconnect $+ %tanks.OO000O0O
  if (%tanks.O00000OO > %tanksplayerlimit) %tanks.O0000OO0 = O00OOO00
  elseif (%tanksonecon != 1) && ($timer(%tanks.OO00000O)) && (%tanks.OO000O0O) %tanks.O0000OO0 = O0000000
  else .timer $+ %tanks.OO00000O -o 1 10 return
  if ($O0000O00(0,%tanks.OO000O0O)) %tanks.O0000OO0 = O000O0O0
  else {
    var %tanks.OO000O00 = %tanks.O000OOO0
    while (%tanks.OO000O00) && (%tanksonecon) {
      if (%tanks.O0OO0000 [ $+ [ %tanks.OO000O00 ] ] isnum) && (%tanks.OO000O0O == $sock(tanks. [ $+ [ %tanks.OO000O00 ] ] ).ip) {
        %tanks.O0000OO0 = O0000OOO
        break
      }
      dec %tanks.OO000O00
    }
  }
  if (%tanks.O0000OO0) O00OOO0O %tanks.OOO0OO0O ver $tanksversion(1) %tanks.O0000OO0
  else .timertanks.O0OO0OOO $+ %tanks.O00000OO -o 1 15 O0OO0OOO 1 %tanks.O00000OO %tanks.OOO0OO0O %tanks.OO000O0O
}
alias -l O0OOO0OO if ($sock(downloadtanks).name) || ($timer(installtanks)) return return
alias -l O000OOOO {
  var %tanks.OOO0OO0O, %tanks.O0OO0O0O = %tanks.O000OOO0
  while (%tanks.O0OO0O0O) {
    %tanks.OOO0OO0O = tanks. $+ %tanks.O0OO0O0O
    if ($sock(%tanks.OOO0OO0O)) && (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) && ($1 != %tanks.O0OO0O0O) sockwrite -tn %tanks.OOO0OO0O $2-
    dec %tanks.O0OO0O0O
  }
}
alias -l O00O00OO {
  if ($sock(tanks)) && ($1 != 1) return
  if ($sock(tanks.*,0)) O0OO000O O00OO00O 1
  var %tanks.O0OO0O0O = %tanks.O000OOO0, %tanks.O00O0OOO
  while (%tanks.O0OO0O0O) {
    if (%tanks.O000O00O == 1) && (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) && (%tanks.O00OOO00 [ $+ [ %tanks.O0OO0O0O ] ] >= %tanks.OO000000) %tanks.O00O0OOO = 1
    elseif %tanks.O000O00O == 2) && (%tanks.OO00O0O0 >= %tanks.OO000000) %tanks.O00O0OOO = 1
    dec %tanks.O0OO0O0O
  }
  if (%tanks.O00O0OOO) O00000OO
  else {
    inc %tanks.OO00O0O0
    O0O0000O
  }
}
alias -l O0O00OO0 {
  var %tanks.OO00O00O
  if ($1 == 0) {
    %tanks.OO00O00O = $2
    tokenize 32 $3-
  }
  %tanks.O000OO0O = $remtok(%tanks.O000OO0O,$1,1,44)
  var %tanks.OO00000O = $O0OOOOOO($2), %tanks.O0OO0O0O = $3
  if (* !iswm %tanks.O0OO0O0O) return
  if ($dialog(tanksbots)) && (%tanks.OO00O00O isnum) {
    var %tanks.OO000O0O = 1
    while ($did(tanksbots,20,%tanks.OO000O0O) < $1) {
      inc %tanks.OO000O0O
    }
    did -i tanksbots 20 %tanks.OO000O0O $1
    did -i tanksbots 22 %tanks.OO000O0O %tanks.O0OO0O0O
  }
  $O0000O00($1,$sock(tanks. [ $+ [ $1 ] ] ).ip,%tanks.O0OO0O0O)
  O00OOOOO $1 %tanks.OO00000O
  if (%tanksnochat) && ($sock(tanks)) && ($1 != %tanks.OOO00OO0) %tanks.O0OO0O0O = Player $+ $1
  %tanks.O00OOOO0 [ $+ [ $1 ] ] = %tanks.O0OO0O0O
  O0OO0000 $1 $O0OO0000
  unset %tanks.OO00OOO0 [ $+ [ $1 ] ]
  if (* !iswm $timer(tanks.O0O0O00O)) && (%tanks.O00OO0OO [ $+ [ %tanks.O0OOOO0O ] ] == 5) O0O0O00O 0
  %tanks.O00OO0OO [ $+ [ $1 ] ] = %tanks.OO00O00O
  if (* !iswm $sock(tanks)) {
    O0O00OOO $1 O000OOOO %tanks.O0O0OO0O0 %tanks.O00OOOO00
    O00OOOO0 $iif(%tanks.O0OOOOOO !isin O0000O00 O000000O O0000O0O,-) $1 1
    O0OOOO00 $1
    O0O00OOO $1 O00O00OO $1 $O00O0O0O
    if (%tanks.OO00O00O isnum) %tanks.OO00O00O = 0 %tanks.OO00O00O
    O0OO000O O00OO0O0 %tanks.OO00O00O $1 %tanks.OO00000O %tanks.O0OO0O0O
  }
  if ($1 == %tanks.OOO00OO0) && (%tankslog) && ($sock(tanks)) write " $+ $scriptdir $+ tanks.log" - Connect: %tanksip $+ : $+ %tanksport
  if ($1 == %tanks.OOO00OO0) && ($line(@tanksO00000OO,1)) && ($sock(tanks)) {
    %tanks.O0OOOOOO = O0000O00
    OOO00O0O
  }
  else {
    O000O00O
    O0000000
    if ($1 == %tanks.OOO00OO0) OO0O0O00
  }
  OOO0O0O0 O0000O0O %tanks.O0OO0000 [ $+ [ $1 ] ] %tanks.O0OO0O0O $sock(tanks. [ $+ [ $1 ] ] ).ip
  O0OOO0O0
  O0O0OO0O
}
dialog tanksban {
  title "Tanks ban list"
  option dbu
  size -1 -1 319 127
  box "Add a ban", 11, 4 2 133 121
  text "Select a user to copy info to ban mask field", 12, 10 11 105 8
  list 1, 10 20 68 56, size
  list 2, 81 20 50 56, size
  radio "Ban by IP address", 3, 74 79 56 10
  radio "Ban by name", 4, 13 79 53 10
  text "Ban mask:", 13, 10 94 26 8
  edit "", 5, 38 92 61 12
  text "Comment:", 14, 10 108 26 8
  edit "", 6, 38 106 93 12
  button "Add ban", 7, 102 92 29 12, default ok
  box "Ban list", 15, 144 2 171 104
  list 8, 150 12 159 74, sort size extsel hsbar vsbar
  button "&Remove selected", 9, 255 89 54 12
  text "Wildcards may be used where necessary.", 16, 154 113 114 8, center
  button "Close", 10, 285 110 30 13, cancel
}
on *:unload:{
  OOO0OO00
  unset %tanks*
}
alias -l O00OO000 {
  while ($0) {
    O00OOOOO $1 $O0OOOOOO($2)
    if (%tanksnochat) && ($sock(tanks)) && ($1 != %tanks.OOO00OO0) {
      if ($1 == 0) %tanks.O00OOOO00 = Server
      else %tanks.O00OOOO0 [ $+ [ $1 ] ] = Player $+ $1
    }
    else %tanks.O00OOOO0 [ $+ [ $1 ] ] = $3
    tokenize 32 $4-
  }
}
alias -l O0OO0OOO {
  if ($1 == 1) {
    if (%tanks.O0OO0000 [ $+ [ $2 ] ] !isnum) && ($sock($3).ip == $4) sockclose $3
  }
  elseif ($1 == 2) {
    if ($window($2)) $3-
  }
  elseif ($1 == 3) {
    if ($window(@Tanks)) && (%tanks.O0OOOOOO == O000000O) %tanks.O0OOOOOO = O0000O0O
  }
  elseif ($1 == 4) {
    OO00O0O0
    if ($window(@Tanks)) drawdot @Tanks
  }
}
dialog tanksserver {
  title "Tanks server settings"
  size -1 -1 183 146
  option dbu
  button "&Ok" 1,75 130 32 12, default ok
  button "&Cancel" 2,110 130 32 12, cancel
  button "&Apply" 3,145 130 32 12
  box "Game settings" 101,6 4 171 65, group
  check "Instagib mode (One hit kills, no starting credits)" 4,14 15 124 11
  check "Reset scores when a" 5,14 33 61 11
  combo 6,76 33 40 50, drop
  text "of" 102,119 35 6 8
  edit "" 7,126 33 16 11, center
  text "is reached" 103,145 35 26 8
  text "Wind mode:" 104,14 53 30 8
  combo 8,46 51 55 50, drop
  box "Connections" 105,6 77 171 47, group
  text "Limit the number of players to:" 106,14 91 76 8
  edit "" 9,91 89 16 12, center
  button "-" 10,110 89 14 12
  button "+" 11,126 89 14 12
  check "Allow multiple connections from the same IP address" 12,14 107 135 10
}
alias -l O0OOOOOO {
  if ($istok(%tanks.O0O00000,$1,32)) return $1
  if (, isin $1) {
    var %tanks.O00OOO0O = $1, %tanks.O0000OO0 = 1
    tokenize 44 $rgb($getdot(@tanksO000000O, [ $1 ] ))
    if ($1 > 222) && ($2 < 32) && ($3 > 222) %tanks.O0000OO0 = 0
    if ($gettok(%tanks.O00OOO0O,1,44) isnum 0- [ $+ [ $calc(%tanks.O0OOOOO0 -1) ] ] ) if ($gettok(%tanks.O00OOO0O,2,44) isnum 0- [ $+ [ $calc(%tanks.O0OOOO00 -1) ] ] ) if (%tanks.O0000OO0) return %tanks.O00OOO0O
  }
  return $gettok(%tanks.O0O00000,$rand(1,$numtok(%tanks.O0O00000,32)),32)
}
alias -l O0OOO000 {
  if ($timer(tanks.OO0O00OO2)) return
  var %tanks.O0OO0O00, %tanks.O0000OO0 = %tanks.O0OOOO0O, %tanks.OO000O0O = %tanksinc
  if ($istok(O000000O O0000OOO O000O00O O000O0O0 O0000OO0 O0000000 O000OOO0 O000O0OO1 O000O0OO2 O000O0OO3 O000O0OO4 O000O0OO5,$1,32)) O0OO000O O00O0OO0 $1 $iif($2 isnum,$2,%tanks.OO000O0O)
  if ($1 == O000OOOO) {
    %tanksinc = 1
    O000O00O
  }
  if ($1 == O0000O0O) {
    %tanksinc = 5
    O000O00O
  }
  if ($1 == 0) tokenize 32 $2-
  if ($2 isnum) %tanks.OO000O0O = $2
  if ($1 == O000000O) || ($1 == O0000OOO) {
    %tanks.O0OO0O00 = %tanks.OO0OO000 [ $+ [ %tanks.O0000OO0 ] ] $replace($1,O000000O,+,O0000OOO,-) %tanks.OO000O0O
    if (%tanks.O0OO0O00 < 0) %tanks.O0OO0O00 = 0
    if ($iif(%tanks.O00O0OO0 & 1,100,%tanks.O0OO00O0 [ $+ [ %tanks.O0000OO0 ] ] ) < %tanks.O0OO0O00) %tanks.O0OO0O00 = $ifmatch
    %tanks.OO0OO000 [ $+ [ %tanks.O0000OO0 ] ] = %tanks.O0OO0O00
    OOOO0000 398 %tanks.OO0OO000 [ $+ [ %tanks.O0OOOO0O ] ]
  }
  elseif ($1 == O000O00O) || ($1 == O000O0O0) {
    %tanks.O0OO0O00 = $replace($1,O000O00O,1,O000O0O0,-1)
    inc %tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] $calc(%tanks.OO000O0O *%tanks.O0OO0O00)
    if ($calc(%tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] -%tanks.OO000O0O *%tanks.O0OO0O00) == $calc(90+90*%tanks.O0OO0O00)) %tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] = $calc(90-90*%tanks.O0OO0O00)
    if (%tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] < 0) %tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] = 0
    if (%tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] > 180) %tanks.OO00O0OO [ $+ [ %tanks.O0000OO0 ] ] = 180
    O000OOO0
    OO00OO00 %tanks.O0000OO0
  }
  elseif (O000O0OO? iswm $1) {
    %tanks.O0OO0OOO = $O000000O
    if (%tanks.O0OO0OOO > $right($1,1)) %tanks.O0OO0OOO = $right($1,1)
    O0OOO00O
  }
  elseif ($1 == O0000OO0) {
    %tanks.OO000O0O = $calc(1+%tanks.O0OO0OOO)
    if (%tanks.OO000O0O > 5) %tanks.OO000O0O = 5
    if ($calc(25*%tanks.OO000O0O) <= %tanks.O0O00O0O [ $+ [ %tanks.O0000OO0 ] ] ) %tanks.O0OO0OOO = %tanks.OO000O0O
    O0OOO00O
  }
  elseif ($1 == O0000000) {
    dec %tanks.O0OO0OOO
    if (%tanks.O0OO0OOO < 1) %tanks.O0OO0OOO = 1
    O0OOO00O
  }
  elseif ($1 == O000OOO0) OO0O000O
  elseif ($1 == O000OO0O) {
    if (%tanks.O0OOOO0O == %tanks.OOO00OO0) && ($timer(tanks.OO0O00OO2)) return
    OO0O00OO
  }
  elseif ($1 == O000O000) && (%tanks.O0OOO0OO > 0) {
    dec %tanks.O0OOO0OO %tanks.OOO0O000
    O0000000
  }
  elseif ($1 == O00000O0) {
    var %tanks.O0000OO0 = %tanks.O000OOO0
    while (%tanks.O0000OO0) && (%tanks.O0OO0000 [ $+ [ %tanks.O0000OO0 ] ] !isnum) {
      dec %tanks.O0000OO0
    }
    if (%tanks.O0000OO0 > $calc(8+%tanks.O0OOO0OO)) inc %tanks.O0OOO0OO %tanks.OOO0O000
    O0000000
  }
  drawdot @Tanks
}
on *:dialog:tanksserver:init,sclick:*:{
  if ($devent == init) OOO00OO0
  elseif ($did == 1) || ($did == 3) O0000O0O
  elseif ($did == 5) did $iif($did(tanksserver,5).state,-e,-b) tanksserver 6,7
  elseif ($did isnum 10-11) {
    %tanksplayerlimit = $did(tanksserver,9)
    if (%tanksplayerlimit !isnum) %tanksplayerlimit = 8
    $iif($did == 10,dec,inc) %tanksplayerlimit
    if (%tanksplayerlimit < 2) %tanksplayerlimit = 2
    elseif (%tanksplayerlimit > 32) %tanksplayerlimit = 32
    did -o tanksserver 9 1 %tanksplayerlimit
  }
}
alias -l OO0O0000 {
  if ($window(@Tanks)) {
    var %tanks.O0000OO0, %tanks.OO000O00 = $iif(%tanks.O0OOOOOO isin O0000O00 O000000O O0000O0O,1)
    if (%tanks.OO000O00) && (%tankstitle & 1) {
      if (%tanks.O000O00O == 2) %tanks.O0000OO0 =  -  Round %tanks.OO00O0O0 of %tanks.OO000000
      else %tanks.O0000OO0 =  -  Round %tanks.OO00O0O0
    }
    if (%tanks.OO000O00) && (%tankstitle & 2) {
      if (%tanks.OOO00OO0 != 0) %tanks.O0000OO0 = %tanks.O0000OO0  -  Frags: %tanks.O00OOO00 [ $+ [ %tanks.OOO00OO0 ] ]
      if (%tanks.O000O00O == 1) %tanks.O0000OO0 = %tanks.O0000OO0  -  Frag limit: %tanks.OO000000
    }
    if ($0) %tanks.O0000OO0 =  -  $1-
    else {
      if (%tankstitle & 4) && (%tanks.OO0OOO00 [ $+ [ %tanks.OOO00OO0 ] ] > 0) && (%tanks.OO000O00) %tanks.O0000OO0 = %tanks.O0000OO0  -  Accuracy: $calc(+$round($calc(100 * %tanks.OO0O0OO0 [ $+ [ %tanks.OOO00OO0 ] ] / %tanks.OO0OOO00 [ $+ [ %tanks.OOO00OO0 ] ] ),0)) $+ %
      var %tanks.OOO0OO0O = $iif(%tanks.O0OO00000 isnum,%tanks.O00OOOO00,%tanks.O00OOOO01)
      if ($sock(tanks)) || ($sock(tanks.*,0)) && (%tankstitle & 8) && (* iswm %tanks.OOO0OO0O) && ((%tanksnochat != 1) || (* !iswm $sock(tanks))) %tanks.O0000OO0 = %tanks.O0000OO0  -  Server: %tanks.OOO0OO0O
    }
    titlebar @Tanks $iif(%tanks.O00O0OO0 & 1,instagib) %tanks.O0000OO0
  }
}
alias -l O0OO000O {
  if ($sock(tanks)) sockwrite -tn tanks $1-
  else {
    var %tanks.OOO0OO0O, %tanks.O0OO0O0O = %tanks.O000OOO0
    while (%tanks.O0OO0O0O) {
      %tanks.OOO0OO0O = tanks. $+ %tanks.O0OO0O0O
      if ($sock(%tanks.OOO0OO0O)) && (%tanks.O0OO0000 [ $+ [ %tanks.O0OO0O0O ] ] isnum) sockwrite -tn %tanks.OOO0OO0O $1-
      dec %tanks.O0OO0O0O
    }
  }
}
alias -l O0O00000 {
  var %tanks.O0OO0O0O = $deltok($replace($remove($strip($1),$chr(1)),$chr(32), ),0,160), %tanks.O00000OO = 1
  while (%tanks.O00000OO <= $len(%tanks.O0OO0O0O)) {
    if ($asc($mid(%tanks.O0OO0O0O,%tanks.O00000OO,1)) < 33) {
      %tanks.O0OO0O0O = $left(%tanks.O0OO0O0O,$calc(%tanks.O00000OO -1))
      break
    }
    inc %tanks.O00000OO
  }
  if (* !iswm %tanks.O0OO0O0O) {
    if (%tanks.O00OOOO0 [ $+ [ $2 ] ] != $null) %tanks.O0OO0O0O = $ifmatch
    elseif ($me) %tanks.O0OO0O0O = $me
    else %tanks.O0OO0O0O = Tank $+ $right($ticks,5)
  }
  if ($left(%tanks.O0OO0O0O,-1) === Skill ) && ($right(%tanks.O0OO0O0O,1) isnum 0-4) && (%tanks.O00OO0OO [ $+ [ $2 ] ] != $right(%tanks.O0OO0O0O,1)) %tanks.O0OO0O0O = %tanks.O0OO0O0O $+ $rand(0,9)
  %tanks.O00000OO = %tanks.O000OOO0
  while (%tanks.O00000OO) {
    if (%tanks.O0OO0000 [ $+ [ %tanks.O00000OO ] ] isnum) && (%tanks.O0OO0O0O === %tanks.O00OOOO0 [ $+ [ %tanks.O00000OO ] ] ) && (%tanks.O00000OO != $2) {
      %tanks.O0OO0O0O = %tanks.O0OO0O0O $+ $rand(0,9)
      %tanks.O00000OO = %tanks.O000OOO0
      continue
    }
    dec %tanks.O00000OO
  }
  return %tanks.O0OO0O0O
}
alias -l O0000O0O {
  %tanksmode = $did(tanksserver,4).state
  %tanks.O00O0OO0 = %tanksmode
  %tankslimitmode = $did(tanksserver,5).state * $did(tanksserver,6,1).sel
  %tanks.O000O00O = %tankslimitmode
  if ($int($did(tanksserver,7)) isnum 1-999) %tankslimit = $ifmatch
  else %tankslimit = 10
  %tanks.OO000000 = %tankslimit
  %tankscwind = $did(tanksserver,8,1).sel - 1
  %tanks.O00OO000 = %tankscwind
  if ($int($did(tanksserver,9)) isnum 2-32) %tanksplayerlimit = $ifmatch
  else %tanksplayerlimit = 8
  %tanksonecon = 1 - $did(tanksserver,12).state
  OOO00OO0
  if ($window(@Tanks)) {
    OO0O0000
    OO0000OO
    OO0000O0
    O000OO0O
    O0000000
    O000O00O
    drawdot @Tanks
  }
  O0OOOO00
  O0OOO0O0
}
alias -l OO00O0OO {
  if ($dialog(tankschat)) {
    dialog -ev tankschat
    return
  }
  if ($1) %tanks.OO0OOOOO = 1
  else unset %tanks.OO0OOOOO
  if (%tanks.O0OO0000 [ $+ [ %tanks.OOO00OO0 ] ] isnum) || ($sock(tanks.*,0)) { }
  else return
  var %tanks.O0000OO0 = $left($dialog(tankschat,$replace(tankschat,chat,$iif($1,msg,chat)),@tanks),200)
  if ($1) && (* iswm %tanks.O000OO0O) O00OO0O0 /msg %tanks.O000OO0O %tanks.O0000OO0
  else O00OO0O0 %tanks.O0000OO0
}
alias -l O0O0OO00 {
  if (%tankschat.O000O000) return
  var %tanks.O00000OO = %tankschat.O00O0O0O
  inc %tankschat.O00O0O0O $1
  if (%tankschat.O00O0O0O >= $calc(%tankschat.O00OO000 -10)) %tankschat.O00O0O0O = %tankschat.O00OO000 - 11
  if (%tankschat.O00O0O0O < 0) %tankschat.O00O0O0O = 0
  if (%tanks.O00000OO != %tankschat.O00O0O0O) OO0O0O00
}
