-------------------------------------------------------
-- Local variables and Loaded Message
-------------------------------------------------------
local MB = "|cffe1a500Marking|cff69ccf0Bar|cffffffff"  -- MB Title
local MBF = "|cffe1a500MB|cff69ccf0Flares|cffffffff"   -- MBFlares Title
local versionNum = GetAddOnMetadata("MarkingBar", "Version")
local curVer = "|cffffffff "..versionNum.."|cffe1a500"      -- Version Number

DEFAULT_CHAT_FRAME:AddMessage(MB..curVer..' is loaded.')
DEFAULT_CHAT_FRAME:AddMessage(MB..' Use /mb to access the options panel.')


-------------------------------------------------------
-- Databases with Variable Options and Backdrops
-------------------------------------------------------
MBDB = {
    shown = true,
    aloneShow = true,
	partyShow = true,
    raidShow = true,
	locked = false,
	ctrlLock = true,
	clamped = true,
	flipped = false,
	vertical = false,
	bgHide = false,
	tooltips = true,
	scale = 1,
	alpha = 1,
	msg_intro = "I will use the following marks:", --Remember to change below if you change here!!!
	msg_skull = "Kill",
	msg_cross = "then kill",
	msg_square = "Hunter - Freezing Trap",
	msg_moon = "Mage - Polymorph",
	msg_triangle = "Druid - Hibernate",
	msg_diamond = "Warlock - Seduce/Banish/Enslave Demon",
	msg_circle = "Priest - Shackle/Mind Control",
	msg_star = "Rogue - Sap",
	msg_footer = "Input other miscellaneous text to send here.",
	announce_intro = true,
	announce_skull = true,
	announce_cross = true,
	announce_square = true,
	announce_moon = true,
	announce_triangle = true,
	announce_diamond = true,
	announce_circle = true,
	announce_star = true,
    announce_footer = false,
    announce_tooltips = false,
}

MBCtrlDB = {
    shown = true,
    aloneShow = true,
	partyShow = true,
    raidShow = true,
	locked = true,
	clamped = true,
	vertical = false,
	bgHide = false,
	tooltips = true,
	scale = 1,
	alpha = 1,
}
    
MBFlaresDB = {
	shown = true,
    aloneShow = true,
	partyShow = true,
    raidShow = true,
	locked = false,
	clamped = true,
	flipped = false,
	vertical = false,
	bgHide = false,
	tooltips = true,
	scale = 1,
	alpha = 1,
    announce_rw = false,
    msg_rw = "Please look at raid chat to see raid mark descriptions.",
}
 
local MB_clear_flag = false;
 
local defaultBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4,}
}
local borderlessBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	tile = true,
	tileSize = 16
}

local editBoxBackdrop = {
	bgFile = "Interface\\COMMON\\Common-Input-Border",
	tile = false,
}

-------------------------------------------------------
-- MB Main Frame and Movers
-------------------------------------------------------

MB_mainFrame = CreateFrame("Frame", "MB_mainFrame", UIParent)
MB_mainFrame:SetBackdrop(borderlessBackdrop)
MB_mainFrame:SetBackdropColor(0,0,0,0)
MB_mainFrame:EnableMouse(true)
MB_mainFrame:SetMovable(true)
MB_mainFrame:SetUserPlaced(true)
MB_mainFrame:SetSize(210,35)
MB_mainFrame:SetPoint("TOP", UIParent, "TOP")
MB_mainFrame:SetClampedToScreen(false)

local moverLeft = CreateFrame("Frame", "moverLeft", MB_mainFrame)
moverLeft:SetBackdrop(defaultBackdrop)
moverLeft:SetBackdropColor(0.1,0.1,0.1,0.7)
moverLeft:EnableMouse(true)
moverLeft:SetMovable(true)
moverLeft:SetSize(20,35)
moverLeft:SetPoint("RIGHT", MB_mainFrame, "LEFT")
moverLeft:SetScript("OnMouseDown", function(self,button) if (button=="LeftButton") then MB_mainFrame:StartMoving() end end)
moverLeft:SetScript("OnMouseUp", function(self) MB_mainFrame:StopMovingOrSizing() end)

-------------------------------------------------------
-- MB Icon Frame and Icons
-------------------------------------------------------

local iconFrame = CreateFrame("Frame", "MB_iconFrame", MB_mainFrame)
iconFrame:SetBackdrop(defaultBackdrop)
iconFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
iconFrame:EnableMouse(true)
iconFrame:SetMovable(true)
iconFrame:SetSize(210,35)
iconFrame:SetPoint("LEFT", MB_mainFrame, "LEFT")
local iconSkull = CreateFrame("Button", "iconSkull", iconFrame)
iconSkull:SetSize(20,20)
iconSkull:SetPoint("LEFT", iconFrame, "LEFT",5,0)
iconSkull:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconSkull:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
iconSkull:EnableMouse(true)
iconSkull:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 8) end)
iconSkull:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_skull, 1,1,1,true); end GameTooltip:AddLine("Skull", 0.88,0.65,0); GameTooltip:Show() end end)
iconSkull:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconCross = CreateFrame("Button", "iconCross", iconFrame)
iconCross:SetSize(20,20)
iconCross:SetPoint("LEFT", iconSkull, "RIGHT")
iconCross:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconCross:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
iconCross:EnableMouse(true)
iconCross:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 7) end)
iconCross:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_cross, 1,1,1,true); end GameTooltip:AddLine("Cross", 0.88,0.65,0); GameTooltip:Show() end end)
iconCross:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconSquare = CreateFrame("Button", "iconSquare", iconFrame)
iconSquare:SetSize(20,20)
iconSquare:SetPoint("LEFT", iconCross, "RIGHT")
iconSquare:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconSquare:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
iconSquare:EnableMouse(true)
iconSquare:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 6) end)
iconSquare:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_square, 1,1,1,true); end GameTooltip:AddLine("Square", 0.88,0.65,0); GameTooltip:Show() end end)
iconSquare:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconMoon = CreateFrame("Button", "iconMoon", iconFrame)
iconMoon:SetSize(20,20)
iconMoon:SetPoint("LEFT", iconSquare, "RIGHT")
iconMoon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconMoon:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
iconMoon:EnableMouse(true)
iconMoon:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 5) end)
iconMoon:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_moon, 1,1,1,true); end GameTooltip:AddLine("Moon", 0.88,0.65,0); GameTooltip:Show() end end)
iconMoon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconTriangle = CreateFrame("Button", "iconTriangle", iconFrame)
iconTriangle:SetSize(20,20)
iconTriangle:SetPoint("LEFT", iconMoon, "RIGHT")
iconTriangle:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconTriangle:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
iconTriangle:EnableMouse(true)
iconTriangle:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 4) end)
iconTriangle:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_triangle, 1,1,1,true); end GameTooltip:AddLine("Triangle", 0.88,0.65,0); GameTooltip:Show() end end)
iconTriangle:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconDiamond = CreateFrame("Button", "iconDiamond", iconFrame)
iconDiamond:SetSize(20,20)
iconDiamond:SetPoint("LEFT", iconTriangle, "RIGHT")
iconDiamond:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconDiamond:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
iconDiamond:EnableMouse(true)
iconDiamond:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 3) end)
iconDiamond:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_diamond, 1,1,1,true); end GameTooltip:AddLine("Diamond", 0.88,0.65,0); GameTooltip:Show() end end)
iconDiamond:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconCircle = CreateFrame("Button", "iconCircle", iconFrame)
iconCircle:SetSize(20,20)
iconCircle:SetPoint("LEFT", iconDiamond, "RIGHT")
iconCircle:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconCircle:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
iconCircle:EnableMouse(true)
iconCircle:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 2) end)
iconCircle:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_circle, 1,1,1,true); end GameTooltip:AddLine("Circle", 0.88,0.65,0); GameTooltip:Show() end end)
iconCircle:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local iconStar = CreateFrame("Button", "iconStar", iconFrame)
iconStar:SetSize(20,20)
iconStar:SetPoint("LEFT", iconCircle, "RIGHT")
iconStar:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
iconStar:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
iconStar:EnableMouse(true)
iconStar:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 1) end)
iconStar:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_star, 1,1,1,true); end GameTooltip:AddLine("Star", 0.88,0.65,0); GameTooltip:Show() end end)
iconStar:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local lockIcon = CreateFrame("Button", "lockIcon", iconFrame)
lockIcon:SetSize(20,20)
lockIcon:SetPoint("LEFT", iconStar , "RIGHT")
lockIcon:SetNormalTexture("Interface\\GLUES\\CharacterSelect\\Glues-Addon-Icons")
lockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
lockIcon:EnableMouse(true)
lockIcon:SetScript("OnClick", function(self) MB_lockToggle("main") end)
lockIcon:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Lock/Unlock Icons",0.88,0.65,0); GameTooltip:Show() end end)
lockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local clearIcon = CreateFrame("Button", "clearIcon", iconFrame)
clearIcon:SetSize(20,20)
clearIcon:SetPoint("LEFT", lockIcon , "RIGHT")
clearIcon:SetNormalTexture("interface\\glues\\loadingscreens\\dynamicelements")
clearIcon:GetNormalTexture():SetTexCoord(0,0.5,0,0.5)
clearIcon:EnableMouse(true)
clearIcon:SetScript("OnClick", function(self) if (not MB_clear_flag) then MB_clear_flag=true; for i=8, 0, -1 do SetRaidTarget("player",i) end repeat SetRaidTargetIcon("player",0) until (GetRaidTargetIndex("player") == nil) MB_clear_flag=false; end end)
clearIcon:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Clear All Icons",0.88,0.65,0); GameTooltip:Show() end end)
clearIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)



-------------------------------------------------------
-- MB Control Frame
-------------------------------------------------------

local MB_controlFrame = CreateFrame("Frame", "MB_controlFrame", UIParent)
MB_controlFrame:SetBackdrop(defaultBackdrop)
MB_controlFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
MB_controlFrame:EnableMouse(true)
MB_controlFrame:SetMovable(true)
MB_controlFrame:SetSize(100,35)
if MBDB.ctrlLock then
    MB_controlFrame:SetSize(80,35)
end
MB_controlFrame:SetPoint("LEFT", MB_iconFrame, "RIGHT",5,0)

local announceIcon  = CreateFrame("Button", "announceIcon ", MB_controlFrame)
announceIcon :SetSize(20,20)
announceIcon :SetPoint("LEFT", MB_controlFrame, "LEFT",10,0)
announceIcon :SetNormalTexture("Interface\\AddOns\\MarkingBar\\announce")
announceIcon :GetNormalTexture():SetTexCoord(0,1,0,1)
announceIcon :EnableMouse(true)
announceIcon :SetScript("OnClick", function(self) MB_Announce() end)
announceIcon :SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Announce to Chat", 0.88,0.65,0); GameTooltip:Show() end end)
announceIcon :SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local readyCheck = CreateFrame("Button", "readyCheck", MB_controlFrame)
readyCheck:SetSize(20,20)
readyCheck:SetPoint("LEFT", announceIcon , "RIGHT")
readyCheck:SetNormalTexture("interface\\raidframe\\readycheck-ready")
readyCheck:GetNormalTexture():SetTexCoord(0,1,0,1)
readyCheck:EnableMouse(true)
readyCheck:SetScript("OnClick", function(self) DoReadyCheck() end)
readyCheck:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Ready Check",0.88,0.65,0); GameTooltip:Show() end end)
readyCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local optIcon = CreateFrame("Button", "optIcon", MB_controlFrame)
optIcon:SetSize(20,20)
optIcon:SetPoint("LEFT", readyCheck , "RIGHT")
optIcon:SetNormalTexture("interface\\WorldMap\\Gear_64")
optIcon:GetNormalTexture():SetTexCoord(0,.5,0,.5)
optIcon:EnableMouse(true)
optIcon:RegisterForClicks("AnyDown")
optIcon:SetScript("OnClick", function(self,button) if ( button == "RightButton" ) then InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.childpanel4) else InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.childpanel1) end end )
optIcon:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Options",0.88,0.65,0); GameTooltip:Show() end end)
optIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local ctrlLockIcon = CreateFrame("Button", "ctrlLockIcon", MB_controlFrame)
ctrlLockIcon:SetSize(20,20)
ctrlLockIcon:SetNormalTexture("Interface\\GLUES\\CharacterSelect\\Glues-Addon-Icons")
ctrlLockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
ctrlLockIcon:SetScript("OnClick", function(self) MB_lockToggle("ctrl") end)
ctrlLockIcon:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Lock/Unlock Controls",0.88,0.65,0); GameTooltip:Show() end end)
ctrlLockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
ctrlLockIcon:SetPoint("LEFT", optIcon , "RIGHT")
ctrlLockIcon:SetAlpha(1)
ctrlLockIcon:EnableMouse(true)

