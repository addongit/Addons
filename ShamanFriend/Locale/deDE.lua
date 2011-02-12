
local L = LibStub("AceLocale-3.0"):NewLocale("ShamanFriend", "deDE", false);
if not L then return end

-- Options
L["Options for ShamanFriend"] = "Optionen f\195\188r ShamanFriend"

L["Show UI"] = "Optionen anzeigen"
L["Shows the Graphical User Interface"] = "Zeigt die Optionen an"

L["Show version"] = true

L["Alerts"] = "Alarme"
L["Settings for Elemental Shields and Weapon Enchants."] = "Einstellungen f\195\188r Elementarschilde und Waffenverzauberungen"
L["Elemental Shield"] = "Elementar Schild"
L["Toggle check for Elemental Shield."] = "\195\156berpr\195\188fung auf Elementarschilde an/aus"
L["Toggle Earth Shield tracking on other targets than yourself."] = true
L["Weapon Enchant"] = "Waffen Verzauberung"
L["Toggle check for Weapon Enchants."] = "\195\156berpr\195\188fung auf Waffenverzauberungen an/aus"
L["Enter Combat"] = true
L["Notify when entering combat."] = true
L["After Combat"] = true
L["Notify after the end of combat."] = true
L["No Mounted"] = "Aufgesessen"
L["No Vehicle"] = true
L["Disable notifications when mounted."] = "Benachrichtigungen wenn aufgesessen abschalten"
L["Disable notifications when in a vehicle."] = true
L["Sound"] = "Sound"
L["Play a sound when a buff is missing."] = "Sound abspielen wenn Buffs fehlen" 
L["Maelstrom Weapon"] = "Waffe des Mahlstroms"
L["Toggle Maelstrom information."] = true
L["Lava Surge"] = true
L["Toggle Lava Surge information."] = true
L["Fulmination"] = true
L["Alert when lightning shield hits 9 stacks."] = true
L["Play a sound when a proc occurs."] = true
L["Ding"] = "Ding"
L["Dong"] = "Dong"
L["Dodo"] = "Dodo"
L["Bell"] = "Glocke"
L["None"] = "Keinen"
		
L["Display"] = "Anzeige"
L["Settings for how to display the message."] = "Einstellen wie und wann Alarme angezeigt werden"
L["Color"] = "Farbe"
L["Sets the color of the text when displaying messages."] = "Stellt die Farbe des Texts ein in dem Benachrichtigungen angezeigt werden"
L["Scroll output"] = "Scrollen"
L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"] = true
L["Frames output"] = "Fenster"
L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"] = true
-- "Anzeige der Nachrichten in anderen Fenstern ein/ausschalten. Falls diese Option ausgeschaltet ist werden Nachrichten nur in SCT/MSBT angezeigt. (dies beinhaltet auch Chatfenster)"
L["Time to display message"] = "Zeit, wie lange die Nachricht angezeigt werden soll"
L["Set the time the message will be displayed (5=default)"] = "Bestimme die Zeit, wie lange die Nachricht angezeigt werden soll (5=Standard)"
						
