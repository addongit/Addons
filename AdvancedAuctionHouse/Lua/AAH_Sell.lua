function AAHFunc.SellFrame_OnLoad(this)
--@non-alpha@
	AAH_SellItemBrowse:Hide()
--@end-non-alpha@
	AAH_SellAutoPriceLabel:SetText(AAHLocale.Messages.SELL_AUTO_PRICE_HEADER)
	AAH_SellAutoFillPercentBidLabel:SetText(AAHLocale.Messages.SELL_PERCENT)
	AAH_SellAutoFillPercentBuyoutLabel:SetText(AAHLocale.Messages.SELL_PERCENT)
	AAH_SellPriceBidLabel:SetText(TEXT("AUCTION_FIRST_PRICE_COLON"))
	AAH_SellPriceBidPPULabel:SetText(AAHLocale.Messages.SELL_PER_UNIT .. ": ")
	AAH_SellPriceBuyoutLabel:SetText(TEXT("AUCTION_BUYOUT_PRICE_COLON"))
	AAH_SellPriceBuyoutPPULabel:SetText(AAHLocale.Messages.SELL_PER_UNIT .. ": ")
	UIDropDownMenu_SetWidth(AAH_SellAutoFillBidDropDown, 70)
	UIDropDownMenu_SetWidth(AAH_SellAutoFillBuyoutDropDown, 70)
end

function AAHFunc.SellClearItem()
	if GetAuctionItem() then
		ClickAuctionItemButton()
		PickupBagItem(GetCursorItemInfo())
	end
end

function AAHFunc.SellListHeader_OnClick(this)
	local id = this:GetID()
	AAHFunc.SellClearSortIcons()
	if AuctionSellList.sortIndex == id or AuctionSellList.sortIndex == -id then
		AAHVar.Sell_SortMode = (AAHVar.Sell_SortMode + 1) % 4
	else
		AAHVar.Sell_SortMode = 0
	end
	if id == 6 then
		if AAHVar.Sell_SortMode == 0 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_up")
		elseif AAHVar.Sell_SortMode == 1 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_down")
		elseif AAHVar.Sell_SortMode == 2 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\hollow_arrow_up")
		elseif AAHVar.Sell_SortMode == 3 then
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\hollow_arrow_down")
		end
	else
		if AuctionSellList.sortIndex == id then
			id = -id
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_down")
		else
			getglobal(this:GetName() .. "SortIcon"):SetFile("Interface\\AddOns\\AdvancedAuctionhouse\\Textures\\full_arrow_up")
		end
	end
	AAHFunc.SellList_Sort(id)
end

function AAHFunc.SellClearSortIcons()
	AAH_SellHeaderNameSortIcon:SetFile("")
	AAH_SellHeaderLevelSortIcon:SetFile("")
	AAH_SellHeaderLeftTimeSortIcon:SetFile("")
	AAH_SellHeaderBuyerSortIcon:SetFile("")
	AAH_SellHeaderPriceSortIcon:SetFile("")
end

function AAHFunc.SellList_Sort(index)
	AuctionSellList.sortIndex = index
	if math.abs(index) == 6 then
		if AAHVar.Sell_SortMode == 0 then
			table.sort(AuctionSellList.list, AAHFunc.ToolsSortBidLess)
		elseif AAHVar.Sell_SortMode == 1 then
			table.sort(AuctionSellList.list, AAHFunc.ToolsSortBidMore)
		elseif AAHVar.Sell_SortMode == 2 then
			table.sort(AuctionSellList.list, AAHFunc.ToolsSortBuyoutLess)
		elseif AAHVar.Sell_SortMode == 3 then
			table.sort(AuctionSellList.list, AAHFunc.ToolsSortBuyoutMore)
		end
	else
		if index == 1 or index == -1 then
			AAHVar.Auction_HeaderSortItem = "name"
		elseif index == 2 or index == -2 then
			AAHVar.Auction_HeaderSortItem = "level"
		elseif index == 3 or index == -3 then
			AAHVar.Auction_HeaderSortItem = "leftTime"
		elseif index == 4 or index == -4 then
			AAHVar.Auction_HeaderSortItem = "bidder"
		elseif index == 5 or index == -5 then
			AAHVar.Auction_HeaderSortItem = "status"
		end
		if AuctionSellList.sortIndex > 0 then
			table.sort(AuctionSellList.list, AAHFunc.ToolsSortLess)
		else
			table.sort(AuctionSellList.list, AAHFunc.ToolsSortMore)
		end
	end
	AAHFunc.SellList_UpdateItems()
