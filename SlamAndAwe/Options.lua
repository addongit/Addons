-- @release $Id: Options.lua 15 2011-02-11 21:31:27Z reighnman $

if not SlamAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0");
local _, _, _, clientVersion = GetBuildInfo()

SlamAndAwe.emptyOptions = { "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none" }
SlamAndAwe.singleOptions = { "dw", "cs", "ex", "bt", "rb", "bs", "br", "none", "none", "none", "none", "none", "none", "none", "none", "none" }
SlamAndAwe.aoeOptions = { "dw", "bt", "rb", "bs", "br", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none" }

SlamAndAwe.fonteffects = {
	["none"] = L["None"],
	["OUTLINE"] = L["OUTLINE"],
	["THICKOUTLINE"] = L["THICKOUTLINE"],
	["MONOCHROME"] = L["MONOCHROME"],
}

-------------------
-- Config details
-------------------
function SlamAndAwe:SetDefaultOptions()
	SlamAndAwe.defaults = {
		char = {
			disabled = false,
			specchangewarning = true,
			message = "Welcome Home!",
			movingframes = true,
			showicons = true,
			relativeTo = "UIParent",
			relativePoint = "CENTER",
			point = "CENTER",
			texture = "Blizzard",
			barfont = "Friz Quadrata TT",
			barfontsize = 12,
			barfonteffect = "none",
			msgfont = "Friz Quadrata TT",
			msgfontsize = 24,
			msgfonteffect = "none",
			border = "None",
			barborder = "Blizzard Tooltip",
			mw4sound = "Sound\\Spells\\ShootWandLaunchLightning.wav",
			mw4soundname = "SAA Maelstrom 1",
			mw5sound = "Sound\\Spells\\DynamiteExplode.wav",
			mw5soundname = "SAA Maelstrom 2",
			shieldsound = "Sound\\Doodad\\BellowIn.wav",
			shieldsoundname = "SAA Shield 1",
			weaponsound = "Sound\\Doodad\\BellowIn.wav",
			weaponsoundname = "SAA Shield 1",
			xOffset = 0,
			yOffset = -100,
			fWidth = 300,
			fHeight = 175,
			resetOn = true,
			scale = 1,
			ShockPercent = .6,
			ShearPercent = .6,
			shockshow = true,
			shearshow = false,
			ssshow = true,
			firetotemshow = true,
			wfshow = true,
			fsdotshow = true,
			gcdshow = true,
			gcdfullwidth = false,
			fnshow = true,
			fsshow = true,
			petshow = false,
			disablebars = false,
			maelstromTalents = 0,
			feralSpiritTalented = false,
			mw4soundplay = true,
			mw5soundplay = true,
			mw5repeat = 3,
			mwflash = true,
			shieldshow = true,
			msshow = true,
			msstacks = 0,
			arena = false,
			barstext = true,
			SSlen = 8,

--SlamAndAwe	
			hsshow = true,		
			rageThreshold = 75,
			csshow = true,
			dwshow = true,
			reshow = true,
			CSLen = 6,
			DWLen = 30,
			RELen = 12,
			
--SlamAndAwe CDs
			PummelLen = 10,
			RagingBlowLen = 6,
			BloodthirstLen = 3,
			BattleShoutLen = 30,
			ColossusSmashLen = 20,
			
			ShockLen = 6,
			ShearLen = 6,
			lastshock = "",
			debug = false,
			msg = { r = 1, g = .5, b = 0, },
			msgtime = 2,
			newsitem = 0,
			castweaponrebuff = false,
			MSBToutputarea = "Notification",
			colours = {
				watershield = { r=.6, g=.6,	b=1, a=.3 },
				lightningshield = { r=0, g=0, b=1, a=.5 },
				earthshield = { r=0, g=1, b=0, a=.5 },
				noshield = { r=1, g=0, b=0, a=1 },
				
				flameshock = { r=1, g=.6, b=.2, a=.9 },
				flameshockDot = { r=1, g=.6, b=.2, a=.6 },
				earthshock = { r=0, g=1, b=.3, a=.9 },
				frostshock = { r=.6, g=.6, b=1, a=.9 },
				windshear = { r=.6, g=.6, b=.6, a=.9 },
				
				maelstrom = { r=1, g=.5, b=1, a=.3 },
				msalpha = .3,
				msalphaFull = .9,

				magma = { r=.9, g=.4, b=0, a=.9 },
				feralspiritCD = { r=0, g=.6, b=.95, a=.9 },
				stormstrike = { r=1, g=1, b=.2, a=.9 },
				firenova = { r=1, g=.9, b=.4, a=.9 },
				windfury = { r=1, g=0, b=0, a=.5 },

--SlamAndAwe

        bloodthirst = { r=0, g=1, b=.3, a=.9 },
        ragingblow = { r=0, g=1, b=.3, a=.9 },
        bloodsurge = { r=0, g=1, b=.3, a=.9 },
	      slam = { r=0, g=1, b=.3, a=.9 },
	      heroicstrike = { r=0, g=1, b=.3, a=.9 },
	      pummel = { r=0, g=1, b=.3, a=.9 },		
	      colossussmash = { r=1, g=.8, b=0, a=.9 },	
		    deathwish = { r=1, g=.6, b=0, a=.9 },
		    recklessness = { r=1, g=.13, b=0, a=.9 },		
			},
			uptime = {
				show = true,
				fWidth = 120,
				fHeight = 120,
				barWidth = 100,
				barHeight = 20,
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				point = "CENTER",
				xOffset = -200,
				yOffset = -275,
				alpha = 0.4,
				scale = 1,
				flurry = { r = .2, g = .1, b = 1, a = 0.5, },
				en = { r = 1, g = 1, b = .8, a = 0.5, },
				ur = { r = 1, g = .5, b = 0, a = 0.5, },
			},
			stats = {
				show = true,
				fWidth = 120,
				fHeight = 200,
				barWidth = 100,
				barHeight = 20,
				relativeTo = "SlamAndAwe.UptimeFrame",
				relativePoint = "TOPLEFT",
				point = "TOPLEFT",
				xOffset = 125,
				yOffset = 0,
				alpha = 0.4,
				scale = 1,	
				wfcalc = true,
				wfcol = { r = 1, g = .5, b = 0, a = 0.8, },
				wftime = 2,
				best = {
					ap = 0,
					spellpower = 0,
					meleehit = 0,
					spellhit = 0,
					expertise = 0,
					meleecrit = 0,
					spellcrit = 0,
					wfmh = 0,
					wfoh = 0,
					stormstrike = 0,
				},
			},
			priority = {
				show = true,
				titleshow = false,
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				point = "CENTER",
				fWidth = 50,
				fHeight = 50,
				xOffset = -215,
				yOffset = -60,
				alpha = 0.4,
				scale = 1,	
				next = 1,
				cooldown = 0.5,
				fsticksleft = 2,
				totemtimeleft = 20,
				srmana = 10,
				wsmana = 0,
				shieldorbs = 1,
				magmaticks = 2,
				firetotemtime = 0,
				searingticks = 0,
				worldbossonly = true,
				hideImmune = true,
--				combopoints = true,
				showpurge = false,
				showinterrupt = true,
				showcooldown = true,
				prOption = SlamAndAwe.singleOptions,
				groupnumber = 1, 
				prOptions = { 	
						SlamAndAwe.singleOptions, 
						SlamAndAwe.aoeOptions, 
						SlamAndAwe.emptyOptions, 
						SlamAndAwe.emptyOptions, 
						SlamAndAwe.emptyOptions }
			},
			binding = {
				show = true,
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				point = "CENTER",
				fWidth = 200,
				fHeight = 50,
				xOffset = -200,
				yOffset = -100,
				alpha = 0.4,
				scale = 1,	
				mhspell = SlamAndAwe.constants["Windfury Weapon"],
				ohspell = SlamAndAwe.constants["Flametongue Weapon"],
				macroset = false,
			},
			warning = {
				show = true,
				duration = 3,
				shield = false,
				weapon = true,
				range = false,
				grounding = true,
				interrupt = true,
				purge = true,
				timeleft = 300, 
				colour = { r = 1, g = .5, b = 0, a = 0.5, },
				relativeTo = "UIParent",
				relativePoint = "TOP",
				point = "CENTER",
				fWidth = 400,
				fHeight = 75,
				xOffset = 0,
				yOffset = -250,
			},
		}
	}
end

function SlamAndAwe:VerifyOptions()
	SlamAndAwe.db.char.priority.option =  nil -- remove old format of options
	SlamAndAwe.db.char.priority.options = nil
	if not SlamAndAwe.db.char.priority.prOption then -- fix for corruption in v5.50
		SlamAndAwe.db.char.priority.prOption = SlamAndAwe.emptyOptions
		SlamAndAwe:Print(L["SlamAndAwe Warning : No options set"])
	end
	for index = 1, 16 do
		if not SlamAndAwe.db.char.priority.prOption[index] then
			SlamAndAwe.db.char.priority.prOption[index] = "none"
		end
	end
	for group = 1, 5 do
		for index = 1, 16 do
			if not SlamAndAwe.db.char.priority.prOptions[group][index] then
				SlamAndAwe.db.char.priority.prOptions[group][index] = "none"
			end
		end
	end
end

function SlamAndAwe:GetOptions()
	local options = { 
		name = "SlamAndAwe",
		handler = SlamAndAwe,
		type='group',
		childGroups ='tree',
		args = {
			frames = {
				name = L["Frame Options"],
				type = 'group',
				order = 1,
				args = {
					width = {
						type = 'range',
						name = L["Bar Width"],
						desc = L["help_width"],
						min = 100,
						max = 500,
						step = 10,
						get = "GetWidth",
						set = "SetWidth",
						order = 32,
					},
					scale = {
						type = 'range',
						name = L["Bar Scale"],
						desc = L["help_scale"],
						min = 0.10,
						max = 2.00,
						step = 0.05,
						get = "GetScale",
						set = "SetScale",
						order = 33,
					},
					resetbars = {
						type = 'execute',
						name = L["Reset Bars"],
						desc = L["help_reset"],
						func = "ResetBars",
						order = 34,
					},
					resetuptime = {
						type = 'execute',
						name = L["Reset Uptime"],
						desc = L["help_reset_uptime"],
						func = "ResetUptime",
						order = 35,
					},
					resetpriority = {
						type = 'execute',
						name = L["Reset Priority"],
						desc = L["help_reset_priority"],
						func = "ResetPriority",
						order = 36,
					},
				},
			},
			bars = {
				name = L["Timer Bars"],
				type = 'group',
				order = 2,
				args = {
					CSbar = {
						type = 'toggle',
						name = L["Colossus Smash Bar"],
						desc = L["help_CS"],
						get = "colossussmashQuery",
						set = "ActivateColossusSmash",
						order = 11,
						},
					DWbar = {
						type = 'toggle',
						name = L["Death Wish Bar"],
						desc = L["help_DW"],
						get = "deathwishQuery",
						set = "ActivateDeathWish",
						order = 12,
						},
					REbar = {
						type = 'toggle',
						name = L["Recklessness Bar"],
						desc = L["help_RE"],
						get = "recklessnessQuery",
						set = "ActivateRecklessness",
						order = 13,
					},
					gcd = {
						type = 'toggle',
						name = L["GCD"],
						desc = L["help_gcd"],
						get = "gcdQuery",
						set = "ActivateGCD",
						order = 18,
					},
					gcdfullwidth = {
						type = 'toggle',
						name = L["GCD full width"],
						desc = L["help_gcd_fullwidth"],
						get = "gcdFullwidthQuery",
						set = "ActivateGCDfullwidth",
						order = 19,
					},
				},
			},
			barcolours = {
				name = L["Bar Colours"],
				type = 'group',
				order = 3, 
				args = {
					ColossusSmash = {
						type = 'color',
						name = L["Colossus Smash Bar Colour"],
						desc = L["colColossusSmash"],
						get = "getColossusSmashColour",
						set = "setColossusSmashColour",
						hasAlpha = true,
						order = 23,
					},
					DeathWish = {
						type = 'color',
						name = L["Death Wish Bar Colour"],
						desc = L["colDeathWish"],
						get = "getDeathWishColour",
						set = "setDeathWishColour",
						hasAlpha = true,
						order = 25,
					},
					Recklessness = {
						type = 'color',
						name = L["Recklessness Bar Colour"],
						desc = L["colRecklessness"],
						get = "getRecklessnessColour",
						set = "setRecklessnessColour",
						hasAlpha = true,
						order = 26,
					},
				},
			},
			priority = {
				name = L["Priority Frame"],
				type = 'group',
				order = 4, 
				args = {
					priority = {
						type = 'toggle',
						name = L["Priority Frame"],
						desc = L["help_priority"],
						get = "priorityQuery",
						set = "ActivatePriority",
						order = 21,
					},
					title = {
						type = 'toggle',
						name = L["Display frame title"],
						get = "priorityTitleQuery",
						set = "ActivatePriorityTitle",
						order = 22,
					},
--					combopoints = {
--						type = 'toggle',
--						name = L["Combo Points"],
--						desc = L["help_combopoints"],
--						get = "combopointsQuery",
--						set = "ActivateComboPoints",
--						order = 23,
--					},
					priorityscale = {
						type = 'range',
						name = L["Priority Bar Scale"],
						desc = L["help_priority_scale"],
						min = 0.50,
						max = 2.00,
						step = 0.01,
						get = "GetPriorityScale",
						set = "SetPriorityScale",
						order = 24,
					},
					heroicstrike = {
						type = 'toggle',
						name = SlamAndAwe.constants["Heroic Strike"],
						desc = L["help_heroicstrike"],
						get = "heroicstrikeQuery",
						set = "ActivateHeroicStrike",
						order = 25,
					},
					rage = {
						type = 'range',
						name = L["HS Rage Threshold"],
						desc = L["help_hsrage"],
						min = 1,
						max = 100,
						step = 1,
						get = "GetRageThreshold",
						set = "SetRageThreshold",
						order = 26,
					},
					showinterrupt = {
						type = 'toggle',
						name = L["Show Interrupt"],
						desc = L["help_showinterrupt"],
						get = "showinterruptQuery",
						set = "ActivateShowInterrupt",
						order = 27,
					},
				},
			},
			warning = {
				name = L["Warning Options"],
				type = 'group',
				order = 6, 
				args = {
					show = {
						type = 'toggle',
						name = L["Use Warning Frame"],
						desc = L["help_warningframe"],
						get = "WarningFrameQuery",
						set = "ActivateWarningFrame",
						order = 1,
					},

					range = {
						type = 'toggle',
						name = L["Out of range"],
						desc = L["help_outofrange"],
						get = "rangeWarnQuery",
						set = "ActivateRangeWarn",
						order = 4,
					},
					interrupt = {
						type = 'toggle',
						name = L["Interrupt Warning"],
						desc = L["help_interruptwarning"],
						get = "interruptWarnQuery",
						set = "ActivateInterruptWarn",
						order = 6,
					},
					colour = {
						type = 'color',
						name = L["Warning Msg Colour"],
						desc = L["colWarningMessage"],
						get = "getWarningColour",
						set = "setWarningColour",
						hasAlpha = true,
						order = 10,
					},
					duration = {
						type = 'range',
						name = L["Warning Message Duration"],
						min = 1,
						max = 10,
						step = .2,
						get = "GetWarningDuration",
						set = "SetWarningDuration",
						order = 11,
					},
--~					msbt = {
--~						type = 'select',
--~						name = L["MSBT output area"],
--~						get = "GetMSBTareas",
--~						set = "SetMSBTareas",
--~						values = SlamAndAwe.MSBT.areas,
--~						order = 12,
--~					},
--~ 					rebuff = {
--~ 						type = 'range',
--~ 						name = L["Weapon Rebuff time"],
--~ 						desc = L["help_weaponrebuff"],
--~ 						min = 0,
--~ 						max = 900,
--~ 						step = 10,
--~ 						get = "GetRebuffTime",
--~ 						set = "SetRebuffTime",
--~ 						order = 6,
--~ 					},
				},
			},
			media = {
				name = L["Media Options"],
				type = 'group',
				order = 7, 
				args = {
					msgfont = {
						type = 'select',
						name = L["Message Font"],
						get = "GetMsgFont",
						set = "SetMsgFont",
						values = SlamAndAwe.fonts,
						order = 7,
					},
					msgfonteffect = {
						name = L["Message Font Effect"],
						type = "select",
						get = "GetMsgFontEffect",
						set = "SetMsgFontEffect",
						values = SlamAndAwe.fonteffects,
						order = 8,
					},
					msgfontsize = {
						type = 'range',
						name = L["Message Font Size"],
						min = 6,
						max = 32,
						step = 1,
						get = "GetMsgFontSize",
						set = "SetMsgFontSize",
						order = 9,
					},

				},
			},
			uptime = {
				name = L["Uptime Frame"],
				type = 'group',
				order = 8,
				args = {
					break1 = {
						type = 'header',
						name = L["Bar Colours"],
						dialogHidden = true,
						order = 1,
					},
					flurry = {
						type = 'color',
						name = L["Flurry Colour"],
						desc = L["colFlurry"],
						get = "getFlurryColour",
						set = "setFlurryColour",
						hasAlpha = true,
						order = 2,
					},					
					en = {
						type = 'color',
						name = L["Enrage Colour"],
						desc = L["colEN"],
						get = "getENColour",
						set = "setENColour",
						hasAlpha = true,
						order = 3,
					},					
					break2 = {
						type = 'header',
						name = L["Misc Options"],
						dialogHidden = true,
						order = 10,
					},
					show = {
						type = 'toggle',
						name = L["Show Frame"],
						desc = L["help_showuptime"],
						get = "showUptimeQuery",
						set = "ActivateShowUptime",
						order = 11,
					},
					resetsession = {
						type = 'execute',
						name = L["Reset Session info"],
						desc = L["help_reset"],
						func = "InitialiseUptime",
						order = 13,
					},			
				},			
			},
			debug = {
				type = 'toggle',
				name = L["Debug mode"],
				desc = L["help_debug"],
				get = "debugQuery",
				set = "ActivateDebug",
				order = 20,
			},
			moveframes = {
				type = 'toggle',
				name = L["Move Frames"],
				desc = L["help_display"],
				get = "MovingFramesQuery",
				set = "ShowHideBars",
				order = 21,
			},
			config = {
				type = 'execute',
				name = L["Configure Options"],
				desc = L["help_config"],
				func = "OpenConfig",
				order = 24,
			},
			enable = {
				type = 'execute',
				name = L["Enable/Disable"],
				desc = L["help_disable"],
				func = "EnableDisable",
				order = 26,
			},
			disable = {
				type = 'execute',
				name = L["Enable/Disable"],
				desc = L["help_disable"],
				func = "EnableDisable",
				guiHidden = true,
				order = 27,
			},
			version = {
				type = 'execute',
				name = L["Version"],
				desc = L["help_version"],
				func = "DisplayVersion",
				order = 29,
			},
			help = {
				type = 'description',
				name = L["help"],
				guiHidden = true,
				order = 30,
			},
			priorities = { 
				name = L["Set Priorities"],
				type='group',
				childGroups ='tree',
				order = 5,
				args = {			
					prioritygroup = {
						type = 'select',
						name = L["Priority Group"],
						get = "GetPriorityGroup",
						set = "SetPriorityGroup",
						values = { L["Priority Group One"],  L["Priority Group Two"], L["Priority Group Three"], L["Priority Group Four"], L["Priority Group Five"] },
						order = 1,
					},
					priority1 = {
						type = 'select',
						name = L["First Priority"],
						get = SlamAndAwe:GetPriority(1),
						set = SlamAndAwe:SetPriority(1),
						values = SlamAndAwe.priorityTable.name,
						order = 31,
					},
					priority2 = {
						type = 'select',
						name = L["Second Priority"],
						get = SlamAndAwe:GetPriority(2),
						set = SlamAndAwe:SetPriority(2),
						values = SlamAndAwe.priorityTable.name,
						order = 32,
					},
					priority3 = {
						type = 'select',
						name = L["Third Priority"],
						get = SlamAndAwe:GetPriority(3),
						set = SlamAndAwe:SetPriority(3),
						values = SlamAndAwe.priorityTable.name,
						order = 33,
					},
					priority4 = {
						type = 'select',
						name = L["Fourth Priority"],
						get = SlamAndAwe:GetPriority(4),
						set = SlamAndAwe:SetPriority(4),
						values = SlamAndAwe.priorityTable.name,
						order = 34,
					},
					priority5 = {
						type = 'select',
						name = L["Fifth Priority"],
						get = SlamAndAwe:GetPriority(5),
						set = SlamAndAwe:SetPriority(5),
						values = SlamAndAwe.priorityTable.name,
						order = 35,
					},
					priority6 = {
						type = 'select',
						name = L["Sixth Priority"],
						get = SlamAndAwe:GetPriority(6),
						set = SlamAndAwe:SetPriority(6),
						values = SlamAndAwe.priorityTable.name,
						order = 36,
					},
					priority7 = {
						type = 'select',
						name = L["Seventh Priority"],
						get = SlamAndAwe:GetPriority(7),
						set = SlamAndAwe:SetPriority(7),
						values = SlamAndAwe.priorityTable.name,
						order = 37,
					},
					priority8 = {
						type = 'select',
						name = L["Eighth Priority"],
						get = SlamAndAwe:GetPriority(8),
						set = SlamAndAwe:SetPriority(8),
						values = SlamAndAwe.priorityTable.name,
						order = 38,
					},
					priority9 = {
						type = 'select',
						name = L["Ninth Priority"],
						get = SlamAndAwe:GetPriority(9),
						set = SlamAndAwe:SetPriority(9),
						values = SlamAndAwe.priorityTable.name,
						order = 39,
					},
					priority10 = {
						type = 'select',
						name = L["Tenth Priority"],
						get = SlamAndAwe:GetPriority(10),
						set = SlamAndAwe:SetPriority(10),
						values = SlamAndAwe.priorityTable.name,
						order = 40,
					},
					priority11 = {
						type = 'select',
						name = L["Eleventh Priority"],
						get = SlamAndAwe:GetPriority(11),
						set = SlamAndAwe:SetPriority(11),
						values = SlamAndAwe.priorityTable.name,
						order = 41,
					},
					priority12 = {
						type = 'select',
						name = L["Twelfth Priority"],
						get = SlamAndAwe:GetPriority(12),
						set = SlamAndAwe:SetPriority(12),
						values = SlamAndAwe.priorityTable.name,
						order = 42,
					},
					priority13 = {
						type = 'select',
						name = L["Thirteenth Priority"],
						get = SlamAndAwe:GetPriority(13),
						set = SlamAndAwe:SetPriority(13),
						values = SlamAndAwe.priorityTable.name,
						order = 43,
					},
					priority14 = {
						type = 'select',
						name = L["Fourteenth Priority"],
						get = SlamAndAwe:GetPriority(14),
						set = SlamAndAwe:SetPriority(14),
						values = SlamAndAwe.priorityTable.name,
						order = 44,
					},
					priority15 = {
						type = 'select',
						name = L["Fifteenth Priority"],
						get = SlamAndAwe:GetPriority(15),
						set = SlamAndAwe:SetPriority(15),
						values = SlamAndAwe.priorityTable.name,
						order = 45,
					},
					priority16 = {
						type = 'select',
						name = L["Sixteenth Priority"],
						get = SlamAndAwe:GetPriority(16),
						set = SlamAndAwe:SetPriority(16),
						values = SlamAndAwe.priorityTable.name,
						order = 46,
					},
				}
			}
		}
	}
	return options
end

function SlamAndAwe:ActivateSS()
	SlamAndAwe.db.char.ssshow = not SlamAndAwe.db.char.ssshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.ssshow) then
		SlamAndAwe:Print(L["config_SS_on"])
	else
		SlamAndAwe:Print(L["config_SS_off"])
	end
