-- Don't bother nonrogues with this
if ( select( 2, UnitClass( "player" ) ) ~= "ROGUE" ) then
	Poisonous_Config = nil
	return
end

local _G = _G
local BuyMerchantItem = _G.BuyMerchantItem
local GetMerchantItemLink = _G.GetMerchantItemLink
local GetMerchantNumItems = _G.GetMerchantNumItems
local select = _G.select
local strfind = _G.strfind
local tonumber = _G.tonumber
local UnitLevel = _G.UnitLevel

Poisonous = select( 2, ... )
Poisonous.CurrentPoisons = {}

SLASH_POISONOUS1 = "/poisonous"
SLASH_POISONOUS2 = "/poisons"
SLASH_POISONOUS3 = "/poison"

local POISON_STACK_SIZE = 20
local CRIPPLING = "CRIPPLING"
local DEADLY = "DEADLY"
local INSTANT = "INSTANT"
local MINDNUMBING = "MINDNUMBING"
local WOUND = "WOUND"

Poisonous.PoisonBarSequences = {
	[INSTANT] = { INSTANT, DEADLY, WOUND, CRIPPLING, MINDNUMBING },
	[WOUND] = { WOUND, DEADLY, INSTANT, CRIPPLING, MINDNUMBING },
}

Poisonous.Poisons = {
	CRIPPLING = {
		name = "Crippling Poison",
		icon = "Interface\\Icons\\Ability_PoisonSting",
		buffPattern = "crippling poison",
		symbol = "C",
		color = { r = 1.0, g = 1.0, b = 1.0 },
		{ level = 20, itemID =  3775 },
	},
	DEADLY = {
		name = "Deadly Poison",
		icon = "Interface\\Icons\\Ability_Rogue_DualWeild",
		buffPattern = "deadly poison",
		symbol = "D",
		color = { r = 1.0, g = 0.82, b = 0.0 },
		{ level = 30, itemID =  2892 },
	},
	INSTANT = {
		name = "Instant Poison",
		icon = "Interface\\Icons\\Ability_Poisons",
		buffPattern = "instant poison",
		symbol = "I",
		color = { r = 0.1, g = 1.0, b = 0.1 },
		{ level = 10, itemID =  6947 },
	},
	MINDNUMBING = {
		name = "Mind-numbing Poison",
		icon = "Interface\\Icons\\Spell_Nature_NullifyDisease",
		buffPattern = "mind numbing poison",
		symbol = "M",
		color = { r = 0.5, g = 0.5, b = 1.0 },
		{ level = 24, itemID =  5237 },
	},
	WOUND = {
		name = "Wound Poison",
		icon = "Interface\\Icons\\INV_Misc_Herb_16",
		buffPattern = "wound poison",
		symbol = "W",
		color = { r = 1.0, g = 0.1, b = 0.1},
		{ level = 32, itemID = 10918 },
	},
}
local PoisonItems = {}
for poisonType, poisonTypeData in pairs( Poisonous.Poisons ) do
	for i = 1, #poisonTypeData, 1 do
		local poisonData = poisonTypeData[i]
		PoisonItems[ poisonData.itemID ] = poisonType
	end
end

function Poisonous:OnEvent( event, ... )
	if ( event == "VARIABLES_LOADED" ) then
		self:ValidateConfig()
		self:CreateOptionsPanel()

		-- Initialize LibButtonFacade
		if ( LibStub ) then
			Poisonous.LBF = LibStub( "LibButtonFacade", true )
			if ( Poisonous.LBF ) then
				Poisonous.LBFGroup = Poisonous.LBF:Group( "Poisonous" )
				Poisonous.LBF:RegisterSkinCallback( "Poisonous", Poisonous.LBFSkinCallback, Poisonous )
			end
		end

	elseif ( event == "BAG_UPDATE" ) then
		self:UpdatePoisonBarButtons()

	elseif ( event == "MERCHANT_SHOW" ) then
		if ( not self:IsAtPoisonVendor() ) then return end

		-- Check how many we have of the various poison types, how many we need, and what itemIDs they are
		local itemsToBuy = nil
		for poisonType in pairs( self.Poisons ) do
			local numDesired = self:GetNumDesired( poisonType )
			if ( numDesired > 0 ) then
				local numPoisons, itemID = self:GetNumPoisons( poisonType )
				if ( itemID and ( numPoisons < numDesired ) ) then
					if ( not itemsToBuy ) then itemsToBuy = {} end
					itemsToBuy[ itemID ] = numDesired - numPoisons
				end
			end
		end
		if ( not itemsToBuy ) then return end

		-- Now go through the merchant's list and buy what we're missing
		for itemIndex = 1, GetMerchantNumItems(), 1 do
			local itemID = self:GetMerchantItemID( itemIndex )
			local numToBuy = itemsToBuy[ itemID ]
			if ( numToBuy ) then
				while ( numToBuy > POISON_STACK_SIZE ) do
					BuyMerchantItem( itemIndex, POISON_STACK_SIZE )
					numToBuy = numToBuy - POISON_STACK_SIZE
				end
				BuyMerchantItem( itemIndex, numToBuy )
				itemsToBuy[ itemID ] = nil
			end
		end

		-- Announce poisons we didn't update
		if ( Poisonous_Config.Options.ShowUnableToBuyAlert ) then
			for itemID, numToBuy in pairs( itemsToBuy ) do
				local link = select( 2, GetItemInfo( itemID ) )
				DEFAULT_CHAT_FRAME:AddMessage( ("Unable to purchase item: %sx%d.  Vendor does not carry it."):format( link, numToBuy ), 1.0, 0.1, 0.1 )
			end
		end

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		self:UpdatePoisonBarLock()

	elseif ( event == "PLAYER_TALENT_UPDATE" ) then
		self:UpdatePoisonBarButtons()

