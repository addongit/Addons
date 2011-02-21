-- @release $Id: News.lua 5 2011-01-25 14:05:53Z reighnman $

if not SlamAndAwe then return end

--- Many thanks to Dennis Hafstrom for the idea (and the code) for this News frame (lifted from Enhancer)

local _G = getfenv(0)
local LibStub = _G["LibStub"]
local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")

local format, len = _G.string.format, _G.string.len
local gsub, trim = _G.string.gsub, _G.strtrim

SlamAndAwe.newsCurrent = 3 -- Can only ever increase

function SlamAndAwe:AddNewsStory(article)
	SlamAndAwe.newsFrame:AddLine("Introduction", "Welcome to SlamAndAwe, a modified version of the ShockAndAwe addon. ")
	SlamAndAwe.newsFrame:AddLine("", "This addon was written to enhance fury warrior dps and build on the")
	SlamAndAwe.newsFrame:AddLine("", "work done with shockandawe and DisqoDice. Its aim is to provide a fully configurable addon")
	SlamAndAwe.newsFrame:AddLine("", "you can adjust to suit your own particular UI layout. Use /saa config to")
	SlamAndAwe.newsFrame:AddLine("", "access the configuration menu")
	SlamAndAwe.newsFrame:AddLine("            ","") -- Some spacing
	SlamAndAwe.newsFrame:AddLine("Timer Bars", "Bars are still under construction, the only available bar currently")
	SlamAndAwe.newsFrame:AddLine("", "is the gcd bar.")
	SlamAndAwe.newsFrame:AddLine("            ","") -- Some spacing
end

function SlamAndAwe:News(override)
	if (not override and ((self.db.char.newsitem or 0) >= self.newsCurrent)) then return; end
	self:CreateNewsFrame()
	tinsert(UISpecialFrames, "AddOnNewsFrame")
	self.newsFrame:Clear()
	self.newsFrame.title:SetText("|cffffd200SlamAndAwe|r")
	
	self:AddNewsStory(self.db.char.newsitem)
	-------- max length for "subject    ","body"---------------------------------------------------
	self.newsFrame:AddLine("            ","") -- Some spacing
	self.newsFrame:AddLine("            ","")
	
	self.newsFrame:AddLine(L["Config"], L["help1"])
	self.newsFrame:AddLine("", L["help2"])
	self.newsFrame:AddLine("", L["help_command"])
	self.newsFrame:AddLine("            ","")
	self.newsFrame:AddLine(L["Website"], self:SpamSafe(L["__URL__"]))
	
	self:PopulateNewsFrame(1)
	self.newsFrame:Show()
	self.db.char.newsitem = self.newsCurrent
end

function SlamAndAwe:SpamSafe(text)
	-- replace ' [dot] ' with '.' and ' [at] ' with '@'
	return gsub(gsub(text, " %[at%] ", "@"), " %[dot%] ", ".")
end

