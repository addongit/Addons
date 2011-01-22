SliceCommander = LibStub("AceAddon-3.0"):NewAddon("SliceCommander", "AceTimer-3.0")
local self = SliceCommander
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")

SLICECMDR = { }
SLICECMDR.AlertPending = 0
SLICECMDR.curCombo = 0
SLICECMDR.LastTime = 0
SLICECMDR.BarFont = 0
SLICECMDR.LastEnergy = 0
SLICECMDR.MHExpire = 0
SLICECMDR.OHExpire = 0
SLICECMDR.tNow = 0
SLICECMDR.currnetBloodSpell = ' '
SLICECMDR.currnetBloodCaster = ''
local soundStatus
nextStop = 0

local curComboTarget = ""

-- fade
local fadein = 0.5       -- fade delay for each combo point frame
local fadeout = 0.5      -- fade delay for each combo point frame
local framefadein = 0.4  -- fade delay for entering combat
local framefadeout = 0.4 -- fade delay for leaving combat
local scaleUI = 0
local widthUI = 0

local SliceCmdr_BarOrderNeg = {}
local SliceCmdr_BarOrderPos = {}

function self:TestValueOptions()
	if SliceCmdr_Save == nil then
		return true
	end
	if SliceCmdr_Save.IsLocked == nil or
	SliceCmdr_Save.HideEnergy == nil or
	SliceCmdr_Save.Energy1 == nil or
	SliceCmdr_Save.Energy2 == nil or
	SliceCmdr_Save.Energy3 == nil or
	SliceCmdr_Save.Fail == nil or
	SliceCmdr_Save.Expire == nil or
	SliceCmdr_Save.Tick3 == nil or
	SliceCmdr_Save.Tick2 == nil or
	SliceCmdr_Save.Tick1 == nil or
	SliceCmdr_Save.Applied == nil or
	SliceCmdr_Save.Apply3 == nil or
	SliceCmdr_Save.Apply2 == nil or
	SliceCmdr_Save.Apply1 == nil or
	SliceCmdr_Save.EnergySound1 == nil or
	SliceCmdr_Save.EnergySound2 == nil or
	SliceCmdr_Save.EnergySound3 == nil or
	SliceCmdr_Save.HealthUnder == nil or
	SliceCmdr_Save.RUP_Fail == nil or
	SliceCmdr_Save.RUP_Expire == nil or
	SliceCmdr_Save.RUP_Applied == nil or
	SliceCmdr_Save.RUP_Refresh3 == nil or
	SliceCmdr_Save.RUP_Refresh2 == nil or
	SliceCmdr_Save.RUP_Refresh1 == nil or
	SliceCmdr_Save.RUP_Alert == nil or
	SliceCmdr_Save.Width == nil or
	SliceCmdr_Save.Scale == nil or
	SliceCmdr_Save.PadLatency == nil or
	SliceCmdr_Save.SpellText == nil or
	SliceCmdr_Save.FullTimer == nil or
	SliceCmdr_Save.SoundCombat == nil or
	SliceCmdr_Save.EnergyTrans == nil or
	SliceCmdr_Save.BarMargin == nil or
	SliceCmdr_Save.DPBarShow == nil or
	SliceCmdr_Save.EnvenomShow == nil or
	SliceCmdr_Save.PoisonShow == nil or
	SliceCmdr_Save.PoisonTransparencyShow == nil or
	SliceCmdr_Save.EABarShow == nil or
	SliceCmdr_Save.SnDBarShow == nil or
	SliceCmdr_Save.VenBarShow == nil or
	SliceCmdr_Save.RECBarShow == nil or
	SliceCmdr_Save.StunBarShow == nil or
	SliceCmdr_Save.TotTBarShow == nil or
	SliceCmdr_Save.RupBarShow == nil or
	SliceCmdr_Save.RupBarMine == nil or
	SliceCmdr_Save.THREATBarShow == nil or
	SliceCmdr_Save.checkHealthSpec1 == nil or
	SliceCmdr_Save.checkHealthSpec2 == nil or
	SliceCmdr_Save.CPBarShow == nil or
	SliceCmdr_Save.ThreatGroupOnly == nil or
	SliceCmdr_Save.EnergyHeight == nil or
	SliceCmdr_Save.TimerHeight == nil or
	SliceCmdr_Save.BarTexture == nil or
	SliceCmdr_Save.PosCP == nil or
	SliceCmdr_Save.PosThreat == nil or
	SliceCmdr_Save.PosSTUN == nil or
	SliceCmdr_Save.PosREC == nil or
	SliceCmdr_Save.PosSND == nil or
	SliceCmdr_Save.PosRUP == nil or
	SliceCmdr_Save.PosTOT == nil or
	SliceCmdr_Save.PosVEN == nil or
	SliceCmdr_Save.PosDP == nil or
	SliceCmdr_Save.PosEA == nil
	then
		return true
	end
	return false	
end

function self:SetDefaultOptions()
	SliceCmdr_Save = {}
	SliceCmdr_Save.IsLocked = true
	SliceCmdr_Save.HideEnergy = false
	SliceCmdr_Save.Energy1 = 35
	SliceCmdr_Save.Energy2 = 55
	SliceCmdr_Save.Energy3 = 25
	SliceCmdr_Save.Fail = 'None'
	SliceCmdr_Save.Expire = 'None'
	SliceCmdr_Save.Tick3 = 'None'
	SliceCmdr_Save.Tick2 = 'None'
	SliceCmdr_Save.Tick1 = 'None'
	SliceCmdr_Save.Applied = 'None'
	SliceCmdr_Save.Apply3 = 'None'
	SliceCmdr_Save.Apply2 = 'None'
	SliceCmdr_Save.Apply1 = 'None'
	SliceCmdr_Save.EnergySound1 = 'None'
	SliceCmdr_Save.EnergySound2 = 'None'
	SliceCmdr_Save.EnergySound3 = 'None'
	SliceCmdr_Save.HealthUnder = 'You Spin Me'
	SliceCmdr_Save.RUP_Fail = 'None'
	SliceCmdr_Save.RUP_Expire = 'None'
	SliceCmdr_Save.RUP_Applied = 'None'
	SliceCmdr_Save.RUP_Refresh3 = 'None'
	SliceCmdr_Save.RUP_Refresh2 = 'None'
	SliceCmdr_Save.RUP_Refresh1 = 'None'
	SliceCmdr_Save.RUP_Alert = 'None'
	SliceCmdr_Save.Width = 280
	SliceCmdr_Save.Scale = 100
	SliceCmdr_Save.PadLatency = true
	SliceCmdr_Save.SpellText = true
	SliceCmdr_Save.FullTimer = false
	SliceCmdr_Save.SoundCombat = true
	SliceCmdr_Save.EnergyTrans = 0
	SliceCmdr_Save.BarMargin = 3
	SliceCmdr_Save.DPBarShow = true
	SliceCmdr_Save.EnvenomShow = true
	SliceCmdr_Save.PoisonShow = true
	SliceCmdr_Save.PoisonTransparencyShow = true
	SliceCmdr_Save.EABarShow = true
	SliceCmdr_Save.SnDBarShow = true
	SliceCmdr_Save.VenBarShow = true
	SliceCmdr_Save.RECBarShow = true
	SliceCmdr_Save.StunBarShow = true
	SliceCmdr_Save.TotTBarShow = true
	SliceCmdr_Save.RupBarShow = true
	SliceCmdr_Save.RupBarMine = true
	SliceCmdr_Save.THREATBarShow = true
	SliceCmdr_Save.checkHealthSpec1 = true
	SliceCmdr_Save.checkHealthSpec2 = false
	SliceCmdr_Save.CPBarShow = true
	SliceCmdr_Save.ThreatGroupOnly = true
	SliceCmdr_Save.EnergyHeight = 28
	SliceCmdr_Save.TimerHeight = 17
	SliceCmdr_Save.BarTexture = 'Blizzard'
	SliceCmdr_Save.PosCP = -1
	SliceCmdr_Save.PosThreat = -2
	SliceCmdr_Save.PosSTUN = -3
	SliceCmdr_Save.PosREC = 1
	SliceCmdr_Save.PosSND = 2
	SliceCmdr_Save.PosRUP = 3
	SliceCmdr_Save.PosTOT = 4
	SliceCmdr_Save.PosVEN = 5
	SliceCmdr_Save.PosDP = 6
	SliceCmdr_Save.PosEA = 7
	
	if SLICECMDR.BARS['SnD']['obj'] ~= 0 then
		SliceCmdr_LockCkecked(SliceCmdr_Save.IsLocked)
		SliceCmdr_SetTimerHeight(SliceCmdr_Save.TimerHeight)
		SliceCmdr_SetWidth(SliceCmdr_Save.Width)
		SliceCmdr_SetEnergyHeight(SliceCmdr_Save.EnergyHeight)
		SliceCmdr_SetScale(SliceCmdr_Save.Scale)
		SliceCmdr_Config_RetextureBars()
		LibStub("AceConfigRegistry-3.0"):NotifyChange("SliceCommander")
	end
end

function self:ConfigSoundMenuInit(WhichMenu)
	returnArray = {}
	for ignore, SoundName in pairs(SliceCmdr_SoundMenu[WhichMenu]) do   
		returnArray[SoundName] = SoundName
	end
	return returnArray
end


SC_OptionsTable_Sound = {
	name = SC_LANG_SOUND,
	handler = SliceCommander,
	type = "group",
	args = {--Sound settings
		headerSndSoundSetting = {--Slice and Dice
			order = 1,
			name = "Slice and Dice",
			type = "header"
		},
		Tick3 = {--Alert - 3 sec
			order = 2,
			name = "Alert - 3 sec",
			desc = "Alert 3 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Tick")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Tick3 = val
			end,
			get = function(info) return SliceCmdr_Save.Tick3 end
		},
		Tick2 = {--Alert - 2 sec
			order = 4,
			name = "Alert - 2 sec",
			desc = "Alert 2 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Tick")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Tick2 = val
			end,
			get = function(info) return SliceCmdr_Save.Tick2 end
		},
		Tick1 = {--Alert - 1 sec
			order = 6,
			name = "Alert - 1 sec",
			desc = "Alert 1 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Tick")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Tick1 = val
			end,
			get = function(info) return SliceCmdr_Save.Tick1 end
		},
		Apply3 = {--Refresh - 3 sec
			order = 3,
			name = "Refresh - 3 sec",
			desc = "Refresh 3 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Apply3 = val
			end,
			get = function(info) return SliceCmdr_Save.Apply3 end
		},
		Apply2 = {--Refresh - 2 sec
			order = 5,
			name = "Refresh - 2 sec",
			desc = "Refresh 2 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Apply2 = val
			end,
			get = function(info) return SliceCmdr_Save.Apply2 end
		},
		Apply1 = {--Refresh - 1 sec
			order = 7,
			name = "Refresh - 1 sec",
			desc = "Refresh 1 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Apply1 = val
			end,
			get = function(info) return SliceCmdr_Save.Apply1 end
		},
		Fail = {--Faillure
			order = 8,
			name = "Faillure",
			desc = "The refresh failled",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Fail")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Fail = val
			end,
			get = function(info) return SliceCmdr_Save.Fail end
		},
		
		Applied = {--Applied
			order = 9,
			name = "Applied",
			desc = "Slice and Dice is applied",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Applied = val
			end,
			get = function(info) return SliceCmdr_Save.Applied end
		},
		Expire = {--Expire
			order = 10,
			name = "Expired",
			desc = "Slice and Dice buff expire",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Fail")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.Expire = val
			end,
			get = function(info) return SliceCmdr_Save.Expire end
		},
		headerRupSoundSetting = {--Rupture
			order = 11,
			name = "Rupture",
			type = "header"
		},
		RUP_Alert = {--Alert
			order = 12,
			name = "Alert",
			desc = "Alert 3, 2 and 1 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Tick")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Alert = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Alert end
		},
		RUP_Refresh3 = {--Refresh - 3 sec
			order = 13,
			name = "Refresh - 3 sec",
			desc = "Refresh 3 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Refresh3 = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Refresh3 end
		},
		RUP_Refresh2 = {--Refresh - 2 sec
			order = 15,
			name = "Refresh - 2 sec",
			desc = "Refresh 2 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Refresh2 = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Refresh2 end
		},
		RUP_Refresh1 = {--Refresh - 1 sec
			order = 17,
			name = "Refresh - 1 sec",
			desc = "Refresh 1 secondes before fade",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Refresh1 = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Refresh1 end
		},
		RUP_Fail = {--Faillure
			order = 14,
			name = "Faillure",
			desc = "The refresh failled",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Fail")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Fail = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Fail end
		},
		RUP_Applied = {--Applied
			order = 16,
			name = "Applied",
			desc = "Rupture is applied",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Apply")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Applied = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Applied end
		},
		RUP_Expire = {--Expire
			order = 18,
			name = "Expired",
			desc = "Rupture debuff expire",
			type = "select",
			values = function()
				return self:ConfigSoundMenuInit("Fail")
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.RUP_Expire = val
			end,
			get = function(info) return SliceCmdr_Save.RUP_Expire end
		},
	}
}


