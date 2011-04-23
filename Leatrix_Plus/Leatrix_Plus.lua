----------------------------------------------------------------------
-- 	Leatrix Plus 4.21
-- 	Last updated: 23rd April 2011
----------------------------------------------------------------------

----------------------------------------------------------------------
-- 	Script code
----------------------------------------------------------------------

-- 	Create tables to store configuration
	if not LeaPlusOptionsDB then LeaPlusOptionsDB = {} end
	local LeaPlusOptionsLC = {}

--	Initialise variables
	local r, g, b = 1.0, 0.85, 0.0
	local orig_OpenBackpack = OpenBackpack;
	local orig_CloseBackpack = CloseBackpack;
	local Leatrix_Script = UIErrorsFrame:GetScript('OnEvent')

--	Create frame so we can watch events
	local frame = CreateFrame("FRAME", "Leatrix_Plus");
	frame:RegisterEvent("ADDON_LOADED");
	frame:RegisterEvent("PLAYER_LOGOUT");
	frame:RegisterEvent("UPDATE_CHAT_WINDOWS")

----------------------------------------------------------------------
--	Chat filters
----------------------------------------------------------------------

--	Duel spam filter
	local function LeaPlusDuelFilter(arg1,arg2,msg)
		-- Do nothing if your name is mentioned
		if (UnitName("player")) and (msg:find(UnitName("player"))) then
			return
		end
		-- Block messages involving duels
		if (msg:find("has defeated")) then return true end
		if (msg:find("has fled from")) then return true	end
	end

--	Dual spec filter
	local function LeaPlusTalentFilter(arg1,arg2,msg)
		-- Block messages involving dual spec
		if (msg:find(string.gsub(ERR_LEARN_ABILITY_S:gsub('%.', '%.'), '%%s', '(.*)'))) then return true end
		if (msg:find(string.gsub(ERR_LEARN_SPELL_S:gsub('%.', '%.'), '%%s', '(.*)'))) then return true end
		if (msg:find(string.gsub(ERR_SPELL_UNLEARNED_S:gsub('%.', '%.'), '%%s', '(.*)'))) then return true end
	end

----------------------------------------------------------------------
--	Functions
----------------------------------------------------------------------

-- 	Show button tooltips
	local function ShowTooltip(self)
		if self.tiptext then
			GameTooltip:SetOwner(self, "ANCHOR_TOP")
			GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
		end
	end

-- 	Hide button tooltips
	local function HideTooltip() 
		GameTooltip:Hide() 
	end

--	Check if a player name is in your friends list
	local function LeaPlusFriendCheck(LeaListName)
		for i = 1, GetNumFriends() do
			if (LeaListName == GetFriendInfo(i)) then
				return true
			end
		end
		return false;
	end

----------------------------------------------------------------------
--	Do It Now!
----------------------------------------------------------------------

--	Quest size update (when changing slider)
	local function LeaPlusQuestSizeUpdate()
		if LeaPlusOptionsLC["LeaPlusQuestFont"] == "On" then
			SystemFont_Med1:SetFont(SystemFont_Med1:GetFont(), LeaPlusOptionsLC["LeaPlusQuestSize"], nil);
			SystemFont_Med2:SetFont(SystemFont_Med2:GetFont(), LeaPlusOptionsLC["LeaPlusQuestSize"]+1, nil);	
			QuestFont_Shadow_Huge:SetFont(QuestFont_Shadow_Huge:GetFont(), (LeaPlusOptionsLC["LeaPlusQuestSize"]+6), nil);
		elseif LeaPlusOptionsLC["LeaPlusQuestFont"] == "Off" then
			SystemFont_Med1:SetFont(SystemFont_Med1:GetFont(), 12, nil);
			SystemFont_Med2:SetFont(SystemFont_Med2:GetFont(), 13, nil);	
			QuestFont_Shadow_Huge:SetFont(QuestFont_Shadow_Huge:GetFont(), 18, nil);
		end
	end

