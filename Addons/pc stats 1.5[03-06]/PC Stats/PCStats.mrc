on 1:LOAD: {
  if ($version < 6) {
    echo -a PCS TATS: 6[1PC Stats6]1 You need a version newer than $version
    echo -a PC STATS: 6[1PC Stats6]1 unloading...
    .unload $shortfn($scriptdirpcstats.mrc)
  }
  else {
    echo -a PC STATS: 6[1PC Stats6]1 Sucessfully Loaded!
    echo -a PC STATS: 6[1PC Stats6]1 type /pcstats or run it from menubar or status menu
  }
}
alias gethwnd {
  var %c = 0
  var %get = $dll($sysdll2,getFirstProcess,.)
  if ($1 isin %get) { return $gettok(%get,1,9) | goto done }
  while %get != 0 {
    inc %c
    var %get = $dll($sysdll2,getNextProcess,.)
    if ($1 isin %get) { return $gettok(%get,2,9) | goto done }
  }
  :done
}
alias pcstats { echo -a 6[1PC Stats6]1 Loading... Please wait | dialog -md pcstats pcstats }
alias sysdll { return " $+ $scriptdirdll/moo.dll" }
alias -l sysdll2 { return " $+ $scriptdirdll/procs.dll" }
alias -l sysdll3 { return " $+ $scriptdirdll/ProcInfo.dll" }
alias -l mdx { return " $+ $scriptdirdll/mdx.dll" }
alias -l mdx.load {
  dll $mdx SetMircVersion $version
  dll $mdx MarkDialog $dname
}
alias -l ctlgen { return $scriptdirdll/ctl_gen.mdx }
alias -l views { return $scriptdirdll/views.mdx }
alias -l white { return $rgb(255,255,255) }
alias -l grey { return $rgb(200,200,200) }
dialog run {
  title "Run..."
  size -1 -1 122 45
  option dbu
  button "OK", 2, 82 29 37 12, ok
  edit "", 3, 3 14 116 10
  text "Type the process path you want to run ", 4, 3 3 114 8
  button "Cancel", 5, 42 29 37 12, cancel
}
on 1:dialog:run:*:*: {
  if ($devent == init) {
    mdx.load
    dll $mdx SetDialog run style title
    dll $mdx SetDialog run bgcolor $rgb(255,255,255)
    dll $mdx SetFont 2,3,4,5 + 13 0 tahoma
    dll $mdx SetBorderStyle 3 border
    dll $mdx SetBorderStyle 2,5 staticedge
    dll $mdx SetColor 4 textbg $rgb(255,255,255)
    dll $mdx SetColor 4 background $rgb(255,255,255)
  }
  elseif ($devent == sclick) {
    if ($did == 2) {
      run $did(3)
    }
    else { halt }
  }
}
dialog cls {
  title "Close Process"
  size -1 -1 123 32
  option dbu
  text "Select a process of the list...", 1, 4 3 113 8
  button "OK", 2, 40 17 37 12,ok
}
on 1:dialog:cls:*:*: {
  mdx.load
  dll $mdx SetDialog cls style title
  dll $mdx SetDialog cls bgcolor $rgb(255,255,255)
  dll $mdx SetFont 1,2 + 13 0 tahoma
  dll $mdx SetBorderStyle 2 staticedge
  dll $mdx SetColor 1 textbg $rgb(255,255,255)
  dll $mdx SetColor 1 background $rgb(255,255,255)
}

alias uptimez return $uptime(server,1)
alias chanz return $chan(0)
alias diskz {
  set %disk $remove($did(8).seltext,:)
  set %free $disk(%disk).free
  set %freeGB $calc(%free / 1024 / 1024 / 1024)
  set %freeMB $calc(%freeGB * 1024)
  set %total $iif($disk(%disk),$disk(%disk).size,0)
  set %totalGB $calc(%total / 1024 / 1024 / 1024)
  set %totalMB $calc(%totalGB * 1024)
  set %used $calc(%total - %free)
  set %usedGB $calc(%used / 1024 / 1024 / 1024)
  set %usedMB $calc(%usedGB * 1024)
  set %p100use $int($calc(%used * 100 / %total))
  did -ra $dname 10 $iif($int(%totalGB) != 0,$round(%totalGB,2) GB,$round(%totalMB,2) MB) ( $+ %total bytes)
  did -ra $dname 14 $iif(%free == $null,0 MB (0 bytes),$iif($int(%freeGB) != 0,$round(%freeGB,2) GB,$round(%freeMB,2) MB) ( $+ %free bytes))
  did -ra $dname 25 $iif($int(%usedGB) != 0,$round(%usedGB,2) GB,$round(%usedMB,2) MB) ( $+ %used bytes)
  did -ra $dname 12 %p100use 0 100
  did -ra $dname 24 $iif(%p100use == $null,0,%p100use) $+ $chr(37)
  unset %disk, %free, %freeGB, %freeMB, %used, %usedGB, %usedMB, %total, %totalGB, %totalMB, %p100use
}

