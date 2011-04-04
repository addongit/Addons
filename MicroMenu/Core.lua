local addonName, addon = ...

addon.defaultOrder = {
	'CharacterMicroButton',
	'SpellbookMicroButton',
	'TalentMicroButton',
	'AchievementMicroButton',
	'QuestLogMicroButton',
	'FriendsMicroButton',
	'GuildMicroButton',
	'PVPMicroButton',
	'LFDMicroButton',
	'MainMenuMicroButton',
	'HelpMicroButton'
}

addon.defaultSettings = {
	latency			= 600,
	lock				= false,
	spacing			= 3,
	tooltip			= ""
}

local buttons, order = { }, { }

--[[-----------------------------------------------------------------------------
Platform
-------------------------------------------------------------------------------]]
function addon:GetVersionInteger(version)
	local major, minor, revision = tostring(version):match("([0-9]+)%.([0-9]+)%.?([0-9]*)")
	return (tonumber(major) or 0) * 1000000 + (tonumber(minor) or 0) * 1000 + (tonumber(revision) or 0)
end

local frameName
if (GetAddOnMetadata(addonName, "X-AllowPlugin") or ""):lower() == "true" then
	if IsAddOnLoaded('Titan') and addon:GetVersionInteger(GetAddOnMetadata('Titan', 'Version')) >= 4003000 then
		addon.platform, frameName = 'Titan', 'TitanPanel' .. addonName .. 'Button'
	elseif IsAddOnLoaded('FuBar') and addon:GetVersionInteger(GetAddOnMetadata('FuBar', 'X-Curse-Project-Name')) >= 3006000 and LibStub('LibFuBarPlugin-3.0', true) then
		addon.platform = 'FuBar'
	end
end
if not addon.platform then
	frameName = addonName .. "Frame"
end

--[[-----------------------------------------------------------------------------
Plugin frame
-------------------------------------------------------------------------------]]
local frame = CreateFrame('Button', frameName, UIParent)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetPoint('CENTER')
frame:SetHeight(1)
frame:SetWidth(1)
frame:Hide()

frame:SetScript('OnShow', function(self)
	self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	self:RegisterForDrag('LeftButton')
	self:SetScript('OnClick', addon.OnClick)
	self:SetScript('OnDragStart', addon.OnDragStart)
	self:SetScript('OnDragStop', addon.OnDragStop)
	self:SetScript('OnEnter', addon.OnEnter)
	self:SetScript('OnLeave', addon.OnLeave)
	self:SetScript('OnShow', nil)
end)

--[[-----------------------------------------------------------------------------
Addon methods
-------------------------------------------------------------------------------]]
function addon.DoNothing()
end

function addon:GetAnchorInfo(frame)
	local _, y = frame:GetCenter()
	if y * 2 >= UIParent:GetHeight() then
		return 'TOP', frame, 'BOTTOM'
	end
	return 'BOTTOM', frame, 'TOP'
end

function addon.OnClick(_, button)
	if button == 'RightButton' and addon.config then
		addon.config()
	end
end

--[[-----------------------------------------------------------------------------
Initialize
-------------------------------------------------------------------------------]]
addon.buttons, addon.frame, addon.order = buttons, frame, order

function addon:UpdateProfile()
	local settings = addon.db.profile
	local settings_order = settings.order
	if type(settings_order) ~= 'table' then
		settings_order = { }
		local defaultOrder = addon.defaultOrder
		for index = 1, #defaultOrder do
			settings_order[index] = defaultOrder[index]
		end
		settings.order = settings_order
	end

	local Hide, Show = frame.Hide, frame.Show
	for button in pairs(buttons) do
		buttons[button] = 0
		Hide(button)
	end

	wipe(order)
	local count, button = 0
	for index = 1, #settings_order do
		button = _G[settings_order[index]]
		if button and buttons[button] then
			count = count + 1
			buttons[button], order[count] = count, button
			Show(button)
		end
	end

	addon:ApplyPluginSettings()
end

AchievementMicroButton_Update = addon.DoNothing												-- Temp fix for Bliz bug

frame:SetScript('OnEvent', function(self, event, name)
	if name ~= addonName then return end
	self:UnregisterEvent(event)

	self:SetScript('OnEvent', function(self, event)
		self:UnregisterEvent(event)
		self:SetScript('OnEvent', nil)
		addon:ApplyPluginSettings()
	end)
	self:RegisterEvent('VARIABLES_LOADED')

	addon.db = LibStub('AceDB-3.0'):New(addonName .. "Settings", { profile = addon.defaultSettings }, 'Default')
	local settings = addon.db.profile
	if addon:GetVersionInteger(settings.version) < 1001000 then
		settings.order = nil
	end
	settings.version = GetAddOnMetadata(addonName, 'Version')

	local RegisterCallback, UpdateProfile = addon.db.RegisterCallback, addon.UpdateProfile
	RegisterCallback(addon, 'OnProfileChanged', UpdateProfile)
	RegisterCallback(addon, 'OnProfileCopied', UpdateProfile)
	RegisterCallback(addon, 'OnProfileReset', UpdateProfile)
	UpdateProfile()
end)
frame:RegisterEvent('ADDON_LOADED')

--[[-----------------------------------------------------------------------------
Load on demand configuration
-------------------------------------------------------------------------------]]
local LOA = LibStub('LibOptionsAssist-1.0', true)
if not (LOA and select(2, GetAddOnInfo(addonName .. '_Config'))) then return end	-- Make sure config support exists

addon.config = LOA:AddEntry(addonName, nil, function()
	addon.L = setmetatable({ }, { __index = function(self, key)
		self[key] = key
		return key
	end })

	local config = addonName .. '_Config'
	addon.addonName, _G[config] = addonName, addon
	LibStub('LibOptionsAssist-1.0'):LoadModule(config)
	addon.addonName, _G[config] = nil, nil
end)
