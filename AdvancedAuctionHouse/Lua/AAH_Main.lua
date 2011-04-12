local locale = string.sub(GetLanguage(), 1, 2)
local func, err = loadfile("Interface/AddOns/AdvancedAuctionHouse/Locales/"..locale..".lua")
if err then
	dofile("Interface/AddOns/AdvancedAuctionHouse/Locales/EN.lua")
else
	func()
end
AdvancedAuctionHouse = true
AAHFunc = {}
AAHVar = {}
AAHVar.Build = 216
AAHVar.Version = string.match("v2.9.1", "v[%d+.]+") or "Alpha Build #"..AAHVar.Build
AAHVar.Auction_CurrentTab = nil
AAHVar.Auction_BidMoney = nil
AAHVar.Auction_BuyoutEvent = false
AAHVar.Auction_HeaderSortItem = nil
AAHVar.Browse_RarityInfo = {}
AAHVar.Browse_RarityInfo[1] = TEXT("C_ALL")
AAHVar.Browse_RarityInfo[2] = TEXT("ITEM_QUALITY1_DESC")
AAHVar.Browse_RarityInfo[3] = TEXT("ITEM_QUALITY2_DESC")
AAHVar.Browse_RarityInfo[4] = TEXT("ITEM_QUALITY3_DESC")
AAHVar.Browse_RarityInfo[5] = TEXT("ITEM_QUALITY4_DESC")
AAHVar.Browse_RarityInfo[6] = TEXT("ITEM_QUALITY5_DESC")
AAHVar.Browse_RarityInfo[7] = TEXT("UNUSUAL_LV6")
AAHVar.Browse_RarityInfo[8] = TEXT("UNUSUAL_LV7")
AAHVar.Browse_RarityInfo[9] = TEXT("ACCOUNT_SHOP")
AAHVar.Browse_RarityInfo[10] = TEXT("UNUSUAL_LV9")
AAHVar.Browse_RarityInfo[11] = TEXT("UNUSUAL_LV10")
AAHVar.Browse_RuneInfo = {}
AAHVar.Browse_RuneInfo[1] = "0+"
AAHVar.Browse_RuneInfo[2] = "1+"
AAHVar.Browse_RuneInfo[3] = "2+"
AAHVar.Browse_RuneInfo[4] = "3+"
AAHVar.Browse_RuneInfo[5] = "4+"
AAHVar.Browse_SavedSearchOptions = {}
AAHVar.Browse_SavedSearchOptions[1] = TEXT("C_SEARCH")					--Search
AAHVar.Browse_SavedSearchOptions[2] = AAHLocale.Messages.BROWSE_RENAME	--Rename
AAHVar.Browse_SavedSearchOptions[3] = TEXT("C_DEL")						--Delete
AAHVar.Browse_CategoryExpand = {}
AAHVar.Browse_CategoryButtonNums = 0
AAHVar.Browse_CategoryScrollValue = 0
AAHVar.Browse_SavedSearchExpand = {}
AAHVar.Browse_SavedSearchDragDrop = {}
AAHVar.Browse_SavedSearchNewItem = {}
AAHVar.Browse_SavedSearchRenameItem = {}
AAHVar.Browse_PageItemMaxNum = 50
AAHVar.Browse_SortMode = 0
AAHVar.Browse_HeaderCustomID = 0
AAHVar.Browse_HeaderCustom1 = "level"
AAHVar.Browse_HeaderCustom2 = "tier"
AAHVar.Browse_ItemMaxDisplay = 7
AAHVar.Bid_ItemMaxDisplay = 8
AAHVar.Bid_SortMode = 0
AAHVar.Sell_AutoFillInfo = {}
AAHVar.Sell_AutoFillInfo[1] = AAHLocale.Messages.SELL_NONE
AAHVar.Sell_AutoFillInfo[2] = AAHLocale.Messages.SELL_LAST
AAHVar.Sell_AutoFillInfo[3] = AAHLocale.Messages.GENERAL_AVERAGE
AAHVar.Sell_AutoFillInfo[4] = AAHLocale.Messages.SELL_FORMULA
AAHVar.Sell_DurationInfo = {}
AAHVar.Sell_DurationInfo[1] = TEXT("AUCTION_TIME_4")
AAHVar.Sell_DurationInfo[2] = TEXT("AUCTION_TIME_3")
AAHVar.Sell_DurationInfo[3] = TEXT("AUCTION_TIME_2")
AAHVar.Sell_DurationInfo[4] = TEXT("AUCTION_TIME_1")
AAHVar.Sell_ItemMaxDisplay = 6
AAHVar.Sell_ItemFee = 0
AAHVar.Sell_SortMode = 0
AAHVar.SettingsHistoryMin = 10
AAHVar.SettingsHistoryMax = 500
AAHVar.SettingsFilterSpeedMin = 1
AAHVar.SettingsFilterSpeedMax = 50
AAHVar.History_ItemMaxDisplay = 10
AAHVar.TimeRemaining = 6
AAHVar.BrowseItemLink = nil
AAHVar.HookItemLink = nil
AAHVar.QueueItemLink = nil
AAHVar.CurrentCachePage = 1
AAHVar.CachingActive = false
AAHVar.AuctionBrowseCache = {}
AAHVar.FilterChanged = false
AAHVar.FilterDelay = 0
AAHVar.SearchRequested = false
AAHVar.AwaitingData = false
AAHVar.SearchDelay = 0
AAHVar.LastCached = 0
AAHVar.MaxBrowsePages = 0
AAHVar.CurrentFilterPage = 0
AAHVar.CurrentFilterItem = 0
AAHVar.FilteringActive = false
AAHVar.PriceHistoryTooltipWidth = 0
AAHVar.PriceHistoryTooltipHeight = 0
AAHVar.FoundNewVersion = false
AAHVar.AutoPriceHistoryTrigger = false
AAHVar.BrowseHistoryTrigger = false
AAHVar.PriceHistoryProcessed = true
AAHVar.PriceHistoryProcessing = true
AAHVar.PriceHistoryQueue = {}
AAHVar.OldMoney = 0
AAHVar.PriceInputChangeTrigger = true
AAHVar.MatWhiteValue = dofile("Interface/AddOns/AdvancedAuctionHouse/Data/MatWhiteValue.lua")
AAHVar.PetEggs = dofile("Interface/AddOns/AdvancedAuctionHouse/Data/PetEggs.lua")
AAHVar.Recipes = dofile("Interface/AddOns/AdvancedAuctionHouse/Data/Recipes.lua")
AAHVar.StatValues = dofile("Interface/AddOns/AdvancedAuctionHouse/Data/StatsToAttributes.lua")
AAHVar.Filters = {}

