-- @release $Id: Export.lua 5 2011-01-25 14:05:53Z reighnman $

if not SlamAndAwe then return end

local L = LibStub("AceLocale-3.0"):GetLocale("SlamAndAwe")
local media = LibStub:GetLibrary("LibSharedMedia-3.0")
local C = SlamAndAwe.constants -- Defined in Constants.LUA no locale needed.
if not C then 
	SlamAndAwe:SetConstants()
end

local format, len, lower = _G.string.format, _G.string.len, _G.string.lower
local gsub, trim = _G.string.gsub, _G.strtrim

local frame = CreateFrame("Frame", "SAA_ExportFrame", UIParent, "DialogBoxFrame")

local outputText = ""
if not SlamAndAwe.vars then
	SlamAndAwe.vars = {}
end

function SlamAndAwe:ExportToSim()
	if self:CheckIfBuffed() then
		self:PrintMsg(L["warn_sim_export"], SlamAndAwe.db.char.warning.colour, 5)
	end
	outputText = ""
	self:ExportStats()
	self:ExportSetBonuses() -- needs data for T11 bonuses
	self:ExportRingProc()
	self:ExportGlyphs()
	self:ExportArmourType()
	self:ExportTalents()
	StaticPopup_Show("SAA_EXPORT_ENHSIM")
end

StaticPopupDialogs["SAA_EXPORT_ENHSIM"] = {
	text = L["export_enhsim"],
	button1 = ACCEPT,
	button2 = CLOSE,
	hasEditBox = 1,
	OnShow = function(self)
		local editBox = _G[self:GetName().."EditBox"]
		editBox:SetText(outputText)
		editBox:HighlightText()
		editBox:SetAutoFocus(false)
		editBox:SetJustifyH("LEFT")
		editBox:SetJustifyV("TOP")
		editBox:SetFocus()
		local dialogBox = editBox:GetParent()
		dialogBox:SetPoint("TOP", SlamAndAwe.msgFrame, "BOTTOM",0, -50)
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
	end,
	OnHide = function(self)
		_G[self:GetName().."EditBox"]:SetText("");
	end,
	timeout = 0,
	hideOnEscape = 1,
}

function SlamAndAwe:AddLine(text)
	self:DebugPrint(text)
	if text then
		outputText = outputText.."\r\n"..trim(text)
	end
end

