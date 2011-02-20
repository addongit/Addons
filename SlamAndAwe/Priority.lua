-- @release $Id: Priority.lua 19 2011-02-11 22:08:07Z reighnman $

if not SlamAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local LBF = LibStub("LibButtonFacade", true)
local LBFgroup = nil
local _, _, _, clientVersion = GetBuildInfo()

--if LBF then
--	local LBFgroup = LBF:Group("SlamAndAwe")
--end
SlamAndAwe.PriorityFrame = CreateFrame("Button", "SAA_PriorityFrame", UIParent)
SlamAndAwe.PriorityFrame.cooldown = CreateFrame("Cooldown", "SAA_PriorityFrameCooldown", SlamAndAwe.PriorityFrame)

---------------------------
-- Local Variables
---------------------------

SlamAndAwe.priorityTable = {}
SlamAndAwe.priorityTable.name = {}
SlamAndAwe.priorityTable.icon = {}
SlamAndAwe.priorityTable.test = {}

--------------------------
--  Helper Functions
--------------------------
-- returns : true if spellname is available in less than priority.cooldown
--                 or if spellname is currently activated
--           , remaining cooldown, 0 if ready to be cast
function SlamAndAwe:SpellAvailable(spellname)
	if SlamAndAwe.db.char.priority.hideImmune and self:IsTargetImmune(spellname) then
		return false
	end
	local start, duration = GetSpellCooldown(spellname)
	if start then
		local timeleft = start + duration - GetTime()
		return timeleft <= SlamAndAwe.db.char.priority.cooldown, duration, timeleft
	end
	return false, 999
end

function SlamAndAwe:GCDAvailable()
	local startTime, gcdDuration = GetSpellCooldown(SlamAndAwe.constants["Demoralizing Shout"])
	local gcdTime = startTime + gcdDuration - GetTime()
	return gcdTime <= SlamAndAwe.db.char.priority.cooldown 
end

function SlamAndAwe:GetDebuffInfo(debuff)
	local index = 1
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, debuffExpires, unitCaster = UnitDebuff("target", index)
		local isMine = unitCaster == "player" 
		if name == debuff and isMine then 
			local duration = debuffExpires - GetTime()
			return duration > SlamAndAwe.db.char.priority.cooldown, duration, count, debuffExpires
		end
		index = index + 1
	end
	return false, 0, 0, 0
end

function SlamAndAwe:GetBuffInfo(buff)
	local index = 1
	while UnitBuff("player", index) do
		local name, _, _, count, _, _, buffExpires = UnitBuff("player", index)
		if name == buff then 
			local duration = buffExpires - GetTime()
			return duration > SlamAndAwe.db.char.priority.cooldown, duration, count
		end
		index = index + 1
	end
	return false, 0, 0
end

function SlamAndAwe:IsTargetImmune(spell)
	target = UnitName("target") or ""
	if spell and SlamAndAwe.db.char.immuneTargets[target.."_"..spell] then
		return true
	end
	return false
end

function SlamAndAwe:FireTotemNeeded(spell)
	if SlamAndAwe:GCDAvailable() then
		-- only bother checking for totem availabilty if we have a GCD
		local _, totemname, start, duration = GetTotemInfo(1)
		if totemname == nil or totemname == "" then -- no fire totem deployed so recommend it be dropped
			return true
		end
		if start and strmatch(totemname, spell) then
			local timeleft = start + duration - GetTime()
			return timeleft <= SlamAndAwe.db.char.priority.cooldown, duration
		end
	end
	return false, 999
end

------------------
-- Priorities
------------------

function SlamAndAwe:SetPriorityTable()
		SlamAndAwe.priorityTable.name["none"] = L["None"]
	_, _, SlamAndAwe.priorityTable.icon["none"] = "Interface/Tooltips/UI-Tooltip-Background"
	SlamAndAwe.priorityTable.test["none"] = function () return false end
end

