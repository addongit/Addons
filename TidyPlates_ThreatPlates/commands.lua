--[[TPTP Tank Toggle Command]]--
local Active = function() return GetActiveTalentGroup() end
function toggleDPS()
	setSpecDPS(Active())
	TidyPlatesThreat.db.char.threat.tanking = false
	TidyPlatesThreat.db.profile.threat.ON = true
	if TidyPlatesThreat.db.profile.verbose then
	print("-->>|cffff0000DPS Plates Enabled|r<<--")
	print("|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cff89F559"..dualSpec().."|r spec and are now in your |cffff0000dpsing / healing|r role.")
	end
	TidyPlates:ForceUpdate()
end
function toggleTANK()
	setSpecTank(Active())	
	TidyPlatesThreat.db.char.threat.tanking = true
	TidyPlatesThreat.db.profile.threat.ON = true
	if TidyPlatesThreat.db.profile.verbose then
	print("-->>|cff00ff00Tank Plates Enabled|r<<--")
	print("|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff89F559"..dualSpec().."|r spec and are now in your |cff00ff00tanking|r role.")
	end
	TidyPlates:ForceUpdate()
end
local function TPTPDPS()
	toggleDPS()
end
SLASH_TPTPDPS1 = "/tptpdps"
SlashCmdList["TPTPDPS"] = TPTPDPS
local function TPTPTANK()
	toggleTANK()
end
SLASH_TPTPTANK1 = "/tptptank"
SlashCmdList["TPTPTANK"] = TPTPTANK
local function TPTPTOGGLE()
	TidyPlatesThreat.db.char.threat.tanking = not TidyPlatesThreat.db.char.threat.tanking
	if TidyPlatesThreat.db.char.threat.tanking then 
		toggleTANK()
	else
		toggleDPS()
	end
end
SLASH_TPTPTOGGLE1 = "/tptptoggle"
SlashCmdList["TPTPTOGGLE"] = TPTPTOGGLE
local function TPTPOVERLAP()
	SetCVar("spreadnameplates",abs(GetCVar("spreadnameplates")-1))
	if GetCVar("spreadnameplates") == "0" and TidyPlatesThreat.db.profile.verbose then
		print("-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--")
	else
		print("-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--")
	end
end
SLASH_TPTPOVERLAP1 = "/tptpol"
SlashCmdList["TPTPOVERLAP"] = TPTPOVERLAP
local function TPTPVERBOSE()
	TidyPlatesThreat.db.profile.verbose = not TidyPlatesThreat.db.profile.verbose
	if TidyPlatesThreat.db.profile.verbose then
		print("-->>Threat Plates verbose is now |cff00ff00ON!|r<<--")
	else
		print("-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!")
	end
end
SLASH_TPTPVERBOSE1 = "/tptpverbose"
SlashCmdList["TPTPVERBOSE"] = TPTPVERBOSE