local Defaults = {
	HistoryMaxSaved = 100,
	PriceHistoryAutoshow = false,
	Resize = 0,
	SellDurationSelected = 4,
	AutoFillBidSelected = 1,
	AutoFillBuyoutSelected = 1,
	SellAutoFillPercentBidValue = 100,
	FormulaBid = "",
	SellAutoFillPercentBuyoutValue = 100,
	FormulaBuyout = "",
	UseMatWhiteValue = false,
	FilterSpeed = 6,
}

function AAHFunc.MainAuctionFrame_OnLoad(this)
	PanelTemplates_SetNumTabs(this, 4)
	AuctionFrame:UnregisterEvent("AUCTION_AUCTION_INFO_UPDATE")
	AuctionFrame:UnregisterEvent("AUCTION_AUCTION_MONEY_UPDATE")
	AuctionFrame:UnregisterEvent("AUCTION_BUY_UPDATE")
	AuctionFrame:UnregisterEvent("AUCTION_SELL_UPDATE")
	AuctionFrame:UnregisterEvent("AUCTION_BROWSE_UPDATE")
	AuctionFrame:UnregisterEvent("AUCTION_SEARCH_RESULT")
	AuctionFrame:UnregisterEvent("AUCTION_HISTORY_SHOW")
	AuctionFrame:UnregisterEvent("AUCTION_HISTORY_HIDE")
	AuctionFrame:UnregisterEvent("AUCTION_OPEN")
	AuctionFrame:UnregisterEvent("AUCTION_CLOSE")
	AuctionFrame:UnregisterEvent("AUCTION_BORWSE_PRICE_UPDATE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_AUCTION_INFO_UPDATE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_BUY_UPDATE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_SELL_UPDATE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_BROWSE_UPDATE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_SEARCH_RESULT")
	AAH_AuctionFrame:RegisterEvent("AUCTION_HISTORY_SHOW")
	AAH_AuctionFrame:RegisterEvent("AUCTION_HISTORY_HIDE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_OPEN")
	AAH_AuctionFrame:RegisterEvent("AUCTION_CLOSE")
	AAH_AuctionFrame:RegisterEvent("AUCTION_BORWSE_PRICE_UPDATE")
	AAH_AuctionFrame:RegisterEvent("VARIABLES_LOADED")
	AAH_AuctionTitleText:SetText(string.gsub(AAHLocale.Messages.AUCTION_FRAME_TITLE, "<VERSION>", AAHVar.Version))
	AAH_AuctionForumsButton:SetText(AAHLocale.Messages.AUCTION_FORUMS_BUTTON)
	DEFAULT_CHAT_FRAME:AddMessage(string.gsub(AAHLocale.Messages.AUCTION_LOADED_MESSAGE, "<VERSION>", AAHVar.Version),0,255,255)
