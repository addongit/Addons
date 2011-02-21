-- @release $Id: Bindings.lua 5 2011-01-25 14:05:53Z reighnman $

if not SlamAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local AceEvent = LibStub("AceEvent-3.0")
local C = SlamAndAwe.constants -- Defined in SlamAndAwe LUA no locale needed.
-- Binding Variables

function SlamAndAwe:SetBindings()
	BINDING_HEADER_SLAMANDAWE_TITLE = L["Keybind Title"]
	BINDING_NAME_SLAMANDAWE_WATER_SHIELD = SlamAndAwe.constants["Water Shield"]
	BINDING_NAME_SLAMANDAWE_LIGHTNING_SHIELD = SlamAndAwe.constants["Lightning Shield"]
	BINDING_NAME_SLAMANDAWE_MHWEAPON_REBUFF = L["MH Weapon Rebuff"]
	BINDING_NAME_SLAMANDAWE_OHWEAPON_REBUFF = L["OH Weapon Rebuff"]
	BINDING_NAME_SLAMANDAWE_ENABLE_DISABLE= L["Enable/Disable"]
	BINDING_NAME_SLAMANDAWE_PRIORITYSET_1=L["Use Priority Set"].." 1"
	BINDING_NAME_SLAMANDAWE_PRIORITYSET_2=L["Use Priority Set"].." 2"
	BINDING_NAME_SLAMANDAWE_PRIORITYSET_3=L["Use Priority Set"].." 3"
	BINDING_NAME_SLAMANDAWE_PRIORITYSET_4=L["Use Priority Set"].." 4"
	BINDING_NAME_SLAMANDAWE_PRIORITYSET_5=L["Use Priority Set"].." 5"

	SlamAndAwe.BindingFrame = CreateFrame("Frame", "SAA_BindingFrame", UIParent, "SecureFrameTemplate")
	SlamAndAwe.bindings = {}
	SlamAndAwe.Button = {}
	SlamAndAwe.bindings.imbues = {}
	SlamAndAwe.bindings.imbues[L["None"]] = L["None"]
end

--------------------------------
--  Create Binding Frame
--------------------------------

function SlamAndAwe:CreateBindingFrame()
	self.BindingFrame:SetScale(SlamAndAwe.db.char.binding.scale)
	self.BindingFrame:SetFrameStrata("BACKGROUND")
	self.BindingFrame:SetWidth(SlamAndAwe.db.char.binding.fWidth)
	self.BindingFrame:SetHeight(SlamAndAwe.db.char.binding.fHeight)
	self.BindingFrame:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	self.BindingFrame:SetBackdropColor(0, 0, 0, SlamAndAwe.db.char.binding.alpha);
	self.BindingFrame:SetMovable(true);
	self.BindingFrame:RegisterForDrag("LeftButton");
	self.BindingFrame:SetPoint(SlamAndAwe.db.char.binding.point, SlamAndAwe.db.char.binding.relativeTo, SlamAndAwe.db.char.binding.relativePoint, SlamAndAwe.db.char.binding.xOffset, SlamAndAwe.db.char.binding.yOffset)
	self.BindingFrame:SetScript("OnDragStart", 
		function()
			self.BindingFrame:StartMoving();
		end );
	self.BindingFrame:SetScript("OnDragStop",
		function()
			self.BindingFrame:StopMovingOrSizing();
			self.BindingFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(SlamAndAwe.db.char.binding, self.BindingFrame);
		end );
		
	if not self.BindingFrame.topText then
		self.BindingFrame.topText = self.BindingFrame:CreateFontString(nil, "OVERLAY")
	end
	self.BindingFrame.topText:SetTextColor(1,1,1,1)
	self.BindingFrame.topText:SetFont(media:Fetch("font", SlamAndAwe.db.char.barfont), SlamAndAwe.db.char.barfontsize)
	self.BindingFrame.topText:SetPoint("TOP", self.BindingFrame, "TOP", 0, SlamAndAwe.db.char.barfontsize + 2)
	self.BindingFrame.topText:SetText("keybound buttons")

	self.BindingFrame:Hide()

	function SlamAndAwe.Button:CreateButton(name, parent)
		local button = CreateFrame("Button", name, parent, "SecureHandlerAttributeTemplate, SecureActionButtonTemplate") 
		button.Parent = parent
		button.Name = name
		button:SetWidth(36)
		button:SetHeight(36)	
		button:RegisterForClicks("LeftButtonUp","RightButtonUp")		
		button:SetParent(parent)
		button:SetAttribute("hidden", false)
		button:Enable()
		return button		
	end

