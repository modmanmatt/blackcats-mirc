BlackCats-MIRC_v1.6.6_Clean
-
Version $rel: echo -a $about
Torrent Tracker Site : /run http://www.blackcats-games.net
.Download dir:run $getdir
-
MIRC Addons
.Addres Book:/abook
.-
...-
...View my config:/ftpsay
...Config advertise:F4
..-
..XDCC
...Configure XDCC Server:/xdcc_dlg
...-
...Server Status
....$iif($xdcc(status) == on,>ON<,ON): xdcc_on 
....$iif($xdcc(status) == off,>OFF<,OFF): xdcc_off
...Advertise: 
....$iif($xdcc(advertisement) == on,>ON<,ON):.timerxdccadv 0 $calc(60*$xdcc(addelay)) xdcc_adv | writeini $mircdirxdcc\xdcc.ini xserver advertisement on | xdcc_adv
....$iif($xdcc(advertisement) == off,>OFF<,OFF):.timerxdccadv off | writeini $mircdirxdcc\xdcc.ini xserver advertisement off
...View Xdcc Stats: xdcc_stats
...Change MinCPS $+ $chr(58) $xdcc(mincps):writeini $mircdirxdcc\xdcc.ini xserver mincps $$?="MinCPS?" 
...Change Slots $+ $chr(58) $xdcc(maxslots):writeini $mircdirxdcc\xdcc.ini xserver maxslots $$?="Maximum open slots?"
..-
.-
.$ifadmin(Admin)
..+OP Yourself
...Users Channel: /chanServ op #tsz $me
...Mods Channel: /chanServ op #tszmods $me
..Get Founder Access 
..Password ?:{ 
  if ( $?="Founder password?" == $null ) /echo -t 10 -Admin- a null password is not accepted ! ask a founder  else { 
  /writeini c:\pw.ini pass founder $!   /echo -t 10 -Admin- Register founder password 7 $!   }
}
..Users Channel:{ if ($isfile(c:\pw.ini) == $true ) /chanserv IDENTIFY #bc $readini c:\pw.ini pass founder | else /echo -t 10 -Admin- Set a founder password in TSZ menu/Admin ! }
..Mods Channel:{ if ($isfile(c:\pw.ini) == $true ) /chanserv IDENTIFY #bc $readini c:\pw.ini pass founder | else /echo -t 10 -Admin- Set a founder password in TSZ menu/Admin ! }
..-
.Unban Me
..Users Channel: /Chanserv Unban #tsz
..Mods Channel: /Chanserv Unban #tszmods
..Ban and Channel Config : /Channel #tsz
.-
.Whities
..Auto Voice Server
...$iif(%auto.voice == on,>On<,On):%auto.voice = on
...$iif(%auto.voice == off,>Off<,Off):%auto.voice = off
..Badword Kick
...$iif(%reg.badwords.kick == on,>On<,On):%reg.badwords.kick = on
...$iif(%reg.badwords.kick == off,>Off<,Off):%reg.badwords.kick = off
...Badword NoRejoin Kick
....$iif(%reg.badwords.ban == on,>On<,On):%reg.badwords.ban = on
....$iif(%reg.badwords.ban == off,>Off<,Off):%reg.badwords.ban = off
..Show trigger
...$iif(%reg.trigger.show == on,>On<,On):%reg.trigger.show = on
...$iif(%reg.trigger.show == off,>Off<,Off):%reg.trigger.show = off
.Notice
..Channel Notice:notice $chan  $+ $sets(viz,ADV.text) $+ | $+ $b(@notice) $+ $b(#) $+ | -  $$?="Enter Notice"
..Operator Notice:onotice $chan  $+ $sets(viz,ADV.text) $+ | $+ $b(@notice) $+ $b(#) $+ | -  $$?="Enter Notice"
.-
.Toolz
..Clone Seek:Clone.Check.start $chan
..Search Country
...Autralia:SiPSeek $chan AU
...BE:SiPSeek $chan BE
...Canada:SiPSeek $chan CA
...COM:SiPSeek $chan COM
...Denmark:SiPSeek $chan DK
...EDU:SiPSeek $chan EDU
...Nederland:SiPSeek $chan NL
...NET:SiPSeek $chan NET
...Sweden:SiPSeek $chan SE
...United Kingdom:SiPSeek $chan UK
.NetSplit Detector
..Warning-amsg $str($chr(160),2) ( $+ $iif(%netsplitWarning,On,Off) $+ )
...$iif(%netsplitWarning,Deactivate,Activate): {
  if (%netsplitWarning) unset %netsplitWarning
  else %netsplitWarning = 1
}
..Custom Quitmsg ( $+ $iif(%netsplitQuit,On,Off) $+ )
...$iif(%netsplitQuit,Deactivate,Activate): {
  if (%netsplitQuit) unset %netsplitQuit
  else %netsplitQuit = 1
}
..Close Msg? $str($chr(160),7) ( $+ $iif(%netsplitCloseMsg,Yes,No) $+ )
...$iif(%netsplitCloseMsg,Deactivate,Activate): {
  if (%netsplitCloseMsg) unset %netsplitCloseMsg
  else %netsplitCloseMsg = 1
}
..Close DCC
...Sends $str($chr(160),2) $+ ( $+ $iif(%netsplitCloseDCCSends,Yes,No) $+ )
....$iif(%netsplitCloseDCCSends,Deactivate,Activate): {
  if (%netsplitCloseDCCSends) unset %netsplitCloseDCCSends
  else %netsplitCloseDCCSends = 1
}
...Gets $str($chr(160),3) ( $+ $iif(%netsplitCloseDCCGets,Yes,No) $+ )
....$iif(%netsplitCloseDCCGets,Deactivate,Activate): {
  if (%netsplitCloseDCCGets) unset %netsplitCloseDCCGets
  else %netsplitCloseDCCGets = 1
}
...Chats $str($chr(160),3) $+ ( $+ $iif(%netsplitCloseDCCChats,Yes,No) $+ )
....$iif(%netsplitCloseDCCChats,Deactivate,Activate): {
  if (%netsplitCloseDCCChats) unset %netsplitCloseDCCChats
  else %netsplitCloseDCCChats = 1
}
...Fservs $str($chr(160),2) $+ ( $+ $iif(%netsplitCloseDCCFservs,Yes,No) $+ )
....$iif(%netsplitCloseDCCFservs,Deactivate,Activate): {
  if (%netsplitCloseDCCFservs) unset %netsplitCloseDCCFservs
  else %netsplitCloseDCCFservs = 1
}
..Reset Counter? $chr(160) ( $+ $iif(%netsplitCount,%netsplitCount,N/A) $+ ):unset %netsplitCount
..-
..About:nsabout
.-
.Admin Commands : /acom
.-
MIRC Tools
.NickAlert:/nickalert.options
.Away system:/aws
.Acronym:/acronc
.Nick colors:tsz_option.ncol
.User modes:tsz_option.umode
.Ignore list:tsz_option.ignore
.Pager:pager1
.-
MIRC Help
.Online Help :run http://www.blackcats-games.net/forum/index.php?showtopic=49462
.Register Keygenerator :run C:/mirc_server/Tools/keygen.exe
.Fkeys : Show.FKeys
.Command Help : /help
;.History:F11
;.About :F12
