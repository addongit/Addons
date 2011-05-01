-- Indicators frame

-- Indicators have the following variables:
--  1st: Indicator name.
--  2nd: Function that sets up the indicator frame's functionality.

JSHB.classindicators = {
	["HUNTER"] = {
		-- Aspect Indicator
		{ 	JSHB.locale.indicator_hunter_aspect,
			function(self)
				-- Set the initial texture on creation
				if (GetShapeshiftForm() > 0) then
					local _, name = GetShapeshiftFormInfo(GetShapeshiftForm())
					local _, _, tex = GetSpellInfo(name)				
					self.Icon:SetTexture(tex)
				else
					self.Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
				end
				
				self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
				self:SetScript("OnEvent", function(self, event, ...)
					if event == "UPDATE_SHAPESHIFT_FORM" then
						if (GetShapeshiftForm() > 0) then
							local _, name = GetShapeshiftFormInfo(GetShapeshiftForm())
							local _, _, tex = GetSpellInfo(name)
							self.Icon:SetTexture(tex)

						else
							self.Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
						end
					end
				end)
				self.updateTimer = 0
				self:SetScript("OnUpdate", function(self, elapsed)
					self.updateTimer = self.updateTimer + elapsed
					if self.updateTimer < 0.3 then return end
					if (GetShapeshiftForm() > 0) then
						local _, name = GetShapeshiftFormInfo(GetShapeshiftForm())
						local _, _, tex = GetSpellInfo(name)
						self.Icon:SetTexture(tex)

					else
						self.Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
					end
				end)
			end,
		},
	},
}

JSHB.setupClassIndicators = function()

	if JSHB.indicatorFrame then
		JSHB.indicatorFrame:Hide()
		JSHB.indicatorFrame:SetParent(nil)
		JSHB.indicatorFrame = nil
		
		JSHB.anchorFrame.indicatorBar = nil
	end
	
	local totalIndicators = #JSHB.classindicators[select(2, UnitClass("player"))]
	local gap = 2
	local frameName = "JSHB_FRAME_indicatorBar"
	
	if (not JSHB.mainframe.db.enableindicator) or (totalIndicators == 0) then return end

	JSHB.anchorFrame.indicatorBar = CreateFrame("Frame", frameName .. "_ANCHOR", UIParent)
	
	JSHB.indicatorFrame = CreateFrame("Frame", frameName, UIParent)
	JSHB.indicatorFrame:SetHeight(JSHB.mainframe.db.indicatoriconsize)
	JSHB.indicatorFrame:SetWidth((JSHB.mainframe.db.indicatoriconsize * totalIndicators) + (gap * (totalIndicators - 1)))
	JSHB.indicatorFrame:SetPoint(JSHB.mainframe.db.indicatorBarAnchorPoint, 'UIParent', JSHB.mainframe.db.indicatorBarAnchorPointRelative,
		JSHB.mainframe.db.indicatorBarAnchorPointOffsetX, JSHB.mainframe.db.indicatorBarAnchorPointOffsetY)
	
	JSHB.indicatorFrame.indicator = {}
	
	local i
	for i=1,totalIndicators do
	
		-- Create the sub-frame for this indicator
		JSHB.indicatorFrame.indicator[i] = CreateFrame("Frame", frameName .. "_Indicator" .. i, JSHB.indicatorFrame)
		JSHB.indicatorFrame.indicator[i]:SetHeight(JSHB.mainframe.db.indicatoriconsize)
		JSHB.indicatorFrame.indicator[i]:SetWidth(JSHB.mainframe.db.indicatoriconsize)
		JSHB.indicatorFrame.indicator[i]:SetPoint("TOPLEFT", JSHB.indicatorFrame, "TOPLEFT", (i - 1) * (JSHB.mainframe.db.indicatoriconsize + gap), 0)

		-- Create the Icon itself for the indicator
		JSHB.indicatorFrame.indicator[i].Icon = JSHB.indicatorFrame.indicator[i]:CreateTexture(nil, "BACKGROUND")
		JSHB.indicatorFrame.indicator[i].Icon:SetAllPoints(JSHB.indicatorFrame.indicator[i])
		JSHB.indicatorFrame.indicator[i].Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
		
		if JSHB.mainframe.db.enabletukui then
			JSHB.indicatorFrame.indicator[i].border = JSHB.makeTukui(JSHB.indicatorFrame.indicator[i])
		end
		
		JSHB.indicatorFrame.indicator[i]:SetAlpha(1)
		JSHB.indicatorFrame.indicator[i]:Show()
		
		-- Call the setup for this indicator
		JSHB.classindicators[select(2, UnitClass("player"))][i][2](JSHB.indicatorFrame.indicator[i])		
	end	
end
