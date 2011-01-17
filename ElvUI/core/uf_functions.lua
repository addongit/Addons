------------------------------------------------------------------------
--	UnitFrame Functions
------------------------------------------------------------------------
local ElvDB = ElvDB
local ElvCF = ElvCF
local ElvL = ElvL

ElvDB.LoadUFFunctions = function(layout)
	function ElvDB.SpawnMenu(self)
		local unit = self.unit:gsub("(.)", string.upper, 1)
		if self.unit == "targettarget" then return end
		if _G[unit.."FrameDropDown"] then
			ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
		elseif (self.unit:match("party")) then
			ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
		else
			FriendsDropDown.unit = self.unit
			FriendsDropDown.id = self.id
			FriendsDropDown.initialize = RaidFrameDropDown_Initialize
			ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
		end
	end

	local frameshown = true
	local unitlist = {}
	local function FadeFramesInOut(fade)
		for frames, unitlist in pairs(unitlist) do
			if not UnitExists(_G[unitlist].unit) then return end
			if fade == true then
				UIFrameFadeIn(_G[unitlist], 0.15)
			else
				UIFrameFadeOut(_G[unitlist], 0.15)
			end
		end
	end

	ElvDB.Fader = function(self, arg1, arg2)	
		if arg1 == "UNIT_HEALTH" and self.unit ~= arg2 then return end
		
		local unit = self.unit
		if arg2 == true then self = self:GetParent() end
		if not unitlist[tostring(self:GetName())] then tinsert(unitlist, tostring(self:GetName())) end
		
		local cur = UnitHealth("player")
		local max = UnitHealthMax("player")
		
		if (UnitCastingInfo("player") or UnitChannelInfo("player")) and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true	
		elseif cur ~= max and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true	
		elseif (UnitExists("target") or UnitExists("focus")) and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true	
		elseif arg1 == true and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true
		else
			if InCombatLockdown() and frameshown ~= true then
				FadeFramesInOut(true)
				frameshown = true	
			elseif not UnitExists("target") and not InCombatLockdown() and not UnitExists("focus") and (cur == max) and not (UnitCastingInfo("player") or UnitChannelInfo("player")) then
				FadeFramesInOut(false)
				frameshown = false
			end
		end
	end

	ElvDB.AuraFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)	
		local header = icon:GetParent():GetParent():GetParent():GetName()
		local inInstance, instanceType = IsInInstance()
		icon.owner = caster
		icon.isStealable = isStealable
		if header == "ElvuiHealR6R25" or (ElvCF["raidframes"].griddps == true and header == "ElvuiDPSR6R25") then 
			if inInstance and (instanceType == "pvp" or instanceType == "arena") then
				if DebuffWhiteList[name] or TargetPVPOnly[name] then
					return true
				else
					return false
				end
			else
				if header == "ElvuiHealR6R25" and DebuffHealerWhiteList[name] then
					return true
				elseif header == "ElvuiDPSR6R25" and DebuffDPSWhiteList[name] then
					return true
				else
					return false
				end
			end	
		elseif (unit and unit:find("arena%d")) then --Arena frames
			if dtype then
				if DebuffWhiteList[name] then
					return true
				else
					return false
				end			
			else
				if ArenaBuffWhiteList[name] then
					return true
				else
					return false
				end		
			end
		elseif unit == "target" then --Target Only
			if ElvCF["auras"].playerdebuffsonly == true then
				-- Show all debuffs on friendly targets
				if UnitIsFriend("player", "target") then return true end
				
				local isPlayer
				
				if(caster == 'player' or caster == 'vehicle') then
					isPlayer = true
				else
					isPlayer = false
				end

				if isPlayer then
					return true
				elseif DebuffWhiteList[name] or (inInstance and ((instanceType == "pvp" or instanceType == "arena") and TargetPVPOnly[name])) then
					return true
				else
					return false
				end
			else
				return true
			end
		else --Everything else
			if unit ~= "player" and unit ~= "targettarget" and unit ~= "focus" and ElvCF["auras"].arenadebuffs == true and inInstance and (instanceType == "pvp" or instanceType == "arena") then
				if DebuffWhiteList[name] or TargetPVPOnly[name] then
					return true
				else
					return false
				end
			else
				if DebuffBlacklist[name] then
					return false
				else
					return true
				end
			end
		end
	end

	ElvDB.PostUpdateHealth = function(health, unit, min, max)
		local header = health:GetParent():GetParent():GetName()

		if ElvCF["general"].classcolortheme == true then
			local r, g, b = health:GetStatusBarColor()
			health:GetParent().FrameBorder:SetBackdropBorderColor(r,g,b)
			
			if health:GetParent().PowerFrame then
				health:GetParent().PowerFrame:SetBackdropBorderColor(r,g,b)
			end
			
			if unit == "target" then
				if health:GetParent().CPoints.FrameBackdrop then
					health:GetParent().CPoints.FrameBackdrop:SetBackdropBorderColor(r,g,b)
				end
			elseif unit and unit:find("boss%d") then
				if health:GetParent().AltPowerBar.FrameBackdrop then
					health:GetParent().AltPowerBar.FrameBackdrop:SetBackdropBorderColor(r,g,b)
				end
			elseif unit and unit:find("arena%d") then
				if health:GetParent().Trinketbg then
					health:GetParent().Trinketbg:SetBackdropBorderColor(r,g,b)
				end
			end
		end
		
		--Setup color health by value option
		if ElvCF["unitframes"].healthcolorbyvalue == true then
			if (UnitIsTapped("target")) and (not UnitIsTappedByPlayer("target")) and unit == "target" then
				health:SetStatusBarColor(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 1)
				health.bg:SetTexture(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 0.3)		
			elseif not UnitIsConnected(unit) then
				health:SetStatusBarColor(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 1)
				health.bg:SetTexture(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 0.3)				
			else
				local perc = (min/max)*100
				if(perc <= 50 and perc >= 26) then
					health:SetStatusBarColor(224/255, 221/255, 9/255, 1)
					health.bg:SetTexture(224/255, 221/255, 9/255, 0.1)
				elseif(perc < 26) then
					health:SetStatusBarColor(255/255, 13/255, 9/255, 1)
					health.bg:SetTexture(255/255, 13/255, 9/255, 0.1)
				else
					if ElvCF["unitframes"].classcolor ~= true then
						health:SetStatusBarColor(unpack(ElvCF["unitframes"].healthcolor))
						health.bg:SetTexture(unpack(ElvCF["unitframes"].healthbackdropcolor))		
					else
						if (UnitIsPlayer(unit)) then
							local class = select(2, UnitClass(unit))
							if not class then return end
							local c = ElvDB.oUF_colors.class[class]
							health:SetStatusBarColor(c[1], c[2], c[3], 1)
							health.bg:SetTexture(c[1], c[2], c[3], 0.3)	
						else
							local reaction = UnitReaction(unit, 'player')
							if not reaction then return end
							local c = ElvDB.oUF_colors.reaction[reaction]
							health:SetStatusBarColor(c[1], c[2], c[3], 1)
							health.bg:SetTexture(c[1], c[2], c[3], 0.3)						
						end
					end
				end
			end
		else
			if (UnitIsTapped("target")) and (not UnitIsTappedByPlayer("target")) and unit == "target" then
				health:SetStatusBarColor(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 1)
				health.bg:SetTexture(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 0.3)		
			elseif not UnitIsConnected(unit) then
				health:SetStatusBarColor(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 1)
				health.bg:SetTexture(ElvDB.oUF_colors.tapped[1], ElvDB.oUF_colors.tapped[2], ElvDB.oUF_colors.tapped[3], 0.3)						
			else
				if ElvCF["unitframes"].classcolor ~= true then
					health:SetStatusBarColor(unpack(ElvCF["unitframes"].healthcolor))
					health.bg:SetTexture(unpack(ElvCF["unitframes"].healthbackdropcolor))		
				else		
					if (UnitIsPlayer(unit)) then
						local class = select(2, UnitClass(unit))
						if not class then return end
						local c = ElvDB.oUF_colors.class[class]
						health:SetStatusBarColor(c[1], c[2], c[3], 1)
						health.bg:SetTexture(c[1], c[2], c[3], 0.3)	
					else
						local reaction = UnitReaction(unit, 'player')
						if not reaction then return end
						local c = ElvDB.oUF_colors.reaction[reaction]
						health:SetStatusBarColor(c[1], c[2], c[3], 1)
						health.bg:SetTexture(c[1], c[2], c[3], 0.3)						
					end			
				end
			end
		end
		
		--Small frames don't have health value display
		if not health.value then return end
		
		if header == "ElvuiHealParty" or header == "ElvuiDPSParty" or header == "ElvuiHealR6R25" or header == "ElvuiDPSR6R25" or header == "ElvuiHealR26R40" or header == "ElvuiDPSR26R40" then --Raid/Party Layouts
			if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
				if not UnitIsConnected(unit) then
					health.value:SetText("|cffD7BEA5"..ElvL.unitframes_ouf_offline.."|r")
				elseif UnitIsDead(unit) then
					health.value:SetText("|cffD7BEA5"..ElvL.unitframes_ouf_dead.."|r")
				elseif UnitIsGhost(unit) then
					health.value:SetText("|cffD7BEA5"..ElvL.unitframes_ouf_ghost.."|r")
				end
			else
				if min ~= max and ElvCF["raidframes"].healthdeficit == true then
					health.value:SetText("|cff559655-"..ElvDB.ShortValueNegative(max-min).."|r")
				else
					health.value:SetText("")
				end
			end
			if (header == "ElvuiHealR6R25" or header == "ElvuiDPSR6R25" or header == "ElvuiHealR26R40" or header == "ElvuiDPSR26R40") and ElvCF["raidframes"].hidenonmana == true then
				local powertype, _ = UnitPowerType(unit)
				if powertype ~= SPELL_POWER_MANA then
					health:SetHeight(health:GetParent():GetHeight())
				else
					if header == "ElvuiHealR6R25" then
						health:SetHeight(health:GetParent():GetHeight() * 0.85)
					elseif header == "ElvuiDPSR6R25" then
						if ElvCF["raidframes"].griddps ~= true then
							health:SetHeight(health:GetParent():GetHeight() * 0.75)
						else
							health:SetHeight(health:GetParent():GetHeight() * 0.83)
						end
					else
						health:SetHeight(health:GetParent():GetHeight())	
					end
				end	
			end		
		else
			if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
				if not UnitIsConnected(unit) then
					health.value:SetText("|cffD7BEA5"..ElvL.unitframes_ouf_offline.."|r")
				elseif UnitIsDead(unit) then
					health.value:SetText("|cffD7BEA5"..ElvL.unitframes_ouf_dead.."|r")
				elseif UnitIsGhost(unit) then
					health.value:SetText("|cffD7BEA5"..ElvL.unitframes_ouf_ghost.."|r")
				end
			else
				if min ~= max then
					local r, g, b
					r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
					if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
						if ElvCF["unitframes"].showtotalhpmp == true then
							health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", ElvDB.ShortValue(min), ElvDB.ShortValue(max))
						else
							health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", ElvDB.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
						end
					elseif unit == "target" or unit == "focus" or (unit and unit:find("boss%d")) then
						if ElvCF["unitframes"].showtotalhpmp == true then
							health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", ElvDB.ShortValue(min), ElvDB.ShortValue(max))
						else
							health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", ElvDB.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
						end
					elseif (unit and unit:find("arena%d")) then
						health.value:SetText("|cff559655"..ElvDB.ShortValue(min).."|r")
					else
						health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", ElvDB.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
					end
				else
					if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
						health.value:SetText("|cff559655"..ElvDB.ShortValue(max).."|r")
					elseif unit == "target" or unit == "focus" or (unit and unit:find("arena%d")) then
						health.value:SetText("|cff559655"..ElvDB.ShortValue(max).."|r")
					else
						health.value:SetText("|cff559655"..ElvDB.ShortValue(max).."|r")
					end
				end
			end
		end
	end

	ElvDB.CheckPower = function(self, event)
		local unit = self.unit
		local powertype, _ = UnitPowerType(unit)
		if powertype ~= SPELL_POWER_MANA then
			self.Health:SetHeight(self.Health:GetParent():GetHeight())
			if self.Power then
				self.Power:Hide()
			end
		else
			if IsAddOnLoaded("ElvUI_Heal_Layout") and self:GetParent():GetName() == "ElvuiHealR6R25" then
					self.Health:SetHeight(self.Health:GetParent():GetHeight() * 0.85)
			elseif self:GetParent():GetName() == "ElvuiDPSR6R25" then
				if ElvCF["raidframes"].griddps ~= true then
					self.Health:SetHeight(self.Health:GetParent():GetHeight() * 0.75)
				else
					self.Health:SetHeight(self.Health:GetParent():GetHeight() * 0.83)
				end
			else
				self.Health:SetHeight(self.Health:GetParent():GetHeight())	
			end
			if self.Power then
				self.Power:Show()
			end
		end	
	end

	ElvDB.PostNamePosition = function(self)
		self.Name:ClearAllPoints()
		if (self.Power.value:GetText() and UnitIsPlayer("target") and ElvCF["unitframes"].targetpowerplayeronly == true) or (self.Power.value:GetText() and ElvCF["unitframes"].targetpowerplayeronly == false) then
			self.Name:SetPoint("CENTER", self.health, "CENTER", 0, 1)
		else
			self.Power.value:SetAlpha(0)
			self.Name:SetPoint("LEFT", self.health, "LEFT", 4, 1)
		end
	end

	ElvDB.PreUpdatePower = function(power, unit)
		local _, pType = UnitPowerType(unit)
		
		local color = ElvDB.oUF_colors.power[pType]
		if color then
			power:SetStatusBarColor(color[1], color[2], color[3])
		end
	end
	
	ElvDB.PostUpdatePower = function(power, unit, min, max)
		local self = power:GetParent()
		local header = power:GetParent():GetParent():GetName()
		local pType, pToken, altR, altG, altB = UnitPowerType(unit)
		local color = ElvDB.oUF_colors.power[pToken]
		
		if header == "ElvuiDPSR6R25" or header == "ElvuiHealR6R25" then
			if pType ~= SPELL_POWER_MANA then
				power:Hide()
			else
				power:Show()
			end
		end
		
		if not power.value then return end
		
		if color then
			power.value:SetTextColor(color[1], color[2], color[3])
		else
			power.value:SetTextColor(altR, altG, altB, 1)
		end	
			
		if min == 0 then 
			power.value:SetText("") 
			if (unit and unit:find("boss%d")) then
				self.Health.value:ClearAllPoints()
				self.Health.value:SetPoint("LEFT", self.Health, "LEFT", ElvDB.Scale(2), ElvDB.Scale(1))
			end
		else
			if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) and not (unit and unit:find("boss%d")) then
				power.value:SetText()
			elseif UnitIsDead(unit) or UnitIsGhost(unit) then
				power.value:SetText()
			else
				if min ~= max then
					if pType == 0 then
						if unit == "target" then
							if ElvCF["unitframes"].showtotalhpmp == true then
								power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ElvDB.ShortValue(max - (max - min)), ElvDB.ShortValue(max))
							else
								power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), ElvDB.ShortValue(max - (max - min)))
							end
						elseif unit == "player" and self:GetAttribute("normalUnit") == "pet" or unit == "pet" then
							if ElvCF["unitframes"].showtotalhpmp == true then
								power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ElvDB.ShortValue(max - (max - min)), ElvDB.ShortValue(max))
							else
								power.value:SetFormattedText("%d%%", floor(min / max * 100))
							end
						elseif (unit and unit:find("arena%d")) then
							power.value:SetText(ElvDB.ShortValue(min))
						elseif (unit and unit:find("boss%d")) then
							if ElvCF["unitframes"].showtotalhpmp == true then
								power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ElvDB.ShortValue(max), ElvDB.ShortValue(max - (max - min)))
							else
								power.value:SetFormattedText("%s |cffD7BEA5-|r %d%%", ElvDB.ShortValue(max - (max - min)), floor(min / max * 100))
							end		
							self.Health.value:ClearAllPoints()
							self.Health.value:SetPoint("TOPLEFT", self.Health, "TOPLEFT", ElvDB.Scale(2), ElvDB.Scale(-2))						
						else
							if ElvCF["unitframes"].showtotalhpmp == true then
								power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ElvDB.ShortValue(max - (max - min)), ElvDB.ShortValue(max))
							else
								power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), ElvDB.ShortValue(max - (max - min)))
							end
						end
					else
						power.value:SetText(max - (max - min))
					end
				else
					if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) then
						power.value:SetText(ElvDB.ShortValue(min))
					else
						power.value:SetText(ElvDB.ShortValue(min))
					end
				end
			end
		end
		
		if self.Name then
			if unit == "target" then ElvDB.PostNamePosition(self, power) end
		end
	end

	ElvDB.CustomCastTimeText = function(self, duration)
		self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
	end

	ElvDB.CustomCastDelayText = function(self, duration)
		self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
	end

	local FormatTime = function(s)
		local day, hour, minute = 86400, 3600, 60
		if s >= day then
			return format("%dd", ceil(s / hour))
		elseif s >= hour then
			return format("%dh", ceil(s / hour))
		elseif s >= minute then
			return format("%dm", ceil(s / minute))
		elseif s >= minute / 12 then
			return floor(s)
		end
		return format("%.1f", s)
	end

	local CreateAuraTimer = function(self, elapsed)	
		if self.timeLeft then
			self.elapsed = (self.elapsed or 0) + elapsed
			if self.elapsed >= 0.1 then
				if not self.first then
					self.timeLeft = self.timeLeft - self.elapsed
				else
					self.timeLeft = self.timeLeft - GetTime()
					self.first = false
				end
				if self.timeLeft > 0 then
					local time = FormatTime(self.timeLeft)
					self.remaining:SetText(time)
					if self.timeLeft <= 5 then
						self.remaining:SetTextColor(0.99, 0.31, 0.31)
					else
						self.remaining:SetTextColor(1, 1, 1)
					end
				else
					self.remaining:Hide()
					self:SetScript("OnUpdate", nil)
				end
				if (not self.debuff) and ElvCF["general"].classcolortheme == true then
					local r, g, b = self:GetParent():GetParent().FrameBorder:GetBackdropBorderColor()
					self:SetBackdropBorderColor(r, g, b)
				end
				self.elapsed = 0
			end
		end
	end

	function ElvDB.PvPUpdate(self, elapsed)
		if(self.elapsed and self.elapsed > 0.2) then
			local unit = self.unit
			local time = GetPVPTimer()
			
			local min = format("%01.f", floor((time/1000)/60))
			local sec = format("%02.f", floor((time/1000) - min *60)) 
			if(self.PvP) then
				local factionGroup = UnitFactionGroup(unit)
				if(UnitIsPVPFreeForAll(unit)) then
					if time ~= 301000 and time ~= -1 then
						self.PvP:SetText(PVP.." ".."("..min..":"..sec..")")
					else
						self.PvP:SetText(PVP)
					end
				elseif(factionGroup and UnitIsPVP(unit)) then
					if time ~= 301000 and time ~= -1 then
						self.PvP:SetText(PVP.." ".."("..min..":"..sec..")")
					else
						self.PvP:SetText(PVP)
					end
				else
					self.PvP:SetText("")
				end
			end
			self.elapsed = 0
		else
			self.elapsed = (self.elapsed or 0) + elapsed
		end
	end

	function ElvDB.PostCreateAura(element, button)
		local unit = button:GetParent():GetParent().unit
		local header = button:GetParent():GetParent():GetParent():GetName()
		
		if header == "ElvuiHealR6R25" or (header == "ElvuiDPSR6R25" and ElvCF["raidframes"].griddps == true) then
			button:EnableMouse(false)
			button:SetFrameLevel(button:GetParent():GetParent().Power:GetFrameLevel() + 4)
		end
		
		if unit == "focus" or unit == "targettarget" or header == "ElvuiHealR6R25" or header == "ElvuiDPSR6R25" or header == "ElvuiHealParty" then
			button.remaining = ElvDB.SetFontString(button, ElvCF["media"].font, ElvCF["auras"].auratextscale*0.85, "THINOUTLINE")
		else
			button.remaining = ElvDB.SetFontString(button, ElvCF["media"].font, ElvCF["auras"].auratextscale, "THINOUTLINE")
		end
		
		ElvDB.SetTemplate(button)
		button.remaining:SetPoint("CENTER", ElvDB.Scale(0), ElvDB.mult)
		
		button.cd.noOCC = true		 	-- hide OmniCC CDs
		button.cd.noCooldownCount = true	-- hide CDC CDs
		
		button.cd:SetReverse()
		button.icon:SetPoint("TOPLEFT", ElvDB.Scale(2), ElvDB.Scale(-2))
		button.icon:SetPoint("BOTTOMRIGHT", ElvDB.Scale(-2), ElvDB.Scale(2))
		button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		button.icon:SetDrawLayer('ARTWORK')
		
		button.count:SetPoint("BOTTOMRIGHT", ElvDB.mult, ElvDB.Scale(1.5))
		button.count:SetJustifyH("RIGHT")
		button.count:SetFont(ElvCF["media"].font, ElvCF["auras"].auratextscale*0.8, "THINOUTLINE")

		button.overlayFrame = CreateFrame("frame", nil, button, nil)
		button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
		button.cd:ClearAllPoints()
		button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", ElvDB.Scale(2), ElvDB.Scale(-2))
		button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", ElvDB.Scale(-2), ElvDB.Scale(2))
		button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 2)	   
		button.overlay:SetParent(button.overlayFrame)
		button.count:SetParent(button.overlayFrame)
		button.remaining:SetParent(button.overlayFrame)
		
		local highlight = button:CreateTexture(nil, "HIGHLIGHT")
		highlight:SetTexture(1,1,1,0.45)
		highlight:SetAllPoints(button.icon)	
	end

	function ElvDB.PostUpdateAura(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
		local name, _, _, _, dtype, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)
		
		if(icon.debuff) then
			if(not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle") and (not DebuffWhiteList[name]) then
				icon:SetBackdropBorderColor(unpack(ElvCF["media"].bordercolor))
				icon.icon:SetDesaturated(true)
			else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				if (name == "Unstable Affliction" or name == "Vampiric Touch") and ElvDB.myclass ~= "WARLOCK" then
					icon:SetBackdropBorderColor(0.05, 0.85, 0.94)
				else
					icon:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
				end
				icon.icon:SetDesaturated(false)
			end
		else
			if (icon.isStealable or (ElvDB.myclass == "PRIEST" and dtype == "Magic")) and not UnitIsFriend("player", unit) then
				icon:SetBackdropBorderColor(237/255, 234/255, 142/255)
			else
				if ElvCF["general"].classcolortheme == true then
					local r, g, b = icon:GetParent():GetParent().FrameBorder:GetBackdropBorderColor()
					icon:SetBackdropBorderColor(r, g, b)
				else
					icon:SetBackdropBorderColor(unpack(ElvCF["media"].bordercolor))
				end			
			end
		end
		
		if duration and duration > 0 then
			if ElvCF["auras"].auratimer == true then
				icon.remaining:Show()
			else
				icon.remaining:Hide()
			end
		else
			icon.remaining:Hide()
		end
		
		icon.duration = duration
		icon.timeLeft = expirationTime
		icon.first = true
		icon:SetScript("OnUpdate", CreateAuraTimer)
	end

	ElvDB.HidePortrait = function(self, event)
		if self.unit == "target" then
			if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
				self.PFrame:SetAlpha(0)
			else
				self.PFrame:SetAlpha(1)
			end
		end
	end

	ElvDB.PostCastStart = function(self, unit, name, rank, castid)
		if unit == "vehicle" then unit = "player" end
		--Fix blank castbar with opening text
		if name == "Opening" then
			self.Text:SetText(OPENING)
		else
			self.Text:SetText(string.sub(name, 0, 25))
		end
		
		if self.interrupt and unit ~= "player" then
			if UnitCanAttack("player", unit) then
				self:SetStatusBarColor(unpack(ElvCF["castbar"].nointerruptcolor))
			else
				self:SetStatusBarColor(unpack(ElvCF["castbar"].castbarcolor))	
			end
		else
			if ElvCF["castbar"].classcolor ~= true or unit ~= "player" then
				self:SetStatusBarColor(unpack(ElvCF["castbar"].castbarcolor))
			else
				self:SetStatusBarColor(unpack(oUF.colors.class[select(2, UnitClass(unit))]))
			end	
		end
	end

	ElvDB.UpdateShards = function(self, event, unit, powerType)
		if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end
		local num = UnitPower(unit, SPELL_POWER_SOUL_SHARDS)
		for i = 1, SHARD_BAR_NUM_SHARDS do
			if(i <= num) then
				self.SoulShards[i]:SetAlpha(1)
			else
				self.SoulShards[i]:SetAlpha(.2)
			end
		end
	end

	ElvDB.UpdateHoly = function(self, event, unit, powerType)
		if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end
		local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
		for i = 1, MAX_HOLY_POWER do
			if(i <= num) then
				self.HolyPower[i]:SetAlpha(1)
			else
				self.HolyPower[i]:SetAlpha(.2)
			end
		end
	end

	ElvDB.MoveBuffs = function(self, login)
		local parent = self:GetParent()
		if login then
			self:SetScript("OnUpdate", nil)
		end
		
		if self:IsShown() then
			if self == parent.EclipseBar then
				parent.FlashInfo:Hide()
				parent.PvP:SetAlpha(0)
			end
			parent.FrameBorder.shadow:SetPoint("TOPLEFT", ElvDB.Scale(-4), ElvDB.Scale(17))
			
			if (IsAddOnLoaded("ElvUI_Dps_Layout") and DPSElementsCharPos and DPSElementsCharPos["DPSPlayerBuffs"] and DPSElementsCharPos["DPSPlayerBuffs"]["moved"] == true) then return end
			if (IsAddOnLoaded("ElvUI_Heal_Layout") and HealElementsCharPos and HealElementsCharPos["HealPlayerBuffs"] and HealElementsCharPos["HealPlayerBuffs"]["moved"] == true) then return end
			if (IsAddOnLoaded("ElvUI_Dps_Layout") and DPSElementsCharPos and DPSElementsCharPos["DPSPlayerDebuffs"] and DPSElementsCharPos["DPSPlayerDebuffs"]["moved"] == true) then return end
			if (IsAddOnLoaded("ElvUI_Heal_Layout") and HealElementsCharPos and HealElementsCharPos["HealPlayerDebuffs"] and HealElementsCharPos["HealPlayerDebuffs"]["moved"] == true) then return end
			
			if parent.Debuffs then 
				parent.Debuffs:ClearAllPoints()
				if parent.Debuffs then parent.Debuffs:SetPoint("BOTTOM", parent.Health, "TOP", 0, ElvDB.Scale(17)) end	
			end		
		else
			if self == parent.EclipseBar then
				parent.FlashInfo:Show()
				parent.PvP:SetAlpha(1)
			end
			parent.FrameBorder.shadow:SetPoint("TOPLEFT", ElvDB.Scale(-4), ElvDB.Scale(4))
			
			if (IsAddOnLoaded("ElvUI_Dps_Layout") and DPSElementsCharPos and DPSElementsCharPos["DPSPlayerBuffs"] and DPSElementsCharPos["DPSPlayerBuffs"]["moved"] == true) then return end
			if (IsAddOnLoaded("ElvUI_Heal_Layout") and HealElementsCharPos and HealElementsCharPos["HealPlayerBuffs"] and HealElementsCharPos["HealPlayerBuffs"]["moved"] == true) then return end
			if (IsAddOnLoaded("ElvUI_Dps_Layout") and DPSElementsCharPos and DPSElementsCharPos["DPSPlayerDebuffs"] and DPSElementsCharPos["DPSPlayerDebuffs"]["moved"] == true) then return end
			if (IsAddOnLoaded("ElvUI_Heal_Layout") and HealElementsCharPos and HealElementsCharPos["HealPlayerDebuffs"] and HealElementsCharPos["HealPlayerDebuffs"]["moved"] == true) then return end
			
			if parent.Debuffs then 
				parent.Debuffs:ClearAllPoints()
				parent.Debuffs:SetPoint("BOTTOM", parent.Health, "TOP", 0, ElvDB.Scale(6))
			end	
		end
	end

	local starfirename = select(1, GetSpellInfo(2912))
	ElvDB.EclipseDirection = function(self)
		if ( GetEclipseDirection() == "sun" ) then
			self.Text:SetText(starfirename.."!")
			self.Text:SetTextColor(.2,.2,1,1)
		elseif ( GetEclipseDirection() == "moon" ) then
			self.Text:SetText(POWER_TYPE_WRATH.."!")
			self.Text:SetTextColor(1,1,.3, 1)
		else
			self.Text:SetText("")
		end
	end

	ElvDB.ToggleBars = function(self)
		local parent = self:GetParent()
		local unit = parent.unit
		if unit == "vehicle" then unit = "player" end
		if unit ~= "player" then return end
		
		if IsAddOnLoaded("ElvUI_Dps_Layout") then
			Elv_player = ElvDPS_player
		elseif IsAddOnLoaded("ElvUI_Heal_Layout") then
			Elv_player = ElvHeal_player
		end
		
		if self == Elv_player.EclipseBar and (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then 
			Elv_player.EclipseBar:SetScript("OnUpdate", function() 
				if (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then
					if Elv_player.EclipseBar:IsShown() then
						Elv_player.EclipseBar:Hide()
						Elv_player.EclipseBar:SetScript("OnUpdate", nil)
					end
				else
					Elv_player.EclipseBar:Show()
					Elv_player.EclipseBar:SetScript("OnUpdate", nil)			
				end
			end) 
			return 
		end
		
		if UnitHasVehicleUI("player") then
			self:Hide()
		else	
			self:Show()
		end
	end

	ElvDB.ComboDisplay = function(self, event, unit)
		if(unit == 'pet') then return end
		
		local cpoints = self.CPoints
		local cp
		if (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then
			cp = GetComboPoints('vehicle', 'target')
		else
			cp = GetComboPoints('player', 'target')
		end

		for i=1, MAX_COMBO_POINTS do
			if(i <= cp) then
				cpoints[i]:SetAlpha(1)
			else
				cpoints[i]:SetAlpha(0.15)
			end
		end
		
		if cpoints[1]:GetAlpha() == 1 then
			for i=1, MAX_COMBO_POINTS do
				cpoints[i]:Show()
			end
			if (IsAddOnLoaded("ElvUI_Dps_Layout") and DPSElementsCharPos and ((DPSElementsCharPos["DPSComboBar"] and DPSElementsCharPos["DPSComboBar"]["moved"] == true) or (DPSElementsCharPos["DPSTargetBuffs"] and DPSElementsCharPos["DPSTargetBuffs"]["moved"] == true))) then return end
			if (IsAddOnLoaded("ElvUI_Heal_Layout") and HealElementsCharPos and ((HealElementsCharPos["HealComboBar"] and HealElementsCharPos["HealComboBar"]["moved"] == true) or (HealElementsCharPos["HealTargetBuffs"] and HealElementsCharPos["HealTargetBuffs"]["moved"] == true))) then return end
			self.FrameBorder.shadow:SetPoint("TOPLEFT", ElvDB.Scale(-4), ElvDB.Scale(17))
			if self.Buffs then self.Buffs:ClearAllPoints() self.Buffs:SetPoint("BOTTOM", self.Health, "TOP", 0, ElvDB.Scale(17)) end	
		else
			for i=1, MAX_COMBO_POINTS do
				cpoints[i]:Hide()
			end
			if (IsAddOnLoaded("ElvUI_Dps_Layout") and DPSElementsCharPos and ((DPSElementsCharPos["DPSComboBar"] and DPSElementsCharPos["DPSComboBar"]["moved"] == true) or (DPSElementsCharPos["DPSTargetBuffs"] and DPSElementsCharPos["DPSTargetBuffs"]["moved"] == true))) then return end
			if (IsAddOnLoaded("ElvUI_Heal_Layout") and HealElementsCharPos and ((HealElementsCharPos["HealComboBar"] and HealElementsCharPos["HealComboBar"]["moved"] == true) or (HealElementsCharPos["HealTargetBuffs"] and HealElementsCharPos["HealTargetBuffs"]["moved"] == true))) then return end
			self.FrameBorder.shadow:SetPoint("TOPLEFT", ElvDB.Scale(-4), ElvDB.Scale(4))	
			if self.Buffs then self.Buffs:ClearAllPoints() self.Buffs:SetPoint("BOTTOM", self.Health, "TOP", 0, ElvDB.Scale(4)) end	
		end
	end

	ElvDB.MLAnchorUpdate = function (self)
		if self.Leader:IsShown() then
			self.MasterLooter:SetPoint("TOPLEFT", 14, 8)
		else
			self.MasterLooter:SetPoint("TOPLEFT", 2, 8)
		end
	end

	ElvDB.RestingIconUpdate = function (self)
		if IsResting() then
			self.Resting:Show()
		else
			self.Resting:Hide()
		end
	end

	ElvDB.UpdateReputation = function(self, event, unit, bar, min, max, value, name, id)
		if not name then return end
		local name, id = GetWatchedFactionInfo()
		bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
		
		local cur = value - min
		local total = max - min
		
		bar.Text:SetFormattedText(name..': '..ElvDB.ShortValue(cur)..' / '..ElvDB.ShortValue(total)..' <%d%%>', (cur / total) * 100)
	end

	local delay = 0
	ElvDB.UpdateManaLevel = function(self, elapsed)
		delay = delay + elapsed
		if self.parent.unit ~= "player" or delay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
		delay = 0

		local percMana = UnitMana("player") / UnitManaMax("player") * 100

		if percMana <= 20 then
			self.ManaLevel:SetText("|cffaf5050"..ElvL.unitframes_ouf_lowmana.."|r")
			ElvDB.Flash(self, 0.3)
		else
			self.ManaLevel:SetText()
			ElvDB.StopFlash(self)
		end
	end

	ElvDB.UpdateDruidMana = function(self)
		if self.unit ~= "player" then return end

		local num, str = UnitPowerType("player")
		if num ~= 0 then
			local min = UnitPower("player", 0)
			local max = UnitPowerMax("player", 0)

			local percMana = min / max * 100
			if percMana <= ElvCF["unitframes"].lowThreshold then
				self.FlashInfo.ManaLevel:SetText("|cffaf5050"..ElvL.unitframes_ouf_lowmana.."|r")
				ElvDB.Flash(self.FlashInfo, 0.3)
			else
				self.FlashInfo.ManaLevel:SetText()
				ElvDB.StopFlash(self.FlashInfo)
			end

			if min ~= max then
				if self.Power.value:GetText() then
					self.DruidMana:SetPoint("LEFT", self.Power.value, "RIGHT", -3, 0)
					self.DruidMana:SetFormattedText("|cffD7BEA5-|r %d%%|r", floor(min / max * 100))
				else
					self.DruidMana:SetPoint("LEFT", self.Health, "LEFT", 4, 1)
					self.DruidMana:SetFormattedText("%d%%", floor(min / max * 100))
				end
			else
				self.DruidMana:SetText()
			end

			self.DruidMana:SetAlpha(1)
		else
			self.DruidMana:SetAlpha(0)
		end
	end

	function ElvDB.UpdateThreat(self, event, unit)
		if (self.unit ~= unit) or (unit == "target" or unit == "focus" or unit == "focustarget" or unit == "targettarget") then return end
		if not self.unit then return end
		if not unit then return end
		
		local threat = UnitThreatSituation(self.unit)
		if threat and threat > 1 then
			local r, g, b = GetThreatStatusColor(threat)
			if self.FrameBorder.shadow then
				self.FrameBorder.shadow:SetBackdropBorderColor(r,g,b,0.85)
				if self.PowerFrame and self.PowerFrame.shadow then
					self.PowerFrame.shadow:SetBackdropBorderColor(r,g,b,0.85)
				end
				if self.PFrame and self.PFrame.shadow then
					self.PFrame.shadow:SetBackdropBorderColor(r, g, b, 1)
				end
			else
				if self.HealthBorder then
					self.HealthBorder:SetBackdropBorderColor(r, g, b, 1)
				end
				if self.PFrame then
					self.PFrame:SetBackdropBorderColor(r, g, b, 1)
				end
				self.FrameBorder:SetBackdropBorderColor(r, g, b, 1)
			end
		else
			if self.FrameBorder.shadow then
				self.FrameBorder.shadow:SetBackdropBorderColor(0,0,0,0.75)
				if self.PowerFrame and self.PowerFrame.shadow then
					self.PowerFrame.shadow:SetBackdropBorderColor(0,0,0,0.75)
				end
				if self.PFrame and self.PFrame.shadow then
					self.PFrame.shadow:SetBackdropBorderColor(0, 0, 0, 1)
				end
			else
				self.FrameBorder:SetBackdropBorderColor(unpack(ElvCF["media"].altbordercolor))
				if self.HealthBorder then
					self.HealthBorder:SetBackdropBorderColor(unpack(ElvCF["media"].altbordercolor))
				end
				if self.PFrame then
					self.PFrame:SetBackdropBorderColor(unpack(ElvCF["media"].altbordercolor))
				end
			end
		end 
	end

	ElvDB.updateAllElements = function(frame)
		for _, v in ipairs(frame.__elements) do
			v(frame, "UpdateElement", frame.unit)
		end
		
		local header = frame:GetParent():GetName()
		if (header == "ElvuiDPSR6R25" or header == "ElvuiHealR6R25") and ElvCF["raidframes"].hidenonmana == true then
			local powertype, _ = UnitPowerType(frame.unit)
			if powertype ~= SPELL_POWER_MANA then
				frame.Health:SetHeight(frame.Health:GetParent():GetHeight())
				if frame.Power then
					frame.Power:Hide()
				end
			else
				if IsAddOnLoaded("ElvUI_Heal_Layout") and frame:GetParent():GetName() == "ElvuiHealR6R25" then
					frame.Health:SetHeight(frame.Health:GetParent():GetHeight() * 0.85)
				elseif frame:GetParent():GetName() == "ElvuiDPSR6R25" then
					if ElvCF["raidframes"].griddps ~= true then
						frame.Health:SetHeight(frame.Health:GetParent():GetHeight() * 0.75)
					else
						frame.Health:SetHeight(frame.Health:GetParent():GetHeight() * 0.83)
					end
				else
					frame.Health:SetHeight(frame.Health:GetParent():GetHeight())	
				end
				if frame.Power then
					frame.Power:Show()
				end
			end		
		end
	end

	function ElvDB.ExperienceText(self, unit, min, max)
		local rested = GetXPExhaustion()
		if rested then 
			self.Text:SetFormattedText('XP: '..ElvDB.ShortValue(min)..' / '..ElvDB.ShortValue(max)..' <%d%%>  R: +'..ElvDB.ShortValue(rested)..' <%d%%>', min / max * 100, rested / max * 100)
		else
			self.Text:SetFormattedText('XP: '..ElvDB.ShortValue(min)..' / '..ElvDB.ShortValue(max)..' <%d%%>', min / max * 100)
		end
	end



	--------------------------------------------------------------------------------------------
	-- THE AURAWATCH FUNCTION ITSELF. HERE BE DRAGONS!
	--------------------------------------------------------------------------------------------

	ElvDB.countOffsets = {
		TOPLEFT = {6, 1},
		TOPRIGHT = {-6, 1},
		BOTTOMLEFT = {6, 1},
		BOTTOMRIGHT = {-6, 1},
		LEFT = {6, 1},
		RIGHT = {-6, 1},
		TOP = {0, 0},
		BOTTOM = {0, 0},
	}

	function ElvDB.CreateAuraWatchIcon(self, icon)
		if (icon.cd) then
			icon.cd:SetReverse()
		end 	
	end

	function ElvDB.createAuraWatch(self, unit)
		local auras = CreateFrame("Frame", nil, self)
		auras:SetPoint("TOPLEFT", self.Health, 2, -2)
		auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
		auras.presentAlpha = 1
		auras.missingAlpha = 0
		auras.icons = {}
		auras.PostCreateIcon = ElvDB.CreateAuraWatchIcon

		if (not ElvCF["auras"].auratimer) then
			auras.hideCooldown = true
		end

		local buffs = {}
		if IsAddOnLoaded("ElvUI_Dps_Layout") then
			if (ElvDB.DPSBuffIDs["ALL"]) then
				for key, value in pairs(ElvDB.DPSBuffIDs["ALL"]) do
					tinsert(buffs, value)
				end
			end

			if (ElvDB.DPSBuffIDs[ElvDB.myclass]) then
				for key, value in pairs(ElvDB.DPSBuffIDs[ElvDB.myclass]) do
					tinsert(buffs, value)
				end
			end	
		else
			if (ElvDB.HealerBuffIDs["ALL"]) then
				for key, value in pairs(ElvDB.HealerBuffIDs["ALL"]) do
					tinsert(buffs, value)
				end
			end

			if (ElvDB.HealerBuffIDs[ElvDB.myclass]) then
				for key, value in pairs(ElvDB.HealerBuffIDs[ElvDB.myclass]) do
					tinsert(buffs, value)
				end
			end
		end
		
		if ElvDB.PetBuffs[ElvDB.myclass] then
			for key, value in pairs(ElvDB.PetBuffs[ElvDB.myclass]) do
				tinsert(buffs, value)
			end
		end

		-- "Cornerbuffs"
		if (buffs) then
			for key, spell in pairs(buffs) do
				local icon = CreateFrame("Frame", nil, auras)
				icon.spellID = spell[1]
				icon.anyUnit = spell[4]
				icon:SetWidth(ElvDB.Scale(ElvCF["auras"].buffindicatorsize))
				icon:SetHeight(ElvDB.Scale(ElvCF["auras"].buffindicatorsize))
				icon:SetPoint(spell[2], 0, 0)

				local tex = icon:CreateTexture(nil, "OVERLAY")
				tex:SetAllPoints(icon)
				tex:SetTexture([=[Interface\AddOns\ElvUI\media\textures\blank]=])
				if (spell[3]) then
					tex:SetVertexColor(unpack(spell[3]))
				else
					tex:SetVertexColor(0.8, 0.8, 0.8)
				end

				local count = icon:CreateFontString(nil, "OVERLAY")
				count:SetFont(ElvCF["media"].uffont, 8, "THINOUTLINE")
				count:SetPoint("CENTER", unpack(ElvDB.countOffsets[spell[2]]))
				icon.count = count

				auras.icons[spell[1]] = icon
			end
		end

		self.AuraWatch = auras
	end
end