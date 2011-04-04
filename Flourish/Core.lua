local LSM3 = LibStub("LibSharedMedia-3.0")

local flourish = CreateFrame("Frame")
local flourishBar = CreateFrame("StatusBar", "flourishBar", MainMenuExpBar)
local flourishOptionsFrame = CreateFrame("Frame", "flourishOptionsFrame", UIParent, "OptionsBoxTemplate")
tinsert(UISpecialFrames,flourishOptionsFrame:GetName())
local flourishVer = "1.5"
flourishBar:SetFrameStrata(MainMenuExpBar:GetFrameStrata())
flourishBar:SetFrameLevel(MainMenuExpBar:GetFrameLevel())
flourishBar:SetWidth(MainMenuExpBar:GetWidth())
flourishBar:SetHeight(MainMenuExpBar:GetHeight())
flourishBar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 0)
flourishBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
flourishBar:SetMinMaxValues(0, UnitXPMax("player"))
flourishBar:SetValue(0)
flourish:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
flourish:RegisterEvent("ADDON_LOADED")
flourish:RegisterEvent("QUEST_LOG_UPDATE")
flourish:RegisterEvent("PLAYER_XP_UPDATE")
flourish:RegisterEvent("ZONE_CHANGED_NEW_AREA")
flourish:RegisterEvent("UNIT_PORTRAIT_UPDATE")

local flourishPartial = {}
local flourishCheckBox = {}
local flourishCheckBoxText = {}
local flourishQuestLogFrame = {}
local flourishQuestLogState = {}
local flourishCheckedSaved = true
local flourishBEBCreated = false
local flourishBarBEB
local flourishDominosCreated = false
local flourishBarDominos
local flourishDominosXP
local flourishXparkyCreated = false
local flourishBarXparky
local flourishXPBarNoneCreated = false
local flourishXPBarNone
local flourishSaftCreated = false
local flourishSaft
local flourishCreatedBoxes = {}
local flourishBackdrop = {
  -- path to the background texture
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
  -- path to the border texture
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  -- true to repeat the background texture to fill the frame, false to scale it
  tile = true,
  -- size (width or height) of the square repeating background tiles (in pixels)
  tileSize = 12,
  -- thickness of edge segments and square size of edge corners (in pixels)
  edgeSize = 12,
  -- distance from the edges of the frame to those of the background texture (in pixels)
  insets = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2
  }
}

DEFAULT_CHAT_FRAME:AddMessage("|cFF4499FFFlourish v"..flourishVer.." Loaded")

function flourish_SUI()
  if (IsAddOnLoaded("SpartanUI")) then
  if (not flourishSUICreated) then
	flourishBarSUI = CreateFrame("Frame", "flourishBarSUI", SUI_ExperienceBar)
	flourishBarSUI:SetFrameStrata(SUI_ExperienceBar:GetFrameStrata())
	flourishBarSUI:SetFrameLevel(SUI_ExperienceBar:GetFrameLevel())
	flourishBarSUI:SetWidth(SUI_ExperienceBar:GetWidth())
	flourishBarSUI:SetHeight(SUI_ExperienceBar:GetHeight())
	flourishBarSUI:SetPoint("BOTTOMRIGHT","SpartanUI","BOTTOM",-80,0)
	flourishBarSUIFill = flourishBarSUI:CreateTexture("flourishBarSUIFill", "BORDER")
	flourishBarSUIFill:SetTexture("Interface\\AddOns\\SpartanUI\\media\\status_glow")
	flourishBarSUIFill:SetWidth(SUI_ExperienceBarFill:GetWidth()+200)
	flourishBarSUIFill:SetHeight(32)
	flourishBarSUIFill:SetPoint("RIGHT")
	flourishBarSUIFill:SetVertexColor(1,0.75,0,0.5)
	flourishBarSUILead = flourishBarSUI:CreateTexture("flourishBarSUILead", "BORDER")
	flourishBarSUILead:SetTexture("Interface\\AddOns\\SpartanUI\\media\\status_lead")
	flourishBarSUILead:SetWidth(20)
	flourishBarSUILead:SetHeight(32)
	flourishBarSUILead:SetPoint("RIGHT", flourishBarSUIFill, "LEFT")
	flourishBarSUILead:SetTexCoord(1,0,0,1)
	flourishBarSUILead:SetVertexColor(1,0.75,0,0.5)
	flourishSUICreated = true
  end
  end
end
function flourish_Dominos()
  if (IsAddOnLoaded("Dominos")) then
  if (not flourishDominosCreated) then
    flourishDominosXP = Dominos.Frame:Get("xp")
	if (flourishDominosXP) then
	  flourishBarDominos = CreateFrame("StatusBar", "flourishBarDominos", flourishDominosXP)
	  flourishBarDominos:SetFrameStrata(flourishDominosXP:GetFrameStrata())
	  flourishBarDominos:SetFrameLevel(flourishDominosXP:GetFrameLevel()+2)
	  flourishBarDominos:SetWidth(flourishDominosXP:GetWidth())
	  flourishBarDominos:SetHeight(flourishDominosXP:GetHeight())
	  flourishBarDominos:SetPoint("CENTER", flourishDominosXP, "CENTER", 0, 0)
	  flourishBarDominos:SetStatusBarTexture(flourishDominosXP.bg:GetTexture())
	  flourishBarDominos:SetMinMaxValues(0, UnitXPMax("player"))
	  flourishBarDominos:SetValue(0)
	  flourishDominosCreated = true
	end
  end
  end