SC_OptionsTable_DisplayTimer = {
	name = SC_DISPLAY_SETTINGS,
	handler = SliceCommander,
	type = "group",
	args = {--Display setting
		displayDescription = {
			order = 0,
			name = "Each bar have to have a different position. If you want to have a bar on the top of the energy bar you have to use negative index. Positive index is used to position bar at the bottom.",
			fontSize = "medium",
			type = "description"
		},
		headerEnergySetting = {--Combo Point Settings
			order = 1,
			name = "Energy bar Settings",
			type = "header"
		},
		HideEnergy = {--Hide Energy
			order = 2,
			name = "Hide Energy bar",
			desc = "Hide the Energy bar",
			type = "toggle",
			set = function(info,val)
				if val then
					VTimerEnergy:Hide()
				else
					VTimerEnergy:Show()
				end
				SliceCmdr_Save.HideEnergy = val
			end,
			get = function(info) return SliceCmdr_Save.HideEnergy end
		},
		EnergyTrans = {--Energy bar transparancy
			order = 3,
			name = "Transparency (Full)",
			desc = "The fade out value of the energy bar when it is full.",
			type = "range",
			min = 0,
			max = 100,
			step = 1,
			bigStep = 1,
			set = function(info,val)
				VTimerEnergy:SetAlpha( val / 100.0 )
				SLICECMDR.BARS['MH']['obj']:SetAlpha(val / 100.0)
				SLICECMDR.BARS['OH']['obj']:SetAlpha(val / 100.0)
				SliceCmdr_Save.EnergyTrans = val
			end,
			get = function(info) return SliceCmdr_Save.EnergyTrans end,
			isPercent = false
		},
		Energy1 = {--Energy Marker 1
			order = 4,
			name = "Energy Marker 1",
			type = "range",
			min = 0,
			max = 100,
			step = 1,
			bigStep = 1,
			set = function(info,val)
				SliceCmdr_Save.Energy1 = val
				SliceCmdr_Config_OtherVars()
			end,
			get = function(info) return SliceCmdr_Save.Energy1 end,
			isPercent = false
		},
		Energy2 = {--Energy Marker 2
			order = 5,
			name = "Energy Marker 2",
			type = "range",
			min = 0,
			max = 100,
			step = 1,
			bigStep = 1,
			set = function(info,val)
				SliceCmdr_Save.Energy2 = val
				SliceCmdr_Config_OtherVars()
			end,
			get = function(info) return SliceCmdr_Save.Energy2 end,
			isPercent = false
		},
		Energy3 = {--Energy Marker 3
			order = 6,
			name = "Energy Marker 3",
			type = "range",
			min = 0,
			max = 100,
			step = 1,
			bigStep = 1,
			set = function(info,val)
				SliceCmdr_Save.Energy3 = val
				SliceCmdr_Config_OtherVars()
			end,
			get = function(info) return SliceCmdr_Save.Energy3 end,
			isPercent = false
		},
		headerDPSetting = {--Poison bar Settings
			order = 7,
			name = "Poison bar Settings",
			type = "header"
		},
		DPBarShow = {--Show Poison
			order = 8,
			name = "Show Poison bar",
			desc = "Display the Poison timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.DPBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.DPBarShow end
		},
		PosDP = {--Poison position
			order = 9,
			name = "Poison bar position",
			desc = "The place where to display the Poison bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosDP = val
			end,
			get = function(info) return SliceCmdr_Save.PosDP end
		},
		EnvenomShow = {--Show Envenom
			order = 10,
			name = "Show envenom buff",
			desc = "The timer bar in default will display the timer of deadly poison on the target.",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.EnvenomShow = val
			end,
			get = function(info) return SliceCmdr_Save.EnvenomShow end
		},
		PoisonShow = {--Show Poison weapon enchant
			order = 11,
			name = "Show poison weapon enchant",
			desc = "Display two thin poison bar timer on the energy bar corresponding of each temporary enchant on each weapon.",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.PoisonShow = val
			end,
			get = function(info) return SliceCmdr_Save.PoisonShow end
		},
		PoisonTransparencyShow = {--Show Poison weapon enchant
			order = 12,
			name = "Disable energy bar fade out",
			desc = "Disable energy bar and poison bar fade out when poison on weapon(s) is up",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.PoisonTransparencyShow = val
			end,
			get = function(info) return SliceCmdr_Save.PoisonTransparencyShow end
		},
		headerVendettaSetting = {--Vendetta Settings
			order = 101,
			name = "Vendetta Settings",
			type = "header"
		},
		VenBarShow = {--Show vendetta
			order = 102,
			name = "Show vendetta bar",
			desc = "Display the vendetta timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.VenBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.VenBarShow end
		},
		PosVEN = {--Vendetta position
			order = 103,
			name = "Vendetta bar position",
			desc = "The place where to display the vendetta bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosVEN = val
			end,
			get = function(info) return SliceCmdr_Save.PosVEN end
		},
		headerToTSetting = {--Tricks of the Trade Settings
			order = 104,
			name = "Tricks of the Trade Settings",
			type = "header"
		},
		TotTBarShow = {--Show ToT
			order = 105,
			name = "Show Tricks of the Trade bar",
			desc = "Display the Tricks of the Trade timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.TotTBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.TotTBarShow end
		},
		PosTOT = {--ToT position
			order = 106,
			name = "Tricks of the Trade bar position",
			desc = "The place where to display the Tricks of the Trade bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosTOT = val
			end,
			get = function(info) return SliceCmdr_Save.PosTOT end
		},
		headerEASetting = {--Expose Armor Settings
			order = 107,
			name = "Expose Armor Settings",
			type = "header"
		},
		EABarShow = {--Show EA
			order = 108,
			name = "Show Expose Armor bar",
			desc = "Display the Expose Armor timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.EABarShow = val
			end,
			get = function(info) return SliceCmdr_Save.EABarShow end
		},
		PosEA = {--EA position
			order = 109,
			name = "Expose Armor bar position",
			desc = "The place where to display the Expose Armor bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosEA = val
			end,
			get = function(info) return SliceCmdr_Save.PosEA end
		},
		headerRecSetting = {--Recuperate Settings
			order = 110,
			name = "Recuperate Settings",
			type = "header"
		},
		RECBarShow = {--Show Recuperate
			order = 111,
			name = "Show Recuperate bar",
			desc = "Display the Recuperate timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.RECBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.RECBarShow end
		},
		PosREC = {--Recuperate position
			order = 112,
			name = "Recuperate bar position",
			desc = "The place where to display the Recuperate bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosREC = val
			end,
			get = function(info) return SliceCmdr_Save.PosREC end
		},
		headerStunSetting = {--Stun bar Settings
			order = 113,
			name = "Stun bar Settings",
			type = "header"
		},
		StunBarShow = {--Show Stun
			order = 114,
			name = "Show Stun bar",
			desc = "Display the Stun timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.StunBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.StunBarShow end
		},
		PosSTUN = {--Stun position
			order = 115,
			name = "Stun bar position",
			desc = "The place where to display the Stun bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosSTUN = val
			end,
			get = function(info) return SliceCmdr_Save.PosSTUN end
		},
		headerBloodSetting = {--Blood Settings
			order = 122,
			name = "Blood bar Settings",
			type = "header"
		},
		RupBarShow = {--Show Blood
			order = 123,
			name = "Show Blood bar",
			desc = "Display the Blood timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.RupBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.RupBarShow end
		},
		PosRUP = {--Blood position
			order = 124,
			name = "Blood bar position",
			desc = "The place where to display the Blood bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosRUP = val
			end,
			get = function(info) return SliceCmdr_Save.PosRUP end
		},
		RupBarMine = {--Show Blood
			order = 125,
			name = "Show Only my blood effect",
			desc = "Only your garrote and rupture will be display. In default all blood effect will be display (not usefull anymore). If you want to show only your blood effect you have to reset the addon configuration.",
			--disabled = true,
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.RupBarMine = val
			end,
			get = function(info) return SliceCmdr_Save.RupBarMine end
		},
		headerSndSetting = {--Slice and Dice Settings
			order = 126,
			name = "Slice and Dice Settings",
			type = "header"
		},
		SnDBarShow = {--Show Slice and Dice
			order = 127,
			name = "Show Slice and Dice bar",
			desc = "Display the Slice and Dice timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.SnDBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.SnDBarShow end
		},
		PosSND = {--Slice and Dice position
			order = 128,
			name = "Slice and Dice bar position",
			desc = "The place where to display the Slice and Dice bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosSND = val
			end,
			get = function(info) return SliceCmdr_Save.PosSND end
		},
		headerCPSetting = {--Combo Point Settings
			order = 129,
			name = "Combo Point bar Settings",
			type = "header"
		},
		CPBarShow = {--Show Combo Point
			order = 130,
			name = "Show Combo Point bar",
			desc = "Display the Combo Point timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.CPBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.CPBarShow end
		},
		PosCP = {--Combo Point position
			order = 131,
			name = "Combo Point bar position",
			desc = "The place where to display the Combo Point bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosCP = val
			end,
			get = function(info) return SliceCmdr_Save.PosCP end
		},
		headerThreatSetting = {--Threat Settings
			order = 132,
			name = "Threat bar Settings",
			type = "header"
		},
		THREATBarShow = {--Show Threat
			order = 133,
			name = "Show Threat bar",
			desc = "Display the Threat timer bar",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.THREATBarShow = val
			end,
			get = function(info) return SliceCmdr_Save.THREATBarShow end
		},
		PosThreat = {--Threat position
			order = 134,
			name = "Threat bar position",
			desc = "The place where to display the Threat bar",
			type = "select",
			values = function()
				returnArray = {}
				for key = -10, 10, 1 do
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.PosThreat = val
			end,
			get = function(info) return SliceCmdr_Save.PosThreat end
		},
		ThreatGroupOnly = {--Show Threat bar only in group
			order = 135,
			name = "Threat bar only in group",
			desc = "Display the Threat bar only if you are in a group or a raid",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_Save.ThreatGroupOnly = val
			end,
			get = function(info) return SliceCmdr_Save.ThreatGroupOnly end
		},
	}
}

SC_OptionsTable = {
	name = "SliceCommander",
	handler = SliceCommander,
	type = "group",
	args = {--SliceCommander
		IsLocked = {--Lock
			order = 1,
			name = "Lock",
			desc = "Disable Right Click to Move",
			type = "toggle",
			set = function(info,val)
				SliceCmdr_LockCkecked(val)
			end,
			get = function(info) return SliceCmdr_Save.IsLocked end
		},
		FullTimer = {--Full timer
			order = 2,
			name = "Full Timer",
			desc = "Make timer full bar duration",
			type = "toggle",
			set = function(info,val) SliceCmdr_Save.FullTimer = val end,
			get = function(info) return SliceCmdr_Save.FullTimer end
		},
		PadLatency = {--Latency
			order = 3,
			name = "Enable Latency",
			desc = "Pad Alerts with Latency",
			type = "toggle",
			set = function(info,val) SliceCmdr_Save.PadLatency = val end,
			get = function(info) return SliceCmdr_Save.PadLatency end
		},
		SpellText = {--Spell text
			order = 4,
			name = "Spell Text",
			desc = "Enable spell text on bars",
			type = "toggle",
			set = function(info,val) SliceCmdr_Save.SpellText = val end,
			get = function(info) return SliceCmdr_Save.SpellText end
		},
		SoundCombat = {--Disable sound out of combat
			order = 5,
			name = "Sound Combat",
			desc = "Disable sounds out of combat",
			type = "toggle",
			set = function(info,val) SliceCmdr_Save.SoundCombat = val end,
			get = function(info) return SliceCmdr_Save.SoundCombat end
		},
		headerDisplaySetting = {--CDisplay Setting
			order = 6,
			name = "Display Setting",
			type = "header"
		},
		BarTexture = {--Texture
			order = 7,
			name = "Bar Texture",
			desc = "Bar Texture for timer and energy",
			type = "select",
			values = function()
				returnArray = {}
				for key, value in pairs(SliceCmdr_BarTextures) do 
					returnArray[key] = key
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_Save.BarTexture = val
				SliceCmdr_Config_RetextureBars()
			end,
			get = function(info) return SliceCmdr_Save.BarTexture end
		},
		Scale = {--Scale
			order = 8,
			name = "Scale",
			desc = "AddOn Scale",
			type = "range",
			min = 50,
			max = 200,
			disabled = true,
			step = 1,
			bigStep = 10,
			set = function(info,val)
				SliceCmdr_Save.Scale = val
				SliceCmdr_SetScale(val)
			end,
			get = function(info) return SliceCmdr_Save.Scale end,
			isPercent = false
		},
		Width = {--Width
			order = 9,
			name = "Width",
			desc = "Bar Width",
			type = "range",
			min = 125,
			max = 300,
			step = 1,
			bigStep = 5,
			set = function(info,val)
				SliceCmdr_Save.Width = val
				SliceCmdr_SetWidth(val)
			end,
			get = function(info) return SliceCmdr_Save.Width end,
			isPercent = false
		},
		EnergyHeight = {--Energy bar height
			order = 10,
			name = "Energy Height",
			desc = "EnergyBar Height",
			type = "range",
			min = 1,
			max = 40,
			step = 1,
			bigStep = 1,
			set = function(info,val)
				SliceCmdr_Save.EnergyHeight = val
				SliceCmdr_SetEnergyHeight(val)
			end,
			get = function(info) return SliceCmdr_Save.EnergyHeight end,
			isPercent = false
		},
		TimerHeight = {--Timer height
			order = 11,
			name = "Timer Height",
			desc = "TimerBar Height",
			type = "range",
			min = 1,
			max = 50,
			step = 1,
			bigStep = 1,
			set = function(info,val)
				SliceCmdr_Save.TimerHeight = val
				SliceCmdr_SetTimerHeight(val)
			end,
			get = function(info) return SliceCmdr_Save.TimerHeight end,
			isPercent = false
		},
		BarMargin = {--Margin
			order = 12,
			name = "Bar Margin",
			desc = "Bar Margin",
			type = "range",
			min = -2,
			max = 10,
			step = 1,
			bigStep = 1,
			set = function(info,val) SliceCmdr_Save.BarMargin = val end,
			get = function(info) return SliceCmdr_Save.BarMargin end,
			isPercent = false
		},
		headerCheckHealth = {--Check health header
			order = 13,
			name = "Enable 35% backstab warning",
			type = "header"
		},
		checkHealthSpec1 = {--Check health spec1
			order = 14,
			name = "Spec 1",
			desc = "Check health for Spec 1",
			type = "toggle",
			set = function(info,val) SliceCmdr_Save.checkHealthSpec1 = val end,
			get = function(info) return SliceCmdr_Save.checkHealthSpec1 end
		},
		checkHealthSpec2 = {--Check health spec2
			order = 15,
			name = "Spec 2",
			desc = "Check health for Spec 2",
			type = "toggle",
			set = function(info,val) SliceCmdr_Save.checkHealthSpec2 = val end,
			get = function(info) return SliceCmdr_Save.checkHealthSpec2 end
		},
		HealthUnder = {--Texture
			order = 16,
			name = "Sound under 35% health",
			desc = "The sound play when the health reach 35% health",
			type = "select",
			values = function()
				returnArray = {}
				for ignore, SoundName in pairs(SliceCmdr_SoundMenu['All']) do   
					returnArray[SoundName] = SoundName
				end
				return returnArray
			end,
			set = function(info,val)
				SliceCmdr_SoundTest(val)
				SliceCmdr_Save.HealthUnder = val
			end,
			get = function(info)
				return SliceCmdr_Save.HealthUnder
			end
		},		
	}
}

