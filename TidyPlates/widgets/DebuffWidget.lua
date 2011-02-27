
--[[
To Do List: 

Spell Priority 
		for spellid, priority in pairs(AuraPriorities) do
			for index = 1, 8 do
				if priority > (AuraSlotPriority[index] or 0 ) then
					tinsert(AuraSlotPriority, index, priority)
					tinsert(AuraSlotspellid, index, spellid)
					break
				end
			end
		end
		
		TidyPlates:RequestDelegateUpdate()		-- Delegate Update

--]]

local PlayerGUID = UnitGUID("player")
local PolledHideIn = TidyPlatesWidgets.PolledHideIn
local FilterFunction = function() return 1 end
local AuraMonitor = CreateFrame("Frame")
local WatcherIsEnabled = false
local WidgetList, WidgetGUID = {}, {}
local UpdateWidget
local TargetOfGroupMembers = {}

local function SetFilter(func)
	if func and type(func) == "function" then
		FilterFunction = func
	end
end

local function GetAuraWidgetByGUID(guid)
	if guid then return WidgetGUID[guid] end
end

local function IsAuraShown(widget, aura)
	--if aura and type(aura) == 'table' then	
	--elseif aura then
	--else
		if widget and widget.IsShown then 
			for i = 1, 6 do
				if widget.AuraIconFrames[i] and widget.AuraIconFrames[i]:IsShown() then return true end
			end
		end
	--end
end

-- Raid Icon BIT Reference
local RaidIconBit = {
	["STAR"] = 0x00100000,
	["CIRCLE"] = 0x00200000,
	["DIAMOND"] = 0x00400000,
	["TRIANGLE"] = 0x00800000,
	["MOON"] = 0x01000000,
	["SQUARE"] = 0x02000000,
	["CROSS"] = 0x04000000,
	["SKULL"] = 0x08000000,
}

local RaidIconIndex = {
	"STAR",
	"CIRCLE",
	"DIAMOND",
	"TRIANGLE",
	"MOON",
	"SQUARE",
	"CROSS",
	"SKULL",
}

local ByRaidIcon = {}			-- Raid Icon to GUID 		-- ex.  ByRaidIcon["SKULL"] = GUID
local ByName = {}				-- Name to GUID (PVP)


-----------------------------------------------------
-- Default Filter
-----------------------------------------------------
local function DefaultFilterFunction(debuff) 
	if (debuff.duration < 600) then
		return true
	end
end

-----------------------------------------------------
-- Update Via Search
-----------------------------------------------------

local function FindWidgetByGUID(guid)
	return WidgetGUID[guid]
end

local function FindWidgetByName(name)
	local widget
	for widget in pairs(WidgetList) do
		if widget.unit.name == name then return widget end
	end
end

local function FindWidgetByIcon(raidicon)
	local widget
	for widget in pairs(WidgetList) do
		if widget.unit.isMarked and widget.unit.raidIcon == raidicon then return widget end
	end
end

local function CallForWidgetUpdate(guid, raidicon, name)
	local widget

	if guid then widget = FindWidgetByGUID(guid) end
	if (not widget) and name then widget = FindWidgetByName(name) end
	if (not widget) and raidicon then widget = FindWidgetByIcon(raidicon) end
	
	if widget then UpdateWidget(widget) end
end


-----------------------------------------------------
-- Aura Durations
-----------------------------------------------------
TidyPlatesData.CachedAuraDurations = {}

-- /run for i, v in pairs(TidyPlatesData.CachedAuraDurations) do print(i,v) end
local function GetSpellDuration(spellid)
	if spellid then return TidyPlatesData.CachedAuraDurations[spellid] end
end

local function SetSpellDuration(spellid, duration)
	if spellid then TidyPlatesData.CachedAuraDurations[spellid] = duration end
end

-----------------------------------------------------
-- Aura Instances
-----------------------------------------------------
local AuraInstances = {}
AuraInstances.ExpirationTimes = {}
AuraInstances.Stacks = {}
AuraInstances.Caster = {}
AuraInstances.Duration = {}

