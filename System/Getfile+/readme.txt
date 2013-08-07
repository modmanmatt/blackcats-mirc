GetFile+ && MGetFile+ [Versión 1.19]        Author: [Niko]     Last modified: 08-01-2005

-Installation:

CAUTION: You need mIRC 6.11 or above to use this addon

* Load both *.mrc remote files,f.i:

  + Unzip on mIRC base folder
  + Type /load -rs "Getfile+\Getfile+.mrc"  
  + Type /load -rs "Getfile+\MGetfile+.mrc"
  

   
;###################################
   
[MGETFILE+]

CAUTION: This addon needs GETFILE+. It works as a front-end for getfile+

- Description: Multiple download manager, it works as a simplified version of Flashget for mIRC users
  It works with download queus and allows urls lists (The clasical *.lst files). When we add new downloads
  we can select them to be paused or autoqueued for download.
  If you close the manager window downloads are paused, and will be resumed on the next manager use


Note: I've included /mgetfile+_url if you want to add urls directly (/mgetfile+_url newurl) while manager
is open (/mgetfile+).


;###################################

 [GETFILE+]

-Description:

  Allows download of files from HTTP and FTP Servers using sockets on mIRC. 
  It's an advanced version of my old addon GETFILE. 
  Main differences between GETFILE AND GETFILE+ are:

  1- Dialogs have been supresed from the addon to allow scripters to use it for self-update features and a best performance
  2- Now it uses the new files commands on mirc (/fope,/fwrite,...) supported form mIRC 6.11
     It's a lot faster by avoid to reopen the file being downloaded on each bwrite access and moving the pointer to the right 
     position on the file.
  3- Two new signals provided
 

Note: It's only formed by Getfile+.mrc, other files on this package are from MGetfile+
   
-Features:
 
 1- <FTP+HTTP> Supports resume, it can continue the download of a partially downloaded file. This option
               is useful if download has been stopped but not all servers support it.
 
 2- <FTP+HTTP> Downloads can be used by a HTTP public proxy without password. You can get some of them on
               http://www.samair.ru/proxy/index.htm
               ONLY proxys supporting the GET Method can be used on this way   
  
 3- <HTTP>     Some servers try to avoid download of files from external links, so we can't start a direct download
               on our favourite browser. Getfile+ has been developed concerned on this issue and tries to bypass
               that servers. 
               As an example try to download              http://usuarios.lycos.es/addonsmirc/files/nksbot.zip
               using both IExplorer and Getfile+!
 
 4- <HTTP>     A lot of times when requesting a file from a server we are redirected to another url from which
               we can download it. This addons supports this issue, so it's compatible with cgi or php scripts
 
 5- <FTP>      FTP transfers can be done using ACTIVE or PASIVE mode. Difference is based on who starts the
               connection (who opens the port for comunication). Some servers works always on PASIVE or on
               ACTIVE mode. With this addon you can select which one you prefer

 Note: DSL users can be interesed on using PASIVE mode, on this way they forgot the problem of open ports
       on router, and if ACTIVE mode is obligatory (Servers requires it) you can always set a port range for that function
  
 7-            Download number are "not limited", it can download hundred of files at a time

 8-            You can run it on "Command line" mode. Type /getfile+ /? To see something similar to...

 Usage:
                  1- Getfile+ [-options] url [destination]
                  2- var %v = $Getfile+(url,destination).options
                  
  + url is the link to the file to be downloaded
  + destination is optional, by default is the Getdir on mIRC (DCC usually)
  + options:
     a -> resume , o -> overwrite .If files exists, this selects what addon will do. If both "oa" are indicated, 
          "o" has preference
     d -> forces direct download. If not indicated a proxy HTTP will be used if it was especified on getfile+ 
          configuration
     l -> show download log on a @window (named @Getfile+.Xnn,where Getfile+.Xnn is the local identifier of the download)
     i -> Ignores check to detect if HTTP server sends an informative html file. Use it carefully.

  + with option 2 you can look %v to know if an error was returned. If it was it will be returned on the form 
    Error: reason, else it will return local identifier Getfile+.Xnn of the download
   
    Examples:
    1) Getfile+ -ol http://usuarios.lycos.es/addonsmirc/files/nksbot.zip c:\socketsbots.zip 
    2) var %a = $Getfile+(http://usuarios.lycos.es/addonsmirc/files/nksbot.zip,c:\socketsbots.zip).ol

 Note: Using command line format (/getfile+) both url and download path supports spaces on their name if they are
       enclosed with "".


 General options can be set using the dialog /getfile+ /o
 
 
 
 // TIPS FOR SCRIPTERS, IGNORE THIS IF YOU ARE NOT A SCRIPTER //

- As a improvement on this version 5 signals are suplied which allow you to use Getfile+ as a self-update module
  for your script.
  They are named   GETFILE+_UPD , GETFILE+_OK , GETFILE+_ERR , GETFILE+_CONNECT and GETFILE+_CONNECT

1) GETFILE+_UPD is sent when you get bytes from the current download (with a higher frecuency rate of 1 per second).
   It's suplied to give you the data to make progress bars of the update service.