L["Spells"] = "Zauber"
L["Settings regarding different spells."] = "Einstellungen verschiedener Zauber"
L["Purge"] = "Reinigen"
L["Toggle Purge information."] = "Reinigen Warnung an/aus"
L["Broadcast Purge"] = "\195\156ber Reinigen informieren"
L["Broadcast Purge message to the following chat. (Above option must be enabled)"] ="Eine Nachricht \195\188ber die Reinigung an das folgende Chatfenster senden. (informieren muss aktiviert sein)"
L["Raid"] = "Raid"
L["Party"] = "Gruppe"
L["Battleground"] = true
L["Raid Warning"] = "Raidwarnung"
L["Interrupt"] = "Windstoß"
L["Toggle Interrupt information."] = true
L["Broadcast Interrupt"] = true
L["Broadcast Interrupt message to the following chat. (Above option must be enabled)"] = "Eine Nachricht \195\188ber Erdschock an das folgende Chatfenster senden. (informieren muss aktiviert sein)"
L["Grounding Totem"] = "Totem der Erdung"
L["Toggle message when Grounding Totem absorbs a spell."] = "Anzeige von geerdeten Zaubern an/aus"
L["Ground self only"] = true
L["Only show grounding message for your own Grounding Totem"] = true
L["Broadcast Grounding Totem"] = "\195\188ber Totem der Erdung informieren"
L["Broadcast Grounding Totem message to the following chat. (Above option must be enabled)"] = "Eine Nachricht \195\188ber Totem der Erdung an das folgende Chatfenster senden. (informieren muss aktiviert sein)"
L["Add target"] = "Ziel hinzufügen"
L["Add the target to the end of the message when broadcasting."] = "Füge das Ziel ans Ende der Nachricht beim Senden"
L["Bloodlust message"] = "Kampfrausch Nachricht"
L["Send a message when Bloodlust/Heroism is cast."] = "Sende eine Nachricht beim Wirken von Kampfrausch/Heldentum"
L["Bloodlust text"] = "Kampfrausch Text"
L["The text in the message when Bloodlust/Heroism is cast."] = "Text in der Nachricht, wenn Kampfrausch/Heldentum gewirkt wird"
L["Bloodlust chat"] = "Kampfrausch Chatfenster"
L["Chat for the Bloodlust/Heroism message."] = "Chatfenster f\195\188r die Kampfrausch/Heldentum Nachricht"
L["Yell"] = "Rufen"
L["Say"] = "Sagen"
L["Mana Tide message"] = "Totem der Manaflut Nachricht"
L["Send a message when Mana Tide is cast."] = "Sende eine Nachricht beim Wirken von Totem der Manaflut"
L["Mana Tide text"] = "Totem der Manaflut Text"
L["The text in the message when Mana Tide is cast."] = "Text in der Nachricht, wenn Totem der Manaflut gewirkt wird"
L["Mana Tide chat"] = "Totem der Manaflut Chat"
L["Chat for the Mana Tide message."] = "Chatfenster f\195\188r die Totem der Manaflut Nachricht"
L["Feral Spirit message"] = "Wildgeist Nachricht"
L["Send a message when Feral Spirit is cast."] = "Sende eine Nachricht beim Wirken von Wildgeist"
L["Feral Spirit text"] = "Wildgeist Text"
L["The text in the message when Feral Spirit is cast."] = "Text in der Nachricht, wenn Wildgeist gewirkt wird"
L["Feral Spirit chat"] = "Wildgeist Chat"
L["Chat for the Feral Spirit message."] = "Chatfenster f\195\188r die Wildgeist Nachricht"
L["Dispel"] = true
L["Toggle message when dispel is cast."] = true
L["Broadcast Dispel"] = true
L["Broadcast dispel message to the following chat. (Above option must be enabled)"] = true
 
L["General Display"] = "Allgemeine Einstellungen"
L["General Display settings and options for the Custom Message Frame."] = "Allgemeine Einstellungen und Optionen f\195\188r das Anzeigefenster"
L["In Chat"] = "Im Chat"
L["Display message in Chat Frame."] = "Benachrichtigung im Chat Fenster anzeigen"
L["Chat number"] = "Chatnummer"
L["Choose which chat to display the messages in (0=default)."] = "Chatfenster, in dem die Nachrichten angezeigt werden sollen (0=Standard)"
L["On Screen"] = "Bildschirm"
L["Display message in Blizzard UI Error Frame."] = "Benachrichtigungen im eigenen Fenster anzeigen"
L["Custom Frame"] = "Eigenes Fenster"
L["Display message in Custom Message Frame."] = "Benachrichtigungen im eigenen Fenster anzeigen"
L["Font Size"] = "Schriftgr\195\182\195\159e"
L["Set the font size in the Custom Message Frame."] = "Schriftgr\195\182\195\159e im eigenen Fenster einstellen"
L["Font Face"] = "Schriftart"
L["Set the font face in the Custom Message Frame."] = "Schriftart im eigenen Fenster einstellen"
L["Normal"] = "Normal"
L["Arial"] = "Arial"
L["Skurri"] = "Skurri"
L["Morpheus"] = "Morpheus"
L["Font Effect"] = "Schriftstil"
L["Set the font effect in the Custom Message Frame."] = "Schriftstil im eigenen Fenster einstellen"
L["OUTLINE"] = "Umrandet"
L["THICKOUTLINE"] = "Dick umrandet"
L["MONOCHROME"] = "Einfarbig"
L["Lock"] = "Sperren"
L["Toggle locking of the Custom Message Frame."] = "Eigenes Fensters sperren an/aus"
L["BG Announce"] = true
L["Announce when in battlegrounds."] = true
L["Arena Announce"] = true
L["Announce when in arena."] = true
L["5-man Announce"] = true
L["Announce when in a 5-man instance."] = true
L["Raid Announce"] = true
L["Announce when in a raid instance."] = true
L["World Announce"] = true
L["Announce when not in instances."] = true