end

function AAHFunc.SellAutoFillBidDropDown_Show()
	local buttonInfo
	for i = 1, 4 do
		buttonInfo = {}
		buttonInfo.text = AAHVar.Sell_AutoFillInfo[i]
		buttonInfo.func = AAHFunc.SellAutoFillBidDropDown_Click
		UIDropDownMenu_AddButton(buttonInfo)
	end
end

function AAHFunc.SellAutoFillBidDropDown_Click(button)
	AAHFunc.ToolsSetDropDown(AAH_SellAutoFillBidDropDown, button:GetID(), button:GetText())
	AAH_SavedSettings.AutoFillBidSelected = button:GetID()
	AAHFunc.SellAutoFillBidEditBox_CheckVisibility()
	AAHFunc.SellAutoFillPriceFields()
end

function AAHFunc.SellAutoFillBidEditBox_CheckVisibility()
	if UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBidDropDown) == 3 then
		AAH_SellAutoFillPercentBid:Show()
		AAH_SellAutoFillFormulaBid:Hide()
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBidDropDown) == 4 then
		AAH_SellAutoFillPercentBid:Hide()
		AAH_SellAutoFillFormulaBid:Show()
	else
		AAH_SellAutoFillPercentBid:Hide()
		AAH_SellAutoFillFormulaBid:Hide()
	end
end

function AAHFunc.SellAutoFillBuyoutDropDown_Show()
	local buttonInfo
	for i = 1, 4 do
		buttonInfo = {}
		buttonInfo.text = AAHVar.Sell_AutoFillInfo[i]
		buttonInfo.func = AAHFunc.SellAutoFillBuyoutDropDown_Click
		UIDropDownMenu_AddButton(buttonInfo)
	end
end

function AAHFunc.SellAutoFillBuyoutDropDown_Click(button)
	AAHFunc.ToolsSetDropDown(AAH_SellAutoFillBuyoutDropDown, button:GetID(), button:GetText())
	AAH_SavedSettings.AutoFillBuyoutSelected = button:GetID()
	AAHFunc.SellAutoFillBuyoutEditBox_CheckVisibility()
	AAHFunc.SellAutoFillPriceFields()
end

function AAHFunc.SellAutoFillBuyoutEditBox_CheckVisibility()
	if UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBuyoutDropDown) == 3 then
		AAH_SellAutoFillPercentBuyout:Show()
		AAH_SellAutoFillFormulaBuyoutout:Hide()
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBuyoutDropDown) == 4 then
		AAH_SellAutoFillPercentBuyout:Hide()
		AAH_SellAutoFillFormulaBuyoutout:Show()
	else
		AAH_SellAutoFillPercentBuyout:Hide()
		AAH_SellAutoFillFormulaBuyoutout:Hide()
	end
end

function AAHFunc.SellItem_Update()
	local name, itemTexture, stackCount, itemPrice = GetAuctionItem()
	if stackCount and stackCount <= 1 then
		stackCount = ""
	end
	AAH_SellPlaceItemButtonName:SetText(name)
	AAH_SellPlaceItemButtonTexture:SetTexture(itemTexture)
	AAH_SellPlaceItemButtonCount:SetText(stackCount)
	MoneyInputFrame_ResetMoney(AAH_SellPriceBid)
	MoneyInputFrame_ResetMoney(AAH_SellPriceBuyout)
	if name then
		AAHVar.AutoPriceHistoryTrigger = true
		AuctionItemHistoryRequest()
		AAHFunc.SellFeeFrame_Update()
		AAH_SellHistoryButton:Enable()
	else
		MoneyFrame_Update("AAH_SellFeeFrame", 0)
		AAH_SellHistoryButton:Disable()
	end
	AAHFunc.SellFrame_CanCreate()
end