local function GetAuraList(guid)
	if guid then
		return AuraInstances.ExpirationTimes[guid]
	end
end

local function GetAuraInstance(guid, spellid)
	if guid and spellid then
		if AuraInstances.ExpirationTimes[guid] then
			local expiration, stacks, caster, duration
			expiration = AuraInstances.ExpirationTimes[guid][spellid]
			stacks = AuraInstances.Stacks[guid][spellid]
			caster = AuraInstances.Caster[guid][spellid]
			duration = AuraInstances.Duration[guid][spellid]
			return expiration, stacks, caster, duration
		end
	end
end

local function SetAuraInstance(guid, spellid, expiration, stacks, caster, duration)
	 -- testing
	 --if spellid == 81500 then return end
	 --print(spellid, expiration, stacks, caster, duration)
	 
	if guid and spellid then
		-- Check guid
		AuraInstances.ExpirationTimes[guid] = AuraInstances.ExpirationTimes[guid] or {}
		AuraInstances.Stacks[guid] = AuraInstances.Stacks[guid] or {}
		AuraInstances.Caster[guid] = AuraInstances.Caster[guid] or {}
		AuraInstances.Duration[guid] = AuraInstances.Duration[guid] or {}
		-- Set Values
		AuraInstances.ExpirationTimes[guid][spellid] = expiration
		AuraInstances.Stacks[guid][spellid] = stacks
		AuraInstances.Caster[guid][spellid] = caster
		AuraInstances.Duration[guid][spellid] = duration
	end
end

-----------------------------------------------------
-- Aura Updating Via UnitID
-----------------------------------------------------

local function UpdateAurasByUnitID(unitid)

		-- Limit to enemies, for now
		if UnitIsFriend("player", unitid) then return end
		
		-- Check the UnitIDs Debuffs
		local index
		local guid = UnitGUID(unitid)
		for index = 1, 40 do
			local name , _, _, count, debuffType, duration, expirationTime, unitCaster, _, _, spellid = UnitDebuff(unitid, index)
			if not name then break end
			-- Cache duration for future use
			SetSpellDuration(spellid, duration)
			-- Add aura to unit
			SetAuraInstance(guid, spellid, expirationTime, count, UnitGUID(unitCaster or ""), duration)
		end	

		local raidicon, name
		if UnitPlayerControlled(unitid) then name = UnitName(unitid) end
		raidicon = RaidIconIndex[GetRaidTargetIndex(unitid) or ""]
		if raidicon then ByRaidIcon[raidicon] = guid end
		
		CallForWidgetUpdate(guid, raidicon, name)
 end
 
 local function UpdateAuraByLookup(guid)
 	if guid == UnitGUID("target") then
		UpdateAurasByUnitID("target")
		-- return true
	elseif guid == UnitGUID("mouseover") then
		UpdateAurasByUnitID("mouseover")
		-- return true
	elseif TargetOfGroupMembers[guid] then
		local unit = TargetOfGroupMembers[guid]
		if unit then
			local unittarget = UnitGUID(unit.."target")
			if guid == unittarget then
				UpdateAurasByUnitID(unittarget)
				-- return true
			end
		end		
	end
	return false
 end
 
-----------------------------------------------------
-- Aura Updating Via Combat Log
-- local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellName, spellSchool, auraType, stackCount = ...
-----------------------------------------------------

local function CombatLog_ApplyAura(...)
	local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid = ...
	local duration = GetSpellDuration(spellid)
	SetAuraInstance(destGUID, spellid, GetTime() + (duration or 0), 1, sourceGUID, duration)
end

local function CombatLog_RemoveAura(...) 
	local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid = ...
	SetAuraInstance(destGUID, spellid)
end

local function CombatLog_UpdateAuraStacks(...) 
	local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, _, _, _, stackCount = ...
	local duration = GetSpellDuration(spellid)
	SetAuraInstance(destGUID, spellid, GetTime() + (duration or 0), stackCount, sourceGUID, duration)
end

-----------------------------------------------------
-- General Events
-----------------------------------------------------