function SlamAndAwe:ExportStats()
	local rating, percentage
	outputText = ""
	self:AddLine("###############################")
	self:AddLine("## SlamAndAwe EnhSim Export ##")
	self:AddLine("###############################")
	self:AddLine(" ")
	self:AddLine("config_source slamandawe")
	self:AddLine(" ")
	local _, race = UnitRace("player")
	self:AddLine("race                            "..lower(race))
	local mh, oh = UnitAttackSpeed("player")
	local meleehaste = GetCombatRatingBonus(18) or 0
	local spellhaste = GetCombatRatingBonus(20) or 0
	local mhspeed = ((mh or 0) * (1 + meleehaste/100)) + 0.005 -- force small delta to counter rounding issues
	local ohspeed = ((oh or 0) * (1 + meleehaste/100)) + 0.005
	self:AddLine("mh_speed                        "..format("%.1f",mhspeed).."0")
	self:AddLine("oh_speed                        "..format("%.1f",ohspeed).."0")
	
	self:AddLine("mh_dps                          "..self:GetWeaponDPS(16))
	self:AddLine("oh_dps                          "..self:GetWeaponDPS(17))
	
	self:AddLine("mh_crit                         "..format("%.2f",GetCritChance()))
	self:AddLine("oh_crit                         "..format("%.2f",GetCritChance()))
	
	percentage = GetCombatRatingBonus(6) -- Melee Hit rating
	if self:IsEnhancement() then
		percentage = percentage + 6
	end
	percentage = percentage + self:DraeneiHitBuff()
	self:AddLine("mh_hit                          "..format("%.2f",percentage))
	self:AddLine("oh_hit                          "..format("%.2f",percentage))
	
	rating = GetCombatRating(24) -- Expertise rating
	self:AddLine("mh_expertise_rating             "..rating)
	self:AddLine("oh_expertise_rating             "..rating)
	
	local ap, buff, debuff = UnitAttackPower("player")
	local power = ap + buff + debuff
	self:AddLine("ap                              "..power)
	self:AddLine("melee_haste                     "..format("%.2f",meleehaste))
	
	self:AddLine("str                             "..UnitStat("player",1))
	self:AddLine("agi                             "..UnitStat("player",2))
	self:AddLine("int                             "..UnitStat("player",4))
	self:AddLine("spi                             "..UnitStat("player",5))
	
	rating = GetCombatRating(26) -- Mastery rating
	self:AddLine("mastery_rating                  "..rating)
	
	self:AddLine("spellpower                      "..GetSpellBonusDamage(4))
	self:AddLine("spell_crit                      "..format("%.2f",GetSpellCritChance(4)))
	
	percentage = GetCombatRatingBonus(8) -- Spell hit rating
	percentage = percentage + self:DraeneiHitBuff()
	self:AddLine("spell_hit                       "..format("%.2f",percentage))
	self:AddLine("spell_haste                     "..format("%.2f",spellhaste))
	
	self:AddLine("max_mana                        "..UnitPowerMax("player"))
	local _, manaregen = GetManaRegen()
	self:AddLine("mp5                             "..format("%d", manaregen * 5))
	self:AddLine(" ")
	
	if SlamAndAwe.db.char.binding.mhspell == SlamAndAwe.constants["Windfury Weapon"] then
		self:AddLine("mh_imbue                        windfury")
	elseif SlamAndAwe.db.char.binding.mhspell == SlamAndAwe.constants["Flametongue Weapon"] then
		self:AddLine("mh_imbue                        flametongue")
	elseif SlamAndAwe.db.char.binding.mhspell == SlamAndAwe.constants["Frostbrand Weapon"] then
		self:AddLine("mh_imbue                        frostbrand")
	else
		self:AddLine("mh_imbue                        -")
	end
	if SlamAndAwe.db.char.binding.ohspell == SlamAndAwe.constants["Windfury Weapon"] then
		self:AddLine("oh_imbue                        windfury")
	elseif SlamAndAwe.db.char.binding.ohspell == SlamAndAwe.constants["Flametongue Weapon"] then
		self:AddLine("oh_imbue                        flametongue")
	elseif SlamAndAwe.db.char.binding.ohspell == SlamAndAwe.constants["Frostbrand Weapon"] then
		self:AddLine("oh_imbue                        frostbrand")
	else
		self:AddLine("oh_imbue                        -")
	end
	self:AddLine(" ")
	self:ExportItemDetails("mh", 16, true)
	self:ExportItemDetails("oh", 17, true)
	self:AddLine(" ")
	
	self:ExportItemDetails("trinket1         ", 13, false)
	self:ExportItemDetails("trinket2         ", 14, false)
	self:AddLine(" ")
	self:AddLine("metagem                         "..self:GetMetaGemID())
	if self:isAlchemist() then
		self:AddLine("mixology                        1")
	else
		self:AddLine("mixology                        0")
	end
end

