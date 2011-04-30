local LBI = LibStub("LibBossIDs-1.0")

local frame = _G.BattleStandardReminder or CreateFrame("Frame")
_G.BattleStandardReminder = frame

local GetTime=GetTime
local UnitGUID=UnitGUID
local UnitHealth,UnitHealthMax=UnitHealth,UnitHealthMax
local UnitExists,UnitIsTappedByPlayer=UnitExists,UnitIsTappedByPlayer
local tonumber = tonumber
local pairs = pairs
local wipe = wipe

local guids = setmetatable({}, {
      __index = function(self, key)
         local guid = tonumber(key:sub(-13, -9), 16) or 0
         self[key]=LBI.BossIDs[guid or 0] or false         
         return self[key]
      end
})

local lastWarn = 0

local function check(unit)
	if UnitIsTappedByPlayer(unit) then
		if guids[UnitGUID(unit)] then
			-- yes!
		else
			return	-- nope
		end
	else
		return	-- nope
	end

	local health = UnitHealth(unit) / UnitHealthMax(unit)
	if health < 0.2 and health > 0.01 then -- Menos de 20% e mais de 1%
		
		if GetTime()>lastWarn+120 then

			-- GLOBALS: print, format, UnitName, UnitIsInMyGuild, UnitIsPartyLeader, SendChatMessage		
			local msg = format("Place the Guild Standart : %s is at %.0f%%", UnitName(unit), 
				UnitHealth(unit) / UnitHealthMax(unit) * 100
			)
			
			SendChatMessage(msg, "party")
			SendChatMessage(msg, "raid")
			lastWarn=GetTime()

		end
	  
	end


end

function frame:UNIT_HEALTH(event,unit)
   return check(unit)
end

function frame:UNIT_TARGET(event,srcunit)
   local unit = srcunit.."target"
   if UnitExists(unit) then
      return check(unit)
   end
end

function frame:ZONE_CHANGED(event)
   wipe(guids)
end



frame:SetScript("OnEvent", function(self,event,...)
      return self[event](self,event,...)
   end
)

frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("UNIT_TARGET")
frame:RegisterEvent("ZONE_CHANGED")