local function EventUnitTarget()
	wipe(TargetOfGroupMembers)
	
	for name, unitid in pairs(TidyPlatesUtility.GroupMembers.UnitId) do
		local targetOf = unitid..("target" or "")
		if UnitExists(targetOf) then
			TargetOfGroupMembers[UnitGUID(targetOf)] = targetOf
		end
	end
end

local function EventPlayerTarget()	
	if UnitExists("target") then
		UpdateAurasByUnitID("target")
	end
end

local function EventUnitAura(unitid)
	if unitid == "target" then
		UpdateAurasByUnitID("target")
		-- call update - To do:
	elseif unitid == "focus" then
		UpdateAurasByUnitID("focus")
		-- call update 
	end
end

--[[
-- "REGEN_ENABLED" --
local function EventRegenEnabled()

end

-- "REGEN_DISABLED" --
local function EventRegenDisabledt()

end
--]]

-----------------------------------------------------
-- Function Reference Lists
-----------------------------------------------------
local CombatLogEvents = {
	-- Refresh Expire Time
	["SPELL_AURA_APPLIED"] = CombatLog_ApplyAura,
	["SPELL_AURA_REFRESH"] = CombatLog_ApplyAura,
	-- Add a stack
	["SPELL_AURA_APPLIED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Remove a stack
	["SPELL_AURA_REMOVED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Expires Aura
	["SPELL_AURA_BROKEN"] = CombatLog_RemoveAura,
	["SPELL_AURA_BROKEN_SPELL"] = CombatLog_RemoveAura,
	["SPELL_AURA_REMOVED"] = CombatLog_RemoveAura,
}

local GeneralEvents = {
	["UNIT_TARGET"] = EventUnitTarget,
	--["PLAYER_TARGET"] = EventPlayerTarget,
	["UNIT_AURA"] = EventUnitAura,
}

local function CombatEventHandler(frame, event, ...)
	local timestamp, combatevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...

	-- General Events, Passthrough
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then 
		if GeneralEvents[event] then GeneralEvents[event](...) end 
		return
	end
	
	-- Evaluate only for enemy units, for now
	if (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) then
		local CombatLogUpdateFunction = CombatLogEvents[combatevent]
		-- Evaluate only for certain combat log events
		if CombatLogUpdateFunction  then 
			local auraType = select(12, ...)
			-- Evaluate only for debuffs
			if auraType == "DEBUFF" then 
				-- Update Auras via API/UnitID Search
				if not UpdateAuraByLookup(destGUID) then
				-- Update Auras via Combat Log		
					CombatLogUpdateFunction(select(3, ...)) 
				end
				
				-- To Do: Need to write something to detect when a change was made to the destID
				-- Return values on functions?
				
				local name, raidicon
				-- Cache Unit Name for alternative lookup strategy
				if bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then 
					ByName[destName] = destGUID
					name = destName
				end
				-- Cache Raid Icon Data for alternative lookup strategy
				for iconname, bitmask in pairs(RaidIconBit) do
					if bit.band(destFlags, bitmask) > 0  then
						ByRaidIcon[iconname] = destGUID
						raidicon = iconname
						break
					end
				end
				
				CallForWidgetUpdate(destGUID, raidicon, name)
			end
		end
	end
end

-------------------------------------------------------------
-- Widget Object Functions
-------------------------------------------------------------
local function DefaultFilterFunction(debuff, unit) 
	if (debuff.duration < auraDurationFilter) then
		return true
	end
end

local function UpdateWidgetTime(frame, expiration)
	local timeleft = ceil(expiration-GetTime())
	if timeleft > 60 then 
		frame.TimeLeft:SetText(ceil(timeleft/60).."m")
	else
		frame.TimeLeft:SetText(ceil(timeleft))
	end
end


local function UpdateIcon(frame, aura, expiration, stacks)
	if frame and aura and expiration then
		--local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo(aura)
		local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo(aura)
		
		-- Icon
		frame.Icon:SetTexture(icon)
		
		-- Stacks
		if stacks > 1 then frame.Stacks:SetText(stacks)
		else frame.Stacks:SetText("") end
		
		-- Expiration
		UpdateWidgetTime(frame, expiration)
		frame:Show()
		PolledHideIn(frame, expiration)
	else 
	--elseif frame then 
		frame:Hide()
		PolledHideIn(frame, 0)
	end
end

local AuraSlotspellid = {} 	-- auraSlot[slot] = spellid
local AuraSlotPriority = {} 	-- auraSlot[slot] = priority
local CurrentDebuff = {}

function UpdateWidget(frame)
		-- Check for ID
		local unit = frame.unit
		local guid = unit.guid
		
		if not guid then
			-- Attempt to ID widget via Name or Raid Icon
			if unit.type == "PLAYER" then guid = ByName[unit.name]
			elseif unit.isMarked then guid = ByRaidIcon[unit.raidIcon] end
			
			if guid then 
				unit.guid = guid	-- Feed data back into unit table		-- Testing
			else
				frame:Hide()
				return
			end
		end
		
		local AuraIconFrames = frame.AuraIconFrames
		local AurasOnUnit = GetAuraList(guid)
		local AuraSlotIndex = 1

		-- Set Auras to Available Slots
		if AurasOnUnit then
			frame:Show()
			local spellid, expiration, stacks, caster, duration
			for spellid, expiration in pairs(AurasOnUnit) do
				expiration, stacks, caster, duration = GetAuraInstance(guid, spellid)
				
				CurrentDebuff.name = GetSpellInfo(spellid)
				CurrentDebuff.spellid = spellid
				CurrentDebuff.stacks = stacks
				CurrentDebuff.duration = duration
				CurrentDebuff.caster = caster

				if frame.Filter(CurrentDebuff, unit) and expiration > GetTime() then
					UpdateIcon(AuraIconFrames[AuraSlotIndex], spellid, expiration, stacks) 
					AuraSlotIndex = AuraSlotIndex + 1
					if AuraSlotIndex > 8 then break end
				end
			end
		end
		
		-- Clear Extra Slots
		for AuraSlotIndex = AuraSlotIndex, 8 do UpdateIcon(AuraIconFrames[AuraSlotIndex]) end
		
		TidyPlates:RequestDelegateUpdate()		-- Delegate Update, For Debuff Widget-Controlled Scale and Opacity Functions
end

-- Context Update (mouseover, target change)
local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid
	frame.unit = unit
	frame.guidcache = guid
	
	WidgetList[frame] = true
	if guid then WidgetGUID[guid] = frame end
	
	if unit.isTarget then UpdateAurasByUnitID("target")
	elseif unit.isMouseover then UpdateAurasByUnitID("mouseover") end
	
	local raidicon, name
	if unit.isMarked then
		raidicon = unit.raidIcon
		if guid then ByRaidIcon[raidicon] = guid end
	end
	if unit.type == "PLAYER" and unit.reaction == "HOSTILE" then name = unit.name end
	
	CallForWidgetUpdate(guid, raidicon, name)
end

local function ClearWidgetContext(frame)
	if frame.guidcache then 
		WidgetGUID[frame.guidcache] = nil 
		frame.unit = nil
	end
	WidgetList[frame] = nil
	
end

-------------------------------------------------------------
-- Widget Frames
-------------------------------------------------------------
local AuraBorderArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraFrame"				-- FINISH ART
local AuraGlowArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraGlow"	
local AuraTestArt = ""
local AuraFont = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"

local function Enable()
	AuraMonitor:SetScript("OnEvent", CombatEventHandler)
	AuraMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	AuraMonitor:RegisterEvent("UNIT_TARGET")
	AuraMonitor:RegisterEvent("UNIT_AURA")
	--AuraMonitor:RegisterEvent("PLAYER_TARGET")

	TidyPlatesUtility:EnableGroupWatcher()
	WatcherIsEnabled = true
	
	if not TidyPlatesData.CachedAuraDurations then
		TidyPlatesData.CachedAuraDurations = {}
	end
	
end

local function Disable() 
	AuraMonitor:SetScript("OnEvent", nil)
	AuraMonitor:UnregisterAllEvents()
	TidyPlatesUtility:DisableGroupWatcher()
	WatcherIsEnabled = false
end

-- Create an Aura Icon
local function CreateAuraIconFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(26); frame:SetHeight(14)
	-- Icon
	frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
	frame.Icon:SetAllPoints(frame)
	--frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
	frame.Border = frame:CreateTexture(nil, "ARTWORK")
	frame.Border:SetWidth(32); frame.Border:SetHeight(32)
	frame.Border:SetPoint("CENTER", 1, -2)
	frame.Border:SetTexture(AuraBorderArt)
	-- Glow
	--frame.Glow = frame:CreateTexture(nil, "ARTWORK")
	--frame.Glow:SetAllPoints(frame.Border)
	--frame.Glow:SetTexture(AuraGlowArt)
	--  Time Text
	frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
	frame.TimeLeft:SetFont(AuraFont ,9, "OUTLINE")
	frame.TimeLeft:SetShadowOffset(1, -1)
	frame.TimeLeft:SetShadowColor(0,0,0,1)
	frame.TimeLeft:SetPoint("RIGHT", 0, 8)
	frame.TimeLeft:SetWidth(26)
	frame.TimeLeft:SetHeight(16)
	frame.TimeLeft:SetJustifyH("RIGHT")
	--  Stacks
	frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
	frame.Stacks:SetFont(AuraFont,10, "OUTLINE")
	frame.Stacks:SetShadowOffset(1, -1)
	frame.Stacks:SetShadowColor(0,0,0,1)
	frame.Stacks:SetPoint("RIGHT", 0, -6)
	frame.Stacks:SetWidth(26)
	frame.Stacks:SetHeight(16)
	frame.Stacks:SetJustifyH("RIGHT")
	-- Information about the currently displayed aura
	frame.AuraInfo = {	
		Name = "",
		Icon = "",
		Stacks = 0,
		Expiration = 0,
		Type = "",
	}		
	frame.Poll = UpdateWidgetTime
	frame:Hide()
	return frame
end

-- Create the Main Widget Body and Icon Array
local function CreateAuraWidget(parent)
	--if not WatcherIsEnabled then Enable() end
	-- Create Base frame
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(128); frame:SetHeight(32); frame:Show()
	-- Create Icon Array
	frame.AuraIconFrames = {}
	local AuraIconFrames = frame.AuraIconFrames
	for index = 1, 8 do AuraIconFrames[index] = CreateAuraIconFrame(frame);  end
	-- Set Anchors	
	AuraIconFrames[1]:SetPoint("LEFT", frame)
	for index = 2, 3 do AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index-1], "RIGHT", 5, 0) end
	AuraIconFrames[4]:SetPoint("BOTTOMLEFT", AuraIconFrames[1], "TOPLEFT", 0, 8)
	for index = 5, 6 do AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index-1], "RIGHT", 5, 0) end
	-- Functions
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end
	frame:SetScript("OnHide", function() for index = 1, 4 do PolledHideIn(AuraIconFrames[index], 0) end end)	
	frame.Filter = DefaultFilterFunction
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetContext
	return frame
end

-----------------------------------------------------
-- External
-----------------------------------------------------
TidyPlatesWidgets.GetAuraWidgetByGUID = GetAuraWidgetByGUID
TidyPlatesWidgets.IsAuraShown = IsAuraShown

TidyPlatesWidgets.CreateAuraWidget = CreateAuraWidget
TidyPlatesWidgets.EnableAuraWatcher = Enable
TidyPlatesWidgets.DisableAuraWatcher = Disable

-----------------------------------------------------
-- Debuff Library
-----------------------------------------------------
--[[
	-- Druid
	SetSpellDuration(8921, 12)	-- Moonfire
	SetSpellDuration(1822, 9)	-- Rake
	SetSpellDuration(33876, 60)	-- Mangle

	-- Deathknight
	-- Hunter
	-- Mage
	-- Paladin
	-- Priest
	-- Rogue
	-- Shaman
	-- Warlock
	-- Warrior
--]]


