--SlamAndAwe

	SlamAndAwe.priorityTable.name["cs"] = SlamAndAwe.constants["Colossus Smash"]
	SlamAndAwe.priorityTable.icon["cs"] = SlamAndAwe.constants["Colossus Smash Icon"]
	SlamAndAwe.priorityTable.test["cs"] =  
			function () 	
        local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Colossus Smash"]);     
        if usable then
          return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Colossus Smash"])     
        end
      end     
     
	SlamAndAwe.priorityTable.name["bt"] = SlamAndAwe.constants["Bloodthirst"]
	SlamAndAwe.priorityTable.icon["bt"] = SlamAndAwe.constants["Bloodthirst Icon"]
	SlamAndAwe.priorityTable.test["bt"] =  
			function () 	
        local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Bloodthirst"]);
        
        if usable then
          return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Bloodthirst"])     
        end
      end
		
	SlamAndAwe.priorityTable.name["rb"] = SlamAndAwe.constants["Raging Blow"]
	SlamAndAwe.priorityTable.icon["rb"] = SlamAndAwe.constants["Raging Blow Icon"]
	SlamAndAwe.priorityTable.test["rb"] =  
			function () 	
        local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Raging Blow"]);
        
        if usable then
          return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Raging Blow"])     
        end
      end
      
	SlamAndAwe.priorityTable.name["sl"] = SlamAndAwe.constants["Slam"]
	SlamAndAwe.priorityTable.icon["sl"] = SlamAndAwe.constants["Slam Icon"]
	SlamAndAwe.priorityTable.test["sl"] =  
			function () 	
        local slusable, slnomana = IsUsableSpell(SlamAndAwe.constants["Slam"]);
        if slusable then
           return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Slam"])
        end
      end
      
	SlamAndAwe.priorityTable.name["bs"] = SlamAndAwe.constants["Bloodsurge"]
	SlamAndAwe.priorityTable.icon["bs"] = SlamAndAwe.constants["Slam Icon"]
	SlamAndAwe.priorityTable.test["bs"] =  
			function ()
					local bsbuff = SlamAndAwe:GetBuffInfo(SlamAndAwe.constants["Bloodsurge"])
				
          if bsbuff == true then
            local bsusable, bsnomana = IsUsableSpell(SlamAndAwe.constants["Slam"]);
            if bsusable then
              return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Slam"])
            end
          end
      end
      
  SlamAndAwe.priorityTable.name["dw"] = SlamAndAwe.constants["Death Wish"]
	SlamAndAwe.priorityTable.icon["dw"] = SlamAndAwe.constants["Death Wish Icon"]
	SlamAndAwe.priorityTable.test["dw"] =  
			function () 	
       local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Death Wish"]);
       if usable then
           return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Death Wish"])
       end
      end
      
  SlamAndAwe.priorityTable.name["ex"] = SlamAndAwe.constants["Execute"]
	SlamAndAwe.priorityTable.icon["ex"] = SlamAndAwe.constants["Execute Icon"]
	SlamAndAwe.priorityTable.test["ex"] =  
			function () 	
       local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Execute"]);
       if usable then
           return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Execute"])
       end
      end
      
  SlamAndAwe.priorityTable.name["ex5"] = "Executioner x5"
	SlamAndAwe.priorityTable.icon["ex5"] = SlamAndAwe.constants["Execute Icon"]
	SlamAndAwe.priorityTable.test["ex5"] =  
			function () 	
       local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Execute"]);
       if usable then
          local executionerPresent, duration, count =  SlamAndAwe:GetBuffInfo(SlamAndAwe.constants["Executioner"])
           if count < 5 or duration < 4 then
               return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Execute"])
           end
       end
      end
      
  SlamAndAwe.priorityTable.name["br"] = SlamAndAwe.constants["Berserker Rage"]
	SlamAndAwe.priorityTable.icon["br"] = SlamAndAwe.constants["Berserker Rage Icon"]
	SlamAndAwe.priorityTable.test["br"] =  
			function () 	
        local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Berserker Rage"]);
        if usable then
           --Check for enrage
           local buff1 = SlamAndAwe:GetBuffInfo(SlamAndAwe.constants["Enrage"])
           local buff2 = SlamAndAwe:GetBuffInfo(SlamAndAwe.constants["Death Wish"])
           if not (buff1 or buff2) then
              return SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Berserker Rage"])
           end
        end
      end   

-------------------------------
-- Priority Frame functions
-------------------------------

