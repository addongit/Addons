--
-- JS' Hunter Bar
--
-- US - Blackhand - Alliance (Js)
--
-- www.transcended.us forums for support
--
--local debug = true -- For testing things.
if select(2, UnitClass("player")) ~= "HUNTER" then return end

JSHB.mainframe = CreateFrame("StatusBar", "JSHB_MainFrame", UIParent)
JSHB.mainframe.db = {}

local mF	= JSHB.mainframe
local L		= JSHB.locale
local DB 	= JSHB.mainframe.db
local DBG 	= JSHB.mainframe.dbg

-- Display the login welcome greeting
print("|cffabd473" .. L.greeting1 .. strsub(JSHB.ver,7) .. "|r" .. L.greeting2)

SLASH_JSHB1 	= "/jsb"
SLASH_JSHB2 	= "/jshb"
SLASH_JSHB3 	= "/jsbar"

-- Variables used by Tukui (v13+)
local TukUI_borderr, TukUI_borderg, TukUI_borderb
local TukUI_backdropr, TukUI_backdropg, TukUI_backdropb

-- Anchor frames for moving various frames
JSHB.anchorFrame = {}
JSHB.anchorFrame.tranqAlert 	= CreateFrame("Frame", "JSHB_MainFrame_Anchor_tranqAlert", UIParent)
JSHB.anchorFrame.tranqables		= CreateFrame("Frame", "JSHB_MainFrame_Anchor_ccIcons", UIParent)
JSHB.anchorFrame.markReminder 	= CreateFrame("Frame", "JSHB_MainFrame_Anchor_markReminder", UIParent)
JSHB.anchorFrame.debuffAlert 	= CreateFrame("Frame", "JSHB_MainFrame_Anchor_debuffAlert", UIParent)
JSHB.anchorFrame.cdIcons 		= CreateFrame("Frame", "JSHB_MainFrame_Anchor_cdIcons", UIParent)
JSHB.anchorFrame.ccIcons 		= CreateFrame("Frame", "JSHB_MainFrame_Anchor_ccIcons", UIParent)


-- Register in the Interface Addon Options GUI
JSHB.options = CreateFrame( "Frame", "JSHB.options", UIParent )
JSHB.options.name = L.greeting1

JSHB.options.buttonLoD = CreateFrame("Button", "JSHB_Options_LoDBbutton", JSHB.options, "UIPanelButtonTemplate")
JSHB.options.buttonLoD:SetWidth(240)
JSHB.options.buttonLoD:SetHeight(24)
JSHB.options.buttonLoD:SetText("Click here to load options panels")
JSHB.options.buttonLoD:SetPoint("TOP", JSHB.options, "TOP", 0, -20)
JSHB.options.buttonLoD:SetScript("OnClick", function(self) PlaySound("igMainMenuOptionCheckBoxOn"); JSHB.loadOptionsAddon() end)
InterfaceOptions_AddCategory(JSHB.options)


function JSHB.loadOptionsAddon()

	if JSHB.optionsAreLoaded then return end

	local loaded, reason = LoadAddOn("JSHunterBarOptions")

	if not loaded then
		print(L.loderror)
	else
		print(L.lodsuccessful)

		JSHB.optionsAreLoaded = true
		JSHB.setupOptionsPane()

		JSHB.options.RefreshConfigurationSettingsForSpec("bm")
		JSHB.options.RefreshConfigurationSettingsForSpec("mm")
		JSHB.options.RefreshConfigurationSettingsForSpec("sv")
	end
end


JSHB.getFont = function(name, returnNil, singleNest)

	local i
	if JSHB.fonts ~= nil then
		for i=1,#JSHB.fonts do
			if JSHB.fonts[i].text == name then return(JSHB.fonts[i].font) end
		end
	end
	if returnNil ~= true then
		if singleNest ~= true then
			return(JSHB.getFont("Arial Narrow", nil, true))
		else
			return("Fonts\\ARIALN.TTF")
		end
	end
	return(nil)
end


