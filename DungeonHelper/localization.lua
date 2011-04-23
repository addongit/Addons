
-- CHANGES TO LOCALIZATION SHOULD BE MADE USING http://www.wowace.com/addons/Broker_FindGroup/localization/

local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("DungeonHelper", "enUS", true)

if L then
	L["Remaining"] = true
	
	L["General"] = true
	L["Data Broker"] = true
	L["Play Alert"] = true
	L["Options"] = true
	L["Display Type"] = true

	L["Report Time to Party"] = true
	L["Dungeon completed in"] = true
	L["Completed in"] = true
	L["Hide Minimap Button"] = true

	L["Show Instance Name"] = true
	L["Show Wait Time"] = true
	L["Short Text"] = true
	L["Teleport In/Out"] = true
	L["T"] = true
	L["H"] = true
	L["D"] = true
	L["Waiting for:"] = true
	L["My estimated wait time:"] = true
	L["Wait time as:"] = true
	L["Time"] = true
	L["Tank"] = true
	L["Healer"] = true
	L["DPS"] = true
	L["In Party"] = true
	L["Assembling group..."] = true
	L["Find Group"] = true
	L["Queued for: "] = true
	L["Click to open the dungeon finder."] = true
	L["Ctrl-Click or Middle-Click Teleport."] = true
	L["Right-Click for options."] = true
end

local L = AceLocale:NewLocale("DungeonHelper", "deDE")
if L then 
	L["Assembling group..."] = "Gruppe zusammenstellen..."
L["Click to open the dungeon finder."] = "Klicken, um den Dungeonfinder zu öffnen."
L["Completed in"] = "Abgeschlossen in"
L["Ctrl-Click or Middle-Click Teleport."] = "Strg-Klick oder Mittelklick für Teleport"
L["D"] = "DD"
L["DPS"] = "DD"
L["Data Broker"] = "Data Broker" -- Needs review
L["Display Type"] = "Anzeige Art"
L["Dungeon completed in"] = "Dungeon abgeschlossen in"
L["Find Group"] = "Gruppe finden"
L["General"] = "Allgemein" -- Needs review
L["H"] = "H"
L["Healer"] = "Heiler"
L["Hide Minimap Button"] = "Minimap-Button verstecken"
L["In Party"] = "In Gruppe"
L["My estimated wait time:"] = "Meine geschätzte Wartezeit: "
L["Options"] = "Optionen"
L["Play Alert"] = "Alarm abspielen"
L["Queued for: "] = "Angemeldet für: "
L["Remaining"] = "Verbleibend" -- Needs review
L["Report Time to Party"] = "Berichte Zeit an Gruppe"
L["Right-Click for options."] = "Rechtsklick für Optionen"
L["Short Text"] = "Kurzform"
L["Show Instance Name"] = "Instanznamen anzeigen"
L["Show Wait Time"] = "Wartezeit anzeigen"
L["T"] = "T"
L["Tank"] = "Tank"
L["Teleport In/Out"] = "Rein/Rausporten"
L["Time"] = "Zeit"
L["Wait time as:"] = "Wartezeit als: "
L["Waiting for:"] = "Warte auf: "

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "frFR")
if L then
	L["Assembling group..."] = "Constitution du groupe..."
L["Click to open the dungeon finder."] = "Cliquez pour ouvrir l'outil Donjons."
L["Completed in"] = "Terminé en" -- Needs review
L["D"] = "D"
L["DPS"] = "DPS"
L["Data Broker"] = "Data Broker" -- Needs review
L["Display Type"] = "Type d'affichage" -- Needs review
L["Dungeon completed in"] = "Donjon terminé en" -- Needs review
L["Find Group"] = "Trouver un groupe"
L["General"] = "Général" -- Needs review
L["H"] = "H"
L["Healer"] = "Soigneur"
L["Hide Minimap Button"] = "Cacher l'icône de la minicarte" -- Needs review
L["In Party"] = "En groupe"
L["My estimated wait time:"] = "Mon temps d'attente estimé :"
L["Options"] = "Options" -- Needs review
L["Queued for: "] = "En file pour : "
L["Report Time to Party"] = "Indiquer la durée au groupe" -- Needs review
L["Short Text"] = "Texte court"
L["Show Instance Name"] = "Afficher le nom de l'instance"
L["Show Wait Time"] = "Afficher le temps d'attente"
L["T"] = "T"
L["Tank"] = "Tank"
L["Teleport In/Out"] = "Se téléporter à l'intérieur/à l'extérieur"
L["Time"] = "Temps"
L["Wait time as:"] = "Temps d'attente en tant que :"
L["Waiting for:"] = "En attente depuis :"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "koKR")
if L then
	L["Assembling group..."] = "파티 구성 중..."
