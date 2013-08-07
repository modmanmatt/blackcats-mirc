menu menubar {
  Duke Script
  .Setup:.dialog -m duke duke
  .-
  .Ad In #:msg # 10I Am Using K949'10s Sound Script 9::10 http://scripts.zilfa.com
  .Ad All:amsg 10I Am Using K949'10s Sound Script 9::10 http://scripts.zilfa.com
  .-
  .Reload:.load -rs duke.mrc
  .Unload:.unload -rs duke.mrc

}

dialog duke {
  title "Duke Nukem SB v1.0 - by Camaro350"
  size -1 -1 140 120
  option dbu
  box "Duke Nukem Sound Board Setup:", 1, 3 1 126 100
  button "OK", 2, 3 105 31 12, ok
  button "Cancel", 3, 34 105 31 12, cancel
  check "Turn on duke sounds", 4, 9 9 99 10
  box "This script is in beta, it is incomplete:", 6, 3 1 20 20
}
