local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local L = LibStub("AceLocale-3.0"):NewLocale("SlamAndAwe", "enUS", true, debug);

L["About"] = true
L["Version"] = true 
L["__URL__"] = "http://wow.curse.com/downloads/wow-addons/details/slamandawe.aspx"

------------------------------------------------------------------
-- Spell Names these MUST be localised for addon to work
------------------------------------------------------------------

L["WF_Attack"] = "Your Windfury Attack(.+) (%d+)"
L["One-Handed Axes"] = true
L["Two-Handed Axes"] = true
L["Daggers"] = true
L["Fist Weapons"] = true
L["One-Handed Maces"] = true
L["Two-Handed Maces"] = true
L["DPS"] = "(%d+.%d) damage per second"
L["Out of range"] = true
L["too far away"] = true
L["Weapon"] = true -- this is 7th return value for GetItemInfo used to check if Offhand is weapon
L["Alchemy"] = true -- this is the name of the Alchemy profession as it appears on the skills panel in game
L["Searing Totem"] = true -- used to check if Fire Nova can work

------------------
-- Help section
------------------
L["help_CS"] = "Activate or deactivate the Colossus Smash timer bar."
L["help_DW"] = "Activate or deactivate the Death Wish timer bar."
L["help_RE"] = "Activate or deactivate the Recklessness timer bar."

