local VERSION = 1.8

------------------------------------------------------------------------------
-- Begin Library
if ( ( not OptionsLib ) or ( not OptionsLib.Version ) or ( OptionsLib.Version < VERSION ) ) then
------------------------------------------------------------------------------

local CONTROLTYPE_BUTTON = 1
local CONTROLTYPE_CHECKBOX = 2
--local CONTROLTYPE_DROPDOWN = 3
local CONTROLTYPE_EDIT = 4
local CONTROLTYPE_FONTSTRING = 5
local CONTROLTYPE_GROUPBOX = 6
local CONTROLTYPE_SLIDER = 7

local function getObjectDatabaseValue( object, root )
	if ( ( not object ) or ( not object.Database ) ) then return nil end

	local data = root
	for k, varName in pairs( object.Database ) do
		if ( ( type( data ) == "table" ) and data[ varName ] ) then
			data = data[ varName ]
		else
			return nil
		end
	end
	if ( data ~= root ) then return data end
end

local function setObjectDatabaseValue( object, root, value )
	if ( ( not object ) or ( not object.Database ) ) then return nil end

	local data = root
	local db = object.Database
	for i = 1, #db, 1 do
		local varName = db[i]
		if ( i == #db ) then
			data[ varName ] = value
		else
			if ( ( type( data ) == "table" ) and data[ varName ] ) then
				data = data[ varName ]
			end
		end
	end
end

local DEFAULT_COLUMN_PADDING = 10
local DEFAULT_PADDING_X = 10
local DEFAULT_PADDING_Y = 0
local CONTROL_SPACING_SIZE = 8
local CONTROL_SPACING_MIN = 1
local INDENT_SIZE = 8
local INDENT_MIN = 1

local _G = getfenv(0)
local panelLib = {}
local controlLib = {}		-- Generic control functionality
local buttonLib = {}		-- Button control functionality
local checkLib = {}			-- Checkbox control functionality
local editLib = {}			-- Editbox control functionality
local fontStringLib = {}	-- Fontstring functionality
local groupLib = {}			-- Groupbox control functionality
local sliderLib = {}		-- Slider control functionality

local function tostringboolean( value )
	local valType = type( value )
	if ( valType == "boolean" ) then
		if ( value ) then return "1" end
	elseif ( valType == "number" ) then
		if ( value ~= 0 ) then return "1" end
	else
		if ( tonumber( value ) ~= 0 ) then return "1" end
	end
	return "0"
end

local function Slider_UpdateValueText( slider )
	local value = slider:GetValue()
	if ( slider.valueFormat ) then
		if ( type( slider.valueFormat ) == "string" ) then
			value = slider.valueFormat:format( value )
		elseif ( type ( slider.valueFormat ) == "function" ) then
			value = slider.valueFormat( value )
		end
	end
	slider:GetParent().value:SetText( value )
end

------------------------------------------------------------------------------
-- Public Interface
------------------------------------------------------------------------------
OptionsLib = { Version = VERSION }

local function OptionsPanel_ClearShown( self )
	self.shown = nil
	if ( not self.controls ) then return end
	for k, control in pairs( self.controls ) do
		OptionsPanel_ClearShown( control )
	end
end

local function OptionsPanel_Cancel( self )
	for k, control in pairs( self.controls ) do
		BlizzardOptionsPanel_CancelControl( control )
	end

	-- The options frame closes after this, so reset any shown flags
	OptionsPanel_ClearShown( self )
	
	if ( self.onCancel ) then self.onCancel() end
end

local function OptionsPanel_Default( self )
	for k, control in pairs( self.controls ) do
		BlizzardOptionsPanel_DefaultControl( control )
	end
end

local function OptionsPanel_Okay( self )
	-- Only save values if the panel actually got shown
	if ( self.shown ) then
		local data = self:GetDatabase()
		if ( not data ) then return end
	
		for k, control in pairs( self.controls ) do
			if ( control.type == CONTROLTYPE_GROUPBOX ) then
				control:SetDataValues()
			elseif ( control.type == CONTROLTYPE_FONTSTRING ) then
				-- Fonts have no data
			elseif ( control.SetDataValue and control.GetValue ) then
				control:SetDataValue( control:GetValue() )
			end
		end
	end

	-- The options frame closes after this, so reset any shown flags
	OptionsPanel_ClearShown( self )

	if ( self.onOkay ) then self.onOkay() end
end

local function OptionsPanel_Refresh( self )
	-- Add something here
end

local function OptionsPanel_OnShow( self )
	self:OrganizeControls()
	self.shown = true
end

local function BuildOptionsPanelFrameName( panelName )
	local frameName = panelName:gsub( "[^%w]", "" )
	if ( frameName:sub( 0, 1 ):find( "%d" ) ) then
		frameName = "Addon"..frameName
	end
	return frameName.."OptionsPanel"
end

local function ScrollButtonUp_OnClick( self )
	local scrollBar = self:GetParent()
	scrollBar:SetValue( scrollBar:GetValue() - scrollBar:GetValueStep() )
	PlaySound( "UChatScrollButton" )
end

local function ScrollButtonDown_OnClick( self )
	local scrollBar = self:GetParent()
	scrollBar:SetValue( scrollBar:GetValue() + scrollBar:GetValueStep() )
	PlaySound( "UChatScrollButton" )
end

local function ScrollFrame_OnMouseWheel( self, value )
	local scrollBar = self.scrollBar
	scrollBar:SetValue( scrollBar:GetValue() - value * scrollBar:GetValueStep() )
end

local function ScrollBar_OnValueChanged( self, value )
	local scrollFrame = self:GetParent()
	scrollFrame:SetVerticalScroll( value )
	scrollFrame.scrollChild:SetPoint( "TOP", 0, value )
	
	local min, max = self:GetMinMaxValues()
	if ( value == min ) then
		self.up:Disable()
	else
		self.up:Enable()
	end
	
	if ( value == max ) then
		self.down:Disable()
	else
		self.down:Enable()
	end
end

local function CreateScrollBar( parent )
	local scrollBar = CreateFrame( "Slider", nil, parent )
	scrollBar:SetWidth( 16 )
	scrollBar:SetMinMaxValues( 0, 100 )
	scrollBar:SetValue( 0 )
	scrollBar:SetScript( "OnValueChanged", ScrollBar_OnValueChanged )
	scrollBar:Hide()
	
	-- Thumb
	scrollBar:SetThumbTexture( "Interface\\Buttons\\UI-ScrollBar-Knob" )
	local thumb = scrollBar:GetThumbTexture()
	thumb:SetHeight( 24 )
	thumb:SetWidth( 15 )
	thumb:SetTexCoord( 0.20, 0.75, 0.125, 0.875 )

	-- Scroll Up button	
	local up = CreateFrame( "Button", nil, scrollBar )
	up:SetPoint( "BOTTOM", scrollBar, "TOP", 0, -3 )
	up:SetHeight( 16 )
	up:SetWidth( 15 )
	up:SetNormalTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up" )
	up:GetNormalTexture():SetTexCoord( 0.20, 0.75, 0.20, 0.75 )	
	up:SetPushedTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down" )
	up:GetPushedTexture():SetTexCoord( 0.20, 0.75, 0.20, 0.75 )	
	up:SetDisabledTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled" )
	up:GetDisabledTexture():SetTexCoord( 0.20, 0.75, 0.20, 0.75 )	
	up:SetHighlightTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight" )
	up:GetHighlightTexture():SetTexCoord( 0.20, 0.75, 0.20, 0.75 )
	up:GetHighlightTexture():SetBlendMode( "ADD" )
	up:SetScript( "OnClick", ScrollButtonUp_OnClick )
	up:Disable()
	up:Show()
	scrollBar.up = up
	
	-- Scroll Down button
	local down = CreateFrame( "Button", nil, scrollBar )
	down:SetPoint( "TOP", scrollBar, "BOTTOM", 0, 3 )
	down:SetHeight( 16 )
	down:SetWidth( 15 )
	down:SetNormalTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up" )
	down:GetNormalTexture():SetTexCoord( 0.20, 0.75, 0.25, 0.75 )	
	down:SetPushedTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down" )
	down:GetPushedTexture():SetTexCoord( 0.20, 0.75, 0.25, 0.75 )	
	down:SetDisabledTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled" )
	down:GetDisabledTexture():SetTexCoord( 0.20, 0.75, 0.25, 0.75 )	
	down:SetHighlightTexture( "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight" )
	down:GetHighlightTexture():SetTexCoord( 0.20, 0.75, 0.25, 0.75 )
	down:GetHighlightTexture():SetBlendMode( "ADD" )
	down:SetScript( "OnClick", ScrollButtonDown_OnClick )
	down:Show()
	scrollBar.down = down
	
	return scrollBar
end

local function CreateScrollFrame( parent )
	-- Scroll Frame
	local scrollFrame = CreateFrame( "ScrollFrame", nil, parent )

	scrollChild = CreateFrame( "Frame", nil )
	scrollChild:SetParent( scrollFrame )
	scrollFrame:SetScrollChild( scrollChild )
	scrollChild:SetPoint( "TOP" )
	scrollChild:SetPoint( "LEFT" )
	scrollChild:SetPoint( "RIGHT" )
	scrollChild:SetHeight( 400 )	-- Will be adjusted based on control height later
	scrollChild:Show()
	scrollFrame.scrollChild = scrollChild
	
	local scrollBar = CreateScrollBar( scrollFrame )
--	scrollBar:SetPoint( "TOPRIGHT", -3, -12 )
--	scrollBar:SetPoint( "BOTTOMRIGHT", -3, 13 )
	scrollBar:SetPoint( "TOPLEFT", scrollFrame, "TOPRIGHT", -3, -12 )
	scrollBar:SetPoint( "BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", -3, 13 )
	scrollFrame.scrollBar = scrollBar
	
	scrollFrame:UpdateScrollChildRect()
	scrollFrame:EnableMouseWheel( true )	
	scrollFrame:SetScript( "OnMouseWheel", ScrollFrame_OnMouseWheel )

	scrollFrame:Show()
	return scrollFrame
end

function OptionsLib:CreateOptionsPanel( panelName, frameName )
	if ( not panelName ) then return nil end
	frameName = frameName or BuildOptionsPanelFrameName( panelName )

	-- Options Panel
	local optionsPanel = CreateFrame( "Frame", frameName, scrollFrame )
	optionsPanel:Hide()
	optionsPanel.controls = {}
	optionsPanel.name = panelName
	for funcName, func in pairs( panelLib ) do optionsPanel[ funcName ] = func end

	optionsPanel.cancel = OptionsPanel_Cancel
	optionsPanel.default = OptionsPanel_Default
	optionsPanel.okay = OptionsPanel_Okay
	optionsPanel.refresh = OptionsPanel_Refresh
	optionsPanel:SetScript( "OnShow", OptionsPanel_OnShow )
	
	-- Create the icon
	local optionsIcon = optionsPanel:CreateTexture( frameName.."Icon", "ARTWORK" )
	optionsIcon:SetHeight( 25 )
	optionsIcon:SetWidth( 25 )
	optionsIcon:SetPoint( "TOPLEFT", optionsPanel, "TOPLEFT", 11, -11 )
	optionsIcon:Hide()
	optionsPanel.icon = optionsIcon

	-- Create the title (no position, it gets placed during refresh)
	local optionsTitle = optionsPanel:CreateFontString( frameName.."Title", "ARTWORK", "GameFontNormalLarge" )
	optionsTitle:SetText( panelName )
	optionsPanel.title = optionsTitle

	-- Create the description (no position, it gets placed during refresh)
	local optionsDescription = optionsPanel:CreateFontString( frameName.."Description", "ARTWORK", "GameFontHighlightSmall" )
	optionsDescription:SetJustifyH( "LEFT" )
	optionsDescription:SetJustifyV( "TOP" )
	optionsDescription:SetNonSpaceWrap( true )
	optionsDescription:Hide()
	optionsPanel.description = optionsDescription

	-- Scroll Frame
	local scrollFrame = CreateScrollFrame( optionsPanel )
	optionsPanel.scrollFrame = scrollFrame
	optionsPanel.controlContainer = scrollFrame.scrollChild

	-- Add the panel to the options UI
	InterfaceOptions_AddCategory( optionsPanel )
	return optionsPanel
end

------------------------------------------------------------------------------
-- Panel Functions
------------------------------------------------------------------------------

local function GetControlName( panel )
	local numControls = 0
	if ( panel.controls ) then numControls = #panel.controls end
	return panel:GetName().."Control"..tostring( numControls + 1 )
end

local function UpdateFontStringHeight( fontString, width )
	if ( width > 0 ) then
		local fontHeight = select( 2, fontString:GetFont() )
		local lineHeight = fontString:GetStringHeight()
		-- If the width is derived from left and right anchors, then the string height is
		-- correct and based on the font height.  If the width is set explicitly then the
		-- string height will be the total height of all the lines, and so we don't use it.
		if ( lineHeight > fontHeight ) then return end
		local stringWidth = fontString:GetStringWidth()
		local numLines = math.ceil( stringWidth / width )
		fontString:SetHeight( numLines * lineHeight )
	end
end

function panelLib:AddButton( text, tooltip, width )
	local controlName = GetControlName( self )
	local controlContainer = self.controlContainer or self
	local control = CreateFrame( "Button", controlName, controlContainer, "UIPanelButtonTemplate" )
	control.parent = self
	control.type = CONTROLTYPE_BUTTON
	for funcName, func in pairs( buttonLib ) do control[ funcName ] = func end
	
	control:SetHeight( 22 )
	
	width = tonumber( width or 0 )
	if ( width == 0 ) then width = 100 end
	control:SetWidth( width )
	
	control:SetText( text or "" )

	-- Add this control to the panel
	table.insert( self.controls, control )

	control:Show()
	return control
end

function panelLib:AddCheckButton( text, tooltip, isFullSize, defaultChecked, ... )
	local controlName = GetControlName( self )
	local control = nil
	local controlContainer = self.controlContainer or self
	if ( isFullSize ) then
		control = CreateFrame( "CheckButton", controlName, controlContainer, "InterfaceOptionsCheckButtonTemplate" )
--		control = CreateFrame( "CheckButton", controlName, controlContainer )

		control:SetWidth( 16 )
		control:SetHeight( 16 )
		control:SetHitRectInsets( 0, -100, 0, 0 )

		local tex = control:CreateTexture( nil, "ARTWORK" )
		tex:SetWidth( 24 )
		tex:SetHeight( 24 )
		tex:SetTexture( "Interface\\Buttons\\UI-CheckBox-Up" )
		tex:SetPoint( "CENTER", control, "CENTER", 0, 0 )
		tex:Show()
		control:SetNormalTexture( tex )

		tex = control:CreateTexture( nil, "OVERLAY" )
		tex:SetWidth( 24 )
		tex:SetHeight( 24 )
		tex:SetTexture( "Interface\\Buttons\\UI-CheckBox-Down" )
		tex:SetPoint( "CENTER", control, "CENTER", 0, 0 )
		tex:Show()
		control:SetPushedTexture( tex )

		tex = control:CreateTexture( nil, "OVERLAY" )
		tex:SetWidth( 24 )
		tex:SetHeight( 24 )
		tex:SetTexture( "Interface\\Buttons\\UI-CheckBox-Highlight" )
		tex:SetBlendMode( "ADD" )
		tex:SetPoint( "CENTER", control, "CENTER", 0, 0 )
		tex:Show()
		control:SetHighlightTexture( tex )

		tex = control:CreateTexture( nil, "OVERLAY" )
		tex:SetWidth( 24 )
		tex:SetHeight( 24 )
		tex:SetTexture( "Interface\\Buttons\\UI-CheckBox-Check" )
		tex:SetPoint( "CENTER", control, "CENTER", 0, 0 )
		tex:Show()
		control:SetCheckedTexture( tex )

		tex = control:CreateTexture( nil, "OVERLAY" )
		tex:SetWidth( 24 )
		tex:SetHeight( 24 )
		tex:SetTexture( "Interface\\Buttons\\UI-CheckBox-Check-Disabled" )
		tex:SetPoint( "CENTER", control, "CENTER", 0, 0 )
		tex:Show()
		control:SetDisabledCheckedTexture( tex )

		_G[ controlName.."Text" ]:SetPoint( "LEFT", control, "RIGHT", 4, 1 )
	else
		control = CreateFrame( "CheckButton", controlName, self, "InterfaceOptionsSmallCheckButtonTemplate" )
	end
	control.parent = self
	control.type = CONTROLTYPE_CHECKBOX
	for funcName, func in pairs( checkLib ) do control[ funcName ] = func end
	
	control:SetOffsetX( 3 )

	control.text = _G[ controlName.."Text" ]
	control.text:SetText( text )
	control.tooltipText = tooltip
	if ( defaultChecked ) then
		control.defaultValue = "1"
	else
		control.defaultValue = "0"
	end
	
	-- Control data source	
	if ( select( "#", ... ) > 0 ) then
		control:SetDatabase( ... )
	end

	control:SetScript( "OnShow", function( self )
		local value
		if ( self.shown ) then
			value = self:GetChecked()
		else
			value = self:GetDataValue()

			if ( not self.invert ) then
				self:SetChecked( value )
			else
				self:SetChecked( not value )
			end
			self.shown = true
		end

		if ( self.dependentControls ) then
			if ( value ) then
				for _, depControl in next, self.dependentControls do
					depControl:Enable()
				end
			else
				for _, depControl in next, self.dependentControls do
					depControl:Disable()
				end
			end
		end
	end )

	-- Add this control to the panel
	table.insert( self.controls, control )

	control:Show()
	return control
end

--function panelLib:AddDropdownControl( text, tooltip, ... )
--end

local EditBox_Backdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { top = 5, left = 5, bottom = 5, right = 5 },
}
local EditBox_ClearFocus = function( self )
	self:ClearFocus()
