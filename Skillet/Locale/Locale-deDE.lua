--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

-- German localizations provided by Farook (from wowinterface.com) and Stan (from wowace)

-- If you are doing localization and would like your name added here, please feel free
-- to do so, or let me know and I will be happy to add you to the credits
--[[
2009-10-14, RaverJK:
I did a complete review and proof reading  of the German translation. I changed a lot.
Many terms have been shortened to have the lables more intuitive and the descriptions
more... erm..  descriptive.
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "deDE")
if not L then return end

L[" days"] = " Tage"
L["ABOUTDESC"] = "Gibt Informationen über Skillet aus"
L["APPEARANCEDESC"] = "Einstelungen die das Aussehen von Skillet ändern"
L["About"] = "Über Skillet"
L["Appearance"] = "Aussehen"
L["Blizzard"] = "Blizzard"
L["Buy Reagents"] = "Reagenzien kaufen"
L["By Difficulty"] = "Nach Schwierigkeit"
L["By Item Level"] = "nach Item-Level"
L["By Level"] = "Nach Stufe"
L["By Name"] = "Nach Name"
L["By Quality"] = "Nach Qualität"
L["By Skill Level"] = "nach Schwierigkeitsgrad"
L["CONFIGDESC"] = "Öffnet ein Konfigurationsfenster für Skillet"
L["Clear"] = "Leeren"
L["Config"] = "Konfiguraton"
L["Could not find bag space for"] = "Kann keinen Taschenplatz finden für"
L["Crafted By"] = "Herstellbar von"
L["Create"] = "Erstellen"
L["Create All"] = "Alle erstellen"
L["DISPLAYREQUIREDLEVELDESC"] = "Wenn der hergestellte Gegenstand eine Charakter-Mindeststufe erfordert, wird die Stufe im Rezept angezeigt"
L["DISPLAYREQUIREDLEVELNAME"] = "Zeige benötigte Stufe"
L["DISPLAYSGOPPINGLISTATAUCTIONDESC"] = "Zeigt eine Liste der in deinen Taschen fehlenden Ragenzien, die für die Herstellung der Gegenstände in der Warteschlange benötigt werden."
L["DISPLAYSGOPPINGLISTATAUCTIONNAME"] = "Einkaufsliste im Auktionshaus"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Zeigt eine Liste der in deinen Taschen fehlenden Ragenzien, die für die Herstellung der Gegenstände in der Warteschlange benötigt werden."
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Einkaufsliste in der Bank"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Eine Einkaufsliste von Gegenständen anzeigen die benötigt werden um bereits in Auftrag gegebene Rezepte zu erstellen, sich aber nicht in deinen Taschen befinden"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Einkaufsliste an der Gildenbank anzeigen"
L["Delete"] = "Löschen"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "When enabled, recipe names will have one or more '+' characters appeneded to their name to inidcate the difficulty of the recipe." -- Requires localization
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Show recipe difficulty as text" -- Requires localization
L["Enabled"] = "Aktiviert"
L["Enchant"] = "Verzaubern"
L["FEATURESDESC"] = "Optionale Funktionen die ein- oder ausgeschaltet werden können."
L["Features"] = "Optionen"
L["Filter"] = "Filter"
L["Glyph "] = "Glyphe "
L["Gold earned"] = "Erhaltenes Gold"
L["Grouping"] = "Gruppierung"
L["Hide trivial"] = "Graue verstecken"
L["Hide uncraftable"] = "Nur herstellbare"
L["INVENTORYDESC"] = "Inventar-Information"
L["Include alts"] = "Twinks miteinbeziehen"
L["Inventory"] = "Inventar"
L["LINKCRAFTABLEREAGENTSDESC"] = "Wenn ein Reagenz für das aktuelle Rezept hergestellt werden kann, führt ein Klick auf das Reagenz zu dessen Rezept."
L["LINKCRAFTABLEREAGENTSNAME"] = "Reagenzien anklickbar"
L["Library"] = "Bibliothek"
L["Load"] = "Laden"
L["Move Down"] = "Move Down" -- Requires localization
L["Move Up"] = "Move Up" -- Requires localization
L["Move to Bottom"] = "Move to Bottom" -- Requires localization
L["Move to Top"] = "Move to Top" -- Requires localization
L["No Data"] = "Keine Daten"
L["No such queue saved"] = "No such queue saved" -- Requires localization
L["None"] = "Nichts"
L["Notes"] = "Notizen"
L["Number of items to queue/create"] = "Anzahl der Gegenstände in Warteschlange/zum Erstellen"
L["Options"] = "Optionen"
L["Pause"] = "Pause"
L["Process"] = "Start!"
L["Purchased"] = "Eingekauft"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Wenn ein Reagenz für das aktuelle Rezept hergestellt werden kann aber nicht genug fertige davon da sind, wird das Reagenz zur Warteschlange hinzugefügt."
L["QUEUECRAFTABLEREAGENTSNAME"] = "Herstellbare Reagenzien zur Warteschlange"
L["QUEUEGLYPHREAGENTSDESC"] = "If you can create a reagent needed for the current recipe, and don't have enough, then that reagent will be added to the queue. This option is separate for Glyphs only." -- Needs review
L["QUEUEGLYPHREAGENTSNAME"] = "Queue reagents for Glyphs" -- Needs review
L["Queue"] = "Warteschlange"
L["Queue All"] = "Alle in Warteschlange"
L["Queue is empty"] = "Queue is empty" -- Requires localization
L["Queue is not empty. Overwrite?"] = "Queue is not empty. Overwrite?" -- Requires localization
L["Queue with this name already exsists. Overwrite?"] = "Queue with this name already exsists. Overwrite?" -- Requires localization
L["Queues"] = "Queues" -- Requires localization
L["Really delete this queue?"] = "Really delete this queue?" -- Requires localization
L["Rescan"] = "Erneut scannen"
L["Retrieve"] = "Abfragen"
L["SCALEDESC"] = "Skalierung des Berufsfensters (Standard 1.0)"
L["SHOPPINGLISTDESC"] = "Zeigt die Einkaufsliste"
L["SHOWBANKALTCOUNTSDESC"] = "When calculating and displaying craftable item counts, include items from your bank and from your other characters" -- Requires localization
L["SHOWBANKALTCOUNTSNAME"] = "Bankfächer und andere Chars inkludieren"
L["SHOWCRAFTCOUNTSDESC"] = "Show the number of times you can craft a recipe, not the total number of items producable" -- Requires localization
L["SHOWCRAFTCOUNTSNAME"] = "Show craftable counts" -- Requires localization
L["SHOWCRAFTERSTOOLTIPDESC"] = "Zeigt im Tooltip eines Gegenstandes die Twinks an, die ihn herstellen können."
L["SHOWCRAFTERSTOOLTIPNAME"] = "Hersteller im Tooltip anzeigen"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Zeigt einen detaillierten Tooltip, wenn der Mauszeiger über ein Rezept auf der linken Seite gehalten wird."
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Detaillierter Tooltip für Rezepte"
L["SHOWFULLTOOLTIPDESC"] = "Display all informations about an item to be crafted. If you turn it off you will only see compressed tooltip (hold Ctrl to show full tooltip)" -- Needs review
L["SHOWFULLTOOLTIPNAME"] = "Standard-Tooltips verwenden"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Zeigt die benutzerdefinierten Notizen für einen Gegenstand im Tooltip an."
L["SHOWITEMNOTESTOOLTIPNAME"] = "Notizen im Tooltip"
L["SHOWITEMTOOLTIPDESC"] = "Display craftable item tooltip, instead of a recipe tooltip." -- Requires localization
L["SHOWITEMTOOLTIPNAME"] = "Den Gegenstandstooltip anzeigen wenn möglich"
L["SORTASC"] = "Sortiere aufsteigend"
L["SORTDESC"] = "Sortiere absteigend"
L["STANDBYDESC"] = "Toggle standby mode on/off" -- Requires localization
L["STANDBYNAME"] = "standby" -- Requires localization
L["SUPPORTEDADDONSDESC"] = "Unterstützte Addons die Dazu benutzt werden könnten oder benutzt werden um das Inventar aufzuzeichnen."
L["Save"] = "Speichern"
L["Scale"] = "Skalierung"
L["Scan completed"] = "Scan abgeschlossen"
L["Scanning tradeskill"] = "Scanne Berufe"
L["Select skill difficulty threshold"] = "Select skill difficulty threshold"
L["Selected Addon"] = "Gewähltes Addon"
L["Sells for "] = "Verkauf für "
L["Shopping List"] = "Einkaufsliste"
L["Skillet Trade Skills"] = "Skillet Trade Skills"
L["Sold amount"] = "Sold amount" -- Requires localization
L["Sorting"] = "Sortierung"
L["Source:"] = "Quelle:"
L["Start"] = "Start"
L["Supported Addons"] = "Unterstützte Addons"
L["TRANSPARAENCYDESC"] = "Transparenz des Skillet-Fensters"
L["This merchant sells reagents you need!"] = "Dieser Händler verkauft Reagenzien die du brauchst!"
L["Total Cost:"] = "Gesamtkosten:"
L["Total spent"] = "Ausgegeben total"
L["Trained"] = "Trained" -- Requires localization
L["Transparency"] = "Transparenz"
L["Unknown"] = "Unbekannt"
L["VENDORAUTOBUYDESC"] = "Hat ein Händler Reagenzien, die in der Einkaufsliste sind, werden diese automatisch gekauft."
L["VENDORAUTOBUYNAME"] = "Reagenzien automatisch kaufen"
L["VENDORBUYBUTTONDESC"] = "Hat ein Händler Reagenzien, die in der Einkaufsliste sind, wird eine Schaltfläche zum Kaufen der Reagenzien angezeigt."
L["VENDORBUYBUTTONNAME"] = "Kaufen-Schaltfläche beim Händler"
L["alts"] = "Reagenzien auf Twinks"
L["bank"] = "Reagenzien in der Bank"
L["buyable"] = "käuflich"
L["can be created from reagents in your inventory"] = "herstellbar mit den Reagenzien in deinem Inventar"
L["can be created from reagents in your inventory and bank"] = "herstellbar mit den Reagenzien in deinem Inventar und der Bank"
L["can be created from reagents on all characters"] = "herstellbar mit den Reagenzien auf allen Charakteren"
L["click here to add a note"] = "Hier klicken um eine Notiz hinzuzufügen"
L["craftable"] = "craftable" -- Requires localization
L["is now disabled"] = "ist jetzt deaktiviert"
L["is now enabled"] = "ist jetzt aktiviert"
L["not yet cached"] = "noch nicht im Cache"
L["reagents in inventory"] = "Reagenzien im Inventar"

