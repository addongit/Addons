--
-- $Id: BugGrabber.lua 178 2011-04-12 22:51:46Z rabbit $
--
-- The BugSack and !BugGrabber team is:
-- Current Developer: Rabbit
-- Past Developers: Rowne, Ramble, industrial, Fritti, kergoth, ckknight
-- Testers: Ramble, Sariash
--
--[[

!BugGrabber, World of Warcraft addon that catches errors and formats them with a debug stack.
Copyright (C) 2011 The !BugGrabber Team

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

-----------------------------------------------------------------------
-- Check if we already exist in the global space
-- If we do - bail out early, there's no version checks.
if _G.BugGrabber then return end

-----------------------------------------------------------------------
-- If we're embedded we create a .BugGrabber object on the addons
-- table, unless we find a standalone !BugGrabber addon.

local bugGrabberParentAddon, parentAddonTable = ...
local STANDALONE_NAME = "!BugGrabber"
if bugGrabberParentAddon ~= STANDALONE_NAME then
	for i, handler in next, { STANDALONE_NAME, "!Swatter", "!ImprovedErrorFrame" } do
		local enabled = select(4, GetAddOnInfo(handler))
		if enabled then return end -- Bail out
	end
end
if not parentAddonTable.BugGrabber then parentAddonTable.BugGrabber = {} end
local addon = parentAddonTable.BugGrabber

local real_seterrorhandler = seterrorhandler

-----------------------------------------------------------------------
-- Global config variables
--
MAX_BUGGRABBER_ERRORS = 50

-- If we get more errors than this per second, we stop all capturing
BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE = 10
BUGGRABBER_TIME_TO_RESUME = 30
BUGGRABBER_SUPPRESS_THROTTLE_CHAT = nil

-----------------------------------------------------------------------
-- Localization
--
local L = {
	ADDON_CALL_PROTECTED = "[%s] AddOn '%s' tried to call the protected function '%s'.",
	ADDON_CALL_PROTECTED_MATCH = "^%[(.*)%] (AddOn '.*' tried to call the protected function '.*'.)$",
	ADDON_DISABLED = "|cffffff00!BugGrabber and %s cannot coexist; %s has been forcefully disabled. If you want to, you may log out, disable !BugGrabber, and enable %s.|r",
	BUGGRABBER_RESUMING = "|cffffff00!BugGrabber is capturing errors again.|r",
	BUGGRABBER_STOPPED = "|cffffff00!BugGrabber has stopped capturing errors since it has captured more than %d errors per second. Capturing will resume in %d seconds.|r",
	ERROR_UNABLE = "|cffffff00!BugGrabber is unable to retrieve errors from other players by itself. Please install BugSack or a similar display addon that might give you this functionality.|r",
	ERROR_DETECTED = "%s |cffffff00captured, click the link for more information.|r",
	NO_DISPLAY_1 = "|cffffff00You seem to be running !BugGrabber with no display addon to go along with it. Although a slash command is provided for accessing error reports, a display can help you manage these errors in a more convenient way.|r",
	NO_DISPLAY_2 = "|cffffff00The standard display is called BugSack, and can probably be found on the same site where you found !BugGrabber.|r",
	NO_DISPLAY_STOP = "|cffffff00If you don't want to be reminded about this again, run /stopnag.|r",
	STOP_NAG = "|cffffff00!BugGrabber will not nag about missing a display addon again until next patch.|r",
	USAGE = "|cffffff00Usage: /buggrabber <1-%d>.|r",
}
-----------------------------------------------------------------------
-- Locals
--

local frame = CreateFrame("Frame")

-- Should implement :FormatError(errorTable).
local displayObjectName = nil
for i = 1, GetNumAddOns() do
	local meta = GetAddOnMetadata(i, "X-BugGrabber-Display")
	if meta then
		local enabled = select(4, GetAddOnInfo(i))
		if enabled then
			displayObjectName = meta
			break
		end
	end
end

-- Shorthand to BugGrabberDB.errors
local db = nil

-- Errors we catch during the addon loading process, before our saved
-- variables are available. After the SVs have loaded, these will be
-- inserted into the proper DB.
local loadErrors = {}

local paused = nil
local isBugGrabbedRegistered = nil
local callbacks = nil
local playerName = UnitName("player")
local chatLinkFormat = "|Hbuggrabber:%s:%s|h|cffff0000[Error %s]|r|h"
local tableToString = "table: %s"

-----------------------------------------------------------------------
-- Callbacks
--

local function setupCallbacks()
	if not callbacks and LibStub and LibStub("CallbackHandler-1.0", true) then
		callbacks = LibStub("CallbackHandler-1.0"):New(addon)
		function callbacks:OnUsed(target, eventname)
			if eventname == "BugGrabber_BugGrabbed" then isBugGrabbedRegistered = true end
		end
		function callbacks:OnUnused(target, eventname)
			if eventname == "BugGrabber_BugGrabbed" then isBugGrabbedRegistered = nil end
		end
		setupCallbacks = nil
	end
end
setupCallbacks()

local function triggerEvent(...)
	if not callbacks then setupCallbacks() end
	if callbacks then callbacks:Fire(...) end
end

-----------------------------------------------------------------------
-- Utility
--

local function fetchFromDatabase(database, target)
	for i, err in next, database do
		if err.message == target then
			-- This error already exists
			err.counter = err.counter + 1
			err.session = addon:GetSessionId()

			return table.remove(database, i)
		end
	end
end

local function printErrorObject(err)
	local found = nil
	if displayObjectName and _G[displayObjectName] then
		local display = _G[displayObjectName]
		if type(display) == "table" and type(display.FormatError) == "function" then
			found = true
			print(display:FormatError(err))
		end
	end
	if not found then
		print(err.message)
		print(err.stack)
		print(err.locals)
	end
end

-- XXX Disabled until someone complains and demands that they return.
local function registerAddonActionEvents()
	--frame:RegisterEvent("ADDON_ACTION_BLOCKED")
	--frame:RegisterEvent("ADDON_ACTION_FORBIDDEN")
end

local function unregisterAddonActionEvents()
	--frame:UnregisterEvent("ADDON_ACTION_BLOCKED")
	--frame:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
end

local function pause()
	if paused then return end

	if not BUGGRABBER_SUPPRESS_THROTTLE_CHAT then
		print(L.BUGGRABBER_STOPPED:format(BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE, BUGGRABBER_TIME_TO_RESUME))
	end
	unregisterAddonActionEvents()
	paused = true
	triggerEvent("BugGrabber_CapturePaused")
end

local function resume()
	if not paused then return end

	if not BUGGRABBER_SUPPRESS_THROTTLE_CHAT then
		print(L.BUGGRABBER_RESUMING)
	end
	registerAddonActionEvents()
	paused = nil
	triggerEvent("BugGrabber_CaptureResumed")
end

-----------------------------------------------------------------------
-- Slash handler
--

local function slashHandler(index)
	if not db then return end
	index = tonumber(index)
	local err = type(index) == "number" and db[index] or nil
	if not index or not err or type(err) ~= "table" or (type(err.message) ~= "string" and type(err.message) ~= "table") then
		print(L.USAGE:format(#db))
		return
	end
	printErrorObject(err)
end

-----------------------------------------------------------------------
-- Error catching
--

local sanitizeStack, sanitizeLocals, findVersions = nil, nil, nil
do
	local function scanObject(o)
		local version, revision = nil, nil
		for k, v in pairs(o) do
			if type(k) == "string" and (type(v) == "string" or type(v) == "number") then
				local low = k:lower()
				if not version and low:find("version") then
					version = v
				elseif not revision and low:find("revision") then
					revision = v
				end
			end
			if version and revision then break end
		end
		return version, revision
	end

	local matchCache = setmetatable({}, { __index = function(self, object)
		if type(object) ~= "string" or #object < 3 then return end
		local found = nil
		-- First see if it's a library
		if LibStub then
			local lib, minor = LibStub(object, true)
			found = minor
		end
		-- Then see if we can get some addon metadata
		if not found and IsAddOnLoaded(object) then
			found = GetAddOnMetadata(object, "X-Curse-Packaged-Version")
			if not found then
				found = GetAddOnMetadata(object, "Version")
			end
		end
		-- Perhaps it's a global object?
		if not found then
			local o = _G[object] or _G[object:upper()]
			if type(o) == "table" then
				local v, r = scanObject(o)
				if v or r then
					found = tostring(v) .. "." .. tostring(r)
				end
			elseif o then
				found = o
			end
		end
		if not found then
			found = _G[object:upper() .. "_VERSION"]
		end
		if type(found) == "string" or type(found) == "number" then
			self[object] = found
			return found
		end
	end })
	local escapeCache = setmetatable({}, { __index = function(self, key)
		local escaped = key:gsub("([%.%-%(%)%+])", "%%%1")
		self[key] = escaped
		return escaped
	end })

	local tmp = {}
	local function replacer(start, object, tail)
		-- Have we matched this object before on the same line?
		-- (another pattern could re-match a previous match...)
		if tmp[object] then return end
		local found = matchCache[object]
		if found then
			tmp[object] = true
			return (start ~= 1 and start or "") .. object .. "-" .. found .. (type(tail) == "string" and tail or "")
		end
	end

	local matchers = {
		"(\\)([^\\]+)(%.lua)",       -- \Anything-except-backslashes.lua
		"^()([^\\]+)(\\)",           -- Start-of-the-line-until-first-backslash\
		"()(%a+%-%d%.?%d?)()",       -- Anything-#.#, where .# is optional
		"()(Lib%u%a+%-?%d?%.?%d?)()" -- LibXanything-#.#, where X is any capital letter and -#.# is optional
	}
	function findVersions(line)
		if not line or line:find("FrameXML\\") then return line end
		for i, m in next, matchers do
			line = line:gsub(m, replacer)
		end
		wipe(tmp)
		return line
	end

	function sanitizeStack(dump)
		if not dump then return end
		dump = dump:gsub("Interface\\", "")
		dump = dump:gsub("AddOns\\", "")
		dump = dump:gsub("%.%.%.[^\\]+\\", "")
		dump = dump:gsub("%[C%]:.-\n", "<in C code>\n")
		dump = dump:gsub("%<?%[string (\".-\")%](:%d+)%>?", "<string>:%1%2")
		dump = dump:gsub("[`']", "\"")
		return dump
	end

	function sanitizeLocals(dump)
		if not dump then return end
		dump = dump:gsub("Interface\\", "")
		dump = dump:gsub("AddOns\\", "")
		-- Reduce Foo\\Bar-3.0\\Bar-3.0.lua to Foo\\..\\Bar-3.0.lua to save room
		-- since wow crashes with strings > 983 chars and I don't want to split
		-- stuff, it's so hacky :/
		for token in dump:gmatch("\\([^\\]+)%.lua") do
			dump = dump:gsub(escapeCache[token] .. "\\", "..\\")
		end
		dump = dump:gsub("<function> defined", "<func>")
		dump = dump:gsub("{%s+}", "{}")
		return dump
	end
end

-- Error handler
local grabError
do
	local tmp = {}
	function grabError(errorMessage)
		if paused then return end
		errorMessage = tostring(errorMessage)

		local looping = errorMessage:find("BugGrabber") and true or nil
		if looping then
			print(errorMessage)
			return
		end

		local sanitizedMessage = findVersions(sanitizeStack(errorMessage))

		-- Insert the error into the correct database if it's not there
		-- already. If it is, just increment the counter.
		local found = nil
		if db then
			found = fetchFromDatabase(db, sanitizedMessage)
		else
			found = fetchFromDatabase(loadErrors, sanitizedMessage)
		end

		frame.count = frame.count + 1

		local errorObject = found

		if not errorObject then
			local stack = sanitizeStack(debugstack(3))

			-- Scan for version numbers in the stack
			for line in stack:gmatch("(.-)\n") do
				tmp[#tmp+1] = findVersions(line)
			end

			-- Store the error
			errorObject = {
				message = sanitizedMessage,
				stack = table.concat(tmp, "\n"),
				locals = sanitizeLocals(debuglocals(4)),
				session = addon:GetSessionId(),
				time = date("%Y/%m/%d %H:%M:%S"),
				counter = 1,
			}

			wipe(tmp)
		end

		addon:StoreError(errorObject)

		triggerEvent("BugGrabber_BugGrabbed", errorObject)

		if not isBugGrabbedRegistered then
			print(L.ERROR_DETECTED:format(addon:GetChatLink(errorObject)))
		end
	end
end

-----------------------------------------------------------------------
-- API
--

function addon:StoreError(errorObject)
	if db then
		db[#db + 1] = errorObject
		-- Save only the last MAX_BUGGRABBER_ERRORS errors (otherwise the SV gets too big)
		if #db > MAX_BUGGRABBER_ERRORS then
			table.remove(db, 1)
		end
	else
		loadErrors[#loadErrors + 1] = errorObject
	end
end

function addon:GetChatLink(errorObject)
	local tableId = tostring(errorObject):sub(8)
	return chatLinkFormat:format(playerName, tableId, tableId)
end

function addon:GetErrorByPlayerAndID(player, id)
	if player == playerName then return self:GetErrorByID(id) end
	print(L.ERROR_UNABLE)
end

function addon:GetErrorByID(id)
	local errorId = tableToString:format(id)
	for i, err in next, db do
		if tostring(err) == errorId then
			return err
		end
	end
end

function addon:GetErrorID(errorObject) return tostring(errorObject):sub(8) end
function addon:Reset() if BugGrabberDB then wipe(BugGrabberDB.errors) end end
function addon:GetDB() return db or loadErrors end
function addon:GetSessionId() return BugGrabberDB and BugGrabberDB.session or -1 end
function addon:IsPaused() return paused end

function addon:HandleBugLink(player, id, link)
	local errorObject = self:GetErrorByPlayerAndID(player, id)
	if errorObject then
		printErrorObject(errorObject)
	end
end

-----------------------------------------------------------------------
-- Initialization
--

local function initDatabase()
	-- Persist defaults and make sure we have sane SavedVariables
	if type(BugGrabberDB) ~= "table" then BugGrabberDB = {} end
	local sv = BugGrabberDB
	if type(sv.session) ~= "number" then sv.session = 0 end
	if type(sv.errors) ~= "table" then sv.errors = {} end

	-- From now on we can persist errors. Create a new session.
	sv.session = sv.session + 1

	-- Determine the correct database
	db = BugGrabberDB.errors -- db is a file-local variable
	-- Cut down on the nr of errors if it is over the MAX_BUGGRABBER_ERRORS
	while #db > MAX_BUGGRABBER_ERRORS do
		table.remove(db, 1)
	end

	-- If there were any load errors, we need to iterate them and
	-- insert the relevant ones into our SV DB.
	for i, err in next, loadErrors do
		err.session = sv.session -- Update the session ID directly
		local exists = fetchFromDatabase(db, err.message)
		addon:StoreError(exists or err)
	end
	wipe(loadErrors)

	if type(sv.lastSanitation) ~= "number" or sv.lastSanitation ~= 3 then
		for i, v in next, db do
			if type(v.message) == "table" then table.remove(db, i) end
		end
		sv.lastSanitation = 3
	end

	-- load locales
	if type(addon.LoadTranslations) == "function" then
		local locale = GetLocale()
		if locale ~= "enUS" and locale ~= "enGB" then
			addon:LoadTranslations(locale, L)
		end
		addon.LoadTranslations = nil
	end

	-- Only warn about missing display if we're running standalone.
	if not displayObjectName and bugGrabberParentAddon == STANDALONE_NAME then
		local currentInterface = select(4, GetBuildInfo())
		if type(currentInterface) ~= "number" then currentInterface = 0 end
		if not sv.stopnag or sv.stopnag < currentInterface then
			print(L.NO_DISPLAY_1)
			print(L.NO_DISPLAY_2)
			print(L.NO_DISPLAY_STOP)
			_G.SlashCmdList.BugGrabberStopNag = function()
				print(L.STOP_NAG)
				sv.stopnag = currentInterface
			end
			_G.SLASH_BugGrabberStopNag1 = "/stopnag"
		end
	end

	initDatabase = nil
end

do
	local function createSwatter()
		-- Need this so Stubby will feed us errors instead of just
		-- dumping them to the chat frame.
		_G.Swatter = {
			IsEnabled = function() return true end,
			OnError = function(msg, frame, stack, etype, ...)
				grabError(tostring(msg) .. tostring(stack))
			end,
			isFake = true,
		}
	end

	local swatterDisabled = nil
	function frame:ADDON_LOADED(event, msg)
		if not callbacks then setupCallbacks() end
		if msg == "Stubby" then createSwatter() end
		if initDatabase then
			-- If we're running embedded, just init as soon as possible,
			-- but if we are running separately we init when !BugGrabber
			-- loads so that our SVs are available.
			if bugGrabberParentAddon ~= STANDALONE_NAME or msg == bugGrabberParentAddon then
				initDatabase()
			end
		end

		if not swatterDisabled and _G.Swatter and not _G.Swatter.isFake then
			swatterDisabled = true
			print(L.ADDON_DISABLED:format("Swatter", "Swatter", "Swatter"))
			DisableAddOn("!Swatter")
			SlashCmdList.SWATTER = nil
			SLASH_SWATTER1, SLASH_SWATTER2 = nil, nil
			for k, v in pairs(Swatter) do
				if type(v) == "table" then
					if v.UnregisterAllEvents then
						v:UnregisterAllEvents()
					end
					if v.Hide then
						v:Hide()
					end
				end
			end
			Swatter = nil

			local enabled = select(4, GetAddOnInfo("Stubby"))
			if enabled then createSwatter() end

			real_seterrorhandler(grabError)
		end
	end
end

function frame:PLAYER_LOGIN()
	if not callbacks then setupCallbacks() end
	real_seterrorhandler(grabError)
end
function frame:ADDON_ACTION_FORBIDDEN(event, addonName, addonFunc)
	grabError(L.ADDON_CALL_PROTECTED:format(event, addonName or "<name>", addonFunc or "<func>"))
end
frame.ADDON_ACTION_BLOCKED = frame.ADDON_ACTION_FORBIDDEN -- XXX Unused?
frame:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
registerAddonActionEvents()

real_seterrorhandler(grabError)
function seterrorhandler() --[[ noop ]] end

do
	-- Flood protection
	local totalElapsed = 0
	frame.count = 0
	frame:SetScript("OnUpdate", function(self, elapsed)
		totalElapsed = totalElapsed + elapsed
		if totalElapsed > 1 then
			if not paused then
				-- Seems like we're getting more errors/sec than we want.
				if self.count > BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE then
					pause()
				end
				self.count = 0
				totalElapsed = 0
			elseif totalElapsed > BUGGRABBER_TIME_TO_RESUME then
				totalElapsed = 0
				resume()
			end
		end
	end)
end

do
	-- Set up the ItemRef hook that allow us to link bugs.
	local origHandler = _G.ChatFrame_OnHyperlinkShow
	_G.ChatFrame_OnHyperlinkShow = function(chatFrame, link, ...)
		local player, tableId = link:match("^buggrabber:(%a+):(%x+)")
		if not player or not tableId then return origHandler(chatFrame, link, ...) end
		if IsModifiedClick("CHATLINK") then
			ChatEdit_InsertLink(link)
		else
			addon:HandleBugLink(player, tableId, link, chatFrame, ...)
		end
	end
end

-- Set up slash command
_G.SlashCmdList.BugGrabber = slashHandler
_G.SLASH_BugGrabber1 = "/buggrabber"
_G.BugGrabber = addon