function SlamAndAwe:ExportItemDetails(slotname, slotid, weapon)
	local slotLink = GetInventoryItemLink("player", slotid)
	if slotLink then
		local itemName, itemString, _, _, _, _, itemSubType = GetItemInfo(slotLink)
		local _, itemID, enchantID = strsplit(":", itemString)
		if not itemID then
			itemID = "-"
		end
		if not enchantID then
			enchantID = "-"
		end
		if weapon then -- looking up weapon so we want enchant details
			self:AddLine(slotname.."_enchant                      "..enchantID)
			if itemSubType == L["One-Handed Axes"] or itemSubType == L["Two-Handed Axes"] then
				self:AddLine(slotname.."_weapon                       axe")
			elseif itemSubType == L["Daggers"] then
				self:AddLine(slotname.."_weapon                       dagger")
			elseif itemSubType == L["Fist Weapons"] then
				self:AddLine(slotname.."_weapon                       fist")
			elseif itemSubType == L["One-Handed Maces"] or itemSubType == L["Two-Handed Maces"] then
				self:AddLine(slotname.."_weapon                       mace")
			else
				self:AddLine(slotname.."_weapon                       -")
			end
		else
			-- regular item either trinket or totem
			self:AddLine(slotname.."               "..itemID)
		end
		if slotid == 16 then
			if itemID == "50035" then
				self:AddLine("necrotic_touch                  1")
				self:AddLine("necrotic_touch_heroic         0")
			elseif itemID == "50692" then
				self:AddLine("necrotic_touch                  0")
				self:AddLine("necrotic_touch_heroic         1")
			else
				self:AddLine("necrotic_touch                  0")
				self:AddLine("necrotic_touch_heroic         0")
			end
		end
	else
		self:AddLine(slotname.."               -")
	end
end

function SlamAndAwe:ExportRingProc()
	local itemID = self:GetItemID(11)
	self:DebugPrint("ring 1 :"..itemID)
	if itemID == "50401" or itemID == "50402" then
		self:AddLine("ring_proc                       ashen_verdict")
		return
	end
	itemID = self:GetItemID(12)
	self:DebugPrint("ring 2 :"..itemID)
	if itemID == "50401" or itemID == "50402" then
		self:AddLine("ring_proc                       ashen_verdict")
		return
	end
	self:AddLine("ring_proc                       -")
end

function SlamAndAwe:GetItemID(slot)
	local slotLink = GetInventoryItemLink("player", slot)
	local itemID = 0
	local itemSubType = "none"
	local itemName, itemString
	if slotLink then
		itemName, itemString, _, _, _, _, itemSubType = GetItemInfo(slotLink)
		_, itemID = strsplit(":", itemString)
		itemID = itemID or 0		
	end
	return itemID, itemSubType
end

function SlamAndAwe:GetWeaponDPS(slot)
	self:DebugPrint("Scanning tooltip for slot "..slot)
	if not self.vars.tooltip then
		self:CreateTooltip()
	end
	self.vars.tooltip:ClearLines()
	self.vars.tooltip:SetInventoryItem("player", slot)
	local dps = nil
	local maxlines = self.vars.tooltip:NumLines()
	if maxlines > 10 then maxlines = 10 end
	for i=1,maxlines do
		self:DebugPrint("line "..i.." contains:"..self.vars.Llines[i]:GetText())
		local _,_, dps = string.find(self.vars.Llines[i]:GetText(), L["DPS"])
		if dps and tonumber(dps) then
			return format("%.1f",dps)
		end
	end
	return "0.0 # unable to read weapon dps please check"
end

function SlamAndAwe:CheckIfBuffed()
	local index = 1
	local buffCount = 0
	while UnitBuff("PLAYER", index) do
		local name = UnitBuff("PLAYER", index)
		if name ~= C["Heroic Presence"] and name ~= C["Champion of the Kirin Tor"] then
			buffCount = buffCount + 1
		end
		index = index + 1
	end
	if buffCount > 0 then 
		return true
	else
		return false
	end
end

