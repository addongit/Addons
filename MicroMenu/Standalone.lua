local addonName, addon = ...

if addon.platform then return end

local default = addon.defaultSettings
default.anchorPoint			= 'CENTER'
default.anchorOffsetX		= 0
default.anchorOffsetY		= 0
default.borderSpacing		= 3
default.buttonSize			= 20
default.frameBackgroundA	= 0.69
default.frameBackgroundB	= 0.1
default.frameBackgroundG	= 0.05
default.frameBackgroundR	= 0.05
default.frameBorderA			= 1
default.frameBorderB			= 1
default.frameBorderG			= 1
default.frameBorderR			= 1
default.frameLevel			= 1
default.frameLock				= false
default.frameStrata			= 'HIGH'

local frame, order = addon.frame, addon.order

--[[-----------------------------------------------------------------------------
Script abstraction
-------------------------------------------------------------------------------]]
function addon.OnDragStart()
	if addon.db.profile.frameLock then return end
	addon.isMoving = true
	frame:StartMoving()
	GameTooltip:Hide()
end

function addon.OnDragStop()
	if not addon.isMoving then return end
	frame:StopMovingOrSizing()
	local settings = addon.db.profile
	local anchor, x, y = settings.anchorPoint
	local L1, B1, W1, H1 = UIParent:GetRect()
	local L2, B2, W2, H2 = frame:GetRect()
	if anchor == 'TOP' then
		x, y = L2 - L1 + (W2 - W1) * 0.5, B2 + H2 - B1 - H1
	elseif anchor == 'BOTTOM' then
		x, y = L2 - L1 + (W2 - W1) * 0.5, B2 - B1
	elseif anchor == 'LEFT' then
		x, y = L2 - L1, B2 - B1 + (H2 - H1) * 0.5
	elseif anchor == 'RIGHT' then
		x, y = L2 + W2 - L1 - W1, B2 - B1 + (H2 - H1) * 0.5
	elseif anchor == 'TOPLEFT' then
		x, y = L2 - L1, B2 + H2 - B1 - H1
	elseif anchor == 'TOPRIGHT' then
		x, y = L2 + W2 - L1 - W1, B2 + H2 - B1 - H1
	elseif anchor == 'BOTTOMLEFT' then
		x, y = L2 - L1, B2 - B1
	elseif anchor == 'BOTTOMRIGHT' then
		x, y = L2 + W2 - L1 - W1, B2 - B1
	else
		x, y = L2 - L1 + (W2 - W1) * 0.5, B2 - B1 + (H2 - H1) * 0.5
	end
	frame:ClearAllPoints()
	frame:SetPoint(anchor, UIParent, x, y)
	addon.isMoving, settings.anchorOffsetX, settings.anchorOffsetY = nil, x, y
end

addon.OnEnter = addon.DoNothing
addon.OnLeave = addon.DoNothing

--[[-----------------------------------------------------------------------------
Addon methods
-------------------------------------------------------------------------------]]
function addon:ApplyPluginSettings()
	local settings = self.db.profile
	frame:ClearAllPoints()
	frame:SetPoint(settings.anchorPoint, UIParent, settings.anchorOffsetX, settings.anchorOffsetY)
	frame:SetFrameStrata(settings.frameStrata)
	frame:SetFrameLevel(settings.frameLevel)
	frame:SetBackdropColor(settings.frameBackgroundR, settings.frameBackgroundG, settings.frameBackgroundB, settings.frameBackgroundA)
	frame:SetBackdropBorderColor(settings.frameBorderR, settings.frameBorderG, settings.frameBorderB, settings.frameBorderA)
	self:UpdatePlugin()
end

function addon:IsTooltipAllowed()
	return SecureCmdOptionParse(self.db.profile.tooltip) ~= "Hide"
end

function addon:UpdatePlugin()
	local settings, button = self.db.profile
	local borderSpacing, buttonSize, spacing = settings.borderSpacing, settings.buttonSize, settings.spacing
	local baseOffset, offsetAdjust = buttonSize + spacing, borderSpacing + 3
	local ClearAllPoints, SetPoint = frame.ClearAllPoints, frame.SetPoint
	for index = 1, #order do
		button = order[index]
		button:SetHeight(buttonSize)
		button:SetWidth(buttonSize)
		ClearAllPoints(button)
		SetPoint(button, 'LEFT', frame, baseOffset * (index - 1) + offsetAdjust, 0)
	end
	frame:SetHeight(buttonSize + offsetAdjust + offsetAdjust)
	frame:SetWidth(baseOffset * #order - spacing + offsetAdjust + offsetAdjust)
end

--[[-----------------------------------------------------------------------------
Initialize
-------------------------------------------------------------------------------]]
frame:SetBackdrop({
	bgFile = [[Interface\BUTTONS\WHITE8X8]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
	tileSize = 16, tile = true,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
frame:SetClampedToScreen(true)
frame:SetClampRectInsets(3, -3, -3, 3)
frame:Show()
