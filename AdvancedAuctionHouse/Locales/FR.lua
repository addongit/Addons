AAHLocale = {}
AAHLocale.Commands = {
	BARGAIN = "$bargain", -- Requires localization
	DURA = "$dura,$durability", -- Requires localization
	EGGAPTITUDE = "$eggapt", -- Requires localization
	EGGLEVEL = "$egglvl", -- Requires localization
	FIVE = "$five,$quintuple", -- Requires localization
	FOUR = "$four,$quadruple", -- Requires localization
	GREEN = "$green", -- Requires localization
	ONE = "$one,$single", -- Requires localization
	ORANGE = "$orange", -- Requires localization
	PLUS = "$plus", -- Requires localization
	SIX = "$six,$sextuple", -- Requires localization
	THREE = "$three,$triple", -- Requires localization
	TIER = "$tier", -- Requires localization
	TWO = "$two,$double", -- Requires localization
	VENDOR = "$vendor", -- Requires localization
	YELLOW = "$yellow", -- Requires localization
	ZERO = "$zero,$clean", -- Requires localization
}
AAHLocale.Messages = {
	ADDON_MANAGER_DESCRIPTION = [=[Advanced AuctionHouse modifie la fenêtre par défaut de la Salle des Ventes. Il ajoute plusieurs nouvelles fonctions utiles afin de faciliter et de rendre plus confortable les recherches et les enchères.

Toutes les fonctions sont directement inclues dans la fenêtre principale des enchères, de cette manière vous n'avez rien à faire si ce n'est d'ouvrir la Salle des Ventes pour les utiliser.]=],
	AUCTION_EXCHANGE_RATE = "Taux de change",
	AUCTION_FORUMS_BUTTON = "Forums AAH",
	AUCTION_FORUMS_BUTTON_TOOLTIP_HEADER = "Lien sur les forums Advanced AuctionHouse",
	AUCTION_FORUMS_BUTTON_TOOLTIP_TEXT = "Ceci va ouvrir votre navigateur par défaut sur les Forums Advanced AuctionHouse",
	AUCTION_FRAME_TITLE = "Advanced AuctionHouse <VERSION> par Mavoc (FR)", -- Needs review
	AUCTION_LOADED_MESSAGE = "Addon chargé: AdvancedAuctionHouse <VERSION> par Mavoc (FR) - Traduction par Ex Tempus", -- Needs review
	BROWSE_CANCELLING = "Annulation de la recherche précédente",
	BROWSE_CLEAR_BUTTON = "Remise à zéro",
	BROWSE_CLEAR_BUTTON_TOOLTIP_HEADER = "Mise à zéro des filtres",
	BROWSE_CLEAR_BUTTON_TOOLTIP_TEXT = "Pressez ce bouton pour mettre à zéro tous les filtres appliqués à votre recherche. Ceci n'effacera pas les résultats de la recherche.",
	BROWSE_CREATE_FOLDER_POPUP = "Créer un dossier",
	BROWSE_FILTER = "Filtre",
	BROWSE_FILTER_OR_TOOLTIP_HEADER = "Lier les mots-clés avec 'OU'",
	BROWSE_FILTER_OR_TOOLTIP_TEXT = [=[Cocher pour appliquer aux mots-clés un 'OU' au lieu d'un 'ET'.
(Filter#1 et/ou Filter#2) et/ou Filter#3]=],
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_HEADER = "Filtre sur le Prix de l'Enchère",
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_TEXT = "Cochez cette option pour filtrer les éléments sur la base du prix de l'enchère au lieu du prix de rachat.",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_HEADER = "Filtre sur une prix maximum",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_TEXT = "Saisissez un prix maximum pour le filtrage des articles.",
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_HEADER = "Filtre sur une prix minimum",
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_TEXT = "Saisissez un prix minimum pour le filtrage des articles.",
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_HEADER = "Filtre sur Prix/Unité",
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_TEXT = "Cochez cette option pour filtrer les éléments sur la base des PPU au lieu du prix total.",
	BROWSE_FILTER_TOOLTIP_HEADER = "Mot-clé #",
	BROWSE_FILTER_TOOLTIP_TEXT1 = [=[Entrez un mot clé ici pour filtrer vos résultats de recherche. Pour inverser le filtre, saisir un ! devant le mot-clé. Utiliser plusieurs champs mots-clés impliquera un ET entre eux par défaut.

Les filtres spéciaux suivantes peuvent être utilisés:]=],
	BROWSE_FILTER_TOOLTIP_TEXT2 = [=[|cffffd200$green|r - items with green stats
|cffffd200$yellow|r - items with yellow stats
|cffffd200$orange|r - items with orange stats
|cffffd200$zero|r - items with zero stats
|cffffd200$one|r - items with one stat
|cffffd200$two|r - items with two stats
|cffffd200$three|r - items with three stats
|cffffd200$four|r - items with four stats
|cffffd200$five|r - items with five stats
|cffffd200$six|r - items with six stats]=], -- Needs review
	BROWSE_FILTER_TOOLTIP_TEXT3 = [=[|cffffd200$dura|r - items with dura >= 101
--($dura110 sets the min dura to 110)
|cffffd200$tier|r - items with tier >= 1
--($tier3 sets the min tier to 3)
|cffffd200$egglvl|r - pet eggs with level >= 1
--($egglvl30 sets the min level to 30)
|cffffd200$eggapt|r - pet eggs with aptitude >= 1
--($eggapt80 sets the min aptitude to 80)
|cffffd200$vendor|r - sell to vendor for profit.
--(see curse.com for usage)
|cffffd200$bargain|r - resell on AH for profit
--(see curse.com for usage)]=], -- Needs review
	BROWSE_HEADER_CUSTOM_TITLE = "Select Auction Data Type:", -- Requires localization
	BROWSE_INFO_LABEL = "Trouvés: <MAXITEMS> - Chargés: <SCANPERCENT>% - Filtrés: <FILTEREDITEMS> - Effectués: <FILTERPERCENT>%",
	BROWSE_INFO_LABEL_TOOLTIP_HEADER = "Filtrage en cours",
	BROWSE_INFO_LABEL_TOOLTIP_TEXT = [=[Affiche les informations suivantes:

- le total des résultats de la recherche (max 500)
- la progression de la recherche
- le nombre d'objets correspondants aux mots-clés
- la progression du filtrage]=],
	BROWSE_MAX = "Max",
	BROWSE_MIN = "Min",
	BROWSE_NAME_SEARCH_POPUP = "Nommer votre recherche enregistrée",
	BROWSE_NO_RESULTS = "Aucun résultat pour votre recherche",
	BROWSE_OR = "ou",
	BROWSE_PPU = "PPU",
	BROWSE_RENAME = "Renommer",
	BROWSE_RENAME_SAVED_SEARCH_POPUP = "Renommer votre recherche enregistrée",
	BROWSE_SAVED_SEARCH_TITLE = "Recherches enregistrées",
	BROWSE_SEARCHING = "Recherche en cours ... veuillez patienter svp.",
	BROWSE_SEARCH_PARAMETERS = "Search Parameters", -- Requires localization
	BROWSE_USABLE = "Utilisable",
	GENERAL_ATTRIBUTES = "Attributes", -- Requires localization
	GENERAL_AVERAGE = "Moyenne",
	GENERAL_AVERAGE_PRICE_PER_UNIT = "Prix moyen par unité:",
	GENERAL_CUSTOM_HEADER_TOOLTIP_HEADER = "Custom Column", -- Requires localization
	GENERAL_CUSTOM_HEADER_TOOLTIP_TEXT = [=[Left-Click: Sort Column
Right-Click: Change Column]=], -- Requires localization
	GENERAL_DECIMAL_POINT = ".", -- Requires localization
	GENERAL_DEX_HEADER = "Dex", -- Requires localization
	GENERAL_DPS_HEADER = "DPS", -- Requires localization
	GENERAL_DURA_HEADER = "Dura", -- Requires localization
	GENERAL_GENERAL = "General", -- Requires localization
	GENERAL_HEAL_HEADER = "Heal", -- Requires localization
	GENERAL_HP_HEADER = "HP", -- Requires localization
	GENERAL_INTEL_HEADER = "Intel", -- Requires localization
	GENERAL_MACC_HEADER = "M Acc", -- Requires localization
	GENERAL_MATT_HEADER = "M Att", -- Requires localization
	GENERAL_MCRIT_HEADER = "M Crit", -- Requires localization
	GENERAL_MDAM_HEADER = "M Dam", -- Requires localization
	GENERAL_MDEF_HEADER = "M Def", -- Requires localization
	GENERAL_MEDIAN_PRICE_PER_UNIT = "Median price per unit:", -- Requires localization
	GENERAL_MP_HEADER = "MP", -- Requires localization
	GENERAL_OTHER = "Other", -- Requires localization
	GENERAL_PACC_HEADER = "P Acc", -- Requires localization
	GENERAL_PARRY_HEADER = "Parry", -- Requires localization
	GENERAL_PATT_HEADER = "P Att", -- Requires localization
	GENERAL_PCRIT_HEADER = "P Crit", -- Requires localization
	GENERAL_PDAM_HEADER = "P Dam", -- Requires localization
	GENERAL_PDEF_HEADER = "P Def", -- Requires localization
	GENERAL_PDOD_HEADER = "Dodge", -- Requires localization
	GENERAL_PLUS_HEADER = "Plus", -- Requires localization
	GENERAL_PRICE_PER_UNIT_HEADER = "Prix/Unité",
	GENERAL_SPEED_HEADER = "Speed", -- Requires localization
	GENERAL_STAM_HEADER = "Stam", -- Requires localization
	GENERAL_STATS = "Stats", -- Requires localization
	GENERAL_STR_HEADER = "Str", -- Requires localization
	GENERAL_TIER_HEADER = "Tier", -- Requires localization
	GENERAL_WIS_HEADER = "Wis", -- Requires localization
	GENERAL_WORTH_HEADER = "Worth", -- Requires localization
	HISTORY_NO_DATA = "Cet objet n'a pas d'historique de prix !",
	HISTORY_SUMMARY_AVERAGE = "Median Price: <MEDIAN> Average Price: <AVERAGE>",
	HISTORY_SUMMARY_MINMAX = [=[Prix Min: <MINIMUM>
Prix Max: <MAXIMUM>]=],
	HISTORY_SUMMARY_NUMHISTORY = "(<NUMHISTORY> enchères)",
	LUNA_NEW_VERSION_FOUND = "Une version plus récente d'Advanced AuctionHouse est disponible sur rom.curse.com",
	LUNA_NOT_FOUND = "Lune est nécessaire pour cette fonctionnalité. Luna est téléchargeable sur curse.",
	SELL_AUTO_BID_PRICE_TOOLTIP_HEADER = "Mode automatique du Prix d'enchère",
	SELL_AUTO_BID_PRICE_TOOLTIP_TEXT = [=[Le mode automatique du prix d'enchère peut être sélectionné ici. Les modes sont:

|cffffd200Aucun|r: aucun prix ne sera entré

|cffffd200Dernier|r: même prix que la dernière fois que cet objet a été mis aux enchères (si existant)

|cffffd200Moyenne|r: prix moyen auquel cet objet se vend

|cffffd200Formule|r: défini une formule perso de prix auto]=],
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_HEADER = "Mode Prix de rachat automatique",
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_TEXT = [=[Le mode automatique du prix de rachat peut être sélectionné ici. Les modes sont:

|cffffd200Aucun|r: aucun prix ne sera entré

|cffffd200Dernier|r: même prix que la dernière fois que cet objet a été mis aux enchères (si existant)

|cffffd200Moyenne|r: prix moyen auquel cet objet se vend

|cffffd200Formule|r: défini une formule perso de prix auto]=],
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_HEADER = "Formule de prix personnalisée",
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_TEXT = [=[Définissez une formule qui sera utilisée pour calculer le prix auto. Les symboles suivants peuvent être utilisés

AVG - Prix moyen
MEDIAN - Prix médian
MAX - Prix maximum
MIN - Prix minimum

Exemple: AVG+((MIN)/3) * 1.2]=],
	SELL_AUTO_PRICE_HEADER = "Paramètres de prix auto",
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_HEADER = "Réduction sur le prix", -- Needs review
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_TEXT = "Définissez un pourcentage qui sera déduit de la valeur de prix auto sélectionnée.",
	SELL_FORMULA = "Formule",
	SELL_LAST = "Dernier",
	SELL_NONE = "Aucun",
	SELL_NUM_AUCTION = "Nombre d'enchères:",
	SELL_PERCENT = "% moins cher", -- Needs review
	SELL_PER_UNIT = "par unité",
	SETTINGS_BROWSE = "Browse Settings", -- Requires localization
	SETTINGS_CLEAR_ALL_SUCCESS = "Tout l'historique de prix a été effacé avec succès.",
	SETTINGS_CLEAR_SUCCESS = "Historique du prix effacé avec succès pour: |cffffffff",
	SETTINGS_FILTER_SPEED = "Filter Speed", -- Requires localization
	SETTINGS_FILTER_SPEED_HEADER = "Filter Speed", -- Requires localization
	SETTINGS_FILTER_SPEED_TEXT = [=[This sets the amount of items to filter per update. The higher the setting the faster the speed but the higher the lag caused from filtering.
Supports mouse-wheel]=], -- Requires localization
	SETTINGS_GENERAL = "General Settings", -- Requires localization
	SETTINGS_HISTORY = "History Settings", -- Requires localization
	SETTINGS_MAX_SAVED_HISTORY = "Max Saved History", -- Requires localization
	SETTINGS_MAX_SAVED_HISTORY_HEADER = "Max Saved History", -- Requires localization
	SETTINGS_MAX_SAVED_HISTORY_TEXT = [=[Set the max amount of saved history per item.
Supports mouse-wheel]=], -- Requires localization
	SETTINGS_MISSING_PARAMETER = "Paramètre manquant pour effacer les données d'historique.",
	SETTINGS_PRICE_HISTORY_TOOLTIP = "Always Show Price History Tooltip", -- Requires localization
	SETTINGS_PRICE_HISTORY_TOOLTIP_HEADER = "Show Price History Tooltip", -- Requires localization
	SETTINGS_PRICE_HISTORY_TOOLTIP_TEXT = [=[Checked: Display Tooltip by Default. Hold ALT to hide
Unchecked: Only Display Tooltip if ALT is held down]=], -- Requires localization
	SETTINGS_PRICE_PER_UNIT_PER_WHITE = "Price/Unit/White For Materials", -- Requires localization
	SETTINGS_PRICE_PER_UNIT_PER_WHITE_HEADER = "Price/Unit/White", -- Requires localization
	SETTINGS_PRICE_PER_UNIT_PER_WHITE_TEXT = [=[Enabling this will cause all Materials to used Price Per Unit Per White Material. This will allow you to more easily compare prices of Materials at different levels of refinement. This will apply to all areas that use Price/Unit including selling prices.
Green = 2x White Mats
Blue = 12x White Mats
Purple = 72x White Mats
Example
100x |cff0072bc[Zinc Ingot]|r at 120,000 for the stack
Price/Unit = 1,200
Price/Unit/White = 100]=], -- Requires localization
	TOOLS_DAY_ABV = "j",
	TOOLS_GOLD_BASED = "(Basé sur <SCANNED> enchères scannées vendues pour de l'or)",
	TOOLS_HOUR_ABV = "h",
	TOOLS_ITEM_NOT_FOUND = "Pas d'historique de prix trouvé pour: |cffffffff",
	TOOLS_MIN_ABV = "m",
	TOOLS_NO_HISTORY_DATA = "Aucune information disponible.",
	TOOLS_POWERED_BY = "(powered by Advanced AuctionHouse)",
	TOOLS_PRICE_HISTORY = "Historique de Prix",
	TOOLS_UNKNOWN_COMMAND = [=[Commande inconnue.Les commandes sont:
|cffffffff/aah numhistory <max history entries to save per item>|r
|cffffffff/aah clear <item>|r
|cffffffff/aah clearall|r
|cffffffff/aah pricehistory|r]=],
}
