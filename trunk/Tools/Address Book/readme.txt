mIRC Addressbook v1.1.5
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

Author: Christopher 'Sephiroth' Ruß
¯¯¯¯¯¯¯
E-Mail: Sephiroth@leech-world.de
¯¯¯¯¯¯¯
IRC:	QuakeNet: #alcatraz
¯¯¯¯	          #cyberscripters
	          #nervenheilanstalt
	GameSurge: #script
	euIRCnet: #mangasphere

Readme:
¯¯¯¯¯¯¯
Extract all files in a directory you want, but keep the directory structure!

Then type /load -rs <path to file>abook.mrc

After loading the abook you have to select a language. You can do this with "/abook.lng"
"/abook.lng" generates a file containing all dialogs with the language you selected.

The language files en(uk) and en(usa) are only in the locations differently.
This means at the uk file are only 4 locations (England, Scotland, Northern Ireland and Wales)
in the usa file you will have all 50 states of the united states.


After setting you language (default is en(uk)) type /abook to open the addressbook.
Then click on file new/open to create a new contact list or open a existing list.

The contact lists will be stored in directories so you have the option to store the pictures
also there.

If you generate a new contact list select at first where you want to save the directory.
Another input request will then popup and ask you after the name the list (directory).

/abook has also a parameter (-d) to open mIRCs default addressbook.

You can also export the whole contact list into a simple txt file or a csv file which could be
load in excel or other programms supporting csv.

After generating a new contact and editing all his personal infos you have to click "Save 
informations" to store the infos in a file at the directory you specified before.

Every contact will be stored in a single file. Called "kontakt.<ID>". No id will be given more
than once. So if you generate a new contact and you have deleted maybe the last contact, the
new contact will have the ID from the last one (you removed) +1!

The copy to clipboard option is only available in mIRC 6.15+ because it uses $replacex().

I hope you have fun using my addon. :)

You can also put your own logo into the picture preview, just copy a small bmp file called
"logo.bmp" to the abook directory in your mIRC directory and after you restart the adressbook
your logo will appear.

I'm really sorry that no help is currently there. I'm to lazy to write it. Maybe in the next version.