L["Windfury"] = "Windzorn"
L["Settings for Windfury counter."] = "Einstellungen f\195\188r Waffe des Windzorns"
L["Enable"] = "Einschalten"
L["Enable WF hit counter."] = "Windzorn Treffer z\195\164hlen an/aus"
L["Crit"] = "Krit"
L["Enable display of WF crits."] = "Anzeige von Windzorn Krits einschalten"
L["Miss"] = "Verfehlen"
L["Enable display of WF misses."] = "Anzeige von Windzorn Verfehlen einschalten"
L["Hand"] = true
L["Show which hand the proc comes from"] = true

L["Lightning Overload"] = "Blitz\195\188berladung"
L["Settings for Lightning Overload."] = "Einstellungen f\195\188r Blitz\195\188berladung"
L["Toggle whether to show a message when Lightning Overload procs."] = "Anzeige f\195\188r Ausl\195\182sen der Blitz\195\188berladung ein/ausschalten"
L["Use alternative method"] = "Alternative Methode benutzen"
L["Uses an alternative method to detect LO procs. (Works better in raids, but can be delayed, and damage will probably break)"] = "Benutzt eine alternative Methode f\195\188r Blitz\195\188berladung. (Besser f\195\188r Schlachtgruppen, kann aber verz\195\182gern und Schaden wird vermutlich gebrochen)"
L["Damage"] = "Schaden"
L["Enable display of Lightning Overload total damage."] = "Anzeige f\195\188r kompletten Blitz\195\188berladungsschaden an/aus"
L["Enable display of Lightning Overload crits."] = "Anzeige der kritischen Treffer der Blitz\195\188berladung einschalten"
L["Enable display of Lightning Overload misses."] = "Anzeige der verfehlen Treffer der Blitz\195\188berladung einschalten"
L["No Lightning Capacitator"] = "Kein Blitzkondensator"
L["Attempt to remove procs coming from the Lightning Capacitator trinket. (Does not always work, and can cause the damage from dual procs to be a bit off)"] = "Versucht Treffer des Blitzkondensators zu unterdr\195\188cken. (Funktioniert nicht immer und kann den Schaden von zweifachen Treffern verringern)"

L["Earth Shield"] = true
L["Settings for Earth Shield."] = true
L["Toggle Earth Shield tracker"] = true
L["Lock tracker"] = true
L["Lock Earth Shield tracker."] = true
L["Disable tooltip"] = true
L["Disable Earth Shield tracker tooltip."] = true
L["Button only"] = true
L["Show only the Earth Shield button."] = true
L["Alert when fading"] = true
L["Alert me when Earth Shield fades from my target."] = true
L["Play a sound when Earth Shield fades from my target."] = true

L["CC"] = true
L["Settings for Crowd Control."] = true
L["Success"] = true
L["Display when successfully CCing a target."] = true
L["Success text"] = true
L["TARGET = CC target"] = true
L["The text in the message when CC succeeds."] = true
L["Fail"] = true
L["Display when CCing a target fails."] = true
L["Fail text"] = true
L["The text in the message when CC fails."] = true
L["Remove"] = true
L["Display when CC is removed from a target."] = true
L["Remove text"] = true
L["The text in the message when CC is removed."] = true
L["Broadcast CC"] = true
L["Broadcast CC message to the following chat. (Above option must be enabled)"] = true
L["Broken"] = true
L["Display when CC is broken."] = true
L["Broken text"] = true
L["The text in the message when CC is broken."] = true
L["Broadcast Broken CC"] = true
L["Broadcast Broken CC message to the following chat. (Above option must be enabled)"] = true
L["Tank break time"] = true
L["Do not warn if the tank breaks CC after this time"] = true
L["Play a sound when CC fades from my target."] = true
L["SOURCE = Source of break, TARGET = CC target"] = true
L[" faded from "] = true
L[" broke SPELL on "] = true

-- L["Totems"] = true
-- L["Settings for Totems."] = true
-- L["Warn on kill"] = true
-- L["Shows a message whenether one of your totems are killed."] = true
-- L["Broadcast on kill"] = true
-- L["Broadcast to the following chat when one of your totems are killed. (Above option must be enabled)"] = true