function SlamAndAwe:ExportGlyphs()
	local numglyphs = GetNumGlyphSockets()
	local prime = 0
	local major = 0
	local minor = 0
	self:AddLine(" ")
	for index = 1, numglyphs do
		local _, _, _, spellID = GetGlyphSocketInfo(index)
		if spellID then
			self:DebugPrint("found glyph "..index.." spell :"..spellID)
			if spellID == 63271 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    feral_spirit")
			elseif spellID == 55455 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    fire_elemental_totem")
			elseif spellID == 55447 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    flame_shock")
			elseif spellID == 55451 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    flametongue_weapon")
			elseif spellID == 55454 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    lava_burst")
			elseif spellID == 55444 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    lava_lash")
			elseif spellID == 55453 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    lightning_bolt")
			elseif spellID == 55442 then  
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    shocking")
			elseif spellID == 55446 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    stormstrike")
			elseif spellID == 55436 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    water_shield")
			elseif spellID == 55445 then
				prime = prime + 1
				self:AddLine("glyph_prime"..prime.."                    windfury_weapon")
			end
	
			--- Major Glyphs
			if spellID == 55449 then
				major = major + 1
				self:AddLine("glyph_major"..major.."                    chain_lightning")
			elseif spellID == 55452 then
				major = major + 1
				self:AddLine("glyph_major"..major.."                    elemental_mastery")
			elseif spellID == 55450 then
				major = major + 1
				self:AddLine("glyph_major"..major.."                    fire_nova")
			elseif spellID == 55448 then
				major = major + 1
				self:AddLine("glyph_major"..major.."                    lightning_shield")
			elseif spellID == 63270 then
				major = major + 1
				self:AddLine("glyph_major"..major.."                    thunder")
			elseif spellID == 55438 then
				major = major + 1
				self:AddLine("glyph_major"..major.."                    totemic_recall")
			end
		end
	end
	for index = prime + 1,3 do
		self:AddLine("glyph_prime"..index.."                    - ## slot empty")
	end
	self:AddLine(" ")

	for index = major + 1,3 do
		self:AddLine("glyph_major"..index.."                    - ## slot empty")
	end
	self:AddLine(" ")
	self:AddLine("glyph_minor1                    - ## no useful glyphs current implemented in the sim")
	self:AddLine("glyph_minor2                    - ## no useful glyphs current implemented in the sim")
	self:AddLine("glyph_minor3                    - ## no useful glyphs current implemented in the sim")
end

function SlamAndAwe:ExportArmourType()
	local allMailArmour = true
	local slots = { 1, --head
						3, --shoulder
						5, -- chest 
						6, -- waist
						7, -- legs
						8, -- feet
						9, -- wrist
						10, -- gloves
						}
	self:AddLine(" ")
	for index=1, 8 do
		local itemID, itemSubType = self:GetItemID(slots[index])
		if itemID and itemSubType then
			self:DebugPrint("checking slot : "..slots[index].." item :"..itemID.." type:"..itemSubType)
		end
		if itemSubType ~= "Mail" then 
			allMailArmour = false
		end
	end
	if allMailArmour then
		self:AddLine("armor_type_bonus         1")	
	else
		self:AddLine("armor_type_bonus         0")	
	end
end

function SlamAndAwe:IsEnhancement()
	return GetPrimaryTalentTree() == 2
end

function SlamAndAwe:ExportTalents()
	local currRank, maxRank
	self:AddLine(" ")
	self:AddLine(" ")
	self:AddLine("#############")
	self:AddLine("## Talents ##")
	self:AddLine("#############")
    self:AddLine(" ")
	if self:IsEnhancement() then
		self:AddLine("primary_talent                  enhancement")
	else
		self:AddLine("primary_talent                  elemental")
	end
	--nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(tree,index)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,1) -- Elemental Weapons
	self:AddLine("elemental_weapons               "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,2) -- Focused Strikes
	self:AddLine("focused_strikes                 "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,3) -- Improved Shields
	self:AddLine("improved_shields                "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,4) -- Elemental Devastation
	self:AddLine("elemental_devastation           "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,5) -- Flurry
	self:AddLine("flurry                          "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,10) -- Static Shock
	self:AddLine("static_shock                    "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,12) -- Improved Fire Nova
	self:AddLine("improved_fire_nova              "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,13) -- Searing Flames
	self:AddLine("searing_flames                  "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,15) -- Shamanistic Rage
	self:AddLine("shamanistic_rage                "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,16) -- Unleashed Rage
	self:AddLine("unleashed_rage                  "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,17) -- Maelstrom Weapon
	self:AddLine("maelstrom_weapon                "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(2,18) -- Imp.Lava Lash
	self:AddLine("improved_lava_lash              "..currRank.."/"..maxRank)
	self:AddLine(" ")
	self:AddLine(" ")
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,2) -- Convection
	self:AddLine("convection                      "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,3) -- Concussion
	self:AddLine("concussion                      "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,4) -- Call of Flame
	self:AddLine("call_of_flame                   "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,6) -- Reverberation
	self:AddLine("reverberation                   "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,7) -- Elemental Precision
	self:AddLine("elemental_precision             "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,9) -- Elemental Focus
	self:AddLine("elemental_focus                 "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,11) -- Elemental Oath
	self:AddLine("elemental_oath                  "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,12) -- Lava Flows
	self:AddLine("lava_flows                      "..currRank.."/"..maxRank)

	_, _, _, _, currRank, maxRank = GetTalentInfo(1,8) -- Elemental Mastery
	self:AddLine("elemental_mastery               "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,17) -- Feedback
	self:AddLine("feedback                        "..currRank.."/"..maxRank)
	_, _, _, _, currRank, maxRank = GetTalentInfo(1,18) -- Lava Surge
	self:AddLine("lava_surge                      "..currRank.."/"..maxRank)
