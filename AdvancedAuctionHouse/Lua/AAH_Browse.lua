local HeaderList = {}
--table.insert(HeaderList, {[1] = , [2] = , [3] = , [4] = })
--General
table.insert(HeaderList, {[1] = C_LEVEL, [2] = C_LEVEL, [3] = "level", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = AAHLocale.Messages.GENERAL_TIER_HEADER, [2] = AAHLocale.Messages.GENERAL_TIER_HEADER, [3] = "tier", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = AAHLocale.Messages.GENERAL_PLUS_HEADER, [2] = AAHLocale.Messages.GENERAL_PLUS_HEADER, [3] = "plus", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = AAHLocale.Messages.GENERAL_WORTH_HEADER, [2] = AAHLocale.Messages.GENERAL_WORTH_HEADER, [3] = "worth", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = TEXT("SYS_ITEM_DURABLE"), [2] = AAHLocale.Messages.GENERAL_DURA_HEADER, [3] = "dura", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAPON_MDMG"), [2] = AAHLocale.Messages.GENERAL_MDAM_HEADER, [3] = "mdam", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAPON_DMG"), [2] = AAHLocale.Messages.GENERAL_PDAM_HEADER, [3] = "pdam", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAPON_ATKSPEED"), [2] = AAHLocale.Messages.GENERAL_SPEED_HEADER, [3] = "speed", [4] = "GENERAL"})
table.insert(HeaderList, {[1] = AAHLocale.Messages.GENERAL_DPS_HEADER, [2] = AAHLocale.Messages.GENERAL_DPS_HEADER, [3] = "dps", [4] = "GENERAL"})
--Stats
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_3"), [2] = AAHLocale.Messages.GENERAL_STAM_HEADER, [3] = "sta", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_2"), [2] = AAHLocale.Messages.GENERAL_STR_HEADER, [3] = "str", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_6"), [2] = AAHLocale.Messages.GENERAL_DEX_HEADER, [3] = "dex", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_5"), [2] = AAHLocale.Messages.GENERAL_WIS_HEADER, [3] = "wis", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_4"), [2] = AAHLocale.Messages.GENERAL_INTEL_HEADER, [3] = "int", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_8"), [2] = AAHLocale.Messages.GENERAL_HP_HEADER, [3] = "hp", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_9"), [2] = AAHLocale.Messages.GENERAL_MP_HEADER, [3] = "mp", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_12"), [2] = AAHLocale.Messages.GENERAL_PATT_HEADER, [3] = "patt", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_15"), [2] = AAHLocale.Messages.GENERAL_MATT_HEADER, [3] = "matt", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_ARMOR_DEF"), [2] = AAHLocale.Messages.GENERAL_PDEF_HEADER, [3] = "pdef", [4] = "STATS"})
table.insert(HeaderList, {[1] = TEXT("SYS_ARMOR_MDEF"), [2] = AAHLocale.Messages.GENERAL_MDEF_HEADER, [3] = "mdef", [4] = "STATS"})
--Attributes
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_18"), [2] = AAHLocale.Messages.GENERAL_PCRIT_HEADER, [3] = "pcrit", [4] = "ATTRIBUTES"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_20"), [2] = AAHLocale.Messages.GENERAL_MCRIT_HEADER, [3] = "mcrit", [4] = "ATTRIBUTES"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_16"), [2] = AAHLocale.Messages.GENERAL_PACC_HEADER, [3] = "pacc", [4] = "ATTRIBUTES"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_195"), [2] = AAHLocale.Messages.GENERAL_MACC_HEADER, [3] = "macc", [4] = "ATTRIBUTES"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_17"), [2] = AAHLocale.Messages.GENERAL_PDOD_HEADER, [3] = "pdod", [4] = "ATTRIBUTES"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_22"), [2] = AAHLocale.Messages.GENERAL_PARRY_HEADER, [3] = "parry", [4] = "ATTRIBUTES"})
table.insert(HeaderList, {[1] = TEXT("SYS_WEAREQTYPE_150"), [2] = AAHLocale.Messages.GENERAL_HEAL_HEADER, [3] = "heal", [4] = "ATTRIBUTES"})
--Other
--table.insert(HeaderList, {[1] = , [2] = , [3] = , [4] = "OTHER"})

function AAHFunc.BrowseFrame_OnLoad(this)
	AAH_BrowseHeaderPPU:SetText(AAHLocale.Messages.GENERAL_PRICE_PER_UNIT_HEADER)
	AAH_BrowseHeaderCustom2:SetText(AAHLocale.Messages.GENERAL_TIER_HEADER)
	AAH_BrowseHeaderName:SetWidth(AAH_BrowseHeaderName:GetTextWidth() + 12)
	AAH_BrowseHeaderCustom1:SetWidth(AAH_BrowseHeaderCustom1:GetTextWidth() + 12)
	AAH_BrowseHeaderCustom2:SetWidth(AAH_BrowseHeaderCustom2:GetTextWidth() + 12)
	AAH_BrowseHeaderLeftTime:SetWidth(AAH_BrowseHeaderLeftTime:GetTextWidth() + 12)
	AAH_BrowseHeaderSeller:SetWidth(AAH_BrowseHeaderSeller:GetTextWidth() + 12)
	AAH_BrowseHeaderPPU:SetWidth(AAH_BrowseHeaderPPU:GetTextWidth() + 12)
	AAH_BrowseHeaderPrice:SetWidth(AAH_BrowseHeaderPrice:GetTextWidth() + 12)
	AAH_BrowseHeaderCustom1:SetTextColor(0.6,0.8,1)
	AAH_BrowseHeaderCustom2:SetTextColor(0.6,0.8,1)
	UIDropDownMenu_Initialize(AAH_BrowseHeaderCustom1Menu, AAHFunc.BrowseHeaderCustomMenu, "MENU")
	UIDropDownMenu_Initialize(AAH_BrowseHeaderCustom2Menu, AAHFunc.BrowseHeaderCustomMenu, "MENU")
	AAH_BrowseUsableButtonLabel:SetText(AAHLocale.Messages.BROWSE_USABLE)
	AAH_BrowseResetButton:SetText(AAHLocale.Messages.BROWSE_CLEAR_BUTTON)
	AAH_BrowseFilterPPUButtonLabel:SetText(AAHLocale.Messages.BROWSE_PPU)
	AAH_BrowseFilterMinPriceEditBoxLabel:SetText(AAHLocale.Messages.BROWSE_MIN)
	AAH_BrowseFilterMaxPriceButtonLabel:SetText(AAHLocale.Messages.BROWSE_MAX)
	AAH_BrowseFilter1EditBoxLabel:SetText(AAHLocale.Messages.BROWSE_FILTER)
	AAH_BrowseFilter2OrButtonLabel:SetText(AAHLocale.Messages.BROWSE_OR)
	AAH_BrowseFilter3OrButtonLabel:SetText(AAHLocale.Messages.BROWSE_OR)
	AAH_BrowseSavedSearchTitle:SetText(AAHLocale.Messages.BROWSE_SAVED_SEARCH_TITLE)
	AAH_BrowseSearchLabel:SetText(AAHLocale.Messages.BROWSE_SEARCH_PARAMETERS)
	AAHFunc.BrowsePrepareCachedSearch()
end

