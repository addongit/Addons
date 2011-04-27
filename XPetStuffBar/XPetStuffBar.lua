--This is the internal name of the mod.
local XBARMOD="XPetStuffBar";
local dbver="6";

--Default settings and other info about the mod
XBarCore.ModData[XBARMOD] = {
	["nbuttons"]=0,
	["dbver"]=dbver,
	["dhorizontal"]=true,
	["hidebar"]=false,
	["dorder"]="az",
	["dscale"]=1,
	["dtooltips"]=true,
	["enabled"]=false,
	["nchecks"]=0,
	["wrappable"]=false,
	["sortable"]=true,
	["fbuttonid"]="XBar_StdButtonID",
	["fbuttoncb"]="XBar_StdButtonCB",
	["foptioncb"]=XBARMOD.."_OptionCB",
};

XBarCore.ModData.XPetStuffXP={
	["loaded"]=true,
};
local XPETSTUFFXPSETUP=false;

local XBAR_PETXP_H="Interface\\AddOns\\XPetStuffBar\\overlayh";
local XBAR_PETXP_V="Interface\\AddOns\\XPetStuffBar\\overlayv";

function XPetStuffBar_OnLoad(self)
	--Each bar must catch its own event notifications
	local Class,_;

	-- Nonlocalized class check
	_, Class = UnitClass("player");
	if (Class == "HUNTER") then
		self:RegisterEvent("SPELLS_CHANGED");
		self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		self:RegisterEvent("PLAYER_ENTERING_WORLD");
		self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		self:RegisterEvent("UNIT_PET_EXPERIENCE");
		self:RegisterEvent("UNIT_PET");
		XBarCore.ModData[XBARMOD].enabled=true;
	else
		self:SetScript("OnUpdate",nil);
		-- Reduces lag
	end
end

function XPetStuffBar_OnEvent(self,event,...)
	arg1=...;
	-- XPetStuffBar has some stuff it has to do after XBar is done with it
	XBar_StdEventHandler(XBARMOD,event,arg1);
	if (event == "PLAYER_ENTERING_WORLD") then
		XPetStuffXPBar_Setup(self);
		XPetStuffXPBar_UpdateScreen();
		XPetStuffXPBar_Update();
	elseif (event == "UNIT_PET_EXPERIENCE") then
		XPetStuffXPBar_Update();
	elseif (event == "UNIT_PET" and arg1=="player") then
		XPetStuffXPBar_Update();
	end
end

function XPetStuffBar_OptionCB(option,value)
	if (option=="XPBar") then
		XPetStuffXPBar_UpdateScreen();
	elseif (option=="XPBarText") then
		XPetStuffXPBar_UpdateScreen();
	elseif (option=="XPBarHorizontal") then
		XPetStuffXPBar_UpdateScreen();
	else
		XBar_Update(XBARMOD);
	end
end

function XPetStuffXPBar_OnEnter(self)
	local showtext=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBarText;

	if not showtext then
		TextStatusBar_UpdateTextString(self);
		ShowTextStatusBarText(self);
	end
end

function XPetStuffXPBar_OnLeave(self)
	local showtext=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBarText;

	if not showtext then
		TextStatusBar_UpdateTextString(self);
		HideTextStatusBarText(self);
	end
end

function XPetStuffXPBar_Setup()
	if not XPETSTUFFXPSETUP then

		TextStatusBar_Initialize(XPetStuffXPBar);
		SetTextStatusBarText(XPetStuffXPBar, XPetStuffXPBarText);
		XBarCore.FrameDB.XPetStuffXPBar={};
		if not XBarData[XBarCore.XBarOptionSet].mods.XPetStuffXP then
			XBarData[XBarCore.XBarOptionSet].mods.XPetStuffXP=
			{
				["x"]=150,
				["y"]=-130,
				["rp"]="TOPLEFT",
				["pt"]="TOPLEFT",
				["hidebar"]=false;
			};
		end
		XBarCore.SetPos("XPetStuffXP");
		SetTextStatusBarTextZeroText(XPetStuffXPBar,"");
	end
