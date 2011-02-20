--[[
File Author: Erik L. Vonderscheer
File Revision: 3ffe5a9
File Date: 2010-10-19T06:45:37Z
]]--
local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "enUS", true)
if L then
L["AltCL"] = "Enable Alternate Combat Log Filtering"
L["AltCLD"] = "Enable COMBAT_LOG_EVENT_UNFILTERED"
L["AltSound"] = "Alternate Sound"
L["AltSoundD"] = "Play alternate sound on Bloodsurge gain."
L["Alternative Combat Log Filtering"] = true
L["BSD"] = "Instant SLAM! notification"
L["Color"] = true
L["ColorD"] = "Set flash color."
L["Custom Procs"] = true
L["Enable Debugging"] = true
L["Enter spellID or spellName to watch for."] = true
L["Flash"] = true
L["FlashD"] = "Flash Screen on Bloodsurge gain."
L["FlashDur"] = "Flash Duration"
L["FlashDurD"] = "Set the duration of Screen Flash"
L["FlashMod"] = "Flash Pulse"
L["FlashModD"] = "Set the duration of screen flash pulse rate"
L["Icon"] = true
L["IconD"] = "Flash Icon on Bloodsurge gain."
L["IconDur"] = "Icon Duration"
L["IconDurD"] = "Set the duration of Icon Flash"
L["IconMod"] = "Icon Pulse"
L["IconModD"] = "Set the duration of icon flash pulse rate"
L["IconSize"] = "Icon Size"
L["IconSizeD"] = "Set Icon Size to be Flashed."
L["IconTest"] = "Test"
L["IconTestD"] = "Test the Icon for size and location."
L["IconX"] = true
L["IconXD"] = "Icons horizontal location"
L["IconY"] = true
L["IconYD"] = "Icons vertical location"
L["Msg"] = "Message"
L["MsgD"] = "Print message in UI Error Frame on Bloodsurge gain."
L["Options"] = "Notification Options"
L["Play selected sound for all Custom Procs."] = true
L["RegCLEUdesc"] = "Register COMBAT_LOG_EVENT_UNFILTERED"
L["RegUAdesc"] = "Register UNIT_AURA"
L["Sound"] = true
L["Sound on Custom Procs"] = true
L["SoundD"] = "Play sound on Bloodsurge gain."
L["You can enter either spellID or spellName to search for."] = true
L["spellID or spellName"] = true
L["turnOn"] = "Turn On"
L["turnOnD"] = "Enable/Disable AddOn"
L.SID = {
	SID1 = "46916",
}

if GetLocale() == "enUS" then return end
end

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "deDE")
if L then
-- L["AltCL"] = ""
-- L["AltCLD"] = ""
-- L["AltSound"] = ""
-- L["AltSoundD"] = ""
-- L["Alternative Combat Log Filtering"] = ""
-- L["BSD"] = ""
L["Color"] = "Farbe"
-- L["ColorD"] = ""
-- L["Custom Procs"] = ""
-- L["Enable Debugging"] = ""
-- L["Enter spellID or spellName to watch for."] = ""
-- L["Flash"] = ""
-- L["FlashD"] = ""
-- L["FlashDur"] = ""
-- L["FlashDurD"] = ""
-- L["FlashMod"] = ""
-- L["FlashModD"] = ""
L["Icon"] = "Symbol"
-- L["IconD"] = ""
-- L["IconDur"] = ""
-- L["IconDurD"] = ""
-- L["IconMod"] = ""
-- L["IconModD"] = ""
L["IconSize"] = "Symbol Größe"
-- L["IconSizeD"] = ""
L["IconTest"] = "Test"
-- L["IconTestD"] = ""
-- L["IconX"] = ""
-- L["IconXD"] = ""
-- L["IconY"] = ""
-- L["IconYD"] = ""
L["Msg"] = "Nachricht"
-- L["MsgD"] = ""
L["Options"] = "Anzeige Optionen"
-- L["Play selected sound for all Custom Procs."] = ""
-- L["RegCLEUdesc"] = ""
-- L["RegUAdesc"] = ""
L["Sound"] = "Ton"
-- L["Sound on Custom Procs"] = ""
-- L["SoundD"] = ""
-- L["You can enter either spellID or spellName to search for."] = ""
-- L["spellID or spellName"] = ""
L["turnOn"] = "Einschalten"
L["turnOnD"] = "Addon Ein/Abschalten"
L.SID = {
	-- SID1 = "",
}

