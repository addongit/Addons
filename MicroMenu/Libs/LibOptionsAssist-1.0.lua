local LIB, REVISION = "LibOptionsAssist-1.0", 3
if not LibStub then error(LIB .. " requires LibStub", 0) end

local lib, oldRevision = LibStub:NewLibrary(LIB, REVISION)
if not lib then return end

--[[-----------------------------------------------------------------------------
Version bridge
-------------------------------------------------------------------------------]]
local content, desc, frame, fsDesc, fsInfo, fsTitle, info, mt, name, path, showing, title, widget, LOD, OnHide, OnShow

if oldRevision then
	if oldRevision < 2 then
		desc, info, name, path, title, LOD, OnHide, OnShow = { }, lib._info, lib._name, lib._path, lib._title, lib._LOD, lib._OnHide, lib._OnShow
		content, frame, fsInfo, fsTitle = lib.content, lib.frame, lib.info, lib.title
		mt, showing, widget = lib.emulate_mt, lib.showing, lib.widget
		fsDesc = frame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
		fsInfo:SetParent(frame)
		fsTitle:SetParent(frame)
		lib.title_bar:Hide()
		wipe(lib)
		wipe(mt)
	else
		content, desc, frame, fsDesc, fsInfo, fsTitle, info, mt, name, path, showing, title, widget, LOD, OnHide, OnShow = lib.__void()
	end
else
	desc, info, mt, name, path, title, LOD, OnHide, OnShow = { }, { }, { }, { }, { }, { }, { }, { }, { }
	frame = CreateFrame('Frame', nil, UIParent)
	content = CreateFrame('Frame', nil, frame)
	fsDesc = frame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
	fsInfo = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
	fsTitle = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
	frame:Hide()
end

--[[-----------------------------------------------------------------------------
Initialize frames and font strings
-------------------------------------------------------------------------------]]
frame:SetScript('OnHide', function(self)
	if OnHide[showing] then
		local ok, err = pcall(OnHide[showing], showing)
		if not ok then
			geterrorhandler()(err)
		end
	end
end)

frame:SetScript('OnShow', function(self)
	if showing then
		if OnShow[showing] then
			local ok, err = pcall(OnShow[showing], showing)
			if not ok then
				geterrorhandler()(err)
			end
		end
		showing:Refresh()
	end
end)

frame:SetScript('OnUpdate', function(self)													-- Keep the width of fontString[DESC] set correctly
	self:SetScript('OnUpdate', nil)
	fsDesc:SetWidth(self:GetWidth() - 25)
	self:SetScript('OnSizeChanged', function(self, width)
		fsDesc:SetWidth(width - 25)
	end)
end)

content:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -10, 10)

fsDesc:ClearAllPoints()
fsDesc:SetJustifyH('LEFT')
fsDesc:SetJustifyV('TOP')
fsDesc:SetNonSpaceWrap(true)
fsDesc:SetText(" ")
fsDesc:Hide()
fsDesc.shown = false

fsInfo:ClearAllPoints()
fsInfo:SetAlpha(0.75)
fsInfo:SetJustifyH('RIGHT')
fsInfo:SetJustifyV('MIDDLE')
fsInfo:SetPoint('TOPLEFT', frame, 'TOPLEFT', 15, -15)
fsInfo:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', -10, -15)
fsInfo:SetText(" ")
fsInfo:Hide()
fsInfo.shown = false

fsTitle:ClearAllPoints()
fsTitle:SetJustifyH('LEFT')
fsTitle:SetJustifyV('TOP')
fsTitle:SetPoint('TOPLEFT', frame, 'TOPLEFT', 15, -15)
fsTitle:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', -10, -15)
fsTitle:SetText(" ")
fsTitle:SetHeight(fsTitle:GetStringHeight())
fsTitle:Hide()
fsTitle.shown = false

--[[-----------------------------------------------------------------------------
LoD library support
-------------------------------------------------------------------------------]]
local ACD, ACR = LibStub('AceConfigDialog-3.0', true), LibStub('AceConfigRegistry-3.0', true)

if ACD and ACR and widget then
	frame:UnregisterEvent('ADDON_LOADED')
	frame:SetScript('OnEvent', nil)