function AAHFunc.BrowseFrame_OnUpdate(this, elapsedTime)
	if AAHVar.SearchRequested == true then
		AAHVar.SearchDelay = AAHVar.SearchDelay - elapsedTime
	end
	if AAHVar.SearchRequested == true and AAHVar.SearchDelay <= 0 then
		AAHVar.SearchRequested = false
		AAHFunc.BrowseExecuteSearch()
	end
	if AAHVar.PriceHistoryProcessing and #(AAHVar.PriceHistoryQueue) > 0 then
		if AAHVar.PriceHistoryProcessed then
			local queueItem = table.remove(AAHVar.PriceHistoryQueue)
			if queueItem and queueItem.auctionid ~= nil and queueItem.link ~= nil then
				AAHVar.PriceHistoryProcessed = false
				AAHVar.BrowseHistoryTrigger = true
				AAHVar.QueueItemLink = queueItem.link
				AuctionBrowseHistoryRequest(queueItem.auctionid)
			end
		end
	end
	if AAHVar.FilteringActive == true then
		for i = 1, AAH_SavedSettings.FilterSpeed do
			while (not((AAHVar.AuctionBrowseCache.PAGEREADY and AAHVar.AuctionBrowseCache.PAGEREADY[AAHVar.CurrentFilterPage] == true and AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentFilterPage][AAHVar.CurrentFilterItem] and AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentFilterPage][AAHVar.CurrentFilterItem].auctionid)
			or (AAHVar.CurrentFilterPage > AAHVar.MaxBrowsePages))) do
				AAHVar.CurrentFilterItem = AAHVar.CurrentFilterItem + 1
				if AAHVar.CurrentFilterItem > AAHVar.Browse_PageItemMaxNum then
					AAHVar.CurrentFilterItem = 1
					AAHVar.CurrentFilterPage = AAHVar.CurrentFilterPage + 1
				end
			end
			if AAHVar.CurrentFilterPage > AAHVar.MaxBrowsePages then
				AAHVar.FilteringActive = false
				break
			else
				AAHFunc.BrowseAddItemToList(AAHVar.CurrentFilterPage, AAHVar.CurrentFilterItem)

				AAHVar.CurrentFilterItem = AAHVar.CurrentFilterItem + 1
				if AAHVar.CurrentFilterItem > AAHVar.Browse_PageItemMaxNum then
					AAHVar.CurrentFilterItem = 1
					AAHVar.CurrentFilterPage = AAHVar.CurrentFilterPage + 1
				end
			end
		end
		AAHFunc.BrowseInfoLabelUpdate()
		local maxValue = #(AuctionBrowseList.list) - AAHVar.Browse_ItemMaxDisplay
		if maxValue > 0 or (AuctionBrowseList.pageNum > 1 and maxValue == 0) then
			AAH_BrowseListScrollBar:SetMinMaxValues(0, maxValue)
			AAH_BrowseListScrollBar:Show()
		else
			AAH_BrowseListScrollBar:SetMinMaxValues(0, 0)
			AAH_BrowseListScrollBar:Hide()
		end
		AAHFunc.BrowseList_UpdateItems()
	end
	if AAHVar.FilterChanged == true then
		AAHVar.FilterDelay = AAHVar.FilterDelay + elapsedTime
	end
	if AAHVar.FilterChanged == true and AAHVar.FilterDelay > 2 then
		AAHVar.FilterChanged = false
		AAHFunc.BrowseList_Update()
	end
	if AAHVar.CachingActive == true then
		AAHVar.TimeRemaining = AAHVar.TimeRemaining - elapsedTime
	end
	if AAHVar.TimeRemaining <= 0 then
		if (AAHVar.CurrentCachePage <= AAHVar.MaxBrowsePages) and (AAHVar.CachingActive == true) then
			if AAHVar.CurrentCachePage == 1 then
				AAHFunc.BrowseCachePage(true)
			elseif AAHVar.AwaitingData == true then
				AAHFunc.BrowseCachePage(false)
			elseif AuctionBrowseNextPage(AAHVar.CurrentCachePage) then
				AAHFunc.BrowseCachePage(false)
			else
				AAHVar.TimeRemaining = 1
			end
		else
			AAHVar.CachingActive = false
			AAHVar.TimeRemaining = 0.1
		end
	end
end

function AAHFunc.BrowseHeader_OnClick(this, key)
	local id = this:GetID()
	if key == "LBUTTON" then
		AAHFunc.BrowseClearSortIcons()
		if AuctionBrowseList.sortIndex == id or AuctionBrowseList.sortIndex == -id then
			AAHVar.Browse_SortMode = (AAHVar.Browse_SortMode + 1) % 4
		else
			AAHVar.Browse_SortMode = 0
		end
		if id == 7 or id == 6 then
			if AAHVar.Browse_SortMode == 0 then
				getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_up")
			elseif AAHVar.Browse_SortMode == 1 then
				getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_down")
			elseif AAHVar.Browse_SortMode == 2 then
				getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\hollow_arrow_up")
			elseif AAHVar.Browse_SortMode == 3 then
				getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\hollow_arrow_down")
			end
		else
			if AuctionBrowseList.sortIndex == id then
				id = -id
				getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_down")
			else
				getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_up")
			end
		end
		AAHFunc.BrowseList_Sort(id)
	elseif key == "RBUTTON" then
		if id == 2 then
			AAHVar.Browse_HeaderCustomID = 1
			ToggleDropDownMenu(AAH_BrowseHeaderCustom1Menu)
		elseif id == 3 then
			AAHVar.Browse_HeaderCustomID = 2
			ToggleDropDownMenu(AAH_BrowseHeaderCustom2Menu)
		end
	end
end

function AAHFunc.BrowseClearSortIcons()
	AAH_BrowseHeaderNameSortIcon:SetFile("")
	AAH_BrowseHeaderCustom1SortIcon:SetFile("")
	AAH_BrowseHeaderCustom2SortIcon:SetFile("")
	AAH_BrowseHeaderLeftTimeSortIcon:SetFile("")
	AAH_BrowseHeaderSellerSortIcon:SetFile("")
	AAH_BrowseHeaderPPUSortIcon:SetFile("")
	AAH_BrowseHeaderPriceSortIcon:SetFile("")
end

function AAHFunc.BrowseList_Sort(index)
	AuctionBrowseList.sortIndex = index
	if math.abs(index) == 7 then
		if AAHVar.Browse_SortMode == 0 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBidLess)
		elseif AAHVar.Browse_SortMode == 1 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBidMore)
		elseif AAHVar.Browse_SortMode == 2 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBuyoutLess)
		elseif AAHVar.Browse_SortMode == 3 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBuyoutMore)
		end
	elseif math.abs(index) == 6 then
		if AAHVar.Browse_SortMode == 0 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBidPPULess)
		elseif AAHVar.Browse_SortMode == 1 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBidPPUMore)
		elseif AAHVar.Browse_SortMode == 2 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBuyoutPPULess)
		elseif AAHVar.Browse_SortMode == 3 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortBuyoutPPUMore)
		end
	else
		if math.abs(index) == 1 then
			AAHVar.Auction_HeaderSortItem = "name"
		elseif math.abs(index) == 2 then
			AAHVar.Auction_HeaderSortItem = AAHVar.Browse_HeaderCustom1
		elseif math.abs(index) == 3 then
			AAHVar.Auction_HeaderSortItem = AAHVar.Browse_HeaderCustom2
		elseif math.abs(index) == 4 then
			AAHVar.Auction_HeaderSortItem = "leftTime"
		elseif math.abs(index) == 5 then
			AAHVar.Auction_HeaderSortItem = "seller"
		end
		if AuctionBrowseList.sortIndex > 0 then
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortLess)
		else
			table.sort(AuctionBrowseList.list, AAHFunc.ToolsSortMore)
		end
	end
	AAHFunc.BrowseList_UpdateItems()
end

function AAHFunc.BrowseHeaderCustomMenu()
	local info = {}
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		info.text = AAHLocale.Messages.BROWSE_HEADER_CUSTOM_TITLE
		info.isTitle = true
		info.notCheckable = true
		UIDropDownMenu_AddButton(info, 1)
		info = {}
		info.text = AAHLocale.Messages.GENERAL_GENERAL
		info.value = "GENERAL"
		info.notCheckable = true
		info.hasArrow = true
		UIDropDownMenu_AddButton(info, 1)
		info = {}
		info.text = AAHLocale.Messages.GENERAL_STATS
		info.value = "STATS"
		info.notCheckable = true
		info.hasArrow = true
		UIDropDownMenu_AddButton(info, 1)
		info = {}
		info.text = AAHLocale.Messages.GENERAL_ATTRIBUTES
		info.value = "ATTRIBUTES"
		info.notCheckable = true
		info.hasArrow = true
		UIDropDownMenu_AddButton(info, 1)
