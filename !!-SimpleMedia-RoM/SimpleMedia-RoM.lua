--[[
    SimpleMedia-RoM
    
    Registers a few standard Runes of Magic media files with SimpleMediaLib.
    All files listed here are already present in the game. This mereyl makes
    them visible through SimpleMediaLib.
    
    This also serves as an example add-on for creating other SimpleMediaLib collections.
    
    Version: 1.0
    Author: Peryl
    License: Public Domain
    
]]--

--[[ Get a reference to SimpleMediaLib ]]--

local smlib = LibStub:GetLibrary("SimpleMediaLib", true);
if(not smlib) then
    DEFAULT_CHAT_FRAME:AddMessage("[SimpleMedia-RoM]: Can't find SimpleMediaLib. Aborting.");
    return; -- Exit if SimpleMediaLib is not loaded
end


--[[ The list of media files to be registered ]]--

local MediaInfo = {
    --[[ RoM default fonts. (Font names taken from the font file itself) ]]--
    
    { type = "Font", name = "AR HeiU30 Medium", file = "fonts/dfheimdu.ttf", scale = 1.0 },
    { type = "Font", name = "Candara Bold",  file = "fonts/dfheimdu_id.ttf", scale = 1.0 },
    { type = "Font", name = "MS PGothic",  file = "fonts/dfheimdu_jp.ttf", scale = 1.0 },
    { type = "Font", name = "Daum Regular",  file = "fonts/dfheimdu_kr.ttf", scale = 1.0 },
    { type = "Font", name = "DejaVu Sans Condensed",  file = "fonts/dfheimdu_ru.ttf", scale = 1.0 },
    { type = "Font", name = "Arial",  file = "fonts/dfheimdu_vn.ttf", scale = 1.0 },

    
    --[[ Some RoM images that may be useful. ]]--
  
    -- Bars
    { type = "Image", category = "Bar", name = "Banto Bar", file = "interface/common/bar/bantobar", width = 256, height = 32 },
    { type = "Image", category = "Bar", name = "Gloss", file = "interface/common/bar/gloss", width = 256, height = 32 },
    { type = "Image", category = "Bar", name = "Round", file = "interface/common/bar/round", width = 256, height = 32 },
    { type = "Image", category = "Bar", name = "Smooth", file = "interface/common/bar/smooth", width = 256, height = 32 },
    { type = "Image", category = "Bar", name = "Status Bar", file = "interface/common/bar/statusbar", width = 256, height = 32 },
    { type = "Image", category = "Bar", name = "Steel", file = "interface/common/bar/bantobar", width = 256, height = 32 },
    
    -- Common panels
    { type = "Image", category = "Background", name = "Common Panel 1", file = "interface/common/panelcommonframe", width = 256, height = 256 },
    { type = "Image", category = "Background", name = "Common Panel 2", file = "interface/common/panelcommonframe2", width = 256, height = 256 },
    { type = "Image", category = "Background", name = "Common Panel 3", file = "interface/common/panelcommonframe3", width = 64, height = 64 },
    { type = "Image", category = "Background", name = "Common Title Bar", file = "interface/common/panelframetitle", width = 512, height = 32 },
    { type = "Image", category = "Background", name = "Portrait Frame", file = "interface/common/panelportraitframe", width = 128, height = 128 },
    { type = "Image", category = "Background", name = "Common Seperator", file = "interface/common/panelseperate-horizontalline", width = 256, height = 4 },
    
    -- Highlights
    { type = "Image", category = "Highlight", name = "Highlight - Blue", file = "interface/buttons/listitemhighlight", width = 128, height = 16 },
    { type = "Image", category = "Highlight", name = "Highlight - Dark Blue", file = "interface/auctionframe/auctionframeitem-highlight", width = 128, height = 32 },
    { type = "Image", category = "Highlight", name = "Highlight - Orange", file = "interface/transportbook/tb_highlight-01", width = 128, height = 32 },
    { type = "Image", category = "Highlight", name = "Highlight - Green", file = "interface/transportbook/tb_highlight-02", width = 128, height = 32 },
    
    -- Dialog borders and backdrops
    { type = "Image", category = "Border", name = "Dialog Border - Dark", file = "interface/dialogframe/backupdialogbox-border", width = 256, height = 32 },
    { type = "Image", category = "Border", name = "Dialog Border - Light", file = "interface/dialogframe/dialogbox-border", width = 256, height = 32 },
    { type = "Image", category = "Background", name = "Dialog Background", file = "interface/dialogframe/dialogbox-background", width = 64, height = 64 },
    
    -- Tooltip border and backdrop
    { type = "Image", category = "Border", name = "Tooltip Border", file = "interface/tooltips/tooltip-border", width = 128, height = 16 },
    { type = "Image", category = "Background", name = "Tooltip Background", file = "interface/tooltips/tooltip-background", width = 16, height = 16 },
    { type = "Image", category = "Misc", name = "Tooltip Seperator", file = "interface/tooltips/tooltip-seperator", width = 256, height = 4 },
    
    
    
    --[[ Some Default RoM Sound Effects ]]--
    
    { type = "Sound", category = "Effect", name = "Add Rune", file = "sound/interface/add_rune" },
    { type = "Sound", category = "Effect", name = "Success Ding", file = "sound/interface/gather_herb_success" },
    { type = "Sound", category = "Effect", name = "Failed Gather", file = "sound/interface/gather_herb_failed" },
    { type = "Sound", category = "Effect", name = "Quest Complete", file = "sound/interface/questitemfinish" },
    { type = "Sound", category = "Effect", name = "Refine Breakdown", file = "sound/interface/refine_breakdown" },
    { type = "Sound", category = "Effect", name = "Repair", file = "sound/interface/repairequipment" },
    { type = "Sound", category = "Effect", name = "Sell Item", file = "sound/interface/sellitem" },
    { type = "Sound", category = "Effect", name = "Bell", file = "sound/interface/sys_mission_onditions" },
    { type = "Sound", category = "Effect", name = "Click 1", file = "sound/interface/ui_charselect_pick" },
    { type = "Sound", category = "Effect", name = "Click 2", file = "sound/interface/ui_chat_click" },
    { type = "Sound", category = "Effect", name = "Click 3", file = "sound/interface/ui_checkbox_click" },
    { type = "Sound", category = "Effect", name = "Click 4", file = "sound/interface/ui_contextmenu_click" },
    { type = "Sound", category = "Effect", name = "Click 5", file = "sound/interface/ui_generic_click" },
    { type = "Sound", category = "Effect", name = "Click 6", file = "sound/interface/ui_sysmenu_click" },
    { type = "Sound", category = "Effect", name = "Click 7", file = "sound/interface/ui_tab_click" },
    { type = "Sound", category = "Effect", name = "Close 1", file = "sound/interface/ui_generic_close" },
    { type = "Sound", category = "Effect", name = "Close 2", file = "sound/interface/ui_sysmenu_close" },
    { type = "Sound", category = "Effect", name = "Open 1", file = "sound/interface/ui_contextmenu_open" },
    { type = "Sound", category = "Effect", name = "Open 2", file = "sound/interface/ui_generic_open" },
    { type = "Sound", category = "Effect", name = "Open 3", file = "sound/interface/ui_sysmenu_open" },
    { type = "Sound", category = "Effect", name = "System Message", file = "sound/interface/ui_sysmsg_normal" },
};


--[[ Register the media files with SimpleMediaLib ]]--

smlib:RegisterMediaList(MediaInfo);
