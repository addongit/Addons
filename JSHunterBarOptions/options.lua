-- In game configuration, using Blizzard addon frame.

local mF	= JSHB.mainframe
local L		= JSHB.locale
local DB 	= JSHB.mainframe.db
local DBG 	= JSHB.mainframe.dbg

JSHB.options.info = {}

-- Clean up the LoD button
JSHB.options.buttonLoD:Hide()
JSHB.options.buttonLoD:SetText(nil)
JSHB.options.buttonLoD = nil


local function checkNotEqual(val1, val2)
	if ((not val1) and val2) or (val1 and (not val2)) then return true else	return false end
end


JSHB.options.ConfirmDelete = function(spec, parent, idx)

	local deleteType, specTimers, specName
	
	if JSHB.options.AddTimerFrame then JSHB.options.AddTimerFrame:Hide() end

	if StaticPopupDialogs["JSHB.optionsDeleteConfirmation"] ~= nil then StaticPopupDialogs["JSHB.optionsDeleteConfirmation"] = nil end

	if tContains({"bm", "mm", "sv"}, spec) ~= nil then
		specTimers = (spec == "bm") and JSHB.options.bm.Timers or ((spec == "mm") and JSHB.options.mm.Timers or JSHB.options.sv.Timers)
		specName = (spec == "bm") and L.namebm or ((spec == "mm") and L.namemm or L.namesv)
		deleteType = 0
	else
		specTimers = (spec == "customspell") and JSHB.options.customspell.spellids or ((spec == "customtranq") and JSHB.options.customtranq.spellids or JSHB.options.customaura.spellids)
		specName = (spec == "customspell") and L.namecustomspellshort or ((spec == "customtranq") and L.namecustomtranqshort or L.namecustomaurashort)
		deleteType = 1
	end

	StaticPopupDialogs["JSHB.optionsDeleteConfirmation"] = {
		text = strupper(
			select(1, (deleteType == 0 and GetSpellInfo(specTimers[idx][1]) or GetSpellInfo(specTimers[idx]))).."\n\n|cffff0000"..L.confirmdelete1..specName..(deleteType == 0 and L.confirmdelete2 or L.confirmdelete3).."|r"),
		button1 = "Delete",
		button2 = "Cancel",
		OnAccept = function()
			StaticPopup_Hide("JSHB.optionsDeleteConfirmation")
			table.remove(specTimers, idx)
			if deleteType == 0 then
				JSHB.options.RefreshConfigurationSettingsForSpec(spec)
			elseif deleteType == 1 then
				JSHB.options.RefreshConfigurationSettingsForCustomSpell(spec)
			end			
			StaticPopupDialogs["JSHB.optionsDeleteConfirmation"] = nil
		end,
		OnCancel = function()
			StaticPopup_Hide("JSHB.optionsDeleteConfirmation")
			StaticPopupDialogs["JSHB.optionsDeleteConfirmation"] = nil
		end,
		cancels = "JSHB.optionsDeleteConfirmation",
		exclusive = true,
		showAlert = true,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	StaticPopup_Show("JSHB.optionsDeleteConfirmation")
end


function JSHB.options.createSpellFrame(custid, parent, frameName, index, anchorFrame, offsetY, spaceY)

	local custSpells = (custid == "customspell") and JSHB.options.customspell.spellids or ((custid == "customtranq") and JSHB.options.customtranq.spellids or JSHB.options.customaura.spellids)

	local frame = CreateFrame("Frame", frameName, parent)
	frame:SetHeight(32)
	frame:SetWidth(360)
	frame:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, offsetY - (spaceY or 5))
	frame:Show()

	local bgtex = frame:CreateTexture(nil, "BACKGROUND", frame)
	bgtex:SetAllPoints(frame)
	bgtex:SetTexture(0, 0, 0, 1)
	
	frame.border = CreateFrame("Frame", nil, frame)
	frame.border:SetBackdrop({
	  bgFile = "",
	  edgeFile = JSHB.getTexture("Blank"), 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	frame.border:SetBackdropColor(.1,.1,.1,1)
	frame.border:SetBackdropBorderColor(.6,.6,.6,1)
	frame.border:SetPoint("TOPLEFT", -1, 1)
	frame.border:SetPoint("BOTTOMRIGHT", 1, -1)

	frame.deletebutton = CreateFrame("Button", nil, frame)
	frame.deletebutton.desc = L.deletebutton
	frame.deletebutton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -6)
	frame.deletebutton.Texture = frame.deletebutton:CreateTexture(nil, "OVERLAY")
	frame.deletebutton.Texture:SetAllPoints(frame.deletebutton)
	frame.deletebutton.Texture:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
	frame.deletebutton.Texture:SetTexCoord(0.08,0.92,0.08,0.92)
	frame.deletebutton:SetHeight(20)
	frame.deletebutton:SetWidth(20)
	frame.deletebutton:Enable()
	frame.deletebutton:EnableMouse()
	frame.deletebutton:SetScript("OnClick", function() JSHB.options.ConfirmDelete(custid, parent, index) end)
	frame.deletebutton:SetScript("OnEnter", function(self) if self.desc then GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetText(self.desc, nil, nil, nil, nil, true) end end)
	frame.deletebutton:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame.icon = CreateFrame("Frame", nil, frame)
	frame.icon.desc = select(1, GetSpellInfo(custSpells[index]))
	frame.icon:SetPoint("LEFT", frame, "LEFT", 4, 0)
	frame.icon.Texture = frame.icon:CreateTexture(nil, "OVERLAY")
	frame.icon.Texture:SetAllPoints(frame.icon)
	frame.icon.Texture:SetTexture(select(3, GetSpellInfo(custSpells[index])))
	frame.icon:SetHeight(20)
	frame.icon:SetWidth(20)
	frame.icon:SetScript("OnEnter", function(self) if self.desc then GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetText(self.desc, nil, nil, nil, nil, true) end end)
	frame.icon:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame.text1 = frame:CreateFontString(frameName.."text1", "ARTWORK", frame)
	frame.text1:SetFontObject(GameFontNormal)	
	frame.text1:SetJustifyH("LEFT")
	frame.text1:SetWidth(108)
	frame.text1:SetPoint("LEFT", frame.icon, "RIGHT", 6, 0)
	frame.text1:SetText(select(1, GetSpellInfo(custSpells[index])))
	
	frame.text2 = frame:CreateFontString(frameName.."text2", "ARTWORK", frame)
	frame.text2:SetFontObject(GameFontNormal)	
	frame.text2:SetJustifyH("LEFT")
	frame.text2:SetWidth(170)
	frame.text2:SetPoint("LEFT", frame.text1, "RIGHT", 6, 0)
	frame.text2:SetText(custSpells[index])
end


function JSHB.options.createTimerFrame(spec, parent, frameName, timer, anchorFrame, offsetY, spaceY)

	local specTimers = (spec == "bm") and JSHB.options.bm.Timers or ((spec == "mm") and JSHB.options.mm.Timers or JSHB.options.sv.Timers)

	local frame = CreateFrame("Frame", frameName, parent)
	frame:SetHeight(32)
	frame:SetWidth(360)
	frame:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, offsetY - (spaceY or 5))
	frame:Show()

	local bgtex = frame:CreateTexture(nil, "BACKGROUND", frame)
	bgtex:SetAllPoints(frame)
	bgtex:SetTexture(0, 0, 0, 1)
	
	frame.border = CreateFrame("Frame", nil, frame)
	frame.border:SetBackdrop({
	  bgFile = "",
	  edgeFile = JSHB.getTexture("Blank"), 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	frame.border:SetBackdropColor(.1,.1,.1,1)
	frame.border:SetBackdropBorderColor(.6,.6,.6,1)
	frame.border:SetPoint("TOPLEFT", -1, 1)
	frame.border:SetPoint("BOTTOMRIGHT", 1, -1)

	frame.deletebutton = CreateFrame("Button", nil, frame)
	frame.deletebutton.desc = L.deletebutton
	frame.deletebutton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -6)
	frame.deletebutton.Texture = frame.deletebutton:CreateTexture(nil, "OVERLAY")
	frame.deletebutton.Texture:SetAllPoints(frame.deletebutton)
	frame.deletebutton.Texture:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
	frame.deletebutton.Texture:SetTexCoord(0.08,0.92,0.08,0.92)
	frame.deletebutton:SetHeight(20)
	frame.deletebutton:SetWidth(20)
	frame.deletebutton:Enable()
	frame.deletebutton:EnableMouse()
	frame.deletebutton:SetScript("OnClick", function() JSHB.options.ConfirmDelete(spec, parent, timer) end)
	frame.deletebutton:SetScript("OnEnter", function(self) if self.desc then GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetText(self.desc, nil, nil, nil, nil, true) end end)
	frame.deletebutton:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame.editbutton = CreateFrame("Button", nil, frame)
	frame.editbutton.desc = L.editbutton
	frame.editbutton:SetPoint("TOPRIGHT", frame.deletebutton, "TOPLEFT", -4, 0)
	frame.editbutton.Texture = frame.editbutton:CreateTexture(nil, "OVERLAY")
	frame.editbutton.Texture:SetAllPoints(frame.editbutton)
	frame.editbutton.Texture:SetTexture("Interface\\Icons\\Trade_Engineering")
	frame.editbutton.Texture:SetTexCoord(0.08,0.92,0.08,0.92)
	frame.editbutton:SetHeight(20)
	frame.editbutton:SetWidth(20)
	frame.editbutton:Enable()
	frame.editbutton:EnableMouse()
	frame.editbutton:SetScript("OnClick", function() JSHB.options.AddTimer(spec, parent, timer) end)
	frame.editbutton:SetScript("OnEnter", function(self) if self.desc then GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetText(self.desc, nil, nil, nil, nil, true) end end)
	frame.editbutton:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame.icon = CreateFrame("Frame", nil, frame)
	frame.icon.desc = select(1, GetSpellInfo(specTimers[timer][1]))
	frame.icon:SetPoint("LEFT", frame, "LEFT", 4, 0)
	frame.icon.Texture = frame.icon:CreateTexture(nil, "OVERLAY")
	frame.icon.Texture:SetAllPoints(frame.icon)
	frame.icon.Texture:SetTexture(select(3, GetSpellInfo(specTimers[timer][1])))
	frame.icon:SetHeight(20)
	frame.icon:SetWidth(20)
	frame.icon:SetScript("OnEnter", function(self) if self.desc then GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetText(self.desc, nil, nil, nil, nil, true) end end)
	frame.icon:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame.text1 = frame:CreateFontString(frameName.."text1", "ARTWORK", frame)
	frame.text1:SetFontObject(GameFontNormal)	
	frame.text1:SetJustifyH("LEFT")
	frame.text1:SetWidth(108)
	frame.text1:SetPoint("LEFT", frame.icon, "RIGHT", 6, 0)
	frame.text1:SetText(select(1, GetSpellInfo(specTimers[timer][1])))

	frame.text2 = frame:CreateFontString(frameName.."text2", "ARTWORK", frame)
	frame.text2:SetFontObject(GameFontNormal)	
	frame.text2:SetJustifyH("LEFT")
	frame.text2:SetWidth(170)
	frame.text2:SetPoint("RIGHT", frame.editbutton, "LEFT", 6, 0)
	frame.text2:SetText((specTimers[timer][2] and L.spelltextdurfor or L.spelltextcdfor) .. 
				(specTimers[timer][3]==0 and L.spelltexttarget or (specTimers[timer][3]==1 and L.spelltextplayer or L.spelltextpet)) .. " - " .. 
				JSHB.timerpositions.getValueName(specTimers[timer][4]))
end


JSHB.options.AddCustomSpell = function(custid, parent)

	if JSHB.options.AddCustomSpellFrame then
		JSHB.options.AddCustomSpellFrame:SetParent(nil)
		JSHB.options.AddCustomSpellFrame = nil
	end

	local custSpells = (custid == "customspell") and JSHB.options.customspell.spellids or ((custid == "customtranq") and JSHB.options.customtranq.spellids or JSHB.options.customaura.spellids)
		
	JSHB.options.AddCustomSpellFrame = CreateFrame("Frame", "JSHB_Options_AddCustomSpellFrame", parent)
	JSHB.options.AddCustomSpellFrame:SetHeight(220)
	JSHB.options.AddCustomSpellFrame:SetWidth(260)
	JSHB.options.AddCustomSpellFrame:SetPoint("CENTER", 0, 0)
	JSHB.options.AddCustomSpellFrame:Raise()
	JSHB.options.AddCustomSpellFrame:Show()
	JSHB.options.AddCustomSpellFrame:SetScript("OnHide", function()
		JSHB.options.AddCustomSpellFrame:SetScript("OnHide", nil)
		JSHB.options.AddCustomSpellFrame:Hide()
		JSHB.options.AddCustomSpellFrame:SetParent(nil)
		JSHB.options.AddCustomSpellFrame = nil
	end)
	JSHB.options.AddCustomSpellFrame.custid = custid
	JSHB.options.AddCustomSpellFrame.custSpells = custSpells

	local bgtex = JSHB.options.AddCustomSpellFrame:CreateTexture(nil, "BACKGROUND", JSHB.options.AddCustomSpellFrame)
	bgtex:SetAllPoints(JSHB.options.AddCustomSpellFrame)
	bgtex:SetTexture(0, 0, 0, 1)
	
	JSHB.options.AddCustomSpellFrame.border = CreateFrame("Frame", nil, JSHB.options.AddCustomSpellFrame)
	JSHB.options.AddCustomSpellFrame.border:SetBackdrop({
	  bgFile = "",
	  edgeFile = JSHB.getTexture("Blank"), 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	JSHB.options.AddCustomSpellFrame.border:SetBackdropColor(.1,.1,.1,1)
	JSHB.options.AddCustomSpellFrame.border:SetBackdropBorderColor(.6,.6,.6,1)
	JSHB.options.AddCustomSpellFrame.border:SetPoint("TOPLEFT", -1, 1)
	JSHB.options.AddCustomSpellFrame.border:SetPoint("BOTTOMRIGHT", 1, -1)

	JSHB.options.AddCustomSpellFrame.text1 = JSHB.options.AddCustomSpellFrame:CreateFontString("JSHB_Options_AddCustomSpellFrame_text1", "ARTWORK", JSHB.options.AddCustomSpellFrame)
	JSHB.options.AddCustomSpellFrame.text1:SetFontObject(GameFontNormal)	
	JSHB.options.AddCustomSpellFrame.text1:SetJustifyH("CENTER")
	JSHB.options.AddCustomSpellFrame.text1:SetWidth(270)
	JSHB.options.AddCustomSpellFrame.text1:SetPoint("TOP", JSHB.options.AddCustomSpellFrame, "TOP", 0, -30)
	JSHB.options.AddCustomSpellFrame.text1:SetText(L.addspelltext1)
	
	JSHB.options.AddCustomSpellFrame.text2 = JSHB.options.AddCustomSpellFrame:CreateFontString("JSHB_Options_AddCustomSpellFrame_text2", "ARTWORK", JSHB.options.AddCustomSpellFrame)
	JSHB.options.AddCustomSpellFrame.text2:SetFontObject(GameFontNormal)	
	JSHB.options.AddCustomSpellFrame.text2:SetJustifyH("CENTER")
	JSHB.options.AddCustomSpellFrame.text2:SetWidth(270)
	JSHB.options.AddCustomSpellFrame.text2:SetPoint("TOP", JSHB.options.AddCustomSpellFrame, "TOP", 0, -140)
	JSHB.options.AddCustomSpellFrame.text2:SetText("")
	
	JSHB.options.AddCustomSpellFrame.spellbox = CreateFrame("EditBox", "JSHB_editbox_spellbox", JSHB.options.AddCustomSpellFrame)
	JSHB.options.AddCustomSpellFrame.spellbox:SetAutoFocus(true)
	JSHB.options.AddCustomSpellFrame.spellbox:SetMultiLine(false)
	JSHB.options.AddCustomSpellFrame.spellbox:SetWidth(38)
	JSHB.options.AddCustomSpellFrame.spellbox:SetHeight(22) -- Useless, ignored - need to use setpoint to change frame height
	JSHB.options.AddCustomSpellFrame.spellbox:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background", })
	JSHB.options.AddCustomSpellFrame.spellbox:SetBackdropColor(.75, .75, .75, 0.7)
	JSHB.options.AddCustomSpellFrame.spellbox:SetFontObject(GameFontHighlight)
	JSHB.options.AddCustomSpellFrame.spellbox:SetFrameStrata("DIALOG")
	JSHB.options.AddCustomSpellFrame.spellbox:SetJustifyH("CENTER")
	JSHB.options.AddCustomSpellFrame.spellbox:SetMaxLetters(5)
	JSHB.options.AddCustomSpellFrame.spellbox:SetNumeric(true)
	JSHB.options.AddCustomSpellFrame.spellbox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	JSHB.options.AddCustomSpellFrame.spellbox:SetScript("OnTabPressed", function(self) self:ClearFocus() end)
	JSHB.options.AddCustomSpellFrame.spellbox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	JSHB.options.AddCustomSpellFrame.spellbox:SetScript("OnTextChanged", function(self)	
		if (GetSpellInfo(self:GetNumber()) ~= nil) then
			JSHB.options.AddCustomSpellFrame.text2:SetText(select(1, GetSpellInfo(self:GetNumber())))
		else		
			JSHB.options.AddCustomSpellFrame.text2:SetText(L.invalidspellid)
		end
	end)	
	JSHB.options.AddCustomSpellFrame.spellbox:SetPoint("TOP", JSHB.options.AddCustomSpellFrame, "TOP", 0, -90)
	
	JSHB.options.AddCustomSpellFrame.cancelButton = JSHB.options.CreateButton(JSHB.options.AddCustomSpellFrame, "JSHB_Options_AddCustomSpell_CancelButton", "Cancel", 60, 24)
	JSHB.options.AddCustomSpellFrame.cancelButton:SetPoint("BOTTOM", JSHB.options.AddCustomSpellFrame, "BOTTOM", -34, 6)
	JSHB.options.AddCustomSpellFrame.cancelButton:SetScript("OnClick", function(self) JSHB.options.AddCustomSpellFrame:Hide() end)

	JSHB.options.AddCustomSpellFrame.saveButton = JSHB.options.CreateButton(JSHB.options.AddCustomSpellFrame, "JSHB_Options_AddCustomSpell_SaveButton", L.savebutton2, 60, 24)
	JSHB.options.AddCustomSpellFrame.saveButton:SetPoint("BOTTOM", JSHB.options.AddCustomSpellFrame, "BOTTOM", 34, 6)
	JSHB.options.AddCustomSpellFrame.saveButton:SetScript("OnClick", function(self)

		local idx = #JSHB.options.AddCustomSpellFrame.custSpells + 1
		local i

		-- Add
		if  GetSpellInfo(JSHB.options.AddCustomSpellFrame.spellbox:GetNumber()) ~= nil then
		
			if (JSHB.options.AddCustomSpellFrame.custid == "customspell") then
			
				JSHB.options.customspell.spellids[#JSHB.options.customspell.spellids + 1] = JSHB.options.AddCustomSpellFrame.spellbox:GetNumber()
				table.sort(JSHB.options.customspell.spellids, function(a,b) return select(1, GetSpellInfo(a))<select(1, GetSpellInfo(b)) end)
				
			elseif (JSHB.options.AddCustomSpellFrame.custid == "customtranq") then
			
				JSHB.options.customtranq.spellids[#JSHB.options.customtranq.spellids + 1] = JSHB.options.AddCustomSpellFrame.spellbox:GetNumber()
				table.sort(JSHB.options.customtranq.spellids, function(a,b) return select(1, GetSpellInfo(a))<select(1, GetSpellInfo(b)) end)
				
			elseif (JSHB.options.AddCustomSpellFrame.custid == "customaura") then
			
				JSHB.options.customaura.spellids[#JSHB.options.customaura.spellids + 1] = JSHB.options.AddCustomSpellFrame.spellbox:GetNumber()
				table.sort(JSHB.options.customaura.spellids, function(a,b) return select(1, GetSpellInfo(a))<select(1, GetSpellInfo(b)) end)
			end

			JSHB.options.RefreshConfigurationSettingsForCustomSpell(JSHB.options.AddCustomSpellFrame.custid)

			JSHB.options.AddCustomSpellFrame:Hide()
		end
	end)
end


JSHB.options.AddTimer = function(spec, parent, editTimer)

	if JSHB.options.AddTimerFrame then
		JSHB.options.AddTimerFrame:SetParent(nil)
		JSHB.options.AddTimerFrame = nil
	end

	local specTimers = (spec == "bm") and JSHB.options.bm.Timers or ((spec == "mm") and JSHB.options.mm.Timers or JSHB.options.sv.Timers)
	
	local spellTable = {}
	local i, ii
	for i=1,#JSHB.spellid do
		spellTable[i] = { select(1, GetSpellInfo(JSHB.spellid[i][1])), JSHB.spellid[i][1] }
		
		if JSHB.spellid[i][2] == 1 then
			spellTable[i][1] = spellTable[i][1] .. " (|cffabd473" .. L.petspell .. "|r)"
		end
	end
	
	-- Add in the custom spells
	ii = #spellTable + 1
	for i=1,#JSHB.options.customspell.spellids do
		spellTable[ii] = { select(1, GetSpellInfo(JSHB.options.customspell.spellids[i])), JSHB.options.customspell.spellids[i] }
		ii = ii + 1
	end

	table.sort(spellTable, function(a,b) return a[1] < b[1] end)

	JSHB.options.AddTimerFrame = CreateFrame("Frame", "JSHB_Options_AddTimerFrame", parent)
	JSHB.options.AddTimerFrame:SetHeight(340)
	JSHB.options.AddTimerFrame:SetWidth(260)
	JSHB.options.AddTimerFrame:SetPoint("CENTER", 0, 0)
	JSHB.options.AddTimerFrame:Raise()
	JSHB.options.AddTimerFrame:Show()
	JSHB.options.AddTimerFrame:SetScript("OnHide", function()
		JSHB.options.AddTimerFrame:SetScript("OnHide", nil)
		JSHB.options.AddTimerFrame:Hide()
		JSHB.options.AddTimerFrame:SetParent(nil)
		JSHB.options.AddTimerFrame = nil
	end)
	JSHB.options.AddTimerFrame.editTimer = editTimer
	JSHB.options.AddTimerFrame.spec = spec
	JSHB.options.AddTimerFrame.specTimers = specTimers
	JSHB.options.AddTimerFrame.spellTable = spellTable

	local bgtex = JSHB.options.AddTimerFrame:CreateTexture(nil, "BACKGROUND", JSHB.options.AddTimerFrame)
	bgtex:SetAllPoints(JSHB.options.AddTimerFrame)
	bgtex:SetTexture(0, 0, 0, 1)
	
	JSHB.options.AddTimerFrame.border = CreateFrame("Frame", nil, JSHB.options.AddTimerFrame)
	JSHB.options.AddTimerFrame.border:SetBackdrop({
	  bgFile = "",
	  edgeFile = JSHB.getTexture("Blank"), 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	JSHB.options.AddTimerFrame.border:SetBackdropColor(.1,.1,.1,1)
	JSHB.options.AddTimerFrame.border:SetBackdropBorderColor(.6,.6,.6,1)
	JSHB.options.AddTimerFrame.border:SetPoint("TOPLEFT", -1, 1)
	JSHB.options.AddTimerFrame.border:SetPoint("BOTTOMRIGHT", 1, -1)

	local tableDurCD = { { L.cd, 0 }, { L.dur, 1 } }

	JSHB.options.AddTimerFrame.pickDurOrCD = JSHB.options.CreateDropdown(JSHB.options.AddTimerFrame, "JSHB_dropdown_pickDurOrCD", L.durorcd, function()

		JSHB.options.info = {}
		local i
		for i=1,#tableDurCD do
			JSHB.options.info.text = tableDurCD[i][1]
			JSHB.options.info.value = tableDurCD[i][2]
			JSHB.options.info.func = function(self) JSHB.options.AddTimerFrame.pickDurOrCD:SetValue(self.value, self.text) end
			JSHB.options.info.checked = false
			UIDropDownMenu_AddButton(JSHB.options.info)
		end
	end)

	JSHB.options.AddTimerFrame.pickDurOrCD:SetPoint("TOPLEFT", JSHB.options.AddTimerFrame, "TOPLEFT", 40, -80)
	JSHB.options.AddTimerFrame.pickDurOrCD:SetPoint("TOPRIGHT", JSHB.options.AddTimerFrame, "TOPRIGHT", -40, -110)

	UIDropDownMenu_SetSelectedValue(JSHB.options.AddTimerFrame.pickDurOrCD.dropdown, 
		editTimer ~= nil and (specTimers[editTimer][2] == true and 1 or 0) or tableDurCD[1][2])
	JSHB.options.AddTimerFrame.pickDurOrCD.valueText:SetText(
		editTimer ~= nil and (specTimers[editTimer][2]==true and tableDurCD[2][1] or tableDurCD[1][1]) or tableDurCD[1][1])

	local tablePlayerOrTarget = { { L.spelltexttarget, 0 }, { L.spelltextplayer, 1 }, { L.spelltextpet, 2 } }
	JSHB.options.AddTimerFrame.pickPlayerOrTarget = JSHB.options.CreateDropdown(JSHB.options.AddTimerFrame, "JSHB_dropdown_pickPlayerOrTarget", L.pickplayerortarget, function()

		JSHB.options.info = {}
		local i
		for i=1,#tablePlayerOrTarget do
			JSHB.options.info.text = tablePlayerOrTarget[i][1]
			JSHB.options.info.value = tablePlayerOrTarget[i][2]
			JSHB.options.info.func = function(self) JSHB.options.AddTimerFrame.pickPlayerOrTarget:SetValue(self.value, self.text) end
			JSHB.options.info.checked = false
			UIDropDownMenu_AddButton(JSHB.options.info)
		end
	end)
	JSHB.options.AddTimerFrame.pickPlayerOrTarget:SetPoint("TOPLEFT", JSHB.options.AddTimerFrame.pickDurOrCD, "TOPLEFT", 0, -55)
	JSHB.options.AddTimerFrame.pickPlayerOrTarget:SetPoint("TOPRIGHT", JSHB.options.AddTimerFrame.pickDurOrCD, "TOPRIGHT", 0, -55)

	if (editTimer ~= nil) and (specTimers[editTimer][3]==false) then specTimers[editTimer][3] = 0 end
	if (editTimer ~= nil) and (specTimers[editTimer][3]==true) then specTimers[editTimer][3] = 1 end
	UIDropDownMenu_SetSelectedValue(JSHB.options.AddTimerFrame.pickPlayerOrTarget.dropdown,
		editTimer ~= nil and specTimers[editTimer][3] or tablePlayerOrTarget[1][2])
	JSHB.options.AddTimerFrame.pickPlayerOrTarget.valueText:SetText(
		editTimer ~= nil and tablePlayerOrTarget[specTimers[editTimer][3]+1][1] or tablePlayerOrTarget[1][1])

	JSHB.options.AddTimerFrame.pickLocation = JSHB.options.CreateDropdown(JSHB.options.AddTimerFrame, "JSHB_dropdown_pickLocation", L.pickLocation, function()

		JSHB.options.info = {}
		local i
		for i=1,#JSHB.timerpositions do
			JSHB.options.info.text = JSHB.timerpositions[i][1]
			JSHB.options.info.value = JSHB.timerpositions[i][2]
			JSHB.options.info.func = function(self) JSHB.options.AddTimerFrame.pickLocation:SetValue(self.value, self.text) end
			JSHB.options.info.checked = false
			UIDropDownMenu_AddButton(JSHB.options.info)
		end
	end)
	JSHB.options.AddTimerFrame.pickLocation:SetPoint("TOPLEFT", JSHB.options.AddTimerFrame.pickPlayerOrTarget, "TOPLEFT", 0, -55)
	JSHB.options.AddTimerFrame.pickLocation:SetPoint("TOPRIGHT", JSHB.options.AddTimerFrame.pickPlayerOrTarget, "TOPRIGHT", 0, -55)
	UIDropDownMenu_SetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown, editTimer ~= nil and specTimers[editTimer][4] or JSHB.timerpositions[1][2])
	JSHB.options.AddTimerFrame.pickLocation.valueText:SetText(
		editTimer ~= nil and JSHB.timerpositions.getValueName(specTimers[editTimer][4]) or JSHB.timerpositions[1][1])

	JSHB.options.AddTimerFrame.pickOffset = JSHB.options.CreateSlider("JSHB_Options_AddTimerFrame_pickOffset", JSHB.options.AddTimerFrame, L.pickOffset, 1, 50, 1, 220, 15)
	JSHB.options.AddTimerFrame.pickOffset:SetPoint("TOPLEFT", JSHB.options.AddTimerFrame, "TOPLEFT", 20, -260)
	JSHB.options.AddTimerFrame.pickOffset:Hide()

	JSHB.options.AddTimerFrame.pickSpell = JSHB.options.CreateScrollingDropdown(JSHB.options.AddTimerFrame, "JSHB_pickSpell", L.pickSpell, spellTable)
	JSHB.options.AddTimerFrame.pickSpell:SetPoint("TOPLEFT", JSHB.options.AddTimerFrame, "TOPLEFT", 40, -25)
	JSHB.options.AddTimerFrame.pickSpell:SetValue(
		editTimer ~= nil and (select(1, GetSpellInfo(specTimers[editTimer][1])) .. (specTimers[editTimer][3] == 2 and " (|cffabd473" .. L.petspell .. "|r)" or "")) or spellTable[1][1])

	local button_OnClick = JSHB.options.AddTimerFrame.pickSpell.button:GetScript("OnClick")
	JSHB.options.AddTimerFrame.pickSpell.button:SetScript("OnClick", function(self)
		button_OnClick(self)
		JSHB.options.AddTimerFrame.pickSpell.dropdown.list:Hide()

		local OnShow = JSHB.options.AddTimerFrame.pickSpell.dropdown.list:GetScript("OnShow")
		JSHB.options.AddTimerFrame.pickSpell.dropdown.list:SetScript("OnShow", function(self)
			OnShow(self)
		end)

		local OnVerticalScroll = JSHB.options.AddTimerFrame.pickSpell.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
		JSHB.options.AddTimerFrame.pickSpell.dropdown.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
			OnVerticalScroll(self, delta)
		end)

		local SetText = JSHB.options.AddTimerFrame.pickSpell.dropdown.list.text.SetText
		JSHB.options.AddTimerFrame.pickSpell.dropdown.list.text.SetText = function(self, text)
			SetText(self, text)
		end

		button_OnClick(self)
		self:SetScript("OnClick", button_OnClick)
	end)

	JSHB.options.AddTimerFrame.cancelButton = JSHB.options.CreateButton(JSHB.options.AddTimerFrame, "JSHB_Options_AddTimer_CancelButton", "Cancel", 60, 24)
	JSHB.options.AddTimerFrame.cancelButton:SetPoint("BOTTOM", JSHB.options.AddTimerFrame, "BOTTOM", -34, 6)
	JSHB.options.AddTimerFrame.cancelButton:SetScript("OnClick", function(self) JSHB.options.AddTimerFrame:Hide() end)

	JSHB.options.AddTimerFrame.saveButton = JSHB.options.CreateButton(JSHB.options.AddTimerFrame, "JSHB_Options_AddTimer_SaveButton", editTimer ~= nil and L.savebutton1 or L.savebutton2, 60, 24)
	JSHB.options.AddTimerFrame.saveButton:SetPoint("BOTTOM", JSHB.options.AddTimerFrame, "BOTTOM", 34, 6)
	JSHB.options.AddTimerFrame.saveButton:SetScript("OnClick", function(self)

		local idx = #JSHB.options.AddTimerFrame.specTimers + 1
		local i

		-- Add
		if not JSHB.options.AddTimerFrame.editTimer then
			JSHB.options.AddTimerFrame.specTimers[idx] = { 0, 0, 0, 0 }
			for i=1,#JSHB.options.AddTimerFrame.spellTable do
				if JSHB.options.AddTimerFrame.spellTable[i][1] == JSHB.options.AddTimerFrame.pickSpell:GetValue() then
					JSHB.options.AddTimerFrame.specTimers[idx][1] = JSHB.options.AddTimerFrame.spellTable[i][2]
					break
				end
			end
			JSHB.options.AddTimerFrame.specTimers[idx][2] = (UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickDurOrCD.dropdown) == 1) and true or false
			JSHB.options.AddTimerFrame.specTimers[idx][3] = UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickPlayerOrTarget.dropdown)
			JSHB.options.AddTimerFrame.specTimers[idx][4] = UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown)
			JSHB.options.AddTimerFrame.specTimers[idx][5] = JSHB.options.AddTimerFrame.pickOffset:GetValue()
			JSHB.options.AddTimerFrame.specTimers =
				mF.fixIconTimerIndex(JSHB.options.AddTimerFrame.specTimers, JSHB.options.AddTimerFrame.specTimers[idx][4], idx)

		-- Update
		else
			for i=1,#JSHB.options.AddTimerFrame.spellTable do
				if JSHB.options.AddTimerFrame.spellTable[i][1] == JSHB.options.AddTimerFrame.pickSpell:GetValue() then 
					JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][1] = JSHB.options.AddTimerFrame.spellTable[i][2]
					break
				end
			end
			JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][2] = (UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickDurOrCD.dropdown) == 1) and true or false
			JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][3] = UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickPlayerOrTarget.dropdown)
			JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][4] = UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown)
			JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] = JSHB.options.AddTimerFrame.pickOffset:GetValue()
			JSHB.options.AddTimerFrame.specTimers =
				mF.fixIconTimerIndex(JSHB.options.AddTimerFrame.specTimers, JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][4], JSHB.options.AddTimerFrame.editTimer)
		end
		table.sort(JSHB.options.AddTimerFrame.specTimers, function(a,b) return select(1, GetSpellInfo(a[1]))<select(1, GetSpellInfo(b[1])) end)

		JSHB.options.RefreshConfigurationSettingsForSpec(JSHB.options.AddTimerFrame.spec)

		JSHB.options.AddTimerFrame:Hide()
	end)

	JSHB.options.AddTimerFrame.lastVal = nil
	JSHB.options.AddTimerFrame.updateTimer = 0
	JSHB.options.AddTimerFrame:SetScript("OnUpdate", function(self, elapsed)

		self.updateTimer = self.updateTimer + elapsed

		if self.updateTimer > 0.25 then

			local val = UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown)
			if ((val == JSHB.pos.LEFT) or (val == JSHB.pos.RIGHT)) and ((not JSHB.options.AddTimerFrame.pickOffset:IsShown()) or (val ~= JSHB.options.AddTimerFrame.lastVal)) then

				JSHB.options.AddTimerFrame.lastVal = val

				JSHB.options.AddTimerFrame.pickOffset.leftCount = 1
				JSHB.options.AddTimerFrame.pickOffset.rightCount = JSHB.options.AddTimerFrame.pickOffset.leftCount

				local x
				for x=1,#JSHB.options.AddTimerFrame.specTimers do
					if JSHB.options.AddTimerFrame.specTimers[x][4] == JSHB.pos.LEFT then JSHB.options.AddTimerFrame.pickOffset.leftCount = JSHB.options.AddTimerFrame.pickOffset.leftCount + 1 end
					if JSHB.options.AddTimerFrame.specTimers[x][4] == JSHB.pos.RIGHT then JSHB.options.AddTimerFrame.pickOffset.rightCount = JSHB.options.AddTimerFrame.pickOffset.rightCount + 1 end
				end

				if (JSHB.options.AddTimerFrame.editTimer ~= nil) then

					if (JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][4] == JSHB.pos.LEFT) then

						if (UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown) == JSHB.pos.LEFT) then

							JSHB.options.AddTimerFrame.pickOffset.leftCount = JSHB.options.AddTimerFrame.pickOffset.leftCount - 1
							JSHB.options.AddTimerFrame.pickOffset.rightCount = JSHB.options.AddTimerFrame.pickOffset.rightCount + 1
						end

					elseif (JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][4] == JSHB.pos.RIGHT) then

						if (UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown) == JSHB.pos.RIGHT) then

							JSHB.options.AddTimerFrame.pickOffset.leftCount = JSHB.options.AddTimerFrame.pickOffset.leftCount + 1
							JSHB.options.AddTimerFrame.pickOffset.rightCount = JSHB.options.AddTimerFrame.pickOffset.rightCount - 1
						end
					end
				end

				if (UIDropDownMenu_GetSelectedValue(JSHB.options.AddTimerFrame.pickLocation.dropdown) == JSHB.pos.LEFT) then

					JSHB.options.AddTimerFrame.pickOffset:SetMinMaxValues(1, JSHB.options.AddTimerFrame.pickOffset.leftCount)
				else
					JSHB.options.AddTimerFrame.pickOffset:SetMinMaxValues(1, JSHB.options.AddTimerFrame.pickOffset.rightCount)
				end

				if (JSHB.options.AddTimerFrame.editTimer ~= nil) and (JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] ~= nil) then

					if (val == JSHB.pos.LEFT) then

						JSHB.options.AddTimerFrame.pickOffset:SetValue(
							((JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] >= 1) and (JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] <= JSHB.options.AddTimerFrame.pickOffset.leftCount))
							 and JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] or JSHB.options.AddTimerFrame.pickOffset.leftCount)
					else
						JSHB.options.AddTimerFrame.pickOffset:SetValue(
							((JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] >= 1) and (JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] <= JSHB.options.AddTimerFrame.pickOffset.rightCount))
							 and JSHB.options.AddTimerFrame.specTimers[JSHB.options.AddTimerFrame.editTimer][5] or JSHB.options.AddTimerFrame.pickOffset.rightCount)
					end

				elseif (val == JSHB.pos.LEFT) then

					JSHB.options.AddTimerFrame.pickOffset:SetValue(JSHB.options.AddTimerFrame.pickOffset.leftCount)
				else
					JSHB.options.AddTimerFrame.pickOffset:SetValue(JSHB.options.AddTimerFrame.pickOffset.rightCount)
				end

				JSHB.options.AddTimerFrame.pickOffset:Show()

			elseif (val ~= JSHB.pos.LEFT) and (val ~= JSHB.pos.RIGHT) and JSHB.options.AddTimerFrame.pickOffset:IsShown() then

				JSHB.options.AddTimerFrame.pickOffset:Hide()
			end
		end
	end)

	JSHB.options.info = {}
