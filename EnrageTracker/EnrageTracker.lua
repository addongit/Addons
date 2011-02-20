-- EnrageTracker v1.5 by Naw
-- Track enrage effects with a customizable enrage bar


-- Setup the ace3 addon
local EnrageTracker = LibStub("AceAddon-3.0"):NewAddon("EnrageTracker", "AceConsole-3.0", "AceEvent-3.0")

-- Setup the anchor frame
local EnragedFrame = CreateFrame("Frame", "EnragedFrame")
EnragedFrame:ClearAllPoints()
EnragedFrame:SetPoint("CENTER", UIParent, "CENTER")
EnragedFrame:SetMovable(true)
EnragedFrame:SetResizable(true)
EnragedFrame:SetClampedToScreen(true)
EnragedFrame:SetDontSavePosition(true)
EnragedFrame:SetMinResize(100, 10)
EnragedFrame:SetMaxResize(300, 50)
EnragedFrame:SetScript("OnMouseDown", function() EnragedFrame:StartMoving() end)
EnragedFrame:SetScript("OnMouseUp", function() EnragedFrame:StopMovingOrSizing(); EnrageTracker:SavePosition() end)

-- Setup the enraged bar
local EnragedBar = CreateBar("Interface\\Addons\\EnrageTracker\\Textures\\smooth.tga", 100, 15)
EnragedBar:SetAllPoints(EnragedFrame)

-- Setup the resize grip
local EnragedResizeFrame = CreateFrame("Button", "EnragedResizeFrame", EnragedFrame)
EnragedResizeFrame:SetSize(15, 15)
EnragedResizeFrame:SetPoint("BOTTOMRIGHT", EnragedFrame, 5, -5)
EnragedResizeFrame:SetNormalTexture("Interface\\Addons\\EnrageTracker\\Textures\\ResizeGrip")
EnragedResizeFrame:SetHighlightTexture("Interface\\Addons\\EnrageTracker\\Textures\\ResizeGrip")
EnragedResizeFrame:SetScript("OnMouseDown", function() EnragedFrame:StartSizing("BOTTOMRIGHT") end)
EnragedResizeFrame:SetScript("OnMouseUp",  function() EnragedFrame:StopMovingOrSizing(); EnrageTracker:SavePosition() end)

-- Register the bar textures
local SharedMedia = LibStub("LibSharedMedia-3.0")
SharedMedia:Register("texture", "Banto", "Interface\\Addons\\EnrageTracker\\Textures\\banto.tga")
SharedMedia:Register("texture", "Blizzard", "Interface\\TargetingFrame\\UI-StatusBar")
SharedMedia:Register("texture", "Charcoal", "Interface\\Addons\\EnrageTracker\\Textures\\charcoal.tga")
SharedMedia:Register("texture", "Glaze", "Interface\\Addons\\EnrageTracker\\Textures\\glaze.tga")
SharedMedia:Register("texture", "Otravi", "Interface\\Addons\\EnrageTracker\\Textures\\otravi.tga")
SharedMedia:Register("texture", "Perl", "Interface\\Addons\\EnrageTracker\\Textures\\perl.tga")
SharedMedia:Register("texture", "Smooth", "Interface\\Addons\\EnrageTracker\\Textures\\smooth.tga")
SharedMedia:Register("texture", "Striped", "Interface\\Addons\\EnrageTracker\\Textures\\striped.tga")
SharedMedia:Register("texture", "Transparent", "Interface\\Addons\\EnrageTracker\\Textures\\transparent.tga")

	
-- List of enrage effects
local enrages = { "Enrage", "Death Wish", "Berserker Rage", "Unholy Frenzy" }


--------------------------------------------------------------------------------
-- Options table and defaults table
--------------------------------------------------------------------------------


