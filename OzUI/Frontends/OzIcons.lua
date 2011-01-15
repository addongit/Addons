if (not OzUIConfig.OzIcons.enabled) then
	return
end

OzIcons = {}

OzIcons.iconFrames = {}

OzIcons.settings = {
	font = TukuiCF.media.uffont,
	fontSize = 12,
	fontFlags = "MONOCHROMEOUTLINE"
}

OzIcons.frameSettings = {
	["Target_Debuff"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",130,0},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(40),
		["grow"] = "RIGHT",
	},
	["Target_Buff"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",130,-50},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(40),
		["grow"] = "RIGHT",
	},
	["Player_Debuff"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",-130,-50},
		["ySpacing"] = 0,
		["xSpacing"] = -6,
		["iconSize"] = TukuiDB.Scale(40),
		["grow"] = "LEFT",
	},
	["Player_Buff"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",-130,0},
		["ySpacing"] = 0,
		["xSpacing"] = -6,
		["iconSize"] = TukuiDB.Scale(40),
		["grow"] = "LEFT",
	},
	["Pet_Debuff"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",130,290},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(32),
		["grow"] = "RIGHT",
	},
	["Pet_Buff"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",130,330},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(32),
		["grow"] = "RIGHT",
	},
	["focus"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",130,370},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(32),
		["grow"] = "RIGHT",
	},
	["cooldown"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",0,-220},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(32),
		["grow"] = "HORIZONTAL",
	},
	["procs"] = {
		["anchor"] = {"CENTER",UIParent,"CENTER",0,-170},
		["ySpacing"] = 0,
		["xSpacing"] = 6,
		["iconSize"] = TukuiDB.Scale(40),
		["grow"] = "HORIZONTAL",
	},

}


function OzIcons:Init()
	self:CreateFrames()
--[[
	local icon = "Interface\\Icons\\Spell_DeathKnight_FrostFever"
	self:Create("focus","frostfever",icon,"Frost Fever",3,10,GetTime()+20)
	self:Create("focus","frostfever2",icon,"Frost Fever",3,10,20)
	self:Create("focus","frostfever3",icon,"Frost Fever",3,10,20)
	self:Create("focus","frostfever4",icon,"Frost Fever",3,10,20)

	self:Create("Pet_Buff","frostfever",icon,"Frost Fever",3,10,20)
	self:Create("Pet_Buff","frostfever2",icon,"Frost Fever",3,10,20)
	self:Create("Pet_Buff","frostfever3",icon,"Frost Fever",3,10,20)
	self:Create("Pet_Buff","frostfever4",icon,"Frost Fever",3,10,20)
]]--
end

function OzIcons:CreateFrames()
	for containerName,settings in pairs(self.frameSettings) do
		local f = CreateFrame("Frame","OzIconFrame"..containerName,UIParent)
		f:SetPoint(unpack(settings.anchor))
		f:SetWidth(2)
		f:SetHeight(10)
		--[[
		f:SetBackdropColor(0.1, 0.9, 0.4)
		f:SetBackdropBorderColor(0.5, 0.5, 0.5)
		f:SetBackdrop({
	        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	        edgeFile = "Interface\\Tooltips\\None",
	        insets = { left = 0, right = 0, top = 0, bottom = 0 },
	        tile = false,
		})
		]]--
		self.iconFrames[containerName] = {["frame"] = f, active = {}, cache = {}}
	end
end

function OzIcons:RepositionFrames(containerName)
	local lookup = {
		["LEFT"] = "RIGHT",
		["RIGHT"] = "LEFT",
		["TOP"] = "BOTTOM",
		["BOTTOM"] = "TOP",
		["HORIZONTAL"] = "LEFT",
		["VERTICAL"] = "BOTTOM",
	}
	local containerFrame = self.iconFrames[containerName].frame
	local lastFrame = containerFrame
	local frameSetting = self.frameSettings[containerName]
	local count = 0
	if (frameSetting.grow ~= "VERTICAL" and frameSetting.grow ~= "HORIZONTAL") then
		for id, frame in pairs  (self.iconFrames[containerName].active) do
			if frame then
				frame:ClearAllPoints()
				frame:SetPoint(lookup[frameSetting.grow],lastFrame,frameSetting.grow,frameSetting.xSpacing,frameSetting.ySpacing)
				lastFrame = frame
				count = count + 1
			end
		end	
	else
		for id, frame in pairs  (self.iconFrames[containerName].active) do
			if frame then
				frame:ClearAllPoints()
				frame:SetPoint(lookup[frameSetting.grow],lastFrame,lookup[lookup[frameSetting.grow]],frameSetting.xSpacing,frameSetting.ySpacing)
				lastFrame = frame
				count = count + 1
			end
		end	
		if (frameSetting.grow == "VERTICAL") then
			local setting = self.frameSettings[containerName]
			containerFrame:SetPoint(setting.anchor[1],setting.anchor[2],setting.anchor[3],setting.anchor[4],setting.anchor[5]-(count*(setting.iconSize+setting.ySpacing)/2)-setting.ySpacing)
		elseif (frameSetting.grow == "HORIZONTAL") then
			local setting = self.frameSettings[containerName]
			containerFrame:SetPoint(setting.anchor[1],setting.anchor[2],setting.anchor[3],setting.anchor[4]-(count*(setting.iconSize+setting.xSpacing)/2)-setting.xSpacing,setting.anchor[5])
		end
	end
