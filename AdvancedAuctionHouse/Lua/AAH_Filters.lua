--[[ Filter Creation Help --
	Filter function will have 2 tables for parameters.
	First table is param and it is a table of what was entered into the filterbox.
		example filter: $bob/hello/13//46///en
		param = {
			[1] = "bob",
			[2] = "hello",
			[3] = "13",
			[4] = "",
			[5] = "46",
			[6] = "",
			[7] = "",
			[8] = "en",
		}
		only param[1] is needed, all others are optional for the filter
	Second Table is a table of info for that auction entry
		listing.name = string,				--name of the item
		listing.itemid = number,			--itemID number
		listing.count = number,				--stack size
		listing.rarity = number,			--rarity level (0=white, 1=green, etc.)
		listing.level = number,				--item level as listed in the level column
		listing.levelcolor = string,		--color hex code for the level, yellow if using game value, green if overriden with different value
		listing.leftTime = number,			--time left in minutes, not exact number, seems to round up by the tens slot (1234 will be 1240)
		listing.bidPrice = number,			--the estimated price to bid on the item
		listing.bidppu = number,			--bidPrice / count
		listing.buyoutPrice = number,		--the price to buyout the auction
		listing.buyppu = number,			--buyoutPrice / count
		listing.seller = string,			--name of the seller
		listing.isBuyer = boolean,			--true if you are the current highest bidder
		listing.texture = string,			--location of the item's icon texture file
		listing.auctionid = number,			--ID number used to buy the auction
		listing.tier = number				--Tier
		listing.plus = number				--Plus
		listing.dura = number				--Max Durability
		listing.worth = number				--Vendor Value
		listing.mdam = number				--Magical Damage
		listing.pdam = number				--Physical Damage
		listing.speed = number				--Attack Speed
		listing.dps = number				--DPS
		listing.sta = number				--Stamina
		listing.str = number				--Strength
		listing.dex = number				--Dexterity
		listing.wis = number				--Wisdom
		listing.int = number				--Intelligence
		listing.hp = number					--Maximum HP
		listing.mp = number					--Maximum MP
		listing.patt = number				--Physical Attack
		listing.matt = number				--Magical Attack
		listing.pdef = number				--Physical Defense
		listing.mdef = number				--Magical Defense
		listing.pcrit = number				--Physical Crit Rate
		listing.mcrit = number				--Magical Crit Rate
		listing.pacc = number				--Physical Accuracy
		listing.macc = number				--Magical Accuracy
		listing.pdod = number				--Physical Dodge Rate
		listing.parry = number				--Parry Rate
		listing.heal = number				--Healing Bonus
	Your function will look something like ...
		function FilterForBob(param, listing)
			--test for true
			return true
			--else
			return false
		end
	To register your filter use 1 of the 2 following methods in your VARIABLES_LOADED event
		AAHFunc.FiltersRegister({coms = <comma seperated string of commands>, func = <your function name without the (param, listing)>})
	OR
		local filter = {
			coms = <comma seperated string of commands>,
			func = <your function name without the (param, listing)>,
		}
		AAHFunc.FiltersRegister(filter)
	Examples
		if AdvancedAuctionHouse then
			AAHFunc.FiltersRegister({coms = "$bob,$bobby,$robert", func = FilterForBob})
		end
	OR
		if AdvancedAuctionHouse then
			local filter = {
				coms = "$bob,$bobby,$robert",
				func = FilterForBob,
			}
			AAHFunc.FiltersRegister(filter)
		end
]]

function AAHFunc.FiltersRegister(entry)
	if type(entry) == "table" and type(entry.func) == "function" and type(entry.coms) == "string" then
		entry.coms = entry.coms..","
		for com in string.gmatch(entry.coms, "\$(.-),") do
			AAHVar.Filters[com] = entry.func
			AAHDebug("$"..com.." initialized")
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Invalid Filter setup")
	end
end

function AAHFunc.FiltersZero(param, listing)--Search for items with a 0 Stats
	return AAHFunc.FiltersCount(param, listing, 0)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.ZERO, func = AAHFunc.FiltersZero})

function AAHFunc.FiltersOne(param, listing)--Search for items with a 1 Stat
	return AAHFunc.FiltersCount(param, listing, 1)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.ONE, func = AAHFunc.FiltersOne})