L["help"] = "All options can be configured more easily using the Blizzard options menu. Press ESC and select addons then click on SlamAndAwe to configure."
L["help1"] = "All options can be configured more easily using the Blizzard options menu."
L["help2"] = "Press ESC and select addons then click on SlamAndAwe to configure."
L["help_width"] = "The width of the cooldown bars, in pixels."
L["help_scale"] = "Use this to scale bars frame. Valid scale multiplier values are 0.25 to 3"
L["help_reset"] = "Resets bars frame to default values."
L["help_reset_uptime"] = "Reset uptime frame to default values"
L["help_reset_priority"] = "Reset priority frame to default values"
L["help_testbar"] = "Fires a Test Event."
L["help_display"] = "Hide or unhide the bar frames to reposition them.  When displayed, left click to drag the bars."
L["help_ss"] = "Activate or deactivate the Stormstrike bar."
L["help_magma"] = "Activate or deactivate the Fire Totem bar."
L["help_wf"] = "Activate or deactivate the Windfury bar."
L["help_twist"] = "Activate or deactivate the totem twisting bar."
L["help_shock"] = "Activate or deactivate the shocks bar."
L["help_fsdot"] = "Activate or deactivate the flame shock dot overlay bar."
L["help_shear"] = "Activate or deactivate the wind shear bar."
L["help_arena"] = "Activate or deactivate arena 4 piece bonus (9 second stormstrikes)."
L["help_shield"] = "Activate or deactivate the watershield timer bar."
L["help_maelstrom"] = "Activate or deactivate the maelstrom weapon bar."
L["help_lavalash"] = "Activate or deactivate Lava Lash bar."
L["help_firenova"] = "Activate or deactivate Fire Nova bar."
L["help_version"] = "Show version information" 
L["help_windshear"] = "Activate or deactivate the icon to warn if you should use Wind Shear to reduce threat" 
L["help_threat"] = "Percentage threat that triggers display of Wind Shear warning" 
L["help_debug"] = "Activate or deactivate debug messages" 
L["help_textonbars"] = "Activate or deactivate text displays on bars"
L["help_showuptime"] = "Activate or deactivate Uptime frame"
L["help_gcd"] = "Activate or deactivate display of global cooldown bar"
L["help_gcd_fullwidth"] = "Show GCD bar as a full width bar"
L["help_mw5sound"] = "Select sound to play every X seconds when Maelstrom Weapon has 5 stacks"
L["help_mw5soundplay"] = "Activate or deactivate playing sound when Maelstrom Weapon has 5 stacks"
L["help_mw5flash"] = "Activate or deactive flashing of Maelstrom Weapon bar when 5 stacks achieved"
L["help_mw4sound"] = "Select sound to play when Maelstrom Weapon reaches 4 stacks"
L["help_mw4soundplay"] = "Activate or deactivate playing sound when Maelstrom Weapon reaches 4 stacks"
L["help_mw5repeat"] = "Select interval after which Maelstrom weapon 5 stack sound repeats"
L["help_showwftotals"] = "Display total Windfury damage using Scrolling Combat Text if installed"
L["help_priority"] = "Activate or deactivate Priority Icon frame"
L["help_cooldown"] = "Seconds left on cooldown to consider showing priority. eg: 0 means wait until Cooldown over before option available. Whereas 0.25 means any skill with 0.25 sec or less of Cooldown show it as next priority."
L["help_export"] = "Export character data for use with EnhSim"
L["help_news"] = "Display the latest news item about SlamAndAwe"
L["help_disablebars"] = "Tick to disable the display of timer bars out of combat"
L["help_fsticksleft"] = "Damage Ticks left on Flame Shock debuff before showing priority. ie: 3 means only show Flame Shock in prioirty if 3 or less damage ticks left on target's debuff."
L["help_srmana"] = "Percentage mana left at which Priority frame shows Shamanistic Rage icon. Use 0 to indicate disable this option."
L["help_wsmana"] = "If mana is below this percent recommend Water Shield, if it is above this percent recommend Lightning Shield. To always recommend Water Shield set to 100, to always recommend Lightning Shield set to 0."
L["help_hwhealth"] = "Percentage of health remaining to recommend Healing Wave."
L["help_worldbossonly"] = "Restrict showing of Wind Shear in priority frame to times when target is a World Boss."
L["help_config"] = "Display easy to use graphical config panel"
L["help_combopoints"] = "Show Maelstrom Weapon stacks as combo points on the priority frame"
L["help_baricons"] = "Show icon alongside each bar to help identify which bar it is"
L["help_feralspirit"] = "Activate or deactivate the Feral Spirit bar"
L["help_totemtimeleft"] = "Seconds left on Totem buff before showing priority. ie: 20 means show priority placement of Totem if less than 20 seconds left before totem expires."
L["help_outofrange"] = "Display a large warning message if you are out of range of target"
L["help_chingroup"] = "Displays Chain Heal instead of Healing Wave when health is below Healing Wave Health% while you are in a group."
L["help_shieldorbs"] = "Max orbs left for Water or Lightning Shield to be recommended."
L["help_magmaticks"] = "Recommend refresh Magma totem if this number of ticks left before totem expires."
L["help_searingticks"] = "Recommend refresh Searing totem if this number of ticks left before totem expires."
L["help_disable"] = "Enables or disables the addon - typically use when changing specs"
L["help_showinterrupt"] = "Activate or deactivate display of enemy spell interrupt frame"
L["help_showpurge"] = "Activate or deactivate display of enemy buff purgeable frame"
L["help_showcooldown"] = "Activate or deactivate display of cooldown 'clock' display on priority frame"
L["help_hideimmunespells"] = "Activate or deactivate hiding of spells from priority frame that mob is immune to"
L["help_resetImmunity"] = "This will clear the immunity tables so that all mobs are reset"
L["help_priority_scale"] = "This will scale the priority frame"
L["help_activeshields"] = "Untick to hide shield bar whilst its active"
L["help_specchangewarning"] = "Activate or deactivate warning if you are not in Enhance Spec"
L["help_showpetframe"] = "Activate or deactivate Feral Spirits Pet frame"

L["help_heroicstrike"] = "Display Heroic Strike during Incite, Battle Trance or when Rage above configured threshold"
L["help_hsrage"] = "Set heroic strike rage threshold"
----------------
-- Menu section
----------------
L["Colossus Smash Bar"] = true
L["Death Wish Bar"] = true
L["Recklessness Bar"] = true