end
local EditBox_OnCursorChanged = ScrollingEdit_OnCursorChanged
local EditBox_OnShow = function( self )
	if ( not self.shown ) then	
		self:SetValue( self:GetDataValue() )
		self.shown = true
	end
end 
local EditBox_OnTextChanged = function( self )
	local parent = self:GetParent() -- Get the scrollframe
	ScrollingEdit_OnTextChanged( self, self:GetParent() )
	self.lengthText:SetFormattedText( "%d/%d Characters Used", self:GetNumLetters(), self:GetMaxLetters() )
end
local EditBox_OnUpdate = ScrollingEdit_OnUpdate
local EditBox_EditButton_OnClick = function( self )
	self.editBox:SetFocus()
end

function panelLib:AddEditBox( text, tooltip, multiLine, ... )
	local controlName = GetControlName( self )
	local controlContainer = self.controlContainer or self
	local control = CreateFrame( "Frame", controlName, controlContainer )
	control.parent = self
	control:SetHeight( 22 )
	control:SetWidth( 200 )
	control.type = CONTROLTYPE_EDIT
	for funcName, func in pairs( editLib ) do control[ funcName ] = func end
	
	local label = control:CreateFontString( controlName.."Label", "OVERLAY", "GameFontNormal" )
	label:SetPoint( "TOPLEFT" )
	label:SetText( text or "" )
	control.label = label
	
	local lengthText = control:CreateFontString( controlName.."Length", "OVERLAY", "GameFontDisableSmall" )
	lengthText:SetPoint( "TOPRIGHT" )
	lengthText:SetText( "" )
	control.lengthText = lengthText

	local scrollBackground = CreateFrame( "Frame", controlName.."Background", control )
	control.scrollBackground = scrollBackground
	scrollBackground:SetBackdrop( EditBox_Backdrop )
	scrollBackground:SetBackdropBorderColor( TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b )
	scrollBackground:SetBackdropColor( TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b )
	scrollBackground:SetWidth( 300 )
	scrollBackground:SetHeight( 300 )
	scrollBackground:SetPoint( "TOPLEFT", label, "BOTTOMLEFT" )
	scrollBackground:SetPoint( "BOTTOMRIGHT" )

	local scrollFrame = CreateFrame( "ScrollFrame", controlName.."ScrollFrame", scrollBackground, "UIPanelScrollFrameTemplate" )
	control.scrollFrame = scrollFrame
	scrollFrame:SetPoint( "TOPLEFT", 5, -4 )
	scrollFrame:SetPoint( "BOTTOMRIGHT", -26, 3 )

	local editBox = CreateFrame( "EditBox", controlName.."Edit", scrollFrame )
	control.editBox = editBox
	editBox.lengthText = lengthText
	editBox:ClearFocus()
	editBox:SetAutoFocus( false )
	editBox:SetCursorPosition( 0 )
	editBox:SetHeight( 300 )
	editBox:SetMaxLetters( 1000 )
	editBox:SetMultiLine( true )
	editBox:SetWidth( 250 )
	editBox:SetFontObject( GameFontHighlightSmall )
	editBox:SetScript( "OnEscapePressed", EditBox_ClearFocus )
	editBox:SetScript( "OnTextChanged", EditBox_OnTextChanged )
	editBox:SetScript( "OnCursorChanged", EditBox_OnCursorChanged )
	editBox:SetScript( "OnUpdate", EditBox_OnUpdate )
	scrollFrame:SetScrollChild( editBox )
	scrollFrame:UpdateScrollChildRect( editBox )

	local editButton = CreateFrame( "Button", controlName.."EditButton", scrollFrame )
	control.editButton = editButton
	editButton.editBox = editBox
	editButton:SetPoint( "TOPLEFT" )
	editButton:SetPoint( "BOTTOMRIGHT" )
	editButton:SetScript( "OnClick", EditBox_EditButton_OnClick )

	control:SetScript( "OnShow", EditBox_OnShow )

	-- Control data source	
	if ( select( "#", ... ) > 0 ) then
		control:SetDatabase( ... )
	end
	
	-- Add this control to the panel
	table.insert( self.controls, control )
	
	control:Show()
	return control	