-- Not ready for primetime yet
--	elseif ( ( event == "UNIT_AURA" ) and ( select( 1, ... ) == "target" ) ) then
--		self:CheckEnrage( "target" )

	elseif ( ( event == "UNIT_INVENTORY_CHANGED" ) and ( select( 1, ... ) == "player" ) ) then
		for poisonType in pairs( self.Poisons ) do
			local button = self:GetPoisonBarButton( poisonType )
			button:SetChecked( 0 )
			button:GetCheckedTexture():SetVertexColor( 1, 1, 1 )
		end

	end
end

function Poisonous:OnSlashCommand( message )
	if ( message == "lock" ) then
		Poisonous_Config.Options.LockPoisonBar = not Poisonous_Config.Options.LockPoisonBar
		self:UpdatePoisonBarLock()
	else
		self.optionsPanel:ShowOptions()
	end
end

local TempIgnorePoisonWarning = false	-- If I ever decide to put in a "yes, I know, quit bugging me" feature
function Poisonous:CheckPoisonExpiration( elapsed )
	-- Don't even bother if we're not set to announce anything
	local alert = self.alert
	local options = Poisonous_Config.Options
	if ( not options.AnnounceExpiration and not options.AnnounceNoPoisons ) then
		alert:Hide()
		return
	end
	if ( options.AnnounceNoPoisonsNotInTown and IsResting() ) then
		alert:Hide()
		return
	end
	if ( options.AnnounceNoPoisonsNotMounted and ( IsFlying() or IsMounted() or CanExitVehicle() ) ) then
		alert:Hide()
		return
	end

	-- Get the time remaining
	local hasMHEnchant, mhExpiration, mhCharges,
		  hasOHEnchant, ohExpiration, ohCharges,
		  hasThrownEnchant, thrownExpiration, thrownCharges = GetWeaponEnchantInfo()
	
	-- Convert to seconds
	mhExpiration = ( mhExpiration or 0 ) / 1000
	ohExpiration = ( ohExpiration or 0 ) / 1000
	thrownExpiration = ( thrownExpiration or 0 ) / 1000

	local alertText, severity = "", 0

	local hasPoisonableMainhand = self:HasPoisonableWeapon( 16 )
	if ( hasPoisonableMainhand ) then
		if ( options.AnnounceNoPoisons and ( mhExpiration == 0 ) ) then
			alertText = alertText.."Mainhand weapon is not poisoned!"
		elseif ( options.AnnounceExpiration and ( mhExpiration < 180 ) ) then
			alertText = alertText.."Mainhand poison expires in "..self:FormatExpirationTime( mhExpiration ).."!"
			if ( mhExpiration < 30 ) then
				severity = max( severity, 3 )
			elseif ( mhExpiration < 60 ) then
				severity = max( severity, 2 )
			else
				severity = max( severity, 1 )
			end
		end
	end

	if ( hasPoisonableMainhand and self:HasPoisonableWeapon( 17 ) ) then
		if ( options.AnnounceNoPoisons and ( ohExpiration == 0 ) ) then
			if ( alertText:len() > 0 ) then alertText = alertText.."\n" end
			alertText = alertText.."Offhand weapon is not poisoned!"
		elseif ( options.AnnounceExpiration and ( ohExpiration < 180 ) ) then
			if ( alertText:len() > 0 ) then alertText = alertText.."\n" end
			alertText = alertText.."Offhand poison expires in "..self:FormatExpirationTime( ohExpiration ).."!"
			if ( ohExpiration < 30 ) then
				severity = max( severity, 3 )
			elseif ( ohExpiration < 60 ) then
				severity = max( severity, 2 )
			else
				severity = max( severity, 1 )
			end
		end
	end

	if ( hasPoisonableMainhand and self:HasPoisonableWeapon( 18 ) ) then
		if ( options.AnnounceNoPoisons and ( thrownExpiration == 0 ) ) then
			if ( alertText:len() > 0 ) then alertText = alertText.."\n" end
			alertText = alertText.."Thrown weapon is not poisoned!"
		elseif ( options.AnnounceExpiration and ( thrownExpiration < 180 ) ) then
			if ( alertText:len() > 0 ) then alertText = alertText.."\n" end
			alertText = alertText.."Thrown poison expires in "..self:FormatExpirationTime( thrownExpiration ).."!"
			if ( thrownExpiration < 30 ) then
				severity = max( severity, 3 )
			elseif ( ohExpiration < 60 ) then
				severity = max( severity, 2 )
			else
				severity = max( severity, 1 )
			end
		end
	end

	if ( alertText and TempIgnorePoisonWarning ) then
		alert:Hide()
		return
	end
	TempIgnorePoisonWarning = false

	local r, g, b, a = 1, 1, 1, 0.10
	if ( severity == 3 ) then
		r, g, b, a = 1, 0, 0, 0.35
	elseif ( severity == 2 ) then
		r, g, b, a = 1, 1, 0, 0.25
	elseif ( severity == 1 ) then
		r, g, b, a = 0, 1, 0, 0.10
	end

	if ( alertText:len() > 0 ) then
		if ( ( severity == 0 ) and ( alert:IsShown() ~= 1 ) ) then
			PlaySoundFile( "Sound\\Doodad\\BE_ScryingOrb_Explode.wav" )
		end
		alert.text:SetText( alertText )
		alert.text:SetVertexColor( r, g, b, 1 )
		alert.background:SetVertexColor( r, g, b, a )
		
		if ( Poisonous_Config.Options.HideExpirationBackground ) then
			alert.background:Hide()
		else
			alert.background:Show()
		end
		
		alert:Show()
	else
		alert.text:SetText( alertText )
		alert:Hide()
	end
