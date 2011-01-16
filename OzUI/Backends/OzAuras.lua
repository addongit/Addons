if (not OzUIConfig.OzAuras.enabled) then
	return
end

local class = select(2,UnitClass("player"))

local auras = {
	["DEFAULT"] = {
		["player"] = {
			["HARMFUL"] = {
				[11196] = {["frame"] = "Player_Buff"}, -- First aid 
			},
			["HELPFUL"] = {
				[2825] = {["frame"] = "Player_Buff"}, -- Bloodlust
				[67773] = {["frame"] = "Player_Buff" }, -- Paragon
				[75458] = {["frame"] = "Player_Buff", ["internalCd"] = 45}, -- Piercing Twilight
				[71559] = {["frame"] = "Player_Buff", ["internalCd"] = 105}, -- Aim of the iron dwarves
				[71560] = {["frame"] = "Player_Buff", ["internalCd"] = 105 }, -- Speed of the vrykul
				[71485] = {["frame"] = "Player_Buff", ["internalCd"] = 105 }, -- Agility of the vrykul
				[71486] = {["frame"] = "Player_Buff", ["internalCd"] = 105 }, -- Power of the taunka
				[71561] = {["frame"] = "Player_Buff", ["internalCd"] = 105 }, -- Strength of the taunka
				[54758] = {["frame"] = "Player_Buff"}, -- Hyperspeed acceleration
				[71636] = {["frame"] = "Player_Buff"}, -- Pylactery of the nameless lich (heroic)
				[71643] = {["frame"] = "Player_Buff"}, -- Dislodged forein object (heroic)
				[71643] = {["frame"] = "Player_Buff"}, -- Dislodged forein object (heroic)
				[72416] = {["frame"] = "Player_Buff"}, -- Frostforged sage
				[20572] = {["frame"] = "Player_Buff"}, -- Blood fury
				[33697] = {["frame"] = "Player_Buff"}, -- Blood fury
				[55503] = {["frame"] = "Player_Buff"}, -- Lifeblood
				[10060] = {["frame"] = "Player_Buff"}, -- Power infusion
				[1022] = {["frame"] = "Player_Buff"}, -- Hand of Protection
                [71636] = {["frame"] = "Player_Buff"}, -- Siphoned Power
                [71605] = {["frame"] = "Player_Buff"}, -- Siphoned Power
                [59626] = {["frame"] = "Player_Buff"}, -- Black Magic
			},
		},
		["target"] = {
			["HARMFUL"] = {			},
			["PLAYER|HARMFUL"] = {},
			["HELPFUL"] = {
				[6346] = {["frame"] = "Target_Buff"}, -- Fearward
				[48707] = {["frame"] = "Target_Buff"}, -- Anti-magic Shell
				[48792] = {["frame"] = "Target_Buff"}, -- Icebound fortitude
				[51271] = {["frame"] = "Target_Buff"}, -- Pillar of frost
				[47788] = {["frame"] = "Target_Buff"}, -- Guardian spirit
				[33206] = {["frame"] = "Target_Buff"}, -- Pain supression
				[45438] = {["frame"] = "Target_Buff"}, -- Ice block
				[48108] = {["frame"] = "Target_Buff"}, -- Hot streak
				[64343] = {["frame"] = "Target_Buff"}, -- Impact
				[8178] = {["frame"] = "Target_Buff"}, -- Grounding
				[10060] = {["frame"] = "Target_Buff"}, -- Power infusion
				[10060] = {["frame"] = "Target_Buff"}, -- Power infusion
				[642] = {["frame"] = "Target_Buff"}, -- Divine Shield
				[1022] = {["frame"] = "Target_Buff"}, -- Hand of Protection
			},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {},
		},
		["focus"] = {
		},
	}
}
if (class == "HUNTER") then
	auras.HUNTER = {
		["player"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
				[53220] = {["frame"] = "Player_Buff"}, -- Improved Steady
				[82692] = {["frame"] = "Player_Buff"}, -- Focus Fire
		},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {},
		},
		["target"] = {
			["HARMFUL"] = {},
			["PLAYER|HARMFUL"] = {
				[1130] = {["frame"] = "Target_Debuff"}, -- Hunter's Mark
				[88691] = {["frame"] = "Target_Debuff"}, -- Mark of Death
				[1978] = {["frame"] = "Target_Debuff"}, -- Serpent Sting
			},
			["HELPFUL"] = {},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {},
		},
	}