end

function SlamAndAwe:ActivateFireTotem()
	SlamAndAwe.db.char.firetotemshow = not SlamAndAwe.db.char.firetotemshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.firetotemshow) then
		SlamAndAwe:Print(L["config_magma_on"])
	else
		SlamAndAwe:Print(L["config_magma_off"])
	end
end

function SlamAndAwe:ActivateWF()
	SlamAndAwe.db.char.wfshow = not SlamAndAwe.db.char.wfshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.wfshow) then
		SlamAndAwe:Print(L["config_WF_on"])
	else
		SlamAndAwe:Print(L["config_WF_off"])
	end
end

function SlamAndAwe:ActivateShock()
	SlamAndAwe.db.char.shockshow = not SlamAndAwe.db.char.shockshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.shockshow) then
		SlamAndAwe:Print(L["config_Shock_on"])
	else
		SlamAndAwe:Print(L["config_Shock_off"])
	end
end

function SlamAndAwe:ActivateFSDotBar()
	SlamAndAwe.db.char.fsdotshow = not SlamAndAwe.db.char.fsdotshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.fsdotshow) then
		SlamAndAwe:Print(L["config_FSDotShow_on"])
	else
		SlamAndAwe:Print(L["config_FSDotShow_off"])
	end
end

function SlamAndAwe:ActivateShear()
	SlamAndAwe.db.char.shearshow = not SlamAndAwe.db.char.shearshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.shearshow) then
		SlamAndAwe:Print(L["config_Shear_on"])
	else
		SlamAndAwe:Print(L["config_Shear_off"])
	end