end

function Poisonous:CreateOptionsPanel()
	-- Options Panel
	local optionsPanel = OptionsLib:CreateOptionsPanel( "Poisonous" )
	optionsPanel:SetDatabase( "Poisonous_Config" )
	optionsPanel:SetIcon( "Interface\\Icons\\Trade_BrewPoison" )
	optionsPanel:SetDescription( "Poisoner is a simple poison autobuy addon.  Set how many stacks of each kind of poison you want, and whenever you're at a poison vendor it will purchase enough of each poison to give you a full stack of the best rank of each poison you can use at your current level." )
	optionsPanel:SetOkayFunc( function()
		Poisonous:UpdatePoisonBarButtons()
		Poisonous:UpdatePoisonBarLock()
	end )
	self.optionsPanel = optionsPanel

	local enabled = optionsPanel:AddCheckButton( "Enable Poison Auto-buy", "Enable the auto-buy functionality.", true, true )
	enabled:SetDatabase( "Options", "Enabled" )

	local group = optionsPanel:AddGroupBox( "Poison Auto-buy" )
	group:SetPaddingY( 4 )
	group:SetDependantOn( enabled )

	local poisonSequence = { INSTANT, CRIPPLING, WOUND, DEADLY, MINDNUMBING }
	local numPoisons = #poisonSequence
	for i = 1, numPoisons, 1 do
		local poisonType = poisonSequence[i]
		local poisonTypeData = self.Poisons[ poisonType ]
		-- |T<path>:<width>[:<height>:<xOffset>:<yOffset>]|t
		local sliderText = ("|T%s:24:24:0:-2|t %s"):format( poisonTypeData.icon, poisonTypeData.name )
		local slider = group:AddSlider( sliderText, "Set the number of stacks of "..poisonTypeData.name.." to maintain.", 0, 4, 1, 0 )
		if ( i > math.ceil( numPoisons / 2 ) ) then
			slider:SetColumnNumber( 2 )
		end
		slider:SetDatabase( "Poisons", poisonType )
		slider:SetValueFormat( Poisonous.FormatSliderValue )
		slider:SetDependantOn( enabled )
	end

	local barGroup = optionsPanel:AddGroupBox( "Poison Bar" )
	local barEnabled = barGroup:AddCheckButton( "Use the Poison Bar", "Enable the poison bar functionality.", true, true )
	barEnabled:SetDatabase( "Options", "UsePoisonBar" )

	local barLocked = barGroup:AddCheckButton( "Lock the Poison Bar", "", true, true )
	barLocked:SetDatabase( "Options", "LockPoisonBar" )
	barLocked:SetDependantOn( barEnabled )
	barLocked:SetColumnNumber( 2 )
	
	local barTooltips = barGroup:AddCheckButton( "Show Poison Bar Tooltips", "Show tooltips for the poisons on the poison bar.", true, true )
	barTooltips:SetDatabase( "Options", "ShowPoisonBarTooltips" )
	barTooltips:SetDependantOn( barEnabled )
	barTooltips:SetFullWidth( true )
	
	local buttonScale = barGroup:AddSlider( "Poison Bar Scale", "Scale the poison bar buttons.", 0.1, 3, 0.05, 0.85 )
	buttonScale:SetDatabase( "Options", "PoisonBarScale" )
	buttonScale:SetValueFormat( Poisonous.FormatScaleValue )
	buttonScale:SetDependantOn( barEnabled )
	buttonScale:SetColumnNumber( 1 )

	local buttonPadding = barGroup:AddSlider( "Poison Bar Button Padding", "Set the spacing between poison bar button.", 0, 16, 1, 2 )
	buttonPadding:SetDatabase( "Options", "PoisonBarPadding" )
	buttonPadding:SetDependantOn( barEnabled )
	buttonPadding:SetColumnNumber( 2 )

	local announceGroup = optionsPanel:AddGroupBox( "Announcements" )

	local announceExpiration = announceGroup:AddCheckButton( "Poison expiration", "Display warning messages as poisons get closer to expiring, and when they run out (counting down from 3 minutes).", true, true )
	announceExpiration:SetDatabase( "Options", "AnnounceExpiration" )
	
	local announceNoPoisons = announceGroup:AddCheckButton( "Unpoisoned weapon", "Display warning messages when one or both weapons are not poisoned.", true, true )
	announceNoPoisons:SetDatabase( "Options", "AnnounceNoPoisons" )
	announceNoPoisons:SetColumnNumber( 2 )

	local announceNoPoisonsTown = announceGroup:AddCheckButton( "Not in towns", "Don't display expiration warnings in towns (anywhere that counts as an inn).", true, true )
	announceNoPoisonsTown:SetDatabase( "Options", "AnnounceNoPoisonsNotInTown" )

	local announceNoPoisonsMounted = announceGroup:AddCheckButton( "Not while mounted", "Don't display expiration warnings while mounted.", true, true )
	announceNoPoisonsMounted:SetDatabase( "Options", "AnnounceNoPoisonsNotMounted" )
	announceNoPoisonsMounted:SetColumnNumber( 2 )

	local noExpirationBackground = announceGroup:AddCheckButton( "Don't tint screen on warning", "Don't tint the screen when warnings are displayed, to make them a little less annoying.", true, true )
	noExpirationBackground:SetDatabase( "Options", "HideExpirationBackground" )
	noExpirationBackground:SetFullWidth( true )
	
