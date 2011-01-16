if (not OzUIConfig.OzCD.enabled) then
	return
end

local OzCD = {

} 

local API_GetTime = GetTime


OzCD.config = {
	["defaultFrontEnd"] = "OzIcons",
	["useWhitelist"] = false
}


OzCD["frame"] = CreateFrame("Frame","OzCDFrame",UIParent)

local cds = {
	["spell"] = {},
	["inv"] = {},
}


OzCD.config.spells = {
	["DEFAULT"] = {
		[42292] = {type = "inv", slot = {13,14}},
		[54757] = {type = "inv", slot = {10}},
		[54758] = {type = "inv", slot = {10}},
		[55004] = {type = "inv", slot = {8}},
		[55001] = {type = "inv", slot = {15}},
		[8690] = {blacklist = true}, -- Hearthstone 
	},
	["DEATHKNIGHT"] = {
		[45525] = {blacklist = true}, -- Chains of ice
		[45462] = {blacklist = true}, -- Plague strike
		[45477] = {blacklist = true}, -- Icy Touch
		[45902] = {blacklist = true}, -- Blood strike
		[49020] = {blacklist = true}, -- Obliterate
		[50842] = {blacklist = true}, -- Pestilence
		[48721] = {blacklist = true}, -- Blood boil
		[49143] = {blacklist = true}, -- Frost Strike
		[55090] = {blacklist = true}, -- Scourge Strike
		[85948] = {blacklist = true}, -- Festering Strike
		[49184] = {blacklist = true}, -- Howling Blast
		[42650] = {blacklist = true}, -- Army
		[63560] = {blacklist = true}, -- Dark transform
		[49998] = {blacklist = true}, -- Death Strike
		[3714] = {blacklist = true}, -- Death Strike
	},
	["SHAMAN"] = {},
	["DRUID"] = {},
	["PRIEST"] = {},
	["MAGE"] = {},
	["WARLOCK"] = {},
	["WARRIOR"] = {},
	["PALADIN"] = {},
	["ROGUE"] = {},
	["HUNTER"] = {},
}



local foundBuffs = {}

function OzCD:Init()
	-- Try to load Default front end if it was not loaded already
	self.defaultFrontEnd = _G[self.config.defaultFrontEnd]
	self.timeSinceLastUpdate = 0
	self.updateInterval = 0.1
	
	-- create dummy frame for registering events
	OzCD["frame"]:SetPoint("CENTER",UIParent,"CENTER",0,0)		

	self.class = select(2,UnitClass("player"))

	-- Copy class settings over the default settings
	for spellId, spellInfo in pairs(self.config.spells[self.class]) do
		self.config.spells["DEFAULT"][spellId] = spellInfo
	end

	-- Register events and stuff
	OzCD:Enable()
end

function OzCD:Enable()
    OzCD["frame"]:RegisterEvent( "PLAYER_ENTERING_WORLD" )
    OzCD["frame"]:RegisterEvent( "UNIT_SPELLCAST_SUCCEEDED" )
    OzCD["frame"]:RegisterEvent( "SPELL_UPDATE_COOLDOWN" )
	OzCD["frame"]:SetScript("OnUpdate", UpdateCooldown)

	OzCD["frame"]:SetScript("OnEvent", function(self, event, ...)
		OzCD["frame"][event](self, event, ...)
	end)

end


function HighUpdateCooldown(self, elapsed)
	timeSinceLastUpdate =timeSinceLastUpdate + elapsed; 	

	while (timeSinceLastUpdate > updateInterval) do
		OzCD["frame"]:SPELL_UPDATE_COOLDOWN(nil)
		timeSinceLastUpdate = timeSinceLastUpdate - updateInterval;
	end
end


function UpdateCooldown(self, elapsed)
	-- Keep up with cooldown updates
	OzCD.timeSinceLastUpdate = OzCD.timeSinceLastUpdate + elapsed
	if (OzCD.timeSinceLastUpdate > OzCD.updateInterval) then
		OzCD["frame"]:SPELL_UPDATE_COOLDOWN(nil)
		OzCD.timeSinceLastUpdate = 0
	end
end

function OzCD.frame:SPELL_UPDATE_COOLDOWN(event)
	for type,spellCds in pairs(cds) do
		for spellId, info in pairs(spellCds) do
			local start, duration, enabled
			if (type == "inv") then
				start, duration, enable = GetItemCooldown(spellId)
			else
				start, duration, enable = GetSpellCooldown(spellId)
			end
			local cooldown = 0
			cooldown = start+duration-API_GetTime()
			if not enable then
				OzCD.defaultFrontEnd:Hide("focus",type..spellId)
				info.cdSet = false
				--
			elseif ( start > 0 and duration > 1.5) then
				if (not info.cdSet) then
					OzCD.defaultFrontEnd:Create("cooldown",type..spellId,icon,spellName,0,duration,start+duration)
					info.cdSet = true
				end
				if (cooldown <= 0 ) then
					OzCD.defaultFrontEnd:Hide("cooldown",type..spellId)
					info.cdSet = false
				end

			else
				OzCD.defaultFrontEnd:Hide("cooldown",type..spellId)
				info.cdSet = false
			end
		end
	end
end

function OzCD.frame:PLAYER_ENTERING_WORLD(event)

end


function OzCD.frame:UNIT_SPELLCAST_SUCCEEDED(event, unit, spellName,rank,lineId,spellId)
	local spellInfo = OzCD.config.spells["DEFAULT"][spellId]

	if ((unit ~= "player" and unit ~= "pet") or (OzCD.config.useWhiteList and (not spellInfo or not spellInfo.whitelist)) or (not OzCD.config.useWhiteList and (spellInfo and spellInfo.blacklist)))then
		return
	end
		local spellName, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId)
		if (spellInfo) then
			if (spellInfo.type == "inv") then
				for k,iSlot in pairs(spellInfo.slot) do
					local itemId = GetInventoryItemID("player", iSlot)
					icon = GetItemIcon(itemId)
					local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(itemId)
					OzCD.defaultFrontEnd:Create("cooldown","inv"..itemId,icon,sName,0,0,0)
					cds["inv"][itemId] = {["cdSet"] = false}
				end
			else 
				if spellInfo.frontEnds then
					for k,frontEnd in pairs(spellInfo.frontEnds) do
						local arg = nil
						if frontEnd.arg then
							arg = frontEnd.arg
						end
						_G[frontEnd.name]:Create("cooldown","spell"..spellId,icon,spellName,0,0,0,arg)
					end
				else
					OzCD.defaultFrontEnd:Create("cooldown","spell"..spellId,icon,spellName,0,0,0)
				end
			end
		else
			OzCD.defaultFrontEnd:Create("cooldown","spell"..spellId,icon,spellName,0,0,0)
		end
		cds["spell"][spellId] = {["cdSet"] = false}

end

OzCD:Init()
