-- @release $Id: Stats.lua 5 2011-01-25 14:05:53Z reighnman $

if not SlamAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local C = SlamAndAwe.constants -- Defined in Constants.LUA no locale needed.
if not C then 
	SlamAndAwe:SetConstants()
end

SlamAndAwe.StatsFrame = CreateFrame("Frame", "SAA_StatsFrame", UIParent)

---------------------------
-- Local Variables
---------------------------

SlamAndAwe.combat = {}
SlamAndAwe.combat.ss_mh = 32175
SlamAndAwe.combat.ss_oh = 32176
SlamAndAwe.combat.wf_mh = 25504
SlamAndAwe.combat.wf_oh = 33750

local TopScoreFu = TopScoreFu
local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER or 0x00000400
local COMBATLOG_OBJECT_CONTROL_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER or 0x00000100
local COMBATLOG_FILTER_PVP = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER)
local bit_band = bit.band

function SlamAndAwe:InitialiseTopScoreFu()
	if TopScoreFu then
		if not TopScoreFu.db.char.hits[C["Stormstrike"]] then
			TopScoreFu.db.char.hits[C["Stormstrike"]] = {
				crit = {},
				critPvP = {},
				normal = {},
				normalPvP = {},
				isHeal = isHeal,
			}
		end
		if not TopScoreFu.db.char.hits[C["Windfury Attack"]] then
			TopScoreFu.db.char.hits[C["Windfury Attack"]] = {
				crit = {},
				critPvP = {},
				normal = {},
				normalPvP = {},
				isHeal = isHeal,
			}
		end
	end
end

---------------------------
-- Stats Frame functions
---------------------------

function SlamAndAwe:CreateStatsFrame()
	self.StatsFrame:SetScale(self.db.char.stats.scale)
	self.StatsFrame:SetFrameStrata("BACKGROUND")
	self.StatsFrame:SetWidth(self.db.char.stats.fWidth + self.db.char.stats.barHeight)
	self.StatsFrame:SetHeight(self.db.char.stats.fHeight)
	self.StatsFrame:SetBackdrop(self.frameBackdrop)
	self.StatsFrame:SetBackdropColor(0, 0, 0, self.db.char.stats.alpha);
	self.StatsFrame:SetMovable(true);
	self.StatsFrame:RegisterForDrag("LeftButton");
	self.StatsFrame:SetPoint(self.db.char.stats.point, self.db.char.stats.relativeTo, self.db.char.stats.relativePoint, self.db.char.stats.xOffset, self.db.char.stats.yOffset)
	self.StatsFrame:SetScript("OnDragStart", 
		function()
			self.StatsFrame:StartMoving();
		end );
	self.StatsFrame:SetScript("OnDragStop",
		function()
			self.StatsFrame:StopMovingOrSizing();
			self.StatsFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(self.db.char.stats, self.StatsFrame);
		end );
	
	if not self.StatsFrame.topText then
		self.StatsFrame.topText = self.StatsFrame:CreateFontString(nil, "OVERLAY")
	end
	self.StatsFrame.topText:SetTextColor(1,1,1,1)
	self.StatsFrame.topText:SetFont(media:Fetch("font", self.db.char.barfont), self.db.char.barfontsize, self.db.char.barfonteffect)
	self.StatsFrame.topText:SetPoint("TOP", self.StatsFrame, "TOP")
	self.StatsFrame.topText:SetText(L["stats_session"])
	
	local baseOffset = (-1 * self.db.char.stats.fHeight / 8) -- 6 bars + top line + middle line 
	if not self.StatsFrame.middleText then
		self.StatsFrame.middleText = self.StatsFrame:CreateFontString(nil, "OVERLAY")
	end
	self.StatsFrame.middleText:SetTextColor(1,1,1,1)
	self.StatsFrame.middleText:SetFont(media:Fetch("font", self.db.char.barfont), self.db.char.barfontsize, self.db.char.barfonteffect)
	self.StatsFrame.middleText:SetPoint("TOP", self.StatsFrame, "TOP", 0, 4 * baseOffset)
	self.StatsFrame.middleText:SetText(L["stats_lastfight"])
	if self.db.char.stats.show then
		self.StatsFrame:Show()
	else
		self.StatsFrame:Hide()
	end