--	local announceEnrage = announceGroup:AddCheckButton( "Announce enraged targets", "Display a warning message when your current target is enraged.", true, true )
--	announceEnrage:SetDatabase( "Options", "AnnounceEnrage" )
--	announceEnrage:SetColumnNumber( 1 )
end

function Poisonous:FormatExpirationTime( seconds )
	if ( seconds <= 1 ) then
		return ("%d second"):format( seconds )
	elseif ( seconds <= 60 ) then
		return ("%d seconds"):format( seconds )
	else
		local minutes = math.floor( seconds / 60 )
		seconds = seconds - ( minutes * 60 )
		return ("%d:%02d"):format( minutes, seconds )
	end
end

function Poisonous.FormatSliderValue( value )
	if ( value == 1 ) then
		return value.." Stack"
	else
		return value.." Stacks"
	end
end

function Poisonous.FormatScaleValue( value )
	return ("%d%%"):format( value * 100 )
end

function Poisonous:GetBestRank( poisonType )
	local poisonTypeData = self.Poisons[ poisonType ]
	if ( not poisonTypeData ) then return nil end

	local level = UnitLevel( "player" )
	local itemID = nil
	for i = 1, #poisonTypeData, 1 do
		local poisonData = poisonTypeData[i]
		if ( level < poisonData.level ) then return itemID end
		itemID = poisonData.itemID
	end
	return itemID
end

function Poisonous:GetMerchantItemID( itemIndex )
	local link = GetMerchantItemLink( itemIndex )
	if ( not link ) then return nil end
	return tonumber( select( 3, strfind( link, "item:(%d+):" ) ) )
end

function Poisonous:GetNumPoisons( poisonType )
	local itemID = self:GetBestRank( poisonType )
	return GetItemCount( itemID, false ), itemID
end

function Poisonous:GetNumDesired( poisonType )
	return ( Poisonous_Config.Poisons[ poisonType ] or 0 ) * POISON_STACK_SIZE
end

function Poisonous:HasPoisonableWeapon( slotID )
	local weaponType, maxStack, equipSlot = select( 7, GetItemInfo( GetInventoryItemLink( "player", slotID ) or 0 ) )
	if ( ( not weaponType ) or ( weaponType == "Fishing Poles" ) or ( weaponType == "Miscellaneous" ) ) then
		return false
	end
	if ( ( slotID == 18 ) and ( equipSlot ~= "INVTYPE_THROWN" ) ) then
		return false
	end
	return true
end

