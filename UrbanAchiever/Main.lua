local DBG = false
UrbanAchiever = LibStub("AceAddon-3.0"):NewAddon("UrbanAchiever", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
local self = UrbanAchiever

-------------------------------------------------------------
--Locals
-------------------------------------------------------------
--bindings
BINDING_HEADER_URBANACHIEVER = "Urban Achiever"

local MAX_ACHIEVEMENTS = 5800
local menuTypes = {"PLAYER", "PARTY", "RAID_PLAYER"}
local playerFaction = UnitFactionGroup("player") == "Alliance" and 1 or 2

local moneyValues = {
	["G"] = 10000,
	["S"] = 100,
	["C"] = 1,
}

self.categories = {
	["achievements"] = {},
	["statistics"] = {},
	["guild"] = {},
}

self.masterList = {}
self.seriesList = {}
self.expandList = {}

self.isAchList = {}	--Used to see if id's are achievements or statistics or guild
self.isGuildList = {}	--Used to see if id's are achievements or statistics or guild

self.currentTab = "achievements"
self.currentCat = -1
self.currentAch = 0
self.currentSort = "completed d"

self.displayTable = {}

self.catOffset = 0
self.achOffset = 0
self.criteriaOffset = 0

self.isComparing = false
self.comparisonUnit = ""
self.comparisonFaction = ""

self.moneyFormats = {	--[1] = color, [2] = texture
	gold =   {"|cffffd700%i|r", "%i|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t"},
	silver = {"|cffc7c7cf%i|r", "%i|TInterface\\MoneyFrame\\UI-SilverIcon:14:14:2:0|t"},
	copper = {"|cffeda55f%i|r", "%i|TInterface\\MoneyFrame\\UI-CopperIcon:14:14:2:0|t"},
}

self.sortFuncs = {
	["name d"] = function(a, b)
		_,a = GetAchievementInfo(a)
		_,b = GetAchievementInfo(b)
		return a < b
	end,

	["name a"] = function(a, b)
		_,a1 = GetAchievementInfo(a)
		_,b1 = GetAchievementInfo(b)
		assert(a1, "a "..a)
		assert(b1, "b "..b)
		return a1 > b1
	end,

	["points d"] = function(a, b)
		if self.isAchList[GetAchievementCategory(a)] or self.isGuildList[GetAchievementCategory(a)] then
		_,_,a = GetAchievementInfo(a)
		else
			a = GetStatistic(a)
		end
		if self.isAchList[GetAchievementCategory(b)] or self.isGuildList[GetAchievementCategory(b)] then
		_,_,b = GetAchievementInfo(b)
		else
			b = GetStatistic(b)
		end
		return a < b
	end,

	["points a"] = function(a, b)
		if self.isAchList[GetAchievementCategory(a)] or self.isGuildList[GetAchievementCategory(a)] then
		_,_,a = GetAchievementInfo(a)
		else
			a = GetStatistic(a)
		end
		if self.isAchList[GetAchievementCategory(b)] or self.isGuildList[GetAchievementCategory(b)] then
		_,_,b = GetAchievementInfo(b)
		else
			b = GetStatistic(b)
		end
		return a > b
	end,

	["completed d"] = function(a, b)
		local _,_,_,_,a1,a2,a3 = GetAchievementInfo(a)
		a1, a2, a3 = a1 or 0, a2 or 0, a3 or 0
		local _,_,_,_,b1,b2,b3 = GetAchievementInfo(b)
		b1, b2, b3 = b1 or 0, b2 or 0, b3 or 0
		if a3 ~= b3 then return a3 < b3 end	--Years first
		if a1 ~= b1 then return a1 < b1 end	--Then Months
		if a2 ~= b2 then return a2 < b2 end	--Finally Days
		return false		--They're exactly the same, return false
	end,

	["completed a"] = function(a, b)
		local _,_,_,_,a1,a2,a3 = GetAchievementInfo(a)
		a1, a2, a3 = a1 or 0, a2 or 0, a3 or 0
		local _,_,_,_,b1,b2,b3 = GetAchievementInfo(b)
		b1, b2, b3 = b1 or 0, b2 or 0, b3 or 0
		if a3 ~= b3 then return a3 > b3 end	--Years first
		if a1 ~= b1 then return a1 > b1 end	--Then Months
		if a2 ~= b2 then return a2 > b2 end	--Finally Days
		return false		--They're exactly the same, return false
	end,

	["compare d"] = function(a, b)
		if not self.isComparing then return false end
		--They're both achievements, go by date
		if (self.isAchList[GetAchievementCategory(a)] and self.isAchList[GetAchievementCategory(b)]) or (self.isGuildList[GetAchievementCategory(a)] and self.isGuildList[GetAchievementCategory(b)]) then
			local _,a1,a2,a3 = GetAchievementComparisonInfo(a,1)
			a1, a2, a3 = a1 or 0, a2 or 0, a3 or 0
			local _,b1,b2,b3 = GetAchievementComparisonInfo(b,1)
			b1, b2, b3 = b1 or 0, b2 or 0, b3 or 0
			if a3 ~= b3 then return a3 < b3 end	--Years first
			if a1 ~= b1 then return a1 < b1 end	--Then Months
			if a2 ~= b2 then return a2 < b2 end	--Finally Days
			return false		--They're exactly the same, return false
		else
			if self.isAchList[GetAchievementCategory(a)] or self.isGuildList[GetAchievementCategory(a)] then
				local _,a1, a2, a3 = GetAchievementComparisonInfo(a,1)
				a = (a1 or "") .. "/" .. (a2 or "") .. "/" .. (a3 or "")
			else
				a = GetStatistic(a)
			end

			if self.isAchList[GetAchievementCategory(b)] or self.isGuildList[GetAchievementCategory(b)] then
				local _,b1, b2, b3 = GetAchievementComparisonInfo(b,1)
				b = (b1 or "") .. "/" .. (b2 or "") .. "/" .. (b3 or "")
			else
				b = GetStatistic(b)
			end

			return a < b
		end
	end,

	["compare a"] = function(a, b)
		if not self.isComparing then return false end

		if (self.isAchList[GetAchievementCategory(a)] and self.isAchList[GetAchievementCategory(b)]) or (self.isGuildList[GetAchievementCategory(a)] and self.isGuildList[GetAchievementCategory(b)])  then
			local _,a1,a2,a3 = GetAchievementComparisonInfo(a,1)
			a1, a2, a3 = a1 or 0, a2 or 0, a3 or 0
			local _,b1,b2,b3 = GetAchievementComparisonInfo(b,1)
			b1, b2, b3 = b1 or 0, b2 or 0, b3 or 0
			if a3 ~= b3 then return a3 > b3 end	--Years first
			if a1 ~= b1 then return a1 > b1 end	--Then Months
			if a2 ~= b2 then return a2 > b2 end	--Finally Days
			return false		--They're exactly the same, return false
		end

		if self.isAchList[GetAchievementCategory(a)] or self.isGuildList[GetAchievementCategory(a)] then
			local _,a1, a2, a3 = GetAchievementComparisonInfo(a,1)
			a = (a1 or "") .. "/" .. (a2 or "") .. "/" .. (a3 or "")
		else
			a = GetStatistic(a)
		end

		if self.isAchList[GetAchievementCategory(b)] or self.isGuildList[GetAchievementCategory(b)] then
			local _,b1, b2, b3 = GetAchievementComparisonInfo(b,1)
			b = (b1 or "") .. "/" .. (b2 or "") .. "/" .. (b3 or "")
		else
			b = GetStatistic(b)
		end

		return a > b
	end
}

self.timers = {}

SLASH_URBANACHIEVER1 = "/urbanachiever"
SLASH_URBANACHIEVER2 = "/ua"
SlashCmdList["URBANACHIEVER"] = function(msg)
	if msg == "show" then
		self:ToggleFrame()
	else
		InterfaceOptionsFrame_OpenToCategory("Urban Achiever")
	end
end

--Saved Variable
UASVPC = {
	["tracker"] = {
		["x"] = UIParent:GetWidth()/2,
		["y"] = UIParent:GetHeight()/2,
		["scale"] = 1,
		["list"] = {
			[1] = 0,
			[2] = 0,
			[3] = 0,
			[4] = 0,
			[5] = 0,
		},
	},
	["statCriteria"] = true,
	["moneyAsColor"] = false,
	["trackTimed"] = true,
}
-------------------------------------------------------------
--Local functions
-------------------------------------------------------------
local function debug(...)
	if DBG then print(...) end
	return
end

local GANC = GetAchievementNumCriteria
local function GetAchievementNumCriteria(...)
	return GANC(...) or 0
end
-------------------------------------------------------------
--Startup Stuff
-------------------------------------------------------------
function self:Initialize(event, name)
	self:UnregisterEvent("ADDON_LOADED")
	debug("Initializing")
	self:PopulateMasterList()

	self:PopulateCategories("achievements")
	self:PopulateCategories("statistics")
	self:PopulateCategories("guild")

	--self:PopulateAchievements("achievements")
	--self:PopulateAchievements("statistics")

	--self:CreateTracker()
	self:SetupFrames()

	UrbanAchiever:CreateOptions()

end

function self:OnEnable()
	self:RegisterEvent("ADDON_LOADED", "Initialize")
	self:RegisterEvent("ACHIEVEMENT_EARNED", function(self1,arg1)
		self:SetDisplayAchievement()
		searchString = self:GetSearchString(arg1)
		self.masterList[arg1] = {
			["searchString"] = searchString:lower(),
		}
		RemoveTrackedAchievement(arg1)
	end)
	self:RegisterEvent("CRITERIA_UPDATE", function()
		self:RefreshCriteriaButtons()
	end)

	self:RegisterEvent("INSPECT_ACHIEVEMENT_READY", function()
		if self.isComparing then
			self:ComparisonUpdate()
			self:RefreshAchievementButtons(false)
			self.frame:Show()
		end
	end)

	--I loooooove that this event gets called for any achievement, not just when you're tracking it.
	self:RegisterEvent("TRACKED_ACHIEVEMENT_UPDATE", function(event, ...)
		local id, criteriaID, elapsed, duration = ...
		if not elapsed or not duration or not UASVPC.trackTimed then return end
		if elapsed < duration then
			AddTrackedAchievement(id)
		elseif IsTrackedAchievement(id) and elapsed >= duration then
			RemoveTrackedAchievement(id)
		end
	end)

	--Use a different button so InspectAchievements() doesnt get called.  Easier hooking.
	UnitPopupButtons["UA_ACHIEVEMENTS"] = { text = COMPARE_ACHIEVEMENTS, dist = 1 };
	--Replace their Acheivement Button with mine.
	for j = 1, #menuTypes do
		local t = menuTypes[j]
		for i = 1, #UnitPopupMenus[t] do
			if UnitPopupMenus[t][i] == "ACHIEVEMENTS" then
				UnitPopupMenus[t][i] = "UA_ACHIEVEMENTS"
				break
			end
		end
	end

	SlashCmdList["ACHIEVEMENTUI"] = function(msg)
		self:ToggleFrame()
	end

	self:HookAlertFrames()
	self:HookMicroMenu()
	self:HookWatchFrame()

	self:SecureHook("UnitPopup_ShowMenu")
end

function self:OnDisable()
    self:UnregisterEvent("ADDON_LOADED")
	self:UnregisterEvent("ACHIEVEMENT_EARNED")
	self:UnregisterEvent("CRITERIA_UPDATE")

	--Go back to the original button.
	for j = 1, #menuTypes do
		local t = menuTypes[j]
		for i = 1, #UnitPopupMenus[t] do
			if UnitPopupMenus[t][i] == "UA_ACHIEVEMENTS" then
				UnitPopupMenus[t][i] = "ACHIEVEMENTS"
				break
			end
		end
	end
end
-------------------------------------------------------------
--Hooking Stuff
-------------------------------------------------------------
function self:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		button = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i];
		if button.value == "UA_ACHIEVEMENTS" then
		    button.func = function()
				self:SetComparisonUnit(unit)
			end
		end
	end
end