end
function flourish_BEB()
  if (IsAddOnLoaded("BEB")) then
  if (not flourishBEBCreated) then
	flourishBarBEB = CreateFrame("StatusBar", "flourishBarBEB", BEBBackground)
	flourishBarBEB:SetFrameStrata(BEBBackground:GetFrameStrata())
	flourishBarBEB:SetFrameLevel(BEBXpBar:GetFrameLevel())
	flourishBarBEB:SetWidth(BEBBackground:GetWidth())
	flourishBarBEB:SetHeight(BEBBackground:GetHeight())
	flourishBarBEB:SetPoint("CENTER", BEBBackground, "CENTER", 0, 0)
	flourishBarBEB:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	flourishBarBEB:SetMinMaxValues(0, UnitXPMax("player"))
	flourishBarBEB:SetValue(0)
	flourishBEBCreated = true
  end
  end
end
function flourish_saft()
  if (IsAddOnLoaded("stExperienceBar") or IsAddOnLoaded("stExp")) then
  if (not flourishSaftCreated) then
	flourishSaft = CreateFrame("StatusBar", "flourishSaft", stExperienceBar_Frame)
	flourishSaft:SetFrameStrata(stExperienceBar__xpBar:GetFrameStrata())
	flourishSaft:SetFrameLevel(stExperienceBar__xpBar:GetFrameLevel())
	stExperienceBar__xpBar:SetFrameLevel(stExperienceBar__xpBar:GetFrameLevel()+1)
	flourishSaft:SetWidth(stExperienceBar__xpBar:GetWidth())
	flourishSaft:SetHeight(stExperienceBar__xpBar:GetHeight())
	flourishSaft:SetPoint("CENTER", stExperienceBar__xpBar, "CENTER", 0, 0)
	flourishSaft:SetStatusBarTexture(barTex)
	flourishSaft:SetMinMaxValues(0, UnitXPMax("player"))
	flourishSaft:SetValue(0)
	flourishSaftCreated = true
  end
  end
end
function flourish_XPBarNone()
  if (IsAddOnLoaded("XPBarNone")) then
  if (not flourishXPBarNoneCreated) then
  if (XPBarNoneXPBar ~= nil) then
	flourishXPBarNone = CreateFrame("StatusBar", "flourishXPBarNone", XPBarNoneBackground)
	flourishXPBarNone:SetFrameStrata(XPBarNoneXPBar:GetFrameStrata())
	flourishXPBarNone:SetFrameLevel(XPBarNoneXPBar:GetFrameLevel())
	flourishXPBarNone:SetWidth(XPBarNoneBackground:GetWidth())
	flourishXPBarNone:SetHeight(XPBarNoneBackground:GetHeight())
	flourishXPBarNone:SetPoint("CENTER", XPBarNoneBackground, "CENTER", 0, 0)
	flourishXPBarNone:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	flourishXPBarNone:SetMinMaxValues(0, UnitXPMax("player"))
	flourishXPBarNone:SetValue(0)
	flourishXPBarNoneCreated = true
  end
  end
  end
end
function flourish_Xparky()
  if (IsAddOnLoaded("Xparky")) then
  if (not flourishXparkyCreated) then
	flourishBarXparky = CreateFrame("StatusBar", "flourishBarXparky", XparkyXPAnchor)
	flourishBarXparky:SetFrameStrata(XPBarXparky:GetFrameStrata())
	flourishBarXparky:SetFrameLevel(XPBarXparky:GetFrameLevel())
	flourishBarXparky:SetWidth(XparkyXPAnchor:GetWidth())
	flourishBarXparky:SetHeight(XparkyXPAnchor:GetHeight())
	flourishBarXparky:SetPoint("CENTER", XparkyXPAnchor, "CENTER", 0, 0)
	flourishBarXparky:SetStatusBarTexture("Interface\\AddOns\\Xparky\\Textures\\texture.tga")
	flourishBarXparky:SetMinMaxValues(0, UnitXPMax("player"))
	flourishBarXparky:SetValue(0)
	flourishBarXparkySpark = CreateFrame("StatusBar", "flourishBarXparkySpark", flourishBarXparky)
	flourishBarXparkySpark:SetFrameStrata(flourishBarXparky:GetFrameStrata())
	flourishBarXparkySpark:SetFrameLevel(flourishBarXparky:GetFrameLevel()+1)
	flourishBarXparkySpark:SetPoint("LEFT", flourishBarXparky, "LEFT", -120, 0)
	flourishBarXparkySpark:SetWidth(128)
	flourishBarXparkySpark:SetHeight(flourishBarXparky:GetHeight()+13.5)
	flourishBarXparkySpark:SetStatusBarTexture("Interface\\AddOns\\Xparky\\Textures\\glow.tga")
	flourishBarXparkySpark:SetMinMaxValues(0, 1)
	flourishBarXparkySpark:SetValue(1)
	flourishXparkyCreated = true
  end
  end