end
if (class == "DEATHKNIGHT") then
	auras.DEATHKNIGHT = {
		["player"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
				[49016] = {["frame"] = "Player_Buff" }, -- Unholy Frenzy
				[51124] = {["frame"] = "procs", ["frontEnds"] = {
					{["name"] = "OzIcons", ["arg"] = {1,1,1}}, 
					--{["name"] = "OzBars", ["arg"] = {1,1,1}}, 
					{["name"] = "OzSounds", ["arg"] = "Interface\\AddOns\\DXE\\Sounds\\NeoBeep.mp3"},
				} }, -- Killing Machine
				[59052] = {["frame"] = "procs", ["frontEnds"] = {
					{["name"] = "OzIcons", ["arg"] = {1,1,1}}, 
					--{["name"] = "OzBars", ["arg"] = {1,1,1}}, 
					{["name"] = "OzSounds", ["arg"] = "Interface\\AddOns\\DXE\\Sounds\\LiftMe.mp3"},
				} }, -- Freezing fog
				[53365] = {["frame"] = "Player_Buff" }, -- Unholy Strength
				[81340] = {["frame"] = "procs", ["frontEnds"] = {
					{["name"] = "OzIcons", ["arg"] = {1,1,1}}, 
					{["name"] = "OzSounds", ["arg"] = "Interface\\AddOns\\DXE\\Sounds\\LiftMe.mp3"},
				}}, -- Sudden Doom
				[48707] = {["frame"] = "Player_Buff", ["frontEnds"] = {
					{["name"] = "OzIcons", ["arg"] = {1,1,1}}, 
					--{["name"] = "OzBars", ["arg"] = {1,0,0}},
				}}, -- Anti-magic Shell
				[48792] = {["frame"] = "Player_Buff"}, -- Icebound fortitude
				[51271] = {["frame"] = "Player_Buff"}, -- Pillar of frost
				[51460] = {["frame"] = "Player_Buff"}, -- Runic Corruption
			},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {
				[55095] = {["frame"] = "focus"}, -- Frost Fever
				[55078] = {["frame"] = "focus"}, -- Blood plague
			},
			["HARMFUL"] = {
				[91800] = {["frame"] = "Target_Debuff"}, -- Gnaw
				[91797] = {["frame"] = "Target_Debuff"}, -- Monstrous blow
				[47476] = {["frame"] = "Target_Debuff"}, -- Strangulate
			},
		},
		["target"] = {
			["HARMFUL"] = {
				[91800] = {["frame"] = "Target_Debuff"}, -- Gnaw
				[91797] = {["frame"] = "Target_Debuff"}, -- Monstrous blow
				[47476] = {["frame"] = "Target_Debuff"}, -- Strangulate
				[45524] = {["frame"] = "Target_Debuff"}, -- Chains of ice
				[50435] = {["frame"] = "Target_Debuff"}, -- Chillblains
			},
			["PLAYER|HARMFUL"] = {
				[55095] = {["frame"] = "Target_Debuff", ["frontEnds"] = {
					{["name"] = "OzIcons", ["arg"] = {0.5,0.5,1}}, 
					--{["name"] = "OzBars", ["arg"] = {0.5,0.5,1}},
				}}, -- Frost Fever
				[55078] = {["frame"] = "Target_Debuff", ["frontEnds"] = {
					{["name"] = "OzIcons", ["arg"] = {1,0.5,0.5}}, 
					--{["name"] = "OzBars", ["arg"] = {1,0.5,0.5}},
				}}, -- Blood plague
				--[55078] = {["frame"] = "Target_Debuff", ["frontEnds"] = {{["name"] = "OzIcons", ["arg"] = {1,0.5,0.5}}, {["name"] = "OzBars", ["arg"] = {1,0.5,0.5}}}}, -- Blood plague
			},
			["HELPFUL"] = {},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
				[91342] = {["frame"] = "Player_Buff"}, -- Shadow Infusion
				[63560] = {["frame"] = "Player_Buff"}, -- Shadow Infusion
			},
		},
	}
end
if (class == "WARLOCK") then
	auras.WARLOCK = {
		["player"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
				[17941] = {["frame"] = "Player_Buff"}, -- Shadow trance
			},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {
			},
		},
		["target"] = {
			["HARMFUL"] = {
				[1490] = {["frame"] = "Target_Debuff"}, -- curse of elements
			},
			["PLAYER|HARMFUL"] = {
				[603] = {["frame"] = "Target_Debuff"}, -- Bane of doom
				[980] = {["frame"] = "Target_Debuff"}, -- Bane of agony
				[172] = {["frame"] = "Target_Debuff"}, -- corruption
				[30108] = {["frame"] = "Target_Debuff"}, -- Unstable affliction
				[48181] = {["frame"] = "Target_Debuff"}, -- Haunt
				[64371] = {["frame"] = "Target_Debuff"}, -- Eradication
			},
			["HELPFUL"] = {},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
			},
		},
	}
