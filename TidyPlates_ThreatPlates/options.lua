local TidyPlatesThreat = LibStub("AceAddon-3.0"):GetAddon("TidyPlatesThreat");
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Artwork\\"
local db;

-- Reference Tables
local themeList = {'normal', 'tank', 'dps', 'totem','unique'}
local FullAlign = {TOPLEFT = "TOPLEFT",TOP = "TOP",TOPRIGHT = "TOPRIGHT",LEFT = "LEFT",CENTER = "CENTER",RIGHT = "RIGHT",BOTTOMLEFT = "BOTTOMLEFT",BOTTOM = "BOTTOM",BOTTOMRIGHT = "BOTTOMRIGHT"}
local AlignH = {LEFT = "LEFT", CENTER = "CENTER", RIGHT = "RIGHT"}
local AlignV = {BOTTOM = "BOTTOM", CENTER = "CENTER", TOP = "TOP"}
local FontStyle = {
	NONE = "None",
	OUTLINE = "Outline",
	THICKOUTLINE = "Thick Outline",
	["NONE, MONOCHROME"] = "No Outline, Monochrome",
	["OUTLINE, MONOCHROME"] = "Outline, Monochrome",
	["THICKOUTLINE, MONOCHROME"] = "Thick Outline, Monochrome"
}
local DebuffMode = {
	["whitelist"] = "White List",
	["blacklist"] = "Black List",
	["whitelistMine"] = "White List (Mine)",
	["blacklistMine"] = "Black List (Mine)",
	["all"] = "All Debuffs",
	["allMine"] = "All Debuffs (Mine)"
}
local totemID = {
	[1] = {8177,"A1","b8d1ff"},
	[2] = {8512,"A4","b8d1ff"},
	[3] = {3738,"A5","b8d1ff"},
	[4] = {2062,"E1","ffb31f"},
	[5] = {2484,"E2","ffb31f"},
	[6] = {5730,"E3","ffb31f"},
	[7] = {8071,"E4","ffb31f"},
	[8] = {8075,"E5","ffb31f"},
	[9] = {8143,"E6","ffb31f"},
	[10] = {2894,"F1","ff8f8f"},
	[11] = {8227,"F2","ff8f8f"},
	[12] = {8190,"F4","ff8f8f"},
	[13] = {3599,"F5","ff8f8f"},
	[14] = {8184,"W2","2b76ff"},
	[15] = {5394,"W3","2b76ff"},
	[16] = {5675,"W4","2b76ff"},
	[17] = {16190,"W5","2b76ff"},
	[18] = {87718,"W6","2b76ff"}
}
StaticPopupDialogs["TPTP Donate"] = {
	text = GetAddOnMetadata("TidyPlates_ThreatPlates", "title").." v"..GetAddOnMetadata("TidyPlates_ThreatPlates", "version").."\n\nThank you for supporting my work!\n",
	button1 = ACCEPT,
	hasEditBox = 1,
	editBoxWidth = 350,
	OnShow = function(self)
		self.editBox:SetText("http://pledgie.com/campaigns/14853")
		self.editBox:SetFocus()		
	end,
	OnHide = function(self)
		self.editBox:SetText("")
	end,
	OnAccept = function()
	end,
	OnCancel = function()		
	end,
	timeout = 30,
	whileDead = 1,
	hideOnEscape = 1,
}
-- Shared Media Configs
local Media = LibStub("LibSharedMedia-3.0")
local mediaWidgets = Media and LibStub("AceGUISharedMediaWidgets-1.0", true)
Media:Register("statusbar", "ThreatPlatesBar", [[Interface\Addons\TidyPlates_ThreatPlates\Artwork\TP_BarTexture.tga]])
Media:Register("font", "Accidental Presidency",[[Interface\Addons\TidyPlates_ThreatPlates\Fonts\Accidental Presidency.ttf]])

-- Functions
local function GetSpellName(number)
	local n = GetSpellInfo(number)
	return n
end
local function Update()
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end
local function UpdateSpecial()
	db.uniqueSettings.list = {};
	for k_c,k_v in pairs(db.uniqueSettings) do
		if db.uniqueSettings[k_c].name then
			if type(db.uniqueSettings[k_c].name) == "string" then
				db.uniqueSettings.list[k_c] = db.uniqueSettings[k_c].name
			end
		end
	end
end
local function SplitToTable( ... )
	local t = {}
	local index, line
	for index = 1, select("#", ...) do
		line = select(index, ...)
		if line ~= "" then t[line] = true end
	end
	return t
end
local function TableToString(t)
	local list = ""
	for i=1,#t do
		if list then
			if (t[(i+1)] ~= "") then
				list = list..(tostring(t[i])).."\n"
			else 
				list = list..(tostring(t[i]))
			end
		else 
			list = (tostring(t[i])).."\n"
		end
	end
	return list
end
local function ThreatDisabled()
	if db.threat.ON then
		return false
	else
		return true
	end		
end

-- Saved Variables Only

local function GetValue(info)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	if d then
		return db[a][b][c][d]
	elseif c and not d then
		return db[a][b][c]
	elseif b and not d and not c then
		return db[a][b]
	elseif a and not d and not c and not b then
		return db[a]
	end
end

