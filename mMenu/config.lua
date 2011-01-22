--------------------------------------------------------------------------------------
-- General Configuration
--------------------------------------------------------------------------------------
mmconfig = {
	menudirection = true,							-- true = menu below the "m" button
													-- false = menu above the "m" button
	hideonclick = true,								-- Hide the menu after clicking a button (hold shift to not hide the menu)

	buttonwidth = 20,								-- "m"enu Button Width	(better use an even number)
	buttonheight = 20,								-- "m"enu Button Height	(better use an even number)

	addonbuttonwidth = 110,							-- Addons-Button Width
	addonbuttonheight = 20,							-- Addons-Button Height

	fontheight = 11,								-- Fontsize
	font = "Interface\\AddOns\\mmenu\\font.ttf",	-- Font

	textcolor = "|cffffffff",						-- Text Color 
	textcolorclicked = "|cffea0606",				-- Text Color mouseover (id try to change the color if the addon is shown but i dont know how ..)

	configBackDropColor = {.2,.2,.2,1 },			-- Frame Background Color
	configBackDropBorderColor = {.4,.4,.4,1 },		-- Frame Border Color
	mouseoverBackdrop = {.1,.1,.1,1 },				-- Mouseover BackdropColor
	mouseoverm = {.9, 0, 0, 1 },					-- Mouseover Color of the "m"
	
	classcolor = false,								-- Classcolored font + texture
	
	fadetime = 0.25,     							-- Fade In or Out Time (in seconds) 0 = no fading

	tukuisupport = true,							-- Tukui support for colors & datatext (["mmenu"])
	WIMSupport = true,								-- WIM support?

	mList = {										-- Manage which Addons will be listed in the "m"enu
		WorldMap = false,
		Bags = false,
		VuhDo = true,
		Grid = true,
		HealBot = true,
		Numeration = true, 
		Skada = true,
		TinyDPS = true,
		Recount = true,
		DBM = true,
		Omen = true,
		Atlas = true,
		Cascade = true,
		TukuiConfig = true,
		Arh = true,
		ReloadUI = true,
		Raidmarkbar = true,
		PhoenixStyle = true,
	},
	
	hideopen = false,								-- Hide the "O"pen all Button?
	openall = {										-- Manage which Addons will be open on the open-all buttons
		WorldMap = false,
		Bags = false,
		VuhDo = true,
		Grid = true,
		HealBot = true,
		Numeration = true, 
		Skada = true,
		TinyDPS = true,
		Recount = true,
		DBM = true,
		Omen = true,
		Atlas = false,
		Cascade = true,
		Arh = false,
		TukuiConfig = false,
		Raidmarkbar = false,
		PhoenixStyle = false,
	},

	hideclose = false,								-- Hide the "C"lose all Button?
	closeall = {									-- Manage which Addons will be close on the close-all buttons
		WorldMap = false,
		Bags = false,
		VuhDo = true,
		Grid = true,
		HealBot = true,
		Numeration = true, 
		Skada = true,	
		TinyDPS = true,
		Recount = true,
		DBM = true,
		Omen = true,
		Atlas = true,
		Cascade = true,
		Arh = false,
		TukuiConfig = true,
		Raidmarkbar = false,
		PhoenixStyle = false,
	},
}
-- if UnitName("player") == "Duffed" or UnitName("player") == "Suq" or UnitName("player") == "Sappy" or UnitName("player") == "Gawk" or UnitName("player") == "Sacerdus" then mmconfig.hideopen = true mmconfig.hideclose = true mmconfig.menudirection = false mmconfig.buttonheight = ActionBar3Background:GetHeight() mmconfig.buttonwidth = 7 end
--------------------------------------------------------------------------------------
-- Extended Configuration
--------------------------------------------------------------------------------------
-- Tukui Support Configuration
--------------------------------------------------------------------------------------

