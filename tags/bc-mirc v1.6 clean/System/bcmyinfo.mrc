menu menubar {
  BC My Info 
  .Script Version $rel:/me $logo(Release) $cin2($rel)
  .$iif($isfile($sets(programs,flashfxp)),FlashFXP Stats,$null)
  ..Show all:/fxpstat
  ..-
  ..Show Fxp stat:/fxpfxp
  ..Show Upload stat:/fxpup
  ..Show Download stat:/fxpdown
  .-
  .Download
  ..$mircdirdownload:View.Downloads
  .Fserv Info
  ..Show Status Public:/fsi
  ..View Status Private:/fsis
  ..-
  ...Fserv Status $+ $chr(58) $readini($mircdirSystem\Fserve.ini,np,Fserve,Status):/halt
  ...Accessed $+ $chr(58) $readini($mircdirSystem\Fserve.ini,np,Fserve,Access) times:/halt
  ...Max Sends $+ $chr(58) $readini($mircdirSystem\Fserve.ini,np,Fserve,Max.Sends.Total):/halt
  ...Max Queues $+ $chr(58) $readini($mircdirSystem\Fserve.ini,np,Fserve,Max.Queues.Total):/halt
  ...Transfer Record $+ $chr(58) $round($calc($gettok($readini($mircdirSystem\Fserve.ini,np,Fserve,Record.CPS),1,32)/1000),2) kb/s by $gettok($readini($mircdirSystem\Fserve.ini,np,Fserve,Record.CPS),2,32):/halt
  ...Sent $+ $chr(58) $size($readini($mircdirSystem\Fserve.ini,np,Fserve,Send.Bytes)) in $readini($mircdirSystem\Fserve.ini,np,Fserve,Send.Total) files:/halt
  ...Fserv note $+ $chr(58) $readini($mircdirSystem\Fserve.ini,np,Fserve,Note):/halt
  ...Current Gets $+ $chr(58) $get(0):/halt
  ...Current Sends $+ $chr(58) $send(0):/halt
  .Script stats
  ..View Private:/stats_view
  ..Show Public:/stats_show
  ..Overview:/scst
  ..-
  ..Script starts $chr(32) $chr(32) $+ $chr(32) $calc(%stats.starts):.
  ..Chars written $chr(32) $+ $chr(32) $calc(%stats.in.chars):.
  ..Words written $chr(32) $calc(%stats.in.words):.
  ..Lines written $chr(32) $chr(32) $calc(%stats.in.lines):.
  ..Quest. asked $chr(32) $+ $chr(32) $calc(%stats.in.questions):.
  ..-
  ..Users kicked $chr(32) $chr(32) $chr(32) $+ $calc(%stats.kicks):.
  ..Users banned $chr(32) $+ $chr(32) $calc(%stats.bans):.
  ..-
  ..Reset stats:/stats_reset
}