end

---------------------------
-- Stats functions
---------------------------

local wf_cnt = 0
local wf_miss = 0
local wf_dmg = 0
local wf_crit = 0
local wf_hand = "mh"

function SlamAndAwe:WFCalc(id, damage, crit, event, dstName, dstFlags, unitid)
	-- Melee + MH Stormstrike
	if crit == nil then
		crit = 0
	end
	if damage == nil then
		damage = 0
	end
	if event == nil then
		event = "unset"
	end
	if id == nil then
		id = "unknown"
	end
	if id == "melee" or id == self.combat.ss_mh then
		wf_cnt = 0
		if event == "SWING_MISSED" or event == "SPELL_MISSED" then
			wf_miss = 1
			wf_dmg = 0
			wf_crit = 0
		else
			wf_miss = 0
			wf_dmg = damage
			if crit == 1 then
				wf_crit = 1
			else
				wf_crit = 0
			end
		end

	-- OH Stormstrike or Windfury
	elseif id == self.combat.ss_oh or id == self.combat.wf_mh or id == self.combat.wf_oh then
		if id ~= self.combat.ss_oh then
			wf_cnt = wf_cnt + 1
			if id == self.combat.wf_mh then
				wf_hand = "mh"
			elseif id == self.combat.wf_oh then
				wf_hand = "oh"
			end 
		end
		if event == "SWING_MISSED" or event == "SPELL_MISSED" then
			wf_miss = wf_miss + 1
		else
			wf_dmg = wf_dmg + damage
			if crit == 1 then
				wf_crit = wf_crit + 1
			end
		end
	end
	if wf_cnt == 2 then
		self:WFOutput()
		-- report total to TopScoreFu if installed
--~ 		if TopScoreFu then
--~ 			self:InitialiseTopScoreFu() -- force SAA entries to appear in TopScoreFu Spell list if don't exist
--~ 			local critical = crit > 0
--~ 			local pvp = bit_band(dstFlags, COMBATLOG_FILTER_PVP) == COMBATLOG_FILTER_PVP

--~ 			if id == self.combat.ss_mh or id == self.combat.ss_oh then
--~ 				TopScoreFu:RecordHit(C["Stormstrike"], wf_dmg, dstName, unitid, critical, false, pvp)
--~ 			elseif id == self.combat.wf_mh or id == self.combat.wf_oh then
--~ 				TopScoreFu:RecordHit(C["Windfury Attack"], wf_dmg, dstName, unitid, critical, false, pvp)
--~ 			end
--~ 		end
	end
end

function SlamAndAwe:WFOutput()
	local wf_str = ""
	if wf_hand == "mh" then
		wf_str = L["MH Windfury"]
	elseif wf_hand == "oh" then
		wf_str = L["OH Windfury"]
	end
	
	if wf_crit == 0 then
		wf_str = wf_str 
	elseif wf_crit == 1 then
		wf_str = wf_str .. " " .. L["Single crit"]
	elseif wf_crit == 2 then
		wf_str = wf_str .. " " .. L["DOUBLE crit"]
	elseif wf_crit == 3 then
		wf_str = wf_str .. " " .. L["TRIPLE crit"]
	elseif wf_crit ==4 then
		wf_str = wf_str .. " " .. L["QUADRUPLE crit"]
	else
		wf_str = wf_str .. " " .. wf_crit .. " crit"
	end
	wf_str = wf_str .. ": ".. wf_dmg
	if wf_miss > 0 then
		wf_str = wf_str .. " (" .. wf_miss .. " " .. L["miss"] .. ")"
	end
	if SCT then -- use Scrolling Combat Text if installed.
		if wf_crit > 0 then
			SCT:DisplayText(wf_str, self.db.char.stats.wfcol, 1, "event", 1)
		else
			SCT:DisplayText(wf_str, self.db.char.stats.wfcol, 0, "event", 1)
		end
	elseif MikSBT and self.db.char.MSBToutputarea then
		MikSBT.DisplayMessage(wf_str)
	else
		local col = self.db.char.stats.wfcol
		self:PrintMsg(wf_str, col, 5)
	end
	wf_cnt = 0
	wf_miss = 0
	wf_crit = 0
	wf_dmg = 0
end