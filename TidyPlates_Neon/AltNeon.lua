
---------------------------------------------
-- Style Definition
---------------------------------------------
local ArtworkPath = "Interface\\Addons\\TidyPlates_Neon\\Media\\"
local fontsize = 13;
local font = ArtworkPath.."Qlassik_TB.ttf";  local NameTextVerticalAdjustment = -9; fontsize = 12;
--local font = ArtworkPath.."AccidentalPresidency.ttf"; local NameTextVerticalAdjustment = -7
--local font = ArtworkPath.."Pakenham.ttf"; local NameTextVerticalAdjustment = -8
local EmptyTexture = ArtworkPath.."Neon_Empty"
local CastBarVerticalAdjustment = -22

---------------------------------------------
-- Default Style
---------------------------------------------
local Theme = {}
local DefaultStyle = {}

DefaultStyle.highlight = {
	texture =					ArtworkPath.."Neon_Highlight",
}

DefaultStyle.healthborder = {
	texture		 =				ArtworkPath.."Neon_HealthOverlay",
	width = 128,
	height = 32,
	y = 0,
	show = true,
}

DefaultStyle.healthbar = {
	texture =					 ArtworkPath.."Neon_Bar",
	backdrop =					 ArtworkPath.."Neon_Bar_Backdrop",
	width = 100,
	height = 32,
	x = 0,
	y = 0,
}
DefaultStyle.castborder = {
	--texture =					ArtworkPath.."Cast_Normal",
	texture =					ArtworkPath.."Neon_HealthOverlay_Stubby",
	width = 128,
	height = 32,
	x = 16,
	y = CastBarVerticalAdjustment,
	show = true,
}

DefaultStyle.castnostop = {
	--texture =					ArtworkPath.."Cast_Shield",
	texture =					ArtworkPath.."Neon_HealthOverlay_Stubby",
	width = 128,
	height = 32,
	x = 16,
	y = CastBarVerticalAdjustment,
	show = true,
}


