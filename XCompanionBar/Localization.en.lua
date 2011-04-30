--------------------------------------------------------------------------------- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XCompanionBarButtonToggle:LeftButton"] = "Show/hide XCompanionBar";

XCOMPANIONBAR_MSG1="XCompanionBar: New companion learned";
XCOMPANIONBAR_MSG2=" companions loaded.";
XCOMPANIONBAR_MSG3="XCompanionBar: Companions not reported by WoW Client.  Type /reload to fix.";
XCOMPANIONBAR_MSG4=", type '/reload' to update.";
XCOMPANIONBAR_MSG5="XCompanionBar: Size adjusted";

XBAR_HELP_CONTEXT_XCompanionBar = XBarHelpGUI.ContextHeader("XCompanionBar").."The bar imports the first however many pets automatically, set by the slider option NumMaxPets.  "..
  "Importing a large amount may cause severe latency, you should use XCustomBar to create a bar with a lot of companions.  You may show or hide "..
  "individual companions, but only for the first number you specified, they are grouped in the menu in groups of 10.";

-- Since pets/mounts will be localized as retrieved from the game, there is no need to do any further localization.