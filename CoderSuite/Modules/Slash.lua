-- Data: 28.01.2011
-- Sobre: Todo o gerenciamento dos comandos via chat "/comando" serão feitos aqui.

function CoderSuite:RegisterSlash()
	--LibStub("AceConfig-3.0"):RegisterOptionsTable("CoderSuite", options, {"codersuite", "cs"})
	
	
	-- [Reload] --
	CoderSuite:RegisterChatCommand("rl", ReloadUI)

	-- [Ready Check] --
	CoderSuite:RegisterChatCommand("rdy", DoReadyCheck)
	CoderSuite:RegisterChatCommand("rc", DoReadyCheck)

	-- [Ticket] --
	CoderSuite:RegisterChatCommand("ticket", ToggleHelpFrame)
	CoderSuite:RegisterChatCommand("gm", ToggleHelpFrame)
		
	-- [Dungeon/Raids Reset]--
	CoderSuite:RegisterChatCommand("dgreset", ResetInstances)
	CoderSuite:RegisterChatCommand("dgr", ResetInstances)
		
	-- [Dungeon/Raids Teleport]--
	CoderSuite:RegisterChatCommand("dg", function() CoderSuite:InDungeon() end)
		
	-- [Votekick]--	
	CoderSuite:RegisterChatCommand("votekick", UninviteUnit(UnitName("target")))
	
	-- [Calendar]--
	CoderSuite:RegisterChatCommand("cal", ToggleCalendar)
	CoderSuite:RegisterChatCommand("calendar", ToggleCalendar)
	
	-- [Calendar]--
	CoderSuite:RegisterChatCommand("leave", LeaveParty)
	
	-- [Logout/Quit]--
	CoderSuite:RegisterChatCommand("logout", Logout)
	CoderSuite:RegisterChatCommand("q", Quit)
	
	-- [Take Screenshot] -- 
	CoderSuite:RegisterChatCommand("ss", TakeScreenshot)
	
	-- [List of Help] -- 
	CoderSuite:RegisterChatCommand("coder", function() CoderSuite:CoderListCommand() end)		
	
	-- [Raid Seetings]--
	self:RegisterChatCommand("10", function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(1) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end)
	self:RegisterChatCommand("10h", function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(3) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end)
	self:RegisterChatCommand("25", function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(2) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end)
	self:RegisterChatCommand("25h", function() if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then if IsRaidLeader() then SetRaidDifficulty(4) else print("|cffcd0000Error: You aren't the Raid Leader.|r") end else print("|cffcd0000Error: Not in a group.|r") end end)	
end

function CoderSuite:InDungeon()	
	local _inInstance, _ = IsInInstance()
	if _inInstance then		
		LFGTeleport(true);
		CoderSuite:Print(ChatFrame1, "Leaving instance.")
	else		
		LFGTeleport();
		CoderSuite:Print(ChatFrame1, "Entering instance.")
	end
end

function CoderSuite:CoderListCommand()
	CoderSuite:Print(ChatFrame1, "".._tVerde.."===========================")
	CoderSuite:Print(ChatFrame1, "".._tVerde.."====  ".._tCinzaClaro.."Command list of CoderSuite ".._v.._tVerde.." =====")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/cal ".._tBranco.."or".._tLaranja.." /calendar".._tBranco.." - Toggle Calendar window.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/dg ".._tBranco.." - Teleport to dungeon/raid if you are in a group and not in the instance and Teleport out of dungeon/raid if you are in a group and inside the instance.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/dgreset ".._tBranco.."or ".._tLaranja.."/dgr ".._tBranco.." - Reset all instances.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/leave ".._tBranco.." - Leave you group (party or raid).")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/logout ".._tBranco.." - Log out the current char.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/pull ".._tBranco.." - Initiate a countdown in the format /pull 5 will count 5 seconds.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/q ".._tBranco.." - Quit WoW.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/rl ".._tBranco.." - Reload the UI.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/rdy ".._tBranco.."or".._tLaranja.." /rc ".._tBranco.." - Perform a Ready Check.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/ss ".._tBranco.." - Take a Screenshot.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/ticket ".._tBranco.."or".._tLaranja.." /gm ".._tBranco.." - Open support/ticket window.")
	CoderSuite:Print(ChatFrame1, "".._tLaranja.."/votekick ".._tBranco.." - Initiate a votekick against your current target.")
	CoderSuite:Print(ChatFrame1, "".._tVerde.."===========================")
end