end

function SlamAndAwe:ExportSetBonuses()
	local setnames = { "naxx_melee", "worldbreaker_battlegear", "t9_battlegear", "t10_battlegear" }
	local slots = { head = 1, shoulder = 3, chest = 5, legs = 7, gloves = 10 }
	local sets = {}
	for _, value in pairs(setnames) do
		sets[value] = 0
	end	
	local itemID = self:GetItemID(slots.head)
	self:DebugPrint("head slot :"..itemID..":")
	if itemID == "39602" or itemID == "40521" then
		sets["naxx_melee"] = sets["naxx_melee"] + 1
	elseif itemID == "45412" or itemID == "46212" then
		sets["worldbreaker_battlegear"] = sets["worldbreaker_battlegear"] + 1
	elseif itemID == "48368" or itemID == "48343" or itemID == "48363" or itemID == "48348" or itemID == "48358" or itemID == "48353" then 
		sets["t9_battlegear"] = sets["t9_battlegear"] + 1
	elseif itemID == "50832" or itemID == "51197" or itemID == "51242" then
		sets["t10_battlegear"] = sets["t10_battlegear"] + 1
	end
	
	local itemID = self:GetItemID(slots.shoulder)
	self:DebugPrint("shoulder slot :"..itemID)
	if itemID == "39604" or itemID == "40524" then
		sets["naxx_melee"] = sets["naxx_melee"] + 1
	elseif itemID == "45415" or itemID == "46203" then
		sets["worldbreaker_battlegear"] = sets["worldbreaker_battlegear"] + 1
	elseif itemID == "48370" or itemID == "48345" or itemID == "48361" or itemID == "48350" or itemID == "48360" or itemID == "48351" then 
		sets["t9_battlegear"] = sets["t9_battlegear"] + 1
	elseif itemID == "50834" or itemID == "51199" or itemID == "51240" then
		sets["t10_battlegear"] = sets["t10_battlegear"] + 1
	end
	
	local itemID = self:GetItemID(slots.chest)
	self:DebugPrint("chest slot :"..itemID)
	if itemID == "39597" or itemID == "40523" then
		sets["naxx_melee"] = sets["naxx_melee"] + 1
	elseif itemID == "45413" or itemID == "46205" then
		sets["worldbreaker_battlegear"] = sets["worldbreaker_battlegear"] + 1
	elseif itemID == "48366" or itemID == "48341" or itemID == "48365" or itemID == "48346" or itemID == "48356" or itemID == "48355" then 
		sets["t9_battlegear"] = sets["t9_battlegear"] + 1
	elseif itemID == "50830" or itemID == "51195" or itemID == "51244" then
		sets["t10_battlegear"] = sets["t10_battlegear"] + 1
	end
	
	local itemID = self:GetItemID(slots.legs)
	self:DebugPrint("legs slot :"..itemID)
	if itemID == "39603" or itemID == "40522" then
		sets["naxx_melee"] = sets["naxx_melee"] + 1
	elseif itemID == "45416" or itemID == "46208" then
		sets["worldbreaker_battlegear"] = sets["worldbreaker_battlegear"] + 1
	elseif itemID == "48369" or itemID == "48344" or itemID == "48362" or itemID == "48349" or itemID == "48359" or itemID == "48352" then 
		sets["t9_battlegear"] = sets["t9_battlegear"] + 1
	elseif itemID == "50833" or itemID == "51198" or itemID == "51241" then
		sets["t10_battlegear"] = sets["t10_battlegear"] + 1
	end
	
	local itemID = self:GetItemID(slots.gloves)
	self:DebugPrint("gloves slot :"..itemID)
	if itemID == "39601" or itemID == "40520" then
		sets["naxx_melee"] = sets["naxx_melee"] + 1
	elseif itemID == "45414" or itemID == "46200" then
		sets["worldbreaker_battlegear"] = sets["worldbreaker_battlegear"] + 1
	elseif itemID == "48367" or itemID == "48342" or itemID == "48364" or itemID == "48347" or itemID == "48357" or itemID == "48354" then 
		sets["t9_battlegear"] = sets["t9_battlegear"] + 1
	elseif itemID == "50831" or itemID == "51196" or itemID == "51243" then
		sets["t10_battlegear"] = sets["t10_battlegear"] + 1
	end
	self:DebugPrint("sets t10 = "..sets["t10_battlegear"]..", t9 = "..sets["t9_battlegear"]..", t8 = "..sets["worldbreaker_battlegear"]..", t7 = "..sets["naxx_melee"])
	local setnumber = 0
	if sets["t10_battlegear"] >=4 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      t10_battlegear_4")
	elseif sets["t10_battlegear"] >=2 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      t10_battlegear_2")
	end
	if sets["t9_battlegear"] >=4 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      t9_battlegear_4")
	elseif sets["t9_battlegear"] >=2 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      t9_battlegear_2")
	end
	if sets["worldbreaker_battlegear"] >=4 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      worldbreaker_battlegear_4")
	elseif sets["worldbreaker_battlegear"] >=2 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      worldbreaker_battlegear_2")
	end
	if sets["naxx_melee"] >=4 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      naxx_melee_4")
	elseif sets["naxx_melee"] >=2 then
		setnumber = setnumber + 1
		self:AddLine("set_bonus"..setnumber.."                      naxx_melee_2")
	end
	for index = setnumber + 1,3 do
		self:AddLine("set_bonus"..index.."                      -")
	end
