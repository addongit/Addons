local addonName, addon = ...

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function OnEnter(self, motion)
	addon:OnEnter()
	if self.isMoving or not addon:IsTooltipAllowed() then return end
	GameTooltip:SetOwner(self, 'ANCHOR_NONE')
	GameTooltip:SetPoint(addon:GetAnchorInfo(self))
	GameTooltip:SetText(self.tooltipText, 1, 1, 1)
	local keyBind, needBreak = self.keyBind and GetBindingKey(self.keyBind)
	if keyBind then
		GameTooltip:AppendText(NORMAL_FONT_COLOR_CODE .. " (" .. keyBind .. ")")
	end
	if GetCVarBool('showNewbieTips') then
		GameTooltip:AddLine(self.newbieText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
		needBreak = true
	end
	if type(self.extendTooltip) == 'function' then
		if needBreak then
			GameTooltip:AddLine(" ")
		end
		self.extendTooltip()
		needBreak = true
	end
	if not self:IsEnabled() then
		local text = self.disabledTooltip
		if self.minLevel then
			text = FEATURE_BECOMES_AVAILABLE_AT_LEVEL:format(self.minLevel)
		end
		if text then
			if needBreak then
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddLine(text, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
		end
	end
	GameTooltip:Show()
end

local function OnLeave(self, motion)
	addon:OnLeave()
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end

local function OnDragStart(self, button)
	self.down = nil
	GameTooltip:Hide()
	if not (addon.db.profile.lock or IsModifierKeyDown()) then
		self.isMoving = self:GetFrameStrata()
		local x, y = self:GetCenter()
		self:ClearAllPoints()
		self:SetPoint('CENTER', UIParent, 'BOTTOMLEFT', x, y)
		self:SetFrameStrata('TOOLTIP')
		self:StartMoving()
	else
		addon:OnDragStart()
	end
end

local function OnDragStop(self, button)
	if self.isMoving then
		self:StopMovingOrSizing()
		self:SetFrameStrata(self.isMoving)
		self:SetUserPlaced(false)
		self.isMoving = nil

		local buttons, order = addon.buttons, addon.order
		local newIndex, oldIndex = #order, buttons[self]
		tremove(order, oldIndex)

		local x = self:GetCenter()
		for index = 1, #order do
			if x <= order[index]:GetCenter() then
				newIndex = index
				break
			end
		end
		tinsert(order, newIndex, self)

		if newIndex ~= oldIndex then
			for index = oldIndex, newIndex, oldIndex < newIndex and 1 or -1 do
				buttons[order[index]] = index
			end
			local order = addon.db.profile.order
			tinsert(order, newIndex, tremove(order, oldIndex))
		end
		addon:UpdatePlugin()
	else
		addon:OnDragStop()
	end
	UpdateMicroButtons()
	if GetMouseFocus() == self then
		OnEnter(self)
	end
end

local function SetButtonState(self, state)
	if state ~= 'PUSHED' then
		self.Flash:Hide()
	else
		self.Flash:Show()
	end
end

--[[-----------------------------------------------------------------------------
Claim buttons
-------------------------------------------------------------------------------]]
local buttons, frame, DoNothing = addon.buttons, addon.frame, addon.DoNothing
local coords = { 5/32, 27/32, 31/64, 58/64 }
local ClearAllPoints, SetParent = frame.ClearAllPoints, frame.SetParent

local function ClaimButton(name, label, tooltip, keyBind)
	local button = _G[name]
	if not button then return end

	button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
	button:GetNormalTexture():SetTexCoord(unpack(coords))
	button:GetPushedTexture():SetTexCoord(unpack(coords))

	local texture = button:GetDisabledTexture()
	if texture then
		texture:SetTexCoord(unpack(coords))
	end

	button:SetScript('OnDragStart', OnDragStart)
	button:SetScript('OnDragStop', OnDragStop)
	button:SetScript('OnEnter', OnEnter)
	button:SetScript('OnLeave', OnLeave)

	SetParent(button, frame)
	ClearAllPoints(button)
	button:SetMovable(true)
	button:RegisterForClicks('AnyUp')
	button:RegisterForDrag('LeftButton')
	button:SetButtonState('NORMAL', false)
	button:SetHitRectInsets(0, 0, 0, 0)
	button:UnregisterEvent('UPDATE_BINDINGS')

	button.ClearAllPoints = DoNothing
	button.Hide = DoNothing
	button.SetAllPoints = DoNothing
	button.SetParent = DoNothing
	button.SetPoint = DoNothing
	button.Show = DoNothing

	texture = button.Flash
	if texture then
		texture:ClearAllPoints()
		texture:SetAllPoints(button)
		texture:SetDrawLayer('OVERLAY', 2)
		texture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
		button.SetButtonState = SetButtonState
	end

	button.keyBind, button.newbieText, button.tooltipText = keyBind, tooltip, label
	buttons[button] = 0
end

ClaimButton('CharacterMicroButton', CHARACTER_BUTTON, NEWBIE_TOOLTIP_CHARACTER, 'TOGGLECHARACTER0')
ClaimButton('SpellbookMicroButton', SPELLBOOK_ABILITIES_BUTTON, NEWBIE_TOOLTIP_SPELLBOOK, 'TOGGLESPELLBOOK')
ClaimButton('TalentMicroButton', TALENTS_BUTTON, NEWBIE_TOOLTIP_TALENTS, 'TOGGLETALENTS')
ClaimButton('AchievementMicroButton', ACHIEVEMENT_BUTTON, NEWBIE_TOOLTIP_ACHIEVEMENT, 'TOGGLEACHIEVEMENT')
ClaimButton('QuestLogMicroButton', QUESTLOG_BUTTON, NEWBIE_TOOLTIP_QUESTLOG, 'TOGGLEQUESTLOG')
ClaimButton('FriendsMicroButton', SOCIAL_BUTTON, NEWBIE_TOOLTIP_SOCIAL, 'TOGGLESOCIAL')
ClaimButton('GuildMicroButton', GUILD, NEWBIE_TOOLTIP_GUILDTAB, 'TOGGLEGUILDTAB')
ClaimButton('PVPMicroButton', PLAYER_V_PLAYER, NEWBIE_TOOLTIP_PVP, 'TOGGLECHARACTER4')
ClaimButton('LFDMicroButton', DUNGEONS_BUTTON, NEWBIE_TOOLTIP_LFGPARENT, 'TOGGLELFGPARENT')
ClaimButton('MainMenuMicroButton', MAINMENU_BUTTON, NEWBIE_TOOLTIP_MAINMENU, 'TOGGLEGAMEMENU')
ClaimButton('HelpMicroButton', HELP_BUTTON, NEWBIE_TOOLTIP_HELP)

--[[-----------------------------------------------------------------------------
Tweaks
-------------------------------------------------------------------------------]]
if CharacterMicroButton then
	if CharacterFrame then
		CharacterFrame:HookScript('OnHide', UpdateMicroButtons)
		CharacterFrame:HookScript('OnShow', UpdateMicroButtons)
	end
	if MicroButtonPortrait then
		MicroButtonPortrait:ClearAllPoints()
		MicroButtonPortrait:SetAllPoints(CharacterMicroButton)
		MicroButtonPortrait:SetTexCoord(0.1, 0.9, 0.0666, 0.9)
	end
end

if SpellbookMicroButton and SpellBookFrame then
	SpellBookFrame:HookScript('OnHide', UpdateMicroButtons)
	SpellBookFrame:HookScript('OnShow', UpdateMicroButtons)
end

if FriendsMicroButton then
	local coords = { 6/32, 24/32, 10/64, 52/64 }
	FriendsMicroButton:GetNormalTexture():SetTexCoord(unpack(coords))
	FriendsMicroButton:GetPushedTexture():SetTexCoord(unpack(coords))

	local texture = FriendsMicroButton:GetDisabledTexture()
	if texture then
		texture:SetTexCoord(unpack(coords))
	end

	FriendsMicroButton.SetScript = DoNothing

	if FriendsMicroButtonCount then
		FriendsMicroButtonCount:ClearAllPoints()
		FriendsMicroButtonCount:SetPoint('BOTTOM', FriendsMicroButton)
	end
end

if GuildMicroButton and GuildMicroButtonTabard then
	GuildMicroButtonTabard:ClearAllPoints()
	GuildMicroButtonTabard:SetPoint('CENTER', GuildMicroButton, 0, 11)
	GuildMicroButtonTabard.SetPoint = DoNothing

	GuildMicroButton:SetScript('OnSizeChanged', function(self, width, height)
		GuildMicroButtonTabard:SetScale(width / 32)
	end)
end

if PVPMicroButton and PVPMicroButtonTexture then
	PVPMicroButtonTexture:ClearAllPoints()
	PVPMicroButtonTexture:SetAllPoints(PVPMicroButton)
	PVPMicroButtonTexture:SetTexCoord(4/64, 38/64, 2/64, 38/64)
end

if MainMenuMicroButton and MainMenuBarPerformanceBar then
	local coords = { 4/32, 28/32, 33/64, 53/64 }
	local path = ([[Interface\AddOns\%s\MainMenu]]):format(addonName)
	MainMenuMicroButton.tooltipLatency = true

	local texture = MainMenuMicroButton:GetNormalTexture()
	if texture then
		texture:SetTexture(path)
		texture:SetTexCoord(unpack(coords))
	end

	texture = MainMenuMicroButton:GetPushedTexture()
	if texture then
		texture:SetTexture(path)
		texture:SetTexCoord(unpack(coords))
	end

	texture = MainMenuBarPerformanceBar
	texture:ClearAllPoints()
	texture:SetAllPoints(MainMenuMicroButton)
	texture:SetTexture(([[Interface\AddOns\%s\LatencyOverlay]]):format(addonName))
	texture:SetTexCoord(unpack(coords))
	texture.SetPoint = DoNothing

	local latency, worldLatency, timer = 0, 0, 10

	MainMenuMicroButton.extendTooltip = function()
		GameTooltip:AddLine(MAINMENUBAR_LATENCY_LABEL:format(latency, worldLatency), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		GameTooltip:AddLine(MAINMENUBAR_FPS_LABEL:format(GetFramerate()), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	end

	MainMenuMicroButton:SetScript('OnUpdate', function(self, elapsed)
		timer = timer + elapsed
		if timer < 10 then return end
		timer = 0

		local percent, _
		_, _, latency, worldLatency = GetNetStats()
		percent = latency / addon.db.profile.latency
		if percent <= 0.5 then
			texture:SetVertexColor(percent + percent, 1, 0)
		elseif percent <= 1 then
			texture:SetVertexColor(1, 2 - percent - percent, 0)
		else
			texture:SetVertexColor(1, 0, 0)
		end
	end)
end

if TalentMicroButtonAlert then
	TalentMicroButtonAlert:ClearAllPoints()
	TalentMicroButtonAlert:SetPoint('CENTER', UIParent)
	if TalentMicroButtonAlertArrow then
		TalentMicroButtonAlertArrow:Hide()
	end
end