L["Timer Bars"] = true
L["Disable out of combat"] =true
L["Bar Colours"] = true
L["Uptime Frame"] = true
L["Shield Bar"] = true
L["Maelstrom Bar"] = true
L["Stormstrike Bar"] = true
L["Windfury Bar"] = true
L["Shock Bar"] = true
L["FS Dot Bar"] = true
L["Shear Bar"] = true
L["Fire Totem Bar"] = true
L["Lava Lash Bar"] = true
L["Shock Rotation"] = true
L["4 piece arena bonus"] = true
L["Text Display"] = true
L["Bar Width"] = true
L["Bar Scale"] = true
L["Water Shield Alpha"] = true
L["Maelstrom Alpha"] = true
L["Maelstrom Full Alpha"] = true
L["Show Active Shields"] = true
L["HS Rage Threshold"] = true
L["Threat Threshold"] = true
L["Cooldown Threshold"] = true
L["Display Test Bar"] = true
L["Show Frame"] = true
L["Reset Bars"] = true
L["Reset Uptime"] = true
L["Reset Priority"] = true
L["Reset Session info"] = true
L["Move Frames"] = true
L["Debug mode"] = true
L["Bar Texture"] = true
L["Border Texture"] = true
L["Bar Border Texture"] = true
L["Bars Section"] = true
L["Priority Section"] = true
L["Display frame title"] = true
L["Display News"] = true
L["Frame Options"] = true
L["Misc Options"] = true
L["Media Options"] = true
L["Maelstrom Sound 4"] = true
L["Maelstrom Sound 5"] = true
L["Shield Sound"] = true
L["Weapon Sound"] = true
L["Sound Repeat Interval"] = true
L["Maelstrom Flash"] = true
L["Bar Font"] = true
L["Bar Font Size"] = true
L["Bar Font Effect"] = true
L["Message Font"] = true
L["Message Font Size"] = true
L["Message Font Effect"] = true
L["OUTLINE"] = true
L["THICKOUTLINE"] = true
L["MONOCHROME"] = true
L["Maelstrom Weapon Sound"] = true
L["GCD"] = "Global Cooldown Bar" 
L["GCD full width"] = true
L["Stats Frame"] = true
L["Show Windfury Totals"] = true 
L["Windfury Totals Colour"] = true
L["Export to Sim"] = true
L["Flame Shock Ticks Left"] = true 
L["Flame Shock if Unleash Flame"] = true
L["Lava lash 5 searing flames"] = true
L["Lava lash 4 searing flames"] = true
L["Lava lash 3 searing flames"] = true
L["Totem Time Left"] = true
L["Shamanistic Rage Level%"] = true
L["Water Shield Level%"] = true
L["Shield orbs left"] = true
L["Healing Wave Health%"] = true
L["Chain Heal in group"] = true
L["World Boss Only"] = true
L["Configure Options"] = true
L["Combo Points"] = true
L["Show bar icons"] = true
L["Feral Spirit Bar"] = true
L["Drop Totem"] = true
L["Enable/Disable"] = true
L["Show Interrupt"] = true
L["Show Purge"] = true 
L["Show Cooldown"] = true 
L["Hide Immune Spells"] = true
L["Reset Immunity"] = true
L["Set Priorities"] = true
L["Use Priority Set"] = true
L["Magma ticks left"] = true
L["Searing ticks left"] = true
L["Warn on Spec Change"] = true
L["Show Feral Spirit Pet Frame"] = true
L["Enabled display of Feral Spirit Pet frame"] = true
L["Disabled display of Feral Spirit Pet frame"] = true

------------------
-- Config section
------------------
L["config_HS_on"] = "Heroic Strike will now be displayed"
L["config_HS_off"] = "Heroic Strike will NOT now be displayed"
L["config_CS_on"] = "Colossus Smash bar will now be displayed"
L["config_CS_off"] = "Colossus Smash  bar will NOT now be displayed"
L["config_DW_on"] = "Death Wish bar will now be displayed"
L["config_DW_off"] = "Death Wish bar will NOT now be displayed"
L["config_RE_on"] = "Recklessness bar will now be displayed"
L["config_RE_off"] = "Recklessness bar will NOT now be displayed"