L["Click to open the dungeon finder."] = "클릭 던전 찾기 열기"
L["Completed in"] = "완료: "
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl 클릭 또는 마우스 가운데 클릭: 포탈" -- Needs review
L["D"] = "딜"
L["DPS"] = "공격 담당"
L["Display Type"] = "표시 형식"
L["Dungeon completed in"] = "던전 완료: "
L["Find Group"] = "그룹 찾기"
L["H"] = "힐"
L["Healer"] = "치유 담당"
L["Hide Minimap Button"] = "미니맵 버튼 숨김"
L["In Party"] = "파티 중"
L["My estimated wait time:"] = "내 예상 대기 시간"
L["Options"] = "설정"
L["Play Alert"] = "시간 알림"
L["Queued for: "] = "유형:"
L["Report Time to Party"] = "파티에 시간 알림 표시"
L["Right-Click for options."] = "오른쪽 클릭: 설정" -- Needs review
L["Short Text"] = "짧은 문자"
L["Show Instance Name"] = "던전 이름 보기"
L["Show Wait Time"] = "대기 시간 보기"
L["T"] = "탱"
L["Tank"] = "방어 담당"
L["Teleport In/Out"] = "던전 안/밖으로 이동"
L["Time"] = "시간"
L["Wait time as:"] = "역할 별 대기 시간:"
L["Waiting for:"] = "대기 시간:"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "zhTW")
if L then
	L["Assembling group..."] = "組成隊伍..."
L["Click to open the dungeon finder."] = "點擊後開啟地城搜尋器。"
L["Completed in"] = "完成於"
L["Ctrl-Click or Middle-Click Teleport."] = "Ctrl+左鍵或中鍵點擊以傳送" -- Needs review
L["D"] = "輸出"
L["DPS"] = "傷害輸出"
L["Display Type"] = "顯示類型"
L["Dungeon completed in"] = "地城完成於"
L["Find Group"] = "尋找隊伍"
L["H"] = "補"
L["Healer"] = "治療者"
L["Hide Minimap Button"] = "隱藏小地圖按鈕"
L["In Party"] = "在隊伍中"
L["My estimated wait time:"] = "預計我的等待時間:"
L["Options"] = "選項"
L["Play Alert"] = "播放警告"
L["Queued for: "] = "排隊等待:"
L["Report Time to Party"] = "通告時間到隊伍頻道"
L["Right-Click for options."] = "右鍵點擊開啟選項" -- Needs review
L["Short Text"] = "簡短的文字"
L["Show Instance Name"] = "顯示地城名稱"
L["Show Wait Time"] = "顯示等待時間"
L["T"] = "坦"
L["Tank"] = "坦克"
L["Teleport In/Out"] = "傳送進/出"
L["Time"] = "計時"
L["Wait time as:"] = "等待時間為:"
L["Waiting for:"] = "已等待:"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "zhCN")
if L then
	L["Assembling group..."] = "组成队伍..."
L["Click to open the dungeon finder."] = "点击后开启地城搜寻器。"
L["Completed in"] = "完成于"
L["D"] = "输出"
L["DPS"] = "伤害输出"
L["Display Type"] = "显示类型"
L["Dungeon completed in"] = "地城完成于"
L["Find Group"] = "寻找队伍"
L["H"] = "补"
L["Healer"] = "治疗者"
L["Hide Minimap Button"] = "隐藏小地图按钮"
L["In Party"] = "在队伍中"
L["My estimated wait time:"] = "预计我的等待时间:"
L["Options"] = "选项"
L["Play Alert"] = "播放警告"
L["Queued for: "] = "排队等待:"
L["Report Time to Party"] = "通告时间到队伍频道"
L["Short Text"] = "简短的文字"
L["Show Instance Name"] = "显示地城名称"
L["Show Wait Time"] = "显示等待时间"
L["T"] = "坦"
L["Tank"] = "坦克"
L["Teleport In/Out"] = "传送进/出"
L["Time"] = "计时"
L["Wait time as:"] = "等待时间为:"
L["Waiting for:"] = "已等待:"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "ruRU")
if L then
	L["Assembling group..."] = "Формирование группы..."
L["Click to open the dungeon finder."] = "Нажмите, чтобы открыть поиск подземелий"
L["D"] = "Б"
L["DPS"] = "УВС" -- Needs review
L["Find Group"] = "Поиск Группы"
L["H"] = "Л"
L["Healer"] = "Лекарь"
L["Hide Minimap Button"] = "Скрыть кнопку у миникарты"
L["In Party"] = "В Группе"
L["My estimated wait time:"] = "Моё время ожидание:"
L["Queued for: "] = "В очереди:"
L["Short Text"] = "Короткий Текст"
L["Show Instance Name"] = "Показывать Название Подземелья"
L["Show Wait Time"] = "Показывать время ожидания"
L["T"] = "Т"
L["Tank"] = "Танк"
L["Teleport In/Out"] = "Перенестись в/из"
L["Time"] = "Время"
L["Wait time as:"] = "Время ожидания:" -- Needs review
L["Waiting for:"] = "Ожидаем:"

	return
end

local L = AceLocale:NewLocale("DungeonHelper", "esES")
if L then
	
	return
end

local L = AceLocale:NewLocale("DungeonHelper", "esMX")
if L then
	
	return
end