function Poisonous:Initialize()
	-- Do an initial validation to make sure the config structure is present for checking
	Poisonous:ValidateConfig()

	local frame = CreateFrame( "Frame" )
	frame:SetScript( "OnEvent", function( self, event, ... ) Poisonous:OnEvent( event, ... ) end )
	frame:RegisterEvent( "VARIABLES_LOADED" )
	frame:RegisterEvent( "BAG_UPDATE" )
	frame:RegisterEvent( "MERCHANT_SHOW" )
	frame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
	frame:RegisterEvent( "PLAYER_TALENT_UPDATE" )
	frame:RegisterEvent( "UNIT_AURA" )
	frame:RegisterEvent( "UNIT_INVENTORY_CHANGED" )
	frame:SetScript( "OnUpdate", function( self, elapsed ) Poisonous:CheckPoisonExpiration( elapsed ) end )
	frame:Show()
	self.frame = frame

	-- Alert frame
	local alertFrame = CreateFrame( "Frame", "PoisonousAlertFrame", UIParent )
	alertFrame:SetFrameStrata( "FULLSCREEN_DIALOG" )
	alertFrame:SetAllPoints( UIParent )
	alertFrame:Hide()
	self.alert = alertFrame
	local alertBackground = alertFrame:CreateTexture( nil, "BACKGROUND" )
	alertBackground:SetTexture( 1, 1, 1, 1 )
	alertBackground:SetBlendMode( "ADD" )
	alertBackground:SetAllPoints( alertFrame )
	alertBackground:SetParent( alertFrame )
	self.alert.background = alertBackground
	local alertMessage = alertFrame:CreateFontString( nil, "OVERLAY", "BossEmoteNormalHuge" )
	alertMessage:SetVertexColor( 0, 1, 0 )
	alertMessage:SetJustifyH( "CENTER" )
	alertMessage:SetJustifyV( "CENTER" )
	alertMessage:SetPoint( "CENTER", alertFrame, "CENTER" )
	alertMessage:SetText( "" )
	alertMessage:Show()
	self.alert.text = alertMessage
	
	-- Enrage Warning frame
	local enrageWarning = CreateFrame( "Frame", "PoisonousEnrageWarningFrame", UIParent )
	enrageWarning:SetFrameStrata( "FULLSCREEN_DIALOG" )
	enrageWarning:SetAllPoints( UIParent )
	enrageWarning:Hide()
	self.enrageWarning = enrageWarning
--	local enrageWarningBackground = enrageWarning:CreateTexture( nil, "BACKGROUND" )
--	enrageWarningBackground:SetTexture( 1, 1, 1, 1 )
--	enrageWarningBackground:SetBlendMode( "ADD" )
--	enrageWarningBackground:SetAllPoints( enrageWarning )
--	enrageWarningBackground:SetParent( enrageWarning )
--	self.enrageWarning.background = enrageWarningBackground
	local enrageWarningMessage = enrageWarning:CreateFontString( nil, "OVERLAY", "BossEmoteNormalHuge" )
	enrageWarningMessage:SetVertexColor( 1, 0, 0 )
	enrageWarningMessage:SetJustifyH( "CENTER" )
	enrageWarningMessage:SetJustifyV( "CENTER" )
	--enrageWarningMessage:SetPoint( "CENTER", enrageWarning, "CENTER" )
	enrageWarningMessage:SetPoint( "BOTTOM", alertMessage, "TOP" )
	enrageWarningMessage:SetText( "Enraged!" )
	enrageWarningMessage:Show()
	self.enrageWarning.text = enrageWarningMessage

	-- Tooltip
	self.tooltip = TooltipLib:GetTooltip( "PoisonousTooltip" )

	-- Temp Enchant Button updates
	for num = 1, 3, 1 do
		local button = _G[ "TempEnchant"..num ]
		local onUpdateFunc = button:GetScript( "OnUpdate" )

		button:SetScript( "OnUpdate", function( self, ... )
			onUpdateFunc( self, ... )
			Poisonous:TempEnchantButton_OnUpdate( self, ... )
		end )
	end
end

function Poisonous:IsAtPoisonVendor()
	for itemIndex = 1, GetMerchantNumItems() do
		local itemID = self:GetMerchantItemID( itemIndex )
		if ( PoisonItems[ itemID ] ) then return true end
	end
	return false
end

function Poisonous:TempEnchantButton_OnUpdate( frame )
	local tooltip = self.tooltip
	tooltip:SetOwner( UIParent, "ANCHOR_NONE" )
	local hasItem = tooltip:SetInventoryItem( "player", frame:GetID() )
	if ( not hasItem ) then return end

	local count = _G[ frame:GetName().."Count" ]
	count:Hide()

	for line = 1, tooltip:NumLines(), 1 do
		local lineText = tooltip:GetValueLeft( line )
		local searchText = lineText:lower()

		for poisonType, poisonData in pairs( self.Poisons ) do
			local s, e = searchText:find( poisonData.buffPattern )
			if ( s ) then
				-- Chop the line down to just the poison's spell name
				lineText = lineText:sub( s, e )

				-- Mark the poison button to show the poison for this item
				count:SetText( poisonData.symbol )
				local color = poisonData.color
				count:SetTextColor( color.r, color.g, color.b )
				count:Show()

				-- Mark the current state on the poison button
				if ( Poisonous_Config.Options.UsePoisonBar ) then
					local button = self:GetPoisonBarButton( poisonType )
					local itemSpell = GetItemSpell( button.itemID )
					if ( IsCurrentSpell( itemSpell ) or nil ) then
						button.border:SetVertexColor( 1, 1, 1 )
						--button:SetChecked( 1 )
						--button:GetCheckedTexture():SetVertexColor( 1, 1, 1 )
					elseif ( itemSpell == lineText ) then
						button.border:SetVertexColor( 1, 0.5, 1 )
						--button:SetChecked( 1 )
						--button:GetCheckedTexture():SetVertexColor( 1, 0.5, 1 )
					end
				end
				return
			end
		end
	end
