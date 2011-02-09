MA_Locked = false;
MA_Tooltips = true;

local LoadFrame = CreateFrame("FRAME");
LoadFrame:RegisterEvent("ADDON_LOADED");
LoadFrame:RegisterEvent("PLAYER_LOGOUT");

function LoadFrame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "MarkAssistant" then
		if not MarkAssistantDB then
			MarkAssistantDB = {}
		end
		if MarkAssistantDB.locked == nil then
			MarkAssistantDB.locked = false;
		else
			MA_Locked = MarkAssistantDB.locked;
			if MA_Locked == true then
				MA_OptionsFrameCheckButton_Locked:SetChecked(1);
			else
				MA_OptionsFrameCheckButton_Locked:SetChecked(0);
			end
		end
		if MarkAssistantDB.tooltips == nil then
			MarkAssistantDB.tooltips = true;
			MA_OptionsFrameCheckButton_Tooltips:SetChecked(1);
		else
			MA_Tooltips = MarkAssistantDB.tooltips;
			if MA_Tooltips == true then
				MA_OptionsFrameCheckButton_Tooltips:SetChecked(1);
			else
				MA_OptionsFrameCheckButton_Tooltips:SetChecked(0);
			end
		end
	elseif event == "PLAYER_LOGOUT" then
		MarkAssistantDB.locked = MA_Locked;
		MarkAssistantDB.tooltips = MA_Tooltips;
	end
end

LoadFrame:SetScript("OnEvent", LoadFrame.OnEvent);

function MA_OnLoad()
	AddSlashCommands();
end

function SlashCommandHandler(msg)
	if msg == "show" then
		MA_Form:Show();
	elseif msg == "hide" then
		MA_Form:Hide();
	elseif msg == "lock" then
		MA_OptionsFrameCheckButton_Locked:SetChecked(1);
		MA_Locked = true;
	elseif msg == "unlock" then
		MA_OptionsFrameCheckButton_Locked:SetChecked(0);
		MA_Locked = false;
	elseif msg == "tooltips" then
		if MA_Tooltips == false then
			MA_OptionsFrameCheckButton_Tooltips:SetChecked(1);
			MA_Tooltips = true;
			MA_HideGameTooltip();
		else
			MA_OptionsFrameCheckButton_Tooltips:SetChecked(0);
			MA_Tooltips = false;
		end
	elseif msg == "options" or msg == "opts" or msg == "opt" or msg == "config" then
		MA_ShowOptionsFrame();
	else
		print("|r|c00FFD200MarkAssistant|r by |r|c00ABD473Wraine|r@Arygos-US");
		print("To Move: Click and Drag any corner (when unlocked)");
		print("Options: Right Click anywhere on MarkAssistant Frame");
		print("To Use: /markassistant, /markassist, /mark <cmd>");
		print("        <cmd> List: show, hide, lock, unlock, tooltips, options");
	end
end

function AddSlashCommands()
	SlashCmdList["MarkAssistant"] = SlashCommandHandler;
	SLASH_MarkAssistant1 = "/markassistant";
	SLASH_MarkAssistant2 = "/markassist";
	SLASH_MarkAssistant3 = "/mark";
end

function MA_MarkTarget(iconNum)
	SetRaidTargetIcon("target", iconNum);
end

function MA_ShowGameTooltip(str)
	if MA_Tooltips == true then
		FrmX, FrmY = MA_Form:GetCenter();
		MA_TooltipText:SetText(str);
		if (FrmY+85+MA_TooltipText:GetHeight()) >= UIParent:GetHeight() then
			MA_Tooltip:SetPoint("BOTTOMLEFT", FrmX-134.5, FrmY-(33+math.floor(MA_TooltipText:GetHeight())));
		else
			MA_Tooltip:SetPoint("BOTTOMLEFT", FrmX-134.5, FrmY+17);
		end
		MA_Tooltip:SetWidth(MA_TooltipText:GetWidth()+21);
		MA_Tooltip:SetHeight(MA_TooltipText:GetHeight()+15);
		MA_Tooltip:Show();
	end
end

function MA_HideGameTooltip()
	MA_Tooltip:Hide();
	MA_TooltipText:SetText("");
end

function MA_ShowOptionsFrame()
	FrmX, FrmY = MA_Form:GetCenter();
	MA_OptionsFrameText:SetText("|r|c00FFD200Options|r\n-----------------");
	if (FrmX+MA_Form:GetWidth()+50+MA_OptionsFrameText:GetWidth()) >= UIParent:GetWidth() then
		MA_OptionsFrame:SetPoint("BOTTOMLEFT", FrmX-(MA_OptionsFrame:GetWidth()+134.5), FrmY-(MA_OptionsFrame:GetHeight()-17.5));
	else
		MA_OptionsFrame:SetPoint("BOTTOMLEFT", FrmX+134.5, FrmY-(MA_OptionsFrame:GetHeight()-17.5));
	end
	MA_OptionsFrame:Show();
end

function MA_HideOptionsFrame()
	MA_OptionsFrame:Hide();
	MA_OptionsFrameText:SetText("");
end

function MA_SetLocked(self)
	if self:GetChecked() == 1 then
		MA_Locked = true;
	else
		MA_Locked = false;
	end
end

function MA_SetTooltips(self)
	if self:GetChecked() == 1 then
		MA_Tooltips = true;
	else
		MA_Tooltips = false;
		MA_HideGameTooltip();
	end
end