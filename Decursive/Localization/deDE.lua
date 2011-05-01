--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/?to=decursive.php )

    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

--[=[
--			YOUR ATTENTION PLEASE
--
--	   !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--	################################################################
--	#  http://wow.curseforge.com/projects/decursive/localization/  #
--	################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

if not DcrLoadedFiles or not DcrLoadedFiles["enUS.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "deDE");

if not L then
    DcrLoadedFiles["deDE.lua"] = "2.4.0.2";
    return;
end;


L["ABOLISH_CHECK"] = "Zuvor überprüfen ob Reinigung nötig"
L["ABSENT"] = "Fehlt (%s)"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Zeige Anzahl der Betroffenen: "
L["ANCHOR"] = "Decursive Textfenster"
L["BINDING_NAME_DCRPRADD"] = "Ziel zur Prioritätenliste hinzufügen"
L["BINDING_NAME_DCRPRCLEAR"] = "Prioritätenliste leeren"
L["BINDING_NAME_DCRPRLIST"] = "Prioritätenliste ausgeben"
L["BINDING_NAME_DCRPRSHOW"] = "Zeige/Verstecke die Prioritätenliste UI"
L["BINDING_NAME_DCRSHOW"] = "Zeige/Verstecke Decursive Main Bar"
L["BINDING_NAME_DCRSKADD"] = "Ziel zur Ignorierliste hinzufügen"
L["BINDING_NAME_DCRSKCLEAR"] = "Ignorierliste leeren"
L["BINDING_NAME_DCRSKLIST"] = "Ignorierliste ausgeben"
L["BINDING_NAME_DCRSKSHOW"] = "Zeige/Verstecke die Ignorierliste UI"
L["BLACK_LENGTH"] = "Sekunden auf der Blacklist: "
L["CHARMED"] = "Verführung"
L["CLASS_HUNTER"] = "Jäger"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["CTRL"] = "Strg"
L["CURE_PETS"] = "Scanne und reinige Pets"
L["CURSE"] = "Fluch"
L["DEFAULT_MACROKEY"] = "NONE"
L["DISEASE"] = "Krankheit"
L["DONOT_BL_PRIO"] = "Keine Namen der Prioritätenliste bannen"
L["GLOR1"] = "In Gedenken an Glorfindal"
L["GLOR2"] = [=[Decursive ist Bertrand gewidmet, der uns viel zu früh verlassen hat.
Er wird immer in Erinnerung bleiben.]=]
L["GLOR3"] = [=[In Gedenken an Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[Freundschaft und Zuneigung habrn ihre Wurzeln überall, die, die Glorfindal in World of Warcraft getroffen haben kennen einen Menschen großen Einsatzes und einen charismatischen Leiter.

Er war im echten Leben wie im Spiel, Selbstlos, Gro0zügig, immer für seine Freunde da und vor allem ein passinierter Mensch.

Er verließ uns mit 38 und lies nicht nur Anonyme Spieler in einer Virtuellen Welt, sondern echte Freunde zurück, die ihn immer vermissen werden.]=] -- Needs review
L["GLOR5"] = "Er wird immer in Erinnerung bleiben..."
L["HIDE_LIVELIST"] = "Verstecke die Live-Liste"
L["HIDE_MAIN"] = "Verstecke Decursive Fenster"
L["HLP_LEFTCLICK"] = "Linksklick"
L["HLP_MIDDLECLICK"] = "Mittlere Maustaste"
L["HLP_NOTHINGTOCURE"] = "Es gibt nichts zu Heilen!"
L["HLP_RIGHTCLICK"] = "Rechtsklick"
L["HLP_USEXBUTTONTOCURE"] = "Benutze \"%s\" um dieses Gebrechen zu Heilen!"
L["HLP_WRONGMBUTTON"] = "Falscher Mausbutton!"
L["IGNORE_STEALTH"] = "Ignoriere getarnte Einheiten"
L["IS_HERE_MSG"] = "Decursive wurde geladen, kontrolliere bitte die Einstellungen"
L["MAGIC"] = "Magie"
L["NOSPELL"] = "Kein Zauber verfügbar"
L["OPT_DEBUFFENTRY_DESC"] = "Auswählen welche Klasse im Kampf ignoriert werden soll wenn sie von dieser Krankheit betroffen ist."
L["OPT_DISPLAYOPTIONS"] = "Anzeigeoptionen"
L["OPT_HIDEMFS_GROUP"] = "Solo/Gruppe"
L["OPT_HIDEMFS_NEVER"] = "Nie"
L["OPT_HIDEMFS_NEVER_DESC"] = "Das MUF-Fenster nie automatisch verstecken."
L["OPT_HIDEMFS_SOLO"] = "Solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Das MUF-Fenster verstecken wenn du in keiner Gruppe oder Raidgruppe bist."
L["OPTION_MENU"] = "Decursive Einstellungen"
L["OPT_LIVELIST"] = "Live-Liste"
L["OPT_LIVELIST_DESC"] = "Optionen für die Live-Liste"
L["OPT_LLALPHA"] = "Transparenz Live-Liste"
L["OPT_LLSCALE"] = "Skalierung der Live-Liste"
L["OPT_LVONLYINRANGE"] = "Nur Einheiten in Reichweite"
L["OPT_MESSAGES"] = "Nachrichten"
L["OPT_MFALPHA"] = "Transparenz"
L["OPT_MUFSCOLORS"] = "Farben"
L["OPT_UNITPERLINES_DESC"] = "Definiert die max. Anzahl an Micro-Unitframes die pro Zeile angezeigt werden sollen."
L["OPT_USERDEBUFF"] = "Diese Krankheit ist nicht Teil von Decursive's standardmässigen Krankheiten."
L["OPT_XSPACING"] = "Horizontaler Abstand"
L["OPT_XSPACING_DESC"] = "Den horizontalen Abstand zwischen MUFs festlegen."
L["OPT_YSPACING"] = "Vertikaler Abstand"
L["OPT_YSPACING_DESC"] = "Den vertikalen Abstand zwischen MUFs festlegen."
L["PLAY_SOUND"] = "Akustische Warnung falls Reinigung nötig"
L["POISON"] = "Gift"
L["POPULATE"] = "P"
L["POPULATE_LIST"] = "Schnellbestücken der Decursive Liste"
L["PRINT_CHATFRAME"] = "Nachrichten im Chat ausgeben"
L["PRINT_CUSTOM"] = "Nachrichten in Bildschirmmitte ausgeben"
L["PRINT_ERRORS"] = "Fehlernachrichten ausgeben"
L["PRIORITY_LIST"] = "Decursive Prioritätenliste"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Reinige in zufälliger Reihenfolge"
L["REVERSE_LIVELIST"] = "Zeige die Live-Liste umgekehrt"
L["SCAN_LENGTH"] = "Sekunden zwischen Live-Scans: "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Um das Decursive Fenster anzuzeigen, /dcrshow eingeben"
L["SHOW_TOOLTIP"] = "Zeige Tooltips in der Betroffenenliste"
L["SKIP_LIST_STR"] = "Decursive Ignorierliste"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "Zauber %s gefunden!"
L["STEALTHED"] = "Getarnt"
L["STR_CLOSE"] = "Schließen"
L["STR_DCR_PRIO"] = "Decursive Prioritätenliste"
L["STR_DCR_SKIP"] = "Decursive Ignorierliste"
L["STR_GROUP"] = "Gruppe "
L["STR_OPTIONS"] = "Einstellungen"
L["STR_OTHER"] = "Sonstige"
L["STR_POP"] = "Bestückungsliste"
L["STR_QUICK_POP"] = "Schnellbestücken"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00Erfolgreich bei|r %s"
L["TARGETUNIT"] = "Zieleinheit"
L["UNITSTATUS"] = "Einheitenstatus:"



DcrLoadedFiles["deDE.lua"] = "2.4.0.2";