end

function XPetStuffXPBar_Update()
	local currXP, nextXP = GetPetExperience();
	local showtext=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBarText;
	local orient=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBarHorizontal;

	XPetStuffXPBar:SetMinMaxValues(min(0, currXP),nextXP);
	XPetStuffXPBar:SetValue(currXP);
	
	if showtext then
		TextStatusBar_UpdateTextString(XPetStuffXPBar);
		ShowTextStatusBarText(XPetStuffXPBar);
		XPetStuffXPBar.lockShow = 1; -- Reset the lock buffer
	else
		XPetStuffXPBar.lockShow = 0; -- Clear the lock buffer
		HideTextStatusBarText(XPetStuffXPBar);
	end
end

function XPetStuffXPBar_UpdateScreen()
	local value=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBar;
	local showtext=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBarText;
	local orient=XBarData[XBarCore.XBarOptionSet].mods.XPetStuffBar.Options.XPBarHorizontal;
	local v;

	if orient==true then
		orient = "HORIZONTAL";
		XPetStuffXPBarSeg1:ClearAllPoints();
		XPetStuffXPBarSeg1:SetPoint("TOPLEFT","XPetStuffXPBar","TOPLEFT");
		XPetStuffXPBarSeg2:ClearAllPoints();
		XPetStuffXPBarSeg2:SetPoint("LEFT","XPetStuffXPBarSeg1","RIGHT");
		XPetStuffXPBar:SetWidth(317);
		XPetStuffXPBar:SetHeight(11);
		XPetStuffXPBarSeg1:SetWidth(160);
		XPetStuffXPBarSeg2:SetWidth(161);
		XPetStuffXPBarSeg1:SetHeight(13);
		XPetStuffXPBarSeg2:SetHeight(13);
		XPetStuffXPBarSeg1:SetTexture(XBAR_PETXP_H);
		XPetStuffXPBarSeg1:SetTexCoord("0","0.59765625","0","1");
		XPetStuffXPBarSeg2:SetTexture(XBAR_PETXP_H);
		XPetStuffXPBarSeg2:SetTexCoord("0","0.6171875","0","1");
	else
		orient = "VERTICAL";
		XPetStuffXPBarSeg1:ClearAllPoints();
		XPetStuffXPBarSeg1:SetPoint("TOPLEFT","XPetStuffXPBar","TOPLEFT");
		XPetStuffXPBarSeg2:ClearAllPoints();
		XPetStuffXPBarSeg2:SetPoint("TOP","XPetStuffXPBarSeg1","BOTTOM");
		XPetStuffXPBar:SetWidth(11);
		XPetStuffXPBar:SetHeight(317);
		XPetStuffXPBarSeg1:SetWidth(13);
		XPetStuffXPBarSeg2:SetWidth(13);
		XPetStuffXPBarSeg1:SetHeight(160);
		XPetStuffXPBarSeg2:SetHeight(161);
		XPetStuffXPBarSeg1:SetTexture(XBAR_PETXP_V);
		XPetStuffXPBarSeg1:SetTexCoord("0","1","0","0.59765625");
		XPetStuffXPBarSeg2:SetTexture(XBAR_PETXP_V);
		XPetStuffXPBarSeg2:SetTexCoord("0","1","0","0.6171875");
	end

	XPetStuffXPBar:SetOrientation(orient);

	if showtext then
		TextStatusBar_UpdateTextString(XPetStuffXPBar);
		ShowTextStatusBarText(XPetStuffXPBar);
		XPetStuffXPBar.lockShow = 1; -- Reset the lock buffer
	else
		XPetStuffXPBar.lockShow = 0; -- Clear the lock buffer
		HideTextStatusBarText(XPetStuffXPBar);
	end

	if value then
		v=2; -- Show
	else
		v=1; -- Hide
	end
	XBarCore.ShowHide("XPetStuffXP",v);
end
