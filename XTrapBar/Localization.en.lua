-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XTrapBarButtonToggle:LeftButton"] = "Show/hide XTrapBar";

-- Traps
XTrapBarSpells = {
	"^77769",--Trap Launcher
	XBAR_SNOWRAP,
	"^13795",--Immolation Trap
	"^13813",--Explosive Trap
	"^1499",--Freezing Trap
	"^13809",--Ice Trap
	"^34600",--Snake Trap
};

XBAR_HELP_CONTEXT_XTrapBar = XBarHelpGUI.ContextHeader("XTrapBar").."Check a spell to show or uncheck to hide it."

XBarCore.Localize(XTrapBarSpells);