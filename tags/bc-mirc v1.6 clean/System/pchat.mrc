Script
.Advertise:me  $+ $sets(viz,ADV.text) $+ $logo | $+ $b($gzver) $+ | by | $+ $b(Zitarina) $+ |
.Credits:Show.Credits
.Show Current Settings:ShowKi
-  
Info
.Whois:/whois $$1
.DNS:/DNS $$1
.UCentral:/uwho $1
.Query:query $$1
.invite:invite $$1 #$$?="Enter Channels Name"
Notify
.Add:AddNotify $$1
.Remoe:notify -r $$1
Ignore
.ignore:ignore $$1 1
.Unignore:ignore -r $$1 1
Fserv
.Ban:auser 12 $$1
.UnBan:ruser $$1
DCC
.Send:dcc send $$1
.Chat:dcc chat $$1
Ctcp
.Ping:ctcp $$1 ping
.Finger:ctcp $$1 finger
.Version:ctcp $$1 version
.Time:ctcp $$1 time
.page:ctcp $$1 page $$?="Message"
-
TSZ MP3 player
.TSZ Mp3 Player Dialog:/IMP.start
.-
.Play file...:/IMP.playfile
.Play random:IMP.playrandom
.Replay last: IMP.replaylast
.Queue file...:IMP.queuefile
.Stop:splay stop
.Pause:splay pause
.Advertise:/IMP.advertise 1
/sound c:\mirc_server\System\Sounds\dkintro1.wav
