-- Initialize variables
local dbver="2";
local ver="4.00";
local xbarminver=4.00;
local n,i,f,b,c,XBARMOD,BARNAME;

XCustomBarData={ };

local XCUSTOMBAR_LOADED = false;
SLASH_XCUSTOMBAR1 = "/xcustombar";
local XCustomBar_TexID = 1;

local XCustomBarActionMenuDataSpell = {
-- When Left and right action modifiers are supported in Secure Frames, we can uncomment the lines and put the menus back
	{["text"]=XCUSTOMBAR_M1,["value"]=nil},
	{["text"]=XCUSTOMBAR_M2,["value"]="MS"},
--	{["text"]=XCUSTOMBAR_M2.." ("..XCUSTOMBAR_M10..")",["value"]="MSL"},
--	{["text"]=XCUSTOMBAR_M2.." ("..XCUSTOMBAR_M11..")",["value"]="MSR"},
	{["text"]=XCUSTOMBAR_M3,["value"]="MC"},
--	{["text"]=XCUSTOMBAR_M3.." ("..XCUSTOMBAR_M10..")",["value"]="MCL"},
--	{["text"]=XCUSTOMBAR_M3.." ("..XCUSTOMBAR_M11..")",["value"]="MCR"},
	{["text"]=XCUSTOMBAR_M4,["value"]="MA"},
--	{["text"]=XCUSTOMBAR_M4.." ("..XCUSTOMBAR_M10..")",["value"]="MAL"},
--	{["text"]=XCUSTOMBAR_M4.." ("..XCUSTOMBAR_M11..")",["value"]="MAR"},
	{["text"]=XCUSTOMBAR_M5,["value"]=nil},
	{["text"]=XCUSTOMBAR_M6,["value"]="F1"},
	{["text"]=XCUSTOMBAR_M7,["value"]="F2"},
	{["text"]=XCUSTOMBAR_M8,["value"]="F0"},
	{["text"]=XCUSTOMBAR_M9,["value"]=nil},
	{["text"]="1",["value"]="B1"},
	{["text"]="2",["value"]="B2"},
	{["text"]="3",["value"]="B3"},
	{["text"]="4",["value"]="B4"},
	{["text"]="5",["value"]="B5"},
	{["text"]=XCUSTOMBAR_M8,["value"]="B*"},
	{["text"]=XCUSTOMBAR_M12,["value"]=nil},
	{["text"]=XCUSTOMBAR_M13,["value"]="KS"},
	{["text"]=XCUSTOMBAR_M14,["value"]="KP"},
};

local XCustomBarActionMenuDataCompanion = {
	{["text"]=XCUSTOMBAR_M15,["value"]=nil},
	{["text"]=XCUSTOMBAR_M14,["value"]="C"},
	{["text"]=XCUSTOMBAR_M16,["value"]="M"},
};

local XCustomBarActionMenuDataMacro = {
	{["text"]=XCUSTOMBAR_M12,["value"]=nil},
	{["text"]=XCUSTOMBAR_M13,["value"]="S"},
	{["text"]=XCUSTOMBAR_M14,["value"]="P"},
};

local XCustomBarActionMenuDataChat = {
	{["text"]=XCUSTOMBAR_LABELCHAT,["value"]=nil},
	{["text"]=XCUSTOMBAR_LABELSAY,["value"]="S"},
	{["text"]=XCUSTOMBAR_LABELYELL,["value"]="Y"},
	{["text"]=XCUSTOMBAR_LABELPARTY,["value"]="P"},
	{["text"]=XCUSTOMBAR_LABELGUILD,["value"]="G"},
	{["text"]=XCUSTOMBAR_LABELOFFICER,["value"]="O"},
	{["text"]=XCUSTOMBAR_LABELRAID,["value"]="R"},
	{["text"]=XCUSTOMBAR_LABELRAIDWARNING,["value"]="L"},
	{["text"]=XCUSTOMBAR_LABELBATTLEGROUND,["value"]="B"},
	{["text"]=XCUSTOMBAR_LABELWHISPER,["value"]="W"},
	{["text"]=XCUSTOMBAR_LABELCHANNEL,["value"]="C"},
};

local XCustomBarActionMenuDataSpacer = {
	{["text"]=XCUSTOMBAR_LABELSPACER,["value"]=nil},
	{["text"]=XCUSTOMBAR_M17,["value"]="W"},
	{["text"]=XCUSTOMBAR_M18,["value"]=" "},
};

--[[ Button string format:
	1 - Number of successive actions
	2 - Type of actions (S M I ! E C # -)
	3 - Modifier:Shift (shift-)
	4 - Modifier:Ctrl (ctrl-)      None - Either + Left * Right % (L/R not implemented in WoW client yet)
	5 - Modifier:Alt (alt-)
	6 - Help/Harm (0=none, 1=help, 2=harm)
	7 - Button (1-5,*)
	8 - Spellbook (S/P), Companion Type (C/M), or Chat channel:
		S - Say
		Y - Yell
		P - Party
		G - Guild
		O - Officer
		R - Raid
		L - Raid Warning
		B - Battleground
		W - Whisper         \_ If using these types, target or channel name must be specified in the data field (Format is NAME:MESSAGE)
		C - Channel         /  Later on when saving into XBar DB the target name will be moved into the AuxData field after the type.
	9 - Start of data sequence up to '|', and next block begins with 3
]]--

--==XCUSTOMBAR OPTIONS GUI==--

function XCustomBarOptionsGUI_OnLoad(self)
	XCustomBarOptionsGUI.name="XCustomBar";
	XCustomBarOptionsGUI.parent="XBar"; -- empty for now, i might nest it later.
	XCustomBarOptionsGUI.okay=nil;
	XCustomBarOptionsGUI.cancel=nil;
	XCustomBarOptionsGUI.defaults=nil;
	InterfaceOptions_AddCategory(XCustomBarOptionsGUI);
end

--==XCUSTOMBAR==--

function XCustomLoaderBar_OnLoad(self)
	if XBarCore.GetVersion ~= nil then
	if XBarCore.GetVersion() >= xbarminver then
		self:RegisterEvent("VARIABLES_LOADED");
		self:RegisterEvent("PLAYER_ENTERING_WORLD");

		SlashCmdList.XCUSTOMBAR = function(msg)
			XCustomBar_SlashHandler(string.lower(msg));
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG8..tostring(xbarminver)..XCUSTOMBAR_MSG9);
	end
	end
end

function XCustomLoaderBar_OnEvent(self,event,...)
	local i,n,b,f,c,m,x,newdb,a,p1,p2,v;

	if (event == "VARIABLES_LOADED") then		
		-- Validate data
		newdb=false;
		if (XCustomBarData.nbars==nil) then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG1);
			-- no data found, lets make it
			newdb=true;
		elseif (XCustomBarData.dbver==nil) then
			-- This could indicate a pre-3.00 structure.  Let's be nice and convert it over
			print(XCUSTOMBAR_MSG10);
			n=XCustomBarData.nbars;
			if (n) then
				XCustomBarData.dbver=dbver;
				XCustomBarData.changed={};
				for i=1,n do
					m=XCustomBarData["bar"..i];
					if (not XCustomBarData.bars[m]) or (not XCustomBarData.bars[m].nbuttons) then
						newdb=true;
						break;
					end
					x=XCustomBarData.bars[m].nbuttons;
					for c=1,x do
						b=XCustomBarData.bars[m]["button"..c];
						if (not b) or (strlen(b) == 0) then
							newdb=true;
							break;
						end
						a=tonumber(strsub(b,1,1));
						if (not a) or a==0 then
							newdb=true;
							break;
						end
						p1=2;
						while p1<=strlen(b) do
							f=strsub(b,p1,p1);
							p2=strfind(b,"|",p1+6,true);
							if not p2 then
								p2=strlen(b);
							end
							if f=="S" or f=="M" then
								v=strsub(b,1,p1+5).."S"..strsub(b,p1+6);
								b=v;
							elseif (f=="I") then
								v=strsub(b,1,p1+5).."_"..strsub(b,p1+6);
								b=v;
							else
								newdb=true;
								break;
							end
							p1=p2+2; -- Adding 2 to compensate for the extra char we put in.
						end
						if newdb then
							break;
						end
						-- Save our changes
						XCustomBarData.bars[m]["button"..c]=b;
					end
					if newdb then
						break;
					end
				end
				if newdb then
					-- Malformed DB, have to start over
					print(XCUSTOMBAR_MSG11);
				end
			else
				-- Guess we were wrong...
				print(XCUSTOMBAR_MSG11);
				newdb=true;
			end
		elseif (XCustomBarData.dbver ~= dbver) then
			-- New database version, reset
			-- I take this very seriously, as it takes a major event to warrant deleting any custom bars the user has created, since the basic xcustombar
			-- database structure rarely ever need changing, and some users may have had some extensive custom bars set up.
			print("XCustomBar"..XBAR_MSG3);
			newdb=true;
		end
		if newdb then
			XCustomBarData = {
				["dbver"]=dbver,
				["nbars"]=0,
				["bars"] = {},
				["changed"] = {},
			};
		end
	elseif (event == "PLAYER_ENTERING_WORLD") and (not XCUSTOMBAR_LOADED) then
		-- Clean up old data
		if (XCustomBarData.queue) then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG4);
			for i,b in pairs(XCustomBarData.queue) do
				-- If this is still an active bar, lets not delete it
				n=XCustomBarData.nbars;
				f=false;
				for c=1,n do
					if (XCustomBarData["bar"..tostring(c)]==b) then
						f=true;
						break;
					end
				end
				if (not f) then
					n=XBarData["noptionsets"];
					if (n==nil) then
						break;
					end
					for c=1,n do
						f=XBarData["optionset"..tostring(c)];
						if (XBarData["optionset-"..f]) then
							XBarData["optionset-"..f]["mods"]["XCustomBar"..b]=nil;
							m=XBarData["optionset-"..f].nmods;
							for x=1,m do
								if (XBarData["optionset-"..f]["mod"..tostring(x)]=="XCustomBar"..b) then
									XBarData["optionset-"..f]["mod"..tostring(x)]=XBarData["optionset-"..f]["mod"..tostring(m)];
									XBarData["optionset-"..f]["mod"..tostring(m)]=nil;
									XBarData["optionset-"..f].nmods = m-1;
									break;
								end
							end
						end	
					end
				end
			end
			if (n == nil) then
				DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG5);
			else
				XCustomBarData.queue=nil;
			end
		end

		n=XCustomBarData.nbars;
		if (n==nil) then
			n=0;
		end

		-- Double check just in case XBar hasn't got this yet.
		XBarCore.BuildPlayerName();

		-- Lets setup our bars
		XCustomBar_SetupBars();

		for i=1,n do
			-- Retrieve and define object names
			BARNAME=XCustomBarData["bar"..tostring(i)];
			XBARMOD="XCustomBar"..BARNAME;
			XBarCore.Update(XBARMOD);
		end
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG6..tostring(n)..XCUSTOMBAR_MSG7);
		XCUSTOMBAR_LOADED=true;
		self:UnregisterEvent("PLAYER_ENTERING_WORLD");
	end
