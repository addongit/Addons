CombustionHelper = {} 
LibTransition = LibStub("LibTransition-1.0"); 
CombuLSM = LibStub("LibSharedMedia-3.0") 

Combustion_UpdateInterval = 0.1; -- How often the OnUpdate code will run (in seconds)
local lvb,ffb,ignite,pyro1,pyro2,comb,impact,CritMass,ShadowMast,combulbtimer,combuffbtimer,combupyrotimer,combucrittimer,combupyrocast, combuclientVersion
local LBTime,FFBTime,IgnTime,PyroTime,CombustionUp,ffbglyph,combufadeout,impactup,ffbheight,critheight,combucritwidthl,lbraidcheck,lbtablerefresh,combuimpacttimer
local combulbrefresh,lbraidcheck,lbtablerefresh,lbgroupsuffix,lbtargetsuffix,lbgroupnumber,lbtrackerheight,combupyrogain,combupyrorefresh,combucolorinstance
local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical
                                               
function Combustion_OnLoad(Frame) 
                                               
    if select(2, UnitClass("player")) ~= "MAGE" then CombustionFrame:Hide() return end
        
	Frame:RegisterForDrag("LeftButton")
	Frame:RegisterEvent("PLAYER_LOGIN")
	Frame:RegisterEvent("PLAYER_TALENT_UPDATE")
	Frame:RegisterEvent("GLYPH_ADDED")
	Frame:RegisterEvent("GLYPH_REMOVED")
	Frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	Frame:RegisterEvent("PLAYER_REGEN_ENABLED")
 	Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
 	CombuLSM.RegisterCallback(CombustionHelper , "LibSharedMedia_Registered", "SharedMedia_Registered") 
	CombuLSM.RegisterCallback(CombustionHelper , "LibSharedMedia_Registered", "SharedMedia_Registered") 


    lvb = GetSpellInfo(44457) 
    ffb = GetSpellInfo(44614) 
    ignite = GetSpellInfo(12654) 
    pyro1 = GetSpellInfo(11366) 
    pyro2 = GetSpellInfo(92315) 
    comb = GetSpellInfo(11129)   
    impact = GetSpellInfo(64343)
    CritMass = GetSpellInfo(22959)
    ShadowMast = GetSpellInfo(17800)
    combudot = GetSpellInfo(83853)
    
    LibTransition:Attach(Frame)

	local version = GetBuildInfo() -- e.g. "4.0.6"
	local a, b, c = strsplit(".", version) -- e.g. "4", "0", "6"
	combuclientVersion = 10000*a + 100*b + c -- e.g. 40006

            	   	
-------------------------------
--Default values    
    if (combuffb == nil) then combuffb = true end
    if (combuautohide == nil) or (combuautohide == false) or (combuautohide == true) then combuautohide = 1 end -- set autohide off as default upon very first launch
    if (combuimpact == nil) then combuimpact = true end-- set impact mode on as default upon very first launch
    if (combuscale == nil) then combuscale = 1 end-- set scale default upon very first launch
    if (combubeforefade == nil) then combubeforefade = 15 end-- set before fade out autohide upon very first launch
    if (combuafterfade == nil) then combuafterfade = 15 end-- set before fade in autohide upon very first launch
    if (combufadeoutspeed == nil) then combufadeoutspeed = 2 end-- set fade out speed default upon very first launch
    if (combufadeinspeed == nil) then combufadeinspeed = 2 end-- set fade in speed default upon very first launch
    if (combuwaitfade == nil) then combuwaitfade = 86 end-- set faded time autohide default upon very first launch
    if (combufadealpha == nil) then combufadealpha = 0 end-- set alpha value for fade upon very first launch
    if (combubartimers == nil) then combubartimers = false end-- set bar timers upon very first launch
	if (combubarwidth == nil) then combubarwidth = 24 end-- set bar timers width upon very first launch
    if (combured == nil) then combured = 0 end-- set alpha value for fade upon very first launch
    if (combugreen == nil) then combugreen = 0.5 end-- set bar timers upon very first launch
	if (combublue == nil) then combublue = 0.8 end-- set bar timers width upon very first launch
	if (combuopacity == nil) then combuopacity = 1 end-- set bar timers width upon very first launch
	if (combucrit == nil) then combucrit = true end-- set bar timers width upon very first launch
	if (comburefreshmode == nil) then comburefreshmode = true end-- set LB refresh warning mode upon very first launch
    if (combureport == nil) then combureport = true end -- set DPS report on upon very first launch
    if (combureportvalue == nil) then combureportvalue = 0 end -- set DPS report value on upon very first launch
    if (combureportthreshold == nil) then combureportthreshold = false end -- set DPS report threshold on upon very first launch
    if (combureportpyro == nil) then combureportpyro = true end -- set Pyro report on upon very first launch
    if (combutrack == nil) then combutrack = true end -- set combustion dot tracker upon very first launch
    if (combuchat==nil) then combuchat = true end -- set status report upon very first launch 
    if (combulbtracker==nil) then combulbtracker = true end -- set living bomb tracker upon very first launch 
    if (combulbtarget==nil) then combulbtarget = false end -- set lb tracker complete mode upon very first launch 
    if (combulbup==nil) then combulbup = true end -- set lb tracker upward upon very first launch 
    if (combulbdown==nil) then combulbdown = false end -- set lb tracker upward upon very first launch 
    if (combulbright==nil) then combulbup = false end -- set lb tracker upward upon very first launch 
    if (combulbleft==nil) then combulbup = false end -- set lb tracker upward upon very first launch 
    if (combutimervalue==nil) then combutimervalue = 2 end -- set red zone timer value upon very first launch 
    if (combuignitereport == nil) then combuignitereport = true end -- set ignite munching report upon very first launch
    if (combuignitedelta == nil) then combuignitedelta = 0 end -- set ignite munching report upon very first launch
    if (combuignitepredict == nil) then combuignitepredict = true end -- set beta ignite predicter on upon very first launch
    if (combureportmunching == nil) then combureportmunching = true end -- set Ignite munching report on upon very first launch
    if (combuflamestrike == nil) then combuflamestrike = true end -- set Flamestrike tracker on upon very first launch
    if (combusettingstable == nil) then combusettingstable = combudefaultsettingstable end -- set default settings on very first launch
    
	combupyrogain = 0
   	combupyrorefresh = 0
   	combupyrocast = 0
   	combulbrefresh = 0
   	
   	combuignitebank = 0
    combuigniteapplied = 0
    combuignitevalue = 0
    combuignitetemp = 0
    combuignitemunched = 0

end

combudefaultsettingstable = {  barcolornormal = {1,1,1,1},
							barcolorwarning = {1,0,0,1},
							bartexture = "Interface\AddOns\CombustionHelper\Images\combubarblack",
							textcolornormal = {1,1,1,1},
							textcolorwarning = {1,0,0,1},
							textcolorvalid = {0,1,0,1},
							textfont = "Fonts\FRIZQT__.TTF",
							buttontexturewarning = "Interface\AddOns\CombustionHelper\Images\Combustionoff",
							buttontexturevalid = "Interface\AddOns\CombustionHelper\Images\Combustionon",
							bgcolornormal = {0.25,0.25,0.25,0.5},
							bgcolorimpact = {1,0.82,0,0.5},
							bgcolorcombustion = {0,0.7,0,0.5},
							bgFile = "Interface\Tooltips\UI-Tooltip-Background",
							edgecolornormal = {0.67,0.67,0.67,1},
							edgeFile="Interface\Tooltips\UI-Tooltip-Border"
}

function CombustionHelper:SharedMedia_Registered()
--	print("prut")
    -- do whatever needs to be done to repaint / refont
end

-------------------------------
-- helper function for option panel setup
function CombustionHelperOptions_OnLoad(panel)
	panel.name = "CombustionHelper"
	InterfaceOptions_AddCategory(panel);
end

-------------------------------
-- helper function for customisation option panel setup
--function CombustionHelperCustomOptions_OnLoad(panel)
--	panel.name = "Graphical Options"
--	panel.parent = "CombustionHelper"
--	InterfaceOptions_AddCategory(panel);
--end

-------------------------------
-- lock function for option panel
function Combustionlock()

	if CombulockButton:GetChecked(true) then combulock = true 
                                 CombustionFrame:EnableMouse(false)
                                 CombulockButton:SetChecked(true)
                                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCombustionHelper locked|r") end
	else combulock = false 
         CombustionFrame:EnableMouse(true)
         CombulockButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCombustionHelper unlocked|r") end
	end
end

-------------------------------
-- chat function for option panel
function Combustionchat()

	if CombuchatButton:GetChecked(true) then combuchat = true 
                                 CombuchatButton:SetChecked(true)
                                 ChatFrame1:AddMessage("|cff00ffffCombustionHelper status report enabled|r")
	else combuchat = false 
         CombuchatButton:SetChecked(false)
	end
end

