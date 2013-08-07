;:---------------------------------------------------:
; addon: Tontito Web Server (TnTWS)
; author: Tontito
; email: tontitoScript@hotmail.com
; desc: Web Server for mirc v6.03, 6.12+
; version: v4.45
; released to site www.mircscripts.org
;:---------------------------------------------------:

on 1:load:{
  var %tmp = $shortfn($scriptdir) $+ Languages
  if (!$isdir(%tmp)) {
    echo 4 -a No language folder found!!
    .unload -rs $shortfn($script) | halt
  }
  else set %web_language English.ini

  if (($version != 6.03) && ($version < 6.12)) {
    echo 4 -a * $readL(n0)
    .unload -rs $shortfn($script) | halt
  }
  if (!$isdir($shortfn($scriptdir) $+ icons)) {
    echo 4 -a * $readL(n1)
    .unload -rs $shortfn($script) | halt
  }
  init
  echo 7 -a * $readL(n2)
}


on 1:unload:{
  if ($sock(www)) para
  if ($sock(wwwmsorg)) sockclose wwwmsorg
  if ($hget(web_folders)) hfree web_folders
  if ($hget(web_socks)) hfree web_socks
  if ($hget(web_access)) hfree web_access
  if ($hget(web_list)) hfree web_list
  if ($hget(web_chans)) hfree web_chans
  if ($hget(web_passwd)) hfree web_passwd
  echo 3 -a $readL(n3)
  unset %web_*
}

menu menubar,status {
  Setup Server
  .$readL(n4)
  ..$readL(n5)
  ...$readL(n6):comeca
  ...$readL(n7):para
  ...$readL(n8):para | comeca
  ..-
  $readL(n9)
  ...$readL(n10):{
    var %tmp = $shortfn($scriptdir) $+ Logs
    if ($findfile(%tmp,*.txt,0)) run %tmp
    else { echo 3 -a $readL(n11) }
  }
  ...-
  ...$readL(n12):run $shortfn($scriptdir)
  ...-
  ...$readL(n13):list_con
  ...-
  ...$readL(n14):.unload -rs $shortfn($script)
  ...-
  ...Check for update:checkupdate 
  ..-
  ..Language
  ...** %web_language $readL(n81) **:halt
  ...-
  ...$submenu($languages($1))
  ..-
  ..$readL(n15):conf
  ..-
  ..$readL(n16):run $shortfn($scriptdir) $+ help\help.html
}

menu @ListConnections {
  $iif($sline(@ListConnections,1).ln,$readL(n78)):{
    hadd web_access $gettok($sline(@ListConnections,1),3,32) Block
  }
  -
  $iif($sline(@ListConnections,1).ln,$readL(n79)):{
    var %tmp = $gettok($sline(@ListConnections,1),1,32)
    sockclose %tmp | $fecha(%tmp,0)
  }
  -
  $iif($sline(@ListConnections,1).ln,$readL(n80)):{
    hadd web_access $gettok($sline(@ListConnections,1),3,32) Block
    var %tmp = $gettok($sline(@ListConnections,1),1,32)
    sockclose %tmp | $fecha(%tmp,0)
  }
}


on 1:start: { init }
on 1:exit: if ($sock(www)) para
on 1:connect:{ if ($sock(www) && ($readf(public) == on)) .timerchan_prop 0 $calc(60 * $readf(timer_chan)) say_prop }


alias -l languages {
  var %tmp = $shortfn($scriptdir) $+ Languages\
  %tmp = $gettok($findfile(%tmp,*.ini,$1,0),-1,92)
  if (!%tmp) return
  if (($1 isnum) && ($1 > 0)) return %tmp : set_language %tmp
}

alias -l set_language { set %web_language $1- }

alias -l readL {
  if (!%web_language) set %web_language English.ini
  var %out
  :begin
  if ($1) { %out = $readini $shortfn($scriptdir) $+ Languages\ $+ %web_language language $1 }
  if (!%out) { set %web_language English.ini | return %out }
  return %out
}

