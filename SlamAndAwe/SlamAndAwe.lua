-- @release $Id: SlamAndAwe.lua 15 2011-02-11 21:31:27Z reighnman $

if select(2, UnitClass('player')) ~= "WARRIOR" then
	DisableAddOn("SlamAndAwe")
	return
end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local AceAddon = LibStub("AceAddon-3.0")
local media = LibStub:GetLibrary("LibSharedMedia-3.0")
SlamAndAwe = AceAddon:NewAddon("SlamAndAwe", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local SCT = SCT
local REVISION = tonumber(("$Revision: 15 $"):match("%d+"))
local _, _, _, clientVersion = GetBuildInfo()
local queryDisable = false

SlamAndAwe.frames = {}

SlamAndAwe.BaseFrame = CreateFrame("Frame","SlamAndAweBase",UIParent)
SlamAndAwe.frames["Recklessness"] = CreateFrame("Frame","SAA_Bar5_Status",SlamAndAwe.BaseFrame)
SlamAndAwe.frames["Recklessness"].icon = CreateFrame("Frame","SAA_Bar5_StatusIcon",SlamAndAwe.BaseFrame)
SlamAndAwe.frames["DeathWish"] = CreateFrame("Frame","SAA_Bar6_Status",SlamAndAwe.BaseFrame)
SlamAndAwe.frames["DeathWish"].icon = CreateFrame("Frame","SAA_Bar6_StatusIcon",SlamAndAwe.BaseFrame)
SlamAndAwe.frames["ColossusSmash"] = CreateFrame("Frame","SAA_Bar7_Status",SlamAndAwe.BaseFrame)
SlamAndAwe.frames["ColossusSmash"].icon = CreateFrame("Frame","SAA_Bar7_StatusIcon",SlamAndAwe.BaseFrame)
SlamAndAwe.frames["GCD"] = CreateFrame("Frame", "SAA_Bar8_Status", SlamAndAwe.BaseFrame)
SlamAndAwe.msgFrame = CreateFrame("MessageFrame","SlamAndAweMsg",UIParent)
SlamAndAwe.questionFrame = CreateFrame("Frame","SlamAndAweQuestion",UIParent)

SlamAndAwe.textures = {}
SlamAndAwe.borders = {}
SlamAndAwe.fonts = {}
SlamAndAwe.sounds = {}
SlamAndAwe.barBackdrop = {
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	}
SlamAndAwe.frameBackdrop ={
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	}
SlamAndAwe.GCDMin = 0
SlamAndAwe.GCDMax = 0
SlamAndAwe.GCDWidth = 0
	
local SSmin, SSmax, ShockMin, ShockMax, ShearMin, ShearMax, WFPMin, WFPMax, ShieldMin, ShieldMax, MaelstromMin, MaelstromMax
local FSMin, FSMax, FSCDMin, FSCDMax, FireTotemMin, FireTotemMax, GCDPercent, FSDotTime, FNmin, FNmax
local updateActiveSS = false
local updateActiveFireTotem = false
local updateActiveMaelstrom = false
local updateActiveShock = false
local updateActiveFSDot = false
local updateActiveShear = false
local updateActiveShamanistic = false
local updateActiveWFProc = false
local updateActiveGCD = true
local updateActiveFN = false
local WFProcTime = 0
local SSTime = 0
local FireTotemTime = 0
local FNTime = 0
local GCDTime = 0
local FSTime = 0
local FSCDTime = 0
local ShockTime = 0
local FSDotTime = 0
local ShearTime = 0
local ShieldTime = 0
local lastSound = 0
local mw4played = false
local mwflashing = false
local fireTotemGUID = 0
local searingTotem = false

--SlamAndAwe
local CSMin, CSMax, DWMin, DWMax, REMin, REMax
local updateActiveColossusSmash = false
local CSTime = 0
local updateActiveDeathWish = false
local DWTime = 0
local updateActiveRecklessness = false
local RETime = 0

-----------------------------------------
-- Initialisation & Startup Routines
-----------------------------------------

function SlamAndAwe:OnInitialize()
	local AceConfigReg = LibStub("AceConfigRegistry-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	self:SetConstants()
	self:SetBindings()
	self:SetDefaultOptions()
	
	SlamAndAwe.db = LibStub("AceDB-3.0"):New("SlamAndAweDBPC", SlamAndAwe.defaults, "char")
	self:SetPriorityTable()
	self:GetMSBTAreaDefaults()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SlamAndAwe", self:GetOptions(), {"slamandawe", "saa"} )
	media.RegisterCallback(self, "LibSharedMedia_Registered")
	
	-- Add the options to blizzard frame (add them backwards so they show up in the proper order
	self.optionsFrame = AceConfigDialog:AddToBlizOptions("SlamAndAwe", "SlamAndAwe")
	SlamAndAwe.db:RegisterDefaults(SlamAndAwe.defaults)
	if not SlamAndAwe.db.char.immuneTargets then
		SlamAndAwe.db.char.immuneTargets = {}
	end
	self:InitialiseUptime()
	self:InitialiseBindings()
	self:CreateUptimeFrame()
	self:CreatePriorityFrame()
	self:CreateMsgFrame()
	self:News()
	self:VerifyOptions()
	local version = GetAddOnMetadata("SlamAndAwe","Version")
	self.version = ("SlamAndAwe v%s (r%s)"):format(version, REVISION)
	self:Print(self.version.." Loaded.")
end

function SlamAndAwe:SetConstants()
	SlamAndAwe.constants = {}
	local C = SlamAndAwe.constants

	SlamAndAwe.constants["Stormstrike"], _, SlamAndAwe.constants["Stormstrike Icon"] = GetSpellInfo(17364)
	SlamAndAwe.constants["Frost Shock"], _, SlamAndAwe.constants["Frost Shock Icon"] = GetSpellInfo(8056)
	SlamAndAwe.constants["Earth Shock"], _, SlamAndAwe.constants["Earth Shock Icon"] = GetSpellInfo(8042)
	SlamAndAwe.constants["Flame Shock"], _, SlamAndAwe.constants["Flame Shock Icon"] = GetSpellInfo(8050)
	SlamAndAwe.constants["Wind Shear"], _, SlamAndAwe.constants["Wind Shear Icon"] = GetSpellInfo(57994)
	SlamAndAwe.constants["Water Shield"], _, SlamAndAwe.constants["Water Shield Icon"] = GetSpellInfo(52127)
	SlamAndAwe.constants["Windfury Weapon"], _, SlamAndAwe.constants["Windfury Weapon Icon"] = GetSpellInfo(8232)
	SlamAndAwe.constants["Frostbrand Weapon"], _, SlamAndAwe.constants["Frostbrand Weapon Icon"] = GetSpellInfo(8033)
	SlamAndAwe.constants["Flametongue Weapon"], _, SlamAndAwe.constants["Flametongue Weapon Icon"] = GetSpellInfo(8024)
	SlamAndAwe.constants["Earthliving Weapon"], _, SlamAndAwe.constants["Earthliving Weapon Icon"] = GetSpellInfo(51730)
	SlamAndAwe.constants["Lightning Shield"], _, SlamAndAwe.constants["Lightning Shield Icon"] = GetSpellInfo(324)
	SlamAndAwe.constants["Maelstrom Weapon"], _, SlamAndAwe.constants["Maelstrom Weapon Icon"] = GetSpellInfo(53817)
	SlamAndAwe.constants["Earth Shield"], _, SlamAndAwe.constants["Earth Shield Icon"] = GetSpellInfo(974)
	SlamAndAwe.constants["Elemental Devastation"], _, SlamAndAwe.constants["Elemental Devastation Icon"] = GetSpellInfo(29178)
	SlamAndAwe.constants["Lava Lash"], _, SlamAndAwe.constants["Lava Lash Icon"] = GetSpellInfo(60103)
	SlamAndAwe.constants["Flurry"], _, SlamAndAwe.constants["Flurry Icon"] = GetSpellInfo(16278)
	SlamAndAwe.constants["Lightning Bolt"], _, SlamAndAwe.constants["Lightning Bolt Icon"] = GetSpellInfo(403)
	SlamAndAwe.constants["Chain Lightning"], _, SlamAndAwe.constants["Chain Lightning Icon"] = GetSpellInfo(421)
	SlamAndAwe.constants["Grounding Totem"], _, _ = GetSpellInfo(8177)
	SlamAndAwe.constants["Flametongue Totem"], _, SlamAndAwe.constants["Flametongue Totem Icon"] = GetSpellInfo(8227)
	SlamAndAwe.constants["Searing Totem"], _, SlamAndAwe.constants["Searing Totem Icon"] = GetSpellInfo(3599)
	SlamAndAwe.constants["Magma Totem"], _, SlamAndAwe.constants["Magma Totem Icon"] = GetSpellInfo(8190)
	SlamAndAwe.constants["Fire Elemental Totem"], _, SlamAndAwe.constants["Fire Elemental Totem Icon"] = GetSpellInfo(2894)
	SlamAndAwe.constants["Shamanistic Rage"], _, SlamAndAwe.constants["Shamanistic Rage Icon"] = GetSpellInfo(30823)
	SlamAndAwe.constants["Feral Spirit"], _, SlamAndAwe.constants["Feral Spirit Icon"] = GetSpellInfo(51533)
	SlamAndAwe.constants["Unleash Elements"], _, SlamAndAwe.constants["Unleash Elements Icon"] = GetSpellInfo(73680)
	SlamAndAwe.constants["Unleash Flame"], _, SlamAndAwe.constants["Unleash Flame Icon"] = GetSpellInfo(73683)
	SlamAndAwe.constants["Heroic Presence"], _, _ = GetSpellInfo(28878)
	SlamAndAwe.constants["Champion of the Kirin Tor"], _, _ = GetSpellInfo(57821)
	SlamAndAwe.constants["Healing Wave"], _, SlamAndAwe.constants["Healing Wave Icon"] = GetSpellInfo(331)
	SlamAndAwe.constants["Greater Healing Wave"], _, SlamAndAwe.constants["Greater Healing Wave Icon"] = GetSpellInfo(77472)
	SlamAndAwe.constants["Chain Heal"], _, SlamAndAwe.constants["Chain Heal Icon"] = GetSpellInfo(1064)
	SlamAndAwe.constants["Totemic Recall"], _, SlamAndAwe.constants["Totemic Recall Icon"] = GetSpellInfo(36936)
	SlamAndAwe.constants["Volcanic Fury"], _, SlamAndAwe.constants["Volcanic Fury"] = GetSpellInfo(67391)
	SlamAndAwe.constants["Windfury Attack"], _, SlamAndAwe.constants["Windfury Attack Icon"] = GetSpellInfo(25504)
	
	SlamAndAwe.constants["Searing Flames"], _, SlamAndAwe.constants["Searing Flames Icon"] = GetSpellInfo(77661)
	SlamAndAwe.constants["Purge"], _, SlamAndAwe.constants["Purge Icon"] = GetSpellInfo(8012)
	SlamAndAwe.constants["Fire Nova"], _, SlamAndAwe.constants["Fire Nova Icon"] = GetSpellInfo(1535)

--SlamAndAwe
  SlamAndAwe.constants["Colossus Smash"], _, SlamAndAwe.constants["Colossus Smash Icon"] = GetSpellInfo(86346)
	SlamAndAwe.constants["Bloodthirst"], _, SlamAndAwe.constants["Bloodthirst Icon"] = GetSpellInfo(23881)
	SlamAndAwe.constants["Raging Blow"], _, SlamAndAwe.constants["Raging Blow Icon"] = GetSpellInfo(85288)
	SlamAndAwe.constants["Enrage"], _, SlamAndAwe.constants["Enrage Icon"] = GetSpellInfo(13046)
	SlamAndAwe.constants["Berserker Rage"], _, SlamAndAwe.constants["Berserker Rage Icon"] = GetSpellInfo(18499)
	SlamAndAwe.constants["Death Wish"], _, SlamAndAwe.constants["Death Wish Icon"] = GetSpellInfo(12292)	
	SlamAndAwe.constants["Slam"], _, SlamAndAwe.constants["Slam Icon"] = GetSpellInfo(1464)
	SlamAndAwe.constants["Bloodsurge"], _, SlamAndAwe.constants["Bloodsurge Icon"] = GetSpellInfo(46915)
	SlamAndAwe.constants["Heroic Strike"], _, SlamAndAwe.constants["Heroic Strike Icon"] = GetSpellInfo(78)
	SlamAndAwe.constants["Pummel"], _, SlamAndAwe.constants["Pummel Icon"] = GetSpellInfo(6552)
	SlamAndAwe.constants["Battle Trance"], _, SlamAndAwe.constants["Battle Trance Icon"] = GetSpellInfo(12964)
  SlamAndAwe.constants["Demoralizing Shout"], _, SlamAndAwe.constants["Demoralizing Shout Icon"] = GetSpellInfo(1160)
  SlamAndAwe.constants["Shattering Throw"], _, SlamAndAwe.constants["Shattering Throw Icon"] = GetSpellInfo(64382)
  SlamAndAwe.constants["Incite"], _, SlamAndAwe.constants["Incite Icon"] = GetSpellInfo(50687)
  SlamAndAwe.constants["Execute"], _, SlamAndAwe.constants["Execute Icon"] = GetSpellInfo(5308)
  SlamAndAwe.constants["Battle Shout"], _, SlamAndAwe.constants["Battle Shout Icon"] = GetSpellInfo(6673)
  SlamAndAwe.constants["Recklessness"], _, SlamAndAwe.constants["Recklessness Icon"] = GetSpellInfo(1719)
  SlamAndAwe.constants["Executioner"], _, SlamAndAwe.constants["Executioner Icon"] = GetSpellInfo(90806)  
    
end

function SlamAndAwe:OnDisable()
    -- Called when the addon is disabled
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("PLAYER_ALIVE")
  self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
--  self:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
--  self:UnregisterEvent("UNIT_AURA")
--	self:UnregisterEvent("UNIT_MANA")
	self:UnregisterEvent("CHARACTER_POINTS_CHANGED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
--  self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
	self:UnregisterEvent("UPDATE_BINDINGS")
	self:UnregisterEvent("UI_ERROR_MESSAGE")
-- we must still look out for talent changes to fire change of spec to re-enable
--	self:UnregisterEvent("PLAYER_TALENT_UPDATE")
--	self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:UnregisterEvent("UNIT_EXITED_VEHICLE")
	self:UnregisterEvent("UNIT_ENTERED_VEHICLE")
end

function SlamAndAwe:OnEnable()
	self:LibSharedMedia_Registered()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ALIVE")
  self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
--  self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
--  self:RegisterEvent("UNIT_AURA")
-- self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("CHARACTER_POINTS_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
--  self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	self:RegisterEvent("UPDATE_BINDINGS")
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE")
	self:RegisterEvent("UNIT_EXITED_VEHICLE")
end

function SlamAndAwe:LibSharedMedia_Registered()
	media:Register("sound", "SAA Maelstrom 1", "Sound\\Spells\\ShootWandLaunchLightning.wav")
	media:Register("sound", "SAA Maelstrom 2", "Sound\\Spells\\DynamiteExplode.wav")
	media:Register("sound", "SAA Maelstrom 3", "Sound\\Spells\\ArmorKitBuffSound.wav")
	media:Register("sound", "SAA Maelstrom 4", "Sound\\Spells\\Fizzle\\FizzleShadowA.wav")
	media:Register("sound", "SAA Maelstrom 5", "Sound\\Spells\\LevelUp.wav")
	media:Register("sound", "SAA Maelstrom 6", "Sound\\Spells\\Tradeskills\\FishBite.wav")
	media:Register("sound", "SAA Maelstrom 7", "Sound\\Spells\\Tradeskills\\MiningHitA.wav")
	media:Register("sound", "SAA Maelstrom 8", "Sound\\Spells\\AspectofTheSnake.wav")
	media:Register("sound", "SAA Maelstrom 9", "Sound\\Spells\\bind2_Impact_Base.wav")
	media:Register("sound", "SAA Shield 1", "Sound\\Doodad\\BellowIn.wav")
	media:Register("sound", "SAA Shield 2", "Sound\\Doodad\\BellowOut.wav")
	media:Register("sound", "SAA Shield 3", "Sound\\Doodad\\PVP_Lordaeron_Door_Open.wav")
	media:Register("sound", "SAA Shield 4", "Sound\\Spells\\ShaysBell.wav")

	for k, v in pairs(media:List("statusbar")) do
		self.textures[v] = v
	end
	for k, v in pairs(media:List("border")) do
		self.borders[v] = v
	end
	for k, v in pairs(media:List("font")) do
		self.fonts[v] = v
	end
	for k, v in pairs(media:List("sound")) do
		self.sounds[v] = v
	end
end

----------------------
-- Event Routines
----------------------

function SlamAndAwe:UNIT_ENTERED_VEHICLE()
	if UnitInVehicle("player") then
		self:TidyUpAfterCombat() -- on entering vehicle treat as if out of combat ie: disable incombat displays
	end
end

function SlamAndAwe:UNIT_EXITED_VEHICLE()
	if not UnitInVehicle("player") and InCombatLockdown() then
		self:EnteredCombat()  -- if in combat when exit vehichle enable SlamAndAwe combat effects
	end
end

function SlamAndAwe:PLAYER_ENTERING_WORLD()
	self:SetBorderTexture(nil, SlamAndAwe.db.char.border)
	self:SetBarBorderTexture(nil, SlamAndAwe.db.char.barborder)
	self:SetTalentEffects()
	self:RedrawFrames()
	self:UpdateBindings()
	SlamAndAwe.db.char.priority.prOption = SlamAndAwe.db.char.priority.prOptions[SlamAndAwe.db.char.priority.groupnumber]
end

function SlamAndAwe:PLAYER_LOGIN()
	self:SetBorderTexture(nil, SlamAndAwe.db.char.border)
	self:SetBarBorderTexture(nil, SlamAndAwe.db.char.barborder)
	queryDisable = false -- when player first logs in set test for talents in Enh Spec to false
end

function SlamAndAwe:PLAYER_ALIVE()
	self:SetTalentEffects()
	self:RedrawFrames()
	self:UpdateBindings()
	if not queryDisable then -- only ask if not in Enh and addon active if this is fired immediately after first login
		self:QueryDisableAddon()
		queryDisable = true
	end
end

function SlamAndAwe:UI_ERROR_MESSAGE(_, ...)
	if SlamAndAwe.db.char.warning.range then
		local arg1 = select(1,...) or ""
		if strfind(arg1, L["Out of range"]) or strfind(arg1, L["too far away"]) then
			self:PrintMsg(arg1, SlamAndAwe.db.char.warning.colour, 0.5)
		end
	end
end

function SlamAndAwe:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	if sourceGUID == UnitGUID("player") then
		local spellID = select(1,...) or 0
		if SlamAndAwe.db.char.warning.interrupt and event == "SPELL_INTERRUPT" then
			local spellName = select(5,...)
			if spellName then
				self:PrintMsg(L["Interrupted: "] .. spellName, SlamAndAwe.db.char.warning.colour, SlamAndAwe.db.char.warning.duration)
			end
		end
	end
end

function SlamAndAwe:SPELL_UPDATE_COOLDOWN()
	if SlamAndAwe.db.char.gcdshow then
		self:GCDBar()
	end
end

function SlamAndAwe:UNIT_SPELLCAST_SUCCEEDED(_, ...)
	local arg1 = select(1,...) or ""
	local arg2 = select(2,...) or ""
	if arg1 == "player" then -- skip if someone else casting
		if SlamAndAwe.db.char.csshow then
			if arg2 == SlamAndAwe.constants["Colossus Smash"] then
				self:ColossusSmashBar()
			end
		end
	  if SlamAndAwe.db.char.dwshow then
			if arg2 == SlamAndAwe.constants["Death Wish"] then
				self:DeathWishBar()
			end
		end
		if SlamAndAwe.db.char.reshow then
			if arg2 == SlamAndAwe.constants["Recklessness"] then
				self:RecklessnessBar()
			end
		end
	end
end

function SlamAndAwe:CHARACTER_POINTS_CHANGED()
	self:SetTalentEffects()
	self:CreateBaseFrame()
end

function SlamAndAwe:PLAYER_REGEN_DISABLED() -- Entering Combat
	self:EnteredCombat()
end

function SlamAndAwe:PLAYER_REGEN_ENABLED() -- Leaving Combat
	self:TidyUpAfterCombat()
end

function SlamAndAwe:UPDATE_BINDINGS()
	if not InCombatLockdown() then
		self:UpdateBindings()
	end
end

function SlamAndAwe:PLAYER_TALENT_UPDATE()
	self:SetTalentEffects()
	self:RedrawFrames()
end

function SlamAndAwe:ACTIVE_TALENT_GROUP_CHANGED()
	self:QuerySpecChanged()
end

----------------------------
-- Combat start and stop
----------------------------

function SlamAndAwe:EnteredCombat()
	if UnitInVehicle("player") then -- don't enable priorities & bars if we enter combat in a vehicle
		return
	end
	if SlamAndAwe.db.char.disablebars then
		self.BaseFrame:Show()
	end
	if SlamAndAwe.db.char.uptime.show then
		if not self.uptime.incombat then
			self.uptime.incombat = true
			-- reset last fight data on entering combat
			self:InitialiseUptimeBuffs(self.uptime.lastfight)
			self.uptime.currentTime = GetTime()
			self:UpdateUptime()
			self:UpdateUptimeFrames(true)
			self.uptime.TimerEvent = self:ScheduleRepeatingTimer("UpdateUptime", 0.1, nil);
		end
	end
	if SlamAndAwe.db.char.maelstromTalents == 0 then -- check MW talents again to counter Player_Entering_World bug
		self:SetTalentEffects()
		self:CreateBaseFrame()
	end
	if SlamAndAwe.db.char.priority.show and not SlamAndAwe.db.char.disabled then
		SlamAndAwe.db.char.priority.next = "none"
		self:SetPriorityIcon(SlamAndAwe.db.char.priority.next)
		self.updatePriority = true
		self.PriorityFrame:Show()
	end
end

function SlamAndAwe:TidyUpAfterCombat()
--SlamAndAwe	
	self.frames["DeathWish"].icon:Hide()
	self.frames["ColossusSmash"].icon:Hide()
	self.frames["Recklessness"].icon:Hide()
	
	self:SetPriorityIcon("none")
	self.updatePriority = false
	self.PriorityFrame:Hide()
	if SlamAndAwe.db.char.uptime.show then
		if self.uptime.incombat then
			self:UpdateUptime()
			self.uptime.incombat = false
			self:UpdateUptimeFrames(true)
			self:CancelTimer(self.uptime.TimerEvent , false)
		end
	end
	if SlamAndAwe.db.char.disablebars then
		self.BaseFrame:Hide()
	end
	if not SlamAndAwe.db.char.binding.macroset then
		-- call update Bindings to set macro keys if we were in combat when addon initialised
		self:UpdateBindings()
	end
end

----------------------------
-- Question box handler
----------------------------

function SlamAndAwe:QuerySpecChanged()
	if SlamAndAwe.db.char.specchangewarning then
		if SlamAndAwe.db.char.maelstromTalents == 0 and not SlamAndAwe.db.char.disabled then
			-- addon is enabled but we have changed to a non Enhance Spec ask if we should disable addon
			self:DisplayQuestionFrame(false, true)
		elseif SlamAndAwe.db.char.maelstromTalents > 0 and SlamAndAwe.db.char.disabled then
			-- addon is disabled and we have changed to an Fury Spec ask if we should enable addon
			self:DisplayQuestionFrame(true, true)
		end
	end
end

function SlamAndAwe:QueryDisableAddon()
	if SlamAndAwe.db.char.maelstromTalents == 0 then -- check MW talents again to counter Player_Entering_World bug
		self:SetTalentEffects()
	end
	if UnitLevel("player") >= 60 then -- don't bother asking to disable addon if player under level 60.
		if SlamAndAwe.db.char.maelstromTalents == 0 and not SlamAndAwe.db.char.disabled then
			-- addon is enabled but we have changed to a non Enhance Spec ask if we should disable addon
			self:DisplayQuestionFrame(false, false)
		elseif SlamAndAwe.db.char.maelstromTalents > 0 and SlamAndAwe.db.char.disabled then
			-- addon is disabled and we have changed to an Enhance Spec ask if we should enable addon
			self:DisplayQuestionFrame(true, false)
		end
	end
end

StaticPopupDialogs["SAA_QUESTION_FRAME"] = {
	text = L["You have changed to a new talent spec do you want to enable SlamAndAwe?"],
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		SlamAndAwe:EnableDisable()
	end,
	timeout = 0,
	hideOnEscape = 1,
}

function SlamAndAwe:DisplayQuestionFrame(enable, spec)
	if spec then
		if enable then 
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You have changed to a new talent spec do you want to enable SlamAndAwe?"]
		else
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You have changed to a new talent spec do you want to disable SlamAndAwe?"]
		end
	else
		if enable then 
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You are in Fury spec do you want to enable SlamAndAwe?"]
		else
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You are NOT in Fury spec do you want to disable SlamAndAwe?"]
		end
	end
	self:DebugPrint("entered DisplayQuestionFrame, text is :"..StaticPopupDialogs["SAA_QUESTION_FRAME"].text)
	StaticPopup_Show("SAA_QUESTION_FRAME")
end
	
---------------------------
-- Buff Info functions
---------------------------

function SlamAndAwe:GetMaelstromInfo()
	return 0, 0 
end

---------------------------
-- functions
---------------------------

function SlamAndAwe:IsFireTotem(spellID)
	return false
end

function SlamAndAwe:FireNovaGlyph()
	return 0
end

function SlamAndAwe:EnablePetFrame()
	return false
end

function SlamAndAwe:RedrawFrames()
	self:CreateBaseFrame()
	self:CreateUptimeFrame()
end

function SlamAndAwe:SetTalentEffects()
	local currRank, maxRank
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,17)
	SlamAndAwe.db.char.maelstromTalents = currRank
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,6) 
	local reverberation = currRank
	if SlamAndAwe.db.char.maelstromTalents == 0 then
		updateActiveMaelstrom = false
	end
  
  _, _, _, _, currRank, maxRank = GetTalentInfo(1,9)
	SlamAndAwe.db.char.FNlen = 10 - 2 * currRank - self:FireNovaGlyph()
	-- TODO replace this with programatic gear check if per son has arena gear
	if SlamAndAwe.db.char.arena then
		SlamAndAwe.db.char.SSlen = 6 -- arena bonus reduces by 2 sec.
	else
		SlamAndAwe.db.char.SSlen = 8
	end
	if SlamAndAwe.db.char.SSlen > SlamAndAwe.db.char.FNlen then
		SlamAndAwe.db.char.maxLen = SlamAndAwe.db.char.SSlen
	else
		SlamAndAwe.db.char.maxLen = SlamAndAwe.db.char.FNlen
	end

--SlamAndAwe

  SlamAndAwe.db.char.CSLen = 6
  SlamAndAwe.db.char.CSPercent = 1
  SlamAndAwe.db.char.DWLen = 30
  SlamAndAwe.db.char.DWPercent = 1
  SlamAndAwe.db.char.RELen = 12
  SlamAndAwe.db.char.REPercent = 1
  
	
	SlamAndAwe.db.char.ShearPercent = SlamAndAwe.db.char.ShearLen / SlamAndAwe.db.char.maxLen
	SlamAndAwe.db.char.WFProcPercent = 3 / SlamAndAwe.db.char.maxLen
	if SlamAndAwe.db.char.gcdfullwidth then
		GCDPercent = 1
	else
		GCDPercent = 1.5 / SlamAndAwe.db.char.maxLen
	end
end

function SlamAndAwe:DisplayVersion()
	self:Print(self.version)
end

function SlamAndAwe:CreateBaseFrame()
	if not SlamAndAwe.db.char.SSPercent or not SlamAndAwe.db.char.WFProcPercent or not SlamAndAwe.db.char.ShockPercent or not SlamAndAwe.db.char.ShearPercent or not SlamAndAwe.db.char.CSPercent or not SlamAndAwe.db.char.FNPercent or not GCDPercent then
		self:SetTalentEffects()
	end
	self.BaseFrame:SetScale(SlamAndAwe.db.char.scale)
	self.BaseFrame:SetFrameStrata("BACKGROUND")
	self.BaseFrame:SetWidth(SlamAndAwe.db.char.fWidth + SlamAndAwe.db.char.fHeight / 7)
	self.BaseFrame:SetHeight(SlamAndAwe.db.char.fHeight)
	self.BaseFrame:SetBackdrop(self.frameBackdrop)
	self.BaseFrame:SetBackdropColor(1, 1, 1, 0)
	self.BaseFrame:SetMovable(true)
	self.BaseFrame:RegisterForDrag("LeftButton")
	self.BaseFrame:SetPoint(SlamAndAwe.db.char.point, SlamAndAwe.db.char.relativeTo, SlamAndAwe.db.char.relativePoint, SlamAndAwe.db.char.xOffset, SlamAndAwe.db.char.yOffset)
	self.BaseFrame:SetScript("OnDragStart", 
		function()
			self.BaseFrame:StartMoving();
		end );
	self.BaseFrame:SetScript("OnDragStop",
		function()
			self.BaseFrame:StopMovingOrSizing();
			self.BaseFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(SlamAndAwe.db.char, self.BaseFrame);
		end );
	self.BaseFrame:Show()
	SlamAndAwe.db.char.movingframes = false
	
	local barHeight = SlamAndAwe.db.char.fHeight / 7
	local baseOffset = (-1 * barHeight) + 3
	local barCount = 0
  local colours = SlamAndAwe.db.char.colours.magma
	SlamAndAwe:SetBarFrame(self.frames["GCD"], 
					SlamAndAwe.db.char.fWidth * GCDPercent, barHeight,
					barCount * baseOffset, 1,
					0, 1.5, 
					6, 1, 
					.6, .6, .6, .6,
					false)
	self.GCDWidth = self.frames["GCD"].statusbar:GetWidth() -- to account for spark width
	if SlamAndAwe.db.char.gcdshow then
		barCount = barCount + 1 -- we will use gcd frame 
	end
	
--SlamAndAwe
	colours = SlamAndAwe.db.char.colours.colossussmash
	SlamAndAwe:SetBarFrame(self.frames["ColossusSmash"], 
					SlamAndAwe.db.char.fWidth * SlamAndAwe.db.char.CSPercent, barHeight, 
					barCount * baseOffset, 1,
					0, SlamAndAwe.db.char.CSLen, 
					10, 1, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if SlamAndAwe.db.char.csshow then
		barCount = barCount + 1 -- we will use ColossusSmash frame 
	end
	colours = SlamAndAwe.db.char.colours.deathwish
	SlamAndAwe:SetBarFrame(self.frames["DeathWish"], 
					SlamAndAwe.db.char.fWidth * SlamAndAwe.db.char.DWPercent, barHeight, 
					barCount * baseOffset, 1,
					0, SlamAndAwe.db.char.DWLen, 
					10, 1, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if SlamAndAwe.db.char.dwshow then
		barCount = barCount + 1 -- we will use DeathWish frame 
	end
	colours = SlamAndAwe.db.char.colours.recklessness
	SlamAndAwe:SetBarFrame(self.frames["Recklessness"], 
					SlamAndAwe.db.char.fWidth * SlamAndAwe.db.char.REPercent, barHeight, 
					barCount * baseOffset, 1,
					0, SlamAndAwe.db.char.RELen, 
					10, 1, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if SlamAndAwe.db.char.reshow then
		barCount = barCount + 1 -- we will use Recklessness frame 
	end

--SlamAndAwe
	self:SetBarIcon(self.frames["ColossusSmash"].icon, 86346)
	self:SetBarIcon(self.frames["DeathWish"].icon, 12292)
	self:SetBarIcon(self.frames["Recklessness"].icon, 1719)
end

function SlamAndAwe:SetBarFrame(frameName, barWidth, barHeight, frameOffset, frameLevel, minValue, maxValue, frameValue, frameSpark, frameR, frameG, frameB, frameAlpha, icon)
	frameName:SetFrameStrata("LOW")
	frameName:SetWidth(barWidth)
	frameName:SetHeight(barHeight)
	frameName:ClearAllPoints()
	frameName:SetPoint("TOPLEFT", self.BaseFrame, "TOPLEFT", barHeight, frameOffset)
	frameName:SetBackdrop(self.barBackdrop);
	frameName:SetBackdropColor(0, 0, 0, .2);
	frameName:SetBackdropBorderColor( 1, 1, 1, 1);
	frameName:EnableMouse(false)
	if not frameName.statusbar then
		frameName.statusbar = CreateFrame("StatusBar", nil, frameName)
	end
	frameName.statusbar:SetFrameLevel(frameLevel)
	frameName.statusbar:ClearAllPoints()
	frameName.statusbar:SetHeight(barHeight - 6)
	frameName.statusbar:SetWidth(barWidth - 6)
	frameName.statusbar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 3, -3)
	frameName.statusbar:SetStatusBarTexture(media:Fetch("statusbar", SlamAndAwe.db.char.texture))
	frameName.statusbar:GetStatusBarTexture():SetHorizTile(true) -- fix for textures stretching rather than revealing
	frameName.statusbar:SetStatusBarColor(frameR, frameG, frameB, frameAlpha)
	frameName.statusbar:SetMinMaxValues(minValue,maxValue)
	frameName.statusbar:SetValue(frameValue)
	
	if not frameName.spark then
		frameName.spark = frameName.statusbar:CreateTexture(nil, "OVERLAY")
	end
	frameName.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	frameName.spark:SetWidth(16)
	frameName.spark:SetHeight(barHeight + 16)
	frameName.spark:SetBlendMode("ADD")
	frameName.spark:SetPoint("CENTER",frameName.statusbar,"BOTTOMLEFT",(barWidth - 6)* frameSpark, -1)
	frameName.spark:Show()
	
	if not frameName.text then
		frameName.text = frameName:CreateFontString(nil,"OVERLAY")
	end
	local barfont = media:Fetch("font", SlamAndAwe.db.char.barfont)
	frameName.text:SetFont(barfont, SlamAndAwe.db.char.barfontsize, SlamAndAwe.db.char.barfonteffect)
	frameName.text:ClearAllPoints()
	frameName.text:SetTextColor(1, 1, 1, 1)
	frameName.text:SetPoint("CENTER", frameName, "CENTER");
	frameName.text:SetText("")

	frameName:SetScript("OnUpdate", 
		function()
			SlamAndAwe:OnBarUpdate();
		end );
	if icon then
		frameName.icon:SetWidth(barHeight - 3) -- same as height to get square box
		frameName.icon:SetHeight(barHeight - 3)
		frameName.icon:SetPoint("TOPRIGHT", frameName, "TOPLEFT", 0 , -2)
		frameName.icon:Hide()
	end	
	frameName:Hide()
end

function SlamAndAwe:SetBarIcon(iconFrame, spellID)
	local _, _, icon = GetSpellInfo(spellID)
	iconFrame:SetBackdrop({
		bgFile = icon,
		--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 0, right = 0, top = 0, bottom = 0 } })
end

function SlamAndAwe:ResetBars()
	self.BaseFrame:ClearAllPoints()
	SlamAndAwe.db.char.point = self.defaults.char.point
	SlamAndAwe.db.char.relativeTo = self.defaults.char.relativeTo 
	SlamAndAwe.db.char.relativePoint = self.defaults.char.relativePoint
	SlamAndAwe.db.char.xOffset = self.defaults.char.xOffset
	SlamAndAwe.db.char.yOffset = self.defaults.char.yOffset
	SlamAndAwe.db.char.fWidth = self.defaults.char.fWidth
	SlamAndAwe.db.char.fHeight = self.defaults.char.fHeight
	SlamAndAwe.db.char.scale = self.defaults.char.scale
	SlamAndAwe.db.char.barfont = self.defaults.char.barfont
	SlamAndAwe.db.char.barfontsize = self.defaults.char.barfontsize
	SlamAndAwe.db.char.bartexture = self.defaults.char.bartexture
	SlamAndAwe.db.char.texture = self.defaults.char.texture
	self.BaseFrame:SetPoint(SlamAndAwe.db.char.point, SlamAndAwe.db.char.relativeTo, SlamAndAwe.db.char.relativePoint, SlamAndAwe.db.char.xOffset, SlamAndAwe.db.char.yOffset)
	SlamAndAwe:SetTalentEffects()
	self:RedrawFrames()
	SlamAndAwe.db.char.movingframes = true -- so that call to ShowHideBars resets to false
	self:ShowHideBars()
	self:Print(L["config_reset"])
end

function SlamAndAwe:DebugTalents()
	local numTabs = GetNumTalentTabs();
	for t=1, numTabs do
		DEFAULT_CHAT_FRAME:AddMessage(GetTalentTabInfo(t)..":");
		local numTalents = GetNumTalents(t);
		for i=1, numTalents do
			nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
			DEFAULT_CHAT_FRAME:AddMessage("- "..i..":"..nameTalent..": "..currRank.."/"..maxRank);
		end
	end
end

function SlamAndAwe:DebugFrameValues()
	self:Print("CSLen : "..SlamAndAwe.db.char.CSLen)
  self:Print("CSPercent : "..SlamAndAwe.db.char.CSPercent)
	self:Print("DWLen : "..SlamAndAwe.db.char.DWLen)
	self:Print("DWPercent : "..SlamAndAwe.db.char.DWPercent)
	self:Print("ShockLen : "..SlamAndAwe.db.char.ShockLen)
	self:Print("ShockPercent : "..SlamAndAwe.db.char.ShockPercent )
	self:Print("WFProcPercent : "..SlamAndAwe.db.char.WFProcPercent)
end

function SlamAndAwe:WFProcBar()
	return
end

function SlamAndAwe:MaelstromBar()
	return
end

function SlamAndAwe:StormstrikeBar()
	return
end

function SlamAndAwe:FireNovaBar()
	return
end

function SlamAndAwe:FireTotemBar(totemName)
	return
end

--SlamAndAwe
function SlamAndAwe:ColossusSmashBar()
	local colours = SlamAndAwe.db.char.colours.colossussmash
	self.frames["ColossusSmash"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["ColossusSmash"]:Show()
	updateActiveColossusSmash = true
	CSTime = GetTime() + SlamAndAwe.db.char.CSLen
	CSMin, CSMax = self.frames["ColossusSmash"].statusbar:GetMinMaxValues()
	if SlamAndAwe.db.char.showicons then
		self.frames["ColossusSmash"].icon:Show()
	else
		self.frames["ColossusSmash"].icon:Hide()
	end
end

function SlamAndAwe:DeathWishBar()
	local colours = SlamAndAwe.db.char.colours.deathwish
	self.frames["DeathWish"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["DeathWish"]:Show()
	updateActiveDeathWish = true
	DWTime = GetTime() + SlamAndAwe.db.char.DWLen
	DWMin, DWMax = self.frames["DeathWish"].statusbar:GetMinMaxValues()
	if SlamAndAwe.db.char.showicons then
		self.frames["DeathWish"].icon:Show()
	else
		self.frames["DeathWish"].icon:Hide()
	end
end

function SlamAndAwe:RecklessnessBar()
	local colours = SlamAndAwe.db.char.colours.recklessness
	self.frames["Recklessness"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Recklessness"]:Show()
	updateActiveRecklessness = true
	RETime = GetTime() + SlamAndAwe.db.char.RELen
	REMin, REMax = self.frames["Recklessness"].statusbar:GetMinMaxValues()
	if SlamAndAwe.db.char.showicons then
		self.frames["Recklessness"].icon:Show()
	else
		self.frames["Recklessness"].icon:Hide()
	end
end

function SlamAndAwe:ShockBar(colours)
	self.frames["Shock"].icon:Hide()
end

function SlamAndAwe:DebugDebuffInfo()
	local index = 1
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, debuffExpires, unitCaster = UnitDebuff("target", index)
		local isMine = unitCaster == "player" 
		local expires = debuffExpires-GetTime()
		if isMine then
			self:DebugPrint("Debuff :"..name.." expires:"..expires)
		end
		index = index + 1
	end
end

function SlamAndAwe:FlameShockDotBar(shockCast)
	self.frames["FS_DOT"]:Hide()
	updateActiveFSDot = false	
end

function SlamAndAwe:ShearBar()
	self.frames["Shear"].icon:Hide()
end

function SlamAndAwe:GCDBar()
	local startTime, duration, enabled = GetSpellCooldown(SlamAndAwe.constants["Demoralizing Shout"]) -- Lightning Shield chosen because it has no other cooldown and all shammys will have it
	duration = duration or 0 -- force nil to 0 if for some bizzare reason no LS available.
	if duration > 0 then 
		self.frames["GCD"]:Show()
		updateActiveGCD = true
		GCDTime = startTime + duration
		self.GCDMax = duration
	end
end

function SlamAndAwe:DurationString(duration)
    local string = (("%1.1f"):format(duration % 60)) .. "s";
    
    if (duration >= 60) then
        duration = floor(duration - (duration % 60)) / 60; -- minutes
        
        string = (duration % 60) .."m " .. string;
        
        if (duration >= 60) then
            duration = (duration - (duration % 60)) / 60; -- hours
            string = duration .. "h " .. string;
        end
    end
    return string
end

function SlamAndAwe:CheckPurgeableBuff()
  return true
end

local OBU = {}
--OBU.width, OBU.timeLeft, OBU.maelstromTime, OBU.debuffs, OBU.sparkpoint, OBU.start, OBU.startTime, OBU.duration, OBU.EnemySpell, OBU.EnemySpellIcon, OBU.maxTime
--OBU.orbs, OBU.shieldType, OBU.purgeable

function SlamAndAwe:OnBarUpdate()
	if SlamAndAwe.db.char.disabled then
		return
	end
	
	OBU.width = SlamAndAwe.db.char.fWidth - 6
	OBU.timeLeft = 0
	
	if updateActiveGCD then
		OBU.timeLeft = GCDTime - GetTime()
		self.frames["GCD"].statusbar:SetValue(OBU.timeLeft)
		OBU.sparkpoint = OBU.timeLeft / 1.5 * self.GCDWidth
		if OBU.sparkpoint > self.GCDWidth then
			OBU.sparkpoint = self.GCDWidth
		end
		self.frames["GCD"].spark:SetPoint("CENTER",self.frames["GCD"].statusbar,"LEFT", OBU.sparkpoint,-1)
		if GCDTime < GetTime() then
			self.frames["GCD"]:Hide()
			updateActiveGCD = false
		end
	end

--SlamAndAwe
	if updateActiveColossusSmash then
		OBU.timeLeft = CSTime - GetTime()
		self.frames["ColossusSmash"].statusbar:SetValue(OBU.timeLeft)
		self.frames["ColossusSmash"].spark:SetPoint("CENTER",self.frames["ColossusSmash"].statusbar,"LEFT", OBU.timeLeft/CSMax * OBU.width * SlamAndAwe.db.char.CSPercent ,-1)
		if CSTime < GetTime() then
			self.frames["ColossusSmash"]:Hide()
			self.frames["ColossusSmash"].icon:Hide()
			updateActiveColossusSmash = false
		end
	end
	
	if updateActiveDeathWish then
		OBU.timeLeft = DWTime - GetTime()
		self.frames["DeathWish"].statusbar:SetValue(OBU.timeLeft)
		self.frames["DeathWish"].spark:SetPoint("CENTER",self.frames["DeathWish"].statusbar,"LEFT", OBU.timeLeft/DWMax * OBU.width * SlamAndAwe.db.char.DWPercent ,-1)
		if DWTime < GetTime() then
			self.frames["DeathWish"]:Hide()
			self.frames["DeathWish"].icon:Hide()
			updateActiveDeathWish = false
		end
	end
	
	if updateActiveRecklessness then
		OBU.timeLeft = RETime - GetTime()
		self.frames["Recklessness"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Recklessness"].spark:SetPoint("CENTER",self.frames["Recklessness"].statusbar,"LEFT", OBU.timeLeft/REMax * OBU.width * SlamAndAwe.db.char.REPercent ,-1)
		if RETime < GetTime() then
			self.frames["Recklessness"]:Hide()
			self.frames["Recklessness"].icon:Hide()
			updateActiveRecklessness = false
		end
	end

	if SlamAndAwe.db.char.priority.show and not SlamAndAwe.db.char.disabled then
		if SlamAndAwe.db.char.priority.showinterrupt and self.PriorityFrame.interrupt then
			OBU.EnemySpell, _, _, OBU.EnemySpellIcon = UnitCastingInfo("target")
			if not OBU.EnemySpell then
				OBU.EnemySpellIcon = "Interface/Tooltips/UI-Tooltip-Background"
			end
			local nStance = GetShapeshiftForm();
			if self:SpellAvailable(SlamAndAwe.constants["Pummel"]) and nStance ~= 2 then
				self:SetSubFrameBackdrop(self.PriorityFrame.interrupt.frame, OBU.EnemySpellIcon, 4)
				self.PriorityFrame.interrupt.frame:SetBackdropBorderColor(1, 1, 1, 1);
			else
				self:SetSubFrameBackdrop(self.PriorityFrame.interrupt.frame, OBU.EnemySpellIcon, 20)
				self.PriorityFrame.interrupt.frame:SetBackdropBorderColor(1, 0, 0, 1); -- set border colour to Red if Pummel not available
			end
			if not OBU.EnemySpell then
				self.PriorityFrame.interrupt.frame:SetBackdropColor(0, 0, 0, 0);
			end
		end
		if SlamAndAwe.db.char.priority.showpurge and self.PriorityFrame.purge then
			OBU.purgeable = self:CheckPurgeableBuff()
			if OBU.purgeable and not SlamAndAwe.db.char.priority.purgeiconset then
				SlamAndAwe.db.char.priority.purgeiconset = true
				self:SetSubFrameBackdrop(self.PriorityFrame.purge.frame, SlamAndAwe.constants["Heroic Strike"], 4)
			elseif not OBU.purgeable and SlamAndAwe.db.char.priority.purgeiconset then
				SlamAndAwe.db.char.priority.purgeiconset = false
				self:SetSubFrameBackdrop(self.PriorityFrame.purge.frame, "Interface/Tooltips/UI-Tooltip-Background", 4)
				self.PriorityFrame.purge.frame:SetBackdropColor(0, 0, 0, 0);
			end
		end
	end
end

function SlamAndAwe:CreateMsgFrame()
	self.msgFrame:ClearAllPoints()
	self.msgFrame:SetWidth(400)
	self.msgFrame:SetHeight(75)
	self.msgFrame:SetFrameStrata("BACKGROUND")
	self.msgFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	self.msgFrame:SetBackdropColor(1, 1, 1, 0)
	self.msgFrame:SetMovable(true)
	self.msgFrame:RegisterForDrag("LeftButton")
	self.msgFrame:SetScript("OnDragStart", 
		function()
			self.msgFrame:StartMoving();
		end );
	self.msgFrame:SetScript("OnDragStop",
		function()
			self.msgFrame:StopMovingOrSizing();
			self.msgFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(SlamAndAwe.db.char.warning, self.msgFrame);
		end );
	self.msgFrame:SetPoint(SlamAndAwe.db.char.warning.point, SlamAndAwe.db.char.warning.relativeTo, SlamAndAwe.db.char.warning.relativePoint, SlamAndAwe.db.char.warning.xOffset, SlamAndAwe.db.char.warning.yOffset)
	self.msgFrame:SetInsertMode("TOP")
	self.msgFrame:SetFrameStrata("HIGH")
	self.msgFrame:SetToplevel(true)
	local font = media:Fetch("font", SlamAndAwe.db.char.msgfont)
	self.msgFrame:SetFont(font, SlamAndAwe.db.char.msgfontsize, SlamAndAwe.db.char.msgfonteffect)
		
	self.msgFrame:Show()
end

function SlamAndAwe:PrintMsg(msg, col, time)
	if SlamAndAwe.db.char.warning.show and not SlamAndAwe.db.char.disabled then
		if col == nil then
			col = { r=1, b=1, g=1, a=1 }
		end
		if time == nil then 
			time = 3
		end
		if time ~= 5 then
			self.msgFrame:SetTimeVisible(time)
		end
		self.msgFrame:AddMessage(msg, col.r, col.g, col.b, 1, col.time)
	end
end

function SlamAndAwe:DebugPrint(msg)
	if SlamAndAwe.db.char.debug then
		self:Print(msg)
	end
end