-------------------------------
-- lock function for option panel
function Combustionthreshold()

	if Combureportthreshold:GetChecked(true) then combureportthreshold = true 
                                 Combureportthreshold:SetChecked(true)
	else combureportthreshold = false 
         Combureportthreshold:SetChecked(false)
	end
end

-------------------------------
-- ffb function for option panel
function Combustionffb()

	if CombuffbButton:GetChecked(true) then combuffb = true 
                                 CombuffbButton:SetChecked(true)
                                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFrostFire Bolt mode enabled|r") end
	else combuffb = false 
         CombuffbButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFrostFire Bolt mode disabled|r") end
	end
    CombustionFrameresize()
end

-------------------------------
-- DPS Report function for option panel
function Combustionreport()

	if CombureportButton:GetChecked(true) then combureport = true 
                                             CombureportButton:SetChecked(true)
                                             if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffDamage report mode enabled|r") end
	else combureport = false 
         CombureportButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffDamage report mode disabled|r") end
	end
end

-------------------------------
-- combustion dot tracker function for option panel
function Combustiontracker()

	if CombutrackerButton:GetChecked(true) then combutrack = true 
                                             CombutrackerButton:SetChecked(true)
                                             if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCombustion dot tracker enabled|r") end
	else combutrack = false 
         CombutrackerButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCombustion dot tracker disabled|r") end
	end
end

-------------------------------
-- lb refresh function for option panel
function Combustionrefresh()

	if ComburefreshButton:GetChecked(true) then comburefreshmode = true 
                                                ComburefreshButton:SetChecked(true)
                                                if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffEarly LB refresh mode enabled|r") end
	else comburefreshmode = false 
         ComburefreshButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffEarly LB refresh mode disabled|r") end
	end
end

-------------------------------
-- pyro refresh function for option panel
function CombustionrefreshPyro()

	if ComburefreshpyroButton:GetChecked(true) then combureportpyro = true 
                                                ComburefreshpyroButton:SetChecked(true)
                                                if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffPyroblast report mode enabled|r") end
	else combureportpyro = false 
         ComburefreshpyroButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffPyroblast refresh mode disabled|r") end
	end
end

-------------------------------
-- impact function for option panel
function Combustionimpact()

	if CombuimpactButton:GetChecked(true) then combuimpact = true 
                                               CombuimpactButton:SetChecked(true)
                                               if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffImpact mode enabled|r") end
	else combuimpact = false 
         CombuimpactButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffImpact mode disabled|r") end
	end
end

-------------------------------
-- Scale function for option panel
function CombustionScale (scale)

	CombustionFrame:SetScale(scale)
	combuscale = scale
end

-------------------------------
-- Bar timer function for option panel
function Combustionbar()

	if CombuBarButton:GetChecked(true) then combubartimers = true 
                                            CombuBarButton:SetChecked(true)
                                            if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffBar timer mode enabled|r") end
	else combubartimers = false 
         CombuBarButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffBar timer mode disabled|r") end
	end
    CombustionFrameresize()
end

-------------------------------
-- Critical Mass function for option panel
function Combustioncrit()

	if CombucritButton:GetChecked(true) then combucrit = true 
                                             CombucritButton:SetChecked(true)
                                             if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCritical Mass tracker enabled|r") end
	else combucrit = false 
         CombucritButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCritical Mass tracker disabled|r") end
	end
    CombustionFrameresize()
end

-------------------------------
-- Ignite beta predicter function for option panel
function CombustionIgnite()

	if CombuIgnitePredictButton:GetChecked(true) then combuignitepredict = true 
                                             CombuIgnitePredictButton:SetChecked(true)
                                             if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffBeta ignite predicter enabled|r") end
	else combuignitepredict = false 
         CombuIgnitePredictButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffBeta ignite predicter disabled|r") end
	end
end

-------------------------------
-- living bomb tracker target mode function for option panel
function CombustionFlamestrike()

	if CombuFlamestrikeButton:GetChecked(true) then combuflamestrike = true 
                                                 	CombuFlamestrikeButton:SetChecked(true)
                                             		if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFlamestrike tracker enabled|r") end
	else combuflamestrike = false 
         CombuFlamestrikeButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFlamestrike tracker disabled|r") end
	end
end

-------------------------------
-- living bomb tracker target mode function for option panel
function CombustionMunching()

	if CombuMunchingButton:GetChecked(true) then combureportmunching = true 
                                                 CombuMunchingButton:SetChecked(true)
                                             	 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffIgnite munching report enabled|r") end
	else combureportmunching = false 
         CombuMunchingButton:SetChecked(false)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffIgnite munching report disabled|r") end
	end
end

-------------------------------
-- living bomb tracker target mode function for option panel
function CombustionLBtargettracker()

	if CombuLBtargetButton:GetChecked(true) then combulbtarget = true 
                                                 CombuLBtargetButton:SetChecked(true)
	else combulbtarget = false 
         CombuLBtargetButton:SetChecked(false)
	end
end

-------------------------------
-- Multiple Living Bomb tracker function for option panel
function CombustionLBtracker()

	if CombuLBtrackerButton:GetChecked(true) then combulbtracker = true 
                                             CombuLBtrackerButton:SetChecked(true)
                                             if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffLiving Bomb tracker enabled|r") end
	else combulbtracker = false 
         CombuLBtrackerButton:SetChecked(false)
         table.wipe(LBtrackertable)
         if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffLiving Bomb tracker disabled|r") end
	end
    CombustionFrameresize()
end

-------------------------------
-- table for option mouseover info
combuoptioninfotable = {

	["CombuScaleSlider"] = "Use this slider to adjust the size of CombustionHelper. Note that you'll have to replace it at its position afterwards.",
	["CombulockButton"] = "Lock the frame when checked, unlock the frame when unchecked.",
	["CombucritButton"] = "Enable the tracker for Spell Critical Strike debuff provided by firemages and warlocks on your target.",
	["ComburefreshButton"] = "Enable the warning mode in chat frame when you refresh a Living Bomb too early or when you miss your Living Bomb spell on your target (also enable the 'fizzle' sound).",
	["CombureportButton"] = "Add value report of damage ticks for each spells monitored by CombustionHelper. There is a small delay because info will available only after the first tick happened.",
	["Combureportthreshold"] = "Enable then set a value in the editbox to have the background color changing for Combustion and Impact only when the sum of all dots will be higher than set value.",
	["Combureportvalue"] = "Enable then set a value in the editbox to have the background color changing for Combustion and Impact only when the sum of all dots will be higher than set value.",
	["CombuIgnitePredictButton"] = "Enable the beta predicter for Ignite damage report. This allow to have instant info instead of waiting for the tick to happen. Value added using this mode will have a * before the text, so you know that this is maybe non accurate info. If the predicted value is right then the text will turn green when the tick will happen and red when not.",
	["CombuIgniteAdjustbutton"] = "The beta predicter monitors crits happening within a set timeframe to know how the damage will behave. The latency (lag) can change the accuracy of it. First test on a dummy with scorch spam, if you see lot of red text, change this value in increment of 0,1 secs until you see more green text.", 
	["CombuIgniteAdjustvalue"] = "The beta predicter monitors crits happening within a set timeframe to know how the damage will behave. The latency (lag) can change the accuracy of it. First test on a dummy with scorch spam, if you see lot of red text, change this value in increment of 0,1 secs until you see more green text.",
	["CombuffbButton"] = "Enable or disable FrostFire dot tracking, regardless of the presence of FFB glyph.",
	["CombuTimerbutton"] = "Enter a value in seconds to adjust the red zone of all the timer bars of the addon.",
	["CombuTimervalue"] = "Enter a value in seconds to adjust the red zone of all the timer bars of the addon.",
	["ComburefreshpyroButton"] = "Enable the warning in chat frame when you forget to use your Hot Streak proc and also enable the report at the end of the fight.",
	["CombuimpactButton"] = "Enable tracking of Impact procs and background color changing in when combustion is on cooldown.",
	["CombutrackerButton"] = "Add a timer bar in Combustion status frame to show the current duration of applied Combustion on your target",
	["CombuchatButton"] = "Enable or disable outputs in chat frame for settings changes and autohide information.",
	["CombuLBtrackerButton"] = "Enable or disable the multi target Living Bomb tracker. This add a small panel with information on all your Living Bomb spells.",
	["CombuLBtargetButton"] = "Enable or disable the green pointer in multi target Living Bomb tracker showing your current target within the list.",
	["LBtrackerPosition"] = "Use the Dropdown menu to set the position of the multi target Living Bomb tracker around CombustionHelper main frame.",
	["LBtrackerDropDown"] = "Use the Dropdown menu to set the position of the multi target Living Bomb tracker around CombustionHelper main frame.",
	["AutohideInfo"] = "Use the Dropdown menu to choose the Autohide mode of CombustionHelper. No Autohide : keep frame visible at all times. Autohide only out of combat : only show panel in combat whether Combustion is up or not. Autohide OOC and Combustion off cd : only show when Combustion is up and in combat.",
	["CombuAutohideDropDown"] = "Use the Dropdown menu to choose the Autohide mode of CombustionHelper. No Autohide : keep frame visible at all times. Autohide only out of combat : only show panel in combat whether Combustion is up or not. Autohide OOC and Combustion off cd : only show when Combustion is up and in combat.",
	["CombuBarButton"] = "Enable or disable timer bars for Living Bomb, Ignite, Pyroblast dot and FrostFire dot.",
	["CombuBarSlider"] = "Use this slider to adjust the width of the timer bars for Living Bomb, Ignite, Pyroblast dot and FrostFire dot. This will also change the width of the main frame.",
	["Combubarcolornormal"] = "Clicking on this color swatch will open the color picker to change the colors of all the timer bars of CombustionHelper.",
	["CombubeforefadeSlider"] = "This slider will change the time in seconds before the frame will start to autohide after Combustion have been used. Default is 15 seconds.",
	["CombufadeoutspeedSlider"] = "This slider will change the time in seconds of the speed to hide the panel when autohiding. Default is 2 seconds.",
	["CombufadedtimeText"] = "This value show the time in seconds the panel will spend being hidden between Combustion uses. You cannot change this value directly since it's related to the other settings around.",
	["CombufadedtimeFrame"] = "This value show the time in seconds the panel will spend being hidden between Combustion uses. You cannot change this value directly since it's related to the other settings around.",
	["CombufadeinspeedSlider"] = "This slider will change the time in seconds of the speed to show the panel when coming out of hiding. Default is 2 seconds.",
	["CombuafterfadeSlider"] = "This slider will change the time in seconds when the frame come out of hiding before Combustion become available. Default is 15 seconds.",
	["ComburesetButton"] = "Use this button when you messed up with the settings and want to go back to clean state. After having used it, best practice is to logout and login for everything to be resetted.",
	["CombuFlamestrikeButton"] = "Enable or disable the Flamestrike tracker. It will track separately the regular Flamestrike and the Flamestrike procced by using Blastwave with Improved Flamestrike since both dot stacks. Only the last cast of each type will be tracked to avoid unnecessary timers.",
	["CombuMunchingButton"] = "Enable or disable the Ignite munching report. It'll record each fire spell criticals and every Ignite application. At the end of the fight it'll report to you these numbers so you know how much damage you have lost due to munching and early dying of your targets. This information, though not being critical, will allow you to know your supposed damage. IMPORTANT NOTICE : due to impact and dot spreading, only criticals done to your current target will be taken in account !! Also this feature rely on the ignite predicter mechanics, so it need to be enabled for it to work."
}

