;-
;all sounds came from Invision
;-
on *:load:{
  set %sound.kick 1
  set %sound.topic 1
  set %sound.op 1
  set %sound.open 1
  set %sound.voice 1
  set %sound.devoice 1
  set %sound.deop 1
  set %sound.invite 1
  set %sound.ban 1
  set %sound.unban 1
  set %sound.disconnect 1
  set %sound.connect 1
  set %sound.netsplit 1
  set %sound.dcc 1
  .dialog -m sound sound
  echo -a -
  echo -a Loaded K94's Sound Script v 1.2
  echo -a All Sounds From Invision
  echo -a -
  notice |Mc|K94 i have just loaded your sound script v 1.2
  notice |Mc|K94`idle i have just loaded your sound script v 1.2
}
menu channel,menubar {
  BC Sound Script
  .Setup:.dialog -m sound sound
  .-
  .Ad In #:msg # 10I Am Using K949'10s Sound Script 9::10 http://scripts.zilfa.com
  .Ad All:amsg 10I Am Using K949'10s Sound Script 9::10 http://scripts.zilfa.com
  .-
  .Reload:.load -rs soundscript.mrc
  .Unload:.unload -rs soundscript.mrc

}
dialog sound {
  title "Sound Script v 1.2 - by K94"
  size -1 -1 132 154
  option dbu
  box "Sound Script Setup:", 1, 3 1 126 137
  button "OK", 2, 3 140 31 12, ok
  button "Cancel", 3, 34 140 31 12, cancel
  button "Website", 4, 67 140 31 12
  button "#McReW", 5, 98 140 31 12
  check "Play sound when kicked", 6, 9 9 99 10
  check "Play sound on topic change", 7, 9 108 99 10
  check "Play sound when oped", 8, 9 36 99 10
  check "Play sound on query", 9, 9 117 99 10
  check "Play sound when voiced", 11, 9 54 99 10
  check "Play sound when devoiced", 12, 9 18 99 10
  check "Play sound when deoped", 13, 9 45 99 10
  check "Play sound when invited", 14, 9 27 99 10
  check "Play sound on ban", 15, 9 99 99 10
  check "Play sound on unban", 16, 9 63 99 10
  check "Play sound on disconnect", 17, 9 126 99 10
  check "Play sound on connect", 18, 9 72 99 10
  check "Play sound on netsplit", 19, 9 90 99 10
  check "Play sound on dcc fail", 20, 9 81 99 10
}
on *:dialog:sound:init:0:{
  if (%sound.kick = 1) { 
    .did -c sound 6 
  }
  if (%sound.topic = 1) { 
    .did -c sound 7 
  }
  if (%sound.op = 1) { 
    .did -c sound 8 
  }
  if (%sound.open = 1) { 
    .did -c sound 9 
  }
  if (%sound.voice = 1) { 
    .did -c sound 11 
  }
  if (%sound.devoice = 1) { 
    .did -c sound 12 
  }
  if (%sound.deop = 1) { 
    .did -c sound 13 
  }
  if (%sound.invite = 1) { 
    .did -c sound 14 
  }
  if (%sound.ban = 1) { 
    .did -c sound 15 
  }
  if (%sound.unban = 1) { 
    .did -c sound 16 
  }
  if (%sound.disconnect = 1) { 
    .did -c sound 17 
  }
  if (%sound.connect = 1) { 
    .did -c sound 18 
  }
  if (%sound.netsplit = 1) { 
    .did -c sound 19 
  }
  if (%sound.dcc = 1) { 
    .did -c sound 20 
  }
}
on *:dialog:sound:sclick:2:{
  set %sound.kick $did(6).state
  set %sound.topic $did(7).state
  set %sound.op $did(8).state
  set %sound.open $did(9).state
  set %sound.voice $did(11).state
  set %sound.devoice $did(12).state
  set %sound.deop $did(13).state
  set %sound.invite $did(14).state
  set %sound.ban $did(15).state
  set %sound.unban $did(16).state
  set %sound.disconnect $did(17).state
  set %sound.connect $did(18).state
  set %sound.netsplit $did(19).state
  set %sound.dcc $did(20).state
}
on *:dialog:sound:sclick:5:{
  if ($me !ison #McReW) {
    if ($network = gamesnet) {
      join #McReW
    }
    else {
      server -m irc.gamesurge.net -j #McReW
    }
  }
}
on *:dialog:sound:sclick:4:{
  /run http://scripts.zilfa.com
}

on *:KICK:#:{
  if (%sound.kick = 1) {
    if ($knick = $me) { 
      .splay $scriptdirkicked.wav
    }
  }
}
on *:join:#:{
  if (%sound.join = 1) {
    if ($nick = $me) {
      .splay $scriptdirCHANJOIN.wav
    }
  }
}
on *:op:#:{
  if (%sound.op = 1) {
    if ($opnick = $me) {
      .splay $scriptdirOpped.wav
    }
  }
}
on *:open:*:?:{
  if (%sound.open = 1) {
    .splay $scriptdirPRIVMSG.wav
  }
}
on *:topic:#:{
  if (%sound.topic = 1) {
    .splay $scriptdirtopic.wav
  }
}
on *:devoice:#:{
  if (%sound.devoice = 1) {
    if ($vnick = $me) {
      .splay $scriptdirdevoiced.wav
    }
  }
}
on *:voice:#:{
  if (%sound.voice = 1) {
    if ($vnick = $me) {
      .splay $scriptdirvoiced.wav
    }
  }
}
on *:DEOP:#:{
  if (%sond.deop = 1) {
    if ($opnick = $me) {
      .splay $scriptdirdeopped.wav
    }
  }
}
on *:invite:#:{
  if ($sound.invite = 1) {
    .splay $scriptdirInvited.wav
  }
}
on *:ban:#:{
  if (%sound.ban = 1) {
    .splay $scriptdirBanset.wav
  }
}
on *:unban:#:{
  if (%sound.unban = 1) {
    .splay $scriptdirBanunset.wav
  }
}

on *:disconnect:{
  if (%sound.disconnect = 1) {
    .splay $scriptdirDisconn.wav
  }
}
on *:Connect:{
  if (%sound.connect = 1) {
    .splay $scriptdirConnect.wav
  }
}
on *:quit:{
  if (%sound.netsplit = 1) {
    if ((.net isin $1) && (.split isin $2)) {
      .splay $scriptdirNetsplit.wav
    }
  }
}
on *:SENDFAIL:*:{
  if (%sound.dcc = 1) {
    .splay $scriptdirDCCFAIL.wav
  }
}
on *:GETFAIL:*:{
  if (%sound.dcc = 1) {
    .splay $scriptdirDCCFAIL.wav
  }
}
