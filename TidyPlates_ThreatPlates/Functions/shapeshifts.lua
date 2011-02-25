local _,class = UnitClass("player")
local function ShapeshiftUpdate()
	
	local CharDB = TidyPlatesThreat.db.char
	
	if class == "WARRIOR" and CharDB.stances.ON then
		CharDB.threat.tanking = CharDB.stances[GetShapeshiftForm()]
		TidyPlates:Update()
	elseif class == "DRUID" and CharDB.shapeshifts.ON then
		CharDB.threat.tanking = CharDB.shapeshifts[GetShapeshiftForm()]
		TidyPlates:Update()
	elseif class == "DEATHKNIGHT" and CharDB.presences.ON then
		CharDB.threat.tanking = CharDB.presences[GetShapeshiftForm()]
		TidyPlates:Update()
	elseif class == "PALADIN" and CharDB.auras.ON then
		CharDB.threat.tanking = CharDB.auras[GetShapeshiftForm()]
		TidyPlates:Update()
	end
end

TidyPlatesThreat.ShapeshiftUpdate = ShapeshiftUpdate