function SlamAndAwe:CreateNewsFrame()
	self.newsFrame = CreateFrame("Frame", "AddOnNewsFrame", UIParent, "DialogBoxFrame")
	self.newsFrame:ClearAllPoints()
	self.newsFrame:SetWidth(1000)
	self.newsFrame:SetHeight(400)
	self.newsFrame:SetPoint("CENTER")
	self.newsFrame:SetBackdrop({
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
	    edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	    tile = true, tileSize = 16, edgeSize = 16,
	    insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	self.newsFrame:SetBackdropColor(0,0,0,1)
	
	local text = self.newsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
	text:SetFont([[Interface\AddOns\SlamAndAwe\fonts\CAS_ANTN.TTF]], 24, "OUTLINE") -- http://wdnaddons.com/2307561/FrameXML/Fonts.xml
	self.newsFrame.title = text
	text:SetPoint("TOP", 0, -10)
	self.newsFrame:Hide()
	self.newsFrame:EnableMouse(true)
	self.newsFrame:SetMovable(true);
	self.newsFrame:RegisterForDrag("LeftButton");
	self.newsFrame:SetScript("OnDragStart", function() self.newsFrame:StartMoving() end)
	self.newsFrame:SetScript("OnDragStop", function() self.newsFrame:StopMovingOrSizing() end)
	self.newsFrame.scroll = CreateFrame("ScrollFrame", "AddOnNewsScrollFrame", self.newsFrame, "FauxScrollFrameTemplate")
	self.newsFrame.scroll:SetParent(self.newsFrame)
	self.newsFrame.scroll:ClearAllPoints()
	self.newsFrame.scroll:SetWidth(520)
	self.newsFrame.scroll:SetHeight(320) -- 20 entries a 16 px
	self.newsFrame.scroll:SetPoint("TOPLEFT", self.newsFrame, "TOPLEFT", 0, -10)
	
	local function updateScroll()
		self:NewsFrameScroll()
	end

	self.newsFrame.scroll:SetScript("OnVerticalScroll",
		function(self, offset)
			FauxScrollFrame_OnVerticalScroll(self, offset, 16, updateScroll)
		end )
	self.newsFrame.scroll:SetScript("OnShow", function() SlamAndAwe:NewsFrameScroll() end )

	self.newsFrame.lefts = {}
	self.newsFrame.rights = {}
	self.newsFrame.textLefts = {}
	self.newsFrame.textRights = {}
	function SlamAndAwe.newsFrame:Clear()
		self.title:SetText("")
		self.disclaimer:SetText("")
		for i = 1, #self.lefts do
			self.lefts[i] = nil
			self.rights[i] = nil
		end
	end
	
	local function rightColor(right)
		-- Email color as link
		right = gsub(right, "[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?", function(v) return "|cff007fff"..v.."|r"; end)
		
		-- URL color as link (is crap need better URL matching)
		right = gsub(right, "http%:%/%/[A-Za-z0-9%.%/%-]+", function(v) return "|cff007fff"..v.."|r"; end)
		
		-- '-quoted color gray
		right = gsub(right, "(%')(%/%w-%s?%w-)(%')", function(v1, v2, v3) return v1.."|cffcccccc"..v2.."|r"..v3; end) --00ff7f
		
		-- *) lists
		right = gsub(right, "^(%*%)%s)(.+)", function(v1, v2) return "|cff00cccc"..v1.."|r"..v2; end)
		
		-- return the mess
		return right
	end

	function SlamAndAwe.newsFrame:AddLine(left, right)
		SlamAndAwe.newsFrame.lefts[#SlamAndAwe.newsFrame.lefts+1] = trim(left)
		SlamAndAwe.newsFrame.rights[#SlamAndAwe.newsFrame.rights+1] = rightColor(trim(right))
	end
	SlamAndAwe.newsFrame:Hide()
	
	local disclaimer = SlamAndAwe.newsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	disclaimer:SetFont([[Interface\AddOns\SlamAndAwe\fonts\Cella.ttf]], 8, "")
	SlamAndAwe.newsFrame.disclaimer = disclaimer
	disclaimer:SetPoint("BOTTOMRIGHT", SlamAndAwe.newsFrame:GetName(), "BOTTOMRIGHT", -5, 5)
	
	SlamAndAwe.CreateNewsFrame = function() return; end;
end

function SlamAndAwe:PopulateNewsFrame(startline)
	local textHeight = 0
	local endline = startline + 19
	local textline = 0
	if endline > #self.newsFrame.lefts then
		endline = #self.newsFrame.lefts
	end
	for i = startline, endline do
		textline = i - startline + 1
		if not self.newsFrame.textLefts[textline] then
			local left = SlamAndAwe.newsFrame.scroll:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			left:SetFont([[Interface\AddOns\SlamAndAwe\fonts\CAS_ANTN.TTF]], 16, "OUTLINE")
			self.newsFrame.textLefts[textline] = left
			local right = SlamAndAwe.newsFrame.scroll:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
			right:SetFont([[Interface\AddOns\SlamAndAwe\fonts\Cella.ttf]], 14, "OUTLINE")
			self.newsFrame.textRights[textline] = right
			if textline == 1 then
				left:SetPoint("TOPRIGHT", SlamAndAwe.newsFrame.scroll, "TOPLEFT", 125, -35)
			else
				left:SetPoint("TOPRIGHT", self.newsFrame.textLefts[textline-1], "BOTTOMRIGHT", 0, -1)
			end
			right:SetPoint("LEFT", left, "RIGHT", 5, 0)
		end
		self.newsFrame.textLefts[textline]:SetText(self.newsFrame.lefts[i] .. ((len(self.newsFrame.lefts[i]) > 0 and len(strtrim(self.newsFrame.lefts[i])) > 0 and ":") or " "))
		self.newsFrame.textRights[textline]:SetText(self.newsFrame.rights[i])
		local leftWidth = self.newsFrame.textLefts[textline]:GetWidth()
		local rightWidth = self.newsFrame.textRights[textline]:GetWidth()
		textHeight = self.newsFrame.textLefts[textline]:GetHeight()
	end
	for i = textline + 1, 20 do
		if self.newsFrame.textLefts[i] then
			self.newsFrame.textLefts[i]:SetText('')
			self.newsFrame.textRights[i]:SetText('')
		end
	end
	self.newsFrame.scroll:SetWidth(960)
	self.newsFrame.scroll:SetHeight(20 * (textHeight + 1))
	self.newsFrame:SetWidth(1000)
	self.newsFrame:SetHeight(20 * (textHeight + 1) + 120)
	self.newsFrame.scroll:Show()
end

function SlamAndAwe:NewsFrameScroll()
	FauxScrollFrame_Update(self.newsFrame.scroll, #self.newsFrame.lefts, 20, 16) -- scrollframe, number in list, number to display, fontsize of line
	local startline = FauxScrollFrame_GetOffset(self.newsFrame.scroll)
	if startline > 0 then
		self:PopulateNewsFrame(startline)
	end
end