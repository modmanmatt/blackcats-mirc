dialog DM {
  title "Dialog Maker"
  size -1 -1 480 350
  option pixels
  icon $shortfn($scriptdir) $+ Data\Icons\DialogMaker.ico, 0
  box "", 6, 19 59 411 83
  radio "Button", 7, 24 74 100 20, push
  radio "Edit", 8, 124 74 100 20, push
  radio "Text", 9, 224 74 100 20, push
  radio "Link", 10, 324 74 100 20, push
  radio "Box", 11, 24 94 100 20, push
  radio "Scroll", 12, 124 94 100 20, push
  radio "Tab", 13, 224 94 100 20, push
  radio "Icon", 14, 324 94 100 20, push
  radio "Check", 15, 24 114 100 20, push
  radio "Radio", 16, 124 114 100 20, push
  radio "List", 17, 224 114 100 20, push
  radio "Combo", 18, 324 114 100 20, push
  radio "X", 56, 432 65 25 78, push
  list 2, -3 -3 485 32, size
  list 3, 0 330 480 20, size
  text "Name:", 66, 7 190 140 16, right
  edit "", 29, 150 188 225 19, autohs
  text "Titlebar Text:", 111, 7 215 140 16, right
  edit "", 26, 150 213 225 19, autohs
  edit "", 27, 150 235 50 20, autohs limit 5 center
  edit "", 28, 200 235 50 20, autohs limit 5 center
  edit "", 30, 260 235 50 20, autohs limit 4 center
  edit "", 47, 310 235 50 20, autohs limit 4 center
  text "Position and Size:", 55, 8 237 140 16, right
  check "Use DBU", 48, 84 263 120 19, push
  edit "", 1, 83 285 300 19, autohs
  button "Icon", 51, 263 263 120 19
}
on *:dialog:DM:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.dm.x) !== $null) && ($var.read(Options,dmo.pos.dm.y) !== $null) { dialog -s DM $var.read(Options,dmo.pos.dm.x) $var.read(Options,dmo.pos.dm.y) 480 350 }
  mdx SetControlMDX 21 TreeView haslines showsel linesatroot hasbuttons editlabels > $shortfn($scriptdir) $+ Data\Views.mdx
  mdx SetControlMDX 3 StatusBar > $shortfn($scriptdir) $+ Data\Bars.mdx
  mdx SetControlMDX 27,28,30,47 UpDown alignright edit numeric > $shortfn($scriptdir) $+ Data\Ctl_gen.mdx
  mdx SetFont 32,33 24 400 wingdings
  mdx SetFont 3 13 700 Tahoma
  mdx SetBorderStyle 3 windowedge
  mdx SetBorderStyle 1,26,29 border
  mdx SetBorderStyle 27,28,30,47 staticedge
  did -i DM 3 1 setparts 320 -1
  did -i DM 3 2 Ready
  did -i DM 3 3 No Project Loaded
  did -i DM 27,28 1 0 -1 9999 10 0:1,2:5,5:20
  did -i DM 30,47 1 0 0 9999 10 0:1,2:5,5:20
  var.set Variables Version 0.10
  var.set Variables Full_Version 0.1.0.0
  var.set Variables dm.id 1
  dialog -t DM Dialog Maker $var.read(Variables,Version)
  did -b DM 12,13
  dm.skin
  .signal Modules_DM
  if ($var.read(Options,dmo.explorer) == $null) { var.set Options dmo.explorer on }
  if ($var.read(Options,dmo.explorer.part) == $null) { var.set Options dmo.explorer.part Explorer }
  if ($var.read(Options,dmo.explorer.show_aliases) == $null) { var.set Options dmo.explorer.show_aliases on }
  if ($var.read(Options,dmo.explorer.show_dialogs) == $null) { var.set Options dmo.explorer.show_dialogs on }
  if ($var.read(Options,dmo.explorer.show_menus) == $null) { var.set Options dmo.explorer.show_menus on }
  if ($var.read(Options,dmo.show.tips) == $null) { var.set Options dmo.show.tips on }
  if ($var.read(Options,dmo.color.back) == $null) { var.set Options dmo.color.back 255_255_255 }
  if ($var.read(Options,dmo.color.text) == $null) { var.set Options dmo.color.text 0_0_0 }
  if ($var.read(Options,dmo.color.textbg) == $null) { var.set Options dmo.color.textbg 255_255_255 }
  if ($var.read(Options,dmo.font.name) == $null) { var.set Options dmo.font.name Fixedsys }
  if ($var.read(Options,dmo.font.size) == $null) { var.set Options dmo.font.size 13 }
  if ($var.read(Options,dmo.asc) == on) {
    if ($dialog(ce) == $null) {
      if ($var.read(Options,dmo.ceot) == on) { dialog -mod ce ce }
      else { dialog -md ce ce }
    }
  }
  if ($exists($shortfn($scriptdir) $+ Data\Updates\Updates.txt) == $false) { mkdir $shortfn($scriptdir) $+ Data\Updates\ }
  if ($var.read(Options,dmo.last.project) == on) {
    var.set Variables dm.file.test $var.read(Options,dmo.lpf)
    if ($var.read(Variables,dm.file.test) !== $null) {
      did -i DM 3 2 Visual Editor...
      var.set Variables dm.file $shortfn($var.read(Variables,dm.file.test))
      var.set Options dmo.file.last $nofile($var.read(Variables,dm.file.test))
      dm.ve
      if ($1 !== $null) { open.DM $1 }
      if ($1 == $null) { open.DM DialogMaker }
      did -i DM 3 2 Opening Project...
      did -ra DM 29 $var.read(Variables,dm.dn)
      did -ra DM 26 $var.read(Variables,dm.dt)
      did -i DM 27 1 $var.read(Variables,dm.dx) -1 9999 10 0:1,2:5,5:20
      did -i DM 28 1 $var.read(Variables,dm.dy) -1 9999 10 0:1,2:5,5:20
      did -i DM 30 1 $var.read(Variables,dm.dw) 0 9999 10 0:1,2:5,5:20
      did -i DM 47 1 $var.read(Variables,dm.dh) 0 9999 10 0:1,2:5,5:20
      did -ra DM 1 $var.read(Variables,dm.di)
      if ($var.read(Variables,dm.do) == DBU) { did -c DM 48 }
      if ($var.read(Variables,dm.di) !== $null) { did -ra DM 1 $var.read(Variables,dm.di) }
      if ($var.read(Variables,dm.dt) !== $null) { dialog -t VisualEditor Visual Editor - $var.read(Variables,dm.dt) }
      else { dialog -t VisualEditor Visual Editor }
      if ($var.read(Variables,File.Type) == $null) {
        if ($right($var.read(Variables,dm.file),2) == dm) { var.set Variables File.Type DialogMaker }
        if ($right($var.read(Variables,dm.file),2) == ds) { var.set Variables File.Type DialogStudio }
      }
      if ($dialog(ce)) { dm.ce }
      dm.build $var.read(Variables,File.Type)
      did -o DM.Loading 1 3 0 + 1 0 0 Controls $chr(9) OK (Controls: $calc(%dm.fi -1) $+ )
      did -a DM.Loading 2 2 0 4
      did -i DM 3 3 $nopath($longfn($var.read(Variables,dm.file))) ( $+ $bytes($file($var.read(Variables,dm.file)).size,k).suf $+ )

      did -o DM.Loading 1 4 0 + 1 0 0 Menus $chr(9) OK
      did -a DM.Loading 2 3 0 4
      if ($var.read(Variables,dm.fn) !== $null) {
        if ($exists($var.read(Variables,dm.fn)) == $true) { did -o DM.Loading 1 5 0 + 1 0 0 Code $chr(9) OK }
        else { dm.cnd | did -o DM.Loading 1 5 0 + 2 0 0 Code $chr(9) Repaired }
      }
      else { did -o DM.Loading 1 5 0 + 1 0 0 Code $chr(9) OK }
      did -a DM.Loading 2 4 0 4
      set %time2 $duration($time)
      did -o DM.Loading 1 6 0 + 0 0 0 Loading Time $chr(9) $duration($calc(%time2 - %time1))
      unset %time1
      unset %time2
      if ($var.read(Options,dmo.close.loading) == on) { dialog -x DM.Loading DM.Loading }
      else { .timerActive2 1 0 dialog -v DM.Loading DM.Loading }
    }
  }
  if ($var.read(Options,dmo.show.tips) == on) { dialog -md DM.Tips DM.Tips | .timerActive 1 0 dialog -v DM.Tips DM.Tips }
}
on *:dialog:dm:close:*:{
  if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.dm.x $dialog(dm).x | var.set Options dmo.pos.dm.y $dialog(dm).y }
  if ($var.read(Options,dmo.last.project) == on) { var.set Options dmo.lpf $var.read(Variables,dm.fn2) }
  if ($var.read(Variables,dm.file) !== $null) {
    if ($input(Save the project first?,y,Dialog Maker: Close) == $true) { dm.cnd }
  }
  dm.close
}
on *:dialog:dm:edit:26:if ($dialog(VisualEditor)) { dialog -t VisualEditor Visual Editor - $did(26) }
on *:dialog:dm:sclick:3:if ($did(3).sel == 3) { .echo -q $dm.open(DialogMaker,*.dm,Open Dialog Maker Project:) }
on *:dialog:dm:dclick:2:{
  if ($did(2).sel == 3) {
    dll $dm.pop New Open_Menu 32 32
    dll $dm.pop LoadImg Open_Menu 1 icon normal $shortfn($scriptdir) $+ Data\Icons\DialogMaker.ico
    dll $dm.pop LoadImg Open_Menu 2 icon normal $shortfn($scriptdir) $+ Data\Icons\DialogStudio.ico
    dll $dm.pop LoadImg Open_Menu 3 icon normal $shortfn($scriptdir) $+ Data\Dialog Grabber.exe
    dll $dm.pop AddItem Open_Menu 1 1 1 Dialog &Maker
    dll $dm.pop AddItem Open_Menu 2 2 2 Dialog &Studio
    if ($exists($shortfn($scriptdir) $+ Data\Dialog Grabber.exe) == $false) { dll $dm.pop AddItem Open_Menu 3 +Cd 3 3 Dialog &Grabber }
    else { dll $dm.pop AddItem Open_Menu 3 +C 3 3 Dialog &Grabber }
    var.set Temporary sel $gettok($dll($dm.pop,Popup,Open_Menu $mouse.dx $mouse.dy ),3,32)
    if ($var.read(Temporary,sel) = 1) { .echo -q $dm.open(DialogMaker,*.dm,Open Dialog Maker Project:) }
    if ($var.read(Temporary,sel) = 2) { .echo -q $dm.open(DialogStudio,*.ds,Open Dialog Studio Project:) }
    if ($var.read(Temporary,sel) = 3) { run $shortfn($scriptdir) $+ Data\Dialog Grabber.exe }
    var.unset Temporary sel
  }
  if ($did(2).sel == 8) {
    dll $dm.pop New DialogCode_Menu 32 32
    dll $dm.pop LoadImg DialogCode_Menu 1 icon normal $dm.icon(DialogCode)
    dll $dm.pop LoadImg DialogCode_Menu 2 icon normal $dm.icon(Copy)
    dll $dm.pop LoadImg DialogCode_Menu 3 icon normal $dm.icon(Save)
    if ($var.read(Options,dmo.language) !== $null) {
      dll $dm.pop AddItem DialogCode_Menu 1 1 1 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Dialog_Code,View)
      dll $dm.pop AddItem DialogCode_Menu 2 2 2 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Dialog_Code,Copy)
      dll $dm.pop AddItem DialogCode_Menu 3 3 3 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Dialog_Code,Save)
    }
    else {
      dll $dm.pop AddItem DialogCode_Menu 1 1 1 &View
      dll $dm.pop AddItem DialogCode_Menu 2 2 2 &Copy
      dll $dm.pop AddItem DialogCode_Menu 3 3 3 &Save
    }
    var.set Temporary sel $gettok($dll($dm.pop,Popup,DialogCode_Menu $mouse.dx $mouse.dy ),3,32)
    if ($var.read(Temporary,sel) = 1) {
      if ($var.read(Variables,dm.file) == $null) { .echo -q $dm.error(Before see dialog code please first create or open dialog!,dm.open,dm.code.view) }
      else { dm.code.view }
    }
    if ($var.read(Temporary,sel) = 2) {
      if ($var.read(Variables,dm.file) == $null) { .echo -q $dm.error(Before copy dialog code please first create or open dialog!,dm.open,dm.code.copy) }
      else { dm.code.copy }
    }
    if ($var.read(Temporary,sel) = 3) {
      if ($var.read(Variables,dm.file) == $null) { .echo -q $dm.error(Before export dialog code please first create or open dialog!,dm.open,dm.code.save) }
      else { dm.code.save }
    }
    var.unset Temporary sel
  }
}
on *:dialog:dm:sclick:2:{
  if ($did(2).sel == 2) {
    if ($?!="Create new dialog?" == $true) {
      var.unset Variables dm.file,dm.tf,dm.dn,dm.dt,dm.di,dm.do,dm.dx,dm.dy,dm.dw,dm,dh,dm.fn,dm.fn2
      if ($dialog(VisualEditor)) { dialog -x VisualEditor VisualEditor }
      if ($dialog(DM.Loading)) { dialog -x DM.Loading DM.Loading }
      did -r DM 26,29,1
      did -u DM 48
      did -i DM 27,28 1 0 -1 9999 10 0:1,2:5,5:20
      did -i DM 30,47 1 0 0 9999 10 0:1,2:5,5:20
      did -i DM 3 2 Ready
      did -i DM 3 3 No Project Loaded
    }
    if ($dialog(dm) !== $null) { dialog -v DM DM }
  }
  if ($did(2).sel == 3) { .echo -q $dm.open(DialogMaker,*.dm,Open Dialog Maker Project:) }
  if ($did(2).sel == 4) { dm.save }
  if ($did(2).sel == 6) {
    if ($dialog(ce) == $null) {
      if ($var.read(Options,dmo.ceot) == on) { dialog -mod ce ce }
      else { dialog -md ce ce }
    }
    else { dialog -v ce ce }
  }
  if ($did(2).sel == 7) {
    if ($var.read(Variables,dm.file) !== $null) {
      if ($dialog(dc) == $null) { dialog -md dc dc }
      else { dialog -v dc dc }
    }
    else { .echo -q $dm.error(Please open or create new project before use Code Editor!,dm.open,dm.file.dc) }
  }
  if ($did(2).sel == 8) {
    if ($var.read(Variables,dm.file) == $null) { .echo -q $dm.error(Before see dialog code please first create or open project!,dm.open,dm.code.view) }
    else { dm.code.view }
  }
  if ($did(2).sel == 10) {
    dll $dm.pop New Tools_Menu 32 32
    dll $dm.pop LoadImg Tools_Menu 1 icon normal $dm.icon(Options)
    dll $dm.pop LoadImg Tools_Menu 2 icon normal $dm.icon(Update)
    dll $dm.pop LoadImg Tools_Menu 3 icon normal $dm.icon(Modules)
    dll $dm.pop LoadImg Tools_Menu 4 icon normal $dm.icon(Language)
    dll $dm.pop LoadImg Tools_Menu 5 icon normal $dm.icon(Preview)
    if ($var.read(Options,dmo.language) !== $null) {
      dll $dm.pop AddItem Tools_Menu 1 1 1 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Tools,Options)
      dll $dm.pop AddItem Tools_Menu 2 2 2 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Tools,Update)
      dll $dm.pop AddItem Tools_Menu 3 3 3 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Tools,Modules)
      dll $dm.pop AddItem Tools_Menu 4 4 4 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Tools,Language_Editor)
      dll $dm.pop AddItem Tools_Menu 5 5 5 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Tools,Preview)
    }
    else {
      dll $dm.pop AddItem Tools_Menu 1 1 1 &Options
      dll $dm.pop AddItem Tools_Menu 2 2 2 &Update
      dll $dm.pop AddItem Tools_Menu 3 3 3 &Modules
      dll $dm.pop AddItem Tools_Menu 4 4 4 &Language Editor
      dll $dm.pop AddItem Tools_Menu 5 5 5 &Preview
    }
    var.set Temporary sel $gettok($dll($dm.pop,Popup,Tools_Menu $mouse.dx $mouse.dy ),3,32)
    if ($var.read(Temporary,sel) = 1) { if ($dialog(do) == $null) { dialog -md DO DO }
    else { dialog -v DO DO } }
    if ($var.read(Temporary,sel) = 2) { if ($dialog(du) == $null) { dialog -md du du }
    else { dialog -v du du } }
    if ($var.read(Temporary,sel) = 3) { if ($dialog(mod) == $null) { dialog -md MOD MOD }
    else { dialog -v MOD MOD } }
    if ($var.read(Temporary,sel) = 4) { if ($dialog(le) == $null) { dialog -md le le }
    else { dialog -v le le } }
    if ($var.read(Temporary,sel) = 5) {
      if ($dialog(le) == $null) {
        if ($var.read(Variables,dm.file) !== $null) { dm.preview }
        else { .echo -q $dm.error(Please open or create new project before see it's preview!,dm.open,dm.preview) }
      }
    }
    var.unset Temporary sel
  }
  if ($did(2).sel == 11) {
    if ($exists($shortfn($scriptdir) $+ Help.html) == $false) { .echo -q $dm.error(No help file found!) }
    else { run $shortfn($scriptdir) $+ Help.html }
  }
}
on *:dialog:dm:edit:27:{
  if ($dm.edit(dm,27) !== $null) && ($dialog(VisualEditor) !== $null) {
    var.set Variables dm.dx $dm.edit(dm,27)
    dialog -s VisualEditor $dm.edit(dm,27) $dm.edit(dm,28) $dm.edit(dm,30) $dm.edit(dm,47)
  }
  else { var.set Variables dm.dx $dm.edit(dm,27) }
}
on *:dialog:dm:edit:28:{
  if ($dm.edit(dm,28) !== $null) && ($dialog(VisualEditor) !== $null) {
    var.set Variables dm.dy $dm.edit(dm,28)
    dialog -s VisualEditor $dm.edit(dm,27) $dm.edit(dm,28) $dm.edit(dm,30) $dm.edit(dm,47)
  }
  else { var.set Variables dm.dy $dm.edit(dm,28) }
}
on *:dialog:dm:edit:30:{
  if ($dm.edit(dm,30) !== $null) && ($dialog(VisualEditor) !== $null) {
    var.set Variables dm.dw $dm.edit(dm,30)
    dialog -s VisualEditor $dialog(VisualEditor).x $dialog(VisualEditor).y $dm.edit(dm,30) $dm.edit(dm,47)
  }
  else { var.set Variables dm.dw $dm.edit(dm,30) }
}
on *:dialog:dm:edit:47:{
  if ($dm.edit(dm,47) !== $null) && ($dialog(VisualEditor) !== $null) {
    var.set Variables dm.dh $dm.edit(dm,47)
    dialog -s VisualEditor $dialog(VisualEditor).x $dialog(VisualEditor).y $dm.edit(dm,30) $dm.edit(dm,47)
  }
  else { var.set Variables dm.dh $dm.edit(dm,47) }
}
on *:dialog:dm:sclick:7:var.set Variables dm.control Button | did -i DM 3 2 Click on Visual Editor to place the button.
on *:dialog:dm:sclick:8:var.set Variables dm.control Edit | did -i DM 3 2 Click on Visual Editor to place the editbox.
on *:dialog:dm:sclick:9:var.set Variables dm.control Text | did -i DM 3 2 Click on Visual Editor to place the text.
on *:dialog:dm:sclick:10:var.set Variables dm.control Link | did -i DM 3 2 Click on Visual Editor to place the link.
on *:dialog:dm:sclick:11:var.set Variables dm.control Box | did -i DM 3 2 Click on Visual Editor to place the box.
on *:dialog:dm:sclick:12:var.set Variables dm.control Scroll | did -i DM 3 2 Click on Visual Editor to place the scroll.
on *:dialog:dm:sclick:13:var.set Variables dm.control Tab | did -i DM 3 2 Click on Visual Editor to place the tab.
on *:dialog:dm:sclick:14:var.set Variables dm.control Icon | did -i DM 3 2 Click on Visual Editor to place the icon.
on *:dialog:dm:sclick:15:var.set Variables dm.control Check | did -i DM 3 2 Click on Visual Editor to place the chechbox button.
on *:dialog:dm:sclick:16:var.set Variables dm.control Radio | did -i DM 3 2 Click on Visual Editor to place the radio button.
on *:dialog:dm:sclick:17:var.set Variables dm.control List | did -i DM 3 2 Click on Visual Editor to place the list.
on *:dialog:dm:sclick:18:var.set Variables dm.control Combo | did -i DM 3 2 Click on Visual Editor to place the combobox.
on *:dialog:dm:sclick:56:var.unset Variables dm.control | did -i DM 3 2 Ready
on *:dialog:dm:sclick:48:{
  if ($var.read(Variables,dm.do) == DBU) {
    var.unset Variables dm.do
    did -i DM 27 1 $calc($dm.edit(dm,27) /2) -1 9999 10 0:1,2:5,5:20
    did -i DM 28 1 $calc($dm.edit(dm,28) /2) -1 9999 10 0:1,2:5,5:20
    did -i DM 30 1 $calc($dm.edit(dm,30) /2) 0 9999 10 0:1,2:5,5:20
    did -i DM 47 1 $calc($dm.edit(dm,47) /2) 0 9999 10 0:1,2:5,5:20
  }
  else {
    var.set Variables dm.do DBU
    did -i DM 27 1 $calc($dm.edit(dm,27) *2) -1 9999 10 0:1,2:5,5:20
    did -i DM 28 1 $calc($dm.edit(dm,28) *2) -1 9999 10 0:1,2:5,5:20
    did -i DM 30 1 $calc($dm.edit(dm,30) *2) 0 9999 10 0:1,2:5,5:20
    did -i DM 47 1 $calc($dm.edit(dm,47) *2) 0 9999 10 0:1,2:5,5:20
  }
}
on *:dialog:dm:sclick:51:{
  var.set Variables dm.di $sfile(*.ico,Select Dialog Icon:,Select)
  if ($var.read(Variables,dm.di) !== $null) { did -ra DM 1 $var.read(Variables,dm.di) }
}
on *:dialog:dm:sclick:52:{
  if ($var.read(Variables,dm.top) == On) { var.set Variables dm.top Off | dialog -n $var.read(Variables,dm.dn) $var.read(Variables,dm.dn) | dialog -v DM DM }
  else { var.set Variables dm.top On | dialog -o $var.read(Variables,dm.dn) $var.read(Variables,dm.dn) | dialog -v DM DM }
}
------------------------------------------------------------------
dialog DO {
  title "Dialog Maker: Options"
  size -1 -1 530 300
  option pixels
  icon $dm.icon(Options), 0
  box "", 8, 0 267 530 8
  button "&OK", 9, 190 279 150 20, default ok
  list 1, 2 3 145 266, size
  box "", 2, 152 -2 375 245
  list 3, 152 248 375 20, size
  list 4, 156 7 367 215, hide size
  edit "", 5, 155 222 368 18, hide autohs
  list 6, 156 7 367 172, hide size
  list 7, 156 7 367 233, hide size
  list 10, 156 179 366 60, hide size
  icon 11, 153 5 372 237
  button "Open", 12, 159 11 120 20, hide
  check "On Top", 13, 279 11 120 20, hide push
  check "Auto Start", 14, 159 11 120 20, hide push
  check "Open Last Project", 15, 159 11 120 20, hide push
  combo 16, 371 11 150 185, hide size drop
  edit "", 17, 370 36 152 160, hide multi autovs
  list 18, 158 30 200 40, hide size
  text "Red:", 19, 159 15 140 13, hide
  edit "", 20, 308 10 50 18, hide autohs limit 3
  text "Green:", 21, 159 92 140 13, hide
  list 22, 158 107 200 40, hide size
  edit "", 23, 308 87 50 18, hide autohs limit 3
  text "Blue:", 24, 159 167 140 13, hide
  list 25, 158 182 200 40, hide size
  edit "", 26, 308 162 50 18, hide autohs limit 3
  button "", 27, 370 201 151 20, hide
  check "Remember Positions", 28, 399 11 120 20, hide push
  check "Close Loading", 29, 279 11 120 20, hide push
  check "Show Tips", 30, 159 31 120 20, hide push
}
on *:dialog:do:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.do.x) !== $null) && ($var.read(Options,dmo.pos.do.y) !== $null) { dialog -s DO $var.read(Options,dmo.pos.do.x) $var.read(Options,dmo.pos.do.y) 530 300 }
  if ($exists($dm.icon(Logo)) == $true) { did -g DO 11 $dm.icon(Logo) }
  mdx SetBorderStyle 18,22,25,17,20,23,26 staticedge
  mdx SetBorderStyle 3 windowedge
  mdx SetBorderStyle 5 border
  mdx SetControlMDX DO 3 ToolBar flat list nodivider > $shortfn($scriptdir) $+ Data\Bars.mdx
  mdx SetControlMDX DO 10 ToolBar flat nodivider > $shortfn($scriptdir) $+ Data\Bars.mdx
  mdx SetControlMDX 20,23,26 UpDown alignright edit numeric > $shortfn($scriptdir) $+ Data\Ctl_gen.mdx
  did -i DO 3 1 bmpsize 16 16
  did -i DO 10 1 bmpsize 32 32
  did -i DO 3 1 pad 19 5
  did -i DO 10 1 pad 21 5
  did -i DO 3 1 bwidth 32 32
  did -a DO 3 +da 1 $tab Add
  did -a DO 3 +da 2 $tab Load
  did -a DO 3 +a 3 $tab -
  did -a DO 3 +da 4 $tab Rename
  did -a DO 3 +da 5 $tab Delete
  did -a DO 3 +a 6 $tab -
  did -a DO 3 +da 7 $tab Refresh
  mdx SetControlMDX 1 TreeView haslines linesatroot hasbuttons > $shortfn($scriptdir) $+ Data\Views.mdx
  did -a $dname 1 +b General
  did -i $dname 1 1 cb 2
  did -a $dname 1 Main
  did -a $dname 1 Patterns
  did -i DO 1 1 branch expandall $did(1).lines
  did -i $dname 1 1 cb root
  did -a $dname 1 +b Editors
  did -i $dname 1 1 cb 3
  did -a $dname 1 Code Editor
  did -a $dname 1 Visual Editor
  did -a $dname 1 Control Editor
  did -i DO 1 1 branch expandall $did(1).lines
  did -i $dname 1 1 cb root
  did -a $dname 1 +b Skins
  did -i $dname 1 1 cb 4
  did -a $dname 1 Load
  did -i DO 1 1 branch expandall $did(1).lines
  did -i $dname 1 1 cb root
  did -a $dname 1 +b Languages
  did -i $dname 1 1 cb 5
  did -a $dname 1 Load
  did -i DO 1 1 branch expandall $did(1).lines
  mdx SetControlMDX $dname 18,22,25 TrackBar select tooltips nwticks > $shortfn($scriptdir) $+ Data\Bars.mdx
  did -i $dname 18,22,25 1 params * 0 255 * 0 255 * *
  did -a DO 16 Text
  did -a DO 16 Background
  did -a DO 16 Text Background
  did -fc DO 16 1
  did -a DO 17 Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm Nn Oo Pp Qq Rr Ss Tt Uu Vv Ww Xx Yy Zz
  mdx SetColor $dname 19 text $rgb(255,0,0)
  mdx SetColor $dname 21 text $rgb(0,255,0)
  mdx SetColor $dname 24 text $rgb(0,0,255)
  mdx SetColor $dname 17 background $rgb(0,0,0)
  mdx SetFont 5 13 600 Tahoma
  mdx SetFont 17 $var.read(Options,dmo.font.size) 200 $var.read(Options,dmo.font.name)
  did -ra DO 27 $var.read(Options,dmo.font.name) - $var.read(Options,dmo.font.size)
  var.set Variables dm.ff $shortfn($scriptdir) $+ Data\Patterns.ini
  if ($var.read(Options,dmo.asc) == on) { did -c DO 14 }
  .signal Modules_DO
  dm.language
}
on *:dialog:do:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.do.x $dialog(do).x | var.set Options dmo.pos.do.y $dialog(do).y }
on *:dialog:do:sclick:1:{
  did -h DO 4,5,6,7,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
  var.set Temporary sel $replace($gettok($did(1,1),4-,32),$chr(32),_)
  if ($var.read(Temporary,sel) == 2_2) || ($var.read(Temporary,sel) == 2_3) || ($var.read(Temporary,sel) == 3_2) || ($var.read(Temporary,sel) == 3_3) || ($var.read(Temporary,sel) == 3_4) || ($var.read(Temporary,sel) == 4_2) || ($var.read(Temporary,sel) == 4_3) || ($var.read(Temporary,sel) == 5_2) {
    if ($var.read(Temporary,sel) == 2_2) {
      did -v DO 15,28,29,30
      if ($var.read(Options,dmo.last.project) == on) { did -c DO 15 }
      if ($var.read(Options,dmo.remember.positions) == on) { did -c DO 28 }
      if ($var.read(Options,dmo.close.loading) == on) { did -c DO 29 }
      if ($var.read(Options,dmo.show.tips) == on) { did -c DO 30 }
    }
    if ($var.read(Temporary,sel) == 2_3) {
      did -v DO 4,5
      did -br DO 5
      did -r DO 4
      if ($var.read(Options,dmo.language) !== $null) {
        did -o DO 3 2 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Add)
        did -o DO 3 3 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Load)
        did -o DO 3 5 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Rename)
        did -o DO 3 6 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Delete)
        did -o DO 3 8 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Refresh)
      }
      else {
        did -o DO 3 2 +a 1 $tab Add
        did -o DO 3 3 +da 1 $tab Load
        did -o DO 3 5 +a 1 $tab Rename
        did -o DO 3 6 +a 1 $tab Delete
        did -o DO 3 8 +a 1 $tab Refresh
      }
      set %i 1
      while ($ini($var.read(Variables,dm.ff),%i) !== $null) {
        did -a DO 4 $ini($var.read(Variables,dm.ff),%i)
        inc %i
      }
      unset %i
    }
    if ($var.read(Temporary,sel) == 3_2) {
      did -v DO 16,17,18,19,20,21,22,23,24,25,26,27
      var.set Variables dm.color $did(do,16).seltext
      color.refresh
      did -f DO 1
    }
    if ($var.read(Temporary,sel) == 3_3) {
      did -v DO 12,13
      if ($var.read(Options,dmo.veot) == on) { did -c DO 13 }
    }
    if ($var.read(Temporary,sel) == 3_4) {
      did -v DO 13,14
      if ($var.read(Options,dmo.ceot) == on) { did -c DO 13 }
    }
    if ($var.read(Temporary,sel) == 4_2) {
      did -rv DO 6
      if ($var.read(Options,dmo.language) !== $null) {
        did -o DO 3 2 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Add)
        did -o DO 3 3 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Load)
        did -o DO 3 5 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Rename)
        did -o DO 3 6 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Delete)
        did -o DO 3 8 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Refresh)
      }
      else {
        did -o DO 3 2 +da 1 $tab Add
        did -o DO 3 3 +a 1 $tab Load
        did -o DO 3 5 +da 1 $tab Rename
        did -o DO 3 6 +a 1 $tab Delete
        did -o DO 3 8 +a 1 $tab Refresh
      }
      .echo -q $findfile($shortfn($scriptdir) $+ Data\Skins,*.skn,0,did -a DO 6 $remove($nopath($1-),.skn))
    }
    if ($var.read(Temporary,sel) == 5_2) {
      did -v DO 7
      did -ra DO 7 English
      if ($var.read(Options,dmo.language) !== $null) {
        did -o DO 3 2 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Add)
        did -o DO 3 3 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Load)
        did -o DO 3 5 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Rename)
        did -o DO 3 6 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Delete)
        did -o DO 3 8 +a 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Refresh)
      }
      else {
        did -o DO 3 2 +da 1 $tab Add
        did -o DO 3 3 +a 1 $tab Load
        did -o DO 3 5 +da 1 $tab Rename
        did -o DO 3 6 +a 1 $tab Delete
        did -o DO 3 8 +a 1 $tab Refresh
      }
      .echo -q $findfile($shortfn($scriptdir) $+ Data\Languages,*.lng,0,did -a DO 7 $nopath($1-))
    }
  }
  else {
    if ($var.read(Options,dmo.language) !== $null) {
      did -o DO 3 2 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Add)
      did -o DO 3 3 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Load)
      did -o DO 3 5 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Rename)
      did -o DO 3 6 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Delete)
      did -o DO 3 8 +da 1 $tab $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Options,Refresh)
    }
    else {
      did -o DO 3 2 +da 1 $tab Add
      did -o DO 3 3 +da 1 $tab Load
      did -o DO 3 5 +da 1 $tab Rename
      did -o DO 3 6 +da 1 $tab Delete
      did -o DO 3 8 +da 1 $tab Refresh
    }
    did -v DO 11
  }
}
on *:dialog:do:sclick:3:{
  if ($did(3).sel == 2) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 2_3) {
    var.set Variables dm.pn $?="Enter pattern name:"
    if ($var.read(Variables,dm.pn) !== $null) {
      writeini $var.read(Variables,dm.ff) $var.read(Variables,dm.pn) $var.read(Variables,dm.pn) None
      did -a DO 4 $var.read(Variables,dm.pn)
      did -c DO 4 $did(do,4).lines
      if ($did(do,4).seltext !== $null) {
        did -e DO 5
        did -ra DO 5 $readini($var.read(Variables,dm.ff), $ini($var.read(Variables,dm.ff), $did(do,4).sel), $ini($var.read(Variables,dm.ff), $did(do,4).sel))
      }
      else { did -br DO 5 }
    }
    if ($dialog(do)) { dialog -v DO DO }
  }
  if ($did(3).sel == 5) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 2_3) {
    if ($did(4).seltext !== $null) {
      var.set Variables dm.rp $?="Rename ' $+ $did(do,4).seltext $+ ' to:"
      if ($var.read(Variables,dm.rp) !== $null) {
        remini $var.read(Variables,dm.ff) $did(do,4).seltext
        writeini $var.read(Variables,dm.ff) $var.read(Variables,dm.rp) $var.read(Variables,dm.rp) $did(do,5)
        did -co DO 4 $did(do,4).sel $var.read(Variables,dm.rp)
        if ($did(do,4).seltext !== $null) {
          did -e DO 5,19
          did -ra DO 5 $readini($var.read(Variables,dm.ff), $ini($var.read(Variables,dm.ff), $did(do,4).sel), $ini($var.read(Variables,dm.ff), $did(do,4).sel))
        }
        else { did -br DO 5 }
      }
      if ($dialog(do)) { dialog -v DO DO }
    }
  }
  if ($did(3).sel == 6) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 2_3) {
    if ($did(4).seltext !== $null) {
      remini $var.read(Variables,dm.ff) $did(do,4).seltext
      did -d DO 4 $did(do,4).sel
      did -c DO 4 $did(do,4).lines
      if ($did(do,4).seltext !== $null) {
        did -e DO 5
        did -ra DO 5 $readini($var.read(Variables,dm.ff), $ini($var.read(Variables,dm.ff), $did(do,4).sel), $ini($var.read(Variables,dm.ff), $did(do,4).sel))
      }
      else { did -br DO 5 }
    }
  }
  if ($did(3).sel == 8) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 2_3) {
    did -r DO 4,5
    did -b DO 5
    set %i 1
    while ($ini($var.read(Variables,dm.ff),%i) !== $null) {
      did -a DO 4 $ini($var.read(Variables,dm.ff),%i)
      inc %i
    }
    unset %i
  }
  if ($did(3).sel == 3) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 4_2) {
    if ($did(6).seltext !== $null) {
      var.set Options dmo.skin $did(6).seltext
      dm.skin
      if ($var.read(Options,dmo.skin) == Default) { var.unset Options dmo.skin }
    }
  }
  if ($did(3).sel == 6) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 4_2) {
    if ($did(6).seltext !== $null) && ($did(6).seltext !== Default) {
      if ($?!="Are you sure want to delete ' $+ $did(6).seltext $+ '?" == $true) { .remove $shortfn($scriptdir) $+ Data\Skins\ $+ $did(6).seltext $+ .skn }
      dialog -v DO do
      did -r DO 6
      .echo -q $findfile($shortfn($scriptdir) $+ Data\Skins,*.skn,0,did -a DO 6 $remove($nopath($1-),.skn))
    }
    if ($did(6).seltext !== $null) && ($did(6).seltext == Default) { .echo -q $dm.error(You can't delete this skin because it is the default and the original one!) }
  }
  if ($did(3).sel == 8) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 4_2) {
    did -rv DO 6
    .echo -q $findfile($shortfn($scriptdir) $+ Data\Skins,*.skn,0,did -a DO 6 $remove($nopath($1-),.skn))
  }
  if ($did(3).sel == 6) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 5_2) {
    if ($did(7).seltext !== $null) && ($did(7).seltext !== English) {
      if ($?!="Are you sure want to delete ' $+ $did(7).seltext $+ '?" == $true) { .remove $shortfn($scriptdir) $+ Data\Languages\ $+ $did(7).seltext }
      dialog -v DO do
      did -ra DO 7 English
      .echo -q $findfile($shortfn($scriptdir) $+ Data\Languages,*.lng,0,did -a DO 7 $nopath($1-))
    }
    if ($did(7).seltext !== $null) && ($did(7).seltext == English) { .echo -q $dm.error(You can't delete this language!) }
  }
  if ($did(3).sel == 3) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 5_2) {
    if ($did(7).seltext !== $null) && ($did(7).seltext !== English) { var.set Options dmo.language $did(7).seltext | .echo -q $dm.error(You must restart Dialog Maker before the changes take effect!,dm.close Restart) }
    if ($did(7).seltext !== $null) && ($did(7).seltext == English) { var.unset Options dmo.language | .echo -q $dm.error(You must restart Dialog Maker before the changes take effect!,dm.close Restart) }
  }
  if ($did(3).sel == 8) && ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 5_2) {
    did -ra DO 7 English
    .echo -q $findfile($shortfn($scriptdir) $+ Data\Languages,*.lng,0,did -a DO 7 $nopath($1-))
  }
}
on *:dialog:do:sclick:27:{
  var.set Variables dm.test.font $dll($shortfn($scriptdir) $+ Data\Font.dll,Font,Select a Font...)
  if ($var.read(Variables,dm.test.font) !== $false) {
    var.set Options dmo.font.size $gettok($var.read(Variables,dm.test.font,1,44))
    var.set Options dmo.font.name $gettok($var.read(Variables,dm.test.font,4,44))
    if ($var.read(Options,dmo.font.name) !== $null) { mdx SetFont DO 17 $var.read(Options,dmo.font.size) 200 $var.read(Options,dmo.font.name) | did -ra DO 27 $var.read(Options,dmo.font.name) - $var.read(Options,dmo.font.size) }
  }
  if ($dialog(do)) { dialog -v DO DO }
}
on *:dialog:do:edit:20:{
  color.red $dm.edit(do,20) Edit
  color.refresh Edit
}
on *:dialog:do:edit:23:{
  color.green $dm.edit(do,23) Edit
  color.refresh Edit
}
on *:dialog:do:edit:26:{
  color.blue $dm.edit(do,26) Edit
  color.refresh Edit
}
on *:dialog:do:sclick:18:color.red $did(18).seltext
on *:dialog:do:sclick:22:color.green $did(22).seltext
on *:dialog:do:sclick:25:color.blue $did(25).seltext
on *:dialog:do:sclick:12:dm.ve | if ($var.read(Variables,dm.file) !== $null) { dm.build }
on *:dialog:do:sclick:15:{
  if ($var.read(Options,dmo.last.project) == on) { var.unset Options dmo.last.project }
  else { var.set Options dmo.last.project on }
}
on *:dialog:do:sclick:28:{
  if ($var.read(Options,dmo.remember.positions) == on) { var.unset Options dmo.remember.positions }
  else { var.set Options dmo.remember.positions on }
}
on *:dialog:do:sclick:29:{
  if ($var.read(Options,dmo.close.loading) == on) { var.unset Options dmo.close.loading }
  else { var.set Options dmo.close.loading on }
}
on *:dialog:do:sclick:30:{
  if ($var.read(Options,dmo.show.tips) == on) { var.set Options dmo.show.tips off }
  else { var.set Options dmo.show.tips on }
}
on *:dialog:do:sclick:14:{
  if ($var.read(Options,dmo.asc) == on) { var.unset Options dmo.asc }
  else { var.set Options dmo.asc on }
}
on *:dialog:do:sclick:13:{
  if ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 3_3) {
    if ($var.read(Options,dmo.veot) == on) { var.unset Options dmo.veot }
    else { var.set Options dmo.veot on }
  }
  if ($replace($gettok($did(1,1),4-,32),$chr(32),_) == 3_4) {
    if ($var.read(Options,dmo.ceot) == on) { var.unset Options dmo.ceot }
    else { var.set Options dmo.ceot on }
  }
}
on *:dialog:do:sclick:16:{
  var.set Variables dm.color $did(16).seltext
  color.refresh
}
on *:dialog:do:dclick:4:{
  var.set Variables dm.rp $?="Rename ' $+ $did(do,4).seltext $+ ' to:"
  if ($var.read(Variables,dm.rp) !== $null) {
    remini $var.read(Variables,dm.ff) $did(do,4).seltext
    writeini $var.read(Variables,dm.ff) $var.read(Variables,dm.rp) $var.read(Variables,dm.rp) $did(do,5)
    did -co DO 4 $did(do,4).sel $var.read(Variables,dm.rp)
    if ($did(do,4).seltext !== $null) {
      did -e DO 5
      did -ra DO 5 $readini($var.read(Variables,dm.ff), $ini($var.read(Variables,dm.ff), $did(do,4).sel), $ini($var.read(Variables,dm.ff), $did(do,4).sel))
    }
    else { did -br DO 5 }
  }
  if ($dialog(do)) { dialog -v DO DO }
}
on *:dialog:do:edit:5:if ($did(do,5) !== $null) { writeini $var.read(Variables,dm.ff) $did(do,4).seltext $did(do,4).seltext $did(do,5) }
on *:dialog:do:sclick:4:{
  if ($did(do,4).seltext !== $null) {
    did -e DO 5
    did -ra DO 5 $readini($var.read(Variables,dm.ff), $ini($var.read(Variables,dm.ff), $did(do,4).sel), $ini($var.read(Variables,dm.ff), $did(do,4).sel))
  }
  else { did -br DO 5 }
}
on *:dialog:do:sclick:54:{
  if ($var.read(Options,dmo.ceot) == on) { var.unset Options dmo.ceot }
  else { var.set Options dmo.ceot on }
}
on *:dialog:do:sclick:42:dm.ve
on *:dialog:do:sclick:6:{
  did -v DO 10
  var.set Temporary dm.preview.skin $did(6).seltext
  dm.preview.skin
}
on *:dialog:do:dclick:6:{
  var.set Options dmo.skin $did(6).seltext
  dm.skin
  if ($var.read(Options,dmo.skin) == Default) { var.unset Options dmo.skin }
}
on *:dialog:do:sclick:40:{
  did -f DO 6
  var.set Options dmo.skin $did(6).seltext
  dm.skin
  if ($var.read(Options,dmo.skin) == Default) { var.unset Options dmo.skin }
}
on *:dialog:do:sclick:34:{
  if ($var.read(Options,dmo.asc) == on) { var.unset Options dmo.asc }
  else { var.set Options dmo.asc on }
}
on *:dialog:do:sclick:4:{
  if ($var.read(Options,dmo.veot) == on) { var.unset Options dmo.veot }
  else { var.set Options dmo.veot on }
}
on *:dialog:do:dclick:7:{
  if ($did(7).seltext !== $null) && ($did(7).seltext !== English) { var.set Options dmo.language $did(7).seltext | .echo -q $dm.error(You must restart Dialog Maker before the changes take effect!,dm.close Restart) }
  if ($did(7).seltext !== $null) && ($did(7).seltext == English) { var.unset Options dmo.language | .echo -q $dm.error(You must restart Dialog Maker before the changes take effect!,dm.close Restart) }
}
------------------------------------------------------------------
dialog MOD {
  title "Dialog Maker: Modules"
  size -1 -1 560 365
  option pixels
  icon $dm.icon(Modules), 0
  icon 1, 12 12 140 292, $dm.icon(Modules_Pic), 0
  box "", 2, 11 317 538 8
  list 3, 165 10 385 297, size
  button "OK", 5, 449 337 100 20, default ok
  button "&Load", 6, 11 337 75 20
  button "&Adjust", 8, 86 337 75 20
  button "&Refresh", 9, 374 337 75 20
  button "&Delete", 11, 161 337 75 20
}
on *:dialog:mod:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.mod.x) !== $null) && ($var.read(Options,dmo.pos.mod.y) !== $null) { dialog -s mod $var.read(Options,dmo.pos.mod.x) $var.read(Options,dmo.pos.mod.y) 560 360 }
  mdx SetFont 5 13 700 Tahoma
  mdx SetControlMDX 3 ListView infotip sortascending headerdrag showsel single report rowselect > $shortfn($scriptdir) $+ Data\Views.mdx
  did -i $dname 3 1 headerdims 235:1 128:2 0:3
  did -i $dname 3 1 headertext +l Module $chr(9) $+ +l Author $chr(9) $+ +r Location
  did -i $dname 3 1 seticon normal 0 0, $+ $dm.icon(Modules_Loaded)
  did -i $dname 3 1 seticon normal 0 0, $+ $dm.icon(Modules_Unloaded)
  dm.language
  .echo -q $findfile($shortfn($scriptdir) $+ Data\Modules,*.mod,0,dm.add.mod $1-)
}
on *:dialog:mod:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.mod.x $dialog(mod).x | var.set Options dmo.pos.mod.y $dialog(mod).y }
on *:dialog:mod:sclick:3:{
  if ($var.read(Options,dmo.language) == $null) {
    if ($script($shortfn($dm.cell(mod,3,$did(3).sel,3))) !== $null) { did -ra mod 6 &Unload }
    else { did -ra mod 6 &Load }
  }
  else {
    if ($script($shortfn($dm.cell(mod,3,$did(3).sel,3))) !== $null) { did -ra mod 6 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Modules,Unload) }
    else { did -ra mod 6 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Modules,Load) }
  }
}
on *:dialog:mod:dclick:3:{
  if ($script($shortfn($dm.cell(mod,3,$did(3).sel,3))) !== $null) {
    if ($dm.cell(mod,3,$did(3).sel,1) !== $null) {
      .unload -rs $dm.cell(mod,3,$did(3).sel,3)
      did -co mod 3 $did(3).sel 0 + 2 0 0 $dm.cell(mod,3,$did(3).sel,1) $chr(9) $dm.cell(mod,3,$did(3).sel,2) $chr(9) $dm.cell(mod,3,$did(3).sel,3) $chr(4) $readini($dm.cell(mod,3,$did(3).sel,3),Information,Description)
      if ($var.read(Options,dmo.language) == $null) { did -ra mod 6 &Load }
      else { did -ra mod 6 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Modules,Load) }
    }
  }
  else {
    if ($dm.cell(mod,3,$did(3).sel,1) !== $null) {
      .load -rs $dm.cell(mod,3,$did(3).sel,3)
      did -co mod 3 $did(3).sel 0 + 1 0 0 $dm.cell(mod,3,$did(3).sel,1) $chr(9) $dm.cell(mod,3,$did(3).sel,2) $chr(9) $dm.cell(mod,3,$did(3).sel,3) $chr(4) $readini($dm.cell(mod,3,$did(3).sel,3),Information,Description)
      if ($var.read(Options,dmo.language) == $null) { did -ra mod 6 &Unload }
      else { did -ra mod 6 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Modules,Unload) }
    }
  }
}
on *:dialog:mod:sclick:8:{
  if ($dm.cell(mod,3,$did(3).sel,1) !== $null) {
    if ($script($shortfn($dm.cell(mod,3,$did(3).sel,3))) !== $null) { $readini($dm.cell(mod,3,$did(3).sel,3),Information,Adjust) }
    else { .echo -q $dm.error(Before adjusting the module please load it first!,.load -rs $dm.cell(mod,3,$did(3).sel,3) $chr(4) $readini($dm.cell(mod,3,$did(3).sel,3),Information,Description),$readini($dm.cell(mod,3,$did(3).sel,3),Information,Adjust)) }
  }
}
on *:dialog:mod:sclick:11:{
  if ($dm.cell(mod,3,$did(3).sel,1) !== $null) {
    if ($script($shortfn($dm.cell(mod,3,$did(3).sel,3))) !== $null) { .unload -rs $dm.cell(mod,3,$did(3).sel,3) }
    .remove -b $dm.cell(mod,3,$did(3).sel,3)
    did -d mod 3 $did(3).sel
  }
}
on *:dialog:mod:sclick:9:{
  did -ra mod 6 &Load
  did -r mod 3
  .echo -q $findfile($shortfn($scriptdir) $+ Data\Modules,*.mod,0,dm.add.mod $1-)
}
on *:dialog:mod:sclick:6:{
  if ($script($shortfn($dm.cell(mod,3,$did(3).sel,3))) !== $null) {
    if ($dm.cell(mod,3,$did(3).sel,1) !== $null) {
      .unload -rs $dm.cell(mod,3,$did(3).sel,3)
      did -fco mod 3 $did(3).sel 0 + 2 0 0 $dm.cell(mod,3,$did(3).sel,1) $chr(9) $dm.cell(mod,3,$did(3).sel,2) $chr(9) $dm.cell(mod,3,$did(3).sel,3) $chr(4) $readini($dm.cell(mod,3,$did(3).sel,3),Information,Description)
      if ($var.read(Options,dmo.language) == $null) { did -ra mod 6 &Load }
      else { did -ra mod 6 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Modules,Load) }
    }
  }
  else {
    if ($dm.cell(mod,3,$did(3).sel,1) !== $null) {
      .load -rs $dm.cell(mod,3,$did(3).sel,3)
      did -fco mod 3 $did(3).sel 0 + 1 0 0 $dm.cell(mod,3,$did(3).sel,1) $chr(9) $dm.cell(mod,3,$did(3).sel,2) $chr(9) $dm.cell(mod,3,$did(3).sel,3) $chr(4) $readini($dm.cell(mod,3,$did(3).sel,3),Information,Description)
      if ($var.read(Options,dmo.language) == $null) { did -ra mod 6 &Unload }
      else { did -ra mod 6 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Modules,Unload) }
    }
  }
}
------------------------------------------------------------------
dialog LE {
  title "Dialog Maker: Language Editor"
  size -1 -1 640 385
  option pixels
  icon $dm.icon(Language), 0
  list 1, 0 0 500 333, size
  combo 2, 371 353 251 200, size vsbar drop
  button "New", 3, 18 353 151 20
  button "Change", 5, 169 353 101 20, disable default
  list 4, 500 0 140 333, size
  box "", 6, 10 340 620 8
  box "", 7, 10 340 270 40
  box "", 8, 361 340 270 40
}
on *:dialog:le:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.le.x) !== $null) && ($var.read(Options,dmo.pos.le.y) !== $null) { dialog -s le $var.read(Options,dmo.pos.le.x) $var.read(Options,dmo.pos.le.y) 640 385 }
  mdx SetFont 1,2,3,5,4 13 600 Tahoma
  mdx SetControlMDX 1 ListView headerdrag sortascending single report grid rowselect > $shortfn($scriptdir) $+ Data\Views.mdx
  mdx SetControlMDX 4 TreeView haslines linesatroot hasbuttons > $shortfn($scriptdir) $+ Data\Views.mdx
  did -i $dname 1 1 headerdims 239:1 239:2
  did -i $dname 1 1 headertext +c Default $chr(9) $+ +c Translated
  did -f le 2
  did -a $dname 4 Windows
  did -i $dname 4 1 cb 2
  did -a $dname 4 Main
  did -a $dname 4 Error
  did -a $dname 4 Update
  did -a $dname 4 Options
  did -a $dname 4 Modules
  did -a $dname 4 Control Editor
  did -a $dname 4 Language Editor
  did -a $dname 4 Code Editor
  did -i $dname 4 1 cb 9
  did -a $dname 4 Go To Line
  did -a $dname 4 Search
  did -i $dname 4 1 cb root
  did -a $dname 4 Menus
  did -i $dname 4 1 cb 3
  did -a $dname 4 Tools
  did -a $dname 4 Dialog Code
  did -i $dname 4 1 cb root
  did -a $dname 4 About
  .signal Modules_LE
  dm.language
  .echo -q $findfile($shortfn($scriptdir) $+ Data\Languages,*.lng,0,did -a le 2 $nopath($1-))
  did -fc le 2 $did(2).lines
  var.set Temporary lang $shortfn($scriptdir) $+ Data\Languages\ $+ $did(2).seltext
}
on *:dialog:le:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.le.x $dialog(le).x | var.set Options dmo.pos.le.y $dialog(le).y }
on *:dialog:le:sclick:3:{
  var.set Variables dm.new.lang $?="New Language:"
  if ($var.read(Variables,dm.new.lang) !== $null) {
    var.set Variables dm.new.lang $shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Variables,dm.new.lang) $+ .lng
    .copy $shortfn($scriptdirData\New.lng) $var.read(Variables,dm.new.lang)
    if ($dialog(le)) { dialog -v le le }
    did -a le 2 $nopath($var.read(Variables,dm.new.lang))
    did -fc le 2 $did(2).lines
    var.set Temporary lang $shortfn($scriptdir) $+ Data\Languages\ $+ $did(2).seltext
  }
}
on *:dialog:le:sclick:2:{
  if ($did(2).seltext !== $null) {
    var.set Temporary lang $shortfn($scriptdir) $+ Data\Languages\ $+ $did(2).seltext
  }
}
on *:dialog:le:sclick:4:{
  did -b le 5
  var.set Temporary sel $replace($gettok($did(4,1),4-,32),$chr(32),_)
  if ($var.read(Temporary,sel) == 2_2) { var.set Temporary sel Main }
  if ($var.read(Temporary,sel) == 2_3) { var.set Temporary sel Error }
  if ($var.read(Temporary,sel) == 2_4) { var.set Temporary sel Update }
  if ($var.read(Temporary,sel) == 2_5) { var.set Temporary sel Options }
  if ($var.read(Temporary,sel) == 2_6) { var.set Temporary sel Modules }
  if ($var.read(Temporary,sel) == 2_7) { var.set Temporary sel Control_Editor }
  if ($var.read(Temporary,sel) == 2_8) { var.set Temporary sel Language_Editor }
  if ($var.read(Temporary,sel) == 2_9) { var.set Temporary sel Code_Editor }
  if ($var.read(Temporary,sel) == 2_9_2) { var.set Temporary sel Go_To_Line }
  if ($var.read(Temporary,sel) == 2_9_3) { var.set Temporary sel Search }
  if ($var.read(Temporary,sel) == 3_2) { var.set Temporary sel Tools }
  if ($var.read(Temporary,sel) == 3_3) { var.set Temporary sel Dialog_Code }
  if ($var.read(Temporary,sel) == 4) { var.set Temporary sel About }
  if ($var.read(Temporary,sel) !== $null) && ($var.read(Temporary,sel) !== 2) && ($var.read(Temporary,sel) !== 3) && ($did(2).seltext !== $null) {
    did -r le 1
    set %item 1
    while (%item <= $ini($var.read(Temporary,lang),$var.read(Temporary,sel),0)) {
      did -a le 1 $ini($var.read(Temporary,lang),$var.read(Temporary,sel),%item) $chr(9) $readini($var.read(Temporary,lang), $var.read(Temporary,sel),$ini($var.read(Temporary,lang),$var.read(Temporary,sel),%item))
      inc %item
    }
  }
  if ($var.read(Temporary,sel) == 2) || ($var.read(Temporary,sel) == 3) { did -r le 1 }
}
on *:dialog:le:sclick:1:if ($did(1).seltext !== $null) { did -e le 5 } | else { did -b le 5 }
on *:dialog:le:sclick:5:{
  if ($did(1).seltext !== $null) {
    var.set Temporary edit.line $did(1).sel
    if ($dialog(LE.TC) == $null) { did -b le 4 | dialog -mîd LE.TC LE.TC }
    else { did -b le 4 | dialog -x LE.TC LE.TC | dialog -mîd LE.TC LE.TC }
  }
}
on *:dialog:le:dclick:1:{
  if ($did(1).seltext !== $null) {
    var.set Temporary edit.line $did(1).sel
    if ($dialog(LE.TC) == $null) { did -b le 4 | dialog -mîd LE.TC LE.TC }
    else { did -b le 4 | dialog -x LE.TC LE.TC | dialog -mîd LE.TC LE.TC }
  }
}
------------------------------------------------------------------
dialog LE.TC {
  title ""
  size -1 -1 300 60
  option pixels
  icon $dm.icon(Language), 0
  box "", 1, 0 -4 300 40
  edit "", 2, 7 9 284 21, autohs center
  button "&Change", 3, 100 39 100 20, default ok
}
on *:dialog:LE.TC:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.le.tc.x) !== $null) && ($var.read(Options,dmo.pos.le.tc.y) !== $null) { dialog -s le.tc $var.read(Options,dmo.pos.le.tc.x) $var.read(Options,dmo.pos.le.tc.y) 300 60 }
  mdx SetBorderStyle 2 border
  mdx SetFont 2,3 13 600 Tahoma
  var.set Temporary line.number $did(le,1).sel
  var.set Temporary subtopic $did(le,4).seltext
  var.set Temporary original $dm.cell(LE,1,$did(le,1).sel,1)
  var.set Temporary translated $dm.cell(LE,1,$did(le,1).sel,2)
  .signal Modules_LE.TC
  dialog -t LE.TC $var.read(Temporary,original)
  did -ra LE.TC 2 $var.read(Temporary,translated)
  if ($var.read(Options,dmo.language) !== $null) { did -ra le.tc 3 $readini($shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language),Language_Editor,Change) }
}
on *:dialog:LE.TC:close:*:{
  if ($dialog(le)) { did -e le 4 }
  if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.le.tc.x $dialog(le.tc).x | var.set Options dmo.pos.le.tc.y $dialog(le.tc).y }
}
on *:dialog:LE.TC:sclick:3:{
  if ($did(LE.TC,2) !== $null) && ($dialog(le)) {
    did -o le 1 $var.read(Temporary,edit.line) $var.read(Temporary,original) $chr(9) $did(LE.TC,2)
    writeini $var.read(Temporary,lang) $var.read(Temporary,sel) $var.read(Temporary,original) $did(LE.TC,2)
    did -c le 1 $var.read(Temporary,line.number)
  }
}
------------------------------------------------------------------
dialog CE {
  title "Dialog Maker: Control Editor"
  size 425 0 511 235
  option pixels
  icon $dm.icon(Control), 0
  combo 4, 330 211 127 300, size drop
  text "Controls:", 5, 330 195 126 16, center
  text "Text:", 7, 0 10 42 16, right
  edit "", 8, 45 7 413 20, disable autohs
  edit "", 9, 45 32 50 20, disable autohs limit 4 center
  text "Size:", 6, 0 35 42 16, right
  edit "", 10, 96 32 50 20, disable autohs limit 4 center
  edit "", 11, 154 32 50 20, disable autohs limit 4 center
  edit "", 12, 205 32 50 20, disable autohs limit 4 center
  combo 3, 0 192 80 100, hide size drop
  text "Type:", 13, 0 176 80 16, hide center
  text "Align:", 14, 82 176 80 16, hide center
  combo 15, 82 192 80 100, hide size drop
  text "Tab:", 16, 164 176 80 16, hide center
  combo 17, 164 192 80 100, hide size drop
  check "Disable", 18, 258 32 50 20, disable push
  check "Hide", 19, 308 32 50 20, disable push
  check "Result", 20, 358 32 50 20, disable push
  check "Group", 21, 408 32 50 20, disable push
  button "&Save", 69, 0 214 118 20, default
  check "Default", 22, 8 84 96 20, hide push
  check "Flat", 23, 104 84 96 20, hide push
  check "Multi-Line", 24, 200 84 96 20, hide push
  button "Delete", 70, 270 108 120 20, hide
  button "Add", 43, 8 108 74 20, hide
  button "Refresh", 72, 82 108 74 20, hide
  check "Auto H Scroll", 28, 200 84 96 20, hide push
  check "Horizontal Scroll", 30, 200 104 96 20, hide push
  check "Sorted", 32, 8 84 96 20, hide push
  check "Editable", 33, 104 84 96 20, hide push
  check "Force Size", 34, 200 84 96 20, hide push
  check "Extended Select", 53, 104 84 96 20, hide push
  check "No Wordwrap", 36, 8 84 96 20, hide push
  check "Read-Only", 48, 8 104 96 20, hide push
  check "Flat", 40, 8 84 96 20, hide push
  check "3 State", 41, 104 84 96 20, hide push
  check "Flat", 51, 8 84 96 20, hide push
  check "Sorted", 52, 8 84 96 20, hide push
  check "Multi Select", 35, 104 104 96 20, hide push
  check "Force Size", 54, 200 84 96 20, hide push
  check "No Border", 60, 8 84 96 20, hide push
  check "Password Entry", 26, 8 84 96 20, hide push
  check "Allow Return", 27, 104 84 96 20, hide push
  combo 71, 270 86 120 92, hide size vsbar drop
  edit "", 58, 8 86 260 20, hide autohs
  edit "", 62, 6 122 300 20, hide autohs
  edit "", 66, 60 100 100 20, hide autohs
  edit "", 68, 60 124 100 20, hide autohs
  edit "", 59, 38 150 100 18, hide autohs
  text "Icon File:", 61, 0 106 52 16, hide right
  text "Scroll Range:", 64, 0 84 72 16, hide right
  text "Minimum:", 65, 0 104 58 16, hide right
  check "Vertical Scroll", 56, 296 104 96 20, hide push
  check "Horizontal Scroll", 55, 296 84 96 20, hide push
  button "Select...", 63, 314 122 74 20, hide
  check "Horizontal Scroll", 49, 296 84 96 20, hide push
  check "Vertical Scroll", 50, 296 104 96 20, hide push
  check "Auto V Scroll", 29, 296 84 96 20, hide push
  check "Vertical Scroll", 31, 296 104 96 20, hide push
  text "Maximum:", 67, 0 128 58 16, hide right
  text "Limit:", 57, 0 152 36 16, hide right
  list 1, 464 6 48 227, size
}
on *:dialog:ce:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.ce.x) !== $null) && ($var.read(Options,dmo.pos.ce.y) !== $null) { dialog -s ce $var.read(Options,dmo.pos.ce.x) $var.read(Options,dmo.pos.ce.y) 460 232 }
  mdx SetControlMDX ce 1 ToolBar flat nodivider > $shortfn($scriptdir) $+ Data\Bars.mdx
  mdx SetBorderStyle 1 windowedge
  did -i ce 1 1 bmpsize 32 32
  did -i ce 1 1 pad 10 10
  did -i ce 1 1 bwidth 32 32
  did -i ce 1 1 setimage +nhd icon normal, $dm.icon(Copy)
  did -i ce 1 1 setimage +nhd icon normal, $dm.icon(Delete)
  did -i ce 1 1 setimage +nhd icon normal, $dm.icon(Modules)
  did -a ce 1 +wa 1 $tab $chr(9) $+ Copy
  did -a ce 1 +wa 2 $tab $chr(9) $+ Delete
  mdx SetControlMDX 9,10,11,12,59,66,68 UpDown alignright edit numeric > $shortfn($scriptdir) $+ Data\Ctl_gen.mdx
  did -i ce 9,10,11,12,59,66,68 1 0 0 9999 10 0:1,2:5,5:20
  mdx SetBorderStyle 8,58,62 border
  mdx SetBorderStyle 9,10,11,12,59,66,68 staticedge
  .signal Modules_CE
  dm.language
  if ($var.read(Variables,dm.file) !== $null) { dm.ce }
}
on *:dialog:ce:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.ce.x $dialog(ce).x | var.set Options dmo.pos.ce.y $dialog(ce).y }
on *:dialog:ce:sclick:1:{
  if ($did(1).sel == 3) {
    if ($did(ce,4).seltext !== $null) {
      did -i DM 3 2 Deleting Control...
      var.set Variables dm.id $gettok($did(ce,4).seltext,2,32)
      remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32)
      mdx DynamicControl destroy VisualEditor $gettok($did(ce,4).seltext,2,32)
      dm.ce
      if ($gettok($did(ce,4).seltext,2,32) !== $null) && ($gettok($did(ce,4).seltext,1,32) == Tab) { did -e DM 13 }
      if ($did(ce,4).lines > 0) { did -cf ce 4 $did(ce,4).lines | sel.control }
      if ($did(ce,4).lines == 0) {
        did -b ce 8,9,10,11,12,18,19,20,21
        did -r ce 3,8,17,15
        did -i ce 9,10,11,12 1 0 0 9999 10 0:1,2:5,5:20
        did -h ce 22,23,24,26,27,28,29,30,31,48,57,59,36,64,65,66,67,68,60,61,62,63,40,41,51,52,53,54,55,56,35,32,33,34,49,50,58,71,43,70,72,13,3,14,15,16,17
      }
      did -i DM 3 2 Ready
    }
  }
}
on *:dialog:ce:sclick:4:if ($did(ce,4).seltext !== $null) { sel.control }
on *:dialog:ce:edit:62:{
  if ($did(ce,62) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Icon $did(ce,62) }
  else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Icon }
}
on *:dialog:ce:edit:8:{
  if ($var.read(Temporary,Loading) !== Yes) {
    if ($did(ce,8) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Text $did(ce,8) }
    else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Text }
  }
}
on *:dialog:ce:edit:9:if ($dm.edit(ce,9) !== $null) && ($var.read(Temporary,Loading) !== Yes) && ($did(9).enabled == $true) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) X $dm.edit(ce,9) | mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12) }
on *:dialog:ce:edit:10:if ($dm.edit(ce,10) !== $null) && ($var.read(Temporary,Loading) !== Yes) && ($did(10).enabled == $true) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Y $dm.edit(ce,10) | mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12) }
on *:dialog:ce:edit:11:if ($dm.edit(ce,11) !== $null) && ($var.read(Temporary,Loading) !== Yes) && ($did(11).enabled == $true) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) W $dm.edit(ce,11) | mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12) }
on *:dialog:ce:edit:12:if ($dm.edit(ce,12) !== $null) && ($var.read(Temporary,Loading) !== Yes) && ($did(12).enabled == $true) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) H $dm.edit(ce,12) | mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12) }
----------------------------------------------------------------------
on *:dialog:ce:sclick:17:{
  if ($did(17) == None) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Tab }
  else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Tab $did(17) }
}
on *:dialog:ce:sclick:15:{
  if ($did(15) == Default) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Align }
  else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Align $did(15) }
}
on *:dialog:ce:sclick:3:{
  if ($did(3) == Default) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Type }
  else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Type $did(3) }
}
===================TAB=======================
on *:dialog:ce:sclick:43:{
  writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control +Tab
  writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Tab
  dm.te
}
on *:dialog:ce:sclick:70:if ($var.read(Variables,dm.tid) !== $null) { remini $var.read(Variables,dm.fn2) $var.read(Variables,dm.tid) | dm.te }
on *:dialog:ce:edit:58:{
  if ($did(58) !== $null) && ($var.read(Variables,dm.tid) !== $null) { writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.tid) Text $did(58) }
  else { remini $var.read(Variables,dm.fn2) $var.read(Variables,dm.tid) Text }
}
on *:dialog:ce:sclick:71:{
  var.set Variables dm.tid $right($did(71),$calc($pos($did(71),$chr(32),1) *-1))
  did -r ce 58
  if ($readini($var.read(Variables,dm.fn2), $var.read(Variables,dm.tid) ,Text) !== $null) { did -a ce 58 $readini($var.read(Variables,dm.fn2), $var.read(Variables,dm.tid) ,Text) }
}
on *:dialog:ce:sclick:72:dm.te
================ICON=========================
on *:dialog:ce:sclick:63:{
  var.set Variables dm.icon $sfile(*.ico,Select Icon:,Select)
  did -ra ce 62 $var.read(Variables,dm.icon)
  if ($var.read(Variables,dm.icon) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Icon $did(62) }
  else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Icon }
}
on *:dialog:ce:sclick:60:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,NoBorder) == NoBorder) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) NoBorder }
  else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) NoBorder NoBorder }
}
===================COMMON====================
on *:dialog:ce:sclick:69:dm.cnd
on *:dialog:ce:sclick:18:{
  if ($mid($did(ce,4),9,$len($did(ce,4))) !== $null) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Disable) == Disable) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Disable | did -e VisualEditor $gettok($did(ce,4).seltext,2,32) }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Disable Disable | did -b VisualEditor $gettok($did(ce,4).seltext,2,32) }
  }
}
on *:dialog:ce:sclick:19:{
  if ($mid($did(ce,4),9,$len($did(ce,4))) !== $null) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Hide) == Hide) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Hide | mdx SetBorderStyle VisualEditor $gettok($did(ce,4).seltext,2,32) windowedge }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Hide Hide | mdx SetBorderStyle VisualEditor $gettok($did(ce,4).seltext,2,32) clientedge }
  }
}
on *:dialog:ce:sclick:20:{
  if ($mid($did(ce,4),9,$len($did(ce,4))) !== $null) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Result) == Result) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Result }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Result Result }
  }
}
on *:dialog:ce:sclick:21:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Group) == Group) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Group }
  else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Group Group }
}
on *:dialog:ce:edit:8:{
  if ($var.read(Variables,dm.fn2) !== $null) && ($gettok($did(ce,4).seltext,2,32) !== $null) {
    if ($did(ce,8) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Text $did(ce,8) }
    else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Text }
    did -ra VisualEditor $gettok($did(ce,4).seltext,2,32) $did(ce,8)
  }
}
on *:dialog:ce:edit:9:{
  if ($var.read(Variables,dm.fn2) !== $null) && ($gettok($did(ce,4).seltext,2,32) !== $null) {
    if ($dm.edit(ce,9) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) X $dm.edit(ce,9) }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) X 0 }
    mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12)
  }
}
on *:dialog:ce:edit:10:{
  if ($var.read(Variables,dm.fn2) !== $null) && ($gettok($did(ce,4).seltext,2,32) !== $null) {
    if ($dm.edit(ce,10) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Y $dm.edit(ce,10) }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Y 0 }
    mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12)
  }
}
on *:dialog:ce:edit:11:{
  if ($var.read(Variables,dm.fn2) !== $null) && ($gettok($did(ce,4).seltext,2,32) !== $null) {
    if ($dm.edit(ce,11) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) W $dm.edit(ce,11) }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) W 0 }
    mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12)
  }
}
on *:dialog:ce:edit:12:{
  if ($var.read(Variables,dm.fn2) !== $null) && ($gettok($did(ce,4).seltext,2,32) !== $null) {
    if ($dm.edit(ce,12) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) H $dm.edit(ce,12) }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) H 0 }
    mdx MoveControl VisualEditor $gettok($did(ce,4).seltext,2,32) $dm.edit(ce,9) $dm.edit(ce,10) $dm.edit(ce,11) $dm.edit(ce,12)
  }
}
===================RADIO=====================
on *:dialog:ce:sclick:51:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Radio) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Flat) == Flat) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Flat }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Flat Flat }
  }
}
===================CHECK=====================
on *:dialog:ce:sclick:40:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Check) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Flat) == Flat) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Flat }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Flat Flat }
  }
}
on *:dialog:ce:sclick:41:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Check) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,3State) == 3state) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) 3State }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) 3State 3state }
  }
}
===================EDIT======================
on *:dialog:ce:sclick:26:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Password) == Pass) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Password }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Password Pass }
  }
}
on *:dialog:ce:sclick:27:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Return) == Return) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Return }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Return Return }
  }
}
on *:dialog:ce:sclick:48:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,ReadOnly) == Read) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) ReadOnly }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) ReadOnly Read }
  }
}
on *:dialog:ce:sclick:28:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,AutoHS) == Autohs) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) AutoHS }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) AutoHS Autohs }
  }
}
on *:dialog:ce:sclick:29:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,AutoVS) == Autovs) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) AutoVS }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) AutoVS Autovs }
  }
}
on *:dialog:ce:sclick:30:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,HScroll) == Hsbar) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) HScroll }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) HScroll Hsbar }
  }
}
on *:dialog:ce:sclick:31:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,VScroll) == Vsbar) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) VScroll }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) VScroll Vsbar }
  }
}
on *:dialog:ce:edit:59:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Edit) {
    if ($dm.edit(ce,59) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Limit $dm.edit(ce,59) }
    else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Limit }
  }
}
===================BUTTON====================
on *:dialog:ce:sclick:22:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Button) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Default) == Default) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Default }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Default Default }
  }
}
on *:dialog:ce:sclick:23:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Button) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Flat) == Flat) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Flat }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Flat Flat }
  }
}
on *:dialog:ce:sclick:24:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Button) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,MultiLine) == MultiLine) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) MultiLine }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) MultiLine MultiLine }
  }
}
===================LIST======================
on *:dialog:ce:sclick:52:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == List) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Sorted) == Sort) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Sorted }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Sorted Sort }
  }
}
on *:dialog:ce:sclick:53:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == List) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Extended) == Extsel) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Extended }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Extended Extsel }
  }
}
on *:dialog:ce:sclick:35:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == List) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Multi) == Multsel) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Multi }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Multi Multsel }
  }
}
on *:dialog:ce:sclick:54:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == List) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Force) == Size) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Force }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Force Size }
  }
}
on *:dialog:ce:sclick:55:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == List) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Horizontal) == Hsbar) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Horizontal }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Horizontal Hsbar }
  }
}
on *:dialog:ce:sclick:56:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == List) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Vertical) == Vsbar) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Vertical }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Vertical Vsbar }
  }
}
===================COMBO=====================
on *:dialog:ce:sclick:32:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Combo) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Sorted) == Sort) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Sorted }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Sorted Sort }
  }
}
on *:dialog:ce:sclick:33:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Combo) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Editable) == Edit) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Editable }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Editable Edit }
  }
}
on *:dialog:ce:sclick:34:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Combo) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Force) == Size) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Force }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Force Size }
  }
}
on *:dialog:ce:sclick:49:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Combo) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Horizontal) == Hsbar) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Horizontal }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Horizontal Hsbar }
  }
}
on *:dialog:ce:sclick:50:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Combo) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Vertical) == Vsbar) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Vertical }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Vertical Vsbar }
  }
}
===================TEXT======================
on *:dialog:ce:sclick:36:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Text) {
    if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,NoWordwrap) == NoWrap) { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) NoWordwrap }
    else { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) NoWordwrap NoWrap }
  }
}
===================SCROLL====================
on *:dialog:ce:edit:68:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Scroll) {
    if ($did(68) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Maximum $did(68) }
    else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Maximum }
  }
}
on *:dialog:ce:edit:66:{
  if ($readini($var.read(Variables,dm.fn2), $gettok($did(ce,4).seltext,2,32) ,Control) == Scroll) {
    if ($did(66) !== $null) { writeini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Minimum $did(66) }
    else { remini $var.read(Variables,dm.fn2) $gettok($did(ce,4).seltext,2,32) Minimum }
  }
}
----------------------------------------------------------------------------------
dialog DC {
  title "Dialog Maker: Code Editor"
  size -1 -1 640 480
  option pixels
  icon $dm.icon(Code), 0
  edit "", 1, 164 70 475 406, multi return autohs autovs hsbar vsbar
  button "P", 13, 620 41 20 21, hide
  list 17, 2 2 1037 32, size
  list 2, 2 70 160 365, size
  list 3, 3 437 159 40, size
  text "Lines", 4, 4 73 100 16, hide
  edit "", 5, 4 89 155 21, hide read autohs center
  text "Size", 6, 4 120 100 16, hide
  edit "", 7, 4 136 155 21, hide read autohs center
  list 8, 2 70 160 365, hide size vsbar
  edit "", 9, 4 183 155 200, hide read multi return autohs autovs hsbar vsbar
  text "Clipboard", 10, 4 167 100 16, hide
}
on *:dialog:dc:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  mdx SetControlMDX 13 positioner size minbox maxbox > $shortfn($scriptdir) $+ Data\Dialog.mdx
  mdx SetFont 1 $var.read(Options,dmo.font.size) 200 $var.read(Options,dmo.font.name)
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.dc.x) !== $null) && ($var.read(Options,dmo.pos.dc.y) !== $null) && ($var.read(Options,dmo.pos.dc.w) !== $null) && ($var.read(Options,dmo.pos.dc.h) !== $null) { dialog -s dc $var.read(Options,dmo.pos.dc.x) $var.read(Options,dmo.pos.dc.y) $var.read(Options,dmo.pos.dc.w) $var.read(Options,dmo.pos.dc.h) }
  else { did -a dc 13 maximize }
  if ($var.read(Options,dmo.explorer) !== on) { did -h dc 2,3 }
  mdx SetControlMDX dc 17,3 ToolBar flat nodivider > $shortfn($scriptdir) $+ Data\Bars.mdx
  mdx SetBorderStyle 17,3 windowedge
  did -i dc 17,3 1 bmpsize 32 32
  did -i dc 17 1 pad 10 10
  did -i dc 17 1 bwidth 32 32
  did -i dc 3 1 pad 20 6
  mdx SetColor $dname 1 background $rgb($gettok($var.read(Options,dmo.color.back),1,95) , $gettok($var.read(Options,dmo.color.back),2,95) , $gettok($var.read(Options,dmo.color.back),3,95))
  mdx SetColor $dname 1 textbg $rgb($gettok($var.read(Options,dmo.color.textbg),1,95) , $gettok($var.read(Options,dmo.color.textbg),2,95) , $gettok($var.read(Options,dmo.color.textbg),3,95))
  mdx SetColor $dname 1 text $rgb($gettok($var.read(Options,dmo.color.text),1,95) , $gettok($var.read(Options,dmo.color.text),2,95) , $gettok($var.read(Options,dmo.color.text),3,95))
  var.set Variables dmc.file $nofile($shortfn($var.read(Variables,dm.file))) $+ $remove($nopath($var.read(Variables,dm.file)),$right($nopath($var.read(Variables,dm.file)),2)) $+ dmc
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Save)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Copy)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Paste)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Print)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Clear)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Search)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Goto)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Explorer)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Patterns)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Brackets)
  did -i dc 17 1 setimage +nhd icon normal, $dm.icon(Modules)
  did -i dc 17 1 setscheme $rgb(255,255,255) $rgb(128,128,128)
  did -a dc 17 +a 1 $tab Save $chr(9) $+ Save the code and close Code Editor
  did -a dc 17 +a -
  did -a dc 17 +a 2 $tab Copy $chr(9) $+ Copy selected text
  did -a dc 17 +a 3 $tab Paste $chr(9) $+ Paste the text from clipboard to the end of the code
  did -a dc 17 +a -
  did -a dc 17 +a 4 $tab Print $chr(9) $+ Print the code
  did -a dc 17 +a 5 $tab Clear $chr(9) $+ Clear entire code
  did -a dc 17 +a -
  did -a dc 17 +a 6 $tab Search $chr(9) $+ Search through the code
  did -a dc 17 +a 7 $tab Go To Line $chr(9) $+ Go to any line
  if ($var.read(Options,dmo.explorer) == on) { did -a dc 17 +xca 8 $tab Explorer $chr(9) $+ Show or hide Code Editor Explorer }
  else { did -a dc 17 +ca 8 $tab Explorer $chr(9) $+ Show or hide Code Editor Explorer }
  did -a dc 17 +a -
  did -a dc 17 +a 9 $tab Patterns $chr(9) $+ View available patterns
  did -a dc 17 +a 10 $tab Brackets $chr(9) $+ Check code for bracket errors
  did -i dc 3 1 setimage +nhd icon normal, $dm.icon(Explorer)
  did -i dc 3 1 setimage +nhd icon normal, $dm.icon(Information)
  did -i dc 3 1 setimage +nhd icon normal, $dm.icon(Search)
  if ($var.read(Options,dmo.explorer) == on) && ($var.read(Options,dmo.explorer.part) == Explorer) { did -a dc 3 +xgca 1 $tab $chr(9) $+ Explorer }
  else { did -a dc 3 +gca 1 $tab $chr(9) $+ Explorer }
  if ($var.read(Options,dmo.explorer) == on) && ($var.read(Options,dmo.explorer.part) == Information) { did -a dc 3 +xgca 2 $tab $chr(9) $+ Information | did -h DC 2 }
  else { did -a dc 3 +gca 2 $tab $chr(9) $+ Information }
  if ($var.read(Options,dmo.explorer) == on) && ($var.read(Options,dmo.explorer.part) == Search) { did -a dc 3 +xgca 3 $tab $chr(9) $+ Search Results | did -h DC 2 }
  else { did -a dc 3 +gca 3 $tab $chr(9) $+ Search Results }
  mdx SetFont 4,5,6,7,9,10 13 700 Tahoma
  mdx SetBorderStyle 5,7,9 border
  mdx SetColor 5,7,9 text $rgb(100,0,100)
  mdx SetColor 5,7,9 textbg $rgb(255,255,255)
  mdx SetColor 5,7,9 background $rgb(255,255,255)
  mdx SetControlMDX 2 TreeView haslines linesatroot hasbuttons showsel hottrack > $shortfn($scriptdir) $+ Data\Views.mdx
  .signal Modules_DC
  dm.language
  if ($exists($var.read(Variables,dmc.file)) == $true) { loadbuf -ro dc 1 $var.read(Variables,dmc.file) }
  if ($var.read(Options,dmo.explorer) == on) && ($var.read(Options,dmo.explorer.part) == Explorer) { dm.explorer.refresh }
  if ($var.read(Options,dmo.explorer) == on) && ($var.read(Options,dmo.explorer.part) == Information) {
    did -v DC 4,5,6,7,9,10
    did -i DM 3 2 Saving Code...
    savebuf -o dc 1 $shortfn($scriptdir) $+ Data\Temporary.tmp
    did -i DM 3 2 Ready
    did -ra DC 5 $did(DC,1).lines
    did -ra DC 7 $bytes($file($shortfn($scriptdir) $+ Data\Temporary.tmp).size,k).suf
    did -r DC 9
    set %i 1
    while (%i <= $cb(0)) && (%i <= 150) {
      did -a DC 9 $cb(%i) $crlf
      inc %i
    }
    unset %i
    .remove $shortfn($scriptdir) $+ Data\Temporary.tmp
  }
  if ($var.read(Options,dmo.explorer) == on) && ($var.read(Options,dmo.explorer.part) == Search) { did -v DC 8 }
}
on *:dialog:dc:close:*:{
  if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.dc.x $dialog(dc).x | var.set Options dmo.pos.dc.y $dialog(dc).y | var.set Options dmo.pos.dc.w $dialog(dc).w | var.set Options dmo.pos.dc.h $dialog(dc).h }
  if ($input(Save the code before exit?,yu,Code Editor: Close) == $true) {
    did -i DM 3 2 Saving Code...
    if ($did(1) !== $null) { savebuf -o dc 1 $var.read(Variables,dmc.file) }
    if ($did(1) == $null) { .remove $var.read(Variables,dmc.file) }
  }
  if ($dialog(dm)) { dialog -v DM DM }
}
on *:dialog:dc:sclick:8:did -fc DC 1 $gettok($did(dc,8).seltext,1,32)
on *:dialog:dc:edit:1:if ($var.read(Options,dmo.explorer.auto_refresh) == on) { dm.explorer.refresh }
on *:dialog:dc:sclick:13:{
  tokenize 32 $gettok($did(13),1-,32)
  if ($1 == size) {
    if ($var.read(Options,dmo.explorer) == on) { mdx MoveControl dc 1 * * $calc($dialog(dc).cw -167) $calc($dialog(dc).ch -72) }
    else { mdx MoveControl dc 1 4 * $calc($dialog(dc).cw -7) $calc($dialog(dc).ch -72) }
    mdx MoveControl dc 2 * * * $calc($dialog(dc).ch -111)
    mdx MoveControl dc 8 * * * $calc($dialog(dc).ch -111)
    mdx MoveControl dc 3 * $calc($dialog(dc).ch -40) * *
  }
  elseif ($1 == sizing) { did -a $dname 13 setSize c $iif($9 > 640,$9,640) $iif($10 > 480,$10,480) }
}
on *:dialog:dc:sclick:2:{
  if ($gettok($did(2,1),1,32) == slclick) && ($len($dm.tree(DC,2).sel) > 1) {
    if ($gettok($dm.tree(DC,2,$dm.tree(DC,2).root),1,32) == Aliases) { did -fc DC 1 $gettok($read($shortfn($scriptdir) $+ Data\Aliases.txt,$calc($gettok($dm.tree(DC,2).sel,2,32) -1)),1,32) }
    if ($gettok($dm.tree(DC,2,$dm.tree(DC,2).root),1,32) == Dialogs) { did -fc DC 1 $gettok($read($shortfn($scriptdir) $+ Data\Dialogs.txt,$calc($gettok($dm.tree(DC,2).sel,2,32) -1)),1,32) }
    if ($gettok($dm.tree(DC,2,$dm.tree(DC,2).root),1,32) == Menus) { did -fc DC 1 $gettok($read($shortfn($scriptdir) $+ Data\Menus.txt,$calc($gettok($dm.tree(DC,2).sel,2,32) -1)),1,32) }
    if ($gettok($dm.tree(DC,2,$dm.tree(DC,2).root),1,32) == Signals) { did -fc DC 1 $gettok($read($shortfn($scriptdir) $+ Data\Signals.txt,$calc($gettok($dm.tree(DC,2).sel,2,32) -1)),1,32) }
    if ($gettok($dm.tree(DC,2,$dm.tree(DC,2).root),1,32) == Events) { did -fc DC 1 $gettok($read($shortfn($scriptdir) $+ Data\Events.txt,$calc($gettok($dm.tree(DC,2).sel,2,32) -1)),1,32) }
    if ($gettok($dm.tree(DC,2,$dm.tree(DC,2).root),1,32) == Raw) { did -fc DC 1 $gettok($read($shortfn($scriptdir) $+ Data\Raws.txt,$calc($gettok($dm.tree(DC,2).sel,2,32) -1)),1,32) }
  }
  if ($gettok($did(2,1),1,32) == rclick) {
    set %hmenu $dm.mpdll(MPCreateMenu,Explorer)
    set %hmenu $gettok(%hmenu,2,32)
    dm.mpdll MPMenuColor Explorer > RGB_HIGH > $rgb(182,189,210)
    dm.mpdll MPMenuColor Explorer > RGB_HBOX > $rgb(10,36,106)
    dm.mpdll MPMenuColor Explorer > RGB_CSEP > $rgb(210,210,210)
    dm.mpdll MPMenuColor Explorer > RGB_BBOX > $rgb(205,207,214)
    dm.mpdll MPMenuColor Explorer > RGB_CBOX > $rgb(10,36,106)
    dm.mpdll MPAddItem %hmenu > 1 0 0 Refresh > dm.explorer.refresh
    dm.mpdll MPAddItem %hmenu > 100 0 0 - > -
    if ($var.read(Options,dmo.explorer.show_aliases) == on) { dm.mpdll MPAddItem %hmenu > 2 0 2 Aliases > dm.set.eo dmo.explorer.show_aliases }
    else { dm.mpdll MPAddItem %hmenu > 2 0 0 Aliases > dm.set.eo dmo.explorer.show_aliases }
    if ($var.read(Options,dmo.explorer.show_dialogs) == on) { dm.mpdll MPAddItem %hmenu > 3 0 2 Dialogs > dm.set.eo dmo.explorer.show_dialogs }
    else { dm.mpdll MPAddItem %hmenu > 3 0 0 Dialogs > dm.set.eo dmo.explorer.show_dialogs }
    if ($var.read(Options,dmo.explorer.show_menus) == on) { dm.mpdll MPAddItem %hmenu > 4 0 2 Menus > dm.set.eo dmo.explorer.show_menus }
    else { dm.mpdll MPAddItem %hmenu > 4 0 0 Menus > dm.set.eo dmo.explorer.show_menus }
    if ($var.read(Options,dmo.explorer.show_signals) == on) { dm.mpdll MPAddItem %hmenu > 5 0 2 Signals > dm.set.eo dmo.explorer.show_signals }
    else { dm.mpdll MPAddItem %hmenu > 5 0 0 Signals > dm.set.eo dmo.explorer.show_signals }
    if ($var.read(Options,dmo.explorer.show_events) == on) { dm.mpdll MPAddItem %hmenu > 6 0 2 Events > dm.set.eo dmo.explorer.show_events }
    else { dm.mpdll MPAddItem %hmenu > 6 0 0 Events > dm.set.eo dmo.explorer.show_events }
    if ($var.read(Options,dmo.explorer.show_raw_events) == on) { dm.mpdll MPAddItem %hmenu > 7 0 2 Raw Events > dm.set.eo dmo.explorer.show_raw_events }
    else { dm.mpdll MPAddItem %hmenu > 7 0 0 Raw Events > dm.set.eo dmo.explorer.show_raw_events }
    dm.mpdll MPAddItem %hmenu > 200 0 0 - > -
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { dm.mpdll MPAddItem %hmenu > 8 0 2 Auto Expand > dm.set.eo dmo.explorer.auto_expand }
    else { dm.mpdll MPAddItem %hmenu > 8 0 0 Auto Expand > dm.set.eo dmo.explorer.auto_expand }
    if ($var.read(Options,dmo.explorer.auto_refresh) == on) { dm.mpdll MPAddItem %hmenu > 9 0 2 Auto Refresh > dm.set.eo dmo.explorer.auto_refresh }
    else { dm.mpdll MPAddItem %hmenu > 9 0 0 Auto Refresh > dm.set.eo dmo.explorer.auto_refresh }
    set %hsmenu $gettok(%hsmenu,2,32)
    dm.mpdll MPopup Explorer > $mouse.dx $mouse.dy left top right
    unset %hsmenu
  }
}
on *:dialog:dc:sclick:3:{
  if ($did(3).sel == 2) { var.set Options dmo.explorer.part Explorer | dm.explorer.refresh | did -h DC 4,5,6,7,8,9,10 | did -v DC 2 }
  if ($did(3).sel == 3) {
    var.set Options dmo.explorer.part Information
    did -h DC 2,8
    did -v DC 4,5,6,7,9,10
    did -i DM 3 2 Saving Code...
    savebuf -o dc 1 $shortfn($scriptdir) $+ Data\Temporary.tmp
    did -i DM 3 2 Ready
    did -ra DC 5 $did(DC,1).lines
    did -ra DC 7 $bytes($file($shortfn($scriptdir) $+ Data\Temporary.tmp).size,k).suf
    did -r DC 9
    set %i 1
    while (%i <= $cb(0)) && (%i <= 150) {
      did -a DC 9 $cb(%i) $crlf
      inc %i
    }
    unset %i
    .remove $shortfn($scriptdir) $+ Data\Temporary.tmp
  }
  if ($did(3).sel == 4) { var.set Options dmo.explorer.part Search | did -h DC 2,4,5,6,7,9,10 | did -v DC 8 }
}
on *:dialog:dc:sclick:17:{
  if ($did(17).sel == 2) {
    did -i DM 3 2 Saving Code...
    if ($did(1) !== $null) { savebuf -o dc 1 $var.read(Variables,dmc.file) }
    if ($did(1) == $null) { .remove $var.read(Variables,dmc.file) }
    did -i DM 3 2 Ready
    dialog -x dc dc
  }
  elseif ($did(17).sel == 4) {
    clipboard $did(1).seltext
    did -r DC 9
    set %i 1
    while (%i <= $cb(0)) && (%i <= 150) {
      did -a DC 9 $cb(%i) $crlf
      inc %i
    }
    unset %i
  }
  elseif ($did(17).sel == 5) {
    set %i 1
    while (%i <= $cb(0)) {
      did -a dc 1 $cb(%i) $crlf
      inc %i
    }
  }
  elseif ($did(17).sel == 7) {
    savebuf -o dc 1 PRINT.txt
    run -n notepad /p PRINT.txt
    .timerPrint 1 1 .remove PRINT.txt
  }
  elseif ($did(17).sel == 8) { did -r dc 1 }
  elseif ($did(17).sel == 10) { dialog -mod DC.ST DC.ST }
  elseif ($did(17).sel == 11) { dialog -mod DC.GL DC.GL }
  elseif ($did(17).sel == 12) {
    if ($var.read(Options,dmo.explorer) == on) {
      var.set Options dmo.explorer off
      did -h DC 2,3,4,5,6,7,8,9,10
      mdx MoveControl dc 1 4 * $calc($dialog(dc).cw -7) $calc($dialog(dc).ch -72)
    }
    else {
      var.set Options dmo.explorer on
      did -v DC 2,3
      mdx MoveControl dc 1 164 * $calc($dialog(dc).cw -167) $calc($dialog(dc).ch -72)
      if ($var.read(Options,dmo.explorer.part) == Explorer) { did -o dc 3 2 +xgca 1 $tab | did -h DC 4,5,6,7,8,9,10 | did -v DC 2 | dm.explorer.refresh }
      if ($var.read(Options,dmo.explorer.part) == Information) {
        did -o dc 3 3 +xgca 2 $tab
        did -h DC 2,8
        did -v DC 4,5,6,7,9,10
        did -i DM 3 2 Saving Code...
        savebuf -o dc 1 $shortfn($scriptdir) $+ Data\Temporary.tmp
        did -i DM 3 2 Ready
        did -ra DC 5 $did(DC,1).lines
        did -ra DC 7 $bytes($file($shortfn($scriptdir) $+ Data\Temporary.tmp).size,k).suf
        did -r DC 9
        set %i 1
        while (%i <= $cb(0)) && (%i <= 150) {
          did -a DC 9 $cb(%i) $crlf
          inc %i
        }
        unset %i
        .remove $shortfn($scriptdir) $+ Data\Temporary.tmp
      }
      if ($var.read(Options,dmo.explorer.part) == Search) { did -o dc 3 4 +xgca 3 $tab | did -h DC 2,4,5,6,7,9,10 | did -v DC 8 }
    }
  }
  elseif ($did(17).sel == 14) {
    set %hmenu $dm.mpdll(MPCreateMenu,Patterns)
    set %hmenu $gettok(%hmenu,2,32)
    dm.mpdll MPMenuColor Patterns > RGB_HIGH > $rgb(182,189,210)
    dm.mpdll MPMenuColor Patterns > RGB_HBOX > $rgb(10,36,106)
    dm.mpdll MPMenuColor Patterns > RGB_CSEP > $rgb(210,210,210)
    dm.mpdll MPMenuColor Patterns > RGB_BBOX > $rgb(205,207,214)
    dm.mpdll MPMenuColor Patterns > RGB_CBOX > $rgb(10,36,106)
    set %i 1
    while (%i <= $ini($var.read(Variables,dm.ff),0)) {
      dm.mpdll MPAddIcon Patterns > $dm.icon(Patterns)
      dm.mpdll MPAddItem %hmenu > %i 1 0 $ini($var.read(Variables,dm.ff),%i) > did -a dc 1 $readini($var.read(Variables,dm.ff),$ini($var.read(Variables,dm.ff),%i),$ini($var.read(Variables,dm.ff),%i))
      inc %i
    }
    set %hsmenu $gettok(%hsmenu,2,32)
    dm.mpdll MPopup Patterns > $mouse.dx $mouse.dy left top right
    unset %hsmenu
  }
  elseif ($did(17).sel == 15) { dm.BracketCheck }
}
------------------------------------------------------------------
dialog DC.BC {
  title "Bracket Check"
  size -1 -1 421 255
  option pixels
  icon $dm.icon(Brackets), 0
  list 1, 0 1 421 235, size
  text "", 2, 0 237 420 18
}
on *:dialog:DC.BC:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.dc.bc.x) !== $null) && ($var.read(Options,dmo.pos.dc.bc.y) !== $null) { dialog -s dc.bc $var.read(Options,dmo.pos.dc.bc.x) $var.read(Options,dmo.pos.dc.bc.y) 420 255 }
  mdx SetControlMDX 1 ListView headerdrag sortascending single report grid rowselect > $shortfn($scriptdir) $+ Data\Views.mdx
  mdx SetFont 1 13 600 Tahoma
  did -i $dname 1 1 headerdims 199:1 200:2
  did -i $dname 1 1 headertext +c Error $chr(9) $+ +c Line
  mdx SetControlMDX 2 Progressbar smooth > $shortfn($scriptdir) $+ Data\ctl_gen.mdx
  did -a $dname 2 BarColor $rgb(0,0,0)
  .signal Modules_DC.BC
}
on *:dialog:DC.BC:sclick:1:did -c dc 1 $dm.cell(DC.BC,1,$did(1).sel,2)
on *:dialog:DC.BC:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.dc.bc.x $dialog(dc.bc).x | var.set Options dmo.pos.dc.bc.y $dialog(dc.bc).y }
------------------------------------------------------------------
dialog DC.GL {
  title "Go To Line..."
  size -1 -1 200 70
  option pixels
  icon $dm.icon(Goto), 0
  combo 1, 69 11 60 123, size
  box "", 2, 5 34 190 8
  button "&Go", 3, 20 47 80 20, default ok
  button "&Cancel", 4, 100 47 80 20, cancel
  button "", 5, 131 11 20 10
}
on *:dialog:dc.gl:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.dc.gl.x) !== $null) && ($var.read(Options,dmo.pos.dc.gl.y) !== $null) { dialog -s dc.gl $var.read(Options,dmo.pos.dc.gl.x) $var.read(Options,dmo.pos.dc.gl.y) 200 70 }
  mdx SetControlMDX 1 ComboBoxEx dropedit > $shortfn($scriptdir) $+ Data\Views.mdx
  mdx SetFont 1 13 700 Tahoma
  set %i 1
  while ($readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Goto,%i) !== $null) {
    did -a dc.gl 1 0 0 0 0 $readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Goto,%i)
    inc %i
  }
  unset %i
  did -c dc.gl 1 $did(1).lines
  .signal Modules_DC.GL
  dm.language
}
on *:dialog:dc.gl:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.dc.gl.x $dialog(dc.gl).x | var.set Options dmo.pos.dc.gl.y $dialog(dc.gl).y }
on *:dialog:dc.gl:sclick:3:{
  if ($mid($did(1),9,$len($did(1))) !== $null) {
    var.set Goto $calc($ini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Goto,0) +1) $mid($did(1),9,$len($did(1)))
    did -c dc 1 $mid($did(1),9,$len($did(1)))
  }
}
on *:dialog:dc.gl:sclick:5:var.unset Goto | did -r dc.gl 1
------------------------------------------------------------------
dialog DC.ST {
  title "Search..."
  size -1 -1 200 70
  option pixels
  icon $dm.icon(Search), 0
  box "", 2, 5 34 190 8
  button "&Find", 3, 20 47 80 20, default
  button "&Cancel", 4, 100 47 80 20, cancel
  button "", 5, 175 11 20 10
  combo 1, 4 11 169 123, size
}
on *:dialog:dc.st:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.dc.st.x) !== $null) && ($var.read(Options,dmo.pos.dc.st.y) !== $null) { dialog -s dc.st $var.read(Options,dmo.pos.dc.st.x) $var.read(Options,dmo.pos.dc.st.y) 200 70 }
  mdx SetControlMDX 1 ComboBoxEx dropedit > $shortfn($scriptdir) $+ Data\Views.mdx
  mdx SetFont 1 13 700 Tahoma
  set %i 1
  while ($readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Search,%i) !== $null) {
    did -a dc.st 1 0 0 0 0 $readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Search,%i)
    inc %i
  }
  unset %i
  did -c dc.st 1 $did(1).lines
  .signal Modules_DC.ST
  dm.language
}
on *:dialog:dc.st:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.dc.st.x $dialog(dc.st).x | var.set Options dmo.pos.dc.st.y $dialog(dc.st).y }
on *:dialog:dc.st:sclick:3:{
  if ($mid($did(dc.st,1),9,$len($did(dc.st,1))) !== $null) {
    var.set Search $calc($ini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Search,0) +1) $mid($did(dc.st,1),9,$len($did(dc.st,1)))
    did -a dc.st 1 0 0 0 0 $mid($did(dc.st,1),9,$len($did(dc.st,1)))
    filter -cnio DC 1 DC 8 * $+ $mid($did(dc.st,1),9,$len($did(dc.st,1))) $+ *
    if ($filtered > 0) {
      if ($var.read(Options,dmo.explorer) == off) {
        var.set Options dmo.explorer on
        var.set Options dmo.explorer.part Search
        did -o dc 17 12 +xca 8 $tab Explorer
        did -o dc 3 2 +gca 1 $tab
        did -o dc 3 3 +gca 2 $tab
        did -o dc 3 4 +xgca 3 $tab
        did -v DC 8,3
        mdx MoveControl dc 1 164 * $calc($dialog(dc).cw -167) $calc($dialog(dc).ch -72)
      }
      else { did -o dc 3 2 +gca 1 $tab | did -o dc 3 3 +gca 2 $tab | did -o dc 3 4 +xgca 3 $tab | did -h DC 2,4,5,6,7,9,10 | did -v DC 8 }
    }
  }
  else { dialog -x dc.st dc.st }
}
on *:dialog:dc.st:sclick:5:var.unset Search | did -r dc.st 1
------------------------------------------------------------------
dialog DU {
  title "Dialog Maker: Update"
  size -1 -1 500 264
  option pixels
  icon $dm.icon(Update), 0
  list 1, 10 10 480 160, size
  text "Progress:", 2, 10 179 115 16
  text "ProgressBar", 3, 10 202 480 18
  box "", 4, 10 224 480 8
  button "OK", 5, 405 239 85 20, default ok
  button "Refresh", 6, 209 239 75 20, flat
  button "Current", 7, 283 239 75 20, flat
  button "Download", 8, 10 239 100 20
  text "Update Size:", 9, 254 179 115 16
  text "Downloaded:", 10, 373 179 115 16
  text "Time:", 11, 169 179 81 16
  button "Stop", 12, 109 239 100 20
}
on *:dialog:du:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.du.x) !== $null) && ($var.read(Options,dmo.pos.du.y) !== $null) { dialog -s du $var.read(Options,dmo.pos.du.x) $var.read(Options,dmo.pos.du.y) 500 264 }
  mdx SetControlMDX 1 listview headerdrag grid sortascending showsel single report rowselect > $shortfn($scriptdir) $+ Data\Views.mdx
  did -i $dname 1 1 headerdims  180:1 220:2 58:3
  did -i $dname 1 1 headertext +c Update $chr(9) $+ +c URL $chr(9) $+ +c Size
  did -i $dname 1 1 seticon list $dm.icon(CurrentDownload)
  mdx SetControlMDX 3 Progressbar smooth > $shortfn($scriptdir) $+ Data\ctl_gen.mdx
  did -a $dname 3 BarColor $rgb(0,0,0)
  if ($exists($shortfn($scriptdir) $+ Data\Updates\Updates.txt) == $true) { loadbuf -ro du 1 $shortfn($scriptdir) $+ Data\Updates\Updates.txt }
  did -a du 7 $var.read(Variables,Full_Version)
  .signal Modules_DU
  dm.language
}
on *:dialog:du:sclick:12:sockclose dl.*
on *:dialog:du:dclick:1:dm.ds
on *:dialog:du:sclick:8:dm.ds
on *:dialog:du:sclick:6:dm.download www.dialogmaker.hit.bg/ Updates.txt
on *:dialog:du:close:*:{
  if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.du.x $dialog(du).x | var.set Options dmo.pos.du.y $dialog(du).y }
  if ($var.read(Variables,dm.download) !== $null) {
    var.unset Variables dm.download
    sockclose dl.*
  }
}
------------------------------------------------------------------
dialog DE {
  title "Dialog Maker: ERROR!"
  size -1 -1 300 130
  option pixels
  button "&OK", 1, 50 107 100 20, default cancel
  button "&Repair", 2, 150 107 100 20, disable ok
  text "", 3, 8 10 282 90, center
}
on *:dialog:de:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.de.x) !== $null) && ($var.read(Options,dmo.pos.de.y) !== $null) { dialog -s de $var.read(Options,dmo.pos.de.x) $var.read(Options,dmo.pos.de.y) 300 130 }
  mdx SetFont 1,2,3 13 600 Tahoma
  .signal Modules_DE
  dm.language
  did -a de 3 $var.read(Variables,dm.error)
  if ($var.read(Variables,dm.error.action) !== $null) { did -e de 2 }
}
on *:dialog:de:sclick:2:{
  $var.read(Variables,dm.error.action)
  if ($var.read(Variables,dm.error.after.action) !== $null) { $var.read(Variables,dm.error.after.action) }
}
on *:dialog:de:close:*:{
  if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.de.x $dialog(de).x | var.set Options dmo.pos.de.y $dialog(de).y }
  if ($dialog($var.read(Variables,dm.error.last.dialog)) !== $null) { dialog -v $var.read(Variables,dm.error.last.dialog) $var.read(Variables,dm.error.last.dialog) }
  var.unset Variables dm.error*
}
------------------------------------------------------------------
dialog DM.Loading {
  title "Loading"
  size -1 -1 421 255
  option pixels
  icon $dm.icon(OK), 0
  list 1, 0 1 421 235, size
  text "", 2, 0 237 420 18
}
on *:dialog:DM.Loading:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  if ($var.read(Options,dmo.remember.positions) == on) && ($var.read(Options,dmo.pos.DM.Loading.x) !== $null) && ($var.read(Options,dmo.pos.DM.Loading.y) !== $null) { dialog -s DM.Loading $var.read(Options,dmo.pos.DM.Loading.x) $var.read(Options,dmo.pos.DM.Loading.y) 420 255 }
  mdx SetControlMDX 1 ListView headerdrag icon single grid report rowselect > $shortfn($scriptdir) $+ Data\Views.mdx
  mdx SetFont 1 13 600 Tahoma
  did -i $dname 1 1 headerdims 199:1 200:2
  did -i $dname 1 1 headertext +c Section $chr(9) $+ +c Status
  did -i $dname 1 1 seticon normal 0 0, $+ $dm.icon(OK)
  did -i $dname 1 1 seticon normal 0 0, $+ $dm.icon(Error)
  mdx SetControlMDX 2 Progressbar > $shortfn($scriptdir) $+ Data\Ctl_gen.mdx
  did -a $dname 2 BarColor $rgb(0,0,0)
  did -a DM.Loading 1 0 + 0 0 0 Settings $chr(9) Loading...
  did -a DM.Loading 1 0 + 0 0 0 Controls $chr(9) Loading...
  did -a DM.Loading 1 0 + 0 0 0 Menus $chr(9) Loading...
  did -a DM.Loading 1 0 + 0 0 0 Code $chr(9) Loading...
  did -a DM.Loading 1 0 + 0 0 0 Loading Time $chr(9) Waiting...
  .signal Modules_DM.Loading
}
on *:dialog:DM.Loading:close:*:if ($var.read(Options,dmo.remember.positions) == on) { var.set Options dmo.pos.DM.Loading.x $dialog(DM.Loading).x | var.set Options dmo.pos.DM.Loading.y $dialog(DM.Loading).y }
------------------------------------------------------------------
dialog DM.Tips {
  title "Dialog Maker Tips"
  size -1 -1 450 330
  option pixels
  icon $shortfn($scriptdir) $+ Data\Icons\Tips.ico, 0
  box "", 1, -2 285 454 8
  icon 2, 0 0 128 128
  check "Always show tips at startup", 3, 9 302 225 20
  button "&Another Tip", 4, 242 302 100 20
  button "&Close", 5, 342 302 100 20, default ok
  text "", 6, -5 128 460 164
  text "", 7, 128 -1 400 130
  text "Tip Name", 8, 150 15 275 24, center
  text "Tip Text", 9, 5 140 438 140
}
on *:dialog:dm.tips:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  mdx SetColor dm.tips 6,7,8,9 background $rgb(255,255,255)
  mdx SetColor dm.tips 8,9 textbg $rgb(255,255,255)
  mdx SetColor dm.tips 8 text $rgb(100,0,100)
  mdx SetFont 8 20 700 Tahoma
  if ($var.read(Options,dmo.show.tips) == on) { did -c dm.tips 3 }
  did -g dm.tips 2 $shortfn($scriptdir) $+ Data\Icons\Tips.jpg
  var.set Temporary Tip $rand(1,$ini($shortfn($scriptdir) $+ Data\Tips.ini,0))
  did -ra dm.tips 8 $readini($shortfn($scriptdir) $+ Data\Tips.ini,$var.read(Temporary,Tip),Name)
  did -ra dm.tips 9 $readini($shortfn($scriptdir) $+ Data\Tips.ini,$var.read(Temporary,Tip),Tip)
  dm.language
}
on *:dialog:dm.tips:sclick:3:{
  if ($var.read(Options,dmo.show.tips) == on) { var.set Options dmo.show.tips off }
  else { var.set Options dmo.show.tips on }
}
on *:dialog:dm.tips:sclick:4:{
  var.set Temporary Tip $rand(1,$ini($shortfn($scriptdir) $+ Data\Tips.ini,0))
  did -ra dm.tips 8 $readini($shortfn($scriptdir) $+ Data\Tips.ini,$var.read(Temporary,Tip),Name)
  did -ra dm.tips 9 $readini($shortfn($scriptdir) $+ Data\Tips.ini,$var.read(Temporary,Tip),Tip)
}
------------------------------------------------------------------
dialog DM.Convert {
  title "Converting... (Errors: 0)"
  size -1 -1 400 37
  option pixels
  text "", 1, 5 10 390 18
}
on *:dialog:DM.Convert:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  mdx SetDialog dm.convert style title
  mdx SetControlMDX 1 Progressbar smooth > $shortfn($scriptdir) $+ Data\Ctl_gen.mdx
  did -a $dname 1 BarColor $rgb(0,0,0)
}
------------------------------------------------------------------
dialog VisualEditor {
  title "Visual Editor"
  size $var.read(Variables,dm.dx) $var.read(Variables,dm.dy) $var.read(Variables,dm.dw) $var.read(Variables,dm.dh)
  option pixels
  icon $dm.icon(Control), 0
  button "Positioner", 3000, 0 0 0 0
}
on *:dialog:visualeditor:init:*:{
  mdx SetMircVersion $version
  mdx MarkDialog $dname
  mdx SetControlMDX 3000 positioner size minbox maxbox > $shortfn($scriptdir) $+ Data\Dialog.mdx
  dialog -t VisualEditor Visual Editor - $var.read(Variables,dm.dt)
  .signal Modules_VisualEditor
}
on *:dialog:VisualEditor:sclick:*:{ if ($var.read(Variables,dm.control) !== $null) { Add.control } }
on *:dialog:visualeditor:sclick:3000:{
  if ($gettok($did(3000),1,32) == sizing) {
    var.set Variables dm.dw $calc($gettok($did(3000),9,32) +2)
    did -i DM 30 1 $var.read(Variables,dm.dw) 0 9999 10 0:1,2:5,5:20
    var.set Variables dm.dh $calc($gettok($did(3000),10,32) +2)
    did -i DM 47 1 $var.read(Variables,dm.dh) 0 9999 10 0:1,2:5,5:20
  }
}
------------------------------------------------------------------
----------------------------VARIABLES-----------------------------
------------------------------------------------------------------
alias var.set {
  if ($1 !== $null) && ($2 !== $null) && ($3- !== $null) { writeini $shortfn($scriptdir) $+ Data\DialogMaker.ini $1 $2 $3- }
  if ($1 !== $null) && ($2 !== $null) && ($3- == $null) { remini $shortfn($scriptdir) $+ Data\DialogMaker.ini $1 $2 }
}
alias var.unset {
  set %var.file $shortfn($scriptdir) $+ Data\DialogMaker.ini
  set %i 1
  if ($1 !== $null) && ($2 !== $null) { remini %var.file $1 $2 }
  if ($1 !== $null) && ($2 == $null) { remini %var.file $1 }
  if ($1 !== $null) && ($2- !== $null) && ($pos($2-, $chr(44),0) !== $null) {
    while ($pos($2-, $chr(44), $calc(%i -1)) !== $null) {
      remini %var.file $1 $gettok($2-, %i, 44)
      inc %i
    }
  }
  if ($1 !== $null) && ($2- !== $null) && ($right($2-, 1) == *) {
    while (%i <= $ini(%var.file,$1,0)) {
      while ($left($2-, $calc($len($2-) -1)) == $left($ini(%var.file,$1, %i), $calc($len($2-) -1))) { remini %var.file $1 $ini(%var.file,$1,%i) }
      inc %i
    }
  }
  if ($1 !== $null) && ($2- !== $null) && ($left($2-, 1) == *) {
    while (%i <= $ini(%var.file,$1,0)) {
      while ($right($2-, $calc($len($2-) -1)) == $right($ini(%var.file,$1, %i), $calc($len($2-) -1))) { remini %var.file $1 $ini(%var.file,$1,%i) }
      inc %i
    }
  }
  unset %i
  unset %var.file
}
alias var.inc {
  if ($1 !== $null) && ($2 !== $null) && ($3 == $null) { writeini $shortfn($scriptdir) $+ Data\DialogMaker.ini $1 $2 $calc($readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,$1,$2) + 1) }
  if ($1 !== $null) && ($2 !== $null) && ($3 !== $null) { writeini $shortfn($scriptdir) $+ Data\DialogMaker.ini $1 $2 $calc($readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,Variables,$2) + $3) }
}
alias var.dec {
  if ($1 !== $null) && ($2 !== $null) && ($3 == $null) { writeini $shortfn($scriptdir) $+ Data\DialogMaker.ini $1 $2 $calc($readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,$1,$2) - 1) }
  if ($1 !== $null) && ($2 !== $null) && ($3 !== $null) { writeini $shortfn($scriptdir) $+ Data\DialogMaker.ini $1 $2 $calc($readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,$1,$2) - $3) }
}
alias var.read {
  if ($1 !== $null) && ($2 !== $null) { return $readini($shortfn($scriptdir) $+ Data\DialogMaker.ini,$1,$2) }
}
------------------------------------------------------------------
alias dm.error {
  var.set Variables dm.error $1
  var.set Variables dm.error.last.dialog $dname
  if ($2 !== $null) { var.set Variables dm.error.action $2 }
  if ($3- !== $null) { var.set Variables dm.error.after.action $3- }
  if ($dialog(de) == $null) { dialog -mo de de }
}
alias dm.download {
  var.set Temporary socket $+(dl,$chr(46),$nopath($2))
  if (!$sock($var.read(Temporary,socket))) {
    sockopen $var.read(Temporary,socket) $1 80
    sockmark $var.read(Temporary,socket) HEAD $1 $2
  }
  else { $dm.error(Socket already in use.) }
}
alias dm.percent return $+($round($calc((100 / $2) * $1),2),%)
on *:SOCKOPEN:dl.*:{
  did -i DM 3 2 Downloading...
  if ($sockerr) { .echo -q $dm.error($sock($sockname).wsmsg) | return }
  hadd -m ticks $sockname $ticks
  var.set Temporary file $nopath($gettok($sock($sockname).mark,3,32))
  var.set Temporary fullfile $shortfn($scriptdir) $+ Data\Updates\ $+ $var.read(Temporary,file)
  var.set Temporary sckr sockwrite -n $sockname
  var.set Temporary ^ $gettok($sock($sockname).mark,3,32)
  write -c $var.read(Temporary,fullfile)
  $var.read(Temporary,sckr) GET $iif(left($var.read(^),1) != $chr(47),$chr(47) $+ $var.read(^),$var.read(^)) HTTP/1.0
  $var.read(Temporary,sckr) HOST: $gettok($sock($sockname).mark,2,32)
  $var.read(Temporary,sckr) ACCEPT: *.*
  $var.read(Temporary,sckr) $crlf
}
on *:SOCKREAD:dl.*:{
  if ($sockerr) {
    .echo -q $dm.error($sock($sockname).wsmsg)
    return
  }
  unset %a
  :begin
  if ($gettok($sock($sockname).mark,1,32) == head) { sockread %a }
  else { sockread &b }
  if ($sockbr) {
    tokenize 32 $sock($sockname).mark
    if ($1 == HEAD) {
      if (%a) {
        if ($gettok(%a,1,32) == Content-Length:) { var.set totsize $gettok(%a,2,32) }
      }
      else {
        did -ra du 9 Update Size: $bytes($var.read(totsize)).suf
        sockmark $sockname GET $2- $var.read(totsize)
      }
    }
    elseif ($1 == GET) {
      var.set Temporary file $shortfn($scriptdir) $+ Data\Updates\ $+ $nopath($3)
      var.set Temporary cursize $file($var.read(Temporary,file)).size
      var.set Temporary totsize $gettok($sock($sockname).mark,4,32)
      did -ra du 10 Downloaded: $bytes($var.read(Temporary,cursize)).suf
      did -a du 3 $int($remove($dm.percent($var.read(Temporary,cursize),$var.read(totsize)),%)) 0 100
      did -ra du 2 Progress: $dm.percent($var.read(Temporary,cursize),$var.read(totsize))
      bwrite $var.read(Temporary,file) -1 &b
    }
    goto begin
  }
}