end

function Poisonous:ValidateConfig()
	if ( not Poisonous_Config ) then Poisonous_Config = {} end
	if ( not Poisonous_Config.Options ) then
		Poisonous_Config.Options = {
			Enabled = false,		-- Autobuy disabled by default
			UsePoisonBar = true,
			LockPoisonBar = false,
			ShowPoisonBarTooltips = true,
			PoisonBarDirection = "RIGHT",
			PoisonBarPadding = 2,
			PoisonBarScale = 0.85,
			AnnounceExpiration = true,
			AnnounceNoPoisons = true,
			AnnounceNoPoisonsNotInTown = true,
			AnnounceNoPoisonsNotMounted = true,
			HideExpirationBackground = false,
			AnnounceEnrage = true,
		}
	end
	
	-- Specific option checks
	if ( not Poisonous_Config.Options.PoisonBarDirection ) then
		Poisonous_Config.Options.PoisonBarDirection = "RIGHT"
	end
	
	if ( not Poisonous_Config.Options.PoisonBarPadding ) then
		Poisonous_Config.Options.PoisonBarPadding = 2
	end

	if ( not Poisonous_Config.Options.PoisonBarScale ) then
		Poisonous_Config.Options.PoisonBarScale = 0.85
	end

	if ( not Poisonous_Config.Poisons ) then Poisonous_Config.Poisons = {} end

	-- Remove any references to Anesthetic Poison since it's been removed in 4.0
	Poisonous_Config.Poisons[ "ANESTHETIC" ] = nil

	-- Initialize the desired poison counts to 1 stack, but default to autobuy off
	local poisons = Poisonous_Config.Poisons
	for poisonType in pairs( self.Poisons ) do
		if ( not poisons[ poisonType ] ) then
			poisons[ poisonType ] = 1
		end
	end
end

------------------------------------------------------------------------------
-- Enrage Scanning and Notification
------------------------------------------------------------------------------

function Poisonous:CheckEnrage( unitID )
	if ( not Poisonous_Config.Options.AnnounceEnrage ) then return end

	local tooltip = self.tooltip
	tooltip:SetOwner( UIParent, "ANCHOR_NONE" )

	local buffIndex = 1
	repeat
		tooltip:ClearLines()
		tooltip:SetUnitBuff( unitID, buffIndex )
		local name = tooltip:GetValueLeft( 1 )
		if ( name ) then
			if ( tooltip:GetValueRight( 1 ) == "Enrage" ) then
				-- Found an enrage
				if ( self.enrageWarning:IsShown() ~= 1 ) then
					PlaySoundFile( "Sound\\Spells\\bloodlust_player_cast_head.wav" )
				end
				self.enrageWarning:Show()
				return
			end
			buffIndex = buffIndex + 1
		end
	until ( not name )

	self.enrageWarning:Hide()
end

------------------------------------------------------------------------------
-- Poison Bar Handle
------------------------------------------------------------------------------

function PoisonousPoisonBarHandle_OnLoad( self )
	self:RegisterForClicks( "RightButtonUp" )
	self:RegisterForDrag( "LeftButton" )
end

function PoisonousPoisonBarHandle_OnClick( self, button )
	if ( button == "RightButton" ) then
		-- Rotate the bar clockwise
		local direction = Poisonous_Config.Options.PoisonBarDirection
		if ( direction == "RIGHT" ) then
			direction = "BOTTOM"
		elseif ( direction == "BOTTOM" ) then
			direction = "LEFT"
		elseif ( direction == "LEFT" ) then
			direction = "TOP"
		else--if ( direction == "TOP" ) then
			direction = "RIGHT"
		end
		Poisonous_Config.Options.PoisonBarDirection = direction

		Poisonous:UpdatePoisonBarButtons()
	end
end

function PoisonousPoisonBarHandle_OnDragStart( self, button )
	self:StartMoving()
end

function PoisonousPoisonBarHandle_OnDragStop( self )
	self:StopMovingOrSizing()
end

------------------------------------------------------------------------------
-- Poison Bar
------------------------------------------------------------------------------

