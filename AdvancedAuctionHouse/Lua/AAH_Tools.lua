function AAHDebug(msg)
--[===[@alpha@
	DEFAULT_CHAT_FRAME:AddMessage(msg)
--@end-alpha@]===]
end

function AAHFunc.ToolsSortBidLess(item1, item2)
	return item1.bidPrice < item2.bidPrice
end

function AAHFunc.ToolsSortBidMore(item1, item2)
	return item1.bidPrice > item2.bidPrice
end

function AAHFunc.ToolsSortBuyoutLess(item1, item2)
	if item1.buyoutPrice == 0 then
		return false
	elseif item2.buyoutPrice == 0 then
		return true
	else
		return item1.buyoutPrice < item2.buyoutPrice
	end
end

function AAHFunc.ToolsSortBuyoutMore(item1, item2)
	return item1.buyoutPrice > item2.buyoutPrice
end

function AAHFunc.ToolsSortBidPPULess(item1, item2)
	local white1 = AAHFunc.ToolsGetWhiteValue(item1.name)
	local white2 = AAHFunc.ToolsGetWhiteValue(item2.name)
	return (item1.bidPrice / item1.count) / white1 < (item2.bidPrice / item2.count) / white2
end

function AAHFunc.ToolsSortBidPPUMore(item1, item2)
	local white1 = AAHFunc.ToolsGetWhiteValue(item1.name)
	local white2 = AAHFunc.ToolsGetWhiteValue(item2.name)
	return (item1.bidPrice / item1.count) / white1 > (item2.bidPrice / item2.count) / white2
end

function AAHFunc.ToolsSortBuyoutPPULess(item1, item2)
	if item1.buyoutPrice == 0 then
		return false
	elseif item2.buyoutPrice == 0 then
		return true
	else
		local white1 = AAHFunc.ToolsGetWhiteValue(item1.name)
		local white2 = AAHFunc.ToolsGetWhiteValue(item2.name)
		return (item1.buyoutPrice / item1.count) / white1 < (item2.buyoutPrice / item2.count) / white2
	end
end

function AAHFunc.ToolsSortBuyoutPPUMore(item1, item2)
	local white1 = AAHFunc.ToolsGetWhiteValue(item1.name)
	local white2 = AAHFunc.ToolsGetWhiteValue(item2.name)
	return (item1.buyoutPrice / item1.count) / white1 > (item2.buyoutPrice / item2.count) / white2
end

function AAHFunc.ToolsSortLess(item1, item2)
	if AAHVar.Auction_HeaderSortItem == "status" then
		if item1[AAHVar.Auction_HeaderSortItem] == false and item2[AAHVar.Auction_HeaderSortItem] == true then
			return true
		else
			return false
		end
	elseif AAHVar.Auction_HeaderSortItem == "seller" or AAHVar.Auction_HeaderSortItem == "bidder" then
		return AAHFunc.ToolsLower(item1[AAHVar.Auction_HeaderSortItem]) < AAHFunc.ToolsLower(item2[AAHVar.Auction_HeaderSortItem])
	else
		return item1[AAHVar.Auction_HeaderSortItem] < item2[AAHVar.Auction_HeaderSortItem]
	end
end

function AAHFunc.ToolsSortMore(item1, item2)
	if AAHVar.Auction_HeaderSortItem == "status" then
		if item1[AAHVar.Auction_HeaderSortItem] == true and item2[AAHVar.Auction_HeaderSortItem] == false then
			return true
		else
			return false
		end
	elseif AAHVar.Auction_HeaderSortItem == "seller" or AAHVar.Auction_HeaderSortItem == "bidder" then
		return AAHFunc.ToolsLower(item1[AAHVar.Auction_HeaderSortItem]) > AAHFunc.ToolsLower(item2[AAHVar.Auction_HeaderSortItem])
	else
		return item1[AAHVar.Auction_HeaderSortItem] > item2[AAHVar.Auction_HeaderSortItem]
	end
end

function AAHFunc.ToolsGetRationalBidPrices(money)
	local price = math.ceil(money * 1.05)
	if price == money then
		price = price + 1
	end
	return price
end

function AAHFunc.ToolsLunaReceive(Name, Message)
--@non-alpha@
	if string.find(Message, "Build: [%d]+") then
		if AAHVar.Build < tonumber(string.match(Message, "[%d]+")) and not AAHVar.FoundNewVersion then
			DEFAULT_CHAT_FRAME:AddMessage(AAHLocale.Messages.LUNA_NEW_VERSION_FOUND)
			AAHVar.FoundNewVersion = true
		end
	end
--@end-non-alpha@
end

