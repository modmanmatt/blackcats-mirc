-> $chan <-
.Info $chr(32) $chr(32) $chr(32) $chan:/chanstats echo
.-
.Users $chr(32) $chr(32) $chr(32) $+ $nick($chan,0):/chanstats echo
.Ops $chr(32) $chr(32) $chr(32) $chr(32) $nick($chan,0,o) ( $+ $round($calc(100 * ($nick($chan,0,o) / $nick($chan,0))),0) $+ % $+ ):/chanstats echo
.Halfops $chr(32) $nick($chan,0,h) ( $+ $round($calc(100 * ($nick($chan,0,h) / $nick($chan,0))),0) $+ % $+ ):/chanstats echo
.Voice $chr(32) $chr(32) $chr(32) $nick($chan,0,v) ( $+ $round($calc(100 * ($nick($chan,0,v) / $nick($chan,0))),0) $+ % $+ ):/chanstats echo
.Normal $chr(32) $chr(32) $+ $nick($chan,0,r) ( $+ $round($calc(100 * ($nick($chan,0,r) / $nick($chan,0))),0) $+ % $+ ):/chanstats echo
.-
.Modes $chr(32) $chr(32) $iif($chan($chan).mode == $null,N/A,$gettok($chan($chan).mode,1,32)) :/chanstats echo
-
.network services
..tsz2
...$iif(%tsz2 == on,>On<,On):%tsz2 = on
...$iif(%tsz2 == off,>Off<,Off):%tsz2 = off
-
Rejoin #:/hop
Part:/part
Invite user to #:invite $$?="Who would you like to invite?" #
Auto-Join:{ AddtoChanFolder $chan $chan($chan).topic }
Noteboard on $chan: {
  .enable #noteboard
  .disable #memoserv
  if ($window(@Noteboard) == $null) { 
    window -esl15 +l @Noteboard 0 0 640 480 | set %memochan $chan
    /var %nblines = $lines($mircdirtext\noteboard.txt)
    /var %i = 0
    while (%i < %nblines) {
      inc %i
      /aline -l @Noteboard $removecs($read -l $+ %i $mircdirtext\noteboard.txt,[A])
    } 
  }
  echo @Noteboard 1- 4YOU MUST BE IDENTIFIED FOR USE NOTEBOARD 
  echo @Noteboard 2- Use R/click on this window and use popup-menu ..enjoy!
}
-
Read $chan topic history:/outputtopichistory $chan
;$ifopfunc(#,Services on $chan)
.@Services window
..$iif(%window.services == on,>On<,On):%window.services = on
..$iif(%window.services == off,>Off<,Off):%window.services = off
.-
;.$ifchan(Moderators)
..Info: /chanserv info #
..-
..Control
...Op...: /chanserv op # $$?=" # > Enter nickname to op:"
...DeOp...: /chanserv deop # $$?=" # > Enter nickname to deop:"
...-
...Me
....Identify Me: /chanserv identify # $$?=" # > Enter channel password to get founder-level access:"
....-....Op Me: /chanserv op # $me
....Invite Me: /chanserv invite #....Unban Me: /chanserv unban #
...-
...Clear
....Modes (?): if ($?!="Are you sure you want to clear all modes? $crlf If you press YES, modes i, k, l, m, n, p, s, t will be reset.") { /chanserv clear # modes }
....Bans (?): if ($?!="Are you sure you want to clear all bans? $crlf If you press YES, all bans will be removed.") { /chanserv clear # bans }
....Ops (?): if ($?!="Are you sure you want to clear all ops? $crlf If you press YES, all +o will be removed.") { /chanserv clear # ops }
....Voices (?): if ($?!="Are you sure you want to clear all voices? $crlf If you press YES, all +v will be removed.") { /chanserv clear # voices }
....Users (?): if ($?!="Are you sure you want to clear all users? $crlf If you press YES, all users will be kicked.") { /chanserv clear # users }
....-
....Help: /chanserv help clear
..-
..Set
...FOUNDER
....Set... (?): if ($?!="Are you sure you want to change the founder nickname? $crlf If you press YES, current channel founder's nickname will be changed.") { /chanserv set # founder $$?=" # > Enter founder nickname (he/she will have founder-level access to the channel!):" }
....-
....Help: /chanserv help set FOUNDER
...SUCCESSOR
....Set...: /chanserv set # SUCCESSOR $$?=" # > Enter successor nickname (your second nickname, or your best friend):"
....-
....Help: /chanserv help set SUCCESSOR
...PASSWORD
....Set...: /chanserv set # PASSWORD $$?=" # > Enter new password for founder-level access (you MUST to remember it!):"
....-
....Help: /chanserv help set PASSWORD
...DESC
....Set...: /chanserv set # DESC $$?=" # > Enter channel description:"
....-
....Help: /chanserv help set DESC
...URL
....Set...: /chanserv set # URL $$?=" # > Enter channel URL (Web address):"
....-
....Help: /chanserv help set URL
...EMAIL
....Set...: /chanserv set # EMAIL $$?=" # > Enter channel e-mail:"
....-
....Help: /chanserv help set EMAIL
...ENTRYMSG
....Set...: /chanserv set # ENTRYMSG $$?=" # > Enter channel entry message:"....-
....Help: /chanserv help set ENTRYMSG
...TOPIC
....Set...: /chanserv set # TOPIC $$?=" # > Enter channel topic:"
....-
....Help: /chanserv help set TOPIC
...KEEPTOPIC
....ON: /chanserv set # KEEPTOPIC ON
....OFF: /chanserv set # KEEPTOPIC OFF
....-
....Help: /chanserv help set KEEPTOPIC
...TOPICLOCK
....ON: /chanserv set # TOPICLOCK ON
....OFF: /chanserv set # TOPICLOCK OFF
....-
....Help: /chanserv help set TOPICLOCK
...MLOCK
....Set...: /chanserv set # MLOCK $$?=" # > Enter modes (i, k, l, m, n, p, s, t), you can use + or - to enable or disable them (example: +nt-iklps):"
....Remove Lock (?): if ($?!="Are you sure you want to reset mode lock? $crlf If you press YES, all mode locks will be removed.") { /chanserv set # MLOCK + }
....-
....Help: /chanserv help set MLOCK
...PRIVATE
....ON: /chanserv set # PRIVATE ON
....OFF: /chanserv set # PRIVATE OFF
....-
....Help: /chanserv help set PRIVATE
...RESTRICTED
....ON (?): if ($?!="Are you sure you want to enable restricted access? $crlf If you press YES, non OP privileged users will be kicked automatically.") { /chanserv set # RESTRICTED ON }
....OFF (?): if ($?!="Are you sure you want to disable restricted access? $crlf If you press YES, non OP privileged users will not be kicked automatically.") { /chanserv set # RESTRICTED OFF }
....-
....Help: /chanserv help set restricted
...SECURE
....ON: /chanserv set # SECURE ON
....OFF: /chanserv set # SECURE OFF
....-
....Help: /chanserv help set SECURE
...SECUREOPS
....ON: /chanserv set # SECUREOPS ON
....OFF: /chanserv set # SECUREOPS OFF
....-
....Help: /chanserv help set SECUREOPS
...LEAVEOPS
....ON: /chanserv set # LEAVEOPS ON
....OFF: /chanserv set # LEAVEOPS OFF
....-
....Help: /chanserv help set LEAVEOPS
...OPNOTICE
....ON: /chanserv set # OPNOTICE ON
....OFF: /chanserv set # OPNOTICE OFF
....-
....Help: /chanserv help set OPNOTICE
...-
...Help: /chanserv help set
..-
..Access list
...List: /chanserv access # list
...-
...Add/Change...: /chanserv access # add $$?=" # > Enter nickname to add to the Access list " $$?=" Set level "
...Delete...: /chanserv access # del $$?=" # > Enter nickname to remove from Access list (or entry numbers range, or ALL to clear the access list):"
...-
...Help: /chanserv help access
..-
..Levels
...List: /chanserv levels # list
...-
...AUTOOP
....Set...: /chanserv levels # set AUTOOP $$?=" # > Enter value for AUTOOP level:"
....-
...AUTOHALFOP
....Set...: /chanserv levels # set AUTOHALFOP $$?=" # > Enter value for AUTOHALFOP level:"
....-
....Disable: /chanserv levels # disable AUTOOP
...AUTOVOICE
....Set...: /chanserv levels # set AUTOVOICE $$?=" # > Enter value for AUTOVOICE level:"
....-
....Disable: /chanserv levels # disable AUTOVOICE
...AUTODEOP
....Set...: /chanserv levels # set AUTODEOP $$?=" # > Enter value for AUTODEOP level:"
....-
....Disable: /chanserv levels # disable AUTODEOP
...NOJOIN
....Set...: /chanserv levels # set NOJOIN $$?=" # > Enter value for NOJOIN level:"
....-
....Disable: /chanserv levels # disable NOJOIN
...INVITE
....Set...: /chanserv levels # set INVITE $$?=" # > Enter value for INVITE level:"
....-
....Disable: /chanserv levels # disable INVITE
...AKICK
....Set...: /chanserv levels # set AKICK $$?=" # > Enter value for AKICK level:"
....-
....Disable: /chanserv levels # disable AKICK
...SET
....Set...: /chanserv levels # set SET $$?=" # > Enter value for SET level:"
....-
....Disable: /chanserv levels # disable SET
...CLEAR
....Set...: /chanserv levels # set CLEAR $$?=" # > Enter value for CLEAR level:"
....-
....Disable: /chanserv levels # disable CLEAR
...UNBAN
....Set...: /chanserv levels # set UNBAN $$?=" # > Enter value for UNBAN level:"
....-
....Disable: /chanserv levels # disable UNBAN
...OPDEOP
....Set...: /chanserv levels # set OPDEOP $$?=" # > Enter value for OPDEOP level:"
....-
....Disable: /chanserv levels # disable OPDEOP
...ACC-LIST
....Set...: /chanserv levels # set ACC-LIST $$?=" # > Enter value for ACC-LIST level:"
....-....Disable: /chanserv levels # disable ACC-LIST
...ACC-CHANGE
....Set...: /chanserv levels # set ACC-CHANGE $$?=" # > Enter value for ACC-CHANGE level:"
....-
....Disable: /chanserv levels # disable ACC-CHANGE
...MEMO
....Set...: /chanserv levels # set MEMO $$?=" # > Enter value for MEMO level:"
....-
....Disable: /chanserv levels # disable MEMO
...-
...Reset (?): if ($?!="Are you sure you want to reset levels? $crlf If you press YES, all levels will be reset to default values, for example AUTOOP = 5.") { /chanserv levels # reset }
...-
...Help
....General Help: /chanserv help levels
....-
....Level Descriptions: /chanserv help levels desc
..-
..A-Kick list
...List: /chanserv akick # list
...-
...Add...: /chanserv akick # add $$?=" # > Enter nickname or usermask (nick!user@host.domain) to add to the akick list (cannot be *!*@*):"
...Delete...: /chanserv akick # del $$?=" # > Enter nickname or usermask (nick!user@host.domain) to remove from akick list (or ALL to clear the akick list):"
...-
...Help: /chanserv help akick
..-
..Talk: /query ChanServ help
..-
..Help
...General Help: /chanserv help
...-
...Register: /chanserv help register
...Drop: /chanserv help drop
...Info: /chanserv help info
...Op: /chanserv help op
...DeOp: /chanserv help deop
...Identify: /chanserv help identify
...Invite: /chanserv help invite
...UnBan: /chanserv help unban
...-
...Other...: /chanserv help $$?="Enter help topic (for example SET LEAVEOPS):"
.$ifchan(Chan Modes)
..Topic:/topic $chan $$?="Enter Topic"
..-
..Invite only
...+:mode $chan +i
...-:mode $chan -i
..Key
...+:mode $chan +k $$?="Enter Key"
...-:mode $chan -k
..Limit
...+:mode $chan +l $$?="Enter Limit"
...-:mode %chan -l
..Secret
...+:mode $chan +s
...-:mode $chan -s
..Private Only
...+:mode $chan +p
...-:mode $chan -p
..Moderated
...+:mode $chan +m
...-:mode $chan -m
..No Extrnal MSGs
...+:mode $chan +n
...-:mode $chan -n
..Only Ops change topic
...+:mode $chan +t...-:mode $chan -t
..-
.$ifchan(ChanServ)
..Info:/.chanserv Info $chan all
..Ident
...Register:/.chanserv Register $chan $?="Enter the password to use" $?="Enter the description for channel"
...Identify:/.chanserv Identify $chan $?="Enter the channel password"
...LogOut:/.chanserv logout $chan $?="Which nickname should be logged out ?"
...-
...Get Key:/.chanserv getkey $chan
..Settings
...Identification
....Change Founder:/.chanserv Set $chan Founder $?="Enter the new founder's nickname"
....Change Successor:/.chanserv Set $chan Successor $?="Enter the new successor's nickname"
....Password:/.chanserv Set $chan Password $?="Enter the new password for this channel"
....-
....URL:/.chanserv Set $chan URL $?="Enter the new home URL for this channel"
....E-mail:/.chanserv Set $chan email $?="Enter the new e-mail address for this channel"
....Description:/.chanserv Set $chan Desc $?="Enter the new description for this channel"
....Entry Message:/.chanserv Set $chan entrymsg $?="Enter a new entry message for this channel"
...Topic:/.chanserv Set $chan topic $?="Enter the new topic for this channel"
...Security
....Topic Lock
.....On:/.chanserv Set $chan TopicLock On
.....Off:/.chanserv Set $chan TopicLock Off
....Mode Lock
.....Set:/.chanserv Set $chan Mlock $?="Enter the channel mode lock"
.....Clear All:/.chanserv clear $chan modes
....-
....Private
.....On:/.chanserv Set $chan Private On
.....Off:/.chanserv Set $chan Private Off
....Restricted
.....On:/.chanserv Set $chan Restricted On
.....Off:/.chanserv Set $chan Restricted Off
....Secure
.....On:/.chanserv Set $chan Secure On
.....Off:/.chanserv Set $chan Secure Off
....SecureOps
.....On:/.chanserv Set $chan SecureOps On
.....Off:/.chanserv Set $chan SecureOps Off
....SecureFounder
.....On:/.chanserv Set $chan SecureFounder On
.....Off:/.chanserv Set $chan SecureFounder Off
...Misc
....BanType
.....*!user@host:/.chanserv Set $chan BanType 0.....*!*user@host:/.chanserv Set $chan BanType 1
.....*!*@host:/.chanserv Set $chan BanType 2
.....*!*user@*.domain:/.chanserv Set $chan BanType 3
....Topic Retention
.....On:/.chanserv Set $chan Keeptopic On
.....Off:/.chanserv Set $chan Keeptopic Off
....SignKick
.....On:/.chanserv Set $chan SignKick On
.....Off:/.chanserv Set $chan SignKick Off
.....Level:/.chanserv Set $chan SignKick $?="Up to what level should the kick be signed ?"
....OpNotice
.....On:/.chanserv Set $chan OpNotice On
.....Off:/.chanserv Set $chan OpNotice Off
...Levels
....List:/.chanserv Levels $chan List
....Set:/.chanserv Levels $chan Set $?="Enter the level to set of" $?="What level should it be set to ?"
..Access
...List:/.chanserv access $chan list $?="Enter a filter (case sensitive)"
...Add
....Custom Level:/.chanserv access $chan add $?="Enter nickname to add" $?="Which level ?"
....Start Level:/.chanserv access $chan Add $?="Enter nickname to add" 10
....Voice Level:/.chanserv access $chan Add $?="Enter nickname to add" 20
....HalfOp Level:/.chanserv access $chan Add $?="Enter nickname to add" 50
....Op Level:/.chanserv access $chan Add $?="Enter nickname to add" 60
....Admin Level:/.chanserv access $chan Add $?="Enter nickname to add" 90
...Delete:/.chanserv access $chan Del $?="Enter number, nickname or address to delete"
..Command
...Control
....Voice:/.chanserv voice $chan $?="Enter the nickname you want to Voice"
....DeVoice:/.chanserv devoice $chan $?="Enter the nickname you want to DeVoice"
....HalfOp:/.chanserv halfop $chan $?="Enter the nickname you want to Halfop"
....DeHalfOp:/.chanserv dehalfop $chan $?="Enter the nickname you want to DeHalfop"
....Op:/.chanserv op $chan $?="Enter the nickname you want to OP"
....DeOp:/.chanserv deop $chan $?="Enter the nickname you want to DeOP"
....Admin:/.chanserv admin $chan $?="Enter the nickname you want to Admin"
....DeAdmin:/.chanserv deadmin $chan $?="Enter the nickname you want to DeAdmin"....-
....Mass DeOp:/.chanserv clear $chan ops
....Mass DeVoice:/.chanserv clear $chan voices
...Kick/Ban
....KickMe:/.chanserv kick $chan
....Kick:/.chanserv kick $chan $?="Enter the nickname you want to kick"
....Kick <why>:/.chanserv kick $chan $?="Enter the nickname you want to kick" $?="Enter the reason of this kick"
....Kick All Normal Users:/.chanserv clear $chan users
....-
....AutoKick
.....List:/.chanserv akick $chan List
.....Add:/.chanserv Akick $chan Add $?="Enter nickname or address to add"
.....Delete:/.chanserv Akick $chan Del $?="Enter number, nickname or address to delete"
....Unban
.....Me:/.chanserv Unban $chan Me
.....All:/.chanserv clear $chan bans
.NickServ
..Info
...Info:/.nickserv info $?="Enter the nickname to get info on" all
...Group List:/.nickserv glist
...List:/.nickserv list $?="Enter the pattern to list"
...Status:/.nickserv status $?="Enter the nickname"
..Ident
...Register:/.nickserv Register $?="Enter the password you want to use" $?="Enter in an Email Address too"
...Identify:/.nickserv Identify $?="Enter your password"
...LogOut:/.nickserv logout
...Group:/.nickserv group $?="Enter the group name" $?="Enter the group's password"
...-
...Recover:/.nickserv recover $?="Enter nickname to recover" $?="Enter password for the nickname"
...Release:/.nickserv release $?="Enter nickname to recover" $?="Enter password for the nickname"
...Ghost:/.nickserv ghost $?="Enter nickname to ghost <Kill>" $?="Enter password for the nickname"
..Settings
...Identification
....Change Password:/.nickserv set password $?="Enter new password"
....-
....URL:/.nickserv set url $?="Enter your url"
....email:/.nickserv set email $?="Enter your email"
....ICQ:/.nickserv set icq $?="Enter your icq number"
....Greeting Msg:/.nickserv set greet $?="Enter your greeting message"
....-
....Display (Groups only):/.nickserv set display $?="Enter the new display"....Drop:/.nickserv drop $me
...Security
....Kill Protection
.....On:/.nickserv set kill on
.....Off:/.nickserv set kill off
....Security
.....On:/.nickserv set secure on
.....Off:/.nickserv set secure off
....Private
.....On:/.nickserv set private on
.....Off:/.nickserv set private off
....Hide Options
.....email
......On:/.nickserv set hide email on
......Off:/.nickserv set hide email off
.....UserMask
......On:/.nickserv set hide usermask on
......Off:/.nickserv set hide usermask off
.....Quit Message
......On:/.nickserv set hide quit on
......Off:/.nickserv set hide quit off
....Comm Method
.....Msg:/.nickserv set msg on
.....Notice:/.nickserv set msg off
...Access
....Add Mask:/.nickserv access add $?="Enter the mask you like to add to your access list"
....Del Mask:/.nickserv access add $?="Enter the mask you like to delete from your access list"
....List:/.nickserv access list
.BotServ
..Info
...List Bots:/.botserv botlist
...Chan:/.botserv info $chan
...Bot:/.botserv info $?="On what bot do you like info ?"
..Settings
...Assignment
....Assign:/.botserv assign $chan $?="Enter the bots name u want to use"
....Unassign:/.botserv unassign $chan
...Protect
....Don't Kick Ops:/.botserv set $chan dontkickops on
....Do Kick Ops:/.botserv set $chan dontkickops off
....Don't Kick Voices:/.botserv set $chan dontkickvoices on
....Do Kick Voices:/.botserv set $chan dontkickvoices off
...Display Greetings
....On:/.botserv set $chan greet on
....Off:/.botserv set $chan greet off
...Fantasy Commands
....On:/.botserv set $chan fantasy on
....Off:/.botserv set $chan fantasy off
...Symbiosis Mode
....On:/.botserv set $chan symbiosis on
....Off:/.botserv set $chan symbiosis off
...Action Kick
....Bolds
.....On:/.botserv kick $chan bolds on $?="Enter a number of kicks before a ban occurs"
.....Off:/.botserv kick $chan bolds off
....Badwords
.....On:/.botserv kick $chan badwords on $?="Enter a number of kicks before a ban occurs"
.....Off:/.botserv kick $chan badwords off
....Caps
.....On:/.botserv kick $chan caps on $?="Enter a number of kicks before a ban occurs" $?="specify the minimum number of caps" $?="specify the minimum percentage of caps"
.....Off:/.botserv kick $chan caps off
....Colors
.....On:/.botserv kick $chan colors on $?="Enter a number of kicks before a ban occurs"
.....Off:/.botserv kick $chan colors off
....Floods
.....On:/.botserv kick $chan floods on $?="Enter a number of kicks before a ban occurs" $?="number of lines" $?="maximum number of seconds"
.....Off:/.botserv kick $chan floods off
....Repeats
.....On:/.botserv kick $chan repeats on $?="Enter a number of kicks before a ban occurs" $?="maximum number of repeats"
.....Off:/.botserv kick $chan repeats off
....Reverses
.....On:/.botserv kick $chan reverses on $?="Enter a number of kicks before a ban occurs"
.....Off:/.botserv kick $chan reverses off
....Underlines
.....On:/.botserv kick $chan underlines on $?="Enter a number of kicks before a ban occurs"
.....Off:/.botserv kick $chan underlines off
..Badwords
...Add
....word:/.botserv badwords $chan add $?="Enter the new badword"
....word ending in:/.botserv badwords $chan add $?="Enter the new badword" end
....word starting with:/.botserv badwords $chan add $?="Enter the new badword" start
....single word:/.botserv badwords $chan add $?="Enter the new badword" single
...Delete
....word:/.botserv badwords $chan del $?="Enter the badword to delete"
....entry:/.botserv badwords $chan del $?="Enter the entrynumber of the badword to delete, or a list like 2-5,7-9"
...List
....mask:/.botserv badwords $chan list $?="Enter the mask of the badwords to list"
....entry:/.botserv badwords $chan list $?="Enter the entrynumber of the badword to list, or a list like 2-5,7-9"...Clear:/.botserv badwords $chan clear
..-
..Act:/.botserv act $chan $?="Enter the text to display"
..Say:/.botserv say $chan $?="Enter the text to say"
.$ifchan(MemoServ)
..Read
...Nick
....All:/.memoserv read
....Last:/.memoserv read last
....New:/.memoserv read new
....Entry:/.memoserv read $?="Enter the entrynumber of the memo you like to read, or a list like 2-5,7-9"
...Chan
....All:/.memoserv read $chan
....Last:/.memoserv read $chan last
....New:/.memoserv read $chan new
....Entry:/.memoserv read $chan $?="Enter the entrynumber of the memo you like to read, or a list like 2-5,7-9"
..List
...Nick
....All:/.memoserv list
....New:/.memoserv list new
....Entry:/.memoserv list $?="Enter the entrynumber of the memo you like to list, or a list like 2-5,7-9"
...Chan
....All:/.memoserv list $chan
....New:/.memoserv list $chan new
....Entry:/.memoserv list $chan $?="Enter the entrynumber of the memo you like to list, or a list like 2-5,7-9"
..Delete
...Nick
....All:/.memoserv del all
....Entry:/.memoserv del $?="Enter the entrynumber of the memo you like to delete, or a list like 2-5,7-9"
...Chan
....All:/.memoserv del $chan all
....Entry:/.memoserv del $chan $?="Enter the entrynumber of the memo you like to delete, or a list like 2-5,7-9"
..-
..Send:/.memoserv send $?="Enter the chan or nick you want to send a memo to" $?="Enter the memo"
..Cancel:/.memoserv cancel $?="Enter the chan or nick you sent a memo to that you want to cancel"
..-
..Settings
...Notify
....On:/.memoserv set notify on
....Logon:/.memoserv set notify logon
....New:/.memoserv set notify new
....Off:/.memoserv set notify off
...Limit
....$me:/.memoserv set limit $?="Enter the maximum number of memos (max. 40)"
....$chan:/.memoserv set limit $chan $?="Enter the maximum number of memos (max. 40)"
}
-
Addons
.NickAlert:/nickalert
.Away system:/aws
.Acronym:/acronc
.$iif($script(gftpdr1.mrc) == $null,Load GuildFTPD,$null):/load -rs gftpd\gftpd.mrc
.$iif($script(gftpdr1.mrc) != $null,GuildFTPD,$null)
..Configure:GFTPDCustomize
..Help
...Popups Help:GFTPDHelp.win gftpd\popups.help
...Colors Configure Window: GFTPDHelp.win gftpd\colors.help
...Port Configure Window: GFTPDHelp.win gftpd\ports.help
...Main Configure Window: GFTPDHelp.win gftpd\config.help
...Variable Help: GFTPDHelp.win gftpd\var.help
..-
..Re-Open Lost @GuildFTPD Window:GFTPDWinOpen
..Start GuildFTPD :{ run $readini Gftpd/Gftpd.ini GFTPDDlg GFTPDdir $+ guildftpd.exe }
..-
..Unload GFTPDScripts: { unload -as gftpd\gftpda1.ini | unload -rs gftpd\gftpdr1.mrc }
Setup Server
.Fserve
..Server
...$iif(%fserve == on,>On<,On):{
set %fserve on 
advertise start fserve
ame Restarted server <<= a True Sharer !!
.timerserverstopped off
}
...$iif(%fserve == off,>Off<,Off):{ 
set %fserve off
advertise stop fserve 
ame Server Stopped (Reason: Unknow)
.timerserverstopped 0 300 /ame Server Stopped (Reason: I'm a leecher)
}
..Config (F3):F3
..-
..Speed
...Tranfers Now
....Send $send(0) file/s in $BW kbs:echo -s 
....Get $get(0) file/s in $bw-getz kbs :echo -s
...$ifadmin(Speed)
...Min
....$iif(%Min.CPS isnum,Turn Off?,Turn On?):switch min
....MinCPS( $+ %min.cps $+ ):set %min.cps $$?"Minimum CPS?"  | w.set Min.CPS Rate %min.cps 
....Check Every ( $+ %check.time $+ ) secs:set %check.time $$?"Check every X secs" | w.set Min.CPS Delay %check.time | .timerMin.CPS 0 $r.set(Min.CPS,Delay) Min.CPS
...Max
....$iif(%dcc.cap.cps isnum,MaxCPS(on),MaxCPS(off))
....$iif(%dcc.cap.cps isnum,Turn Off?,Turn On?):switch max
....Change? currently( $+ %dcc.cap.cps $+ ):set %dcc.cap.cps $$?"example 5 for 5kb/s" * 1024 | .DCC MaxCPS %dcc.cap.cps
..Queue Manager:F2
..Dcc log manager: dopen dl dl
..-
.FTP
..Set advertise
...$iif(%ftpserv == on,>On<,On):{
set %ftpserv on 
ftpstart
ame Restarted FTP Info <<= a True Sharer !!
}
...$iif(%ftpserv == off,>Off<,Off):{
set %ftpserv off 
ftpoff 
ame FTP Info Stopped (Reason: I'm a Leecher)
}
..-
..View my config:/ftpsay
..Config advertise:F4
.XDCC
..Configure XDCC Server:/xdcc_dlg
..-
..Server Status
...$iif($xdcc(status) == on,>ON<,ON): xdcc_on 
...$iif($xdcc(status) == off,>OFF<,OFF): xdcc_off
..Advertise: 
...$iif($xdcc(advertisement) == on,>ON<,ON):.timerxdccadv 0 $calc(60*$xdcc(addelay)) xdcc_adv | writeini $mircdirxdcc\xdcc.ini xserver advertisement on | xdcc_adv
...$iif($xdcc(advertisement) == off,>OFF<,OFF):.timerxdccadv off | writeini $mircdirxdcc\xdcc.ini xserver advertisement off
..View Xdcc Stats: xdcc_stats
..Change MinCPS $+ $chr(58) $xdcc(mincps):writeini $mircdirxdcc\xdcc.ini xserver mincps $$?="MinCPS?" 
..Change Slots $+ $chr(58) $xdcc(maxslots):writeini $mircdirxdcc\xdcc.ini xserver maxslots $$?="Maximum open slots?"
-
-
View
.Show Credits:/Show.Credits
.Show Current Settings:ShowKi
.View FKeys:/Show.FKeys
.Usefull commands:/help
Clear Window: clear
-
Snarf
.Ratio Stats:/say snarf stats
.Torrent Stats:/say snarf torrentstats
.HnR's:/say snarf hnr
.SeedPoints:/say snarf sp
.Details:/say snarf details
.FAQ Count:/say snarf faqcount
.Rules Count:/say snarf rulescount
.Allowed Clients:/say snarf allowedclients
.Seed Point FAQ:/say snarf spfaq