end

function SlamAndAwe:ActivateArena()
	SlamAndAwe.db.char.arena = not SlamAndAwe.db.char.arena
	SlamAndAwe:SetTalentEffects()
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.arena) then
		SlamAndAwe:Print(L["config_Arena_on"])
	else
		SlamAndAwe:Print(L["config_Arena_off"])
	end
end

function SlamAndAwe:ActivateShowUptime()
	SlamAndAwe.db.char.uptime.show = not SlamAndAwe.db.char.uptime.show
	if (SlamAndAwe.db.char.uptime.show) then
		SlamAndAwe.UptimeFrame:Show()
		SlamAndAwe:Print(L["config_Uptime_on"])
	else
		SlamAndAwe.UptimeFrame:Hide()
		SlamAndAwe:Print(L["config_Uptime_off"])
	end
end

function SlamAndAwe:ActivateMaelstrom()
	SlamAndAwe.db.char.msshow = not SlamAndAwe.db.char.msshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.msshow) then
		SlamAndAwe:MaelstromBar()
		SlamAndAwe.db.char.msstacks = SlamAndAwe:GetMaelstromInfo()
		SlamAndAwe:Print(L["config_MW_on"])
	else
		SlamAndAwe.frames["Maelstrom"]:Hide()
		SlamAndAwe:Print(L["config_MW_off"])
	end
