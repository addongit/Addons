-- This code is based off the code from LibCandyBar-3.0


--------------------------------------------------------------------------------
-- Local variables and functions
--------------------------------------------------------------------------------


-- SecondsToTimeDetail() - Used to format the duration label time
local function SecondsToTimeDetail( t )
	if t >= 3600 then -- > 1 hour
		local h = floor(t/3600)
		local m = t - (h*3600)
		return "%d:%02d", h, m
	elseif t >= 60 then -- 1 minute to 1 hour
		local m = floor(t/60)
		local s = t - (m*60)
		return "%d:%02d", m, s
	elseif t < 10 then -- 0 to 10 seconds
		return "%1.1f", t
	else -- 10 seconds to one minute
		return "%.0f", floor(t + .5)
	end
end


-- OnUpdate() - OnUpdate function used to animate the bar
local function OnUpdate(self)

	-- Check if the expired time is over
	local t = GetTime()
	if t >= self.exp then
		self:Stop()
	-- Update the status bar and duration label
	else
		local time = self.exp - t
		self.remaining = time
		self.statusBar:SetValue(time)		
		self.durationLabel:SetFormattedText(SecondsToTimeDetail(time))
	end
end


-- restyleBar() - Restyle the bar (called whenever changing the label, icon or time visibility settings)
local function restyleBar(self)
	if not self.running then
		return
	end
	
	self.statusBar:SetPoint("TOPLEFT", self)
	self.statusBar:SetPoint("BOTTOMLEFT", self)

	-- Show the name label
	self.nameLabel:Show()
	self.durationLabel:Show()
end


--------------------------------------------------------------------------------
-- Functions to configure the bar
--------------------------------------------------------------------------------


-- SetBarColor() - Set the bar color
local SetBarColor = function(self, r, g, b, a) 
	self.statusBar:SetStatusBarColor(r, g, b, a) 
end


-- SetBarTexture() - Set the texture of the bar
local SetBarTexture = function(self, texture)
	self.statusBar:SetStatusBarTexture(texture)
	self.barBackground:SetTexture(texture)
end


--------------------------------------------------------------------------------
-- Functions to create, show and hide the bar
--------------------------------------------------------------------------------


-- StartBar() - Start the bar
local StartBar = function(self, duration)
	if duration then
		self.remaining = duration
	end
	
	self.running = true
	restyleBar(self)
	self.statusBar:SetMinMaxValues(0, self.remaining)
	self.exp = GetTime() + self.remaining
	self:SetScript("OnUpdate", OnUpdate)
	self:Show()
end


-- StopBar() - Stop the bar
local StopBar = function(self)
	self.running = nil
	self:Hide()
end


-- CreateBar() - Create the bar
function CreateBar(texture, width, height)

	-- Create the main frame
	local bar = CreateFrame("Frame", "EnragedBar", UIParent)
	bar:ClearAllPoints()
	bar:SetMovable(1)
	bar:SetScale(1)
	bar:SetAlpha(1)
	
	-- Create the statusbar
	bar.statusBar = CreateFrame("StatusBar", nil, bar)
	bar.statusBar:SetPoint("TOPRIGHT")
	bar.statusBar:SetPoint("BOTTOMRIGHT")
	bar.statusBar:SetStatusBarTexture(texture)
	
	-- Create the background texture
	bar.barBackground = bar.statusBar:CreateTexture(nil, "BACKGROUND")
	bar.barBackground:SetVertexColor(0.5, 0.5, 0.5, 0.3)
	bar.barBackground:SetTexture(texture)
	bar.barBackground:SetAllPoints()
	
	local fontName, fontSize = GameFontHighlightSmallOutline:GetFont()
	
	-- Create the duration label
	bar.durationLabel = bar.statusBar:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")
	bar.durationLabel:SetPoint("RIGHT", bar.statusBar, "RIGHT", -2, 0)
	bar.durationLabel:SetTextColor(1,1,1,1)
	bar.durationLabel:SetJustifyH("CENTER")
	bar.durationLabel:SetJustifyV("MIDDLE")
	bar.durationLabel:SetFont(fontName, fontSize)
	bar.durationLabel:SetFontObject("GameFontHighlightSmallOutline")
	
	-- Create the name label
	bar.nameLabel = bar.statusBar:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")
	bar.nameLabel:SetPoint("LEFT", bar.statusBar, "LEFT", 2, 0)
	bar.nameLabel:SetPoint("RIGHT", bar.statusBar, "RIGHT", -2, 0)
	bar.nameLabel:SetTextColor(1,1,1,1)
	bar.nameLabel:SetJustifyH("CENTER")
	bar.nameLabel:SetJustifyV("MIDDLE")
	bar.nameLabel:SetFont(fontName, fontSize)
	bar.nameLabel:SetFontObject("GameFontHighlightSmallOutline")
	bar.nameLabel:SetText("Enraged")
	
	-- Set the functions
	bar.Stop = StopBar
	bar.Start = StartBar
	bar.SetTexture = SetBarTexture
	bar.SetColor = SetBarColor

	return bar
end