local function SetValue(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	
	if d then
		db[a][b][c][d] = val
	elseif c and not d then
		db[a][b][c] = val
	elseif b and not d and not c then
		db[a][b] = val
	elseif a and not d and not c and not b then
		db[a] = val
	end
	Update()
end

local function GetValueChar(info)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local t = TidyPlatesThreat.db.char
	if d then
		return t[a][b][c][d]
	elseif c and not d then
		return t[a][b][c]
	elseif b and not d and not c then
		return t[a][b]
	elseif a and not d and not c and not b then
		return t[a]
	end
end

local function SetValueChar(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local t = TidyPlatesThreat.db.char
	if d then
		t[a][b][c][d] = val
	elseif c and not d then
		t[a][b][c] = val
	elseif b and not d and not c then
		t[a][b] = val
	elseif a and not d and not c and not b then
		t[a] = val
	end
	Update()
end

-- Colors

local function GetColor(info)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	return color.r, color.g, color.b, color.a
end

local function SetColor(info, r, g, b)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	color.r, color.g, color.b = r,g,b
	Update()
end

local function GetColorAlpha(info)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	return color.r, color.g, color.b, color.a
end

local function SetColorAlpha(info, r, g, b, a)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	color.r, color.g, color.b, color.a = r,g,b,a
	Update()
end

-- Set Theme Values

local function SetThemeValue(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i=1,5 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][b][c] = val
	end
	Update()
end

local function SetThemeValueArt(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i=1,5 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][b][c] = path..val
	end
	Update()
end

-- Shared Media 

local function SetLSMFont(info,val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]	
	db[a][b][c] = val
	for i=1,5 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][b][c] = Media:Fetch('font', db[a][b][c])
	end
	Update()
end

local function SetLSMTexture(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i=1,5 do
		TidyPlatesThemeList['Threat Plates'][themeList[i]][b][c] = Media:Fetch('statusbar', db[a][b][c])
	end
	Update()
end

local function GetToggleNameplate(info)
	return db.nameplate.toggle[info.arg]
end

local function SetToggleNameplate(info)
	db.nameplate.toggle[info.arg] = not db.nameplate.toggle[info.arg]
	Update()
end

-- Return the Options table
local options = nil;
local function GetOptions()
	if not options then
		options = {
			name = GetAddOnMetadata("TidyPlates_ThreatPlates", "title").." v"..GetAddOnMetadata("TidyPlates_ThreatPlates", "version"),
			handler = TidyPlatesThreat,
			type = "group",
			childGroups = "tab",
			args = {
			-- Config Guide
				NameplateSettings = {
					name = "Nameplate Settings",
					type = "group",
					order = 10,
					args = {
						GeneralSettings = {
							name = "General Settings",
							type = "group",
							order = 10,
							args = {
								Hiding = {
									name = "Hiding",
									type = "group",
									order = 1,
									inline = true,
									args = {
										ShowNeutral = {
											type = "toggle",
											order = 1,
											name = "Show Neutral",
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Neutral",
										},
										ShowNormal = {
											type = "toggle",
											order = 2,
											name = "Show Normal",
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Normal",
										},
										ShowElite = {
											type = "toggle",
											order = 3,
											name = "Show Elite",
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Elite",
										},
										ShowBoss = {
											type = "toggle",
											order = 4,
											name = "Show Boss",
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Boss",
										},
									},
								},
								BlizzSettings = {
									name = "Blizzard Settings",
									type = "group",
									order = 2,
									inline = true,
									args = {
										OpenBlizzardSettings = {
											name = "Open Blizzard Settings",
											type = "execute",
											order = 1,
											func = function()
												InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
												LibStub("AceConfigDialog-3.0"):Close("Tidy Plates: Threat Plates");
											end,
										},
										Friendly = {
											type = "group",
											name = "Friendly",
											order = 2,
											inline = true,
											args = {
												nameplateShowFriends = {
													name = "Show Friends",
													type = "toggle",
													order = 1,
													get = function() if GetCVar("nameplateShowFriends") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowFriends", abs(GetCVar("nameplateShowFriends") - 1)) end,
												},
												nameplateShowFriendlyTotems = {
													name = "Show Friendly Totems",
													type = "toggle",
													order = 2,
													get = function() if GetCVar("nameplateShowFriendlyTotems") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowFriendlyTotems", abs(GetCVar("nameplateShowFriendlyTotems") - 1)) end,
												},
												nameplateShowFriendlyPets = {
													name = "Show Friendly Pets",
													type = "toggle",
													order = 3,
													get = function() if GetCVar("nameplateShowFriendlyPets") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowFriendlyPets", abs(GetCVar("nameplateShowFriendlyPets") - 1)) end,
												},
												nameplateShowFriendlyGuardians = {
													name = "Show Friendly Guardians",
													type = "toggle",
													order = 4,
													get = function() if GetCVar("nameplateShowFriendlyGuardians") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowFriendlyGuardians", abs(GetCVar("nameplateShowFriendlyGuardians") - 1)) end,
												},
											},
										},
										Enemy = {
											type = "group",
											name = "Enemy",
											order = 3,
											inline = true,
											args = {
												nameplateShowEnemies = {
													name = "Show Enemies",
													type = "toggle",
													order = 1,
													get = function() if GetCVar("nameplateShowEnemies") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowEnemies", abs(GetCVar("nameplateShowEnemies") - 1)) end,
												},
												nameplateShowEnemyTotems = {
													name = "Show Enemy Totems",
													type = "toggle",
													order = 2,
													get = function() if GetCVar("nameplateShowEnemyTotems") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowEnemyTotems", abs(GetCVar("nameplateShowEnemyTotems") - 1)) end,
												},
												nameplateShowEnemyPets = {
													name = "Show Enemy Pets",
													type = "toggle",
													order = 3,
													get = function() if GetCVar("nameplateShowEnemyPets") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowEnemyPets", abs(GetCVar("nameplateShowEnemyPets") - 1)) end,
												},
												nameplateShowEnemyGuardians = {
													name = "Show Enemy Guardians",
													type = "toggle",
													order = 4,
													get = function() if GetCVar("nameplateShowEnemyGuardians") == "1" then return true else return false end end,
													set = function() SetCVar("nameplateShowEnemyGuardians", abs(GetCVar("nameplateShowEnemyGuardians") - 1)) end,
												},
											},
										},
									},
								},
							},
						},
						HealthBarTexture = {
							name = "Healthbar",
							type = "group",
							inline = false,
							order = 20,
							args = {
								HealthBarGroup = {
									name = "Textures",
									type = "group",
									inline = true,
									order = 10,
									args = {
										HealthBarTexture = {
											name = "Healthbar",
											type = "select",
											width = "double",
											dialogControl = mediaWidgets and "LSM30_Statusbar" or nil,
											order = 1,									
											values = Media:HashTable("statusbar"),
											get = GetValue,
											set = SetLSMTexture,
											arg = {"settings","healthbar", "texture"},
										},
										Header1 = {
											type = "header",
											order = 1.5,
											name = "",
										},
										HealthBorderToggle = {
											type = "toggle",
											width = "double",
											order = 2,
											name = "Show Border",
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","healthborder","show"},
										},
										HealthBorder = {
											type = "select",
											width = "double",
											order = 3,
											name = "Normal Border",
											get = GetValue,
											set = SetThemeValueArt,
											disabled = function() if db.settings.healthborder.show then return false else return true end end,
											values = {TP_HealthBarOverlay = "Default",TP_HealthBarOverlayThin = "Thin"},
											arg = {"settings","healthborder","texture"},
										},
										Header2 = {
											type = "header",
											order = 3.5,
											name = "",
										},
										EliteHealthBorderToggle = {
											type = "toggle",
											width = "double",
											order = 4,
											name = "Show Elite Border",
											get = GetValue,
											set = SetValue,
											arg = {"settings","elitehealthborder","show"},
										},
										EliteBorder = {
											type = "select",
											width = "double",
											order = 5,
											name = "Elite Border",
											get = GetValue,
											set = SetValue,
											disabled = function() if db.settings.elitehealthborder.show then return false else return true end end,
											values = {TP_HealthBarEliteOverlay = "Default",TP_HealthBarEliteOverlayThin = "Thin"},											
											arg = {"settings","elitehealthborder","texture"}
										},
										Header3 = {
											type = "header",
											order = 5.5,
											name = "",
										},
										Mouseover = {
											type = "select",
											width = "double",
											order = 6,
											name = "Mouseover",
											get = GetValue,
											set = SetThemeValueArt,
											values = {TP_HealthBarHighlight = "Default",Empty = "None"},
											arg = {"settings","highlight","texture"},
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 20,
									args = {
										Warning = {
											type = "description",
											order = 1,
											name = "Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r",
										},
										OffsetX = {
											name = "Offset X",
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 2,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","frame","x"},
										},
										Offsety = {
											name = "Offset Y",
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 3,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","frame","y"},
										},
									},
								},
								Coloring = {
									name = "Coloring",
									type = "group",
									inline = true,
									order = 30,
									args = {
										ColorByHPLevel = {
											name = "Color HP by amount",
											type = "toggle",
											desc = "Changes the HP color depending on the amount of HP the nameplate shows.",
											descStyle = "inline",
											width = "full",
											order = 0,
											get = GetValue,
											set = SetValue,
											arg = {"healthColorChange"},
										},
										ClassColors = {
											name = "Class Coloring",
											order = 2,
											type = "group",
											inline = true,
											args = {
												Enemy = {
													name = "Enemy Class Colors",
													type = "group",
													inline = true,
													order = 1,
													disabled = function() if not db.healthColorChange then return false else return true end end,
													args = {
														Enable = {
															name = "Enable Enemy Class colors",
															type = "toggle",
															width = "full",
															get = GetValue,
															set = SetValue,
															order = 1,
															arg = {"allowClass"}
														},
													},
												},
												Friendly = {
													name = "Friendly Class Colors",
													type = "group",
													inline = true,
													order = 2,
													disabled = function() if not db.healthColorChange then return false else return true end end,
													args = {
														FriendlyClass = {
															name = "Enable Friendly Class Colors",
															type = "toggle",
															desc = "Enable the showing of friendly player class color on hp bars.",
															descStyle = "inline",
															width = "full",
															get = GetValue,
															set = SetValue,
															arg = {"friendlyClass"},
														},
														FriendlyCaching = {
															name = "Friendly Caching",
															type = "toggle",
															desc = "This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)",
															descStyle = "inline",
															width = "full",
															disabled = function() if not db.friendlyClass or db.healthColorChange then return true else return false end end,
															get = GetValue,
															set = SetValue,
															arg = {"cacheClass"},
														},
													},
												},
											},
										},
										CustomColors = {
											name = "Custom HP Color",
											order = 3,
											type = "group",
											inline = true,
											args = {
												Enable = {
													name = "Enable Custom HP colors",
													type = "toggle",
													width = "full",
													get = GetValue,
													set = SetValue,
													order = 1,
													arg = {"customColor"}
												},
												Colors = {
													name = "Colors",
													type = "group",
													inline = true,
													order = 2,
													disabled = function() if db.customColor then return false else return true end end,
													args = {
														FriendlyColor = {
															name = "Friendly Color",
															type = "color",
															width = "full",
															get = GetColor,
															set = SetColor,
															arg = {"fHPbarColor"},
														},
														NeutralColor = {
															name = "Neutral Color",
															type = "color",
															width = "full",
															get = GetColor,
															set = SetColor,
															arg = {"nHPbarColor"},
														},
														EnemyColor = {
															name = "Enemy Color",
															type = "color",
															width = "full",
															get = GetColor,
															set = SetColor,
															arg = {"HPbarColor"},
														},
													},
												},
											},
										},
										RaidMarkColors = {
											name = "Raid Mark HP Color",
											order = 4,
											type = "group",
											inline = true,
											args = {
												Enable = {
													name = "Enable Raid Marked HP colors",
													type = "toggle",
													width = "full",
													get = GetValue,
													set = SetValue,
													order = 1,
													arg = {"settings","raidicon","hpColor"},
												},
												Colors = {
													name = "Colors",
													type = "group",
													inline = true,
													order = 2,
													disabled = function() if db.settings.raidicon.hpColor then return false else return true end end,
													get = GetColor,
													set = SetColor,
													args = {
														STAR = {
															type = "color",
															order = 1,
															name = "Star",
															arg = {"settings","raidicon","hpMarked","STAR"},
														},
														MOON = {
															type = "color",
															order = 2,
															name = "Moon",
															arg = {"settings","raidicon","hpMarked","MOON"},
														},
														CIRCLE = {
															type = "color",
															order = 3,
															name = "Circle",
															arg = {"settings","raidicon","hpMarked","CIRCLE"},
														},
														SQUARE = {
															type = "color",
															order = 4,
															name = "Square",
															arg = {"settings","raidicon","hpMarked","SQUARE"},
														},
														DIAMOND = {
															type = "color",
															order = 5,
															name = "Diamond",
															arg = {"settings","raidicon","hpMarked","DIAMOND"},
														},
														CROSS = {
															type = "color",
															order = 6,
															name = "Cross",
															arg = {"settings","raidicon","hpMarked","CROSS"},
														},
														TRIANGLE = {
															type = "color",
															order = 7,
															name = "Triangle",
															arg = {"settings","raidicon","hpMarked","TRIANGLE"},
														},
														SKULL = {
															type = "color",
															order = 8,
															name = "Skull",
															arg = {"settings","raidicon","hpMarked","SKULL"},
														},
													},
												},
											},
										},
										ThreatColors = {
											name = "Threat Colors",
											order = 1,
											type = "group",
											inline = true,
											args = {
												ThreatGlow = {
													type = "toggle",
													width = "double",
													order = 1,
													name = "Show Threat Glow",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","threatborder","show"},
												},
												Header = {
													name = "Colors",
													type = "header",
													order = 2,
												},
												Low = {
													name = "|cff00ff00Low threat|r",
													type = "color",
													order = 3,
													get = GetColorAlpha,
													set = SetColorAlpha,
													arg = {"settings", "normal", "threatcolor", "LOW"},
													hasAlpha = true,
												},
												Med = {
													name = "|cffffff00Medium threat|r",
													type = "color",
													order = 4,
													get = GetColorAlpha,
													set = SetColorAlpha,
													arg = {"settings", "normal", "threatcolor", "MEDIUM"},
													hasAlpha = true,
												},
												High = {
													name = "|cffff0000High threat|r",
													type = "color",
													get = GetColorAlpha,
													set = SetColorAlpha,
													order = 5,
													arg = {"settings", "normal", "threatcolor", "HIGH"},
													hasAlpha = true,
												},
											},
										},
									},
								},
							},
						},
						CastBarSettings = {
							name = "Castbar",
							type = "group",
							order = 30,
							args = {
								Toggles = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 1,
									args = {
										CastbarToggle = {
											name = "Enable",
											type = "toggle",
											order = 1,
											get = function() if GetCVar("ShowVKeyCastbar") == "1" then return true else return false end end,
											set = function(info, val)
												SetCVar("ShowVKeyCastbar", abs(GetCVar("ShowVKeyCastbar")-1))
												Update()
											end,
											arg = {"settings","castbar","show"},
										},
										Header1 = {
											type = "header",
											name = "Non-Target Castbars",
											order = 2,
										},
										SmartCastbarsToggle = {
											name = "Enable",
											type = "toggle",											
											desc = "This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over.",
											descStyle = "inline",
											width = "full",
											order = 4,
											disabled = function() if GetCVar("ShowVKeyCastbar") == "1" then return false else return true end end,
											get = function(info) return TidyPlatesOptions.EnableCastWatcher end,
											set = function(info,val) 
												TidyPlatesOptions.EnableCastWatcher = not TidyPlatesOptions.EnableCastWatcher; 
												if TidyPlatesOptions.EnableCastWatcher then
													TidyPlates:StartSpellCastWatcher()
												else
													TidyPlates:StopSpellCastWatcher()
												end
											end,
										},
									},
								},
								Textures = {
									name = "Textures",
									type = "group",
									inline = true,
									order = 1,
									disabled = function() if GetCVar("ShowVKeyCastbar") == "1" then return false else return true end end,
									args = {
										CastBarTexture = {
											name = "Castbar",
											type = "select",
											width = "double",
											dialogControl = mediaWidgets and "LSM30_Statusbar" or nil,
											order = 1,									
											values = Media:HashTable("statusbar"),
											get = GetValue,
											set = SetLSMTexture,
											arg = {"settings","castbar", "texture"},
										},
										--Header1 = {
											--name = "",
											--type = "header",
											--order = 2,
										--},
										--Border = {
											--name = "Show Castbar Border",
											--type = "toggle",
											--order = 3,
											--get = GetValue,
											--set = function(info,val) 
												--local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
												--db[a][b][c] = val
												--db[a]["castnostop"]["show"] = val
												--for i=1,5 do
													--TidyPlatesThemeList['Threat Plates'][themeList[i]][b][c] = val
													--TidyPlatesThemeList['Threat Plates'][themeList[i]]["castnostop"]["show"] = val
												--end
												--Update()
											--end,
											--arg = {"settings","castborder","show"},
										--},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if GetCVar("ShowVKeyCastbar") == "1" then return false else return true end end,
									args = {
										PlacementX = {
											name = "X",
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 2,
											get = GetValue,
											set = function(info, val)
												local b1 = {}; b1.arg = {"settings","castborder","x"};
												local b2 = {}; b2.arg = {"settings","castnostop","x"};
												SetThemeValue(b1, val)
												SetThemeValue(b2, val)
												SetThemeValue(info, val)
												end,
											arg = {"settings","castbar","x"},
										},
										PlacementY = {
											name = "Y",
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 3,
											get = GetValue,
											set = function(info, val)
												local b1 = {}; b1.arg = {"settings","castborder","y"};
												local b2 = {}; b2.arg = {"settings","castnostop","y"};
												SetThemeValue(b1, val)
												SetThemeValue(b2, val)
												SetThemeValue(info, val)
												end,
											arg = {"settings","castbar","y"},
										},
									},
								},
								Coloring = {
									name = "Coloring",
									type = "group",
									inline = true,
									order = 30,
									args = {
										Enable = {
											name = "Enable Coloring",
											type = "toggle",
											order = 1,
											set = SetValue,
											get = GetValue,
											disabled = function() if GetCVar("ShowVKeyCastbar") == "1" then return false else return true end end,
											arg = {"castbarColor","toggle"},
										},
										Interruptable = {
											name = "Interruptable Casts",
											type = "color",
											order = 2,
											get = GetColorAlpha,
											set = SetColorAlpha,
											disabled = function() if not db.castbarColor.toggle or GetCVar("ShowVKeyCastbar") ~= "1" then return true else return false end end,
											arg = {"castbarColor"},
										},
										Header1 = {
											type = "header",
											order = 3,
											name = "",
										},
										Enable2 = {
											name = "Shielded Coloring",
											type = "toggle",
											order = 4,
											set = SetValue,
											get = GetValue,
											disabled = function() if not db.castbarColor.toggle or GetCVar("ShowVKeyCastbar") ~= "1" then return true else return false end end,
											arg = {"castbarColorShield","toggle"},
										},
										Shielded = {
											name = "Uninterruptable Casts",
											type = "color",
											order = 5,
											get = GetColorAlpha,
											set = SetColorAlpha,
											disabled = function() if GetCVar("ShowVKeyCastbar") ~= "1" or not db.castbarColor.toggle or not db.castbarColorShield.toggle then return true else return false end end,
											arg = {"castbarColorShield"}
										},
									},
								},
							},
						},
						Alpha = {
							name = "Alpha",
							type = "group",
							order = 40,
							args = {
								BlizzFadeEnable = {
									name = "Blizzard Target Fading",
									type = "group",
									order = 1,
									inline = true,
									get = GetValue,
									set = SetValue,									
									args = {
										Enable = {
											name = "Enable Blizzard 'On-Target' Fading",
											type = "toggle",
											desc = "Enabling this will allow you to set the alpha adjustment for non-target nameplates.",
											descStyle = "inline",
											order = 1,
											get = GetValue,
											set = SetValue,
											width = "full",
											arg = {"blizzFade","toggle"},
										},
										Adjustment = {
											name = "Non-Target Alpha",
											type = "range",
											order = 2,
											width = "full",
											disabled = function() if db.blizzFade.toggle then return false else return true end end,
											min = -1,
											max = 0,
											step = 0.01,
											isPercent = true,	
											arg = {"blizzFade","amount"},
										},
									},
								},
								NameplateAlpha = {
									name = "Alpha Settings",
									type = "group",
									order = 2,
									inline = true,
									get = GetValue,
									set = SetValue,
									args = {
										Neutral = {
											type = "range",
											width = "full",
											order = 2,
											name = "Neutral",
											arg = {"nameplate","alpha","Neutral"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true,
										},
										Normal = {
											type = "range",
											width = "full",
											order = 3,
											name = "Normal",	
											arg = {"nameplate","alpha","Normal"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true,
										},
										Elite = {
											type = "range",
											width = "full",
											order = 4,
											name = "Elite",
											arg = {"nameplate","alpha","Elite"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true,
										},
										Boss = {
											type = "range",
											width = "full",
											order = 5,
											name = "Boss",
											arg = {"nameplate","alpha","Boss"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true,
										},
										--Marked = {
											--type = "range",
											--width = "full",
											--order = 5,
											--name = "Marked",
											--arg = {"nameplate","alpha","Marked"},
											--step = 0.05,
											--min = 0,
											--max = 1,
											--isPercent = true,
										--},
									},
								},
							},
						},
						Scale = {
							name = "Scale",
							type = "group",
							order = 50,
							args = {
								NameplateScale = {
									name = "Scale Settings",
									type = "group",
									order = 2,
									inline = true,
									get = GetValue,
									set = SetValue,
									args = {
										Neutral = {
											type = "range",
											width = "full",
											order = 2,
											name = "Neutral",
											arg = {"nameplate","scale","Neutral"},
											step = 0.05,
											softMin = 0.6,
											softMax = 1.3,
											isPercent = true,
										},
										Normal = {
											type = "range",
											width = "full",
											order = 3,
											name = "Normal",	
											arg = {"nameplate","scale","Normal"},
											step = 0.05,
											softMin = 0.6,
											softMax = 1.3,
											isPercent = true,
										},
										Elite = {
											type = "range",
											width = "full",
											order = 4,
											name = "Elite",
											arg = {"nameplate","scale","Elite"},
											step = 0.05,
											softMin = 0.6,
											softMax = 1.3,
											isPercent = true,
										},
										Boss = {
											type = "range",
											width = "full",
											order = 5,
											name = "Boss",
											arg = {"nameplate","scale","Boss"},
											step = 0.05,
											softMin = 0.6,
											softMax = 1.3,
											isPercent = true,
										},
										--Marked = {
											--type = "range",
											--width = "full",
											--order = 5,
											--name = "Marked",
											--arg = {"nameplate","scale","Marked"},
											--step = 0.05,
											--softMin = 0.6,
											--softMax = 1.3,
											--isPercent = true,
										--},
									},
								},
							},
						},
						Nametext = {
							name = "Name Text",
							type = "group",
							order = 60,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Name Text",
											type = "toggle",
											desc = "Enables the showing of text on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","name","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.name.show then return false else return true end end,
									args = {
										FontLooks = {
											name = "Font",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = "Font",
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings","name", "typeface"},
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = 'Font Style',
													desc = "Set the outlining style of the text.",
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name", "flags"},
												},
												Shadow = {
													name = "Enable Shadow",
													order = 4,
													type = "toggle",
													width = "full",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name","shadow"},
												},
												Header1 = {
													type = "header",
													order = 3,
													name = "",
												},
												Color = {
													type = "color",
													order = 3,
													name = "Color",
													width = "full",
													get = GetColor,
													set = SetColor,
													arg = {"settings","name", "color"},
													hasAlpha = false,
												},
											},
										},
										FontSize = {
											name = "Text Bounds and Sizing",
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = "Font Size",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name","size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false,
												},
												TextBounds = {
													name = "Text Boundaries",
													type = "group",
													order = 2,	
													args = {
														Description = {
															type = "description",
															order = 1,
															name = "These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible.",
															width = "full",
														},
														Width = {
															type = "range",
															width = "full",
															order = 2,
															name = "Text Width",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","name","width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false,
														},
														Height = {
															type = "range",
															width = "full",
															order = 3,
															name = "Text Height",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","name","height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false,
														},
													},													
												},
											},											
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												AlignH = {
													name = "Horizontal Align",
													type = "select",
													width = "full",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name","align"},
												},
												AlignV = {
													name = "Vertical Align",
													type = "select",
													width = "full",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","name","vertical"},
												},
											},
										},
									},
								},
							},
						},
						Healthtext = {
							name = "Health Text",
							type = "group",
							order = 70,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Health Text",
											type = "toggle",
											desc = "Enables the showing of text on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","customtext","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.customtext.show then return false else return true end end,
									args = {
										DisplaySettings = {
											name = "Display Settings",
											type = "group",
											order = 0,
											inline = true,
											args = {
												Full = {
													name = "Text at Full HP",
													type = "toggle",
													order = 0,
													width = "full",
													desc = "Display health text on targets with full HP.",
													descStyle = "inline",
													get = GetValue,
													set = SetValue,
													arg = {"text","full"}
												},
												EnablePercent = {
													name = "Percent Text",
													type = "toggle",
													order = 1,
													width = "full",
													desc = "Display health percentage text.",
													descStyle = "inline",
													get = GetValue,
													set = SetValue,
													arg = {"text","percent"}
												},
												EnableAmount = {
													name = "Amount Text",
													type = "toggle",
													order = 2,
													width = "full",
													desc = "Display health amount text.",
													descStyle = "inline",
													get = GetValue,
													set = SetValue,
													arg = {"text","amount"}
												},
												AmountSettings = {
													name = "Amount Text Formatting",
													type = "group",
													order = 3,
													inline = true,
													get = GetValue,
													set = SetValue,
													disabled = function() if not db.text.amount or not db.settings.customtext.show then return true else return false end end,
													args = {
														Truncate = {
															name = "Truncate Text",
															type = "toggle",
															order = 1,
															width = "full",
															desc = "This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts.",
															descStyle = "inline",
															arg = {"text","truncate"}
														},
														MaxHP = {
															name = "Max HP Text",
															type = "toggle",
															order = 2,
															width = "full",
															desc = "This will format text to show both the maximum hp and current hp.",
															descStyle = "inline",
															arg = {"text","max"}
														},
														Deficit = {
															name = "Deficit Text",
															type = "toggle",
															order = 3,
															width = "full",
															desc = "This will format text to show hp as a value the target is missing.",
															descStyle = "inline",
															arg = {"text","deficit"}
														},
													},
												},
												
											},
										},
										FontLooks = {
											name = "Font",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = "Font",
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings","customtext", "typeface"},
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = 'Font Style',
													desc = "Set the outlining style of the text.",
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext", "flags"},
												},
												Shadow = {
													name = "Enable Shadow",
													order = 4,
													type = "toggle",
													width = "full",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext","shadow"},
												},
											},
										},
										FontSize = {
											name = "Text Bounds and Sizing",
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = "Font Size",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext","size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false,
												},
												TextBounds = {
													name = "Text Boundaries",
													type = "group",
													order = 2,	
													args = {
														Description = {
															type = "description",
															order = 1,
															name = "These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible.",
															width = "full",
														},
														Width = {
															type = "range",
															width = "full",
															order = 2,
															name = "Text Width",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","customtext","width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false,
														},
														Height = {
															type = "range",
															width = "full",
															order = 3,
															name = "Text Height",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","customtext","height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false,
														},
													},													
												},
											},											
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												AlignH = {
													name = "Horizontal Align",
													type = "select",
													width = "full",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext","align"},
												},
												AlignV = {
													name = "Vertical Align",
													type = "select",
													width = "full",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","customtext","vertical"},
												},
											},
										},
									},
								},
							},
						},
						SpellText = {
							name = "Spell Text",
							type = "group",
							order = 80,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Spell Text",
											type = "toggle",
											desc = "Enables the showing of spell text on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","spelltext","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.spelltext.show then return false else return true end end,
									args = {
										FontLooks = {
											name = "Font",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = "Font",
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings","spelltext", "typeface"},
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = 'Font Style',
													desc = "Set the outlining style of the text.",
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext", "flags"},
												},
												Shadow = {
													name = "Enable Shadow",
													order = 4,
													type = "toggle",
													width = "full",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext","shadow"},
												},
											},
										},
										FontSize = {
											name = "Text Bounds and Sizing",
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = "Font Size",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext","size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false,
												},
												TextBounds = {
													name = "Text Boundaries",
													type = "group",
													order = 2,	
													args = {
														Description = {
															type = "description",
															order = 1,
															name = "These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible.",
															width = "full",
														},
														Width = {
															type = "range",
															width = "full",
															order = 2,
															name = "Text Width",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","spelltext","width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false,
														},
														Height = {
															type = "range",
															width = "full",
															order = 3,
															name = "Text Height",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","spelltext","height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false,
														},
													},													
												},
											},											
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												AlignH = {
													name = "Horizontal Align",
													type = "select",
													width = "full",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext","align"},
												},
												AlignV = {
													name = "Vertical Align",
													type = "select",
													width = "full",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spelltext","vertical"},
												},
											},
										},
									},
								},
							},
						},
						Leveltext = {
							name = "Level Text",
							type = "group",
							order = 90,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Level Text",
											type = "toggle",
											desc = "Enables the showing of text on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","level","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.level.show then return false else return true end end,
									args = {
										FontLooks = {
											name = "Font",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = "Font",
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings","level", "typeface"},
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = 'Font Style',
													desc = "Set the outlining style of the text.",
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level", "flags"},
												},
												Shadow = {
													name = "Enable Shadow",
													order = 4,
													type = "toggle",
													width = "full",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level","shadow"},
												},
											},
										},
										FontSize = {
											name = "Text Bounds and Sizing",
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = "Font Size",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level","size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false,
												},
												TextBounds = {
													name = "Text Boundaries",
													type = "group",
													order = 2,	
													args = {
														Description = {
															type = "description",
															order = 1,
															name = "These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible.",
															width = "full",
														},
														Width = {
															type = "range",
															width = "full",
															order = 2,
															name = "Text Width",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","level","width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false,
														},
														Height = {
															type = "range",
															width = "full",
															order = 3,
															name = "Text Height",
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings","level","height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false,
														},
													},													
												},
											},											
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												AlignH = {
													name = "Horizontal Align",
													type = "select",
													width = "full",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level","align"},
												},
												AlignV = {
													name = "Vertical Align",
													type = "select",
													width = "full",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","level","vertical"},
												},
											},
										},
									},
								},
							},
						},
						EliteIcon = {
							name = "Elite Icon",
							type = "group",
							order = 100,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Elite Icon",
											type = "toggle",
											desc = "Enables the showing of the elite icon on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","eliteicon","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.eliteicon.show then return false else return true end end,
									args = {
										Texture = {
											name = "Texture",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Preview = {
													name = "Preview",
													type = "execute",
													order = 1,
													image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\"..db.settings.eliteicon.theme,
												},
												Style = {
													type = "select",
													order = 2,
													name = "Elite Icon Style",
													values = {default = "Default",skullandcross = "Skull and Crossbones"},
													get = GetValue,
													set = function(info,val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i=1,5 do
															TidyPlatesThemeList['Threat Plates'][themeList[i]][b]["texture"] = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\"..val
														end
														options.args.NameplateSettings.args.EliteIcon.args.Options.args.Texture.args.Preview.image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\"..val
														Update()
													end,
													arg = {"settings","eliteicon","theme"},
												},
												Header1 = {
													type = "header",
													order = 3,
													name = "",
												},
												Size = {
													name = "Size",
													type = "range",
													width = "full",
													order = 4,
													get = GetValue,
													set = function(info,val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i=1,5 do
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["eliteicon"]["width"] = val
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["eliteicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings","eliteicon","scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false,
												},
											},
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","eliteicon","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","eliteicon","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Anchor = {
													name = "Anchor",
													type = "select",
													width = "full",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","eliteicon","anchor"},
												},
											},
										},
									},
								},
							},
						},
						SkullIcon = {
							name = "Skull Icon",
							type = "group",
							order = 110,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Skull Icon",
											type = "toggle",
											desc = "Enables the showing of the skull icon on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","skullicon","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.skullicon.show then return false else return true end end,
									args = {
										Texture = {
											name = "Texture",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Size = {
													name = "Size",
													type = "range",
													width = "full",
													order = 4,
													get = GetValue,
													set = function(info,val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i=1,5 do
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["skullicon"]["width"] = val
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["skullicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings","skullicon","scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false,
												},
											},
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","skullicon","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","skullicon","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Anchor = {
													name = "Anchor",
													type = "select",
													width = "full",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","skullicon","anchor"},
												},
											},
										},
									},
								},
							},
						},
						SpellIcon = {
							name = "Spell Icon",
							type = "group",
							order = 120,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Spell Icon",
											type = "toggle",
											desc = "Enables the showing of the spell icon on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","spellicon","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.spellicon.show then return false else return true end end,
									args = {
										Texture = {
											name = "Texture",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Size = {
													name = "Size",
													type = "range",
													width = "full",
													order = 4,
													get = GetValue,
													set = function(info,val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i=1,5 do
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["spellicon"]["width"] = val
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["spellicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings","spellicon","scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false,
												},
											},
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spellicon","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spellicon","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Anchor = {
													name = "Anchor",
													type = "select",
													width = "full",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","spellicon","anchor"},
												},
											},
										},
									},
								},
							},
						},
						Raidmarks = {
							name = "Raid Marks",
							type = "group",
							order = 130,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable Raid Mark Icon",
											type = "toggle",
											desc = "Enables the showing of the raid mark icon on nameplates.",
											descStyle = "inline",
											width = "full",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings","raidicon","show"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.settings.raidicon.show then return false else return true end end,
									args = {
										Texture = {
											name = "Texture",
											type = "group",
											inline = true,
											order = 1,
											args = {
												Size = {
													name = "Size",
													type = "range",
													width = "full",
													order = 4,
													get = GetValue,
													set = function(info,val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i=1,5 do
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["raidicon"]["width"] = val
															TidyPlatesThemeList['Threat Plates'][themeList[i]]["raidicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings","raidicon","scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false,
												},
											},
										},
										Placement = {
											name = "Placement",
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = "X",
													type = "range",
													width = "full",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","raidicon","x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Y = {
													name = "Y",
													type = "range",
													width = "full",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","raidicon","y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false,
												},
												Anchor = {
													name = "Anchor",
													type = "select",
													width = "full",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings","raidicon","anchor"},
												},
											},
										},
									},
								},
							},
						},
					},
				},
				ThreatOptions = {
					name = "Threat System",
					type = "group",
					order = 30,
					args = {
						Enable = {
							name = "Enable Threat System",
							type = "toggle",
							order = 1,
							get = GetValue,
							set = SetValue,
							arg = {"threat", "ON"}
						},
						GeneralSettings = {
							name = "General Settings",
							type = "group",
							order = 0,
							disabled = ThreatDisabled,
							args = {
								AdditionalToggles = {
									name = "Additional Toggles",
									type = "group",
									order = 1,
									inline = true,
									args = {
										IgnoreNonCombat = {
											type = "toggle",
											name = "Ignore Non-Combat Threat",
											order = 1,
											width = "full",
											desc = "Disables threat feedback from mobs you're currently not in combat with.",
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat","nonCombat"},
										},
										Neutral = {
											type = "toggle",
											name = "Show Neutral Threat",
											order = 2,
											width = "full",
											desc = "Disables threat feedback from neutral mobs regardless of boss or elite levels.",
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat","toggle","Neutral"},
										},
										Normal = {
											type = "toggle",
											name = "Show Normal Threat",
											order = 3,
											width = "full",
											desc = "Disables threat feedback from normal mobs.",
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat","toggle","Normal"},
										},
										Elite = {
											type = "toggle",
											name = "Show Elite Threat",
											order = 4,
											width = "full",
											desc = "Disables threat feedback from elite mobs.",
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat","toggle","Elite"},
										},
										Boss = {
											type = "toggle",
											name = "Show Boss Threat",
											order = 5,
											width = "full",
											desc = "Disables threat feedback from boss level mobs.",
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat","toggle","Boss"},
										},
									},
								},
							},
						},
						Alpha = {
							name = "Alpha",
							type = "group",
							desc = "Set alpha settings for different threat reaction types.",
							disabled = ThreatDisabled,
							get = GetValue,
							set = SetValue,
							order = 1,
							args = {
								Enable = {
									name = "Enable Alpha Threat",
									type = "group",
									inline = true,
									order = 0,
									args = {
										Enable = {
											type = "toggle",
											name = "Enable",
											desc = "Enable nameplates to change alpha depending on the levels you set below.",
											width = "full",
											descStyle = "inline",
											order = 2,
											arg = {"threat","useAlpha"}
										},
									},
								},
								Tank = {
									name = "|cff00ff00Tank|r",
									type = "group",
									inline = true,
									order = 1,
									disabled = function() if db.threat.useAlpha then return false else return true end end,
									args = {
										Low = {
											name = "|cffff0000Low threat|r",
											type = "range",
											order = 1,
											arg = {"threat", "tank","alpha","LOW"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true,
										},
										Med = {
											name = "|cffffff00Medium threat|r",
											type = "range",
											order = 2,
											arg = {"threat", "tank","alpha","MEDIUM"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true,
										},
										High = {
											name = "|cff00ff00High threat|r",
											type = "range",
											order = 3,
											arg = {"threat", "tank","alpha","HIGH"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true,
										},
									},
								},
								DPS = {
									name = "|cffff0000DPS/Healing|r",
									type = "group",
									inline = true,
									order = 2,
									disabled = function() if db.threat.useAlpha then return false else return true end end,
									args = {
										Low = {
											name = "|cff00ff00Low threat|r",
											type = "range",
											order = 1,
											arg = {"threat", "dps","alpha","LOW"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true,
										},
										Med = {
											name = "|cffffff00Medium threat|r",
											type = "range",
											order = 2,
											arg = {"threat", "dps","alpha","MEDIUM"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true,
										},
										High = {
											name = "|cffff0000High threat|r",
											type = "range",
											order = 3,
											arg = {"threat", "dps","alpha","HIGH"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true,
										},
									},
								},
								Marked = {
									name = "Marked Targets",
									type = "group",
									inline = true,
									order = 3,
									disabled = function() if db.threat.useAlpha then return false else return true end end,
									args = {
										Toggle = {
											name = "Ignore Marked Targets",
											type = "toggle",
											order = 2,
											width = "full",
											desc = "This will allow you to disabled threat alpha changes on marked targets.",
											descStyle = "inline",
											arg = {"threat","marked","alpha"}
										},
										Alpha = {
											name = "Ignored Alpha",
											order = 3,
											type = "range",
											disabled = function() if not db.threat.marked.alpha or not db.threat.useAlpha then return true else return false end end,
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true,
											arg = {"nameplate","alpha","Marked"},
										},
									},
								},
							},
						},
						Scale = {
							name = "Scale",
							type = "group",
							desc = "Set scale settings for different threat reaction types.",
							disabled = ThreatDisabled,
							order = 1,
							get = GetValue,
							set = SetValue,
							args = {
								Enable = {
									name = "Enable Scale Threat",
									type = "group",
									inline = true,
									order = 0,
									args = {
										Enable = {
											type = "toggle",
											name = "Enable",
											desc = "Enable nameplates to change scale depending on the levels you set below.",
											descStyle = "inline",
											width = "full",
											order = 2,
											arg = {"threat","useScale"}
										},
									},
								},
								Tank = {
									name = "|cff00ff00Tank|r",
									type = "group",
									inline = true,
									order = 1,
									disabled = function() if db.threat.useScale then return false else return true end end,
									args = {
										Low = {
											name = "|cffff0000Low threat|r",
											type = "range",
											order = 1,
											arg = {"threat", "tank","scale","LOW"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true,
										},
										Med = {
											name = "|cffffff00Medium threat|r",
											type = "range",
											order = 2,
											arg = {"threat", "tank","scale","MEDIUM"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true,
										},
										High = {
											name = "|cff00ff00High threat|r",
											type = "range",
											order = 3,
											arg = {"threat", "tank","scale","HIGH"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true,
										},
									},
								},
								DPS = {
									name = "|cffff0000DPS/Healing|r",
									type = "group",
									inline = true,
									order = 2,
									disabled = function() if db.threat.useScale then return false else return true end end,
									args = {
										Low = {
											name = "|cff00ff00Low threat|r",
											type = "range",
											order = 1,
											arg = {"threat", "dps","scale","LOW"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true,
										},
										Med = {
											name = "|cffffff00Medium threat|r",
											type = "range",
											order = 2,
											arg = {"threat", "dps","scale","MEDIUM"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true,
										},
										High = {
											name = "|cffff0000High threat|r",
											type = "range",
											order = 3,
											arg = {"threat", "dps","scale","HIGH"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true,
										},
									},
								},
								Marked = {
									name = "Marked Targets",
									type = "group",
									inline = true,
									order = 3,
									disabled = function() if db.threat.useScale then return false else return true end end,
									args = {
										Toggle = {
											name = "Ignore Marked Targets",
											type = "toggle",
											order = 2,
											width = "full",
											desc = "This will allow you to disabled threat scale changes on marked targets.",
											descStyle = "inline",											
											arg = {"threat","marked","scale"}
										},
										Scale = {
											name = "Ignored Scaling",
											type = "range",
											order = 3,
											disabled = function() if not db.threat.marked.scale or not db.threat.useScale then return true else return false end end,
											step = 0.05,
											min = 0.3,
											max = 2,
											isPercent = true,
											arg = {"nameplate","scale","Marked"},
										},
									},
								},
								TypeSpecific = {
									name = "Additional Adjustments",
									type = "group",
									inline = true,
									order = 4,
									disabled = function() if db.threat.useScale then return false else return true end end,
									args = {
										Toggle = {
											name = "Enable Adjustments",
											order = 1,
											type = "toggle",
											width = "full",
											desc = "This will allow you to add additional scaling changes to specific mob types.",
											descStyle = "inline",
											arg = {"threat","useType"}
										},
										AdditionalSliders = {
											name = "Additional Adjustments",
											type = "group",
											order = 3,
											inline = true,
											disabled = function() if not db.threat.useType or not db.threat.useScale then return true else return false end end,
											args = {
												NormalNeutral = {
													name = "Normal & Neutral",
													order = 1,
													type = "range",
													width = "double",
													arg = {"threat","scaleType", "Normal"},
													min = -0.5,
													max = 0.5,
													step = 0.01,
													isPercent = true,
												},
												Elite = {
													name = "Elite",
													order = 2,
													type = "range",
													width = "double",
													arg = {"threat","scaleType", "Elite"},
													min = -0.5,
													max = 0.5,
													step = 0.01,
													isPercent = true,
												},
												Boss = {
													name = "Boss",
													order = 3,
													type = "range",
													width = "double",
													arg = {"threat","scaleType", "Boss"},
													min = -0.5,
													max = 0.5,
													step = 0.01,
													isPercent = true,
												},
											},
										},
									},
								},
							},
						},
						Coloring = {
							name = "Coloring",
							type = "group",
							order = 4,
							disabled = ThreatDisabled,
							args = {
								Toggles = {
									name = "Toggles",
									order = 1,
									type = "group",
									inline = true,
									args = {
										UseHPColor = {
											name = "Color HP by Threat",
											type = "toggle",
											order = 1,
											desc = "This allows HP color to be the same as the threat colors you set below.",
											descStyle = "inline",
											get = GetValue,
											set = SetValue,
											width = "full",
											arg = {"threat","useHPColor"}
										},
									},
								},
								Tank = {
									name = "|cff00ff00Tank|r",
									type = "group",
									inline = true,
									get = GetColorAlpha,
									set = SetColorAlpha,
									order = 2,
									--disabled = function() if db.threat.useHPColor then return false else return true end end,
									args = {
										Low = {
											name = "|cffff0000Low threat|r",
											type = "color",
											order = 1,
											arg = {"settings", "tank", "threatcolor", "LOW"},
											hasAlpha = true,
										},
										Med = {
											name = "|cffffff00Medium threat|r",
											type = "color",
											order = 2,
											arg = {"settings", "tank", "threatcolor", "MEDIUM"},
											hasAlpha = true,
										},
										High = {
											name = "|cff00ff00High threat|r",
											type = "color",
											order = 3,
											arg = {"settings", "tank", "threatcolor", "HIGH"},
											hasAlpha = true,
										},
									},
								},
								DPS = {
									name = "|cffff0000DPS/Healing|r",
									type = "group",
									inline = true,
									get = GetColorAlpha,
									set = SetColorAlpha,
									order = 3,
									--disabled = function() if db.threat.useHPColor then return false else return true end end,
									args = {
										Low = {
											name = "|cff00ff00Low threat|r",
											type = "color",
											order = 1,
											arg = {"settings", "dps", "threatcolor", "LOW"},
											hasAlpha = true,
										},
										Med = {
											name = "|cffffff00Medium threat|r",
											type = "color",
											order = 2,
											arg = {"settings", "dps", "threatcolor", "MEDIUM"},
											hasAlpha = true,
										},
										High = {
											name = "|cffff0000High threat|r",
											type = "color",
											order = 3,
											arg = {"settings", "dps", "threatcolor", "HIGH"},
											hasAlpha = true,
										},
									},
								},
							},							
						},
						DualSpec = {
							name = "Dual Spec Roles",
							type = "group",
							desc = "Set the role your primary and secondary spec represent.",
							disabled = ThreatDisabled,
							order = 5,
							args = {
								Primary = {
									name = "Primary Spec",
									type = "group",
									inline = true,
									order = 1,
									args = {
										Tank = {
											name = "|cff00ff00Tank|r",
											type = "toggle",
											order = 1,
											desc = "Sets your primary spec to tanking.",
											get = function() return TidyPlatesThreat.db.char.spec.primary end,
											set = function(info,val) 
												TidyPlatesThreat.db.char.spec.primary = true
												if GetActiveTalentGroup() == 1 then
													TidyPlatesThreat.db.char.threat.tanking = true
												end
												Update()
											end
										},
										DPS = {
											name = "|cffff0000DPS/Healing|r",
											type = "toggle",
											order = 2,
											desc = "Sets your primary spec to DPS.",
											get = function() return not TidyPlatesThreat.db.char.spec.primary end,
											set = function(info,val) 
												TidyPlatesThreat.db.char.spec.primary = false
												if GetActiveTalentGroup() == 1 then
													TidyPlatesThreat.db.char.threat.tanking = false
												end
												Update()
											end
										},
									},
								},
								Sencondary = {
									name = "Secondary Spec",
									type = "group",
									inline = true,
									order = 2,
									args = {
										Tank = {
											name = "|cff00ff00Tank|r",
											order = 1,
											type = "toggle",
											desc = "Sets your secondary spec to tanking.",
											get = function() return TidyPlatesThreat.db.char.spec.secondary end,
											set = function(info,val) 
												TidyPlatesThreat.db.char.spec.secondary = true
												if GetActiveTalentGroup() == 2 then
													TidyPlatesThreat.db.char.threat.tanking = true
												end
												Update()
											end,
										},
										DPS = {
											name = "|cffff0000DPS/Healing|r",
											order = 2,
											type = "toggle",
											desc = "Sets your secondary spec to DPS.",
											get = function() return not TidyPlatesThreat.db.char.spec.secondary end,
											set = function(info,val) 
												TidyPlatesThreat.db.char.spec.secondary = false
												if GetActiveTalentGroup() == 2 then
													TidyPlatesThreat.db.char.threat.tanking = false
												end									
												Update()
											end,
										},
									},
								},
							},
						},
						Textures = {
							name = "Textures",
							type = "group",
							order = 3,
							desc = "Set threat textures and their coloring options here.",
							disabled = ThreatDisabled,
							args = {
								ThreatArt = {
									name = "Enable",
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = "Enable",
											type = "toggle",
											order = 1,
											desc = "These options are for the textures shown on nameplates at various threat levels.",
											descStyle = "inline",
											width = "full",
											get = GetValue,
											set = SetValue,
											arg = {"threat","art","ON"},
										},
									},
								},
								Options = {
									name = "Art Options",
									type = "group",
									order = 2,
									inline = true,
									disabled = function() if db.threat.art.ON then return false else return true end end,
									get = GetValue,
									set = SetValue,
									args = {
										PrevLow = {
											name = "Low Threat",
											type = "execute",
											order = 1,
											width = "full",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\"..db.threat.art.theme.."\\".."HIGH",
											imageWidth = 256,
											imageHeight = 64,
										},
										PrevMed = {
											name = "Medium Threat",
											type = "execute",
											order = 2,
											width = "full",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\"..db.threat.art.theme.."\\".."MEDIUM",
											imageWidth = 256,
											imageHeight = 64,
										},
										PrevHigh = {
											name = "High Threat",
											type = "execute",
											order = 3,
											width = "full",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\"..db.threat.art.theme.."\\".."LOW",
											imageWidth = 256,
											imageHeight = 64,
										},
										Style = {
											name = "Style",
											type = "group",
											order = 4,
											inline = true,
											args = {
												Dropdown = {
													name = "",
													type = "select",
													order = 1,
													set = function(info,val) 
														SetValue(info,val)
														local i = options.args.ThreatOptions.args.Textures.args.Options.args
														local p = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\"
														i.PrevLow.image = p..db.threat.art.theme.."\\".."HIGH"
														i.PrevMed.image = p..db.threat.art.theme.."\\".."MEDIUM"
														i.PrevHigh.image = p..db.threat.art.theme.."\\".."LOW"
													end,
													values = {default = "Default", bar = "Bar Style"},
													arg = {"threat","art","theme"}
												},
											},
										},
										Marked = {
											name = "Marked Targets",
											type = "group",
											inline = true,
											order = 4,
											args = {
												Toggle = {
													name = "Ignore Marked Targets",
													order = 2,
													type = "toggle",
													desc = "This will allow you to disabled threat art on marked targets.",
													descStyle = "inline",
													width = "full",
													arg = {"threat","marked","art"}
												},
											},
										},
									},
								},
							},
						},
					},
				},
				Widgets = {
					name = "Widgets",
					type = "group",
					order = 40,
					args = {
						ClassIconWidget = {
							name = "Class Icons",
							type = "group",
							order = 0,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											order = 1,
											desc = "This widget will display class icons on nameplate with the settings you set below.",
											descStyle = "inline",
											width = "full",
											set = SetValue,
											get = GetValue,
											arg = {"classWidget", "ON"},
										},
									},
								},
								Options = {
									name = "Options",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if db.classWidget.ON then return false else return true end end,
									args = {
										FriendlyClass = {
											name = "Enable Friendly Icons",
											type = "toggle",
											desc = "Enable the showing of friendly player class icons.",
											descStyle = "inline",
											width = "full",
											get = GetValue,
											set = SetValue,
											arg = {"friendlyClassIcon"},
										},
										FriendlyCaching = {
											name = "Friendly Caching",
											type = "toggle",
											desc = "This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)",
											descStyle = "inline",
											width = "full",
											disabled = function() if not db.friendlyClassIcon or not db.classWidget.ON then return true else return false end end,
											get = GetValue,
											set = SetValue,
											arg = {"cacheClass"}
										},
									},
								},
								Textures = {
									name = "Textures",
									type = "group",
									inline = true,
									order = 30,
									disabled = function() if db.classWidget.ON then return false else return true end end,
									args = {},
								},
								Sizing = {
									name = "Scale",
									type = "group",
									inline = true,
									order = 40,
									disabled = function() if db.classWidget.ON then return false else return true end end,
									args = {
										ScaleSlider = {
											name = "",
											type = "range",
											set = SetValue,
											get = GetValue,
											arg = {"classWidget","scale"}
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 50,
									disabled = function() if db.classWidget.ON then return false else return true end end,
									args = {
										X = {
											name = "X",
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"classWidget", "x"},											
										},
										Y = {
											name = "Y",
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"classWidget", "y"},											
										},
									},
								},
							},
						},
						ComboPointWidget = {
							name = "Combo Points",
							type = "group",
							order = 10,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											order = 1,
											desc = "This widget will display combo points on your target nameplate.",
											descStyle = "inline",
											width = "full",
											set = SetValue,
											get = GetValue,
											arg = {"comboWidget", "ON"},
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if db.comboWidget.ON then return false else return true end end,
									args = {
										X = {
											name = "X",
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"comboWidget", "x"},											
										},
										Y = {
											name = "Y",
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"comboWidget", "y"},											
										},
									},
								},
							},
						},
						DebuffWidget = {
							name = "Debuffs",
							type = "group",
							order = 20,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											order = 1,
											desc = "This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over.",
											descStyle = "inline",
											width = "full",
											arg = {"debuffWidget", "ON"},
										},
									},
								},
								Sizing = {
									name = "Sizing",
									type = "group",
									order = 15,
									inline = true,
									disabled = function() if db.debuffWidget.ON then return false else return true end end,
									args = {
										Scale = {
											name = "Scale",
											type = "range",
											order = 1,
											width = "full",
											softMin = 0.6,
											softMax = 1.3,
											step = 0.05,
											isPercent = true,
											arg = {"debuffWidget","scale",}
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if db.debuffWidget.ON then return false else return true end end,
									args = {
										X = {
											name = "X",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"debuffWidget", "x"},											
										},
										Y = {
											name = "Y",
											type = "range",
											order = 2,
											min = -120,
											max = 120,
											step = 1,
											arg = {"debuffWidget", "y"},											
										},
										Anchor = {
											name = "Anchor",
											type = "select",
											order = 3,
											values = FullAlign,
											arg = {"debuffWidget","anchor"}
										},
									},
								},
								Filtering = {
									name = "filtering",
									order = 30,
									type = "group",
									inline = true,
									disabled = function() if db.debuffWidget.ON then return false else return true end end,
									args = {
										Mode = {
											name = "Mode",
											type = "select",
											order = 1,									
											width = "double",
											values = DebuffMode,
											arg = {"debuffWidget","mode"},
										},
										DebuffList = {
											name = "Filtered Debuffs",
											type = "input",
											order = 2,						
											dialogControl = "MultiLineEditBox",
											width = "full",
											get = function(info) 
												local list = db.debuffWidget.filter; 
												return TableToString(list) 
											end,
											set = function(info, v) 
												local table = {strsplit("\n", v)};
												db.debuffWidget.filter = table 
											end,
										},
									},
								},
							},
						},
						SocialWidget = {
							name = "Social Widget",
							type = "group",
							order = 30,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											desc = "Enables the showing if indicator icons for friends, guildmates, and BNET Friends",
											descStyle = "inline",
											width = "full",
											order = 1,
											arg = {"socialWidget", "ON"},
										},
									},
								},
								Sizing = {
									name = "Scale",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if db.socialWidget.ON then return false else return true end end,
									args = {
										ScaleSlider = {
											name = "",
											type = "range",
											arg = {"socialWidget","scale"}
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 30,
									disabled = function() if db.socialWidget.ON then return false else return true end end,
									args = {
										X = {
											name = "X",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"socialWidget", "x"},											
										},
										Y = {
											name = "Y",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"socialWidget", "y"},											
										},
									},
								},
							},
						},
						ThreatLineWidget = {
							name = "Threat Line",
							type = "group",
							order = 40,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											order = 1,
											desc = "This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates.",
											descStyle = "inline",
											width = "full",
											arg = {"threatWidget", "ON"},
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if db.threatWidget.ON then return false else return true end end,
									args = {
										X = {
											name = "X",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"threatWidget", "x"},											
										},
										Y = {
											name = "Y",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"threatWidget", "y"},											
										},
										Anchor = {
											name = "Anchor",
											type = "select",
											order = 4,
											values = FullAlign,
											arg = {"threatWidget","anchor"}
										},
									},
								},
							},
						},
						TankedWidget = {
							name = "Tanked Targets",
							type = "group",
							order = 50,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									disabled = function() if TidyPlatesThreat.db.char.threat.tanking then return false else return true end end,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											order = 1,
											desc = "This widget will display a small shield or dagger that will indicate if the nameplate is currently being tanked.|cffff00ffRequires tanking role.|r",
											descStyle = "inline",
											width = "full",
											arg = {"tankedWidget", "ON"},
										},
									},
								},
								Sizing = {
									name = "Scale",
									type = "group",
									inline = true,
									order = 20,
									disabled = function() if not db.tankedWidget.ON or not TidyPlatesThreat.db.char.threat.tanking then return true else return false end end,
									args = {
										ScaleSlider = {
											name = "",
											type = "range",
											arg = {"tankedWidget","scale"}
										},
									},
								},
								Placement = {
									name = "Placement",
									type = "group",
									inline = true,
									order = 30,
									disabled = function() if not db.tankedWidget.ON or not TidyPlatesThreat.db.char.threat.tanking then return true else return false end end,
									args = {
										X = {
											name = "X",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"tankedWidget", "x"},											
										},
										Y = {
											name = "Y",
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"tankedWidget", "y"},											
										},
										Anchor = {
											name = "Anchor",
											type = "select",
											order = 4,
											values = FullAlign,
											arg = {"tankedWidget","anchor"}
										},
									},
								},
							},
						},
						TargetArtWidget = {
							name = "Target Highlight",
							type = "group",
							order = 60,
							args = {
								Enable = {
									name = "Enable",
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = "Enable",
											type = "toggle",
											desc = "Enables the showing of a texture on your target nameplate",
											descStyle = "inline",
											width = "full",
											order = 1,
											set = SetValue,
											get = GetValue,
											arg = {"targetWidget", "ON"},
										},
									},
								},
								Texture = {
									name = "Texture",
									type = "group",
									inline = true,
									disabled = function() if db.targetWidget.ON then return false else return true end end,
									args = {
										Preview = {
											name = "Preview",
											order = 0,
											width = "full",
											type = "execute",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\TargetArtWidget\\"..db.targetWidget.theme,
											imageWidth = 256,
											imageHeight = 64,
										},
										Color = {
											name = "Color",
											type = "color",
											width = "full",
											order = 1,
											get = GetColorAlpha,
											set = SetColorAlpha,
											hasAlpha = true,
											arg = {"targetWidget"},
										},
										Select = {
											name = "Style",
											type = "select",
											width = "full",
											order = 3,
											get = GetValue,
											set = function(info,val) 
												SetValue(info,val)
												options.args.Widgets.args.TargetArtWidget.args.Texture.args.Preview.image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\TargetArtWidget\\"..db.targetWidget.theme;
											end,
											values = { default = "Default", arrows = "Arrows", crescent = "Crescent", bubble = "Bubble"},
											arg = {"targetWidget","theme"},
										},										
									},
								},
							},
						},
					},					
				},
				Totems = {
					name = "Totem Nameplates",
					type = "group",
					childGroups = "list",
					order = 50,
					args = {},
				},
				Custom = {
					name = "Custom Nameplates",
					type = "group",
					childGroups = "list",
					order = 60,
					args = {},
				},
				About = {
					name = "About",
					type = "group",
					order = 70,
					args = {
						Donate = {
							name = "Click to Donate!",
							type = "execute",
							order = 1,
							width = "full",
							image = path.."Logo2",
							imageWidth = 256,
							imageHeight = 32,
							func = function()
								StaticPopup_Show("TPTP Donate")
							end,
						},
						AboutInfo = {
							type = "description",
							order = 2,
							width = "full",
							name = "Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00Shamtasticle@gmail.com|r\n\n--Suicidal Katt",
						},
					},
				},
			},
		}
	end
	local ClassOpts_OrderCount = 1
	local ClassOpts = {
		Style = {
			name = "Style",
			order = -1,
			type = "select",
			width = "full",
			get = GetValue,
			set = function(info,val)
				SetValue(info,val)
				for k_c,v_c in pairs(CLASS_SORT_ORDER) do
					options.args.Widgets.args.ClassIconWidget.args.Textures.args["Prev"..k_c].image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ClassIconWidget\\"..db.classWidget.theme.."\\"..CLASS_SORT_ORDER[k_c]
				end
			end,
			values = {default = "Default",transparent = "Transparent"},
			arg = {"classWidget","theme"},
		},
	};
	for k_c,v_c in pairs(CLASS_SORT_ORDER) do
		ClassOpts["Prev"..k_c] = {
			name = CLASS_SORT_ORDER[k_c],
			type = "execute",
			order = ClassOpts_OrderCount,
			image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ClassIconWidget\\"..db.classWidget.theme.."\\"..CLASS_SORT_ORDER[k_c],
		}
		ClassOpts_OrderCount = ClassOpts_OrderCount+1
	end
	options.args.Widgets.args.ClassIconWidget.args.Textures.args = ClassOpts
	local TotemOpts = {
		TotemSettings = {
			name = "|cffffffffTotem Settings|r",
			type = "group",
			order = 10,
			args = {
				Toggles = {
					name = "Toggling",
					type = "group",
					order = 1,
					inline = true,
					args = {
						HideHealth = {
							name = "Hide Healthbars",
							type = "toggle",
							order = 1,
							get = GetValue,
							set = SetValue,
							arg = {"totemSettings","hideHealthbar"},
						},
						Header1 = {
							type = "header",
							order = 2,
							name = "",
						},
						ShowEnemy = {
							name = "Show Enemy Totems",
							type = "toggle",
							order = 3,
							get = function() if GetCVar("nameplateShowEnemyTotems") == "1" then return true else return false end end,
							set = function() SetCVar("nameplateShowEnemyTotems", abs(GetCVar("nameplateShowEnemyTotems") - 1)) end,
						},
						ShowFriend = {
							name = "Show Friendly Totems",
							type = "toggle",
							order = 4,
							get = function() if GetCVar("nameplateShowFriendlyTotems") == "1" then return true else return false end end,
							set = function() SetCVar("nameplateShowFriendlyTotems", abs(GetCVar("nameplateShowFriendlyTotems") - 1)) end,
						},
					},					
				},
				Icon = {
					name = "Icon",
					type = "group",
					order = 2,
					inline = true,
					args = {
						Enable = {
							name = "Enable",
							type = "toggle",
							order = 1,
							set = SetValue,
							get = GetValue,
							arg = {"totemWidget","ON"}
						},
						Options = {
							name = "Options",
							type = "group",
							inline = true,
							order = 2,
							disabled = function() if db.totemWidget.ON then return false else return true end end,
							set = SetValue,
							get = GetValue,
							args = {
								Header1 = {
									type = "header",
									order = 1,
									name = "Placement",
								},
								X = {
									name = "x",
									type = "range",
									order = 2,
									min = -120,
									max = 120,
									step = 1,
									arg = {"totemWidget","x"},
								},
								Y = {
									name = "y",
									type = "range",
									order = 3,
									min = -120,
									max = 120,
									step = 1,
									arg = {"totemWidget","y"},
								},
								Anchor = {
									name = "Anchor",
									type = "select",
									order = 4,
									values = FullAlign,
									arg = {"totemWidget","anchor"}
								},
								Header2 = {
									type = "header",
									order = 4,
									name = "",
								},
								Scale = {
									name = "Icon Size",
									type = "range",
									width = "full",
									order = 5,
									min = 0,
									max = 120,
									step = 1,
									arg = {"totemWidget","scale"},
								},
							},
						},
					},
				},
				Alpha = {
					name = "Alpha",
					type = "group",
					order = 3,
					inline = true,
					get = GetValue,
					set = SetValue,
					args = {
						TotemAlpha = {
							name = "Totem Alpha",
							order = 1,
							type = "range",
							width = "full",
							arg = {"nameplate","alpha","Totem"},
							step = 0.05,
							min = 0,
							max = 1,
							isPercent = true,
						},
					},
				},
				Scale = {
					name = "Scale",
					type = "group",
					order = 4,
					inline = true,
					get = GetValue,
					set = SetValue,
					args = {
						TotemAlpha = {
							name = "Totem Scale",
							order = 1,
							type = "range",
							width = "full",
							arg = {"nameplate","scale","Totem"},
							step = 0.05,
							softMin = 0.6,
							softMax = 1.3,
							isPercent = true,
						},
					},
				},
			},
		},
	};
	local TotemOpts_OrderCnt = 30;	
	for k_c,v_c in ipairs(totemID) do
		TotemOpts[GetSpellName(totemID[k_c][1])] = {
			name = "|cff"..totemID[k_c][3]..GetSpellName(totemID[k_c][1]).."|r",
			type = "group",
			--disabled = function() if db.totemSettings[totemID[k_c][2]][1] then return false else return true end end,
			order = TotemOps_OrderCnt,
			args = {
				Header = {
					name = "> |cff"..totemID[k_c][3]..GetSpellName(totemID[k_c][1]).."|r <",
					type = "header",
					order = 0,
				},
				Enabled = {
					name = "Enable",
					type = "group",
					inline = true,
					order = 1,
					args = {
						Toggle = {
							name = "Show Nameplate",
							type = "toggle",
							set = SetValue,
							get = GetValue,
							arg = {"totemSettings",totemID[k_c][2],1},
						},
					},
				},
				HealthColor = {
					name = "Health Coloring",
					type = "group",
					order = 2,
					inline = true,
					disabled = function() if db.totemSettings[totemID[k_c][2]][1] then return false else return true end end,
					args = {
						Enable = {
							name = "Enable Custom Colors",
							type = "toggle",
							order = 1,
							get = GetValue,
							set = SetValue,
							arg = {"totemSettings",totemID[k_c][2],2},
						},
						Color = {
							name = "Color",
							type = "color",
							order = 2,
							get = GetColor,
							set = SetColor,
							disabled = function() if not db.totemSettings[totemID[k_c][2]][1] or not db.totemSettings[totemID[k_c][2]][2] then return true else return false end end,
							arg = {"totemSettings",totemID[k_c][2],"color"},
						},
					},
				},
				Textures = {
					name = "Textures",
					type = "group",
					order = 3,
					inline = true,
					disabled = function() if db.totemSettings[totemID[k_c][2]][1] then return false else return true end end,
					args = {
						Icon = {
							name = "",
							type = "execute",
							width = "full",
							order = 0,
							image = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\"..db.totemSettings[totemID[k_c][2]][7].."\\"..totemID[k_c][2],
						},
						Style = {
							name = "",
							type = "select",
							order = 1,
							width = "full",
							get = GetValue,
							set = function(info,val) 
								SetValue(info, val)
								options.args.Totems.args[GetSpellName(totemID[k_c][1])].args.Textures.args.Icon.image = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\"..db.totemSettings[totemID[k_c][2]][7].."\\"..totemID[k_c][2];
							end,
							values = {normal = "Normal", special = "Special"},
							arg = {"totemSettings",totemID[k_c][2],7},
						},
					},
				},
			},
		}
		TotemOpts_OrderCnt = TotemOpts_OrderCnt + 10;
	end
	options.args.Totems.args = TotemOpts;
	local CustomOpts_OrderCnt = 30;
	local CustomOpts = {
		GeneralSettings = {
			name = "|cffffffffGeneral Settings|r",
			type = "group",
			order = 10,
			args = {
				Icon = {
					name = "Icon",
					type = "group",
					order = 1,
					inline = true,
					args = {
						Enable = {
							name = "Enable",
							type = "toggle",
							desc = "Disabling this will turn off any all icons without harming custom settings per nameplate.",
							descStyle = "inline",
							width = "full",
							order = 1,
							set = SetValue,
							get = GetValue,
							arg = {"uniqueWidget","ON"}
						},
						Options = {
							name = "Options",
							type = "group",
							inline = true,
							order = 2,
							disabled = function() if db.uniqueWidget.ON then return false else return true end end,
							set = SetValue,
							get = GetValue,
							args = {
								Header1 = {
									type = "header",
									order = 1,
									name = "Placement",
								},
								X = {
									name = "x",
									type = "range",
									order = 2,
									min = -120,
									max = 120,
									step = 1,
									arg = {"uniqueWidget","x"},
								},
								Y = {
									name = "y",
									type = "range",
									order = 3,
									min = -120,
									max = 120,
									step = 1,
									arg = {"uniqueWidget","y"},
								},
								Anchor = {
									name = "Anchor",
									type = "select",
									order = 4,
									values = FullAlign,
									arg = {"uniqueWidget","anchor"}
								},
								Header2 = {
									type = "header",
									order = 4,
									name = "Sizing",
								},
								Scale = {
									name = "",
									type = "range",
									order = 5,
									min = 0,
									max = 120,
									step = 1,
									arg = {"uniqueWidget","scale"},
								},
							},
						},
					},
				},
			},
		},
	};
	local CustomOpts_OrderCnt = 30;	
	for k_c,v_c in ipairs(db.uniqueSettings) do
	CustomOpts["#"..k_c] = {
		name = "#"..k_c..". "..db.uniqueSettings[k_c].name,
		type = "group",
		--disabled = function() if db.totemSettings[totemID[k_c][2]][1] then return false else return true end end,
		order = CustomOpts_OrderCnt,
		args = {
			Header = {
				name = db.uniqueSettings[k_c].name,
				type = "header",
				order = 0,
			},
			Name = {
				name = "Set Name",
				order = 1,
				type = "group",
				inline = true,
				disabled = function() if db.uniqueSettings[k_c].useStyle then return false else return true end end,
				args = {
					SetName = {
						name = db.uniqueSettings[k_c].name,
						type = "input",
						order = 1,
						width = "full",
						get = GetValue,
						set = function(info,val)
							SetValue(info,val)
							options.args.Custom.args["#"..k_c].name = "#"..k_c..". "..val
							options.args.Custom.args["#"..k_c].args.Header.name = val
							options.args.Custom.args["#"..k_c].args.Name.args.SetName.name = val
							UpdateSpecial()
						end,
						arg = {"uniqueSettings",k_c,"name"},
					},
				},
			},
			Enabled = {
				name = "Enable",
				type = "group",
				inline = true,
				order = 2,
				args = {
					UseStyle = {
						name = "Use Custom Settings",
						type = "toggle",
						order = 1,
						set = SetValue,
						get = GetValue,
						arg = {"uniqueSettings",k_c,"useStyle"},
					},
					Header1 = {
						type = "header",
						order = 2,
						name = "",
					},
					Namplate = {
						name = "Show Nameplate",
						type = "toggle",
						disabled = function() if db.uniqueSettings[k_c].useStyle then return false else return true end end,
						order = 3,
						set = SetValue,
						get = GetValue,
						arg = {"uniqueSettings",k_c,"showNameplate"},
					},
					CustomSettings = {
						name = "Custom Settings",
						type = "group",
						inline = true,
						order = 4,
						disabled = function() if not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
						args = {
							AlphaSettings = {
								name = "Alpha Setting",
								type = "group",
								order = 1,
								inline = true,
								set = SetValue,
								get = GetValue,
								args = {
									DisableOverride = {
										name = "Disable Custom Alpha",
										type = "toggle",
										desc = "Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings.",
										descStyle = "inline",
										width = "full",
										order = 1,
										arg = {"uniqueSettings",k_c,"overrideAlpha"},
									},
									AlphaSetting = {
										name = "Custom Alpha",
										type = "range",
										order = 2,
										disabled = function() if db.uniqueSettings[k_c].overrideAlpha or not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
										min = 0,
										max = 1,
										step = 0.05,
										isPercent = true,
										arg = {"uniqueSettings",k_c,"alpha"},
									},
								},
							},
							ScaleSettings = {
								name = "Scale Setting",
								type = "group",
								order = 1,
								inline = true,
								set = SetValue,
								get = GetValue,
								args = {
									DisableOverride = {
										name = "Disable Custom Scale",
										type = "toggle",
										desc = "Disables the custom scale setting for this nameplate and instead uses your normal scale settings.",
										descStyle = "inline",
										width = "full",
										order = 1,
										arg = {"uniqueSettings",k_c,"overrideScale"},
									},
									ScaleSetting = {
										name = "Custom Scale",
										type = "range",
										order = 2,
										disabled = function() if db.uniqueSettings[k_c].overrideScale or not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
										min = 0,
										max = 1,
										step = 0.05,
										isPercent = true,
										arg = {"uniqueSettings",k_c,"scale"},
									},
								},
								
							},
							HealthColor = {
								name = "Health Coloring",
								type = "group",
								order = 3,
								inline = true,
								args = {
									UseRaidMarked = {
										name = "Allow Marked HP Coloring",
										type = "toggle",
										desc = "Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark.",
										descStyle = "inline",
										width = "full",
										order = 1,
										get = GetValue,
										set = SetValue,
										arg = {"uniqueSettings",k_c,"allowMarked"},
									},
									Enable = {
										name = "Enable Custom Colors",
										type = "toggle",
										order = 2,
										width = "full",
										get = GetValue,
										set = SetValue,
										arg = {"uniqueSettings",k_c,"useColor"},
									},
									Color = {
										name = "Color",
										type = "color",
										order = 3,
										get = GetColor,
										set = SetColor,
										disabled = function() if not db.uniqueSettings[k_c].useColor or not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
										arg = {"uniqueSettings",k_c,"color"},
									},
								},
							},
						},
					},
				},
			},
			Icon = {
				name = "Icon",
				type = "group",
				order = 3,
				inline = true,
				disabled = function() if not db.uniqueWidget.ON or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
				args = {
					Enable = {
						name = "Enable",
						type = "toggle",
						order = 1,
						desc = "Enable the showing of the custom nameplate icon for this nameplate.",
						descStyle = "inline",
						width = "full",
						get = GetValue,
						set = SetValue,
						arg = {"uniqueSettings",k_c,"showIcon"}
					
					},
					Icon = {
						name = "Preview",
						type = "execute",
						width = "full",
						disabled = function() if not db.uniqueSettings[k_c].showIcon or not db.uniqueWidget.ON or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
						order = 2,
						image = function() 
							if tonumber(db.uniqueSettings[k_c].icon) == nil then 
								return db.uniqueSettings[k_c].icon 
							else
								local icon = select(3, GetSpellInfo(tonumber(db.uniqueSettings[k_c].icon)))
								if icon then
									return icon
								else
									return "Interface\\Icons\\Temp"
								end
							end
						end,
						imageWidth = 64,
						imageHeight = 64,
					},
					Description = {
						type = "description",
						order = 3,
						name = "Type direct icon texture path using '\\' to separate directory folders, or use a spellid.",
						width = "full",
					},
					SetIcon = {
						name = "Set Icon",
						type = "input",
						order = 4,
						disabled = function() if not db.uniqueSettings[k_c].showIcon or not db.uniqueWidget.ON or not db.uniqueSettings[k_c].showNameplate then return true else return false end end,
						width = "full",
						get = GetValue,
						set = function(info,val)
							SetValue(info,val)
							if tonumber(val) == nil then 
								options.args.Custom.args["#"..k_c].args.Icon.args.Icon.image = val
							else
								local icon = select(3, GetSpellInfo(tonumber(db.uniqueSettings[k_c].icon)))
								if icon then
									options.args.Custom.args["#"..k_c].args.Icon.args.Icon.image = icon
								else
									options.args.Custom.args["#"..k_c].args.Icon.args.Icon.image = "Interface\\Icons\\Temp"
								end
							end
							UpdateSpecial()
						end,
						arg = {"uniqueSettings",k_c,"icon"},
					},
				},
			},
		},
	}
	CustomOpts_OrderCnt = CustomOpts_OrderCnt + 10;
	end
	options.args.Custom.args = CustomOpts;
	return options
