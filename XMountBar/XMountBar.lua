--This is the internal name of the mod.
local XBARMOD="XMountBar";
local dbver="0";

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
	["sortable"]=false, -- Cannot sort due to the way companions are auto-managed.
	["ftexint"]=XBARMOD.."_Texture",
	["fbuttonid"]="XBar_StdButtonID",
	["foptioncb"]="XMountBar_OptionCB",
	["nsliders"]=0,
};

XMountBarSpells = { }; -- Empty to start

local SETUPCOMPLETE=false;

function XMountBar_OnLoad(self)
	--Each bar must catch its own event notifications
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("COMPANION_LEARNED");
	self:RegisterEvent("PLAYER_AURAS_CHANGED");
end

function XMountBar_OnEvent(event,arg1)
	--XMountBar has some other things it needs to do besides the standard stuff.
	if (event == "PLAYER_ENTERING_WORLD") then
		XBarQ:CreateDelay("XBarMounts",0.5,XMountBar_Setup,nil,false,true,true);
		XBarQ:CreateDelay("XBarStdEvent-"..XBARMOD.."-"..event,1,XBar_StdEvents,{XBARMOD,event,arg1},false,true,true);
	elseif (event == "COMPANION_LEARNED") then
		print(XMOUNTBAR_MSG1..XMOUNTBAR_MSG4);
	-- This handles mounts only, which apply a buff, so we need not concern ourselves with non-combat pets via the COMPANION_UPDATE event.
	else
		XBarQ:CreateDelay("XBarStdEvent-"..XBARMOD.."-"..event,0.5,XBar_StdEvents,{XBARMOD,event,arg1},false,true,true);
	end
end

function XMountBar_Setup()
	local i,v,n,_,t,b,c1,c2,last,tn,lim;

	if not SETUPCOMPLETE then
		XMountBarSpells = { };
		b=0;
		n=GetNumCompanions("MOUNT");
		c1=0;
		c2=1;
		-- Set up the limit sliders
		XBarCore.ModData[XBARMOD].nsliders=1;
		XBarCore.ModData[XBARMOD]["slider1"]="NumMaxMounts";
		XBarCore.ModData[XBARMOD]["dslider1"]=10; -- I wouldn't go any more than this to start out with
		XBarCore.ModData[XBARMOD]["slider1min"]=5; -- Setting to 0 causes the mod to break, as XBar expects at least 1 button
		XBarCore.ModData[XBARMOD]["slider1max"]=350; -- Real max is 199 pets and 294 mounts, obtainable max will be lower due to factions, this gives us room to grow.
		XBarCore.ModData[XBARMOD]["slider1step"]=5;
		XBarCore.ModData[XBARMOD]["slider1format"]="%i";

		-- Find our limits
		if (XBarData[XBarCore.XBarOptionSet].mods.XMountBar==nil) then
			XBarData[XBarCore.XBarOptionSet].mods.XMountBar={};
		end
		if (XBarData[XBarCore.XBarOptionSet].mods.XMountBar.Options==nil) then
			XBarData[XBarCore.XBarOptionSet].mods.XMountBar.Options={};
		end
		lim=XBarData[XBarCore.XBarOptionSet].mods.XMountBar.Options["NumMaxMounts"];
		if lim==nil then
			-- If we don't find this value, it will be initialized later to 10, so lets set it now.
			lim=10;
		end

		-- If we have any companions of that type, iterate through and find the pet info we need.
		if (n ~= nil) and (n>0) then
			if n>lim then
				n=lim;
			end
			b=b+n; -- only count the number we are loading
			for i=1,n do
				c1=c1+1;
				if c1>15 then
					c1=1;
					c2=c2+1;
				end
				if c1==1 then
					tinsert(XMountBarSpells,"#Mounts"..tostring(c2));
					tinsert(XMountBarSpells,XBAR_SWRAP);
				end
				_,v,_,_,_=GetCompanionInfo("MOUNT",i);
				if (not v) and (i==1) then
					print(XMOUNTBAR_MSG3);
				end
				tinsert(XMountBarSpells,"!M"..tostring(v))

				-- Now to enable it if we have just discovered this pet.
				if (v) and (XBarData[XBarCore.XBarOptionSet].mods.XMountBar) and (XBarData[XBarCore.XBarOptionSet].mods.XMountBar.Options) and (XBarData[XBarCore.XBarOptionSet].mods.XMountBar.Options[v]) == nil then
					XBarData[XBarCore.XBarOptionSet].mods.XMountBar.Options[v]=true;
				end
			end
		end
		
		if (b==0) then
			-- No mounts/critters, so junk it.
			print("XMountBar: No"..XMOUNTBAR_MSG2);
			XBarCore.ModData[XBARMOD].enabled=false;
			XBarCore.ModData[XBARMOD].loaded=false;
		else
			print("XMountBar: "..tostring(b)..XMOUNTBAR_MSG2);
		end
		SETUPCOMPLETE=true;
	end
end

function XMountBar_Texture(mod,texture,spellname)
	local t = texture;
	local summoned,_;

	if XBarData[XBarCore.XBarOptionSet].mods and 
	   XBarData[XBarCore.XBarOptionSet].mods[mod] and
	   XBarData[XBarCore.XBarOptionSet].mods[mod].nohighlight then
		return t;
	end
	-- Will highlight the Mount/critter the player has out
	_,summoned,_,_=XBarCore.GetCompanionInfo("MOUNT",spellname);
	if summoned then
		t="Interface\\Icons\\Spell_Nature_WispSplodeGreen";
	end

	return t;
end

function XMountBar_OptionsChanged()
	print(XMOUNTBAR_MSG5..XMOUNTBAR_MSG4);
end

function XMountBar_OptionCB(option,value,mod,forceupdate)
	if type(value)=="number" then
		-- This is a number, user is adjusting bar size.
		XBarQ:CreateDelay("XMountBarOptions",5,XMountBar_OptionsChanged,nil,false,true,true);
	end
	XBar_StdOptionCB(option,value,mod,forceupdate);
end