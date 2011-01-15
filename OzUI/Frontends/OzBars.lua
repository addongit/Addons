if (not OzUIConfig.OzBars.enabled) then
	return
end

OzBars = {}

OzBars.containers = {}

OzBars.settings = {
	font = TukuiCF.media.font,
	texture = TukuiCF.media.normTex,
	fontSize = 12,
	fontFlags = ""
}

OzBars.frameSettings = {
	["Target_Debuff"] = {
		["name"] = "Target_Debuff",
		["anchor"] = {{"BOTTOMLEFT","oUF_Tukz_target","TOPLEFT",0,140},{"BOTTOMRIGHT","oUF_Tukz_target","TOPRIGHT",0,100}},
		["spacing"] = 1,
		["barHeight"] = 16,
		["grow"] = "TOP",
		["order"] = 1,
	},
	["Target_Buff"] = {
		["name"] = "Target_Buff",
		["anchor"] = {{"CENTER",UIParent,"CENTER",130,270}},
		["spacing"] = 6,
		["barHeight"] = 32,
		["grow"] = "TOP",
		["order"] = 2,
	},
	["Player_Debuff"] = {
		["name"] = "Player_Debuff",
		["anchor"] = {{"CENTER",UIParent,"CENTER",130,310}},
		["spacing"] = 6,
		["barHeight"] = 32,
		["grow"] = "TOP",
		["order"] = 3,
	},
	["Pet_Debuff"] = {
		["name"] = "Pet_Debuff",
		["anchor"] = {{"CENTER",UIParent,"CENTER",130,390}},
		["spacing"] = 6,
		["barHeight"] = 32,
		["grow"] = "TOP",
		["order"] = 5,
	},
	["Pet_Buff"] = {
		["name"] = "Pet_Buff",
		["anchor"] = {{"CENTER",UIParent,"CENTER",130,430}},
		["spacing"] = 6,
		["barHeight"] = 32,
		["grow"] = "TOP",
		["order"] = 6,
	},
	["focus"] = {
		["name"] = "focus",
		["anchor"] = {{"CENTER",UIParent,"CENTER",130,470}},
		["spacing"] = 6,
		["barHeight"] = 32,
		["grow"] = "TOP",
		["order"] = 7,
	},
	["cooldown"] = {
		["name"] = "cooldown",
		["anchor"] = {{"BOTTOMLEFT","OzBarFrameprocs","TOPLEFT",0,6},{"BOTTOMRIGHT","OzBarFrameprocs","TOPRIGHT",0,6}},
		["spacing"] = 1,
		["barHeight"] = 20,
		["grow"] = "TOP",
		["order"] = 9,
	},
	["Player_Buff"] = {
		["name"] = "Player_Buff",
		["anchor"] = {{"BOTTOMLEFT","oUF_Tukz_player","TOPLEFT",0,100},{"BOTTOMRIGHT","oUF_Tukz_player","TOPRIGHT",0,100}},
		["spacing"] = 6,
		["barHeight"] = 16,
		["grow"] = "TOP",
		["order"] = 4,
	},
	["procs"] = {
		["name"] = "procs",
		["anchor"] = {{"BOTTOMLEFT","OzBarFramePlayer_Buff","TOPLEFT",0,6},{"BOTTOMRIGHT","OzBarFramePlayer_Buff","TOPRIGHT",0,6}},
		["spacing"] = 1,
		["barHeight"] = 16,
		["grow"] = "TOP",
		["order"] = 8,
	},

}

local OzBarsFrame = nil
local timeSinceLastUpdate = 0
local updateInterval = 0.05


function OzBars:Init()
	self:CreateFrames()
	local icon = "Interface\\Icons\\Spell_DeathKnight_FrostFever"
	--self:CreateBar("procs",icon,3,10,GetTime()+20)
	OzBarsFrame = CreateFrame("Frame","OzCDFrame",UIParent)
	OzBarsFrame:SetScript("OnUpdate", UpdateBars)

end


