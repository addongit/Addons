-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XPetStuffBarButtonToggle:LeftButton"] = "Show/hide XPetStuffBar";

-- Pet Skills
XPetStuffBarSpells = {
	"#XP Bar",
	"*XPBar",
	"*XPBarText",
	"*XPBarHorizontal",
	"#PetStuffBar",
	"^1515",--Tame Beast
	"^2641",--Dismiss Pet
	"^6991",--Feed Pet
	"^136",--Mend Pet
	"^982",--Revive Pet
	"^1462",--Beast Lore
	"^6197",--Eagle Eye
	"^19574",--Bestial Wrath
	"^19577",--Intimidation
	"^34026",--Kill Command
	"^53271",--Master's Call
};

--Eagle eye isn't really a pet ability, but meh, what the hell.

XBAR_HELP_CONTEXT_XPetStuffBar = XBarHelpGUI.ContextHeader("XPetStuffBar").."PetStuffBar spells are in the submenu for PetStuffBar, check a spell to show or uncheck to hide it.\n"..
  "There is also a pet experience bar, you may configure under the XP Bar submenu:\n"..
  "* XPBar - Shows/Hides the Pet Experience Bar\n"..
  "* XPBarText - Shows your pet's experience in numbers on the bar.\n"..
  "* XPBarHorizontal - Orients the bar horizontally if true, vertically if false.";

XBarCore.Localize(XPetStuffBarSpells);