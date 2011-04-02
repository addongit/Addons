local addonName = ...
local addon = _G[addonName]

local parent = "AltoholicTabXelerated"
local url = "http://www.XeleratedWarcraftGuides.com/Altoholic"

local WHITE		= "|cFFFFFFFF"
local GOLD 		= "|cFFFFD700"

addon.Tabs.Xelerated = {}

local ns = addon.Tabs.Xelerated		-- ns = namespace

function ns:OnLoad()
	_G[parent .. "Text1"]:SetText(format("%s\n\n%s\n%s", 
		"Altoholic Is Sponsored By X-Elerated Warcraft Guides!",
		WHITE.."- ".. GOLD.. "Level From 1-85 In Just 4 Days Played.",
		WHITE.."- ".. GOLD.. "Make 35,000g In Just 2 Days."
	))

	_G[parent .. "Text2"]:SetText("Download X-Elerated Guides by visiting their website at:")
	_G[parent .. "Text3"]:SetText("(Ctrl+C to copy URL)")
	_G[parent .. "Text4"]:SetText("With their in-game leveling guide addon you can level from 1-85 in just 4 days played time. With the X-Elerated Gold Making Guide you can make 3,000g per hour. They also offer a Daily Quest Guide Addon, Profession Leveling Guide, Talent Guide Addon, and Mount Collection Guide.")
	_G[parent .. "Text5"]:SetText("What would you do if you could achieve all that? You could have a level 85 alt of every class in no time. You could have all the gold you need to purchase epic gear, gems, and enchants. You would have all your professions maxed and be one of the top players on your server.")
	_G[parent .. "Text6"]:SetText("All of this can be yours, all you need is the X-Elerated Warcraft Guides Complete Package and then you will have access to all the tools and knowledge you need to dominate your server.")

	ns:ResetURL()
end

function ns:ResetURL()
	_G[parent .. "URL"]:SetText(GOLD .. url)
end
