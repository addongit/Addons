-- HealBot localization information
-- Korean Locale
-- Translation by SayClub

if (GetLocale() == "koKR") then

-------------------
-- Compatibility --
-------------------

-- Class
HEALBOT_DRUID = "드루이드";
HEALBOT_HUNTER = "사냥꾼";
HEALBOT_MAGE = "마법사";
HEALBOT_PALADIN = "성기사";
HEALBOT_PRIEST = "사제";
HEALBOT_ROGUE = "도적";
HEALBOT_SHAMAN = "주술사";
HEALBOT_WARLOCK = "흑마법사";
HEALBOT_WARRIOR = "전사";
HEALBOT_DEATHKNIGHT = "죽음의 기사";

-- Cure Spells
HEALBOT_DISEASE = "질병";
HEALBOT_MAGIC = "마법";
HEALBOT_CURSE = "저주";
HEALBOT_POISON = "독";

-- Debuffs
HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "고대의 격분";
HEALBOT_DEBUFF_IGNITE_MANA = "마나 점화";
HEALBOT_DEBUFF_TAINTED_MIND = "부패한 정신";
HEALBOT_DEBUFF_VIPER_STING = "살무사 쐐기";
HEALBOT_DEBUFF_SILENCE = "침묵";
HEALBOT_DEBUFF_MAGMA_SHACKLES = "용암 족쇄";
HEALBOT_DEBUFF_FROSTBOLT = "얼음 화살";
HEALBOT_DEBUFF_HUNTERS_MARK = "사냥꾼의 징표";
HEALBOT_DEBUFF_SLOW = "감속";
HEALBOT_DEBUFF_ARCANE_BLAST = "비전 작렬";
HEALBOT_DEBUFF_IMPOTENCE = "무기력의 저주";
HEALBOT_DEBUFF_DECAYED_STR = "힘 쇠약";
HEALBOT_DEBUFF_DECAYED_INT = "지능 쇠퇴";
HEALBOT_DEBUFF_CRIPPLE = "신경 마비";
HEALBOT_DEBUFF_CHILLED = "빙결";
HEALBOT_DEBUFF_CONEOFCOLD = "냉기 돌풍";
HEALBOT_DEBUFF_CONCUSSIVESHOT = "충격포";
HEALBOT_DEBUFF_THUNDERCLAP = "천둥벼락";
HEALBOT_DEBUFF_HOWLINGSCREECH = "울부짖는 비명소리";
HEALBOT_DEBUFF_DAZED = "멍해짐";
HEALBOT_DEBUFF_UNSTABLE_AFFL = "불안정한 고통";
HEALBOT_DEBUFF_DREAMLESS_SLEEP = "숙면";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "상급 숙면";
HEALBOT_DEBUFF_MAJOR_DREAMLESS = "일급 숙면";
HEALBOT_DEBUFF_FROST_SHOCK = "냉기 충격"

HB_TOOLTIP_MANA = "^마나 (%d+)$";
HB_TOOLTIP_INSTANT_CAST = "즉시 시전";
HB_TOOLTIP_CAST_TIME = "(%d+.?%d*)초";
HB_TOOLTIP_CHANNELED = "정신 집중";
HB_TOOLTIP_OFFLINE = "오프라인";
HB_OFFLINE = "님이 게임을 종료했습니다."; -- has gone offline msg
HB_ONLINE = "님이 게임에 접속했습니다."; -- has come online msg

-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = "|1을;를; 불려옵니다.";

HEALBOT_ACTION_OPTIONS = "옵션";

HEALBOT_OPTIONS_TITLE = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS = "기본값";
HEALBOT_OPTIONS_CLOSE = "닫기";
HEALBOT_OPTIONS_HARDRESET = "UI 재시작"
HEALBOT_OPTIONS_SOFTRESET = "HB 초기화"
HEALBOT_OPTIONS_INFO = "정보"
HEALBOT_OPTIONS_TAB_GENERAL = "일반";
HEALBOT_OPTIONS_TAB_SPELLS = "주문";
HEALBOT_OPTIONS_TAB_HEALING = "치유";
HEALBOT_OPTIONS_TAB_CDC = "치료";
HEALBOT_OPTIONS_TAB_SKIN = "스킨";
HEALBOT_OPTIONS_TAB_TIPS = "툴팁";
HEALBOT_OPTIONS_TAB_BUFFS = "버프"

HEALBOT_OPTIONS_BARALPHA = "투명도 사용";
HEALBOT_OPTIONS_BARALPHAINHEAL = "들어오는 치유 투명도";
HEALBOT_OPTIONS_BARALPHAEOR = "사거리 벗어남 투명도";
HEALBOT_OPTIONS_ACTIONLOCKED = "위치 잠금";
HEALBOT_OPTIONS_AUTOSHOW = "자동 닫기";
HEALBOT_OPTIONS_PANELSOUNDS = "옵션 열때 효과음 재생";
HEALBOT_OPTIONS_HIDEOPTIONS = "옵션 버튼 숨김";
HEALBOT_OPTIONS_PROTECTPVP = "우발적 PvP 피함";
HEALBOT_OPTIONS_HEAL_CHATOPT = "대화 옵션";