end

function OzIcons:Hide(containerName,id)
	if (self.iconFrames[containerName].active[id]) then
		self.iconFrames[containerName].cache[id] = self.iconFrames[containerName].active[id]
		local f = self.iconFrames[containerName].active[id]
		f:Hide()
		self.iconFrames[containerName].active[id] = nil
		self:RepositionFrames(containerName)
	end
end

function OzIcons:Create(containerName,id,iconFile,iconName,stacks,duration,expire, color)
	duration = 0
	if (self.iconFrames[containerName].active[id]) then
		-- set timer

		local f = self.iconFrames[containerName].active[id]
		if (math.abs(expire - f.cooldown.expire) > 1) then
			f.cooldown:SetCooldown(GetTime()-duration, expire-GetTime())
			f.cooldown.expire = expire
		end
		
		if (stacks > 1) then
			f.stacks:SetText(stacks)
		else
			f.stacks:SetText("")
		end
		self:RepositionFrames(containerName)
	elseif (self.iconFrames[containerName].cache[id]) then
		-- cached, make active
		local f = self.iconFrames[containerName].cache[id]
		self.iconFrames[containerName].active[id] = f
		if (math.abs(expire - f.cooldown.expire) > 1) then
			f.cooldown:SetCooldown(GetTime()-duration,expire-GetTime())
			f.cooldown.expire = expire
		end
		if (stacks > 1) then
			f.stacks:SetText(stacks)
		else
			f.stacks:SetText("")
		end
		f:Show()
		self:RepositionFrames(containerName)
	else
		-- make frame
		local frameSettings = self.frameSettings[containerName]
		local iconName = "OzIcon"..containerName..id
		local anchorFrame = self.iconFrames[containerName].frame

		local f = CreateFrame("Frame", iconName, anchorFrame)
		f:SetFrameStrata("LOW")
		f:SetWidth(frameSettings.iconSize)
		f:SetHeight(frameSettings.iconSize)
		f:SetPoint("CENTER",anchorFrame,"CENTER",0,0)		

		local backdrop = CreateFrame("Frame", nil, f)
		if color then
			TukuiDB.CreatePanel(backdrop, frameSettings.iconSize+2,frameSettings.iconSize+2, "CENTER", f, "CENTER", 0, 0,nil,color)
		else
			TukuiDB.CreatePanel(backdrop, frameSettings.iconSize+2,frameSettings.iconSize+2, "CENTER", f, "CENTER", 0, 0)
		end
		local icon = f:CreateTexture(nil,"BACKGROUND")
		icon:SetTexture(iconFile)
		icon:SetTexCoord(0.08,0.92,0.08,0.92)
		icon:SetAllPoints(f)
		f.icon = icon

		local stackRegion = f:CreateFontString()
		stackRegion:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		stackRegion:SetFont(self.settings.font, self.settings.fontSize*2, self.settings.fontFlags)
		if (stacks > 1) then
			stackRegion:SetText(stacks)
		end
		stackRegion:SetTextColor(1, 0, 0)
		f.stacks = stackRegion

		local cooldown = CreateFrame("Cooldown",nil,f)
		cooldown:SetAllPoints(f)
		cooldown:SetCooldown(GetTime()-duration, expire-GetTime())
		cooldown:SetAlpha(0.75)
		cooldown.expire = expire
		if containerName == "cooldown" then
			cooldown.fontScale = 0
		end
		f.cooldown = cooldown
		
		f:Show()
		self.iconFrames[containerName].active[id] = f
		self:RepositionFrames(containerName)
	end
end

OzIcons:Init()

