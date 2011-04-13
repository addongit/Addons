 --Mage Nuggets 2.091 by B-Buck (Bbuck of Eredar)

MageNugz = {
  spMonitorToggle = false;
  spCombatToggle = false;
  ssMonitorToggle = true;
  mageProcToggle = true;
  camZoomTogg = true;
  mirrorImageToggle = true;
  mageArmorToggle = true;
  evocationToggle = true;
  livingBombToggle = true;
  procMonitorToggle = true;
  arcaneBlastToggle = true;
  abCastTimeToggle = true;
  minimapToggle = true;
  buffmonToggle = false;
  polyToggle = true;
  spMonitorSize = 3;
  ssMonitorSize = 3;
  mgCombatTog = false;
  procMonitorSize = 3;
  livingBCounterSize = 3;
  lockFrames = false;
  borderStyle = 0;
  transColor = 0;
  consoleTextEnabled = true;
  slowfallMsg = "Slowfall Cast On You";
  slowfallMsg2 = "Slowfall Cast On You";
  slowfallMsg3 = "Slowfall Cast On You";
  focusMagicNotify = "Focus Magic Cast On You";
  focusMagicNotify2 = "Focus Magic Cast On You";
  focusMagicNotify3 = "Focus Magic Cast On You";
  focusMagicThanks = "Thanks For Focus Magic";
  focusMagicThanks2 = "Thanks For Focus Magic";
  innervatThanks = "Thanks For The Innervate";
  innervatThanks2 = "Thanks For The Innervate";
  powerinfThanks = "Thanks For Power Infusion";
  darkIntentThanks = "Thanks For Dark Intent";
  backdropR = 0.0;
  backdropG = 0.0;
  backdropB = 0.0;
  backdropA = 0.0;
  MinimapPos = 45;
  miSound = "mirror.mp3";
  miSoundToggle = true;
  procSound = "proc.mp3";
  polySound = "sheep.mp3";
  hsSound = "hotstreak.mp3";
  impactSound = "impact.mp3";
  fofSound = "fof.mp3";
  brainfreezeSound = "brainfreeze.mp3";
  procSoundToggle = true;
  polySoundToggle = true;
  hsSoundToggle = true;
  impactSoundToggle = true;
  fofSoundToggle = true;
  brainfreezeSoundToggle = true;
  toolTips = true;
  clearcastToggle = true;
  managemToggle = true;
  clickthru = false;
  polyFrameSize = 3;
  msgToggle = true;
  cooldownToggle = false;
  apCooldown = true;
  bwCooldown = true;
  cbCooldown = true;
  csCooldown = true;
  dfCooldown = true;
  dbCooldown = true;
  mwCooldown = true;
  miCooldown = true;
  frzCooldown = true;
  msCooldown = true;
  ibrCooldown = true;
  evoCooldown = true;
  ivCooldown = true;
  cooldownSize = 3;
  moonkinTog = false;
  moonkinSize = 3;
  moonkinCombat = false;
  treantSoundTog = true;
  treantSound = "mirror.mp3";
  moonkinProcTog = true;
  innervatNotify = "Innervate Cast On You!";
  castBoxes = true;
  igniteTog = true;
  moonkinProcSize = 3;
  starfallCooldown = true;
  treantCooldown = true;
  moonkinMin = false;
  moonkinAnchorTog = true;
  cauterizeToggle = true;
  moonkinBoxTog = true;
}

local livingBombCount = 0;
local mirrorImageTime = 0;
local livingbombGlobalTime = 0;
local livingbombTime = 0;
local livingbombTime2 = 0;
local livingbombTime3 = 0;
local livingbombTime4 = 0;
local lbTargetId1 = " ";
local lbTargetId2 = " ";
local lbTargetId3 = " ";
local lbTargetId4 = " ";
local spellStealTog = 0;
local misslebTog = 0;
local mageProcSSTime = 0;
local mageProcHSTime = 0;
local mageProcMBTime = 0;
local mageProcBFTime = 0
local fofProgMonTime = 0;
local mageImpProgMonTime = 0;
local combatTextCvar = GetCVar("enableCombatText");
local abProgMonTime = 0;
local ttwFlag = false;
local abCastTime = 2.5;
local abStackCount = 0;
local polyTimer = 0;
local scorchTime = 0;
local icyTimer = 0;
local apTimer = 0;
local lustTimer = 0;
local clearcastTime = 0;
local managemCooldown = 0;
local moonfireTime = 0;
local insectTime = 0;
local starsurgeTime = 0;
local moonkinCombatText = 0;
local incombat = 0;
local talentSpec = "damage";
local mnplayerClass = " "
local mnenglishClass = " "
local sstimeleft = 0;
local igniteTemp = 0;
local ignitetimer = 0;
local cauterizeTime = 0;

function MN_Start(self)
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("CVAR_UPDATE")
    self:RegisterEvent("VARIABLES_LOADED")
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("CONFIRM_TALENT_WIPE")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_TALENT_UPDATE")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_UPDATE_RESTING")
    MageNuggetsOptions()
    SlashCmdList['MAGENUGGETS_SLASHCMD'] = MageNuggets_SlashCommandHandler
    SLASH_MAGENUGGETS_SLASHCMD1 = "/magenuggets"
end

function MageNuggets_SlashCommandHandler(msg) --Handles the slash commands
    if (msg == "options") then
	    InterfaceOptionsFrame_OpenToCategory("Mage Nuggets");
    elseif (msg == "ports") then
        MageNuggets_Minimap_OnClick(); 
    else
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff------------|cff00BFFF".."Mage".." |cff00FF00".."Nuggets".."|cffffffff 2.091--------------")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/magenuggets".." ".."options (Shows Option Menu)")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/magenuggets".." ".."ports (Shows Portal Menu)")
    end
end
--
local MN_UpdateInterval = 0.25;
function MageNuggets_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > MN_UpdateInterval) then
    if (spellStealTog >= 1) then 
        spellStealTog = spellStealTog - 1;
    else
        if (MageNugz.ssMonitorToggle == true) then
            if(mnenglishClass == 'MAGE')then
                local stealableBuffs, i = { }, 1;
                local buffName, _, _, _, _, _, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                while buffName do
                    if(isStealable == 1) then
                        if(expirationTime ~= nil)then
                            sstimeleft = RoundZero(expirationTime - GetTime());    
                            if (sstimeleft > 60) then
                                sstimeleft = "+60";
                            end
                        end
                        stealableBuffs[#stealableBuffs + 1] = buffName.."  "..sstimeleft.."s";
                    end
                    i = i + 1;
                    buffName, _, _, _, _, _, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                end
                if (#stealableBuffs < 1) then
                    MNSpellSteal_Frame:Hide(); 
                else
                    MNSpellSteal_Frame:Show(); 
                    stealableBuffs = table.concat(stealableBuffs, "\n");
                    MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs);
                end
            end
            -----------
            local stealableBuffs2, i = { }, 1;
            local buffName2, _, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
            while buffName2 do
                if(isStealable2 == 1) then
                    if(expirationTime2 ~= nil)then
                        sstimeleft2 = RoundZero(expirationTime2 - GetTime());    
                        if (sstimeleft2 > 60) then
                             sstimeleft2 = "+60";
                        end
                    end
                    stealableBuffs2[#stealableBuffs2 + 1] = buffName2.."  "..sstimeleft2.."s";
                end
                i = i + 1;
                buffName2, _, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
            end
            if (#stealableBuffs2 < 1) then
                MNSpellStealFocus_Frame:Hide(); 
            else
                MNSpellStealFocus_Frame:Show(); 
                stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs2);
            end
            -----------
            if(mnenglishClass == 'SHAMAN')then
                if(UnitCanAttack("player", "target"))then
                    local purgeableBuffs, i = { }, 1;
                    local buffName1, _, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                    while buffName1 do
                        if(debuffType1 == "Magic") then
                            purgeableBuffs[#purgeableBuffs + 1] = buffName1;
                        end
                        i = i + 1;
                        buffName1, _, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                    end
                    if (#purgeableBuffs < 1) then
                        MNSpellSteal_Frame:Hide(); 
                    else
                        MNSpellSteal_Frame:Show(); 
                        purgeableBuffs = table.concat(purgeableBuffs, "\n");
                        MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..purgeableBuffs);
                    end
                else
                    MNSpellSteal_Frame:Hide(); 
                end
            end
        end
    end
  self.TimeSinceLastUpdate = 0;
  end
end     
--------------------------------------------------------------------
function MageNuggetsHS_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (mageProcHSTime >= 0) then
            mageProcHSTime = RoundOne(mageProcHSTime - 0.1);
            MageNugProcFrame_ProcBar:SetValue(mageProcHSTime)
            MageNugProcFrameText2:SetText(mageProcHSTime)
            local position = (MageNugProcFrame_ProcBar:GetValue() / 14 * 120);
            MageNugProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
            if (mageProcHSTime <= 0) then
                MageNugProcFrame:Hide()
                MageNugProcFrame_ProcBar:SetValue(15)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsMB_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (mageProcMBTime >= 0) then
            mageProcMBTime = RoundOne(mageProcMBTime - 0.1);
            MageNugMBProcFrame_ProcBar:SetValue(mageProcMBTime)
            MageNugMBProcFrameText2:SetText(mageProcMBTime)
            local position = (MageNugMBProcFrame_ProcBar:GetValue() / 20 * 120);
            MageNugMBProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugMBProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
            if (mageProcMBTime <= 0.1) then
                MageNugMBProcFrame:Hide()
                MageNugMBProcFrame_ProcBar:SetValue(14)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsBF_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (mageProcBFTime >= 0) then
            mageProcBFTime = RoundOne(mageProcBFTime - 0.1);
            MageNugBFProcFrame_ProcBar:SetValue(mageProcBFTime)
            MageNugBFProcFrameText2:SetText(mageProcBFTime)
            local position = (MageNugBFProcFrame_ProcBar:GetValue() / 14 * 120);
            MageNugBFProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugBFProcFrame_ProcBar,"BOTTOMLEFT",position - 10, -6);
            if (mageProcBFTime <= 0) then
                MageNugBFProcFrame:Hide()
                MageNugBFProcFrame_ProcBar:SetValue(15)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--    
function MageNuggetsAB_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        local _, _, _, _, _, _, castTime, _, _ = GetSpellInfo(30451)
        MNabCast_FrameText:SetText(RoundThree(castTime * 0.001))
        if (abProgMonTime >= 0) then
            abProgMonTime = RoundOne(abProgMonTime - 0.1);
            MageNugAB_Frame_ABBar:SetValue(abProgMonTime)
            MageNugAB_FrameText2:SetText("|cffFFFFFF"..abProgMonTime)
            if (abProgMonTime <= 0) then
                MageNugAB_Frame:Hide()
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--   
function MageNuggetsLB_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (livingbombGlobalTime >= 0) then
            livingbombGlobalTime = RoundOne(livingbombGlobalTime - 0.1);
            if (livingbombGlobalTime <= 0) then
               livingBombCount = 0;
               MageNugLB_Frame:Hide();
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsLB1_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (livingbombTime >= 0) then
            livingbombTime = RoundOne(livingbombTime - 0.1);
            MageNugLB1_Frame_Bar:SetValue(livingbombTime)
            MageNugLB1_Frame_Text:SetText(livingbombTime)
            local position = (MageNugLB1_Frame_Bar:GetValue() / 13 * 99);
            MageNugLB1_Frame_BarSpark:SetPoint("BOTTOMLEFT",MageNugLB1_Frame_Bar,"BOTTOMLEFT",position - 6, -6);
            if (livingbombTime <= 0) then
                MageNugLB1_Frame:Hide();
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsLB2_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (livingbombTime2 >= 0) then
            livingbombTime2 = RoundOne(livingbombTime2 - 0.1);
            MageNugLB2_Frame_Bar:SetValue(livingbombTime2)
            MageNugLB2_Frame_Text:SetText(livingbombTime2)
            local position = (MageNugLB2_Frame_Bar:GetValue() / 13 * 99);
            MageNugLB2_Frame_BarSpark:SetPoint("BOTTOMLEFT",MageNugLB2_Frame_Bar,"BOTTOMLEFT",position - 6, -6);
            if (livingbombTime2 <= 0) then
                MageNugLB2_Frame:Hide();
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsLB3_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (livingbombTime3 >= 0) then
            livingbombTime3 = RoundOne(livingbombTime3 - 0.1);
            MageNugLB3_Frame_Bar:SetValue(livingbombTime3)
            MageNugLB3_Frame_Text:SetText(livingbombTime3)
            local position = (MageNugLB3_Frame_Bar:GetValue() / 13 * 99);
            MageNugLB3_Frame_BarSpark:SetPoint("BOTTOMLEFT",MageNugLB3_Frame_Bar,"BOTTOMLEFT",position - 6, -6);
            if (livingbombTime3 <= 0) then
                MageNugLB3_Frame:Hide();
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsLB4_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (livingbombTime4 >= 0) then
            livingbombTime4 = RoundOne(livingbombTime4 - 0.1);
            MageNugLB4_Frame_Bar:SetValue(livingbombTime4)
            MageNugLB4_Frame_Text:SetText(livingbombTime4)
            local position = (MageNugLB4_Frame_Bar:GetValue() / 13 * 99);
            MageNugLB4_Frame_BarSpark:SetPoint("BOTTOMLEFT",MageNugLB4_Frame_Bar,"BOTTOMLEFT",position - 6, -6);
            if (livingbombTime4 <= 0) then
                MageNugLB4_Frame:Hide();
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsClearCast_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (clearcastTime >= 0) then
            clearcastTime = RoundOne(clearcastTime - 0.1);
            MageNugClearcast_Frame_Bar:SetValue(clearcastTime)
            MageNugClearcast_FrameText2:SetText(clearcastTime)
            if (clearcastTime <= 0) then
                MageNugClearcast_Frame:Hide();
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsIgnite_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (ignitetimer > 0) then
            ignitetimer = ignitetimer - 0.1;
            if(ignitetimer < 2.1) then
                local igntemp = RoundZero(igniteTemp / 2);
                MageNugIgnite_FrameText:SetText(igntemp);
                
            
            end
            MageNugIgnite_Frame_Bar:SetValue(ignitetimer);
            MageNugIgnite_FrameText2:SetText(RoundOne(ignitetimer));
            
        else  
            MageNugIgnite_Frame:Hide();   
       
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCritMass_OnUpdate(self, elapsed)  
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if(scorchTime >= 0) then
            scorchTime = scorchTime - 1;
            MNcritMass_FrameText:SetText(scorchTime)
            if(scorchTime <= 0) then
                MNcritMass_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsMI_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (mirrorImageTime >= 0) then
            mirrorImageTime = mirrorImageTime - 1.0;
            MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
            MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
            if (mirrorImageTime <= 0) then
                MageNugMI_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCauterize_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (cauterizeTime >= 0) then
            cauterizeTime = cauterizeTime - 1.0;
            MageNugCauterize_Frame_Text1:SetText(" "..cauterizeTime)
            MageNugCauterize_Frame_Bar:SetValue(cauterizeTime)
            if (cauterizeTime <= 0) then
                MageNugCauterize_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsPoly_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (polyTimer >= 0) then
            polyTimer = RoundZero(polyTimer - 1.0);
            MageNugPolyFrameTimerText:SetText(polyTimer);
            MageNugPolyFrame_Bar:SetValue(polyTimer);
            if(polyTimer <= 0) then
                MageNugPolyFrame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--  
function MNManaGem_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.3) then   
        local count = GetItemCount(36799, nil, true)
        if (count ~= 0) then
            MageNugManaGem_Frame_Text:SetText("|cffffffff"..count)
        else
            local randomNum = math.random(1,2)
            if(randomNum == 1) then 
                MageNugManaGem_Frame_Text:SetText("|cffFF0000"..count)
            elseif(randomNum == 2) then
                MageNugManaGem_Frame_Text:SetText("|cffffffff"..count)
            end
        end
        local startTime, duration, enable = GetItemCooldown(36799);
        managemCooldown = RoundZero(startTime + duration - GetTime());
        if (managemCooldown > 0) then
            MageNugManaGem_Frame_Text2:SetText("|cffffffff"..managemCooldown.."s")
            MageNugManaGem_Frame_Bar:SetValue(managemCooldown)
        else
            if(count == 0) then
                local randomNum2 = math.random(1,2)
                if(randomNum2 == 1) then 
                    MageNugManaGem_Frame_Text2:SetText("|cffffffffEMPTY")
                    MageNugManaGem_Frame_Bar:SetValue(120)
                elseif(randomNum2 == 2) then
                    MageNugManaGem_Frame_Text2:SetText("|cffff0000EMPTY")
                    MageNugManaGem_Frame_Bar:SetValue(0)
                end
            else
                MageNugManaGem_Frame_Text2:SetText("|cffffffffREADY")
                MageNugManaGem_Frame_Bar:SetValue(120)
            end
        end    
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsIcy_OnUpdate(self, elapsed) 
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (icyTimer >= 0) then
            icyTimer = icyTimer - 1.0;
            MNicyveins_FrameText:SetText(icyTimer);
            if(icyTimer <= 0) then
                MNicyveins_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
function MageNuggetsGem_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (impGemTimer >= 0) then
            impGemTimer = impGemTimer - 1.0;
            MNimpGem_Frame_Text:SetText(impGemTimer);
            if(impGemTimer <= 0) then
                MNimpGem_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsLust_OnUpdate(self, elapsed) 
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (lustTimer >= 0) then
            lustTimer = lustTimer - 1.0;
            MNlust_FrameText:SetText(lustTimer);
            if(lustTimer <= 0) then
                MNlust_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
function MageNuggetsShootingStars_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (mageProcSSTime >= 0) then
            mageProcSSTime = RoundOne(mageProcSSTime - 0.1);
            MageNugSSProcFrame_ProcBar:SetValue(mageProcSSTime)
            MageNugSSProcFrameText2:SetText(mageProcSSTime)
            local position = (MageNugSSProcFrame_ProcBar:GetValue() / 8 * 120);
            MageNugSSProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugSSProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
            if (mageProcSSTime <= 0.1) then
                MageNugSSProcFrame:Hide()
                MageNugSSProcFrame_ProcBar:SetValue(8)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end       
--
function MageNuggetsArcaneP_OnUpdate(self, elapsed) 
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then   
        if (apTimer >= 0) then
            apTimer = apTimer - 1.0;
            MNarcanepower_FrameText:SetText(apTimer);
            if(apTimer <= 0) then
                MNarcanepower_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
function MageNuggetsFoF_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (fofProgMonTime >= 0) then
            local i = 1;
            local buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
            while buffName do
                if(spellId == 44544) then
                MageNugFoFProcFrameCountText:SetText("|cffffffff"..count)
                fofProgMonTime = RoundOne(expirationTime - GetTime());
                end
                i = i + 1;
                buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
            end
            MageNugFoFProcFrame_ProcBar:SetValue(fofProgMonTime)
            MageNugFoFProcFrameText2:SetText(fofProgMonTime)
            local position = (MageNugFoFProcFrame_ProcBar:GetValue() / 14 * 120);
            MageNugFoFProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugFoFProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
            if (fofProgMonTime <= 0) then
                MageNugFoFProcFrame:Hide()
                MageNugFoFProcFrame_ProcBar:SetValue(14)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
function MageNuggetsImpact_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        if (mageImpProgMonTime >= 0) then
            mageImpProgMonTime = RoundOne(mageImpProgMonTime - 0.1);
            MageNugImpactProcFrame_ProcBar:SetValue(mageImpProgMonTime)
            MageNugImpactProcFrameText2:SetText(mageImpProgMonTime)
            local position = (MageNugImpactProcFrame_ProcBar:GetValue() / 9 * 120);
            MageNugImpactProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugImpactProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
            if (mageImpProgMonTime <= 0) then
                MageNugImpactProcFrame:Hide()
                MageNugImpactProcFrame_ProcBar:SetValue(9)        
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
function MageNuggetsSP_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > 1.0) then   
   
    if (ttwFlag == false) then
        MNTorment_Frame:Hide();
    end
    local _, _, _, _, currRank11, _ = GetTalentInfo(1,4); --torment the weak
    local _, _, _, _, combstRank, _ = GetTalentInfo(2,13); --combustion
    local spellHit = RoundCrit(GetCombatRatingBonus(8));
    local critRating = RoundCrit(GetSpellCritChance(3));
    local hasteRating = ((GetCombatRatingBonus(20)/100) + 1);
    local mastery = 0;
    local combustCount = 0;
    local masteryText = " "
    local adept = 0;
    if(mnenglishClass == 'MAGE') then
        local _, _, _, _, arcanePoints = GetTalentTabInfo(1);
        local _, _, _, _, firePoints = GetTalentTabInfo(2);   
        local _, _, _, _, frostPoints = GetTalentTabInfo(3);
        if (arcanePoints > firePoints) and (arcanePoints > frostPoints)then
            mastery = ((GetCombatRatingBonus(26)+8)*1.5);
            adept = UnitMana("Player") / UnitManaMax("Player");
            mastery = RoundCrit(mastery * adept);
            masteryText = "|cff9966FFAdept";
        elseif(firePoints > arcanePoints) and (firePoints > frostPoints) then
            mastery = ((GetCombatRatingBonus(26)+8)*2.8);
            mastery = RoundCrit(mastery)
            masteryText = "|cffFF3300Burn";
        elseif(frostPoints > arcanePoints) and (frostPoints > firePoints) then
            mastery = ((GetCombatRatingBonus(26)+2)*2.5);
            mastery = RoundCrit(mastery)
            masteryText = "|cff66CCFFBurn";
        else
            masteryText = "|cffFFFFFFMstry";
        end
    else
        masteryText = "|cffFFFFFFMstry";
        mastery = RoundCrit(GetCombatRatingBonus(26)+8)
    end
    if(mnenglishClass == 'DRUID') then
        local nameD, _, _, _, moonkinRank, _ = GetTalentInfo(1,8) --moonkin form 
        if (moonkinRank == 1) then
            mastery = ((GetCombatRatingBonus(26)+8)*1.5);
            mastery = RoundCrit(mastery);
            masteryText = "|cff33FF33T.E.";
        else
            masteryText = "|cffFFFFFFMstry";
        end
    end
    local mnRace = UnitRace("player");
    local j = 1;
    local jj = 1;
    local h = 1;
    ttwFlag = false;
    local buffName3, rank3, _, count3, _, duration3, expirationTime3, _, _, _, spellId3 = UnitAura("target", j, "HARMFUL");
    while buffName3 do
        if (MageNugz.buffmonToggle == false) then
            if (currRank11 == 3) or (currRank11 == 2) or (currRank11 == 1) then
                if(spellId3 == 31589) or (spellId3 == 55095) or (spellId3 == 45524) or (spellId3 == 12323) or (spellId3 == 18223) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                elseif (spellId3 == 3600) or (spellId3 == 13809) or (spellId3 == 2974) or (spellId3 == 25809) or (spellId3 == 1715) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                elseif (buffName3 == frostboltId) or (buffName3 == conecoldId) or (buffName3 == blastwaveId) or (buffName3 == frostfireId) or (buffName3 == chilledId) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                elseif (buffName3 == judgementjustId) or (buffName3 == infectedwoundsIdthen) or (buffName3 == thunderclapId) or (buffName3 == deadlythrowId) or (buffName3 == frostshockId) or (buffName3 == mindflayId) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                end
            end
        end   
        if(spellId3 == 22959) or (spellId3 == 17800) then --critical mass and shadow and flame
            critRating = critRating + 5.0;
            if (MageNugz.buffmonToggle == false) then
                scorchTime = RoundZero(expirationTime3 - GetTime());
                MNcritMass_Frame:Show();
            end
        end
        if(spellId3 == 17800) then --shadow mastery
            critRating = critRating + 5.0;
        end
        j = j + 1;
        buffName3, rank3, _, count3, _, duration3, expirationTime3, _, _, _, spellId3 = UnitAura("target", j, "HARMFUL");
    end     
    local combName, combRank, _, combCount, _, _, _, _, _, _, combspellId = UnitAura("target", h, "PLAYER|HARMFUL");
    while combName do
        if (MageNugz.buffmonToggle == false) then
            if (combstRank == 1) then
                if(combspellId == 44457) then
                    combustCount = combustCount + 1;
                    MNcombust_FrameText:SetText(combustCount)
                    MNcombust_Frame:Show();            
                end
                if(combspellId == 12654) then
                    combustCount = combustCount + 1;
                    MNcombust_FrameText:SetText(combustCount)
                    MNcombust_Frame:Show();            
                end
                if(combspellId == 44614) then
                    combustCount = combustCount + 1;
                    MNcombust_FrameText:SetText(combustCount)
                    MNcombust_Frame:Show();            
                end
                if(combspellId == 11366) then
                    combustCount = combustCount + 1;
                    MNcombust_FrameText:SetText(combustCount)
                    MNcombust_Frame:Show();            
                end
                if(combspellId == 92315) then --pyroblast!
                    combustCount = combustCount + 1;
                    MNcombust_FrameText:SetText(combustCount)
                    MNcombust_Frame:Show();            
                end
                if(combspellId == 83853) then --combustion
                    combustCount = combustCount + 1;
                    MNcombust_FrameText:SetText(combustCount)
                    MNcombust_Frame:Show();            
                end
            end
        end
        h = h + 1;
        combName, combRank, _, combCount, _, _, _, _, _, _, combspellId = UnitAura("target", h, "PLAYER|HARMFUL");
    end 
    if (combustCount == 0) then
        MNcombust_Frame:Hide();
    end
    local buffName2, rank2, _, count2, _, _, _, _, _, _, spellId2 = UnitAura("player", jj, "HELPFUL");
    while buffName2 do
        if(spellId2 == 83582) then--Pyro
            local pyroname, _, _, _, pyroRank, _ = GetTalentInfo(2,19); --Pyro
            if (pyroRank == 1)then
                hasteRating = (hasteRating*1.05);
            else
                hasteRating = (hasteRating*1.10);
            end
        end
        if(spellId2 == 16886) then --natures grace
            local ngname, _, _, _, ngcurrRank, _ = GetTalentInfo(1,1) --natures grace 
            if(ngcurrRank == 3) then 
                hasteRating = (hasteRating*1.15);
            elseif (ngcurrRank == 2) then
                hasteRating = (hasteRating*1.10);
            elseif (ngcurrRank == 1) then
                hasteRating = (hasteRating*1.05);
            end   
        end
        if(spellId2 == 28878) then
            spellHit = spellHit + 1;
        end
        if(spellId2 == 6562) then
            spellHit = spellHit + 1;
        end
        if(spellId2 == 85767) or (spellId2 == 80398) or (spellId2 == 85768) then --Dark Intent
            hasteRating = (hasteRating*1.03);
        end     
        if(spellId2 == 49868) then --Mind Quickening
            hasteRating = (hasteRating*1.05);
        end           
            if(spellId2 == 10060) then --power infusion
                hasteRating = (hasteRating*1.20);
            end
            if(spellId2 == 70753) then --pushing the limit
                hasteRating = (hasteRating*1.12);
            end
            if(spellId2 == 2895) then --wrath of air tot
                hasteRating = (hasteRating*1.05);
            end
            if(spellId2 == 24907) then --Moonkin Aura
                hasteRating = (hasteRating*1.05);
            end
            if(spellId2 == 26297) then --berserking
                hasteRating = (hasteRating*1.20);
            end
            if(spellId2 == 12472) then --icy veins
                hasteRating = (hasteRating*1.20);
            end
            if(spellId2 == 2825) then --bloodlust
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 65980) then --bloodlust argent turny
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 32182) then --heroism
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 65983) then --heroism argent turny
                hasteRating = (hasteRating*1.30);
            end
            jj = jj + 1;
            buffName2, rank2, _, count2, _, _, _, _, _, _, spellId2 = UnitAura("player", jj, "HELPFUL");
        end 
        if(mnenglishClass == 'MAGE') then
            local _, _, _, _, currRank10, _ = GetTalentInfo(1,3); --netherwind presence
            if(currRank10 == 1) then
                hasteRating = (hasteRating*1.01);
            end
            if(currRank10 == 2) then
                hasteRating = (hasteRating*1.02);
            end
            if(currRank10 == 3) then
                hasteRating = (hasteRating*1.03);
            end
        end
        local race, raceEn = UnitRace("player");
        if(raceEn == "Draenei") then
            spellHit = spellHit + 1;
        end
        if(mnRace == "Goblin") then
            hasteRating = (hasteRating*1.01);
        end 
        if(spellHit >= 17.0) then
            spellHit = "capped";
        else
            spellHit = spellHit.."%";
        end
        hasteRating = RoundCrit((hasteRating - 1)*100)
        local regenbase, regencasting = GetManaRegen();
        if(talentSpec == "damage")then
            MageNugSP_FrameText:SetText("|cffFF0000SP:|cffFFFFFF"..GetSpellBonusDamage(3).."\n|cffFF6600Crit:|cffFFFFFF"..critRating.."%".."\n|cffCC33FFHaste:|cffFFFFFF"..hasteRating.."%".."\n|cffFFFF33 Hit:|cffFFFFFF"..spellHit.."\n"..masteryText..":|cffFFFFFF"..mastery.."%");
        else
            if(incombat == 1) then    
                MageNugSP_FrameText:SetText("|cffFF0000SP:|cffFFFFFF"..GetSpellBonusDamage(3).."\n|cffFF6600Crit:|cffFFFFFF"..critRating.."%".."\n|cffCC33FFHaste:|cffFFFFFF"..hasteRating.."%".."\n|cffFFFF33 Regen:|cffFFFFFF"..RoundZero(regencasting*5).."\n"..masteryText..":|cffFFFFFF"..mastery.."%");
            else
                MageNugSP_FrameText:SetText("|cffFF0000SP:|cffFFFFFF"..GetSpellBonusDamage(3).."\n|cffFF6600Crit:|cffFFFFFF"..critRating.."%".."\n|cffCC33FFHaste:|cffFFFFFF"..hasteRating.."%".."\n|cffFFFF33 Regen:|cffFFFFFF"..RoundZero(regenbase*5).."\n"..masteryText..":|cffFFFFFF"..mastery.."%");
            end
        end
    self.TimeSinceLastUpdate = 0;
   end