if ( mmconfig.tukuisupport ) then
	if IsAddOnLoaded("Tukui") then
		mmconfig.configBackDropColor = (TukuiCF["media"].backdropcolor)
		mmconfig.configBackDropBorderColor = (TukuiCF["media"].bordercolor)
		--mmconfig.mouseoverBackdrop = {.15,.15,.15,1}
		--mmconfig.mouseoverm = { }
	end
	-- Duffed edit
	if IsAddOnLoaded("Duffed") and IsAddOnLoaded("Tukui") then
		mmconfig.textcolorclicked = panelcolor
		if (TukuiCF["datatext"]["panelcolor"].classcolor) then
			local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
			mmconfig.mouseoverm = {classcolor.r,classcolor.g,classcolor.b,1}
		end
	end
	-- Eclipse edit
	if (IsAddOnLoaded("eTukui_Arena_Layout") or IsAddOnLoaded("eTukui_CombaBar")) and IsAddOnLoaded("Tukui") then
		mmconfig.textcolorclicked = (TukuiCF["datatext"].color)
		if (TukuiCF["datatext"].classcolor) then
			local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
			mmconfig.mouseoverm = {classcolor.r,classcolor.g,classcolor.b,1}
		end
	end
	-- Dunno how to check other edits without a specific Addon like "eTukui_Arena_Layout" 
	
	-- Datatext Button
	if TukuiCF["datatext"].mmenu and TukuiCF["datatext"].mmenu > 0 and IsAddOnLoaded("Tukui") then
		local Stat = CreateFrame("Frame", "mmdatatextbutton", TukuiInfoLeft)
		Stat:EnableMouse(true)
		
		local Text = Stat:CreateFontString(nil, "LOW")
		Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
		Text:SetText(mmconfig.textcolorclicked.."m|r"..mmconfig.textcolor.."Menu|r")
		TukuiDB.PP(TukuiCF["datatext"].mmenu, Text)
		Stat:SetAllPoints(Text)
		
		Stat:SetScript("OnMouseDown", function()
			if menu:IsShown() then
				menu:Hide()
			else
				menu:Show()
				UIFrameFadeIn(menu, mmconfig.fadetime, 0, 1)
			end
		end)
		
		Stat:SetScript("OnEnter", function()
			Text:SetText(mmconfig.textcolorclicked.."mMenu|r")
		end)
		Stat:SetScript("OnLeave", function()
			Text:SetText(mmconfig.textcolorclicked.."m|r"..mmconfig.textcolor.."Menu|r")
		end)
		
		mmconfig.hideopen = true
		mmconfig.hideclose = true
		mmconfig.menudirection = false
	end
end

--------------------------------------------------------------------------------------
-- Classcolor
--------------------------------------------------------------------------------------
if (mmconfig.classcolor) then
	-- this code is copied out of the Tukui Forum posted by .. eh .. cant find the post, sry
	local class = select(2, UnitClass("Player"))
	if class == "DEATHKNIGHT" then
		mmconfig.textcolorclicked = "|cffc41e3c"
	elseif class == "DRUID" then
		mmconfig.textcolorclicked = "|cffff7d0a"
	elseif class == "HUNTER" then
		mmconfig.textcolorclicked = "|cffabd674"
	elseif class == "MAGE" then
		mmconfig.textcolorclicked = "|cff68cdff"
	elseif class == "PALADIN" then
		mmconfig.textcolorclicked = "|cfff58cba"
	elseif class == "PRIEST" then
		mmconfig.textcolorclicked = "|cffd4d4d4"
	elseif class == "ROGUE" then
		mmconfig.textcolorclicked = "|cfffff352"
	elseif class == "SHAMAN" then
		mmconfig.textcolorclicked = "|cff294f9b"
	elseif class == "WARLOCK" then
		mmconfig.textcolorclicked = "|cff9482c9"
	elseif class == "WARRIOR" then
		mmconfig.textcolorclicked = "|cffc79c6e"
	end
	
	-- the "m"
	local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
	mmconfig.mouseoverm = {classcolor.r,classcolor.g,classcolor.b,1}
end