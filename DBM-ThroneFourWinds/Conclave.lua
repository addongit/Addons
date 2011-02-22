local mod	= DBM:NewMod("Conclave", "DBM-ThroneFourWinds")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5214 $"):sub(12, -3))
mod:SetCreatureID(45870, 45871, 45872)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_POWER",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnNurture			= mod:NewSpellAnnounce(85422, 3)
local warnSoothingBreeze	= mod:NewSpellAnnounce(86207, 3)	-- using a spellID here with a better description of the spell
local warnSummonTornados	= mod:NewSpellAnnounce(86192, 3)
local warnWindBlast			= mod:NewSpellAnnounce(86193, 3)
local warnStormShield		= mod:NewSpellAnnounce(95865, 3)
local warnPoisonToxic	 	= mod:NewSpellAnnounce(86281, 3)
local warnGatherStrength	= mod:NewTargetAnnounce(86307, 4)
local warnSpecial			= mod:NewAnnounce("warnSpecial", 3, "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")--Hurricane/Sleet Storm/Zephyr in single announce

local specWarnSpecial		= mod:NewSpecialWarning("specWarnSpecial")
local specWarnShield		= mod:NewSpecialWarningSpell(95865)
local specWarnWindBlast		= mod:NewSpecialWarningSpell(86193, false)
local specWarnIcePatch      = mod:NewSpecialWarningMove(93131)