--		info = {}
--		info.text = AAHLocale.Messages.GENERAL_OTHER
--		info.value = "OTHER"
--		info.notCheckable = true
--		info.hasArrow = true
--		UIDropDownMenu_AddButton(info, 1)
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		for i = 1, #(HeaderList) do
			if HeaderList[i][4] == UIDROPDOWNMENU_MENU_VALUE then
				info = {}
				info.text = HeaderList[i][1]
				info.arg1 = HeaderList[i][2]
				info.value = HeaderList[i][3]
				info.arg2 = AAHVar.Browse_HeaderCustomID
				info.notCheckable = true
				info.func = function(button)
					AAHVar["Browse_HeaderCustom"..button.arg2] = button.value
					local header = getglobal("AAH_BrowseHeaderCustom"..button.arg2)
					header:SetText(button.arg1)
					header:SetWidth(header:GetTextWidth() + 12)
					if AuctionBrowseList.sortIndex == button.arg2 + 1 or AuctionBrowseList.sortIndex == -(button.arg2 + 1) then
						AAHFunc.BrowseClearSortIcons()
					end
					CloseDropDownMenus()
					AAHFunc.BrowseList_UpdateItems()
				end
				UIDropDownMenu_AddButton(info, 2)
			end
		end
	end
end

function AAHFunc.BrowseBidButton_OnClick(this)
	local money = MoneyInputFrame_GetCopper(AAH_BrowseBidMoneyInput)
	if money > GetPlayerMoney("copper") then
		StaticPopup_Show("BUYOUT_ALERT")
		return
	end
	local selected = AuctionBrowseList.selected
	if selected then
		if money == AAHFunc.ToolsGetRationalBidPrices(AuctionBrowseList.list[selected].bidPrice) then
			AAHVar.Auction_BidMoney = AuctionBrowseList.list[selected].bidPrice
			AAHVar.RationalValues = {
				bidPrice = money,
				auctionid = AuctionBrowseList.list[selected].auctionid,
				name = AuctionBrowseList.list[selected].name,
			}
		else
			AAHVar.Auction_BidMoney = MoneyInputFrame_GetCopper(AAH_BrowseBidMoneyInput)
		end
		AuctionBrowseBuyItem(AuctionBrowseList.list[selected].auctionid, AAHVar.Auction_BidMoney)
	end
end

function AAHFunc.BrowseBuyoutButton_OnClick(this)
	local selected = AuctionBrowseList.selected
	if selected then
		if AuctionBrowseList.list[selected].buyoutPrice > GetPlayerMoney("copper") then
			StaticPopup_Show("BUYOUT_ALERT")
		else
			StaticPopup_Show("BUYOUT_CONFIRMATION", AuctionBrowseList.list[selected].name)
		end
	end
end

function AAHFunc.BrowseCategoryScrollBar_Update()
	local maxValue = GetAuctionBrowseFilterMaxItems(AAHVar.Browse_CategoryExpand[1], AAHVar.Browse_CategoryExpand[2]) - (AAHVar.Browse_ItemMaxDisplay * 2)
	if maxValue > 0 then
		AAH_BrowseCategoryScrollBar:Show()
		AAH_BrowseCategoryScrollBar:SetMinMaxValues(0, maxValue)
	else
		AAH_BrowseCategoryScrollBar:Hide()
		AAH_BrowseCategoryScrollBar:SetMinMaxValues(0, 0)
	end
	AAHFunc.BrowseCategory_UpdateList()
end

function AAHFunc.BrowseCategory_UpdateList()
	AAHVar.Browse_CategoryButtonNums = 0
	AAHVar.Browse_CategoryScrollValue = AAH_BrowseCategoryScrollBar:GetValue()
	AAHFunc.BrowseCategory_SetItemInfo(1, GetAuctionBrowseFilterList())
	for i = AAHVar.Browse_CategoryButtonNums + 1, AAHVar.Browse_ItemMaxDisplay * 2 do
		getglobal("AAH_BrowseCategoryButton"..i):Hide()
	end
end

function AAHFunc.BrowseCategory_SetItemInfo(layer, ...)
	for i = 1, arg.n do
		if AAHVar.Browse_CategoryButtonNums >= AAHVar.Browse_ItemMaxDisplay * 2 then
			return
		end
		if AAHVar.Browse_CategoryScrollValue > 0 then
			AAHVar.Browse_CategoryScrollValue = AAHVar.Browse_CategoryScrollValue - 1
		else
			local count = AAHVar.Browse_CategoryButtonNums + 1
			local button = getglobal("AAH_BrowseCategoryButton"..count)
			local normalText = getglobal(button:GetName().."NormalText")
			local highlightText = getglobal(button:GetName().."HighlightText")
			local lineTexture = getglobal(button:GetName().."Line")
			local backgoundTexture = getglobal(button:GetName().."Backgound")
			local width = 116
			button.layer = layer
			button.index = i
			if layer == 1 then
				backgoundTexture:Show()
				backgoundTexture:SetAlpha(1.0)
				lineTexture:Hide()
				normalText:ClearAllAnchors()
				normalText:SetAnchor("LEFT", "LEFT", button:GetName(), 10, 0)
				normalText:SetWidth(width - 20)
				normalText:SetColor(1, 1, 0)
				highlightText:ClearAllAnchors()
				highlightText:SetAnchor("LEFT", "LEFT", button:GetName(), 10, 0)
				highlightText:SetWidth(width - 20)
				highlightText:SetColor(1, 1, 0)
			elseif layer == 2 then
				backgoundTexture:Show()
				backgoundTexture:SetAlpha(0.5)
				lineTexture:Hide()
				normalText:ClearAllAnchors()
				normalText:SetAnchor("LEFT", "LEFT", button:GetName(), 15, 0)
				normalText:SetWidth(width - 25)
				normalText:SetColor(1, 1, 1)
				highlightText:ClearAllAnchors()
				highlightText:SetAnchor("LEFT", "LEFT", button:GetName(), 15, 0)
				highlightText:SetWidth(width - 25)
				highlightText:SetColor(1, 1, 1)
			else
				backgoundTexture:Hide()
				lineTexture:Show()
				if i == arg.n then
					lineTexture:SetTexCoord(0, 1, 0.5, 0.8125)
				else
					lineTexture:SetTexCoord(0, 1, 0, 0.3125)
				end
				normalText:ClearAllAnchors()
				normalText:SetAnchor("LEFT", "LEFT", button:GetName(), 20, 0)
				normalText:SetWidth(width - 30)
				normalText:SetColor(1, 1, 1)
				highlightText:ClearAllAnchors()
				highlightText:SetAnchor("LEFT", "LEFT", button:GetName(), 20, 0)
				highlightText:SetWidth(width - 30)
				highlightText:SetColor(1, 1, 1)
			end
			button:SetText(arg[i])
			if AAHVar.Browse_CategoryExpand[layer] == i then
				button:LockHighlight()
			else
				button:UnlockHighlight()
			end
			button:Show()
			AAHVar.Browse_CategoryButtonNums = count
		end
		if layer == 1 then
			if AAHVar.Browse_CategoryExpand[1] == i then
				AAHFunc.BrowseCategory_SetItemInfo(layer + 1, GetAuctionBrowseFilterList(i))
			end
		elseif layer == 2 then
			if AAHVar.Browse_CategoryExpand[2] == i then
				AAHFunc.BrowseCategory_SetItemInfo(layer + 1, GetAuctionBrowseFilterList(AAHVar.Browse_CategoryExpand[1], i))
			end
		end
	end
