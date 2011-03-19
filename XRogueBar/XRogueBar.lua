--This is the internal name of the mod.
local XBARMOD="XRogueBar";
local dbver="5";

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
	["ftexint"]="XBar_StdTexture",
	["fbuttonid"]="XBar_StdButtonID",
	["foptioncb"]="XBar_StdOptionCB",
};

function XRogueBar_OnLoad(self)
	--Each bar must catch its own event notifications
	local Class,_;

	-- Nonlocalized class check
	_, Class = UnitClass("player");
	if (Class == "ROGUE") then
		self:RegisterEvent("SPELLS_CHANGED");
		self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		self:RegisterEvent("PLAYER_ENTERING_WORLD");
		self:RegisterEvent("UNIT_AURA");
		self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		XBarCore.ModData[XBARMOD].enabled=true;
	else
		self:SetScript("OnUpdate",nil);
		-- Reduces lag
	end
end

