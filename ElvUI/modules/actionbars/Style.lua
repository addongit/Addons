local ElvDB = ElvDB
local ElvCF = ElvCF

if not ElvCF["actionbar"].enable == true then return end

local _G = _G
local media = ElvCF["media"]
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")

function style(self, vehicle, totem)
	local name = self:GetName()
	
	if name:match("MultiCastActionButton") then return end 
	
	local action = self.action
	local Button = self
	local Icon = _G[name.."Icon"]
	local Count = _G[name.."Count"]
	local Flash	 = _G[name.."Flash"]
	local HotKey = _G[name.."HotKey"]
	local Border  = _G[name.."Border"]
	local Btname = _G[name.."Name"]
	local normal  = _G[name.."NormalTexture"]
	
	if Flash then
		Flash:SetTexture("")
	end
	Button:SetNormalTexture("")
	
	if Border then
		Border:Hide()
		Border = ElvDB.dummy
	end
	
	if Count then
		Count:ClearAllPoints()
		Count:SetPoint("BOTTOMRIGHT", 0, ElvDB.Scale(2))
		Count:SetFont(ElvCF["media"].font, 12, "OUTLINE")
	end
	
	if Btname then
		if ElvCF["actionbar"].macrotext ~= true then
			Btname:SetText("")
			Btname:Hide()
			Btname.Show = ElvDB.dummy
		end
	end
	
	if not _G[name.."Panel"] then
		if not totem then
			self:SetWidth(ElvDB.buttonsize)
			self:SetHeight(ElvDB.buttonsize)
 
			local panel = CreateFrame("Frame", name.."Panel", self)
			if vehicle then
				ElvDB.CreatePanel(panel, ElvDB.buttonsize*1.2, ElvDB.buttonsize*1.2, "CENTER", self, "CENTER", 0, 0)
			else
				ElvDB.CreatePanel(panel, ElvDB.buttonsize, ElvDB.buttonsize, "CENTER", self, "CENTER", 0, 0)
			end
			ElvDB.SetNormTexTemplate(panel)
			panel:SetFrameStrata(self:GetFrameStrata())
			panel:SetFrameLevel(self:GetFrameLevel() - 1)
		end
		
		if Icon then
			Icon:SetTexCoord(.08, .92, .08, .92)
			Icon:SetPoint("TOPLEFT", Button, ElvDB.Scale(2), ElvDB.Scale(-2))
			Icon:SetPoint("BOTTOMRIGHT", Button, ElvDB.Scale(-2), ElvDB.Scale(2))
		end
	end
	
	if HotKey then
		HotKey:ClearAllPoints()
		HotKey:SetPoint("TOPRIGHT", 0, ElvDB.Scale(-3))
		HotKey:SetFont(ElvCF["media"].font, 12, "OUTLINE")
		HotKey.ClearAllPoints = ElvDB.dummy
		HotKey.SetPoint = ElvDB.dummy
		if not ElvCF["actionbar"].hotkey == true then
			HotKey:SetText("")
			HotKey:Hide()
			HotKey.Show = ElvDB.dummy
		end
	end
	
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