end

function panelLib:AddFontString( text, r, g, b )
	local controlName = GetControlName( self )
--	local control = CreateFrame( "Frame", controlName, self )
	local controlContainer = self.controlContainer or self
	local control = controlContainer:CreateFontString( controlName, "OVERLAY", "GameFontHighlightSmall" )
	control.parent = self
	control.type = CONTROLTYPE_FONTSTRING
	for funcName, func in pairs( fontStringLib ) do control[ funcName ] = func end
	control:SetJustifyH( "LEFT" )
	control:SetJustifyV( "TOP" )
	control:SetNonSpaceWrap( true )
	control:SetText( text )
	if ( r and g and b ) then
		control:SetTextColor( r, g, b )
	end

	-- Add this control to the panel
	table.insert( self.controls, control )

	control:Show()
	return control
end

local GroupBoxBackdrop  = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

function panelLib:AddGroupBox( text )
	local controlName = GetControlName( self )
	local controlContainer = self.controlContainer or self
	local control = CreateFrame( "Frame", controlName, controlContainer )
	control.parent = self
	control.type = CONTROLTYPE_GROUPBOX
	control.controls = {}
	for funcName, func in pairs( groupLib ) do control[ funcName ] = func end
	control:SetOffsetY( -5 )
	control:SetPaddingX( 10 )
	control:SetPaddingY( 0 )
	
	local title = control:CreateFontString( controlName.."Title", "OVERLAY", "GameFontNormal" )
	title:SetPoint( "TOPLEFT", 1, -2 )
	title:SetJustifyH( "CENTER" )
	title:SetJustifyV( "CENTER" )
	title:SetHeight( 16 )
	title:SetText( text )
	title:Show()
	control.title = title

	local controlContainer = CreateFrame( "Frame", controlName.."Container", control )
	controlContainer:SetPoint( "TOP", title, "BOTTOM" )
	controlContainer:SetPoint( "BOTTOMLEFT" )
	controlContainer:SetPoint( "BOTTOMRIGHT" )
	controlContainer:SetBackdrop( GroupBoxBackdrop )
	controlContainer:SetBackdropColor( 0, 0, 0, 0.5 )
	controlContainer:SetBackdropBorderColor( 0.5, 0.5, 0.5 )
	control.controlContainer = controlContainer

	-- Add this control to the panel
	table.insert( self.controls, control )

	control:Show()
	return control
