--[[

Author: Trelis @ Proudmoore
(shamanfriend (a) stassart o org)

Original Author: Glyph @ EU-Sylvanas (2007-2009)

See info.txt for more information

Copyright 2009-2011 Benjamin Stassart

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]

-- Disable ShamanFriend if the player is not a shaman
if select(2, UnitClass('player')) ~= "SHAMAN" then
        DisableAddOn("ShamanFriend")
        return
end

local L = LibStub("AceLocale-3.0"):GetLocale("ShamanFriend")
local AceAddon = LibStub("AceAddon-3.0")
ShamanFriend = AceAddon:NewAddon("ShamanFriend", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "LibSink-2.0")

-- Add configmode support (i.e. OneButtonConfig)
-- Create the global table if it does not exist yet
CONFIGMODE_CALLBACKS = CONFIGMODE_CALLBACKS or {}
-- Declare our handler
CONFIGMODE_CALLBACKS["ShamanFriend"] = function(action)
	if action == "ON" then
		ShamanFriend.configMode = true
		ShamanFriend:UpdateLock()
	elseif action == "OFF" then
		ShamanFriend.configMode = false
		ShamanFriend:UpdateLock()
	end
end

local options = {
	name = "Shaman Friend",
	handler = ShamanFriend,
	type ='group',
	childGroups ='tree',
	desc = L["Options for ShamanFriend"],
	args = {
		ui = {
			name = L["Show UI"],
			type = "execute",
			desc = L["Shows the Graphical User Interface"],
			func = "OpenConfig",
			guiHidden = true,
			order = 999,
		},
		version = {
			name = L["Show version"],
			type = "execute",
			desc = L["Show version"],
			func = "ShowVersion",
			guiHidden = true,
			order = 998,
		},
		alert = {
			name = L["Alerts"],
			type = 'group',
			desc = L["Settings for Elemental Shields and Weapon Enchants."],
			order = 200, 
			args = {
				shield = {
					name = L["Elemental Shield"],
					type = "toggle",
					desc = L["Toggle check for Elemental Shield."],
					get = function(info) return ShamanFriend.db.profile.alert.shield end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.shield = v
						ShamanFriend:LoadEvents()
					end,
					order = 201,
				},
				weapon = {
					name = L["Weapon Enchant"],
					type = "toggle",
					desc = L["Toggle check for Weapon Enchants."],
					get = function(info) return ShamanFriend.db.profile.alert.weapon end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.weapon = v
						ShamanFriend:LoadEvents()
					end,
					order = 202,
				},
				buff_sound = {
					name = L["Sound"],
					type = "select",
					desc = L["Play a sound when a buff is missing."],
					get = function(info) return ShamanFriend.db.profile.alert.sound end,
					set = function(info,v) ShamanFriend.db.profile.alert.sound = v	end,
					values = {
						["ding"] = L["Ding"],
						["dong"] = L["Dong"],
						["dodo"] = L["Dodo"],
						["bell"] = L["Bell"],
						["none"] = L["None"],
					},
					order = 203,
				},
				h204 = {type = "header", name = " ", order = 204},
				entercombat = {
					name = L["Enter Combat"],
					type = "toggle",
					desc = L["Notify when entering combat."],
					get = function(info) return ShamanFriend.db.profile.alert.entercombat end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.entercombat = v
						ShamanFriend:LoadEvents()
					end,
					order = 205,
				},
				aftercombat = {
					name = L["After Combat"],
					type = "toggle",
					desc = L["Notify after the end of combat."],
					get = function(info) return ShamanFriend.db.profile.alert.aftercombat end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.aftercombat = v
						ShamanFriend:LoadEvents()
					end,
					order = 206,
				},
				mounted = {
					name = L["No Mounted"],
					type = "toggle",
					desc = L["Disable notifications when mounted."],
					get = function(info) return ShamanFriend.db.profile.alert.mounted end,
					set = function(info,v) ShamanFriend.db.profile.alert.mounted = v end,
					order = 207,
				},
				vehicle = {
					name = L["No Vehicle"],
					type = "toggle",
					desc = L["Disable notifications when in a vehicle."],
					get = function(info) return ShamanFriend.db.profile.alert.vehicle end,
					set = function(info,v) ShamanFriend.db.profile.alert.vehicle = v end,
					order = 208,
				},
				h209 = {type = "header", name = " ", order = 209},
				maelstrom = {
					name = L["Maelstrom Weapon"],
					type = "toggle",
					desc = L["Toggle Maelstrom information."],
					get = function(info) return ShamanFriend.db.profile.alert.maelstrom end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.maelstrom = v
						ShamanFriend:LoadEvents()
					end,
					order = 210,
				},
				surge = {
					name = L["Lava Surge"],
					type = "toggle",
					desc = L["Toggle Lava Surge information."],
					get = function(info) return ShamanFriend.db.profile.alert.surge end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.surge = v
						ShamanFriend:LoadEvents()
					end,
					order = 211,
				},
				fulmination = {
					name = L["Fulmination"],
					type = "toggle",
					desc = L["Alert when lightning shield hits 9 stacks."],
					get = function(info) return ShamanFriend.db.profile.alert.fulmination end,
					set = function(info,v)
						ShamanFriend.db.profile.alert.fulmination = v
						ShamanFriend:LoadEvents()
					end,
					order = 212,
				},
				proc_sound = {
					name = L["Sound"],
					type = "select",
					desc = L["Play a sound when a proc occurs."],
					get = function(info) return ShamanFriend.db.profile.alert.proc_sound end,
					set = function(info,v) ShamanFriend.db.profile.alert.proc_sound = v	end,
					values = {
						["ding"] = L["Ding"],
						["dong"] = L["Dong"],
						["dodo"] = L["Dodo"],
						["bell"] = L["Bell"],
						["none"] = L["None"],
					},
					order = 213,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.alert.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.alert.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.alert.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.alert.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.alert.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.alert.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.alert.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.alert.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},
		spell = {
			name = L["Spells"],
			type = 'group',
			desc = L["Settings regarding different spells."],
			order = 300,
			args = {
				purge = {
					name = L["Purge"],
					type = "toggle",
					desc = L["Toggle Purge information."],
					get = function(info) return ShamanFriend.db.profile.spell.purge end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.purge = v
						ShamanFriend:LoadEvents()
					end,
					order = 301,
				},
				purgemsg = {
					name = L["Broadcast Purge"],
					type = "select",
					desc = L["Broadcast Purge message to the following chat. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.spell.purgemsg end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.purgemsg = v
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.purge end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["RAID_WARNING"] = L["Raid Warning"],
						["SAY"] = L["Say"],
						["none"] = L["None"],
					},
					order = 302,
				},
				h303 = {type = "header", name = " ", order = 303},
				interrupt = {
					name = L["Interrupt"],
					type = "toggle",
					desc = L["Toggle Interrupt information."],
					get = function(info) return ShamanFriend.db.profile.spell.interrupt end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.interrupt = v
						ShamanFriend:LoadEvents()
					end,
					order = 304,
				},
				interruptmsg = {
					name = L["Broadcast Interrupt"],
					type = "select",
					desc = L["Broadcast Interrupt message to the following chat. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.spell.interruptmsg end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.interruptmsg = v
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.interrupt end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["RAID_WARNING"] = L["Raid Warning"],
						["SAY"] = L["Say"],
						["none"] = L["None"],
					},
					order = 305,
				},
				h306 = {type = "header", name = " ", order = 306},
				target = {
					name = L["Add target"],
					type = "toggle",
					desc = L["Add the target to the end of the message when broadcasting."],
					get = function(info) return ShamanFriend.db.profile.spell.target end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.target = v
					end,
					order = 307,
				},
				h308 = {type = "header", name = " ", order = 308},
				ground = {
					name = L["Grounding Totem"],
					type = "toggle",
					desc = L["Toggle message when Grounding Totem absorbs a spell."],
					get = function(info) return ShamanFriend.db.profile.spell.ground end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.ground = v
						ShamanFriend:LoadEvents()
					end,
					order = 309,
				},
				groundself = {
					name = L["Ground self only"],
					type = "toggle",
					desc = L["Only show grounding message for your own Grounding Totem"],
					get = function(info) return ShamanFriend.db.profile.spell.groundself end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.groundself = v
						ShamanFriend:LoadEvents()
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.ground end,
					order = 310,
				},
				groundmsg = {
					name = L["Broadcast Grounding Totem"],
					type = "select",
					desc = L["Broadcast Grounding Totem message to the following chat. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.spell.groundmsg end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.groundmsg = v
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.ground end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["RAID_WARNING"] = L["Raid Warning"],
						["SAY"] = L["Say"],
						["none"] = L["None"],
					},
					order = 311,
				},
				h312 = {type = "header", name = " ", order = 312},
				bloodlust = {
					name = L["Bloodlust message"],
					type = "toggle",
					desc = L["Send a message when Bloodlust/Heroism is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.bloodlust end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.bloodlust = v
						ShamanFriend:LoadEvents()
					end,
					order = 313,
				},
				bloodlusttext = {
					name = L["Bloodlust text"],
					type = "input",
					desc = L["The text in the message when Bloodlust/Heroism is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.bloodlusttext end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.bloodlusttext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = "%t = your target",
					disabled = function() return not ShamanFriend.db.profile.spell.bloodlust end,
					order = 314,
				},
				bloodlustchat = {
					name = L["Bloodlust chat"],
					type = "select",
					desc = L["Chat for the Bloodlust/Heroism message."],
					get = function(info) return ShamanFriend.db.profile.spell.bloodlustchat end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.bloodlustchat = v
						-- ShamanFriend:LoadEvents()
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.bloodlust end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["YELL"] = L["Yell"],
						["SAY"] = L["Say"],
						["RAID_WARNING"] = L["Raid Warning"],
					},
					order = 315,
				},
				h316 = {type = "header", name = " ", order = 316},
				manatide = {
					name = L["Mana Tide message"],
					type = "toggle",
					desc = L["Send a message when Mana Tide is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.manatide end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.manatide = v
						ShamanFriend:LoadEvents()
					end,
					order = 317,
				},
				manatidetext = {
					name = L["Mana Tide text"],
					type = "input",
					desc = L["The text in the message when Mana Tide is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.manatidetext end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.manatidetext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = "%t = your target",
					disabled = function() return not ShamanFriend.db.profile.spell.manatide end,
					order = 318,
				},
				manatidechat = {
					name = L["Mana Tide chat"],
					type = "select",
					desc = L["Chat for the Mana Tide message."],
					get = function(info) return ShamanFriend.db.profile.spell.manatidechat end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.manatidechat = v
						-- ShamanFriend:LoadEvents()
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.manatide end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["YELL"] = L["Yell"],
						["SAY"] = L["Say"],
						["RAID_WARNING"] = L["Raid Warning"],
					},
					order = 319,
				},
				h320 = {type = "header", name = " ", order = 320},
				feralspirit = {
					name = L["Feral Spirit message"],
					type = "toggle",
					desc = L["Send a message when Feral Spirit is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.feralspirit end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.feralspirit = v
						ShamanFriend:LoadEvents()
					end,
					order = 321,
				},
				feralspirittext = {
					name = L["Feral Spirit text"],
					type = "input",
					desc = L["The text in the message when Feral Spirit is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.feralspirittext end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.feralspirittext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = "%t = your target",
					disabled = function() return not ShamanFriend.db.profile.spell.feralspirit end,
					order = 322,
				},
				feralspiritchat = {
					name = L["Feral Spirit chat"],
					type = "select",
					desc = L["Chat for the Feral Spirit message."],
					get = function(info) return ShamanFriend.db.profile.spell.feralspiritchat end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.feralspiritchat = v
						-- ShamanFriend:LoadEvents()
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.feralspirit end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["YELL"] = L["Yell"],
						["SAY"] = L["Say"],
						["RAID_WARNING"] = L["Raid Warning"],
					},
					order = 323,
				},
				h324 = {type = "header", name = " ", order = 324},
				dispel = {
					name = L["Dispel"],
					type = "toggle",
					desc = L["Toggle message when dispel is cast."],
					get = function(info) return ShamanFriend.db.profile.spell.dispel end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.dispel = v
						ShamanFriend:LoadEvents()
					end,
					order = 325,
				},
				dispelmsg = {
					name = L["Broadcast Dispel"],
					type = "select",
					desc = L["Broadcast dispel message to the following chat. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.spell.dispelmsg end,
					set = function(info,v)
						ShamanFriend.db.profile.spell.dispelmsg = v
					end,
					disabled = function() return not ShamanFriend.db.profile.spell.dispel end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["RAID_WARNING"] = L["Raid Warning"],
						["none"] = L["None"],
					},
					order = 326,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.spell.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.spell.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.spell.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.spell.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.spell.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.spell.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.spell.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.spell.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},
		display = {
			name = L["General Display"],
			type = 'group',
			desc = L["General Display settings and options for the Custom Message Frame."],
			order = 100, 
			args = {
				chat = {
					name = L["In Chat"],
					type = "toggle",
					desc = L["Display message in Chat Frame."],
					get = function(info) return ShamanFriend.db.profile.display.chat end,
					set = function(info,v) ShamanFriend.db.profile.display.chat = v end,
					order = 110,
				},
				number= {
					name = L["Chat number"],
					type = "range",
					desc = L["Choose which chat to display the messages in (0=default)."],
					get = function(info) return ShamanFriend.db.profile.display.number end,
					set = function(info,v)
						ShamanFriend.db.profile.display.number = v
					end,
					step = 1,
					min = 0,
					max = 10,
					order = 111,
				},
				screen = {
					name = L["On Screen"],
					type = "toggle",
					desc = L["Display message in Blizzard UI Error Frame."],
					get = function(info) return ShamanFriend.db.profile.display.screen end,
					set = function(info,v) ShamanFriend.db.profile.display.screen = v end,
					order = 120,
				},
				frame = {
					name = L["Custom Frame"],
					type = "toggle",
					desc = L["Display message in Custom Message Frame."],
					get = function(info) return ShamanFriend.db.profile.display.frame end,
					set = function(info,v)
						ShamanFriend.db.profile.display.frame = v
						ShamanFriend:LoadEvents()
					end,
					order = 130,
				},
				lock = {
					name = L["Lock"],
					type = "toggle",
					desc = L["Toggle locking of the Custom Message Frame."],
					get = function(info) return ShamanFriend.db.profile.display.lock end,
					set = function(info,v)
						ShamanFriend.db.profile.display.lock = v
						ShamanFriend:UpdateLock()
					end,
					order = 131,
				},
				fontSize = {
					name = L["Font Size"],
					type = "range",
					desc = L["Set the font size in the Custom Message Frame."],
					get = function(info) return ShamanFriend.db.profile.display.fontSize end,
					set = function(info,v)
						ShamanFriend.db.profile.display.fontSize = v
						ShamanFriend:UpdateFont()
					end,
					step = 1,
					min = 8,
					max = 32,
					order = 132,
				},
				fontFace = {
					name = L["Font Face"],
					type = "select",
					desc = L["Set the font face in the Custom Message Frame."],
					get = function(info) return ShamanFriend.db.profile.display.fontFace end,
					set = function(info,v)
						ShamanFriend.db.profile.display.fontFace = v
						ShamanFriend:UpdateFont()
					end,
					values = {
						[L["FRIZQT__.TTF"]] = L["Normal"],
						[L["ARIALN.TTF"]] = L["Arial"],
						[L["skurri.ttf"]] = L["Skurri"],
						[L["MORPHEUS.ttf"]] = L["Morpheus"],
					},
					order = 133,
				},
				fontEffect = {
					name = L["Font Effect"],
					type = "select",
					desc = L["Set the font effect in the Custom Message Frame."],
					get = function(info) return ShamanFriend.db.profile.display.fontEffect end,
					set = function(info,v)
						ShamanFriend.db.profile.display.fontEffect = v
						ShamanFriend:UpdateFont()
					end,
					values = {
						["none"] = L["None"],
						[L["OUTLINE"]] = L["OUTLINE"],
						[L["THICKOUTLINE"]] = L["THICKOUTLINE"],
						[L["MONOCHROME"]] = L["MONOCHROME"],
					},
					order = 134,
				},
				BGAnnounce = {
					name = L["BG Announce"],
					type = "select",
					desc = L["Announce when in battlegrounds."],
					get = function(info) return ShamanFriend.db.profile.display.bgannounce end,
					set = function(info,v)
						ShamanFriend.db.profile.display.bgannounce = v
						ShamanFriend:LoadEvents()
					end,
					values = {
						["BATTLEGROUND"] = L["Battleground"],
						["PARTY"] = L["Party"],
						["YELL"] = L["Yell"],
						["SAY"] = L["Say"],
						["none"] = L["None"],
					},
					order = 135,
				},
				ArenaAnnounce = {
					name = L["Arena Announce"],
					type = "toggle",
					desc = L["Announce when in arena."],
					get = function(info) return ShamanFriend.db.profile.display.arenaannounce end,
					set = function(info,v)
						ShamanFriend.db.profile.display.arenaannounce = v
						ShamanFriend:LoadEvents()
					end,
					order = 136,
				},
				PartyAnnounce = {
					name = L["5-man Announce"],
					type = "toggle",
					desc = L["Announce when in a 5-man instance."],
					get = function(info) return ShamanFriend.db.profile.display.partyannounce end,
					set = function(info,v)
						ShamanFriend.db.profile.display.partyannounce = v
						ShamanFriend:LoadEvents()
					end,
					order = 137,
				},
				RaidAnnounce = {
					name = L["Raid Announce"],
					type = "toggle",
					desc = L["Announce when in a raid instance."],
					get = function(info) return ShamanFriend.db.profile.display.raidannounce end,
					set = function(info,v)
						ShamanFriend.db.profile.display.raidannounce = v
						ShamanFriend:LoadEvents()
					end,
					order = 138,
				},
				WorldAnnounce = {
					name = L["World Announce"],
					type = "toggle",
					desc = L["Announce when not in instances."],
					get = function(info) return ShamanFriend.db.profile.display.worldannounce end,
					set = function(info,v)
						ShamanFriend.db.profile.display.worldannounce = v
						ShamanFriend:LoadEvents()
					end,
					order = 139,
				},
			}
		},
		wf = {
			name = L["Windfury"],
			type = 'group',
			desc = L["Settings for Windfury counter."],
			order = 500,
			args = {
				enable = {
					name = L["Enable"],
					type = "toggle",
					desc = L["Enable WF hit counter."],
					get = function(info) return ShamanFriend.db.profile.wf.enable end,
					set = function(info,v)
						ShamanFriend.db.profile.wf.enable = v
						ShamanFriend:LoadEvents()
					end,
					order = 501,
				},
				crit = {
					name = L["Crit"],
					type = "toggle",
					desc = L["Enable display of WF crits."],
					get = function(info) return ShamanFriend.db.profile.wf.crit end,
					set = function(info,v) ShamanFriend.db.profile.wf.crit = v end,
					disabled = function() return not ShamanFriend.db.profile.wf.enable end,
					order = 502,
				},
				miss = {
					name = L["Miss"],
					type = "toggle",
					desc = L["Enable display of WF misses."],
					get = function(info) return ShamanFriend.db.profile.wf.miss end,
					set = function(info,v) ShamanFriend.db.profile.wf.miss = v end,
					disabled = function() return not ShamanFriend.db.profile.wf.enable end,
					order = 503,
				},
				hand = {
					name = L["Hand"],
					type = "toggle",
					desc = L["Show which hand the proc comes from"],
					get = function(info) return ShamanFriend.db.profile.wf.hand end,
					set = function(info,v) ShamanFriend.db.profile.wf.hand = v end,
					disabled = function() return not ShamanFriend.db.profile.wf.enable end,
					order = 503,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.wf.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.wf.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.wf.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.wf.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.wf.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.wf.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.wf.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.wf.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},
		lo = {
			name = L["Lightning Overload"],
			type = 'group',
			desc = L["Settings for Lightning Overload."],
			order = 400,
			args = {
				enable = {
					name = L["Enable"],
					type = "toggle",
					desc = L["Toggle whether to show a message when Lightning Overload procs."],
					get = function(info) return ShamanFriend.db.profile.lo.enable end,
					set = function(info,v)
						ShamanFriend.db.profile.lo.enable = v
						ShamanFriend:LoadEvents()
					end,
					order = 401,
				},
				crit = {
					name = L["Crit"],
					type = "toggle",
					desc = L["Enable display of Lightning Overload crits."],
					get = function(info) return ShamanFriend.db.profile.lo.crit end,
					set = function(info,v) ShamanFriend.db.profile.lo.crit = v end,
					disabled = function() return not ShamanFriend.db.profile.lo.enable end,
					order = 403,
				},
				damage = {
					name = L["Damage"],
					type = "toggle",
					desc = L["Enable display of Lightning Overload total damage."],
					get = function(info) return ShamanFriend.db.profile.lo.damage end,
					set = function(info,v) ShamanFriend.db.profile.lo.damage = v end,
					disabled = function() return not ShamanFriend.db.profile.lo.enable end,
					order = 404,
				},
				miss = {
					name = L["Miss"],
					type = "toggle",
					desc = L["Enable display of Lightning Overload misses."],
					get = function(info) return ShamanFriend.db.profile.lo.miss end,
					set = function(info,v) ShamanFriend.db.profile.lo.miss = v end,
					disabled = function() return not ShamanFriend.db.profile.lo.enable end,
					order = 405,
				},
				fulmination = {
					name = L["Fulmination"],
					type = "toggle",
					desc = L["Fulmination"],
					get = function(info) return ShamanFriend.db.profile.lo.fulmination end,
					set = function(info,v)
						ShamanFriend.db.profile.lo.fulmination = v
						ShamanFriend:LoadEvents()
					end,
					order = 406,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.lo.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.lo.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.lo.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.lo.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.lo.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.lo.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.lo.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.lo.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},
		eshield = {
			name = L["Earth Shield"],
			type = 'group',
			desc = L["Settings for Earth Shield."],
			order = 500,
			args = {
				enable = {
					name = L["Enable"],
					type = "toggle",
					desc = L["Toggle Earth Shield tracker"],
					get = function(info) return ShamanFriend.db.profile.eshield.enable end,
					set = function(info,v)
						ShamanFriend.db.profile.eshield.enable = v
						ShamanFriend:LoadEvents()
					end,
					order = 501,
				},
				lock = {
					name = L["Lock tracker"],
					type = "toggle",
					desc = L["Lock Earth Shield tracker."],
					get = function(info) return ShamanFriend.db.profile.eshield.lock end,
					set = function(info,v)
						ShamanFriend.db.profile.eshield.lock = v
						ShamanFriend:SetButtonMode()
					end,
					order = 502,
				},
				tooltip = {
					name = L["Disable tooltip"],
					type = "toggle",
					desc = L["Disable Earth Shield tracker tooltip."],
					get = function(info) return ShamanFriend.db.profile.eshield.notooltip end,
					set = function(info,v)
						ShamanFriend.db.profile.eshield.notooltip = v
					end,
					order = 503,
				},
				button = {
					name = L["Button only"],
					type = "toggle",
					desc = L["Show only the Earth Shield button."],
					get = function(info) return ShamanFriend.db.profile.eshield.button end,
					set = function(info,v)
						ShamanFriend.db.profile.eshield.button = v
						ShamanFriend:SetButtonMode()
					end,
					order = 504,
				},
				h505 = {type = "header", name = " ", order = 505},
				alert = {
					name = L["Alert when fading"],
					type = "toggle",
					desc = L["Alert me when Earth Shield fades from my target."],
					get = function(info) return ShamanFriend.db.profile.eshield.alert end,
					set = function(info,v)
						ShamanFriend.db.profile.eshield.alert = v
					end,
					order = 506,
				},
				sound = {
					name = L["Sound"],
					type = "select",
					desc = L["Play a sound when Earth Shield fades from my target."],
					get = function(info) return ShamanFriend.db.profile.eshield.sound end,
					set = function(info,v) ShamanFriend.db.profile.eshield.sound = v	end,
					values = {
						["ding"] = L["Ding"],
						["dong"] = L["Dong"],
						["dodo"] = L["Dodo"],
						["bell"] = L["Bell"],
						["none"] = L["None"],
					},
					order = 507,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.eshield.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.eshield.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.eshield.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.eshield.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.eshield.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.eshield.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.eshield.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.eshield.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},
		cc = {
			name = L["CC"],
			type = 'group',
			desc = L["Settings for Crowd Control."],
			order = 600,
			args = {
				success = {
					name = L["Success"],
					type = "toggle",
					desc = L["Display when successfully CCing a target."],
					get = function(info) return ShamanFriend.db.profile.cc.success end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.success = v
						ShamanFriend:LoadEvents()
					end,
					order = 602,
				},
				successtext = {
					name = L["Success text"],
					type = "input",
					desc = L["The text in the message when CC succeeds."],
					get = function(info) return ShamanFriend.db.profile.cc.successtext end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.successtext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = L["TARGET = CC target"],
					disabled = function() return not ShamanFriend.db.profile.cc.success end,
					order = 603,
				},
				fail = {
					name = L["Fail"],
					type = "toggle",
					desc = L["Display when CCing a target fails."],
					get = function(info) return ShamanFriend.db.profile.cc.fail end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.fail = v
						ShamanFriend:LoadEvents()
					end,
					order = 604,
				},
				failtext = {
					name = L["Fail text"],
					type = "input",
					desc = L["The text in the message when CC fails."],
					get = function(info) return ShamanFriend.db.profile.cc.failtext end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.failtext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = L["TARGET = CC target"],
					disabled = function() return not ShamanFriend.db.profile.cc.fail end,
					order = 605,
				},
				remove = {
					name = L["Remove"],
					type = "toggle",
					desc = L["Display when CC is removed from a target."],
					get = function(info) return ShamanFriend.db.profile.cc.remove end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.remove = v
						ShamanFriend:LoadEvents()
					end,
					order = 606,
				},
				removetext = {
					name = L["Remove text"],
					type = "input",
					desc = L["The text in the message when CC is removed."],
					get = function(info) return ShamanFriend.db.profile.cc.removetext end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.removetext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = L["TARGET = CC target"],
					disabled = function() return not ShamanFriend.db.profile.cc.remove end,
					order = 607,
				},
				ccchat = {
					name = L["Broadcast CC"],
					type = "select",
					desc = L["Broadcast CC message to the following chat. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.cc.ccchat end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.ccchat = v
					end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["YELL"] = L["Yell"],
						["SAY"] = L["Say"],
						["RAID_WARNING"] = L["Raid Warning"],
						["none"] = L["None"],
					},
					order = 608,
				},
				h609 = {type = "header", name = " ", order = 609},
				broken = {
					name = L["Broken"],
					type = "toggle",
					desc = L["Display when CC is broken."],
					get = function(info) return ShamanFriend.db.profile.cc.broken end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.broken = v
						ShamanFriend:LoadEvents()
					end,
					order = 610,
				},
				brokentext = {
					name = L["Broken text"],
					type = "input",
					desc = L["The text in the message when CC is broken."],
					get = function(info) return ShamanFriend.db.profile.cc.brokentext end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.brokentext = v
						-- ShamanFriend:LoadEvents()
					end,
					usage = L["SOURCE = Source of break, TARGET = CC target"],
				 	disabled = function() return not ShamanFriend.db.profile.cc.broken end,
					order = 611,
				},
				brokenchat = {
					name = L["Broadcast Broken CC"],
					type = "select",
					desc = L["Broadcast Broken CC message to the following chat. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.cc.brokenchat end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.brokenchat = v
					end,
					values = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["YELL"] = L["Yell"],
						["SAY"] = L["Say"],
						["RAID_WARNING"] = L["Raid Warning"],
						["none"] = L["None"],
					},
					order = 612,
				},
				tanktime = {
					name = L["Tank break time"],
					type = "range",
					desc = L["Do not warn if the tank breaks CC after this time"],
					get = function(info) return ShamanFriend.db.profile.cc.tanktime end,
					set = function(info,v)
						ShamanFriend.db.profile.cc.tanktime = v
						end,
					step = 1,
					min = 0,
					max = 60,
					order = 613,
				},
				sound = {
					name = L["Sound"],
					type = "select",
					desc = L["Play a sound when CC fades from my target."],
					get = function(info) return ShamanFriend.db.profile.cc.sound end,
					set = function(info,v) ShamanFriend.db.profile.cc.sound = v	end,
					values = {
						["ding"] = L["Ding"],
						["dong"] = L["Dong"],
						["dodo"] = L["Dodo"],
						["bell"] = L["Bell"],
						["none"] = L["None"],
					},
					order = 614,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.cc.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.cc.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.cc.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.cc.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.cc.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.cc.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.cc.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.cc.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 614,
						},
					}
				},
			}
		},
		--[[totem = {
			name = L["Totems"],
			type = 'group',
			desc = L["Settings for Totems."],
			order = 500,
			args = {
				kill = {
					name = L["Warn on kill"],
					type = "toggle",
					desc = L["Shows a message whenether one of your totems are killed."],
					get = function(info) return ShamanFriend.db.profile.totem.kill end,
					set = function(info,v)
						ShamanFriend.db.profile.totem.kill = v
						ShamanFriend:LoadEvents()
					end,
					order = 501,
				},
				killmsg = {
					name = L["Broadcast on kill"],
					type = "text",
					desc = L["Broadcast to the following chat when one of your totems are killed. (Above option must be enabled)"],
					get = function(info) return ShamanFriend.db.profile.totem.killmsg end,
					set = function(info,v)
						ShamanFriend.db.profile.totem.killmsg = v
					end,
					disabled = function() return not ShamanFriend.db.profile.totem.killmsg end,
					validate = {
						["RAID"] = L["Raid"],
						["PARTY"] = L["Party"],
						["RAID_WARNING"] = L["Raid Warning"],
						["none"] = L["None"],
					},
					order = 502,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.totem.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.totem.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.totem.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.totem.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.lo.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.totem.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.totem.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.totem.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},]]
		misc = {
			name = L["Miscellaneous"],
			type = 'group',
			desc = L["Various other small notices/usefull functions."],
			order = 800,
			args = {
				elet5 = {
					name = L["Elemental T5 2-piece bonus"],
					type = "toggle",
					desc = L["Show a message when you get the proc from the Elemental Tier5 2-piece bonus"],
					get = function(info) return ShamanFriend.db.profile.misc.elet5 end,
					set = function(info,v)
						ShamanFriend.db.profile.misc.elet5 = v
						ShamanFriend:LoadEvents()
					end,
				},
				enht5 = {
					name = L["Enhancement T5 2-piece bonus"],
					type = "toggle",
					desc = L["Show a message when you get the proc from the Enhancement Tier5 2-piece bonus"],
					get = function(info) return ShamanFriend.db.profile.misc.enht5 end,
					set = function(info,v)
						ShamanFriend.db.profile.misc.enht5 = v
						ShamanFriend:LoadEvents()
					end,
				},
				restot5 = {
					name = L["Restoration T5 4-piece bonus"],
					type = "toggle",
					desc = L["Show a message when you get the proc from the Restoration Tier5 4-piece bonus"],
					get = function(info) return ShamanFriend.db.profile.misc.restot5 end,
					set = function(info,v)
						ShamanFriend.db.profile.misc.restot5 = v
						ShamanFriend:LoadEvents()
					end,
				},
				display = {
					name = L["Display"],
					type = 'group',
					desc = L["Settings for how to display the message."], 
					args = {
						color = {
							name = L["Color"],
							type = 'color',
							desc = L["Sets the color of the text when displaying messages."],
							get = function(info)
							local v = ShamanFriend.db.profile.misc.display.color
								return v.r,v.g,v.b
								end,
							set = function(info,r,g,b) ShamanFriend.db.profile.misc.display.color = {r=r,g=g,b=b} end
						},
						scroll = {
							type = 'toggle',
							name = L["Scroll output"],
							desc = L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"],
							get = function(info) return ShamanFriend.db.profile.misc.display.scroll end,
							set = function(info,t) ShamanFriend.db.profile.misc.display.scroll = t end,
						},
						frames = {
							type = 'toggle',
							name = L["Frames output"],
							desc = L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"],
							get = function(info) return ShamanFriend.db.profile.misc.display.frames end,
							set = function(info,t) ShamanFriend.db.profile.misc.display.frames = t end,
						},
						time = {
							--hidden = true,
							name = L["Time to display message"],
							type = "range",
							desc = L["Set the time the message will be displayed (5=default)"],
							get = function(info) return ShamanFriend.db.profile.misc.display.time end,
							set = function(info,v)
								ShamanFriend.db.profile.misc.display.time = v
							end,
							step = 1,
							min = 1,
							max = 20,
							order = 111,
						},
					}
				},
			}
		},
	}
}

local bloodlusttextdefault
if UnitRace("player") == "Draenei" then
  bloodlusttextdefault = "Heroism UP! Now go pewpew!"
else
  bloodlusttextdefault = "Bloodlust UP! Now go pewpew %t!"
end

ShamanFriend.defaults = {
   profile = {
	alert = {
		shield = true,
		weapon = true,
		entercombat = true,
		aftercombat = false,
		mounted = true,
		vehicle = true,
		sound = "none",
		maelstrom = false,
		surge = false,
		fulmination = false,
		proc_sound = "none",
		display = {
			color = { r=1, g=1, b=1 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
	spell = {
		purge = true,
		purgemsg = "none",
		interrupt = false,
		interruptmsg = "none",
		ground = false,
		groundself = true,
		groundmsg = "none",
		target = false,
		bloodlust = false,
		bloodlusttext = bloodlusttextdefault,
		bloodlustchat = "YELL",
		manatide = false,
		manatidetext = "Mana Tide UP! More mana to the people!",
		manatidechat = "YELL",
		feralspirit = false,
		feralspirittext = "Feral Spirits! Who let the dogs out?",
                feralspiritchat = "YELL",
		dispel = false,
		dispelmsg = "none",
		display = {
			color = { r=1, g=0.5, b=0.7 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
	display = {
		chat = false,
		number = 0,
		screen = false,
		frame = true,
		fontSize = 18,
		fontFace = L["FRIZQT__.TTF"],
		fontEffect = L["OUTLINE"],
		lock = true,
                bgannounce = "none",
                arenaannounce = true,
                partyannounce = true,
                raidannounce = true,
		worldannounce = false,
	},
	wf = {
		enable = true,
		crit = true,
		miss = false,
		hand = false,
		display = {
			color = { r=0.7, g=0.7, b=1 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
	lo = {
		enable = true,
		crit = false,
		damage = false,
		miss = false,
		fulmination = false,
		display = {
			color = { r=0.7, g=0.7, b=1 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
	eshield = {
		enable = false,
		lock = false,
		notooltip = false,
		button = false,
		alert = true,
		sound = "none",
		display = {
			color = { r=0.7, g=0.7, b=1 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
	cc = {
		success = false,
		successtext = "SF: TARGET has SPELL Don't break it!",
		fail = false,
		failtext = "SF: SPELL failed on TARGET: ",
		remove = false,
		removetext = "SF: TARGET no longer has SPELL!",
		ccchat = "none",
		broken = true,
		brokentext = "SF: SOURCE broke SPELL on TARGET: ",
		brokenchat = "none",
		tanktime = 10,
		sound = "none",
		display = {
			color = { r=0.3, g=1, b=0.1 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
	--[[totem = {
		kill = false,
		killmsg = "none",
		display = {
			color = { r=0.7, g=0.7, b=1 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},]]
	misc = {
		elet5 = false,
		enht5 = false,
		restot5 = false,
		display = {
			color = { r=0.7, g=1, b=0.7 },
			scroll = false,
			frames = true,
			time = 5,
		},
	},
   }
}

local sounds = {
	ding = "Sound\\Doodad\\BellTollAlliance.ogg",
	dong = "Sound\\Doodad\\BellTollHorde.ogg",
	bell = "AuctionWindowClose",
	dodo = "igQuestFailed",
}

local wf_str
local wf_guid
local wf_hand
local wf_cnt = 0
local wf_crit = 0
local wf_miss = 0
local wf_over = 0
local wf_dmg = 0
local fs_target, fs_cnt
local time = 0
local lo_str
local lo_c
local lo_hit = 0
local lo_crit = 0
local lo_miss = 0
local lvb_hit = 0
local lvb_crit = 0
local cl_cnt = 0
local fulm_hit = 0
local fulm_crit = 0
local fulm_miss = 0
local eshield_target = "-"
local eshield_count
local eshield_id
local eshield_lockdown = false
local eshield_oldtarget
local eshield_casttarget
local mw_count = 0
local ls_count = 0

local trackedEvents = {}
local DelayedUnitUpdate = false

local lb_ids = {
	[403] = true
}

local lb_ol_ids = {
	[45284] = true
}

local lvb_ids = {
	[51505] = true
}

local lvb_ol_ids = {
	[77451] = true
}

local cl_ids = {
	[421] = true
}

local cl_ol_ids = {
	[45297] = true
}

local fulm_ids = {
	[88767] = true
}

local es_ids = {
	[8042] = true
}

local shield_ids = {
	-- Water Shield:
	[52127] = true,
	
	-- Lightning Shield:
	[324] = true,
	
	-- Earth Shield:
	[974] = true,
}

local eshield_ids = {
	[974] = true
}

local interrupt_ids = {
	-- Wind Shear
	[57994] = true
}

local cc_ids = {
	-- Hex
	[51514] = true,
	-- Bind Elemental
	[76780] = true
}

-- CC's that can overwrite shaman CC's
-- Or CC's that can be combined with shaman CC so that if
-- these are still up the mob is not lose and there is no need to alert
-- other players
-- Including other shaman's CC's
-- Not including stuff like Blind and Scatter Shot as they are short duration
local allcc_ids = {
	-- Banish
	[710] = true,
	-- Bind Elemental
	[76780] = true,
	-- Fear
	[5782] = true,
	-- Freezing Trap (Effect)
	[3355] = true,
	-- Hex
	[51514] = true,
	-- Hibernate
	[2637] = true,
	-- Polymorph
	[118] = true,
	-- Polymorph: Black Cat
	[61305] = true,
	-- Polymorph: Pig
	[28272] = true,
	-- Polymorph: Rabbit
	[61721] = true,
	-- Polymorph: Turkey
	[61780] = true,
	-- Polymorph: Turtle
	[28271] = true,
	-- Repentance
	[20066] = true,
	-- Sap
	[6770] = true,
}

local hex_ids = {
	-- Hex
	[51514] = true
}

local bind_ids = {
	-- Bind Elemental
	[76780] = true
}

-- Spell ids for Spell Names
-- This is used to get localized names for spells
local name_ids = {
	["Earth Shield"] = 974,
	["Water Shield"] = 52127,
	["Lightning Shield"] = 324,
        ["Bloodlust"] = 2825,
        ["Heroism"] = 32182,
        ["Mana Tide Totem"] = 16190,
        ["Feral Spirit"] = 51533,
        ["Maelstrom Weapon"] = 53817,
	["Grounding Totem"] = 8177,
	["Lava Surge!"] = 77762
}

local lN = {}

ShamanFriend.Wf = 0
ShamanFriend.Wf_miss = 0
ShamanFriend.Wf_crit = 0

function ShamanFriend:OnInitialize()
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")

        self.db = LibStub("AceDB-3.0"):New("ShamanFriendDB", ShamanFriend.defaults, "profile")
        LibStub("AceConfig-3.0"):RegisterOptionsTable("ShamanFriend", options, {"shamanfriend", "sf"} )
	self.optionsFrame = AceConfigDialog:AddToBlizOptions("ShamanFriend","ShamanFriend")
	self.db:RegisterDefaults(self.defaults)
		
	-- self:RegisterChatCommand({"/sfcl"}, options)
	local meta_version = GetAddOnMetadata("ShamanFriend","Version")
	local revision = GetAddOnMetadata("ShamanFriend","X-Curse-Packaged-Version")
	self.version = ("v%s-%s"):format(meta_version, revision)
	self:Print(self.version.." Loaded.")
	self:Print("Use /sf for options.")
	self.announce = true
        self.zonetype = "none"
	self.configMode = false

	self:InitializeEarthShield()
	self:InitializeShield()
	self:InitializeCC()
	self:GetLocaleSpells()

	self:RegisterSink("SF", "ShamanFriend", nil, "SinkPrint")
end

function ShamanFriend:OnEnable()
	-- self:Print("OnEnable")
	self:LoadEvents()
end

function ShamanFriend:OnDisable()
	self:UnregisterAllEvents()
end

function ShamanFriend:InitializeEarthShield()
	self.eshield = {}
	self.eshield = {
		enabled = false,
		TimerEvent = nil,
	}
end

function ShamanFriend:InitializeShield()
	self.shield = {}
	self.shield = {
		enabled = false,
		name = nil,
	}
end

function ShamanFriend:InitializeCC()
	self.cc = {}
	self.cc = {
		removetarget = nil,
		removetime = nil,
	}
	self.hex = {}
	self.hex = {
		enabled = false,
		target = nil,
		dead = false,
		lasttarget = nil,
		time = 0,
		expiration = 0,
		breaksource = nil,
		breakspell = nil,
	}
	self.bind = {}
	self.bind = {
		enabled = false,
		target = nil,
		dead = false,
		lasttarget = nil,
		time = 0,
		expiration = 0,
		breaksource = nil,
		breakspell = nil,
	}
	self.checkcc = {}
	self.NameToID = {}
end

function ShamanFriend:GetLocaleSpells()
	lN["Earth Shield"] = GetSpellInfo(name_ids["Earth Shield"])
	lN["Water Shield"] = GetSpellInfo(name_ids["Water Shield"])
	lN["Lightning Shield"] = GetSpellInfo(name_ids["Lightning Shield"])
	lN["Bloodlust"] = GetSpellInfo(name_ids["Bloodlust"])
	lN["Heroism"] = GetSpellInfo(name_ids["Heroism"])
	lN["Mana Tide Totem"] = GetSpellInfo(name_ids["Mana Tide Totem"])
	lN["Feral Spirit"] = GetSpellInfo(name_ids["Feral Spirit"])
	lN["Maelstrom Weapon"] = GetSpellInfo(name_ids["Maelstrom Weapon"])
	lN["Grounding Totem"] = GetSpellInfo(name_ids["Grounding Totem"])
	lN["Lava Surge!"] = GetSpellInfo(name_ids["Lava Surge!"])
end

-- function ShamanFriend:ShowUI()
--	waterfall:Open("ShamanFriend")
-- end

function ShamanFriend:LoadEvents()
	self:UnregisterAllEvents()
	
	trackedEvents = {}
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

        -- Detect talent spec change
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	
	-- Enter combat
	if self.db.profile.alert.entercombat then
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
	end

	-- After combat
	if self.db.profile.alert.aftercombat == true or
	   self.db.profile.eshield.enable or
	   self.db.profile.cc.broken then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	end

        -- Disable announces when in battlegrounds
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
        ShamanFriend:ZoneCheck();
	
	-- Shield
	-- if self.db.profile.alert.shield then
	--	trackedEvents["SPELL_AURA_REMOVED"] = true
	-- end
	
	-- Weapon
	if self.db.profile.alert.weapon then
		trackedEvents["ENCHANT_REMOVED"] = true
	end
	
	-- Wf
	if self.db.profile.wf.enable then
		trackedEvents["SWING_DAMAGE"] = true
		trackedEvents["SWING_MISSED"] = true
		trackedEvents["SPELL_DAMAGE"] = true
		trackedEvents["SPELL_MISSED"] = true
		--trackedEvents["UNIT_DIED"] = true
	end
	
	-- LO
	if self.db.profile.lo.enable or self.db.profile.lo.fulmination then
		trackedEvents["SPELL_DAMAGE"] = true
		trackedEvents["SPELL_MISSED"] = true
	end
	
	-- BL + Tide + FS
	if self.db.profile.spell.bloodlust or self.db.profile.spell.manatide then
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	end
	
	-- Earth Shield tracker
	if self.db.profile.eshield.enable then
		-- trackedEvents["SPELL_AURA_APPLIED"] = true
		-- trackedEvents["SPELL_AURA_REMOVED"] = true
		trackedEvents["SPELL_HEAL"] = true
		self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		self:RegisterEvent("UNIT_SPELLCAST_SENT")
	end
	
	-- Set bonus
	if self.db.profile.misc.elet5 or self.db.profile.misc.enht5 or self.db.profile.misc.restot5 then
		trackedEvents["SPELL_AURA_APPLIED"] = true
	end
	
	-- Purge
	if self.db.profile.spell.purge or self.db.profile.spell.dispel then
		trackedEvents["SPELL_DISPEL"] = true
	end
	
	-- Ground
	if self.db.profile.spell.ground then
		trackedEvents["SPELL_DAMAGE"] = true
		trackedEvents["SPELL_MISSED"] = true
	end
	
	-- Earth Shock + Wind Shock/Shear
	if self.db.profile.spell.interrupt then
		trackedEvents["SPELL_INTERRUPT"] = true
	end

	-- CC
	if self.db.profile.cc.success then
		trackedEvents["SPELL_AURA_APPLIED"] = true
	end
	if self.db.profile.cc.fail then
		trackedEvents["SPELL_MISSED"] = true
	end
	if self.db.profile.cc.remove then
		trackedEvents["SPELL_AURA_REMOVED"] = true
	end
	if self.db.profile.cc.broken then
		trackedEvents["SWING_DAMAGE"] = true
		trackedEvents["RANGE_DAMAGE"] = true
		trackedEvents["SPELL_DAMAGE"] = true
		trackedEvents["SPELL_DISPEL"] = true
		trackedEvents["SPELL_PERIODIC_DAMAGE"] = true
		trackedEvents["SPELL_AURA_REMOVED"] = true
	 	trackedEvents["SPELL_AURA_BROKEN"] = true
	 	trackedEvents["SPELL_AURA_BROKEN_SPELL"] = true
		-- trackedEvents["UNIT_DIED"] = true
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateUnits")
		self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateUnits")
		self:RegisterEvent("UNIT_NAME_UPDATE", "UpdateUnits")
	end

        -- Maelstrom Weapon
	if self.db.profile.alert.maelstrom or
	   self.db.profile.alert.fulmination or
	   self.db.profile.eshield.enable or
	   self.db.profile.alert.shield then
		self:RegisterEvent("UNIT_AURA")
	end

	if self.db.profile.alert.surge then
		-- I can't find a fired event for Lava Surge, but it is sent to the combatlog
		trackedEvents["SPELL_CAST_SUCCESS"] = true
	end
	
	-- Totem kills
	--if self.db.profile.totem.kill then
	--	trackedEvents["UNIT_DIED"] = true
	--end
	
	-- Custom Message Frame
	if (not self.msgFrame) and self.db.profile.display.frame then
		self:CreateCustomFrame()
	end
	
	-- Create Eshield Frame
	if self.db.profile.eshield.enable then
                ShamanFriend:FindEshieldId();
		if (not self.eshieldFrame) then
			self:CreateEshieldFrame()
		end
		if self.eshieldFrame then
	           if (eshield_id) then
			self.eshieldFrame:Show()
			self.eshieldButton:Show()
                   end
		end
	elseif self.eshieldFrame then
		self.eshieldFrame:Hide()
		self.eshieldButton:Hide()
	end
end

function ShamanFriend:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	local substring
	if not trackedEvents[event] then
		-- self:Print("NOT tracked")
		-- self:Print(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
		-- self:Print(...)
		return
	end
	if (event == "SWING_DAMAGE") then
		if self.db.profile.wf.enable and sourceGUID == UnitGUID("player") then
			self:WfHandler("melee",select(1,...),select(7,...),select(2,...),event)
			
		end
		if self.db.profile.cc.broken then
			if (self.hex.enabled and destGUID == self.hex.target) then
				self.hex.breaksource = sourceName
				self.hex.breakspell = "(melee)"
				if (select(2,...) > 0) then
					self.hex.dead = true
				end
				-- self:Print("breakspell: " .. self.hex.breakspell .. ", dead: " .. tostring(self.hex.dead))
			elseif (self.bind.enabled and destGUID == self.bind.target) then
				self.bind.breaksource = sourceName
			 	self.bind.breakspell = "(melee)"
				if (select(2,...) > 0) then
					self.bind.dead = true
				end
			end
		end
	elseif (event == "SWING_MISSED") and sourceGUID == UnitGUID("player") then
		if self.db.profile.wf.enable then
			self:WfHandler("melee",select(2,...),0,0,event)
		end
	elseif (event == "RANGE_DAMAGE") then
		if self.db.profile.cc.broken then
			if (self.hex.enabled and destGUID == self.hex.target) then
				self.hex.breaksource = sourceName
				self.hex.breakspell = select(2,...)
				if (select(5,...) > 0) then
					self.hex.dead = true
				end
				-- self:Print("breakspell: " .. self.hex.breakspell .. ", dead: " .. tostring(self.hex.dead))
			elseif (self.bind.enabled and destGUID == self.bind.target) then
				self.bind.breaksource = sourceName
			 	self.bind.breakspell = select(2,...)
				if (select(5,...) > 0) then
					self.bind.dead = true
				end
			end
		end
	elseif (event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or
	   event == "SPELL_MISSED") then
		if self.db.profile.cc.broken and event == "SPELL_DAMAGE" or
		   event == "SPELL_PERIODIC_DAMAGE" then
			if (self.hex.enabled and destGUID == self.hex.target) then
				self.hex.breaksource = sourceName
				self.hex.breakspell = select(2,...)
				if (select(5,...) > 0) then
					self.hex.dead = true
				end
				-- self:Print("breakspell: " .. self.hex.breakspell .. ", dead: " .. tostring(self.hex.dead))
			elseif (self.bind.enabled and destGUID == self.bind.target) then
				self.bind.breaksource = sourceName
				self.bind.breakspell = select(2,...)
				if (select(5,...) > 0) then
					self.bind.dead = true
				end
			end
		end
		if sourceGUID == UnitGUID("player") then
			if self.db.profile.lo.enable or self.db.profile.lo.fulmination then
				if event == "SPELL_DAMAGE" then
					self:LoHandler(select(1,...),select(4,...),select(10,...),event)
				elseif event == "SPELL_MISSED" then
					self:LoHandler(select(1,...),0,0,event)
				end
			end
			if self.db.profile.wf.enable then
				if event == "SPELL_DAMAGE" then
					self:WfHandler(select(1,...),select(4,...),select(10,...),select(5,...),event)
				elseif event == "SPELL_MISSED" then
					self:WfHandler(select(1,...),0,0,0,event)
				end
			end
			if self.db.profile.cc.fail and event == "SPELL_MISSED" then
				if cc_ids[select(1,...)] and self:ChatChannel(self.db.profile.cc.ccchat) ~= "none" then
					-- Replace TARGET in string with the actual target
					substring = string.gsub(self.db.profile.cc.failtext, "TARGET", destName)
					-- Add the type of miss to the end
					substring = substring .. select(4,...)

					-- Do not announce that the CC failed if they are still CC'd
					-- For example if you try to bind a banished target
					local announce = true
					if (self:GetCC(destGUID)) then
						announce = false
					-- elseif (UnitIsDead(destGUID) or UnitIsCorpse(destGUID)) then
					-- 	announce = false
					end
					if (not announce) then
						-- Replace SPELL in string with the actual spell
						substring = string.gsub(substring, "SPELL", select(2,...))
						self:Message(substring, "spell")
					else
						-- Replace SPELL in string with the actual spell
						local spellstring = "\124cff71d5ff\124Hspell:" .. select(1,...) .. "\124h[" .. select(2,...) .. "]\124h\124r"
						substring = string.gsub(substring, "SPELL", spellstring)

   	       					self:Announce(substring,self:ChatChannel(self.db.profile.cc.ccchat))
					end
				end
			end
		else
			if self.db.profile.spell.ground then
                                -- self:Print(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
				-- destFlags == 8465 for my unmarked totem. With a raid mark on totem, higher bits may be set. 
				if ((not self.db.profile.spell.groundself) or math.fmod(destFlags,65536) == 8465) and destName == lN["Grounding Totem"] then
					self:Message(L["Ground: "] .. select(2,...) .. string.format(" (%s)",strlower(select(4,...))),"spell")
					if self:ChatChannel(self.db.profile.spell.groundmsg) ~= "none" then
						self:Announce(L["Ground: "] .. select(2,...) .. string.format(" (%s)",strlower(select(4,...))),self:ChatChannel(self.db.profile.spell.groundmsg))
					end
				end 
			end		
		end
	elseif event == "SPELL_AURA_REMOVED" then
		if sourceGUID == UnitGUID("player") and cc_ids[select(1,...)] then
			-- More than one CC can break at the same time before it is processed
			-- We need to create a table of each CC break
			table.insert(self.checkcc, timestamp);
			table.insert(self.checkcc, destGUID);
			table.insert(self.checkcc, destName);
			local cc_sid = select(1,...)
			table.insert(self.checkcc, cc_sid);
			local cc_name = select(2,...)
			table.insert(self.checkcc, cc_name);
			self:ScheduleTimer(self.CheckCC, 0.2, self)
		elseif allcc_ids[select(1,...)] then
			-- Track if any CC was removed from a target
			-- We won't announce when applying CC to this target
			self.cc.removetarget = destGUID
			self.cc.removetime = timestamp
		end
	-- Blizzard has apparently implemented this for every CC in the game, except Hex
	-- There does not seem to be any good way to determine what broke Hex until this is implemented
	elseif (event == "SPELL_AURA_BROKEN" or
                event == "SPELL_AURA_BROKEN_SPELL") then
	 	-- self:Print(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
		if (self.hex.enabled and destGUID == self.hex.target and hex_ids[select(1,...)]) or
		   (self.bind.enabled and destGUID == self.bind.target and bind_ids[select(1,...)]) then
			if self.db.profile.cc.broken then
				local breakspell
				-- What broke it?
				if (event == "SPELL_AURA_BROKEN") then
					breakspell = "(melee)"
				elseif (event == "SPELL_AURA_BROKEN_SPELL") then
					breakspell = select(5,...)
				end

				local cctime = 0
				if (hex_ids[select(1,...)]) then
					cctime = self.hex.time
				else
					cctime = self.bind.time
				end

				self:BreakMessage(timestamp, sourceName, destGUID, destName, breakspell, cctime, select(1,...), select(2,...))

				if hex_ids[select(1,...)] then
					self.hex.enabled = false
					self.hex.target = nil
					self.hex.dead = false
					-- self.hex.time = 0
					self.hex.breaksource = nil
					self.hex.breakspell = nil
				elseif bind_ids[select(1,...)] then
					self.bind.enabled = false
					self.bind.target = nil
					self.bind.dead = false
					-- self.bind.time = 0
					self.bind.breaksource = nil
					self.bind.breakspell = nil
				end
			end
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if self.db.profile.misc.elet5 and select(1,...) == 37234 and destGUID == UnitGUID("player") then
			self:Message(L["Gained set bonus"], "misc")
		elseif self.db.profile.misc.enht5 and select(1,...) == 37240 and destGUID == UnitGUID("player") then
			self:Message(L["Gained set bonus"], "misc")
		elseif self.db.profile.misc.restot5 and select(1,...) == 39950 and destGUID == UnitGUID("player") then
			self:Message(L["Gained set bonus"], "misc")
		elseif sourceGUID == UnitGUID("player") and cc_ids[select(1,...)] then
			local announce = true
			if hex_ids[select(1,...)] then
				self.hex.enabled = true
				self.hex.target = destGUID
				self.hex.dead = false
				-- Do not reset time or announce if reapplying CC to the same target
				if (self.hex.target == self.hex.lasttarget) then
					announce = false
				else
					self.hex.time = timestamp
					self.hex.lasttarget = destGUID
				end
				self.hex.breaksource = nil
				self.hex.breakspell = nil
				self.hex.expiration = self:GetExpiration(timestamp, select(2,...), destGUID, 60)
			elseif bind_ids[select(1,...)] then
				self.bind.enabled = true
				self.bind.target = destGUID
				self.bind.dead = false
				-- Do not reset time or announce if reapplying CC to the same target
				if (self.bind.target == self.bind.lasttarget) then
					announce = false
				else
					self.bind.time = timestamp
					self.bind.lasttarget = destGUID
				end
				self.bind.breaksource = nil
				self.bind.breakspell = nil
				self.bind.expiration = self:GetExpiration(timestamp, select(2,...), destGUID, 50)
			end
			if (self:GetCC(destGUID)) then
				-- Do not announce if the target is already CC'd by another player
				announce = false
			elseif (destGUID == self.cc.removetarget and (self.cc.removetime + 1) >= timestamp) then
				-- Do not announce if CC was just removed from that target
				-- For example, if we hex a target that was polymorphed
				announce = false
			-- elseif (UnitIsDead(destGUID) or UnitIsCorpse(destGUID)) then
			-- 	announce = false
			end
			if self.db.profile.cc.success and self:ChatChannel(self.db.profile.cc.ccchat) ~= "none" and announce then
				-- Replace TARGET in string with the actual target
				substring = string.gsub(self.db.profile.cc.successtext, "TARGET", destName)
				-- Replace SPELL in string with the actual spell
				local spellstring = "\124cff71d5ff\124Hspell:" .. select(1,...) .. "\124h[" .. select(2,...) .. "]\124h\124r"
				substring = string.gsub(substring, "SPELL", spellstring)
   	       			self:Announce(substring,self:ChatChannel(self.db.profile.cc.ccchat))
			end
		end
	elseif event == "SPELL_INTERRUPT" then
		if self.db.profile.spell.interrupt and sourceGUID == UnitGUID("player") and interrupt_ids[select(1,...)] then
			self:Message(string.format(L["Interrupted: %s"],select(5,...)),"spell")
			if self:ChatChannel(self.db.profile.spell.interruptmsg) ~= "none" then
				if self.db.profile.spell.target then
					self:Announce(string.format(L["Interrupted: %s"] .. " (%s)",select(5,...),destName),self:ChatChannel(self.db.profile.spell.interruptmsg))
				else
					self:Announce(string.format(L["Interrupted: %s"],select(5,...)),self:ChatChannel(self.db.profile.spell.interruptmsg))
				end
			end
		end	
	elseif event == "SPELL_HEAL" then
		if eshield_id and self.db.profile.eshield.enable and select(1,...) == 379 and destName == eshield_target then
			self:eshield_BuffCheck()
		end
	elseif event == "SPELL_DISPEL" then
		if self.db.profile.spell.purge and sourceGUID == UnitGUID("player") and select(1,...) == 370 then
			self:Message(L["Purge: "] .. select(5,...),"spell")
			if self:ChatChannel(self.db.profile.spell.purgemsg) ~= "none" then
				if self.db.profile.spell.target then
					self:Announce(string.format(L["Purge: "] .. "%s (%s)",select(5,...),destName),self:ChatChannel(self.db.profile.spell.purgemsg))
				else
					self:Announce(L["Purge: "] .. select(5,...),self:ChatChannel(self.db.profile.spell.purgemsg))
				end
			end
		elseif self.db.profile.spell.dispel and sourceGUID == UnitGUID("player") and select(1,...) == 51886 then
			self:Message(L["Dispel: "] .. select(5,...),"spell")
			if self:ChatChannel(self.db.profile.spell.dispelmsg) ~= "none" then
				if self.db.profile.spell.target then
					self:Announce(string.format(L["Dispel: "] .. "%s (%s)",select(5,...),destName),self:ChatChannel(self.db.profile.spell.dispelmsg))
				else
					self:Announce(L["Dispel: "] .. select(5,...),self:ChatChannel(self.db.profile.spell.dispelmsg))
				end
			end
		elseif self.db.profile.cc.broken then
			if (self.hex.enabled and destGUID == self.hex.target) then
				self.hex.breaksource = sourceName
				self.hex.breakspell = select(2,...)
				-- self:Print("breakspell: " .. self.hex.breakspell)
			elseif (self.bind.enabled and destGUID == self.bind.target) then
				self.bind.breaksource = sourceName
			 	self.bind.breakspell = select(2,...)
				-- self:Print("breakspell: " .. self.hex.breakspell)
			end
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if self.db.profile.alert.surge and sourceGUID == UnitGUID("player") and (select(1,...) == 77762) then
			self:Message(select(2,...), "proc")
		end
	-- elseif event == "UNIT_DIED" then
	 	-- self:Print(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
		-- if (self.hex.enabled and destGUID == self.hex.target and self.db.profile.cc.broken) then
			-- self:Print("Hex target died")
		-- 	self.hex.dead = true
		-- elseif (self.bind.enabled and destGUID == self.bind.target and self.db.profile.cc.broken) then
			-- self:Print("Bind target died")
		-- 	self.bind.dead = true
		-- end
		-- if self.db.profile.wf.enable and sourceGUID == wf_guid then
			--wf_guid = nil
		-- end
		--[[if self.db.profile.totem.kill and sourceFlags == 8465 then
			self:Message(L["Killed: "] .. select(5,...),"totem")
			if self:ChatChannel(self.db.profile.spell.purgemsg) ~= "none" then
				if self.db.profile.spell.target then
					self:Announce(string.format(L["Killed: "] .. "%s (%s)",select(5,...),destName),self:ChatChannel(self.db.profile.spell.purgemsg))
				else
					self:Announce(L["Killed: "] .. select(5,...),self:ChatChannel(self.db.profile.spell.purgemsg))
				end
			end
		end]]
	elseif event == "ENCHANT_REMOVED" then
		if self.db.profile.alert.weapon and destGUID == UnitGUID("player") and IsEquippedItem(select(3,...)) == 1 then
			self:ScheduleTimer(self.CheckWeapon, 1, self)
		end
	end
	
	--self:Print("tracked")
	--self:Print(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
	--self:Print(...)
end

function ShamanFriend:CheckCC()
	-- self:Print("In CheckCC")
	while (next(self.checkcc) ~= nil) do
		local timestamp, destGUID, destName, cc_sid, cc_name
		timestamp = table.remove(self.checkcc, 1)
		destGUID = table.remove(self.checkcc, 1)
		destName = table.remove(self.checkcc, 1)
		cc_sid = table.remove(self.checkcc, 1)
		cc_name = table.remove(self.checkcc, 1)
		self:CCRemoved(timestamp, destGUID, destName, cc_sid, cc_name)
	end
end


function ShamanFriend:CCRemoved(timestamp, destGUID, destName, cc_sid, cc_name)
	-- self:Print("In CCRemoved")
	if self.db.profile.cc.broken and self.hex.breakspell and hex_ids[cc_sid] and
	   (timestamp + 1 < self.hex.expiration) then
		self:BreakMessage(timestamp, self.hex.breaksource, destGUID, destName, self.hex.breakspell, self.hex.time, cc_sid, cc_name)
	elseif self.db.profile.cc.broken and self.bind.breakspell and bind_ids[cc_sid] and
	   (timestamp + 1 < self.bind.expiration) then
		self:BreakMessage(timestamp, self.bind.breaksource, destGUID, destName, self.bind.breakspell, self.bind.time, cc_sid, cc_name)
	elseif self.db.profile.cc.remove then
		if hex_ids[cc_sid] and self.hex.enabled or
		   bind_ids[cc_sid] and self.bind.enabled then
			self:Message(cc_name .. L[" faded from "] .. destName, "cc")
			-- Do not announce that the CC faded if they are still CC'd
			local announce = true
			if (self:GetCC(destGUID)) then
				announce = false
			-- elseif (UnitIsDead(destGUID) or UnitIsCorpse(destGUID)) then
			elseif (hex_ids[cc_sid] and self.hex.dead) or
				(bind_ids[cc_sid] and self.bind.dead) then
				announce = false
			end
			if self:ChatChannel(self.db.profile.cc.ccchat) ~= "none" and announce then
				-- Replace TARGET in string with the actual target
				substring = string.gsub(self.db.profile.cc.removetext, "TARGET", destName)
				-- Replace SPELL in string with the actual spell
				local spellstring = "\124cff71d5ff\124Hspell:" .. cc_sid .. "\124h[" .. cc_name .. "]\124h\124r"
				substring = string.gsub(substring, "SPELL", spellstring)
         					self:Announce(substring,self:ChatChannel(self.db.profile.cc.ccchat))
			end
		end
	end
	if hex_ids[cc_sid] then
		self.hex.enabled = false
		self.hex.target = nil
		self.hex.dead = false
		-- self.hex.time = 0
		self.hex.breaksource = nil
		self.hex.breakspell = nil
	elseif bind_ids[cc_sid] then
		self.bind.enabled = false
		self.bind.target = nil
		self.bind.dead = false
		-- self.bind.time = 0
		self.bind.breaksource = nil
		self.bind.breakspell = nil
	end
	self.cc.removetarget = nil
end

function ShamanFriend:BreakMessage(timestamp, sourceName, destGUID, destName, breakspell, cc_time, cc_sid, cc_name)
	local message = L[" broke SPELL on "]
	-- Replace SPELL in string with the actual spell
	message = string.gsub(message, "SPELL", cc_name)

	-- self:Print("In BreakMessage")

	-- if (UnitIsDead(destGUID) or UnitIsCorpse(destGUID)) then
	if (hex_ids[cc_sid] and self.hex.dead) or
	   (bind_ids[cc_sid] and self.bind.dead) then
		return
	end

	self:Message(sourceName .. message .. destName .. ": " .. breakspell, "cc")

	-- If the tank breaks it after tanktime then do not warn
	local istank = false
	local uid = self.NameToID[sourceName]
	local role = ""
	if (uid and UnitExists(uid)) then
		role = UnitGroupRolesAssigned(uid)
	end
	if (role == "TANK") then
		istank = true
	elseif (uid and UnitExists(uid) and GetPartyAssignment('MAINTANK', uid)) then
		istank = true
	end

	-- self:Print("istank: " .. tostring(istank) .. ", timestamp: " .. timestamp .. ", cc_time: " .. cc_time)
	if (istank and (timestamp >= cc_time + self.db.profile.cc.tanktime)) then
		return
	end

	if self:ChatChannel(self.db.profile.cc.brokenchat) ~= "none" then
		-- Replace SOURCE in string with the source
		substring = string.gsub(self.db.profile.cc.brokentext, "SOURCE", sourceName)
		-- Replace TARGET in string with the TARGET
		substring = string.gsub(substring, "TARGET", destName)
		-- Replace SPELL in string with the actual spell
		local spellstring = "\124cff71d5ff\124Hspell:" .. cc_sid .. "\124h[" .. cc_name .. "]\124h\124r"
		substring = string.gsub(substring, "SPELL", spellstring)
		-- Add what broke it
		substring = substring .. breakspell
		self:Announce(substring,self:ChatChannel(self.db.profile.cc.brokenchat))
	end
end

function ShamanFriend:LEARNED_SPELL_IN_TAB(event, Tab)
	if self.eshieldFrame then
		self.eshieldFrame:Hide()
	end
	if self.eshieldButton then
			self.eshieldButton:Hide()
	end
	-- self:Print("detected a new spell")
	self:LoadEvents()
end

function ShamanFriend:ACTIVE_TALENT_GROUP_CHANGED(event, newGroup, prevGroup)
	-- if self.db.char.switchSpec then
		if self.eshieldFrame then
			self.eshieldFrame:Hide()
		end
		if self.eshieldButton then
			self.eshieldButton:Hide()
		end
		-- self:Print("detected a talent spec change")
	        self:LoadEvents()
	-- end
end

function ShamanFriend:ChatChannel(chat)
	if chat == "RAID" and not UnitInRaid("player") then
		chat = "PARTY"
	end
	if chat == "PARTY" and GetNumPartyMembers() == 0 then
		chat = "none"
	end

	-- Currently in beta /say and /yell do not work in instances
	-- if self.zonetype == "party" and
	--    (chat == "SAY" or chat == "YELL") then
	-- 	if GetNumPartyMembers() > 0 then
	-- 		chat = "PARTY"
	-- 	end
	-- end

	-- self:Print("ChatChannel: " .. chat)
	return chat;
end

-- a1 = Unit casting the spell
-- a2 = Spell name
-- a3 = Spell rank
function ShamanFriend:UNIT_SPELLCAST_SUCCEEDED(event,a1,a2,a3)
	if a1 ~= "player" then
		return
	end
	
	if self.db.profile.spell.bloodlust and self:ChatChannel(self.db.profile.spell.bloodlustchat) ~= "none" and (a2 == lN["Bloodlust"] or a2 == lN["Heroism"]) then
		self:Announce(self.db.profile.spell.bloodlusttext,self:ChatChannel(self.db.profile.spell.bloodlustchat))
	elseif self.db.profile.spell.manatide and self:ChatChannel(self.db.profile.spell.manatidechat) ~= "none" and a2 == lN["Mana Tide Totem"] then
   	        self:Announce(self.db.profile.spell.manatidetext,self:ChatChannel(self.db.profile.spell.manatidechat))
	elseif self.db.profile.spell.feralspirit and self:ChatChannel(self.db.profile.spell.feralspiritchat) ~= "none" and a2 == lN["Feral Spirit"] then
   	        self:Announce(self.db.profile.spell.feralspirittext,self:ChatChannel(self.db.profile.spell.feralspiritchat))
	-- This event isn't called for Lava Surge
	-- elseif self.db.profile.alert.surge and a2 == lN["Lava Surge!"] then
	--	self:Message(a2, "alert")
	end
end

-- a1 = Unit
function ShamanFriend:UNIT_AURA(event,a1)
	local old_count = 0

	if self.db.profile.alert.maelstrom and a1 == "player" then
		old_count = mw_count
		self:maelstrom_BuffCheck()
		if old_count ~= mw_count and mw_count == 5 then
			self:Message(lN["Maelstrom Weapon"] .. " 5","proc")
                end
	end

	if self.db.profile.alert.fulmination and a1 == "player" then
		-- old_count = ls_count
		self:fulmination_BuffCheck()
		-- if old_count ~= ls_count and ls_count == 9 then
		if ls_count == 9 then
			self:Message(lN["Lightning Shield"] .. " 9","proc")
                end
	end

	if self.db.profile.alert.shield and a1 == "player" then
		if UnitBuff("player", lN["Lightning Shield"]) then
			self.shield.enabled = true
			self.shield.name = lN["Lightning Shield"]
		elseif UnitBuff("player", lN["Water Shield"]) then
			self.shield.enabled = true
			self.shield.name = lN["Water Shield"]
		elseif UnitBuff("player", lN["Earth Shield"]) then
			self.shield.enabled = true
			self.shield.name = lN["Earth Shield"]
		elseif self.shield.enabled then
			self.shield.enabled = false
			self:Message(self.shield.name .. L[" faded"], "alert")
		end
	end

	if eshield_id and self.db.profile.eshield.enable and (a1 == eshield_target or a1 == "player") then
		-- self:Print("Updating Earth Shield in UNIT_AURA")
		self:eshield_BuffCheck()

		local buff, _, _, count, _, _, expirationTime, source  = UnitBuff(eshield_target, lN["Earth Shield"])
		-- self:Print("Earth Shield source: " .. source)

		if self.eshield.enabled and (not buff or source ~= "player") then
			self.eshield.enabled = false
			self:CancelTimer(self.eshield.TimerEvent, false)
			local es_target_name = UnitName(eshield_target)
			if not es_target_name then
				es_target_name = "Unknown"
			end
			if self.db.profile.eshield.alert then
				self:Message(L["Earth Shield faded from "] .. es_target_name, "eshield")
			end
		end
	end
end

-- Load NameToID table
-- This is only used to get UnitIDs for tanks
-- so there is no need to track pets
function ShamanFriend:UpdateUnits()
	local num_party = GetNumPartyMembers()
	local num_raid = GetNumRaidMembers()

	-- Don't do this in combat for performance reasons
	-- For this addon it is not a big deal if we don't
	-- have a current list of tanks if it changes during combat
	if InCombatLockdown() then
		DelayedUnitUpdate = true
		return
	end

	self.NameToID = {}

	if num_raid > 0 then
		for i = 1, num_raid do
			local unitID = "raid" .. i
			if UnitExists(unitID) then
				self.NameToID[UnitName(unitID)] = unitID
			end
		end
	elseif num_party > 0 then
		for i = 1, num_party do
			local unitID = "party" .. i
			if UnitExists(unitID) then
				self.NameToID[UnitName(unitID)] = unitID
			end
		end
	end

	-- The shaman shouldn't be a tank
	-- self.NameToID[UnitName("player")] = "player"
	DelayedUnitUpdate = false
end

function ShamanFriend:eshield_checkTarget()
	if eshield_id and self.db.profile.eshield.enable and eshield_target ~= eshield_casttarget then
		local buff, _, _, count, _, _, expirationTime, source  = UnitBuff(eshield_casttarget, lN["Earth Shield"])

		if source == "player" and buff then
			if InCombatLockdown() then
				-- Target changed in combat
				self.eshieldButton.texture:SetVertexColor(0.8,0,0,0.8)
				if self.eshield_lockdown == false then
					self.eshield_oldtarget = eshield_target
					self.eshield_lockdown = true
					-- self:Print("Earth Shield oldtarget " .. self.eshield_oldtarget)
				end
			end
			if self.eshield_lockdown and self.eshield_oldtarget == eshield_casttarget then
				-- Target changed back to original
				self.eshieldButton.texture:SetVertexColor(1,1,1,1)
				self.eshield_lockdown = false
			end

			eshield_target = eshield_casttarget
		        -- self:Print("Updating Earth Shield in eshield_checkTarget")
			if UnitInParty(eshield_target) or UnitInRaid(eshield_target) then
                                self:eshield_SetTarget(eshield_target)
				self:eshield_SetText("-","-")
				self:eshield_BuffCheck()
				self.eshield.enabled = true
				self.eshield.TimerEvent = self:ScheduleRepeatingTimer(self.eshield_BuffCheck, 10, self)
			else
				eshield_target = "Outside group"
                                self:eshield_SetTarget(eshield_target)
				self:eshield_SetText("-","-")
				self:eshield_BuffCheck()
				if self.eshield.enabled then
					self.eshield.enabled = false
					self:CancelTimer(self.eshield.TimerEvent, false)
				end
			end
		else
			if not UnitInParty(eshield_casttarget) and not UnitInRaid(eshield_casttarget) then
				eshield_target = "Outside group"
                                self:eshield_SetTarget(eshield_target)
				self:eshield_SetText("-","-")
				self:eshield_BuffCheck()
				if self.eshield.enabled then
					self.eshield.enabled = false
					self:CancelTimer(self.eshield.TimerEvent, false)
				end
			-- else
			-- self:Print("Earth Shield cast failed.")
			end
		end
	elseif eshield_id and self.db.profile.eshield.enable then
		local buff, _, _, count, _, _, expirationTime, source  = UnitBuff(eshield_target, lN["Earth Shield"])

		if source == "player" and buff then
			-- Earth Shield never changed targets, re-enable earth shield checking
			if not self.eshield.enabled then
				self.eshield.enabled = true
				self.eshield.TimerEvent = self:ScheduleRepeatingTimer(self.eshield_BuffCheck, 10, self)
				self:eshield_BuffCheck()
			end
		end
	end
end

function ShamanFriend:maelstrom_BuffCheck()
	local buff, _, _, count, _, _, expirationTime  = UnitBuff("PLAYER", lN["Maelstrom Weapon"])
	if buff then
		mw_count = count
		-- self:Print(lN["Maelstrom Weapon"] .. count)
	end
end

function ShamanFriend:fulmination_BuffCheck()
	local buff, _, _, count, _, _, expirationTime  = UnitBuff("PLAYER", lN["Lightning Shield"])
	if buff then
		ls_count = count
		-- self:Print(lN["Lightning Shield"] .. count)
	else
		ls_count = 0
	end
end

-- Find the expiration time of buff
function ShamanFriend:GetExpiration(timestamp, buff_name, unitid, default)
	-- Try to get a usable unitid
	if (unitid == UnitGUID("target")) then
		unitid = "target"
	elseif (unitid == UnitGUID("focus")) then
		unitid = "focus"
	elseif (unitid == UnitGUID("targettarget")) then
		unitid = "targettarget"
	elseif (unitid == UnitGUID("focustarget")) then
		unitid = "focustarget"
	else
		-- Couldn't find a usable unitid
		-- Default if we can't figure it out
		return timestamp + default
	end

	local buff, _, _, count, _, _, expirationTime  = UnitBuff(unitid, buff_name)
	if (buff) then
		return expirationTime
	else
		-- Default if we can't figure it out
		return timestamp + default
	end
end

-- Find a CC on the unit cast by any player
function ShamanFriend:GetCC(unitid)
	local spell

	-- Try to get a usable unitid
	if (unitid == UnitGUID("target")) then
		unitid = "target"
	elseif (unitid == UnitGUID("focus")) then
		unitid = "focus"
	elseif (unitid == UnitGUID("targettarget")) then
		unitid = "targettarget"
	elseif (unitid == UnitGUID("focustarget")) then
		unitid = "focustarget"
	else
		-- Couldn't find a usable unitid
		return
	end

	-- Go through all buffs on a unit until you find a CC
	local i = 1
	local buffName, _, _, _, _, _, _, _, _, _,
		buffID = UnitBuff(unitid, i)
	while buffName do
		if allcc_ids[buffID] and buffName then
			spell = buffName
			break
		end
		i = i + 1
		buffName, _, _, _, _, _, _, _, _, _,
			buffID = UnitBuff(unitid, i)
	end
	return spell
end

function ShamanFriend:OpenConfig()
	if InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory("ShamanFriend");
	else
		InterfaceOptionsFrame_OpenToFrame("ShamanFriend");
	end
end

function ShamanFriend:ShowVersion()
	self:Print(self.version)
end

function ShamanFriend:WfHandler(id, damage, crit, over, event)
	-- Melee + mh stormstrike
	if id == "melee" or id == 32175 then
		wf_cnt = 0
		wf_over = 0
		if event == "SWING_MISSED" or event == "SPELL_MISSED" then
			wf_miss = 1
			wf_dmg = 0
			wf_crit = 0
		else
			wf_miss = 0
			--self:Print("aaa: " .. damage .. "event: " .. event)
			wf_dmg = damage
			if crit == 1 then
				wf_crit = 1
			else
				wf_crit = 0
			end
		end

	-- oh stormstrike + wf mh + wf oh
	elseif id == 32176 or id == 25504 or id == 33750 then
		if id ~= 32176 then
			wf_cnt = wf_cnt + 1
			if id == 25504 then
				wf_hand = "mh"
			elseif id == 33750 then
				wf_hand = "oh"
			end 
		end
		
		if event == "SWING_MISSED" or event == "SPELL_MISSED" then
			wf_miss = wf_miss + 1
		else
			--self:Print("bbb: " .. damage)
			wf_dmg = wf_dmg + damage
			
			if crit == 1 then
				wf_crit = wf_crit + 1
			end
		end
	
	end
	
	if wf_cnt == 3 then
		self:WfPrinter()
	elseif (self.db.profile.wf.miss and wf_cnt > 0 and wf_cnt < 3 and over > 0) then
		wf_over = 1
		self:WfPrinter()
	end
end

function ShamanFriend:WfPrinter()
	if wf_hand == "mh" and self.db.profile.wf.hand then
		wf_str = L["MH Windfury"]
	elseif wf_hand == "oh" and self.db.profile.wf.hand then
		wf_str = L["OH Windfury"]
	else
		wf_str = L["Windfury"]
	end
	
	if wf_crit == 0 or not self.db.profile.wf.crit then
		wf_str = wf_str .. ": " .. wf_dmg
	elseif wf_crit == 1 then
		wf_str = wf_str .. L[" Single crit: "] .. wf_dmg
	elseif wf_crit == 2 then
		wf_str = wf_str .. L[" DOUBLE crit: "] .. wf_dmg
	elseif wf_crit == 3 then
		wf_str = wf_str .. L[" TRIPLE crit: "] .. wf_dmg
	elseif wf_crit == 4 then
		wf_str = wf_str .. L[" QUADRUPLE crit: "] .. wf_dmg
	elseif wf_crit == 5 then
		wf_str = wf_str .. L[" QUINTUPLE crit: "] .. wf_dmg
	else
		wf_str = wf_str .. " " .. wf_crit .. " crit: " .. wf_dmg
	end
	if self.db.profile.wf.miss and wf_miss > 0 then
		wf_str = wf_str .. " (" .. wf_miss .. L[" miss"] .. ")"
	end
	if self.db.profile.wf.miss and wf_over > 0 then
		wf_str = wf_str .. " (" .. wf_cnt .. L[" proc kill"] .. ")"
	end
	self:Message(wf_str, "wf")
	
	self.Wf = wf_dmg
	self.Wf_miss = wf_miss
	self.Wf_crit = wf_crit
	wf_cnt = 0
	wf_miss = 0
	wf_crit = 0
	wf_over = 0
	wf_dmg = 0
end

function ShamanFriend:LoHandler(spellID, spellDamage, spellCrit, event)
	if lb_ids[spellID] then
		if event == "SPELL_MISSED" then
			lo_miss = 1
		else
			lo_miss = 0
		end

		cl_cnt = 0;
		lo_hit = spellDamage
		if spellCrit == 1 then
			lo_crit = 1
		else
			lo_crit = 0
		end
	elseif lb_ol_ids[spellID] then
		if event == "SPELL_MISSED" then
			lo_miss = lo_miss + 1
		end

		lo_hit = lo_hit + spellDamage
		if spellCrit == 1 then
			lo_crit = lo_crit +1
		end
		
		lo_str = L["Lightning Overload"]
		if self.db.profile.lo.crit then
			if lo_crit == 1 then
				lo_str = lo_str .. L[" CRIT"]
			elseif lo_crit == 2 then
				lo_str = lo_str .. L[" DOUBLE CRIT"]
			elseif lo_crit > 2 then
				lo_str = lo_str .. lo_crit .. L[" CRIT"]
			end
		end
		
		if self.db.profile.lo.damage then
			lo_str = lo_str .. ": " .. lo_hit
		end
		if self.db.profile.lo.miss and lo_miss > 0 then
			lo_str = lo_str .. " (" .. lo_miss .. L[" miss"] .. ")"
		end
		self:Message(lo_str, "lo")
	elseif lvb_ids[spellID] then
		if event == "SPELL_MISSED" then
			lo_miss = 1
		else
			lo_miss = 0
		end

		cl_cnt = 0;
		lvb_hit = spellDamage
		if spellCrit == 1 then
			lvb_crit = 1
		else
			lvb_crit = 0
		end
	elseif lvb_ol_ids[spellID] then
		if event == "SPELL_MISSED" then
			lo_miss = lo_miss + 1
		end

		lvb_hit = lvb_hit + spellDamage
		if spellCrit == 1 then
			lvb_crit = lvb_crit +1
		end
		
		lo_str = L["Lava Burst Overload"]
		if self.db.profile.lo.crit then
			if lvb_crit == 1 then
				lo_str = lo_str .. L[" CRIT"]
			elseif lvb_crit == 2 then
				lo_str = lo_str .. L[" DOUBLE CRIT"]
			elseif lvb_crit > 2 then
				lo_str = lo_str .. lvb_crit .. L[" CRIT"]
			end
		end
		
		if self.db.profile.lo.damage then
			lo_str = lo_str .. ": " .. lvb_hit
		end
		if self.db.profile.lo.miss and lo_miss > 0 then
			lo_str = lo_str .. " (" .. lo_miss .. L[" miss"] .. ")"
		end
		self:Message(lo_str, "lo")
	elseif cl_ids[spellID] then
		if cl_cnt == 0 then
			lo_hit = spellDamage
			cl_cnt = 1
			-- Reset the cl_cnt in 2 sec
			self:ScheduleTimer(function() cl_cnt = 0
			end, 2, self)

			if event == "SPELL_MISSED" then
				lo_miss = 1
			else
				lo_miss = 0
			end

			if spellCrit == 1 then
				lo_crit = 1
			else
				lo_crit = 0
			end
		else
			lo_hit = lo_hit + spellDamage
			cl_cnt = cl_cnt + 1

			if event == "SPELL_MISSED" then
				lo_miss = lo_miss + 1
			end

			if spellCrit == 1 then
				lo_crit = lo_crit +1
			end
                end
		lo_c = 2
	elseif cl_ol_ids[spellID] then
		lo_hit = lo_hit + spellDamage
		lo_c = lo_c + 1

		if event == "SPELL_MISSED" then
			lo_miss = lo_miss + 1
		end

		if spellCrit == 1 then
			lo_crit = lo_crit +1
		end

		if lo_c / 3 == 1 then
			lo_str = L["Chain Lightning Overload"]
		elseif lo_c / 6 == 1 then
			lo_str = L["DOUBLE Chain Lightning Overload"]
		elseif lo_c / 9 == 1 then
			lo_str = L["TRIPLE Chain Lightning Overload"]
		end

		if self.db.profile.lo.crit then
			if lo_crit == 1 then
				lo_str = lo_str .. L[" CRIT"]
			elseif lo_crit == 2 then
				lo_str = lo_str .. L[" DOUBLE CRIT"]
			elseif lo_crit > 2 then
				lo_str = lo_str .. lo_crit .. L[" CRIT"]
			end
		end

		if self.db.profile.lo.damage then
			lo_str = lo_str .. ": " .. lo_hit
		end
		if self.db.profile.lo.miss and lo_miss > 0 then
			lo_str = lo_str .. " (" .. lo_miss .. L[" miss"] .. ")"
		end
		self:Message(lo_str, "lo")
	elseif fulm_ids[spellID] then
		fulm_hit = spellDamage
		if event == "SPELL_MISSED" then
			fulm_miss = 1
		else
			fulm_miss = 0
		end
		if spellCrit == 1 then
			fulm_crit = 1
		else
			fulm_crit = 0
		end
	elseif es_ids[spellID] then
		if ((fulm_hit == 0) and (fulm_miss == 0)) then
			return
		end

		fulm_hit = fulm_hit + spellDamage

		if event == "SPELL_MISSED" then
			fulm_miss = fulm_miss + 1
		end
		if spellCrit == 1 then
			fulm_crit = fulm_crit +1
		end
		
		lo_str = L["Fulmination"]
		if self.db.profile.lo.crit then
			if fulm_crit == 1 then
				lo_str = lo_str .. L[" CRIT"]
			elseif fulm_crit == 2 then
				lo_str = lo_str .. L[" DOUBLE CRIT"]
			elseif fulm_crit > 2 then
				lo_str = lo_str .. fulm_crit .. L[" CRIT"]
			end
		end
		
		if self.db.profile.lo.damage then
			lo_str = lo_str .. ": " .. fulm_hit
		end
		if self.db.profile.lo.miss and fulm_miss > 0 then
			lo_str = lo_str .. " (" .. fulm_miss .. L[" miss"] .. ")"
		end
		self:Message(lo_str, "lo")
		fulm_hit = 0
		fulm_miss = 0
	end
end

-- a1 - Unit casting the spell
-- a2 - Spell name
-- a3 - Spell rank
-- a4 = Spell target
function ShamanFriend:UNIT_SPELLCAST_SENT(event, a1, a2, a3, a4)
	if a1 ~= "player" then
		return
	end

	if self.db.profile.eshield.enable and a2 == lN["Earth Shield"] then
		if a4 ~= nil then
			eshield_casttarget = a4
			-- Temporarily disable earth shield checking
			if self.eshield.enabled then
				self.eshield.enabled = false
				self:CancelTimer(self.eshield.TimerEvent, false)
			end
			self:ScheduleTimer(self.eshield_checkTarget, 1, self)
		end
	end
end

--function ShamanFriend:ESSetTarget(t)
--	eshield_target = t
--end

function ShamanFriend:PLAYER_REGEN_DISABLED()
	if not (UnitIsDeadOrGhost("player")) then
		if self.db.profile.alert.shield then
			self:CheckShield()
		end
		if self.db.profile.alert.weapon then
			self:CheckWeapon()
		end
	end
end

function ShamanFriend:PLAYER_REGEN_ENABLED()
	if self.db.profile.alert.aftercombat then
		if not (UnitIsDeadOrGhost("player")) then
			if self.db.profile.alert.shield then
				self:CheckShield()
			end
			if self.db.profile.alert.weapon then
				self:CheckWeapon()
			end
		end
	end
	if (eshield_id) then
		-- self:Print("Updating Earth Shield in PLAYER_REGEN_ENABLED")
        	self:eshield_SetTarget(eshield_target)
		self:eshield_BuffCheck()
	end
	if DelayedUnitUpdate then
		self:UpdateUnits()
	end
end

function ShamanFriend:PLAYER_ENTERING_WORLD()
	ShamanFriend:ZoneCheck();
end

function ShamanFriend:ZoneCheck()
	local inInstance, instanceType = IsInInstance();

	self.announce = true
	self.zonetype = instanceType

        if instanceType == "pvp" then
        	if self.db.profile.display.bgannounce == "none" then
			self.announce = false
                end
        elseif instanceType == "arena" then
        	if self.db.profile.display.arenaannounce == false then
			self.announce = false
                end
        elseif instanceType == "party" then
        	if self.db.profile.display.partyannounce == false then
			self.announce = false
                end
        elseif instanceType == "raid" then
        	if self.db.profile.display.raidannounce == false then
			self.announce = false
                end
        else
        	if self.db.profile.display.worldannounce == false then
			self.announce = false
                end
        end
end

function ShamanFriend:Announce(msg, chatType, language, channel)
        if self.announce == false then
		return
        end

	-- Battlegrounds need to be handled specially
	if self.zonetype == "pvp" then
		if self.db.profile.display.bgannounce == "BATTLEGROUND" then
			chatType = "BATTLEGROUND"
		elseif self.db.profile.display.bgannounce == "PARTY" then
			if GetRealNumPartyMembers() > 0 then
				chatType = "PARTY"
			else
				return
			end
		elseif self.db.profile.display.bgannounce == "none" then
			return
		end
	end

	-- self:Print("announce: " .. tostring(self.announce) .. " chatType: " .. chatType)

	SendChatMessage(msg, chatType, language, channel);
end

function ShamanFriend:CheckShield()
	if not (UnitBuff("player", lN["Lightning Shield"]) or UnitBuff("player", lN["Water Shield"]) or UnitBuff("player", lN["Earth Shield"])) then
		if not (self.db.profile.alert.mounted and IsMounted()) then
			if not (self.db.profile.alert.vehicle and UnitInVehicle("player")) then
				self:Message(L["Missing: Elemental Shield"], "alert")
			end
		end
	end
end


function ShamanFriend:CheckWeapon()
	local a,_,_,d = GetWeaponEnchantInfo()
	if not a then
		if not (self.db.profile.alert.mounted and IsMounted()) then
			if not (self.db.profile.alert.vehicle and UnitInVehicle("player")) then
				self:Message(L["Missing: Main Hand Enchant"], "alert")
			end
		end
	end
	
	if OffhandHasWeapon() and not d then
		if not (self.db.profile.alert.mounted and IsMounted()) then
			if not (self.db.profile.alert.vehicle and UnitInVehicle("player")) then
				self:Message(L["Missing: Off Hand Enchant"], "alert")
			end
		end
	end
end

function ShamanFriend:Message(str, type)
	local c, t
	if type == "wf" then
		c = self.db.profile.wf.display.color
		t = self.db.profile.wf.display.time
		opt_sound = "none"
	elseif type == "alert" then
		c = self.db.profile.alert.display.color
		t = self.db.profile.alert.display.time
		opt_sound = self.db.profile.alert.sound
	elseif type == "spell" then
		c = self.db.profile.spell.display.color
		t = self.db.profile.spell.display.time
		opt_sound = "none"
	elseif type == "lo" then
		c = self.db.profile.lo.display.color
		t = self.db.profile.lo.display.time
		opt_sound = "none"
	elseif type == "misc" then
		c = self.db.profile.misc.display.color
		t = self.db.profile.misc.display.time
		opt_sound = "none"
	elseif type == "eshield" then
		c = self.db.profile.eshield.display.color
		t = self.db.profile.eshield.display.time
		opt_sound = self.db.profile.eshield.sound
	elseif type == "cc" then
		c = self.db.profile.cc.display.color
		t = self.db.profile.cc.display.time
		opt_sound = self.db.profile.cc.sound
	elseif type == "proc" then
		c = self.db.profile.alert.display.color
		t = self.db.profile.alert.display.time
		opt_sound = self.db.profile.alert.proc_sound
	end
	if (type == "wf" and self.db.profile.wf.display.frames) or ((type == "alert" or type == "proc") and self.db.profile.alert.display.frames) or (type == "spell" and self.db.profile.spell.display.frames) or (type == "lo" and self.db.profile.lo.display.frames) or (type == "misc" and self.db.profile.misc.display.frames) or (type == "eshield" and self.db.profile.eshield.display.frames) or (type == "cc" and self.db.profile.cc.display.frames) then
		if self.db.profile.display.chat then
			if self.db.profile.display.number == 0 then
				self:Print(str)
			else
				local chatframe = getglobal("ChatFrame" .. self.db.profile.display.number)
				chatframe:AddMessage(str, c.r, c.g, c.b)
			end
		end
		if self.db.profile.display.screen then
			UIErrorsFrame:AddMessage(str, c.r, c.g, c.b, 1, t)
		end
		if self.db.profile.display.frame then
			if t ~= 5 then
				self.msgFrame:SetTimeVisible(t)
			end
			self.msgFrame:AddMessage(str, c.r, c.g, c.b, 1, t)
		end
	end
	if ((type == "wf" and self.db.profile.wf.display.scroll) or ((type == "alert" or type == "proc") and self.db.profile.alert.display.scroll) or (type == "spell" and self.db.profile.spell.display.scroll) or (type == "lo" and self.db.profile.lo.display.scroll) or (type == "misc" and self.db.profile.misc.display.scroll) or (type == "eshield" and self.db.profile.eshield.display.scroll) or (type == "cc" and self.db.profile.cc.display.scroll)) then
		-- Use LibSink to handle scrolling text
		self:Pour(str, c.r, c.g, c.b)
	end
	
	if opt_sound ~= "none" then
		local sound = sounds[opt_sound]
		if string.find(sound, "%\\") then
			PlaySoundFile(sound)
		else
			PlaySound(sound)
		end
	end
end

function ShamanFriend:SinkPrint(addon, message, r, g, b)
 	if not self.msgFrame then self:CreateCustomFrame() end
 	self.msgFrame:AddMessage(message, r, g, b, 1, UIERRORS_HOLD_TIME)
end

function ShamanFriend:CreateCustomFrame()
	self.dragButton = CreateFrame("Button",nil,UIParent)
	self.dragButton.owner = self
	self.dragButton:Hide()
	self.dragButton:ClearAllPoints()
	self.dragButton:SetWidth(250)
	self.dragButton:SetHeight(20)
	
	if self.db.profile.display.x and self.db.profile.display.y then
		--local s = self.dragButton:GetEffectiveScale()
		--self.dragbutton:ClearAllPoints()
		--self.dragButton:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.display.x / s, self.db.profile.display.y / s)
		self.dragButton:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.display.x, self.db.profile.display.y)
	else 
		self.dragButton:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, 0)
	end	
	
	self.dragButton:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	})
	self.dragButton:SetBackdropColor(0,0,0.3,.6)	
	
	self.dragButton:SetMovable(true)
	self.dragButton:RegisterForDrag("LeftButton")
	self.dragButton:SetScript("OnDragStart", function() ShamanFriend.dragButton:StartMoving() end )
	self.dragButton:SetScript("OnDragStop",
		function()
			ShamanFriend.dragButton:StopMovingOrSizing()
			self.db.profile.display.x = ShamanFriend.dragButton:GetLeft()
			self.db.profile.display.y = ShamanFriend.dragButton:GetTop()
		end
	)

	self.msgFrame = CreateFrame("MessageFrame")
	self.msgFrame.owner = self
	self.msgFrame:ClearAllPoints()
	self.msgFrame:SetWidth(400)
	self.msgFrame:SetHeight(75)
	self.msgFrame:SetPoint("TOP", self.dragButton, "TOP", 0, 0)
	self.msgFrame:SetInsertMode("TOP")
	self.msgFrame:SetFrameStrata("HIGH")
	self.msgFrame:SetToplevel(true)

	self.msgText = self.dragButton:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
	self.msgText:SetText("ShamanFriend Display")
	self.msgText:SetPoint("TOP", self.dragButton, "TOP", 0, -5)

	self:UpdateLock()
	self:UpdateFont()
	
	self.msgFrame:Show()
end

function ShamanFriend:UpdateFont()
	if self.db.profile.display.frame and self.msgFrame then
		self.msgFrame:SetFont("Fonts\\" .. self.db.profile.display.fontFace, self.db.profile.display.fontSize,self.db.profile.display.fontEffect)
		
		--if self.db.profile.display.fontSize == "small" then
		--	self.msgFrame:SetFontObject(GameFontNormalSmall)
		--elseif self.db.profile.display.fontSize == "normal" then
		--	self.msgFrame:SetFontObject(GameFontNormal)
		--elseif self.db.profile.display.fontSize == "large" then
		--	self.msgFrame:SetFontObject(GameFontNormalLarge)
		--elseif self.db.profile.display.fontSize == "huge" then
		--	self.msgFrame:SetFontObject(GameFontNormalHuge)
		--end
	end
end

function ShamanFriend:UpdateLock()
	if self.db.profile.display.frame and self.msgFrame then
		if self.db.profile.display.lock and not self.configMode then
			self.dragButton:SetMovable(false)
			self.dragButton:RegisterForDrag()
			self.msgFrame:SetBackdrop(nil)
			self.msgFrame:SetBackdropColor(0,0,0,0)
			self.dragButton:Hide()
		else
			self.dragButton:Show()
			self.dragButton:SetMovable(true)
			self.dragButton:RegisterForDrag("LeftButton")
			self.msgFrame:SetBackdrop({
				bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			})
			self.msgFrame:SetBackdropColor(0,0,0.3,.3)
		end
	end
end

function ShamanFriend:FindEshieldId()
	local i = 1
        eshield_id = nil
	while true do
	   local spell, rank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
	   if (not spell) then
		  break
	   end
	   if spell == lN["Earth Shield"] then
		  eshield_id = i
	   end
	   i = i + 1
	end
end

function ShamanFriend:CreateEshieldFrame()
	if eshield_id == nil then
		return
	end
	
	self.eshieldFrame = CreateFrame("Frame","ShamanFriend_eshield",UIParent)
	self.eshieldFrame.owner = self
	self.eshieldFrame:ClearAllPoints()
	self.eshieldFrame:SetWidth(170)
	self.eshieldFrame:SetHeight(54)
--	self.eshieldFrame:SetFrameStrata("DIALOG")
	self.eshieldFrame:SetFrameStrata("MEDIUM")
	self.eshieldFrame:SetToplevel(true)
	self.eshieldFrame:SetMovable(true)
	self.eshieldFrame:EnableMouse(true)
	self.eshieldFrame:SetMovable(true)
	self.eshieldFrame:RegisterForDrag("LeftButton")
	self.eshieldFrame:SetScript("OnDragStart",
		function()
			if (not self.db.profile.eshield.lock) or self.configMode then
				ShamanFriend.eshieldFrame:StartMoving()
			end
		end
	)
	self.eshieldFrame:SetScript("OnDragStop",
		function()
			ShamanFriend.eshieldFrame:StopMovingOrSizing()
			self.db.profile.eshield.x = ShamanFriend.eshieldFrame:GetLeft()
			self.db.profile.eshield.y = ShamanFriend.eshieldFrame:GetTop()
		end
	)
	
	if self.db.profile.eshield.x and self.db.profile.eshield.y then
		self.eshieldFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.eshield.x, self.db.profile.eshield.y)
	else 
		self.eshieldFrame:SetPoint("BOTTOMRIGHT", UIParrent, "BOTTOMRIGHT", -200, 300)
	end	
	
	self.eshieldHeader = self.eshieldFrame:CreateFontString(nil, "OVERLAY")
	self.eshieldHeader.owner = self
	
	self.eshieldInfo = self.eshieldFrame:CreateFontString(nil, "OVERLAY")
	self.eshieldInfo.owner = self

	self:SetButtonMode()

	self.eshieldButton = CreateFrame("Button", "ShamanFriend_eshieldButton", self.eshieldFrame, "SecureActionButtonTemplate")
	self.eshieldButton.class = self
	self.eshieldButton:SetPoint("TOPRIGHT", self.eshieldFrame, "TOPLEFT", 0, 0)
	self.eshieldButton:SetWidth(36)
	self.eshieldButton:SetHeight(36)
--	self.eshieldButton:SetFrameStrata("DIALOG")
	self.eshieldButton:SetFrameStrata("MEDIUM")
	self.eshieldButton:SetToplevel(true)
	self.eshieldButton:HookScript("OnEnter", ShamanFriend.ShowTooltip)
	self.eshieldButton:HookScript("OnLeave", ShamanFriend.HideTooltip)
	
	--self.eshieldButton:SetNormalTexture(GetSpellTexture("Healing Wave"))
	--self.eshieldButton:SetNormalTexture(GetSpellTexture(lN["Earth Shield"]))
	--self.eshieldButton:SetNormalTexture("")
	
	self.eshieldButton.texture = self.eshieldButton:CreateTexture(nil, "ARTWORK")
	--self.eshieldButton.texture:SetTexture(GetSpellTexture("Healing Wave"))
	self.eshieldButton.texture:SetTexture(GetSpellTexture(lN["Earth Shield"]))
	self.eshieldButton.texture:SetPoint("TOPLEFT", self.eshieldButton, "TOPLEFT", 3, -3)
	self.eshieldButton.texture:SetPoint("BOTTOMRIGHT", self.eshieldButton, "BOTTOMRIGHT",  -3, 3)
	self.eshieldButton.texture:SetTexCoord(0.10, 0.90, 0.10, 0.90)
	
	self.eshieldButton_shadow = CreateFrame("Frame", "ShamanFriend_eshieldButton_shadow", self.eshieldButton)
	--frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})
	self.eshieldButton_shadow:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true, tileSize = 8, edgeSize = 9,
			insets = { left = 2, right =2, top = 2, bottom = 2 }
		})
	self.eshieldButton_shadow:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
	self.eshieldButton_shadow:SetAllPoints(self.eshieldButton)
	self.eshieldButton_shadow:SetFrameLevel(0)
	
	self.eshieldButton.Cooldown = CreateFrame("Cooldown", "ShamanFriend_eshieldButton_cooldown", self.eshieldButton, "CooldownFrameTemplate");
	
        self.eshield_target = "target"
	self:eshield_SetTarget("target")
	
	self:eshield_SetText("-","-")

	self.eshieldFrame:Show()
end

function ShamanFriend:SetButtonMode()
	self.eshieldFrame:ClearAllPoints()
	if self.db.profile.eshield.x and self.db.profile.eshield.y then
		self.eshieldFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.eshield.x, self.db.profile.eshield.y)
	else 
		self.eshieldFrame:SetPoint("BOTTOMRIGHT", UIParrent, "BOTTOMRIGHT", -200, 300)
	end	

	self.eshieldFrame:Hide()
	if (self.db.profile.eshield.button) then
		self.eshieldFrame:SetWidth(36)
		self.eshieldFrame:SetHeight(36)
		if (ShamanFriend.db.profile.eshield.lock) then
			self.eshieldFrame:SetBackdrop(nil)
			self.eshieldFrame:SetBackdropColor(0,0,0,0)
		else
			self.eshieldFrame:SetBackdrop({
					bgFile = "Interface/Tooltips/UI-Tooltip-Background",
					edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
					tile = true, tileSize = 8, edgeSize = 9,
					insets = { left = 2, right =2, top = 2, bottom = 2 }
				})
			self.eshieldFrame:SetBackdropColor(0.1,0.1,0.1,0.9)
		end

		self.eshieldInfo:SetFontObject(GameFontNormalLarge)
		self.eshieldInfo:ClearAllPoints()
		self.eshieldInfo:SetTextColor(1, 1, 1, 1)
		self.eshieldInfo:SetWidth(36)
		self.eshieldInfo:SetHeight(36)
		self.eshieldInfo:SetPoint("TOP", self.eshieldFrame, "TOP",0,0)
		self.eshieldInfo:SetJustifyH("LEFT")
		self.eshieldInfo:SetJustifyV("MIDDLE")

		self:eshield_SetText("-","-")
		self:eshield_BuffCheck()
		-- self:Print("SetButtonMode Hide")
		self.eshieldFrame:Show()
		self.eshieldHeader:Hide()
		self.eshieldInfo:Show()
	else
		self.eshieldFrame:SetWidth(170)
		self.eshieldFrame:SetHeight(54)
		self.eshieldFrame:SetBackdrop({
				bgFile = "Interface/Tooltips/UI-Tooltip-Background",
				edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
				tile = true, tileSize = 8, edgeSize = 9,
				insets = { left = 2, right =2, top = 2, bottom = 2 }
			})
		self.eshieldFrame:SetBackdropColor(0.1,0.1,0.1,0.9)

		self.eshieldHeader:SetFontObject(GameFontNormalSmall)
		self.eshieldHeader:ClearAllPoints()
		self.eshieldHeader:SetWidth(170)
		self.eshieldHeader:SetHeight(12)
		self.eshieldHeader:SetPoint("TOP", self.eshieldFrame, "TOP",0,-2)
		self.eshieldHeader:SetJustifyH("CENTER")
		self.eshieldHeader:SetJustifyV("TOP")
		self.eshieldHeader:SetText(L["Shaman Friend ES Tracker"])

		self.eshieldInfo:SetFontObject(GameFontNormalSmall)
		self.eshieldInfo:ClearAllPoints()
		self.eshieldInfo:SetTextColor(1, 1, 1, 1)
		self.eshieldInfo:SetWidth(130)
		self.eshieldInfo:SetHeight(36)
		self.eshieldInfo:SetPoint("TOP", self.eshieldHeader, "BOTTOM",0,0)
		self.eshieldInfo:SetJustifyH("LEFT")
		self.eshieldInfo:SetJustifyV("MIDDLE")

		self:eshield_SetText("-","-")
		self:eshield_BuffCheck()

		-- self:Print("SetButtonMode Show")
		self.eshieldFrame:Show()
		self.eshieldHeader:Show()
		self.eshieldInfo:Show()
	end
end

function ShamanFriend:ShowTooltip()
	if (ShamanFriend.db.profile.eshield.notooltip) then
		return
	end

	if (eshield_id) then
		GameTooltip:SetOwner(ShamanFriend.eshieldButton,ANCHOR_LEFT)
		GameTooltip:SetSpellBookItem(eshield_id, BOOKTYPE_SPELL)
		-- GameTooltip:SetHyperlink(GetSpellLink(lN["Earth Shield"]))
	end
end

function ShamanFriend:HideTooltip()
	GameTooltip:Hide()
end

function ShamanFriend:eshield_SetText(eshield_text_charges, eshield_text_time)
	if eshield_target == L["Outside group"] then
		eshield_text_charges = "-"
		eshield_text_time = "-"
		if (self.db.profile.eshield.button) then
			if eshield_text_charges == "-" then
				eshield_text_charges = ""
			end
			self.eshieldInfo:SetText(eshield_text_charges)
		else
			self.eshieldInfo:SetText(L["Charges: "] .. eshield_text_charges .. "|n" .. L["Time: "] .. eshield_text_time .. "|n" .. L["Target: "] .. "|cffff0000" .. eshield_target .. "|r")
		end
	else
		if (self.db.profile.eshield.button) then
			if eshield_text_charges == "-" then
				eshield_text_charges = ""
			end
			self.eshieldInfo:SetText(eshield_text_charges)
		else
			self.eshieldInfo:SetText(L["Charges: "] .. eshield_text_charges .. "|n" .. L["Time: "] .. eshield_text_time .. "|n" .. L["Target: "] .. eshield_target)
		end
	end
end

function ShamanFriend:eshield_BuffCheck()
	if (not eshield_target) or eshield_target == L["Outside group"] or eshield_target == "-" then
		self:eshield_SetText("-","-")
	else
		local nothing = true
		local buff, _, _, count, _, _, expirationTime  = UnitBuff(eshield_target, lN["Earth Shield"])

		if buff == lN["Earth Shield"] then
			if expirationTime  == nil then
				expirationTime  = "|cff999999Unavailable|r"
			else
				expirationTime  = math.ceil((expirationTime  - GetTime()) / 60) .. L[" min"]
			end

			self:eshield_SetText(count,expirationTime )
			nothing = false
		end
		
		if nothing then
			self:eshield_SetText("-","-")
		end
	end
end

function ShamanFriend:eshield_SetTarget(t)
        if not InCombatLockdown() then
		self.eshieldButton:SetAttribute("type1", "spell")
		self.eshieldButton:SetAttribute("spell1", lN["Earth Shield"])
		self.eshieldButton:SetAttribute("unit1", t)
		self.eshieldButton.texture:SetVertexColor(1,1,1,1)
		self.eshield_lockdown = false
	end
end

function ShamanFriend:SPELL_UPDATE_COOLDOWN()
	if eshield_id then
		local start, duration, enable = GetSpellCooldown(eshield_id, BOOKTYPE_SPELL );
		CooldownFrame_SetTimer(self.eshieldButton.Cooldown, start, duration, enable );
	end
end