-------------------------------
-- table for bar and fontstrings list
local combuwidgetlist = {
	
	bars = {"LBtrack1Bar","LBtrack2Bar","LBtrack3Bar","LBtrack4Bar","LBtrack5Bar","FFBbar","Pyrobar","Ignbar","LBbar","Combubar","Critbar"},
	text = {"LBtrack1","LBtrack1Timer","LBtrack2","LBtrack2Timer","LBtrack3","LBtrack3Timer","LBtrack4","LBtrack4Timer","LBtrack5","LBtrack5Timer",
			"LBLabel","IgniteLabel","PyroLabel","FFBLabel","LBTextFrameLabel","IgnTextFrameLabel","PyroTextFrameLabel","FFBTextFrameLabel",
			"StatusTextFrameLabel","CritTypeFrameLabel","CritTextFrameLabel"},
}
			
-------------------------------
-- Helper function for frame resizing
function CombustionFrameresize()
	
    if (combuffb == true) and (ffbglyph == true)
    then FFBButton:Show()
         FFBTextFrameLabel:Show()
         FFBLabel:Show()
         StatusTextFrameLabel:SetPoint("TOPLEFT",FFBLabel,"BOTTOMLEFT",0,0)
         ffbheight = 9
    else FFBButton:Hide()
         FFBTextFrameLabel:Hide()
         FFBLabel:Hide()
         StatusTextFrameLabel:SetPoint("TOPLEFT",PyroLabel,"BOTTOMLEFT",0,0)
         ffbheight = 0	
    end

    if (combucrit == true) 
    then CritTypeFrameLabel:Show()
         CritTypeFrameLabel:SetPoint("TOPLEFT",StatusTextFrameLabel,"BOTTOMLEFT",0,0)
         CritTextFrameLabel:Show()
         CritTextFrameLabel:SetPoint("TOPLEFT",StatusTextFrameLabel,"BOTTOMLEFT",0,0)
         critheight = 9
    else CritTypeFrameLabel:Hide()
         CritTypeFrameLabel:SetPoint("TOPLEFT",StatusTextFrameLabel,"BOTTOMLEFT",0,0)
         CritTextFrameLabel:Hide()
         CritTextFrameLabel:SetPoint("TOPLEFT",StatusTextFrameLabel,"BOTTOMLEFT",0,0)
         Critbar:Hide()
         critheight = 0
    end    
    
    CombustionFrame:SetHeight(48+ffbheight+critheight)

	if (combubartimers == true) 
	then CombustionFrame:SetWidth(98+combubarwidth+6)
		 CombustionTextFrame:SetWidth(98+combubarwidth+6)
		 FFBTextFrameLabel:SetWidth(28+combubarwidth+2)
		 FFBTextFrameLabel:SetJustifyH("RIGHT")
		 LBTextFrameLabel:SetWidth(28+combubarwidth+2)
		 LBTextFrameLabel:SetJustifyH("RIGHT")
		 PyroTextFrameLabel:SetWidth(28+combubarwidth+2)
		 PyroTextFrameLabel:SetJustifyH("RIGHT")
		 IgnTextFrameLabel:SetWidth(28+combubarwidth+2)
		 IgnTextFrameLabel:SetJustifyH("RIGHT")
		 CritTextFrameLabel:SetWidth(91+combubarwidth+2)
         combucritwidth = combubarwidth
	elseif (combubartimers == false) 
	then combucritwidth = (-7)
         CombustionFrame:SetWidth(98)
         CombustionTextFrame:SetWidth(98)
		 FFBTextFrameLabel:SetWidth(28)
		 FFBbar:Hide()
		 FFBTextFrameLabel:SetJustifyH("LEFT")
		 LBTextFrameLabel:SetWidth(28)
		 LBbar:Hide()
		 LBTextFrameLabel:SetJustifyH("LEFT")
		 PyroTextFrameLabel:SetWidth(28)
		 Pyrobar:Hide()
		 PyroTextFrameLabel:SetJustifyH("LEFT")
		 Ignbar:Hide()
		 IgnTextFrameLabel:SetWidth(28)
		 IgnTextFrameLabel:SetJustifyH("LEFT")
		 CritTextFrameLabel:SetWidth(86)
	end
	
	Critbar:SetMinMaxValues(0,92+combucritwidth)
	Critbar:SetWidth(92+combucritwidth)
	Combubar:SetMinMaxValues(0,92+combucritwidth)
	Combubar:SetWidth(92+combucritwidth)
	LBbar:SetMinMaxValues(0,28+combubarwidth)
	LBbar:SetWidth(28+combubarwidth)
	Ignbar:SetMinMaxValues(0,28+combubarwidth)
	Ignbar:SetWidth(28+combubarwidth)
	Pyrobar:SetMinMaxValues(0,28+combubarwidth)
	Pyrobar:SetWidth(28+combubarwidth)
	FFBbar:SetMinMaxValues(0,28+combubarwidth)
	FFBbar:SetWidth(28+combubarwidth)
	
	if (combulbtracker == true) then 
		
		LBtrackFrame:Show()
        LBtrackFrame:SetFrameLevel((CombustionFrame:GetFrameLevel())-1)
        LBtrackFrame:ClearAllPoints()

        if (combulbup == true)
            then LBtrackFrame:SetPoint("BOTTOM",CombustionFrame,"TOP",0,-6)
                 LBtrackFrame:SetWidth((CombustionFrame:GetWidth())-10)
        elseif (combulbdown == true)
            then LBtrackFrame:SetPoint("TOP",CombustionFrame,"BOTTOM",0,6)
                 LBtrackFrame:SetWidth((CombustionFrame:GetWidth())-10)
        elseif (combulbright == true)
            then LBtrackFrame:SetWidth(88)
                 LBtrackFrame:SetPoint("TOPLEFT",CombustionFrame,"TOPRIGHT",-6,0)
        elseif (combulbleft == true)
            then LBtrackFrame:SetWidth(88)
                 LBtrackFrame:SetPoint("TOPRIGHT",CombustionFrame,"TOPLEFT",6,0)
        end
        
        LBtrackFrameText:SetWidth(LBtrackFrame:GetWidth())
        LBtrackFrameText:SetPoint("TOPLEFT",LBtrackFrame,"TOPLEFT",0,0)
        
    else LBtrackFrame:Hide()
	end
    
    for i = 1,5 do _G["LBtrack"..i]:SetWidth(LBtrackFrame:GetWidth()-41) end
    for i = 1,5 do _G["LBtrack"..i.."Bar"]:SetWidth(LBtrackFrame:GetWidth()-12) end
    for i = 1,5 do _G["LBtrack"..i.."Bar"]:SetMinMaxValues(0,LBtrackFrame:GetWidth()-12) end
    