2) GETFILE+_OK is sent when a download finish successfully.
3) GETFILE+_ERR is sent when a downloads is stoped with an error (download interrupted,no connection,...)
4) GETFILE+_INIT is sent before the download begins. At this time all data from the download are ready for you.
5) GETFILE+_CONNECT is sent when you connect to the server.

Data on signals is tabbed using $chr(9) as the separator. On this way blank spaces will not hurt the download.
It's a good idea to do a /tokenize 9 $1- at the begin of each signal, so the data will be organized on the
following way:

$1 = Local id of the download, useful to check each download (It's the same name than the socket it uses and to 
     the file descriptor (used on fopen))
$2 = Bytes already downloaded 
$3 = Time used (on msc) to download $2 bytes
$4 = Number of initial Bytes. It will be 0 if...:
     + full file is being downloaded 
     + we are resuming and server doesn't support resume
     + we are overwriting an existing file

     If we resume successfully its value will be the size of file on disk
     just before download is resumed.


$5 = Total size of the file to be downloaded. Some servers doesn't provide
     information about file size,and so if download is interrupted there is
     no way to know if file has been fully downloaded. When this happens
     signal GETFILE+_OK will always be sent and $5 will be filled with -1 value.
     On correct downloads      $5 (total) = $4 (starting) + $2 (downloaded)

$6 = Name on HD of the file being downloaded 
     Example: c:\temp\winzip.exe
$7 = Url , link on internet of the file to be downloaded. 
     Example: http://www.airtel.net/file.txt
$8 = Date of file on web server,it's a last modificated date


GETFILE+_ERR gets two more data:

$9 = Two values:
     + 0 : No operation on HD
     + 1 : Operation on HD, but error on transfer. It can be used then the "a" resume flag
           to try it again.

$10 = Error Description , usually on the way  "Error: text" , without ""

GETFILE+_INIT gets one more data:

$9 = It can return 4 values:

   0 -> A new file will be downloaded on HD
   1 -> Resume is set and server supports it
   2 -> Overwrite is set, file will be downloaded from the start of file on server
  -1 -> Resume is set but server doesn´t support it. If download is not stopped using "getfile+close $1"
        file on HD will be overwrited

Purpose of this signal are mainly the following:

  a) If we want a self-updater function this will be the moment to init data of downloads, for ex. limit of progressbars
  b) If we want to resume we can get using $9 if server supports that mode, and stop the download if it doesn't
  c) To check file name on web using $gettok($7,-1,47) and abort download if we see that server send informative html
     It's very useful when using  -i flag
  
Signal GETFILE+_CONNECT send the same number of parameters than GETFILE+_OK and GETFILE+_UPD:
   
  + $1 : Same that on GETFILE+_OK
  + $2 : Reserved for future development
  + $3 : 1 if we are using a proxy set on Options or 0 if not
  + $4 : Host (Of proxy or server where file is, take a look to $3)
  + $5 : Port (Of proxy or server where file is, take a look to $3)
  + $6 : Same that on GETFILE+_OK
  + $7 : Same that on GETFILE+_OK


Examples of signals


