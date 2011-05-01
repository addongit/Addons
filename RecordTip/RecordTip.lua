--local RecordTipDB = RecordTipDB or {["dmg"] = {}, ["heal"] = {}}

local RT = CreateFrame("MessageFrame", "RecordTipFrame", UIParent)

RT:EnableKeyboard(false)
RT:EnableMouse(false)
RT:EnableMouseWheel(false)

RT:ClearAllPoints()
RT:SetWidth(400)
RT:SetHeight(50)
RT:SetPoint("BOTTOMLEFT", MainMenuBar, "TOPLEFT", ((MainMenuBar:GetWidth()/2) - 200), 150)

RT:SetFadeDuration(0.75)
RT:SetFading(true)
RT:SetTimeVisible(0.5)

RT:SetFontObject("NumberFont_Outline_Med")
RT:SetTextColor(0.4, 1, 0.4, 1)
RT:SetJustifyH("CENTER")

RT:Show();

function RT.OnEvent(self, event, ...)
	if event == "ADDON_LOADED" and select(1, ...) == "RecordTip" then
		if RecordTipDB == nil then
			RecordTipDB = {["dmg"] = {}, ["heal"] = {}}
		end

		RT:AddMessage("|cFF44FF44RecordTip |cFFFFFFFFloaded.")
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and select(4, ...) == UnitName("player") then
		if string.find(select(2, ...), "_DAMAGE") then
			local spell = select(10, ...)
			local amount = select(12, ...) or 0
			local crit = select(18, ...) or 0

			if spell and type(spell) == "string" then
				RecordTipDB.dmg[spell] = RecordTipDB.dmg[spell] or {["norm"] = 0, ["crit"] = 0}
				if crit == 1 then
					local record = RecordTipDB.dmg[spell].crit or 0

					if record < amount then
						RT:Clear();
						RT:AddMessage("New "..spell.."|cFFFF0000 critical|cFFFFFFFF damage record "..amount.." ("..RecordTipDB.dmg[spell].crit..")!")
						RecordTipDB.dmg[spell].crit = amount
					end
				else
					local record = RecordTipDB.dmg[spell].norm or 0

					if record < amount then
						RT:Clear();
						RT:AddMessage("New "..spell.." damage record "..amount.." ("..RecordTipDB.dmg[spell].norm..")!")
						RecordTipDB.dmg[spell].norm = amount
					end
				end
			end
		elseif string.find(select(2, ...), "_HEAL") then
			local spell = select(10, ...)
			local amount = select(12, ...) or 0
			local crit = select(15, ...) or 0

			if spell and type(spell) == "string" then
				RecordTipDB.heal[spell] = RecordTipDB.heal[spell] or {["norm"] = 0, ["crit"] = 0}

				if crit == 1 then
					local record = RecordTipDB.heal[spell].crit or 0

					if record < amount then
						RT:Clear();
						RT:AddMessage("New "..spell.." |cFF00FF00critical|cFFFFFFFF heal record "..amount.." ("..RecordTipDB.heal[spell].crit..")!")
						RecordTipDB.heal[spell].crit = amount
					end
				else
					local record = RecordTipDB.heal[spell].norm or 0

					if record < amount then
						RT:Clear();
						RT:AddMessage("New "..spell.." heal record "..amount.." ("..RecordTipDB.heal[spell].norm..")!")
						RecordTipDB.heal[spell].norm = amount
					end
				end
			end
		end
	end
end

RT:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RT:RegisterEvent("ADDON_LOADED")
RT:SetScript("OnEvent", RT.OnEvent)


GameTooltip:HookScript("OnShow", function(self)
	local spell = self:GetSpell();

	if spell and RecordTipDB.dmg[spell] and (RecordTipDB.dmg[spell].crit > 0 or RecordTipDB.dmg[spell].norm > 0) then
		self:AddLine(" ");
		self:AddLine("|cFFFFFF44RecordTip |cFFFF4444Damage");
		if RecordTipDB.dmg[spell].norm and RecordTipDB.dmg[spell].norm > 0 then
			self:AddDoubleLine("Normal", RecordTipDB.dmg[spell].norm, 1, 1, 1, 0, 1, 0);
		end
		if RecordTipDB.dmg[spell].crit and RecordTipDB.dmg[spell].crit > 0 then
			self:AddDoubleLine("Critical", RecordTipDB.dmg[spell].crit, 1, 1, 1, 0, 1, 0);
		end
	end

	if spell and RecordTipDB.heal[spell] and (RecordTipDB.heal[spell].crit > 0 or RecordTipDB.heal[spell].norm > 0) then
		self:AddLine(" ");
		self:AddLine("|cFFFFFF44RecordTip |cFF44FF44Heal");
		if RecordTipDB.heal[spell].norm and RecordTipDB.heal[spell].norm > 0 then
			self:AddDoubleLine("Normal", RecordTipDB.heal[spell].norm, 1, 1, 1, 0, 1, 0);
		end
		if RecordTipDB.heal[spell].crit and RecordTipDB.heal[spell].crit > 0 then
			self:AddDoubleLine("Critical", RecordTipDB.heal[spell].crit, 1, 1, 1, 0, 1, 0);
		end
	end
end);

function RT.SlashCmdHandler(...)
	if select(1, ...) and string.lower(select(1, ...)) == "reset" then
		RecordTipDB = nil
		RecordTipDB = {["dmg"] = {}, ["heal"] = {}}
		DEFAULT_CHAT_FRAME:AddMessage("|cFF44FF44RecordTip|cFFFFFFFF all records reset.")
	end
end

SlashCmdList['RECORDTIP_SLASHCMD'] = RT.SlashCmdHandler
SLASH_RECORDTIP_SLASHCMD1 = '/recordtip'
SLASH_RECORDTIP_SLASHCMD2 = '/rt'