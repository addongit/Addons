--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/?to=decursive.php )

    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
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
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Russian localization
-------------------------------------------------------------------------------

--[=[
--			YOUR ATTENTION PLEASE
--
--	   !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--	################################################################
--	#  http://wow.curseforge.com/projects/decursive/localization/  #
--	################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

if not DcrLoadedFiles or not DcrLoadedFiles["enUS.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DcrCorrupted = true;
    message("Decursive installation is corrupted!");
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "ruRU");

if not L then
    DcrLoadedFiles["ruRU.lua"] = "2.4.0.2";
    return;
end;

L["ABOLISH_CHECK"] = "Проверять на наличие Устранения яда/болезни перед лечением"
L["ABSENT"] = "Отсутствует (%s)"
L["AFFLICTEDBY"] = "%s заражен"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Количество отображаемых заражений : "
L["ANCHOR"] = "Текстовой указатель"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Показать или скрыть микро-фреймы игроков"
L["BINDING_NAME_DCRPRADD"] = "Добавить цель в список приоритета"
L["BINDING_NAME_DCRPRCLEAR"] = "Очистить список приоритета"
L["BINDING_NAME_DCRPRLIST"] = "Распечатка списка приоритета"
L["BINDING_NAME_DCRPRSHOW"] = "Показать или скрыть список приоритета"
L["BINDING_NAME_DCRSHOW"] = [=[Показать или скрыть главную панель Decursivа
(активный-список | указатель)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Отображать опции панели"
L["BINDING_NAME_DCRSKADD"] = "Добавить цель в список пропусков"
L["BINDING_NAME_DCRSKCLEAR"] = "Очистить список пропусков"
L["BINDING_NAME_DCRSKLIST"] = "Распечатка списка пропусков"
L["BINDING_NAME_DCRSKSHOW"] = "Показать или скрыть список пропусков"
L["BLACK_LENGTH"] = "Секунд в чёрном списке: "
L["BLACKLISTED"] = "В чёрном списке"
L["CHARMED"] = "Очарования"
L["CLASS_HUNTER"] = "Охотник"
L["CLEAR_PRIO"] = "О"
L["CLEAR_SKIP"] = "О"
L["COLORALERT"] = "Установить предупреждающий цвет, когда требуется '%s'."
L["COLORCHRONOS"] = "Хронометры"
L["COLORCHRONOS_DESC"] = "Установить цвет хронометров"
L["COLORSTATUS"] = "Установить цвет для МФИ статуса: '%s'."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Скан и лечение питомцев"
L["CURSE"] = "Проклятие"
L["DEFAULT_MACROKEY"] = "NONE"
L["DISABLEWARNING"] = [=[Decursive отключен!

Чтобы включить его снова, введите |cFFFFAA44/DCR STANDBY|r]=]
L["DISEASE"] = "Болезни"
L["DONOT_BL_PRIO"] = "Не вносить в чёрный список имена из списка приоритетов"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000не удалось на|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "Фокус"
L["FUBARMENU"] = "Меню FuBarа"
L["FUBARMENU_DESC"] = "Настройка иконки FuBarа"
L["GLOR1"] = "В память о Glorfindal'е"
L["GLOR2"] = [=[Decursive посвящён памяти о Бертране, который оставил нас слишком рано.
Его всегда будут помнить.]=]
L["GLOR3"] = [=[В память о Bertrand Sense
1969 - 2007]=]
L["GLOR4"] = [=[Дружба и привязанность могут пустить свои корни где угодно. Те, кто встретился с Glorfindal в World of Warcraft, знали его как человека с великими обязательствами, и харизматического лидера.

В жизни он был таким же, как и в игре: самоотверженным, щедрым, преданным своим друзьям и, прежде всего всего, страстным человеком.

Он оставил нас в возрасте 38 лет, оставив не только игроков в виртуальном мире, но и группу истинных друзей, которые будут тосковать без него всегда.]=]
L["GLOR5"] = "Его всегда будут помнить..."
L["HANDLEHELP"] = "Тащить все микро-фреймы игроков (МФИ)"
L["HIDE_LIVELIST"] = "Скрыть активный список"
L["HIDE_MAIN"] = "Скрыть окно Decursivа"
L["HLP_LEFTCLICK"] = "Левый клик"
L["HLP_LL_ONCLICK_TEXT"] = [=[Щелканье по активному-списку бесполезно после WoW 2.0. Вы должны прочитать файл "Readme.txt", который находится в папке Decursive...
(Для перемещения этого списка переместите панель Decursive, /dcrshow и левый-alt-клик для изменения положения)]=]
L["HLP_MIDDLECLICK"] = "Центральный клик"
L["HLP_NOTHINGTOCURE"] = "В данный момент тут нечего лечить!"
L["HLP_RIGHTCLICK"] = "Правый клик"
L["HLP_USEXBUTTONTOCURE"] = "Используйте \"%s\" для излечения данного заражения!"
L["HLP_WRONGMBUTTON"] = "Неверная кнопка мыши!"
L["IGNORE_STEALTH"] = "Игнорировать невидимых игроков"
L["IS_HERE_MSG"] = "Decursive инициализирован, не забудьте проверить настройки"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r клик: Удалить данного игрока
|cFF33AA33ЛЕВЫЙ|r клик: Повысить данного игрока
|cFF33AA33ПРАВЫЙ|r клик:Понизить данного игрока
|cFF33AA33[SHIFT]ЛЕВЫЙ|r клик: Поместить данного игрока вверх
|cFF33AA33[SHIFT]ПРАВЫЙ|r клик: Поместить данного игрока вниз]=]
L["MACROKEYALREADYMAPPED"] = [=[ПРЕДУПРЕЖДЕНИЕ: Клавиша, назначенная для макроса Decursive [%s] уже назначена на '%s'.
Decursive восстановит предыдущее назначение, если вы назначите другую клавишу для этого макроса.]=]
L["MACROKEYMAPPINGFAILED"] = "Клавиша [%s] не может быть назначена для макроса Decursive!"
L["MACROKEYMAPPINGSUCCESS"] = "Клавиша [%s] успешно назначена для макроса Decursive."
L["MACROKEYNOTMAPPED"] = "Макросу Decursive не назначена клавиша, проверьте настройки макросов!"
L["MAGIC"] = "Магия"
L["MAGICCHARMED"] = "Магическое очарования"
L["MISSINGUNIT"] = "Потеря игрока"
L["NORMAL"] = "Нормальное"
L["NOSPELL"] = "Нет доступных заклинаний"
L["OPT_ABOLISHCHECK_DESC"] = "выберите, отображать ли игроков с активным заклинанием 'Снятие' и излечивать"
L["OPT_ADDDEBUFF"] = "Добавить недуг"
L["OPT_ADDDEBUFF_DESC"] = "Добавить новый недуг в данный список"
L["OPT_ADDDEBUFFFHIST"] = "Добавить недавнее заражение"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Добавить заражение, используя историю"
L["OPT_ADDDEBUFF_USAGE"] = "<Название недуга>"
L["OPT_ADVDISP"] = "Доп. настройки отображения"
L["OPT_ADVDISP_DESC"] = "Позволяет установить прозрачность краёв и центра раздельно, а также установить расстояние между МФИ"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s пораженный %s будет пропущен"
L["OPT_ALWAYSIGNORE"] = "Также игнорировать вне боя"
L["OPT_ALWAYSIGNORE_DESC"] = "Если отмечено, данный недуг будет также игнорироваться, когда вы находитесь вне боя"
L["OPT_AMOUNT_AFFLIC_DESC"] = "Установите максимальное количество отображаемых заражений в активном списке"
L["OPT_ANCHOR_DESC"] = "Отображать указатель пользовательского фрейма ошибок"
L["OPT_AUTOHIDEMFS"] = "Автоскрытие"
L["OPT_AUTOHIDEMFS_DESC"] = "Выберите, когда скрывать МФИ"
L["OPT_BLACKLENTGH_DESC"] = "Установите как долго кто либо будет находиться в чёрном списке"
L["OPT_BORDERTRANSP"] = "Прозрачность краёв"
L["OPT_BORDERTRANSP_DESC"] = "Установка прозрачности краёв"
L["OPT_CENTERTRANSP"] = "Прозрачность центра"
L["OPT_CENTERTRANSP_DESC"] = "Установка прозрачности центра"
L["OPT_CHARMEDCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать очарованных игроков"
L["OPT_CHATFRAME_DESC"] = "Сообщения Decursive будут выводится в стандартное окно чата"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Создать виртуальный тест заражения"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Позволяет вам увидеть, как будет всё это выглядеть, когда будет обнаружено заражение"
L["OPT_CUREPETS_DESC"] = "Питомцы будут отображаться и излечиваться"
L["OPT_CURINGOPTIONS"] = "Настройки лечения"
L["OPT_CURINGOPTIONS_DESC"] = "Установите различные аспекты процесса лечения"
L["OPT_CURINGORDEROPTIONS"] = "Настройки порядка лечения"
L["OPT_CURSECHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать проклятых игроков"
L["OPT_DEBCHECKEDBYDEF"] = "Назначен на стандарт"
L["OPT_DEBUFFENTRY_DESC"] = "Выберите, какой класс будет игнорироваться в бою при поражении данным недугом"
L["OPT_DEBUFFFILTER"] = "Фильтрование недугов"
L["OPT_DEBUFFFILTER_DESC"] = "Выберите недуги для фильтрации по имени и классу, когда вы находитесь в бою"
L["OPT_DISEASECHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать заболевших игроков"
L["OPT_DISPLAYOPTIONS"] = "Настройки отображения"
L["OPT_DONOTBLPRIO_DESC"] = "Приоритетный игрок не может быть в чёрном списке"
L["OPT_GROWDIRECTION"] = "Перевернуть отображение МФИ"
L["OPT_GROWDIRECTION_DESC"] = "МФИ будет отображаться снизу вверх"
L["OPT_HIDELIVELIST_DESC"] = "Если не скрыт, отображает информацию о зараженных игроках"
L["OPT_HIDEMFS_GROUP"] = "Один/В группе"
L["OPT_HIDEMFS_GROUP_DESC"] = "Скрывать МФИ, когда вы не находитесь в рейде"
L["OPT_HIDEMFS_NEVER"] = "Никогда"
L["OPT_HIDEMFS_NEVER_DESC"] = "Никогда не скрывать МФИ автоматически"
L["OPT_HIDEMFS_SOLO"] = "Один"
L["OPT_HIDEMFS_SOLO_DESC"] = "Скрывать МФИ, когда вы не находитесь в группе или в рейде"
L["OPT_IGNORESTEALTHED_DESC"] = "Скрывающиеся игроки будут игнорироваться"
L["OPTION_MENU"] = "Меню настроек Decursive"
L["OPT_LIVELIST"] = "Активный список"
L["OPT_LIVELIST_DESC"] = "Настройки активного списка"
L["OPT_LLALPHA"] = "Прозрачность активного списка"
L["OPT_LLALPHA_DESC"] = "Изменение прозрачности главной панели Decursive и активного списка (Главная панель должна быть включена)"
L["OPT_LLSCALE"] = "Масштаб активного списка"
L["OPT_LLSCALE_DESC"] = "Установка размера главной панели Decursive и активного списка (Главная панель должна быть включена)"
L["OPT_LVONLYINRANGE"] = "Только игроки в пределах досягаемости"
L["OPT_LVONLYINRANGE_DESC"] = "В активном списке будут отображаться только те игроки, которые находятся в радиусе рассеивания"
L["OPT_MACROBIND"] = "Назначить клавишу для макроса"
L["OPT_MACROBIND_DESC"] = [=[Установка клавиши, с помощью которой будет вызываться макрос 'Decursive'.

Выберите клавишу и нажмите 'Enter' для сохранения нового назначения (установив курсор мыши над областью редактирования)]=]
L["OPT_MACROOPTIONS"] = "Настройки макросов"
L["OPT_MACROOPTIONS_DESC"] = "Установка поведения макросов, созданных Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать магически-очарованных игроков"
L["OPT_MAGICCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать пораженных магией игроков"
L["OPT_MAXMFS"] = "Всего игроков"
L["OPT_MAXMFS_DESC"] = "Установить максимальное количество игроков, которые будут отображаться на микро-фреймах"
L["OPT_MESSAGES"] = "Сообщения"
L["OPT_MESSAGES_DESC"] = "Настройки отображения сообщений"
L["OPT_MFALPHA"] = "Прозрачность"
L["OPT_MFALPHA_DESC"] = "Установка прозрачности МФИ, когда игроки не поражены"
L["OPT_MFPERFOPT"] = "Настройки быстродействия"
L["OPT_MFREFRESHRATE"] = "Частота обновления"
L["OPT_MFREFRESHRATE_DESC"] = "Время между каждым запросом (1 or several micro-unit-frames can be refreshed at once)"
L["OPT_MFREFRESHSPEED"] = "Скорость обновления"
L["OPT_MFREFRESHSPEED_DESC"] = "Количество микро-фреймов игроков, обновляемых в однократном прохождении"
L["OPT_MFSCALE"] = "Масштаб микро-фреймов игроков"
L["OPT_MFSCALE_DESC"] = "Установка размера микро-фреймов игроков"
L["OPT_MFSETTINGS"] = "Настройки микро-фреймов игроков"
L["OPT_MFSETTINGS_DESC"] = "Настройка микро-фреймов игроков"
L["OPT_MUFSCOLORS"] = "Цвета"
L["OPT_MUFSCOLORS_DESC"] = "Изменить цвета микро-фреймов игроков."
L["OPT_NOKEYWARN"] = "Известить, если нет клавиши"
L["OPT_NOKEYWARN_DESC"] = "Показать предупреждение, если нет назначенной клавиши."
L["OPT_PLAYSOUND_DESC"] = "Проиграть звук при заражении кого-либо"
L["OPT_POISONCHECK_DESC"] = "Если отмечено, то вы сможете видеть и излечивать отравленных игроков"
L["OPT_PRINT_CUSTOM_DESC"] = "Сообщения Decursive будут выводиться в пользовательское окно чата"
L["OPT_PRINT_ERRORS_DESC"] = "Выводить сообщения об ошибках"
L["OPT_PROFILERESET"] = "Сброс профиля..."
L["OPT_RANDOMORDER_DESC"] = "Игроки будут отображаться и излечиваться в случайном порядке (не рекомендуется)"
L["OPT_READDDEFAULTSD"] = "Повторно добавить стандартный недуг"
L["OPT_READDDEFAULTSD_DESC1"] = [=[Добавить утерянные стандартные недуги Decursive в данный список
Ваши настройки не будут изменены]=]
L["OPT_READDDEFAULTSD_DESC2"] = "Все стандартные недуги Decursive уже существуют в данном списке"
L["OPT_REMOVESKDEBCONF"] = [=[Вы уверены, что хотите удалить
 '%s' 
из списка пропусков?]=]
L["OPT_REMOVETHISDEBUFF"] = "Удалить данный недуг"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Удалить '%s' из списка пропусков"
L["OPT_RESETDEBUFF"] = "Сброс данного недуга"
L["OPT_RESETDTDCRDEFAULT"] = "Сброс '%s' на стандарт Decursive"
L["OPT_RESETOPTIONS"] = "Сброс настроек на стандартные"
L["OPT_RESETOPTIONS_DESC"] = "Сброс текущих настроек профиля на стандартные значения"
L["OPT_RESTPROFILECONF"] = [=[Вы уверены в том, что хотите сбросить настройки профиля
 '(%s) %s' ?]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "Активный список будет заполняться снизу вверх"
L["OPT_SCANLENGTH_DESC"] = "Установите промежуток времени между сканированием"
L["OPT_SHOWBORDER"] = "Показать края по цвету класса"
L["OPT_SHOWBORDER_DESC"] = "Края МФИ будут отображаться в соответствии с предназначенным для класса цветом"
L["OPT_SHOWCHRONO"] = "Показать хронометры"
L["OPT_SHOWCHRONO_DESC"] = "Отображение в секундах количества времени, прошедшего с момента заражения игрока"
L["OPT_SHOWHELP"] = "Вызов справки"
L["OPT_SHOWHELP_DESC"] = "Показывать тултип при наводке курсора мыши на микро-фреймы игроков"
L["OPT_SHOWMFS"] = "Показать микро-фреймы игроков"
L["OPT_SHOWMFS_DESC"] = "Эта опция должна быть отмечена, если вы хотите лечить с помощью кликов"
L["OPT_SHOWMINIMAPICON"] = "Иконка у миникарты"
L["OPT_SHOWMINIMAPICON_DESC"] = "Включить/выключить иконку и миникарты."
L["OPT_SHOWTOOLTIP_DESC"] = "Показывать тултип о заражениях в активном списке и МФИ"
L["OPT_STICKTORIGHT"] = "Выравнять МФИ вправо"
L["OPT_STICKTORIGHT_DESC"] = "МФИ будет расти справа налево, якорь будет перемещён по мере необходимости."
L["OPT_TIECENTERANDBORDER"] = "Объединить прозрачность центра и краёв"
L["OPT_TIECENTERANDBORDER_OPT"] = "Если отмечено, то прозрачность краёв будет соответствовать прозрачности центра"
L["OPT_TIE_LIVELIST_DESC"] = "Отображение активного списка связано с отображением панели \"Decursivа\" "
L["OPT_TIEXYSPACING"] = "Объединить гориз. и вертик. расстояние"
L["OPT_TIEXYSPACING_DESC"] = "Если отмечено, то горизонтальное и вертикальное расстояния между МФИ будут равны"
L["OPT_UNITPERLINES"] = "Игроков в линии"
L["OPT_UNITPERLINES_DESC"] = "Установить максимальное число игроков которые будут отображаться на одной строке микро-фреймах"
L["OPT_USERDEBUFF"] = "Данный недуг не часть стандартных недугов Decursivа"
L["OPT_XSPACING"] = "Расстояние по горизонтали"
L["OPT_XSPACING_DESC"] = "Установка расстояния по горизонтали между МФИ"
L["OPT_YSPACING"] = "Расстояние по вертикали"
L["OPT_YSPACING_DESC"] = "Установка расстояния по вертикали между МФИ"
L["PLAY_SOUND"] = "Проиграть звук, если есть кого лечить"
L["POISON"] = "Яды"
L["POPULATE"] = "зп"
L["POPULATE_LIST"] = "Быстро заполнить список Decursivа"
L["PRINT_CHATFRAME"] = "Выводить сообщения в стандартный чат"
L["PRINT_CUSTOM"] = "Выводить сообщения в окно"
L["PRINT_ERRORS"] = "Выводить сообщения об ошибках"
L["PRIORITY_LIST"] = "Список приоритетов"
L["PRIORITY_SHOW"] = "ПР"
L["RANDOM_ORDER"] = "Лечить в случайном порядке"
L["REVERSE_LIVELIST"] = "Перевернуть отображение активного списка"
L["SCAN_LENGTH"] = "Секунд между активными скан.: "
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Для отображения фреймов Decursive введите /dcrshow"
L["SHOW_TOOLTIP"] = "Показ тултипа по зараженным игрокам"
L["SKIP_LIST_STR"] = "Список пропусков"
L["SKIP_SHOW"] = "П"
L["SPELL_FOUND"] = "Заклинание %s найдено!"
L["STEALTHED"] = "Скрывается"
L["STR_CLOSE"] = "Закрыть"
L["STR_DCR_PRIO"] = "Приоритеты Decursive"
L["STR_DCR_SKIP"] = "Пропуски Decursive"
L["STR_GROUP"] = "Группа "
L["STR_OPTIONS"] = "Настройки Decursive"
L["STR_OTHER"] = "Другое"
L["STR_POP"] = "Список заполнений"
L["STR_QUICK_POP"] = "Быстрое заполнение"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00успешно на|r %s"
L["TARGETUNIT"] = "Цель"
L["TIE_LIVELIST"] = "Привязка обзора активного списка к окну DCR"
L["TOOFAR"] = "Слишком далеко"
L["UNITSTATUS"] = "Состояние: "



DcrLoadedFiles["ruRU.lua"] = "2.4.0.2";