L["Miscellaneous"] = "Diverses"
L["Various other small notices/usefull functions."] = "Verschiedene kleine Anzeigen/brauchbare Funktionen"
L["Elemental T5 2-piece bonus"] = "Elementar T5 2-Teile Bonus"
L["Show a message when you get the proc from the Elemental Tier5 2-piece bonus"] = "Zeige eine Nachricht beim Erhalten des Elementar Tier5 2-Teile Bonus"
L["Enhancement T5 2-piece bonus"] = "Verst\195\164rkung T5 2-Teile Bonus"
L["Show a message when you get the proc from the Enhancement Tier5 2-piece bonus"] = "Zeige eine Nachricht beim Erhalten des Verst\195\164rkung Tier5 2-Teile Bonus"
L["Restoration T5 4-piece bonus"] = "Wiederherstellung T5 4-Teile Bonus"
L["Show a message when you get the proc from the Restoration Tier5 4-piece bonus"] = "Zeige eine Nachricht beim Erhalten des Wiederherstellung Tier5 4-Teile Bonus"

-- More
L[" faded"] = " ist abgelaufen"
L["Main Hand Enchant faded"] = "Waffenhandverzauberung abgelaufen"
L["Off Hand Enchant faded"] = "Nebenhandverzauberung abgelaufen"
L["Weapon Enchant faded"] = true
L["Your Earth Shield faded from %s"] = "Dein Erdschild schwindet von %s"

L["Interrupted: %s"] = "Unterbrochen: %s"
L["Killed: "] = true

-- LO
L["Lightning Overload"] = "Blitz\195\188berladung"
L["DOUBLE Lightning Overload"] = "DOPPELTE Blitz\195\188berladung"
L["Lava Burst Overload"] = true
L["Chain Lightning Overload"] = true
L["DOUBLE Chain Lightning Overload"] = true
L["TRIPLE Chain Lightning Overload"] = true
L[" CRIT"] = "KRITISCHER TREFFER"
L[" DOUBLE CRIT"] = "DOPPELTER KRITISCHER TREFFER"
L["Electrical Charge"] = "Elektrische Aufladung"
	
-- WF
L["Windfury"] = "Windzorn"
L["MH Windfury"] = true
L["OH Windfury"] = true
L[" Single crit: "] = " Einzelkrit: "
L[" DOUBLE crit: "] = " DOPPELKRIT: "
L[" TRIPLE crit: "] = " DREIFACHKRIT: "
L[" QUADRUPLE crit: "] = true
L[" QUINTUPLE crit: "] = true
L[" miss"] = " verfehlt"
L[" proc kill"] = true

-- Purge
L["Purge: "] = "Reinigen: "
L["Dispel: "] = true
	
-- Grounding Totem
L["Ground: " ] = "Geerdet: "
	
-- Cooldowns
L["Elemental Mastery"] = true
L["Mana Tide Totem"] = true
L["Bloodlust"] = true
L["Windfury"] = true
L["Nature's Swiftness"] = true
L["Reincarnation"] = true
L["Chain Lightning"] = true
L["Shocks"] = true
L["Fire Elemental Totem"] = true
L["Earth Elemental Totem"] = true
L["Grounding Totem"] = true
L["Eartbind Totem"] = true
L["Stoneclaw Totem"] = true
L["Fire Nova Totem"] = true
L["Astral Recall"] = true
L["Healthstone"] = true
L["Potions"] = true
L["Stormstrike"] = true
	
-- Missing
L["Missing: Elemental Shield"] = "Kein Elementarschild aktiv"
L["Missing: Main Hand Enchant"] = "Keine Waffenhandverzauberung"
L["Missing: Off Hand Enchant"] = "Keine Nebenhandverzauberung"

-- T5 2-piece set bonus
L["Gained set bonus"] = "Set Bonus erhalten"
	
-- Earth Shield frame
L["Charges: "] = "Aufladungen: "
L["Target: "] = "Ziel: "
L["Time: "] = "Zeit: "
L["Outside group"] = "Au\195\159erhalb Gruppe"
L[" min"] = " min"
L["Shaman Friend ES Tracker"] = "Shaman Friend ES \195\156berwachung"
L["Earth Shield faded from "] = true
L["Killed: "] = true
	
-- Font Face
L["FRIZQT__.TTF"] = "FRIZQT__.TTF"
L["ARIALN.TTF"] = "ARIALN.TTF"
L["skurri.ttf"] = "skurri.ttf"
L["MORPHEUS.ttf"] = "MORPHEUS.ttf"