end

--SlamAndAwe
function SlamAndAwe:ActivateColossusSmash()
	SlamAndAwe.db.char.csshow = not SlamAndAwe.db.char.csshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.csshow) then
		SlamAndAwe:Print(L["config_CS_on"])
	else
		SlamAndAwe.frames["ColossusSmash"]:Hide()
		SlamAndAwe:Print(L["config_CS_off"])
	end
end

function SlamAndAwe:ActivateDeathWish()
	SlamAndAwe.db.char.dwshow = not SlamAndAwe.db.char.dwshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.dwshow) then
		SlamAndAwe:Print(L["config_DW_on"])
	else
		SlamAndAwe.frames["DeathWish"]:Hide()
		SlamAndAwe:Print(L["config_DW_off"])
	end
end

function SlamAndAwe:ActivateRecklessness()
	SlamAndAwe.db.char.reshow = not SlamAndAwe.db.char.reshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.reshow) then
		SlamAndAwe:Print(L["config_RE_on"])
	else
		SlamAndAwe.frames["Recklessness"]:Hide()
		SlamAndAwe:Print(L["config_RE_off"])
	end
end

function SlamAndAwe:ActivateFireNova()
	SlamAndAwe.db.char.fnshow = not SlamAndAwe.db.char.fnshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.fnshow) then
		SlamAndAwe:Print(L["config_FN_on"])
	else
		SlamAndAwe.frames["FireNova"]:Hide()
		SlamAndAwe:Print(L["config_FN_off"])
	end
end

function SlamAndAwe:ActivateGCD()
	SlamAndAwe.db.char.gcdshow = not SlamAndAwe.db.char.gcdshow
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.gcdshow) then
		SlamAndAwe.frames["GCD"]:Show()
		SlamAndAwe:Print(L["config_GCD_on"])
	else
		SlamAndAwe.frames["GCD"]:Hide()
		SlamAndAwe:Print(L["config_GCD_off"])
	end
end

function SlamAndAwe:ActivateGCDfullwidth()
	SlamAndAwe.db.char.gcdfullwidth = not SlamAndAwe.db.char.gcdfullwidth
	SlamAndAwe:SetTalentEffects()
	SlamAndAwe:CreateBaseFrame()
	if (SlamAndAwe.db.char.gcdfullwidth) then
		SlamAndAwe:Print(L["config_GCD_fullwidth_on"])
	else
		SlamAndAwe:Print(L["config_GCD_fullwidth_off"])
	end
end

function SlamAndAwe:Activatedisablebars()
	SlamAndAwe.db.char.disablebars = not SlamAndAwe.db.char.disablebars
	if (SlamAndAwe.db.char.disablebars) then
		if not InCombatLockdown() then
			SlamAndAwe.BaseFrame:Hide()
		end
		SlamAndAwe:Print(L["config_disable_on"])
	else
		SlamAndAwe.BaseFrame:Show()
		SlamAndAwe:Print(L["config_disable_off"])
	end
end

function SlamAndAwe:ActivateBarIcons()
	SlamAndAwe.db.char.showicons = not SlamAndAwe.db.char.showicons
	if (SlamAndAwe.db.char.showicons) then
		SlamAndAwe:Print(L["config_baricons_on"])
	else
		SlamAndAwe:Print(L["config_baricons_off"])
	end
end

function SlamAndAwe:ActivateDebug()
	SlamAndAwe.db.char.debug = not SlamAndAwe.db.char.debug
	if (SlamAndAwe.db.char.debug) then
		SlamAndAwe:Print(L["config_debug_on"])
	else
		SlamAndAwe:Print(L["config_debug_off"])
	end
end

function SlamAndAwe:Activatespecchangewarning()
	SlamAndAwe.db.char.specchangewarning = not SlamAndAwe.db.char.specchangewarning
	if (SlamAndAwe.db.char.specchangewarning) then
		SlamAndAwe:Print(L["config_specchangewarning_on"])
	else
		SlamAndAwe:Print(L["config_specchangewarning_off"])
	end
end

function SlamAndAwe:ActivateHeroicStrike()
	SlamAndAwe.db.char.hsshow = not SlamAndAwe.db.char.hsshow
	if (SlamAndAwe.db.char.hsshow) then
		SlamAndAwe:Print(L["config_HS_on"])
	else
		SlamAndAwe:Print(L["config_HS_off"])
	end
end

--function SlamAndAwe:ActivateComboPoints()
--	SlamAndAwe.db.char.priority.combopoints = not SlamAndAwe.db.char.priority.combopoints
--	if (SlamAndAwe.db.char.priority.combopoints) then
--		for index = 1, 5 do
--			SlamAndAwe.PriorityFrame.combo[index].frame:Show()
--		end
--		SlamAndAwe:Print(L["config_combopoints_on"])
--	else
--		for index = 1, 5 do
--			SlamAndAwe.PriorityFrame.combo[index].frame:Hide()
--		end
--		SlamAndAwe:Print(L["config_combopoints_off"])
--	end
--end

function SlamAndAwe:ActivateWorldBoss()
	SlamAndAwe.db.char.priority.worldbossonly = not SlamAndAwe.db.char.priority.worldbossonly
	if (SlamAndAwe.db.char.priority.worldbossonly) then
		SlamAndAwe:Print(L["config_worldboss_on"])
	else
		SlamAndAwe:Print(L["config_worldboss_off"])
	end
end

function SlamAndAwe:ActivateHideImmune()
	SlamAndAwe.db.char.priority.hideImmune = not SlamAndAwe.db.char.priority.hideImmune
	if (SlamAndAwe.db.char.priority.hideImmune) then
		SlamAndAwe:Print(L["config_hideimmune_on"])
	else
		SlamAndAwe:Print(L["config_hideimmune_off"])
	end
end

function SlamAndAwe:ActivateShowInterrupt()
	SlamAndAwe.db.char.priority.showinterrupt = not SlamAndAwe.db.char.priority.showinterrupt
	if (SlamAndAwe.db.char.priority.showinterrupt) then
		SlamAndAwe.PriorityFrame.interrupt.frame:Show()
		SlamAndAwe:Print(L["config_showinterrupt_on"])
	else
		SlamAndAwe.PriorityFrame.interrupt.frame:Hide()
		SlamAndAwe:Print(L["config_showinterrupt_off"])
	end
