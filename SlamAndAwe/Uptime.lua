-- @release $Id: Uptime.lua 5 2011-01-25 14:05:53Z reighnman $

if not SlamAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local C = SlamAndAwe.constants -- Defined in Constants.LUA no locale needed.

SlamAndAwe.UptimeFrame = CreateFrame("Frame", "SAA_UptimeFrame", UIParent)

---------------------------
-- Uptime functions
---------------------------

function SlamAndAwe:InitialiseUptime()
	SlamAndAwe.uptime = {}
	SlamAndAwe.uptime = {
		session = {},
		lastfight = {},
		incombat = false,
		TimerEvent = nil,
		currentTime = nil,
	}
	self:InitialiseUptimeBuffs(SlamAndAwe.uptime.session)
	self:InitialiseUptimeBuffs(SlamAndAwe.uptime.lastfight)
end

function SlamAndAwe:InitialiseUptimeBuffs(timeframe)
	timeframe.totalTime = 0
	if not timeframe.buffs then
		timeframe.buffs = {}
	end
	if not timeframe.buffs[SlamAndAwe.constants["Enrage"]] then
		timeframe.buffs[SlamAndAwe.constants["Enrage"]] = {}
		timeframe.buffs[SlamAndAwe.constants["Enrage"]].name = SlamAndAwe.constants["Enrage"]
		timeframe.buffs[SlamAndAwe.constants["Enrage"]].icon = SlamAndAwe.constants["Enrage Icon"]
	end
	if not timeframe.buffs[SlamAndAwe.constants["Flurry"]] then
		timeframe.buffs[SlamAndAwe.constants["Flurry"]] = {}
		timeframe.buffs[SlamAndAwe.constants["Flurry"]].name = SlamAndAwe.constants["Flurry"]
		timeframe.buffs[SlamAndAwe.constants["Flurry"]].icon = SlamAndAwe.constants["Flurry Icon"]
	end
	timeframe.buffs[SlamAndAwe.constants["Enrage"]].uptime = 0
	timeframe.buffs[SlamAndAwe.constants["Flurry"]].uptime = 0
end

function SlamAndAwe:UpdateUptime()
	if not SlamAndAwe.uptime.incombat then
		return
	end
	local currentTime = GetTime()
	-- add conditional safety measure - we should never have no current time but to be sure...
	if  not SlamAndAwe.uptime.currentTime then
		SlamAndAwe.uptime.currentTime = currentTime
	end
	local diffTime = currentTime - SlamAndAwe.uptime.currentTime
	
	SlamAndAwe.uptime.session.totalTime = SlamAndAwe.uptime.session.totalTime + diffTime;
	SlamAndAwe.uptime.lastfight.totalTime = SlamAndAwe.uptime.lastfight.totalTime + diffTime;
	
	local i = 1
	local buff = UnitBuff("player", i)
	while buff do
		if SlamAndAwe.uptime.session.buffs[buff] then
			SlamAndAwe.uptime.session.buffs[buff].uptime = SlamAndAwe.uptime.session.buffs[buff].uptime + diffTime
		end
		if SlamAndAwe.uptime.lastfight.buffs[buff] then
			SlamAndAwe.uptime.lastfight.buffs[buff].uptime = SlamAndAwe.uptime.lastfight.buffs[buff].uptime + diffTime
		end		
		i = i + 1
		buff = UnitBuff("player", i)
	end	
	SlamAndAwe.uptime.currentTime = currentTime
	self:UpdateUptimeFrames(false)
end

