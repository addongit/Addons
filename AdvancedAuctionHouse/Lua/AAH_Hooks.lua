HistoryForGameTooltipHyperLink = false
HistoryForGameTooltip = false
HistoryForOther = false

local GameTooltip_obj = GameTooltip
local GameTooltipHyperLink_obj = GameTooltipHyperLink

local SetHyperLink_orig = GameTooltipHyperLink_obj["SetHyperLink"]
function GameTooltipHyperLink:SetHyperLink(link)
	SetHyperLink_orig(GameTooltipHyperLink_obj, link)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		local linktype, data, linkname = ParseHyperlink(link)
		if linktype == "item" then
			HistoryForGameTooltipHyperLink = true
			HistoryForGameTooltip = false
			local itemid, itemname = AAHFunc.ToolsParseLink(link)
			AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
		end
	end
end

local SetGameTooltipHyperLink_orig=GameTooltip_obj["SetHyperLink"]
function GameTooltip:SetHyperLink(link)
	SetGameTooltipHyperLink_orig(GameTooltip_obj, link)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		local linktype, data, name = ParseHyperlink(link)
		if linktype == "item" then
			HistoryForGameTooltipHyperLink = false
			HistoryForGameTooltip = true
			local itemid, itemname = AAHFunc.ToolsParseLink(link)
			AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
		end
	end
end

local SetBagItem_orig = GameTooltip_obj["SetBagItem"]
function GameTooltip:SetBagItem(id)
	SetBagItem_orig(GameTooltip_obj, id)
	local link = GetBagItemLink(id)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(link)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

local SetAuctionBrowseItem_orig = GameTooltip_obj["SetAuctionBrowseItem"]
function GameTooltip:SetAuctionBrowseItem(id)
	SetAuctionBrowseItem_orig(GameTooltip_obj, id)
	local link = GetAuctionBrowseItemLink(id)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(link)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

local SetAuctionItem_orig = GameTooltip_obj["SetAuctionItem"]
function GameTooltip:SetAuctionItem(id)
	SetAuctionItem_orig(GameTooltip_obj, id)
	if AAHVar.HookItemLink and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(AAHVar.HookItemLink)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

local SetBankItem_orig = GameTooltip_obj["SetBankItem"]
function GameTooltip:SetBankItem(id)
	SetBankItem_orig(GameTooltip_obj, id)
	local link = GetBankItemLink(id)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(link)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

local SetCraftItem_orig = GameTooltip_obj["SetCraftItem"]
function GameTooltip:SetCraftItem(obj, qual)
	SetCraftItem_orig(GameTooltip_obj, obj, qual)
	local link = GetCraftItemLink(obj, 1)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(link)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

local SetHouseItem_orig = GameTooltip_obj["SetHouseItem"]
function GameTooltip:SetHouseItem(DBID, id)
	SetHouseItem_orig(GameTooltip_obj, DBID, id)
	if DBID and id then
		local link = Houses_GetItemLink(DBID, id)
		if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
			HistoryForGameTooltipHyperLink = false
			HistoryForGameTooltip = true
			local itemid, itemname = AAHFunc.ToolsParseLink(link)
			AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
		end
	end
end

local SetBootyItem_orig = GameTooltip_obj["SetBootyItem"]
function GameTooltip:SetBootyItem(id)
	SetBootyItem_orig(GameTooltip_obj, id)
	local link = GetBootyItemLink(id)
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(link)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

local SetStoreItem_orig = GameTooltip_obj["SetStoreItem"]
function GameTooltip:SetStoreItem(tab, ButtonId)
	SetStoreItem_orig(GameTooltip_obj, tab, ButtonId)
	local link
	if tab == "SELL" then
		link = GetStoreSellItemLink(ButtonId)
	elseif tab == "BUYBACK" then
		link = GetStoreBuyBackItemLink(ButtonId)
	end
	if link and IsAltKeyDown() == not AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local itemid, itemname = AAHFunc.ToolsParseLink(link)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, itemid, itemname)
	end
end

--[=[ no access to this items id or link (UNKNOWN)
local SetAccountBagItem_orig = GameTooltip_obj["SetAccountBagItem"]
function GameTooltip:SetAccountBagItem(id)
	SetAccountBagItem_orig(GameTooltip_obj, id)
	if IsAltKeyDown() or AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		AAHDebug("SetAccountBagItem<>"..id)
		AAHFunc.ToolsShowPriceHistoryTooltip(self, nil)
	end
end--]=]