function AAHFunc.FiltersTwo(param, listing)--Search for items with a 2 Stats
	return AAHFunc.FiltersCount(param, listing, 2)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.TWO, func = AAHFunc.FiltersTwo})

function AAHFunc.FiltersThree(param, listing)--Search for items with a 3 Stats
	return AAHFunc.FiltersCount(param, listing, 3)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.THREE, func = AAHFunc.FiltersThree})

function AAHFunc.FiltersFour(param, listing)--Search for items with a 4 Stats
	return AAHFunc.FiltersCount(param, listing, 4)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.FOUR, func = AAHFunc.FiltersFour})

function AAHFunc.FiltersFive(param, listing)--Search for items with a 5 Stats
	return AAHFunc.FiltersCount(param, listing, 5)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.FIVE, func = AAHFunc.FiltersFive})

function AAHFunc.FiltersSix(param, listing)--Search for items with a 6 Stats
	return AAHFunc.FiltersCount(param, listing, 6)
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.SIX, func = AAHFunc.FiltersSix})

function AAHFunc.FiltersGreen(param, listing, color)
	if color then
		return "green"
	else
		return AAHFunc.FiltersColor(param, listing, "green")
	end
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.GREEN, func = AAHFunc.FiltersGreen})

function AAHFunc.FiltersYellow(param, listing, color)
	if color then
		return "yellow"
	else
		return AAHFunc.FiltersColor(param, listing, "yellow")
	end
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.YELLOW, func = AAHFunc.FiltersYellow})

function AAHFunc.FiltersOrange(param, listing, color)
	if color then
		return "orange"
	else
		return AAHFunc.FiltersColor(param, listing, "orange")
	end
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.ORANGE, func = AAHFunc.FiltersOrange})

function AAHFunc.FiltersColor(param, listing, color)--Search for green, yellow, or orange stats
	local left, right, found
	for i = 3, 40 do
		if getglobal("AAH_TooltipTextLeft"..i):IsVisible() and getglobal("AAH_TooltipTextRight"..i):IsVisible() then
			left = getglobal("AAH_TooltipTextLeft"..i):GetText()
			right = getglobal("AAH_TooltipTextRight"..i):GetText()
			if left and left ~= "" and right and right ~= "" then
				found = AAHFunc.ToolsFindColor(getglobal("AAH_TooltipTextLeft"..i):GetColor())
				if found == color then
					return true
				elseif AAHFunc.ToolsFindColor(r, g, b) == "rune" then
					return false
				end
			end
		end
	end
	return false
end

function AAHFunc.FiltersCount(param, listing, count)-- Search for # of colored stats
	local statCount = 0
	local colorinverse = false
	local color = nil
	if param[2] then
		if string.sub(param[2],1,1) == "!" then
			param[2] = string.sub(param[2],2)
			colorinverse = true
		end
		if string.sub(param[2],1,1) == "$" then
			param[2] = string.sub(param[2],2)
		end
		if AAHVar.Filters[param[2]] then
			color = AAHVar.Filters[param[2]](param, listing, true)
			if color ~= "green" and color ~= "yellow" and color ~= "orange" then
				color = nil
			end
		end
	end
	local left, right, found
	for i = 3, 40 do
		if getglobal("AAH_TooltipTextLeft"..i):IsVisible() and getglobal("AAH_TooltipTextRight"..i):IsVisible() then
			left = getglobal("AAH_TooltipTextLeft"..i):GetText()
			right = getglobal("AAH_TooltipTextRight"..i):GetText()
			if left and left ~= "" and right and right ~= "" and not string.match(left, TEXT("SYS_TOOLTIP_RUNE_LEVEL")) then
				found = AAHFunc.ToolsFindColor(getglobal("AAH_TooltipTextLeft"..i):GetColor())
				if found == "rune" then
					break
				elseif found ~= "green" and found ~= "yellow" and found ~= "orange" then
					--ignore
				elseif color then
					if colorinverse then
						if found ~= color then
							statCount = statCount + 1
						elseif found == color then
							statCount = -1
							break
						end
					else
						if found == color then
							statCount = statCount + 1
						elseif found ~= color then
							statCount = -1
							break
						end
					end
				else
					statCount = statCount + 1
				end
			end
		end
	end
	if count == statCount then
		return true
	end
	return false
end

function AAHFunc.FiltersTier(param, listing)--Search for items with a minimum tier
	local value = 1
	if param[2] then
		value = tonumber(string.match(param[2], "%d+")) or 1
	end
	if listing.tier >= value then
		return true
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.TIER, func = AAHFunc.FiltersTier})