end

function AAHFunc.BrowseCategoryButton_OnClick(this, key)
	for index, value in pairs(AAHVar.Browse_CategoryExpand) do
		if index > this.layer then
			AAHVar.Browse_CategoryExpand[index] = nil
		end
	end
	if AAHVar.Browse_CategoryExpand[this.layer] == this.index then
		AAHVar.Browse_CategoryExpand[this.layer] = nil
	else
		AAHVar.Browse_CategoryExpand[this.layer] = this.index
	end
	AAHFunc.BrowseCategoryScrollBar_Update()
end

function AAHFunc.BrowseRuneDropDown_Show()
	for i = 1, 5 do
		info= {}
		info.text = AAHVar.Browse_RuneInfo[i]
		info.func = function(button)
			AAHFunc.ToolsSetDropDown(AAH_BrowseRuneDropDown, button:GetID(), button:GetText())
		end
		UIDropDownMenu_AddButton(info)
	end
end

function AAHFunc.BrowseRarityDropDown_Show()
	local info
	for i = 1, 11 do
		info = {}
		info.text = AAHVar.Browse_RarityInfo[i]
		info.textR, info.textG, info.textB = GetItemQualityColor(i - 1)
		info.func = function(button)
			AAHFunc.ToolsSetDropDown(AAH_BrowseRarityDropDown, button:GetID(), button:GetText(), {GetItemQualityColor(button:GetID() - 1)})
		end
		UIDropDownMenu_AddButton(info)
	end
end

function AAHFunc.BrowseResetButton_OnClick()
	AAH_BrowseNameEditBox:SetText("")
	AAH_BrowseMinLvlEditBox:SetText("")
	AAH_BrowseMaxLvlEditBox:SetText("")
	AAHFunc.ToolsSetDropDown(AAH_BrowseRarityDropDown, 1, AAHVar.Browse_RarityInfo[1], {1, 1, 1})
	AAHFunc.ToolsSetDropDown(AAH_BrowseRuneDropDown, 1, AAHVar.Browse_RuneInfo[1])
	AAH_BrowseUsableButton:SetChecked(false)
	AAHVar.Browse_CategoryExpand = {}
	AAHFunc.BrowseCategoryScrollBar_Update()
	AAH_BrowseFilter1EditBox:SetText("")
	AAH_BrowseFilter2EditBox:SetText("")
	AAH_BrowseFilter3EditBox:SetText("")
	AAH_BrowseFilter2OrButton:SetChecked(false)
	AAH_BrowseFilter3OrButton:SetChecked(false)
	AAH_BrowseFilterPPUButton:SetChecked(false)
	AAH_BrowseFilterBidButton:SetChecked(false)
	AAH_BrowseFilterMinPriceEditBox:SetText("")
	AAH_BrowseFilterMaxPriceEditBox:SetText("")
end

function AAHFunc.BrowseSearchButton_OnClick()
	if AAHVar.CachingActive == false then
		AAHFunc.BrowsePrepareCachedSearch()
		AAHFunc.BrowseList_Update()
		AAHFunc.BrowseExecuteSearch()
	else
		AAH_BrowseSearchButton:Disable()
		AAHVar.CachingActive = false
		AAHVar.SearchRequested = true
		AAHFunc.BrowsePrepareCachedSearch()
		AAHFunc.BrowseList_Update()
		AAH_BrowseProgressLabel:SetText(AAHLocale.Messages.BROWSE_CANCELLING)
		AAH_BrowseInfoLabel:SetText("")
		AAHVar.SearchDelay = 6.0
	end
end

function AAHFunc.BrowseExecuteSearch()
	local name = AAH_BrowseNameEditBox:GetText()
	local minlvl = AAH_BrowseMinLvlEditBox:GetNumber()
	local maxlvl = AAH_BrowseMaxLvlEditBox:GetNumber()
	local rarity = UIDropDownMenu_GetSelectedID(AAH_BrowseRarityDropDown)
	local rune = UIDropDownMenu_GetSelectedID(AAH_BrowseRuneDropDown)
	local usable = AAH_BrowseUsableButton:IsChecked()
	name = string.gsub(name, "'", "''")
	AAHVar.PriceHistoryQueue = {}
	AuctionBrowseList.pageNum = 1
	AAH_BrowseProgressLabel:SetText(AAHLocale.Messages.BROWSE_SEARCHING)
	AAH_BrowseInfoLabel:SetText("")
	AAHVar.TimeRemaining = 6.5
	AAHVar.CachingActive = true
	AuctionBrowseSearchItem(name, minlvl, maxlvl, rarity, 1, rune, usable, AAHVar.Browse_CategoryExpand[1], AAHVar.Browse_CategoryExpand[2], AAHVar.Browse_CategoryExpand[3])
	AAH_BrowseSearchButton:Disable()
end

function AAHFunc.BrowsePrepareCachedSearch()
	AAHVar.AuctionBrowseCache.PAGEREADY = {}
	AAHVar.AuctionBrowseCache.CACHEDDATA = {}
	for i = 1, 10 do
		AAHVar.AuctionBrowseCache.PAGEREADY[i] = false
		AAHVar.AuctionBrowseCache.CACHEDDATA[i] = {}
	end
	AAHVar.CurrentCachePage = 1
end

function AAHFunc.BrowseFilter_TooltipDisplay(this, num)
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT", 0, -50)
	GameTooltip:SetText(AAHLocale.Messages.BROWSE_FILTER_TOOLTIP_HEADER .. num, 1, 1, 1)
	GameTooltip:AddLine(AAHLocale.Messages.BROWSE_FILTER_TOOLTIP_TEXT1, 0, 0.75, 0.95)
	GameTooltip:AddLine(AAHLocale.Messages.BROWSE_FILTER_TOOLTIP_TEXT2, 0, 0.75, 0.95)
	GameTooltip:AddLine(AAHLocale.Messages.BROWSE_FILTER_TOOLTIP_TEXT3, 0, 0.75, 0.95)
	GameTooltip:Show()
end

function AAHFunc.BrowseFilterChange()
	AAHVar.FilterChanged = true
	AAHVar.FilterDelay = 0
end

function AAHFunc.BrowseCachePage(firstPage)
	local auctionid, texture, name, count, rarity, level, leftTime, seller, isBuyer, bidPrice, buyoutPrice, link, itemid, itemname
	local j, max
	-- check if all items are loaded
	if (AAHVar.CurrentCachePage < AAHVar.MaxBrowsePages) then -- not on last page
		j = AAHVar.Browse_PageItemMaxNum
	else -- last page
		max=GetAuctionBrowseMaxItems()
		j = max - (AAHVar.MaxBrowsePages-1)*AAHVar.Browse_PageItemMaxNum
	end
	auctionid, name, count, rarity, texture, level, leftTime, seller, isBuyer, _, bidPrice, buyoutPrice = GetAuctionBrowseItemInfo(AAHVar.CurrentCachePage, j)
	if (not auctionid) then -- not loaded
		if AAHVar.CurrentCachePage <= AAHVar.MaxBrowsePages then
			AAHVar.TimeRemaining = 1.0 -- try again later
			AAHVar.AwaitingData = true
		else -- end of result
			AAHVar.CachingActive = false -- stop loading
			AAHVar.AwaitingData = false
		end
		return
	end
	AAHVar.AwaitingData = false
	for i = 1, AAHVar.Browse_PageItemMaxNum do
		auctionid, name, count, rarity, texture, level, leftTime, seller, isBuyer, _,bidPrice, buyoutPrice = GetAuctionBrowseItemInfo(AAHVar.CurrentCachePage, i)
		if auctionid then
			link = GetAuctionBrowseItemLink(auctionid)
			itemid, itemname = AAHFunc.ToolsParseLink(link)
		end
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i] = {}
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].auctionid = auctionid
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].itemid = itemid
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].link = link
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].name = name
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].count = count
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].rarity = rarity
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].texture = texture
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].level = level
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].levelcolor = NORMAL_FONT_COLOR_CODE
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].leftTime = leftTime
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].seller = seller
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].isBuyer = isBuyer
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].bidPrice = bidPrice
		AAHVar.AuctionBrowseCache.CACHEDDATA[AAHVar.CurrentCachePage][i].buyoutPrice = buyoutPrice
		if auctionid and name then
			local found = false
			for i, v in ipairs(AAHVar.PriceHistoryQueue) do
				if v.itemid == itemid then
					found = true
					break
				end
			end
			if not found then
				local queueItem = {}
				queueItem.name = name
				queueItem.auctionid = auctionid
				queueItem.link = link
				queueItem.itemid = itemid
				table.insert(AAHVar.PriceHistoryQueue, queueItem)
			end
		end
	end
	AAHVar.AuctionBrowseCache.PAGEREADY[AAHVar.CurrentCachePage] = true
	AAHVar.LastCached = AAHVar.CurrentCachePage
	AAHFunc.BrowseInfoLabelUpdate()
	AAHVar.CurrentCachePage = AAHVar.CurrentCachePage + 1
	if firstPage == true then
		AAHFunc.BrowseList_Update()
	else
		AAHFunc.BrowseList_Update(AAHVar.LastCached)
	end
	AAHVar.TimeRemaining = 6