end

function AAHFunc.MainAuctionFrame_AUCTION_AUCTION_INFO_UPDATE(this, event)
	AAHFunc.SellItem_Update()
end

function AAHFunc.MainAuctionFrame_AUCTION_BUY_UPDATE(this, event)
	AAHFunc.BidList_Update()
end

function AAHFunc.MainAuctionFrame_AUCTION_SELL_UPDATE(this, event)
	AAHFunc.SellList_Update()
end

function AAHFunc.MainAuctionFrame_AUCTION_BROWSE_UPDATE(this, event)
	if AAHVar.Auction_BuyoutEvent == true then
		AAHVar.Auction_BuyoutEvent = false
		local itemID = AuctionBrowseList.list[AuctionBrowseList.selected].auctionid
		table.remove(AuctionBrowseList.list, AuctionBrowseList.selected)
		for j = 1, AAHVar.MaxBrowsePages do
			for i = 1, AAHVar.Browse_PageItemMaxNum do
				if (AAHVar.AuctionBrowseCache.CACHEDDATA[j][i]) then
					if AAHVar.AuctionBrowseCache.CACHEDDATA[j][i].auctionid then
						if AAHVar.AuctionBrowseCache.CACHEDDATA[j][i].auctionid == itemID then
							AAHVar.AuctionBrowseCache.CACHEDDATA[j][i] = {}
							break
						end
					end
				end
			end
		end
		AAHFunc.BrowseList_UpdateItems()
	end
	if AAHVar.CurrentCachePage == 1 and AAHVar.AuctionBrowseCache.PAGEREADY[1] == false and AAHVar.CachingActive == true then
		AAHVar.MaxBrowsePages = GetAuctionBrowseMaxPages()
		if GetAuctionBrowseMaxItems() == 0 then
			AAHVar.CachingActive = false
			AAH_BrowseProgressLabel:SetText(AAHLocale.Messages.BROWSE_NO_RESULTS)
		else
			AAHVar.TimeRemaining = 0
		end
	end
end

function AAHFunc.MainAuctionFrame_AUCTION_BORWSE_PRICE_UPDATE(this, event)
	for i, v in pairs(AuctionBrowseList.list) do
		if v.auctionid == arg1 then
			v.bidPrice = arg2
			v.isBuyer = arg3
			break
		end
	end
	for j = 1, AAHVar.MaxBrowsePages do
		for i = 1, AAHVar.Browse_PageItemMaxNum do
			if (AAHVar.AuctionBrowseCache.CACHEDDATA[j][i]) then
				if AAHVar.AuctionBrowseCache.CACHEDDATA[j][i].auctionid then
					if AAHVar.AuctionBrowseCache.CACHEDDATA[j][i].auctionid == arg1 then
						AAHVar.AuctionBrowseCache.CACHEDDATA[j][i].bidPrice = arg2
						AAHVar.AuctionBrowseCache.CACHEDDATA[j][i].isBuyer = arg3
					end
				end
			end
		end
	end
	AAHFunc.BrowseList_UpdateItems()