end

function XCustomBar_CurAction()
	return XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur;
end

function XCustomBar_CurBar()
	local curi=XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur;
	local curb=nil;
	local curnb=0;
	
	if (curi ~= nil) then
		curb=XCustomBarData["bar"..tostring(curi)];
	end
	
	if (curb ~= nil) then
		curnb=XCustomBarData.bars[curb].nbuttons;
	end
	if (curnb==nil) then
		curnb=0;
	end;

	return curi,curb,curnb;
end

function XCustomBar_CurButton()
	return XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur;
end

function XCustomBar_GetAction(curbar, curbtn, curact)
	-- Returns: type (S/M/I), Actiontext (minus the ending '|'), startpos, endpos (relative to button string)
	local r=nil;
	local t=nil;
	local s,n,p,i,x,l;

	if ((curbar ~= nil) and (curbtn ~= nil) and (curact ~= nil)) then
		s=XCustomBarData.bars[curbar]["button"..tostring(curbtn)];
	end

	if (s~=nil) then
		n=tonumber(strsub(s,1,1));
		t=strsub(s,2,2);
		l=strlen(s);
		if (curact <= n) then
			x=3;
			i=1;
			while (x<l) do
				p=strfind(s,"|",x);
				if (curact==i) then
					r=strsub(s,x,p-1);
					break;
				end
				i=i+1;
				x=p+1;
			end
		end
	end

	if (r==nil) then
		x=0;
		p=0;
	else
		p=p-1;
	end
	
	return t,r,x,p;
end

function XCustomBar_GenerateList(mod,BN)
	local i,j,a,t,x,n,def,nActions,_,v,pos;

	XBarCore.ModData[mod].ActionList = { };
	n=XCustomBarData.bars[BN].nbuttons;
	for i=1,n do
		def=XCustomBarData.bars[BN]["button"..tostring(i)];
		nActions=tonumber(strsub(def,1,1));
		if not XBarCore.ModData[mod].ActionList[i] then
			XBarCore.ModData[mod].ActionList[i] = {};
		end
		a=XBarCore.ModData[mod].ActionList[i];

		t=strsub(def,2,2);

		def=strsub(def,3);
		if (t=="S") then
			a.Type=XBAR_TSPELL;
		elseif (t=="M") then
			a.Type=XBAR_TMACRO;
		elseif (t=="I") then
			a.Type=XBAR_TITEM;
		elseif (t=="!") then
			a.Type=XBAR_TCOMPANION;
		elseif (t=="E") then
			a.Type=XBAR_TEMOTE;
			j=GetNumMacroIcons(); -- Load the icons
			j=XCustomBarData.bars[BN]["button"..tostring(i).."icon"];
			if not j then
				j=1;
			end
			a.Texture=GetMacroIconInfo(j);
		elseif (t=="C") then
			a.Type=XBAR_TCHAT;
			j=GetNumMacroIcons(); -- Load the icons
			j=XCustomBarData.bars[BN]["button"..tostring(i).."icon"];
			if not j then
				j=1;
			end
			a.Texture=GetMacroIconInfo(j);
		elseif (t=="-") then
			a.Type=XBAR_TSPACER;
		elseif (t=="#") then
			a.Type=XBAR_THEADER;
		end

		for j=1,nActions do
			-- Initialize the data
			if not (a.Data) then
				a.Data={};
			end
			a.Data[j]={};

			-- Data
			pos=strfind(def,"|",7);
			t=strsub(def,7,pos-1);
			a.Data[j].Data=t;

			-- Items require an Item ID now
			if a.Type==XBAR_TITEM then
				a.Data[j].ID=tonumber(t);
				if type(a.Data[j].ID)=="number" then
					t=GetItemInfo(a.Data[j].ID);
					if t==nil then
						a.Data[j].Data = "Unknown: "..tostring(a.Data[j].ID); -- This occurs when the item is not in the local cache
						print(XCUSTOMBAR_MSG15..tostring(a.Data[j].ID)..XCUSTOMBAR_MSG16);
					else
						a.Data[j].Data = tostring(GetItemInfo(a.Data[j].ID));
					end
				end
			end

			if a.Type==XBAR_TSPELL then
				-- Modifiers must be ALT-CTRL-SHIFT
				a.Data[j].Modifiers=strsub(def,1,3);

				-- Help/Harm (0,1,2)
				a.Data[j].IFF=strsub(def,4,4);

				-- Button identifier (1-5 or *)
				a.Data[j].Buttons=strsub(def,5,5);

				-- Spellbook
				t=strsub(def,6,6);
				if t=="S" then
					a.Data[j].AuxData = BOOKTYPE_SPELL;
				elseif t=="P" then
					a.Data[j].AuxData = BOOKTYPE_PET;
				end

				-- Spell ID
				t=a.Data[j].Data;
				x=strfind(t,"(",1,true);
				v=nil;
				if (x) then
					v=strsub(t,x+1);
					t=strsub(t,1,x-1);
					x=strfind(v,")",1,true);
					if (x) then
						v=strsub(v,1,x-1);
					end
				end
			elseif a.Type==XBAR_TMACRO then
				-- Spellbook
				t=strsub(def,6,6);
				if t=="S" then
					a.Data[j].AuxData = BOOKTYPE_SPELL;
				elseif t=="P" then
					a.Data[j].AuxData = BOOKTYPE_PET;
				end
			elseif a.Type==XBAR_TCOMPANION then
				-- Companion Type
				t=strsub(def,6,6);
				if t=="M" then
					a.Data[j].AuxData = "MOUNT";
				elseif t=="C" then
					a.Data[j].AuxData = "CRITTER";
				end
			elseif a.Type==XBAR_TCHAT then
				-- Chat Type
				t=strsub(def,6,6);
				if t=="S" then
					a.Data[j].AuxData = "SAY";
				elseif t=="Y" then
					a.Data[j].AuxData = "YELL";
				elseif t=="P" then
					a.Data[j].AuxData = "PARTY";
				elseif t=="G" then
					a.Data[j].AuxData = "GUILD";
				elseif t=="O" then
					a.Data[j].AuxData = "OFFICER";
				elseif t=="R" then
					a.Data[j].AuxData = "RAID";
				elseif t=="L" then
					a.Data[j].AuxData = "RAIDWARNING";
				elseif t=="B" then
					a.Data[j].AuxData = "BATTLEGROUND";
				elseif t=="W" then
					a.Data[j].AuxData = "WHISPER";
				elseif t=="C" then
					a.Data[j].AuxData = "CHANNEL";
				end
			end
			if (pos==strlen(def)) then
				def="";
			else
				def=strsub(def,pos+1);
			end
		end
	end