--	The Do It Now bit
	local function DoItNow(frame)

		-- Bag automation
		function OpenBackpack(...)
			if LeaPlusOptionsLC["LeaPlusDisBP"] == "On" then
				return
			else
				return orig_OpenBackpack(...);
			end
		end

		function CloseBackpack(...)
			if LeaPlusOptionsLC["LeaPlusDisBP"] == "On" then
				return
			else
				return orig_CloseBackpack(...);
			end
		end

		-- Automatic resurrection
		if LeaPlusOptionsLC["LeaPlusNormalRes"] == "On" then
			frame:RegisterEvent("RESURRECT_REQUEST");
		else
			frame:UnregisterEvent("RESURRECT_REQUEST");
		end

		-- Block duel messages
		if LeaPlusOptionsLC["LeaPlusDuelMessage"] == "On" then
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", LeaPlusDuelFilter)
		else
			ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", LeaPlusDuelFilter)
		end

		-- Block dual-spec spam
		if LeaPlusOptionsLC["LeaPlusDualSpec"] == "On" then
			frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", LeaPlusTalentFilter)
		else
			frame:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
			ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", LeaPlusTalentFilter)
		end

		-- Disable death effect
		if LeaPlusOptionsLC["LeaPlusDeathEffect"] == "On" then
			SetCVar("ffxDeath", "0")
		else
			SetCVar("ffxDeath", "1")
		end

		-- Disable netherworld effect
		if LeaPlusOptionsLC["LeaPlusNetherEffect"] == "On" then
			SetCVar("ffxNetherWorld", "0")
		else
			SetCVar("ffxNetherWorld", "1")
		end

		-- Disable full-screen glow
		if LeaPlusOptionsLC["LeaPlusGlowEffect"] == "On" then
			SetCVar("ffxGlow", "0")
		else
			SetCVar("ffxGlow", "1")
		end

		-- Block duels
		if LeaPlusOptionsLC["LeaPlusDeclineDuel"] == "On" then
			frame:RegisterEvent("DUEL_REQUESTED");
		else
			frame:UnregisterEvent("DUEL_REQUESTED");
		end

		-- Block guild petitions
		if LeaPlusOptionsLC["LeaPlusClosePetition"] == "On" then
			frame:RegisterEvent("PETITION_SHOW");
		else
			frame:UnregisterEvent("PETITION_SHOW");
		end

		-- Block party invites
		if LeaPlusOptionsLC["LeaPlusDeclineParty"] == "On" then
			frame:RegisterEvent("PARTY_INVITE_REQUEST");
		else
			frame:UnregisterEvent("PARTY_INVITE_REQUEST");
		end

		-- Player chains
		if LeaPlusOptionsLC["LeaPlusPlayerGold"] == "On" then
			PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite.blp");
		else
			PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame.blp");
		end

		-- Zone text
		if LeaPlusOptionsLC["LeaPlusZoneText"] == "On" then
			ZoneTextFrame:SetScript("OnShow", function() ZoneTextFrame:Hide() end)
		else
			ZoneTextFrame:SetScript("OnShow", function() ZoneTextFrame:Show() end)
		end

		-- Subzone text
		if LeaPlusOptionsLC["LeaPlusSubzoneText"] == "On" then
			SubZoneTextFrame:SetScript("OnShow", function() SubZoneTextFrame:Hide() end)
		else
			SubZoneTextFrame:SetScript("OnShow", function() SubZoneTextFrame:Show() end)
		end

		-- Old chat style
		if LeaPlusOptionsLC["LeaPlusOldChat"] == "On" then
			ChatTypeInfo['WHISPER']['sticky'] = 0
			ChatTypeInfo['BN_WHISPER']['sticky'] = 0
		else
			ChatTypeInfo['WHISPER']['sticky'] = 1
			ChatTypeInfo['BN_WHISPER']['sticky'] = 1
		end

	LeaPlusQuestSizeUpdate();

	end