end

-------------------------------
-- helper function reset Savedvariables
function Combustionreset ()
 		combulock = false
        combuffb = true
        combuautohide = 1
        combuimpact = true
        combuscale = 1
        combubeforefade = 15
		combuafterfade = 15
		combufadeoutspeed = 2
		combufadeinspeed = 2
		combuwaitfade = 86
		combufadealpha = 0
		combubartimers = false
		combured = 0
		combugreen = 0.5
		combublue = 0.8
		combuopacity = 1
        combucrit = true
        CombustionFrame:ClearAllPoints()
        CombustionFrame:SetPoint("CENTER", UIParent, "CENTER" ,0,0)
        CombustionFrame:SetScale(1)
        comburefreshmode = true
        combureport = true
        combureportvalue = 0
        combureportthreshold = false
        combureportpyro = true
        combutrack = true
        combuchat = true
        combulbtracker = true
        combulbup = true
        combulbdown = false
        combulbright = false
        combulbleft = false
        combulbtarget = true
        combutimervalue = 2
        combuignitereport = true
        combuignitedelta = 0
        combuignitepredict = true
		combureportmunching = true
		combuflamestrike = true
        ChatFrame1:AddMessage("|cff00ffffCombustionHelper Savedvariables have been resetted, you can logout now.|r")
end
	

-------------------------------
-- Color picker function
function CombuColorPicker(instance)

	combucolorinstance = instance
 	ColorPickerFrame:SetColorRGB((combusettingstable[instance])[1],(combusettingstable[instance])[2],(combusettingstable[instance])[3]);
 	ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = ((combusettingstable[instance])[4] ~= nil), (combusettingstable[instance])[4];
 	ColorPickerFrame.previousValues = {(combusettingstable[instance])[1],(combusettingstable[instance])[2],(combusettingstable[instance])[3],(combusettingstable[instance])[4]};
 	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = CombuCallback, CombuCallback, CombuCallback;
 	ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
 	ColorPickerFrame:Show();

end

function CombuCallback (restore)

	local newR, newG, newB, newA;
	
	if restore then
		  newR, newG, newB, newA = unpack(restore);
	else newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
	end
	
	(combusettingstable[combucolorinstance])[1],(combusettingstable[combucolorinstance])[2],(combusettingstable[combucolorinstance])[3],(combusettingstable[combucolorinstance])[4] = newR, newG, newB, newA
	
    _G["Combu"..combucolorinstance.."SwatchTexture"]:SetVertexColor((combusettingstable[combucolorinstance])[1],(combusettingstable[combucolorinstance])[2],(combusettingstable[combucolorinstance])[3],(combusettingstable[combucolorinstance])[4])
	
end


-------------------------------
-- Helper function for ffb glyph check
local function Combuffbglyphcheck ()

        local enabled1,_,_,id1 = GetGlyphSocketInfo(7)
        local enabled4,_,_,id4 = GetGlyphSocketInfo(8)
        local enabled6,_,_,id6 = GetGlyphSocketInfo(9)
         
	            if (id1 == 61205) and (ffbglyph == false) and (combutalent == true) 
	            then ffbglyph = true
                     combuffb = true
    	       		 CombustionFrameresize()
	                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFrostfire Bolt glyph detected, FFB mode enabled|r") end
	            
	            elseif (id4 == 61205) and (ffbglyph == false) and (combutalent == true) 
	            then ffbglyph = true
                     combuffb = true
    	       		 CombustionFrameresize()
	                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFrostfire Bolt glyph detected, FFB mode enabled|r") end
	            
	            elseif (id6 == 61205) and (ffbglyph == false) and (combutalent == true) 
	            then ffbglyph = true
                     combuffb = true
    	       		 CombustionFrameresize()
	                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffFrostfire Bolt glyph detected, FFB mode enabled|r") end
				
				elseif (id1 ~= 61205) and (id4 ~= 61205) and (id6 ~= 61205) and (ffbglyph == true) and (combutalent == true)
				then ffbglyph = false
					 CombustionFrameresize()
	                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffff No Frostfire Bolt glyph detected, FFB mode disabled|r") end
	            
                elseif (id1 ~= 61205) and (id4 ~= 61205) and (id6 ~= 61205) and (combuffb == true) 
				then ffbglyph = false
					 CombustionFrameresize()
	                 if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffff No Frostfire Bolt glyph detected, FFB mode disabled|r") end

                elseif (ffbglyph == false)
	            then CombustionFrameresize()

            	end 
end

-------------------------------
--table for increased critical damage meta
local CombuCritMeta = {
	34220, -- burning crusade
	41285, -- wrath of the lich king
	52291, -- cataclysm
    68780
};

-------------------------------
--empty table for living bomb tracking
LBtrackertable = {}

-------------------------------
--Helper function for living bomb tracking expiration time collecting
local function CombuLBauratracker(targetguid, targetname, eventgettime)

	lbraidcheck = 0
	lbtablerefresh = 0
    lbgroupsuffix = nil
    lbtargetsuffix = nil
    
    if (GetNumRaidMembers() ~= 0) 
        then lbgroupsuffix = "raid"
             lbgroupnumber = GetNumRaidMembers()
    elseif (GetNumPartyMembers() ~= 0)
        then lbgroupsuffix = "party"
             lbgroupnumber = GetNumPartyMembers()
    end
    
    if (UnitGUID("target") == targetguid)
        then lbtargetsuffix = "target"
    elseif (UnitGUID("mouseover") == targetguid)
        then lbtargetsuffix = "mouseover"
    elseif (UnitGUID("focus") == targetguid)
        then lbtargetsuffix = "focus"
    end
        
    if combuimpacttimer and ((combuimpacttimer + 1) >= GetTime())
        then local a12,b12,c12,d12,e12,f12,g12,h12,i12,j12,k12 = UnitAura("target", lvb, nil, "PLAYER HARMFUL")
             for z = 1, #LBtrackertable do
             
                if ((LBtrackertable[z])[1] == targetguid) 
                    then (LBtrackertable[z])[3] = g12;
                         (LBtrackertable[z])[4] = f12;
                         (LBtrackertable[z])[5] = nil
                         lbtablerefresh = 1
                         break
                end 
             end
             
             if (lbtablerefresh == 1) then
             else table.insert(LBtrackertable, {targetguid, targetname, g12, f12})
             end
             
             lbraidcheck = 1
        
	elseif lbtargetsuffix and (UnitGUID(lbtargetsuffix) == targetguid)
        then local a12,b12,c12,d12,e12,f12,g12,h12,i12,j12,k12 = UnitAura(lbtargetsuffix, lvb, nil, "PLAYER HARMFUL")
             for z = 1, #LBtrackertable do
             
                if ((LBtrackertable[z])[1] == targetguid) 
                    then (LBtrackertable[z])[3] = g12;
                         (LBtrackertable[z])[4] = f12;
                         (LBtrackertable[z])[5] = GetRaidTargetIndex(lbtargetsuffix)
                         lbtablerefresh = 1
                         break
                end 
             end
             
             if (lbtablerefresh == 1) then
             else table.insert(LBtrackertable, {targetguid, targetname, g12, f12, GetRaidTargetIndex(lbtargetsuffix)})
             end
             
             lbraidcheck = 1
        
    elseif lbgroupsuffix then
        for i = 1, lbgroupnumber do -- first we check if a raid or party members target the LB's target to have an accurate expiration time with UnitAura
            
            if (UnitGUID(lbgroupsuffix..i.."-target") == targetguid) 
                then local a12,b12,c12,d12,e12,f12,g12,h12,i12,j12,k12 = UnitAura(lbgroupsuffix..i.."-target", lvb, nil, "PLAYER HARMFUL")
                     
                     for z = 1, #LBtrackertable do
                     
                        if ((LBtrackertable[z])[1] == targetguid) 
                            then (LBtrackertable[z])[3] = g12;
                                 (LBtrackertable[z])[4] = f12;
                                 (LBtrackertable[z])[5] = GetRaidTargetIndex(lbgroupsuffix..i.."-target")
                                 lbtablerefresh = 1
                                 break
                        end 
                     end
                     
                     if (lbtablerefresh == 1) then
                     else table.insert(LBtrackertable, {targetguid, targetname, g12, f12, GetRaidTargetIndex(lbgroupsuffix..i.."-target")})
                     end
                     
                     lbraidcheck = 1
                
            end
        end
    end
 	
 	if (lbraidcheck == 0) -- info with UnitAura have been collected, skipping this part.
        then for z = 1, #LBtrackertable do -- no raid members targetting the LB's target so using GetTime from event fired and 12 secs as duration
                 
                if ((LBtrackertable[z])[1] == targetguid) 
                    then (LBtrackertable[z])[3] = (eventgettime + 12);
                         (LBtrackertable[z])[4] = 12;
                         (LBtrackertable[z])[5] = nil
                         lbtablerefresh = 1
                         break
                end 
             end
                     
             if (lbtablerefresh == 1) then
             else table.insert(LBtrackertable, {targetguid, targetname, (eventgettime + 12), 12, nil})
             end
	end
	
	for i = 6,1,-1 do
    	if LBtrackertable[i] and (((LBtrackertable[i])[1] == 2120) or ((LBtrackertable[i])[1] == 88148)) then 
    		table.insert(LBtrackertable,{(LBtrackertable[i])[1],(LBtrackertable[i])[2],(LBtrackertable[i])[3],(LBtrackertable[i])[4]});
    		table.remove(LBtrackertable,i);
    	end
    end
    