end

function SlamAndAwe:ActivateShowPurge()
	SlamAndAwe.db.char.priority.showpurge = not SlamAndAwe.db.char.priority.showpurge
	if (SlamAndAwe.db.char.priority.showpurge) then
		SlamAndAwe.PriorityFrame.purge.frame:Show()
		SlamAndAwe:Print(L["config_showpurge_on"])
	else
		SlamAndAwe.PriorityFrame.purge.frame:Hide()
		SlamAndAwe:Print(L["config_showpurge_off"])
	end
end

function SlamAndAwe:ActivateShowCooldown()
	SlamAndAwe.db.char.priority.showcooldown = not SlamAndAwe.db.char.priority.showcooldown
	if (SlamAndAwe.db.char.priority.showcooldown) then
		SlamAndAwe:Print(L["config_showcooldown_on"])
	else
		SlamAndAwe:Print(L["config_showcooldown_off"])
	end
end

function SlamAndAwe:ActivateTextOnBars()
	SlamAndAwe.db.char.barstext = not SlamAndAwe.db.char.barstext
	if (SlamAndAwe.db.char.barstext) then
		SlamAndAwe:Print(L["config_Barstext_on"])
	else
		SlamAndAwe:Print(L["config_Barstext_off"])
	end
end

function SlamAndAwe:ActivateMW5flash()
	SlamAndAwe.db.char.mw5flash = not SlamAndAwe.db.char.mw5flash
	if (SlamAndAwe.db.char.mw5flash) then
		SlamAndAwe:Print(L["config_mw5flash_on"])
	else
		UIFrameFlashStop(SlamAndAwe.frames["Maelstrom"])
		SlamAndAwe:SetMaelstromAlpha(SlamAndAwe.db.char.colours.msalpha)
		SlamAndAwe:Print(L["config_mw5flash_off"])
	end
end

function SlamAndAwe:ShowPetFrame()
	SlamAndAwe.db.char.petframeshow = not SlamAndAwe.db.char.petframeshow
	if SlamAndAwe.db.char.petframeshow then
		SlamAndAwe:EnablePetFrame()
		SlamAndAwe:Print(L["Enabled display of Feral Spirit Pet frame"])
	else
		SlamAndAwe:Print(L["Disabled display of Feral Spirit Pet frame"])
	end
end

function SlamAndAwe:ShowHideBars()
	SlamAndAwe.db.char.movingframes = not SlamAndAwe.db.char.movingframes
	if SlamAndAwe.db.char.movingframes then
		SlamAndAwe.PriorityFrame:EnableMouse(1)
		SlamAndAwe.PriorityFrame:SetBackdropColor(0, 0, 0, 1)
		SlamAndAwe.PriorityFrame:Show()
		SlamAndAwe.UptimeFrame:EnableMouse(1)
		SlamAndAwe.UptimeFrame:SetBackdropColor(0, 0, 0, 1)
		SlamAndAwe.UptimeFrame:Show()
		SlamAndAwe.msgFrame:EnableMouse(1)
		SlamAndAwe.msgFrame:SetBackdropColor(0, 0, 0, 1)
		SlamAndAwe.msgFrame:Show()
		SlamAndAwe.BaseFrame:EnableMouse(1)
		SlamAndAwe.BaseFrame:SetBackdropColor(0, 0, 0, 1);
		SlamAndAwe.frames["GCD"]:Show()
	else
		SlamAndAwe.PriorityFrame:EnableMouse(0);
		SlamAndAwe.PriorityFrame:SetBackdropColor(1, 1, 1, 0);
		SlamAndAwe.BaseFrame:EnableMouse(0);
		SlamAndAwe.BaseFrame:SetBackdropColor(1, 1, 1, 0);
		SlamAndAwe.UptimeFrame:EnableMouse(0)
		SlamAndAwe.UptimeFrame:SetBackdropColor(0, 0, 0, 0.3);
		SlamAndAwe.msgFrame:EnableMouse(0)
		SlamAndAwe.msgFrame:SetBackdropColor(1, 1, 1, 0);
		-- SlamAndAwe.BaseFrame:Hide()
		SlamAndAwe.frames["GCD"]:Hide()
		if SlamAndAwe.db.char.priority.show and InCombatLockdown() then
			SlamAndAwe.PriorityFrame:Show()
		else
			SlamAndAwe.PriorityFrame:Hide()
		end
		if SlamAndAwe.db.char.uptime.show then
			SlamAndAwe.UptimeFrame:Show()
		else
			SlamAndAwe.UptimeFrame:Hide()
		end
	end
	SlamAndAwe:SetPriorityUpdateScript()
end

function SlamAndAwe:FinishedMoving(var, frame)
	local point, relativeTo, relativePoint, xOffset, yOffset = frame:GetPoint();
	var.point = point
	var.relativeTo = relativeTo
	var.relativePoint = relativePoint
	var.xOffset = xOffset
	var.yOffset = yOffset
end

function SlamAndAwe:SetShowWFTotals(info, newValue)
	SlamAndAwe.db.char.stats.wfcalc = newValue
	if (SlamAndAwe.db.char.stats.wfcalc) then
		SlamAndAwe:Print(L["config_wfcalc_on"])
	else
		SlamAndAwe:Print(L["config_wfcalc_off"])
	end
end

function SlamAndAwe:MovingFramesQuery()
	return SlamAndAwe.db.char.movingframes
end

function SlamAndAwe:PetFrameQuery()
	return SlamAndAwe.db.char.petframeshow
end

function SlamAndAwe:SSQuery()
	return SlamAndAwe.db.char.ssshow
end

function SlamAndAwe:FireTotemQuery()
	return SlamAndAwe.db.char.firetotemshow
end

function SlamAndAwe:WFQuery()
	return SlamAndAwe.db.char.wfshow
end

function SlamAndAwe:shockQuery()
	return SlamAndAwe.db.char.shockshow
end

function SlamAndAwe:fsdotbarQuery()
	return SlamAndAwe.db.char.fsdotshow
end

function SlamAndAwe:shearQuery()
	return SlamAndAwe.db.char.shearshow
end

function SlamAndAwe:gcdQuery()
	return SlamAndAwe.db.char.gcdshow
end

function SlamAndAwe:gcdFullwidthQuery()
	return SlamAndAwe.db.char.gcdfullwidth
end

function SlamAndAwe:heroicstrikeQuery()
	return SlamAndAwe.db.char.hsshow
end

--function SlamAndAwe:combopointsQuery()
--	return SlamAndAwe.db.char.priority.combopoints
--end

function SlamAndAwe:worldbossQuery()
	return SlamAndAwe.db.char.priority.worldbossonly
end

function SlamAndAwe:hideImmuneQuery()
	return SlamAndAwe.db.char.priority.hideImmune
end

function SlamAndAwe:showinterruptQuery()
	return SlamAndAwe.db.char.priority.showinterrupt
end

function SlamAndAwe:showpurgeQuery()
	return SlamAndAwe.db.char.priority.showpurge
end

function SlamAndAwe:showcooldownQuery()
	return SlamAndAwe.db.char.priority.showcooldown
end

function SlamAndAwe:disablebarsQuery()
	return SlamAndAwe.db.char.disablebars
end

function SlamAndAwe:bariconsQuery()
	return SlamAndAwe.db.char.showicons
end

function SlamAndAwe:arenaQuery()
	return SlamAndAwe.db.char.arena
end

function SlamAndAwe:showUptimeQuery()
	return SlamAndAwe.db.char.uptime.show
end

function SlamAndAwe:maelstromQuery()
	return SlamAndAwe.db.char.msshow
end

--SlamAndAwe
function SlamAndAwe:colossussmashQuery()
	return SlamAndAwe.db.char.csshow
end

function SlamAndAwe:deathwishQuery()
	return SlamAndAwe.db.char.dwshow
end

function SlamAndAwe:recklessnessQuery()
	return SlamAndAwe.db.char.reshow
end

function SlamAndAwe:firenovaQuery()
	return SlamAndAwe.db.char.fnshow
end

function SlamAndAwe:textOnBarsQuery()
    return SlamAndAwe.db.char.barstext
end