end

function AAHFunc.BrowseList_Update(addPage)
	AuctionBrowseList.nextPage = nil
	if addPage then
		if AAHVar.FilteringActive == false then
			AAHVar.CurrentFilterPage = addPage
			AAHVar.CurrentFilterItem = 1
			AAHVar.FilteringActive = true
		end
		AAHFunc.BrowseInfoLabelUpdate()
	else
		AuctionBrowseList.maxNums = GetAuctionBrowseMaxItems()
		AuctionBrowseList.list = {}
		if AuctionBrowseList.maxNums > 0 then
			AAHVar.CurrentFilterPage = 1
			AAHVar.CurrentFilterItem = 1
			AAHVar.FilteringActive = true
			AAH_BrowseProgressLabel:SetText("")
			if AuctionBrowseList.sortIndex then
				AAHFunc.BrowseList_Sort(AuctionBrowseList.sortIndex)
			end
		end
		AAHFunc.BrowseList_UpdateItems()
	end
end

function AAHFunc.BrowseAddPageToList(pageNumber)
	if AAHVar.AuctionBrowseCache.PAGEREADY and AAHVar.AuctionBrowseCache.PAGEREADY[pageNumber] == true then
		for i = 1, AAHVar.Browse_PageItemMaxNum do
			AAHFunc.BrowseAddItemToList(pageNumber, i)
		end
	end
end

function AAHFunc.BrowseAddItemToList(pageNumber, itemIndex)
	if AAHVar.AuctionBrowseCache.PAGEREADY and AAHVar.AuctionBrowseCache.PAGEREADY[pageNumber] == true then
		local listing = AAHVar.AuctionBrowseCache.CACHEDDATA[pageNumber][itemIndex]
		if listing.auctionid then
			if listing.buyoutPrice > 0 then
				listing.buyppu = listing.buyoutPrice / listing.count
			else
				listing.buyppu = -1
			end
			listing.bidppu = AAHFunc.ToolsGetRationalBidPrices(listing.bidPrice) / listing.count
			if AAHVar.Recipes[listing.itemid] then
				listing.levelcolor = GREEN_FONT_COLOR_CODE
				listing.level = AAHVar.Recipes[listing.itemid]
			end
			AAH_Tooltip:SetHyperLink(listing.link)
			AAH_Tooltip:Hide()
			GameTooltip1:Hide()
			GameTooltip2:Hide()
			local left, leftVis, right, rightVis
			listing.tier = 0		--Tier
			listing.plus = 0		--Plus
			listing.dura = 0		--Max Durability
			listing.worth = 0		--Vendor Value
			listing.mdam = 0		--Magical Damage
			listing.pdam = 0		--Physical Damage
			listing.speed = 0		--Attack Speed
			listing.dps = 0			--DPS
			listing.sta = 0			--Stamina
			listing.str = 0			--Strength
			listing.dex = 0			--Dexterity
			listing.wis = 0			--Wisdom
			listing.int = 0			--Intelligence
			listing.hp = 0			--Maximum HP
			listing.mp = 0			--Maximum MP
			listing.patt = 0		--Physical Attack
			listing.matt = 0		--Magical Attack
			listing.pdef = 0		--Physical Defense
			listing.mdef = 0		--Magical Defense
			listing.pcrit = 0		--Physical Crit Rate
			listing.mcrit = 0		--Magical Crit Rate
			listing.pacc = 0		--Physical Accuracy
			listing.macc = 0		--Magical Accuracy
			listing.pdod = 0		--Physical Dodge Rate
			listing.parry = 0		--Parry Rate
			listing.heal = 0		--Healing Bonus
			for i = 1, 40 do
				leftVis = getglobal("AAH_TooltipTextLeft"..i):IsVisible()
				rightVis = getglobal("AAH_TooltipTextRight"..i):IsVisible()
				if not leftVis and not rightVis then
					break
				end
				left = getglobal("AAH_TooltipTextLeft"..i):GetText()
				if left and left ~= "" and leftVis then
					left = string.gsub(left, "|c%x%x%x%x%x%x%x%x", "")
					left = string.gsub(left, "|r", "")
					--left = string.gsub(left, COMMA, "")
					if AAHVar.PetEggs[listing.itemid] and string.find(left, TEXT("PET_LEVEL").."%d+") == 1 then
						listing.levelcolor = GREEN_FONT_COLOR_CODE
						listing.level = tonumber(string.match(left, "%d+"))
					elseif string.find(left, listing.name.." %+ %d+") == 1 then
						left = string.gsub(left, listing.name, "")
						listing.plus = tonumber(string.match(left, "%d+"))
					elseif string.find(left, TEXT("SYS_TOOLTIP_RUNE_LEVEL")) == 1 then
						listing.tier = tonumber(string.match(left, "%d+"))
					elseif string.find(left, TEXT("SYS_ITEM_COST")) == 1 then
						left = string.gsub(left, COMMA, "")
						listing.worth = tonumber(string.match(left, "%d+"))
					elseif string.find(left, TEXT("SYS_WEAPON_DMG")) == 1 then
						listing.pdam = listing.pdam + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, TEXT("SYS_WEAPON_MDMG")) == 1 then
						listing.mdam = listing.mdam + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, TEXT("SYS_ARMOR_DEF")) == 1 then
						listing.pdef = listing.pdef + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_3")) == 1 then
						listing.sta = listing.sta + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_2")) == 1 then
						listing.str = listing.str + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_6")) == 1 then
						listing.dex = listing.dex + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_5")) == 1 then
						listing.wis = listing.wis + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_4")) == 1 then
						listing.int = listing.int + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_13")) == 1 then
						listing.pdef = listing.pdef + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_14")) == 1 then
						listing.mdef = listing.mdef + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_12")) == 1 then
						listing.patt = listing.patt + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_15")) == 1 then
						listing.matt = listing.matt + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_8")) == 1 then
						listing.hp = listing.hp + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_9")) == 1 then
						listing.mp = listing.mp + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_18")) == 1 then
						listing.pcrit = listing.pcrit + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_20")) == 1 then
						listing.mcrit = listing.mcrit + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_16")) == 1 then
						listing.pacc = listing.pacc + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_195")) == 1 then
						listing.macc = listing.macc + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_17")) == 1 then
						listing.pdod = listing.pdod + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_150")) == 1 then
						listing.heal = listing.heal + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_22")) == 1 then
						listing.parry = listing.parry + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_25")) == 1 then
						listing.pdam = listing.pdam + tonumber(string.match(left, "[%d+%.?]+"))
					elseif string.find(left, "%+[%d+%.?]+ "..TEXT("SYS_WEAREQTYPE_191")) == 1 then
						listing.mdam = listing.mdam + tonumber(string.match(left, "[%d+%.?]+"))
					end
				end
				right = getglobal("AAH_TooltipTextRight"..i):GetText()
				if right and right ~= "" and rightVis then
					right = string.gsub(right, "|c%x%x%x%x%x%x%x%x", "")
					right = string.gsub(right, "|r", "")
					--right = string.gsub(right, COMMA, "")
					if string.find(right, TEXT("SYS_WEAPON_ATKSPEED")) == 1 then
						listing.speed = tonumber(string.match(right, "[%d+%.?]+"))
					elseif string.find(right, TEXT("SYS_ARMOR_MDEF")) == 1 then
						listing.mdef = tonumber(string.match(right, "[%d+%.?]+"))
					elseif string.find(right, TEXT("SYS_ITEM_DURABLE")) == 1 then
						right = string.gsub(right, TEXT("SYS_ITEM_DURABLE").." %d+/", "")
						listing.dura = tonumber(string.match(right, "%d+"))
					end
				end
			end
			if listing.mdam > 0 then
				listing.heal = listing.heal + (listing.mdam * 0.5)
			end
			if listing.speed > 0 and listing.pdam > 0 then
				listing.dps = listing.pdam / listing.speed
			end
			local class = UnitClass("player")
			if AAHVar.StatValues[class] then
				for stat, t in pairs(AAHVar.StatValues[class]) do
					for attribute, value in pairs(t) do
						listing[attribute] = listing[attribute] + (listing[stat] * value)
					end
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("ERROR: please report you language and class to the AAH Forums")
			end
			if AAHFunc.FiltersCheckFilter(listing) == true then
				table.insert(AuctionBrowseList.list, listing)
				AAHVar.Browse_SortMode = 0
				AAHFunc.BrowseClearSortIcons()
				AuctionBrowseList.sortIndex = 0
			end
		end
	end