if GetLocale() == "deDE" then return end
end

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "zhCN")
if L then
L["AltCL"] = "启用交替战斗记录过滤"
L["AltCLD"] = "启用 COMBAT_LOG_EVENT_UNFILTERED"
L["AltSound"] = "交替音效"
L["AltSoundD"] = "当获得血涌效果时播放交替音效"
L["Alternative Combat Log Filtering"] = "交替战斗记录过滤"
L["BSD"] = "瞬发猛击提醒"
L["Color"] = "颜色"
L["ColorD"] = "设置闪烁颜色。"
L["Custom Procs"] = "自定义触发"
-- L["Enable Debugging"] = ""
L["Enter spellID or spellName to watch for."] = "输入要监视的法术ID或法术名称。"
L["Flash"] = "闪烁屏幕"
L["FlashD"] = "获得血涌效果时闪烁屏幕。"
-- L["FlashDur"] = ""
-- L["FlashDurD"] = ""
-- L["FlashMod"] = ""
-- L["FlashModD"] = ""
L["Icon"] = "图标"
L["IconD"] = "获得血涌效果时闪烁血涌图标。"
-- L["IconDur"] = ""
-- L["IconDurD"] = ""
-- L["IconMod"] = ""
-- L["IconModD"] = ""
L["IconSize"] = "图标大小"
L["IconSizeD"] = "设置闪烁的图标大小。"
L["IconTest"] = "测试"
L["IconTestD"] = "测试图标大小和位置。"
L["IconX"] = "图标的水平位置"
L["IconXD"] = "图标的水平位置"
L["IconY"] = "图标的垂直位置"
L["IconYD"] = "图标的垂直位置"
L["Msg"] = "信息"
L["MsgD"] = "获得血涌效果时在UI错误框体显示信息。"
L["Options"] = "选项"
-- L["Play selected sound for all Custom Procs."] = ""
-- L["RegCLEUdesc"] = ""
-- L["RegUAdesc"] = ""
L["Sound"] = "音效"
-- L["Sound on Custom Procs"] = ""
L["SoundD"] = "获得血涌效果时播放音效。"
L["You can enter either spellID or spellName to search for."] = "你可以输入法术ID或法术名称来搜索。"
L["spellID or spellName"] = "法术ID或法术名称"
L["turnOn"] = "开启"
L["turnOnD"] = "启用/禁用插件"
L.SID = {
	-- SID1 = "",
}

if GetLocale() == "zhCN" then return end
end

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "zhTW")
if L then
-- L["AltCL"] = ""
-- L["AltCLD"] = ""
-- L["AltSound"] = ""
-- L["AltSoundD"] = ""
-- L["Alternative Combat Log Filtering"] = ""
L["BSD"] = "瞬發猛擊提醒器"
L["Color"] = "顏色"
L["ColorD"] = "設定閃爍顏色。"
L["Custom Procs"] = "自定義觸發"
-- L["Enable Debugging"] = ""
L["Enter spellID or spellName to watch for."] = "輸入要監視的法術ID或法術名稱。"
L["Flash"] = "閃爍屏幕"
L["FlashD"] = "獲得熱血沸騰效果時閃爍屏幕。"
-- L["FlashDur"] = ""
-- L["FlashDurD"] = ""
-- L["FlashMod"] = ""
-- L["FlashModD"] = ""
L["Icon"] = "圖示"
L["IconD"] = "獲得熱血沸騰效果時閃爍圖示。"
-- L["IconDur"] = ""
-- L["IconDurD"] = ""
-- L["IconMod"] = ""
-- L["IconModD"] = ""
L["IconSize"] = "圖示大小"
L["IconSizeD"] = "設定閃爍的圖示大小。"
L["IconTest"] = "測試"
L["IconTestD"] = "測試圖示的大小和位置。"
L["IconX"] = "圖示的水平位置"
L["IconXD"] = "圖示的水平位置"
L["IconY"] = "圖示的垂直位置"
L["IconYD"] = "圖示的垂直位置"
L["Msg"] = "訊息"
L["MsgD"] = "獲得熱血沸騰效果時在UI錯誤框體顯示訊息。"
L["Options"] = "選項"
-- L["Play selected sound for all Custom Procs."] = ""
-- L["RegCLEUdesc"] = ""
-- L["RegUAdesc"] = ""
L["Sound"] = "音效"
-- L["Sound on Custom Procs"] = ""
L["SoundD"] = "獲得熱血沸騰效果時播放音效。"
L["You can enter either spellID or spellName to search for."] = "你可以輸入法術ID或法術名稱來搜尋。"
L["spellID or spellName"] = "法術ID或法術名稱"
L["turnOn"] = "開啟"
L["turnOnD"] = "啟用/禁用插件"
L.SID = {
	-- SID1 = "",
}

