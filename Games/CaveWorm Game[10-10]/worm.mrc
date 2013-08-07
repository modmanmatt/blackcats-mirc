alias worm {

  /window -adfkp +tf @worm -1 -1 200 220

  /drawtext @worm 1 1 20 CaveWomr Game
  /drawtext @worm 1 1 40 By Illusionz
  /drawtext @worm 1 1 60 Click to play
  /drawtext @worm 1 1 80 Click to restart

  %worm.s = dead

}

on 1:close:@worm:/.timerworm off

menu menubar {
  MIRC Games
  .ParWorm:/worm
}

alias -l goworm {

  %worm.vy = -5
  %worm.y = 100
  %worm.w = 40
  %worm.w2 = 2
  %worm.w3 = 120
  %worm.p = 0

  %worm.s = alive

  /drawrect -f @worm 0 1 0 0 200 200

  /drawrect -f @worm 12 1 0 0 200 40

  /drawrect -f @worm 12 1 0 160 200 41

  /doworm

}

alias -l doworm {

  /inc %worm.p

  if ( $rand(1,10) == 1 ) %worm.w2 = $rand(1,5)
  %worm.w = $calc( %worm.w + %worm.w2 - 3 )
  if ( %worm.w < 1 ) %worm.w = 1
  if ( %worm.w > $calc( 200 - %worm.w3 ) ) %worm.w = $calc( 200 - %worm.w3 )

  if ($mouse.key & 1) /dec %worm.vy
  else /inc %worm.vy
  %worm.y = $calc( %worm.y + $calc( %worm.vy / 20 ) )

  /drawline -n @worm 0 1 199 0 199 200

  ;  /drawdot -n @worm 14 1 99 $rand(0,99)
  ;  /drawdot -n @worm 14 1 99 $rand(0,99)
  ;  /drawdot -n @worm 14 1 99 $rand(0,99)
  ;  /drawdot -n @worm 14 1 99 $rand(0,99)

  %val = %worm.p % 30

  if ( %val == 1 ) {
    /drawrect -nr @worm 16711680 1 198 $rand(%worm.w,$calc(%worm.w + %worm.w3 - 30)) 2 30
  }

  %val = %worm.p % 50

  if ( %val == 1 ) {
    /dec %worm.w3
  }

  /drawline -nr @worm 16711680 1 199 0 199 %worm.w
  /drawline -nr @worm 16711680 1 199 1 199 %worm.w
  /drawline -nr @worm 16711680 1 199 $calc( %worm.w + %worm.w3 ) 199 200

  if ( $getdot( @worm, 50, %worm.y ) == 16711680 ) { /wormdie | halt }
  if ( %worm.y <= 1 || %worm.y >= 199 ) { /wormdie | halt }


  /drawline -n @worm 6 1 50 $calc( %worm.y - 2 ) 50 $calc( %worm.y + 2 )

  /drawscroll -n @worm -1 0 0 0 200 200

  /drawrect -nf @worm 0 1 0 201 200 20

  if ( %worm.h !isnum ) %worm.h = 0
  if ( %worm.p > %worm.h ) %worm.h = %worm.p

  /drawtext -n @worm 1 1 201 S: %worm.p
  /drawtext -n @worm 1 51 201 H: %worm.h

  /drawdot @worm

  /.timerworm -h 1 15 /doworm

}

alias -l wormdie {

  /drawline @worm 12 1 50 $calc( %worm.y - 2 ) 50 $calc( %worm.y + 2 )

  %val = 0
  while ( %val < 40 ) {
    /inc %val 3
    /drawrect -e @worm 4 1 $calc( 50 - %val ) $calc( %worm.y - %val ) $calc( %val * 2 ) $calc( %val * 2 )
  }

  /drawrect -nf @worm 0 1 10 50 80 16
  /drawtext @worm 1 10 50 You died 

  %worm.s = dead

  /halt

}

menu @worm {
  sclick:/checkgoworm
}

alias -l checkgoworm {
  if ( %worm.s == dead ) /goworm
}
