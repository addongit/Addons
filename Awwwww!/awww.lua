local f = CreateFrame("Frame")
local tkDrop = LibStub("tekKonfig-Dropdown")
local sounds = {
	"Interface\\AddOns\\Awwwww!\\sounds\\DonkeyKong-Die.ogg",			--Donkey Kong
	"Interface\\AddOns\\Awwwww!\\sounds\\SuperMario-Die.ogg",			--Mario
	"Interface\\AddOns\\Awwwww!\\sounds\\Mega Man Dies_3.ogg",			--Mega Man
	"Interface\\AddOns\\Awwwww!\\sounds\\MsPacMan-Death.ogg",			--Ms. PacMan
	"Interface\\AddOns\\Awwwww!\\sounds\\PacMan-Killed.ogg",			--PacMan
	"Interface\\AddOns\\Awwwww!\\sounds\\PriceIsRight-GameOver.ogg",	--The Price Is Right
	"Interface\\AddOns\\Awwwww!\\sounds\\LegendOfZelda-Die.ogg",		--Zelda
}
local values = {
	"Random",
	"Donkey Kong",
	"Mario",
	"Mega Man",
	"Ms. PacMan",
	"PacMan",
	"The Price Is Right",
	"Zelda",
}
local channels = {
	"Master",
	"SFX",
	--"Music",
	"Ambience",
}

local defaults = {
	sound = 1,
	channel = 1,
}

--local rand
local function DeathSound()
	if AwwwwwDB.sound == 1 then	--if set to "Random"
		PlaySoundFile(sounds[math.random(#sounds)], channels[AwwwwwDB.channel])
	else
		PlaySoundFile(sounds[AwwwwwDB.sound +1], channels[AwwwwwDB.channel])	-- +1 because "Random" is 1
	end
end

local function AddOptions()
	local header = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		header:SetParent(f)
		header:SetPoint("TOPLEFT", f, "TOPLEFT", 20,-15)
		header:SetText("Awwwww!")

	local subheader = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		subheader:SetParent(f)
		subheader:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0,-10)
		subheader:SetPoint("RIGHT", f, "RIGHT", -20,0)
		subheader:SetHeight(30)
		subheader:SetNonSpaceWrap(true)
		subheader:SetJustifyH("LEFT")
		subheader:SetText("This addon will play one or all of the following sounds upon your death.")

	local dropdown,droptext,dropcont,droplabel = tkDrop.new(f,"Sound played", "TOPLEFT", subheader, "BOTTOMLEFT", 0,-10)
		dropdown:SetWidth(175)
		dropdown.tiptext = "Select which sound to play upon your death.  Select 'Random' if you wish to hear all of them."
		droplabel:ClearAllPoints()
		droplabel:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 20, 5)
		droptext:SetText(values[AwwwwwDB.sound])
		local function OnClick(self)
			UIDropDownMenu_SetSelectedValue(dropdown, self.value)
			droptext:SetText(values[self.value])
			AwwwwwDB.sound = self.value
		end
		UIDropDownMenu_Initialize(dropdown, function()
			local current, info = values[AwwwwwDB.sound], UIDropDownMenu_CreateInfo()
			for k,v in pairs(values) do
				info.text, info.value, info.func, info.checked = v, k, OnClick, v == current
				UIDropDownMenu_AddButton(info)
			end
		end)

	local button = CreateFrame("Button", nil, f)
		button:SetWidth(140)
		button:SetHeight(25)
		button:SetPoint("LEFT", dropdown, "RIGHT", 20,3)
		button:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up.blp")
		button:GetNormalTexture():SetTexCoord(0,.64,0,.64)
		button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight.blp")
		button:GetHighlightTexture():SetTexCoord(0,.64,0,.64)
		button:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down.blp")
		button:GetPushedTexture():SetTexCoord(0,.64,0,.64)
		button:SetNormalFontObject("GameFontHighlight")
		button:SetText("Test")
		button:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
					GameTooltip:SetText("Hear the sound you've selected.")
					GameTooltip:Show()
				end)
		button:SetScript("OnLeave", function() GameTooltip:Hide() end)
		button:SetScript("OnClick", DeathSound)

	local dropdown2,droptext2,dropcont2,droplabel2 = tkDrop.new(f,"Sound channel", "TOPRIGHT", dropdown, "BOTTOMRIGHT", 0,-20)
		dropdown2:SetWidth(175)
		dropdown2.tiptext = "Select which channel the sound should be played on.  The volume of individual channels and the Master game sound may be adjusted in the 'Sound & Voice' options window."
		droplabel2:ClearAllPoints()
		droplabel2:SetPoint("BOTTOMLEFT", dropdown2, "TOPLEFT", 20, 5)
		droptext2:SetText(channels[AwwwwwDB.channel])
		local function OnClick2(self)
			UIDropDownMenu_SetSelectedValue(dropdown2, self.value)
			droptext2:SetText(channels[self.value])
			AwwwwwDB.channel = self.value
		end
		UIDropDownMenu_Initialize(dropdown2, function()
			local current, info = channels[AwwwwwDB.channel], UIDropDownMenu_CreateInfo()
			for k,v in pairs(channels) do
				info.text, info.value, info.func, info.checked = v, k, OnClick2, v == current
				UIDropDownMenu_AddButton(info)
			end
		end)
end

local function OnInitialize()
	AwwwwwDB = AwwwwwDB or {}
	for k,v in pairs(defaults) do
	    if type(AwwwwwDB[k]) == "nil" then
	        AwwwwwDB[k] = v
	    end
	end
	
	f.name = "Awwwww!"
	InterfaceOptions_AddCategory(f)
	AddOptions()
	
	f:UnregisterEvent("PLAYER_LOGIN")
	f:RegisterEvent("PLAYER_DEAD")
	f:SetScript("OnEvent", DeathSound)
	
	AddOptions = nil
	OnInitialize = nil
end


f:SetScript("OnEvent", OnInitialize)
f:RegisterEvent("PLAYER_LOGIN")