end

function AAHFunc.BrowseInfoLabelUpdate()
	local scanPercent = math.ceil(100 / AAHVar.MaxBrowsePages * AAHVar.LastCached)
	local filterPercentPerPage = 100 / AAHVar.MaxBrowsePages
	local filterPercentPerItem = filterPercentPerPage / 50
	local filterPercent = math.ceil((filterPercentPerPage * (AAHVar.CurrentFilterPage - 1)) + (filterPercentPerItem * AAHVar.CurrentFilterItem))
	if (filterPercent > scanPercent) then
		filterPercent = scanPercent
	end
	local labeltext = AAHLocale.Messages.BROWSE_INFO_LABEL
	labeltext = labeltext:gsub("<MAXITEMS>", GetAuctionBrowseMaxItems())
	labeltext = labeltext:gsub("<SCANPERCENT>", scanPercent)
	labeltext = labeltext:gsub("<FILTEREDITEMS>", #(AuctionBrowseList.list))
	labeltext = labeltext:gsub("<FILTERPERCENT>", filterPercent)
	AAH_BrowseInfoLabel:SetText(labeltext)
end

function AAHFunc.BrowseList_UpdateItems()
	local index = AAH_BrowseListScrollBar:GetValue() + 1
	local button, buttonName
	local info, r, g, b, white
	local bidPPU, buyPPU
	local fixedName
	for i = 1, AAHVar.Browse_ItemMaxDisplay do
		button = getglobal("AAH_BrowseListItem"..i)
		info = AuctionBrowseList.list[index]
		if info then
			button.index = index
			buttonName = button:GetName()
			fixedName = info.name
			r, g, b = GetItemQualityColor(info.rarity)
			getglobal(buttonName.."Name"):SetText(info.name)
			getglobal(buttonName.."Name"):SetColor(r, g, b)
			for k = 1, 2 do
				if not info[AAHVar["Browse_HeaderCustom"..k]] or info[AAHVar["Browse_HeaderCustom"..k]] == 0 or info[AAHVar["Browse_HeaderCustom"..k]] == "" then
					getglobal(buttonName.."Custom"..k):SetText("")
				elseif AAHVar["Browse_HeaderCustom"..k] == "level" then
					getglobal(buttonName.."Custom"..k):SetText(info.levelcolor..info.level.."|r")
				else
					getglobal(buttonName.."Custom"..k):SetText(tonumber(string.format("%.2f", info[AAHVar["Browse_HeaderCustom"..k]])))
				end
			end
			getglobal(buttonName.."LeftTime"):SetText(AAHFunc.ToolsLocalizedTimeString(info.leftTime))
			getglobal(buttonName.."Seller"):SetText(info.seller)
			getglobal(buttonName.."PPUBid"):SetText("")
			getglobal(buttonName.."PPUBuy"):SetText("")
			white = AAHFunc.ToolsGetWhiteValue(info.name)
			bidPPU = AAHFunc.ToolsDynamicDecimalPlaces((info.bidPrice / info.count) / white)
			buyPPU = AAHFunc.ToolsDynamicDecimalPlaces((info.buyoutPrice / info.count) / white)
			if info.count > 0 and info.bidPrice > 0 then
				getglobal(buttonName.."PPUBid"):SetText(AAHFunc.ToolsNumberWithCommas(bidPPU))
				if info.buyoutPrice > 0 then
					getglobal(buttonName.."PPUBuy"):SetText(AAHFunc.ToolsNumberWithCommas(buyPPU))
				else
					getglobal(buttonName.."PPUBuy"):SetText("")
				end
			end
			getglobal(buttonName.."PPUBid"):SetColor(1,1,1)
			getglobal(buttonName.."PPUBuy"):SetColor(1,1,1)
			if AAH_SavedHistoryTable[info.itemid] and AAH_SavedHistoryTable[info.itemid].avg then
				AAHFunc.ToolsAveragePriceColoring(info.bidPrice / info.count, AAH_SavedHistoryTable[info.itemid].avg, buttonName.."PPUBid")
				AAHFunc.ToolsAveragePriceColoring(info.buyoutPrice / info.count, AAH_SavedHistoryTable[info.itemid].avg, buttonName.."PPUBuy")
			end
			SetItemButtonCount(getglobal(buttonName.."Icon"), info.count)
			SetItemButtonTexture(getglobal(buttonName.."Icon"), info.texture)
			MoneyFrame_Update(buttonName.."BidMoney", info.bidPrice, "copper")
			if info.isBuyer then
				getglobal(buttonName.."BidMoneyText"):SetText(TEXT("AUCTION_SELF_BID"))
			else
				getglobal(buttonName.."BidMoneyText"):SetText("")
			end
			if info.buyoutPrice > 0 then
				getglobal(buttonName.."BuyoutMoney"):Show()
				MoneyFrame_Update(buttonName.."BuyoutMoney", info.buyoutPrice, "copper")
			else
				getglobal(buttonName.."BuyoutMoney"):Hide()
			end
			button:Show()
		else
			button:Hide()
		end
		index = index + 1
	end
	AAHFunc.BrowseList_SetSelected(AuctionBrowseList.selected)
end

function AAHFunc.BrowseList_SetSelected(auctionid)
	AAH_BrowseBidButton:Disable()
	AAH_BrowseBuyoutButton:Disable()
	AAH_BrowseHistoryButton:Disable()
	AuctionBrowseList.selected = auctionid
	local button, info
	for i = 1, AAHVar.Browse_ItemMaxDisplay do
		button = getglobal("AAH_BrowseListItem"..i)
		info = AuctionBrowseList.list[button.index]
		if info and button.index == auctionid then
			MoneyInputFrame_SetMode(AAH_BrowseBidMoneyInput, "copper")
			MoneyInputFrame_SetCopper(AAH_BrowseBidMoneyInput, AAHFunc.ToolsGetRationalBidPrices(info.bidPrice))
			if not info.isBuyer then
				AAH_BrowseBidButton:Enable()
			end
			if info.buyoutPrice > 0 then
				AAH_BrowseBuyoutButton:Enable()
			end
			AAH_BrowseHistoryButton:Enable()
			button:LockHighlight()
		else
			button:UnlockHighlight()
		end
	end
end

function AAHFunc.BrowseSavedSearchExpandButton_OnClick(action)
	if action == "Expand" then
		AAH_BrowseSavedSearchExpandButton:Hide()
		AAH_BrowseSavedSearchMinimizeButton:Show()
		AAH_BrowseSavedSearchPlusButton:Enable()
		AAH_BrowseSavedSearch:Show()
	elseif action == "Minimize" then
		AAH_BrowseSavedSearchExpandButton:Show()
		AAH_BrowseSavedSearchMinimizeButton:Hide()
		AAH_BrowseSavedSearchPlusButton:Disable()
		AAH_BrowseSavedSearch:Hide()
	end
end

function AAHFunc.BrowseSavedSearchScrollBar_Update()
	local maxValue = #(AAH_SavedSearch)
	if AAHVar.Browse_SavedSearchExpand[1] then
		maxValue = maxValue + #(AAH_SavedSearch[AAHVar.Browse_SavedSearchExpand[1]]["contents"])
		if AAHVar.Browse_SavedSearchExpand[2] then
			maxValue = maxValue + #(AAHVar.Browse_SavedSearchOptions)
		end
	end
	maxValue = maxValue - ((AAHVar.Browse_ItemMaxDisplay * 2) + 5)
	if maxValue > 0 then
		AAH_BrowseSavedSearchScrollBar:Show()
		AAH_BrowseSavedSearchScrollBar:SetMinMaxValues(0, maxValue)
	else
		AAH_BrowseSavedSearchScrollBar:Hide()
		AAH_BrowseSavedSearchScrollBar:SetMinMaxValues(0, 0)
	end
	AAHFunc.BrowseSavedSearch_UpdateList()
end

function AAHFunc.BrowseSavedSearch_UpdateList()
	local layer = 1
	local index = 1
	local text
	local folder = 1
	local item = 0
	local option = 0
	local count = 1
	local scroll = AAH_BrowseSavedSearchScrollBar:GetValue()
	while AAH_SavedSearch[folder] do
		if count > (AAHVar.Browse_ItemMaxDisplay * 2) + 6 then
			return
		end
		if scroll > 0 then
			scroll = scroll - 1
		else
			local button = getglobal("AAH_BrowseSavedSearchButton"..count)
			local normalText = getglobal(button:GetName().."NormalText")
			local highlightText = getglobal(button:GetName().."HighlightText")
			local lineTexture = getglobal(button:GetName().."Line")
			local backgoundTexture = getglobal(button:GetName().."Backgound")
			local width = button:GetWidth()
			if option > 0 then
				layer = 3
				index = option
				text = AAHVar.Browse_SavedSearchOptions[index]
			elseif item > 0 then
				layer = 2
				index = item
				text = AAH_SavedSearch[folder]["contents"][item]["name"]
			else
				layer = 1
				index = folder
				text = AAH_SavedSearch[folder]["name"]
			end
			button.layer = layer
			button.index = index
			if layer == 1 then
				backgoundTexture:Show()
				backgoundTexture:SetAlpha(1.0)
				lineTexture:Hide()
				normalText:ClearAllAnchors()
				normalText:SetAnchor("LEFT", "LEFT", button:GetName(), 10, 0)
				normalText:SetWidth(width - 20)
				normalText:SetColor(1, 1, 0)
				highlightText:ClearAllAnchors()
				highlightText:SetAnchor("LEFT", "LEFT", button:GetName(), 10, 0)
				highlightText:SetWidth(width - 20)
				highlightText:SetColor(1, 1, 0)
			elseif layer == 2 then
				backgoundTexture:Show()
				backgoundTexture:SetAlpha(0.5)
				lineTexture:Hide()
				normalText:ClearAllAnchors()
				normalText:SetAnchor("LEFT", "LEFT", button:GetName(), 15, 0)
				normalText:SetWidth(width - 25)
				normalText:SetColor(1, 1, 1)
				highlightText:ClearAllAnchors()
				highlightText:SetAnchor("LEFT", "LEFT", button:GetName(), 15, 0)
				highlightText:SetWidth(width - 25)
				highlightText:SetColor(1, 1, 1)
			else
				backgoundTexture:Hide()
				lineTexture:Show()
				if index == #(AAHVar.Browse_SavedSearchOptions) then
					lineTexture:SetTexCoord(0, 1, 0.5, 0.8125)
				else
					lineTexture:SetTexCoord(0, 1, 0, 0.3125)
				end
				normalText:ClearAllAnchors()
				normalText:SetAnchor("LEFT", "LEFT", button:GetName(), 20, 0)
				normalText:SetWidth(width - 30)
				normalText:SetColor(1, 1, 1)
				highlightText:ClearAllAnchors()
				highlightText:SetAnchor("LEFT", "LEFT", button:GetName(), 20, 0)
				highlightText:SetWidth(width - 30)
				highlightText:SetColor(1, 1, 1)
			end
			button:SetText(text)
			if AAHVar.Browse_SavedSearchExpand[layer] == index then
				button:LockHighlight()
			else
				button:UnlockHighlight()
			end
			button:Show()
			count = count + 1
		end
		if option > 0 then
			if option == #(AAHVar.Browse_SavedSearchOptions) then
				option = 0
				if item == #(AAH_SavedSearch[folder]["contents"]) then
					item = 0
					folder = folder + 1
				else
					item = item + 1
				end
			else
				option = option + 1
			end
		elseif item > 0 then
			if item == AAHVar.Browse_SavedSearchExpand[2] then
				option = 1
			elseif item == #(AAH_SavedSearch[folder]["contents"]) then
				item = 0
				folder = folder + 1
			else
				item = item + 1
			end
		elseif folder == AAHVar.Browse_SavedSearchExpand[1] then
			item = 1
		else
			folder = folder + 1
		end
	end
	for i = count, (AAHVar.Browse_ItemMaxDisplay * 2) + 6 do
		getglobal("AAH_BrowseSavedSearchButton"..i):Hide()
	end
end

function AAHFunc.BrowseSavedSearchButton_OnClick(this, key)
	for index, value in pairs(AAHVar.Browse_SavedSearchExpand) do
		if index > this.layer then
			AAHVar.Browse_SavedSearchExpand[index] = nil
		end
	end
	if this.layer == 3 then
		if key == "LBUTTON" then
			if this.index == 1 then
				AAHFunc.BrowseSavedSearch_Search(AAHVar.Browse_SavedSearchExpand[1], AAHVar.Browse_SavedSearchExpand[2])
			elseif this.index == 2 then
				AAHVar.Browse_SavedSearchRenameItem = AAHVar.Browse_SavedSearchExpand
				StaticPopup_Show("SAVEDSEARCH_RENAMEITEM")
			elseif this.index == 3 then
				table.remove(AAH_SavedSearch[AAHVar.Browse_SavedSearchExpand[1]]["contents"], AAHVar.Browse_SavedSearchExpand[2])
				AAHVar.Browse_SavedSearchExpand[2] = nil
				if #(AAH_SavedSearch[AAHVar.Browse_SavedSearchExpand[1]]["contents"]) == 0 then
					AAHFunc.BrowseSavedSearchRemoveFolder(AAHVar.Browse_SavedSearchExpand[1], nil)
				end
			end
		elseif key == "RBUTTON" then
			--???
		end
	elseif this.layer == 2 then
		if key == "LBUTTON" then
			if AAHVar.Browse_SavedSearchExpand[2] == this.index then
				AAHVar.Browse_SavedSearchExpand[2] = nil
				--Make Double Click Search
			else
				AAHVar.Browse_SavedSearchExpand[this.layer] = this.index
			end
		elseif key == "RBUTTON" then
			--When Double Click Searches, then this expands
		end
	elseif this.layer == 1 then
		if key == "LBUTTON" then
			if AAHVar.Browse_SavedSearchExpand[1] == this.index then
				AAHVar.Browse_SavedSearchExpand[this.layer] = nil
			else
				AAHVar.Browse_SavedSearchExpand[this.layer] = this.index
			end
		elseif key == "RBUTTON" then
			--Find way to have folder options
		end
	end
	AAHFunc.BrowseSavedSearchScrollBar_Update()
end

function AAHFunc.BrowseSavedSearchButton_OnDragStart(this)
	AAHVar.Browse_SavedSearchDragDrop = {}
	if this.layer == 1 then
		AAHVar.Browse_SavedSearchDragDrop["folder"] = this.index
	elseif this.layer == 2 then
		AAHVar.Browse_SavedSearchDragDrop["folder"] = AAHVar.Browse_SavedSearchExpand[1]
		AAHVar.Browse_SavedSearchDragDrop["item"] = this.index
	end
end

function AAHFunc.BrowseSavedSearchButton_OnReceiveDrag(this)
	local temptable = {}
	local offset = 0
	if AAHVar.Browse_SavedSearchDragDrop["folder"] and this.layer ~= 3 then
		if AAHVar.Browse_SavedSearchDragDrop["item"] then
			if this.layer == 2 then
				table.insert(AAH_SavedSearch[AAHVar.Browse_SavedSearchExpand[1]]["contents"], this.index, AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]]["contents"][AAHVar.Browse_SavedSearchDragDrop["item"]])
				if this.index < AAHVar.Browse_SavedSearchDragDrop["item"] then
					offset = 1
				end
				table.remove(AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]]["contents"], AAHVar.Browse_SavedSearchDragDrop["item"] + offset)
			elseif this.layer == 1 then
				table.insert(AAH_SavedSearch[this.index]["contents"], AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]]["contents"][AAHVar.Browse_SavedSearchDragDrop["item"]])
				table.remove(AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]]["contents"], AAHVar.Browse_SavedSearchDragDrop["item"])
				if #(AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]]["contents"]) == 0 then
					AAHFunc.BrowseSavedSearchRemoveFolder(AAHVar.Browse_SavedSearchDragDrop["folder"], this.index)
				else
					AAHVar.Browse_SavedSearchExpand[1] = this.index
				end
			end
			AAHVar.Browse_SavedSearchExpand[2] = nil
		elseif this.layer == 1 then
			table.insert(AAH_SavedSearch, this.index, AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]])
			if this.index < AAHVar.Browse_SavedSearchDragDrop["folder"] then
				offset = 1
			end
			table.remove(AAH_SavedSearch, AAHVar.Browse_SavedSearchDragDrop["folder"] + offset)
			AAHVar.Browse_SavedSearchExpand = {}
		elseif not this.layer then
			table.insert(AAH_SavedSearch, AAH_SavedSearch[AAHVar.Browse_SavedSearchDragDrop["folder"]])
			table.remove(AAH_SavedSearch, AAHVar.Browse_SavedSearchDragDrop["folder"])
			AAHVar.Browse_SavedSearchExpand = {}
		end
	end
	AAHFunc.BrowseSavedSearchScrollBar_Update()