--[=[ no access to this items id or link
local SetInventoryItem_orig = GameTooltip_obj["SetInventoryItem"]
function GameTooltip:SetInventoryItem(unitid, slot)
	SetInventoryItem_orig(GameTooltip_obj, unitid, slot)
	if IsAltKeyDown() or AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		AAHFunc.ToolsShowPriceHistoryTooltip(self, nil)
	end
end--]=]

--[=[ no access to this item's id or link
local SetCraftRequestItem_orig = GameTooltip_obj["SetCraftRequestItem"]
function GameTooltip:SetCraftRequestItem(obj, id)
	SetCraftRequestItem_orig(GameTooltip_obj, obj, id)
	if IsAltKeyDown() or AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local name = GameTooltipTextLeft1:GetText()
		AAHFunc.ToolsShowPriceHistoryTooltip(self, name)
	end
end--]=]

--[=[ no access to this item's id or link
local SetAuctionBidItem_orig = GameTooltip_obj["SetAuctionBidItem"]
function GameTooltip:SetAuctionBidItem(id)
	SetAuctionBidItem_orig(GameTooltip_obj, id)
	if IsAltKeyDown() or AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local name = GameTooltipTextLeft1:GetText()
		local offset = string.find(name, "+")
		if offset then
			name = string.sub(name, 1, offset - 2)
		end
		AAHFunc.ToolsShowPriceHistoryTooltip(self, name)
	end
end--]=]

--[=[ no access to this item's id or link
local SetAuctionSellItem_orig = GameTooltip_obj["SetAuctionSellItem"]
function GameTooltip:SetAuctionSellItem(id)
	SetAuctionSellItem_orig(GameTooltip_obj, id)
	if IsAltKeyDown() or AAH_SavedSettings.PriceHistoryAutoshow then
		HistoryForGameTooltipHyperLink = false
		HistoryForGameTooltip = true
		local name = GameTooltipTextLeft1:GetText()
		local offset = string.find(name, "+")
		if offset then
			name = string.sub(name, 1, offset - 2)
		end
		AAHFunc.ToolsShowPriceHistoryTooltip(self, name)
	end
end--]=]

local ChatEdit_AddItemLink_orig = ChatEdit_AddItemLink
function ChatEdit_AddItemLink(ItemLink, allEditbox)
	local name
	if ItemLink and not ITEMLINK_EDITBOX and AAH_AuctionFrame:IsVisible() and AAH_BrowseFrame:IsVisible() then
		_, _, name = ParseHyperlink(ItemLink)
		AAH_BrowseNameEditBox:SetText(name)
		return true
	end
	ChatEdit_AddItemLink_orig(ItemLink, allEditbox)
end

local CloseAllWindows_orig = CloseAllWindows
function CloseAllWindows()
	HideUIPanel(AAH_AuctionFrame)
	CloseAllWindows_orig()
end

local SendSystemMsg_orig = SendSystemMsg
function SendSystemMsg(arg1, override)
	if arg1 then
		if not override then
			if arg1 == TEXT("SYS_AC_HISTORY_NONE") then
				return
			end
		end
		SendSystemMsg_orig(arg1, override)
	end
end

local SendWarningMsg_orig = SendWarningMsg
function SendWarningMsg(text)
	if string.find(text, TEXT("SYS_AC_BID_PERICES_TO_LOW")) and AAHVar.RationalValues then
		AAHVar.Auction_BidMoney = AAHVar.RationalValues.bidPrice
		if AAHVar.Auction_BidMoney > GetPlayerMoney("copper") then
			StaticPopup_Show("BUYOUT_ALERT")
			return
		end
		AuctionBrowseBuyItem(AAHVar.RationalValues.auctionid, AAHVar.Auction_BidMoney)
		AAHVar.RationalValues = nil
	else
		SendWarningMsg_orig(text)
	end
end

if zBagItem_OnClick then
	local zBagItem_OnClick_orig = zBagItem_OnClick
	function zBagItem_OnClick(this, button, ignoreShift)
		if GetAuctionItem() then
			AAHFunc.SellClearItem()
		end
		if not AAH_HistoryList:IsVisible() then
			AAHVar.HookItemLink = GetBagItemLink(this.index)
		end
		zBagItem_OnClick_orig(this, button, ignoreShift)
	end
