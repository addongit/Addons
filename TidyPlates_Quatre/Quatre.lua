-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local CopyTable = TidyPlatesUtility.copyTable

local path = "Interface\\Addons\\TidyPlates_Quatre\\Media\\"
local font =					path.."Font.ttf"
local blizzfont =				NAMEPLATE_FONT
--local blizzfont =					"FONTS\\ARIALN.TTF"
--local font =					"FONTS\\FRIZQT__.TTF"
--local font =					NAMEPLATE_FONT

local castbarVertical = -15

local StyleDefault = {}

StyleDefault.frame = {
	width = 100,
	height = 45,
	x = 0,
	y = 0,		-- (-12) To put the bar near the middle
	anchor = "CENTER",
}

StyleDefault.healthborder = {
	texture		 =					path.."RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
}

StyleDefault.target = {
	texture		 =				path.."TargetBox",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true,
}

StyleDefault.highlight = {
	--texture		 =				path.."Highlight",
	texture		 =					path.."RegularBorder",
	width = 128,
	height = 64,
}

StyleDefault.threatborder = {
	texture =			path.."RegularThreatLarger",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
}

StyleDefault.castbar = {
	texture =					path.."Statusbar",
	backdrop = 				path.."Empty",
	height = 8,
	width = 99,
	x = 0,
	y = 15+castbarVertical,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

StyleDefault.castborder = {
	texture =					path.."RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = castbarVertical,
	anchor = "CENTER",
}

StyleDefault.castnostop = {
	texture = 				path.."RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = castbarVertical,
	anchor = "CENTER",
}

StyleDefault.name = {
	typeface =					font,
	size = 12,
	height = 12,
	width = 180,
	x = 0,
	y = 9,
	align = "CENTER",
	anchor = "TOP",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

StyleDefault.level = {
	typeface =					font,
	size = 11,
	width = 93,
	height = 10,
	x = -2,
	y = 14.85,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false,
}

StyleDefault.healthbar = {
	texture =					 path.."Statusbar",
	backdrop = 				path.."StatusbarBackground40",
	--backdrop = 				path.."StatusbarBackground75",
	height = 8.5,
	width = 98.5,
	x = 0,
	y = 15,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

StyleDefault.customtext = {
	typeface =					font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 16,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true,
}

StyleDefault.spelltext = {
	typeface =					font,
	size = 12,
	height = 12,
	width = 180,
	x = 0,
	y = -11 + castbarVertical,
	align = "CENTER",
	anchor = "TOP",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true,
}

StyleDefault.spellicon = {
	width = 25,
	height = 25,
	x = -67,
	y = 22+castbarVertical,
	anchor = "CENTER",
}
--[[
StyleDefault.eliteicon = {
	texture = path.."Star",
	width = 16,
	height = 16,
	x = -16, -- or -14
	y = 2,
	anchor = "TOPLEFT",
	show = true,
}
--]]
StyleDefault.eliteicon = {
	texture = path.."EliteBorder3",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true,
}

StyleDefault.raidicon = {
	width = 25,
	height = 25,
	--x = 0,
	--y = 39,
	x = -55,
	y = 21,
	anchor = "CENTER",
}

StyleDefault.skullicon = {
	width = 8,
	height = 8,
	x = 2,
	y = 15,
	anchor = "LEFT",
}

StyleDefault.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 0,},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1,},
	HIGH = {r = 1, g = 0, b = 0, a= 1,},  }

local WidgetConfig = {}
WidgetConfig.ClassIcon = { anchor = "TOP" , x = 0,y = 26 }		-- Above Name
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = -35 ,y = 14 }		-- Aside Name
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = -26 ,y = 10 }		-- Upper Left on Bar
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = 46 ,y = -8 }		-- Right, Opposite Spell Icon (not done)
WidgetConfig.TotemIcon = { anchor = "TOP" , x = 0 ,y = 26 }
--WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = -7 }
WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = 20 }	-- y = 20
--WidgetConfig.ThreatLineWidget = { anchor =  "TOP", x = 0 ,y = -2 }	-- y = 20
-- WidgetConfig.ThreatWheelWidget = { anchor =  "CENTER", x = 60 ,y = 15 } 
WidgetConfig.ThreatWheelWidget = { anchor =  "CENTER", x = 33 ,y = 27 } -- "CENTER", plate, 30, 18
WidgetConfig.ComboWidget = { anchor = "TOP" , x = 0 ,y = 0 }
WidgetConfig.RangeWidget = { anchor = "CENTER" , x = 0 ,y = 12 }
WidgetConfig.DebuffWidget = { anchor = "TOP" , x = 15 ,y = 33 }

local DamageThemeName = "Quatre/|cFFFF4400Damage"
local TankThemeName = "Quatre/|cFF3782D1Tank"

SLASH_QUATRETANK1 = '/quatretank'
SlashCmdList['QUATRETANK'] = ShowTidyPlatesHubTankPanel

SLASH_QUATREDAMAGE = '/quatredamage'
SlashCmdList['QUATREDAMAGE'] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------
Theme["Default"] = StyleDefault
local function StyleDelegate(unit)
	return "Default"
end
Theme.SetStyle = StyleDelegate

TidyPlatesThemeList[DamageThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function OnApplyThemeCustomization(theme)
	local style = theme["Default"]
	style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-16

	-- [[ Font
	local currentFont = font
	if LocalVars.TextUseBlizzardFont then currentFont = blizzfont end
	style.name.typeface = currentFont
	style.level.typeface = currentFont
	style.customtext.typeface = currentFont
	style.spelltext.typeface = currentFont
	--]]
	
	TidyPlates:ForceUpdate()
end

local function OnApplyDamageCustomization()
	OnApplyThemeCustomization(Theme)
end

local function OnInitialize(plate)
	TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
end

local function OnActivateTheme(themeTable)
		if Theme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseDamageVariables()
			OnApplyDamageCustomization()
		end
end

Theme.SetScale = TidyPlatesHubFunctions.SetScale
Theme.SetAlpha = TidyPlatesHubFunctions.SetAlpha
Theme.SetHealthbarColor = TidyPlatesHubFunctions.SetHealthbarColor
Theme.SetThreatColor = TidyPlatesHubFunctions.SetThreatColor
Theme.SetCastbarColor = TidyPlatesHubFunctions.SetCastbarColor
Theme.SetCustomText = TidyPlatesHubFunctions.SetCustomText
Theme.OnUpdate = TidyPlatesHubFunctions.OnUpdate
Theme.OnContextUpdate = TidyPlatesHubFunctions.OnContextUpdate
Theme.ShowConfigPanel = ShowTidyPlatesHubDamagePanel

Theme.OnInitialize = OnInitialize		-- Need to provide widget positions
Theme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
Theme.OnApplyThemeCustomization = OnApplyDamageCustomization -- Called By Hub Panel

do
	local TankTheme = CopyTable(Theme)
	TidyPlatesThemeList[TankThemeName] = TankTheme
	
	local function OnApplyTankCustomization()
		OnApplyThemeCustomization(TankTheme)  -- OnApplyTankCustomization
	end

	local function OnActivateTheme(themeTable)
		if TankTheme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseTankVariables()
			OnApplyTankCustomization()
		end
	end
	
	TankTheme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
	TankTheme.OnApplyThemeCustomization = OnApplyTankCustomization -- Called By Hub Panel
	TankTheme.ShowConfigPanel = ShowTidyPlatesHubTankPanel
end