local moverRight = CreateFrame("Frame", "moverRight", MB_controlFrame)
moverRight:SetBackdrop(defaultBackdrop)
moverRight:SetBackdropColor(0.1,0.1,0.1,0.7)
moverRight:SetSize(20,35)
moverRight:SetMovable(true)
moverRight:SetScript("OnMouseDown", function(self,button) if (button=="LeftButton") then MB_controlFrame:StartMoving() end end)
moverRight:SetScript("OnMouseUp", function(self) MB_controlFrame:StopMovingOrSizing() end)
moverRight:SetPoint("LEFT", MB_controlFrame , "RIGHT")
moverRight:SetAlpha(1)
moverRight:EnableMouse(true)


-------------------------------------------------------
-- MBFlares Main Frame and Movers
-------------------------------------------------------

MBFlares_mainFrame = CreateFrame("Frame", "MBFlares_mainFrame", UIParent)
MBFlares_mainFrame:SetBackdrop(defaultBackdrop)
MBFlares_mainFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
MBFlares_mainFrame:EnableMouse(true)
MBFlares_mainFrame:SetMovable(true)
MBFlares_mainFrame:SetUserPlaced(true)
MBFlares_mainFrame:SetSize(155,30)
MBFlares_mainFrame:SetPoint("TOP", UIParent, "TOP",0,-40)
MBFlares_mainFrame:SetClampedToScreen(false)
local MBFlares_moverLeft = CreateFrame("Frame", "MBFlares_moverLeft", MBFlares_mainFrame)
MBFlares_moverLeft:SetBackdrop(defaultBackdrop)
MBFlares_moverLeft:SetBackdropColor(0.1,0.1,0.1,0.7)
MBFlares_moverLeft:EnableMouse(true)
MBFlares_moverLeft:SetMovable(true)
MBFlares_moverLeft:SetSize(20,30)
MBFlares_moverLeft:SetPoint("RIGHT", MBFlares_mainFrame, "LEFT")
MBFlares_moverLeft:SetScript("OnMouseDown", function(self,button) if (button=="LeftButton") then MBFlares_mainFrame:StartMoving() end end)
MBFlares_moverLeft:SetScript("OnMouseUp", function(self) MBFlares_mainFrame:StopMovingOrSizing() end)

-------------------------------------------------------
-- The Actual Flares
-------------------------------------------------------
local flareBlue = CreateFrame("Button", "flareBlue", MBFlares_mainFrame, "SecureActionButtonTemplate")
flareBlue:SetSize(20,20)
flareBlue:SetNormalTexture("interface\\minimap\\partyraidblips")
flareBlue:GetNormalTexture():SetTexCoord(0.75,0.875,0,0.25)
flareBlue:SetPoint("TOPLEFT", MBFlares_mainFrame, "TOPLEFT",5,-5)
flareBlue:SetAttribute("type", "macro")
flareBlue:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button1")
flareBlue:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true and MBFlares_mainFrame:GetAlpha()==1) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Blue world marker",0.88,0.65,0); GameTooltip:Show() end end)
flareBlue:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local flareGreen = CreateFrame("Button", "flareGreen", MBFlares_mainFrame, "SecureActionButtonTemplate")
flareGreen:SetSize(20,20)
flareGreen:SetNormalTexture("interface\\minimap\\partyraidblips")
flareGreen:GetNormalTexture():SetTexCoord(0.25,0.375,0,0.25)
flareGreen:SetPoint("LEFT", flareBlue, "RIGHT")
flareGreen:SetAttribute("type", "macro")
flareGreen:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button2")
flareGreen:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true and MBFlares_mainFrame:GetAlpha()==1) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Green world marker",0.88,0.65,0); GameTooltip:Show() end end)
flareGreen:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local flarePurple = CreateFrame("Button", "flarePurple", MBFlares_mainFrame, "SecureActionButtonTemplate")
flarePurple:SetSize(20,20)
flarePurple:SetNormalTexture("interface\\minimap\\partyraidblips")
flarePurple:GetNormalTexture():SetTexCoord(0,0.125,0.25,0.5)
flarePurple:SetPoint("LEFT", flareGreen, "RIGHT")
flarePurple:SetAttribute("type", "macro")
flarePurple:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button3")
flarePurple:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Purple world marker",0.88,0.65,0); GameTooltip:Show() end end)
flarePurple:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local flareRed = CreateFrame("Button", "flareRed", MBFlares_mainFrame, "SecureActionButtonTemplate")
flareRed:SetSize(20,20)
flareRed:SetNormalTexture("interface\\minimap\\partyraidblips")
flareRed:GetNormalTexture():SetTexCoord(0.625,0.75,0,0.25)
flareRed:SetPoint("LEFT", flarePurple, "RIGHT")
flareRed:SetAttribute("type", "macro")
flareRed:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button4")
flareRed:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Red world marker",0.88,0.65,0); GameTooltip:Show() end end)
flareRed:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local flareYellow = CreateFrame("Button", "flareYellow", MBFlares_mainFrame, "SecureActionButtonTemplate")
flareYellow:SetSize(20,20)
flareYellow:SetNormalTexture("interface\\minimap\\partyraidblips")
flareYellow:GetNormalTexture():SetTexCoord(0.375,0.5,0,0.25)
flareYellow:SetPoint("LEFT", flareRed, "RIGHT")
flareYellow:SetAttribute("type", "macro")
flareYellow:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button5")
flareYellow:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Yellow world marker",0.88,0.65,0); GameTooltip:Show() end end)
flareYellow:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local flareClear = CreateFrame("Button", "flareClear", MBFlares_mainFrame, "SecureActionButtonTemplate")
flareClear:SetSize(15,15)
flareClear:SetNormalTexture("interface\\glues\\loadingscreens\\dynamicelements")
flareClear:GetNormalTexture():SetTexCoord(0,0.5,0,0.5)
flareClear:SetPoint("LEFT", flareYellow, "RIGHT",3,0)
flareClear:SetAttribute("type", "macro")
flareClear:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button6")
flareClear:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Clear all world markers.",0.88,0.65,0); GameTooltip:Show() end end)
flareClear:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local flarelockIcon = CreateFrame("Button", "flarelockIcon", MBFlares_mainFrame)
flarelockIcon:SetSize(20,20)
flarelockIcon:SetPoint("LEFT", flareClear , "RIGHT",5,0)
flarelockIcon:SetNormalTexture("Interface\\GLUES\\CharacterSelect\\Glues-Addon-Icons")
flarelockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
flarelockIcon:EnableMouse(true)
flarelockIcon:SetScript("OnClick", function(self) MB_lockToggle("flare") end)
flarelockIcon:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Lock/Unlock",0.88,0.65,0); GameTooltip:Show() end end)
flarelockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
-------------------------------------------------------
-- Functions
-------------------------------------------------------

function MB_Announce()
	if (GetNumRaidMembers() == 0) then				-- NOT IN RAID
		if (GetNumPartyMembers() == 0 ) then			-- AND NOT IN A PARTY 
			ChatFrame1:AddMessage(MB .. ": You are not in a Party or Raid.");
		else							-- IN A PARTY		
			MB_Announce_to_Chat("PARTY")
		end
	else								-- IN A RAID
		if IsRaidLeader() or IsRaidOfficer() then		-- ABLE TO MARK
			MB_Announce_to_Chat("RAID")	
		else							--NOT ABLE TO MARK
			ChatFrame1:AddMessage(MB .. ": You are not a Raid Leader or Raid Assistant. You cannot use raid markers.");
		end
	end
end

function MB_Announce_to_Chat(ChatType)
	if (MBDB.announce_intro) then SendChatMessage(MBDB.msg_intro,ChatType,nil); end
	if (MBDB.announce_skull) then	SendChatMessage(MBDB.msg_skull .. " {rt8}.",ChatType,nil); end
	if (MBDB.announce_cross) then SendChatMessage(MBDB.msg_cross .. " {rt7}.",ChatType,nil); end
	if (MBDB.announce_square) then SendChatMessage(MBDB.msg_square .. " {rt6}.",ChatType,nil); end
	if (MBDB.announce_moon) then SendChatMessage(MBDB.msg_moon .. " {rt5}.",ChatType,nil); end
	if (MBDB.announce_triangle) then SendChatMessage(MBDB.msg_triangle .. " {rt4}.",ChatType,nil); end
	if (MBDB.announce_diamond) then SendChatMessage(MBDB.msg_diamond .. " {rt3}.",ChatType,nil); end
	if (MBDB.announce_circle) then SendChatMessage(MBDB.msg_circle .. " {rt2}.",ChatType,nil); end
	if (MBDB.announce_star) then SendChatMessage(MBDB.msg_star .. " {rt1}.",ChatType,nil); end
    if (MBDB.announce_footer) then SendChatMessage(MBDB.msg_footer,ChatType,nil); end
    
    if ( ChatType == "RAID") then
        if MBFlaresDB.announce_rw then 
            SendChatMessage(MBFlaresDB.msg_rw,ChatType,nil); 
            SendChatMessage(MBFlaresDB.msg_rw,"RAID_WARNING",nil);
        end
    end
end

function MB_targetChecker(DB)
    if ( DB == "main" ) then
        MB_mainFrame:Hide()
            if ( MBDB.shown == false ) then           -- show only with target
            if ( UnitExists("target") ) then    -- target exists
                MB_partyChecker(DB)
            else
                MB_mainFrame:Hide()
            end
        else                                    -- show regardless of target
            MB_partyChecker(DB)
        end
    elseif ( DB == "ctrl" ) then
        MB_controlFrame:Hide()
            if ( MBCtrlDB.shown == false ) then           -- show only with target
            if ( UnitExists("target") ) then    -- target exists
                MB_partyChecker(DB)
            else
                MB_controlFrame:Hide()
            end
        else                                    -- show regardless of target
            MB_partyChecker(DB)
        end
    elseif ( DB == "flare" ) then
        MBFlares_mainFrame:Hide()
                if ( MBFlaresDB.shown == false ) then           -- show only with target
            if ( UnitExists("target") ) then    -- target exists
                MB_partyChecker(DB)
            else
                MBFlares_mainFrame:Hide()
            end
        else                                    -- show regardless of target
            MB_partyChecker(DB)
        end
    end
end

function MB_partyChecker(DB)   
    if ( DB == "main" ) then
        if (GetNumRaidMembers() == 0) then				-- NOT IN RAID
            if (GetNumPartyMembers() == 0 ) then		-- AND NOT IN A PARTY 
                if ( MBDB.aloneShow == true ) then
                    MB_mainFrame:Show()
                else                        
                    MB_mainFrame:Hide()
                end
            else							            -- IN A PARTY		
                if ( MBDB.partyShow == true ) then
                    MB_mainFrame:Show()
                else                        
                    MB_mainFrame:Hide()
                end
            end
        else								            -- IN A RAID
            if IsRaidLeader() or IsRaidOfficer() then	-- ABLE TO MARK
                if ( MBDB.raidShow == true ) then
                    MB_mainFrame:Show()
                else                        
                    MB_mainFrame:Hide()
                end
            else							            --BUT NOT ABLE TO MARK
                    MB_mainFrame:Hide()
            end
        end
    elseif ( DB == "ctrl" ) then
        if (GetNumRaidMembers() == 0) then				-- NOT IN RAID
            if (GetNumPartyMembers() == 0 ) then		-- AND NOT IN A PARTY 
                if ( MBCtrlDB.aloneShow == true ) then
                    MB_controlFrame:Show()
                else                        
                    MB_controlFrame:Hide()
                end
            else							            -- IN A PARTY		
                if ( MBCtrlDB.partyShow == true ) then
                    MB_controlFrame:Show()
                else                        
                    MB_controlFrame:Hide()
                end
            end
        else								            -- IN A RAID
            if IsRaidLeader() or IsRaidOfficer() then	-- ABLE TO MARK
                if ( MBCtrlDB.raidShow == true ) then
                    MB_controlFrame:Show()
                else                        
                    MB_controlFrame:Hide()
                end
            else							            --BUT NOT ABLE TO MARK
                    MB_controlFrame:Hide()
            end
        end
    elseif ( DB == "flare" ) then
        if (GetNumRaidMembers() == 0) then				-- NOT IN RAID
            if (GetNumPartyMembers() == 0 ) then		-- AND NOT IN A PARTY 
                if ( MBFlaresDB.aloneShow == true ) then
                    MBFlares_mainFrame:Show()
                else                        
                    MBFlares_mainFrame:Hide()
                end
            else							            -- IN A PARTY		
                if ( MBFlaresDB.partyShow == true ) then
                    MBFlares_mainFrame:Show()
                else                        
                    MBFlares_mainFrame:Hide()
                end
            end
        else								            -- IN A RAID
            if IsRaidLeader() or IsRaidOfficer() then	-- ABLE TO MARK
                if ( MBFlaresDB.raidShow == true ) then
                    MBFlares_mainFrame:Show()
                else                        
                    MBFlares_mainFrame:Hide()
                end
            else							            --BUT NOT ABLE TO MARK
                    MBFlares_mainFrame:Hide()
            end
        end
    end
end


function MB_lock(DB)
    if ( DB == "main" ) then
        MBDB.locked = true
        moverLeft:SetAlpha(0)
        moverLeft:EnableMouse(false)
        lockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    elseif  ( DB == "ctrl" ) then
        MBCtrlDB.locked = true
        moverRight:SetAlpha(0)
        moverRight:EnableMouse(false)
        ctrlLockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    elseif  ( DB == "flare" ) then
        MBFlaresDB.locked = true
    	MBFlares_moverLeft:SetAlpha(0)
        MBFlares_moverLeft:EnableMouse(false)
        flarelockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    end