end

function XCustomBar_OnEvent(self,event,...)
	local bn=self:GetName();
	local arg1 = ...;
	local XBARMOD = "XCustomBar"..XBarCore.FrameDB[bn].XCUSTOMBAR;

	XBar_StdEventHandler(XBARMOD,event,arg1)
end

function XCustomBar_PortExtractField(v)
	local r,t,p;

	if strsub(v,1,1) ~= "[" then
		return nil,nil;
	end
	
	p=strfind(v,"]",2,true);
	if p==nil then
		return nil,nil;
	end
	
	t=tonumber(strsub(v,2,p-1));
	if t==nil then
		return nil,nil;
	elseif t<=0 then
		return "",p+1;
	else
		r=strsub(v,p+1,p+t);
		if strlen(r)~=t then
			return nil,nil;
		end
		return r,p+t+1;
	end
end

function XCustomBar_PortMakeField(v)
	local r,t;

	r="["..strlen(v).."]"..v;
	return r;
end

function XCustomBar_PortValidateButton(v)
	local s,n,i,a,p,r;
	
	s=v;
	if strlen(s)<10 then
		return false;
	end
	-- validate # actions
	n=tonumber(strsub(s,1,1));
	if n==nil or n<=0 then
		return false;
	end
	r=true;
	s=strsub(s,2);
	for i=1,n do
		-- Iterate through actions
		p=strfind(s,"|",1,true);
		if not p then
			r=false;
			break;
		end
		a=strsub(s,1,p-1);
		if not strfind("SMI!EC#-",strsub(a,1,1),1,true) then
			r=false;
			break;
		end
		-- Modifiers
		if not strfind("+-*%",strsub(a,2,2),1,true) then
			r=false;
			break;
		end
		if not strfind("+-*%",strsub(a,3,3),1,true) then
			r=false;
			break;
		end
		if not strfind("+-*%",strsub(a,4,4),1,true) then
			r=false;
			break;
		end
		-- IFF
		if not strfind("012",strsub(a,5,5),1,true) then
			r=false;
			break;
		end
		-- Buttons
		if not strfind("*12345",strsub(a,6,6),1,true) then
			r=false;
			break;
		end
		-- Spellbook / Companion Type / Chat Channel
		if not strfind("-SPCMYGORLBW_",strsub(a,7,7),1,true) then
			r=false;
			break;
		end
		-- Data field should not be blank, not going to bother to validate it per type of action
		if strsub(a,8) == "" then
			r=false;
			break;
		end
		s=strsub(s,p+1);
	end
	return r;
end

function XCustomBar_SetupBars()
	local n,i,BARNAME,XBARMOD,b,f,c,dbv;
	-- Instantiate bars
	n=XCustomBarData.nbars;
	if (n==nil) then
		n=0;
	end

	-- Loop to set up our bars
	for i=1,n do
		-- Retrieve and define object names
		BARNAME=XCustomBarData["bar"..tostring(i)];
		XBARMOD="XCustomBar"..BARNAME;

		b=XCustomBarData.bars[BARNAME].nbuttons;
		dbv=dbver;
		if XCustomBarData.changed==nil then
			XCustomBarData.changed={};
		end
		
		--Default settings and other info about the mod if required
		if ((XBarCore.ModData[XBARMOD]==nil) and (b>0)) then
			XBarCore.ModData[XBARMOD]={
				----REQUIRED VALUES----
				["nbuttons"]=0,
				["dbver"]=dbv,
				["dhorizontal"]=true,
				["dhidebar"]=false,
				["dorder"]="az",
				["dscale"]=1,
				["dtooltips"]=true,
				["enabled"]=true,
				["nchecks"]=0,
				["wrappable"]=true,
				["sortable"]=true,
				["ftexint"]="XBar_StdTexture",
				["foptioncb"]="XBar_StdOptionCB",
				["fbuttoncb"]="XBar_StdButtonCB",
				["fbuttonid"]="XBar_StdButtonID",
			};
		end

		getfenv()["XBAR_HELP_CONTEXT_"..XBARMOD] = XBarHelpGUI.ContextHeader(XBARMOD).."This bar was created using XCustomBar.  Check a button to show or uncheck to hide it.";

		if XCustomBarData.changed[BARNAME] then
			-- This is how we're gonna keep track of user changes, to know when to reset the data so we can support sorting.
			if XBarData[XBarCore.XBarOptionSet].mods[XBARMOD] then
				dbv=tostring(tonumber(XBarData[XBarCore.XBarOptionSet].mods[XBARMOD].dbver)+0.00001);
			end
			XCustomBarData.changed[BARNAME]=nil;
		elseif XBarData[XBarCore.XBarOptionSet].mods[XBARMOD] then
			dbv=XBarData[XBarCore.XBarOptionSet].mods[XBARMOD].dbver;
		end
		XBarCore.ModData[XBARMOD].dbver=dbv;

		-- Generate the ActionList
		XCustomBar_GenerateList(XBARMOD,BARNAME);

		-- Instantiate Frames
		f=CreateFrame("Frame",XBARMOD,UIParent,"XBarTemplate");
		f:SetScript("OnEvent",XCustomBar_OnEvent);

		-- Since we can't use the OnLoad event, we'll put the code here
		f:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		f:RegisterEvent("COMPANION_UPDATE");
		f:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		f:RegisterEvent("SPELLS_CHANGED");
		f:RegisterEvent("UNIT_AURA");
		f:RegisterEvent("UPDATE_MACROS");
		XBarLoader.NotifyBagUpdates(XBARMOD,"XBar_StdEventHandler");

		-- This entry will help us find the identity of the bar later
		if XBarCore.FrameDB[XBARMOD] == nil then
			XBarCore.FrameDB[XBARMOD]={};
		end
		XBarCore.FrameDB[XBARMOD].XCUSTOMBAR=BARNAME;

		-- Finish up the job
		XBarCore.RegisterAddon(XBARMOD,true,true);
	end
end

function XCustomBar_StrReplace(s1,p1,p2,s2)
	local b1="";
	local b2="";
	local l=strlen(s1);

	if (p1>1) then
		b1=strsub(s1,1,p1-1);
	end
	if (p2<l) then
		b2=strsub(s1,p2+1);
	end
	b1=b1..s2..b2;
	
	return b1;
end

--[[Button string format:
	1 - Number of successive actions
	2 - Type of actions (S=Spell, M=Macro, I=Item)
	3 - Modifier:Shift (shift-)
	4 - Modifier:Ctrl (ctrl-)
	5 - Modifier:Alt (alt-)
	6 - Help/Harm (0=none, 1=help, 2=harm)
	7 - Button (1-5,*)
	8 - Start of name sequence up to '|', and next block begins with 3
]]--

function XCustomBar_SlashHandler(msg)
	if (strfind(msg, "config")) then
		if(XCustomBarConfig:IsVisible()) then
			XCustomBarConfig:Hide();
		else
			XCustomBarConfig:Show();
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("XCustomBar v"..ver);
		DEFAULT_CHAT_FRAME:AddMessage(XBAR_HELPTEXT1);
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_HELPTEXT2);
	end
end

-- CONFIG FUNCTIONS --

function XCustomBarConfig_OnShow(self)
	if (not XBarData) then
		self:Hide();
		return;
	end
	if (not XBarData[XBarCore.XBarOptionSet]) then
		self:Hide();
		return;
	end

	n=XBarData[XBarCore.XBarOptionSet].nmods;
	if (n==nil) then
		self:Hide();
		return;
	end

	XCustomBarConfig:SetFrameStrata("FULLSCREEN_DIALOG");
	XCustomBarConfig:SetFrameLevel(10);
	XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur=nil;
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=nil;
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;

	XCustomBarConfigChatLabel:Hide();
	XCustomBarConfigChatScrollFrame:Hide();
	XCustomBarConfigChatFrameBackground:Hide();
	XCustomBarConfigChatSave:Hide();
	XCustomBarConfigTextureNext:Hide();
	XCustomBarConfigTexturePrev:Hide();
	XCustomBarConfigTextureShow:Hide();
	XCustomBarConfigTextureSave:Hide();

	securecall(XCustomBarConfigScrollBars_OnScroll);
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	securecall(XCustomBarConfigScrollActions_OnScroll);

	XBarCore.FrameDB.XCustomBarConfigNewButtonMenu={["XBarCur"]="S"};
	XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELSPELL);
end

function XCustomBarConfigActionMenu_OnClick(self)
	UIDropDownMenu_Initialize(XCustomBarConfigActionMenuFrame, XCustomBarConfigActionMenuFrame_OnLoad);
	ToggleDropDownMenu(1, nil, XCustomBarConfigActionMenuFrame, XCustomBarConfigActionMenu, 0, 0);
end