end
if (class == "MAGE") then
	auras.MAGE = {
		["player"] = {
			["HARMFUL"] = {
                [44457] = {["frame"] = "Target_Debuff"}, -- Living bomb
 			},
			["HELPFUL"] = {
			},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {
			},
		},
		["target"] = {
			["HARMFUL"] = {
			},
			["PLAYER|HARMFUL"] = {
				[44461] = {["frame"] = "Target_Debuff"}, -- Bane of doom
			},
			["HELPFUL"] = {},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
			},
		},
	}
end
if (class == "SHAMAN") then
	auras.SHAMAN = {
		["player"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
				[324] = {["frame"] = "Player_Buff"}, -- Lightning shield
				[77747] = {["frame"] = "Player_Buff"}, -- Totem of wrath
				[64701] = {["frame"] = "Player_Buff"}, -- Elemental mastery
				[16166] = {["frame"] = "Player_Buff"}, -- Elemental mastery
				[52127] = {["frame"] = "Player_Buff"}, -- Elemental mastery
				[974] = {["frame"] = "Player_Buff"}, -- Elemental mastery
			},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {
			},
		},
		["target"] = {
			["HARMFUL"] = {
			},
			["PLAYER|HARMFUL"] = {
				[8050] = {["frame"] = "Target_Debuff"}, -- Flameshock
			},
			["HELPFUL"] = {
				[974] = {["frame"] = "Target_Buff"}, -- Elemental mastery
			},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
			},
		},
	}
end
if (class == "PALADIN") then
	auras.PALADIN = {
		["player"] = {
			["HARMFUL"] = {
				[25771] = {["frame"] = "Player_Debuff"}, -- Forberance
			},
			["HELPFUL"] = {
				[85496] = {["frame"] = "procs", ["frontEnds"] = {{["name"] = "OzIcons", ["arg"] = {1,1,1}}, {["name"] = "OzSounds", ["arg"] = "Interface\\AddOns\\DXE\\Sounds\\NeoBeep.mp3"}} }, -- The art of war
				[59578] = {["frame"] = "procs", ["frontEnds"] = {{["name"] = "OzIcons", ["arg"] = {1,1,1}}, {["name"] = "OzSounds", ["arg"] = "Interface\\AddOns\\DXE\\Sounds\\NeoBeep.mp3"}} }, -- The art of war
				[88819] = {["frame"] = "procs", ["frontEnds"] = {{["name"] = "OzIcons", ["arg"] = {1,1,1}}, {["name"] = "OzSounds", ["arg"] = "Interface\\AddOns\\DXE\\Sounds\\NeoBeep.mp3"}} }, -- Daybreak
				[53563] = {["frame"] = "Player_Buff"}, -- Beacon of Light
				[53657] = {["frame"] = "Player_Buff"}, -- Judgements of the Pure
				[54428] = {["frame"] = "Player_Buff"}, -- Divine Plea
				[498] = {["frame"] = "Player_Buff"}, -- Divine Protection
				[642] = {["frame"] = "Player_Buff"}, -- Divine Shield
			},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {
			},
		},
		["target"] = {
			["HARMFUL"] = {
			},
			["PLAYER|HARMFUL"] = {
				[31803] = {["frame"] = "Target_Debuff"}, -- Bane of doom
			},
			["HELPFUL"] = {
				[53563] = {["frame"] = "Target_Buff"}, -- Beacon of Light
			},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
			},
		},
	}
end
if (class == "PRIEST") then
	auras.PRIEST = {
		["player"] = {
			["HARMFUL"] = {
				[6788] = {["frame"] = "Player_Debuff"}, -- Weakened soul
			},
			["HELPFUL"] = {
				[72418] = {["frame"] = "Player_Buff"}, -- Chilling Knowledge
				[59888] = {["frame"] = "Player_Buff"}, -- Borrowed time
				[6346] = {["frame"] = "Player_Buff"}, -- Fearward
				[47788] = {["frame"] = "Player_Buff"}, -- Guardian spirit
				[63735] = {["frame"] = "Player_Buff"}, -- Serendipity
				[88688] = {["frame"] = "Player_Buff"}, -- Surge of light
		},
		},
		["focus"] = {
			["PLAYER|HARMFUL"] = {
				[6788] = {["frame"] = "Target_Debuff"}, -- Weakened soul
			},
			["HEPFUL"] = {
				[15357] = {["frame"] = "Target_Buff"}, -- Inspiration
			},
		},
		["target"] = {
			["HARMFUL"] = {
				[6788] = {["frame"] = "Target_Debuff"}, -- Weakened soul
			},
			["PLAYER|HARMFUL"] = {
			},
			["HELPFUL"] = {
				[77613] = {["frame"] = "Target_Buff"}, -- Grace
				[15357] = {["frame"] = "Target_Buff"}, -- Inspiration
				[41635] = {["frame"] = "Target_Buff"}, -- Prayer of Mending
			},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
			},
		},
	}
