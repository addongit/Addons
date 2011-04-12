function AAHFunc.HistoryProcessItemPriceHistory()
	local name, count, rarity, icon, seller, buyer, moneytype, price, month, day, hour, minute, failtemp
	local maxnums = GetAuctionHistoryItemNums()
	local startplace = 1
	local hash = ""
	local entry = {}
	name = GetAuctionHistoryItemInfo(1)
	local linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.BrowseItemLink)
	if linkname ~= name then
		if linkname then
			failtemp = linkname
		else
			failtemp = "nil"
		end
		linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.QueueItemLink)
		if linkname ~= name then
			if linkname then
				failtemp = failtemp.." or "..linkname
			else
				failtemp = failtemp.." or nil"
			end
			linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.HookItemLink)
		end
	end
	if linkname == name then
		if AAH_SavedHistoryTable[linkid] then
			for i = maxnums, 1, -1 do
				name, count, rarity, icon, seller, buyer, moneytype, price, month, day, hour, minute = GetAuctionHistoryItemInfo(i)
				hash = ""
				if name then hash = hash..name end
				if count then hash = hash..count end
				if seller then hash = hash..seller end
				if buyer then hash = hash..buyer end
				if moneytype then hash = hash..moneytype end
				if price then hash = hash..price end
				if month then hash = hash..month end
				if day then hash = hash..day end
				if hour then hash = hash..hour end
				if minute then hash = hash..minute end
				if hash == AAH_SavedHistoryTable[linkid].hash then
					startplace = i + 1
					break
				end
			end
		else
			AAH_SavedHistoryTable[linkid] = {}
			AAH_SavedHistoryTable[linkid].name = name
			AAH_SavedHistoryTable[linkid].totalcost = 0
			AAH_SavedHistoryTable[linkid].totalcount = 0
			AAH_SavedHistoryTable[linkid].avg = 0
			AAH_SavedHistoryTable[linkid].history = {}
		end
		for i = startplace, maxnums do
			name, count, rarity, icon, seller, buyer, moneytype, price, month, day, hour, minute = GetAuctionHistoryItemInfo(i)
			entry = {
				["rarity"] = rarity,
				["icon"] = icon,
				["count"] = count,
				["price"] = price,
				["ppu"] = AAHFunc.ToolsDynamicDecimalPlaces(price / count),
				["seller"] = seller,
				["buyer"] = buyer,
				["date"] = string.format("%02d/%02d %02d:%02d", month, day, hour, minute),
			}
			while #(AAH_SavedHistoryTable[linkid]["history"]) >= AAH_SavedSettings.HistoryMaxSaved do
				table.remove(AAH_SavedHistoryTable[linkid].history, AAH_SavedSettings.HistoryMaxSaved)
			end
			table.insert(AAH_SavedHistoryTable[linkid].history, 1, entry)
		end
		hash = ""
		if name then hash = hash..name end
		if count then hash = hash..count end
		if seller then hash = hash..seller end
		if buyer then hash = hash..buyer end
		if moneytype then hash = hash..moneytype end
		if price then hash = hash..price end
		if month then hash = hash..month end
		if day then hash = hash..day end
		if hour then hash = hash..hour end
		if minute then hash = hash..minute end
		AAH_SavedHistoryTable[linkid].hash = hash
		AAH_SavedHistoryTable[linkid].totalcost = 0
		AAH_SavedHistoryTable[linkid].totalcount = 0
		AAH_SavedHistoryTable[linkid].avg = 0
		AAH_SavedHistoryTable[linkid].median = 0
		AAH_SavedHistoryTable[linkid].min = 999999999999
		AAH_SavedHistoryTable[linkid].max = 0
		entry = {}
		for i = 1, #(AAH_SavedHistoryTable[linkid]["history"]) do
			if AAH_SavedHistoryTable[linkid].min > AAH_SavedHistoryTable[linkid]["history"][i].ppu then
				AAH_SavedHistoryTable[linkid].min = AAH_SavedHistoryTable[linkid]["history"][i].ppu
			end
			if AAH_SavedHistoryTable[linkid].max < AAH_SavedHistoryTable[linkid]["history"][i].ppu then
				AAH_SavedHistoryTable[linkid].max = AAH_SavedHistoryTable[linkid]["history"][i].ppu
			end
			table.insert(entry, AAH_SavedHistoryTable[linkid]["history"][i].ppu)
			AAH_SavedHistoryTable[linkid].totalcost = AAH_SavedHistoryTable[linkid].totalcost + AAH_SavedHistoryTable[linkid]["history"][i].price
			AAH_SavedHistoryTable[linkid].totalcount = AAH_SavedHistoryTable[linkid].totalcount + AAH_SavedHistoryTable[linkid]["history"][i].count
		end
		AAH_SavedHistoryTable[linkid].avg = AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[linkid].totalcost / AAH_SavedHistoryTable[linkid].totalcount)
		table.sort(entry)
		AAH_SavedHistoryTable[linkid].median = (entry[math.floor(#(entry) / 2 + 0.5)] + entry[math.ceil(#(entry) / 2 + 0.5)]) / 2
	else
		if not linkname then
			linkname = "nil"
		end
		AAHDebug("HistoryProcessItemPriceHistory: ItemLink Mismatch - historyname("..name..") ~= linkname("..failtemp.." or "..linkname..")")
	end
end

function AAHFunc.HistoryPopup_Show()
	local name = GetAuctionHistoryItemInfo(1)
	local white = AAHFunc.ToolsGetWhiteValue(name)
	local linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.BrowseItemLink)
	if linkname ~= name then
		linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.HookItemLink)
	end
	if linkname == name then
		local numhistory = #(AAH_SavedHistoryTable[linkid].history)
		AAH_HistoryHeaderPPU:SetText(AAHLocale.Messages.GENERAL_PRICE_PER_UNIT_HEADER)
		if AAH_SavedHistoryTable[linkid] and AAH_SavedHistoryTable[linkid].history and #(AAH_SavedHistoryTable[linkid].history) > 0 then
			local summary = AAHLocale.Messages.HISTORY_SUMMARY_MINMAX
			summary = string.gsub(summary, "<MINIMUM>", "|cffffd200"..AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[linkid].min / white)).."|r")
			summary = string.gsub(summary, "<MAXIMUM>", "|cffffd200"..AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[linkid].max / white)).."|r")
			AAH_HistoryMinMaxLabel:SetText(summary)
			local summary = AAHLocale.Messages.HISTORY_SUMMARY_AVERAGE
			summary = string.gsub(summary, "<MEDIAN>", "|cffffd200"..AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[linkid].median / white)).."|r")
			summary = string.gsub(summary, "<AVERAGE>", "|cffffd200"..AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[linkid].avg / white)).."|r")
			AAH_HistoryAverageLabel:SetText(summary)
			local summary = AAHLocale.Messages.HISTORY_SUMMARY_NUMHISTORY
			summary = string.gsub(summary, "<NUMHISTORY>", numhistory)
			AAH_HistoryNumHistoryLabel:SetText(summary)
			local maxvalue = numhistory - AAHVar.History_ItemMaxDisplay
			if maxvalue > 0 then
				AAH_HistoryListScrollBar:SetMinMaxValues(0, maxvalue)
				AAH_HistoryListScrollBar:Show()
			else
				AAH_HistoryListScrollBar:SetMinMaxValues(0, 0)
				AAH_HistoryListScrollBar:Hide()
			end
			AAHFunc.HistoryList_UpdateItems()
			AAH_HistoryList:Show()
		else
			AAH_HistoryList:Hide()
		end
	else
		AAH_HistoryList:Hide()
	end