HEALBOT_OPTIONS_SKINTEXT = "스킨 사용"
HEALBOT_SKINS_STD = "표준"
HEALBOT_OPTIONS_SKINTEXTURE = "무늬"
HEALBOT_OPTIONS_SKINHEIGHT = "높이"
HEALBOT_OPTIONS_SKINWIDTH = "너비"
HEALBOT_OPTIONS_SKINNUMCOLS = "번호. 컬럼"
HEALBOT_OPTIONS_SKINNUMHCOLS = "번호. 컬럼당 그룹"
HEALBOT_OPTIONS_SKINBRSPACE = "줄 간격"
HEALBOT_OPTIONS_SKINBCSPACE = "칸 간격"
HEALBOT_OPTIONS_EXTRASORT = "공격 바 정렬"
HEALBOT_SORTBY_NAME = "이름"
HEALBOT_SORTBY_CLASS = "직업"
HEALBOT_SORTBY_GROUP = "그룹"
HEALBOT_SORTBY_MAXHEALTH = "최대 생명력"
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "새로운 디버프"
HEALBOT_OPTIONS_DELSKIN = "삭제"
HEALBOT_OPTIONS_NEWSKINTEXT = "새로운 스킨"
HEALBOT_OPTIONS_SAVESKIN = "저장"
HEALBOT_OPTIONS_SKINBARS = "바 옵션"
HEALBOT_SKIN_ENTEXT = "사용"
HEALBOT_SKIN_DISTEXT = "사용 안함"
HEALBOT_SKIN_DEBTEXT = "디버프"
HEALBOT_SKIN_BACKTEXT = "배경"
HEALBOT_SKIN_BORDERTEXT = "테두리"
HEALBOT_OPTIONS_SKINFONT = "글꼴"
HEALBOT_OPTIONS_SKINFHEIGHT = "글꼴 크기"
HEALBOT_OPTIONS_BARALPHADIS = "투명도 사용 안함"
HEALBOT_OPTIONS_SHOWHEADERS = "제목 표시"

HEALBOT_OPTIONS_ITEMS = "아이템";

HEALBOT_OPTIONS_COMBOCLASS = "단축 키";
HEALBOT_OPTIONS_CLICK = "클릭";
HEALBOT_OPTIONS_SHIFT = "Shift";
HEALBOT_OPTIONS_CTRL = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "항상 사용";

HEALBOT_OPTIONS_CASTNOTIFY1 = "알림 없음";
HEALBOT_OPTIONS_CASTNOTIFY2 = "자신 알림";
HEALBOT_OPTIONS_CASTNOTIFY3 = "대상 알림";
HEALBOT_OPTIONS_CASTNOTIFY4 = "파티 알림";
HEALBOT_OPTIONS_CASTNOTIFY5 = "공대 알림";
HEALBOT_OPTIONS_CASTNOTIFY6 = "채널 알림";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "부활만 알림";

HEALBOT_OPTIONS_CDCBARS = "바 색상";
HEALBOT_OPTIONS_CDCSHOWHBARS = "생명력 바 색상 변경";
HEALBOT_OPTIONS_CDCSHOWABARS = "어그로 바 색상 변경";
HEALBOT_OPTIONS_CDCWARNINGS = "디버프 경고";
HEALBOT_OPTIONS_SHOWDEBUFFICON = "디버프 표시";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "디버프 경고 표시";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "디버프시 효과음";
HEALBOT_OPTIONS_SOUND = "효과음"

HEALBOT_OPTIONS_HEAL_BUTTONS = "치유 바";
HEALBOT_OPTIONS_SELFHEALS = "자신"
HEALBOT_OPTIONS_PETHEALS = "소환수"
HEALBOT_OPTIONS_GROUPHEALS = "파티";
HEALBOT_OPTIONS_TANKHEALS = "방어 담당";
HEALBOT_OPTIONS_MAINASSIST = "공격 담당";
HEALBOT_OPTIONS_PRIVATETANKS = "개인적 방어 담당";
HEALBOT_OPTIONS_TARGETHEALS = "대상";
HEALBOT_OPTIONS_EMERGENCYHEALS = "공격대";
HEALBOT_OPTIONS_ALERTLEVEL = "경고 레벨";
HEALBOT_OPTIONS_EMERGFILTER = "공격대 바 표시";
HEALBOT_OPTIONS_EMERGFCLASS = "직업 설정";
HEALBOT_OPTIONS_COMBOBUTTON = "버튼";
HEALBOT_OPTIONS_BUTTONLEFT = "왼쪽";
HEALBOT_OPTIONS_BUTTONMIDDLE = "중앙";
HEALBOT_OPTIONS_BUTTONRIGHT = "오른쪽";
HEALBOT_OPTIONS_BUTTON4 = "버튼 4";
HEALBOT_OPTIONS_BUTTON5 = "버튼 5";
HEALBOT_OPTIONS_BUTTON6 = "버튼 6";
HEALBOT_OPTIONS_BUTTON7 = "버튼 7";
HEALBOT_OPTIONS_BUTTON8 = "버튼 8";
HEALBOT_OPTIONS_BUTTON9 = "버튼 9";
HEALBOT_OPTIONS_BUTTON10 = "버튼 10";
HEALBOT_OPTIONS_BUTTON11 = "버튼 11";
HEALBOT_OPTIONS_BUTTON12 = "버튼 12";
HEALBOT_OPTIONS_BUTTON13 = "버튼 13";
HEALBOT_OPTIONS_BUTTON14 = "버튼 14";
HEALBOT_OPTIONS_BUTTON15 = "버튼 15";