DefaultStyle.castbar = {
	texture =					 ArtworkPath.."Neon_Bar",
	width = 58,
	height = 32,
	x = 16,
	y = CastBarVerticalAdjustment,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

--[[ Style 1 -----------------------------------------------------------------

DefaultStyle.spellicon = {
	width = 22,
	height = 22,
	x = 64,
	y = CastBarVerticalAdjustment-3,
	anchor = "CENTER",
	show = true,
}

DefaultStyle.spelltext = {
	typeface = font,
	size = fontsize+2,
	width = 200,
	height = 11,
	x = 0,
	y = CastBarVerticalAdjustment+NameTextVerticalAdjustment-1,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	show = true,
}
--]]

-- [[ Style 2 -----------------------------------------------------------------

DefaultStyle.spellicon = {
	width = 26,
	height = 26,
	x = -32+2,
	y = CastBarVerticalAdjustment-12+3,
	anchor = "CENTER",
	show = true,
}

DefaultStyle.spelltext = {
	typeface = font,
	size = fontsize,
	width = 100,
	height = 11,
	x = 40,
	y = CastBarVerticalAdjustment+NameTextVerticalAdjustment,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	show = true,
}
--]]

--[[  Style 3 -----------------------------------------------------------------

DefaultStyle.castborder = {
	texture =					ArtworkPath.."Cast_Normal",
	--texture =					ArtworkPath.."Neon_HealthOverlay",
	width = 128,
	height = 32,
	x = 0,
	y = CastBarVerticalAdjustment,
	show = true,
}

DefaultStyle.castnostop = {
	texture =					ArtworkPath.."Cast_Shield",
	width = 128,
	height = 32,
	x = 0,
	y = CastBarVerticalAdjustment,
	show = true,
}


DefaultStyle.castbar = {
	texture =					 ArtworkPath.."Neon_Bar",
	width = 100,
	height = 32,
	x = 0,
	y = CastBarVerticalAdjustment,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

DefaultStyle.spellicon = {
	width = 15,
	height = 15,
	x = 24,
	y = CastBarVerticalAdjustment,
	anchor = "CENTER",
	show = true,
}

DefaultStyle.spelltext = {
	typeface = font,
	size = 11,
	width = 150,
	height = 11,
	x = 26,
	y = -19+CastBarVerticalAdjustment,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
	show = true,
}

--]]

DefaultStyle.threatborder = {
	-- [[
	texture =				ArtworkPath.."Neon_AggroOverlayWhite",
	width = 256,
	height = 64,
	y = 1,
	-- ]]
	x = 0,	
	show = true,
}


DefaultStyle.target = {
	texture = "Interface\\Addons\\TidyPlates_Neon\\Media\\Neon_Select",
	width = 128,
	height = 32,
	x = 0,
	y = 0,
	anchor = "CENTER",
	show = true,
}

DefaultStyle.raidicon = {
	width = 28,
	height = 28,
	x = 0,
	y = 20,
	anchor = "CENTER",
	show = true,
}

DefaultStyle.eliteicon = {
	texture = ArtworkPath.."Neon_EliteIcon",
	width = 14,
	height = 14,
	x = -44,
	y = 5,
	anchor = "CENTER",
	show = true,
}

DefaultStyle.name = {
	typeface = font,
	size = fontsize,
	width = 200,
	height = 11,
	x = 0,
	y = NameTextVerticalAdjustment,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = true,
}

DefaultStyle.level = {
	typeface = font,
	size = 9,
	width = 22,
	height = 11,
	x = 5,
	y = 5,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "CENTER",
	flags = "OUTLINE",
	shadow = false,
	show = false,
}

DefaultStyle.skullicon = {
	--texture = "",
	width = 14,
	height = 14,
	x = 5,
	y = 5,
	anchor = "LEFT",
	show = false,
}

DefaultStyle.customtext = {
	typeface = font,
	size = 11,
	width = 150,
	height = 11,
	x = 0,
	y = 1,
	align = "CENTER",
	anchor = "CENTER",
	vertical = "CENTER",
	shadow = false,
	flags = "OUTLINE",
	show = true,
}

DefaultStyle.frame = {
	y = 12,
}

local CopyTable = TidyPlatesUtility.copyTable

-- No Bar
local NameOnlyStyle = CopyTable(DefaultStyle)
NameOnlyStyle.healthborder.texture = EmptyTexture
NameOnlyStyle.healthbar.texture = EmptyTexture

-- 58px wide bar
local CompactStyle = CopyTable(DefaultStyle)
CompactStyle.healthborder.texture = ArtworkPath.."Neon_HealthOverlay_Stubby"
CompactStyle.healthbar.width = 58
CompactStyle.highlight.texture = ArtworkPath.."Neon_Stubby_Highlight"
CompactStyle.target.texture = ArtworkPath.."Neon_Stubby_Target"

-- 38px wide bar
local MiniStyle = CopyTable(DefaultStyle)
MiniStyle.healthborder.texture = ArtworkPath.."Neon_HealthOverlay_Very_Stubby"
MiniStyle.healthbar.width = 38
MiniStyle.name.size = 10
--MiniStyle.name.show = false
MiniStyle.highlight.texture = ArtworkPath.."Neon_Very_Stubby_Highlight"
MiniStyle.target.texture = ArtworkPath.."Neon_Very_Stubby_Target"

-- Border Danger Glow 
local DangerStyle = CopyTable(DefaultStyle)
DangerStyle.threatborder = {
	texture =				ArtworkPath.."Neon_Select",
	width = 128,
	height = 32,
	y = 0,
	x = 0,	
	show = true,
}

-- Styles
Theme["Default"] = DefaultStyle
Theme["Compact"] = CompactStyle
Theme["Mini"] = MiniStyle
Theme["NameOnly"] = NameOnlyStyle
Theme["Friendly"] = DangerStyle

-----------------------------------------------------
-- Tidy Plates: Neon/DPS - Theme Definition
-----------------------------------------------------

local IsTotem = TidyPlatesUtility.IsTotem

local function StyleDelegate(unit)
	if IsTotem(unit.name) then return "Mini"
	--elseif unit.reaction == "FRIENDLY" then return "Friendly"
	else return "Default" end
end

Theme.SetStyle = StyleDelegate

------------------------------------------------------------------------------------------

local WidgetConfig = {}
WidgetConfig.ClassIcon = { anchor = "TOP" , x = 30 ,y = -1 }
WidgetConfig.TotemIcon = { anchor = "TOP" , x = 0 ,y = 2 }
WidgetConfig.ThreatWidget = { anchor =  "CENTER", x = 0 ,y = 4 }
WidgetConfig.ComboWidget = { anchor = "CENTER" , x = 0 ,y = 10 }
WidgetConfig.RangeWidget = { anchor = "CENTER" , x = 0 ,y = 0 }
WidgetConfig.DebuffWidget = { anchor = "CENTER" , x = 15 ,y = 20 }

local ThemeName = "Neon/|cFFFF4400Damage"
local TankThemeName = "Neon/|cFF3782D1Tank"

SLASH_NEONTANK1 = '/neontank'
SlashCmdList['NEONTANK'] = ShowTidyPlatesHubTankPanel

SLASH_NEONDPS1 = '/neondps'
SlashCmdList['NEONDPS'] = ShowTidyPlatesHubDamagePanel

---------------------------------------------
-- Tidy Plates Hub Integration
---------------------------------------------

TidyPlatesThemeList[ThemeName] = Theme
local LocalVars = TidyPlatesHubDamageVariables

local function OnApplyThemeCustomization()
	local style = Theme["Default"]
	style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
	style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)
	TidyPlates:ForceUpdate()
	--print(LocalVars.FrameVerticalPosition, style.frame.y)
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
		local style = TankTheme["Default"]
		style.level.show = (LocalVars.TextShowLevel == true)
		style.target.show = (LocalVars.WidgetTargetHighlight == true)
		style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)
		style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)
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