;$1 = id ; $2 = downloaded ; $3 = Time (msec.) ; $4 = starting file size ; $5 = total file size ; $6 = File name ; $7 = Url ; $8 = Date
on *:signal:GETFILE+_UPD: {
  tokenize 9 $1- | var %destino = $iif($window($+(@,$1)),$+(@,$1),-s)
  echo %destino $+([,,$1,,]) Downloading12 $7 on02 $6 , Downloaded03 $bytes($2,3).suf in06 $round($calc($3 / 1000),2) secs , speed =04 $+($bytes($calc(1000 * $2 / $3),3).suf,/,seg) , File percent = $+(07,$bytes($calc($4 + $2),3).suf,/10,$bytes($5,3).suf,05) $round($calc(100 * ($2 + $4)/ $5),1) $+ %
}

;$1 = id ; $2 = downloaded ; $3 = Time (msec.) ; $4 = starting file size ; $5 = total file size, -1 if HTTP server doesn't send info about it; $6 = File name ; $7 = Url ; $8 = Date
on *:signal:GETFILE+_OK: {
  tokenize 9 $1- | var %destino = $iif($window($+(@,$1)),$+(@,$1),-s)
  if ($5 == -1) { echo %destino $+([,,$1,,]) Download of file12 $7 has ended, can't know if file is fully downloaded. Date:10 $iif($8,$8,Unknown) .Downloaded as02 $6 }
  else { echo %destino $+([,,$1,,]) Download of file12 $7 has ended successfully. Date =10 $8 .Saved as02 $6 }
}

;$1 = id ; $2 = downloaded ; $3 = Time (msec.) ; $4 = starting file size ; $5 = total file size ; $6 = File name ; $7 = Url ; $8 = Date ; $9 = 1 or 0, if operation on HD was taken or not ; $10 = Error description
on *:signal:GETFILE+_ERR: {
  tokenize 9 $1- | var %destino = $iif($window($+(@,$1)),$+(@,$1),-s)
  echo %destino $+([,,$1,,]) Error on download 12 $7 .Date =10 $iif($8,$8,Unknown) 05 $10
}

;$1 = id ; $2 = downloaded ; $3 = Time (msec.) ; $4 = starting file size ; $5 = total file size ; $6 = File name ; $7 = Url ; $8 = Date ; $9 = (0)no file , (1)resume , (2)overwrite , (-1) can't resume
on *:signal:GETFILE+_INIT: {
  tokenize 9 $1- | var %destino = $iif($window($+(@,$1)),$+(@,$1),-s)
  echo %destino $+([,,$1,,]) Starting download of12 $7 on02 $6  .Next operation = $iif($9 == 1,Resuming,$iif($9 == 2,Overwriting,$iif($9 == 2,Can't resume - Overwriting if not getfile+close,Downloading on new file)))
}

;$1 = id ; $2 = reserved ; $3 = ¿Proxy? ; $4 = Host ; $5 = Port ; $6 = File name ; $7 = Url 
on *:signal:GETFILE+_CONNECT: {
  tokenize 9 $1- | var %destino = $iif($window($+(@,$1)),$+(@,$1),-s)
  echo %destino $+([,,$1,,]) Conected to02 $+($4,:,$5) $iif($3,( $+ Proxy $+ )) to download12 $7 on02 $6  
}


Two alias have been also included:

 1) getfile+close : uses Local identifier of a download as parameter $1. IDentifier uses the form getfile+.Xnn where nn is 
    a two digit number (01,02,99). Using this alias we can stop a download at any time. If called as an 
    identifier $getfile+close() it will return 1 if download was being taken or 0 if not.
    If download was being taken signal GETFILE+_ERR will be sent and "Descarga Cancelada." will be
    suplied as info. (It has not been translated to assure the compatibility with versions in different languages)

 2) getfile+close.all. Stop all downloads on GETFILE+. Use it carefully

 
That's all folks!

/**********************************/

English version translated by Mefisto http://www.averno.org 

Updates:  http://mircaddons.webcindario.com  -  http://www.escripting.org 
E-Mail: niko11@eresmas.com (spanish)

/**********************************/