end   

function MageNuggets_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggets") then
            MNVariablesLoaded_OnEvent()
        end
    end  
    if (event == "PLAYER_TALENT_UPDATE") then
        MNtalentSpec();
    end
    if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
        MNtalentSpec();
        MageNugCD1_Frame_Bar:SetValue(0);
        MageNugCD1_Frame:Hide();
        MageNugCD2_Frame_Bar:SetValue(0);
        MageNugCD2_Frame:Hide();
        MageNugCD3_Frame_Bar:SetValue(0);
        MageNugCD3_Frame:Hide();
        MageNugCD4_Frame_Bar:SetValue(0);
        MageNugCD4_Frame:Hide();
        MageNugCD5_Frame_Bar:SetValue(0);
        MageNugCD5_Frame:Hide();
        MageNugCD6_Frame_Bar:SetValue(0);
        MageNugCD6_Frame:Hide();
        if(mnenglishClass == 'DRUID') then
            if(talentSpec == "healer") or (talentSpec == "feral")then
                MageNugMoonkinOptionFrame_CheckButton:SetChecked(1);
                MageNugz.moonkinTog = true;
                MageNugMoonkin_Frame:Hide()
                MNmoonFire_Frame:Hide()
                MNinsectSwarm_Frame:Hide()
                MNstarSurge_Frame:Hide()
            else
                if(MageNugz.moonkinBoxTog == true)then
                    if(MageNugz.moonkinTog == true) then
                        MageNugMoonkinToggle_Frame:Show();
                    end
                end
            end
        end
    end
     if (event == "CONFIRM_TALENT_WIPE") then
        MageNugCD1_Frame_Bar:SetValue(0);
        MageNugCD1_Frame:Hide();
        MageNugCD2_Frame_Bar:SetValue(0);
        MageNugCD2_Frame:Hide();
        MageNugCD3_Frame_Bar:SetValue(0);
        MageNugCD3_Frame:Hide();
        MageNugCD4_Frame_Bar:SetValue(0);
        MageNugCD4_Frame:Hide();
        MageNugCD5_Frame_Bar:SetValue(0);
        MageNugCD5_Frame:Hide();
        MageNugCD6_Frame_Bar:SetValue(0);
        MageNugCD6_Frame:Hide();
    end
    if (event == "PLAYER_REGEN_ENABLED") then       
        incombat = 0;
        if(mnenglishClass == 'DRUID') or (mnenglishClass == 'MAGE') then
            MageNugCD_Frame_Text:SetText(" ")
        end
        if (MageNugz.spMonitorToggle == false) then
            if (MageNugz.spCombatToggle == true) then
                MageNugSP_Frame:Hide();
            end
        end    
        if (MageNugz.moonkinTog == false) then
            if (MageNugz.moonkinCombat == true) then
                MageNugMoonkin_Frame:Hide();
                MNmoonFire_Frame:Hide()
                MNinsectSwarm_Frame:Hide()
                MNstarSurge_Frame:Hide()
            end
        end
        if(MageNugz.managemToggle == true) then
            if(MageNugz.mgCombatTog == true) then
                MageNugManaGem_Frame:Hide();
            end
        end        
        MageNugCastInsectFrame:Hide();
        MageNugCastMoonFrame:Hide();
        MageNugCastStarsurgeFrame:Hide();
    end
    if (event == "PLAYER_REGEN_DISABLED") then       
        incombat = 1;
        if(mnenglishClass == 'DRUID') or (mnenglishClass == 'MAGE') then
            MageNugCD_Frame_Text:SetText("c o o l d o w n s")
        end
        if (MageNugz.spMonitorToggle == false) then
            if (MageNugz.spCombatToggle == true) then
                MageNugSP_Frame:Show();
            end
        end
        if (MageNugz.moonkinTog == false) then
            if (MageNugz.moonkinCombat == true) then
                MageNugMoonkin_Frame:Show();
                MNmoonFire_Frame:Show()
                MNinsectSwarm_Frame:Show()
                MNstarSurge_Frame:Show()
            end
        end
        if(MageNugz.managemToggle == true) then
            if(MageNugz.mgCombatTog == true) then
                MageNugManaGem_Frame:Show();
            end
        end
        if(mnenglishClass == 'MAGE') and (MageNugz.mageArmorToggle == true) then
        local i1 = 1; 
        local isMageArmorOn = false;
        local buffNamei1, _, _, _, _, _, _, _, _, _, spellIdi1 = UnitAura("player", i1, "HELPFUL");
        while buffNamei1 do
            if(spellIdi1 == 7302) or (spellIdi1 == 6117) or (spellIdi1 == 30482) then
                isMageArmorOn = true;
            end
            i1 = i1 + 1;
            buffNamei1, _, _, _, _, _, _, _, _, _, spellIdi1 = UnitAura("player", i1, "HELPFUL");
        end
        if (isMageArmorOn == false) then
            if(combatTextCvar == '1') then
                if (MageNugz.mageProcToggle == true) then
                    CombatText_AddMessage("BUFF MISSING: Mage Armor!", CombatText_StandardScroll, 1.0, 0, 0, "crit", isStaggered, nil);
			    end
            end
            if (MageNugz.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."BUFF MISSING: Mage Armor!")
            end
        end
        end
    end  
    if (event == "CVAR_UPDATE") then
        combatTextCvar = GetCVar("enableCombatText")
    end
    if (event == "PLAYER_ENTERING_WORLD") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
    end
    if (event == "PLAYER_UPDATE_RESTING") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
    end
    if (event == "COMBAT_LOG_EVENT_UNFILTERED")then   
        local _, event1, _, sourceName, _, destGUID, destName, _ = select(1, ...) 
        local arg, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = select(9, ...) 
		local spellId1 = select(12, ...)     
        if (event1 == "SPELL_AURA_APPLIED_DOSE") and (sourceName == UnitName("player")) then
            if(arg == 36032) then
                abStackCount = abStackCount + 1;
                abProgMonTime = 6;
                MageNugAB_FrameText:SetText("|cffFF00FF"..abStackCount)
                MageNugAB_Frame_ABBar:SetValue(abProgMonTime)
            end
        end
        if(MageNugz.igniteTog == true)then
            if((event1 == "SPELL_PERIODIC_DAMAGE") and (sourceName == UnitName("player")))then
                if((arg10 == 1) and (arg6 == 4)) then
                    if(destGUID == UnitGUID("target")) and (arg ~= 12654) then   
                        local mastertemp = ((GetCombatRatingBonus(26)+8)*2.8)
                        igniteTemp = RoundZero((arg4 * 0.40)*(1+(0.01 * mastertemp)));
                        ignitetimer = 5.0;
                        MageNugIgnite_FrameText:SetText(igniteTemp);
                        MageNugIgnite_Frame:Show();
                    end
                end
            end
            if((event1 == "SPELL_DAMAGE") and (sourceName == UnitName("player")))then
                if((arg10 == 1) and (arg6 == 4))then
                    if(destGUID == UnitGUID("target")) then  
                        local mastertemp = ((GetCombatRatingBonus(26)+8)*2.8)
                        igniteTemp = RoundZero((arg4*0.40)*(1+(0.01*mastertemp)));
                        ignitetimer = 5.0;   
                        MageNugIgnite_FrameText:SetText(igniteTemp);
                        MageNugIgnite_Frame:Show();
                    end
                end
            end
        end
        if (event1 == "SPELL_DISPEL") and (sourceName == UnitName("player")) then
            if (MageNugz.ssMonitorToggle == true) then
                if(combatTextCvar == '1') then
                    CombatText_AddMessage("Dispelled"..":"..GetSpellLink(spellId1), CombatText_StandardScroll, 0.10, 0, 1, "sticky", nil);
                end
                if (MageNugz.consoleTextEnabled == true) then
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF".."Dispelled"..":"..GetSpellLink(spellId1))
	    	    end
            end
        end
        if (event1 == "SPELL_AURA_REFRESH") and (sourceName == UnitName("player")) then
            if(arg == 79683) then -- Arcane Missiles!
                if(MageNugz.procMonitorToggle == true) then
                    mageProcMBTime = 20;
                    MageNugMBProcFrameText:SetText("|cffFF33FF".."ARCANE MISSILES!")
                    MageNugMBProcFrame_ProcBar:SetValue(mageProcMBTime)
                    MageNugMBProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("ARCANE MISSILES!", CombatText_StandardScroll, 0.60, 0, 0.60, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end    
            if (arg == 16870) then
                if (MageNugz.clearcastToggle == true) then
                    if(combatTextCvar == '1') then    
                        CombatText_AddMessage("Clearcast", CombatText_StandardScroll, 1, 1, 1, nil, isStaggered, nil);
                    end    
                    clearcastTime = 8;
                    MageNugClearcast_Frame:Show();
                end
            end
            if (arg == 64343) then --Impact
                if(MageNugz.procMonitorToggle == true) then
                    mageImpProgMonTime = 9;
                    MageNugImpactProcFrameText:SetText("|cffFF0000".."IMPACT!")
                    MageNugImpactProcFrame_ProcBar:SetValue(mageImpProgMonTime)
                    MageNugImpactProcFrame:Show();
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("IMPACT!", CombatText_StandardScroll, 1.0, 0, 0, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.impactSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.impactSound)
                end
            end
            if(arg == 48108) then --Hot Streak!
                if(MageNugz.procMonitorToggle == true) then
                    mageProcHSTime = 14;
                    MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!")
                    MageNugProcFrame_ProcBar:SetValue(mageProcHSTime)
                    MageNugProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("HOT STREAK!", CombatText_StandardScroll, 1, 0.10, 0, "crit", isStaggered,nil);
			        end
                end
                if (MageNugz.hsSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.hsSound)
                end
            end  
            if(arg == 57761) then --Brain Freeze
                if(MageNugz.procMonitorToggle == true) then
                    mageProcBFTime = 14;     
                    MageNugBFProcFrameText:SetText("|cffFF3300".."BRAIN FREEZE!")
                    MageNugBFProcFrame_ProcBar:SetValue(mageProcBFTime)
                    MageNugBFProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("BRAIN FREEZE!", CombatText_StandardScroll, 1, 0.20, 0, "crit", isStaggered);
			        end
                end
                if (MageNugz.brainfreezeSoundToggle == true) then
                   PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.brainfreezeSound)
                end
            end  
             if(arg == 44457) then
                if (MageNugz.livingBombToggle == true) then
                    _, _, _, _, _, _, lbrefreshexpTime, unitCaster, _, _, _ = UnitAura("target", livingBombId, nil,"PLAYER|HARMFUL")
                    livingbombGlobalTime = 14;
                    if(lbrefreshexpTime ~= nil) then
                        if(destGUID == lbTargetId1)then
                            livingbombTime = (lbrefreshexpTime - GetTime());
                        elseif(destGUID == lbTargetId2)then 
                            livingbombTime2 = (lbrefreshexpTime - GetTime());
                        elseif(destGUID == lbTargetId3)then
                            livingbombTime3 = (lbrefreshexpTime - GetTime());
                        elseif(destGUID == lbTargetId4)then
                            livingbombTime4 = (lbrefreshexpTime - GetTime());
                        end
                    end
                end
            end
            if(arg == 44544) then --Fingers of Frost
                if(MageNugz.procMonitorToggle == true) then
                    fofProgMonTime = 14;
                    MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
                    MageNugFoFProcFrame_ProcBar:SetValue(fofProgMonTime)
                    MageNugFoFProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                       CombatText_AddMessage("Fingers Of Frost", CombatText_StandardScroll, 1, 1, 1, "crit", 1);
			        end
                end
                if (MageNugz.fofSoundToggle == true) then
                   PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.fofSound)
                end
            end  
            if(arg == 36032)then -- Arcane Blast
                abStackCount = 4;
                abProgMonTime = 6;
                MageNugAB_FrameText:SetText("|cffFF00FF"..abStackCount)
                MageNugAB_Frame_ABBar:SetValue(abProgMonTime)
            end
            if (MageNugz.polyToggle == true) then
                if (arg == 2637) then -- hibernate
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyPigId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 40;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                        MageNugPolyFrame:Show();
                    end
                end                
                if (arg == 51514) then -- hex
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyPigId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Hex"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 60;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Hex"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                        MageNugPolyFrame:Show();
                    end
                end                
                if (arg == 28272) then -- pig
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyPigId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 50;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                        MageNugPolyFrame:Show();
                    end
                end
                if (arg == 61305) then -- cat
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyCatId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 50;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                        MageNugPolyFrame:Show();
                    end
                end
                if (arg == 61721) then -- rabbit
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyRabbitId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 50;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                        MageNugPolyFrame:Show();
                    end
                end
                if (arg == 28271) then -- turtle
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyTurtleId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 50;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                        MageNugPolyFrame:Show();
                    end
                end
                if (arg == 118)  then  --sheep
                    _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polySheepId, nil,"PLAYER|HARMFUL")
                    if(polyExpTime ~= nil) then
                        polyTimer = RoundZero(polyExpTime - GetTime());
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                        MageNugPolyFrame:Show();
                    else
                        polyTimer = 50;
                        MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                        MageNugPolyFrame_Bar:SetValue(polyTimer);
                        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                        MageNugPolyFrame:Show();
                    end
                end
            end            
        end
        --
        if (event1 == "SPELL_CAST_SUCCESS") and (sourceName == UnitName("pet"))then 
            if(arg == 33395)then
                if (MageNugz.frzCooldown == true) then
                    freezeId, _, _, _, _, _, _, _, _ = GetSpellInfo(33395);
                    MNcooldownMonitor(freezeId, 25, "Interface\\Icons\\spell_frost_frostnova")
                end
            end
        end
        if (event1 == "SPELL_SUMMON") and (sourceName == UnitName("player")) then
             if (arg == 82676) then -- ring of frost
                --if (MageNugz.cbCooldown == true) then
                    local rfstart, rfduration, rfenabled = GetSpellCooldown(82676);
                        local rfTime = RoundOne(rfstart + rfduration - GetTime())       
                    ringfrostID, _, _, _, _, _, _, _, _ = GetSpellInfo(82676);
                    MNcooldownMonitor(ringfrostID, rfTime, "Interface\\Icons\\spell_frost_frozencore")
                --end
            end
        end
        if (event1 == "SPELL_CAST_SUCCESS") and (sourceName == UnitName("player"))then 
            if (arg == 33831) then
                if (MageNugz.treantCooldown == true) then
                    treantId, _, _, _, _, _, _, _, _ = GetSpellInfo(33831);
                    MNcooldownMonitor(treantId, 180, "Interface\\Icons\\ability_druid_forceofnature")
                end
                if (MageNugz.treantSoundTog == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.treantSound)
                end
            end
            if (arg == 122) then -- frost nova
                --if (MageNugz.cbCooldown == true) then
                    frostnovaId, _, _, _, _, _, _, _, _ = GetSpellInfo(122);
                    MNcooldownMonitor(frostnovaId, 25, "Interface\\Icons\\spell_frost_frostnova")
                --end
            end
            if (arg == 120) then -- cone of cold
                --if (MageNugz.cbCooldown == true) then
                    coneofcoldId, _, _, _, _, _, _, _, _ = GetSpellInfo(120);
                    MNcooldownMonitor(coneofcoldId, 10, "Interface\\Icons\\spell_frost_glacier")
                --end
            end
            if (arg == 45438) then -- Ice Block
                --if (MageNugz.cbCooldown == true) then
                    local ibstart, ibduration, ibenabled = GetSpellCooldown(78674);
                        local ibTime = RoundOne(ibstart + ibduration - GetTime())       
                    iceblockId, _, _, _, _, _, _, _, _ = GetSpellInfo(45438);
                    MNcooldownMonitor(iceblockId, ibTime, "Interface\\Icons\\spell_frost_frost")
                --end
            end
            if (arg == 82731) then -- Flame Orb
                --if (MageNugz.cbCooldown == true) then
                    flameOrbId, _, _, _, _, _, _, _, _ = GetSpellInfo(82731);
                    MNcooldownMonitor(flameOrbId, 60, "Interface\\Icons\\spell_mage_flameorb")
                --end
            end
            if (arg == 11129) then -- Combustion
                if (MageNugz.cbCooldown == true) then
                    combustionId, _, _, _, _, _, _, _, _ = GetSpellInfo(11129);
                    MNcooldownMonitor(combustionId, 120, "Interface\\Icons\\spell_fire_sealoffire")
                end
            end
            if (arg == 31661) then -- Dragons Breath
                if (MageNugz.dbCooldown == true) then
                    dragonsbreathId, _, _, _, _, _, _, _, _ = GetSpellInfo(31661);
                    MNcooldownMonitor(dragonsbreathId, 20, "Interface\\Icons\\inv_misc_head_dragon_01")
                end
            end
            if (arg == 11113) then -- blastwave
                if (MageNugz.bwCooldown == true) then
                    blastwaveId, _, _, _, _, _, _, _, _ = GetSpellInfo(11113);
                    MNcooldownMonitor(blastwaveId, 15, "Interface\\Icons\\spell_holy_excorcism_02")
                end
            end
            if (arg == 44572) then -- deep freeze
                if (MageNugz.dfCooldown == true) then
                    deepfreezeId, _, _, _, _, _, _, _, _ = GetSpellInfo(44572);
                    MNcooldownMonitor(deepfreezeId, 30, "Interface\\Icons\\ability_mage_deepfreeze")
                end
            end
            if (arg == 5405) then -- mana gem
                managemCooldown = 120;  
            end
            if (arg == 2139) then -- Counterspell
                if(MageNugz.csCooldown == true) then
                    counterspellId, _, _, _, _, _, _, _, _ = GetSpellInfo(2139);
                    MNcooldownMonitor(counterspellId, 24, "Interface\\Icons\\spell_frost_iceshock")
                end
            end
            if (arg == 8921) then
                moonfireTime = 18;
            end
            if (arg == 93402) then
                moonfireTime = 18;
            end
            if (arg == 5570) then
                insectTime = 18;
            end
            if (arg == 78674) then
                starsurgeTime = 16.5;
            end
        end
        --
        if event1 == "SPELL_AURA_REMOVED" then 
            if sourceName == UnitName("player") then
                if(arg == 57761) then
                    MageNugBFProcFrame:Hide()
                end
                if(arg == 44544) then
                    MageNugFoFProcFrame:Hide()
                end
                if(arg == 93400) then -- Shooting Stars
                   MageNugSSProcFrame:Hide()
                end
                if(arg == 79683) then
                    MageNugMBProcFrame:Hide();
                end
                if (arg == 64343) then
                    MageNugImpactProcFrame:Hide();
                end
                if(arg == 48108) then
                    MageNugProcFrame:Hide();
                end
                if(arg == 22959) then
                    MNcritMass_Frame:Hide();
                end
               --[[ if(arg == 12654)then
                    igniteTemp = 0;
                    MageNugIgnite_FrameText:SetText(igniteTemp);
                end
                --]]
                if (arg == 36032) then
                    abStackCount = 0;
                    MageNugAB_Frame:Hide();
                end
                if (arg == 83582) then
                    MNPyromaniac_Frame:Hide();
                end
                if (arg == 48505) then
                    if (MageNugz.starfallCooldown == true) then
                        start, duration, enabled = GetSpellCooldown(48505);
                        starFallId, _, _, _, _, _, _, _, _ = GetSpellInfo(48505);
                        MNcooldownMonitor(starFallId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\ability_druid_starfall")
                    end
                end
                if (arg == 12051) then
                    if (MageNugz.evoCooldown == true) then
                        start, duration, enabled = GetSpellCooldown(12051);
                        evocateId, _, _, _, _, _, _, _, _ = GetSpellInfo(12051);
                        MNcooldownMonitor(evocateId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\spell_nature_purge")
                    end
                end
                if (arg == 12472) then --icy veins
                    if (MageNugz.ivCooldown == true) then
                        start, duration, enabled = GetSpellCooldown(12472);
                        icyveinsId, _, _, _, _, _, _, _, _ = GetSpellInfo(12472);
                        MNcooldownMonitor(icyveinsId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\Spell_frost_coldhearted")
                    end    
                end
                if (arg == 12042) then
                    if (MageNugz.apCooldown == true) then
                        start, duration, enabled = GetSpellCooldown(12042);
                        arcanePowerId, _, _, _, _, _, _, _, _ = GetSpellInfo(12042);
                        MNcooldownMonitor(arcanePowerId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\spell_nature_lightning")
                    end    
                end
                if (arg == 11426) then
                    if (MageNugz.ibrCooldown == true) then
                        start, duration, enabled = GetSpellCooldown(11426);
                        icebarrierId, _, _, _, _, _, _, _, _ = GetSpellInfo(11426);
                        MNcooldownMonitor(icebarrierId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\spell_ice_lament")
                    end         
                end
                if(arg == 87023) then
                    if(combatTextCvar == '1') then
                        if (MageNugz.mageProcToggle == true) then
                            CombatText_AddMessage("extinguished", CombatText_StandardScroll, 0.90, 0, 0, nil, isStaggered, nil);
			            end
                    end
                    if (MageNugz.cauterizeToggle == true) then
                        MageNugCauterizeFrame:Hide();
                    end
                end
                if (arg == 12536) or (arg == 16870) then
                    if (MageNugz.clearcastToggle == true) then
                        MageNugClearcast_Frame:Hide();
                    end
                end
                if(arg == 83098) then
                    MNimpGem_Frame:Hide();
                end
                if (arg == 44457) then
                    livingBombCount = livingBombCount - 1;
                    if(livingBombCount <=0) then
                        livingBombCount = 0;
                        MageNugLB_Frame:Hide();
                    end
                    MageNugLB_Frame_Text:SetText("|cffFFFFFF"..livingBombCount)
                    if (destGUID == lbTargetId1) then
                        livingbombTime = 0;
                        lbTargetId1 = nil;
                    elseif (destGUID == lbTargetId2) then
                        livingbombTime2 = 0;
                        lbTargetId2 = nil;
                    elseif (destGUID == lbTargetId3) then
                        livingbombTime3 = 0;
                        lbTargetId3 = nil;
                    elseif (destGUID == lbTargetId4) then
                        livingbombTime4 = 0;
                        lbTargetId4 = nil;
                    end
                end
                if (MageNugz.polyToggle == true) then
                     if (arg == 2637) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Hibernate Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Hibernate Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end
                    if (arg == 51514) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Hex Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Hex Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end
                    if (arg == 28272) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Pig) Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end
                    if (arg == 118) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Sheep) Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end
                    if (arg == 28271) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Turtle) Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end
                    if (arg == 61721) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Rabbit) Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end
                    if (arg == 61305) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Black Cat) Broken On"..":|cffFFFFFF "..destName);
                        end
                        if (MageNugz.polySoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.polySound)
                        end
                    end 
                end
            end
        end
        if event1 == "SPELL_AURA_APPLIED" then
            if sourceName == UnitName("player") then
            if (arg == 83582) then -- pyromaniac
                if (MageNugz.buffmonToggle == false) then
                    MNPyromaniac_Frame:Show();
                end
            end
            if(arg == 83098) then -- imp mana gem
                if (MageNugz.buffmonToggle == false) then
                    impGemTimer = 14;
                    MNimpGem_Frame_Text:SetText(impGemTimer);
                    MNimpGem_Frame:Show();
                end
            end
            if (arg == 29166) then
                if (destName ~= UnitName("player")) then
                    if (MageNugz.msgToggle == true) then
                        SendChatMessage(MageNugz.innervatNotify, "WHISPER", nil, destName);   
                    end
                end
            end
            if(arg == 93400) then -- Shooting Stars
                if(MageNugz.moonkinProcTog == true) then
                   mageProcSSTime = 7;
                   starsurgeTime = 0;
                   MageNugSSProcFrameText:SetText("|cffFF33FF".."Shooting Stars")
                   MageNugSSProcFrame_ProcBar:SetValue(mageProcSSTime)
                   MageNugSSProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.moonkinCombatText == true) then
                        CombatText_AddMessage("Shooting Stars", CombatText_StandardScroll, 0.60, 0, 0.60, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end    
            
            if(arg == 79683) then -- Arcane Missiles!
                if(MageNugz.procMonitorToggle == true) then
                    mageProcMBTime = 20;
                    MageNugMBProcFrameText:SetText("|cffFF33FF".."ARCANE MISSILES!")
                    MageNugMBProcFrame_ProcBar:SetValue(mageProcMBTime)
                    MageNugMBProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("ARCANE MISSILES!", CombatText_StandardScroll, 0.60, 0, 0.60, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end    
            if(arg == 87023) then
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("Cauterize:", CombatText_StandardScroll, 0.90, 0, 0, nil, isStaggered, nil);
                        CombatText_AddMessage("EXTINGUISH YOURSELF", CombatText_StandardScroll, 0.90, 0, 0, nil, isStaggered, nil);
			        end
                end
                if (MageNugz.cauterizeToggle == true) then
                    MageNugCauterizeFrame:Show();
                    cauterizeTime = 60;
                    MageNugCauterize_Frame:Show();
                end
            end
            if(arg == 48108) then --Hot Streak!
                if(MageNugz.procMonitorToggle == true) then
                    mageProcHSTime = 14;
                    MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!")
                    MageNugProcFrame_ProcBar:SetValue(mageProcHSTime)
                    MageNugProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("HOT STREAK!", CombatText_StandardScroll, 1, 0.10, 0, "crit", isStaggered,nil);
			        end
                end
                if (MageNugz.hsSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.hsSound)
                end
            end  
            if (arg == 64343) then --Impact
                if(MageNugz.procMonitorToggle == true) then
                    mageImpProgMonTime = 9;
                    MageNugImpactProcFrameText:SetText("|cffFF0000".."IMPACT!")
                    MageNugImpactProcFrame_ProcBar:SetValue(mageImpProgMonTime)
                    MageNugImpactProcFrame:Show();
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("IMPACT!", CombatText_StandardScroll, 1.0, 0, 0, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.impactSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.impactSound)
                end
            end
            if(arg == 57761) then --Brain Freeze
                if(MageNugz.procMonitorToggle == true) then
                    mageProcBFTime = 14;     
                    MageNugBFProcFrameText:SetText("|cffFF3300".."BRAIN FREEZE!")
                    MageNugBFProcFrame_ProcBar:SetValue(mageProcBFTime)
                    MageNugBFProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage("BRAIN FREEZE!", CombatText_StandardScroll, 1, 0.20, 0, "crit", isStaggered);
			        end
                end
                if (MageNugz.brainfreezeSoundToggle == true) then
                   PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.brainfreezeSound)
                end
            end  
            if(arg == 44544) then --Fingers of Frost
                if(MageNugz.procMonitorToggle == true) then
                    fofProgMonTime = 15;
                    MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
                    MageNugFoFProcFrame_ProcBar:SetValue(fofProgMonTime)
                    MageNugFoFProcFrame:Show()
                end
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                       CombatText_AddMessage("Fingers Of Frost", CombatText_StandardScroll, 1, 1, 1, "crit", 1);
			        end
                end
                if (MageNugz.fofSoundToggle == true) then
                   PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.fofSound)
                end
            end  
            if (arg == 36032) then -- Arcane Blast
                if (MageNugz.arcaneBlastToggle == true) then
                    abStackCount = 1;
                    abProgMonTime = 6;
                    MageNugAB_FrameText:SetText("|cffFF00FF"..abStackCount)
                    MageNugAB_Frame_ABBar:SetValue(abProgMonTime)
                    MageNugAB_Frame:Show()
                end
            end
            if (arg == 12042) then
                if (MageNugz.buffmonToggle == false) then
                    apTimer = 14
                    MNarcanepower_FrameText:SetText(apTimer);
                    MNarcanepower_Frame:Show();
                end
            end
            if (arg == 12472) then --icy veins
                if (MageNugz.buffmonToggle == false) then
                    icyTimer = 19;
                    MNicyveins_FrameText:SetText(icyTimer);
                    MNicyveins_Frame:Show();
                end
            end    
            if (MageNugz.polyToggle == true) then
                    if (arg == 2637) then -- hibernate
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyPigId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 40;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                            MageNugPolyFrame:Show();
                        end
                    end
                    if (arg == 51514) then -- HEX
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyPigId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."HEX"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 60;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."HEX"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                            MageNugPolyFrame:Show();
                        end
                    end
                    if (arg == 28272) then -- pig
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyPigId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 50;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                            MageNugPolyFrame:Show();
                        end
                    end
                    if (arg == 61305) then -- cat
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyCatId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 50;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                            MageNugPolyFrame:Show();
                        end
                    end
                    if (arg == 61721) then -- rabbit
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyRabbitId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 50;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                            MageNugPolyFrame:Show();
                        end
                    end
                    if (arg == 28271) then -- turtle
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polyTurtleId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 50;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                            MageNugPolyFrame:Show();
                        end
                    end
                    if (arg == 118)  then  --sheep
                        _, _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = UnitAura("target", polySheepId, nil,"PLAYER|HARMFUL")
                        if (polyExpTime ~= nil) then
                            polyTimer = RoundZero(polyExpTime - GetTime());
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                            MageNugPolyFrame:Show();
                        else
                            polyTimer = 50;
                            MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                            MageNugPolyFrameTimerText:SetText(polyTimer);
                            MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                            MageNugPolyFrame_Bar:SetValue(polyTimer);
                            MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                            MageNugPolyFrame:Show();
                        end
                    end
                end            
                if(arg == 44457) then
                    if (MageNugz.livingBombToggle == true) then
                        livingBombCount = livingBombCount + 1;
                        livingbombGlobalTime = 14
                        MageNugLB_Frame_Text:SetText("|cffFFFFFF"..livingBombCount)
                        _, _, _, _, _, _, lbexpirationTime, unitCaster, _, _, _ = UnitAura("target", livingBombId, nil,"PLAYER|HARMFUL")
                        if (lbexpirationTime ~= nil) then
                            if(livingbombTime <= 0) then
                                lbTargetId1 = destGUID;
                                livingbombTime = (lbexpirationTime - GetTime());
                                MageNugLB1_Frame_Text:SetText(RoundOne(livingbombTime))
                                MageNugLB1_Frame_Text2:SetText(strsub(destName,1,18))
                                MageNugLB_Frame:Show()
                                MageNugLB1_Frame:Show()
                            elseif(livingbombTime2 <= 0) then 
                                lbTargetId2 = destGUID;
                                livingbombTime2 = (lbexpirationTime - GetTime());
                                MageNugLB2_Frame_Text:SetText(RoundOne(livingbombTime2))
                                MageNugLB2_Frame_Text2:SetText(strsub(destName,1,18))
                                MageNugLB2_Frame:Show()
                            elseif(livingbombTime3 <= 0) then
                                lbTargetId3 = destGUID;
                                livingbombTime3 = (lbexpirationTime - GetTime());
                                MageNugLB3_Frame_Text:SetText(RoundOne(livingbombTime3))
                                MageNugLB3_Frame_Text2:SetText(strsub(destName,1,18))
                                MageNugLB3_Frame:Show()
                            elseif(livingbombTime4 <= 0) then
                                lbTargetId4 = destGUID;
                                livingbombTime4 = (lbexpirationTime - GetTime());
                                MageNugLB4_Frame_Text:SetText(RoundOne(livingbombTime4));
                                MageNugLB4_Frame_Text2:SetText(strsub(destName,1,18))
                                MageNugLB4_Frame:Show();
                            end
                        end
                    end
                end
                if (arg == 55342) then
                    if (MageNugz.mirrorImageToggle == true) then
                        if (MageNugz.miSoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.miSound)
                        end
                        mirrorImageTime = 30;
                        MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
                        MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
                        MageNugMI_Frame:Show();
                    end
                    if (MageNugz.miCooldown == true) then
                        mirrorImageId, _, _, _, _, _, _, _, _ = GetSpellInfo(55342);
                        MNcooldownMonitor(mirrorImageId, 180, "Interface\\Icons\\spell_magic_lesserinvisibilty")
                    end  
                end
                if (arg == 130) then
                    if (destName ~= UnitName("player")) then
                        if (MageNugz.msgToggle == true) then
                            local sfRandomNum = math.random(1,3)
                            if(sfRandomNum == 1) then 
                                SendChatMessage(MageNugz.slowfallMsg, "WHISPER", nil, destName);
                            end
                            if(sfRandomNum == 2) then
                                SendChatMessage(MageNugz.slowfallMsg2, "WHISPER", nil, destName);
                            end
                            if(sfRandomNum == 3) then
                                SendChatMessage(MageNugz.slowfallMsg3, "WHISPER", nil, destName);
                            end
                        end
                    end
                end
                if (arg == 54646) then
                    if (MageNugz.msgToggle == true) then
                        local fmRandomNum = math.random(1,3)
                        if(fmRandomNum == 1) then
                            SendChatMessage(MageNugz.focusMagicNotify, "WHISPER", nil, destName);
                        end
                        if(fmRandomNum == 2) then
                            SendChatMessage(MageNugz.focusMagicNotify2, "WHISPER", nil, destName);
                        end
                        if(fmRandomNum == 3) then
                            SendChatMessage(MageNugz.focusMagicNotify3, "WHISPER", nil, destName);
                        end
                    end
                end
            end
            if destName == UnitName("player") then
                if (arg == 12536) then
                    if (MageNugz.clearcastToggle == true) then
                        if(combatTextCvar == '1') then    
                            CombatText_AddMessage("Clearcast", CombatText_StandardScroll, 1, 1, 1, nil, isStaggered, nil);
                        end    
                        clearcastTime = 15;
                        MageNugClearcast_Frame:Show();
                    end
                end
                if (arg == 16870) then
                    if (MageNugz.clearcastToggle == true) then
                        if(combatTextCvar == '1') then    
                            CombatText_AddMessage("Clearcast", CombatText_StandardScroll, 1, 1, 1, nil, isStaggered, nil);
                        end    
                        clearcastTime = 8;
                        MageNugClearcast_Frame:Show();
                    end
                end
                if (arg == 64868) then
				    if(combatTextCvar == '1') then
                        if (MageNugz.mageProcToggle == true) then
                            CombatText_AddMessage("Praxis", CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil, nil);
                            CombatText_AddMessage("+350 Spellpower", CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);
			            end
                    end
                end
		        if (arg == 10060) and (sourceName ~= UnitName("player")) then
                    if (MageNugz.consoleTextEnabled == true) then
                        DEFAULT_CHAT_FRAME:AddMessage("|cff0000FF".."Power Infusion By"..":|cffFFFFFF "..sourceName);
                    end
                    if(combatTextCvar == '1') then
                        CombatText_AddMessage(sourceName, CombatText_StandardScroll, 0, 0.10, 1, "sticky", nil);
                        CombatText_AddMessage("POWER INFUSION!", CombatText_StandardScroll, 0, 0.10, 1, "sticky", nil);  
                    end
                    if (MageNugz.msgToggle == true) then
                        SendChatMessage(MageNugz.powerinfThanks, "WHISPER", nil, sourceName);   
                    end
                end
                if (arg == 12051) then
                    if (MageNugz.evocationToggle == true) then
                        local manaPoolTotal = UnitManaMax("player");
                        local evoTotal = manaPoolTotal * 0.60
                        evoTotal = math.floor(evoTotal+0.5) 
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cff663399".."Evocating For".." "..evoTotal.." ".."Mana");
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Evocating For".." "..evoTotal.." Mana", CombatText_StandardScroll, 0, 0.10, 1, nil, isStaggered, nil);  
                        end
                    end
                end
                if(combatTextCvar == '1') then
                    if (arg == 63711) then
                        CombatText_AddMessage("STORM POWER".."!!", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage("(+135% Crit Damage)", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                    if (arg == 65134) then
                        CombatText_AddMessage("STORM POWER".."!", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage("(+135% Crit Damage)", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                    if (arg == 62821) then
                        CombatText_AddMessage("TOASTY FIRE!", CombatText_StandardScroll, 1, 0.20, 0, "sticky", nil);
                    end
                    if (arg == 29232) then
                        CombatText_AddMessage("Fungal Creep!", CombatText_StandardScroll, 0, 1, 0.2, "sticky", nil);
                        CombatText_AddMessage("(+50% Crit Rating)", CombatText_StandardScroll, 0, 1, 0,2, "sticky", nil);
                    end
                    if (arg == 62320) then
                        CombatText_AddMessage("Aura of Celerity!", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage("(+20% Haste)", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                    if (arg == 62807) then
                        CombatText_AddMessage("Star Light!", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage("(50% Haste)", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                end
                if (arg == 29166) then
                    if (sourceName ~= UnitName("player")) then
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cff0000FF".."Innervated By"..":|cffFFFFFF "..sourceName);
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage(sourceName, CombatText_StandardScroll, 0, 0.10, 1, "sticky", nil);
                            CombatText_AddMessage("INNERVATED YOU!", CombatText_StandardScroll, 0, 0.10, 1, "sticky", nil);  
                        end
                        if (MageNugz.msgToggle == true) then
                            local inRandomNum = math.random(1,2)
                            if(inRandomNum == 1) then 
                                SendChatMessage(MageNugz.innervatThanks, "WHISPER", nil, sourceName);   
                            end
                            if(inRandomNum == 2) then 
                                SendChatMessage(MageNugz.innervatThanks2, "WHISPER", nil, sourceName);
                            end
                        end
                    end
                end
                if (arg == 54646) then
                    if (MageNugz.consoleTextEnabled == true) then
                        DEFAULT_CHAT_FRAME:AddMessage("|cff0000FF".."Focused Magic By"..":|cffFFFFFF "..sourceName);
                    end
                    if(combatTextCvar == '1') then
                        CombatText_AddMessage(sourceName, CombatText_StandardScroll, 0, 0.10, 1, nil, nil);
                        CombatText_AddMessage("Focused Magic you", CombatText_StandardScroll, 0, 0.10, 1, nil, nil);  
                    end
                    if (MageNugz.msgToggle == true) then
                        local fmRandomNum = math.random(1,2)
                        if(fmRandomNum == 1) then 
                            SendChatMessage(MageNugz.focusMagicThanks, "WHISPER", nil, sourceName);   
                        end
                        if(fmRandomNum == 2) then
                            SendChatMessage(MageNugz.focusMagicThanks2, "WHISPER", nil, sourceName);
                        end
                    end
                end
                
                
                if (arg == 85767) then
                    if (MageNugz.consoleTextEnabled == true) then
                        DEFAULT_CHAT_FRAME:AddMessage("|cff0000FF".."Dark Intent By"..":|cffFFFFFF "..sourceName);
                    end
                    if(combatTextCvar == '1') then
                        CombatText_AddMessage(sourceName, CombatText_StandardScroll, 0, 0.10, 1, nil, nil);
                        CombatText_AddMessage("Dark Intent", CombatText_StandardScroll, 0, 0.10, 1, nil, nil);  
                    end
                    if (MageNugz.msgToggle == true) then
                        SendChatMessage(MageNugz.darkIntentThanks, "WHISPER", nil, sourceName);   
                    end
                end
                
                
                
                
                
                
                if (arg == 2825) then
                    if sourceName ~= UnitName("player") then
                        if (MageNugz.buffmonToggle == false) then
                            lustTimer = 40;
                            MNlust_Frame:Show()
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Blood Lust used by"..":|cff0000FF "..sourceName);
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage(sourceName, CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);
                            CombatText_AddMessage("BLOOD LUSTED!", CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);  
                        end
                    end
                end
                if (arg == 32182) then
                    if sourceName ~= UnitName("player") then
                        lustTimer = 40;
                        MNlust_Frame:Show()
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Heroism used by"..":|cff0000FF "..sourceName);
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage(sourceName, CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);
                            CombatText_AddMessage("HEROISM!", CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);  
                        end
                    end
                end
  
            end
		end
        --
        if event1 == "SPELL_STOLEN" then
            if sourceName == UnitName("player") then
				if(combatTextCvar == '1') then
                    CombatText_AddMessage("Stole"..":"..GetSpellLink(spellId1), CombatText_StandardScroll, 0.10, 0, 1, "sticky", nil);
                end
                if (MageNugz.consoleTextEnabled == true) then
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF".."Spell Stolen"..":"..GetSpellLink(spellId1).."From "..destName)
	    	    end
            end
		end
     end
end

--------------------------------Options Functions----------------------------------

function MNtalentSpec()
    if (mnenglishClass == 'WARLOCK') or (mnenglishClass == 'MAGE') then
        talentSpec = "damage";
    end
    if(mnenglishClass == 'SHAMAN')then
        local _, _, _, _, elePoints = GetTalentTabInfo(1);
        local _, _, _, _, enhanPoints = GetTalentTabInfo(2);   
        local _, _, _, _, restoPoints = GetTalentTabInfo(3);
        if(restoPoints > elePoints) and (restoPoints > enhanPoints) then
            talentSpec = "healer";
        else
            talentSpec = "damage";
        end
    end
    if(mnenglishClass == 'PRIEST') then
        local _, _, _, _, discPoints = GetTalentTabInfo(1);
        local _, _, _, _, holyPoints = GetTalentTabInfo(2);   
        local _, _, _, _, shadowPoints = GetTalentTabInfo(3);
        if(shadowPoints > holyPoints) and (shadowPoints > discPoints) then
            talentSpec = "damage";
        else
            talentSpec = "healer";
        end
    end
    if(mnenglishClass == 'DRUID') then
        local _, _, _, _, balPoints = GetTalentTabInfo(1);
        local _, _, _, _, feralPoints = GetTalentTabInfo(2);   
        local _, _, _, _, restoPoints = GetTalentTabInfo(3);
        if(restoPoints > feralPoints) and (restoPoints > balPoints) then
            talentSpec = "healer";
        elseif(feralPoints > balPoints) and (feralPoints > restoPoints) then
            talentSpec = "feral";
        else
            talentSpec = "damage";
        end
    end
end


function MNVariablesLoaded_OnEvent() --Takes care of the options on load up
        mnplayerClass, mnenglishClass = UnitClass("player");  
        if((mnenglishClass == 'WARRIOR') or (mnenglishClass == 'ROGUE') or (mnenglishClass == 'DEATH KNIGHT') or (mnenglishClass == 'PALADAIN') or (mnenglishClass == 'HUNTER')) then
            MageNugz.spMonitorToggle = true;
            MageNugz.ssMonitorToggle = false;
            MageNugz.igniteTog = false;
            MageNugz.mageProcToggle = false;
            MageNugz.camZoomTogg = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.mageArmorToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.procMonitorToggle = false;
            MageNugz.consoleTextEnabled = false;
            MageNugz.arcaneBlastToggle = false;
            MageNugz.minimapToggle = false;
            MageNugz.cooldownToggle = true;
            MageNugCD_Frame:Hide();
            MageNugz.moonkinTog = true;
            MageNugMoonkin_Frame:Hide()
            MageNugz.managemToggle = false;
            MageNugManaGem_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
        end
        if(mnenglishClass == 'WARLOCK') then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff 2.091 ".."loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
            MageNugz.igniteTog = false;
            MageNugz.ssMonitorToggle = false;
            MageNugz.mageProcToggle = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.mageArmorToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.procMonitorToggle = false;
            MageNugz.minimapToggle = false;
            MageNugz.cooldownToggle = true;
            MageNugCD_Frame:Hide();
            MageNugz.moonkinTog = true;
            MageNugMoonkin_Frame:Hide()
            MageNugz.managemToggle = false;
            MageNugManaGem_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
        end
        if(mnenglishClass == 'SHAMAN')then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff 2.091 ".."loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
            MageNugz.igniteTog = false;
            MageNugz.mageProcToggle = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.mageArmorToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.procMonitorToggle = false;
            MageNugz.minimapToggle = false;
            MageNugz.cooldownToggle = true;
            MageNugCD_Frame:Hide();
            MageNugz.moonkinTog = true;
            MageNugMoonkin_Frame:Hide()
            MageNugz.managemToggle = false;
            MageNugManaGem_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
            MNSpellSteal_FrameTitleText:SetText("|cffffffffPURGEABLE")
        end
        if(mnenglishClass == 'PRIEST') then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff 2.091 ".."loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
            MageNugz.igniteTog = false;
            MageNugz.ssMonitorToggle = false;
            MageNugz.mageProcToggle = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.mageArmorToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.procMonitorToggle = false;
            MageNugz.minimapToggle = false;
            MageNugz.cooldownToggle = true;
            MageNugCD_Frame:Hide();
            MageNugz.moonkinTog = true;
            MageNugMoonkin_Frame:Hide()
            MageNugz.managemToggle = false;
            MageNugManaGem_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
        end
        if(mnenglishClass == 'DRUID') then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff 2.091 ".."loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
            MageNugz.igniteTog = false;
            MageNugz.ssMonitorToggle = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.mageArmorToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.minimapToggle = false;
            MageNugz.managemToggle = false;
            MageNugManaGem_Frame:Hide();
            MageNugCD_Frame_Text:SetText(" ");
            if(MageNugz.moonkinCombat == true) then
                MageNugMoonkin_Frame:Hide();
                MNmoonFire_Frame:Hide();
                MNinsectSwarm_Frame:Hide();
                MNstarSurge_Frame:Hide();
            else
                if (MageNugz.moonkinTog == false) or (MageNugz.moonkinTog == nil) then
                    MageNugMoonkin_Frame:Show();
                    MNmoonFire_Frame:Show();
                    MNinsectSwarm_Frame:Show();
                    MNstarSurge_Frame:Show();
                end
            end
            if (MageNugz.moonkinMin == true) then
                MageNugMoonkin_Frame_Texture:Hide();
            end
        end
        if(mnenglishClass == 'MAGE') then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff 2.091 ".."loaded! (Use: /magenuggets options)")
            MageNugCD_Frame_Text:SetText(" ");
            MageNugz.moonkinTog = true;
            MageNugMoonkin_Frame:Hide()
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
            MNSpellSteal_FrameTitleText:SetText("|cff33ccffS P E L L S T E A L");
            MNSpellStealFocus_FrameTitleText:SetText("|cff33ccffFOCUS SPELLSTEAL");
            if(MageNugz.managemToggle == true) then
                if(MageNugz.mgCombatTog == true) then
                    MageNugManaGem_Frame:Hide();
                end
            end        
        end                
        -----Main Options----- 
        MageNugMoonkinToggle_FrameText:SetText("|cff00BFFF".."Mage".."|cff00FF00".." Nuggets")
        MageNugCauterizeFrame:Hide();
        if (MageNugz.minimapToggle == nil) then
            MageNugz.minimapToggle = true;
        end
        if (MageNugz.minimapToggle == true) then
            MageNug_MinimapFrame:Show();
            MageNugOption2Frame_MinimapCheckButton:SetChecked(0);
        else
            MageNug_MinimapFrame:Hide();
            MageNugOption2Frame_MinimapCheckButton:SetChecked(1);
        end
        combatTextCvar = GetCVar("enableCombatText")
        MNspellstealFontString:SetText("Disable Spellsteal/Purge Monitor")
        MNprocTextFontString:SetText("Disable Mage Proc Combat Text")
        MNmirrorImageFontString:SetText("Disable Mirror Image Timer")
        MNmageArmorFontString:SetText("Disable Mage Armor Notify")
        MNevoFontString:SetText("Disable Evocation Notify")
        MNlbCounterFontString:SetText("Disable Living Bomb Counter")
        MNprocMonsFontString:SetText("Disable Mage Proc Monitors")
        MNabCounterFontString:SetText("Disable Arcane Blast Counter")
        MNPolyFontString:SetText("Disable Poly/Hex/Hibernate Monitor")
        MNcheckboxclearcastString:SetText("Disable Clearcast Monitor")
        MNcheckboxABcastString:SetText("AB Cast Time")
        MN_Slider2FontString:SetText("Spellsteal Monitor Size")
        MN_Slider3FontString:SetText("LB & AB Counter Size")
        MN_Slider4FontString:SetText("Mage Proc Monitor Size")
        MageNugOptionsFrameButton1:SetText("Preview Frames")
        if (MageNugz.ssMonitorToggle == true) then
            MageNugOptionsFrame_CheckButton2:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton2:SetChecked(1);
        end
        if (MageNugz.mageProcToggle == true) then
            MageNugOptionsFrame_CheckButton3:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton3:SetChecked(1);
        end
        if(MageNugz.igniteTog == true) or (MageNugz.igniteTog == nil) then
            MageNugOptionsFrame_IgniteCheckButton:SetChecked(1);
            MageNugz.igniteTog = true;
        else
            MageNugOptionsFrame_IgniteCheckButton:GetChecked(0);
        end
        if (MageNugz.mirrorImageToggle == true) then
            MageNugOptionsFrame_CheckButton6:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton6:SetChecked(1);
        end
        if (MageNugz.mageArmorToggle == nil) then
            MageNugz.mageArmorToggle = true
        end
        if (MageNugz.mageArmorToggle == true) then
            MageNugOptionsFrame_CheckButton7:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton7:SetChecked(1);
        end
        if (MageNugz.evocationToggle == true) then
            MageNugOptionsFrame_CheckButton8:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton8:SetChecked(1);
        end
        if (MageNugz.livingBombToggle == true) then
            MageNugOptionsFrame_CheckButton9:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton9:SetChecked(1);
        end
        if(MageNugz.abCastTimeToggle == nil) then
            MageNugz.abCastTimeToggle = true;
        end
        if(MageNugz.abCastTimeToggle == true) then
            MageNugOptionsFrame_ABcastCheckButton:SetChecked(1);
            MNabCast_Frame:Show();
        else
            MageNugOptionsFrame_ABcastCheckButton:SetChecked(0);
            MNabCast_Frame:Hide();
        end   
        if (MageNugz.arcaneBlastToggle == true) then
            MageNugOptionsFrame_CheckButton13:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton13:SetChecked(1);
        end
        if (MageNugz.polyToggle == true) then
            MageNugOptionsFrame_CheckButton14:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton14:SetChecked(1);
        end
        if (MageNugz.clearcastToggle == nil) then
            MageNugz.clearcastToggle = true;
        end
        if (MageNugz.clearcastToggle == true) then
            MageNugOptionsFrame_CheckButtonCC:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButtonCC:SetChecked(1);
        end  
        if(MageNugz.mgCombatTog == nil) then
            MageNugz.mgCombatTog = false;
        end
        if(MageNugz.mgCombatTog == true) then
            MageNugOptionsFrame_CheckButtonMGcombat:SetChecked(1);
        else
            MageNugOptionsFrame_CheckButtonMGcombat:SetChecked(0);
        end
        if (MageNugz.managemToggle == nil) then
            MageNugz.managemToggle = true;
        end
        if (MageNugz.managemToggle == true) then
            MageNugOptionsFrame_CheckButtonMG:SetChecked(0);
            if(MageNugz.mgCombatTog == false) then    
                MageNugManaGem_Frame:Show();
            end
        else
            MageNugOptionsFrame_CheckButtonMG:SetChecked(1);
            MageNugManaGem_Frame:Hide()
        end
        if (MageNugz.procMonitorToggle == nil) then
            MageNugz.procMonitorToggle = true;
        end
        if (MageNugz.procMonitorToggle == true) then
            MageNugOptionsFrame_CheckButton11:SetChecked(0);
        else
            MageNugOptionsFrame_CheckButton11:SetChecked(1);
        end
        if (MageNugz.ssMonitorSize == nil) then
            MageNugOptionsFrame_Slider2:SetValue(3)
        else
            MageNugOptionsFrame_Slider2:SetValue(MageNugz.ssMonitorSize)
        end
        if (MageNugz.livingBCounterSize == nil) then
            MageNugOptionsFrame_Slider3:SetValue(3)
        else
            MageNugOptionsFrame_Slider3:SetValue(MageNugz.livingBCounterSize)
        end
        if (MageNugz.procMonitorSize == nil) then
            MageNugOptionsFrame_Slider4:SetValue(3)
        else
            MageNugOptionsFrame_Slider4:SetValue(MageNugz.procMonitorSize)
        end  
        -----Messages Options----        
        MageNugMsgOptionFrame_Text1:SetText("Slowfall Notify Messages")
        MageNugMsgOptionFrame_Text2:SetText("Focus Magic Notify Messages")
        MageNugMsgOptionFrame_Text3:SetText("Focus Magic Thank You Messages")
        MageNugMsgOptionFrame_Text4:SetText("Innervate Thank You Messages")
        if (MageNugz.msgToggle == nil) then
            MageNugz.msgToggle = true;
        end
        if (MageNugz.msgToggle == true) then
            MageNugMsgOptionFrame_CheckButton:SetChecked(0);
        else
            MageNugMsgOptionFrame_CheckButton:SetChecked(1);
        end
        if (MageNugz.slowfallMsg == nil) or (MageNugz.slowfallMsg == "") then
            SlowFallMsgEditBox:SetText("Slowfall Cast On You")
        else
            SlowFallMsgEditBox:SetText(MageNugz.slowfallMsg)
        end
        if (MageNugz.slowfallMsg2 == nil) or (MageNugz.slowfallMsg2 == "") then
            SlowFallMsgEditBox2:SetText("Slowfall Cast On You")
        else
            SlowFallMsgEditBox2:SetText(MageNugz.slowfallMsg2)
        end
        if (MageNugz.slowfallMsg3 == nil) or (MageNugz.slowfallMsg3 == "")then
            SlowFallMsgEditBox3:SetText("Slowfall Cast On You")
        else
            SlowFallMsgEditBox3:SetText(MageNugz.slowfallMsg3)
        end
        if (MageNugz.focusMagicNotify == nil) or (MageNugz.focusMagicNotify == "") then
            FocMagNotifyEditBox:SetText("Focus Magic Cast On You")
        else
          FocMagNotifyEditBox:SetText(MageNugz.focusMagicNotify)
        end
        if (MageNugz.focusMagicNotify2 == nil) or (MageNugz.focusMagicNotify2 == "") then
            FocMagNotifyEditBox2:SetText("Focus Magic Cast On You")
        else
           FocMagNotifyEditBox2:SetText(MageNugz.focusMagicNotify2)
        end
        if (MageNugz.focusMagicNotify3 == nil) or (MageNugz.focusMagicNotify3 == "") then
            FocMagNotifyEditBox3:SetText("Focus Magic Cast On You")
        else
           FocMagNotifyEditBox3:SetText(MageNugz.focusMagicNotify3)
        end
        if (MageNugz.focusMagicThanks == nil) or (MageNugz.focusMagicThanks == "") then
            FocMagThankEditBox:SetText("Thanks For Focus Magic")
        else
            FocMagThankEditBox:SetText(MageNugz.focusMagicThanks)
        end
        if (MageNugz.focusMagicThanks2 == nil) or (MageNugz.focusMagicThanks2 == "") then
            FocMagThankEditBox2:SetText("Thanks For Focus Magic")
        else
            FocMagThankEditBox2:SetText(MageNugz.focusMagicThanks2)
        end
        if (MageNugz.innervatThanks == nil) or (MageNugz.innervatThanks == "") then
            InnervThankEditBox:SetText("Thanks For The Innervate")
        else
            InnervThankEditBox:SetText(MageNugz.innervatThanks)
        end
        if (MageNugz.innervatThanks2 == nil) or (MageNugz.innervatThanks2 == "") then
            InnervThankEditBox2:SetText("Thanks For The Innervate")
        else
            InnervThankEditBox2:SetText(MageNugz.innervatThanks2)
        end
        ------Message 2 Options----
        MageNugMsg2OptionFrame_Text1:SetText("Power Infusion Thank You")
        if (MageNugz.powerinfThanks == nil) or (MageNugz.powerinfThanks == "") then
            MageNugMsg2OptionFrame_PowerInfusionEditBox:SetText("Thanks For Power Infusion")
        else
            MageNugMsg2OptionFrame_PowerInfusionEditBox:SetText(MageNugz.powerinfThanks)
        end
        
        if (MageNugz.darkIntentThanks == nil) or (MageNugz.darkIntentThanks == "") then
            MageNugMsg2OptionFrame_DarkIntentEditBox:SetText("Thanks For Dark Intent")
        else
            MageNugMsg2OptionFrame_DarkIntentEditBox:SetText(MageNugz.darkIntentThanks)
        end
        
        
        
        ------Monitor Options------       
        MNcheckbox1FontString:SetText("Disable Stat Monitor")
        MNcheckbox2FontString:SetText("Disable Buff Monitors")
        MageNugStatMonOptionFrame_SPSliderFontString:SetText("Stat Monitor Size")
        MageNugStatMonOptionFrame_BorderSliderFontString:SetText("Border Type")
        MageNugStatMonOptionFrame_TransSliderFontString:SetText("Background Transparency")
        MageNugStatMonOptionFrame_ColorSliderFontString:SetText("Backdrop Color")
        if (MageNugz.spCombatToggle == nil)then
            MageNugz.spCombatToggle = false;
        end
        if (MageNugz.spCombatToggle == true) then
            MageNugStatMonOptionFrame_CheckButton0:SetChecked(1);
        else
            MageNugStatMonOptionFrame_CheckButton0:SetChecked(0);
        end
        if (MageNugz.spMonitorToggle == nil) then
            MageNugz.spMonitorToggle = false;
        end
        if (MageNugz.spMonitorToggle == true) then
            MageNugStatMonOptionFrame_CheckButton1:SetChecked(1);
            MageNugSP_Frame:Hide();
        else
            if (MageNugz.spCombatToggle == true) then
                MageNugSP_Frame:Hide();
            else
                MageNugSP_Frame:Show();
            end
            MageNugStatMonOptionFrame_CheckButton1:SetChecked(0);
        end
        if (MageNugz.buffmonToggle == nil) then
            MageNugz.buffmonToggle = false;
        end
        if (MageNugz.buffmonToggle == true) then
            MageNugStatMonOptionFrame_CheckButton2:SetChecked(1);
        else
            MageNugStatMonOptionFrame_CheckButton2:SetChecked(0);
        end
        if (MageNugz.spMonitorSize == nil) then
            MageNugStatMonOptionFrame_SPSizeSlider:SetValue(3)
        else
            MageNugStatMonOptionFrame_SPSizeSlider:SetValue(MageNugz.spMonitorSize)
        end
        if(MageNugz.borderStyle == nil) then
            MageNugStatMonOptionFrame_BorderSlider:SetValue(0);
        else
            MageNugStatMonOptionFrame_BorderSlider:SetValue(MageNugz.borderStyle);
        end
        if(MageNugz.transColor == nil) then
            MageNugStatMonOptionFrame_TransparencySlider:SetValue(0);
        else
            MageNugStatMonOptionFrame_TransparencySlider:SetValue(MageNugz.transColor);
        end
        --------Options 2--------
        MNcheckboxMiniMapFontString:SetText("Disable Minimap Button")
        MNcheckboxCameraFontString:SetText("Disable Maximum Camera Zoom Out")
        MNcheckboxConsoleTextFontString:SetText("Disable Console Text")
        MNcheckboxLockFramesFontString:SetText("Lock Frames")
        MNcheckboxTTFontString:SetText("Tool Tips")
        MNcheckboxClickThruFontString:SetText("Enable Frame Click Through")
        MNpolyFrameSizeFontString:SetText("Polymorph Monitor Size")
        if (MageNugz.MinimapPos == nil) then
            MageNugz.MinimapPos = 45;
        end
        if (MageNugz.camZoomTogg == true) then
            ConsoleExec("cameraDistanceMax 50");
            MageNugOption2Frame_CameraCheckButton:SetChecked(0);
        else
            MageNugOption2Frame_CameraCheckButton:SetChecked(1);
        end
        if (MageNugz.lockFrames == nil) then
            MageNugz.lockFrames = false;
        end
        if (MageNugz.lockFrames == true) then
            MageNugOption2Frame_LockFramesCheckButton:SetChecked(1);
        else
            MageNugOption2Frame_LockFramesCheckButton:SetChecked(0);
        end
        if (MageNugz.consoleTextEnabled == nil) then
            MageNugz.consoleTextEnabled = true;
        end
        if (MageNugz.consoleTextEnabled == true) then
            MageNugOption2Frame_ConsoleTextCheckButton:SetChecked(0);
        else
            MageNugOption2Frame_ConsoleTextCheckButton:SetChecked(1);
        end
        if (MageNugz.toolTips == nil) then
            MageNugz.toolTips = true;
        end
        if (MageNugz.toolTips == true) then
            MageNugOption2Frame_CheckButtonTT:SetChecked(1);
        else
            MageNugOption2Frame_CheckButtonTT:SetChecked(0);
        end
        if (MageNugz.clickthru == nil) then
            MageNugz.clickthru = false;
        end
        if (MageNugz.clickthru == true) then
            MageNugOption2Frame_ClickThruCheckButton:SetChecked(1);
        else
            MageNugOption2Frame_ClickThruCheckButton:SetChecked(0);
        end
        if (MageNugz.polyFrameSize == nil) then
            MageNugOption2Frame_Slider1:SetValue(3)
        else
            MageNugOption2Frame_Slider1:SetValue(MageNugz.polyFrameSize)
        end
        if (MageNugz.cauterizeToggle == true) or (MageNugz.cauterizeToggle == nil) then
            MageNugOption2Frame_CauterizeCheckButton:SetChecked(1);
            MageNugz.cauterizeToggle = true;
        else
            MageNugOption2Frame_CauterizeCheckButton:SetChecked(0);
        end
        
        -------Sounds Options-------
        if (MageNugz.miSound == nil) or (MageNugz.miSound == "") then
            MageNugSoundOptionFrame_MISoundEditBox:SetText("mirror.mp3")
        else
            MageNugSoundOptionFrame_MISoundEditBox:SetText(MageNugz.miSound)
        end
        if (MageNugz.procSound == nil) or (MageNugz.procSound == "") then
            MageNugSoundOptionFrame_ProcSoundEditBox:SetText("proc.mp3")
        else
            MageNugSoundOptionFrame_ProcSoundEditBox:SetText(MageNugz.procSound)
        end
        if (MageNugz.miSoundToggle == true) or (MageNugz.miSoundToggle == nil) then
            MageNugSoundOptionFrame_MICheckButton:SetChecked(1);
            MageNugz.miSoundToggle = true;
        else
            MageNugSoundOptionFrame_MICheckButton:SetChecked(0);
        end
        if (MageNugz.procSoundToggle == true) or (MageNugz.procSoundToggle == nil) then
            MageNugSoundOptionFrame_ProcCheckButton:SetChecked(1);
            MageNugz.procSoundToggle = true;
        else
            MageNugSoundOptionFrame_ProcCheckButton:SetChecked(0);
        end
        if (MageNugz.polySound == nil) or (MageNugz.polySound == "") then
            MageNugSoundOptionFrame_PolySoundEditBox:SetText("sheep.mp3")
        else
            MageNugSoundOptionFrame_PolySoundEditBox:SetText(MageNugz.polySound)
        end
        if (MageNugz.polySoundToggle == true) or (MageNugz.polySoundToggle == nil) then
            MageNugSoundOptionFrame_PolyCheckButton:SetChecked(1);
            MageNugz.polySoundToggle = true;
        else
            MageNugSoundOptionFrame_PolyCheckButton:SetChecked(0);
        end
        if (MageNugz.hsSound == nil) or (MageNugz.hsSound == "") then
            MageNugSoundOptionFrame_HotStreakSoundEditBox:SetText("hotstreak.mp3")
        else
            MageNugSoundOptionFrame_HotStreakSoundEditBox:SetText(MageNugz.hsSound)
        end
        if (MageNugz.hsSoundToggle == true) or (MageNugz.hsSoundToggle == nil) then
            MageNugSoundOptionFrame_HotStreakCheckButton:SetChecked(1);
            MageNugz.hsSoundToggle = true;
        else
            MageNugSoundOptionFrame_HotStreakCheckButton:SetChecked(0);
        end
        if (MageNugz.impactSound == nil) or (MageNugz.impactSound == "") then
            MageNugSoundOptionFrame_ImpactSoundEditBox:SetText("impact.mp3")
        else
            MageNugSoundOptionFrame_ImpactSoundEditBox:SetText(MageNugz.impactSound)
        end
        if (MageNugz.impactSoundToggle == true) or (MageNugz.impactSoundToggle == nil) then
            MageNugSoundOptionFrame_ImpactCheckButton:SetChecked(1);
            MageNugz.impactSoundToggle = true;
        else
            MageNugSoundOptionFrame_ImpactCheckButton:SetChecked(0);
        end
        if (MageNugz.fofSound == nil) or (MageNugz.fofSound == "") then
            MageNugSoundOptionFrame_FoFSoundEditBox:SetText("fof.mp3")
        else
            MageNugSoundOptionFrame_FoFSoundEditBox:SetText(MageNugz.fofSound)
        end
        if (MageNugz.fofSoundToggle == true) or (MageNugz.fofSoundToggle == nil) then
            MageNugSoundOptionFrame_FoFCheckButton:SetChecked(1);
            MageNugz.fofSoundToggle = true;
        else
            MageNugSoundOptionFrame_FoFCheckButton:SetChecked(0);
        end
        if (MageNugz.brainfreezeSound == nil) or (MageNugz.brainfreezeSound == "") then
            MageNugSoundOptionFrame_BrainFreezeSoundEditBox:SetText("brainfreeze.mp3")
        else
            MageNugSoundOptionFrame_BrainFreezeSoundEditBox:SetText(MageNugz.brainfreezeSound)
        end
        if (MageNugz.brainfreezeSoundToggle == true) or (MageNugz.brainfreezeSoundToggle == nil) then
            MageNugSoundOptionFrame_BrainFreezeCheckButton:SetChecked(1);
            MageNugz.brainfreezeSoundToggle = true;
        else
            MageNugSoundOptionFrame_BrainFreezeCheckButton:SetChecked(0);
        end
        ---cooldown options-----
        if (MageNugz.cooldownToggle == nil) then
            MageNugz.cooldownToggle = false;
        end
        if (MageNugz.cooldownToggle == true) then
            MageNugCooldownFrame_cdButton:SetChecked(1);        
        else
            MageNugCooldownFrame_cdButton:SetChecked(0); 
            MageNugCD_Frame:Show()
        end
        if (MageNugz.apCooldown == nil) or (MageNugz.apCooldown == true) then
            MageNugCooldownFrame_apButton:SetChecked(1);
            MageNugz.apCooldown = true;
        else
            MageNugCooldownFrame_apButton:SetChecked(0);
        end
        if (MageNugz.bwCooldown == nil) or (MageNugz.bwCooldown == true) then
            MageNugCooldownFrame_bwButton:SetChecked(1);
            MageNugz.bwCooldown = true;
        else
            MageNugCooldownFrame_bwButton:SetChecked(0);
        end
        if (MageNugz.cbCooldown == nil) or (MageNugz.cbCooldown == true) then
            MageNugCooldownFrame_cbButton:SetChecked(1);
            MageNugz.cbCooldown = true;
        else
            MageNugCooldownFrame_cbButton:SetChecked(0);
        end
        if (MageNugz.csCooldown == nil) or (MageNugz.csCooldown == true) then
            MageNugCooldownFrame_csButton:SetChecked(1);
            MageNugz.csCooldown = true;
        else
            MageNugCooldownFrame_csButton:SetChecked(0);
        end
        if (MageNugz.dfCooldown == nil) or (MageNugz.dfCooldown == true) then
            MageNugCooldownFrame_dfButton:SetChecked(1);
            MageNugz.dfCooldown = true;
        else
            MageNugCooldownFrame_dfButton:SetChecked(0);
        end
        if (MageNugz.dbCooldown == nil) or (MageNugz.dbCooldown == true) then
            MageNugCooldownFrame_dbButton:SetChecked(1);
            MageNugz.dbCooldown = true;
        else
            MageNugCooldownFrame_dbButton:SetChecked(0);
        end
        if (MageNugz.mwCooldown == nil) or (MageNugz.mwCooldown == true) then
            MageNugCooldownFrame_mwButton:SetChecked(1);
            MageNugz.mwCooldown = true;
        else
            MageNugCooldownFrame_mwButton:SetChecked(0);
        end
        if (MageNugz.miCooldown == nil) or (MageNugz.miCooldown == true) then
            MageNugCooldownFrame_miButton:SetChecked(1);
            MageNugz.miCooldown = true;
        else
            MageNugCooldownFrame_miButton:SetChecked(0);
        end
        if (MageNugz.frzCooldown == nil) or (MageNugz.frzCooldown == true) then
            MageNugCooldownFrame_frzButton:SetChecked(1);
            MageNugz.frzCooldown = true;
        else
            MageNugCooldownFrame_frzButton:SetChecked(0);
        end
        if (MageNugz.msCooldown == nil) or (MageNugz.msCooldown == true) then
            MageNugCooldownFrame_msButton:SetChecked(1);
            MageNugz.msCooldown = true;
        else
            MageNugCooldownFrame_msButton:SetChecked(0);
        end
        if (MageNugz.ibrCooldown == nil) or (MageNugz.ibrCooldown == true) then
            MageNugCooldownFrame_ibrButton:SetChecked(1);
            MageNugz.ibrCooldown = true;
        else
            MageNugCooldownFrame_ibrButton:SetChecked(0);
        end
        if (MageNugz.evoCooldown == nil) or (MageNugz.evoCooldown == true) then
            MageNugCooldownFrame_evoButton:SetChecked(1);
            MageNugz.evoCooldown = true;
        else
            MageNugCooldownFrame_evoButton:SetChecked(0);
        end
        if (MageNugz.ivCooldown == nil) or (MageNugz.ivCooldown == true) then
            MageNugCooldownFrame_ivButton:SetChecked(1);
            MageNugz.ivCooldown = true;
        else
            MageNugCooldownFrame_ivButton:SetChecked(0);
        end
        if (MageNugz.treantCooldown == nil) or (MageNugz.treantCooldown == true) then
            MageNugCooldownFrame_treantButton:SetChecked(1);
            MageNugz.treantCooldown = true;
        else
            MageNugCooldownFrame_treantButton:SetChecked(0);
        end
        if (MageNugz.starfallCooldown == nil) or (MageNugz.starfallCooldown == true) then
            MageNugCooldownFrame_starfallButton:SetChecked(1);
            MageNugz.starfallCooldown = true;
        else
            MageNugCooldownFrame_starfallButton:SetChecked(0);
        end
        if (MageNugz.cooldownSize == nil) then
            MageNugCooldownFrame_Slider1:SetValue(3);
        else
            MageNugCooldownFrame_Slider1:SetValue(MageNugz.cooldownSize);
        end
        -----moonkin optioins--------
        if(MageNugz.moonkinBoxTog == true) or (MageNugz.moonkinBoxTog == nil)then
            MageNugMoonkinOptionFrame_CheckButton0:SetChecked(1);
            MageNugz.moonkinBoxTog = true;
        else
            MageNugMoonkinOptionFrame_CheckButton0:SetChecked(0);
            MageNugz.moonkinBoxTog = false;
        end
        if(MageNugz.moonkinTog == nil) then
            MageNugz.moonkinTog = false;
        end
        if (MageNugz.moonkinTog == true) then
            MageNugMoonkinOptionFrame_CheckButton:SetChecked(1);
            MageNugMoonkin_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
        else
            MageNugMoonkinOptionFrame_CheckButton:SetChecked(0);
            if(MageNugz.moonkinCombat == false) then
                MageNugMoonkin_Frame:Show();
                MNmoonFire_Frame:Show();
                MNinsectSwarm_Frame:Show();
                MNstarSurge_Frame:Show();
            end
        end
        if (MageNugz.moonkinCombat == nil) then
            MageNugz.moonkinCombat = false;
        end
        if (MageNugz.moonkinCombat == true) then
            MageNugMoonkinOptionFrame_CheckButton1:SetChecked(1);
        else
            MageNugMoonkinOptionFrame_CheckButton1:SetChecked(0);
        end
         if (MageNugz.moonkinMin == nil) then
            MageNugz.moonkinMin = false;
        end
        if (MageNugz.moonkinMin == true) then
            MageNugMoonkinOptionFrame_CheckButtonMin:SetChecked(1);
        else
            MageNugMoonkinOptionFrame_CheckButtonMin:SetChecked(0);
        end
        if (MageNugz.moonkinSize == nil) then
            MageNugMoonkinOptionFrame_Slider:SetValue(3)
        else
            MageNugMoonkinOptionFrame_Slider:SetValue(MageNugz.moonkinSize)
        end
        if (MageNugz.treantSoundTog == nil) then
            MageNugz.treantSoundTog = true;
        end
        if (MageNugz.treantSoundTog == true) then
            MageNugMoonkinOptionFrame_CheckButton2:SetChecked(1);
        else
            MageNugMoonkinOptionFrame_CheckButton2:SetChecked(0);
        end
        if (MageNugz.treantSound == nil) or (MageNugz.treantSound == "") then
            MageNugMoonkinOptionFrame_SoundEditBox:SetText("mirror.mp3")
        else
            MageNugMoonkinOptionFrame_SoundEditBox:SetText(MageNugz.treantSound)
        end
        if (MageNugz.moonkinProcTog == nil) then
            MageNugz.moonkinProcTog = true;
        end
        if (MageNugz.moonkinProcTog == true) then
            MageNugMoonkinOptionFrame_ProcCheckButton:SetChecked(1)
        else
            MageNugMoonkinOptionFrame_ProcCheckButton:SetChecked(0)
        end
        if (MageNugz.moonkinCombatText == nil)then
            MageNugz.moonkinCombatText = true
        end
        if (MageNugz.moonkinCombatText == true) then
            MageNugMoonkinOptionFrame_CheckButton3:SetChecked(1);
        else
            MageNugMoonkinOptionFrame_CheckButton3:SetChecked(0);
        end
        if (MageNugz.innervatNotify == nil) or (MageNugz.innervatNotify == "") then
            MageNugMoonkinOptionFrame_InnervateEditBox:SetText("Innervate Cast On You!")
        else
            MageNugMoonkinOptionFrame_InnervateEditBox:SetText(MageNugz.innervatNotify)
        end
        if(MageNugz.castBoxes == nil)then
            MageNugz.castBoxes = true;
        end
        if(MageNugz.castBoxes == true)then
            MageNugMoonkinOptionFrame_CastCheckButton:SetChecked(1)
        else
            MageNugMoonkinOptionFrame_CastCheckButton:SetChecked(0)
        end
        if (MageNugz.moonkinProcSize == nil) then
            MageNugMoonkinOptionFrame_Slider1:SetValue(3);
        else
            MageNugMoonkinOptionFrame_Slider1:SetValue(MageNugz.moonkinProcSize);
        end
        if (MageNugz.moonkinAnchorTog == nil) then
            MageNugz.moonkinAnchorTog = true;
        end
        if(MageNugz.moonkinAnchorTog == true)then
            MageNugMoonkinOptionFrame_CheckButtonAnchor:SetChecked(1)
        else
            MageNugMoonkinOptionFrame_CheckButtonAnchor:SetChecked(0)
        end
        ------------------------------
        MageNugPolyFrame:Hide();
        MageNugImpactProcFrame:Hide();
        MageNugBFProcFrame:Hide();
        MageNugProcFrame:Hide();
        MageNugMBProcFrame:Hide();
        MageNugFoFProcFrame:Hide(); 
        MageNugAB_Frame:Hide();
        MNcritMass_Frame:Hide();
        iceBlockId, _, _, _, _, _, _, _, _ = GetSpellInfo(45438);
        livingBombId, _, _, _, _, _, _, _, _ = GetSpellInfo(44457);
        icyVeinsId, _, _, _, _, _, _, _, _ = GetSpellInfo(12472);
        polyPigId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
        polySheepId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
        polyTurtleId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
        polyRabbitId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
        polyCatId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
        frostboltId, _, _, _, _, _, _, _, _ = GetSpellInfo(42842);
        frostfireId, _, _, _, _, _, _, _, _ = GetSpellInfo(47610);
        conecoldId, _, _, _, _, _, _, _, _ = GetSpellInfo(42931);
        blastwaveId, _, _, _, _, _, _, _, _ = GetSpellInfo(42945);
        judgementjustId, _, _, _, _, _, _, _, _ = GetSpellInfo(53696);
        infectedwoundsId, _, _, _, _, _, _, _, _ = GetSpellInfo(48485);
        thunderclapId, _, _, _, _, _, _, _, _ = GetSpellInfo(47502);
        deadlythrowId, _, _, _, _, _, _, _, _ = GetSpellInfo(48674);
        frostshockId, _, _, _, _, _, _, _, _ = GetSpellInfo(49236);
        chilledId, _, _, _, _, _, _, _, _ = GetSpellInfo(7321); 
        mindflayId, _, _, _, _, _, _, _, _ = GetSpellInfo(48156);
        impactId, _, _, _, _, _, _, _, _ = GetSpellInfo(64343);
        managemId, _, _, _, _, _, _, _, _ = GetSpellInfo(36799);
        MageNugz_MinimapButton_Move()
        MnClickThrough()
        MNmoonkinAnchorToggle()
        incombat = 0;
        
              
        
end

function MageNuggetsOptions() --Options Frame
    local MageNugOptions = CreateFrame("FRAME", "MageNugOptions", InterfaceOptionsFrame)
    MageNugOptions.name = "Mage Nuggets"
    InterfaceOptions_AddCategory(MageNugOptions)
    MageNugOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    
    local statmonOptions = CreateFrame("FRAME", "statmonOptions");
    statmonOptions.name = "Stat Monitor";
    statmonOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(statmonOptions); 
    statmonOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local msgOptions = CreateFrame("FRAME", "msgOptions");
    msgOptions.name = "Messages";
    msgOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(msgOptions); 
    msgOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local msg2Options = CreateFrame("FRAME", "msg2Options");
    msg2Options.name = "Messages 2";
    msg2Options.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(msg2Options); 
    msg2Options:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    
    local soundOptions = CreateFrame("FRAME", "soundOptions");
    soundOptions.name = "Sounds";
    soundOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(soundOptions); 
    soundOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    
    local moonkinOptions = CreateFrame("FRAME", "moonkinOptions");
    moonkinOptions.name = "Moonkin";
    moonkinOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(moonkinOptions); 
    moonkinOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    
    local mnOptions = CreateFrame("FRAME", "mnOptions");
    mnOptions.name = "Options";
    mnOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(mnOptions); 
    mnOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
    
    local mnCooldowns = CreateFrame("FRAME", "mnCooldowns");
    mnCooldowns.name = "Cooldowns";
    mnCooldowns.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(mnCooldowns); 
    mnCooldowns:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

end

function hideMonitorToggle() -- Monitor Toggle
    local monitorChecked = MageNugStatMonOptionFrame_CheckButton1:GetChecked();
    if (monitorChecked == 1) then
	    MageNugSP_Frame:Hide();
        MageNugz.spMonitorToggle = true;
    else
        if (MageNugz.spCombatToggle == false) then
            MageNugSP_Frame:Show();
        end
        MageNugz.spMonitorToggle = false;
    end
end
--
function MNstatMonCombat()
    local statChecked = MageNugStatMonOptionFrame_CheckButton0:GetChecked();
    if (statChecked == 1) then
        MageNugz.spCombatToggle = true;
        MageNugSP_Frame:Hide();
    else
        MageNugz.spCombatToggle = false;
        if(MageNugz.spMonitorToggle == false) then
            MageNugSP_Frame:Show();
        end
    end
end
--
function MNigniteToggle()
    local isChecked = MageNugOptionsFrame_IgniteCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.igniteTog = true;
    else
        MageNugz.igniteTog = false;
    end
end
--
function MNMinimapButtonToggle()
    local mini = MageNugOption2Frame_MinimapCheckButton:GetChecked();
    if (mini == 1) then
        MageNugz.minimapToggle = false; 
        MageNug_MinimapFrame:Hide();
    else
        MageNugz.minimapToggle = true; 
        MageNug_MinimapFrame:Show();
    end
end

function HideSSMonitorToggle() -- Spellsteal Monitor Toggle
    local stealMonitorChecked = MageNugOptionsFrame_CheckButton2:GetChecked();
    if (stealMonitorChecked == 1) then
	    MageNugz.ssMonitorToggle = false; 
    else
        MageNugz.ssMonitorToggle = true;
    end
end

function MNmgCombatToggle()
    local isChecked = MageNugOptionsFrame_CheckButtonMGcombat:GetChecked();
    if (isChecked == 1) then
	    MageNugz.mgCombatTog = true; 
        MageNugManaGem_Frame:Hide();
    else
        MageNugz.mgCombatTog = false;
        if(MageNugz.managemToggle == true) then
            MageNugManaGem_Frame:Show();
        end
    end
end

function MNmessagesToggle() --Messages Toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton:GetChecked();
    if (msgTog == 1) then
	    MageNugz.msgToggle = false; 
    else
        MageNugz.msgToggle = true;
    end
end

function MNCauterizeToggle()
    local isChecked = MageNugOption2Frame_CauterizeCheckButton:GetChecked();
    if (isChecked == 1) then
	    MageNugz.cauterizeToggle = true; 
    else
        MageNugz.cauterizeToggle = false;
    end
end


function MageProcNoteToggle() -- Mage Proc Notification Toggle
    local cNotifyChecked = MageNugOptionsFrame_CheckButton3:GetChecked();
    if (cNotifyChecked == 1) then
	    MageNugz.mageProcToggle = false;
    else
        MageNugz.mageProcToggle = true;
    end
end

function cameraZoomToggle() -- Camera Zoom Out Toggle
    local camZoomChecked = MageNugOption2Frame_CameraCheckButton:GetChecked();
    if (camZoomChecked == 1) then
        ConsoleExec("cameraDistanceMax 15");
        MageNugz.camZoomTogg = false;
    else  
        ConsoleExec("cameraDistanceMax 50");
        MageNugz.camZoomTogg = true;
    end
end

function MirrorImageSoundToggle() -- Mirror Image Sound Toggle
    local miChecked = MageNugSoundOptionFrame_MICheckButton:GetChecked();
    if (miChecked == 1) then
        MageNugz.miSoundToggle = true;
    else  
        MageNugz.miSoundToggle = false;
    end
end

function ProcSoundToggle() -- Proc Sound Toggle
    local procChecked = MageNugSoundOptionFrame_ProcCheckButton:GetChecked();
    if (procChecked == 1) then
        MageNugz.procSoundToggle = true;
    else  
        MageNugz.procSoundToggle = false;
    end
end

function PolySoundToggle() -- Poly Sound Toggle
    local isChecked = MageNugSoundOptionFrame_PolyCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.polySoundToggle = true;
    else  
        MageNugz.polySoundToggle = false;
    end
end

function HotStreakSoundToggle() -- HS Sound Toggle
    local isChecked = MageNugSoundOptionFrame_HotStreakCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.hsSoundToggle = true;
    else  
        MageNugz.hsSoundToggle = false;
    end
end

function ImpactSoundToggle() -- Impact Sound Toggle
    local isChecked = MageNugSoundOptionFrame_ImpactCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.impactSoundToggle = true;
    else  
        MageNugz.impactSoundToggle = false;
    end
end

function FoFSoundToggle() -- FoF Sound Toggle
    local isChecked = MageNugSoundOptionFrame_FoFCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.fofSoundToggle = true;
    else  
        MageNugz.fofSoundToggle = false;
    end
end

function BrainFreezeSoundToggle() --Brain Freeze Sound Toggle
    local isChecked = MageNugSoundOptionFrame_BrainFreezeCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.brainfreezeSoundToggle = true;
    else  
        MageNugz.brainfreezeSoundToggle = false;
    end
end

function MirrorImagToggle() -- Mirror Image Timer Toggle
    local mirrorChecked = MageNugOptionsFrame_CheckButton6:GetChecked();
    if (mirrorChecked == 1) then
        MageNugz.mirrorImageToggle = false;
    else  
        MageNugz.mirrorImageToggle = true;
    end
end

function MageArmorToggle() -- Mage Armor Notify Toggle
    local maChecked = MageNugOptionsFrame_CheckButton7:GetChecked();
    if (maChecked == 1) then
        MageNugz.mageArmorToggle = false;
    else  
        MageNugz.mageArmorToggle = true;
    end
end

function EvoToggle() -- Evocation Toggle
    local evoChecked = MageNugOptionsFrame_CheckButton8:GetChecked();
    if (evoChecked == 1) then
        MageNugz.evocationToggle = false;
    else  
        MageNugz.evocationToggle = true;
    end
end

function LivingBToggle() -- Living Bomb Toggle
    local lbChecked = MageNugOptionsFrame_CheckButton9:GetChecked();
    if (lbChecked == 1) then
        MageNugz.livingBombToggle = false;
    else  
        MageNugz.livingBombToggle = true;
    end
end

function MNabCastTimeToggle() -- AB Cast Time Toggle
    local abcChecked = MageNugOptionsFrame_ABcastCheckButton:GetChecked();
    if (abcChecked == 1) then
        MageNugz.abCastTimeToggle = true;
        MNabCast_Frame:Show();
    else  
        MageNugz.abCastTimeToggle = false;
        MNabCast_Frame:Hide();
    end
end

function MageProcMonitorToggle()
    local mpChecked = MageNugOptionsFrame_CheckButton11:GetChecked();
    if (mpChecked == 1) then
        MageNugz.procMonitorToggle = false;
    else  
        MageNugz.procMonitorToggle = true;
    end
end

function MNArcaneBlastToggle()
    local abChecked = MageNugOptionsFrame_CheckButton13:GetChecked();
    if (abChecked == 1) then
        MageNugz.arcaneBlastToggle = false;
    else  
        MageNugz.arcaneBlastToggle = true;
    end
end

function MNpolyToggle()
    local polyChecked = MageNugOptionsFrame_CheckButton14:GetChecked();
    if (polyChecked == 1) then
        MageNugz.polyToggle = false;
    else  
        MageNugz.polyToggle = true;
    end
end

function BuffMonitorsToggle()
    local buffsChecked = MageNugStatMonOptionFrame_CheckButton2:GetChecked();
    if (buffsChecked == 1) then
	    MageNugz.buffmonToggle = true;
    else
        MageNugz.buffmonToggle = false;
    end
end

function MnClickThrough()
    local clickChecked = MageNugOption2Frame_ClickThruCheckButton:GetChecked();
    if (clickChecked == 1) then
        MageNugz.clickthru = true;
        MNSpellStealFocus_Frame:EnableMouse(false);
        MageNugIgnite_Frame:EnableMouse(false)
        MageNugSP_Frame:EnableMouse(false)
        MNTorment_Frame:EnableMouse(false)
        MNicyveins_Frame:EnableMouse(false)
        MNarcanepower_Frame:EnableMouse(false)
        MageNugCauterize_Frame:EnableMouse(false);
        MNlust_Frame:EnableMouse(false)
        MageNugClearcast_Frame:EnableMouse(false)
        MNcritMass_Frame:EnableMouse(false)
        MageNugAB_Frame:EnableMouse(false)
        MNabCast_Frame:EnableMouse(false)
        MageNugProcFrame:EnableMouse(false)
        MageNugPolyFrame:EnableMouse(false)
        MageNugImpactProcFrame:EnableMouse(false)
        MageNugBFProcFrame:EnableMouse(false)
        MageNugMBProcFrame:EnableMouse(false)
        MageNugFoFProcFrame:EnableMouse(false)
        MNSpellSteal_Frame:EnableMouse(false)
        MageNugMI_Frame:EnableMouse(false)
        MageNugCD_Frame:EnableMouse(false)
        MageNugCD1_Frame:EnableMouse(false)
        MageNugCD2_Frame:EnableMouse(false)
        MageNugCD3_Frame:EnableMouse(false)
        MageNugCD4_Frame:EnableMouse(false)
        MageNugCD5_Frame:EnableMouse(false)
        MageNugCD6_Frame:EnableMouse(false)
        MageNugCD1_Frame_Bar:EnableMouse(false)
        MageNugCD2_Frame_Bar:EnableMouse(false)
        MageNugCD3_Frame_Bar:EnableMouse(false)
        MageNugCD4_Frame_Bar:EnableMouse(false)
        MageNugCD5_Frame_Bar:EnableMouse(false)
        MageNugCD6_Frame_Bar:EnableMouse(false)
        MageNugLB_Frame:EnableMouse(false)
        MageNugLB1_Frame:EnableMouse(false)
        MageNugLB2_Frame:EnableMouse(false)
        MageNugLB3_Frame:EnableMouse(false)
        MageNugLB4_Frame:EnableMouse(false)
        MageNugLB1_Frame_Bar:EnableMouse(false)
        MageNugLB2_Frame_Bar:EnableMouse(false)
        MageNugLB3_Frame_Bar:EnableMouse(false)
        MageNugLB4_Frame_Bar:EnableMouse(false)
        MageNugMoonkin_Frame:EnableMouse(false)
        MageNugSSProcFrame:EnableMouse(false)
        MageNugCastStarsurgeFrame:EnableMouse(false)
        MageNugCastMoonFrame:EnableMouse(false)
        MageNugCastInsectFrame:EnableMouse(false)
        MNmoonFire_Frame:EnableMouse(false)
        MNinsectSwarm_Frame:EnableMouse(false)
        MNstarSurge_Frame:EnableMouse(false)
    else
        MageNugz.clickthru = false;
        MNSpellStealFocus_Frame:EnableMouse(true);
        MageNugSP_Frame:EnableMouse(true)
        MageNugIgnite_Frame:EnableMouse(true)
        MNTorment_Frame:EnableMouse(true)
        MNicyveins_Frame:EnableMouse(true)
        MNarcanepower_Frame:EnableMouse(true)
        MNlust_Frame:EnableMouse(true)
        MageNugClearcast_Frame:EnableMouse(true)
        MNcritMass_Frame:EnableMouse(true)
        MageNugCauterize_Frame:EnableMouse(true);
        MageNugAB_Frame:EnableMouse(true)
        MNabCast_Frame:EnableMouse(true)
        MageNugProcFrame:EnableMouse(true)
        MageNugPolyFrame:EnableMouse(true)
        MageNugImpactProcFrame:EnableMouse(true)
        MageNugBFProcFrame:EnableMouse(true)
        MageNugMBProcFrame:EnableMouse(true)
        MageNugFoFProcFrame:EnableMouse(true)
        MNSpellSteal_Frame:EnableMouse(true)
        MageNugMI_Frame:EnableMouse(true)
        MageNugCD_Frame:EnableMouse(true)
        MageNugCD1_Frame:EnableMouse(true)
        MageNugCD2_Frame:EnableMouse(true)
        MageNugCD3_Frame:EnableMouse(true)
        MageNugCD4_Frame:EnableMouse(true)
        MageNugCD5_Frame:EnableMouse(true)
        MageNugCD6_Frame:EnableMouse(true)
        MageNugCD1_Frame_Bar:EnableMouse(true)
        MageNugCD2_Frame_Bar:EnableMouse(true)
        MageNugCD3_Frame_Bar:EnableMouse(true)
        MageNugCD4_Frame_Bar:EnableMouse(true)
        MageNugCD5_Frame_Bar:EnableMouse(true)
        MageNugCD6_Frame_Bar:EnableMouse(true)
        MageNugLB_Frame:EnableMouse(true)
        MageNugLB1_Frame:EnableMouse(true)
        MageNugLB2_Frame:EnableMouse(true)
        MageNugLB3_Frame:EnableMouse(true)
        MageNugLB4_Frame:EnableMouse(true)
        MageNugLB1_Frame_Bar:EnableMouse(true)
        MageNugLB2_Frame_Bar:EnableMouse(true)
        MageNugLB3_Frame_Bar:EnableMouse(true)
        MageNugLB4_Frame_Bar:EnableMouse(true)
        MageNugMoonkin_Frame:EnableMouse(true)
        MageNugSSProcFrame:EnableMouse(true)
        MageNugCastStarsurgeFrame:EnableMouse(true)
        MageNugCastMoonFrame:EnableMouse(true)
        MageNugCastInsectFrame:EnableMouse(true)
        MNmoonFire_Frame:EnableMouse(true)
        MNinsectSwarm_Frame:EnableMouse(true)
        MNstarSurge_Frame:EnableMouse(true)
    end
end

function ShowConfigFrames() --Shows frames for 20 seconds
    if (MageNugz.ssMonitorToggle == true) then
        spellStealTog = 20;
        MNSpellSteal_Frame:Show();
        MNSpellStealFocus_Frame:Show();
    end
    mirrorImageTime = 60;
    MageNugMI_Frame:Show();
    livingbombGlobalTime = 60;
    MageNugLB_Frame:Show();
    ignitetimer = 60;
    MageNugIgnite_Frame:Show();
    --MNcooldownMonitor("Cooldowns", 60, "Interface\\Icons\\Spell_frost_coldhearted")
    --MNcooldownMonitor("Cooldowns", 60, "Interface\\Icons\\Spell_frost_coldhearted")
    --MNcooldownMonitor("Cooldowns", 60, "Interface\\Icons\\Spell_frost_coldhearted")
    --MNcooldownMonitor("Cooldowns", 60, "Interface\\Icons\\Spell_frost_coldhearted")
    --MNcooldownMonitor("Cooldowns", 60, "Interface\\Icons\\Spell_frost_coldhearted")
    --MNcooldownMonitor("Cooldowns", 60, "Interface\\Icons\\Spell_frost_coldhearted")
    polyTimer = 60
    MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph")
    MageNugPolyFrame:Show();
    mageImpProgMonTime = 60;
    MageNugImpactProcFrameText:SetText("|cffFF0000".."IMPACT!")
    MageNugImpactProcFrame:Show()
    mageProcBFTime = 60;
    MageNugBFProcFrameText:SetText("|cffFF3300".."BRAIN FREEZE!")
    MageNugBFProcFrame:Show();
    mageProcHSTime = 60;
    MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!");
    MageNugProcFrame:Show();
    mageProcMBTime = 60;
    misslebTog = 60;
    MageNugMBProcFrameText:SetText("|cffFF33FF".."ARCANE MISSILES!")
    MageNugMBProcFrame:Show();
    fofProgMonTime = 60;
    MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
    MageNugFoFProcFrame:Show(); 
    cauterizeTime = 60;
    MageNugCauterize_Frame:Show();
    abProgMonTime = 60;
    MageNugAB_Frame:Show();
    clearcastTime = 60;
    MageNugClearcast_Frame:Show();
    MageNugCauterizeFrame:Show();
end

function HideConfigFrames()
    MageNugCauterize_Frame:Hide();
    MNSpellSteal_Frame:Hide();
    MNSpellStealFocus_Frame:Hide();
    MageNugMI_Frame:Hide();
    MageNugLB_Frame:Hide();
    MageNugPolyFrame:Hide();
    MageNugIgnite_Frame:Hide();
    MageNugImpactProcFrame:Hide()
    MageNugBFProcFrame:Hide();
    MageNugProcFrame:Hide();
    MageNugMBProcFrame:Hide();
    MageNugFoFProcFrame:Hide(); 
    MageNugAB_Frame:Hide();
    MageNugClearcast_Frame:Hide();
    MageNugCauterizeFrame:Hide();
end


function LockFramesToggle()
    local flChecked = MageNugOption2Frame_LockFramesCheckButton:GetChecked();
    if (flChecked == 1) then
        MageNugz.lockFrames = true;
    else  
        MageNugz.lockFrames = false;
    end
end

function ConsoleTextToggle()
    local ctChecked = MageNugOption2Frame_ConsoleTextCheckButton:GetChecked();
    if (ctChecked == 1) then
        MageNugz.consoleTextEnabled = false;
    else
        MageNugz.consoleTextEnabled = true;
    end
end

function MNtoolTipToggle()
    local ttChecked = MageNugOption2Frame_CheckButtonTT:GetChecked();
    if (ttChecked == 1) then
        MageNugz.toolTips = true;
    else
        MageNugz.toolTips = false;
    end
end

function MNclearcastToggle()
    local ccChecked = MageNugOptionsFrame_CheckButtonCC:GetChecked();
    if (ccChecked == 1) then
        MageNugz.clearcastToggle = false;
    else
        MageNugz.clearcastToggle = true;
    end
end
--
function MNmanagemToggle()
    local isChecked = MageNugOptionsFrame_CheckButtonMG:GetChecked();
    if (isChecked == 1) then
        MageNugz.managemToggle = false;
        MageNugManaGem_Frame:Hide();
    else
        MageNugz.managemToggle = true;
        MageNugManaGem_Frame:Show();
    end
end
----------cooldown monitor-------------
function MNcooldownMonitor(name, expiretime, texture)
    if(MageNugCD1_Frame_Bar:GetValue() < 1)then
        MageNugCD1_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD1_Frame_Text:SetText(name)
        MageNugCD1_Frame_Text2:SetText("!")
        MageNugCD1_Frame_Texture:SetTexture(texture)
        MageNugCD1_Frame:Show()
    elseif(MageNugCD2_Frame_Bar:GetValue() < 1)then
        MageNugCD2_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD2_Frame_Text:SetText(name)
        MageNugCD2_Frame_Text2:SetText("!")
        MageNugCD2_Frame_Texture:SetTexture(texture)
        MageNugCD2_Frame:Show()
    elseif(MageNugCD3_Frame_Bar:GetValue() < 1)then
        MageNugCD3_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD3_Frame_Text:SetText(name)
        MageNugCD3_Frame_Text2:SetText("!")
        MageNugCD3_Frame_Texture:SetTexture(texture)
        MageNugCD3_Frame:Show()
    elseif(MageNugCD4_Frame_Bar:GetValue() < 1)then
        MageNugCD4_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD4_Frame_Text:SetText(name)
        MageNugCD4_Frame_Text2:SetText("!")
        MageNugCD4_Frame_Texture:SetTexture(texture)
        MageNugCD4_Frame:Show()
    elseif(MageNugCD5_Frame_Bar:GetValue() < 1)then
        MageNugCD5_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD5_Frame_Text:SetText(name)
        MageNugCD5_Frame_Text2:SetText("!")
        MageNugCD5_Frame_Texture:SetTexture(texture)
        MageNugCD5_Frame:Show()
    elseif(MageNugCD6_Frame_Bar:GetValue() < 1)then
        MageNugCD6_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD6_Frame_Text:SetText(name)
        MageNugCD6_Frame_Text2:SetText("!")
        MageNugCD6_Frame_Texture:SetTexture(texture)
        MageNugCD6_Frame:Show()
    end
end
--
function MNCooldownToggle()
    local cdChecked = MageNugCooldownFrame_cdButton:GetChecked();
    if (cdChecked == 1) then
        MageNugz.cooldownToggle = true;
        MageNugCD_Frame:Hide();
    else  
        MageNugz.cooldownToggle = false;
        MageNugCD_Frame:Show();
    end
end
--
function MageNuggetsCD1_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then   
        local start, duration, enabled = GetSpellCooldown(MageNugCD1_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD1_Frame_Bar:SetValue(timeleft);
            MageNugCD1_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD1_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCD2_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then   
        local start, duration, enabled = GetSpellCooldown(MageNugCD2_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then    
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD2_Frame_Bar:SetValue(timeleft);
            MageNugCD2_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD2_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCD3_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then   
        local start, duration, enabled = GetSpellCooldown(MageNugCD3_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD3_Frame_Bar:SetValue(timeleft);
            MageNugCD3_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD3_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCD4_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then   
        local start, duration, enabled = GetSpellCooldown(MageNugCD4_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then            
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD4_Frame_Bar:SetValue(timeleft);
            MageNugCD4_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD4_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCD5_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then   
        local start, duration, enabled = GetSpellCooldown(MageNugCD5_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD5_Frame_Bar:SetValue(timeleft);
            MageNugCD5_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD5_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MageNuggetsCD6_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then   
        local start, duration, enabled = GetSpellCooldown(MageNugCD6_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD6_Frame_Bar:SetValue(timeleft);
            MageNugCD6_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD6_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
function MNapCooldown()
    local isChecked = MageNugCooldownFrame_apButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.apCooldown = true;
    else  
        MageNugz.apCooldown = false;
    end
end
--
function MNbwCooldown()
    local isChecked = MageNugCooldownFrame_bwButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.bwCooldown = true;
    else  
        MageNugz.bwCooldown = false;
    end
end
--
function MNcbCooldown()
    local isChecked = MageNugCooldownFrame_cbButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.cbCooldown = true;
    else  
        MageNugz.cbCooldown = false;
    end
end
--
function MNcsCooldown()
    local isChecked = MageNugCooldownFrame_csButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.csCooldown = true;
    else  
        MageNugz.csCooldown = false;
    end
end
--
function MNdfCooldown()
    local isChecked = MageNugCooldownFrame_dfButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.dfCooldown = true;
    else  
        MageNugz.dfCooldown = false;
    end
end
--
function MNdbCooldown()
    local isChecked = MageNugCooldownFrame_dbButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.dbCooldown = true;
    else  
        MageNugz.dbCooldown = false;
    end
end
--
function MNmwCooldown()
    local isChecked = MageNugCooldownFrame_mwButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.mwCooldown = true;
    else  
        MageNugz.mwCooldown = false;
    end
end
--
function MNfrzCooldown()
    local isChecked = MageNugCooldownFrame_frzButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.frzCooldown = true;
    else  
        MageNugz.frzCooldown = false;
    end
end
--
function MNmsCooldown()
    local isChecked = MageNugCooldownFrame_msButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.msCooldown = true;
    else  
        MageNugz.msCooldown = false;
    end
end
--
function MNmiCooldown()
    local isChecked = MageNugCooldownFrame_miButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.miCooldown = true;
    else  
        MageNugz.miCooldown = false;
    end
end
--
function MNibrCooldown()
    local isChecked = MageNugCooldownFrame_ibrButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.ibrCooldown = true;
    else  
        MageNugz.ibrCooldown = false;
    end
end
--
function MNevoCooldown()
    local isChecked = MageNugCooldownFrame_evoButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.evoCooldown = true;
    else  
        MageNugz.evoCooldown = false;
    end
end
--
function MNivCooldown()
    local isChecked = MageNugCooldownFrame_ivButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.ivCooldown = true;
    else  
        MageNugz.ivCooldown = false;
    end
end
--
function MNtreantCooldown()
    local isChecked = MageNugCooldownFrame_treantButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.treantCooldown = true;
    else  
        MageNugz.treantCooldown = false;
    end
end
--
function MNstarfallCooldown()
    local isChecked = MageNugCooldownFrame_starfallButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.starfallCooldown = true;
    else  
        MageNugz.starfallCooldown = false;
    end
end
--
function MNcooldownSlider()
    local tempInt = MageNugCooldownFrame_Slider1:GetValue()
    if (tempInt == 0) then
        MageNugCD_Frame:SetScale(0.7);
        MageNugz.cooldownSize = 0;
    end
    if (tempInt == 1) then
        MageNugCD_Frame:SetScale(0.8);
        MageNugz.cooldownSize = 1;
    end
    if (tempInt == 2) then
        MageNugCD_Frame:SetScale(0.9);
        MageNugz.cooldownSize = 2;
    end
    if (tempInt == 3) then
        MageNugCD_Frame:SetScale(1.0);
        MageNugz.cooldownSize = 3;
    end
    if (tempInt == 4) then
        MageNugCD_Frame:SetScale(1.1);
        MageNugz.cooldownSize = 4;
    end
    if (tempInt == 5) then
        MageNugCD_Frame:SetScale(1.2);
        MageNugz.cooldownSize = 5;
    end
    if (tempInt == 6) then
        MageNugCD_Frame:SetScale(1.3);
        MageNugz.cooldownSize = 6;
    end
end
-----------------
function  MageNugSpMonitorSize() --Function for the SP Slider
    local tempInt = MageNugStatMonOptionFrame_SPSizeSlider:GetValue()
    if (tempInt == 0) then
        MageNugSP_Frame:SetScale(0.7);
        MageNugz.spMonitorSize = 0;
    end
    if (tempInt == 1) then
        MageNugSP_Frame:SetScale(0.8);
        MageNugz.spMonitorSize = 1;
    end
    if (tempInt == 2) then
        MageNugSP_Frame:SetScale(0.9);
        MageNugz.spMonitorSize = 2;
    end
    if (tempInt == 3) then
        MageNugSP_Frame:SetScale(1.0);
        MageNugz.spMonitorSize = 3;
    end
    if (tempInt == 4) then
        MageNugSP_Frame:SetScale(1.1);
        MageNugz.spMonitorSize = 4;
    end
    if (tempInt == 5) then
        MageNugSP_Frame:SetScale(1.2);
        MageNugz.spMonitorSize = 5;
    end
    if (tempInt == 6) then
        MageNugSP_Frame:SetScale(1.3);
        MageNugz.spMonitorSize = 6;
    end
end

function  MageNugSSMonitorSize() -- SS Slider
    local tempInt = MageNugOptionsFrame_Slider2:GetValue()
    if (tempInt == 0) then
        MNSpellSteal_Frame:SetScale(0.7);
        MageNugz.ssMonitorSize = 0;
    end
    if (tempInt == 1) then
        MNSpellSteal_Frame:SetScale(0.8);
        MageNugz.ssMonitorSize = 1;
    end
    if (tempInt == 2) then
        MNSpellSteal_Frame:SetScale(0.9);
        MageNugz.ssMonitorSize = 2;
    end
    if (tempInt == 3) then
        MNSpellSteal_Frame:SetScale(1.0);
        MageNugz.ssMonitorSize = 3;
    end
    if (tempInt == 4) then
        MNSpellSteal_Frame:SetScale(1.1);
        MageNugz.ssMonitorSize = 4;
    end
    if (tempInt == 5) then
        MNSpellSteal_Frame:SetScale(1.2);
        MageNugz.ssMonitorSize = 5;
    end
    if (tempInt == 6) then
        MNSpellSteal_Frame:SetScale(1.3);
        MageNugz.ssMonitorSize = 6;
    end
end

function  MageNugProcMonitorSize() --Proc Slider
    local tempInt = MageNugOptionsFrame_Slider4:GetValue()
    if (tempInt == 0) then
        MageNugProcFrame:SetScale(0.7);
        MageNugMBProcFrame:SetScale(0.7);
        MageNugFoFProcFrame:SetScale(0.7);
        MageNugBFProcFrame:SetScale(0.7);
        MageNugImpactProcFrame:SetScale(0.7);
        MageNugz.procMonitorSize = 0;
    end
    if (tempInt == 1) then
        MageNugProcFrame:SetScale(0.8);
        MageNugMBProcFrame:SetScale(0.8);
        MageNugFoFProcFrame:SetScale(0.8);
        MageNugBFProcFrame:SetScale(0.8);
        MageNugImpactProcFrame:SetScale(0.8);
        MageNugz.procMonitorSize = 1;
    end
    if (tempInt == 2) then
        MageNugProcFrame:SetScale(0.9);
        MageNugMBProcFrame:SetScale(0.9);
        MageNugFoFProcFrame:SetScale(0.9);
        MageNugBFProcFrame:SetScale(0.9);
        MageNugImpactProcFrame:SetScale(0.9);
        MageNugz.procMonitorSize = 2;
    end
    if (tempInt == 3) then
        MageNugProcFrame:SetScale(1.0);
        MageNugMBProcFrame:SetScale(1.0);
        MageNugFoFProcFrame:SetScale(1.0);
        MageNugBFProcFrame:SetScale(1.0);
        MageNugImpactProcFrame:SetScale(1.0);
        MageNugz.procMonitorSize = 3;
    end
    if (tempInt == 4) then
        MageNugProcFrame:SetScale(1.1);
        MageNugMBProcFrame:SetScale(1.1);
        MageNugFoFProcFrame:SetScale(1.1);
        MageNugBFProcFrame:SetScale(1.1);
        MageNugImpactProcFrame:SetScale(1.1);
        MageNugz.procMonitorSize = 4;
    end
    if (tempInt == 5) then
        MageNugProcFrame:SetScale(1.2);
        MageNugMBProcFrame:SetScale(1.2);
        MageNugFoFProcFrame:SetScale(1.2);
        MageNugBFProcFrame:SetScale(1.2);
        MageNugImpactProcFrame:SetScale(1.2);
        MageNugz.procMonitorSize = 5;
    end
    if (tempInt == 6) then
        MageNugProcFrame:SetScale(1.3);
        MageNugMBProcFrame:SetScale(1.3);
        MageNugFoFProcFrame:SetScale(1.3);
        MageNugBFProcFrame:SetScale(1.3);
        MageNugImpactProcFrame:SetScale(1.3);
        MageNugz.procMonitorSize = 6;
    end
end

function MageNugPolyFrameSize()
     local tempInt = MageNugOption2Frame_Slider1:GetValue()
    if (tempInt == 0) then
        MageNugPolyFrame:SetScale(0.7);
        MageNugz.polyFrameSize = 0;
    end
    if (tempInt == 1) then
        MageNugPolyFrame:SetScale(0.8);
        MageNugz.polyFrameSize = 1;
    end
    if (tempInt == 2) then
        MageNugPolyFrame:SetScale(0.9);
        MageNugz.polyFrameSize = 2;
    end
    if (tempInt == 3) then
        MageNugPolyFrame:SetScale(1.0);
        MageNugz.polyFrameSize = 3;
    end
    if (tempInt == 4) then
        MageNugPolyFrame:SetScale(1.2);
        MageNugz.polyFrameSize = 4;
    end
    if (tempInt == 5) then
        MageNugPolyFrame:SetScale(1.4);
        MageNugz.polyFrameSize = 5;
    end
    if (tempInt == 6) then
        MageNugPolyFrame:SetScale(1.6);
        MageNugz.polyFrameSize = 6;
    end
end

function MageNugLivingBombSize() 
 local tempInt = MageNugOptionsFrame_Slider3:GetValue()
    if (tempInt == 0) then
        MageNugAB_Frame:SetScale(0.7);
        MageNugLB_Frame:SetScale(0.7);
        MageNugManaGem_Frame:SetScale(0.7);
        MageNugClearcast_Frame:SetScale(0.7);
        MageNugIgnite_Frame:SetScale(0.7);
        MageNugz.livingBCounterSize = 0;
    end
    if (tempInt == 1) then
        MageNugAB_Frame:SetScale(0.8);
        MageNugLB_Frame:SetScale(0.8);
        MageNugIgnite_Frame:SetScale(0.8);
        MageNugManaGem_Frame:SetScale(0.8);
        MageNugClearcast_Frame:SetScale(0.8);
        MageNugz.livingBCounterSize = 1;
    end
    if (tempInt == 2) then
        MageNugAB_Frame:SetScale(0.9);
        MageNugLB_Frame:SetScale(0.9);
        MageNugIgnite_Frame:SetScale(0.9);
        MageNugManaGem_Frame:SetScale(0.9);
        MageNugClearcast_Frame:SetScale(0.9);
        MageNugz.livingBCounterSize = 2;
    end
    if (tempInt == 3) then
        MageNugAB_Frame:SetScale(1.0);
        MageNugLB_Frame:SetScale(1.0);
        MageNugManaGem_Frame:SetScale(1.0);
        MageNugClearcast_Frame:SetScale(1.0);
        MageNugIgnite_Frame:SetScale(1.0);
        MageNugz.livingBCounterSize = 3;
    end
    if (tempInt == 4) then
        MageNugAB_Frame:SetScale(1.1);
        MageNugLB_Frame:SetScale(1.1);
        MageNugManaGem_Frame:SetScale(1.1);
        MageNugIgnite_Frame:SetScale(1.1);
        MageNugClearcast_Frame:SetScale(1.1);
        MageNugz.livingBCounterSize = 4;
    end
    if (tempInt == 5) then
        MageNugAB_Frame:SetScale(1.2);
        MageNugLB_Frame:SetScale(1.2);
        MageNugIgnite_Frame:SetScale(1.2);
        MageNugManaGem_Frame:SetScale(1.2);
        MageNugClearcast_Frame:SetScale(1.2);
        MageNugz.livingBCounterSize = 5;
    end
    if (tempInt == 6) then
        MageNugAB_Frame:SetScale(1.3);
        MageNugLB_Frame:SetScale(1.3);
        MageNugIgnite_Frame:SetScale(1.3);
        MageNugManaGem_Frame:SetScale(1.3);
        MageNugClearcast_Frame:SetScale(1.3);
        MageNugz.livingBCounterSize = 6;
    end
end

function Tab2_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF".."Messages are picked at random.")
  GameTooltip:Show()
end

function Monitors_OnEnter()
  if (MageNugz.toolTips == true) then
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."You can disable or resize this".." \n".."monitor in options.")
    GameTooltip:Show()
    end
end

function SPMonitor_OnEnter()
    if (MageNugz.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."You can customize or disable this".." \n".."monitor in options.")
        GameTooltip:Show()
    end
end

function MNcooldownOnEnter()
     if (MageNugz.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."See Mage Nuggets Options -> Cooldowns")
        GameTooltip:Show()
    end
end

function RoundCrit(critNum) 
    return math.floor(critNum*math.pow(10,2)+0.5) / math.pow(10,2) 
end

function RoundThree(critNum) 
    return math.floor(critNum*math.pow(10,3)+0.5) / math.pow(10,3) 
end

function RoundOne(inputNum) 
    return math.floor(inputNum*math.pow(10,1)+0.5) / math.pow(10,1) 
end

function RoundZero(inputNum)
    return math.floor(inputNum*math.pow(10,0)+0.5) / math.pow(10,0) 
end



function CombatText_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."Checking this will disable all notifications sent to".." \n".."the chat console. This includes polymorph, evocation,".." \n".."spellsteal notifications and all other chat console notifications.")
  GameTooltip:Show()
end

function MageProc_OnEnter()
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."The in game combat text must be turned on".." \n".."for mage proc combat text to function.")
    GameTooltip:Show()
end

function MNLockFrames(self)
    if (MageNugz.lockFrames == false)then
       self:StartMoving(); self.isMoving = true;
    end
end

function BorderTypeSlider()
    local tempInt = MageNugStatMonOptionFrame_BorderSlider:GetValue()
    if (tempInt == 0) then
         MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 0;
    end
    if (tempInt == 1) then
         MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                    tile = true, tileSize = 16, edgeSize = 8, 
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 1;
    end
    if (tempInt == 2) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 2;
    end
    if (tempInt == 3) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                                    tile = true, tileSize = 16, edgeSize = 8, 
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 3;
    end
    if (tempInt == 4) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 4;
    end
    if (tempInt == 5) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
                                    tile = true, tileSize = 16, edgeSize = 8, 
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 5;
    end
    if (tempInt == 6) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 6;
    end
end

function BackdropTransparencySlider()
    local tempInt = MageNugStatMonOptionFrame_TransparencySlider:GetValue()
    if (tempInt == 0) then
        MageNugz.backdropA = 1.0;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 0;
    end
    if (tempInt == 1) then
        MageNugz.backdropA = 0.85;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 1;
    end
    if (tempInt == 2) then
        MageNugz.backdropA = 0.7;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 2;
    end
    if (tempInt == 3) then
        MageNugz.backdropA = 0.55;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 3;
    end
    if (tempInt == 4) then
        MageNugz.backdropA = 0.4;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 4;
    end
    if (tempInt == 5) then
        MageNugz.backdropA = 0.25;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 5;
    end
    if (tempInt == 6) then
        MageNugz.backdropA = 0.0;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 6;
    end
end

function MNSetBackdropBlack()
    MageNugz.backdropR = 0.0;
    MageNugz.backdropG = 0.0;
    MageNugz.backdropB = 0.0;
    MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
end

function MNColorSelector()
    MageNugz.backdropR, MageNugz.backdropG, MageNugz.backdropB = MageNugStatMonOptionFrameColorSelect:GetColorRGB();
    MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA);
end

function MageNugz_MinimapButton_Move()
	MageNug_MinimapFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(MageNugz.MinimapPos)),(80*sin(MageNugz.MinimapPos))-52)
end

function MageNugz_MinimapButton_DraggingFrame_OnUpdate()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
	xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70
	MageNugz.MinimapPos = math.deg(math.atan2(ypos,xpos))
    MageNugz_MinimapButton_Move()
end

function MageNuggets_Minimap_OnClick() 
    local englishFaction, localizedFaction = UnitFactionGroup("player")
    if (englishFaction == "Horde")then
        MageNugHordeFrame:Show();
    end
    if (englishFaction == "Alliance") then
        MageNugAlliFrame:Show();
    end   
end
--------Moonkin--------

function MageNuggetsMoonkin_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        barpower = UnitPower("player", 8);
        if(GetEclipseDirection() == 'sun') then
            MageNugMoonkin_Frame_Texture:SetTexture("Interface\\Icons\\spell_arcane_starfire");
            if(barpower < 0) then
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFLunar "..(barpower * -1));
            else
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFLunar "..barpower);
            end
            MageNugMoonkin_Frame_Bar:SetStatusBarColor(0, 0, 0.8)
            MageNugMoonkin_Frame_Bar:SetValue(barpower * -1);
        elseif (GetEclipseDirection() == 'moon') then
            MageNugMoonkin_Frame_Texture:SetTexture("Interface\\Icons\\spell_nature_abolishmagic");
            if(barpower < 0) then
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFSolar "..(barpower * -1));
            else
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFSolar "..barpower);
            end
            MageNugMoonkin_Frame_Bar:SetStatusBarColor(1, 0.5, 0)
            MageNugMoonkin_Frame_Bar:SetValue(barpower);
        end
    self.TimeSinceLastUpdate = 0;
    end   
end


function MageNugMoonSize()
    local tempInt = MageNugMoonkinOptionFrame_Slider:GetValue()
    if (tempInt == 0) then
        MageNugMoonkin_Frame:SetScale(0.7);
        MNmoonFire_Frame:SetScale(0.7);
        MNinsectSwarm_Frame:SetScale(0.7);
        MNstarSurge_Frame:SetScale(0.7);
        MageNugz.moonkinSize = 0;
    end
    if (tempInt == 1) then
       MageNugMoonkin_Frame:SetScale(0.8);
       MNmoonFire_Frame:SetScale(0.8);
       MNinsectSwarm_Frame:SetScale(0.8);
       MNstarSurge_Frame:SetScale(0.8);
       MageNugz.moonkinSize = 1;
    end
    if (tempInt == 2) then
        MageNugMoonkin_Frame:SetScale(0.9);
        MNmoonFire_Frame:SetScale(0.9);
        MNinsectSwarm_Frame:SetScale(0.9);
        MNstarSurge_Frame:SetScale(0.9);
        MageNugz.moonkinSize = 2;
    end
    if (tempInt == 3) then
        MageNugMoonkin_Frame:SetScale(1.0);
        MNmoonFire_Frame:SetScale(1.0);
        MNinsectSwarm_Frame:SetScale(1.0);
        MNstarSurge_Frame:SetScale(1.0);
        MageNugz.moonkinSize = 3;
    end
    if (tempInt == 4) then
        MageNugMoonkin_Frame:SetScale(1.1);
        MNmoonFire_Frame:SetScale(1.1);
        MNinsectSwarm_Frame:SetScale(1.1);
        MNstarSurge_Frame:SetScale(1.1);
        MageNugz.moonkinSize = 4;
    end
    if (tempInt == 5) then
        MageNugMoonkin_Frame:SetScale(1.2);
        MNmoonFire_Frame:SetScale(1.2);
        MNinsectSwarm_Frame:SetScale(1.2);
        MNstarSurge_Frame:SetScale(1.2);
        MageNugz.moonkinSize = 5;
    end
    if (tempInt == 6) then
        MageNugMoonkin_Frame:SetScale(1.4);
        MNmoonFire_Frame:SetScale(1.4);
        MNinsectSwarm_Frame:SetScale(1.4);
        MNstarSurge_Frame:SetScale(1.4);
        MageNugz.moonkinSize =  6;
    end
    if (tempInt == 7) then
        MageNugMoonkin_Frame:SetScale(1.7);
        MNmoonFire_Frame:SetScale(1.7);
        MNinsectSwarm_Frame:SetScale(1.7);
        MNstarSurge_Frame:SetScale(1.7);
        MageNugz.moonkinSize =  7;
    end
    if (tempInt == 8) then
        MageNugMoonkin_Frame:SetScale(2.0);
        MNmoonFire_Frame:SetScale(2.0);
        MNinsectSwarm_Frame:SetScale(2.0);
        MNstarSurge_Frame:SetScale(2.0);
        MageNugz.moonkinSize =  8;
    end
    if (tempInt == 9) then
        MageNugMoonkin_Frame:SetScale(2.2);
        MNmoonFire_Frame:SetScale(2.2);
        MNinsectSwarm_Frame:SetScale(2.2);
        MNstarSurge_Frame:SetScale(2.2);
        MageNugz.moonkinSize =  9;
    end
    if (tempInt == 10) then
        MNmoonFire_Frame:SetScale(2.7);
        MNinsectSwarm_Frame:SetScale(2.7);
        MNstarSurge_Frame:SetScale(2.7);
        MageNugMoonkin_Frame:SetScale(2.7);
        MageNugz.moonkinSize =  10;
    end
end

function MNmoonkinCombatToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton1:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinCombat = true;
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide()
        MNinsectSwarm_Frame:Hide()
        MNstarSurge_Frame:Hide()
    else  
        MageNugz.moonkinCombat = false;
        MageNugMoonkin_Frame:Show();
        MNmoonFire_Frame:Show()
        MNinsectSwarm_Frame:Show()
        MNstarSurge_Frame:Show()
    end

end

function MNmoonkinToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide()
        MNinsectSwarm_Frame:Hide()
        MNstarSurge_Frame:Hide()
    else  
        MageNugz.moonkinTog = false;
        if (MageNugz.moonkinCombat == false) then
            MageNugMoonkin_Frame:Show();
            MNmoonFire_Frame:Show()
            MNinsectSwarm_Frame:Show()
            MNstarSurge_Frame:Show()
        end
    end
end

function TreantSoundToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton2:GetChecked();
    if (isChecked == 1) then
        MageNugz.treantSoundTog = true;
    else  
        MageNugz.treantSoundTog = false;
    end
end

function MoonkinProcToggle()
    local isChecked = MageNugMoonkinOptionFrame_ProcCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinProcTog = true;
    else  
        MageNugz.moonkinProcTog = false;
    end
end

function MNmoonkinCombatTextToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton3:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinCombatText = true;
    else  
        MageNugz.moonkinCombatText = false;
    end
end

function MNcastFramesToggle()
    local isChecked = MageNugMoonkinOptionFrame_CastCheckButton:GetChecked();
    if (isChecked == 1) then
        MageNugz.castBoxes = true;
    else  
        MageNugz.castBoxes = false;
        MageNugCastStarsurgeFrame:Hide();
        MageNugCastMoonFrame:Hide();
        MageNugCastInsectFrame:Hide();
    end
end

function MNmoonkinAnchorToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButtonAnchor:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinAnchorTog = true;
        MNmoonFire_Frame:EnableMouse(false);
        MNmoonFire_Frame:ClearAllPoints();
        MNmoonFire_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", -2, 16);
        MNinsectSwarm_Frame:EnableMouse(false);
        MNinsectSwarm_Frame:ClearAllPoints();
        MNinsectSwarm_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 24, 16);
        MNstarSurge_Frame:ClearAllPoints();
        MNstarSurge_Frame:EnableMouse(false);
        MNstarSurge_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 50, 16);
    else  
        MageNugz.moonkinAnchorTog = false;
        MNmoonFire_Frame:EnableMouse(true);
        MNinsectSwarm_Frame:EnableMouse(true);
        MNstarSurge_Frame:EnableMouse(true);
    end
end

function  MageNugMoonkinProcSize() --Proc Slider
    local tempInt = MageNugMoonkinOptionFrame_Slider1:GetValue()
    if (tempInt == 0) then
        MageNugSSProcFrame:SetScale(0.7);
        MageNugCastStarsurgeFrame:SetScale(0.7);
        MageNugCastMoonFrame:SetScale(0.7);
        MageNugCastInsectFrame:SetScale(0.7);
        MageNugz.moonkinProcSize = 0;
    end
    if (tempInt == 1) then
        MageNugSSProcFrame:SetScale(0.8);
        MageNugCastStarsurgeFrame:SetScale(0.8);
        MageNugCastMoonFrame:SetScale(0.8);
        MageNugCastInsectFrame:SetScale(0.8);
        MageNugz.moonkinProcSize = 1;
    end
    if (tempInt == 2) then
        MageNugSSProcFrame:SetScale(0.9);
        MageNugCastStarsurgeFrame:SetScale(0.9);
        MageNugCastMoonFrame:SetScale(0.9);
        MageNugCastInsectFrame:SetScale(0.9);
        MageNugz.moonkinProcSize = 2;
    end
    if (tempInt == 3) then
        MageNugSSProcFrame:SetScale(1.0);
        MageNugCastStarsurgeFrame:SetScale(1.0);
        MageNugCastMoonFrame:SetScale(1.0);
        MageNugCastInsectFrame:SetScale(1.0);
        MageNugz.moonkinProcSize = 3;
    end
    if (tempInt == 4) then
        MageNugSSProcFrame:SetScale(1.1);
        MageNugCastStarsurgeFrame:SetScale(1.1);
        MageNugCastMoonFrame:SetScale(1.1);
        MageNugCastInsectFrame:SetScale(1.1);
        MageNugz.moonkinProcSize = 4;
    end
    if (tempInt == 5) then
        MageNugSSProcFrame:SetScale(1.2);
        MageNugCastStarsurgeFrame:SetScale(1.2);
        MageNugCastMoonFrame:SetScale(1.2);
        MageNugCastInsectFrame:SetScale(1.2);
        MageNugz.moonkinProcSize = 5;
    end
    if (tempInt == 6) then
        MageNugSSProcFrame:SetScale(1.4);
        MageNugCastStarsurgeFrame:SetScale(1.4);
        MageNugCastMoonFrame:SetScale(1.4);
        MageNugCastInsectFrame:SetScale(1.4);
        MageNugz.moonkinProcSize = 6;
    end
end

function MNmoonkinminimalToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButtonMin:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinMin = true;
        MageNugMoonkin_Frame_Texture:Hide();
    else  
        MageNugz.moonkinMin = false;
        MageNugMoonkin_Frame_Texture:Show();
    end
end

function MNmoonkinBoxToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton0:GetChecked();
    if (isChecked == 1) then
        MageNugz.moonkinBoxTog = true;
    else  
        MageNugz.moonkinBoxTog = false;
    end
end


function MNmoonFire_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        moonfireTime = 0;
        local i = 1;
        local buffName, rank, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        while buffName do
            if(spellId == 8921) then
                moonfireTime = RoundOne(expirationTime - GetTime());
            end
            if(spellId == 93402) then
                moonfireTime = RoundOne(expirationTime - GetTime());
            end
            i = i + 1;
            buffName, rank, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        end     
        if(moonfireTime <= 0.5) then
            MNmoonFire_FrameText:SetText(" ")                
            MNmoonFire_Frame:SetAlpha(1);
            if(MageNugz.castBoxes == true)then
                if(incombat == 1) then
                    MageNugCastMoonFrame:Show();
               end
            end
        else    
            MNmoonFire_FrameText:SetText(moonfireTime);
            MNmoonFire_Frame:SetAlpha(0.5);
            MageNugCastMoonFrame:Hide();
        end
        self.TimeSinceLastUpdate = 0;
    end
end

function MNinsectSwarm_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        insectTime = 0;
        local i = 1;
        local buffName, rank, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        while buffName do
            if(spellId == 5570) then
                insectTime = RoundOne(expirationTime - GetTime());
            end
            i = i + 1;
            buffName, rank, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        end     
        if(insectTime <= 0.5) then
            MNinsectSwarm_FrameText:SetText(" ")                
            MNinsectSwarm_Frame:SetAlpha(1);
            if(MageNugz.castBoxes == true)then
                if(incombat == 1) then
                    MageNugCastInsectFrame:Show();
                end
            end
        else    
            MNinsectSwarm_FrameText:SetText(insectTime);
            MNinsectSwarm_Frame:SetAlpha(0.5);
            MageNugCastInsectFrame:Hide();
    
        end
        self.TimeSinceLastUpdate = 0;
    end
end

function MNstarSurge_OnUpdate(self, elapsed) 
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then   
        local ssstart, ssduration, ssenabled = GetSpellCooldown(78674);
        starsurgeTime = RoundOne(ssstart + ssduration - GetTime())       
        if (starsurgeTime > 1.5) then
            MNstarSurge_FrameText:SetText(starsurgeTime)
            MNstarSurge_Frame:SetAlpha(0.5);
            MageNugCastStarsurgeFrame:Hide();
        elseif (starsurgeTime > 1.0) then
            MNstarSurge_FrameText:SetText("gcd")
        else
            MNstarSurge_FrameText:SetText(" ")
            MNstarSurge_Frame:SetAlpha(1);
            if(MageNugz.castBoxes == true)then
               if(incombat == 1)then
                MageNugCastStarsurgeFrame:Show();
                end
            end
        end
        self.TimeSinceLastUpdate = 0;
    end
end

function MNanchorMoonkinFrames()
    MNmoonFire_Frame:ClearAllPoints();
    MNmoonFire_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", -2, 16);
    MNinsectSwarm_Frame:ClearAllPoints();
    MNinsectSwarm_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 24, 16);
    MNstarSurge_Frame:ClearAllPoints();
    MNstarSurge_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 50, 16);
end