end

local intoptions = nil;
local function GetIntOptions()
	if not intoptions then
		intoptions = {
			name = GetAddOnMetadata("TidyPlates_ThreatPlates", "title").." v"..GetAddOnMetadata("TidyPlates_ThreatPlates", "version"),
			handler = TidyPlatesThreat,
			type = "group",
			args = {
				note = {
					type = "description",
					name = "You can access the "..GetAddOnMetadata("TidyPlates_ThreatPlates", "title").." v"..GetAddOnMetadata("TidyPlates_ThreatPlates", "version").." options by typing: /tptp",
					order = 10,
				},
				openoptions = {
					type = "execute",
					name = "Open Config",
					image = path.."Logo",
					width = "full",
					imageWidth = 256,
					imageHeight = 32,
					func = function() 
						TidyPlatesThreat:OpenOptions()
					end,
					order = 20,
				},
			},
		};
	end
	return intoptions;
end

function TidyPlatesThreat:OpenOptions()
	HideUIPanel(InterfaceOptionsFrame)
	HideUIPanel(GameMenuFrame)
	if not options then TidyPlatesThreat:SetUpOptions() end
	LibStub("AceConfigDialog-3.0"):Open("Tidy Plates: Threat Plates");
end

function TidyPlatesThreat:ChatCommand(input)
	TidyPlatesThreat:OpenOptions();
end

function TidyPlatesThreat:ConfigRefresh()
	db = self.db.profile;
	Update()
end

function TidyPlatesThreat:SetUpInitialOptions()
	-- Chat Command
	self:RegisterChatCommand("tptp", "ChatCommand");
	
	-- Interface panel options
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Tidy Plates: Threat Plates Dialog", GetIntOptions);
	
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tidy Plates: Threat Plates Dialog", "Tidy Plates: Threat Plates");
end

function TidyPlatesThreat:SetUpOptions()
	db = self.db.profile;
	
	-- Options Window
	GetOptions();
	UpdateSpecial();
	
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	options.args.profiles.order = 10000;
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Tidy Plates: Threat Plates", options);
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("Tidy Plates: Threat Plates", 750, 600)
end