end

if yBagItem_OnClick then
	local yBagItem_OnClick_orig = yBagItem_OnClick
	function yBagItem_OnClick(this, button, ignoreShift)
		if GetAuctionItem() then
			AAHFunc.SellClearItem()
		end
		if not AAH_HistoryList:IsVisible() then
			AAHVar.HookItemLink = GetBagItemLink(this.index)
		end
		yBagItem_OnClick_orig(this, button, ignoreShift)
	end
end

if FlieBag then
	local FlieBag_ItemButton_OnClick_orig = FlieBag.ItemButton.OnClick
	function FlieBag.ItemButton.OnClick(this, button, ignoreShift)
		if GetAuctionItem() then
			AAHFunc.SellClearItem()
		end
		if not AAH_HistoryList:IsVisible() then
			AAHVar.HookItemLink = GetBagItemLink(this.inventoryIndex)
		end
		FlieBag_ItemButton_OnClick_orig(this, button, ignoreShift)
	end
end

if BagItemButton_OnClick then
	local BagItemButton_OnClick_orig = BagItemButton_OnClick
	function BagItemButton_OnClick(this, button, ignoreShift)
		if GetAuctionItem() then
			AAHFunc.SellClearItem()
		end
		if not AAH_HistoryList:IsVisible() then
			AAHVar.HookItemLink = GetBagItemLink(this.index)
		end
		BagItemButton_OnClick_orig(this, button, ignoreShift)
	end
end

if GoodsItemButton_OnClick then
	local GoodsItemButton_OnClick_orig = GoodsItemButton_OnClick
	function GoodsItemButton_OnClick(this, button, ignoreShift)
		if GetAuctionItem() then
			AAHFunc.SellClearItem()
		end
		if not AAH_HistoryList:IsVisible() then
			AAHVar.HookItemLink = GetBagItemLink(this:GetID())
		end
		GoodsItemButton_OnClick_orig(this, button, ignoreShift)
	end
end

StaticPopupDialogs["BUYOUT_CONFIRMATION"] = {
	text = TEXT("BUYOUT_CONFIRMATION"),
	button1 = TEXT("ACCEPT"),
	button2 = TEXT("CANCEL"),
	OnShow = function(this)
		local buyoutPrice
		if AAHVar.Auction_CurrentTab == "BROWSE" then
			buyoutPrice = AuctionBrowseList.list[AuctionBrowseList.selected].buyoutPrice
		elseif AAHVar.Auction_CurrentTab == "BUY" then
			buyoutPrice = AuctionBidList.list[AuctionBidList.selected].buyoutPrice
		end
		MoneyFrame_Update(this:GetName().."MoneyFrame", buyoutPrice, "copper")
	end,
	OnAccept = function(this)
		local editbox = getglobal(this:GetName().."EditBox")
		if AAHVar.Auction_CurrentTab == "BROWSE" then
			AAHVar.Auction_BuyoutEvent = true
			AuctionBrowseBuyItem(AuctionBrowseList.list[AuctionBrowseList.selected].auctionid, nil, editbox:GetText())
		elseif AAHVar.Auction_CurrentTab == "BUY" then
			AuctionBidBuyItem(AuctionBidList.list[AuctionBidList.selected].auctionid, nil, editbox:GetText())
		end
		editbox:SetText("")
	end,
	timeout = 0,
	hasMoneyFrame = 1,
	hideOnEscape = 1,
}