end

SLASH_FLOURISH1 = '/flourish'
SlashCmdList["FLOURISH"] = function(msg, editbox)
  flourishOptionsShowHide()
  updateQuestXP("misc")
end

function currentZoneOption()
  if (flourishZoneOption:GetChecked()) then
    flourishOptions["zoneOnly"] = true
	flourish:ZONE_CHANGED_NEW_AREA()
  else
    flourishOptions["zoneOnly"] = false
  end
end

function incompleteOption()
  if (flourishIncompleteOption:GetChecked()) then
    flourishOptions["includeIncomplete"] = true
	updateQuestXP("misc")
  else
    flourishOptions["includeIncomplete"] = false
	updateQuestXP("misc")
  end
end

function messageOption()
  if (flourishMessageOption:GetChecked()) then
    flourishOptions["displayMessage"] = true
	updateQuestXP("misc")
  else
    flourishOptions["displayMessage"] = false
	updateQuestXP("misc")
  end
end

function soundOption()
  if (flourishSoundOption:GetChecked()) then
    flourishOptions["playSound"] = true
	updateQuestXP("misc")
  else
    flourishOptions["playSound"] = false
	updateQuestXP("misc")
  end
end

function flourish:ADDON_LOADED(event, addon)
  if flourishOptions == nil then
    flourishOptions = {}
    flourishOptions["zoneOnly"] = false
    flourishOptions["includeIncomplete"] = false
    flourishOptions["displayMessage"] = true
    flourishOptions["playSound"] = false
  end
  if flourishChecked == nil then
    flourishChecked = {}
    flourishCheckedSaved = false
  end
end

function flourish:QUEST_LOG_UPDATE(event, addon)
  flourishQuestArray()
  flourishCreateBoxes()
  flourishUpdateChecked()
  flourish_BEB()
  flourish_Dominos()
  flourish_SUI()
  flourish_XPBarNone()
  flourish_saft()
  flourish_Xparky()
  updateQuestXP(event)
end

function flourish:PLAYER_XP_UPDATE(event, addon)
  flourishQuestArray()
  flourishCreateBoxes()
  updateQuestXP(event)
end

function flourish:UNIT_PORTRAIT_UPDATE(event, addon)
  flourishQuestArray()
  flourishCreateBoxes()
  updateQuestXP(event)
end

function flourish:ZONE_CHANGED_NEW_AREA(event, addon)
  if (flourishOptions["zoneOnly"]) then
    local o = 1
    while GetQuestLogTitle(o) do
      local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(o)
      if (isHeader) then
	    if (questLogTitleText == GetZoneText()) then
		  flourishCheckBox[o]:SetChecked(true)
		else
		  flourishCheckBox[o]:SetChecked(false)
		end
      end
      o = o + 1
    end
    flourishUpdateZoneSection()
  end
end

