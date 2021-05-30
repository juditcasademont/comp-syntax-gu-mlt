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
  impNegPhrase action = mkUtt negativePol (mkImp action) ;

  actionFact person action = mkCl person action ;
  propertyFact person property = mkCl person property ;

  isProfessionProperty profession = mkVP (mkNP profession) ; --no a_Det
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
  undressAction = mkVP (reflV (mkV "vestir" "vesteixo")) ; --refl doesn't work in imperative "vesteix &+ et" should be "vesteix-te"
  dressAction = mkVP (reflV (mkV "desvestir" "desvesteixo")) ;
  eatAction = mkVP (mkV "menjar") ;
  drinkAction = mkVP (mkV "beure") ;
  smokeAction = mkVP (mkV "fumar") ;
  measureTemperatureAction = mkVP (mkV2 (mkV "medir" "medeixo")) (mkNP the_Det (mkN "temperatura corporal" feminine)) ;
  measureBloodPressureAction = mkVP (mkV2 (mkV "medir" "medeixo")) (mkNP the_Det (mkN "pressió arterial" feminine)) ;

  hospitalPlace = {at = pAdv "a l'hospital" ; to = pAdv "a l'hospital"} ;
  homePlace = {at = pAdv "a casa" ; to = pAdv "a casa"} ;
  schoolPlace = {at = pAdv "a l'escola" ; to = pAdv "a l'escola"} ;
  workPlace = {at = pAdv "a la feina" ; to = pAdv "a la feina"} ;

  doctorProfession = mkCN (mkN "metge") ;
  nurseProfession = mkCN (mkN "infermera") ;
  interpreterProfession = mkCN (mkN "intèrpret") ;

  bePregnantProperty = mkVP (mkA "embarassada") ; --only feminine form
  beIllProperty = mkVP (mkA "malalt") ; --ESTAR (*tu ets malalt)
  beWellProperty = mkVP (mkA "bé") ; --^^same
  beDeadProperty = mkVP (mkA "mort") ; 
  haveAllergiesProperty = mkVP have_V2 (mkNP aPl_Det (mkN "al·lèrgia")) ;
  havePainsProperty = mkVP have_V2 (mkNP aPl_Det (mkN "dolor")) ;
  haveChildrenProperty = mkVP have_V2 (mkNP aPl_Det (mkN "fill")) ;

  feverIllness = mkNP (mkN "febre") ; --no a_Det
  fluIllness = mkNP the_Det (mkN "grip" feminine) ;
  headacheIllness = mkNP (mkN "mal de cap") ;
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
  --be_V = mkV "estar" ;

  }

-----KNOWN ISSUES-----