StaticPopupDialogs["SAVEDSEARCH_CREATEFOLDER"] = {
	text = AAHLocale.Messages.BROWSE_CREATE_FOLDER_POPUP,
	button1 = TEXT("ACCEPT"),
	button2 = TEXT("CANCEL"),
	OnShow = function(this)
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
	OnAccept = function(this)
	table.insert(AAH_SavedSearch, {["name"] = getglobal(this:GetName().."EditBox"):GetText(), ["contents"] = {},})
	table.insert(AAH_SavedSearch[#(AAH_SavedSearch)]["contents"], AAHVar.Browse_SavedSearchNewItem)
	AAHFunc.BrowseSavedSearchScrollBar_Update()
	end,
	OnCancel = function(this)
		AAHVar.Browse_SavedSearchNewItem = {}
	end,
	hasEditBox = 1,
	hideOnEscape = 1,
}

StaticPopupDialogs["SAVEDSEARCH_CREATEITEM"] = {
	text = AAHLocale.Messages.BROWSE_NAME_SEARCH_POPUP,
	button1 = TEXT("ACCEPT"),
	button2 = TEXT("CANCEL"),
	OnShow = function(this)
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
	OnAccept = function(this)
		AAHFunc.BrowseSavedSearch_CreateItem(getglobal(this:GetName().."EditBox"):GetText())
	end,
	hasEditBox = 1,
	hideOnEscape = 1,
}

StaticPopupDialogs["SAVEDSEARCH_RENAMEITEM"] = {
	text = AAHLocale.Messages.BROWSE_RENAME_SAVED_SEARCH_POPUP,
	button1 = TEXT("ACCEPT"),
	button2 = TEXT("CANCEL"),
	OnShow = function(this)
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
	OnAccept = function(this)
		AAH_SavedSearch[AAHVar.Browse_SavedSearchRenameItem[1]]["contents"][AAHVar.Browse_SavedSearchRenameItem[2]]["name"] = getglobal(this:GetName().."EditBox"):GetText()
		AAHFunc.BrowseSavedSearchScrollBar_Update()
	end,
	hasEditBox = 1,
	hideOnEscape = 1,
}

SLASH_AAH_SlashHandler1 = "/aah"
SLASH_AAH_SlashHandler2 = "/auctionhouse"
SlashCmdList["AAH_SlashHandler"] = function(editBox, msg)
	local command = ""
	local param = ""
	if string.find(msg, " ") then
		command = AAHFunc.ToolsLower(string.sub(msg, 1, string.find(msg, " ") - 1))
		param = string.sub(msg, string.find(msg, " ") + 1)
	else
		command = msg
	end
	local linkid, linkname = AAHFunc.ToolsParseLink(param)
	if linkid then
		param = linkid
	end
	if command == "clear" then
		if AAH_SavedHistoryTable[param] then
			AAH_SavedHistoryTable[param] = nil
			DEFAULT_CHAT_FRAME:AddMessage(AAHLocale.Messages.SETTINGS_CLEAR_SUCCESS .. param)
		elseif param == "" then
			DEFAULT_CHAT_FRAME:AddMessage(AAHLocale.Messages.SETTINGS_MISSING_PARAMETER)
		else
			DEFAULT_CHAT_FRAME:AddMessage(AAHLocale.Messages.TOOLS_ITEM_NOT_FOUND .. param)
		end
	elseif command == "clearall" then
		AAH_SavedHistoryTable = {}
		DEFAULT_CHAT_FRAME:AddMessage(AAHLocale.Messages.SETTINGS_CLEAR_ALL_SUCCESS)
	elseif command == "usewhitevalue" then
		if AAH_SavedSettings.UseMatWhiteValue then
			AAH_SavedSettings.UseMatWhiteValue = false
			--Message
		else
			AAH_SavedSettings.UseMatWhiteValue = true
			--Message
		end
		AAH_SettingsUseWhiteValue:SetChecked(AAH_SavedSettings.UseMatWhiteValue)
	elseif command == "pricehistory" then
		if AAH_SavedSettings.PriceHistoryAutoshow then
			AAH_SavedSettings.PriceHistoryAutoshow = false
			--Message
		else
			AAH_SavedSettings.PriceHistoryAutoshow = true
			--Message
		end
		AAH_SettingsAlwaysShowPriceHistory:SetChecked(AAH_SavedSettings.PriceHistoryAutoshow)
	elseif command == "numhistory" then
		if tonumber(param) then
			param = math.floor(tonumber(param))
			if param >= AAHVar.SettingsHistoryMin and param <= AAHVar.SettingsHistoryMax then
				AAH_SavedSettings.HistoryMaxSaved = param
				AAH_SettingsMaxHistory:SetValue(AAH_SavedSettings.HistoryMaxSaved)
				--Message Success
			else
				--Message Out of Range
			end
		else
			--Message No Param
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(AAHLocale.Messages.TOOLS_UNKNOWN_COMMAND)
	end
end