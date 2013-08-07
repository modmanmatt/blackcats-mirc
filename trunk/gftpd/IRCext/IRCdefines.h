/*The source to some plug-ins have been provided
to allow you to help improve and add to the 
abilities of the server. The original code is property
of GuildFTPd and is for the explicit use of you,
the end user, for use with GuildFTPd.

Redistribution or reuse of any parts or whole
of the program code is only authorized when
credit or a reference is provided within your
program or program documentation  that the
code is an original component of GuildFTPd.

Downloading and using any source to any plug-in
assumes your agreement to these guidelines.

By downloading any of these source code archives,
you agree to these established terms. If you do not
agree to the terms outlined, you are restricted from
downloading them. 
We welcome any submitted improvements to any
of the original plug-ins or brand new plug-ins. 
Any such plug-ins will be considered for
distribution on the GuildFTPd website. 
Should we post your plug-in, we will also provide
due credit to you for your work.*/



#define RPL_ENDOFWHO 315
#define RPL_TOPIC 332
#define RPL_VERSION 351
#define RPL_WHOREPLY 352
#define RPL_NAMREPLY 353
#define RPL_ENDOFNAMES 366

#define ERR_NOSUCHNICK 401
#define ERR_NOSUCHSERVER 402
#define ERR_NOSUCHCHANNEL 403
#define ERR_TOOMANYCHANNELS 405
#define ERR_NONICKNAMEGIVEN 431
#define ERR_ERRONEUSNICKNAME 432
#define ERR_NICKNAMEINUSE 433
#define ERR_NICKCOLLISION 436
#define ERR_NOTONCHANNEL 442
#define ERR_NEEDMOREPARAMS 461
#define ERR_ALREADYREGISTRED 462
#define ERR_CHANNELISFULL 471
#define ERR_UNKNOWNMODE 472
#define ERR_INVITEONLYCHAN 473
#define ERR_BANNEDFROMCHAN 474
#define ERR_BADCHANNELKEY 475
#define ERR_NOPRIVILEGES 481
#define ERR_CHANOPRIVSNEEDED 482
#define ERR_CANTKILLSERVER 483

/*
        404     ERR_CANNOTSENDTOCHAN
        406     ERR_WASNOSUCHNICK
        407     ERR_TOOMANYTARGETS
        409     ERR_NOORIGIN
        411     ERR_NORECIPIENT
        412     ERR_NOTEXTTOSEND
        413     ERR_NOTOPLEVEL
        414     ERR_WILDTOPLEVEL
        421     ERR_UNKNOWNCOMMAND
        422     ERR_NOMOTD
        423     ERR_NOADMININFO
        424     ERR_FILEERROR
        441     ERR_USERNOTINCHANNEL
        443     ERR_USERONCHANNEL
        444     ERR_NOLOGIN
        445     ERR_SUMMONDISABLED
        446     ERR_USERSDISABLED
        451     ERR_NOTREGISTERED
        463     ERR_NOPERMFORHOST
        464     ERR_PASSWDMISMATCH
        465     ERR_YOUREBANNEDCREEP
        467     ERR_KEYSET
        491     ERR_NOOPERHOST
        501     ERR_UMODEUNKNOWNFLAG
        502     ERR_USERSDONTMATCH
        300     RPL_NONE
        302     RPL_USERHOST
        303     RPL_ISON
        301     RPL_AWAY
        305     RPL_UNAWAY
        306     RPL_NOWAWAY
        311     RPL_WHOISUSER
        312     RPL_WHOISSERVER
        313     RPL_WHOISOPERATOR
        317     RPL_WHOISIDLE
        318     RPL_ENDOFWHOIS
        319     RPL_WHOISCHANNELS
        314     RPL_WHOWASUSER
        369     RPL_ENDOFWHOWAS
        321     RPL_LISTSTART
        322     RPL_LIST
        323     RPL_LISTEND
        324     RPL_CHANNELMODEIS
        331     RPL_NOTOPIC
        341     RPL_INVITING
        342     RPL_SUMMONING
        364     RPL_LINKS
        365     RPL_ENDOFLINKS
        367     RPL_BANLIST
        368     RPL_ENDOFBANLIST
        371     RPL_INFO
        374     RPL_ENDOFINFO
        375     RPL_MOTDSTART
        372     RPL_MOTD
        376     RPL_ENDOFMOTD
        381     RPL_YOUREOPER
        382     RPL_REHASHING
        391     RPL_TIME
        392     RPL_USERSSTART
        393     RPL_USERS
        394     RPL_ENDOFUSERS
        395     RPL_NOUSERS
        200     RPL_TRACELINK
        201     RPL_TRACECONNECTING
        202     RPL_TRACEHANDSHAKE
        203     RPL_TRACEUNKNOWN
        204     RPL_TRACEOPERATOR
        205     RPL_TRACEUSER
        206     RPL_TRACESERVER
        208     RPL_TRACENEWTYPE
        261     RPL_TRACELOG
        211     RPL_STATSLINKINFO
        212     RPL_STATSCOMMANDS
        213     RPL_STATSCLINE
        214     RPL_STATSNLINE
        215     RPL_STATSILINE
        216     RPL_STATSKLINE
        218     RPL_STATSYLINE
        219     RPL_ENDOFSTATS
        241     RPL_STATSLLINE
        242     RPL_STATSUPTIME
        243     RPL_STATSOLINE
        244     RPL_STATSHLINE
        221     RPL_UMODEIS
        251     RPL_LUSERCLIENT
        252     RPL_LUSEROP
        253     RPL_LUSERUNKNOWN
        254     RPL_LUSERCHANNELS
        255     RPL_LUSERME
        256     RPL_ADMINME
        257     RPL_ADMINLOC1
        258     RPL_ADMINLOC2
        259     RPL_ADMINEMAIL
                        
*/