on *:SOCKCLOSE:dl.*:{
  var.set ticks $calc(($ticks - $hget(ticks,$sockname)) /1000)
  did -ra du 2 Progress: 100%
  did -a du 3 100 0 100
  did -ra du 11 Time: $var.read(ticks)
  if ($var.read(Variables,dm.download) !== $null) {
    var.unset Variables dm.download
    did -i DM 3 2 Installing...
    .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -dQ2 $var.read(Temporary,fullfile) $deltok($scriptdir,-1,92))
    .echo -q $dm.error(The selected update was downloaded and installed successfully. To apply the changes please click 'Repair' to exit mIRC.,exit)
  }
  if ($exists($shortfn($scriptdir) $+ Data\Updates\Updates.txt) == $true) { loadbuf -ro du 1 $shortfn($scriptdir) $+ Data\Updates\Updates.txt }
  did -i DM 3 2 Ready
}
alias dm.open {
  if ($var.read(Options,dmo.file.last) == $null) {
    if ($1 == $null) && ($2 == $null) && ($3 == $null) { var.set Variables dm.file.test $sfile(*.dm,Open Dialog Maker Project,Open) }
    else { var.set Variables dm.file.test $sfile($2, $3,Open) }
  }
  if ($var.read(Options,dmo.file.last) !== $null) {
    if ($1 == $null) && ($2 == $null) && ($3 == $null) { var.set Variables dm.file.test $sfile($var.read(Options,dmo.file.last) *.dm,Open Dialog Maker Project,Open) }
    else { var.set Variables dm.file.test $sfile($var.read(Options,dmo.file.last) $2, $3,Open) }
  }
  if ($var.read(Variables,dm.file.test) !== $null) {
    var.set Options dmo.file.last $nofile($var.read(Variables,dm.file.test))
    var.set Variables dm.file $shortfn($var.read(Variables,dm.file.test))
    if ($1 !== $null) { open.DM $1 }
    if ($1 == $null) { open.DM DialogMaker }
    did -i DM 3 2 Opening Project...
    did -ra DM 29 $var.read(Variables,dm.dn)
    did -ra DM 26 $var.read(Variables,dm.dt)
    did -i DM 27 1 $var.read(Variables,dm.dx) -1 9999 10 0:1,2:5,5:20
    did -i DM 28 1 $var.read(Variables,dm.dy) -1 9999 10 0:1,2:5,5:20
    did -i DM 30 1 $var.read(Variables,dm.dw) 0 9999 10 0:1,2:5,5:20
    did -i DM 47 1 $var.read(Variables,dm.dh) 0 9999 10 0:1,2:5,5:20
    did -ra DM 1 $var.read(Variables,dm.di)
    if ($var.read(Variables,dm.do) == DBU) { did -c DM 48 }
    did -i DM 3 2 Opening Visual Editor...
    dm.ve
    if ($var.read(Variables,dm.di) !== $null) { did -ra DM 1 $var.read(Variables,dm.di) }
    if ($var.read(Variables,dm.dt) !== $null) { dialog -t VisualEditor Visual Editor - $var.read(Variables,dm.dt) }
    else { dialog -t VisualEditor Visual Editor }
    if ($dialog(ce) !== $null) { dm.ce }
    if ($var.read(Variables,File.Type) == $null) {
      if ($right($var.read(Variables,dm.file),2) == dm) { var.set Variables File.Type DialogMaker }
      if ($right($var.read(Variables,dm.file),2) == ds) { var.set Variables File.Type DialogStudio }
    }
    dm.build $var.read(Variables,File.Type)
    if ($dialog(DM.Loading)) {
      did -o DM.Loading 1 3 0 + 1 0 0 Controls $chr(9) OK (Controls: $calc(%dm.fi -1) $+ )
      did -a DM.Loading 2 2 0 4
      did -i DM 3 3 $nopath($longfn($var.read(Variables,dm.file))) ( $+ $bytes($file($var.read(Variables,dm.file)).size,k).suf $+ )

      did -o DM.Loading 1 4 0 + 1 0 0 Menus $chr(9) OK
      did -a DM.Loading 2 3 0 4
      if ($var.read(Variables,dm.fn) !== $null) {
        if ($exists($var.read(Variables,dm.fn)) == $true) { did -o DM.Loading 1 5 0 + 1 0 0 Code $chr(9) OK }
        else { dm.cnd | did -o DM.Loading 1 5 0 + 2 0 0 Code $chr(9) Repaired }
      }
      else { did -o DM.Loading 1 5 0 + 1 0 0 Code $chr(9) OK }
      did -a DM.Loading 2 4 0 4
      set %time2 $duration($time)
      did -o DM.Loading 1 6 0 + 0 0 0 Loading Time $chr(9) $duration($calc(%time2 - %time1))
      unset %time1
      unset %time2
      if ($var.read(Options,dmo.close.loading) == on) { dialog -x DM.Loading DM.Loading }
      else { .timerActive2 1 0 dialog -v DM.Loading DM.Loading }
    }
  }
}
alias open.dm {
  set %time1 $duration($time)
  set %dm.errors 0
  if ($1 == DialogMaker) {
    if ($dialog(DM.Loading)) { did -r DM.Loading 2 | dialog -v DM.Loading DM.Loading }
    else { dialog -md DM.Loading DM.Loading }
    var.set Variables dm.dn $readini($var.read(Variables,dm.file),Dialog,Name)
    var.set Variables dm.fn $nofile($var.read(Variables,dm.file)) $+ $var.read(Variables,dm.dn) $+ .mrc
    did -a DM.Loading 2 1 0 10
    var.set Variables dm.fn2 $var.read(Variables,dm.file)
    did -a DM.Loading 2 2 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,Name) == $null) { writeini $var.read(Variables,dm.fn2) Dialog Name Unknown | inc %dm.errors }
    did -a DM.Loading 2 3 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,Title) !== $null) { var.set Variables dm.dt $readini($var.read(Variables,dm.file),Dialog,Title) }
    did -a DM.Loading 2 4 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,Option) !== $null) { var.set Variables dm.DO $readini($var.read(Variables,dm.file),Dialog,Option) }
    else { var.unset Variables dm.DO }
    did -a DM.Loading 2 5 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,Icon) !== $null) { var.set Variables dm.di $readini($var.read(Variables,dm.file),Dialog,Icon) }
    else { var.unset Variables dm.di }
    did -a DM.Loading 2 6 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,X) == $null) { writeini $var.read(Variables,dm.fn2) Dialog X -1 | inc %dm.errors }
    var.set Variables dm.dx $readini($var.read(Variables,dm.file),Dialog,X)
    did -a DM.Loading 2 7 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,Y) == $null) { writeini $var.read(Variables,dm.fn2) Dialog Y -1 | inc %dm.errors }
    var.set Variables dm.dy $readini($var.read(Variables,dm.file),Dialog,Y)
    did -a DM.Loading 2 8 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,W) == $null) { writeini $var.read(Variables,dm.fn2) Dialog W 640 | inc %dm.errors }
    var.set Variables dm.dw $readini($var.read(Variables,dm.file),Dialog,W)
    did -a DM.Loading 2 9 0 10
    if ($readini($var.read(Variables,dm.file),Dialog,H) == $null) { writeini $var.read(Variables,dm.fn2) Dialog H 480 | inc %dm.errors }
    var.set Variables dm.dh $readini($var.read(Variables,dm.file),Dialog,H)
    did -a DM.Loading 2 10 0 11
    if (%dm.errors = 0) { did -o DM.Loading 1 2 0 + 1 0 0 Settings $chr(9) OK }
    else { did -o DM.Loading 1 2 0 + 2 0 0 Settings $chr(9) Repaired (Errors: %dm.errors $+ ) }
    did -a DM.Loading 2 1 0 4
  }
  if ($1 == DialogStudio) {
    var.unset Variables dm.fn
    mkdir $remove($nopath($var.read(Variables,dm.file)),.ds)
    var.set Variables dm.fn2 $remove($nopath($var.read(Variables,dm.file)),.ds) $+ \ $+ $remove($nopath($var.read(Variables,dm.file)),.ds) $+ .dm
    if ($readini($var.read(Variables,dm.file),Main,Name) == $null) { writeini $var.read(Variables,dm.file) Main Name Unknown | inc %dm.errors }
    var.set Variables dm.dn $readini($var.read(Variables,dm.file),Main,Name)
    if ($readini($var.read(Variables,dm.file),Main,Title) !== $null) { var.set Variables dm.dt $readini($var.read(Variables,dm.file),Main,Title) }
    if ($gettok($readini($var.read(Variables,dm.file),Main,Options),3,44) == 1) { did -c DM 48 | var.set Variables dm.DO dbu }
    if ($readini($var.read(Variables,dm.file),Main,IconPath) !== $null) { var.set Variables dm.di $readini($var.read(Variables,dm.file),Main,IconPath) }
    if ($readini($var.read(Variables,dm.file),Main,Position) == $null) { writeini $var.read(Variables,dm.fn2) Main Position -1 $+ $chr(44) $+ -1 $+ $chr(44) $+ 640 $+ $chr(44) $+ 480  | inc %dm.errors }
    var.set Variables dm.dx $gettok($readini($var.read(Variables,dm.file),Main,Position),1,44)
    var.set Variables dm.dy $gettok($readini($var.read(Variables,dm.file),Main,Position),2,44)
    var.set Variables dm.dw $gettok($readini($var.read(Variables,dm.file),Main,Position),3,44)
    var.set Variables dm.dh $gettok($readini($var.read(Variables,dm.file),Main,Position),4,44)
    writeini $var.read(Variables,dm.fn2) Dialog Name $var.read(Variables,dm.dn)
    writeini $var.read(Variables,dm.fn2) Dialog Title $var.read(Variables,dm.dt)
    writeini $var.read(Variables,dm.fn2) Dialog Option Pixels
    if ($var.read(Variables,dm.di) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog Icon $var.read(Variables,dm.di) }
    if ($var.read(Variables,dm.dx) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog X $var.read(Variables,dm.dx) }
    if ($var.read(Variables,dm.dy) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog Y $var.read(Variables,dm.dy) }
    if ($var.read(Variables,dm.dw) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog W $var.read(Variables,dm.dw) }
    if ($var.read(Variables,dm.dh) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog H $var.read(Variables,dm.dh) }
  }
}
alias dm.save {
  var.set Variables dm.dn $did(dm,29)
  var.set Variables dm.dt $did(dm,26)
  var.unset Variables dm.dx,dm.dy,dm.dw,dm.dh
  var.set Variables dm.dx $dm.edit(dm,27)
  var.set Variables dm.dy $dm.edit(dm,28)
  if ($dm.edit(dm,30) > 0) { var.set Variables dm.dw $dm.edit(dm,30) }
  if ($dm.edit(dm,47) > 0) { var.set Variables dm.dh $dm.edit(dm,47) }
  if ($var.read(Variables,dm.dn) == $null) { .echo -q $dm.error(Please enter dialog name!) }
  elseif ($var.read(Variables,dm.dx) == $null) || ($var.read(Variables,dm.dy) == $null) || ($var.read(Variables,dm.dw) == $null) || ($var.read(Variables,dm.dh) == $null) { .echo -q $dm.error(Please enter dialog size and/or position!) }
  if ($var.read(Variables,dm.dn) !== $null) && ($var.read(Variables,dm.dx) !== $null) && ($var.read(Variables,dm.dy) !== $null) && ($var.read(Variables,dm.dw) !== $null) && ($var.read(Variables,dm.dh) !== $null) { dm.cnd | dm.ve | dm.build }
}
alias dm.cnd {
  did -i DM 3 2 Saving Data...
  var.set Variables dm.dn $did(dm,29)
  var.set Variables dm.dt $did(dm,26)
  var.set Variables dm.di $did(dm,1)
  var.set Variables dm.dx $dm.edit(dm,27)
  var.set Variables dm.dy $dm.edit(dm,28)
  var.set Variables dm.dw $dm.edit(dm,30)
  var.set Variables dm.dh $dm.edit(dm,47)
  var.set Variables dm.fn2 $shortfn($mircdir) $+ $var.read(Variables,dm.dn) $+ \ $+ $var.read(Variables,dm.dn) $+ .dm
  var.set Variables dmc.file $nofile($shortfn($var.read(Variables,dm.file))) $+ $remove($nopath($var.read(Variables,dm.file)),$right($nopath($var.read(Variables,dm.file)),2)) $+ dmc
  if ($var.read(Variables,dm.dn) !== $null) {
    did -i DM 3 2 Writing Data...
    if ($exists($var.read(Variables,dm.dn)) == $false) { mkdir $var.read(Variables,dm.dn) }
    writeini $var.read(Variables,dm.fn2) Dialog Name $var.read(Variables,dm.dn)
    if ($var.read(Variables,dm.dt) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog Title $var.read(Variables,dm.dt) }
    else { remini $var.read(Variables,dm.fn2) Dialog Title }
    if ($var.read(Variables,dm.do) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog Option $var.read(Variables,dm.do) }
    else { remini $var.read(Variables,dm.fn2) Dialog Option }
    if ($var.read(Variables,dm.di) !== $null) { writeini $var.read(Variables,dm.fn2) Dialog Icon $var.read(Variables,dm.di) }
    else { remini $var.read(Variables,dm.fn2) Dialog Icon }
    writeini $var.read(Variables,dm.fn2) Dialog X $var.read(Variables,dm.dx)
    writeini $var.read(Variables,dm.fn2) Dialog Y $var.read(Variables,dm.dy)
    writeini $var.read(Variables,dm.fn2) Dialog W $var.read(Variables,dm.dw)
    writeini $var.read(Variables,dm.fn2) Dialog H $var.read(Variables,dm.dh)
    var.set Variables dm.file $shortfn($var.read(Variables,dm.fn2))
    var.set Variables dm.fn $shortfn($var.read(Variables,dm.dn)) $+ \ $+ $var.read(Variables,dm.dn) $+ .mrc
    write -c $var.read(Variables,dm.fn) dialog $var.read(Variables,dm.dn) $chr(123)
    write $var.read(Variables,dm.fn) title $var.read(Variables,dm.dt)
    write $var.read(Variables,dm.fn) size $var.read(Variables,dm.dx) $var.read(Variables,dm.dy) $var.read(Variables,dm.dw) $var.read(Variables,dm.dh)
    if ($var.read(Variables,dm.do) !== $null) { write $var.read(Variables,dm.fn) option $var.read(Variables,dm.do) }
    if ($var.read(Variables,dm.di) !== $null) { write $var.read(Variables,dm.fn) icon $var.read(Variables,dm.di) $+ , 0 }
    set %dm.fi 1
    while (%dm.fi < $ini($var.read(Variables,dm.fn2),0)) {
      if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) !== $null) {
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Text) {
          write $var.read(Variables,dm.fn) text " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,NoWordwrap) $readini($var.read(Variables,dm.fn2), %dm.fi ,Align) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), $var.read(Variables,dm.dm.fi) ,Tab)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Button) {
          var.set Temporary part1 button " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Default)
          var.set Temporary part2 $readini($var.read(Variables,dm.fn2), %dm.fi ,Flat) $readini($var.read(Variables,dm.fn2), %dm.fi ,MultiLine) $readini($var.read(Variables,dm.fn2), %dm.fi ,Type) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab)
          write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Edit) {
          if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Limit) !== $null) {
            var.set Temporary part1 edit " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Password) $readini($var.read(Variables,dm.fn2), %dm.fi ,ReadOnly) $readini($var.read(Variables,dm.fn2), %dm.fi ,Return) $readini($var.read(Variables,dm.fn2), %dm.fi ,AutoHS) $readini($var.read(Variables,dm.fn2), %dm.fi ,AutoVS) $readini($var.read(Variables,dm.fn2), %dm.fi ,HScroll) $readini($var.read(Variables,dm.fn2), %dm.fi ,VScroll)
            var.set Temporary part2 Limit $readini($var.read(Variables,dm.fn2), %dm.fi ,Limit) $readini($var.read(Variables,dm.fn2), %dm.fi ,Align) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(dm.fn2), %dm.fi ,Group) $readini($var.read(dm.fn2), %dm.fi ,Tab)
            write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
          }
          else {
            var.set Temporary part1 edit " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Password) $readini($var.read(Variables,dm.fn2), %dm.fi ,ReadOnly) $readini($var.read(Variables,dm.fn2), %dm.fi ,Return)
            var.set Temporary part2 $readini($var.read(Variables,dm.fn2), %dm.fi ,AutoHS) $readini($var.read(Variables,dm.fn2), %dm.fi ,AutoVS) $readini($var.read(Variables,dm.fn2), %dm.fi ,HScroll) $readini($var.read(Variables,dm.fn2), %dm.fi ,VScroll) $readini($var.read(Variables,dm.fn2), $var.read(Variables,dm.fn2), %dm.fi ,Align) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab)
            write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
          }
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Check) {
          var.set Temporary part1 check " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Push) $readini($var.read(Variables,dm.fn2), %dm.fi ,Flat) $readini($var.read(Variables,dm.fn2), %dm.fi ,3State)
          var.set Temporary part2 $readini($var.read(Variables,dm.fn2), %dm.fi ,Align) $readini($var.read(Variables,dm.fn2), %dm.fi ,Type) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab)
          write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Radio) {
          var.set Temporary part1 radio " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Push) $readini($var.read(Variables,dm.fn2), %dm.fi ,Flat) $readini($var.read(Variables,dm.fn2), %dm.fi ,Align) $readini($var.read(Variables,dm.fn2), %dm.fi ,Type) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide)
          var.set Temporary part2 $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group)
          write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Icon) {
          write $var.read(Variables,dm.fn) icon %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Icon) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,NoBorder) $readini($var.read(Variables,dm.fn2), %dm.fi ,Align) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Link) { write $var.read(Variables,dm.fn) link " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab) }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Box) { write $var.read(Variables,dm.fn) box " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab) }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Scroll) {
          if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Minimum) !== $null) && ($readini($var.read(Variables,dm.fn2), %dm.fi ,Maximum) !== $null) {
            write $var.read(Variables,dm.fn) scroll "" $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , Range $readini($var.read(Variables,dm.fn2), %dm.fi ,Minimum) $readini($var.read(Variables,dm.fn2), %dm.fi ,Maximum) $readini($var.read(Variables,dm.fn2), %dm.fi ,Type) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), $var.read(dm.fi) ,Group) $readini($var.read(dm.fn2), $var.read(dm.fi) ,Tab)
          }
          else { write $var.read(Variables,dm.fn) scroll "" $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Type) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab) }
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == List) {
          var.set Temporary part1 list %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Sorted) $readini($var.read(Variables,dm.fn2), %dm.fi ,Extended) $readini($var.read(Variables,dm.fn2), %dm.fi ,Force) $readini($var.read(Variables,dm.fn2), %dm.fi ,Multi) $readini($var.read(Variables,dm.fn2), %dm.fi ,Horizontal)
          var.set Temporary part2 $readini($var.read(Variables,dm.fn2), %dm.fi ,Vertical) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab)
          write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Combo) {
          var.set Temporary part1 combo %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,Sorted) $readini($var.read(Variables,dm.fn2), %dm.fi ,Editable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Force) $readini($var.read(Variables,dm.fn2), %dm.fi ,Horizontal) $readini($var.read(Variables,dm.fn2), %dm.fi ,Vertical)
          var.set Temporary part2 $readini($var.read(Variables,dm.fn2), %dm.fi ,Type) $readini($var.read(Variables,dm.fn2), %dm.fi ,Disable) $readini($var.read(Variables,dm.fn2), %dm.fi ,Hide) $readini($var.read(Variables,dm.fn2), %dm.fi ,Result) $readini($var.read(Variables,dm.fn2), %dm.fi ,Group) $readini($var.read(Variables,dm.fn2), %dm.fi ,Tab)
          write $var.read(Variables,dm.fn) $var.read(Temporary,part1) $var.read(Temporary,part2)
        }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Tab) { write $var.read(Variables,dm.fn) tab " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi $+ , $readini($var.read(Variables,dm.fn2), %dm.fi ,X) $readini($var.read(Variables,dm.fn2), %dm.fi ,Y) $readini($var.read(Variables,dm.fn2), %dm.fi ,W) $readini($var.read(Variables,dm.fn2), %dm.fi ,H) }
        if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == +Tab) { write $var.read(Variables,dm.fn) tab " $+ $readini($var.read(Variables,dm.fn2), %dm.fi ,Text) $+ " $+ , %dm.fi }
      }
      inc %dm.fi
    }
    if (%dm.fi == $ini($var.read(Variables,dm.fn2),0)) { unset %dm.fi }
    write $var.read(Variables,dm.fn) $chr(125)
    set %i 1
    while (%i <= $lines($var.read(Variables,dmc.file))) {
      write $var.read(Variables,dm.fn) $read($var.read(Variables,dmc.file),n, %i)
      inc %i
    }
    var.unset Temporary part*
    unset %i
    .load -rs $shortfn($var.read(Variables,dm.fn))
  }
  did -i DM 3 2 Ready
  did -i DM 3 3 $nopath($longfn($var.read(Variables,dm.file))) ( $+ $bytes($file($var.read(Variables,dm.file)).size,k).suf $+ )
}
alias dm {
  if ($dialog(dm)) { dialog -x DM DM | dialog -md DM DM }
  else { dialog -md DM DM }
}
menu channel,status,menubar {
  MIRC Addons
  .Dialog Maker:dm
}
alias add.control {
  var.set Variables dm.mousex $mouse.x
  var.set Variables dm.mousey $mouse.y
  did -i DM 3 2 Ready
  if ($var.read(Variables,dm.control) == Tab) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Tab
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Tab $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 200
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 100
    did -bu DM 13
  }
  if ($var.read(Variables,dm.control) == Text) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Text
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Text $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 45
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 15
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) text $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 45 15
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Text $var.read(Variables,dm.id)
    did -u DM 9
  }
  if ($var.read(Variables,dm.control) == Button) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Button
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Button $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 75
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 20
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) button $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 75 20
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Button $var.read(Variables,dm.id)
    did -u DM 7
  }
  if ($var.read(Variables,dm.control) == Icon) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Icon
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 32
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 32
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) button $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 32 32
    mdx SetBorderStyle VisualEditor $var.read(Variables,dm.id) clientedge
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) ( $+ $var.read(Variables,dm.id) $+ )
    did -u DM 14
  }
  if ($var.read(Variables,dm.control) == Check) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Check
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Check $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 80
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 15
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) check $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 80 20
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Check $var.read(Variables,dm.id)
    did -u DM 15
  }
  if ($var.read(Variables,dm.control) == Edit) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Edit
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Edit $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 100
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 20
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) edit $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 100 20
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Edit $var.read(Variables,dm.id)
    did -u DM 8
  }
  if ($var.read(Variables,dm.control) == Radio) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Radio
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Radio $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 80
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 15
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) radio $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 80 20
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Radio $var.read(Variables,dm.id)
    did -u DM 16
  }
  if ($var.read(Variables,dm.control) == Link) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Link
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Link $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 45
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 15
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) text $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 45 15
    mdx SetColor VisualEditor $var.read(Variables,dm.id) text $rgb(0,0,255)
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Link $var.read(Variables,dm.id)
    did -u DM 10
  }
  if ($var.read(Variables,dm.control) == Box) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Box
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Text Box $var.read(Variables,dm.id)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 100
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 100
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) box $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 100 100
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -a VisualEditor $var.read(Variables,dm.id) Box $var.read(Variables,dm.id)
    did -u DM 11
  }
  if ($var.read(Variables,dm.control) == Scroll) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Scroll
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 16
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 100
    did -u DM 12
  }
  if ($var.read(Variables,dm.control) == List) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control List
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 100
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 100
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) list $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 100 100
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -u DM 17
  }
  if ($var.read(Variables,dm.control) == Combo) {
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Control Combo
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) X $var.read(Variables,dm.mousex)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) Y $var.read(Variables,dm.mousey)
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) W 100
    writeini $var.read(Variables,dm.fn2) $var.read(Variables,dm.id) H 100
    mdx DynamicControl create VisualEditor $var.read(Variables,dm.id) combo $var.read(Variables,dm.mousex) $var.read(Variables,dm.mousey) 100 100
    mdx SetFont VisualEditor $var.read(Variables,dm.id) 13 200 Tahoma
    did -u DM 18
  }
  if ($dialog(ce) == $null) { dialog -md ce ce }
  dm.ce
  did -cf ce 4 $did(ce,4).lines
  sel.control
  var.unset Variables dm.control
  var.unset Variables dm.mousex,dm.mousey
}
alias sel.control {
  var.set Temporary Loading Yes
  did -r ce 17,15,8,3
  did -h ce 22,23,24,26,27,28,29,30,31,48,57,59,36,64,65,66,67,68,60,61,62,63,40,41,51,52,53,54,55,56,35,32,33,34,49,50,58,71,43,70,72,13,3,14,15,16,17
  did -v ce 16,17
  did -e ce 8,9,10,11,12,18,19,20,21
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Tab) { dm.te | did -v ce 58,71,43,70,72 | did -h ce 16,17 }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Edit) {
    did -v ce 26,27,28,29,30,31,48,57,59,14,15
    did -a ce 15 Default
    did -a ce 15 Right
    did -a ce 15 Center
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == $null) { did -fc ce 15 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Right) { did -fc ce 15 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Center) { did -fc ce 15 3 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Limit) !== $null) { did -i ce 59 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Limit) 0 9999 10 0:1,2:5,5:20 }
    else { did -r ce 59 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Password) !== $null) { did -c ce 26 }
    else { did -u ce 26 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),ReadOnly) !== $null) { did -c ce 48 }
    else { did -u ce 48 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Return) !== $null) { did -c ce 27 }
    else { did -u ce 27 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),AutoHS) !== $null) { did -c ce 28 }
    else { did -u ce 28 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),AutoVS) !== $null) { did -c ce 29 }
    else { did -u ce 29 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),HScroll) !== $null) { did -c ce 30 }
    else { did -u ce 30 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),VScroll) !== $null) { did -c ce 31 }
    else { did -u ce 31 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Text) {
    did -v ce 36,14,15
    did -a ce 15 Default
    did -a ce 15 Right
    did -a ce 15 Center
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == $null) { did -fc ce 15 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Right) { did -fc ce 15 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Center) { did -fc ce 15 3 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),NoWordwrap) !== $null) { did -c ce 36 }
    else { did -u ce 36 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Radio) {
    did -v ce 51,13,3,14,15
    did -a ce 3 Default
    did -a ce 3 Push
    did -a ce 15 Default
    did -a ce 15 Left
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == $null) { did -fc ce 3 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == Push) { did -fc ce 3 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == $null) { did -fc ce 15 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Right) { did -fc ce 15 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Flat) !== $null) { did -c ce 51 }
    else { did -u ce 51 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Check) {
    did -v ce 40,41,13,3,14,15
    did -a ce 3 Default
    did -a ce 3 Push
    did -a ce 15 Default
    did -a ce 15 Left
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == $null) { did -fc ce 3 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == Push) { did -fc ce 3 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == $null) { did -fc ce 15 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Right) { did -fc ce 15 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Flat) !== $null) { did -c ce 40 }
    else { did -u ce 40 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),3State) !== $null) { did -c ce 41 }
    else { did -u ce 41 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Button) {
    did -v ce 22,23,24,13,3
    did -a ce 3 Default
    did -a ce 3 OK
    did -a ce 3 Cancel
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == $null) { did -fc ce 3 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == OK) { did -fc ce 3 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == Cancel) { did -fc ce 3 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Default) !== $null) { did -c ce 22 }
    else { did -u ce 22 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Flat) !== $null) { did -c ce 23 }
    else { did -u ce 23 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),MultiLine) !== $null) { did -c ce 24 }
    else { did -u ce 24 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == List) {
    did -v ce 52,53,54,55,56,35
    did -rb ce 8
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Sorted) !== $null) { did -c ce 52 }
    else { did -u ce 52 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Extended) !== $null) { did -c ce 53 }
    else { did -u ce 53 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Multi) !== $null) { did -c ce 35 }
    else { did -u ce 35 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Force) !== $null) { did -c ce 54 }
    else { did -u ce 54 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Horizontal) !== $null) { did -c ce 55 }
    else { did -u ce 55 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Vertical) !== $null) { did -c ce 56 }
    else { did -u ce 56 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Combo) {
    did -v ce 32,33,34,49,50,13,3
    did -rb ce 8
    did -a ce 3 Default
    did -a ce 3 Drop
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == $null) { did -fc ce 3 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == Drop) { did -fc ce 3 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Sorted) !== $null) { did -c ce 32 }
    else { did -u ce 32 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Editable) !== $null) { did -c ce 33 }
    else { did -u ce 33 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Force) !== $null) { did -c ce 34 }
    else { did -u ce 34 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Horizontal) !== $null) { did -c ce 49 }
    else { did -u ce 49 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Vertical) !== $null) { did -c ce 50 }
    else { did -u ce 50 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Scroll) {
    did -v ce 64,65,66,67,68,13,3
    did -rb ce 8
    did -a ce 3 Default
    did -a ce 3 Horizontal
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == $null) { did -fc ce 3 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Type) == Horizontal) { did -fc ce 3 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Minimum) !== $null) { did -i ce 66 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Minimum) 0 9999 10 0:1,2:5,5:20 }
    else { did -r ce 66 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Maximum) !== $null) { did -i ce 68 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Maximum) 0 9999 10 0:1,2:5,5:20 }
    else { did -r ce 68 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) == Icon) {
    did -v ce 60,61,62,63,14,15
    did -rb ce 8
    did -a ce 15 Default
    did -a ce 15 Top
    did -a ce 15 Left
    did -a ce 15 Right
    did -a ce 15 Bottom
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == $null) { did -fc ce 15 1 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Top) { did -fc ce 15 2 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Left) { did -fc ce 15 3 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Right) { did -fc ce 15 4 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Align) == Bottom) { did -fc ce 15 5 | did -f ce 4 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),NoBorder) !== $null) { did -c ce 60 }
    else { did -u ce 60 }
    if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Icon) !== $null) { did -ra ce 62 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Icon) }
    else { did -r ce 62 }
  }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Control) !== Tab) {
    did -ra ce 17 None
    set %dm.fi 1
    while (%dm.fi <= $ini($var.read(Variables,dm.fn2),0)) {
      if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == Tab) { did -a ce 17 Tab %dm.fi }
      if ($readini($var.read(Variables,dm.fn2), %dm.fi ,Control) == +Tab) { did -a ce 17 Tab %dm.fi }
      inc %dm.fi
    }
    unset %dm.fi
  }
  else { did -r ce 17 }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Text) !== $null) { did -ra ce 8 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Text) }
  did -i ce 9 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),X) 0 9999 10 0:1,2:5,5:20
  did -i ce 10 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),y) 0 9999 10 0:1,2:5,5:20
  did -i ce 11 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),W) 0 9999 10 0:1,2:5,5:20
  did -i ce 12 1 $readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),H) 0 9999 10 0:1,2:5,5:20
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Disable) !== $null) { did -c ce 18 }
  else { did -u ce 18 }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Hide) !== $null) { did -c ce 19 }
  else { did -u ce 19 }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Result) !== $null) { did -c ce 20 }
  else { did -u ce 20 }
  if ($readini($var.read(Variables,dm.fn2),$gettok($did(ce,4).seltext,2,32),Group) !== $null) { did -c ce 21 }
  else { did -u ce 21 }
  var.unset Temporary Loading
}
alias dm.ve {
  if ($var.read(Variables,dm.file) !== $null) {
    if ($dialog(VisualEditor)) { dialog -x VisualEditor Visual Editor }
    if ($var.read(Options,dmo.veot) == on) { dialog -mod VisualEditor VisualEditor $readini($var.read(Variables,dm.file),Dialog,X) $readini($var.read(Variables,dm.file),Dialog,Y) $readini($var.read(Variables,dm.file),Dialog,W) $readini($var.read(Variables,dm.file),Dialog,H) }
    else { dialog -md VisualEditor VisualEditor $readini($var.read(Variables,dm.file),Dialog,X) $readini($var.read(Variables,dm.file),Dialog,Y) $readini($var.read(Variables,dm.file),Dialog,W) $readini($var.read(Variables,dm.file),Dialog,H) }
  }
  else { .echo -q $dm.error(Please open or create new project before use Visual Editor!,dm.open) }
}
alias dm.ce {
  did -r ce 4
  set %dm.fi 1
  while (%dm.fi < $ini($var.read(Variables,dm.fn2),0)) {
    if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) !== $null) && ($left($readini($var.read(Variables,dm.fn2),%dm.fi,Control),1) !== +) { did -a ce 4 $readini($var.read(Variables,dm.fn2),%dm.fi,Control) %dm.fi }
    inc %dm.fi
  }
  unset %dm.fi
  dm.id
}
alias dm.build {
  did -i DM 3 2 Creating Controls...
  set %dm.fi 1
  if ($1 == $null) || ($1 == DialogMaker) {
    while (%dm.fi < $ini($var.read(Variables,dm.fn2),0)) {
      if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) !== $null) && ($left($readini($var.read(Variables,dm.fn2),%dm.fi,Control),1) !== +) {
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Button) {
          mdx DynamicControl create VisualEditor %dm.fi button $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Text) {
          mdx DynamicControl create VisualEditor %dm.fi text $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Edit) {
          mdx DynamicControl create VisualEditor %dm.fi edit $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Link) {
          mdx DynamicControl create VisualEditor %dm.fi text $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetColor VisualEditor %dm.fi text $rgb(0,0,255)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Check) {
          mdx DynamicControl create VisualEditor %dm.fi check $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Radio) {
          mdx DynamicControl create VisualEditor %dm.fi radio $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == List) {
          mdx DynamicControl create VisualEditor %dm.fi list $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Combo) {
          mdx DynamicControl create VisualEditor %dm.fi combo $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Box) {
          mdx DynamicControl create VisualEditor %dm.fi box $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.fn2),%dm.fi,Text)
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Icon) {
          mdx DynamicControl create VisualEditor %dm.fi button $readini($var.read(Variables,dm.fn2),%dm.fi,X) $readini($var.read(Variables,dm.fn2),%dm.fi,Y) $readini($var.read(Variables,dm.fn2),%dm.fi,W) $readini($var.read(Variables,dm.fn2),%dm.fi,H)
          mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
          mdx SetBorderStyle VisualEditor %dm.fi clientedge
          did -a VisualEditor %dm.fi ( $+ %dm.fi $+ )
        }
        if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == Tab) { did -b DM 13 }
      }
      if ($dialog(DM.Loading)) { did -a DM.Loading 2 %dm.fi 0 $ini($var.read(Variables,dm.fn2),0) }
      inc %dm.fi
    }
  }
  if ($1 == DialogStudio) {
    set %dm.convert_errors 0
    dialog -md DM.Convert DM.Convert
    while (%dm.fi <= $ini($var.read(Variables,dm.file),0)) {
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 0) {
        mdx DynamicControl create VisualEditor %dm.fi button $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Button
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 1) {
        mdx DynamicControl create VisualEditor %dm.fi edit $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Edit
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 2) {
        mdx DynamicControl create VisualEditor %dm.fi combo $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Combo
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 3) {
        mdx DynamicControl create VisualEditor %dm.fi text $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Text
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 4) {
        mdx DynamicControl create VisualEditor %dm.fi box $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Box
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 5) {
        mdx DynamicControl create VisualEditor %dm.fi list $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        writeini $var.read(Variables,dm.fn2) %dm.fi Control List
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 6) {
        mdx DynamicControl create VisualEditor %dm.fi check $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Check
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 7) {
        mdx DynamicControl create VisualEditor %dm.fi radio $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Radio
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 8) {
        mdx DynamicControl create VisualEditor %dm.fi text $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetColor VisualEditor %dm.fi text $rgb(0,0,255)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        did -a VisualEditor %dm.fi $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text)
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Link
        if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Text $readini($var.read(Variables,dm.file),Control $+ %dm.fi,Text) }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 9) {
        mdx DynamicControl create VisualEditor %dm.fi button $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44)
        mdx SetFont VisualEditor %dm.fi 13 200 Tahoma
        mdx SetBorderStyle VisualEditor %dm.fi clientedge
        did -a VisualEditor %dm.fi ( $+ %dm.fi $+ )
        writeini $var.read(Variables,dm.fn2) %dm.fi Control Icon
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi X $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),1,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi X 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi Y $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),2,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi Y 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi W $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),3,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi W 0 | inc %dm.convert_errors }
        if ($gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) !== $null) { writeini $var.read(Variables,dm.fn2) %dm.fi H $gettok($readini($var.read(Variables,dm.file),Control $+ %dm.fi,Position),4,44) }
        else { writeini $var.read(Variables,dm.fn2) %dm.fi H 0 | inc %dm.convert_errors }
      }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 10) { did -b DM 13 }
      if ($readini($var.read(Variables,dm.file),Control $+ %dm.fi,CType) == 11) { }
      did -a DM.Convert 1 %dm.fi 0 $ini($var.read(Variables,dm.file),0)
      dialog -t DM.Convert Converting... (Errors: %dm.convert_errors $+ )
      inc %dm.fi
    }
    var.set Options dmo.file.last $nofile($var.read(Variables,dm.fn2))
    dialog -x DM.Convert DM.Convert
    did -i DM 3 3 $nopath($longfn($var.read(Variables,dm.file))) ( $+ $bytes($file($var.read(Variables,dm.file)).size,k).suf $+ )
  }
  var.unset Variables File.Type
  dm.id
  did -i DM 3 2 Ready
}
alias dm.te {
  did -r ce 71
  set %dm.fi 1
  while (%dm.fi < $ini($var.read(Variables,dm.fn2),0)) {
    if ($readini($var.read(Variables,dm.fn2),%dm.fi,Control) == +Tab) { did -a ce 71 $readini($var.read(Variables,dm.fn2), %dm.fi ,Control) %dm.fi }
    inc %dm.fi
  }
  dm.id
}
alias dm.skin {
  mdx SetControlMDX $dname 2 ToolBar arrows flat nodivider > $shortfn($scriptdir) $+ Data\Bars.mdx
  did -i DM 2 1 bmpsize 32 32
  did -i DM 2 1 pad 9 5
  did -i DM 2 1 bwidth 32 32
  did -i DM 3 2 Loading Skin...
  if ($var.read(Options,dmo.skin) == $null) { var.set Options dmo.skin Default }
  if ($var.read(Options,dmo.skin) !== $null) {
    set %dm.file1 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Options,dmo.skin) $+ .skn
    set %dm.file2 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Options,dmo.skin) $+ \
    if ($exists(%dm.file2) == $false) {
      mkdir %dm.file2
      .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -Q2 %dm.file1 %dm.file2)
    }
  }
  else {
    set %dm.file1 $shortfn($scriptdir) $+ Data\Skins\Default.skn
    set %dm.file2 $shortfn($scriptdir) $+ Data\Skins\Default\
    if ($exists(%dm.file2) == $false) {
      mkdir %dm.file2
      .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -Q2 %dm.file1 %dm.file2)
    }
  }
  var.set Variables dm.sb %dm.file2 $+ \Toolbar.bmp
  if ($exists($var.read(Variables,dm.sb)) == $true) { did -i DM 2 1 setbkg tile $var.read(Variables,dm.sb) }
  else { did -i DM 2 1 setbkg none }
  var.unset Variables dm.sb
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(New)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(Open)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(Save)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(Control)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(Code)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(DialogCode)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(Tools)
  did -i DM 2 1 setimage +nhd icon normal, $dm.icon(Help)
  did -ra DM 2 +a 1 $tab New
  did -a DM 2 +va 2 $tab Open
  did -a DM 2 +a 3 $tab Save
  did -a DM 2 +a -
  did -a DM 2 +a 4 $tab Control Editor
  did -a DM 2 +a 5 $tab Code Editor
  did -a DM 2 +va 6 $tab Dialog Code
  did -a DM 2 +a -
  did -a DM 2 +a 7 $tab Tools
  did -a DM 2 +a 8 $tab Help
  did -i DM 3 2 Ready
  dm.language
}
alias dm.preview.skin {
  did -i DO 10 1 bmpsize 32 32
  did -i DO 10 1 pad 9 5
  did -i DO 10 1 bwidth 32 32
  set %dm.file1 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Temporary,dm.preview.skin) $+ .skn
  set %dm.file2 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Temporary,dm.preview.skin) $+ \
  if ($exists(%dm.file2) == $false) {
    mkdir %dm.file2
    .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -Q2 %dm.file1 %dm.file2)
  }
  var.set Variables dm.sb %dm.file2 $+ \Toolbar.bmp
  if ($exists($var.read(Variables,dm.sb)) == $true) { did -i DO 10 1 setbkg tile $var.read(Variables,dm.sb) }
  else { did -i DO 10 1 setbkg none }
  var.unset Variables dm.sb
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(New,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(Open,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(Save,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(Control,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(Code,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(DialogCode,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(Tools,Preview)
  did -i DO 10 1 setimage +nhd icon normal, $dm.icon(Help,Preview)
  did -ra DO 10 +a 1 $tab New
  did -a DO 10 +a 2 $tab Open
  did -a DO 10 +a 3 $tab Save
  did -a DO 10 +a -
  did -a DO 10 +a 4 $tab Control Editor
  did -a DO 10 +a 5 $tab Code Editor
  did -a DO 10 +a 6 $tab Dialog Code
  did -a DO 10 +a -
  did -a DO 10 +a 7 $tab Tools
  did -a DO 10 +a 8 $tab Help
}
alias dm.pop { return $+($shortfn($+($shortfn($scriptdir),Data\Popups.dll))) }
alias dm.mpdll {
  if ($isid) { return $dll($shortfn($scriptdir) $+ Data\Mpopup.dll,$1,$2-) }
  else { dll $shortfn($scriptdir) $+ Data\Mpopup.dll $1 $2- }
}
alias dm.edit { return $gettok($did($1 $+ , $2),1,32) }
alias -l mdx { return $dll($shortfn($scriptdir) $+ Data\Mdx.dll,$1,$2-) }
alias dm.icon {
  if ($var.read(Options,dmo.skin) !== $null) {
    set %dm.file1 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Options,dmo.skin) $+ .skn
    set %dm.file2 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Options,dmo.skin) $+ \
    if ($exists(%dm.file2) == $false) {
      mkdir %dm.file2
      .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -Q2 %dm.file1 %dm.file2)
    }
  }
  else {
    set %dm.file1 $shortfn($scriptdir) $+ Data\Skins\Default.skn
    set %dm.file2 $shortfn($scriptdir) $+ Data\Skins\Default\
    if ($exists(%dm.file2) == $false) {
      mkdir %dm.file2
      .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -Q2 %dm.file1 %dm.file2)
    }
  }
  if ($var.read(Temporary,dm.preview.skin) !== $null) {
    set %dm.file1 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Temporary,dm.preview.skin) $+ .skn
    set %dm.file2 $shortfn($scriptdir) $+ Data\Skins\ $+ $var.read(Temporary,dm.preview.skin) $+ \
    if ($exists(%dm.file2) == $false) {
      mkdir %dm.file2
      .echo -q $dll($shortfn($scriptdir) $+ Data\mUnzip.dll, Unzip, -Q2 %dm.file1 %dm.file2)
    }
  }
  if ($1 == Logo) { if ($isfile(%dm.file2 $+ \Logo.jpg) == $true) { return %dm.file2 $+ \Logo.jpg } }
  if ($1 == Modules_Pic) {
    if ($isfile(%dm.file2 $+ \Modules.jpg) == $true) { return %dm.file2 $+ \Modules.jpg }
    else { return $shortfn($scriptdir) $+ Data\Icons\Modules.jpg }
  }
  if ($1 == Modules_Loaded) {
    if ($isfile(%dm.file2 $+ \Loaded.ico) == $true) { return %dm.file2 $+ \Loaded.ico }
    else { return $shortfn($scriptdir) $+ Data\Icons\Loaded.ico }
  }
  if ($1 == Modules_Unloaded) {
    if ($isfile(%dm.file2 $+ \Unloaded.ico) == $true) { return %dm.file2 $+ \Unloaded.ico }
    else { return $shortfn($scriptdir) $+ Data\Icons\Unloaded.ico }
  }
  if ($2 == $null) { if ($var.read(Options,dmo.skin) !== $null) { return %dm.file2 $+ \ $+ $1 $+ .ico } }
  if ($2 == Preview) { if ($var.read(Temporary,dm.preview.skin) !== $null) { return %dm.file2 $+ \ $+ $1 $+ .ico } }
}
alias dm.language {
  if ($var.read(Options,dmo.language) !== $null) {
    set %l $shortfn($scriptdir) $+ Data\Languages\ $+ $var.read(Options,dmo.language)
    if ($dialog(dm).active == $true) {
      did -r DM 2
      did -ra DM 2 +a 1 $tab $readini(%l,Main,New)
      did -a DM 2 +va 2 $tab $readini(%l,Main,Open)
      did -a DM 2 +a 3 $tab $readini(%l,Main,Save)
      did -a DM 2 +a -
      did -a DM 2 +a 4 $tab $readini(%l,Main,Control_Editor)
      did -a DM 2 +a 5 $tab $readini(%l,Main,Code_Editor)
      did -a DM 2 +va 6 $tab $readini(%l,Main,Dialog_Code)
      did -a DM 2 +a -
      did -a DM 2 +a 7 $tab $readini(%l,Main,Tools)
      did -a DM 2 +a 8 $tab $readini(%l,Main,Help)
      did -ra DM 7 $readini(%l,Main,Button)
      did -ra DM 8 $readini(%l,Main,Edit)
      did -ra DM 9 $readini(%l,Main,Text)
      did -ra DM 10 $readini(%l,Main,Link)
      did -ra DM 11 $readini(%l,Main,Box)
      did -ra DM 12 $readini(%l,Main,Scroll)
      did -ra DM 13 $readini(%l,Main,Tab)
      did -ra DM 14,51 $readini(%l,Main,Icon)
      did -ra DM 15 $readini(%l,Main,Check)
      did -ra DM 16 $readini(%l,Main,Radio)
      did -ra DM 17 $readini(%l,Main,List)
      did -ra DM 18 $readini(%l,Main,Combo)
      did -ra DM 66 $readini(%l,Main,Name:)
      did -ra DM 111 $readini(%l,Main,Titlebar_Text:)
      did -ra DM 55 $readini(%l,Main,Position_and_Size:)
      did -ra DM 48 $readini(%l,Main,Use_DBU)
    }
    if ($dialog(do).active == $true) {
      dialog -t DO Dialog Maker: $readini(%l,Options,Options)
      did -ra DO 3 +da 1 $tab $readini(%l,Options,Add)
      did -a DO 3 +da 2 $tab $readini(%l,Options,Load)
      did -a DO 3 +a 3 $tab -
      did -a DO 3 +da 4 $tab $readini(%l,Options,Rename)
      did -a DO 3 +da 5 $tab $readini(%l,Options,Delete)
      did -a DO 3 +a 6 $tab -
      did -a DO 3 +da 7 $tab $readini(%l,Options,Refresh)
      did -ra DO 1 +b $readini(%l,Options,General)
      did -i DO 1 1 cb 2
      did -a DO 1 $readini(%l,Options,Main)
      did -a DO 1 $readini(%l,Options,Patterns)
      did -i DO 1 1 branch expandall $did(1).lines
      did -i DO 1 1 cb root
      did -a DO 1 +b $readini(%l,Options,Editors)
      did -i DO 1 1 cb 3
      did -a DO 1 $readini(%l,Options,Code_Editor)
      did -a DO 1 $readini(%l,Options,Visual_Editor)
      did -a DO 1 $readini(%l,Options,Control_Editor)
      did -i DO 1 1 branch expandall $did(1).lines
      did -i DO 1 1 cb root
      did -a DO 1 +b $readini(%l,Options,Skins)
      did -i DO 1 1 cb 4
      did -a DO 1 $readini(%l,Options,Load)
      did -i DO 1 1 branch expandall $did(1).lines
      did -i DO 1 1 cb root
      did -a DO 1 +b $readini(%l,Options,Languages)
      did -i DO 1 1 cb 5
      did -a DO 1 $readini(%l,Options,Load)
      did -i DO 1 1 branch expandall $did(1).lines
      did -ra DO 9 $readini(%l,Options,OK)
      did -ra DO 12 $readini(%l,Options,Open)
      did -ra DO 13 $readini(%l,Options,On_Top)
      did -ra DO 14 $readini(%l,Options,Auto_Start)
      did -ra DO 15 $readini(%l,Options,Open_Last_Project)
      did -ra DO 29 $readini(%l,Options,Close_Loading)t
      did -ra DO 30 $readini(%l,Options,Show_Tips)
      did -ra DO 28 $readini(%l,Options,Remember_Positions)
      did -ra DO 19 $readini(%l,Options,Red:)
      did -ra DO 21 $readini(%l,Options,Green:)
      did -ra DO 24 $readini(%l,Options,Blue:)
    }
    if ($dialog(mod).active == $true) {
      dialog -t mod Dialog Maker: $readini(%l,Modules,Modules)
      did -i mod 3 1 headertext +l $readini(%l,Modules,Module) $chr(9) $+ +l $readini(%l,Modules,Author) $chr(9) $+ +r Location
      did -ra mod 5 $readini(%l,Modules,OK)
      did -ra mod 6 $readini(%l,Modules,Load)
      did -ra mod 8 $readini(%l,Modules,Adjust)
      did -ra mod 9 $readini(%l,Modules,Refresh)
      did -ra mod 11 $readini(%l,Modules,Delete)
    }
    if ($dialog(dm.tips).active == $true) {
      dialog -t dm.tips Dialog Maker $readini(%l,Tips,Tips)
      did -ra dm.tips 3 $readini(%l,Tips,Always_show_tips_at_startup)
      did -ra dm.tips 4 $readini(%l,Tips,Another_Tip)
      did -ra dm.tips 5 $readini(%l,Tips,Close)
    }
    if ($dialog(ce).active == $true) {
      dialog -t ce Dialog Maker: $readini(%l,Control_Editor,Control_Editor)
      did -ra ce 5 $readini(%l,Control_Editor,Controls:)
      did -ra ce 7 $readini(%l,Control_Editor,Text:)
      did -ra ce 6 $readini(%l,Control_Editor,Size:)
      did -ra ce 13 $readini(%l,Control_Editor,Type:)
      did -ra ce 14 $readini(%l,Control_Editor,Align:)
      did -ra ce 16 $readini(%l,Control_Editor,Tab:)
      did -ra ce 18 $readini(%l,Control_Editor,Disable)
      did -ra ce 19 $readini(%l,Control_Editor,Hide)
      did -ra ce 20 $readini(%l,Control_Editor,Result)
      did -ra ce 21 $readini(%l,Control_Editor,Group)
      did -ra ce 69 $readini(%l,Control_Editor,Save)
      did -ra ce 22 $readini(%l,Control_Editor,Default)
      did -ra ce 23,40,51 $readini(%l,Control_Editor,Flat)
      did -ra ce 24 $readini(%l,Control_Editor,Multi-Line)
      did -ra ce 63 $readini(%l,Control_Editor,Select...)
      did -ra ce 43 $readini(%l,Control_Editor,Add)
      did -ra ce 72 $readini(%l,Control_Editor,Refresh)
      did -ra ce 26 $readini(%l,Control_Editor,Password_Entry)
      did -ra ce 28 $readini(%l,Control_Editor,Auto_H_Scroll)
      did -ra ce 29 $readini(%l,Control_Editor,Auto_V_Scroll)
      did -ra ce 30,49,55 $readini(%l,Control_Editor,Horizontal_Scroll)
      did -ra ce 31,50,56 $readini(%l,Control_Editor,Vertical_Scroll)
      did -ra ce 32,52 $readini(%l,Control_Editor,Sorted)
      did -ra ce 33 $readini(%l,Control_Editor,Editable)
      did -ra ce 34,54 $readini(%l,Control_Editor,Force_Size)
      did -ra ce 53 $readini(%l,Control_Editor,Extended_Select)
      did -ra ce 36 $readini(%l,Control_Editor,No_Wordwrap)
      did -ra ce 48 $readini(%l,Control_Editor,Read-Only)
      did -ra ce 41 $readini(%l,Control_Editor,3_State)
      did -ra ce 35 $readini(%l,Control_Editor,Multi_Select)
      did -ra ce 60 $readini(%l,Control_Editor,No_Border)
      did -ra ce 27 $readini(%l,Control_Editor,Allow_Return)
      did -ra ce 67 $readini(%l,Control_Editor,Maximum:)
      did -ra ce 57 $readini(%l,Control_Editor,Limit:)
      did -ra ce 61 $readini(%l,Control_Editor,Icon_File:)
      did -ra ce 64 $readini(%l,Control_Editor,Scroll_Range:)
      did -ra ce 65 $readini(%l,Control_Editor,Minimum:)
    }
    if ($dialog(le).active == $true) {
      dialog -t le Dialog Maker: $readini(%l,Language_Editor,Language_Editor)
      did -ra le 4 $readini(%l,Language_Editor,Windows)
      did -i le 4 1 cb 2
      did -a le 4 $readini(%l,Language_Editor,Main)
      did -a le 4 $readini(%l,Language_Editor,Error)
      did -a le 4 $readini(%l,Language_Editor,Update)
      did -a le 4 $readini(%l,Language_Editor,Options)
      did -a le 4 $readini(%l,Language_Editor,Modules)
      did -a le 4 $readini(%l,Language_Editor,Control_Editor)
      did -a le 4 $readini(%l,Language_Editor,Language_Editor)
      did -a le 4 $readini(%l,Language_Editor,Code_Editor)
      did -i le 4 1 cb 9
      did -a le 4 $readini(%l,Language_Editor,Go_To_Line)
      did -a le 4 $readini(%l,Language_Editor,Search)
      did -i le 4 1 cb root
      did -a le 4 $readini(%l,Language_Editor,Menus)
      did -i le 4 1 cb 3
      did -a le 4 $readini(%l,Language_Editor,Tools)
      did -a le 4 $readini(%l,Language_Editor,Dialog_Code)
      did -i le 4 1 cb root
      did -a le 4 $readini(%l,Language_Editor,About)
      did -i le 1 1 headertext +c $readini(%l,Language_Editor,Default) $chr(9) $+ +c $readini(%l,Language_Editor,Translated)
      did -ra le 3 $readini(%l,Language_Editor,New)
      did -ra le 5 $readini(%l,Language_Editor,Change)
    }
    if ($dialog(dc).active == $true) {
      dialog -t dc Dialog Maker: $readini(%l,Code_Editor,Code_Editor)
      did -r dc 17
      did -a dc 17 +a 1 $tab $readini(%l,Code_Editor,Save)
      did -a dc 17 +a -
      did -a dc 17 +a 2 $tab $readini(%l,Code_Editor,Copy)
      did -a dc 17 +a 3 $tab $readini(%l,Code_Editor,Paste)
      did -a dc 17 +a -
      did -a dc 17 +a 4 $tab $readini(%l,Code_Editor,Print)
      did -a dc 17 +a 5 $tab $readini(%l,Code_Editor,Clear)
      did -a dc 17 +a -
      did -a dc 17 +a 6 $tab $readini(%l,Code_Editor,Search)
      did -a dc 17 +a 7 $tab $readini(%l,Code_Editor,Go_to_Line)
      if ($var.read(Options,dmo.explorer) == on) { did -a dc 17 +xca 8 $tab $readini(%l,Code_Editor,Explorer) }
      else { did -a dc 17 +ca 8 $tab $readini(%l,Code_Editor,Explorer) }
      did -a dc 17 +a -
      did -a dc 17 +a 9 $tab $readini(%l,Code_Editor,Patterns)
      did -a dc 17 +a 10 $tab $readini(%l,Code_Editor,Brackets)
      did -ra dc 4 $readini(%l,Code_Editor,Lines)
      did -ra dc 6  $readini(%l,Code_Editor,Size)
      did -ra dc 10 $readini(%l,Code_Editor,Clipboard)
    }
    if ($dialog(dc.gl).active == $true) {
      dialog -t dc.gl $readini(%l,Go_To_Line,Go_To_Line...)
      did -ra dc.gl 3 $readini(%l,Go_To_Line,Go)
      did -ra dc.gl 4 $readini(%l,Go_To_Line,Cancel)
    }
    if ($dialog(dc.st).active == $true) {
      dialog -t dc.st $readini(%l,Search,Search...)
      did -ra dc.st 3 $readini(%l,Search,Find)
      did -ra dc.st 4 $readini(%l,Search,Cancel)
    }
    if ($dialog(du).active == $true) {
      dialog -t du Dialog Maker: $readini(%l,Update,Update)
      did -i du 1 1 headertext +c $readini(%l,Update,Update) $chr(9) $+ +c $readini(%l,Update,URL) $chr(9) $+ +c $readini(%l,Update,Size)
      did -ra du 2 $readini(%l,Update,Progress:)
      did -ra du 11 $readini(%l,Update,Time:)
      did -ra du 9 $readini(%l,Update,Update_Size:)
      did -ra du 10 $readini(%l,Update,Downloaded:)
      did -ra du 8 $readini(%l,Update,Download)
      did -ra du 12 $readini(%l,Update,Stop)
      did -ra du 6 $readini(%l,Update,Refresh)
      did -ra du 7 $readini(%l,Update,Current)
      did -ra du 5 $readini(%l,Update,OK)
    }
    if ($dialog(de).active == $true) {
      dialog -t de Dialog Maker: $readini(%l,Error,ERROR!)
      did -ra de 1 $readini(%l,Error,OK)
      did -ra de 2 $readini(%l,Error,Repair)
    }
    unset %l
  }
}
alias dm.id {
  did -i DM 3 2 Calculating IDs...
  set %dm.i 1
  while (%dm.i < $ini($var.read(Variables,dm.fn2),0)) {
    if ($readini($var.read(Variables,dm.fn2),%dm.i,Control) !== $null) { set %id.string $addtok(%id.string,%dm.i,44) }
    inc %dm.i
  }
  set %id.i 1
  while (%id.i <= $numtok(%id.string,44)) {
    if ($gettok(%id.string,%id.i,44) < $calc($gettok(%id.string,$calc(%id.i +1),44) -1)) && (%id.change !== Yes) {
      var.set Variables dm.id $calc($gettok(%id.string,%id.i,44) +1)
      set %id.change Yes
    }
    inc %id.i
  }
  if (%id.change !== Yes) { var.set Variables dm.id $calc($numtok(%id.string,44) +1) }
  unset %id.*
  unset %dm.i
  did -i DM 3 2 Ready
}
alias dm.set.eo {
  if ($var.read(Options,$1-) == on) { var.set Options $1- off }
  else { var.set Options $1- on }
  dm.explorer.refresh
}
alias dm.close {
  if ($dialog(VisualEditor)) { dialog -x VisualEditor VisualEditor }
  if ($dialog(DM)) { dialog -x DM DM }
  if ($dialog(DO)) { dialog -x DO DO }
  if ($dialog(MOD)) { dialog -x MOD MOD }
  if ($dialog(DU)) { dialog -x du du }
  if ($dialog(CE)) { dialog -x ce ce }
  if ($dialog(DC)) { dialog -x dc dc }
  if ($dialog(DC.GL)) { dialog -x dc.gl dc.gl }
  if ($dialog(DC.ST)) { dialog -x dc.st dc.st }
  if ($dialog(LE)) { dialog -x le le }
  if ($dialog(LE.CT)) { dialog -x le.ct le.ct }
  if ($dialog(ODFF)) { dialog -x odff odff }
  if ($dialog(DE)) { dialog -x de de }
  if ($dialog(DM.Loading)) { dialog -x DM.Loading DM.Loading }
  if ($dialog($var.read(Variables,dm.dn)) !== $null) { dialog -x $var.read(Variables,dm.dn) $var.read(Variables,dm.dn) }
  if ($script($nopath($var.read(Variables,dm.fn))) !== $null) { .unload -rs $shortfn($var.read(Variables,dm.fn)) }
  var.unset Temporary
  var.unset Variables dm.file,dm.oid
  unset %dm.*
  if ($1 == Restart) { .timerDMres 1 0 /DM }
}
alias dm.code.view {
  dm.cnd
  dialog -v DM dm
  run -o Notepad.exe $remove($var.read(Variables,dm.file),$right($shortfn($var.read(Variables,dm.file)),2)) $+ mrc
}
alias dm.code.copy {
  dm.cnd
  did -i DM 3 2 Copying Code...
  clipboard
  var %a = 1, %lines = $lines($remove($var.read(Variables,dm.file),$right($shortfn($var.read(Variables,dm.file)),2)) $+ mrc)
  while (%a <= %lines) {
    clipboard -an $read($remove($var.read(Variables,dm.file),$right($shortfn($var.read(Variables,dm.file)),2)) $+ mrc,n,%a)
    inc %a
  }
  unset %a
  unset %lines
  did -i DM 3 2 Ready
}
alias dm.code.save {
  if ($var.read(Options,export.dir) == $null) { var.set Options export.dir $mircdir }
  set %test.dir $sfile($var.read(Options,export.dir) $nopath($longfn($remove($var.read(Variables,dm.file),$right($shortfn($var.read(Variables,dm.file)),2)) $+ mrc)),Save Dialog Code:,Save)
  if (%test.dir !== $null) {
    dm.cnd
    dialog -v DM dm
    var.set Options export.dir $nofile(%test.dir)
    .copy -o $+($remove($var.read(Variables,dm.file),$right($shortfn($var.read(Variables,dm.file)),2)),mrc) $+($shortfn($nofile(%test.dir)),$replace($nopath(%test.dir),$chr(32),_))
  }
  unset %test.dir
}
alias dm.file.dc {
  if ($var.read(Variables,dm.file) !== $null) { dialog -md dc dc | .timerDC 1 0 dialog -v dc dc }
}
alias dm.ds {
  if ($did(1).seltext !== $null) { download $dm.cell(DU,1,$did(1).sel,2) }
  var.set Variables dm.download Update
}
alias dm.cell { return $gettok($gettok($gettok($did($1,$2,$3),$4,9),$iif($4 = 1,6,5) $+ -,32),1,4) }
alias dm.tree {
  var %dialog = $1
  var %id = $2
  if (!$dialog(%dialog)) return
  if ($3) {
    var %Loc = $3-
    if ($prop = lines) {
      did -i %dialog %id 1 cb root %loc
      var %return = $calc($did(%dialog,%id,0).lines -1)
      goto end
    }
    if ($numtok(%Loc,32) = 1) did -i %dialog %id 1 cb root
    else { did -i %dialog %id 1 cb root $gettok(%loc,1- $+ $calc($numtok(%loc,32) -1),32) }
    var %line = $gettok($did(%dialog,%id,$gettok(%Loc,-1,32)),7-,32)
    if ($prop = tooltip) { var %return = $gettok(%line,2-,9) | goto end }
    var %return = $gettok(%line,1,9)
    goto end
  }
  var %entry = $did(%dialog,%id,1)
  if ($gettok(%entry,1,32) = slclick) var %loc = $gettok(%entry,4-,32)
  else var %loc = $gettok(%entry,3-,32)
  var %depth = $calc($numtok(%loc,32) -1)
  var %branch = $gettok(%loc,-1,32)
  var %line = $gettok($did(%dialog,%id,%branch),7-,32)
  if (!$prop) { var %return = $gettok(%line,1,9) | goto end }
  if ($prop = root) { var %return = $gettok(%loc,1,32) | goto end }
  if ($prop = sel) { var %return = %loc | goto end }
  if ($prop = lines) { var %return = $calc($did(%dialog,%id,0).lines -1) | goto end }
  if ($prop = len) { var %return = $len(%line) | goto end }
  if ($prop = tooltip) { var %return = $gettok(%line,2-,9) | goto end }
  if ($prop = event) { var %return = $gettok(%entry,1,32) | goto end }
  :end
  if (%depth = 0) did -i %dialog %id 1 cb root
  else did -i %dialog %id 1 cb root $gettok(%loc,1- $+ %depth,32)
  return %return
}
alias dm.preview {
  dm.cnd
  if ($dialog($var.read(Variables,dm.dn)) == $null) { dialog -md $var.read(Variables,dm.dn) $var.read(Variables,dm.dn) }
  else { dialog -x $var.read(Variables,dm.dn) $var.read(Variables,dm.dn) | dialog -md $var.read(Variables,dm.dn) $var.read(Variables,dm.dn) }
}
alias dm.explorer.refresh {
  if ($var.read(Options,dmo.explorer.show_aliases) == on) { filter -cnif DC 1 $shortfn($scriptdir) $+ Data\Aliases.txt alias* }
  if ($var.read(Options,dmo.explorer.show_dialogs) == on) { filter -cnif DC 1 $shortfn($scriptdir) $+ Data\Dialogs.txt dialog* }
  if ($var.read(Options,dmo.explorer.show_menus) == on) { filter -cnif DC 1 $shortfn($scriptdir) $+ Data\Menus.txt menu* }
  if ($var.read(Options,dmo.explorer.show_signals) == on) { filter -cnif DC 1 $shortfn($scriptdir) $+ Data\Signals.txt *:signal:* }
  if ($var.read(Options,dmo.explorer.show_events) == on) { filter -cnif DC 1 $shortfn($scriptdir) $+ Data\Events.txt on * }
  if ($var.read(Options,dmo.explorer.show_raw_events) == on) { filter -cnif DC 1 $shortfn($scriptdir) $+ Data\Raws.txt *raw* }
  did -r DC 2
  set %i 1
  if ($var.read(Options,dmo.explorer.show_aliases) == on) {
    did -a DC 2 +b Aliases ( $+ $lines($shortfn($scriptdir) $+ Data\Aliases.txt) $+ )
    did -i DC 2 1 cb $did(dc,2).lines
    while (%i <= $lines($shortfn($scriptdir) $+ Data\Aliases.txt)) {
      did -a DC 2 $remove($read($shortfn($scriptdir) $+ Data\Aliases.txt,%i),alias)
      inc %i
    }
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { did -i DC 2 1 branch expandall $did(dc,2).lines }
    did -i DC 2 1 cb up
  }
  set %i 1
  if ($var.read(Options,dmo.explorer.show_dialogs) == on) {
    did -a DC 2 +b Dialogs ( $+ $lines($shortfn($scriptdir) $+ Data\Dialogs.txt) $+ )
    did -i DC 2 1 cb $did(dc,2).lines
    while (%i <= $lines($shortfn($scriptdir) $+ Data\Dialogs.txt)) {
      did -a DC 2 $read($shortfn($scriptdir) $+ Data\Dialogs.txt,%i)
      inc %i
    }
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { did -i DC 2 1 branch expandall $did(dc,2).lines }
    did -i DC 2 1 cb up
  }
  set %i 1
  if ($var.read(Options,dmo.explorer.show_menus) == on) {
    did -a DC 2 +b Menus ( $+ $lines($shortfn($scriptdir) $+ Data\Menus.txt) $+ )
    did -i DC 2 1 cb $did(dc,2).lines
    while (%i <= $lines($shortfn($scriptdir) $+ Data\Menus.txt)) {
      did -a DC 2 $remove($read($shortfn($scriptdir) $+ Data\Menus.txt,%i),menu)
      inc %i
    }
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { did -i DC 2 1 branch expandall $did(dc,2).lines }
    did -i DC 2 1 cb up
  }
  set %i 1
  if ($var.read(Options,dmo.explorer.show_signals) == on) {
    did -a DC 2 +b Signals ( $+ $lines($shortfn($scriptdir) $+ Data\Signals.txt) $+ )
    did -i DC 2 1 cb $did(dc,2).lines
    while (%i <= $lines($shortfn($scriptdir) $+ Data\Signals.txt)) {
      did -a DC 2 $remove($read($shortfn($scriptdir) $+ Data\Signals.txt,%i),signal,on,:)
      inc %i
    }
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { did -i DC 2 1 branch expandall $did(dc,2).lines }
    did -i DC 2 1 cb up
  }
  set %i 1
  if ($var.read(Options,dmo.explorer.show_events) == on) {
    did -a DC 2 +b Events ( $+ $lines($shortfn($scriptdir) $+ Data\Events.txt) $+ )
    did -i DC 2 1 cb $did(dc,2).lines
    while (%i <= $lines($shortfn($scriptdir) $+ Data\Events.txt)) {
      did -a DC 2 $remove($read($shortfn($scriptdir) $+ Data\Events.txt,%i),on)
      inc %i
    }
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { did -i DC 2 1 branch expandall $did(dc,2).lines }
    did -i DC 2 1 cb up
  }
  set %i 1
  if ($var.read(Options,dmo.explorer.show_raw_events) == on) {
    did -a DC 2 +b Raw Events ( $+ $lines($shortfn($scriptdir) $+ Data\Raws.txt) $+ )
    did -i DC 2 1 cb $did(dc,2).lines
    while (%i <= $lines($shortfn($scriptdir) $+ Data\Raws.txt)) {
      did -a DC 2 $remove($read($shortfn($scriptdir) $+ Data\Raws.txt,%i),on,/)
      inc %i
    }
    if ($var.read(Options,dmo.explorer.auto_expand) == on) { did -i DC 2 1 branch expandall $did(dc,2).lines }
    did -i DC 2 1 cb up
  }
}
alias dm.import.dialog {
  if ($readini($var.read(Variables,dm.file),Dialog,Name) == $null) { writeini $var.read(Variables,dm.fn2) Dialog Name Unknown | inc %dm.errors }
  var.set Variables dm.dn $readini($var.read(Variables,dm.file),Dialog,Name)
  if ($readini($var.read(Variables,dm.file),Dialog,Title) !== $null) { var.set Variables dm.dt $readini($var.read(Variables,dm.file),Dialog,Title) }
  if ($readini($var.read(Variables,dm.file),Dialog,Option) !== $null) { var.set Variables dm.DO $readini($var.read(Variables,dm.file),Dialog,Option) }
  else { var.unset Variables dm.DO }
  if ($readini($var.read(Variables,dm.file),Dialog,Icon) !== $null) { var.set Variables dm.di $readini($var.read(Variables,dm.file),Dialog,Icon) }
  else { var.unset Variables dm.di }
  if ($readini($var.read(Variables,dm.file),Dialog,X) == $null) { writeini $var.read(Variables,dm.fn2) Dialog X -1 | inc %dm.errors }
  var.set Variables dm.dx $readini($var.read(Variables,dm.file),Dialog,X)
  if ($readini($var.read(Variables,dm.file),Dialog,Y) == $null) { writeini $var.read(Variables,dm.fn2) Dialog Y -1 | inc %dm.errors }
  var.set Variables dm.dy $readini($var.read(Variables,dm.file),Dialog,Y)
  if ($readini($var.read(Variables,dm.file),Dialog,W) == $null) { writeini $var.read(Variables,dm.fn2) Dialog W 640 | inc %dm.errors }
  var.set Variables dm.dw $readini($var.read(Variables,dm.file),Dialog,W)
  if ($readini($var.read(Variables,dm.file),Dialog,H) == $null) { writeini $var.read(Variables,dm.fn2) Dialog H 480 | inc %dm.errors }
  var.set Variables dm.dh $readini($var.read(Variables,dm.file),Dialog,H)
}
alias dm.add.mod {
  if ($script($nopath($shortfn($1-))) == $null) { did -a mod 3 0 + 2 0 0 $remove($nopath($1-),.mod) $chr(9) $readini($shortfn($1-),Information,Author) $chr(9) $shortfn($1-) $chr(4) $readini($shortfn($1-),Information,Description) }
  else { did -a mod 3 0 + 1 0 0 $remove($nopath($1-),.mod) $chr(9) $readini($shortfn($1-),Information,Author) $chr(9) $shortfn($1-) $chr(4) $readini($shortfn($1-),Information,Description) }
}
alias dm.open.more {
  did -o dc 11 4 +xgca 1 $1-
  if ($readini($var.read(Variables,dm.file),$gettok($1-,2,32),Code) !== $null) { did -ra dc 1 $readini($var.read(Variables,dm.file),$gettok($1-,2,32),Code) }
  else { did -r dc 1 }
}
alias dm.BracketCheck {
  did -i DM 3 2 Saving Code...
  if ($did(1) !== $null) { savebuf -o dc 1 $var.read(Variables,dmc.file) }
  if ($did(1) == $null) { .remove $var.read(Variables,dmc.file) }
  did -i DM 3 2 Ready
  set %BC.fn $var.read(Variables,dmc.file)
  set %BC.a.ffn $remove($var.read(Variables,dmc.file),$shortfn($mircdir)) | set %BC.a.load FALSE | if ($2) { set %BC.ignore $2- }
  set %lines $lines(%BC.a.ffn)
  inc %lines
  set %prm $calc(100 / %lines)
  set %BC.a.fn $gettok(%BC.a.ffn,$numtok(%BC.a.ffn,92),92)
  unset %BC.ini
  if ($right(%BC.a.fn,3) == ini) { set %BC.ini TRUE }
  if ($dialog(DC.BC) == $null) { dialog -md DC.BC DC.BC }
  else { dialog -x DC.BC DC.BC | dialog -md DC.BC DC.BC }
  set %n1 1
  while (%n1 <= %lines) {
    set %txt $read(%BC.a.ffn,n,%n1)
    if (%BC.ini) { if ($left(%txt,1) != $chr(91)) { set %txt $gettok(%txt,2-,61) } }
    if ($left(%txt,1) == $chr(59)) { goto skpBC2 }
    set %w1 $gettok(%txt,1,32)
    set %w2 $gettok(%txt,2,32)
    if ($left(%w2,1) == ") { goto skpBC2 }
    if ($findtok(%BC.ignore,%n1,1,32)) { goto skpBC1 }
    set %open $calc($pos(%txt,$chr(40),0) + %open)
    set %close $calc($pos(%txt,$chr(41),0) + %close)
    :skpBC1
    if ($right(%txt,2) != $+($chr(36),$chr(38))) {
      if (%open != %close) {
        set %BC.err TRUE
        if (!$isid) { did -a DC.BC 1 Error $chr(9) %n1 }
      }
      set %open
      set %close
    }
    if (($+(if,$chr(40)) isin $remove(%txt,iif)) || ($+(elseif,$chr(40)) isin %txt) || ($+(while,$chr(40)) isin %txt)) {
      set %BC.err TRUE
      if (!$isid) { did -a DC.BC 1 Error $chr(9) %n1 }
    }
    if (%BC.ini) { if ($left(%w1,1) == $chr(91)) { goto skpBC3 } }
    if ((%w1 == alias) || (%w1 == menu) || (%w1 == on) || (ctcp*:*:*:* iswm %txt) || (%n1 == %lines)) {
      :skpBC3
      if (%openbrk != %closbrk) {
        set %errs $abs($calc(%openbrk - %closbrk))
        set %BC.err TRUE
        if (!$isid) { did -a DC.BC 1 Error Between Lines $chr(9) %lastline and $calc(%n1 - 1) }
        if (!$isid) { did -a DC.BC 1 $chr(123) $chr(125) Bracket Errors $chr(9) %errs }
        set %l1 $calc(%lastline + 1)
        set %lerr %lastline
        set %l2 $calc(%n1 - 1)
        while (%l1 <= %l2) {
          set %txt2 $read(%BC.a.ffn,n,%l1)
          if ($numtok(%txt2,32) == 1) && ($right(%txt2,1) != $chr(125)) && ($right(%txt2,1) !== $chr(61)) {
            did -a DC.BC 1 Possible ' $+ $chr(123) $+ ' Error $chr(9) %l1
          }
          if (($+(i,f,$chr(32),$chr(40)) isin %txt2) || ($+(elsei,f,$chr(32),$chr(40)) isin %txt2) || ($+(whi,le,$chr(32),$chr(40)) isin %txt2)) {
            if (($chr(41) !isin %txt2) || ($chr(123) !isin %txt2)) {
              if (!$isid) { did -a DC.BC 1 Possible Error $chr(9) %l1 }
            }
          }
          set %bt1 $remove(%txt2,$chr(123) $+ $chr(32),$chr(32))
          if (($chr(123) isin %bt1) && ($len(%bt1) != $pos(%bt1,$chr(123)))) {
            if (!$isid) { did -a DC.BC 1 Possible ' $+ $chr(123) $+ ' Error $chr(9) %l1 }
          }
          set %bt1 $remove(%txt2,$chr(32) $+ $chr(125),$chr(32))
          if (($chr(125) isin %bt1) && ($len(%bt1) != 1)) {
            if (!$isid) { did -a DC.BC 1 Possible ' $+ $chr(125) $+ ' Error $chr(9) %l1 }
          }
          inc %l1
        }
      }
      set %lastline %n1
      unset %openbrk
      unset %closbrk
    }
    set %openbrk $calc($pos(%txt,$chr(123) $+ $chr(32),0) + %openbrk + $iif($right(%txt,1) == $chr(123),1))
    set %closbrk $calc($pos(%txt,$chr(32) $+ $chr(125),0) + %closbrk + $iif($left(%txt,1) == $chr(125),1))
    :skpBC2
    inc %n1
    if (!$isid) { did -a DC.BC 2 $int($calc(%prm * %n1 * 2)) 0 200 }
  }
  if (!%BC.err) {
    if ($isid) { return GOOD }
  }
  elseif (%BC.err) {
    unset %BC.err*
    if ($isid) { return ERROR }
  }
  unset %BC.err
  if ($did(DC.BC,1).lines <= 1) { dialog -x DC.BC DC.BC }
}
alias color.red {
  if ($var.read(Variables,dm.color) == Background) { mdx SetColor DO 17 background $rgb( $1 , $dm.edit(do,23) , $dm.edit(do,26) ) | var.set Options dmo.color.back $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($var.read(Variables,dm.color) == Text) { mdx SetColor DO 17 text $rgb( $1 , $dm.edit(do,23) , $dm.edit(do,26) ) | var.set Options dmo.color.text $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($var.read(Variables,dm.color) == Text Background) { mdx SetColor DO 17 textbg $rgb( $1 , $dm.edit(do,23) , $dm.edit(do,26) ) | var.set Options dmo.color.textbg $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($2 !== Edit) { did -i DO 20 1 $1 0 255 10 0:1,2:5,5:20 }
}
alias color.green {
  if ($var.read(Variables,dm.color) == Background) { mdx SetColor DO 17 background $rgb($dm.edit(do,20) , $1 , $dm.edit(do,26) ) | var.set Options dmo.color.back $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($var.read(Variables,dm.color) == Text) { mdx SetColor DO 17 text $rgb($dm.edit(do,20) , $1 , $dm.edit(do,26) ) | var.set Options dmo.color.text $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($var.read(Variables,dm.color) == Text Background) { mdx SetColor DO 17 textbg $rgb($dm.edit(do,20) , $1 , $dm.edit(do,26) ) | var.set Options dmo.color.textbg $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($2 !== Edit) { did -i DO 23 1 $1 0 255 10 0:1,2:5,5:20 }
}
alias color.blue {
  if ($var.read(Variables,dm.color) == Background) { mdx SetColor DO 17 background $rgb($dm.edit(do,20) , $dm.edit(do,23) , $1 ) | var.set Options dmo.color.back $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($var.read(Variables,dm.color) == Text) { mdx SetColor DO 17 text $rgb($dm.edit(do,20) , $dm.edit(do,23) , $1 ) | var.set Options dmo.color.text $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($var.read(Variables,dm.color) == Text Background) { mdx SetColor DO 17 textbg $rgb($dm.edit(do,20) , $dm.edit(do,23) , $1 ) | var.set Options dmo.color.textbg $dm.edit(do,20) $+ _ $+ $dm.edit(do,23) $+ _ $+ $dm.edit(do,26) }
  if ($2 !== Edit) { did -i DO 26 1 $1 0 255 10 0:1,2:5,5:20 }
}
alias color.refresh {
  if ($var.read(Variables,dm.color) == Text) {
    if ($1 !== Edit) {
      did -i DO 20 1 $gettok($var.read(Options,dmo.color.text),1,95) 0 255 10 0:1,2:5,5:20
      did -i DO 23 1 $gettok($var.read(Options,dmo.color.text),2,95) 0 255 10 0:1,2:5,5:20
      did -i DO 26 1 $gettok($var.read(Options,dmo.color.text),3,95) 0 255 10 0:1,2:5,5:20
    }
    did -i $dname 18 1 params $gettok($var.read(Options,dmo.color.text),1,95) 0 255 * 0 255 * *
    did -i $dname 22 1 params $gettok($var.read(Options,dmo.color.text),2,95) 0 255 * 0 255 * *
    did -i $dname 25 1 params $gettok($var.read(Options,dmo.color.text),3,95) 0 255 * 0 255 * *
  }
  if ($var.read(Variables,dm.color) == Background) {
    if ($1 !== Edit) {
      did -i DO 20 1 $gettok($var.read(Options,dmo.color.back),1,95) 0 255 10 0:1,2:5,5:20
      did -i DO 23 1 $gettok($var.read(Options,dmo.color.back),2,95) 0 255 10 0:1,2:5,5:20
      did -i DO 26 1 $gettok($var.read(Options,dmo.color.back),3,95) 0 255 10 0:1,2:5,5:20
    }
    did -i $dname 18 1 params $gettok($var.read(Options,dmo.color.back),1,95) 0 255 * 0 255 * *
    did -i $dname 22 1 params $gettok($var.read(Options,dmo.color.back),2,95) 0 255 * 0 255 * *
    did -i $dname 25 1 params $gettok($var.read(Options,dmo.color.back),3,95) 0 255 * 0 255 * *
  }
  if ($var.read(Variables,dm.color) == Text Background) {
    if ($1 !== Edit) {
      did -i DO 20 1 $gettok($var.read(Options,dmo.color.textbg),1,95) 0 255 10 0:1,2:5,5:20
      did -i DO 23 1 $gettok($var.read(Options,dmo.color.textbg),2,95) 0 255 10 0:1,2:5,5:20
      did -i DO 26 1 $gettok($var.read(Options,dmo.color.textbg),3,95) 0 255 10 0:1,2:5,5:20
    }
    did -i $dname 18 1 params $gettok($var.read(Options,dmo.color.textbg),1,95) 0 255 * 0 255 * *
    did -i $dname 22 1 params $gettok($var.read(Options,dmo.color.textbg),2,95) 0 255 * 0 255 * *
    did -i $dname 25 1 params $gettok($var.read(Options,dmo.color.textbg),3,95) 0 255 * 0 255 * *
  }
  mdx SetColor $dname 17 textbg $rgb($gettok($var.read(Options,dmo.color.textbg),1,95) , $gettok($var.read(Options,dmo.color.textbg),2,95) , $gettok($var.read(Options,dmo.color.textbg),3,95))
  mdx SetColor $dname 17 background $rgb($gettok($var.read(Options,dmo.color.back),1,95) , $gettok($var.read(Options,dmo.color.back),2,95) , $gettok($var.read(Options,dmo.color.back),3,95))
  mdx SetColor $dname 17 text $rgb($gettok($var.read(Options,dmo.color.text),1,95) , $gettok($var.read(Options,dmo.color.text),2,95) , $gettok($var.read(Options,dmo.color.text),3,95))
}
