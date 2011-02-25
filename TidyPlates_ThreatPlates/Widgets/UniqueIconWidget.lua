---------------
-- Unique Icon Widget
---------------
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\"

function uL(number)
	local name = GetSpellInfo(number)
	return name
end

TPuniqueList = {
	[uL(28673)] 					= "U1", -- Web Wrap
	["Immortal Guardian"] 			= "U2",
	["Marked Immortal Guardian"] 	= "U3",
	["Empowered Adherent"]			= "U4",
	["Deformed Fanatic"]			= "U5",
	["Reanimated Adherent"]			= "U6",	
	["Reanimated Fanatic"]			= "U6",
	["Bone Spike"]					= "U7",
	["Onyxian Whelp"] 				= "U8", 
	["Shambling Horror"]			= "U9",
	-- Player Pets
	[uL(34433)]						= "U10", -- Shadow Fiend
	["Spirit Wolf"]					= "U11",
	["Blood Worm"]					= "U12",
	["Water Elemental"]				= "U13",
	["Treant"]						= "U14",
	["Viper"]						= "U15",
	["Venomous Snake"]				= "U15",
	["Army of the Dead Ghoul"]		= "U16",
	-- Added
	["Gas Cloud"]					= "U17",
	["Volatile Ooze"]				= "U18",
	["Darnavan"] 					= "U19",
	["Val'kyr Shadowguard"]			= "U20",
	["Kinetic Bomb"] 				= "U21",
	["The Lich King"] 				= "U22",
	["Raging Spirit"] 				= "U23",
	["Drudge Ghoul"] 				= "U24",
	["Unbound Seer"]				= "U25",
	["Living Inferno"]				= "U26",
	["Living Ember"]				= "U27",
	["Fanged Pit Viper"]			= "U28",
	["Shadowy Apparition"] 			= "U29",
	["Canal Crab"] 					= "U30",
	["Muddy Crawfish"]				= "U31"
}

local function UpdateUniqueIconWidget(self, unit)
	local unique = TPuniqueList[unit.name]
	local db = TidyPlatesThreat.db.profile
	--print(unique)
	if unique and db.uniqueWidget.ON and db.uniqueSettings[unique][6] then
		self.Icon:SetTexture(path..TPuniqueList[unit.name]) 
		self:Show()
	else self:Hide() end
end

local function CreateUniqueIconWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(64)
	frame:SetHeight(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetPoint("CENTER",frame)
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateUniqueIconWidget
	return frame
end

ThreatPlatesWidgets.CreateUniqueIconWidget = CreateUniqueIconWidget
