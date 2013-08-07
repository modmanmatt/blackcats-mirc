var %text, %i, %outtext
on *:input:*:{
  %text = $null

  if ($1- == z) { haltdef | %text = Zzzz.. Sleeping }
  if ($1- == o) { haltdef | %text = Oh! }
  if ($1- == g) { haltdef | %text = Great! }
  if ($1- == c) { haltdef | %text = Cool! }
  if ($1- == h8) { haltdef | %text = Hi M8, Good To See You! }
  if ($1- == 1m) { haltdef | %text = Wait One Moment please.. }
  if ($1- == l8r) { haltdef | %text = See You Later.. }
  if ($1- == haha) { haltdef | %text = Hahahaha.. This Is Very Funny! }
  if ($1- == afaik) { haltdef | %text = As Far As I Know }
  if ($1- == asap) { haltdef | %text = As Soon As Possible }
  if ($1- == b) { haltdef | %text = Back }
  if ($1- == biab) { haltdef | %text = Back In A Bit }
  if ($1- == bbl) { haltdef | %text = Be Back Later }
  if ($1- == bbs) { haltdef | %text = Be Back Soon }
  if ($1- == bal) { haltdef | %text = Break A Leg }
  if ($1- == brb) { haltdef | %text = Be Right Back }
  if ($1- == btw) { haltdef | %text = By The Way }
  if ($1- == bye) { haltdef | %text = Bye Bye }
  if ($1- == ciao) { haltdef | %text = Ciao }
  if ($1- == h) { haltdef | %text = Hello }
  if ($1- == nb) { haltdef | %text = Not Bad! }
  if ($1- == w) { haltdef | %text = Wow! }
  if ($1- == ww) { haltdef | %text = Wow! Wee }
  if ($1- == sy) { haltdef | %text = See Ya! }
  if ($1- == neo4) { haltdef | %text = Neo4 Playstation II Chip }
  if ($1- == neo2) { haltdef | %text = Neo2 Playstation II Chip }
  if ($1- == ar) { haltdef | %text = Action Replay }
  if ($1- == gs) { haltdef | %text = Game Shark }
  if ($1- == syl) { haltdef | %text = See You Later }
  if ($1- == yup) { haltdef | %text = Yup, That's Right! }
  if ($1- == damn) { haltdef | %text = Damn }
  if ($1- == diky) { haltdef | %text = Do I Know You ? }
  if ($1- == doh) { haltdef | %text = DOH ! }
  if ($1- == fol) { haltdef | %text = Farts Out Loud }
  if ($1- == hmmm) { haltdef | %text = Hmmm }
  if ($1- == ois) { haltdef | %text = Oh I See }
  if ($1- == fyi) { haltdef | %text = For Your Information }
  if ($1- == sing) { haltdef | %text = Anyone Like To Sing A Song?? }
  if ($1- == ga) { haltdef | %text = Good Afternoon }
  if ($1- == gb) { haltdef | %text = Goodbye - Ciao - Adios - Tot Ziens - Farvel - Auf Wiedersehn - Au Revoir }
  if ($1- == gmab) { haltdef | %text = Give Me A Break }
  if ($1- == psx) { haltdef | %text = Playstation }
  if ($1- == ps1) { haltdef | %text = Playstation 1 }
  if ($1- == ps2) { haltdef | %text = Playstation II }
  if ($1- == pc) { haltdef | %text = Personal Computer }
  if ($1- == vcd) { haltdef | %text = Video CD }
  if ($1- == svcd) { haltdef | %text = Super Video CD }
  if ($1- == pal) { haltdef | %text = Phase Alternative Line }
  if ($1- == ntsc) { haltdef | %text = National Television Systems Committee }
  if ($1- == ge) { haltdef | %text = Good Evening }
  if ($1- == gm) { haltdef | %text = Good Morning }
  if ($1- == gmta) { haltdef | %text = Great Minds Think Alike }
  if ($1- == gn) { haltdef | %text = Good Night }
  if ($1- == gr) { haltdef | %text = Gotta Reboot }
  if ($1- == gtg) { haltdef | %text = Got To Go }
  if ($1- == goh) { haltdef | %text = Get Outta Here ! }
  if ($1- == jk) { haltdef | %text = Just Kidding }
  if ($1- == hey) { haltdef | %text = Hey }
  if ($1- == hi) { haltdef | %text = Hi }
  if ($1- == hand) { haltdef | %text = Have A Nice Day }
  if ($1- == ho) { haltdef | %text = Hold On }
  if ($1- == idk) { haltdef | %text = I Don't Know }
  if ($1- == lael) { haltdef | %text = Laughs An Evil Laugh }
  if ($1- == lthtt) { haltdef | %text = Laughing To Hard To Type }
  if ($1- == lol) { haltdef | %text = Laughs Out Loud }
  if ($1- == help) { haltdef | %text = Help.. Can Some One Help Me Please? }
  if ($1- == tsz) { haltdef | %text = The Sharing Zone }
  if ($1- == lofl) { haltdef | %text = Laughs Out Freakin Loud }
  if ($1- == lmao) { haltdef | %text = Laugh My Ass Off }
  if ($1- == lmno) { haltdef | %text = Laughing My Nutz Off }
  if ($1- == ok) { haltdef | %text = Okay ! }
  if ($1- == k) { haltdef | %text = Okay }
  if ($1- == ltns) { haltdef | %text = Long Time No Seen }
  if ($1- == lawl) { haltdef | %text = Laughs A Wicked Laugh }
  if ($1- == myob) { haltdef | %text = Mind Your Own Business }
  if ($1- == nada) { haltdef | %text = Nada - Nothing - De Rien - Niks - Ingenting - Di Niente }
  if ($1- == nice) { haltdef | %text = Nice }
  if ($1- == nm) { haltdef | %text = Never Mind }
  if ($1- == nmp) { haltdef | %text = Not My Problem }
  if ($1- == np) { haltdef | %text = No Problem m8 }
  if ($1- == plz) { haltdef | %text = Pretty Please With Sugar On Top ! }
  if ($1- == ptmy) { haltdef | %text = Pleased To Meet You }
  if ($1- == prob) { haltdef | %text = Probably }
  if ($1- == rotfl) { haltdef | %text = Rolling On The Floor Laughing }
  if ($1- == stm8) { haltdef | %text = Sleep Tight m8 }
  if ($1- == st) { haltdef | %text = Sleep Tight }
  if ($1- == wu) { haltdef | %text = What's Up ? }
  if ($1- == tal) { haltdef | %text = Thanks A Lot }  
  if ($1- == thx) { haltdef | %text = Thanks }  
  if ($1- == tmi) { haltdef | %text = Too Much Information }
  if ($1- == ttyl) { haltdef | %text = Talk To You Later }
  if ($1- == ty) { haltdef | %text = Thank You }  
  if ($1- == tyvm) { haltdef | %text = Thank You Very Much }
  if ($1- == wb) { haltdef | %text = Welcome Back m8 }
  if ($1- == high) { haltdef | %text = High! }
  if ($1- == wtg) { haltdef | %text = Way To Go }
  if ($1- == yeah) { haltdef | %text = Yeah }
  if ($1- == yw) { haltdef | %text = Your Welcome }
  if ($1- == hip) { haltdef | %text = Hip Hip Hourra }
  if ($1- == lmto) { haltdef | %text = Laugh My Tits Off }
  if ($1- == dc) { haltdef | %text = Dont Care }
  if ($1- == u2) { haltdef | %text = Love you To }
  if ($1- == burp) { haltdef | %text = Buuurp! Ooops Sorry Guys :))) }
  if ($1- == sg) { haltdef | %text = Sounds Great M8! }
  if ($1- == lg) { haltdef | %text = L@@ks good :)) }
  if ($1- == nym) { haltdef | %text = Never You Mind ;) }
  if ($1- == look) { haltdef | %text = löÖk }



  if (%text != $null) {
    %i = 1
    %outtext = $null
    while (%i <= $numtok(%text,32)) {
      %temp = $gettok(%text,%i,32)
      %outtext = %outtext  $+ $ADI $+ $left(%temp,1) $+  $+ $ADT $+ $right(%temp,$calc($len(%temp)-1))
      %i = %i + 1
    }
    say %outtext
    unset %temp
  }
  unset %text
  unset %outtext
  unset %i

  if ($1- == hh ) { say 8h12e9h4e | halt }
  if ($1- == lcl ) { say 4L12a8u9g8h13s 9C4o12l3o13u11r6e7d 8L9o11u4d | halt }
  if ($1- == muh ) { say 4M12u8h9a8h13a9h12a8h9a7h13a | halt }
  if ($1- == version ) { echo -a 5,1|1,5|4,5|5,4|7,4|4,7|8,7|7,8|0,8|8,0|4,0 %tpauser ShareScript $logo ©Snake & Zit TpA Crew 2001-2002 8,0|0,8|7,8|8,7|4,7|7,4|5,4|4,5|1,5|5,1|9,1 | halt }
}


}