function SliceCmdr_Config_OtherVars()
	local p1 = SliceCmdr_Save.Energy1 / UnitManaMax("player") * SliceCmdr_Save.Width
	local p2 = SliceCmdr_Save.Energy2 / UnitManaMax("player") * SliceCmdr_Save.Width
	local p3 = SliceCmdr_Save.Energy3 / UnitManaMax("player") * SliceCmdr_Save.Width
	
	SliceCmdr_Spark1:SetPoint("TOPLEFT", VTimerEnergy, "TOPLEFT", p1, 0)
	SliceCmdr_Spark2:SetPoint("TOPLEFT", VTimerEnergy, "TOPLEFT", p2, 0)
	SliceCmdr_Spark3:SetPoint("TOPLEFT", VTimerEnergy, "TOPLEFT", p3, 0)
end

function SliceCmdr_LockCkecked(checked)
	if (checked) then
		--SliceCmdr:SetMovable(false)
		VTimerEnergy:SetAlpha(SliceCmdr_Save.EnergyTrans / 100.0)
		SliceCmdr:SetBackdropColor(0.7,0.2,0.2,0)
		SliceCmdr:EnableMouse(false)
		SliceCmdr_Save.IsLocked = true
	else
		--SliceCmdr:SetMovable(true)
		VTimerEnergy:SetAlpha(1)
		SliceCmdr:SetBackdropColor(0.7,0.2,0.2,0.5)
		SliceCmdr:EnableMouse(true)
		SliceCmdr_Save.IsLocked = false
	end	
end

function SliceCmdr_Config_RetextureBars()
	local texture = SliceCmdr_BarTexture()
	
	VTimerEnergy:SetStatusBarTexture(texture)
	SLICECMDR.BARS['Rup']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['DP']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['ToT']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['REC']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['EA']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['SnD']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['VEN']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['MH']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['OH']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['STUN']['obj']:SetStatusBarTexture(texture)
	SLICECMDR.BARS['THREAT']['obj']:SetStatusBarTexture(texture)
	
	for i = 1, 5 do
		SLICECMDR.BARS['CP']['obj'].combos[i].bg:SetTexture(texture)
	end		
	
end

function SliceCmdr_SetScale(NewScale) 
	if (NewScale >= 50) then
		SliceCmdr:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['VEN']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['Rup']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['CP']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['DP']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['SnD']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['STUN']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['MH']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['OH']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['ToT']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['EA']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['REC']['obj']:SetScale ( NewScale / 100 )
		SLICECMDR.BARS['THREAT']['obj']:SetScale ( NewScale / 100 )
	end
end

function SliceCmdr_SetWidth(w) 
	if (w >= 25) then
		VTimerEnergy:SetWidth( w )
		SLICECMDR.BARS['VEN']['obj']:SetWidth(w)
		SLICECMDR.BARS['CP']['obj']:SetWidth(w)
		cx = 0
		width = ((w-(2*4))/5)
		for i = 1, 5 do
			SLICECMDR.BARS['CP']['obj'].combos[i]:ClearAllPoints()
			SLICECMDR.BARS['CP']['obj'].combos[i]:SetPoint("TOPLEFT", SLICECMDR.BARS['CP']['obj'], "TOPLEFT", cx, 0)
			SLICECMDR.BARS['CP']['obj'].combos[i]:SetPoint("BOTTOMRIGHT", SLICECMDR.BARS['CP']['obj'], "BOTTOMLEFT", cx + width , 0)
			cx = cx + width + 2
		end
		SLICECMDR.BARS['Rup']['obj']:SetWidth(w)
		SLICECMDR.BARS['DP']['obj']:SetWidth(w)
		SLICECMDR.BARS['SnD']['obj']:SetWidth(w)
		SLICECMDR.BARS['STUN']['obj']:SetWidth(w)
		SLICECMDR.BARS['MH']['obj']:SetWidth(w)
		SLICECMDR.BARS['OH']['obj']:SetWidth(w)
		SLICECMDR.BARS['ToT']['obj']:SetWidth(w)
		SLICECMDR.BARS['EA']['obj']:SetWidth(w)
		SLICECMDR.BARS['REC']['obj']:SetWidth(w)
		SLICECMDR.BARS['THREAT']['obj']:SetWidth(w)
		SliceCmdr_Spark1:SetPoint("TOPLEFT", VTimerEnergy, "TOPLEFT", (SliceCmdr_Save.Energy1 / UnitManaMax("player") * w), 0)
		SliceCmdr_Spark2:SetPoint("TOPLEFT", VTimerEnergy, "TOPLEFT", (SliceCmdr_Save.Energy2 / UnitManaMax("player") * w), 0)
		SliceCmdr_Spark3:SetPoint("TOPLEFT", VTimerEnergy, "TOPLEFT", (SliceCmdr_Save.Energy3 / UnitManaMax("player") * w), 0)
	end
end

function SliceCmdr_SetEnergyHeight(w) 
	if (w >= 1) then
		SliceCmdr:SetWidth( w )
		SliceCmdr:SetHeight( w )
		VTimerEnergy:SetHeight( w )
		VTimerEnergyTxt:SetHeight( w )
		SliceCmdr_Combo:SetHeight( w )
		SliceCmdr_Spark1:SetHeight( w )
		SliceCmdr_Spark2:SetHeight( w )
		SliceCmdr_Spark3:SetHeight( w )
	end
end

function SliceCmdr_SetTimerHeight(w) 
	if (w >= 1) then
		SLICECMDR.BARS['VEN']['obj']:SetHeight( w )
		SLICECMDR.BARS['VEN']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['VEN']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['VEN']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['VEN']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['VEN']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['VEN']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['VEN']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['VEN']['obj'], "TOPLEFT", SLICECMDR.BARS['VEN']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['Rup']['obj']:SetHeight( w )
		SLICECMDR.BARS['Rup']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['Rup']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['Rup']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['Rup']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['Rup']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['Rup']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['Rup']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['Rup']['obj'], "TOPLEFT", SLICECMDR.BARS['Rup']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['DP']['obj']:SetHeight( w )
		SLICECMDR.BARS['DP']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['DP']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['DP']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['DP']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['DP']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['DP']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['DP']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['DP']['obj'], "TOPLEFT", SLICECMDR.BARS['DP']['obj'].icon:GetHeight(), 0)
			
		SLICECMDR.BARS['SnD']['obj']:SetHeight( w )
		SLICECMDR.BARS['SnD']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['SnD']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['SnD']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['SnD']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['SnD']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['SnD']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['SnD']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['SnD']['obj'], "TOPLEFT", SLICECMDR.BARS['SnD']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['CP']['obj']:SetHeight( w )
		SLICECMDR.BARS['CP']['obj'].comboText:SetHeight( w )
		for i = 1, 5 do
			SLICECMDR.BARS['CP']['obj'].combos[i]:SetHeight(w-2)
		end
		
		SLICECMDR.BARS['STUN']['obj']:SetHeight( w )
		SLICECMDR.BARS['STUN']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['STUN']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['STUN']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['STUN']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['STUN']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['STUN']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['STUN']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['STUN']['obj'], "TOPLEFT", SLICECMDR.BARS['STUN']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['ToT']['obj']:SetHeight( w )
		SLICECMDR.BARS['ToT']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['ToT']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['ToT']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['ToT']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['ToT']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['ToT']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['ToT']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['ToT']['obj'], "TOPLEFT", SLICECMDR.BARS['ToT']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['EA']['obj']:SetHeight( w )
		SLICECMDR.BARS['EA']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['EA']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['EA']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['EA']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['EA']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['EA']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['EA']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['EA']['obj'], "TOPLEFT", SLICECMDR.BARS['EA']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['REC']['obj']:SetHeight( w )
		SLICECMDR.BARS['REC']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['REC']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['REC']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['REC']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['REC']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['REC']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['REC']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['REC']['obj'], "TOPLEFT", SLICECMDR.BARS['REC']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BARS['THREAT']['obj']:SetHeight( w )
		SLICECMDR.BARS['THREAT']['obj'].text:SetHeight( w )
		SLICECMDR.BARS['THREAT']['obj'].text2:SetHeight( w )
		SLICECMDR.BARS['THREAT']['obj'].textIcon:SetHeight( w+2 )
		SLICECMDR.BARS['THREAT']['obj'].textIcon:SetWidth( w+2 )
		SLICECMDR.BARS['THREAT']['obj'].icon:SetHeight( w )
		SLICECMDR.BARS['THREAT']['obj'].icon:SetWidth( w )
		SLICECMDR.BARS['THREAT']['obj'].text2:SetPoint("TOPLEFT", SLICECMDR.BARS['THREAT']['obj'], "TOPLEFT", SLICECMDR.BARS['THREAT']['obj'].icon:GetHeight(), 0)
		
		SLICECMDR.BarFont2:SetFont("Fonts\\FRIZQT__.TTF", w-2)
		SLICECMDR.BarFont4:SetFont("Fonts\\FRIZQT__.TTF", w-2)
	end
end