function XCustomBarConfigActionMenu_Select(self)
	local v=self.value;
	local s,t,curbar,curbtn,curact,p1,p2,a,f,v2,atype;
	
	_,curbar=XCustomBar_CurBar();
	curbtn=XCustomBar_CurButton();
	curact=XCustomBar_CurAction();
	atype,a,p1,p2=XCustomBar_GetAction(curbar,curbtn,curact);

	if InCombatLockdown() then
		return;
	end

	t=strsub(v,1,1);
	if (strlen(v)==3) then
		v2=strsub(v,3,3);
		if (v2=="L") then
			v2="*";
		elseif (v2=="R") then
			v2="%";
		else
			v2="+";
		end
	else
		v2="+";
	end
	v=strsub(v,2,2);

	if (a=="") then
		return;
	end

	s=XCustomBarData.bars[curbar]["button"..tostring(curbtn)];
	if atype=="S" then
		if (t=="M") then
			if (v=="C") then
				p1=p1+1;
			elseif (v=="A") then
				p1=p1+2;
			end
			f=strsub(s,p1,p1);
			if (f ~= v2) then
				s=XCustomBar_StrReplace(s,p1,p1,v2);
			elseif (f==v2) then
				s=XCustomBar_StrReplace(s,p1,p1,"-");
			end
		elseif (t=="F") then
			s=XCustomBar_StrReplace(s,p1+3,p1+3,v);
		elseif (t=="B") then
			s=XCustomBar_StrReplace(s,p1+4,p1+4,v);
		elseif (t=="K") then
			s=XCustomBar_StrReplace(s,p1+5,p1+5,v);
		end
	elseif atype=="M" then
		s=XCustomBar_StrReplace(s,p1+5,p1+5,t);
	elseif atype=="!" then
		s=XCustomBar_StrReplace(s,p1+5,p1+5,t);
	elseif atype=="C" then
		f = strfind(s,":",p1+6,true);
		v = strfind(s,"|",p1+6,true);
		a="";
		if (f and v) and f<v then
			a=strsub(s,p1+6,f);
			f=f+1;
		elseif (v) then
			a=":";
			f=p1+6;
		end
		if t=="W" or t=="C" then
			t=t..a..strsub(s,f,v);
			XCustomBarConfigActionText:SetText(a);
			XCustomBarConfigActionSave:Show();
			XCustomBarConfigActionText:Show();
			XCustomBarConfigActionLabel:Show();
		else
			XCustomBarConfigActionText:SetText("");
			XCustomBarConfigActionSave:Hide();
			XCustomBarConfigActionText:Hide();
			XCustomBarConfigActionLabel:Hide();
			t=t..strsub(s,f,v);
		end
		XCustomBarConfigChatScrollFrameText:SetText(strsub(s,f,v));
		s=XCustomBar_StrReplace(s,p1+5,v,t);
	elseif atype=="-" then
		s=XCustomBar_StrReplace(s,p1+6,p1+6,t);
	end
	XCustomBarData.changed[curbar]=true;
	XCustomBarData.bars[curbar]["button"..tostring(curbtn)]=s;
	XCustomBarConfigScrollActions_OnScroll();
end

function XCustomBarConfigActionMenuFrame_OnLoad(self,level)
	-- Loading off the click event from the button itself so we can make sure the data is there.
	-- Reinitializes every time we click the button.
	local info = UIDropDownMenu_CreateInfo();
	local i,t,v,c,c2,s,k,curbar,curbtn,curact;
	local menukey=UIDROPDOWNMENU_MENU_VALUE;
	local sourcetable,atype;

	_,curbar=XCustomBar_CurBar();
	curbtn=XCustomBar_CurButton();
	curact=XCustomBar_CurAction();
	atype,s=XCustomBar_GetAction(curbar,curbtn,curact);

	if atype=="S" then
		sourcetable=XCustomBarActionMenuDataSpell;
	elseif atype=="M" then
		sourcetable=XCustomBarActionMenuDataMacro;
	elseif atype=="!" then
		sourcetable=XCustomBarActionMenuDataCompanion;
	elseif atype=="C" then
		sourcetable=XCustomBarActionMenuDataChat;
	elseif atype=="-" then
		sourcetable=XCustomBarActionMenuDataSpacer;
	else
		return;
	end

	level = level or 1;
	for i=1,#(sourcetable) do
		t=sourcetable[i]["text"];
		v=sourcetable[i]["value"];
		if (v==nil) then
			k=t;
		end
		if ((level==1) and (v==nil)) then
			info.text = t;
			info.func = nil;
			info.owner = self:GetParent();
			info.hasArrow=true;
			info.notCheckable=true;
			info.value=t;
			info.checked=false;
			UIDropDownMenu_AddButton(info,1);
		elseif ((level==2) and (v~=nil) and (menukey==k)) then
			info.text = t;
			info.func = XCustomBarConfigActionMenu_Select;
			info.owner = self:GetParent();
			info.hasArrow=false;
			info.notCheckable=false;
			info.value=v;
			info.checked=false;
			t=strsub(v,1,1);
			c="";
			c2="";
			if strlen(v)>=2 then
				c=strsub(v,2,2);
			end
			if (strlen(v)>=3) then
				c2=strsub(v,3,3);
			end
			if  ((atype=="S") and (t=="M") and (c=="S") and (c2=="") and (strsub(s,1,1)=="+")) or   -- Modifiers
			    ((atype=="S") and (t=="M") and (c=="S") and (c2=="L") and (strsub(s,1,1)=="*")) or
			    ((atype=="S") and (t=="M") and (c=="S") and (c2=="R") and (strsub(s,1,1)=="%")) or
				((atype=="S") and (t=="M") and (c=="C") and (c2=="") and (strsub(s,2,2)=="+")) or
			    ((atype=="S") and (t=="M") and (c=="C") and (c2=="L") and (strsub(s,2,2)=="*")) or
			    ((atype=="S") and (t=="M") and (c=="C") and (c2=="R") and (strsub(s,2,2)=="%")) or
				((atype=="S") and (t=="M") and (c=="A") and (c2=="") and (strsub(s,3,3)=="+")) or
			    ((atype=="S") and (t=="M") and (c=="A") and (c2=="L") and (strsub(s,3,3)=="*")) or
			    ((atype=="S") and (t=="M") and (c=="A") and (c2=="R") and (strsub(s,3,3)=="%")) or
				((atype=="S") and (t=="F") and (c==strsub(s,4,4))) or   -- IFF
				((atype=="S") and (t=="B") and (c==strsub(s,5,5))) or   -- Button
				((atype=="S") and (t=="K") and (c==strsub(s,6,6))) or   -- Spellbook
				((atype=="M") and (t==strsub(s,6,6))) or                -- Macro spellbook
				((atype=="!") and (t==strsub(s,6,6))) or                -- Companion type
				((atype=="C") and (v==strsub(s,6,6))) or                -- Chat type
				((atype=="-") and (t==strsub(s,7,7))) then              -- Spacer type
				info.checked=true;
			end
			UIDropDownMenu_AddButton(info,2);
		end
	end
end

function XCustomBarConfigActionSave_OnClick(self)
	local t1=XCustomBarConfigActionText:GetText();
	local t2="";
	local i,l,c,b,n,btn,a,p1,p1,s;

	_,b,n=XCustomBar_CurBar();
	btn=XCustomBar_CurButton();
	a=XCustomBar_CurAction();

	if ((b==nil) or (btn==nil) or (a==nil)) then
		return;
	end

	if (t1==nil) then
		t1="";
	end

	l=strlen(t1);
	i=1;
	while (i<=l) do
		c=strsub(t1,i,i);

		-- Unicode detection
		if strfind(XCUSTOMBAR_UNICODEPREFIXES,c,1,true) then
			c=strsub(t1,i,i+1);
			i=i+1;
		end

		-- can't use Pipe char "|" under any circumstances
		if ((strfind(XCUSTOMBAR_VALIDCHARS,c,1,true) or strfind(XCUSTOMBAR_LIMITEDCHARS,c,1,true)) and (c~="|")) then
			t2=t2..c;
		end
		i=i+1;
	end
	
	--Spell ID Detection
	--Required for non-type able characters in spell names
	if strsub(t2,1,1) == "^" then
		-- Extract the spell ID
		t2=strsub(t2,2);
		i=tonumber(t2);
		if (i ~= nil) and (i > 0) then
			-- Get the name
			t2=GetSpellInfo(i);
			-- See if its an actual spell
			if t2==nil then
				t2="";
			end
		else
			t2="";
		end
	end

	XCustomBarConfigActionText:SetText(t2);

	-- Validate name
	if (strlen(t2)==0) then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG2);
		return;
	end

	i,t1,p1,p2=XCustomBar_GetAction(b,btn,a);
	s=XCustomBarData.bars[b]["button"..tostring(btn)];
	if strsub(s,2,2)=="C" then
		if (strsub(s,p1+5,p1+5)=="W") or (strsub(s,p1+5,p1+5)=="C") then
			i=strfind(s,":",p1+6,true);
			if i then
				s=XCustomBar_StrReplace(s,p1+6,i-1,t2);
			else
				s=strsub(s,1,p1+5)..t2..":"..strsub(s,p1+6);
			end
			XCustomBarData.bars[b]["button"..tostring(btn)]=s;
			XCustomBarData.changed[b]=true;
		end
	else
		XCustomBarData.bars[b]["button"..tostring(btn)]=XCustomBar_StrReplace(s,p1+6,p2,t2);
		XCustomBarData.changed[b]=true;
	end
