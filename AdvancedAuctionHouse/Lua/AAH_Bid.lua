function AAHFunc.BidFrame_OnLoad(this)
	AAH_BidHeaderPPU:SetText(AAHLocale.Messages.GENERAL_PRICE_PER_UNIT_HEADER)
end

function AAHFunc.BidListHeader_OnClick(this)
	local id = this:GetID()
	AAHFunc.BidClearSortIcons()
	if AuctionBidList.sortIndex == id or AuctionBidList.sortIndex == -id then
		AAHVar.Bid_SortMode = (AAHVar.Bid_SortMode + 1) % 4
	else
		AAHVar.Bid_SortMode = 0
	end
	if id == 6 or id == 7 then
		if AAHVar.Bid_SortMode == 0 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_up")
		elseif AAHVar.Bid_SortMode == 1 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_down")
		elseif AAHVar.Bid_SortMode == 2 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\hollow_arrow_up")
		elseif AAHVar.Bid_SortMode == 3 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\hollow_arrow_down")
		end
	else
		if AuctionBidList.sortIndex == id then
			id = -id
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_down")
		else
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_up")
		end
	end
	AAHFunc.BidList_Sort(id)
end

function AAHFunc.BidClearSortIcons()
	AAH_BidHeaderNameSortIcon:SetFile("")
	AAH_BidHeaderLevelSortIcon:SetFile("")
	AAH_BidHeaderLeftTimeSortIcon:SetFile("")
	AAH_BidHeaderSellerSortIcon:SetFile("")
	AAH_BidHeaderStatusSortIcon:SetFile("")
	AAH_BidHeaderPPUSortIcon:SetFile("")
	AAH_BidHeaderPriceSortIcon:SetFile("")
end

function AAHFunc.BidList_Sort(index)
	AuctionBidList.sortIndex = index
	if math.abs(index) == 6 then
		if AAHVar.Bid_SortMode == 0 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBidLess)
		elseif AAHVar.Bid_SortMode == 1 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBidMore)
		elseif AAHVar.Bid_SortMode == 2 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBuyoutLess)
		elseif AAHVar.Bid_SortMode == 3 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBuyoutMore)
		end
	elseif math.abs(index) == 7 then
		if AAHVar.Bid_SortMode == 0 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBidPPULess)
		elseif AAHVar.Bid_SortMode == 1 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBidPPUMore)
		elseif AAHVar.Bid_SortMode == 2 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBuyoutPPULess)
		elseif AAHVar.Bid_SortMode == 3 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortBuyoutPPUMore)
		end
	else
		if index == 1 or index == -1 then
			AAHVar.Auction_HeaderSortItem = "name"
		elseif index == 2 or index == -2 then
			AAHVar.Auction_HeaderSortItem = "level"
		elseif index == 3 or index == -3 then
			AAHVar.Auction_HeaderSortItem = "leftTime"
		elseif index == 4 or index == -4 then
			AAHVar.Auction_HeaderSortItem = "seller"
		elseif index == 5 or index == -5 then
			AAHVar.Auction_HeaderSortItem = "status"
		end
		if AuctionBidList.sortIndex > 0 then
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortLess)
		else
			table.sort(AuctionBidList.list, AAHFunc.ToolsSortMore)
		end
	end
	AAHFunc.BidList_UpdateItems()
end

function AAHFunc.BidListBidButton_OnClick(this)
	local money = MoneyInputFrame_GetCopper(AAH_BidListBidMoneyInput)
	if money > GetPlayerMoney("copper") then
		StaticPopup_Show("BUYOUT_ALERT")
		return
	end
	local selected = AuctionBidList.selected
	if selected then
		AAHVar.Auction_BidMoney = money
		AuctionBidBuyItem(AuctionBidList.list[selected].auctionid, AAHVar.Auction_BidMoney)
	end
end

function AAHFunc.BidListBuyoutButton_OnClick(this)
	local selected = AuctionBidList.selected
	if selected then
		local buyoutPrice = AuctionBidList.list[selected].buyoutPrice
		local ItemName = AuctionBidList.list[selected].name
		if buyoutPrice > GetPlayerMoney("copper") then
			StaticPopup_Show("BUYOUT_ALERT")
		else
			StaticPopup_Show("BUYOUT_CONFIRMATION", ItemName)
		end
	end
end