end

--------------------------------
--  Create Button Template
--------------------------------

function SlamAndAwe:InitialiseBindings()
	self:SetBindings()
	SlamAndAwe.db.char.binding.macroset = false
	self:CreateBindingFrame()
	self.BindingFrame:SetFrameStrata("HIGH")
	self.BindingFrame:SetWidth(250)
	self.BindingFrame:SetHeight(50)
	self.BindingFrame:ClearAllPoints()
	self.BindingFrame:SetPoint("TOPLEFT", self.BaseFrame, "TOPLEFT", barHeight, frameOffset)
	self.BindingFrame:SetBackdrop(self.barBackdrop)
	self.BindingFrame:SetBackdropColor(0, 0, 0, .2)
	self.BindingFrame:SetBackdropBorderColor( 1, 1, 1, 1)
	self.BindingFrame:EnableMouse(false)
	self.bindings.watershield = self.Button:CreateButton("SAA_WaterShieldButton", self.BindingFrame)
	self.bindings.lightningshield = self.Button:CreateButton("SAA_LightningShieldButton", self.BindingFrame)
	self.bindings.mhrebuff = self.Button:CreateButton("SAA_MHRebuffButton", self.BindingFrame)
	self.bindings.ohrebuff = self.Button:CreateButton("SAA_OHRebuffButton", self.BindingFrame)
	self.bindings.watershield:Show()
	self.bindings.lightningshield:Show()
	self.bindings.mhrebuff:Show()
	self.bindings.ohrebuff:Show()
	
	self:UpdateBindings()
	self.BindingFrame:Hide()
end

function SlamAndAwe:UpdateBindings()
	return true
end

function SlamAndAwe:SetBindingKey(button, keyname, bindingname)
	ClearOverrideBindings(button)
	local key = GetBindingKey(bindingname)
	if (key) then
		SetOverrideBindingClick(button, nil, key, keyname)
	end
end

function SlamAndAwe:SetMacro(button, spell, slot)
	SlamAndAwe.db.char.binding.macroset = true
	local index = slot - 15
--~ 	local macrotext = "/script CancelItemTempEnchantment("..index..")\n/cast "..spell.."\n/use "..slot.."\n/click StaticPopup1Button1"
	local macrotext = "/dance"
	local macroname = "SAAMacro"..index
 	button:SetAttribute("type", "macro")
 	button:SetAttribute(macroname, macrotext)
	self:Print("set button for slot "..slot.." "..macroname)
end

function SlamAndAwe:UpdateButton(button, spell, slot)
	button:SetAttribute("type1", "spell")
	button:SetAttribute("spell1", spell)
	if slot then
		button:SetAttribute("target-slot1", slot)
	end
	button:SetAttribute("unit", "player")
end

-----------------------------
-- Button press functions
-----------------------------

function SlamAndAwe:CastWaterShield()
	return true
end

function SlamAndAwe:CastLightningShield()
	return true
end

function SlamAndAwe:RebuffWeapons(hand)
	return true
end

function SlamAndAwe:MainHandBuffMissing()
  return false
end

function SlamAndAwe:OffHandBuffMissing()
	return false
end

function SlamAndAwe:SelectPrioritySet(groupNumber)
	SlamAndAwe.db.char.priority.prOption = SlamAndAwe.db.char.priority.prOptions[groupNumber]
	SlamAndAwe.db.char.priority.groupnumber = groupNumber
	if self.PriorityFrame and self.PriorityFrame.topText then
		self.PriorityFrame.topText:SetText(string.format(L["Next Priority (Set %s)"], SlamAndAwe.db.char.priority.groupnumber))
	end
	self:Print(string.format(L["Priority Set %s selected"], groupNumber))
end