function SlamAndAwe:mw5soundplayQuery()
    return SlamAndAwe.db.char.mw5soundplay
end

function SlamAndAwe:mw4soundplayQuery()
    return SlamAndAwe.db.char.mw4soundplay
end

function SlamAndAwe:mw5flashQuery()
    return SlamAndAwe.db.char.mw5flash
end

function SlamAndAwe:debugQuery()
	return SlamAndAwe.db.char.debug
end

function SlamAndAwe:specchangewarningQuery()
	return SlamAndAwe.db.char.specchangewarning
end

function SlamAndAwe:GetBarTexture()
    return SlamAndAwe.db.char.texture
end

function SlamAndAwe:GetBorderTexture()
    return SlamAndAwe.db.char.border
end

function SlamAndAwe:GetBarBorderTexture()
    return SlamAndAwe.db.char.barborder
end

function SlamAndAwe:GetBarFont()
    return SlamAndAwe.db.char.barfont
end

function SlamAndAwe:GetBarFontSize()
    return SlamAndAwe.db.char.barfontsize
end

function SlamAndAwe:GetBarFontEffect()
    return SlamAndAwe.db.char.barfonteffect
end

function SlamAndAwe:GetMsgFont()
    return SlamAndAwe.db.char.msgfont
end

function SlamAndAwe:GetMsgFontSize()
    return SlamAndAwe.db.char.msgfontsize
end

function SlamAndAwe:GetMsgFontEffect()
    return SlamAndAwe.db.char.msgfonteffect
end

function SlamAndAwe:GetWidth()
    return SlamAndAwe.db.char.fWidth
end

function SlamAndAwe:GetScale()
    return SlamAndAwe.db.char.scale
end

function SlamAndAwe:GetPriorityScale()
    return SlamAndAwe.db.char.priority.scale
end

function SlamAndAwe:GetMSalpha()
    return SlamAndAwe.db.char.colours.msalpha
end

function SlamAndAwe:GetMSalphaFull()
    return SlamAndAwe.db.char.colours.msalphaFull
end

function SlamAndAwe:GetWeaponSound()
    return SlamAndAwe.db.char.weaponsoundname
end

function SlamAndAwe:GetMW5sound()
    return SlamAndAwe.db.char.mw5soundname
end

function SlamAndAwe:GetMW5repeat()
    return SlamAndAwe.db.char.mw5repeat
end

function SlamAndAwe:GetMW4sound()
    return SlamAndAwe.db.char.mw4soundname
end

function SlamAndAwe:GetRageThreshold()
   return SlamAndAwe.db.char.rageThreshold
end

function SlamAndAwe:GetCooldownThreshold()
    return SlamAndAwe.db.char.priority.cooldown
end

function SlamAndAwe:GetTotemTimeLeft()
    return SlamAndAwe.db.char.priority.totemtimeleft
end

function SlamAndAwe:GetRebuffTime()
    return SlamAndAwe.db.char.warning.timeleft
end

function SlamAndAwe:GetShowWFTotals()
	return SlamAndAwe.db.char.stats.wfcalc
end

function SlamAndAwe:SetBarFont(info, newValue)
	SlamAndAwe.db.char.barfont = newValue
	SlamAndAwe:RedrawFrames()
end

function SlamAndAwe:SetBarFontSize(info, newValue)
	SlamAndAwe.db.char.barfontsize = newValue
	SlamAndAwe:RedrawFrames()
end

function SlamAndAwe:SetBarFontEffect(info, newValue)
	SlamAndAwe.db.char.barfonteffect = newValue
	SlamAndAwe:RedrawFrames()
end

function SlamAndAwe:SetMsgFont(info, newValue)
	SlamAndAwe.db.char.msgfont = newValue
	SlamAndAwe:CreateMsgFrame()
end

function SlamAndAwe:SetMsgFontSize(info, newValue)
	SlamAndAwe.db.char.msgfontsize = newValue
	SlamAndAwe:CreateMsgFrame()
end

function SlamAndAwe:SetMsgFontEffect(info, newValue)
	SlamAndAwe.db.char.msgfonteffect = newValue
	SlamAndAwe:CreateMsgFrame()
end

function SlamAndAwe:SetBarTexture(info, newValue)
	SlamAndAwe.db.char.texture = newValue
	local barTexture = media:Fetch('statusbar', newValue)
	SlamAndAwe.frames["GCD"].statusbar:SetStatusBarTexture(barTexture)
end

function SlamAndAwe:SetBorderTexture(info, newValue)
	SlamAndAwe.db.char.border = newValue
	local newTexture = media:Fetch("border", SlamAndAwe.db.char.border)
	if newTexture then
		SlamAndAwe.frameBackdrop.edgeFile = newTexture
		SlamAndAwe:RedrawFrames()
	else
		if SlamAndAwe.db.char.debug then
			SlamAndAwe:Print("border texture not found. Trying to set "..SlamAndAwe.db.char.border)
		end
	end
end

function SlamAndAwe:SetBarBorderTexture(info, newValue)
	SlamAndAwe.db.char.barborder = newValue
	local newTexture = media:Fetch("border", SlamAndAwe.db.char.barborder)
	if newTexture then
		SlamAndAwe.barBackdrop.edgeFile = newTexture
		SlamAndAwe.frames["Maelstrom"]:SetBackdrop(SlamAndAwe.barBackdrop)
		SlamAndAwe.frames["Stormstrike"]:SetBackdrop(SlamAndAwe.barBackdrop)
		SlamAndAwe.frames["Shock"]:SetBackdrop(SlamAndAwe.barBackdrop)
		SlamAndAwe.frames["Windfury"]:SetBackdrop(SlamAndAwe.barBackdrop)
		SlamAndAwe.frames["GCD"]:SetBackdrop(SlamAndAwe.barBackdrop)
		
--SlamAndAwe
		SlamAndAwe.frames["ColossusSmash"]:SetBackdrop(SlamAndAwe.barBackdrop)
	  SlamAndAwe.frames["DeathWish"]:SetBackdrop(SlamAndAwe.barBackdrop)
	  SlamAndAwe.frames["Recklessness"]:SetBackdrop(SlamAndAwe.barBackdrop)		
		SlamAndAwe:RedrawFrames()
	else
		if SlamAndAwe.db.char.debug then
			SlamAndAwe:Print("bar border texture not found. Trying to set "..SlamAndAwe.db.char.barborder)
		end
	end
end

function SlamAndAwe:SetWeaponSound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	SlamAndAwe.db.char.weaponsoundname = newValue
	if newSound then
		SlamAndAwe.db.char.weaponsound = newSound
		PlaySoundFile(newSound)
	else
		if SlamAndAwe.db.char.debug then
			SlamAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function SlamAndAwe:SetMW5sound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	SlamAndAwe.db.char.mw5soundname = newValue
	if newSound then
		SlamAndAwe.db.char.mw5sound = newSound
		PlaySoundFile(newSound)
	else
		if SlamAndAwe.db.char.debug then
			SlamAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function SlamAndAwe:SetMW5repeat(info, newValue)
	SlamAndAwe.db.char.mw5repeat = newValue
end

function SlamAndAwe:SetMW4sound(info, newValue)
	local newSound = media:Fetch("sound", newValue)
	SlamAndAwe.db.char.mw4soundname = newValue
	if newSound then
		SlamAndAwe.db.char.mw4sound = newSound
		PlaySoundFile(newSound)
	else
		if SlamAndAwe.db.char.debug then
			SlamAndAwe:Print("Sound not found. Trying to set "..newSound)
		end
	end
end

function SlamAndAwe:SetRageThreshold(info, newValue)
	SlamAndAwe.db.char.rageThreshold = newValue
	SlamAndAwe:Print(L["config_Rage"]..newValue)
end

function SlamAndAwe:SetCooldownThreshold(info, newValue)
	SlamAndAwe.db.char.priority.cooldown = newValue
	SlamAndAwe:Print(L["config_Cooldown"]..newValue)
end

function SlamAndAwe:SetRebuffTime(info, newValue)
	SlamAndAwe.db.char.warning.timeleft = newValue
end