end

function AAHFunc.BrowseSavedSearch_CreateItem(itemname)
	local temp = {}
	temp.name = itemname
	temp.data = {}
	temp.data.Keyword = AAH_BrowseNameEditBox:GetText()
	temp.data.MinLvl = AAH_BrowseMinLvlEditBox:GetText()
	temp.data.MaxLvl = AAH_BrowseMaxLvlEditBox:GetText()
	temp.data.Rarity = UIDropDownMenu_GetSelectedID(AAH_BrowseRarityDropDown)
	temp.data.Rune = UIDropDownMenu_GetSelectedID(AAH_BrowseRuneDropDown)
	temp.data.Usable = AAH_BrowseUsableButton:IsChecked()
	temp.data.Category1 = AAHVar.Browse_CategoryExpand[1]
	temp.data.Category2 = AAHVar.Browse_CategoryExpand[2]
	temp.data.Category3 = AAHVar.Browse_CategoryExpand[3]
	temp.data.PPU = AAH_BrowseFilterPPUButton:IsChecked()
	temp.data.Bid = AAH_BrowseFilterBidButton:IsChecked()
	temp.data.MinPrice = AAH_BrowseFilterMinPriceEditBox:GetText()
	temp.data.MaxPrice = AAH_BrowseFilterMaxPriceEditBox:GetText()
	temp.data.Filter1 = AAH_BrowseFilter1EditBox:GetText()
	temp.data.Filter2 = AAH_BrowseFilter2EditBox:GetText()
	temp.data.Filter3 = AAH_BrowseFilter3EditBox:GetText()
	temp.data.Or2 = AAH_BrowseFilter2OrButton:IsChecked()
	temp.data.Or3 = AAH_BrowseFilter3OrButton:IsChecked()
	if AAHVar.Browse_SavedSearchExpand[1] then
		AAHVar.Browse_SavedSearchExpand[2] = nil
		AAHVar.Browse_SavedSearchExpand[3] = nil
		table.insert(AAH_SavedSearch[AAHVar.Browse_SavedSearchExpand[1]]["contents"], temp)
		AAHFunc.BrowseSavedSearchScrollBar_Update()
	else
		AAHVar.Browse_SavedSearchNewItem = temp
		StaticPopup_Show("SAVEDSEARCH_CREATEFOLDER")
	end
