
JSHB.ver = GetAddOnMetadata( ..., "Version" ):match( "^([%d.]+)" )

local L	= JSHB.locale

JSHB.spellid = {
	-- Player / Target 
	{ 90355 },		-- Ancient Hysteria
	{ 19574 },		-- Bestial Wrath
	{ 3674 },		-- Black Arrow
	{ 20572 },		-- Blood Fury
	{ 2825 },		-- Blood Lust
	{ 53434 }, 		-- Call of the Wild
	{ 51755 },		-- Camoflauge
	{ 53209 },		-- Chimera Shot
	{ 5116 },		-- Concussive Shot
	{ 77767 },		-- Cobra Shot
	{ 12292 },		-- Deathwish (Warrior spell)
	{ 19263 },		-- Deterrance
	{ 781 },		-- Disengage
	{ 20736 },		-- Distracting Shot
	{ 53301 },		-- Explosive Shot
	{ 13813 },		-- Explosive Trap
	{ 5384 },		-- Feign Death
	{ 82726 },		-- Fervor
	{ 19623 },		-- Frenzy
	{ 82926 },		-- Fire! (proc)
	{ 82692 },		-- Focus Fire
	{ 1499 },		-- Freezing Trap
	{ 32182 },		-- Heroism
	{ 56303 },		-- Hunter's Mark
	{ 13795 },		-- Immolation Trap
	{ 19577 },		-- Intimidation
	{ 53351 },		-- Kill Shot
	{ 13809 },		-- Frost Trap
	{ 53220 },		-- Improved Steady Shot
	{ 34026 },		-- Kill Command
	{ 94007 }, 		-- Killing Streak
	{ 53351 },		-- Kill Shot
	{ 56453 },		-- Lock n' Load
	{ 53271 },		-- Master's Call
	{ 34477 },		-- Misdirection
	{ 1022 },		-- Hand of Protection (Paladin Spell)
	{ 79633 },		-- Potion of Tol'Vir
	{ 23989 },		-- Readiness
	{ 82925 },		-- ..Ready, Set, Aim
	{ 3045 },		-- Rapid Fire
	{ 2973 },		-- Raptor Strike
	{ 82897 },		-- Resistance is Futile
	{ 1513 },		-- Scare Beast
	{ 19503 },		-- Scatter Shot
	{ 1978 },		-- Serpent Sting
	{ 34490 },		-- Silencing Shot
	{ 34600 },		-- Snake Trap
	{ 90361 }, 		-- Spirit Mend
	{ 56641 },		-- Steady Shot
	{ 82175 },		-- Synapse Springs
	{ 34692 },		-- The Beast Within
	{ 80353 },		-- Time Warp
	{ 77769 },		-- Trap Launcher
	{ 26297 },		-- Berserking (Troll race)
	{ 82654 },		-- Widow Venom
	{ 2974 },		-- Wing Clip
	{ 19386 },		-- Wyvern Sting
	
	-- Pet Spells (Indicate a pet specific check by adding second column with value of '1' - for spells that put a buff on the actual pet and not you)
	{ 136, 1 },		-- Mend Pet
	{ 26090 },		-- Pummel
	{ 50479 },		-- Nether Shock
	{ 50318 },		-- Serenity Dust
}

JSHB.tranqalerts = {
	92967, -- BWD: Maloriak 
	80084, -- BWD: Maimgor
	80158, --  SC: Warbringers
	91543, -- BWD: Arcanotron - Power Conversion
	81706, --  TV: Lockmaw - Venomous Rage
}

