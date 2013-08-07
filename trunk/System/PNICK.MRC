-> $snick($active,1) <-
.Info $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $+ $nick($active,$snick($active,1)).pnick:.
.-
.Status $chr(32) $chr(32) $chr(32) $chr(32) $+ $iif($nick($active,$snick($active,1),o) != $null,(@) - God,$iif($nick($active,$snick($active,1),h) != $null,(%) Distro,$iif($nick($active,$snick($active,1),h) != $null,(+) User,Newbie)))):.
.Adress $chr(32) $chr(32) $chr(32) $chr(32) $+ $iif($snick($active,1) == $me,$host,$gettok($address($snick($active,1),5),2,$asc(@))):.
.Comchans $chr(32) $+ $iif($comchan($snick($active,1),0) > 1,$comchans($snick($active,1)),$comchan($snick($active,1),1)):.
.Idle $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $chr(32) $duration($nick($active,$snick($active,1)).idle):.
-
ADD to Noteboard : { 
  if ($window(@noteboard) != $null) /aline -ls @Noteboard $removecs($$1,[A])
  /write $mircdirtext\noteboard.txt $removecs($$1,[A])
}
-
Info
.Whois:/whois $$1
.DNS:/DNS $$1
.UCentral:/uwho $1
.Traceroute:/tracert $gettok($address($1,5),2,64)
.-
.Ctcp
..Ping:/ctcp $$1 ping
..Finger:/ctcp $$1 finger
..Version:/ctcp $$1 version
..Time:/ctcp $$1 time
..Page:ctcp $$1 page $$?"message"
Settings
.Notify List
..Add:AddNotify $$1
..Remove:notify -r $$1
.Ignore
..ignore:/ignore $$1 1
..Unignore:/ignore -r $$1 1
Invite:invite $$1 #$$?="Enter Channels Name"
DCC/PM
.Query:query $$1
.Notice:notice $$1 $$?="whats the message?"
.Message:msg $$1 $$?="whats the message?"
.Attention:say  $+ $$1 $+ : $$?="whats the message?"
.Request chat:.ctcp $$1 CHAT
.-
.DCC Send:/dcc send $$1 | .notice $$1 i have sent you $send(1).file
.DCC Chat:/dcc chat $$1
-
MyNick
.Change nick:/nick $$?="Enter a new nickname"
.Identify:/.nickserv identify $$?="Enter your password"
.Register:/.nickserv register $$?="Enter your password" $$?="Enter your e-mail address"
-
$ifhalfop(#,control)
.$iif($snick(#,1) isreg $chan,User $snick(#,1)):mode $chan +v $$1
.$iif($snick(#,1) isvo $chan,Newbie $snick(#,1)):mode $chan -v $$1
.-
.Mass Control ( $snick(#,0) select )
..Voice:mode # +vvvv $$1 $2 $3 $4 | mode # +vvvv $$5 $6 $7 $8 | mode # +vvvv $$9 $10 $11 $12 | mode # +vvvv $$13 $14 $15 $16
..DeVoice:mode # -vvvv $$1 $2 $3 $4 | mode # -vvvv $$5 $6 $7 $8 | mode # -vvvv $$9 $10 $11 $12 | mode # -vvvv $$13 $14 $15 $16
$ifopfunc(#,Control)
.God $snick(#,1):mode $chan +ohv $$1 $$1 $$1
.Distro $snick(#,1):mode $chan -o+vh $$1 $$1 $$1
.User $snick(#,1):mode $chan -oh+v $$1 $$1 $$1
.Newbie $snick(#,1):mode $chan -ohv $$1 $$1 $$1
.-
.Mass Control ( $snick(#,0) select )
..Op:mode # +oooo $$1 $2 $3 $4 | mode # +oooo $$5 $6 $7 $8 | mode # +oooo $$9 $10 $11 $12 | mode # +oooo $$13 $14 $15 $16
..DeOp:mode # -oooo $$1 $2 $3 $4 | mode # -oooo $$5 $6 $7 $8 | mode # -oooo $$9 $10 $11 $12 | mode # -oooo $$13 $14 $15 $16
..HalfOp:mode # +hhhh $$1 $2 $3 $4 | mode # +hhhh $$5 $6 $7 $8 | mode # +hhhh $$9 $10 $11 $12 | mode # +hhhh $$13 $14 $15 $16
..DeHalfOp:mode # -hhhh $$1 $2 $3 $4 | mode # -hhhh $$5 $6 $7 $8 | mode # -hhhh $$9 $10 $11 $12 | mode # -hhhh $$13 $14 $15 $16
..Voice:mode # +vvvv $$1 $2 $3 $4 | mode # +vvvv $$5 $6 $7 $8 | mode # +vvvv $$9 $10 $11 $12 | mode # +vvvv $$13 $14 $15 $16
..DeVoice:mode # -vvvv $$1 $2 $3 $4 | mode # -vvvv $$5 $6 $7 $8 | mode # -vvvv $$9 $10 $11 $12 | mode # -vvvv $$13 $14 $15 $16
.Deop
...Bloody:/me thinks $$1 is being an ass. | .timer 1 3 /me grabs onto $$1's @ and yanks. Blood sprays across the channel, splattering all over her as the @ is severed from $$1's body. | .timer 1 4 /mode # -o $$1
...Crowbar:/me grabs her trusty crowbar and rips the @ off of $$1's body. | /mode # -o $$1
...Mace:/me draws her trusty vorpal mace of (-@) and knocks the @ off of $$1's shoulders. | /mode # -o $$1
...Guillotine:/me puts on her black hood, and bounds $$1's hands behind their back. | .timer 1 2 /me inserts $$1's (@) into the (-@) guillotine. | .timer 1 5 /me pulls the cord and laughs demonically as $$1's (@) is severed from their body. | .timer 1 7 /mode # -o $$1
.$ifadmin(Admin)
..Protect:mode $chan +a $$1
..Deprotect:mode $chan -a $$1
..SetAllLevels:mode $chan +aohv $$1 $$1 $$1 $$1
..DropAllLevels:mode $chan -aohv $$1 $$1 $$1 $$1
..Chanserv Modes
...Op:/.chanserv op $chan $$1
...DeOp:/.chanserv deop $chan $$1
...HalfOp:/.chanserv halfop $chan $$1
...DeHalfOp:/.chanserv dehalfop $chan $$1
...Voice:/.chanserv voice $chan $$1
...DeVoice:/.chanserv devoice $chan $$1
..Access List
...Add:/.chanserv access $chan add $$1 $$?="Enter the level"
...Delete:/.chanserv access $chan del $$1
...Check:/.chanserv access $chan list $$1
$ifopfunc($chan,Kick/Ban)
.Kick:mode # -Q | .timer 1 1 kick # $$1 | .timer 1 2 mode # +Q
.Kick(why):mode # -Q | .timer 1 1 kick # $$1 $$?="Reason for kick:" | .timer 1 2 mode # +Q
.Kick(text):mode # -Q | .timer 1 1 kick # $$1 $b($kicktext) | .timer 1 2 mode # +Q
.-
.NoRejoinKick:ban -u2 $$1 2 | kick # $$1
.NoRejoinKick(why):ban -u10 $$1 2 | kick # $$1 $$?="Enter Reason"
.NoRejoinKick(text):ban -u2 $$1 2 | kick # $$1 $b($kicktext)
.-
.Ban:ban $$1 2
.Ban(Timed):ban -u $+ $$?="Enter Time (in seconds)" $$1 2
.-
.Ban,Kick:ban $$1 2 | kick # $$1
.Ban,Kick(why):ban $$1 2 | kick # $$1 $$?="Enter Reason"
.Ban,Kick(text):ban $$1 2 | kick # $$1 $b($kicktext)
.-
.Add to AKick:/.chanserv Akick $chan Add $$1
.StickyBan
..Add:guser 5 $$1 2
..Remove:ruser 5 $$?"nick to remove from sticky ban?" 2
.-
.$ifop($chan,Shut Up Kick)
..Add:add.SUK $chan $1
..Remove:rem.SUK $chan $1
-
Lamers Tools
.SET 1
..[&S]chlong:/me whips out his 2 Foot Schlong and presses it against $$1 $+ 's forehead 
..[&9] Iron:/me Feels like golfing with $$1 $+ 's head. $me pulls out his 9 Iron and Bashes $$1 $+ 's Head!!
..[&N]ut Kick:/me Puts on his Doc Martens and kicks $$1 in the balls!!
..[&H]orny:/me thinks that $$1 is wat to horney to be in # !! $me hates horney losers who probably suck their own Genitles !! 
..[&O]J:/me puts on his Ski mask and stalks $$1 for a while. One day $me sees $$1 walking with somone he doesn't like. $me becomes insanely jealous and slices $$1 $+ 's throat. When the IRCops ask who did it, $me blamed it on OJ Simpson!!
..[&H]acksaw:/me pulls out his Hack Saw and cuts up $$1 into little pieces and feeds them to his dog.
..[&C]hainsaw:/me pulls out his chainsaw and Hacks apart $$1 from limb to limb
..[&L]ightening:/me CAlls to the god of lightening and asks him for help. Later that day $$1 is walking home from the sexual toys store when a lightening bolt comes and knocks down a tree that kills $$1
..[&S]ledge:/me looks around the room and sees $$1  ..... what an asshole!! $me then decides something should be done about it, so he grabs his sledge hammer and then squishes $$1 skull in to applesauce!!!  PUNK!
..[&P]hone:/me is using his phone bug when he hears that $$1 is a telemarketer. $me calls 1-800-FUCK- $$1- UP. An officer is sent over. The officer goes crazy and anally rapes $$1. Then slits $$1's fucking throat!! SHITHEAD!
..[&K]nuckles:/me finds brass knuckles in his pocket. Shit what you goona do with those asks $$1. I am gonna fuck you up!!!! $me runs at $$1 and proceeeds to bash $$1 fucking face in!!   MOTHERFUCKER!
..[&D]ildo:/me sees $$1's mother on the street, she is trying to sell dildos for her church. $me takes them and jams them in any available opening in her body. BITCH!
..[&N]azi:/me sees that $$1 is on NAZI Online. What the FUCK. $me pulls out his beretta and puts a bullet in $$1's fucking head!  RACIST ASSHOLE! 
..[&L]aser:/me has a large and powerful laser in his backpack. While giving his presentation he pulls it out.. $me sees $$1 being an asshole so he points it at $$1's eyes....ahhhhhhhhhhh!! Now all $$1 has are two burned craters for a face.  SUCKA!
..[&B]at:/me grabs the aluminum bat from the house and runs out to practice T-ball.. from $$1's head...whoops!...WHACK!!.. Now $$1's pea-sized brain is all over the field!   RETARDO!
..[&K]ey:/me thinks that $$1 types worth shit. $ME takes his keyboard and smashes it over $$1's fucking head. IDIOT!
..[&F]lashlight:/me is looking around in the dark for something.. $me shines the light on $$1 who is jerking off in the corner with a mag full of animal pics. $me takes his chance while  $$1 is still stunned by the light and crushes $$1 skull in with his Mag-Lite. SICKO!
..[&B]omb:/me plants a mine at the doorway to $$1's house.. when $$1 leaves to go get the new NKOTB album his legs are blown off! POSEUR!
..[&W]eights:/me is lifting weights in the gym when $$1 comes bye and starts acting like an asshole... $me gets up and knocks $$1 on his ass... $me lifts the 400pd weight above his head... THUMP! is the only sound heard as $$1's head is flattened to a pancake!  ASSHOLE!
..[&T]hroat Stick!:/me Shoves a dildo Down $$1 's Throat... Say What U Will Now!
..[&E]ye Poke!:/me Pokes $$1 In The Eye With a finger... Can Ya See Now??
..[&A]ss KICK!:/me Kicks $$1 In The Ass... Leaving His Foot Embedded In His Asshole... Guess U Can Stay... I Need My Foot.
..[&B]rain Swish!:/me Sticks a RED Hot Curling Iron In $1's Ear And Swishes Their Brain Around For awhile... Is It Clear Now??
SET 2 
..Block Attack:me Blocks $$1's Futile And Hopeless Attack ! 
..Kick User:me Moves Back To Do A RoundHouse Kick And Hits $$1 In The $$?="Where Do You Wanna Hit?" ! | me Tries To Control His Power... But What Can You Do ! There's Too Much Of It ! 
..Ball Hit:me Hits $$1 Quickly In The Growings ! | me Watches As $$1 Rolls Around In The Ground ! 
..Glare User:me Glares Sharply At $$1 ! 
..Punch User:me Punches $$1 Sharply In The Nose ! | say You Bleed Like A Pig $$1 ! 
..Punch Where?:me Pulls Back His 5 Kg Fist And Hits $$1 Sharply In The $$?="Where Do You Want To Hit?" ! | say Damn, That Must Have Hurt (Guess U Can't Feel Anything Anymore Though) ! 
..Grenade User:me Takes Out A Grenade ! ...Pulls The Pin ...4 ...3 ...2 ...1 And Tosses It To $$1 ! | say !*#*! KABOW !*#*! Damn... what a BLAST ! 
..Hang User:me Puts A Tight Rope Around $$1 's Neck And Opens The Channel Trapdoor In # ! | say You Are Hung ! HeHe ! $$1 Is A Swinging Pendulum ! 
..Burn User:say GRRRRRR...! | me Opens His Mouth And Blows Fire At $$1 , Burning His $$?="Where Do You Want To Burn?" | say Who Wants Fryed Chicken ? 
..Shoot User:me Blows $$1 Head Away With A Double Barrel Shotgun ! 
..Shoot With?:say Ok, You Are Bugging Me, Time To Get Rough, $$1 ! | me Pulls Out His $$?="What Weapon Will You Use?" And Shoots With It At $$1 To Cause Some MAJOR Damage To His $$?="Where To Cause Damage?" ! | say Oh Man... That Sure Was Effective :) 
..Tail Whip:say MwHaHaHaHaHa ! | me Whips her Monstrous Tail At $$1 To Break their $$?="Where Do You Wanna Hit?" ! | me Shows her 300 Teeth And Then Eats $$1! (Yummy) 
..Sword Hit:say $$1 , Want To Bring This Back In Time ? | me Gets On His Armor And Pulls Out His Version 7.7 °ShowDowN PrO° Executioner Sword ! | say You Asked For It $$1 ! (Here We Go) | me Hits $$1 With The Sword In His $$?="Where Do You Wanna Hit?" ! | say A Big *!CRACK!*  Fills The Air ! 
..Go Back:say I Am Not Being Fair Am I ? | me Turns Back To Mortal... | say Now You have At Least A Little Chance $$1 ! 
SET 3
..Monster:say ArrrgH ! You Are Beating Me $$1 ... | me Falls To The Ground And Starts To Shake ! | me Turns In To A Huge Monster With 300 Teeth And A Large Tail Full Of Horns ! | me Growls And Bites $$1 's Head Off ! | say Ahh That Was Delicious ! ***BURP ! 
..Shit Bag:me Hands $$1 A Flaming Bag Of Shit ! 
..Piss On:me Pisses All Over $$1 ! And Watches Him Melt... 
..Crap On:me Craps All Over $$1 ! | say Damn ! That Is What I Call A ShitPileMan ! 
..Welcome:me Welcomes $$1 To # !  
..Grin Wicked:me Grins At $$1 Wickedly ! 
..Smile:me Smiles Warmly At $$1 ! 
..Problem:me Wonders : $$1 , DO YOU HAVE A PROBLEM ? | say WELL SOLVE IT BUTTMUNCH AND DON'T GO CRYING TO OTHERS ! 
..Turn To Smurf:me Falls To The Ground... Changes To Blue... And Turns Into A GIANT SMURF ! THEN SINGS THE SMURF SONG TO $$1 ALL NIGHT LONG! | say LA LA LA LA LA LA LA LA LA LA LA LA LA ! | say $$1 , You Want An Oncore Performance? ;) ..Cast Spell:me Casts A Magical Spell Of $$?="Whose Spell Will You Cast?" Upon $$1 ! | say $$1 Is Blinded And Paralized Immediately.....Laugh At:me Laughs Uncontrollably At $$1 ! No Offense ! 
..Give Beer:me Hands $$1 A Nice Cold $$?="Enter Brand Of Beer?:" | say You Needed That ;) 
..Send To Hell:me Moves Couple Of Steps Back... And Then Runs Forward Towards $$1 ! | me Kicks $$1 's Ass All The Way To #Hell ! 
..LawnMower:say Ahhh ! It's That Time Again ! | me Takes Out A LawnMower And Starts To Cut Some Gr(ass) ! | say La La La... ThUD ! What Was That ? | me Notices That He Has Given $$1 A Permanent HairCut ! 
..-
BADMOODS
.BADMOODS1
..mood:/me is in a VERY BAD MOOD!!
..tear out:/me would like to tear out $$1's heart and set it on fire so she can watch it slowly burn until it eventually... stops....
..dump:/me grabs a can of $$?="A can of what?" and dumps it on $$1's head. 
..clothes fire:/me pretends to give $$1 a light, then sets $$1's clothes on fire. 
..hot coffee:/me takes a cup of hot coffee and pours it on $$1 . 
..sword:/me takes out a 12 inch long knife and stabs $$1 repeatedly. "Take that! And that!"
..tongue:/me sticks $me's tongue out at $$1
..gouge:/me gouges out $$1's eyes with a fork.
..fingernails:/me thinks talking to $$1 is about as pleasant as shoving a knife under $me's fingernails.
..mountain:/me takes $$1 to the nearest mountain, then pushes $$1 off a cliff.
..rock:/me ties $$1 to a rock and lets the vultures finish $$1 off. 
..shotgun:/me brings out a double shotgun and blows multiple holes in $$1's head. 
..grenade:/me throws a grenade at $$1. | /.timer 1 3 /me watches $$1's face realize that's it's gonna blow up | /.timer 1 3 /me watches $$1 explode as $$1 draws back an arm to throw it
..razorblades:/me jams a pack of sharpened razorblades down $$1's throat so $$1 will shut up!
..voodoo:/me takes out a voodoo doll of $$1 | /.timer 1 5 /me sticks a few pins in its head. 
..tornado:/me watches as an f5 tornado rips from the sky and envelopes $$1, who spins about wildly in the air and lands bruised and broken in a pile of cow manure
.BADMOOD2
..shutthefuck:/me $$1 shut the fuck up before I bust a cap in yo ass
..glass:/me would rather eat shreads of broken glass than talk to $$1.  
..Farley!:/action 2 Hey!!: 4* $$1 *1  !!! Chuck you Farley !!!
..Biteme!:/action 2 HEY !!:4* $$1 *6 {{{{{{{5 Bite Me 6 }}}}}}}.
..Threat1!:/action 4* $$1 * 6 are you threatening me !?!?
..Threat2!:/action 6 are you threatening me;4* $$1 * ?!?!
..Dumbdirt!:/action 4* $$1 * is dumber than5 DIRT !!!
..Shit&Die!:/action 2 HEY !!:4* $$1 *:5 Eat shit and * DIE !!!
..ShutUp!:/action 2 Hey !!:4* $$1 * Shut up or I'll rip your 2 * Arm * off and Beat you with it !!!
..Stuff Ass!:/action 6 Hey !!:4* $$1 * Cool it or I'll rip your2 * Head *  off and Stuff it up your ass !!!
.FOODINSULTS
..milkshake:/me wants to make a milkshake for $$1! | /.timer 1 5 /me takes $$1 into the kitchen and turns on the blender | /.timer 1 4 /msg oops! $$1's hand has somehow fallen in! | /timer 1 5 /me watches cheerfully as $$1's hand is ground to a pulpy mass
..Slap!:/me slaps $$1 around a bit with a slab of jello
..ketchup:/me stuffs some ketchup packets down $$1's throat. "Shut the hell up!"
..lemon:/me mashes a lemon into $$1's eyes. "Lemonade, anyone?"
.INSULTS:
..rec:/say  12*4 $$1 12* 1 is living proof that even a  12 {{{7Rectum12}}}  1has a natural function !!!
..beer:/say 12*4 $$1 12* 1 Put down that 14,14 0,1 Skunky 14,14 1,0  Beer and slowly back away !!!
..wa:/say Hey, 12*4 $$1 12* 1, Your mom is so fat she sat on a quarter and squished a booger out of George Washington's nose.
..autoexe: /me slaps $$1 around a while with my big 4red autoexec.bat!
..razzberry: /me sticks out her tongue at $$1 and blows a huge razzberry!:Þ
..Rectum!:/say 4* $$1 $+  * is living proof that even a 2 {{{7 Rectum2}}} 1 has a natural function !!!
..Roses!:/say HEY 9* $$1 $+ *, Roses are4 red1,6 violets1 are2 blue1... I was made13 beautiful1  what the hell happened to you????
..DogFace!:/say Hey 4* $$1 $+ *, If my dog had a face like yours, I would shave his ass and make him walk backwards.
..Corn Flakes!:/say HEY 4* $$1 $+  *, Yep.  I'd say you're almost as interesting as the corn flakes I had for breakfast this morning.
..She Pays Me!:/say Hey,4* $$1 $+ *, Do me a favor, when you get a chance:  | /say Would you tell your mom that starting tomorrow night, she is going to have to pay me.
..Fat/Booger!:/say Hey,4* $$1 $+ *, Your mom is so fat she sat on a quarter and squished a booger out of George Washington's nose.
..Rectum!:/say 4* $$1 $+  * is living proof that even a 2 {{{5 Rectum2}}} 1 has a natural function !!!
..Slap!:/me slaps 4 $$1 1around a bit with a large trout
..Pokes!:/me pokes 1* $$1 * with a wet noodle; seeing as how it might be allegic to a stinky trout! !
..Faces!:/me thinks4 $1 2,8 is a person of many faces (ê¿ê) *¿* ()¿() {Ö¿Ö} ô¿ô «©¿©» õ¿õ
..Toss Trout!:/me > toss' 1* $$1 *6  a  Rainbow Trout 1  <2*10)3)8)9)2)3)8)9)3)8)1><
..Carp:/me > slaps* $$1 *around with a stinking old smelly carp!!!
..Not there:/me > thinks that5* $$1 * ain't all there today... about three 4 bricks short of a load!!!
..Bap pillow:/me > 4 Baps 12* $$1 * with a soft feather pillow!
..RoadKill!:/me > 2 Whomps 4 * $$1 * 5up side the head with a putrid, dead, smelly, Possum!!!6 "Road-Kill Anyone"!!!
..SlapsTrout:/action Slaps a4 large trout around a bit with4 $$1
..911:/me gives $$1 a lip ripping, tongue snatching, suck the eyeballs right out of the socket, hot flaming, breath-taking, spine tingling, make you weak at the knees, better call 911, to die for KISS!!!!!!!!!
.INSULTS2
..Used condom:/me takes out a used condom and feeds the filling to $$1 
..AOL:/me breaks into $$1's house and screws with  his  PC so he can only get on AOL,  YES ! (America Online)  Right where you belong you fuckin lamer!!!
..Parents:/say $$1: If your parents got divorced, would they still be cousins?
..Lonely:/ame thinks $$1 looks pretty lonely and would like some company | /ame gives $$1 a blow up doll to make their life dream come true....to find someone as smart as them
..Aol 2:/mebreaks intor $$1 house and screws with  his  PC so he can only get on AOL ... | /timer1 1 10 /me still on AOL  $$1 how did you log on | /timer2 1 15 /me laughs watching $$1 connecting | /timer3 1 25 /notice # YO!!! $$1 Just connected to Worldnet and thought it was AOL 10(((FUCKIN LAMER))))))!
..Shotgun:/me Takes out his Shotgun.......and Blows $1's Fuckin Head Off!
..Pistol:/me aims...........Fire's the Glock.....PocK!....One round in the Head 
..Silencer Shoot:/me takes aim from a rooftop above,..... snipe!.......... $1 is killed by a silenced rifle! "Got that Tango Fucker!"
..Foul language:/me decides to do something about $$1 's dirty mouth so he pulls out fork and stabs $$1 's tongue.
..12 Storey Building:/me hangs $$1 off a 12 storey building by $$1 's one inch dick
..Schlong:/me whips out her 2 Foot Schlong and presses it against $$1 $+ 's chin 
..Horny:/me thinks that $$1 is way to horney to be in # !! $me hates horney losers who probably suck their own genitals !! 
..OJ:/me puts on his Ski mask and stalks $$1 for a while. One day $me sees $$1 walking with somone he doesn't like. $me becomes extremely jealous and slices $$1 $+ 's throat. When the IRCops ask who did it, $me blamed it on OJ Simpson!!
..E.coli:/me offers $$1 a nice juicy hamburger with extra E.COLI  
.Lots of fun
..NoVictim
...Bow:/me bows deeply.
...Sage:/me nods sagely, trying to look wise.
...Mgrin:/me grins mischievously.
...Egrin:/me grins evilly.
...Mosh:/me moshes around the channel and slams you into the wall.
...Rofl:/me falls on the ground, laughing hysterically.
...Solo:/me does an excellent air mandolin solo!
...Moon:/me shows her shiney-hiney to everyone.
...Swear:/me swears blasphemously! 
...Bcry:/me emits a heinously fierce battle cry, causing your blood to race!
...Bspit:/me spits blood on the ground.
...Scowl:/me scowls in an outraged manner.
...Froth:/me froths at the mouth.
...Twiddle:/me twiddles her thumbs.
...Panic:/me panics and looks for a place to hide.
...FTW:/me screams "Fuck The World!!"
...Excellent:/me drums her fingers together and says: Excellent.
...Beer:/me tosses you a bottle of beer...you think she wants something.
..NeedVictim
...High5:/me slams a thunderous high5 with $$1.
...Worship:/me falls to her knees and shows how much she worships $$1.
...Bearhug:/me gives $$1 an overly affectionate bearhug. | /me apologizes for any broken bones.
...groins:/me slams her knee into $$1's groin.
...nuts:/me kicks $$1 in da nuts 
...Whap:/me grabs her elephant by the trunk, swings it madly around, and whaps $$1 in the head. >>THUMP!!<< What a hit!
...FFinger:/me implies with her middle finger that he wants $$1 to fuck off.
...Hbutt:/me gives $$1 an enthusiastic headbutt. They both seem a little dizzy.
...Predator:/me glares at $$1 evilly.. | .timer 1 3  /me reaches into her trenchcoat and pulls out her Ares Predator. | .timer 1 5 /me aims it at $$1's head and pulls the trigger. *BLAM* | .timer 1 6 /me laughs evilly as blood and grey matter fly from the gaping hole in $$1's head.
...Katana:/me slowly draws his katana, while staring at $$1. | .timer 1 3 /me suddenly slashes out at at $$1, laughing evilly as blood and organs flow from the gaping wound.
...Axe:/me slowly opens her black leather longcoat and chooses her weapon. | .timer 1 3 /me draws a gleaming throwing axe and raises it to the sky. | .timer 1 5 /me hurls the axe across the room, Firmly implanting it in $$1's forehead.
...H&K:/me draws his Heckler and Koch hidden in his concealable holster. | .timer 1 2 /me points the gun at $$1's head and grins as a red targeting laser appears between his eyes. | .timer 1 4 /me squeezes the trigger and watches $$1's head explode in a crimson cloud.
...Staff:/me draws a quarterstaff hidden in his robes. | .timer 1 3 /me grins maliciously as he looks into $$1's eyes. | .timer 1 5 /me brings the staff to bear upon $$1's head. | .timer 1 6 /me laughs as a thin trickle of blood streams from $$1's ear.
...Manabolt:/me grins evilly as spell energy intwines around his fingers. | .timer 1 3 /me laughs as her eyes glow red and the power builds around her. | .timer 1 5 /me launches a bolt of energy into $$1 and watches as it rips $$1's body to bloody shreds.
...Conjure:/me holds her hands to the sky and dances in arcane patterns.  Then she speaks a phrase. | .timer 1 3 /say chlictu genactu betalia! | .timer 1 4 /me laughs demonically as a black hooded figure wielding a massive scythe materializes next to $$1. | .timer 1 5 /me watches his creation bring the scythe down again and again, bringing $$1 to his ultimate doom.
...Zap!:/me holds her hands to the sky and asks the Gods for assistance. | .timer 1 3 /me begins to moan as black stormclouds envelop the channel and red bolts of lightning are channeled into his body. | .timer 1 5 /me sends the lightning flying from his hands and ripping into $$1's body, blackening him. | .timer 1 7 /say Ah.  The smell of burnt flesh.
...Shock:/me pulls out the emergency first aid kit and says 9ONE  TWO THREE.... CLEAR!!!9 and 4 ZAPS4 $$1 in the chest with a  million volts using the shock paddles :)
}
-
Dcc Serv:/.fserve $$1 1 $shortfn($$sdir(\,-- Select a dir to share with $$1 ))