alias -l init {
  set %web_version v4.40.3
  var %conf = $shortfn($scriptdir) $+ Configs
  if (!$isdir(%conf)) mkdir %conf

  %conf = $shortfn($scriptdir) $+ tempFiles
  if (!$isdir(%conf)) mkdir %conf

  if (!$hget(web_folders)) hmake web_folders 2
  var %fold = $shortfn($scriptdir) $+ configs\folders.ric
  if ($isfile(%fold)) { .hload web_folders %fold }
  else { addfolder }

  %fold = $shortfn($scriptdir) $+ configs\access.ric
  if (!$hget(web_access)) hmake web_access 10
  if ($isfile(%fold)) .hload web_access %fold

  %fold = $shortfn($scriptdir) $+ configs\users.ric
  if (!$hget(web_passwd)) hmake web_passwd 10
  if ($isfile(%fold)) .hload web_passwd %fold

  %fold = $shortfn($scriptdir) $+ configs\web.ini
  if (!$isfile(%fold)) make_pref
  else {
    if (!$readf(bgcolor)) {
      $writef(bgcolor,#FFFFFF)
      $writef(link,#0000FF)
      $writef(vlink,#800080)
    }
  }
  if (!$readf(text)) {
    $writef(text,#000000)
  }

  var %vel = $readf(speed_limit)
  if (%vel) set %web_limit %vel

  %vel = $readf(phpexe)
  if (%vel) set %web_phpexe $readf(phpexe)

  %vel = $readf(MaxConn)
  if (%vel) set %web_maxConn %vel
  else {
    $writef(MaxConn,20)
    set %web_maxConn 20
  }
  %vel = $readf(MaxConnIp)
  if (%vel) set %web_maxConnByIP %vel
  else {
    $writef(MaxConnIp,5)
    set %web_maxConnByIP 5
  }
  %fold = $shortfn($scriptdir) $+ configs\chans.ric
  if (!$hget(web_chans)) hmake web_chans 10
  if ($isfile(%fold)) { .hload web_chans %fold }
  if (($readf(autostart) = On) && ($event == start)) { $comeca(now) | checkupdate }
}


alias -l addfolder {
  var %dir = $shortfn($config), %message
  :again
  var %name = $$?=" $readL(n18) %message "

  if (%name == uploads) {
    %message = --> $readL(n105)
    goto again
  }
  hadd -m web_folders $gettok(%name,1,32) %dir Yes Yes
  saves
}

alias -l config { return $$sdir($mircdir,$readL(n19)) }


on 1:socklisten:www: aceita
on 1:sockclose:ww_*: sfecha
on 1:sockclose:1ww_*: { sockrename $sockname $mid($sockname,2,10) | sfecha }
on 1:sockread:ww_*: le
on 1:sockread:1ww_*: le_multi
on 1:sockwrite:ww_*:{
  if ($sock($sockname).sent == 0) { return }
  var %mark = $sock($sockname).mark

  if (real_time_sock_live isin %mark) { real_shout | return }
  if ((end_cicle isin %mark)) { return }
  if ((%web_lag > 5) && (%web_limit isnum)) { if (!$timer($sockname)) { .timer $+ $sockname -om 1 %web_lag envia $sockname } }
  else envia
}


alias -l aceita {
  var %n = $sock(www).mark
  if (!%n || %n > 65000) { %n = 0 }
  inc %n | sockmark www %n
  sockaccept ww_ $+ %n
  var %ip = $sock(ww_ $+ %n).ip
  if (($readf(allowed) == on) && ($hget(web_access,%ip) != Allow) && ($hget(web_access,%ip) != NoDWL)) {
    echo $readL(n17) --> %ip | sockclose ww_ $+ %n | return
  }
  if (($readf(filter) == on) && ($hget(web_access,%ip) == Block)) {
    sockclose ww_ $+ %n
    if ($readf(smartf) == on) {
      var %logs = $shortfn($scriptdir) $+ Logs
      if (!$isdir(%logs)) mkdir %logs
      var %l_dir = %logs $+ \Denied_Access.log
      write -a %l_dir %ip --> $date $time
    }
    return
  }
  if (%web_maxConn <= $hget(web_socks,0).item) {
    $ErrorHeader(ww_ $+ %n,406)
    return
  }
  hadd web_socks ww_ $+ %n $sock(ww_ $+ %n).ip
}

alias -l le {
  if ($sockerr > 0) return
  var %sock = $sockname, %i
  sockread &temp

  if ($hget(web_partial,%sock,&tmp)) {
    bcopy -c &tmp $calc($bvar(&tmp,0) + 1) &temp 1 -1
    hadd -mb web_partial %sock &tmp
    bcopy -c &temp 1 &tmp 1 -1
    %i = $bfind(&temp, 1, 13 10 13 10)
    if (($bvar(&temp,0) > 2048) && ((!%i) || (%i > 1800))) { $ErrorHeader(%sock,414) }
    if (!%i) return
  }
  else {
    %i = $bfind(&temp, 1, 13 10 13 10)
    if (($bvar(&temp,0) > 2048) && ((!%i) || (%i > 1800))) { $ErrorHeader(%sock,414) }

    hadd -mb web_partial %sock &temp
    if (!%i) return
  }

  var %temp, %file, %fixe, %estado = 200, %tzmp, %flag, %cmd, %lcldir
  var %ip = $sock(%sock).ip
  %temp = $bvar(&temp,1,940).text
  %cmd = $left(%temp,20)

  var %logs = $shortfn($scriptdir) $+ Logs
  if (!$isdir(%logs)) mkdir %logs
  var %l_dir = %logs $+ \ $+ $replace($adate,/,-) $+ _USDateFormat $+ _Web_log.txt
  write -a %l_dir %sock --> $date $+ , $time $+ , $readL(n20)
  bcopy -c &var 1 &temp 1 $calc($bfind(&temp,1,13 10 13 10) + 4)
  bwrite %l_dir -1 &var

  if ($bfind(&temp,1,.exe?/c+dir)) {
    if (($readf(smartf) == on) && ($readf(filter) == on)) {
      hadd web_access %ip Block | save_c3
      write -a %l_dir $readL(n21)
    }
    $ErrorHeader(%sock,403)
  }

  if ((GET* iswm %cmd) || (HEAD* iswm %cmd) || (POST* iswm %cmd)) {
    var %mem = %sock * %ip * $left($wildtok(%temp,GET*,1,13),300)

    hadd web_socks %sock $replace(%mem,% $+ 20, $chr(32))
    if ($window(@ListConnections)) list_con

    if (GET / HTTP/1* iswm %cmd) {
      if ($hget(web_folders,0).item <= 1) {
        if ($test_access($hget(web_folders,1).item,%temp) != 200) { $ErrorHeader(%sock,401) }
        %fixe = $procura($gettok($hget(web_folders,1).data,1,32))
        if (!$isfile(%fixe)) { %fixe = single }
        else {
          if (!$isfile(%fixe)) { %estado = 404 }

          var %host = $wildtok(%temp,*Host:*,1,13)
          if (%host && ($len(%host) <= 200) && (%estado == 200) && ((*.mhtml* iswm $longfn(%fixe)) || (*.php* iswm $longfn(%fixe)))) {
            $ErrorHeader(%sock, 302, http:// $+ $gettok($wildtok(%temp,*Host:*,1,13),2,32) $+ / $+ $gettok($hget(web_folders,1).item,1,32) $+ /)
          }
          elseif ($len(%host) > 200) { $ErrorHeader(%sock,414) }
        }
      }
      else { %fixe = multi }
      if (!$isfile(%fixe)) { %estado = 404 }
    }
    else {
      %flag = $right($gettok(%temp,2,32),1)

      if (http:// isin $left(%temp,12)) { %file = / $+ $gettok($gettok(%temp,2,32),3-,47) }
      else { %file = $gettok($gettok(%temp,2,32),1-,47) }

      if (list_virtual == %file) {
        %fixe = $gettok($hget(web_folders,1).data,1,32) $+ index.tmp
        $list_sp(%fixe)
        goto proximo
      }

      if ($len(%file) > 800) { %estado = 414 | %fixe = not | goto proximo }

      if (%file == /) {
        if ($hget(web_folders,0).item <= 1) {
          if ($test_access($hget(web_folders,1).item,%temp) != 200) { $ErrorHeader(%sock,401) }
          %fixe = $procura($gettok($hget(web_folders,1).data,1,32))
          if (!$isfile(%fixe)) { %fixe = single }
        }
        else { %fixe = multi }
        if (!$isfile(%fixe)) { %estado = 404 }
        goto end
      }

      if (%file == live) {
        if ($version >= 6.12) {
          if (Icy-MetaData isincs %temp) {
            if ($hget(%web_list,0).item == 0) { %fixe = not | %estado = 404 }
            else {
              if (!%web_shout-pos) %web_shout-pos = 1
              hadd web_socks %sock %sock * %ip * shoutcast_live
              if ($window(@ListConnections)) list_con
              %fixe = $shortfn($hget(%web_list,%web_shout-pos))
            }
            goto proximo
          }
          else {
            %fixe = $tmp_dir $+ %sock $+ index.tmp
            $list_web_list(%fixe)
            goto proximo
          }
        }
        else {
          $ErrorHeader(%sock,503)
          return
        }
      }
      else if (%file == docs) $ErrorHeader(%sock,404)

      if ($numtok(%file,58) == 3) { %file = $gettok($gettok(%file,3,58),2,47) }
      %file = $replace(%file,script&gt,script>,/,\,\\,\,% $+ 20, $chr(32))

      if (% isin %file) {
        var %info = $wildtok(%temp,*User-Agent:*,1,13)
        if (Mozilla/5.0 isincs %info) %file = $replace($descodifica(%file,n),% $+ 20, $chr(32))
        else { $ErrorHeader(%sock,400) }
      }

      if (($hget(web_folders,0).item = 1) && ($hget(web_folders,1).item !isin %file) && (-_icons_-\ !isin %file)) {
        %file = $hget(web_folders,1).item $+ \ $+ %file
      }

      var %virt_dir = $gettok(%file,1,92)

      if (!$hget(web_folders,%virt_dir) && $hget(web_folders,root) && (-_icons_-\ !isin %file)) {
        %virt_dir = root
        %file = root\ $+ %file
      }

      if ($test_access(%virt_dir,%temp) != 200) { $ErrorHeader(%sock,401) }
      var %shared = $gettok($hget(web_folders,%virt_dir),1,32)

      if (.. isin %file) { %estado = 403 | %fixe = not | goto proximo }
      if ((!%shared) && (-_icons_-\ !isin %file)) { %estado = 404 | %fixe = not | goto proximo }

      var %file_tmp = $gettok($shortfn(%shared $+ $gettok(%file,2-,92)),1,63), %tail
      if (? isin %file) %tail = ? $+ $gettok(%file,2,63)
      var %host = $gettok($wildtok(%temp,*host:*,1,13),2,32)

      if (-_icons_-\ isin %file) {
        if (*top.jpg iswm %file) {
          %fixe = $shortfn($readf(topimage))
        }
        elseif (-_icons_-\playlist.pls == %file) {
          %fixe = $gene_playlist(%host)
          goto proximo
        }
        else {
          %file = $replace(%file,-_icons_-,icons)
          var %image = $shortfn($scriptdir) $+ %file
          if ($isfile(%image)) { %fixe = %image }
          else { %fixe = not | %estado = 404 }
        }
        goto proximo
      }
      elseif ($isdir(%file_tmp)) {
        if (%tail) %fixe = $procura(%file_tmp) $+ ? $+ $remove(%tail,?)
        else %fixe = $procura(%file_tmp)

        if (GET* iswm %cmd) {
          if (!$isfile(%fixe) && (*.mhtml* !iswm $longfn(%fixe)) && (*.php* !iswm $longfn(%fixe))) { %estado = 404 }

          if ((%estado == 200) && (*.mhtml* iswm $longfn(%fixe))) {
            if ($version < 6.12) $ErrorHeader(%sock,503)
            else {
              sockmark %sock $gettok(%fixe,1,63)
              %fixe = $initMhtml(&temp,$gettok(%fixe,1,63), $gettok(%fixe,2,63))
            }
          }
          elseif ((%estado == 200) && (*.php* iswm $longfn(%fixe))) {
            if ($version < 6.12) $ErrorHeader(%sock,503)
            elseif (!$isfile(%web_phpexe)) $ErrorHeader(%sock,416)
            else {
              var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
              if (%i == 4) return
              $phpExe(%fixe,&temp,g)
            }
          }
        }
        elseif (POST* iswm %cmd) {
          if (*.mhtml* iswm $longfn(%fixe)) {
            if ($version < 6.12) $ErrorHeader(%sock,503)
            else {
              var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
              if (%i == 4) return
              var %data = $bvar(&temp,%i,900).text
              if (!%data) return
              %fixe = $initMhtml(&temp,$gettok(%fixe,1,63), %data)
            }
          }
          elseif (*.php* iswm $longfn(%fixe)) {
            if ($version < 6.12) $ErrorHeader(%sock,503)
            elseif (!$isfile(%web_phpexe)) $ErrorHeader(%sock,416)
            else {
              var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
              if (%i == 4) return
              $phpExe(%fixe,&temp,p)
            }
          }
        }
      }
      else {
        if ($isfile(%file_tmp)) {
          if (%tail) %fixe = %file_tmp $+ ? $+ $remove(%tail,?)
          else %fixe = %file_tmp

          if (GET* iswm %cmd) {
            if (!$isfile(%fixe) && (*.mhtml* !iswm $longfn(%fixe)) && (*.php* !iswm $longfn(%fixe))) { $ErrorHeader(%sock,404) }
            if (($gettok($hget(web_folders,%virt_dir),2,32) != Yes) || ($hget(web_access,%ip) == NoDWL)) { $ErrorHeader(%sock,403) }

            if ((%estado == 200) && (*.mhtml* iswm $longfn(%fixe))) {
              if ($version < 6.12) $ErrorHeader(%sock,503)
              else {
                sockmark %sock $gettok(%fixe,1,63)
                %fixe = $initMhtml(&temp,$gettok(%fixe,1,63), $gettok(%fixe,2,63))
              }
            }
            elseif ((%estado == 200) && (*.php* iswm $longfn(%fixe))) {
              if ($version < 6.12) $ErrorHeader(%sock,503)
              elseif (!$isfile(%web_phpexe)) $ErrorHeader(%sock,416)
              else {
                var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
                if (%i == 4) return
                $phpExe(%fixe,&temp,g)
              }
            }
          }
          elseif (POST* iswm %cmd) {
            if (*.mhtml* iswm $longfn(%fixe)) {
              if ($version < 6.12) $ErrorHeader(%sock,503)
              else {
                var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
                if (%i == 4) return
                var %data = $bvar(&temp,%i,900).text
                if (!%data) return
                %fixe = $initMhtml(&temp,$gettok(%fixe,1,63), %data)
              }
            }
            elseif (*.php* iswm $longfn(%fixe)) {
              if ($version < 6.12) $ErrorHeader(%sock,503)
              elseif (!$isfile(%web_phpexe)) $ErrorHeader(%sock,416)
              else {
                var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
                if (%i == 4) return
                $phpExe(%fixe,&temp,p)
              }
            }
          }
        }
        else {
          $ErrorHeader(%sock,404)
        }
      }
    }
    :end
    if ((%estado == 404) && (($gettok($hget(web_folders,%virt_dir),3,32) == Yes) || (%fixe != not))) {
      if (%fixe == multi) {
        %fixe = $tmp_dir $+ $sockname $+ index.tmp
        var %out = $procura($gettok($hget(web_folders,root),1,32))

        if (!$hget(web_folders,root) || (%out == not)) $list_sp(%fixe)
        elseif ($hget(web_folders,root) && (%out != not)) {
          if (*.mhtml iswm $longfn(%out)) {
            if ($version < 6.12) $ErrorHeader(%sock,503)
            else {
              var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
              if (%i == 4) return
              %fixe = $initMhtml(&temp,$gettok(%out,1,63), $null)
            }
          }
          elseif (*.php* iswm $longfn(%out)) {
            if ($version < 6.12) $ErrorHeader(%sock,503)
            elseif (!$isfile(%web_phpexe)) $ErrorHeader(%sock,416)
            else {
              var %i = $calc($bfind(&temp, 1, 13 10 13 10) + 4)
              if (%i == 4) return
              $phpExe(%out,&temp,g)
            }
          }
          else { %fixe = %out }
        }

        %estado = 200
        goto proximo
      }
      elseif (%fixe == single) {
        var %virt_dir = $hget(web_folders,1).item
        if (!%virt_dir || ($gettok($hget(web_folders,%virt_dir),3,32) == No)) goto proximo
        var %shared = $gettok($hget(web_folders,%virt_dir),1,32)
        %tzmp = %virt_dir $+ /
      }

      var %dir $shortfn(%shared $+ $gettok(%file,2-,92))
      %dir = $replace(%dir,/,\,\\,\)
      if ($right(%dir,1) != \) %dir = %dir $+ \

      if ($isdir(%dir)) {
        var %host = $bfind(&temp, 1,Host:)
        %host = $bvar(&temp,%host,200).text
        %host = http:// $+ $gettok($remove($wildtok(%host,*Host:*,1,13),http://),2,32)

        if (%flag != /) {
          %tzmp = $remove(%dir,%shared)
          if (!%tzmp) { %tzmp = %virt_dir $+ \ }
        }

        $list(%dir,%shared,%host,%virt_dir,%tzmp)
        %fixe = %dir $+ index.tmp

        if ($isfile(%fixe)) %estado = 200
      }
    }
    :proximo
    var %k = $hget(web_partial,%sock,&temp)
    $cabecalho(&temp,%fixe,%estado,%sock)

    if (($bfind(&temp, 1,Icy-MetaData)) && (.mp3 isin %fixe)) {

      if (shoutcast_live isin $hget(web_socks,%sock)) {
        if (%web_shout-pos) sockmark %sock %web_shout-pos 0 real_time_sock_live
        else sockmark %sock 1 0 real_time_sock_live
      }
      else sockmark %sock $sock(%sock).mark real_time_sock
      halt
    }
    else {
      if (HEAD !isincs %temp) { envia }
      else { sockmark %sock end_cicle | $fecha(%sock,1) }
    }
  }
  elseif (Connect isin %cmd) { $ErrorHeader(%sock,405) }
  else { $ErrorHeader(%sock,501) }
}


;############################## PHP ######################################

alias -l phpExe {
  var %resto = $remove($gettok($1,2,63),"), %init = $remove($gettok($1,1,63),"), %sock = $sockname

  if (((? isin $1) && (!%resto)) || (script> isin %resto) || (=admin isin %resto) || ($len(%resto) > 190)) { $ErrorHeader(%sock,414) }
  if ((SqlQuery= isin %resto) || (IDAdmin= isin %resto) || (base= isin %resto) || (tampon= isin %resto) || (file= isin %resto)) { $ErrorHeader(%sock,414) }

  var %phpfile = $gettok($1,1,63), %rest, %parameter1
  var %postdata = $tmp_dir $+ %sock $+ post.tmp
  var %outfile = $tmp_dir $+ %sock $+ out.tmp
  var %vbsfile = $tmp_dir $+ %sock $+ exe.vbs
  var %batfile = $tmp_dir $+ %sock $+ exe.bat
  var %post = post $+ %sock

  var %i = $bfind($2, 1, 13 10 13 10)
  if (%i > 940) { $ErrorHeader(%sock,414) }
  var %header = $remove($bvar($2,1,%i).text,")
  var %request = $gettok(%header,2,32), %head, %data
  if (($chr(10) isin $gettok(%header,1,32)) || ($chr(13) isin $gettok(%header,1,32))) { $ErrorHeader(%sock,414) }

  .fopen -o %post %postdata
  if ($3 == p) {
    %i = $calc($bfind($2, 1, 13 10 13 10) + 4)
    bcopy &mine 1 $2 %i $bvar($2,0)
    if ($bvar(&mine,0)) .fwrite -b %post &mine
    else {
      .fclose %post
      halt
    }
  }
  .fclose %post

  var %content_len = $remove($getHeader(Content-Length:,$2),")
  if (%content_len !isnum) %content_len = 0

  .fopen -o %post %vbsfile
  .fwrite -n %post Set WshShell = WScript.CreateObject("WScript.Shell")
  .fwrite -n %post Set WshProcessEnv = WshShell.Environment("PROCESS")
  .fwrite -n %post WshProcessEnv("GATEWAY_INTERFACE") = "CGI/1.2"
  .fwrite -n %post WshProcessEnv("SERVER_SOFTWARE") = "Tontito's Web Server %web_version $+ "
  .fwrite -n %post WshProcessEnv("SERVER_PROTOCOL") = "HTTP/1.1"
  .fwrite -n %post WshProcessEnv("REDIRECT_STATUS") = "200"
  .fwrite -n %post WshProcessEnv("REQUEST_METHOD") = " $+ $gettok(%header,1,32) $+ "
  .fwrite -n %post WshProcessEnv("REQUEST_URI") = " $+ %request $+ "
  .fwrite -n %post WshProcessEnv("PATH_INFO") = " $+ %request $+ "
  .fwrite -n %post WshProcessEnv("PATH_TRANSLATED") = " $+ %init $+ "
  .fwrite -n %post WshProcessEnv("SCRIPT_FILENAME") = " $+ %init $+ "
  .fwrite -n %post WshProcessEnv("DOCUMENT_ROOT") = " $+ $gettok($hget(web_folders,$gettok(%request,1,47)),1,32) $+ "
  .fwrite -n %post WshProcessEnv("SCRIPT_NAME") = " $+ $gettok($gettok($gettok(%header,1,13),2,32),1,63) $+ "
  .fwrite -n %post WshProcessEnv("REMOTE_ADDR") = " $+ $sock(%sock).ip $+ "
  .fwrite -n %post WshProcessEnv("CONTENT_TYPE") = "application/x-www-form-urlencoded"
  .fwrite -n %post WshProcessEnv("CONTENT_LENGTH") = " $+ %content_len $+ "
  .fwrite -n %post WshProcessEnv("REDIRECT_URL") = " $+ $gettok($gettok($gettok(%header,1,13),2,32),1,63) $+ "
  .fwrite -n %post WshProcessEnv("SERVER_PORT") = " $+ $readf(port_list) $+ "
  .fwrite -n %post WshProcessEnv("SERVER_NAME") = " $+ $remove($gettok($getHeader(host:,$2),1,58),") $+ "

  if (%resto) {
    .fwrite -n %post WshProcessEnv("QUERY_STRING") = " $+ %resto $+ "
    .fwrite -n %post WshProcessEnv("REDIRECT_QUERY_STRING") = " $+ %resto $+ "
  }

  %header = $gettok(%header,2-,10)
  while (%header) {
    %head = $gettok(%header,1,32)
    %data = $gettok($gettok(%header,1,13),2-,32)

    %head = $upper(HTTP_ $+ $replace(%head,-,_,:,))
    if (%head != HTTP_GET) && (%head != HTTP_POST) && (%head != HTTP_HEAD) && (%head != HTTP__REQUEST_) {
      .fwrite -n %post WshProcessEnv(" $+ %head $+ ") = " $+ %data $+ "
    }
    %header = $gettok(%header,2-,10)
  }

  .fwrite -n %post Return = WshShell.Run("CMD /C "" $+ %batfile $+ """,0)
  .fclose %post 

  .fopen -o %post %batfile
  if ($isfile(%postdata) && ($file(%postdata).size > 0)) .fwrite -n %post %web_phpexe %phpfile %parameter1 < %postdata > %outfile
  else .fwrite -n %post %web_phpexe %phpfile > %outfile

  .fwrite -n %post del %vbsfile
  .fwrite -n %post del %postdata
  .fwrite -n %post del %batfile
  .fclose %post 

  run -n %vbsfile
  .timerphpwait $+ %sock -om 0 10 { check $2 %sock }
  halt
}

alias -l check {
  var %out = $tmp_dir $+ $2 $+ out.tmp

  if (!$isfile($tmp_dir $+ $2 $+ exe.vbs)) {
    .timerphpwait $+ $2 off
    if ($sock($2)) {
      var %k = $hget(web_partial,$2,&temp)
      $cabecalho(&temp,%out,200,$2)
      envia $2
    }
    elseif ($isfile(%out)) { .remove %out }
  }
}

alias getHeader {
  var %i = $calc($bfind($2, 1, $1) + $len($1))
  return $bvar($2,%i,$calc($bfind($2, %i, 13 10) - %i)).text
}

;############################  MHTML v2  #################################

alias -l le_multi {
  var %aux = up_file $+ $sockname
  sockread &temp
  .fwrite -b %aux &temp

  if ($bfind(&temp,1,$hget($sockname,tag) $+ --) || $1 || (($bvar(&temp,0) < 70) && $bfind(&temp,1,$right($hget($sockname,tag) $+ --,$calc($bvar(&temp,0) - 2))))) {
    .fclose %aux

    var %file = $gettok($hget($sockname,tagdata),1,32)
    var %tag = $hget($sockname,tag)
    %aux = $tmp_dir $+ $sockname $+ _up

    bread %aux 1 900 &lol
    var %size  = $calc($gettok($wildtok($bvar(&lol,15,900).text,*Content-Length:*,1,13),2,32) - 1000)
    if (%size > 50000000) {
      .remove %aux
      $ErrorHeader($sockname,413)
    }

    bread %aux 1 $file(%aux).size &tmp1
    .remove %aux

    %aux = $calc($bfind(&tmp1,1,name="userfile";))
    %i = $calc($bfind(&tmp1,%aux,13 10 13 10) + 4)

    if ($bvar(&tmp1,0) < 9000000) %size = %i
    bcopy &file 1 &tmp1 %i $calc($bfind(&tmp1,%size,%tag) - %i - 4)
    if ($bvar(&file,0) > 0) {
      hadd -bm mhtml $mid($sockname,2,10) $+ uploaded_file &file
      bunset &file

      %aux = $calc($bfind(&tmp1,%aux,filename=") + 10)
      var %name = $nopath($bvar(&tmp1,%aux,$calc($bfind(&tmp1,%aux,") - %aux)).text)
      if ((.php isin %name) || (.mhtml isin %name)) { .remove $tmp_dir $+ $sockname $+ _up | $ErrorHeader($sockname,412) }

      hadd mhtml $mid($sockname,2,10) $+ uploaded_name %name
    }

    bunset &tmp1
    hfree $sockname *
    sockrename $sockname $mid($sockname,2,10)
    var %file = $initMhtml(%lol,%file,)
    var %k = $hget(web_partial,$sockname,&temp)
    $cabecalho(&temp,%file,200,$sockname)
    envia
  }
}

alias -l initMhtml {
  var %teste = $bfind($1,1,Content-Type: multipart/form-data; boundary=)

  if (%teste > 0) {
    var %mais = $bfind(&temp,$calc(%teste + 44),13)

    hadd -m 1 $+ $sockname tag $bvar(&temp,$calc(%teste + 44),$calc(%mais - (%teste + 44))).text
    hadd -m 1 $+ $sockname tagdata $2

    var %dah = up_file $+ 1 $+ $sockname
    if (!$fopen(%dah)) .fopen -o %dah $tmp_dir $+ 1 $+ $sockname $+ _up
    .fwrite -b %dah $1

    if ($bfind(&temp,1,$hget(1 $+ $sockname,tag) $+ --)) {
      sockrename $sockname 1 $+ $sockname
      $le_multi(ok)
      halt
    }

    sockrename $sockname 1 $+ $sockname
    halt
  }
  else {
    hadd -m mhtml $sockname $+ mhtml_rootdir $nofile($2)

    var %i = 1, %tmp
    while ($true) {
      %tmp = $gettok($3,%i,38)
      if (%tmp == $null) break
      hadd mhtml $sockname $+ $gettok(%tmp,1,61) $gettok(%tmp,2,61)
      inc %i
    }

    if (!$isdir($tmp_dir)) mkdir $tmp_dir
    var %file
    if ($version >= 6.12) { %file = $writeAlias($2) }
    else { return }

    return %file
  }
}


alias -l writeAlias {
  if ($2 > 100) return
  var %file = $1, %sock = $sockname

  if (.. isin $1) {
    %i = $findtok(%file,..,1,92)
    %file = $deltok($deltok(%file,%i,92),$calc(%i - 1),92)
  }

  var %aux = $2 $+ _ $+ %sock
  var %dir = $tmp_dir
  var %linha, %script = 0 | .fopen %aux %file
  var %crt_dir = $nofile(%file)
  if ($ferr) return

  if (!$2) {
    .fopen -o %sock %dir $+ %sock $+ .tmp
    if ($ferr) return

    hadd -m temp $+ %sock 0 alias mhtml.rootdir $chr(123) return $nofile($shortfn($1)) $chr(125)
    hadd -m temp $+ %sock 1 alias mhtml.get $chr(123) return $ $+ hget(mhtml,$ $+ mhtml.sock $ $+ + $ $+ 1) $chr(125)
    hadd -m temp $+ %sock 2 alias mhtml.sock $chr(123) return %sock $chr(125)
    hadd -m temp $+ %sock 3 alias mhtml.print $chr(123) if ($ $+ 1 == -n) $chr(123) .fwrite -n %sock $+ 1 $ $+ 2- $chr(125)
    hadd -m temp $+ %sock 4 else $chr(123) .fwrite %sock $+ 1 $ $+ 1- $chr(125) $chr(125)
    hadd -m temp $+ %sock 5 alias mhtml.isset $chr(123) if ($ $+ hget(mhtml,$ $+ mhtml.sock $ $+ + $ $+ 1) == $ $+ null) return $ $+ false
    hadd -m temp $+ %sock 6 else return $ $+ true $chr(125)
    hadd -m temp $+ %sock 7 alias mhtml.self $chr(123) return $nopath($longfn($1)) $chr(125)
    hadd -m temp $+ %sock 8 alias mhtml.set $chr(123) hadd mhtml $ $+ mhtml.sock $ $+ + $ $+ 1 $ $+ 2 $chr(125)
    hadd -m temp $+ %sock 9 alias mhtml.cache $chr(123) hadd mhtml $ $+ mhtml.sock $ $+ + þcache $ $+ 1 $chr(125)
    hadd -m temp $+ %sock 10 alias mhtml.hidetime $chr(123) hadd mhtml $ $+ mhtml.sock $ $+ + dont_gene_time $ $+ 1 $chr(125)
    hadd -m temp $+ %sock 11 alias mhtml.wml $chr(123) hadd mhtml $ $+ mhtml.sock $ $+ + þwml $ $+ 1 $chr(125)
    hadd -m temp $+ %sock 12 alias mhtml.save $chr(123) var % $+ i = $ $+ hget(mhtml,$ $+ mhtml.sock $ $+ + uploaded_file,& $+ tmp) $chr(124) bwrite " $ $+ + $ $+ 1 $ $+ + " -1 & $+ tmp $chr(125)

    .fwrite -n %sock on 1:load: $+ $chr(123) .fopen -o %sock $+ 1 %dir $+ %sock $+ .index.tmp $chr(124) var % $+ times = $ticks
  }

  while (!$feof) {
    %linha = $remove($fread(%aux),$chr(9))

    if ($len(%linha) != $count(%linha,$chr(32))) {
      if (? isin %linha) {
        if (<?mhtml.inc isin %linha) { $recurs(%crt_dir $+ $gettok($gettok(%linha,2,32),1,63), $calc($2 + 1)) | if ($fopen($calc($2 + 1) $+ _ $+ %sock)) fclose $calc($2 + 1) $+ _ $+ %sock }
        elseif (<?mhtml isin %linha) %script = 1
        elseif (?> isin %linha) %script = 0
        elseif (!%script) .fwrite -n %sock .fwrite -n %sock $+ 1 $left(%linha,900)
        elseif (%script) {
          if ((alias* iswm %linha) || (%script == 2)) { %script = 2 | hadd -m temp $+ %sock $hget(temp $+ %sock,0).item %linha }
          elseif ((*mhtml.include* iswm %linha)) $recurs(%crt_dir $+ $gettok($gettok(%linha,2,32),1,63), $calc($2 + 1))
          else .fwrite -n %sock $replace(%linha,"$mhtml.self\",$hget(mhtml,%sock $+ mhtml_path))
        }
      }
      elseif (!%script) {
        .fwrite -n %sock .fwrite -n %sock $+ 1 $left(%linha,900)
      }
      elseif (%script) {
        if ((alias* iswm %linha) || (%script == 2)) { %script = 2 | hadd -m temp $+ %sock $hget(temp $+ %sock,0).item %linha }
        elseif ((*mhtml.include* iswm %linha)) { $recurs(%crt_dir $+ $gettok($gettok(%linha,2,32),1,63), $calc($2 + 1)) | if ($fopen($calc($2 + 1) $+ _ $+ %sock)) fclose $calc($2 + 1) $+ _ $+ %sock }
        else .fwrite -n %sock %linha
      }
    }
  }
  .fclose %aux

  if (!$2) {
    .fwrite -n %sock .fwrite -n %sock $+ 1 <p>Mhtml page generated in $ $+ calc(($ $+ ticks - % $+ times) / 1000) $ $+ + s</p>
    .fwrite -n %sock .fclose %sock $+ 1 $chr(124) .remove $ $+ script
    .fwrite -n %sock .unload -rs $ $+ script $chr(125)

    var %i = 0, %len = $hget(temp $+ %sock,0).item
    while (%i < %len) {
      .fwrite -n %sock $hget(temp $+ %sock,%i)
      inc %i
    }
    hfree temp $+ %sock

    .fclose %sock
    .load -rs %dir $+ %sock $+ .tmp
    return %dir $+ %sock $+ .index.tmp
  }
  else return
}

alias -l recurs { $writeAlias($1,$2) }

;#########################################################################

alias -l test_access {
  if ($gettok($hget(web_folders,$1),4,32) == Yes) {
    var %data = $gettok($wildtok($2,*Authorization:*,1,13),3,32)
    var %user = $gettok($decode(%data,m),1,58)
    var %aut = $md5(%data)

    if (%aut == $gettok($hget(web_folders,$1),5,32)) { return 200 }
    elseif (%aut == $gettok($hget(web_passwd,%user),1,32) && $istok($hget(web_passwd,%user),$1,1,32)) { return 200 }
    else return 401
  }
  return 200
}


alias -l procura {
  var %fixe = $1 $+ \index.htm
  if (!$isfile(%fixe)) %fixe = $1 $+ \index.html
  if (!$isfile(%fixe)) %fixe = $1 $+ \index.mhtml
  if (!$isfile(%fixe)) %fixe = $1 $+ \index.php
  if (!$isfile(%fixe)) %fixe = not
  return $replace(%fixe,\\,\)
}

alias -l descodifica {
  var %text = $1, %aux, %aux1, %tx1, %tx2
  var %brow = $2

  :again
  %aux = $pos(%text,%,1)
  if (!%aux) goto end

  if ($mid(%text,$calc(%aux + 3),1) == \) %brow = n

  if ((%brow == i)) {
    %tx1 = $mid(%text,$calc(%aux + 1),2)
    %tx2 = $mid(%text,$calc(%aux + 4),2)
    if (%tx1 == C2) { %aux1 = $chr($base(%tx2,16,10)) }
    else { %aux1 = $chr($calc($base(%tx1,16,10) + ($base(%tx2,16,10) - 131))) }
    %aux = %tx1 $+ % $+ %tx2
  }
  else {
    %aux = $mid(%text,$calc(%aux + 1),2)
    %aux1 = $chr($base(%aux,16,10))
  }

  if (%aux !isincs %text) { %text = $replace(%text,% $+ $left(%aux,2), %aux1) }
  else %text = $replace(%text,% $+ %aux, %aux1)

  goto again
  :end
  return $replace(%text,$chr(32), % $+ 20)
}

alias -l envia {
  var %sock = $sockname $1
  if (($sock(%sock).sq > 8000) || ($sockerr)) { if ($sockerr) $fecha(%sock,1) | return }
  tokenize 32 $sock(%sock).mark

  if (!$4 || ($4 > 399) || ($5 <= 0)) { if ($5 <= 0) { return } | $fecha(%sock,1) }
  bread $1 $2 8192 &fich
  sockwrite -n %sock &fich
  sockmark %sock $1 $calc($2 + 8192) $3 $4 $calc($5 - 8192) $6

  if (real_time_sock isin $1-) {
    if ($2 < 8192) {
      var %fich = StreamTitle=' $+ $nopath($longfn($1)) $+ ';StreamUrl='';
      var %size = $ceil($calc($len(%fich) / 16))
      var %falta = $calc((%size * 16) - $len(%fich))
      if (%falta == 0) { inc %size | %falta = 16 }

      bset &metadata 1 %size
      bset -t &metadata 2 %fich
      var %i = 0
      while (%i < %falta) {
        bset &metadata $calc($bvar(&metadata,0) + 1) 0
        inc %i
      }
    }
    else bset &metadata 1 0
    sockwrite %sock &metadata
  }

  if ($timer(ww_bitrate)) inc %web_rate 8
  if (($5 <= 8192) || (%pos <= 8192)) {
    var %long = $longfn($1)
    if (*index.tmp iswm $1) { .remove $1 }
    if (* $+ %sock $+ out.tmp iswm %long) { .remove $1 }
    if (($sock(%sock).sq == 0) && ($sock(%sock).rq == 0)) { $fecha(%sock,0) }
    else { $fecha(%sock,1) }
  }
}

alias -l real_shout {
  if ($sockerr || ($hget(%web_list,0).item == 0)) $fecha($sockname,1)

  var %param = $sock($sockname).mark
  var %web_shout = $gettok(%param,1,32)
  var %web_shout_pos = $gettok(%param,2,32)
  set %web_shout-pos %web_shout

  if (%web_shout <= 0 || ($sockname == $null)) { halt }

  if ($sock($sockname).sq <= 8192) {
    var %file = $shortfn($hget(%web_list,%web_shout))
    if ($isfile(%file) && ($file(%file).size > %web_shout_pos)) bread %file %web_shout_pos 8192 &data

    if ($bvar(&data,0) < 8192) {
      inc %web_shout

      if (!$isfile($shortfn($hget(%web_list,%web_shout)))) { set %web_shout 1 }
      if (%web_shout > $hget(%web_list,0).item) { set %web_shout 1 }
      set %web_shout_pos $calc(8192 - $bvar(&data,0))

      %file = $shortfn($hget(%web_list,%web_shout))
      if ($isfile(%file)) {
        bread %file 0 $calc(8192 - $bvar(&data,0)) &fich_tmp
        bcopy -c &data $calc($bvar(&data,0) + 1) &fich_tmp 1 -1
      }
      else { sockclose $sockname | halt }
    }
    else { inc %web_shout_pos 8192 }

    if (%web_shout_pos <= 8192) {
      var %fich = StreamTitle=' $+ $nopath($longfn($hget(%web_list,%web_shout))) $+ ';StreamUrl='';
      var %size = $ceil($calc($len(%fich) / 16))
      var %falta = $calc((%size * 16) - $len(%fich))
      if (%falta == 0) { inc %size | %falta = 16 }

      bset &metadata 1 %size
      bset -t &metadata 2 %fich
      var %i = 0
      while (%i < %falta) {
        bset &metadata $calc($bvar(&metadata,0) + 1) 0
        inc %i
      }
    }
    else { bset &metadata 1 0 }

    if ($timer(ww_bitrate)) inc %web_rate 8
    sockwrite $sockname &data
    sockwrite $sockname &metadata

    sockmark $sockname %web_shout %web_shout_pos $gettok(%param,3-,32)
  }
}

;###### Cleanup structures #######


alias -l fecha {
  if (!$1) { halt }
  .timer $+ $1 off
  .timerphpwait $+ $1 off
  if ($hget(web_partial)) hdel web_partial $1
  if ($hget(web_socks)) hdel web_socks $1
  if ($hget(mhtml)) hdel -w mhtml * $+ $1 $+ *

  var %ip = $sock($1).ip
  if (!%ip) %ip = $hfind(web_ips,* $+ $1 $+ *,1,w).data
  var %n = $gettok($hget(web_ips,%ip),1,32)
  var %nome_socks = $gettok($hget(web_ips,%ip),2-,32)

  if ($istok(%nome_socks,$1,32)) {
    dec %n
    if (%n <= 0) hdel web_ips %ip
    else hadd web_ips %ip %n $remove($gettok($hget(web_ips,%ip),2-,32),$1)
  }

  if ($3) { $sclose($1,true) | halt }

  if ($2 == 0) sclose $1
  else .timerwait $+ $1 -mo 0 400 sclose $1
  halt
}

alias -l sclose {
  if ($2 || !$sock($1) || (($sock($1).sq == 0) && ($sock($1).rq == 0))) {
    hdel web_socks $1
    hdel web_partial $1
    sockclose $1

    if ($window(@ListConnections)) { list_con }
    .timerwait $+ $1 off
  }
}

alias -l sfecha {
  var %test = $fline(@ListConnections,* $+ $sockname $+ *,1,1)
  if (%test) dline @ListConnections %test

  if ($hget(web_partial)) hdel web_partial $sockname
  if ($hget(web_socks)) hdel web_socks $sockname
  if ($hget(mhtml)) hdel -w mhtml * $+ $sockname $+ *
  var %ip = $sock($sockname).ip

  var %n = $gettok($hget(web_ips,%ip),1,32)
  var %nome_socks = $gettok($hget(web_ips,%ip),2-,32)

  if ($istok(%nome_socks,$sockname,32)) {
    dec %n
    if (%n <= 0) hdel web_ips %ip
    else hadd web_ips %ip %n $remove($gettok($hget(web_ips,%ip),2-,32),$sockname)
  }

  if ($version >= 6.12) {
    if ($sockname isin $script($script(0))) {
      .remove $script($script(0))
      .unload -rs $script($script(0))
      echo $readL(n107)
    }
    .fclose * $+ $sockname $+ *
    .remove $tmp_dir $+ 1 $+ $sockname $+ _up
    if ($hget(temp $+ $sockname)) hfree -s temp $+ $sockname
  }

  .timer $+ $sockname off
  .timerwait $+ $sockname off
  .timerphpwait $+ $sockname off
}


;######### admin interface ##########

alias list_cleanup {
  var %i = 1, %sock

  if ($hget(web_socks,0).item > 0) {
    while (%i <= $hget(web_socks,0).item) {
      %sock = $hget(web_socks,%i).item

      if (!$sock(%sock) || (($sock(%sock).rcvd == 0) && ($sock(%sock).ls > 60))) {
        hdel web_socks %sock
        echo fecha %sock com $sock(%sock).rcvd e com $sock(%sock).ls e tem $sock(%sock)
        sockclose %sock
      }
      else inc %i
    }
    if ($window(@ListConnections)) { list_con }
  }
}

alias test_virtfolder {
  var %i = 1, %dir
  while (%i <= $hget(web_folders,0).item) {
    if (!$isdir($gettok($hget(web_folders,%i).data,1,32))) {
      echo 8 -a $readL(n33) 1--> $hget(web_folders,%i).item <--
      hdel web_folders $hget(web_folders,%i).item
    }
    else inc %i
  }
  saves
}


;###### END Cleanup structures #######

alias list_con1 {
  var %i = 1
  if (!$sock(www)) { echo -a $readL(n22) | return }
  if ($hget(web_ips,0).item == 0) { echo -a $readL(n23) | return }

  echo $readL(n24)
  while (%i <= $hget(web_ips,0).item) {
    echo $readL(n25) $hget(web_ips,%i).item $hget(web_ips,%i).data
    inc %i
  }
  echo $readL(n26)
}

alias list_con {
  var %i = 1
  clear @ListConnections
  if (!$sock(www)) { echo -a $readL(n22) | return }

  window -dlS @ListConnections
  while (%i <= $hget(web_socks,0).item) {
    aline @ListConnections $hget(web_socks,%i).data
    inc %i
  }
}

alias -l para {
  if ($sock(www)) {
    sockclose ww* | .timerww* off | .timerwaitww* off
    if ($hget(web_socks)) { hfree web_socks }
    if ($hget(web_ips)) { hfree web_ips }
    if ($hget(mhtml)) hfree mhtml
    if ($hget(web_partial)) hfree web_partial
    hfree -w temp*
    .timerchan_prop off
    echo 3 -a $readL(n27)
  }
  else { echo 3 -a $readL(n28) }
}

alias -l comeca {
  if (!$1) { init }
  if (!$sock(www)) {
    if (!$portfree($readf(port_list))) { echo 4 -a $readL(n29) $readf(port_list) | halt }
    socklisten www $readf(port_list)
  }
  else { echo 3 -a $readL(n30) | halt }
  var %ip = 127.0.0.1
  if ($server) %ip = $ip
  if (%web_limit isnum) { .timerww_bitrate -o 0 1 regula }
  if (!$hget(web_socks)) { hmake web_socks 20 }
  if (!$hget(web_ips)) { hmake web_ips 20 }
  if (!$hget(web_partial)) { hmake web_partial 1 }

  test_virtfolder
  var %logs = $shortfn($scriptdir) $+ Logs
  if (!$isdir(%logs)) mkdir %logs

  %logs = $shortfn($scriptdir) $+ Configs\playlist.ric
  if ($isfile(%logs) && ($readf(web_list) != $null) && !$hget($readf(web_list))) {
    hmake $readf(web_list) | hload $readf(web_list) %logs | set %web_list $readf(web_list)
  }

  if ($version > 6.16) echo 4 This Web server version hasn't been yet tested with Mirc $version $+ , some options may not work well.

  if ($server && $sock(www) && ($readf(public) == on)) {
    .timerchan_prop 0 $calc(60 * $readf(timer_chan)) say_prop
    say_prop
  }

  echo 3 -a $readL(n31)
  echo 3 -a $readL(n32)
}


;#### regules ####

alias -l regula {
  ; list_cleanup

  if (%web_limit isnum) {
    var %var = $calc(%web_rate / %web_limit)
    var %l = $mid(%var,3,1)

    if ((%var < 1.1) && (%var > 0.9)) { }
    elseif (%web_rate > %web_limit) {
      if ((%web_lag == 10) || (%var > 2)) { inc %web_lag 250 }
      else { inc %web_lag $calc(%l * 2) }
    }
    elseif (%web_lag > 5) {
      if (%var < 0.6) { dec %web_lag 60 }
      else { dec %web_lag $calc(2 * (10 - %l)) }
    }
    set %web_rate 0
  }
  else .timerww_bitrate off
}

;### Dinamic list of folders and playlists ###

alias -l list {
  if ($version == 6.03) { $list_6.03($1,$2,$3,$4,$5) | return }

  var %var, %in4 = $4
  if ($4 == root) return
  var %time = $ticks
  var %i = 1, %j, %f, %dir = $1, %file = $1 $+ index.tmp, %size
  var %shared = $2
  var %long = $longfn(%shared)
  var %lcldir = $5, %tmpfile = file $+ $sockname

  .fopen -o %tmpfile %file
  if ($ferr) { if ($fopen(file)) .fclose %tmpfile | return }

  .fwrite %tmpfile <html><title> $readf(title) </title><body bgcolor=" $+ $readf(bgcolor) $+ " link=" $+ $readf(link) $+ " vlink=" $+ $readf(vlink) $+ " text=" $+ $readf(text) $+ "><div align="left">
  if ($isfile($readf(topimage))) { .fwrite -n %tmpfile <p align="center"><img border="0" src=" /-_icons_-/top.jpg "></p> }
  .fwrite %tmpfile <table>
  if (($gettok($hget(web_folders,$4),2,32) != Yes) || ($hget(web_access,$sock($sockname).ip) == NoDWL)) .fwrite %tmpfile <tr><td> $readL(n34) </td></tr>
  if (($2 && ($hget(web_folders,0).item > 1)) || ($2 != $1)) .fwrite -n %tmpfile <tr><td><a href="../"><img src="/-_icons_-/back.gif" alt="Back" border="0"></a></td></tr>

  var %h = $finddir(%dir,*,0,1, var %i = $make_folder_list($longfn($1-), %tmpfile , %lcldir, %long)).shortfn
  %h = $findfile(%dir,*,0,1, var %i = $make_file_list($longfn($1-), %tmpfile , %in4, %long)).shortfn

  .fwrite %tmpfile </table> Page generated in $calc(($ticks - %time) / 1000) $+ s </div></body></html>
  .fclose %tmpfile
}

alias -l make_folder_list {
  var %tmp1 = $gettok($1,-1,92), %tmp = $gettok($replace($remove($1,$4),\,/,$chr(32), % $+ 20),-1,47)
  if (h !isin $file($1).attr) .fwrite -n $2 <tr><td><img src=" $+ /-_icons_-/folder.gif $+ "><a href=" $+ ./ $+ $3 $+ %tmp $+ / $+ "> %tmp1 </a></td><td></td></tr>
}

alias -l make_file_list {
  var %f = $1, %j, %size, %prop = $file($1).attr
  if (h isin %prop || s isin %prop || %prop == $null) { return }

  %j = $replace($remove(%f,$4), \, /,$chr(32), % $+ 20)
  if ($left(%j,1) != /) { %j = / $+ %j }
  %size = $file(%f).size
  if (%size < 10000000) { %size = $round($calc(%size / 1024),1) $+ Kb }
  else { %size = $round($calc(%size / 1048576),1) $+ Mb }

  if (*index.tmp !iswm %j) .fwrite -n $2 <tr><td><a href=" $+ / $+ $3 $+ %j $+ "> $nopath(%f) </a></td><td> %size </td></tr>
}


alias -l list_6.03 {
  var %var, %in4 = $4
  if ($4 == root) return
  var %time = $ticks
  var %i = 1, %j, %f, %dir = $1, %file = $1 $+ index.tmp, %size
  var %shared = $2
  var %long = $longfn(%shared)
  var %lcldir = $5

  write -c %file <html><title> $readf(title) </title><body bgcolor=" $+ $readf(bgcolor) $+ " link=" $+ $readf(link) $+ " vlink=" $+ $readf(vlink) $+ " text=" $+ $readf(text) $+ "><div align="left">
  if ($isfile($readf(topimage))) { write -a %file <p align="center"><img border="0" src=" /-_icons_-/top.jpg "></p> }

  write -a %file <table>
  if (($gettok($hget(web_folders,$4),2,32) != Yes) || ($hget(web_access,$sock($sockname).ip) == NoDWL)) write -a %file <tr><td> $readL(n34) </td></tr>
  if (($2 && ($hget(web_folders,0).item > 1)) || ($2 != $1)) write -a %file <tr><td><a href="../"><img src="/-_icons_-/back.gif" alt="Back" border="0"></a></td></tr>
  var %h = $finddir(%dir,*,0,1, var %i = $make_folder_list_6.03($longfn($1-), %file, %lcldir, %long)).shortfn
  %h = $findfile(%dir,*,0,1, var %i = $make_file_list_6.03($longfn($1-), %file, %in4, %long)).shortfn

  write -a %file </table> Page generated in $calc(($ticks - %time) / 1000) $+ s </div></body></html>
}

alias -l make_folder_list_6.03 {
  var %tmp1 = $gettok($1,-1,92), %tmp = $gettok($replace($remove($1,$4),\,/,$chr(32), % $+ 20),-1,47)
  if (h !isin $file($1).attr) write -a $2 <tr><td><img src=" $+ /-_icons_-/folder.gif $+ "><a href=" $+ ./ $+ $3 $+ %tmp $+ / $+ "> %tmp1 </a></td><td></td></tr>
}

alias -l make_file_list_6.03 {
  var %f = $1, %j, %size, %prop = $file($1).attr
  if (h isin %prop || s isin %prop || %prop == $null) { return }

  %j = $replace($remove(%f,$4), \, /,$chr(32), % $+ 20)
  if ($left(%j,1) != /) { %j = / $+ %j }
  %size = $file(%f).size
  if (%size < 10000000) { %size = $round($calc(%size / 1024),1) $+ Kb }
  else { %size = $round($calc(%size / 1048576),1) $+ Mb }

  if (index.tmp !isin %j) write -a $2 <tr><td><a href=" $+ / $+ $3 $+ %j $+ "> $nopath(%f) </a></td><td> %size </td></tr>
}


alias -l list_sp {
  var %i = 1, %dir

  write -c $1 <html><title> $readf(title) </title><body bgcolor=" $+ $readf(bgcolor) $+ " link=" $+ $readf(link) $+ " vlink=" $+ $readf(vlink) $+ " text=" $+ $readf(text) $+ ">
  if ($isfile($readf(topimage))) { write -a $1 <p align="center"><img border="0" src=" /-_icons_-/top.jpg "></p> }

  while (%i <= $hget(web_folders,0).item) {
    %dir = $hget(web_folders,%i).item
    if ((%dir != root) && ($gettok($hget(web_folders,%dir),3,32) == Yes)) {
      write -a $1 <p><img src=" $+ /-_icons_-/folder.gif $+ "><a href=" $+ / $+ %dir $+ / $+ "> %dir </a></p>
    }
    inc %i
  }
  write -a $1 </body></html>
}

alias -l list_web_list {
  var %i = 1, %file, %time = $ticks, %tmpfile = filelist $+ $sockname
  .fopen -o %tmpfile $1

  .fwrite -n %tmpfile <html><title> $readf(title) </title><body bgcolor=" $+ $readf(bgcolor) $+ " link=" $+ $readf(link) $+ " vlink=" $+ $readf(vlink) $+ " text=" $+ $readf(text) $+ "><div align="left">
  if ($isfile($readf(topimage))) { .fwrite -n %tmpfile <p align="center"><img border="0" src=" /-_icons_-/top.jpg "></p> }
  .fwrite -n %tmpfile <table> <tr><td><a href="../"><img src="/-_icons_-/back.gif" alt="Back" border="0"></a></td></tr>
  if ($hget(%web_list,0).item > 0) .fwrite -n %tmpfile <tr><td><center><a href="/-_icons_-/playlist.pls"><img src="/-_icons_-/pls.gif" alt="Load playlist!" border="0"></a></center></td></tr>

  while (%i <= $hget(%web_list,0).item) {
    %file = $longfn($hget(%web_list,%i))
    if (%file) {
      if (%i == %web_shout-pos) .fwrite -n %tmpfile <tr><td><b><i><font color=" $+ $readf(link) $+ "> %i $+ : $nopath(%file) </font></i></b></td></tr>
      else .fwrite -n %tmpfile <tr><td> %i $+ : $nopath(%file) </td></tr>
    }
    inc %i
  }

  if ($hget(%web_list,0).item > 0) .fwrite -n %tmpfile <tr><td><center><a href="/-_icons_-/playlist.pls"><img src="/-_icons_-/pls.gif" alt="Load playlist!" border="0"></a></center></td></tr>
  .fwrite -n %tmpfile </table> Page generated in $calc(($ticks - %time) / 1000) $+ s </div></body></html>
  .fclose %tmpfile
}

alias -l gene_playlist {
  var %fixe = $tmp_dir $+ $sockname $+ playlist.pls.index.tmp
  write -c %fixe [playlist]
  write -a %fixe numberofentries=1
  if (!$1) write -a %fixe File1=http:// $+ $ip $+ /live
  else write -a %fixe File1=http:// $+ $1 $+ /live
  return %fixe
}


;### Headers section ###

alias -l cabecalho {
  if (($3 < 400) && (!$4 || ($bvar($1,0) == 0))) return
  var %aux, %fich, %falta, %tama, %num, %text, %ftime, %ate, %tem, %data1, %data2, %content
  %fich = $2 | %num = $3 | %tem = 0 | %ftime = $file(%fich).mtime
  var %leng = $file(%fich).size

  if ((*out.tmp iswm %fich) && (%leng > 0)) {
    bread %fich 0 %leng &mine
    var %i = $bfind(&mine, 1, 13 10 13 10)
    bread %fich $calc(%i + 3) %leng &mine
    bread %fich 0 %i &header
    var %header = $bvar(&header,1,900).text

    if (Status: isin %header) {
      %num = $gettok($gettok(%header,1,13),2,32)
      .remove %fich
    }
    else {
      .remove %fich
      bwrite %fich -1 -1 &mine
    }
  }

  if (%leng > 50000) {
    var %ip = $sock($4).ip
    var %ns = $gettok($hget(web_ips,%ip),1,32)
    inc %ns
    if (%ns > %web_maxConnByIP) { %num = 406 }
    hadd web_ips %ip %ns $gettok($hget(web_ips,%ip),2-,32) $4
  }

  if (%num < 400) {
    %text = $bvar($1,1,900).text
    %aux  = $gettok($wildtok(%text,*Range: bytes*,1,13),2,61)
    %data1 = $gettok($wildtok(%text,*If-Range:*,1,13),2-,32)
    %data2 = $gettok($wildtok(%text,*If-Modified-Since*,1,13),2-,32)

    if (%aux) { %tem = $gettok(%aux,1,45) | %ate = $gettok(%aux,2,45) }
    if (%data1 && %aux) {
      if ($ctime(%data1) >= %ftime) { %num = 206 }
      else { %num = 200 }
    }
    if (%data2) {
      if (($ctime(%data2) > $gmt) || %ftime > $ctime(%data2)) { %num = 200 }
      else { %num = 304 }
    }
  }

  %tama = $file(%fich).size
  if (!%tama) { %tama = 0 }
  if (!%ate) { %ate = $calc(%tama - 1) }
  %falta = $calc((%ate + 1) - %tem)
  if ((%num == 200) && (%falta < %tama)) { %num = 206 }

  if ($bfind($1, 1,Icy-MetaData)) {
    sockmark $4 %fich %tem %tama %num %falta
    sockwrite -n $4 ICY %num
    if (%num < 400) {
      sockwrite -n $4 icy-notice1:<BR>This stream requires <a href="http://www.winamp.com/">Winamp</a><BR>
      sockwrite -n $4 icy-name:Tontito Web Sound %web_version
      sockwrite -n $4 icy-genre:All around
      sockwrite -n $4 icy-metaint:8192
      sockwrite -n $4 icy-br: $+ $sound(%fich).bitrate
      sockwrite -n $4
    }
    else { $fecha($4) }
  }
  else {
    sockmark $4 %fich %tem %tama %num %falta
    sockwrite -n $4 HTTP/1.1 %num
    sockwrite -n $4 Date: $asctime($gmt,ddd dd mmm yyyy HH:nn:ss) GMT
    sockwrite -n $4 Server: Tontito's Mirc Web Server %web_version

    if ($bvar(&header,0)) {
      var %tam = $bvar(&header,0), %head, %data
      var %header = $bvar(&header,1,%tam).text , %cok

      while (%header) {
        %head = $gettok(%header,1,32)
        %data = $gettok($gettok(%header,1,13),2-,32)

        if (%head == Content-type:) %content = true
        if ((%num != 302) && (%head != Status:)) {
          sockwrite -n $4 %head %data
          inc %cok
        }
        elseif (%head == Location:) {
          sockwrite -n $4 %head %data
        }
        %header = $gettok(%header,2-,10)
      }
    }
    else if (%num == 302) { sockwrite -n $4 Location: $5 }

    var %wml = $hget(mhtml,$4 $+ þwml)

    if (%num < 400) {
      sockwrite -n $4 Last-Modified: $asctime(%ftime,ddd dd mmm yyyy HH:nn:ss) GMT
      sockwrite -n $4 Accept-Ranges: bytes
      var %ext = $gettok(%fich,-1,46)

      if (!%content) {
        if (*playlist.pls.index.tmp iswm %fich) { sockwrite -n $4 Content-Type: audio/x-scpls }
        elseif (%ext isin html php) { sockwrite -n $4 Content-Type: text/html }
        elseif (%ext isin txt log) { sockwrite -n $4 Content-Type: text/plain }
        elseif (%ext isin jpg gif png bmp tif) { sockwrite -n $4 Content-Type: image/jpeg }
        elseif (%ext isin ico) { sockwrite -n $4 Content-Type: image/x-icon }
        elseif (%ext isin tmp wml) {
          if (%wml || (%ext == wml)) { sockwrite -n $4 Content-Type: text/vnd.wap.wml }
          else { sockwrite -n $4 Content-Type: text/html }
        }
        else { sockwrite -n $4 Content-Type: application }
      }

      if ((%ext == mhtml) || (%ext == tmp)) { sockwrite -n $4 Cache-Control: no-cache }
      if (htm !isin %ext) { sockwrite -n $4 Content-Length: %falta }
      if (%tem >= 0) { sockwrite -n $4 Content-Range: bytes %tem $+ - $+ %ate $+ / $+ %tama }
    }

    sockwrite -n $4 Connection: close
    sockwrite -n $4

    if ((%num > 399) || (%num == 302)) { $erro(%num,$4,ok,%wml) }
  }
}

alias -l ErrorHeader {
  if (($2 < 400) && ($2 != 302)) { echo This method can only be used to send errors! | return }

  if ($sock($1).sq < 4000) {
    sockwrite -n $1 HTTP/1.1 $2 .
    if ($2 == 401) { sockwrite -n $1 WWW-Authenticate: Basic realm="Tontito Web Server Authenticate System" }
    sockwrite -n $1 Date: $asctime($gmt,ddd dd mmm yyyy HH:nn:ss) GMT
    sockwrite -n $1 Server: Tontito's Mirc Web Server %web_version

    if ($2 == 302) { sockwrite -n $1 Location: $3 }
    sockwrite -n $1 Connection: close
    sockwrite -n $1
  }
  else { $fecha($1,0,true) }

  if (($2 > 399) || ($2 == 302)) { $erro($2,$1,ok) }
}

alias -l erro {
  var %message
  if ($1 == 400) %message = Bad Request (Requests with special chars made by ie type browsers aren't accepted)
  elseif ($1 == 401) %message = Unauthorized
  elseif ($1 == 403) %message = Forbidden
  elseif ($1 == 404) %message = The page cannot be found/displayed
  elseif ($1 == 405) %message = Method Not Allowed
  elseif ($1 == 406) %message = Not Acceptable (too many connections from your host)
  elseif ($1 == 412) %message = File type can't be uploaded
  elseif ($1 == 413) %message = File is too big to be uploaded
  elseif ($1 == 414) %message = The server is not willing to process the request
  elseif ($1 == 416) %message = Php module not loaded
  elseif ($1 == 501) %message = Not Implemented
  elseif ($1 == 503) %message = Service Unavailable for Mirc version < 6.12

  if (!%wml) {
    sockwrite -n $2 <html><head><title>HTTP $1 $+ </title></head><table><tr><td> %message </td></tr>
    sockwrite -n $2 <tr><td>Server returned Error code $1.</td></tr></table></html>
  }
  else {
    sockwrite -n $2 <?xml version="1.0"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml"><wml><card id="deck1" title="Wml IRC Menu"><p>Menu<br/>
    sockwrite -n $2 <br/></p><p align="center"><a href="index.wml"> Homepage </a></p><p align="center">
    sockwrite -n $2 <p align="center"><br/> © Tontito <br/></p></card></wml>
  }

  if ($3 && ($1 != 414)) { $fecha($2,0) }
  else { $fecha($2,1) }
}

on *:Text:!web server:#:{ if (($readf(public) == on) && ($hget(web_chans,$chan)) && ($sock(www))) .notice $nick $replace($hget(web_chans,$chan),&k,,&b,,&u,,mysong,$nopath($longfn($hget(%web_list,%web_shout-pos))),myip,http:// $+ $ip $+ : $+ $readf(port_list)) }

alias -l say_prop {
  var %i = 1
  while (%i <= $hget(web_chans,0).item) {
    if ($me ison $hget(web_chans,%i).item) {
      if ($hget(web_chans,%i).data) msg $hget(web_chans,%i).item $replace($hget(web_chans,$hget(web_chans,%i).item),&k,,&b,,&u,,mysong,$nopath($longfn($hget(%web_list,%web_shout-pos))),myip,http:// $+ $ip $+ : $+ $readf(port_list))
      else echo 4 Attention: $hget(web_chans,%i).item with no message in chan pub!!!!
    }
    inc %i
  }
}


alias -l tmp_dir return $shortfn($scriptdir) $+ tempFiles\


;#### Dialogs ####

alias -l conf { if (!$dialog(web_conf)) dialog -md web_conf web_conf }

on *:dialog:web_conf:init:*:{ fill_conf }

dialog web_conf {
  title $readL(n36)
  size -1 -1 213 220
  option dbu
  tab $readL(n37), 1, 1 0 209 195
  check $readL(n38), 2, 11 25 54 10, tab 1
  edit "", 5, 177 41 23 10, tab 1 limit 5
  text $readL(n40), 6, 125 42 52 8, tab 1
  text $readL(n41), 7, 10 42 51 8, tab 1
  edit "", 8, 60 41 16 10, tab 1 limit 3
  button $readL(n42), 9, 15 79 44 12, tab 1
  combo 10, 74 80 66 50, tab 1 sort size drop
  button $readL(n43), 11, 154 79 44 12, tab 1
  text "KB/s", 13, 77 42 18 8, tab 1
  check $readL(n44), 14, 13 97 89 10, tab 1
  check $readL(n45), 15, 119 97 83 10, tab 1
  box $readL(n46), 16, 7 60 198 79, tab 1
  box $readL(n47), 17, 7 141 198 53, tab 1
  combo 18, 74 177 67 50, tab 1 sort size drop
  button $readL(n48), 19, 15 177 44 12, tab 1
  button $readL(n49), 20, 154 177 44 12, tab 1
  check $readL(n50), 21, 12 149 96 10, tab 1
  edit "", 22, 36 162 164 10, tab 1 autohs
  text $readL(n51), 23, 9 164 27 8, tab 1
  edit "", 24, 161 150 21 10, tab 1
  text $readL(n52), 25, 117 151 44 8, tab 1
  text $readL(n53), 26, 182 151 20 8, tab 1
  box "", 27, 7 16 198 41, tab 1
  text "", 50, 67 27 135 8, tab 1
  check $readL(n54), 51, 13 110 63 10, tab 1
  edit "", 52, 37 124 50 10, tab 1
  edit "", 53, 143 124 53 10, tab 1 pass
  text $readL(n55), 54, 105 125 38 8, tab 1
  text $readL(n56), 55, 13 125 23 8, tab 1
  text "", 56, 81 114 116 8, tab 1
  link "", 12, 11 68 191 8, tab 1
  tab $readL(n57), 28
  box $readL(n58), 29, 8 20 197 43, tab 28
  check $readL(n59), 30, 15 28 182 10, tab 28
  button $readL(n60), 31, 16 42 44 12, tab 28
  combo 32, 72 42 70 50, tab 28 sort size drop
  button $readL(n61), 33, 153 42 44 12, tab 28
  box $readL(n62), 34, 8 68 197 43, tab 28
  check $readL(n63), 35, 15 77 59 10, tab 28
  check $readL(n64), 36, 142 77 58 10, tab 28
  combo 37, 72 92 70 50, tab 28 sort size drop
  button $readL(n60), 38, 16 91 44 12, tab 28
  button $readL(n61), 39, 153 91 44 12, tab 28
  box $readL(n65), 71, 8 116 196 35, tab 28
  button $readL(n60), 73, 16 129 44 12, tab 28
  combo 74, 72 130 70 50, tab 28 size drop
  button $readL(n61), 75, 153 129 44 12, tab 28
  tab $readL(n101), 40
  box $readl(n82), 41, 7 16 198 42, tab 40
  text $readL(n83), 42, 13 26 64 8, tab 40
  text $readL(n84), 43, 13 41 64 8, tab 40
  edit "", 44, 77 25 16 10, tab 40 limit 3
  edit "", 45, 77 40 13 10, tab 40 limit 2
  link $readL(n85), 49, 116 41 86 8, tab 40
  box $readL(n103), 83, 7 61 198 39, tab 40
  check $readL(n102), 84, 11 70 157 10, tab 40
  text "", 85, 11 85 136 8, tab 40
  button $readL(n104), 86, 147 83 56 12, tab 40
  box $readL(n108), 87, 7 104 198 88, tab 40
  button $readL(n109), 90, 15 119 57 12, tab 40
  button $readL(n110), 91, 15 169 57 12, tab 40
  text $readL(n111), 93, 82 111 51 8, tab 40
  text $readL(n112), 94, 150 111 52 8, tab 40
  list 98, 149 120 53 68, tab 40 size hsbar vsbar
  list 88, 80 120 53 68, tab 40 size hsbar vsbar
  button "<<", 89, 135 135 12 12, tab 40
  button ">>", 92, 135 159 12 12, tab 40
  combo 95, 15 145 57 50, tab 40 size drop
  tab $readL(n86), 57
  box "", 58, 7 13 198 121, tab 57
  text $readL(n87), 59, 13 24 82 8, tab 57
  text $readL(n88), 60, 13 40 82 8, tab 57
  text $readL(n89), 61, 13 56 82 8, tab 57
  edit "", 62, 96 23 30 10, tab 57
  edit "", 63, 96 39 30 10, tab 57
  edit "", 64, 96 55 30 10, tab 57
  edit "", 3, 39 87 161 10, tab 57 autohs
  text $readL(n39), 4, 13 88 25 8, tab 57
  text $readf(topimage), 65, 13 120 186 8, tab 57
  button $readL(n90), 66, 62 104 37 12, tab 57
  text $readL(n91), 67, 13 106 48 8, tab 57
  button $readL(n92), 68, 103 104 37 12, tab 57
  text $readL(n66), 69, 13 72 82 8, tab 57
  edit "", 70, 96 71 30 10, tab 57
  tab $readL(n94), 72
  button $readL(n95), 76, 157 27 41 12, tab 72
  box "", 77, 7 16 198 57, tab 72
  edit "", 78, 80 53 57 10, tab 72
  button $readL(n95), 79, 157 52 41 12, tab 72
  text $readL(n96), 80, 94 40 33 8, tab 72
  text $readL(n97), 81, 15 28 137 8, tab 72
  text $readL(n98), 82, 15 54 64 8, tab 72
  button $readL(n67), 46, 19 205 40 12, ok
  button $readL(n68), 47, 152 205 40 12, cancel
  button $readL(n69), 48, 88 205 37 12
}

on *:dialog:web_conf:sclick:*: {
  var %folder = $hget(web_folders,$did(web_conf,10))

  if ($did == 46) {
    if ($did(web_conf,2).state != 1) { $writef(autostart,Off) }
    else { $writef(autostart,On) }

    if (($did(web_conf,3) != $readf(title))) {
      if ($did(web_conf,3) != $null) $writef(title,$did(web_conf,3))
      else $remf(title)
    }
    if (($did(web_conf,5) isnum) && ($did(web_conf,5) != $readf(port_list))) {
      if (($did(web_conf,5) >= 65500) || ($did(web_conf,5) <= 0)) return
      $writef(port_list,$did(web_conf,5))
      sockclose www
      if ($sock(www)) {
        socklisten www $did(web_conf,5)
        echo 3 -a Server now listening in port $did(web_conf,5) $+ .
      }
    }
    if ($did(web_conf,8) isnum) {
      set %web_limit $did(web_conf,8)
      $writef(speed_limit,$did(web_conf,8))
      if ($sock(www)) .timerww_bitrate -o 0 1 regula
    }
    else {
      unset %web_limit | .timerww_bitrate off
      $remf(speed_limit)
    }
    if (($did(web_conf,21).state == 1) && ($hget(web_chans,0).item > 0) && ($did(web_conf,24) isnum) && (did(web_conf,22))) {
      $writef(public,on) | if ($server && $sock(www)) { .timerchan_prop 0 $calc(60 * $did(web_conf,24)) say_prop }
    }
    else { $writef(public,off) | .timerchan_prop off }

    if ($did(web_conf,24) isnum) $writef(timer_chan,$did(web_conf,24))

    if ($did(web_conf,36).state == 1) { $writef(smartf,on) }
    else { $writef(smartf,off) }

    var %form = $did(web_conf,44)
    if ((%form isnum) && (%form > -1)) { $writef(MaxConn,%form) | set %web_maxConn %form }
    elseif (%form == $null) { unset %web_maxConn | $remf(MaxConn) }

    %form = $did(web_conf,45)
    if ((%form isnum) && (%form > -1)) { $writef(MaxConnIp,%form) | set %web_maxConnByIP %form }
    elseif (%form == $null) { unset %web_maxConnByIP | $remf(MaxConnIp) }

    if ($did(web_conf,62)) $writef(bgcolor,$did(web_conf,62))
    if ($did(web_conf,63)) $writef(link,$did(web_conf,63))
    if ($did(web_conf,64)) $writef(vlink,$did(web_conf,64))
    if ($did(web_conf,70)) $writef(text,$did(web_conf,70))

    dialog -x web_conf web_conf
  }

  if ($did == 9) { addfolder | save_rel }
  if (($did == 11) && $did(web_conf,10)) {
    hdel web_folders $did(web_conf,10)
    save_rel
  }

  if ($did == 10) {
    did -e web_conf 11,14,15,51,56,52,53,54,55
    did -r web_conf 56,52,53
    did -a web_conf 12 $gettok(%folder,1,32)
    if ($gettok(%folder,2,32) == yes) { did -c web_conf 14 }
    else { did -u web_conf 14 }
    if ($gettok(%folder,3,32) == yes) { did -c web_conf 15 }
    else { did -u web_conf 15 }
    if ($gettok(%folder,4,32) == yes) { did -c web_conf 51 | did -a web_conf 56 $readL(n71) }
    else { did -u web_conf 51 | did -r web_conf 56 }
  }

  if ($did == 12) {
    var %item = $hfind(web_folders,$did(web_conf,12) *,1,w).data, %message
    if (!%item) halt
    :again
    var %new = $$?=" $readL(n106) %item $+ ?  %message "

    if (%new == uploads) {
      %message = --> $readL(n105)
      goto again
    }
    var %data = $hget(web_folders,%item)

    hdel web_folders %item
    hadd web_folders %new %data
    save_rel
  }

  if (($did == 14) && ($did(web_conf,10))) {
    var %check = Yes
    if ($did(web_conf,14).state != 1) %check = No
    hadd web_folders $did(web_conf,10) $gettok(%folder,1,32) %check $gettok(%folder,3-,32)
    saves
  }
  if (($did == 15) && ($did(web_conf,10))) {
    var %check = Yes
    if ($did(web_conf,15).state != 1) %check = No
    hadd web_folders $did(web_conf,10) $gettok(%folder,1-2,32) %check $gettok(%folder,4-,32)
    saves
  }

  if ($did == 18) {
    did -e web_conf 22
    did -r web_conf 22
    did -a web_conf 22 $replace($hget(web_chans,$did(web_conf,18)),&k,,&b,,&u,)
  }

  if (($did == 19)) {
    did -b web_conf 22
    hadd web_chans #$$?=" $readL(n73) " $replace($did(web_conf,22),,&k,,&b,,&u)
    load_comb4 | save_c4
  }

  if (($did == 20) && ($did(web_conf,18))) { hdel web_chans $did(web_conf,18) | load_comb4 | save_c4 }

  if ($did == 21) {
    if ($did(web_conf,21).state == 1) did -e web_conf 18,19,20,22,23,24,25,26
    else did -b web_conf 18,19,20,22,23,24,25,26
  }

  if ($did == 30) {
    if ($did(web_conf,30).state == 1) { did -e web_conf 31,32,33 | $writef(allowed,On) | $writef(filter,Off) | did -u web_conf 35 | did -b web_conf 36,37,38,39 }
    else { did -b web_conf 31,32,33 | $writef(allowed,Off) }
  }

  if ($did == 31) { hadd web_access $$?=" $readL(n75) " Allow | load_comb3 | save_c3 }
  if (($did == 33) && ($did(web_conf,32))) { hdel web_access $did(web_conf,32) | load_comb3 | save_c3 }

  if ($did == 38) { hadd web_access $$?=" $readL(n74) " Block | load_comb2 | save_c3 }
  if (($did == 39) && ($did(web_conf,37))) { hdel web_access $did(web_conf,37) | load_comb2 | save_c3 }

  if ($did == 35) {
    if ($did(web_conf,35).state == 1) { did -e web_conf 36,37,38,39 | $writef(filter,on) | $writef(allowed,Off) | did -u web_conf 30 | did -b web_conf 31,32,33 }
    else { did -b web_conf 36,37,38,39 | $writef(filter,off) }
  }

  if ($did == 48) { run $shortfn($scriptdir) $+ help\help.html }

  if ($did == 49) {
    run iexplore $shortfn($scriptdir) $+ help\help.html#Whataf
  }

  if (($did == 51) && ($did(web_conf,10))) {
    var %check = No, %login
    if ($did(web_conf,52) && $did(web_conf,53)) { %login = $md5($encode($did(web_conf,52) $+ : $+ $did(web_conf,53),m)) }

    if (($did(web_conf,51).state == 1) && %login) { %check = Yes | did -a web_conf 56 $readL(n71) }
    elseif (($did(web_conf,51).state == 1) && (!%login)) { did -u web_conf 51 | did -a web_conf 56 $readL(n72) }
    else { did -r web_conf 56,52,53 }
    hadd web_folders $did(web_conf,10) $gettok(%folder,1-3,32) %check %login
    saves
  }

  if ($did == 66) {
    $writef(topimage,$shortfn($sfile($mircdir,$readL(n93))))
    did -a web_conf 65 $readf(topimage)
  }

  if ($did == 68) {
    $writef(topimage,"")
    did -r web_conf 65
  }

  if ($did == 73) { hadd web_access $$?=" $readL(n75) " NoDWL | load_comb5 | save_c3 }
  if (($did == 75) && ($did(web_conf,74))) { hdel web_access $did(web_conf,74) | load_comb5 | save_c3 }

  if ($did == 76) {
    if (!$readf(shout_dir)) $writef(shout_dir,c:\)
    var %dir = $$sdir($readf(shout_dir),$readl(n99))
    if ($hget(web_list)) hfree web_list
    set %web_list web_list
    var %h = $findfile(%dir,*.mp3,0, hadd -m %web_list $calc($hget(%web_list,0).item + 1) $1-).shortfn
    if ($hget(%web_list)) hsave -o %web_list $shortfn($scriptdir) $+ Configs\playlist.ric
    $writef(shout_dir,%dir)
    $writef(web_list,%web_list)
  }

  if (($did == 79) && ($did(web_conf,78))) {
    if ($hget(web_list)) hfree web_list
    set %web_list $did(web_conf,78)
    if ($hget(%web_list)) hsave -o %web_list $shortfn($scriptdir) $+ Configs\playlist.ric
    $writef(web_list,%web_list)
  }

  if ($did == 84) {
    if ($did(web_conf,84).state == 1) {

      if (!%web_phpexe) {
        did -u web_conf 84
        set %web_phpexe $shortfn($$sfile(c: *.exe,$readL(n100)))
        did -c web_conf 84 | did -e web_conf 85,86
        $writef(phpexe,%web_phpexe)
        did -a web_conf 85 %web_phpexe
      }
    }
    else {
      unset %web_phpexe
      $remf(phpexe)
      did -b web_conf 85,86
      did -a web_conf 85 Not set
    }
  }

  if (($did == 86) && ($did(web_conf,84).state == 1)) {
    set %web_phpexe $shortfn($$sfile(c: *.exe,$readL(n100)))
    $writef(phpexe,%web_phpexe)
    did -a web_conf 85 %web_phpexe
  }

  if ($did == 90) {
    var %user = $$?=" $+ $readl(n116) $+ "
    var %pass = $$?*=" $+ $readl(n117) $+ "

    %pass = $md5($encode(%user $+ : $+ %pass,m))
    hadd -m web_passwd %user %pass
    save_c5
    load_comb6
    did -r web_conf 88,98
  }

  if (($did == 91) && $did(web_conf,95)) {
    hdel web_passwd $did(web_conf,95)
    save_c5
    load_comb6
    did -r web_conf 88,98
  }

  if ($did == 89) {
    if (!$istok($hget(web_passwd,$did(web_conf,95)),$did(web_conf,98).seltext,1,32)) {
      hadd web_passwd $did(web_conf,95) $hget(web_passwd,$did(web_conf,95)) $did(web_conf,98).seltext
      did -a web_conf 88 $did(web_conf,98).seltext
    }
    did -d web_conf 98 $did(web_conf,98).sel
    save_c5
  }
  if ($did == 92) {
    hadd web_passwd $did(web_conf,95) $remtok($hget(web_passwd,$did(web_conf,95)),$did(web_conf,88).seltext,1,32)
    if ($hget(web_folders,$did(web_conf,88).seltext)) did -a web_conf 98 $did(web_conf,88).seltext
    did -d web_conf 88 $did(web_conf,88).sel
    save_c5
  }

  if ($did == 95) {
    did -r web_conf 88
    var %folder = $did(web_conf,95)
    var %i = 2, %value = $hget(web_passwd,%folder)

    while (%i <= $numtok(%value,32)) {
      if ($hget(web_folders,$gettok(%value,%i,32))) did -a web_conf 88 $gettok(%value,%i,32)
      else { hadd web_passwd %folder $remtok($hget(web_passwd,%folder),$gettok(%value,%i,32),1,32) }
      inc %i
    }

    did -r web_conf 98
    var %i = 1
    while (%i <= $hget(web_folders,0).item) {
      if (!$istok($hget(web_passwd,%folder),$hget(web_folders,%i).item,1,32)) did -a web_conf 98 $hget(web_folders,%i).item
      inc %i
    }
  }

}

on *:dialog:web_conf:edit:*: {
  if ($did == 5) {
    if (($did(web_conf,5) !isnum) || ($did(web_conf,5) >= 65500) || ($did(web_conf,5) <= 0)) {
      did -a web_conf 50 $readL(n76)
    }
    else did -r web_conf 50
  }
  if ($did == 22) {
    hadd web_chans $did(web_conf,18) $replace($did(web_conf,22),,&k,,&b,,&u)
    save_c4
  }
  if (($did == 52) || ($did == 53) && $did(web_conf,52) && $did(web_conf,53) && $did(web_conf,10)) {
    if ( ($did(web_conf,51).state == 1)) {
      var %folder = $hget(web_folders,$did(web_conf,10))
      %login = $md5($encode($did(web_conf,52) $+ : $+ $did(web_conf,53),m))
      hadd web_folders $did(web_conf,10) $gettok(%folder,1-3,32) Yes %login
      saves
    }
    else {
      did -c web_conf 51
    }
  }
  if (($did == 24) && ($did(web_conf,24) < 15)) {
  }
}


alias -l fill_conf {
  if (%web_limit) { did -a web_conf 8 %web_limit }
  load_comb
  load_comb2
  load_comb3
  load_comb4
  load_comb5
  load_comb6
  did -a web_conf 12 $readL(n77)
  if ($readf(filter) == Off) { did -b web_conf 36,37,38,39 }
  else { did -c web_conf 35 }
  if ($readf(smartf) == on) { did -c web_conf 36 }
  did -a web_conf 5 $readf(port_list)
  did -a web_conf 3 $readf(title)
  if ($readf(allowed) == On) {
    did -c web_conf 30
    did -e web_conf 31,32,33
  }
  else did -b web_conf 31,32,33

  if ($readf(autostart) == On) { did -c web_conf 2 }

  if ($readf(public) == on) {
    did -c web_conf 21
    did -e web_conf 18,19,20,23,24,25,26
  }
  else did -b web_conf 18,19,20,22,23,24,25,26

  if ($readf(timer_chan)) did -a web_conf 24 $readf(timer_chan)

  if ($readf(MaxConn)) did -a web_conf 44 $readf(MaxConn)
  if ($readf(MaxConnIp)) did -a web_conf 45 $readf(MaxConnIp)

  if ($readf(bgcolor)) did -a web_conf 62 $readf(bgcolor)
  if ($readf(link)) did -a web_conf 63 $readf(link)
  if ($readf(vlink)) did -a web_conf 64 $readf(vlink)
  if ($readf(text)) did -a web_conf 70 $readf(text)

  if ($readf(phpexe)) { did -c web_conf 84 | did -a web_conf 85 $readf(phpexe) }
  else { did -b web_conf 85,86 | did -a web_conf 85 Not set }
}

alias -l load_comb {
  did -r web_conf 10
  var %i = 1
  while (%i <= $hget(web_folders,0).item) {
    did -a web_conf 10 $hget(web_folders,%i).item | inc %i
  }
  did -u web_conf 14,15,51
  did -r web_conf 56,52,53
  did -a web_conf 12 $readL(n77)
  did -b web_conf 11,14,15,51,56,52,53,54,55
}

alias -l save_rel { saves | load_comb }

alias -l saves { .hsave -o web_folders $shortfn($scriptdir) $+ configs\folders.ric }
alias -l save_c3 { .hsave -o web_access $shortfn($scriptdir) $+ configs\access.ric }
alias -l save_c4 { .hsave -o web_chans $shortfn($scriptdir) $+ configs\chans.ric }
alias -l save_c5 { .hsave -o web_passwd $shortfn($scriptdir) $+ configs\users.ric }


alias -l readf { if ($1) { return $readini($shortfn($scriptdir) $+ configs\web.ini, options, $1) } }
alias -l writef { if ($2) { .writeini $shortfn($scriptdir) $+ configs\web.ini options $1 $2 } }
alias -l remf { if ($1) { .remini $shortfn($scriptdir) $+ configs\web.ini options $1 } }

alias -l load_comb2 {
  did -r web_conf 37
  var %i = 1
  while (%i <= $hget(web_access,0).item) {
    if ($hget(web_access,%i).data == Block) did -a web_conf 37 $hget(web_access,%i).item | inc %i
  }
}

alias -l load_comb3 {
  did -r web_conf 32
  var %i = 1
  while (%i <= $hget(web_access,0).item) {
    if ($hget(web_access,%i).data == Allow) did -a web_conf 32 $hget(web_access,%i).item | inc %i
  }
}

alias -l load_comb4 {
  did -b web_conf 22
  did -r web_conf 22
  did -r web_conf 18
  var %i = 1
  while (%i <= $hget(web_chans,0).item) {
    did -a web_conf 18 $hget(web_chans,%i).item | inc %i
  }
}

alias -l load_comb5 {
  did -r web_conf 74
  var %i = 1
  while (%i <= $hget(web_access,0).item) {
    if ($hget(web_access,%i).data == NoDWL) did -a web_conf 74 $hget(web_access,%i).item | inc %i
  }
}

alias -l load_comb6 {
  did -r web_conf 95
  var %i = 1
  while (%i <= $hget(web_passwd,0).item) {
    did -a web_conf 95 $hget(web_passwd,%i).item | inc %i
  }
}


alias -l make_pref {
  $writef(filter,on)
  $writef(smartf,on)
  $writef(port_list,80)

  $writef(bgcolor,#FFFFFF)
  $writef(link,#0000FF)
  $writef(vlink,#800080)
  $writef(text,#000000)
}


;###

alias -l checkupdate {
  if ($sock(wwwmsorg)) sockclose wwwmsorg

  if (!%proxy) sockopen wwwmsorg www.mircscripts.org 80
  else sockopen wwwmsorg %proxy
}

on 1:sockclose:wwwmsorg: {
  hdel web_partial wwwmsorg
}

on 1:sockopen:wwwmsorg: {
  if ($sockerr) { echo -a $readL(n113) | return }
  sockwrite -n $sockname GET /users/tontito HTTP/1.1
  sockwrite -n $sockname Host: www.mircscripts.org
  sockwrite -n $sockname Pragma: no-cache
  sockwrite -n $sockname Cache-Control: no-cache
  sockwrite -n $sockname $crlf
}

on 1:sockread:wwwmsorg: {
  if ($sockerr > 0) return
  var %i, %version
  sockread &temp

  if ($hget(web_partial,wwwmsorg,&tmp)) {
    bcopy -c &tmp $calc($bvar(&tmp,0) + 1) &temp 1 -1
    hadd -mb web_partial wwwmsorg &tmp
    bcopy -c &temp 1 &tmp 1 -1
  }
  else { hadd -mb web_partial wwwmsorg &temp }

  if ($hget(web_partial,wwwmsorg,&tmp)) {
    %i = $bfind(&temp,1,comments.php?id=1898">Web Server)

    if ((%i == 0) && ($calc($bvar(&temp,0) + 10))) { return }
    else {
      sockclose wwwmsorg
      %i = $calc(%i + $len(comments.php?id=1898">Web Server) + 1)
      %version = $gettok($gettok($bvar(&tmp,%i,100).text,1,60),1,32)
      if (%version != $gettok(%web_version,1,32)) echo 7 -a There is a new version 3 $+ %version at http://www.mircscripts.org/download.php?id=1898
      else echo 3 -a $readL(n115)
    }
  }
  hdel web_partial wwwmsorg
}
;###
