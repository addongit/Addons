﻿-- localization for koKR

-- Localization thanks to Tez. @hijal(하이잘)
-- My blog is http://tezthehunter.blogspot.com

local L	= JSHB.locale

if GetLocale() == "koKR" then

	L.greeting1 				= "JS' 헌터 바 "
	L.greeting2 				= " 불러오기 완료,  /jsb 명령어를 통해 도움말을 볼 수 있습니다."
	L.tranqremoved 			= "평정의 사격으로 다음의 효과를 지웠습니다. "
	L.tranqfrom 				= " 로 부터 "
	L.mdcaston 				= " cast on "
	L.mdfinished				= " finished."
	L.mdtargetmounted		= " can not be cast on you when mounted!"
	L.mdaggroto				= " is transferring threat to You!"
	L.mdaggrotoover			= " threat transfer complete."
	L.slashdesc1 				= "JS' 헌터 바 "
	L.slashdesc2 				= "설정창을 엽니다."
	L.slashdesc3 				= "바의 위치를 고정하거나 풉니다"
	L.slashdesc4 				= "바의 위치를 초기화합니다."
	L.invalidoption 			= "불가능한 설정입니다"
	L.nowlocked 				= "JS' 헌터 바의 위치가 고정되었습니다, '/jsb lock' 명령어를 다시 실행하면 고정된 위치를 풀 수 있습니다."
	L.nowunlocked 			= "JS' 헌터 바의 위치가 자유롭게 되었습니다, '/jsb lock' 명령어를 다시 실행하면 위치를 고정시킬 수 있습니다.."
	L.loderror				= "JSHB: Options Load on Demand Error!"
	L.lodsuccessful			= "JSHB: Options Loaded"

	L.postop					= "타이머 위에"
	L.posbottom				= "타이머 아래에"
	L.posabove				= "위쪽"
	L.posbelow				= "아래쪽"
	L.poscenter				= "가운데"
	L.posleft					= "왼쪽"
	L.posright				= "오른쪽"
	L.postopbottom			= "위/아래"
	L.posmovable				= "MOVABLE"

	-- Options - misc stuff
	L.confirmdelete1			= "지워도 괜찮습니까? "
	L.confirmdelete2			= " 타이머?"
	L.confirmdelete3		= " spell?"
	L.deletebutton			= "지우기"
	L.editbutton 				= "수정하기"
	L.spelltextdurfor			= "지속시간 "
	L.spelltextcdfor			= "재사용대기시간 "
	L.spelltextplayer			= "플래이어"
	L.spelltexttarget			= "대상"
	L.spelltextpet			= "Pet"
	L.dur						= "지속시간"
	L.cd						= "재사용대기시간"
	L.durorcd					= "지속시간인가요? 아니면 재사용대기시간?"
	L.pickplayerortarget 		= "자신에 대한 건가요? 아니면 대상 몹에 대한건가요?"
	L.pickLocation			= "바를 중심으로 어디에 위치하면 좋을까요?"
	L.pickSpell				= "추적할 기술이나 아이템을 선택하세요"
	L.pickOffset				= "Position of this icon: %d"
	L.savebutton1				= "업데이트"
	L.savebutton2				= "추가하기"
	L.nottracking 			= "당신은 아무것도 추적하지 않고 있습니다. "
	L.currentlytracking1		= "당신은 %d개의 기술들을 추적하고 있습니다. "
	L.currentlytracking2		= " 타이머:"
	L.buttonaddtimer			= "타이머를 추가합니다."
	L.movetranqalert			= "Tranq\nAlert"
	L.movetranqables		= "Tranq-able Debuffs"
	L.movemarkreminder		= "Hunter's Mark\nReminder"
	L.movecctimers			= "Crowd Control\nTimers"
	L.movedebuffalert			= "Debuff\nAlert"
	L.moveicontimers			= "Icon Timers"
	L.tranq 					= "Tranq!"
	L.petspell				= "pet"
	L.playerspell			= "player"
	L.nocustomspells		= "You have no custom spells defined."
	L.customspellsdefined	= "You have the following %d custom spell(s) defined:"
	L.buttonaddspell		= "Add Spell"
	L.addspelltext1			= "Enter the spell ID that you want to add.\n\nNOTE: Invalid IDs will not be added."
	L.invalidspellid		= "INVALID SPELL ID"

	-- Chat channels
	L.chan_auto 				= "Automatic"
	L.chan_selfwhisper		= "Whisper Self"
	L.chan_raid 				= "Raid"
	L.chan_yell 				= "Yell"
	L.chan_officer			= "Officer"
	L.chan_guild				= "Guild"
	L.chan_battleground		= "Battleground"
	L.chan_party				= "Party"
	L.chan_emote				= "Emote"
	L.chan_say				= "Say"

	-- Options - main
	L.enablebarlock 			= "바의 위치를 고정시킵니다"

	-- Options - general
	L.namegeneral 				= "일반 설정"
	L.enablestackbars 			= "Display bars to indicate stacks for spec abilities"
	L.movestackbarstotop			= "Move the stack bars to the top (instead of the bottom)"
	L.enableautoshotbar 			= "자동사격 바"
	L.enableautoshottext 			= "자동사격 바를 보여줍니다."
	L.enablemaintick 				= "기본 사격기술을 시전하기 위한 최소집중을 표시합니다."
	L.enablehuntersmarkwarning 		= "사냥꾼의 징표가 시전되지 않았음을  경고합니다."
	L.enabletranqannounce 		= "평정사격을 통한 마법해제를 표시합니다."
	L.tranqannouncechannel		= "Notify to channel"
	L.enabletranqalert 			= "Show alert when a mob should be tranq'd"
	L.enablecctimers 				= "빙결의 덫과 비룡쐐기의 군중제어시간을 표시합니다."
	L.enableprediction 			= "고정 사격과 코브라 사격으로 회복하는 집중을 표시합니다."
	L.enabletimers 				= "재사용대기시간을 추적하는 타이머를 활성화 합니다."
	L.timerfontposition 			= "타이머 글자 위치:"
	L.enabletimerstext 			= "재사용대기시간을 추적하는 타이머 숫자를 표시합니다."
	L.enabletimertenths 			= "10초 이하의 시간은 소수점으로 표시합니다."
	L.enabledebuffalert			= "Enable debuff icons for important debuffs"
	L.enabletargethealthpercent	= "Show your target's health percentage on bar"
	L.timericonanchorparent		= "Icon timers anchor point"
	L.timertextcoloredbytime		= "Color timer's text based on time remaining"
	L.enablecurrentfocustext		= "Enable text representation of current focus on bar"
	L.enabletranqablesframe		= "Enable frame to show tranq-able buffs on target"
	L.enabletranqablestips		= "Show hover-over tips for tranqable buffs (non-click through)"

	-- Options - style & size
	L.namestylesize				= "맵시와 크기"
	L.classcolored 				= "사냥꾼 직업색상으로 색을 설정합니다.\n    아래에 설정된 색을 쓰고 싶으면 체크를 푸세요."
	L.classcoloredprediction 		= "사냥꾼 직업색상으로 예측바의 색을 설정합니다.\n    아래에 설정된 색을 쓰고 싶으면 체크를 푸세요."
	L.enabletukui 				= "TukUI처럼 군중제어와 사냥꾼의 징표 경고를 표시합니다."
	L.enabletukuitimers 			= "TukUI처럼 타이머 스타일을 설정합니다"
	L.enablehighcolorwarning 		= "최대 집중치를 넘기면 집중바의 색을 바꿉니다."
	L.focushighthreshold 			= "한계선: %d%%"
	L.focuscenteroffset			= "Focus number offset from center: %d"
	L.barwidth 					= "집중 바 가로크기: %dpx"
	L.barheight 					= "집중 바 높이: %dpx"
	L.iconsize					= "타이머 아이콘 크기: %dpx"
	L.cciconsize 					= "군중제어 아이콘 크기: %dpx"
	L.markiconsize 				= "사냥꾼의 징표 아이콘 크기: %dpx"
	L.taiconsize					= "Tranq Alert icon size: %dpx"
	L.tranqablesiconsize			= "Tranq-able debuffs icon size: %dpx"
	L.icontimerssize				= "Icon Timers icon size: %dpx"
	L.icontimersgap				= "Icon Timers gap between left and right: %dpx"
	L.debufficonsize				= "Debuff Alert icon size: %dpx"
	L.alphabackdrop 				= "바 배경 알파: %d%%"
	L.alphazeroooc 				= "비전투 중 최저 집중 알파값: %d%%"
	L.alphamaxooc 				= "비전투 중 최대 집중 알파값: %d%%"
	L.alphanormooc 				= "비전투 중 집중 알파값: %d%%"
	L.alphazero 					= "전투 중 최전 집중 알파값: %d%%"
	L.alphamax 					= "전투 중 최대 집중 알파값: %d%%"
	L.alphanorm 					= "전투 중 집중 알파값: %d%%"
	L.alphaicontimersfaded		= "Icon timers faded Alpha: %d%%"

	-- Options - fonts & textures
	L.namefontstextures 			= "서체와 무늬"
	L.barfont 					= "집중 숫자의 서체:"
	L.timerfont 					= "타이머 서체:"
	L.bartexture 					= "집중 바 무늬:"
	L.fontoutlined 				= "집중치 글자에 테두리효과를 줍니다."
	L.fontsize 					= "집중 바 서체의 크기: %dpx"
	L.fontsizetimers 				= "타이머 아이콘용 서체의 크기: %dpx"

	-- Options - Colors
	L.namecolors						= "색"
	L.barcolor 						= "기본 색"
	L.barcolorwarninglow 				= "낮은 집중 경고 색"
	L.barcolorwarninghigh 			= "높은 집중 경고 색"
	L.autoshotbarcolor 				= "자동사격 바"
	L.predictionbarcolor 				= "집중 예상 바"
	L.predictionbarcolorwarninghigh	= "집중 예상 바 높음 경고"

	-- Options - specs
	L.namebm = "야수 특성"
	L.namemm = "사격 특성"
	L.namesv = "생존 특성"
	
	-- Options - Misdirection
	L.namemd					= "Misdirection"
	L.mdoptiontext1			= "NOTE: With Blizzard default frames unit frames, you need to use a modifier with Right click to use the default menu.\n\nFor example: SHIFT or CTRL or ALT + Right Click"	
	L.enablerightclickmd		= "Enable right click misdirection on specified unit frames"
	L.enablemdonpet			= "Enable for Player's pet frame"
	L.enablemdonparty			= "Enable for Party frames"
	L.enablemdonraid			= "Enable for Raid frames"
	L.enablemdcastannounce	= "Misdirection cast notification to chat"
	L.enablemdoverannounce	= "Misdirection expire/used notification to chat"
	L.enablemdtargetwhisper   = "Whisper Misdirection target when aggro is transferring and finished"
	L.mdannouncechannel		= "Chat channel"
	
	-- Options - Custom Spells
	L.namecustomspell		= "Custom Spells"
	
	-- Options - Custom Tranqs
	L.namecustomtranq		= "Custom Tranqs"

	-- Options - Custom Auras
	L.namecustomaura		= "Custom Auras"
	
end