function SlamAndAwe:CreateUptimeFrame()
	SlamAndAwe.UptimeFrame:ClearAllPoints()
	SlamAndAwe.UptimeFrame:SetScale(SlamAndAwe.db.char.uptime.scale)
	SlamAndAwe.UptimeFrame:SetFrameStrata("BACKGROUND")
	SlamAndAwe.UptimeFrame:SetWidth(SlamAndAwe.db.char.uptime.fWidth + SlamAndAwe.db.char.uptime.barHeight)
	SlamAndAwe.UptimeFrame:SetHeight(SlamAndAwe.db.char.uptime.fHeight + 16)
	SlamAndAwe.UptimeFrame:SetBackdrop(self.frameBackdrop)
	SlamAndAwe.UptimeFrame:SetBackdropColor(0, 0, 0, SlamAndAwe.db.char.uptime.alpha)
	SlamAndAwe.UptimeFrame:SetMovable(true)
	SlamAndAwe.UptimeFrame:RegisterForDrag("LeftButton")
	SlamAndAwe.UptimeFrame:SetPoint(SlamAndAwe.db.char.uptime.point, SlamAndAwe.db.char.uptime.relativeTo, SlamAndAwe.db.char.uptime.relativePoint, SlamAndAwe.db.char.uptime.xOffset, SlamAndAwe.db.char.uptime.yOffset)
	SlamAndAwe.UptimeFrame:SetScript("OnDragStart", 
		function()
			SlamAndAwe.UptimeFrame:StartMoving();
		end );
	SlamAndAwe.UptimeFrame:SetScript("OnDragStop",
		function()
			SlamAndAwe.UptimeFrame:StopMovingOrSizing();
			SlamAndAwe.UptimeFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(SlamAndAwe.db.char.uptime, SlamAndAwe.UptimeFrame);
		end );
	
	local barfont = media:Fetch("font", SlamAndAwe.db.char.barfont)
	if not SlamAndAwe.UptimeFrame.topText then
		SlamAndAwe.UptimeFrame.topText = SlamAndAwe.UptimeFrame:CreateFontString(nil, "OVERLAY")
	end
	SlamAndAwe.UptimeFrame.topText:SetTextColor(1,1,1,1)
	SlamAndAwe.UptimeFrame.topText:SetFont(barfont, SlamAndAwe.db.char.barfontsize, SlamAndAwe.db.char.barfonteffect)
	SlamAndAwe.UptimeFrame.topText:SetPoint("TOP", SlamAndAwe.UptimeFrame, "TOP", 0, - 2)
	SlamAndAwe.UptimeFrame.topText:SetText(L["uptime_session"])
	
	if not SlamAndAwe.UptimeFrame.ResetButton then
		SlamAndAwe.UptimeFrame.ResetButton=CreateFrame("Button", nil, SlamAndAwe.UptimeFrame)
	end
	local size = SlamAndAwe.UptimeFrame.topText:GetHeight()
	SlamAndAwe.UptimeFrame.ResetButton:SetNormalTexture("Interface\\Addons\\SlamAndAwe\\textures\\icon-reset")
	SlamAndAwe.UptimeFrame.ResetButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	SlamAndAwe.UptimeFrame.ResetButton:SetWidth(size)
	SlamAndAwe.UptimeFrame.ResetButton:SetHeight(size)
	SlamAndAwe.UptimeFrame.ResetButton:SetPoint("TOPRIGHT", SlamAndAwe.UptimeFrame.topText, "TOPLEFT", -5, 0)
	SlamAndAwe.UptimeFrame.ResetButton:SetScript("OnClick",function() SlamAndAwe:ResetUptimeValues() end)
	SlamAndAwe.UptimeFrame.ResetButton:SetFrameLevel(SlamAndAwe.UptimeFrame.ResetButton:GetFrameLevel()+1)
	SlamAndAwe.UptimeFrame.ResetButton:SetScript("OnEnter", function() UptimeResetButtonTooltip() end);
	SlamAndAwe.UptimeFrame.ResetButton:SetScript("OnLeave", function() GameTooltip:Hide() end);


	local baseOffset = (-1 * SlamAndAwe.db.char.uptime.fHeight / 6) - 2 -- 6 bars + top line + middle line 
	if not SlamAndAwe.UptimeFrame.middleText then
		SlamAndAwe.UptimeFrame.middleText = SlamAndAwe.UptimeFrame:CreateFontString(nil, "OVERLAY")
	end
	SlamAndAwe.UptimeFrame.middleText:SetTextColor(1,1,1,1)
	SlamAndAwe.UptimeFrame.middleText:SetFont(barfont, SlamAndAwe.db.char.barfontsize, SlamAndAwe.db.char.barfonteffect)
	SlamAndAwe.UptimeFrame.middleText:SetPoint("TOP", SlamAndAwe.UptimeFrame, "TOP", 0, 3 * baseOffset - 2)
	SlamAndAwe.UptimeFrame.middleText:SetText(L["uptime_lastfight"])
	if SlamAndAwe.db.char.uptime.show then
		SlamAndAwe.UptimeFrame:Show()
	else
		SlamAndAwe.UptimeFrame:Hide()
	end
	local session = SlamAndAwe.uptime.session
	local lastfight = SlamAndAwe.uptime.lastfight
	
	self:CreateUptimeBarFrame(session.buffs[SlamAndAwe.constants["Flurry"]], SlamAndAwe.db.char.uptime.flurry, baseOffset)
	self:CreateUptimeBarFrame(session.buffs[SlamAndAwe.constants["Enrage"]], SlamAndAwe.db.char.uptime.en, 2 * baseOffset)
	
	self:CreateUptimeBarFrame(lastfight.buffs[SlamAndAwe.constants["Flurry"]], SlamAndAwe.db.char.uptime.flurry, 4 * baseOffset)
	self:CreateUptimeBarFrame(lastfight.buffs[SlamAndAwe.constants["Enrage"]], SlamAndAwe.db.char.uptime.en, 5 * baseOffset)
