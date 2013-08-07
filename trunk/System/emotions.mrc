/help {
  /echo -a $cin2(-Help-) 
  /echo -a $cin2(-Help-) $cin(Commands Help:)
  /echo -a $cin2(-Help-)
  /echo -a $cin2(-Help-) $cin(/god) $cin2(- Used for gods to get status)
  /echo -a $cin2(-Help-) $cin(/degod) $cin2(- Used for gods to get status)
  /echo -a $cin2(-Help-) $cin(/distro) $cin2(- Used for distro user to undo status)
  /echo -a $cin2(-Help-) $cin(/dedistro) $cin2(- For distro users to undo status)
  /echo -a $cin2(-Help-) $cin(/serve) $cin2(- Used for approved users to get status)
  /echo -a $cin2(-Help-) $cin(/deserve) $cin2(- For approved users undo status)
  /echo -a $cin2(-Help-)
  /echo -a $cin2(-Help-) $cin(/fex) $cin2(- Open fserv explorer)
  /echo -a $cin2(-Help-) $cin(/fexi) $cin2(- Open income queue)
  /echo -a $cin2(-Help-) $cin(/aws) $cin2(- Open the Away System)
  /echo -a $cin2(-Help-) $cin(/qmanager) $cin2(- Open the queue manager)
  /echo -a $cin2(-Help-) $cin(/cfg) $cin2(- Open the script config dialog)
  /echo -a $cin2(-Help-) $cin(/kaloom) $cin2(Open the about dialog)
  /echo -a $cin2(-Help-) $cin(@find filename) $cin2(- Search for a file on Fservers and FTPs)
  /echo -a $cin2(-Help-)
  /echo -a $cin2(-Help-) $cin(Stats Commands)
  /echo -a $cin2(-Help-)
  /echo -a $cin2(-Help-) $cin(/sys) $cin2(- Show System information public)
  /echo -a $cin2(-Help-) $cin(/sysself) $cin2(- View system information private)
  /echo -a $cin2(-Help-) $cin(/stats_show) $cin2(- Show script stats public)
  /echo -a $cin2(-Help-) $cin(/stats_view) $cin2(- View script stats private)
  /echo -a $cin2(-Help-) $cin(/fsi) $cin2(- Show fserv stats public)
  /echo -a $cin2(-Help-) $cin(/fsis) $cin2(- View fserv stats private)
  /echo -a $cin2(-Help-) $cin(/fxpstat) $cin2(- Show FlashFXP stat)
  /echo -a $cin2(-Help-)
  if ($me ison $chan) {
    if ($me isop $chan) {
      /echo -a $cin2(-Help-) $cin(Admin Commands)
      /echo -a $cin2(-Help-)
      /echo -a $cin2(-Help-) $cin(/Version) $cin2(- Users script version)
      /echo -a $cin2(-Help-) $cin(/speed) $cin2(- View users up/down tranfers)
      /echo -a $cin2(-Help-) $cin(/online) $cin2(- View users onlinetime)
      /echo -a $cin2(-Help-) $cin(/snagged) $cin2(- View how many GB users have served)
      /echo -a $cin2(-Help-) $cin(/hdrive) $cin2(- View users free harddrive space)
      /echo -a $cin2(-Help-) $cin(/ip) $cin2(- View users IP and Host)
      /echo -a $cin2(-Help-) $cin(/time) $cin2(- See users current time)
      /echo -a $cin2(-Help-) $cin(/limit) $cin2( - See users bandwith limit)
      /echo -a $cin2(-Help-)
    }
  }
  /echo -a 10 $cin2(-Help-) $cin(Emotions:)
  /echo -a 10 $cin2(-Help-)
  /echo -a 10 $cin2(-Help-) $cin(/tell nickname text) $cin2(- Private messages)
  /echo -a 10 $cin2(-Help-) $cin(/bow) $cin2(- You bow)
  /echo -a 10 $cin2(-Help-) $cin(/bow nickname) $cin2(- You bow for nickname)
  /echo -a 10 $cin2(-Help-) $cin(/Dance) $cin2(- Dance alone)
  /echo -a 10 $cin2(-Help-) $cin(/dance nickname) $cin2(- You dance with nickname)
  /echo -a 10 $cin2(-Help-) $cin(/wink) $cin2(- You wink to all)
  /echo -a 10 $cin2(-Help-) $cin(/wink nickname) $cin2(- You wink to nickname)
  /echo -a 10 $cin2(-Help-) $cin(/think text) $cin2(- You think the message)
  /echo -a 10 $cin2(-Help-) $cin(/egrin) $cin2(- You grin evil)
  /echo -a 10 $cin2(-Help-) $cin(/egrin nickname) $cin2(- You grin evil to nickname)
  /echo -a 10 $cin2(-Help-) $cin(/smile) $cin2(- You smile)
  /echo -a 10 $cin2(-Help-) $cin(/smile nickname) $cin2(- You smiles to nickname)
  /echo -a 10 $cin2(-Help-) $cin(/knock) $cin2(- You knock yourself)
  /echo -a 10 $cin2(-Help-) $cin(/knock nickname) $cin2(- You knock nickname)
  /echo -a 10 $cin2(-Help-) $cin(/sleep) $cin2(- You are sleeping)
  /echo -a 10 $cin2(-Help-) $cin(/sleep nickname) $cin2(- Nickname is sleepy)
  /echo -a 10 $cin2(-Help-) $cin(/sing) $cin2(- You sing)
  /echo -a 10 $cin2(-Help-) $cin(/sing nickname) $cin2(- You sing for nickname)
  /echo -a 10 $cin2(-Help-) $cin(/give nickname whattogive) $cin2(- You give nickname something)
  /echo -a 10 $cin2(-Help-) $cin(/version) $cin2(- Script version)
  /echo -a 10 $cin2(-Help-)
  /echo -a 10 $cin2(-Help-)
  /echo -a 10 $cin2(-Help-) $cin(If you need help to setup your script, then)
  /echo -a 10 $cin2(-Help-) $cin(ask any of the ops)
  /echo -a 10 $cin2(-Help-) 
}