local timerNurture			= mod:NewNextTimer(114, 85422)--This does NOT cast at same time as hurricane/sleet storm/Zephyr (35 seconds after special ended?)
local timerWindChill		= mod:NewNextTimer(10.5, 84645, nil, false)
local timerSlicingGale		= mod:NewBuffActiveTimer(45, 93058)
local timerWindBlast		= mod:NewBuffActiveTimer(10, 86193)
local timerWindBlastCD		= mod:NewCDTimer(60, 86193)-- Cooldown: 1st->2nd = 22sec || 2nd->3rd = 60sec || 3rd->4th = 60sec ?
local timerStormShieldCD	= mod:NewNextTimer(113, 95865)--Heroic ability, seems to share CD/line up with Nurture
local timerGatherStrength	= mod:NewTargetTimer(60, 86307)
local timerPoisonToxic		= mod:NewBuffActiveTimer(5, 86281)
local timerPoisonToxicCD	= mod:NewCDTimer(21, 86281)--is this a CD or a next timer?
local timerPermaFrostCD		= mod:NewCDTimer(10, 93233)
local timerSoothingBreezeCD	= mod:NewNextTimer(32.5, 86205)--needs more work, works fine as a CD timer for now, but it also depends on bosses energy on whether or not he casts this instead of spores.
local timerSpecial			= mod:NewTimer(95, "timerSpecial", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")--hurricane/Sleet storm/Zephyr share CD. Shortened cause sometimes slipstreams end early, even though cd is a little longer
local timerSpecialActive	= mod:NewTimer(15, "timerSpecialActive", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")

local enrageTimer			= mod:NewBerserkTimer(480) -- Both normal and heroic mode

mod:AddBoolOption("OnlyWarnforMyTarget", false, "announce")--Default off do to targeting dependance (not great for healers who don't set focus). Has ability to filter all timers/warnings for bosses you are not targeting or focusing.

local windBlastCounter = 0
local specialSpam = 0
local specialsEnded = 0
local poisonCounter = 0
local poisonSpam = 0
local iceSpam = 0
local GatherStrengthwarned = false

function mod:OnCombatStart(delay)
	windBlastCounter = 0
	specialSpam = 0
	specialsEnded = 0
	iceSpam = 0
	GatherStrengthwarned = false
	timerSpecial:Start(90-delay)
	enrageTimer:Start(-delay)
	if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
		timerSoothingBreezeCD:Start(15-delay)
		timerNurture:Start(30-delay)
	end
	if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
		timerWindBlastCD:Start(30-delay)
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerStormShieldCD:Start(30-delay)
		end
	end
	if self:GetUnitCreatureId("target") == 45871 or self:GetUnitCreatureId("focus") == 45871 or not self.Options.OnlyWarnforMyTarget then--Nezir
		timerPermaFrostCD:Start(-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93057, 93058) then
		if args:IsPlayer() then
			timerSlicingGale:Start()
		end
	elseif args:IsSpellID(84651, 93117, 93118, 93119) and args:GetDestCreatureID() == 45870 and GetTime() - specialsEnded >= 3 then--Zephyr stacks on Anshal
		if (args.amount or 1) >= 15 then--Special has ended when he's at 15 stacks.
			timerSpecial:Start()
			specialsEnded = GetTime()
			if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
				timerSoothingBreezeCD:Start(15)
				timerNurture:Start(35)
			end
			if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
				timerStormShieldCD:Start(35)
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(84644, 84643) and GetTime() - specialsEnded >= 3 then--Sleet Storm, Hurricane.
		timerSpecial:Start()
		specialsEnded = GetTime()
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
			timerSoothingBreezeCD:Start(15)
			timerNurture:Start(35)
		end
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
			timerStormShieldCD:Start(35)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(86111, 93129, 93130, 93131) and args:IsPlayer() and GetTime() - iceSpam >= 3 then
		iceSpam = GetTime()
		specWarnIcePatch:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86205) then
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
			warnSoothingBreeze:Show()--possibly change to target scanning and announce whether he's casting it on himself or one of his flowers.
			timerSoothingBreezeCD:Start()
		end
	elseif args:IsSpellID(86192) then
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then
			warnSummonTornados:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(85422) then
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then--Anshal and his flowers
			warnNurture:Show()
			--timerNurture:Start()--Trying an anti spam experiment of starting this timer somewhere else to minimize time it spends on screen.
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
				timerPoisonToxicCD:Start()
			end
		end
	elseif args:IsSpellID(93233) then
		if self:GetUnitCreatureId("target") == 45871 or self:GetUnitCreatureId("focus") == 45871 or not self.Options.OnlyWarnforMyTarget then--Nezir
			timerPermaFrostCD:Start()
		end
	elseif args:IsSpellID(84644, 84638, 84643) and GetTime() - specialSpam > 3 then
		warnSpecial:Show()
		specWarnSpecial:Show()
		timerSpecialActive:Start()
		specialSpam = GetTime()--Trigger it off any of 3 spells, but only once.
		poisonCounter = 0
		if self:GetUnitCreatureId("target") == 45871 or self:GetUnitCreatureId("focus") == 45871 or not self.Options.OnlyWarnforMyTarget then--Nezir
			timerPermaFrostCD:Start(15)--This is gonna slap you in face the instance special ends.
		end
	elseif args:IsSpellID(93059, 95865) then-- Storm Shield Warning (Heroic mode skill)
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
			warnStormShield:Show()
			specWarnShield:Show()
			--timerStormShieldCD:Start()--Trying an anti spam experiment of starting this timer somewhere else to minimize time it spends on screen.
		end
	elseif args:IsSpellID(86281) and GetTime() - poisonSpam > 3 then-- Poison Toxic Warning (at Heroic, Poison Toxic damage is too high, so warning needed)
		poisonSpam = GetTime()
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then
			warnPoisonToxic:Show()
			timerPoisonToxic:Show()
			timerPoisonToxicCD:Start()
		end
		if poisonCounter < 1 then
			poisonCounter = 1
		end
	elseif args:IsSpellID(84645, 93123, 93124, 93125) then
		if self:GetUnitCreatureId("target") == 45871 or self:GetUnitCreatureId("focus") == 45871 or not self.Options.OnlyWarnforMyTarget then--Nezir
			timerWindChill:Start()
		end
	elseif args:IsSpellID(86193) then
		windBlastCounter = windBlastCounter + 1
		if self:GetUnitCreatureId("target") == 45872 or self:GetUnitCreatureId("focus") == 45872 or not self.Options.OnlyWarnforMyTarget then--Rohash
			warnWindBlast:Show()
			specWarnWindBlast:Show()
			timerWindBlast:Start()
			if windBlastCounter == 1 then
				timerWindBlastCD:Start(82)
			else
				timerWindBlastCD:Start()
			end
		end
	end
end

-- Posion Toxic can do casts during stun, so if Poison Toxic cancelled, Next Poision Toxic timer known by boss`s power.
function mod:UNIT_POWER(uId)
	if self:GetUnitCreatureId(uId) == 45870 and UnitPower(uId) == 62 and poisonCounter == 0 and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
		if self:GetUnitCreatureId("target") == 45870 or self:GetUnitCreatureId("focus") == 45870 or self:GetUnitCreatureId("target") == 45812 or not self.Options.OnlyWarnforMyTarget then
			timerPoisonToxicCD:Start(10)
		end
	elseif self:GetUnitCreatureId(uId) == 45870 and UnitPower(uId) == 79 and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
		timerPoisonToxicCD:Cancel()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, boss)
	if (msg == L.gatherstrength or msg:find(L.gatherstrength)) and mod:LatencyCheck() then
		self:SendSync("GatherStrength", boss)
	end
end

function mod:OnSync(msg, boss)
	if msg == "GatherStrength" and self:IsInCombat() and not GatherStrengthwarned then
		warnGatherStrength:Show(boss)
		timerGatherStrength:Start(boss)
		GatherStrengthwarned = true
	end
end