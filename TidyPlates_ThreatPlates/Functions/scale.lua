local function TypeScale(unit)
	local db = TidyPlatesThreat.db.profile.threat
	local T =  TPTP_UnitType(unit)
	if db.useType then
		if T == "Neutral" then
			return db.scaleType["Normal"]
		elseif T == "Normal" or T == "Elite" or T == "Boss" then
			return db.scaleType[T]
		elseif T == "Unique" then
			if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
				return db.scaleType["Boss"]
			elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
				return db.scaleType["Elite"]
			elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE"))then
				return db.scaleType["Normal"]
			elseif unit.reaction == "NEUTRAL" then
				return db.scaleType["Normal"]
			end
		end
	else		
		return 0
	end
end

local function SetScale(unit)
	local db = TidyPlatesThreat.db.profile
	local T =  TPTP_UnitType(unit)
	local uS = db.uniqueSettings[TPuniqueList[unit.name]]
	local style = SetStyleThreatPlates(unit)
	if style == "unique" then
		if not uS[10] then
			return uS[7]
		elseif db.threat.ON and InCombatLockdown() and db.threat.useScale and uS[10] then
			if unit.isMarked and TidyPlatesThreat.db.profile.threat.marked.scale then
				return (db.nameplate.scale["Marked"])
			else
				if TidyPlatesThreat.db.char.threat.tanking then
					return (db.threat["tank"].scale[unit.threatSituation] + (TypeScale(unit)))
				else
					return (db.threat["dps"].scale[unit.threatSituation] + (TypeScale(unit)))
				end
			end
		elseif not InCombatLockdown() and uS[10] then
			if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
				return ((db.nameplate.scale["Boss"]) or 1)
			elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
				return ((db.nameplate.scale["Elite"]) or 1)
			elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE"))then
				return ((db.nameplate.scale["Normal"]) or 1)
			elseif unit.reaction == "NEUTRAL" then
				return ((db.nameplate.scale["Neutral"]) or 1)
			end
		end
	elseif style == "normal" then
		return db.nameplate.scale[T]
	elseif (style == "tank" or style == "dps") and db.threat.useScale then
		if unit.isMarked and db.threat.marked.scale then
			return db.nameplate.scale["Marked"]
		else
			return ( db.threat[style].scale[unit.threatSituation] + (TypeScale(unit)))
		end
	else 
		return (db.nameplate.scale[T] or 1)
	end
end

TidyPlatesThreat.SetScale = SetScale