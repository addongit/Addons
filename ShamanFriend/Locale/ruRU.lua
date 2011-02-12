﻿
local L = LibStub("AceLocale-3.0"):NewLocale("ShamanFriend", "ruRU", false);
if not L then return end

-- Options
L["Options for ShamanFriend"] = "Настройки Друга Шамана"

L["Show UI"] = "Показать ПИ"
L["Shows the Graphical User Interface"] = "Показать графический интерфейс пользователя"

L["Show version"] = "Показать версию"

L["Alerts"] = "Тревоги"
L["Settings for Elemental Shields and Weapon Enchants."] = "Настройки для Щитов стихий и Зачарования оружия"
L["Elemental Shield"] = "Щиты стихий"
L["Toggle check for Elemental Shield."] = "Вкл/Выкл проверку Щитов стихий"
L["Toggle Earth Shield tracking on other targets than yourself."] = "Вкл/Выкл проверку Щита Земли на выбранной цели"
L["Weapon Enchant"] = "Зачарование оружия"
L["Toggle check for Weapon Enchants."] = "Вкл/Выкл проверку зачарования оружия"
L["Enter Combat"] = "Бой начинается"
L["Notify when entering combat."] = "Регистрирует начало боя"
L["After Combat"] = "Выход из боя"
L["Notify after the end of combat."] = "Регистрирует выход из боя"
L["No Mounted"] = "Без Ездового животного"
L["No Vehicle"] = "Без Машины"
L["Disable notifications when mounted."] = "Сообщает, что Вы слезли с Ездового животного."
L["Disable notifications when in a vehicle."] = "Сообщает, что Вы вышли из Машины."
L["Sound"] = "Звук"
L["Play a sound when a buff is missing."] = "Воспроизводит звуковой сигнал, когда усиление (buff) рассеилось"
L["Maelstrom Weapon"] = "Оружие Водоворота"
L["Toggle Maelstrom information."] = "Вкл/выкл вывод сообщений о Оружии Водоворота"
L["Lava Surge"] = "Волна лавы"
L["Toggle Lava Surge information."] = "Вкл/выкл вывод сообщений о Волне лавы"
L["Fulmination"] = "Сверкание"
L["Alert when lightning shield hits 9 stacks."] = "Сообщить когда Щита молний собирает 9 зарядов."
L["Play a sound when a proc occurs."] = "Проиграть звук при срабатывании прока."
L["Ding"] = true
L["Dong"] = true
L["Dodo"] = true
L["Bell"] = true
L["None"] = true

L["Display"] = "Экран"
L["Settings for how to display the message."] = "Настройки для экранных сообщений"
L["Color"] = "Цвет"
L["Sets the color of the text when displaying messages."] = "Выберите цвет текста экранных сообщений"
L["Scroll output"] = "Зависающие сообщения"
L["Toggle showing messages in scrolling text. (Settings are in the 'Output Category')"] = "Вкл/Выкл отображений зависающих сообщений. (Параметры настройки находятся в категории 'Прокрутка')."
L["Frames output"] = "Окно сообщений"
L["Toggle whether the message will show up in the frames. (Settings are in the 'General Display' category.)"] = "Вкл/Выкл отображение сообщений в пользовательском окне. (Параметры настройки находятся в разделе 'Главный экран')."
L["Time to display message"] = "Время отображения экранных сообщений"
L["Set the time the message will be displayed (5=default)"] = "Установите время отображения сообщений (5=по умолчанию)"
				