-- Options table
local options = {
	type = "group",
	name = "EnrageTracker",
	handler = EnrageTracker,
	args = {
		enable = {
			type = "toggle",
			name = "Enable",
			desc = "Enable or disable the addon",
			order = 10,
			get = function(info) return EnrageTracker.db.profile.enable end,
			set = function(info, value)
				EnrageTracker.db.profile.enable = value
				EnrageTracker:ToggleAddon()
			end,
		},
		
		fury = { 
			type = "toggle",
			name = "Fury only",
			desc = "Only track enrages while specced as fury",
			order = 20,
			get = function(info) return EnrageTracker.db.profile.fury end,
			set = function(info, value) 
				EnrageTracker.db.profile.fury = value
				EnrageTracker:ToggleAddon()
			end,
		},
		
		spacer1 = {
			type = "description",
			name = "",
			order = 30,
			width = "full",
		},
		
		color = {
			type = "color",
			name = "Bar color",
			desc = "Set the bar color",
			order = 40,
			cmdHidden = true,
			get = function(info) return unpack(EnrageTracker.db.profile.color) end,
			set = function(info, r, g, b, a)
				EnrageTracker.db.profile.color = { r, g, b, a }
				EnrageTracker:UpdateBar()
			end,
		},
				
		texture = {
			type = "select",
			name = "Bar texture",
			desc = "Set the bar texture",
			order = 50,
			cmdHidden = true,
			values = SharedMedia:List("texture"),
			get = function(info) return EnrageTracker.db.profile.texture end,
			set = function(info, value)
				EnrageTracker.db.profile.texture = value
				EnrageTracker:UpdateBar()
			end,
		},
				
		config = {
			type = "execute",
			name = "Config",
			desc = "Show the config panel",
			order = 60,
			guiHidden = true,
			func = "ShowConfig",
		},
		
		spacer2 = {
			type = "description",
			name = "",
			order = 70,
			width = "full",
		},
		
		lock = { 
			type = "execute",
			name = "Lock",
			desc = "Lock the bar",
			order = 80,
			func = "LockBar",
		},
		
		unlock = {
			type = "execute",
			name = "Unlock",
			desc = "Unlock the bar",
			order = 90,
			func = "UnlockBar",
		},
		
		reset = {
			type = "execute",
			name = "Reset",
			desc = "Reset the bar position",
			order = 100,
			func = "ResetBar",
		},
		
		test = {
			type = "execute",
			name = "Test",
			desc = "Show a test bar",
			order = 110,
			func = function() EnragedBar:Start(10) end,
		},
	},
}


-- Default settings
local defaults = {
	profile = {
		enable = true,
		fury = true,
		locked = false,

		color = { 1, 0, 0, 1 },
		texture = 7,
		
		width = 100,
		height = 12,
		point = "CENTER",
		x = 0,
		y = 0,
	},
}


--------------------------------------------------------------------------------
-- Main functions
--------------------------------------------------------------------------------


