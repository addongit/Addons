-----------------------------------------------------
-- Theme Definition
-----------------------------------------------------
local Theme = {}
local CopyTable = TidyPlatesUtility.copyTable

local path = "Interface\\Addons\\TidyPlates_Quatre\\Media\\"
local font =					path.."Font.ttf"
--local font =					"FONTS\\ARIALN.TTF"
--local font =					"FONTS\\FRIZQT__.TTF"
--local font =					NAMEPLATE_FONT
local castbarVertical = -15

Theme.frame = {
	width = 100,
	height = 45,
	x = 0,
	y = 0,		-- (-12) To put the bar near the middle
	anchor = "CENTER",
}

Theme.healthborder = {
	texture		 =					path.."RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
}

Theme.target = {
	texture		 =				path.."TargetBox",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true,
}

Theme.highlight = {
	--texture		 =				path.."Highlight",
	texture		 =					path.."RegularBorder",
	width = 128,
	height = 64,
}

Theme.threatborder = {
	texture =			path.."RegularThreatLarger",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
}

Theme.castbar = {
	texture =					path.."Statusbar",
	backdrop = 				path.."Empty",
	height = 8,
	width = 99,
	x = 0,
	y = 15+castbarVertical,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

Theme.castborder = {
	texture =					path.."RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = castbarVertical,
	anchor = "CENTER",
}

Theme.castnostop = {
	texture = 				path.."RegularBorder",
	width = 128,
	height = 64,
	x = 0,
	y = castbarVertical,
	anchor = "CENTER",
}

Theme.name = {
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

Theme.level = {
	typeface =					font,
	size = 11,
	width = 93,
	height = 10,
	x = -2,
	y = 15.5,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false,
}

Theme.healthbar = {
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

Theme.customtext = {
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

Theme.spelltext = {
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

Theme.spellicon = {
	width = 25,
	height = 25,
	x = -67,
	y = 22+castbarVertical,
	anchor = "CENTER",
}
--[[
Theme.eliteicon = {
	texture = path.."Star",
	width = 16,
	height = 16,
	x = -16, -- or -14
	y = 2,
	anchor = "TOPLEFT",
	show = true,
}
--]]
Theme.eliteicon = {
	texture = path.."EliteBorder3",
	width = 128,
	height = 64,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true,
}

Theme.raidicon = {
	width = 20,
	height = 20,
	x = 0,
	y = 36,
	anchor = "CENTER",
}

Theme.skullicon = {
	width = 8,
	height = 8,
	x = 2,
	y = 15,
	anchor = "LEFT",
}

Theme.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 0,},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1,},
	HIGH = {r = 1, g = 0, b = 0, a= 1,},  }

local WidgetConfig = {}
WidgetConfig.ClassIcon = { anchor = "TOP" , x = 0 ,y = 24 }		-- Above Name
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = -26 ,y = 10 }		-- Upper Left on Bar
--WidgetConfig.ClassIcon = { anchor = "TOP" , x = 46 ,y = -8 }		-- Right, Opposite Spell Icon (not done)
WidgetConfig.TotemIcon = { anchor = "TOP" , x = 0 ,y = 24 }
--WidgetConfig.ThreatWidget = { anchor =  "TOP", x = 0 ,y = -7 }
WidgetConfig.ThreatWidget = { anchor =  "TOP", x = 0 ,y = 20 }
WidgetConfig.ComboWidget = { anchor = "TOP" , x = 0 ,y = 0 }
WidgetConfig.RangeWidget = { anchor = "CENTER" , x = 0 ,y = 12 }
WidgetConfig.DebuffWidget = { anchor = "TOP" , x = 15 ,y = 36 }

local ThemeName = "Quatre/|cFFFF4400Damage"
local TankThemeName = "Quatre/|cFF3782D1Tank"

SLASH_QUATRETANK1 = '/quatretank'
SlashCmdList['QUATRETANK'] = ShowTidyPlatesHubTankPanel

SLASH_QUATREDAMAGE = '/quatredamage'
SlashCmdList['QUATREDAMAGE'] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------

TidyPlatesThemeList[ThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function OnApplyThemeCustomization()
	Theme.level.show = (LocalVars.TextShowLevel == true)
	Theme.target.show = (LocalVars.WidgetTargetHighlight == true)
	Theme.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	Theme.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)
	TidyPlates:ForceUpdate()
end

local function OnInitialize(plate)
	TidyPlatesHubFunctions.OnInitializeWidgets(plate, WidgetConfig)
end

local function OnActivateTheme(themeTable)
		if Theme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseDamageVariables()
			OnApplyThemeCustomization()
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
Theme.OnApplyThemeCustomization = OnApplyThemeCustomization -- Called By Hub Panel

do
	local TankTheme = CopyTable(Theme)
	TidyPlatesThemeList[TankThemeName] = TankTheme
	
	local function OnApplyThemeCustomization()
		TankTheme.level.show = (LocalVars.TextShowLevel == true)
		TankTheme.target.show = (LocalVars.WidgetTargetHighlight == true)
		TankTheme.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
		TankTheme.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)
		TidyPlates:ForceUpdate()
	end

	local function OnActivateTheme(themeTable)
		if TankTheme == themeTable then
			LocalVars = TidyPlatesHubFunctions:UseTankVariables()
			OnApplyThemeCustomization()
		end
	end
	
	TankTheme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
	TankTheme.OnApplyThemeCustomization = OnApplyThemeCustomization -- Called By Hub Panel
	TankTheme.ShowConfigPanel = ShowTidyPlatesHubTankPanel
end