L["Spells"] = "Заклинания"
L["Settings regarding different spells."] = "Настройки для различных заклинаний."
L["Purge"] = "Развеяние магии"
L["Toggle Purge information."] = "Вкл/выкл сообщения для Развеяния магии"
L["Broadcast Purge"] = "Ввода Развеивания магии"
L["Broadcast Purge message to the following chat. (Above option must be enabled)"] = "Выводит сообщения в чат об развеяной магии. (Выберите нужный вариант.)"
L["Raid"] = "Рейд"
L["Party"] = "Группа"
L["Battleground"] = "Поля боя"
L["Raid Warning"] = "Предупреждение рейду"
L["Interrupt"] = "Земной шок"
L["Toggle Interrupt information."] = "Вкл/выкл вывод сообщений для Земного шока"
L["Broadcast Interrupt"] = "Вывода сообщений"
L["Broadcast Interrupt message to the following chat. (Above option must be enabled)"] = "Выводит сообщения в чат об прерванных заклинаниях. (Выберите нужный вариант.)"
L["Grounding Totem"] = "Тотем заземления"
L["Toggle message when Grounding Totem absorbs a spell."] = "Вкл/Выкл вывод сообщений для Тотема заземления."
L["Ground self only"] = "Игнорировать свои заземления"
L["Only show grounding message for your own Grounding Totem"] = "Блокирует вывод сообщений, об заземленной магии, в чат от Вашего Тотема заземления"
L["Broadcast Grounding Totem"] = "Способ вывода сообщений"
L["Broadcast Grounding Totem message to the following chat. (Above option must be enabled)"] = "Выводит сообщения в чат об заземленных заклинаний. (Выберите нужный вариант)."
L["Add target"] = "Добавить цель"
L["Add the target to the end of the message when broadcasting."] = "Добавлять цель в конец сообщения. (В конце сообщения будет добалено имя цели у которой Вы прервали заклинание)."
L["Bloodlust message"] = "Сообщения Кровожадности"
L["Send a message when Bloodlust/Heroism is cast."] = "Вкл/Выкл вывод сообщений для наложенного эффекта Кровожадность/Героизм."
L["Bloodlust text"] = "Текст Кровожадности"
L["The text in the message when Bloodlust/Heroism is cast."] = "Текст сообщения наложенного эффекта Кровожадность/Героизм. (Нажмите Enter для сохранения текста)."
L["Bloodlust chat"] = "Способ вывода сообщений"
L["Chat for the Bloodlust/Heroism message."] = "Чат для сообщений Кровожадности/Героизма. (Выберите нужный вариант.)."
L["Yell"] = "Крик"
L["Say"] = "Сказать"
L["Mana Tide message"] = "Сообщение Прилива маны"
L["Send a message when Mana Tide is cast."] = "Вкл/Выкл вывод сообщений для заклинания Прилив маны."
L["Mana Tide text"] = "Текст Прилива маны"
L["The text in the message when Mana Tide is cast."] = "Текст сообщения для заклинания Прилив маны. (Нажмите Enter для сохранения текста)."
L["Mana Tide chat"] = "Способ вывода сообщений"
L["Chat for the Mana Tide message."] = "Чат для сообщения Прилив маны. (Выберите нужный вариант.)."
L["Feral Spirit message"] = "Сообщение Дух дикого волка"
L["Send a message when Feral Spirit is cast."] = "Вкл/Выкл вывод сообщений для заклинания Дух дикого волка."
L["Feral Spirit text"] = "Текст Дух дикого волка."
L["The text in the message when Feral Spirit is cast."] = "Текст сообщения для заклинания Дух дикого волка. (Нажмите Enter для сохранения текста)."
L["Feral Spirit chat"] = "Способ вывода сообщений"
L["Chat for the Feral Spirit message."] = "Чат для сообщения Дух дикого волка. (Выберите нужный вариант.)."
L["Dispel"] = "Рассеивание"
L["Toggle message when dispel is cast."] = "Вкл/Выкл вывод сообщений при применении Рассеивания"
L["Broadcast Dispel"] = "Вывода Рассеивания"
L["Broadcast dispel message to the following chat. (Above option must be enabled)"] = "Выводит сообщения в чат об применении Рассеивания. (Выберите нужный вариант)."