-- OnInitialize() - Called when the addon is loaded
function EnrageTracker:OnInitialize()
	-- Only load the addon for warriors
	local _, className = UnitClass("player")
	if className ~= "WARRIOR" then
		return
	end
	
	-- Load saved variables
	self.db = LibStub("AceDB-3.0"):New("EnrageTrackerDB", defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")
	
	-- Setup the options table
	LibStub("AceConfig-3.0"):RegisterOptionsTable("EnrageTracker", options, {"enragetracker", "enrage"})
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EnrageTracker", "EnrageTracker")
	
	-- Add the profiles page
	LibStub("AceConfig-3.0"):RegisterOptionsTable("EnragedProfiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
	self.optionsFrame.profiles = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EnragedProfiles", "Profiles", "EnrageTracker")

	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "ToggleAddon")
	
	-- Initialize variables
	self.buffList = {}
	self.lastExpire = 0
	
	-- Enable the addon
	self:UpdateBar()
	self:LoadPosition()
	self:ToggleAddon()
end


-- ToggleAddon() - Enable or disable the addon
function EnrageTracker:ToggleAddon()
	if self.db.profile.enable and (not self.db.profile.fury or (self.db.profile.fury and GetPrimaryTalentTree() == 2)) then
		self:RegisterEvent("UNIT_AURA")
	else
		self:UnregisterEvent("UNIT_AURA")
	end
end


-- ProfileChanged() - Called whenever the profile is changed
function EnrageTracker:ProfileChanged(event, database)
	self.db = database
	self:UpdateBar()
	self:LoadPosition()
	self:ToggleAddon()
end


-- ShowConfig() - Show the options frame
function EnrageTracker:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end


-- UNIT_AURA() - Called whenever the player gains or loses a buff
-- This function keeps track of enrage uptimes and displays the enrage bar when needed
function EnrageTracker:UNIT_AURA(event, unit, ...)
	if unit ~= "player" then
		return
	end
		
	-- Clear the buff history if the bar isn't visible
	if not EnragedBar:IsVisible() then
		self.buffList = {}
		self.lastExpire = 0
	end

	-- Check for enrage effects
	local buff, expires
	for k,v in pairs(enrages) do
		buff, _, _, _, _, _, expires = UnitBuff("player", v)
		if buff then
			-- Add the buff
			if not self.buffList[buff] then
				self.buffList[buff] = 0
			end		
			-- Update the expiration date
			self.buffList[buff] = expires
		else
			-- Remove the buff
			if self.buffList[v] then
				self.buffList[v] = nil
			end
		end
	end

	-- Find the enrage effect with the longest remaining duration
	local name
	local longest = 0
	for k,v in pairs(self.buffList) do
		if v > longest then
			name = k
			longest = v
		end
	end

	-- Show the longest enrage effect
	if longest > self.lastExpire then
		EnragedBar:Start(longest - GetTime())
		self.lastExpire = longest
	-- Hide the bar if there aren't any enrages
	elseif not name then
		EnragedBar:Stop()
	end
end


-- UpdateBar() - Set the bar texture, color, etc..
function EnrageTracker:UpdateBar()
	-- Lock or unlock the bar
	if self.db.profile.locked then
		self:LockBar()
	else
		self:UnlockBar()
	end

	-- Set the texture and color
	local list = SharedMedia:List("texture")
	EnragedBar:SetTexture(SharedMedia:Fetch("texture", list[self.db.profile.texture]))
	EnragedBar:SetColor(unpack(self.db.profile.color))
end


--------------------------------------------------------------------------------
-- Frame functions
--------------------------------------------------------------------------------


-- LockBar() - Lock the frame
function EnrageTracker:LockBar()
	self.db.profile.locked = true
	EnragedFrame:EnableMouse(false)
	EnragedFrame:SetBackdrop(nil)
	EnragedResizeFrame:Hide()
end


-- UnlockBar() - Unlock the frame
function EnrageTracker:UnlockBar()
	self.db.profile.locked = false
	EnragedFrame:EnableMouse(true)
	EnragedFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"})
	EnragedFrame:SetBackdropColor(1.0, 0.0, 0.0, 0.75)
	EnragedFrame:Show()
	EnragedResizeFrame:Show()
end


-- ResetBar() - Reset the frame
function EnrageTracker:ResetBar()
	EnragedFrame:ClearAllPoints()
	EnragedFrame:SetPoint("CENTER", UIParent, "CENTER")
	self:UnlockBar()
end


--- SavePosition() - Save the frame position and size
function EnrageTracker:SavePosition()
	self.db.profile.width, self.db.profile.height = EnragedFrame:GetSize()
	self.db.profile.point, _, _, self.db.profile.x, self.db.profile.y = EnragedFrame:GetPoint()
end


--- LoadPosition() - Load the frame position and size
function EnrageTracker:LoadPosition()
	EnragedFrame:SetSize(self.db.profile.width, self.db.profile.height)
	EnragedFrame:ClearAllPoints()
	EnragedFrame:SetPoint(self.db.profile.point, nil, self.db.profile.point, self.db.profile.x, self.db.profile.y)
end