L["config_SS_on"] = "Stormstrike bar will now be displayed when cast"
L["config_SS_off"] = "Stormstrike bar will NOT now be displayed when cast"
L["config_WF_on"] = "Windfury bar will now be displayed when cast"
L["config_WF_off"] = "Windfury bar will NOT now be displayed when cast"
L["config_Shock_on"] = "Shock bar will now be displayed when cast"
L["config_Shock_off"] = "Shock bar will NOT now be displayed when cast"
L["config_FSDotShow_on"] = "Flame Shock dot bar will now be displayed when FS dot on target"
L["config_FSDotShow_off"] = "Flame Shock dot bar will NOT now be displayed when FS dot on target"
L["config_Shear_on"] = "Wind Shear bar will now be displayed when cast"
L["config_Shear_off"] = "Wind Shear bar will NOT now be displayed when cast"
L["config_Sheild_on"] = "Shield bar will now be displayed"
L["config_Sheild_off"] = "Shield bar will NOT now be displayed"
L["config_Arena_on"] = "Using Arena kit bonus with Stormstrike timer"
L["config_Arena_off"] = "NOT using Arena kit bonus with Stormstrike timer"
L["config_Uptime_on"] = "Display of Uptime frame enabled"
L["config_Uptime_off"] = "Display of Uptime frame disabled"
L["config_MW_on"] = "Maelstrom bar will now be displayed"
L["config_MW_off"] = "Maelstrom bar will NOT now be displayed"
L["config_FN_on"] = "Fire Nova bar will now be displayed"
L["config_FN_off"] = "Fire Nova  bar will NOT now be displayed"
L["config_GCD_on"] = "Global Cooldown bar will now be displayed"
L["config_GCD_off"] = "Global Cooldown bar will NOT now be displayed"
L["config_debug_on"] = "Debug info will now be displayed"
L["config_debug_off"] = "Debug info will NOT now be displayed"
L["config_WSicon_on"] = "Wind Shear icon will now be displayed"
L["config_WSicon_off"] = "Wind Shear icon will NOT now be displayed"
L["config_Barstext_on"] = "Text info on bars will now be displayed"
L["config_Barstext_off"] = "Text info on bars will NOT now be displayed"
L["config_Threat"] = "Threat threshold for Wind Shear display set to : "
L["config_Rage"] = "Rage threshold for Heroic Strike display set to : "
L["config_Cooldown"] = "Cooldown threshold for priority icon display set to : "
L["config_FSTicksLeft"] = "Flame Shock threshold for priority icon display set to : "
L["config_ticksleft"] = " ticks left"
L["config_ShieldAlpha"] = "Shield Alpha set to : "
L["config_MSAlpha_ooc"] = "Maelstrom Alpha out of Combat set to : "
L["config_MSAlpha_combat"] = "Maelstrom Alpha in Combat set to : "
L["config_reset"] = "Reset bar frame to default values"
L["config_mw5soundplay_on"] = "Will play a sound when Maelstrom Weapon reaches 5 stacks"
L["config_mw5soundplay_off"] = "Will NOT play a sound when Maelstrom Weapon reaches 5 stacks"
L["config_mw5flash_on"] = "Flash the Maelstrom Weapon bar when it reaches 5 stacks"
L["config_mw5flash_off"] = "Do NOT flash the Maelstrom Weapon bar when it reaches 5 stacks"
L["config_mw4soundplay_on"] = "Will play a sound when Maelstrom Weapon reaches 4 stacks"
L["config_mw4soundplay_off"] = "Will NOT play a sound when Maelstrom Weapon reaches 4 stacks"
L["config_wfcalc_on"] = "Total Windfury damage will be displayed in Scrolling Combat Text (if installed)"
L["config_wfcalc_off"] = "Total Windfury damage will NOT be displayed in Scrolling Combat Text (if installed)"
L["config_priority_on"] = "Priority Frame is enabled"
L["config_priority_off"] = "Priority Frame is disabled"
L["config_prioritytitle_on"] = "Priority Frame's title will now be displayed"
L["config_prioritytitle_off"] = "Priority Frame's title will NOT now be displayed"
L["config_disable_on"] = "Timer bars will now be hidden out of combat"
L["config_disable_off"] = "Timer bars will remain displayed out of combat"
L["config_worldboss_on"] = "Wind Shear will only be shown if threat exceeded when target is a world boss"
L["config_worldboss_off"] = "Wind Shear will be shown if threat exceeded on any target"
L["config_combopoints_on"] = "Maelstrom Weapon combo points will now be shown on the priority frame"
L["config_combopoints_off"] = "Maelstrom Weapon combo points will NOT now be shown on the priority frame"
L["config_baricons_on"] = "Icons will now be shown next to each timer bar"
L["config_baricons_off"] = "Icons will NOT now be shown next to each timer bar"
L["config_feralspirit_on"] = "Feral Spirit Bars will now be shown"
L["config_feralspirit_off"] = "Feral Spirit Bars will NOT now be shown"
L["config_TotemTimeLeft"] = "Totem threshold for priority icon display set to : "
L["config_srmana"] = "Shamanistic Rage warning mana percentage set to : "
L["config_wsmana"] = "Recommending Water Shield if mana is below : "
L["config_hwhealth"] = "Max health to recommend Healing Wave set to : "
L["config_chingroup_on"] = "When grouped, priority window will now show Chain Heal instead of Healing Wave."
L["config_chingroup_off"] = "When grouped, priority window will now show Healing Wave instead of Chain Heal."
L["config_shieldorbs"] = "Max number of orbs to recommend shields set to : "
L["config_magmaticks"] = "Magma totem will be recommended to be refreshed in priority list if %s or less ticks remain"
L["config_searingticks"] = "Searing totem will be recommended to be refreshed in priority list if %s or less ticks remain"
L["config_disabled_on"] = "The addon's features are now disabled please use /saa enable if you want to enable them again"
L["config_disabled_off"] = "The addon's features are now enabled please use /saa disable if you want to disable them again"
L["config_magma_on"] = "The fire totem bar will now be displayed"
L["config_magma_off"] = "The fire totem bar will NOT now be displayed"
L["config_GCD_fullwidth_on"] = "The GCD bar will now be shown full width"
L["config_GCD_fullwidth_off"] = "The GCD bar will now be shown in proportional width"
L["config_showinterrupt_on"] = "The Enemy Spell Interrupt frame will now be shown"
L["config_showinterrupt_off"] = "The Enemy Spell Interrupt frame will NOT now be shown"
L["config_showpurge_on"] = "The Enemy Buff Purge frame will now be shown"
L["config_showpurge_off"] = "The Enemy Buff Purge frame will NOT now be shown"
L["config_showcooldown_on"] = "The priority frame will now show a cooldown 'clock'"
L["config_showcooldown_off"] = "The priority frame will NOT now show a cooldown 'clock'"
L["config_hideimmune_on"] = "The priority frame will now NOT display any spell it knows the target is immune to"
L["config_hideimmune_off"] = "The priority frame will now display any spell even if it knows the target is immune to that spell"
L["config_resetImmunity"] = "All target immunities to spells have been cleared"
L["config_ActiveShields_off"] = "The Shield bar will be hidden when the shield is active"
L["config_ActiveShields_on"] = "The Shield bar will be shown when the shield is active"
L["config_specchangewarning_on"] = "You will now be warned when you switch specs if you are not in Enhance spec"
L["config_specchangewarning_off"] = "You will NOT now be warned when you switch specs if you are not in Enhance spec"
L["Cannot enable/disable addon in combat"] = true
L["Cannot change scale in combat"] = true
L["Cannot change bar width in combat"] = true
L["You have changed to a new talent spec do you want to enable SlamAndAwe?"] = true
L["You have changed to a new talent spec do you want to disable SlamAndAwe?"] = true
L["You are in Fury spec, do you want to enable SlamAndAwe?"] = true
L["You are NOT Fury spec, do you want to disable SlamAndAwe?"] = true