local function PoisonousPoisonButton_OnEnter( self )
	if ( not Poisonous_Config.Options.ShowPoisonBarTooltips ) then return end

	GameTooltip_SetDefaultAnchor( GameTooltip, self )
	GameTooltip:SetHyperlink( "item:"..tostring( self.itemID ) )

	if ( Poisonous:HasPoisonableWeapon( 16 ) ) then
		GameTooltip:AddLine( GREEN_FONT_COLOR_CODE.."Left click to apply to your mainhand weapon" )
	end

	if ( Poisonous:HasPoisonableWeapon( 17 ) ) then
		GameTooltip:AddLine( GREEN_FONT_COLOR_CODE.."Right click to apply to your offhand weapon" )
	end

	if ( Poisonous:HasPoisonableWeapon( 18 ) ) then
		GameTooltip:AddLine( GREEN_FONT_COLOR_CODE.."Alt-click to apply to your thrown weapon" )
	end

	GameTooltip:Show()
end
local function PoisonousPoisonButton_OnLeave( self )
	GameTooltip:Hide()
end

-- Doesn't work well right now anyways, plus need to expand it for thrown anyway
--local function PoisonousPoisonButton_PreClick( self, button )
--	if ( IsAltKeyDown() ) then
--		if ( button == "LeftButton" ) then
--			CancelItemTempEnchantment( 1 )
--		elseif ( button == "RightButton" ) then
--			CancelItemTempEnchantment( 2 )
--		end
--	end
--end

function Poisonous.PoisonButton_Update( self )
	-- I could do button border color here instead of the TempEnchantFrame's OnUpdate, but eh, I'll worry about
	-- that if it matters someday.

	-- Update the count
	local countText = _G[ self:GetName().."Count" ]
	countText:SetText( Poisonous:GetNumPoisons( self.poisonType ) )
	countText:Show()
end

function Poisonous:GetPoisonBarButton( poisonType )
	if ( not self.PoisonBarButtons ) then self.PoisonBarButtons = {} end

	local button = self.PoisonBarButtons[ poisonType ]
	if ( not button ) then
		local poisonData = self.Poisons[ poisonType ]

		local buttonName = "PoisonButton"..poisonType
		button = CreateFrame( "CheckButton", buttonName, UIParent, "ActionBarButtonTemplate" )
		button.poisonType = poisonType

		if ( not button.border ) then
			button.border = _G[ buttonName.."Border" ]
		end

		local icon = _G[ buttonName.."Icon" ]
		icon:SetTexture( poisonData.icon )
		icon:Show()
		button:SetNormalTexture( "Interface\\Buttons\\UI-Quickslot2" )

		button:SetScript( "OnUpdate", Poisonous.PoisonButton_Update )
		button:SetScript( "OnEnter", ActionButton_SetTooltip )
		button:SetScript( "OnLeave", function( self ) GameTooltip:Hide() end )
		button:SetScript( "OnAttributeChanged", nil )
		button:SetScript( "OnEvent", nil )
		button:SetScript( "PostClick", nil )
		button:SetScript( "OnDragStart", nil )
		button:SetScript( "OnReceiveDrag", nil )

--		button:SetAttribute( "type", "item" )
		button:SetAttribute( "type", "macro" )
		button:SetAttribute( "target-slot", "16" )
		button:SetAttribute( "target-slot2", "17" )
		button:SetAttribute( "alt-target-slot*", "18" )

--		button:SetScript( "PreClick", PoisonousPoisonButton_PreClick )
		button:SetScript( "OnEnter", PoisonousPoisonButton_OnEnter )
		button:SetScript( "OnLeave", PoisonousPoisonButton_OnLeave )

		self.PoisonBarButtons[ poisonType ] = button

		-- Add the button to the LibButtonFacade group if we're using it
		if ( Poisonous.LBFGroup ) then Poisonous.LBFGroup:AddButton( button ) end
	end

	-- Make sure the button scale is correct	
	button:SetScale( Poisonous_Config.Options.PoisonBarScale )

	-- Update the LibButtonFacade settings for this group
	if ( Poisonous.LBFGroup and Poisonous_Config.LBFSettings ) then
		Poisonous.LBFGroup:Skin( Poisonous_Config.LBFSettings.SkinID,
			Poisonous_Config.LBFSettings.Gloss,
			Poisonous_Config.LBFSettings.Backdrop,
			Poisonous_Config.LBFSettings.Colors )
	end

	return button
end

function Poisonous:LBFSkinCallback( skinID, gloss, backdrop, group, button, colors )
	if ( not Poisonous_Config.LBFSettings ) then
		Poisonous_Config.LBFSettings = {}
	end
	
	Poisonous_Config.LBFSettings.SkinID = skinID
	Poisonous_Config.LBFSettings.Gloss = gloss
	Poisonous_Config.LBFSettings.Backdrop = backdrop
	Poisonous_Config.LBFSettings.Colors = colors
end

