--------------------------------------------------------------------------------- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XMountBarButtonToggle:LeftButton"] = "Show/hide XMountBar";

XMOUNTBAR_MSG1="XMountBar: New mount learned";
XMOUNTBAR_MSG2=" mounts loaded.";
XMOUNTBAR_MSG3="XMountBar: Mounts not reported by WoW Client.  Type /reload to fix.";
XMOUNTBAR_MSG4=", type '/reload' to update.";
XMOUNTBAR_MSG5="XMountBar: Size adjusted";

XBAR_HELP_CONTEXT_XMountBar = XBarHelpGUI.ContextHeader("XMountBar").."The bar imports the first however many mounts automatically, set by the slider option NumMaxMounts.  "..
  "Importing a large amount may cause severe latency, you should use XCustomBar to create a bar with a lot of mounts.  You may show or hide "..
  "individual mounts, but only for the first number you specified, they are grouped in the menu in groups of 10.";

-- Since pets/mounts will be localized as retrieved from the game, there is no need to do any further localization.