local config = CreateFrame("Frame");

SpellOverlayTimerConfig = config;
function config:SetDefaultConfig()
	SpellOverlayTimer_Config = {};
	SpellOverlayTimer_Config.FontSize = 25;
	SpellOverlayTimer_Config.FontColor = {1,0,0,1};
	SpellOverlayTimer_Config.FontPosition = "BOTTOM";
end

function config:SetCurrentConfig()
	
	--config.playtime:SetValue(AddonSound_Config.PlayTime);
	
end

function config:ChangeState(self,value)
	if(value == true) then
		local newval =config.fontsize:GetValue();
		config.currentfontsize:SetText(newval);
		SpellOverlayTimer_Config.FontSize=newval;
		config.OverlayTimerPreview:SetTextHeight(newval);
	end
end



local function changedCallback(restore)
 local newR, newG, newB, newA;
 if restore then
   newR, newG, newB, newA = unpack(restore);
 else
   newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
 end
 
 r, g, b, a = newR, newG, newB, newA;
 _G["SpellOverlayTimer_FontColorButtonColorSwatch"]:SetVertexColor(r,g,b,a);
 config.OverlayTimerPreview:SetTextColor(r,g,b,a);
 SpellOverlayTimer_Config.FontColor = {r, g, b, a};
end

function config:ConfigFontColor_OnClick()
	
	local r,g,b,a = unpack(SpellOverlayTimer_Config.FontColor);
	ColorPickerFrame:SetColorRGB(r,g,b);
	ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a;
	ColorPickerFrame.previousValues = {r,g,b,a};
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 
	changedCallback, changedCallback, changedCallback;
	ColorPickerFrame:Hide(); 
	ColorPickerFrame:Show();

end

function config:ChangeFontPosition ()
	SpellOverlayTimer_Config.FontPosition = self.value;								
	UIDropDownMenu_SetSelectedValue(config.ConfigFontPosition,self.value,self.text);
end

function config:Init()
	if not (SpellOverlayTimer_Config) then
		config:SetDefaultConfig();
	end

	config.name = "Spell Overlay Timer";
	local fontsize = CreateFrame( "Slider", "SpellOverlayTimer_FontSizeSlider", config, "OptionsSliderTemplate" );
	config.fontsize = fontsize;
	fontsize.id = "fontsize";
	fontsize:SetPoint( "TOPLEFT", 16, -16 );
	fontsize:SetWidth(300)
	fontsize:SetHeight(20)
	fontsize:SetOrientation('HORIZONTAL');
	fontsize:SetScript("OnValueChanged",config.ChangeState);
	fontsize:SetMinMaxValues(1, 50) ;
	fontsize:SetValueStep(1);
	fontsize:SetValue(SpellOverlayTimer_Config.FontSize);
	_G[ fontsize:GetName().."Low" ]:SetText( '1' );
	_G[ fontsize:GetName().."High" ]:SetText( '30' );
	_G[ fontsize:GetName().."Text" ]:SetText( '|c00dfb802Fontsize');
 
	local currentfontsize = config:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	config.currentfontsize = currentfontsize;
	currentfontsize:SetPoint( "CENTER",  fontsize, "BOTTOM", 0, -5);
	currentfontsize:SetText( SpellOverlayTimer_Config.FontSize );
 
	
	local  ConfigFontColor = CreateFrame( "Button", "SpellOverlayTimer_FontColorButton", config );
	config.ConfigFontColor = ConfigFontColor;
	ConfigFontColor:SetHeight(40);
	ConfigFontColor:SetWidth(40);
	ConfigFontColor:SetScript("OnClick", config.ConfigFontColor_OnClick)
	ConfigFontColor:SetPoint( "BOTTOMLEFT" , fontsize, 0,-50);
	
	
	local colorSwatch = ConfigFontColor:CreateTexture("SpellOverlayTimer_FontColorButtonColorSwatch", "OVERLAY")
	colorSwatch:SetWidth(19)
	colorSwatch:SetHeight(19)
	colorSwatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
	colorSwatch:SetPoint("LEFT")
	colorSwatch:SetVertexColor(unpack(SpellOverlayTimer_Config.FontColor));
	
	
	local texture = ConfigFontColor:CreateTexture(nil, "BACKGROUND")
	texture:SetWidth(16)
	texture:SetHeight(16)
	texture:SetTexture(1, 1, 1)
	texture:SetPoint("CENTER", colorSwatch)
	texture:Show()
	
	
	local ConfigFontColorLabel = config:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	config.ConfigFontColorLabel = ConfigFontColorLabel;
	ConfigFontColorLabel:SetPoint( "RIGHT" , ConfigFontColor,"RIGHT",30,0);
	ConfigFontColorLabel:SetText( " |c00dfb802Fontcolor" );
	ConfigFontColor:Show();
	
	local ConfigFontPositionLabel = config:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	config.ConfigFontPositionLabel = ConfigFontPositionLabel;
	ConfigFontPositionLabel:SetPoint( "BOTTOMLEFT" , ConfigFontColor,0,-16);
	ConfigFontPositionLabel:SetText( "|c00dfb802Font Position" );
	ConfigFontPositionLabel:Show();
	
	local ConfigFontPosition = CreateFrame("Frame", "SpellOverlayTimer_FontPosition", config, "UIDropDownMenuTemplate")
	config.ConfigFontPosition = ConfigFontPosition;
	ConfigFontPosition:SetPoint("RIGHT", ConfigFontPositionLabel,30, 0)
	ConfigFontPosition.initialize = function () 
		
		info = UIDropDownMenu_CreateInfo()
		info.text = "Bottom";
		info.func = config.ChangeFontPosition
		info.value = "BOTTOM";
		if(SpellOverlayTimer_Config.FontPosition == info.value) then
			info.checked = true;
		else
			info.checked = false;
		end
		UIDropDownMenu_AddButton(info)
		info = UIDropDownMenu_CreateInfo()
		info.text = "Top";
		info.func = config.ChangeFontPosition
		info.value = "TOP";
		if(SpellOverlayTimer_Config.FontPosition == info.value) then
			info.checked = true;
			
		else
			info.checked = false;
		end
		UIDropDownMenu_AddButton(info)
	
	end;
	UIDropDownMenu_Initialize(ConfigFontPosition, ConfigFontPosition.initialize)
	UIDropDownMenu_SetSelectedValue(ConfigFontPosition,SpellOverlayTimer_Config.FontPosition );
	
	
	local ConfigFontColorPreview = config:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	config.ConfigFontColorPreview = ConfigFontColorPreview;
	ConfigFontColorPreview:SetPoint( "BOTTOMLEFT" , ConfigFontPositionLabel,0,-22);
	ConfigFontColorPreview:SetText( "|c00dfb802Fontsize and color Preview" );
	
	local OverlayTimerPreview = config:CreateFontString( nil, "ARTWORK", "CombatTextFont");
	config.OverlayTimerPreview = OverlayTimerPreview;
	OverlayTimerPreview:SetText( "20 s" );
	OverlayTimerPreview:SetTextHeight(SpellOverlayTimer_Config.FontSize);
	OverlayTimerPreview:SetPoint("BOTTOMLEFT", ConfigFontColorPreview, 0 , -60);
	OverlayTimerPreview:SetTextColor(unpack(SpellOverlayTimer_Config.FontColor));
	
	


 
 InterfaceOptions_AddCategory(config);


 

end