HEALBOT_CLASSES_ALL = "모든 직업";
HEALBOT_CLASSES_MELEE = "근거리";
HEALBOT_CLASSES_RANGES = "원거리";
HEALBOT_CLASSES_HEALERS = "치유사";
HEALBOT_CLASSES_CUSTOM = "사용자";

HEALBOT_OPTIONS_SHOWTOOLTIP = "툴팁 표시";
HEALBOT_OPTIONS_SHOWDETTOOLTIP = "상세한 주문 정보 표시";
HEALBOT_OPTIONS_SHOWCDTOOLTIP = "주문 재사용 대기시간 표시";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "대상 정보 표시";
HEALBOT_OPTIONS_SHOWRECTOOLTIP = "지속 치유 추천 표시";
HEALBOT_TOOLTIP_POSDEFAULT = "기본 위치";
HEALBOT_TOOLTIP_POSLEFT = "Healbot의 좌측";
HEALBOT_TOOLTIP_POSRIGHT = "Healbot의 우측";
HEALBOT_TOOLTIP_POSABOVE = "Healbot의 상단";
HEALBOT_TOOLTIP_POSBELOW = "Healbot의 하단";
HEALBOT_TOOLTIP_POSCURSOR = "커서 옆";
HEALBOT_TOOLTIP_RECOMMENDTEXT = "지속 치유 추천";
HEALBOT_TOOLTIP_NONE = "사용 가능 없음";
HEALBOT_TOOLTIP_CORPSE = "의 시체";
HEALBOT_TOOLTIP_CD = " (CD ";
HEALBOT_TOOLTIP_SECS = "s)";
HEALBOT_WORDS_SEC = "초";
HEALBOT_WORDS_CAST = "시전";
HEALBOT_WORDS_UNKNOWN = "알 수 없음";
HEALBOT_WORDS_YES = "예";
HEALBOT_WORDS_NO = "아니요";

HEALBOT_WORDS_NONE = "없음";
HEALBOT_OPTIONS_ALT = "Alt";
HEALBOT_DISABLED_TARGET = "대상";
HEALBOT_OPTIONS_SHOWCLASSONBAR = "바에 직업 표시";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "바에 생명력 표시";
HEALBOT_OPTIONS_BARHEALTHINCHEALS = "들어오는 치유 포함";
HEALBOT_OPTIONS_BARHEALTHSEPHEALS = "들어오는 치유 분리";
HEALBOT_OPTIONS_BARHEALTH1 = "결손치";
HEALBOT_OPTIONS_BARHEALTH2 = "백분율";
HEALBOT_OPTIONS_TIPTEXT = "툴팁 정보";
HEALBOT_OPTIONS_POSTOOLTIP = "위치 정보";
HEALBOT_OPTIONS_SHOWNAMEONBAR = "바에 이름 표시";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "직업에 의한 문자 색상";
HEALBOT_OPTIONS_EMERGFILTERGROUPS = "공격대 그룹 포함";

HEALBOT_ONE = "1";
HEALBOT_TWO = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR = "4";
HEALBOT_FIVE = "5";
HEALBOT_SIX = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";

HEALBOT_OPTIONS_SETDEFAULTS = "기본값 설정";
HEALBOT_OPTIONS_SETDEFAULTSMSG = "모든 옵션을 기본값으로 되돌립니다.";
HEALBOT_OPTIONS_RIGHTBOPTIONS = "우 클릭시 옵션 열기";