end

function XCustomBarConfigChatSave_OnClick(self)
	local t1=XCustomBarConfigChatScrollFrameText:GetText();
	local t2="";
	local i,l,c,b,n,btn,a,p1,p1,s;

	_,b,n=XCustomBar_CurBar();
	btn=XCustomBar_CurButton();
	a=XCustomBar_CurAction();

	if ((b==nil) or (btn==nil) or (a==nil)) then
		return;
	end

	if (t1==nil) then
		t1="";
	end

	l=strlen(t1);
	i=1;
	while (i<=l) do
		c=strsub(t1,i,i);

		-- Unicode detection
		if strfind(XCUSTOMBAR_UNICODEPREFIXES,c,1,true) then
			c=strsub(t1,i,i+1);
			i=i+1;
		end

		-- can't use Pipe char "|" under any circumstances
		if ((strfind(XCUSTOMBAR_VALIDCHARS,c,1,true) or strfind(XCUSTOMBAR_LIMITEDCHARS,c,1,true) or strfind(XCUSTOMBAR_CHATCHARS,c,1,true)) and (c~="|")) then
			t2=t2..c;
		end
		i=i+1;
	end

	XCustomBarConfigChatScrollFrameText:SetText(t2);

	-- Validate name
	if (strlen(t2)==0) then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG2);
		return;
	end

	i,t1,p1,p2=XCustomBar_GetAction(b,btn,a);
	s=XCustomBarData.bars[b]["button"..tostring(btn)];
	if strsub(s,2,2)=="C" then
		if (strsub(s,p1+5,p1+5)=="W") or (strsub(s,p1+5,p1+5)=="C") then
			i=strfind(s,":",p1+6,true);
			if i then
				s=XCustomBar_StrReplace(s,i+1,p2,t2);
			else
				s=strsub(s,1,p1+5)..XCustomBarConfigActionText:GetText()..":"..t2..strsub(s,p2+1);
			end
		else
			s=XCustomBar_StrReplace(s,p1+6,p2,t2);
		end
		XCustomBarData.bars[b]["button"..tostring(btn)]=s;
		XCustomBarData.changed[b]=true;
	end
end

function XCustomBarConfigButtonMoveDown_OnClick(self)
	local _,b,n,btn,s,c;
	
	_,b,n=XCustomBar_CurBar();
	btn=XCustomBar_CurButton();

	if ((b==nil) or (btn==nil)) then
		return;
	end
	
	if (btn < n) then
		c=btn+1;
		s=XCustomBarData.bars[b]["button"..tostring(btn)];
		XCustomBarData.bars[b]["button"..tostring(btn)]=XCustomBarData.bars[b]["button"..tostring(c)];
		XCustomBarData.bars[b]["button"..tostring(c)]=s;
		XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=c;
		if c>10 then
			c=c-10;
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollButtonsScrollFrame,c);
		end
		securecall(XCustomBarConfigScrollButtons_OnScroll);
		XCustomBarData.changed[b]=true;
	end
end

function XCustomBarConfigButtonMoveUp_OnClick(self)
	local _,b,n,btn,c,s;
	
	_,b,n=XCustomBar_CurBar();
	btn=XCustomBar_CurButton();

	if ((b==nil) or (btn==nil)) then
		return;
	end
	
	if (btn > 1) then
		c=btn-1;
		s=XCustomBarData.bars[b]["button"..tostring(btn)];
		XCustomBarData.bars[b]["button"..tostring(btn)]=XCustomBarData.bars[b]["button"..tostring(c)];
		XCustomBarData.bars[b]["button"..tostring(c)]=s;
		XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=c;
		s=FauxScrollFrame_GetOffset(XCustomBarConfigScrollButtonsScrollFrame);
		if (c==s) then
			s=s-1;
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollButtonsScrollFrame,s);
		end
		securecall(XCustomBarConfigScrollButtons_OnScroll);
		XCustomBarData.changed[b]=true;
	end
end

function XCustomBarConfigDelActionBtn_Click(self)
	local _,b,n,btn,t,s,a,p1,p2,c;

	_,b,n=XCustomBar_CurBar();
	btn=XCustomBar_CurButton();
	c=XCustomBar_CurAction();

	if ((b==nil) or (btn==nil) or (c==nil)) then
		return;
	end

	s=XCustomBarData.bars[b]["button"..tostring(btn)];
	n=tonumber(strsub(s,1,1));
	t=strsub(s,2,2);

	if (n==1) then
		return;
	end

	t,a,p1,p2=XCustomBar_GetAction(b,btn,c)

	-- Delete selected action
	n=n-1;
	s=XCustomBar_StrReplace(s,1,1,tostring(n));
	s=XCustomBar_StrReplace(s,p1,p2+1,"");
	XCustomBarData.bars[b]["button"..tostring(btn)]=s;

	-- Update the list
	-- Only adjust offset if needed
	-- This code is redundant and unnecessary since the current limit on actions per button is 9.  I'm leaving it in for the future if I expand the list.
	if (c>n) then
		XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=n;
		if (n>10) then
			n=n-10;
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollActionsScrollFrame,n);
		else
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollActionsScrollFrame,0);
		end
	end
	XCustomBarData.changed[b]=true;
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigDelBarBtn_Click(self)
	local b,n;

	i,b,n=XCustomBar_CurBar();
	n=XCustomBarData.nbars;

	if (b==nil) then
		return;
	end

	-- Move bars up if needed
	for x=i,(n-1) do
		XCustomBarData["bar"..tostring(x)]=XCustomBarData["bar"..tostring(x+1)];
	end
	
	-- Delete last bar
	XCustomBarData["bar"..tostring(n)]=nil;
	XCustomBarData.bars[b]=nil;
	n=n-1;
	XCustomBarData.nbars=n;

	--Queue the bar for cleanup next time the mod loads
	if (XCustomBarData.queue==nil) then
		XCustomBarData.queue={ };
	end
	tinsert(XCustomBarData.queue,b);

	-- Update the list
	-- Only adjust offset if needed
	if (n==0) then
		XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur=nil;
	elseif (i>n) then
		XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur=n;
		if (n>10) then
			n=n-10;
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollBarsScrollFrame,n);
		else
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollBarsScrollFrame,0);
		end
	end
	securecall(XCustomBarConfigScrollBars_OnScroll);
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=nil;
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	XCustomBarData.changed[b]=true;
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigDelButtonBtn_Click(self)
	local t=XBarCore.FrameDB.XCustomBarConfigNewButtonMenu.XBarCur;
	local i,b,n,x,c;

	i,b,n=XCustomBar_CurBar();
	c=XCustomBar_CurButton();

	if ((b==nil) or (n==1) or (c==nil)) then
		return;
	end

	-- Move buttons up if needed
	for x=c,(n-1) do
		XCustomBarData.bars[b]["button"..tostring(x)]=XCustomBarData.bars[b]["button"..tostring(x+1)];
	end
	
	-- Delete current button
	XCustomBarData.bars[b]["button"..tostring(n)]=nil;
	n=n-1;
	XCustomBarData.bars[b].nbuttons=n;

	-- Update the list
	-- Only adjust offset if needed
	if (c>n) then
		XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=n;
		if (n>10) then
			n=n-10;
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollButtonsScrollFrame,n);
		else
			FauxScrollFrame_SetOffset(XCustomBarConfigScrollButtonsScrollFrame,0);
		end
	end
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	XCustomBarData.changed[b]=true;
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigExportBarBtn_Click(self)
	local t,i,n,_,curbar;

	_,curbar,n=XCustomBar_CurBar();

	if not curbar then
		return;
	end

	if not (n and n > 0) then
		return;
	end

	t="XCBSTR"
	t=t..XCustomBar_PortMakeField(dbver);
	t=t..XCustomBar_PortMakeField(tostring(n));
	for i=1,n do
		t=t..XCustomBar_PortMakeField(XCustomBarData.bars[curbar]["button"..i]);
	end

	XCustomBarConfigPortBox:SetText(t);
end