function SlamAndAwe:SetPriorityBackdrop(icon)
--	self.PriorityFrame.Icon:SetTexture(icon)
	self.PriorityFrame:SetBackdrop({ bgFile = icon,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
end

function SlamAndAwe:CreatePriorityFrame()
	self.updatePriority = false
	self.PriorityFrame:SetScale(SlamAndAwe.db.char.priority.scale)
	self.PriorityFrame:SetFrameStrata("BACKGROUND")
	self.PriorityFrame:SetWidth(SlamAndAwe.db.char.priority.fWidth)
	self.PriorityFrame:SetHeight(SlamAndAwe.db.char.priority.fHeight)
	self.PriorityFrame.Icon = _G["SAA_PriorityFrameIcon"]
	self:SetPriorityBackdrop("Interface/Tooltips/UI-Tooltip-Background")
	self.PriorityFrame:SetBackdropColor(0, 0, 0, SlamAndAwe.db.char.priority.alpha);
	self.PriorityFrame:SetMovable(true);
	self.PriorityFrame:RegisterForDrag("LeftButton");
	self.PriorityFrame:EnableMouse(false)
	self.PriorityFrame:SetPoint(SlamAndAwe.db.char.priority.point, SlamAndAwe.db.char.priority.relativeTo, SlamAndAwe.db.char.priority.relativePoint, SlamAndAwe.db.char.priority.xOffset, SlamAndAwe.db.char.priority.yOffset)
	self.PriorityFrame:SetScript("OnDragStart", 
		function()
			self.PriorityFrame:StartMoving();
		end );
	self.PriorityFrame:SetScript("OnDragStop",
		function()
			self.PriorityFrame:StopMovingOrSizing();
			self.PriorityFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(SlamAndAwe.db.char.priority, self.PriorityFrame);
		end );
	self:SetPriorityUpdateScript()
	if not self.PriorityFrame.topText then
		self.PriorityFrame.topText = self.PriorityFrame:CreateFontString(nil, "OVERLAY")
	end
	self.PriorityFrame.topText:SetTextColor(1,1,1,1)
	self.PriorityFrame.topText:SetFont(media:Fetch("font", SlamAndAwe.db.char.barfont), SlamAndAwe.db.char.barfontsize)
	self.PriorityFrame.topText:SetPoint("TOP", self.PriorityFrame, "TOP", 0, SlamAndAwe.db.char.barfontsize + 2)
	self.PriorityFrame.topText:SetText(string.format(L["Next Priority (Set %s)"], SlamAndAwe.db.char.priority.groupnumber))
	self.PriorityFrame.cooldown:SetAllPoints(self.PriorityFrame)
	self:CreateComboPointFrames()
	self:CreateInterruptPurgeFrames()
	
	if SlamAndAwe.db.char.priority.show and InCombatLockdown() then
		self.PriorityFrame:Show()
	else
		self.PriorityFrame:Hide()
	end
	if SlamAndAwe.db.char.priority.titleshow then
		self.PriorityFrame.topText:Show()
	else
		self.PriorityFrame.topText:Hide()
	end
	if LBF and LBFgroup then
		LBFgroup:AddButton(self.PriorityFrame)
	end
end

function SlamAndAwe:ResetPriority()
	self.PriorityFrame:ClearAllPoints()
	SlamAndAwe.db.char.priority.point = self.defaults.char.priority.point
	SlamAndAwe.db.char.priority.relativeTo = self.defaults.char.priority.relativeTo 
	SlamAndAwe.db.char.priority.relativePoint = self.defaults.char.priority.relativePoint
	SlamAndAwe.db.char.priority.xOffset = self.defaults.char.priority.xOffset
	SlamAndAwe.db.char.priority.yOffset = self.defaults.char.priority.yOffset
	SlamAndAwe.db.char.priority.fWidth = self.defaults.char.priority.fWidth
	SlamAndAwe.db.char.priority.fHeight = self.defaults.char.priority.fHeight
	SlamAndAwe.db.char.priority.scale = self.defaults.char.priority.scale
	SlamAndAwe.db.char.priority.prOption = self.defaults.char.priority.prOption
	self.PriorityFrame:SetPoint(SlamAndAwe.db.char.priority.point, SlamAndAwe.db.char.priority.relativeTo, SlamAndAwe.db.char.priority.relativePoint, SlamAndAwe.db.char.priority.xOffset, SlamAndAwe.db.char.priority.yOffset)
	self:CreatePriorityFrame()
	self:Print(L["priority_reset"])
end

function SlamAndAwe:SetPriorityUpdateScript()
	self.PriorityFrame:SetScript("OnUpdate", 
		function()
			if self.updatePriority then
				SlamAndAwe.db.char.priority.previous = SlamAndAwe.db.char.priority.next
				SlamAndAwe:SetNextPriority()
--				if SlamAndAwe.db.char.priority.next ~= SlamAndAwe.db.char.priority.previous or SlamAndAwe:CheckShamanisticRage() then
				SlamAndAwe:SetPriorityIcon(SlamAndAwe.db.char.priority.next) -- always set icon to fix the times where it was getting stuck
--				end
				if SlamAndAwe.db.char.priority.showcooldown then
					local startTime, duration = GetSpellCooldown(SlamAndAwe.constants["Demoralizing Shout"])
					if startTime then
						SlamAndAwe.PriorityFrame.cooldown:SetCooldown(startTime, duration)
					end
				end
			end
		end );
end

function SlamAndAwe:SetPriorityIcon(priority)
	--self:DebugPrint("setting icon to "..priority)
	if InCombatLockdown() or priority == "none" then
		local icon = self.priorityTable.icon[priority]
		if self:CheckWindShear() then
			icon = SlamAndAwe.constants["Heroic Strike Icon"]
			SlamAndAwe.db.char.priority.next = "wind"
		end
		if self:CheckShamanisticRage() then
			icon = SlamAndAwe.constants["Shamanistic Rage Icon"]
			SlamAndAwe.db.char.priority.next = "mana"
		end
		-- check if we should show shamanistic rage icon
		self:SetPriorityBackdrop(icon)
	end
end

function SlamAndAwe:CheckWindShear()
	if SlamAndAwe.db.char.hsshow then
     local avail = SlamAndAwe:SpellAvailable(SlamAndAwe.constants["Heroic Strike"])
     local usable, nomana = IsUsableSpell(SlamAndAwe.constants["Heroic Strike"])
     local buff1 = SlamAndAwe:GetBuffInfo(SlamAndAwe.constants["Battle Trance"])
     local buff2 = SlamAndAwe:GetBuffInfo(SlamAndAwe.constants["Incite"])    		
     local rage = UnitPower("player", "rage")
		local hsrage = SlamAndAwe.db.char.rageThreshold
		
		if buff1 or buff2 then
      if usable and avail then
        return true
      end     
    elseif rage >= hsrage then
        if usable and avail then
						return true
        end
		end
	end
	return false
end

function SlamAndAwe:CheckShamanisticRage()
	local srtalent
	_, _, _, _, srtalent = GetTalentInfo(2,26)
	if srtalent == 1 then
		local startTime, duration = GetSpellCooldown(SlamAndAwe.constants["Shamanistic Rage"])
		if startTime then 
			local timeleft = startTime + duration - GetTime()
			local manapercent = 100 * UnitMana("player") / UnitManaMax("player")
			if manapercent < SlamAndAwe.db.char.priority.srmana and timeleft <= SlamAndAwe.db.char.priority.cooldown then
				return true
			end
		end
	end
	return false
end

function SlamAndAwe:QuakingEarthEquipped()
	local rangedLink = GetInventoryItemLink("player",GetInventorySlotInfo("RangedSlot")) or "0:0"
    local _, itemID = strsplit(":", rangedLink)
	return itemID == "47667" -- returns if ranged slot has Totem of Quaking Earth
end

function SlamAndAwe:SetNextPriority()
	-- force update of stacks count to ensure priority shown correctly
	SlamAndAwe.db.char.msstacks = SlamAndAwe:GetMaelstromInfo()
	if SlamAndAwe.db.char.priority.combopoints then
		self:ShowComboPoints()
	end
	SlamAndAwe.db.char.priority.next = "none"
	for index = 1, 16 do
		if SlamAndAwe.db.char.priority.prOption[index] and self.priorityTable.test[SlamAndAwe.db.char.priority.prOption[index]] then  -- verify that the option actually exists
			if self.priorityTable.test[SlamAndAwe.db.char.priority.prOption[index]]() then
				SlamAndAwe.db.char.priority.next = SlamAndAwe.db.char.priority.prOption[index]
				return -- we need to break out of the routine as we have found the top priority
			end
		end
	end
end

function SlamAndAwe:ShowComboPoints()
	local col = SlamAndAwe.db.char.colours.maelstrom
	for index = 1, 5 do
		if self.PriorityFrame.combo[index].frame then
			if SlamAndAwe.db.char.msstacks >= index then
				self.PriorityFrame.combo[index].frame:SetBackdropColor(1, 0, 0, 1)
			else
				self.PriorityFrame.combo[index].frame:SetBackdropColor(col.r, col.g, col.b, 0)
			end
		else
			self:Print("Error could not find combo frame "..index)
		end
	end
end

function SlamAndAwe:CreateComboPointFrames()
	self.PriorityFrame.combo = {}
	for index = 1, 5 do 
		self:CreateComboPoint(index)
	end
end
	
function SlamAndAwe:CreateComboPoint(index)
	if not self.PriorityFrame.combo[index] or not self.PriorityFrame.combo[index].frame then
		self.PriorityFrame.combo[index] = {}
		self.PriorityFrame.combo[index].frame = CreateFrame("Frame", "SAA_PriorityComboFrame"..index, self.PriorityFrame)
	end
	local comboFrame = self.PriorityFrame.combo[index].frame
	local width = SlamAndAwe.db.char.priority.fWidth / 5
	local height = SlamAndAwe.db.char.priority.fHeight / 5
	comboFrame:SetScale(SlamAndAwe.db.char.priority.scale)
	comboFrame:SetFrameStrata("BACKGROUND")
	comboFrame:SetWidth(width)
	comboFrame:SetHeight(height)
	comboFrame:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 4,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})	
	comboFrame:SetBackdropColor(0, 0, 0, 0);
	comboFrame:SetPoint("BOTTOMLEFT",  self.PriorityFrame, "BOTTOMLEFT", (index - 1) * width , - height)

	if SlamAndAwe.db.char.priority.combopoints then
		comboFrame:Show()
	else
		comboFrame:Hide()
	end