function AAHFunc.FiltersPlus(param, listing)--Search for items with a minimum plus
	local value = 1
	if param[2] then
		value = tonumber(string.match(param[2], "%d+")) or 1
	end
	if listing.plus >= value then
		return true
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.PLUS, func = AAHFunc.FiltersPlus})

function AAHFunc.FiltersDura(param, listing)--Search for items with durability >= 101 (high dura)
	local value = 101
	if param[2] then
		value = tonumber(string.match(param[2], "%d+")) or 101
	end
	if listing.dura >= value then
		return true
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.DURA, func = AAHFunc.FiltersDura})

function AAHFunc.FiltersEggLevel(param, listing)--Search for Pet Eggs with a minimum Level
	if AAHVar.PetEggs[listing.itemid] then
		local value = 1
		if param[2] then
			value = tonumber(string.match(param[2], "%d+")) or 1
		end
		if listing.level >= value then
			return true
		end
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.EGGLEVEL, func = AAHFunc.FiltersEggLevel})

function AAHFunc.FiltersEggAptitude(param, listing)--Search for Pet Eggs with a minimum Aptitude
	local left
	local value = 1
	if param[2] then
		value = tonumber(string.match(param[2], "%d+")) or 1
	end
	if AAHVar.PetEggs[listing.itemid] then
		for i = 3, 40 do
			left = getglobal("AAH_TooltipTextLeft"..i):GetText()
			if left ~= nil and getglobal("AAH_TooltipTextLeft"..i):IsVisible() then
				if string.find(left, TEXT("PET_TOOLTIP_TALENT").."%d+") then
					if tonumber(string.match(left, "%d+")) >= value then
						return true
					end
				end
			end
		end
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.EGGAPTITUDE, func = AAHFunc.FiltersEggAptitude})

function AAHFunc.FiltersVendor(param, listing)--Search for items that can be vendored for a profit
	if listing.isBuyer or listing.worth == 0 then
		return false
	end
	local minprofit = 1
	if param[2] then
		minprofit = tonumber(string.match(param[2], "%d+")) or 1
	end
	local maxtime = 4320
	if param[3] then
		maxtime = tonumber(string.match(param[3], "%d+")) or 4320
	end
	if listing.worth > listing.buyppu and listing.buyppu > 0 then
		return true
	elseif listing.worth - listing.bidppu >= minprofit and listing.leftTime <= maxtime then
		return true
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.VENDOR, func = AAHFunc.FiltersVendor})

function AAHFunc.FiltersBargain(param, listing)--Search for items that can be reauctioned for a profit
	if AAH_SavedHistoryTable[listing.itemid] and AAH_SavedHistoryTable[listing.itemid].avg and not listing.isBuyer then
		local avgcost = AAH_SavedHistoryTable[listing.itemid].avg
	else
		return false
	end
	local percent = .7
	if param[2] then
		percent = 1 - (tonumber(string.match(param[2], "%d+")) / 100) or .7
	end
	local maxtime = 4320
	if param[3] then
		maxtime = tonumber(string.match(param[3], "%d+")) or 4320
	end
	if avgcost * percent >= listing.bidppu and maxtime >= listing.leftTime then
		return true
	elseif avgcost * percent >= listing.buyppu and listing.buyppu > 0 then
		return true
	end
	return false
end
AAHFunc.FiltersRegister({coms = AAHLocale.Commands.BARGAIN, func = AAHFunc.FiltersBargain})