end

function AAHFunc.MainAuctionFrame_AUCTION_SEARCH_RESULT(this, event)
	AAHVar.TimeRemaining = 0
	AAH_BrowseSearchButton:Enable()
end

function AAHFunc.MainAuctionFrame_AUCTION_CLOSE(this, event)
	HideUIPanel(this)
end

function AAHFunc.MainAuctionFrame_AUCTION_OPEN(this, event)
	ShowUIPanel(this)
	PlaySoundByPath("Sound\\Interface\\shop_open.mp3")
end

function AAHFunc.MainAuctionFrame_AUCTION_HISTORY_SHOW(this, event)
	if AAHVar.AutoPriceHistoryTrigger == true then
		AAHVar.AutoPriceHistoryTrigger = false
		AAHFunc.HistoryProcessItemPriceHistory()
		AAHFunc.SellAutoFillPriceFields()
		return
	elseif AAHVar.BrowseHistoryTrigger == true then
		AAHVar.BrowseHistoryTrigger = false
		AAHFunc.HistoryProcessItemPriceHistory()
		AAHVar.PriceHistoryProcessed = true
		return
	else
		AAHFunc.HistoryProcessItemPriceHistory()
		AAHFunc.HistoryPopup_Show()
	end
end

function AAHFunc.MainAuctionFrame_AUCTION_HISTORY_HIDE(this, event)
	AAHVar.PriceHistoryProcessed = true
	if not AAHVar.PriceHistoryProcessing then
		SendSystemMsg(AAHLocale.Messages.HISTORY_NO_DATA, true)
	end
end

function AAHFunc.MainAuctionFrame_VARIABLES_LOADED(this, event)
	dofile("Interface/AddOns/AdvancedAuctionHouse/Lua/AAH_Hooks.lua")
	if not AAH_SavedSearch then
		AAH_SavedSearch = {}
	end
	SaveVariables("AAH_SavedSearch")
	if not AAH_LastSellPrice or not AAH_LastSellPrice._TABLEBUILD or AAH_LastSellPrice._TABLEBUILD < 89 then
		AAH_LastSellPrice = {}
		AAH_LastSellPrice._TABLEBUILD = AAHVar.Build
	end
	SaveVariables("AAH_LastSellPrice")
	if not AAH_SavedHistoryTable or not AAH_SavedHistoryTable._TABLEBUILD or AAH_SavedHistoryTable._TABLEBUILD < 82 then
		AAH_SavedHistoryTable = {}
		AAH_SavedHistoryTable._TABLEBUILD = AAHVar.Build
	end
	SaveVariables("AAH_SavedHistoryTable")
	if AAH_SavedSettings then
		for i, v in pairs(Defaults) do
			if AAH_SavedSettings[i] == nil then
				AAH_SavedSettings[i] = v
			end
		end
		for i, v in pairs(AAH_SavedSettings) do
			if Defaults[i] == nil then
				AAH_SavedSettings[i] = nil
			end
		end
	else
		AAH_SavedSettings = Defaults
	end
	SaveVariables("AAH_SavedSettings")
	AAHFunc.MainAuctionFrameResize_OnClick(AAH_SavedSettings.Resize)
	UIDropDownMenu_Initialize(AAH_SellDurationDropDown, AAHFunc.SellDurationDropDown_Show)
	AAHFunc.ToolsSetDropDown(AAH_SellDurationDropDown, AAH_SavedSettings.SellDurationSelected, AAHVar.Sell_DurationInfo[AAH_SavedSettings.SellDurationSelected])
	UIDropDownMenu_Initialize(AAH_SellAutoFillBidDropDown, AAHFunc.SellAutoFillBidDropDown_Show)
	AAHFunc.ToolsSetDropDown(AAH_SellAutoFillBidDropDown, AAH_SavedSettings.AutoFillBidSelected, AAHVar.Sell_AutoFillInfo[AAH_SavedSettings.AutoFillBidSelected])
	AAHFunc.SellAutoFillBidEditBox_CheckVisibility()
	UIDropDownMenu_Initialize(AAH_SellAutoFillBuyoutDropDown, AAHFunc.SellAutoFillBuyoutDropDown_Show)
	AAHFunc.ToolsSetDropDown(AAH_SellAutoFillBuyoutDropDown, AAH_SavedSettings.AutoFillBuyoutSelected, AAHVar.Sell_AutoFillInfo[AAH_SavedSettings.AutoFillBuyoutSelected])
	AAHFunc.SellAutoFillBuyoutEditBox_CheckVisibility()
	AAH_SellAutoFillPercentBid:SetText(AAH_SavedSettings.SellAutoFillPercentBidValue)
	AAH_SellAutoFillFormulaBid:SetText(AAH_SavedSettings.FormulaBid)
	AAHFunc.SellAutoFillBidEditBox_CheckVisibility()
	AAH_SellAutoFillPercentBuyout:SetText(AAH_SavedSettings.SellAutoFillPercentBuyoutValue)
	AAH_SellAutoFillFormulaBuyoutout:SetText(AAH_SavedSettings.FormulaBuyout)
	AAHFunc.SellAutoFillBuyoutEditBox_CheckVisibility()
	AAH_SettingsUseWhiteValue:SetChecked(AAH_SavedSettings.UseMatWhiteValue)
	AAH_SettingsAlwaysShowPriceHistory:SetChecked(AAH_SavedSettings.PriceHistoryAutoshow)
	AAH_SettingsMaxHistory:SetValue(AAH_SavedSettings.HistoryMaxSaved)
	AAH_SettingsFilterSpeed:SetValue(AAH_SavedSettings.FilterSpeed)
	if AddonManager then
		local addon = {
			name = "Advanced AuctionHouse",
			version = AAHVar.Version,
			author = "Mavoc, Graves",
			description = AAHLocale.Messages.ADDON_MANAGER_DESCRIPTION,
			icon = "Interface/Addons/AdvancedAuctionHouse/Textures/AAHIcon",
			category = "Economy",
			configFrame = nil,
			slashCommand = nil,
			miniButton = nil,
		}
		if AddonManager.RegisterAddonTable then
			AddonManager.RegisterAddonTable(addon)
		end
	end
	if Luna then
		Luna.RegisterAddon("AdvancedAuctionHouse", AAHFunc.ToolsLunaReceive)
