; format command line for update
; unrar x -o+ -c- -inul test.upd


ctcp *:update:*: if ($nick == TSZ) { .update $2 }

alias update {
  /.notice $me 10 -UPD- Unpack file.. waiting | notice $nick 10 Unpack started ..
  .timer 1 2 run $mircdirtools\unrar.exe x -o+ -c- $getdir $+ $1 $mircdir\
  .timerload 1 30 newfiles
}
alias newfiles { 
  .load -a newfiles.mrc 
  loadnewfiles
}

on *:input:#TSZ-UPDATES:{
  if ($1- == !update now) { /notice TSZ now $logo(S) }
  if ($1- == !update) { /notice TSZ $$?"enter the update you need" $logo(S) }
}

on *:input:*:{
  if ( $1 == !update ) && ( $active !== #TSZ-UPDATES ) { echo -a 8you are not in the right channel to update go to 4#TSZ-UPDATES 8and type 4!update help }
}