----------------------------------------------------------------------
-- 	Default Events
----------------------------------------------------------------------

	local function eventHandler(frame, event, arg1)

		-- Load saved variables or set to default if none exist
		if (event == "ADDON_LOADED" and arg1 == "Leatrix_Plus") then
			if LeaPlusOptionsDB["LeaPlusDeathEffect"] 		== nil then LeaPlusOptionsLC["LeaPlusDeathEffect"] 		= "On"	else LeaPlusOptionsLC["LeaPlusDeathEffect"] 	= LeaPlusOptionsDB["LeaPlusDeathEffect"] 	end 
			if LeaPlusOptionsDB["LeaPlusDeclineDuel"] 		== nil then LeaPlusOptionsLC["LeaPlusDeclineDuel"] 		= "On" 	else LeaPlusOptionsLC["LeaPlusDeclineDuel"] 	= LeaPlusOptionsDB["LeaPlusDeclineDuel"] 	end 
			if LeaPlusOptionsDB["LeaPlusClosePetition"] 	== nil then LeaPlusOptionsLC["LeaPlusClosePetition"] 	= "On"  else LeaPlusOptionsLC["LeaPlusClosePetition"]	= LeaPlusOptionsDB["LeaPlusClosePetition"] 	end 
			if LeaPlusOptionsDB["LeaPlusDeclineParty"] 		== nil then LeaPlusOptionsLC["LeaPlusDeclineParty"] 	= "Off" else LeaPlusOptionsLC["LeaPlusDeclineParty"] 	= LeaPlusOptionsDB["LeaPlusDeclineParty"] 	end 
			if LeaPlusOptionsDB["LeaPlusNormalRes"] 		== nil then LeaPlusOptionsLC["LeaPlusNormalRes"] 		= "Off"	else LeaPlusOptionsLC["LeaPlusNormalRes"] 		= LeaPlusOptionsDB["LeaPlusNormalRes"] 		end 
			if LeaPlusOptionsDB["LeaPlusDuelMessage"] 		== nil then LeaPlusOptionsLC["LeaPlusDuelMessage"] 		= "On"	else LeaPlusOptionsLC["LeaPlusDuelMessage"] 	= LeaPlusOptionsDB["LeaPlusDuelMessage"] 	end 
			if LeaPlusOptionsDB["LeaPlusDualSpec"] 			== nil then LeaPlusOptionsLC["LeaPlusDualSpec"] 		= "On"	else LeaPlusOptionsLC["LeaPlusDualSpec"] 		= LeaPlusOptionsDB["LeaPlusDualSpec"] 		end 
			if LeaPlusOptionsDB["LeaPlusDisBP"] 			== nil then LeaPlusOptionsLC["LeaPlusDisBP"] 			= "On"	else LeaPlusOptionsLC["LeaPlusDisBP"] 			= LeaPlusOptionsDB["LeaPlusDisBP"] 			end 
			if LeaPlusOptionsDB["LeaPlusPlayerGold"] 		== nil then LeaPlusOptionsLC["LeaPlusPlayerGold"] 		= "On"	else LeaPlusOptionsLC["LeaPlusPlayerGold"] 		= LeaPlusOptionsDB["LeaPlusPlayerGold"] 	end 
			if LeaPlusOptionsDB["LeaPlusGlowEffect"] 		== nil then LeaPlusOptionsLC["LeaPlusGlowEffect"] 		= "Off"	else LeaPlusOptionsLC["LeaPlusGlowEffect"] 		= LeaPlusOptionsDB["LeaPlusGlowEffect"] 	end 
			if LeaPlusOptionsDB["LeaPlusNetherEffect"] 		== nil then LeaPlusOptionsLC["LeaPlusNetherEffect"] 	= "On"	else LeaPlusOptionsLC["LeaPlusNetherEffect"] 	= LeaPlusOptionsDB["LeaPlusNetherEffect"] 	end 
			if LeaPlusOptionsDB["LeaPlusZoneText"] 			== nil then LeaPlusOptionsLC["LeaPlusZoneText"] 		= "On"	else LeaPlusOptionsLC["LeaPlusZoneText"] 		= LeaPlusOptionsDB["LeaPlusZoneText"] 		end 
			if LeaPlusOptionsDB["LeaPlusSubzoneText"] 		== nil then LeaPlusOptionsLC["LeaPlusSubzoneText"] 		= "On"	else LeaPlusOptionsLC["LeaPlusSubzoneText"] 	= LeaPlusOptionsDB["LeaPlusSubzoneText"] 	end 
			if LeaPlusOptionsDB["LeaPlusErrorMsg"] 			== nil then LeaPlusOptionsLC["LeaPlusErrorMsg"] 		= "On"	else LeaPlusOptionsLC["LeaPlusErrorMsg"] 		= LeaPlusOptionsDB["LeaPlusErrorMsg"] 		end 
			if LeaPlusOptionsDB["LeaPlusInfoMsg"] 			== nil then LeaPlusOptionsLC["LeaPlusInfoMsg"] 			= "Off"	else LeaPlusOptionsLC["LeaPlusInfoMsg"] 		= LeaPlusOptionsDB["LeaPlusInfoMsg"] 		end 
			if LeaPlusOptionsDB["LeaPlusQuestFont"] 		== nil then LeaPlusOptionsLC["LeaPlusQuestFont"] 		= "Off"	else LeaPlusOptionsLC["LeaPlusQuestFont"] 		= LeaPlusOptionsDB["LeaPlusQuestFont"] 		end 
			if LeaPlusOptionsDB["LeaPlusQuestSize"] 		== nil then LeaPlusOptionsLC["LeaPlusQuestSize"] 		= "12"	else LeaPlusOptionsLC["LeaPlusQuestSize"] 		= LeaPlusOptionsDB["LeaPlusQuestSize"] 		end 
			if LeaPlusOptionsDB["LeaPlusOldChat"] 			== nil then LeaPlusOptionsLC["LeaPlusOldChat"]	 		= "On"	else LeaPlusOptionsLC["LeaPlusOldChat"] 		= LeaPlusOptionsDB["LeaPlusOldChat"] 		end 

			UIParentLoadAddOn("Blizzard_DebugTools")
			DEFAULT_CHAT_FRAME:AddMessage("Leatrix Plus loaded successfully.", 1.0,0.85,0.0)
			wipe(LeaPlusOptionsDB)
			DoItNow(frame);
		end

		-- Save locals back to globals on logout
		if (event == "PLAYER_LOGOUT") then
			LeaPlusOptionsDB["LeaPlusDeathEffect"] 		= LeaPlusOptionsLC["LeaPlusDeathEffect"]
			LeaPlusOptionsDB["LeaPlusDeclineDuel"] 		= LeaPlusOptionsLC["LeaPlusDeclineDuel"]
			LeaPlusOptionsDB["LeaPlusClosePetition"]	= LeaPlusOptionsLC["LeaPlusClosePetition"]
			LeaPlusOptionsDB["LeaPlusDeclineParty"]	 	= LeaPlusOptionsLC["LeaPlusDeclineParty"]
			LeaPlusOptionsDB["LeaPlusNormalRes"] 		= LeaPlusOptionsLC["LeaPlusNormalRes"]
			LeaPlusOptionsDB["LeaPlusDuelMessage"] 		= LeaPlusOptionsLC["LeaPlusDuelMessage"]
			LeaPlusOptionsDB["LeaPlusDualSpec"] 		= LeaPlusOptionsLC["LeaPlusDualSpec"]
			LeaPlusOptionsDB["LeaPlusDisBP"] 			= LeaPlusOptionsLC["LeaPlusDisBP"]
			LeaPlusOptionsDB["LeaPlusPlayerGold"] 		= LeaPlusOptionsLC["LeaPlusPlayerGold"]
			LeaPlusOptionsDB["LeaPlusGlowEffect"] 		= LeaPlusOptionsLC["LeaPlusGlowEffect"]
			LeaPlusOptionsDB["LeaPlusNetherEffect"] 	= LeaPlusOptionsLC["LeaPlusNetherEffect"]
			LeaPlusOptionsDB["LeaPlusZoneText"] 		= LeaPlusOptionsLC["LeaPlusZoneText"]
			LeaPlusOptionsDB["LeaPlusSubzoneText"] 		= LeaPlusOptionsLC["LeaPlusSubzoneText"]
			LeaPlusOptionsDB["LeaPlusErrorMsg"] 		= LeaPlusOptionsLC["LeaPlusErrorMsg"]
			LeaPlusOptionsDB["LeaPlusInfoMsg"] 			= LeaPlusOptionsLC["LeaPlusInfoMsg"]
			LeaPlusOptionsDB["LeaPlusQuestFont"] 		= LeaPlusOptionsLC["LeaPlusQuestFont"]
			LeaPlusOptionsDB["LeaPlusQuestSize"] 		= LeaPlusOptionsLC["LeaPlusQuestSize"]
			LeaPlusOptionsDB["LeaPlusOldChat"] 			= LeaPlusOptionsLC["LeaPlusOldChat"]
		end