JSHB.debuffalerts = {
	15007, -- Resurrection Sickness

	89000, --  BH: Argaloth - Fel Flames
	
	94679, -- BWD: Magmaw - Parasitic Infection
	
	91902, -- BWD: Pyreclaw - 25m
	80127, -- BWD: Pyreclaw - 10m
	
	80094, -- BWD: Toxitron - Fixate 
	
	91433, -- BWD: Electron - Lightning Conductor
	92053, -- BWD: Electron - Shadow Conductor
	
	92023, -- BWD: Magmatron - Encasing Shadows
	
	77786, -- BWD: Maloriak - Consuming Flames
	78617, -- BWD: Maloriak - Fixate
	77699, -- BWD: Maloriak - Flash Freeze
	77760, -- BWD: Maloriak - Biting Chill
	92987, -- BWD: Maloriak - Dark Sludge
	
	92407, -- BWD: Atramedes - Sonic Breath
	92485, -- BWD: Atramedes - Roaring Flame
	92423, -- BWD: Atramedes - Searing Flame
	
	79318, -- BWD: Nefarian - Dominion
	80627, -- BWD: Nefarian - Stolen Power (It's a Buff, but useful to know your stacks!)
	94075, -- BWD: Nefarian - Magma
	79339, -- BWD: Nefarian - Explosive Cinders
	
	82665, -- BOT: Feludius - Heart of Ice
	82762, -- BOT: Feludius - Waterlogged
	82665, -- BOT: Feludius - Heart of Ice
	93207, -- BOT: Feludius - Frost Beacon
	
	82660, -- BOT: Ignacious - Burning Blood
	
	92075, -- BOT: Terrastra - Gravity Core
	
	92067, -- BOT: Arion - Static Overload	
	83099, -- BOT: Arion - Lightning Rod
	
	86788, -- BOT: V&T - Blackout
	86622, -- BOT: V&T - Engulfing Magic
	88518, -- BOT: V&T - Twilight Meteorite
	86840, -- BOT: V&T - Devouring Flames
	92887, -- BOT: V&T - Twilight Zone
	
--	95809, 3045, -- Insanity (Ancient Hysteria) / Rapid Fire(for testing!)
}

JSHB.pos = {
	["TOP"]		= 1,
	["BOTTOM"]	= 2,
	["ABOVE"]	= 3, 
	["BELOW"]	= 4,
	["CENTER"]	= 5,
	["LEFT"]	= 6,
	["RIGHT"]	= 7,
	["MOVABLE"]	= 8,
}

JSHB.defaultFonts = {
	{ text = "Arial Narrow", 		value = "Fonts\\ARIALN.TTF",
		font = "Fonts\\ARIALN.TTF" },
	{ text = "Big Noodle", 			value = "Interface\\AddOns\\JSHunterBar\\media\\fonts\\BigNoodle.ttf",
		font = "Interface\\AddOns\\JSHunterBar\\media\\fonts\\BigNoodle.ttf" },
	{ text = "Friz Quadrata TT", 	value = "Fonts\\FRIZQT__.TTF",
		font = "Fonts\\FRIZQT__.TTF" },
	{ text = "Morpheus", 			value = "Fonts\\MORPHEUS.ttf",
		font = "Fonts\\MORPHEUS.ttf" },
	{ text = "Skurri", 				value = "Fonts\\skurri.ttf",
		font = "Fonts\\skurri.ttf" },
}
JSHB.fonts = {}

JSHB.defaultTextures = {
	{ text = "Blank", 				value = "Interface\\AddOns\\JSHunterBar\\media\\textures\\blank.tga",
		texture = "Interface\\AddOns\\JSHunterBar\\media\\textures\\blank.tga" },
	{ text = "Blizzard",			value = "Interface\\TargetingFrame\\UI-StatusBar",
		texture = "Interface\\TargetingFrame\\UI-StatusBar" },
	{ text = "Solid", 				value = "Interface\\AddOns\\JSHunterBar\\media\\textures\\solid.tga",
		texture = "Interface\\AddOns\\JSHunterBar\\media\\textures\\solid.tga"},
}
JSHB.textures = {}

JSHB.defaultSounds = {
	{ text = "Alliance Bell", 	value = "Sound\\Doodad\\BellTollAlliance.wav",
		sound = "Sound\\Doodad\\BellTollAlliance.wav" },
	{ text = "Cannon Blast", 	value = "Sound\\Doodad\\Cannon01_BlastA.wav",
		sound = "Sound\\Doodad\\Cannon01_BlastA.wav" },
	{ text = "Dynamite", 		value = "Sound\\Spells\\DynamiteExplode.wav",
		sound = "Sound\\Spells\\DynamiteExplode.wav" },
	{ text = "Gong", 			value = "Sound\\Doodad\\G_GongTroll01.wav",
		sound = "Sound\\Doodad\\G_GongTroll01.wav" },
	{ text = "Horde Bell", 		value = "Sound\\Doodad\\BellTollHorde.wav",
		sound = "Sound\\Doodad\\BellTollHorde.wav" },
	{ text = "Serpent", 		value = "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.wav",
		sound = "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.wav" },
	{ text = "Tribal Bell", 	value = "Sound\\Doodad\\BellTollTribal.wav",
		sound = "Sound\\Doodad\\BellTollTribal.wav" },
}

JSHB.sounds = {}

JSHB.specs = { "bm", "mm", "sv" } -- in order

JSHB.timerpositions = {
	{ L.posabove, 	JSHB.pos.ABOVE },
	{ L.poscenter, 	JSHB.pos.CENTER },
	{ L.posbelow, 	JSHB.pos.BELOW },
	{ L.posleft, 	JSHB.pos.LEFT },
	{ L.posright, 	JSHB.pos.RIGHT },
}

JSHB.timericonanchors = {
	{ L.posabove, 	JSHB.pos.ABOVE },
	{ L.posbelow, 	JSHB.pos.BELOW },
	{ L.posmovable,	JSHB.pos.MOVABLE },
}

JSHB.chatchannels = {
	{ L.chan_auto, 			1 },
	{ L.chan_raid, 			"RAID" },
	{ L.chan_yell, 			"YELL" },
	{ L.chan_officer, 		"OFFICER" },
	{ L.chan_guild, 		"GUILD" },
	{ L.chan_battleground,	"BATTLEGROUND" },
	{ L.chan_party, 		"PARTY" },
	{ L.chan_emote, 		"EMOTE" },
	{ L.chan_say, 			"SAY" },
	{ L.chan_selfwhisper,	"SELFWHISPER" },
}

JSHB.timerfontpositions = {
	{ L.posright, 		JSHB.pos.RIGHT },
	{ L.poscenter, 		JSHB.pos.CENTER },
	{ L.postopbottom,	JSHB.pos.TOP },
}

JSHB.defaults = {
	["main"] = {
		["anchorPoint"]						= "CENTER",
		["anchorPointRelative"] 			= "CENTER",
		["anchorPointOffsetX"] 				= 0,
		["anchorPointOffsetY"] 				= -170,

		["alertAnchorPoint"] 				= "CENTER",
		["alertAnchorPointRelative"] 		= "CENTER",
		["alertAnchorPointOffsetX"] 		= 0,
		["alertAnchorPointOffsetY"] 		= 120,
		
		["tranqablesAnchorPoint"] 			= "CENTER",
		["tranqablesAnchorPointRelative"] 	= "CENTER",
		["tranqablesAnchorPointOffsetX"] 	= 250,
		["tranqablesAnchorPointOffsetY"] 	= 250,

		["markAnchorPoint"] 				= "CENTER",
		["markAnchorPointRelative"] 		= "CENTER",
		["markAnchorPointOffsetX"] 			= 80,
		["markAnchorPointOffsetY"] 			= 100,

		["ccAnchorPoint"] 					= "CENTER",
		["ccAnchorPointRelative"] 			= "CENTER",
		["ccAnchorPointOffsetX"] 			= -190,
		["ccAnchorPointOffsetY"] 			= -170,

		["debuffAnchorPoint"] 				= "CENTER",
		["debuffAnchorPointRelative"] 		= "CENTER",
		["debuffAnchorPointOffsetX"] 		= -80,
		["debuffAnchorPointOffsetY"] 		= 100,

		["cdIconAnchorPoint"] 				= "CENTER",
		["cdIconAnchorPointRelative"]		= "CENTER",
		["cdIconAnchorPointOffsetX"] 		= 0,
		["cdIconAnchorPointOffsetY"] 		= -240,
	},

	["general"] = {
		["enableprediction"]				= true,
		["enablestackbars"]					= true,
		["movestackbarstotop"]				= false,
		["enableautoshotbar"]				= false,
		["enableautoshottext"]				= true,
		["enabletimers"]					= true,
		["timerfontposition"]				= JSHB.pos.TOP,
		["enablemaintick"]					= true,
		["enabletimerstext"]				= true,
		["enabletimertenths"]				= false,
		["enablecctimers"]					= true,
		["enablehuntersmarkwarning"]		= true,
		["enabletranqablesframe"]			= false,
		["enabletranqablestips"]			= false,
		["enabletranqannounce"]				= true,
		["tranqannouncechannel"]			= 1,
		["enabletranqalert"]				= true,
		["enabledebuffalert"]				= true,
		["enablecdicons"]					= true,
		["enabletargethealthpercent"]		= true,
		["timericonanchorparent"]			= JSHB.pos.MOVABLE,
		["timertextcoloredbytime"]			= true,
		["enablecurrentfocustext"]			= true,
	},

	["style"] = {
		["classcolored"]					= true,
		["classcoloredprediction"]			= true,
		["enablehighcolorwarning"]			= true,
		["enabletukui"]						= false,
		["enabletukuitimers"]				= false,
		["focushighthreshold"]				= 0.8,
		["focuscenteroffset"]				= 0,
		["barWidth"]						= 250,
		["barHeight"]						= 19,
		["iconSize"]						= 19,
		["cCIconSize"]						= 30,
		["markIconSize"]					= 40,
		["taiconsize"]						= 40,
		["tranqablesiconsize"]				= 24,
		["icontimerssize"]					= 30,
		["icontimersgap"]					= 260,
		["debufficonsize"]					= 40,
		["alphabackdrop"]					= 0.5,
		["alphazeroooc"]					= 0,
		["alphamaxooc"]						= 0.1,
		["alphanormooc"]					= 0.5,
		["alphazero"]						= 0.1,
		["alphamax"]						= 0.9,
		["alphanorm"]						= 0.9,
		["alphaicontimersfaded"]			= 0.35,
	},

	["fontstextures"] = {
		["barfont"]							= "Big Noodle",
		["timerfont"]						= "Arial Narrow",
		["bartexture"]						= "Blizzard",
		["fontoutlined"]					= true,
		["fontsize"]						= 17,
		["fontsizetimers"]					= 13,
	},

	["colors"] = {
		["barcolor"] 						= {0.6, 0.6, 0.6},
		["barcolorwarninglow"]				= {1, 0, 0},
		["barcolorwarninghigh"]				= {1, 0.55, 0},
		["predictionbarcolorwarninghigh"]	= {1, 0.55, 0},
		["predictionbarcolor"]				= {0.6, 0.6, 0.6},
		["autoshotbarcolor"]				= {1, 1, 1},
	},
	
	--  1st field = { spell ID, "true" for pet - or omit }
	--  2nd field = true to track duration up or false for cooldown
	--  3rd field = 1 for player, 0 for target, 2 for pet
	--  4th field = position of the icon relative to the bar
	--  5th field = offset index for icon timers (if placed in LEFT or RIGHT position)
	["bm"] = {
		{ 1978, 	true, 	0, 	JSHB.pos.ABOVE },
		{ 82654,	true, 	0, 	JSHB.pos.ABOVE },
		{ 3045, 	true, 	1, 	JSHB.pos.ABOVE },
		{ 82726, 	false, 	1, 	JSHB.pos.BELOW },
		{ 1499,		false, 	1, 	JSHB.pos.BELOW },
		{ 34692,	true, 	1, 	JSHB.pos.ABOVE },
		{ 19574,	false, 	1, 	JSHB.pos.BELOW },
		{ 90355,	true, 	1, 	JSHB.pos.ABOVE },
		{ 90355,	false, 	1, 	JSHB.pos.BELOW },
		{ 136,		true,	2,	JSHB.pos.ABOVE },
		{ 90361,	true,	1,	JSHB.pos.ABOVE },
		{ 90361,	false,	1,	JSHB.pos.BELOW },

	},

	["mm"] = {
		{ 53220, 	true, 	1, 	JSHB.pos.ABOVE },
		{ 1978, 	true, 	0, 	JSHB.pos.ABOVE },
		{ 82654,	true, 	0, 	JSHB.pos.ABOVE },
		{ 3045, 	true, 	1, 	JSHB.pos.ABOVE },
		{ 1499,		false, 	1, 	JSHB.pos.BELOW },
		{ 90355,	true, 	1, 	JSHB.pos.ABOVE },
		{ 136,		true,	2,	JSHB.pos.ABOVE },
	},

	["sv"] = {
		{ 3674, 	false, 	1, 	JSHB.pos.ABOVE },
		{ 1978, 	true, 	0, 	JSHB.pos.ABOVE },
		{ 3045, 	true, 	1, 	JSHB.pos.ABOVE },
		{ 82654,	true, 	0, 	JSHB.pos.ABOVE },
		{ 19386, 	false, 	1, 	JSHB.pos.BELOW },
		{ 1499,		false, 	1, 	JSHB.pos.BELOW },
		{ 90355,	true, 	1, 	JSHB.pos.ABOVE },
		{ 136,		true,	2,	JSHB.pos.ABOVE },
	},
	
	["misdirection"] = {
		["enablerightclickmd"]				= true,
		["enablemdonpet"]					= true,
		["enablemdonparty"]					= true,
		["enablemdonraid"]					= true,
		["enablemdcastannounce"]			= true,
		["enablemdoverannounce"]			= false,
		["enablemdtargetwhisper"]			= true,
		["mdannouncechannel"]				= 1,
	},
	
	["customspell"] = {},

	["customtranq"] = {},

	["customaura"] = {},
}

JSHB.defaults.faction = {
	["Alliance"] = {
		["bm"] = {
			{ 32182,	true, 	1, 	JSHB.pos.ABOVE },
		},
		
		["mm"] = {
			{ 32182,	true, 	1, 	JSHB.pos.ABOVE },
		},
		
		["sv"] = {
			{ 32182,	true, 	1, 	JSHB.pos.ABOVE },
		},
	},
	
	["Horde"] = {
		["bm"] = {
			{ 20572,	true, 	1, 	JSHB.pos.ABOVE },
			{ 20572,	false, 	1, 	JSHB.pos.BELOW },
			{ 2825,		true, 	1, 	JSHB.pos.ABOVE },			
		},
		
		["mm"] = {
			{ 20572,	true, 	1, 	JSHB.pos.ABOVE },
			{ 20572,	false, 	1, 	JSHB.pos.BELOW },
			{ 2825,		true, 	1, 	JSHB.pos.ABOVE },
		},
		
		["sv"] = {
			{ 20572,	true, 	1, 	JSHB.pos.ABOVE },
			{ 20572,	false, 	1, 	JSHB.pos.BELOW },
			{ 2825,		true, 	1, 	JSHB.pos.ABOVE },
		},
	},
}

-- Format:
-- Pre.. Text or ""
-- ..Mid.. Text or ""
-- ..Post Text or ""
-- Starting number (append an integer to Pre.., before ..Mid.. starting at this increment) - Top nest of loop or nil
-- Ending number  (max increment number that 'Starting number' should count up to and inclue) or nil
-- Starting number2 (append an integer to ..Mid.., before ..Post starting at this increment) - Nested inside previous or nil
-- Ending number2  (max increment number that 'Starting number2' should count up to and inclue) or nil
JSHB.mdframeinfo = {

	["general"] = {
		-- TukUI Frames
		{ "TukuiFocus", "", "" },
		{ "TukuiTargetTarget", "", "" },
		{ "TukuiMainAssist", "", "" },
		{ "TukuiMainTank", "", "" },
		-- ElvUI Frames
		{ "ElvDPS_focus", "", "" },
		{ "ElvDPS_targettarget", "", "" },
		-- Shadowed Unit Frames
		{ "SUFUnitfocus", "", "" },
		{ "SUFUnittargettarget", "", "" },
		{ "SUFHeadermaintankUnitButton", "", "", 1, 5 },
		-- nUI
		{ "nUI_SoloUnit_Focus", "", "" },
		{ "nUI_SoloUnit_ToT", "", "" },
		-- X-perl
		{ "XPerl_TargetTarget", "", "" },
	},

	["pet"] = {
		-- Blizzard Frames
		{ "PetFrame", "", "" },
		{ "PartyMemberFrame", "", "PetFrame", 1, 4 },
		-- TukUI Frames		
		{ "TukuiPet", "", "" },		
		-- ElvUI Frames
		{ "ElvDPS_pet", "", "" },
		{ "ElvHeal_pet", "", "" },
		-- Shadowed Unit Frames
		{ "SUFUnitpet", "", "" },
		{ "SUFChildpartypet", "", "", 1, 5 },
		-- nUI
		{ "nUI_SoloUnit_Pet", "", "" },
		{ "nUI_PartyUnit_PartyPet", "", "", 1, 4 },
		-- X-perl
		{ "XPerl_PlayerPet", "", "" },
		{ "XPerl_PartyPet", "", "", 1, 5 },
	},
	
	["party"] = {
		-- Blizzard Frames
		{ "PartyMemberFrame", "", "", 1, 4 },
		{ "CompactPartyFrameMember", "", "", 1, 10 },
		-- TukUI Frames
		{ "oUF_TukuiParty", "", "", 1, 4 },
		{ "oUF_TukuiPartyPet", "", "", 1, 4 },
		-- ElvUI Frames
		{ "ElvuiDPSPartyUnitButton", "", "", 1, 10 },
		-- Shadowed Unit Frames
		{ "SUFHeaderpartyUnitButton", "", "", 1, 5 },
		-- nUI
		{ "nUI_PartyUnit_Party", "", "", 1, 4 },
		-- X-Perl
		{ "XPerl_Party", "", "", 1, 5 }
	},
	
	["raid"] = {
		-- Blizzard Frames
		{ "CompactRaidFrame", "", "", 1, 80 },
		{ "SimpleTankFramesUnitButton", "", "", 1, 5 },
		-- TukUI Frames
		{ "oUF_TukuiDpsRaid05101525", "", "", 1, 50 },
		{ "oUF_TukuiHealRaid0115", "", "", 1, 50 },
		{ "oUF_TukuiDpsRaid40", "", "", 1, 80 },
		{ "TukuiGrid", "", "", 1, 80 },
		{ "TukuiMainTank", "", "" },
		-- ElvUI Frames
		{ "ElvuiDPSR6R25UnitButton", "", "", 1, 50 },
		{ "ElvDPSMainTankUnitButton", "", "", 1, 10 },
		{ "ElvuiDPSR26R40UnitButton", "", "", 1, 80 },
		{ "ElvHealMainTankUnitButton", "", "", 1, 5 },
		-- Grid Frames
		{ "GridLayoutHeader", "UnitButton", "", 1, 10, 1, 12 },
		-- Shadowed Unit Frames
		{ "SUFHeaderraidUnitButton", "", "", 1, 40 },
		{ "SUFHeaderraidpetUnitButton", "", "", 1, 40 },
		-- nUI
		{ "nUI_Raid10Unit_Raid", "", "", 1, 10 },
		{ "nUI_Raid10Unit_Focus", "", "" },
		{ "nUI_Raid10Unit_PartyPet", "", "", 1, 10 },
		{ "nUI_Raid10Unit_Pet", "", "" },
		{ "nUI_Raid10Unit_ToT", "", "" },		
		{ "nUI_Raid15Unit_Raid", "", "", 1, 15 },
		{ "nUI_Raid15Unit_Focus", "", "" },
		{ "nUI_Raid15Unit_PartyPet", "", "", 1, 15 },
		{ "nUI_Raid15Unit_Pet", "", "" },
		{ "nUI_Raid15Unit_ToT", "", "" },
		{ "nUI_Raid20Unit_Raid", "", "", 1, 20 },
		{ "nUI_Raid20Unit_Focus", "", "" },
		{ "nUI_Raid20Unit_PartyPet", "", "", 1, 20 },
		{ "nUI_Raid20Unit_Pet", "", "" },
		{ "nUI_Raid20Unit_ToT", "", "" },
		{ "nUI_Raid25Unit_Raid", "", "", 1, 25 },
		{ "nUI_Raid25Unit_Focus", "", "" },
		{ "nUI_Raid25Unit_PartyPet", "", "", 1, 25 },
		{ "nUI_Raid25Unit_Pet", "", "" },
		{ "nUI_Raid25Unit_ToT", "", "" },
		{ "nUI_Raid40Unit_Raid", "", "", 1, 40 },
		{ "nUI_Raid40Unit_Focus", "", "" },
		{ "nUI_Raid40Unit_PartyPet", "", "", 1, 40 },
		{ "nUI_Raid40Unit_Pet", "", "" },
		{ "nUI_Raid40Unit_ToT", "", "" },
		-- X-perl
		{ "XPerl_RaidFrames", "", "", 1, 80 },
	},
}

-- Misc global variables
JSHB.classColors			= { 0.67, 0.83, 0.45 }
JSHB.predictionSpellBase 	= 9 					-- Value of focus gained from base of Steady/Cobra Shot
JSHB.currentTree 			= 0
JSHB.barLocked				= true
JSHB.isCasting				= false
JSHB.moveColor				= { 0, .5, 0, .8 } 		-- Green
JSHB.autoShotStartTime		= 0
JSHB.autoShotEndTime		= 0
JSHB.functionChain			= {}

-- Setup frames
JSHB.timerFrames 		= {}
JSHB.iconTimerFrames	= {}
JSHB.stackBarFrames 	= {}
JSHB.cCIconFrames		= {}
JSHB.debuffIconFrames	= {}
JSHB.cDIconFrames		= {}