end

local SliderBackdrop  = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	tile = true,
	tileSize = 8,
	edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}

local function Slider_OnShow( self )
	if ( not self.shown ) then
		self:SetValue( self:GetDataValue() or self.defaultValue )
		self.shown = true
	end
end

function panelLib:AddSlider( text, tooltip, minValue, maxValue, valueStep, defaultValue, ... )
	minValue = tonumber( minValue ) or 0
	maxValue = tonumber( maxValue ) or 1

	local controlName = GetControlName( self )

	local controlContainer = self.controlContainer or self
	local control = CreateFrame( "Frame", controlName, controlContainer )
	control.parent = self
	control:SetHeight( 42 )
	control:SetWidth( 200 )
	control.type = CONTROLTYPE_SLIDER

	control.defaultValue = defaultValue or minValue
	control.tooltipText = tooltip

	control:SetScript( "OnShow", Slider_OnShow )

	for funcName, func in pairs( sliderLib ) do control[ funcName ] = func end

	local slider = CreateFrame( "Slider", nil, control )
	slider:SetPoint( "TOPLEFT", control, "TOPLEFT", 0, -14 )
	slider:SetPoint( "TOPRIGHT", control, "TOPRIGHT", 0, -14 )
	slider:SetBackdrop( SliderBackdrop )
	slider:SetHeight( 15 )
	slider:SetHitRectInsets( 0, 0, -10, 0 )
	slider:SetMinMaxValues( minValue, maxValue )
	slider:SetOrientation( "HORIZONTAL" )
	slider:SetThumbTexture( "Interface\\Buttons\\UI-SliderBar-Button-Horizontal" )
	slider.thumb = slider:GetThumbTexture()
	slider:SetValueStep( tonumber( valueStep ) or 1 )
	slider:Show()
	control.slider = slider

	local title = slider:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
	title:SetPoint( "BOTTOM", slider, "TOP", 0, 0 )
	title:SetJustifyH( "CENTER" )
	title:SetJustifyV( "CENTER" )
	title:SetHeight( 16 )
	title:SetText( text )
	title:Show()
	control.title = title

	local minText = slider:CreateFontString( nil, "OVERLAY", "GameFontHighlightSmall" )
	minText:SetPoint( "TOPLEFT", slider, "BOTTOMLEFT", 2, -3 )
	minText:SetText( tostring( minValue ) )
	minText:SetJustifyH( "LEFT" )
	minText:SetJustifyV( "TOP" )
	minText:Show()
	control.minText = minText

	local maxText = slider:CreateFontString( nil, "OVERLAY", "GameFontHighlightSmall" )
	maxText:SetPoint( "TOPRIGHT", slider, "BOTTOMRIGHT", -2, -3 )
	maxText:SetText( tostring( maxValue ) )
	maxText:SetJustifyH( "RIGHT" )
	maxText:SetJustifyV( "TOP" )
	maxText:Show()
	control.maxText = maxText

	local value = slider:CreateFontString( nil, "OVERLAY", "GameFontHighlightSmall" )
	value:SetPoint( "TOP", slider, "BOTTOM", 0, 0 )
	value:SetHeight( 14 )
	value:SetJustifyH( "CENTER" )
	value:SetJustifyV( "TOP" )
	value:Show()
	control.value = value

	-- Set the slider's initial value
	slider:SetScript( "OnValueChanged", Slider_UpdateValueText )
	slider:SetValue( defaultValue or minValue )

	-- Control data source	
	if ( select( "#", ... ) > 0 ) then
		control:SetDatabase( ... )
	end

	-- Add this control to the panel
	table.insert( self.controls, control )

	control:Show()
	return control