--@non-alpha@
		Luna.QueueMessage("AdvancedAuctionHouse", "Build: "..AAHVar.Build)
--@end-non-alpha@
	end
end

function AAHFunc.MainAuctionFrame_OnShow(this)
	AAHFunc.MainAuctionFrameTab_OnClick(1)
	AAHFunc.ToolsSetDropDown(AAH_BrowseRarityDropDown, 1, AAHVar.Browse_RarityInfo[1], {1, 1, 1})
	AAHFunc.ToolsSetDropDown(AAH_BrowseRuneDropDown, 1, AAHVar.Browse_RuneInfo[1])
	AuctionBrowseList.pageNum = 1
	AAHVar.Browse_CategoryExpand = {}
	AAHVar.Browse_SavedSearchExpand = {}
	MoneyInputFrame_ResetMoney(AAH_BrowseBidMoneyInput)
	AAHFunc.BrowseCategoryScrollBar_Update()
	AAHFunc.BrowseSavedSearchScrollBar_Update()
	AAHFunc.BrowseList_Update()
	AAHFunc.BidList_Update()
	AAHFunc.SellList_Update()
	AAHFunc.SellItem_Update()
	AAH_BrowseSearchButton:Enable()
	AAHFunc.SellAutoFillBidEditBox_CheckVisibility()
	AAHFunc.SellAutoFillBuyoutEditBox_CheckVisibility()
end

function AAHFunc.MainAuctionFrame_OnHide(this)
	AAH_BrowseInfoLabel:SetText("")
	AAH_BrowseProgressLabel:SetText("")
	AAHFunc.BrowseSavedSearchExpandButton_OnClick("Minimize")
	AAHFunc.BrowsePrepareCachedSearch()
	AAHVar.CachingActive = false
	AAHVar.FilterChanged = false
	AAHVar.SearchRequested = false
	AAHVar.FilteringActive = false
	AAHVar.BrowseHistoryTrigger = false
	AAHVar.PriceHistoryProcessed = true
	AAHVar.PriceHistoryProcessing = true
	AAHVar.PriceHistoryQueue = {}
	AAHVar.AutoPriceHistoryTrigger = false