function self:HookAlertFrames()
	if not AchievementFrame then
		AchievementFrame_LoadUI()
	end

	CreateFrame("Button", "AchievementAlertFrame1", UIParent, "AchievementAlertFrameTemplate")
	AchievementAlertFrame1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 128)
	CreateFrame("Button", "AchievementAlertFrame2", UIParent, "AchievementAlertFrameTemplate")
	AchievementAlertFrame2:SetPoint("BOTTOM", AchievementAlertFrame1, "TOP", 0, -10)

	AchievementAlertFrame1:SetScript("OnClick", function(button)
		local id = button.id
		self.frame:Show()
		self:SetDisplayAchievement(id, true)
		self:SetCategory(id)
	end)

	AchievementAlertFrame2:SetScript("OnClick", function(button)
		local id = button.id
		self.frame:Show()
		self:SetDisplayAchievement(id, true)
		self:SetCategory(id)
	end)
end

function self:HookMicroMenu()
	AchievementMicroButton:SetScript("OnClick", function()
		self:ToggleFrame()
	end)

	AchievementMicroButton:SetScript("OnEnter", function(frame)
		frame.tooltipText = MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "URBANACHIEVER_TOGGLE")
		GameTooltip_AddNewbieTip(frame, frame.tooltipText, 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_ACHIEVEMENT);
	end)
end

function self:HookWatchFrame()
	local oldWatchFrameLinkButtonTemplate_OnLeftClick = WatchFrameLinkButtonTemplate_OnLeftClick

	WatchFrameLinkButtonTemplate_OnLeftClick = function(this)
		CloseDropDownMenus()
		if ( this.type == "QUEST" ) then
			if IsModifiedClick("ALT") then
				RemoveQuestWatch(GetQuestIndexForWatch(this.index))
				WatchFrame_Update()
			else
				QuestLog_SetSelection(GetQuestIndexForWatch(this.index))
			end
		elseif ( this.type == "ACHIEVEMENT" ) then
			if IsModifiedClick("ALT") then
				RemoveTrackedAchievement(this.index)
			else
				if not self.frame:IsShown() then
					self.frame:Show()
				end
				self:SetDisplayAchievement(this.index, true)
			end
		end
	end
end
-------------------------------------------------------------
--Utilities
-------------------------------------------------------------
function self:InsertIntoChat(id)
	--Taken from Historian, thanks Ixchael!
	if (ChatFrame1EditBox == nil) then
		return;
	end;

	if not ChatFrame1EditBox:IsVisible() then
		ChatFrame1EditBox:Show();
	end;

	ChatFrame1EditBox:Insert(GetAchievementLink(id));
end

function self:SortDisplayTable(sortStr)
	local dir = "d"
	if self.currentSort == sortStr .. " d" then
		dir = "a"
	end
	sortStr = sortStr .. " " .. dir
	self:RefreshAchievementButtons(sortStr)
	self.currentSort = sortStr
end

function preserveSort(t, f)	--table.sort sucks!
	local temp
	for a = 1, #t, 1 do
		for b = #t, a + 1, -1 do
			if f(t[b-1], t[b]) then
				temp = t[b-1]
				t[b-1] = t[b]
				t[b] = temp
			end
		end
	end
end

function self:Search(searchStr)
	if searchStr == "" then return end --no point in returning everything
	searchStr = searchStr:lower()
	local searchTable = {strsplit(" ", searchStr)}
	local result = true
	self.displayTable = {}

	for a = 1, MAX_ACHIEVEMENTS do
		if self.masterList[a] then
			result = true
			for _, v in next, searchTable do
				if not self.masterList[a].searchString:find(v) then result = false break end
			end
			if result then
				tinsert(self.displayTable, a)
			end
		end
	end

	self.currentCat = -2
	self:RefreshAchievementButtons("name a")
end

function self:GetSearchString(id)
	if not type(id) == "number" then return end
	local retok, id, name, points, completed, month, day, year, description, _,_, reward = pcall (GetAchievementInfo,id)
    if not retok or not id then return nil end
	if not id then return nil end
	if completed then
		if year < 10 then
			year = "0" .. year;
		end
		if (GetLocale() == "frFR" or GetLocale() == "ruRU") then
			completed = day .. "/" .. month .. "/" .. year;
		else
			if (GetLocale() == "deDE") then
				completed = day .. "." .. month .. "." .. year;
			else
				completed = month .. "/" .. day .. "/" .. year;
			end
		end
	else
		completed = "";
	end
	--searchString will be used as a basis of the searching, instead of looping through all the sub-arrays
	searchStr = name .. "; " .. points .. "; " .. completed  .. "; " .. description .. "; " .. reward .. "; "

	--Add the criteria info
	for a=1, GetAchievementNumCriteria(id) do
	criteriaName = GetAchievementCriteriaInfo(id, a)
	searchStr = searchStr .. (criteriaName or "") .. "; "
	end
	--Add all the info to the master list
	return searchStr:lower()
end

function UrbanAchiever_CatButtonScroll(self1, arg1)
	--arg1 = 1 for up, -1 for down
	if IsShiftKeyDown() then arg1 = arg1 * 5 end    --Shift = longer scroll
	local sMin, sMax = self.frame.catScroll:GetMinMaxValues()
	self.catOffset = math.min(sMax, math.max(sMin, self.catOffset+ (arg1 * -1)))
	self.frame.catScroll:SetValue(self.catOffset)
end

function UrbanAchiever_AchButtonScroll(self1, arg1)
	--arg1 = 1 for up, -1 for down
	if IsShiftKeyDown() then arg1 = arg1 * 5 end    --Shift = longer scroll
	local sMin, sMax = self.frame.achScroll:GetMinMaxValues()
	self.achOffset = math.min(sMax, math.max(sMin, self.achOffset+ (arg1 * -1)))
	self.frame.achScroll:SetValue(self.achOffset)
end

function UrbanAchiever_CriteriaButtonScroll(self1, arg1)
	--arg1 = 1 for up, -1 for down
	if IsShiftKeyDown() then arg1 = arg1 * 5 end    --Shift = longer scroll
	local sMin, sMax = self.frame.criteriaScroll:GetMinMaxValues()
	self.criteriaOffset = math.min(sMax, math.max(sMin, self.criteriaOffset+ (arg1 * -1)))
	self.frame.criteriaScroll:SetValue(self.criteriaOffset)
 end

function self:ToggleFrame()
	if self.frame == nil then self:Initialize("","") end
	if self.frame == nil then return end
	if self.frame:IsShown() then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function self:SetCategory(id)
	if id == nil then id = self.currentAch end
	if not self.masterList[id] then return end

	local category = GetAchievementCategory(id)
	if self.isAchList[category] then
		self.currentTab = "achievements"
	else
		if self.isGuildList[category] then
			self.currentTab = "guild"
		else
			self.currentTab = "statistics"
		end
	end

	self.currentCat = category
	local _, catParent = GetCategoryInfo(category)
	if catParent ~= -1 then	--It's a child category, expand the parent
		for k, v in next, self.categories[self.currentTab] do
			if v.id == catParent then
				v.collapsed = false
				break
			end
		end
	end
	self:RefreshCategoryButtons()
	self:RefreshAchievementButtons(nil, id)
end

function self:FormatMoney(compMin, compMax)
	local fIndex = UASVPC.moneyAsColor and 1 or 2
	local fSpace = UASVPC.moneyAsColor and "." or " "
	--compMin =  1368980
	--compMax = 10000000
	compMin = tostring(compMin)
	compMax = tostring(compMax)
	local length = compMin:len()
	local gold, silver, copper = "","",""
	if length <= 2 then		--	1-2
		copper = compMin
	elseif length <= 4 then --	3-4
		silver = compMin:sub(1, length - 2)
		copper = compMin:sub(length-1)
	else					--	5+
		gold =   compMin:sub(1, length-4)
		silver = compMin:sub(length-3, length-2)
		copper = compMin:sub(length-1)
	end
	gold   = tonumber(gold)   or 0
	silver = tonumber(silver) or 0
	copper = tonumber(copper) or 0

	if gold >   0 then gold   = format(self.moneyFormats.gold[fIndex],   gold)	 else gold   = "" end
	if silver > 0 then silver = format(self.moneyFormats.silver[fIndex], silver) else silver = "" end
	if copper > 0 then copper = format(self.moneyFormats.copper[fIndex], copper) else copper = "" end

	compMin = gold .. (gold:len() > 0 and silver:len() > 0 and fSpace or "") ..
			  silver .. (silver:len() > 0 and copper:len() > 0 and fSpace or "") .. copper
	if compMin == "" then compMin = format(self.moneyFormats.copper[fIndex], 0) end
	compMax = format(self.moneyFormats.gold[fIndex], compMax:sub(1, compMax:len() - 4))

	return compMin, compMax
end

function self:StrToMoney(str)
	str = tostring(str)
	if not str:find("|T") then return str end
	local result = 0
	for num, value in str:gmatch("(%d+)|T.-UI%-(.)") do
		result = result + (num * moneyValues[value])
	end
	return tostring(result)
end

function self:FormatString(str)
	if not str:find("|T") then return str end
	local cur, max
	local t = {string.split("/", str)}
	if t[2] then	--There is a max string
		cur, max = self:FormatMoney(self:StrToMoney(t[1]), self:StrToMoney(t[2]))
		return cur .. " / " .. max
	else			--No max string, fake one and ignore it.
		cur = self:FormatMoney(self:StrToMoney(t[1]), 10000)
		return cur
	end
end
-------------------------------------------------------------
--Frame Stuff
-------------------------------------------------------------

function self:HideCategorySum()
	categoryStatusBar92:Hide();
	categoryStatusBar96:Hide();
	categoryStatusBar97:Hide();
	categoryStatusBar95:Hide();
	categoryStatusBar168:Hide();
	categoryStatusBar169:Hide();
	categoryStatusBar201:Hide();
	categoryStatusBar155:Hide();
	categoryStatusBar81:Hide();
end
function self:ShowCategorySum()
	categoryStatusBar92:Show();
	categoryStatusBar96:Show();
	categoryStatusBar97:Show();
	categoryStatusBar95:Show();
	categoryStatusBar168:Show();
	categoryStatusBar169:Show();
	categoryStatusBar201:Show();
	categoryStatusBar155:Show();
	categoryStatusBar81:Hide();
end
function self:HideCategorySumGuild()
	categoryStatusBar15088:Hide();
	categoryStatusBar15077:Hide();
	categoryStatusBar15078:Hide();
	categoryStatusBar15079:Hide();
	categoryStatusBar15080:Hide();
	categoryStatusBar15089:Hide();
	categoryStatusBar15093:Hide();
end
function self:ShowCategorySumGuild()
	categoryStatusBar15088:Show();
	categoryStatusBar15077:Show();
	categoryStatusBar15078:Show();
	categoryStatusBar15079:Show();
	categoryStatusBar15080:Show();
	categoryStatusBar15089:Show();
	categoryStatusBar15093:Hide();

end

