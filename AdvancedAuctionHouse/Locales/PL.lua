AAHLocale = {}
AAHLocale.Commands = {
	BARGAIN = "$bargain", -- Needs review
	DURA = "$dura,$durability,$wytrzymałość", -- Needs review
	EGGAPTITUDE = "$eggapt,$uzdolnienia", -- Needs review
	EGGLEVEL = "$egglvl,$poziom", -- Needs review
	FIVE = "$five,$pięć", -- Needs review
	FOUR = "$four,$cztery", -- Needs review
	GREEN = "$green,$zielony", -- Needs review
	ONE = "$one,$jeden", -- Needs review
	ORANGE = "$orange,$pomarańczowy", -- Needs review
	PLUS = "$plus", -- Needs review
	SIX = "$six,$sześć", -- Needs review
	THREE = "$three,$trzy", -- Needs review
	TIER = "$tier", -- Needs review
	TWO = "$two,$dwa", -- Needs review
	VENDOR = "$vendor", -- Needs review
	YELLOW = "$yellow,$żółty", -- Needs review
	ZERO = "$zero", -- Needs review
}
AAHLocale.Messages = {
	ADDON_MANAGER_DESCRIPTION = [=[Advanced AuctionHouse alters the default auctionhouse frame. It adds several useful new functions to make browsing and auctioning easier and more comfortable.

All functionality is directly built into the auctionframe so you don't have to do anything but open the auctionhouse and you can use the new functions right away.]=],
	AUCTION_EXCHANGE_RATE = "Ratio wymiany",
	AUCTION_FORUMS_BUTTON = "Forum AAH",
	AUCTION_FORUMS_BUTTON_TOOLTIP_HEADER = "Advanced AuctionHouse Forums Weblink", -- Requires localization
	AUCTION_FORUMS_BUTTON_TOOLTIP_TEXT = "To otworzy forum AAH w  wyszukiwarce",
	AUCTION_FRAME_TITLE = "Advanced AuctionHouse <VERSION> by Mavoc (PL) - Translated by Quinte", -- Needs review
	AUCTION_LOADED_MESSAGE = "Addon loaded: Advanced AuctionHouse <VERSION> by Mavoc (PL) - Translated by Quinte", -- Needs review
	BROWSE_CANCELLING = "Anuluj poprzednie wyszukiwanie",
	BROWSE_CLEAR_BUTTON = "Wyczyść",
	BROWSE_CLEAR_BUTTON_TOOLTIP_HEADER = "Wyczyść wyniki wyszukiwania i filtry",
	BROWSE_CLEAR_BUTTON_TOOLTIP_TEXT = "Naciśnij przycisk aby zresetować hasło wyszukiwania oraz filtry. Nie zresetuje to wyszukanych wyników.",
	BROWSE_CREATE_FOLDER_POPUP = "Stwórz folder",
	BROWSE_FILTER = "Filtry",
	BROWSE_FILTER_OR_TOOLTIP_HEADER = "Sprawdzaj słowa kluczowe z ALBO",
	BROWSE_FILTER_OR_TOOLTIP_TEXT = "Zaznacz to aby sprawdzać słowa kluczowe z ALBO zamiast I (Filtr#1 i/albo Filtr#2) i/albo Filtr#3",
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_HEADER = "Bid Price Filtering", -- Requires localization
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_TEXT = "Zaznacz to albo filtrować przedmioty na podstawie ceny aukcji zamiast ceny zakupu.",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_HEADER = "Maximum Price Filtering", -- Requires localization
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_TEXT = "Enter a maximum price for filtering items.", -- Requires localization
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_HEADER = "Minimum Price Filtering", -- Requires localization
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_TEXT = "Enter a minimum price for filtering items.", -- Requires localization
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_HEADER = "Price/Unit Filtering", -- Requires localization
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_TEXT = "Check this to filter items based on the PPU instead of the total price.", -- Requires localization
	BROWSE_FILTER_TOOLTIP_HEADER = "Słowo kluczowe #",
	BROWSE_FILTER_TOOLTIP_TEXT1 = [=[

The following special filters can be used:]=],
	BROWSE_FILTER_TOOLTIP_TEXT2 = [=[|cffffd200$green|r - items with green stats
|cffffd200$yellow|r - items with yellow stats
|cffffd200$orange|r - items with orange stats
|cffffd200$zero|r - items with zero stats
|cffffd200$one|r - items with one stat
|cffffd200$two|r - items with two stats
|cffffd200$three|r - items with three stats
|cffffd200$four|r - items with four stats
|cffffd200$five|r - items with five stats
|cffffd200$six|r - items with six stats]=], -- Requires localization
	BROWSE_FILTER_TOOLTIP_TEXT3 = [=[|cffffd200$dura|r - items with dura >= 101
--($dura/110 sets the min dura to 110)
|cffffd200$tier|r - items with tier >= 1
--($tier/3 sets the min tier to 3)
|cffffd200$plus|r - items with a plus >= 1
--($plus/6 sets the min plus to 6)
|cffffd200$egglvl|r - pet eggs with level >= 1
--($egglvl/30 sets the min level to 30)
|cffffd200$eggapt|r - pet eggs with aptitude >= 1
--($eggapt/80 sets the min aptitude to 80)
|cffffd200$vendor|r - sell to vendor for profit.
--(see curse.com for usage)
|cffffd200$bargain|r - resell on AH for profit
--(see curse.com for usage)]=], -- Requires localization
	BROWSE_HEADER_CUSTOM_TITLE = "Select Auction Data Type:", -- Requires localization
	BROWSE_INFO_LABEL = "Znaleziono: <MAXITEMS> - Wczytano: <SCANPERCENT>% -Pasuje: <FILTEREDITEMS> - Sprawdzone: <FILTERPERCENT>%",
	BROWSE_INFO_LABEL_TOOLTIP_HEADER = "Buforowanie i filtrowanie",
	BROWSE_INFO_LABEL_TOOLTIP_TEXT = [=[Wyświetla takie informacje:

- ilość znalezionych rezultatów (max 500)
- postęp wyszukiwania
- ilość przedmiotów pasujących do filtrów
- postęp filtrowania]=],
	BROWSE_MAX = "Max",
	BROWSE_MIN = "Min",
	BROWSE_NAME_SEARCH_POPUP = "Nazwij twoje zapisane wyszukanie",
	BROWSE_NO_RESULTS = "Nie znaleziono żadnych wyników",
	BROWSE_OR = "albo",
	BROWSE_PPU = "PPU", -- Requires localization
	BROWSE_RENAME = "Zmień nazwę",
	BROWSE_RENAME_SAVED_SEARCH_POPUP = "Zmień nazwe zapisanego wyszukania",
	BROWSE_SAVED_SEARCH_TITLE = "Zapisane wyszukania",
	BROWSE_SEARCHING = "Wyszukiwanie trwa... proszę czekać.",
	BROWSE_SEARCH_PARAMETERS = "Parametry wyszukania",
	BROWSE_USABLE = "Do użytku",
	GENERAL_ATTRIBUTES = "Attributes", -- Requires localization
	GENERAL_AVERAGE = "Średnia",
	GENERAL_AVERAGE_PRICE_PER_UNIT = "Średnia cena za sztukę",
	GENERAL_CUSTOM_HEADER_TOOLTIP_HEADER = "Ustawienia kolumny",
	GENERAL_CUSTOM_HEADER_TOOLTIP_TEXT = [=[Left-Click: Posortuj kolumne
Right-Click: Zmień kolumne]=],
	GENERAL_DECIMAL_POINT = ".",
	GENERAL_DEX_HEADER = "Zrę", -- Needs review
	GENERAL_DPS_HEADER = "DPS", -- Needs review
	GENERAL_DURA_HEADER = "Wyt", -- Needs review
	GENERAL_GENERAL = "General", -- Requires localization
	GENERAL_HEAL_HEADER = "Lecz", -- Needs review
	GENERAL_HP_HEADER = "HP", -- Needs review
	GENERAL_INTEL_HEADER = "Int", -- Needs review
	GENERAL_MACC_HEADER = "M Acc", -- Needs review
	GENERAL_MATT_HEADER = "M Att", -- Needs review
	GENERAL_MCRIT_HEADER = "M Crit", -- Needs review
	GENERAL_MDAM_HEADER = "M Dam", -- Needs review
	GENERAL_MDEF_HEADER = "M Def", -- Needs review
	GENERAL_MEDIAN_PRICE_PER_UNIT = "Cena mediana za sztukę",
	GENERAL_MP_HEADER = "MP", -- Needs review
	GENERAL_OTHER = "Other", -- Requires localization
	GENERAL_PACC_HEADER = "P Acc", -- Needs review
	GENERAL_PARRY_HEADER = "Blok", -- Needs review
	GENERAL_PATT_HEADER = "P Att", -- Needs review
	GENERAL_PCRIT_HEADER = "P Crit", -- Needs review
	GENERAL_PDAM_HEADER = "P Dam", -- Needs review
	GENERAL_PDEF_HEADER = "P Def", -- Needs review
	GENERAL_PDOD_HEADER = "Unik", -- Needs review
	GENERAL_PLUS_HEADER = "Plus", -- Needs review
	GENERAL_PRICE_PER_UNIT_HEADER = "Cena za sztukę",
	GENERAL_SPEED_HEADER = "Speed", -- Requires localization
	GENERAL_STAM_HEADER = "Wyt", -- Needs review
	GENERAL_STATS = "Stats", -- Requires localization
	GENERAL_STR_HEADER = "Sił", -- Needs review
	GENERAL_TIER_HEADER = "Tier", -- Needs review
	GENERAL_WIS_HEADER = "Mąd", -- Needs review
	GENERAL_WORTH_HEADER = "Wartość", -- Needs review
	HISTORY_NO_DATA = "Ten przedmiot nie ma żadnej historii ceny.",
	HISTORY_SUMMARY_AVERAGE = "Median Price: <MEDIAN>  Average Price: <AVERAGE>",
	HISTORY_SUMMARY_MINMAX = [=[Min Cena: <MINIMUM>
Max Cena: <MAXIMUM>]=],
	HISTORY_SUMMARY_NUMHISTORY = "(<NUMHISTORY> aukcji)",
	LUNA_NEW_VERSION_FOUND = "Nowsza wersja Advanced AuctionHouse jest dostępna na fom.curse.com",
	LUNA_NOT_FOUND = "Luna jest wymagana do działania. Luna może być znaleziona na curse.",
	SELL_AUTO_BID_PRICE_TOOLTIP_HEADER = "Autofill Bidprice Mode", -- Requires localization
	SELL_AUTO_BID_PRICE_TOOLTIP_TEXT = [=[The mode for autofill of the bid-value can be selected here. Modes are:

|cffffd200None|r no price will be entered

same price as |cffffd200last|r time this item was auctioned (if present)

|cffffd200average|r price this item sells for

define a custom autofill |cffffd200formula|r]=], -- Requires localization
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_HEADER = "Autofill Buyoutprice Mode", -- Requires localization
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_TEXT = [=[The mode for autofill of the buyout-value can be selected here. Modes are:

|cffffd200None|r no price will be entered

same price as |cffffd200last|r time this item was auctioned (if present)

|cffffd200average|r price this item sells for

define a custom autofill |cffffd200formula|r]=], -- Requires localization
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_HEADER = "Custom Price Formula", -- Requires localization
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_TEXT = [=[Define a custom formula that will be used to calculate the autofill price. The following placeholders can be used

AVG - Average price
MEDIAN - Median price
MIN - Minimum price
MAX - Maximum price

Example: AVG - ((AVG - MIN) / 3)]=], -- Requires localization
	SELL_AUTO_PRICE_HEADER = "Auto price settings", -- Requires localization
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_HEADER = "Percent Of Average", -- Requires localization
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_TEXT = "Cena ustalona na podstawie % średniej ceny z historii",
	SELL_FORMULA = "Wzór",
	SELL_LAST = "Ostatnia",
	SELL_NONE = "Żadne",
	SELL_NUM_AUCTION = "Ilość aukcji",
	SELL_PERCENT = "% of average", -- Requires localization
	SELL_PER_UNIT = "za sztukę",
	SETTINGS_BROWSE = "Ustawienia wyszukiwania",
	SETTINGS_CLEAR_ALL_SUCCESS = "Wyczyszczona cała historia cen",
	SETTINGS_CLEAR_SUCCESS = "Wyczyszczona historia ceny dla: |cffffffff",
	SETTINGS_FILTER_SPEED = "Prędkość filtra",
	SETTINGS_FILTER_SPEED_HEADER = "Prędkość filtra",
	SETTINGS_FILTER_SPEED_TEXT = "To ustawia ilość przedmiotów filtrowanych w czasie 1 update. Im większy ustawiony tym szybciej filtruje ale wyższe ustawienie może powodować lagi. Można używać scrolla.",
	SETTINGS_GENERAL = "Ustawienia",
	SETTINGS_HISTORY = "Ustawienia historii",
	SETTINGS_MAX_SAVED_HISTORY = "Max Saved History", -- Requires localization
	SETTINGS_MAX_SAVED_HISTORY_HEADER = "Max Saved History", -- Requires localization
	SETTINGS_MAX_SAVED_HISTORY_TEXT = [=[Set the max amount of saved history per item.
Supports mouse-wheel]=], -- Requires localization
	SETTINGS_MISSING_PARAMETER = "Brakuje parametru do wyczyszczenia historii,",
	SETTINGS_PRICE_HISTORY_TOOLTIP = "Zawsze pokazuj historie ceny",
	SETTINGS_PRICE_HISTORY_TOOLTIP_HEADER = "Pokaż historie ceny",
	SETTINGS_PRICE_HISTORY_TOOLTIP_TEXT = [=[Zaznaczone: Wyświetlaj chmurkę cały czas. Przytrzymaj ALT aby schować.
Odznaczone: Wyświetlaj chmurkę tylko gdy ALT jest wciśnięty]=],
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
	TOOLS_DAY_ABV = "d",
	TOOLS_GOLD_BASED = "(Na podstawie <SCANNED> aukcji sprzedanych za złoto)",
	TOOLS_HOUR_ABV = "h",
	TOOLS_ITEM_NOT_FOUND = "Nie znaleziono historii dla: |cffffffff",
	TOOLS_MIN_ABV = "m",
	TOOLS_NO_HISTORY_DATA = "Brak danych.",
	TOOLS_POWERED_BY = "(powered by Advanced AuctionHouse)",
	TOOLS_PRICE_HISTORY = "Historia ceny",
	TOOLS_UNKNOWN_COMMAND = [=[Unknown command. Commands are: 
|cffffffff/aah numhistory <max history entries to save per item>|r
|cffffffff/aah clear <item>|r
|cffffffff/aah clearall|r
|cffffffff/aah pricehistory|r]=], -- Requires localization
}