function SlamAndAwe:SetWidth(info,newValue)
	if InCombatLockdown() then
		SlamAndAwe:Print(L["Cannot change bar width in combat"])
		return
	end
	local wasMoving = SlamAndAwe.db.char.movingframes
	SlamAndAwe.db.char.fWidth = newValue
	SlamAndAwe:RedrawFrames()
	if wasMoving then
		SlamAndAwe:ShowHideBars()
	end
	SlamAndAwe:DebugPrint(L["Frame width set to : "]..SlamAndAwe.db.char.fWidth)	
end

function SlamAndAwe:SetScale(info,newValue)
	if InCombatLockdown() then
		SlamAndAwe:Print(L["Cannot change scale in combat"])
		return
	end
	local wasMoving = SlamAndAwe.db.char.movingframes
	SlamAndAwe.db.char.scale = newValue
	SlamAndAwe.BaseFrame:SetScale(SlamAndAwe.db.char.scale)
	SlamAndAwe:RedrawFrames()
	if wasMoving then
		SlamAndAwe:ShowHideBars()
	end
	SlamAndAwe:DebugPrint(L["Scale set to : "]..SlamAndAwe.db.char.scale)
end

function SlamAndAwe:SetPriorityScale(info,newValue)
	if InCombatLockdown() then
		SlamAndAwe:Print(L["Cannot change scale in combat"])
	end
	SlamAndAwe.db.char.priority.scale = newValue
	SlamAndAwe.PriorityFrame:SetScale(SlamAndAwe.db.char.priority.scale)
	SlamAndAwe:DebugPrint(L["Priority Scale set to : "]..SlamAndAwe.db.char.priority.scale)
end

function SlamAndAwe:SetMSalpha(info,newValue)
	if SlamAndAwe.db.char.msshow then
		SlamAndAwe.db.char.colours.msalpha = newValue
		SlamAndAwe:SetMaelstromAlpha(SlamAndAwe.db.char.colours.msalpha)
		SlamAndAwe:Print(L["config_MSAlpha_ooc"]..SlamAndAwe.db.char.colours.msalpha)
	end
end

function SlamAndAwe:SetMSalphaFull(info,newValue)
	if SlamAndAwe.db.char.msshow then
		SlamAndAwe.db.char.colours.msalphaFull = newValue
		SlamAndAwe:SetMaelstromAlpha(SlamAndAwe.db.char.colours.msalphaFull)
		SlamAndAwe:Print(L["config_MSAlpha_combat"]..SlamAndAwe.db.char.colours.msalphaFull)
	end
end

function SlamAndAwe:SetMaelstromAlpha(alphaValue)
	SlamAndAwe.frames["Maelstrom"]:SetBackdropColor(0, 0, 0, alphaValue * .2)
	SlamAndAwe.frames["Maelstrom"]:SetBackdropBorderColor( 1, 1, 1, alphaValue)
	local colours = SlamAndAwe.db.char.colours.maelstrom
	SlamAndAwe.frames["Maelstrom"].statusbar:SetStatusBarColor( colours.r, colours.g, colours.b, alphaValue)
end

-----------------------------------------
-- Colour choices getter/setters
-----------------------------------------

function SlamAndAwe:getFlameShockColour(info)
	local colours = SlamAndAwe.db.char.colours.flameshock
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setFlameShockColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.flameshock.r = r
	SlamAndAwe.db.char.colours.flameshock.g = g
	SlamAndAwe.db.char.colours.flameshock.b = b
	SlamAndAwe.db.char.colours.flameshock.a = a
	SlamAndAwe:ShockBar(SlamAndAwe.db.char.colours.flameshock)
end

function SlamAndAwe:getFlameShockDotColour(info)
	local colours = SlamAndAwe.db.char.colours.flameshockDot
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setFlameShockDotColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.flameshockDot.r = r
	SlamAndAwe.db.char.colours.flameshockDot.g = g
	SlamAndAwe.db.char.colours.flameshockDot.b = b
	SlamAndAwe.db.char.colours.flameshockDot.a = a
	FSDotTime = GetTime() + 18
	SlamAndAwe:FlameShockDotBar(true) 
end

function SlamAndAwe:getFrostShockColour(info)
	local colours = SlamAndAwe.db.char.colours.frostshock
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setFrostShockColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.frostshock.r = r
	SlamAndAwe.db.char.colours.frostshock.g = g
	SlamAndAwe.db.char.colours.frostshock.b = b
	SlamAndAwe.db.char.colours.frostshock.a = a
	SlamAndAwe:ShockBar(SlamAndAwe.db.char.colours.frostshock)
end

function SlamAndAwe:getWindShearColour(info)
	local colours = SlamAndAwe.db.char.colours.windshear
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setWindShearColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.windshear.r = r
	SlamAndAwe.db.char.colours.windshear.g = g
	SlamAndAwe.db.char.colours.windshear.b = b
	SlamAndAwe.db.char.colours.windshear.a = a
	SlamAndAwe:ShearBar()
end

function SlamAndAwe:getMaelstromColour(info)
	local colours = SlamAndAwe.db.char.colours.maelstrom
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setMaelstromColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.maelstrom.r = r
	SlamAndAwe.db.char.colours.maelstrom.g = g
	SlamAndAwe.db.char.colours.maelstrom.b = b
	SlamAndAwe.db.char.colours.maelstrom.a = a
	SlamAndAwe:MaelstromBar()
end

function SlamAndAwe:getStormstrikeColour(info)
	local colours = SlamAndAwe.db.char.colours.stormstrike
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setStormstrikeColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.stormstrike.r = r
	SlamAndAwe.db.char.colours.stormstrike.g = g
	SlamAndAwe.db.char.colours.stormstrike.b = b
	SlamAndAwe.db.char.colours.stormstrike.a = a
	SlamAndAwe:StormstrikeBar()
end

function SlamAndAwe:getWindfuryColour(info)
	local colours = SlamAndAwe.db.char.colours.windfury
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setWindfuryColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.windfury.r = r
	SlamAndAwe.db.char.colours.windfury.g = g
	SlamAndAwe.db.char.colours.windfury.b = b
	SlamAndAwe.db.char.colours.windfury.a = a
	SlamAndAwe:WFProcBar()
end

function SlamAndAwe:getColossusSmashColour(info)
	local colours = SlamAndAwe.db.char.colours.colossussmash
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setColossusSmashColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.colossussmash.r = r
	SlamAndAwe.db.char.colours.colossussmash.g = g
	SlamAndAwe.db.char.colours.colossussmash.b = b
	SlamAndAwe.db.char.colours.colossussmash.a = a
	SlamAndAwe:ColossusSmashBar()
end

function SlamAndAwe:getDeathWishColour(info)
	local colours = SlamAndAwe.db.char.colours.deathwish
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setDeathWishColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.deathwish.r = r
	SlamAndAwe.db.char.colours.deathwish.g = g
	SlamAndAwe.db.char.colours.deathwish.b = b
	SlamAndAwe.db.char.colours.deathwish.a = a
	SlamAndAwe:DeathWishBar()
end

function SlamAndAwe:getRecklessnessColour(info)
	local colours = SlamAndAwe.db.char.colours.recklessness
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setRecklessnessColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.recklessness.r = r
	SlamAndAwe.db.char.colours.recklessness.g = g
	SlamAndAwe.db.char.colours.recklessness.b = b
	SlamAndAwe.db.char.colours.recklessness.a = a
	SlamAndAwe:RecklessnessBar()
end

function SlamAndAwe:getFireNovaColour(info)
	local colours = SlamAndAwe.db.char.colours.firenova
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setFireNovaColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.firenova.r = r
	SlamAndAwe.db.char.colours.firenova.g = g
	SlamAndAwe.db.char.colours.firenova.b = b
	SlamAndAwe.db.char.colours.firenova.a = a
	SlamAndAwe:FireNovaBar()
end

function SlamAndAwe:getMagmaColour(info)
	local colours = SlamAndAwe.db.char.colours.magma
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setMagmaColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.magma.r = r
	SlamAndAwe.db.char.colours.magma.g = g
	SlamAndAwe.db.char.colours.magma.b = b
	SlamAndAwe.db.char.colours.magma.a = a
	SlamAndAwe:MagmaBar()
end

function SlamAndAwe:getLavaBurstColour(info)
	local colours = SlamAndAwe.db.char.colours.lavaburst
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setLavaBurstColour(info,r,g,b,a)
	SlamAndAwe.db.char.colours.lavaburst.r = r
	SlamAndAwe.db.char.colours.lavaburst.g = g
	SlamAndAwe.db.char.colours.lavaburst.b = b
	SlamAndAwe.db.char.colours.lavaburst.a = a
	SlamAndAwe:LavaBurstBar()