function updateQuestXP(event)
  flourishCreateBoxes()
  if (flourishOnceCalled) then
    local i = 1
	local lastHeader = 1
	local allChecked = false
    local currentQuestXPTotal = 0
    while GetQuestLogTitle(i) do
      local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(i)
	  if (isHeader) then
	    flourishCheckID = questLogTitleText
	  else
	    flourishCheckID = questID
	  end
	  if (flourishOptions["includeIncomplete"]) then
	    isComplete = true
	  end
	  if (flourishCheckBox[i]:GetChecked()) then
	    flourishChecked[flourishCheckID] = true
	  else
	    flourishChecked[flourishCheckID] = false
	  end
      if (not isHeader) then
	    flourishObjectives = GetNumQuestLeaderBoards(i)
	    if (flourishObjectives == 0) then
	      isComplete = true
	    end
	    if (flourishCheckBox[i]:GetChecked()) then
		  if (isComplete) then
	        currentQuestXPTotal = currentQuestXPTotal + flourishQuestLogState[i]["xp"]
		  end
	  	else
		  allChecked = false
		  flourishCheckBox[lastHeader]:SetChecked(false)
		end
	  else
		if (allChecked) then
		  flourishCheckBox[lastHeader]:SetChecked(true)
		end
		allChecked = true
	    lastHeader = i
      end
      i = i + 1
    end
	if (allChecked) then
	  flourishCheckBox[lastHeader]:SetChecked(true)
    end
    local currXP = UnitXP("player")+currentQuestXPTotal
    local nextXP = UnitXPMax("player")
	if (currentQuestXPTotal == 0) then
	  currXP = 0
	end
    flourishBar:SetStatusBarColor(1.0, 0.75, 0.0, 0.5)
    if currXP > nextXP then
      if (flourishOptions["playSound"]) then
	    PlaySound("Deathbind Sound")
	  end
	  if (flourishOptions["displayMessage"] and event == "QUEST_LOG_UPDATE") then
	    if (currentQuestXPTotal > 0) then
	      UIErrorsFrame:AddMessage("|cFF336699Flourish - |cFFC0FF00LEVEL UP |cFF336699- |cFFFFC000"..currentQuestXPTotal.." QXP")
        end
	  end
	  flourishBar:SetStatusBarColor(0.75, 1.0, 0.0, 0.5)
    else
	  if (flourishOptions["displayMessage"] and event == "QUEST_LOG_UPDATE") then
	    if (currentQuestXPTotal > 0) then
	      UIErrorsFrame:AddMessage("|cFF336699Flourish - |cFFFFC000"..currentQuestXPTotal.." QXP")
	    end
	  end
	end
	flourishBar:SetFrameStrata(MainMenuExpBar:GetFrameStrata())
	flourishBar:SetFrameLevel(MainMenuExpBar:GetFrameLevel())
	flourishBar:SetWidth(MainMenuExpBar:GetWidth())
	flourishBar:SetHeight(MainMenuExpBar:GetHeight())
	flourishBar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 0)
    flourishBar:SetMinMaxValues(min(0, currXP), nextXP)
    flourishBar:SetValue(currXP)
	if (flourishBEBCreated) then
	  flourishBarBEB:SetStatusBarColor(1.0, 0.75, 0.0, 0.5)
      if currXP > nextXP then
        flourishBarBEB:SetStatusBarColor(0.75, 1.0, 0.0, 0.5)
      end
	  flourishBarBEB:SetFrameStrata(BEBBackground:GetFrameStrata())
	  flourishBarBEB:SetFrameLevel(BEBXpBar:GetFrameLevel())
      flourishBarBEB:SetMinMaxValues(min(0, currXP), nextXP)
      flourishBarBEB:SetValue(currXP)
	  flourishBarBEB:SetWidth(BEBBackground:GetWidth())
	  flourishBarBEB:SetHeight(BEBBackground:GetHeight())
	  flourishBarBEB:SetStatusBarTexture(BEB.TexturePath(BEBCharSettings.BEBXpBar.texture))
	end
	if (flourishSUICreated) then
	  flourishBarSUI:SetFrameStrata(SUI_ExperienceBar:GetFrameStrata())
	  flourishBarSUI:SetFrameLevel(SUI_ExperienceBar:GetFrameLevel())
	  flourishBarSUIFill:SetVertexColor(1.0, 0.75, 0.0, 0.7)
	  flourishBarSUILead:SetVertexColor(1.0, 0.75, 0.0, 0.7)
      flourishBarSUIFill:SetWidth((currXP/nextXP)*400)
      if currXP > nextXP then
        flourishBarSUIFill:SetVertexColor(0.75, 1.0, 0.0, 0.7)
        flourishBarSUILead:SetVertexColor(0.75, 1.0, 0.0, 0.7)
        flourishBarSUIFill:SetWidth(420)
      end
	  if currXP == 0 then
	    flourishBarSUIFill:SetVertexColor(0,0,0,0)
	    flourishBarSUILead:SetVertexColor(0,0,0,0)
	  end
	end
	if (flourishDominosCreated) then
	  flourishBarDominos:SetStatusBarColor(1.0, 0.75, 0.0, 0.5)
      if currXP > nextXP then
        flourishBarDominos:SetStatusBarColor(0.75, 1.0, 0.0, 0.5)
      end
	  flourishBarDominos:SetFrameStrata(flourishDominosXP:GetFrameStrata())
	  flourishBarDominos:SetFrameLevel(flourishDominosXP:GetFrameLevel()+2)
      flourishBarDominos:SetMinMaxValues(min(0, currXP), nextXP)
      flourishBarDominos:SetValue(currXP)
	  flourishBarDominos:SetWidth(flourishDominosXP:GetWidth())
	  flourishBarDominos:SetHeight(flourishDominosXP:GetHeight())
	  flourishBarDominos:SetStatusBarTexture(flourishDominosXP.bg:GetTexture())
	end
	if (flourishXPBarNoneCreated) then
	  flourishXPBarNone:SetStatusBarColor(1.0, 0.75, 0.0, 0.5)
      if currXP > nextXP then
        flourishXPBarNone:SetStatusBarColor(0.75, 1.0, 0.0, 0.5)
      end
	  flourishXPBarNone:SetFrameStrata(XPBarNoneXPBar:GetFrameStrata())
	  flourishXPBarNone:SetFrameLevel(XPBarNoneXPBar:GetFrameLevel())
      flourishXPBarNone:SetMinMaxValues(min(0, currXP), nextXP)
      flourishXPBarNone:SetValue(currXP)
	  flourishXPBarNone:SetWidth(XPBarNoneBackground:GetWidth())
	  flourishXPBarNone:SetHeight(XPBarNoneBackground:GetHeight())
	  local texturePath = LSM3:Fetch("statusbar", XPBarNone.db.profile.general.texture)
	  flourishXPBarNone:SetStatusBarTexture(texturePath)
	end
	if (flourishSaftCreated) then
	  flourishSaft:SetStatusBarColor(1.0, 0.75, 0.0, 0.66)
      if currXP > nextXP then
        flourishSaft:SetStatusBarColor(0.75, 1.0, 0.0, 0.66)
      end
	  flourishSaft:SetWidth(stExperienceBar__xpBar:GetWidth())
	  flourishSaft:SetHeight(stExperienceBar__xpBar:GetHeight())
      flourishSaft:SetMinMaxValues(min(0, currXP), nextXP)
      flourishSaft:SetValue(currXP)
	end
	if (flourishXparkyCreated) then
	  flourishBarXparky:SetStatusBarColor(1.0, 0.75, 0.0, 0.5)
	  flourishBarXparkySpark:SetStatusBarColor(1.0, 0.75, 0.0, 0.5)
      if currXP > nextXP then
        flourishBarXparky:SetStatusBarColor(0.75, 1.0, 0.0, 0.5)
        flourishBarXparkySpark:SetStatusBarColor(0.75, 1.0, 0.0, 0.5)
      end
	  if(Xparky.db.profile.ShowShadow) then
	    flourishXparkyShadow = 2.5
	  else
	    flourishXparkyShadow = 0
	  end
	  flourishBarXparky:SetPoint("CENTER", XparkyXPAnchor, "CENTER", 0, flourishXparkyShadow)
	  flourishBarXparky:SetWidth(XparkyXPAnchor:GetWidth())
	  flourishBarXparky:SetHeight(XPBarXparky:GetHeight())
      flourishBarXparky:SetMinMaxValues(min(0, currXP), nextXP)
      flourishBarXparky:SetValue(currXP)
	  flourishXparkyMinValue, flourishXparkyMaxValue = flourishBarXparky:GetMinMaxValues()
	  flourishXparkyOffset = ((flourishBarXparky:GetValue()/flourishXparkyMaxValue)*flourishBarXparky:GetWidth())-120
	  flourishBarXparkySpark:SetHeight(flourishBarXparky:GetHeight()+12)
	  flourishBarXparkySpark:SetPoint("LEFT", flourishBarXparky, "LEFT", flourishXparkyOffset, 0)
	  flourishBarXparkySpark:SetFrameStrata(XPBarXparky:GetFrameStrata())
	  flourishBarXparkySpark:SetFrameLevel(XPBarXparky:GetFrameLevel())
	  flourishBarXparkySpark:SetFrameStrata(flourishBarXparky:GetFrameStrata())
	  flourishBarXparkySpark:SetFrameLevel(flourishBarXparky:GetFrameLevel()+1)
	  if (currXP == 0) then
	    flourishBarXparky:Hide()
	    flourishBarXparkySpark:Hide()
      else
	    flourishBarXparky:Show()
	    flourishBarXparkySpark:Show()
	  end
	end
  end