L["General Display"] = "Главный экран"
L["General Display settings and options for the Custom Message Frame."] = "Главный экран настроек и опций для пользовательского окна сообщений."
L["In Chat"] = "В чат"
L["Display message in Chat Frame."] = "Выводить сообщения в окно чата"
L["Chat number"] = "Номер чата"
L["Choose which chat to display the messages in (0=default)."] = "Выберите в какой чат будут отображатся сообщения (0=по умолчанию)."
L["On Screen"] = "Окно ошибок Blizzard"
L["Display message in Blizzard UI Error Frame."] = "Показывать сообщения в окне ошибок Blizzard UI."
L["Custom Frame"] = "Пользовательское окно"
L["Display message in Custom Message Frame."] = "Показать сообщения в пользовательском окне сообщений."
L["Font Size"] = "Размер шрифта"
L["Set the font size in the Custom Message Frame."] = "Выберите размер шрифта для отображения в пользовательском окне сообщений."
L["Font Face"] = "Шрифт"
L["Set the font face in the Custom Message Frame."] = "Выберите формат шрифта для отображения в пользовательском окне сообщений."
L["Normal"] = "Normal"
L["Arial"] = "Arial"
L["Skurri"] = "Skurri"
L["Morpheus"] = "Morpheus"
L["Font Effect"] = "Эффекты шрифта"
L["Set the font effect in the Custom Message Frame."] = "Выберите графический эффект отображения шрифта в пользовательском окне сообщений."
L["OUTLINE"] = "OUTLINE"
L["THICKOUTLINE"] = "THICKOUTLINE"
L["MONOCHROME"] = "MONOCHROME"
L["Lock"] = "Закрепить"
L["Toggle locking of the Custom Message Frame."] = "Закрепить пользовательское окно сообщений. (Передвигать при зажатой клавише ALT.)"
L["BG Announce"] = "Оповещения на ПБ"
L["Announce when in battlegrounds."] = "Выводить сообщения на поле боя."
L["Arena Announce"] = "Оповещения на арене"
L["Announce when in arena."] = "Выводить сообщения когда вы на арене."
L["5-man Announce"] = "Оповещения группы"
L["Announce when in a 5-man instance."] = "Выводить сообщения когда вы в подземелье из 5-чел."
L["Raid Announce"] = "Оповещения рейда"
L["Announce when in a raid instance."] = "Выводить сообщения когда вы в рейдовом подземелье."
L["World Announce"] = "Оповещения в мире"
L["Announce when not in instances."] = "Выводить сообщения когда вы не в подземелье."

L["Windfury"] = "Ярость ветра"
L["Settings for Windfury counter."] = "Настройки для Ярости ветра."
L["Enable"] = "Включить"
L["Enable WF hit counter."] = "Включить отображение сообщений Ярости ветра."
L["Crit"] = "Крит"
L["Enable display of WF crits."] = "Включить отображение критов Ярости ветра ЯВ"
L["Miss"] = "Промах"
L["Enable display of WF misses."] = "Включить отображение промахов Ярости ветра ЯВ"
L["Hand"] = "Рука"
L["Show which hand the proc comes from"] = "Показыват на какой руке было срабатывание"

L["Lightning Overload"] = "Перезагрузка молнии"
L["Settings for Lightning Overload."] = "Настройки для Перезагрузки молний."
L["Toggle whether to show a message when Lightning Overload procs."] = "Показывать сообщения сработавшей Перезагрузки молний."
L["Use alternative method"] = "Использовать альтернативный метод"
L["Uses an alternative method to detect LO procs. (Works better in raids, but can be delayed, and damage will probably break)"] = "Использовать альтернативный метод обнаружения сработавшей ПМ. (Works better in raids, but can be delayed, and damage will probably break)"
L["Damage"] = "Повреждение"
L["Enable display of Lightning Overload total damage."] = "Позволить отображать суммарное повреждение Перезагрузки молний."
L["Enable display of Lightning Overload misses."] = "Позволить отображать промахи Перезагрузки молний."
L["Enable display of Lightning Overload crits."] = "Позволить отображать криты Перезагрузки молнии."
L["No Lightning Capacitator"] = true
L["Attempt to remove procs coming from the Lightning Capacitator trinket. (Does not always work, and can cause the damage from dual procs to be a bit off)"] = true

L["Earth Shield"] = "Щит земли"
L["Settings for Earth Shield."] = "Настройки Щита Земли"
L["Toggle Earth Shield tracker"] = "Вкл/Выкл отображение панели управления Щитом Земли"
L["Lock tracker"] = "Заблокировать отслеживание"
L["Lock Earth Shield tracker."] = "Заблокировать отслеживание Щита земли"
L["Disable tooltip"] = "Отключить подсказки"
L["Disable Earth Shield tracker tooltip."] = "Отключить подсказки слежения за Щитом земли"
L["Button only"] = "Только кнопка"
L["Show only the Earth Shield button."] = "Отображать только кнопку Щита земли."
L["Alert when fading"] = "Сообщить когда рассеится"
L["Alert me when Earth Shield fades from my target."] = "Предупредить когда Щит земли рассеялся с моей цели"
L["Play a sound when Earth Shield fades from my target."] = "Проиграть звук когда Щит земли рассеялся с моей цели"

