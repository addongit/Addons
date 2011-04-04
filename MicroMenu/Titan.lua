local addonName, addon = ...

if addon.platform ~= 'Titan' then return end

addon.defaultSettings.titanTooltip = true

local BUTTON_SIZE = 16

local frame, order = addon.frame, addon.order

frame.registry = {
	id = addonName,
	category = GetAddOnMetadata(addonName, 'X-Category'),
	version = GetAddOnMetadata(addonName, 'Version'),
	controlVariables = { DisplayOnRightSide = true },
	savedVariables = { DisplayOnRightSide = false }
}

--[[-----------------------------------------------------------------------------
Script abstraction
-------------------------------------------------------------------------------]]
function addon.OnDragStart()
	addon.isMoving = true
	TitanPanelButton_OnDragStart(frame)
	GameTooltip:Hide()
end

function addon.OnDragStop()
	TitanPanelButton_OnDragStop(frame)
	addon.isMoving = nil
end

function addon.OnEnter()
	if addon.isMoving then return end
	TitanPanelButton_OnEnter(frame)
end

function addon.OnLeave()
	if addon.isMoving then return end
	TitanPanelButton_OnLeave(frame)
end

--[[-----------------------------------------------------------------------------
Addon methods
-------------------------------------------------------------------------------]]
function addon:IsTooltipAllowed()
	local settings = self.db.profile
	if settings.titanTooltip then
		return TitanPanelGetVar('ToolTipsShown') and not (TitanPanelGetVar('HideTipsInCombat') and InCombatLockdown())
	end
	return SecureCmdOptionParse(settings.tooltip) ~= "Hide"
end

function addon:UpdatePlugin()
	local spacing = self.db.profile.spacing
	local baseOffset = BUTTON_SIZE + spacing
	local ClearAllPoints, SetPoint = frame.ClearAllPoints, frame.SetPoint
	for index = 1, #order do
		ClearAllPoints(order[index])
		SetPoint(order[index], 'LEFT', frame, baseOffset * (index - 1), 0)
	end
	frame:SetWidth(baseOffset * #order - spacing)
end

addon.ApplyPluginSettings = addon.UpdatePlugin

--[[-----------------------------------------------------------------------------
Initialize
-------------------------------------------------------------------------------]]
TitanUtils_PluginToRegister(frame)

frame:SetFrameStrata('FULLSCREEN')
frame:SetToplevel(true)
frame:SetHeight(16)

local function GetName()
	return addonName
end

for button in pairs(addon.buttons) do
	button.GetName = GetName
	button:SetHeight(BUTTON_SIZE)
	button:SetWidth(BUTTON_SIZE)
end