-------------------
-- Colours section
-------------------
L["Colossus Smash Bar Colour"] = true
L["Death Wish Bar Colour"] = true
L["Recklessness Bar Colour"] = true

L["Shields"] = true
L["Shocks"] = true
L["Other Bars"] = true
L["Water Shield Colour"] = true
L["Lightning Shield Colour"] = true
L["Earth Shield Colour"] = true
L["Shield Down Colour"] = true
L["Flame Shock Colour"] = true
L["FS Dot Colour"] = true
L["Earth Shock Colour"] = true
L["Frost Shock Colour"] = true
L["Wind Shear Colour"] = true
L["Maelstrom Bar Colour"] = true
L["Stormstrike Bar Colour"] = true
L["Windfury Bar Colour"] = true
L["Lava Lash Bar Colour"] = true
L["Fire Nova Bar Colour"] = true
L["Feral Spirit Bar Colour"] = true
L["Feral Spirit CD Bar Colour"] = true
L["Flurry Colour"] = true
L["Elemental Devastation Colour"] = true
L["Unleashed Rage Colour"] = true
L["Fire Bar Colour"] = true
L["Enrage Colour"] = true

L["Bloodthirst Colour"] = true
L["Raging Blow Colour"] = true
L["Slam Colour"] = true
L["Bloodsurge Colour"] = true
L["Death Wish Colour"] = true
L["Battle Shout Colour"] = true
L["Colossus Smash Colour"] = true

----------------------------------------

