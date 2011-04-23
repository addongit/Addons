local debugg = false
if select(2, UnitClass("player")) == "DEATHKNIGHT" then	
	if debugg then print("CLCDK:Starting")end	
	CLCDK_VERSION = 4.016	
	
	-----Create Main Frame-----
	local CLCDK = CreateFrame("Button", "CLCDK", UIParent)
	CLCDK:SetWidth(94)
	CLCDK:SetHeight(68)
	CLCDK:SetFrameStrata("BACKGROUND")	

	-----Locals-----
	--Constants
	local PLAYER_NAME, PLAYER_RACE = UnitName("player"), select(2, UnitRace("player"))
	local SPEC_UNKNOWN, SPEC_BLOOD, SPEC_FROST, SPEC_UNHOLY = 0, 1, 2, 3
	local BBUUFF, BBFFUU, UUBBFF, UUFFBB, FFUUBB, FFBBUU = 1, 2, 3, 4, 5, 6
	local DISEASE_BOTH, DISEASE_ONE, DISEASE_NONE = 2, 1, 0
	local THREAT_OFF, THREAT_ANALOG, THREAT_DIGITAL = 0, 1, 99	
	local IS_BUFF = 2
	local ITEM_LOAD_THRESHOLD = .5
	local RUNE_COLOUR = {{1, 0, 0},{0, 0.95, 0},{0, 1, 1},{0.8, 0.1, 1}} --Blood,  Unholy,  Frost,  Death
	
	--Variables
	local DTspells
	local loaded, mutex = false, false
	local mousex, mousey
	local font = 'Interface\\AddOns\\CLC_DK\\Font.ttf'
	local GetTime = GetTime
	local darksim = {0, 0}
	local simtime = 0
	local GCD, curtime, launchtime = 0, 0, 0
	local Current_Spec, FS_Reduce, DC_Reduce, HB_Glyph, PoolInterrupt, epidemic, DND_Glyph = SPEC_UNKNOWN, 0, 0, false, 0, 0, 0
	local updatetimer = 0

	if debugg then print("CLCDK:Locals Done")end

	--If User has Button Facade, then set up skinning function
	local LBF = LibStub("LibButtonFacade", true)	
	if LBF then
		function CLCDK:OnSkin(skin, gloss, backdrop, _, _, colours)	
			CLCDK_Settings.lbf[1] = skin
			CLCDK_Settings.lbf[2] = gloss
			CLCDK_Settings.lbf[3] = backdrop
			CLCDK_Settings.lbf[4] = colours	
		end
	end
	
	local spells
	function CLCDK:LoadSpells()
		if spells ~= nil then wipe(spells) end
		spells = {}
		spells = {
			["Anti-Magic Shell"] = GetSpellInfo(48707),
			["Army of the Dead"] = GetSpellInfo(42650),
			["Blood Boil"] = GetSpellInfo(48721),	
			["Blood Plague"] = GetSpellInfo(59879),	
			["Blood Strike"] = GetSpellInfo(45902),
			["Blood Tap"] = GetSpellInfo(45529),
			["Dark Command"] = GetSpellInfo(56222),
			["Dark Simulacrum"] = GetSpellInfo(77606), --Cata
			["Death and Decay"] = GetSpellInfo(43265),	
			["Death Coil"] = GetSpellInfo(47541),
			["Death Grip"] = GetSpellInfo(49576),	
			["Death Pact"] = GetSpellInfo(48743),
			["Death Strike"] = GetSpellInfo(49998),		
			["Empower Rune Weapon"] = GetSpellInfo(47568),	
			["Festering Strike"] = GetSpellInfo(85948),	--Cata
			["Frost Fever"] = GetSpellInfo(59921),
			["Horn of Winter"] = GetSpellInfo(57330),		
			["Icebound Fortitude"] = GetSpellInfo(48792),
			["Icy Touch"] = GetSpellInfo(45477),		
			["Mind Freeze"] = GetSpellInfo(47528),
			["Necrotic Strike"] = GetSpellInfo(73975), --Cata		
			["Obliterate"] = GetSpellInfo(49020),		
			["Outbreak"] = GetSpellInfo(77575), --Cata
			["Pestilence"] = GetSpellInfo(50842),		
			["Plague Strike"] = GetSpellInfo(45462),		
			["Raise Ally"] = GetSpellInfo(61999),
			["Raise Dead"] = GetSpellInfo(46584),	
			["Rune Strike"] = GetSpellInfo(56815),	
			["Strangulate"] = GetSpellInfo(47476),	
			
			--Blood Only
			["Blade Barrier"] = GetSpellInfo(64856), 
			["Blood Shield"] = GetSpellInfo(77535),		
			["Crimson Scourge"] = GetSpellInfo(81141),
			["Bone Shield"] = GetSpellInfo(49222),
			["Dancing Rune Weapon"] = GetSpellInfo(49028),
			["Heart Strike"] = GetSpellInfo(55050),
			["Rune Tap"] = GetSpellInfo(48982),		
			["Scarlet Fever"] = GetSpellInfo(81130),		
			["Vampiric Blood"] = GetSpellInfo(55233),
			
			--Frost Only
			["Chilblains"] = GetSpellInfo(50041),
			["Freezing Fog"] = GetSpellInfo(59052),
			["Frost Strike"] = GetSpellInfo(49143),		
			["Howling Blast"] = GetSpellInfo(49184),
			["Hungering Cold"] = GetSpellInfo(49203),	
			["Killing Machine"] = GetSpellInfo(51124),
			["Lichborne"] = GetSpellInfo(49039),
			["Pillar of Frost"] = GetSpellInfo(51271),	
							
			--Unholy Only
			["Anti-Magic Zone"] = GetSpellInfo(51052),
			["Dark Transformation"] = GetSpellInfo(63560),
			["Desolation"] = GetSpellInfo(63583),
			["Ebon Plague"] = GetSpellInfo(65142),
			["Gnaw"] =  GetSpellInfo(91800),
			["Runic Corruption"] = GetSpellInfo(51460),
			["Scourge Strike"] = GetSpellInfo(55090),			
			["Shadow Infusion"] = GetSpellInfo(91342),	
			["Sudden Doom"] = GetSpellInfo(81340),
			["Summon Gargoyle"] = GetSpellInfo(49206),
			["Unholy Frenzy"] = GetSpellInfo(49016),

			--Tier Sets
			["T9 2pc"] = GetSpellInfo(67117),	
			["T10 4pc"] = GetSpellInfo(70657),
			["T11 4pc"] = GetSpellInfo(90507),
			
			--Racials
			["Human"] = GetSpellInfo(59752),--Every Man for Himself
			["Dwarf"] = GetSpellInfo(20594),--Stoneform
			["NightElf"] = GetSpellInfo(58984),--Shadowmeld
			["Gnome"] = GetSpellInfo(20589),--Escape Artist 
			["Draenei"] = GetSpellInfo(28880),--Gift of the Naaru
			["Worgen"] = GetSpellInfo(68992),--Darkflight
			
			["Orc"] = GetSpellInfo(33697),--Blood Fury
			["Scourge"] = GetSpellInfo(7744),--Will of the Forsaken 
			["Tauren"] = GetSpellInfo(20549),--War Stomp
			["Troll"] = GetSpellInfo(26297),--Berserking
			["BloodElf"] = GetSpellInfo(28730),--Arcane Torrent
			["Goblin"] = GetSpellInfo(69070),--Rocket Jump
		}
		
		DTspells = {
			[spells["Frost Fever"]] = {59921, 21, true},
			[spells["Blood Plague"]] = {59879, 21, true},
			[spells["Death and Decay"]] = {43265, 10, false},
			
			[spells["Ebon Plague"]] = {65142, 21, true},
			
			[spells["Scarlet Fever"]] = {81130, 21, true},
			
			[spells["Chilblains"]] = {50041, 10, false},
		}
		
		if debugg then print("CLCDK:Spells Loaded")end
	end
			
	local Cooldowns
	function CLCDK:LoadCooldowns()
		if Cooldowns~= nil then wipe(Cooldowns) end
		Cooldowns = {}
		Cooldowns = {
			NormCDs = {--CDs that all DKs get
				spells["Anti-Magic Shell"],
				spells["Army of the Dead"],			
				spells["Blood Tap"],
				spells["Dark Command"],
				spells["Dark Simulacrum"],
				spells["Death and Decay"],
				spells["Death Grip"],
				spells["Death Pact"],
				spells["Empower Rune Weapon"],
				spells["Horn of Winter"],
				spells["Icebound Fortitude"],
				spells["Mind Freeze"],
				spells["Necrotic Strike"],
				spells["Outbreak"],
				spells["Raise Ally"],
				spells["Raise Dead"],
				spells["Strangulate"],
			},
			UnholyCDs = {--Unholy Only
				spells["Anti-Magic Zone"],
				spells["Dark Transformation"],
				spells["Ebon Plague"],
				spells["Gnaw"],
				spells["Runic Corruption"],
				spells["Shadow Infusion"],
				spells["Summon Gargoyle"],	
				spells["Sudden Doom"],
				spells["Unholy Frenzy"],
			},
			FrostCDs = {--Frost Only
				spells["Chilblains"],
				spells["Freezing Fog"],
				spells["Hungering Cold"],
				spells["Killing Machine"],
				spells["Lichborne"],
				spells["Pillar of Frost"],			
			},
			BloodCDs = {--Blood Only
				spells["Blade Barrier"],
				spells["Blood Shield"],
				spells["Bone Shield"],	
				spells["Crimson Scourge"],
				spells["Dancing Rune Weapon"],
				spells["Rune Tap"],	
				spells["Scarlet Fever"],
				spells["Vampiric Blood"],
			},
			Buffs = {--List of Buffs
				--- How to use {who gets buff,  Is it also a CD?}
				--normal
				[spells["Anti-Magic Shell"]] = {"player", true},
				[spells["Dark Simulacrum"]] = {"target", true},	
				[spells["Horn of Winter"]] = {"player", true},
				[spells["Icebound Fortitude"]] = {"player", true},
				[spells["Necrotic Strike"]] = {"target", false},
				[spells["Strangulate"]] = {"target", true},		
						
				--unholy
				[spells["Dark Transformation"]] = {"pet", false},
				[spells["Shadow Infusion"]] = {"pet", false},	
				[spells["Unholy Frenzy"]] = {"player", true},
				[spells["Runic Corruption"]] = {"player", false},
				[spells["Sudden Doom"]] = {"player", false},
				[spells["Ebon Plague"]] = {"target", false},
				
				--frost
				[spells["Pillar of Frost"]] = {"player", true},
				[spells["Lichborne"]] = {"player", true},
				[spells["Freezing Fog"]] = {"player", false},
				[spells["Killing Machine"]] = {"player", false},
				[spells["Chilblains"]] = {"target", false},
				
				--blood
				[spells["Blade Barrier"]] = {"player", false},	
				[spells["Blood Shield"]] = {"player", false},	
				[spells["Bone Shield"]] = {"player", true},	
				[spells["Crimson Scourge"]] = {"player", false},
				[spells["Dancing Rune Weapon"]] = {"player", true},
				[spells["Vampiric Blood"]] = {"player", true},
				[spells["Scarlet Fever"]] = {"target", false},
				
				--Tier
				[spells["T9 2pc"]] = {"player", false},	
				[spells["T10 4pc"]] = {"player", false},
				[spells["T11 4pc"]] = {"player", false},	
			},
			Moves = {--List of Moves that can be watched when availible
				spells["Blood Boil"],
				spells["Blood Strike"],
				spells["Death Coil"],
				spells["Death Strike"],
				spells["Festering Strike"],
				spells["Frost Strike"],
				spells["Heart Strike"],
				spells["Howling Blast"],
				spells["Icy Touch"],
				spells["Necrotic Strike"],
				spells["Obliterate"],
				spells["Pestilence"],
				spells["Plague Strike"],
				spells["Rune Strike"],
				spells["Scourge Strike"],
			},				
		}
		if debugg then print("CLCDK:Cooldowns Loaded")end
	end	

	function CLCDK:LoadTrinkets()
		local loaded = true
		
		local function AddTrinket(name, info) --BuffID, Is on use?, (ItemID or ICD), start, cd flag, alternative buff	
			if name == nil then 
				loaded = false
				if debugg then print("CLCDK:Trinket Not Found - Buff: "..info[1])end
			else 
				Cooldowns.Trinkets[name] = info
			end
		end
		Cooldowns.Trinkets = {}	
		
		--Test trinket that doesnt exist
		--AddTrinket(select(1, GetItemInfo(1)), {"Test Trinket"})
		
		--On-Use		
		--Impatience of Youth
		spells["Thrill of Victory"] = GetSpellInfo(91828)
		AddTrinket(select(1, GetItemInfo(62469)), {spells["Thrill of Victory"], true, 62469})
		
		-- Vial of Stolen Memories
		spells["Memory of Invincibility"] = GetSpellInfo(92213)
		AddTrinket(select(1, GetItemInfo(59515)), {spells["Memory of Invincibility"], true, 59515})
		
		-- Figurine - King of Boars
		spells["King of Boars"] = GetSpellInfo(73522)
		AddTrinket(select(1, GetItemInfo(52351)), {spells["King of Boars"], true, 52351})
		
		-- Figurine - Earthen Guardian
		spells["Earthen Guardian"] = GetSpellInfo(73550)
		AddTrinket(select(1, GetItemInfo(52352)), {spells["Earthen Guardian"], true, 52352})
		
		-- Might of the Ocean
		spells["Typhoon"] = GetSpellInfo(91340)
		AddTrinket(select(1, GetItemInfo(56285)), {spells["Typhoon"], true, 56285})
		
		-- Magnetite Mirror
		spells["Polarization"] = GetSpellInfo(91351)
		AddTrinket(select(1, GetItemInfo(55814)), {spells["Polarization"], true, 55814})
		
		-- Mirror of Broken Images
		spells["Image of Immortality"] = GetSpellInfo(92222)
		AddTrinket(select(1, GetItemInfo(62466)), {spells["Image of Immortality"], true, 62466})
		
			
		--Stacking Buff	
		--"License to Slay
		spells["Slayer"] = GetSpellInfo(91810)
		AddTrinket(select(1, GetItemInfo(58180)), {spells["Slayer"], false, 0, 0, false})
		
		-- Fury of Angerforge
		spells["Forged Fury"] = GetSpellInfo(91836)
		spells["Raw Fury"] = GetSpellInfo(91832)
		AddTrinket(select(1, GetItemInfo(59461)), {spells["Forged Fury"], false, 120, 0, false, spells["Raw Fury"]})

		
		--ICD
		-- Heart of Rage
		spells["Rageheart"] = GetSpellInfo(92345)
		AddTrinket(select(1, GetItemInfo(65072)), {spells["Rageheart"], false, 20*5, 0, false})
		
		-- Heart of Solace
		spells["Heartened"] = GetSpellInfo(91363)
		AddTrinket(select(1, GetItemInfo(55868)), {spells["Heartened"], false, 20*5, 0, false})	
		
		-- Crushing Weight
		spells["Race Against Death"] = GetSpellInfo(92342)
		AddTrinket(select(1, GetItemInfo(59506)), {spells["Race Against Death"], false, 15*5, 0, false})
		
		-- Symbiotic Worm
		spells["Turn of the Worm"] = GetSpellInfo(92235)
		AddTrinket(select(1, GetItemInfo(59332)), {spells["Turn of the Worm"], false, 30, 0, false})
		
		-- Bedrock Talisman
		spells["Tectonic Shift"] = GetSpellInfo(92233)
		AddTrinket(select(1, GetItemInfo(58182)), {spells["Tectonic Shift"], false, 30, 0, false})
		
		-- Porcelain Crab
		spells["Hardened Shell"] = GetSpellInfo(92174)
		AddTrinket(select(1, GetItemInfo(56280)), {spells["Hardened Shell"], false, 20*5, 0, false})
		
		-- Right Eye of Rajh
		spells["Eye of Doom"] = GetSpellInfo(91368)
		AddTrinket(select(1, GetItemInfo(56431)), {spells["Eye of Doom"], false, 10*5, 0, false})
	
		if debugg then print("CLCDK:Trinkets Loaded")end
		return loaded
	end
	
	--In: timeleft - seconds
	--Out: formated string of hours, minutes and seconds
	local function formatTime(timeleft)
		if timeleft > 3600 then
			return format("%dh:%dm", timeleft/3600, ((timeleft%3600)/60))
		elseif timeleft > 600 then 
			return format("%dm", timeleft/60)
		elseif timeleft > 60 then 
			return format("%d:%2.2d", timeleft/60, timeleft%60)
		end	
		return timeleft
	end		
	
	--In: start- when the spell cd started  dur- duration of the cd
	--Out: returns if the spell is or will be off cd in the next GCD
	local function isOffCD(start, dur)
		return (dur + start - curtime - GCD <= 0)
	end
	
	--In:tabl - table to check if key is in it  key- key you are looking for
	--Out: returns true if key is in table
	local function inTable(tabl, key)
		for i = 1, #tabl do
			if tabl[i] == key then return true end
		end
		return false
	end
	
	local resize = nil
	--Sets up required information for each element that can be moved
	function CLCDK:SetupMoveFunction(frame)
		frame.Drag = CreateFrame("Button", "ResizeGrip", frame) -- Grip Buttons from Omen2
		frame.Drag:SetFrameLevel(frame:GetFrameLevel() + 100)
		frame.Drag:SetNormalTexture("Interface\\AddOns\\CLC_DK\\ResizeGrip")
		frame.Drag:SetHighlightTexture("Interface\\AddOns\\CLC_DK\\ResizeGrip")
		frame.Drag:SetWidth(26)
		frame.Drag:SetHeight(26)
		frame.Drag:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 7, -7)
		frame.Drag:EnableMouse(true)
		frame.Drag:Show()
		frame.Drag:SetScript("OnMouseDown", function(self,button) 
			if not CLCDK_Settings.Locked and button == "LeftButton" then		
				mousex, mousey = GetCursorPosition()
				resize = self:GetParent()
			end 
		end)
		
		frame.Drag:SetScript("OnMouseUp", function(self,button) 
			if not CLCDK_Settings.Locked and button == "LeftButton" then		
				self:StopMovingOrSizing()
				CLCDK_Settings.Location[(self:GetParent()):GetName()].Scale = (self:GetParent()):GetScale()
				resize, mousex, mousey = nil, nil, nil
			end 
		end)
	
		frame:EnableMouse(false)
		frame:SetMovable(true)
		
		--When mouse held, move
		frame:SetScript("OnMouseDown", function(self, button)
			if debugg then print("CLCDK:Mouse Down "..self:GetName())end
			CloseDropDownMenus()
		--	self.x1, self.y1 = select(4, self:GetPoint())
			self:StartMoving()
		--	self.x2, self.y2 = select(4, self:GetPoint())
		end)

		--When mouse released, save position
		frame:SetScript("OnMouseUp", function(self, button)			
			if debugg then print("CLCDK:Mouse Up "..self:GetName())end
		--	self.x3, self.y3 = select(4, self:GetPoint())
		--	print("Delta "..(self.x3-self.x2)+self.x1.." "..(self.y3-self.y2)+self.y1)
		--	CLCDK_Settings.Location[self:GetName()].X, CLCDK_Settings.Location[self:GetName()].Y = (self.x3-self.x2)+self.x1, (self.y3-self.y2)+self.y1
			self:StopMovingOrSizing()
			CLCDK_Settings.Location[self:GetName()].Point, CLCDK_Settings.Location[self:GetName()].Rel, CLCDK_Settings.Location[self:GetName()].RelPoint, CLCDK_Settings.Location[self:GetName()].X, CLCDK_Settings.Location[self:GetName()].Y = self:GetPoint()
		end)
	end

	--Icon template
	--In: name: the name of the icon frame   parent: the icons parent   spellname: the spell the icon will first display   size:height and width in pixels
	--Out: returns the icon create by parameters
	function CLCDK:CreateIcon(name, parent, spellname, size)
		frame = CreateFrame('Button', name, parent)
		frame:SetWidth(size)
		frame:SetHeight(size)
		frame:SetFrameStrata("BACKGROUND")
		frame.Spell = spellname
		frame.c = CreateFrame('Cooldown', nil, frame)
		frame.c:SetAllPoints(frame)
		frame.Icon = frame:CreateTexture("$parentIcon", "DIALOG")
		frame.Icon:SetAllPoints()
		frame.Icon:SetTexture(GetSpellTexture(spellname))
		frame.Time = frame:CreateFontString(nil, 'OVERLAY')
		frame.Time:SetPoint("CENTER",frame, 1, 0)
		frame.Time:SetJustifyH("CENTER")
		frame.Time:SetFont(font, 13, "OUTLINE")
		frame.Stack = frame:CreateFontString(nil, 'OVERLAY')
		frame.Stack:SetPoint("BOTTOMRIGHT",frame, 2, 1)
		frame.Stack:SetJustifyH("CENTER")
		frame.Stack:SetFont(font, 11, "OUTLINE")
		frame:EnableMouse(false)
		return frame
	end

	function CLCDK:CreateCDs()	
		CLCDK.CD = {}		
		
		--Create two frames in which 2 icons will placed in each
		for i = 1, 4 do  
			CLCDK.CD[i] = CreateFrame("Button", "CLCDK.CD"..i, CLCDK)
			CLCDK.CD[i]:SetWidth(34)
			CLCDK.CD[i]:SetHeight(68)
			CLCDK.CD[i]:SetFrameStrata("BACKGROUND")
			CLCDK.CD[i]:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = -1, right = -1, top = -1, bottom = -1},}
			CLCDK.CD[i]:SetBackdropColor(0, 0, 0, 0.5)	
			CLCDK:SetupMoveFunction(CLCDK.CD[i])
		end

		--List of CD frame names, using the name of dropdown menu to allow easy saving and fetching
		CDDisplayList = {	
			"CLCDK_CDRPanel_DD_CD1_One",
			"CLCDK_CDRPanel_DD_CD1_Two",
			"CLCDK_CDRPanel_DD_CD2_One",
			"CLCDK_CDRPanel_DD_CD2_Two",
			"CLCDK_CDRPanel_DD_CD3_One",
			"CLCDK_CDRPanel_DD_CD3_Two",
			"CLCDK_CDRPanel_DD_CD4_One",
			"CLCDK_CDRPanel_DD_CD4_Two",
		}
		
		--Create the Icons with desired paramaters
		for i = 1, #CDDisplayList do  
			CLCDK.CD[CDDisplayList[i]] = CLCDK:CreateIcon(CDDisplayList[i].."Butt", CLCDK, spells["Horn of Winter"], 32)	
			CLCDK.CD[CDDisplayList[i]].Time:SetFont(font, 11, "OUTLINE")
			CLCDK.CD[CDDisplayList[i]]:SetParent(CLCDK.CD[ceil(i/2)])
			CLCDK.CD[CDDisplayList[i]]:EnableMouse(false)
		end
		
		--Give Icons their position based on parent
		CLCDK.CD[CDDisplayList[1]]:SetPoint("TOPLEFT", CLCDK.CD[1], "TOPLEFT", 1, -1)
		CLCDK.CD[CDDisplayList[2]]:SetPoint("TOPLEFT", CLCDK.CD[CDDisplayList[1]], "BOTTOMLEFT", 0, -2)
		CLCDK.CD[CDDisplayList[3]]:SetPoint("TOPRIGHT", CLCDK.CD[2], "TOPRIGHT", -1, -1)
		CLCDK.CD[CDDisplayList[4]]:SetPoint("TOPLEFT", CLCDK.CD[CDDisplayList[3]], "BOTTOMLEFT", 0, -2)
		CLCDK.CD[CDDisplayList[5]]:SetPoint("TOPRIGHT", CLCDK.CD[3], "TOPRIGHT", -1, -1)
		CLCDK.CD[CDDisplayList[6]]:SetPoint("TOPLEFT", CLCDK.CD[CDDisplayList[5]], "BOTTOMLEFT", 0, -2)
		CLCDK.CD[CDDisplayList[7]]:SetPoint("TOPRIGHT", CLCDK.CD[4], "TOPRIGHT", -1, -1)
		CLCDK.CD[CDDisplayList[8]]:SetPoint("TOPLEFT", CLCDK.CD[CDDisplayList[7]], "BOTTOMLEFT", 0, -2)
		if debugg then print("CLCDK:Cooldowns Created")end
	end
	
	function CLCDK:CreateUI()
		CLCDK:SetupMoveFunction(CLCDK)
	
		--Create Rune bar frame
		CLCDK.RuneBar = CreateFrame("Button", "CLCDK.RuneBar", CLCDK)
		CLCDK.RuneBar:SetHeight(23)
		CLCDK.RuneBar:SetWidth(94)	
		CLCDK.RuneBar:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = 0, right = 0, top = 0, bottom = 0},}
		CLCDK.RuneBar:SetBackdropColor(0, 0, 0, 0.5)	
		CLCDK.RuneBar.Text = CLCDK.RuneBar:CreateFontString(nil, 'OVERLAY')
		CLCDK.RuneBar.Text:SetPoint("TOP", CLCDK.RuneBar, "TOP", 0, -2)
		CLCDK.RuneBar.Text:SetJustifyH("CENTER")
		CLCDK.RuneBar.Text:SetFont(font, 18, "OUTLINE")		
		CLCDK:SetupMoveFunction(CLCDK.RuneBar)
		
		--Create Runic Power frame
		CLCDK.RunicPower = CreateFrame("Button", "CLCDK.RunicPower", CLCDK)
		CLCDK.RunicPower:SetHeight(23)
		CLCDK.RunicPower:SetWidth(47)	
		CLCDK.RunicPower:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = 0, right = 0, top = 0, bottom = 0},}
		CLCDK.RunicPower:SetBackdropColor(0, 0, 0, 0.5)		
		CLCDK.RunicPower.Text = CLCDK.RunicPower:CreateFontString(nil, 'OVERLAY')
		CLCDK.RunicPower.Text:SetPoint("TOP", CLCDK.RunicPower, "TOP", 0, -2)
		CLCDK.RunicPower.Text:SetJustifyH("CENTER")
		CLCDK.RunicPower.Text:SetFont(font, 18, "OUTLINE")	
		CLCDK:SetupMoveFunction(CLCDK.RunicPower)
		
		--Create frome for Diseases with 2 icons for their respective disease
		CLCDK.Diseases = CreateFrame("Button", "CLCDK.Diseases", CLCDK)
		CLCDK.Diseases:SetHeight(24)
		CLCDK.Diseases:SetWidth(47)	
		CLCDK.Diseases:SetFrameStrata("BACKGROUND")
		CLCDK.Diseases:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = 0, right = 0, top = 0, bottom = 0},}
		CLCDK.Diseases:SetBackdropColor(0, 0, 0, 0.5)	
		CLCDK.Diseases.BP = CLCDK:CreateIcon("CLCDK.Diseases.BP", CLCDK.Diseases, spells["Blood Plague"], 21)
		CLCDK.Diseases.BP:SetParent(CLCDK.Diseases)
		CLCDK.Diseases.BP:SetPoint("TOPRIGHT", CLCDK.Diseases, "TOPRIGHT", -1, -1)
		CLCDK.Diseases.BP:SetBackdropColor(0, 0, 0, 0)
		CLCDK.Diseases.FF = CLCDK:CreateIcon("CLCDK.Diseases.FF", CLCDK.Diseases, spells["Frost Fever"], 21)
		CLCDK.Diseases.FF:SetParent(CLCDK.Diseases)
		CLCDK.Diseases.FF:SetPoint("RIGHT", CLCDK.Diseases.BP, "LEFT", -3, 0)
		CLCDK.Diseases.FF:SetBackdropColor(0, 0, 0, 0)
		CLCDK:SetupMoveFunction(CLCDK.Diseases)	
		
		--Create the Frame and Icon for the large main Priority Icon
		CLCDK.Move = CLCDK:CreateIcon('CLCDK.Move', CLCDK, spells["Death Coil"], 47)
		CLCDK.Move.Time:SetFont(font, 16, "OUTLINE")
		CLCDK.Move.Stack:SetFont(font, 15, "OUTLINE")
		CLCDK:SetupMoveFunction(CLCDK.Move)	
		
		--Create backdrop for move
		CLCDK.MoveBackdrop = CreateFrame('Frame', nil, CLCDK)
		CLCDK.MoveBackdrop:SetHeight(47)
		CLCDK.MoveBackdrop:SetWidth(47)
		CLCDK.MoveBackdrop:SetFrameStrata("BACKGROUND")
		CLCDK.MoveBackdrop:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = 0, right = 0, top = 0, bottom = 0},}
		CLCDK.MoveBackdrop:SetBackdropColor(0, 0, 0, 0.5)	
		CLCDK.MoveBackdrop:SetAllPoints(CLCDK.Move)		
		
		--Mini AOE icon to be placed in the Priority Icon
		CLCDK.Move.AOE = CLCDK:CreateIcon('CLCDK.AOE', CLCDK.Move, spells["Death Coil"], 18)
		CLCDK.Move.AOE:SetPoint("BOTTOMLEFT", CLCDK.Move, "BOTTOMLEFT", 2, 2)
		
		--Mini Interrupt icon to be placed in the Priority Icon
		CLCDK.Move.Interrupt = CLCDK:CreateIcon('CLCDK.Interrupt', CLCDK.Move, spells["Mind Freeze"], 18)
		CLCDK.Move.Interrupt:SetPoint("TOPRIGHT", CLCDK.Move, "TOPRIGHT", -2, -2)
		if debugg then print("CLCDK:UI Created")end
		
		CLCDK.DT = CreateFrame("Frame", "CLCDK.DT", UIPARENT)		
		CLCDK.DT:SetHeight(5*25)
		CLCDK.DT:SetWidth(180)
		CLCDK.DT:SetFrameStrata("BACKGROUND")	
		CLCDK.DT:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = 0, right = 0, top = 0, bottom = 0},}
		CLCDK.DT:SetBackdropColor(0, 0, 0, 0)
		CLCDK.DT:SetScale(0.7)
		CLCDK:SetupMoveFunction(CLCDK.DT)
		CLCDK.DT.Unit = {}
	end
	
	------Update Frames------	
	--In:location - name or location of the settings for specific CD   frame- frame in which to set the icon for
	--Out:: N/A (does not return but does set icon settings
	function CLCDK:UpdateCD(location, frame)
		--Reset Icon
		frame.Time:SetText("")
		frame.Stack:SetText("")		
		
		--If the option is not set to nothing
		if CLCDK_Settings.CD[Current_Spec][location] ~= nil and CLCDK_Settings.CD[Current_Spec][location][1] ~= nil and
			CLCDK_Settings.CD[Current_Spec][location][1] ~= CLCDK_OPTIONS_FRAME_VIEW_NONE then	
			frame:SetAlpha(1)
			frame.Icon:SetVertexColor(1, 1, 1, 1)			
			if CLCDK_Settings.CD[Current_Spec][location][1] == CLCDK_OPTIONS_CDR_CD_PRIORITY then --Priority
				--If targeting something that you can attack and is not dead
				if (UnitCanAttack("player", "target") and (not UnitIsDead("target"))) then
					--Get Icon from Priority Rotation
					frame.Icon:SetTexture(CLCDK:GetNextMove(frame.Icon))
				else
					frame.Icon:SetTexture(nil)
				end
			elseif CLCDK_Settings.CD[Current_Spec][location][1] == CLCDK_OPTIONS_CDR_CD_PRESENCE then --Presence
				frame.Icon:SetTexture(nil)			
				for i = 1, GetNumShapeshiftForms() do 
					local icon, _, active = GetShapeshiftFormInfo(i)
					if active then frame.Icon:SetTexture(icon) end
				end	
			elseif CLCDK_Settings.CD[Current_Spec][location][IS_BUFF] then --Buff/DeBuff			
				local icon, count, dur, expirationTime					

				if CLCDK_Settings.CD[Current_Spec][location][1] == spells["Dark Simulacrum"] then
					local id
					if (curtime - simtime) >= 5 then
						simtime = curtime
						for i = 1, 120 do
							_, id = GetActionInfo(i)
							if id == 77606 then	darksim[1] = i;	darksim[2] = 0;	if debugg then print("CLCDK:Dark Simulacrum Action Slot "..i)end; break; end
						end
					end
					_, id = GetActionInfo(darksim[1])
					if id ~= nil and id ~= 77606 then
						if CLCDK_Settings.Range and IsSpellInRange(GetSpellInfo(id), "target") == 0 then frame.Icon:SetVertexColor(0.8, 0.05, 0.05, 1) end							
						frame.Icon:SetTexture(GetSpellTexture(id))
						if darksim[2] == 0 or darksim[2] < curtime then	darksim[2] = curtime + 20 end	
						frame.Time:SetText(floor(darksim[2] - curtime))							
						return							
					end
				end
				
				--if its on a target then its a debuff, otherwise its a buff
				if Cooldowns.Buffs[CLCDK_Settings.CD[Current_Spec][location][1]][1] == "target" then
					_, _, icon, count, _, dur, expirationTime = UnitDebuff("target", CLCDK_Settings.CD[Current_Spec][location][1])
				else
					_, _, icon, count, _, dur, expirationTime = UnitBuff(Cooldowns.Buffs[CLCDK_Settings.CD[Current_Spec][location][1]][1], CLCDK_Settings.CD[Current_Spec][location][1])
				end	
				frame.Icon:SetTexture(icon)
				
				--If not an aura, set time
				if icon ~= nil and ceil(expirationTime - curtime) > 0 then				
					frame.Icon:SetVertexColor(0.5, 0.5, 0.5, 1)
					frame.Time:SetText(formatTime(ceil(expirationTime - curtime)))
					if count > 1 then frame.Stack:SetText(count) end	
				end
			elseif inTable(Cooldowns.Moves, CLCDK_Settings.CD[Current_Spec][location][1]) then --Move
				icon = GetSpellTexture(CLCDK_Settings.CD[Current_Spec][location][1])
				if icon ~= nil then
					--Check if move is off CD
					start, dur =  GetSpellCooldown(CLCDK_Settings.CD[Current_Spec][location][1])
					if isOffCD(start, dur) and IsUsableSpell(CLCDK_Settings.CD[Current_Spec][location][1]) then
						icon = CLCDK:GetRangeandIcon(frame.Icon, CLCDK_Settings.CD[Current_Spec][location][1])
					else
						icon = nil
					end	
				end		
				frame.Icon:SetTexture(icon)
			elseif CLCDK_Settings.CD[Current_Spec][location][1] == CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1 or
				CLCDK_Settings.CD[Current_Spec][location][1] == CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT2 then --Trinkets
				
				local id
				if CLCDK_Settings.CD[Current_Spec][location][1] == CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1 then
					id = GetInventoryItemID("player", 13)
				else
					id = GetInventoryItemID("player", 14)
				end
				local trink = Cooldowns.Trinkets[select(1,GetItemInfo(id))]
			
				if trink ~= nil then
					local altbuff = false
				
					--Buff
					_, _, icon, count, _, dur, expirationTime = UnitBuff("player",trink[1])						
					if icon == nil and trink[6] ~= nil then
						_, _, icon, count, _, dur, expirationTime = UnitBuff("player",trink[6])	
						altbuff = true
					end	
					if icon ~= nil then
						frame.Icon:SetTexture(icon)
						frame.Icon:SetVertexColor(0.5, 0.5, 0.5, 1)
						frame.Time:SetText(formatTime(ceil(expirationTime - curtime)))
						if count > 1 then frame.Stack:SetText(count) end	
						if (not altbuff) and (not trink[5]) then trink[5] = true; trink[4] = curtime end					
						
					--ICD or Use CD					
					else 
						local start, dur, active
						frame.Icon:SetTexture(GetItemIcon(id))
						if trink[2] then --On-Use
							start, dur, active = GetItemCooldown(trink[3])					
						else --ICD
							trink[5] = false
							dur, start = trink[3], trink[4]
							active = 1
						end
						t = ceil(start + dur - curtime)
						if t > 0 and active == 1 and dur > 7 then
							frame.Icon:SetVertexColor(0.5, 0.5, 0.5, 1)
							if CLCDK_Settings.CDS then frame.c:SetCooldown(start, dur) end	
							frame.Time:SetText(formatTime(t))
						end
					end
				else
					frame.Icon:SetTexture(nil)
				end
			elseif  CLCDK_Settings.CD[Current_Spec][location][1] == CLCDK_OPTIONS_CDR_RACIAL then
				icon = CLCDK:GetRangeandIcon(frame.Icon, spells[PLAYER_RACE])
				frame.Icon:SetTexture(icon)
				if icon ~= nil then
					start, dur, active =  GetSpellCooldown(spells[PLAYER_RACE])
					t = ceil(start + dur - curtime)
					if active == 1 and dur > 7 then
						frame.Icon:SetVertexColor(0.5, 0.5, 0.5, 1)
						if CLCDK_Settings.CDS then frame.c:SetCooldown(start, dur) end	
						frame.Time:SetText(formatTime(t))
					end	
				end				
				
			else --Cooldown				
				icon = CLCDK:GetRangeandIcon(frame.Icon, CLCDK_Settings.CD[Current_Spec][location][1])
				frame.Icon:SetTexture(icon)
				if icon ~= nil then
					start, dur, active =  GetSpellCooldown(CLCDK_Settings.CD[Current_Spec][location][1])
					t = ceil(start + dur - curtime)
					if active == 1 and dur > 7 then
						frame.Icon:SetVertexColor(0.5, 0.5, 0.5, 1)
						if CLCDK_Settings.CDS then frame.c:SetCooldown(start, dur) end	
						frame.Time:SetText(formatTime(t))
					end	
				end				
			end
			--if the icon is nil, then just hide the frame
			if frame.Icon:GetTexture() == nil then
				frame:SetAlpha(0)
			end
		else	
			CLCDK_Settings.CD[Current_Spec][location][1] = CLCDK_OPTIONS_FRAME_VIEW_NONE
			frame:SetAlpha(0)
		end	
	end
	
	--Used to move individual frames where they are suppose to be displayed, also enables and disables mouse depending on settings
	function CLCDK:MoveFrame(self)
		self:ClearAllPoints()
		self:SetPoint(CLCDK_Settings.Location[self:GetName()].Point, CLCDK_Settings.Location[self:GetName()].Rel, CLCDK_Settings.Location[self:GetName()].RelPoint, CLCDK_Settings.Location[self:GetName()].X, CLCDK_Settings.Location[self:GetName()].Y)
		self:SetBackdropColor(0, 0, 0, CLCDK_Settings.Trans)
		self:EnableMouse((not CLCDK_Settings.Locked) and ((not CLCDK_Settings.LockedPieces) or (CLCDK_Settings.Location[self:GetName()].Rel == nil)))
		if CLCDK_Settings.Locked then self.Drag:SetAlpha(0) 
		else self.Drag:SetAlpha(1) end
		
		if CLCDK_Settings.Location[self:GetName()].Scale ~= nil then
			self:SetScale(CLCDK_Settings.Location[self:GetName()].Scale)
		else
			CLCDK_Settings.Location[self:GetName()].Scale = 1
		end
	end
	
	--Called to update all the frames positions and scales
	function CLCDK:UpdatePosition()
		CLCDK:MoveFrame(CLCDK)
		CLCDK:MoveFrame(CLCDK.CD[1])
		CLCDK:MoveFrame(CLCDK.CD[2])
		CLCDK:MoveFrame(CLCDK.CD[3])
		CLCDK:MoveFrame(CLCDK.CD[4])
		CLCDK:MoveFrame(CLCDK.DT)
		CLCDK:MoveFrame(CLCDK.RuneBar)
		CLCDK:MoveFrame(CLCDK.RunicPower)
		CLCDK:MoveFrame(CLCDK.Move)
		CLCDK.MoveBackdrop:SetBackdropColor(0, 0, 0, CLCDK_Settings.Trans)
		CLCDK:MoveFrame(CLCDK.Diseases)		
		
		CLCDK.DT:SetHeight(CLCDK_Settings.DT.Numframes*25)
		if CLCDK_Settings.Locked then
			CLCDK.DT:SetBackdropColor(0, 0, 0, 0)
			CLCDK.DT:EnableMouse(false)
		else
			CLCDK.DT:SetBackdropColor(0, 0, 0, 0.35)
			CLCDK.DT:EnableMouse(true)
		end
		
		CLCDK:SetScale(CLCDK_Settings.Scale)
		if debugg then print("CLCDK:UpdatePosition")end
	end

	--Main function for updating all information
	function CLCDK:UpdateUI()	
		if (UnitCanAttack("player", "target") and (not UnitIsDead("target"))) then
			CLCDK:SetAlpha(1)			
		else
			CLCDK:SetAlpha(CLCDK_Settings.CombatTrans)
		end
		
		--GCD		
		local start, dur = GetSpellCooldown(spells["Death Coil"])
		if dur ~= 0 and start ~= nil then 
			GCD =  dur - (curtime - start)
			if CLCDK_Settings.GCD then			
				CLCDK.Move.c:SetCooldown(start, dur)			
			end				
		else 
			GCD = 0
		end	

		--Runes
		if CLCDK_Settings.Rune then
			CLCDK.RuneBar:SetAlpha(1)	
			local RuneBar = ""
			
			local function runetext(i)
				local start, cooldown = GetRuneCooldown(i)
				local r, g, b = unpack(RUNE_COLOUR[GetRuneType(i)])
				local cdtime = (math.ceil(start + cooldown - curtime))	
				if cdtime >= cooldown or cdtime >= 10 then
					cdtime = "X"
				elseif cdtime <= 0 then				
					cdtime = "*"
				end       
				return string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, cdtime)
			end 
			
			local b1, b2, u1, u2, f1, f2 = runetext(1), runetext(2), runetext(3), runetext(4), runetext(5), runetext(6)
			
			if CLCDK_Settings.RuneOrder == BBUUFF then
				RuneBar = b1..b2..u1..u2..f1..f2
			elseif CLCDK_Settings.RuneOrder == BBFFUU then
				RuneBar = b1..b2..f1..f2..u1..u2
			elseif CLCDK_Settings.RuneOrder == UUBBFF then
				RuneBar = u1..u2..b1..b2..f1..f2
			elseif CLCDK_Settings.RuneOrder == UUFFBB then
				RuneBar = u1..u2..f1..f2..b1..b2
			elseif CLCDK_Settings.RuneOrder == FFUUBB then
				RuneBar = f1..f2..u1..u2..b1..b2
			elseif CLCDK_Settings.RuneOrder == FFBBUU then
				RuneBar = f1..f2..b1..b2..u1..u2
			end
						
			CLCDK.RuneBar.Text:SetText(RuneBar) 	
		else
			CLCDK.RuneBar:SetAlpha(0)	
		end

		--RunicPower
		if CLCDK_Settings.RP then
			CLCDK.RunicPower:SetAlpha(1)	
			r, g, b = unpack(RUNE_COLOUR[3])	
			CLCDK.RunicPower.Text:SetText(string.format("|cff%02x%02x%02x%.3d|r",r*255, g*255, b*255, UnitPower("player")))	
		else
			CLCDK.RunicPower:SetAlpha(0)	
		end	

		--Diseases
		if CLCDK_Settings.Disease then			
			CLCDK.Diseases:SetAlpha(1)
			CLCDK.Diseases.FF.Icon:SetVertexColor(1, 1, 1, 1)
			CLCDK.Diseases.BP.Icon:SetVertexColor(1, 1, 1, 1)		
			CLCDK.Diseases.FF.Time:SetText("")
			CLCDK.Diseases.BP.Time:SetText("")		
			if UnitCanAttack("player", "target") and (not UnitIsDead("target")) then							
				local expires = select(7,UnitDebuff("TARGET", spells["Frost Fever"], nil, "PLAYER"))
				if  expires ~= nil and (expires - curtime) > 0 then
					CLCDK.Diseases.FF.Icon:SetVertexColor(.5, .5, .5, 1)
					CLCDK.Diseases.FF.Time:SetText(string.format("|cffffffff%.2d|r", expires - curtime))	
				end
				
				expires = select(7,UnitDebuff("TARGET", spells["Blood Plague"], nil, "PLAYER"))
				if expires ~= nil and (expires - curtime) > 0 then
					CLCDK.Diseases.BP.Icon:SetVertexColor(.5, .5, .5, 1)
					CLCDK.Diseases.BP.Time:SetText(string.format("|cffffffff%.2d|r", expires - curtime))
				end		
			end	
		else
			CLCDK.Diseases:SetAlpha(0)				
		end
		
		--Priority Icon
		CLCDK.Move.AOE:SetAlpha(0)
		CLCDK.Move.Interrupt:SetAlpha(0)
		if CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][1] ~= CLCDK_OPTIONS_FRAME_VIEW_NONE then
			CLCDK.Move:SetAlpha(1)
			CLCDK.MoveBackdrop:SetAlpha(1)
			CLCDK:UpdateCD("CLCDK_CDRPanel_DD_Priority", CLCDK.Move)
			
			--If Prioirty on Main Icon
			if CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][1] == CLCDK_OPTIONS_CDR_CD_PRIORITY then
				if CLCDK_Settings.MoveAltInterrupt then --Show Interrupt
					local spell, notint = select(1, UnitCastingInfo("target")), select(9, UnitCastingInfo("target"))
					if spell == nil then spell, notint = select(1, UnitChannelInfo("target")), select(8, UnitChannelInfo("target")) end
					if spell ~= nil and not notint then 
						start, dur =  GetSpellCooldown(spells["Mind Freeze"])
						if (isOffCD (start, dur)) and (UnitPower("player") >= (20 - (10*select(5, GetTalentInfo(2, 7))))) then								
							CLCDK.Move.Interrupt:SetAlpha(1)	
						end
					end		
				end
			end			
		else
			CLCDK.Move:SetAlpha(0)
			CLCDK.MoveBackdrop:SetAlpha(0)
		end	
		
		--CDs		
		for i = 1, #CDDisplayList do
			if CLCDK_Settings.CD[Current_Spec][ceil(i/2)] then
				CLCDK.CD[ceil(i/2)]:SetAlpha(1)	
				CLCDK:UpdateCD(CDDisplayList[i], CLCDK.CD[CDDisplayList[i]])			
			else
				CLCDK.CD[ceil(i/2)]:SetAlpha(0)	
			end
		end
		
		--GCD
		if CLCDK_Settings.GCD then
			local start, dur = GetSpellCooldown(spells["Death Coil"])
			if dur ~= 0 and start ~= nil then			
				CLCDK.Move.c:SetCooldown(start, dur)		
			end
		end
		
		--Prints out Buffs: Used for new buffs that ID is not known
		-- for i = 1, 40 do
			-- if select(1, UnitBuff("player", i)) ~= nil then
				-- print(select(1, UnitBuff("player", i)).." "..select(11, UnitBuff("player", i)))
			-- end
		-- end
	end
		
	do --Disease Tracker
		--Create a DT Frame
		function CLCDK:DTCreateFrame()
			frame = CreateFrame('StatusBar', nil, CLCDK.DT)
			frame:SetHeight(24)
			frame:SetWidth(CLCDK.DT:GetWidth()-2)
			frame:SetStatusBarTexture([[Interface\Tooltips\UI-Tooltip-Background]])
			frame:SetStatusBarColor(1, 0, 0); 		
			frame:SetBackdrop{bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background', tile = false, insets = {left = -1, right = -1, top = -1, bottom = -1},}
			frame:SetBackdropColor(0, 0, 0, 0.5)	
			
			frame.Name = frame:CreateFontString(nil, 'OVERLAY')
			frame.Name:SetPoint("LEFT", frame, 3, 0)
			frame.Name:SetFont(CLCDK_NAMEFONT, 13, "OUTLINE")
			return frame
		end
		
		--Gather the info and apply them to it's frame
		function CLCDK:DTUpdateInfo(guid, info)
			if (not CLCDK_Settings.DT.Target) and UnitGUID("target") == guid then return end
			
			--Create Frame
			if info.Frame == nil then info.Frame = CLCDK:DTCreateFrame() end			
			info.Frame:SetAlpha(1)
			
			--Set Settings			
			if info.spot == nil or info.spot ~= CLCDK.DT.spot then
				info.spot = CLCDK.DT.spot	
				info.Frame:ClearAllPoints()
				if CLCDK_Settings.DT.GrowDown then info.Frame:SetPoint("TOP", 0, -(CLCDK.DT.spot*27)-1)	
				else info.Frame:SetPoint("BOTTOM", 0, (CLCDK.DT.spot*27)+1) end
			end
			
			--Change Colour
			if CLCDK_Settings.DT.TColours then
				if (UnitGUID("target") == guid) then info.Frame:SetBackdropColor(0.1, 0.75, 0.1, 0.9)
				elseif (UnitGUID("focus") == guid) then info.Frame:SetBackdropColor(0.2, 0.2, 0.75, 0.9)
				else info.Frame:SetBackdropColor(0, 0, 0, 0.5) end
			end
			
			--Threat
			info.Frame:SetMinMaxValues(CLCDK_Settings.DT.Threat, 100)
			if CLCDK_Settings.DT.Threat ~= THREAT_OFF and info.Threat ~= nil then info.Frame:SetValue(info.Threat) 
			else info.Frame:SetValue(0)	end			
			
			--Name
			local name = info.Name
			local color 
			if CLCDK_Settings.DT.CColours then color = RAID_CLASS_COLORS[select(2, GetPlayerInfoByGUID(guid))] end
			if color == nil then color = {}; color.r, color.g, color.b = 1, 1, 1; end		
			name = (string.len(name) > 9 and string.gsub(name, '%s?(.)%S+%s', '%1. ') or name)	
			info.Frame.Name:SetText(string.format("|cff%02x%02x%02x%.9s|r", color.r*255, color.g*255, color.b*255, name))

			--Dots
			if info.Frame.Icons == nil or info.OldDots ~= info.NumDots then
				local count = 0
				local texture
				if info.Frame.Icons ~= nil then
					for j, v in pairs(info.Frame.Icons) do
						info.Frame.Icons[j]:SetAlpha(0)
					end
					info.Frame.Icons = nil					
				end	
				info.Frame.Icons = {}
				info.OldDots = info.NumDots
				for j, v in pairs(info.Spells) do
					info.Frame.Icons[j] = CLCDK:CreateIcon("CLCDK.DT."..j, info.Frame, j, 20)
					info.Frame.Icons[j].Time:SetFont(font, 11, "OUTLINE")
					info.Frame.Icons[j]:SetPoint("RIGHT", -(count*22)-1, 0)
					info.Frame.Icons[j].Icon:SetTexture(GetSpellTexture(DTspells[j][1]))
					count = count + 1
				end	
			end
			
			--Update Dots
			if info.Frame.Icons ~= nil and next(info.Spells) ~= nil then				
				for j, v in pairs(info.Spells) do
					if v ~= nil and info.Frame.Icons[j]~= nil then
						t = floor(v - curtime)
						if t >= 0 then
							info.Frame.Icons[j]:SetAlpha(1)
							info.Frame.Icons[j].Icon:SetVertexColor(0.5, 0.5, 0.5, 1)
							if t > CLCDK_Settings.DT.Warning then info.Frame.Icons[j].Time:SetText(formatTime(t))
							else info.Frame.Icons[j].Time:SetText(format("|cffff2222%s|r",formatTime(t))) end
						else
							info.NumDots = info.NumDots - 1
							info.Frame.Icons[j]:SetAlpha(0)
							info.Spells[j] = nil					
						end	
					else
						info.NumDots = info.NumDots - 1
						if info.Frame.Icons[j]~= nil then info.Frame.Icons[j]:SetAlpha(0) end
						info.Spells[j] = nil
					end
				end
			else
				return
			end
			
			info.Updated = true
			CLCDK.DT.spot = CLCDK.DT.spot + 1
		end

		--Update the frames
		function CLCDK:DTUpdateFrames()		
			local function updateGUIDFrame(guid)
				if CLCDK.DT.Unit[guid] ~= nil then
					CLCDK.DT.Unit[guid].Updated = false
					if CLCDK.DT.spot < CLCDK_Settings.DT.Numframes then CLCDK:DTUpdateInfo(guid, CLCDK.DT.Unit[guid]) end				
					if CLCDK.DT.Unit[guid].Updated == false and CLCDK.DT.Unit[guid]~= nil and CLCDK.DT.Unit[guid].Frame ~= nil then
						CLCDK.DT.Unit[guid].Frame:SetAlpha(0)
						if next(CLCDK.DT.Unit[guid].Spells) == nil then CLCDK.DT.Unit[guid] = nil end
					end	
				end
			end
			
			CLCDK.DT.spot = 0
			
			local targetguid, focusguid
			
			if CLCDK_Settings.DT.TPriority then
				targetguid, focusguid = UnitGUID("target"), UnitGUID("focus")
				updateGUIDFrame(targetguid)	
				if targetguid ~= focusguid then updateGUIDFrame(focusguid) end	
			end
			
			for k, v in pairs(CLCDK.DT.Unit) do
				if k ~= targetguid and k ~= focusguid then updateGUIDFrame(k) end	
			end	
		end		
		
		--Update Threat and Dots from checking target infoz
		local updatedGUIDs = {}
		function CLCDK:DTCheckTargets()
			local function updateGUIDInfo(unit)
				local guid = UnitGUID(unit) 
				if guid ~= nil and updatedGUIDs[guid] == nil then					
					if UnitIsDead(unit) and CLCDK.DT.Unit[guid] ~= nil and CLCDK.DT.Unit[guid].Frame ~= nil then  
						CLCDK.DT.Unit[guid].Frame:SetAlpha(0)
						CLCDK.DT.Unit[guid].Frame = nil
						CLCDK.DT.Unit[guid] = nil 
					end
					
					if select(1, UnitDebuff(unit, 1, "PLAYER")) ~= nil then
						local name, expt
						for j= 1, 10 do						
							name, _, _, _, _, _, expt = UnitDebuff(unit, j, "PLAYER")
							if name == nil then break end						
							if CLCDK_Settings.DT.Dots[name] then
								if CLCDK.DT.Unit[guid] == nil then 
									local targetName = UnitName(unit)
									CLCDK.DT.Unit[guid] = {}
									CLCDK.DT.Unit[guid].Spells = {}
									CLCDK.DT.Unit[guid].NumDots = 0
									CLCDK.DT.Unit[guid].Name = select(3, string.find(targetName, "(.-)-")) or targetName					
								end	
								
								updatedGUIDs[guid] = true
								
								if CLCDK.DT.Unit[guid].Spells[name] == nil then
									CLCDK.DT.Unit[guid].NumDots = CLCDK.DT.Unit[guid].NumDots + 1
								end						
								if name == spells["Death and Decay"] then
									CLCDK.DT.Unit[guid].Spells[name] = select(1, GetSpellCooldown(name)) + 10 + DND_Glyph
								else
									CLCDK.DT.Unit[guid].Spells[name] = expt
								end
								
								if CLCDK_Settings.DT.Threat ~= THREAT_OFF then
									CLCDK.DT.Unit[guid].Threat = select(3, UnitDetailedThreatSituation("player", unit))
								end
							end
						end
					end	
				end
			end
			
			updatedGUIDs = {}
			updateGUIDInfo("target")
			updateGUIDInfo("focus")
			updateGUIDInfo("pettarget")
			for i = 1, MAX_BOSS_FRAMES do updateGUIDInfo("boss"..i)	end
			for i = 1, (GetNumRaidMembers() + 1) do	updateGUIDInfo("raid"..i.."target")	end
		end
	end
	
	do-----Priority System-----
		--Called to update a priority icon with next move
		function CLCDK:GetNextMove(icon)	
			--Call correct function based on spec
			if (Current_Spec == SPEC_UNHOLY) then
				if CLCDK_Settings.MoveAltAOE then CLCDK.Move.AOE:SetAlpha(1); CLCDK.Move.AOE.Icon:SetTexture(CLCDK:UnholyAOEMove(CLCDK.Move.AOE.Icon)) end
				return CLCDK:UnholyMove(icon)
			elseif (Current_Spec == SPEC_FROST) then
				if CLCDK_Settings.MoveAltAOE then CLCDK.Move.AOE:SetAlpha(1); CLCDK.Move.AOE.Icon:SetTexture(CLCDK:FrostAOEMove(CLCDK.Move.AOE.Icon)) end
				return CLCDK:FrostMove(icon)
			elseif (Current_Spec == SPEC_BLOOD) then
				if CLCDK_Settings.MoveAltAOE then CLCDK.Move.AOE:SetAlpha(1); CLCDK.Move.AOE.Icon:SetTexture(CLCDK:BloodAOEMove(CLCDK.Move.AOE.Icon)) end
				return CLCDK:BloodMove(icon)
			else
				return CLCDK:BlankMove(icon)
			end
		end

		--Determines if player is in range with spell and sets colour and icon accordingly
		--In: icon: icon in which to change the vertex colour of   move: spellID of spell to be cast next
		--Out: returns the texture of the icon (probably unessesary since icon is now being passed in, will look into it more)
		function CLCDK:GetRangeandIcon(icon, move)
			if move ~= nil then
				if CLCDK_Settings.Range and IsSpellInRange(move, "target") == 0 then
					icon:SetVertexColor(0.8, 0.05, 0.05, 1) 
				else
					icon:SetVertexColor(1, 1, 1, 1)
				end
				return GetSpellTexture(move)
			end
			return nil
		end

		--Gives CD of rune type specified
		--In: r : type of rune set to be queried
		--Out:  time1: the lowest cd of the 2 runes being queried  time2: the higher of the cds  RT1: returns true if lowest cd rune is a death rune, RT2: same as RT2 except higher CD rune
		function CLCDK:RuneCDs(r)
			--Get individual rune numbers
			local a, b		
			if r == SPEC_UNHOLY then a, b = 3, 4
			elseif r == SPEC_FROST then a, b = 5, 6
			elseif r == SPEC_BLOOD then a, b = 1, 2
			end
			
			--Set a max time incase nil is returned
			local time1, time2 = 20, 20
			
			--Get CD of first rune
			local start, dur, cool = GetRuneCooldown(a)		
			time1 = (cool and 0) or (dur - (curtime - start + GCD))			
			
			--Get CD of second rune
			local start, dur, cool = GetRuneCooldown(b)
			time2 = (cool and 0) or (dur - (curtime - start + GCD))
				
			--if seconf rune will be off CD before first, then return second then first rune, else vice versa
			if time1 > time2 then
				return time2, time1, GetRuneType(b) == 4, GetRuneType(a) == 4
			else
				return time1, time2, GetRuneType(a) == 4, GetRuneType(b) == 4
			end
		end	

		--Returns the total number of Death runes off CD
		function CLCDK:DeathRunes()	
			local count = 0
			local start, dur, cool
			for i = 1, 6 do	
				if GetRuneType(i) == 4 then
					start, dur, cool = GetRuneCooldown(i)
					if (cool or isOffCD(start, dur)) then
						count = count + 1
					end	
				end
			end
			return count
		end
		
		--Returns if move is off cooldown or not
		function CLCDK:QuickAOESpellCheck(move)	
			if CLCDK_Settings.MoveAltAOE and GetSpellTexture(move) ~= nil then
				local start, dur =  GetSpellCooldown(move)
				if (isOffCD (start, dur)) then
					return true
				end
			end
			return false
		end

		--Determines if Dieseases need to be refreshed or applied
		function CLCDK:GetDisease(icon)
			--If settings not to worry about diseases, then break
			if CLCDK_Settings.CD[Current_Spec].DiseaseOption == DISEASE_NONE then return false end
		
			--Get Duration left on diseases
			local FFexpires, BPexpires	
			local expires = select(7,UnitDebuff("TARGET", spells["Frost Fever"], nil, "PLAYER"))
			if  expires ~= nil then	FFexpires = expires - curtime end		
			expires = select(7,UnitDebuff("TARGET", spells["Blood Plague"], nil, "PLAYER"))
			if expires ~= nil then BPexpires = expires - curtime end			
				
			--Check if Outbreak is off CD, is known and Player wants to use it in rotation	
			local start, dur =  GetSpellCooldown(spells["Outbreak"])
			local outbreak = CLCDK_Settings.CD[Current_Spec].Outbreak and IsSpellKnown(77575) and isOffCD(start, dur)
			
			-- Apply Frost Fever		
			if (FFexpires == nil or FFexpires < 2) then	
			
				-- Add Death Grip as first priority until IT is in range
				if CLCDK_Settings.DG and (IsSpellInRange(spells["Icy Touch"], "target")) == 0 and IsUsableSpell(spells["Death Grip"]) then
					return true, (CLCDK:GetRangeandIcon(icon, spells["Death Grip"]))
				end 
			
				if outbreak then --if can use outbreak, then do it
					return true, CLCDK:GetRangeandIcon(icon, spells["Outbreak"])
				elseif ((CLCDK:RuneCDs(SPEC_FROST) <= 0) or CLCDK:DeathRunes() >= 1) then --if rune is availible, then do Icy touch or howling blast (depending on spec)
					return true, (Current_Spec == SPEC_FROST and CLCDK_Settings.CD[Current_Spec].SpecOption and HB_Glyph and GetSpellTexture(spells["Howling Blast"])~=nil and CLCDK:GetRangeandIcon(icon, spells["Howling Blast"])) 
						or CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])
				end
			end

			--Apply Blood Plague
			if (CLCDK_Settings.CD[Current_Spec].DiseaseOption ~= DISEASE_ONE or outbreak) then
				if (BPexpires == nil or BPexpires < 2) then
					if outbreak then --if can use outbreak, then do it
						return true, CLCDK:GetRangeandIcon(icon, spells["Outbreak"])
					elseif ((CLCDK:RuneCDs(SPEC_UNHOLY) <= 0) or CLCDK:DeathRunes() >= 1) then --if rune availible, then use Plague Strike
						return true, CLCDK:GetRangeandIcon(icon, spells["Plague Strike"])
					end
				end	
			end
			return false
		end

		--Function to determine rotation for Unholy Spec
		function CLCDK:UnholyMove(icon)			
			--Diseases > Dark Transformation > SS if both Unholy and/or all Death runes are up > FeS if both pairs of Blood and Frost runes are up >
			--DC if SD, 100 RP, will overcap RP with anything else or if RC isn’t up > SS > FeS > DC > HoW.	
				
			--Diseases		
			local disease, move = CLCDK:GetDisease(icon)	
			if disease then	return move	end		
			
			--Rune Info
			local frost, lfrost, fd, lfd = CLCDK:RuneCDs(SPEC_FROST)
			local unholy, lunholy = CLCDK:RuneCDs(SPEC_UNHOLY)
			local blood, lblood, bd, lbd = CLCDK:RuneCDs(SPEC_BLOOD)
			local death = CLCDK:DeathRunes()

			--Dark Transformation
			if GetSpellTexture(spells["Dark Transformation"])~=nil and CLCDK_Settings.CD[Current_Spec].SpecOption then
				if select(4, UnitBuff("PET",spells["Shadow Infusion"])) == 5 and ((unholy <= 0) or (death >= 1)) then
					return CLCDK:GetRangeandIcon(icon, spells["Dark Transformation"])
				end
			end
			
			--Scourge Strike		
			if (lunholy <= 0) or (lfrost <= 0 and (lfd or (frost <= 0 and fd))) or (lblood <= 0 and (lbd or (blood <= 0 and bd))) then				
				if CLCDK_Settings.MoveAltDND then
					--Death and Decay
					if GetSpellTexture(spells["Death and Decay"]) ~= nil then
						start, dur =  GetSpellCooldown(spells["Death and Decay"])
						if (isOffCD (start, dur)) then
							CLCDK.Move.AOE:SetAlpha(1)
							CLCDK.Move.AOE.Icon:SetTexture(GetSpellTexture(spells["Death and Decay"]))                              
						end
					end
				end
				return CLCDK:GetRangeandIcon(icon, spells["Scourge Strike"])				
			end	
			
			--Festering Strike
			if GetSpellTexture(spells["Festering Strike"])~=nil then
				if (lfrost <= 0) and (lblood <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Festering Strike"])
				end	
			else
				--Blood Strike 		
				if (lblood <=0) then
					return CLCDK:GetRangeandIcon(icon, spells["Blood Strike"])
				end
				
				--Icy Touch
				if (lfrost <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])
				end
			end
			
			-- Death Coil
			if CLCDK_Settings.CD[Current_Spec].RP and 
				((UnitPower("player") >= (40 - DC_Reduce + PoolInterrupt)) or (select(7, UnitBuff("PLAYER",spells["Sudden Doom"]))~= nil)) then
				return CLCDK:GetRangeandIcon(icon, spells["Death Coil"])
			end	
			
			--Scourge Strike
			if (unholy <= 0) or (death >= 1) then
				if CLCDK_Settings.MoveAltDND then
					--Death and Decay
					if GetSpellTexture(spells["Death and Decay"]) ~= nil then
						start, dur =  GetSpellCooldown(spells["Death and Decay"])
						if (isOffCD (start, dur)) then
							CLCDK.Move.AOE:SetAlpha(1)
							CLCDK.Move.AOE.Icon:SetTexture(GetSpellTexture(spells["Death and Decay"]))                              
						end
					end
				end
				return CLCDK:GetRangeandIcon(icon, spells["Scourge Strike"])
			end	
			
			--Festering Strike
			if GetSpellTexture(spells["Festering Strike"])~=nil then
				if (frost <= 0) and (blood <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Festering Strike"])
				end	
			else
				--Blood Strike 		
				if (blood <=0) then
					return CLCDK:GetRangeandIcon(icon, spells["Blood Strike"])
				end
				
				--Icy Touch
				if (frost <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])
				end
			end	
			
			--Horn
			if CLCDK_Settings.CD[Current_Spec].Horn and GetSpellTexture(spells["Horn of Winter"])~=nil then		
				start, dur =  GetSpellCooldown(spells["Horn of Winter"])
				if (isOffCD (start, dur)) then
					return CLCDK:GetRangeandIcon(icon, spells["Horn of Winter"])
				end	
			end	
			
			-- If nothing else can be done
			return nil				
		end
		
		--Function to determine rotation for Frost Spec
		function CLCDK:FrostMove(icon)			
			--Diseases > Ob if both Frost/Unholy pairs and/or both Death runes are up, or if KM is procced >
			--BS if both Blood Runes are up > FS if RP capped > Rime > Ob > BS > FS > HoW. 
			
			--Diseases
			local disease, move = CLCDK:GetDisease(icon)	
			if disease then	return move	end	
			
			--Rune Info
			local frost, lfrost, fd = CLCDK:RuneCDs(SPEC_FROST)
			local unholy, lunholy, ud = CLCDK:RuneCDs(SPEC_UNHOLY)
			local blood, lblood, bd, lbd = CLCDK:RuneCDs(SPEC_BLOOD)
			local death = CLCDK:DeathRunes()	
			
			--Obliterate
			if GetSpellTexture(spells["Obliterate"])~=nil then				
				if ((lfrost <= 0) and (lunholy <= 0)) or (blood<=0 and lblood <= 0 and bd and lbd) or
					((((frost <= 0) and (unholy <= 0)) or (((frost <= 0 and not fd) or (unholy  <= 0 and not ud)) and death >= 1) or (death >= 2)) and (select(7,UnitBuff("player", spells["Killing Machine"])) ~= nil)) then
					return CLCDK:GetRangeandIcon(icon, spells["Obliterate"])
				end			
			end

			--Blood Strike 		
			if (lblood <=0) then				
				return CLCDK:GetRangeandIcon(icon, spells["Blood Strike"])
			end
			
			-- Frost Strike
			if CLCDK_Settings.CD[Current_Spec].RP and (UnitPower("player") >= (UnitPowerMax("player")-10)) then
				return CLCDK:GetRangeandIcon(icon, spells["Frost Strike"])
			end
			
			-- Rime HB
			if CLCDK_Settings.CD[Current_Spec].SpecOption and select(7,UnitBuff("player", spells["Freezing Fog"])) ~= nil and GetSpellTexture(spells["Howling Blast"])~=nil then			
				return CLCDK:GetRangeandIcon(icon, spells["Howling Blast"])
			end	

			--Obliterate
			if GetSpellTexture(spells["Obliterate"])~=nil then		
				if ((frost <= 0) and (unholy <= 0)) or (((frost <= 0 and not fd) or (unholy  <= 0 and not ud)) and death >= 1) or (death >= 2) then
					return CLCDK:GetRangeandIcon(icon, spells["Obliterate"])
				end
			else			
				--Icy Touch
				if (frost <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])
				end
				
				--Plague Strike
				if (unholy <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Plague Strike"])
				end
			end	
			
			-- Blood Strike 		
			if (blood <= 0) and (death <= 0) then
				return CLCDK:GetRangeandIcon(icon, spells["Blood Strike"])
			end		
			
			-- Frost Strike
			if CLCDK_Settings.CD[Current_Spec].RP and UnitPower("player") >= (40 - FS_Reduce + PoolInterrupt) then
				return CLCDK:GetRangeandIcon(icon, spells["Frost Strike"])
			end
				
			--Horn
			if CLCDK_Settings.CD[Current_Spec].Horn and GetSpellTexture(spells["Horn of Winter"])~=nil then
				start, dur =  GetSpellCooldown(spells["Horn of Winter"])
				if (isOffCD (start, dur)) then
					return CLCDK:GetRangeandIcon(icon, spells["Horn of Winter"])
				end	
			end	
				
			-- If nothing else can be done
			return nil				
		end
		
		--Function to determine rotation for Blood Spec
		function CLCDK:BloodMove(icon)
			--Rune Info
			local frost, lfrost, fd = CLCDK:RuneCDs(SPEC_FROST)
			local unholy, lunholy, ud = CLCDK:RuneCDs(SPEC_UNHOLY)
			local blood = CLCDK:RuneCDs(SPEC_BLOOD)
			local death = CLCDK:DeathRunes()	
				
			-- Bone Shield
			if GetSpellTexture(spells["Bone Shield"])~=nil and CLCDK_Settings.CD[Current_Spec].SpecOption then
				expires = select(7, UnitBuff("player", spells["Bone Shield"]))
				start, dur =  GetSpellCooldown(spells["Bone Shield"])
				if expires == nil and (unholy or death >= 1) and (isOffCD (start, dur)) then	
					return GetSpellTexture(spells["Bone Shield"])
				end
			end		
			
			--Diseases
			local disease, move = CLCDK:GetDisease(icon)	
			if disease then	return move	end	
			
			--Death Strike
			if GetSpellTexture(spells["Death Strike"]) ~= nil then
				if ((frost <= 0) and (unholy  <= 0)) or (((frost <= 0 and not fd) or (unholy  <= 0 and not ud)) and death >= 1) or (death >= 2) then
					return CLCDK:GetRangeandIcon(icon, spells["Death Strike"])
				end	
			end
			
			--Heart if Blade Barrier Less then 4
			if blood <= 0 then
				expires = select(7, UnitBuff("player", spells["Blade Barrier"]))
				if expires == nil or (expires - curtime) < 4 then	
					return CLCDK:GetRangeandIcon(icon, spells["Heart Strike"])
				end
			end
			
			-- Rune Strike
			if CLCDK_Settings.CD[Current_Spec].RP then
				if GetSpellTexture(spells["Rune Strike"])~=nil then
					if UnitPower("player") >= (30 + PoolInterrupt) then
						return CLCDK:GetRangeandIcon(icon, spells["Rune Strike"])
					end
				else
					if UnitPower("player") >= (40 + PoolInterrupt) then
						return CLCDK:GetRangeandIcon(icon, spells["Death Coil"])
					end	
				end
			end
					
			-- Heart Strike
			if blood <= 0 then		
				return CLCDK:GetRangeandIcon(icon, spells["Heart Strike"])
			end		
			
			-- If Crimson Scourge, Blood Boil
			if GetSpellTexture(spells["Blood Boil"]) ~= nil then
				if select(7,UnitBuff("player", spells["Crimson Scourge"])) ~= nil then			
					return GetSpellTexture(spells["Blood Boil"])
				end		
			end
			
			--Horn
			if CLCDK_Settings.CD[Current_Spec].Horn and GetSpellTexture(spells["Horn of Winter"])~=nil then
				start, dur =  GetSpellCooldown(spells["Horn of Winter"])
				if (isOffCD (start, dur)) then
					return CLCDK:GetRangeandIcon(icon, spells["Horn of Winter"])
				end	
			end		
			
			-- If nothing else can be done
			return nil				
		end	

		--Function to determine rotation for No Spec
		function CLCDK:BlankMove(icon)			
			--Rune Info
			local frost = CLCDK:RuneCDs(SPEC_FROST)
			local unholy = CLCDK:RuneCDs(SPEC_UNHOLY)
			local blood = CLCDK:RuneCDs(SPEC_BLOOD)
			local death = CLCDK:DeathRunes()	
		
			--Diseases
			local disease, move = CLCDK:GetDisease(icon)	
			if disease then	return move	end	
			
			-- Blood Strike
			if (blood <= 0) then		
				return CLCDK:GetRangeandIcon(icon, spells["Blood Strike"])
			end	
			
			--Death Strike
			if GetSpellTexture(spells["Death Strike"])~=nil then
				if ((frost <= 0) and (unholy  <= 0)) or (((frost <= 0) or (unholy  <= 0)) and death >=1) or (death >= 2) then
					return CLCDK:GetRangeandIcon(icon, spells["Death Strike"])
				end
			else
				-- Blood Strike
				if (death >= 2) then		
					return CLCDK:GetRangeandIcon(icon, spells["Blood Strike"])
				end	
			
				--Icy Touch
				if (frost <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])
				end
				
				--Plague Strike
				if (unholy <= 0) then
					return CLCDK:GetRangeandIcon(icon, spells["Plague Strike"])
				end
			end
			
			-- Death Coil
			if CLCDK_Settings.CD[Current_Spec].RP and UnitPower("player") >= (40 + PoolInterrupt) then
				return CLCDK:GetRangeandIcon(icon, spells["Death Coil"])
			end		
			
			--Horn
			if CLCDK_Settings.CD[Current_Spec].Horn and GetSpellTexture(spells["Horn of Winter"])~=nil then
				start, dur =  GetSpellCooldown(spells["Horn of Winter"])
				if (isOffCD (start, dur)) then
					return CLCDK:GetRangeandIcon(icon, spells["Horn of Winter"])
				end	
			end	
			
			-- If nothing else can be done
			return nil				
		end	
		
		--Function to determine AOE rotation for Unholy Spec
		function CLCDK:UnholyAOEMove(icon)
			-- Diseases > Dark Transformation > Death and Decay > SS if both Unholy and/or all Death runes are up > 
			-- BB + IT if both pairs of Blood and Frost runes are up >	DC 
			-- > SS > BB + IT 
						
			--Rune Info
			local frost, lfrost, fd, lfd = CLCDK:RuneCDs(SPEC_FROST)
			local unholy, lunholy = CLCDK:RuneCDs(SPEC_UNHOLY)
			local blood, lblood, bd, lbd = CLCDK:RuneCDs(SPEC_BLOOD)
			local death = CLCDK:DeathRunes()
						
			--Death and Decay
			if CLCDK:QuickAOESpellCheck(spells["Death and Decay"]) and ((unholy <= 0) or (death >= 1)) then
				return CLCDK:GetRangeandIcon(icon, spells["Death and Decay"])	
			end
			
			--AOE:Blood Boil	
			if CLCDK:QuickAOESpellCheck(spells["Blood Boil"]) and (lblood <=0) then	
				return CLCDK:GetRangeandIcon(icon, spells["Blood Boil"])	
			end
			
			--AOE:Icy Touch
			if CLCDK:QuickAOESpellCheck(spells["Icy Touch"]) and (lfrost <=0) then	
				return CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])	
			end
			
			-- Death Coil
			if CLCDK_Settings.CD[Current_Spec].RP and 
				((UnitPower("player") >= (40 - DC_Reduce + PoolInterrupt)) or (select(7, UnitBuff("PLAYER",spells["Sudden Doom"]))~= nil)) then
				return CLCDK:GetRangeandIcon(icon, nil)
			end	
			
			--Scourge Strike
			if (unholy <= 0) or (death >= 1) then
				return CLCDK:GetRangeandIcon(icon, nil)
			end	
			
			--AOE:Blood Boil	
			if CLCDK:QuickAOESpellCheck(spells["Blood Boil"]) and (blood <=0) then	
				return CLCDK:GetRangeandIcon(icon, spells["Blood Boil"])	
			end
			
			--AOE:Icy Touch
			if CLCDK:QuickAOESpellCheck(spells["Icy Touch"]) and (frost <=0) then
				return CLCDK:GetRangeandIcon(icon, spells["Icy Touch"])	
			end	

			return nil
		end
		
		--Function to determine AOE rotation for Frost Spec
		function CLCDK:FrostAOEMove(icon)
			-- HB if both Frost runes and/or both Death runes are up >
			-- DnD/PS if both Unholy Runes are up > BS if both Blood Runes are up >
			-- FS if RP capped > HB > BS > DnD/PS > FS > HoW.
		
			--Rune Info
			local frost, lfrost, fd, lfd = CLCDK:RuneCDs(SPEC_FROST)
			local unholy, lunholy, ud, lud = CLCDK:RuneCDs(SPEC_UNHOLY)
			local blood, lblood, bd, lbd = CLCDK:RuneCDs(SPEC_BLOOD)
			local death = CLCDK:DeathRunes()
		
			--AOE:Howling Blast
			if CLCDK:QuickAOESpellCheck(spells["Howling Blast"]) and ((lfrost <= 0) or (lblood <= 0 and lbd) or (lunholy <= 0 and lud)) then	
				return CLCDK:GetRangeandIcon(icon, spells["Howling Blast"])	
			end
			
			--AOE:DnD or PS
			if lunholy <= 0 then
				if CLCDK:QuickAOESpellCheck(spells["Death and Decay"]) then
					return CLCDK:GetRangeandIcon(icon, spells["Death and Decay"])	
				end
				
				if CLCDK:QuickAOESpellCheck(spells["Plague Strike"]) then	
					return CLCDK:GetRangeandIcon(icon, spells["Plague Strike"])	
				end
			end
					
			--AOE:Blood Strike 		
			if CLCDK:QuickAOESpellCheck(spells["Blood Strike"]) and lblood <= 0 then	
				return CLCDK:GetRangeandIcon(icon, nil)	
			end
			
			--AOE:Frost Strike 		
			if CLCDK:QuickAOESpellCheck(spells["Frost Strike"]) and UnitPower("player") >= (40 - FS_Reduce + PoolInterrupt) then
				return CLCDK:GetRangeandIcon(icon, nil)	
			end
			
			--AOE:Howling Blast
			if CLCDK:QuickAOESpellCheck(spells["Howling Blast"]) and (frost <= 0 or death >= 1) then	
				return CLCDK:GetRangeandIcon(icon, spells["Howling Blast"])	
			end
			
			--AOE:Blood Strike 		
			if CLCDK:QuickAOESpellCheck(spells["Blood Strike"]) and blood <= 1 then	
				return CLCDK:GetRangeandIcon(icon, nil)	
			end					
			
			--AOE:DnD or PS
			if unholy <= 0 then
				if CLCDK:QuickAOESpellCheck(spells["Death and Decay"]) then
					return CLCDK:GetRangeandIcon(icon, spells["Death and Decay"])	
				end
				
				if CLCDK:QuickAOESpellCheck(spells["Plague Strike"]) then	
					return CLCDK:GetRangeandIcon(icon, spells["Plague Strike"])	
				end
			end
			
			return nil
		end
		
		--Function to determine AOE rotation for Blood Spec
		function CLCDK:BloodAOEMove(icon)
			return nil
		end
	
	end
	
	--Function to check spec and gylphs and adjust settings accordingly
	function CLCDK:CheckSpec()
		--Set all settings to default
		Current_Spec, FS_Reduce, DC_Reduce, HB_Glyph, DND_Glyph = SPEC_UNKNOWN, 0, 0, false, 0
		
		--Unholy
		if IsSpellKnown(55090) then --Scourge Strike
			Current_Spec = SPEC_UNHOLY						
			DC_Reduce = 3*select(5, GetTalentInfo(3, 7))	--Runic Corruption
		
		--Blood
		elseif IsSpellKnown(55050) then --Heart Strike
			Current_Spec = SPEC_BLOOD					
		
		--Frost
		elseif IsSpellKnown(49143) then --Frost Strike
			Current_Spec = SPEC_FROST
			for i = 1, GetNumGlyphSockets() do
				local glyphID = select(4, GetGlyphSocketInfo(i))		
				if ( glyphID ~= nil ) then	
					--local name = GetSpellInfo(glyphID)
					--print(name.." "..glyphID)
					
					if (glyphID == 63335) then --Glyph of Howling Blast
						HB_Glyph = true
					end
					
					if (glyphID == 58647) then --Glyph of Frost Strike
						FS_Reduce = 8 
					end
				end
			end	
		end
		
		epidemic = 4 * select(5, GetTalentInfo(3, 3))
		for i = 1, GetNumGlyphSockets() do
			local glyphID = select(4, GetGlyphSocketInfo(i))		
			if ( glyphID ~= nil ) then	
				--local name = GetSpellInfo(glyphID)
				--print(name.." "..glyphID)
				
				if (glyphID == 43542) then --Glyph of Death and Decay
					DND_Glyph = 5
				end
			end
		end	
		
		
		if debugg then print("CLCDK:Check Spec - "..Current_Spec)end
		CLCDK:OptionsRefresh()
	end
	
	function CLCDK:Initialize()
		if debugg then print("CLCDK:Initialize")end			
		mutex = true
		
		CLCDK:LoadSpells()
		CLCDK:LoadCooldowns()
		if not CLCDK:LoadTrinkets() and (curtime - launchtime < ITEM_LOAD_THRESHOLD)then if debugg then print("CLCDK:Initialize Failed")end; mutex = false; return; end	
		if debugg and (curtime - launchtime >= ITEM_LOAD_THRESHOLD) then print("CLCDK:Launch Threshold Met") end		
		
		if debugg then
			print("~~CLCDK:Spell Difference Start~~")
			for k, v in pairs (spells) do
				if v == nil or k ~= v then print (k.." =/= ".. v)	end
			end
			print("~~CLCDK:Spell Difference End~~")
		end
		
		--CLCDK:SetDefaults()
		--Check Settings
		CLCDK:CheckSettings()
		if debugg then print("CLCDK:Initialize - Version "..CLCDK_Settings.Version)end
		
		if CLCDK_Settings.DT.Combat or not CLCDK_Settings.DT.Enable then
			CLCDK:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		else
			CLCDK:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
		
		CLCDK:SetAlpha(0)		
		CLCDK:CreateCDs()
		CLCDK:CreateUI()		
		
		--Setup Button Facade if enabled
		if LBF then	
			LBF:Group("CLCDK"):Skin(unpack(CLCDK_Settings.lbf))
			LBF:Group("CLCDK"):AddButton(CLCDK.Diseases.FF)
			LBF:Group("CLCDK"):AddButton(CLCDK.Diseases.BP)
			LBF:Group("CLCDK"):AddButton(CLCDK.Move)
			LBF:Group("CLCDK"):AddButton(CLCDK.Move.AOE)
			LBF:Group("CLCDK"):AddButton(CLCDK.Move.Interrupt)
			for i = 1, #CDDisplayList do  
				LBF:Group("CLCDK"):AddButton(CLCDK.CD[CDDisplayList[i]])
			end				
			LBF:RegisterSkinCallback('CLCDK', self.OnSkin, self)
		end	
		
		InterfaceOptions_AddCategory(CLCDK_Options)
		InterfaceOptions_AddCategory(CLCDK_FramePanel)
		InterfaceOptions_AddCategory(CLCDK_CDRPanel)
		InterfaceOptions_AddCategory(CLCDK_CDPanel)
		InterfaceOptions_AddCategory(CLCDK_DTPanel)
		InterfaceOptions_AddCategory(CLCDK_ABOUTPanel)

		CLCDK_CDRPanel_DG_Text:SetText(spells["Death Grip"])
		
		--Initalize all dropdowns
		UIDropDownMenu_Initialize(CLCDK_FramePanel_Rune_DD, CLCDK_Rune_DD_OnLoad)
		UIDropDownMenu_Initialize(CLCDK_CDRPanel_Diseases_DD, CLCDK_Diseases_OnLoad)
		UIDropDownMenu_Initialize(CLCDK_CDRPanel_DD_Priority, CLCDK_CDRPanel_DD_OnLoad)
		for i = 1, #CDDisplayList do  
			UIDropDownMenu_Initialize(_G[CDDisplayList[i]], CLCDK_CDRPanel_DD_OnLoad)
		end
		UIDropDownMenu_Initialize(CLCDK_FramePanel_ViewDD, CLCDK_FramePanel_ViewDD_OnLoad)	
		UIDropDownMenu_Initialize(CLCDK_DTPanel_DD_Threat, CLCDK_DTPanel_Threat_OnLoad)
		if debugg then print("CLCDK:Initialize - Dropdowns Done")end
		
		CLCDK:CheckSpec()			
		
		mutex = nil
		loaded = true
		
		collectgarbage()
	end
	
	if debugg then print("CLCDK:Functions Done")end
	
	-----Events-----
	--Register Events
	CLCDK:RegisterEvent("PLAYER_TALENT_UPDATE")
	CLCDK:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	CLCDK:RegisterEvent("GLYPH_UPDATED")
	--CLCDK:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
	--Function to be called when events triggered
	local slottimer = 0
	CLCDK:SetScript("OnEvent", function(_, e, ...)
		if loaded then 
			if debugg then print("CLCDK:Event "..e)end
			if e == "COMBAT_LOG_EVENT_UNFILTERED" then		
				local _, event, _, casterName, _, targetguid, targetName, _, _, spellName = ...			
				if (event == "UNIT_DIED" or event == "UNIT_DESTROYED") and CLCDK.DT.Unit[targetguid] ~= nil then  
					if CLCDK.DT.Unit[targetguid].Frame ~= nil then
						CLCDK.DT.Unit[targetguid].Frame:SetAlpha(0)
						CLCDK.DT.Unit[targetguid].Frame = nil
					end
					CLCDK.DT.Unit[targetguid] = nil 
				end
				
				if (casterName == PLAYER_NAME) and CLCDK_Settings.DT.Dots[spellName] then
					curtime = GetTime()
					if (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH") then			
						if CLCDK.DT.Unit[targetguid] == nil then  
							CLCDK.DT.Unit[targetguid] = {}
							CLCDK.DT.Unit[targetguid].Spells = {}
							CLCDK.DT.Unit[targetguid].NumDots = 0
							CLCDK.DT.Unit[targetguid].Name = select(3, string.find(targetName, "(.-)-")) or targetName					
						end
						
						if CLCDK.DT.Unit[targetguid].Spells[spellName] == nil then
							CLCDK.DT.Unit[targetguid].NumDots = CLCDK.DT.Unit[targetguid].NumDots + 1
						end
						
						if spellName == spells["Death and Decay"] then
							CLCDK.DT.Unit[targetguid].Spells[spellName] = select(1, GetSpellCooldown(spellName)) + 10 + DND_Glyph
						else
							CLCDK.DT.Unit[targetguid].Spells[spellName] = (DTspells[spellName][2] + ((DTspells[spellName][3] and epidemic) or 0)) + curtime-- + 21 + epidemic	
						end
						
					elseif (event == "SPELL_AURA_REMOVED") then
						if CLCDK.DT.Unit[targetguid] ~= nil and  CLCDK.DT.Unit[targetguid][spellName] ~= nil then  
							 CLCDK.DT.Unit[targetguid].Spells[spellName] = nil
							 CLCDK.DT.Unit[targetguid].NumDots = CLCDK.DT.Unit[targetguid].NumDots - 1
						end	
					end
				end		
			else
				CLCDK:CheckSpec() 
			end
		end
	end)	
		
	--Main function to run addon
	local DTupdatetimer = 0
	local DTchecktimer = 0
	CLCDK:SetScript("OnUpdate", function() 
		curtime = GetTime()    	
		--Make sure it only updates at max, once every 0.15 sec
		if (curtime - updatetimer >= 0.15) then	
			updatetimer = curtime
			
			if (not loaded) and (not mutex) then 
				if launchtime == 0 then launchtime = curtime;if debugg then print("CLCDK:Launchtime Set")end end
				CLCDK:Initialize()		
			elseif loaded then
				--Check if visibility conditions are met, if so update the information in the addon
				if (not UnitHasVehicleUI("player")) and 
						((InCombatLockdown() and CLCDK_Settings.VScheme == CLCDK_OPTIONS_FRAME_VIEW_NORM) or 
						(CLCDK_Settings.VScheme == CLCDK_OPTIONS_FRAME_VIEW_SHOW) or 
						(not CLCDK_Settings.Locked) or 
						(CLCDK_Settings.VScheme ~= CLCDK_OPTIONS_FRAME_VIEW_HIDE and UnitCanAttack("player", "target") and (not UnitIsDead("target")))) then	
					CLCDK:UpdateUI()
					if CLCDK_Settings.Locked then
						if IsAltKeyDown() then CLCDK:EnableMouse(true) 
						else CLCDK:EnableMouse(false) end
					end
					
				else	
					CLCDK:SetAlpha(0)				
				end
				
				if resize ~= nil then
					x, y = GetCursorPosition()
					sizex = (x - mousex + resize:GetWidth())/resize:GetWidth()
					sizey = (mousey - y + resize:GetHeight())/resize:GetHeight()
					if sizex < sizey then
						if sizex > 1 then
							resize:SetScale(sizex)
						end
					else
						if sizey > 1 then
							resize:SetScale(sizey)
						end
					end		
				end
			end	
		end	
		if loaded and CLCDK_Settings.DT.Enable then
			if (curtime - DTchecktimer >= CLCDK_Settings.DT.Update) then
				DTchecktimer = curtime	
				CLCDK:DTCheckTargets()
			end
			if (curtime - DTupdatetimer >= 0.5) then
				DTupdatetimer = curtime	
				CLCDK:DTUpdateFrames()
			end
		end
	end)
	
	-----Options-----
	--Setup slash command
	SLASH_CLCDK1 = '/clcdk'
	SlashCmdList["CLCDK"] = function() 
		InterfaceOptionsFrame_OpenToCategory(CLCDK_FramePanel)
		if debugg then print("CLCDK:Slash Command Used")end
	end
	
	--Update the Blizzard interface Options with settings
	function CLCDK:OptionsRefresh()
		if CLCDK_Settings ~= nil and CLCDK_Settings.Version ~= nil and CLCDK_Settings.Version == CLCDK_VERSION then	
			--Frame
			CLCDK_FramePanel_GCD:SetChecked(CLCDK_Settings.GCD)
			CLCDK_FramePanel_CDS:SetChecked(CLCDK_Settings.CDS)
			CLCDK_FramePanel_Range:SetChecked(CLCDK_Settings.Range)			
			CLCDK_FramePanel_Rune:SetChecked(CLCDK_Settings.Rune)
			CLCDK_FramePanel_RP:SetChecked(CLCDK_Settings.RP)		
			CLCDK_FramePanel_Disease:SetChecked(CLCDK_Settings.Disease)		
			CLCDK_FramePanel_Locked:SetChecked(CLCDK_Settings.Locked)
			CLCDK_FramePanel_LockedPieces:SetChecked(CLCDK_Settings.LockedPieces)
			CLCDK_FramePanel_Scale:SetNumber(CLCDK_Settings.Scale)
			CLCDK_FramePanel_Scale:SetCursorPosition(0)	
			CLCDK_FramePanel_Trans:SetNumber(CLCDK_Settings.Trans)
			CLCDK_FramePanel_Trans:SetCursorPosition(0)	
			CLCDK_FramePanel_CombatTrans:SetNumber(CLCDK_Settings.CombatTrans)
			CLCDK_FramePanel_CombatTrans:SetCursorPosition(0)	
			
			--View Dropdown
			UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_ViewDD, CLCDK_Settings.VScheme)	
			UIDropDownMenu_SetText(CLCDK_FramePanel_ViewDD, CLCDK_Settings.VScheme)	
						
			UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder)	
			UIDropDownMenu_SetText(CLCDK_FramePanel_Rune_DD, CLCDK_OPTIONS_FRAME_RUNE_ORDER[CLCDK_Settings.RuneOrder])	
			
			
			--CD/R 
			CLCDK_CDRPanel_SpecOption:Enable()
			CLCDK_CDRPanel_Outbreak_Text:SetText(spells["Outbreak"])
			CLCDK_CDRPanel_Horn_Text:SetText(spells["Horn of Winter"])
			if (Current_Spec == SPEC_UNHOLY) then				
				CLCDK_CDRPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_UNHOLY)
				CLCDK_CDPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_UNHOLY)
				CLCDK_CDRPanel_SpecOption_Text:SetText(spells["Dark Transformation"])
				CLCDK_CDRPanel_SpecOption:Enable()
				CLCDK_DTPanel_DOTS_Spec_Text:SetText(spells["Ebon Plague"])
			elseif (Current_Spec == SPEC_FROST) then
				CLCDK_CDRPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_FROST)
				CLCDK_CDPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_FROST)
				CLCDK_CDRPanel_SpecOption_Text:SetText(spells["Howling Blast"])
				CLCDK_CDRPanel_SpecOption:Enable()
				CLCDK_DTPanel_DOTS_Spec_Text:SetText(spells["Chilblains"])
			elseif (Current_Spec == SPEC_BLOOD) then
				CLCDK_CDRPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_BLOOD)
				CLCDK_CDPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_BLOOD)
				CLCDK_CDRPanel_SpecOption_Text:SetText(spells["Bone Shield"])
				CLCDK_CDRPanel_SpecOption:Enable()
				CLCDK_DTPanel_DOTS_Spec_Text:SetText(spells["Scarlet Fever"])
			else
				CLCDK_CDRPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_None)
				CLCDK_CDPanel_Title_Spec:SetText(CLCDK_OPTIONS_SPEC_None)
				CLCDK_CDRPanel_SpecOption_Text:SetText("")
				CLCDK_CDRPanel_SpecOption:Disable()
			end	
						
			--Disease Dropdown
			UIDropDownMenu_SetSelectedValue(CLCDK_CDRPanel_Diseases_DD, CLCDK_Settings.CD[Current_Spec].DiseaseOption)	
			local text
			if CLCDK_Settings.CD[Current_Spec].DiseaseOption == DISEASE_BOTH then text = CLCDK_OPTIONS_CDR_DISEASES_DD_BOTH
			elseif CLCDK_Settings.CD[Current_Spec].DiseaseOption == DISEASE_ONE then text = CLCDK_OPTIONS_CDR_DISEASES_DD_ONE
			else text =	CLCDK_OPTIONS_CDR_DISEASES_DD_NONE end
			UIDropDownMenu_SetText(CLCDK_CDRPanel_Diseases_DD, text)	
			
			CLCDK_CDRPanel_Outbreak:SetChecked(CLCDK_Settings.CD[Current_Spec].Outbreak)			
			CLCDK_CDRPanel_Horn:SetChecked(CLCDK_Settings.CD[Current_Spec].Horn)
			CLCDK_CDRPanel_IRP:SetChecked(CLCDK_Settings.CD[Current_Spec].RP)
			CLCDK_CDRPanel_PoolInterrupt:SetChecked(CLCDK_Settings.PoolInterrupt)
			CLCDK_CDRPanel_MoveAltInterrupt:SetChecked(CLCDK_Settings.MoveAltInterrupt)
			CLCDK_CDRPanel_MoveAltAOE:SetChecked(CLCDK_Settings.MoveAltAOE)
			CLCDK_CDRPanel_MoveAltDND:SetChecked(CLCDK_Settings.MoveAltDND)
			CLCDK_CDRPanel_DG:SetChecked(CLCDK_Settings.DG)
			CLCDK_CDRPanel_SpecOption:SetChecked(CLCDK_Settings.CD[Current_Spec].SpecOption)
			CLCDK_CDRPanel_DD_CD1:SetChecked(CLCDK_Settings.CD[Current_Spec][1])	
			CLCDK_CDRPanel_DD_CD2:SetChecked(CLCDK_Settings.CD[Current_Spec][2])
			CLCDK_CDRPanel_DD_CD3:SetChecked(CLCDK_Settings.CD[Current_Spec][3])	
			CLCDK_CDRPanel_DD_CD4:SetChecked(CLCDK_Settings.CD[Current_Spec][4])			
						
			--Priority Dropdown
			if CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"] ~= nil and CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][1] ~= nil then
				UIDropDownMenu_SetSelectedValue(CLCDK_CDRPanel_DD_Priority, CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][1]..((CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][IS_BUFF] and " (Buff)") or ""))	
				UIDropDownMenu_SetText(CLCDK_CDRPanel_DD_Priority, CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][1]..((CLCDK_Settings.CD[Current_Spec]["CLCDK_CDRPanel_DD_Priority"][IS_BUFF] and " (Buff)") or ""))				
			end
			
			--Cooldown Dropdown
			for i = 1, #CDDisplayList do
				if _G[CDDisplayList[i]] ~= nil and CLCDK_Settings.CD[Current_Spec][CDDisplayList[i]] ~= nil and CLCDK_Settings.CD[Current_Spec][CDDisplayList[i]][1] ~= nil then
					UIDropDownMenu_SetSelectedValue(_G[CDDisplayList[i]], CLCDK_Settings.CD[Current_Spec][CDDisplayList[i]][1]..((CLCDK_Settings.CD[Current_Spec][CDDisplayList[i]][IS_BUFF] and " (Buff)") or ""))
					UIDropDownMenu_SetText(_G[CDDisplayList[i]], CLCDK_Settings.CD[Current_Spec][CDDisplayList[i]][1]..((CLCDK_Settings.CD[Current_Spec][CDDisplayList[i]][IS_BUFF] and " (Buff)") or ""))
				end
			end

			--Disease Tracker
			CLCDK_DTPanel_Enable:SetChecked(CLCDK_Settings.DT.Enable)
			CLCDK_DTPanel_CColours:SetChecked(CLCDK_Settings.DT.CColours)
			CLCDK_DTPanel_TColours:SetChecked(CLCDK_Settings.DT.TColours)
			CLCDK_DTPanel_Target:SetChecked(CLCDK_Settings.DT.Target)
			CLCDK_DTPanel_TPriority:SetChecked(CLCDK_Settings.DT.TPriority)
			CLCDK_DTPanel_GrowDown:SetChecked(CLCDK_Settings.DT.GrowDown)
			CLCDK_DTPanel_CombatLog:SetChecked(CLCDK_Settings.DT.Combat)
			CLCDK_DTPanel_Update:SetNumber(CLCDK_Settings.DT.Update)
			CLCDK_DTPanel_Update:SetCursorPosition(0)
			CLCDK_DTPanel_NumFrames:SetNumber(CLCDK_Settings.DT.Numframes)
			CLCDK_DTPanel_NumFrames:SetCursorPosition(0)
			CLCDK_DTPanel_Warning:SetNumber(CLCDK_Settings.DT.Warning)
			CLCDK_DTPanel_Warning:SetCursorPosition(0)
			UIDropDownMenu_SetSelectedValue(CLCDK_DTPanel_DD_Threat, CLCDK_Settings.DT.Threat)	
			if CLCDK_Settings.DT.Threat == THREAT_OFF then text = CLCDK_OPTIONS_DT_THREAT_OFF
			elseif CLCDK_Settings.DT.Threat == THREAT_ANALOG then text = CLCDK_OPTIONS_DT_THREAT_ANALOG
			elseif CLCDK_Settings.DT.Threat == THREAT_DIGITAL then text = CLCDK_OPTIONS_DT_THREAT_DIGITAL
			end
			UIDropDownMenu_SetText(CLCDK_DTPanel_DD_Threat, text)	
			
			CLCDK_DTPanel_DOTS_FF_Text:SetText(spells["Frost Fever"])
			CLCDK_DTPanel_DOTS_FF:SetChecked(CLCDK_Settings.DT.Dots[spells["Frost Fever"]])
			CLCDK_DTPanel_DOTS_BP_Text:SetText(spells["Blood Plague"])
			CLCDK_DTPanel_DOTS_BP:SetChecked(CLCDK_Settings.DT.Dots[spells["Blood Plague"]])
			CLCDK_DTPanel_DOTS_DD_Text:SetText(spells["Death and Decay"])
			CLCDK_DTPanel_DOTS_DD:SetChecked(CLCDK_Settings.DT.Dots[spells["Death and Decay"]])
			
			--About Options
			local expText = "<html><body>"
					.."<p>"..CLCDK_ABOUT_BODY.."</p>"
					.."<p><br/>"
					.."|cffaaaaaa"..CLCDK_ABOUT_GER.."<br/>"
					.."|cffaaaaaa"..CLCDK_ABOUT_CT.."<br/>"
					.."</p>"
					.."</body></html>";
			CLCDK_ABOUTHTML:SetText (expText);
			CLCDK_ABOUTHTML:SetSpacing (2);
			
			if debugg then print("CLCDK:OptionsRefresh")end
			CLCDK:UpdatePosition()				
		else
			if debugg then print("CLCDK:ERROR OptionsRefresh - "..(CLCDK_Settings == nil and "Settings are nil") or (CLCDK_Settings.Version == nil and "Version is nil") or ("Invalid Version"..CLCDK_Settings.Version ))end
		end
	end
	
	--Check if options are valid and save them to settings if so
	function CLCDK:OptionsOkay()
		if CLCDK_Settings ~= nil and (CLCDK_Settings.Version ~= nil and CLCDK_Settings.Version == CLCDK_VERSION) then
			--Frame
			CLCDK_Settings.GCD = CLCDK_FramePanel_GCD:GetChecked()
			CLCDK_Settings.CDS = CLCDK_FramePanel_CDS:GetChecked()
			CLCDK_Settings.Range = CLCDK_FramePanel_Range:GetChecked()
			CLCDK_Settings.Rune = CLCDK_FramePanel_Rune:GetChecked()
			CLCDK_Settings.RP = CLCDK_FramePanel_RP:GetChecked()
			CLCDK_Settings.Disease = CLCDK_FramePanel_Disease:GetChecked()
			CLCDK_Settings.Locked = CLCDK_FramePanel_Locked:GetChecked()
			CLCDK_Settings.LockedPieces = CLCDK_FramePanel_LockedPieces:GetChecked()	
						
			--Scale
			if CLCDK_FramePanel_Scale:GetNumber() >= 0.5 and CLCDK_FramePanel_Scale:GetNumber() <= 5 then
				CLCDK_Settings.Scale = CLCDK_FramePanel_Scale:GetNumber()
			else
				CLCDK_FramePanel_Scale:SetNumber(CLCDK_Settings.Scale)
			end
			
			--Transparency
			if CLCDK_FramePanel_Trans:GetNumber() >= 0 and CLCDK_FramePanel_Trans:GetNumber() <= 1 then
				CLCDK_Settings.Trans = CLCDK_FramePanel_Trans:GetNumber()
			else
				CLCDK_FramePanel_Trans:SetNumber(CLCDK_Settings.Trans)
			end
			
			--Transparency
			if CLCDK_FramePanel_CombatTrans:GetNumber() >= 0 and CLCDK_FramePanel_CombatTrans:GetNumber() <= 1 then
				CLCDK_Settings.CombatTrans = CLCDK_FramePanel_CombatTrans:GetNumber()
			else
				CLCDK_FramePanel_CombatTrans:SetNumber(CLCDK_Settings.CombatTrans)
			end

			--CD/R
			CLCDK_Settings.PoolInterrupt = CLCDK_CDRPanel_PoolInterrupt:GetChecked()
			CLCDK_Settings.MoveAltInterrupt = CLCDK_CDRPanel_MoveAltInterrupt:GetChecked()
			CLCDK_Settings.MoveAltAOE = CLCDK_CDRPanel_MoveAltAOE:GetChecked()
			CLCDK_Settings.MoveAltDND = CLCDK_CDRPanel_MoveAltDND:GetChecked()
			CLCDK_Settings.DG = CLCDK_CDRPanel_DG:GetChecked()
			CLCDK_Settings.CD[Current_Spec].SpecOption = CLCDK_CDRPanel_SpecOption:GetChecked()
			CLCDK_Settings.CD[Current_Spec].Outbreak = CLCDK_CDRPanel_Outbreak:GetChecked()
			CLCDK_Settings.CD[Current_Spec].Horn = CLCDK_CDRPanel_Horn:GetChecked()
			CLCDK_Settings.CD[Current_Spec].RP = CLCDK_CDRPanel_IRP:GetChecked()			
			CLCDK_Settings.CD[Current_Spec][1] = (CLCDK_CDRPanel_DD_CD1:GetChecked())
			CLCDK_Settings.CD[Current_Spec][2] = (CLCDK_CDRPanel_DD_CD2:GetChecked())
			CLCDK_Settings.CD[Current_Spec][3] = (CLCDK_CDRPanel_DD_CD3:GetChecked())
			CLCDK_Settings.CD[Current_Spec][4] = (CLCDK_CDRPanel_DD_CD4:GetChecked())
			
			--Pool for Interrupt
			PoolInterrupt = 0
			if CLCDK_Settings.PoolInterrupt then
				PoolInterrupt = 20 - (10*select(5, GetTalentInfo(2, 7))) -- Endless Winter
			end
			
			--Disease Timers
			CLCDK_Settings.DT.Enable = CLCDK_DTPanel_Enable:GetChecked()
			if not CLCDK_Settings.DT.Enable then
				for k, v in pairs(CLCDK.DT.Unit) do
					CLCDK.DT.Unit[k].Frame:SetAlpha(0)
					CLCDK.DT.Unit[k].Frame = nil
				end	
				collectgarbage()
			end
			CLCDK_Settings.DT.CColours = CLCDK_DTPanel_CColours:GetChecked()
			CLCDK_Settings.DT.TColours = CLCDK_DTPanel_TColours:GetChecked()
			CLCDK_Settings.DT.Target = CLCDK_DTPanel_Target:GetChecked()
			CLCDK_Settings.DT.TPriority = CLCDK_DTPanel_TPriority:GetChecked()
			CLCDK_Settings.DT.GrowDown = CLCDK_DTPanel_GrowDown:GetChecked()
			CLCDK_Settings.DT.Combat = CLCDK_DTPanel_CombatLog:GetChecked()
			if CLCDK_DTPanel_Update:GetNumber() >= 0.1 and CLCDK_DTPanel_Update:GetNumber() <= 10 then
				CLCDK_Settings.DT.Update = CLCDK_DTPanel_Update:GetNumber()
			else
				CLCDK_DTPanel_Update:SetNumber(CLCDK_Settings.DT.Update)
			end
			if CLCDK_DTPanel_NumFrames:GetNumber() >= 1 and CLCDK_DTPanel_NumFrames:GetNumber() <= 10 then
				CLCDK_Settings.DT.Numframes = CLCDK_DTPanel_NumFrames:GetNumber()
			else
				CLCDK_DTPanel_NumFrames:SetNumber(CLCDK_Settings.DT.Numframes)
			end
			if CLCDK_DTPanel_Warning:GetNumber() >= 0 and CLCDK_DTPanel_Warning:GetNumber() <= 10 then
				CLCDK_Settings.DT.Warning = CLCDK_DTPanel_Warning:GetNumber()
			else
				CLCDK_DTPanel_Warning:SetNumber(CLCDK_Settings.DT.Warning)
			end
			CLCDK_Settings.DT.Dots[spells["Frost Fever"]] = CLCDK_DTPanel_DOTS_FF:GetChecked()
			CLCDK_Settings.DT.Dots[spells["Blood Plague"]] = CLCDK_DTPanel_DOTS_BP:GetChecked()
			CLCDK_Settings.DT.Dots[spells["Death and Decay"]] = CLCDK_DTPanel_DOTS_DD:GetChecked()
			if (Current_Spec == SPEC_UNHOLY) then	
				CLCDK_Settings.DT.Dots[spells["Ebon Plague"]] = CLCDK_DTPanel_DOTS_Spec:GetChecked()
			elseif (Current_Spec == SPEC_FROST) then
				CLCDK_Settings.DT.Dots[spells["Chilblains"]] = CLCDK_DTPanel_DOTS_Spec:GetChecked()
			elseif (Current_Spec == SPEC_BLOOD) then
				CLCDK_Settings.DT.Dots[spells["Scarlet Fever"]] = CLCDK_DTPanel_DOTS_Spec:GetChecked()
			end	
			
			if CLCDK_Settings.DT.Combat or not CLCDK_Settings.DT.Enable then
				CLCDK:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			else
				CLCDK:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			end
			
			if debugg then print("CLCDK:OptionsOkay")end
			CLCDK:OptionsRefresh()			
		else
			if debugg then print("CLCDK:ERROR OptionsOkay - "..(CLCDK_Settings == nil and "Settings are nil") or (CLCDK_Settings.Version == nil and "Version is nil") or ("Invalid Version"..CLCDK_Settings.Version))end	
		end
	end
	
	--Cooldown Defaults
	function CLCDK:CooldownDefaults()
		if CLCDK_Settings.CD ~= nil then wipe(CLCDK_Settings.CD) end
		CLCDK_Settings.CD = {			
			[SPEC_UNHOLY] = {
				["CLCDK_CDRPanel_DD_Priority"] = {CLCDK_OPTIONS_CDR_CD_PRIORITY, nil},
				DiseaseOption = DISEASE_BOTH,		
				Outbreak = true,
				Horn = true,
				RP = true,
				SpecOption = true,
			
				[1] = true,
				["CLCDK_CDRPanel_DD_CD1_One"] = {spells["Shadow Infusion"], true},
				["CLCDK_CDRPanel_DD_CD1_Two"] = {spells["Dark Transformation"], true},				
				
				[2] = true,
				["CLCDK_CDRPanel_DD_CD2_One"] = {spells["Runic Corruption"], true},
				["CLCDK_CDRPanel_DD_CD2_Two"] = {spells["Sudden Doom"], true},
				
				[3] = false,
				["CLCDK_CDRPanel_DD_CD3_One"] = {spells["Horn of Winter"], true},
				["CLCDK_CDRPanel_DD_CD3_Two"] = {spells["Blood Tap"], nil},
				
				[4] = false,
				["CLCDK_CDRPanel_DD_CD4_One"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1, nil},
				["CLCDK_CDRPanel_DD_CD4_Two"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT2, nil},
			},
			
			[SPEC_FROST] = {
				["CLCDK_CDRPanel_DD_Priority"] = {CLCDK_OPTIONS_CDR_CD_PRIORITY, nil},
				DiseaseOption = DISEASE_BOTH,		
				Outbreak = false,
				Horn = true,
				RP = true,
				SpecOption = true,
			
				[1] = true,
				["CLCDK_CDRPanel_DD_CD1_One"] = {spells["Lichborne"], nil},
				["CLCDK_CDRPanel_DD_CD1_Two"] = {spells["Lichborne"], true},				
				
				[2] = true,
				["CLCDK_CDRPanel_DD_CD2_One"] = {spells["Killing Machine"], true},
				["CLCDK_CDRPanel_DD_CD2_Two"] = {spells["Freezing Fog"], true},
				
				[3] = false,
				["CLCDK_CDRPanel_DD_CD3_One"] = {spells["Horn of Winter"], true},
				["CLCDK_CDRPanel_DD_CD3_Two"] = {spells["Blood Tap"], nil},
				
				[4] = false,
				["CLCDK_CDRPanel_DD_CD4_One"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1, nil},
				["CLCDK_CDRPanel_DD_CD4_Two"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT2, nil},
			},
			
			[SPEC_BLOOD] = {
				["CLCDK_CDRPanel_DD_Priority"] = {CLCDK_OPTIONS_CDR_CD_PRIORITY, nil},
				DiseaseOption = DISEASE_NONE,		
				Outbreak = true,
				Horn = false,
				RP = true,
				SpecOption = true,
			
				[1] = true,
				["CLCDK_CDRPanel_DD_CD1_One"] = {spells["Bone Shield"], true},
				["CLCDK_CDRPanel_DD_CD1_Two"] = {spells["Vampiric Blood"], nil},				
				
				[2] = true,
				["CLCDK_CDRPanel_DD_CD2_One"] = {spells["Rune Tap"], nil},
				["CLCDK_CDRPanel_DD_CD2_Two"] = {spells["Scarlet Fever"], true},
				
				[3] = false,
				["CLCDK_CDRPanel_DD_CD3_One"] = {spells["Horn of Winter"], true},
				["CLCDK_CDRPanel_DD_CD3_Two"] = {spells["Blood Tap"], nil},
				
				[4] = false,
				["CLCDK_CDRPanel_DD_CD4_One"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1, nil},
				["CLCDK_CDRPanel_DD_CD4_Two"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT2, nil},
			},
			
			[SPEC_UNKNOWN] = {
				["CLCDK_CDRPanel_DD_Priority"] = {CLCDK_OPTIONS_CDR_CD_PRIORITY, nil},
				DiseaseOption = DISEASE_BOTH,		
				Outbreak = false,
				Horn = true,
				RP = true,
				SpecOption = true,
			
				[1] = true,
				["CLCDK_CDRPanel_DD_CD1_One"] = {spells["Horn of Winter"], nil},
				["CLCDK_CDRPanel_DD_CD1_Two"] = {spells["Blood Tap"], nil},				
				
				[2] = true,
				["CLCDK_CDRPanel_DD_CD2_One"] = {spells["Raise Dead"], nil},
				["CLCDK_CDRPanel_DD_CD2_Two"] = {spells["Army of the Dead"], nil},
				
				[3] = false,
				["CLCDK_CDRPanel_DD_CD3_One"] = {spells["Horn of Winter"], true},
				["CLCDK_CDRPanel_DD_CD3_Two"] = {spells["Blood Tap"], nil},
				
				[4] = false,
				["CLCDK_CDRPanel_DD_CD4_One"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1, nil},
				["CLCDK_CDRPanel_DD_CD4_Two"] = {CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT2, nil},
			},			
		}
	end
	
	--Checks to make sure that none of the settings are nil, which will lead to the addon not working properly
	function CLCDK:CheckSettings()	
		if debugg then print("CLCDK:Check Settings Start")end
		
		local specs = {SPEC_UNKNOWN, SPEC_BLOOD, SPEC_FROST, SPEC_UNHOLY}
		local spots = {"Priority", "CD1_One", "CD1_Two", "CD2_One", "CD2_Two", "CD3_One", "CD3_Two", "CD4_One", "CD4_Two"}
		
		--Defaults
		if CLCDK_Settings == nil then 
			CLCDK_Settings = {} 
			CLCDK_Settings.Locked = true	
			CLCDK_Settings.LockedPieces = true			
			CLCDK_Settings.Range = true	
			CLCDK_Settings.GCD = true	
			CLCDK_Settings.Rune = true
			CLCDK_Settings.RuneOrder = BBUUFF
			CLCDK_Settings.RP = true				
			CLCDK_Settings.Disease = true		
			CLCDK_Settings.CD = {}
			CLCDK:CooldownDefaults()
		end		
		
		--General Settings
		if CLCDK_Settings.lbf == nil then CLCDK_Settings.lbf = { 'Blizzard', 0, nil }end	
		if CLCDK_Settings.Scale == nil then CLCDK_Settings.Scale = 1.0 end
		if CLCDK_Settings.RuneOrder == nil then  CLCDK_Settings.RuneOrder = BBUUFF end
		if CLCDK_Settings.Trans == nil then CLCDK_Settings.Trans = 0.5 end
		if CLCDK_Settings.CombatTrans == nil then CLCDK_Settings.CombatTrans = 1.0 end
		if CLCDK_Settings.VScheme == nil then CLCDK_Settings.VScheme = CLCDK_OPTIONS_FRAME_VIEW_NORM end
		
		--CDs
		if CLCDK_Settings.CD == nil then 
			CLCDK_Settings.CD = {}
			CLCDK:CooldownDefaults()
		end		
		for i=1,#specs do
			if CLCDK_Settings.CD[specs[i]] == nil then CLCDK_Settings.CD[specs[i]] = {}	end			
			if CLCDK_Settings.CD[specs[i]].DiseaseOption == nil then CLCDK_Settings.CD[specs[i]].DiseaseOption = DISEASE_BOTH end
			for j=1,#spots do
				if CLCDK_Settings.CD[specs[i]]["CLCDK_CDRPanel_DD_"..spots[j]] == nil or 
					CLCDK_Settings.CD[specs[i]]["CLCDK_CDRPanel_DD_"..spots[j]][1] == nil then
					CLCDK_Settings.CD[specs[i]]["CLCDK_CDRPanel_DD_"..spots[j]] = {CLCDK_OPTIONS_FRAME_VIEW_NONE, nil}
				end	
			end
		end		

		--DT
		if CLCDK_Settings.DT == nil then 
			CLCDK_Settings.DT = {}
			CLCDK_Settings.DT.Enable = true
			CLCDK_Settings.DT.Target = true
			CLCDK_Settings.DT.TPriority = true
			CLCDK_Settings.DT.CColours = true
			CLCDK_Settings.DT.TColours = true	
		end
		if CLCDK_Settings.DT.Update == nil then CLCDK_Settings.DT.Update = 2.5 end
		if CLCDK_Settings.DT.Numframes == nil then CLCDK_Settings.DT.Numframes = 5 end
		if CLCDK_Settings.DT.Warning == nil then CLCDK_Settings.DT.Warning = 3 end
		if CLCDK_Settings.DT.Threat == nil then CLCDK_Settings.DT.Threat = THREAT_ANALOG end
		if CLCDK_Settings.DT.Dots == nil then 
			CLCDK_Settings.DT.Dots = {}
			CLCDK_Settings.DT.Dots[spells["Frost Fever"]] = true
			CLCDK_Settings.DT.Dots[spells["Blood Plague"]] = true
			CLCDK_Settings.DT.Dots[spells["Death and Decay"]] = true
		end
		
		--Frame Location
		if CLCDK_Settings.Location == nil then CLCDK_Settings.Location = {} end			
		if CLCDK_Settings.Location["CLCDK"] == nil then	CLCDK_Settings.Location["CLCDK"] = {Point = "Center", Rel = nil, RelPoint = "CENTER", X = 0, Y = -175, Scale = 1} end		
		if CLCDK_Settings.Location["CLCDK.CD1"] == nil then	CLCDK_Settings.Location["CLCDK.CD1"] = {Point = "TOPRIGHT",Rel = "CLCDK",RelPoint = "TOPLEFT", X = -1, Y = -3, Scale = 1} end		
		if CLCDK_Settings.Location["CLCDK.CD2"] == nil then	CLCDK_Settings.Location["CLCDK.CD2"] = {Point = "TOPLEFT",Rel = "CLCDK",RelPoint = "TOPRIGHT",X = 1,Y = -3, Scale = 1}	end		
		if CLCDK_Settings.Location["CLCDK.CD3"] == nil then	CLCDK_Settings.Location["CLCDK.CD3"] = {Point = "TOPRIGHT",Rel = "CLCDK.CD1",RelPoint = "TOPLEFT", X = -2, Y = 0, Scale = 1} end		
		if CLCDK_Settings.Location["CLCDK.CD4"] == nil then	CLCDK_Settings.Location["CLCDK.CD4"] = {Point = "TOPLEFT",Rel = "CLCDK.CD2",RelPoint = "TOPRIGHT",X = 2,Y = 0, Scale = 1} end
		if CLCDK_Settings.Location["CLCDK.RuneBar"] == nil then	CLCDK_Settings.Location["CLCDK.RuneBar"] = {Point = "Top",Rel = "CLCDK",RelPoint = "Top",X = 0,Y = -2, Scale = 1} end		
		if CLCDK_Settings.Location["CLCDK.RunicPower"] == nil then CLCDK_Settings.Location["CLCDK.RunicPower"] = {Point = "TOPRIGHT",Rel = "CLCDK.RuneBar",RelPoint = "BOTTOMRIGHT",X = 0,Y = 0, Scale = 1} end
		if CLCDK_Settings.Location["CLCDK.Move"] == nil then CLCDK_Settings.Location["CLCDK.Move"] = {Point = "TOPLEFT",Rel = "CLCDK.RuneBar",RelPoint = "BOTTOMLEFT",X = 0,Y = 0, Scale = 1} end		
		if CLCDK_Settings.Location["CLCDK.Diseases"] == nil then CLCDK_Settings.Location["CLCDK.Diseases"]= {Point = "TOPRIGHT",Rel = "CLCDK.RunicPower",RelPoint = "BOTTOMRIGHT",X = 0,Y = 0, Scale = 1} end
		if CLCDK_Settings.Location["CLCDK.DT"] == nil then	CLCDK_Settings.Location["CLCDK.DT"] = {Point = "BOTTOMRIGHT",Rel = "CLCDK.CD3",RelPoint = "BOTTOMLEFT",X = -2,Y = 0, Scale = 0.7} end
		
		CLCDK_Settings.Version = CLCDK_VERSION
		
		wipe(specs)
		wipe(spots)	
		collectgarbage()
		if debugg then print("CLCDK:Check Settings Complete")end
	end
	
	--Set frame location back to Defaults
	function CLCDK:SetLocationDefault()
		if CLCDK_Settings.Location ~= nil then wipe(CLCDK_Settings.Location); CLCDK_Settings.Location = nil end
		CLCDK:CheckSettings()
		
		CLCDK:OptionsRefresh()
		if debugg then print("CLCDK:SetLocationDefault Done")end
	end
	
	--Set all settings back to default
	function CLCDK:SetDefaults()
		if CLCDK_Settings ~= nil then wipe(CLCDK_Settings); CLCDK_Settings = nil end
		CLCDK:CheckSettings()
		
		CLCDK:OptionsRefresh()
		if debugg then print("CLCDK:SetDefaults Done")end
	end
	
	function CLCDK_Rune_DD_OnLoad()
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_RUNE_ORDER[BBUUFF]	
		info.value      = BBUUFF
		info.func       = function() CLCDK_Settings.RuneOrder = BBUUFF; UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_RUNE_ORDER[BBFFUU]	
		info.value      = BBFFUU
		info.func       = function() CLCDK_Settings.RuneOrder = BBFFUU; UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_RUNE_ORDER[UUBBFF]	
		info.value      = UUBBFF
		info.func       = function() CLCDK_Settings.RuneOrder = UUBBFF; UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_RUNE_ORDER[UUFFBB]	
		info.value      = UUFFBB
		info.func       = function() CLCDK_Settings.RuneOrder = UUFFBB; UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_RUNE_ORDER[FFUUBB]	
		info.value      = FFUUBB
		info.func       = function() CLCDK_Settings.RuneOrder = FFUUBB; UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_RUNE_ORDER[FFBBUU]	
		info.value      = FFBBUU
		info.func       = function() CLCDK_Settings.RuneOrder = FFBBUU; UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_Rune_DD, CLCDK_Settings.RuneOrder); end
		UIDropDownMenu_AddButton(info)
	end
	
	function CLCDK_DTPanel_Threat_OnLoad()
		info            = {}	
		info.text       = CLCDK_OPTIONS_DT_THREAT_OFF	
		info.value      = THREAT_OFF
		info.func       = function() CLCDK_Settings.DT.Threat = THREAT_OFF;UIDropDownMenu_SetSelectedValue(CLCDK_DTPanel_DD_Threat, CLCDK_Settings.DT.Threat); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_DT_THREAT_ANALOG
		info.value      = THREAT_ANALOG
		info.func       = function() CLCDK_Settings.DT.Threat = THREAT_ANALOG;UIDropDownMenu_SetSelectedValue(CLCDK_DTPanel_DD_Threat, CLCDK_Settings.DT.Threat); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_DT_THREAT_DIGITAL
		info.value      = THREAT_DIGITAL
		info.func       = function() CLCDK_Settings.DT.Threat = THREAT_DIGITAL;UIDropDownMenu_SetSelectedValue(CLCDK_DTPanel_DD_Threat, CLCDK_Settings.DT.Threat); end
		UIDropDownMenu_AddButton(info)
	end
	
	--function to handle the View dropdown box
	function CLCDK_FramePanel_ViewDD_OnLoad()
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_VIEW_NORM	
		info.value      = CLCDK_OPTIONS_FRAME_VIEW_NORM
		info.func       = function() CLCDK_Settings.VScheme = CLCDK_OPTIONS_FRAME_VIEW_NORM;UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_ViewDD, CLCDK_Settings.VScheme); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_VIEW_TARGET
		info.value      = CLCDK_OPTIONS_FRAME_VIEW_TARGET
		info.func       = function() CLCDK_Settings.VScheme = CLCDK_OPTIONS_FRAME_VIEW_TARGET;UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_ViewDD, CLCDK_Settings.VScheme); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_VIEW_SHOW
		info.value      = CLCDK_OPTIONS_FRAME_VIEW_SHOW
		info.func       = function() CLCDK_Settings.VScheme = CLCDK_OPTIONS_FRAME_VIEW_SHOW;UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_ViewDD, CLCDK_Settings.VScheme); end
		UIDropDownMenu_AddButton(info)
		
		info            = {}	
		info.text       = CLCDK_OPTIONS_FRAME_VIEW_HIDE
		info.value      = CLCDK_OPTIONS_FRAME_VIEW_HIDE
		info.func       = function() CLCDK_Settings.VScheme = CLCDK_OPTIONS_FRAME_VIEW_HIDE;UIDropDownMenu_SetSelectedValue(CLCDK_FramePanel_ViewDD, CLCDK_Settings.VScheme); end
		UIDropDownMenu_AddButton(info)	
	end
	
	--function to handle the Disease dropdown box
	function CLCDK_Diseases_OnLoad(self)	
		info = {}	
		info.text = CLCDK_OPTIONS_CDR_DISEASES_DD_BOTH
		info.value = DISEASE_BOTH
		info.func = function() CLCDK_Settings.CD[Current_Spec].DiseaseOption = DISEASE_BOTH;UIDropDownMenu_SetSelectedValue(CLCDK_CDRPanel_Diseases_DD,  CLCDK_Settings.CD[Current_Spec].DiseaseOption); end
		UIDropDownMenu_AddButton(info)	
		
		info = {}	
		info.text = CLCDK_OPTIONS_CDR_DISEASES_DD_ONE
		info.value = DISEASE_ONE
		info.func = function() CLCDK_Settings.CD[Current_Spec].DiseaseOption = DISEASE_ONE;UIDropDownMenu_SetSelectedValue(CLCDK_CDRPanel_Diseases_DD,  CLCDK_Settings.CD[Current_Spec].DiseaseOption); end
		UIDropDownMenu_AddButton(info)
		
		info = {}	
		info.text = CLCDK_OPTIONS_CDR_DISEASES_DD_NONE
		info.value = DISEASE_NONE
		info.func = function() CLCDK_Settings.CD[Current_Spec].DiseaseOption = DISEASE_NONE;UIDropDownMenu_SetSelectedValue(CLCDK_CDRPanel_Diseases_DD,  CLCDK_Settings.CD[Current_Spec].DiseaseOption); end
		UIDropDownMenu_AddButton(info)			
	end

	--function to handle the CD dropdown boxes
	function CLCDK_CDRPanel_DD_OnLoad(self, level)
		--If specified level, or base
		level = level or 1
		
		--Template for an item in the dropdown box
		local function CLCDK_CDRPanel_DD_Item (panel, spell, buff)	
			info = {}
			info.text = spell .. ((buff and " (Buff)") or "")	
			info.value = spell .. ((buff and " (Buff)") or "")
			info.func = function() 
				CLCDK_Settings.CD[Current_Spec][panel:GetName()][1] = spell 
				CLCDK_Settings.CD[Current_Spec][panel:GetName()][2] = buff
				UIDropDownMenu_SetSelectedValue(panel, spell .. ((buff and " (Buff)") or "")) 	
				CloseDropDownMenus()	
			end
			return info
		end	
		
		--Function to add specs specific CDs
		local function AddSpecCDs(Spec)
			for i = 1, #Spec do
				if (Cooldowns.Buffs[Spec[i]] == nil or Cooldowns.Buffs[Spec[i]][2]) then
					UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, Spec[i]), 2)
				end	
				if Cooldowns.Buffs[Spec[i]] ~= nil then
					UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, Spec[i], true), 2)			
				end
			end			
		end
		
		--If base level
		if level == 1 then
			--Add unique items to dropdown
			UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, CLCDK_OPTIONS_CDR_CD_PRIORITY), 1)
			UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, CLCDK_OPTIONS_CDR_CD_PRESENCE), 1)
			UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, CLCDK_OPTIONS_FRAME_VIEW_NONE), 1)
			UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, CLCDK_OPTIONS_CDR_RACIAL), 1)
			
			--Setup nested dropdowns
			info.hasArrow = true
			info.notClickable = 1
			
			--Spec Specific CDs		
			info.text = CLCDK_OPTIONS_CDR_CD_SPEC
			info.value = {["Level1_Key"] = "Spec";}
			UIDropDownMenu_AddButton(info)
			
			--Normal CDs		
			info.text = CLCDK_OPTIONS_CDR_CD_NORMAL
			info.value = {["Level1_Key"] = "Normal";}
			UIDropDownMenu_AddButton(info)	

			--Moves 	
			info.text = CLCDK_OPTIONS_CDR_CD_MOVES
			info.value = {["Level1_Key"] = "Moves";}
			UIDropDownMenu_AddButton(info)				
			
			--Tier Buffs		
			info.text = CLCDK_OPTIONS_CDR_CD_TIER			
			info.value = {["Level1_Key"] = "Tier";}
			UIDropDownMenu_AddButton(info)	
			
			--Trinkets		
			info.text = CLCDK_OPTIONS_CDR_CD_TRINKETS		
			info.value = {["Level1_Key"] = "Trinkets";}
			UIDropDownMenu_AddButton(info)	
			
		--If nested menu
		elseif level == 2 then
			--Check what the "parent" is
			local key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"]
			
			if key == "Spec" then
				if (Current_Spec == SPEC_UNHOLY) then
					AddSpecCDs(Cooldowns.UnholyCDs)	
				elseif (Current_Spec == SPEC_FROST) then
					AddSpecCDs(Cooldowns.FrostCDs)
				elseif (Current_Spec == SPEC_BLOOD) then
					AddSpecCDs(Cooldowns.BloodCDs)
				end	
				
			elseif key == "Normal" then
				AddSpecCDs(Cooldowns.NormCDs)
				
			elseif key == "Moves" then	
				for i = 1, #Cooldowns.Moves do		
					if GetSpellTexture(Cooldowns.Moves[i]) ~= nil then
						UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, Cooldowns.Moves[i]), 2)			
					end
				end
				
			elseif key == "Tier" then		
				info.hasArrow = false
			
				info.text = "==T9=="
				info.isTitle  = 1
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info, 2)					
				UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, spells["T9 2pc"], true), 2)
				
				info.text = "==T10=="
				info.isTitle = 1
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info, 2)
				UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, spells["T10 4pc"], true), 2)
			
				info.text = "==T11=="
				info.isTitle  = 1
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info, 2)
				UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, spells["T11 4pc"], true), 2)
				
			elseif key == "Trinkets" then		
				UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT1), 2)
				UIDropDownMenu_AddButton(CLCDK_CDRPanel_DD_Item(self, CLCDK_OPTIONS_CDR_CD_TRINKETS_SLOT2), 2)
			end
		end
	end	
	
else
	if debugg then print("CLCDK: Not a DK")end
	debugg = nil
	CLCDK_Options = nil
	CLCDK_FramePanel = nil
	CLCDK_CDRPanel = nil
	CLCDK_CDPanel = nil
	CLCDK_ABOUTPanel = nil
end