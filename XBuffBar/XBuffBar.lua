--This is the internal name of the mod.
local XBARMOD="XBuffBar";
local dbver="16";

--Default settings and other info about the mod
XBarCore.ModData[XBARMOD] = {
	["nbuttons"]=0,
	["dbver"]=dbver,
	["dhorizontal"]=true,
	["hidebar"]=false,
	["dorder"]="az",
	["dscale"]=1,
	["dtooltips"]=true,
	["enabled"]=true,
	["nchecks"]=0,
	["wrappable"]=true,
	["sortable"]=true,
	["ftexint"]="XBar_StdTexture",
	["fbuttonid"]="XBar_StdButtonID",
	["fbuttoncb"]="XBar_StdButtonCB",
	["foptioncb"]="XBar_StdOptionCB",
};

function XBuffBar_OnLoad(self)
	--Each bar must catch its own event notifications
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	XBarLoader.NotifyBagUpdates(XBARMOD,"XBar_StdEventHandler");
end