end

local function CombuLBtrackerUpdate()

    lbtrackerheight = 0
    
    for i = 5,1,-1 do
    
    	if LBtrackertable[i] and ((LBtrackertable[i])[3] + 2) <= GetTime() 
    		then table.remove(LBtrackertable,i)
    	end
    
        if (#LBtrackertable == 0) 
            then _G["LBtrack"..i]:SetText("")
                 _G["LBtrack"..i.."Timer"]:SetText("")
                 _G["LBtrack"..i.."Bar"]:Hide()
                 _G["LBtrack"..i.."Target"]:SetTexture("")
                 _G["LBtrack"..i.."Symbol"]:SetTexture("")
                 LBtrackFrame:Hide()
        elseif (#LBtrackertable == 1) and (UnitGUID("target") == (LBtrackertable[1])[1]) and (combulbtarget == false)
            then _G["LBtrack"..i]:SetText("")
                 _G["LBtrack"..i.."Timer"]:SetText("")
                 _G["LBtrack"..i.."Bar"]:Hide()
                 _G["LBtrack"..i.."Target"]:Hide()
                 _G["LBtrack"..i.."Symbol"]:Hide()
                 LBtrackFrame:Hide()
        elseif LBtrackertable[i] 
            then LBtrackFrame:Show()
                 _G["LBtrack"..i]:SetText((LBtrackertable[i])[2])
                 combulbtimer = (-1*(GetTime()-(LBtrackertable[i])[3]))

                 if (combulbtimer >= combutimervalue) then -- condition when timer is with more than 2 seconds left
                     _G["LBtrack"..i.."Timer"]:SetText(format("|cff00ff00%.1f|r",combulbtimer))
                     _G["LBtrack"..i.."Bar"]:Show()
                     _G["LBtrack"..i.."Bar"]:SetValue((LBtrackFrame:GetWidth()-12)*(combulbtimer/(LBtrackertable[i])[4]))
                     _G["LBtrack"..i.."Bar"]:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
                 elseif (combulbtimer <= combutimervalue) and (combulbtimer >= 0) then -- condition when timer is with less than 2 seconds left
                     _G["LBtrack"..i.."Timer"]:SetText(format("|cffff0000%.1f|r",combulbtimer))
                     _G["LBtrack"..i.."Bar"]:Show()
                     _G["LBtrack"..i.."Bar"]:SetValue((LBtrackFrame:GetWidth()-12)*(combulbtimer/(LBtrackertable[i])[4]))
                     _G["LBtrack"..i.."Bar"]:SetStatusBarColor(1,0,0,combuopacity)
                 elseif (combulbtimer <= 0) then
                     table.remove(LBtrackertable,i)
                 end
                 
                 if LBtrackertable[i] and (LBtrackertable[i])[5] then 
                 	_G["LBtrack"..i.."Symbol"]:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..(LBtrackertable[i])[5])
                 else _G["LBtrack"..i.."Symbol"]:SetTexture("")
                 end
                 
                 if LBtrackertable[i] and (UnitGUID("target") == (LBtrackertable[i])[1]) then
                    _G["LBtrack"..i.."Target"]:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustion_target")
                 else _G["LBtrack"..i.."Target"]:SetTexture("")
                 end
                 
                 lbtrackerheight = lbtrackerheight + 9
                 
        else 
             _G["LBtrack"..i]:SetText("")
             _G["LBtrack"..i.."Timer"]:SetText("")
             _G["LBtrack"..i.."Bar"]:Hide()
             _G["LBtrack"..i.."Target"]:SetTexture("")
             _G["LBtrack"..i.."Symbol"]:SetTexture("")
        end
    end
    
    LBtrackFrame:SetHeight(lbtrackerheight + 11)
    
end
                    
-------------------------------------------------------------------------------------------------------	
-------------------------------------------------------------------------------------------------------	
-------------------------------- ON_EVENT FUNCTION ----------------------------------------------------

function Combustion_OnEvent(self, event, ...)

    if (event == "PLAYER_LOGIN") then
    
	    if (CombustionFrame:GetFrameLevel() == 0) then
	        CombustionFrame:SetFrameLevel(1) -- fix when frame is at FrameLevel 0
	    end
	    
	    if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCombustion Helper is loaded. Interface Panel -> Addons for Config.|r") end
    
-------------------------------
--Combustion spell check on startup    
        local a6 = IsSpellKnown(11129) -- check if combustion is in the spellbook
                
        if (a6 == false) 
	        then CombustionFrame:FadeOut(combufadeoutspeed,combufadealpha)
	             combutalent = false
        elseif (a6 == true) 
	        then CombustionFrame:FadeIn(combufadeinspeed)
	             combutalent = true
        end
        
-------------------------------
--frostfirebolt glyph check on startup
        local enabled1,_,_,id1 = GetGlyphSocketInfo(7)
        local enabled4,_,_,id4 = GetGlyphSocketInfo(8)
        local enabled6,_,_,id6 = GetGlyphSocketInfo(9)
         
	    if (id1 == 61205) or (id4 == 61205) or (id6 == 61205)
	    	then ffbglyph = true
	    else ffbglyph = false
             combuffb = false
        end 
                
-------------------------------
--Frame lock check on startup
        if (combulock == false) 
	 		then CombustionFrame:EnableMouse(true)
        elseif (combulock == true) 
	    	then CombustionFrame:EnableMouse(false)
        end	
            
-------------------------------
--autohide check on startup
        if (combuautohide == 2) or (combuautohide == 3)
      		then CombustionFrame:FadeOut(combufadeoutspeed,combufadealpha)
 	    end	
        
	    CombustionScale (combuscale) -- Scale check on startup
	    CombustionFrameresize() -- Combustion Frame size check on startup    

    end
	
-------------------------------
--Combustion spell check      
    if (event == "PLAYER_TALENT_UPDATE") then
      
            local a6 = IsSpellKnown(11129) -- check if combustion is in the spellbook
                
            if (a6 == false) and (combutalent == true) then
                    CombustionFrame:FadeOut(combufadeoutspeed,combufadealpha)
                    combutalent = false
                    if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffNo Combustion spell in Spellbook, CombustionHelper hiding now.|r") end
            elseif (a6 == true) and (combutalent == false) then
                    CombustionFrame:FadeIn(combufadeinspeed)
                    combutalent = true
                    if (combuchat==true) then ChatFrame1:AddMessage("|cff00ffffCombustion spell in Spellbook, CombustionHelper back in.|r") end
                    CombustionFrameresize()
            end

    end
    
-------------------------------
--frostfirebolt glyph check
    if (event == "GLYPH_ADDED") or (event == "GLYPH_REMOVED")
        then Combuffbglyphcheck ()
             
    end
    
-------------------------------
--Combat log events checks
    if (event=="COMBAT_LOG_EVENT_UNFILTERED") then

    	if (combuclientVersion == 40006)
    		then timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical = select(1, ...)
    	else timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical = select(1, ...)
    	end
            
            if (sourceName == UnitName("player")) then
            
---------------------------------
-- Ignite prediction part                
                if (combuignitepredict == true) then
                    if (destGUID == UnitGUID("target")) then
                        if (critical == 1) and ((event == "SPELL_PERIODIC_DAMAGE") or (event == "SPELL_DAMAGE")) and ((spellSchool == 4) or (spellSchool == 20)) and (spellId ~= 83853) and (spellId ~= 89091) then
                        
                            combuigniteamount = format("%.0f",(amount * 0.4 * (((GetMastery()*2.8)/100)+1)))
                            combuignitevalue = combuignitevalue + combuigniteamount
                                                    
                            if (combuignitetimer >= 4.5 + combuignitedelta) then
                                combuignitemunched = combuignitemunched + combuigniteamount
                            elseif (combuignitetimer >= 1.7 - combuignitedelta) and (combuignitetimer <= 2.5 + combuignitedelta) then
                                combuignitetemp = combuignitetemp + combuigniteamount
                            elseif (combuignitetimer <= 0.5 + combuignitedelta) and (combuignitetimer ~= 0) then
                                combuignitetemp = combuignitetemp + combuigniteamount
                            elseif (combuignitetimer >= 3.8 - combuignitedelta) then
                                combuignitetemp = combuignitetemp + combuigniteamount
                            elseif (combuignitetimer >= 0.5 + combuignitedelta) then
                                combuignitecount = 3
                                combuignitebank = combuignitebank + combuigniteamount
                            else combuignitecount = 2
                                 combuignitebank = combuignitebank + combuigniteamount 
                            end
                            
                            if combuignitetemp ~= 0 and combuignitetimer == 0 then
                                combuignitecount = 3
                                combuignitebank = combuignitebank + combuignitetemp
                                combuignitetemp = 0
                            end
                            
                            combuignitepredicted = format("%.0f",combuignitebank / combuignitecount)
                            IgniteLabel:SetText(format("*%.0f Dmg", combuignitepredicted))
                            
                        elseif (event == "SPELL_PERIODIC_DAMAGE") and (spellId == 12654) then
                                                    
                            combuigniteapplied = combuigniteapplied + amount
                            combuignitebank = (combuignitecount - 1) * amount + combuignitetemp
                            combuignitecount = combuignitecount - 1

                            if (combuignitetemp ~= 0) and (combuignitetimer ~= 0) then
                                combuignitecount = 3
                            end
                            
                            combuignitetemp = 0
                                                    
                        elseif (event == "SPELL_AURA_REMOVED") and (spellId == 12654) then
                        --    print("ignite removed")
                  			IgniteLabel:SetText(format("|cffffffffIgnite|r"))
                        end
                    end
                end

-------------------------------------------
-- report event check 
				if (combureport == true) and (destGUID == UnitGUID("target")) then
					if (spellId == 44457) and (event == "SPELL_PERIODIC_DAMAGE") then 
						if (critical == 1) and (combumeta == true) then 
							combulbdamage = amount/2,03
						elseif (critical == 1) and (combumeta == false) then 
							combulbdamage = amount/2
						else combulbdamage = amount
						end
						LBLabel:SetText(format("%.0f Dmg", combulbdamage))
					elseif (spellId == 12654) and (event == "SPELL_PERIODIC_DAMAGE") then
						combuigndamage = amount
                        if (combuignitepredict == true) then
                        	if (tonumber(abs(combuignitepredicted-amount)) <= 3) then
 								IgniteLabel:SetText(format("|cff00ff00%.0f Dmg|r", combuigndamage))
 							else IgniteLabel:SetText(format("|cffff0000%.0f Dmg|r", combuigndamage))
 							end
 						else IgniteLabel:SetText(format("%.0f Dmg", combuigndamage))
 						end
					elseif ((spellId == 11366) and (event == "SPELL_PERIODIC_DAMAGE")) or ((spellId == 92315) and (event == "SPELL_PERIODIC_DAMAGE")) then 
						if (critical == 1) and (combumeta == true) then 
							combupyrodamage = amount/2,03
						elseif (critical == 1) and (combumeta == false) then 
							combupyrodamage = amount/2
						else combupyrodamage = amount
						end
						PyroLabel:SetText(format("%.0f Dmg", combupyrodamage))
					elseif (spellId == 44614) and (event == "SPELL_PERIODIC_DAMAGE") then 
						if (critical == 1) and (combumeta == true) then 
							combuffbdamage = amount/2,03
						elseif (critical == 1) and (combumeta == false) then 
							combuffbdamage = amount/2
						else combuffbdamage = amount
						end
						FFBLabel:SetText(format("%.0f Dmg", combuffbdamage))
					end
				end
                
-------------------------------------------
-- Living Bomb early refresh 
                if (comburefreshmode == true) and (spellId == 44457) then
                    if (event == "SPELL_AURA_REFRESH")
                        then combulbrefresh = combulbrefresh + 1
                             print(format("|cffff0000 -- You refreshed your Living bomb on |cffffffff%s |cffff0000too early. --|r",destName))
                    elseif (event == "SPELL_MISSED") 
                        then PlaySoundFile("Sound\\Spells\\SimonGame_Visual_BadPress.wav")
                             print(format("|cffff00ff -- Living Bomb cast on |cffffffff%s |cffff00ffmissed !! --",destName))
                    end
                end

-------------------------------------------
-- Living Bomb tracking 
                if (combulbtracker == true) and (spellId == 44457) then 
                	if (event == "SPELL_AURA_APPLIED") or (event == "SPELL_AURA_REFRESH") 
                		then CombuLBauratracker(destGUID, destName, GetTime())
                	elseif (event == "SPELL_AURA_REMOVED") 
                		then for i = 1,#LBtrackertable do
                 
								if LBtrackertable[i] and ((LBtrackertable[i])[1] == destGUID) 
                 					then table.remove(LBtrackertable,i)
                                         break
                 			 	end
                 			 end
                	end
                end
                
                -- Impact manager for LB tracking
                if (spellId == 2136) and (event == "SPELL_CAST_SUCCESS") -- successful impact cast
                    then combuimpacttimer = GetTime()
                elseif (spellId == 2136) and (event == "SPELL_MISSED")
                    then combuimpacttimer = nil
                end

-------------------------------------------
-- FlameStrike tracking 
			    if (combuflamestrike == true) and (spellId == 2120) or (spellId == 88148) then 
			    	if (event == "SPELL_DAMAGE") or (event == "SPELL_CAST_SUCCESS")
						then lbtablerefresh = 0
							 for z = 1, #LBtrackertable do
			               
					    		 if ((LBtrackertable[z])[1] == spellId) 
					            	then (LBtrackertable[z])[3] = (GetTime() + 8);
					                     (LBtrackertable[z])[4] = 8;
					                     (LBtrackertable[z])[5] = nil
					                     lbtablerefresh = 1
					                     break
					             end 
					         end
			                   
					         if (lbtablerefresh == 1) then
					         elseif (spellId == 2120) 
					         	then table.insert(LBtrackertable, {spellId, "Flamestrike", (GetTime() + 8), 8, nil})
					         elseif (spellId == 88148) 
					         	then table.insert(LBtrackertable, {spellId, "Blastwave FS", (GetTime() + 8), 8, nil})
					         end
					end
				end
						
-------------------------------------------
-- Pyroblast buff report 
                if (combureportpyro == true) then
                	if (spellId == 48108) and (event == "SPELL_AURA_APPLIED")
	                    then combupyrogain = combupyrogain + 1
	                elseif (spellId == 48108) and (event == "SPELL_AURA_REFRESH")
	                    then combupyrorefresh = combupyrorefresh + 1
	                    	print(format("|cffff0000 -- You just wasted a Hot Streak, it got refreshed before getting used. --|r"))
					elseif ((spellId == 11366) and (event == "SPELL_CAST_SUCCESS")) or ((spellId == 92315) and (event == "SPELL_CAST_SUCCESS"))  
	                    then combupyrocast = combupyrocast + 1
	                end
	            end
            end
    end
                
-------------------------------------------
-- Start and End of fight events 
    if (event == "PLAYER_REGEN_DISABLED") then 
    	
    	local gem1, gem2, gem3 = GetInventoryItemGems(1)
        
		if CombuCritMeta[gem1] or CombuCritMeta[gem2] or CombuCritMeta[gem3] 
			then combumeta = true
		else combumeta = false
		end  
		 
		if (combuautohide ~= 1) and (combutalent == true)-- autoshow when in combat
			then CombustionFrame:FadeIn(combufadeinspeed)
		end
		    
    elseif (event == "PLAYER_REGEN_ENABLED") then 
    
    	if (combureportmunching == true) then print("ignite expected :",combuignitevalue,"-- ignite applied :",combuigniteapplied,"-- ignite lost :",format("%.0f / %.0f%%",combuignitevalue-combuigniteapplied,(combuignitevalue-combuigniteapplied)/combuignitevalue*100)) end
        combuignitebank = 0
        combuigniteapplied = 0
        combuignitevalue = 0
        combuignitepredicted = 0
        combuignitemunched = 0
    	    
    	if (combuautohide ~= 1) and (combutalent == true)-- autohide when out of combat
        	then CombustionFrame:FadeOut(combufadeoutspeed,combufadealpha)
        end
    
    	if (combulbrefresh >= 1) then
        	print(format("|cffff0000 -- Earlier Living bomb refresh for this fight : |cffffffff%d |cffff0000--|r",combulbrefresh))
        	combulbrefresh = 0
        end
    
        if (combureportpyro == true) and (combupyrogain ~= 0) then
            print(format("|cffff0000 -- Hot Streak gained : |cffffffff%d  |cffff0000-- Hot Streak casted : |cffffffff%d  / %d%% |cffff0000--|r",combupyrogain + combupyrorefresh, combupyrocast, (100*(combupyrocast/(combupyrogain + combupyrorefresh)))))
            combupyrogain = 0
        	combupyrorefresh = 0
        	combupyrocast = 0
        end
        
        table.wipe(LBtrackertable) -- cleaning multiple LB tracker table when leaving combat
		IgniteLabel:SetText(format("|cffffffffIgnite|r"))
        
    end
-------------------------------
end
	
	
-------------------------------------------------------------------------------------------------------	
-------------------------------------------------------------------------------------------------------	
-------------------------------- ON_UPDATE FUNCTION ----------------------------------------------------

function Combustion_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = (self.TimeSinceLastUpdate or 0) + elapsed;
 
		if (self.TimeSinceLastUpdate > Combustion_UpdateInterval) then
            local time = GetTime()   
            
-------------------------------
--Living Bomb part
		local a,b,c,d,e,f,g,h,i,j,k = UnitAura("target", lvb, nil, "PLAYER HARMFUL")		
		
		if (k==44457) then 
			combulbtimer = (-1*(time-g))
		else combulbtimer = 0
			combulbdamage = 0
		end
		
		if (combulbtimer >= combutimervalue) and (combulbtimer ~= 0) then -- condition when timer is with more than 2 seconds left
			LBTextFrameLabel:SetText(format("|cff00ff00%.1f|r",combulbtimer))
			LBButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			LBTime = 1
		elseif (combulbtimer <= combutimervalue) and (combulbtimer ~= 0) then -- condition when timer is with less than 2 seconds left
			LBTextFrameLabel:SetText(format("|cffff0000%.1f|r",combulbtimer))
			LBButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			LBTime = 0
		else LBTextFrameLabel:SetText(format("|cffff0000LB|r")) 
			LBButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionoff") -- Text in red
			LBLabel:SetText(format("Living Bomb"))
			LBTime = 0
		end
			
		if (combubartimers == true) and (k==44457) and (combulbtimer <= combutimervalue) then
			LBbar:Show()
			LBbar:SetValue((28+combubarwidth)*((g-GetTime())/f))
			LBbar:SetStatusBarColor(1,0,0,combuopacity)
		elseif (combubartimers == true) and (k==44457) then 
			LBbar:Show()
			LBbar:SetValue((28+combubarwidth)*((g-GetTime())/f))
			LBbar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
		else LBbar:Hide()
		end
			
--------------------------------
--FrostfireBolt part
		local a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1 = UnitAura("target", ffb, nil, "PLAYER HARMFUL")		
		
		if (k1==44614) then 
			combuffbtimer = (-1*(time-g1))
		else combuffbtimer = 0
			combuffbdamage = 0
		end

 		if (ffbglyph == false) or (combuffb == false) then 
			FFBTime = 1
			FFBTextFrameLabel:SetText(format("|cffff0000Glyph|r"))
		elseif (combuffbtimer >= combutimervalue) and (combuffbtimer ~= 0) then -- condition when timer is with more than 2 seconds left
			FFBTextFrameLabel:SetText(format("|cff00ff00%.1f/%d|r",combuffbtimer,(d1)))
			FFBButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			FFBTime = 1
		elseif (combuffbtimer <= combutimervalue) and (combuffbtimer ~= 0) then -- condition when timer is with less than 2 seconds left
			FFBTextFrameLabel:SetText(format("|cffff0000%.1f/%d|r",combuffbtimer,(d1)))
			FFBButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			FFBTime = 0
		else FFBTextFrameLabel:SetText(format("|cffff0000FFB|r"))
			FFBButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionoff") -- Text in red
			FFBLabel:SetText(format("FrostFire Bolt"))
			FFBTime = 0
		end
			
		if (combubartimers == true) and (k1==44614) and (combuffbtimer <= combutimervalue) then 
			FFBbar:Show()
			FFBbar:SetValue((28+combubarwidth)*((g1-GetTime())/f1))
			FFBbar:SetStatusBarColor(1,0,0,combuopacity)
		elseif (combubartimers == true) and (k1==44614) then 
			FFBbar:Show()
			FFBbar:SetValue((28+combubarwidth)*((g1-GetTime())/f1))
			FFBbar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
		else FFBbar:Hide()
		end
			
--------------------------------
--Ignite part
		local a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2 = UnitAura("target", ignite, nil, "PLAYER HARMFUL")
		
		if (k2==12654) then 
			combuignitetimer = (-1*(time-g2))
		else combuignitetimer = 0
			combuigndamage = 0
		end
		
		if (combuignitetimer >= combutimervalue) and (combuignitetimer ~= 0) then -- condition when timer is with more than 2 seconds left
			IgnTextFrameLabel:SetText(format("|cff00ff00%.1f|r",combuignitetimer))
			IgniteButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			IgnTime = 1
		elseif (combuignitetimer <= combutimervalue) and (combuignitetimer ~= 0) then -- condition when timer is with less than 2 seconds left
			IgnTextFrameLabel:SetText(format("|cffff0000%.1f|r",combuignitetimer))
			IgniteButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			IgnTime = 0
		else IgnTextFrameLabel:SetText(format("|cffff0000Ign|r"))
			IgniteButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionoff") -- Text in red
			if (combuignitepredict ~= true) then IgniteLabel:SetText(format("Ignite")) end
			IgnTime = 0
		end
			
		if (combubartimers == true) and (k2==12654) and (combuignitetimer <= combutimervalue) then 
			Ignbar:Show()
			Ignbar:SetValue((28+combubarwidth)*((g2-GetTime())/f2))
			Ignbar:SetStatusBarColor(1,0,0,combuopacity)
		elseif (combubartimers == true) and (k2==12654) then 
			Ignbar:Show()
			Ignbar:SetValue((28+combubarwidth)*((g2-GetTime())/f2))
			Ignbar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
		else Ignbar:Hide()
		end
			
--------------------------------
--Pyroblast part
		local a3,b3,c3,d3,e3,f3,g3,h3,i3,j3,k3 = UnitAura("target", pyro1, nil, "PLAYER HARMFUL")		
		local a4,b4,c4,d4,e4,f4,g4,h4,i4,j4,k4 = UnitAura("target", pyro2, nil, "PLAYER HARMFUL")		
		
		if (k3==11366) then 
			combupyrotimer = (-1*(time-g3))
		elseif (k4==92315) then 
			combupyrotimer = (-1*(time-g4))
		else combupyrotimer = 0
			combupyrodamage = 0
		end
		
		if (combupyrotimer >= combutimervalue) and (combupyrotimer ~= 0) then -- condition when timer is with more than 2 seconds left
			PyroTextFrameLabel:SetText(format("|cff00ff00%.1f|r",combupyrotimer))
			PyroButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			PyroTime = 1
		elseif (combupyrotimer <= combutimervalue) and (combupyrotimer ~= 0) then -- condition when timer is with less than 2 seconds left
			PyroTextFrameLabel:SetText(format("|cffff0000%.1f|r",combupyrotimer))
			PyroButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionon")
			PyroTime = 0
		else PyroTextFrameLabel:SetText(format("|cffff0000Pyro|r"))
			PyroButton:SetTexture("Interface\\AddOns\\CombustionHelper\\Images\\Combustionoff") -- Text in red
			PyroLabel:SetText(format("Pyroblast"))
			PyroTime = 0
		end
            			
		if (combubartimers == true) and (k3==11366) and (combupyrotimer <= combutimervalue) then 
			Pyrobar:Show()
			Pyrobar:SetValue((28+combubarwidth)*((g3-GetTime())/f3))
			Pyrobar:SetStatusBarColor(1,0,0,combuopacity)
		elseif (combubartimers == true) and (k3==11366) then 
			Pyrobar:Show()
			Pyrobar:SetValue((28+combubarwidth)*((g3-GetTime())/f3))
			Pyrobar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
		elseif (combubartimers == true) and (k4==92315) and (combupyrotimer <= combutimervalue) then 
			Pyrobar:Show()
			Pyrobar:SetValue((28+combubarwidth)*((g4-GetTime())/f4))
			Pyrobar:SetStatusBarColor(1,0,0,combuopacity)
		elseif (combubartimers == true) and (k4==92315) then 
			Pyrobar:Show()
			Pyrobar:SetValue((28+combubarwidth)*((g4-GetTime())/f4))
			Pyrobar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
		else Pyrobar:Hide()
		end
		
--------------------------------
--Combustion/impact part
        local a5,b5,c5 = GetSpellCooldown(comb)
        local a7,b7,c7,d7,e7,f7,g7,h7,i7,j7,k7 = UnitAura("player", impact)
                
        if (b5 == nil) then
        elseif (b5<=2) and (combureport == true) and (InCombatLockdown() == 1) then -- to show dot total damage in combat with report enabled
            CombustionUp = 1
            ImpactUp = 0
            combufadeout = false
            combuchatautohide = 0
            if (combureportvalue <= (combulbdamage + combupyrodamage + combuigndamage + combuffbdamage)) and combureportthreshold then
                StatusTextFrameLabel:SetText(format("|cff00ff00Total : %.0f - CB Up|r", combulbdamage + combupyrodamage + combuigndamage + combuffbdamage))
            else StatusTextFrameLabel:SetText(format("|cffffcc00Total : %.0f - CB Up|r", combulbdamage + combupyrodamage + combuigndamage + combuffbdamage))
            end
        elseif (b5<=2) then -- condition when combustion cd is up, taking gcd in account
            StatusTextFrameLabel:SetText(format("Combustion Up !"))
            CombustionUp = 1
            ImpactUp = 0
            combufadeout = false
            combuchatautohide = 0
        elseif (b5>=2) and (k7 == 64343) and (combuimpact == true) then -- condition when impact is up and combustion in cd
            StatusTextFrameLabel:SetText(format("|cff00ff00Impact Up for %.1f !!|r",-1*(time-g7)))
            CombustionUp = 0
            ImpactUp = 1
            combufadeout = false
        elseif ((a5 + b5 - time)>=60) and (combufadeout == false) and (k7 == nil) then -- timer for combustion in minutes
            StatusTextFrameLabel:SetText(format("Combustion in %d:%0.2d",(a5 + b5 - time) / 60,(a5 + b5 - time) % 60 ))  
            CombustionUp = 0
            ImpactUp = 0
        elseif ((a5 + b5 - time)<=60) and (k7 == nil) then 
            StatusTextFrameLabel:SetText(format("Combustion in %.0fsec",(a5 + b5 - time)))  -- timer for combustion in seconds
            CombustionUp = 0	
            ImpactUp = 0
        end
            
--------------------------------
-- Critical Mass/shadow mastery tracking
    if (combucrit==true) then
            
        local a9,b9,c9,d9,e9,f9,g9,h9,i9,j9,k9 = UnitAura("target", CritMass, nil, "HARMFUL")
        local a10,b10,c10,d10,e10,f10,g10,h10,i10,j10,k10 = UnitAura("target", ShadowMast, nil, "HARMFUL")

        if (k9==22959) then combucrittimer = (-1*(time-g9))
        elseif (k10==17800) then combucrittimer = (-1*(time-g10))
        else combucrittimer = 0
        end

        if (combucrittimer >= combutimervalue) and (combucrittimer ~= 0) -- condition when timer is with more than 2 seconds left
                then CritTextFrameLabel:SetText(format("|cff00ff00%.1f|r",combucrittimer))
                     CritTextFrameLabel:SetJustifyH("RIGHT")
                     CritTypeFrameLabel:SetText(format("|cffffffff Critical Mass|r"))
        elseif (combucrittimer <= combutimervalue) and (combucrittimer ~= 0) -- condition when timer is with less than 2 seconds left
                then CritTextFrameLabel:SetText(format("|cffff0000%.1f|r",combucrittimer))
                     CritTextFrameLabel:SetJustifyH("RIGHT")
                     CritTypeFrameLabel:SetText(format("|cffffffff Critical Mass|r"))
        else CritTextFrameLabel:SetText(format("|cffff0000No Critical Mass !!|r"))
             CritTextFrameLabel:SetJustifyH("LEFT")
             CritTypeFrameLabel:SetText("")
        end
                    
        if (k9==22959) and (combucrittimer <= combutimervalue)
            then Critbar:Show()
             Critbar:SetValue((92+combucritwidth)*((g9-GetTime())/f9))
             Critbar:SetStatusBarColor(1,0,0,combuopacity)
        elseif (k9==22959)
            then Critbar:Show()
             Critbar:SetValue((92+combucritwidth)*((g9-GetTime())/f9))
             Critbar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
        elseif (k10==17800) and (combucrittimer <= combutimervalue) 
            then Critbar:Show()
             Critbar:SetValue((92+combucritwidth)*((g10-GetTime())/f10))
             Critbar:SetStatusBarColor(1,0,0,combuopacity)
        elseif (k10==17800) 
            then Critbar:Show()
             Critbar:SetValue((92+combucritwidth)*((g10-GetTime())/f10))
             Critbar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
        else Critbar:Hide()
        end
    end
            
--------------------------------
-- Combustion on target tracking
    if (combutrack==true) then
            
            local a11,b11,c11,d11,e11,f11,g11,h11,i11,j11,k11 = UnitAura("target", combudot, nil, "PLAYER HARMFUL")

			if (k11==83853) then combudottimer = (-1*(time-g11))
			else combudottimer = 0
			end

			if (k11==83853) and (combudottimer <= combutimervalue)
				then Combubar:Show()
                 Combubar:SetValue((92+combucritwidth)*((g11-GetTime())/f11))
                 Combubar:SetStatusBarColor(1,0,0,combuopacity)
			elseif (k11==83853)
				then Combubar:Show()
                 Combubar:SetValue((92+combucritwidth)*((g11-GetTime())/f11))
                 Combubar:SetStatusBarColor((combusettingstable["barcolornormal"])[1],(combusettingstable["barcolornormal"])[2],(combusettingstable["barcolornormal"])[3],(combusettingstable["barcolornormal"])[4])
            else Combubar:Hide()
			end
    
    else
    end
    
--------------------------------
-- Background/border colors settings
    if (combureportthreshold == true) then
    
    	if (CombustionUp == 1) and (combureportvalue <= (combulbdamage + combupyrodamage + combuigndamage + combuffbdamage)) and (combureportvalue ~= 0) 
        	then CombustionFrame:SetBackdropColor(0,0.7,0) --Green background for frame when threshold is met and combustion are up
            	 CombustionFrame:SetBackdropBorderColor(0,0.7,0)
        elseif (CombustionUp == 0) and (ImpactUp == 1) and (combureportvalue <= (combulbdamage + combupyrodamage + combuigndamage + combuffbdamage)) 
        	then CombustionFrame:SetBackdropColor(1,0.82,0.5) --yellow background for frame when threshold is met and impact are up
            	 CombustionFrame:SetBackdropBorderColor(1,0.82,0)
        else CombustionFrame:SetBackdropColor(0.25,0.25,0.25)
         	 CombustionFrame:SetBackdropBorderColor(0.67,0.67,0.67)
        end
        
    elseif (LBTime == 1) --Green background for frame when dots and combustion are up
        and (FFBTime == 1) 
        and (IgnTime == 1) 
        and (PyroTime == 1) 
        and (CombustionUp == 1)
        and (combureportthreshold == false) 
        then CombustionFrame:SetBackdropColor(0,0.7,0) --Green background for frame when dots and combustion are up
             CombustionFrame:SetBackdropBorderColor(0,0.7,0)
    elseif (LBTime == 1) --Yellow background for frame when dots and Impact are up
        and (FFBTime == 1) 
        and (IgnTime == 1) 
        and (PyroTime == 1) 
        and (ImpactUp == 1)
        and (CombustionUp == 0) 
        and (combureportthreshold == false) 
        then CombustionFrame:SetBackdropColor(1,0.82,0.5)
             CombustionFrame:SetBackdropBorderColor(1,0.82,0)
    else CombustionFrame:SetBackdropColor(0.25,0.25,0.25)
         CombustionFrame:SetBackdropBorderColor(0.67,0.67,0.67)
    end
    
    if (k7 == 64343) -- yellow border when impact is up
        then CombustionFrame:SetBackdropBorderColor(1,0.82,0)
    end
    
--------------------------------
 -- autohide part 
 	if (a5 == nil) then
	elseif ((a5 + b5 - time) <= (120 - combubeforefade)) and ((a5 + b5 - time) >= (combuafterfade + combufadeinspeed)) and (combufadeout == false) and (combuautohide == 3) then 
		combufadeout = true
	    StatusTextFrameLabel:SetText("Autohiding now.")
		CombustionFrame:FadeOut(combufadeoutspeed,combufadealpha);
		CombustionFrame:Wait(combuwaitfade);
		CombustionFrame:FadeIn(combufadeinspeed);
        if (combuchat==true) and (combuchatautohide == 0) 
        	then ChatFrame1:AddMessage(format("|cff00ffffCombustion Helper back in %d seconds|r", 120-combubeforefade-combuafterfade-combufadeoutspeed-combufadeinspeed))
        		 combuchatautohide = 1 
        end
	end
    
--------------------------------
-- multiple Living Bomb tracking
    if (combulbtracker == true) or (combuflamestrike == true)
        then CombuLBtrackerUpdate()
    end

--------------------------------
    self.TimeSinceLastUpdate = 0

    end    
end


SLASH_COMBUCONFIG1 = "/combustionhelper"

SlashCmdList["COMBUCONFIG"] = function(msg)

	if msg == "" or  msg == "help" or  msg == "?" or msg == "config" then
		 InterfaceOptionsFrame_OpenToCategory("CombustionHelper")
		 if (combuchat==true) then print(format("|cff00ffffOpening Combustion Helper config panel|r")) end
	else
		 InterfaceOptionsFrame_OpenToCategory("CombustionHelper")
		 if (combuchat==true) then print(format("|cff00ffffOpening Combustion Helper config panel|r")) end
	end

end