function AAHFunc.ToolsLocalizedTimeString(leftTime)
	local days, hours, minutes
	local temptime
	days = math.floor(leftTime / 1440)
	temptime = leftTime - (days * 1440)
	hours = string.format("%2s", math.floor(temptime / 60))
	temptime = temptime - (hours * 60)
	minutes = string.format("%02s", temptime)
	if days == 0 then
		days = "   "
	else
		hours = string.format("%02d", hours)
		days = days..AAHLocale.Messages.TOOLS_DAY_ABV
	end
	if days == "   " and hours == 0 then
		hours = "   "
	else
		hours = hours..AAHLocale.Messages.TOOLS_HOUR_ABV
	end
	return days.." "..hours.." "..minutes..AAHLocale.Messages.TOOLS_MIN_ABV
end

function AAHFunc.ToolsEvaluateString(str)
	str = string.gsub(str, ",", ".")
	local func, error = loadstring("return " .. str, str)
	local outcome,result = pcall( func, str )
	return result
end

function AAHFunc.ToolsChatEdit_AddItemLink(ItemLink, allEditbox)
	if ItemLink == nil then
		return
	end
	if ITEMLINK_EDITBOX ~= nil then
		ITEMLINK_EDITBOX:InsertText(ItemLink)
		return true
	elseif AAH_AuctionFrame:IsVisible() and AAH_BrowseFrame:IsVisible() then
		local _type, _data, _name = ParseHyperlink(ItemLink)
		AAH_BrowseNameEditBox:SetText(_name)
		return true
	elseif allEditbox then
		local editbox = GetKeyboardFocus()
		if editbox then
			local _type, _data, _name = ParseHyperlink(ItemLink)
			editbox:InsertText(_name)
			return true
		end
	end
	return false
end

function AAHFunc.ToolsGetVendorPrice()
	local temp
	for i = 1, 40 do
		if getglobal("AAH_TooltipTextLeft"..i):IsVisible() then
			temp = getglobal("AAH_TooltipTextLeft"..i):GetText()
			if temp and string.find(temp, TEXT("SYS_ITEM_COST")) then
				temp = string.gsub(temp, COMMA, "")
				return tonumber(string.match(temp, "%d+"))
			end
		end
	end
	return nil
end

function AAHFunc.ToolsPriceHistoryTooltip_OnUpdate(tooltip, elapsedTime)
	if HistoryForOther then
		return
	end
	if ((not GameTooltip:IsVisible()) and HistoryForGameTooltip) or ((not GameTooltipHyperLink:IsVisible()) and HistoryForGameTooltipHyperLink) or ((not GameTooltip:IsVisible()) and (not GameTooltipHyperLink:IsVisible()) and (not HistoryForOther)) then
		tooltip:Hide()
	else
		if HistoryForGameTooltip then
			tooltip:ClearAllAnchors()
			tooltip:SetAnchor("TOPLEFT", "BOTTOMLEFT", GameTooltip, 0, 0)
		elseif HistoryForGameTooltipHyperLink then
			tooltip:ClearAllAnchors()
			tooltip:SetAnchor("TOPLEFT", "BOTTOMLEFT", GameTooltipHyperLink, 0, 0)
		end
		tooltip:SetWidth(AAHVar.PriceHistoryTooltipWidth)
		tooltip:SetHeight(AAHVar.PriceHistoryTooltipHeight)
	end
end

function AAHFunc.ToolsSetDropDown(frame, id, name, color)
	if name then
		getglobal(frame:GetName().."Text"):SetText(name)
		if color then
			getglobal(frame:GetName().."Text"):SetColor(color[1], color[2], color[3])
		end
	end
	if id then 
		frame.selectedID = id
	end
end

function AAHFunc.ToolsParseLink(link)
	local data, name
	if link and link ~= "" then
		_, data, name = ParseHyperlink(link)
		if data then
			return tonumber(string.sub(data, 1, 5), 16), name
		else
			AAHDebug("ToolsParseLink: Bad Link: link = "..link)
		end
	end
	return nil, nil
end