end

function flourishSetChecked()
  local k = 1
  while GetQuestLogTitle(k) do
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(k)
    if (isHeader) then
	  flourishCheckID = questLogTitleText
    else
	  flourishCheckID = questID
    end
	if (flourishChecked[flourishCheckID]) then
	  flourishCheckBox[k]:SetChecked(true)
	else
	  flourishCheckBox[k]:SetChecked(false)
	end
	if (flourishChecked[flourishCheckID] == nil) then
	  flourishCheckBox[k]:SetChecked(true)
	end
	k = k + 1
  end
  if (flourishOptions["zoneOnly"]) then
    flourishZoneOption:SetChecked(true)
  end
  if (flourishOptions["includeIncomplete"]) then
    flourishIncompleteOption:SetChecked(true)
  end
  if (flourishOptions["displayMessage"]) then
    flourishMessageOption:SetChecked(true)
  end
  if (flourishOptions["playSound"]) then
    flourishSoundOption:SetChecked(true)
  end
end

function flourishUpdateChecked()
  local j = 1
  while GetQuestLogTitle(j) do
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(j)
	if (isHeader) then
	  flourishCheckID = questLogTitleText
	else
	  flourishCheckID = questID
	end
	if (flourishChecked[flourishCheckID]) then
	  flourishCheckBox[j]:SetChecked(true)
	else
	  flourishCheckBox[j]:SetChecked(false)
	end
	if (flourishChecked[flourishCheckID] == nil) then
	  flourishCheckBox[j]:SetChecked(true)
	end
	j = j + 1
  end
  local h = 1
  flourishChecked = {}
  while GetQuestLogTitle(j) do
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(h)
	if (isHeader) then
	  flourishCheckID = questLogTitleText
	else
	  flourishCheckID = questID
	end
	if (flourishCheckBox[h]:GetChecked()) then
	  flourishChecked[flourishCheckID] = true
	else
	  flourishChecked[flourishCheckID] = false
	end
	h = h + 1
  end
end

function flourishPartialSection()
  local r = 1
  local curHeader = 1
  local allChecked = false
  while GetQuestLogTitle(r) do
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(r)
	if (isHeader) then
	  flourishCheckID = questLogTitleText
	else
	  flourishCheckID = questID
	end
    if (isHeader) then
	  if (allChecked) then
	    flourishPartial[curHeader] = false
	  else
	    flourishPartial[curHeader] = true
	  end
	  allChecked = true
	  curHeader = r
	else
      if (not flourishCheckBox[curHeader]:GetChecked()) then
	    if (flourishCheckBox[r]:GetChecked()) then
	    else
		  allChecked = false
        end
	  else
	  end
    end
	if (flourishCheckBox[r]:GetChecked()) then
	  flourishChecked[flourishCheckID] = true
	else
	  flourishChecked[flourishCheckID] = false
	end
    r = r + 1
  end
  if (allChecked) then
	flourishPartial[curHeader] = false
  else
	flourishPartial[curHeader] = true
  end