function AAHFunc.BidList_Update()
	local name, count, rarity, texture, level, leftTime, seller, status, bidPrice, buyoutPrice
	AuctionBidList.maxNums = GetAuctionNumBidItems()
	AuctionBidList.list = {}
	for i = 1, AuctionBidList.maxNums do
		name, count, rarity, texture, level, leftTime, seller, status, _, bidPrice, buyoutPrice = GetAuctionBidItemInfo(i)
		AuctionBidList.list[i] = {}
		AuctionBidList.list[i].auctionid = i
		AuctionBidList.list[i].name = name
		AuctionBidList.list[i].rarity = rarity
		AuctionBidList.list[i].count = count
		AuctionBidList.list[i].texture = texture
		AuctionBidList.list[i].level = level
		AuctionBidList.list[i].leftTime = leftTime
		AuctionBidList.list[i].seller = seller
		AuctionBidList.list[i].status = status
		AuctionBidList.list[i].bidPrice = bidPrice
		AuctionBidList.list[i].buyoutPrice = buyoutPrice
	end
	if AuctionBidList.sortIndex then
		AAHFunc.BidList_Sort(AuctionBidList.sortIndex)
	end
	local maxValue = AuctionBidList.maxNums - AAHVar.Bid_ItemMaxDisplay
	if maxValue > 0 then
		AAH_BidListScrollBar:SetMinMaxValues(0, maxValue)
		AAH_BidListScrollBar:Show()
	else
		AAH_BidListScrollBar:SetMinMaxValues(0, 0)
		AAH_BidListScrollBar:Hide()
	end
	AAHFunc.BidList_UpdateItems()
end

function AAHFunc.BidList_UpdateItems()
	local value = AAH_BidListScrollBar:GetValue()
	local index = value + 1
	local button, buttonName
	local info, color, r, g, b, white
	local bidPPU, buyPPU
	local fixedName
	for i = 1, AAHVar.Bid_ItemMaxDisplay do
		button = getglobal("AAH_BidListItem"..i)
		info = AuctionBidList.list[index]
		if info then
			button.index = index
			buttonName = button:GetName()
			fixedName = info.name
			r, g, b = GetItemQualityColor(info.rarity)
			getglobal(buttonName.."Name"):SetText(info.name)
			getglobal(buttonName.."Name"):SetColor(r, g, b)
			getglobal(buttonName.."Level"):SetText(info.level)
			getglobal(buttonName.."LeftTime"):SetText(AAHFunc.ToolsLocalizedTimeString(info.leftTime))
			getglobal(buttonName.."Seller"):SetText(info.seller)
			getglobal(buttonName.."PPUBid"):SetText("")
			getglobal(buttonName.."PPUBuy"):SetText("")
			SetItemButtonCount(getglobal(buttonName.."Icon"), info.count)
			SetItemButtonTexture(getglobal(buttonName.."Icon"), info.texture)
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
			if AAH_SavedHistoryTable[fixedName] and AAH_SavedHistoryTable[fixedName].avg then
				AAHFunc.ToolsAveragePriceColoring(bidPPU, AAH_SavedHistoryTable[fixedName].avg, buttonName.."PPUBid")
				AAHFunc.ToolsAveragePriceColoring(buyPPU, AAH_SavedHistoryTable[fixedName].avg, buttonName.."PPUBuy")
			end
			if info.status then
				getglobal(buttonName.."Status"):SetText(AUCTION_HIGHEST_PRICE)
				getglobal(buttonName.."Status"):SetColor(0, 1, 0)
			else
				getglobal(buttonName.."Status"):SetText(AUCTION_BID_EXCEED)
				getglobal(buttonName.."Status"):SetColor(1, 0, 0)
			end
			MoneyFrame_Update(buttonName.."BidMoney", info.bidPrice, "copper")
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
	AAHFunc.BidList_SetSelected(AuctionBidList.selected)
end

function AAHFunc.BidList_SetSelected(auctionid)
	AAH_BidListBidButton:Disable()
	AAH_BidListBuyoutButton:Disable()
	AAH_BidListHistoryButton:Disable()
	AuctionBidList.selected = auctionid
	local button, info
	for i = 1, AAHVar.Bid_ItemMaxDisplay do
		button = getglobal("AAH_BidListItem"..i)
		info = AuctionBidList.list[button.index]
		if info and button.index == auctionid then
			MoneyInputFrame_SetMode(AAH_BidListBidMoneyInput, "copper")
			MoneyInputFrame_SetCopper(AAH_BidListBidMoneyInput, AAHFunc.ToolsGetRationalBidPrices(info.bidPrice))
			if not info.status then
				AAH_BidListBidButton:Enable()
			end
			if info.buyoutPrice > 0 then
				AAH_BidListBuyoutButton:Enable()
			end
			AAH_BidListHistoryButton:Enable()
			button:LockHighlight()
		else
			button:UnlockHighlight()
		end
	end
end