L["colBloodthirst"] = "Select which color to display when its on cooldown"
L["colRagingBlow"] = "Select which color to display when its on cooldown"
L["colSlam"] = "Select which color to display when its on cooldown"
L["colBloodsurge"] = "Select which color to display when its on cooldown"
L["colDeathWish"] = "Select which color to displayp"
L["colBattleShout"] = "Select which color to display when its on cooldown"
L["colColossusSmash"] = "Select which color to display"
L["colRecklessness"] = "Select which color to display"

L["colWaterShield"] = "Select which colour you want to use when water shield is active"
L["colLightningShield"] = "Select which colour you want to use when lightning shield is active"
L["colEarthShield"] = "Select which colour you want to use if earth shield is active on you"
L["colNoShield"] = "Select which colour you want to use when no shield is active"
L["colFlameShock"] = "Select which colour to show on shock bar when last shock was Flame Shock"
L["colFlameShockDot"] = "Select which colour to show on the flame shock dot bar"
L["colEarthShock"] = "Select which colour to show on shock bar when last shock was Earth Shock"
L["colFrostShock"] = "Select which colour to show on shock bar when last shock was Frost Shock"
L["colWindShear"] = "Select which colour to show on the Wind Shear bar"
L["colMaelstrom"] = "Select which colour to show on Maelstrom Weapon bar when its on cooldown"
L["colMaelstromAlpha"] = "Select how bright the Maelstrom Weapon bar is when you don't have 5 stacks"
L["colMaelstromFullAlpha"] = "Select how bright the Maelstrom Weapon bar is when you have 5 stacks"
L["colStormstrike"] = "Select which colour to show on Stormstike bar when its on cooldown"
L["colWindfury"] = "Select which colour to show on Windfury bar when its on cooldown"
L["colLavaLash"] = "Select which colour to show on Lava Lash bar when its on cooldown"
L["colFireNova"] = "Select which colour to show on Fire Nova bar when its on cooldown"
L["colFeralSpirit"] = "Select which colour to show on Feral Spirits bar when its on cooldown"
L["colFeralSpiritCD"] = "Select which colour to show on Feral Spirits CD bar when its on cooldown"
L["colFlurry"] = "Select which colour to show on Flurry Uptime bar"
L["colED"] = "Select which colour to show on Elemental Devastation Uptime bar"
L["colUR"] = "Select which colour to show on Unleashed Rage Uptime bar"
L["colEN"] = "Select which colour to show on Enrage Uptime bar"
L["colWFTotals"] = "Select which colour to display the total Windfury damage"
L["colMagma"] = "Select which colour to display on Fire Totem bar when its on cooldown"


-----------------------
-- Warning Options
-----------------------

L["Warning Options"] = true
L["Shield Warning"] = true
L["help_shieldwarning"] = "Activate or deactivate warning when your shield expires"
L["Weapon Inbue Warning"] = true
L["help_weaponwarning"] = "Activate or deactivate warning when your weapon imbue expires or you enter combat without weapons imbued"
L["Main Hand Imbue"] = true
L["Off Hand Imbue"] = true
L["config_shieldwarn_on"] = "Audible warning when shield drops will now be played"
L["config_shieldwarn_off"] = "Audible warning when shield drops will NOT now be played"
L["config_weaponwarn_on"] = "Warning when weapon imbue fades will now be given"
L["config_weaponwarn_off"] = "Warning when weapon imbue fades will NOT now be given"
L["config_rangewarn_on"] = "Warning when you are out of range of target will now be given"
L["config_rangewarn_off"] = "Warning when you are out of range of target will NOT now be given"
L["config_groundingwarn_on"] = "Warning when your grounding totem absorbs a spell will now be given"
L["config_groundingwarn_off"] = "Warning when your grounding totem absorbs a spell will NOT now be given"
L["config_interruptwarn_on"] = "Warning when you interrupt a spell will now be given"
L["config_interruptwarn_off"] = "Warning when you interrupt a spell will NOT now be given"
L["config_purgewarn_on"] = "Warning when you purge a spell will now be given"
L["config_purgewarn_off"] = "Warning when you purge a spell will NOT now be given"
L["Weapon Buff Expired"] = true
L["Missing Weapon Buffs"] = true
L["Expired"] = true
L["Grounded: "] = true
L["Interrupted: "] = true
L["Purged: "] = true
L["Grounding Warning"] = true
L["help_groundingwarning"] = "Enables or disables the warning message when grounding totem absorbs spell"
L["Interrupt Warning"] = true
L["help_interruptwarning"] = "Enables or disables the warning message when you interrupt a spell"
L["Purge Warning"] = true
L["help_purgewarning"] = "Enables or disables the warning message when you purge a spell"
L["Weapon Rebuff time"] = true
L["help_weaponrebuff"] = "Warn if weapon buffs have less than X seconds left"
L["Use Warning Frame"] = true
L["help_warningframe"] = "Display warnings in message frame"
L["config_warnframe_on"] = "Warnings will now be shown in the warning message frame"
L["config_warnframe_off"] = "Warnings will NOT now be shown in the warning message frame"
L["Warning Msg Colour"] = true
L["colWarningMessage"] = "Select which colour to display the warning messages in"
L["Warning Message Duration"] = true
L["%s debuffs remaining"] = true
L["%s orbs remaining"] = true
L["No Shield Active"] = true
L["Warning : No options set"] = true
L["MSBT output area"] = true