if GetLocale() == "zhTW" then return end
end

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "koKR")
if L then
-- L["AltCL"] = ""
-- L["AltCLD"] = ""
-- L["AltSound"] = ""
-- L["AltSoundD"] = ""
-- L["Alternative Combat Log Filtering"] = ""
-- L["BSD"] = ""
-- L["Color"] = ""
-- L["ColorD"] = ""
-- L["Custom Procs"] = ""
-- L["Enable Debugging"] = ""
-- L["Enter spellID or spellName to watch for."] = ""
-- L["Flash"] = ""
-- L["FlashD"] = ""
-- L["FlashDur"] = ""
-- L["FlashDurD"] = ""
-- L["FlashMod"] = ""
-- L["FlashModD"] = ""
-- L["Icon"] = ""
-- L["IconD"] = ""
-- L["IconDur"] = ""
-- L["IconDurD"] = ""
-- L["IconMod"] = ""
-- L["IconModD"] = ""
-- L["IconSize"] = ""
-- L["IconSizeD"] = ""
-- L["IconTest"] = ""
-- L["IconTestD"] = ""
-- L["IconX"] = ""
-- L["IconXD"] = ""
-- L["IconY"] = ""
-- L["IconYD"] = ""
-- L["Msg"] = ""
-- L["MsgD"] = ""
-- L["Options"] = ""
-- L["Play selected sound for all Custom Procs."] = ""
-- L["RegCLEUdesc"] = ""
-- L["RegUAdesc"] = ""
-- L["Sound"] = ""
-- L["Sound on Custom Procs"] = ""
-- L["SoundD"] = ""
-- L["You can enter either spellID or spellName to search for."] = ""
-- L["spellID or spellName"] = ""
-- L["turnOn"] = ""
-- L["turnOnD"] = ""
L.SID = {
	-- SID1 = "",
}

if GetLocale() == "koKR" then return end
end

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "frFR")
if L then
L["AltCL"] = "Active une alternative au filtre du Journal de Combat"
L["AltCLD"] = "Active COMBAT_LOG_EVENT_UNFILTERED"
L["AltSound"] = "Son alternatif"
L["AltSoundD"] = "Joue un son alternatif lors d'Afflux Sanguin."
L["Alternative Combat Log Filtering"] = "Filtre du Journal de Combat alternatif"
L["BSD"] = "Message instantané de Heurtoir ! "
L["Color"] = "Couleur"
L["ColorD"] = "Définit la couleur du flash."
L["Custom Procs"] = "Procs personnalisés"
-- L["Enable Debugging"] = ""
L["Enter spellID or spellName to watch for."] = "Entrée l'ID ou le Nom du sort à surveiller."
L["Flash"] = true
L["FlashD"] = "Flash l'écran lors d'Afflux Sanguin."
L["FlashDur"] = "Durée du Flash"
L["FlashDurD"] = "Définit la durée du Flash à l'écran"
L["FlashMod"] = "Pulsation du Flash"
L["FlashModD"] = "Définit la durée de pulsation du Flash à l'écran"
L["Icon"] = "Icône"
L["IconD"] = "Affiche une Icône lors d'Afflux Sanguin."
L["IconDur"] = "Durée de l'icône"
L["IconDurD"] = "Définit la durée du Flash de l'Icône"
L["IconMod"] = "Pulsation de l'Icône"
L["IconModD"] = "Définit la durée de pulsation de l'Icône"
L["IconSize"] = "Taille de l'icône"
L["IconSizeD"] = "Définit la taille de l'icône à afficher."
L["IconTest"] = "Test"
L["IconTestD"] = "Test la taille et la position de l'Icône."
L["IconX"] = "IcôneX"
L["IconXD"] = "Position horizontale de l'Icône"
L["IconY"] = "IcôneY"
L["IconYD"] = "Position verticale de l'Icône"
L["Msg"] = "Message"
L["MsgD"] = "Affiche un message dans la fenêtre d'Erreur lors d'Afflux Sanguin."
L["Options"] = "Options de notification"
-- L["Play selected sound for all Custom Procs."] = ""
-- L["RegCLEUdesc"] = ""
-- L["RegUAdesc"] = ""
L["Sound"] = "Son"
-- L["Sound on Custom Procs"] = ""
L["SoundD"] = "Jouer un son lors d'Afflux Sanguin."
L["You can enter either spellID or spellName to search for."] = "Vous pouvez chercher par l'ID ou le Nom du sort."
L["spellID or spellName"] = "ID ou Nom du sort"
L["turnOn"] = "Activer"
L["turnOnD"] = "Active/Désactive cet Add'on"
L.SID = {
	SID1 = "46916",
}