function AAHFunc.SellFeeFrame_Update()
	local name, texture, stackCount, price = GetAuctionItem()
	if not name then
		return
	end
	local duration = 0
	if AAH_SavedSettings.SellDurationSelected == 1 then
		duration = 12
	elseif AAH_SavedSettings.SellDurationSelected == 2 then
		duration = 24
	elseif AAH_SavedSettings.SellDurationSelected == 3 then
		duration = 48
	elseif AAH_SavedSettings.SellDurationSelected == 4 then
		duration = 72
	end
	AAHVar.Sell_ItemFee = math.floor((duration / 4) * (price * stackCount * 0.006))
	MoneyFrame_Update("AAH_SellFeeFrame", AAHVar.Sell_ItemFee)
end

function AAHFunc.SellFrame_CanCreate()
	local bid = MoneyInputFrame_GetCopper(AAH_SellPriceBid)
	local buyout = MoneyInputFrame_GetCopper(AAH_SellPriceBuyout)
	if GetAuctionItem() and bid > 0 and (buyout <= 0 or buyout >= bid) then
		AAH_SellConfirmButton:Enable()
	else
		AAH_SellConfirmButton:Disable()
	end
end

function AAHFunc.SellConfirmButton_OnClick(this, key)
	local bid = MoneyInputFrame_GetCopper(AAH_SellPriceBid)
	local buyout = MoneyInputFrame_GetCopper(AAH_SellPriceBuyout)
	local name, itemTexture, stackCount, itemPrice = GetAuctionItem()
	local linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.HookItemLink)
	if AAHVar.Sell_ItemFee > GetPlayerMoney("copper") then
		StaticPopup_Show("AUCTIONCREATE_ALERT")
		return
	end
	if name == linkname then
		AAHFunc.SellUpdatePriceHistory(linkid, AAHFunc.ToolsDynamicDecimalPlaces(bid / stackCount), AAHFunc.ToolsDynamicDecimalPlaces(buyout / stackCount))
	end
	CreateAuctionItem(AAH_SavedSettings.SellDurationSelected, bid, 1, buyout)
	AAHFunc.SellList_Update()
end

function AAHFunc.SellList_Update()
	local name, count, rarity, texture, level, leftTime, bidder, bidPrice, buyoutPrice
	AuctionSellList.maxNums = GetAuctionNumSellItems()
	AuctionSellList.list = {}
	for i = 1, AuctionSellList.maxNums do
		name, count, rarity, texture, level, leftTime, bidder, _, bidPrice, buyoutPrice = GetAuctionSellItemInfo(i)
		AuctionSellList.list[i] = {}
		AuctionSellList.list[i].auctionid = i
		AuctionSellList.list[i].name = name
		AuctionSellList.list[i].count = count
		AuctionSellList.list[i].rarity = rarity
		AuctionSellList.list[i].texture = texture
		AuctionSellList.list[i].level = level
		AuctionSellList.list[i].leftTime = leftTime
		AuctionSellList.list[i].bidder = bidder
		AuctionSellList.list[i].bidPrice = bidPrice
		AuctionSellList.list[i].buyoutPrice = buyoutPrice
	end
	if AuctionSellList.sortIndex then
		AAHFunc.SellList_Sort(AuctionSellList.sortIndex)
	end
	-- Update ScrollBar
	local maxValue = AuctionSellList.maxNums - AAHVar.Sell_ItemMaxDisplay
	if maxValue > 0 then
		AAH_SellListScrollBar:SetMinMaxValues(0, maxValue)
		AAH_SellListScrollBar:Show()
	else
		AAH_SellListScrollBar:SetMinMaxValues(0, 0)
		AAH_SellListScrollBar:Hide()
	end
	AAHFunc.SellList_UpdateItems()
end

