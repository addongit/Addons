
local LibButtonFacade = LibStub("LibButtonFacade", true)

if not LibButtonFacade then return end

LibButtonFacade:AddSkin("Vaka",{

	Normal = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\ButtonFacade_Vaka\Textures\texture]],
		Static = true,
	},
	Pushed = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\ButtonFacade_Vaka\Textures\pushed]],
	},
	Checked = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\ButtonFacade_Vaka\Textures\checked]],
		BlendMode = "ADD",
	},
	Highlight = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\ButtonFacade_Vaka\Textures\highlight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\ButtonFacade_Vaka\Textures\checked]],
		BlendMode = "ADD",
	},
	Gloss = {
		Width = 38,
		Height = 38,
		Texture = [[Interface\AddOns\ButtonFacade_Vaka\Textures\gloss]],
	},
	Disabled = {
		Hide = true,
	},
	Icon = {
		Width = 34,
		Height = 34,
		TexCoords = {0.07, 0.93, 0.07, 0.93},
	},
	Cooldown = {
		Width = 32,
		Height = 32,
	},
	Backdrop = {
		Width = 37,
		Height = 37,
		Texture = [[Interface\Addons\ButtonFacade_Vaka\Textures\backdrop]],
	},
	HotKey = {
		Width = 20,
		Height = 10,
		OffsetX = 11,
		OffsetY = 3,
	},
	Count = {
		Width = 20,
		Height = 10,
		OffsetX = 5,
		OffsetY = -7,
	},
	Name = {
		Width = 35,
		Height = 10,
		OffsetY = -9,
	},
	AutoCast = {
		Width = 30,
		Height = 30,
	},
	AutoCastable = {
		Width = 62,
		Height = 62,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Flash = {
		Width = 35,
		Height = 35,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
},true)