function UpdateBars(self, elapsed)
	timeSinceLastUpdate = timeSinceLastUpdate + elapsed;
	if (timeSinceLastUpdate > updateInterval) then
		for containerFrame, container in pairs (OzBars.containers) do
			for id, bar in pairs(container.active) do
				bar.bar:SetValue(bar.expire-GetTime())
				bar.durationRegion:SetText(math.floor(bar.expire-GetTime()))
				
			end
		end
		
		timeSinceLastUpdate = 0
	end
end


function OzBars:CreateFrames()
	local orderedSettings = {}
	for containerName,settings in pairs(self.frameSettings) do
		table.insert(orderedSettings, settings.order, settings)
	end

	for i = 1,#orderedSettings do
		local containerName = orderedSettings[i].name
		local settings = orderedSettings[i]
		local f = CreateFrame("Frame","OzBarFrame"..containerName,UIParent)
		f:SetFrameStrata("BACKGROUND")
		for index,anchor in pairs(settings.anchor) do 
			local point,parent,pointTo,xPos,yPos = unpack(anchor)
			if (type(parent) == "string") then
				parent = _G[parent]
			end
			f:SetPoint(point,parent,pointTo,xPos,yPos)
		end

		f:SetHeight(1)

		local background = f:CreateTexture( nil, "BACKGROUND", nil )
		background:SetAlpha( 0.75 )
		background:SetTexture( TukuiCF["media"].normTex )
		background:SetPoint( "TOPLEFT", f, "TOPLEFT", 0, 0 )
		background:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0 )
		background:SetVertexColor( 0.2, 0.2, 0.2 )
		f.background = background
		
		local border = CreateFrame( "Frame", nil, f, nil )
		border:SetAlpha( 0.75 )
		border:SetFrameStrata( "BACKGROUND" )
		border:SetBackdrop( {
			edgeFile = TukuiCF["media"].glowTex, 
			edgeSize = 5,
			insets = { left = 3, right = 3, top = 3, bottom = 3 }
		} )
		border:SetBackdropColor( 0, 0, 0, 0 )
		border:SetBackdropBorderColor( 0, 0, 0 )
		border:SetPoint( "TOPLEFT", f, "TOPLEFT", -5, 5 )
		border:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", 5, -5 )
		f.border = border	

		self.containers[containerName] = {["frame"] = f, active = {}, cache = {}}
		f:SetAlpha(0)
	end
end


function OzBars:CreateBar(containerName,id,iconName,barName,stacks,duration,expire, arg)
	local anchorFrame = self.containers[containerName].frame
	local barFrame = CreateFrame("Frame","OzBar"..iconName,anchorFrame)
	local frameSetting = self.frameSettings[containerName]
	barFrame:SetFrameStrata("LOW")
	barFrame:SetHeight(frameSetting.barHeight)
	barFrame:SetWidth(anchorFrame:GetWidth())
	barFrame:SetPoint("CENTER",anchorFrame,"CENTER",0,0)		


	local icon = barFrame:CreateTexture(nil,"BACKGROUND")
	icon:SetTexture(iconName)
	icon:SetTexCoord(0.08,0.92,0.08,0.92)
	icon:SetHeight(frameSetting.barHeight)
	icon:SetWidth(frameSetting.barHeight)
	icon:SetPoint("LEFT",barFrame,"LEFT",0,0)
	barFrame.icon = icon

	barFrame.duration = duration
	barFrame.expire = expire

	local bar = CreateFrame("StatusBar",nil,barFrame)
	bar:SetPoint("BOTTOMLEFT",barFrame,"BOTTOMLEFT",frameSetting.barHeight+1,0)
	bar:SetPoint("TOPRIGHT",barFrame,"TOPRIGHT",0,0)
	bar:SetMinMaxValues(0,expire-GetTime())
	bar:SetValue(expire-GetTime())
	bar:SetStatusBarTexture(self.settings.texture)
	if (type(arg) == "table") then
		bar:SetStatusBarColor(unpack(arg))
	else
		bar:SetStatusBarColor(1,0,1)
	end
	barFrame.bar = bar

	local stackRegion = barFrame:CreateFontString()
	stackRegion:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0)
	stackRegion:SetFont(self.settings.font, self.settings.fontSize, self.settings.fontFlags)
	stackRegion:SetShadowOffset(TukuiDB.mult, -TukuiDB.mult)
	if (stacks > 1) then
		stackRegion:SetText(stacks)
	end
	stackRegion:SetTextColor(1, 1, 1)

	local durationRegion = bar:CreateFontString()
	durationRegion:SetPoint("RIGHT", bar, "RIGHT", -10, 0)
	durationRegion:SetFont(self.settings.font, self.settings.fontSize, self.settings.fontFlags)
	durationRegion:SetShadowOffset(TukuiDB.mult, -TukuiDB.mult)
	if (stacks > 1) then
		durationRegion:SetText(math.ceil(expire-GetTime()))
	end
	durationRegion:SetTextColor(1, 1, 1)
	barFrame.durationRegion = durationRegion

	local nameRegion = bar:CreateFontString()
	nameRegion:SetPoint("LEFT", bar, "LEFT", 2, 0)
	nameRegion:SetFont(self.settings.font, self.settings.fontSize, self.settings.fontFlags)
	nameRegion:SetShadowOffset(TukuiDB.mult, -TukuiDB.mult)
	nameRegion:SetText(barName)
	stackRegion:SetTextColor(1, 0, 0)
	
	barFrame.stacks = stackRegion

	self.containers[containerName].active[id] = barFrame
