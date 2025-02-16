menu channel,status {
  .Time: {
    time
  }
}
alias time {
  window -poCzdk0 +tnbL @Time -1 -1 200 200
  window -poChzdk0 +tnbL @buffer -1 -1 800 800
  %time.o = n
  time.r
  .timertime 0 1 time.r
}
alias -l time.r {
  if (%time.o != y) {
    clear @buffer
    drawfill @buffer 0 0 1 1
    drawdot @buffer 14 300 420 340
    drawdot @buffer 1 300 400 360
    drawdot @buffer 0 290 400 360
    drawtext @buffer 1 Tahoma 50 375 85 12
    drawtext @buffer 1 Tahoma 50 645 330 3
    drawtext @buffer 1 Tahoma 50 385 580 6
    drawtext @buffer 1 Tahoma 50 125 330 9
    drawtext @buffer 14 Tahoma 40 23 -8 Made By BlueThen
    drawtext @buffer 12 Tahoma 40 20 -5 Made By BlueThen
    drawtext @buffer 14 Tahoma 40 503 -8 BlueThen.com
    drawtext @buffer 12 Tahoma 40 500 -5 BlueThen.com
    drawtext -p @buffer 14 Tahoma 40 14 636  $+ $date 
    drawtext -p @buffer 1 Tahoma 40 10 640  $+ $date 
    drawtext @buffer 14 Tahoma 70 675 605 $asctime(TT)
    drawtext @buffer 1 Tahoma 70 670 610 $asctime(TT)
    drawtext -p @buffer 14 Tahoma 40 494 636  $+ $asctime(h:nn:ss) 
    drawtext -p @buffer 1 Tahoma 40 490 640  $+ $asctime(h:nn:ss) 
    drawline @buffer 4 10 400 360 $calc(400 + (250 * $cos($calc(90+((60-$asctime(s))*6))).deg)) $calc(360 - (250 * $sin($calc(90+((60-$asctime(s))*6))).deg))
    drawline @buffer 10 10 400 360 $calc(400 + (150 * $cos($calc(90+((12-$asctime(h))*30))).deg)) $calc(360 - (150 * $sin($calc(90+((12-$asctime(h))*30))).deg))
    drawline @buffer 1 10 400 360 $calc(400 + (250 * $cos($calc(90+((60-$asctime(n))*6))).deg)) $calc(360 - (200 * $sin($calc(90+((60-$asctime(n))*6))).deg))
    drawcopy -m @buffer 0 0 800 800 @time 0 0 200 200
  }
}
on *:close:@time: {
  %time.o = y
  .timertime off
  window -c @buffer
}