end


function SlamAndAwe:GetMetaGemID()
	local slotLink = GetInventoryItemLink("player", 1) -- head slot item
	if slotLink then
		for index = 1,3 do
			local _, gemLink = GetItemGem(slotLink,index)
			if gemLink then
				local _, itemString, _, _, _, _, gemType = GetItemInfo(gemLink)
				if(gemType == "Meta") then
					local _, itemID = strsplit(":", itemString)
					if not itemID then
						itemID = "-"
					end
					return itemID
				end
			end
		end
	end
	return "-"
end

function SlamAndAwe:isAlchemist()
	local profession1, profession2 = GetProfessions()
	if strfind(GetProfessionInfo(profession1), L["Alchemy"]) or strfind(GetProfessionInfo(profession2), L["Alchemy"]) then
		return true
	end
	return false
end

function SlamAndAwe:DraeneiHitBuff()
	local _, race = UnitRace("player")
	if race == "Draenei" then
		return 1
	else
		return 0
	end
end

---------------------
-- tooltip scanning
---------------------

function SlamAndAwe:CreateTooltip()
	local tt = CreateFrame("GameTooltip")
	self.vars.tooltip = tt
	tt:SetOwner(UIParent, "ANCHOR_NONE")
	self.vars.Llines, self.vars.Rlines = {}, {}
	for i=1,30 do
		self.vars.Llines[i], self.vars.Rlines[i] = tt:CreateFontString(), tt:CreateFontString()
		self.vars.Llines[i]:SetFontObject(GameFontNormal)
		self.vars.Rlines[i]:SetFontObject(GameFontNormal)
		tt:AddFontStrings(self.vars.Llines[i], self.vars.Rlines[i])
	end
end