end

function SlamAndAwe:CreateUptimeBarFrame(buff, buffColours, frameOffset)
	if not buff.barFrame then
		buff.barFrame = CreateFrame("Frame", nil, SlamAndAwe.UptimeFrame)
	end
	buff.barFrame:SetFrameStrata("LOW")
	buff.barFrame:SetWidth(SlamAndAwe.db.char.uptime.barWidth + SlamAndAwe.db.char.uptime.barHeight)
	buff.barFrame:SetHeight(SlamAndAwe.db.char.uptime.barHeight)
	buff.barFrame:ClearAllPoints()
	buff.barFrame:SetPoint("TOPLEFT", SlamAndAwe.UptimeFrame, "TOPLEFT", SlamAndAwe.db.char.uptime.barHeight, frameOffset)
	buff.barFrame:SetScript("OnUpdate", function() self:UpdateUptimeFrames(false); end );
	
	if not buff.barFrame.buffIcon then
		buff.barFrame.buffIcon = CreateFrame("Frame", nil, buff.barFrame)
	end
	buff.barFrame.buffIcon:SetWidth(SlamAndAwe.db.char.uptime.barHeight)
	buff.barFrame.buffIcon:SetHeight(SlamAndAwe.db.char.uptime.barHeight)
	buff.barFrame.buffIcon:SetBackdrop({ bgFile = buff.icon })
	buff.barFrame.buffIcon:SetPoint("TOPRIGHT", buff.barFrame, "TOPLEFT", 12, 0)
	
	if not buff.barFrame.statusbar then
		buff.barFrame.statusbar = CreateFrame("StatusBar", nil, buff.barFrame, "TextStatusBar")
	end
	buff.barFrame.statusbar:ClearAllPoints()
	buff.barFrame.statusbar:SetHeight(SlamAndAwe.db.char.uptime.barHeight)
	buff.barFrame.statusbar:SetWidth(SlamAndAwe.db.char.uptime.barWidth)
	buff.barFrame.statusbar:SetPoint("RIGHT", buff.barFrame, "RIGHT")
	buff.barFrame.statusbar:SetStatusBarTexture(media:Fetch("statusbar", SlamAndAwe.db.char.texture))
	buff.barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
	buff.barFrame.statusbar:SetMinMaxValues(0,1)
	buff.barFrame.statusbar:SetValue(0)
	
	local barfont = media:Fetch("font", SlamAndAwe.db.char.barfont)
	if not buff.barFrame.statusbar.leftText then
		buff.barFrame.statusbar.leftText = buff.barFrame.statusbar:CreateFontString(nil, "OVERLAY")
	end
	buff.barFrame.statusbar.leftText:SetTextColor(1,1,1,1)
	buff.barFrame.statusbar.leftText:SetFont(barfont, SlamAndAwe.db.char.barfontsize, SlamAndAwe.db.char.barfonteffect)
	buff.barFrame.statusbar.leftText:SetPoint("TOPLEFT", buff.barFrame.statusbar, "TOPLEFT")
	buff.barFrame.statusbar.leftText:SetText("0.0s")
	
	if not buff.barFrame.statusbar.rightText then
		buff.barFrame.statusbar.rightText = buff.barFrame.statusbar:CreateFontString(nil, "OVERLAY")
	end
	buff.barFrame.statusbar.rightText:SetTextColor(1,1,1,1)
	buff.barFrame.statusbar.rightText:SetFont(barfont, SlamAndAwe.db.char.barfontsize, SlamAndAwe.db.char.barfonteffect)
	buff.barFrame.statusbar.rightText:SetPoint("TOPRIGHT", buff.barFrame.statusbar, "TOPRIGHT")
	buff.barFrame.statusbar.rightText:SetText("0%")
	
	buff.barFrame.statusbar:SetScript("OnEnter", function() UptimeStatusBarTooltip(buff) end);
	buff.barFrame.statusbar:SetScript("OnLeave", function() GameTooltip:Hide() end);
	buff.barFrame.buffIcon:SetScript("OnEnter", function() UptimeStatusBarTooltip(buff) end);
	buff.barFrame.buffIcon:SetScript("OnLeave", function() GameTooltip:Hide() end);