end

function OzBars:Hide(containerName,id)
	if (self.containers[containerName].active[id]) then
		self.containers[containerName].cache[id] = self.containers[containerName].active[id]
		local f = self.containers[containerName].active[id]
		f:Hide()
		self.containers[containerName].active[id] = nil
		self:RepositionFrames(containerName)
	end
end

function OzBars:Create(containerName,id,icon,barName,stacks,duration,expire,arg)
	if (self.containers[containerName].active[id]) then
		-- set timer
		local f = self.containers[containerName].active[id]
		--if (math.abs(expire - f.expire) > 1) then
			f.expire = expire
		if (f.duration < duration) then
			f.bar:SetMinMaxValues(0,duration)
		end
		--end
		if (stacks > 1) then
			f.stacks:SetText(stacks)
		else
			f.stacks:SetText("")
		end
		self:RepositionFrames(containerName)
	elseif (self.containers[containerName].cache[id]) then
		-- cached, make active
		local f = self.containers[containerName].cache[id]
		self.containers[containerName].active[id] = f
		if (math.abs(expire - f.expire) > 1) then
			f.expire = expire
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
		local anchorFrame = self.containers[containerName].frame
		local f = self:CreateBar(containerName,id,icon,barName,stacks,duration,expire,arg)

		self:RepositionFrames(containerName)
	end
end

function OzBars:RepositionFrames(containerName)
	local lookup = {
		["TOP"] = "BOTTOM",
		["BOTTOM"] = "TOP",
	}
	local containerFrame = self.containers[containerName].frame
	local lastFrame = containerFrame
	local frameSetting = self.frameSettings[containerName]
	local grow = frameSetting.grow
	local count = 0
	for id, frame in pairs  (self.containers[containerName].active) do
		if frame then
			frame:ClearAllPoints()
			if (count == 0) then
				frame:SetPoint(lookup[grow],lastFrame,lookup[grow],0,0)
			else
				frame:SetPoint(lookup[grow],lastFrame,grow,0,frameSetting.spacing)
			end
			lastFrame = frame
			count = count + 1
		end
	end	
	if (count > 0) then
		containerFrame:SetHeight(count*(frameSetting.barHeight+frameSetting.spacing)-frameSetting.spacing)
		containerFrame:SetAlpha(1)
	else
		containerFrame:SetHeight(1)
		containerFrame:SetAlpha(0)
	end

end

OzBars:Init()