end

function flourishUpdateCheckBox()
  flourishZoneOption:SetChecked(false)
  currentZoneOption()
  updateQuestXP()
end

function flourishUpdateSection()
  flourishZoneOption:SetChecked(false)
  currentZoneOption()
  local p = 1
  local curHeader = 1
  flourishPartialSection()
  while GetQuestLogTitle(p) do
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(p)
	if (isHeader) then
	  flourishCheckID = questLogTitleText
	else
	  flourishCheckID = questID
	end
    if (isHeader) then
	  curHeader = p
	else
	  if (flourishCheckBox[curHeader]:GetChecked()) then
		flourishCheckBox[p]:SetChecked(true)
	  else
	    if (not flourishPartial[curHeader]) then
	      flourishCheckBox[p]:SetChecked(false)
        end
	  end
    end
	if (flourishCheckBox[p]:GetChecked()) then
	  flourishChecked[flourishCheckID] = true
	else
	  flourishChecked[flourishCheckID] = false
	end
    p = p + 1
  end
    updateQuestXP("misc")
end

function flourishUpdateZoneSection()
  local p = 1
  local curHeader = 1
  while GetQuestLogTitle(p) do
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(p)
	if (isHeader) then
	  flourishCheckID = questLogTitleText
	else
	  flourishCheckID = questID
	end
    if (isHeader) then
	  curHeader = p
	else
	  if (flourishCheckBox[curHeader]:GetChecked()) then
		flourishCheckBox[p]:SetChecked(true)
	  else
	    flourishCheckBox[p]:SetChecked(false)
	  end
    end
	if (flourishCheckBox[p]:GetChecked()) then
	  flourishChecked[flourishCheckID] = true
	else
	  flourishChecked[flourishCheckID] = false
	end
    p = p + 1
  end
    updateQuestXP("misc")
end