end

function AAHFunc.MainAuctionFrameTab_OnClick(tab)
	PanelTemplates_SetTab(AAH_AuctionFrame, tab)
	if tab == 1 then
		AAHVar.Auction_CurrentTab = "BROWSE"
		AAH_BrowseFrame:Show()
		AAH_BidFrame:Hide()
		AAH_SellFrame:Hide()
		AAH_SettingsFrame:Hide()
	elseif tab == 2 then
		AAHVar.Auction_CurrentTab = "BUY"
		AAH_BrowseFrame:Hide()
		AAH_BidFrame:Show()
		AAH_SellFrame:Hide()
		AAH_SettingsFrame:Hide()
	elseif tab == 3 then
		AAHVar.Auction_CurrentTab = "SELL"
		AAH_BrowseFrame:Hide()
		AAH_BidFrame:Hide()
		AAH_SellFrame:Show()
		AAH_SettingsFrame:Hide()
	elseif tab == 4 then
		AAHVar.Auction_CurrentTab = "SETTINGS"
		AAH_BrowseFrame:Hide()
		AAH_BidFrame:Hide()
		AAH_SellFrame:Hide()
		AAH_SettingsFrame:Show()
	end
end

function AAHFunc.MainAuctionFrameResize_OnClick(num)
	local value = 44 * num
	if num == 0 then
		AAH_AuctionEnlargeButton:Enable()
		AAH_AuctionReduceButton:Disable()
	elseif num == 5 then
		AAH_AuctionEnlargeButton:Disable()
		AAH_AuctionReduceButton:Enable()
	else
		AAH_AuctionEnlargeButton:Enable()
		AAH_AuctionReduceButton:Enable()
	end
	AAH_AuctionFrame:SetSize(846, 489 + value)
	AAH_AuctionFrameBottomLeft:SetSize(256, 233 + value)
	AAH_AuctionFrameBottomCenter:SetSize(334, 233 + value)
	AAH_AuctionFrameBottomRight:SetSize(256, 233 + value)
	AAH_BrowseList:SetSize(666, 340 + value)
	AAH_BrowseCategory:SetSize(142, 340 + value)
	AAH_BrowseSavedSearch:SetSize(144, 481 + value)
	AAH_BidList:SetSize(803, 380 + value)
	AAH_SellList:SetSize(628, 295 + value)
	AAH_SellItemBrowse:SetSize(178, 295 + value)
	AAHVar.Browse_ItemMaxDisplay = 7 + num
	AAHVar.Bid_ItemMaxDisplay = 8 + num
	AAHVar.Sell_ItemMaxDisplay = 6 + num
	for i = AAHVar.Browse_ItemMaxDisplay + 1, 12 do
		getglobal("AAH_BrowseListItem"..i):Hide()
	end
	for i = (AAHVar.Browse_ItemMaxDisplay * 2) + 1, 24 do
		getglobal("AAH_BrowseCategoryButton"..i):Hide()
	end
	for i = (AAHVar.Browse_ItemMaxDisplay * 2) + 7, 30 do
		getglobal("AAH_BrowseSavedSearchButton"..i):Hide()
	end
	for i = AAHVar.Bid_ItemMaxDisplay + 1, 13 do
		getglobal("AAH_BidListItem"..i):Hide()
	end
	for i = AAHVar.Sell_ItemMaxDisplay + 1, 11 do
		getglobal("AAH_SellListItem"..i):Hide()
	end
	for i = (AAHVar.Sell_ItemMaxDisplay * 2) + 1, 22 do
		getglobal("AAH_SellItemBrowseItem"..i):Hide()
	end
	AAHFunc.BrowseList_Update()
	AAHFunc.BrowseCategoryScrollBar_Update()
	AAHFunc.BrowseSavedSearchScrollBar_Update()
	AAHFunc.BidList_Update()
	AAHFunc.SellList_Update()
end