end

function AAHFunc.BrowseSavedSearch_Search(folder, item)
	local temp = AAH_SavedSearch[folder]["contents"][item]["data"]
	AAH_BrowseNameEditBox:SetText(temp.Keyword)
	AAH_BrowseMinLvlEditBox:SetText(temp.MinLvl)
	AAH_BrowseMaxLvlEditBox:SetText(temp.MaxLvl)
	AAHFunc.ToolsSetDropDown(AAH_BrowseRarityDropDown, temp.Rarity, AAHVar.Browse_RarityInfo[temp.Rarity], {GetItemQualityColor(temp.Rarity - 1)})
	AAHFunc.ToolsSetDropDown(AAH_BrowseRuneDropDown, temp.Rune, AAHVar.Browse_RuneInfo[temp.Rune])
	AAH_BrowseUsableButton:SetChecked(temp.Usable)
	AAHVar.Browse_CategoryExpand[1] = temp.Category1
	AAHVar.Browse_CategoryExpand[2] = temp.Category2
	AAHVar.Browse_CategoryExpand[3] = temp.Category3
	AAH_BrowseFilterPPUButton:SetChecked(temp.PPU)
	AAH_BrowseFilterBidButton:SetChecked(temp.Bid)
	AAH_BrowseFilterMinPriceEditBox:SetText(temp.MinPrice)
	AAH_BrowseFilterMaxPriceEditBox:SetText(temp.MaxPrice)
	AAH_BrowseFilter1EditBox:SetText(temp.Filter1)
	AAH_BrowseFilter2EditBox:SetText(temp.Filter2)
	AAH_BrowseFilter3EditBox:SetText(temp.Filter3)
	AAH_BrowseFilter2OrButton:SetChecked(temp.Or2)
	AAH_BrowseFilter3OrButton:SetChecked(temp.Or3)
	AAHFunc.BrowseCategoryScrollBar_Update()
	AAHFunc.BrowseSearchButton_OnClick()
end

function AAHFunc.BrowseSavedSearchRemoveFolder(folder, expand)
	if expand and expand > folder then
		expand = expand - 1
	end
	table.remove(AAH_SavedSearch, folder)
	AAHVar.Browse_SavedSearchExpand[1] = expand
end