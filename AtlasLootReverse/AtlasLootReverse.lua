--[[
	AtlasLootReverse
	Written by pceric
	http://www.wowinterface.com/downloads/info9179-Know-It-All.html
]]
AtlasLootReverse = LibStub("AceAddon-3.0"):NewAddon("AtlasLootReverse", "AceConsole-3.0")
local TT = LibStub("LibExtraTip-1")
local L = LibStub("AceLocale-3.0"):GetLocale("AtlasLootReverse", true)

AtlasLootReverse.title = L["AtlasLootReverse"]
AtlasLootReverse.version = GetAddOnMetadata("AtlasLootReverse", "Version")

local db
local tmp

-- Default settings
local defaults = {
	profile = {
		dbversion = "",
		alversion = "",
		whoTable = {},
		embedded = true
	}
}

-- searches a table for string s
local function tfind(t, s)
	local last
	for k, v in pairs(t) do
		if type(v) == "table" then
			tfind(v, s)
		else
			if v == s then
				tmp = last
			end
			last = v
		end
	end 
end

----------------------
--On start
function AtlasLootReverse:OnInitialize()
	local alrdb = LibStub("AceDB-3.0"):New("AtlasLootReverseDB", defaults, true)
	db = alrdb.profile --local the profile table
    self:RegisterChatCommand(L["atlaslootreverse"], "ChatCommand")
    self:RegisterChatCommand(L["alr"], "ChatCommand")
	TT:RegisterTooltip(GameTooltip)
	TT:RegisterTooltip(ItemRefTooltip)
end

----------------------
--Disabled
function AtlasLootReverse:OnDisable()
	TT:RemoveCallback(AtlasLootReverse.Who)
end

----------------------
--Loaded
function AtlasLootReverse:OnEnable()
	-- Sanity check for v6 of ALE
	assert(ATLASLOOT_VERSION_NUM, "Your AtlasLoot is either too old or broken!")
	if db.dbversion ~= AtlasLootReverse.version or db.alversion ~= ATLASLOOT_VERSION_NUM then
		local zone
		local excludes = {
			[29434] = true,  -- BoJ
			[40752] = true,  -- EoH
			[40753] = true,  -- EoV
			[43102] = true,  -- Frozen Orb
			[45624] = true,  -- EoC
			[47241] = true,  -- EoT
			[49426] = true,  -- EoF
			[44990] = true,  -- CS
			[45038] = true,  -- Frag
			[46017] = true,  -- Hammer
			[47242] = true,  -- Trophy
			[49908] = true,  -- Primordial Saronite
			[50274] = true,  -- Shadowfrost Shard
			[52025] = true,  -- VMoS
			[52026] = true,  -- PMoS
			[52027] = true,  -- CMoS
		}
		local tiers = {
			["PVP70SET"] = string.format(L["PvP %s Set"], "70"),
			["PVP80SET"] = string.format(L["PvP %s Set"], "80"),
			["PVP85SET"] = string.format(L["PvP %s Set"], "85"),
			["T456SET"] = string.format(L["PvP %s Set"], "4/5/6"),
			["T7T8SET"] = string.format(L["Tier %s"], "7/8"),
			["T9SET"] = string.format(L["Tier %s"], "9"),
			["T10SET"] = string.format(L["Tier %s"], "10"),
			["T11SET"] = string.format(L["Tier %s"], "11"),
		}
		wipe(db.whoTable) -- Wipe the table
		AtlasLoot:LoadModule("all")  -- Force AtlasLoot to load all modules
		for _,itable in pairs(AtlasLoot_Data) do
			for k,v in pairs(itable) do
				if string.find(k, "Normal") or string.find(k, "Heroic") or string.find(k, "25Man") then  -- Doing a find because some are _A and some _H
					for _, page in pairs(v) do
						for k2,v2 in pairs(page) do
							if type(v2) == "table" and type(v2[2]) == "number" and v2[2] > 0 and not excludes[v2[2]] and itable.info.name ~= "Keys" then
								if itable.info.instance and AtlasLoot_LootTableRegister.Instances[itable.info.instance] then
									-- Some bizzare voodoo in ALE v6.02.00
									if type(AtlasLoot_LootTableRegister.Instances[itable.info.instance]) == "string" then
										zone = AtlasLoot_LootTableRegister.Instances[AtlasLoot_LootTableRegister.Instances[itable.info.instance]].Info[1]
									else
										zone = AtlasLoot_LootTableRegister.Instances[itable.info.instance].Info[1]
									end
								else
									zone = ""
								end
								-- Check if non-normal zone
								if k == "Heroic" then
									zone = strtrim(string.format(L["Heroic %s"], zone))
								elseif k == "25Man" then
									zone = strtrim(string.format(L["25 Man %s"], zone))
								elseif k == "25ManHeroic" then
									zone = strtrim(string.format(L["25 Man Heroic %s"], zone))
								end
								if zone ~= "" then
									zone = " (" .. zone .. ")"
								end
								-- Check to see if it drops from multiple people
								if (db.whoTable[v2[2]]) then
									if not string.find(db.whoTable[v2[2]], itable.info.name .. zone, 1, true) then
										db.whoTable[v2[2]] = db.whoTable[v2[2]] .. "|" .. itable.info.name .. zone
									end
								else
									db.whoTable[v2[2]] = itable.info.name .. zone
								end
								-- Check to see if this is a set piece
								if itable.info.menu and tiers[itable.info.menu] then
									db.whoTable[v2[2]] = db.whoTable[v2[2]] .. " " .. tiers[itable.info.menu]
								end
							end
						end
					end
				end
			end
		end
		db.dbversion = AtlasLootReverse.version
		db.alversion = ATLASLOOT_VERSION_NUM
		print(AtlasLootReverse.title .. " database rebuilt.")
	end
	TT:AddCallback(AtlasLootReverse.Who)
end

----------------------
--Command Handler
function AtlasLootReverse:ChatCommand(input)
    if input:trim() == "embed" then
        db.embedded = not db.embedded
		print(L["Tooltip embedded: "] .. tostring(db.embedded))
	else
		print(L["Commands:\n/alr embed - Toggles the tooltip being embedded or split into another box"])
    end
end

-- LibExtraTip Call Backs
function AtlasLootReverse:Who(item)
	local _, itemId = strsplit(":", item)
	--TT:AddLine(self, itemId, nil, nil, nil, db.embedded)
	if db.whoTable[tonumber(itemId)] then
		for v in string.gmatch(db.whoTable[tonumber(itemId)], "[^|]+") do
			if not string.find(v, 'Tier ') and not string.find(v, 'Tabards') and not string.find(v, 'PvP ') then
				v = string.format(L["Drops from %s"], v)
			end
			TT:AddLine(self, v, nil, nil, nil, db.embedded)
		end
	end
end