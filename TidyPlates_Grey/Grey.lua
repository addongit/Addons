-----------------------------------------------------
-- Tidy Plates Grey
-----------------------------------------------------
local Theme = {}
local CopyTable = TidyPlatesUtility.copyTable

local defaultArtPath = "Interface\\Addons\\TidyPlates_Grey\\Media"
local font =					defaultArtPath.."\\LiberationSans-Regular.ttf"
local nameplate_verticalOffset = -5
local castBar_verticalOffset = -6 -- Adjust Cast Bar distance

Theme.hitbox = { width = 140, height = 35, }

Theme.highlight = {
	texture =					defaultArtPath.."\\Highlight",
}

Theme.healthborder = {
	texture		 =				defaultArtPath.."\\RegularBorder",
	glowtexture =					defaultArtPath.."\\Highlight",
	--texture =					defaultArtPath.."\\EliteBorder",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.eliteicon = {
	texture = defaultArtPath.."\\EliteIcon",
	width = 14,
	height = 14,
	x = -51,
	y = 17,
	anchor = "CENTER",
	show = true,
}

Theme.target = {
	texture = defaultArtPath.."\\TargetBox",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER",
	show = true,
}

Theme.threatborder = {
	texture =			defaultArtPath.."\\RegularThreat",
	elitetexture =			defaultArtPath.."\\EliteThreat",
	width = 128,
	height = 64,
	x = 0,
	y = nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.castborder = {
	texture =					defaultArtPath.."\\CastStoppable",
	width = 128,
	height = 64,
	x = 0,
	y = 0 +castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.castnostop = {
	texture = 				defaultArtPath.."\\CastNotStoppable",
	width = 128,
	height = 64,
	x = 0,
	y = 0+castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.name = {
	typeface =					font,
	size = 9,
	width = 100,
	height = 10,
	x = 0,
	y = 6+nameplate_verticalOffset,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

Theme.level = {
	typeface =					font,
	size = 9,
	width = 25,
	height = 10,
	x = 36,
	y = 6+nameplate_verticalOffset,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
}

Theme.healthbar = {
	texture =					 defaultArtPath.."\\Statusbar",
	backdrop = 				defaultArtPath.."\\Empty",
	--backdrop = 				defaultArtPath.."\\Statusbar",
	height = 12,
	width = 101,
	x = 0,
	y = 15+nameplate_verticalOffset,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

Theme.castbar = {
	texture =					defaultArtPath.."\\Statusbar",
	backdrop = 				defaultArtPath.."\\Empty",
	--backdrop = 				defaultArtPath.."\\Statusbar",
	height = 12,
	width = 99,
	x = 0,
	y = -8+castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

Theme.customtext = {
	typeface =					font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 16+nameplate_verticalOffset,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true,
}

Theme.spelltext = {
	typeface =					font,
	size = 8,
	width = 100,
	height = 10,
	x = 1,
	y = castBar_verticalOffset-8+nameplate_verticalOffset,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true,
}

Theme.spellicon = {
	width = 18,
	height = 18,
	x = 62,
	y = -8+castBar_verticalOffset+nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.raidicon = {
	width = 20,
	height = 20,
	x = -35,
	y = 12+nameplate_verticalOffset,
	anchor = "TOP",
}

Theme.dangerskull = {
	width = 14,
	height = 14,
	x = 44,
	y = 8+nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.frame = {
	width = 101,
	height = 45,
	x = 0,
	y = 0+nameplate_verticalOffset,
	anchor = "CENTER",
}

Theme.threatcolor = {
	LOW = {r = .6, g = 1, b = 0, a = 1,},
	MEDIUM = {r = .6, g = 1, b = 0, a = 1,},
	HIGH = {r = 1, g = 0, b = 0, a= 1,},  }

local WidgetConfig = {}
WidgetConfig.ClassIcon = { anchor = "TOP" , x = -32 ,y = 7 }
--WidgetConfig.TotemIcon = { anchor = "TOP" , x = -28 ,y = 12 }
WidgetConfig.TotemIcon = { anchor = "TOP" , x = 0 ,y = 10 }
WidgetConfig.ThreatWidget = { anchor =  "CENTER", x = 0 ,y = 18 }
WidgetConfig.ComboWidget = { anchor = "CENTER" , x = 0 ,y = 24 }
WidgetConfig.RangeWidget = { anchor = "CENTER" , x = 0 ,y = 12 }
WidgetConfig.DebuffWidget = { anchor = "CENTER" , x = 15 ,y = 35 }

local ThemeName = "Grey/|cFFFF4400Damage"
local TankThemeName = "Grey/|cFF3782D1Tank"
-- local DamageThemeStyle


SLASH_GREYTANK1 = '/greytank'
SlashCmdList['GREYTANK'] = ShowTidyPlatesHubTankPanel

SLASH_GREYDPS1 = '/greydps'
SlashCmdList['GREYDPS'] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------

TidyPlatesThemeList[ThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function OnApplyThemeCustomization()
	Theme.level.show = (LocalVars.TextShowLevel == true)
	Theme.target.show = (LocalVars.WidgetTargetHighlight == true)
	Theme.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	Theme.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-5
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
		TankTheme.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-5
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