function Poisonous:UpdatePoisonBarButtons()
	if ( not Poisonous_Config.Options.UsePoisonBar ) then
		if ( self.PoisonBarButtons ) then
			for poisonType, button in pairs( self.PoisonBarButtons ) do
				button:Hide()
			end
		end
		return
	end

	local relativeFrame = PoisonousPoisonBarHandle
	local point, relativePoint, offsetX, offsetY, startIndex, endIndex, increment

	-- Determine which poison sequence we should use, based on spec
	local poisonBarSequence = nil
	
-- 4.0.3a: Nope, it looks like we're back to Instant beating out Wound by a small margin
--	-- Determine spec
--	local activeTalentGroup = GetActiveTalentGroup( false, false )
--	local specIndex = 0
--	local highestPointsSpent = 0
--	for tabIndex = 1, GetNumTalentTabs( "player" ) do
--		local pointsSpent = select( 5, GetTalentTabInfo( tabIndex, "player", nil, activeTalentGroup ) )
--		if ( pointsSpent > highestPointsSpent ) then
--			specIndex = tabIndex
--			highestPointsSpent = pointsSpent
--		end
--	end
--	if ( specIndex == 1 ) then	-- Assassination
		poisonBarSequence = self.PoisonBarSequences[ INSTANT ]
--	else
--		poisonBarSequence = self.PoisonBarSequences[ WOUND ]
--	end

	-- Arrange the buttons
	local direction = Poisonous_Config.Options.PoisonBarDirection
	if ( direction == "RIGHT" ) then	-- Right of the anchor
		point = "TOPLEFT"
		relativePoint = "TOPRIGHT"
		offsetX = ( Poisonous_Config.Options.PoisonBarPadding + 2 )
		startIndex = 1
		endIndex = #poisonBarSequence
	elseif ( direction == "BOTTOM" ) then	-- Below the anchor
		point = "TOPLEFT"
		relativePoint = "BOTTOMLEFT"
		offsetY = -( Poisonous_Config.Options.PoisonBarPadding + 2 )
		startIndex = 1
		endIndex = #poisonBarSequence
	elseif ( direction == "LEFT" ) then		-- Left of the anchor
		point = "TOPRIGHT"
		relativePoint = "TOPLEFT"
		offsetX = -( Poisonous_Config.Options.PoisonBarPadding + 2 )
		startIndex = #poisonBarSequence
		endIndex = 1
		increment = -1
	else --if ( direction == "TOP" ) then	-- Above the anchor
		point = "BOTTOMLEFT"
		relativePoint = "TOPLEFT"
		offsetY = ( Poisonous_Config.Options.PoisonBarPadding + 2 )
		startIndex = #poisonBarSequence
		endIndex = 1
		increment = -1
	end

	-- Clear poison button positioning before updating them in case anchors are reversed
	for index = startIndex, endIndex, increment or 1 do
		local poisonType = poisonBarSequence[ index ]
		local button = self:GetPoisonBarButton( poisonType )
		button:ClearAllPoints()
	end

	-- Update the buttons
	local offsetXAdjustment, offsetYAdjustment
	for index = startIndex, endIndex, increment or 1 do
		local poisonType = poisonBarSequence[ index ]
		local poisonData = self.Poisons[ poisonType ]
		local buttonName = "PoisonButton"..poisonType
		local button = self:GetPoisonBarButton( poisonType )

		local itemID = self:GetBestRank( poisonType )
		--local count = self:GetNumPoisons( poisonType )
		if ( ( not itemID ) or ( count == 0 ) ) then
			button:Hide()
		else
			button.itemID = itemID

			--button:SetAttribute( "item", "item:"..tostring( itemID ) )
			button:SetAttribute( "macrotext", "#showtooltip\n/stopcasting\n/use item:"..tostring( itemID ) )

			offsetXAdjustment = 0
			offsetYAdjustment = 0
			if ( relativeFrame == PoisonousPoisonBarHandle ) then
				if ( direction == "RIGHT" ) then
					offsetYAdjustment = - 2
				elseif ( direction == "LEFT" ) then
					offsetYAdjustment = - 2
				elseif ( direction == "BOTTOM" ) then
					offsetXAdjustment = 2
				elseif ( direction == "TOP" ) then
					offsetXAdjustment = 2
				end
			end

			button:SetPoint( point, relativeFrame, relativePoint,
				( offsetX or 0 ) + offsetXAdjustment, ( offsetY or 0 ) + offsetYAdjustment )
			--button.count:SetText( count )

			relativeFrame = button
			button:Show()
		end
	end
end

function Poisonous:UpdatePoisonBarLock()
	local options = Poisonous_Config.Options
	if ( ( not options.UsePoisonBar ) or options.LockPoisonBar ) then
		PoisonousPoisonBarHandle:Hide()
	else
		PoisonousPoisonBarHandle:Show()
	end
end

------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------

SlashCmdList["POISONOUS"] = function( message ) Poisonous:OnSlashCommand( message ) end
Poisonous:Initialize()
