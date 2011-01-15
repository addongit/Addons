local OverLayTimers = {};
local OverLayUpdater = 0.2;
local OverLayTimersActive = 0;
local alreadywarned = {};
local OverLayRemap = {
	[88843] = 19615,
	[93426] = 91342,
	[60349] = 53817,
};
SpellOverlayTimerConfig = {};
function SpellOverlayTimer_Init()
	SpellOverlayTimer_timer:UnregisterEvent("ADDON_LOADED");
	hooksecurefunc("SpellActivationOverlay_ShowOverlay", SpellOverlayTimer_OverlayTimerShow);
	hooksecurefunc("SpellActivationOverlay_HideOverlays",SpellOverlayTimer_OverlayTimerHide);
	SpellOverlayTimerConfig:Init();

end


function SpellOverlayTimer_GetBuffTimeLeft(spellid,onwho)
	local i = 1;
	local name, _, _, _, _, _, buff_expiretime, _, _, _, buff_spellid  = UnitBuff(onwho, i);
	while name  do
	 i = i +1;
	 if(buff_spellid==spellid) then
		return floor((GetTime()-buff_expiretime)*-1);
	 end
	--if(onwho=="pet") then
	--	print("d:"..buff_spellid);
	--end
	 
	 name, _, _, _, _, _, buff_expiretime, _, _, _, buff_spellid  = UnitBuff(onwho, i);
	end
	
	return false;
end

function SpellOverlayTimer_OverlayTimerShow(...)
	if (GetCVarBool("displaySpellActivationOverlays") == false ) then
		return;
	end
	local self, spellID, texturePath, position, scale, r, g, b, vFlip, hFlip = ...;
	local checkwho = "player";
	local origoverlay = SpellActivationOverlay_GetOverlay(self, spellID, position);
	if(OverLayRemap[spellID]) then
		spellID = OverLayRemap[spellID];
	end
	local timeleft = SpellOverlayTimer_GetBuffTimeLeft(spellID,checkwho);
	if(timeleft == false) then
		checkwho = "pet";
		timeleft = SpellOverlayTimer_GetBuffTimeLeft(spellID,checkwho);
	end
	if(timeleft == false) then
		if not (alreadywarned[spellID]) then
			print("|c00FF0000SpellOverlayTimer: |c00FFFFFFCan not find timer infos for spellid "..spellID..", please report this.");
			alreadywarned[spellID] = 1;
		end
		return;
	end
	
	if not(OverLayTimers[spellID]) then
		local OverlayTimer = SpellOverlayTimer_timer:CreateFontString( spellid, "ARTWORK", "CombatTextFont" );
		OverlayTimer:SetText( timeleft.." s" );
		OverLayTimers[spellID] = {};
		OverLayTimers[spellID].position = position;
		OverLayTimers[spellID].overlay = OverlayTimer;
		OverLayTimers[spellID].active = false;
		OverLayTimers[spellID].checkwho = checkwho;
	end
	if(OverLayTimers[spellID].active == false) then
		OverLayTimersActive = OverLayTimersActive +1;
	end
	OverLayTimers[spellID].active = true;
	OverLayTimers[spellID].overlay:ClearAllPoints();
	if(OverLayTimers[spellID].position ~= position) then
		OverLayTimers[spellID].overlay:SetPoint( "CENTER",  origoverlay, SpellOverlayTimer_Config.FontPosition , 135,0);
	else
		OverLayTimers[spellID].overlay:SetPoint( "CENTER",  origoverlay, SpellOverlayTimer_Config.FontPosition);
	end
	OverLayTimers[spellID].overlay:SetTextColor(unpack(SpellOverlayTimer_Config.FontColor));
	OverLayTimers[spellID].overlay:SetTextHeight(SpellOverlayTimer_Config.FontSize);
	OverLayTimers[spellID].overlay:Show();
	if(OverLayTimersActive==1) then
		SpellOverlayTimer_timer:SetScript("OnUpdate", SpellOverlayTimer_TimerEvent);
	end
end

function SpellOverlayTimer_OverlayTimerHide(...)
	
	if (GetCVarBool("displaySpellActivationOverlays") == false ) then
		return;
	end
	local self,spellid = ...;
	if(OverLayRemap[spellid]) then
		spellid = OverLayRemap[spellid];
	end
	if not(OverLayTimers[spellid]) then
		return;
	end
	OverLayTimers[spellid].active = false;
	OverLayTimers[spellid].overlay:Hide();
	OverLayTimersActive = OverLayTimersActive-1;
	if(OverLayTimersActive==0) then
		SpellOverlayTimer_timer:SetScript("OnUpdate", nil);
	end
end


function SpellOverlayTimer_TimerEvent(self,elapsed)
	OverLayUpdater = OverLayUpdater - elapsed;
	if(OverLayUpdater > 0 or OverLayTimersActive==0) then
		return;
	else
		OverLayUpdater = 0.2;
	end
	if(OverLayTimers) then
		for index,value in pairs(OverLayTimers) do 
			local timeleft = SpellOverlayTimer_GetBuffTimeLeft(index,value.checkwho);
			if(timeleft) then
				value.overlay:SetText(timeleft.." s" );
			end
		end
	
	end
end

function SpellOverlayTimer_OnEvent(self, event, ...)
	local arg1 = ...;
	if(arg1=="SpellOverlayTimer") then
		SpellOverlayTimer_Init();
	end
end


SpellOverlayTimer_timer = CreateFrame("FRAME");
SpellOverlayTimer_timer:SetScript("OnEvent", SpellOverlayTimer_OnEvent);
SpellOverlayTimer_timer:RegisterEvent("ADDON_LOADED");
