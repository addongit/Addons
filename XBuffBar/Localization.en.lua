-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XBuffBarButtonToggle:LeftButton"] = "Show/hide XBuffBar";

-- Most of these buffs affect a party.  Some buffs that only affect the caster are included
-- if the class only has a few of them.  Warlocks and Rogues have so many other abilities
-- they will be in a separate bar.

-- Buffs
XBuffBarSpells = {
	-- Death Knight
	"#DEATHKNIGHT",
	"^3714",--Path of Frost
	"^48792",--Icebound Fortitude
	"^55233",--Vampiric Blood
	"^57330",--Horn of Winter
	"^51271",--Unbreakable Armor
	"^48707",--Anti-Magic Shell
	"^51052",--Anti-Magic Zone
	"^49222",--Bone Shield
	"^47568",--Empower Rune Weapon
	"^49028",--Dancing Rune Weapon
	"^42650",--Army of the Dead
	-- Druid Buffs
	"#DRUID",
	"^1126",--Mark of the Wild
	"^467",--Thorns
	"^5217",--Tiger's Fury
	"^22812",--Barkskin
	"^5209",--Challenging Roar
	"^61336",--Survival Instincts
	"^22842",--Frenzied Regeneration
	"^29166",--Innervate
	"^33891",--Tree of Life
	"^17116",--Nature's Swiftness
	-- Hunter Buffs
	"#HUNTER",
	"^51755",--Camouflage
	"^19574",--Bestial Wrath
	"^3045",--Rapid Fire
	"^23989",--Readiness
	"^5384",--Feign Death
	"^19263",--Deterrence
	-- Mage Buffs
	"#MAGE",
	"^130",--Slow Fall
	"^1459",--Arcane Brilliance
	"^61316",--Dalaran Brilliance
	"^543",--Mage Ward
	"^12051",--Evocation
	"^45438",--Ice Block
	"^11426",--Ice Barrier
	"^7302",--Ice Armor
	"^6117",--Mage Armor
	"^30482",--Molten Armor
	"^1463",--Mana Shield
	"^66",--Invisibility
	"^80353",--Time Warp
	-- Pally buffs
	"#PALADIN",
	"^1022",--Hand of Protection
	"^1044",--Hand of Freedom
    "^6940",--Hand of Sacrifice
	"^1038",--Hand of Salvation
	"^62124",--Hand of Reckoning
	"^19740",--Blessing of Might
	"^20217",--Blessing of Kings
	"^25780",--Righteous Fury
	"^31884",--Avenging Wrath
	"^498",--Divine Protection
	"^31821",--Aura Mastery
	"^20911",--Sanctuary
	"^54428",--Divine Plea
	"^642",--Divine Shield
	-- Priest Buffs
	"#PRIEST",
	"^1706",--Levitate
	"^15473",--Shadowform
	"^15286",--Vampiric Embrace
	"^588",--Inner Fire
	"^73413",--Inner Will
	"^89485",--Inner Focus
	"^21562",--Power Word: Fortitude
	"^17",--Power Word: Shield
	"^27683",--Shadow Protection
	"^64901",--Hymn of Hope
	"^6346",--Fear Ward
	"^10060",--Power Infusion
	"^33206",--Pain Suppression
	"^47585",--Dispersion
	"^47788",--Guardian Spirit
	"^87151",--Archangel
	"^14751",--Chakra
	-- Rogue Buffs
	-- Shaman buffs
	"#SHAMAN",
	"^8017",--Rockbiter Weapon
	"^8024",--Flametongue Weapon
	"^8033",--Frostbrand Weapon
	"^8232",--Windfury Weapon
	"^51730",--Earthliving Weapon
	"^324",--Lightning Shield
	"^974",--Earth Shield
	"^52127",--Water Shield
	"^546",--Water Walking
	"^131",--Water Breathing
	"^2825",--Bloodlust
	"^32182",--Heroism
	-- Warlock Buffs
	"#WARLOCK",
	"^687",--Demon Armor
	"^28176",--Fel Armor
	"^19028",--Soul Link
	"^6229",--Shadow Ward
	"^5697",--Unending Breath
	"^80398",--Dark Intent
	-- Warrior Buffs
	"#WARRIOR",
	"^6673",--Battle Shout
	"^1160",--Demoralizing Shout
	"^5246",--Intimidating Shout
	"^1161",--Challenging Shout
	"^469",--Commanding Shout
	"^12323",--Piercing Howl
	"^23920",--Spell Reflection
	"^85730",--Deadly Calm
	"^1134",--Inner Rage
	"^18499",--Berserker Rage
	"^871",--Shield Wall
	"^12975",--Last Stand
	"^55694",--Enraged Regeneration
	"^3411",--Intervene
	"^20230",--Retaliation
	"^1719",--Recklessness
	"^12328",--Sweeping Strikes
	"^50720",--Vigilance
};

-- Maximum bar size will be auto-calculated in the main section

XBarCore.Localize(XBuffBarSpells);

XBAR_HELP_CONTEXT_XBuffBar = XBarHelpGUI.ContextHeader("XBuffBar").."Spells are organized by class, check a spell to show or uncheck to hide it."

local i,v,p,s;

-- Auto-translate the class headers
for i,v in pairs(XBuffBarSpells) do
	if strsub(XBuffBarSpells[i],1,1)=="#" then
		s="";
		p=strfind(XBuffBarSpells[i],"-",2,true);
		if (p==nil) then
			p=strlen(XBuffBarSpells[i]);
		else
			s=strsub(XBuffBarSpells[i],p);
			p=p-1;
		end
		XBuffBarSpells[i]="#"..tostring(LOCALIZED_CLASS_NAMES_MALE[strsub(XBuffBarSpells[i],2,p)])..s;
	end
end