function AAHFunc.FiltersCheckFilter(listing)
	local filter1 = false
	local filter2 = false
	local filter3 = false
	local filtertrue = false
	local filter1Phrase = AAH_BrowseFilter1EditBox:GetText()
	local filter2Phrase = AAH_BrowseFilter2EditBox:GetText()
	local filter3Phrase = AAH_BrowseFilter3EditBox:GetText()
	local or2 = AAH_BrowseFilter2OrButton:IsChecked()
	local or3 = AAH_BrowseFilter3OrButton:IsChecked()
	local filterminprice = AAH_BrowseFilterMinPriceEditBox:GetNumber()
	local filtermaxprice = AAH_BrowseFilterMaxPriceEditBox:GetNumber()
	local filterppu = AAH_BrowseFilterPPUButton:IsChecked()
	local filterbid = AAH_BrowseFilterBidButton:IsChecked()
	AAH_Tooltip:SetHyperLink(listing.link)
	AAH_Tooltip:Hide()
	GameTooltip1:Hide()
	GameTooltip2:Hide()
	if filter1Phrase ~= "" then
		if string.sub(filter1Phrase, 1, 1) == "!" then
			if string.len(filter1Phrase) > 1 then
				filter1 = not(AAHFunc.FiltersSearchInTooltip(string.sub(filter1Phrase, 2), listing))
			else
				filter1 = true
			end
		else
			filter1 = AAHFunc.FiltersSearchInTooltip(filter1Phrase, listing)
		end
	else
		filter1 = true
	end
	if filter2Phrase ~= "" then
		if string.sub(filter2Phrase, 1, 1) == "!" then
			if string.len(filter2Phrase) > 1 then
				filter2 = not(AAHFunc.FiltersSearchInTooltip(string.sub(filter2Phrase, 2), listing))
			else
				filter2 = true
			end
		else
			filter2 = AAHFunc.FiltersSearchInTooltip(filter2Phrase, listing)
		end
	else
		filter2 = true
	end
	if filter3Phrase ~= "" then
		if string.sub(filter3Phrase, 1, 1) == "!" then
			if string.len(filter3Phrase) > 1 then
				filter3 = not(AAHFunc.FiltersSearchInTooltip(string.sub(filter3Phrase, 2), listing))
			else
				filter3 = true
			end
		else
			filter3 = AAHFunc.FiltersSearchInTooltip(filter3Phrase, listing)
		end
	else
		filter3 = true
	end
	if or2 and or3 then
		filtertrue = (filter1 or filter2 or filter3)
	elseif or2 and (not or3) then
		filtertrue = ((filter1 or filter2) and filter3)
	elseif (not or2) and or3 then
		filtertrue = ((filter1 and filter2) or filter3)
	else
		filtertrue = (filter1 and filter2 and filter3)
	end
	if not filtertrue then
		return false
	end
	if filterminprice and filterminprice > 0 then
		if filterppu and filterbid and listing.bidppu < filterminprice then
			return false
		elseif filterppu and not filterbid and listing.buyppu < filterminprice then
			return false
		elseif not filterppu and filterbid and listing.bidPrice < filterminprice then
			return false
		elseif not filterppu and not filterbid and listing.buyoutPrice < filterminprice then
			return false
		end
	end
	if filtermaxprice and filtermaxprice > 0 then
		if filterppu and filterbid and listing.bidppu > filtermaxprice and listing.bidppu > 0 then
			return false
		elseif filterppu and not filterbid and listing.buyppu > filtermaxprice and listing.buyppu > 0 then
			return false
		elseif not filterppu and filterbid and listing.bidPrice > filtermaxprice and listing.bidPrice > 0 then
			return false
		elseif not filterppu and not filterbid and listing.buyoutPrice > filtermaxprice and listing.buyoutPrice > 0 then
			return false
		end
	end
	return true
end

function AAHFunc.FiltersSearchInTooltip(searchString, listing)
	local lowerString = AAHFunc.ToolsLower(string.gsub(searchString, "-", "%%-"))
	local text
	if string.sub(lowerString, 1, 1) == "$" then
		lowerString = lowerString.."/"
		local strlen = string.len(lowerString)
		local param = {}
		local loc1, loc2 = 2, 0
		repeat
			loc2 = string.find(lowerString, "/", loc1)
			table.insert(param, string.sub(lowerString, loc1, loc2 - 1))
			loc1 = loc2 + 1
		until loc1 > strlen
		if AAHVar.Filters[param[1]] then
			return AAHVar.Filters[param[1]](param, listing)
		end
	else
		for i = 1, 40 do
			--Search for text in left sides
			text = getglobal("AAH_TooltipTextLeft"..i):GetText()
			if text ~= nil and getglobal("AAH_TooltipTextLeft"..i):IsVisible() then
				if string.find(AAHFunc.ToolsLower(text), lowerString) then
					return true
				end
			end
			--Search for text in right sides
			text = getglobal("AAH_TooltipTextRight"..i):GetText()
			if text ~= nil and getglobal("AAH_TooltipTextRight"..i):IsVisible() then
				if string.find(AAHFunc.ToolsLower(text), lowerString) then
					return true
				end
			end
		end
	end
	return false
end