function AAHFunc.SellList_UpdateItems()
	local index = AAH_SellListScrollBar:GetValue() + 1
	local button, buttonName
	local info, r, g, b
	for i = 1, AAHVar.Sell_ItemMaxDisplay do
		button = getglobal("AAH_SellListItem"..i)
		info = AuctionSellList.list[index]
		if info then
			button.index = index
			buttonName = button:GetName()
			r, g, b = GetItemQualityColor(info.rarity)
			getglobal(buttonName.."Name"):SetText(info.name)
			getglobal(buttonName.."Name"):SetColor(r, g, b)
			getglobal(buttonName.."Level"):SetText(info.level)
			getglobal(buttonName.."LeftTime"):SetText(AAHFunc.ToolsLocalizedTimeString(info.leftTime))
			getglobal(buttonName.."Bidder"):SetText(info.bidder)
			SetItemButtonCount(getglobal(buttonName.."Icon"), info.count)
			SetItemButtonTexture(getglobal(buttonName.."Icon"), info.texture)
			MoneyFrame_Update(buttonName.."BidMoney", info.bidPrice, "copper")
			if info.buyoutPrice > 0 then
				MoneyFrame_Update(buttonName.."BuyoutMoney", info.buyoutPrice, "copper")
				getglobal(buttonName.."BuyoutMoney"):Show()
			else
				getglobal(buttonName.."BuyoutMoney"):Hide()
			end
			button:Show()
		else
			button:Hide()
		end
		index = index + 1
	end
	AAH_SellNumberLabel:SetText(AAHLocale.Messages.SELL_NUM_AUCTION)
	AAH_SellNumber:SetText(GetAuctionNumSellItems() .. "/30")
	AAHFunc.SellList_SetSelected(AuctionSellList.selected)
end

function AAHFunc.SellList_SetSelected(auctionid)
	AAH_SellListCancelButton:Disable()
	AuctionSellList.selected = auctionid
	local button, info
	for i = 1, AAHVar.Sell_ItemMaxDisplay do
		button = getglobal("AAH_SellListItem"..i)
		info = AuctionSellList.list[button.index]
		if info and button.index == auctionid then
			AAH_SellListCancelButton:Enable()
			button:LockHighlight()
		else
			button:UnlockHighlight()
		end
	end
end

function AAHFunc.SellDurationDropDown_Show()
	local info
	for i, v in pairs(AAHVar.Sell_DurationInfo) do
		info = {}
		info.text = v
		info.func = function(button)
			AAHFunc.ToolsSetDropDown(AAH_SellDurationDropDown, button:GetID(), button:GetText())
			AAH_SavedSettings.SellDurationSelected = button:GetID()
			AAHFunc.SellFeeFrame_Update()
		end
		UIDropDownMenu_AddButton(info)
	end
end

function AAHFunc.SellUpdatePriceHistory(itemid, bid, buyout)
	if not AAH_LastSellPrice[itemid] then
		AAH_LastSellPrice[itemid] = {}
	end
	AAH_LastSellPrice[itemid].bid = bid
	AAH_LastSellPrice[itemid].buyout = buyout
end