dialog pcstats {
  title "PC Stats v1.5"
  size -1 -1 662 468
  option pixels notheme
  icon "dll/pc.ico", 0
  text "Operating System:", 1, 9 86 107 16
  text "", 2, 23 101 311 16
  text "Uptime:", 5, 23 117 37 16
  text "", 6, 67 117 267 16
  text "Processor:", 19, 17 23 56 16
  text "", 20, 82 23 238 16
  text "Disk:", 7, 9 152 37 16
  combo 8, 52 150 53 100, size drop
  text "Total Size:", 9, 117 152 60 16
  text "0 MB (0 bytes)", 10, 181 152 327 16
  text "Used:", 11, 23 175 43 16, right
  text "", 12, 23 197 217 26
  text "Free:", 13, 259 175 34 16, right
  text "0 MB (0 bytes)", 14, 296 175 179 16
  text "Memory:", 15, 9 238 54 16
  text "CPU:", 16, 9 7 38 16
  text "", 22, 23 42 217 26
  text "", 23, 254 43 64 26
  text "0%", 24, 254 197 64 26
  text "0 MB (0 bytes)", 25, 70 175 173 16
  text "Used:", 26, 23 257 43 16, right
  text "Free:", 27, 259 257 34 16
  text "", 28, 296 257 179 16
  text "", 29, 70 257 181 16
  text "", 30, 23 275 217 26
  text "", 31, 254 275 64 26
  text "Total:", 32, 119 238 33 16
  text "", 33, 160 238 212 16
  text "", 34, -147 77 982 3
  text "", 35, -147 142 982 3
  text "", 36, -160 229 982 3
  text "", 37, -165 305 982 3
  check "Auto-Refresh", 38, 445 438 125 24, push
  text "Processes running:", 3, 9 312 137 16
  list 40, 10 336 147 62, size
  text "", 4, -166 428 982 3
  text "", 41, 167 304 3 127
  text "mIRC Info:", 42, 178 312 54 16
  text "Nick:", 43, 182 334 69 16, right
  text "Connections:", 44, 182 349 69 16, right
  text "Channels:", 45, 182 379 69 16, right
  text "Active Server:", 46, 182 364 69 16, right
  text "Uptime:", 47, 182 394 69 16, right
  text "", 48, 256 334 153 16
  text "", 49, 256 349 153 16
  text "", 50, 256 364 153 16
  text "", 51, 256 379 153 16
  text "", 52, 256 394 153 16
  button "Close", 53, 573 438 75 24, ok
  text "", 54, 11 437 150 24
  text "PC Stats v1.5 by FoLKeN^", 39, 366 439 75 24
  button "End Process", 55, 10 401 76 18
  text "", 56, 348 -34 3 177
  text "Screen:", 57, 358 5 45 16
  text "Resolution:", 58, 371 19 66 16
  text "", 59, 448 19 127 16
  text "Color depth:", 60, 370 32 66 16
  text "", 61, 448 32 127 16
  text "", 62, 418 306 3 127
  text "Name:", 63, 441 334 46 16, right
  text "Dial-up Status:", 66, 428 312 73 16
  text "Speed", 67, 441 351 46 16, right
  text "In:", 68, 441 368 46 16, right
  text "Out:", 69, 441 385 46 16, right
  text "", 70, 493 334 156 16
  text "", 71, 493 351 156 16
  text "", 72, 493 385 156 16
  text "", 73, 493 368 156 16
  text "Send to:", 21, 168 444 43 16
  combo 64, 220 440 78 100, size drop
  button "Send!", 65, 300 438 58 25
  button "Run...", 74, 93 401 64 18
  text "Network Drives:", 17, 362 86 90 16
  text "net", 18, 382 105 269 16
  text "Graphics:", 75, 360 54 45 16
  text "gfx", 76, 410 54 243 16
}