HEALBOT_OPTIONS_HEADEROPTTEXT = "제목 옵션";
HEALBOT_OPTIONS_ICONOPTTEXT = "아이콘 옵션";
HEALBOT_SKIN_HEADERBARCOL = "바 색상";
HEALBOT_SKIN_HEADERTEXTCOL = "문자 색상";
HEALBOT_OPTIONS_BUFFSTEXT1 = "버프 주문";
HEALBOT_OPTIONS_BUFFSTEXT2 = "멤버 체크";
HEALBOT_OPTIONS_BUFFSTEXT3 = "바 색상";
HEALBOT_OPTIONS_BUFF = "보프 ";
HEALBOT_OPTIONS_BUFFSELF = "자신";
HEALBOT_OPTIONS_BUFFPARTY = "파티시";
HEALBOT_OPTIONS_BUFFRAID = "공격대시";
HEALBOT_OPTIONS_MONITORBUFFS = "사라진 버프 모니터";
HEALBOT_OPTIONS_MONITORBUFFSC = "전투중";
HEALBOT_OPTIONS_ENABLESMARTCAST = "비전투 상태일 때 신속시전";
HEALBOT_OPTIONS_SMARTCASTSPELLS = "주문들 포함";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "디버프 제거";
HEALBOT_OPTIONS_SMARTCASTBUFF = "버프 추가";
HEALBOT_OPTIONS_SMARTCASTHEAL = "치유 주문들";
HEALBOT_OPTIONS_BAR2SIZE = "파워 바 크기";
HEALBOT_OPTIONS_SETSPELLS = "주문 설정";
HEALBOT_OPTIONS_ENABLEDBARS = "항상 바 사용";
HEALBOT_OPTIONS_DISABLEDBARS = "비전투 상태일 때 바 사용 안함";
HEALBOT_OPTIONS_MONITORDEBUFFS = "디버프들 해제 모니터";
HEALBOT_OPTIONS_DEBUFFTEXT1 = "디버프 해제 주문";

HEALBOT_OPTIONS_IGNOREDEBUFF = "디버프들 무시:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS = "직업별";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "감속 효과";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "짧은 지속시간";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM = "해롭지 않은 ";

HEALBOT_OPTIONS_RANGECHECKFREQ = "거리, 오라, 어그로 업데이트 빈도";

HEALBOT_OPTIONS_HIDEPARTYFRAMES = "파티원 프레임 숨김";
HEALBOT_OPTIONS_HIDEPLAYERTARGET = "플레이어와 대상 포함";
HEALBOT_OPTIONS_DISABLEHEALBOT = "HealBot 사용 안함";

HEALBOT_OPTIONS_CHECKEDTARGET = "체크";

HEALBOT_ASSIST = "지원";
HEALBOT_FOCUS = "주시";
HEALBOT_MENU = "메뉴";
HEALBOT_MAINTANK = "방어  담당";
HEALBOT_MAINASSIST = "공격 담당";
HEALBOT_STOP = "정지";
HEALBOT_TELL = "알림";

HEALBOT_TITAN_SMARTCAST = "신속시전";
HEALBOT_TITAN_MONITORBUFFS = "버프들 모니터";
HEALBOT_TITAN_MONITORDEBUFFS = "디버프들 모니터"
HEALBOT_TITAN_SHOWBARS = "바 표시";
HEALBOT_TITAN_EXTRABARS = "응급 바";
HEALBOT_BUTTON_TOOLTIP = "왼쪽 클릭으로 HealBot 옵션 창을 엽니다.\n오른쪽 클릭 (끌기)으로 이 아이콘을 이동시킵니다.";
HEALBOT_TITAN_TOOLTIP = "왼쪽 클릭으로 HealBot 옵션 창을 엽니다.";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "미니맵 버튼 표시";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT = "HoT 표시";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "전술 목표 표시";
HEALBOT_OPTIONS_HOTONBAR = "바 켬";
HEALBOT_OPTIONS_HOTOFFBAR = "바 끔";
HEALBOT_OPTIONS_HOTBARRIGHT = "오른쪽";
HEALBOT_OPTIONS_HOTBARLEFT = "왼쪽";

HEALBOT_ZONE_AB = "아라시 분지";
HEALBOT_ZONE_AV = "알터랙 계곡";
HEALBOT_ZONE_ES = "폭풍의 눈";
HEALBOT_ZONE_IC = "정복의 섬";
HEALBOT_ZONE_SA = "고대의 해안";
HEALBOT_ZONE_WG = "전쟁노래 협곡";

HEALBOT_OPTION_AGGROTRACK = "어그로 모니터"
HEALBOT_OPTION_AGGROBAR = "반작임 바"
HEALBOT_OPTION_AGGROTXT = ">> 문자 표시 <<"
HEALBOT_OPTION_BARUPDFREQ = "업데이트 빈도"
HEALBOT_OPTION_USEFLUIDBARS = "유동적 바 사용"
HEALBOT_OPTION_CPUPROFILE = "CPU 프로필 사용 (애드온의 CPU 사용 정보)"
HEALBOT_OPTIONS_RELOADUIMSG = "이 옵션은 UI 재시작 후 적용됩니다, 지금 재시작 하시겠습니까?"

HEALBOT_SELF_PVP = "자신 PvP"
HEALBOT_OPTIONS_ANCHOR = "프레임 위치"
HEALBOT_OPTIONS_BARSANCHOR = "바 위치"
HEALBOT_OPTIONS_TOPLEFT = "좌측 상단"
HEALBOT_OPTIONS_BOTTOMLEFT = "좌측 하단"
HEALBOT_OPTIONS_TOPRIGHT = "우측 상단"
HEALBOT_OPTIONS_BOTTOMRIGHT = "우측 하단"
HEALBOT_OPTIONS_TOP = "상단"
HEALBOT_OPTIONS_BOTTOM = "하단"