SLICECMDR.BARS = { 
	['THREAT'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['STUN'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['CP'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['VEN'] = {
		['obj'] = 0,
		['expire'] = 0,
		['cd'] = 0
	},
	['ToT'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['EA'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['SnD'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['DP'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['REC'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['Rup'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['MH'] = {
		['obj'] = 0,
		['expire'] = 0
	},
	['OH'] = {
		['obj'] = 0,
		['expire'] = 0
	},
}

function SliceCmdr_MoveStart()
	if (SliceCmdr_Save.IsLocked == false) then
		SliceCmdr:StartMoving()
	 end
end

function SliceCmdr_MoveStop()
	if (SliceCmdr_Save.IsLocked == false) then
		SliceCmdr:StopMovingOrSizing()
	end		
end

function SliceCmdr_BarTexture() 
	if (SliceCmdr_Save.BarTexture) then
		return SliceCmdr_BarTextures[SliceCmdr_Save.BarTexture]
	else
		return "Interface\\AddOns\\SliceCommander\\Images\\Smooth.tga"
	end
	
end

function SliceCmdr_SoundTest(name) 
	if (SliceCmdr_Sounds[name] and SliceCmdr_Sounds[name] ~= "" and SliceCmdr_Sounds[name] ~= nil ) then
		if nextStop == 0 then
			soundStatus = GetCVar('Sound_EnableSFX')
		end
		SetCVar('Sound_EnableSFX','1',true)
		nextStop = nextStop + 1
		PlaySoundFile( SliceCmdr_Sounds[name] )
		self:ScheduleTimer('SetCVarFunction', SliceCmdr_Timer[name], soundStatus)
	end
end

function SliceCmdr_Sound(saved) 
	if isCombat()==1 then
		if (SliceCmdr_Save[saved]) then
			if(SliceCmdr_Sounds[ SliceCmdr_Save[saved] ] ~= "" and SliceCmdr_Sounds[ SliceCmdr_Save[saved] ] ~= nil) then
				if nextStop == 0 then
					soundStatus = GetCVar('Sound_EnableSFX')
				end
				SetCVar('Sound_EnableSFX','1',true)
				nextStop = nextStop + 1
				PlaySoundFile( SliceCmdr_Sounds[ SliceCmdr_Save[saved] ] )
				self:ScheduleTimer('SetCVarFunction', SliceCmdr_Timer[SliceCmdr_Save[saved]], soundStatus)
			end
		end
	end
end

function SliceCommander:SetCVarFunction(arg1)
	nextStop = nextStop -1
	if nextStop <= 0 then
		SetCVar('Sound_EnableSFX',arg1,true)
	end
end

function SliceCmdr_ChangeAnchor()
	local offSetSize = SliceCmdr_Save.BarMargin -- other good values, -1, -2
	if type(offSetSize) == "string" then
		offSetSize = 3
	end
	
	if SliceCmdr_Save.PosSTUN == nil
		or SliceCmdr_Save.PosCP == nil
		or SliceCmdr_Save.PosThreat == nil
		or SliceCmdr_Save.PosREC == nil
		or SliceCmdr_Save.PosSND == nil
		or SliceCmdr_Save.PosRUP == nil
		or SliceCmdr_Save.PosTOT == nil
		or SliceCmdr_Save.PosVEN == nil
		or SliceCmdr_Save.PosDP == nil
		or SliceCmdr_Save.PosEA == nil then
		SliceCmdr_Save.PosCP = -1
		SliceCmdr_Save.PosThreat = -2
		SliceCmdr_Save.PosSTUN = -3
		SliceCmdr_Save.PosREC = 1
		SliceCmdr_Save.PosSND = 2
		SliceCmdr_Save.PosRUP = 3
		SliceCmdr_Save.PosTOT = 4
		SliceCmdr_Save.PosVEN = 5
		SliceCmdr_Save.PosDP = 6
		SliceCmdr_Save.PosEA = 7
	end
	
	LastAnchorNeg = VTimerEnergy
	AnchorFromNeg = "BOTTOMLEFT"
	AnchorToNeg = "TOPLEFT"
	LastAnchorPos = VTimerEnergy
	AnchorFromPos = "TOPLEFT"
	AnchorToPos = "BOTTOMLEFT"
	for i = 1, 10 do
		--under
		if SliceCmdr_Save.PosSTUN == i and SLICECMDR.BARS['STUN']['expire'] ~= 0 then
			SLICECMDR.BARS['STUN']['obj']:ClearAllPoints()
			SLICECMDR.BARS['STUN']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['STUN']['obj']
		end
		if SliceCmdr_Save.PosCP == i and SLICECMDR.BARS['CP']['expire'] ~= 0 then
			SLICECMDR.BARS['CP']['obj']:ClearAllPoints()
			SLICECMDR.BARS['CP']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['CP']['obj']
		end
		if SliceCmdr_Save.PosREC == i and SLICECMDR.BARS['REC']['expire'] ~= 0 then
			SLICECMDR.BARS['REC']['obj']:ClearAllPoints()
			SLICECMDR.BARS['REC']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['REC']['obj']
		end
		if SliceCmdr_Save.PosSND == i and SLICECMDR.BARS['SnD']['expire'] ~= 0 then
			SLICECMDR.BARS['SnD']['obj']:ClearAllPoints()
			SLICECMDR.BARS['SnD']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['SnD']['obj']
		end
		if SliceCmdr_Save.PosRUP == i and SLICECMDR.BARS['Rup']['expire'] ~= 0 then
			SLICECMDR.BARS['Rup']['obj']:ClearAllPoints()
			SLICECMDR.BARS['Rup']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['Rup']['obj']
		end
		if SliceCmdr_Save.PosTOT == i and SLICECMDR.BARS['ToT']['expire'] ~= 0 then
			SLICECMDR.BARS['ToT']['obj']:ClearAllPoints()
			SLICECMDR.BARS['ToT']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['ToT']['obj']
		end
		if SliceCmdr_Save.PosVEN == i and ( SLICECMDR.BARS['VEN']['expire'] ~= 0 or SLICECMDR.BARS['VEN']['cd'] ~= 0 ) then
			SLICECMDR.BARS['VEN']['obj']:ClearAllPoints()
			SLICECMDR.BARS['VEN']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['VEN']['obj']
		end
		if SliceCmdr_Save.PosDP == i and SLICECMDR.BARS['DP']['expire'] ~= 0 then
			SLICECMDR.BARS['DP']['obj']:ClearAllPoints()
			SLICECMDR.BARS['DP']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['DP']['obj']
		end
		if SliceCmdr_Save.PosEA == i and SLICECMDR.BARS['EA']['expire'] ~= 0 then
			SLICECMDR.BARS['EA']['obj']:ClearAllPoints()
			SLICECMDR.BARS['EA']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['EA']['obj']
		end
		if SliceCmdr_Save.PosThreat == i and SLICECMDR.BARS['THREAT']['expire'] ~= 0 then
			SLICECMDR.BARS['THREAT']['obj']:ClearAllPoints()
			SLICECMDR.BARS['THREAT']['obj']:SetPoint(AnchorFromPos, LastAnchorPos, AnchorToPos, 0, offSetSize*-1)
			LastAnchorPos = SLICECMDR.BARS['THREAT']['obj']
		end
		
		--on top
		if SliceCmdr_Save.PosSTUN == i*-1 and SLICECMDR.BARS['STUN']['expire'] ~= 0 then
			SLICECMDR.BARS['STUN']['obj']:ClearAllPoints()
			SLICECMDR.BARS['STUN']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['STUN']['obj']
		end
		if SliceCmdr_Save.PosCP == i*-1 and SLICECMDR.BARS['CP']['expire'] ~= 0 then
			SLICECMDR.BARS['CP']['obj']:ClearAllPoints()
			SLICECMDR.BARS['CP']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['CP']['obj']
		end
		if SliceCmdr_Save.PosREC == i*-1 and SLICECMDR.BARS['REC']['expire'] ~= 0 then
			SLICECMDR.BARS['REC']['obj']:ClearAllPoints()
			SLICECMDR.BARS['REC']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['REC']['obj']
		end
		if SliceCmdr_Save.PosSND == i*-1 and SLICECMDR.BARS['SnD']['expire'] ~= 0 then
			SLICECMDR.BARS['SnD']['obj']:ClearAllPoints()
			SLICECMDR.BARS['SnD']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['SnD']['obj']
		end
		if SliceCmdr_Save.PosRUP == i*-1 and SLICECMDR.BARS['Rup']['expire'] ~= 0 then
			SLICECMDR.BARS['Rup']['obj']:ClearAllPoints()
			SLICECMDR.BARS['Rup']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['Rup']['obj']
		end
		if SliceCmdr_Save.PosTOT == i*-1 and SLICECMDR.BARS['ToT']['expire'] ~= 0 then
			SLICECMDR.BARS['ToT']['obj']:ClearAllPoints()
			SLICECMDR.BARS['ToT']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['ToT']['obj']
		end
		if SliceCmdr_Save.PosVEN == i*-1 and ( SLICECMDR.BARS['VEN']['expire'] ~= 0 or SLICECMDR.BARS['VEN']['cd'] ~= 0 ) then
			SLICECMDR.BARS['VEN']['obj']:ClearAllPoints()
			SLICECMDR.BARS['VEN']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['VEN']['obj']
		end
		if SliceCmdr_Save.PosDP == i*-1 and SLICECMDR.BARS['DP']['expire'] ~= 0 then
			SLICECMDR.BARS['DP']['obj']:ClearAllPoints()
			SLICECMDR.BARS['DP']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['DP']['obj']
		end
		if SliceCmdr_Save.PosEA == i*-1 and SLICECMDR.BARS['EA']['expire'] ~= 0 then
			SLICECMDR.BARS['EA']['obj']:ClearAllPoints()
			SLICECMDR.BARS['EA']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['EA']['obj']
		end
		if SliceCmdr_Save.PosThreat == i*-1 and SLICECMDR.BARS['THREAT']['expire'] ~= 0 then
			SLICECMDR.BARS['THREAT']['obj']:ClearAllPoints()
			SLICECMDR.BARS['THREAT']['obj']:SetPoint(AnchorFromNeg, LastAnchorNeg, AnchorToNeg, 0, offSetSize)
			LastAnchorNeg = SLICECMDR.BARS['THREAT']['obj']
		end
	end
end

function isCombat()
	if SliceCmdr_Save.SoundCombat==true then
		if UnitAffectingCombat("player")==1 then
			return 1
		else
			return 0
		end
	else
		return 1
	end
end
localSelf = ""
function SliceCmdr_OnEvent(self, event, ...)
	if localSelf == "" then
		localSelf = self
	end
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local timestamp, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
		if (type == "SPELL_AURA_REFRESH" or type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_REMOVED" or type == "SPELL_AURA_APPLIED_DOSE" or type == "SPELL_PERIODIC_AURA_REMOVED" or type == "SPELL_PERIODIC_AURA_APPLIED" or type == "SPELL_PERIODIC_AURA_APPLIED_DOSE" or type == "SPELL_PERIODIC_AURA_REFRESH") then
			local spellId, spellName, spellSchool = select(9, ...)
			
			if (destGUID == UnitGUID("player")) then
				-- SLICE AND DICE EVENT --
				if (spellId == 5171 and SliceCmdr_Save.SnDBarShow == true) then
					if (type == "SPELL_AURA_REMOVED" ) then
						if (UnitAffectingCombat("player")) then
							SliceCmdr_Sound("Fail")
						else
							SliceCmdr_Sound("Expire")
						end					
						SLICECMDR.BARS['SnD']['expire'] = 0
						SliceCmdr_ChangeAnchor()
						SLICECMDR.BARS['SnD']['obj']:Hide()
					else
						if( type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_APPLIED_DOSE" or type == "SPELL_AURA_REFRESH" ) then
							local name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", SC_SPELL_SND)
							local timeLeftOnLast = SLICECMDR.BARS['SnD']['expire'] - GetTime()
							SLICECMDR.BARS['SnD']['obj']:Show()
							if SliceCmdr_Save.FullTimer == true then
								SLICECMDR.BARS['SnD']['obj']:SetMinMaxValues(0, duration)
							else
								SLICECMDR.BARS['SnD']['obj']:SetMinMaxValues(0, 6.0)
							end
							SLICECMDR.BARS['SnD']['obj'].icon:SetTexture(icon)
							if SliceCmdr_Save.SpellText == true then
								SLICECMDR.BARS['SnD']['obj'].text2:SetText(string.format("%s", name))
							else
								SLICECMDR.BARS['SnD']['obj'].text2:SetText("")
							end
							SLICECMDR.BARS['SnD']['expire'] = expirationTime
							SliceCmdr_ChangeAnchor()--change les ancres des bares
							if (type == "SPELL_AURA_APPLIED") then
								SliceCmdr_Sound("Applied")
							else
								if (timeLeftOnLast <= 1) then
									SliceCmdr_Sound("Apply1")
								else
									if (timeLeftOnLast <= 2) then
										SliceCmdr_Sound("Apply2")
									else
										SliceCmdr_Sound("Apply3")
									end
								end
							end
						end
					end
				end	
				-- ENVENOM --
				if (spellName == SC_SPELL_ENV and SliceCmdr_Save.DPBarShow == true and SliceCmdr_Save.EnvenomShow == true) then
					local name1, rank1, icon1, count1, debuffType1, duration1, expirationTime1, isMine1, isStealable1 = UnitAura("player", spellName)
					if (type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_APPLIED_DOSE" or type == "SPELL_AURA_REFRESH") then
						SLICECMDR.BARS['DP']['expire'] = expirationTime1
						SLICECMDR.BARS['DP']['obj']:Show()
						if SliceCmdr_Save.FullTimer == true then
							SLICECMDR.BARS['DP']['obj']:SetMinMaxValues(0, duration1)
						else
							SLICECMDR.BARS['DP']['obj']:SetMinMaxValues(0, 6.0)
						end
						SLICECMDR.BARS['DP']['obj'].icon:SetTexture(icon1)
						if SliceCmdr_Save.SpellText == true then
							SLICECMDR.BARS['DP']['obj'].text2:SetText( string.format("%s", name1) )
						else
							SLICECMDR.BARS['DP']['obj'].text2:SetText("")
						end
						SliceCmdr_ChangeAnchor()--change les ancres
					end
				end
				-- RECUPERATE --
				if (spellName == SC_SPELL_REC and SliceCmdr_Save.RECBarShow == true) then
					local name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", spellName)
					if (type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_APPLIED_DOSE" or type == "SPELL_AURA_REFRESH") then
						SLICECMDR.BARS['REC']['expire'] = expirationTime
						SLICECMDR.BARS['REC']['obj']:Show()
						if SliceCmdr_Save.FullTimer == true then
							SLICECMDR.BARS['REC']['obj']:SetMinMaxValues(0, duration)
						else
							SLICECMDR.BARS['REC']['obj']:SetMinMaxValues(0, 6.0)
						end
						SLICECMDR.BARS['REC']['obj'].icon:SetTexture(icon)
						if SliceCmdr_Save.SpellText == true then
							SLICECMDR.BARS['REC']['obj'].text2:SetText( string.format("%s", name) )
						else
							SLICECMDR.BARS['REC']['obj'].text2:SetText("")
						end
						SliceCmdr_ChangeAnchor()--change les ancres
					end
				end
			else
				if (destGUID == UnitGUID("target")) then	
					-- VENDETTA EVENT --
					if (spellName == SC_SPELL_VEN and SliceCmdr_Save.VenBarShow == true) then
						local name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitDebuff("target", SC_SPELL_VEN)
						if (isMine == "player") then
							if (type == "SPELL_AURA_REMOVED") then
								SLICECMDR.BARS['VEN']['exspire'] = 0
							else
								SLICECMDR.BARS['VEN']['obj']:SetStatusBarColor(110/255, 34/255, 45/255)
								SLICECMDR.BARS['VEN']['expire'] = expirationTime
								SLICECMDR.BARS['VEN']['obj'].icon:SetTexture(icon)
								if SliceCmdr_Save.SpellText == true then
									SLICECMDR.BARS['VEN']['obj'].text2:SetText(string.format("%s", name))
								else
									SLICECMDR.BARS['VEN']['obj'].text2:SetText("")
								end
								SLICECMDR.BARS['VEN']['obj']:Show()
								if SliceCmdr_Save.FullTimer == true then
									SLICECMDR.BARS['VEN']['obj']:SetMinMaxValues(0, duration)
								else
									SLICECMDR.BARS['VEN']['obj']:SetMinMaxValues(0, 6.0)
								end
								SliceCmdr_ChangeAnchor()--change les ancres
							end
						end
					end
					-- DEADLY POISON --
					if (spellName == SC_SPELL_DP and SliceCmdr_Save.DPBarShow == true) then
						local name1, rank1, icon1, count1, debuffType1, duration1, expirationTime1, isMine1, isStealable1 = UnitDebuff("target", SC_SPELL_DP)
						if (type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_APPLIED_DOSE" or type == "SPELL_AURA_REFRESH") then
							if (isMine1 == "player") then
								SLICECMDR.BARS['CP']['obj'].combos[count1].bg:SetVertexColor(64/255, 167/255, 64/255)
								if( SliceCmdr_Save.EnvenomShow == false )then
									SLICECMDR.BARS['DP']['expire'] = expirationTime1
									SLICECMDR.BARS['DP']['obj'].textIcon:SetText(string.format("%i", count1))
									SLICECMDR.BARS['DP']['obj']:Show()
									if SliceCmdr_Save.FullTimer == true then
										SLICECMDR.BARS['DP']['obj']:SetMinMaxValues(0, duration1)
									else
										SLICECMDR.BARS['DP']['obj']:SetMinMaxValues(0, 6.0)
									end
									SLICECMDR.BARS['DP']['obj'].icon:SetTexture(icon1)
									if SliceCmdr_Save.SpellText == true then
										SLICECMDR.BARS['DP']['obj'].text2:SetText( string.format("%s", name1) )
									else
										SLICECMDR.BARS['DP']['obj'].text2:SetText("")
									end
									SliceCmdr_ChangeAnchor()--change les ancres
								end
							end
						end
					end
					-- EXPOSE ARMOR --
					if ( (spellId == 8647 or spellName == SC_SPELL_SA or spellName == SC_SPELL_FF) and SliceCmdr_Save.EABarShow == true) then
						local name1, rank1, icon1, count1, debuffType1, duration1, expirationTime1, isMine1, isStealable1 = UnitDebuff("target", spellName)
						if ( type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_APPLIED_DOSE" or type == "SPELL_AURA_REFRESH" ) then
							if ( spellName == SC_SPELL_SA or spellName == SC_SPELL_FF ) then
								if count1 ~= nil then
									SLICECMDR.BARS['EA']['obj'].textIcon:SetText(string.format("%i", count1))
								else
									SLICECMDR.BARS['EA']['obj'].textIcon:SetText("1")
								end
							else
								SLICECMDR.BARS['EA']['obj'].textIcon:SetText("")
							end
							SLICECMDR.BARS['EA']['obj'].icon:SetTexture(icon1)
							SLICECMDR.BARS['EA']['expire'] = expirationTime1
							if SliceCmdr_Save.SpellText == true then
								SLICECMDR.BARS['EA']['obj'].text2:SetText(string.format("%s",  name1))
							else
								SLICECMDR.BARS['EA']['obj'].text2:SetText("")
							end
							SLICECMDR.BARS['EA']['obj']:Show()
							if SliceCmdr_Save.FullTimer == true then
								SLICECMDR.BARS['EA']['obj']:SetMinMaxValues(0, duration1)
							else
								SLICECMDR.BARS['EA']['obj']:SetMinMaxValues(0, 6.0)
							end
							SliceCmdr_ChangeAnchor()--change les ancres
						end
					end
					-- STUN --
					if ( (spellId == 408 or spellId == 1833 ) and SliceCmdr_Save.StunBarShow == true) then
						local name1, rank1, icon1, count1, debuffType1, duration1, expirationTime1, isMine1, isStealable1 = UnitDebuff("target", spellName)
						if isMine1 == "player" then
							if ( type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_REFRESH" ) then
								SLICECMDR.BARS['STUN']['obj'].icon:SetTexture(icon1)
								SLICECMDR.BARS['STUN']['expire'] = expirationTime1
								if SliceCmdr_Save.SpellText == true then
									SLICECMDR.BARS['STUN']['obj'].text2:SetText(string.format("%s",  name1))
								else
									SLICECMDR.BARS['STUN']['obj'].text2:SetText("")
								end
								SLICECMDR.BARS['STUN']['obj']:Show()
								if SliceCmdr_Save.FullTimer == true then
									SLICECMDR.BARS['STUN']['obj']:SetMinMaxValues(0, duration1)
								else
									SLICECMDR.BARS['STUN']['obj']:SetMinMaxValues(0, 6.0)
								end
								SliceCmdr_ChangeAnchor()
							end
						end
					end
					-- Bleed Effect --
					-- My rupture only --
					if ( SliceCmdr_Save.RupBarMine == true and SliceCmdr_Save.RupBarShow == true and (spellName == SC_SPELL_RUP or spellName == SC_SPELL_GAR) and sourceGUID == UnitGUID("player")) then
						if (type == "SPELL_AURA_REMOVED") then
							if UnitAffectingCombat("player") and spellName == SC_SPELL_RUP then
									SliceCmdr_Sound("RUP_Fail")
								else
									SliceCmdr_Sound("RUP_Expire")
							end
						else
							local name2, rank2, icon2, count2, debuffType2, duration2, expirationTime2, isMine2, isStealable2 = UnitDebuff("target", SC_SPELL_RUP)
							if name2 == nil then
								name2, rank2, icon2, count2, debuffType2, duration2, expirationTime2, isMine2, isStealable2 = UnitDebuff("target", SC_SPELL_GAR)
							end
							if (isMine2 == "player") then
								if (type == "SPELL_AURA_APPLIED") then
									SliceCmdr_Sound('RUP_Applied')
								else
									local timeLeftOnLast = SLICECMDR.BARS['Rup']['expire'] - GetTime()
									if (timeLeftOnLast <= 1) then
										SliceCmdr_Sound('RUP_Refresh1')
									else
										if (timeLeftOnLast <= 2) then
											SliceCmdr_Sound('RUP_Refresh2')
										else
											SliceCmdr_Sound('RUP_Refresh3')
										end
									end							
								end
								SLICECMDR.BARS['Rup']['expire'] = expirationTime2
								SLICECMDR.BARS['Rup']['Expires'] = expirationTime2
								SLICECMDR.BARS['Rup']['obj'].icon:SetTexture(icon2)
								SLICECMDR.BARS['Rup']['obj']:Show()
								if SliceCmdr_Save.FullTimer == true then
									SLICECMDR.BARS['Rup']['obj']:SetMinMaxValues(0, duration2)
								else
									SLICECMDR.BARS['Rup']['obj']:SetMinMaxValues(0, 6.0)
								end
								if SliceCmdr_Save.SpellText == true then
									SLICECMDR.BARS['Rup']['obj'].text2:SetText(string.format("%s", name2))
								else
									SLICECMDR.BARS['Rup']['obj'].text2:SetText("")
								end
								SliceCmdr_ChangeAnchor()
							end
						end
					end
					-- All bleed effect --
					if (  SliceCmdr_Save.RupBarMine == false and SliceCmdr_Save.RupBarShow == true and (type == "SPELL_AURA_APPLIED" or type == "SPELL_AURA_REFRESH") ) then
						if ( spellName == SC_SPELL_RUP or spellName == SC_SPELL_GAR  or spellName == SC_SPELL_DRUIDE_LAC  or spellName == SC_SPELL_DRUIDE_POU  or spellName == SC_SPELL_DRUIDE_RIP  or spellName == SC_SPELL_DRUIDE_RAK or spellName == SC_SPELL_WARRIOR_DWO or spellName == SC_SPELL_WARRIOR_REN or spellName == SC_SPELL_HUNTER_PSH ) then
							local name2, rank2, icon2, count2, debuffType2, duration2, expirationTime2, isMine2, isStealable2 = UnitDebuff("target", spellName)
							if expirationTime2 ~= nil then
								if ( expirationTime2 > SLICECMDR.BARS['Rup']['expire'] )then
									SLICECMDR.currnetBloodCaster = isMine2
									SLICECMDR.currnetBloodSpell = name2
									SLICECMDR.BARS['Rup']['obj'].icon:SetTexture(icon2)
									SLICECMDR.BARS['Rup']['expire'] = expirationTime2
									SLICECMDR.BARS['Rup']['obj']:Show()
									if SliceCmdr_Save.FullTimer == true then
										SLICECMDR.BARS['Rup']['obj']:SetMinMaxValues(0, duration2)
									else
										SLICECMDR.BARS['Rup']['obj']:SetMinMaxValues(0, 6.0)
									end
									if SliceCmdr_Save.SpellText == true then
										SLICECMDR.BARS['Rup']['obj'].text2:SetText(string.format("%s", name2))
									else
										SLICECMDR.BARS['Rup']['obj'].text2:SetText("")
									end
									SliceCmdr_ChangeAnchor()
								end
							end
						end
					end
				end
			end	
		end
	end
	
	if (event == "UNIT_COMBO_POINTS") then
		local unit = select(1, ...)
		nameUID = UnitGUID("target")
		if (unit and unit == "player") then
			local name1, rank1, icon1, count1, debuffType1, duration1, expirationTime1, isMine1, isStealable1 = UnitDebuff("target", SC_SPELL_DP)
			if not name1 then
				SLICECMDR.BARS['DP']['expire'] = 0
				if( SliceCmdr_Save.EnvenomShow == false )then
					SLICECMDR.BARS['DP']['obj']:Hide()
				end
			end
			curComboTarget = nameUID
			SliceCmdr_SetComboPts()
			SliceCmdr_ChangeAnchor()
		end
	end
	if (event == "PLAYER_TARGET_CHANGED") then
		SliceCmdr_SetComboPts()
		SliceCmdr_TestTarget()
	end
end

function SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
	if name then
		if name2 then
			if expirationTime2 > expirationTime then
				expirationTime = expirationTime2
				name = name2
			end
		end
	else
		if name2 then
			expirationTime = expirationTime2
			name = name2
		end
	end
	
	return name, expirationTime
end

function SliceCmdr_TestTarget()
	local name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitDebuff("target", SC_SPELL_DP)
	if (SliceCmdr_Save.DPBarShow == true and SliceCmdr_Save.EnvenomShow == false) then
		if not name then
			SLICECMDR.BARS['DP']['expire'] = 0
			SLICECMDR.BARS['DP']['obj']:Hide()
		else
			if (isMine == "player") then
				SLICECMDR.BARS['DP']['expire'] = expirationTime
 				SLICECMDR.BARS['DP']['obj'].text:SetText(expirationTime)
				SLICECMDR.BARS['DP']['obj'].textIcon:SetText(string.format("%i", count))
				if SliceCmdr_Save.SpellText == true then
					SLICECMDR.BARS['DP']['obj'].text2:SetText(string.format("%s", name))
				else
					SLICECMDR.BARS['DP']['obj'].text2:SetText("")
				end
				SLICECMDR.BARS['DP']['obj']:Show()
				if SliceCmdr_Save.FullTimer == true then
					SLICECMDR.BARS['DP']['obj']:SetMinMaxValues(0, duration)
				else
					SLICECMDR.BARS['DP']['obj']:SetMinMaxValues(0, 6.0)
				end
			else
				SLICECMDR.BARS['DP']['expire'] = 0
				SLICECMDR.BARS['DP']['obj']:Hide()
			end
		end
	end
	
	if ( SliceCmdr_Save.RupBarShow == true and SliceCmdr_Save.RupBarMine == false ) then
		name, _, _, _, _, _, expirationTime = UnitDebuff("target", SC_SPELL_RUP)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_GAR)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_GAR)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_DRUIDE_LAC)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_DRUIDE_POU)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_DRUIDE_RIP)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_DRUIDE_RAK)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_WARRIOR_DWO)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_WARRIOR_REN)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		name2, _, _, _, _, _, expirationTime2 = UnitDebuff("target", SC_SPELL_HUNTER_PSH)
		name, expirationTime = SliceCmdr_TestTargetBleed(name, name2, expirationTime, expirationTime2)
		
		if( name )then
			_, _, icon, _, _, _, _ = UnitDebuff("target", name)
		end
		
		if not name then
			SLICECMDR.BARS['Rup']['expire'] = 0
			SLICECMDR.BARS['Rup']['obj']:Hide()
			SliceCmdr_ChangeAnchor()--change les ancres
		else
			SLICECMDR.BARS['Rup']['obj'].icon:SetTexture(icon)
			SLICECMDR.BARS['Rup']['expire'] = expirationTime
			SLICECMDR.BARS['Rup']['obj']:Show()
			if SliceCmdr_Save.SpellText == true then
				SLICECMDR.BARS['Rup']['obj'].text2:SetText(string.format("%s", name))
			else
				SLICECMDR.BARS['Rup']['obj'].text2:SetText("")
			end
			SliceCmdr_ChangeAnchor()
		end
	end
	
	if ( SliceCmdr_Save.RupBarShow == true and SliceCmdr_Save.RupBarMine == true ) then
		name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitDebuff("target", SC_SPELL_RUP)
		if not name then
			name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitDebuff("target", SC_SPELL_GAR)
		end
		if not name then
			SLICECMDR.BARS['Rup']['expire'] = 0
			SLICECMDR.BARS['Rup']['Expires'] = 0
			SLICECMDR.BARS['Rup']['obj']:Hide()
			SliceCmdr_ChangeAnchor()--change les ancres
		else
			if (isMine == "player") then
				if SliceCmdr_Save.SpellText == true then
					SLICECMDR.BARS['Rup']['obj'].text2:SetText(string.format("%s", name))
				else
					SLICECMDR.BARS['Rup']['obj'].text2:SetText("")
				end
				SLICECMDR.BARS['Rup']['expire'] = expirationTime
				SLICECMDR.BARS['Rup']['Expires'] = expirationTime
				SLICECMDR.BARS['Rup']['obj']:Show()
				if SliceCmdr_Save.FullTimer == true then
					SLICECMDR.BARS['Rup']['obj']:SetMinMaxValues(0, duration)
				else
					SLICECMDR.BARS['Rup']['obj']:SetMinMaxValues(0, 6.0)
				end
				SliceCmdr_ChangeAnchor()--change les ancres
			else
				SLICECMDR.BARS['Rup']['expire'] = 0
				SLICECMDR.BARS['Rup']['Expires'] = 0
				SLICECMDR.BARS['Rup']['obj']:Hide()
				SliceCmdr_ChangeAnchor()--change les ancres
			end
		end
	end
	
	if (SliceCmdr_Save.EABarShow == true) then
		name, _, icon, _, _, duration, expirationTime = UnitDebuff("target", SC_SPELL_EA)
		if not name then
			name, _, icon, count, _, duration, expirationTime = UnitDebuff("target", SC_SPELL_SA)
			if not name then
				name, _, icon, count, _, duration, expirationTime = UnitDebuff("target", SC_SPELL_FF)
			end
			if not name then
				SLICECMDR.BARS['EA']['expire'] = 0
				SLICECMDR.BARS['EA']['obj']:Hide()
				SliceCmdr_ChangeAnchor()--change les ancres
			else
				SLICECMDR.BARS['EA']['obj'].icon:SetTexture(icon)
				if count ~= nil then
					SLICECMDR.BARS['EA']['obj'].textIcon:SetText(string.format("%i", count))
				else
					SLICECMDR.BARS['EA']['obj'].textIcon:SetText("1")
				end
				if SliceCmdr_Save.SpellText == true then
					SLICECMDR.BARS['EA']['obj'].text2:SetText(string.format("%s", name))
				else
					SLICECMDR.BARS['EA']['obj'].text2:SetText("")
				end
				SLICECMDR.BARS['EA']['expire'] = expirationTime
				SLICECMDR.BARS['EA']['obj']:Show()
				if SliceCmdr_Save.FullTimer == true then
					SLICECMDR.BARS['EA']['obj']:SetMinMaxValues(0, duration)
				else
					SLICECMDR.BARS['EA']['obj']:SetMinMaxValues(0, 6.0)
				end
				SliceCmdr_ChangeAnchor()
			end
		else
			SLICECMDR.BARS['EA']['obj'].icon:SetTexture(icon)
			SLICECMDR.BARS['EA']['expire'] = expirationTime
			SLICECMDR.BARS['EA']['obj']:Show()
			if SliceCmdr_Save.FullTimer == true then
				SLICECMDR.BARS['EA']['obj']:SetMinMaxValues(0, duration)
			else
				SLICECMDR.BARS['EA']['obj']:SetMinMaxValues(0, 6.0)
			end
			if SliceCmdr_Save.SpellText == true then
				SLICECMDR.BARS['EA']['obj'].text2:SetText(string.format("%s",  name))
			else
				SLICECMDR.BARS['EA']['obj'].text2:SetText("")
			end
			SliceCmdr_ChangeAnchor()
			
		end
	end
end

local curCombo = 0

function SliceCmdr_SetComboPts()
	local points = GetComboPoints("player")
	
	if (SliceCmdr_Save.CPBarShow == true) then 
		SLICECMDR.BARS['CP']['expire'] = points
		if points == 0 then
		
			nameUID = UnitGUID("target")
			if nameUID ~= curComboTarget then
				return
			end
		end

		if points == curCombo then
			if curCombo == 0 and not incombat and visible then
				UIFrameFadeOut(SLICECMDR.BARS['CP']['obj'], framefadeout)
				visible = false
			elseif curCombo > 0 and not visible then
				UIFrameFadeIn(SLICECMDR.BARS['CP']['obj'], framefadein)
				visible = true
			end
			return
		end
		
		if (points > curCombo) then
			for i = curCombo + 1, points do
				SLICECMDR.BARS['CP']['obj'].combos[i]:Show()
			end
			SliceCmdr_Combo:SetText(points)
		else
			for i = points + 1, curCombo do
				SLICECMDR.BARS['CP']['obj'].combos[i]:Hide()
			end
			SliceCmdr_Combo:SetText("")
		end	

		
		if points > 0 then
			if points < 3 then
				SLICECMDR.BarFont4:SetShadowColor(0,0,0, 1)
				SLICECMDR.BarFont4:SetTextColor(213/255,200/255,184/255,1)
			else
				SLICECMDR.BarFont4:SetShadowColor(0,0,0, 0)
				SLICECMDR.BarFont4:SetTextColor(0,0,0, 1)
			end
			SLICECMDR.BARS['CP']['obj'].comboText:SetText(points)
		else
			SLICECMDR.BARS['CP']['obj'].comboText:SetText("")
		end
		
		curCombo = points
		
		if curCombo == 0 and not incombat and visible then
			UIFrameFadeOut(SLICECMDR.BARS['CP']['obj'], framefadeout)
			visible = false
		elseif curCombo > 0 and not visible then
			UIFrameFadeIn(SLICECMDR.BARS['CP']['obj'], framefadein)
			visible = true
		end
	else
		if (points > curCombo) then
			SliceCmdr_Combo:SetText(points)
		else
			SliceCmdr_Combo:SetText("")
		end	
	end		
end

function SliceCommander:OnDisable()
	SliceCmdr:UnregisterAllEvents()
	SliceCmdr:Hide()
end

function SliceCmdr_NewFrame()
	local f = CreateFrame("StatusBar", nil, UIParent)
	
	f:SetWidth(widthUI)
	f:SetScale(scaleUI)
	f:SetHeight(10)
	f:SetStatusBarTexture(SliceCmdr_BarTexture())
	f:SetStatusBarColor(0.768627451, 0, 0, 1)
	f:EnableMouse(false)
	f:SetMinMaxValues(0, 6.0)
	f:SetValue(0)

	f:Hide()
	
	f:SetBackdrop({
		  bgFile="Interface\\AddOns\\SliceCommander\\Images\\solid.tga",
		  edgeFile="",
		  tile=true, tileSize=1, edgeSize=0,
		  insets={left=-1, right=-1, top=-1, bottom=-1}
		})
	f:SetBackdropBorderColor(1,1,1,1)
	f:SetBackdropColor(26/255, 26/255, 26/255)
	
	-- text on the right --			
	if not f.text then
		f.text = f:CreateFontString(nil, nil, "GameFontWhite")
	end
	f.text:SetFontObject(SLICECMDR.BarFont2)
	f.text:SetHeight(10)
	f.text:SetWidth(40)
	f.text:SetPoint("TOPRIGHT", f, "TOPRIGHT",  -5, 0)
	f.text:SetJustifyH("RIGHT")
	f.text:SetText("")
	
	-- icon on the left --	
	if not f.icon then
		f.icon = f:CreateTexture(nil, "OVERLAY")
	end
	local offSetSize = SliceCmdr_Save.BarMargin -- other good values, -1, -2
	if type(offSetSize) == "string" then
		offSetSize = 3
	end
	f.icon:SetHeight(f:GetHeight()+offSetSize)
	f.icon:SetWidth(f.icon:GetHeight())
	f.icon:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f.icon:SetAlpha(1)
	f.icon:SetTexCoord(0.07,0.93,0.07,0.93)
	
	f:SetWidth(widthUI-f.icon:GetHeight())
	
	-- Count on the icon --
	if not f.textIcon then
		f.textIcon = f:CreateFontString(nil, "OVERLAY", nil)
	end
	f.textIcon:SetFontObject(SLICECMDR.BarFont2)
	f.textIcon:SetHeight(f.icon:GetHeight()+2)
	f.textIcon:SetWidth(f.icon:GetHeight())
	f.textIcon:SetPoint("CENTER", f.icon , "CENTER", f.icon:GetHeight()+4, 0)
	f.textIcon:SetJustifyH("CENTER")
	f.textIcon:SetText("")
	
	-- text on the left --
	if not f.text2 then
		f.text2 = f:CreateFontString(nil, nil, nil)
	end
	f.text2:SetFontObject(SLICECMDR.BarFont2)
	f.text2:SetHeight(10)
	f.text2:SetWidth(120)
	f.text2:SetPoint("RIGHT", f, "RIGHT", 0, 0)
	f.text2:SetJustifyH("CENTER")
	f.text2:SetText("")
	
	return f
	
end

function SliceCmdr_CPFrame()
	local f = CreateFrame("StatusBar", nil, UIParent)
	local width = widthUI
	f:ClearAllPoints()
	f:SetWidth(width)
	f:SetScale(scaleUI)
	f:SetHeight(10)
	--f:SetPoint("BOTTOMLEFT", VTimerEnergy, "TOPLEFT", 0, 0)
	
	f.bg = f:CreateTexture(nil, "BACKGROUND")
	f.bg:ClearAllPoints()
	f.bg:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f.bg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
	f:SetBackdrop({
		  bgFile="Interface\\AddOns\\SliceCommander\\Images\\solid.tga",
		  edgeFile="",
		  tile=false, tileSize=1, edgeSize=0,
		  insets={left=-1, right=-1, top=-1, bottom=-1}
		})
	f:SetBackdropBorderColor(1,1,1,1)
	f:SetBackdropColor(26/255, 26/255, 26/255)
	
	f.combos = {}
	
	local cx = 0
	local spacing = 2
	width = ((width-(spacing*4))/5)
	
	-- text
	local font = "Fonts\\FRIZQT__.TTF"
	local fontsize = 13
	local fontstyle = "MONOCHROME"
	
	for i = 1, 5 do
		local combo = CreateFrame("Frame", nil, f)
		combo:ClearAllPoints()
		combo:SetPoint("TOPLEFT", f, "TOPLEFT", cx, 0)
		combo:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", cx + width, 0)
		combo:SetHeight(8)
		combo.bg = combo:CreateTexture(nil, "BACKGROUND")
		combo.bg:ClearAllPoints()
		combo.bg:SetAllPoints(combo)
		combo.bg:SetTexture("Interface\\AddOns\\SliceCommander\\Images\\solid.tga")
		combo.bg:SetVertexColor(192/255, 176/255, 71/255)
		combo.bg:SetAlpha(1)
		combo:Hide()
		f.combos[i] = combo
		
		cx = cx + width + spacing
	end

	f.overlay = CreateFrame("Frame", nil, f)
	f.overlay:ClearAllPoints()
	f.overlay:SetAllPoints(f)
	
	if not f.comboText then
		f.comboText = f.overlay:CreateFontString(nil, "OVERLAY")
	end
	f.comboText:SetFontObject(SLICECMDR.BarFont4)
	f.comboText:SetHeight(10)
	f.comboText:SetWidth(120)
	f.comboText:SetJustifyH("CENTER")
	f.comboText:SetText("")
	f.comboText:ClearAllPoints()
	f.comboText:SetAllPoints(f.overlay)

	visible = false
	f:Hide()
	return f
	
end

function SliceCmdr_NewPoisonFrame()
	local f = CreateFrame("StatusBar", nil, UIParent)
	
	f:SetPoint("BOTTOMLEFT", VTimerEnergy, "TOPLEFT", 0, -3)
	f:SetWidth(widthUI)
	f:SetScale(scaleUI)
	f:SetHeight(2)
	f:SetFrameLevel(2)
	f:SetStatusBarTexture(SliceCmdr_BarTexture())
	f:SetStatusBarColor(64/255, 167/255, 64/255)
	f:EnableMouse(false)
	f:SetMinMaxValues(0, 3600*1000)
	f:SetValue(0)
	f:SetFrameStrata("MEDIUM")
	f:Hide()
	
	f:SetBackdrop({
		bgFile="Interface\\AddOns\\SliceCommander\\Images\\solid.tga",
		edgeFile="",
		tile=true, tileSize=1, edgeSize=0,
		insets={left=0, right=0, top=0, bottom=0}
	})
	f:SetBackdropBorderColor(1,1,1,1)
	f:SetBackdropColor(26/255, 26/255, 26/255,0)
	return f
end

function SliceCommander:OnInitialize()
	local localizedClass, englishClass = UnitClass("player")
	if (englishClass == "ROGUE") then
		
		if SliceCommander:TestValueOptions() then
			SliceCommander:SetDefaultOptions()
		end
		
		AceConfig:RegisterOptionsTable("SliceCommander", SC_OptionsTable)
		AceConfig:RegisterOptionsTable("SliceCommander_DisplayTimer", SC_OptionsTable_DisplayTimer)
		AceConfig:RegisterOptionsTable("SliceCommander_Sound", SC_OptionsTable_Sound)
		
		SetDefaultOpttion = AceConfigDialog:AddToBlizOptions("SliceCommander","SliceCommander")
		SetDefaultOpttion.default = function() SliceCommander:SetDefaultOptions() end
		
		SetDefaultOpttion = AceConfigDialog:AddToBlizOptions("SliceCommander_DisplayTimer",SC_DISPLAY_SETTINGS,"SliceCommander")
		SetDefaultOpttion.default = function() SliceCommander:SetDefaultOptions() end
		
		SetDefaultOpttion = AceConfigDialog:AddToBlizOptions("SliceCommander_Sound",SC_LANG_SOUND,"SliceCommander")
		SetDefaultOpttion.default = function() SliceCommander:SetDefaultOptions() end

		VTimerEnergy:SetFrameLevel(1)
		scaleUI = VTimerEnergy:GetScale()
		widthUI = VTimerEnergy:GetWidth()
		soundStatus = GetCVar('Sound_EnableSFX')
		
		SliceCmdr:SetBackdrop({
		  bgFile="Interface\\AddOns\\SliceCommander\\Images\\solid.tga",
		  edgeFile="",
		  tile=true, tileSize=1, edgeSize=0,
		  insets={left=-1, right=-1, top=-1, bottom=-1}
		})
		SliceCmdr:SetBackdropColor(0.7,0.2,0.2,0)
		
		SliceCmdr:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		SliceCmdr:RegisterEvent("UNIT_COMBO_POINTS")
		SLICECMDR.BarFont = CreateFont("VTimerFont")
		SLICECMDR.BarFont:SetFont("Fonts\\FRIZQT__.TTF", 17)
		SLICECMDR.BarFont:SetShadowColor(0,0,0, 0.7)
		SLICECMDR.BarFont:SetTextColor(1,1,1,1)
		SLICECMDR.BarFont:SetShadowOffset(0.8, -0.8)
		
		SLICECMDR.BarFont2 = CreateFont("VTimerFont2")
		SLICECMDR.BarFont2:SetFont("Fonts\\FRIZQT__.TTF", 8)
		SLICECMDR.BarFont2:SetShadowColor(0,0,0, 0.7)
		SLICECMDR.BarFont2:SetTextColor(213/255,200/255,184/255,1)
		SLICECMDR.BarFont2:SetShadowOffset(0.8, -0.8)
		
		SLICECMDR.BarFont3 = CreateFont("VTimerFont1O")
		SLICECMDR.BarFont3:SetFont("Fonts\\FRIZQT__.TTF", 17)
		SLICECMDR.BarFont3:SetShadowColor(0,0,0, 0.2)
		SLICECMDR.BarFont3:SetTextColor(0,0,0,1)
		SLICECMDR.BarFont3:SetShadowOffset(0.8, -0.8)
		
		SLICECMDR.BarFont4 = CreateFont("VTimerFont4")
		SLICECMDR.BarFont4:SetFont("Fonts\\FRIZQT__.TTF", 8)
		SLICECMDR.BarFont4:SetShadowColor(0,0,0, 1)
		SLICECMDR.BarFont4:SetTextColor(213/255,200/255,184/255,1)
		SLICECMDR.BarFont4:SetShadowOffset(0.8, -0.8)
		
		SLICECMDR.LastEnergy = UnitMana('player')
		
		VTimerEnergyTxt:SetFontObject(SLICECMDR.BarFont)
		SliceCmdr_Combo:SetFontObject(SLICECMDR.BarFont3)
		
		VTimerEnergy:SetMinMaxValues(0,UnitManaMax("player"))
		VTimerEnergy:SetBackdrop({
		  bgFile="Interface\\AddOns\\SliceCommander\\Images\\solid.tga",
		  edgeFile="",
		  tile=true, tileSize=1, edgeSize=0,
		  insets={left=-1, right=-1, top=-1, bottom=-1}
		})
		VTimerEnergy:SetBackdropBorderColor(1,1,1,1)
		VTimerEnergy:SetBackdropColor(26/255, 26/255, 26/255)
		VTimerEnergy:SetStatusBarTexture(SliceCmdr_BarTexture())
		VTimerEnergy:SetWidth(200)
		VTimerEnergy:SetFrameStrata("MEDIUM")
		VTimerEnergy:SetStatusBarColor(234/255, 234/255, 234/255)
		
		SLICECMDR.BARS['CP']['obj'] = SliceCmdr_CPFrame()
		
		SLICECMDR.BARS['STUN']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['STUN']['obj']:SetStatusBarColor(227/255, 186/255, 132/255)

		SLICECMDR.BARS['SnD']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['SnD']['obj']:SetStatusBarColor(193/255, 79/255, 44/255)
		
		SLICECMDR.BARS['Rup']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['Rup']['obj']:SetStatusBarColor(180/255, 38/255, 38/255)
		
		SLICECMDR.BARS['REC']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['REC']['obj']:SetStatusBarColor(110/255, 172/255, 163/255)

		SLICECMDR.BARS['VEN']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['VEN']['obj']:SetStatusBarColor(110/255, 34/255, 45/255)
		SLICECMDR.BARS['VEN']['obj'].icon:SetTexture("Interface\\Icons\\Ability_Rogue_Deadliness")
		
		SLICECMDR.BARS['DP']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['DP']['obj']:SetStatusBarColor(64/255, 167/255, 64/255)
		
		SLICECMDR.BARS['ToT']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['ToT']['obj']:SetStatusBarColor(77/255, 77/255, 255/255)
		SLICECMDR.BARS['ToT']['obj'].icon:SetTexture("Interface\\Icons\\Ability_Rogue_TricksOftheTrade")
		
		SLICECMDR.BARS['EA']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['EA']['obj']:SetStatusBarColor(151/255, 101/255, 199/255)
		
		SLICECMDR.BARS['THREAT']['obj'] = SliceCmdr_NewFrame()
		SLICECMDR.BARS['THREAT']['obj']:SetMinMaxValues(0, 110)
		--SLICECMDR.BARS['THREAT']['obj']:SetStatusBarColor(151/255, 101/255, 199/255)
		
		SLICECMDR.BARS['MH']['obj'] = SliceCmdr_NewPoisonFrame()
		
		SLICECMDR.BARS['OH']['obj'] = SliceCmdr_NewPoisonFrame()
		SLICECMDR.BARS['OH']['obj']:ClearAllPoints()
		SLICECMDR.BARS['OH']['obj']:SetPoint("TOPLEFT", VTimerEnergy, "BOTTOMLEFT", 0 , 3)
		
		frameHealth = CreateFrame("Frame",nil,UIParent)
		frameHealth:SetPoint("RIGHT", VTimerEnergy, "RIGHT", -50, 0)
		frameHealth:SetFrameStrata("HIGH")
		frameHealth:SetWidth(20) -- Set these to whatever height/width is needed 
		frameHealth:SetHeight(20) -- for your Texture

		frameHealth.iconHealth = frameHealth:CreateTexture(nil, "OVERLAY")
		frameHealth.iconHealth:SetHeight(20)
		frameHealth.iconHealth:SetWidth(20)
		frameHealth.iconHealth:SetPoint("RIGHT", frameHealth, "RIGHT", 0, 0)
		frameHealth.iconHealth:SetAlpha(1)
		frameHealth.iconHealth:SetTexCoord(0.07,0.93,0.07,0.93)
		frameHealth.iconHealth:SetTexture("Interface\\Icons\\Ability_BackStab")
		frameHealth:Hide()
		frameHealthStatus = 0
	
		SliceCmdr_LockCkecked(SliceCmdr_Save.IsLocked)
		SliceCmdr_SetTimerHeight(SliceCmdr_Save.TimerHeight)
		SliceCmdr_SetWidth(SliceCmdr_Save.Width)
		SliceCmdr_SetEnergyHeight(SliceCmdr_Save.EnergyHeight)
		SliceCmdr_SetScale(SliceCmdr_Save.Scale)
		SliceCmdr_Config_RetextureBars()
		
	else
		SliceCommander:OnDisable()
		return 0
	end
	
end

function SliceCmdr_util_SnDBuffTime()
	if ((SLICECMDR.BARS['SnD']['expire'] > 0) and (SLICECMDR.tNow < SLICECMDR.BARS['SnD']['expire'])) then
		return SLICECMDR.BARS['SnD']['expire'] - SLICECMDR.tNow
	else
		return 0
	end
end

function SliceCmdr_util_VENCDTime(VendettaCD)
	expirationTime = 120 - ( SLICECMDR.tNow - VendettaCD )
	if expirationTime <= 0 then
		expirationTime = 0
	end
	return expirationTime
end

function SliceCmdr_util_ToTCDTime(ToTExpires)
	expirationTime = 30 - ( SLICECMDR.tNow - ToTExpires )
	if expirationTime <= 0 then
		expirationTime = 0
	end
	return expirationTime
end

function SliceCmdr_util(Timer)
	if ((Timer > 0) and (SLICECMDR.tNow < Timer)) then
		return Timer - SLICECMDR.tNow
	else
		return 0
	end
end

function SliceCmdr_RupBar()
	local x = SliceCmdr_util(SLICECMDR.BARS['Rup']['expire'])
	
	SliceCmdr_Bar(x,SLICECMDR.BARS['Rup'])
	if (x > 0) then
		if (x <= 3) then
			if (RUP_AlertPending == 3) then
				SliceCmdr_Sound('RUP_Alert')
				RUP_AlertPending = 2
			else 
				if (x <= 2) then
					if (RUP_AlertPending == 2) then
						SliceCmdr_Sound('RUP_Alert')
						RUP_AlertPending = 1
					else 
						if (x <= 1) then
							if (RUP_AlertPending == 1) then
								SliceCmdr_Sound('RUP_Alert')
								RUP_AlertPending = 0
							end
						end
					end
				end
			end
		else
			RUP_AlertPending = 3
		end
	end
	if (x <= 0) then
		SLICECMDR.BARS['Rup']['expire'] = 0
	end	
end

function SliceCmdr_RecBar()
	local x = SliceCmdr_util(SLICECMDR.BARS['REC']['expire'])
	
	SliceCmdr_Bar(x,SLICECMDR.BARS['REC'])
	
	if (x <= 0) then
		SLICECMDR.BARS['REC']['expire'] = 0
	end	
end

function SliceCmdr_DPBar()
	local x = SliceCmdr_util(SLICECMDR.BARS['DP']['expire'])
	SliceCmdr_Bar(x,SLICECMDR.BARS['DP'])
	
	name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitDebuff("target", SC_SPELL_DP)
	nameUID = UnitGUID("target")
	
	for i = 1, 5 do
		if nameUID then
			if curComboTarget == nameUID then
				if name and isMine == "player" then
					if i <= count then
						SLICECMDR.BARS['CP']['obj'].combos[i].bg:SetVertexColor(64/255, 167/255, 64/255)
					else
						SLICECMDR.BARS['CP']['obj'].combos[i].bg:SetVertexColor(192/255, 176/255, 71/255)
					end
				else
					SLICECMDR.BARS['CP']['obj'].combos[i].bg:SetVertexColor(192/255, 176/255, 71/255)
				end
			else
				SLICECMDR.BARS['CP']['obj'].combos[i].bg:SetVertexColor(124/255, 124/255, 124/255)
			end
		else
			SLICECMDR.BARS['CP']['obj'].combos[i].bg:SetVertexColor(124/255, 124/255, 124/255)
		end
	end
	if (x == 0) then
		SLICECMDR.BARS['DP']['expire'] = 0
	end
end

function SliceCmdr_ToTBar()
	if SliceCmdr_Save.TotTBarShow == true then
		start, duration, enabled = GetSpellCooldown(SC_SPELL_TOT)
		if start ~= 0 and SLICECMDR.BARS['ToT']['expire'] == 0 and enabled == 1 and duration == 30 then
			SLICECMDR.BARS['ToT']['expire'] = start
			SliceCmdr_ChangeAnchor()
			SLICECMDR.BARS['ToT']['obj']:Show()
			if SliceCmdr_Save.FullTimer == true then
				SLICECMDR.BARS['ToT']['obj']:SetMinMaxValues(0, duration)
			else
				SLICECMDR.BARS['ToT']['obj']:SetMinMaxValues(0, 6.0)
			end
			if SliceCmdr_Save.SpellText == true then
				SLICECMDR.BARS['ToT']['obj'].text2:SetText(string.format("%s", SC_SPELL_TOT))
			else
				SLICECMDR.BARS['ToT']['obj'].text2:SetText("")
			end
		end
		
		local x = SliceCmdr_util_ToTCDTime(SLICECMDR.BARS['ToT']['expire'])
		SliceCmdr_Bar(x,SLICECMDR.BARS['ToT'])
		if (x <= 0) then
			SLICECMDR.BARS['ToT']['expire'] = 0
		end
	else
		SLICECMDR.BARS['ToT']['expire'] = 0
		SLICECMDR.BARS['ToT']['obj']:Hide()
	end
end

function SliceCmdr_EABar()
	local x = SliceCmdr_util(SLICECMDR.BARS['EA']['expire'])

	SliceCmdr_Bar(x,SLICECMDR.BARS['EA'])
	
	if (x <= 0) then
		SLICECMDR.BARS['EA']['expire'] = 0
	end
end

function SliceCmdr_StunBar()
	local x = SliceCmdr_util(SLICECMDR.BARS['STUN']['expire'])

	SliceCmdr_Bar(x,SLICECMDR.BARS['STUN'])
	
	if (x <= 0) then
		SLICECMDR.BARS['STUN']['expire'] = 0
	end
end

function SliceCmdr_PoisonBar()
	if SliceCmdr_Save.PoisonShow == true then
		local _ , mainHandExpiration , _ , _ , offHandExpiration = GetWeaponEnchantInfo()

		if ( mainHandExpiration ~= nil ) then
			SLICECMDR.BARS['MH']['obj']:SetValue(mainHandExpiration)
			SLICECMDR.BARS['MH']['obj']:Show()
		else
			SLICECMDR.BARS['MH']['obj']:Hide()
		end
		if ( offHandExpiration ~= nil ) then
			SLICECMDR.BARS['OH']['obj']:SetValue(offHandExpiration)
			SLICECMDR.BARS['OH']['obj']:Show()
		else
			SLICECMDR.BARS['OH']['obj']:Hide()
		end
	else
		SLICECMDR.BARS['MH']['obj']:Hide()
		SLICECMDR.BARS['OH']['obj']:Hide()
	end
end

function SliceCmdr_Bar(x,SLICECMDR_BARS)
	if ( x > 0 ) then
		if (SLICECMDR_BARS) then
			SLICECMDR_BARS['obj']:SetValue(x)
			SLICECMDR_BARS['obj'].text:SetText(string.format("%0.1f", x))
		end
	else
		SLICECMDR_BARS['obj']:Hide()
		SLICECMDR_BARS['obj'].text:SetText("")
		SliceCmdr_ChangeAnchor()
	end
end

function SliceCmdr_VendettaBar()
	if SliceCmdr_Save.VenBarShow == false then
		SLICECMDR.BARS['VEN']['expire'] = 0
	end

	local x = SliceCmdr_util(SLICECMDR.BARS['VEN']['expire'])
	local VEN = SLICECMDR.BARS['VEN']
	
	if (x > 0) then
		if (SLICECMDR.BARS['VEN']) then
			SLICECMDR.BARS['VEN']['obj']:SetValue(x)
			SLICECMDR.BARS['VEN']['obj'].text:SetText(string.format("%0.1f", x))
		end
	else
		if  SliceCmdr_Save.VenBarShow == true then
			SLICECMDR.BARS['VEN']['expire'] = 0
			start, duration, enabled = GetSpellCooldown(SC_SPELL_VEN)
			if start ~= 0 and SLICECMDR.BARS['VEN']['cd'] == 0 and enabled == 1 and duration == 120 then
				SLICECMDR.BARS['VEN']['cd'] = start
			end
			
			local x = SliceCmdr_util_VENCDTime(SLICECMDR.BARS['VEN']['cd'])
			SliceCmdr_Bar(x,SLICECMDR.BARS['VEN'])
			if (x <= 0) then
				SLICECMDR.BARS['VEN']['cd'] = 0
			else
				SliceCmdr_ChangeAnchor()
				SLICECMDR.BARS['VEN']['obj']:Show()
				if SliceCmdr_Save.FullTimer == true then
					SLICECMDR.BARS['VEN']['obj']:SetMinMaxValues(0, duration)
				else
					SLICECMDR.BARS['VEN']['obj']:SetMinMaxValues(0, 6.0)
				end
				if SliceCmdr_Save.SpellText == true then
					SLICECMDR.BARS['VEN']['obj'].text2:SetText(string.format("%s", SC_SPELL_VEN.." (CD)"))
				else
					SLICECMDR.BARS['VEN']['obj'].text2:SetText("")
				end
				SLICECMDR.BARS['VEN']['obj']:SetStatusBarColor(139/255, 78/255, 87/255)			
			end
		end
	end	
	
end

function SliceCmdr_SNDBar()
	if SliceCmdr_Save.SnDBarShow == false then
		SLICECMDR.BARS['SnD']['expire'] = 0
	end
	SLICECMDR.tNow = GetTime()
	if (SliceCmdr_Save.PadLatency) then
		local down, up, lag = GetNetStats()
		SLICECMDR.tNow = SLICECMDR.tNow + (lag*2/1000)
	end	
		
	local x = SliceCmdr_util_SnDBuffTime()

	if (x > 0) then
		if (x <= 3) then
			if (SLICECMDR.AlertPending == 3) then
				SliceCmdr_Sound("Tick3")
				SLICECMDR.AlertPending = 2
			else 
				if (x <= 2) then
					if (SLICECMDR.AlertPending == 2) then
						SliceCmdr_Sound("Tick2")
						SLICECMDR.AlertPending = 1
					else 
						if (x <= 1) then
							if (SLICECMDR.AlertPending == 1) then
								SliceCmdr_Sound("Tick1")
								SLICECMDR.AlertPending = 0
							end
						end
					end
				end
			end
		else
			SLICECMDR.AlertPending = 3
		end
		
	end
	
	if (SLICECMDR.BARS['SnD']) then
		if (SLICECMDR.BARS['SnD']['obj']) then
			SLICECMDR.BARS['SnD']['obj']:SetValue(x)
			if (x > 0) then
				SLICECMDR.BARS['SnD']['obj'].text:SetText(string.format("%0.1f", x))
			else
				SLICECMDR.BARS['SnD']['obj'].text:SetText("")
			end		
		end			
	end
end

function SliceCmdr_TargetHealth()
	if (GetActiveTalentGroup(false,false) == 1 and SliceCmdr_Save.checkHealthSpec1) or (GetActiveTalentGroup(false,false) == 2 and SliceCmdr_Save.checkHealthSpec2) then
		HP = UnitHealth("target")
		maxHP = UnitHealthMax("target")
		if HP ~= 0 and maxHP ~= 0 then
			pourcentHP = (HP / maxHP) * 100
			if pourcentHP <= 35 then
				if frameHealthStatus == 0 then
					frameHealthStatus = 1
					SliceCmdr_Sound("HealthUnder")
					frameHealth:Show()
				end
			else
				if frameHealthStatus == 1 then
					frameHealthStatus = 0
					frameHealth:Hide()
				end
			end
		else
			if frameHealthStatus == 1 then
				frameHealthStatus = 0
				frameHealth:Hide()
			end
		end
	end
end

function SliceCmdr_TargetThreat()
	if SliceCmdr_Save.THREATBarShow == false or (SliceCmdr_Save.ThreatGroupOnly and GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0) then
		SLICECMDR.BARS['THREAT']['expire'] = 0
	else
		isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
		if rawthreatpct == nil then
			SLICECMDR.BARS['THREAT']['expire'] = 0
		else
			hexCol = rawthreatpct *(255/110)
			rCol = hexCol-45
			gCol = 255-hexCol+50
			if isTanking == 1 then
				rCol = 210
				gCol = 50
				rawthreatpct = 100
			end
			if rCol > 210 then
				rCol = 210
			end
			if rCol < 50 then
				rCol = 50
			end	
			if gCol > 210 then
				gCol = 210
			end
			if gCol < 50 then
				gCol = 50
			end			
			bCol = 50
			SLICECMDR.BARS['THREAT']['expire'] = rawthreatpct
		end
	end
	if SLICECMDR.BARS['THREAT']['expire'] == 0 then
		SLICECMDR.BARS['THREAT']['obj']:Hide()
	else
		SLICECMDR.BARS['THREAT']['obj']:SetValue(SLICECMDR.BARS['THREAT']['expire'])
		SLICECMDR.BARS['THREAT']['obj'].text:SetText(string.format("%0.1f", SLICECMDR.BARS['THREAT']['expire']))
		SLICECMDR.BARS['THREAT']['obj']:SetStatusBarColor(rCol/255,gCol/255,bCol/255)
		SLICECMDR.BARS['THREAT']['obj']:Show()
	end
end

SLASH_SLICECOMMANDER1 = "/slicecommander"
SLASH_SLICECOMMANDER2 = "/sc"
SlashCmdList["SLICECOMMANDER"] = function(msg)
	InterfaceOptionsFrame_OpenToCategory("SliceCommander")
end

function SliceCmdr_Config_OnEvent(self, event, ...)
	if (event == "ADDON_LOADED") then
		local localizedClass, englishClass = UnitClass("player")
		if (englishClass == "ROGUE") then
			local arg1 = select(1, ...)
			if (arg1 == "SliceCommander") then
				SliceCmdr_Config_LoadVars()
			end
		end
	end	
end

function SliceCommander:OnEnable()
	local localizedClass, englishClass = UnitClass("player")
	if (englishClass == "ROGUE") then
		VTimerEnergy:SetValue(UnitMana("player"))
		VTimerEnergy:SetMinMaxValues(0,UnitManaMax("player"))
		
		if (UnitManaMax("player") == UnitMana('player')) then
			VTimerEnergyTxt:SetText("")
		else
			VTimerEnergyTxt:SetText(UnitMana("player"))
		end			
		
		SliceCmdr_Config_OtherVars()
		
		if (SLICECMDR.LastEnergy < UnitMana('player')) then
			if ((SLICECMDR.LastEnergy < SliceCmdr_Save.Energy2) and (UnitMana('player') >= SliceCmdr_Save.Energy2)) then
				SliceCmdr_Sound("EnergySound2")
			else
				if ((SLICECMDR.LastEnergy < SliceCmdr_Save.Energy1) and (UnitMana('player') >= SliceCmdr_Save.Energy1)) then
					SliceCmdr_Sound("EnergySound1")
				else
					if ((SLICECMDR.LastEnergy < SliceCmdr_Save.Energy3) and (UnitMana('player') >= SliceCmdr_Save.Energy3)) then
						SliceCmdr_Sound("EnergySound3")
					end
				end
			end
			if (UnitManaMax("player") == UnitMana('player')) then
				if( SliceCmdr_Save.PoisonShow == true and SliceCmdr_Save.PoisonTransparencyShow == true and ((SLICECMDR.BARS['MH']['obj']:GetValue() ~= 0 and SLICECMDR.BARS['MH']['obj']:GetValue() ~= nil) or (SLICECMDR.BARS['OH']['obj']:GetValue() ~= 0 and SLICECMDR.BARS['OH']['obj']:GetValue() ~= nil) ) ) then
					SLICECMDR.BARS['MH']['obj']:SetAlpha(1.0)
					SLICECMDR.BARS['OH']['obj']:SetAlpha(1.0)
					VTimerEnergy:SetAlpha(1.0)
				else
					SLICECMDR.BARS['MH']['obj']:SetAlpha(SliceCmdr_Save.EnergyTrans / 100.0)
					SLICECMDR.BARS['OH']['obj']:SetAlpha(SliceCmdr_Save.EnergyTrans / 100.0)
					VTimerEnergy:SetAlpha(SliceCmdr_Save.EnergyTrans / 100.0)
				end
			else
				SLICECMDR.BARS['MH']['obj']:SetAlpha(1.0)
				SLICECMDR.BARS['OH']['obj']:SetAlpha(1.0)
				VTimerEnergy:SetAlpha(1.0)
			end
		end
		
		SLICECMDR.LastEnergy = UnitMana('player')
		SliceCmdr_SNDBar()
		SliceCmdr_RecBar()
		SliceCmdr_VendettaBar()
		SliceCmdr_ToTBar()
		SliceCmdr_EABar()
		SliceCmdr_DPBar()
		SliceCmdr_RupBar()
		SliceCmdr_StunBar()
		SliceCmdr_PoisonBar()
		SliceCmdr_TargetHealth()
		SliceCmdr_TargetThreat()
	end
end