if GetLocale() == "frFR" then return end
end

local L =  LibStub("AceLocale-3.0"):NewLocale("BloodSurge", "ruRU")
if L then
L["AltCL"] = "Включите альтернативный фильтр логов боя"
L["AltCLD"] = "Включить не фильтрованный лог боя"
L["AltSound"] = "Альтернативный звук"
L["AltSoundD"] = "Играть альтернативный звук при получении Bloodsurge"
L["Alternative Combat Log Filtering"] = "Альтернативный фильтр логов боя"
L["BSD"] = "Мгновенный SLAM! Уведомление"
L["Color"] = "Цвет"
L["ColorD"] = "Установить цвет вспышки"
L["Custom Procs"] = "Пользовательские настройки оповещения " -- Needs review
-- L["Enable Debugging"] = ""
L["Enter spellID or spellName to watch for."] = "Введите spellID или spellName что бы следить за ними"
L["Flash"] = "Вспышка"
L["FlashD"] = "Картинка вспышки при получении Bloodsurge" -- Needs review
L["FlashDur"] = "Продолжительность вспышки"
L["FlashDurD"] = "Установить продолжительность вспышек"
L["FlashMod"] = "Мигание вспышки"
L["FlashModD"] = "Установить продолжительность мигание вспышки на экране" -- Needs review
L["Icon"] = "Значек"
L["IconD"] = "Вспыхивающий значек при получении Bloodsurge" -- Needs review
L["IconDur"] = "Продолжительность мигания значка" -- Needs review
L["IconDurD"] = "Установить продолжительность вспышки значка"
L["IconMod"] = "Мигание значка"
L["IconModD"] = "Установить продолжительность мигания значка"
L["IconSize"] = "Размер значка"
L["IconSizeD"] = "Установить размер значка при вспыхивании" -- Needs review
L["IconTest"] = "Тест"
L["IconTestD"] = "Тест расположения и размера значка"
L["IconX"] = "По горизонтали"
L["IconXD"] = "Значек по горизонтали"
L["IconY"] = "По вертикали"
L["IconYD"] = "Значек по вертикали"
L["Msg"] = "Сообщение"
L["MsgD"] = "Сообщение ошибки кадра в пользовательском интерфейсе при получении Bloodsurge" -- Needs review
L["Options"] = "Настройки"
-- L["Play selected sound for all Custom Procs."] = ""
-- L["RegCLEUdesc"] = ""
-- L["RegUAdesc"] = ""
L["Sound"] = "Звук"
-- L["Sound on Custom Procs"] = ""
L["SoundD"] = "Звук при получении Bloodsurge"
L["You can enter either spellID or spellName to search for."] = "Вы также можете ввести spellID или spellName для поиска"
L["spellID or spellName"] = "spellID или spellName"
L["turnOn"] = "Включить"
L["turnOnD"] = "Включение/Выключение аддона"
L.SID = {
	-- SID1 = "",
}

if GetLocale() == "ruRU" then return end
end
