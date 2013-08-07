;QuitMessagePicker.mrc v1.2 (c) Woodsman, 3/30/2000.  This is an mIRC add-on script.
;To load into mIRC, type '/load -rs QuitMessagePicker.mrc', w/o the quotes.  This
;includes 3 fun aliases:
;  /bye - allows you to pick a random quit message from a file, each time you log off.
;  /emoticons - displays a handy window of emoticons, each time you start mIRC.
;  /acronyms - displays a handy list of acronyms to the current window
;  see readme.txt for details
on 1:START: {
  /emoticons
}
alias bye {
  /var %numlines = $read -l0 "system\text\bye.txt"
  :byeagain
  /var %rand = $rand(1,%numlines)
  /var %Quitmsg = $read -nl $+ %rand "system\text\bye.txt"
  /echo -a %Quitmsg
  /quit %Quitmsg $logo(Exit)
}
alias emoticons {
  /window -n @emoticons
  /loadbuf @emoticons "c:\My Documents\emoticons.txt"
}
alias acronyms {
  /me lol = laughing out loud, rofl = rolling on floor laughing, roflmao = rolling on floor laughing my but off, afk = away from keyboard, bak = back at keyboard, brb = be right back, wb   = welcome back, bbl = be back later, btw = by the way, <g> = grin, <eg> = evil grin, gmta =   great minds think alike, ty = thank you, yw = your welcome.
}
