--[[
   à : \195\160    è : \195\168    ì : \195\172    ò : \195\178    ù : \195\185
   á : \195\161    é : \195\169    í : \195\173    ó : \195\179    ú : \195\186
   â : \195\162    ê : \195\170    î : \195\174    ô : \195\180    û : \195\187
   ã : \195\163    ë : \195\171    ï : \195\175    õ : \195\181    ü : \195\188
   ä : \195\164                    ñ : \195\177    ö : \195\182
   æ : \195\166                                    ø : \195\184
   ç : \195\167                                    œ : \197\147
   Ä : \195\132    Ö : \195\150    Ü : \195\156    ß : \195\159

]]

SC_SPELL_SND = GetSpellInfo(5171);
SC_SPELL_TOT = GetSpellInfo(57934);
SC_SPELL_VEN = GetSpellInfo(79140);
SC_SPELL_DP = GetSpellInfo(2818);
SC_SPELL_ENV = GetSpellInfo(32645);
SC_SPELL_REC = GetSpellInfo(73651);

SC_SPELL_EA = GetSpellInfo(8647);
SC_SPELL_SA = GetSpellInfo(7386);
SC_SPELL_FF = GetSpellInfo(91565);

SC_SPELL_RUP = GetSpellInfo(1943);
SC_SPELL_GAR = GetSpellInfo(703);

--Not really usefull now but...
SC_SPELL_DRUIDE_LAC = GetSpellInfo(33745);
SC_SPELL_DRUIDE_POU = GetSpellInfo(9007);
SC_SPELL_DRUIDE_RIP = GetSpellInfo(1079);
SC_SPELL_DRUIDE_RAK = GetSpellInfo(1822);
SC_SPELL_HUNTER_PSH = GetSpellInfo(53234);
--SC_SPELL_HUNTER_CAT = GetSpellInfo(59881)"Griffure";
--SC_SPELL_HUNTER_RAP = GetSpellInfo()"Pourfendeur sauvage";
SC_SPELL_WARRIOR_DWO = GetSpellInfo(43100);
SC_SPELL_WARRIOR_REN = GetSpellInfo(94009);

if (GetLocale() == "frFR") then
	SC_LANG_CP = "Combo Points";
	SC_LANG_SETTINGS = "Options";
	SC_DISPLAY_SETTINGS = "Options d'affichage"
	SC_LANG_SOUND = "Options de son";
else
	if (GetLocale() == "deDE") then
		SC_LANG_CP = "Combo Points";
		SC_LANG_SETTINGS = "Einstellungen";
		SC_DISPLAY_SETTINGS = "Display settings"
		SC_LANG_SOUND = "Sound settings";
	else
		if (GetLocale() == "esES" or GetLocale() == "esMX") then
			SC_LANG_CP = "Combo Points";
			SC_LANG_SETTINGS = "Ajustes";
			SC_DISPLAY_SETTINGS = "Display settings"
			SC_LANG_SOUND = "Sound settings";
		else
			if (GetLocale() == "ruRU") then
				SC_LANG_CP = "Combo Points";
				SC_LANG_SETTINGS = "Установки";
				SC_DISPLAY_SETTINGS = "Display settings"
				SC_LANG_SOUND = "Sound settings";
			else
				SC_LANG_CP = "Combo Points";
				SC_LANG_SETTINGS = "Settings";
				SC_DISPLAY_SETTINGS = "Display settings"
				SC_LANG_SOUND = "Sound settings";
			end
		end
	end
end