end

function UptimeStatusBarTooltip(buff)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(buff.barFrame, "ANCHOR_BOTTOMLEFT");
		GameTooltip:AddLine(buff.name)
		GameTooltip:AddTexture(buff.icon)
		GameTooltip:AddLine((L["Uptime is %s (%s)"]):format(
				buff.barFrame.statusbar.leftText:GetText(),
				buff.barFrame.statusbar.rightText:GetText()
			))
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end

function UptimeResetButtonTooltip()
	if not InCombatLockdown() then
		GameTooltip:SetOwner(SlamAndAwe.UptimeFrame.ResetButton, "ANCHOR_BOTTOMLEFT");
		GameTooltip:AddLine(L["Reset Session statistics"])
		GameTooltip:Show()
	else
		GameTooltip:Hide()
		
	end
end

function SlamAndAwe:UpdateUptimeFrames(forceUpdate)
	if InCombatLockdown() or forceUpdate then
		local session = SlamAndAwe.uptime.session
		local lastfight = SlamAndAwe.uptime.lastfight
		session.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar.leftText:SetText(self:DurationString(session.buffs[SlamAndAwe.constants["Flurry"]].uptime))
		session.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar.leftText:SetText(self:DurationString(session.buffs[SlamAndAwe.constants["Enrage"]].uptime))
  	lastfight.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar.leftText:SetText(self:DurationString(lastfight.buffs[SlamAndAwe.constants["Flurry"]].uptime))
		lastfight.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar.leftText:SetText(self:DurationString(lastfight.buffs[SlamAndAwe.constants["Enrage"]].uptime))

		local percent
		if session.totalTime == 0 then
			session.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(0)
			session.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText("0%")
			session.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar:SetValue(0)
			session.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar.rightText:SetText("0%")
		else
			percent = session.buffs[SlamAndAwe.constants["Flurry"]].uptime / session.totalTime
			session.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(percent)
			session.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText((("%d"):format(percent * 100)) .. "%")
		
			percent = session.buffs[SlamAndAwe.constants["Enrage"]].uptime / session.totalTime
			session.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar:SetValue(percent)
			session.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar.rightText:SetText((("%d"):format(percent * 100)) .. "%")
		end

		if lastfight.totalTime == 0 then
			lastfight.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(0)
			lastfight.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText("0%")
			lastfight.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar:SetValue(0)
			lastfight.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar.rightText:SetText("0%")
		else
			percent = lastfight.buffs[SlamAndAwe.constants["Flurry"]].uptime / lastfight.totalTime
			lastfight.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar:SetValue(percent)
			lastfight.buffs[SlamAndAwe.constants["Flurry"]].barFrame.statusbar.rightText:SetText((("%d"):format(percent * 100)) .. "%")
			
			percent = lastfight.buffs[SlamAndAwe.constants["Enrage"]].uptime / lastfight.totalTime
			lastfight.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar:SetValue(percent)
			lastfight.buffs[SlamAndAwe.constants["Enrage"]].barFrame.statusbar.rightText:SetText((("%d"):format(percent * 100)) .. "%")
		end
	end
end

function SlamAndAwe:ResetUptime()
	SlamAndAwe.UptimeFrame:ClearAllPoints()
	SlamAndAwe.db.char.uptime.point = self.defaults.char.uptime.point
	SlamAndAwe.db.char.uptime.relativeTo = self.defaults.char.uptime.relativeTo 
	SlamAndAwe.db.char.uptime.relativePoint = self.defaults.char.uptime.relativePoint
	SlamAndAwe.db.char.uptime.xOffset = self.defaults.char.uptime.xOffset
	SlamAndAwe.db.char.uptime.yOffset = self.defaults.char.uptime.yOffset
	SlamAndAwe.db.char.uptime.fWidth = self.defaults.char.uptime.fWidth
	SlamAndAwe.db.char.uptime.fHeight = self.defaults.char.uptime.fHeight
	SlamAndAwe.db.char.uptime.scale = self.defaults.char.uptime.scale
	self:CreateUptimeFrame()
	self:Print(L["uptime_reset"])
end

function SlamAndAwe:ResetUptimeValues()
	self:InitialiseUptimeBuffs(SlamAndAwe.uptime.session)
	self:InitialiseUptimeBuffs(SlamAndAwe.uptime.lastfight)
	self:UpdateUptimeFrames(true)
end