/acom {
  /echo -a 10 -Admin- 
  /echo -a 10 -Admin- Special Commands for OPs
  /echo -a 10 -Admin- 
  /echo -a 10 -Admin- /acom - (This help command) 
  /echo -a 10 -Admin- /code text - (Replace text with your txt)
  /echo -a 10 -Admin- /version - (Users script version)
  /echo -a 10 -Admin- /speed - (View users up/down tranfers)
  /echo -a 10 -Admin- /online - (View users onlinetime)
  /echo -a 10 -Admin- /snagged - (View how many GB users have served)
  /echo -a 10 -Admin- /hdrive - (View users free harddrive space)
  /echo -a 10 -Admin- /god - (Op yourself)
  /echo -a 10 -Admin- /degod - (Deop yourself)
  /echo -a 10 -Admin- /ip - (View users IP and Host)
  /echo -a 10 -Admin- /time - (See users current time)
  /echo -a 10 -Admin-
}

/speed { 
  if $me isop $chan { /.msg $chan @1! | /echo -a 9 $logo(Admin) 9 Users bandwidth }
}

/hdrive { 
  if $me isop $chan { /.msg $chan @2! | /echo -a 9 $logo(Admin) 9 Users free harddrive }
}
/online { 
  if $me isop $chan { /.msg $chan @3! | /echo -a 9 $logo(Admin) 9 Users been online }
}

/snagged { 
  if $me isop $chan { /.msg $chan @4! | /echo -a 9 $logo(Admin) 9 Users snagged }
}

/version { 
  if $me isop $chan { /.msg $chan @5! | /echo -a 9 $logo(Admin) 9 Users Version }
}

/time { 
  if $me isop $chan { /.msg $chan @6! | /echo -a 9 $logo(Admin) 9 Users time }
}

/ip { 
  if $me isop $chan { /.msg $chan @7! | /echo -a 9 $logo(Admin) 9 Users Ip and Host }
}

/limit {
  if $me isop $chan { /.msg $chan @8! | /echo -a 9 $logo(Admin) 9 Users Bandwith limit }

}
/god { 
  /chanServ op # $me
}

/degod { 
  /chanServ deop # $me
}

/distro { 
  /chanServ halfop # $me
}

/dedistro { 
  /chanServ dehalfop # $me
}

/serve { 
  /chanServ voice # $me
}

/deserve { 
  /chanServ devoice # $me
}

/tell {
  if ($1 ison $chan) {
    if ($2 != $null) {
      /msg $1 $2-
    }
    else {
      echo -a 10 Type a message for $1 !
      echo -a 10 Help: /tell nickname message
    }
  }
  else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
}

/bow {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me bows deeply for $1
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me bows deeply
}

/dance {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me takes $1 hand, and dance around the channel
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me dance around the channel
}

/wink {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me winks to $1
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me winks to all m8s.
}

/think {
  if ($1 != $null) {
    /me . o O ( $1- )
  }
  else echo -a $logo(ScriptOS) 10 User $1 not exist on this channel !
}

/egrin {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me looks at $1 and grin evily
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me grins evily
}

/smile {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me smiles to $1
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me smiles
}

/knock {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me knocks $1 on the head
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me knock $me on the head
}

/sleep {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me thinks that $1 need some sleep
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me is sleeping.. Zzzzzz...
}

/sing {
  if ($1 != $null) {
    if ($1 ison $chan) {
      /me singing a song for $1.. ( Tralalala.. lala.. la.. )
    }
    else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
  }
  else /me singing a song.. ( Tralalala.. lala.. la.. )
}

/give {
  if ($1 ison $chan) {
    if ($2 != $null) {
      /me gives $2- to $1 
    }
    else {
      echo -a 10 Tell what to give $1
      echo -a 10 Help: /give nickname a cold beer
    }
  }
  else echo -a $logo(ScriptOS) 10 User $1 don't exist on this channel !
}