function XCustomBarConfigImportBarBtn_Click(self)
	-- Quantify text
	local t1=XCustomBarConfigNewBar:GetText();
	local t2="";
	local portstr=XCustomBarConfigPortBox:GetText();
	local portdb={};
	local i,l,c,p,v;

	if (t1==nil) then
		t1="";
	end

	l=strlen(t1);
	i=1;
	while (i<=l) do
		c=strsub(t1,i,i);

		-- Unicode detection
		if strfind(XCUSTOMBAR_UNICODEPREFIXES,c,1,true) then
			c=strsub(t1,i,i+1);
			i=i+1;
		end

		if strfind(XCUSTOMBAR_VALIDCHARS,c,1,true) then
			t2=t2..c;
		end
		i=i+1;
	end

	XCustomBarConfigNewBar:SetText(t2);

	-- Validate name
	if (strlen(t2)==0) then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG14);
		return;
	end

	c=XCustomBarData.nbars;
	for i=1,c do
		if (t2==XCustomBarData["bar"..tostring(i)]) then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG3);
			return;
		end
	end

	--Bar name has been validated, now lets build and validate the DB.
	v=strsub(portstr,1,6);
	portstr=strsub(portstr,7);
	if v~="XCBSTR" then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG12);
		return;
	end

	-- Match DB ver
	v,p=XCustomBar_PortExtractField(portstr);
	if (v==nil or v=="") then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG12);
		return;
	elseif v~=dbver then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG13);
		return;
	end
	portstr=strsub(portstr,p);

	-- Get nbuttons
	v,p=XCustomBar_PortExtractField(portstr);
	if (v==nil or v=="") then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG12);
		return;
	else
		v=tonumber(v);
		if (v==nil) or (v<=0) then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG12);
			return;
		end
	end
	portdb.nbuttons=v;
	portstr=strsub(portstr,p);

	--Get buttons
	for i=1,portdb.nbuttons do
		v,p=XCustomBar_PortExtractField(portstr);
		if (v==nil or v=="") then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG12);
			return;
		elseif not XCustomBar_PortValidateButton(v) then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG12);
			return;
		end
		portstr=strsub(portstr,p);
		portdb["button"..i]=v;
	end

	-- Add new bars
	c=c+1;
	XCustomBarData.nbars=c;
	XCustomBarData["bar"..tostring(c)]=t2;
	XCustomBarData.bars[t2]=portdb; -- Import the database we made earlier during validation

	-- Update the list
	XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur=c;
	if (c>10) then
		c=c-10;
		FauxScrollFrame_SetOffset(XCustomBarConfigScrollBarsScrollFrame,c);
	end
	securecall(XCustomBarConfigScrollBars_OnScroll);
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=nil;
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigScrollActions_OnClick(iButton)
	-- Bar selected, update window to reflect.
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=XBarCore.FrameDB["XCustomBarConfigScrollActionsLine"..iButton].XBarValue;

	-- Update highlights and action related options by updating the list.
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigScrollActions_OnLoad(self)
	local bn=self:GetName();
	if XBarCore.FrameDB[bn] == nil then
		XBarCore.FrameDB[bn] = {};
	end
	XBarCore.FrameDB[bn].XBarOnScroll="XCustomBarConfigScrollActions_OnScroll";
	XBarCore.FrameDB[bn].XBarOnClick="XCustomBarConfigScrollActions_OnClick";
end

function XCustomBarConfigScrollActions_OnScroll(self)
	local i,o,v,curbar,curbtn,n,curact,curbtn,_,b,b2;

	if InCombatLockdown() then
		return;
	end

	_,curbar=XCustomBar_CurBar();
	curbtn=XCustomBar_CurButton();
	curact=XCustomBar_CurAction();
	if (curbar==nil) or (curbtn==nil) then
		n=0;
	else
		n=XCustomBarData.bars[curbar]["button"..tostring(curbtn)];
	end

	if (n==nil) then
		n=0;
	elseif (n=="") then
		n=0;
	else
		n=tonumber(strsub(n,1,1));
	end

	if not curbar or not curbtn then
		XCustomBarConfigNewActionBtn:Hide();
		XCustomBarConfigDelActionBtn:Hide();
	else
		o=XCustomBarData.bars[curbar]["button"..curbtn];
		o=strsub(o,2,2);
		if o=="S" then
			XCustomBarConfigNewActionBtn:Show();
			XCustomBarConfigDelActionBtn:Show();
		else
			XCustomBarConfigNewActionBtn:Hide();
			XCustomBarConfigDelActionBtn:Hide();
		end
	end

	o=FauxScrollFrame_GetOffset(XCustomBarConfigScrollActionsScrollFrame);
	for i=1,10 do
		v=i+o;
		b=getfenv()["XCustomBarConfigScrollActionsLine"..tostring(i)]
		b2=getfenv()["XCustomBarConfigScrollActionsLine"..tostring(i).."TextName"];
		if XBarCore.FrameDB["XCustomBarConfigScrollActionsLine"..tostring(i)] == nil then
			XBarCore.FrameDB["XCustomBarConfigScrollActionsLine"..tostring(i)] = {};
		end
		if (v>n) then
			b2:SetText("");
			XBarCore.FrameDB["XCustomBarConfigScrollActionsLine"..tostring(i)].XBarValue=nil;
			b:Hide();
		else
			b2:SetText("Action"..v);
			XBarCore.FrameDB["XCustomBarConfigScrollActionsLine"..tostring(i)].XBarValue=v;
			b:Show();
		end
	end

	if (n <= 10) then
		-- Extra stuff, lets hide our glider textures
		XCustomBarConfigScrollActionsGliderBar1:Hide();
		XCustomBarConfigScrollActionsGliderBar2:Hide();
		XCustomBarConfigScrollActionsGliderBar3:Hide();
	else
		XCustomBarConfigScrollActionsGliderBar1:Show();
		XCustomBarConfigScrollActionsGliderBar2:Show();
		XCustomBarConfigScrollActionsGliderBar3:Show();
	end
	
	-- Update highlights
	XBarScrollFrame_ClearHighlights("XCustomBarConfigScrollActions");
	if (curact) then
		XBarScrollFrame_Highlight("XCustomBarConfigScrollActions",curact-o);
		if (XCustomBarConfigActionMenu ~= nil) then
			XCustomBarConfigActionMenu:Enable();
			XCustomBarConfigActionLabel:Show();
			XCustomBarConfigActionText:Show();
			XCustomBarConfigActionSave:Show();
			XCustomBarConfigChatLabel:Hide();
			XCustomBarConfigChatScrollFrame:Hide();
			XCustomBarConfigChatFrameBackground:Hide();
			XCustomBarConfigChatSave:Hide();
			XCustomBarConfigTextureNext:Hide();
			XCustomBarConfigTexturePrev:Hide();
			XCustomBarConfigTextureShow:Hide();
			XCustomBarConfigTextureSave:Hide();
			i,v=XCustomBar_GetAction(curbar,curbtn,curact);
			if (i=="S") then
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELSPELL);
				XCustomBarConfigActionText:SetText(strsub(v,7));
			elseif (i=="M") then
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELMACRO);
				XCustomBarConfigActionText:SetText(strsub(v,7));
			elseif (i=="I") then
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELITEM);
				XCustomBarConfigActionMenu:Disable();
				XCustomBarConfigActionText:SetText(strsub(v,7));
			elseif (i=="!") then
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELCOMPANION);
				XCustomBarConfigActionText:SetText(strsub(v,7));
			elseif (i=="E") then
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELEMOTE);
				XCustomBarConfigActionMenu:Disable();
				v=XCustomBarData.bars[curbar]["button"..curbtn.."icon"];
				if v==nil then
					XCustomBarData.bars[curbar]["button"..curbtn.."icon"]=1;
					v=1;
				end
				XCustomBarConfigTextureShow_SetID(v);
				XCustomBarConfigTextureNext:Show();
				XCustomBarConfigTexturePrev:Show();
				XCustomBarConfigTextureShow:Show();
				XCustomBarConfigTextureSave:Show();
			elseif (i=="C") then
				v=XCustomBarData.bars[curbar]["button"..curbtn.."icon"];
				if v==nil then
					XCustomBarData.bars[curbar]["button"..curbtn.."icon"]=1;
					v=1;
				end
				XCustomBarConfigChatLabel:Show();
				XCustomBarConfigChatScrollFrame:Show();
				XCustomBarConfigChatFrameBackground:Show();
				XCustomBarConfigChatSave:Show();
				XCustomBarConfigTextureNext:Show();
				XCustomBarConfigTexturePrev:Show();
				XCustomBarConfigTextureShow:Show();
				XCustomBarConfigTextureSave:Show();
				XCustomBarConfigTextureShow_SetID(v);
				atype,v=XCustomBar_GetAction(curbar,curbtn,curact);
				o=strsub(v,7);
				b=strfind(o,":");
				if b then
					XCustomBarConfigActionText:SetText(strsub(o,1,b-1));
					b=b+1;
				else
					XCustomBarConfigActionText:SetText("");
					b=1
				end
				v=strsub(v,6,6);
				if v=="W" then
					XCustomBarConfigChatScrollFrameText:SetText(strsub(o,b));
					XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELWHISPER);
					XCustomBarConfigActionLabel:Show();
					XCustomBarConfigActionText:Show();
					XCustomBarConfigActionSave:Show();
				elseif v=="C" then
					XCustomBarConfigChatScrollFrameText:SetText(strsub(o,b));
					XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELCHANNEL);
					XCustomBarConfigActionLabel:Show();
					XCustomBarConfigActionText:Show();
					XCustomBarConfigActionSave:Show();
				else
					XCustomBarConfigChatScrollFrameText:SetText(o);
					XCustomBarConfigActionLabel:Hide();
					XCustomBarConfigActionText:Hide();
					XCustomBarConfigActionSave:Hide();
				end
			elseif (i=="#") then
				XCustomBarConfigActionText:SetText(strsub(v,7));
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELHEADER);
				XCustomBarConfigActionMenu:Disable();
			elseif (i=="-") then
				XCustomBarConfigActionText:SetText(strsub(v,7));
				XCustomBarConfigActionLabel:SetText(XCUSTOMBAR_LABELSPACER);
				XCustomBarConfigActionLabel:Hide();
				XCustomBarConfigActionText:Hide();
				XCustomBarConfigActionSave:Hide();
			end
		end
	else
		-- Nothing highlighted, lets disable the options
		if (XCustomBarConfigActionMenu ~= nil) then
			XCustomBarConfigActionMenu:Disable();
			XCustomBarConfigActionLabel:Hide();
			XCustomBarConfigActionText:Hide();
			XCustomBarConfigActionSave:Hide();
		end
	end

	FauxScrollFrame_Update(XCustomBarConfigScrollActionsScrollFrame,n,10,16);
