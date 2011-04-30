-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XRogueBarButtonToggle:LeftButton"] = "Show/hide XRogueBar";

-- Spells
XRogueBarSpells = {
    "#Combat Abilities",
	"^36554",--Shadowstep
	"^51713",--Shadow Dance
	"^14177",--Cold Blood
	"^13877",--Blade Flurry
	"^14183",--Premeditation
	"^5171",--Slice and Dice
	"^13750",--Adrenaline Rush
	XBAR_SNOWRAP,
    "#Survival Abilities",
	"^14185",--Preparation
	"^1856",--Vanish
	"^5277",--Evasion
	"^31224",--Cloak of Shadows
	"^2094",--Blind
	"^1966",--Feint
	"^2983",--Sprint
	"^1766",--Kick
	XBAR_SNOWRAP,
    "#Crowd Control",
	"^1725",--Distract
	"^6770",--Sap
	XBAR_SNOWRAP,
    "#Miscellaneous",
	"^1784",--Stealth
	"^921",--Pick Pocket
	"^1804",--Pick Lock
	"^1842",--Disarm Trap
};

XBAR_HELP_CONTEXT_XRogueBar = XBarHelpGUI.ContextHeader("XRogueBar").."Spells are organized by type, check a spell to show or uncheck to hide it."

XBarCore.Localize(XRogueBarSpells);