else
	frame:RegisterEvent('ADDON_LOADED')
	frame:SetScript('OnEvent', function(self)
		if not ACD then
			ACD = LibStub('AceConfigDialog-3.0', true)
		end
		if not ACR then
			ACR = LibStub('AceConfigRegistry-3.0', true)
		end
		if not (ACD and ACR and LibStub('AceGUI-3.0', true)) then return end
		self:UnregisterEvent('ADDON_LOADED')
		self:SetScript('OnEvent', nil)
		widget = {
			content = content,
			frame = frame,
			type = LIB
		}
		LibStub('AceGUI-3.0'):RegisterAsContainer(widget)
		if showing then
			showing:Refresh()
		end
	end)
end

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]
local function AnchorContent()
	local anchor = fsTitle.shown and fsTitle
	if fsInfo.shown then
		if anchor then
			fsInfo:SetHeight(fsTitle:GetStringHeight())
		else
			fsInfo:SetHeight(fsInfo:GetStringHeight())
			anchor = fsInfo
		end
	end
	if fsDesc.shown then
		if anchor then
			fsDesc:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, -11)
		else
			fsDesc:SetPoint('TOPLEFT', fsTitle, 'TOPLEFT')
		end
		content:SetPoint('TOPLEFT', fsDesc, 'BOTTOMLEFT', 0, -10)
	elseif anchor then
		content:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, -8)
	else
		content:SetPoint('TOPLEFT', fsTitle, 'TOPLEFT')
	end
end
AnchorContent()

local function DoNothing()
end

local function Update(fs, text)
	if text then
		fs:SetText(text)
		if not fs.shown then
			fs.shown = true
			fs:Show()
			AnchorContent()
		end
	elseif fs.shown then
		fs.shown = false
		fs:Hide()
		AnchorContent()
	end
end

local function Set(entry, text, fs, variable)
	if type(text) ~= 'string' and text ~= nil then
		error(LIB .. ": <object>:Set" .. (fs == fsDesc and "Desc") or (fs == fsInfo and "Info") or "Title" .. "(text) - 'text' expected string or nil, got " .. type(text), 3)
	end
	if text then
		text = strtrim(text)
		if text == "" then
			text = nil
		end
	end
	variable[entry] = text
	if showing == entry then
		Update(fs, text)
	end
end

--[[-----------------------------------------------------------------------------
Instead of creating a new set of frames and font strings for each Blizzard
options panel entry, one set will be shared between them all.  To facilitate
this, a metatable will be used to emulate the needed methods.
-------------------------------------------------------------------------------]]
mt.__call = function(self)
	InterfaceOptionsFrame_OpenToCategory(self)
end

mt.__index = {
	cancel = DoNothing,
	defaults = DoNothing,
	okay = DoNothing,
	refresh = DoNothing,

	["AssignOptions"] = function(self, optName, ...)
		if optName == nil then
			name[self], path[self] = nil, nil
		else
			name[self] = optName
			if select('#', ...) > 0 then
				path[self] = { ... }
			else
				path[self] = nil
			end
		end
		self:Refresh()
	end,

	['ClearAllPoints'] = function(self)															-- Required
		if (showing or self) == self then
			frame:ClearAllPoints()
		end
	end,

	["FlagAsLoaded"] = function(self)
		LOD[self] = nil
	end,

	["GetDesc"] = function(self)
		return desc[self]
	end,

	["GetInfo"] = function(self)
		return info[self]
	end,

	['GetScript'] = function(self, script)
		if script == 'OnHide' then
			return OnHide[self]
		elseif script == 'OnShow' then
			return OnShow[self]
		else
			error(LIB .. ": <object>:GetScript(script) - '" .. tostring(script) .. "' is not a valid script for this object", 2)
		end
	end,

	["GetTitle"] = function(self)
		return title[self]
	end,

	['HasScript'] = function(self, script)
		return script == 'OnHide' or script == 'OnShow'
	end,

	['Hide'] = function(self)																		-- Required
		if showing == self then
			content:Hide()
			if widget then
				widget:PauseLayout()
				widget:ReleaseChildren()
			end
			frame:Hide()
			showing = nil
		end
	end,

	['IsShown'] = function(self)
		return showing == self
	end,

	['IsVisible'] = function(self)
		return showing == self and frame:IsVisible()
	end,

	["Refresh"] = function(self)
		if showing == self then
			Update(fsDesc, desc[self])
			Update(fsInfo, info[self])
			Update(fsTitle, title[self])
			if widget then
				content:Hide()
				local name = name[self]
				if name and ACR:GetOptionsTable(name) then
					widget:ResumeLayout()
					if not path[self] then
						ACD:Open(name, widget)
					else
						ACD:Open(name, widget, unpack(path[self]))
					end
					content:Show()
				end
			end
		end
	end,

	['SetAllPoints'] = function(self, ...)
		if (showing or self) == self then
			frame:SetAllPoints(...)
		end
	end,

	["SetDesc"] = function(self, text)
		Set(self, text, fsDesc, desc)
	end,

	["SetInfo"] = function(self, text)
		Set(self, text, fsInfo, info)
	end,

	['SetParent'] = function(self, ...)															-- Required
		if (showing or self) == self then
			frame:SetParent(...)
		end
	end,

	['SetPoint'] = function(self, ...)															-- Required
		if (showing or self) == self then
			frame:SetPoint(...)
		end
	end,

	['SetScript'] = function(self, script, func)
		if type(func) ~= 'function' and func ~= nil then
			error(LIB .. ": <object>:SetScript(script, func) - 'func' expected function or nil, got " .. type(func), 2)
		elseif script == 'OnHide' then
			OnHide[self] = func
		elseif script == 'OnShow' then
			OnShow[self] = func
		else
			error(LIB .. ": <object>:SetScript(script, func) - '" .. tostring(script) .. "' is not a valid script for this object", 2)
		end
	end,

	["SetTitle"] = function(self, text)
		Set(self, text, fsTitle, title)
	end,

	['Show'] = function(self)																		-- Required
		if showing then
			if showing == self then
				return self:Refresh()
			end
			showing:Hide()
		elseif LOD[self] then																		-- Do this before showing to avoid potential LoD issues
			local lod = LOD[self]
			LOD[self] = nil
			if type(lod) == 'function' then
				local ok, name = pcall(lod, self)
				lod = ok and name
			end
			if type(lod) == 'string' then
				lib:LoadModule(lod)
			end
		end
		showing = self
		frame:Show()
	end
}

