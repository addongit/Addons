-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XSealBarButtonToggle:LeftButton"] = "Show/hide XSealBar";

-- Seals
XSealBarSpells = {
	"^853",--Hammer of Justice
	"^24275",--Hammer of Wrath
	"^20271",--Judgement
	"^20154",--Seal of Righteousness
	"^20164",--Seal of Justice
	"^20165",--Seal of Insight
	"^31801",--Seal of Truth
};

XBAR_HELP_CONTEXT_XSealBar = XBarHelpGUI.ContextHeader("XSealBar").."Check a spell to show or uncheck to hide it."

XBarCore.Localize(XSealBarSpells);