function AAHFunc.ToolsShowPriceHistoryTooltip(tooltip, itemid, itemname)
	local tempString = ""
	local white = AAHFunc.ToolsGetWhiteValue(itemname)
	AAH_PriceHistoryTooltip:SetText(AAHLocale.Messages.TOOLS_PRICE_HISTORY, 0, 0.75, 0.95)
	AAH_PriceHistoryTooltip:AddDoubleLine(AAHLocale.Messages.TOOLS_POWERED_BY, "", 0, 0.75, 0.95)
	if AAH_SavedHistoryTable[itemid] then
		local numhistory = #(AAH_SavedHistoryTable[itemid].history)
		if numhistory > 0 then
			AAH_PriceHistoryTooltip:AddLine(" ")
			tempString = "|cffffd200"..AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[itemid].avg / white)).."|r"
			AAH_PriceHistoryTooltip:AddDoubleLine(AAHLocale.Messages.GENERAL_AVERAGE_PRICE_PER_UNIT, tempString)
			tempString = "|cffffd200"..AAHFunc.ToolsNumberWithCommas(AAHFunc.ToolsDynamicDecimalPlaces(AAH_SavedHistoryTable[itemid].median / white)).."|r"
			AAH_PriceHistoryTooltip:AddDoubleLine(AAHLocale.Messages.GENERAL_MEDIAN_PRICE_PER_UNIT, tempString)
			tempString = string.gsub(AAHLocale.Messages.TOOLS_GOLD_BASED, "<SCANNED>", numhistory)
			AAH_PriceHistoryTooltip:AddDoubleLine(tempString)
		end
	else
		AAH_PriceHistoryTooltip:AddLine(" ")
		AAH_PriceHistoryTooltip:AddLine(AAHLocale.Messages.TOOLS_NO_HISTORY_DATA)
	end
	AAHVar.PriceHistoryTooltipWidth = AAH_PriceHistoryTooltip:GetWidth()
	AAHVar.PriceHistoryTooltipHeight = AAH_PriceHistoryTooltip:GetHeight()
	AAH_PriceHistoryTooltip:Show()
	if getglobal("AC_VendorInformationFrame") and AC_VendorInformationFrame:IsVisible() then
		AC_VendorInformationFrame:ClearAllAnchors()
		AC_VendorInformationFrame:SetAnchor("TOPLEFT", "BOTTOMLEFT", "AAH_PriceHistoryTooltip", 0, 0)
	end
end

function AAHFunc.ToolsDynamicDecimalPlaces(number)
	if type(number) ~= "number" then
		AAHDebug("ToolsDynamicDecimalPlaces: Bad number")
		return 0
	elseif number < 0 then
		return 0
	elseif number < 0.001 then
		return tonumber(string.format("%.6f", number))
	elseif number < 0.01 then
		return tonumber(string.format("%.5f", number))
	elseif number < 0.1 then
		return tonumber(string.format("%.4f", number))
	elseif number < 1 then
		return tonumber(string.format("%.3f", number))
	elseif number < 10 then
		return tonumber(string.format("%.2f", number))
	elseif number < 100 then
		return tonumber(string.format("%.1f", number))
	else
		return tonumber(string.format("%.0f", number))
	end
end

function AAHFunc.ToolsNumberWithCommas(num)
	local dec = ""
	if string.match(num, "%.%d+") then
		dec = AAHLocale.Messages.GENERAL_DECIMAL_POINT..string.sub(string.match(num, "%.%d+"), 2)
		num = string.gsub(num, "%.%d+", "")
	end
	while string.match(num, "%d%d%d%d$") do
		dec = COMMA..string.match(num, "%d%d%d$")..dec
		num = string.gsub(num, "%d%d%d$", "")
	end
	return num..dec
end

function AAHFunc.ToolsGetWhiteValue(name)
	if AAH_SavedSettings.UseMatWhiteValue and AAHVar.MatWhiteValue[name] then
		return AAHVar.MatWhiteValue[name]
	else
		return 1
	end
end

function AAHFunc.ToolsAveragePriceColoring(price, average, widget)
	local buyPPUColor = 0
	if price / average < 1 then
		buyPPUColor = price / average
		getglobal(widget):SetColor(buyPPUColor,1,buyPPUColor)
	else
		buyPPUColor = 2 - math.min(price / average, 2)
		getglobal(widget):SetColor(1,buyPPUColor,buyPPUColor)
	end
end

function AAHFunc.ToolsFindColor(r, g, b)
	if r == 1 and g == 1 and b == 1 then
		return "white"
	elseif r == 0 and g == 1 and b == 0 then
		return "green"
	elseif r == 1 and g == 1 and b == 0 then
		return "yellow"
	elseif r == 1 and g == 0 and b == 0 then
		return "red"
	elseif string.format("%.2f", r) == "0.94" and string.format("%.2f", g) == "0.38" and string.format("%.2f", b) == "0.05" then
		return "orange"
	elseif string.format("%.2f", r) == "0.74" and string.format("%.2f", g) == "0.18" and string.format("%.2f", b) == "1.00" then
		return "rune"
	elseif string.format("%.2f", r) == "0.62" and string.format("%.2f", g) == "0.46" and string.format("%.2f", b) == "0.30" then
		return "set"
	else
		return "other"
	end
end

function AAHFunc.ToolsGetItemPriceHistoryByName(name)
	if AAH_SavedHistoryTable[name] then
		local numhistory = #(AAH_SavedHistoryTable[name].history)
		local avg = AAH_SavedHistoryTable[name].avg
		local totalcount = AAH_SavedHistoryTable[name].totalcount
		return numhistory, avg, totalcount
	else
		return nil, nil, nil
	end
end

function AAHFunc.ToolsLower(text)
	local convert = {
		["Ä"] = "ä",
		["Ö"] = "ö",
		["Ü"] = "ü",
	}
	text = string.lower(text)
	for u, l in pairs(convert) do
		text = string.gsub(text, u, l)
	end
	return text
end