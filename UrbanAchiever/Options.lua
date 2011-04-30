function UrbanAchiever:CreateOptions()
	local panel = CreateFrame("Frame")
	panel.name = "Urban Achiever"
	
	local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 15, -16)
	title:SetText("Urban Achiever")
	title:SetJustifyH("LEFT")
	title:SetJustifyV("TOP")
	
	local subText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subText:SetText(UAReplacementFrame)
	subText:SetNonSpaceWrap(true)
	subText:SetJustifyH("LEFT")
	subText:SetJustifyV("TOP")
	
	local statTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	statTitle:SetText(UAOptions)
	statTitle:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -10)
	
	local sC = CreateFrame("CheckButton", "UACB", panel, "OptionsCheckButtonTemplate")
	sC:SetPoint("TOPLEFT", statTitle, "BOTTOMLEFT", 0, -10)
	sC.text = getglobal(sC:GetName() .. "Text")
	sC.text:SetText(UADisplayStatiCriter)
	sC.tooltipText = UADSCTooltipStr1;
	sC:SetChecked(UASVPC.statCriteria)
	sC:SetScript("OnClick", function()
		if sC:GetChecked() then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		UASVPC.statCriteria = not UASVPC.statCriteria 
		sC:SetChecked(UASVPC.statCriteria)
	end)
	
	local mC = CreateFrame("CheckButton", "UACB2", panel, "OptionsCheckButtonTemplate")
	mC:SetPoint("TOPLEFT", sC, "BOTTOMLEFT", 0, -10)
	mC.text = getglobal(mC:GetName() .. "Text")
	mC.text:SetText(UAColorMoney)
	mC.tooltipText = UAShowMoneyStr1 .. " |cffffd70012|r.|cffc7c7cf34|r.|cffeda55f56|r " .. UAShowMoneyStr2 .. " 12|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t 34|TInterface\\MoneyFrame\\UI-SilverIcon:14:14:2:0|t 56|TInterface\\MoneyFrame\\UI-CopperIcon:14:14:2:0|t"
	mC:SetChecked(UASVPC.moneyAsColor)
	mC:SetScript("OnClick", function()
		if mC:GetChecked() then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		UASVPC.moneyAsColor = not UASVPC.moneyAsColor
		mC:SetChecked(UASVPC.moneyAsColor)
	end)
	
	local dS = CreateFrame("CheckButton", "UACB3", panel, "OptionsCheckButtonTemplate")
	dS:SetPoint("TOPLEFT", mC, "BOTTOMLEFT", 0, -10)
	dS.text = getglobal(dS:GetName() .. "Text")
	dS.text:SetText(UADisplaySummaryCriter)
	dS.tooltipText = UADSCTooltipStr2;
	dS:SetChecked(UASVPC.specificCriteria)
	dS:SetScript("OnClick", function()
		if dS:GetChecked() then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		UASVPC.specificCriteria = not UASVPC.specificCriteria
		dS:SetChecked(UASVPC.specificCriteria)
	end)
	
	local tT = CreateFrame("CheckButton", "UACB4", panel, "OptionsCheckButtonTemplate")
	tT:SetPoint("TOPLEFT", dS, "BOTTOMLEFT", 0, -10)
	tT.text = getglobal(tT:GetName() .. "Text")
	tT.text:SetText(UAAutoTrackA)
	tT.tooltipText = UAAutoTrackATootltip
	tT:SetChecked(UASVPC.trackTimed)
	tT:SetScript("OnClick", function()
		if tT:GetChecked() then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		UASVPC.trackTimed = not UASVPC.trackTimed
		tT:SetChecked(UASVPC.trackTimed)
	end)
	
	InterfaceOptions_AddCategory(panel)
	UrbanAchiever:AddHelpPanel()
end

function UrbanAchiever:AddHelpPanel()
	local panel = CreateFrame("Frame")
	panel.name = UAHelp;
	panel.parent = "Urban Achiever"
	
	local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 15, -16)
	title:SetText("Urban Achiever - " .. UAHelp)
	title:SetJustifyH("LEFT")
	title:SetJustifyV("TOP")
	
	local subText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subText:SetText(UAOMG)
	subText:SetNonSpaceWrap(true)
	subText:SetJustifyH("LEFT")
	subText:SetJustifyV("TOP")
	
	local iconTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	iconTitle:SetText(UAIcon)
	iconTitle:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -10)
	
	local iconIcons = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	iconIcons:SetTextColor(1,1,1)
	iconIcons:SetPoint("TOPLEFT", iconTitle, "BOTTOMLEFT")
	iconIcons:SetText("|cffff0000!|r\n" ..
		"|cff00ff00T|r\n" .. 
		"+/-\n"
	)
	
	local iconBody = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	iconBody:SetJustifyH("LEFT")
	iconBody:SetWidth(370)
	iconBody:SetTextColor(1,1,1)
	iconBody:SetText(UARewardStr .. UATrackedStr .. UAMoreStr)
	iconBody:SetPoint("TOPLEFT", iconIcons, "TOPRIGHT", 0, -6)
	
	local trackerTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	trackerTitle:SetText(UATracker)
	trackerTitle:SetPoint("TOPLEFT", iconIcons, "BOTTOMLEFT", 0, -15)
	
	local trackerBody = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	trackerBody:SetJustifyH("LEFT")
	trackerBody:SetWidth(390)
	trackerBody:SetTextColor(1,1,1)
	trackerBody:SetText("|cff00ff00" .. UABindTrackedStr .. "|cff00ff00" .. UABindShowStr .. "|cff00ff00" .. UABindRemoveTrackedStr)
	trackerBody:SetPoint("TOPLEFT", trackerTitle, "BOTTOMLEFT")
	
	InterfaceOptions_AddCategory(panel)
end
