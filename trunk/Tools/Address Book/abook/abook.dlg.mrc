;Please don't edit this file.
;This file is generated automatical!
dialog addressbook {
title "Addressbook"
size -1 -1 1 1
option dbu
icon abook\abook.ico, 0
tab "Contact", 12, 4 25 291 170
text "Name:", 16, 10 46 40 8, tab 12 right
link "Send", 22, 10 96 20 8, tab 12
icon 33, 225 46 60 60, $mircexe, 1, tab 12
box "Statements of Place", 42, 8 126 285 44, tab 12
text "Surname:", 17, 10 56 40 8, tab 12 right
edit "", 26, 55 45 150 10, tab 12 autohs
edit "", 27, 55 55 150 10, tab 12 autohs
text "Title:", 18, 10 66 40 8, tab 12 right
edit "", 28, 55 65 150 10, tab 12 autohs
text "Firm:", 19, 10 76 40 8, tab 12 right
edit "", 29, 55 75 150 10, tab 12 autohs
text "Telephone:", 20, 10 86 40 8, tab 12 right
edit "", 30, 55 85 150 10, tab 12 autohs
text "E-Mail:", 21, 30 96 20 8, tab 12 right
edit "", 31, 55 95 150 10, tab 12 autohs
text "Birthday:", 62, 10 106 40 8, tab 12 right
combo 63, 55 105 35 50, tab 12 drop
combo 64, 90 105 70 50, tab 12 drop
combo 65, 160 105 45 50, tab 12 drop
text "Note:", 23, 10 116 40 8, tab 12 right
edit "", 32, 55 115 235 10, tab 12 autohs limit 700
text "City:", 36, 110 146 30 8, tab 12 right
text "Street:", 34, 10 136 40 8, tab 12 right
text "ZIP Code:", 35, 10 146 40 8, tab 12 right
text "Location:", 37, 10 156 40 8, tab 12 right
edit "", 39, 55 135 235 10, tab 12
edit "", 40, 55 145 50 10, tab 12
edit "", 41, 145 145 145 10, tab 12
combo 38, 55 155 235 100, tab 12 sort size edit drop
button "Save information", 57, 45 174 105 12, tab 12
button "Copy informationen to the clipboard", 43, 155 174 135 12, tab 12
button "Clear", 59, 10 174 30 12, tab 12
tab "Contactlist", 11
list 44, 10 45 280 145, tab 11 size
tab "Search Contact", 13
list 45, 10 60 280 130, tab 13 size
text "Search criterion:", 46, 10 46 40 8, tab 13 right
edit "", 47, 55 45 190 10, tab 13
button "Search", 58, 253 44 37 12, tab 13 default
button "New Contact", 14, 5 5 50 12
button "Del Contact", 15, 60 5 50 12
combo 24, 162 6 110 120, sort size vsbar drop
text "Contactlist:", 25, 121 7 40 8, right
menu "&File", 1
item "&New", 9, 1
item break, 10, 1
item "O&pen", 4, 1
item "&Close", 5, 1
item break, 1000, 1
item "&Language", 6, 1
item break, 7, 1
item "E&xit", 8, 1, ok
menu "&Edit", 2
item "&New Contact", 48, 2
item "&Remove Contact", 49, 2
item break, 60, 2
item "&Export...", 61, 2
menu "&View", 50
item "&Contact", 51, 50
item "Contact&list", 52, 50
item "&Search &contact", 53, 50
menu "&?", 3
item "&Help...", 54, 3
item break, 56, 3
item "A&bout...", 55, 3
}
dialog about {
title "Addressbook"
size -1 -1 150 34
option dbu
icon abook\abook.ico, 0
icon 1, 2 9 16 16,abook\about.ico
text Addressbook $+ $crlf $+ $crlf $+ Written by Christopher Ruß $+ $chr(44) if you have Questions about it send a mail to Sephiroth@leech-world.de , 2, 20 2 132 27
}
dialog clip {
title "Copy to clipboard"
size -1 -1 265 95
option dbu
icon abook\abook.ico, 0
list 1, 5 10 50 65, size sort vsbar
list 2, 70 10 50 65, size vsbar
button ">>", 11, 56 10 12 12
button ">", 3, 56 25 12 12
button "<", 4, 56 40 12 12
button "<<", 12, 56 55 12 12
button "Up", 5, 122 10 25 12
button "Down", 6, 122 25 25 12
box "Select parts", 7, 2 1 150 77
box "Preview", 8, 153 1 110 77
button "Copy", 9, 100 80 37 12,ok
button "Cancel", 10, 140 80 37 12,cancel
text "", 13, 160 10 95 67
}
dialog export {
title "Export..."
size -1 -1 162 40
icon abook\abook.ico, 0
option dbu
button "Export", 1, 40 25 37 12,default
button "Cancel", 2, 85 25 37 12,cancel
text "Select a format for the export:", 3, 2 2 158 8
combo 4, 2 12 158 40, size drop
}
dialog ahelp {
title "Help"
size -1 -1 257 145
option dbu
list 1, 2 2 50 125, size
edit "", 2, 55 2 200 125, read multi return
button "Close", 3, 217 130 37 12,cancel
text "mIRC Abook v1.1 (multilang)", 4, 2 132 212 8,disabled
}