end

function SlamAndAwe:getFlurryColour(info)
	local colours = SlamAndAwe.db.char.uptime.flurry
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setFlurryColour(info,r,g,b,a)
	SlamAndAwe.db.char.uptime.flurry.r = r
	SlamAndAwe.db.char.uptime.flurry.g = g
	SlamAndAwe.db.char.uptime.flurry.b = b
	SlamAndAwe.db.char.uptime.flurry.a = a
	local buffColours = SlamAndAwe.db.char.uptime.flurry
	SlamAndAwe.uptime.session.buffs[Flurry].barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
	SlamAndAwe.uptime.lastfight.buffs[Flurry].barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
end

function SlamAndAwe:getENColour(info)
	local colours = SlamAndAwe.db.char.uptime.en
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setENColour(info,r,g,b,a)
	SlamAndAwe.db.char.uptime.en.r = r
	SlamAndAwe.db.char.uptime.en.g = g
	SlamAndAwe.db.char.uptime.en.b = b
	SlamAndAwe.db.char.uptime.en.a = a
	local buffColours = SlamAndAwe.db.char.uptime.en
	SlamAndAwe.uptime.session.buffs[Enrage].barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
	SlamAndAwe.uptime.lastfight.buffs[Enrage].barFrame.statusbar:SetStatusBarColor(buffColours.r, buffColours.g, buffColours.b, buffColours.a)
end

function SlamAndAwe:getWFTotalsColour(info)
	local colours = SlamAndAwe.db.char.stats.wfcol
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setWFTotalsColour(info,r,g,b,a)
	SlamAndAwe.db.char.stats.wfcol.r = r
	SlamAndAwe.db.char.stats.wfcol.g = g
	SlamAndAwe.db.char.stats.wfcol.b = b
	SlamAndAwe.db.char.stats.wfcol.a = a
end


-----------------------------------------
-- Priority Choices
-----------------------------------------

function SlamAndAwe:GetPriorityGroup(info)
	return SlamAndAwe.db.char.priority.groupnumber
end

function SlamAndAwe:SetPriorityGroup(info, groupnumber)
	SlamAndAwe.db.char.priority.groupnumber = groupnumber
	SlamAndAwe:SelectPrioritySet(groupnumber)
end

function SlamAndAwe:GetPriority(index)
	return 	
		function(info) 
			return SlamAndAwe.db.char.priority.prOption[index]  
		end
end

function SlamAndAwe:SetPriority(index)
	return 		
		function(info, priorityValue)
			SlamAndAwe:DebugPrint("setting priority "..index.." to "..priorityValue)
			SlamAndAwe.db.char.priority.prOption[index] = priorityValue
			SlamAndAwe.db.char.priority.prOptions[SlamAndAwe.db.char.priority.groupnumber] = SlamAndAwe.db.char.priority.prOption
		end
end

function SlamAndAwe:priorityQuery()
	return SlamAndAwe.db.char.priority.show
end

function SlamAndAwe:ActivatePriority()
	SlamAndAwe.db.char.priority.show = not SlamAndAwe.db.char.priority.show
	if (SlamAndAwe.db.char.priority.show) then
		SlamAndAwe:Print(L["config_priority_on"])
	else
		SlamAndAwe.PriorityFrame:Hide()
		SlamAndAwe:Print(L["config_priority_off"])
	end
end

function SlamAndAwe:priorityTitleQuery()
	return SlamAndAwe.db.char.priority.titleshow
end

function SlamAndAwe:ActivatePriorityTitle()
	SlamAndAwe.db.char.priority.titleshow = not SlamAndAwe.db.char.priority.titleshow
	if SlamAndAwe.db.char.priority.titleshow then
		SlamAndAwe.PriorityFrame.topText:Show()
		SlamAndAwe:Print(L["config_prioritytitle_on"])
	else
		SlamAndAwe.PriorityFrame.topText:Hide()
		SlamAndAwe:Print(L["config_prioritytitle_off"])
	end
end

---------------
-- Warnings
---------------

function SlamAndAwe:WarningFrameQuery()
	return SlamAndAwe.db.char.warning.show
end

function SlamAndAwe:ActivateWarningFrame()
	SlamAndAwe.db.char.warning.show = not SlamAndAwe.db.char.warning.show
	if (SlamAndAwe.db.char.warning.show) then
		SlamAndAwe:Print(L["config_warnframe_on"])
	else
		SlamAndAwe:Print(L["config_warnframe_off"])
	end
end

function SlamAndAwe:rangeWarnQuery()
	return SlamAndAwe.db.char.warning.range
end

function SlamAndAwe:ActivateRangeWarn()
	SlamAndAwe.db.char.warning.range = not SlamAndAwe.db.char.warning.range
	if (SlamAndAwe.db.char.warning.range) then
		SlamAndAwe:Print(L["config_rangewarn_on"])
	else
		SlamAndAwe:Print(L["config_rangewarn_off"])
	end
end

function SlamAndAwe:interruptWarnQuery()
	return SlamAndAwe.db.char.warning.interrupt
end

function SlamAndAwe:ActivateInterruptWarn()
	SlamAndAwe.db.char.warning.interrupt = not SlamAndAwe.db.char.warning.interrupt
	if (SlamAndAwe.db.char.warning.interrupt) then
		SlamAndAwe:Print(L["config_interruptwarn_on"])
	else
		SlamAndAwe:Print(L["config_interruptwarn_off"])
	end
end

function SlamAndAwe:EnableDisable()
	if InCombatLockdown() then
		SlamAndAwe:Print(L["Cannot enable/disable addon in combat"])
		return
	end
	SlamAndAwe.db.char.disabled = not SlamAndAwe.db.char.disabled
	if (SlamAndAwe.db.char.disabled) then
		SlamAndAwe:OnDisable()
		SlamAndAwe.BaseFrame:Hide()
		SlamAndAwe.PriorityFrame:Hide()
		SlamAndAwe.UptimeFrame:Hide()
		SlamAndAwe:Print(L["config_disabled_on"])
	else
		SlamAndAwe:OnEnable()
		SlamAndAwe:RedrawFrames()
		SlamAndAwe.db.char.movingframes = true -- forces false in ShowHideBars to re-enable frames
		SlamAndAwe:ShowHideBars()
		SlamAndAwe:Print(L["config_disabled_off"])
	end
end

function SlamAndAwe:ResetImmunity()
	SlamAndAwe.db.char.immuneTargets = {}
	SlamAndAwe:Print(L["config_resetImmunity"])
end

function SlamAndAwe:GetMSBTareas(info)
	return SlamAndAwe.db.char.MSBToutputarea
end

function SlamAndAwe:SetMSBTareas(info, value)
	SlamAndAwe.db.char.MSBToutputarea = value
end

function SlamAndAwe:getWarningColour(info)
	local colours = SlamAndAwe.db.char.warning.colour
	return colours.r, colours.g, colours.b, colours.a
end

function SlamAndAwe:setWarningColour(info,r,g,b,a)
	SlamAndAwe.db.char.warning.colour.r = r
	SlamAndAwe.db.char.warning.colour.g = g
	SlamAndAwe.db.char.warning.colour.b = b
	SlamAndAwe.db.char.warning.colour.a = a
end

function SlamAndAwe:GetWarningDuration(info)
	return SlamAndAwe.db.char.warning.duration 
end

function SlamAndAwe:SetWarningDuration(info, priorityValue)
	SlamAndAwe.db.char.warning.duration = priorityValue
end

function SlamAndAwe:OpenConfig()
	if InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory("SlamAndAwe");
	else
		InterfaceOptionsFrame_OpenToFrame("SlamAndAwe");
	end
end

function SlamAndAwe:GetMSBTAreaDefaults()
    local i = 0;
	SlamAndAwe.MSBT = {}
	SlamAndAwe.MSBT.areas = {}
    if MikSBT ~= nil and MikSBT.IterateScrollAreas ~= nil then
        for scrollAreaKey, scrollAreaName in MikSBT.IterateScrollAreas() do
            i = i + 1
            SlamAndAwe.MSBT.areas[i] = scrollAreaName
        end
    end
end