----------------------------------------------------------------------
--	Plus events
----------------------------------------------------------------------

		-- Automatic resurrection
		if event == "RESURRECT_REQUEST" then
			AcceptResurrect();
			StaticPopup_Hide("RESURRECT_NO_TIMER");
		end

		-- Check for talent switch function
		if event == "ACTIVE_TALENT_GROUP_CHANGED" then
			DEFAULT_CHAT_FRAME:AddMessage("Talent spec changed.", 1.0,0.85,0.0)
		end

		-- Block duels
		if event == "DUEL_REQUESTED" and not LeaPlusFriendCheck(arg1) then
			CancelDuel();
			StaticPopup_Hide("DUEL_REQUESTED");
		end

		-- Block guild pettitions
		if event == "PETITION_SHOW" and not LeaPlusFriendCheck(arg1) then
			ClosePetition();
		end

		-- Block party invites
		if event == "PARTY_INVITE_REQUEST" and not LeaPlusFriendCheck(arg1) then
			DeclineGroup(); 
			StaticPopup_Hide("PARTY_INVITE");
		end

	end

----------------------------------------------------------------------
--	Error events
----------------------------------------------------------------------

	local function ErrEventHandler(self, event, LeaPlusError, ...)

		-- Handle error messages
		if event == "UI_ERROR_MESSAGE" then
			if LeaPlusOptionsLC["LeaPlusErrorMsg"] == "On" then
				if (LeaPlusError == "Inventory is full." or LeaPlusError == "Your quest log is full.") then 
					return Leatrix_Script(self, event, LeaPlusError, ...) 
				end
			elseif LeaPlusOptionsLC["LeaPlusErrorMsg"] == "Off" then
				return Leatrix_Script(self, event, LeaPlusError, ...) 
			end
		end

		-- Handle system messages
		if event == 'SYSMSG' then
			if LeaPlusOptionsLC["LeaPlusInfoMsg"] == "On" then
				return
		else
				return Leatrix_Script(self, event, LeaPlusError, ...)
			end
		end

		-- Handle information messages
		if event == 'UI_INFO_MESSAGE' then
			if LeaPlusOptionsLC["LeaPlusInfoMsg"] == "On" then
				return
			else
				return Leatrix_Script(self, event, LeaPlusError, ...)
			end
		end

	end

