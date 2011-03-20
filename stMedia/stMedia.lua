stMedia = {}

stMedia["fonts"] = {}
stMedia["textures"] = {}


local function registerMedia(type, name, path)
	if not stMedia[type] then
		stMedia[type] = {}
	end
	stMedia[type][name] = path
end

--Pixel Fonts
registerMedia("fonts", 	"Hooge0053",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0553.ttf")
registerMedia("fonts", 	"Hooge0054",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0554.ttf")
registerMedia("fonts", 	"Hooge0055",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0555.ttf")
registerMedia("fonts", 	"Hooge0056",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0556.ttf")
registerMedia("fonts", 	"Hooge0057",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0557.ttf")
registerMedia("fonts", 	"Hooge0058",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0558.ttf")
registerMedia("fonts", 	"Hooge0063",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0563.ttf")
registerMedia("fonts", 	"Hooge0064",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0564.ttf")
registerMedia("fonts", 	"Hooge0065",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0565.ttf")
registerMedia("fonts", 	"Hooge0066",	"Interface\\AddOns\\stMedia\\Fonts\\pixel\\HOOG0566.ttf")
registerMedia("fonts", 	"Homespun",		"Interface\\AddOns\\stMedia\\Fonts\\pixel\\homespun.ttf")
registerMedia("fonts", 	"Borgnine",		"Interface\\AddOns\\stMedia\\Fonts\\pixel\\Borgnine.ttf")
registerMedia("fonts", 	"Ernest",		"Interface\\AddOns\\stMedia\\Fonts\\pixel\\Ernest.ttf")
--Sans Serif Fonts
registerMedia("fonts",	"Harabara",		"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\harabara.ttf")
registerMedia("fonts",	"Neometric",	"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\Neometric-Medium.ttf")
registerMedia("fonts",	"Acens",		"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\Acens.ttf")
registerMedia("fonts",	"Aldo",			"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\Aldo PC.ttf")
registerMedia("fonts",	"DuePuntoBlk",	"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\duepuntozero_black.ttf")
registerMedia("fonts",	"DuePuntoBld",	"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\duepuntozero_bold.ttf")
registerMedia("fonts",	"DuePuntoReg",	"Interface\\AddOns\\stMedia\\Fonts\\sans_serif\\duepuntozero_regular.ttf")

--Textures
registerMedia("textures",	"Flat",		"Interface\\AddOns\\stMedia\\Textures\\Flat.tga")
registerMedia("textures",	"FlatDark",	"Interface\\AddOns\\stMedia\\Textures\\FlatDark.tga")