end

function MB_unlock(DB)
    if ( DB == "main" ) then
        MBDB.locked = false
        moverLeft:SetAlpha(1)
        moverLeft:EnableMouse(true)
        lockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
    elseif  ( DB == "ctrl" ) then
        MBCtrlDB.locked = false
        moverRight:SetAlpha(1)
        moverRight:EnableMouse(true)
        ctrlLockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
    elseif  ( DB == "flare" ) then
        MBFlaresDB.locked = false
        MBFlares_moverLeft:SetAlpha(1)
        MBFlares_moverLeft:EnableMouse(true)
        flarelockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
    end
end

function MB_lockToggle(DB)
    if ( DB == "main" ) then
        if MBDB.locked then MB_unlock("main") else MB_lock("main") end
    elseif ( DB == "ctrl" ) then
        if MBCtrlDB.locked then
            if MBDB.ctrlLock then MB_ctrlUnlock() end -- if ctrl is connected to icons
            MB_unlock("ctrl")
        else
            MB_lock("ctrl") 
        end
    elseif ( DB == "flare" ) then
        if MBFlaresDB.locked then MB_unlock("flare") else MB_lock("flare") end
    end    
end

function MB_ctrlLock()
	MBDB.ctrlLock = true
    MB_lock("ctrl")
    MB_flipChecker()
end

function MB_ctrlUnlock()
	MBDB.ctrlLock = false
    MB_unlock("ctrl")
    MB_flipChecker()
end

function MB_ctrlLockToggle()
	if (MBDB.ctrlLock == true) then
		MB_ctrlUnlock()
	else
		MB_ctrlLock()
	end
end


function MB_reset_msg() 	--Remember to change up top if you change here!!!
	MBDB.msg_intro = "I will use the following marks:"
	MBDB.msg_skull = "Kill"
	MBDB.msg_cross = "Then kill"
	MBDB.msg_square = "Hunter - Freezing Trap"
	MBDB.msg_moon = "Mage - Polymorph"
	MBDB.msg_triangle = "Druid - Hibernate"
	MBDB.msg_diamond = "Warlock - Seduce/Banish/Enslave Demon"
	MBDB.msg_circle = "Priest - Shackle/Mind Control"
	MBDB.msg_star = "Rogue - Sap"
    MBDB.msg_footer = "Input other miscellaneous text to send here."
	MBDB.announce_intro = true
	MBDB.announce_skull = true
	MBDB.announce_cross = true
	MBDB.announce_square = true
	MBDB.announce_moon = true
	MBDB.announce_triangle = true
	MBDB.announce_diamond = true
	MBDB.announce_circle = true
	MBDB.announce_star = true
    MBDB.announce_footer = false
    MBFlaresDB.announce_rw = false
    MBFlaresDB.msg_rw = "Please look at raid chat to see raid mark descriptions."
end

function MB_reset()
    -- reset variables
    MBDB.ctrlLock = true
	MBDB.shown = true
    MBDB.aloneShow = true
	MBDB.partyShow = true
    MBDB.raidShow = true
	MBDB.locked= false
	MBDB.clamped = true
	MBDB.flipped = false
	MBDB.vertical = false
	MBDB.bgHide = false
	MBDB.tooltips = true
	MBDB.scale = 1
	MBDB.alpha = 1
    MB_reset_msg()
    --reset orientations
    MB_targetChecker("main")
	MB_unlock("main")
	MB_mainFrame:SetClampedToScreen(true)
	MB_bgShow("main")

    --reset variables for Ctrl
	MBCtrlDB.shown = true
    MBCtrlDB.aloneShow = true
	MBCtrlDB.partyShow = true
    MBCtrlDB.raidShow = true
	MBCtrlDB.locked = true
	MBCtrlDB.clamped = true
	MBCtrlDB.vertical = false
	MBCtrlDB.bgHide = false
	MBCtrlDB.tooltips = true
    MBDB.announce_tooltip = false
	MBCtrlDB.scale = 1
	MBCtrlDB.alpha = 1
    --reset orientation for Ctrl
	MB_targetChecker("ctrl")
    MB_ctrlLock()
	MB_lock("ctrl")
	MB_controlFrame:SetClampedToScreen(true)
	MB_bgShow("ctrl")
    
	MB_flipChecker()
    
    --reset variables for flares
	MBFlaresDB.shown = true
    MBFlaresDB.aloneShow = true
	MBFlaresDB.partyShow = true
    MBFlaresDB.raidShow = true
	MBFlaresDB.locked = false
	MBFlaresDB.clamped = true
	MBFlaresDB.bgHide = false
	MBFlaresDB.tooltips = true
	MBFlaresDB.scale = 1
	MBFlaresDB.alpha = 1
    --reset orientation for flares
	MB_targetChecker("flare")
	MB_unlock("flare")
	MBFlares_mainFrame:SetClampedToScreen(true)
    MB_flareflip(1)
	MB_bgShow("flare")
    --updates checkmarks
    --reset frames to center positions
	MB_mainFrame:ClearAllPoints()
    MB_controlFrame:ClearAllPoints()
	MBFlares_mainFrame:ClearAllPoints()
	MB_mainFrame:SetPoint("TOP", UIParent, "TOP")
    MB_controlFrame:SetPoint("LEFT", MB_iconFrame, "RIGHT",5,0)
	MBFlares_mainFrame:SetPoint("TOP", UIParent, "TOP",0,-40)
	MB_checkUpdater()
end

function MB_flip(dir)
	iconSkull:ClearAllPoints()
	iconCross:ClearAllPoints()
	iconSquare:ClearAllPoints()
	iconMoon:ClearAllPoints()
	iconTriangle:ClearAllPoints()
	iconDiamond:ClearAllPoints()
	iconCircle:ClearAllPoints()
	iconStar:ClearAllPoints()
	lockIcon:ClearAllPoints()
	clearIcon:ClearAllPoints()
	moverLeft:ClearAllPoints()
	iconFrame:ClearAllPoints()
    announceIcon:ClearAllPoints()
	readyCheck:ClearAllPoints()
	optIcon:ClearAllPoints()
    ctrlLockIcon:ClearAllPoints()
    moverRight:ClearAllPoints()
	if (dir==1) then -- Normal
		iconSkull:SetPoint("LEFT", iconFrame, "LEFT",5,0)
		iconCross:SetPoint("LEFT", iconSkull, "RIGHT")
		iconSquare:SetPoint("LEFT", iconCross, "RIGHT")
		iconMoon:SetPoint("LEFT", iconSquare, "RIGHT")
		iconTriangle:SetPoint("LEFT", iconMoon, "RIGHT")
		iconDiamond:SetPoint("LEFT", iconTriangle, "RIGHT")
		iconCircle:SetPoint("LEFT", iconDiamond, "RIGHT")
		iconStar:SetPoint("LEFT", iconCircle, "RIGHT")
		lockIcon:SetPoint("LEFT", iconStar , "RIGHT")
        clearIcon:SetPoint("LEFT", lockIcon , "RIGHT")
        MB_mainFrame:SetSize(210,35)
		iconFrame:SetSize(210,35)
		iconFrame:SetPoint("LEFT", MB_mainFrame, "LEFT")
        moverLeft:SetSize(20,35)
		moverLeft:SetPoint("RIGHT", MB_mainFrame, "LEFT")
	elseif (dir==2) then -- Backwards
		iconStar:SetPoint("LEFT", iconFrame, "LEFT",5,0)
		iconCircle:SetPoint("LEFT", iconStar, "RIGHT")
		iconDiamond:SetPoint("LEFT", iconCircle, "RIGHT")
		iconTriangle:SetPoint("LEFT", iconDiamond, "RIGHT")
		iconMoon:SetPoint("LEFT", iconTriangle, "RIGHT")
		iconSquare:SetPoint("LEFT", iconMoon, "RIGHT")
		iconCross:SetPoint("LEFT", iconSquare, "RIGHT")
		iconSkull:SetPoint("LEFT", iconCross, "RIGHT")
		lockIcon:SetPoint("LEFT", iconSkull , "RIGHT")
        clearIcon:SetPoint("LEFT", lockIcon , "RIGHT")
        MB_mainFrame:SetSize(210,35)
 		iconFrame:SetSize(210,35)
		iconFrame:SetPoint("LEFT", MB_mainFrame, "LEFT")
		moverLeft:SetSize(20,35)
		moverLeft:SetPoint("RIGHT", MB_mainFrame, "LEFT")
	elseif (dir==3) then -- Normal vertical
		iconSkull:SetPoint("TOP", iconFrame, "TOP",0,-5)
		iconCross:SetPoint("TOP", iconSkull, "BOTTOM")
		iconSquare:SetPoint("TOP", iconCross, "BOTTOM")
		iconMoon:SetPoint("TOP", iconSquare, "BOTTOM")
		iconTriangle:SetPoint("TOP", iconMoon, "BOTTOM")
		iconDiamond:SetPoint("TOP", iconTriangle, "BOTTOM")
		iconCircle:SetPoint("TOP", iconDiamond, "BOTTOM")
		iconStar:SetPoint("TOP", iconCircle, "BOTTOM")
		lockIcon:SetPoint("TOP", iconStar , "BOTTOM")
        clearIcon:SetPoint("TOP", lockIcon , "BOTTOM")
        MB_mainFrame:SetSize(35,210)
		iconFrame:SetSize(35,210)
		iconFrame:SetPoint("TOP", MB_mainFrame, "TOP")
		moverLeft:SetSize(35,20)
		moverLeft:SetPoint("BOTTOM", MB_mainFrame, "TOP")
	elseif (dir==4) then -- Backwards vertical
		iconStar:SetPoint("TOP", iconFrame, "TOP",0,-5)
		iconCircle:SetPoint("TOP", iconStar, "BOTTOM")
		iconDiamond:SetPoint("TOP", iconCircle, "BOTTOM")
		iconTriangle:SetPoint("TOP", iconDiamond, "BOTTOM")
		iconMoon:SetPoint("TOP", iconTriangle, "BOTTOM")
		iconSquare:SetPoint("TOP", iconMoon, "BOTTOM")
		iconCross:SetPoint("TOP", iconSquare, "BOTTOM")
		iconSkull:SetPoint("TOP", iconCross, "BOTTOM")
		lockIcon:SetPoint("TOP", iconSkull , "BOTTOM")
        clearIcon:SetPoint("TOP", lockIcon , "BOTTOM")
        MB_mainFrame:SetSize(35,210)
		iconFrame:SetSize(35,210)
		iconFrame:SetPoint("TOP", MB_mainFrame, "TOP")
		moverLeft:SetSize(35,20)
		moverLeft:SetPoint("BOTTOM", MB_mainFrame, "TOP")
	end
    if MBCtrlDB.vertical then
            -- and stuff for control options vertically
		announceIcon :SetPoint("TOP", MB_controlFrame, "TOP",0,-10)
		readyCheck:SetPoint("TOP", announceIcon , "BOTTOM")
		optIcon:SetPoint("TOP", readyCheck , "BOTtOM")
		if MBDB.ctrlLock then
            MB_controlFrame:ClearAllPoints()
            MB_controlFrame:SetSize(35,80)
            ctrlLockIcon:SetAlpha(0)
            ctrlLockIcon:EnableMouse(false)
            moverRight:SetAlpha(0)
            moverRight:EnableMouse(false)
            MB_controlFrame:SetParent(MB_mainFrame)
            MB_controlFrame:SetPoint("TOP", MB_iconFrame, "BOTTOM",0,5)
        else
            MB_controlFrame:SetSize(35,100)
            ctrlLockIcon:SetAlpha(1)
            ctrlLockIcon:EnableMouse(true)
            MB_controlFrame:SetParent(UIParent)
            ctrlLockIcon:SetPoint("TOP", optIcon , "BOTTOM")
            moverRight:SetSize(35,20)
            moverRight:SetPoint("TOP", MB_controlFrame, "BOTTOM")
        end
    else
            -- and stuff for control options horizontally
		announceIcon :SetPoint("LEFT", MB_controlFrame, "LEFT",10,0)
		readyCheck:SetPoint("LEFT", announceIcon , "RIGHT")
		optIcon:SetPoint("LEFT", readyCheck , "RIGHT")
 		if MBDB.ctrlLock then
            MB_controlFrame:ClearAllPoints()
            MB_controlFrame:SetSize(80,35)
            ctrlLockIcon:SetAlpha(0)
            ctrlLockIcon:EnableMouse(false)
            moverRight:SetAlpha(0)
            moverRight:EnableMouse(false)
            MB_controlFrame:SetPoint("LEFT", MB_iconFrame, "RIGHT",5,0)
        else
            MB_controlFrame:SetSize(100,35)
            ctrlLockIcon:SetAlpha(1)
            ctrlLockIcon:EnableMouse(true)
            ctrlLockIcon:SetPoint("LEFT", optIcon , "RIGHT")
            moverRight:SetSize(20,35)
            moverRight:SetPoint("LEFT", MB_controlFrame , "RIGHT")
        end 
    end
