TukuiDB = ElvDB
TukuiCF = ElvCF

TukuiMinimap = ElvuiMinimap
TukuiActionBarBackground = ElvuiActionBarBackground
TukuiInfoLeft = ElvuiInfoLeft
TukuiInfoRight = ElvuiInfoRight

if IsAddOnLoaded("ElvUI_Dps_Layout") then
	oUF_Tukz_player = ElvDPS_player
	oUF_Tukz_target = ElvDPS_target
	oUF_Tukz_focus = ElvDPS_focus
elseif IsAddOnLoaded("ElvUI_Heal_Layout") then
	oUF_Tukz_player = ElvHeal_player
	oUF_Tukz_target = ElvHeal_target
	oUF_Tukz_focus = ElvHeal_focus
end