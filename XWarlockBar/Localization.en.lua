-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XWarlockBarButtonToggle:LeftButton"] = "Show/hide XWarlockBar";

-- Spells
XWarlockBarSpells = {
	"#Demons",
	"^688",--Summon Imp
	"^697",--Summon Voidwalker
	"^712",--Summon Succubus
	"^691",--Summon Felhunter
	"^30146",--Summon Felguard
	"^1122",--Summon Infernal
	"^18540",--Summon Doomguard
	"^126",--Eye of Kilrogg
	XBAR_SNOWRAP,
    "#Miscellaneous",
	"^1454",--Life Tap
	"^755",--Health Funnel
	"^1098",--Enslave Demon
	"^710",--Banish
	"^5500",--Sense Demons
	XBAR_SWRAP,
	"#Conjurables",
	"^48018",--Demonic Circle: Summon
	"^48020",--Demonic Circle: Teleport
	"^698",--Ritual of Summoning
	"^29893",--Ritual of Souls
	"^693",--Create Soulstone
	"^6201",--Create Healthstone
	XBAR_SNOWRAP,
	"#Curses",
	"^702",--Curse of Weakness
	"^1714",--Curse of Tongues
	"^18223",--Curse of Exhaustion
	"^1490",--Curse of the Elements
	XBAR_SNOWRAP,
	"#Banes",
	"^980",--Bane of Agony
	"^603",--Bane of Doom
	"^80240",--Bane of Havoc
};

XBAR_HELP_CONTEXT_XWarlockBar = XBarHelpGUI.ContextHeader("XWarlockBar").."Spells are organized by usage, check a spell to show or uncheck to hide it."

XBarCore.Localize(XWarlockBarSpells);