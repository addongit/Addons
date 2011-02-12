local mod	= DBM:NewMod("Chimaeron", "DBM-BlackwingDescent", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5078 $"):sub(12, -3))
mod:SetCreatureID(43296)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

local warnCausticSlime		= mod:NewTargetAnnounce(82935, 3, nil, false)--This will be very spammy but useful for debugging positioning issues (IE too many people clumped)
local warnBreak				= mod:NewAnnounce("WarnBreak", 3, 82881, mod:IsTank() or mod:IsHealer())
local warnDoubleAttack		= mod:NewSpellAnnounce(88826, 4, nil, mod:IsTank() or mod:IsHealer())
local warnMassacre			= mod:NewSpellAnnounce(82848, 4)
local warnFeud				= mod:NewSpellAnnounce(88872, 3)
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)

local specWarnMassacre		= mod:NewSpecialWarningSpell(82848, mod:IsHealer())
local specWarnDoubleAttack	= mod:NewSpecialWarningSpell(88826, mod:IsTank())

local timerBreak			= mod:NewTargetTimer(60, 82881)
local timerBreakCD			= mod:NewNextTimer(15, 82881)--Also double attack CD
local timerMassacre			= mod:NewCastTimer(4, 82848)
local timerMassacreNext		= mod:NewNextTimer(30, 82848)
local timerCausticSlime		= mod:NewNextTimer(15, 88915)--This is seemingly cast 15 seconds into feud, any other time it's simply cast repeatedly the whole fight.
local timerFeud				= mod:NewBuffActiveTimer(26, 88872)

local berserkTimer			= mod:NewBerserkTimer(450)--Heroic

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnSlime")
mod:AddBoolOption("InfoFrame", mod:IsHealer())

local prewarnedPhase2 = false
local feud = false
local slimeTargets = {}
local slimeTargetIcons = {}

local function showSlimeWarning()
	warnCausticSlime:Show(table.concat(slimeTargets, "<, >"))
	table.wipe(slimeTargets)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetSlimeIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(slimeTargetIcons, sort_by_group)
			local slimeIcon = 8
			for i, v in ipairs(slimeTargetIcons) do
				self:SetIcon(UnitName(v), slimeIcon, 3)
				slimeIcon = slimeIcon - 1
			end
			table.wipe(slimeTargetIcons)
		end
	end
end

function mod:OnCombatStart(delay)
	timerMassacreNext:Start(26-delay)
	timerBreakCD:Start(6-delay)
	prewarnedPhase2 = false
	feud = false
	slimeIcon = 8
	table.wipe(slimeTargets)
	table.wipe(slimeTargetIcons)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		berserkTimer:Start(-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.HealthInfo)
		DBM.InfoFrame:Show(5, "health", 10000)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82881) then
		warnBreak:Show(args.spellName, args.destName, args.amount or 1)
		timerBreak:Start(args.destName)
		timerBreakCD:Start()
	elseif args:IsSpellID(88826) then
		warnDoubleAttack:Show()
		specWarnDoubleAttack:Show()
	elseif args:IsSpellID(82935, 88915, 88916, 88917) and args:IsDestTypePlayer() then
		slimeTargets[#slimeTargets + 1] = args.destName
		if self.Options.SetIconOnSlime and not feud then--Don't set icons during feud, set them any other time.
			table.insert(slimeTargetIcons, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetSlimeIcons")
			if mod:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.4, "SetSlimeIcons")--0.3 might work, but i know 0.4 works for sure so i don't feel like rush changing it.
			end
		end
		self:Unschedule(showSlimeWarning)
		self:Schedule(0.3, showSlimeWarning)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82848) then
		warnMassacre:Show()
		specWarnMassacre:Show()
		timerMassacre:Start()
		timerMassacreNext:Start()
		timerCausticSlime:Start(19)--Always 19 seconds after massacre.
		feud = false
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(88872) then
		warnFeud:Show()
		timerFeud:Start()
		feud = true
	elseif args:IsSpellID(82934) then
		warnPhase2:Show()
		timerCausticSlime:Cancel()
		timerMassacreNext:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 22 and h < 25 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 43296 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end