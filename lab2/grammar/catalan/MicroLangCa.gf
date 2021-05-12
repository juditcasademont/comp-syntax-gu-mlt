--# -path=.:../abstract
concrete MicroLangCa of MicroLang = open MicroResCa in {


-----------------------------------------------------
---------------- Grammar part -----------------------
-----------------------------------------------------

lincat

  -----simple-----
  Utt = {s : Str} ;
  S  = {s : Str} ;
  V = Verb ;
  V2 = Verb2 ;
  A = Adjective ;
  N = Noun ;
  Adv = {s : Str} ;
  Comp = Adjective ;
  AP = Adjective ;
  CN = Noun ;
  Prep = {s : Str} ;

  -----complex-----
  Det = {s: Gender => Str ; n : Number } ;
  Pron = {s : Case => Str ; g : Gender ; n: Number } ;
  NP = {s : Case => Str ; g : Gender ; n : Number } ;
  VP = {v : Verb ; compl : Number => Gender => Str} ;

lin

  -----simple-----
  UttS s = s ;
  UsePron p = p ;
  UseN noun = noun ;
  PositA a = a ;
  CompAP ap = ap ;

  -----complex-----

-----determiners-----
  ----el, la, l', els, les
  thePl_Det = {s = table { Masc => "els" ; Fem => "les" } ; n = Pl };
  the_Det = {s = table { Masc => pre { "a"|"e"|"i"|"o"|"u" => "l'"; _ => "el" } ;
                         Fem => pre { "a"|"e"|"o" => "l'"; _ => "la" } } ;
                         n = Sg };

  ----un, una, uns, unes
  a_Det = {s = table { Masc => "un" ; Fem => "una" } ; n = Sg };
  aPl_Det = {s = table { Masc => "uns" ; Fem => "unes" } ; n = Pl };

-----prepositions-----
  --PrepNP prep np = {s = prep.s ++ np.s ! Acc} ;

  in_Prep = {s = "a"} ;
  on_Prep = {s = "en"} ;
  with_Prep = {s = "amb"} ;

-----pronouns-----
  he_Pron = {
    s = table {Nom => "ell" ; Acc => "el"} ;
    n = Sg ;
    pers = P3 ;
    g = Masc ;
    } ;

  she_Pron = {
    s = table {Nom => "ella" ; Acc => "la"} ;
    n = Sg ;
    pers = P3 ;
    g = Fem ;
    } ;

  they_Pron = {
    s = table {Nom => "ells" ; Acc => "els"} ;
    n = Pl ;
    pers = P3 ;
    g = Masc | Fem ; ---WRONGGGGGGGGGGGGGGGGGGG
    } ;

-----------------------------------------------------
---------------- Lexicon part -----------------------
-----------------------------------------------------

lin already_Adv = mkAdv "ja" ;
lin animal_N = mkNBasic "animal" Masc ;
lin apple_N = mkNFemA "poma" Fem ;
lin baby_N = mkNBasic "bebè" Masc ;
lin bad_A = mkABasic "dolent" ;
lin beer_N = mkNFemA "cervesa" Fem ;
lin big_A = mkASame "gran" ;
lin bike_N = mkNFemA "bicicleta" Fem ;
lin bird_N = mkNBasic "ocell" Masc ;
lin black_A = mkAAtoE "negre" ;
lin blood_N = mkNBasic "sang" Fem ;
lin blue_A = mkAVa "blau" ;
lin boat_N = mkNQues "barca" Fem ;
lin book_N = mkNBasic "llibre" Masc ;
lin boy_N = mkNBasic "nen" Masc ;
lin bread_N = mkNVi "pa" Masc ;
lin break_V2 = mkV1CarV2 "trencar" ;
lin buy_V2 = mkV1BasicV2 "comprar" ;
lin car_N = mkNBasic "cotxe" Masc ;
lin cat_N = mkNBasic "gat" Masc ;
lin child_N = mkNBasic "infant" Masc ;
lin city_N = mkNBasic "ciutat" Fem ;
lin clean_A = mkABasic "net" ;
lin clever_A = mkASta "llest" ;
lin cloud_N = mkNBasic "núvol" Masc ;
lin cold_A = mkABasic "fred" ;
lin come_V = mkV "venir" "vinc" "véns" "ve" "venim" "veniu" "vénen" ;
lin computer_N = mkNBasic "ordinador" Masc ;
lin cow_N = mkNQues "vaca" Fem ;
lin dirty_A = mkABasic "brut" ;
lin dog_N = mkNSs "gos" Masc ;
lin drink_V2 = mkV2 "beure" "bec" "beus" "beu" "bevem" "beveu" "beuen" ;
lin eat_V2 = mkV1JarV2 "menjar" ;
lin find_V2 = mkV1BasicV2 "trobar" ;
lin fire_N = mkNBasic "foc" Masc ;
lin fish_N = mkNIx "peix" Masc ;
lin flower_N = mkNBasic "flor" Fem ;
lin friend_N = mkNBasic "amic" Masc ;
lin girl_N = mkNFemA "nena" Fem ;
lin good_A = mkABo "bo" ;
lin go_V = mkV "anar" "vaig" "vas" "va" "aneu" "anem" "van" ;
lin grammar_N = mkNQues "gramàtica" Fem ;
lin green_A = mkABasic "verd" ;
lin heavy_A = mkAAda "pesat" ;
lin horse_N = mkNBasic "cavall" Masc ;
lin hot_A = mkABasic "calent" ;
lin house_N = mkNFemA "casa" Fem ;
-- lin john_PN = mkPN "John" ;
lin jump_V = mkV1BasicV "saltar" ;
lin kill_V2 = mkV1BasicV2 "matar" ;
-- lin know_VS = mkVS "saber" ;
lin language_N = mkNFemA "idioma" Masc ;
lin live_V = mkV "viure" "visc" "vius" "viu" "vivim" "viviu" "viuen" ;
lin love_V2 = mkV1BasicV2 "estimar" ;
lin man_N = mkNBasic "home" Masc ;
lin milk_N = mkNBasic "llet" Masc ;
lin music_N = mkNQues "música" Fem ;
lin new_A = mkAVa "nou" ;
lin now_Adv = mkAdv "ara" ;
lin old_A = mkABasic "vell" ;
-- lin paris_PN = mkPN "Paris" ;
lin play_V = mkV1GarV1 "jugar" ;
lin read_V2 = mkV2 "llegir" "llegeixo" "llegeixes" "llegeix" "llegim" "llegiu" "llegeixen" ;
lin ready_A = mkASta "llest" ;
lin red_A = mkABasic "vermell" ;
lin river_N = mkNBasic "riu" Masc ;
lin run_V = mkV "córrer" "corro" "corres" "corre" "correm" "correu" "corren" ;
lin sea_N = mkNBasic "mar" Masc ; --same word can also be Fem but well
lin see_V2 = mkV2 "veure" "veig" "veus" "veu" "veiem" "veieu" "veuen" ;
lin ship_N = mkNBasic "vaixell" Masc ;
lin sleep_V = mkV "dormir" "dormo" "dorms" "dorm" "dormim" "dormiu" "dormen" ;
lin small_A = mkABasic "petit" ;
lin star_N = mkNFemA "estrella" Fem ;
lin swim_V = mkV1BasicV "nedar" ;
lin teach_V2 = mkV1BasicV2 "ensenyar" ;
lin train_N = mkNBasic "tren" Masc ;
lin travel_V = mkV1JarV2 "viatjar" ;
lin tree_N = mkNBasic "arbre" Masc ;
lin understand_V2 = mkV2 "entendre" "entenc" "entens" "entén" "entenem" "enteneu" "entenen" ;
lin wait_V2 = mkV1BasicV2 "esperar" ;
lin walk_V = mkV1BasicV "caminar" ;
lin warm_A = mkABasic "calent" ;
lin water_N = mkN "aigua" "aigües" Fem;
lin white_A = mkANca "blanc" ;
lin wine_N = mkNVi "vi" Masc ;
lin woman_N = mkNFemA "dona" Fem ;
lin yellow_A = mkAOc "groc" ;
lin young_A = mkASame "jove" ;


}