end

function MB_flipChecker()
	if (MBDB.flipped==false) and (MBDB.vertical==false) then
		MB_flip(1)
	elseif (MBDB.flipped==true) and (MBDB.vertical==false) then 
		MB_flip(2)	
	elseif (MBDB.flipped==false) and (MBDB.vertical==true) then
		MB_flip(3)
	elseif (MBDB.flipped==true) and (MBDB.vertical==true) then
		MB_flip(4)
	end
end

function MB_flareflip(dir)
	flareBlue:ClearAllPoints()
	flareGreen:ClearAllPoints()
	flarePurple:ClearAllPoints()
	flareRed:ClearAllPoints()
	flareYellow:ClearAllPoints()
	flareClear:ClearAllPoints()
	flarelockIcon:ClearAllPoints()
	MBFlares_mainFrame:ClearAllPoints()
	MBFlares_moverLeft:ClearAllPoints()
	if (dir==1) then -- Normal
		flareBlue:SetPoint("TOPLEFT", MBFlares_mainFrame, "TOPLEFT",5,-5)
		flareGreen:SetPoint("LEFT", flareBlue, "RIGHT")
		flarePurple:SetPoint("LEFT", flareGreen, "RIGHT")
		flareRed:SetPoint("LEFT", flarePurple, "RIGHT")
		flareYellow:SetPoint("LEFT", flareRed, "RIGHT")
		flareClear:SetPoint("LEFT", flareYellow, "RIGHT",3,0)
		flarelockIcon:SetPoint("LEFT", flareClear, "RIGHT",5,0)
		MBFlares_mainFrame:SetSize(155,30)
		MBFlares_mainFrame:SetPoint("TOP", UIParent, "TOP",0,-40)
		MBFlares_moverLeft:SetSize(20,30)
		MBFlares_moverLeft:SetPoint("RIGHT", MBFlares_mainFrame, "LEFT")
	elseif (dir==2) then -- Backwards
		flareYellow:SetPoint("TOPLEFT", MBFlares_mainFrame, "TOPLEFT",5,-5)
		flareRed:SetPoint("LEFT", flareYellow, "RIGHT")
		flarePurple:SetPoint("LEFT", flareRed, "RIGHT")
		flareGreen:SetPoint("LEFT", flarePurple, "RIGHT")
		flareBlue:SetPoint("LEFT", flareGreen, "RIGHT")
		flareClear:SetPoint("LEFT", flareBlue, "RIGHT",3,0)
		flarelockIcon:SetPoint("LEFT", flareClear, "RIGHT",5,0)
		MBFlares_mainFrame:SetSize(155,30)
		MBFlares_mainFrame:SetPoint("TOP", UIParent, "TOP",0,-40)
		MBFlares_moverLeft:SetSize(20,30)
		MBFlares_moverLeft:SetPoint("RIGHT", MBFlares_mainFrame, "LEFT")
	elseif (dir==3) then -- Normal vertical
		flareBlue:SetPoint("TOPLEFT", MBFlares_mainFrame, "TOPLEFT",5,-5)
		flareGreen:SetPoint("TOP", flareBlue, "BOTTOM")
		flarePurple:SetPoint("TOP", flareGreen, "BOTTOM")
		flareRed:SetPoint("TOP", flarePurple, "BOTTOM")
		flareYellow:SetPoint("TOP", flareRed, "BOTTOM")
		flareClear:SetPoint("TOP", flareYellow, "BOTTOM",0,-3)
		flarelockIcon:SetPoint("TOP", flareClear, "BOTTOM",0,-5)
		MBFlares_mainFrame:SetSize(30,155)
		MBFlares_mainFrame:SetPoint("TOP", UIParent, "TOP",0,-40)
		MBFlares_moverLeft:SetSize(30,20)
		MBFlares_moverLeft:SetPoint("BOTTOM", MBFlares_mainFrame, "TOP")
	elseif (dir==4) then -- Backwards vertical
		flareYellow:SetPoint("TOPLEFT", MBFlares_mainFrame, "TOPLEFT",5,-5)
		flareRed:SetPoint("TOP", flareYellow, "BOTTOM")
		flarePurple:SetPoint("TOP", flareRed, "BOTTOM")
		flareGreen:SetPoint("TOP", flarePurple, "BOTTOM")
		flareBlue:SetPoint("TOP", flareGreen, "BOTTOM")
		flareClear:SetPoint("TOP", flareBlue, "BOTTOM",0,-3)
		flarelockIcon:SetPoint("TOP", flareClear, "BOTTOM",0,-5)
		MBFlares_mainFrame:SetSize(30,155)
		MBFlares_mainFrame:SetPoint("TOP", UIParent, "TOP",0,-40)
		MBFlares_moverLeft:SetSize(30,20)
		MBFlares_moverLeft:SetPoint("BOTTOM", MBFlares_mainFrame, "TOP")
	end
end

function MB_flareflipChecker()
	if (MBFlaresDB.flipped==false) and (MBFlaresDB.vertical==false) then
		MB_flareflip(1)
	elseif (MBFlaresDB.flipped==true) and (MBFlaresDB.vertical==false) then 
		MB_flareflip(2)	
	elseif (MBFlaresDB.flipped==false) and (MBFlaresDB.vertical==true) then
		MB_flareflip(3)
	elseif (MBFlaresDB.flipped==true) and (MBFlaresDB.vertical==true) then
		MB_flareflip(4)
	end
end

function MB_bgToggle(DB)
    if ( DB == "main" ) then
    	if ( MBDB.bgHide==true ) then MBDB.bgHide = false; MB_bgShow("main") else	MBDB.bgHide = true; MB_bgHide("main") end
    elseif ( DB == "ctrl" ) then
    	if ( MBCtrlDB.bgHide==true ) then MBCtrlDB.bgHide = false; MB_bgShow("ctrl") else	MBCtrlDB.bgHide = true; MB_bgHide("ctrl") end
    elseif ( DB == "flare" ) then
    	if ( MBFlaresDB.bgHide==true ) then MBFlaresDB.bgHide = false; MB_bgShow("flare") else MBFlaresDB.bgHide = true; MB_bgHide("flare") end
    end
end

function MB_bgHide(DB)
    if ( DB == "main" ) then
        iconFrame:SetBackdropColor(0,0,0,0)
        iconFrame:SetBackdropBorderColor(0,0,0,0)
    elseif ( DB == "ctrl" ) then
        MB_controlFrame:SetBackdropColor(0,0,0,0)
        MB_controlFrame:SetBackdropBorderColor(0,0,0,0)
    elseif ( DB == "flare" ) then
        MBFlares_mainFrame:SetBackdropColor(0,0,0,0)
        MBFlares_mainFrame:SetBackdropBorderColor(0,0,0,0)
    end
end

function MB_bgShow(DB)
    if ( DB == "main" ) then
        iconFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
        iconFrame:SetBackdropBorderColor(1,1,1,1)
    elseif ( DB == "ctrl" ) then
        MB_controlFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
        MB_controlFrame:SetBackdropBorderColor(1,1,1,1)
    elseif ( DB == "flare" ) then
        MBFlares_mainFrame:SetBackdropColor(0.1,0.1,0.1,1)
        MBFlares_mainFrame:SetBackdropBorderColor(1,1,1,1)
    end
end

function MB_scale(self,DB)
	if self == nil then return end
    if ( DB == "main" ) then
    	MBDB.scale = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." scale: "..math.floor((MBDB.scale*100)).."%")
        MB_mainFrame:SetScale(MBDB.scale);
    elseif ( DB == "ctrl" ) then
    	MBCtrlDB.scale = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." controls scale: "..math.floor((MBCtrlDB.scale*100)).."%")
        MB_controlFrame:SetScale(MBCtrlDB.scale);
    elseif ( DB == "flare" ) then
    	MBFlaresDB.scale = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MBF .." scale: "..math.floor((MBFlaresDB.scale*100)).."%")
        MBFlares_mainFrame:SetScale(MBFlaresDB.scale);
    end
end


function MB_alpha(self,DB)
	if self == nil then return end
    if ( DB == "main" ) then
        MBDB.alpha = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." opacity: "..math.floor((MBDB.alpha*100)).."%")
        MB_mainFrame:SetAlpha(MBDB.alpha);
    elseif ( DB == "ctrl" ) then
        MBCtrlDB.alpha = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." controls opacity: "..math.floor((MBCtrlDB.alpha*100)).."%")
        MB_controlFrame:SetAlpha(MBCtrlDB.alpha);
    elseif ( DB == "flare" ) then
        MBFlaresDB.alpha = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MBF .." opacity: "..math.floor((MBFlaresDB.alpha*100)).."%")
        MBFlares_mainFrame:SetAlpha(MBFlaresDB.alpha);
    end
end

function MB_checkUpdater()
	showCheck:SetChecked(MBDB.shown)
    aloneCheck:SetChecked(MBDB.aloneShow)
	partyCheck:SetChecked(MBDB.partyShow)
    raidCheck:SetChecked(MBDB.raidShow)
	lockCheck:SetChecked(MBDB.locked)
    ctrlCheck:SetChecked(MBDB.ctrlLock)
	clampCheck:SetChecked(MBDB.clamped)
	flipCheck:SetChecked(MBDB.flipped)
	vertCheck:SetChecked(MBDB.vertical)
	bgCheck:SetChecked(MBDB.bgHide)
	toolCheck:SetChecked(MBDB.tooltips)
	getglobal(scaleSlider:GetName().."Low"):SetText("50%")
	getglobal(scaleSlider:GetName().."High"):SetText("150%")
	getglobal(scaleSlider:GetName().."Text"):SetText(MB .." scale: "..math.floor((MBDB.scale*100)).."%")	
	scaleSlider:SetValue(MBDB.scale)
	getglobal(alphaSlider:GetName().."Low"):SetText("0%")
	getglobal(alphaSlider:GetName().."High"):SetText("100%")
	getglobal(alphaSlider:GetName().."Text"):SetText(MB .." opacity: "..math.floor((MBDB.alpha*100)).."%")
	alphaSlider:SetValue(MBDB.alpha)
    
    ctrlShowCheck:SetChecked(MBCtrlDB.shown)
    ctrlAloneCheck:SetChecked(MBCtrlDB.aloneShow)
	ctrlPartyCheck:SetChecked(MBCtrlDB.partyShow)
    ctrlRaidCheck:SetChecked(MBCtrlDB.raidShow)
	ctrlLockCheck:SetChecked(MBCtrlDB.locked)
	ctrlClampCheck:SetChecked(MBCtrlDB.clamped)
	ctrlVertCheck:SetChecked(MBCtrlDB.vertical)
	ctrlBgCheck:SetChecked(MBCtrlDB.bgHide)
	ctrlToolCheck:SetChecked(MBCtrlDB.tooltips)
	getglobal(ctrlScaleSlider:GetName().."Low"):SetText("50%")
	getglobal(ctrlScaleSlider:GetName().."High"):SetText("150%")
	getglobal(ctrlScaleSlider:GetName().."Text"):SetText(MB .." scale: "..math.floor((MBCtrlDB.scale*100)).."%")	
	ctrlScaleSlider:SetValue(MBCtrlDB.scale)
	getglobal(ctrlAlphaSlider:GetName().."Low"):SetText("0%")
	getglobal(ctrlAlphaSlider:GetName().."High"):SetText("100%")
	getglobal(ctrlAlphaSlider:GetName().."Text"):SetText(MB .." opacity: "..math.floor((MBCtrlDB.alpha*100)).."%")
	ctrlAlphaSlider:SetValue(MBCtrlDB.alpha)

	flareShowCheck:SetChecked(MBFlaresDB.shown)
    flareAloneCheck:SetChecked(MBFlaresDB.aloneShow)
	flarePartyCheck:SetChecked(MBFlaresDB.partyShow)
    flareRaidCheck:SetChecked(MBFlaresDB.raidShow)
	flareLockCheck:SetChecked(MBFlaresDB.locked)
	flareClampCheck:SetChecked(MBFlaresDB.clamped)
	flareflipCheck:SetChecked(MBFlaresDB.flipped)
	flarevertCheck:SetChecked(MBFlaresDB.vertical)
	flareBgCheck:SetChecked(MBFlaresDB.bgHide)
	flareToolCheck:SetChecked(MBFlaresDB.tooltips)
	getglobal(flareScaleSlider:GetName().."Low"):SetText("50%")
	getglobal(flareScaleSlider:GetName().."High"):SetText("150%")
	getglobal(flareScaleSlider:GetName().."Text"):SetText(MBF .. " scale: "..math.floor((MBFlaresDB.scale*100)).."%")	
	flareScaleSlider:SetValue(MBFlaresDB.scale)
	getglobal(flareAlphaSlider:GetName().."Low"):SetText("0%")
	getglobal(flareAlphaSlider:GetName().."High"):SetText("100%")
	getglobal(flareAlphaSlider:GetName().."Text"):SetText(MBF .. " opacity: "..math.floor((MBFlaresDB.alpha*100)).."%")
	flareAlphaSlider:SetValue(MBFlaresDB.alpha)
    
    MB_Update_Announce()
