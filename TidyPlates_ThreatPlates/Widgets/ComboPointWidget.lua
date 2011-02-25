------------------------
-- Combo Point Widget --
------------------------
local path = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ComboPointWidget\\"
local COMBO_ART = { "1", "2", "3", "4", "5", }

local function UpdateComboPointFrame(frame, unit)
	local points 
	if UnitExists("target") and unit.isTarget then points = GetComboPoints("player", "target") end
	if points and points > 0 and TidyPlatesThreat.db.profile.comboWidget.ON then 
		frame.Icon:SetTexture(path..COMBO_ART[points]) 
		frame:Show()
	else 
		frame:Hide() 
	end	
end

local function CreateComboPointWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(64)
	frame:SetWidth(64)
	--frame:RegisterEvent("PLAYER_COMBO_POINTS")
	--frame:SetScript("OnEvent", TidyPlates.Update)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateComboPointFrame
	return frame
end

ThreatPlatesWidgets.CreateComboPointWidget = CreateComboPointWidget
