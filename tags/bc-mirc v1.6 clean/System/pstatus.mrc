-> $network <-
.Info $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $+ $network:.
.-
.Server $chr(32) $chr(32) $chr(32) $chr(32) $server:.
.IP $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $+ $chr(32) $chr(32) $serverip:.
.Port $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $port:.
.Connected $chr(32) $+ $duration($calc($uptime(server) / 1000)):.
.Idle $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $+ $chr(32) $chr(32) $duration($idle):.
-
$iif($server != $null,List Channels):{ list }
$iif($server != $null,List Servers):{ links }
-
Script Credits:Show.Credits
/wavplay c:\mirc_server\System\Sounds\Victory Fanfare Variation.mp3
Show Current Settings:ShowKi
View FKeys:Show.Fkeys
View Usefull Commands:/help
-
join ?:/join #$$?="Enter a channel to join:"
-
Change nick:/nick $$?="Enter a new nickname"
Identify:/.nickserv identify $$?="Enter your password"
Register:/.nickserv register $$?="Enter your password" $$?="Enter your e-mail address"
Chanserv Invite:/.chanserv invite $$?="Enter the channel where u want to be invited to"
-
Notify List
.Show:.notify -s
.Hide:.notify -h
Quits
.Normal: IRC:quit http://www.tpa.luvs.it
.Remote closed the connection:quit Remote closed the connection
.EOF of client: quit EOF of client
.Read Error: quit Read error: 104 (Connection reset by peer)
.Ping Timeout: quit Ping timeout: 180 seconds
Clear Window:clear