end
function MB_Update_Announce()
	AnnounceIntroCheck:SetChecked(MBDB.announce_intro)
	AnnounceIntroMsg:SetText(MBDB.msg_intro)
    AnnounceIntroMsg:SetCursorPosition(0)
	AnnounceskullCheck:SetChecked(MBDB.announce_skull)
	AnnounceskullMsg:SetText(MBDB.msg_skull)
    AnnounceskullMsg:SetCursorPosition(0)
	AnnouncecrossCheck:SetChecked(MBDB.announce_cross)
	AnnouncecrossMsg:SetText(MBDB.msg_cross)
    AnnouncecrossMsg:SetCursorPosition(0)
	AnnouncesquareCheck:SetChecked(MBDB.announce_square)
	AnnouncesquareMsg:SetText(MBDB.msg_square)
	AnnouncesquareMsg:SetCursorPosition(0)
    AnnouncemoonCheck:SetChecked(MBDB.announce_moon)
	AnnouncemoonMsg:SetText(MBDB.msg_moon)
	AnnouncemoonMsg:SetCursorPosition(0)
    AnnouncetriangleCheck:SetChecked(MBDB.announce_triangle)
	AnnouncetriangleMsg:SetText(MBDB.msg_triangle)
	AnnouncetriangleMsg:SetCursorPosition(0)
    AnnouncediamondCheck:SetChecked(MBDB.announce_diamond)
	AnnouncediamondMsg:SetText(MBDB.msg_diamond)
	AnnouncediamondMsg:SetCursorPosition(0)
    AnnouncecircleCheck:SetChecked(MBDB.announce_circle)
	AnnouncecircleMsg:SetText(MBDB.msg_circle)
	AnnouncecircleMsg:SetCursorPosition(0)
    AnnouncestarCheck:SetChecked(MBDB.announce_star)
	AnnouncestarMsg:SetText(MBDB.msg_star)
    AnnouncestarMsg:SetCursorPosition(0)
    AnnouncefooterCheck:SetChecked(MBDB.announce_footer)
	AnnouncefooterMsg:SetText(MBDB.msg_footer)
    AnnouncefooterMsg:SetCursorPosition(0)
    AnnouncerwCheck:SetChecked(MBFlaresDB.announce_rw)
    AnnouncerwMsg:SetText(MBFlaresDB.msg_rw)
    AnnouncerwMsg:SetCursorPosition(0)
    AnnouncetooltipCheck:SetChecked(MBDB.announce_tooltip)
end

function MB_Announce_Save()
	MBDB.msg_intro = AnnounceIntroMsg:GetText()
	MBDB.msg_skull = AnnounceskullMsg:GetText()
	MBDB.msg_cross = AnnouncecrossMsg:GetText()
	MBDB.msg_square = AnnouncesquareMsg:GetText()
	MBDB.msg_moon = AnnouncemoonMsg:GetText()
	MBDB.msg_triangle = AnnouncetriangleMsg:GetText()
	MBDB.msg_diamond = AnnouncediamondMsg:GetText()
	MBDB.msg_circle = AnnouncecircleMsg:GetText()
	MBDB.msg_star = AnnouncestarMsg:GetText()
    MBDB.msg_footer = AnnouncefooterMsg:GetText()
    MBFlaresDB.msg_rw = AnnouncerwMsg:GetText()
end

-------------------------------------------------------
-- Slash Commands
-------------------------------------------------------

SLASH_MB1 = '/MB'
SLASH_MB2 = '/MBF'
SLASH_MB3 = "/MARKINGBAR"
SLASH_MB4 = "/MBFLARES"
SLASH_MB5 = "/MARKINGBARFLARES"
function SlashCmdList.MB(msg, editbox)
	if (msg=="reset") then
		MB_reset()
    elseif (msg=="options") then
		InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.panel)
	else
		InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.panel)
	end
end

----------------
-- Main Options Page
----------------

MarkingBarOpt = {};
MarkingBarOpt.panel = CreateFrame( "Frame", "MarkingBarOpt", InterfaceOptionsFramePanelContainer );
MarkingBarOpt.panel.name = "Marking Bar";
MarkingBarOpt.panel.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.panel.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.panel.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.panel);

local MBOptionsText = MarkingBarOpt.panel:CreateFontString("MBOptionsText", "OVERLAY", "ChatFontNormal")
MBOptionsText:SetPoint("TOP", MarkingBarOpt.panel, "TOP",0,-10)
MBOptionsText:SetText(MB.."|cffe1a500 Options")
local OptionsText = MarkingBarOpt.panel:CreateFontString("OptionsText", "OVERLAY", "ChatFontSmall")
OptionsText:SetPoint("TOPLEFT", MarkingBarOpt.panel, "TOPLEFT",25,-30)
OptionsText:SetText("Expand the MarkingBar (+) on the left to see the options.")

local versFooter = CreateFrame("Frame", "versFooter", MarkingBarOpt.panel)
versFooter:SetBackdrop(defaultBackdrop)
versFooter:SetBackdropColor(0.1,0.1,0.1,0.9)
versFooter:SetBackdropBorderColor(1,1,1,0.5)
versFooter:SetPoint("BOTTOM", MarkingBarOpt.panel, "BOTTOM",0,5)
versFooter:SetSize(175,23)
local versionText = versFooter:CreateFontString("versionText", "OVERLAY", "ChatFontSmall")
versionText:SetPoint("TOP", versFooter, "TOP",0,-5)
versionText:SetText(MB..curVer)

----------------
-- Marker Options Page
----------------
MarkingBarOpt.childpanel1 = CreateFrame( "Frame", "optionsMarker", MarkingBarOpt.panel);
MarkingBarOpt.childpanel1.name = "Markers";
MarkingBarOpt.childpanel1.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.childpanel1.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel1.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel1.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.childpanel1.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.childpanel1);

local markerOptionsText = MarkingBarOpt.childpanel1:CreateFontString("markerOptionsText", "OVERLAY", "ChatFontNormal")
markerOptionsText:SetPoint("TOP", MarkingBarOpt.childpanel1, "TOP",0,-10) 
markerOptionsText:SetText(MB.."|cffe1a500 Options")

