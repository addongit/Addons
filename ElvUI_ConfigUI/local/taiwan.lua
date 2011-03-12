﻿if GetLocale() == "zhTW" then
	-- general
	ElvuiL.option_general = "一般"
	ElvuiL.option_general_uiscale = "自動調整UI比例"
	ElvuiL.option_general_multisample = "多重採樣保護"
	ElvuiL.option_general_customuiscale = " UI比例 (當自動調整關閉時)"
	ElvuiL.option_general_embedright = "將插件綁定於右邊對話框架(Recount, Omen, Skada)"
	ElvuiL.option_general_classtheme = "框架邊緣使用職業顏色"
	ElvuiL.option_general_autocustomlagtolerance = "自動更新自訂延遲容許值"
	ElvuiL.option_general_fontscale = "主文字大小"
	
	--Media
	ElvuiL.option_media = "材質&音效"
	ElvuiL.option_media_font = "主要字型檔案路徑"
	ElvuiL.option_media_uffont = "框架字型路徑"
	ElvuiL.option_media_dmgfont = "傷害字型路徑 (需要重新啟動WOW)"
	ElvuiL.option_media_normTex = "單位框架血量、能量材質路徑"
	ElvuiL.option_media_glowTex = "高亮材質顏色"
	ElvuiL.option_media_bubbleTex = "連擊點材質路徑(血條)"
	ElvuiL.option_media_blank = "主要UI材質路徑"
	ElvuiL.option_media_bordercolor = "非單位框架邊緣顏色"
	ElvuiL.option_media_altbordercolor = "單位框架邊緣顏色"
	ElvuiL.option_media_backdropcolor = "框架背景顏色"
	ElvuiL.option_media_backdropfadecolor = "框架背景淡出顏色"
	ElvuiL.option_media_buttonhover = "指標選定高亮度材質顏色"
	ElvuiL.option_media_valuecolor = "訊息文字顏色"
	ElvuiL.option_media_raidicons = "團隊圖標材質路徑"
	ElvuiL.option_media_whisper = "收到密語提示音效路徑"
	ElvuiL.option_media_warning = "警告音效路徑"
	ElvuiL.option_media_glossy = "Glossy Bar Texture"
	 
	-- nameplate
	ElvuiL.option_nameplates = "名條"
	ElvuiL.option_nameplates_enable = "啟用名條模組"
	ElvuiL.option_nameplates_enhancethreat = "啟用仇恨上色模式, 依照你的角色決定"
	ElvuiL.option_nameplates_showhealth = "在名條上顯示生命"
	ElvuiL.option_nameplates_combat = "只在戰鬥中顯示敵人名條"
	ElvuiL.option_nameplates_goodcolor = "Good threat color, varies depending if your a tank or dps/heal"
	ElvuiL.option_nameplates_badcolor = "Bad threat color, varies depending if your a tank or dps/heal"
	ElvuiL.option_nameplates_transitioncolor = "Losing/Gaining threat color"
	
	-- addon skins
	ElvuiL.option_skin = "插件外皮"
	ElvuiL.option_skin_kle = "KL Encounters"
	ElvuiL.option_skin_omen = "Omen"
	ElvuiL.option_skin_recount = "Recount"
	ElvuiL.option_skin_skada = "Skada"
	ElvuiL.option_hookkleright = "強制將KLE設置於右邊對話框上方"
	 
	-- classtimer
	ElvuiL.option_classtimer = "職業計時條"
	ElvuiL.option_classtimer_enable = "啟動職業計時條模組"
	ElvuiL.option_classtimer_bar_height = "計時條高度"
	ElvuiL.option_classtimer_bar_spacing = "計時條間距"
	ElvuiL.option_classtimer_icon_position = "圖示位置 (0-左邊,1-右邊,2-外面左邊,3-外面右邊)"
	ElvuiL.option_classtimer_layout = "樣式配置 (1-5)"
	ElvuiL.option_classtimer_showspark = "顯示閃光"
	ElvuiL.option_classtimer_cast_suparator = "Cast Seperator"
	ElvuiL.option_classtimer_classcolor = "職業上色"
	ElvuiL.option_classtimer_debuffcolor = " DEBUFF計時條顏色"
	ElvuiL.option_classtimer_buffcolor = " BUFF計時條顏色"
	ElvuiL.option_classtimer_proccolor = "飾品效果發動計時條顏色"
	 
	-- datatext
	ElvuiL.option_datatext = "訊息文字"
	ElvuiL.option_datatext_24h = "使用24小時制"
	ElvuiL.option_datatext_localtime = "使用當地時間"
	ElvuiL.option_datatext_bg = "啟用戰場資訊"
	ElvuiL.option_datatext_guild = "公會訊息位置 (輸入0為關閉)"
	ElvuiL.option_datatext_mem = "記憶體使用資訊位置 (輸入0為關閉)"
	ElvuiL.option_datatext_bags = "顯示背包空格位置 (輸入0為關閉)"
	ElvuiL.option_datatext_fontsize = "訊息文字大小"
	ElvuiL.option_datatext_system = "延遲及FPS顯示位置 (輸入0為關閉)"
	ElvuiL.option_datatext_friend = "好友名單顯示位置 (輸入0為關閉)"
	ElvuiL.option_datatext_time = "時間顯示位置 (輸入0為關閉)"
	ElvuiL.option_datatext_gold = "金錢顯示位置 (輸入0為關閉)"
	ElvuiL.option_datatext_dur = "裝備耐久顯示位置 (輸入0為關閉)"
	ElvuiL.option_datatext_stat1 = "角色主要能力顯示位置"
	ElvuiL.option_datatext_stat2 = "角色次要能力顯示位置"
	ElvuiL.option_datatext_dps = "每秒傷害"
	ElvuiL.option_datatext_hps = "每秒治療"
	
	-- auras
	ElvuiL.option_auras = "光環"
	ElvuiL.option_auras_minimapauras = "啟用小地圖旁狀態光環"
	ElvuiL.option_auras_arenadebuffs = "只顯示對我有用的光環"
	ElvuiL.option_auras_auratimer = "顯示光環時間"
	ElvuiL.option_auras_targetaura = "顯示目標光環"
	ElvuiL.option_auras_focusdebuff = "顯示專注目標debuffs"
	ElvuiL.option_auras_playeraura = "在玩家頭像顯示光環"
	ElvuiL.option_auras_aurascale = "光環字體比例"
	ElvuiL.option_auras_totdebuffs = "顯示目標的目標debuffs"
	ElvuiL.option_auras_playershowonlydebuffs = "只在玩家單位框架顯示debuffs (限開啟玩家單位框架光環下使用)"
	ElvuiL.option_auras_playerdebuffsonly = "只顯示玩家DEBUFF於目標單位框架(可於auraFilter.lua設定)"
	ElvuiL.option_auras_RaidUnitBuffWatch = "開啟團隊buff監視"
	ElvuiL.option_auras_buffindicatorsize = "隊伍/團隊視窗增益圖示大小"
	
	ElvuiL.option_auras_playtarbuffperrow = "於玩家/目標單位框架上每列BUFF/DEBUFF顯示數"
	ElvuiL.option_auras_smallbuffperrow = "於目標的目標/專注單位框架上每列BUFF/DEBUFF顯示數"
	
	-- raidframes
	ElvuiL.option_raidframes = "團隊框架"
	ElvuiL.option_raidframes_enable = "啟用團隊框架模組"
	ElvuiL.option_raidframes_gridonly = "在小隊時依然使用25人團隊框架"
	ElvuiL.option_raidframes_healcomm = "啟用HealComm插件 (限治療配置)"
	ElvuiL.option_raidframes_boss = "顯示首領框架"
	ElvuiL.option_raidframes_hpvertical = "GRID血量垂直顯示(限治療配置)"
	ElvuiL.option_raidframes_enablerange = "開啟團隊/隊伍距離過遠淡出顯示"
	ElvuiL.option_raidframes_range = "團隊/隊伍距離過遠淡出濃度"
	ElvuiL.option_raidframes_maintank = "啟用主坦單位框架"
	ElvuiL.option_raidframes_mainassist = "啟用主助攻單位框架"
	ElvuiL.option_raidframes_playerparty = "於隊伍中顯示玩家自己"
	ElvuiL.option_raidframes_hidenonmana = "只在單位有能量時顯示能量條"
	ElvuiL.option_raidframes_fontsize = "團隊框架字體大小"
	ElvuiL.option_raidframes_scale = "團隊單位框架比例 (用小數 例: 0.96)"
	ElvuiL.option_raidframes_disableblizz = "關閉WOW內建團隊框架"
	ElvuiL.option_raidframes_griddps = "Display the DPS Layout in grid layout instead of a vertical layout (Not Party)"
	ElvuiL.option_raidframes_partytarget = "顯示隊員目標(DPS限定)"
	
	-- castbar
	ElvuiL.option_castbar = "施法條"
	ElvuiL.option_castbar_nointerruptcolor = "無法中斷的法術施法條顏色"
	ElvuiL.option_castbar_castbarcolor = "施法條顏色"
	ElvuiL.option_castbar_castbar = "啟用施法條模組"
	ElvuiL.option_castbar_latency = "在施法條中顯示延遲"
	ElvuiL.option_castbar_icon = "顯示法術圖示"
	ElvuiL.option_castbar_castermode = "啟用大型施法條 "
	ElvuiL.option_castbar_classcolor = "施法條使用玩家職業顏色"
	 
	-- unit frames
	ElvuiL.option_unitframes_unitframes = "單位框架"
	ElvuiL.option_unitframes_healthcolor = "生命條顏色"
	ElvuiL.option_unitframes_combatfeedback = "玩家及目標單位框架戰鬥回報"
	ElvuiL.option_unitframes_totalhpmp = "顯示總生命/能量值"
	ElvuiL.option_unitframes_aurawatch = "啟用Buff監視"
	ElvuiL.option_unitframes_saveperchar = "依角色儲存單位框架位置"
	ElvuiL.option_unitframes_playeraggro = "啟用玩家仇恨顯示"
	ElvuiL.option_unitframes_smooth = "啟用smooth bar"
	ElvuiL.option_unitframes_portrait = "啟用玩家及目標動態頭像"
	ElvuiL.option_unitframes_enable = "啟用Elvui團隊框架模組"
	ElvuiL.option_unitframes_enemypower = "只顯示玩家能量條"
	ElvuiL.option_unitframes_raidaggro = "啟用仇恨顯示"
	ElvuiL.option_unitframes_symbol = "顯示隊伍/團隊標記"
	ElvuiL.option_others_threatbar = "啟用仇恨條"
	ElvuiL.option_unitframes_focus = "啟用專注目標"
	ElvuiL.option_unitframes_manalow = "法力過低顯示"
	ElvuiL.option_unitframes_classcolor = "單位框架依照職業上色"
	ElvuiL.option_unitframes_SwingBar = "啟用自動攻擊計時條 (限DPS配置)"
	ElvuiL.option_unitframes_DebuffHighlight = "單位框架依可驅散DEBUFF上色"
	ElvuiL.option_unitframes_mendpet = "於寵物框架顯示Mend Pet狀態條 (限DPS配置)"
	ElvuiL.option_unitframes_fontsize = "字體大小"
	ElvuiL.option_unitframes_unitframes_poweroffset = "將能量條並排於單位框架 (0 以並排)"
	ElvuiL.option_unitframes_classbar = "啟用職業條 (圖騰列, 符文列, 神聖能量列, 靈魂裂片列, 日/月蝕列)"
    ElvuiL.option_unitframes_healthbackdropcolor = "全部單位視窗生命條使用背景顏色"
	ElvuiL.option_unitframes_healthcolorbyvalue = "生命條依照剩餘生命上色"
	ElvuiL.option_unitframes_combat = "Fade unitframes while not in-combat"
	ElvuiL.option_unitframes_pettarget = "顯示寵物目標(DPS限定)"
	
	 -- frame sizes
	ElvuiL.option_framesizes = "單位視窗大小"
	ElvuiL.option_framesizes_playtarwidth = "玩家/目標單位框架的闊度"
    ElvuiL.option_framesizes_playtarheight = "玩家/目標單位框架的高度"
    ElvuiL.option_framesizes_smallwidth = "目標的目標/專注/專注目標及玩家寵物單位框架的闊度"
    ElvuiL.option_framesizes_smallheight = "目標的目標/專注/專注目標及玩家寵物單位框架的高度"
    ElvuiL.option_framesizes_arenabosswidth = "競技場/首領單位框架的闊度"
    ElvuiL.option_framesizes_arenabossheight = "競技場/首領單位框架的高度"
    ElvuiL.option_framesizes_assisttankwidth = "主坦克/助手單位框架的闊度"
    ElvuiL.option_framesizes_assisttankheight = "主坦克/助手單位框架的高度"
	
	-- loot
	ElvuiL.option_loot = "拾取"
	ElvuiL.option_loot_enableloot = "啟用戰利品視窗"
	ElvuiL.option_loot_autogreed = "最高等級時自動分解/貪婪綠裝"
	ElvuiL.option_loot_enableroll = "啟用骰裝視窗"
	 
	-- tooltip
	ElvuiL.option_tooltip = "提示訊息"
	ElvuiL.option_tooltip_enable = "啟用提示訊息模組"
	ElvuiL.option_tooltip_hidecombat = "戰鬥中隱藏右下角提示訊息"
	ElvuiL.option_tooltip_hidebutton = "隱藏動作條提示訊息"
	ElvuiL.option_tooltip_hideuf = "隱藏單位框架提示訊息"
	ElvuiL.option_tooltip_cursor = "開啟滑鼠旁提示訊息"
	ElvuiL.option_tooltip_combatraid = "只在團隊戰鬥中隱藏提示訊息"
	ElvuiL.option_tooltip_colorreaction = "提示訊息及生命條依照敵對狀態上色"
	ElvuiL.option_tooltip_xOfs = "提示訊息X-軸位子調整 (-x = 左, +x = 右)"
	ElvuiL.option_tooltip_yOfs = "提示訊息Y-軸位子調整 (-y = 下, +y = 上)"
	ElvuiL.option_tooltip_itemid = "顯示物品ID"
	
	-- others
	ElvuiL.option_others = "其它功能"
	ElvuiL.option_others_bg = "戰場中死亡自動放魂"
	ElvuiL.option_others_autosell = "自動販賣灰色物品"
	ElvuiL.option_others_autorepair = "自動修復裝備"
	ElvuiL.option_others_autoinvite = "啟用自動邀請及接受邀請 (限好友及公會會員)"
	ElvuiL.option_others_enablemap = "啟用小地圖模組"
	ElvuiL.option_others_errorhide = "隱藏螢幕中央錯誤訊息"
	ElvuiL.option_others_spincam = "暫離時旋轉鏡頭"
	ElvuiL.option_others_bagenable = "啟用整合背包模組"
	 
	-- reminder
	ElvuiL.option_reminder = "光環警告"
	ElvuiL.option_reminder_enable = "啟用玩家光環警告"
	ElvuiL.option_reminder_sound = "啟用光環警告音效"
	ElvuiL.option_reminder_RaidBuffReminder = "啟用小地圖下方的團隊buff提醒"
	 
	-- action bar
	ElvuiL.option_actionbar = "動作條 "
	ElvuiL.option_actionbar_hidess = "隱藏變身及圖騰條"
	ElvuiL.option_actionbar_showgrid = "永遠顯示動作條空格"
	ElvuiL.option_actionbar_enable = "啟用動作條模組"
	ElvuiL.option_actionbar_rb = "啟用當滑鼠移動至右方動作條時顯示"
	ElvuiL.option_actionbar_hk = "顯示熱鍵文字"
	ElvuiL.option_actionbar_ssmo = "啟用當滑鼠移動至變身及圖騰條時顯示"
	ElvuiL.option_actionbar_bottompetbar = "將主動作條向上移動並將寵物動作條移至主動作條下方"
	ElvuiL.option_actionbar_buttonsize = "主要熱鍵大小"
	ElvuiL.option_actionbar_buttonspacing = "主要熱鍵間隔距離"
	ElvuiL.option_actionbar_petbuttonsize = "寵物/姿態/圖騰熱鍵大小"
	ElvuiL.option_actionbar_macrotext = "快捷鍵顯示巨集名稱"
	ElvuiL.option_actionbar_verticalstance = "直立式姿態列"
	ElvuiL.option_actionbar_petbuttonsize = "寵物/姿態列快捷鍵大小"
	ElvuiL.option_actionbar_swaptopbottombar = "Swap the top and bottom actionbar positions"
	
	-- arena
	ElvuiL.option_arena = "競技場"
	ElvuiL.option_arena_st = "競技場中啟用敵方法術追蹤"
	ElvuiL.option_arena_uf = "啟用競技場單位框架"
	 
	-- cooldowns
	ElvuiL.option_cooldown = "冷卻"
	ElvuiL.option_cooldown_enable = "啟用按鍵上冷卻倒數文字"
	ElvuiL.option_cooldown_th = "於CD剩下X秒時轉變成倒數到期文字顏色"
	ElvuiL.option_cooldown_expiringcolor = "倒數到期文字顏色"
	ElvuiL.option_cooldown_secondscolor = "秒數文字顏色"
	ElvuiL.option_cooldown_minutescolor = "分鐘文字顏色"
	ElvuiL.option_cooldown_hourscolor = "小時文字顏色"
	ElvuiL.option_cooldown_dayscolor = "天數文字顏色"
	 
	-- chat
	ElvuiL.option_chat = "聊天"
	ElvuiL.option_chat_bubbles = "對話泡泡外皮"
	ElvuiL.option_chat_enable = "啟用聊天模組"
	ElvuiL.option_chat_whispersound = "收到密語時播放提示音效"
	ElvuiL.option_chat_chatwidth = "對話框寬度"
	ElvuiL.option_chat_backdrop = "顯示對話框背景"
	ElvuiL.option_chat_chatheight = "對話框高度"
	ElvuiL.option_chat_fadeoutofuse = "不使用時使文字淡出"
	ElvuiL.option_chat_sticky = "開啟新對話框時預設某些重要頻道"
	ElvuiL.option_chat_rightchat = "顯示右邊對話框"
	ElvuiL.option_chat_combathide = "戰鬥中隱藏對話框('Left-左', 'Right-右', 'Both-左+右', or 'NONE-無')"
	 
	-- buttons
	ElvuiL.option_button_reset = "重置UI"
	ElvuiL.option_button_load = "套用設定"
	ElvuiL.option_button_close = "關閉"
	ElvuiL.option_setsavedsetttings = "依角色儲存設定"
	ElvuiL.option_resetchar = "你確定要將你的角色設定回復到預設設定嗎?"
	ElvuiL.option_resetall = "你確定要將你所有的設定回復到系統預設值嗎?"
	ElvuiL.option_perchar = "你確定要啟用或者關閉依角色儲存設定的模式嗎?"
	ElvuiL.option_makeselection = "你必需作出選擇才能繼續設定"
end