function AAHFunc.SellAutoFillPriceFields()
	local percent, formula, value
	local name, itemTexture, stackCount, itemPrice = GetAuctionItem()
	local white = AAHFunc.ToolsGetWhiteValue(name)
	local linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.HookItemLink)
	if not name or name == "" or linkname ~= name then
		AAH_SellHistoryButton:Disable()
		return
	end
	AAH_SellHistoryButton:Enable()
	if UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBidDropDown) == 1 then --none
		MoneyInputFrame_ResetMoney(AAH_SellPriceBid)
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBidDropDown) == 2 then --last
		if AAH_LastSellPrice[linkid] and AAH_LastSellPrice[linkid].bid then
			MoneyInputFrame_SetCopper(AAH_SellPriceBidPPU, AAH_LastSellPrice[linkid].bid / white)
		end
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBidDropDown) == 3 then --percent
		percent = AAH_SellAutoFillPercentBid:GetText()
		if percent == "" then
			percent = 100
		end
		percent = percent / 100
		if AAH_SavedHistoryTable[linkid] and AAH_SavedHistoryTable[linkid].avg then
			MoneyInputFrame_SetCopper(AAH_SellPriceBidPPU, (AAH_SavedHistoryTable[linkid].avg / white) * percent)
		end
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBidDropDown) == 4 then --formula
		formula = AAHFunc.ToolsLower(AAH_SellAutoFillFormulaBid:GetText())
		if AAH_SavedHistoryTable[linkid] and AAH_SavedHistoryTable[linkid].avg then
			formula = string.gsub(formula, "avg", AAH_SavedHistoryTable[linkid].avg / white)
			formula = string.gsub(formula, "min", AAH_SavedHistoryTable[linkid].min / white)
			formula = string.gsub(formula, "max", AAH_SavedHistoryTable[linkid].max / white)
			formula = string.gsub(formula, "median", AAH_SavedHistoryTable[linkid].median / white)
		end
		value = tonumber(AAHFunc.ToolsEvaluateString(formula))
		if value then
			MoneyInputFrame_SetCopper(AAH_SellPriceBidPPU, value)
			AAH_SavedSettings.FormulaBid = AAH_SellAutoFillFormulaBid:GetText()
		else
			MoneyInputFrame_ResetMoney(AAH_SellPriceBidPPU)
		end
	end
	if UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBuyoutDropDown) == 1 then --none
		MoneyInputFrame_ResetMoney(AAH_SellPriceBuyout)
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBuyoutDropDown) == 2 then --last
		if AAH_LastSellPrice[linkid] and AAH_LastSellPrice[linkid].buyout then
			MoneyInputFrame_SetCopper(AAH_SellPriceBuyoutPPU, AAH_LastSellPrice[linkid].buyout / white)
		end
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBuyoutDropDown) == 3 then --percent
		percent = AAH_SellAutoFillPercentBuyout:GetText()
		if percent == "" then
			percent = 100
		end
		percent = percent / 100
		if AAH_SavedHistoryTable[linkid] and AAH_SavedHistoryTable[linkid].avg then
			MoneyInputFrame_SetCopper(AAH_SellPriceBuyoutPPU, (AAH_SavedHistoryTable[linkid].avg / white) * percent)
		end
	elseif UIDropDownMenu_GetSelectedID(AAH_SellAutoFillBuyoutDropDown) == 4 then --formula
		formula = AAHFunc.ToolsLower(AAH_SellAutoFillFormulaBuyoutout:GetText())
		if AAH_SavedHistoryTable[linkid] and AAH_SavedHistoryTable[linkid].avg then
			formula = string.gsub(formula, "avg", AAH_SavedHistoryTable[linkid].avg / white)
			formula = string.gsub(formula, "min", AAH_SavedHistoryTable[linkid].min / white)
			formula = string.gsub(formula, "max", AAH_SavedHistoryTable[linkid].max / white)
			formula = string.gsub(formula, "median", AAH_SavedHistoryTable[linkid].median / white)
		end
		value = tonumber(AAHFunc.ToolsEvaluateString(formula))
		if value then
			MoneyInputFrame_SetCopper(AAH_SellPriceBuyoutPPU, value)
			AAH_SavedSettings.FormulaBuyout = AAH_SellAutoFillFormulaBuyoutout:GetText()
		else
			MoneyInputFrame_ResetMoney(AAH_SellPriceBuyoutPPU)
		end
	end
end

function AAHFunc.SellPriceInput_OnTextChange(box1, box2, ppuToFull)
	local name, itemTexture, stackCount, itemPrice = GetAuctionItem()
	local white = AAHFunc.ToolsGetWhiteValue(name)
	if not stackCount or stackCount < 1 then
		stackCount = 1
	end
	if not tonumber(box1:GetText()) and box1:GetText() ~= "" then
		box1:SetText(string.gsub(box1:GetText(), ",", "."))
		if not tonumber(box1:GetText()) then
			box1:SetText(box1.oldText)
		end
		box1:ClearFocus()
		box1:SetFocus()
	else
		box1.oldText = box1:GetText()
	end
	AAHVar.PriceInputChangeTrigger = false
	if ppuToFull then
		if tonumber(box1:GetText()) then
			box2:SetText(math.ceil(box1:GetText() * stackCount * white))
		else
			box2:SetText("")
		end
	else
		if tonumber(box1:GetText()) then
			box2:SetText(AAHFunc.ToolsDynamicDecimalPlaces((box1:GetText() / stackCount) / white))
		else
			box2:SetText("")
		end
	end
	box2.oldText = box2:GetText()
	AAHVar.PriceInputChangeTrigger = true
end