local showCheck = CreateFrame("CheckButton", "showCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
showCheck:SetPoint("TOPLEFT", MarkingBarOpt.childpanel1, "TOPLEFT",25,-30)
showCheck:SetSize(20,20)
showCheck:SetScript("OnClick", function(self) if (MBDB.shown == true) then MBDB.shown = false else MBDB.shown = true end MB_targetChecker("main") end)
local showText = MarkingBarOpt.childpanel1:CreateFontString("showText", "OVERLAY", "ChatFontSmall")
showText:SetPoint("LEFT", showCheck, "RIGHT", 5,0)
showText:SetText("Always show "..MB.." with or without a target")

local partyRaidText = MarkingBarOpt.childpanel1:CreateFontString("partyRaidText", "OVERLAY", "ChatFontSmall")
partyRaidText:SetPoint("TOPLEFT", showCheck,"BOTTOMLEFT",0,-5)
partyRaidText:SetText("Show "..MB.." when...")

local aloneCheck = CreateFrame("CheckButton", "aloneCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
aloneCheck:SetPoint("TOPLEFT", partyRaidText,"BOTTOMLEFT",0,-2)
aloneCheck:SetSize(20,20)
aloneCheck:SetScript("OnClick", function(self) if (MBDB.aloneShow == true) then MBDB.aloneShow = false else MBDB.aloneShow = true end MB_targetChecker("main") end)
local aloneText = MarkingBarOpt.childpanel1:CreateFontString("aloneText", "OVERLAY", "ChatFontSmall")
aloneText:SetPoint("LEFT", aloneCheck, "RIGHT", 5,0)
aloneText:SetText(" Alone")

local partyCheck = CreateFrame("CheckButton", "partyCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
partyCheck:SetPoint("LEFT", aloneText, "RIGHT",20,0)
partyCheck:SetSize(20,20)
partyCheck:SetScript("OnClick", function(self) if (MBDB.partyShow == true) then MBDB.partyShow = false else MBDB.partyShow = true end MB_targetChecker("main") end)
local partyText = MarkingBarOpt.childpanel1:CreateFontString("partyText", "OVERLAY", "ChatFontSmall")
partyText:SetPoint("LEFT", partyCheck, "RIGHT", 5,0)
partyText:SetText(" in a Party ")

local raidCheck = CreateFrame("CheckButton", "raidCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
raidCheck:SetPoint("LEFT", partyText, "RIGHT",20,0)
raidCheck:SetSize(20,20)
raidCheck:SetScript("OnClick", function(self) if (MBDB.raidShow == true) then MBDB.raidShow = false else MBDB.raidShow = true end MB_targetChecker("main") end)
local raidText = MarkingBarOpt.childpanel1:CreateFontString("raidText", "OVERLAY", "ChatFontSmall")
raidText:SetPoint("LEFT", raidCheck, "RIGHT", 5,0)
raidText:SetText(" in a Raid ")

local lockCheck = CreateFrame("CheckButton", "lockCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
lockCheck:SetPoint("TOP",aloneCheck,"BOTTOM",0,-5)
lockCheck:SetSize(20,20)
lockCheck:SetScript("OnClick", function(self) MB_lockToggle("main") MB_checkUpdater() end)
local lockText = MarkingBarOpt.childpanel1:CreateFontString("lockText", "OVERLAY", "ChatFontSmall")
lockText:SetPoint("LEFT", lockCheck, "RIGHT", 5,0)
lockText:SetText("Lock "..MB.."'s position")

local clampCheck = CreateFrame("CheckButton", "clampCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
clampCheck:SetPoint("TOP",lockCheck,"BOTTOM",0,-5)
clampCheck:SetSize(20,20)
clampCheck:SetScript("OnClick", function(self) if (MBDB.clamped==true) then MBDB.clamped = false MB_mainFrame:SetClampedToScreen(false) else MBDB.clamped = true MB_mainFrame:SetClampedToScreen(true) end end)
local clampText = MarkingBarOpt.childpanel1:CreateFontString("clampText", "OVERLAY", "ChatFontSmall")
clampText:SetPoint("LEFT", clampCheck, "RIGHT", 5,0)
clampText:SetText("Keep "..MB.." inside screen edges")

local flipCheck = CreateFrame("CheckButton", "flipCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
flipCheck:SetPoint("TOP",clampCheck,"BOTTOM",0,-5)
flipCheck:SetSize(20,20)
flipCheck:SetScript("OnClick", function(self) if (MBDB.flipped==true) then MBDB.flipped = false else MBDB.flipped = true end; MB_flipChecker() end)
local flipText = MarkingBarOpt.childpanel1:CreateFontString("flipText", "OVERLAY", "ChatFontSmall")
flipText:SetPoint("LEFT", flipCheck, "RIGHT", 5,0)
flipText:SetText("Reverse "..MB.."'s icon order")

local vertCheck = CreateFrame("CheckButton", "vertCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
vertCheck:SetPoint("TOP",flipCheck,"BOTTOM",0,-5)
vertCheck:SetSize(20,20)
vertCheck:SetScript("OnClick", function(self) if (MBDB.vertical==true) then MBDB.vertical = false else MBDB.vertical = true end; MB_flipChecker() end)
local vertText = MarkingBarOpt.childpanel1:CreateFontString("vertText", "OVERLAY", "ChatFontSmall")
vertText:SetPoint("LEFT", vertCheck, "RIGHT", 5,0)
vertText:SetText("Display "..MB.." vertically")

local bgCheck = CreateFrame("CheckButton", "bgCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
bgCheck:SetPoint("TOP",vertCheck,"BOTTOM",0,-5)
bgCheck:SetSize(20,20)
bgCheck:SetScript("OnClick", function(self) MB_bgToggle("main") end)
local bgText = MarkingBarOpt.childpanel1:CreateFontString("bgText", "OVERLAY", "ChatFontSmall")
bgText:SetPoint("LEFT", bgCheck, "RIGHT", 5,0)
bgText:SetText("Hide "..MB.."'s background and border")

local toolCheck = CreateFrame("CheckButton", "toolCheck", MarkingBarOpt.childpanel1, "UICheckButtonTemplate")
toolCheck:SetPoint("TOP",bgCheck,"BOTTOM",0,-5)
toolCheck:SetSize(20,20)
toolCheck:SetScript("OnClick", function(self) if (MBDB.tooltips==true) then MBDB.tooltips = false else MBDB.tooltips = true end end)
local toolText = MarkingBarOpt.childpanel1:CreateFontString("toolText", "OVERLAY", "ChatFontSmall")
toolText:SetPoint("LEFT", toolCheck, "RIGHT", 5,0)
toolText:SetText("Enable "..MB.."'s tooltips")

local alphaSlider = CreateFrame("Slider", "alphaSlider", MarkingBarOpt.childpanel1, "OptionsSliderTemplate")
alphaSlider:SetPoint("TOPLEFT", toolCheck, "BOTTOMLEFT",25,-25)
alphaSlider:SetSize(180,16)
alphaSlider:SetMinMaxValues(0,1)
alphaSlider:SetValue(1)
alphaSlider:SetValueStep(0.01)
alphaSlider:SetOrientation("HORIZONTAL")
alphaSlider:SetScript("OnValueChanged", function(self) MB_alpha(self,"main") end)
alphaSlider:SetScript("OnLoad", function(self) MB_alpha(self,"main") end)

local scaleSlider = CreateFrame("Slider", "scaleSlider", MarkingBarOpt.childpanel1, "OptionsSliderTemplate")
scaleSlider:SetPoint("TOPLEFT", alphaSlider, "BOTTOMLEFT",0,-25)
scaleSlider:SetSize(180,16)
scaleSlider:SetMinMaxValues(0.5,1.5)
scaleSlider:SetValue(1)
scaleSlider:SetValueStep(0.01)
scaleSlider:SetOrientation("HORIZONTAL")
scaleSlider:SetScript("OnValueChanged", function(self) MB_scale(self,"main") end)
scaleSlider:SetScript("OnLoad", function(self) MB_scale(self,"main") end)


----------------
-- Control Options Page
----------------
MarkingBarOpt.childpanel2 = CreateFrame( "Frame", "optionsControl", MarkingBarOpt.panel);
MarkingBarOpt.childpanel2.name = "Controls";
MarkingBarOpt.childpanel2.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.childpanel2.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel2.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel2.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.childpanel2.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.childpanel2);

local ctrlOptionsText = MarkingBarOpt.childpanel2:CreateFontString("ctrlOptionsText", "OVERLAY", "ChatFontNormal")
ctrlOptionsText:SetPoint("TOP", MarkingBarOpt.childpanel2, "TOP",0,-10)
ctrlOptionsText:SetText(MB.."|cffe1a500 Control Options")

local ctrlShowCheck = CreateFrame("CheckButton", "ctrlShowCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlShowCheck:SetPoint("TOPLEFT", MarkingBarOpt.childpanel2, "TOPLEFT",25,-30)
ctrlShowCheck:SetSize(20,20)
ctrlShowCheck:SetScript("OnClick", function(self) if (MBCtrlDB.shown == true) then MBCtrlDB.shown = false else MBCtrlDB.shown = true end MB_targetChecker("ctrl") end)
MarkingBarOpt.childpanel2:CreateFontString("ctrlShowText", "OVERLAY", "ChatFontSmall")
ctrlShowText:SetPoint("LEFT", ctrlShowCheck, "RIGHT", 5,0)
ctrlShowText:SetText("Always show "..MB.." controls  with or without a target")

local ctrlPartyRaidText = MarkingBarOpt.childpanel2:CreateFontString("ctrlPartyRaidText", "OVERLAY", "ChatFontSmall")
ctrlPartyRaidText:SetPoint("TOPLEFT", ctrlShowCheck,"BOTTOMLEFT",0,-5)
ctrlPartyRaidText:SetText("Show "..MB.." controls  when...")

local ctrlAloneCheck = CreateFrame("CheckButton", "ctrlAloneCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlAloneCheck:SetPoint("TOPLEFT", ctrlPartyRaidText,"BOTTOMLEFT",0,-2)
ctrlAloneCheck:SetSize(20,20)
ctrlAloneCheck:SetScript("OnClick", function(self) if (MBCtrlDB.aloneShow == true) then MBCtrlDB.aloneShow = false else MBCtrlDB.aloneShow = true end MB_targetChecker("ctrl") end)
local ctrlAloneText = MarkingBarOpt.childpanel2:CreateFontString("ctrlAloneText", "OVERLAY", "ChatFontSmall")
ctrlAloneText:SetPoint("LEFT", ctrlAloneCheck, "RIGHT", 5,0)
ctrlAloneText:SetText(" Alone")

local ctrlPartyCheck = CreateFrame("CheckButton", "ctrlPartyCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlPartyCheck:SetPoint("LEFT", ctrlAloneText, "RIGHT",20,0)
ctrlPartyCheck:SetSize(20,20)
ctrlPartyCheck:SetScript("OnClick", function(self) if (MBCtrlDB.partyShow == true) then MBCtrlDB.partyShow = false else MBCtrlDB.partyShow = true end MB_targetChecker("ctrl") end)
local ctrlPartyText = MarkingBarOpt.childpanel2:CreateFontString("ctrlPartyText", "OVERLAY", "ChatFontSmall")
ctrlPartyText:SetPoint("LEFT", ctrlPartyCheck, "RIGHT", 5,0)
ctrlPartyText:SetText(" in a Party ")

local ctrlRaidCheck = CreateFrame("CheckButton", "ctrlRaidCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlRaidCheck:SetPoint("LEFT", ctrlPartyText, "RIGHT",20,0)
ctrlRaidCheck:SetSize(20,20)
ctrlRaidCheck:SetScript("OnClick", function(self) if (MBCtrlDB.raidShow == true) then MBCtrlDB.raidShow = false else MBCtrlDB.raidShow = true end MB_targetChecker("ctrl") end)
local ctrlRaidText = MarkingBarOpt.childpanel2:CreateFontString("ctrlRaidText", "OVERLAY", "ChatFontSmall")
ctrlRaidText:SetPoint("LEFT", ctrlRaidCheck, "RIGHT", 5,0)
ctrlRaidText:SetText(" in a Raid ")

local ctrlCheck = CreateFrame("CheckButton", "ctrlCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlCheck:SetPoint("TOP",ctrlAloneCheck,"BOTTOM",0,-5)
ctrlCheck:SetSize(20,20)
ctrlCheck:SetScript("OnClick", function(self) MB_ctrlLockToggle(); MB_checkUpdater(); end)
local ctrlText = MarkingBarOpt.childpanel2:CreateFontString("ctrlText", "OVERLAY", "ChatFontSmall")
ctrlText:SetPoint("LEFT", ctrlCheck, "RIGHT", 5,0)
ctrlText:SetText("Connect "..MB.."'s controls to the raid icons.")

local ctrlLockCheck = CreateFrame("CheckButton", "ctrlLockCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlLockCheck:SetPoint("TOP",ctrlCheck, "BOTTOM",0,-5)
ctrlLockCheck:SetSize(20,20)
ctrlLockCheck:SetScript("OnClick", function(self) MB_lockToggle("ctrl"); MB_checkUpdater(); end)
ctrlLockCheck:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Note: Changing this options will disconnect controls from the raid icons.",0.88,0.65,0); GameTooltip:Show() end)
ctrlLockCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local ctrlLockText = MarkingBarOpt.childpanel2:CreateFontString("ctrlLockText", "OVERLAY", "ChatFontSmall")
ctrlLockText:SetPoint("LEFT", ctrlLockCheck, "RIGHT", 5,0)
ctrlLockText:SetText("Lock "..MB.." control's position.")

local ctrlClampCheck = CreateFrame("CheckButton", "ctrlClampCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlClampCheck:SetPoint("TOP",ctrlLockCheck,"BOTTOM",0,-5)
ctrlClampCheck:SetSize(20,20)
ctrlClampCheck:SetScript("OnClick", function(self) if (MBCtrlDB.clamped==true) then	MBCtrlDB.clamped = false MB_controlFrame:SetClampedToScreen(false) else MBCtrlDB.clamped = true MB_controlFrame:SetClampedToScreen(true) end end)
local ctrlClampText = MarkingBarOpt.childpanel2:CreateFontString("ctrlClampText", "OVERLAY", "ChatFontSmall")
ctrlClampText:SetPoint("LEFT", ctrlClampCheck, "RIGHT", 5,0)
ctrlClampText:SetText("Keep "..MB.." controls  inside screen edges")

local ctrlVertCheck = CreateFrame("CheckButton", "ctrlVertCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlVertCheck:SetPoint("TOP",ctrlClampCheck,"BOTTOM",0,-5)
ctrlVertCheck:SetSize(20,20)
ctrlVertCheck:SetScript("OnClick", function(self) if (MBCtrlDB.vertical==true) then MBCtrlDB.vertical = false else MBCtrlDB.vertical = true end; if MBDB.ctrlLock then MB_ctrlUnlock() end; MB_flipChecker(); MB_checkUpdater() end)
ctrlVertCheck:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Note: Changing this options will disconnect controls from the raid icons.",0.88,0.65,0); GameTooltip:Show() end)
ctrlVertCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local ctrlVertText = MarkingBarOpt.childpanel2:CreateFontString("ctrlvertText", "OVERLAY", "ChatFontSmall")
ctrlVertText:SetPoint("LEFT", ctrlVertCheck, "RIGHT", 5,0)
ctrlVertText:SetText("Display "..MB.." controls  vertically")

local ctrlBgCheck = CreateFrame("CheckButton", "ctrlBgCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlBgCheck:SetPoint("TOP",ctrlVertCheck,"BOTTOM",0,-5)
ctrlBgCheck:SetSize(20,20)
ctrlBgCheck:SetScript("OnClick", function(self) MB_bgToggle("ctrl") end)
local ctrlBgText = MarkingBarOpt.childpanel2:CreateFontString("ctrlBgText", "OVERLAY", "ChatFontSmall")
ctrlBgText:SetPoint("LEFT", ctrlBgCheck, "RIGHT", 5,0)
ctrlBgText:SetText("Hide "..MB.." controls 's background and borders")

local ctrlToolCheck = CreateFrame("CheckButton", "ctrlToolCheck", MarkingBarOpt.childpanel2, "UICheckButtonTemplate")
ctrlToolCheck:SetPoint("TOP",ctrlBgCheck,"BOTTOM",0,-5)
ctrlToolCheck:SetSize(20,20)
ctrlToolCheck:SetScript("OnClick", function(self) if (MBCtrlDB.tooltips==true) then MBCtrlDB.tooltips = false else MBCtrlDB.tooltips = true end end)
local ctrlToolText = MarkingBarOpt.childpanel2:CreateFontString("ctrlToolText", "OVERLAY", "ChatFontSmall")
ctrlToolText:SetPoint("LEFT", ctrlToolCheck, "RIGHT", 5,0)
ctrlToolText:SetText("Enable "..MB.." controls 's tooltips")

local ctrlAlphaSlider = CreateFrame("Slider", "ctrlAlphaSlider", MarkingBarOpt.childpanel2, "OptionsSliderTemplate")
ctrlAlphaSlider:SetPoint("TOPLEFT", ctrlToolCheck, "BOTTOMLEFT",25,-25)
ctrlAlphaSlider:SetSize(180,16)
ctrlAlphaSlider:SetMinMaxValues(0,1)
ctrlAlphaSlider:SetValue(1)
ctrlAlphaSlider:SetValueStep(0.01)
ctrlAlphaSlider:SetOrientation("HORIZONTAL")
ctrlAlphaSlider:SetScript("OnValueChanged", function(self) MB_alpha(self,"ctrl") end)
ctrlAlphaSlider:SetScript("OnLoad", function(self) MB_alpha(self,"ctrl") end)

local ctrlScaleSlider = CreateFrame("Slider", "ctrlScaleSlider", MarkingBarOpt.childpanel2, "OptionsSliderTemplate")
ctrlScaleSlider:SetPoint("TOPLEFT", ctrlAlphaSlider, "BOTTOMLEFT",0,-25)
ctrlScaleSlider:SetSize(180,16)
ctrlScaleSlider:SetMinMaxValues(0.5,1.5)
ctrlScaleSlider:SetValue(1)
ctrlScaleSlider:SetValueStep(0.01)
ctrlScaleSlider:SetOrientation("HORIZONTAL")
ctrlScaleSlider:SetScript("OnValueChanged", function(self) MB_scale(self,"ctrl") end)
ctrlScaleSlider:SetScript("OnLoad", function(self) MB_scale (self,"ctrl") end)


----------------
-- Flares Options Page
----------------
MarkingBarOpt.childpanel3 = CreateFrame( "Frame", "optionsFlares", MarkingBarOpt.panel);
MarkingBarOpt.childpanel3.name = "Flares";
MarkingBarOpt.childpanel3.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.childpanel3.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel3.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel3.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.childpanel3.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.childpanel3);

local flareOptionsText = MarkingBarOpt.childpanel3:CreateFontString("flareOptionsText", "OVERLAY", "ChatFontNormal")
flareOptionsText:SetPoint("TOP", MarkingBarOpt.childpanel3, "TOP",0,-10)
flareOptionsText:SetText(MBF.."|cffe1a500 Options")

local flareShowCheck = CreateFrame("CheckButton", "flareShowCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareShowCheck:SetPoint("TOPLEFT", MarkingBarOpt.childpanel3, "TOPLEFT",25,-30)
flareShowCheck:SetSize(20,20)
flareShowCheck:SetScript("OnClick", function(self) if (MBFlaresDB.shown == true) then MBFlaresDB.shown = false else MBFlaresDB.shown = true end MB_targetChecker("flare") end)
MarkingBarOpt.childpanel3:CreateFontString("flareShowText", "OVERLAY", "ChatFontSmall")
flareShowText:SetPoint("LEFT", flareShowCheck, "RIGHT", 5,0)
flareShowText:SetText("Always show "..MBF.." with or without a target")

local flarePartyRaidText = MarkingBarOpt.childpanel3:CreateFontString("flarePartyRaidText", "OVERLAY", "ChatFontSmall")
flarePartyRaidText:SetPoint("TOPLEFT", flareShowCheck,"BOTTOMLEFT",0,-5)
flarePartyRaidText:SetText("Show "..MBF.." when...")

local flareAloneCheck = CreateFrame("CheckButton", "flareAloneCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareAloneCheck:SetPoint("TOPLEFT", flarePartyRaidText,"BOTTOMLEFT",0,-2)
flareAloneCheck:SetSize(20,20)
flareAloneCheck:SetScript("OnClick", function(self) if (MBFlaresDB.aloneShow == true) then MBFlaresDB.aloneShow = false else MBFlaresDB.aloneShow = true end MB_targetChecker("flare") end)
local flareAloneText = MarkingBarOpt.childpanel3:CreateFontString("flareAloneText", "OVERLAY", "ChatFontSmall")
flareAloneText:SetPoint("LEFT", flareAloneCheck, "RIGHT", 5,0)
flareAloneText:SetText(" Alone")

local flarePartyCheck = CreateFrame("CheckButton", "flarePartyCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flarePartyCheck:SetPoint("LEFT", flareAloneText, "RIGHT",20,0)
flarePartyCheck:SetSize(20,20)
flarePartyCheck:SetScript("OnClick", function(self) if (MBFlaresDB.partyShow == true) then MBFlaresDB.partyShow = false else MBFlaresDB.partyShow = true end MB_targetChecker("flare") end)
local flarePartyText = MarkingBarOpt.childpanel3:CreateFontString("flarePartyText", "OVERLAY", "ChatFontSmall")
flarePartyText:SetPoint("LEFT", flarePartyCheck, "RIGHT", 5,0)
flarePartyText:SetText(" in a Party ")

local flareRaidCheck = CreateFrame("CheckButton", "flareRaidCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareRaidCheck:SetPoint("LEFT", flarePartyText, "RIGHT",20,0)
flareRaidCheck:SetSize(20,20)
flareRaidCheck:SetScript("OnClick", function(self) if (MBFlaresDB.raidShow == true) then MBFlaresDB.raidShow = false else MBFlaresDB.raidShow = true end MB_targetChecker("flare") end)
local flareRaidText = MarkingBarOpt.childpanel3:CreateFontString("flareRaidText", "OVERLAY", "ChatFontSmall")
flareRaidText:SetPoint("LEFT", flareRaidCheck, "RIGHT", 5,0)
flareRaidText:SetText(" in a Raid ")

local flareLockCheck = CreateFrame("CheckButton", "flareLockCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareLockCheck:SetPoint("TOP",flareAloneCheck, "BOTTOM",0,-5)
flareLockCheck:SetSize(20,20)
flareLockCheck:SetScript("OnClick", function(self) MB_lockToggle("flare") end)
local flareLockText = MarkingBarOpt.childpanel3:CreateFontString("flareLockText", "OVERLAY", "ChatFontSmall")
flareLockText:SetPoint("LEFT", flareLockCheck, "RIGHT", 5,0)
flareLockText:SetText("Lock "..MBF.."'s position")

local flareClampCheck = CreateFrame("CheckButton", "flareClampCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareClampCheck:SetPoint("TOP",flareLockCheck,"BOTTOM",0,-5)
flareClampCheck:SetSize(20,20)
flareClampCheck:SetScript("OnClick", function(self) if (MBFlaresDB.clamped==true) then	MBFlaresDB.clamped = false	MBFlares_mainFrame:SetClampedToScreen(false) else MBFlaresDB.clamped = true MBFlares_mainFrame:SetClampedToScreen(true)	end end)
local flareClampText = MarkingBarOpt.childpanel3:CreateFontString("flareClampText", "OVERLAY", "ChatFontSmall")
flareClampText:SetPoint("LEFT", flareClampCheck, "RIGHT", 5,0)
flareClampText:SetText("Keep "..MBF.." inside screen edges")

local flareFlipCheck = CreateFrame("CheckButton", "flareflipCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareFlipCheck:SetPoint("TOP",flareClampCheck,"BOTTOM",0,-5)
flareFlipCheck:SetSize(20,20)
flareFlipCheck:SetScript("OnClick", function(self) if (MBFlaresDB.flipped==true) then MBFlaresDB.flipped = false else MBFlaresDB.flipped = true end; MB_flareflipChecker() end)
local flareFlipText = MarkingBarOpt.childpanel3:CreateFontString("flareflipText", "OVERLAY", "ChatFontSmall")
flareFlipText:SetPoint("LEFT", flareflipCheck, "RIGHT", 5,0)
flareFlipText:SetText("Reverse "..MBF.."'s icon order")

local flareVertCheck = CreateFrame("CheckButton", "flarevertCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareVertCheck:SetPoint("TOP",flareflipCheck,"BOTTOM",0,-5)
flareVertCheck:SetSize(20,20)
flareVertCheck:SetScript("OnClick", function(self) if (MBFlaresDB.vertical==true) then MBFlaresDB.vertical = false else MBFlaresDB.vertical = true end; MB_flareflipChecker() end)
local flareVertText = MarkingBarOpt.childpanel3:CreateFontString("flarevertText", "OVERLAY", "ChatFontSmall")
flareVertText:SetPoint("LEFT", flarevertCheck, "RIGHT", 5,0)
flareVertText:SetText("Display "..MBF.." vertically")

local flareBgCheck = CreateFrame("CheckButton", "flareBgCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareBgCheck:SetPoint("TOP",flarevertCheck,"BOTTOM",0,-5)
flareBgCheck:SetSize(20,20)
flareBgCheck:SetScript("OnClick", function(self) MB_bgToggle("flare") end)
local flareBgText = MarkingBarOpt.childpanel3:CreateFontString("flareBgText", "OVERLAY", "ChatFontSmall")
flareBgText:SetPoint("LEFT", flareBgCheck, "RIGHT", 5,0)
flareBgText:SetText("Hide "..MBF.."'s background and borders")

local flareToolCheck = CreateFrame("CheckButton", "flareToolCheck", MarkingBarOpt.childpanel3, "UICheckButtonTemplate")
flareToolCheck:SetPoint("TOP",flareBgCheck,"BOTTOM",0,-5)
flareToolCheck:SetSize(20,20)
flareToolCheck:SetScript("OnClick", function(self) if (MBFlaresDB.tooltips==true) then MBFlaresDB.tooltips = false else MBFlaresDB.tooltips = true end end)
local flareToolText = MarkingBarOpt.childpanel3:CreateFontString("flareToolText", "OVERLAY", "ChatFontSmall")
flareToolText:SetPoint("LEFT", flareToolCheck, "RIGHT", 5,0)
flareToolText:SetText("Enable "..MBF.."'s tooltips")

local flareAlphaSlider = CreateFrame("Slider", "flareAlphaSlider", MarkingBarOpt.childpanel3, "OptionsSliderTemplate")
flareAlphaSlider:SetPoint("TOPLEFT", flareToolCheck, "BOTTOMLEFT",25,-25)
flareAlphaSlider:SetSize(180,16)
flareAlphaSlider:SetMinMaxValues(0,1)
flareAlphaSlider:SetValue(1)
flareAlphaSlider:SetValueStep(0.01)
flareAlphaSlider:SetOrientation("HORIZONTAL")
flareAlphaSlider:SetScript("OnValueChanged", function(self) MB_alpha(self,"flare") end)
flareAlphaSlider:SetScript("OnLoad", function(self) MB_alpha(self,"flare") end)

local flareScaleSlider = CreateFrame("Slider", "flareScaleSlider", MarkingBarOpt.childpanel3, "OptionsSliderTemplate")
flareScaleSlider:SetPoint("TOPLEFT", flareAlphaSlider, "BOTTOMLEFT",0,-25)
flareScaleSlider:SetSize(180,16)
flareScaleSlider:SetMinMaxValues(0.5,1.5)
flareScaleSlider:SetValue(1)
flareScaleSlider:SetValueStep(0.01)
flareScaleSlider:SetOrientation("HORIZONTAL")
flareScaleSlider:SetScript("OnValueChanged", function(self) MB_scale(self,"flare") end)
flareScaleSlider:SetScript("OnLoad", function(self) MB_scale(self,"flare") end)

----------------
-- Announce Options Page
----------------
MarkingBarOpt.childpanel4 = CreateFrame( "Frame", "optionsAnnounce", MarkingBarOpt.panel);
MarkingBarOpt.childpanel4.name = "Marker Announcements";
MarkingBarOpt.childpanel4.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.childpanel4.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel4.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.childpanel4.default = function(self) MB_reset(); end
MarkingBarOpt.childpanel4.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.childpanel4);

local AnnounceOptionsText = MarkingBarOpt.childpanel4:CreateFontString("AnnounceOptionsText", "OVERLAY", "ChatFontNormal")
AnnounceOptionsText:SetPoint("TOP", MarkingBarOpt.childpanel4, "TOP",0,-10)
AnnounceOptionsText:SetText("|cffe1a500Chat Announcement Options")

local AnnounceInstText1 = MarkingBarOpt.childpanel4:CreateFontString("AnnounceInstText", "OVERLAY", "ChatFontSmall")
AnnounceInstText1:SetPoint("TOPLEFT", MarkingBarOpt.childpanel4, "TOPLEFT", 10,-30)
AnnounceInstText1:SetText("Send")

local AnnounceInstText2 = MarkingBarOpt.childpanel4:CreateFontString("AnnounceInstText", "OVERLAY", "ChatFontSmall")
AnnounceInstText2:SetPoint("TOP", MarkingBarOpt.childpanel4, "TOP", 0, -30)
AnnounceInstText2:SetText("Enter the chat messages to send:")

local AnnounceIntroCheck = CreateFrame("CheckButton", "AnnounceIntroCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnounceIntroCheck:SetPoint("TOPLEFT", MarkingBarOpt.childpanel4, "TOPLEFT", 10,-50)
AnnounceIntroCheck:SetSize(20,20)
AnnounceIntroCheck:SetScript("OnClick", function(self) if (MBDB.announce_intro==true) then MBDB.announce_intro = false; else MBDB.announce_intro = true; end end)
local AnnounceIntroMsg = CreateFrame("EditBox", "AnnounceIntroMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnounceIntroMsg:SetPoint("LEFT", AnnounceIntroCheck, "RIGHT", 10,0)
AnnounceIntroMsg:SetSize(320,20)
AnnounceIntroMsg:SetFont("Fonts\\ARIALN.TTF", 12)

local AnnounceskullCheck = CreateFrame("CheckButton", "AnnounceskullCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnounceskullCheck:SetPoint("TOP", AnnounceIntroCheck, "BOTTOM",0,-15)
AnnounceskullCheck:SetSize(20,20)
AnnounceskullCheck:SetScript("OnClick", function(self) if (MBDB.announce_skull==true) then MBDB.announce_skull = false; else MBDB.announce_skull = true; end end)
local AnnounceskullMsg = CreateFrame("EditBox", "AnnounceskullMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnounceskullMsg:SetPoint("LEFT", AnnounceskullCheck, "RIGHT", 10,0)
AnnounceskullMsg:SetSize(320,20)
AnnounceskullMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnounceskullIcon = CreateFrame("Button", "AnnounceSkullIcon", MarkingBarOpt.childpanel4)
AnnounceskullIcon:SetSize(20,20)
AnnounceskullIcon:SetPoint("LEFT", AnnounceskullMsg, "Right",5,0)
AnnounceskullIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnounceskullIcon:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
AnnounceskullIcon:EnableMouse(false)

local AnnouncecrossCheck = CreateFrame("CheckButton", "AnnouncecrossCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncecrossCheck:SetPoint("TOP", AnnounceskullCheck, "BOTTOM",0,-5)
AnnouncecrossCheck:SetSize(20,20)
AnnouncecrossCheck:SetScript("OnClick", function(self) if (MBDB.announce_cross==true) then MBDB.announce_cross = false; else MBDB.announce_cross = true; end end)
local AnnouncecrossMsg = CreateFrame("EditBox", "AnnouncecrossMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncecrossMsg:SetPoint("LEFT", AnnouncecrossCheck, "RIGHT", 10,0)
AnnouncecrossMsg:SetSize(320,20)
AnnouncecrossMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncecrossIcon = CreateFrame("Button", "AnnouncecrossIcon", MarkingBarOpt.childpanel4)
AnnouncecrossIcon:SetSize(20,20)
AnnouncecrossIcon:SetPoint("LEFT", AnnouncecrossMsg, "Right",5,0)
AnnouncecrossIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncecrossIcon:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
AnnouncecrossIcon:EnableMouse(false)

local AnnouncesquareCheck = CreateFrame("CheckButton", "AnnouncesquareCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncesquareCheck:SetPoint("TOP", AnnouncecrossCheck, "BOTTOM",0,-5)
AnnouncesquareCheck:SetSize(20,20)
AnnouncesquareCheck:SetScript("OnClick", function(self) if (MBDB.announce_square==true) then MBDB.announce_square = false; else MBDB.announce_square = true; end end)
local AnnouncesquareMsg = CreateFrame("EditBox", "AnnouncesquareMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncesquareMsg:SetPoint("LEFT", AnnouncesquareCheck, "RIGHT", 10,0)
AnnouncesquareMsg:SetSize(320,20)
AnnouncesquareMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncesquareIcon = CreateFrame("Button", "AnnouncesquareIcon", MarkingBarOpt.childpanel4)
AnnouncesquareIcon:SetSize(20,20)
AnnouncesquareIcon:SetPoint("LEFT", AnnouncesquareMsg, "Right",5,0)
AnnouncesquareIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncesquareIcon:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
AnnouncesquareIcon:EnableMouse(false)

local AnnouncemoonCheck = CreateFrame("CheckButton", "AnnouncemoonCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncemoonCheck:SetPoint("TOP", AnnouncesquareCheck, "BOTTOM",0,-5)
AnnouncemoonCheck:SetSize(20,20)
AnnouncemoonCheck:SetScript("OnClick", function(self) if (MBDB.announce_moon==true) then MBDB.announce_moon = false; else MBDB.announce_moon = true; end end)
local AnnouncemoonMsg = CreateFrame("EditBox", "AnnouncemoonMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncemoonMsg:SetPoint("LEFT", AnnouncemoonCheck, "RIGHT", 10,0)
AnnouncemoonMsg:SetSize(320,20)
AnnouncemoonMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncemoonIcon = CreateFrame("Button", "AnnouncemoonIcon", MarkingBarOpt.childpanel4)
AnnouncemoonIcon:SetSize(20,20)
AnnouncemoonIcon:SetPoint("LEFT", AnnouncemoonMsg, "Right",5,0)
AnnouncemoonIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncemoonIcon:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
AnnouncemoonIcon:EnableMouse(false)

local AnnouncetriangleCheck = CreateFrame("CheckButton", "AnnouncetriangleCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncetriangleCheck:SetPoint("TOP", AnnouncemoonCheck, "BOTTOM",0,-5)
AnnouncetriangleCheck:SetSize(20,20)
AnnouncetriangleCheck:SetScript("OnClick", function(self) if (MBDB.announce_triangle==true) then MBDB.announce_triangle = false; else MBDB.announce_triangle = true; end end)
local AnnouncetriangleMsg = CreateFrame("EditBox", "AnnouncetriangleMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncetriangleMsg:SetPoint("LEFT", AnnouncetriangleCheck, "RIGHT", 10,0)
AnnouncetriangleMsg:SetSize(320,20)
AnnouncetriangleMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncetriangleIcon = CreateFrame("Button", "AnnouncetriangleIcon", MarkingBarOpt.childpanel4)
AnnouncetriangleIcon:SetSize(20,20)
AnnouncetriangleIcon:SetPoint("LEFT", AnnouncetriangleMsg, "Right",5,0)
AnnouncetriangleIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncetriangleIcon:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
AnnouncetriangleIcon:EnableMouse(false)

local AnnouncediamondCheck = CreateFrame("CheckButton", "AnnouncediamondCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncediamondCheck:SetPoint("TOP", AnnouncetriangleCheck, "BOTTOM",0,-5)
AnnouncediamondCheck:SetSize(20,20)
AnnouncediamondCheck:SetScript("OnClick", function(self) if (MBDB.announce_diamond==true) then MBDB.announce_diamond = false; else MBDB.announce_diamond = true; end end)
local AnnouncediamondMsg = CreateFrame("EditBox", "AnnouncediamondMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncediamondMsg:SetPoint("LEFT", AnnouncediamondCheck, "RIGHT", 10,0)
AnnouncediamondMsg:SetSize(320,20)
AnnouncediamondMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncediamondIcon = CreateFrame("Button", "AnnouncediamondIcon", MarkingBarOpt.childpanel4)
AnnouncediamondIcon:SetSize(20,20)
AnnouncediamondIcon:SetPoint("LEFT", AnnouncediamondMsg, "Right",5,0)
AnnouncediamondIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncediamondIcon:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
AnnouncediamondIcon:EnableMouse(false)

local AnnouncecircleCheck = CreateFrame("CheckButton", "AnnouncecircleCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncecircleCheck:SetPoint("TOP", AnnouncediamondCheck, "BOTTOM",0,-5)
AnnouncecircleCheck:SetSize(20,20)
AnnouncecircleCheck:SetScript("OnClick", function(self) if (MBDB.announce_circle==true) then MBDB.announce_circle = false; else MBDB.announce_circle = true; end end)
local AnnouncecircleMsg = CreateFrame("EditBox", "AnnouncecircleMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncecircleMsg:SetPoint("LEFT", AnnouncecircleCheck, "RIGHT", 10,0)
AnnouncecircleMsg:SetSize(320,20)
AnnouncecircleMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncecircleIcon = CreateFrame("Button", "AnnouncecircleIcon", MarkingBarOpt.childpanel4)
AnnouncecircleIcon:SetSize(20,20)
AnnouncecircleIcon:SetPoint("LEFT", AnnouncecircleMsg, "Right",5,0)
AnnouncecircleIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncecircleIcon:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
AnnouncecircleIcon:EnableMouse(false)

local AnnouncestarCheck = CreateFrame("CheckButton", "AnnouncestarCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncestarCheck:SetPoint("TOP", AnnouncecircleCheck, "BOTTOM",0,-5)
AnnouncestarCheck:SetSize(20,20)
AnnouncestarCheck:SetScript("OnClick", function(self) if (MBDB.announce_star==true) then MBDB.announce_star = false; else MBDB.announce_star = true; end end)
local AnnouncestarMsg = CreateFrame("EditBox", "AnnouncestarMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncestarMsg:SetPoint("LEFT", AnnouncestarCheck, "RIGHT", 10,0)
AnnouncestarMsg:SetSize(320,20)
AnnouncestarMsg:SetFont("Fonts\\ARIALN.TTF", 12)
local AnnouncestarIcon = CreateFrame("Button", "AnnouncestarIcon", MarkingBarOpt.childpanel4)
AnnouncestarIcon:SetSize(20,20)
AnnouncestarIcon:SetPoint("LEFT", AnnouncestarMsg, "Right",5,0)
AnnouncestarIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncestarIcon:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
AnnouncestarIcon:EnableMouse(false)

local AnnouncefooterCheck = CreateFrame("CheckButton", "AnnouncefooterCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncefooterCheck:SetPoint("TOP", AnnouncestarCheck, "BOTTOM",0,-5)
AnnouncefooterCheck:SetSize(20,20)
AnnouncefooterCheck:SetScript("OnClick", function(self) if (MBDB.announce_footer) then MBDB.announce_footer = false; else MBDB.announce_footer = true; end end)
local AnnouncefooterMsg = CreateFrame("EditBox", "AnnouncefooterMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncefooterMsg:SetPoint("LEFT", AnnouncefooterCheck, "RIGHT", 10,0)
AnnouncefooterMsg:SetSize(320,20)
AnnouncefooterMsg:SetFont("Fonts\\ARIALN.TTF", 12)

local AnnouncerwText = MarkingBarOpt.childpanel4:CreateFontString("AnnouncerwText", "OVERLAY", "ChatFontSmall")
AnnouncerwText:SetPoint("TOPLEFT", AnnouncefooterCheck, "BOTTOMLEFT",0,-15)
AnnouncerwText:SetText("Enter the chat message to send as a Raid Warning: (Only in a Raid)")

local AnnouncerwCheck = CreateFrame("CheckButton", "AnnouncerwCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncerwCheck:SetPoint("TOPLEFT", AnnouncerwText, "BOTTOMLEFT",0,-5)
AnnouncerwCheck:SetSize(20,20)
AnnouncerwCheck:SetScript("OnClick", function(self) if (MBFlaresDB.announce_rw) then MBFlaresDB.announce_rw = false; else MBFlaresDB.announce_rw = true; end end)
local AnnouncerwMsg = CreateFrame("EditBox", "AnnouncerwMsg", MarkingBarOpt.childpanel4, "InputBoxTemplate")
AnnouncerwMsg:SetPoint("LEFT", AnnouncerwCheck, "RIGHT", 10,0)
AnnouncerwMsg:SetSize(320,20)
AnnouncerwMsg:SetFont("Fonts\\ARIALN.TTF", 12)

local AnnouncetooltipCheck = CreateFrame("CheckButton", "AnnouncetooltipCheck", MarkingBarOpt.childpanel4, "UICheckButtonTemplate")
AnnouncetooltipCheck:SetPoint("TOP", AnnouncerwCheck, "BOTTOM",0,-15)
AnnouncetooltipCheck:SetSize(20,20)
AnnouncetooltipCheck:SetScript("OnClick", function(self) if (MBDB.announce_tooltip==true) then MBDB.announce_tooltip = false; else MBDB.announce_tooltip = true; end end)
local AnnouncetooltipText = MarkingBarOpt.childpanel4:CreateFontString("AnnouncetooltipText", "OVERLAY", "ChatFontSmall")
AnnouncetooltipText:SetPoint("LEFT", AnnouncetooltipCheck, "RIGHT",10,0)
AnnouncetooltipText:SetText("Add announce text to raid icon tooltips.")

local AnnounceResetMsgButton = CreateFrame("Button", "AnnounceResetMsgButton", MarkingBarOpt.childpanel4, "OptionsButtonTemplate")
AnnounceResetMsgButton:SetPoint("BOTTOMRIGHT", MarkingBarOpt.childpanel4, "BOTTOMRIGHT",-5,5)
AnnounceResetMsgButton:SetScript("OnClick", function(self) MB_reset_msg(); MB_checkUpdater(); end)
AnnounceResetMsgButton:SetSize(200,20)
AnnounceResetMsgButton:SetText("Reset to Default Messages")

-------------------------------------------------------
-- OnEvent
-------------------------------------------------------

local MB_OnUpdate = CreateFrame("Frame")
MB_OnUpdate:RegisterEvent("ADDON_LOADED")
MB_OnUpdate:RegisterEvent("PARTY_MEMBERS_CHANGED")
MB_OnUpdate:RegisterEvent("RAID_ROSTER_UPDATE")
MB_OnUpdate:RegisterEvent("PLAYER_TARGET_CHANGED")
MB_OnUpdate:RegisterEvent("PLAYER_REGEN_DISABLED") --to hide flares and get no taint
MB_OnUpdate:RegisterEvent("PLAYER_REGEN_ENABLED")  --stupid taint

MB_OnUpdate:SetScript("OnEvent", function(self,event,addon,...)
	if (event=="ADDON_LOADED") then
		if (addon=="MarkingBar") then            
			if (MBDB.shown==false) then MB_mainFrame:Hide() else MB_targetChecker("main") end
			if (MBDB.locked==true) then MB_lock("main") else MB_unlock("main") end
			if (MBDB.clamped==true) then MB_mainFrame:SetClampedToScreen(true) else MB_mainFrame:SetClampedToScreen(false) end
			if (MBDB.bgHide==true) then MB_bgHide("main") else MB_bgShow("main") end
			MB_mainFrame:SetScale(MBDB.scale,main)
			MB_mainFrame:SetAlpha(MBDB.alpha,main)
         
            if (MBCtrlDB.shown==false) then MB_controlFrame:Hide() else MB_targetChecker("ctrl") end
			if (MBCtrlDB.clamped==true) then MB_controlFrame:SetClampedToScreen(true) else MB_controlFrame:SetClampedToScreen(false) end
            if (MBCtrlDB.locked==true) then MB_lock("ctrl") else MB_unlock("ctrl") end
            if (MBCtrlDB.bgHide==true) then MB_bgHide("ctrl") else MB_bgShow("ctrl") end
			MB_controlFrame:SetScale(MBCtrlDB.scale,ctrl)
			MB_controlFrame:SetAlpha(MBCtrlDB.alpha,ctrl)
            
            MB_flipChecker() 
            
            if (MBFlaresDB.shown==false) then MBFlares_mainFrame:Hide() else MB_targetChecker("flare") end --for shown and partyShow
			if (MBFlaresDB.locked==true) then MB_lock("flare") else MB_unlock("flare") end
			if (MBFlaresDB.clamped==true) then MBFlares_mainFrame:SetClampedToScreen(true) else MBFlares_mainFrame:SetClampedToScreen(false) end
			MB_flareflipChecker() -- for flipped and vertical
			if (MBFlaresDB.bgHide==true) then MB_bgHide("flare") else MB_bgShow("flare") end
			MBFlares_mainFrame:SetScale(MBFlaresDB.scale,flare)
			MBFlares_mainFrame:SetAlpha(MBFlaresDB.alpha,flare)
		end
	end
    
	if (event=="PARTY_MEMBERS_CHANGED") or (event=="RAID_ROSTER_UPDATE") or (event=="PLAYER_TARGET_CHANGED") then
		MB_targetChecker("main")
        MB_targetChecker("ctrl")
        if ( not InCombatLockdown() ) then
            MB_targetChecker("flare")
        end
    end
    if (event=="PLAYER_REGEN_ENABLED") then
        MB_targetChecker("flare")
    end
end
)