end

function SlamAndAwe:CreateInterruptPurgeFrames()
	if not self.PriorityFrame.interrupt then
		self.PriorityFrame.interrupt = {}
		self.PriorityFrame.interrupt.frame = CreateFrame("Frame", "SAA_PriorityInterruptFrame", self.PriorityFrame)
	end
	local interruptFrame = self.PriorityFrame.interrupt.frame
	local width = SlamAndAwe.db.char.priority.fWidth / 2
	local height = SlamAndAwe.db.char.priority.fHeight / 2
	interruptFrame:SetScale(SlamAndAwe.db.char.priority.scale)
	interruptFrame:SetFrameStrata("BACKGROUND")
	interruptFrame:SetWidth(width)
	interruptFrame:SetHeight(height)
	self:SetSubFrameBackdrop(interruptFrame, "Interface/Tooltips/UI-Tooltip-Background", 4)	
	interruptFrame:SetBackdropColor(0, 0, 0, 0);
	interruptFrame:SetPoint("BOTTOMLEFT",  self.PriorityFrame, "BOTTOMRIGHT", 0 , 0)
	if SlamAndAwe.db.char.priority.showinterrupt then
		interruptFrame:Show()
	else
		interruptFrame:Hide()
	end

	if not self.PriorityFrame.purge then
		self.PriorityFrame.purge = {}
		self.PriorityFrame.purge.frame = CreateFrame("Frame", "SAA_PrioritypurgeFrame", self.PriorityFrame)
	end
	local purgeFrame = self.PriorityFrame.purge.frame
	purgeFrame:SetScale(SlamAndAwe.db.char.priority.scale)
	purgeFrame:SetFrameStrata("BACKGROUND")
	purgeFrame:SetWidth(width)
	purgeFrame:SetHeight(height)
	self:SetSubFrameBackdrop(purgeFrame, "Interface/Tooltips/UI-Tooltip-Background", 4)	
	purgeFrame:SetBackdropColor(0, 0, 0, 0);
	purgeFrame:SetPoint("BOTTOMLEFT",  self.PriorityFrame, "BOTTOMRIGHT", 0 , height)	
	if SlamAndAwe.db.char.priority.showpurge then
		purgeFrame:Show()
	else
		purgeFrame:Hide()
	end
end

function SlamAndAwe:SetSubFrameBackdrop(subFrame, icon, edgeSize)
	subFrame:SetBackdrop({ bgFile = icon,
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = edgeSize,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})	
end