end

function XCustomBarConfigScrollBars_OnClick(iButton)
	local v;

	-- Update highlights
	XBarScrollFrame_ClearHighlights("XCustomBarConfigScrollBars");
	XBarScrollFrame_Highlight("XCustomBarConfigScrollBars",iButton);

	-- Bar selected, update window to reflect.
	v=XBarCore.FrameDB["XCustomBarConfigScrollBarsLine"..tostring(iButton)].XBarValue;
	XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur=v;
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=nil;
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigScrollBars_OnLoad(self)
	local bn=self:GetName();
	if XBarCore.FrameDB[bn] == nil then
		XBarCore.FrameDB[bn] = {};
	end
	XBarCore.FrameDB[bn].XBarOnScroll="XCustomBarConfigScrollBars_OnScroll";
	XBarCore.FrameDB[bn].XBarOnClick="XCustomBarConfigScrollBars_OnClick";
end

function XCustomBarConfigScrollBars_OnScroll(self)
	local i,o,v,curi,curb,b,b2;

	if InCombatLockdown() then
		return;
	end
	
	curi,curb=XCustomBar_CurBar();
	n=XCustomBarData.nbars;
	if (n==nil) then
		n=0;
	end;
	o=FauxScrollFrame_GetOffset(XCustomBarConfigScrollBarsScrollFrame);
	for i=1,10 do
		v=i+o;
		b=getfenv()["XCustomBarConfigScrollBarsLine"..tostring(i)];
		b2=getfenv()["XCustomBarConfigScrollBarsLine"..tostring(i).."TextName"];
		if XBarCore.FrameDB["XCustomBarConfigScrollBarsLine"..tostring(i)] == nil then
			XBarCore.FrameDB["XCustomBarConfigScrollBarsLine"..tostring(i)] = {};
		end
		if (v>n) then
			b2:SetText("");
			XBarCore.FrameDB["XCustomBarConfigScrollBarsLine"..tostring(i)].XBarValue=nil;
			b:Hide();
		else
			b2:SetText(XCustomBarData["bar"..v]);
			XBarCore.FrameDB["XCustomBarConfigScrollBarsLine"..tostring(i)].XBarValue=v;
			b:Show();
		end
	end
	if (n <= 10) then
		-- Extra stuff, lets hide our glider textures
		XCustomBarConfigScrollBarsGliderBar1:Hide();
		XCustomBarConfigScrollBarsGliderBar2:Hide();
		XCustomBarConfigScrollBarsGliderBar3:Hide();
	else
		XCustomBarConfigScrollBarsGliderBar1:Show();
		XCustomBarConfigScrollBarsGliderBar2:Show();
		XCustomBarConfigScrollBarsGliderBar3:Show();
	end
	
	-- Update highlights
	XBarScrollFrame_ClearHighlights("XCustomBarConfigScrollBars");
	if (curi) then
		XBarScrollFrame_Highlight("XCustomBarConfigScrollBars",curi-o);
	end

	FauxScrollFrame_Update(XCustomBarConfigScrollBarsScrollFrame,n,10,16);
end

function XCustomBarConfigScrollButtons_OnClick(iButton)
	-- Update highlights
	XBarScrollFrame_ClearHighlights("XCustomBarConfigScrollButtons");
	XBarScrollFrame_Highlight("XCustomBarConfigScrollButtons",iButton);

	-- Bar selected, update window to reflect.
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=XBarCore.FrameDB["XCustomBarConfigScrollButtonsLine"..iButton].XBarValue;
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	securecall(XCustomBarConfigScrollActions_OnScroll);
	securecall(XCustomBarConfigScrollActions_OnClick,1);
end

function XCustomBarConfigScrollButtons_OnLoad(self)
	local bn=self:GetName();
	if XBarCore.FrameDB[bn] == nil then
		XBarCore.FrameDB[bn] = {};
	end
	XBarCore.FrameDB[bn].XBarOnScroll="XCustomBarConfigScrollButtons_OnScroll";
	XBarCore.FrameDB[bn].XBarOnClick="XCustomBarConfigScrollButtons_OnClick";
end

function XCustomBarConfigScrollButtons_OnScroll(self)
	local i,o,v,curbar,n,curbtn,_,b,b2,t;

	if InCombatLockdown() then
		return;
	end
	
	_,curbar,n=XCustomBar_CurBar();
	curbtn=XCustomBar_CurButton();
	o=FauxScrollFrame_GetOffset(XCustomBarConfigScrollButtonsScrollFrame);
	for i=1,10 do
		v=i+o;
		b=getfenv()["XCustomBarConfigScrollButtonsLine"..tostring(i)]
		b2=getfenv()["XCustomBarConfigScrollButtonsLine"..tostring(i).."TextName"];
		if XBarCore.FrameDB["XCustomBarConfigScrollButtonsLine"..tostring(i)] == nil then
			XBarCore.FrameDB["XCustomBarConfigScrollButtonsLine"..tostring(i)] = {};
		end
		if (v>n) then
			b2:SetText("");
			XBarCore.FrameDB["XCustomBarConfigScrollButtonsLine"..tostring(i)].XBarValue=nil;
			b:Hide();
		else
			t=XCustomBarData.bars[curbar]["button"..v];
			t=strsub(t,2,2);
			if t=="S" then
				t=XCUSTOMBAR_LABELSPELL;
			elseif t=="M" then
				t=XCUSTOMBAR_LABELMACRO;
			elseif t=="I" then
				t=XCUSTOMBAR_LABELITEM;
			elseif t=="!" then
				t=XCUSTOMBAR_LABELCOMPANION;
			elseif t=="E" then
				t=XCUSTOMBAR_LABELEMOTE;
			elseif t=="C" then
				t=XCUSTOMBAR_LABELCHAT;
			elseif t=="#" then
				t=XCUSTOMBAR_LABELHEADER;
			elseif t=="-" then
				t=XCUSTOMBAR_LABELSPACER;
			end
			b2:SetText(v.." "..t);
			XBarCore.FrameDB["XCustomBarConfigScrollButtonsLine"..tostring(i)].XBarValue=v;
			b:Show();
		end
	end
	if (n <= 10) then
		-- Extra stuff, lets hide our glider textures
		XCustomBarConfigScrollButtonsGliderBar1:Hide();
		XCustomBarConfigScrollButtonsGliderBar2:Hide();
		XCustomBarConfigScrollButtonsGliderBar3:Hide();
	else
		XCustomBarConfigScrollButtonsGliderBar1:Show();
		XCustomBarConfigScrollButtonsGliderBar2:Show();
		XCustomBarConfigScrollButtonsGliderBar3:Show();
	end
	
	-- Update highlights
	XBarScrollFrame_ClearHighlights("XCustomBarConfigScrollButtons");
	if (curbtn) then
		XBarScrollFrame_Highlight("XCustomBarConfigScrollButtons",curbtn-o);
	end

	FauxScrollFrame_Update(XCustomBarConfigScrollButtonsScrollFrame,n,10,16);
end

function XCustomBarConfigTextureNext_OnClick(self)
	local i=XCustomBar_TexID;
	if i == GetNumMacroIcons() then
		i=1;
	else
		i=i+1;
	end
	XCustomBarConfigTextureShow_SetID(i);
end