HEALBOT_PANEL_BLACKLIST = "블랙리스트"

HEALBOT_WORDS_REMOVEFROM = "제거";
HEALBOT_WORDS_ADDTO = "추가";
HEALBOT_WORDS_INCLUDE = "포함";

HEALBOT_OPTIONS_TTALPHA = "투명도"
HEALBOT_TOOLTIP_TARGETBAR = "대상 바"
HEALBOT_OPTIONS_MYTARGET = "나의 대상"

HEALBOT_DISCONNECTED_TEXT = "<DC>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME = "나의 버프들 표시";
HEALBOT_OPTIONS_TOOLTIPUPDATE = "지속적 업데이트";
HEALBOT_OPTIONS_BUFFSTEXTTIMER = "만료전 버프 표시";
HEALBOT_OPTIONS_SHORTBUFFTIMER = "짧은 버프들"
HEALBOT_OPTIONS_LONGBUFFTIMER = "긴 버프들"

HEALBOT_BALANCE = "조화"
HEALBOT_FERAL = "야성"
HEALBOT_RESTORATION = "회복"
HEALBOT_SHAMAN_RESTORATION = "복원"
HEALBOT_ARCANE = "비전"
HEALBOT_FIRE = "화염"
HEALBOT_FROST = "냉기"
HEALBOT_DISCIPLINE = "수양"
HEALBOT_HOLY = "신성"
HEALBOT_SHADOW = "암흑"
HEALBOT_ASSASSINATION = "암살"
HEALBOT_COMBAT = "전투"
HEALBOT_SUBTLETY = "잠행"
HEALBOT_ARMS = "무기"
HEALBOT_FURY = "분노"
HEALBOT_PROTECTION = "방어"
HEALBOT_BEASTMASTERY = "야수"
HEALBOT_MARKSMANSHIP = "사격"
HEALBOT_SURVIVAL = "생존"
HEALBOT_RETRIBUTION = "징벌"
HEALBOT_ELEMENTAL = "정기"
HEALBOT_ENHANCEMENT = "고양"
HEALBOT_AFFLICTION = "고통"
HEALBOT_DEMONOLOGY = "악마"
HEALBOT_DESTRUCTION = "파괴"
HEALBOT_BLOOD = "혈기"
HEALBOT_UNHOLY = "부정"

HEALBOT_OPTIONS_VISIBLERANGE = "거리 100미터 이상일 때 바 사용 안함"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG = "치유 메시지"
HEALBOT_OPTIONS_NOTIFY_MSG = "메시지"
HEALBOT_WORDS_YOU = "당신";
HEALBOT_NOTIFYHEALMSG = "#h을 위해 #n님에게 #s 시전을 시작합니다.";
HEALBOT_NOTIFYOTHERMSG ="#n님에게 #s 시전을 시작합니다.";

HEALBOT_OPTIONS_HOTPOSITION = "아이콘 위치"
HEALBOT_OPTIONS_HOTSHOWTEXT = "아이콘 문자 표시"
HEALBOT_OPTIONS_HOTTEXTCOUNT = "갯수"
HEALBOT_OPTIONS_HOTTEXTDURATION = "지속시간"
HEALBOT_OPTIONS_ICONSCALE = "아이콘 크기"
HEALBOT_OPTIONS_ICONTEXTSCALE = "아이콘 문자 크기"

HEALBOT_SKIN_FLUID = "Fluid"
HEALBOT_SKIN_VIVID = "Vivid"
HEALBOT_SKIN_LIGHT = "Light"
HEALBOT_SKIN_SQUARE = "Square"
HEALBOT_OPTIONS_AGGROBARSIZE = "어그로 바 크기"
HEALBOT_OPTIONS_TARGETBARMODE = "미리 지정한 대상 바의 설정 제한"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "이중 문자 라인"
HEALBOT_OPTIONS_TEXTALIGNMENT = "문자 정렬"
HEALBOT_OPTIONS_ENABLELIBQH = "libQuickHealth 사용"
HEALBOT_VEHICLE = "차량"
HEALBOT_OPTIONS_UNIQUESPEC = "각 특성별 고유 주문 저장"
HEALBOT_WORDS_ERROR = "오류"
HEALBOT_SPELL_NOT_FOUND = "주문을 찾을수 없음"
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "중투 상태시 툴팁 숨김"

HEALBOT_OPTIONS_BUFFNAMED = "볼 플레이어의 이름 입력\n\n"
HEALBOT_WORD_ALWAYS = "항상";
HEALBOT_WORD_SOLO = "솔로잉";
HEALBOT_WORD_NEVER = "표시 안함";
HEALBOT_SHOW_CLASS_AS_ICON = "아이콘";
HEALBOT_SHOW_CLASS_AS_TEXT = "문자";

HEALBOT_SHOW_INCHEALS = "들어오는 치유 표시";
HEALBOT_D_DURATION = "직접적인 지속시간";
HEALBOT_H_DURATION = "지속치유 지속시간";
HEALBOT_C_DURATION = "채널링 지속시간";