local function stylesmallbutton(normal, button, icon, name, pet)
	local Flash	 = _G[name.."Flash"]
	button:SetNormalTexture("")
	
	-- another bug fix reported by Affli in t12 beta
	button.SetNormalTexture = ElvDB.dummy
	
	Flash:SetTexture(1, 1, 1, 0.3)
	
	if not _G[name.."Panel"] then
		button:SetWidth(ElvDB.petbuttonsize)
		button:SetHeight(ElvDB.petbuttonsize)
		
		local panel = CreateFrame("Frame", name.."Panel", button)
		ElvDB.CreatePanel(panel, ElvDB.petbuttonsize, ElvDB.petbuttonsize, "CENTER", button, "CENTER", 0, 0)
		panel:SetBackdropColor(unpack(media.backdropcolor))
		panel:SetFrameStrata(button:GetFrameStrata())
		panel:SetFrameLevel(button:GetFrameLevel() - 1)

		icon:SetTexCoord(.08, .92, .08, .92)
		icon:ClearAllPoints()
		if pet then
			local autocast = _G[name.."AutoCastable"]
			autocast:SetWidth(ElvDB.Scale(41))
			autocast:SetHeight(ElvDB.Scale(40))
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)
			icon:SetPoint("TOPLEFT", button, ElvDB.Scale(2), ElvDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, ElvDB.Scale(-2), ElvDB.Scale(2))
		else
			icon:SetPoint("TOPLEFT", button, ElvDB.Scale(2), ElvDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, ElvDB.Scale(-2), ElvDB.Scale(2))
		end
	end
	
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

function ElvDB.StyleShift()
	for i=1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture"]
		stylesmallbutton(normal, button, icon, name)
	end
end

function ElvDB.StylePet()
	for i=1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture2"]
		stylesmallbutton(normal, button, icon, name, true)
	end
end

-- rescale cooldown spiral to fix texture.
local buttonNames = { "ActionButton",  "MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarLeftButton", "MultiBarRightButton", "ShapeshiftButton", "PetActionButton"}
for _, name in ipairs( buttonNames ) do
	for index = 1, 12 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if ( button == nil or cooldown == nil ) then
			break
		end
		
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end

local buttons = 0
local function SetupFlyoutButton()
	for i=1, buttons do
		--prevent error if you don't have max ammount of buttons
		if _G["SpellFlyoutButton"..i] then
			style(_G["SpellFlyoutButton"..i], false)
			ElvDB.StyleButton(_G["SpellFlyoutButton"..i], true)
			if ElvCF["actionbar"].rightbarmouseover == true then
				SpellFlyout:HookScript("OnEnter", function(self) RightBarMouseOver(1) end)
				SpellFlyout:HookScript("OnLeave", function(self) RightBarMouseOver(0) end)
				_G["SpellFlyoutButton"..i]:HookScript("OnEnter", function(self) RightBarMouseOver(1) end)
				_G["SpellFlyoutButton"..i]:HookScript("OnLeave", function(self) RightBarMouseOver(0) end)
			end
		end
	end
end
SpellFlyout:HookScript("OnShow", SetupFlyoutButton)

-- Reposition flyout buttons depending on what Elvui bar the button is parented to
local function FlyoutButtonPos(self, buttons, direction)
	for i=1, buttons do
		local parent = SpellFlyout:GetParent()
		if not _G["SpellFlyoutButton"..i] then return end
		
		if InCombatLockdown() then return end
 
		if direction == "LEFT" then
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", parent, "LEFT", -4, 0)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", _G["SpellFlyoutButton"..i-1], "LEFT", -4, 0)
			end
		else
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", parent, "TOP", 0, 4)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", _G["SpellFlyoutButton"..i-1], "TOP", 0, 4)
			end
		end
	end
end
 
