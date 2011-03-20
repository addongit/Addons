stExp = {}

-- Config ----------------
--------------------------
--Font/Text
stExp.font = stMedia.fonts.Homespun
stExp.fontsize = 12
stExp.fontflags = "MONOCHROMEOUTLINE"
stExp.showText = true		 -- Set to false to hide text
stExp.mouseoverText = false -- Set to true to only show text on mouseover

--Textures/Colors
stExp.barTex = stMedia.textures.Flat
stExp.bordercolor = { 0.3, 0.3, 0.3 }
stExp.backdropcolor = { 0.1, 0.1, 0.1 }
--Sizes
stExp.playerWidth = Minimap:GetWidth()+4
stExp.playerHeight = 19
stExp.guildWidth = Minimap:GetWidth()-2
stExp.guildHeight = 12 

--Placement
stExp.playerAnchor = { "TOP", Minimap, "BOTTOM", 0, -7 }
stExp.guildAnchor = { "TOP", Minimap, "BOTTOM", 0, -30}

--Misc
stExp.hideinCombat = true