function flourishCreateBoxes()
  flourishQuestArray()
  local n = 1
  while GetQuestLogTitle(n) do
	local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(n)
	if (not isHeader) then
	  flourishObjectives = GetNumQuestLeaderBoards(n)
	  if (flourishObjectives == 0) then
	    isComplete = true
	  end
	  if (not flourishCreatedBoxes[n]) then
		flourishCheckBox[n] = CreateFrame("CheckButton","flourishCheckBox"..n, flourishOptionsFrame, "UICheckButtonTemplate")
		flourishCheckBox[n]:SetChecked(true)
		flourishCheckBoxText[n] = flourishCheckBox[n]:CreateFontString("flourishCheckBoxText"..n)
	  end
	  flourishCheckBox[n]:SetScript("onClick", flourishUpdateCheckBox)
	  flourishCheckBox[n]:ClearAllPoints()
	  flourishHeightOffset = -14 * n
	  flourishCheckBox[n]:SetPoint("TOPLEFT",26,flourishHeightOffset)
	  flourishCreatedBoxes[n] = "quest"
	  flourishColor = "|cFF336699"
	  flourishQuestXPText = "  |cFFFFC000"..flourishQuestLogState[n]["xp"].." |cFF805f00QXP "
	else
	  if (not flourishCreatedBoxes[n]) then
		flourishCheckBox[n] = CreateFrame("CheckButton","flourishCheckBox"..n, flourishOptionsFrame, "UICheckButtonTemplate")
		flourishCheckBox[n]:SetChecked(true)
		flourishCheckBoxText[n] = flourishCheckBox[n]:CreateFontString("flourishCheckBoxText"..n)
	  end
	  flourishCheckBox[n]:SetScript("onClick", flourishUpdateSection)
	  flourishCheckBox[n]:ClearAllPoints()
	  flourishHeightOffset = -14 * n
	  flourishCheckBox[n]:SetPoint("TOPLEFT",10,flourishHeightOffset)
	  flourishCreatedBoxes[n] = "header"
	  flourishColor = "|cFF4499FF"
	  flourishQuestXPText = " "
	end
	  if (isComplete) then
		flourishCompleteText = "|cFFC0FF00(Complete)"
	  else
		flourishCompleteText = ""
	  end
		flourishCheckBoxText[n]:SetPoint("Left",20,0)
		flourishCheckBoxText[n]:SetFontObject("GameFontNormal")
		flourishCheckBoxText[n]:SetText(flourishColor..questTitle..flourishQuestXPText..flourishCompleteText)
	  --flourishCheckBox[n]:SetBackdrop(flourishBackdrop)
	  flourishCheckBox[n]:SetWidth(16)
	  flourishCheckBox[n]:SetHeight(16)
      flourishCheckBox[n]:Show()
	  --flourishCheckBox[n]:SetBackdropBorderColor(0.2, 0.4, 0.7)
	  --flourishCheckBox[n]:SetBackdropColor(0,0,0,1)
	n = n + 1
  end
  flourishQuestCount = n + 2
  flourishOptionsFrameHeight = flourishQuestCount*14
  flourishOptionsFrame:SetHeight(flourishOptionsFrameHeight+20)
  while flourishCheckBox[n] do
    flourishCheckBox[n]:Hide()
    flourishCheckBox[n]:SetChecked(true)
    n = n + 1
  end
  -- flourish options frane
  if (not flourishOnceCalled) then
    -- create the quest log button
	if (IsAddOnLoaded("UberQuest")) then
      flourishQuestLogFrame = CreateFrame("Frame","flourishQuestLogFrame", UberQuest_List, "OptionsBoxTemplate")
      flourishQuestLogFrame:SetPoint("TOPLEFT",58,16)
	elseif (IsAddOnLoaded("QuestGuru")) then
      flourishQuestLogFrame = CreateFrame("Frame","flourishQuestLogFrame", QuestGuru_QuestLogFrame, "OptionsBoxTemplate")
      flourishQuestLogFrame:SetPoint("TOPLEFT",10,10)
	else
      flourishQuestLogFrame = CreateFrame("Frame","flourishQuestLogFrame", QuestLogFrame, "OptionsBoxTemplate")
      flourishQuestLogFrame:SetPoint("BOTTOMLEFT",12,-8)
    end
	flourishQuestLogFrame:SetWidth(57)
    flourishQuestLogFrame:SetHeight(22)
	flourishQuestLogFrame:SetFrameStrata("BACKGROUND")
	flourishQuestLogFrame:SetBackdrop(flourishBackdrop)
	flourishQuestLogFrame:SetBackdropBorderColor(0.2, 0.4, 0.7)
	flourishQuestLogFrame:SetBackdropColor(0,0,0,1)
	-- create an invisible button for the user to click to collapse and expand the options frame
	flourishOptionsButton = CreateFrame("Button", "flourishOptionsButton", flourishQuestLogFrame)
	flourishOptionsButton:SetWidth(45)
    flourishOptionsButton:SetHeight(16)
    flourishOptionsButton:SetPoint("Left",5,1)
	flourishOptionsButton:RegisterForClicks("AnyUp")
	flourishOptionsButton:SetFrameStrata("HIGH")
	flourishOptionsButton:SetScript("OnMouseUp", flourishOptionsShowHide)
	flourishOptionsButton:SetScript("OnEnter", flourishLabelHighlightOn)
	flourishOptionsButton:SetScript("OnLeave", flourishLabelHighlightOff)
	flourishQuestLogLabel = flourishQuestLogFrame:CreateFontString("flourishZoneText", flourishQuestLogFrame:GetFrameStrata())
    flourishQuestLogLabel:SetPoint("Left",5,1)
	flourishQuestLogLabel:SetFontObject("GameFontNormal")
	flourishQuestLogLabel:SetText("|cFF336699Flourish")
    -- create the options frame
    flourishOptionsFrame:SetPoint("CENTER",0,0)
	flourishOptionsFrame:SetWidth(400)
    flourishOptionsFrame:SetHeight(600)
	flourishOptionsFrame:SetFrameStrata("HIGH")
	flourishOptionsFrame:SetBackdrop(flourishBackdrop)
	flourishOptionsFrame:SetBackdropBorderColor(0.2, 0.4, 0.7)
	flourishOptionsFrame:SetBackdropColor(0,0,0,1)
    flourishOptionsFrame:EnableMouse(true)
	flourishOptionsFrame:SetClampedToScreen(true)
    flourishOptionsTitle = flourishOptionsFrame:CreateTitleRegion()
    flourishOptionsTitle:SetAllPoints()
	-- create a title for the options frame
	flourishOptionsLabel = flourishOptionsFrame:CreateFontString("flourishOptionsLabel", "HIGH")
    flourishOptionsLabel:SetPoint("TOP",0,-3)
	flourishOptionsLabel:SetFontObject("GameFontNormal")
	flourishOptionsLabel:SetTextHeight(16)
	flourishOptionsLabel:SetText("|cFF4499FFFlourish v"..flourishVer)
	-- create an invisible button for the user to click to close the options frame
	flourishCloseButton = CreateFrame("Button", "flourishCloseButton", flourishOptionsFrame)
	flourishCloseButton:SetWidth(45)
    flourishCloseButton:SetHeight(16)
    flourishCloseButton:SetPoint("BOTTOM",0,5)
	flourishCloseButton:RegisterForClicks("AnyUp")
	flourishCloseButton:SetFrameStrata("HIGH")
	flourishCloseButton:SetScript("OnMouseUp", flourishOptionsShowHide)
	flourishCloseButton:SetScript("OnEnter", flourishCloseHighlightOn)
	flourishCloseButton:SetScript("OnLeave", flourishCloseHighlightOff)
	flourishCloseLabel = flourishOptionsFrame:CreateFontString("flourishCloseLabel", "HIGH")
    flourishCloseLabel:SetPoint("Bottom",0,5)
	flourishCloseLabel:SetFontObject("GameFontNormal")
	flourishCloseLabel:SetText("|cFF993311Close")
	-- flourish zone options
    flourishZoneOption = CreateFrame("CheckButton","flourishZoneOption", flourishOptionsFrame, "UICheckButtonTemplate")
    flourishZoneOption:SetScript("onClick", currentZoneOption)
    flourishZoneOption:SetPoint("BOTTOMLEFT",10,20)
	flourishZoneOption:SetWidth(20)
	flourishZoneOption:SetHeight(20)
	flourishZoneText = flourishZoneOption:CreateFontString("flourishZoneText", flourishOptionsFrame:GetFrameStrata())
    flourishZoneText:SetPoint("Left",20,0)
	flourishZoneText:SetFontObject("GameFontNormal")
	flourishZoneText:SetText("Current Zone")
	-- flourish incomplete options
    flourishIncompleteOption = CreateFrame("CheckButton","flourishIncompleteOption", flourishOptionsFrame, "UICheckButtonTemplate")
    flourishIncompleteOption:SetScript("onClick", incompleteOption)
    flourishIncompleteOption:SetPoint("BOTTOMLEFT",115,20)
	flourishIncompleteOption:SetWidth(20)
	flourishIncompleteOption:SetHeight(20)
	flourishIncompleteText = flourishIncompleteOption:CreateFontString("flourishIncompleteText", flourishOptionsFrame:GetFrameStrata())
    flourishIncompleteText:SetPoint("Left",20,0)
	flourishIncompleteText:SetFontObject("GameFontNormal")
	flourishIncompleteText:SetText("Include Incomplete")
	-- flourish message options
    flourishMessageOption = CreateFrame("CheckButton","flourishMessageOption", flourishOptionsFrame, "UICheckButtonTemplate")
    flourishMessageOption:SetScript("onClick", messageOption)
    flourishMessageOption:SetPoint("BOTTOMLEFT",260,20)
	flourishMessageOption:SetWidth(20)
	flourishMessageOption:SetHeight(20)
	flourishMessageOption:SetChecked(true)
	flourishMessageText = flourishMessageOption:CreateFontString("flourishMessageText", flourishOptionsFrame:GetFrameStrata())
    flourishMessageText:SetPoint("Left",20,0)
	flourishMessageText:SetFontObject("GameFontNormal")
	flourishMessageText:SetText("Display Messages")
	-- flourish sound options
    flourishSoundOption = CreateFrame("CheckButton","flourishSoundOption", flourishOptionsFrame, "UICheckButtonTemplate")
    flourishSoundOption:SetScript("onClick", soundOption)
    flourishSoundOption:SetPoint("BOTTOMLEFT",10,5)
	flourishSoundOption:SetWidth(20)
	flourishSoundOption:SetHeight(20)
	flourishSoundOption:SetChecked(true)
	flourishSoundText = flourishSoundOption:CreateFontString("flourishSoundText", flourishOptionsFrame:GetFrameStrata())
    flourishSoundText:SetPoint("Left",20,0)
	flourishSoundText:SetFontObject("GameFontNormal")
	flourishSoundText:SetText("Play Sounds")
	-- collapse options frame
	-- set flourish variables as called
    flourishOnceCalled = true
	flourishOptionsFrame:Hide()
    -- load saved variables and restore previously checked quests
	if (flourishCheckedSaved) then
	  flourishSetChecked()
	end
  end