end


JSHB.options.RefreshConfigurationSettingsForCustomSpell = function(typ)

	local x
	for x=1,300 do
		if _G["JSHB_Options_customspell_"..typ..x] ~= nil then
			_G["JSHB_Options_customspell_"..typ..x]:Hide()
			_G["JSHB_Options_customspell_"..typ..x] = nil
		end
	end

	local custSpells = (typ == "customspell") and JSHB.options.customspell.spellids or ((typ == "customtranq") and JSHB.options.customtranq.spellids or JSHB.options.customaura.spellids)
	
	if (not custSpells) or (#custSpells == 0) then
		JSHB.options[typ].text1:SetText(L.nocustomspells)
		return 
	else
		JSHB.options[typ].text1:SetText(format(L.customspellsdefined, #custSpells))
	end

	for x=1,#custSpells do
		JSHB.options.createSpellFrame(typ, JSHB.options[typ], "JSHB_Options_customspell_"..typ..x, x, JSHB.options[typ].text1, -((x-1)*37))
	end
end


JSHB.options.RefreshConfigurationSettingsForSpec = function(spec)

	local x
	for x=1,300 do
		if _G["JSHB_Options_timers_"..spec..x] ~= nil then
			_G["JSHB_Options_timers_"..spec..x]:Hide()
			_G["JSHB_Options_timers_"..spec..x] = nil
		end
	end

	if (not JSHB.options[spec].Timers) or (#JSHB.options[spec].Timers == 0) then
		JSHB.options[spec].text1:SetText(L.nottracking .. L["name"..spec])
		return 
	else
		JSHB.options[spec].text1:SetText(format(L.currentlytracking1 .. L["name"..spec] .. L.currentlytracking2, #JSHB.options[spec].Timers))
	end

	for x=1,#JSHB.options[spec].Timers do
		JSHB.options.createTimerFrame(spec, JSHB.options[spec], "JSHB_Options_timers_"..spec..x, x, JSHB.options[spec].text1, -((x-1)*37))
	end
end


JSHB.options.ApplyDefaultConfigurationSettingsForCustomSpell = function(typ)

	local x
	for x=1,300 do
		if _G["JSHB_Options_customspell_"..typ..x] ~= nil then
			_G["JSHB_Options_customspell_"..typ..x]:Hide()
			_G["JSHB_Options_customspell_"..typ..x] = nil
		end
	end

	if (typ == "customspell") then
		JSHB.options.customspell.spellids = { }
	elseif (typ == "customtranq") then
		JSHB.options.customtranq.spellids = { }
	elseif (typ == "customaura") then
		JSHB.options.customaura.spellids = { }
	end

	JSHB.reconfigureAddon()
	JSHB.setupOptionsPane()
end


JSHB.options.ApplyDefaultConfigurationSettingsFor = function(category)

	local x, y
	for x,y in pairs(JSHB.defaults[category]) do 
		DB[x] = y
	end

	JSHB.reconfigureAddon()
	JSHB.setupOptionsPane()
end


JSHB.options.ApplyDefaultConfigurationSettingsForSpec = function(spec)

	local x
	for x=1,300 do
		if _G["JSHB_Options_timers_"..spec..x] ~= nil then
			_G["JSHB_Options_timers_"..spec..x]:Hide()
			_G["JSHB_Options_timers_"..spec..x] = nil
		end
	end

	local x, y
	DB.timers[spec] = {}
	for x,y in pairs(JSHB.defaults[spec]) do 
		DB.timers[spec][x] = y
	end

	table.sort(DB.timers[spec], function(a,b) return select(1, GetSpellInfo(a[1])) < select(1, GetSpellInfo(b[1])) end)
	JSHB.options[spec].Timers = DB.timers[spec]

	JSHB.reconfigureAddon()
	JSHB.setupOptionsPane()
end


JSHB.options.CreateButton = function(parent, frameName, label, width, height, onclick, fontObject)

	if _G[frameName] then
		_G[frameName..'Text'] = nil
		_G[frameName] = nil		
	end

	local button = CreateFrame("Button", frameName, parent, "UIPanelButtonTemplate")
	button:SetWidth(width or 100)
	button:SetHeight(height or 20)
	button:SetText(label)

	if onclick then
		button:SetScript("OnClick", function(self) PlaySound("igMainMenuOptionCheckBoxOn"); ToggleDropDownMenu(nil, nil, self:GetParent()) end)
	end
	if fontObject then
		button:SetNormalFontObject(fontObject);
		button:SetHighlightFontObject(fontObject);		
	end
	if _G[frameName.."Text"]:GetStringWidth() > button:GetWidth() then
		button:SetWidth( _G[frameName.."Text"]:GetStringWidth() + 25 )
	end

	return button
end


function JSHB.options.CreateCheckButton(ref, parent, label)

	if _G[ref] then
		_G[ref..'Text'] = nil
		_G[ref] = nil		
	end

	local checkbutton = CreateFrame("CheckButton", ref, parent, "InterfaceOptionsCheckButtonTemplate")
	_G[ref.."Text"]:SetText(label)
	_G[ref.."Text"]:SetJustifyH("LEFT")
	checkbutton.GetValue = function() if checkbutton:GetChecked() then return true else return false end end
	checkbutton.SetValue = checkbutton.SetChecked
	return checkbutton
end


JSHB.options.CreateSlider = function(frametitle, parent, text, low, high, step, framewidth, frameheight)

	if _G[frametitle] then
		_G[frametitle..'Text'] = nil
		_G[frametitle] = nil		
	end

	local slider = CreateFrame('Slider', frametitle, parent, 'OptionsSliderTemplate')
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)
	slider:SetWidth(framewidth)
	slider:SetHeight(frameheight)
	slider.myName = frametitle
	slider.myText = text
	_G[frametitle..'Text']:SetFormattedText(text, slider:GetValue())
	slider:SetScript("OnValueChanged", function(self, value) _G[self.myName..'Text']:SetFormattedText(self.myText, self:GetValue()) end)
	return slider
end

function JSHB.options.CreateColorEditBox(color, framename, parent, nextTabIndex)

	local editbox = CreateFrame("EditBox", framename, parent)
	editbox:SetAutoFocus(false)
	editbox:SetMultiLine(false)
	editbox:SetWidth(26)
	editbox:SetHeight(22) -- Useless, ignored - need to use setpoint to change frame height
	editbox:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background", })
	editbox:SetBackdropColor(color[1], color[2], color[3], 0.5)
	editbox:SetFontObject(GameFontHighlight)
	editbox:SetFrameStrata("DIALOG")
	editbox:SetJustifyH("RIGHT")
	editbox:SetMaxLetters(3)
	editbox:SetNumeric(true)
	editbox:SetScript("OnEscapePressed", function(self) if self:GetNumber() > 255 then self:SetNumber(255) end; self:ClearFocus() end)
	editbox:SetScript("OnTabPressed", function(self)
		if self:GetNumber() > 255 then self:SetNumber(255) end
		self:ClearFocus()
		_G[self:GetParent():GetName()..nextTabIndex]:SetFocus()
	end)
	editbox:SetScript("OnEnterPressed", function(self)
		if self:GetNumber() > 255 then self:SetNumber(255) end
		_G[self:GetParent():GetName()..nextTabIndex]:SetFocus()
		self:GetParent().SetColors(self:GetParent().redbox:GetNumber()/255, self:GetParent().greenbox:GetNumber()/255, self:GetParent().bluebox:GetNumber()/255)
	end)
		
	return editbox
end
	

function JSHB.options.CreateColorSelector(frametitle, parent, text, textwidth, withalpha)

	if _G[frametitle] then _G[frametitle] = nil end

	--- Color select texture with wheel and value
	local colorselect = CreateFrame("ColorSelect", frametitle, parent)
	colorselect:SetWidth(withalpha and (101) or 64)
	colorselect:SetHeight(64)
		
	-- create a color wheel
	local colorwheel = colorselect:CreateTexture()
	colorwheel:SetWidth(64)
	colorwheel:SetHeight(64)
	colorwheel:SetPoint("TOPLEFT", colorselect, "TOPLEFT", 5, 0)
	colorselect:SetColorWheelTexture(colorwheel)
	
	-- create the colorpicker
	local pickertexture = colorselect:CreateTexture()
	pickertexture:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons")
	pickertexture:SetWidth(10)
	pickertexture:SetHeight(10)
	pickertexture:SetTexCoord(0,0.15625, 0, 0.625)
	colorselect:SetColorWheelThumbTexture(pickertexture)
	
	if withalpha then
		-- create the alpha bar
		local colorvalue = colorselect:CreateTexture()
		colorvalue:SetWidth(32)
		colorvalue:SetHeight(64)
		colorvalue:SetPoint("LEFT", colorwheel, "RIGHT", 10, -3)
		colorselect:SetColorValueTexture(colorvalue)
	
		-- create the alpha arrows
		local thumbtexture = colorselect:CreateTexture()
		thumbtexture:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons")
		thumbtexture:SetWidth(48)
		thumbtexture:SetHeight(14)
		thumbtexture:SetTexCoord(0.25, 1, 0.875, 0)
		colorselect:SetColorValueThumbTexture(thumbtexture)
	end
	
	colorselect.sampletext = colorselect:CreateFontString(frametitle.."SampleText", "ARTWORK")
	colorselect.sampletext:SetFontObject(GameFontNormal)
	colorselect.sampletext:SetText(text)
	colorselect.sampletext:SetJustifyH("CENTER")
	colorselect.sampletext:SetWidth(textwidth)
	colorselect.sampletext:SetPoint("BOTTOM", colorselect, "TOP", 5, 4)

	-- Add input fields
	colorselect.greenbox = JSHB.options.CreateColorEditBox({ 0, 1, 0}, frametitle.."greenbox", colorselect, "bluebox")
	colorselect.greenbox:SetPoint("TOP", colorselect, "BOTTOM", 5, -7)

	colorselect.redbox = JSHB.options.CreateColorEditBox({ 1, 0, 0}, frametitle.."redbox", colorselect, "greenbox")
	colorselect.redbox:SetPoint("RIGHT", colorselect.greenbox, "LEFT", -3, 0)

	colorselect.bluebox = JSHB.options.CreateColorEditBox({ 0, 0, 1}, frametitle.."bluebox", colorselect, "redbox")
	colorselect.bluebox:SetPoint("LEFT", colorselect.greenbox, "RIGHT", 3, 0)

	colorselect.SetColors = function(r, g, b)
		colorselect:SetColorRGB(ceil(r), ceil(g), ceil(b))
		colorselect.redbox:SetNumber(ceil(r*255))
		colorselect.greenbox:SetNumber(ceil(g*255))
		colorselect.bluebox:SetNumber(ceil(b*255))
	end
	
	-- Add script to change the color of the text font to match selected color
	colorselect:SetScript("OnColorSelect", function(self)
		self.sampletext:SetTextColor(self:GetColorRGB())
		self.redbox:SetNumber(ceil(select(1, self:GetColorRGB())*255))
		self.greenbox:SetNumber(ceil(select(2, self:GetColorRGB())*255))
		self.bluebox:SetNumber(ceil(select(3, self:GetColorRGB())*255))
	end)
	
	colorselect:SetScript("OnShow", function(self)
		self.redbox:SetNumber(ceil(select(1, self:GetColorRGB())*255)); self.redbox:SetCursorPosition(0)
		self.greenbox:SetNumber(ceil(select(2, self:GetColorRGB())*255)); self.greenbox:SetCursorPosition(0)
		self.bluebox:SetNumber(ceil(select(3, self:GetColorRGB())*255)); self.bluebox:SetCursorPosition(0)
	end)
	
	return colorselect
end

local ii = 0
function JSHB.options.CreateDropdown(parent, frametitle, name, init)

	if _G[frametitle .. "_Dropdown"] then
		_G[frametitle .. "_Dropdown"] = nil		
	end

	ii = ii + 1

	local frame = CreateFrame("Frame", frametitle .. "_Dropdown", parent)
	frame:SetHeight(42)
	frame:SetWidth(162)
	frame:EnableMouse(true)
	frame:SetScript("OnEnter", function(self)
		if self.desc then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.desc, nil, nil, nil, nil, true)
		end
	end)
	frame:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	frame:SetScript("OnHide", function(self) CloseDropDownMenus() end)

	local dropdown = CreateFrame("Frame", frametitle .. "_Dropdown" .. ii, frame)
	dropdown:SetPoint("TOPLEFT", frame, -16, -14)
	dropdown:SetPoint("TOPRIGHT", frame, 16, -14)
	dropdown:SetHeight(32)

	local ltex = dropdown:CreateTexture(dropdown:GetName() .. "Left", "ARTWORK")
	ltex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	ltex:SetTexCoord(0, 0.1953125, 0, 1)
	ltex:SetPoint("TOPLEFT", dropdown, 0, 17)
	ltex:SetWidth(25)
	ltex:SetHeight(64)

	local rtex = dropdown:CreateTexture(nil, "BORDER")
	rtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	rtex:SetTexCoord(0.8046875, 1, 0, 1)
	rtex:SetPoint("TOPRIGHT", dropdown, 0, 17)
	rtex:SetWidth(25)
	rtex:SetHeight(64)

	local mtex = dropdown:CreateTexture(nil, "BORDER")
	mtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	mtex:SetTexCoord(0.1953125, 0.8046875, 0, 1)
	mtex:SetPoint("LEFT", ltex, "RIGHT")
	mtex:SetPoint("RIGHT", rtex, "LEFT")
	mtex:SetHeight(64)

	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 20, 0)
	label:SetPoint("BOTTOMRIGHT", dropdown, "TOPRIGHT", -20, 0)
	label:SetJustifyH("LEFT")
	label:SetText(name)

	local value = dropdown:CreateFontString(dropdown:GetName() .. "Text", "OVERLAY", "GameFontHighlightSmall")
	value:SetPoint("LEFT", ltex, 26, 2)
	value:SetPoint("RIGHT", rtex, -43, 2)
	value:SetJustifyH("LEFT")
	value:SetHeight(10)

	local button = CreateFrame("Button", nil, dropdown)
	button:SetPoint("TOPRIGHT", rtex, -16, -18)
	button:SetWidth(24)
	button:SetHeight(24)
	button:SetScript("OnEnter", function(self)
		if self.desc then
			GameTooltip:SetOwner(self:GetParent():GetParent(), "ANCHOR_RIGHT")
			GameTooltip:SetText(self:GetParent():GetParent().desc, nil, nil, nil, nil, true)
		end
	end)
	button:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	button:SetScript("OnClick", function(self) PlaySound("igMainMenuOptionCheckBoxOn"); ToggleDropDownMenu(nil, nil, self:GetParent()) end)

	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	button:GetHighlightTexture():SetBlendMode("ADD")

	frame.button = button
	frame.dropdown = dropdown
	frame.labelText = label
	frame.valueText = value

	frame.SetValue = function(self, value, text) self.valueText:SetText(text or value); UIDropDownMenu_SetSelectedValue(self.dropdown, value or "UNKNOWN") end
	frame.GetValue = function(self) return UIDropDownMenu_GetSelectedValue(self.dropdown) or self.valueText:GetText() end

	if init then
		UIDropDownMenu_Initialize(dropdown, init)
	end

	return frame
end


local function ListButton_OnClick(self)
	local dropdown = self:GetParent():GetParent()
	dropdown.selected = self.value
	dropdown.list:Hide()

	local container = dropdown:GetParent()
	container.valueText:SetText(self.value)

	if container.OnValueChanged then
		container:OnValueChanged(self.value)
	end

	PlaySound("UChatScrollButton")
end


local function CreateListButton(parent)
	local button = CreateFrame("Button", nil, parent)
	button:SetHeight(UIDROPDOWNMENU_BUTTON_HEIGHT)

	button.label = button:CreateFontString()
	button.label:SetFont((GameFontHighlightSmallLeft:GetFont()), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
	button.label:SetJustifyH("LEFT")
	button.label:SetPoint("LEFT", 27, 0)

	button.check = button:CreateTexture(nil, "ARTWORK")
	button.check:SetWidth(24)
	button.check:SetHeight(24)
	button.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	button.check:SetPoint("LEFT")

	local highlight = button:CreateTexture(nil, "BACKGROUND")
	highlight:SetAllPoints(button)
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetAlpha(0.6)
	highlight:SetBlendMode("ADD")
	highlight:Hide()
	button:SetHighlightTexture(highlight)

	button:SetScript("OnClick", ListButton_OnClick)

	return button
end


local function UpdateList(self)

	local buttons = self.buttons
	local items = self:GetParent().items
	local listSize = min(#items, 10) -- 10 = Max number of items from the list to display at one time

	local scrollFrame = self.scrollFrame
	local offset = scrollFrame.offset
	FauxScrollFrame_Update(scrollFrame, #items, listSize, UIDROPDOWNMENU_BUTTON_HEIGHT)

	local selected = self:GetParent().selected

	for i = 1, listSize do
		local index = i + offset
		local button = self.buttons[i]

		local item = items[index]
		if item then
			button.value = item
			button.label:SetText(item)

			if item == selected then
				button.check:Show()
			else
				button.check:Hide()
			end

			button:SetWidth(self.width)
			button:Show()
		else
			button.value = nil
			button.label:SetText()
			button.check:Hide()
			button:Hide()
		end
	end

	for i = listSize + 1, #buttons do
		buttons[i]:Hide()
	end

	if self.scrollFrame:IsShown() then
		self:SetWidth(self.width + 50)
	else
		self:SetWidth(self.width + 30)
	end
	self:SetHeight((listSize * UIDROPDOWNMENU_BUTTON_HEIGHT) + (UIDROPDOWNMENU_BORDER_HEIGHT * 2))
end


function JSHB.options.CreateList(parent)

	local list = CreateFrame("Button", parent:GetName() .. "List", parent)
	list:SetToplevel(true)
	list:Raise()

	list.text = list:CreateFontString()
	list.text:SetFont("Fonts\\FRIZQT__.ttf", UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 2)

	list.buttons = setmetatable({}, { __index = function(t, i)
		local button = CreateListButton(list)
		if i > 1 then
			button:SetPoint("TOPLEFT", t[i-1], "BOTTOMLEFT")
		else
			button:SetPoint("TOPLEFT", 15, -15)
		end
		t[i] = button

		return button
	end })

	list.scrollFrame = CreateFrame("ScrollFrame", list:GetName() .. "ScrollFrame", list, "FauxScrollFrameTemplate")
	list.scrollFrame:SetPoint("TOPLEFT", 6, -7)-- 12, -14
	list.scrollFrame:SetPoint("BOTTOMRIGHT", -30, 6)-- -36,13
	list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
		FauxScrollFrame_OnVerticalScroll(self, delta, UIDROPDOWNMENU_BUTTON_HEIGHT, function() UpdateList(list) end)
	end)

	list.border = CreateFrame("Frame", nil, list)
	list.border:SetBackdrop({
	  bgFile = "",
	  edgeFile = JSHB.getTexture("Blank"), 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	list.border:SetBackdropColor(.1,.1,.1,1)
	list.border:SetBackdropBorderColor(.6,.6,.6,1)
	list.border:SetPoint("TOPLEFT", -1, 1)
	list.border:SetPoint("BOTTOMRIGHT", 1, -1)

	list:SetScript("OnShow", function(self)
		self.width = 0
		for i, item in pairs(self:GetParent().items) do
			self.text:SetText(item)
			self.width = max(self.text:GetWidth() + 60, self.width)
		end
		UpdateList(self)
	end)
	list:SetScript("OnHide", list.Hide)
	list:SetScript("OnClick", list.Hide)
	list:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 12, 6)
	list:Hide()

	local bgtex = list:CreateTexture(nil, "BACKGROUND", list)
	bgtex:SetAllPoints(list)
	bgtex:SetTexture(0, 0, 0, 1)

	return list
end


local function DropdownButton_OnClick(self)

	local list = self:GetParent().list
	if list then
		if list:IsShown() then 
			list:Hide()
		else
			list:SetToplevel(true)
			list:Raise()
			list:Show()
		end
	else
		local dropdown = self:GetParent()
		dropdown.list = JSHB.options.CreateList(dropdown)
		dropdown.list:Show()
	end
end


function JSHB.options.CreateScrollingDropdown(parent, frametitle, name, items)

	if _G[frametitle] then
		_G[frametitle] = nil		
	end

	local container = JSHB.options.CreateDropdown(parent, "JSHB_ScrollingDropdown" .. frametitle, name)
	local singleColTable = { }
	local i

	for i=1,#items do
		singleColTable[i] = items[i][1]
	end

	if type(singleColTable) == "table" then
		container.button:SetScript("OnClick", DropdownButton_OnClick)
		container.dropdown.items = singleColTable
	end

	container.SetValue = function(self, value, text) self.valueText:SetText(text or value) self.dropdown.selected = value end

	return container
end


-- Register in the Interface Addon Options GUI
JSHB.options.enablebarlock = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablebarlock", JSHB.options, L.enablebarlock)
JSHB.options.enablebarlock:SetPoint("TOPLEFT", 10, -10)


-- Create general options panel
JSHB.options.genscrollframeparent = CreateFrame("Frame", "JSHB.optionsGeneralScrollFrameParent", JSHB.options)
JSHB.options.genscrollframeparent.name = L.namegeneral
JSHB.options.genscrollframeparent.parent = JSHB.options.name

JSHB.options.genscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsGeneralScrollFrame", JSHB.options.genscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.genscrollframe:SetPoint("TOPLEFT", JSHB.options.genscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.genscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.genscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.genscrollframe:SetPoint("RIGHT", JSHB.options.genscrollframeparent, "RIGHT", -28, 0)
JSHB.options.genscrollframe:SetFrameLevel(JSHB.options.genscrollframeparent:GetFrameLevel())

JSHB.options.general = CreateFrame("Frame", "JSHB.optionsGeneral", JSHB.options.genscrollframe)
JSHB.options.general:SetWidth(350)
JSHB.options.general:SetHeight(450)

local optgen = JSHB.options.general

optgen.enablestackbars = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablestackbars", optgen, L.enablestackbars)
optgen.enablestackbars:SetPoint("TOPLEFT", 10, -10)

optgen.movestackbarstotop =
	JSHB.options.CreateCheckButton("JSHB_Options_movestackbarstotop", optgen, L.movestackbarstotop)
optgen.movestackbarstotop:SetPoint("TOPLEFT", optgen.enablestackbars, "TOPLEFT", 10, -25)

optgen.enableautoshotbar = 
	JSHB.options.CreateCheckButton("JSHB_Options_enableautoshotbar", optgen, L.enableautoshotbar)
optgen.enableautoshotbar:SetPoint("TOPLEFT", optgen.movestackbarstotop, "TOPLEFT", -10, -25)

optgen.enableautoshottext = 
	JSHB.options.CreateCheckButton("JSHB_Options_enableautoshottext", optgen, L.enableautoshottext)
optgen.enableautoshottext:SetPoint("TOPLEFT", optgen.enableautoshotbar, "TOPLEFT", 0, -25)

optgen.enablemaintick = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablemaintick", optgen, L.enablemaintick)
optgen.enablemaintick:SetPoint("TOPLEFT", optgen.enableautoshottext, "TOPLEFT", 0, -25)

optgen.enablehuntersmarkwarning = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablehuntersmarkwarning", optgen, L.enablehuntersmarkwarning)
optgen.enablehuntersmarkwarning:SetPoint("TOPLEFT", optgen.enablemaintick, "TOPLEFT", 0, -25)

optgen.enabletranqannounce = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletranqannounce", optgen, L.enabletranqannounce)
optgen.enabletranqannounce:SetPoint("TOPLEFT", optgen.enablehuntersmarkwarning, "TOPLEFT", 0, -25)

optgen.tranqannouncechannel = JSHB.options.CreateDropdown(optgen, "JSHB_dropdown_tranqannouncechannel", L.tranqannouncechannel, function()

	JSHB.options.info = {}
	local i
	for i=1,#JSHB.chatchannels do
		JSHB.options.info.text = JSHB.chatchannels[i][1]
		JSHB.options.info.value = JSHB.chatchannels[i][2] or 1
		JSHB.options.info.func = function(self) optgen.tranqannouncechannel:SetValue(self.value, self.text) end
		JSHB.options.info.checked = false
		UIDropDownMenu_AddButton(JSHB.options.info)
	end
end)
optgen.tranqannouncechannel:SetPoint("TOPLEFT", optgen.enabletranqannounce, "TOPLEFT", 25, -25)
optgen.tranqannouncechannel:SetPoint("TOPRIGHT", optgen.enabletranqannounce, "TOPLEFT", 160, -45)

optgen.enabletranqalert = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletranqalert", optgen, L.enabletranqalert)
optgen.enabletranqalert:SetPoint("TOPLEFT", optgen.tranqannouncechannel, "TOPLEFT", -25, -50)

optgen.enablecctimers = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablecctimers", optgen, L.enablecctimers)
optgen.enablecctimers:SetPoint("TOPLEFT", optgen.enabletranqalert, "TOPLEFT", 0, -25)

optgen.enableprediction = 
	JSHB.options.CreateCheckButton("JSHB_Options_enableprediction", optgen, L.enableprediction)
optgen.enableprediction:SetPoint("TOPLEFT", optgen.enablecctimers, "TOPLEFT", 0, -25)

optgen.enabletimers = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletimers", optgen, L.enabletimers)
optgen.enabletimers:SetPoint("TOPLEFT", optgen.enableprediction, "TOPLEFT", 0, -25)

optgen.timerfontposition = JSHB.options.CreateDropdown(optgen, "JSHB_dropdown_timerfontposition", L.timerfontposition, function()

	JSHB.options.info = {}
	local i
	for i=1,#JSHB.timerfontpositions do
		JSHB.options.info.text = JSHB.timerfontpositions[i][1]
		JSHB.options.info.value = JSHB.timerfontpositions[i][2]
		JSHB.options.info.func = function(self) optgen.timerfontposition:SetValue(self.value, self.text) end
		JSHB.options.info.checked = false
		UIDropDownMenu_AddButton(JSHB.options.info)
	end
end)
optgen.timerfontposition:SetPoint("TOPLEFT", optgen.enabletimers, "TOPLEFT", 25, -25)
optgen.timerfontposition:SetPoint("TOPRIGHT", optgen.enabletimers, "TOPLEFT", 160, -45)

optgen.enabletimerstext = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletimerstext", optgen, L.enabletimerstext)
optgen.enabletimerstext:SetPoint("TOPLEFT", optgen.timerfontposition, "TOPLEFT", -25, -50)

optgen.enabletimertenths = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletimertenths", optgen, L.enabletimertenths)
optgen.enabletimertenths:SetPoint("TOPLEFT", optgen.enabletimerstext, "TOPLEFT", 10, -25)

optgen.enabledebuffalert = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabledebuffalert", optgen, L.enabledebuffalert)
optgen.enabledebuffalert:SetPoint("TOPLEFT", optgen.enabletimertenths, "TOPLEFT", -10, -25)

optgen.enabletargethealthpercent = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletargethealthpercent", optgen, L.enabletargethealthpercent)
optgen.enabletargethealthpercent:SetPoint("TOPLEFT", optgen.enabledebuffalert, "TOPLEFT", 0, -25)

optgen.timericonanchorparent = JSHB.options.CreateDropdown(optgen, "JSHB_dropdown_timericonanchorparent", L.timericonanchorparent, function()

	JSHB.options.info = {}
	local i
	for i=1,#JSHB.timericonanchors do
		JSHB.options.info.text = JSHB.timericonanchors[i][1]
		JSHB.options.info.value = JSHB.timericonanchors[i][2]
		JSHB.options.info.func = function(self) optgen.timericonanchorparent:SetValue(self.value, self.text) end
		JSHB.options.info.checked = false
		UIDropDownMenu_AddButton(JSHB.options.info)
	end
end)
optgen.timericonanchorparent:SetPoint("TOPLEFT", optgen.enabletargethealthpercent, "TOPLEFT", 25, -25)
optgen.timericonanchorparent:SetPoint("TOPRIGHT", optgen.enabletargethealthpercent, "TOPLEFT", 160, -45)

optgen.timertextcoloredbytime = 
	JSHB.options.CreateCheckButton("JSHB_Options_timertextcoloredbytime", optgen, L.timertextcoloredbytime)
optgen.timertextcoloredbytime:SetPoint("TOPLEFT", optgen.timericonanchorparent, "TOPLEFT", -25, -50)

optgen.enablecurrentfocustext = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablecurrentfocustext", optgen, L.enablecurrentfocustext)
optgen.enablecurrentfocustext:SetPoint("TOPLEFT", optgen.timertextcoloredbytime, "TOPLEFT", 0, -25)

optgen.enabletranqablesframe = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletranqablesframe", optgen, L.enabletranqablesframe)
optgen.enabletranqablesframe:SetPoint("TOPLEFT", optgen.enablecurrentfocustext, "TOPLEFT", 0, -25)

optgen.enabletranqablestips = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletranqablestips", optgen, L.enabletranqablestips)
optgen.enabletranqablestips:SetPoint("TOPLEFT", optgen.enabletranqablesframe, "TOPLEFT", 10, -25)

JSHB.options.genscrollframe:SetScrollChild(optgen)


-- Create Style & Size options panel
JSHB.options.stylesizescrollframeparent = CreateFrame("Frame", "JSHB.optionsStyleSizeScrollFrameParent", JSHB.options)
JSHB.options.stylesizescrollframeparent.name = L.namestylesize
JSHB.options.stylesizescrollframeparent.parent = JSHB.options.name

JSHB.options.stylesizescrollframe = CreateFrame("ScrollFrame", "JSHB.optionsStyleSizeScrollFrame",
	JSHB.options.stylesizescrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.stylesizescrollframe:SetPoint("TOPLEFT", JSHB.options.stylesizescrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.stylesizescrollframe:SetPoint("BOTTOMLEFT", JSHB.options.stylesizescrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.stylesizescrollframe:SetPoint("RIGHT", JSHB.options.stylesizescrollframeparent, "RIGHT", -28, 0)
JSHB.options.stylesizescrollframe:SetFrameLevel(JSHB.options.stylesizescrollframeparent:GetFrameLevel())

JSHB.options.stylesize = CreateFrame("Frame", "JSHB.optionsStyleSize", JSHB.options.stylesizescrollframe)
JSHB.options.stylesize:SetWidth(350)
JSHB.options.stylesize:SetHeight(450)

local optcs = JSHB.options.stylesize

optcs.classcolored = 
	JSHB.options.CreateCheckButton("JSHB_Options_classcolored", optcs, L.classcolored)
optcs.classcolored:SetPoint("TOPLEFT", 10, -12)

optcs.classcoloredprediction = 
	JSHB.options.CreateCheckButton("JSHB_Options_classcoloredprediction", optcs, L.classcoloredprediction)
optcs.classcoloredprediction:SetPoint("TOPLEFT", optcs.classcolored, "TOPLEFT", 0, -32)

optcs.enabletukui = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletukui", optcs, L.enabletukui)
optcs.enabletukui:SetPoint("TOPLEFT", optcs.classcoloredprediction, "TOPLEFT", 0, -29)

optcs.enabletukuitimers = 
	JSHB.options.CreateCheckButton("JSHB_Options_enabletukuitimers", optcs, L.enabletukuitimers)
optcs.enabletukuitimers:SetPoint("TOPLEFT", optcs.enabletukui, "TOPLEFT", 10, -30)

optcs.enablehighcolorwarning = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablehighcolorwarning", optcs, L.enablehighcolorwarning)
optcs.enablehighcolorwarning:SetPoint("TOPLEFT", optcs.enabletukuitimers, "TOPLEFT", -10, -30)

optcs.focushighthreshold =
	JSHB.options.CreateSlider("JSHB_Options_focushighthreshold", optcs, L.focushighthreshold, 50, 90, 1, 340, 15)
optcs.focushighthreshold:SetPoint("TOPLEFT", optcs.enablehighcolorwarning, "TOPLEFT", 10, -55)

optcs.focuscenteroffset =
	JSHB.options.CreateSlider("JSHB_Options_focuscenteroffset", optcs, L.focuscenteroffset, -200, 200, 1, 340, 15)
optcs.focuscenteroffset:SetPoint("TOPLEFT", optcs.focushighthreshold, "TOPLEFT", 0, -45)

optcs.barwidth =
	JSHB.options.CreateSlider("JSHB_Options_barwidth", optcs, L.barwidth, 50, 400, 1, 340, 15)
optcs.barwidth:SetPoint("TOPLEFT", optcs.focuscenteroffset, "TOPLEFT", 0, -45)

optcs.barheight =
	JSHB.options.CreateSlider("JSHB_Options_barheight", optcs, L.barheight, 8, 200, 1, 340, 15)
optcs.barheight:SetPoint("TOPLEFT", optcs.barwidth, "TOPLEFT", 0, -45)

optcs.iconsize =
	JSHB.options.CreateSlider("JSHB_Options_iconsize", optcs, L.iconsize, 8, 50, 1, 340, 15)
optcs.iconsize:SetPoint("TOPLEFT", optcs.barheight, "TOPLEFT", 0, -45)

optcs.cciconsize =
	JSHB.options.CreateSlider("JSHB_Options_cciconsize", optcs, L.cciconsize, 8, 50, 1, 340, 15)
optcs.cciconsize:SetPoint("TOPLEFT", optcs.iconsize, "TOPLEFT", 0, -45)

optcs.markiconsize =
	JSHB.options.CreateSlider("JSHB_Options_markiconsize", optcs, L.markiconsize, 8, 50, 1, 340, 15)
optcs.markiconsize:SetPoint("TOPLEFT", optcs.cciconsize, "TOPLEFT", 0, -45)

optcs.taiconsize =
	JSHB.options.CreateSlider("JSHB_Options_taiconsize", optcs, L.taiconsize, 8, 50, 1, 340, 15)
optcs.taiconsize:SetPoint("TOPLEFT", optcs.markiconsize, "TOPLEFT", 0, -45)

optcs.tranqablesiconsize =
	JSHB.options.CreateSlider("JSHB_Options_tranqablesiconsize", optcs, L.tranqablesiconsize, 8, 50, 1, 340, 15)
optcs.tranqablesiconsize:SetPoint("TOPLEFT", optcs.taiconsize, "TOPLEFT", 0, -45)

optcs.icontimerssize =
	JSHB.options.CreateSlider("JSHB_Options_icontimerssize", optcs, L.icontimerssize, 8, 40, 1, 340, 15)
optcs.icontimerssize:SetPoint("TOPLEFT", optcs.tranqablesiconsize, "TOPLEFT", 0, -45)

optcs.icontimersgap =
	JSHB.options.CreateSlider("JSHB_Options_icontimersgap", optcs, L.icontimersgap, 2, 400, 1, 340, 15)
optcs.icontimersgap:SetPoint("TOPLEFT", optcs.icontimerssize, "TOPLEFT", 0, -45)

optcs.debufficonsize =
	JSHB.options.CreateSlider("JSHB_Options_debufficonsize", optcs, L.debufficonsize, 8, 60, 1, 340, 15)
optcs.debufficonsize:SetPoint("TOPLEFT", optcs.icontimersgap, "TOPLEFT", 0, -45)

optcs.alphabackdrop =
	JSHB.options.CreateSlider("JSHB_Options_alphabackdrop", optcs, L.alphabackdrop, 0, 100, 5, 340, 15)
optcs.alphabackdrop:SetPoint("TOPLEFT", optcs.debufficonsize, "TOPLEFT", 0, -45)

optcs.alphazeroooc =
	JSHB.options.CreateSlider("JSHB_Options_alphazeroooc", optcs, L.alphazeroooc, 0, 100, 5, 340, 15)
optcs.alphazeroooc:SetPoint("TOPLEFT", optcs.alphabackdrop, "TOPLEFT", 0, -45)

optcs.alphamaxooc =
	JSHB.options.CreateSlider("JSHB_Options_alphamaxooc", optcs, L.alphamaxooc, 0, 100, 5, 340, 15)
optcs.alphamaxooc:SetPoint("TOPLEFT", optcs.alphazeroooc, "TOPLEFT", 0, -45)

optcs.alphanormooc =
	JSHB.options.CreateSlider("JSHB_Options_alphanormooc", optcs, L.alphanormooc, 0, 100, 5, 340, 15)
optcs.alphanormooc:SetPoint("TOPLEFT", optcs.alphamaxooc, "TOPLEFT", 0, -45)

optcs.alphazero =
	JSHB.options.CreateSlider("JSHB_Options_alphazero", optcs, L.alphazero, 0, 100, 5, 340, 15)
optcs.alphazero:SetPoint("TOPLEFT", optcs.alphanormooc, "TOPLEFT", 0, -45)

optcs.alphamax =
	JSHB.options.CreateSlider("JSHB_Options_alphamax", optcs, L.alphamax, 0, 100, 5, 340, 15)
optcs.alphamax:SetPoint("TOPLEFT", optcs.alphazero, "TOPLEFT", 0, -45)

optcs.alphanorm =
	JSHB.options.CreateSlider("JSHB_Options_alphanorm", optcs, L.alphanorm, 0, 100, 5, 340, 15)
optcs.alphanorm:SetPoint("TOPLEFT", optcs.alphamax, "TOPLEFT", 0, -45)

optcs.alphaicontimersfaded =
	JSHB.options.CreateSlider("JSHB_Options_alphaicontimersfaded", optcs, L.alphaicontimersfaded, 0, 100, 5, 340, 15)
optcs.alphaicontimersfaded:SetPoint("TOPLEFT", optcs.alphanorm, "TOPLEFT", 0, -45)

JSHB.options.stylesizescrollframe:SetScrollChild(optcs)


-- Create Fonts & Textures options panel
JSHB.options.fontstextures = CreateFrame( "Frame", "JSHB.optionsFontsTextures", JSHB.options)
JSHB.options.fontstextures.name = L.namefontstextures
JSHB.options.fontstextures.parent = JSHB.options.name

local optft = JSHB.options.fontstextures

JSHB.options.info = {}
local i
for i=1,#JSHB.fonts do	
	JSHB.options.info[i] = { JSHB.fonts[i].text, JSHB.fonts[i].font }
end
i = nil
--optft.barfont = JSHB.options.CreateScrollingDropdown(optft, "JSHB_scrollingdropdown_barfont", L.barfont, JSHB.fnts)
optft.barfont = JSHB.options.CreateScrollingDropdown(optft, "JSHB_scrollingdropdown_barfont", L.barfont, JSHB.options.info)
optft.barfont:SetPoint("TOPLEFT", 15, -12)
optft.barfont:SetValue("Arial")
local button_OnClick = optft.barfont.button:GetScript("OnClick")
optft.barfont.button:SetScript("OnClick", function(self)
	button_OnClick(self)
	optft.barfont.dropdown.list:Hide()

	local function SetButtonFonts(self)
		local buttons = optft.barfont.dropdown.list.buttons
		local i
		for i = 1, #buttons do
			local button = buttons[i]
			if button.value and button:IsShown() then
				button.label:SetFont(JSHB.getFont(button.value),
					UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
			end
		end
	end

	local OnShow = optft.barfont.dropdown.list:GetScript("OnShow")
	optft.barfont.dropdown.list:SetScript("OnShow", function(self)
		OnShow(self)
		SetButtonFonts(self)
	end)

	local OnVerticalScroll = optft.barfont.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
	optft.barfont.dropdown.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
		OnVerticalScroll(self, delta)
		SetButtonFonts(self)
	end)

	local SetText = optft.barfont.dropdown.list.text.SetText
	optft.barfont.dropdown.list.text.SetText = function(self, text)
		self:SetFont(JSHB.getFont(text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
		SetText(self, text)
	end

	button_OnClick(self)
	self:SetScript("OnClick", button_OnClick)
end)

JSHB.options.info = {}
local i
for i=1,#JSHB.fonts do	
	JSHB.options.info[i] = { JSHB.fonts[i].text, JSHB.fonts[i].font }
end
i = nil
optft.timerfont = JSHB.options.CreateScrollingDropdown(optft, "JSHB_scrollingdropdown_timerfont", L.timerfont, JSHB.options.info)
optft.timerfont:SetPoint("TOPLEFT", optft.barfont, "TOPLEFT", 0, -55)
optft.timerfont:SetValue("Arial")
local button_OnClick = optft.timerfont.button:GetScript("OnClick")
optft.timerfont.button:SetScript("OnClick", function(self)
	button_OnClick(self)
	optft.timerfont.dropdown.list:Hide()

	local function SetButtonFonts(self)
		local buttons = optft.timerfont.dropdown.list.buttons
		local i
		for i = 1, #buttons do
			local button = buttons[i]
			if button.value and button:IsShown() then
				button.label:SetFont(JSHB.getFont(button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
			end
		end
	end

	local OnShow = optft.timerfont.dropdown.list:GetScript("OnShow")
	optft.timerfont.dropdown.list:SetScript("OnShow", function(self)
		OnShow(self)
		SetButtonFonts(self)
	end)

	local OnVerticalScroll = optft.timerfont.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
	optft.timerfont.dropdown.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
		OnVerticalScroll(self, delta)
		SetButtonFonts(self)
	end)

	local SetText = optft.timerfont.dropdown.list.text.SetText
	optft.timerfont.dropdown.list.text.SetText = function(self, text)
		self:SetFont(JSHB.getFont(text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
		SetText(self, text)
	end

	button_OnClick(self)
	self:SetScript("OnClick", button_OnClick)
end)

JSHB.options.info = {}
local i
for i=1,#JSHB.textures do	
	JSHB.options.info[i] = { JSHB.textures[i].text, JSHB.textures[i].texture }
end
i = nil
optft.bartexture = JSHB.options.CreateScrollingDropdown(optft, "JSHB_scrollingdropdown_bartexture", L.bartexture, JSHB.options.info)
optft.bartexture:SetPoint("TOPLEFT", optft.timerfont, "TOPLEFT", 0, -55)
optft.bartexture:SetValue("Blizzard")
local button_OnClick = optft.bartexture.button:GetScript("OnClick")
optft.bartexture.button:SetScript("OnClick", function(self)

	button_OnClick(self)
	optft.bartexture.dropdown.list:Hide()

	local function SetButtonTextures(self)

		local buttons = optft.bartexture.dropdown.list.buttons
		local i
		for i = 1, #buttons do
			local button = buttons[i]
			if button.value and button:IsShown() then
				local normal = button:CreateTexture(nil, "BACKGROUND")
				normal:SetAllPoints(button)
				normal:SetTexture(JSHB.getTexture(button.value))
				normal:SetAlpha(0.4)
				normal:SetBlendMode("ADD")
				normal:Hide()
				button:SetNormalTexture(normal)
			end
		end
	end

	local OnShow = optft.bartexture.dropdown.list:GetScript("OnShow")
	optft.bartexture.dropdown.list:SetScript("OnShow", function(self)
		OnShow(self)
		SetButtonTextures(self)
	end)

	local OnVerticalScroll = optft.bartexture.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
	optft.bartexture.dropdown.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
		OnVerticalScroll(self, delta)
		SetButtonTextures(self)
	end)

	local SetText = optft.bartexture.dropdown.list.text.SetText
	optft.bartexture.dropdown.list.text.SetText = function(self, text) SetText(self, text) end

	button_OnClick(self)
	self:SetScript("OnClick", button_OnClick)
end)

optft.fontoutlined = 
	JSHB.options.CreateCheckButton("JSHB_Options_fontoutlined", optft, L.fontoutlined)
optft.fontoutlined:SetPoint("TOPLEFT", optft.bartexture, "TOPLEFT", 0, -55)

optft.fontsize =
	JSHB.options.CreateSlider("JSHB_Options_fontsize", optft, L.fontsize, 8, 30, 1, 340, 15)
optft.fontsize:SetPoint("TOPLEFT", optft.fontoutlined, "TOPLEFT", 5, -45)

optft.fontsizetimers =
	JSHB.options.CreateSlider("JSHB_Options_fontsizetimers", optft, L.fontsizetimers, 8, 30, 1, 340, 15)
optft.fontsizetimers:SetPoint("TOPLEFT", optft.fontsize, "TOPLEFT", 0, -45)


-- Create Colors options panel
JSHB.options.colors = CreateFrame( "Frame", "JSHB.optionsColors", JSHB.options)
local optc = JSHB.options.colors
optc.name = L.namecolors
optc.parent = JSHB.options.name

optc.barcolor =
	JSHB.options.CreateColorSelector("JSHB_Options_barcolor", optc, L.barcolor, 80)
optc.barcolor:SetPoint("TOPLEFT", 40, -50)

optc.barcolorwarninglow =
	JSHB.options.CreateColorSelector("JSHB_Options_barcolorwarninglow", optc, L.barcolorwarninglow, 80)
optc.barcolorwarninglow:SetPoint("LEFT", optc.barcolor, "RIGHT", 50, 0)

optc.barcolorwarninghigh =
	JSHB.options.CreateColorSelector("JSHB_Options_barcolorwarninghigh", optc, L.barcolorwarninghigh, 80)
optc.barcolorwarninghigh:SetPoint("LEFT", optc.barcolorwarninglow, "RIGHT", 50, 0)

optc.autoshotbarcolor =
	JSHB.options.CreateColorSelector("JSHB_Options_autoshotbarcolor", optc, L.autoshotbarcolor, 80)
optc.autoshotbarcolor:SetPoint("TOPLEFT", optc.barcolor, "TOPLEFT", 0, -140)

optc.predictionbarcolor =
	JSHB.options.CreateColorSelector("JSHB_Options_predictionbarcolor", optc, L.predictionbarcolor, 80)
optc.predictionbarcolor:SetPoint("LEFT", optc.autoshotbarcolor, "RIGHT", 50, 0)

optc.predictionbarcolorwarninghigh =
	JSHB.options.CreateColorSelector("JSHB_Options_predictionbarcolorwarninghigh", optc, L.predictionbarcolorwarninghigh, 80)
optc.predictionbarcolorwarninghigh:SetPoint("LEFT", optc.predictionbarcolor, "RIGHT", 50, 0)


-- Create indicator options panel
JSHB.options.indicatorscrollframeparent = CreateFrame("Frame", "JSHB.optionsIndicatorScrollFrameParent", JSHB.options)
JSHB.options.indicatorscrollframeparent.name = L.nameindicator
JSHB.options.indicatorscrollframeparent.parent = JSHB.options.name

JSHB.options.indicatorscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsIndicatorScrollFrame", JSHB.options.indicatorscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.indicatorscrollframe:SetPoint("TOPLEFT", JSHB.options.indicatorscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.indicatorscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.indicatorscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.indicatorscrollframe:SetPoint("RIGHT", JSHB.options.indicatorscrollframeparent, "RIGHT", -28, 0)
JSHB.options.indicatorscrollframe:SetFrameLevel(JSHB.options.indicatorscrollframeparent:GetFrameLevel())

JSHB.options.indicator = CreateFrame("Frame", "JSHB.optionsIndicator", JSHB.options.indicatorscrollframe)
JSHB.options.indicator:SetWidth(350)
JSHB.options.indicator:SetHeight(450)

local optind = JSHB.options.indicator

optind.enableindicator = 
	JSHB.options.CreateCheckButton("JSHB_Options_enableindicator", optind, L.enableindicator)
optind.enableindicator:SetPoint("TOPLEFT", 10, -10)

optind.indicatoriconsize =
	JSHB.options.CreateSlider("JSHB_Options_indicatoriconsize", optind, L.indicatoriconsize, 8, 50, 1, 340, 15)
optind.indicatoriconsize:SetPoint("TOPLEFT", optind.enableindicator, "TOPLEFT", 10, -45)

JSHB.options.indicatorscrollframe:SetScrollChild(optind)


-- Create BM options panel
JSHB.options.bmscrollframeparent = CreateFrame("Frame", "JSHB.optionsBMScrollFrameParent", JSHB.options)
JSHB.options.bmscrollframeparent.name = L.namebm
JSHB.options.bmscrollframeparent.parent = JSHB.options.name

JSHB.options.bmscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsBMScrollFrame", JSHB.options.bmscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.bmscrollframe:SetPoint("TOPLEFT", JSHB.options.bmscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.bmscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.bmscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.bmscrollframe:SetPoint("RIGHT", JSHB.options.bmscrollframeparent, "RIGHT", -28, 0)
JSHB.options.bmscrollframe:SetFrameLevel(JSHB.options.bmscrollframeparent:GetFrameLevel())

JSHB.options.bm = CreateFrame("Frame", "JSHB.optionsBM", JSHB.options.bmscrollframe)
JSHB.options.bm:SetWidth(350)
JSHB.options.bm:SetHeight(450)

local optbm = JSHB.options.bm

optbm.button1 = JSHB.options.CreateButton(optbm, "JSHB_Options_BMButton1", L.buttonaddtimer, 70, 24)
optbm.button1:SetPoint("TOPLEFT", 14, -10)
optbm.button1:SetScript("OnClick", function() JSHB.options.AddTimer("bm", JSHB.options.bm) end)

optbm.text1 = optbm:CreateFontString("JSHB_Options_BMText1", "ARTWORK", optbm)
optbm.text1:SetFontObject(GameFontNormal)	
optbm.text1:SetJustifyH("LEFT")
optbm.text1:SetWidth(360)
optbm.text1:SetPoint("TOPLEFT", optbm.button1, "TOPLEFT", 0, -35)

JSHB.options.bmscrollframe:SetScrollChild(optbm)


-- Create MM options panel
JSHB.options.mmscrollframeparent = CreateFrame("Frame", "JSHB.optionsMMScrollFrameParent", JSHB.options)
JSHB.options.mmscrollframeparent.name = L.namemm
JSHB.options.mmscrollframeparent.parent = JSHB.options.name

JSHB.options.mmscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsMMScrollFrame", JSHB.options.mmscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.mmscrollframe:SetPoint("TOPLEFT", JSHB.options.mmscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.mmscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.mmscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.mmscrollframe:SetPoint("RIGHT", JSHB.options.mmscrollframeparent, "RIGHT", -28, 0)
JSHB.options.mmscrollframe:SetFrameLevel(JSHB.options.mmscrollframeparent:GetFrameLevel())

JSHB.options.mm = CreateFrame("Frame", "JSHB.optionsMM", JSHB.options.mmscrollframe)
JSHB.options.mm:SetWidth(350)
JSHB.options.mm:SetHeight(450)

local optmm = JSHB.options.mm

optmm.button1 = JSHB.options.CreateButton(optmm, "JSHB_Options_MMButton1", L.buttonaddtimer, 70, 24)
optmm.button1:SetPoint("TOPLEFT", 14, -10)
optmm.button1:SetScript("OnClick", function() JSHB.options.AddTimer("mm", JSHB.options.mm) end)

optmm.text1 = optmm:CreateFontString("JSHB_Options_MMText1", "ARTWORK", optmm)
optmm.text1:SetFontObject(GameFontNormal)	
optmm.text1:SetJustifyH("LEFT")
optmm.text1:SetWidth(360)
optmm.text1:SetPoint("TOPLEFT", optmm.button1, "TOPLEFT", 0, -35)

JSHB.options.mmscrollframe:SetScrollChild(optmm)


-- Create SV options panel
JSHB.options.svscrollframeparent = CreateFrame("Frame", "JSHB.optionsSVScrollFrameParent", JSHB.options)
JSHB.options.svscrollframeparent.name = L.namesv
JSHB.options.svscrollframeparent.parent = JSHB.options.name

JSHB.options.svscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsSVScrollFrame", JSHB.options.svscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.svscrollframe:SetPoint("TOPLEFT", JSHB.options.svscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.svscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.svscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.svscrollframe:SetPoint("RIGHT", JSHB.options.svscrollframeparent, "RIGHT", -28, 0)
JSHB.options.svscrollframe:SetFrameLevel(JSHB.options.svscrollframeparent:GetFrameLevel())

JSHB.options.sv = CreateFrame("Frame", "JSHB.optionsSV", JSHB.options.svscrollframe)
JSHB.options.sv:SetWidth(350)
JSHB.options.sv:SetHeight(450)

local optsv = JSHB.options.sv

optsv.button1 = JSHB.options.CreateButton(optsv, "JSHB_Options_SVButton1", L.buttonaddtimer, 70, 24)
optsv.button1:SetPoint("TOPLEFT", 14, -10)
optsv.button1:SetScript("OnClick", function() JSHB.options.AddTimer("sv", JSHB.options.sv) end)

optsv.text1 = optsv:CreateFontString("JSHB_Options_SVText1", "ARTWORK", optsv)
optsv.text1:SetFontObject(GameFontNormal)	
optsv.text1:SetJustifyH("LEFT")
optsv.text1:SetWidth(360)
optsv.text1:SetPoint("TOPLEFT", optsv.button1, "TOPLEFT", 0, -35)

JSHB.options.svscrollframe:SetScrollChild(optsv)


-- Create Misdirection options panel
JSHB.options.mdscrollframeparent = CreateFrame("Frame", "JSHB.optionsMisdirectionScrollFrameParent", JSHB.options)
JSHB.options.mdscrollframeparent.name = L.namemd
JSHB.options.mdscrollframeparent.parent = JSHB.options.name

JSHB.options.mdscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsMisdirectionScrollFrame",
	JSHB.options.mdscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.mdscrollframe:SetPoint("TOPLEFT", JSHB.options.mdscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.mdscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.mdscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.mdscrollframe:SetPoint("RIGHT", JSHB.options.mdscrollframeparent, "RIGHT", -28, 0)
JSHB.options.mdscrollframe:SetFrameLevel(JSHB.options.mdscrollframeparent:GetFrameLevel())

JSHB.options.md = CreateFrame("Frame", "JSHB.optionsMisdirection", JSHB.options.mdscrollframe)
JSHB.options.md:SetWidth(350)
JSHB.options.md:SetHeight(450)

local optmd = JSHB.options.md

optmd.mdoptiontext1 = optmd:CreateFontString("JSHB_Options_mdoptiontext1", "ARTWORK")
optmd.mdoptiontext1:SetFontObject(GameFontNormal)
optmd.mdoptiontext1:SetText(L.mdoptiontext1)
optmd.mdoptiontext1:SetJustifyH("LEFT")
optmd.mdoptiontext1:SetWidth(360)
optmd.mdoptiontext1:SetPoint("TOPLEFT", 10, -12)

optmd.enablerightclickmd = 
	JSHB.options.CreateCheckButton("JSHB_Options_enablerightclickmd", optmd, L.enablerightclickmd)
optmd.enablerightclickmd:SetPoint("TOPLEFT", 10, -80)

optmd.enablemdonpet =
	JSHB.options.CreateCheckButton("JSHB_Options_enablemdonpet", optmd, L.enablemdonpet)
optmd.enablemdonpet:SetPoint("TOPLEFT", optmd.enablerightclickmd, "TOPLEFT", 10, -25)

optmd.enablemdonparty =
	JSHB.options.CreateCheckButton("JSHB_Options_enablemdonparty", optmd, L.enablemdonparty)
optmd.enablemdonparty:SetPoint("TOPLEFT", optmd.enablemdonpet, "TOPLEFT", 0, -25)

optmd.enablemdonraid =
	JSHB.options.CreateCheckButton("JSHB_Options_enablemdonraid", optmd, L.enablemdonraid)
optmd.enablemdonraid:SetPoint("TOPLEFT", optmd.enablemdonparty, "TOPLEFT", 0, -25)

optmd.enablemdcastannounce =
	JSHB.options.CreateCheckButton("JSHB_Options_enablemdcastannounce", optmd, L.enablemdcastannounce)
optmd.enablemdcastannounce:SetPoint("TOPLEFT", optmd.enablemdonraid, "TOPLEFT", -10, -30)
		
optmd.enablemdoverannounce =
	JSHB.options.CreateCheckButton("JSHB_Options_enablemdoverannounce", optmd, L.enablemdoverannounce)
optmd.enablemdoverannounce:SetPoint("TOPLEFT", optmd.enablemdcastannounce, "TOPLEFT", 0, -25)

optmd.enablemdtargetwhisper =
	JSHB.options.CreateCheckButton("JSHB_Options_enablemdtargetwhisper", optmd, L.enablemdtargetwhisper)
optmd.enablemdtargetwhisper:SetPoint("TOPLEFT", optmd.enablemdoverannounce, "TOPLEFT", 0, -25)

optmd.mdannouncechannel = JSHB.options.CreateDropdown(optmd, "JSHB_dropdown_mdannouncechannel", L.mdannouncechannel, function()
	JSHB.options.info = {}
	local i
	for i=1,#JSHB.chatchannels do
		JSHB.options.info.text = JSHB.chatchannels[i][1]
		JSHB.options.info.value = JSHB.chatchannels[i][2] or 1
		JSHB.options.info.func = function(self) optmd.mdannouncechannel:SetValue(self.value, self.text) end
		JSHB.options.info.checked = false
		UIDropDownMenu_AddButton(JSHB.options.info)
	end
end)
optmd.mdannouncechannel:SetPoint("TOPLEFT", optmd.enablemdtargetwhisper, "TOPLEFT", 25, -25)
optmd.mdannouncechannel:SetPoint("TOPRIGHT", optmd.enablemdtargetwhisper, "TOPLEFT", 160, -45)

JSHB.options.mdscrollframe:SetScrollChild(optmd)

-- Create Custom Spell options panel
JSHB.options.customspellscrollframeparent = CreateFrame("Frame", "JSHB.optionsCustomSpellScrollFrameParent", JSHB.options)
JSHB.options.customspellscrollframeparent.name = L.namecustomspell
JSHB.options.customspellscrollframeparent.parent = JSHB.options.name

JSHB.options.customspellscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsCustomSpellScrollFrame",
	JSHB.options.customspellscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.customspellscrollframe:SetPoint("TOPLEFT", JSHB.options.customspellscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.customspellscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.customspellscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.customspellscrollframe:SetPoint("RIGHT", JSHB.options.customspellscrollframeparent, "RIGHT", -28, 0)
JSHB.options.customspellscrollframe:SetFrameLevel(JSHB.options.customspellscrollframeparent:GetFrameLevel())

JSHB.options.customspell = CreateFrame("Frame", "JSHB.optionsCustomSpell", JSHB.options.customspellscrollframe)
JSHB.options.customspell:SetWidth(350)
JSHB.options.customspell:SetHeight(450)

local optcsp = JSHB.options.customspell

optcsp.button1 = JSHB.options.CreateButton(optcsp, "JSHB_Options_CustomSpellButton1", L.buttonaddspell, 70, 24)
optcsp.button1:SetPoint("TOPLEFT", 14, -10)
optcsp.button1:SetScript("OnClick", function() JSHB.options.AddCustomSpell("customspell", JSHB.options.customspell) end)

optcsp.text1 = optcsp:CreateFontString("JSHB_Options_CustomSpellText1", "ARTWORK", optcsp)
optcsp.text1:SetFontObject(GameFontNormal)	
optcsp.text1:SetJustifyH("LEFT")
optcsp.text1:SetWidth(360)
optcsp.text1:SetPoint("TOPLEFT", optcsp.button1, "TOPLEFT", 0, -35)

JSHB.options.customspellscrollframe:SetScrollChild(optcsp)

-- Create Custom Tranq options panel
JSHB.options.customtranqscrollframeparent = CreateFrame("Frame", "JSHB.optionsCustomTranqScrollFrameParent", JSHB.options)
JSHB.options.customtranqscrollframeparent.name = L.namecustomtranq
JSHB.options.customtranqscrollframeparent.parent = JSHB.options.name

JSHB.options.customtranqscrollframe = CreateFrame("ScrollFrame", "JSHB.optionsCustomTranqScrollFrame",
	JSHB.options.customtranqscrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.customtranqscrollframe:SetPoint("TOPLEFT", JSHB.options.customtranqscrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.customtranqscrollframe:SetPoint("BOTTOMLEFT", JSHB.options.customtranqscrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.customtranqscrollframe:SetPoint("RIGHT", JSHB.options.customtranqscrollframeparent, "RIGHT", -28, 0)
JSHB.options.customtranqscrollframe:SetFrameLevel(JSHB.options.customtranqscrollframeparent:GetFrameLevel())

JSHB.options.customtranq = CreateFrame("Frame", "JSHB.optionsCustomTranq", JSHB.options.customtranqscrollframe)
JSHB.options.customtranq:SetWidth(350)
JSHB.options.customtranq:SetHeight(450)

local optctr = JSHB.options.customtranq

optctr.button1 = JSHB.options.CreateButton(optctr, "JSHB_Options_CustomTranqButton1", L.buttonaddspell, 70, 24)
optctr.button1:SetPoint("TOPLEFT", 14, -10)
optctr.button1:SetScript("OnClick", function() JSHB.options.AddCustomSpell("customtranq", JSHB.options.customtranq) end)

optctr.text1 = optctr:CreateFontString("JSHB_Options_CustomTranqText1", "ARTWORK", optctr)
optctr.text1:SetFontObject(GameFontNormal)	
optctr.text1:SetJustifyH("LEFT")
optctr.text1:SetWidth(360)
optctr.text1:SetPoint("TOPLEFT", optctr.button1, "TOPLEFT", 0, -35)

JSHB.options.customtranqscrollframe:SetScrollChild(optctr)

-- Create Custom Aura options panel
JSHB.options.customaurascrollframeparent = CreateFrame("Frame", "JSHB.optionsCustomAuraScrollFrameParent", JSHB.options)
JSHB.options.customaurascrollframeparent.name = L.namecustomaura
JSHB.options.customaurascrollframeparent.parent = JSHB.options.name

JSHB.options.customaurascrollframe = CreateFrame("ScrollFrame", "JSHB.optionsCustomAuraScrollFrame",
	JSHB.options.customaurascrollframeparent, "UIPanelScrollFrameTemplate")
JSHB.options.customaurascrollframe:SetPoint("TOPLEFT", JSHB.options.customaurascrollframeparent, "TOPLEFT", 0, -8)
JSHB.options.customaurascrollframe:SetPoint("BOTTOMLEFT", JSHB.options.customaurascrollframeparent, "BOTTOMLEFT", 0, 8)
JSHB.options.customaurascrollframe:SetPoint("RIGHT", JSHB.options.customaurascrollframeparent, "RIGHT", -28, 0)
JSHB.options.customaurascrollframe:SetFrameLevel(JSHB.options.customaurascrollframeparent:GetFrameLevel())

JSHB.options.customaura = CreateFrame("Frame", "JSHB.optionsCustomAura", JSHB.options.customaurascrollframe)
JSHB.options.customaura:SetWidth(350)
JSHB.options.customaura:SetHeight(450)

local optcau = JSHB.options.customaura

optcau.button1 = JSHB.options.CreateButton(optcau, "JSHB_Options_CustomAuraButton1", L.buttonaddspell, 70, 24)
optcau.button1:SetPoint("TOPLEFT", 14, -10)
optcau.button1:SetScript("OnClick", function() JSHB.options.AddCustomSpell("customaura", JSHB.options.customaura) end)

optcau.text1 = optcau:CreateFontString("JSHB_Options_CustomAuraText1", "ARTWORK", optcau)
optcau.text1:SetFontObject(GameFontNormal)	
optcau.text1:SetJustifyH("LEFT")
optcau.text1:SetWidth(360)
optcau.text1:SetPoint("TOPLEFT", optcau.button1, "TOPLEFT", 0, -35)

JSHB.options.customaurascrollframe:SetScrollChild(optcau)


JSHB.updateSettings = function()

	-- Default pane
	if checkNotEqual(JSHB.barLocked, JSHB.options.enablebarlock:GetChecked()) then
		JSHB.barLocked = not JSHB.barLocked
		mF:ApplyLock()
	end

	-- General pane
	DB.enablestackbars = JSHB.options.general.enablestackbars:GetChecked() and true or false
	DB.movestackbarstotop = JSHB.options.general.movestackbarstotop:GetChecked() and true or false
	DB.enableautoshotbar = JSHB.options.general.enableautoshotbar:GetChecked() and true or false
	DB.enableautoshottext = JSHB.options.general.enableautoshottext:GetChecked() and true or false
	DB.enablemaintick = JSHB.options.general.enablemaintick:GetChecked() and true or false
	DB.enablehuntersmarkwarning = JSHB.options.general.enablehuntersmarkwarning:GetChecked() and true or false
	DB.enablecctimers = JSHB.options.general.enablecctimers:GetChecked() and true or false
	DB.enableprediction = JSHB.options.general.enableprediction:GetChecked() and true or false
	DB.enabletimers = JSHB.options.general.enabletimers:GetChecked() and true or false
	DB.timerfontposition = UIDropDownMenu_GetSelectedValue(JSHB.options.general.timerfontposition.dropdown)
	DB.enabletimerstext = JSHB.options.general.enabletimerstext:GetChecked() and true or false
	DB.enabletranqannounce = JSHB.options.general.enabletranqannounce:GetChecked() and true or false
	DB.tranqannouncechannel = UIDropDownMenu_GetSelectedValue(JSHB.options.general.tranqannouncechannel.dropdown)
	DB.enabletranqalert = JSHB.options.general.enabletranqalert:GetChecked() and true or false
	DB.enabletimertenths = JSHB.options.general.enabletimertenths:GetChecked() and true or false
	DB.enabledebuffalert = JSHB.options.general.enabledebuffalert:GetChecked() and true or false
	DB.enabletargethealthpercent = JSHB.options.general.enabletargethealthpercent:GetChecked() and true or false
	DB.timericonanchorparent = UIDropDownMenu_GetSelectedValue(JSHB.options.general.timericonanchorparent.dropdown)
	DB.timertextcoloredbytime = JSHB.options.general.timertextcoloredbytime:GetChecked() and true or false
	DB.enablecurrentfocustext = JSHB.options.general.enablecurrentfocustext:GetChecked() and true or false
	DB.enabletranqablesframe = JSHB.options.general.enabletranqablesframe:GetChecked() and true or false
	DB.enabletranqablestips = JSHB.options.general.enabletranqablestips:GetChecked() and true or false

	-- Style & Style pane
	DB.classcolored = JSHB.options.stylesize.classcolored:GetChecked() and true or false
	DB.classcoloredprediction = JSHB.options.stylesize.classcoloredprediction:GetChecked() and true or false
	DB.enablehighcolorwarning = JSHB.options.stylesize.enablehighcolorwarning:GetChecked() and true or false
	DB.enabletukui = JSHB.options.stylesize.enabletukui:GetChecked() and true or false
	DB.enabletukuitimers = JSHB.options.stylesize.enabletukuitimers:GetChecked() and true or false
	DB.focushighthreshold = JSHB.options.stylesize.focushighthreshold:GetValue() / 100
	DB.focuscenteroffset = JSHB.options.stylesize.focuscenteroffset:GetValue()
	DB.alphazeroooc = JSHB.options.stylesize.alphazeroooc:GetValue() / 100
	DB.alphamaxooc = JSHB.options.stylesize.alphamaxooc:GetValue() / 100
	DB.alphanormooc = JSHB.options.stylesize.alphanormooc:GetValue() / 100
	DB.alphazero = JSHB.options.stylesize.alphazero:GetValue() / 100
	DB.alphamax = JSHB.options.stylesize.alphamax:GetValue() / 100
	DB.alphanorm = JSHB.options.stylesize.alphanorm:GetValue() / 100
	DB.alphaicontimersfaded = JSHB.options.stylesize.alphaicontimersfaded:GetValue() / 100
	DB.barWidth = JSHB.options.stylesize.barwidth:GetValue()
	DB.barHeight = JSHB.options.stylesize.barheight:GetValue()
	DB.iconSize = JSHB.options.stylesize.iconsize:GetValue()
		if (DB.iconSize < 8) then DB.iconSize = 8 end
	DB.cCIconSize = JSHB.options.stylesize.cciconsize:GetValue()
	DB.markIconSize = JSHB.options.stylesize.markiconsize:GetValue()
	DB.taiconsize = JSHB.options.stylesize.taiconsize:GetValue()
	DB.tranqablesiconsize = JSHB.options.stylesize.tranqablesiconsize:GetValue()
	DB.icontimerssize = JSHB.options.stylesize.icontimerssize:GetValue()
	DB.icontimersgap = JSHB.options.stylesize.icontimersgap:GetValue()
	DB.debufficonsize = JSHB.options.stylesize.debufficonsize:GetValue()
	DB.alphabackdrop = JSHB.options.stylesize.alphabackdrop:GetValue() / 100
	
	-- Colors
	DB.barcolor = { JSHB.options.colors.barcolor:GetColorRGB() }
	DB.barcolorwarninglow = { JSHB.options.colors.barcolorwarninglow:GetColorRGB() }
	DB.barcolorwarninghigh = { JSHB.options.colors.barcolorwarninghigh:GetColorRGB() }
	DB.predictionbarcolorwarninghigh = { JSHB.options.colors.predictionbarcolorwarninghigh:GetColorRGB() }
	DB.predictionbarcolor = { JSHB.options.colors.predictionbarcolor:GetColorRGB() }
	DB.autoshotbarcolor = { JSHB.options.colors.autoshotbarcolor:GetColorRGB() }

	-- Font & Texture pane
	DB.barfont = JSHB.options.fontstextures.barfont:GetValue()
	DB.timerfont = JSHB.options.fontstextures.timerfont:GetValue()
	DB.bartexture = JSHB.options.fontstextures.bartexture:GetValue()
	DB.fontsize = JSHB.options.fontstextures.fontsize:GetValue()
	DB.fontsizetimers = JSHB.options.fontstextures.fontsizetimers:GetValue()
	DB.fontoutlined = JSHB.options.fontstextures.fontoutlined:GetChecked() and true or false
	
	-- Class bar pane
	DB.enableindicator = JSHB.options.indicator.enableindicator:GetChecked() and true or false
	DB.indicatoriconsize = JSHB.options.indicator.indicatoriconsize:GetValue()
	
	-- Spec timers pane
	DB.timers["bm"] = JSHB.options.bm.Timers
	DB.timers["mm"] = JSHB.options.mm.Timers
	DB.timers["sv"] = JSHB.options.sv.Timers

	-- Misdirection pane
	DB.enablerightclickmd = JSHB.options.md.enablerightclickmd:GetChecked() and true or false
	DB.enablemdonpet = JSHB.options.md.enablemdonpet:GetChecked() and true or false
	DB.enablemdonparty = JSHB.options.md.enablemdonparty:GetChecked() and true or false
	DB.enablemdonraid = JSHB.options.md.enablemdonraid:GetChecked() and true or false
	DB.enablemdcastannounce = JSHB.options.md.enablemdcastannounce:GetChecked() and true or false
	DB.enablemdoverannounce = JSHB.options.md.enablemdoverannounce:GetChecked() and true or false
	DB.enablemdtargetwhisper = JSHB.options.md.enablemdtargetwhisper:GetChecked() and true or false
	DB.mdannouncechannel = UIDropDownMenu_GetSelectedValue(JSHB.options.md.mdannouncechannel.dropdown)
		
	-- Custom Spells
	DBG.customspell = JSHB.options.customspell.spellids
	
	-- Custom Tranqs
	DBG.customtranq = JSHB.options.customtranq.spellids
	
	-- Custom Auras
	DBG.customaura = JSHB.options.customaura.spellids
	
	
	JSHB.reconfigureAddon()
end


local function getMatchTableVal(table, colMatch, colReturn, toMatch)
	local i
	for i=1,#table do
		if table[i][colMatch] == toMatch then return table[i][colReturn] end
	end
	return nil
end


JSHB.setupOptionsPane = function()
	
	-- Default pane
	if JSHB.barLocked then JSHB.options.enablebarlock:SetChecked(true) else JSHB.options.enablebarlock:SetChecked(false) end

	-- General pane
	if DB.enablestackbars then JSHB.options.general.enablestackbars:SetChecked(true) else JSHB.options.general.enablestackbars:SetChecked(false) end
	if DB.movestackbarstotop then JSHB.options.general.movestackbarstotop:SetChecked(true) else JSHB.options.general.movestackbarstotop:SetChecked(false) end
	if DB.enableautoshotbar then JSHB.options.general.enableautoshotbar:SetChecked(true) else JSHB.options.general.enableautoshotbar:SetChecked(false) end
	if DB.enableautoshottext then JSHB.options.general.enableautoshottext:SetChecked(true) else JSHB.options.general.enableautoshottext:SetChecked(false) end
	if DB.enablemaintick then JSHB.options.general.enablemaintick:SetChecked(true) else JSHB.options.general.enablemaintick:SetChecked(false) end
	if DB.enablehuntersmarkwarning then JSHB.options.general.enablehuntersmarkwarning:SetChecked(true) else JSHB.options.general.enablehuntersmarkwarning:SetChecked(false) end
	if DB.enabletranqannounce then JSHB.options.general.enabletranqannounce:SetChecked(true) else JSHB.options.general.enabletranqannounce:SetChecked(false) end

	UIDropDownMenu_SetSelectedValue(JSHB.options.general.tranqannouncechannel.dropdown, DB.tranqannouncechannel or 1) -- the or 1 accounts for feature added after-the-fact
	JSHB.options.general.tranqannouncechannel.valueText:SetText(getMatchTableVal(JSHB.chatchannels, 2, 1, DB.tranqannouncechannel))

	if DB.enabletranqalert then JSHB.options.general.enabletranqalert:SetChecked(true) else JSHB.options.general.enabletranqalert:SetChecked(false) end
	if DB.enablecctimers then JSHB.options.general.enablecctimers:SetChecked(true) else JSHB.options.general.enablecctimers:SetChecked(false) end
	if DB.enableprediction then JSHB.options.general.enableprediction:SetChecked(true) else JSHB.options.general.enableprediction:SetChecked(false) end
	if DB.enabletimers then JSHB.options.general.enabletimers:SetChecked(true) else JSHB.options.general.enabletimers:SetChecked(false) end

	UIDropDownMenu_SetSelectedValue(JSHB.options.general.timerfontposition.dropdown, DB.timerfontposition)
	JSHB.options.general.timerfontposition.valueText:SetText(getMatchTableVal(JSHB.timerfontpositions, 2, 1, DB.timerfontposition))

	if DB.enabletimerstext then JSHB.options.general.enabletimerstext:SetChecked(true) else JSHB.options.general.enabletimerstext:SetChecked(false) end
	if DB.enabletimertenths then JSHB.options.general.enabletimertenths:SetChecked(true) else JSHB.options.general.enabletimertenths:SetChecked(false) end
	if DB.enabledebuffalert then JSHB.options.general.enabledebuffalert:SetChecked(true) else JSHB.options.general.enabledebuffalert:SetChecked(false) end
	if DB.enabletargethealthpercent  then JSHB.options.general.enabletargethealthpercent:SetChecked(true) else JSHB.options.general.enabletargethealthpercent:SetChecked(false) end

	UIDropDownMenu_SetSelectedValue(JSHB.options.general.timericonanchorparent.dropdown, DB.timericonanchorparent)
	JSHB.options.general.timericonanchorparent.valueText:SetText(getMatchTableVal(JSHB.timericonanchors, 2, 1, DB.timericonanchorparent))

	if DB.timertextcoloredbytime then JSHB.options.general.timertextcoloredbytime:SetChecked(true) else JSHB.options.general.timertextcoloredbytime:SetChecked(false) end
	if DB.enablecurrentfocustext then JSHB.options.general.enablecurrentfocustext:SetChecked(true) else JSHB.options.general.enablecurrentfocustext:SetChecked(false) end
	if DB.enabletranqablesframe then JSHB.options.general.enabletranqablesframe:SetChecked(true) else JSHB.options.general.enabletranqablesframe:SetChecked(false) end
	if DB.enabletranqablestips then JSHB.options.general.enabletranqablestips:SetChecked(true) else JSHB.options.general.enabletranqablestips:SetChecked(false) end

	-- Style & Style pane
	if DB.classcolored then JSHB.options.stylesize.classcolored:SetChecked(true) else JSHB.options.stylesize.classcolored:SetChecked(false) end
	if DB.classcoloredprediction then JSHB.options.stylesize.classcoloredprediction:SetChecked(true) else JSHB.options.stylesize.classcoloredprediction:SetChecked(false) end
	if DB.enablehighcolorwarning then JSHB.options.stylesize.enablehighcolorwarning:SetChecked(true) else JSHB.options.stylesize.enablehighcolorwarning:SetChecked(false) end
	JSHB.options.stylesize.focushighthreshold:SetValue(DB.focushighthreshold * 100)
	JSHB.options.stylesize.focuscenteroffset:SetValue(DB.focuscenteroffset)
	if DB.enabletukui then JSHB.options.stylesize.enabletukui:SetChecked(true) else JSHB.options.stylesize.enabletukui:SetChecked(false) end
	if DB.enabletukuitimers then JSHB.options.stylesize.enabletukuitimers:SetChecked(true) else JSHB.options.stylesize.enabletukuitimers:SetChecked(false) end
	JSHB.options.stylesize.barwidth:SetValue(DB.barWidth)
	JSHB.options.stylesize.barheight:SetValue(DB.barHeight)
	JSHB.options.stylesize.iconsize:SetValue(DB.iconSize)
	JSHB.options.stylesize.cciconsize:SetValue(DB.cCIconSize)
	JSHB.options.stylesize.markiconsize:SetValue(DB.markIconSize)
	JSHB.options.stylesize.taiconsize:SetValue(DB.taiconsize)
	JSHB.options.stylesize.tranqablesiconsize:SetValue(DB.tranqablesiconsize)
	JSHB.options.stylesize.icontimerssize:SetValue(DB.icontimerssize)
	JSHB.options.stylesize.icontimersgap:SetValue(DB.icontimersgap)
	JSHB.options.stylesize.debufficonsize:SetValue(DB.debufficonsize)
	JSHB.options.stylesize.alphabackdrop:SetValue(DB.alphabackdrop * 100)
	JSHB.options.stylesize.alphazeroooc:SetValue(DB.alphazeroooc * 100)
	JSHB.options.stylesize.alphamaxooc:SetValue(DB.alphamaxooc * 100)
	JSHB.options.stylesize.alphanormooc:SetValue(DB.alphanormooc * 100)
	JSHB.options.stylesize.alphazero:SetValue(DB.alphazero * 100)
	JSHB.options.stylesize.alphamax:SetValue(DB.alphamax * 100)
	JSHB.options.stylesize.alphanorm:SetValue(DB.alphanorm * 100)
	JSHB.options.stylesize.alphaicontimersfaded:SetValue(DB.alphaicontimersfaded * 100)

	-- Font & Texture pane
	JSHB.options.fontstextures.barfont:SetValue(DB.barfont)
	JSHB.options.fontstextures.timerfont:SetValue(DB.timerfont)
	JSHB.options.fontstextures.bartexture:SetValue(DB.bartexture)
	JSHB.options.fontstextures.fontsize:SetValue(DB.fontsize)
	JSHB.options.fontstextures.fontsizetimers:SetValue(DB.fontsizetimers)
	if DB.fontoutlined then JSHB.options.fontstextures.fontoutlined:SetChecked(true) else JSHB.options.fontstextures.fontoutlined:SetChecked(false) end

	-- Colors pane
	JSHB.options.colors.barcolor:SetColorRGB(unpack(DB.barcolor))
	JSHB.options.colors.barcolorwarninglow:SetColorRGB(unpack(DB.barcolorwarninglow))
	JSHB.options.colors.barcolorwarninghigh:SetColorRGB(unpack(DB.barcolorwarninghigh))
	JSHB.options.colors.predictionbarcolorwarninghigh:SetColorRGB(unpack(DB.predictionbarcolorwarninghigh))
	JSHB.options.colors.predictionbarcolor:SetColorRGB(unpack(DB.predictionbarcolor))
	JSHB.options.colors.autoshotbarcolor:SetColorRGB(unpack(DB.autoshotbarcolor))

	-- Class bar pane
	if DB.enableindicator then JSHB.options.indicator.enableindicator:SetChecked(true) else JSHB.options.indicator.enableindicator:SetChecked(false) end
	JSHB.options.indicator.indicatoriconsize:SetValue(DB.indicatoriconsize)
	
	-- Spec timers pane
	JSHB.options.bm.Timers = DB.timers["bm"]
	JSHB.options.mm.Timers = DB.timers["mm"]
	JSHB.options.sv.Timers = DB.timers["sv"]
	
	-- Misdirection pane
	if DB.enablerightclickmd then JSHB.options.md.enablerightclickmd:SetChecked(true) else JSHB.options.md.enablerightclickmd:SetChecked(false) end
	if DB.enablemdonpet then JSHB.options.md.enablemdonpet:SetChecked(true) else JSHB.options.md.enablemdonpet:SetChecked(false) end
	if DB.enablemdonparty then JSHB.options.md.enablemdonparty:SetChecked(true) else JSHB.options.md.enablemdonparty:SetChecked(false) end
	if DB.enablemdonraid then JSHB.options.md.enablemdonraid:SetChecked(true) else JSHB.options.md.enablemdonraid:SetChecked(false) end
	if DB.enablemdcastannounce then JSHB.options.md.enablemdcastannounce:SetChecked(true) else JSHB.options.md.enablemdcastannounce:SetChecked(false) end
	if DB.enablemdtargetwhisper then JSHB.options.md.enablemdtargetwhisper:SetChecked(true) else JSHB.options.md.enablemdtargetwhisper:SetChecked(false) end
	if DB.enablemdoverannounce then JSHB.options.md.enablemdoverannounce:SetChecked(true) else JSHB.options.md.enablemdoverannounce:SetChecked(false) end
	
	UIDropDownMenu_SetSelectedValue(JSHB.options.md.mdannouncechannel.dropdown, DB.mdannouncechannel or 1)
	JSHB.options.md.mdannouncechannel.valueText:SetText(getMatchTableVal(JSHB.chatchannels, 2, 1, DB.mdannouncechannel))
	
	-- Custom Spells
	JSHB.options.customspell.spellids = DBG.customspell
	
	-- Custom Tranqs
	JSHB.options.customtranq.spellids = DBG.customtranq
	
	-- Custom Auras
	JSHB.options.customaura.spellids = DBG.customaura
end


-- Lastly, Add in the panels.
JSHB.options.okay = JSHB.updateSettings
JSHB.options.cancel = JSHB.setupOptionsPane
JSHB.options.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("main") end

JSHB.options.genscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("general") end
InterfaceOptions_AddCategory(JSHB.options.genscrollframeparent)

JSHB.options.stylesizescrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("style") end
InterfaceOptions_AddCategory(JSHB.options.stylesizescrollframeparent)

JSHB.options.fontstextures.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("fontstextures") end
InterfaceOptions_AddCategory(JSHB.options.fontstextures)

JSHB.options.colors.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("colors") end
InterfaceOptions_AddCategory(JSHB.options.colors)

JSHB.options.indicatorscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("indicator") end
InterfaceOptions_AddCategory(JSHB.options.indicatorscrollframeparent)

JSHB.options.bmscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsForSpec("bm") end
JSHB.options.bmscrollframeparent.refresh = function() JSHB.options.RefreshConfigurationSettingsForSpec("bm") end
InterfaceOptions_AddCategory(JSHB.options.bmscrollframeparent)

JSHB.options.mmscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsForSpec("mm") end
JSHB.options.mmscrollframeparent.refresh = function() JSHB.options.RefreshConfigurationSettingsForSpec("mm") end
InterfaceOptions_AddCategory(JSHB.options.mmscrollframeparent)

JSHB.options.svscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsForSpec("sv") end
JSHB.options.svscrollframeparent.refresh = function() JSHB.options.RefreshConfigurationSettingsForSpec("sv") end
InterfaceOptions_AddCategory(JSHB.options.svscrollframeparent)

JSHB.options.mdscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsFor("misdirection") end
InterfaceOptions_AddCategory(JSHB.options.mdscrollframeparent)

JSHB.options.customspellscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsForCustomSpell("customspell") end
JSHB.options.customspellscrollframeparent.refresh = function() JSHB.options.RefreshConfigurationSettingsForCustomSpell("customspell") end
InterfaceOptions_AddCategory(JSHB.options.customspellscrollframeparent)

JSHB.options.customtranqscrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsForCustomSpell("customtranq") end
JSHB.options.customtranqscrollframeparent.refresh = function() JSHB.options.RefreshConfigurationSettingsForCustomSpell("customtranq") end
InterfaceOptions_AddCategory(JSHB.options.customtranqscrollframeparent)

JSHB.options.customaurascrollframeparent.default = function() JSHB.options.ApplyDefaultConfigurationSettingsForCustomSpell("customaura") end
JSHB.options.customaurascrollframeparent.refresh = function() JSHB.options.RefreshConfigurationSettingsForCustomSpell("customaura") end
InterfaceOptions_AddCategory(JSHB.options.customaurascrollframeparent)
