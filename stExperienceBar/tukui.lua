if not IsAddOnLoaded("Tukui") then return end

local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales

stExp.font = C.media.uffont
stExp.fontsize = C.media.uffontsize and C.media.uffontsize or 12			--Checking for options only in my Tukui Edit
stExp.fontflags = C.media.uffontsize and "MONOCHROMEOUTLINE" or "OUTLINE"  --Checking for options only in my Tukui Edit

--Textures
stExp.barTex = C.media.normTex

stExp.borderColor = C.media.bordercolor
stExp.backdropColor = C.media.backdropcolor