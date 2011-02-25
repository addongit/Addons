-- Set Global Table
if not ThreatPlatesWidgets then ThreatPlatesWidgets = {} end
local Media = LibStub("LibSharedMedia-3.0")
local db

-- Name Text
--[[
local function NameUpdate(frame, unit)
	db = TidyPlatesThreat.db.profile.settings
	local c = db.name.color
	frame:SetText(unit.name)
	frame:SetFont((Media:Fetch('font', db.name.typeface)), db.name.size, db.name.flags)
	frame:SetJustifyH(db.name.align)
	frame:SetJustifyV(db.name.vertical)
	frame:SetWidth(db.name.width)
	frame:SetHeight(db.name.height)
	frame:SetTextColor(c.r, c.g, c.b)
	frame:SetShadowOffset(1, -1)
	if db.name.shadow then 
		frame:SetShadowColor(0,0,0,1)
	else 
		frame:SetShadowColor(0,0,0,0) 
	end	
	frame:Show()
end

local function CreateNameText(frame)
	db = TidyPlatesThreat.db.profile.settings
	local text = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
	text:SetText(nil)
	text:SetJustifyH(db.name.align)
	text:SetJustifyV(db.name.vertical)
	text:SetTextColor(1, 1, 1, 1)
	text:SetWidth(db.name.width)
	text:SetHeight(db.name.height)
	text:SetFont(Media:Fetch('font', db.name.typeface), db.name.size, db.name.flags)
	text:SetPoint("CENTER",frame,"CENTER", db.name.x, db.name.y)
	text:SetShadowOffset(1, -1)
	text.Update = NameUpdate
	if db.name.shadow then text:SetShadowColor(0,0,0,1)
	else text:SetShadowColor(0,0,0,0) end
	return text
end]]--

--DebuffFilterFunction
local function DebuffFilter(debuff)
	db = TidyPlatesThreat.db.profile.debuffWidget
	local spells = db.filter
	if db.mode == "whitelist" then
		if tContains(spells, (debuff.name)) then 
			return true 
		end
	elseif db.mode == "blacklist" then
		if tContains(spells, (debuff.name)) then
			return false
		else
			return true
		end
	elseif db.mode == "whitelistMine" then
		if tContains(spells, (debuff.name)) and debuff.caster == UnitGUID("Player") then
			return true
		end
	elseif db.mode == "blacklistMine" then
		if debuff.caster == UnitGUID("Player") then
			if tContains(spells, (debuff.name)) then
				return false
			else
				return true
			end
		end
	elseif db.mode == "allMine" then
		if debuff.caster == UnitGUID("Player") then
			return true
		end
	elseif db.mode == "all" then
		return true
	end
end


local function OnInitialize(plate)
	if not plate.widgets.WidgetDebuff then
		plate.widgets.WidgetDebuff = TidyPlatesWidgets.CreateAuraWidget(plate)
		plate.widgets.WidgetDebuff:SetPoint("CENTER", plate, TidyPlatesThreat.db.profile.debuffWidget.x, TidyPlatesThreat.db.profile.debuffWidget.y)
		plate.widgets.WidgetDebuff:SetFrameLevel(plate:GetFrameLevel())
		plate.widgets.WidgetDebuff.Filter = DebuffFilter
	end
	
	if not plate.widgets.TankedWidget then
		plate.widgets.TankedWidget = TidyPlatesWidgets.CreateTankedWidget(plate)		
		plate.widgets.TankedWidget:SetPoint("CENTER", plate, TidyPlatesThreat.db.profile.tankedWidget.x, TidyPlatesThreat.db.profile.tankedWidget.y)
	end
end

