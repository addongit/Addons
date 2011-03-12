local function SetHealthbarColor(unit)
	local db = TidyPlatesThreat.db.profile
	local style = SetStyleThreatPlates(unit)
	local c
	if style == "totem" or style == "etotem" then
		if db.settings.raidicon.hpColor and unit.isMarked then
			local R = db.settings.raidicon.hpMarked[unit.raidIcon]
			return R.r, R.g, R.b
		else
			local tS = db.totemSettings[TPtotemList[unit.name]]
			if tS[2] then
				c = tS.color
				return c.r, c.g, c.b
			else
				return unit.red, unit.green, unit.blue
			end
		end
	elseif style == "unique" then
		for k_c,k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				local u = db.uniqueSettings[k_c]
				if u.useColor then
					if u.allowMarked and unit.isMarked and db.settings.raidicon.hpColor then
						local R = db.settings.raidicon.hpMarked[unit.raidIcon]
						return R.r, R.g, R.b
					else
						local c = u.color
						return c.r,c.g,c.b
					end
				elseif not u.useColor then
					if u.allowMarked and unit.isMarked and db.settings.raidicon.hpColor then
						local R = db.settings.raidicon.hpMarked[unit.raidIcon]
						return R.r, R.g, R.b
					elseif not unit.isMarked and db.threat.useHPColor and InCombatLockdown() and db.threat.ON then
						if TidyPlatesThreat.db.char.threat.tanking then
							local T = db.settings["tank"].threatcolor[unit.threatSituation]
							return T.r, T.g, T.b
						else
							local T = db.settings["dps"].threatcolor[unit.threatSituation]
							return T.r, T.g, T.b
						end
					else
						return unit.red, unit.green, unit.blue
					end
				end
			end
		end
	elseif ((( style == "tank") or (style == "dps")) and db.threat.useHPColor and InCombatLockdown()) then
		if db.settings.raidicon.hpColor and unit.isMarked then
			local R = db.settings.raidicon.hpMarked[unit.raidIcon]
			return R.r, R.g, R.b
		else
			local T = db.settings[style].threatcolor[unit.threatSituation]
			return T.r, T.g, T.b
		end
	else
		if db.settings.raidicon.hpColor and unit.isMarked then
			local R = db.settings.raidicon.hpMarked[unit.raidIcon]
			return R.r, R.g, R.b
		else
			if db.healthColorChange then
				local pct = unit.health / unit.healthmax
				return (1-pct),(pct), 0
			elseif db.customColor then
				if unit.reaction == "FRIENDLY" then
					local d = db.fHPbarColor
					return d.r, d.g, d.b
				elseif unit.reaction == "NEUTRAL" then
					local n = db.nHPbarColor
					return n.r, n.g, n.b
				else
					local c = db.HPbarColor
					if unit.class and (unit.class == "UNKNOWN") then
						return c.r, c.g, c.b
					elseif unit.class and (unit.class ~= "UNKNOWN") and db.allowClass then
						return c.r, c.g, c.b
					else
						return unit.red, unit.green, unit.blue
					end
				end
			elseif TidyPlatesThreat.db.profile.cache[unit.name] and db.friendlyClass then
				local class = TidyPlatesThreat.db.profile.cache[unit.name]
				local c = RAID_CLASS_COLORS[class]
				return c.r, c.g, c.b
			elseif unit.guid and GetPlayerInfoByGUID(unit.guid) and not TidyPlatesThreat.db.profile.cache[unit.name] and db.friendlyClass then
				local _, class = GetPlayerInfoByGUID(unit.guid)
				local c = RAID_CLASS_COLORS[class]
				if db.cacheClass then
					TidyPlatesThreat.db.profile.cache[unit.name] = class
				end
				return c.r, c.g, c.b
			else
				return unit.red, unit.green, unit.blue
			end
		end
	end
end

TidyPlatesThreat.SetHealthbarColor = SetHealthbarColor