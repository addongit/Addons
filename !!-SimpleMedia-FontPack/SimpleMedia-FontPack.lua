--[[
    SimpleMedia-FontPack
    
    Registers 32 new fonts for use with SimpleMediaLib.
    
    All the fonts provided were downloaded from www.dafont.com and all may
    be distributed in this way (see font_licenses.txt for details).
    
    Version: 1.0
    Author: Peryl
    License: 
        code: Public Domain
        fonts: Various, see font_licenses.txt for details.
]]--

--[[ Get a reference to SimpleMediaLib ]]--

local smlib = LibStub:GetLibrary("SimpleMediaLib", true);
if(not smlib) then
    DEFAULT_CHAT_FRAME:AddMessage("[SimpleMedia-FontPack]: Can't find SimpleMediaLib. Aborting.");
    return; -- Exit if SimpleMediaLib is not loaded
end


--[[ The list of media files to be registered ]]--

local FontInfo = {
    -- Font names were taken from the font file itself.
    -- Scale values shown are suggestions only and may be ignored.
    { type = "Font", category = "Cartoon", name = "Aklatanic TSO",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/cartoon/aklatanic_tso/aklatan.ttf", scale = 1.15 },
    { type = "Font", category = "Cartoon", name = "Cartoon Regular",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/cartoon/cartoon/cartoon_regular.ttf", scale = 1.35 },
    { type = "Font", category = "Cartoon", name = "GoodDog Plain",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/cartoon/good_dog/gooddp__.ttf", scale = 1.2 },
    { type = "Font", category = "Cartoon", name = "GoodDog Cool",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/cartoon/good_dog/gooddc__.ttf", scale = 1.3 },
    { type = "Font", category = "Comic", name = "Komika Display",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/comic/komika_display/kmkdsp__.ttf", scale = 1.05 },
    { type = "Font", category = "Comic", name = "Kronika",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/comic/kronika/kronika_.ttf", scale = 1.15 },
    { type = "Font", category = "Comic", name = "Suplexmentary Comic NC",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/comic/suplexmentary_comic_nc/suplexmentary comic nc.ttf", scale = 1.05 },
    { type = "Font", category = "Celtic", name = "Duralith",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/celtic/duralith/duralith.ttf", scale = 1.2 },
    { type = "Font", category = "Celtic", name = "Stonehenge Regular",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/celtic/stonehenge/stonehen.ttf", scale = 1.4 },
    { type = "Font", category = "Celtic", name = "Yataghan",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/celtic/yataghan/yataghan.ttf", scale = 1.4 },
    { type = "Font", category = "Eroded", name = "Licinia 'Aged'",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/eroded/licinia_aged/licinia aged.ttf", scale = 1.35 },
    { type = "Font", category = "Fixed Width", name = "Bitstream Vera Sans Mono",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/fixed width/bitstream_vera_mono/veramono.ttf", scale = 1.0 },
    { type = "Font", category = "Fixed Width", name = "saxMono",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/fixed width/saxmono/saxmono.ttf", scale = 1.1 },
    { type = "Font", category = "Horror", name = "Lycanthrope",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/horror/lycanthrope/lycanthrope.ttf", scale = 0.95 },
    { type = "Font", category = "Medieval", name = "Dark11",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/medieval/dark11/dark11__.ttf", scale = 1.2 },
    { type = "Font", category = "Sans Serif", name = "Asenine",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/asenine/asenine_.ttf", scale = 1.2 },
    { type = "Font", category = "Sans Serif", name = "Bitstream Vera Sans",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/bitstream_vera_sans/vera.ttf", scale = 1.0 },
    { type = "Font", category = "Sans Serif", name = "Bitstream Vera Sans Oblique",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/bitstream_vera_sans/verait.ttf", scale = 1.0 },
    { type = "Font", category = "Sans Serif", name = "Bolonewt",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/bolonewt/bolonewt.ttf", scale = 1.1 },
    { type = "Font", category = "Sans Serif", name = "hlmt-rounded",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/hlmt_rounded/hlmt-rounded.ttf", scale = 1.2 },
    { type = "Font", category = "Sans Serif", name = "Sansation",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/sansation/sansation_regular.ttf", scale = 1.0 },
    { type = "Font", category = "Sans Serif", name = "Sansumi-DemiBold",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/sansumi/sansumi-demibold.ttf", scale = 0.9 },
    { type = "Font", category = "Sans Serif", name = "Tin Birdhouse",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/sans serif/tin_birdhouse/tinbird.ttf", scale = 1.0 },
    { type = "Font", category = "Sci-Fi", name = "Neuropol X Free",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/scifi/neuropol_x_free/neuropol x free.ttf", scale = 1.0 },
    { type = "Font", category = "Script", name = "Verona Script",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/script/verona_script/verona script.ttf", scale = 1.35 },
    { type = "Font", category = "Serif", name = "Bitstream Vera Serif",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/serif/bitstream_vera_seri/verase.ttf", scale = 1.0 },
    { type = "Font", category = "Serif", name = "Lymphatic",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/serif/lymphatic/lymphati.ttf", scale = 1.1 },
    { type = "Font", category = "Serif", name = "OldTypefaces",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/serif/old_typefaces/oldtypefaces.ttf", scale = 1.1 },
    { type = "Font", category = "Typewriter", name = "OldNewspaperTypes",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/typewriter/oldnewspapertypes/oldnewspapertypes.ttf", scale = 1.15 },
    { type = "Font", category = "Various", name = "Capsuula Regular",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/various/capsuula/capsuula.ttf", scale = 1.2 },
    { type = "Font", category = "Various", name = "kawoszeh",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/various/kawoszeh/kawoszeh.ttf", scale = 1.2 },
    { type = "Font", category = "Various", name = "Twilight New Moon",  file = "interface/addons/!!-SimpleMedia-FontPack/fonts/various/twilight_new_moon/twilight new moon.ttf", scale = 1.3 },
};


--[[ Register the media files with SimpleMediaLib ]]--

smlib:RegisterMediaList(FontInfo);
