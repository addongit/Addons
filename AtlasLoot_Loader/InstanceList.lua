﻿--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
]]
AtlasLoot_ModuleList_Loader = {
	"AtlasLootClassicWoW",
	"AtlasLootBurningCrusade",
	"AtlasLootWotLK",
	"AtlasLootCataclysm",
	"AtlasLootCrafting",
	"AtlasLootWorldEvents"
}

AtlasLoot_InstanceList_Loader = {

["T456Rogue"] = 2,
["TailoringSoulclothEm"] = 5,
["HCHallsKargath"] = 2,
["BDChimaeron"] = 4,
["Ramkahen"] = 4,
["DrakTharonKeepTrollgore"] = 3,
["T456PaladinHoly"] = 2,
["EngineeringMisc"] = 5,
["HCFurnaceMaker"] = 2,
["Ogrila"] = 2,
["WSGArmor"] = 1,
["AQ20Ayamiss"] = 1,
["Gilneas"] = 1,
["AhnkahetTaldaram"] = 3,
["SCHOLODeathKnight"] = 1,
["HoOTrash"] = 4,
["T10PriestShadow"] = 3,
["CFRUnderGhazan"] = 2,
["NaxxDeathKnightTank"] = 3,
["PVP70Warrior"] = 2,
["UlduarKologarn"] = 3,
["DMWMagisterKalendris"] = 1,
["Naxx80Thaddius"] = 3,
["HordeExpedition"] = 3,
["LeatherItemEnhancement"] = 5,
["SPKalecgos"] = 2,
["EnchantingGloves"] = 5,
["HCFurnaceBreaker"] = 2,
["EngineeringTinker"] = 5,
["BoTCouncil"] = 4,
["PVP70NonSet"] = 2,
["TailoringItemEnhancement"] = 5,
["TKEyeSolarian"] = 2,
["Kurenai"] = 2,
["PVP70Mage"] = 2,
["Naxx80AnubRekhan"] = 3,
["KeepersofTime"] = 2,
["HardModeResist"] = 2,
["LeatherworkingLeatherVolcanicArmor"] = 5,
["ABSets"] = 1,
["BRDArena"] = 1,
["KaraNightbane"] = 2,
["AQ40Fankriss"] = 1,
["KaraAttumen"] = 2,
["GundrakTrash"] = 3,
["BlacksmithingMailBloodsoulEmbrace"] = 5,
["SmithingWeaponRemoved"] = 5,
["UlduarIronCouncil"] = 3,
["WorldBossesBC"] = 2,
["T11Mage"] = 4,
["Stormwind"] = 1,
["BTBloodboil"] = 2,
["T456Hunter"] = 2,
["LeatherworkingMailSwiftarrowBattlefear"] = 5,
["BRDTomb"] = 1,
["Inscription_Scrolls"] = 5,
["LeatherworkingMailNerubianHive"] = 5,
["TKEyeKaelthas"] = 2,
["Ashtongue"] = 2,
["CFRSlaveRokmar"] = 2,
["TailoringArmorBC"] = 5,
["UlduarRazorscale"] = 3,
["MountHyjalKazrogal"] = 2,
["STRATMalekithePallid"] = 1,
["Inscription_DeathKnight"] = 5,
["AQ20Sets"] = 1,
["SMArmoryLoot"] = 1,
["EnchantingMisc"] = 5,
["VPErtan"] = 4,
["JewelcraftingDailyBlue"] = 5,
["SilvermoonCity"] = 1,
["TheSilverCovenant"] = 3,
["AQ20Moam"] = 1,
["STRATRamsteintheGorger"] = 1,
["GBDrahga"] = 4,
["LBRSFelguard"] = 1,
["NaxxShamanElemental"] = 3,
["MCMagmadar"] = 1,
["CFRSerpentHydross"] = 2,
["Gnomish"] = 5,
["T11PaladinHoly"] = 4,
["T11PaladinRetribution"] = 4,
["UBRSAnvilcrack"] = 1,
["Onyxia"] = 3,
["LeatherworkingMailBlueDragonM"] = 5,
["VPAsaad"] = 4,
["LeatherworkingLeatherBoreanEmbrace"] = 5,
["ToTOzumat"] = 4,
["FirelandsRagnaros"] = 4,
["UBRSBeast"] = 1,
["FirelandsShannox"] = 4,
["Naxx80Gluth"] = 3,
["T11Hunter"] = 4,
["LeatherworkingLeatherWildDraenishA"] = 5,
["LeatherLeatherArmorBC"] = 5,
["LostCityBarim"] = 4,
["PVP80ShamanRestoration"] = 3,
["StonecoreTrash"] = 4,
["KnightsoftheEbonBlade"] = 3,
["SPFelmyst"] = 2,
["EngineeringArmorMail"] = 5,
["T0Warlock"] = 1,
["MCGehennas"] = 1,
["AQ40Skeram"] = 1,
["BTIllidanStormrage"] = 2,
["Inscription_OffHand"] = 5,
["Heirloom85"] = 4,
["BDAtramedes"] = 4,
["CoTMorassAeonus"] = 2,
["LBRSWyrmthalak"] = 1,
["ZFAntusul"] = 1,
["T11DruidFeral"] = 4,
["JewelTrinket"] = 5,
["SCHOLOJandiceBarov"] = 1,
["T10WarriorFury"] = 3,
["T456ShamanElemental"] = 2,
["HallsofLightningLoken"] = 3,
["EngineeringArmorCloth"] = 5,
["CoTHillsbradHunter"] = 2,
["KirinTor"] = 3,
["GruulsLairHighKingMaulgar"] = 2,
["Mooncloth"] = 5,
["DMEPusillin"] = 1,
["LeatherworkingMailNetherstrikeArmor"] = 5,
["SmithingWeaponCata"] = 5,
["ZA85JanAlai"] = 4,
["DMNGuardMoldar"] = 1,
["DMNGuardFengus"] = 1,
["VentureBay"] = 3,
["JewelDragonsEye"] = 5,
["AlchemyOtherElixir"] = 5,
["PVP70PriestHoly"] = 2,
["SMGraveyardLoot"] = 1,
["Naxx80Trash"] = 3,
["Netherwing"] = 2,
["BRDHoundmaster"] = 1,
["MountsAchievement"] = 4,
["PVP60Rogue"] = 1,
["CFRSerpentVashj"] = 2,
["EnchantingBracer"] = 5,
["T9DruidBalance"] = 3,
["Shatar"] = 2,
["HoOAnhuur"] = 4,
["FrenzyheartTribe"] = 3,
["ArchaeologyNightElf"] = 5,
["DMWPrinceTortheldrin"] = 1,
["VWOWSets"] = 1,
["PetsRare"] = 4,
["STHazzasandMorphaz"] = 1,
["STAvatarofHakkar"] = 1,
["TransformationItems"] = 4,
["MCGeddon"] = 1,
["SmithingWeaponWrath"] = 5,
["Hellfire"] = 2,
["PVP85NonSet"] = 4,
["JewelYellow"] = 5,
["BWLVaelastrasz"] = 1,
["TheNexusAnomalus"] = 3,
["ZA85Nalorakk"] = 4,
["UldGrimlok"] = 1,
["T9DeathKnightDPS"] = 3,
["SPBrutallus"] = 2,
["TailoringArcanoVest"] = 5,
["ZA85TimedChest"] = 4,
["MountsCraftQuest"] = 4,
["WorldEpics80"] = 3,
["BoTChogall"] = 4,
["STRATTrash"] = 1,
["PVP60Hunter"] = 1,
["BTGorefiend"] = 2,
["UldShovelphlange"] = 1,
["Therazane"] = 4,
["KaraTrash"] = 2,
["HCFurnaceBroggok"] = 2,
["T9WarriorProtection"] = 3,
["VaultofArchavonToravon"] = 3,
["GnomereganLoot"] = 1,
["SCHOLOKirtonostheHerald"] = 1,
["BlackrockCavernsLordObsidius"] = 4,
["AVMisc"] = 1,
["TabardsRemoved"] = 4,
["AzjolNerubHadronox"] = 3,
["LeatherworkingLeatherFelSkin"] = 5,
["Sporeggar"] = 2,
["NaxxPaladinHoly"] = 3,
["PVP85Rogue"] = 4,
["ZFZerillis"] = 1,
["ShadowfangTrash"] = 4,
["PVP70Accessories2"] = 2,
["DMEZevrimThornhoof"] = 1,
["MountsPvP"] = 4,
["TailoringFrostwovenPower"] = 5,
["Spellfire"] = 5,
["T0Mage"] = 1,
["T456DruidBalance"] = 2,
["HallsofStoneMaiden"] = 3,
["VioletHoldIchoron"] = 3,
["ICCFestergut"] = 3,
["PVP60Druid"] = 1,
["Inscription_Paladin"] = 5,
["ArchaeologyTolvir"] = 5,
["FoSBronjahm"] = 3,
["VPAltairus"] = 4,
["ArgentDawn"] = 1,
["Skyguard"] = 2,
["T456DruidRestoration"] = 2,
["T11PaladinProtection"] = 4,
["SmithingArmorOld"] = 5,
["LBRSSmolderweb"] = 1,
["ZFHydromancerVelratha"] = 1,
["MountsRare"] = 4,
["Naxx80FourHorsemen"] = 3,
["AQ20Buru"] = 1,
["EmblemofValor"] = 3,
["DarkspearTrolls"] = 1,
["JewelGreen"] = 5,
["HallsofStoneKrystallus"] = 3,
["MCRANDOMBOSSDROPPS"] = 1,
["LBRSVoone"] = 1,
["NaxxPaladinRetribution"] = 3,
["ZGKilnara"] = 4,
["PVP70DruidRestoration"] = 2,
["SCHOLODoctorTheolenKrastinov"] = 1,
["AQ40CThun"] = 1,
["STJammalanandOgom"] = 1,
["EmblemofTriumph"] = 3,
["SmithingArmorRemoved"] = 5,
["TailoringSpellstrikeInfu"] = 5,
["MountHyjalTrash"] = 2,
["WSGWeapons"] = 1,
["HoOIsiset"] = 4,
["AuchShadowBlackheart"] = 2,
["CFRSlaveMennu"] = 2,
["TheNexusKolurgStoutbeard"] = 3,
["HardModeArena"] = 2,
["LeatherworkingMailBlackDragonM"] = 5,
["CFRSerpentLurker"] = 2,
["PVP80Weapons"] = 3,
["Halion"] = 3,
["LeatherworkingMailScaledDraenicA"] = 5,
["GBErudax"] = 4,
["ICCTrash"] = 3,
["CFRUnderHungarfen"] = 2,
["Naxx80Heigan"] = 3,
["LeatherworkingLeatherEvisceratorBattlegear"] = 5,
["WailingCavernsLoot"] = 1,
["T1T2Shaman"] = 1,
["T9DruidRestoration"] = 3,
["WildhammerClan"] = 4,
["Mining"] = 5,
["LeatherCloaks"] = 5,
["BlackrockCavernsBeauty"] = 4,
["Nagrand"] = 2,
["BlackrockMountainEntLoot"] = 1,
["AuchManaTavarok"] = 2,
["Swordsmith"] = 5,
["NaxxPriestHoly"] = 3,
["T3Mage"] = 1,
["SCHOLORasFrostwhisper"] = 1,
["ArchaeologyDwarf"] = 5,
["MCSulfuron"] = 1,
["PVP60Warrior"] = 1,
["AuchShadowGrandmaster"] = 2,
["ThunderBluff"] = 1,
["TailoringShirts"] = 5,
["UldIronaya"] = 1,
["PVP80Accessories"] = 3,
["PVP85PriestShadow"] = 4,
["BTAkama"] = 2,
["Inscription_Warrior"] = 5,
["BRDPyromantLoregrain"] = 1,
["UBRSRunewatcher"] = 1,
["T1T2Druid"] = 1,
["BRDWarderStilgiss"] = 1,
["OcuDrakos"] = 3,
["AQ40BugFam"] = 1,
["VioletHoldCyanigosa"] = 3,
["SCHOLOLadyIlluciaBarov"] = 1,
["T11Warlock"] = 4,
["UlduarAuriaya"] = 3,
["CraftedWeapons"] = 5,
["CoTStratholmeTrash"] = 3,
["PVP70Weapons"] = 2,
["SCHOLORattlegore"] = 1,
["Sartharion"] = 3,
["VioletHoldLavanthor"] = 3,
["Inscription_Warlock"] = 5,
["CFRUnderStalker"] = 2,
["CoTStratholmeSalramm"] = 3,
["EmblemofTriumph2"] = 3,
["TrialoftheCrusaderNorthrendBeasts"] = 3,
["ZGJindo"] = 4,
["NaxxPaladinProtection"] = 3,
["SmithingArmorEnhancement"] = 5,
["JewelRing"] = 5,
["LeatherDrumsBagsMisc"] = 5,
["GundrakGaldarah"] = 3,
["T10DeathKnightDPS"] = 3,
["T10DruidBalance"] = 3,
["PVP80ShamanElemental"] = 3,
["AllianceVanguard"] = 3,
["BWLChromaggus"] = 1,
["BRDLordIncendius"] = 1,
["HCHallsTrash"] = 2,
["Shadoweave"] = 5,
["T11ShamanEnhancement"] = 4,
["MountsAlliance"] = 4,
["OldKeys"] = 1,
["HardModePlate"] = 2,
["ICCLanathel"] = 3,
["ShadowfangWalden"] = 4,
["BWLFlamegor"] = 1,
["LeatherworkingCataVendor"] = 5,
["LeatherworkingMailFelstalkerArmor"] = 5,
["AuchSethekkTalonKing"] = 2,
["PVP85Warlock"] = 4,
["STRATTheUnforgiven"] = 1,
["MountsFaction"] = 4,
["StonecoreAzil"] = 4,
["AlchemyOil"] = 5,
["PVP70Accessories"] = 2,
["T9Mage"] = 3,
["BRDVerek"] = 1,
["KaraAran"] = 2,
["T456PaladinProtection"] = 2,
["T1T2Hunter"] = 1,
["AuchCryptsExarch"] = 2,
["SmithingWeaponEnhancement"] = 5,
["BWLNefarian"] = 1,
["SmithingArmorBC"] = 5,
["STRATBalnazzar"] = 1,
["STRATInstructorGalford"] = 1,
["BlackrockCavernsRomogg"] = 4,
["Goblin"] = 5,
["KaraCharredBoneFragment"] = 2,
["BRDLordRoccor"] = 1,
["TKArcHarbinger"] = 2,
["LBRSVosh"] = 1,
["PetsEvent"] = 4,
["STRATWilleyHopebreaker"] = 1,
["EngineeringExplosives"] = 5,
["GundrakColossus"] = 3,
["UtgardeKeepTrash"] = 3,
["UPSkadi"] = 3,
["DMNKingGordok"] = 1,
["Naxx80Loatheb"] = 3,
["Armorsmith"] = 5,
["UlduarIgnis"] = 3,
["MCLucifron"] = 1,
["PVP85DruidRestoration"] = 4,
["GuardiansHyjal"] = 4,
["DMNStomperKreeg"] = 1,
["LeatherworkingLeatherOvercasterBattlegear"] = 5,
["Timbermaw"] = 1,
["T10ShamanRestoration"] = 3,
["T9Rogue"] = 3,
["CookingSpecial"] = 5,
["TBCSets"] = 2,
["HCMagtheridon"] = 2,
["Argaloth"] = 4,
["PVP85Accessories"] = 4,
["PetsRemoved"] = 4,
["JewelNeck"] = 5,
["DMETrash"] = 1,
["Inscription_Priest"] = 5,
["LeatherworkingMailFelscaleArmor"] = 5,
["T456PriestHoly"] = 2,
["PVP80ClassItems"] = 3,
["EmblemofConquest"] = 3,
["ArchaeologyMisc"] = 5,
["UlduarMimiron"] = 3,
["DrakTharonKeepTrash"] = 3,
["SMCathedralLoot"] = 1,
["UBRSTrash"] = 1,
["DMWHelnurath"] = 1,
["PVP80NonSet"] = 3,
["LBRSTrash"] = 1,
["AQBroodRings"] = 1,
["ToTUlthok"] = 4,
["PoSTyrannus"] = 3,
["KaraPrince"] = 2,
["AuchCryptsShirrak"] = 2,
["TKMechCacheoftheLegion"] = 2,
["NewItems41"] = 4,
["Tranquillien"] = 2,
["SPMuru"] = 2,
["PVP80PriestShadow"] = 3,
["FirelandsStaghelm"] = 4,
["T0Warrior"] = 1,
["ArgentCrusade"] = 3,
["ZGVenoxis"] = 4,
["LBRSCrystalFang"] = 1,
["WSGAccessories"] = 1,
["NaxxShamanEnhancement"] = 3,
["AQ40Emperors"] = 1,
["PVP70PriestShadow"] = 2,
["HCRampWatchkeeper"] = 2,
["TailoringCataVendor"] = 5,
["PVP60Priest"] = 1,
["BDMaloriak"] = 4,
["T10PaladinRetribution"] = 3,
["CFRSerpentLeotheras"] = 2,
["TKBotSplinter"] = 2,
["STEranikus"] = 1,
["T3Warrior"] = 1,
["UlduarVezax"] = 3,
["SmithingMisc"] = 5,
["LBRSSlavener"] = 1,
["BlacksmithingPlateEnchantedAdaman"] = 5,
["OcuUrom"] = 3,
["LeatherworkingLeatherPrimalBatskin"] = 5,
["SunOffensive"] = 2,
["BlacksmithingPlateAdamantiteB"] = 5,
["PVP80PriestHoly"] = 3,
["Consortium"] = 2,
["TailoringCloth"] = 5,
["HallsofStoneTribunal"] = 3,
["SCHOLOLorekeeperPolkelt"] = 1,
["Stockade"] = 1,
["AlteracFactions"] = 1,
["SPPatterns"] = 2,
["T9PaladinRetribution"] = 3,
["AhnkahetTrash"] = 3,
["HallsofLightningBjarngrim"] = 3,
["KaraIllhoof"] = 2,
["WorldEpics3039"] = 1,
["PetsCrafted"] = 4,
["CoTHillsbradDrake"] = 2,
["T3Shaman"] = 1,
["NaxxWarlock"] = 3,
["MiscFactions"] = 1,
["SMTVexallus"] = 2,
["LeatherLeather"] = 5,
["TheNexusTelestra"] = 3,
["WOTLKSets"] = 3,
["ZFSezzziz"] = 1,
["HoRMarwyn"] = 3,
["AQ40Trash"] = 1,
["Naxx80Gothik"] = 3,
["SCHOLOLordAlexeiBarov"] = 1,
["STRATNerubenkan"] = 1,
["T10Mage"] = 3,
["UlduarYoggSaron"] = 3,
["BTShahraz"] = 2,
["AuchManaPandemonius"] = 2,
["PVP60Mage"] = 1,
["EnchantingCloak"] = 5,
["TailoringBloodvineG"] = 5,
["PVP80Mage"] = 3,
["CookingRating"] = 5,
["UlduarHodir"] = 3,
["BlackrockCavernsCorla"] = 4,
["AuchShadowHellmaw"] = 2,
["TrialoftheCrusaderAnubarak"] = 3,
["CookingDaily"] = 5,
["LBRSDoomhowl"] = 1,
["EnchantingCataVendor"] = 5,
["DeadminesTrash"] = 4,
["ZFChiefUkorzSandscalp"] = 1,
["DMEHydro"] = 1,
["ZA85Daakara"] = 4,
["AuchTrash"] = 2,
["Inscription_Rogue"] = 5,
["T3Paladin"] = 1,
["GBUmbriss"] = 4,
["TrialoftheCrusaderLordJaraxxus"] = 3,
["CFRSteamWarlord"] = 2,
["T11ShamanRestoration"] = 4,
["DMWTsuzee"] = 1,
["T9PaladinHoly"] = 3,
["VaultofArchavonArchavon"] = 3,
["BRDFineousDarkvire"] = 1,
["NaxxMage"] = 3,
["CFRSteamSteamrigger"] = 2,
["PVP80PaladinHoly"] = 3,
["BRDTheVault"] = 1,
["CoTHillsbradSkarloc"] = 2,
["BlacksmithingPlateBurningRage"] = 5,
["AlchemyGuardianElixir"] = 5,
["TrialoftheCrusaderFactionChampions"] = 3,
["HallsofStoneSjonnir"] = 3,
["TailoringImbuedNeather"] = 5,
["CookingOtherBuffs"] = 5,
["PVP85PaladinRetribution"] = 4,
["HCHallsNethekurse"] = 2,
["UlduarAlgalon"] = 3,
["SPEredarTwins"] = 2,
["LBRSSpirestoneButcher"] = 1,
["ZGSets"] = 1,
["VWOWScholo"] = 1,
["WorldEpics5060"] = 1,
["TKMechCalc"] = 2,
["UPYmiron"] = 3,
["BTPatterns"] = 2,
["TabardsHorde"] = 4,
["T9ShamanElemental"] = 3,
["PVP70ShamanRestoration"] = 2,
["MCGarr"] = 1,
["NaxxHunter"] = 3,
["LeatherworkingLeatherPrimalIntent"] = 5,
["PetsPromotionalCardGame"] = 4,
["UBRSGyth"] = 1,
["PVP70WarlockDemonology"] = 2,
["WorldEpics85"] = 4,
["TheOracles"] = 3,
["STRATRisenHammersmith"] = 1,
["Heirloom"] = 3,
["AlchemyBattleElixir"] = 5,
["KaraMaiden"] = 2,
["VioletHoldTrash"] = 3,
["JewelcraftingDailyGreen"] = 5,
["CoTTrash"] = 2,
["BoTTrash"] = 4,
["DMEAlzzin"] = 1,
["PVP60Shaman"] = 1,
["CoTStratholmeMeathook"] = 3,
["TailoringShadowEmbrace"] = 5,
["Naxx80KelThuzad"] = 3,
["DS3Cloth"] = 2,
["BWLEbonroc"] = 1,
["ZGMadness"] = 4,
["PoSGarfrost"] = 3,
["HardModeRelic"] = 2,
["JewelMisc"] = 5,
["T0Shaman"] = 1,
["T456PaladinRetribution"] = 2,
["TabardsAlliance"] = 4,
["LeatherLeatherArmorCata"] = 5,
["TKEyeAlar"] = 2,
["T9DruidFeral"] = 3,
["T10WarriorProtection"] = 3,
["ArchaeologyOrc"] = 5,
["TailoringMisc"] = 5,
["GundrakEck"] = 3,
["BDOmnotron"] = 4,
["TailoringWhitemendWis"] = 5,
["LeatherworkingLeatherWindhawkArmor"] = 5,
["TheSonsofHodir"] = 3,
["ThoriumBrotherhood"] = 1,
["Naxx80Faerlina"] = 3,
["AuchSethekkRavenGod"] = 2,
["AlchemyCauldron"] = 5,
["PoSKrickIck"] = 3,
["ArchaeologyTroll"] = 5,
["SMTrash"] = 1,
["T10DruidFeral"] = 3,
["Exodar"] = 1,
["LeatherworkingMailNetherscaleArmor"] = 5,
["NaxxDruidRestoration"] = 3,
["TabardsAchievementQuestRareMisc"] = 4,
["HardModeAccessories"] = 2,
["TailoringTheUnyielding"] = 5,
["WrathKeys"] = 3,
["T3Hunter"] = 1,
["PVP85Warrior"] = 4,
["AuchManaYor"] = 2,
["T10DruidRestoration"] = 3,
["CookingBuff"] = 5,
["PVP85PaladinHoly"] = 4,
["WSGMisc"] = 1,
["SPTrash"] = 2,
["UPTrash"] = 3,
["AuchCryptsAvatar"] = 2,
["ICCPutricide"] = 3,
["T3Druid"] = 1,
["BlacksmithingPlateImperialPlate"] = 5,
["SmithingArmorWrath"] = 5,
["AzjolNerubKrikthir"] = 3,
["TKBotSarannis"] = 2,
["TheSunreavers"] = 3,
["LBRSHalycon"] = 1,
["Maghar"] = 2,
["LeatherworkingMailNetherFury"] = 5,
["ICCLichKing"] = 3,
["Hammersmith"] = 5,
["ZA85Trash"] = 4,
["UldAncientStoneKeeper"] = 1,
["LowerCity"] = 2,
["HardModeCloaks"] = 2,
["ShadowfangGodfrey"] = 4,
["HCHallsOmrogg"] = 2,
["StonecoreOzruk"] = 4,
["DeadminesFoeReaper"] = 4,
["TailoringArmorWotLK"] = 5,
["TheWyrmrestAccord"] = 3,
["T9DeathKnightTank"] = 3,
["DMNThimblejack"] = 1,
["BlacksmithingPlateFaithFelsteel"] = 5,
["T456PriestShadow"] = 2,
["BRDBSPlans"] = 1,
["TKBotFreywinn"] = 2,
["CFRSerpentMorogrim"] = 2,
["Naxx80Grobbulus"] = 3,
["CookingStandard"] = 5,
["PVP85DruidFeral"] = 4,
["SCHOLOQuestItems"] = 1,
["CookingAPSP"] = 5,
["STRATHearthsingerForresten"] = 1,
["T11DeathKnightTank"] = 4,
["HallsofStoneTrash"] = 3,
["CFRSerpentKarathress"] = 2,
["NaxxWarriorFury"] = 3,
["FishingDaily"] = 5,
["PetsPetStore"] = 4,
["STTrash"] = 1,
["Naxx80Noth"] = 3,
["PVP80PaladinRetribution"] = 3,
["UlduarFreya"] = 3,
["ICCGunshipBattle"] = 3,
["AQ40Ouro"] = 1,
["ShadowfangSpringvale"] = 4,
["HoRFalric"] = 3,
["MountHyjalAnetheron"] = 2,
["TrialoftheChampionBlackKnight"] = 3,
["AQ20Ossirian"] = 1,
["BDNefarian"] = 4,
["JewelRed"] = 5,
["AzjolNerubAnubarak"] = 3,
["OcuTrash"] = 3,
["BRDFlamelash"] = 1,
["T456Warlock"] = 2,
["PVP80DruidFeral"] = 3,
["ZA85Malacrass"] = 4,
["T11WarriorFury"] = 4,
["AhnkahetAmanitar"] = 3,
["CookingFeasts"] = 5,
["T11PriestHoly"] = 4,
["DeadminesGearbreaker"] = 4,
["Orgrimmar"] = 1,
["UldTrash"] = 1,
["FirelandsBethtilac"] = 4,
["MountsEvent"] = 4,
["FHTrashMobs"] = 3,
["PVP80DruidBalance"] = 3,
["T456ShamanRestoration"] = 2,
["BTCouncil"] = 2,
["Enchanting2HWeapon"] = 5,
["T10ShamanEnhancement"] = 3,
["ZFTrash"] = 1,
["LeatherMailArmorBC"] = 5,
["LostCityHusam"] = 4,
["T10Warlock"] = 3,
["BDTrash"] = 4,
["T11ShamanElemental"] = 4,
["MCShazzrah"] = 1,
["GundrakSladran"] = 3,
["T10DeathKnightTank"] = 3,
["PVP85Mage"] = 4,
["BoTSinestra"] = 4,
["HardModeMail"] = 2,
["VWOWZulGurub"] = 1,
["T456WarriorProtection"] = 2,
["KaraNetherspite"] = 2,
["BRDImperatorDagranThaurissan"] = 1,
["LostCityTrash"] = 4,
["SCHOLOInstructorMalicia"] = 1,
["KaraCurator"] = 2,
["EnchantingRing"] = 5,
["FirelandsRhyolith"] = 4,
["PetsAccessories"] = 4,
["PVP70DeathKnight"] = 2,
["T456WarriorFury"] = 2,
["LBRSZigris"] = 1,
["T10PaladinProtection"] = 3,
["AzjolNerubTrash"] = 3,
["DMNGuardSlipkik"] = 1,
["LeatherLeatherArmorOld"] = 5,
["T11DeathKnightDPS"] = 4,
["ArchaeologyArmorAndWeapons"] = 5,
["T9ShamanEnhancement"] = 3,
["TailoringDuskweaver"] = 5,
["STRATStratholmeCourier"] = 1,
["TheKaluak"] = 3,
["Aldor"] = 2,
["Axesmith"] = 5,
["NaxxDruidBalance"] = 3,
["LeatherworkingLeatherBloodTigerH"] = 5,
["STRATBaronessAnastari"] = 1,
["TKBotLaj"] = 2,
["ICCValithria"] = 3,
["LostCityLockmaw"] = 4,
["AuchSethekkDarkweaver"] = 2,
["CenarionCircle"] = 1,
["PVP85Trinkets"] = 4,
["DMWIllyannaRavenoak"] = 1,
["T0Rogue"] = 1,
["LBRSLordMagus"] = 1,
["Undercity"] = 1,
["VioletHoldErekem"] = 3,
["ScaleSands"] = 2,
["ICCSindragosa"] = 3,
["AQ40Viscidus"] = 1,
["SCHOLOTrash"] = 1,
["ICCLordMarrowgar"] = 3,
["T1T2Paladin"] = 1,
["DeadminesGlubtok"] = 4,
["CoTStratholmeMalGanis"] = 3,
["UlduarLeviathan"] = 3,
["HoRLichKing"] = 3,
["DeadminesEntrance"] = 1,
["UBRSSolakar"] = 1,
["PVP70WarlockDestruction"] = 2,
["T0Hunter"] = 1,
["SmithingWeaponBC"] = 5,
["EngineeringWeapon"] = 5,
["AuchManaNexusPrince"] = 2,
["DS3Mail"] = 2,
["EnchantingStaff"] = 5,
["DMBooks"] = 1,
["ShadowfangAshbury"] = 4,
["AlchemyPotion"] = 5,
["Terokkar"] = 2,
["SCHOLOBloodStewardofKirtonos"] = 1,
["BlacksmithingPlateOrnateSaroniteBattlegear"] = 5,
["T3Rogue"] = 1,
["HardModeCloth"] = 2,
["BRDHighInterrogatorGerstahn"] = 1,
["TKMechSepethrea"] = 2,
["BRDBaelGar"] = 1,
["LeatherMailArmorOld"] = 5,
["PVP70PaladinRetribution"] = 2,
["NaxxShamanRestoration"] = 3,
["LeatherworkingMailStormhideBattlegear"] = 5,
["PVP60Warlock"] = 1,
["HardModeWeapons"] = 2,
["BRDPrincess"] = 1,
["JewelPurple"] = 5,
["TailoringSpellfireWrath"] = 5,
["TheNexusKeristrasza"] = 3,
["UldObsidianSentinel"] = 1,
["UBRSEmberseer"] = 1,
["AhnkahetVolazj"] = 3,
["AQ20Rajaxx"] = 1,
["Naxx80Sapphiron"] = 3,
["MountsCardGamePromotional"] = 4,
["LBRSOmokk"] = 1,
["ICCCouncil"] = 3,
["DMNTRIBUTERUN"] = 1,
["HallsofLightningIonar"] = 3,
["BWLRazorgore"] = 1,
["SCHOLOTheRavenian"] = 1,
["SMTFireheart"] = 2,
["LeatherworkingLeatherSClefthoof"] = 5,
["CExpedition"] = 2,
["PVP85DruidBalance"] = 4,
["OcuEregos"] = 3,
["CFRSteamTrash"] = 2,
["KaraNamed"] = 2,
["EngineeringGem"] = 5,
["AhnkahetNadox"] = 3,
["DrakTharonKeepTharonja"] = 3,
["MCTrashMobs"] = 1,
["UlduarDeconstructor"] = 3,
["DMNCaptainKromcrush"] = 1,
["MountHyjalAzgalor"] = 2,
["HonorHold"] = 2,
["UtgardeKeepSkarvald"] = 3,
["TKEyeTrash"] = 2,
["LeatherMailArmorCata"] = 5,
["TabardsNeutralFaction"] = 4,
["UldArchaedas"] = 1,
["CFRSlaveQuagmirran"] = 2,
["ZFGahzrilla"] = 1,
["UldBaelog"] = 1,
["CFRSerpentTrash"] = 2,
["PVP70PaladinHoly"] = 2,
["CoTMorassTemporus"] = 2,
["CFRUnderSwamplord"] = 2,
["PVP80Hunter"] = 3,
["T11DruidBalance"] = 4,
["Blackfathom"] = 1,
["AQ40Sartura"] = 1,
["PVP80Warlock"] = 3,
["GBThrongus"] = 4,
["CoTStratholmeEpoch"] = 3,
["JewelcraftingDailyOrange"] = 5,
["UldRevelosh"] = 1,
["BlacksmithingPlateSavageSaroniteBattlegear"] = 5,
["T3Priest"] = 1,
["SMTDelrissa"] = 2,
["LeatherworkingLeatherIceborneEmbrace"] = 5,
["DMWTendrisWarpwood"] = 1,
["MountHyjalWinterchill"] = 2,
["PVP80DruidRestoration"] = 3,
["PVP70ShamanEnhancement"] = 2,
["AB4049"] = 1,
["JewelBlue"] = 5,
["NaxxDeathKnightDPS"] = 3,
["STRATLordAuriusRivendare"] = 1,
["ArchaeologyDraenei"] = 5,
["BlacksmithingPlateTheDarksoul"] = 5,
["VioletHoldMoragg"] = 3,
["NaxxDruidFeral"] = 3,
["PVP85Weapons2"] = 4,
["Malygos"] = 3,
["Darnassus"] = 1,
["STRATTimmytheCruel"] = 1,
["ZFDustwraith"] = 1,
["PVP80Warrior"] = 3,
["LBRSQuestItems"] = 1,
["BaradinsWardens"] = 4,
["TheAshenVerdict"] = 3,
["HoOSetesh"] = 4,
["Zangarmarsh"] = 2,
["WorldEpics4049"] = 1,
["WorldEpics70"] = 3,
["BRDGolemLordArgelmach"] = 1,
["AQ20Trash"] = 1,
["TrialoftheChampionChampions"] = 3,
["JewelcraftingDailyRed"] = 5,
["AQ40Sets"] = 1,
["JewelOrange"] = 5,
["WinterfinRetreat"] = 3,
["T0Priest"] = 1,
["LakeWintergrasp"] = 3,
["VioletEye"] = 2,
["ZGZanzil"] = 4,
["BTTrash"] = 2,
["StonecoreSlabhide"] = 4,
["DeadminesCookie"] = 4,
["BTNajentus"] = 2,
["BlackrockCavernsSteelbender"] = 4,
["T0Druid"] = 1,
["BRDPanzor"] = 1,
["BRDTrash"] = 1,
["PVP70Rogue"] = 2,
["TailoringArmorOld"] = 5,
["T10Rogue"] = 3,
["STRATMagistrateBarthilas"] = 1,
["T9Hunter"] = 3,
["MCMajordomo"] = 1,
["EnchantingChest"] = 5,
["FirelandsBaleroc"] = 4,
["T0Paladin"] = 1,
["OcuCloudstrider"] = 3,
["EngineeringArmorPlate"] = 5,
["ZFWitchDoctorZumrah"] = 1,
["JewelcraftingDailyDragonEye"] = 5,
["DMWTrash"] = 1,
["BoTValionaTheralion"] = 4,
["TKArcDalliah"] = 2,
["T456DruidFeral"] = 2,
["VaultofArchavonEmalon"] = 3,
["CFRSteamThespia"] = 2,
["EnchantingWeapon"] = 5,
["T9PriestShadow"] = 3,
["Scryer"] = 2,
["SmithingCataVendor"] = 5,
["Naxx80Patchwerk"] = 3,
["CookingHitCrit"] = 5,
["Inscription_RelicsEnchants"] = 5,
["ShadowfangSilverlaine"] = 4,
["PVP80Misc"] = 3,
["PVP60Paladin"] = 1,
["PVP70DruidFeral"] = 2,
["JewelcraftingDailyMeta"] = 5,
["T9WarriorFury"] = 3,
["TrialoftheCrusaderPatterns"] = 3,
["HallsofLightningVolkhan"] = 3,
["T1T2Rogue"] = 1,
["FoSDevourer"] = 3,
["Ironforge"] = 1,
["KaraMoroes"] = 2,
["TailoringBags"] = 5,
["RagefireChasmLoot"] = 1,
["BTSupremus"] = 2,
["NaxxWarriorProtection"] = 3,
["T11PriestShadow"] = 4,
["SCHOLODarkmasterGandling"] = 1,
["BlacksmithingPlateFlameG"] = 5,
["PVP70Rep"] = 2,
["EngineeringReagents"] = 5,
["LeatherworkingLeatherDevilsaurArmor"] = 5,
["DeadminesVanessa"] = 4,
["BRDQuestItems"] = 1,
["EngineeringArmor"] = 5,
["T10ShamanElemental"] = 3,
["PVP70DruidBalance"] = 2,
["KaraChess"] = 2,
["SMTKaelthas"] = 2,
["EngineeringArmorLeather"] = 5,
["ArchaeologyFossil"] = 5,
["PetsAchievementFaction"] = 4,
["NaxxPriestShadow"] = 3,
["STRATSkull"] = 1,
["EmblemofHeroism"] = 3,
["ICCRotface"] = 3,
["BTReliquaryofSouls"] = 2,
["ToTNazjar"] = 4,
["Inscription_Misc"] = 5,
["UlduarPatterns"] = 3,
["StonecoreCorborus"] = 4,
["EngineeringPetMount"] = 5,
["EnchantingBoots"] = 5,
["Inscription_Hunter"] = 5,
["T1T2Mage"] = 1,
["HoOAnraphet"] = 4,
["GundrakMoorabi"] = 3,
["BWLTrashMobs"] = 1,
["ZA85AkilZon"] = 4,
["AlchemyTransmute"] = 5,
["TrialoftheChampionEadricthePure"] = 3,
["MCGolemagg"] = 1,
["DMELethtendrisPimgib"] = 1,
["DragonmawClan"] = 4,
["UlduarThorim"] = 3,
["LostCitySiamat"] = 4,
["DeadminesRipsnarl"] = 4,
["HoOPtah"] = 4,
["LeatherSpecializations"] = 5,
["BlacksmithingPlateKhoriumWard"] = 5,
["T1T2Warlock"] = 1,
["LeatherworkingMailGreenDragonM"] = 5,
["T1T2Warrior"] = 1,
["TailoringPrimalMoon"] = 5,
["T3Warlock"] = 1,
["PVP80Rogue"] = 3,
["T9ShamanRestoration"] = 3,
["FirelandsAlysrazor"] = 4,
["CoTStratholmeInfiniteCorruptor"] = 3,
["TKArcUnbound"] = 2,
["Inscription_Mage"] = 5,
["BoTWyrmbreaker"] = 4,
["EngineeringArmorTrinket"] = 5,
["ABMisc"] = 1,
["SMTTrash"] = 2,
["CoTMorassDeja"] = 2,
["JewelPrismatic"] = 5,
["JusticePoints"] = 4,
["ToTTrash"] = 4,
["BDMagmaw"] = 4,
["PVP80ShamanEnhancement"] = 3,
["TFWConclave"] = 4,
["VPTrash"] = 4,
["AQ40Huhuran"] = 1,
["GnomereganRep"] = 1,
["EarthenRing"] = 4,
["TFWAlAkir"] = 4,
["AQEnchants"] = 1,
["ZA85Halazzi"] = 4,
["RazorfenKraulLoot"] = 1,
["ZGMandokir"] = 4,
["AQ20Kurinnaxx"] = 1,
["VaultofArchavonKoralon"] = 3,
["JewelcraftingDailyYellow"] = 5,
["T10Hunter"] = 3,
["TailoringNeatherVest"] = 5,
["T456Mage"] = 2,
["DrakTharonKeepNovos"] = 3,
["Inscription_Shaman"] = 5,
["DS3Plate"] = 2,
["NaxxRogue"] = 3,
["LeatherworkingLeatherIronfeatherArmor"] = 5,
["ZGTrash"] = 4,
["MountHyjalArchimonde"] = 2,
["LBRSBashguud"] = 1,
["Weaponsmith"] = 5,
["RazorfenDownsLoot"] = 1,
["CookingAgiStrInt"] = 5,
["KaraOperaEvent"] = 2,
["JewelcraftingDailyRemoved"] = 5,
["TailoringBattlecastG"] = 5,
["VioletHoldZuramat"] = 3,
["LeatherworkingMailFrostscaleBinding"] = 5,
["Inscription_Druid"] = 5,
["UPSorrowgrave"] = 3,
["MountsRemoved"] = 4,
["T11DruidRestoration"] = 4,
["PVP70PaladinProtection"] = 2,
["BlacksmithingMailFelIronChain"] = 5,
["EmblemofFrost"] = 3,
["SMLibraryLoot"] = 1,
["AuchShadowMurmur"] = 2,
["BRDGeneralAngerforge"] = 1,
["HellscreamsReach"] = 4,
["AhnkahetJedoga"] = 3,
["AVBlue"] = 1,
["T10PaladinHoly"] = 3,
["TrialoftheCrusaderTwinValkyrs"] = 3,
["PetsMerchant"] = 4,
["BCKeys"] = 2,
["T9Warlock"] = 3,
["PVP85DeathKnight"] = 4,
["DrakTharonKeepKingDred"] = 3,
["UtgardeKeepKeleseth"] = 3,
["MCRagnaros"] = 1,
["PVP80DeathKnight"] = 3,
["TKBotThorngrin"] = 2,
["TKEyeVoidReaver"] = 2,
["BWLLashlayer"] = 1,
["GruulGruul"] = 2,
["ICCLadyDeathwhisper"] = 3,
["ArchaeologyNerubian"] = 5,
["UBRSFLAME"] = 1,
["T9PaladinProtection"] = 3,
["PVP85PriestHoly"] = 4,
["HoORajh"] = 4,
["AlchemyMisc"] = 5,
["SmithingWeaponOld"] = 5,
["PVP85Weapons"] = 4,
["SCHOLOMardukVectus"] = 1,
["PVP60Accessories"] = 1,
["PVP60Weapons"] = 1,
["AB2039"] = 1,
["TKMechCapacitus"] = 2,
["PVP70Hunter"] = 2,
["PVP85ShamanRestoration"] = 4,
["T1T2Priest"] = 1,
["UldGalgannFirehammer"] = 1,
["HCRampOmor"] = 2,
["TailoringArmorCata"] = 5,
["T11WarriorProtection"] = 4,
["TabardsCardGame"] = 4,
["Thrallmar"] = 2,
["DMNChoRush"] = 1,
["JewelMeta"] = 5,
["TailoringFrostsavageBattlegear"] = 5,
["ToTStonespeaker"] = 4,
["HCHallsPorung"] = 2,
["VioletHoldXevozz"] = 3,
["T11Rogue"] = 4,
["BloodsailHydraxian"] = 1,
["Legendaries"] = 4,
["LeatherLeatherArmorWrath"] = 5,
["ICCSaurfang"] = 3,
["ArchaeologyVrykul"] = 5,
["HCRampVazruden"] = 2,
["BRDMagmus"] = 1,
["DMWImmolthar"] = 1,
["TheNexusOrmorok"] = 3,
["LBRSSpirestoneLord"] = 1,
["DS3Leather"] = 2,
["BlackrockCavernsTrash"] = 4,
["Naxx80Razuvious"] = 3,
["CardGame"] = 4,
["UBRSRend"] = 1,
["UlduarTrash"] = 3,
["STRATFrasSiabi"] = 1,
["BilgewaterCartel"] = 1,
["STRATBlackGuardSwordsmith"] = 1,
["MountsHorde"] = 4,
["JewelcraftingDailyPurple"] = 5,
["BWLFiremaw"] = 1,
["BRDGuzzler"] = 1,
["HallsofLightningTrash"] = 3,
["BlacksmithingPlateFelIronPlate"] = 5,
["Naxx80Maexxna"] = 3,
["TKArcScryer"] = 2,
["TrialoftheChampionConfessorPaletress"] = 3,
["EnchantingShield"] = 5,
["UtgardeKeepIngvar"] = 3,
["PVP85Misc"] = 4,
["HardModeLeather"] = 2,
["PVP85ShamanEnhancement"] = 4,
["T456ShamanEnhancement"] = 2,
["SmithingArmorCata"] = 5,
["PVP70ShamanElemental"] = 2,
["ValorPoints"] = 4,
["STRATStonespine"] = 1,
["EngineeringFirework"] = 5,
["GBTrash"] = 4,
["AlchemyFlask"] = 5,
["LeatherworkingLeatherThickDraenicA"] = 5,
["LeatherworkingLeatherStormshroudArmor"] = 5,
["PVP85ShamanElemental"] = 4,
["T9PriestHoly"] = 3,
["TKTrash"] = 2,
["SPKiljaeden"] = 2,
["FirstAid"] = 5,
["PetsQuest"] = 4,
["UBRSDrakkisath"] = 1,
["LeatherMailArmorWrath"] = 5,
["LBRSGrimaxe"] = 1,
["HoOAmmunae"] = 4,
["T10PriestHoly"] = 3,
["JewelChimerasEye"] = 5,
["UPPalehoof"] = 3,
["JewelcraftingDailyNeckRing"] = 5,
["EngineeringScope"] = 5,
["MaraudonLoot"] = 1,
["PVP85Hunter"] = 4,
}