end

function flourishQuestArray()
  local u = 1
  local flourishLastSelected = GetQuestLogSelection()
  while GetQuestLogTitle(u) do
    SelectQuestLogEntry(u)
    local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(u)
	if (flourishQuestLogState[u] == nil) then
      flourishQuestLogState[u] = {}
    end
	flourishQuestLogState[u]["title"] = questLogTitleText
	if (isHeader) then
	  flourishQuestLogState[u]["header"] = true
	  flourishQuestLogState[u]["xp"] = 0
	else
	  flourishQuestLogState[u]["header"] = false
	  flourishQuestLogState[u]["xp"] = GetQuestLogRewardXP()
	end
	if (flourishCreatedBoxes[u]) then
	  flourishQuestLogState[u]["checked"] = flourishCheckBox[u]:GetChecked() or false
	else
	  flourishQuestLogState[u]["checked"] = false
	end
    u = u + 1
  end
  SelectQuestLogEntry(flourishLastSelected)
end

function flourishCloseHighlightOn()
  flourishCloseLabel:SetText("|cFFFF4422Close")
end

function flourishCloseHighlightOff()
  flourishCloseLabel:SetText("|cFF993311Close")
end

function flourishLabelHighlightOn()
  flourishQuestLogLabel:SetText("|cFF4499FFFlourish")
end

function flourishLabelHighlightOff()
  flourishQuestLogLabel:SetText("|cFF336699Flourish")
end

function flourishOptionsShowHide()
  if (flourishOptionsFrame:IsVisible()) then
	flourishOptionsFrame:Hide()
  else
	flourishOptionsFrame:Show()
  end
end