--Hide the Mouseover texture and attempt to find the ammount of buttons to be skinned
local function styleflyout(self)
	self.FlyoutBorder:SetAlpha(0)
	self.FlyoutBorderShadow:SetAlpha(0)
	
	SpellFlyoutHorizontalBackground:SetAlpha(0)
	SpellFlyoutVerticalBackground:SetAlpha(0)
	SpellFlyoutBackgroundEnd:SetAlpha(0)
	
	for i=1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			buttons = numSlots
			break
		end
	end
	
	--Change arrow direction depending on what bar the button is on
	local arrowDistance
	if ((SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
			arrowDistance = 5
	else
			arrowDistance = 2
	end
	
	if (self:GetParent() == MultiBarBottomRight and ElvCF.actionbar.rightbars > 1) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
		SetClampedTextureRotation(self.FlyoutArrow, 270)
		FlyoutButtonPos(self,buttons,"LEFT")
	elseif (self:GetParent() == MultiBarLeft and not ElvDB.lowversion and ElvCF.actionbar.bottomrows == 2) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
		SetClampedTextureRotation(self.FlyoutArrow, 0)
		FlyoutButtonPos(self,buttons,"UP")	
	elseif not self:GetParent():GetParent() == "SpellBookSpellIconsFrame" then
		FlyoutButtonPos(self,buttons,"UP")
	end
end

do	
	for i = 1, 12 do
		ElvDB.StyleButton(_G["MultiBarLeftButton"..i], true)
		ElvDB.StyleButton(_G["MultiBarRightButton"..i], true)
		ElvDB.StyleButton(_G["MultiBarBottomRightButton"..i], true)
		ElvDB.StyleButton(_G["MultiBarBottomLeftButton"..i], true)
		ElvDB.StyleButton(_G["ActionButton"..i], true)
	end
	 
	for i=1, 10 do
		ElvDB.StyleButton(_G["ShapeshiftButton"..i], true)
		ElvDB.StyleButton(_G["PetActionButton"..i], true)	
	end
	
	for i=1, 6 do
		ElvDB.StyleButton(_G["VehicleMenuBarActionButton"..i], true)
		style(_G["VehicleMenuBarActionButton"..i], true)
	end
end

hooksecurefunc("ActionButton_Update", style)
hooksecurefunc("ActionButton_UpdateHotkeys", ElvDB.UpdateHotkey)
hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)

--[[
    MultiCastActionBar Skin
	
	(C)2010 Darth Android / Telroth - The Venture Co.

]]

if ElvDB.myclass ~= "SHAMAN" then return end

-- Courtesy Blizzard Inc.
-- I wouldn't have to copy these if they'd just make them not local >.>
SLOT_EMPTY_TCOORDS = {
	[EARTH_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 3 / 256,
		bottom	= 33 / 256,
	},
	[FIRE_TOTEM_SLOT] = {
		left	= 67 / 128,
		right	= 97 / 128,
		top		= 100 / 256,
		bottom	= 130 / 256,
	},
	[WATER_TOTEM_SLOT] = {
		left	= 39 / 128,
		right	= 69 / 128,
		top		= 209 / 256,
		bottom	= 239 / 256,
	},
	[AIR_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 36 / 256,
		bottom	= 66 / 256,
	},
}

local AddOn_Loaded = CreateFrame("Frame")
AddOn_Loaded:RegisterEvent("ADDON_LOADED")
AddOn_Loaded:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "ElvUI" then return end

	Mod_AddonSkins:RegisterSkin("Blizzard_TotemBar",function(Skin,skin,Layout,layout,config)
		-- Skin Flyout
		function Skin:SkinMCABFlyoutFrame(flyout, type, parent)
			local point, _, _, _, _ = ElvuiShiftBar:GetPoint()
			flyout.top:SetTexture(nil)
			flyout.middle:SetTexture(nil)
			self:SkinFrame(flyout)
			flyout:SetBackdropBorderColor(0,0,0,0)
			flyout:SetBackdropColor(0,0,0,0)
			-- Skin buttons
			local last = nil
			for _,button in ipairs(flyout.buttons) do
				self:SkinButton(button)
				if not InCombatLockdown() then
					button:SetSize(ElvDB.petbuttonsize,ElvDB.petbuttonsize)
					button:ClearAllPoints()
					button:SetPoint("BOTTOM",last,"TOP",0,config.borderWidth)
				end			
				if button:IsVisible() then last = button end
				button:SetBackdropBorderColor(parent:GetBackdropBorderColor())
				if ElvCF["actionbar"].shapeshiftmouseover == true then
					button:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
					button:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
				end
			end
			flyout.buttons[1]:SetPoint("BOTTOM",flyout,"BOTTOM")
			if type == "slot" then
				local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
				flyout.buttons[1].icon:SetTexCoord(tcoords.left,tcoords.right,tcoords.top,tcoords.bottom)
			end
			-- Skin Close button
			local close = MultiCastFlyoutFrameCloseButton
			self:SkinButton(close)
			
			close:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
			close:GetHighlightTexture():SetPoint("TOPLEFT",close,"TOPLEFT",config.borderWidth,-config.borderWidth)
			close:GetHighlightTexture():SetPoint("BOTTOMRIGHT",close,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
			close:GetNormalTexture():SetTexture(nil)
			close:ClearAllPoints()
			if point == "BOTTOMLEFT" or point == "BOTTOMRIGHT" or point == "BOTTOM" then
				close:SetPoint("BOTTOMLEFT",last,"TOPLEFT",0,4)
				close:SetPoint("BOTTOMRIGHT",last,"TOPRIGHT",0,4)
			else
				if last then
					close:SetWidth(last:GetWidth())
				end
				close:SetPoint("TOP",flyout,"BOTTOM",0,-4)		
			end
			close:SetHeight(4*2)
			close:SetBackdropBorderColor(parent:GetBackdropBorderColor())
			flyout:ClearAllPoints()
			if point == "BOTTOMLEFT" or point == "BOTTOMRIGHT" or point == "BOTTOM" then
				flyout:SetPoint("BOTTOM",parent,"TOP",0,4)
			else
				flyout:SetPoint("TOP",parent,"BOTTOM",0,-4)
			end
			
			if ElvCF["actionbar"].shapeshiftmouseover == true then
				flyout:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
				flyout:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
				close:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
				close:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
			end
			
			MultiCastFlyoutFrameOpenButton:Hide()
		end
		hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self, type, parent) skin:SkinMCABFlyoutFrame(self, type, parent) end)
		
		function Skin:SkinMCABFlyoutOpenButton(button, parent)
			local point, _, _, _, _ = ElvuiShiftBar:GetPoint()
			button:GetHighlightTexture():SetTexture(nil)
			button:GetNormalTexture():SetTexture(nil)
			button:SetHeight(ElvDB.Scale(4)*3)
			button:ClearAllPoints()
			if point == "BOTTOMLEFT" or point == "BOTTOMRIGHT" or point == "BOTTOM" then
				button:SetPoint("BOTTOMLEFT", parent, "TOPLEFT")
				button:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT")
			else
				button:SetPoint("TOPLEFT", parent, "BOTTOMLEFT")
				button:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT")			
			end
			button:SetBackdropColor(0,0,0,0)
			button:SetBackdropBorderColor(0,0,0,0)
			if not button.visibleBut then
				button.visibleBut = CreateFrame("Frame",nil,button)
				button.visibleBut:SetHeight(ElvDB.Scale(4)*2)
				if point == "BOTTOMLEFT" or point == "BOTTOMRIGHT" or point == "BOTTOM" then
					button.visibleBut:SetPoint("TOPLEFT",config.barSpacing)
					button.visibleBut:SetPoint("TOPRIGHT",config.barSpacing)
				else
					button.visibleBut:SetPoint("BOTTOMLEFT")
					button.visibleBut:SetPoint("BOTTOMRIGHT")				
				end
				self:SkinFrame(button.visibleBut)
			end
			
			if ElvCF["actionbar"].shapeshiftmouseover == true then
				button:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
				button:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
			end
			button.visibleBut:SetBackdropBorderColor(parent:GetBackdropBorderColor())
		end
		hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show",function(button,_, parent) skin:SkinMCABFlyoutOpenButton(button, parent) end)
		
		local bordercolors = {
			{.58,.23,.10},    -- Fire
			{.23,.45,.13},    -- Earth
			{.19,.48,.60},   -- Water
			{.42,.18,.74},   -- Air
			{.39,.39,.12}    -- Summon / Recall
		}
		
		function Skin:SkinMCABSlotButton(button, index)
			self:SkinButton(button)
			if _G[button:GetName().."Panel"] then _G[button:GetName().."Panel"]:Hide() end
			button.overlayTex:SetTexture(nil)
			button.background:SetDrawLayer("ARTWORK")
			button.background:ClearAllPoints()
			button.background:SetPoint("TOPLEFT",button,"TOPLEFT",config.borderWidth,-config.borderWidth)
			button.background:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
			button:SetSize(ElvDB.petbuttonsize, ElvDB.petbuttonsize)
			button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
			style(button, false, true)
			ElvDB.StyleButton(button, false)
			if ElvCF["actionbar"].shapeshiftmouseover == true then
				button:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
				button:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
			end
		end
		hooksecurefunc("MultiCastSlotButton_Update",function(self, slot) skin:SkinMCABSlotButton(self, slot) end)
		
		-- Skin the actual totem buttons
		function Skin:SkinMCABActionButton(button, index)
			for i=1, button:GetNumRegions() do
				local region = select(i, button:GetRegions())
				if region:GetObjectType() == "Texture" then
					if region:GetDrawLayer() == "BACKGROUND" then
						region:SetTexCoord(0.1, 0.1, 0.1, 0.9, 0.9, 0.1, 0.9, 0.9)
						if not InCombatLockdown() then
							region:ClearAllPoints()
							region:SetPoint("TOPLEFT", button.slotButton, "TOPLEFT", config.borderWidth, -config.borderWidth)
							region:SetPoint("BOTTOMRIGHT", button.slotButton, "BOTTOMRIGHT", -config.borderWidth, config.borderWidth)
						end
					end
				end
			end
			button.overlayTex:SetTexture(nil)
			button.overlayTex:Hide()
			button:GetNormalTexture():SetTexture(nil)
			button:GetNormalTexture():Hide()
			button:GetNormalTexture().Show = ElvDB.dummy
			if _G[button:GetName().."Panel"] then _G[button:GetName().."Panel"]:Hide() end
			if not InCombatLockdown() then button:SetAllPoints(button.slotButton) end
			button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
			button:SetBackdropColor(0,0,0,0)
			style(button, false, true)
			ElvDB.StyleButton(button, false)
			if ElvCF["actionbar"].shapeshiftmouseover == true then
				button:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
				button:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
			end
		end
		hooksecurefunc("MultiCastActionButton_Update",function(actionButton, actionId, actionIndex, slot) skin:SkinMCABActionButton(actionButton,actionIndex) end)
		
		-- Skin the summon and recall buttons
		function Skin:SkinMCABSpellButton(button, index)
			if not button then return end
			self:SkinButton(button)
			button:GetNormalTexture():SetTexture(nil)
			self:SkinBackgroundFrame(button)
			button:SetBackdropBorderColor(unpack(bordercolors[((index-1)%5)+1]))
			if not InCombatLockdown() then button:SetSize(ElvDB.petbuttonsize, ElvDB.petbuttonsize) end
			_G[button:GetName().."Highlight"]:SetTexture(nil)
			_G[button:GetName().."NormalTexture"]:SetTexture(nil)
			style(button, false, true)
			ElvDB.StyleButton(button, false)
			if index == 0 then
				button:ClearAllPoints()
				button:SetPoint("RIGHT", MultiCastActionButton1, "LEFT", -8, 0)
			end
			if ElvCF["actionbar"].shapeshiftmouseover == true then
				button:HookScript("OnEnter", function() MultiCastActionBarFrame:SetAlpha(1) end)
				button:HookScript("OnLeave", function() MultiCastActionBarFrame:SetAlpha(0) end)
			end
		end
		hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) skin:SkinMCABSpellButton(self,0) end)
		hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) skin:SkinMCABSpellButton(self,5) end)
		
		local frame = MultiCastActionBarFrame
	end)
end)