on 1:dialog:pcstats:sclick:53: { .timersys off }
on 1:dialog:pcstats:init:*: {
  mdx.load
  dll $mdx SetDialog pcstats bgcolor $rgb(255,255,255)
  dll $mdx SetControlMDX 12,22,30 progressbar smooth > $ctlgen
  dll $mdx SetControlMDX 40 listview list flatsb sortascending > $views
  dll $mdx SetColor 1,7,16,15,17,3,42,57,66,75 text $rgb(0,0,255)
  dll $mdx SetColor 54 text $rgb(255,0,0)
  dll $mdx SetBorderStyle 12,22,30 border
  dll $mdx SetBorderStyle 40 windowedge
  dll $mdx SetBorderStyle 38,53,55,65,74 staticedge
  var %p = 0
  while %p < 76 {
    inc %p
    dll $mdx SetColor $dname %p textbg $white
    dll $mdx SetColor $dname %p background $white 
    dll $mdx SetFont $dname %p + 13 400 tahoma
    dll $shortfn($scriptdirdll\hos.dll) RemoveTheme $dname %p
  }
  dll $mdx SetColor $dname 4,41,34,35,36,37,56,62 textbg $grey
  dll $mdx SetColor $dname 4,41,34,35,36,37,56,62 background $grey
  did -a pcstats 12,22,30 BarColor $grey
  did -a pcstats 12,22,30 BGColor $white
  dll $mdx SetFont 23,24,31 + 24 600 verdana
  dll $mdx SetColor 23,24,31 text $grey
  dll $mdx SetFont 54,39 + 12 0 tahoma

  var %p = 0
  var %abc = abcdefghijklmnopqrstuvwxyz
  while %p < $len(%abc) {
    inc %p
    var %disk = $mid(%abc,%p,1)
    if ($disk(%disk) == $true) { did -a pcstats 8 %disk $+ : }  
  }
  did -c pcstats 8 1 | diskz

  did -a pcstats 64 All
  did -a pcstats 64 Myself
  did -a pcstats 64 All Chans
  did -a pcstats 64 All Queries
  did -a pcstats 64 -------------
  var %t = 0
  while %t < $chan(0) {
    inc %t
    did -a pcstats 64 $chan(%t)
  }
  did -a pcstats 64 -------------
  var %t = 0
  while %t < $query(0) {
    inc %t
    did -a pcstats 64 $query(%t)
  }
  did -c pcstats 64 1

  load.sys
  load.procs
  echo -a 6[1PC Stats6]1
}
on 1:Dialog:pcstats:sclick:38: {
  if ($did(38).state == 1) { .timersys 0 1 load.sys | did -ra $dname 54 Note: Processes list doesn't refresh. }
  else { .timersys off | did -r $dname 54 }
}
on 1:dialog:pcstats:sclick:8: { diskz }
alias load.procs {
  did -r pcstats 40
  set %procs $nopath($gettok($dll($sysdll2,getFirstProcess,_),1,9))
  while %procs != 0 {
    set %procs $nopath($gettok($dll($sysdll2,getNextProcess,_),1,9))
    did -a pcstats 40 %procs
  }
}
alias load.sys {
  var %cpuuse = $mid($dll($sysdll3,GetCpuUsage,.),1,2)
  if ($dll($sysdll3,GetCpuVendor,.) != UNKNOWN) {
    did -ra pcstats 22  %cpuuse 0 100
    did -ra pcstats 20 $remove($cpu(processor),1-)
    did -ra pcstats 23 %cpuuse $+ $chr(37) 
  }
  else {
    did -ra pcstats 20 <unknown>
    did -ra pcstats 22  %cpuuse 0 100
    did -ra pcstats 23 %cpuuse $+ $chr(37)
  }
  did -ra pcstats 2 $dll($scriptdirdll/moo.dll,osinfo,_)
  did -ra pcstats 6 $uptime(system,1)

  did -ra pcstats 18 $iif($dll($sysdll,netcapacity,_),$dll($sysdll,netcapacity,_),Not Detected)

  did -ra pcstats 76 $iif($dll($sysdll,gfxinfo,_) != -1,$dll($sysdll,gfxinfo,_),Don't know...)

  var %umem = $calc($dll($sysdll3,GetRam,memory) - $dll($sysdll3,GetRam,memoryavail))
  did -ra pcstats 33 $round($calc($dll($sysdll3,GetRam,memory) / 1024),2) MB $+($chr(40),$calc($dll($sysdll3,GetRam,memory) * 1024) bytes,$chr(41))
  did -ra pcstats 30 $dll($sysdll3,GetRam,p100use) 0 100
  did -ra pcstats 31 $dll($sysdll3,GetRam,p100use) $+ $chr(37)
  did -ra pcstats 28 $round($calc($dll($sysdll3,GetRam,memoryavail) / 1024),2) MB ( $+ $calc($dll($sysdll3,GetRam,memoryavail) * 1024) bytes)
  did -ra pcstats 29 $round($calc(%umem / 1024),2) MB ( $+ $calc(%umem * 1024) bytes)

  did -ra pcstats 50 $iif(!$server,Not Connected,$scid($activecid).$server)
  did -ra pcstats 48 $me
  did -ra pcstats 49 $scon(0)
  did -ra pcstats 51 $iif(!$server,Not Connected,$scid($activecid).$chanz)
  did -ra pcstats 52 $iif(!$server,Not Connected,$scid($activecid).$uptimez)

  var %b = $cpu(screen).bit
  did -ra pcstats 59 $cpu(screen).res
  did -ra pcstats 61 %b $+($chr(40),$iif(4 isin %b,16 Colors),$iif(8 isin %b,256 Colors),$iif(16 isin %b,High Colors),$iif(24 isin %b,High Colors),$iif(32 isin %b,True Color),$chr(41))

  if ($cpu(connection) == none detected) {
    did -ra pcstats 70 Not Detected/Connected
    did -ra pcstats 71,72,73 -
  }
  else {
    did -ra pcstats 70 $cpu(connection).name
    did -ra pcstats 71 $cpu(connection).speed
    did -ra pcstats 72 $cpu(connection).in
    did -ra pcstats 73 $cpu(connection).out
  }
}
on 1:dialog:pcstats:sclick:55: {
  if ($did(40).seltext != $null) {
    dll $sysdll2 closeProcess $gethwnd($gettok($did(40).seltext,6,32))
    did -d pcstats 40 $did(40).sel
  }
  else {
    dialog -md cls cls
  }
}
on 1:dialog:pcstats:sclick:65: {
  var %sel = $did(64).seltext
  var %stats = 6[1PC Stats6]1 - 4[1OS4]7 $dll($sysdll,osinfo,_) - 4[1CPU4]7 $dll($sysdll3,GetCpuVendor,.) - $cpu(processor) - 4[1RAM4]7 $cpu(ram).used $+ MB/ $+ $cpu(ram).total $+ MB - 4[1Screen4]7 $cpu(screen).res $cpu(screen).bit 

  if (%sel == All) { 
    amsg %stats 
    echo -s %stats 
    var %o = 0
    while %o < $query(0) {
      inc %o
      .msg $query(%o) %stats
    }
  }
  elseif (%sel == Myself) { echo -a %stats }
  elseif (%sel == All Chans) { 
    var %o = 0
    while %o < $chan(0) {
      inc %o
      msg $chan(%o) %stats
    }
  }
  elseif (%sel == All Queries) { 
    var %o = 0
    while %o < $query(0) {
      inc %o
      msg $query(%o) %stats
    }
  }
  elseif (%sel == -------------) { halt }
  else {
    msg %sel %stats
  }
}
on 1:dialog:pcstats:sclick:74: { dialog -md run run }
alias cpu {
  if ($1 == processor) { 
    if ($prop == hz) { return $remove($gettok($dll($sysdll,cpuinfo,_),2,44),$chr(44)) }
    elseif ($prop == name) { var %a = $calc($numtok($dll($sysdll,cpuinfo,_),32) - 4) | return $remove($gettok($dll($sysdll,cpuinfo,_),1- %a,32),$chr(44)) }
    elseif ($prop == cache) { return $lower($gettok($dll($sysdll,cpuinfo,_),-3,32)) }
    elseif ($prop == load) { return $lower($remove($gettok($dll($sysdll,cpuinfo,_),-2,32),$chr(40))) }
    elseif ($prop == $null) { return $dll($sysdll,cpuinfo,_) }
    else { return $null }
  }
  if ($1 == ram) {
    if ($prop == used) { return $gettok($gettok($dll($sysdll,meminfo,_),2,32),1,47) }
    elseif ($prop == total) { return $remove($gettok($gettok($dll($sysdll,meminfo,_),2,32),2,47),mb) }
    elseif ($prop == free) { return $calc($cpu(ram).total - $cpu(ram).used) }
    elseif ($prop == per) { return  $remove($gettok($dll($sysdll,meminfo,_),3,32),$chr(40),$chr(41),%) }
    elseif ($prop == $null) { return $dll($sysdll,meminfo,_) }
    else { return $null }
  }
  if ($1 == connection) {
    if ($prop == name) { var %a = $calc($numtok($dll($sysdll,connection,_),32) - 8) | return $gettok($deltok($dll($sysdll,connection,_),1-2,32),1- %a,32)  }
    elseif ($prop == rate) { return $gettok($dll($sysdll,connection,_),-5,32) }
    elseif ($prop == in) { return $lower($remove($gettok($dll($sysdll,connection,_),-4,32),$chr(40))) }
    elseif ($prop == out) { return $lower($remove($gettok($dll($sysdll,connection,_),-2,32),$chr(40))) }
    elseif ($prop == $null) { return $dll($sysdll,connection,_) }  
    else { return $null }
  }
  if ($1 == screen) {
    if ($prop == res) { return $gettok($dll($sysdll,screeninfo,_),1,32) }
    elseif ($prop == bit) { return $gettok($dll($sysdll,screeninfo,_),2,32) } 
    elseif ($prop == $null) { return $sysdll,screeninfo,_) }
    else { return $null }  
  }
}
menu status,menubar {
  Tools
  .PC Stats 1.5: pcstats
}
