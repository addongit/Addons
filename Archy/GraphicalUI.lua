local Archy = LibStub("AceAddon-3.0"):GetAddon("Archy")
local theme = Archy:NewModule("Theme_GraphicalUI", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Archy")

local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
if not LibSharedMedia then
	LoadAddOn("LibSharedMedia-3.0")
	LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
end

local DEFAULT_LSM_FONT = "Arial Narrow"
if LibSharedMedia then
	if not LibSharedMedia:IsValid("font", DEFAULT_LSM_FONT) then
		DEFAULT_LSM_FONT = LibSharedMedia:GetDefault("font")
	end
end

theme.displayName = "GraphicalUI"
theme.desc = ""

local frameAnchorOptions = {
	["TOPLEFT"]	= L["Top Left"],
	["TOPRIGHT"]	= L["Top Right"],
	["BOTTOMRIGHT"]	= L["Bottom Right"],
	["BOTTOMLEFT"]  = L["Bottom Left"],
}
local outlines = {
	[""]             = L["None"],
	["OUTLINE"]      = L["Outline"],
	["THICKOUTLINE"] = L["Thick Outline"],
}

local defaults = {
	profile = {
		hideInCombat = true,
		artifact = {
			shown = true,
			scale = 1,
			alpha = 1,
			rowHeight = 22,
			rowWidth = 300,
			expander = {
				shown = false,
				textureExpanded = 'Interface\Buttons\UI-MinusButton-Up',
				textureCollapsed = 'Interface\Buttons\UI-PlusButton-Up',
			},
			progressBar = {
				colors = {
					normal = { 1, 0.5, 0, 1 },
					rare = { 0, 0.4, 0.8, 1 },
					first = { 1, 1, 1, 1 },
					solvable = { 0, 1, 0, 1 },
					keystones = { 1, 1, 0, 1 },
				},
				texture = LibSharedMedia and LibSharedMedia:GetDefault("statusbar") or "Blizzard",
				backgroundTexture = 'Interface\\AddOns\\Archy\\Media\\Progress-Background',
			},
			font = { 
				name = DEFAULT_LSM_FONT,
				size = 12,
				outline = "",
				shadow = true,
				color = { 1, 1, 1, 1 },
			},
			solveButton = {
				texture = 'Interface\\ICONS\\TRADE_ARCHAEOLOGY_AQIR_ARTIFACTFRAGMENT.BLP',
				height = 22,
				width = 22,
			},
			border = {
				color = { 1, 1, 1, 1 },
				texture = 'Blizzard Tooltip',
				size = 16,
				padding = 3,
			},
			background = {
				color = { 0, 0, 0, 0.5 },
			},
		},
		digsite = {
			shown = true,
			scale = 1,
			alpha = 1,
			rowHeight = 22,
			rowWidth = 300,
			expander = {
				shown = false,
				textureExpanded = 'Interface\Buttons\UI-MinusButton-Up',
				textureCollapsed = 'Interface\Buttons\UI-PlusButton-Up',
			},
			font = { 
				name = DEFAULT_LSM_FONT,
				size = 12,
				outline = "",
				shadow = true,
				color = { 1, 1, 1, 1 },
			},
			border = {
				color = { 1, 1, 1, 1 },
				texture = 'Blizzard Tooltip',
				size = 16,
				padding = 3,
			},
			background = {
				color = { 0, 0, 0, 0.5 },
			},
		},
		distanceIndicator = {
			shown = true,
			scale = 1,
			alpha = 1,
			height = 42,
			width = 42,
			showSurveyButton = false,
			greenTexture = 'Interface\\AddOns\\Archy\\Media\\DistanceIndicator-Green',
			yellowTexture = 'Interface\\AddOns\\Archy\\Media\\DistanceIndicator-Yellow',
			redTexture = 'Interface\\AddOns\\Archy\\Media\\DistanceIndicator-Red',
			font = { 
				name = DEFAULT_LSM_FONT,
				size = 12,
				outline = "",
				shadow = true,
				color = { 1, 1, 1, 1 },
			},
		},
	},
}

function theme:OnInitialize()
	self.db = Archy.db:RegisterNamespace("GraphicalUI", defaults)
	if not self.db.profile.enabled then
		self:SetEnabledState(false)
	end
end

function theme:OnEnable()
	self:SetupArtifactsFrame()
	self:SetupDigsitesFrame()
	self:SetupDistanceIndicatorFrame()

	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function theme:OnDisable()
	self:SetupArtifactsFrame()
	self:SetupDigsitesFrame()
	self:SetupDistanceIndicatorFrame()
end

local inCombat = InCombatLockdown()
function theme:PLAYER_REGEN_ENABLED()
	inCombat = false
	if self.db.profile.hideInCombat then
		self:SetCombatAlpha()
	end
end

function theme:PLAYER_REGEN_DISABLED()
	inCombat = true
	if self.db.profile.hideInCombat then
		self:SetCombatAlpha()
	end
end

function theme:SetCombatAlpha()
	self.artifacts:SetAlpha(inCombat and 0 or self.db.profile.artifact.alpha)
	self.digsites:SetAlpha(inCombat and 0 or self.db.profile.digsite.alpha)
	self.indicatorFrame:SetAlpha(inCombat and 0 or self.db.profile.distanceIndicator.alpha)
end

local CreateArtifactRowFrame.__index = function(t,k)
	t[k] = CreateFrame("ArchyArtifactFrameRow" .. tostring(k), theme.artifacts)
	return t[k]
end

function theme:SetupArtifactsFrame()
	if not self.artifacts then
		self.artifacts = CreateFrame("ArchyArtifactFrame", nil)
		self.artifacts.children = setmetatable( {} , { CreateArtifactRowFrame })
	end
	
	
	
	
end

local CreateDigsiteRowFrame.__index = function(t,k)
	t[k] = CreateFrame("ArchyDigsitesFrameRow" .. tostring(k), theme.digsites, "ArchyDigSiteRowTemplate_GraphicalUI")
	return t[k]
end

function theme:SetupDigsitesFrame()
	if not self.digsites then
		self.digsites = CreateFrame("ArchyDigsitesFrame", nil)
		self.digsites.children = setmetatable( {}, { CreateDigsiteRowFrame })
	end
end

function theme:SetupDistanceIndicatorFrame()
	if not self.indicatorFrame then	
		self.indicatorFrame = CreateFrame("ArchyDistanceIndicatorFrame", nil)
	end
end


function theme:UpdateArtifactFrame(frame)
end

function theme:UpdateDigsiteFrame(frame)
end

function theme:UpdateDistanceIndicator(frame)
end


function theme:ShowArtifacts()
	self.db.profile.artifact.shown = true
end
function theme:HideArtifacts()
	self.db.profile.artifact.shown = false
end

function theme:ShowDigsites()
	self.db.profile.digsite.shown = true
end
function theme:HideDigsites()
	self.db.profile.digsite.shown = false
end

function theme:ShowDistanceIndicator()
	self.db.profile.distanceIndicator.shown = true
end
function theme:HideDistanceIndicator()
	self.db.profile.distanceIndicator.shown = false
end