--	Register event handler
	frame:SetScript("OnEvent", eventHandler);
	UIErrorsFrame:SetScript('OnEvent', ErrEventHandler)

----------------------------------------------------------------------
-- Slash commands
----------------------------------------------------------------------

--	Slash command handler
	local function slashCommand(str)
		if str == '' then
			InterfaceOptionsFrame_OpenToCategory("Leatrix Plus");
		elseif str == 'help' then DEFAULT_CHAT_FRAME:AddMessage("Leatrix Plus\n/lp - Show options panel\n/lp hiderc - Hide Choose your Role window\n/lp timer - Show dungeon cooldown\n/lp toggle - Toggle hiding errors\n/lp frame - Toggle frame Information\n/lp reload - Reload the UI\n/lp restart - Restart the graphics engine", r,g,b)
		elseif str == "hiderc" then
			LFDRoleCheckPopup:Hide()
		elseif str == "frame" then
			FrameStackTooltip_Toggle();
		elseif str == "reload" then
			ReloadUI();
		elseif str == "restart" then
			RestartGx();
		elseif str == "toggle" then
			if LeaPlusOptionsLC["LeaPlusErrorMsg"] == "Off" then
				LeaPlusOptionsLC["LeaPlusErrorMsg"] = "On"
				DEFAULT_CHAT_FRAME:AddMessage("Error messages will now be hidden.",  r,g,b)
			elseif LeaPlusOptionsLC["LeaPlusErrorMsg"] == "On" then
				LeaPlusOptionsLC["LeaPlusErrorMsg"] = "Off"
				DEFAULT_CHAT_FRAME:AddMessage("Error messages will now be shown.",  r,g,b)
			end
		elseif str == "timer" then
			if LFDQueueFrameCooldownFrame:IsShown() then
				LFDQueueFrameCooldownFrame:Hide();
			else
				LFDQueueFrameCooldownFrame:Show();
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Invalid command.  Type '/lp help' for help.",  r,g,b)
		end
	end