------------
-- Uptime
------------

L["uptime_session"] = "Session Uptime"
L["uptime_lastfight"] = "Last Fight Uptime"
L["uptime_reset"] = "Reset uptime frame to default values"
L["Uptime is %s (%s)"] = true
L["Reset Session statistics"] = true

---------------------------
-- WF/SS total damage 
---------------------------

L["MH Windfury"] = true
L["OH Windfury"] = true
L["Single crit"] = true
L["DOUBLE crit"] = true
L["TRIPLE crit"] = true
L["QUADRUPLE crit"] = true
L["miss"] = true

---------------
-- Priorities
---------------

L["Priority Group"] = true
L["Priority Group One"] = true
L["Priority Group Two"] = true
L["Priority Group Three"] = true
L["Priority Group Four"] = true
L["Priority Group Five"] = true
L["MW5 Lightning Bolt"] = true
L["MW5 Chain Lightning"] = true
L["MW5 Healing Wave"] = true
L["MW4 Lightning Bolt"] = true
L["MW4 Chain Lightning"] = true
L["MW4 Healing Wave"] = true
L["MW3 Chain Lightning"] = true
L["MW3 Lightning Bolt"] = true
L["Earth Shock if SS"] = true
L["Stormstrike if no debuff"] = true
L["Lava Lash if no QE"] = true
L["Feral Spirit on Boss"] = true
L["Fire Elemental on Boss"] = true
L["Flame Shock on Boss"] = true
L["Shamanistic Rage on Boss"] = true
L["Magma Totem if expired"] = true
L["Lightning Shield if expired"] = true
L["Priority Bar Scale"] = true
L["None"] = true

L["Priority Frame"] = true
L["First Priority"] = true
L["Second Priority"] = true
L["Third Priority"] = true
L["Fourth Priority"] = true
L["Fifth Priority"] = true
L["Sixth Priority"] = true
L["Seventh Priority"] = true
L["Eighth Priority"] = true
L["Ninth Priority"] = true
L["Tenth Priority"] = true
L["Eleventh Priority"] = true
L["Twelfth Priority"] = true
L["Thirteenth Priority"] = true
L["Fourteenth Priority"] = true
L["Fifteenth Priority"] = true
L["Sixteenth Priority"] = true
L["Next Priority (Set %s)"] = true
L["Priority Set %s selected"] = true
L["priority_reset"] = "Your priority choices have been reverted to the defaults"

--------------
-- Bindings
-------------

L["Keybind Title"] = "SlamAndAwe Keybinds"
L["MH Weapon Rebuff"] = true
L["OH Weapon Rebuff"] = true

-----------
-- News
-----------

L["Website"] = true
L["Command"] = true
L["Config"] = true
L["help_command"] = "Or if you are feeling machocistic - Use /saa for command line configuration"

-----------
-- Export
-----------

L["SlamAndAwe Export to EnhSim\n"] = true
L["export_enhsim"] = "SlamAndAwe Export to EnhSim\nPress Ctrl-C to copy details\n(Yes! I know it looks empty, it isn't)"
L["warn_sim_export"] = "Warning you have buffs that MIGHT effect the Sim accuracy. Cancel them and export again for accurate values."

-----------
-- Options
-----------

L["Frame width set to : "] = true
L["Scale set to : "] = true
L["Priority Scale set to : "] = true