end
if (class == "ROGUE") then
	auras.ROGUE = {
		["player"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
				[58427] = {["frame"] = "Target_Debuff" }, -- Overkill
				[32645] = {["frame"] = "Target_Debuff" }, -- Envenom
				[32645] = {["frame"] = "Target_Debuff" }, -- Envenom
				[5171] = {["frame"] = "Target_Debuff" }, -- Envenom
			},
		},
		["target"] = {
			["HARMFUL|PLAYER"] = {
				[703] = {["frame"] = "Target_Debuff"}, -- Garrote
				[1943] = {["frame"] = "Target_Debuff"}, -- Rupture
				[2818] = {["frame"] = "Target_Debuff"}, -- Deadly Poison
				[79140] = {["frame"] = "Target_Debuff"}, -- Vendetta
				[408] = {["frame"] = "Target_Debuff"}, -- Kidney shot
				[1833] = {["frame"] = "Target_Debuff"}, -- Cheapshot
				[3409] = {["frame"] = "Target_Debuff"}, -- Crippling poison
				[13218] = {["frame"] = "Target_Debuff"}, -- Wound poison
			},
			["HELPFUL"] = {},
		},
		["pet"] = {
			["HARMFUL"] = {},
			["HELPFUL"] = {
			},
		},
	}
end

local OzAuras = {}

local filterTypes = {}


OzAuras["frame"] = CreateFrame("Frame","OzAuras",UIParent)
OzAuras["config"]  = {
	["defaultFrontEnd"] = "OzIcons",
	["useWhitelist"] = false
}

OzAuras["foundBuffs"] = {}

function OzAuras:Init()
	self.defaultFrontEnd = _G[self.config.defaultFrontEnd]

	OzAuras["frame"]:SetWidth(32)
	OzAuras["frame"]:SetHeight(32)
	OzAuras["frame"]:SetPoint("CENTER",UIParent,"CENTER",0,0)		

	OzAuras:Enable()
end

function OzAuras:LoadClassAuaras()
	self.class = class
	self.activeAuras = {}	
	self.inactiveAuras = {}

	for target, filters in pairs(auras["DEFAULT"]) do
		if (not filterTypes[target]) then
			filterTypes[target] = {}
		end
		for filter,spells in pairs(filters) do
			if (not filterTypes[target][filter]) then
				filterTypes[target][filter] = filter
			end
		end
	end

	if auras[self.class] then
		for target, filters in pairs(auras[self.class]) do
			if (not filterTypes[target]) then
				filterTypes[target] = {}
			end
			if (not auras["DEFAULT"][target]) then
				auras["DEFAULT"][target] = {}
			end
			for filter,spells in pairs(filters) do
				if (not filterTypes[target][filter]) then
					filterTypes[target][filter] = filter
				end
				if (not auras["DEFAULT"][target][filter]) then
					auras["DEFAULT"][target][filter] = {}
				end
				for spellId, auraInfo in pairs  (spells) do
					auras["DEFAULT"][target][filter][spellId] = auraInfo
				end
			end
		end
	end
end

function OzAuras:Enable()
    OzAuras["frame"]:RegisterEvent( "UNIT_AURA" )
    OzAuras["frame"]:RegisterEvent( "PLAYER_ENTERING_WORLD" )
    OzAuras["frame"]:RegisterEvent( "PLAYER_TARGET_CHANGED" )
    OzAuras["frame"]:RegisterEvent( "PLAYER_FOCUS_CHANGED" )
	OzAuras["frame"]:SetScript("OnEvent", function(self, event, ...)
		OzAuras["frame"][event](self, event, ...); -- call one of the functions above
	end);

	self:LoadClassAuaras()

end

function OzAuras.frame:PLAYER_ENTERING_WORLD(event)
	OzAuras["frame"]:UNIT_AURA("UNIT_AURA","player")

end

function OzAuras.frame:PLAYER_TARGET_CHANGED(event)
	OzAuras["frame"]:UNIT_AURA("UNIT_AURA","target")

end

function OzAuras.frame:PLAYER_FOCUS_CHANGED(event)
	OzAuras["frame"]:UNIT_AURA("UNIT_AURA","focus")

end


