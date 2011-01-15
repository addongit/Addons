--[[ Initialization Code ]]--
local Archy = LibStub("AceAddon-3.0"):NewAddon("Archy", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0", "LibSink-2.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Archy", false)
local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("Archy", {
	type="data source",
	icon = "Interface\\Icons\\trade_archaeology",
	iconCoords = { 0.075, 0.925, 0.075, 0.925 },
	text = L["Archy"],
})
local icon = LibStub("LibDBIcon-1.0")
local astrolabe = DongleStub("Astrolabe-1.0")
local qtip = LibStub("LibQTip-1.0")

_G["Archy"] = Archy

Archy.version = GetAddOnMetadata("Archy", "Version")

--[[ Variable declarations ]]--
local db
local MAX_ARCHAEOLOGY_RANK = 525
local SITES_PER_CONTINENT = 4
local rank, maxRank
local confirmArgs, requiresConfirm
local raceDataLoaded = false
local archRelatedBagUpdate = false
local keystoneLootRaceID = nil
local playerContinent
local siteStats, siteBlacklist
local lastSite, nearestSite, playerPosition, surveyPosition = {}, nil, { map = 0, level = 0, x = 0,  y = 0 }, { map = 0, level = 0, x = 0,  y = 0 }
local zoneData, siteData, raceData, currencyData, artifacts, digsites = {}, {}, {}, {}, {}, {}
local tomtomPoint, tomtomActive, tomtomExists, tomtomFrame, tomtomSite
local distanceIndicatorActive = false

local emptySiteStats = { ['surveys'] = 0, ['fragments'] = 0, ['looted'] = 0, ['keystones'] = 0, ['counter'] = 0 }
local emptySite = { ['continent'] = 0, ['map'] = 0, ['blob'] = 0, ['race'] = 0 }
local emptyZone = { ['continent'] = 0, ['map'] = 0, ['level'] = 0, ['mapFile'] = '', ['id'] = 0, ['name'] = '' }
local artifactSolved = { ['raceId'] = 0, ['name'] = '' }
local continentMapToID = {}
local mapFileToID = {}
local mapIDToZone = {}
local mapIDToZoneName = {}
local zoneIDToName = {}
local raceNameToID = {}
local currencyIDToRaceID = {}
local keystoneIDToRaceID = {}
local minimapSize = {}

local Arrow_OnUpdate, POI_OnEnter, POI_OnLeave, GetArchaeologyRank, SolveRaceArtifact
local ClearTomTomPoint, UpdateTomTomPoint, RefreshTomTom
local RefreshBlobInfo, MinimapBlobSetPositionAndSize, UpdateSiteBlobs
local CreateMinimapPOI, UpdateMinimapEdges, UpdateMinimapPOIs
local AnnounceNearestSite, ResetPositions, UpdateRaceArtifact, ShowDistanceIndicator, HideDistanceIndicator
local inCombat = false
local TrapWorldMouse

local digsiteFrame = {}
local distanceIndicatorFrame = {}
local racesFrame = {}

--[[ Archy variables ]]--
Archy.LastSurveySite = lastSite
Archy.NearestSite = nearestSite
Archy.PlayerPosition = playerPosition
Archy.LastSurveyPosition = surveyPosition
Archy.RaceData = raceData
Archy.ZoneData = zoneData
Archy.SiteData = siteData
Archy.CurrentSites = digsites
Archy.CurrentArtifacts = artifacts
Archy.CurrencyData = currencyData


--[[ Default profile values ]]--
local defaults = {
	profile = {
		general = {
			enabled = true,
			show = true,
			stealthMode = false,
			icon = { hide = false },
			locked = true,
			confirmSolve = true,
			showSkillBar = true,
			sinkOptions = { },
			easyCast = false,
			autoLoot = true,
		},
		artifact = {
			show = true,
			position = { "TOPRIGHT", "TOPRIGHT", -200, -425 },
			anchor = "TOPRIGHT",
			positionX = 100,
			positionY = -300,
			scale = 1,
			alpha = 1,
			filter = true,
			announce = true,
			keystoneAnnounce = true,
			ping = true,
			keystonePing = true,
			blacklist = {},
			autofill = {},
			style = "Compact",
			borderAlpha = 1,
			bgAlpha = 1,
			nameFontSize = 14,
			nameFontOutline = "OUTLINE",
			keystoneFontSize = 14,
			keystoneFontOutline = "OUTLINE",
			fragmentBarColors = {
				["Normal"] = { r = 1, g = 0.5, b = 0 },
				["Solvable"] = { r = 0, g = 1, b = 0 },
				["Rare"] = { r = 0, g = 0.4, b = 0.8 },
				["AttachToSolve"] = { r = 1, g = 1, b = 0 },
				["FirstTime"] = { r = 1, g = 1, b = 1 },
			},
		},
		digsite = {
			show = true,
			position = { "TOPRIGHT", "TOPRIGHT", -200, -200 },
			anchor = "TOPRIGHT",
			positionX = 400,
			positionY = -300,
			scale = 1,
			alpha = 1,
			style = "Extended", 
			sortByDistance = true,
			announceNearest = true,
			distanceIndicator = {
				enabled = true,
				green = 40,
				yellow = 80,
				position = { "CENTER", "CENTER", 0, 0 },
				anchor = "TOPLEFT",
				undocked = false,
				showSurveyButton = true,
			},
			filterLDB = false,
			borderAlpha = 1,
			bgAlpha = 1,
			nameFontSize = 16,
			nameFontOutline = "",
			zoneFontSize = 12,
			zoneFontOutline = "",
		},
		minimap = {
			show = true,
			nearest = true,
			fragmentNodes = true,
			fragmentIcon = "CyanDot",
			blob = false,
			zoneBlob = false,
			blobAlpha = 0.25,
			blobDistance = 400,
			useBlobDistance = true,
		},
		tomtom = {
			enabled = true,
			distance = 125,
			ping = true,
		},
	},
}

--[[ Keybinds ]]
BINDING_HEADER_ARCHY = L["Archy"]
BINDING_NAME_OPTIONS = L["BINDING_NAME_OPTIONS"]
BINDING_NAME_TOGGLE  = L["BINDING_NAME_TOGGLE"]
BINDING_NAME_SOLVE   = L["BINDING_NAME_SOLVE"]
BINDING_NAME_SOLVE_WITH_KEYSTONES   = L["BINDING_NAME_SOLVESTONE"]
BINDING_NAME_ARTIFACTS = L["BINDING_NAME_ARTIFACTS"]
BINDING_NAME_DIGSITES = L["BINDING_NAME_DIGSITES"]

--[[ Config Options ]]--
local fragmentIconValues = {
	["CyanDot"]		= L["Light Blue Dot"],
	["Cross"]		= L["Cross"],
}
local frameAnchorOptions = {
	["TOPLEFT"]	= L["Top Left"],
	["TOPRIGHT"]	= L["Top Right"],
	["BOTTOMRIGHT"]	= L["Bottom Right"],
	["BOTTOMLEFT"]  = L["Bottom Left"],
}
local outlines = {
	[""]             = L["None"],
	["OUTLINE"]      = L["Outline"],
	["THICKOUTLINE"] = L["Thick Outline"],
}

local generalOptions = {
	type = "group",
	order = 1,
	name = L["General"],
	desc = L["General Options"],
	args = {
		desc = {
			order = 0,
			type = "description",
			name = L["Archy"],
		},
		show = {
			order = 1,
			name = L["Show Archy"],
			desc = L["Toggle the display of Archy"],
			type = "toggle",
			get = function() return db.general.show end,
			set = function(_, value) 
				db.general.show = value
				Archy:ConfigUpdated()
			end,
		},
		reset = {
			order = 2,
			name = L["Reset Positions"],
			desc = L["Reset the window positions to defaults"],
			type = "execute",
			func = function()
				ResetPositions()
			end,
		},
		lock = {
			order = 3,
			name = L["Lock Positions"],
			desc = L["Locks the windows so they cannot be repositioned by accident"],
			type = "toggle",
			get = function() return db.general.locked end,
			set = function(_, value)
				db.general.locked = value
				Archy:ConfigUpdated()
			end,
			width = "double"
		},
		icon = {
			order = 4,
			name = L["Hide Minimap Button"],
			desc = L["Toggles the display of the Minimap Icon"],
			type = "toggle",
			get = function() return db.general.icon.hide end,
			set = function(k, v) 
				db.general.icon.hide = v; 
				if db.general.icon.hide then
					icon:Hide("ArchyLDB")
				else
					icon:Show("ArchyLDB")
				end
			end,
			width = "double"
		},
		easyCast = {
			order = 6,
			name = L["Enable EasyCast"],
			desc = L["Double right-click on the screen to cast Survey.  This is experimental and may interfere with other addons with similar functionality when enabled."],
			type = "toggle",
			get = function() return db.general.easyCast end,
			set = function(_, value) 
				db.general.easyCast = value
				Archy:ConfigUpdated()
			end,
			width = "full",
		},	
		autoLoot = {
			order = 7,
			name = L["AutoLoot Fragments and Key Stones"],
			desc = L["Enable the addon to auto-loot fragments and key stones for you."],
			type = "toggle",
			get = function() return db.general.autoLoot end,
			set = function(_, value) 
				db.general.autoLoot = value
				Archy:ConfigUpdated()
			end,
			width = "full",
		},	
	},
}

local artifactOptions = {
	order = 2,
	type = "group",
	childGroups = "tab",
	name = L["Artifacts"],
	desc = L["Artifact Options"],
	args = {
		options = {
			name = L["General"],
			order = 0,
			type = "group",
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of the Artifact options"],
				},
				show = {
					order = 1,
					type = "toggle",
					name = L["Show"],
					desc = L["Toggles the display of the Artifacts list"],
					get = function() return db.artifact.show end,
					set = function(_, value)
						db.artifact.show = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				filter = {
					order = 2,
					type = "toggle",
					name = L["Filter by Continent"],
					desc = L["Filter the Artifact list by races on the continent"],
					get = function() return db.artifact.filter end,
					set = function(_, value)
						db.artifact.filter = value
						Archy:ConfigUpdated('artifact')
					end,					
					disabled = function() return not db.artifact.show end,
				},
				announce = {
					order = 3,
					type = "toggle",
					name = L["Announce when solvable"],
					desc = L["Announce in the chat window when an artifact can be solved with fragments"],
					get = function() return db.artifact.announce end,
					set = function(_, value)
						db.artifact.announce = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				keystoneAnnounce = {
					order = 4,
					type = "toggle",
					name = L["Include key stones"],
					desc = L["Announce in the chat window when an artifact can be solved with fragments and key stones"],
					get = function() return db.artifact.keystoneAnnounce end,
					set = function(_, value)
						db.artifact.keystoneAnnounce = value
						Archy:ConfigUpdated('artifact')
					end,
					disabled = function() return not db.artifact.announce end,
				},
				ping = {
					order = 5,
					type = "toggle",
					name = L["Play sound when solvable"],
					desc = L["Play a sound when an artifact can be solved with fragments"],
					get = function() return db.artifact.ping end,
					set = function(_, value)
						db.artifact.ping = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				keystonePing = {
					order = 6,
					type = "toggle",
					name = L["Include key stones"],
					desc = L["Play a sound when an artifact can be solved with fragments and key stones"],
					get = function() return db.artifact.keystonePing end,
					set = function(_, value)
						db.artifact.keystonePing = value
						Archy:ConfigUpdated('artifact')
					end,
					disabled = function() return not db.artifact.ping end,
				},
				confirmSolve = {
					order = 6.5,
					type = "toggle",
					name = L["Confirm solves near skill cap"],
					desc = L["Ask for confirmation when your skill nears the cap.  When enabled, no confirmation is needed for Illustrious Archaeologists."],
					get = function() return db.general.confirmSolve end,
					set = function(_, value)
						db.general.confirmSolve = value
						Archy:ConfigUpdated()
					end,
					width = "full",
				},
				showSkillBar = {
					order = 7,
					name = L["Show Archaeology Skill"],
					desc = L["Show your Archaeology skill on the Artifacts list header"],
					type = "toggle",
					get = function() return db.general.showSkillBar end,
					set = function(_, value) 
						db.general.showSkillBar = value
						Archy:ConfigUpdated()
					end,
					width = "double",
				},	
			},
		},
		blacklist = {
			order = 1,
			type = "group",
			name = L["Blacklist"],
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Allows you to blacklist races from being used by Archy"],
				},
				races = {
					order = 1,
					type = "multiselect",
					tristate = false,
					name = L["Races"],
					desc = L["Select races to blacklist"],
					values = function() 
						local races = {}
						for rid, race in pairs(raceData) do
							races[rid] = race['name']
						end
						return races
					end,
					get = function(info, key) return db.artifact.blacklist[key] end,
					set = function(info, key, value) 
						db.artifact.blacklist[key] = value 
						Archy:ConfigUpdated('artifact')
					end,
					width = "full",
				},
			},
		},
		autofill = {
			order = 2,
			type = "group",
			name = L["AutoFill Key Stones"],
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Allows Archy to autofill key stones as you receive them for you on the races you specify"],
				},
				races = {
					order = 1,
					type = "multiselect",
					tristate = false,
					name = L["Races"],
					desc = L["Select races to autofill"],
					values = function() 
						local races = {}
						for rid, race in pairs(raceData) do
							races[rid] = race['name']
						end
						return races
					end,
					get = function(info, key) return db.artifact.autofill[key] end,
					set = function(info, key, value) 
						db.artifact.autofill[key] = value 
						Archy:ConfigUpdated('artifact', 'autofill')
					end,
					width = "full",
				},
			},
		},
		displayOptions = {
			name = L["Display Options"],
			order = 4,
			type = "group",
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of how the Artifacts list is displayed"],
				},
				scale = {
					order = 7,
					type = "range",
					name = L["Size"],
					desc = L["Set how large the Artifacts list is"],
					min = 0.25, max = 4, step = 0.01, bigStep = 0.05,
					get = function() return db.artifact.scale end,
					set = function(_, value)
						db.artifact.scale = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				alpha = {
					order = 8,
					type = "range",
					name = L["Opacity"],
					desc = L["Set how transparent or opaque the Artifacts list is"],
					min = 0.25, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.artifact.alpha end,
					set = function(_, value)
						db.artifact.alpha = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				anchor = {
					order	= 9,
					type	= "select",
					name	= L["Anchor"],
					desc	= L["The corner of the Artifacts list that the frame will grow from."],
					get	= function() return db.artifact.anchor end,
					set	= function(_, value) 
						db.artifact.anchor = value
						Archy:SaveFramePosition(racesFrame)
					end,
					values	= frameAnchorOptions,
				},
				space = {
					order = 12,
					type = "description",
					name = "",
				},
				borderAlpha = {
					order = 13,
					type = "range",
					name = L["Border Opacity"],
					desc = L["Set how transparent or opaque the border for the Artifacts list is"],
					min = 0.01, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.artifact.borderAlpha end,
					set = function(_, value)
						db.artifact.borderAlpha = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				bgAlpha = {
					order = 14,
					type = "range",
					name = L["Background Opacity"],
					desc = L["Set how transparent or opaque the background for the Artifacts list is"],
					min = 0.01, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.artifact.bgAlpha end,
					set = function(_, value)
						db.artifact.bgAlpha = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				space2 = {
					order = 15,
					type = "description",
					name = " ",
				},
				nameFontSize = {
					order = 16,
					type = "range",
					name = L["Name Font Size"],
					desc = L["Control the font size of the artifact name"],
					min = 4, max = 30, step = 1,
					get = function() return db.artifact.nameFontSize end,
					set = function(_, value)
						db.artifact.nameFontSize = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				nameFontOutline = {
					order = 16.5,
					type = "select",
					name = L["Name Font Outline"],
					desc = L["The outline that the artifact name will use"],
					values = outlines,
					get = function() return db.artifact.nameFontOutline end,
					set = function(_, value)
						db.artifact.nameFontOutline = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				keystoneFontSize = {
					order = 17,
					type = "range",
					name = L["Fragment Font Size"],
					desc = L["Control the font size of the fragment progress"],
					min = 4, max = 30, step = 1,
					get = function() return db.artifact.keystoneFontSize end,
					set = function(_, value)
						db.artifact.keystoneFontSize = value
						Archy:ConfigUpdated('artifact')
					end,
				},
				keystoneFontOutline = {
					order = 17.5,
					type = "select",
					name = L["Fragment Font Outline"],
					desc = L["The outline that the fragment progress will use"],
					values = outlines,
					get = function() return db.artifact.keystoneFontOutline end,
					set = function(_, value)
						db.artifact.keystoneFontOutline = value
						Archy:ConfigUpdated('artifact')
					end,
				},


				fragmentBarColor = {
					order = 31,
					name = L["Progress Bar Color"],
					desc = L["Set the color of the progress bar for artifacts you are working on"],
					type = "color",
					get = function(info)
						return db.artifact.fragmentBarColors["Normal"].r, db.artifact.fragmentBarColors["Normal"].g, db.artifact.fragmentBarColors["Normal"].b
					end,
					set = function(info, r, g, b)
						db.artifact.fragmentBarColors["Normal"].r = r
						db.artifact.fragmentBarColors["Normal"].g = g
						db.artifact.fragmentBarColors["Normal"].b = b
						Archy:ConfigUpdated('artifact', 'color')
					end,
				},
				fragmentBarFirstTimeColor = {
					order = 32,
					name = L["First Time Color"],
					desc = L["Set the color of the progress bar for artifacts you are working on for the first time"],
					type = "color",
					get = function(info)
						return db.artifact.fragmentBarColors["FirstTime"].r, db.artifact.fragmentBarColors["FirstTime"].g, db.artifact.fragmentBarColors["FirstTime"].b
					end,
					set = function(info, r, g, b)
						db.artifact.fragmentBarColors["FirstTime"].r = r
						db.artifact.fragmentBarColors["FirstTime"].g = g
						db.artifact.fragmentBarColors["FirstTime"].b = b
						Archy:ConfigUpdated('artifact', 'color')
					end,
				},
				fragmentBarSolvableColor = {
					order = 33,
					name = L["Solvable Color"],
					desc = L["Set the color of the progress bar for artifacts you can solve"],
					type = "color",
					get = function(info)
						return db.artifact.fragmentBarColors["Solvable"].r, db.artifact.fragmentBarColors["Solvable"].g, db.artifact.fragmentBarColors["Solvable"].b
					end,
					set = function(info, r, g, b)
						db.artifact.fragmentBarColors["Solvable"].r = r
						db.artifact.fragmentBarColors["Solvable"].g = g
						db.artifact.fragmentBarColors["Solvable"].b = b
						Archy:ConfigUpdated('artifact', 'color')
					end,
				},
				fragmentBarRareColor = {
					order = 34,
					name = L["Rare Color"],
					desc = L["Set the color of the progress bar for rare artifacts you are working on"],
					type = "color",
					get = function(info)
						return db.artifact.fragmentBarColors["Rare"].r, db.artifact.fragmentBarColors["Rare"].g, db.artifact.fragmentBarColors["Rare"].b
					end,
					set = function(info, r, g, b)
						db.artifact.fragmentBarColors["Rare"].r = r
						db.artifact.fragmentBarColors["Rare"].g = g
						db.artifact.fragmentBarColors["Rare"].b = b
						Archy:ConfigUpdated('artifact', 'color')
					end,
				},
				fragmentBarKeystoneColor = {
					order = 35,
					name = L["Solvable With Key Stone Color"],
					desc = L["Set the color of the progress bar for artifacts could solve if you attach key stones to them"],
					type = "color",
					get = function(info)
						return db.artifact.fragmentBarColors["AttachToSolve"].r, db.artifact.fragmentBarColors["AttachToSolve"].g, db.artifact.fragmentBarColors["AttachToSolve"].b
					end,
					set = function(info, r, g, b)
						db.artifact.fragmentBarColors["AttachToSolve"].r = r
						db.artifact.fragmentBarColors["AttachToSolve"].g = g
						db.artifact.fragmentBarColors["AttachToSolve"].b = b
						Archy:ConfigUpdated('artifact', 'color')
					end,
				},
				
				
				
				
			},				
		},
	},
}
local digsiteOptions = {
	order = 3,
	type = "group",
	childGroups = "tab",
	name = L["Dig Sites"],
	desc = L["Dig Site Options"],
	args = {
		options = {
			name = L["General"],
			order = 0,
			type = "group",
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of the Dig Site options"],
				},
				show = {
					order = 1,
					type = "toggle",
					name = L["Show"],
					desc = L["Toggles the display of the Dig Sites list"],
					get = function() return db.digsite.show end,
					set = function(_, value)
						db.digsite.show = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				filterLDB = {
					order = 1.5,
					type = "toggle",
					name = L["Filter LDB to Continent"],
					desc = L["Filter the LDB tooltip to only include the current continent"],
					get = function() return db.digsite.filterLDB end,
					set = function(_, value)
						db.digsite.filterLDB = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				sortByDistance = {
					order = 2,
					type = "toggle",
					name = L["Sort by distance"],
					desc = L["Sort the dig sites by your distance to them"],
					get = function() return db.digsite.sortByDistance end,
					set = function(_, value)
						db.digsite.sortByDistance = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				announceNearest = {
					order = 3,
					type = "toggle",
					name = L["Announce Nearest Dig Site"],
					desc = L["Announces the nearest dig site when it is found"],
					get = function() return db.digsite.announceNearest end,
					set = function(_, value)
						db.digsite.announceNearest = value
						Archy:ConfigUpdated('digsite')
					end,
				},
			},
		},
		distanceIndicator = {
			name = L["Survey Distance Indicator"],
			order = 1,
			type = "group",
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of Survey Distance Indicator options"],
				},
				enable = {
					order = 1,
					type = "toggle",
					name = L["Enable"],
					desc = L["Enable the Survey Distance Indicator"],
					get = function() return db.digsite.distanceIndicator.enabled end,
					set = function(_, value)
						db.digsite.distanceIndicator.enabled = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				showSurveyButton = {
					order = 1.5,
					type = "toggle",
					name = L["Show Survey Button"],
					desc = L["Shows a Survey button with the Distance Indicator."],
					get = function() return db.digsite.distanceIndicator.showSurveyButton end,
					set = function(_, value)
						db.digsite.distanceIndicator.showSurveyButton = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				docked = {
					order = 2,
					type = "toggle",
					name = L["Undock"],
					desc = L["Undock the survey distance indicator from the Dig Sites list"],
					get = function() return db.digsite.distanceIndicator.undocked end,
					set = function(_, value)
						db.digsite.distanceIndicator.undocked = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				anchor = {
					order	= 2.5,
					type	= "select",
					name	= L["Anchor"],
					desc	= L["The corner of the survey distance indicator that the frame will anchor from."],
					get	= function() return db.digsite.distanceIndicator.anchor end,
					set	= function(_, value) 
						db.digsite.distanceIndicator.anchor = value
						Archy:SaveFramePosition(distanceIndicatorFrame)
					end,
					values	= frameAnchorOptions,
					disabled = function() return not db.digsite.distanceIndicator.undocked end,
				},
				space = {
					order = 3,
					type = "description",
					name = "",
				},
				green = {
					order = 5,
					type = "range",
					name = L["Green Distance Radius"],
					desc = L["Set how large the green area of the survey distance indicator will use"],
					min = 1, max = 200, step = 1,
					get = function() return db.digsite.distanceIndicator.green end,
					set = function(_, value)
						db.digsite.distanceIndicator.green = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				yellow = {
					order = 6,
					type = "range",
					name = L["Yellow Distance Radius"],
					desc = L["Set how large the yellow area of the survey distance indicator will use"],
					min = 1, max = 200, step = 1,
					get = function() return db.digsite.distanceIndicator.yellow end,
					set = function(_, value)
						db.digsite.distanceIndicator.yellow = value
						Archy:ConfigUpdated('digsite')
					end,
				},
			},
		},
		displayOptions = {
			name = L["Display Options"],
			order = 2,
			type = "group",
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of how the Dig Site list is displayed"],
				},
				scale = {
					order = 7,
					type = "range",
					name = L["Size"],
					desc = L["Set how large the Dig Site list is"],
					min = 0.25, max = 4, step = 0.01, bigStep = 0.05,
					get = function() return db.digsite.scale end,
					set = function(_, value)
						db.digsite.scale = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				alpha = {
					order = 8,
					type = "range",
					name = L["Opacity"],
					desc = L["Set how transparent or opaque the Dig Site list is"],
					min = 0.25, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.digsite.alpha end,
					set = function(_, value)
						db.digsite.alpha = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				anchor = {
					order	= 9,
					type	= "select",
					name	= L["Anchor"],
					desc	= L["The corner of the Dig Sites list that the frame will grow from."],
					get	= function() return db.digsite.anchor end,
					set	= function(_, value) 
						db.digsite.anchor = value
						Archy:SaveFramePosition(digsiteFrame)
					end,
					values	= frameAnchorOptions,
				},
				space2 = {
					order = 12,
					type = "description",
					name = "",
				},
				borderAlpha = {
					order = 13,
					type = "range",
					name = L["Border Opacity"],
					desc = L["Set how transparent or opaque the border for the Dig Sites list is"],
					min = 0.01, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.digsite.borderAlpha end,
					set = function(_, value)
						db.digsite.borderAlpha = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				bgAlpha = {
					order = 14,
					type = "range",
					name = L["Background Opacity"],
					desc = L["Set how transparent or opaque the background for the Dig Sites list is"],
					min = 0.01, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.digsite.bgAlpha end,
					set = function(_, value)
						db.digsite.bgAlpha = value
						Archy:ConfigUpdated('digsite')
					end,
				},
				space = {
					order = 15,
					type = "description",
					name = " ",
					width = "full", 
				},
				nameFontSize = {
					order = 16,
					type = "range",
					name = L["Name Font Size"],
					desc = L["Control the font size of the dig site name"],
					min = 4, max = 30, step = 1,
					get = function() return db.digsite.nameFontSize end,
					set = function(_, value)
						db.digsite.nameFontSize = value
						Archy:ConfigUpdated('digsite', 'font')
					end,
				},
				nameFontOutline = {
					order = 16.5,
					type = "select",
					name = L["Name Font Outline"],
					desc = L["The outline that the dig site name will use"],
					values = outlines,
					get = function() return db.digsite.nameFontOutline end,
					set = function(_, value)
						db.digsite.nameFontOutline = value
						Archy:ConfigUpdated('digsite', 'font')
					end,
				},
				zoneFontSize = {
					order = 17,
					type = "range",
					name = L["Zone Font Size"],
					desc = L["Control the font size of the zone and distance"],
					min = 4, max = 30, step = 1,
					get = function() return db.digsite.zoneFontSize end,
					set = function(_, value)
						db.digsite.zoneFontSize = value
						Archy:ConfigUpdated('digsite', 'font')
					end,
				},
				zoneFontOutline = {
					order = 17.5,
					type = "select",
					name = L["Zone Font Outline"],
					desc = L["The outline that the zone and distance will use"],
					values = outlines,
					get = function() return db.digsite.zoneFontOutline end,
					set = function(_, value)
						db.digsite.zoneFontOutline = value
						Archy:ConfigUpdated('digsite', 'font')
					end,
				},
			},
		},
	},
}
local archyDataOptions = {
	order = 6,
	type = "group",
	name = "ArchyData",
	disabled = function() 
		local _, _, _, enabled, _, reason, _ = GetAddOnInfo("Archy_Data")
		return not enabled or (reason ~= nil)
	end,
	args = {
		desc = {
			order = 0,
			type = "description",
			name = L["Import Survey Node data from ArchyData"],
		},
		loadData = {
			order = 5,
			name = L["Import ArchyData"],
			desc = L["Load ArchyData and import the data to your database."],
			type = "execute",
			func = function()
				local loaded, reason = LoadAddOn("Archy_Data")
				if loaded then
					local ArchyData = LibStub("AceAddon-3.0"):GetAddon("Archy_Data")
--					local dataVersion = tonumber(GetAddOnMetadata("Archy_Data", "X-Generated-Version"):match("%d+")) 
					ArchyData:PerformImport(true)
					Archy:Print(L["ArchyData has been imported."])
					Archy:ConfigUpdated()
					if not db.data then db.data = {} end
--					db.data.lastImport = dataVersion
					db.data.imported = true
				else
					Archy:Print(L["Failed to load ArchyData due to "]..reason)
				end
			end,
			disabled = function()
				local _, _, _, enabled, _, reason, _ = GetAddOnInfo("Archy_Data")
				return not enabled or (reason ~= nil) or (db.data and db.data.imported)
			end,
		},		
	},
}
local tomtomOptions = {
	order = 4,
	type = "group",
	name = L["TomTom"],
	desc = L["TomTom Options"],
	args = {
		desc = {
			order = 0,
			type = "description",
			name = L["Control various aspects of TomTom integration"],
		},
		enable = {
			order = 1,
			type = "toggle",
			name = L["Enable TomTom integration"],
			desc = L["Toggle if Archy will send the nearest dig site waypoint information to TomTom"],
			width = "double",
			get = function() return db.tomtom.enabled end,
			set = function(_, value)
				db.tomtom.enabled = value
				Archy:ConfigUpdated('tomtom')
			end,
		},
		arrivalDistance = {
			order = 2,
			type = "range",
			name = L["\"Arrival Distance\""],
			desc = L["This setting will control the distance at which the waypoint arrow switches to a downwards arrow, indicating you have arrived at your destination.\nNOTE: This may not work with emulation addons if they do not support this."],
			min = 0, max = 150, step = 5,
			get = function() return db.tomtom.distance end,
			set = function(_, value)
				db.tomtom.distance = value
				Archy:ConfigUpdated('tomtom')
			end,
			disabled = function() return not db.tomtom.enabled or not tomtomExists end,
--			width = "double"
		},
		arrivalPing = {
			order = 3,
			type = "toggle",
			name = L["Play a sound when arriving at a waypoint"],
			desc = L["When you 'arrive' at a waypoint (this distance is controlled by the 'Arrival Distance' setting in this group) a sound can be played to indicate this.  You can enable or disable this sound using this setting."],
			width = "double",
			get = function() return db.tomtom.ping end,
			set = function(_, value)
				db.tomtom.ping = value
				Archy:ConfigUpdated('tomtom')
			end,
			disabled = function() return not db.tomtom.enabled or not tomtomExists  end,
			width = "double"
		},
	},
}
local minimapOptions = {
	order = 5,
	type = "group",
	childGroups = "tab",
	name = L["Minimap"],
	desc = L["Minimap Options"],
	args = {
		options = {
			name = L["General"],
			order = 0,
			type = "group",
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of Minimap options"],
				},
				show = {
					order = 1,
					type = "toggle",
					name = L["Show Dig Sites"],
					desc = L["Show your dig sites on the minimap"],
					get = function() return db.minimap.show end,
					set = function(_, value)
						db.minimap.show = value
						Archy:ConfigUpdated('minimap')
					end,
				},
				nearest = {
					order = 2,
					type = "toggle",
					name = L["Nearest only"],
					desc = L["Show only the nearest dig site on the minimap"],
					get = function() return db.minimap.nearest end,
					set = function(_, value)
						db.minimap.nearest = value
						Archy:ConfigUpdated('minimap')
					end,
					disabled = function() return not db.minimap.show end,
				},
				fragmentNodes = {
					order = 3,
					type = "toggle",
					name = L["Show Fragment Nodes"],
					desc = L["Show the locations where you have collected fragments"],
					get = function() return db.minimap.fragmentNodes end,
					set = function(_, value)
						db.minimap.fragmentNodes = value
						Archy:ConfigUpdated('minimap')
					end,
					width = "double",
				},
				fragmentIcon = {
					order = 3.5,
					name = L["Node Icon"],
					desc = L["Icon to use for the fragment node icon"],
					type = "select",
					values = fragmentIconValues,
					get = function() return db.minimap.fragmentIcon end,
					set = function(_, value)
						db.minimap.fragmentIcon = value
						Archy:ConfigUpdated('minimap')
					end,
				},
			},
		},
		blobs = {
			name = L["Dig Site Boundaries"],
			order = 1,
			type = "group",
			args = {
				blob = {
					order = 4,
					type = "toggle",
					name = L["Show Dig Site Boundaries on minimap"],
					desc = L["Show the dig site boundaries on the minimap"],
					width = "double",
					get = function() return db.minimap.blob end,
					set = function(_, value)
						db.minimap.blob = value
						Archy:ConfigUpdated('minimap')
					end,
					width = "full",
				},
				zoneMapBlob = {
					order = 5,
					type = "toggle",
					name = L["Show Dig Site Boundaries on battlefield map"],
					desc = L["Show the dig site boundaries on the battlefield map"],
					width = "double",
					get = function() return db.minimap.zoneBlob end,
					set = function(_, value)
						db.minimap.zoneBlob = value
						Archy:ConfigUpdated('minimap')
					end,
					width = "full",
				},
				blobAlpha = {
					order = 6,
					type = "range",
					name = L["Opacity"],
					desc = L["Set how transparent or opaque the Dig Site boundaries are"],
					min = 0.25, max = 1, step = 0.01, bigStep = 0.05,
					get = function() return db.minimap.blobAlpha end,
					set = function(_, value)
						db.minimap.blobAlpha = value
						Archy:ConfigUpdated('minimap')
					end,
					disabled = function() return not db.minimap.blob and not db.minimap.zoneBlob end,
				},
				useBlobDistance = {
					order = 4.4,
					type = "toggle",
					name = L["Enable \"Arrival Distance\""],
					desc = L["This setting will control the distance at which the minimap blob will become visible.\nNOTE: This is a semi-workaround for the boundaries exceeding the minimap area."],
					get = function() return db.minimap.useBlobDistance end,
					set = function(_, value)
						db.minimap.useBlobDistance = value
						Archy:ConfigUpdated('minimap')
					end,
					disabled = function() return not db.minimap.blob end,
					width = "full",
				},
				blobDistance = {
					order = 4.5,
					type = "range",
					name = L["\"Arrival Distance\""],
					desc = L["This setting will control the distance at which the minimap blob will become visible.\nNOTE: This is a semi-workaround for the boundaries exceeding the minimap area."],
					min = 0, max = 550, step = 5,
					get = function() return db.minimap.blobDistance end,
					set = function(_, value)
						db.minimap.blobDistance = value
						Archy:ConfigUpdated('minimap')
					end,
					disabled = function() return not db.minimap.blob or not db.minimap.useBlobDistance end,
--					width = "double"
				},
			},
		},
	},
}

--[[ Function locals ]]--
local floor = floor
local GetCurrentMapContinent, GetCurrentMapAreaID, GetCurrentMapDungeonLevel, GetMapContinents, GetMapInfo, GetMapZones, IsInInstance, GetNumMapLandmarks, GetMapLandmarkInfo, UpdateMapHighlight = GetCurrentMapContinent, GetCurrentMapAreaID, GetCurrentMapDungeonLevel, GetMapContinents, GetMapInfo, GetMapZones, IsInInstance, GetNumMapLandmarks, GetMapLandmarkInfo, UpdateMapHighlight
local GetNumArchaeologyRaces, GetNumArtifactsByRace, GetArchaeologyRaceInfo, ArchaeologyMapUpdateAll, ArcheologyGetVisibleBlobID, RequestArtifactCompletionHistory = GetNumArchaeologyRaces, GetNumArtifactsByRace, GetArchaeologyRaceInfo, ArchaeologyMapUpdateAll, ArcheologyGetVisibleBlobID, RequestArtifactCompletionHistory
local GetCurrencyListSize, GetCurrencyInfo, GetItemInfo, InCombatLockdown, GetProfessions, GetProfessionInfo = GetCurrencyListSize, GetCurrencyInfo, GetItemInfo, InCombatLockdown, GetProfessions, GetProfessionInfo


--[[ Meta Tables ]]--
setmetatable(raceData, { __index = function(t,k) 
	if GetNumArchaeologyRaces() == 0 then return end
	local raceName, currencyID, raceTexture, itemID = GetArchaeologyRaceInfo(k)
	local currencyName = GetCurrencyInfo(currencyID)
	local itemName, _, _, _, _, _, _, _, _, itemTexture, _ = GetItemInfo(itemID)
	t[k] = { ['name'] = raceName, ['currency'] = { ['id'] = currencyID, ['name'] = currencyName }, ['texture'] = raceTexture, ['keystone'] = { ['id'] = itemID, ['name'] = itemName, ['texture'] = itemTexture, ['inventory'] = 0 } }
	return t[k]
end })

setmetatable(zoneData, { __index = function(t,k) if k then DEFAULT_CHAT_FRAME:AddMessage("Archy is missing data for zone "..k) end; return emptyZone end })
setmetatable(siteData, { __index = function(t,k) if k then DEFAULT_CHAT_FRAME:AddMessage("Archy is missing data for dig site " .. k) end; return emptySite end })
setmetatable(artifacts, { __index = function(t,k) if k then t[k] = { ['name'] = '', ['rare'] = false, ['tooltip'] = '', ['icon'] = '', ['sockets'] = 0, ['stonesAdded'] = 0, ['fragments'] = 0, ['fragAdjust'] = 0, ['fragTotal'] = 0, ['canSolve'] = false, ['canSolveStone'] = false, ['ping'] = false }; return t[k]; end end })


local blobs = setmetatable({}, { 
__index = function(t, k)
	local f = CreateFrame("ArchaeologyDigSiteFrame", "Archy" .. k .. "_Blob")
	rawset(t, k, f)
	f:ClearAllPoints()
	f:EnableMouse(false)
	f:SetFillAlpha(256 * db.minimap.blobAlpha)
	f:SetFillTexture("Interface\\WorldMap\\UI-ArchaeologyBlob-Inside")
	f:SetBorderTexture("Interface\\WorldMap\\UI-ArchaeologyBlob-Outside")
	f:EnableSmoothing(true)
	f:SetBorderScalar(0.1)
	f:Hide()
	return f
end })

local pois = setmetatable( {}, { 
__index = function(t, k)
	local poi = CreateFrame("Frame", "ArchyMinimap_POI"..k, Minimap)
	poi:SetWidth(10)
	poi:SetHeight(10)
	poi:SetScript("OnEnter", POI_OnEnter)
	poi:SetScript("OnLeave", POI_OnLeave)

	local arrow = CreateFrame("Frame", nil, poi)
	arrow:SetPoint("CENTER", poi)
	arrow:SetScript("OnUpdate", Arrow_OnUpdate)
	arrow:SetWidth(32)
	arrow:SetHeight(32)
	
	local arrowtexture = arrow:CreateTexture(nil, "OVERLAY")
	arrowtexture:SetTexture([[Interface\Minimap\ROTATING-MINIMAPGUIDEARROW.tga]]) -- [[Interface\Archeology\Arch-Icon-Marker.blp]])
	arrowtexture:SetAllPoints(arrow)
	arrow.texture = arrowtexture
	arrow.t = 0
	arrow.poi = poi
	arrow:Hide()
	poi.useArrow = false
	poi.arrow = arrow	
	return poi
end })




--[[ Pre load tables ]]--
do 
	-- cache the zone/map data
	local orig = GetCurrentMapAreaID()
	for cid, cname in pairs{GetMapContinents()} do
		SetMapZoom(cid)
		local mapid = GetCurrentMapAreaID()
		continentMapToID[mapid] = cid
		local cmn = GetMapInfo()
		zoneData[mapid] = { ['continent'] = cid, ['map'] = mapid, ['level'] = 0, ['mapFile'] = cmn, ['id'] = 0, ['name'] = cname }
		mapFileToID[cmn] = mapid
		mapIDToZoneName[mapid] = cname
		for zid, zname in pairs{GetMapZones(cid)} do
			SetMapZoom(cid, zid)
			local mapid = GetCurrentMapAreaID()
			local level = GetCurrentMapDungeonLevel()
			mapFileToID[GetMapInfo()] = mapid
			mapIDToZone[mapid] = zid
			mapIDToZoneName[mapid] = zname
			zoneIDToName[zid] = zname
			zoneData[mapid] = { ['continent'] = zid, ['map'] = mapid, ['level'] = level, ['mapFile'] = GetMapInfo(), ['id'] = zid, ['name'] = zname }
		end
	end
	SetMapByID(orig)

	-- Load the site data
	siteData[L["Ironband's Excavation Site"]] = { ['continent'] = 2, ['map'] = 35, ['blob'] = 54097, ['race'] = 1 } 
	siteData[L["Ironbeard's Tomb"]] = { ['continent'] = 2, ['map'] = 40, ['blob'] = 54124, ['race'] = 1 } 
	siteData[L["Whelgar's Excavation Site"]] = { ['continent'] = 2, ['map'] = 40, ['blob'] = 54126, ['race'] = 1 } 
	siteData[L["Greenwarden's Fossil Bank"]] = { ['continent'] = 2, ['map'] = 40, ['blob'] = 54127, ['race'] = 3 } 
	siteData[L["Thoradin's Wall"]] = { ['continent'] = 2, ['map'] = 16, ['blob'] = 54129, ['race'] = 1 } 
	siteData[L["Witherbark Digsite"]] = { ['continent'] = 2, ['map'] = 16, ['blob'] = 54132, ['race'] = 8 } 
	siteData[L["Thandol Span"]] = { ['continent'] = 2, ['map'] = 40, ['blob'] = 54133, ['race'] = 1 } 
	siteData[L["Dun Garok Digsite"]] = { ['continent'] = 2, ['map'] = 24, ['blob'] = 54134, ['race'] = 1 } 
	siteData[L["Southshore Fossil Field"]] = { ['continent'] = 2, ['map'] = 24, ['blob'] = 54135, ['race'] = 3 } 
	siteData[L["Aerie Peak Digsite"]] = { ['continent'] = 2, ['map'] = 26, ['blob'] = 54136, ['race'] = 1 } 
	siteData[L["Shadra'Alor Digsite"]] = { ['continent'] = 2, ['map'] = 26, ['blob'] = 54137, ['race'] = 8 } 
	siteData[L["Altar of Zul Digsite"]] = { ['continent'] = 2, ['map'] = 26, ['blob'] = 54138, ['race'] = 8 } 
	siteData[L["Jintha'Alor Lower City Digsite"]] = { ['continent'] = 2, ['map'] = 26, ['blob'] = 54139, ['race'] = 8 } 
	siteData[L["Jintha'Alor Upper City Digsite"]] = { ['continent'] = 2, ['map'] = 26, ['blob'] = 54140, ['race'] = 8 } 
	siteData[L["Agol'watha Digsite"]] = { ['continent'] = 2, ['map'] = 26, ['blob'] = 54141, ['race'] = 8 } 
	siteData[L["Hammertoe's Digsite"]] = { ['continent'] = 2, ['map'] = 17, ['blob'] = 54832, ['race'] = 1 } 
	siteData[L["Tomb of the Watchers Digsite"]] = { ['continent'] = 2, ['map'] = 17, ['blob'] = 54834, ['race'] = 1 } 
	siteData[L["Uldaman Entrance Digsite"]] = { ['continent'] = 2, ['map'] = 17, ['blob'] = 54838, ['race'] = 1 } 
	siteData[L["Sunken Temple Digsite"]] = { ['continent'] = 2, ['map'] = 38, ['blob'] = 54862, ['race'] = 8 } 
	siteData[L["Misty Reed Fossil Bank"]] = { ['continent'] = 2, ['map'] = 38, ['blob'] = 54864, ['race'] = 3 } 
	siteData[L["Twilight Grove Digsite"]] = { ['continent'] = 2, ['map'] = 34, ['blob'] = 55350, ['race'] = 4 } 
	siteData[L["Vul'Gol Fossil Bank"]] = { ['continent'] = 2, ['map'] = 34, ['blob'] = 55352, ['race'] = 3 } 
	siteData[L["Nazj'vel Digsite"]] = { ['continent'] = 1, ['map'] = 42, ['blob'] = 55354, ['race'] = 4 } 
	siteData[L["Zoram Strand Digsite"]] = { ['continent'] = 1, ['map'] = 43, ['blob'] = 55356, ['race'] = 4 } 
	siteData[L["Ruins of Ordil'Aran"]] = { ['continent'] = 1, ['map'] = 43, ['blob'] = 55398, ['race'] = 4 } 
	siteData[L["Ruins of Stardust"]] = { ['continent'] = 1, ['map'] = 43, ['blob'] = 55400, ['race'] = 4 } 
	siteData[L["Forest Song Digsite"]] = { ['continent'] = 1, ['map'] = 43, ['blob'] = 55402, ['race'] = 4 } 
	siteData[L["Stonetalon Peak"]] = { ['continent'] = 1, ['map'] = 81, ['blob'] = 55404, ['race'] = 4 } 
	siteData[L["Ruins of Eldre'Thar"]] = { ['continent'] = 1, ['map'] = 81, ['blob'] = 55406, ['race'] = 4 } 
	siteData[L["Unearthed Grounds"]] = { ['continent'] = 1, ['map'] = 81, ['blob'] = 55408, ['race'] = 3 } 
	siteData[L["Bael Modan Digsite"]] = { ['continent'] = 1, ['map'] = 607, ['blob'] = 55410, ['race'] = 1 } 
	siteData[L["Ruins of Eldarath"]] = { ['continent'] = 1, ['map'] = 181, ['blob'] = 55412, ['race'] = 4 } 
	siteData[L["Ruins of Arkkoran"]] = { ['continent'] = 1, ['map'] = 181, ['blob'] = 55414, ['race'] = 4 } 
	siteData[L["Lakeridge Highway Fossil Bank"]] = { ['continent'] = 2, ['map'] = 36, ['blob'] = 55416, ['race'] = 3 } 
	siteData[L["Slitherblade Shore Digsite"]] = { ['continent'] = 1, ['map'] = 101, ['blob'] = 55418, ['race'] = 4 } 
	siteData[L["Ethel Rethor Digsite"]] = { ['continent'] = 1, ['map'] = 101, ['blob'] = 55420, ['race'] = 4 } 
	siteData[L["Valley of Bones"]] = { ['continent'] = 1, ['map'] = 101, ['blob'] = 55422, ['race'] = 3 } 
	siteData[L["Mannoroc Coven Digsite"]] = { ['continent'] = 1, ['map'] = 101, ['blob'] = 55424, ['race'] = 4 } 
	siteData[L["Kodo Graveyard"]] = { ['continent'] = 1, ['map'] = 101, ['blob'] = 55426, ['race'] = 3 } 
	siteData[L["Sargeron Digsite"]] = { ['continent'] = 1, ['map'] = 101, ['blob'] = 55428, ['race'] = 4 } 
	siteData[L["Red Reaches Fossil Bank"]] = { ['continent'] = 2, ['map'] = 19, ['blob'] = 55434, ['race'] = 3 } 
	siteData[L["Dreadmaul Fossil Field"]] = { ['continent'] = 2, ['map'] = 19, ['blob'] = 55436, ['race'] = 3 } 
	siteData[L["Grimsilt Digsite"]] = { ['continent'] = 2, ['map'] = 28, ['blob'] = 55438, ['race'] = 1 } 
	siteData[L["Pyrox Flats Digsite"]] = { ['continent'] = 2, ['map'] = 28, ['blob'] = 55440, ['race'] = 1 } 
	siteData[L["Western Ruins of Thaurissan"]] = { ['continent'] = 2, ['map'] = 29, ['blob'] = 55442, ['race'] = 1 } 
	siteData[L["Eastern Ruins of Thaurissan"]] = { ['continent'] = 2, ['map'] = 29, ['blob'] = 55444, ['race'] = 1 } 
	siteData[L["Terror Wing Fossil Field"]] = { ['continent'] = 2, ['map'] = 29, ['blob'] = 55446, ['race'] = 3 } 
	siteData[L["Zul'Mashar Digsite"]] = { ['continent'] = 2, ['map'] = 23, ['blob'] = 55448, ['race'] = 8 } 
	siteData[L["Quel'Lithien Lodge Digsite"]] = { ['continent'] = 2, ['map'] = 23, ['blob'] = 55450, ['race'] = 4 } 
	siteData[L["Infectis Scar Fossil Field"]] = { ['continent'] = 2, ['map'] = 23, ['blob'] = 55452, ['race'] = 3 } 
	siteData[L["Eastern Zul'Kunda Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55454, ['race'] = 8 } 
	siteData[L["Western Zul'Kunda Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55456, ['race'] = 8 } 
	siteData[L["Bal'lal Ruins Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55458, ['race'] = 8 } 
	siteData[L["Balia'mah Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55460, ['race'] = 8 } 
	siteData[L["Ziata'jai Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55462, ['race'] = 8 } 
	siteData[L["Eastern Zul'Mamwe Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55464, ['race'] = 8 } 
	siteData[L["Western Zul'Mamwe Digsite"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55466, ['race'] = 8 } 
	siteData[L["Savage Coast Raptor Fields"]] = { ['continent'] = 2, ['map'] = 37, ['blob'] = 55468, ['race'] = 3 } 
	siteData[L["Ruins of Aboraz"]] = { ['continent'] = 2, ['map'] = 673, ['blob'] = 55470, ['race'] = 8 } 
	siteData[L["Ruins of Jubuwal"]] = { ['continent'] = 2, ['map'] = 673, ['blob'] = 55472, ['race'] = 8 } 
	siteData[L["Gurubashi Arena Digsite"]] = { ['continent'] = 2, ['map'] = 673, ['blob'] = 55474, ['race'] = 8 } 
	siteData[L["Nek'mani Wellspring Digsite"]] = { ['continent'] = 2, ['map'] = 673, ['blob'] = 55476, ['race'] = 8 } 
	siteData[L["Felstone Fossil Field"]] = { ['continent'] = 2, ['map'] = 22, ['blob'] = 55478, ['race'] = 3 } 
	siteData[L["Northridge Fossil Filed"]] = { ['continent'] = 2, ['map'] = 22, ['blob'] = 55480, ['race'] = 3 } 
	siteData[L["Andorhal Fossil Bank"]] = { ['continent'] = 2, ['map'] = 22, ['blob'] = 55482, ['race'] = 3 } 
	siteData[L["Wyrmbog Fossil Field"]] = { ['continent'] = 1, ['map'] = 141, ['blob'] = 55755, ['race'] = 3 } 
	siteData[L["Quagmire Fossil Field"]] = { ['continent'] = 1, ['map'] = 141, ['blob'] = 55757, ['race'] = 3 } 
	siteData[L["Dire Maul Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56327, ['race'] = 4 } 
	siteData[L["Broken Commons Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56329, ['race'] = 4 } 
	siteData[L["Ravenwind Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56331, ['race'] = 4 } 
	siteData[L["Oneiros Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56333, ['race'] = 4 } 
	siteData[L["Solarsal Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56335, ['race'] = 4 } 
	siteData[L["Darkmist Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56337, ['race'] = 4 } 
	siteData[L["South Isildien Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56339, ['race'] = 4 } 
	siteData[L["North Isildien Digsite"]] = { ['continent'] = 1, ['map'] = 121, ['blob'] = 56341, ['race'] = 4 } 
	siteData[L["Constellas Digsite"]] = { ['continent'] = 1, ['map'] = 182, ['blob'] = 56343, ['race'] = 4 } 
	siteData[L["Morlos'Aran Digsite"]] = { ['continent'] = 1, ['map'] = 182, ['blob'] = 56345, ['race'] = 4 } 
	siteData[L["Jaedenar Digsite"]] = { ['continent'] = 1, ['map'] = 182, ['blob'] = 56347, ['race'] = 4 } 
	siteData[L["Ironwood Digsite"]] = { ['continent'] = 1, ['map'] = 182, ['blob'] = 56349, ['race'] = 4 } 
	siteData[L["Lake Kel'Theril Digsite"]] = { ['continent'] = 1, ['map'] = 281, ['blob'] = 56351, ['race'] = 4 } 
	siteData[L["Owl Wing Thicket Digsite"]] = { ['continent'] = 1, ['map'] = 281, ['blob'] = 56354, ['race'] = 4 } 
	siteData[L["Frostwhisper Gorge Digsite"]] = { ['continent'] = 1, ['map'] = 281, ['blob'] = 56356, ['race'] = 4 } 
	siteData[L["Fields of Blood Fossil Bank"]] = { ['continent'] = 1, ['map'] = 607, ['blob'] = 56358, ['race'] = 3 } 
	siteData[L["Nightmare Scar Digsite"]] = { ['continent'] = 1, ['map'] = 607, ['blob'] = 56362, ['race'] = 4 } 
	siteData[L["Zul'Farrak Digsite"]] = { ['continent'] = 1, ['map'] = 161, ['blob'] = 56364, ['race'] = 8 } 
	siteData[L["Broken Pillar Digsite"]] = { ['continent'] = 1, ['map'] = 161, ['blob'] = 56367, ['race'] = 8 } 
	siteData[L["Eastmoon Ruins Digsite"]] = { ['continent'] = 1, ['map'] = 161, ['blob'] = 56369, ['race'] = 8 } 
	siteData[L["Southmoon Ruins Digsite"]] = { ['continent'] = 1, ['map'] = 161, ['blob'] = 56371, ['race'] = 8 } 
	siteData[L["Dunemaul Fossil Ridge"]] = { ['continent'] = 1, ['map'] = 161, ['blob'] = 56373, ['race'] = 3 } 
	siteData[L["Abyssal Sands Fossil Ridge"]] = { ['continent'] = 1, ['map'] = 161, ['blob'] = 56375, ['race'] = 3 } 
	siteData[L["Lower Lakkari Tar Pits"]] = { ['continent'] = 1, ['map'] = 201, ['blob'] = 56380, ['race'] = 3 } 
	siteData[L["Upper Lakkari Tar Pits"]] = { ['continent'] = 1, ['map'] = 201, ['blob'] = 56382, ['race'] = 3 } 
	siteData[L["Terror Run Fossil Field"]] = { ['continent'] = 1, ['map'] = 201, ['blob'] = 56384, ['race'] = 3 } 
	siteData[L["Screaming Reaches Fossil Field"]] = { ['continent'] = 1, ['map'] = 201, ['blob'] = 56386, ['race'] = 3 } 
	siteData[L["Marshlands Fossil Bank"]] = { ['continent'] = 1, ['map'] = 201, ['blob'] = 56388, ['race'] = 3 } 
	siteData[L["Southwind Village Digsite"]] = { ['continent'] = 1, ['map'] = 261, ['blob'] = 56390, ['race'] = 4 } 
	siteData[L["Gor'gaz Outpost Digsite"]] = { ['continent'] = 3, ['map'] = 465, ['blob'] = 56392, ['race'] = 6 } 
	siteData[L["Zeth'Gor Digsite"]] = { ['continent'] = 3, ['map'] = 465, ['blob'] = 56394, ['race'] = 6 } 
	siteData[L["Hellfire Basin Digsite"]] = { ['continent'] = 3, ['map'] = 465, ['blob'] = 56396, ['race'] = 6 } 
	siteData[L["Hellfire Citadel Digsite"]] = { ['continent'] = 3, ['map'] = 465, ['blob'] = 56398, ['race'] = 6 } 
	siteData[L["Sha'naar Digsite"]] = { ['continent'] = 3, ['map'] = 465, ['blob'] = 56400, ['race'] = 2 } 
	siteData[L["Boha'mu Ruins Digsite"]] = { ['continent'] = 3, ['map'] = 467, ['blob'] = 56402, ['race'] = 2 } 
	siteData[L["Twin Spire Ruins Digsite"]] = { ['continent'] = 3, ['map'] = 467, ['blob'] = 56404, ['race'] = 2 } 
	siteData[L["Ruins of Enkaat Digsite"]] = { ['continent'] = 3, ['map'] = 479, ['blob'] = 56406, ['race'] = 2 } 
	siteData[L["Arklon Ruins Digsite"]] = { ['continent'] = 3, ['map'] = 479, ['blob'] = 56408, ['race'] = 2 } 
	siteData[L["Ruins of Farahlon Digsite"]] = { ['continent'] = 3, ['map'] = 479, ['blob'] = 56410, ['race'] = 2 } 
	siteData[L["Ancestral Grounds Digsite"]] = { ['continent'] = 3, ['map'] = 477, ['blob'] = 56412, ['race'] = 6 } 
	siteData[L["Sunspring Post Digsite"]] = { ['continent'] = 3, ['map'] = 477, ['blob'] = 56416, ['race'] = 6 } 
	siteData[L["Laughing Skull Digsite"]] = { ['continent'] = 3, ['map'] = 477, ['blob'] = 56418, ['race'] = 6 } 
	siteData[L["Burning Blade Digsite"]] = { ['continent'] = 3, ['map'] = 477, ['blob'] = 56420, ['race'] = 6 } 
	siteData[L["Halaa Digsite"]] = { ['continent'] = 3, ['map'] = 477, ['blob'] = 56422, ['race'] = 2 } 
	siteData[L["Grangol'var Village Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56424, ['race'] = 6 } 
	siteData[L["Tuurem Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56426, ['race'] = 2 } 
	siteData[L["Bleeding Hollow Ruins Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56428, ['race'] = 6 } 
	siteData[L["Bonechewer Ruins Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56430, ['race'] = 6 } 
	siteData[L["Bone Wastes Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56432, ['race'] = 2 } 
	siteData[L["East Auchindoun Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56434, ['race'] = 2 } 
	siteData[L["West Auchindoun Digsite"]] = { ['continent'] = 3, ['map'] = 478, ['blob'] = 56437, ['race'] = 2 } 
	siteData[L["Illidari Point Digsite"]] = { ['continent'] = 3, ['map'] = 473, ['blob'] = 56439, ['race'] = 2 } 
	siteData[L["Coilskar Point Digsite"]] = { ['continent'] = 3, ['map'] = 473, ['blob'] = 56441, ['race'] = 2 } 
	siteData[L["Ruins of Baa'ri Digsite"]] = { ['continent'] = 3, ['map'] = 473, ['blob'] = 56446, ['race'] = 2 } 
	siteData[L["Eclipse Point Digsite"]] = { ['continent'] = 3, ['map'] = 473, ['blob'] = 56448, ['race'] = 2 } 
	siteData[L["Warden's Cage Digsite"]] = { ['continent'] = 3, ['map'] = 473, ['blob'] = 56450, ['race'] = 6 } 
	siteData[L["Dragonmaw Fortress"]] = { ['continent'] = 3, ['map'] = 473, ['blob'] = 56455, ['race'] = 6 } 
	siteData[L["Skorn Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56504, ['race'] = 9 } 
	siteData[L["Halgrind Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56506, ['race'] = 9 } 
	siteData[L["Wyrmskull Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56508, ['race'] = 9 } 
	siteData[L["Shield Hill Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56510, ['race'] = 9 } 
	siteData[L["Baleheim Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56512, ['race'] = 9 } 
	siteData[L["Nifflevar Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56514, ['race'] = 9 } 
	siteData[L["Gjalerbron Digsite"]] = { ['continent'] = 4, ['map'] = 491, ['blob'] = 56516, ['race'] = 9 } 
	siteData[L["Pit of Narjun Digsite"]] = { ['continent'] = 4, ['map'] = 488, ['blob'] = 56518, ['race'] = 5 } 
	siteData[L["Moonrest Gardens Digsite"]] = { ['continent'] = 4, ['map'] = 488, ['blob'] = 56520, ['race'] = 4 } 
	siteData[L["En'kilah Digsite"]] = { ['continent'] = 4, ['map'] = 486, ['blob'] = 56522, ['race'] = 5 } 
	siteData[L["Kolramas Digsite"]] = { ['continent'] = 4, ['map'] = 496, ['blob'] = 56524, ['race'] = 5 } 
	siteData[L["Riplash Ruins Digsite"]] = { ['continent'] = 4, ['map'] = 486, ['blob'] = 56526, ['race'] = 4 } 
	siteData[L["Violet Stand Digsite"]] = { ['continent'] = 4, ['map'] = 510, ['blob'] = 56528, ['race'] = 4 } 
	siteData[L["Ruins of Shandaral Digsite"]] = { ['continent'] = 4, ['map'] = 510, ['blob'] = 56530, ['race'] = 4 } 
	siteData[L["Altar of Sseratus Digsite"]] = { ['continent'] = 4, ['map'] = 496, ['blob'] = 56533, ['race'] = 8 } 
	siteData[L["Zim'Rhuk Digsite"]] = { ['continent'] = 4, ['map'] = 496, ['blob'] = 56535, ['race'] = 8 } 
	siteData[L["Zol'Heb Digsite"]] = { ['continent'] = 4, ['map'] = 496, ['blob'] = 56537, ['race'] = 8 } 
	siteData[L["Altar of Quetz'lun Digsite"]] = { ['continent'] = 4, ['map'] = 496, ['blob'] = 56539, ['race'] = 8 } 
	siteData[L["Talramas Digsite"]] = { ['continent'] = 4, ['map'] = 486, ['blob'] = 56541, ['race'] = 5 } 
	siteData[L["Voldrune Digsite"]] = { ['continent'] = 4, ['map'] = 490, ['blob'] = 56543, ['race'] = 9 } 
	siteData[L["Drakil'Jin Ruins Digsite"]] = { ['continent'] = 4, ['map'] = 490, ['blob'] = 56547, ['race'] = 8 } 
	siteData[L["Brunnhildar Village Digsite"]] = { ['continent'] = 4, ['map'] = 495, ['blob'] = 56549, ['race'] = 9 } 
	siteData[L["Sifreldar Village Digsite"]] = { ['continent'] = 4, ['map'] = 495, ['blob'] = 56551, ['race'] = 9 } 
	siteData[L["Valkyrion Digsite"]] = { ['continent'] = 4, ['map'] = 495, ['blob'] = 56553, ['race'] = 9 } 
	siteData[L["Scourgeholme Digsite"]] = { ['continent'] = 4, ['map'] = 492, ['blob'] = 56555, ['race'] = 5 } 
	siteData[L["Ymirheim Digsite"]] = { ['continent'] = 4, ['map'] = 492, ['blob'] = 56560, ['race'] = 9 } 
	siteData[L["Jotunheim Digsite"]] = { ['continent'] = 4, ['map'] = 492, ['blob'] = 56562, ['race'] = 9 } 
	siteData[L["Njorndar Village Digsite"]] = { ['continent'] = 4, ['map'] = 492, ['blob'] = 56564, ['race'] = 9 } 
	siteData[L["Ruins of Lar'donir Digsite"]] = { ['continent'] = 1, ['map'] = 606, ['blob'] = 56566, ['race'] = 4 } 
	siteData[L["Shrine of Goldrinn Digsite"]] = { ['continent'] = 1, ['map'] = 606, ['blob'] = 56568, ['race'] = 4 } 
	siteData[L["Grove of Aessina Digsite"]] = { ['continent'] = 1, ['map'] = 606, ['blob'] = 56570, ['race'] = 4 } 
	siteData[L["Sanctuary of Malorne Digsite"]] = { ['continent'] = 1, ['map'] = 606, ['blob'] = 56572, ['race'] = 4 } 
	siteData[L["Scorched Plain Digsite"]] = { ['continent'] = 1, ['map'] = 606, ['blob'] = 56574, ['race'] = 4 } 
	siteData[L["Quel'Dormir Gardens Digsite"]] = { ['continent'] = 2, ['map'] = 615, ['blob'] = 56576, ['race'] = 4 } 
	siteData[L["Nar'shola (Middle Tier) Digsite"]] = { ['continent'] = 2, ['map'] = 615, ['blob'] = 56578, ['race'] = 4 } 
	siteData[L["Biel'aran Ridge Digsite"]] = { ['continent'] = 2, ['map'] = 615, ['blob'] = 56580, ['race'] = 4 } 
	siteData[L["Dunwald Ruins Digsite"]] = { ['continent'] = 2, ['map'] = 700, ['blob'] = 56583, ['race'] = 1 } 
	siteData[L["Thundermar Ruins Digsite"]] = { ['continent'] = 2, ['map'] = 700, ['blob'] = 56585, ['race'] = 1 } 
	siteData[L["Humboldt Conflagration Digsite"]] = { ['continent'] = 2, ['map'] = 700, ['blob'] = 56587, ['race'] = 1 } 
	siteData[L["Grim Batol Digsite"]] = { ['continent'] = 2, ['map'] = 700, ['blob'] = 56589, ['race'] = 1 } 
	siteData[L["Khartut's Tomb Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56591, ['race'] = 7 } 
	siteData[L["Tombs of the Precursors Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56593, ['race'] = 7 } 
	siteData[L["Steps of Fate Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56595, ['race'] = 7 } 
	siteData[L["Neferset Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56597, ['race'] = 7 } 
	siteData[L["Orsis Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56599, ['race'] = 7 } 
	siteData[L["Ruins of Ammon Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56601, ['race'] = 7 } 
	siteData[L["Ruins of Khintaset Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56603, ['race'] = 7 } 
	siteData[L["Temple of Uldum Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56605, ['race'] = 7 } 
	siteData[L["Ruins of Ahmtul Digsite"]] = { ['continent'] = 1, ['map'] = 720, ['blob'] = 56607, ['race'] = 7 } 

	--  Minimap size values
	minimapSize = {
		indoor = {
			[0] = 300,
			[1] = 240,
			[2] = 180,
			[3] = 120,
			[4] = 80,
			[5] = 50,
		},
		outdoor = {
			[0] = 466 + 2/3,
			[1] = 400,
			[2] = 333 + 1/3,
			[3] = 266 + 2/6,
			[4] = 200, 
			[5] = 133 + 1/3,
		},
		inScale = {
			[0] = 1,
			[1] = 1.25,
			[2] = 5/3,
			[3] = 2.5,
			[4] = 3.75,
			[5] = 6,
		},
		outScale = {
			[0] = 1,
			[1] = 7/6,
			[2] = 1.4,
			[3] = 1.75,
			[4] = 7/3,
			[5] = 3.5,
		},
	}

end

--[[ Function Hooks ]]--
-- Hook and overwrite the default SolveArtifact function to provide confirmations when nearing cap
local blizSolveArtifact = SolveArtifact
SolveArtifact = function(raceIndex)
	local rank, maxRank = GetArchaeologyRank()
	if db.general.confirmSolve and maxRank < MAX_ARCHAEOLOGY_RANK and (rank + 25) >= maxRank then requiresConfirm = true end
	if requiresConfirm then
		if not confirmArgs then confirmArgs = {} end
		confirmArgs.race = raceIndex
		StaticPopup_Show("ARCHY_CONFIRM_SOLVE", rank, maxRank)
	else
		return SolveRaceArtifact(raceIndex)
	end
end


--[[ Dialog declarations ]]--
StaticPopupDialogs["ARCHY_CONFIRM_SOLVE"] = {
	text = L["Your Archaeology skill is at %d of %d.  Are you sure you would like to solve this artifact before visiting a trainer?"],
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		if confirmArgs and confirmArgs.race then
			SolveRaceArtifact(confirmArgs.race)
			confirmArgs = nil
		else
			blizSolveArtifact()
			confirmArgs = nil
		end
	end,
	OnCancel = function()
		confirmArgs = nil
	end,
	timeout = 0,
	sound = "levelup2",
	whileDead = false,
	hideOnEscape = true,
}


--[[ Local Helper Functions ]]--

-- Returns true if the player has the archaeology secondary skill
local function HasArchaeology()
	local _, _, arch = GetProfessions()
	return (arch and true or false)
end

local function IsTaintable()
	if (InCombatLockdown() or UnitAffectingCombat("player") or inCombat) then
		return true
	end
end

local function ShouldBeHidden()
	if (not db.general.show) or IsInInstance() or (not HasArchaeology()) or (not playerContinent) then
		return true
	end
end

-- opens the Blizzard_ArchaeologyUI panel
function Archy:ShowArchaeology()
	if IsAddOnLoaded("Blizzard_ArchaeologyUI") then
		ShowUIPanel(ArchaeologyFrame)
		return true
	else
		local loaded, reason = LoadAddOn("Blizzard_ArchaeologyUI")
		if loaded then
			ShowUIPanel(ArchaeologyFrame)
			return true
		else
			Archy:Print(string.format(L["ArchaeologyUI not loaded: %s Try opening manually."], _G["ADDON_"..reason]))
			return false
		end
	end
end

-- returns the rank and max rank for the players archaeology skill
function GetArchaeologyRank()
	local _, _, arch = GetProfessions()
	if arch then
		local _, _, rank, maxRank = GetProfessionInfo(arch)
		return rank, maxRank
	end
end

-- Toggles the lock of the panels
local function ToggleLock()
	db.general.locked = not db.general.locked
	Archy:Print("is now", (db.general.locked and "" or "un") .. "locked.")
	Archy:ConfigUpdated()
end

-- deformat substitute
local function MatchFormat(msg, pattern)
	return string.match(msg, string.gsub(string.gsub(pattern, "(%%s)", "(.+)"), "(%%d)", "(.+)"))
end

-- extract the itemid from the itemlink
local function GetIDFromLink(link)
	if not link then return end

	local found, _, str = string.find(link, "^|c%x+|H(.+)|h%[.+%]")
	if not found then return end

	local _, id = strsplit(":", str)
	return tonumber(id)
end

-- return the player, itemlink and quantity of the item in the chat_msg_loot
local function ParseLootMessage(msg)
	local player = UnitName("player")
	local item, quantity = MatchFormat(msg, LOOT_ITEM_SELF_MULTIPLE)
	if item and quantity then
		return player, item, tonumber(quantity)
	end
	
	quantity = 1
	item = MatchFormat(msg, LOOT_ITEM_SELF)
	if item then
		return player, item, tonumber(quantity)
	end
	
	player, item, quantity = MatchFormat(msg, LOOT_ITEM_MULTIPLE)
	if player and item and quantity then
		return player, item, tonumber(quantity)
	end
	
	quantity = 1
	player, item = MatchFormat(msg, LOOT_ITEM)
	return player, item, tonumber(quantity)
end

-- load the race related data tables
local function LoadRaceData()
	if GetNumArchaeologyRaces() == 0 then return end
	for rid = 1, GetNumArchaeologyRaces() do
		local race = raceData[rid]		-- meta table should load the data
		if race then							-- we have race data
			raceNameToID[race['name']] = rid
			currencyIDToRaceID[race['currency']['id']] = rid
			keystoneIDToRaceID[race['keystone']['id']] = rid
			local _, currencyAmount = GetCurrencyInfo(race['currency']['id'])
			currencyData[race['currency']['id']] = currencyAmount
		end
	end
	
	RequestArtifactCompletionHistory()
	raceDataLoaded = true
end

-- returns a list of race ids for the continent map id
local function ContinentRaces(cid)
	local races = {}
	for _, site in pairs(siteData) do
		if (site.continent == continentMapToID[cid] and not tContains(races, site.race)) then
			tinsert(races, site.race)
		end
	end
	return races
end

function ResetPositions()
	db.digsite.distanceIndicator.position = {unpack(defaults.profile.digsite.distanceIndicator.position)}
	db.digsite.distanceIndicator.anchor = defaults.profile.digsite.distanceIndicator.anchor
	db.digsite.distanceIndicator.undocked = defaults.profile.digsite.distanceIndicator.undocked
	db.digsite.position = {unpack(defaults.profile.digsite.position)}
	db.digsite.anchor = defaults.profile.digsite.anchor
	db.artifact.position = {unpack(defaults.profile.artifact.position)}
	db.artifact.anchor = defaults.profile.artifact.anchor
	Archy:ConfigUpdated()
	Archy:UpdateFramePositions()
end

function Archy:ConfigUpdated(ns, opt)
	db = self.db.profile
	if not ns then
		self:UpdateRacesFrame()
		self:RefreshRacesDisplay()
		self:UpdateDigSiteFrame()
		self:RefreshDigSiteDisplay()
		UpdateMinimapPOIs(true)
		UpdateSiteBlobs()
		RefreshTomTom()
	elseif ns == "artifact" then
		if opt == "autofill" then
			for rid = 1,GetNumArchaeologyRaces() do
				UpdateRaceArtifact(rid)
			end
		end
		if opt == "color" then
			self:RefreshRacesDisplay()
		else
			self:UpdateRacesFrame()
			self:RefreshRacesDisplay()
			self:SetFramePosition(racesFrame)
		end
	elseif ns == "digsite" then
		self:UpdateDigSiteFrame()
		if opt == "font" then
			self:ResizeDigSiteDisplay()
		else
			self:RefreshDigSiteDisplay()
		end
		self:SetFramePosition(digsiteFrame)
		self:SetFramePosition(distanceIndicatorFrame)
		HideDistanceIndicator()
		ShowDistanceIndicator()
	elseif ns == "minimap" then
		
		UpdateMinimapPOIs(true)
		UpdateSiteBlobs()
	elseif ns == "tomtom" then
		if db.tomtom.enabled and tomtomExists then
			if TomTom.profile then
				TomTom.profile.arrow.arrival = db.tomtom.distance
				TomTom.profile.arrow.enablePing = db.tomtom.ping
			end
		end
		RefreshTomTom()
	end
end

--[[ Artifact Functions ]]--
local function Announce(rid)
	if db.general.show then
		local text = string.format(L["You can solve %s Artifact - %s (Fragments: %d of %d)"], "|cFFFFFF00" .. raceData[rid]['name'] .. "|r", "|cFFFFFF00" .. artifacts[rid]['name'] .. "|r", artifacts[rid]['fragments'] + artifacts[rid]['fragAdjust'], artifacts[rid]['fragTotal'])
		Archy:Pour(text, 1, 1, 1)
	end
end

local function Ping()
	if db.general.show then
		PlaySoundFile("Interface\\AddOns\\Archy\\Media\\dingding.mp3");
	end
end

function UpdateRaceArtifact(rid)
	local race = raceData[rid]
	if not race then
		--@??? Maybe use a wipe statement here
		artifacts[rid] = nil
		return
	end
	
	raceData[rid]['keystone']['inventory'] = GetItemCount(raceData[rid]['keystone']['id']) or 0
	
	local numProjects = GetNumArtifactsByRace(rid)
	if numProjects == 0 then
		--artifacts[rid] = nil
	else
		if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
			ArchaeologyFrame_ShowArtifact(rid)
		end
		SetSelectedArtifact(rid)
		local name, _, rarity, icon, spellDescription, numSockets = GetSelectedArtifactInfo();
		local base, adjust, total = GetArtifactProgress()

		local artifact = artifacts[rid]
		
		artifact['canSolve'] = CanSolveArtifact()
		artifact['fragments'] = base
		artifact['fragTotal'] = total
		artifact['sockets'] = numSockets
		artifact['icon'] = icon
		artifact['tooltip'] = spellDescription
		artifact['rare'] = (rarity ~= 0)
		artifact['name'] = name
		artifact['canSolveStone'] = false
		artifact['fragAdjust'] = 0
		artifact['completionCount'] = 0
		
		local prevAdded = min(artifact['stonesAdded'], raceData[rid]['keystone']['inventory'], numSockets)
		if db.artifact.autofill[rid] then
			prevAdded = min(raceData[rid]['keystone']['inventory'], numSockets)
		end
		artifact['stonesAdded'] = min(raceData[rid]['keystone']['inventory'], numSockets)
		if artifact['stonesAdded'] > 0 and numSockets > 0 then
			for i=1,min(artifact['stonesAdded'], numSockets) do
				SocketItemToArtifact()
				if (not ItemAddedToArtifact(i)) then break end
			end
			
			base, adjust, total = GetArtifactProgress()
			artifact['canSolveStone'] = CanSolveArtifact()
			if prevAdded > 0 then
				artifact['fragAdjust'] = adjust
			end
		end
		artifact['stonesAdded'] = prevAdded		
		
		RequestArtifactCompletionHistory()
		if not db.artifact.blacklist[rid] then
			if not artifact['ping'] and (artifact['canSolve'] or artifact['canSolveStone']) then
				if db.artifact.ping or db.artifact.announce then
					artifact['ping'] = true
					if db.artifact.announce then
						Announce(rid)
					end
					if db.artifact.ping then
						Ping()
					end
				end
			end
		end
	end
end

local function UpdateRace(rid)
	UpdateRaceArtifact(rid)
	UpdateArtifactFrame(rid)
end

function SolveRaceArtifact(rid)
	if rid then
		SetSelectedArtifact(rid)
		artifactSolved['raceId'] = rid
		artifactSolved['name'] = GetSelectedArtifactInfo();
		keystoneLootRaceID = rid -- this is to force a refresh after the ARTIFACT_COMPLETE event

		if artifacts[rid]['stonesAdded'] > 0 then
			for i=1, artifacts[rid]['stonesAdded'] do
				SocketItemToArtifact()
				if not ItemAddedToArtifact(i) then break end
			end
		else
			if artifacts[rid]['sockets'] > 0 then
				for i=1, artifacts[rid]['stonesAdded'] do
					RemoveItemFromArtifact()
				end
			end
		end
		GetArtifactProgress()
	end
	blizSolveArtifact()
end

function Archy:SolveAnyArtifact(useStones)
	local found = false
	for rid, artifact in pairs(artifacts) do
		if not db.artifact.blacklist[rid] then
			if (artifact['canSolve'] or (useStones and artifact['canSolveStone'])) then
				SolveRaceArtifact(rid)
				found = true
				break
			end
		end
	end
	if not found then
		Archy:Print(L["No artifacts were solvable"])
	end
end

local function GetArtifactStats(rid, name)
	local numArtifacts = GetNumArtifactsByRace(rid)
	for artifactIndex = 1, numArtifacts do
		local artifactName, _, _, _, _, _, _, firstCompletionTime, completionCount = GetArtifactInfoByRace(rid, artifactIndex)
		if name == artifactName then
			return artifactIndex, firstCompletionTime, completionCount
		end
	end
end

local function UpdateArtifactFrame(rid)
end

function Archy:SocketClicked(self, button, down)
	local rid = self:GetParent():GetParent():GetID()
	local keystoneIndex = self:GetID()
	
	if (button == "LeftButton") then
		if (artifacts[rid]['stonesAdded'] < artifacts[rid]['sockets']) and (artifacts[rid]['stonesAdded'] < raceData[rid]['keystone']['inventory']) then
			artifacts[rid]['stonesAdded'] = artifacts[rid]['stonesAdded'] + 1
		end
	else
		if (artifacts[rid]['stonesAdded'] > 0) then
			artifacts[rid]['stonesAdded'] = artifacts[rid]['stonesAdded'] - 1
		end
	end

	UpdateRaceArtifact(rid)
	Archy:RefreshRacesDisplay()
end



--[[ Dig Site List Functions ]]--
local function ResetDigCounter(id)
	siteStats[id]['counter'] = 0
end

local function IncrementDigCounter(id)
	siteStats[id]['counter'] = (siteStats[id]['counter'] or 0) + 1
end

local function CompareAndResetDigCounters(a, b)
	if not a or not b or (#a == 0) or (#b == 0) then return end
	for _, siteA in pairs(a) do
		local exists = false
		for _, siteB in pairs(b) do
			if siteA.id == siteB.id then
				exists = true
				break
			end
		end
		
		if not exists then
			ResetDigCounter(siteA.id)
		end
	end
end

local function GetContinentSites(cid)
	local sites, orig = {}, GetCurrentMapAreaID()
	SetMapZoom(cid)
	local totalPOIs = GetNumMapLandmarks()
	for index = 1,totalPOIs do
		local name, description, textureIndex, px, py = GetMapLandmarkInfo(index)
		if textureIndex == 177 then
			local zoneName, mapFile, texPctX, texPctY, texX, texY, scrollX, scrollY = UpdateMapHighlight(px, py)

			local site = siteData[name]

			local mc, fc, mz, fz, zoneID = 0, 0, 0, 0, 0
			mc, fc = astrolabe:GetMapID(cid, 0)
			mz = site.map
			zoneID = mapIDToZone[mz]
			

			if site then
				local x, y = astrolabe:TranslateWorldMapPosition(mc, fc, px, py, mz, fz)
				
				local raceName, _, raceCrestTexture = GetArchaeologyRaceInfo(site.race)
				
				local digsite = {
					continent = mc,
					zoneId = zoneID,
					zoneName = mapIDToZoneName[mz],
					mapFile = mapFile,
					map = mz,
					level = fz,
					x = x,
					y = y,
					name = name,
					raceId = site.race,
					id = site.blob,
					distance = 999999,
				}
				tinsert(sites, digsite)
			end
		end
	end
	SetMapByID(orig)
	return sites
end

local function UpdateSites()
	local sites
	for cid, cname in pairs{GetMapContinents()} do
		if (not digsites[cid]) then digsites[cid] = {} end
		sites = GetContinentSites(cid)
		if sites and (#sites > 0) and cid == continentMapToID[playerContinent] then
			CompareAndResetDigCounters(digsites[cid], sites)
			CompareAndResetDigCounters(sites, digsites[cid])
		end
		
		if (#sites > 0) then digsites[cid] = sites end
	end
end

function Archy:IsSiteBlacklisted(name)
	return siteBlacklist[name]
end

function Archy:ToggleSiteBlacklist(name)
	siteBlacklist[name] = not siteBlacklist[name]
end

function Archy:UpdateSiteDistances()
	if not digsites[continentMapToID[playerContinent]] or (#digsites[continentMapToID[playerContinent]] == 0) then 
		nearestSite = nil
		return
	end
	
	local distance, nearest
	for i=1,SITES_PER_CONTINENT do 
		local site = digsites[continentMapToID[playerContinent]][i]
		site.distance = astrolabe:ComputeDistance(playerPosition.map, playerPosition.level, playerPosition.x, playerPosition.y, site.map, site.level, site.x, site.y)
		if not Archy:IsSiteBlacklisted(site.name) then
			if not distance or site.distance < distance then
				distance = site.distance
				nearest = site
			end
		end
	end
	
	if nearest and (not nearestSite or nearestSite.id ~= nearest.id) then
		-- nearest dig site has changed
		nearestSite = nearest
		tomtomActive = true
		RefreshTomTom()
		UpdateSiteBlobs()
		UpdateMinimapPOIs()
		if db.digsite.announceNearest and db.general.show then
			AnnounceNearestSite()
		end
	end
	
	-- Sort sites
	local sites = digsites[continentMapToID[playerContinent]]
	if db.digsite.sortByDistance then
		table.sort(sites, function(a,b)
			if Archy:IsSiteBlacklisted(a.name) and not Archy:IsSiteBlacklisted(b.name) then 
				return 1 < 0
			elseif not Archy:IsSiteBlacklisted(a.name) and Archy:IsSiteBlacklisted(b.name) then 
				return 0 < 1
			end
			if (a.distance == -1 and b.distance == -1) or (not a.distance and not b.distance) then
				return a.zoneName .. ":" .. a.name < b.zoneName .. ":" .. b.name
			else
				return (a.distance or 0) < (b.distance or 0)
			end
		end)
	else	-- sort by zone then name
		table.sort(sites, function(a,b)
			return a.zoneName .. ":" .. a.name < b.zoneName .. ":" .. b.name
		end)
	end
end

function AnnounceNearestSite()
	if not nearestSite or not nearestSite.distance then return end
	Archy:Pour(string.format(L["Nearest Dig Site is: %s in %s (%.1f yards away)"], GREEN_FONT_COLOR_CODE .. nearestSite.name .. "|r", GREEN_FONT_COLOR_CODE .. nearestSite.zoneName .. "|r", nearestSite.distance), 1, 1, 1)
end

local function UpdateSiteFrame(index)
end

function Archy:ImportOldStatsDB()
	for key, st in pairs(Archy.db.char.digsites) do
		if key ~= "blacklist" and key ~= "stats" then
			if siteData[key] then
				local site = siteData[key]
				siteStats[site.blob]['surveys'] = (siteStats[site.blob]['surveys'] or 0) + st['surveys']
				siteStats[site.blob]['fragments'] = (siteStats[site.blob]['fragments'] or 0) + st['fragments']
				siteStats[site.blob]['looted'] = (siteStats[site.blob]['looted'] or 0) + st['looted']
				siteStats[site.blob]['keystones'] = (siteStats[site.blob]['keystones'] or 0) + st['keystones']
				Archy.db.char.digsites[key] = nil
			end
		end
	end
end




--[[ Survey Functions ]]--
local function AddSurveyNode(siteId, map, level, x, y)
	local newNode = { m = map, f = level, x = x, y = y }
	local exists = false
	
	if not Archy.db.global.surveyNodes then Archy.db.global.surveyNodes = {} end
	if not Archy.db.global.surveyNodes[siteId] then Archy.db.global.surveyNodes[siteId] = {} end
	for _, node in pairs(Archy.db.global.surveyNodes[siteId]) do	
		local distance = astrolabe:ComputeDistance(newNode.m, newNode.f, newNode.x, newNode.y, node.m, node.f, node.x, node.y)
		if not distance or IsInInstance() then distance = 0 end
		if distance <= 10 then 
			exists = true 
			break
		end
	end
	if not exists then
		tinsert(Archy.db.global.surveyNodes[siteId], newNode)
	end
end

function Archy:InjectSurveyNode(siteId, map, level, x, y)
	local newNode = { m = map, f = level, x = x, y = y }
	local exists = false
	
	if not Archy.db.global.surveyNodes then Archy.db.global.surveyNodes = {} end
	if not Archy.db.global.surveyNodes[siteId] then Archy.db.global.surveyNodes[siteId] = {} end
	for _, node in pairs(Archy.db.global.surveyNodes[siteId]) do	
		local distance = astrolabe:ComputeDistance(newNode.m, newNode.f, newNode.x, newNode.y, node.m, node.f, node.x, node.y)
		if not distance then distance = 0 end
		if distance <= 10 then 
			exists = true 
			break
		end
	end
	if not exists then
		tinsert(Archy.db.global.surveyNodes[siteId], newNode)
	end
end

function Archy:ClearSurveyNodeDB()
	Archy.db.global.surveyNodes = {}
	collectgarbage('collect')
end

function ShowDistanceIndicator()
	if not IsTaintable() then
		if not distanceIndicatorFrame:IsShown() and not ShouldBeHidden() and db.digsite.distanceIndicator.enabled and distanceIndicatorActive then
			distanceIndicatorFrame.circle:SetAlpha(1.0)
			distanceIndicatorFrame:Show()
		end
		if not db.digsite.distanceIndicator.showSurveyButton then
			distanceIndicatorFrame.surveyButton:Hide()
			distanceIndicatorFrame:SetWidth(42)
		else
			distanceIndicatorFrame.surveyButton:Show()
			distanceIndicatorFrame:SetWidth(52 + distanceIndicatorFrame.surveyButton:GetWidth())
		end
	end
end
function HideDistanceIndicator()
	if not IsTaintable() then
		if distanceIndicatorFrame:IsShown() then
			if not ShouldBeHidden() and db.digsite.distanceIndicator.enabled and not distanceIndicatorActive then
				distanceIndicatorFrame.circle:SetAlpha(0)
			else
				distanceIndicatorFrame:Hide()
			end
		end
		if not db.digsite.distanceIndicator.showSurveyButton then
			distanceIndicatorFrame.surveyButton:Hide()
			distanceIndicatorFrame:SetWidth(42)
		else
			distanceIndicatorFrame.surveyButton:Show()
			distanceIndicatorFrame:SetWidth(52 + distanceIndicatorFrame.surveyButton:GetWidth())
		end
	end
end

local diColors = {
	["Green"] = {0, 0.24609375, 0, 1 },
	["Yellow"] = {0.24609375, 0.5, 0, 1 },
	["Red"] = {0.5, 0.75, 0, 1 },
}
local function SetDistanceIndicatorColor(color)
	if color then
		distanceIndicatorFrame.circle.texture:SetTexCoord(unpack(diColors[color]))
		distanceIndicatorFrame.circle:SetAlpha(1)
		ShowDistanceIndicator()
	else
		HideDistanceIndicator()
	end
end

local function SetDistanceIndicatorText(distance)
	if distance then
		distanceIndicatorFrame.circle.distance:SetText(string.format("%1.f", distance))
	end
end

local function UpdateDistanceIndicator()
	if surveyPosition.x == 0 and surveyPosition.y == 0 then return end
	local distance = astrolabe:ComputeDistance(playerPosition.map, playerPosition.level, playerPosition.x, playerPosition.y, surveyPosition.map, surveyPosition.level, surveyPosition.x, surveyPosition.y)
	if not distance or IsInInstance() then distance = 0 end
	
	local greenMin, greenMax = 0, db.digsite.distanceIndicator.green
	local yellowMin, yellowMax = greenMax, db.digsite.distanceIndicator.yellow
	local redMin, redMax = yellowMax, 500
	if distance >= greenMin and distance <= greenMax then
		SetDistanceIndicatorColor("Green")
	elseif distance >= yellowMin and distance <= yellowMax then
		SetDistanceIndicatorColor("Yellow")
	elseif distance >= redMin and distance <= redMax then
		SetDistanceIndicatorColor("Red")
	else
		HideDistanceIndicator()
		return
	end
	SetDistanceIndicatorText(distance)
end


--[[ Minimap Functions ]]--
function CreateMinimapPOI(index, type, loc, title, siteId, surveyNum)
	local poi = pois[index]
	local poiButton = CreateFrame("Frame", nil, poi)
	poiButton.texture = poiButton:CreateTexture(nil, "OVERLAY")
	if type == "site" then
		poi.useArrow = true
		poiButton.texture:SetTexture([[Interface\Archeology\Arch-Icon-Marker.blp]])
		poiButton:SetWidth(14)
		poiButton:SetHeight(14)
	else
		poi.useArrow = false
		poiButton.texture:SetTexture([[Interface\AddOns\Archy\Media\Nodes]])
		if db.minimap.fragmentIcon == "Cross" then
			poiButton.texture:SetTexCoord(0,0.46875,0, 0.453125)
		else
			poiButton.texture:SetTexCoord(0,0.234375,0.5, 0.734375)
		end
		poiButton:SetWidth(8)
		poiButton:SetHeight(8)
	end
	poiButton.texture:SetAllPoints(poiButton)
	poiButton:SetPoint("CENTER", poi)
	poiButton:SetScale(1)
	poiButton:SetParent(poi)
	poiButton:EnableMouse(false)
	poi.poiButton = poiButton
	poi.index = index
	poi.type = type
	poi.title = title
	poi.location = loc
	poi.active = true
	poi.siteId = siteId
	poi.surveyNum = surveyNum
	pois[index] = poi
	return poi
end

function UpdateMinimapEdges()
	for id, poi in pairs(pois) do
		if poi.active then
			if astrolabe:IsIconOnEdge(poi) then
				poi.poiButton:Hide()
				if poi.useArrow then poi.arrow:Show() end
			else
				poi.poiButton:Show()
				if poi.useArrow then poi.arrow:Hide() end
			end
		end
	end
end

local lastNearestSite
function UpdateMinimapPOIs(force)
	if WorldMapButton:IsVisible() then return end
	if lastNearestSite ~= nearestSite or force then
		lastNearestSite = nearestSite
		local validSiteIDs = {}
		if db.general.show and db.minimap.show then
			if digsites[continentMapToID[playerContinent]] then
				for _, site in pairs(digsites[continentMapToID[playerContinent]]) do
					tinsert(validSiteIDs, site.id)
				end
			end
		end
		
		-- remove the icons from the minimap
		for id, poi in pairs(pois) do
			if not tContains(validSiteIDs, poi.siteId) or (poi.type == "survey" and lastNearestSite.id ~= poi.siteId) or force then
				astrolabe:RemoveIconFromMinimap(poi)
				if poi.poiButton then
					poi.poiButton:Hide()
					poi.poiButton:SetParent(Minimap)
					poi.poiButton = nil
				end
				if poi.useArrow then
					poi.arrow:Hide()
				end
				poi.active = false
			end
		end
		
		if not playerPosition.x and not playerPosition.y then return end
		if db.general.show and db.minimap.show then
			local sites = digsites[continentMapToID[playerContinent]]
			if not sites or (#sites == 0) then return end
			local i = 1
			for _, site in pairs(sites) do
				if not db.minimap.nearest or (db.minimap.nearest and nearestSite and nearestSite.id == site.id) then
					-- check to see if the poi exists
					local exists = false
					for poiIndex, poiObj in pairs(pois) do
						if poiObj.siteId == site.id and not poiObj.surveyNum and poiObj.active then
							exists = true
							break
						end
					end
					if not exists then
						while pois[i] and pois[i].active do i = i + 1 end
						-- i = i + 1
						local poi = CreateMinimapPOI(i, "site", { map = site.map, level = site.level, x = site.x, y = site.y }, site.name .. "\n" .. L["Zone: "] .. site.zoneName)
						astrolabe:PlaceIconOnMinimap(poi, site.map, site.level, site.x, site.y)
					end
					
					if nearestSite and db.minimap.fragmentNodes and nearestSite.id == site.id then
						if Archy.db.global.surveyNodes[site.id] then
							for surveyNum, node in pairs(Archy.db.global.surveyNodes[site.id]) do
								local exists = false
								for poiIndex, poiObj in pairs(pois) do
									if poiObj.siteId == site.id and poiObj.surveyNum == surveyNum and poiObj.active then
										exists = true
										break
									end
								end
								if not exists then
									while pois[i] and pois[i].active do i = i + 1 end
									local nodePoi = CreateMinimapPOI(i, "survey", { map = node.m, level = node.f, x = node.x, y = node.y }, L["Survey"] .. " #" .. surveyNum .. "\n" .. site.name .. "\n" .. L["Zone: "] .. site.zoneName, site.id, surveyNum)
									astrolabe:PlaceIconOnMinimap(nodePoi, node.m, node.f, node.x, node.y)
								end
							end
						end
					end
				end
			end
			UpdateMinimapEdges()
		end
	else
		if lastNearestSite then UpdateMinimapEdges() end
	end
end

function POI_OnEnter(self)
	if self.title then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
		GameTooltip:SetText(self.title, NORMAL_FONT_COLOR[1], NORMAL_FONT_COLOR[2], NORMAL_FONT_COLOR[3], 1) --, true)
	end
end

function POI_OnLeave(self)
	GameTooltip:Hide()
end

local square_half = math.sqrt(0.5)
local rad_135 = math.rad(135)
local update_threshold = 0.1
function Arrow_OnUpdate(self, elapsed)
	self.t = self.t + elapsed
	if self.t < update_threshold then
		return
	end
	self.t = 0
	
	local angle = astrolabe:GetDirectionToIcon(self.poi)
	angle = angle + rad_135

	if GetCVar("rotateMinimap") == "1" then
		angle = angle - GetPlayerFacing()
	end
	
	if angle == self.last_angle then
		return
	end
	self.last_angle = angle
	
	--rotate the texture
	local sin,cos = math.sin(angle) * square_half, math.cos(angle) * square_half
	self.texture:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
end

--[[ Blob Functions ]]--
function RefreshBlobInfo(f)
	f:DrawNone()
	local numEntries = ArchaeologyMapUpdateAll()
	for i = 1, numEntries do
		local blobID = ArcheologyGetVisibleBlobID(i)
		f:DrawBlob(blobID, true)
	end
end

function MinimapBlobSetPositionAndSize(f)
	if not f or not playerPosition.x or not playerPosition.y then return end
	local dx = (playerPosition.x - 0.5) * f:GetWidth()
	local dy = (playerPosition.y - 0.5) * f:GetHeight()
	f:ClearAllPoints()
	f:SetPoint("CENTER", Minimap, "CENTER", -dx, dy)

	local mapWidth = f:GetParent():GetWidth()
	local mapHeight = f:GetParent():GetHeight()
	local mapSizePix = math.min(mapWidth, mapHeight)

	local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	local zoom = Minimap:GetZoom()
	local mapSizeYards = minimapSize[indoors][zoom]

	if not playerPosition.map or playerPosition.map == -1 then return end
	
	local _, _, yw, yh, _, _ = astrolabe:GetMapInfo(playerPosition.map, playerPosition.level)
	local pw = yw*mapSizePix/mapSizeYards
	local ph = yh*mapSizePix/mapSizeYards

	if pw==old_pw and ph==oldph then return end
	old_pw, old_ph = pw, ph

	f:SetSize(pw, ph)
	
	f:SetFillAlpha(256 * db.minimap.blobAlpha)
--	f:SetFrameStrata("LOW")
--	f:SetFrameLevel(f:GetParent():GetFrameLevel() + 7)
end

function UpdateSiteBlobs()
	if IsTaintable() then return end			-- Cannot update this during combat as it's a protected frame
	if BattlefieldMinimap then
		if db.minimap.zoneBlob and db.general.show and not IsInInstance() then
			local blob = blobs["Battlefield"]
			if blob:GetParent() ~= BattlefieldMinimap then -- set the battlefield map parent
				blob:SetParent(BattlefieldMinimap) 
				blob:ClearAllPoints()
				blob:SetAllPoints(BattlefieldMinimap)
				blob:SetFrameLevel(BattlefieldMinimap:GetFrameLevel() + 2)
			end
			RefreshBlobInfo(blob)
			if not blob:IsShown() then blob:Show() end
		elseif blobs["Battlefield"]:IsShown() then
			blobs["Battlefield"]:Hide()
		end
	end

	if db.minimap.show and db.minimap.blob and db.general.show and not IsInInstance() then
		local blob = blobs["Minimap"]
		if blob:GetParent() ~= Minimap then				-- set the minimap parent
			blob:SetParent(Minimap)
			blob:SetFrameLevel(Minimap:GetFrameLevel() + 2)
		end
		
		if (db.minimap.useBlobDistance and nearestSite and nearestSite.distance and (nearestSite.distance > db.minimap.blobDistance)) then
			if blob:IsShown() then blob:Hide() end
			return
		end

		RefreshBlobInfo(blob)
		MinimapBlobSetPositionAndSize(blob)
		if not blob:IsShown() then blob:Show() end
		
		
	elseif blobs["Minimap"]:IsShown() then
		blobs["Minimap"]:Hide()
	end
end


--[[ TomTom Functions ]]--
-- clear the waypoint we gave tomtom
function ClearTomTomPoint()
	if tomtomPoint then
		tomtomPoint = TomTom:RemoveWaypoint(tomtomPoint)
	end
end

function UpdateTomTomPoint()
	if not tomtomSite and not nearestSite then
		-- we have no information to pass tomtom
		ClearTomTomPoint()
		return
	end
	
	if not nearestSite then nearestSite = tomtomSite else tomtomSite = nearestSite end
	if not tomtomFrame then tomtomFrame = CreateFrame("Frame") end
	if not tomtomFrame:IsShown() then tomtomFrame:Show() end
	
	local waypointExists
	if TomTom.WaypointExists then	-- do we have the legit TomTom?
		waypointExists = TomTom:WaypointExists(continentMapToID[tomtomSite.continent], tomtomSite.zoneId, tomtomSite.x * 100, tomtomSite.y * 100, tomtomSite.name .. "\n" .. tomtomSite.zoneName)
	end
	
	if not waypointExists then	-- waypoint doesn't exist or we have a TomTom emulator
		ClearTomTomPoint()
		tomtomPoint = TomTom:AddZWaypoint(continentMapToID[tomtomSite.continent], tomtomSite.zoneId, tomtomSite.x * 100, tomtomSite.y * 100, tomtomSite.name .. "\n" .. tomtomSite.zoneName, false, false, false, false, false, true)
	end
end

function RefreshTomTom()
	if db.general.show and db.tomtom.enabled and tomtomExists and tomtomActive then
		UpdateTomTomPoint()
	else
		if db.tomtom.enabled and not tomtomExists then db.tomtom.enabled = false; Archy:Print("TomTom doesn't exist... disabling it"); end		-- TomTom (or emulator) was disabled, disabling TomTom support
		if tomtomPoint then			-- Clear the waypoint in TomTom if we had one
			ClearTomTomPoint()
			tomtomPoint = nil
		end
		if tomtomFrame then			-- Hide TomTom if it was visible
			if tomtomFrame:IsShown() then tomtomFrame:Hide() end
			tomtomFrame = nil
		end
	end
end

--[[ LibDataBroker functions ]]--
local myProvider, cellPrototype = qtip:CreateCellProvider()
function cellPrototype:InitializeCell()
	local bar = self:CreateTexture(nil, "OVERLAY", self)
	self.bar = bar
	bar:SetWidth(100)
	bar:SetHeight(12)
	bar:SetPoint("LEFT", self, "LEFT", 1, 0)
	
	local bg = self:CreateTexture(nil, "BACKGROUND")
	self.bg = bg
	bg:SetWidth(102)
	bg:SetHeight(14)
	bg:SetTexture(0,0,0,0.5)
	bg:SetPoint("LEFT", self)
	
	local fs = self:CreateFontString(nil, "OVERLAY")
	self.fs = fs
	fs:SetAllPoints(self)
	fs:SetFontObject(GameTooltipText)
	fs:SetShadowColor(0,0,0)
	fs:SetShadowOffset(1, -1)
	self.r, self.g, self.b = 1, 1, 1
end
 
function cellPrototype:SetupCell(tooltip, value, justification, font, r, g, b)
	local barTexture = [[Interface\TargetingFrame\UI-StatusBar]]
	local bar = self.bar
	local fs = self.fs
--[[	{ 
	1 artifact['fragments'], 
	2 artifact['fragAdjust'], 
	3 artifact['fragTotal'], 
	4 raceData[rid]['keystone']['inventory'], 
	5 artifact['sockets'], 
	6 artifact['stonesAdded'], 
	7 artifact['canSolve'], 
	8 artifact['canSolveStone'],
	9 artifact['rare'] }
]]

	local perc = min((value[1] + value[2]) / value[3] * 100, 100)
	
	if value[7] then 
		self.r, self.g, self.b = db.artifact.fragmentBarColors["Solvable"].r, db.artifact.fragmentBarColors["Solvable"].g, db.artifact.fragmentBarColors["Solvable"].b
	elseif value[8] then
		self.r ,self.g, self.b = db.artifact.fragmentBarColors["AttachToSolve"].r, db.artifact.fragmentBarColors["AttachToSolve"].g, db.artifact.fragmentBarColors["AttachToSolve"].b
	elseif value[9] then
		self.r, self.g, self.b = db.artifact.fragmentBarColors["Rare"].r, db.artifact.fragmentBarColors["Rare"].g, db.artifact.fragmentBarColors["Rare"].b
	else
		self.r, self.g, self.b = db.artifact.fragmentBarColors["Normal"].r, db.artifact.fragmentBarColors["Normal"].g, db.artifact.fragmentBarColors["Normal"].b
	end
	bar:SetVertexColor(self.r, self.g, self.b)
	bar:SetWidth(perc)
	bar:SetTexture(barTexture)
	bar:Show()
	fs:SetFontObject(font or tooltip:GetFont())
	fs:SetJustifyH("CENTER")
	fs:SetTextColor(1,1,1)
	
	local adjust = ""
	if value[2] > 0 then
		adjust = "(+" .. tostring(value[2]) .. ")"
	end
	local frags = string.format("%d%s / %d", value[1], adjust, value[3])
	
	fs:SetText(frags)
	fs:Show()

	return bar:GetWidth() + 2, bar:GetHeight() + 2
end
 
function cellPrototype:ReleaseCell()
   self.r, self.g, self.b = 1, 1, 1
end

function cellPrototype:getContentHeight()
	return self.bar:GetHeight() + 2
end

function ldb:OnEnter()
	local numCols, colIndex, line = 10, 0, 0
	local tooltip = qtip:Acquire("ArchyTooltip", numCols, "CENTER", "LEFT", "LEFT", "LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT")
	self.tooltip = tooltip
	tooltip:SetScale(1)
	tooltip:SetAutoHideDelay(0.1, self);
	tooltip:Hide();
	tooltip:Clear();
	
	local line = tooltip:AddHeader(".")
	tooltip:SetCell(line, 1, string.format("%s%s%s", ORANGE_FONT_COLOR_CODE, L["Archy"], "|r"), "CENTER", numCols)
	if HasArchaeology() then
		line = tooltip:AddLine(".")
		local rank, maxRank = GetArchaeologyRank()
		local skill = string.format("%d/%d", rank, maxRank)
		if maxRank < MAX_ARCHAEOLOGY_RANK and (maxRank - rank) <= 25 then
			skill = string.format("%s - |cFFFF0000%s|r", skill, L["Visit a trainer!"])
		elseif maxRank == MAX_ARCHAEOLOGY_RANK and rank == maxRank then
			skill = string.format("%s%s|r", GREEN_FONT_COLOR_CODE, "MAX")
		end
		tooltip:SetCell(line, 1, string.format("%s%s|r%s", NORMAL_FONT_COLOR_CODE, L["Skill: "], skill), "CENTER", numCols)
		
		line = tooltip:AddLine("."); tooltip:SetCell(line, 1, string.format("%s%s|r", "|cFFFFFF00", L["Artifacts"]), "LEFT", numCols);
		line = tooltip:AddLine(".")
		tooltip:SetCell(line, 1, " ", "LEFT", 1)
		tooltip:SetCell(line, 2, NORMAL_FONT_COLOR_CODE .. L["Race"] .. "|r", "LEFT", 1)
		tooltip:SetCell(line, 3, " ", "LEFT", 1)
		tooltip:SetCell(line, 4, NORMAL_FONT_COLOR_CODE .. L["Artifact"] .. "|r", "LEFT", 2)
		tooltip:SetCell(line, 6, NORMAL_FONT_COLOR_CODE .. L["Progress"] .. "|r", "CENTER", 1)
		tooltip:SetCell(line, 7, NORMAL_FONT_COLOR_CODE .. L["Keys"] .. "|r", "CENTER", 1)
		tooltip:SetCell(line, 8, NORMAL_FONT_COLOR_CODE .. L["Sockets"] .. "|r", "CENTER", 1)
		tooltip:SetCell(line, 9, NORMAL_FONT_COLOR_CODE .. L["Completed"] .. "|r", "CENTER", 2)
		
		for rid, artifact in pairs(artifacts) do
			if artifact['fragTotal'] > 0 then
				line = tooltip:AddLine(" ")
				tooltip:SetCell(line, 1, " " .. format("|T%s:18:18:0:1:128:128:4:60:4:60|t", raceData[rid]['texture']), "LEFT", 1);
				tooltip:SetCell(line, 2, raceData[rid]['name'], "LEFT", 1)
				tooltip:SetCell(line, 3, " " .. format("|T%s:18:18|t", artifact['icon']), "LEFT", 1);
				local artifactName = artifact['name']
				if artifact['rare'] then artifactName = string.format("%s%s|r", "|cFF0070DD", artifactName) end
				tooltip:SetCell(line, 4, artifactName, "LEFT", 2)

				tooltip:SetCell(line, 6, { artifact['fragments'], artifact['fragAdjust'], artifact['fragTotal'], raceData[rid]['keystone']['inventory'], artifact['sockets'], artifact['stonesAdded'], artifact['canSolve'], artifact['canSolveStone'], artifact['rare'] }, myProvider, 1, 0, 0)
				tooltip:SetCell(line, 7, (raceData[rid]['keystone']['inventory'] > 0) and raceData[rid]['keystone']['inventory'] or "", "CENTER", 1)
				tooltip:SetCell(line, 8, (artifact['sockets'] > 0) and artifact['sockets'] or "", "CENTER", 1)
				
				local _, _, completionCount = GetArtifactStats(rid, artifact['name'])
				tooltip:SetCell(line, 9, (completionCount or "unknown"), "CENTER", 2)
			end
		end
		
		line = tooltip:AddLine(" "); line = tooltip:AddLine(" ");
		tooltip:SetCell(line, 1, string.format("%s%s|r", "|cFFFFFF00", L["Dig Sites"]), "LEFT", numCols);
		for cid, csites in pairs(digsites) do
			if (#csites > 0) and (cid == continentMapToID[playerContinent] or not db.digsite.filterLDB) then
				local continentName
				for _, zone in pairs(zoneData) do
					if zone['continent'] == cid and zone['id'] == 0 then
						continentName = zone['name']
						break
					end
				end
				line = tooltip:AddLine(" ")
				tooltip:SetCell(line, 1,"  " .. ORANGE_FONT_COLOR_CODE .. continentName .. "|r", "LEFT", numCols);
		
				line = tooltip:AddLine(" ");
				tooltip:SetCell(line, 1, " ", "LEFT", 1);
				tooltip:SetCell(line, 2, NORMAL_FONT_COLOR_CODE .. L["Fragment"] .. "|r", "LEFT", 2);
				tooltip:SetCell(line, 4, NORMAL_FONT_COLOR_CODE .. L["Dig Site"] .. "|r", "LEFT", 1);
				tooltip:SetCell(line, 5, NORMAL_FONT_COLOR_CODE .. L["Zone"] .. "|r", "LEFT", 2);
				tooltip:SetCell(line, 7, NORMAL_FONT_COLOR_CODE .. L["Surveys"] .. "|r", "CENTER", 1);
				tooltip:SetCell(line, 8, NORMAL_FONT_COLOR_CODE .. L["Digs"] .. "|r", "CENTER", 1);
				tooltip:SetCell(line, 9, NORMAL_FONT_COLOR_CODE .. L["Frags"] .. "|r", "CENTER", 1);
				tooltip:SetCell(line, 10, NORMAL_FONT_COLOR_CODE .. L["Keys"] .. "|r", "CENTER", 1);
				
				for _, site in pairs(csites) do
					line = tooltip:AddLine(" ")
					tooltip:SetCell(line, 1, " " .. format("|T%s:18:18:0:1:128:128:4:60:4:60|t", raceData[site['raceId']]['texture']), "LEFT", 1);
					tooltip:SetCell(line, 2, raceData[site['raceId']]['name'], "LEFT", 2);
					tooltip:SetCell(line, 4, site['name'], "LEFT", 1);
					tooltip:SetCell(line, 5, site['zoneName'], "LEFT", 2);
					tooltip:SetCell(line, 7, siteStats[site['id']]['surveys'], "CENTER", 1);
					tooltip:SetCell(line, 8, siteStats[site['id']]['looted'], "CENTER", 1);
					tooltip:SetCell(line, 9, siteStats[site['id']]['fragments'], "CENTER", 1);
					tooltip:SetCell(line, 10, siteStats[site['id']]['keystones'], "CENTER", 1);
				end
				line = tooltip:AddLine(" ")
			end
		end
		
		
	else
		line = tooltip:AddLine(" ");
		tooltip:SetCell( line, 1, L["Learn Archaeology in your nearest major city!"], "CENTER", numCols);
	end
	
	line = tooltip:AddLine(" ");
	line = tooltip:AddLine(" "); tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Left-Click to toggle Archy"] .. "|r", "LEFT", numCols);
	line = tooltip:AddLine(" "); tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Shift Left-Click to toggle Archy's on-screen lists"] .. "|r", "LEFT", numCols);
	line = tooltip:AddLine(" "); tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Right-Click to lock/unlock Archy"] .. "|r", "LEFT", numCols);
	line = tooltip:AddLine(" "); tooltip:SetCell(line, 1, "|cFF00FF00" .. L["Middle-Click to display the Archaeology window"] .. "|r", "LEFT", numCols);
	
	tooltip:EnableMouse();
	tooltip:SmartAnchorTo(self);
	tooltip:UpdateScrolling();
	tooltip:Show()
end

function ldb:OnLeave()
	qtip:Release(self.tooltip)
	self.tooltip = nil
end

function ldb:OnClick(button, down)
	
	if button == "LeftButton" and IsShiftKeyDown() then
		db.general.stealthMode = not db.general.stealthMode
		Archy:ConfigUpdated()
	elseif button == "LeftButton" and IsControlKeyDown() then
		InterfaceOptionsFrame_OpenToCategory(Archy.optionsFrame)
	elseif button == "LeftButton" then
		db.general.show = not db.general.show
		Archy:ConfigUpdated()
		HideDistanceIndicator()
		ShowDistanceIndicator()
	elseif button == "RightButton" then
		ToggleLock()
	elseif button == "MiddleButton" then
		Archy:ShowArchaeology()
	end
end


--[[ Slash command handler ]]--
local function SlashHandler(msg, editbox)
	local command = string.lower(msg) -- , args = string.match(msg:lower(), "^(%S*)%s*(.-)$")
	if command == L["config"]:lower() then
		InterfaceOptionsFrame_OpenToCategory(Archy.optionsFrame)
	elseif command == L["stealth"]:lower() then
		db.general.stealthMode = not db.general.stealthMode
		Archy:ConfigUpdated()
	elseif command == L["dig sites"]:lower() then
		db.digsite.show = not db.digsite.show
		Archy:ConfigUpdated('digsite')
	elseif command == L["artifacts"]:lower() then
		db.artifact.show = not db.artifact.show
		Archy:ConfigUpdated('artifact')
	elseif command == L["solve"]:lower() then
		Archy:SolveAnyArtifact()
	elseif command == L["solve stone"]:lower() then
		Archy:SolveAnyArtifact(true)
	elseif command == L["nearest"]:lower() or command == L["closest"]:lower() then
		AnnounceNearestSite()
	elseif command == L["reset"]:lower() then
		ResetPositions()
	elseif command == L["tomtom"]:lower() then
		db.tomtom.enabled = not db.tomtom.enabled
		RefreshTomTom()
	elseif command == L["minimap"]:lower() then
		db.minimap.show = not db.minimap.show
		Archy:ConfigUpdated('minimap')
	elseif command == "test" then
		racesFrame:SetBackdropBorderColor(1,1,1,0.5)
	else
		Archy:Print(L["Available commands are:"])
		Archy:Print("|cFF00FF00" .. L["config"] .. "|r - " .. L["Shows the Options"])
		Archy:Print("|cFF00FF00" .. L["stealth"] .. "|r - " .. L["Toggles the display of the Artifacts and Dig Sites lists"])
		Archy:Print("|cFF00FF00" .. L["dig sites"] .. "|r - " .. L["Toggles the display of the Dig Sites list"])
		Archy:Print("|cFF00FF00" .. L["artifacts"] .. "|r - " .. L["Toggles the display of the Artifacts list"])
		Archy:Print("|cFF00FF00" .. L["solve"] .. "|r - " .. L["Solves the first artifact it finds that it can solve"])
		Archy:Print("|cFF00FF00" .. L["solve stone"] .. "|r - " .. L["Solves the first artifact it finds that it can solve (including key stones)"])
		Archy:Print("|cFF00FF00" .. L["nearest"] .. "|r or |cFF00FF00" .. L["closest"] .. "|r - " .. L["Announces the nearest dig site to you"])
		Archy:Print("|cFF00FF00" .. L["reset"] .. "|r - " .. L["Reset the window positions to defaults"])
		Archy:Print("|cFF00FF00" .. L["tomtom"] .. "|r - " .. L["Toggles TomTom Integration"])
		Archy:Print("|cFF00FF00" .. L["minimap"] .. "|r - " .. L["Toggles the dig site icons on the minimap"])
	end
end


--[[ AddOn Initialization ]]--
function Archy:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("ArchyDB", 	defaults, 'Default')
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileUpdate")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileUpdate")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileUpdate")

	if LibStub:GetLibrary("LibAboutPanel", true) then
		self.optionsFrame = LibStub:GetLibrary("LibAboutPanel").new(nil, "Archy")
	else
		self:Print("Lib AboutPanel not loaded.")
	end

	self:SetSinkStorage(Archy.db.profile.general.sinkOptions)

	generalOptions.args.output = Archy:GetSinkAce3OptionsDataTable()
	generalOptions.args.output.guiInline = true
	generalOptions.args.output.name = L["Announcements Output"]
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy General", generalOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy Artifacts", artifactOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy Dig Sites", digsiteOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy TomTom", tomtomOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy Minimap", minimapOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy Data", archyDataOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Archy Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy General", L["General"], "Archy")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy Artifacts", L["Artifacts"], "Archy")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy Dig Sites", L["Dig Sites"], "Archy")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy TomTom", L["TomTom Support"], "Archy")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy Minimap", L["Minimap"], "Archy")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy Data", L["Import Data"], "Archy")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Archy Profiles", L["Profiles"], "Archy")
	
	if not Archy.db.global.surveyNodes then Archy.db.global.surveyNodes = {} end
	Archy.db.char.digsites = Archy.db.char.digsites or { stats = {}, blacklist = {} }
	if not Archy.db.char.digsites.stats then Archy.db.char.digsites.stats = {} end
	if not Archy.db.char.digsites.blacklist then Archy.db.char.digsites.blacklist = {} end
	
	siteStats = Archy.db.char.digsites.stats
	setmetatable(siteStats, { __index = function(t, k) if k then t[k] = { ['surveys'] = 0, ['fragments'] = 0, ['looted'] = 0, ['keystones'] = 0, ['counter'] = 0 }; return t[k]; end end })
	
	siteBlacklist = Archy.db.char.digsites.blacklist
	setmetatable(siteBlacklist, {__index = function(t, k) if k then t[k] = false; return t[k]; end end })
	
	db = self.db.profile
	if not db.data then db.data = {} end
	db.data.imported = false
	
	digsiteFrame = CreateFrame("Frame", "ArchyDigSiteFrame", UIParent, "ArchyDigSiteContainer")
	digsiteFrame.children = setmetatable({}, {
	__index = function(t,k)
		if k then
			local f = CreateFrame("Frame", "ArchyDigSiteChildFrame" .. k, digsiteFrame, "ArchyDigSiteRowTemplate")
			f:Show()
			t[k] = f
			return f
		end
	end })
	racesFrame = CreateFrame("Frame", "ArchyArtifactFrame", UIParent, "ArchyArtifactContainer")
	racesFrame.children = setmetatable({}, {
	__index = function(t,k)
		if k then
			local f = CreateFrame("Frame", "ArchyArtifactChildFrame" .. k, racesFrame, "ArchyArtifactRowTemplate")
			f:Show()
			t[k] = f
			return f
		end
	end })
	
	distanceIndicatorFrame = CreateFrame("Frame", "ArchyDistanceIndicatorFrame", UIParent, "ArchyDistanceIndicator")
	local surveySpellName = GetSpellInfo(80451)
	distanceIndicatorFrame.surveyButton:SetText(surveySpellName)
	distanceIndicatorFrame.surveyButton:SetWidth(distanceIndicatorFrame.surveyButton:GetTextWidth()+ 20)
	distanceIndicatorFrame.circle:SetScale(0.65)

	self:UpdateFramePositions()
	
	icon:Register("ArchyLDB", ldb, db.general.icon)
	
	TrapWorldMouse()
	
	self:ImportOldStatsDB()
end

function Archy:UpdateFramePositions()
	self:SetFramePosition(distanceIndicatorFrame)
	self:SetFramePosition(digsiteFrame)
	self:SetFramePosition(racesFrame)
end

function Archy:OnEnable()
	--@TODO Setup and register the options table
	
	_G["SLASH_ARCHY1"] = "/archy"
	_G.SlashCmdList["ARCHY"] = SlashHandler
	--self:SecureHook("SetCVar")
	
	self:RegisterEvent("ARTIFACT_HISTORY_READY", "ArtifactHistoryReady")
--	self:RegisterEvent("ARTIFACT_UPDATE", "ArtifactUpdated")
	self:RegisterEvent("LOOT_OPENED", "OnPlayerLooting")
	self:RegisterEvent("LOOT_CLOSED", "OnPlayerLooting")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerLogin")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CombatStateChanged")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CombatStateChanged")
	self:RegisterEvent("ARTIFACT_COMPLETE", "ArtifactCompleted")
	self:RegisterEvent("ARTIFACT_DIG_SITE_UPDATED", "DigSitesUpdated")
	self:RegisterEvent("BAG_UPDATE", "BagUpdated")
	self:RegisterEvent("SKILL_LINES_CHANGED", "SkillLinesChanged")
	self:RegisterEvent("CHAT_MSG_LOOT", "LootReceived")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "PlayerCastSurvey")
	self:RegisterEvent("CURRENCY_DISPLAY_UPDATE", "CurrencyUpdated")

	self:ScheduleTimer("UpdatePlayerPosition", 1, true)
	timerID = self:ScheduleRepeatingTimer("UpdatePlayerPosition", 0.1)

	db.general.locked = false
	
	Archy:UpdateDigSiteFrame()
	Archy:UpdateRacesFrame()
	HideDistanceIndicator()
	ShowDistanceIndicator()
	tomtomActive = true
	tomtomExists = (TomTom and TomTom.AddZWaypoint and TomTom.RemoveWaypoint) and true or false
end

function Archy:OnDisable()

--	self:UnregisterEvent("ARTIFACT_HISTORY_READY")
--	self:UnregisterEvent("ARTIFACT_UPDATE")
	self:UnregisterEvent("ARTIFACT_COMPLETE")
	self:UnregisterEvent("ARTIFACT_DIG_SITE_UPDATED")
	self:UnregisterEvent("BAG_UPDATE")
	self:UnregisterEvent("SKILL_LINES_CHANGED")
	self:UnregisterEvent("CHAT_MSG_LOOT")
	self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
	self:CancelTimer(timerID)
	--self:SecureHook("SetCVar")
end

function Archy:OnProfileUpdate()
	db = self.db.profile
end

--[[ Event Handlers ]]--
function Archy:ArtifactHistoryReady()
	for rid, artifact in pairs(artifacts) do
		local _, _, completionCount = GetArtifactStats(rid, artifact['name'])
		if completionCount then
			artifact['completionCount'] = completionCount
		end
	end
	self:RefreshRacesDisplay()
end

function Archy:ArtifactUpdated()
	-- ignore this event for now as it's can break other Archaeology UIs
	-- Would have been nice if Blizzard passed the race index or artifact name with the event
end

function Archy:ArtifactCompleted()
	archRelatedBagUpdate = true
end

function Archy:DigSitesUpdated()
	if not playerContinent then return end
	UpdateSites()
	self:UpdateSiteDistances()
	self:RefreshDigSiteDisplay()
end

function Archy:BagUpdated()
	if not playerContinent then return end
	if not archRelatedBagUpdate then return end
	
	-- perform an artifact refresh here
	if keystoneLootRaceID then
		UpdateRaceArtifact(keystoneLootRaceID)
		self:ScheduleTimer("RefreshRacesDisplay", 0.5)
		keystoneLootRaceID = nil
	end
	
	archRelatedBagUpdate = false
end

function Archy:SkillLinesChanged()
	if not playerContinent then return end
	
	if racesFrame and racesFrame.skillBar then
		local rank, maxRank = GetArchaeologyRank()
		racesFrame.skillBar:SetMinMaxValues(0, maxRank)
		racesFrame.skillBar:SetValue(rank)
		racesFrame.skillBar.text:SetText(string.format("%s : %d/%d", GetArchaeologyInfo(), rank, maxRank))
	end
end

function Archy:LootReceived(event, msg)
	local _, itemLink, amount = ParseLootMessage(msg)
	if not itemLink then return end
	local itemID = GetIDFromLink(itemLink)
	local rid = keystoneIDToRaceID[itemID]
	if rid then
		siteStats[lastSite.id]['keystones'] = siteStats[lastSite.id]['keystones'] + 1
		keystoneLootRaceID = rid
		archRelatedBagUpdate = true
	end
end

function Archy:PlayerCastSurvey(event, unit, spell, _, _, spellid)
	if unit ~= "player" or spellid ~= 80451 then return end
	surveyPosition = playerPosition and { x = playerPosition.x, y = playerPosition.y, map = playerPosition.map, level = playerPosition.level } or nil

	if surveyPosition then
		lastSite = nearestSite
		siteStats[lastSite.id]['surveys'] = siteStats[lastSite.id]['surveys'] + 1

		distanceIndicatorActive = true
		ShowDistanceIndicator()
		UpdateDistanceIndicator()

		tomtomActive = false
		RefreshTomTom()
		self:RefreshDigSiteDisplay()
	end
end

function Archy:CurrencyUpdated()
	if not playerContinent then return end
	if GetNumArchaeologyRaces() == 0 then return end
	
	for rid = 1, GetNumArchaeologyRaces() do
		local cid = raceData[rid]['currency']['id']
		local _, currencyAmount = GetCurrencyInfo(cid)
		local diff = currencyAmount - (currencyData[cid] or 0)
		currencyData[cid] = currencyAmount
		if diff < 0 then
			-- we've spent fragments, aka. Solved an artifact
			artifacts[rid]['stonesAdded'] = 0
			
			if artifactSolved['raceId'] > 0 then
				-- announce that we have solved an artifact
				local _, _, completionCount = GetArtifactStats(rid, artifactSolved['name'])
				local text = string.format(L["You have solved %s Artifact - %s (Times completed: %d)"], "|cFFFFFF00" .. raceData[rid]['name'] .. "|r", "|cFFFFFF00" .. artifactSolved['name'] .. "|r", (completionCount or 0))
				self:Pour(text, 1, 1, 1)
				
				-- reset it since we know it's been solved
				artifactSolved['raceId'] = 0
				artifactSolved['name'] = ''
				self:RefreshRacesDisplay()
			end
			
		elseif diff > 0 then
			-- we've gained fragments, aka. Successfully dug at a dig site
		
			-- update the artifact info
			UpdateRaceArtifact(rid)

			-- deactivate the distance indicator
			distanceIndicatorActive = false
			HideDistanceIndicator()
			
			-- Increment the site stats
			IncrementDigCounter(lastSite.id)
			siteStats[lastSite.id].looted = (siteStats[lastSite.id].looted or 0) + 1
			siteStats[lastSite.id].fragments = siteStats[lastSite.id].fragments + diff
			
			AddSurveyNode(lastSite.id, playerPosition.map, playerPosition.level, playerPosition.x, playerPosition.y)
			surveyPosition.map, surveyPosition.level, surveyPosition.x, surveyPosition.y = 0, 0, 0, 0		-- clear the last survey position
			UpdateMinimapPOIs(true)
			self:RefreshRacesDisplay()
			self:RefreshDigSiteDisplay()
		end
	end
end

function Archy:CombatStateChanged(event)
	if event == "PLAYER_REGEN_DISABLED" then
		inCombat = true
		blobs["Minimap"]:DrawNone()
	elseif event == "PLAYER_REGEN_ENABLED" then
		inCombat = false
	end
end


--[[ Positional functions ]]--
function Archy:UpdatePlayerPosition(force)
	if not HasArchaeology() then return end
	if (GetCurrentMapAreaID() == -1) then return end
	local map, level, x, y = astrolabe:GetCurrentPlayerPosition()
	if x == 0 and y == 0 then return end
	if not map or not level then return end

	local continent = astrolabe:GetMapInfo(map, level)
	if playerPosition.x ~= x or playerPosition.y ~= y or playerPosition.map ~= map or playerPosition.level ~= level or force then
		playerPosition.x, playerPosition.y, playerPosition.map, playerPosition.level = x, y, map, level

		-- player location has changed
		if not IsInInstance() then
			self:UpdateSiteDistances()
			UpdateDistanceIndicator()
			UpdateMinimapPOIs()
			UpdateSiteBlobs()
		end
		self:UpdateDigSiteFrame()
		self:RefreshDigSiteDisplay()
	end
	
	if playerContinent ~= continent then 		-- we have switch continents or moved into an instance, battleground or something similar
--		print("---- PLAYER CHANGED CONTINENT TO : ", continent, "-----")
		playerContinent = continent
		
		if (#raceData == 0) then LoadRaceData() end
		ClearTomTomPoint()
		RefreshTomTom()
		UpdateSites()
		
		if GetNumArchaeologyRaces() > 0 then 
			for rid = 1,GetNumArchaeologyRaces() do
				UpdateRaceArtifact(rid)
			end
			self:UpdateRacesFrame()
			self:RefreshRacesDisplay()
		end
		self:UpdateDigSiteFrame()
		self:RefreshDigSiteDisplay()
		self:UpdateFramePositions()
	end
end


--[[ UI functions ]]--
local function TransformSiteFrame(frame)

	if db.digsite.style == "Compact" then
		frame.crest:SetWidth(20)
		frame.crest:SetHeight(20)
		frame.crest.icon:SetWidth(20)
		frame.crest.icon:SetHeight(20)
		frame.zone:Hide()
		frame.distance:Hide()
		frame:SetHeight(24)
	else
		frame.crest:SetWidth(40)
		frame.crest:SetHeight(40)
		frame.crest.icon:SetWidth(40)
		frame.crest.icon:SetHeight(40)
		frame.zone:Show()
		frame.distance:Show()
		frame:SetHeight(40)
	end
end

local function TransformRaceFrame(frame)
	if db.artifact.style == "Compact" then
		--[[
		frame.icon:Hide()
]]
		
		frame.crest:ClearAllPoints()
		frame.crest:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		
		frame.icon:ClearAllPoints()
		frame.icon:SetPoint("LEFT", frame.crest, "RIGHT", 0, 0)
		frame.icon:SetWidth(32)
		frame.icon:SetHeight(32)
		frame.icon.texture:SetWidth(32)
		frame.icon.texture:SetHeight(32)
--		frame.fragmentBar:ClearAllPoints()
--		frame.fragmentBar:SetPoint("LEFT", frame.icon, "RIGHT", 5, 0)
		
		
		frame.crest.text:Hide()
		frame.crest:SetWidth(36)
		frame.crest:SetHeight(36)
		frame.solveButton:SetText("")
		frame.solveButton:SetWidth(34)
		frame.solveButton:SetHeight(34)
		frame.solveButton:SetNormalTexture([[Interface\ICONS\TRADE_ARCHAEOLOGY_AQIR_ARTIFACTFRAGMENT.BLP]])
		frame.solveButton:SetDisabledTexture([[Interface\ICONS\TRADE_ARCHAEOLOGY_AQIR_ARTIFACTFRAGMENT.BLP]])
		frame.solveButton:GetDisabledTexture():SetBlendMode("MOD")
		
		frame.solveButton:ClearAllPoints()
		frame.solveButton:SetPoint("LEFT", frame.fragmentBar, "RIGHT", 5, 0)
		frame.fragmentBar.fragments:ClearAllPoints()
		frame.fragmentBar.fragments:SetPoint("RIGHT", frame.fragmentBar.keystones, "LEFT", -7, 2)
		frame.fragmentBar.keystone1:Hide()
		frame.fragmentBar.keystone2:Hide()
		frame.fragmentBar.keystone3:Hide()
		frame.fragmentBar.keystone4:Hide()
		frame.fragmentBar.artifact:SetWidth(160)

		frame:SetWidth(315 + frame.solveButton:GetWidth())
		frame:SetHeight(36)
	else
		frame.icon:ClearAllPoints()
		frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.icon:SetWidth(36)
		frame.icon:SetHeight(36)
		frame.icon.texture:SetWidth(36)
		frame.icon.texture:SetHeight(36)
	
	
	
		frame.icon:Show()
		frame.crest.text:Show()
		frame.crest:SetWidth(24)
		frame.crest:SetHeight(24)
		frame.crest:ClearAllPoints()
		frame.crest:SetPoint("TOPLEFT", frame.icon, "BOTTOMLEFT", 0, 0)
		frame.solveButton:SetHeight(24)
		frame.solveButton:SetNormalTexture(nil)
		frame.solveButton:SetDisabledTexture(nil)
		frame.solveButton:ClearAllPoints()
		frame.solveButton:SetPoint("TOPRIGHT", frame.fragmentBar, "BOTTOMRIGHT", 0, -3)
		frame.fragmentBar.fragments:ClearAllPoints()
		frame.fragmentBar.fragments:SetPoint("RIGHT", frame.fragmentBar, "RIGHT", -5, 2)
		frame.fragmentBar.keystones:Hide()
		frame.fragmentBar.artifact:SetWidth(200)

		frame:SetWidth(295)
		frame:SetHeight(70)
	end
end

function SetMovableState(self, value)
	self:SetMovable(value)
	self:EnableMouse(value)
	
	if value then self:RegisterForDrag("LeftButton")
	else self:RegisterForDrag() end
end

function Archy:UpdateRacesFrame()
	if IsTaintable() then return end
	racesFrame:SetScale(db.artifact.scale)
	racesFrame:SetAlpha(db.artifact.alpha)
	racesFrame:SetBackdropColor(1,1,1,db.artifact.bgAlpha)
	racesFrame:SetBackdropBorderColor(1,1,1,db.artifact.borderAlpha)
--	racesFrame:ClearAllPoints()
--	racesFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", db.artifact.positionX, db.artifact.positionY)
	SetMovableState(racesFrame, (not db.general.locked))

	local nFn = [[Fonts\FRIZQT__.TTF]]
	for _, f in pairs(racesFrame.children) do
		f.fragmentBar.artifact:SetFont(nFn, db.artifact.nameFontSize, db.artifact.nameFontOutline)
		f.fragmentBar.fragments:SetFont(nFn, db.artifact.keystoneFontSize, db.artifact.keystoneFontOutline)
	end

	if racesFrame:IsVisible() then
		if db.general.stealthMode or not db.artifact.show or ShouldBeHidden() then
			racesFrame:Hide()
		end
	else
		if not db.general.stealthMode and db.artifact.show and not ShouldBeHidden() then
			racesFrame:Show()
		end
	end
end

function Archy:UpdateDigSiteFrame()
	if IsTaintable() then return end
	digsiteFrame:SetScale(db.digsite.scale)
	digsiteFrame:SetAlpha(db.digsite.alpha)
	digsiteFrame:SetBackdropColor(1,1,1,db.digsite.bgAlpha)
	digsiteFrame:SetBackdropBorderColor(1,1,1,db.digsite.borderAlpha)
	--SetMovableState(digsiteFrame, (not db.general.locked))
	
	local nFn = [[Fonts\FRIZQT__.TTF]]
	for _, siteFrame in pairs(digsiteFrame.children) do
		siteFrame.site.name:SetFont(nFn, db.digsite.nameFontSize, db.digsite.nameFontOutline)
		siteFrame.digCounter.value:SetFont(nFn, db.digsite.nameFontSize, db.digsite.nameFontOutline)
		siteFrame.zone.name:SetFont(nFn, db.digsite.zoneFontSize, db.digsite.zoneFontOutline)
		siteFrame.distance.value:SetFont(nFn, db.digsite.zoneFontSize, db.digsite.zoneFontOutline)
	end
	

	local cid = continentMapToID[playerContinent]
	
	if digsiteFrame:IsVisible() then
		if db.general.stealthMode or not db.digsite.show or ShouldBeHidden() or not digsites[cid] or #digsites[cid] == 0 then
			digsiteFrame:Hide()
		end
	else
		if not db.general.stealthMode and db.digsite.show and not ShouldBeHidden() and digsites[cid] and #digsites[cid] > 0 then
			digsiteFrame:Show()
		end
	end
end

function Archy:RefreshRacesDisplay()
	if GetNumArchaeologyRaces() == 0 then return end
	if ShouldBeHidden() then return end
	
	local maxWidth, maxHeight = 0, 0
	self:SkillLinesChanged()
	
	local topFrame = racesFrame.container
	local hiddenAnchor = racesFrame
	local count = 0
	
	for _, child in pairs(racesFrame.children) do child:Hide() end
	for rid, race in pairs(raceData) do
		local child = racesFrame.children[rid]
		local artifact = artifacts[rid]
		child.solveButton:SetText(L["Solve"])
		child.solveButton:SetWidth(child.solveButton:GetTextWidth() + 20)
		child.solveButton.tooltip = L["Solve"]

		if child.style ~= db.artifact.style then
			TransformRaceFrame(child)
		end
		
		child:SetID(rid)
		child.crest.texture:SetTexture(race['texture'])
		child.crest.tooltip = race['name'] .. "\n" .. NORMAL_FONT_COLOR_CODE .. L["Key Stones:"] .. "|r " .. race['keystone']['inventory']
		child.crest.text:SetText(race['name'])
		child.icon.texture:SetTexture(artifact['icon'])
		local _, _, completionCount = GetArtifactStats(rid, artifact['name'])
		child.icon.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. artifact['name'] .. "|r\n" .. NORMAL_FONT_COLOR_CODE .. artifact['tooltip'] 
			.. "\n\n" .. HIGHLIGHT_FONT_COLOR_CODE .. string.format(L["Solved Count: %s"], NORMAL_FONT_COLOR_CODE .. (completionCount or "0") .. "|r")
			.. "\n\n" .. GREEN_FONT_COLOR_CODE .. L["Left-Click to open artifact in default Archaeology UI"] .. "|r"
			
		child.fragmentBar.barTexture:SetTexCoord(0, 0.810546875, 0.40625, 0.5625)			-- can solve with keystones if they were attached
		local barColor
		if artifact['rare'] then
			barColor = db.artifact.fragmentBarColors["Rare"]
			child.fragmentBar.barBackground:SetTexCoord(0, 0.72265625, 0.3671875, 0.7890625)		-- rare
		else
			if completionCount == 0 then
				barColor = db.artifact.fragmentBarColors["FirstTime"]
			else
				barColor = db.artifact.fragmentBarColors["Normal"]
			end
			child.fragmentBar.barBackground:SetTexCoord(0, 0.72265625, 0, 0.411875)					-- bg
		end
		child.fragmentBar:SetMinMaxValues(0, artifact['fragTotal'])
		child.fragmentBar:SetValue(min(artifact['fragments'] + artifact['fragAdjust'], artifact['fragTotal']))
		local adjust = (artifact['fragAdjust'] > 0) and string.format(" (|cFF00FF00+%d|r)", artifact['fragAdjust']) or ""
		child.fragmentBar.fragments:SetText(string.format("%d%s / %d", artifact['fragments'], adjust, artifact['fragTotal']))
		child.fragmentBar.artifact:SetText(artifact['name'])
		local endFound = false
		
		if db.artifact.style == "Compact" then
			if artifact['sockets'] > 0 then
				child.fragmentBar.keystones.tooltip = string.format(L["%d Key stone sockets available"], artifact['sockets']) 
				.. "\n" .. string.format(L["%d %ss in your inventory"], (race['keystone']['inventory'] or 0), (race['keystone']['name'] or L["Key stone"]))
				child.fragmentBar.keystones:Show()
				child.fragmentBar.keystones.count:SetText(string.format("%d/%d", artifact['stonesAdded'], artifact['sockets']))
				if artifact['stonesAdded'] > 0 then
					child.fragmentBar.keystones.icon:SetTexture(race['keystone']['texture'])
				else
					child.fragmentBar.keystones.icon:SetTexture(nil)
				end
			else
				child.fragmentBar.keystones:Hide()
			end
		else
			for ki=1, (ARCHAEOLOGY_MAX_STONES or 4) do
				if ki > artifact['sockets'] or not race['keystone']['name'] then
					child.fragmentBar["keystone" .. ki]:Hide()
				else
					child.fragmentBar["keystone" .. ki].icon:SetTexture(race['keystone']['texture'])
					if ki <= artifact['stonesAdded'] then
						child.fragmentBar["keystone" .. ki].icon:Show()
						child.fragmentBar["keystone" .. ki].tooltip = string.format(ARCHAEOLOGY_KEYSTONE_REMOVE_TOOLTIP, race['keystone']['name'])
						child.fragmentBar["keystone" .. ki]:Enable()
					else
						child.fragmentBar["keystone" .. ki].icon:Hide()
						child.fragmentBar["keystone" .. ki].tooltip = string.format(ARCHAEOLOGY_KEYSTONE_ADD_TOOLTIP, race['keystone']['name'])
						child.fragmentBar["keystone" .. ki]:Enable()
						if endFound then
							child.fragmentBar["keystone" .. ki]:Disable()
						end
						endFound = true
					end
					child.fragmentBar["keystone" .. ki]:Show()
				end
			end
		end
		
		if artifact['canSolve'] or (artifact['stonesAdded'] > 0 and artifact['canSolveStone']) then
			child.solveButton:Enable()
			barColor = db.artifact.fragmentBarColors["Solvable"]
		else
			if (artifact['canSolveStone']) then
				barColor = db.artifact.fragmentBarColors["AttachToSolve"]
			end
			child.solveButton:Disable()
		end

		child.fragmentBar.barTexture:SetVertexColor(barColor.r, barColor.g, barColor.b, 1)
		if not db.artifact.blacklist[rid] and artifact['fragTotal'] > 0 and (not db.artifact.filter or tContains(ContinentRaces(playerContinent), rid))then
			child:ClearAllPoints()
			if topFrame == racesFrame.container then
				child:SetPoint("TOP", topFrame, "TOP", 0, 0)
			else
				child:SetPoint("TOP", topFrame, "BOTTOM", 0, -5)
			end
			topFrame = child
			child:Show()
			maxHeight = maxHeight + child:GetHeight() + 5
			maxWidth = (maxWidth > child:GetWidth()) and maxWidth or child:GetWidth()
			count = count + 1
		else
			child:Hide()
		end
	end

	local containerXofs = 0
	if db.artifact.style == "Compact" then
		maxHeight = maxHeight + 10
		containerXofs = -10
	end
	
	
	racesFrame.skillBar:SetWidth(maxWidth)
	racesFrame.skillBar.border:SetWidth(maxWidth+9)
	
	racesFrame.container:SetHeight(maxHeight)
	racesFrame.container:SetWidth(maxWidth)
	
	if db.general.showSkillBar then
		racesFrame.skillBar:Show()
		racesFrame.container:ClearAllPoints()
		racesFrame.container:SetPoint("TOP", racesFrame.skillBar, "BOTTOM", containerXofs, -10)
		maxHeight = maxHeight + 30
	else
		racesFrame.skillBar:Hide()
		racesFrame.container:ClearAllPoints()
		racesFrame.container:SetPoint("TOP", racesFrame, "TOP", containerXofs, -20)
		maxHeight = maxHeight + 10
	end

	if not IsTaintable() then
		if count == 0 then racesFrame:Hide() end
		racesFrame:SetHeight(maxHeight + 15)
		racesFrame:SetWidth(maxWidth + 45)
	end
	
	
end

function Archy:ShowDigSiteTooltip(self)
	local siteId = self:GetParent():GetID()
	self.tooltip = self.name:GetText()
	self.tooltip = self.tooltip .. string.format("\n%s%s%s%s|r", NORMAL_FONT_COLOR_CODE, L["Zone: "], HIGHLIGHT_FONT_COLOR_CODE, self:GetParent().zone.name:GetText())
	self.tooltip = self.tooltip .. string.format("\n\n%s%s %s%s|r", NORMAL_FONT_COLOR_CODE, L["Surveys:"], HIGHLIGHT_FONT_COLOR_CODE, (siteStats[siteId].surveys or 0))
	self.tooltip = self.tooltip .. string.format("\n%s%s %s%s|r", NORMAL_FONT_COLOR_CODE, L["Digs:"], HIGHLIGHT_FONT_COLOR_CODE, (siteStats[siteId].looted or 0))
	self.tooltip = self.tooltip .. string.format("\n%s%s %s%s|r", NORMAL_FONT_COLOR_CODE, L["Fragments:"], HIGHLIGHT_FONT_COLOR_CODE, (siteStats[siteId].fragments or 0))
	self.tooltip = self.tooltip .. string.format("\n%s%s %s%s|r", NORMAL_FONT_COLOR_CODE, L["Key Stones:"], HIGHLIGHT_FONT_COLOR_CODE, (siteStats[siteId].keystones or 0))
	self.tooltip = self.tooltip .. "\n\n" .. GREEN_FONT_COLOR_CODE .. L["Left-Click to view the zone map"]
	if Archy:IsSiteBlacklisted(self.siteName) then
		self.tooltip = self.tooltip .. "\n" .. L["Right-Click to remove from blacklist"]
	else
		self.tooltip = self.tooltip .. "\n" .. L["Right-Click to blacklist"]
	end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(self.tooltip, NORMAL_FONT_COLOR[1], NORMAL_FONT_COLOR[2], NORMAL_FONT_COLOR[3], 1, true);
end

function Archy:ResizeDigSiteDisplay()
	local maxWidth, maxHeight = 0, 0
	local topFrame = digsiteFrame.container
	local siteIndex = 0
	for _, siteFrame in pairs(digsiteFrame.children) do
		siteIndex = siteIndex + 1
		siteFrame.zone:SetWidth(siteFrame.zone.name:GetStringWidth())
		siteFrame.distance:SetWidth(siteFrame.distance.value:GetStringWidth())
		siteFrame.site:SetWidth(siteFrame.site.name:GetStringWidth())
		local width
		local nameWidth = siteFrame.site:GetWidth()
		local zoneWidth = siteFrame.zone:GetWidth()
		if nameWidth > zoneWidth then
			width = siteFrame.crest:GetWidth() + nameWidth + siteFrame.digCounter:GetWidth() + 6
		else
			width = siteFrame.crest:GetWidth() + zoneWidth + siteFrame.distance:GetWidth() + 6
		end
		if width > maxWidth then maxWidth = width end
		maxHeight = maxHeight + siteFrame:GetHeight() + 5

		siteFrame:ClearAllPoints()
		if siteIndex == 1 then siteFrame:SetPoint("TOP", topFrame, "TOP", 0, 0) else siteFrame:SetPoint("TOP", topFrame, "BOTTOM", 0, -5) end
		topFrame = siteFrame
	end
	for _, siteFrame in pairs(digsiteFrame.children) do
		siteFrame:SetWidth(maxWidth)
	end
	local cpoint, crelTo, crelPoint, cxOfs, cyOfs = digsiteFrame.container:GetPoint()

	digsiteFrame.container:SetWidth(maxWidth)
	
	digsiteFrame.container:SetHeight(maxHeight)
	if not IsTaintable() then 
		digsiteFrame:SetHeight(digsiteFrame.container:GetHeight() + cyOfs + 40)
		digsiteFrame:SetWidth(maxWidth + cxOfs + 30)
	end
end

function Archy:RefreshDigSiteDisplay()
	if ShouldBeHidden() then return end

	local cid = continentMapToID[playerContinent]
	if not cid then return end
	if not digsites[cid] or #digsites[cid] == 0 then return end
	for _,siteFrame in pairs(digsiteFrame.children) do siteFrame:Hide() end
	
	local hasNilDistance = false
	for _, site in pairs(digsites[cid]) do
		if site.distance == nil then 
			hasNilDistance = true
			break
		end
	end
	if hasNilDistance then return end
	
	for siteIndex, site in pairs(digsites[cid]) do
		local siteFrame = digsiteFrame.children[siteIndex]
		
		if siteFrame.style ~= db.digsite.style then
			TransformSiteFrame(siteFrame)
		end

		siteFrame.distance.value:SetText(string.format(L["%d yards"], site.distance))
		local count = siteStats[site.id]['counter']
		siteFrame.digCounter.value:SetText((count and count > 0) and "|cFFFFFFFF" .. count .. "|r" or "")
		siteFrame.site.name:SetText((Archy:IsSiteBlacklisted(site.name)) and "|cFFFF0000" .. site.name or "|cFFFFFFFF" .. site.name)
	
		if siteFrame.site.siteName ~= site.name then
			siteFrame.crest.icon:SetTexture(raceData[site.raceId]['texture'])
			siteFrame.zone.name:SetText(site.zoneName)
			siteFrame.site.siteName = site.name
			siteFrame.site.zoneId = site.zoneId
			siteFrame.distance.value:SetText(string.format(L["%d yards"], site.distance))
			
			siteFrame:SetID(site.id)
		end
		
		siteFrame:Show()
	end
	
	self:ResizeDigSiteDisplay()
end

function Archy:SetFramePosition(frame)
	local bPoint, bRelativeTo, bRelativePoint, bXofs, bYofs
	
	if not frame.isMoving then
		bRelativeTo = UIParent
		if frame == digsiteFrame then
			bPoint, bRelativePoint, bXofs, bYofs = unpack(db.digsite.position)
		elseif frame == racesFrame then
			bPoint, bRelativePoint, bXofs, bYofs = unpack(db.artifact.position)
		elseif frame == distanceIndicatorFrame then
			if not db.digsite.distanceIndicator.undocked then 
				bRelativeTo = digsiteFrame
				bPoint, bRelativePoint, bXofs, bYofs = "CENTER", "TOPLEFT", 50, -5
				frame:SetParent(digsiteFrame)
			else
				frame:SetParent(UIParent)
				bPoint, bRelativePoint, bXofs, bYofs = unpack(db.digsite.distanceIndicator.position)
			end
		end
		
		frame:ClearAllPoints()
		frame:SetPoint(bPoint, bRelativeTo, bRelativePoint, bXofs, bYofs)
		frame:SetFrameLevel(2)
		if  frame:GetParent() == UIParent and not IsTaintable() and not db.general.locked then
			frame:SetUserPlaced(false)
		end
	end
end

function Archy:SaveFramePosition(frame)
	local bPoint, bRelativeTo, bRelativePoint, bXofs, bYofs = frame:GetPoint()
	local width, height
	local anchor, position

	if frame == digsiteFrame then
		anchor = Archy.db.profile.digsite.anchor
		position = Archy.db.profile.digsite.position
	elseif frame == racesFrame then
		anchor = Archy.db.profile.artifact.anchor
		position = Archy.db.profile.artifact.position
	elseif frame == distanceIndicatorFrame then
		anchor = Archy.db.profile.digsite.distanceIndicator.anchor
		position = Archy.db.profile.digsite.distanceIndicator.position
	end
	
	if not anchor or not position then return end
	
	if anchor == bPoint then
		position = { bPoint, bRelativePoint, bXofs, bYofs }
	else
		width = frame:GetWidth()
		height = frame:GetHeight()
		
		if bPoint == "TOP" then
			bXofs = bXofs - (width / 2)
		elseif bPoint == "LEFT" then
			bYofs = bYofs + (height / 2)
		elseif bPoint == "BOTTOMLEFT" then
			bYofs = bYofs + height
		elseif bPoint == "TOPRIGHT" then
			bXofs = bXofs - width
		elseif bPoint == "RIGHT" then
			bYofs = bYofs + (height / 2)
			bXofs = bXofs - width
		elseif bPoint == "BOTTOM" then
			bYofs = bYofs + height
			bXofs = bXofs - (width / 2)
		elseif bPoint == "BOTTOMRIGHT" then
			bYofs = bYofs + height
			bXofs = bXofs - width
		elseif bPoint == "CENTER" then
			bYofs = bYofs + (height / 2)
			bXofs = bXofs - (width / 2)
		end

		if anchor == "TOPRIGHT" then
			bXofs = bXofs + width
		elseif anchor == "BOTTOMRIGHT" then
			bYofs = bYofs - height
			bXofs = bXofs + width
		elseif anchor == "BOTTOMLEFT" then
			bYofs = bYofs - height
		end
		
		position = { anchor, bRelativePoint, bXofs, bYofs }
		if frame == digsiteFrame then
			db.digsite.position = position
		elseif frame == racesFrame then
			db.artifact.position = position
		elseif frame == distanceIndicatorFrame then
			db.digsite.distanceIndicator.position = position
		end
	end
	
	self:OnProfileUpdate()
	Archy:SetFramePosition(frame)
end




--[[ 
	Hook World Frame Mouse Interaction - Credit to Sutorix for his implementation of this in Fishing Buddy
	This code is quite raw and does need some cleaning up as it is experimental at best
]]--
-- handle option keys for enabling casting
local function NormalHijackCheck()
   if ( not IsTaintable() and db.general.easyCast and not ShouldBeHidden() ) then
      return true;
   end
end

local HijackCheck = NormalHijackCheck;
local function SetHijackCheck(func)
   if ( not func ) then
      func = NormalHijackCheck;
   end
   HijackCheck = func;
end

local sabutton
local function CreateSAButton(name, postclick)	
	if sabutton then return end
   local btn = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate");
   btn:SetPoint("LEFT", UIParent, "RIGHT", 10000, 0);
   btn:SetFrameStrata("LOW");
   btn:EnableMouse(true);
   btn:RegisterForClicks("RightButtonUp");
   btn:SetScript("PostClick", postclick);
   btn:Hide();
   btn.name = name;

   sabutton = btn;

   return btn;
end

local function GetSurveySkillInfo()
	local _, _, arch = GetProfessions()
	if ( arch ) then
		local name = GetProfessionInfo(arch)
		return true, name
	end
	return false, PROFESSIONS_ARCHAEOLOGY
end

local ActionBarID
local SURVEYTEXTURE = "Interface\\Icons\\INV_Misc_Shovel_01"
local function GetSurveyActionBarID(force)
	if ( force or not ActionBarID ) then
      for slot=1,72 do
         if ( HasAction(slot) and not IsAttackAction(slot) ) then
            local t,_,_ = GetActionInfo(slot);
            if ( t == "spell" ) then
               local tex = GetActionTexture(slot);
               if ( tex and tex == SURVEYTEXTURE ) then
                  ActionBarID = slot;
                  break;
               end
            end
         end
      end
   end
   return ActionBarID;
end

local function InvokeSurvey(useaction, btn)
	btn = btn or sabutton
	if (not btn) then return end
	local _, name = GetSurveySkillInfo()
	local findid = GetSurveyActionBarID()
	if ( not useaction or not findid) then 
		btn:SetAttribute("type", "spell")
		btn:SetAttribute("spell", 80451)
		btn:SetAttribute("action", nil)
	else
		btn:SetAttribute("type", "action")
		btn:SetAttribute("action", findid)
		btn:SetAttribute("spell", nil)
	end
end

local function OverrideClick(btn)
	btn = btn or sabutton
	if (not sabutton) then return end
	SetOverrideBindingClick(btn, true, "BUTTON2", btn.name)
end

local function CentralCasting()
   InvokeSurvey(true)
   OverrideClick();
   OverrideOn = true;
end

local lastClickTime
local ACTIONDOUBLEWAIT = 0.4;
local MINACTIONDOUBLECLICK = 0.05;
local isLooting = false
local function CheckForDoubleClick()
   if ( not isLooting and lastClickTime ) then
      local pressTime = GetTime();
      local doubleTime = pressTime - lastClickTime;
      if ( (doubleTime < ACTIONDOUBLEWAIT) and (doubleTime > MINACTIONDOUBLECLICK) ) then
		lastClickTime = nil
		return true
      end
   end
   lastClickTime = GetTime();
   return false;
end

local function ExtendDoubleClick()
   if ( lastClickTime ) then
      lastClickTime = lastClickTime + ACTIONDOUBLEWAIT/2;
   end
end




local SavedWFOnMouseDown;

-- handle mouse up and mouse down in the WorldFrame so that we can steal
-- the hardware events to implement 'Easy Cast'
-- Thanks to the Cosmos team for figuring this one out -- I didn't realize
-- that the mouse handler in the WorldFrame got everything first!
local function WF_OnMouseDown(...)
   -- Only steal 'right clicks' (self is arg #1!)
   local button = select(2, ...);
   if ( button == "RightButton" and HijackCheck() ) then
      if ( CheckForDoubleClick() ) then
          -- We're stealing the mouse-up event, make sure we exit MouseLook
         if ( IsMouselooking() and not InCombatLockdown()) then
            MouselookStop();
         end
         CentralCasting();
      end
   end
   if ( SavedWFOnMouseDown ) then
      SavedWFOnMouseDown(...);
   end
end

local function SafeHookMethod(object, method, newmethod)
   local oldValue = object[method];
   if ( oldValue ~= getglobal(newmethod) ) then
      object[method] = newmethod;
      return true;
   end
   return false;
end

local function SafeHookScript(frame, handlername, newscript)
   local oldValue = frame:GetScript(handlername);
   frame:SetScript(handlername, newscript);
   return oldValue;
end


function TrapWorldMouse()
   if ( WorldFrame.OnMouseDown ) then
      hooksecurefunc(WorldFrame, "OnMouseDown", WF_OnMouseDown) 
   else
      SavedWFOnMouseDown = SafeHookScript(WorldFrame, "OnMouseDown", WF_OnMouseDown);
   end
end

function Archy:CheckOverride()
	if not IsTaintable() then
		ClearOverrideBindings(Archy_SurveyButton)
	end
	OverrideOn = false
end

function Archy:OnPlayerLogin()
	CreateSAButton("Archy_SurveyButton", Archy.CheckOverride)
end

function Archy:OnPlayerLooting(event, ...)
	isLooting = (event == "LOOT_OPENED")
	local autoLootEnabled = ...
	if autoLootEnabled == 1 then return end
	if isLooting and db.general.autoLoot then
		for slotNum = 1, GetNumLootItems() do
			if LootSlotIsCurrency(slotNum) then
				LootSlot(slotNum)
			elseif LootSlotIsItem(slotNum) then
				local link = GetLootSlotLink(slotNum)
				if link then
					local itemID = GetIDFromLink(link)
					if itemID and keystoneIDToRaceID[itemID] then
						LootSlot(slotNum)
					end
				end
			end
		end
	end
end