JSHB.getTexture = function(name, returnNil, singleNest)

	local i
	if JSHB.textures ~= nil then
		for i=1,#JSHB.textures do
			if JSHB.textures[i].text == name then return(JSHB.textures[i].texture) end
		end
	end
	if returnNil ~= true then
		if singleNest ~= true then
			return(JSHB.getTexture("Blizzard", nil, true))
		else
			return("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end
	return(nil)
end


JSHB.getSound = function(name, returnNil, singleNest)

	local i
	if JSHB.sounds ~= nil then
		for i=1,#JSHB.sounds do
			if JSHB.sounds[i].text == name then return(JSHB.sounds[i].sound) end
		end
	end
	if returnNil ~= true then
		if singleNest ~= true then
			return(JSHB.getSound("Alliance Bell", nil, true))
		else
			return("Sound\\Doodad\\BellTollAlliance.wav")
		end
	end
	return(nil)
end


local function GetLibSharedMedia3()
	if LibStub and LibStub("LibSharedMedia-3.0", true) then
		return(LibStub("LibSharedMedia-3.0", true))
	end
	return(false)
end


function JSHB.updateSharedMedia(mediatype)

	local i

	-- Build a new JSHB media list, always using our default fonts/textures/sounds as primary
	JSHB.fonts = {}
	for i=1,#JSHB.defaultFonts do
		JSHB.fonts[i] = JSHB.defaultFonts[i]
	end

	JSHB.textures = {}
	for i=1,#JSHB.defaultTextures do
		JSHB.textures[i] = JSHB.defaultTextures[i]
	end

	JSHB.sounds = {}
	for i=1,#JSHB.defaultSounds do
		JSHB.sounds[i] = JSHB.defaultSounds[i]
	end

	if GetLibSharedMedia3() then

		local k, v
		-- Fonts
		for k,v in next, GetLibSharedMedia3():HashTable("font") do
			if JSHB.getFont(k, true) == nil then
				table.insert(JSHB.fonts, { text = k, value = v, font = v })
			end
		end

		-- Textures
		for k,v in next, GetLibSharedMedia3():HashTable("statusbar") do
			if JSHB.getTexture(k, true) == nil then
				table.insert(JSHB.textures, { text = k, value = v, texture = v })
			end
		end

		-- Sounds
		for k,v in next, GetLibSharedMedia3():HashTable("sound") do
			if k ~= "None" then
				if JSHB.getSound(k, true) == nil then
					table.insert(JSHB.sounds, { text = k, value = v, sound = v })
				end
			end
		end
	end
	table.sort(JSHB.fonts, function(a,b) return a.text < b.text end)
	table.sort(JSHB.textures, function(a,b) return a.text < b.text end)
	table.sort(JSHB.sounds, function(a,b) return a.text < b.text end)
end


local function isCombatActive()

	if (JSHB.regenEnabled == false) or UnitAffectingCombat("player") or UnitAffectingCombat("pet") then
		return true
	end
	return false
end


function JSHB.setMDOnFrame(globalName, removeIt)

	local macroStr ="/run JSHB.mDHoverTarget = UnitName('mouseover');\n/cast [@mouseover,exists,nodead,nounithasvehicleui,novehicleui] " .. select(1, GetSpellInfo(34477))

	if (_G[globalName] ~= nil) then
	
		if not removeIt then
			if _G[globalName]:GetAttribute("type2") ~= "macro" then
			
				_G[globalName]:SetAttribute("type2", "macro")
			end
			if _G[globalName]:GetAttribute("macrotext") ~= macroStr then
				
				_G[globalName]:SetAttribute("macrotext", macroStr)
			end
		else
			if _G[globalName]:GetAttribute("type2") == "macro" then
			
				_G[globalName]:SetAttribute("type2", nil)
			end
			
			if _G[globalName]:GetAttribute("macrotext") == macroStr then
				
				_G[globalName]:SetAttribute("macrotext", nil)
			end
		end
	end
end


function JSHB.setMisdirectionOnFrames(whichFrameKey, removeIt)

--	-- If player is using Clique, do not run these functions!
--	if IsAddOnLoaded("Clique") then return end

	local i, idx1, idx2, workStr	
	for i=1,#JSHB.mdframeinfo[whichFrameKey] do	
		if JSHB.mdframeinfo[whichFrameKey][i][4] then		
			for idx1=JSHB.mdframeinfo[whichFrameKey][i][4],JSHB.mdframeinfo[whichFrameKey][i][5] do		
				if JSHB.mdframeinfo[whichFrameKey][i][6] then		
					for idx2=JSHB.mdframeinfo[whichFrameKey][i][6],JSHB.mdframeinfo[whichFrameKey][i][7] do					
						JSHB.setMDOnFrame(JSHB.mdframeinfo[whichFrameKey][i][1] .. idx1 .. JSHB.mdframeinfo[whichFrameKey][i][2] .. idx2 .. JSHB.mdframeinfo[whichFrameKey][i][3], removeIt)
					end
				else
					JSHB.setMDOnFrame(JSHB.mdframeinfo[whichFrameKey][i][1] .. idx1 .. JSHB.mdframeinfo[whichFrameKey][i][2] .. JSHB.mdframeinfo[whichFrameKey][i][3], removeIt)
				end
			end
		else
			JSHB.setMDOnFrame(JSHB.mdframeinfo[whichFrameKey][i][1] .. JSHB.mdframeinfo[whichFrameKey][i][2] .. JSHB.mdframeinfo[whichFrameKey][i][3], removeIt)
		end
	end
end


local function setMisdirects(delayedUpdate)

	-- Secure frames can not be modified in combat!
	if isCombatActive() then
		JSHB.flagDelayedMDUpdate = true
		return
	end
	JSHB.flagDelayedMDUpdate = nil

	mF:UnregisterEvent("PARTY_CONVERTED_TO_RAID")
	mF:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	mF:UnregisterEvent("RAID_ROSTER_UPDATE")
	
	local x,y
	for x,y in pairs(JSHB.mdframeinfo) do
			JSHB.setMisdirectionOnFrames(x, true)
	end

	if not DB.enablerightclickmd then return end

	if DB.enablemdonpet then
		JSHB.setMisdirectionOnFrames("general")
	end	
	if DB.enablemdonpet then
		JSHB.setMisdirectionOnFrames("pet")
	end
	if DB.enablemdonparty then
		JSHB.setMisdirectionOnFrames("party")
	end
	if DB.enablemdonraid then
		JSHB.setMisdirectionOnFrames("raid")
	end
	
	-- Add events to update misdirects when group or raid changes happen.
	mF:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	mF:RegisterEvent("PARTY_MEMBERS_CHANGED")
	mF:RegisterEvent("RAID_ROSTER_UPDATE")
	
end


JSHB.timerpositions.getValueName = function(val)

	local i
	for i=1,#JSHB.timerpositions do
		if JSHB.timerpositions[i][2] == val then return JSHB.timerpositions[i][1] end
	end

	return nil -- Default
end


local function makeTukui(frame, isNotIcon)

	local border = CreateFrame("Frame", nil, frame)

	border:SetBackdrop({
	  bgFile = JSHB.getTexture("Blank"), 
	  edgeFile = JSHB.getTexture("Blank"), 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})

	border:SetPoint("TOPLEFT", -2, 2)
	border:SetPoint("BOTTOMRIGHT", 2, -2)
	border:SetFrameLevel(frame:GetFrameLevel() - 1)

	if IsAddOnLoaded("Tukui") and strsub(GetAddOnMetadata("Tukui", "Version"),1, 2) == "13" then
		border:SetBackdropColor(TukUI_backdropr, TukUI_backdropb, TukUI_backdropb, 1)
		border:SetBackdropBorderColor(TukUI_borderr, TukUI_borderg, TukUI_borderb, 1)
	else
		border:SetBackdropColor(.1,.1,.1,1)
		border:SetBackdropBorderColor(.6,.6,.6,1)
	end

	if not isNotIcon then
		frame.Icon:SetTexCoord(0.08,0.92,0.08,0.92)
	end
	
	return border
end


local function getChatChan(chan)

	local function HideOutgoing(self, event, msg, author, ...)

		if author == GetUnitName("player") then

			ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", HideOutgoing)
    		return true
		end
	end

	if chan ~= 1 then
	
		if chan == "SELFWHISPER" then
		
			ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", HideOutgoing)
			return("WHISPER")
		end
		
		return(chan)
	end

	local zoneType = select(2, IsInInstance())
	if zoneType == "pvp" or zoneType == "arena" then
	
		return "BATTLEGROUND"

	elseif GetNumRaidMembers() > 0 then

		return "RAID"

	elseif GetNumPartyMembers() > 0 then

		return "PARTY"
	else
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", HideOutgoing)
		return "WHISPER" -- default to whisper as last resort unless directly specified
	end
end


-- Check for Debuff on target unit, cast by player
local function checkForTargetDebuff(spellID)

	local v1, v2, v3, v4	
	v1, _, _, v4, _, v2, v3 = UnitAura("target", GetSpellInfo(spellID), nil, "PLAYER|HARMFUL")	
	return v1 and true or false, v1 and v2 or 0, (v1 and (v3 - GetTime()) > 0) and math.max(v3 - GetTime(), 0) or 0, v4
end


-- Check for Buff or Cooldown of ability on player unit, cast by player - getDuration = true for duration, false for CD
local function checkForBuff(spellID, getDuration, onPet)

	local v1, v2, v3, v4
	
	if getDuration then
		if onPet == true then
			v1, _, _, v4, _, v2, v3 = UnitAura("pet", GetSpellInfo(spellID), nil, "PLAYER|HELPFUL") -- Check on the pet, not the player!
		else
			v1, _, _, v4, _, v2, v3 = UnitAura("player", GetSpellInfo(spellID), nil, "PLAYER|HELPFUL")
		end
		return v1 and true or false, v1 and v2 or 0, v1 and math.max(v3 - GetTime(), 0) or 0, v4
	else
		v1, v2 = GetSpellCooldown(spellID)

		-- Need to hack this code a bit, because if we are on GCD it will trigger this to have a duration.
		-- Assuming the duration cannot be less than 1.9, we can override the issues with a simple hack.
		if v2 > 1.9 then
			return v2 == 0 and false or true, v2 == 0 and 0 or v2, v2 == 0 and 0 or math.max(v1 + v2 - GetTime(), 0), 0
		else
			return false, 0, 0, 0 -- easy!
		end
	end
end


local function getIconOffset(whichPos)

	if whichPos == JSHB.pos.CENTER then 

		return 0

	elseif ( (whichPos == JSHB.pos.TOP or whichPos == JSHB.pos.ABOVE) and 
		((DB.timericonanchorparent ~= JSHB.pos.ABOVE) or ((DB.timericonanchorparent == JSHB.pos.ABOVE) and (JSHB.numTimersOnLeft + JSHB.numTimersOnRight == 0))) ) or

		( (whichPos == JSHB.pos.BOTTOM or whichPos == JSHB.pos.BELOW) and
		(DB.timericonanchorparent == JSHB.pos.BELOW) and (JSHB.numTimersOnLeft + JSHB.numTimersOnRight > 0) ) then

		return ((mF:GetHeight() / 2) + (DB.iconSize/2) + (DB.enabletukuitimers and 6 or 3) + ((JSHB.stackBarOn and DB.movestackbarstotop) and 10 or 0)) -- +6 or +3 for border from inset + 1 px spacing

	else
		return (-((mF:GetHeight() / 2) + (DB.iconSize/2) + (DB.enabletukuitimers and 6 or 3) + ((JSHB.stackBarOn and (not DB.movestackbarstotop)) and 10 or 0)))
	end
end


local function getTimerXPos(durationLeft, durationMax)
	return ((((durationLeft / durationMax) * 100) * (((mF:GetWidth() - DB.iconSize) + (DB.enabletukuitimers and 0 or 4)) / 100)) - (DB.enabletukuitimers and 0 or 2))
end


local function formatTimeText(val, tenths, autocolor, timeIndicator)

	if (val >= 3600) then
		return autocolor and format('|cffccccff%d%s|r', math.floor((val+1800) / 3600), timeIndicator and "h" or "") or 
			format('%d%s', math.floor((val+1800) / 3600), timeIndicator and "h" or "")

	elseif (val >= 60 ) then
		return autocolor and format('|cffffffff%d%s|r', math.floor((val+30) / 60), timeIndicator and "m" or "") or 
			format('%d%s', math.floor((val+30) / 60), timeIndicator and "m" or "")

	elseif (val > 3) then
		return autocolor and format('|cffffff00%d%s|r', math.floor(val), timeIndicator and "s" or "") or 
			format('%d%s', math.floor(val), timeIndicator and "s" or "")

	elseif (val > 0) then
		if tenths then
			return autocolor and format('|cffff0000%.1f%s|r', val, timeIndicator and "s" or "") or 
				format('%.1f%s', val, timeIndicator and "s" or "")
		else
			return autocolor and format('|cffff0000%d%s|r', math.floor(val), timeIndicator and "s" or "") or 
				format('%d%s', math.floor(val), timeIndicator and "s" or "")
		end
	end
end


local function jSHBTimer_Stop(self)
	self.enabled = nil
	self:Hide()
end


local function jSHBTimer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end


local function jSHBTimer_OnSizeChanged(self, width, height)

	local fontScale = floor(width + 0.5) / 30 -- 30 is the default iconsize for cctimers.
	if fontScale == self.fontScale then
		return
	end

	self.fontScale = fontScale
	if fontScale < .4 then
		self:Hide()
	else
		self.text:SetFont(JSHB.getFont(DB.timerfont), fontScale * 18, 'OUTLINE') -- 16px font size based on icon size of 30
		self.text:SetShadowColor(0, 0, 0, 0.5)
		self.text:SetShadowOffset(2, -2)
		if self.enabled then
			jSHBTimer_ForceUpdate(self)
		end
	end
end


local function jSHBTimer_OnUpdate(self, elapsed)

	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local remain = self.duration - (GetTime() - self.start)

		if floor(remain + 0.1) > 0 then
			self.text:SetText(formatTimeText(remain, false, true))
			self.nextUpdate = 0.1
		else
			jSHBTimer_Stop(self)
		end
	end
end


local function jSHBTimer_Create(self)

	local scaler = CreateFrame('Frame', nil, self)
	scaler:SetAllPoints(self)

	local timer = CreateFrame('Frame', nil, scaler)
	timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", jSHBTimer_OnUpdate)

	local text = timer:CreateFontString(nil, 'OVERLAY')
	text:SetPoint("CENTER", (floor(self:GetWidth() + 0.5) / 30) * 2, 0) -- 2px offset based on 18px font and 30px standard icon width
	text:SetJustifyH("CENTER")
	text:SetJustifyV("CENTER")
	timer.text = text

	jSHBTimer_OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript("OnSizeChanged", function(self, ...) jSHBTimer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end


local function stopCCTimer(spellID, targetGUID)

	local i
	for i=1,3 do
		if (JSHB.cCIconFrames[i].active == true) and (JSHB.cCIconFrames[i].spellID == spellID) and (JSHB.cCIconFrames[i].guid == targetGUID) then

			JSHB.cCIconFrames[i]:SetAlpha(0)
			JSHB.cCIconFrames[i].guid = 0
			JSHB.cCIconFrames[i].spellID = 0
			JSHB.cCIconFrames[i].active = false
			JSHB.cCIconFrames[i].killtime = 0

			if JSHB.cCIconFrames[i].timer then
				JSHB.cCIconFrames[i].timer.enabled = nil
				JSHB.cCIconFrames[i].timer:Hide()
			end

			break -- Found the right one, stop the loop
		end
	end
end


local function repositionCCTimers()

	local i, x
	local j = 1
	for i=1,3 do
		if JSHB.cCIconFrames[i].active == true then

			if (JSHB.cCIconFrames[i].killtime < GetTime()) then

				stopCCTimer(JSHB.cCIconFrames[i].spellID, JSHB.cCIconFrames[i].guid)
			else

				if DB.ccAnchorPointOffsetX <= 0 then -- Expand Left

					x = (-(((j-1)*(DB.cCIconSize + (DB.enabletukui and 6 or 2))) )) + DB.ccAnchorPointOffsetX

				else -- Expand Right

					x = (((j-1)*(DB.cCIconSize + (DB.enabletukui and 6 or 2))) ) + DB.ccAnchorPointOffsetX
				end

				JSHB.cCIconFrames[i]:SetPoint(DB.ccAnchorPoint, 'UIParent', DB.ccAnchorPointRelative, x, DB.ccAnchorPointOffsetY)

				j = j + 1
			end
		end
	end
end


local function addCCTimer(spellID, targetGUID, expireTime)

	local i
	for i=2,4 do -- Position Wyvern first, as it's only a 30s duration.

		if (JSHB.cCIconFrames[i].active == false) or (spellID == 19386) then -- Wyvern Sting

			if (spellID == 19386) then i = 1 end

			JSHB.cCIconFrames[i].Icon:ClearAllPoints()
			JSHB.cCIconFrames[i].Icon:SetAllPoints(JSHB.cCIconFrames[i])
			JSHB.cCIconFrames[i].Icon:SetTexture(select(3, GetSpellInfo(spellID)))

			if JSHB.barLocked then
				JSHB.cCIconFrames[i]:SetAlpha(1) 
			end

			JSHB.cCIconFrames[i].killtime = GetTime() + expireTime + .2
			JSHB.cCIconFrames[i].guid = targetGUID -- Need to know the target id associated with this frame.
			JSHB.cCIconFrames[i].spellID = spellID
			JSHB.cCIconFrames[i].active = true

			local timer = JSHB.cCIconFrames[i].timer or jSHBTimer_Create(JSHB.cCIconFrames[i])
			timer.start = GetTime()
			timer.duration = expireTime
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()

			break
		end
	end
end


local function refreshCCTimer(spellID, targetGUID, expireTime)

	for i=1,4 do
		if (JSHB.cCIconFrames[i].active == true) and (JSHB.cCIconFrames[i].spellID == spellID) and (JSHB.cCIconFrames[i].guid == targetGUID) then

			JSHB.cCIconFrames[i].killtime = GetTime() + expireTime + .2

			local timer = JSHB.cCIconFrames[i].timer or jSHBTimer_Create(JSHB.cCIconFrames[i])
			timer.start = GetTime()
			timer.duration = expireTime
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()

			break
		end
	end
end


local function setCCTimers()

	local i, x

	for i=1,4 do
		if JSHB.cCIconFrames[i] ~= nil then
			if i == 1 then
				JSHB.cCIconFrames[i]:SetScript("OnUpdate", nil)
			end
			JSHB.cCIconFrames[i]:Hide()
			JSHB.cCIconFrames[i].active = false

			if JSHB.cCIconFrames[i].timer then
				JSHB.cCIconFrames[i].timer.enabled = nil
				JSHB.cCIconFrames[i].timer:Hide()
			end

			JSHB.cCIconFrames[i] = nil
		end
	end

	if not DB.enablecctimers then return end

	for i=1,4 do -- Allocating 4 frames, more than enough, low overhead

		JSHB.cCIconFrames[i] = CreateFrame("Frame", nil, mF)
		JSHB.cCIconFrames[i]:SetWidth(DB.cCIconSize)
		JSHB.cCIconFrames[i]:SetHeight(DB.cCIconSize)

		if DB.ccAnchorPointOffsetX <= 0 then -- Expand Left

			x = (-(i*(DB.cCIconSize+2))) + DB.ccAnchorPointOffsetX

		else -- Expand Right

			x = (i*(DB.cCIconSize+2)) + DB.ccAnchorPointOffsetX
		end

		JSHB.cCIconFrames[i]:SetPoint(DB.ccAnchorPoint, 'UIParent', DB.ccAnchorPointRelative, x, DB.ccAnchorPointOffsetY)

		JSHB.cCIconFrames[i].Icon = JSHB.cCIconFrames[i]:CreateTexture(nil, "BACKGROUND")

		if DB.enabletukui then
			JSHB.cCIconFrames[i].border = makeTukui(JSHB.cCIconFrames[i])
		end

		JSHB.cCIconFrames[i]:SetAlpha(0)
		JSHB.cCIconFrames[i]:Show()		
		JSHB.cCIconFrames[i].guid = 0
		JSHB.cCIconFrames[i].spellID = 0
		JSHB.cCIconFrames[i].active = false
	end

	-- First frame calls the update routine.
	JSHB.cCIconFrames[1].updateTimer = 0
	JSHB.cCIconFrames[1]:SetScript("OnUpdate", function(self, elapsed)

		self.updateTimer = self.updateTimer + elapsed

		if self.updateTimer > 0.15 then

			local i, x
			local j = 1
			for i=1,3 do
				if JSHB.cCIconFrames[i].active == true then

					if (JSHB.cCIconFrames[i].killtime < GetTime()) then

						stopCCTimer(JSHB.cCIconFrames[i].spellID, JSHB.cCIconFrames[i].guid)
					else
						if DB.ccAnchorPointOffsetX <= 0 then -- Expand Left

							x = (-(((j-1)*(DB.cCIconSize + (DB.enabletukui and 6 or 2))) )) + DB.ccAnchorPointOffsetX

						else -- Expand Right

							x = (((j-1)*(DB.cCIconSize + (DB.enabletukui and 6 or 2))) ) + DB.ccAnchorPointOffsetX
						end

						JSHB.cCIconFrames[i]:SetPoint(DB.ccAnchorPoint, 'UIParent', DB.ccAnchorPointRelative, x, DB.ccAnchorPointOffsetY)
						j = j + 1
					end
				end
			end
		end
	end)
end


local function stopDebuffAlert(spellID)

	local i
	for i=1,6 do
		if (JSHB.debuffIconFrames[i].active == true) and (JSHB.debuffIconFrames[i].spellID == spellID) then
			AutoCastShine_AutoCastStop(JSHB.debuffIconFrames[i].shine);
			JSHB.debuffIconFrames[i].Icon:Hide()

			JSHB.debuffIconFrames[i].Stacks:Hide()
			JSHB.debuffIconFrames[i]:SetAlpha(0)
			JSHB.debuffIconFrames[i].spellID = 0
			JSHB.debuffIconFrames[i].active = false
			JSHB.debuffIconFrames[i].killtime = 0
			JSHB.debuffIconFrames[i]:EnableMouse(nil)

			if JSHB.debuffIconFrames[i].timer then
				JSHB.debuffIconFrames[i].timer.enabled = nil
				JSHB.debuffIconFrames[i].timer:Hide()
			end
			break -- Found the right one, stop the loop
		end
	end
end


local function addDebuffAlert(spellID, expireTime, stacks)

	local i
	for i=1,6 do
		if (JSHB.debuffIconFrames[i].active == false) then

			JSHB.debuffIconFrames[i].Icon:ClearAllPoints()
			JSHB.debuffIconFrames[i].Icon:SetTexture(select(3, GetSpellInfo(spellID)))
			JSHB.debuffIconFrames[i].Icon:SetAllPoints(JSHB.debuffIconFrames[i])
			JSHB.debuffIconFrames[i].Icon:Show()

			if stacks and (stacks > 0) then 
				JSHB.debuffIconFrames[i].Stacks:SetText(stacks)
				JSHB.debuffIconFrames[i].Stacks:Show()
			else
				JSHB.debuffIconFrames[i].Stacks:Hide()
			end

			if JSHB.barLocked then
				JSHB.debuffIconFrames[i]:SetAlpha(1)
			end

			JSHB.debuffIconFrames[i].killtime = GetTime() + expireTime + .1
			JSHB.debuffIconFrames[i].spellID = spellID
			JSHB.debuffIconFrames[i].active = true
			JSHB.debuffIconFrames[i]:EnableMouse(true)
			AutoCastShine_AutoCastStart(JSHB.debuffIconFrames[i].shine)

			local timer = JSHB.debuffIconFrames[i].timer or jSHBTimer_Create(JSHB.debuffIconFrames[i])
			timer.start = GetTime()
			timer.duration = expireTime
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()

			break
		end
	end
end


local function refreshDebuffAlert(spellID, expireTime, stacks)

	local i
	
	for i=1,6 do
		if (JSHB.debuffIconFrames[i].active == true) and (JSHB.debuffIconFrames[i].spellID == spellID) then

			JSHB.debuffIconFrames[i].killtime = GetTime() + expireTime + .1

			JSHB.debuffIconFrames[i].Icon:Show()

			if stacks and (stacks > 0) then 
				JSHB.debuffIconFrames[i].Stacks:SetText(stacks)
				JSHB.debuffIconFrames[i].Stacks:Show()
			else
				JSHB.debuffIconFrames[i].Stacks:Hide()
			end

			local timer = JSHB.debuffIconFrames[i].timer or jSHBTimer_Create(JSHB.debuffIconFrames[i])
			timer.start = GetTime()
			timer.duration = expireTime
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()

			break
		end
	end
end


local function setDebuffAlert()

	local i, x

	for i=1,6 do
		if JSHB.debuffIconFrames[i] ~= nil then
			if i == 1 then
				JSHB.debuffIconFrames[i]:SetScript("OnUpdate", nil)
			end
			JSHB.debuffIconFrames[i]:Hide()
			JSHB.debuffIconFrames[i].active = false

			if JSHB.debuffIconFrames[i].timer then
				JSHB.debuffIconFrames[i].timer.enabled = nil
				JSHB.debuffIconFrames[i].timer:Hide()
			end

			JSHB.debuffIconFrames[i] = nil
		end
	end

	if not DB.enabledebuffalert then return end

	for i=1,6 do -- Allocating 6 frames, more than enough, low overhead
		JSHB.debuffIconFrames[i] = CreateFrame("Frame", "JSHB_DebuffIconFrame"..i, mF)
		JSHB.debuffIconFrames[i]:SetWidth(DB.debufficonsize)
		JSHB.debuffIconFrames[i]:SetHeight(DB.debufficonsize)

		if DB.debuffAnchorPointOffsetX <= 0 then -- Expand Left
			x = (-(i*(DB.debufficonsize+4))) + DB.debuffAnchorPointOffsetX
		else -- Expand Right
			x = (i*(DB.debufficonsize+4)) + DB.debuffAnchorPointOffsetX
		end

		JSHB.debuffIconFrames[i]:SetPoint(DB.debuffAnchorPoint, 'UIParent', DB.debuffAnchorPointRelative, x, DB.debuffAnchorPointOffsetY)

		JSHB.debuffIconFrames[i].Icon = JSHB.debuffIconFrames[i]:CreateTexture(nil, "BACKGROUND")
		JSHB.debuffIconFrames[i].Icon:SetAlpha(1)
		JSHB.debuffIconFrames[i].Icon:Hide()

		if DB.enabletukui then
			JSHB.debuffIconFrames[i].border = makeTukui(JSHB.debuffIconFrames[i])
		end

		JSHB.debuffIconFrames[i]:SetAlpha(0)
		JSHB.debuffIconFrames[i]:Show()
		JSHB.debuffIconFrames[i].spellID = 0
		JSHB.debuffIconFrames[i].active = false
		JSHB.debuffIconFrames[i]:SetScript("OnEnter", function(self)

			if self.spellID == 0 then return end

			local index
			for index=1,40 do
				if (select(11, UnitAura("player", index, "HARMFUL")) == self.spellID) then
				
					GameTooltip:SetOwner(self)
					GameTooltip:SetUnitAura("player", index, "HARMFUL")
					GameTooltip:Show()
					return
					
				elseif (select(11, UnitAura("player", index, "HELPFUL")) == self.spellID) then
				
					GameTooltip:SetOwner(self)
					GameTooltip:SetUnitAura("player", index, "HELPFUL")
					GameTooltip:Show()
					return
				end
			end
			self:EnableMouse(nil)
		end)
		JSHB.debuffIconFrames[i]:SetScript("OnLeave", function(self)
			if self.spellID == 0 then return end
			GameTooltip:Hide()
		end)
		JSHB.debuffIconFrames[i]:EnableMouse(nil)

		JSHB.debuffIconFrames[i].shine = SpellBook_GetAutoCastShine()
		JSHB.debuffIconFrames[i].shine:Show();
		JSHB.debuffIconFrames[i].shine:SetParent(JSHB.debuffIconFrames[i]);
		JSHB.debuffIconFrames[i].shine:SetWidth(DB.enabletukui and (DB.debufficonsize + 7) or (DB.debufficonsize + 3))
		JSHB.debuffIconFrames[i].shine:SetHeight(DB.enabletukui and (DB.debufficonsize + 7) or (DB.debufficonsize + 3))
		JSHB.debuffIconFrames[i].shine:SetPoint("CENTER", JSHB.debuffIconFrames[i], "CENTER");
		
		JSHB.debuffIconFrames[i].Stacks = JSHB.debuffIconFrames[i]:CreateFontString(nil, "OVERLAY", JSHB.debuffIconFrames[i])
		JSHB.debuffIconFrames[i].Stacks:SetJustifyH("RIGHT")
		JSHB.debuffIconFrames[i].Stacks:SetJustifyV("BOTTOM")
		JSHB.debuffIconFrames[i].Stacks:SetPoint("BOTTOMRIGHT", JSHB.debuffIconFrames[i], "BOTTOMRIGHT", 4, -4)
		JSHB.debuffIconFrames[i].Stacks:SetFont(JSHB.getFont("Arial Narrow"), DB.debufficonsize*.35, "OUTLINE")
		JSHB.debuffIconFrames[i].Stacks:SetTextColor(1, 0, 0, 1)
		JSHB.debuffIconFrames[i].Stacks:Hide()		
	end

	-- First frame calls the update routine.
	JSHB.debuffIconFrames[1].updateTimer = 0
	JSHB.debuffIconFrames[1]:SetScript("OnUpdate", function(self, elapsed)

		self.updateTimer = self.updateTimer + elapsed

		if self.updateTimer > 0.15 then

			local i, x
			local j = 1
			for i=1,6 do
				if JSHB.debuffIconFrames[i].active == true then

					if (JSHB.debuffIconFrames[i].killtime < GetTime()) then

						stopDebuffAlert(JSHB.debuffIconFrames[i].spellID)
					else
						if DB.debuffAnchorPointOffsetX <= 0 then -- Expand Left

							x = (-(((j-1)*(DB.debufficonsize + (DB.enabletukui and 8 or 4))) )) + DB.debuffAnchorPointOffsetX

						else -- Expand Right

							x = (((j-1)*(DB.debufficonsize + (DB.enabletukui and 8 or 4))) ) + DB.debuffAnchorPointOffsetX
						end

						JSHB.debuffIconFrames[i]:SetPoint(DB.debuffAnchorPoint, 'UIParent', DB.debuffAnchorPointRelative, x, DB.debuffAnchorPointOffsetY)

						if JSHB.barLocked then
							JSHB.debuffIconFrames[i]:SetAlpha(1)
						end
						j = j + 1
					end
				end
			end
		end
	end)
end


local function setMarkReminder()

	if JSHB.markFrame then
		JSHB.markFrame:Hide()
		
		if JSHB.markFrame.timer then
			JSHB.markFrame.timer.enabled = nil
			JSHB.markFrame.timer:Hide()
		end
		JSHB.markFrame:SetParent(nil)
		JSHB.markFrame = nil
	end

	if not DB.enablehuntersmarkwarning then return end

	JSHB.markFrame = CreateFrame("Frame", nil, UIParent)
	JSHB.markFrame:SetWidth(DB.markIconSize)
	JSHB.markFrame:SetHeight(DB.markIconSize)
	JSHB.markFrame:SetPoint(DB.markAnchorPoint, 'UIParent', DB.markAnchorPointRelative, DB.markAnchorPointOffsetX, DB.markAnchorPointOffsetY)

	JSHB.markFrame.Icon = JSHB.markFrame:CreateTexture(nil, "BACKGROUND")
	JSHB.markFrame.Icon:SetTexture(select(3, GetSpellInfo(56303))) -- Hunter's Mark
	JSHB.markFrame.Icon:SetAllPoints(JSHB.markFrame)
	
	if DB.enabletukui then
		JSHB.markFrame.border = makeTukui(JSHB.markFrame)
	end

	JSHB.markFrame.shine = SpellBook_GetAutoCastShine()
	JSHB.markFrame.shine:Show();
	JSHB.markFrame.shine:SetParent(JSHB.markFrame);
	JSHB.markFrame.shine:SetWidth(DB.enabletukui and (DB.markIconSize + 7) or (DB.markIconSize + 3))
	JSHB.markFrame.shine:SetHeight(DB.enabletukui and (DB.markIconSize + 7) or (DB.markIconSize + 3))
	JSHB.markFrame.shine:SetPoint("CENTER", JSHB.markFrame, "CENTER");
	
	JSHB.markFrame:SetAlpha(0)
	JSHB.markFrame:Show()
	
	JSHB.functionChain[#JSHB.functionChain + 1] = function(self, elapsed)

		if self.updateTimer <= 0.15 then return end
	
		if not JSHB.barLocked then return end

		if (not UnitExists("target")) or (UnitExists("target") and UnitIsFriend("player", "target")) or (UnitIsDeadOrGhost("target")) then

				AutoCastShine_AutoCastStop(JSHB.markFrame.shine)
				JSHB.markFrame:SetAlpha(0)

		else
			local v1, _, _, _, _, v2, v3 = UnitAura("target", GetSpellInfo(56303), nil, "HARMFUL") -- Any hunter's mark, not just player!
			local v4, _, _, _, _, v5, v6 = UnitAura("target", GetSpellInfo(88691), nil, "HARMFUL") -- Any MFD, not just player!

			-- Mark present and time is above threshold of 30s (HM) / 5s (MFD)
			if (v1 and ((v3 - GetTime()) > 30)) or (v4 and ((v6 - GetTime()) > 4)) or UnitInVehicle("player") then

				-- Hunter's Mark / MFD present with 30s/5s or more remaining duration on target
				AutoCastShine_AutoCastStop(JSHB.markFrame.shine)				
				JSHB.markFrame:SetAlpha(0)

			-- Hunter's Mark present, didn't meet above condition, must be under 30s duration remaining.
			elseif v1 and not (v4 and ((v6 - GetTime()) > 4)) then
			
				if (JSHB.markFrame.timer == nil) or (not JSHB.markFrame.timer.enabled) then
				
					JSHB.markFrame.Icon:SetTexture(select(3, GetSpellInfo(56303))) -- Hunter's Mark

					local timer = JSHB.markFrame.timer or jSHBTimer_Create(JSHB.markFrame)
					timer.start = GetTime()
					timer.duration = v3 - GetTime()
					timer.enabled = true
					timer.nextUpdate = 0
					timer:Show()
				end
				
				if isCombatActive() then
					AutoCastShine_AutoCastStart(JSHB.markFrame.shine)
				else
					AutoCastShine_AutoCastStop(JSHB.markFrame.shine)
				end
				
				JSHB.markFrame:SetAlpha(mF:GetAlpha())

			-- Hunter's Mark not up but MFD present, didn't meet above conditions, must be under 5s duration remaining.
			elseif v4 then
			
				if (JSHB.markFrame.timer == nil) or (not JSHB.markFrame.timer.enabled) then

					JSHB.markFrame.Icon:SetTexture(select(3, GetSpellInfo(53241))) -- Marked for Death
				
					local timer = JSHB.markFrame.timer or jSHBTimer_Create(JSHB.markFrame)
					timer.start = GetTime()
					timer.duration = v6 - GetTime()
					timer.enabled = true
					timer.nextUpdate = 0
					timer:Show()
				end
				
				if isCombatActive() then
					AutoCastShine_AutoCastStart(JSHB.markFrame.shine)
				else
					AutoCastShine_AutoCastStop(JSHB.markFrame.shine)
				end
				
				JSHB.markFrame:SetAlpha(mF:GetAlpha())

			-- Mark is not present at all.
			else
				if JSHB.markFrame.Icon:GetTexture() ~= select(3, GetSpellInfo(56303)) then -- Hunter's Mark
					JSHB.markFrame.Icon:SetTexture(select(3, GetSpellInfo(56303)))
				end
				
				if isCombatActive() then
					AutoCastShine_AutoCastStart(JSHB.markFrame.shine)
				else
					AutoCastShine_AutoCastStop(JSHB.markFrame.shine)
				end
				
				JSHB.markFrame:SetAlpha(mF:GetAlpha())
				
				local timer = JSHB.markFrame.timer or jSHBTimer_Create(JSHB.markFrame)
				timer.enabled = false
				timer:Hide()
			end
		end
	end
end


local function setTranqAlert()

	if JSHB.tranqFrame then
		JSHB.tranqFrame:Hide()
		JSHB.tranqFrame:SetParent(nil)
		JSHB.tranqFrame = nil
	end

	if not DB.enabletranqalert then return end

	--JSHB.tranqFrame = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate")
	JSHB.tranqFrame = CreateFrame("Frame", nil, UIParent)	
	JSHB.tranqFrame:SetWidth(DB.taiconsize)
	JSHB.tranqFrame:SetHeight(DB.taiconsize)
	JSHB.tranqFrame:SetPoint(DB.alertAnchorPoint, 'UIParent', DB.alertAnchorPointRelative, DB.alertAnchorPointOffsetX, DB.alertAnchorPointOffsetY)

	JSHB.tranqFrame.Icon = JSHB.tranqFrame:CreateTexture(nil, "BACKGROUND")
	JSHB.tranqFrame.Icon:SetTexture(select(3, GetSpellInfo(19801))) -- Tranq Shot ID
	JSHB.tranqFrame.Icon:SetAllPoints(JSHB.tranqFrame)

--	JSHB.tranqFrame:SetAttribute("type", "spell")
--	JSHB.tranqFrame:SetAttribute("spell", select(1, GetSpellInfo(19801)))
--	JSHB.tranqFrame:SetAttribute("unit", "target")

	if DB.enabletukui then
		JSHB.tranqFrame.border = makeTukui(JSHB.tranqFrame)
	end

	JSHB.tranqFrame.shine = SpellBook_GetAutoCastShine()
	JSHB.tranqFrame.shine:Show();
	JSHB.tranqFrame.shine:SetParent(JSHB.tranqFrame);
	JSHB.tranqFrame.shine:SetWidth(DB.enabletukui and (DB.taiconsize + 7) or (DB.taiconsize + 3))
	JSHB.tranqFrame.shine:SetHeight(DB.enabletukui and (DB.taiconsize + 7) or (DB.taiconsize + 3))
	JSHB.tranqFrame.shine:SetPoint("CENTER", JSHB.tranqFrame, "CENTER");
	
	JSHB.tranqFrame:SetAlpha(0)
	JSHB.tranqFrame:Show()
	
	JSHB.functionChain[#JSHB.functionChain + 1] = function(self, elapsed)

		if self.updateTimer <= 0.15 then return end
	
		if not JSHB.barLocked then return end

		if (not UnitExists("target")) or (UnitExists("target") and UnitIsFriend("player", "target")) then
			AutoCastShine_AutoCastStop(JSHB.tranqFrame.shine)
			JSHB.tranqFrame:SetAlpha(0)
			return
		else
			local x
			for x=1,#JSHB.tranqalerts do

				if UnitAura("target", GetSpellInfo(JSHB.tranqalerts[x]), nil, "HELPFUL") then
					AutoCastShine_AutoCastStart(JSHB.tranqFrame.shine)
					JSHB.tranqFrame:SetAlpha(mF:GetAlpha())
					return
				end
			end
			-- Custom tranq spells
			for x=1,#DBG.customtranq do

				if UnitAura("target", GetSpellInfo(DBG.customtranq[x]), nil, "HELPFUL") then
					AutoCastShine_AutoCastStart(JSHB.tranqFrame.shine)
					JSHB.tranqFrame:SetAlpha(mF:GetAlpha())
					return
				end
			end
		end
		JSHB.tranqFrame:SetAlpha(0)
	end
end


local function getAuraInfo(alias)

	if alias[2] and (alias[3] == 1 or alias[3] == 2) then -- get duration left on player or pet

		return checkForBuff(alias[1], true, (alias[3] == 2) and true or false)

	elseif alias[2] and (alias[3] == 0) then -- get duration left on target

		return checkForTargetDebuff(alias[1])

	else -- get cooldown left, assume player and not target

		return checkForBuff(alias[1], false, false)
	end
end


local function setAllTimers()

	local x, i, j

	JSHB.currentTree = GetPrimaryTalentTree() -- 3 = sv, 2 = mm, 1 = bm

	for i=1,100 do
		if JSHB.timerFrames[i] ~= nil then 
			JSHB.timerFrames[i]:Hide()
			JSHB.timerFrames[i]:SetScript("OnUpdate", nil)
			JSHB.timerFrames[i].timerTable = nil
			JSHB.timerFrames[i] = nil
		end

		if JSHB.iconTimerFrames[i] ~= nil then
			JSHB.iconTimerFrames[i]:Hide()
			JSHB.iconTimerFrames[i]:SetScript("OnUpdate", nil)
			JSHB.iconTimerFrames[i].timerTable = nil
			JSHB.iconTimerFrames[i] = nil
		end
	end

	JSHB.flagTimerOnTop = nil
	JSHB.flagTimerOnBottom = nil
	JSHB.numTimersOnLeft = 0
	JSHB.numTimersOnRight = 0

	if (DB.timers[JSHB.specs[JSHB.currentTree]] == nil) or (#DB.timers[JSHB.specs[JSHB.currentTree]] == 0) then return end

	local fontScale = floor(DB.icontimerssize) / 30 -- 30 is the default iconsize for icontimers.

	if not DB.enabletimers then return end

	if JSHB.currentTree == nil then JSHB.currentTree = 1 end

	i, j = 1, 1
	for x=1,#DB.timers[JSHB.specs[JSHB.currentTree]] do

		if DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.TOP or DB.timers[JSHB.specs[JSHB.currentTree]][4] == JSHB.pos.ABOVE then

			JSHB.flagTimerOnTop = true

		elseif DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.BOTTOM or DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.BELOW then

			JSHB.flagTimerOnBottom = true
		end

		-- Moving timers
		if (DB.timers[JSHB.specs[JSHB.currentTree]][x][4] ~= JSHB.pos.LEFT) and (DB.timers[JSHB.specs[JSHB.currentTree]][x][4] ~= JSHB.pos.RIGHT) then

			JSHB.timerFrames[i] = CreateFrame("Frame", nil, mF)
			JSHB.timerFrames[i]:SetWidth(DB.iconSize)
			JSHB.timerFrames[i]:SetHeight(DB.iconSize)
			JSHB.timerFrames[i]:SetPoint("LEFT", mF, "LEFT", 0, getIconOffset(DB.timers[JSHB.specs[JSHB.currentTree]][x][4]))

			JSHB.timerFrames[i].Icon = JSHB.timerFrames[i]:CreateTexture(nil,"BACKGROUND")
			JSHB.timerFrames[i].Icon:SetTexture(select(3, GetSpellInfo(DB.timers[JSHB.specs[JSHB.currentTree]][x][1])))
			JSHB.timerFrames[i].Icon:SetAllPoints(JSHB.timerFrames[i])

			if DB.enabletukui and (DB.timers[JSHB.specs[JSHB.currentTree]][x][4] ~= JSHB.pos.CENTER) then
				JSHB.timerFrames[i].border = makeTukui(JSHB.timerFrames[i])
			end

			JSHB.timerFrames[i].value = JSHB.timerFrames[i]:CreateFontString(nil, "OVERLAY")

			if DB.timerfontposition == JSHB.pos.TOP or DB.timerfontposition == JSHB.pos.BOTTOM then

				if (DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.TOP) or (DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.ABOVE) then

					JSHB.timerFrames[i].value:SetJustifyH("CENTER")
					JSHB.timerFrames[i].value:SetJustifyV("BOTTOM")

					JSHB.timerFrames[i].value:SetPoint("BOTTOM", JSHB.timerFrames[i], "TOP", 0,  DB.enabletukuitimers and 3 or 1)
				else
					JSHB.timerFrames[i].value:SetJustifyH("CENTER")
					JSHB.timerFrames[i].value:SetJustifyV("TOP")

					JSHB.timerFrames[i].value:SetPoint("TOP", JSHB.timerFrames[i], "BOTTOM", 0, DB.enabletukuitimers and -3 or -1)
				end

			elseif DB.timerfontposition == JSHB.pos.RIGHT then

					JSHB.timerFrames[i].value:SetJustifyH("LEFT")
					JSHB.timerFrames[i].value:SetJustifyV("CENTER")

					JSHB.timerFrames[i].value:SetPoint("LEFT", JSHB.timerFrames[i], "RIGHT", DB.enabletukuitimers and 3 or 1,  0)

			else
				JSHB.timerFrames[i].value:SetJustifyH("CENTER")
				JSHB.timerFrames[i].value:SetJustifyV("CENTER")

				JSHB.timerFrames[i].value:SetPoint("CENTER", JSHB.timerFrames[i], "CENTER", 1, 0)
			end

			JSHB.timerFrames[i].value:SetFont(JSHB.getFont(DB.timerfont), DB.fontsizetimers, "OUTLINE")
			JSHB.timerFrames[i].value:SetText("")
			JSHB.timerFrames[i].value:SetAlpha(1)

			JSHB.timerFrames[i].updateTimer = 0
			JSHB.timerFrames[i].timerTable = DB.timers[JSHB.specs[JSHB.currentTree]][x]
			JSHB.timerFrames[i]:SetScript("OnUpdate", function(self, elapsed)

				self.updateTimer = self.updateTimer + elapsed

				if self.updateTimer > 0.04 then

					if JSHB.currentTree == nil then return end

					local v1, v2, v3 = getAuraInfo(self.timerTable)

					if v1 and (not UnitIsDeadOrGhost("player")) then

						if not self.enabled then

							self.enabled = true
							self:SetAlpha(1)
						end

						self:ClearAllPoints()
						self:SetPoint("LEFT", mF, "LEFT", floor(getTimerXPos(v3, v2)),  getIconOffset(self.timerTable[4]))

						self.value:SetText(formatTimeText(v3, DB.enabletimertenths, DB.timertextcoloredbytime))

					elseif self.enabled then

						self.enabled = nil
						self.value:SetText("")
						self:SetAlpha(0)
					end
				end
			end)

			JSHB.timerFrames[i]:SetAlpha(0)
			JSHB.timerFrames[i]:Show()
			i = i + 1
		else
			-- Icon timers

			JSHB.iconTimerFrames[j] = CreateFrame("Frame", nil, mF)
			JSHB.iconTimerFrames[j]:SetWidth(DB.icontimerssize)
			JSHB.iconTimerFrames[j]:SetHeight(DB.icontimerssize)

			local v1, v2, v3, v4, v5 = DB.cdIconAnchorPoint, 'UIParent', DB.cdIconAnchorPointRelative, DB.cdIconAnchorPointOffsetX, DB.cdIconAnchorPointOffsetY

			if (DB.enabletukui == true) then

				v4 = (DB.icontimersgap >= 6) and (DB.icontimersgap / 2) or 3
			else
				v4 = (DB.icontimersgap >= 2) and (DB.icontimersgap / 2) or 1
			end

			v4 = floor(v4 + 0.5)
			v4 = v4 + ((DB.icontimerssize + (DB.enabletukui == true and 6 or 2)) * (DB.timers[JSHB.specs[JSHB.currentTree]][x][5] - 1))

			if (DB.timericonanchorparent == JSHB.pos.MOVABLE) then

				if DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.LEFT then

					v1 = "BOTTOMRIGHT"
					JSHB.numTimersOnLeft = JSHB.numTimersOnLeft + 1
					v4 = (-(v4))
				else
					v1 = "BOTTOMLEFT"
					JSHB.numTimersOnRight = JSHB.numTimersOnRight + 1
				end

				v4 = v4 + DB.cdIconAnchorPointOffsetX
				v5 = v5 + (-(DB.icontimerssize/2))

			else
				v5 = ((DB.movestackbarstotop and DB.timericonanchorparent == JSHB.pos.ABOVE) or
					(not DB.movestackbarstotop and DB.timericonanchorparent == JSHB.pos.BELOW)) and 16 or 6

				if (DB.timericonanchorparent == JSHB.pos.ABOVE) then

					if DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.LEFT then

						JSHB.numTimersOnLeft = JSHB.numTimersOnLeft + 1
						v1, v2, v3 = "BOTTOMRIGHT", mF, "TOP"
						v4 = (-(v4))
					else
						JSHB.numTimersOnRight = JSHB.numTimersOnRight + 1
						v1, v2, v3 = "BOTTOMLEFT", mF, "TOP"
					end
				else
					v5 = (-(v5))
					if DB.timers[JSHB.specs[JSHB.currentTree]][x][4] == JSHB.pos.LEFT then

						JSHB.numTimersOnLeft = JSHB.numTimersOnLeft + 1
						v1, v2, v3 = "TOPRIGHT", mF, "BOTTOM"
						v4 = (-(v4))
					else
						JSHB.numTimersOnRight = JSHB.numTimersOnRight + 1
						v1, v2, v3 = "TOPLEFT", mF, "BOTTOM"
					end
				end
			end

			JSHB.iconTimerFrames[j]:SetPoint(v1, v2, v3, v4, v5)

			JSHB.iconTimerFrames[j].Icon = JSHB.iconTimerFrames[j]:CreateTexture(nil,"BACKGROUND")
			JSHB.iconTimerFrames[j].Icon:SetTexture(select(3, GetSpellInfo(DB.timers[JSHB.specs[JSHB.currentTree]][x][1])))
			JSHB.iconTimerFrames[j].Icon:SetAllPoints(JSHB.iconTimerFrames[j])

			if DB.enabletukui then
				JSHB.iconTimerFrames[j].border = makeTukui(JSHB.iconTimerFrames[j])
			end

			JSHB.iconTimerFrames[j].value = JSHB.iconTimerFrames[j]:CreateFontString(nil, "OVERLAY")

			if (DB.timericonanchorparent == JSHB.pos.ABOVE) then

				JSHB.iconTimerFrames[j].value:SetPoint("BOTTOM", JSHB.iconTimerFrames[j], "TOP", 0, (DB.enabletukui == true and 5 or 1))
			else
				JSHB.iconTimerFrames[j].value:SetPoint("TOP", JSHB.iconTimerFrames[j], "BOTTOM", 0, (DB.enabletukui == true and -5 or -1))
			end

			JSHB.iconTimerFrames[j].value:SetJustifyH("CENTER")
			JSHB.iconTimerFrames[j].value:SetJustifyV((DB.timericonanchorparent == JSHB.pos.ABOVE) and "BOTTOM" or "TOP")

			if fontScale < .4 then fontScale = .4 end

			JSHB.iconTimerFrames[j].value:SetFont(JSHB.getFont(DB.timerfont), fontScale * 14, 'OUTLINE')
			JSHB.iconTimerFrames[j].value:SetTextColor(1, 1, 1, 1)
			JSHB.iconTimerFrames[j].value:SetAlpha(1)

			JSHB.iconTimerFrames[j].stacks = JSHB.iconTimerFrames[j]:CreateFontString(nil, "OVERLAY", JSHB.iconTimerFrames[j])
			JSHB.iconTimerFrames[j].stacks:SetJustifyH("LEFT")
			JSHB.iconTimerFrames[j].stacks:SetJustifyV("TOP")
			JSHB.iconTimerFrames[j].stacks:SetPoint("TOPLEFT", JSHB.iconTimerFrames[j], "TOPLEFT", (DB.enabletukui == true and -1 or 1), (DB.enabletukui == true and 2 or -1))
			JSHB.iconTimerFrames[j].stacks:SetFont(JSHB.getFont("Arial Narrow"), fontScale * 14, "OUTLINE")
			JSHB.iconTimerFrames[j].stacks:SetTextColor(1, 1, 0, 1)
			JSHB.iconTimerFrames[j].stacks:Show()

			JSHB.iconTimerFrames[j].updateTimer = 0
			JSHB.iconTimerFrames[j].timerTable = DB.timers[JSHB.specs[JSHB.currentTree]][x]
			JSHB.iconTimerFrames[j]:SetScript("OnUpdate", function(self, elapsed)

				self.updateTimer = self.updateTimer + elapsed

				if self.updateTimer > 0.04 then

					if JSHB.currentTree == nil then return end

					local v1, v2, v3, v4 = getAuraInfo(self.timerTable) -- true is duration(2) and player(3)

					if ((not v1) and (self.timerTable[2] == true) and (self.timerTable[3] == false or self.timerTable[3] == 0)) or
						(v1 and (self.timerTable[2] == true and (self.timerTable[3] ~= false and self.timerTable[3] ~= 0))) or
						(not v1 and (self.timerTable[2] == false) and (self.timerTable[3] ~= false and self.timerTable[3] ~= 0)) then

						self.Icon:SetAlpha(1)
					else
						self.Icon:SetAlpha(DB.alphaicontimersfaded)
					end

					self.value:SetText(formatTimeText(v3, DB.enabletimertenths, DB.timertextcoloredbytime, true))
					self.stacks:SetText((v4 and v4 ~= 0) and v4 or "")
				end
			end)

			JSHB.iconTimerFrames[j]:SetAlpha(1)
			JSHB.iconTimerFrames[j]:Show()

			j = j + 1
		end
	end
end


local function getMainSpell()

	JSHB.currentTree = GetPrimaryTalentTree()

	if JSHB.currentTree == nil then JSHB.currentTree = 1 end
	
	if JSHB.currentTree == 3 then
		return select(4, GetSpellInfo(53301)) -- Explosive Shot
	elseif JSHB.currentTree == 2 then
		return select(4, GetSpellInfo(53209))
	else
		return select(4, GetSpellInfo(34026)) -- Kill Command
	end
end


local function setTicks()

	if JSHB.tickMin then
		JSHB.tickMin:SetScript("OnUpdate", nil)
		JSHB.tickMin:Hide()
		JSHB.tickMin:SetParent(nil)
		JSHB.tickMin = nil
	end

	if not DB.enablemaintick then return end	

	JSHB.tickMin = CreateFrame("Frame", nil, mF)
	JSHB.tickMin:SetWidth(10)
	JSHB.tickMin:SetHeight(mF:GetHeight() * 1.6)

	JSHB.tickMin.backdrop = JSHB.tickMin:CreateTexture(nil,"OVERLAY")
	JSHB.tickMin.backdrop:SetAllPoints(JSHB.tickMin)
	JSHB.tickMin.backdrop:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")	
	JSHB.tickMin.backdrop:SetBlendMode("ADD")

	JSHB.tickMin.updateTimer = 0
	JSHB.tickMin:SetScript("OnUpdate", function(self, elapsed)

		self.updateTimer = self.updateTimer + elapsed

		if self.updateTimer > 0.15 then

			self:SetPoint("LEFT", mF, "LEFT", getMainSpell() * (mF:GetWidth() / select(2, mF:GetMinMaxValues())) - 5, 0)

			if UnitPower("player") >= getMainSpell() then
				self.backdrop:SetVertexColor(barColor[1], barColor[2], barColor[3], 1)
			else
				self.backdrop:SetVertexColor(DB.barcolorwarninglow[1], DB.barcolorwarninglow[2], DB.barcolorwarninglow[3], 1)
			end

			self:SetAlpha(1)
			self:Show()
		end
	end)
end


local function getPredictionAdjustment()

	-- Account for Termination talent extra focus
	if UnitHealth("target") / UnitHealthMax("target") <= 0.25 then 
		return (select(5, GetTalentInfo(2, 12)) * 3) -- Termination base per point = 3
	else
		return (0)
	end
end


local function getPredictionColor()

	-- class colored prediction is turned on
	if DB.classcoloredprediction then

		if DB.enablehighcolorwarning and ((UnitPower("player") / UnitPowerMax("player")) >= DB.focushighthreshold) then
			-- class colored but over high threshold
			return DB.predictionbarcolorwarninghigh
		else
			-- class colored not over high threshold or high threshold is turned off
			return JSHB.classColors
		end

	-- class colored prediction is not turned on
	elseif DB.enablehighcolorwarning and ((UnitPower("player") / UnitPowerMax("player")) >= DB.focushighthreshold) then

		-- over the threshold enabled, set to the high warning color	
		return DB.predictionbarcolorwarninghigh
	else
		-- not over threshold, set color to the hard-defined color because class colored prediction is not on		
		return DB.predictionbarcolor
	end
end


local function getBarColor()

	-- class colored is turned on
	if DB.classcolored then

		if DB.enablehighcolorwarning and ((UnitPower("player") / UnitPowerMax("player")) >= DB.focushighthreshold) then

			-- class colored but over high threshold
			return DB.barcolorwarninghigh

		elseif UnitPower("player") < getMainSpell() then

			-- Focus is lower than main shot
			return DB.barcolorwarninglow

		else
			-- class colored not over high threshold or high threshold is turned off
			return JSHB.classColors
		end

	-- class colored is not turned on
	elseif DB.enablehighcolorwarning and ((UnitPower("player") / UnitPowerMax("player")) >= DB.focushighthreshold) then

		-- over the threshold enabled, set to the high warning color	
		return DB.barcolorwarninghigh

	elseif UnitPower("player") < getMainSpell() then

		-- Focus is lower than main shot
		return DB.barcolorwarninglow

	else
		-- Set color to the hard-defined color because class colored is not on		
		return DB.barcolor
	end
end


local function setAutoShot()

	if mF.autoShotValue ~= nil then
		mF.autoShotValue:Hide()
		mF.autoShotValue = nil
	end
	
	if JSHB.autoShotFrame ~= nil then
		JSHB.autoShotFrame:Hide()
		JSHB.autoShotFrame:SetParent(nil)
		JSHB.autoShotFrame = nil
	end

	JSHB.autoShotStartTime = 0
	JSHB.autoShotEndTime = 0

	if DB.enableautoshotbar then

		JSHB.autoShotFrame = CreateFrame("StatusBar", nil, mF)

		JSHB.autoShotFrame:SetStatusBarTexture(mF:GetStatusBarTexture():GetTexture()) -- Use the main bar's texture
		JSHB.autoShotFrame:SetPoint("BOTTOMLEFT", mF, "BOTTOMLEFT", 0, 0)
		JSHB.autoShotFrame:SetMinMaxValues(0, UnitRangedDamage("player")*100)
		JSHB.autoShotFrame:SetSize(DB.barWidth, 3)
		JSHB.autoShotFrame:SetValue(UnitRangedDamage("player"))
		JSHB.autoShotFrame:SetFrameLevel(mF:GetFrameLevel() + 1)		
		JSHB.autoShotFrame:SetStatusBarColor(DB.autoshotbarcolor[1], DB.autoshotbarcolor[2], DB.autoshotbarcolor[3], 1)
		JSHB.autoShotFrame:SetAlpha(1)

		JSHB.autoShotFrame.updateTimer = 0
		JSHB.autoShotFrame:SetScript("OnUpdate", function(self, elapsed)

			self.updateTimer = self.updateTimer + elapsed

			if self.updateTimer <= 0.04 then
				return
			else
				self.updateTimer = 0
			end

			if (GetTime() < JSHB.autoShotEndTime) then
				self:SetValue((UnitRangedDamage("player") * 100) - ((JSHB.autoShotEndTime * 100) - (GetTime() * 100)))
			else
				self:Hide()
			end
		end)
	end

	if DB.enableautoshottext then

		mF.autoShotValue = mF:CreateFontString(nil, "OVERLAY")

		mF.autoShotValue:SetFont(JSHB.getFont(DB.timerfont), mF:GetHeight() * .7, "OUTLINE")
		mF.autoShotValue:SetTextColor(1, 1, 1)
		mF.autoShotValue:SetPoint("BOTTOMRIGHT", mF, "BOTTOMRIGHT", 1, 0)
		mF.autoShotValue:SetJustifyH("BOTTOM")
		mF.autoShotValue:SetAlpha(1)
		mF.autoShotValue:Show()

		JSHB.functionChain[#JSHB.functionChain + 1] = function(self, elapsed)

			if self.updateTimer <= 0.07 then return	end		

			if (not UnitIsDeadOrGhost("player")) and (GetTime() < JSHB.autoShotEndTime) and (isCombatActive()) then

				mF.autoShotValue:SetFormattedText("%.1f", JSHB.autoShotEndTime - GetTime())
			else
				mF.autoShotValue:SetText("")
			end
		end
	end
end


local function updatePrediction()

	if DB.enableprediction and JSHB.isCasting then

		barColor = getPredictionColor()

		JSHB.predictionFrame:SetSize((mF:GetWidth() / 100) * (JSHB.predictionSpellBase + getPredictionAdjustment()), mF:GetHeight())

		JSHB.predictionFrame:ClearAllPoints()
		JSHB.predictionFrame:SetPoint("LEFT", mF, "LEFT", mF:GetWidth() / (select(2, mF:GetMinMaxValues()) / mF:GetValue()), 0)

		if (UnitPower("player") + JSHB.predictionSpellBase + getPredictionAdjustment()) <= UnitPowerMax("player") then

			if (UnitPower("player") + JSHB.predictionSpellBase + getPredictionAdjustment()) >= getMainSpell() then

				JSHB.predictionFrame:SetStatusBarColor(barColor[1], barColor[2], barColor[3], 1)
			else
				JSHB.predictionFrame:SetStatusBarColor(DB.barcolorwarninglow[1], DB.barcolorwarninglow[2], DB.barcolorwarninglow[3], 1)
			end

		else
			JSHB.predictionFrame:SetSize((mF:GetWidth() / 100) * (UnitPowerMax("player") - UnitPower("player")), mF:GetHeight())
			JSHB.predictionFrame:SetStatusBarColor(DB.barcolorwarninglow[1], DB.barcolorwarninglow[2], DB.barcolorwarninglow[3], 1)
		end

		if ((UnitPowerMax("player") - UnitPower("player")) > 0) and (not UnitIsDeadOrGhost("player")) then

			JSHB.predictionFrame:SetAlpha(mF:GetAlpha() * 0.7)
			JSHB.predictionFrame:Show()

		else
			JSHB.predictionFrame:Hide()
		end
	end
end


local function setPrediction()

	barColor = getPredictionColor()

	if JSHB.predictionFrame then
		JSHB.predictionFrame:Hide()
		JSHB.predictionFrame:SetParent(nil)
		JSHB.predictionFrame = nil
	end

	if not DB.enableprediction then return end

	JSHB.predictionFrame = CreateFrame("StatusBar", nil, mF)

	JSHB.predictionFrame:SetStatusBarTexture(mF:GetStatusBarTexture():GetTexture()) -- Use the main bar's texture
	JSHB.predictionFrame:SetMinMaxValues(0, 1)
	JSHB.predictionFrame:SetValue(1)
	JSHB.predictionFrame:SetFrameLevel(mF:GetFrameLevel())

	JSHB.predictionFrame:SetSize((mF:GetWidth() / 100) * (JSHB.predictionSpellBase + getPredictionAdjustment()), mF:GetHeight())
   
	JSHB.predictionFrame:Hide()

	if (UnitPower("player") + JSHB.predictionSpellBase + getPredictionAdjustment()) <= UnitPowerMax("player") then
		JSHB.predictionFrame:SetStatusBarColor(barColor[1], barColor[2], barColor[3], 1)
	else
		JSHB.predictionFrame:SetSize((mF:GetWidth() / 100) * (UnitPowerMax("player") - UnitPower("player")), mF:GetHeight())		
		JSHB.predictionFrame:SetStatusBarColor(DB.barcolorwarninglow[1], DB.barcolorwarninglow[2], DB.barcolorwarninglow[3], 1)
	end
end


local function setStackBars()

	local numBars, barSize
	local checkFunction
	local i

	for i=1,5 do
		if JSHB.stackBarFrames[i] then
			JSHB.stackBarFrames[i]:SetScript("OnUpdate", nil)
			JSHB.stackBarFrames[i]:Hide()
			JSHB.stackBarFrames[i] = nil
		end
	end

	JSHB.stackBarOn = false

	if not DB.enablestackbars then return end

	if JSHB.currentTree == 1 then 	-- bm
	
		numBars = 5 -- Frenzy Stacks on pet for using focus fire.

		if (not select(5, GetTalentInfo(1, 6))) then return end -- Frenzy

		checkFunction = function(self, index)

			local stacks = select(4, UnitAura("pet", GetSpellInfo(19615), nil, "HELPFUL")) or 0 -- 19615 = Frenzy Effect

			if (stacks == 0) then

				if JSHB.stackBarOn then

					mF.backdrop:ClearAllPoints()
					mF.backdrop:SetPoint("TOPLEFT", -2, 2)
					mF.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
					JSHB.stackBarOn = false
				end
				self:SetAlpha(0)
				return false

			elseif (stacks > 0) and (not JSHB.stackBarOn) then

				mF.backdrop:ClearAllPoints()
				mF.backdrop:SetPoint("TOPLEFT", -2, DB.movestackbarstotop and 12 or 2)
				mF.backdrop:SetPoint("BOTTOMRIGHT", 2, DB.movestackbarstotop and -2 or -12)
				JSHB.stackBarOn = true
			end

			if stacks >= index then
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
				if stacks == 5 then
					self:SetAlpha(1)
					return true
				end
			else
				self.backdrop:SetTexture(0, 0, 0, 1) -- Black
			end

			self:SetAlpha(1)
			return false
		end

	elseif JSHB.currentTree == 2 then 	-- mm
	
		numBars = 5 -- Ready, Set, Aim... on player

		checkFunction = function(self, index)
			local proc = select(1, UnitAura("player", GetSpellInfo(82926), nil, "HELPFUL")) or false -- 82926 = Fire! proc
			local stacks = select(4, UnitAura("player", GetSpellInfo(82925), nil, "HELPFUL")) or 0 -- 82925 = Ready, Set, Aim...

			if proc then
				if not JSHB.stackBarOn then

					mF.backdrop:ClearAllPoints()
					mF.backdrop:SetPoint("TOPLEFT", -2, DB.movestackbarstotop and 12 or 2)
					mF.backdrop:SetPoint("BOTTOMRIGHT", 2, DB.movestackbarstotop and -2 or -12)
					JSHB.stackBarOn = true					
				end
				self:SetAlpha(1)
				return true
			end

			if (stacks == 0) then

				if JSHB.stackBarOn then

					mF.backdrop:ClearAllPoints()
					mF.backdrop:SetPoint("TOPLEFT", -2, 2)
					mF.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
					JSHB.stackBarOn = false
				end

				self:SetAlpha(0)
				return false

			elseif (stacks > 0) and (not JSHB.stackBarOn) then

				mF.backdrop:ClearAllPoints()
				mF.backdrop:SetPoint("TOPLEFT", -2, DB.movestackbarstotop and 12 or 2)
				mF.backdrop:SetPoint("BOTTOMRIGHT", 2, DB.movestackbarstotop and -2 or -12)
				JSHB.stackBarOn = true
			end

			if stacks >= index then				
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
			else
				self.backdrop:SetTexture(0, 0, 0, 1) -- Black
			end

			self:SetAlpha(1)
			return false
		end
	else 				-- sv
	
		numBars = 2

		if (not select(5, GetTalentInfo(3, 10))) then return end -- Lock n' Load

		checkFunction = function(self, index)
		
			local stacks = select(4, UnitAura("player", GetSpellInfo(56342), nil, "HELPFUL")) or 0 -- 56342 = Lock n' Load proc

			if stacks ~= 0 then
				if not JSHB.stackBarOn then

					mF.backdrop:ClearAllPoints()
					mF.backdrop:SetPoint("TOPLEFT", -2, DB.movestackbarstotop and 12 or 2)
					mF.backdrop:SetPoint("BOTTOMRIGHT", 2, DB.movestackbarstotop and -2 or -12)
					JSHB.stackBarOn = true					
				end
			else
				if JSHB.stackBarOn then

					mF.backdrop:ClearAllPoints()
					mF.backdrop:SetPoint("TOPLEFT", -2, 2)
					mF.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
					JSHB.stackBarOn = false
				end
			end			
			
			if stacks >= index then			
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
				self:SetAlpha(1)
				return true
			else
				self.backdrop:SetTexture(0, 0, 0, 1) -- Black
				self:SetAlpha(0)
			end
			return false
		end
	end

	JSHB.stackBarOn = true

	mF.backdrop:ClearAllPoints()
	mF.backdrop:SetPoint("TOPLEFT", -2, DB.movestackbarstotop and 12 or 2)
	mF.backdrop:SetPoint("BOTTOMRIGHT", 2, DB.movestackbarstotop and -2 or -12)

	barSize = ((DB.barWidth - ((numBars-1) * 4)) - 2) / numBars
	for i=1,numBars do

		JSHB.stackBarFrames[i] = CreateFrame("Frame", nil, mF)
		JSHB.stackBarFrames[i]:SetSize(barSize, 5)

		if DB.movestackbarstotop then
			JSHB.stackBarFrames[i]:SetPoint("BOTTOMLEFT", mF, "TOPLEFT", 1 + (barSize + 4) * (i-1) , 3)
		else
			JSHB.stackBarFrames[i]:SetPoint("TOPLEFT", mF, "BOTTOMLEFT", 1 + (barSize + 4) * (i-1) , -3)
		end

		JSHB.stackBarFrames[i].border = CreateFrame("Frame", nil, JSHB.stackBarFrames[i])

		JSHB.stackBarFrames[i].border:SetBackdrop({
		  bgFile = JSHB.getTexture("Blank"), 
		  edgeFile = JSHB.getTexture("Blank"), 
		  tile = false, tileSize = 0, edgeSize = 1, 
		  insets = { left = -1, right = -1, top = -1, bottom = -1}
		})

		JSHB.stackBarFrames[i].border:SetPoint("TOPLEFT", -1, 1)
		JSHB.stackBarFrames[i].border:SetPoint("BOTTOMRIGHT", 1, -1)
		JSHB.stackBarFrames[i].border:SetFrameLevel(JSHB.stackBarFrames[i]:GetFrameLevel() - 1)

		if IsAddOnLoaded("Tukui") and strsub(GetAddOnMetadata("Tukui", "Version"),1, 2) == "13" then
			JSHB.stackBarFrames[i].border:SetBackdropColor(TukUI_backdropr, TukUI_backdropb, TukUI_backdropb,1)
			JSHB.stackBarFrames[i].border:SetBackdropBorderColor(TukUI_borderr, TukUI_borderg, TukUI_borderb,1)
		else
			JSHB.stackBarFrames[i].border:SetBackdropColor(.1,.1,.1,1)
			JSHB.stackBarFrames[i].border:SetBackdropBorderColor(.6,.6,.6,1)
		end

		JSHB.stackBarFrames[i].backdrop = JSHB.stackBarFrames[i]:CreateTexture(nil, "BACKGROUND", JSHB.stackBarFrames[i])
		JSHB.stackBarFrames[i].backdrop:SetPoint("TOPLEFT", 1, -1)
		JSHB.stackBarFrames[i].backdrop:SetPoint("BOTTOMRIGHT", -1, 1)

		JSHB.stackBarFrames[i].barIndex = i
		JSHB.stackBarFrames[i].checkFunction = checkFunction
		JSHB.stackBarFrames[i].updateTimer = 0
		JSHB.stackBarFrames[i].updateFlash = 0
		JSHB.stackBarFrames[i].backdrop:SetTexture(0, .6, 0, 1) -- Green

		JSHB.stackBarFrames[i]:SetScript("OnUpdate", function(self, elapsed)

			self.updateTimer = self.updateTimer + elapsed

			if self.updateTimer > 0.15 then

				if self.checkFunction(self, self.barIndex) then

					self.updateFlash = (self.updateFlash >= .5) and 0 or self.updateFlash + .05
					self.backdrop:SetTexture(0, .3 + self.updateFlash, 0, 1)

				end
			end
		end)

		JSHB.stackBarFrames[i]:SetAlpha(0)
		JSHB.stackBarFrames[i]:Show()
	end
end


local function setTranqables()

	local i

	if JSHB.tranqablesFrames then
	
		for i=1,40 do
			if JSHB.tranqablesFrames[i] ~= nil then
				JSHB.tranqablesFrames[i]:Hide()
				JSHB.tranqablesFrames[i]:SetParent(nil)
				JSHB.tranqablesFrames[i] = nil
			end
		end

		JSHB.tranqablesFrames = nil
	end
	
	if JSHB.tranqablesFrame ~= nil then
		JSHB.tranqablesFrame:Hide()
		JSHB.tranqablesFrame:SetScript("OnUpdate", nil)
		JSHB.tranqablesFrame:SetParent(nil)
		JSHB.tranqablesFrame = nil		
	end

	if not DB.enabletranqablesframe then return end

	JSHB.tranqablesFrame = CreateFrame("Frame", nil, mF)
	JSHB.tranqablesFrame:SetWidth(((DB.tranqablesiconsize + (DB.enabletukui and 6 or 2)) * 8) - (DB.enabletukui and 6 or 2))
	JSHB.tranqablesFrame:SetHeight(((DB.tranqablesiconsize + (DB.enabletukui and 6 or 2)) * 5) - (DB.enabletukui and 6 or 2))
	JSHB.tranqablesFrame:SetPoint(DB.tranqablesAnchorPoint, 'UIParent', DB.tranqablesAnchorPointRelative, DB.tranqablesAnchorPointOffsetX, DB.tranqablesAnchorPointOffsetY)

	JSHB.tranqablesFrames = {}
	for i=1,40 do
		JSHB.tranqablesFrames[i] = CreateFrame("Frame", nil, JSHB.tranqablesFrame)
		JSHB.tranqablesFrames[i]:SetWidth(DB.tranqablesiconsize)
		JSHB.tranqablesFrames[i]:SetHeight(DB.tranqablesiconsize)
		JSHB.tranqablesFrames[i]:SetPoint("TOPLEFT", JSHB.tranqablesFrame, "TOPLEFT",
			((DB.tranqablesiconsize + (DB.enabletukui and 6 or 2)) * mod(i-1, 8)), -((DB.tranqablesiconsize + (DB.enabletukui and 6 or 2)) * floor((i-1) / 8)))
			
		JSHB.tranqablesFrames[i].Icon = JSHB.tranqablesFrames[i]:CreateTexture(nil, "BACKGROUND")
		JSHB.tranqablesFrames[i].Icon:SetAllPoints(JSHB.tranqablesFrames[i])
		JSHB.tranqablesFrames[i].Icon:SetTexture(select(3, GetSpellInfo(19801))) -- For testing
		
		if DB.enabletukui then
			JSHB.tranqablesFrames[i].border = makeTukui(JSHB.tranqablesFrames[i])
		end
		
		JSHB.tranqablesFrames[i]:SetAlpha(1)
		JSHB.tranqablesFrames[i]:Hide()
		JSHB.tranqablesFrames[i].spellID = 0
		
		if DB.enabletranqablestips then

				JSHB.tranqablesFrames[i]:SetScript("OnEnter", function(self)

				if (self.spellID == 0) then return end

				local index
				for index=1,40 do
					if (select(11, UnitBuff("target", index)) == self.spellID) then
						GameTooltip:SetOwner(self)
						GameTooltip:SetUnitBuff("target", index)
						GameTooltip:Show()
						return
					end
				end
			end)
			JSHB.tranqablesFrames[i]:SetScript("OnLeave", function(self)
				if self.spellID == 0 then return end
				GameTooltip:Hide()
				end)
		end
	end
	
	JSHB.tranqablesFrame.updateTimer = 0
	JSHB.tranqablesFrame:SetScript("OnUpdate", function(self, elapsed, ...)
	
		self.updateTimer = self.updateTimer + elapsed
		
		if self.updateTimer < 0.1 then return end
		
		local i
		if not UnitCanAttack("player", "target") then
		--if 0==1 then -- For testing
			for i=1,40 do
				JSHB.tranqablesFrames[i].spellID = 0
				JSHB.tranqablesFrames[i]:Hide()
			end			
		else
			local j = 1
			for i=1,40 do			
				local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId  = UnitBuff("target", i)

				if debuffType == "Magic" then
					JSHB.tranqablesFrames[j].spellID = spellId
					JSHB.tranqablesFrames[j].Icon:SetTexture(select(3, GetSpellInfo(spellId)))
					JSHB.tranqablesFrames[j]:Show()
					j = j + 1
				end
			end
			
			for i=j,40 do
				JSHB.tranqablesFrames[i]:Hide()
				JSHB.tranqablesFrames[i].spellID = 0
			end
		end
	end)
end


function mF:CreateFrame()

	mF:SetStatusBarTexture(JSHB.getTexture(DB.bartexture))
	mF:SetMinMaxValues(0, 100)
	mF:SetValue(100)

	mF.backdrop = mF:CreateTexture(nil, "BACKGROUND", mF)
	mF.backdrop:SetPoint("TOPLEFT", -2, 2)
	mF.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	mF.backdrop:SetTexture(0, 0, 0, .5)

	mF:SetScript("OnDragStart", mF.StartMoving)
	mF:SetScript("OnDragStop", mF.StopMovingOrSizing)
end


SlashCmdList.JSHB = function(msg, editbox)

	local v1, v2 = msg:match("^(%S*)%s*(.-)$");
	
	v1 = v1:lower()

	if v1 == "" then

		if not debug then

			print("|cffabd473" .. L.slashdesc1 .. strsub(JSHB.ver,7) .. "|r")
			print("/jsb config - " .. L.slashdesc2)
			print("/jsb lock - " .. L.slashdesc3)
			print("/jsb reset - " .. L.slashdesc4)

		else
			print("Debug Info: N/A")
			print("addDebuffAlert(95809, 16, 150)"); addDebuffAlert(95809, 16, 150) -- For testing, adds a Debuff alert manually
		end

	elseif v1 == "options" or v1 == "config" or v1 == "opt" or v1 == "o" then

		JSHB.loadOptionsAddon()
		if JSHB.optionsAreLoaded == true then
			InterfaceOptionsFrame_OpenToCategory(JSHB.options)
		end

	elseif v1 == "reset" then

			if not JSHB.barLocked then 

				JSHB.barLocked = not JSHB.barLocked
				if JSHB.optionsAreLoaded then
					if JSHB.barLocked then JSHB.options.enablebarlock:SetChecked(true) else JSHB.options.enablebarlock:SetChecked(false) end
				end
				mF:ApplyLock()
			end

			local x, y
			for x,y in pairs(JSHB.defaults["main"]) do 
				DB[x] = y
			end

			JSHB.reconfigureAddon()

	elseif v1 == "lock" or v1 == "unlock" or v1 == "drag" or v1 == "move" or v1 == "l" then

		JSHB.barLocked = not JSHB.barLocked
		if JSHB.optionsAreLoaded then
			if JSHB.barLocked then JSHB.options.enablebarlock:SetChecked(true) else JSHB.options.enablebarlock:SetChecked(false) end
		end
		mF:ApplyLock()
		
	elseif v1 == "id" or v1 == "frameid" then
	
		print(format("Hovered Frame's Name: |cffFFD100"), GetMouseFocus():GetName())
		print(format("Hovered Frame's Parent Name: |cffFFD100"), GetMouseFocus():GetParent():GetName())	
		
	else
		print(L.invalidoption)
	end
end


local function enableFrameUnlock(source, mover, moveText, w, h, v1, v2, x, y)

	if source[1] ~= nil then
		local i = 1
		while source[i] ~= nil do
			source[i]:Hide()
			i = i + 1
		end
	else
		source:Hide()
	end

	mover:SetWidth(w)
	mover:SetHeight(h)
	mover:ClearAllPoints()
	mover:SetPoint(DB[v1], 'UIParent', DB[v2], DB[x], DB[y])

	if not mover.backdrop then 
		mover.backdrop = mover:CreateTexture(nil, "BACKGROUND", mover)
		mover.backdrop:SetAllPoints(mover)
		mover.backdrop:SetTexture(JSHB.moveColor[1], JSHB.moveColor[2], JSHB.moveColor[3], JSHB.moveColor[4])
		mover.backdrop:SetAlpha(1)
		mover.backdrop:Show()

		mover.value = mover:CreateFontString(nil, "OVERLAY", mover)
		mover.value:SetJustifyH("CENTER")
		mover.value:SetPoint("BOTTOM", mover, "TOP", 0, 2)
		mover.value:SetFont(JSHB.getFont("Arial Narrow"), 15, "OUTLINE")
		mover.value:SetTextColor(1, 1, 1, 1)
		mover.value:SetText(moveText)
	end

	mover:Show()
	mover:EnableMouse(true)
	mover:RegisterForDrag("LeftButton", "RightButton")
	mover:SetScript("OnDragStart", mover.StartMoving)
	mover:SetScript("OnDragStop", mover.StopMovingOrSizing)
	mover:SetMovable(true)
end


local function enableFrameLock(mover, v1, v2, x, y, setupCaller)

	DB[v1], _, DB[v2], DB[x], DB[y] = mover:GetPoint()

	mover:StopMovingOrSizing()
	mover:SetMovable(false)
	mover:EnableMouse(false)
	mover:RegisterForDrag()
	mover:Hide()

	if setupCaller then setupCaller() end
end


function mF:ApplyLock()

	if JSHB.barLocked then -- LOCK

		print(L.nowlocked)

		DB.anchorPoint, _, DB.anchorPointRelative, DB.anchorPointOffsetX, DB.anchorPointOffsetY = mF:GetPoint()

		mF:StopMovingOrSizing()		
		mF:SetMovable(false)
		mF:EnableMouse(false)
		mF:RegisterForDrag()

		mF.backdrop:SetTexture(0, 0, 0, DB.alphabackdrop)

		enableFrameLock(JSHB.anchorFrame.tranqAlert, "alertAnchorPoint", "alertAnchorPointRelative", "alertAnchorPointOffsetX", "alertAnchorPointOffsetY", setTranqAlert)
		enableFrameLock(JSHB.anchorFrame.tranqables, "tranqablesAnchorPoint", "tranqablesAnchorPointRelative", "tranqablesAnchorPointOffsetX", "tranqablesAnchorPointOffsetY", setTranqables)
		enableFrameLock(JSHB.anchorFrame.markReminder, "markAnchorPoint", "markAnchorPointRelative", "markAnchorPointOffsetX", "markAnchorPointOffsetY", setMarkReminder)
		enableFrameLock(JSHB.anchorFrame.ccIcons, "ccAnchorPoint", "ccAnchorPointRelative", "ccAnchorPointOffsetX", "ccAnchorPointOffsetY", setCCTimers)
		enableFrameLock(JSHB.anchorFrame.debuffAlert, "debuffAnchorPoint", "debuffAnchorPointRelative", "debuffAnchorPointOffsetX", "debuffAnchorPointOffsetY", setDebuffAlert)
		enableFrameLock(JSHB.anchorFrame.cdIcons, "cdIconAnchorPoint", "cdIconAnchorPointRelative", "cdIconAnchorPointOffsetX", "cdIconAnchorPointOffsetY", setAllTimers)

		JSHB.updateMainFrame()

	else -- UNLOCK

		print(L.nowunlocked)

		mF:SetAlpha(1)
		mF:SetMovable(true)
		mF:EnableMouse(true)
		mF:RegisterForDrag("LeftButton", "RightButton")

		mF.backdrop:SetTexture(JSHB.moveColor[1], JSHB.moveColor[2], JSHB.moveColor[3], JSHB.moveColor[4])

		if DB.enabletranqalert then
			enableFrameUnlock(JSHB.tranqFrame, JSHB.anchorFrame.tranqAlert, L.movetranqalert, DB.taiconsize, DB.taiconsize,
				"alertAnchorPoint", "alertAnchorPointRelative", "alertAnchorPointOffsetX", "alertAnchorPointOffsetY")
		end

		if DB.enabletranqablesframe then
			enableFrameUnlock(JSHB.tranqablesFrame, JSHB.anchorFrame.tranqables, L.movetranqables,
			(((DB.tranqablesiconsize + (DB.enabletukui and 6 or 2)) * 8) - (DB.enabletukui and 6 or 2)),
			(((DB.tranqablesiconsize + (DB.enabletukui and 6 or 2)) * 5) - (DB.enabletukui and 6 or 2)),
				"tranqablesAnchorPoint", "tranqablesAnchorPointRelative", "tranqablesAnchorPointOffsetX", "tranqablesAnchorPointOffsetY")
		end
		
		if DB.enablehuntersmarkwarning then
			enableFrameUnlock(JSHB.markFrame, JSHB.anchorFrame.markReminder, L.movemarkreminder, DB.markIconSize, DB.markIconSize,
				"markAnchorPoint", "markAnchorPointRelative", "markAnchorPointOffsetX", "markAnchorPointOffsetY")
		end

		if DB.enablecctimers then
			enableFrameUnlock(JSHB.cCIconFrames, JSHB.anchorFrame.ccIcons, L.movecctimers, DB.cCIconSize, DB.cCIconSize,
				"ccAnchorPoint", "ccAnchorPointRelative", "ccAnchorPointOffsetX", "ccAnchorPointOffsetY")
		end

		if DB.enabledebuffalert then
			enableFrameUnlock(JSHB.debuffIconFrames, JSHB.anchorFrame.debuffAlert, L.movedebuffalert, DB.debufficonsize, DB.debufficonsize,
				"debuffAnchorPoint", "debuffAnchorPointRelative", "debuffAnchorPointOffsetX", "debuffAnchorPointOffsetY")
		end

		if (JSHB.numTimersOnLeft + JSHB.numTimersOnRight > 0) and (DB.timericonanchorparent == JSHB.pos.MOVABLE) then

			local v
			if (DB.enabletukui == true) then
				v = (DB.icontimersgap >= 6) and (DB.icontimersgap/2) or 3
			else
				v = (DB.icontimersgap >= 2) and (DB.icontimersgap/2) or 1
			end

			v = v + ((DB.icontimerssize + (DB.enabletukui == true and 6 or 2)) * max(JSHB.numTimersOnLeft, JSHB.numTimersOnRight))
			v = v * 2

			enableFrameUnlock(JSHB.iconTimerFrames, JSHB.anchorFrame.cdIcons, L.moveicontimers, v, DB.icontimerssize + ((DB.enabletukui == true) and 4 or 0),
				"cdIconAnchorPoint", "cdIconAnchorPointRelative", "cdIconAnchorPointOffsetX", "cdIconAnchorPointOffsetY")
		end
	end
end


function mF:ApplyOptions()

	local barColor = getBarColor()

	mF:SetScript("OnUpdate", nil)
	JSHB.functionChain = {}
	
	if mF.targetHealthValue then
		mF.targetHealthValue:Hide()
		mF.targetHealthValue = nil
	end

	if mF.border then
		mF.border:Hide()
		mF.border:SetParent(nil)
		mF.border = nil
	end

	if mF.value then
		mF.value:Hide()
		mF.value = nil
	end

	if DB.enabletukui then
		mF.border = makeTukui(mF, true)

		if JSHB.stackBarOn then
			mF.border:ClearAllPoints()
			mF.border:SetPoint("TOPLEFT", -2, DB.movestackbarstotop and 12 or 2)
			mF.border:SetPoint("BOTTOMRIGHT", 2, DB.movestackbarstotop and -2 or -12)
		end
	end

	mF:SetStatusBarTexture(JSHB.getTexture(DB.bartexture))
	mF:SetMinMaxValues(0, (UnitPowerMax("player") > 0) and UnitPowerMax("player") or 100)	
	mF:SetStatusBarColor(barColor[1], barColor[2], barColor[3], 1)
	mF:ClearAllPoints()
	mF:SetSize(DB.barWidth, DB.barHeight)
	mF:SetPoint(DB.anchorPoint, 'UIParent', DB.anchorPointRelative, DB.anchorPointOffsetX, DB.anchorPointOffsetY)

	mF.backdrop:ClearAllPoints()
	mF.backdrop:SetPoint("TOPLEFT", -2, 2)
	mF.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	mF.backdrop:SetTexture(0, 0, 0, DB.alphabackdrop)

	mF:SetValue(UnitPower("player"))
	
	if DB.enablecurrentfocustext then
		mF.value = mF:CreateFontString(nil, "OVERLAY", mF)
		mF.value:SetJustifyH("CENTER")
		mF.value:SetPoint("CENTER", mF, "CENTER", DB.focuscenteroffset, (DB.enableautoshotbar == true) and 2 or 0)
		mF.value:SetFont(JSHB.getFont(DB.barfont), DB.fontsize, DB.fontoutlined and "OUTLINE" or "")
		mF.value:SetTextColor(1, 1, 1, 1)
		mF.value:SetText(UnitPower("player"))
	end

	JSHB.functionChain[#JSHB.functionChain + 1] = function(self, elapsed) if self.updateTimer > 0.06 then JSHB.updateMainFrame() end end

	if DB.enabletargethealthpercent then

		mF.targetHealthValue = mF:CreateFontString(nil, "OVERLAY", mF)
		mF.targetHealthValue:SetJustifyH("LEFT")
		mF.targetHealthValue:SetPoint("LEFT", mF, "LEFT", 1, (DB.enableautoshotbar == true) and 2 or 0)
		mF.targetHealthValue:SetFont(JSHB.getFont(DB.barfont), DB.fontsize * .8, "OUTLINE")

		JSHB.functionChain[#JSHB.functionChain + 1] = function(self, elapsed)

			if self.updateTimer <= 0.25 then return end

			if (not UnitExists("target")) or (UnitIsDeadOrGhost("target")) then 

				mF.targetHealthValue:SetText("")

			else
				if UnitHealth("target") / UnitHealthMax("target") >= .8 then
				
					mF.targetHealthValue:SetFormattedText("|cffffff00%d %%|r", (UnitHealth("target") / UnitHealthMax("target")) * 100)
					
				elseif UnitHealth("target") / UnitHealthMax("target") >= .2 then
				
					mF.targetHealthValue:SetFormattedText("|cffffffff%d %%|r", (UnitHealth("target") / UnitHealthMax("target")) * 100)
					
				else
					mF.targetHealthValue:SetFormattedText("|cffff0000%d %%|r", (UnitHealth("target") / UnitHealthMax("target")) * 100)
				end
			end
		end
	end

	setTicks()
	setAutoShot()
	setPrediction()
	setAllTimers()
	setCCTimers()
	setMarkReminder()
	setTranqAlert()
	setDebuffAlert()
	setStackBars()
	setMisdirects()
	setTranqables()

	-- Setup the function chain caller for the main bar, this allows for modules later.
	mF.updateTimer = 0
	mF:SetScript("OnUpdate", function(self, elapsed, ...)
		self.updateTimer = self.updateTimer + elapsed
		local i
		for i=1,#JSHB.functionChain do
			JSHB.functionChain[i](self, elapsed, ...)
		end
	end)
end


JSHB.reconfigureAddon = function()
	mF:ApplyOptions()
end


local function getMatchTableVal(wTable, colMatch, colReturn, toMatch)
	local i
	for i=1,#wTable do
		if wTable[i][colMatch] == toMatch then return wTable[i][colReturn] end
	end
	return nil
end


local function getMatchTablePosition(wTable, colMatch, toMatch)
	local i
	for i=1,#wTable do
		if wTable[i][colMatch] == toMatch then return(i) end
	end
	return nil
end


function mF.fixIconTimerIndex(timerTable, sidePos, modifiedTimerTableIndex)

	if (sidePos ~= JSHB.pos.LEFT) and (sidePos ~= JSHB.pos.RIGHT) then return(timerTable) end

	local workTable = {}
	local workTableTimer = {}
	local fixIt = false
	local j = 1
	local i

	for i = 1, #timerTable do
		if timerTable[i][4] == sidePos then
			workTable[j] = { i, timerTable[i][5] }
			if workTable[j][2] == nil then fixIt = true end 
			j = j + 1
		end
	end

	-- If we find a bad entry in the table, we need to fix it before we do any repositioning
	if fixIt then
		for i=1,#workTable do workTable[i][2] = i end
	else
		-- Much easier to work with a sequential table!
		table.sort(workTable, function(a,b) return a[2] < b[2] end)
	end

	-- Working icon timer table is now valid continue on with any insert
	if modifiedTimerTableIndex then

		local idx = getMatchTablePosition(workTable, 1, modifiedTimerTableIndex)
		workTableTimer = workTable[idx]
		table.remove(workTable, idx)
		table.insert(workTable, workTableTimer[2], workTableTimer)
		for i = 1,#workTable do workTable[i][2] = i end
	end

	-- Verify no gaps in the table
	for i = 1,#workTable do
		workTable[i][2] = i
	end

	-- All done, return a valid/validated table
	for i=1,#workTable do
		timerTable[workTable[i][1]][5] = workTable[i][2]
	end

	workTable = nil
	return(timerTable)
end


function JSHB.updateMainFrame()

	mF:SetValue(UnitPower("player"))
	
	if DB.enablecurrentfocustext and (mF.value ~= nil) then
		mF.value:SetText(UnitPower("player"))
	end

	local barColor = getBarColor()
	mF:SetStatusBarColor(barColor[1], barColor[2], barColor[3], 1)

	if (UnitPower("player") == 0) or (UnitIsDeadOrGhost("player")) then
		if JSHB.barLocked then 
			mF:SetAlpha(isCombatActive() and DB.alphazero or DB.alphazeroooc) 
		end
	else
		if UnitPower("player") == UnitPowerMax("player") then

			if JSHB.barLocked then 
				mF:SetAlpha(isCombatActive() and DB.alphamax or DB.alphamaxooc)
			end

		else
			if JSHB.barLocked then mF:SetAlpha(isCombatActive() and DB.alphanorm or DB.alphanormooc) end
		end
	end

	updatePrediction()
end


mF:RegisterEvent("ADDON_LOADED")
mF:RegisterEvent("PLAYER_LOGIN")


mF:SetScript("OnEvent", function(self, event, ...)

	local spellCastID
	local i, x, y, d

	if event == "ADDON_LOADED" then

		self:UnregisterEvent("ADDON_LOADED")

		local addon = ...
		if addon:lower() ~= "jshunterbar" then return end

		JSHB_SavedOptionsGlobal = JSHB_SavedOptionsGlobal
		JSHB_SavedOptions = JSHB_SavedOptions
		
		local newInstall = false
		if not JSHB_SavedOptions then
			JSHB_SavedOptions = {}
			newInstall = true
		end
		
		-- Add in faction specific defaults to the spec defaults tables
		for x,y in pairs(JSHB.defaults.faction[select(1,UnitFactionGroup("player"))]) do
			for i=1,#y do
				JSHB.defaults[x][#JSHB.defaults[x]+1] = y[i]
			end
		end
		
		-- Compact version of configuration settings for new installs and checking variables of existing installs
		for x,y in pairs(JSHB.defaults["main"]) do
			if JSHB_SavedOptions[x] == nil then JSHB_SavedOptions[x] = y end
		end
		for x,y in pairs(JSHB.defaults["general"]) do
			if JSHB_SavedOptions[x] == nil then JSHB_SavedOptions[x] = y end
		end
		for x,y in pairs(JSHB.defaults["style"]) do
			if JSHB_SavedOptions[x] == nil then JSHB_SavedOptions[x] = y end
			
			if JSHB_SavedOptions["iconSize"] == 0 then 
				JSHB_SavedOptions["iconSize"] = JSHB.defaults["style"]["iconSize"]
			end
		end
		for x,y in pairs(JSHB.defaults["fontstextures"]) do
			if JSHB_SavedOptions[x] == nil then JSHB_SavedOptions[x] = y end
			
			if JSHB_SavedOptions["timerfont"] == "Arial" then 
				JSHB_SavedOptions["timerfont"] = JSHB.defaults["fontstextures"]["timerfont"]
			end
		end
		for x,y in pairs(JSHB.defaults["colors"]) do
			if JSHB_SavedOptions[x] == nil then JSHB_SavedOptions[x] = y end
		end

		if JSHB_SavedOptions.timers == nil then
			JSHB_SavedOptions.timers = {}
		end

		for x=1,#JSHB.specs do

			if JSHB_SavedOptions.timers[JSHB.specs[x]] == nil then

				if newInstall then
					JSHB_SavedOptions.timers[JSHB.specs[x]] = JSHB.defaults[JSHB.specs[x]]
				else
					JSHB_SavedOptions.timers[JSHB.specs[x]] = {}
				end
			end

			if (#JSHB_SavedOptions.timers[JSHB.specs[x]] > 0) then

				-- Backward Compatibility fix! (1.95- to 1.96+ implementation)
				for i=1,#JSHB_SavedOptions.timers[JSHB.specs[x]] do
					-- Changes "true" or "false" to 1 or 0
					if JSHB_SavedOptions.timers[JSHB.specs[x]][i][3] == true then JSHB_SavedOptions.timers[JSHB.specs[x]][i][3] = 1 end
					if JSHB_SavedOptions.timers[JSHB.specs[x]][i][3] == false then JSHB_SavedOptions.timers[JSHB.specs[x]][i][3] = 0 end
					
					-- Changes mend pet to target 2 instead of "true"
					if JSHB_SavedOptions.timers[JSHB.specs[x]][i][1] == 136 then JSHB_SavedOptions.timers[JSHB.specs[x]][i][3] = 2 end
				end
			
				table.sort(JSHB_SavedOptions.timers[JSHB.specs[x]], function(a,b) return select(1, GetSpellInfo(a[1]))<select(1, GetSpellInfo(b[1])) end)
				mF.fixIconTimerIndex(JSHB_SavedOptions.timers[JSHB.specs[x]], JSHB.pos.LEFT)
				mF.fixIconTimerIndex(JSHB_SavedOptions.timers[JSHB.specs[x]], JSHB.pos.RIGHT)
			end
		end
		
		for x,y in pairs(JSHB.defaults["misdirection"]) do
			if JSHB_SavedOptions[x] == nil then JSHB_SavedOptions[x] = y end
		end
		
		-- Global Saved Variables for Custom Spells
		if not JSHB_SavedOptionsGlobal then
			JSHB_SavedOptionsGlobal = {}
		end
			
		if JSHB_SavedOptionsGlobal.customspell == nil then
			JSHB_SavedOptionsGlobal.customspell = { }
		end
		
		if JSHB_SavedOptionsGlobal.customtranq == nil then
			JSHB_SavedOptionsGlobal.customtranq = { }
		end
		
		if JSHB_SavedOptionsGlobal.customaura == nil then
			JSHB_SavedOptionsGlobal.customaura = { }
		end
		
		-- Set options globals and locals
		JSHB.mainframe.dbg = JSHB_SavedOptionsGlobal
		DBG = JSHB_SavedOptionsGlobal
		
		JSHB.mainframe.db = JSHB_SavedOptions
		DB = JSHB_SavedOptions
		
		if IsAddOnLoaded("Tukui") and strsub(GetAddOnMetadata("Tukui", "Version"),1, 2) == "13" then
			local TukUI_T, TukUI_C, TukUI_L = unpack(Tukui)
			TukUI_borderr, TukUI_borderg, TukUI_borderb = unpack(TukUI_C["media"].bordercolor)
			TukUI_backdropr, TukUI_backdropg, TukUI_backdropb = unpack(TukUI_C["media"].backdropcolor)
			TukUI_T, TukUI_C, TukUI_L = nil, nil, nil
		end
		
		-- Register our media to the global SharedMedia
		if GetLibSharedMedia3() then			
			for i=1,#JSHB.defaultFonts do GetLibSharedMedia3():Register("font", JSHB.defaultFonts[i].text, JSHB.defaultFonts[i].font) end
			for i=1,#JSHB.defaultTextures do GetLibSharedMedia3():Register("statusbar", JSHB.defaultTextures[i].text, JSHB.defaultTextures[i].texture) end
			for i=1,#JSHB.defaultSounds do GetLibSharedMedia3():Register("sound", JSHB.defaultSounds[i].text, JSHB.defaultSounds[i].sound) end
			GetLibSharedMedia3().RegisterCallback(JSHB, "LibSharedMedia_Registered", "updateSharedMedia")
		end
		
		JSHB.updateSharedMedia()

		self:CreateFrame()
		
	elseif event == "PLAYER_LOGIN" then

		if JSHB.optionsAreLoaded then JSHB.setupOptionsPane() end
		JSHB.reconfigureAddon()

		mF:RegisterEvent('UNIT_MAXPOWER')
		mF:RegisterEvent("UNIT_SPELLCAST_START")
		mF:RegisterEvent("UNIT_SPELLCAST_STOP")
		mF:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		mF:RegisterEvent("UNIT_SPELLCAST_FAILED")
		mF:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		mF:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		mF:RegisterEvent("PLAYER_ENTERING_WORLD")
		mF:RegisterEvent("PLAYER_REGEN_ENABLED")
		mF:RegisterEvent("PLAYER_REGEN_DISABLED")

		JSHB.updateMainFrame()

	elseif event == "PLAYER_REGEN_ENABLED" then

		JSHB.regenEnabled = true
		
		-- If player was in combat when setMisdirects() was called, it gets delayed and re-called when out of combat.
		if JSHB.flagDelayedMDUpdate then setMisdirects() end
		
		JSHB.updateMainFrame()

	elseif event == "PLAYER_REGEN_DISABLED" then

		JSHB.regenEnabled = false
		JSHB.updateMainFrame()

	elseif event == "UNIT_SPELLCAST_START" then

		if select(1, ...) == "player" then

			spellCastID = select(5, ...)
			if spellCastID  == 56641 or spellCastID == 77767 then -- Steady Shot / Cobra Shot
				JSHB.isCasting = true

				if DB.enableprediction then
					updatePrediction()
				end
			end
		end

	elseif string.find(event, "UNIT_SPELLCAST_") then -- STOP / FAILED / SUCCEEDED all handled here

		if select(1, ...) == "player" then

			spellCastID = select(5, ...)

			if (event == "UNIT_SPELLCAST_SUCCEEDED") and (spellCastID == 75) and (DB.enableautoshotbar or DB.enableautoshottext) then -- Autoshot

				JSHB.autoShotStartTime 	= GetTime()
				JSHB.autoShotEndTime	= JSHB.autoShotStartTime + UnitRangedDamage("player")

				if DB.enableautoshotbar then
					JSHB.autoShotFrame:Show()
				end

				if DB.enableautoshottext then
					mF.autoShotValue:SetFormattedText("%#.1f", JSHB.autoShotEndTime - GetTime())
				end
			
			elseif spellCastID  == 56641 or spellCastID == 77767 then

				JSHB.isCasting = false
				
				if DB.enableprediction then
					JSHB.predictionFrame:Hide()
					return
				end
			end
		end	
	
	elseif event == "PLAYER_ENTERING_WORLD" then

		if debug then print("*** DEBUG OPTIONS ON! ***") end
	
		setMisdirects()
		
	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then

		JSHB.currentTree = GetPrimaryTalentTree()
		
		if JSHB.currentTree == nil then
			JSHB.currentTree = 1
		end
		
		JSHB.reconfigureAddon()

	elseif (event == "PARTY_CONVERTED_TO_RAID") or (event == "PARTY_MEMBERS_CHANGED") or (event == "RAID_ROSTER_UPDATE") then

		setMisdirects()

	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then

		if DB.enablecctimers == true then

			if (select(2, ...) == "SPELL_AURA_APPLIED") and (select(3, select(1, ...)) == UnitGUID("player")) then

				if select(9, ...) == 3355 then -- Freezing trap Aura

					i = (bit.band(select(8, select(1, ...)), COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or (60 + (6 * select(5, GetTalentInfo(3, 5))))

					addCCTimer(1499, select(6, select(1, ...)), i) -- account for trap mastery

				elseif select(9, ...) == 19386 then -- wyvern

					addCCTimer(19386, select(6, select(1, ...)), 30) -- wyvern
				end

			elseif (select(2, ...) == "SPELL_AURA_REFRESH") and (select(3, select(1, ...)) == UnitGUID("player")) then

				if select(9, ...) == 3355 then -- Freezing Trap Aura

					i = (bit.band(select(8, select(1, ...)), COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or (60 + (6 * select(5, GetTalentInfo(3, 5))))
					refreshCCTimer(1499, select(6, select(1, ...)), i) -- account for trap mastery

				end
			elseif (select(2, ...) == "SPELL_AURA_REMOVED") and (select(3, select(1, ...)) == UnitGUID("player")) then

				if select(9, ...) == 3355 then -- Freezing Trap Aura

					stopCCTimer(1499, select(6, select(1, ...)))

				elseif select(9, ...) == 19386 then -- wyvern

					stopCCTimer(19386, select(6, select(1, ...))) -- wyvern
				end
			end
		end

		if DB.enabletranqannounce == true then

			if (select(2, ...) == "SPELL_DISPEL") and (select(3, select(1, ...)) == UnitGUID("player")) and (select(6, select(1, ...)) ~= UnitGUID("pet")) then

				SendChatMessage(L.tranqremoved .. "|cff71d5ff|Hspell:" .. select(2, select(11, ...)) .. "|h[" .. select(2, select(12, ...)) .. "]|h|r"
						.. L.tranqfrom..select(7, select(1, ...))..".", getChatChan(DB.tranqannouncechannel), nil, GetUnitName("player"))
			end
		end
		
		if (select(2, ...) == "SPELL_CAST_SUCCESS") and (select(9, ...) == 34477) and (select(3, select(1, ...)) == UnitGUID("player")) then
			JSHB.misdirectionToPlayer = select(7, ...)
		end
		
		if DB.enablemdcastannounce == true then

			if (select(2, ...) == "SPELL_CAST_SUCCESS") and (select(9, ...) == 34477) and (select(3, select(1, ...)) == UnitGUID("player")) then

				SendChatMessage("|cff71d5ff|Hspell:" .. select(9, ...) .. "|h[" .. select(10, ...) .. "]|h|r"
						.. L.mdcaston .. select(7, ...) ..".", getChatChan(DB.mdannouncechannel), nil, GetUnitName("player"))

			elseif (select(2, ...) == "SPELL_CAST_FAILED") and (select(9, ...) == 34477) and (select(3, select(1, ...)) == UnitGUID("player")) then

				-- Be sure we are not trying to send a tell to a pet or player name not in party/raid!
				if UnitIsPlayer(JSHB.mDHoverTarget) and (UnitInParty(JSHB.mDHoverTarget) or UnitInRaid(JSHB.mDHoverTarget)) then

					-- Need to be sure it's whispering cause the target was mounted and not cause spell was on cooldown.
					if select(12, ...) == "Spell cannot be cast on a mounted unit." then -- Unit is mounted return message
					
						SendChatMessage("|cff71d5ff|Hspell:" .. select(9, ...) .. "|h[" .. select(10, ...) .. "]|h|r "
							.. L.mdtargetmounted, "WHISPER", nil, JSHB.mDHoverTarget)
					end
				end
			end
		end

		if DB.enablemdtargetwhisper == true then -- aggro transfer (35079)
		
			if (select(2, ...) == "SPELL_AURA_APPLIED") and (select(9, ...) == 35079) and (select(3, select(1, ...)) == UnitGUID("player")) then

				if UnitInParty(JSHB.misdirectionToPlayer) or UnitInRaid(JSHB.misdirectionToPlayer) then

					SendChatMessage("|cff71d5ff|Hspell:" .. select(9, ...) .. "|h[" .. select(10, ...) .. "]|h|r"
							.. L.mdaggroto, "WHISPER", nil, JSHB.misdirectionToPlayer)
				end
			end
			
			if (select(2, ...) == "SPELL_AURA_REMOVED") and (select(9, ...) == 35079) and (select(3, select(1, ...)) == UnitGUID("player")) then

				if UnitInParty(JSHB.misdirectionToPlayer) or UnitInRaid(JSHB.misdirectionToPlayer) then

					SendChatMessage("|cff71d5ff|Hspell:" .. select(9, ...) .. "|h[" .. select(10, ...) .. "]|h|r"
							.. L.mdaggrotoover, "WHISPER", nil, JSHB.misdirectionToPlayer)
				end
			end
		end		
		
		if DB.enablemdoverannounce == true then

			if (select(2, ...) == "SPELL_AURA_REMOVED") and (select(9, ...) == 34477) and (select(3, select(1, ...)) == UnitGUID("player")) then

				SendChatMessage("|cff71d5ff|Hspell:" .. select(9, ...) .. "|h[" .. select(10, ...) .. "]|h|r"
						.. L.mdfinished, getChatChan(DB.mdannouncechannel), nil, GetUnitName("player"))
			end
		end

		
		if DB.enabledebuffalert then

			local v = select(9, ...)
			if (select(2, ...) == "SPELL_AURA_APPLIED") and (select(6, select(1, ...)) == UnitGUID("player")) then

				if (tContains(JSHB.debuffalerts, v) ~= nil) or (tContains(DBG.customaura, v) ~= nil) then

					if select(11, UnitAura("player", GetSpellInfo(v), nil, "HARMFUL")) == v then
					
						addDebuffAlert(v, select(6, UnitAura("player", GetSpellInfo(v), nil, "HARMFUL")),
							select(4, UnitAura("player", GetSpellInfo(v), nil, "HARMFUL")))
					else
						addDebuffAlert(v, select(6, UnitAura("player", GetSpellInfo(v), nil, "HELPFUL")),
							select(4, UnitAura("player", GetSpellInfo(v), nil, "HELPFUL")))
					end
				end

			elseif (select(2, ...) == "SPELL_AURA_REFRESH") and (select(6, select(1, ...)) == UnitGUID("player")) then

				if (tContains(JSHB.debuffalerts, v) ~= nil) or (tContains(DBG.customaura, v) ~= nil) then

					if select(11, UnitAura("player", GetSpellInfo(v), nil, "HARMFUL")) == v then
					
						refreshDebuffAlert(v, select(6, UnitAura("player", GetSpellInfo(v), nil, "HARMFUL")),
							select(4, UnitAura("player", GetSpellInfo(v), nil, "HARMFUL")))
					else
						refreshDebuffAlert(v, select(6, UnitAura("player", GetSpellInfo(v), nil, "HELPFUL")),
							select(4, UnitAura("player", GetSpellInfo(v), nil, "HELPFUL")))
					end
				end

			elseif (select(2, ...) == "SPELL_AURA_REMOVED") and (select(6, select(1, ...)) == UnitGUID("player")) then

				if tContains(JSHB.debuffalerts, v) ~= nil then

					stopDebuffAlert(v)
				end
			end
		end

	elseif (event == "UNIT_MAXPOWER") then

		mF:SetMinMaxValues(0, UnitPowerMax("player"))

	end
end)
