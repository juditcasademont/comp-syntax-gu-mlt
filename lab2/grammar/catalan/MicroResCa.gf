resource MicroResCa = {

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  Person = P1 | P2 | P3 ;
  Case = Nom | Acc ;
  NAgreement = NAgr Gender Number ;
  VForm = VInf | VPresInd Person Number; 

oper

-------NOUNS-------

  Noun : Type = {s : Number => Str ; g : Gender} ;

  mkN : Str -> Str -> Gender -> Noun = \sg,pl,ge -> {
    s = table {Sg => sg; Pl => pl};
    g = ge ;
    };

  --- most common: add "s" to singular
  mkNBasic : Str -> Gender -> Noun = \sg,ge -> case sg of {
    _ + ("l"|"è"|"i"|"g"|"e"|"n"|"t"|"c"|"r"|"u") => mkN sg (sg + "s") ge
  } ;

  --- (usually feminine) nouns ending with "a" transform "a" to "e" and add "s"
  mkNFemA : Str -> Gender -> Noun = \sg,ge -> case sg of {
    x + "a" => mkN sg (x + "es") ge
  } ;

  --- (usually feminine) nouns ending with "ca" transform "c" to "qu" when the letter after is e
  mkNQues : Str -> Gender -> Noun = \sg,ge -> case sg of {
    x + "ca" => mkN sg (x + "ques") ge
  } ;

  --- some very short words add an "n" before making the plural normally
  mkNVi : Str -> Gender -> Noun = \sg,ge -> case sg of {
    ("pa" | "vi") => mkN sg (sg + "ns") ge
  } ;

  --- words ending with "s" double the "s" and add "o" before forming plural normally (avoids ending words with "ss")
  mkNSs : Str -> Gender -> Noun = \sg,ge -> case sg of {
    _ + "s" => mkN sg (sg + "sos") ge
  } ;

  --- similar to mkNSs but with x and no doubling
  mkNIx : Str -> Gender -> Noun = \sg,ge -> case sg of {
    _ + "x" => mkN sg (sg + "os") ge
  } ;

-------ADJECTIVES-------

  Adjective = {s : NAgreement => Str} ;

  mkA : Str -> Str -> Str -> Str -> Adjective = \ms,fs,mp,fp -> {
    s = table { NAgr Masc Sg => ms ;
                NAgr Fem Sg => fs ;
                NAgr Masc Pl => mp ;
                NAgr Fem Pl => fp} ;
    } ;

  --- most common: "a" "s" "es" formation
  mkABasic : Str -> Adjective = \ms -> case ms of {
     _ + ("et"|"it"|"ut"|"nt"|"d"|"l") => mkA ms (ms + "a") (ms + "s") (ms + "es")
  } ;

  --- same form for masculin and feminine
  mkASame : Str -> Adjective = \ms -> case ms of {
     _ + ("an"|"ve") => mkA ms ms (ms + "s") (ms + "s")
  } ;

  --- masculin adjs ending with "e" transform to "a"
  mkAAtoE : Str -> Adjective = \ms -> case ms of {
     x + "e" => mkA ms (x + "a") (ms + "s") (ms + "s")
  } ;

  --- letter "u" transforms to "v" 
  mkAVa : Str -> Adjective = \ms -> case ms of {
     x + "u" => mkA ms (x + "va") (ms + "s") (x + "ves")
  } ;

  --- masculin adjs ending "st" add "o" to masc pl form to avoid "sts" (too many consonants)
  mkASta : Str -> Adjective = \ms -> case ms of {
     _ + "st" => mkA ms (ms + "a") (ms + "os") (ms + "es")
  } ;

  --- short adjs sometimes add "n" to plural
  mkABo : Str -> Adjective = \ms -> case ms of {
     _ + "o" => mkA ms (ms + "na") (ms + "ns") (ms + "nes")
  } ;

  --- transforming "t" to "d"
  mkAAda : Str -> Adjective = \ms -> case ms of {
     x + "at" => mkA ms (x + "ada") (ms + "s") (x + "ades")
  } ;

  --- (similar to noun version) "c" becomes "qu" when the letter after is "e"
  mkANca : Str -> Adjective = \ms -> case ms of {
     x + "nc" => mkA ms (ms + "a") (ms + "s") (x + "nques")
  } ;

  --- c sometimes transforms to g I guess
  mkAOc : Str -> Adjective = \ms -> case ms of {
     x + "oc" => mkA ms (x + "oga") (ms + "s") (x + "ogues")
  } ;

-------VERBS-------

  --- transitive verbs
  Verb2 = {s : VForm => Str} ;
  --Verb2 : Type = Verb ** {c : Str} ;

  --- intransitive verbs
  Verb = {s : VForm => Str} ;

  mkV2 : (inf,p1s,p2s,p3s,p1p,p2p,p3p : Str) -> Verb2
    = \inf,p1s,p2s,p3s,p1p,p2p,p3p -> {
    s = table {
      VInf => inf ;
      VPresInd P1 Sg => p1s ;
      VPresInd P2 Sg => p2s ;
      VPresInd P3 Sg => p3s ;
      VPresInd P1 Pl => p1p ;
      VPresInd P2 Pl => p2p ;
      VPresInd P3 Pl => p3p
      } ;
    --c = []
    } ;

  mkV : (inf,p1s,p2s,p3s,p1p,p2p,p3p : Str) -> Verb
    = \inf,p1s,p2s,p3s,p1p,p2p,p3p -> {
    s = table {
      VInf => inf ;
      VPresInd P1 Sg => p1s ;
      VPresInd P2 Sg => p2s ;
      VPresInd P3 Sg => p3s ;
      VPresInd P1 Pl => p1p ;
      VPresInd P2 Pl => p2p ;
      VPresInd P3 Pl => p3p
      } ;
    } ;
  
  --- 1st conjugation (transitive)
  mkV1BasicV2 : Str -> Verb2 = \inf -> case inf of {
    cant + "ar" =>  mkV2 inf (cant + "o") (cant + "es") (cant + "a") (cant + "em") (cant + "eu") (cant + "en")
  } ;

  --- 1st conjugation (intransitive)
  mkV1BasicV : Str -> Verb = \inf -> case inf of {
    cant + "ar" =>  mkV inf (cant + "o") (cant + "es") (cant + "a") (cant + "em") (cant + "eu") (cant + "en")
  } ;

  --- 1st conjugation with "c" -> "qu" transformation
  mkV1CarV2 : Str -> Verb2 = \inf -> case inf of {
    tren + "car" => mkV2 inf (tren + "co") (tren + "ques") (tren + "ca") (tren + "quem") (tren + "queu") (tren + "quen")
  } ;

  --- 1st conjugation with "j" -> "g" transformation
  mkV1JarV2 : Str -> Verb2 = \inf -> case inf of {
    men + "jar" =>  mkV2 inf (men + "jo") (men + "ges") (men + "ja") (men + "gem") (men + "geu") (men + "gen")
  } ;

  --- 1st conjugation with "g" -> "gu" transformation
  mkV1GarV1 : Str -> Verb = \inf -> case inf of {
    ju + "gar" => mkV inf (ju + "go") (ju + "gues") (ju + "ga") (ju + "guem") (ju + "gueu") (ju + "guen")
  } ;

  be_Verb : Verb = mkV "ser" "sóc" "ets" "és" "som" "sou" "son" ; 


  -------ADVERBS-------
  Adv : Type = {s : Str} ;

  mkAdv : Str -> Adv
    = \s -> lin Adv {s = s} ;


-------PREPOSITIONS-------
  Prep : Type = {s : Str} ;

  mkPrep : Str -> Prep
    = \s -> lin Prep {s = s} ;



}