end

function AAHFunc.HistoryList_UpdateItems()
	local name = GetAuctionHistoryItemInfo(1)
	local white = AAHFunc.ToolsGetWhiteValue(name)
	local linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.BrowseItemLink)
	if linkname ~= name then
		linkid, linkname = AAHFunc.ToolsParseLink(AAHVar.HookItemLink)
	end
	if linkname == name then
		local r, g, b, frame, button
		local history = AAH_SavedHistoryTable[linkid].history
		local numhistory = #(history)
		local value = AAH_HistoryListScrollBar:GetValue()
		local index = value + 1
		for i = 1, AAHVar.History_ItemMaxDisplay do
			frame = getglobal("AAH_HistoryListItem"..i)
			if i <= numhistory then
				button = getglobal(frame:GetName().."Icon")
				button.index = index
				SetItemButtonTexture(button, history[index].icon)
				SetItemButtonCount(button, history[index].count)
				if index <= 10 then
					getglobal(button:GetName().."Red"):Hide()
				else
					getglobal(button:GetName().."Red"):Show()
				end
				r, g, b = GetItemQualityColor(history[index].rarity)
				getglobal(frame:GetName().."Name"):SetText(AAH_SavedHistoryTable[linkid].name)
				getglobal(frame:GetName().."Name"):SetColor(r, g, b)
				getglobal(frame:GetName().."DateText"):SetText(history[index].date)
				getglobal(frame:GetName().."SellerText"):SetText(history[index].seller)
				getglobal(frame:GetName().."BuyerText"):SetText(history[index].buyer)
				getglobal(frame:GetName().."PPU"):SetText(AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(history[index].ppu / white)))
				getglobal(frame:GetName().."PPU"):SetColor(1,1,1)
				AAHFunc.ToolsAveragePriceColoring(history[index].ppu, AAH_SavedHistoryTable[linkid].avg, frame:GetName().."PPU")
				MoneyFrame_Update(frame:GetName().."Price", history[index].price, 1)
				frame:Show()
			else
				frame:Hide()
			end
			index = index + 1
		end
	else
		AAH_HistoryList:Hide()
	end
end