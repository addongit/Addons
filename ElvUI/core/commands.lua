local E, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

-- enable or disable an addon via command
SlashCmdList.DISABLE_ADDON = function(s) DisableAddOn(s) ReloadUI() end
SLASH_DISABLE_ADDON1 = "/disable"
SlashCmdList.ENABLE_ADDON = function(s) EnableAddOn(s) LoadAddOn(s) ReloadUI() end
SLASH_ENABLE_ADDON1 = "/enable"

-- switch to heal layout via a command
local function HEAL()
	DisableAddOn("ElvUI_Dps_Layout")
	EnableAddOn("ElvUI_Heal_Layout")
	ReloadUI()
end
SLASH_HEAL1 = "/heal"
SlashCmdList["HEAL"] = HEAL

-- switch to dps layout via a command
local function DPS()
	DisableAddOn("ElvUI_Heal_Layout");
	EnableAddOn("ElvUI_Dps_Layout")
	ReloadUI()
end
SLASH_DPS1 = "/dps"
SlashCmdList["DPS"] = DPS

-- enable lua error by command
function SlashCmdList.LUAERROR(msg, editbox)
	if (msg == 'on') then
		SetCVar("scriptErrors", 1)
		-- because sometime we need to /rl to show error.
		ReloadUI()
	elseif (msg == 'off') then
		SetCVar("scriptErrors", 0)
	else
		print("/luaerror on - /luaerror off")
	end
end
SLASH_LUAERROR1 = '/luaerror'

function DisbandRaidGroup()
		if InCombatLockdown() then return end -- Prevent user error in combat
		
		SendChatMessage(L.disband, "RAID" or "PARTY")
		if UnitInRaid("player") then
			for i = 1, GetNumRaidMembers() do
				local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
				if online and name ~= E.myname then
					UninviteUnit(name)
				end
			end
		else
			for i = MAX_PARTY_MEMBERS, 1, -1 do
				if GetPartyMember(i) then
					UninviteUnit(UnitName("party"..i))
				end
			end
		end
		LeaveParty()
end

SlashCmdList["GROUPDISBAND"] = function()
	StaticPopup_Show("DISBAND_RAID")
end
SLASH_GROUPDISBAND1 = '/rd'

-- farm mode
local farm = false
local minisize = 250
local minisize2 = 250
function SlashCmdList.FARMMODE(msg, editbox)
	if farm == false then
		minisize = Minimap:GetWidth()
		if MinimapMover then
			minisize2 = MinimapMover:GetWidth()
			MinimapMover:SetSize(250, 250)
		end
		Minimap:SetSize(250, 250)
		farm = true
	else
		if MinimapMover then
			MinimapMover:SetSize(minisize2, minisize2)
		end	
		Minimap:SetSize(minisize, minisize)
		farm = false
	end

	ElvuiMinimapStatsLeft:SetWidth((Minimap:GetWidth() / 2) - 1)
	ElvuiMinimapStatsRight:SetWidth((Minimap:GetWidth() / 2) - 1)
	
	if E.Movers["AurasMover"]["moved"] ~= true then
		AurasMover:ClearAllPoints()
		AurasMover:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", E.Scale(-8), E.Scale(2))
	end	
end
SLASH_FARMMODE1 = '/farmmode'


--	GM toggle command
SLASH_GM1 = "/gm"
SlashCmdList["GM"] = function() ToggleHelpFrame() end

-- Print list of commands to chat
SLASH_UIHELP1 = "/UIHelp"
SlashCmdList["UIHELP"] = E.UIHelp

--ReInstall UI
SLASH_CONFIGURE1 = "/installui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("INSTALL_UI") end

-- Command to Toggle showing the UI Movers
SLASH_MOVEUI1 = '/moveui'
SlashCmdList.MOVEUI = function()		
	E.ToggleMovers()
	
	if C["actionbar"].enable == true then
		E.ToggleABLock()
	end
	
	if oUF then
		E.MoveUF()
	end
	
	if ElvuiInfoLeftRButton.hovered == true then
		local locked = false
		GameTooltip:ClearLines()
		for name, _ in pairs(E.CreatedMovers) do
			if _G[name]:IsShown() then
				locked = true
			else
				locked = false
			end
		end	
		
		if locked ~= true then
			GameTooltip:AddLine(UNLOCK.." "..BUG_CATEGORY5,1,1,1)
		else
			GameTooltip:AddLine(LOCK.." "..BUG_CATEGORY5,unpack(C["media"].valuecolor))
		end
	end
end

-- Command to reset the movers
SLASH_RESETMOVERS1 = '/resetui'
SlashCmdList.RESETMOVERS = function(arg) 
	if arg ~= "uf" then
		E.ResetMovers(arg) 
	end
	
	if oUF and (arg == nil or arg == "" or arg == "uf") then 
		StaticPopup_Show("RESET_UF") 
	end 
end

--Command to fix the Combat Log if it breaks
local function CLFIX()
	CombatLogClearEntries()
end
SLASH_CLFIX1 = "/clfix"
SlashCmdList["CLFIX"] = CLFIX