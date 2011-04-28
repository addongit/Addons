--This is the internal name of the mod.
local XBARMOD="XTradeBar";
local dbver="9";

local specialized=false;
local minors = {2,3,4,14,15,29};
local majors = {5,16,30};

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
	["wrappable"]=false,
	["sortable"]=true,
	["fbuttonid"]=XBARMOD.."_ButtonID",
	["fbuttoncb"]="XBar_StdButtonCB",
	["foptioncb"]="XBar_StdOptionCB",
	["ftexint"]="XTradeBar_Texture",
};

function XTradeBar_OnLoad(self)
	--Each bar must catch its own event notifications
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	XBarLoader.NotifyBagUpdates(XBARMOD,"XBar_StdEventHandler");
end

function XTradeBar_ButtonID(id,spellname)
	local newid=id;
	local i,v,sn,a;
	local ismajor,isminor;

-- Logic flow (assuming a spell is enabled):
--   Always show the minor professions if we see them
--   The presence of a minor profession indicates a specialty
--   If we show a minor, hide the appropriate major.
--   A spell will never be a major and a minor
--   All minor spells will be immediately followed by their corresponding major

	-- If we don't even know the spell in the first place, don't bother testing, as we'll just mess something up.
	if (id==nil) then
		return nil;
	end

	if (not XBarCore.GetOption(XBARMOD,spellname)) then
		newid=nil;
		-- If someone decided it'd be fun to disable the major spell on their own while having a specialized profession, lets not let it affect the next profession.
		if specialized then
			for i,v in pairs(majors) do
				a=XBarCore.ModData.XTradeBar.ActionList[v];
				if (a) and (spellname==a.Data[1].Data) then
					specialized=false;
					break;
				end
			end
		end
	else
		ismajor=false;
		isminor=false;

		-- Perform checks to see what we have
		for i,v in pairs(minors) do
			a=XBarCore.ModData.XTradeBar.ActionList[v];
			if (a) and ((spellname==a.Data[1].Data) and (newid~=nil)) then
				-- this is a Minor profession (specialty)
				isminor=true;
				if (specialized) then
					-- we found something already, don't show this
					-- This is primarily for weaponsmithing, as there are 2 levels of specialization
					newid=false;
				else
					specialized=true;
				end
				break;
			end
		end

		for i,v in pairs(majors) do
				a=XBarCore.ModData.XTradeBar.ActionList[v];
				if (a) and (spellname==a.Data[1].Data) then
				-- this is a Major profession (unspecialized)
				ismajor=true;
				if specialized then
					-- Hide the main one
					specialized=false;
					newid=nil;
				end
				break;
			end
		end

		-- note that if this is not a major or minor spell, the button will be shown as normal
		if (not ismajor) and (not isminor) then
			-- Reset the specialization attribute for the next profession just in case.
			specialized=false;
		end
	end

	return newid;
end

function XTradeBar_Texture(mod,texture,spellname)
	-- This function must be named directly in the global environment space to work as a callback
	local t = texture;
	local i,a,_;

	if XBarData[XBarCore.XBarOptionSet].mods and 
	   XBarData[XBarCore.XBarOptionSet].mods[mod] and
	   XBarData[XBarCore.XBarOptionSet].mods[mod].nohighlight then
		return t;
	end

	-- Look for tracking textures
	i,_,a = XBarCore.GetTrackID(spellname);
	if (i) and (a) then
		t="Interface\\Icons\\Spell_Nature_WispSplodeGreen"
	end
	-- This bar does not have any player buffs on it, so ignore standard texture callback.

	return t;
end
