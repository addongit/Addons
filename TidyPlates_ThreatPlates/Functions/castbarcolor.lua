local function SetCastbarColor(unit)
	local color = {r = "0", g = "0", b = "0", a = "0"}
	if TidyPlatesThreat.db.profile.castbarColor.toggle then
		color = TidyPlatesThreat.db.profile.castbarColor
	end
	return color.r, color.g, color.b, color.a
end

TidyPlatesThreat.SetCastbarColor = SetCastbarColor