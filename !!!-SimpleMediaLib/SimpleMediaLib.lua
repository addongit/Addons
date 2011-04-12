--[[
    SimpleMediaLib
    
    A simple library to handle sharing of media files.
    
    Version: 1.0
    Author: Peryl
    License: Public Domain
    
]]--


--[[ Create the library ]]--

local LIB_NAME = "SimpleMediaLib";
local LIB_VERSION = "1";

local smlib = LibStub:NewLibrary(LIB_NAME, LIB_VERSION);
if(not smlib) then
    return;
end



--[[ Init the media lists ]]--

local MediaLists = {
        Font = {},
        Image = {},
        Sound = {},
    };

if(not smlib.MediaLists) then
    smlib.MediaLists = MediaLists;
else
    MediaLists = smlib.MediaLists;
end
    


--[[ List Iterator ]]--

-- The actual iterator function
local function ListIterator(list, i)
    i = i + 1;
    local entry = list[i];
    if(entry) then
        return i, entry;
    end
end



--[[ Helper functions ]]--

local function AddFontEntry(entry)
    if(entry.name and entry.name ~= "") then
        -- Add entry if not already present
        local curentry = smlib:GetMediaByName("Font", entry.name);
        if(not curentry) then
            local fontentry = { name = entry.name, category = entry.category or "General", file = entry.file, scale = (entry.scale or 1.0) };
            smlib.MediaLists.Font[#smlib.MediaLists.Font + 1] = fontentry;
        end
    end
end

local function AddSoundEntry(entry)
    if(entry.name and entry.name ~= "") then
        -- Add entry if not already present
        local curentry = smlib:GetMediaByName("Sound", entry.name);
        if(not curentry) then
            local soundentry = { name = entry.name, category = entry.category or "General", file = entry.file };
            smlib.MediaLists.Sound[#smlib.MediaLists.Sound + 1] = soundentry;
        end
    end
end

local function AddImageEntry(entry)
    if(entry.name and entry.name ~= "") then
        -- Add entry if not already present
        local curentry = smlib:GetMediaByName("Image", entry.name);
        if(not curentry) then
            local imageentry = { name = entry.name, category = entry.category or "General", file = entry.file, 
                                 width = entry.width or 1, height = entry.height or 1, 
                                 top = (entry.top or 0), bottom = (entry.bottom or 1), left = (entry.left or 0), right = (entry.right or 1) };
            smlib.MediaLists.Image[#smlib.MediaLists.Image + 1] = imageentry;
        end
    end
end


------------------------------------------------------------------------------
--[[ Library API ]]--


--[[ Media Type Iterators ]]--

-- Example usage:
--      for i, entry in lib:Fonts() do
--          -- i here has no true meaning and can be ignored
--      end

function smlib:Fonts()
    return ListIterator, MediaLists.Font, 0;
end


function smlib:Sounds()
    return ListIterator, MediaLists.Sound, 0;
end


function smlib:Images()
    return ListIterator, MediaLists.Image, 0;
end



--[[ Retrieve a media file by name ]]--

-- Parameters:
--      mediatype    Type of media to retrieve. Must be "Font", "Sound", or "Image"
--      medianame    Name of the media file to retrieve
-- Returns:
--      table entry of media type or nil if no entry found.

function smlib:GetMediaByName(mediatype, medianame)
    assert(MediaLists[(mediatype or "")], "Bad argument #1 to 'GetMediaByName' (must be \"Font\",\"Image\", or \"Sound\")");

    for i, entry in ListIterator, MediaLists[mediatype], 0 do
        if(string.lower(entry.name) == string.lower(medianame or "")) then
            return entry;
        end
    end
end



--[[ Register a list of media files with SimpleMediaLib ]]--

-- Parameters:
--      medialist   table of media files to be registered

-- Table Structure:
--     mediatable = {
--          { type = "Font", category = "", name = "", file = "", scale = 1.0 },
--          { type = "Image", category = "", name = "", file = "", width = 0, height = 0, top = 0, bottom = 0, left = 0, right = 0 },
--          { type = "Sound", category = "", name = "", file = "" },
--      };

--      The "category" entry, if not provided, will default to "General".
--      For images, the "top", "bottom", "left" and "right" entries are optional and will default to 0, 1, 0, 1 respectively, encompassing the entire image.
--         width and height are in pixels.
--      For fonts, if the "scale" value is not given, the scale defaults to 1.0

function smlib:RegisterMediaList(medialist)
    assert(type(medialist) == "table", "Bad argument to 'RegisterMediaList' (table expected)");

    for i, entry in ipairs(medialist) do
        if(entry.file and entry.file ~= "") then
            local mediatype = entry.type or "";

            if(mediatype == "Font") then
                AddFontEntry(entry);
            elseif(mediatype == "Sound") then
                AddSoundEntry(entry);
            elseif(mediatype == "Image") then
                AddImageEntry(entry);
            end
        end
    end
end