local function OnContextUpdate(plate, unit)
	if TidyPlatesThreat.db.profile.debuffWidget.ON then
		if not plate.widgets.WidgetDebuff then plate.widgets.WidgetDebuff = TidyPlatesWidgets.CreateAuraWidget(plate) end
		plate.widgets.WidgetDebuff:SetPoint("CENTER", plate, TidyPlatesThreat.db.profile.debuffWidget.x, TidyPlatesThreat.db.profile.debuffWidget.y)
		plate.widgets.WidgetDebuff:UpdateContext(unit)
	end	
end

local function OnUpdate(plate, unit)
	db = TidyPlatesThreat.db.profile.settings
	-- Target Art
	if not plate.widgets.TargetArt then plate.widgets.TargetArt = ThreatPlatesWidgets.CreateTargetFrameArt(plate) end
	plate.widgets.TargetArt:SetFrameLevel(TidyPlatesThreat.db.profile.targetWidget.level)
	plate.widgets.TargetArt:Update(unit)
	plate.widgets.TargetArt:SetPoint("CENTER", plate, 0, 0)
	-- Elite Texture
	if not plate.widgets.EliteArt then plate.widgets.EliteArt = ThreatPlatesWidgets.CreateEliteFrameArt(plate) end
	plate.widgets.EliteArt:SetFrameLevel(TidyPlatesThreat.db.profile.eliteWidget.level)
	plate.widgets.EliteArt:SetHeight(TidyPlatesThreat.db.profile.eliteWidget.scale)
	plate.widgets.EliteArt:SetWidth(TidyPlatesThreat.db.profile.eliteWidget.scale)
	plate.widgets.EliteArt:SetPoint("CENTER",plate,(TidyPlatesThreat.db.profile.eliteWidget.anchor), (TidyPlatesThreat.db.profile.eliteWidget.x), (TidyPlatesThreat.db.profile.eliteWidget.y))
	plate.widgets.EliteArt:Update(unit)
	if not plate.widgets.SocialArt then plate.widgets.SocialArt = ThreatPlatesWidgets.CreateSocialWidget(plate) end
	plate.widgets.SocialArt:SetFrameLevel(TidyPlatesThreat.db.profile.socialWidget.level)
	plate.widgets.SocialArt:SetHeight(TidyPlatesThreat.db.profile.socialWidget.scale)
	plate.widgets.SocialArt:SetWidth(TidyPlatesThreat.db.profile.socialWidget.scale)
	plate.widgets.SocialArt:SetPoint("CENTER",plate,TidyPlatesThreat.db.profile.socialWidget.anchor, TidyPlatesThreat.db.profile.socialWidget.x, TidyPlatesThreat.db.profile.socialWidget.y)
	plate.widgets.SocialArt:Update(unit)	
	-- Name Text
	--[[if db.options.showName then
		if not plate.widgets.NameText then plate.widgets.NameText = CreateNameText(plate) end
		plate.widgets.NameText:SetPoint("CENTER", plate, "CENTER", db.name.x, db.name.y)		
		plate.widgets.NameText:Update(unit)
	else
	end]]--
	-- Class Icons
	if not plate.widgets.ClassIconWidget then plate.widgets.ClassIconWidget = ThreatPlatesWidgets.CreateClassIconWidget(plate) end
		plate.widgets.ClassIconWidget:Update(unit)
		plate.widgets.ClassIconWidget:SetHeight(TidyPlatesThreat.db.profile.classWidget.scale)
		plate.widgets.ClassIconWidget:SetWidth(TidyPlatesThreat.db.profile.classWidget.scale)		
		plate.widgets.ClassIconWidget:SetPoint((TidyPlatesThreat.db.profile.classWidget.anchor), plate, (TidyPlatesThreat.db.profile.classWidget.x), (TidyPlatesThreat.db.profile.classWidget.y))
	-- Totem Icons
	if not plate.widgets.TotemIconWidget then plate.widgets.TotemIconWidget = ThreatPlatesWidgets.CreateTotemIconWidget(plate) end
		plate.widgets.TotemIconWidget:Update(unit)
		plate.widgets.TotemIconWidget:SetHeight(TidyPlatesThreat.db.profile.totemWidget.scale)
		plate.widgets.TotemIconWidget:SetWidth(TidyPlatesThreat.db.profile.totemWidget.scale)
		plate.widgets.TotemIconWidget:SetFrameLevel(TidyPlatesThreat.db.profile.totemWidget.level)
		plate.widgets.TotemIconWidget:SetPoint(TidyPlatesThreat.db.profile.totemWidget.anchor, plate, (TidyPlatesThreat.db.profile.totemWidget.x), (TidyPlatesThreat.db.profile.totemWidget.y))
	-- Unique Icons
	if not plate.widgets.UniqueIconWidget then plate.widgets.UniqueIconWidget = ThreatPlatesWidgets.CreateUniqueIconWidget(plate) end
		plate.widgets.UniqueIconWidget:Update(unit)
		plate.widgets.UniqueIconWidget:SetHeight(TidyPlatesThreat.db.profile.uniqueWidget.scale)
		plate.widgets.UniqueIconWidget:SetWidth(TidyPlatesThreat.db.profile.uniqueWidget.scale)
		plate.widgets.UniqueIconWidget:SetFrameLevel(TidyPlatesThreat.db.profile.uniqueWidget.level)
		plate.widgets.UniqueIconWidget:SetPoint(TidyPlatesThreat.db.profile.uniqueWidget.anchor, plate, (TidyPlatesThreat.db.profile.uniqueWidget.x), (TidyPlatesThreat.db.profile.uniqueWidget.y))
	-- Threat Widget
	if TidyPlatesThreat.db.profile.threat.ON then 
		if not plate.widgets.threatWidget then plate.widgets.threatWidget = ThreatPlatesWidgets.CreateThreatWidget(plate) end
		plate.widgets.threatWidget:Update(unit)
		plate.widgets.threatWidget:SetPoint("CENTER", plate, 0, 0)
	end
	--Threat Line Widget
	if TidyPlatesThreat.db.profile.threatWidget.ON and unit.class == "UNKNOWN" then
		if not plate.widgets.ThreatLineWidget then plate.widgets.ThreatLineWidget = TidyPlatesWidgets.CreateThreatLineWidget(plate) end
		plate.widgets.ThreatLineWidget:Update(unit)
		plate.widgets.ThreatLineWidget:SetPoint("CENTER", plate, (TidyPlatesThreat.db.profile.threatWidget.x), TidyPlatesThreat.db.profile.threatWidget.y)
	end
	-- Tanked Widget
	if TidyPlatesThreat.db.profile.tankedWidget.ON and TidyPlatesThreat.db.char.threat.tanking and InCombatLockdown() then
		plate.widgets.TankedWidget:SetPoint("CENTER", plate, TidyPlatesThreat.db.profile.tankedWidget.x, TidyPlatesThreat.db.profile.tankedWidget.y)
		plate.widgets.TankedWidget:Update(unit)
	end
	-- Combo Points
	if not plate.widgets.ComboPoints then plate.widgets.ComboPoints = ThreatPlatesWidgets.CreateComboPointWidget(plate) end
	plate.widgets.ComboPoints:Update(unit)
	plate.widgets.ComboPoints:SetPoint("CENTER", plate, (TidyPlatesThreat.db.profile.comboWidget.x), TidyPlatesThreat.db.profile.comboWidget.y)
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self,event,...) 
	if event == "ADDON_LOADED" then
		local arg1 = ...
		if arg1 == "TidyPlates_ThreatPlates" then
			TidyPlatesThemeList["Threat Plates"].OnInitialize = OnInitialize
			TidyPlatesThemeList["Threat Plates"].OnUpdate = OnUpdate
			TidyPlatesThemeList["Threat Plates"].OnContextUpdate = OnContextUpdate
		end
	end
end)
f:RegisterEvent("ADDON_LOADED")