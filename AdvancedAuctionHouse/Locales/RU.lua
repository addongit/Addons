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
	ADDON_MANAGER_DESCRIPTION = [=[Advanced AuctionHouse изменяет стандартное окно аукционного дома. Он добавляет несколько новых полезных функций, чтобы сделать просмотр и аукционную торговлю проще и удобнее.

Все функциональные возможности непосредственно встроены в окно аукциона, так что Вы не должны делать ничего, лишь открыть аукционный дом, и Вы можете использовать новые функции немедленно.]=],
	AUCTION_EXCHANGE_RATE = "Обменный курс",
	AUCTION_FORUMS_BUTTON = "Форумы",
	AUCTION_FORUMS_BUTTON_TOOLTIP_HEADER = "Веб-ссылка на форумы Advanced AuctionHouse",
	AUCTION_FORUMS_BUTTON_TOOLTIP_TEXT = "Это откроет ваш браузер по умолчанию на форумы Advanced AuctionHouse",
	AUCTION_FRAME_TITLE = "Advanced AuctionHouse версия <VERSION> от Mavoc (RU) - Переведено SilverWF", -- Needs review
	AUCTION_LOADED_MESSAGE = "Аддон загружен: Advanced AuctionHouse версия <VERSION> от Mavoc (RU) - Переведено SilverWF", -- Needs review
	BROWSE_CANCELLING = "Отмена предыдущего поиска",
	BROWSE_CLEAR_BUTTON = "Очистить",
	BROWSE_CLEAR_BUTTON_TOOLTIP_HEADER = "Очистить поиск и фильтры",
	BROWSE_CLEAR_BUTTON_TOOLTIP_TEXT = "Нажмите эту кнопку для сброса всех параметров поиска и фильтрации, примененных к Вашему поиску. Это не сбросит результаты самого поиска.",
	BROWSE_CREATE_FOLDER_POPUP = "Создать папку с именем",
	BROWSE_FILTER = "Фильтры",
	BROWSE_FILTER_OR_TOOLTIP_HEADER = "Свяжите ключевые слова логическим ИЛИ",
	BROWSE_FILTER_OR_TOOLTIP_TEXT = [=[Отметьте, чтобы связать ключевые слова логическим ИЛИ вместо И.
(Фильтр№1 и/или Фильтр№2) и/или Фильтр№3]=],
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_HEADER = "Фильтрация по цене ставок",
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_TEXT = "Отметьте здесь для фильтрации предметов, основанной на цене ставок, вместо цены выкупа.",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_HEADER = "Фильтрация по максимальной цене",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_TEXT = "Введите максимальную цену для фильтрации предметов.",
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_HEADER = "Фильтрация по минимальной цене",
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_TEXT = "Введите минимальную цену для фильтрации предметов.",
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_HEADER = "Фильтрация по цене за единицу",
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_TEXT = "Отметьте здесь для фильтрации предметов, основанной на цене за единицу, вместо общей цены.",
	BROWSE_FILTER_TOOLTIP_HEADER = "Фильтр по ключевому слову №",
	BROWSE_FILTER_TOOLTIP_TEXT1 = [=[Введите ключевое слово здесь, чтобы фильтровать результаты поиска. Чтобы инвертировать фильтр, наберите ! перед ключевым словом. Использование ключевых слов в нескольких полях ввода будет связывать их логическим И по умолчанию.

Следующие специальные фильтры могут быть использованы:]=],
	BROWSE_FILTER_TOOLTIP_TEXT2 = [=[|cffffd200$зеленый|r или |cffffd200$green|r - предметы с зелеными статами
|cffffd200$желтый|r или |cffffd200$yellow|r - предметы с желтыми статами
|cffffd200$оранжевый|r или |cffffd200$orange|r - предметы с оранжевыми статами
|cffffd200$чистая|r или |cffffd200$zero|r - предметы без статов
|cffffd200$один|r или |cffffd200$one|r - предметы с одним статом
|cffffd200$два|r или |cffffd200$two|r - предметы с двумя статами
|cffffd200$три|r или |cffffd200$three|r - предметы с тремя статами
|cffffd200$четыре|r или|cffffd200$four|r - предметы с четырьмя статами
|cffffd200$пять|r или |cffffd200$five|r - предметы с пятью статами
|cffffd200$шесть|r или |cffffd200$six|r - предметы с шестью статами]=],
	BROWSE_FILTER_TOOLTIP_TEXT3 = [=[|cffffd200$прочн|r или |cffffd200$dura|r - предметы с прочностью >= 101
--($dura110 устанавливает минимальную прочность в 110)
|cffffd200$тир|r или |cffffd200$tier|r - предметы с тиром >= 1
--($tier3 устанавливает минимальный тир в 3)
|cffffd200$яйцоуров|r или |cffffd200$egglvl|r - яйца питомцев с уровнем >= 1
--($egglvl30 устанавливает минимальный уровень в 30)
|cffffd200$яйцоскл|r - яйца питомцев со склонностью >= 1
--($eggapt80 устанавливает минимальную склонность в 80)
|cffffd200$вендор|r или |cffffd200$vendor|r - продажа вендору для получения прибыли
--(смотрите curse.com для использования)
|cffffd200$скидка|r или |cffffd200$bargain|r - перепродайте на аукционе для получения прибыли
--(смотрите curse.com для использования)]=], -- Needs review
	BROWSE_HEADER_CUSTOM_TITLE = "Select Auction Data Type:", -- Requires localization
	BROWSE_INFO_LABEL = "Найдено: <MAXITEMS> - Загружено: <SCANPERCENT>% - Совпадений: <FILTEREDITEMS> - Отфильтровано: <FILTERPERCENT>%",
	BROWSE_INFO_LABEL_TOOLTIP_HEADER = "Ход кэширования и фильтрации",
	BROWSE_INFO_LABEL_TOOLTIP_TEXT = [=[Отображает следующую информацию:

- все результаты поиска (максимум 500)
- ход самого поиска
- количество предметов, соответствующих Вашим ключевым словам
- ход процесса фильтрации]=],
	BROWSE_MAX = "Макс.",
	BROWSE_MIN = "Мин.",
	BROWSE_NAME_SEARCH_POPUP = "Назвать Ваш сохраненный поиск",
	BROWSE_NO_RESULTS = "По Вашему поиску ничего не было найдено",
	BROWSE_OR = "или",
	BROWSE_PPU = "За 1",
	BROWSE_RENAME = "Переименовать",
	BROWSE_RENAME_SAVED_SEARCH_POPUP = "Переименовать Ваш сохраненный поиск",
	BROWSE_SAVED_SEARCH_TITLE = "Сохраненные поиски",
	BROWSE_SEARCHING = "Идет поиск ... пожалуйста, подождите.",
	BROWSE_SEARCH_PARAMETERS = "Параметры поиска",
	BROWSE_USABLE = "Пригодные",
	GENERAL_ATTRIBUTES = "Attributes", -- Requires localization
	GENERAL_AVERAGE = "Средняя",
	GENERAL_AVERAGE_PRICE_PER_UNIT = "Средняя цена за единицу:",
	GENERAL_CUSTOM_HEADER_TOOLTIP_HEADER = "Custom Column", -- Requires localization
	GENERAL_CUSTOM_HEADER_TOOLTIP_TEXT = [=[Left-Click: Sort Column
Right-Click: Change Column]=], -- Requires localization
	GENERAL_DECIMAL_POINT = ",",
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
	GENERAL_PRICE_PER_UNIT_HEADER = "Цена за единицу",
	GENERAL_SPEED_HEADER = "Speed", -- Requires localization
	GENERAL_STAM_HEADER = "Stam", -- Requires localization
	GENERAL_STATS = "Stats", -- Requires localization
	GENERAL_STR_HEADER = "Str", -- Requires localization
	GENERAL_TIER_HEADER = "Tier", -- Requires localization
	GENERAL_WIS_HEADER = "Wis", -- Requires localization
	GENERAL_WORTH_HEADER = "Worth", -- Requires localization
	HISTORY_NO_DATA = "Этот предмет не имеет ценовой истории!",
	HISTORY_SUMMARY_AVERAGE = [=[Среднестатистическая цена: <MEDIAN>
Среднеарифметическая цена: <AVERAGE>]=],
	HISTORY_SUMMARY_MINMAX = [=[Минимальная цена: <MINIMUM>
Максимальная цена: <MAXIMUM>]=],
	HISTORY_SUMMARY_NUMHISTORY = "(аукционов: <NUMHISTORY>)",
	LUNA_NEW_VERSION_FOUND = "Доступна новая версия Advanced AuctionHouse от rom.curse.com",
	LUNA_NOT_FOUND = "Для работы этой возможности необходим аддон Luna. Он может быть найден на rom.curse.com.",
	SELL_AUTO_BID_PRICE_TOOLTIP_HEADER = "Режим автозаполнения цены лота",
	SELL_AUTO_BID_PRICE_TOOLTIP_TEXT = [=[Здесь может быть выбран режим для автозаполнения стоимости лота. Режимы:

|cffffd200Нет|r - цена не будет введена

та же цена, по которой |cffffd200последний|r раз этот предмет был продан с аукциона (если имеется)

|cffffd200средняя|r цена, по которой продается этот предмет

определить особую |cffffd200формулу|r автозаполнения]=],
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_HEADER = "Режим автозаполнения цены выкупа",
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_TEXT = [=[Здесь может быть выбран режим для автозаполнения стоимости выкупа. Режимы:

|cffffd200Нет|r - цена не будет введена

та же цена, по которой |cffffd200последний|r раз этот предмет был продан с аукциона (если имеется)

|cffffd200средняя|r цена, по которой продается этот предмет

определить особую |cffffd200формулу|r автозаполнения]=],
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_HEADER = "Особая формула цены",
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_TEXT = [=[Определяет особую формулу, которая будет использоваться для расчета автоматически заполняемой цены. Следующие заполнители могут быть использованы

AVG - Среднеарифметическая цена
MEDIAN - Среднестатистическая цена
MIN - Минимальная цена
MAX - Максимальная цена

Пример: AVG - ((AVG - MIN) / 3)]=],
	SELL_AUTO_PRICE_HEADER = "Настройки автоматической цены",
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_HEADER = "Процент среднего",
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_TEXT = "Автоматическая цена предмета, основанная на истории % от среднего",
	SELL_FORMULA = "Формула",
	SELL_LAST = "Последняя",
	SELL_NONE = "Нет",
	SELL_NUM_AUCTION = "Количество аукционов:",
	SELL_PERCENT = "% от среднего",
	SELL_PER_UNIT = "за единицу",
	SETTINGS_BROWSE = "Browse Settings", -- Requires localization
	SETTINGS_CLEAR_ALL_SUCCESS = "Успешно очищены все данные ценовой истории.",
	SETTINGS_CLEAR_SUCCESS = "Успешно очищена ценовая история для: |cffffffff",
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
	SETTINGS_MISSING_PARAMETER = "Отсутствует параметр для очистки данных истории.",
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
	TOOLS_DAY_ABV = "д",
	TOOLS_GOLD_BASED = "(Основано на <SCANNED> просмотренных аукционах, проданных за золото)",
	TOOLS_HOUR_ABV = "ч",
	TOOLS_ITEM_NOT_FOUND = "Не найдены данные истории для: |cffffffff",
	TOOLS_MIN_ABV = "м",
	TOOLS_NO_HISTORY_DATA = "Нет доступных данных.",
	TOOLS_POWERED_BY = "(используется Advanced AuctionHouse)",
	TOOLS_PRICE_HISTORY = "Ценовая история",
	TOOLS_UNKNOWN_COMMAND = [=[Неизвестная команда. Команды:
|cffffffff/aah numhistory <максимум записей истории, сохраняемых на предмет>|r
|cffffffff/aah clear <предмет>|r
|cffffffff/aah clearall|r
|cffffffff/aah pricehistory|r]=],
}
