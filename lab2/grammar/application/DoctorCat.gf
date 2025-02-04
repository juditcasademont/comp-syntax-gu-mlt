----- export GF_LIB_PATH=/home/guscasaju@GU.GU.SE/gf-lib/Users/aarne/.cabal/share/x86_64-osx-ghc-8.4.3/gf-3.10.4/lib

concrete DoctorCat of Doctor =
  open
    SyntaxCat,
    ParadigmsCat,
    Prelude
  in {

-- application using standard RGL

lincat
  Phrase = Utt ;
  Fact = Cl ;
  Action = VP ;
  Property = VP ;
  Profession = CN ;
  Person = NP ;
  Place = {at,to : Adv} ;
  Substance = NP ;
  Illness = NP ;

lin
  presPosPhrase fact = mkUtt (mkS fact) ;
  presNegPhrase fact = mkUtt (mkS negativePol fact) ;
  pastPosPhrase fact = mkUtt (mkS anteriorAnt fact) ;
  pastNegPhrase fact = mkUtt (mkS anteriorAnt negativePol fact) ;
  presQuestionPhrase fact = mkUtt (mkQS (mkQCl fact)) ;
  pastQuestionPhrase fact = mkUtt (mkQS anteriorAnt (mkQCl fact)) ;

  impPosPhrase action = mkUtt (mkImp action) ;
  impNegPhrase action = mkUtt negativePol (mkImp action) ; --no a l'escola vagis -> wrong order

  actionFact person action = mkCl person action ;
  propertyFact person property = mkCl person property ;

  isProfessionProperty profession = mkVP (mkNP profession) ;
  needProfessionProperty profession = mkVP need_V2 (mkNP a_Det profession) ;
  isAtPlaceProperty place = mkVP place.at ; --currently: verb estar, should be verb ser
  haveIllnessProperty illness = mkVP have_V2 illness ;

  theProfessionPerson profession = mkNP the_Det profession ;

  iMascPerson = i_NP ;
  iFemPerson = i_NP ;
  youMascPerson = you_NP ;
  youFemPerson = you_NP ;
  hePerson = he_NP ;
  shePerson = she_NP ;

  goToAction place = mkVP (mkVP go_V) place.to ;
  stayAtAction place = mkVP (mkVP stay_V) place.at ;
  vaccinateAction person = mkVP vaccinate_V2 person ;
  examineAction person = mkVP examine_V2 person ;
  takeSubstanceAction substance = mkVP take_V2 substance ;

-- end of what could be a functor
--------------------------------

  -- coughAction = mkVP (mkV "tossir" "tusso") ; --wrong conjugation in imperative
  coughAction = mkVP (mkV2 (mkV "tenir" "tinc")) (mkNP (mkN "tos")); --solution to the wrong conjugation above, "tenir tos" == "tossir"
  breatheAction = mkVP (mkV "respirar") ;
  vomitAction = mkVP (mkV "vomitar") ;
  sleepAction = mkVP (mkV "dormir") ;
  -- undressAction = mkVP take_V2 (mkNP theSg_Det (mkN "roba")) ;
  -- dressAction = mkVP put_V2 (mkNP theSg_Det (mkN "roba")) ;
  undressAction = mkVP (reflV (mkV "desvestir" "desvesteixo")) ;
  dressAction = mkVP (reflV (mkV "vestir" "vesteixo")) ; --refl doesn't work in imperative "vesteix &+ et" should be "vesteix-te"
  eatAction = mkVP (mkV "menjar") ;
  drinkAction = mkVP (mkV "beure") ;
  smokeAction = mkVP (mkV "fumar") ;
  measureTemperatureAction = mkVP (mkV2 (mkV "medir" "medeixo")) (mkNP the_Det (mkCN (mkA "corporal") (mkN "temperatura" feminine))) ;
  measureBloodPressureAction = mkVP (mkV2 (mkV "medir" "medeixo")) (mkNP the_Det (mkCN (mkA "arterial") (mkN "pressió" feminine))) ;

  hospitalPlace = {at = pAdv "a l'hospital" ; to = pAdv "a l'hospital"} ;
  homePlace = {at = pAdv "a casa" ; to = pAdv "a casa"} ;
  schoolPlace = {at = pAdv "a l'escola" ; to = pAdv "a l'escola"} ;
  workPlace = {at = pAdv "a la feina" ; to = pAdv "a la feina"} ;

  doctorProfession = mkCN (mkN "metge") ;
  nurseProfession = mkCN (mkN "infermera") ;
  interpreterProfession = mkCN (mkN "intèrpret") ;

  --bePregnantProperty = mkVP (mkA "embarassat") ;
  --beIllProperty = mkVP (mkA "malalt") ;
  --beWellProperty = mkVP (mkA "bé" "bé" "bé" "bé" "benament") ;
  --beDeadProperty = mkVP (mkA "mort") ;
  bePregnantProperty = mkVP (mkAP (mkA (mkA "embarassat") estarCopula)) ;
  beIllProperty = mkVP (mkAP (mkA (mkA "malalt") estarCopula)) ;
  beWellProperty = mkVP (mkAP (mkA (mkA "bé" "bé" "bé" "bé" "benament") estarCopula)) ;
  beDeadProperty = mkVP (mkAP (mkA (mkA "mort") estarCopula)) ;
  haveAllergiesProperty = mkVP have_V2 (mkNP aPl_Det (mkN "al·lèrgia")) ;
  havePainsProperty = mkVP have_V2 (mkNP aPl_Det (mkN "dolor")) ;
  haveChildrenProperty = mkVP have_V2 (mkNP aPl_Det (mkN "fill")) ;

  feverIllness = mkNP (mkN "febre") ; --no a_Det
  fluIllness = mkNP the_Det (mkN "grip" feminine) ;
  headacheIllness = mkNP (compN (mkN "mal") "de cap") ;
  diarrheaIllness = mkNP (mkN "diarrea") ;
  heartDiseaseIllness = mkNP a_Det (mkN "malaltia cardíaca" feminine) ;
  lungDiseaseIllness = mkNP a_Det (mkN "malaltia pulmonar" feminine) ;
  hypertensionIllness = mkNP (mkN "hipertensió") ;

  alcoholSubstance = mkNP (mkN "alcohol") ;
  medicineSubstance = mkNP a_Det (mkN "medicament") ;
  drugsSubstance = mkNP aPl_Det (mkN "droga") ;

oper
  pAdv : Str -> Adv = ParadigmsCat.mkAdv ;

  go_V = mkV "anar" "vaig" ;
  --stay_V = mkV "quedar" ; -- has to be reflexive 
  stay_V = reflV (mkV "quedar") ;
  need_V2 = mkV2 (mkV "necessitar") ;
  take_V2 = mkV2 (mkV "prendre" "prenc" ) ; --participle error: "prengut" should be "pres"
  put_V2 = mkV2 (mkV "posar") ;
  vaccinate_V2 = mkV2 (mkV "vacunar") ; --could also be reflexive
  examine_V2 = mkV2 (mkV "examinar") ;
  ser_V = mkV "ser" "sóc";
  }

-----KNOWN ISSUES-----
--(Thought to be caused by issues occurring in RGL)

--1.--
--When creating reflexive pronouns in the imperative, instead of e.g. the correct form “vesteix-te”
--(‘put clothes on’) we get “vesteix &+ et”. The pronoun “et” in this position should be flipped to “te”.

--2.--
--There is an order error in the negative imperative sentences. Instead of e.g. the correct form
--“no vagis a casa” (‘do not go home’) we get “no a casa vagis” (‘do not home go’). The verb
--should be positioned right after the negation and not at the end of the sentence.

--3.--
--The definite articles “el” and “la” become “l’ “ when accompanying a word that starts with a vowel or h.
--However, here we are able to build “l’metge” which is ungrammatical.

--4.--
--When making the present perfect form (pretèrit d’indicatiu) the wrong auxiliary verb is used. So instead
--of the auxiliary verb “haver”, the present perfect tense is built with the verb “estar”, producing
--ungrammatical sentences such as “ella no està estat malalta”, which should be “ella no ha estat malalta”.
--This might be due to the fact that the Catalan grammar seems to be built from a general Romance grammar,
--which might use the French model of être and avoir.