--	Slash command support
	SLASH_Leatrix_Plus1 = '/lp'
	SlashCmdList["Leatrix_Plus"] = function(str) slashCommand(string.lower(str)) end
	
----------------------------------------------------------------------
-- 	Options panel
----------------------------------------------------------------------
	
-- 	Define the options panel
	local LeaPlusOptionsPanel = CreateFrame('Frame', 'Leatrix_Plus_Options', UIParent)

	function LeaPlusOptionsPanel:OptionsPanel()
		self.name = "Leatrix Plus"

		local function OptionsTitle(title,subtitle)
			local text = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			text:SetPoint('TOPLEFT', 16, -16)
			text:SetText(title)

			local subtext = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
			subtext:SetHeight(32)
			subtext:SetPoint('TOPLEFT', text, 'BOTTOMLEFT', 0, -8)
			subtext:SetPoint('RIGHT', self, -32, 0)
			subtext:SetNonSpaceWrap(true)
			subtext:SetJustifyH('LEFT')
			subtext:SetJustifyV('TOP')
			subtext:SetText(subtitle)
		end
 
		local function OptionsText(title,x,y)
			local text = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			text:SetPoint("TOPLEFT",x,y)
			text:SetText(title)
		end
	 
		-- Define slider control
		local function LeaSlider(LeaPlusSliderName,field,caption,low, high, step, x,y, form, LeaPlusSliderLText, LeaPlusSliderRText)
			local function slider_OnMouseWheel(self, arg1)
				local step = self:GetValueStep() * arg1
				local value = self:GetValue()
				local minVal, maxVal = self:GetMinMaxValues()
				if step > 0 then
					self:SetValue(min(value+step, maxVal))
				else
					self:SetValue(max(value+step, minVal))
				end
			end

			local LeaPlusSliderName = CreateFrame('slider', field, LeaPlusOptionsPanel, 'OptionssliderTemplate')
			getglobal(LeaPlusSliderName:GetName() .. 'Text'):SetText(caption)

			LeaPlusSliderName:SetScript('OnShow', function(self)
				self.onShow = true
				self:SetValue(LeaPlusOptionsLC[field])
				self.onShow = nil
			end)

			-- Change the value when you drag the slider
			LeaPlusSliderName:SetScript('OnValueChanged', function(self, value)
				self.valText:SetText(format(form, value))
				LeaPlusOptionsLC[field] = value
				LeaPlusQuestSizeUpdate();
			end)

			-- Setup slider layout
			LeaPlusSliderName:SetMinMaxValues(low, high)
			LeaPlusSliderName:SetValueStep(step)
			LeaPlusSliderName:EnableMouseWheel(true)
			LeaPlusSliderName:SetScript('OnMouseWheel', slider_OnMouseWheel)
			LeaPlusSliderName:SetPoint('TOPLEFT', x,y)
			LeaPlusSliderName.tooltipText = "Drag the slider."
			--getglobal(LeaPlusSliderName:GetName() .. 'Text'):SetText('Slider');
			getglobal(LeaPlusSliderName:GetName() .. 'Low'):SetText(LeaPlusSliderLText);
			getglobal(LeaPlusSliderName:GetName() .. 'High'):SetText(LeaPlusSliderRText);
			LeaPlusSliderName:SetWidth(100)
			LeaPlusSliderName:SetHeight(20)

			-- Show text value next to the slider
			local text = LeaPlusSliderName:CreateFontString(nil, 'BACKGROUND')
			text:SetFontObject('GameFontHighlight')
			text:SetPoint('LEFT', LeaPlusSliderName, 'RIGHT', 12, 0)
			LeaPlusSliderName.valText = text
			text:SetText(string.format("%.2f", LeaPlusSliderName:GetValue()))
		end

		-- Define Checkbox control
		local function LeaPlusCheckbox(field,caption,x,y,tip)
			local checkbox = CreateFrame('CheckButton', field, self, 'ChatConfigCheckButtonTemplate')
			getglobal(checkbox:GetName() .. 'Text'):SetText(caption)
			checkbox:SetScript('OnShow', function(self) self:SetChecked(LeaPlusOptionsLC[field]) end)
			checkbox:SetScript('OnClick', function(self)
				if checkbox:GetChecked() == nil then
					LeaPlusOptionsLC[field] = "Off"
				elseif checkbox:GetChecked() == 1 then
					if field == "backsame" and checkbox:GetChecked() == "On" and not (LeaPlusOptionsLC["backdrop"] == "On") then return end
					LeaPlusOptionsLC[field] = "On"
				end
				DoItNow(frame);
			end)
			checkbox:SetPoint("TOPLEFT",x, y)
			checkbox.tooltip = tip;
		end

		-- Populate the options panel
		OptionsTitle("Leatrix Plus",(select(3, GetAddOnInfo("Leatrix_Plus"))));

		OptionsText("Blockers", 16, -72);
		LeaPlusCheckbox("LeaPlusDeclineDuel", 	"Block duels",	 				16, -92, 	"If checked, duel requests will be blocked unless the player requesting the duel is in your friends list.")
		LeaPlusCheckbox("LeaPlusClosePetition", "Block guild petitions",		16, -112, 	"If checked, guild petition signature requests will be blocked unless the player requesting the signature is in your friends list.")
		LeaPlusCheckbox("LeaPlusDeclineParty", 	"Block party invites", 			16, -132, 	"If checked, party invitations will be blocked unless the player inviting you is in your friends list.")

		OptionsText("Miscellaneous", 16, -172);
		LeaPlusCheckbox("LeaPlusDisBP", 		"Prevent bag automation",		16, -192, 	"If checked, bags will not be opened and closed automatically when using a vendor or mailbox, allowing you to open and close them freely at your command.")
		LeaPlusCheckbox("LeaPlusPlayerGold", 	"Show elite chain",				16, -212, 	"If checked, your player portrait will have an elite gold chain around it.")
		LeaPlusCheckbox("LeaPlusNormalRes",		"Automated resurrect", 			16, -232, 	"If checked, resurrection attempts cast on you will be automatically accepted.")

		OptionsText("Graphics", 16, -272);
		LeaPlusCheckbox("LeaPlusDeathEffect", 	"Hide death effect", 			16, -292, 	"If checked, the death effect (grey glow) will not be shown when you are a ghost.")
		LeaPlusCheckbox("LeaPlusNetherEffect", 	"Hide netherworld", 			16, -312, 	"If checked, the netherworld effect (such as mage Invisibility) will not be shown.")
		LeaPlusCheckbox("LeaPlusGlowEffect", 	"Remove screen glow", 			16, -332, 	"If checked, the screen glow will not be shown.  Note that checking this option will reduce overall graphics quality, but you can use it when required to hide the drunken haze (blurry screen).")

		OptionsText("Zone Text", 200, -72);
		LeaPlusCheckbox("LeaPlusZoneText",	 	"Hide zone text",				200, -92, 	"If checked, zone text will not be shown (eg. 'Ironforge').")
		LeaPlusCheckbox("LeaPlusSubzoneText", 	"Hide subzone text",			200, -112, 	"If checked, subzone text will not be shown (eg. 'Mystic Quarter').")

		OptionsText("Chat Frame", 200, -152);
		LeaPlusCheckbox("LeaPlusDuelMessage", 	"Hide duel messages", 			200, -172, 	"If checked, duel messages will be blocked unless you took part in the duel.")
		LeaPlusCheckbox("LeaPlusDualSpec", 		"Hide dual-spec spam", 			200, -192, 	"If checked, switching specs will not flood your chat window with dual-spec spam.")
		LeaPlusCheckbox("LeaPlusOldChat", 		"Use old chat style", 			200, -212, 	"If checked, you can press enter to talk in group chat using whatever method you used last (say, party, guild, etc).  To reply to whispers, press R as normal.")

		OptionsText("Error Frame", 200, -252);
		LeaPlusCheckbox("LeaPlusErrorMsg", 		"Hide error messages",		 	200, -272, 	"If checked, error messages (eg. 'Not enough rage') will not be shown in the error frame.  'Inventory is full' and 'Quest log is full' will be shown regardless of this setting.")
		LeaPlusCheckbox("LeaPlusInfoMsg", 		"Hide info messages", 			200, -292, 	"If checked, information and system messages (eg. quest updates) will not be shown in the error frame.")

		OptionsText("Text Size", 200, -332);
		LeaPlusCheckbox("LeaPlusQuestFont", 	"Resize quest log text", 		200, -352, 	"If checked, quest log text will be resized according to the value set by the slider.  This will also affect a few other windows.")
		LeaSlider("LeaPlusScaleSlider","LeaPlusQuestSize","",10, 36, 1, 200, -382,"%.0f", "10", "36")

		local LeaPlusDeflt = CreateFrame("Button", "LeaPlusDeflt", self, "UIPanelButtonTemplate") 
		LeaPlusDeflt:SetWidth(130)
		LeaPlusDeflt:SetHeight(25) 
		LeaPlusDeflt:SetAlpha(1.0)
		LeaPlusDeflt:SetPoint("BOTTOMLEFT", 10, 10)
		LeaPlusDeflt:SetText("Set Defaults") 
		LeaPlusDeflt:RegisterForClicks("AnyUp") 
		LeaPlusDeflt.tiptext = "Resets all the options back to the default settings."
		LeaPlusDeflt:SetScript("OnEnter", ShowTooltip)		
		LeaPlusDeflt:SetScript("OnLeave", HideTooltip)
		LeaPlusDeflt:SetScript("OnClick", function() 
			LeaPlusOptionsLC["LeaPlusDeathEffect"] 		= "On"
			LeaPlusOptionsLC["LeaPlusDeclineDuel"] 		= "On"
			LeaPlusOptionsLC["LeaPlusClosePetition"] 	= "On"
			LeaPlusOptionsLC["LeaPlusDeclineParty"] 	= "Off"
			LeaPlusOptionsLC["LeaPlusNormalRes"] 		= "Off"
			LeaPlusOptionsLC["LeaPlusDuelMessage"] 		= "On"
			LeaPlusOptionsLC["LeaPlusDualSpec"]			= "On"
			LeaPlusOptionsLC["LeaPlusDisBP"] 			= "On"
			LeaPlusOptionsLC["LeaPlusPlayerGold"] 		= "On"
			LeaPlusOptionsLC["LeaPlusGlowEffect"] 		= "Off"
			LeaPlusOptionsLC["LeaPlusNetherEffect"] 	= "On"
			LeaPlusOptionsLC["LeaPlusZoneText"] 		= "On"
			LeaPlusOptionsLC["LeaPlusSubzoneText"]	 	= "On"
			LeaPlusOptionsLC["LeaPlusErrorMsg"]	 		= "On"
			LeaPlusOptionsLC["LeaPlusInfoMsg"]	 		= "Off"
			LeaPlusOptionsLC["LeaPlusQuestFont"]		= "Off"
			LeaPlusOptionsLC["LeaPlusOldChat"]			= "On"

			DEFAULT_CHAT_FRAME:AddMessage("All settings have been reset.", r,g,b)
			LeaPlusOptionsPanel:Hide();
			LeaPlusOptionsPanel:Show();
			DoItNow(frame);
		end)

		-- Add panel to interface options    
		InterfaceOptions_AddCategory(self) 
	end

		local LeaPlusTimer = CreateFrame("Button", "LeaPlusTimer", LFDQueueFrame, "UIPanelButtonTemplate") 
		LeaPlusTimer:SetWidth(40)
		LeaPlusTimer:SetHeight(25) 
		LeaPlusTimer:SetAlpha(1.0)
		LeaPlusTimer:SetPoint("TOPLEFT", 30, -128)
		LeaPlusTimer:SetText("Time") 
		LeaPlusTimer:RegisterForClicks("AnyUp") 
		LeaPlusTimer.tiptext = "Toggles showing your random dungeon cooldown if the rewards window is showing.\n\nThis button has no effect if the rewards window is not showing."
		LeaPlusTimer:SetScript("OnEnter", ShowTooltip)		
		LeaPlusTimer:SetScript("OnLeave", HideTooltip)
		LeaPlusTimer:SetScript("OnClick", function() 
			if LFDQueueFrameCooldownFrame:IsShown() then
				LFDQueueFrameCooldownFrame:Hide();
			else
				LFDQueueFrameCooldownFrame:Show();
			end
		end)

	-- 	Show panel
	LeaPlusOptionsPanel:OptionsPanel();
