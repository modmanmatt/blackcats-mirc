dialog port {
  title "[i]:Port Scaner [v1.2]"
  size -1 -1 162 130
  option dbu
  box "", 1, 1 1 160 127
  list 2, 4 13 153 98, size
  text "Press Scan to start scannnig", 3, 11 6 140 7
  button "Exit", 4, 120 112 37 12, ok
  button "Scan", 5, 79 112 37 12
  button "Select Type", 6, 5 112 37 12
}
dialog tport {
  title "Ports Type"
  size -1 -1 52 61
  option dbu
  box "Show ...", 1, 1 1 50 45
  radio "All", 2, 5 8 40 10
  radio "Open", 3, 5 17 40 10
  radio "Close", 4, 5 26 40 10
  text "... ports", 5, 3 36 46 8, right
  button "OK", 6, 8 47 37 12, ok
}
alias -l _refresh { var %x 1 | echo -a %x | while (%x <= 2) { did -i eport 1 3 $readini($dir(port.c),port, $+ %x $+ ) | inc %x } }
alias -l ver return [v1.2]
alias -l dir return $scriptdir $+ $1
alias -l _dll return $dir(dll\ $+ $1 $+ )
alias -l ico return $dir(ico\ $+ $1 $+ )
alias _port if !$dialog(port) { dialog -m port port } | else { dialog -x port port }
alias tport if !$dialog(tport) { dialog -m tport tport } | else { dialog -x tport tport }
on *:dialog:tport:*:*: {
  if $devent = init {
    dll $_dll(mdx.dll) SetMircVersion $version
    dll $_dll(mdx.dll) MarkDialog $dname
    dll $_dll(mdx.dll) SetFont $dname 1,2,3,4,5,6 +a 12 400 Verdana
    dll $_dll(mdx.dll) SetBorderStyle $dname 6 clientedge
    did -c $dname $iif(%:port-type = all,2) $iif(%:port-type = open,3) $iif(%:port-type = close,4)
  }
  if $devent = sclick {
    if $did = 2 { set %:port-type all }
    if $did = 3 { set %:port-type open }
    if $did = 4 { set %:port-type close }
  }
}
on *:dialog:port:sclick:*: { if $did = 5 { scan } | if $did = 6 { tport } }
on *:dialog:port:init:*: { 
  dll $_dll(mdx.dll) SetMircVersion $version 
  dll $_dll(mdx.dll) MarkDialog $dname 
  dll $_dll(mdx.dll) SetFont $dname 1,2,3,4,5 +a 12 400 Verdana 
  dll $_dll(mdx.dll) SetBorderStyle $dname 4,5,6 clientedge 
  dll $_dll(mdx.dll) SetControlMDX $dname 2 listview rowselect report grid nosortheader flatsb > $_dll(views.mdx) 
  did -i $dname 2 1 headerdims 30 50 43 500 
  did -i $dname 2 1 headertext 0 0/1 $+ $chr(9) $+ Port $+ $chr(9) $+ +c State $+ $chr(9) $+ Description 
  did -i $dname 2 1 seticon list 0, $+ $ico(open.ico)
  did -i $dname 2 1 seticon list 0, $+ $ico(close.ico)
}
alias -l scan {
  if $dialog(port) {
    var %x 1 
    var %open 0
    var %close 0
    var %time $time
    did -r port 2
    while %x <= $readini($dir(port.c),port,0) {
      var %t $time
      var %port $readini($dir(port.c),port, $+ %x $+ )
      var %p $gettok(%port,1,32)
      var %desc $deltok(%port,1,32)
      if (%:port-type = all) { did -a port 2 +r $iif($portfree(%p),2,1) $iif($portfree(%p),2,1) $iif($portfree(%p),2,1) $chr(32) $+ $chr(9) $+ 0 0 0 %p $+ $chr(9) $+ 0 0 0 $iif($portfree(%p),Close,Open) $+ $chr(9) $+ 0 0 0 %desc | inc % $+ $iif($portfree(%p),close,open) }
      if (%:port-type = open) && !$portfree(%p) { did -a port 2 +r $iif($portfree(%p),2,1) $iif($portfree(%p),2,1) $iif($portfree(%p),2,1) $chr(32) $+ $chr(9) $+ 0 0 0 %p $+ $chr(9) $+ 0 0 0 $iif($portfree(%p),Close,Open) $+ $chr(9) $+ 0 0 0 %desc | inc % $+ $iif($portfree(%p),close,open) }
      if (%:port-type = close) && $portfree(%p) { did -a port 2 +r $iif($portfree(%p),2,1) $iif($portfree(%p),2,1) $iif($portfree(%p),2,1) $chr(32) $+ $chr(9) $+ 0 0 0 %p $+ $chr(9) $+ 0 0 0 $iif($portfree(%p),Close,Open) $+ $chr(9) $+ 0 0 0 %desc | inc % $+ $iif($portfree(%p),close,open) }
      did -ra port 3 $calc(%t - %time) ports/sec
      inc %x
    }
    did -ra port 3 Open: [ $iif(!%open,0,%open) ] Close: [ $iif(!%close,0,%close) ] Scanned [ $calc(%x - 1) ]
  }
}
menu menubar {
  -
  [i] $+ $chr(58) $+ Port-Scanner $ver
  .$iif($dialog(port),$style(2)) [Open] :_port
  .$iif(!$dialog(port),$style(2)) [Close] :_port 
  .-
  .[Unload]:var %x $input(Are you sure that you want to unload this addon?,552,[i]:Port-Scanner $ver $+ ) | if %x = $yes { .unload -rs $script }
  .[About]:run notepad $dir(readme.txt)
}
alias _xx_ {
  var %x 1
  while (%x <= $lines($dir(port.c))) {
    writeini $dir(portx.mrc) port %x $read($dir(port.c), %x)
    inc %x
  }
  writeini $dir(port.c) port 0 $lines(port.c)
}