function self:SetupFrames()
	if self.frame then self.frame:Show() return end
	--Start with the frame and backdrop
	self.frame = CreateFrame("Frame", "UrbanAchieverFrame", UIParent)
	self.frame:SetBackdrop({
		--bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
		--edgeFile = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder", tile = true, tileSize = 32, edgeSize = 64,
		insets = {left = 11, right = 12, top = 12, bottom = 11}
	})
	self.frame.backdrop = self.frame:CreateTexture("$parentBG", "BACKGROUND")
	self.frame.backdrop:SetPoint("TOPLEFT", 6, -6)
	self.frame.backdrop:SetPoint("BOTTOMRIGHT", -6, 6)
	--self.frame.backdrop:SetTexture(0,0,0,1)
	self.frame.backdrop:SetTexture("Interface\\AchievementFrame\\UI-Achievement-StatsBackground")

	self.frame:SetWidth(632)
	self.frame:SetHeight(535)
	self.frame:SetPoint("CENTER")
	self.frame:SetFrameStrata("DIALOG")
	self.frame:EnableMouse(true)
	self.frame:SetMovable(true)

	self.frame:SetScript("OnMouseDown",function(self1,arg1)
        if ( arg1 == "LeftButton" ) then
			self.frame:StartMoving()
		end
    end)
    self.frame:SetScript("OnMouseUp",function(self1,arg1)
        if ( arg1 == "LeftButton" ) then
			self.frame:StopMovingOrSizing()
		end
    end)

	--Initialize arrays
	self.frame.catButtons = {}
	self.frame.achButtons = {}
	self.frame.tabButtons = {}
	self.frame.achSort = {}

	--Header
	local header = self.frame:CreateTexture("$parentHeader", "ARTWORK")
	header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	header:SetWidth(256)
	header:SetHeight(64)
	header:SetPoint("TOP")

	--Points Display Shield
	local shield = self.frame:CreateTexture("$parentPointShield", "ARTWORK")
	shield:SetTexture("Interface\\AchievementFrame\\UI-Achievement-TinyShield")
	shield:SetWidth(20)
	shield:SetHeight(20)
	shield:SetPoint("TOP", 76, -14)
	shield:SetTexCoord(0, 0.6, 0, 0.6)

	--Header Text
	local headerText = self.frame:CreateFontString("$parentHeaderText", "ARTWORK", "GameFontNormal")
	headerText:SetText("Urban Achiever")
	headerText:SetPoint("CENTER", header, 0, 12)

	--Points Text
	self.pointsText = self.frame:CreateFontString("$parentPointText", "ARTWORK", "GameFontNormal")
	self.pointsText:SetPoint("LEFT", shield, "RIGHT", 0, 2)

	--Comparison parent frame
	self.comparison = CreateFrame("Frame", nil, self.frame)

	--Comparison Points Text
	self.compPointsText = self.comparison:CreateFontString("$parentCompPointText", "ARTWORK", "GameFontNormal")
	self.compPointsText:SetText("12345")
	self.compPointsText:SetPoint("TOPRIGHT", self.frame, "TOP", -67, -14)

	--Comparison Points Display Shield
	self.compShield = self.comparison:CreateTexture("$parentCompPointShield", "ARTWORK")
	self.compShield:SetTexture("Interface\\AchievementFrame\\UI-Achievement-TinyShield")
	self.compShield:SetWidth(20)
	self.compShield:SetHeight(20)
	self.compShield:SetPoint("RIGHT", self.compPointsText, "LEFT", 0, -2)
	self.compShield:SetTexCoord(0, 0.6, 0, 0.6)

	--Comparison Header Text
	self.compHeaderText = self.comparison:CreateFontString("$parentCompHeaderText", "ARTWORK", "GameFontNormal")
	self.compHeaderText:SetText(UAComparing .. " [Name here]")
	self.compHeaderText:SetPoint("RIGHT", self.compShield, "LEFT", -5, 2)

	--Comparison Button
	--[[
	local compSetButton = CreateFrame("Button", "$parentComparisonSetButton", self.frame)
	compSetButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	compSetButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	compSetButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round", "ADD")
	compSetButton:SetWidth(32)
	compSetButton:SetHeight(32)
	compSetButton:SetPoint("TOPRIGHT", self.frame, -8, -30)
	compSetButton:SetScript("OnClick", function()
		self:SetComparisonUnit("target")
	end)
	]]--

	--Category Frame
	self.frame.category = CreateFrame("Frame", "$parentCategoryFrame", self.frame)
	self.frame.category:SetWidth(190)
	self.frame.category:SetHeight(470)
	self.frame.category:SetBackdrop({
		--bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
		insets = {left = 11, right = 12, top = 12, bottom = 11}
	})
	self.frame.category.backdrop = self.frame.category:CreateTexture("$parentBG", "BACKGROUND")
	self.frame.category.backdrop:SetPoint("TOPLEFT", 6, -6)
	self.frame.category.backdrop:SetPoint("BOTTOMRIGHT", -6, 6)
	self.frame.category.backdrop:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment")
	self.frame.category.backdrop:SetTexCoord(0,.5,0,1)
	--self.frame.category.backdrop:SetTexture(0,0,0,1)
	self.frame.category:SetPoint("RIGHT", self.frame, "LEFT", 12, 0)

	--Tab Buttons
	self.frame.tabButtons[1] = self:CreateTab("$parentTab1", self.frame, UAAchievement, "achievements")
	self.frame.tabButtons[1]:SetPoint("TOPLEFT", self.frame, "BOTTOMLEFT", 20, 6)

	self.frame.tabButtons[2] = self:CreateTab("$parentTab1", self.frame, UAStatistic, "statistics")
	self.frame.tabButtons[2]:SetPoint("TOPLEFT", self.frame.tabButtons[1], "TOPRIGHT", 5, 0)

	self.frame.tabButtons[3] = self:CreateTab("$parentTab1", self.frame, UAGuild, "guild")
	self.frame.tabButtons[3]:SetPoint("TOPLEFT", self.frame.tabButtons[2], "TOPRIGHT", 5, 0)

	--self.frame.tabButtons[3] = self:CreateTab("$parentTab1", self.frame, "Search", "search")
	--self.frame.tabButtons[3]:SetPoint("TOPLEFT", self.frame.tabButtons[2], "TOPRIGHT", 5, 0)

	--Category Buttons
	self.frame.catButtons[1] = self:CreateCategoryButton("$parentCatButton1", self.frame.category)
	self.frame.catButtons[1]:SetPoint("TOPLEFT", self.frame.category, 12, -12)
	for i=2, 28 do
		self.frame.catButtons[i] = self:CreateCategoryButton("$parentCatButton"..i, self.frame.category)
		self.frame.catButtons[i]:SetPoint("TOPLEFT", self.frame.catButtons[i-1], "BOTTOMLEFT")
	end

	--Achievement Buttons
	self.frame.achButtons[1] = self:CreateAchievementButton("$parentAchButton1", self.frame, 1)
	self.frame.achButtons[1]:SetPoint("TOPLEFT", 12, -90)
	self.frame.achButtons[1]:SetScript("OnEnter", function(self)
		if ( UrbanAchiever.currentTab == "guild" ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			UrbanAchiever:CheckGuildMembersTooltip(self);
			GameTooltip:Show();
		end
	end)
	self.frame.achButtons[1]:SetScript("OnLeave", function(self)
		GameTooltip:Hide();
		guildMemberRequestFrame = nil;
	end)
	for i=2, 27 do
		self.frame.achButtons[i] = self:CreateAchievementButton("$parentAchButton" .. i, self.frame)
		self.frame.achButtons[i]:SetPoint("TOPLEFT", self.frame.achButtons[i-1], "BOTTOMLEFT")
		self.frame.achButtons[i]:SetScript("OnEnter", function(self)
			if ( UrbanAchiever.currentTab == "guild" ) then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				UrbanAchiever:CheckGuildMembersTooltip(self);
				GameTooltip:Show();
			end
		end)
		self.frame.achButtons[i]:SetScript("OnLeave", function(self)
			GameTooltip:Hide();
			guildMemberRequestFrame = nil;
		end)
	end

	--Achievement Sort Buttons
	self.frame.achSort.name = self:CreateAchievementSortButton("$parentSortNameButton", 190, self.frame, UASORT_Name, "name")
	self.frame.achSort.name:SetPoint("BOTTOMLEFT", self.frame.achButtons[1], "TOPLEFT", 10, 1)

	self.frame.achSort.points = self:CreateAchievementSortButton("$parentSortPointsButton", 48, self.frame, UASORT_Points, "points")
	self.frame.achSort.points:SetPoint("LEFT", self.frame.achSort.name, "RIGHT", 1, 0)

	self.frame.achSort.completed = self:CreateAchievementSortButton("$parentSortCompletedButton", 50, self.frame, UASORT_Date, "completed")
	self.frame.achSort.completed:SetPoint("LEFT", self.frame.achSort.points, "RIGHT", 1, 0)

	self.frame.achSort.comparison = self:CreateAchievementSortButton("$parentSortComparisonButton", 70, self.frame, UASORT_Compare, "compare")
	self.frame.achSort.comparison:SetPoint("LEFT", self.frame.achSort.completed, "RIGHT", 1, 0)
	self.frame.achSort.comparison:Hide()

	--Close Button
	self.frame.close = CreateFrame("Button", "$parentCloseButton", self.frame, "UIPanelCloseButton")
	self.frame.close:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -4, -5)

	--Category Toggle Button
	self.frame.catToggle = CreateFrame("Button", "$parentCategoryToggleButton", self.frame)
	self.frame.catToggle:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
	self.frame.catToggle:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
	self.frame.catToggle:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round", "ADD")
	self.frame.catToggle:SetWidth(32)
	self.frame.catToggle:SetHeight(32)
	self.frame.catToggle:SetPoint("BOTTOMLEFT", self.frame.achButtons[1], "TOPLEFT", 5, 21)
	self.frame.catToggle:SetScript("OnClick", function()
		if self.frame.category:IsShown() then
			self.frame.category:Hide()
		else
			self.frame.category:Show()
		end
	end)

	--Search Editbox
	self.frame.editbox = self:CreateEditbox(self.frame)
	self.frame.editbox:SetWidth(200)
	self.frame.editbox:SetPoint("TOPLEFT", self.frame.catToggle, "TOPRIGHT", 10, 0)

	--Achievements Earned Progress Bar
	self.frame.summaryBar = CreateFrame("StatusBar", "$parentBar", self.frame, "AchievementProgressBarTemplate")
	self.frame.summaryBar:SetPoint("LEFT", self.frame.editbox, "RIGHT", 15, 9)
	self.frame.summaryBar:SetWidth(330)
	self.frame.summaryBar.text:ClearAllPoints()
	self.frame.summaryBar.text:SetPoint("RIGHT", -5, 0)
	self.frame.summaryBar.text:SetJustifyH("RIGHT")
	self.frame.summaryBar.name = self.frame.summaryBar:CreateFontString("$parentName", "OVERLAY", "GameFontHighlightSmall")
	self.frame.summaryBar.name:SetPoint("LEFT", 5, 0)
	self.frame.summaryBar.name:SetJustifyH("LEFT")
	self.frame.summaryBar.name:SetWidth(300)

	--creatEachCategoryProgessBar
	local lastFrameID
	local idxCat = 0
	for i,id in ipairs(GetCategoryList()) do
		tittleCat, parentCatID = GetCategoryInfo(id)
		if ( parentCatID == -1 )then
			idxCat = idxCat + 1
			self.frame.category[id] = CreateFrame("StatusBar","categoryStatusBar"..id, self.frame, "AchievementProgressBarTemplate")
			if idxCat == 1 then
				lastFrameID = id
				self.frame.category[id]:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 15, 120)
			else
				if (idxCat%2) == 0 then
					self.frame.category[id]:SetPoint("LEFT", self.frame.category[lastFrameID], "RIGHT", 20, 0)
				else
					self.frame.category[id]:SetPoint("TOPLEFT", self.frame.category[lastFrameID], "BOTTOMLEFT", 0, -5)
					lastFrameID = id
				end
			end
			self.frame.category[id]:SetWidth(290)
			self.frame.category[id]:SetHeight(30)
			self.frame.category[id].text:ClearAllPoints()
			self.frame.category[id].text:SetPoint("RIGHT", -5, 0)
			self.frame.category[id].text:SetJustifyH("RIGHT")
			self.frame.category[id].name = self.frame.category[id]:CreateFontString("$parentName", "OVERLAY", "GameFontHighlightSmall")
			self.frame.category[id].name:SetPoint("LEFT", 5, 0)
			self.frame.category[id].name:SetJustifyH("LEFT")
			self.frame.category[id].name:SetWidth(300)
			self.frame.category[id]:Hide()
		end
	end

	local lastFrameID
	local idxCat = 0
	for i,id in ipairs(GetGuildCategoryList()) do
		tittleCat, parentCatID = GetCategoryInfo(id)
		if ( parentCatID == -1 or parentCatID == 15076 )then
			idxCat = idxCat + 1
			self.frame.category[id] = CreateFrame("StatusBar","categoryStatusBar"..id, self.frame, "AchievementProgressBarTemplate")
			if idxCat == 1 then
				lastFrameID = id
				self.frame.category[id]:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 15, 120)
			else
				if (idxCat%2) == 0 then
					self.frame.category[id]:SetPoint("LEFT", self.frame.category[lastFrameID], "RIGHT", 20, 0)
				else
					self.frame.category[id]:SetPoint("TOPLEFT", self.frame.category[lastFrameID], "BOTTOMLEFT", 0, -5)
					lastFrameID = id
				end
			end
			self.frame.category[id]:SetWidth(290)
			self.frame.category[id]:SetHeight(30)
			self.frame.category[id].text:ClearAllPoints()
			self.frame.category[id].text:SetPoint("RIGHT", -5, 0)
			self.frame.category[id].text:SetJustifyH("RIGHT")
			self.frame.category[id].name = self.frame.category[id]:CreateFontString("$parentName", "OVERLAY", "GameFontHighlightSmall")
			self.frame.category[id].name:SetPoint("LEFT", 5, 0)
			self.frame.category[id].name:SetJustifyH("LEFT")
			self.frame.category[id].name:SetWidth(300)
			self.frame.category[id]:Hide()
		end
	end


	--Achievements Earned Comparison Progress Bar
	self.frame.comparisonSummaryBar = CreateFrame("StatusBar", "$parentComparisonBar", self.frame, "AchievementProgressBarTemplate")
	self.frame.comparisonSummaryBar:SetPoint("LEFT", self.frame.editbox, "RIGHT", 15, -8)
	self.frame.comparisonSummaryBar:SetWidth(330)
	--self.frame.comparisonSummaryBar.text:SetFontObject("GameFontNormal")
	--self.frame.comparisonSummaryBar.text:SetWidth(320)
	self.frame.comparisonSummaryBar.text:ClearAllPoints()
	self.frame.comparisonSummaryBar.text:SetPoint("RIGHT", -5, 0)
	self.frame.comparisonSummaryBar.text:SetJustifyH("RIGHT")
	self.frame.comparisonSummaryBar.name = self.frame.comparisonSummaryBar:CreateFontString("$parentName", "OVERLAY", "GameFontHighlightSmall")
	self.frame.comparisonSummaryBar.name:SetPoint("LEFT", 5, 0)
	self.frame.comparisonSummaryBar.name:SetJustifyH("LEFT")
	self.frame.comparisonSummaryBar.name:SetWidth(300)

	--Category Scroll Bar
	self.frame.catScroll = CreateFrame("Slider", "$parentCatSlider", self.frame.category, "UIPanelScrollBarTemplate")
	self.frame.catScroll:SetPoint("TOPLEFT", self.frame.catButtons[2], "TOPRIGHT")
	self.frame.catScroll:SetPoint("BOTTOMLEFT", self.frame.catButtons[#self.frame.catButtons - 1], "BOTTOMRIGHT")
	self.frame.catScroll:SetWidth(16)
	self.frame.catScroll:SetMinMaxValues(0,0)
	self.frame.catScroll:SetValueStep(1)
	self.frame.catScroll:SetScript("OnValueChanged", UrbanAchiever_OnCatScroll)
	self.frame.catScroll:SetValue(1)

	--Achievement Button Scroll Bar
	self.frame.achScroll = CreateFrame("Slider", "$parentAchSlider", self.frame, "UIPanelScrollBarTemplate")
	self.frame.achScroll:SetPoint("TOPLEFT", self.frame.achButtons[2], "TOPRIGHT")
	self.frame.achScroll:SetPoint("BOTTOMLEFT", self.frame.achButtons[#self.frame.achButtons - 1], "BOTTOMRIGHT")
	self.frame.achScroll:SetWidth(16)
	self.frame.achScroll:SetMinMaxValues(0,0)
	self.frame.achScroll:SetValueStep(1)
	self.frame.achScroll:SetScript("OnValueChanged",UrbanAchiever_OnAchScroll)
	self.frame.achScroll:SetValue(1)

	--Achievement Display Frame
	self.frame.display = CreateFrame("Frame", "$parentDisplayFrame", self.frame)
	self.frame.display.backdrop = self.frame.display:CreateTexture("$parentBG", "BACKGROUND")
	self.frame.display.backdrop:SetPoint("TOPLEFT")
	self.frame.display.backdrop:SetPoint("BOTTOMRIGHT")
	--self.frame.display.backdrop:SetTexture(1,0,0,1)


	self.frame.display:SetWidth(290)
	self.frame.display:SetHeight(463)
	self.frame.display:SetPoint("TOPRIGHT", -13, -75) -- , self.frame.achButtons[1], "TOPRIGHT", 19, 0)
	self.frame.display:Hide()

	--Display Icon
	self.frame.display.icon = self.frame.display:CreateTexture(nil, "ARTWORK")
	self.frame.display.icon:SetWidth(64)
	self.frame.display.icon:SetHeight(64)
	self.frame.display.icon:SetPoint("TOPLEFT")
	--self.frame.display.icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
	--self.frame.display.icon:SetScript("OnClick", function()
	--	self:InsertIntoChat(self.currentAch)
	--end)

	--Display Name
	self.frame.display.name = self.frame.display:CreateFontString("$parentName", "ARTWORK", "AchievementPointsFont")
	self.frame.display.name:SetPoint("TOPLEFT", self.frame.display.icon, "TOPRIGHT", 5, 0)
	--self.frame.display.name:SetPoint("TOPRIGHT", -15,-15)
	self.frame.display.name:SetWidth(220)
	self.frame.display.name:SetHeight(70)
	self.frame.display.name:SetJustifyH("CENTER")
	self.frame.display.name:SetJustifyV("TOP")

	--Display Shield Icon
	self.frame.display.shield = self.frame.display:CreateTexture("$parentShield", "ARTWORK")
	self.frame.display.shield:SetPoint("TOPLEFT", self.frame.display.icon, "BOTTOMLEFT", 0, -5)
	self.frame.display.shield:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Shields")
	self.frame.display.shield:SetTexCoord(0, 0.5, 0.5, 1);
	self.frame.display.shield:SetWidth(64)
	self.frame.display.shield:SetHeight(64)

	--Display Points
	self.frame.display.points = self.frame.display:CreateFontString("$parentPoints", "ARTWORK", "AchievementPointsFont")
	self.frame.display.points:SetPoint("CENTER", self.frame.display.shield, "CENTER", 0, 3)

	--Display Description
	self.frame.display.desc = self.frame.display:CreateFontString("$parentDescription", "ARTWORK", "GameFontNormal")
	self.frame.display.desc:SetPoint("TOPLEFT", self.frame.display.shield, "TOPRIGHT", 5, 0)
	--self.frame.display.desc:SetPoint("BOTTOMRIGHT", self.frame.display, "TOPRIGHT", -15,-109)
	self.frame.display.desc:SetWidth(220)
	self.frame.display.desc:SetHeight(65)
	self.frame.display.desc:SetTextColor(1,1,1)

	--Display Reward
	self.frame.display.reward = self.frame.display:CreateFontString("$parentReward", "ARTWORK", "GameFontNormal")
	self.frame.display.reward:SetPoint("TOP", self.frame.display, "TOP", 0, -127)
	self.frame.display.reward:SetTextColor(1,1,1)
	
	--Display completed
	self.frame.display.completed = self.frame.display:CreateFontString("$parentReward", "ARTWORK", "GameFontNormal")
	self.frame.display.completed:SetPoint("TOP", self.frame.display, "TOP", 0, -60)
	self.frame.display.completed:SetTextColor(0,1,0)
	
	--Display repCriteria
	self.frame.display.repCriteria = self.frame.display:CreateFontString("$parentReward", "ARTWORK", "GameFontNormal")
	self.frame.display.repCriteria:SetPoint("BOTTOM", self.frame.display, "TOP", 0, 3)

	--Display Compare Completed
	self.frame.display.compareDate = self.frame.display:CreateFontString("$parentReward", "ARTWORK", "GameFontNormal")
	self.frame.display.compareDate:SetPoint("TOP", self.frame.display.reward, "BOTTOM", 0, -1)
	self.frame.display.compareDate:SetTextColor(0,1,0)
	self.frame.display.compareDate:SetText("Tomate " .. UACompleted .. ": 12/12/12")
	self.frame.display.compareDate:Hide()

	--Display Bar
	self.frame.display.bar = CreateFrame("StatusBar", "$parentBar", self.frame.display, "AchievementProgressBarTemplate")
	--self.frame.display.bar.text:SetFontObject("GameFontHighlight")
	self.frame.display.bar.text:SetWidth(200)
	self.frame.display.bar:SetPoint("CENTER", self.frame.display, 0, 60)

	--Display Comparison Bar
	self.frame.display.compareBar = CreateFrame("StatusBar", "$parentCompareBar", self.frame.display, "AchievementProgressBarTemplate")
	--self.frame.display.compareBar.text:SetFontObject("GameFontHighlight")
	self.frame.display.compareBar.text:SetWidth(200)
	self.frame.display.compareBar:ClearAllPoints()
	self.frame.display.compareBar:SetPoint("TOP", self.frame.display.bar, "BOTTOM", 0, -25)

	--Display Comparison Bar Name Text
	self.frame.display.compareBar.nameText = self.frame.display.compareBar:CreateFontString("$parentNameText", "ARTWORK", "GameFontNormal")
	self.frame.display.compareBar.nameText:SetTextColor(1,1,1)
	self.frame.display.compareBar.nameText:SetPoint("BOTTOM", self.frame.display.compareBar, "TOP", 0, 5)

	self.frame.display.criteriaButtons = {}

	--Criteria Buttons
	self.frame.display.criteriaButtons[1] = self:CreateCriteriaButton("$parentCriteriaButton1", self.frame.display)
	self.frame.display.criteriaButtons[1]:SetPoint("TOPLEFT", 0, -160)
	self.frame.display.criteriaButtons[1]:SetScript("OnEnter", function(self)
		if ( self.date ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT",-50,0);
			GameTooltip:AddLine(self.date, 1, 1, 1);
			UrbanAchiever:CheckGuildMembersTooltip(self);
			GameTooltip:Show();
		end
	end)
	self.frame.display.criteriaButtons[1]:SetScript("OnLeave", function(self)
		GameTooltip:Hide();
		guildMemberRequestFrame = nil;
	end)
	for i=2, 9 do
		self.frame.display.criteriaButtons[i] = self:CreateCriteriaButton("$parentCriteriaButton" .. i, self.frame.display)
		self.frame.display.criteriaButtons[i]:SetPoint("TOPLEFT", self.frame.display.criteriaButtons[i-1], "BOTTOMLEFT")
		self.frame.display.criteriaButtons[i]:SetScript("OnEnter", function(self)
			if ( self.date ) then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT",-50,0);
				GameTooltip:AddLine(self.date, 1, 1, 1);
				UrbanAchiever:CheckGuildMembersTooltip(self);
				GameTooltip:Show();
			end
		end)
		self.frame.display.criteriaButtons[i]:SetScript("OnLeave", function(self)
			GameTooltip:Hide();
			guildMemberRequestFrame = nil;
		end)
	end

	--Display Scroll Bar
	self.frame.criteriaScroll = CreateFrame("Slider", "$parentSlider", self.frame.display, "UIPanelScrollBarTemplate")
	self.frame.criteriaScroll:SetPoint("TOPLEFT", self.frame.display.criteriaButtons[2], "TOPRIGHT", 1,0)
	self.frame.criteriaScroll:SetPoint("BOTTOMLEFT", self.frame.display.criteriaButtons[#self.frame.display.criteriaButtons - 1], "BOTTOMRIGHT", 1,0)
	self.frame.criteriaScroll:SetWidth(16)
	self.frame.criteriaScroll:SetMinMaxValues(0,0)
	self.frame.criteriaScroll:SetValueStep(1)
	self.frame.criteriaScroll:SetScript("OnValueChanged", UrbanAchiever_OnCriteriaScroll)
	self.frame.criteriaScroll:SetValue(1)
	self.frame.criteriaScroll:Show()

	self.frame.display.criteria = self.frame.display:CreateFontString("$parentCriteria", "ARTWORK", "GameFontNormal")
	self.frame.display.criteria:SetPoint("TOPLEFT", 0, -135)
	self.frame.display.criteria:SetJustifyH("LEFT")
	self.frame.display.criteria:SetJustifyV("TOP")

	tinsert(UISpecialFrames,self.frame:GetName())
	self.frame:SetScript("OnShow", function()
		self:UpdateFunction()

		if self.masterList[self.currentAch] then
			self:SetDisplayAchievement(self.currentAch)
		end
		PlaySound("AchievementMenuOpen");
	end)
	self.frame:SetScript("OnHide", function()
		PlaySound("AchievementMenuClose");
		self.isComparing = false
	end)

	self:UpdateFunction()

	self.frame:Hide()
end

function self:CheckGuildMembersTooltip(requestFrame)
	if ( self.currentTab == "guild" ) then
		local achievementId = requestFrame.id;
		if achievementId == nil then
			achievementId = requestFrame:GetID();
		end
		local _, achievementName, points, achievementCompleted, month, day, year, description, flags, iconpath = GetAchievementInfo(achievementId);
		-- check if achievement has names, only if completed
		if ( achievementCompleted and bit.band(flags, ACHIEVEMENT_FLAGS_SHOW_GUILD_MEMBERS) == ACHIEVEMENT_FLAGS_SHOW_GUILD_MEMBERS ) then
			local numMembers = GetGuildAchievementNumMembers(achievementId);
			if ( numMembers == 0 ) then
				-- we may not have the members from the server yet
				guildMemberRequestFrame = requestFrame;
				GetGuildAchievementMembers(achievementId);
			else
				-- add a line break if the tooltip shows completed date (meta tooltip)
				if ( GameTooltip:NumLines() > 0 ) then
					GameTooltip:AddLine(" ");
				end	
				GameTooltip:AddLine(GUILD_ACHIEVEMENT_EARNED_BY, 1, 1, 1);
				local leftMemberName;
				for i = 1, numMembers do
					if ( leftMemberName ) then
						GameTooltip:AddDoubleLine(leftMemberName, GetGuildAchievementMemberInfo(achievementId, i));
						leftMemberName = nil;
					else
						leftMemberName = GetGuildAchievementMemberInfo(achievementId, i);
					end	
				end
				-- check for leftover name
				if ( leftMemberName ) then
					GameTooltip:AddLine(leftMemberName);
				end
			end
		-- otherwise check if criteria has names
		elseif ( flags ~= nil ) then
			if ( bit.band(flags, ACHIEVEMENT_FLAGS_SHOW_CRITERIA_MEMBERS) == ACHIEVEMENT_FLAGS_SHOW_CRITERIA_MEMBERS ) then
				local numCriteria = GetAchievementNumCriteria(achievementId);
				local firstName = true;
				for i = 1, numCriteria do
					local criteriaString, _, completed, _, _, charName = GetAchievementCriteriaInfo(achievementId, i);
					if ( completed and charName ) then
						if ( firstName ) then
							if ( achievementCompleted ) then
								GameTooltip:AddLine(GUILD_ACHIEVEMENT_EARNED_BY, 1, 1, 1);
							else
								GameTooltip:AddLine(INCOMPLETE, 1, 1, 1);
							end
							firstName = false;
						end
						GameTooltip:AddDoubleLine(criteriaString, charName, 0, 1, 0);
					end
				end
			end
		end
	end
end

function self:CreateCategoryButton(name, parent)
	local button = CreateFrame("Button", name, parent)
	button:EnableMouseWheel(true)
	button:SetWidth(150)
	button:SetHeight(16)

	button.offset = CreateFrame("Frame","$parentOffset", button)
	button.offset:SetPoint("TOPLEFT")
	button.offset:SetWidth(1)
	button.offset:SetHeight(16)

	button.text = button:CreateFontString("$parentText", "BORDER", "GameFontNormal")
	button.text:SetJustifyH("LEFT")
	button.text:SetFont(GameFontNormal:GetFont(), 12)
	button.text:SetPoint("LEFT", button.offset, "RIGHT", 7, 0)
	button.text:SetPoint("RIGHT")
	--button.text:SetWidth(150)
	--button.text:SetTextColor(1,1,1)

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	--button.bg:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-FilterBg")
	button.bg:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Category-Background")
	button.bg:SetTexCoord(0.025, 0.64, 0.1, 0.75)
	button.bg:SetPoint("TOPLEFT", button.offset, "TOPRIGHT")
	--button.bg:SetPoint("BOTTOMRIGHT")
	button.bg:SetWidth(140)
	button.bg:SetHeight(16)

	local highlightTexture = button:CreateTexture()
	highlightTexture:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Category-Highlight")
	highlightTexture:SetTexCoord(0.02, 0.65, 0, 0.91)
	highlightTexture:SetPoint("TOPLEFT", button.bg, -1, 0)
	highlightTexture:SetPoint("BOTTOMRIGHT", button.bg, 1, -2)

	--button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar", "ADD")
	button:SetHighlightTexture(highlightTexture, "ADD")

	button:SetScript("OnClick", function()
		local id = button:GetID()
		self.currentCat = id
		for _,v in next, self.categories[self.currentTab] do
			if v.id == id then
				v.collapsed = not v.collapsed
				break
			end
		end
		self.achOffset = 0
		self:RefreshCategoryButtons()
		self:RefreshAchievementButtons()
	end)
	button:SetScript("OnMouseWheel",UrbanAchiever_CatButtonScroll)

	return button
end

function self:CreateAchievementButton(name, parent)
	local button = CreateFrame("Button", name, parent)
	button:EnableMouseWheel(true)
	button:SetWidth(300)
	button:SetHeight(16)

	button.expand = button:CreateFontString("$parentExpand", "BORDER", "GameFontNormal")
	button.expand:SetText("+")
	button.expand:SetWidth(10)
	button.expand:SetHeight(10)
	button.expand:SetPoint("TOPLEFT")

	button.offset = CreateFrame("Frame", nil, button)
	button.offset:SetWidth(10)
	button.offset:SetHeight(1)
	button.offset:SetPoint("TOPLEFT", 9, 0)

	button.bgframe = CreateFrame("Frame", nil, button)
	button.bgframe:SetWidth(300)
	button.bgframe:SetHeight(16)
	button.bgframe:SetPoint("TOPLEFT")

	button.background = button:CreateTexture("$parentBackground", "BACKGROUND")
	--button.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")
	button.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Stat-Buttons")
	button.background:SetAlpha(0.5)

	button.background:SetPoint("TOPLEFT", button.offset, "TOPRIGHT")
	button.background:SetPoint("BOTTOMRIGHT", button.bgframe)
	--button.background:SetWidth(290)
	--button.background:SetHeight(16)

	button.name = button:CreateFontString("$parentNameText","BORDER", "GameFontNormal")
	button.name:SetPoint("TOPLEFT", button.background)
	--button.text:SetPoint("TOPRIGHT", button, "TOPRIGHT")
	button.name:SetWidth(200)
	button.name:SetHeight(16)
	button.name:SetJustifyH("LEFT")
	button.name:SetJustifyV("TOP")
	button.name:SetTextColor(1,1,1)

	button.points = button:CreateFontString("$parentPointsText","BORDER", "GameFontNormal")
	button.points:SetPoint("TOPLEFT", button, "TOPLEFT", 217, 0)
	--button.text:SetPoint("TOPRIGHT", button, "TOPRIGHT")
	button.points:SetWidth(20)
	button.points:SetJustifyH("LEFT")
	button.points:SetJustifyV("TOP")
	button.points:SetTextColor(1,1,1)

	button.completed = button:CreateFontString("$parentCompletedText","BORDER", "GameFontNormal")
	button.completed:SetPoint("TOPLEFT", button.points, "TOPRIGHT", 2, 0)
	--button.text:SetPoint("TOPRIGHT", button, "TOPRIGHT")
	button.completed:SetWidth(60)
	button.completed:SetHeight(16)
	button.completed:SetJustifyH("LEFT")
	button.completed:SetJustifyV("TOP")
	button.completed:SetTextColor(1,1,1)

	button.stat = button:CreateFontString("$parentStatText","BORDER", "GameFontNormal")
	button.stat:SetPoint("TOPLEFT", button, "TOPLEFT", 217, 0)
	button.stat:SetPoint("TOPRIGHT", button.background, "TOPRIGHT")
	--button.stat:SetWidth(20)
	button.stat:SetJustifyH("LEFT")
	button.stat:SetJustifyV("TOP")
	button.stat:SetTextColor(1,1,1)

	button.comparison = CreateFrame("Frame", "$parentComparison", button)
	button.comparison:SetPoint("RIGHT")
	button.comparison:SetWidth(70)
	button.comparison:SetHeight(16)
	button.comparison:Hide()
	button.comparison:SetFrameLevel(button.comparison:GetFrameLevel() - 1)

	button.comparison.background = button.comparison:CreateTexture("$parentBackground", "BACKGROUND")
	button.comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")
	--button.comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Stat-Buttons")
	button.comparison.background:SetAlpha(0.5)
	button.comparison.background:SetAllPoints(button.comparison)

	button.compare = button.comparison:CreateFontString("$parentText", "BORDER", "GameFontNormal")
	button.compare:SetPoint("LEFT", button.comparison, 5, 0)
	button.compare:SetPoint("RIGHT", button.comparison)
	button.compare:SetTextColor(1,1,1)

	button.comparison:SetScript("OnShow", function()
		if self.isComparing then
			button:SetWidth(370)
			self.frame:SetWidth(702)
		end
	end)

	button.comparison:SetScript("OnHide", function()
		if not self.isComparing then
			button:SetWidth(300)
			self.frame:SetWidth(632)
		end
	end)

	local highlightTexture = button:CreateTexture()
	highlightTexture:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Stat-Buttons")
	highlightTexture:SetTexCoord(0, 1, 0.56, 0.73)
	highlightTexture:SetPoint("TOPLEFT", button.background)
	highlightTexture:SetPoint("BOTTOMRIGHT", button)

	button:SetHighlightTexture(highlightTexture, "ADD")

	button:SetScript("OnClick", function()
		local id = button:GetID()
		if self.masterList[id] then
			if ChatFrame1EditBox:IsVisible() and IsModifiedClick("CHATLINK") then
				self:InsertIntoChat(id)
			elseif IsShiftKeyDown() then
				if IsTrackedAchievement(id) then
					RemoveTrackedAchievement(id)
				else
					local retok, _, _, _, completed = pcall (GetAchievementInfo,id)
					if not retok or not id then return nil end
					if completed == true then
						DEFAULT_CHAT_FRAME:AddMessage(UAAchievementDone);
					else
						AddTrackedAchievement(id)
					end
				end
				self:RefreshAchievementButtons(false)
			else
				self.currentAch = id
				if GetPreviousAchievement(id) and (not GetNextAchievement(id)) then
					self.expandList[id] = not self.expandList[id]
				end

				self:RefreshAchievementButtons(false)
				self:SetDisplayAchievement(id)
			end
		end
	end)
	button:SetScript("OnMouseWheel", UrbanAchiever_AchButtonScroll)

	return button
end

function self:CreateCriteriaButton(name, parent)
	local button = CreateFrame("Button", name, parent)
	button:EnableMouseWheel(true)
	button:SetWidth(273)
	button:SetHeight(16)

	--Offset used to move text when an icon is present
	button.offset = CreateFrame("Frame", nil, button)
	button.offset:SetWidth(1)
	button.offset:SetHeight(16)
	button.offset:SetPoint("LEFT")

	button.text = button:CreateFontString("$parentText", "BORDER", "GameFontHighlight")
	button.text:SetPoint("LEFT", button.offset, "RIGHT")
	button.text:SetPoint("RIGHT", button)
	button.text:SetJustifyH("LEFT")
	button.text:SetTextColor(1,1,1)

	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetWidth(16)
	button.icon:SetHeight(16)
	button.icon:SetPoint("RIGHT", button.text, "LEFT")

	button.comparison = button:CreateTexture(nil, "ARTWORK")
	button.comparison:SetWidth(16)
	button.comparison:SetHeight(16)
	button.comparison:SetPoint("LEFT", button.offset)

	--button:SetNormalTexture("Interface/FriendsFrame/UI-FriendsFrame-HighlightBar")

	local highlightTexture = button:CreateTexture()
	highlightTexture:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Stat-Buttons")
	highlightTexture:SetTexCoord(0, 1, 0.56, 0.73)
	--highlightTexture:SetAllPoints(button)

	button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar", "ADD")

	button:SetScript("OnMouseWheel", UrbanAchiever_CriteriaButtonScroll)

	button:SetScript("OnClick", function()
		local id = button:GetID()
		if button.icon:IsShown() then
			self:SetDisplayAchievement(id)
		end
	end)

	return button
end

function self:CreateAchievementSortButton(name, width, parent, text, sortStr)
	local button = CreateFrame("Button", name, parent)
	button:SetHeight(16)
	button:SetWidth(width)
	button:SetNormalTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
	button:SetHighlightTexture("Interface/FriendsFrame/UI-FriendsFrame-HighlightBar", "ADD")

	button.text = button:CreateFontString("$parentText", "ARTWORK", "GameFontNormal")
	button.text:SetPoint("CENTER", 0, 2)
	button.text:SetTextColor(1,1,1)
	button.text:SetText(text)

	button:SetScript("OnClick", function() self:SortDisplayTable(sortStr) end)

	return button
end

function self:CreateTab(name, parent, text, tab)
	local button = CreateFrame("Button", name, parent)
	button:SetHeight(30)
	button:SetWidth(100)

	--button:SetNormalTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight", "ADD")

	button:SetBackdrop({
		--bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, edgeSize = 16,
		insets = {left = -5, right = -5, top = -5, bottom = -5}
	})
	button.backdrop = button:CreateTexture("$parentBG", "BACKGROUND")
	button.backdrop:SetPoint("TOPLEFT", 2, -2)
	button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
	button.backdrop:SetTexture(0,0,0,1)

	button.text = button:CreateFontString("$parentText", "ARTWORK", "GameFontNormal")
	button.text:SetPoint("CENTER")
	button.text:SetTextColor(1,1,1)
	button.text:SetText(text)

	button:SetScript("OnClick", function()
		self.currentTab = tab
		self:RefreshCategoryButtons()
	end)

	return button
end

function self:CreateEditbox(parent)
	--Shamelessly yoinked from MSBT. Much <3
	-- Create container frame.
	local editbox = CreateFrame("Frame", nil, parent)
	editbox:SetHeight(32)

	-- Create editbox frame.
	local editboxFrame = CreateFrame("Editbox", nil, editbox)
	editboxFrame:SetHeight(20)
	editboxFrame:SetPoint("BOTTOMLEFT", editbox, "BOTTOMLEFT", 5, 0)
	editboxFrame:SetPoint("BOTTOMRIGHT")
	editboxFrame:SetAutoFocus(false)
	editboxFrame:SetFontObject(ChatFontNormal)
	editboxFrame:SetScript("OnEscapePressed",	function() editboxFrame:ClearFocus() end)
	editboxFrame:SetScript("OnEditFocusLost",	function() editboxFrame:HighlightText(0, 0) end)
	editboxFrame:SetScript("OnEditFocusGained",	function() editboxFrame:HighlightText() end)
	--editboxFrame:SetScript("OnTextChanged",		Editbox_OnTextChanged)
	--editboxFrame:SetScript("OnEnter",			Editbox_OnEnter)
	--editboxFrame:SetScript("OnLeave",			Editbox_OnLeave)
	--editboxFrame:SetScript("OnTextChanged",		function() self:Search(editboxFrame:GetText()) end)
	editboxFrame:SetScript("OnEnterPressed",	function() self:Search(editboxFrame:GetText()) editboxFrame:ClearFocus() end)

	-- Left border.
	local left = editboxFrame:CreateTexture(nil, "BACKGROUND")
	left:SetTexture("Interface\\Common\\Common-Input-Border")
	left:SetWidth(8)
	left:SetHeight(22)
	left:SetPoint("LEFT", editboxFrame, "LEFT", -5, 0)
	left:SetTexCoord(0, 0.0625, 0, 0.625)

	-- Right border.
	local right = editboxFrame:CreateTexture(nil, "BACKGROUND")
	right:SetTexture("Interface\\Common\\Common-Input-Border")
	right:SetWidth(8)
	right:SetHeight(22)
	right:SetPoint("RIGHT")
	right:SetTexCoord(0.9375, 1, 0, 0.625)

	-- Middle border.
	local middle = editboxFrame:CreateTexture(nil, "BACKGROUND")
	middle:SetTexture("Interface\\Common\\Common-Input-Border")
	middle:SetWidth(10)
	middle:SetHeight(22)
	middle:SetPoint("LEFT", left, "RIGHT", 0, 0)
	middle:SetPoint("RIGHT", right, "LEFT", 0, 0)
	middle:SetTexCoord(0.0625, 0.9375, 0, 0.625)


	-- Label.
	local label = editbox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	label:SetPoint("TOPLEFT")
	label:SetPoint("TOPRIGHT")
	label:SetJustifyH("LEFT")

	return editbox
end

-------------------------------------------------------------
--Scroll Stuff
-------------------------------------------------------------
function UrbanAchiever_OnCatScroll(self1)
	self.catOffset = self1:GetValue()
	self:RefreshCategoryButtons()
end

function UrbanAchiever_OnAchScroll(self1)
	self.achOffset = self1:GetValue()
	self:RefreshAchievementButtons(false)
end

function UrbanAchiever_OnCriteriaScroll(self1)
	self.criteriaOffset = self1:GetValue()
	self:RefreshCriteriaButtons()
end

-------------------------------------------------------------
--Core Stuff
-------------------------------------------------------------
function self:UpdateFunction()
	if (not self.frame) or (not self.frame:IsShown()) then return end
	self:RefreshCategoryButtons()
	self:RefreshAchievementButtons(false)
	self:ComparisonUpdate()
	--self:TrackerUpdate()
	if self.currentTab == "guild" then
		inGuild = true;
	else
		inGuild = false;
	end
	self.pointsText:SetText(GetTotalAchievementPoints(inGuild));
end

function self:PopulateMasterList()
	debug("PML")
	local id, name, points, completed, month, day, year, description, icon, reward, searchString
	local criteriaName
	local catList, numAchievements, nextId
	local tempTable = {}
	local category

	--Get Every achievement
	for i=1, MAX_ACHIEVEMENTS do
		searchString = self:GetSearchString(i)
		if searchString then
			self.masterList[i] = {
				["searchString"] = searchString:lower(),
			}

			if not GetNextAchievement(i) then
			--If this isnt in the middle of a chain, add it to the category listing
				category = GetAchievementCategory(i)
				if not self.seriesList[category] then
					self.seriesList[category] = {}
				end

				tinsert(self.seriesList[category], i)
			end
		end
	end
end

function self:PopulateCategories(tab)
	local list, name, parent
	local isAch = false
	local isGuild = false
	--Populate the list from API
	if tab == "achievements" then
		list = GetCategoryList()
		isAch = true
	else
		if tab == "guild" then
			list = GetGuildCategoryList()
			isGuild = true
		else
			list = GetStatisticsCategoryList()
		end
	end

	--Insert summary Category
	tinsert(self.categories[tab], {
		["id"] = "-1",
		["name"] = UASummary,
		["collapsed"] = true,
		["children"] = {}
	})

	--Add top level Categories
	for _,id in next, list do
		name, parent = GetCategoryInfo(id)
		self.isAchList[id] = isAch
		self.isGuildList[id] = isGuild
		if parent == 15076 then
			parent = -1
		end
		if parent == -1 then
			tinsert(self.categories[tab], {
				["id"] = id,
				["name"] = name,
				["collapsed"] = true,
				["children"] = {}
			})
		end
	end

	--Add child Categories
	for _,childId in next, list do
		childName, childParent = GetCategoryInfo(childId)
		for parentKey, parentCat in next, self.categories[tab] do
			if childParent == parentCat.id then
				tinsert(parentCat.children,{
						["id"] = childId,
						["name"] = childName
				})
			end
		end
	end
end

function self:SetAchievementButton(button, id, offset)
	local retok, id, name, points, completed, month, day, year, description, _,icon, reward = pcall (GetAchievementInfo,id)
	if not retok then return nil end

	if completed then
		if year < 10 then
			year = "0" .. year;
		end
		if (GetLocale() == "frFR" or GetLocale() == "ruRU") then
			completed = day .. "/" .. month .. "/" .. year;
		else
			if (GetLocale() == "deDE") then
				completed = day .. "." .. month .. "." .. year;
			else
				completed = month .. "/" .. day .. "/" .. year;
			end
		end
	else
		completed = "";
	end
	if not offset then offset = 1 end

	self.frame.achButtons[button]:SetWidth(300)
	self.frame.achButtons[button].name:SetText(name)
	self.frame.achButtons[button].completed:SetText(completed)
	self.frame.achButtons[button]:SetID(id)
	self.frame.achButtons[button].expand:Hide()
	self.frame.achButtons[button].compare:SetText("")
	self.frame.achButtons[button].comparison:Hide()

	self.frame.achButtons[button].background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")
	self.frame.achButtons[button].comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")

	if self.isAchList[GetAchievementCategory(id)] == false and self.isGuildList[GetAchievementCategory(id)] == false then
	--Its a statistic, no date, no points
		self.frame.achButtons[button].stat:SetText(self:FormatString(GetStatistic(id)))
		self.frame.achButtons[button].points:SetText("")

		if self.isComparing then
			self.frame.achButtons[button].comparison:Show()
			self.frame.achButtons[button].compare:SetText(self:FormatString(GetComparisonStatistic(id)))
		end
	else
		self.frame.achButtons[button].points:SetText(points)
		self.frame.achButtons[button].stat:SetText("")

		if completed == "" then
			self.frame.achButtons[button].background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		--else
		--	self.frame.achButtons[button].background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")
		end

		if IsTrackedAchievement(id) then
			self.frame.achButtons[button].expand:SetTextColor(0,1,0)
			self.frame.achButtons[button].expand:SetText("T")
			self.frame.achButtons[button].expand:Show()
		elseif reward ~= "" then	--Theres a reward, it takes precidence
			self.frame.achButtons[button].expand:SetTextColor(1,0,0)
			self.frame.achButtons[button].expand:SetText("!")
			self.frame.achButtons[button].expand:Show()
		elseif self.currentCat > 0 then --If we're searching or at the summary, we dont want to see the + or -
			self.frame.achButtons[button].expand:SetTextColor(1,1,1)
			if GetPreviousAchievement(id) and (not GetNextAchievement(id)) then	--There's a sub achievement
				self.frame.achButtons[button].expand:Show()
				if self.expandList[id] then
					self.frame.achButtons[button].expand:SetText("-")
				else
					self.frame.achButtons[button].expand:SetText("+")
				end
			end
		end

		if self.isComparing then
			self.frame.achButtons[button].comparison:Show()
			local compDone, compM, compD, compY = GetAchievementComparisonInfo(id, 1)

			if compDone then
				self.frame.achButtons[button].compare:SetText(string.format("%d/%d/0%d", compM, compD, compY))
			else
				self.frame.achButtons[button].comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
			end
		end
	end

	if self.currentAch == id then
		self.frame.achButtons[button]:LockHighlight()
	else
		self.frame.achButtons[button]:UnlockHighlight()
	end

	self.frame.achButtons[button].offset:SetWidth(offset)
	self.frame.achButtons[button]:Show()
end

function self:SetDisplayAchievement(id, forceCat)
	if id == nil then id = self.currentAch end
	if not self.masterList[id] then return end

	self.currentAch = id

	--Update the category list
	--On second thought, I dont want it doing this.
	--On third thought, I only want to do it if we're coming from the summary frame.
	if self.currentCat == -1 or forceCat then
		self:SetCategory(self.currentAch)
	end

	--Update this achievement
	self.masterList[id].searchString = self:GetSearchString(id)

	local retok, id, name, points, completed, month, day, year, description, _,icon, reward = pcall (GetAchievementInfo,id)

	self.frame.display:Show()
	self.frame.display.icon:SetTexture(icon)
	self.frame.display.name:SetText(name)
	self.frame.display.desc:SetText(description)
	self.frame.display.compareDate:Hide()

	if self.isAchList[GetAchievementCategory(id)] == false and self.isGuildList[GetAchievementCategory(id)] == false then
		--Statistic
		self.frame.display.icon:Hide()
		self.frame.display.icon:SetWidth(1)
		self.frame.display.shield:Hide()
		self.frame.display.reward:SetText("")
		self.frame.display.points:SetText("")
		self.frame.display.desc:SetText("")
		self.frame.display.name:SetJustifyH("MIDDLE")
		self.frame.display.name:SetWidth(280)

		for a = 1, #self.frame.display.criteriaButtons do
			self.frame.display.criteriaButtons[a]:Hide()
			self.frame.display.criteriaButtons[a].icon:Hide()
		end

		self.frame.display.reward:SetText("|cffffffff" .. self:FormatString(GetStatistic(id)))
		if self.isComparing then
			self.frame.display.compareDate:Show()
			self.frame.display.compareDate:SetText("|cffffffff" .. self.comparisonUnitName .. ": " .. self:FormatString(GetComparisonStatistic(id)))
			self.frame.display.reward:SetText("|cffffffff" .. UnitName("player") .. ": " .. self:FormatString(GetStatistic(id)))
		end
		if UASVPC.statCriteria then
			self:RefreshCriteriaButtons()
		else
			for i=1, #self.frame.display.criteriaButtons do
				self.frame.display.criteriaButtons[i]:Hide()
				self.frame.criteriaScroll:Hide()
			end
		end
	else
		--Achievement
		self.frame.display.icon:Show()
		self.frame.display.icon:SetWidth(64)
		self.frame.display.shield:Show()
		self.frame.display.name:SetJustifyH("LEFT")
		self.frame.display.name:SetWidth(220)
		if completed then
			if year < 10 then
				year = "0" .. year;
			end
			if (GetLocale() == "frFR" or GetLocale() == "ruRU") then
				completed = day .. "/" .. month .. "/" .. year;
			else
				if (GetLocale() == "deDE") then
					completed = day .. "." .. month .. "." .. year;
				else
					completed = month .. "/" .. day .. "/" .. year;
				end
			end
		else
			completed = "";
		end

		if points == 0 then
			self.frame.display.shield:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Shields-NoPoints")
			self.frame.display.points:SetText("")
		else
			self.frame.display.points:SetText(points)
			self.frame.display.shield:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Shields")
		end
		
		
		if self.currentTab == "guild" then
			requiresRep, hasRep, repLevel = GetAchievementGuildRep(self.currentAch);
			if ( requiresRep ) then
				initialOffset = -ACHIEVEMENTBUTTON_CRITERIAROWHEIGHT;
				local gender = UnitSex("player");
				local factionStandingtext = GetText("FACTION_STANDING_LABEL"..repLevel, gender);
				self.frame.display.repCriteria:SetFormattedText(ACHIEVEMENT_REQUIRES_GUILD_REPUTATION, factionStandingtext);
				if ( hasRep ) then
					self.frame.display.repCriteria:SetTextColor(0, 1, 0);
				else
					self.frame.display.repCriteria:SetTextColor(1, 0, 0);
				end
				self.frame.display.repCriteria:Show();
			else
				self.frame.display.repCriteria:Hide();
			end
		else
			self.frame.display.repCriteria:Hide();
		end
		
		if completed == "" then
			self.frame.display.shield:SetTexCoord(.5, 1, 0, .5)
			self.frame.display.points:SetVertexColor(.65, .65, .65)
			self.frame.display.reward:SetText(reward)
			self.frame.display.completed:SetText("")
		else
			self.frame.display.shield:SetTexCoord(0 , .5, 0, .5)
			self.frame.display.points:SetVertexColor(1, 1, 1)
			self.frame.display.reward:SetText(reward)
			self.frame.display.completed:SetText(UACompleted .. ": " .. completed)
		end

		if self.isComparing then
			local compDone, m, d, y = GetAchievementComparisonInfo(id,1)
			if compDone then
				self.frame.display.compareDate:Show()
				self.frame.display.compareDate:SetText(string.format("%s " .. UACompleted .. ":" .." %d/%d/0%d", self.comparisonUnitName, m or -1, d or -1, y or -1))
			end
		end
		self:RefreshCriteriaButtons()
	end
end
-------------------------------------------------------------
--Refresh Stuff
-------------------------------------------------------------
function self:RefreshCriteriaButtons()
	if self.frame == nil then self:Initialize("","") end
	if self.frame == nil then return end
	if not self.frame:IsShown() then return end
	local criteriaName, criteriaType, criteriaCompleted, criteriaQuantity, criteriaReqQuantity,_ ,criteriaFlags, criteriaAssetID, icon, quantityStr
	local buttonNum = 1
	local str = ""
	local offset = 1
	local compDone, comparisonComplete, compCriteriaText

	if self.isComparing then
		compDone = GetAchievementComparisonInfo(self.currentAch,1)
	end


	self.frame.display.bar:Hide()
	self.frame.display.compareBar:Hide()

	for a = self.criteriaOffset + 1, min(#self.frame.display.criteriaButtons + self.criteriaOffset, GetAchievementNumCriteria(self.currentAch)) do
		self.frame.display.criteriaButtons[buttonNum]:Show()
		self.frame.display.criteriaButtons[buttonNum].icon:Hide()
		self.frame.display.criteriaButtons[buttonNum].comparison:Hide()
		offset = 1
		
		criteriaName, criteriaType, criteriaCompleted, criteriaQuantity, criteriaReqQuantity, charName, criteriaFlags, criteriaAssetID, quantityStr =
			GetAchievementCriteriaInfo(self.currentAch, a)
		if criteriaType then	--Some Achievements seem to throw out the wrong number of criteria, causing errors.
			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and criteriaAssetID then
				id, criteriaName, _, criteriaCompleted, month, day, year, _, _, icon = GetAchievementInfo(criteriaAssetID);
			end
			
			if criteriaCompleted then
				str = "|CFF00FF00"
			else
				str = "|CFF808080"
			end
			str = str .. criteriaName -- .. "= " .. criteriaQuantity .. " (" .. criteriaAssetID .. ")"
			if UASVPC.specificCriteria and criteriaReqQuantity > 1 then
				str = string.format("%s (%d/%d)", str, criteriaQuantity, criteriaReqQuantity)
			end
			if self.isComparing and not compDone and UASVPC.statCriteria then
				compCriteriaText,comparisonComplete = GetCriteriaComparisonInfo(self.currentAch, a, 1)

				self.frame.display.criteriaButtons[buttonNum].comparison:Show()

				offset = offset + 16

				if comparisonComplete then
					self.frame.display.criteriaButtons[buttonNum].comparison:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
				else
					self.frame.display.criteriaButtons[buttonNum].comparison:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
				end
			end

			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and criteriaAssetID then
				--Its a meta achievement
				self.frame.display.criteriaButtons[buttonNum].icon:SetTexture(icon)
				self.frame.display.criteriaButtons[buttonNum].icon:Show()
				offset = offset + 16
				self.frame.display.criteriaButtons[buttonNum]:SetID(criteriaAssetID)
			elseif (bit.band(criteriaFlags, ACHIEVEMENT_CRITERIA_PROGRESS_BAR) == ACHIEVEMENT_CRITERIA_PROGRESS_BAR) then
				--Its a progress bar
				offset = 1
				self.frame.display.criteriaButtons[buttonNum]:Hide()
				str = ""

				self.frame.display.bar:Show()
				self.frame.display.bar:SetMinMaxValues(0,criteriaReqQuantity)
				self.frame.display.bar:SetValue(criteriaQuantity)
				local cQ, cRQ = criteriaQuantity, criteriaReqQuantity
				if quantityStr:find("|T") then
					cQ, cRQ = self:FormatMoney(criteriaQuantity, criteriaReqQuantity)
				end
				self.frame.display.bar.text:SetText(cQ .. " / " .. cRQ)

				if self.isComparing  and compCriteriaText then
					self.frame.display.compareBar:Show()
					self.frame.display.compareBar:SetMinMaxValues(0, criteriaReqQuantity)
					local _,_,min, max = string.find(compCriteriaText, "(%d+)/(%d+)")
					self.frame.display.compareBar:SetValue(min)
					--If theres money textures in the string, we're gonna need to format it.
					if quantityStr:find("|T") then
						min, criteriaReqQuantity = self:FormatMoney(min, criteriaReqQuantity)
					end
					self.frame.display.compareBar.text:SetText(min .. " / " .. criteriaReqQuantity)
					self.frame.display.compareBar.nameText:SetText(self.comparisonUnitName .. ":")

				end
				--If theres a progress bar, theres no other achievements
				break
			end
			if month then
				self.frame.display.criteriaButtons[buttonNum].date = string.format(SHORTDATE, day, month, year);
			else
				self.frame.display.criteriaButtons[buttonNum].date = nil;
			end
			if id then
				self.frame.display.criteriaButtons[buttonNum].id = id;
			else
				self.frame.display.criteriaButtons[buttonNum].id = nil;
			end
			self.frame.display.criteriaButtons[buttonNum].text:SetText(str)
			self.frame.display.criteriaButtons[buttonNum].offset:SetWidth(offset)
			buttonNum = buttonNum + 1
		end
	end
	self.frame.criteriaScroll:SetMinMaxValues(0,math.max(GetAchievementNumCriteria(self.currentAch)-#self.frame.display.criteriaButtons, 0))

	if GetAchievementNumCriteria(self.currentAch)-#self.frame.display.criteriaButtons > 0 then
		self.frame.criteriaScroll:Show()
	else
		self.frame.criteriaScroll:Hide()
	end

	for a = GetAchievementNumCriteria(self.currentAch) + 1, #self.frame.display.criteriaButtons do
		self.frame.display.criteriaButtons[a]:Hide()
	end
end

function self:RefreshCategoryButtons()
	local count = 0
	local buttonNum = 1
	for k, v in next, self.categories[self.currentTab] do
		count = count + 1
		if buttonNum <= #self.frame.catButtons and count > self.catOffset then
			self.frame.catButtons[buttonNum].text:SetText(v.name)
			self.frame.catButtons[buttonNum].offset:SetWidth(1)
			self.frame.catButtons[buttonNum]:SetID(v.id)
			if v.id == self.currentCat then
				self.frame.catButtons[buttonNum]:LockHighlight()
			else
				self.frame.catButtons[buttonNum]:UnlockHighlight()
			end
			self.frame.catButtons[buttonNum]:Show()
			buttonNum = buttonNum + 1
		end

		if v.collapsed == false then
			for subK, subV in next, v.children do
				count = count + 1
				if buttonNum <= #self.frame.catButtons and count > self.catOffset then
					self.frame.catButtons[buttonNum].text:SetText(subV.name)
					self.frame.catButtons[buttonNum].offset:SetWidth(10)
					self.frame.catButtons[buttonNum]:SetID(subV.id)
					if subV.id == self.currentCat then
						self.frame.catButtons[buttonNum]:LockHighlight()
					else
						self.frame.catButtons[buttonNum]:UnlockHighlight()
					end
					self.frame.catButtons[buttonNum]:Show()
					buttonNum = buttonNum + 1
				end
			end
		end
	end

	self.frame.catScroll:SetMinMaxValues(0,math.max(count-#self.frame.catButtons, 0))
	if count-#self.frame.catButtons > 0 then
		self.frame.catScroll:Show()
	else
		self.frame.catScroll:Hide()
	end

	for i = buttonNum, #self.frame.catButtons do
		self.frame.catButtons[i]:Hide()
	end
	self:RefreshSummaryBar()

	if self.currentTab == "guild" then
		self.pointsText:SetTextColor(0,1,0);
		self.pointsText:SetText(GetTotalAchievementPoints(true));
		total, completed = GetNumCompletedAchievements(true);
		if self.currentCat == -1 then
			self.frame.summaryBar:SetMinMaxValues(0, total)
			self.frame.summaryBar:SetValue(completed)
			self.frame.summaryBar.text:SetText(completed .. "/" .. total)
		end
	else
		self.pointsText:SetTextColor(1,1,1);
		self.pointsText:SetText(GetTotalAchievementPoints());
		total, completed = GetNumCompletedAchievements();
		if self.currentCat == -1 then
			self.frame.summaryBar:SetMinMaxValues(0, total)
			self.frame.summaryBar:SetValue(completed)
			self.frame.summaryBar.text:SetText(completed .. "/" .. total)
		end
	end

	--Stuff for tab highlights
	--Not happy with this, but it works till I find some better textures.
	if self.currentTab == "achievements" then
		self.frame.tabButtons[1]:LockHighlight()
		self.frame.tabButtons[2]:UnlockHighlight()
		self.frame.tabButtons[3]:UnlockHighlight()
	else
		if self.currentTab == "guild" then
			self.frame.tabButtons[1]:UnlockHighlight()
			self.frame.tabButtons[2]:UnlockHighlight()
			self.frame.tabButtons[3]:LockHighlight()
		else
			self.frame.tabButtons[1]:UnlockHighlight()
			self.frame.tabButtons[2]:LockHighlight()
			self.frame.tabButtons[3]:UnlockHighlight()
		end
	end
end

function self:RefreshAchievementButtons(sortStr, shownID)
	local count = 0
	local buttonNum = 1
	local prevId
	--sortStr = true	dont change the table, sort it
	--			false	dont change the table, dont sort it
	--			nil		reset the table, sort it by name then completed
	if sortStr then
		preserveSort(self.displayTable, self.sortFuncs[sortStr])
	elseif sortStr == nil then
		self.displayTable = {}
		for _, id in next, (self.seriesList[self.currentCat] or {}) do
			--If we're searching, or comparing with the opposite faction, or its not in the list, or its the right faction, show
			if self.currentCat == -2 or (self.isComparing and self.comparisonFaction ~= playerFaction) or (not UrbanAchiever.factionAchs[tostring(id)]) or UrbanAchiever.factionAchs[tostring(id)] == playerFaction then
				tinsert(self.displayTable, id)
			end
		end
		preserveSort(self.displayTable, self.sortFuncs["name a"])
		preserveSort(self.displayTable, self.sortFuncs["completed d"])
	end

	--Used to move the achievement scroll to show the ID we want.
	if shownID then
		--Make sure we're looking for the top achievement of the series.
		local nextId = GetNextAchievement(shownID)
		if nextId then
			while nextId do
				shownID = nextId
				nextId = GetNextAchievement(nextId)
			end
			if GetPreviousAchievement(shownID) and (not GetNextAchievement(shownID)) then
				self.expandList[shownID] = true
			end
		end
		for count, id in next, self.displayTable do
			if id == shownID then
				if count > #self.frame.achButtons then
					self.frame.achScroll:SetValue(count - #self.frame.achButtons)
				end
				break
			end
		end
	end

	for _, id in next, self.displayTable do
		count = count + 1
		if buttonNum <= #self.frame.achButtons and count > self.achOffset then
			self:SetAchievementButton(buttonNum, id, 1)
			buttonNum = buttonNum + 1
		end
		prevId = GetPreviousAchievement(id)
		if prevId and (not GetNextAchievement(id)) then
			if (self.currentCat ~= -2) and (self.expandList[id]) then
				while prevId do
					count = count + 1
					if buttonNum <= #self.frame.achButtons and count > self.achOffset then
						self:SetAchievementButton(buttonNum, prevId, 10)
						buttonNum = buttonNum + 1
					end
					prevId = GetPreviousAchievement(prevId)
				end
			end
		end
	end

	--Start summary category stuff.  We assume all the above stuff has done nothing.
	if self.currentCat == -1 then	--Summary category
		--Incredibly hackish on my part :\
		self.frame.achButtons[buttonNum]:SetWidth(300)
		self.frame.achButtons[buttonNum].name:SetText(UARecentAchiev .. ":")
		self.frame.achButtons[buttonNum].completed:SetText("")
		self.frame.achButtons[buttonNum].compare:SetText("")
		self.frame.achButtons[buttonNum].points:SetText("")
		self.frame.achButtons[buttonNum].stat:SetText("")
		self.frame.achButtons[buttonNum]:SetID(-1)
		self.frame.achButtons[buttonNum].expand:Hide()
		self.frame.achButtons[buttonNum].comparison:Hide()
		self.frame.achButtons[buttonNum].background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		self.frame.achButtons[buttonNum].comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		self.frame.achButtons[buttonNum].offset:SetWidth(1)
		self.frame.achButtons[buttonNum]:UnlockHighlight()
		if self.isComparing then
			self.frame.achButtons[buttonNum]:SetWidth(370)
			self.frame.achButtons[buttonNum].comparison:Show()
		end
		self.frame.achButtons[buttonNum]:Show()
		buttonNum = buttonNum + 1

		for k,id in next, {GetLatestCompletedAchievements()} do
			self:SetAchievementButton(buttonNum, id)
			buttonNum = buttonNum + 1
		end

		self.frame.achButtons[buttonNum]:Hide()
		buttonNum = buttonNum + 1
		
		self.frame.achButtons[buttonNum]:SetWidth(300)
		self.frame.achButtons[buttonNum].name:SetText(UARecentGuildAchiev .. ":")
		self.frame.achButtons[buttonNum].completed:SetText("")
		self.frame.achButtons[buttonNum].compare:SetText("")
		self.frame.achButtons[buttonNum].points:SetText("")
		self.frame.achButtons[buttonNum].stat:SetText("")
		self.frame.achButtons[buttonNum]:SetID(-1)
		self.frame.achButtons[buttonNum].expand:Hide()
		self.frame.achButtons[buttonNum].comparison:Hide()
		self.frame.achButtons[buttonNum].background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		self.frame.achButtons[buttonNum].comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		self.frame.achButtons[buttonNum].offset:SetWidth(1)
		self.frame.achButtons[buttonNum]:UnlockHighlight()
		if self.isComparing then
			self.frame.achButtons[buttonNum]:SetWidth(370)
			self.frame.achButtons[buttonNum].comparison:Show()
		end
		self.frame.achButtons[buttonNum]:Show()
		buttonNum = buttonNum + 1

		for k,id in next, {GetLatestCompletedAchievements(true)} do
			self:SetAchievementButton(buttonNum, id)
			buttonNum = buttonNum + 1
		end

		--[[self.frame.achButtons[buttonNum]:SetWidth(300)
		self.frame.achButtons[buttonNum].name:SetText(UARecentStat .. ":")
		self.frame.achButtons[buttonNum].completed:SetText("")
		self.frame.achButtons[buttonNum].compare:SetText("")
		self.frame.achButtons[buttonNum].points:SetText("")
		self.frame.achButtons[buttonNum].stat:SetText("")
		self.frame.achButtons[buttonNum]:SetID(-1)
		self.frame.achButtons[buttonNum].expand:Hide()
		self.frame.achButtons[buttonNum].comparison:Hide()
		self.frame.achButtons[buttonNum].background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		self.frame.achButtons[buttonNum].comparison.background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal-Desaturated")
		self.frame.achButtons[buttonNum].offset:SetWidth(1)
		self.frame.achButtons[buttonNum]:UnlockHighlight()
		if self.isComparing then
			self.frame.achButtons[buttonNum]:SetWidth(370)
			self.frame.achButtons[buttonNum].comparison:Show()
		end
		self.frame.achButtons[buttonNum]:Show()
		buttonNum = buttonNum + 1

		for k,id in next, {GetLatestUpdatedStats()} do
			statId = GetAchievementInfoFromCriteria(id)
			self:SetAchievementButton(buttonNum, statId)
			buttonNum = buttonNum + 1
		end]]

		--new in sumarry
		local numTotal, numDone
		local catName
		local parentCatID
		local id
		local numItems, numCompleted
		local numItems2, numCompleted2

		for i,id in ipairs(GetCategoryList()) do
			numTotal = 0
			numDone = 0
			catName, parentCatID = GetCategoryInfo(id)
			if parentCatID == -1 then
				for i2,id2 in ipairs(GetCategoryList()) do
					_, parentCatID2 = GetCategoryInfo(id2)
					if parentCatID2 == id then
						numItems, numCompleted = GetCategoryNumAchievements(id)
						numTotal = (numTotal + numItems)
						numDone = (numDone + numCompleted)
					end
				end
				numItems2, numCompleted2 = GetCategoryNumAchievements(id)
				numTotal = (numTotal + numItems2)
				numDone = (numDone + numCompleted2)
				self.frame.category[id]:Hide()
				self.frame.category[id]:SetMinMaxValues(0, numTotal)
				self.frame.category[id]:SetValue(numDone)
				self.frame.category[id].text:SetText(numDone .. "/" .. numTotal)
				self.frame.category[id].name:SetText(catName)
			end
		end

		for i,id in ipairs(GetGuildCategoryList()) do
			numTotal = 0
			numDone = 0
			catName, parentCatID = GetCategoryInfo(id)
			if parentCatID == -1 or parentCatID == 15076 then
				for i2,id2 in ipairs(GetGuildCategoryList()) do
					_, parentCatID2 = GetCategoryInfo(id2)
					if parentCatID2 == id then
						numItems, numCompleted = GetCategoryNumAchievements(id)
						numTotal = (numTotal + numItems)
						numDone = (numDone + numCompleted)
					end
				end
				numItems2, numCompleted2 = GetCategoryNumAchievements(id)
				numTotal = (numTotal + numItems2)
				numDone = (numDone + numCompleted2)
				self.frame.category[id]:Hide()
				self.frame.category[id]:SetMinMaxValues(0, numTotal)
				self.frame.category[id]:SetValue(numDone)
				self.frame.category[id].text:SetText(numDone .. "/" .. numTotal)
				self.frame.category[id].name:SetText(catName)
			end
		end
		
		if self.currentTab == "guild" then
			self:HideCategorySum()
			self:ShowCategorySumGuild()
		else
			self:HideCategorySumGuild()
			self:ShowCategorySum()
		end
	else
		self:HideCategorySumGuild()
		self:HideCategorySum()
	end
	--End summary category stuff.

	--Scroll bar Stuff
	self.frame.achScroll:SetMinMaxValues(0,math.max(count-#self.frame.achButtons, 0))
	if count-#self.frame.achButtons > 0 then
		self.frame.achScroll:Show()
	else
		self.frame.achScroll:Hide()
	end
	for i = buttonNum, #self.frame.achButtons do
		self.frame.achButtons[i]:Hide()
		self.frame.achButtons[i].offset:SetWidth(1)
	end
end

function self:RefreshSummaryBar()
	local total, completed
	local name
	local compareCat = self.currentCat
	if self.currentCat < 0 then
		total, completed = GetNumCompletedAchievements()
		name = UATotal
		compareCat = -1
	else
		total, completed = GetCategoryNumAchievements(self.currentCat)
		name = GetCategoryInfo(self.currentCat)
	end

	self.frame.comparisonSummaryBar:Hide()

	if completed == 0 then
		self.frame.summaryBar:Hide()
	else
		self.frame.summaryBar:Show()
		self.frame.summaryBar:SetMinMaxValues(0, total)
		self.frame.summaryBar:SetValue(completed)
		self.frame.summaryBar.text:SetText(completed .. "/" .. total)
		if GetLocale() == 'deDE' then--It's crapy I know, I have to done something for this, I haven't the time now.
			self.frame.summaryBar.name:SetText(UAAchievEarned .. " " .. name)
		else
			self.frame.summaryBar.name:SetText(name .. " " .. UAAchievEarned)
		end

		if self.isComparing then
			local comparisonCompleted = GetComparisonCategoryNumAchievements(compareCat)
			self.frame.comparisonSummaryBar:Show()
			self.frame.comparisonSummaryBar:SetMinMaxValues(0, total)
			self.frame.comparisonSummaryBar:SetValue(comparisonCompleted)
			self.frame.comparisonSummaryBar.text:SetText(comparisonCompleted .. "/" .. total)
			self.frame.comparisonSummaryBar.name:SetText(self.comparisonUnitName)
		end
	end
end
-------------------------------------------------------------
--Comparison Stuff
-------------------------------------------------------------
function self:ComparisonUpdate()
	if self.isComparing and (self.comparisonUnit ~= "") then
		self.comparison:Show()
		self.frame.achSort.comparison:Show()
		self.compPointsText:SetText(GetComparisonAchievementPoints())
		if UnitExists(self.comparisonUnit) then
			self.compHeaderText:SetText(string.format(UAComparing .. " %s", self.comparisonUnitName))
		end
	else
		self.comparison:Hide()
		self.frame.achSort.comparison:Hide()
		self.comparisonUnit = ""
	end
	self:RefreshSummaryBar()
end

function self:SetComparisonUnit(unit)
	if not UnitExists(unit) then return end

	--Called to prevent errors from being thrown by the default UI
	achievementFunctions.selectedCategory = achievementFunctions.selectedCategory or 96

	self.isComparing = true
	self.comparisonUnit = unit
	self.comparisonUnitName = UnitName(unit)
	self.comparisonFaction = UnitFactionGroup(unit) == "Alliance" and 1 or 2

	ClearAchievementComparisonUnit()
	SetAchievementComparisonUnit(unit)
end
