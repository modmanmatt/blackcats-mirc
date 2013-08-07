Web Experience v6 by: contr0l
Usage /web or /web www.bleh.com.. (yes you can use /web http://et... whatever you want)
extract the web folder in the zip to your mircdir then type [ /load -rs web\web.mrc ] - Now you can use /web

Updates in v6
1) Removed all buttons, and made them into MDX toolbar
2) Added Option to turn Ontop setting for browser window on/off
3) Now remembers History (15 items, once reached, history is cleared)
  -menu on @web window, that lists history.
4) Added 6 menus on the @web window in addition to the Navigation menu:
      -A Navigation menu, with basic navigation functions. (back, forward, refresh, etc)
      -A Source menu to view the source code of the current url.
      -A Translation menu, listing many differen ways of translating the current site.
      -A Zoom/FontSize menu, to adjust the current url's font size.
      -A Favorites menu, that loops thru all favorites you have recorded. and each is added as a menu item.
      -A History menu, that loops thru all history and creates a menu item for each.

5) Fixed history process
6) A Translate button on the controls dialog, pops up a menu same as @web translation menu.
7) Made the control dialog a lil bit smaller, not much.
8) Changed how some things are processed for efficiency.
9) Added View Source function (thx for the help e2ekiel)
10) Fixed Hotlinks
11) Just noticed that you can put c:\ etc in the addy bar and werx fine. as well as ftp:// , irc:// etc...
12) ALOT of code optimzations

*note* when you translate a url, it seems to bug when you try and translate a translated page.
 - so when you translate one page, if you wanna translate to another language, go back to the original page, and translate again.
---------------------------------------

Updates in v5

1) Changed the main command from /url to /web for obvious reasons.
2) Added a navigation menu to the @web window (using winmenu.dll)
  - So that you can minimize the main control dialog, to get it out of the way, and still have basic navigation functions via the menu.
3) @web window is resizeable
4) Removed the editbox from the @web window, so the horizontal scrollbar is now there. ;)
5) @web window's titlebar is updated with the current url's description.
6) added /wbm to only open the control dialog.
*7*) Made script more global, using $scriptdir and wrapping files/paths in "
  -*only setback, is when setting the icon for the mdx status bar, i couldnt use an identifer ($scriptdir), would only work with web\blue.ico
  -*so i still include all files in a web folder, in the zip, so it's best to just extract the zip to your mircdir, and load the web.mrc
8) Now when you maximize the @web window, it goes to almost fullscreen...
  -reason for this, is now it uses winmenu.dll for the navigation menu, and would only work with a desktoip window.
9) ALOT of code optimizations.
