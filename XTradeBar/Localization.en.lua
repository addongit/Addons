-------------------------------------------------------------------------------
-- English localization (Default)
-- By Dr. Doom
-------------------------------------------------------------------------------

-- Bindings
getfenv()["BINDING_NAME_CLICK XTradeBarButtonToggle:LeftButton"] = "Show/hide XTradeBar";

-- As of XTradeBar 1.05 (XBar 1.10) or higher, the specialties must come right before their respective tradeskills
-- Note that the master weaponsmithing skills take precedence over the general skill "weaponsmith" and must appear before

-- Tradeskills
XTradeBarSpells = {
    --[[01]] "#^2259",
	--[[02]] "^28672",--Transmutation Master
	--[[03]] "^28675",--Potion Master
	--[[04]] "^28677",--Elixir Master
	--[[05]] "^2259",--Alchemy
    --[[06]] "#^2018",
	--[[07]] "^2018",--Blacksmithing
    --[[08]] "#^2575",
	--[[09]] "^2656",--Smelting
    --[[10]] "#^7411",
	--[[11]] "^7411",--Enchanting
	--[[12]] "^13262",--Disenchant
    --[[13]] "#^4036",
	--[[14]] "^20219",--Gnomish Engineer
	--[[15]] "^20222",--Goblin Engineer
	--[[16]] "^4036",--Engineering
	--[[17]] "#^45357",
	--[[18]] "^45357",--Inscription
	--[[19]] "^51005",--Milling
    --[[20]] "#^2108",
	--[[21]] "^2108",--Leatherworking
    --[[22]] "#^3908",
	--[[23]] "^3908",--Tailoring
    --[[24]] "#^25229",
	--[[25]] "^25229",--Jewelcrafting
	--[[26]] "^31252",--Prospecting
    --[[27]] "#Secondary",
	--[[28]] "^3273",--First Aid
	--[[29]] "Kochen", -- This is a fix for the deDE locale.  It perceives it as a 'Specialization' and replaces the spell
	--[[30]] "^2550",--Cooking
	--[[31]] "^818",--Basic Campfire
	--[[32]] "^7620",--Fishing
    --[[33]] "#Tracking",
	--[[34]] "@2580",--Find Minerals
	--[[35]] "@2383",--Find Herbs
	--[[36]] "@2481",--Find Treasure
	--[[37]] "@43308",--Find Fish
	--[[38]] "#Archaeology",
	--[[39]] "^78670", -- Archaeology
	--[[40]] "^80451", -- Survey
	--[[41]] "#Special",
	--[[42]] "%^53428",--Runeforging
};

XBAR_HELP_CONTEXT_XTradeBar = XBarHelpGUI.ContextHeader("XTradeBar").."Check a tradeskill to show or uncheck to hide it.  "..
  "Trade skills will automatically show the specialization for your character, if you wish to disable this and show the generic, hide the specialization.";

XBarCore.Localize(XTradeBarSpells);