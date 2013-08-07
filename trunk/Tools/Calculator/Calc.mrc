; Caculator right click in the channel or status to use it
; And from there on, it's just a calculator!
menu channel,status {
  MIRC Tools
  .Calculator:/dialog -md calc calc
}
menu menubar {
  MIRC Tools
  .Calculator:/dialog -md calc calc
}
dialog calc {
  size 400 300 175 197
  edit "",1,5 5 162 20
  button "1",2,10 30 30 30
  button "2",3,40 30 30 30
  button "3",4,70 30 30 30
  button "4",5,10 60 30 30
  button "5",6,40 60 30 30
  button "6",7,70 60 30 30
  button "7",8,10 90 30 30
  button "8",9,40 90 30 30
  button "9",10,70 90 30 30
  button "0",11,10 120 30 30
  button ".",12,40 120 30 30
  button "-",13,70 120 30 30
  button "×",14,130 60 30 30
  button "÷",15,100 60 30 30
  button "+",16,100 90 30 30
  button "=",17,100 120 30 30
  button "Clear",18, 100 30 60 30
  button "(",19, 130 90 30 30
  button ")",20, 130 120 30 30
  text "",21, 12 170 150 14
  text "",22, 20 184 150 14
  check "Display results in Active chan",23,5 150 170 15
}
on *:dialog:calc:sclick:*: {
  if ($did == 2) {
    if (%plus.on == 1) {
      did -r calc 1
    }
    did -a calc 1 1
  }
  if ($did == 3) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 2
  }
  if ($did == 4) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 3
  }
  if ($did == 5) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 4
  }
  if ($did == 6) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 5
  }
  if ($did == 7) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 6
  }
  if ($did == 8) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 7
  }
  if ($did == 9) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 8
  }
  if ($did == 10) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 9
  }
  if ($did == 11) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 0
  }
  if ($did == 12) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 .
  }
  if ($did == 13) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 -
  }
  if ($did == 14) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 *
  }
  if ($did == 15) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 /
  }
  if ($did == 16) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 +
  }
  if ($did == 17) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    if ($len($did(calc,1)) == 0 || $regex($did(calc,1),/[a-zA-Z]/) >= 1) {
      did -r calc 1
      did -a calc 1 You need numbers!
      set %plus.on 1
    }
    else {
      did -a calc 21 Calculator made by L0g2 St3w
      did -a calc 22 Visit: 4d.freeunixhost.com
      set %plus.1 $gettok($did(calc,1),1-,43))
      did -a calc 1 = $+ $calc(%plus.1)
      if ($did(calc,23).state == 1) {
        msg $active I calculated: $did(calc,1) Get great scripts like this at http://4d.freeunixhost.com/
      }
      set %plus.on 1
    }
  }
  if ($did == 18) {
    did -r calc 1
  }
  if ($did == 19) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 (
  }
  if ($did == 20) {
    if (%plus.on == 1) {
      did -r calc 1
      set %plus.on 0
    }
    did -a calc 1 )
  }
}