mt.__metatable = LIB

if showing then
	showing:Refresh()
end

--[[-----------------------------------------------------------------------------
Private API
-------------------------------------------------------------------------------]]
function lib.__void()
	wipe(lib)
	wipe(mt)
	return content, desc, frame, fsDesc, fsInfo, fsTitle, info, mt, name, path, showing, title, widget, LOD, OnHide, OnShow
end

--[[-----------------------------------------------------------------------------
Public API
-------------------------------------------------------------------------------]]
function lib:AddEntry(name, parent, loadOnDemand)
	if type(name) ~= 'string' then
		error(LIB .. ":AddEntry(name, parent, loadOnDemand) - 'name' expected string, got " .. type(name), 2)
	elseif type(parent) ~= 'string' and parent ~= nil then
		error(LIB .. ":AddEntry(name, parent, loadOnDemand) - 'parent' expected string or nil, got " .. type(parent), 2)
	elseif parent and not self:HasEntry(parent) then
		error(LIB .. ":AddEntry(name, parent, loadOnDemand) - 'parent' (" .. parent .. ") must exist before adding a child", 2)
	elseif type(loadOnDemand) ~= 'string' and type(loadOnDemand) ~= 'function' and loadOnDemand ~= nil then
		error(LIB .. ":AddEntry(name, parent, loadOnDemand) - 'loadOnDemand' expected function or string or nil, got " .. type(loadOnDemand), 2)
	end
	local entry = setmetatable({
		name = name,
		parent = parent
	}, mt)
	title[entry], LOD[entry] = name, loadOnDemand
	InterfaceOptions_AddCategory(entry)
	return entry
end

function lib:HasEntry(name, parent)
	if type(name) ~= 'string' or (parent and type(parent) ~= 'string') then return end
	for index, entry in self:IterateEntries(parent) do
		if entry.name == name then
			return index
		end
	end
end

do
	local entries = INTERFACEOPTIONS_ADDONCATEGORIES

	local function iterator(parent, index)
		for index = (index or 0) + 1, #entries do
			if entries[index].parent == parent then
				return index, entries[index]
			end
		end
	end

	function lib:IterateEntries(parent)
		return iterator, type(parent) == 'string' and parent or nil, 0
	end
end

function lib:LoadModule(name)
	if type(name) ~= 'string' then
		error(LIB .. ":LoadModule(name) - 'name' expected string, got " .. type(name), 2)
	end
	local loaded, reason, _, title, _, enabled = nil, 'MISSING', GetAddOnInfo(name)
	if title then
		loaded = IsAddOnLoaded(name)
		if not loaded then
			if not enabled then
				EnableAddOn(name)
			end
			loaded, reason = LoadAddOn(name)
			if not enabled then
				DisableAddOn(name)
			end
		end
	end
	return loaded, reason
end