HEALBOT_OPTION_HIGHLIGHTACTIVEBAR = "마우스 오버 강조"
HEALBOT_OPTION_HIGHLIGHTTARGETBAR = "대상 강조"
HEALBOT_OPTIONS_TESTBARS = "테스트 바"
HEALBOT_OPTION_NUMBARS = "바 수"
HEALBOT_OPTION_NUMTANKS = "방어 담당 수"
HEALBOT_OPTION_NUMMYTARGETS = "나의 대상 수"
HEALBOT_OPTION_NUMPETS = "소환수 수"
HEALBOT_WORD_TEST = "테스트";
HEALBOT_WORD_OFF = "끔";
HEALBOT_WORD_ON = "켬";

HEALBOT_OPTIONS_TAB_PROTECTION = "보호"
HEALBOT_OPTIONS_TAB_CHAT = "대화"
HEALBOT_OPTIONS_TAB_HEADERS = "제목"
HEALBOT_OPTIONS_TAB_BARS = "바들"
HEALBOT_OPTIONS_TAB_ICONS = "아이콘들"
HEALBOT_OPTIONS_TAB_WARNING = "경고"
HEALBOT_OPTIONS_SKINDEFAULTFOR = "기본 스킨"
HEALBOT_OPTIONS_INCHEAL = "들어오는 치유"
HEALBOT_WORD_ARENA = "투기장"
HEALBOT_WORD_BATTLEGROUND = "전장"
HEALBOT_OPTIONS_TEXTOPTIONS = "문자 옵션"
HEALBOT_WORD_PARTY = "파티"
HEALBOT_OPTIONS_COMBOAUTOTARGET = "자동 대상"
HEALBOT_OPTIONS_COMBOAUTOTRINKET = "자동 장신구"
HEALBOT_OPTIONS_GROUPSPERCOLUMN = "컬럼 당 그룹 사용"

HEALBOT_OPTIONS_MAINSORT = "주 정렬"
HEALBOT_OPTIONS_SUBSORT = "보조 정렬"
HEALBOT_OPTIONS_SUBSORTINC = "다른 보조 정렬:"

HEALBOT_OPTIONS_BUTTONCASTMETHOD = "언제 시전"
HEALBOT_OPTIONS_BUTTONCASTPRESSED = "Pressed"
HEALBOT_OPTIONS_BUTTONCASTRELEASED = "Released"

HEALBOT_INFO_INCHEALINFO = "== Healbot Version Information =="
HEALBOT_INFO_ADDONCPUUSAGE = "== Addon CPU Usage in Seconds =="
HEALBOT_INFO_ADDONCOMMUSAGE = "== Addon Comms Usage =="
HEALBOT_WORD_HEALER = "Healer"
HEALBOT_WORD_VERSION = "Version"
HEALBOT_WORD_CLIENT = "Client"
HEALBOT_WORD_ADDON = "Addon"
HEALBOT_INFO_CPUSECS = "CPU Secs"
HEALBOT_INFO_MEMORYKB = "Memory KB"
HEALBOT_INFO_COMMS = "Comms KB"

HEALBOT_WORD_STAR = "별"
HEALBOT_WORD_CIRCLE = "동그라미"
HEALBOT_WORD_DIAMOND = "다이아몬드"
HEALBOT_WORD_TRIANGLE = "세모"
HEALBOT_WORD_MOON = "달"
HEALBOT_WORD_SQUARE = "네모"
HEALBOT_WORD_CROSS = "가위표"
HEALBOT_WORD_SKULL = "해골"

HEALBOT_OPTIONS_ACCEPTSKINMSG = "[HealBot] 스킨 수락: "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM = " from "
HEALBOT_OPTIONS_BUTTONSHARESKIN = "공유"

HEALBOT_CHAT_ADDONID = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1 = "A newer version is available"
HEALBOT_CHAT_NEWVERSION2 = "at http://www.healbot.info"
HEALBOT_CHAT_SHARESKINERR1 = " Skin not found for Sharing"
HEALBOT_CHAT_SHARESKINERR3 = " not found for Skin Sharing"
HEALBOT_CHAT_SHARESKINACPT = "Share Skin accepted from "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS = "Skins set to Defaults"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS = "Custom Debuffs reset"
HEALBOT_CHAT_CHANGESKINERR1 = "알 수 없는 스킨: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2 = "Valid 스킨:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY = "Current spells copied for all specs"
HEALBOT_CHAT_UNKNOWNCMD = "Unknown slash command: /hb "
HEALBOT_CHAT_ENABLED = "Entering enabled state"
HEALBOT_CHAT_DISABLED = "Entering disabled state"
HEALBOT_CHAT_SOFTRELOAD = "Reload healbot requested"
HEALBOT_CHAT_HARDRELOAD = "Reload UI requested"
HEALBOT_CHAT_CONFIRMSPELLRESET = "Spells have been reset"
HEALBOT_CHAT_CONFIRMCURESRESET = "Cures have been reset"
HEALBOT_CHAT_CONFIRMBUFFSRESET = "Buffs have been reset"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA = "Unable to receive all Skin settings - Possibly missing SharedMedia, see HealBot/Docs/readme.html for links"
HEALBOT_CHAT_MACROSOUNDON = "Sound not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROSOUNDOFF = "Sound suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERRORON = "Errors not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERROROFF = "Errors suppressed when using auto trinkets"
HEALBOT_CHAT_ACCEPTSKINON = "Share Skin - Show accept skin popup when someone shares a skin with you"
HEALBOT_CHAT_ACCEPTSKINOFF = "Share Skin - Always ignore share skins from everyone"
HEALBOT_CHAT_USE10ON = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
HEALBOT_CHAT_USE10OFF = "Auto Trinket - Use10 is off"
HEALBOT_CHAT_SKINREC = " skin received from "

