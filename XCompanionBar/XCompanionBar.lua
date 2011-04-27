--This is the internal name of the mod.
local XBARMOD="XCompanionBar";
local dbver="3";

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
	["foptioncb"]="XCompanionBar_OptionCB",
	["nsliders"]=0,
};

XCompanionBarSpells = { }; -- Empty to start

local SETUPCOMPLETE=false;

function XCompanionBar_OnLoad(self)
	--Each bar must catch its own event notifications
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("COMPANION_UPDATE");
	self:RegisterEvent("COMPANION_LEARNED");
	-- Do not need PLAYER_AURAS_CHANGED now that we don't handle mounts here
end

function XCompanionBar_OnEvent(event,arg1)
	--XCompanionBar has some other things it needs to do besides the standard stuff.
	if (event == "PLAYER_ENTERING_WORLD") then
		XBarQ:CreateDelay("XBarCompanions",0.5,XCompanionBar_Setup,nil,false,true,true);
		XBarQ:CreateDelay("XBarStdEvent-"..XBARMOD.."-"..event,1,XBar_StdEvents,{XBARMOD,event,arg1},false,true,true);
	elseif (event == "COMPANION_LEARNED") then
		print(XCOMPANIONBAR_MSG1..XCOMPANIONBAR_MSG4);
	elseif (event == "COMPANION_UPDATE") then
		-- This event fires CONSTANTLY in a capitol city, filter out MOUNT events.
		if arg1 ~= "MOUNT" then
			XBarQ:CreateDelay("XBarStdEvent-"..XBARMOD.."-"..event,1,XBar_StdEvents,{XBARMOD,event,arg1},false,true,true);
		end
	else
		XBarQ:CreateDelay("XBarStdEvent-"..XBARMOD.."-"..event,0.5,XBar_StdEvents,{XBARMOD,event,arg1},false,true,true);
	end
end

function XCompanionBar_Setup()
	local i,v,n,_,t,b,c1,c2,last,lim;

	if not SETUPCOMPLETE then
		XCompanionBarSpells = { };
		b=0;
		n=GetNumCompanions("CRITTER");
		c1=0;
		c2=1;
		-- Set up the limit sliders
		XBarCore.ModData[XBARMOD].nsliders=1;
		XBarCore.ModData[XBARMOD]["slider1"]="NumMaxPets";
		XBarCore.ModData[XBARMOD]["dslider1"]=10; -- I wouldn't go any more than this to start out with
		XBarCore.ModData[XBARMOD]["slider1min"]=5; -- Setting to 0 causes the mod to break, as XBar expects at least 1 button
		XBarCore.ModData[XBARMOD]["slider1max"]=350; -- Real max is 199 pets and 294 mounts, obtainable max will be lower due to factions, this gives us room to grow.
		XBarCore.ModData[XBARMOD]["slider1step"]=5;
		XBarCore.ModData[XBARMOD]["slider1format"]="%i";

		-- Find our limits
		if (XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar==nil) then
			XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar={};
		end
		if (XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar.Options==nil) then
			XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar.Options={};
		end
		lim=XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar.Options["NumMaxPets"];
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
					tinsert(XCompanionBarSpells,"#Pets"..tostring(c2));
					tinsert(XCompanionBarSpells,XBAR_SWRAP);
				end
				_,v,_,_,_=GetCompanionInfo("CRITTER",i);
				if (not v) and (i==1) then
					print(XCOMPANIONBAR_MSG3);
				end
				tinsert(XCompanionBarSpells,"!C"..tostring(v))

				-- Now to enable it if we have just discovered this pet.
				if (v) and (XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar) and (XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar.Options) and (XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar.Options[v]) == nil then
					XBarData[XBarCore.XBarOptionSet].mods.XCompanionBar.Options[v]=true;
				end
			end
		end
		
		if (b==0) then
			-- No mounts/critters, so junk it.
			print("XCompanionBar: No"..XCOMPANIONBAR_MSG2);
			XBarCore.ModData[XBARMOD].enabled=false;
			XBarCore.ModData[XBARMOD].loaded=false;
		else
			print("XCompanionBar: "..tostring(b)..XCOMPANIONBAR_MSG2);
		end
		SETUPCOMPLETE=true;
	end
end

function XCompanionBar_Texture(mod,texture,spellname)
	local t = texture;
	local summoned,_;

	if XBarData[XBarCore.XBarOptionSet].mods and 
	   XBarData[XBarCore.XBarOptionSet].mods[mod] and
	   XBarData[XBarCore.XBarOptionSet].mods[mod].nohighlight then
		return t;
	end
	-- Will highlight the critter the player has out
	_,summoned,_,_=XBarCore.GetCompanionInfo("CRITTER",spellname);
	if summoned then
		t="Interface\\Icons\\Spell_Nature_WispSplodeGreen";
	end

	return t;
end

function XCompanionBar_OptionsChanged()
	print(XCOMPANIONBAR_MSG5..XCOMPANIONBAR_MSG4);
end

function XCompanionBar_OptionCB(option,value,mod,forceupdate)
	if type(value)=="number" then
		-- This is a number, user is adjusting bar size.
		XBarQ:CreateDelay("XCompanionBarOptions",5,XCompanionBar_OptionsChanged,nil,false,true,true);
	end
	XBar_StdOptionCB(option,value,mod,forceupdate);
end