function OzAuras.frame:UNIT_AURA(event, unitId)
	if (unitId ~= "player" and unitId ~= "target" and unitId ~= "pet" and unitId ~= "focus") then
		return
	end
	local class = select(2,UnitClass(unitId))
	local buffs = {}
	for j,filter in pairs(filterTypes[unitId]) do
		if (not buffs[filter]) then
			buffs[filter] = {}
		end
		for i=1,40 do
			local name,_,icon,count,debuffType,duration,expirationTime,source,isStealable,shouldConsolidate,spellId = UnitAura(unitId,i,filter) 
			if (spellId) then
				buffs[filter][spellId] = {["duration"] = duration, ["expire"] = expirationTime, ["count"] = count}
				--
				if not OzAuras.foundBuffs[spellId] then
					OzAuras.foundBuffs[spellId] = name
					--print("|cFF00FFFFOzAuras|r : |cFF00FFFF"..spellId.."|r "..filter.."("..class..")->".. name.." -> duration ("..duration..")")
					--print(icon)
				end
			else
				break
			end
		end
	end
	for j,filter in pairs(filterTypes[unitId]) do
		--print(unitId..filter)
		for spellId, auraInfo in pairs  (auras["DEFAULT"][unitId][filter]) do
			if (buffs[filter][spellId]) then
				if (not auraInfo.started) then
					OzAuras:AuraStart(unitId, filter, spellId, buffs[filter][spellId].duration,buffs[filter][spellId].expire, buffs[filter][spellId].count)
					auras["DEFAULT"][unitId][filter][spellId].started = true
				else
					OzAuras:AuraStart(unitId, filter, spellId, buffs[filter][spellId].duration,buffs[filter][spellId].expire, buffs[filter][spellId].count)

				end
			else
				if (auras["DEFAULT"][unitId][filter][spellId].started) then
					OzAuras:AuraStop(unitId, filter, spellId)
					auras["DEFAULT"][unitId][filter][spellId].started = false
				end
			end
		end
	end
end



function OzAuras:AuraStart (unitId, filter, spellId, duration, expire, count)
	--print(spellId.." "..expire)
	local name, rank, icon, cost, isFunnyl, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId)
	local aura = auras["DEFAULT"][unitId][filter][spellId]
	local containerFrameName = aura.frame
	if (aura.frontEnds) then
		for k,frontEnd in pairs(aura.frontEnds) do
			_G[frontEnd.name]:Create(containerFrameName,"spell"..spellId,icon,name, count,duration,expire, frontEnd.arg)
		end
		if aura.internalCd and not aura.internalCDStarted then
			_G[frontEnd]:Create("cooldown","spell-internal"..spellId,icon,name, 0,0,GetTime()+aura.internalCd, frontEnd.arg)
			local animation = OzAuras["frame"]:CreateAnimationGroup()
			local scaleIn = animation:CreateAnimation("Scale")
			scaleIn:SetScale(1, 1)
			scaleIn:SetDuration(aura.internalCd)
			scaleIn:SetOrder(1)
			animation:SetScript("OnFinished",function (animationGroup)
				aura.internalCDStarted = false
				_G[frontEnd]:Hide("cooldown","spell-internal"..spellId)
			end)
			animation:Play()
			aura.internalCDStarted = true
		end
	else
		self.defaultFrontEnd:Create(containerFrameName,"spell"..spellId,icon,name, count,duration,expire)
		if aura.internalCd and not aura.internalCDStarted then
			self.defaultFrontEnd:Create("cooldown","spell-internal"..spellId,icon,name, 0,0,GetTime()+aura.internalCd)
			local animation = OzAuras["frame"]:CreateAnimationGroup()
			local scaleIn = animation:CreateAnimation("Scale")
			scaleIn:SetScale(1, 1)
			scaleIn:SetDuration(aura.internalCd)
			scaleIn:SetOrder(1)
			animation:SetScript("OnFinished",function (animationGroup)
				aura.internalCDStarted = false
				OzAuras.defaultFrontEnd:Hide("cooldown","spell-internal"..spellId)
			end)
			animation:Play()
			aura.internalCDStarted = true
		end
	end
end


function OzAuras:AuraStop(unitId, filter, spellId)
	local aura = auras["DEFAULT"][unitId][filter][spellId]
	local containerFrameName = aura.frame
	if (aura.frontEnds) then
		for k,frontEnd in pairs(aura.frontEnds) do
			_G[frontEnd.name]:Hide(containerFrameName,"spell"..spellId)
		end
	else
		self.defaultFrontEnd:Hide(containerFrameName,"spell"..spellId)	
	end
end

OzAuras:Init()