HEALBOT_OPTIONS_SELFCASTS = "자신의 시전만"
HEALBOT_OPTIONS_HOTSHOWICON = "아이콘 표시"
HEALBOT_OPTIONS_ALLSPELLS = "모든 주문들"
HEALBOT_OPTIONS_DOUBLEROW = "두줄"
HEALBOT_OPTIONS_HOTBELOWBAR = "바 아래"
HEALBOT_OPTIONS_OTHERSPELLS = "기타 주문들"
HEALBOT_WORD_MACROS = "매크로"
HEALBOT_WORD_SELECT = "선택"
HEALBOT_OPTIONS_QUESTION = "?"
HEALBOT_WORD_CANCEL = "취소"
HEALBOT_WORD_COMMANDS = "명령"
HEALBOT_OPTIONS_BARHEALTH3 = "생명력";
HEALBOT_SORTBY_ROLE = "역할"
HEALBOT_WORD_DPS = "DPS"
HEALBOT_CHAT_TOPROLEERR = " role not valid in this context - use 'TANK', 'DPS' or 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE = "Highest top role is now "
HEALBOT_CHAT_SUBSORTPLAYER1 = "Player will be set to first in SubSort"
HEALBOT_CHAT_SUBSORTPLAYER2 = "Player will be sorted normally in SubSort"
HEALBOT_OPTIONS_SHOWREADYCHECK = "공격대 준비 표시";
HEALBOT_OPTIONS_SUBSORTSELFFIRST = "자신 첫째"
HEALBOT_WORD_FILTER = "필터"
HEALBOT_OPTION_AGGROPCTBAR = "바 이동"
HEALBOT_OPTION_AGGROPCTTXT = "문자 표시"
HEALBOT_OPTION_AGGROPCTTRACK = "백분율 추적"
HEALBOT_OPTIONS_ALERTAGGROLEVEL0 = "0 - has no threat and not tanking anything"
HEALBOT_OPTIONS_ALERTAGGROLEVEL1 = "1 - has threat and not tanking anything"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2 = "2 - insecurely tanking, not highest threat on mob"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3 = "3 - securely tanking at least one mob"
HEALBOT_OPTIONS_AGGROALERT = "어그로 경고 레벨"
HEALBOT_OPTIONS_TOOLTIPSHOWHOT = "활성화된 HOT 품질 모니터 표시"
HEALBOT_WORDS_MIN = "분"
HEALBOT_WORDS_MAX = "최대"
HEALBOT_WORDS_R = "R"
HEALBOT_WORDS_G = "G"
HEALBOT_WORDS_B = "B"
HEALBOT_CHAT_SELFPETSON = "자신의 소환수 켬"
HEALBOT_CHAT_SELFPETSOFF = "자신의 소환수 끔"
HEALBOT_WORD_PRIORITY = "우선 순위"
HEALBOT_VISIBLE_RANGE = "100미터 안"
HEALBOT_SPELL_RANGE = "주문 거리 안"
HEALBOT_CUSTOM_CATEGORY = "목록"
HEALBOT_CUSTOM_CAT_CUSTOM = "사용자"
HEALBOT_CUSTOM_CAT_CLASSIC = "직업"
HEALBOT_CUSTOM_CAT_TBC_OTHER = "TBC - 기타"
HEALBOT_CUSTOM_CAT_TBC_BT = "TBC - 검은 사원"
HEALBOT_CUSTOM_CAT_TBC_SUNWELL = "TBC - 태양샘"
HEALBOT_CUSTOM_CAT_LK_OTHER = "WotLK - 기타"
HEALBOT_CUSTOM_CAT_LK_ULDUAR = "WotLK - 울두아르"
HEALBOT_CUSTOM_CAT_LK_TOC = "WotLK - 십자군의 시험장"
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER = "WotLK - ICC 하부 첨탑"
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS = "WotLK - ICC 역병 작업장"
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON = "WotLK - ICC 진홍빛 전당"
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING = "WotLK - ICC 서리날개 전당"
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE = "WotLK - ICC 얼어붙은 왕좌"
HEALBOT_CUSTOM_CAT_LK_RS_THRONE = "WotLK - 루비 성소"
HEALBOT_CUSTOM_CAT_CATA_OTHER = "Cata - 기타"
HEALBOT_CUSTOM_CAT_CATA_PARTY = "Cata - 파티"
HEALBOT_CUSTOM_CAT_CATA_RAID = "Cata - 공격대"
HEALBOT_WORD_RESET = "초기화"
HEALBOT_HBMENU = "HB 메뉴"
HEALBOT_ACTION_HBFOCUS = "왼쪽 클릭시\n주시 대상 설정"
HEALBOT_WORD_CLEAR = "제거"
HEALBOT_WORD_SET = "세트"
HEALBOT_WORD_HBFOCUS = "HealBot 주시"
HEALBOT_WORD_OUTSIDE = "외부"
HEALBOT_WORD_ALLZONE = "모든 지역"
HEALBOT_WORD_OTHER = "기타"
HEALBOT_OPTIONS_TAB_ALERT = "경고"
HEALBOT_OPTIONS_TAB_SORT = "종류"
HEALBOT_OPTIONS_TAB_AGGRO = "어그로"
HEALBOT_OPTIONS_TAB_ICONTEXT = "아이콘 문자"
HEALBOT_OPTIONS_TAB_TEXT = "바 문자"
HEALBOT_OPTIONS_AGGROBARCOLS = "어그로 바 색상";
HEALBOT_OPTIONS_AGGRO1COL = "위협 수준\n높음"
HEALBOT_OPTIONS_AGGRO2COL = "위험한\n탱킹"
HEALBOT_OPTIONS_AGGRO3COL = "안전한\n탱킹"
HEALBOT_OPTIONS_AGGROFLASHFREQ = "반짝임 빈도"
HEALBOT_OPTIONS_AGGROFLASHALPHA = "투명도 빈도"
HEALBOT_OPTIONS_SHOWDURATIONFROM = "지속시간 표시"
HEALBOT_OPTIONS_SHOWDURATIONWARN = "지속시간 만료 경고"
HEALBOT_CMD_RESETCUSTOMDEBUFFS = "사용자 디버프들 초기화"
HEALBOT_CMD_RESETSKINS = "스킨 초기화"
HEALBOT_CMD_CLEARBLACKLIST = "블랙리스트 제거"
HEALBOT_CMD_TOGGLEACCEPTSKINS = "다른 스킨 수락 토글"
HEALBOT_CMD_COPYSPELLS = "현재 주문 모든 특성에 복사"
HEALBOT_CMD_RESETSPELLS = "주문들 초기화"
HEALBOT_CMD_RESETCURES = "치료 초기화"
HEALBOT_CMD_RESETBUFFS = "버프들 초기화"
HEALBOT_CMD_RESETBARS = "바 위치 초기화"
HEALBOT_CMD_SUPPRESSSOUND = "자동 장신구 사용 효과음 억제 토글"
HEALBOT_CMD_SUPPRESSERRORS = "자동 장신구 사용 오류 억제토글"
HEALBOT_OPTIONS_COMMANDS = "HealBot 명령어"
HEALBOT_WORD_RUN = "실행"
HEALBOT_OPTIONS_MOUSEWHEEL = "마우스 휠 메뉴"
HEALBOT_CMD_DELCUSTOMDEBUFF10 = "우선 순위 10개의 사용자 디버프들 삭제"
HEALBOT_ACCEPTSKINS = "기타 스킨 수락"
HEALBOT_SUPPRESSSOUND = "자동 장신구: 효과음 억제"
HEALBOT_SUPPRESSERROR = "자동 장신구: 오류 억제"
HEALBOT_OPTIONS_CRASHPROT = "충돌 보호"
HEALBOT_CP_MACRO_LEN = "매크로 이름은 1~14 글자 사이여야 합니다."
HEALBOT_CP_MACRO_BASE = "기본 매크로 이름"
HEALBOT_CP_MACRO_SAVE = "마지막 저장: "
HEALBOT_CP_STARTTIME = "로그인시 지속시간 보호"
HEALBOT_WORD_RESERVED = "예약"
HEALBOT_OPTIONS_COMBATPROT = "전투 보호"
HEALBOT_COMBATPROT_PARTYNO = "파티 대비 예약 바"
HEALBOT_COMBATPROT_RAIDNO = "공격대 대비 예약 바"

HEALBOT_WORD_HEALTH = "생명력"
HEALBOT_OPTIONS_DONT_SHOW = "표시 안함"
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT = "생명력과 같이 (현재 생명력)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE = "생명력과 같이 (향후 생명력)"
HEALBOT_OPTIONS_FUTURE_HLTH = "향후 생명력"
HEALBOT_SKIN_HEALTHBARCOL_TEXT = "생명력 바 색상";
HEALBOT_SKIN_INCHEALBARCOL_TEXT = "들어오는 치유 색상";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET = "대상: 항상 표시"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS = "주시: 항상 표시"
HEALBOT_OPTIONS_USEGAMETOOLTIP = "게임 툴팁 사용"

end