L["CC"] = "Сглаз"
L["Settings for Crowd Control."] = "Настройки для Сглаза"
L["Success"] = "Успех"
L["Display when successfully CCing a target."] = "Показывать когда Сглаз прошел успешно"
L["Success text"] = "Сообщение когда Сглаз прошел успешно"
L["TARGET = CC target"] = "Цель Сглаза"
L["The text in the message when CC succeeds."] = "Текст сообщения об успешном Сглазе:"
L["Fail"] = "Неудача"
L["Display when CCing a target fails."] = "Показывать когда Сглаз цели потерпел неудачу"
L["Fail text"] = "Текст сообщения о неудаче"
L["The text in the message when CC fails."] = "Текст сообщения когда Сглаз потерпел неудачу"
L["Remove"] = "Снятие"
L["Display when CC is removed from a target."] = "Показывать когда Сглаз пропадает с цели"
L["Remove text"] = "Текст окончания Сглаза"
L["The text in the message when CC is removed."] = "Текст сообщения когда Сглаз пропадает с цели"
L["Broadcast CC"] = "Анонсировать Сглаз"
L["Broadcast CC message to the following chat. (Above option must be enabled)"] = "Сообщать сообщение о Сглазе в чат. (Выберите нужный вариант)"
L["Broken"] = "Разбивание"
L["Display when CC is broken."] = "Показывать когда Сглаз разбит"
L["Broken text"] = "Текст разбития Сглаза"
L["The text in the message when CC is broken."] = "Текст сообщения о разбивании Сглаза"
L["Broadcast Broken CC"] = "Анонсировать о разбитии Сглаза"
L["Broadcast Broken CC message to the following chat. (Above option must be enabled)"] = "Анонсировать в чат когда Сглаз разбивают. (Выберите нужный вариант)"
L["Tank break time"] = true
L["Do not warn if the tank breaks CC after this time"] = true
L["Play a sound when CC fades from my target."] = "Проигрывать звук когда Сглаз рассеивается с цели"
L["SOURCE = Source of break, TARGET = CC target"] = "Цель разбития Сглаза"
L[" faded from "] = "Сглаз закончился на "
L[" broke SPELL on "] = " разбил SPELL на "

-- L["Totems"] = "Тотемы"
-- L["Settings for Totems."] = "Настройки для тотемов"
-- L["Warn on kill"] = "Предупреждение об уничтожении"
-- L["Shows a message whenether one of your totems are killed."] = "Показывать сообщение, когда один из Ваших тотемов уничтожен."
-- L["Broadcast on kill"] = "Способ вывода сообщений"
-- L["Broadcast to the following chat when one of your totems are killed. (Above option must be enabled)"] = "Выводит сообщения в чат, когда один из ваших тотемов разрушен. (Выберите нужный вариант)."

L["Miscellaneous"] = "Разное"
L["Various other small notices/usefull functions."] = "другие различные уведомления."
L["Elemental T5 2-piece bonus"] = "Комплект Стихии Т5. Бонус от 2х предметов"
L["Show a message when you get the proc from the Elemental Tier5 2-piece bonus"] = "Показывать сообщение срабатывания бонуса от 2х предметов Комплекта Стихии Т5"
L["Enhancement T5 2-piece bonus"] = "Комплект Совершенствование Т5. Бонус от 2х предметов"
L["Show a message when you get the proc from the Enhancement Tier5 2-piece bonus"] = "Показывать сообщение срабатывания бонуса от 2х предметов Комплекта Совершенствования Т5"
L["Restoration T5 4-piece bonus"] = "Комплект Исцеление Т5. Бонус от 4х предметов"
L["Show a message when you get the proc from the Restoration Tier5 4-piece bonus"] = "Показывать сообщение срабатывания бонуса от 4х предметов Комплекта Исцеление Т5"