end

function panelLib:AddSubPanel( panelName )
	if ( not panelName ) then return nil end

	local numPanels = 0
	if ( not self.panels ) then self.panels = {} end
	local frameName = self:GetName().."Panel"..tostring( #self.panels + 1 )

	local panel = CreateFrame( "Frame", frameName )
	panel:Hide()
	panel.controls = {}
	panel.name = panelName
	panel.parent = self.name
	for funcName, func in pairs( panelLib ) do panel[ funcName ] = func end

	panel.cancel = OptionsPanel_Cancel
	panel.default = OptionsPanel_Default
	panel.okay = OptionsPanel_Okay
	panel.refresh = OptionsPanel_Refresh
	panel:SetScript( "OnShow", OptionsPanel_OnShow )

	-- Create the icon
	local panelIcon = panel:CreateTexture( frameName.."Icon", "ARTWORK" )
	panelIcon:SetHeight( 25 )
	panelIcon:SetWidth( 25 )
	panelIcon:SetPoint( "TOPLEFT", panel, "TOPLEFT", 11, -11 )
	panelIcon:Hide()
	panel.icon = panelIcon

	-- Create the title (no position, it gets placed during refresh)
	local panelTitle = panel:CreateFontString( frameName.."Title", "ARTWORK", "GameFontNormalLarge" )
	panelTitle:SetText( panelName )
	panel.title = panelTitle

	-- Create the description (no position, it gets placed during refresh)
	local panelDescription = panel:CreateFontString( frameName.."Description", "ARTWORK", "GameFontHighlightSmall" )
	panelDescription:SetJustifyH( "LEFT" )
	panelDescription:SetJustifyV( "TOP" )
	panelDescription:SetNonSpaceWrap( true )
	panelDescription:Hide()
	panel.description = panelDescription

	-- Scroll Frame
	local scrollFrame = CreateScrollFrame( panel )
	panel.scrollFrame = scrollFrame
	panel.controlContainer = scrollFrame.scrollChild

	-- Add the panel to the parent
	table.insert( self.panels, panel )

	-- Add the panel to the options UI
	InterfaceOptions_AddCategory( panel )
	return panel
end

function panelLib:GetControlSpacing()
	return math.max( self.controlSpacing or CONTROL_SPACING_SIZE, CONTROL_SPACING_MIN )
end

function panelLib:GetIndentSize( size )
	return math.max( self.indentSize or INDENT_SIZE, INDENT_MIN )
end

function panelLib:GetDatabase()
	return getObjectDatabaseValue( self, _G )
end

function panelLib:GetPaddingX()
	return self.paddingX or DEFAULT_PADDING_X
end

function panelLib:GetPaddingY()
	return self.paddingY or DEFAULT_PADDING_Y
end

function panelLib:OrganizeControls()
	local optionsTitle = self.title
	local optionsIcon = self.icon
	local optionsDescription = self.description
	local optionsScrollFrame = self.scrollFrame
	local topFrame = self

	local paddingX = self:GetPaddingX()
	local paddingY = self:GetPaddingY()
	local frameWidth = self:GetWidth()
	if ( frameWidth == 0 ) then
		if ( self.parent ) then
			frameWidth = self.parent:GetWidth()
		elseif ( self:GetParent() ) then
			frameWidth = self:GetParent():GetWidth()
		else
			frameWidth = InterfaceOptionsFramePanelContainer:GetWidth()
		end
		self:SetWidth( frameWidth )
	end
	if ( self.controlContainer ) then self.controlContainer:SetWidth( frameWidth ) end
	frameWidth = frameWidth - ( paddingX * 2 )

	if ( optionsIcon ) then
		topFrame = optionsIcon

		if ( optionsTitle ) then
			if ( optionsIcon:IsShown() ) then
				optionsTitle:SetPoint( "LEFT", optionsIcon, "RIGHT", 3, 0 )
			else
				optionsTitle:SetPoint( "LEFT", optionsIcon, "LEFT", 0, 0 )
			end
		end
	end

	if ( optionsDescription and optionsDescription:IsShown() ) then
		topFrame = optionsDescription
		optionsDescription:SetPoint( "TOPLEFT", self, "TOPLEFT", paddingX, -43 )
		optionsDescription:SetPoint( "TOPRIGHT", self, "TOPRIGHT", -paddingX, -43 )
		UpdateFontStringHeight( optionsDescription, frameWidth )
	end
	
	local controlSpacing = self:GetControlSpacing()
	if ( optionsScrollFrame ) then
		optionsScrollFrame:SetPoint( "TOP", topFrame, "BOTTOM", 0, -(controlSpacing / 2) )
		optionsScrollFrame:SetPoint( "BOTTOMLEFT", 0, 6 )
		optionsScrollFrame:SetPoint( "BOTTOMRIGHT", 0, 6 )
	end

	-- Begin the control layout
	local container = self.controlContainer or self
	
	-- Create the columns
	local numColumns = 1
	for k, control in pairs( self.controls ) do
		numColumns = math.max( numColumns, control.columnNumber or 1 )
	end
	if ( not self.columns ) then self.columns = {} end
	for columnNum = #self.columns + 1, numColumns, 1 do
		local column = CreateFrame( "Frame", self:GetName().."Column"..columnNum, container )
		table.insert( self.columns, column )
	end
	
	-- Arrange the columns
	local columnSpacing = 10	-- Make this configurable at some point
	local columnWidth = ( frameWidth / numColumns ) - ( columnSpacing * ( numColumns - 1 ) )

	--local previousFrames = {}
	local columnHeights = {}
	local previousIndent = {}
	local columns = self.columns
	for columnNum, column in pairs( columns ) do
		column:ClearAllPoints()
		if ( columnNum == 1 ) then
			column:SetPoint( "TOPLEFT", paddingX, -paddingY )
			column:SetPoint( "BOTTOMLEFT", paddingX, paddingY )
		else
			local prevColumn = columns[ columnNum - 1 ]
			column:SetPoint( "TOPLEFT", prevColumn, "TOPRIGHT", DEFAULT_COLUMN_PADDING, 0 )
			column:SetPoint( "BOTTOMLEFT", prevColumn, "BOTTOMRIGHT", DEFAULT_COLUMN_PADDING, 0 )
		end
		
		if ( columnNum == numColumns ) then
			column:SetPoint( "TOPRIGHT", -paddingX, -paddingY )
			column:SetPoint( "BOTTOMRIGHT", -paddingX, paddingY )
		end

		column:SetWidth( columnWidth )
		
		columnHeights[ columnNum ] = 0
		--previousFrames[ columnNum ] = column
		previousIndent[ columnNum ] = 0
	end

	-- Place the controls
	local indentSize = self:GetIndentSize()
	for k, control in pairs( self.controls ) do
		local columnNumber = control.columnNumber or 1
		local column = self.columns[ columnNumber ]
		control:SetParent( column )
		
		local columnHeight = columnHeights[ columnNumber ]
		--local previousFrame = previousFrames[ columnNumber ]
		local indent = ( control.indentLevel or 0 ) - previousIndent[ columnNumber ]
		local indentWidth = indent * indentSize
		
		--if ( previousFrame == column ) then
		--	-- Topmost control in this column
		--	-- X offset: this control's indent size + the control's X offset
		--	-- Y offset: parent's control spacing + the control's Y offset
		--	control:SetPoint( "TOPLEFT", previousFrame, "TOPLEFT",
		--		indentWidth + control:GetOffsetX(),
		--		-( controlSpacing + control:GetOffsetY() ) )
		--else
		--	-- Sequential control in this column
		--	-- X offset: this control's indent size (parent X padding is implicit
		--	--		as it's aligned to a previous control that already includes it)
		--	-- Y offset: parent's control spacing + this control's Y offset
		--	local previousOffsetX = 0
		--	if ( previousFrame.GetOffsetX ) then previousOffsetX = previousFrame:GetOffsetX() end
		--	control:SetPoint( "TOPLEFT", previousFrame, "BOTTOMLEFT",
		--		indentWidth + control:GetOffsetX() - previousOffsetX,
		--		-( controlSpacing + control:GetOffsetY() ) )
		--end

		control:SetPoint( "TOPLEFT", column, "TOPLEFT",
			indentWidth + control:GetOffsetX(),
			-( columnHeight + controlSpacing + control:GetOffsetY() ) )
		
		if ( control.type == CONTROLTYPE_BUTTON ) then
			-- Currently no special processing
		elseif ( control.type == CONTROLTYPE_CHECKBOX ) then
			-- Currently no special processing
		elseif ( control.type == CONTROLTYPE_FONTSTRING ) then
			local maxControlWidth = column:GetWidth() - indentWidth
			if ( ( maxControlWidth > 0 ) and ( control:GetWidth() > maxControlWidth ) ) then
				control:SetWidth( maxControlWidth )
			end

		elseif ( control.type == CONTROLTYPE_GROUPBOX ) then
			control:SetPoint( "RIGHT", column, "RIGHT" )
			control:OrganizeControls()
			
			local columnHeights = {}
			for k, childControl in pairs( control.controls ) do
				local columnNumber = childControl.columnNumber or 1
				local columnHeight = columnHeights[ columnNumber ] or 0
				columnHeights[ columnNumber ] = columnHeight + childControl:GetHeight() +
					controlSpacing + childControl:GetOffsetY()
			end
			local height = 0
			for k, columnHeight in pairs( columnHeights ) do
				height = math.max( height, columnHeight )
			end
			height = height + control.title:GetHeight() + 1
			control:SetHeight( height + controlSpacing + ( control:GetPaddingY() * 2 ) )
			
		elseif ( control.type == CONTROLTYPE_EDIT ) then
			control:SetPoint( "RIGHT", column, "RIGHT" )
			control:SetWidth( column:GetWidth() )	-- Artificial, but helpful
			control.editBox:SetWidth( control:GetWidth() - 33 )	-- Need to figure out why this is right
			
		else
			control:SetPoint( "RIGHT", column, "RIGHT" )
		end
		
		if ( control.fullWidth ) then
			for num = 1, #columnHeights, 1 do
				columnHeights[ num ] = columnHeights[ num ] + control:GetHeight() + controlSpacing + control:GetOffsetY()
			end
		else
			columnHeights[ columnNumber ] = columnHeights[ columnNumber ] + control:GetHeight() + controlSpacing + control:GetOffsetY()
		end
		--previousFrames[ columnNumber ] = control
		previousIndent[ columnNumber ] = math.max( indent, 0 )
	end
	
	-- If there's a scroll frame, determine if we should show the scrollbar or not
	if ( optionsScrollFrame ) then
		--local columnHeights = {}
		--for k, childControl in pairs( self.controls ) do
		--	local columnNumber = childControl.columnNumber or 1			
		--	local columnHeight = columnHeights[ columnNumber ] or 0
		--	columnHeights[ columnNumber ] = columnHeight + childControl:GetHeight() +
		--		controlSpacing + childControl:GetOffsetY()
		--end
		local height = 0
		for k, columnHeight in pairs( columnHeights ) do
			height = math.max( height, columnHeight )
		end

		local scrollSize = height - optionsScrollFrame:GetHeight() - 1
		optionsScrollFrame:EnableMouseWheel( scrollSize > 0 )
		if ( scrollSize > 0 ) then
			-- We're scrolling, so pad the bottom slightly for prettiness
			height = height + controlSpacing

			optionsScrollFrame.scrollChild:SetHeight( height )
			optionsScrollFrame.scrollBar:SetValueStep( scrollSize / 4 )
			optionsScrollFrame.scrollBar:SetMinMaxValues( 0, scrollSize )
			optionsScrollFrame.scrollBar:Show()
		else
			optionsScrollFrame.scrollBar:Hide()
		end
	end
end

function panelLib:SetCancelFunc( func )
	self.onCancel = func
end

function panelLib:SetControlSpacing( spacing )
	self.controlSpacing = spacing
end

function panelLib:SetDatabase( ... )
	self.Database = { ... }
end

function panelLib:SetDescription( description )
	local optionsDescription = self.description
	optionsDescription:SetText( description )
	if ( description and ( type( description ) == "string" ) and ( description:len() > 0 ) ) then
		optionsDescription:Show()
	else
		optionsDescription:Hide()
	end
end

function panelLib:SetIcon( texture )
	local optionsIcon = self.icon
	optionsIcon:SetTexture( texture )
	if ( texture ) then
		optionsIcon:Show()
	else
		optionsIcon:Hide()
	end
end

function panelLib:SetIndentSize( size )
	self.indentSize = size
end

function panelLib:SetOkayFunc( func )
	self.onOkay = func
end

function panelLib:SetPaddingX( padding )
	self.paddingX = padding
end

function panelLib:SetPaddingY( padding )
	self.paddingY = padding
end

function panelLib:ShowOptions( expand )
	-- If we're set to expand, and have a subpanel, open the last one first to get the expansion
	if ( expand and self.panels and ( #self.panels > 0 ) ) then
		InterfaceOptionsFrame_OpenToCategory( self.panels[ #self.panels ] )
	end
	
	-- Open the main panel
	InterfaceOptionsFrame_OpenToCategory( self )
end

------------------------------------------------------------------------------
-- Control Functions
------------------------------------------------------------------------------
function controlLib:GetDataValue()
	return getObjectDatabaseValue( self, self.parent:GetDatabase() )
end

function controlLib:GetOffsetX()
	return self.offsetX or 0
end

function controlLib:GetOffsetY()
	return self.offsetY or 0
end

function controlLib:SetColumnNumber( columnNumber )
	self.columnNumber = columnNumber
end

function controlLib:SetDependantOn( parentControl )
	if ( not parentControl.dependentControls ) then
		parentControl.dependentControls = {}
	end
	table.insert( parentControl.dependentControls, self )
end

function controlLib:SetDatabase( ... )
	self.Database = { ... }
end

function controlLib:SetDataValue( value )
	setObjectDatabaseValue( self, self.parent:GetDatabase(), value )
end

function controlLib:SetFullWidth( value )
	self.fullWidth = value
end

function controlLib:SetOffsetX( value )
	self.offsetX = value
end

function controlLib:SetOffsetY( value )
	self.offsetY = value
end

function controlLib:SetTooltip( tooltipText )
	self.tooltipText = tooltipText
end

function controlLib:SetIndent( indentLevel )
	self.indentLevel = math.max( tonumber( indentLevel ), 0 )
end

------------------------------------------------------------------------------
-- Button Functions
------------------------------------------------------------------------------
for k, v in pairs( controlLib ) do buttonLib[k] = v end

------------------------------------------------------------------------------
-- Checkbox Functions
------------------------------------------------------------------------------
for k, v in pairs( controlLib ) do checkLib[k] = v end

function checkLib:Disable()
	local color = GRAY_FONT_COLOR
	self.text:SetTextColor( color.r, color.g, color.b )
	getmetatable( self ).__index.Disable( self )
end

function checkLib:Enable()
	local color = HIGHLIGHT_FONT_COLOR
	self.text:SetTextColor( color.r, color.g, color.b )
	getmetatable( self ).__index.Enable( self )
end

function checkLib:GetValue()
	return self:GetChecked()
end

function checkLib:SetValue( value )
	self:SetChecked( value )
end

------------------------------------------------------------------------------
-- Editbox Functions
------------------------------------------------------------------------------
for k, v in pairs( controlLib ) do editLib[k] = v end

function editLib:Disable()
	self.label:Disable()
	self.editButton:Disable()
	self.editBox:Disable()
end

function editLib:Enable()
	self.label:Enable()
	self.editButton:Enable()
	self.editBox:Enable()
end

function editLib:GetValue()
	return self.editBox:GetText()
end

function editLib:SetMaxLetters( value )
	self.editBox:SetMaxLetters( tonumber( value ) or 1 )
end

function editLib:SetValue( value )
	return self.editBox:SetText( value or "" )
end

------------------------------------------------------------------------------
-- Fontstring Functions
------------------------------------------------------------------------------
fontStringLib.GetOffsetX = controlLib.GetOffsetX
fontStringLib.GetOffsetY = controlLib.GetOffsetY
fontStringLib.SetDependantOn = controlLib.SetDependantOn
fontStringLib.SetOffsetX = controlLib.SetOffsetX
fontStringLib.SetOffsetY = controlLib.SetOffsetY

------------------------------------------------------------------------------
-- Groupbox Functions
------------------------------------------------------------------------------
for k, v in pairs( panelLib ) do groupLib[k] = v end
groupLib.GetOffsetX = controlLib.GetOffsetX
groupLib.GetOffsetY = controlLib.GetOffsetY
groupLib.SetDatabase = nil
groupLib.SetDependantOn = controlLib.SetDependantOn
groupLib.SetOffsetX = controlLib.SetOffsetX
groupLib.SetOffsetY = controlLib.SetOffsetY

function groupLib:Disable()
	local color = GRAY_FONT_COLOR
	self.title:SetTextColor( color.r, color.g, color.b )
	for k, control in pairs( self.controls ) do
		control:Disable()
	end
end

function groupLib:Enable()
	local color = NORMAL_FONT_COLOR
	self.title:SetTextColor( color.r, color.g, color.b )
	for k, control in pairs( self.controls ) do
		control:Enable()
	end
end

function groupLib:GetDatabase()
	return self.parent:GetDatabase()
end

function groupLib:SetDataValues()
	for k, control in pairs( self.controls ) do
		if ( control.SetDataValue and control.GetValue ) then
			control:SetDataValue( control:GetValue() )
		end
	end
end

------------------------------------------------------------------------------
-- Slider Functions
------------------------------------------------------------------------------
for k, v in pairs( controlLib ) do sliderLib[k] = v end

function sliderLib:Disable()
	self.slider:Disable()
	self.slider.thumb:Hide()
	local color = GRAY_FONT_COLOR
	self.title:SetTextColor( color.r, color.g, color.b )
	self.minText:SetTextColor( color.r, color.g, color.b )
	self.maxText:SetTextColor( color.r, color.g, color.b )
	self.value:SetTextColor( color.r, color.g, color.b )
end

function sliderLib:Enable()
	self.slider:Enable()
	self.slider.thumb:Show()

	local color = NORMAL_FONT_COLOR
	self.title:SetTextColor( color.r, color.g, color.b )

	color = HIGHLIGHT_FONT_COLOR
	self.minText:SetTextColor( color.r, color.g, color.b )
	self.maxText:SetTextColor( color.r, color.g, color.b )
	self.value:SetTextColor( color.r, color.g, color.b )
end

function sliderLib:GetValue()
	return self.slider:GetValue()
end

function sliderLib:SetValue( value )
	self.slider:SetValue( value )
end

function sliderLib:SetValueFormat( valueFormat )
	local slider = self.slider
	slider.valueFormat = valueFormat
	Slider_UpdateValueText( slider )
end

------------------------------------------------------------------------------
-- End Library
end
------------------------------------------------------------------------------
