
TidyPlatesButtonFrameSavedVariables = {}

-------------------------------------------------------------------------------------------------
local DropdownFrame = CreateFrame("Frame", "TidyPlatesDropdownFrame", UIParent, "UIDropDownMenuTemplate" )

local function GetCurrentSpec()
	if GetActiveTalentGroup(false, false) == 2 then return "secondary" 
	else return "primary" end
end

local function SetCurrentTheme(name)
	TidyPlatesOptions[GetCurrentSpec()] = tostring(name)
	TidyPlatesWidgets:ResetWidgets()
	TidyPlates.LoadTheme(name)
	TidyPlates:ForceUpdate()
end

local function CurrentThemeHasConfigPanel()
	local theme = TidyPlatesThemeList[TidyPlatesOptions[GetCurrentSpec()]]
	if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then return true end
end

local function ConfigureCurrentTheme()
	local theme = TidyPlatesThemeList[TidyPlatesOptions[GetCurrentSpec()]]
	if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then theme.ShowConfigPanel() end
end

local function InitializeDropdownMenu()
	local DropdownButton, DropdownTitle, DropdownConfigure, DropdownSpacer = {}, {}, {}, {}
	local currentThemeName = TidyPlatesOptions[GetCurrentSpec()]

	-- Spacer Definition
	DropdownSpacer.text = ""
	DropdownSpacer.notCheckable = 1
	DropdownSpacer.isTitle = 1
	
	-- Title
	DropdownTitle.text = "Tidy Plates"
	DropdownTitle.notCheckable = 1
	DropdownTitle.isTitle = 1
	DropdownTitle.padding = 16
	UIDropDownMenu_AddButton(DropdownTitle)
	UIDropDownMenu_AddButton(DropdownSpacer)
	
	-- Theme Choices
	for name, theme in pairs(TidyPlatesThemeList) do
		DropdownButton.text = name
		DropdownButton.padding = 16
		--DropdownButton.notCheckable = 1
		if currentThemeName == name then
			DropdownButton.checked = true
		else
			DropdownButton.checked = false
		end
		DropdownButton.func = function() SetCurrentTheme(name) end 
		UIDropDownMenu_AddButton(DropdownButton)
	end

	if CurrentThemeHasConfigPanel() then
		UIDropDownMenu_AddButton(DropdownSpacer)
		
		-- Configure Current
		DropdownConfigure.text = "Configure Theme"
		DropdownConfigure.padding = 16
		DropdownConfigure.notCheckable = 1
		DropdownConfigure.keepShownOnClick = 1
		DropdownConfigure.func = ConfigureCurrentTheme
		UIDropDownMenu_AddButton(DropdownConfigure)
	end
	
	--[[ Possible Future Features
		Toggle Enemy Nameplates
		Toggle Friendly Nameplates 
		Allow overlap
	--]]
	
	
end

-------------------------------------------------------------------------------------------------

local ButtonFrame = CreateFrame("Button","TidyPlatesButtonFrame",Minimap)
ButtonFrame:SetWidth(31)
ButtonFrame:SetHeight(31)
ButtonFrame:SetFrameStrata("LOW")
ButtonFrame:SetToplevel(1)
ButtonFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
ButtonFrame:SetPoint("BOTTOMLEFT",Minimap,"BOTTOMLEFT")

local ButtonIcon = ButtonFrame:CreateTexture("TidyPlatesButtonIcon","BACKGROUND")
ButtonIcon:SetTexture("Interface\\Addons\\TidyPlatesIcon\\TidyPlatesIcon")
ButtonIcon:SetWidth(25)
ButtonIcon:SetHeight(25)
ButtonIcon:SetPoint("TOPLEFT",ButtonFrame,"TOPLEFT",4,-3)

local ButtonBorder = ButtonFrame:CreateTexture("TidyPlatesButtonBorder","OVERLAY")
ButtonBorder:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
ButtonBorder:SetWidth(53)
ButtonBorder:SetHeight(53)
ButtonBorder:SetPoint("TOPLEFT",ButtonFrame,"TOPLEFT")

local function OnMouseDown() ButtonIcon:SetTexCoord(-0.1,.9,-0.1,.9) end
local function OnMouseUp() ButtonIcon:SetTexCoord(0,1,0,1) end

local function OnEnter() 
	GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
	GameTooltip:AddLine("Tidy Plates")
	GameTooltip:AddLine("Right-Click: Quick Menu|nLeft-Click: Open Interface Panel",.8,.8,.8,1)
	GameTooltip:Show()
end

local function OnLeave() GameTooltip:Hide() end


local function OnDragStart() 
	OnMouseDown() 
	ButtonFrame:StartMoving()
end

local function OnDragStop()
	OnMouseUp()
	ButtonFrame:StopMovingOrSizing()
end

local function OnClick(frame, button)
	if button =="LeftButton" then
		UIDropDownMenu_Initialize(DropdownFrame, InitializeDropdownMenu, "MENU")
		ToggleDropDownMenu(1, nil, DropdownFrame, frame);
	elseif button =="RightButton"  then
		--InterfaceOptionsFrame_OpenToCategory("TidyPlatesInterfaceOptions")
		InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

ButtonFrame:EnableMouse(true)
ButtonFrame:SetMovable(true)
ButtonFrame:SetClampedToScreen(true)
	
ButtonFrame:RegisterForClicks("LeftButtonUp","RightButtonUp")
ButtonFrame:SetScript("OnClick",OnClick)

ButtonFrame:SetScript("OnMouseDown",OnMouseDown)
ButtonFrame:SetScript("OnMouseUp",OnMouseUp)
ButtonFrame:SetScript("OnEnter",OnEnter)
ButtonFrame:SetScript("OnLeave",OnLeave)

ButtonFrame:RegisterForDrag("LeftButton")
ButtonFrame:SetScript("OnDragStart",OnDragStart)
ButtonFrame:SetScript("OnDragStop",OnDragStop)

ButtonFrame:SetPoint("CENTER", UIParent)



	
	