function XCustomBarConfigTexturePrev_OnClick(self)
	local i=XCustomBar_TexID;

	if i == 1 then
		i=GetNumMacroIcons();
	else
		i=i-1;
	end
	XCustomBarConfigTextureShow_SetID(i);
end

function XCustomBarConfigTextureSave_OnClick(self)
	local curbar,curbtn,v;

	if InCombatLockdown() then
		return;
	end

	_,curbar=XCustomBar_CurBar();
	curbtn=XCustomBar_CurButton();

	if (curbar) and (curbtn) then
		v=XCustomBarData.bars[curbar]["button"..curbtn.."icon"];
		if not v then
			XCustomBarData.bars[curbar]["button"..curbtn.."icon"]=1;
			v=1;
			XCustomBar_TexID=1;
			XCustomBarConfigTextureShow_Update();
		else
			XCustomBarData.bars[curbar]["button"..curbtn.."icon"]=XCustomBar_TexID;
		end
	end
end

function XCustomBarConfigTextureShow_SetID(i)
	XCustomBar_TexID=i;
	XCustomBarConfigTextureShow_Update();
end

function XCustomBarConfigTextureShow_Update()
	local t=GetNumMacroIcons(); -- This is a dummy to load the icon cache

	if not XCustomBar_TexID then
		return;
	end

	XCustomBarConfigTextureShow:SetTexture(GetMacroIconInfo(XCustomBar_TexID));
end

function XCustomBarConfigNewActionBtn_Click(self)
	local _,b,n,btn,t,s;
	
	_,b,n=XCustomBar_CurBar();
	btn=XCustomBar_CurButton();

	if ((b==nil) or (btn==nil)) then
		return;
	end

	s=XCustomBarData.bars[b]["button"..tostring(btn)];
	n=tonumber(strsub(s,1,1));
	t=strsub(s,2,2);

	if (n>=9) then
		return;
	end

	-- Add new action
	n=n+1;
	s=XCustomBar_StrReplace(s,1,1,tostring(n));
	if (t=="S") then
		t="---0*S"..XCUSTOMBAR_LABELSPELL.."|";
	elseif (t=="M") then
		t="---0*S"..XCUSTOMBAR_LABELMACRO.."|";
	elseif (t=="I") then
		t="---0*_"..t..XCUSTOMBAR_LABELITEM.."|"
	elseif (t=="!") then
		t="---0*M"..XCUSTOMBAR_LABELCOMPANION.."|";
	elseif (t=="E") then
		t="---0*_"..XCUSTOMBAR_LABELEMOTE.."|";
		XCustomBarData.bars[b]["button"..tostring(btn).."icon"]=1;
	elseif (t=="C") then
		t="---0*S"..XCUSTOMBAR_LABELCHAT.."|";
		XCustomBarData.bars[b]["button"..tostring(btn).."icon"]=1;
	elseif (t=="#") then
		t="---0*_"..XCUSTOMBAR_LABELHEADER.."|";
	elseif (t=="-") then
		t="---0*_W|";
	end
	XCustomBarData.bars[b]["button"..tostring(btn)]=s..t;

	-- Update the list
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=n;
	if (n>10) then
		n=n-10;
		FauxScrollFrame_SetOffset(XCustomBarConfigScrollActionsScrollFrame,n);
	end
	XCustomBarData.changed[b]=true;
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigNewBarBtn_Click(self)
	-- Quantify text
	local t1=XCustomBarConfigNewBar:GetText();
	local t2="";
	local i,l,c;

	if (t1==nil) then
		t1="";
	end

	l=strlen(t1);
	i=1;
	while (i<=l) do
		c=strsub(t1,i,i);

		-- Unicode detection
		if strfind(XCUSTOMBAR_UNICODEPREFIXES,c,1,true) then
			c=strsub(t1,i,i+1);
			i=i+1;
		end

		if strfind(XCUSTOMBAR_VALIDCHARS,c,1,true) then
			t2=t2..c;
		end
		i=i+1;
	end

	XCustomBarConfigNewBar:SetText(t2);

	-- Validate name
	if (strlen(t2)==0) then
		DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG14);
		return;
	end

	c=XCustomBarData.nbars;
	for i=1,c do
		if (t2==XCustomBarData["bar"..tostring(i)]) then
			DEFAULT_CHAT_FRAME:AddMessage(XCUSTOMBAR_MSG3);
			return;
		end
	end

	-- Add new bars
	c=c+1;
	XCustomBarData.nbars=c;
	XCustomBarData["bar"..tostring(c)]=t2;
	XCustomBarData.bars[t2]={
		["nbuttons"]=1,
		["button1"]="1S---0*S"..XCUSTOMBAR_LABELSPELL.."|",
	};

	-- Update the list
	XBarCore.FrameDB.XCustomBarConfigScrollBars.XBarCur=c;
	if (c>10) then
		c=c-10;
		FauxScrollFrame_SetOffset(XCustomBarConfigScrollBarsScrollFrame,c);
	end
	securecall(XCustomBarConfigScrollBars_OnScroll);
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=nil;
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigNewButtonBtn_Click(self)
	local t=XBarCore.FrameDB.XCustomBarConfigNewButtonMenu.XBarCur;
	local i,b,n;
	
	i,b,n=XCustomBar_CurBar();

	if (b==nil) then
		return;
	end

	-- Add new button
	n=n+1;
	XCustomBarData.bars[b].nbuttons=n;
	if (t=="S") then
		t="1S---0*S"..XCUSTOMBAR_LABELSPELL.."|";
	elseif (t=="M") then
		t="1M---0*S"..XCUSTOMBAR_LABELMACRO.."|";
	elseif (t=="I") then
		t="1I---0*_"..XCUSTOMBAR_LABELITEM.."|";
	elseif (t=="!") then
		t="1!---0*M"..XCUSTOMBAR_LABELCOMPANION.."|";
	elseif (t=="E") then
		t="1E---0*_"..XCUSTOMBAR_LABELEMOTE.."|";
		XCustomBarData.bars[b]["button"..tostring(n).."icon"]=1;
	elseif (t=="C") then
		t="1C---0*S"..XCUSTOMBAR_LABELCHAT.."|";
		XCustomBarData.bars[b]["button"..tostring(n).."icon"]=1;
	elseif (t=="#") then
		t="1#---0*_"..XCUSTOMBAR_LABELHEADER.."|";
	elseif (t=="-") then
		t="1----0*_W|";
	end
	XCustomBarData.bars[b]["button"..tostring(n)]=t;

	-- Update the list
	XBarCore.FrameDB.XCustomBarConfigScrollButtons.XBarCur=n;
	if (n>10) then
		n=n-10;
		FauxScrollFrame_SetOffset(XCustomBarConfigScrollButtonsScrollFrame,n);
	end
	securecall(XCustomBarConfigScrollButtons_OnScroll);
	XBarCore.FrameDB.XCustomBarConfigScrollActions.XBarCur=nil;
	XCustomBarData.changed[b]=true;
	securecall(XCustomBarConfigScrollActions_OnScroll);
end

function XCustomBarConfigNewButtonMenu_OnClick(self)
	UIDropDownMenu_Initialize(XCustomBarConfigNewButtonMenuFrame, XCustomBarConfigNewButtonMenuFrame_OnLoad);
	ToggleDropDownMenu(1, nil, XCustomBarConfigNewButtonMenuFrame, XCustomBarConfigNewButtonMenu, 0, 0);
end

function XCustomBarConfigNewButtonMenu_Select(self)
	local v=self.value;

	if (v=="S") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELSPELL);
	elseif (v=="M") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELMACRO);
	elseif (v=="I") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELITEM);
	elseif (v=="!") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELCOMPANION);
	elseif (v=="E") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELEMOTE);
	elseif (v=="C") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELCHAT);
	elseif (v=="#") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELHEADER);
	elseif (v=="-") then
		XCustomBarConfigNewButtonLabel:SetText(XCUSTOMBAR_LABELSPACER);
	end
	XBarCore.FrameDB.XCustomBarConfigNewButtonMenu.XBarCur=v;
end

function XCustomBarConfigNewButtonMenuFrame_OnLoad(self,level)
	-- Loading off the click event from the button itself so we can make sure the data is there.
	-- Reinitializes every time we click the button.
	local info = UIDropDownMenu_CreateInfo();

	info.func = XCustomBarConfigNewButtonMenu_Select;
	info.owner = self:GetParent();
	info.hasArrow=false;
	info.notCheckable=true;

	info.text = XCUSTOMBAR_LABELSPELL;
	info.value="S";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELMACRO;
	info.value="M";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELITEM;
	info.value="I";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELCOMPANION;
	info.value="!";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELEMOTE;
	info.value="E";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELCHAT;
	info.value="C";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELHEADER;
	info.value="#";
	UIDropDownMenu_AddButton(info,1);

	info.text = XCUSTOMBAR_LABELSPACER;
	info.value="-";
	UIDropDownMenu_AddButton(info,1);
end