-- More
L[" faded"] = " рассеялся"
L["Main Hand Enchant faded"] = "Зачарование Правой руки рассеялось"
L["Off Hand Enchant faded"] = "Зачарование Левой руки рассеялось"
L["Weapon Enchant faded"] = "Зачарование оружия рассеялось"
L["Your Earth Shield faded from %s"] = "Ваш Земной Щит рассеится через %s"

L["Interrupted: %s"] = "Прервано: %s"
L["Killed: "] = "Уничтожено: "

-- LO
L["Lightning Overload"] = "Перезагрузка молнии"
L["DOUBLE Lightning Overload"] = " ДВОЙНАЯ Молния Перезагрузка "
L["Lava Burst Overload"] = "Перезагрузка Выброса лавы"
L["Chain Lightning Overload"] = " Цепная молния Перезагрузка"
L["DOUBLE Chain Lightning Overload"] = " ДВОЙНАЯ Цепная молния Перезагрузка "
L["TRIPLE Chain Lightning Overload"] = " ТРОЙНАЯ Цепная молния Перезагрузка "
L[" CRIT"] = " КРИТ"
L[" DOUBLE CRIT"] = " ДВОЙНОЙ КРИТ"
L["Electrical Charge"] = "Электрический заряд"

-- WF
L["Windfury"] = "Ярость ветра"
L["MH Windfury"] = "ЛР  Ярость ветра"
L["OH Windfury"] = "ПР  Ярость ветра"
L[" Single crit: "] = " Одиночный крит: "
L[" DOUBLE crit: "] = " ДВОЙНОЙ крит: "
L[" TRIPLE crit: "] = " ТРОЙНОЙ крит: "
L[" QUADRUPLE crit: "] = " УЧЕТВЕРЕННЫЙ крит: "
L[" QUINTUPLE crit: "] = true
L[" miss"] = " промах"
L[" proc kill"] = " прок убит"

-- Purge
L["Purge: "] = "Развеяно: "
L["Dispel: "] = "Рассеяно: "

-- Grounding Totem
L["Ground: " ] = "Заземлено: "

-- Cooldowns
L["Elemental Mastery"] = "Покорение стихий"
L["Mana Tide Totem"] = "Тотем прилива маны"
L["Bloodlust"] = "Кровожадность"
L["Windfury"] = "Ярость ветра"
L["Nature's Swiftness"] = "Природная стремительность"
L["Reincarnation"] = "Восстание из мертвых"
L["Chain Lightning"] = "Цепная молния"
L["Shocks"] = "Шоки"
L["Fire Elemental Totem"] = "Тотем элементаля огня"
L["Earth Elemental Totem"] = "Тотем элементаля земли"
L["Grounding Totem"] = "Тотем заземления"
L["Eartbind Totem"] = "Тотем оков земли"
L["Stoneclaw Totem"] = "Тотем каменного огня"
L["Fire Nova Totem"] = "Тотем кольца огня"
L["Astral Recall"] = "Астральное возвращение"
L["Healthstone"] = "Камень возвращения"
L["Potions"] = "Potions"
L["Stormstrike"] = "Удар бури"

-- Missing
L["Missing: Elemental Shield"] = "Отсутствует: Щит стихий"
L["Missing: Main Hand Enchant"] = "Отсутствует: Зачарование Правой руки"
L["Missing: Off Hand Enchant"] = "Отсутствует: Зачарование Левой руки"

-- T5 2-piece set bonus
L["Gained set bonus"] = "Получен бонус комплекта"

-- Earth Shield frame
L["Charges: "] = "Заряд(ов): "
L["Target: "] = "Цель: "
L["Time: "] = "Время: "
L["Outside group"] = "Вне группы"
L[" min"] = " мин"
L["Shaman Friend ES Tracker"] = "Панель управления ЩЗ"
L["Earth Shield faded from "] = "Щит земли рассеялся с "
L["Killed: "] = "Уничтожено: "

-- Font Face
L["FRIZQT__.TTF"] = "FRIZQT__.TTF"
L["ARIALN.TTF"] = "ARIALN.TTF"
L["skurri.ttf"] = "skurri.ttf"
L["MORPHEUS.ttf"] = "MORPHEUS.ttf"
