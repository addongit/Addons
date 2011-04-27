-- localization for frFR - UTF-8

-- French translation by J¯sie on the Les Sentinelles European server
-- http://frost.taguilde.net

-- Updated translation and error fixes thanks to Fenron EU-Hyjal!

local L	= JSHB.locale

if GetLocale() == "frFR" then

    L.greeting1               	= "JS' Hunter Bar "
    L.greeting2               	= " chargé, /jsb pour l'aide."
    L.tranqremoved				= "Tir tranquillisant retiré"
    L.tranqfrom               	= " de "
	L.mdcaston 					= " cast on "
	L.mdfinished				= " finished."
	L.mdtargetmounted			= " can not be cast on you when mounted!"
	L.mdaggroto					= " is transferring threat to You!"
	L.mdaggrotoover				= " threat transfer complete."
    L.slashdesc1              	= "JS' Hunter Bar "
    L.slashdesc2              	= "Ouvrir configuration"
    L.slashdesc3              	= "Verrouiller ou déverrouiller la barre"
    L.slashdesc4              	= "Réinitialiser la position de la barre"
    L.invalidoption           	= "Option invalide."
    L.nowlocked               	= "JS' Hunter Bar est verrouillée, '/jsb lock' pour la deverouillée."
    L.nowunlocked             	= "JS' Hunter Bar est déverrouillé, '/jsb lock' pour la re-verrouillée."
    L.loderror					= "JSHB: Options Load on Demand Error!"
    L.lodsuccessful				= "JSHB: Options Loaded"
    L.postop                	= "HAUT"
    L.posbottom               	= "BAS"
    L.posabove                	= "DESSUS"
    L.posbelow                	= "DESSOUS"
    L.poscenter               	= "CENTRE"
    L.posleft                	= "GAUCHE"
    L.posright                	= "DROITE"
    L.postopbottom            	= "HAUT/BAS"
    L.posmovable				= "MOVABLE"

    -- Chat channels
    L.chan_auto 			= "Automatique"
    L.chan_selfwhisper		= "Whisper Self"
    L.chan_raid 			= "RAID"
    L.chan_yell 			= "CRIER"
    L.chan_officer			= "OFFICIER"
    L.chan_guild			= "GUILDE"
    L.chan_battleground		= "CHAMP DE BATAILLE"
    L.chan_party			= "GROUPE"
    L.chan_emote			= "EMOTE"
    L.chan_say				= "DIRE"

    -- Options - misc stuff
    L.confirmdelete1        = "Effacer ceci "
    L.confirmdelete2        = " timer?"
	L.confirmdelete3		= " spell?"
    L.deletebutton          = "Effacer"
    L.editbutton            = "Editer"
    L.spelltextdurfor       = "Durée"
    L.spelltextcdfor        = "Temps de recharge"
    L.spelltextplayer       = " (Joueur)"
    L.spelltexttarget       = " (Cible)"
	L.spelltextpet			= "Pet"
    L.dur                   = "Durée"
    L.cd                    = "Temps de recharge"
    L.durorcd               = "Durée ou temps de recharge?"
    L.pickplayerortarget    = "Joueur ou Cible ?"
    L.pickLocation          = "Position ?"
    L.pickSpell             = "Capacité ou Objet"
    L.pickOffset			= "Position of this icon: %d"
    L.savebutton1           = "MAJ"
    L.savebutton2           = "Ajouter"
    L.nottracking           = "Vous ne surveillez rien "
    L.currentlytracking1    = "Vous surveillez en "
    L.currentlytracking2    = " %d timers:"
    L.buttonaddtimer        = "Ajouter un Timer"
    L.movetranqalert		= "Alerte\nTir tranquilisant"
	L.movetranqables		= "Tranq-able Debuffs"
    L.movemarkreminder		= "Hunter's Mark\nReminder"
    L.movecctimers			= "Crowd Control\nTimers"
    L.movedebuffalert		= "Debuff\nAlert"
    L.moveicontimers		= "Icon Timers"
	L.moveindicator			= "Indicator Bar"
    L.tranq 				= "Tranq!"
	L.petspell				= "pet"
	L.playerspell			= "player"
	L.nocustomspells		= "You have no custom spells defined."
	L.customspellsdefined	= "You have the following %d custom spell(s) defined:"
	L.buttonaddspell		= "Add Spell"
	L.addspelltext1			= "Enter the spell ID that you want to add.\n\nNOTE: Invalid IDs will not be added."
	L.invalidspellid		= "INVALID SPELL ID"

    -- Options - main
    L.enablebarlock 		= "Verouiller la barre"

    -- Options - general
    L.namegeneral             	= "Général"
    L.enablestackbars 			= "Display bars to indicate stacks for spec abilities"
    L.movestackbarstotop		= "Move the stack bars to the top (instead of the bottom)"
    L.enableautoshotbar         = "Barre du Tir Automatique"
    L.enableautoshottext        = "Timer du Tir Automatique"
    L.enablemaintick            = "Montrer la focalisation minimale nécessaire au tir principal"
    L.enablehuntersmarkwarning	= "Icone d'avertissement de la Marque du chasseur"
    L.enabletranqannounce       = "Notifier les dissipations du Tir tranquillisant "
    L.tranqannouncechannel		= "Canal de notification"
    L.enabletranqalert 			= "Activer l'alerte du Tir tranquilisant"
    L.enablecctimers            = "Timers de Piège givrant et Piqûre de wyverne"
    L.enableprediction          = "Prévision de la focalisation rendue par Tir assuré et Tir du cobra"
    L.enabletimers             	= "Activer les timers et temps de recharge"
    L.timerfontposition         = "Position du texte:"
    L.enabletimerstext          = "Afficher le texte des timers et des temps de recharge"
    L.enabletimertenths         = "Afficher les dixièmes de secondes quand les timers sont < à 10s"
    L.enabledebuffalert			= "Enable debuff icons for important debuffs"
    L.enabletargethealthpercent	= "Show your target's health percentage on bar"
    L.timericonanchorparent		= "Icon timers anchor point"
    L.timertextcoloredbytime	= "Color timer's text based on time remaining"
	L.enablecurrentfocustext	= "Enable text representation of current focus on bar"
	L.enabletranqablesframe		= "Enable frame to show tranq-able buffs on target"
	L.enabletranqablestips		= "Show hover-over tips for tranqable buffs (non-click through)"

    -- Options - style & size
    L.namestylesize            	= "Style & Taille"
    L.classcolored             	= "Couleur liée à la classe pour la barre de focalisation\n    Décocher pour utiliser les couleurs définies ci-dessous"
    L.classcoloredprediction    = "Couleur liée à la classe pour la barre de prévision\n    Décocher pour utiliser les couleurs définies ci-dessous"
    L.enabletukui             	= "Tukui skin pour la barre, la marque du chasseur et l'icone de cc"
    L.enabletukuitimers         = "Tukui skin pour l'icone du timer"
    L.enablehighcolorwarning    = "Changer la couleur de la barre de focalisation\n si vous arrivez proche de son maximum"
    L.focushighthreshold        = "Seuil: %d%%"
    L.focuscenteroffset			= "Focus number offset from center: %d"
    L.barwidth                 	= "Largeur de la barre: %dpx"
    L.barheight                 = "Hauteur de la barre: %dpx"
    L.iconsize                	= "Taille de l'icone de timer: %dpx"
    L.cciconsize                = "Taille de l'icone de Controle de foule: %dpx"
    L.markiconsize             	= "Taille de l'icone de la Marque du Chasseur: %dpx"
    L.taiconsize 				= "Taille de l'icone d'avertissement du Tir tranquilisant : %dpx"
	L.tranqablesiconsize		= "Tranq-able debuffs icon size: %dpx"
    L.icontimerssize			= "Icon Timers icon size: %dpx"
    L.icontimersgap				= "Icon Timers gap between left and right: %dpx"
    L.debufficonsize			= "Debuff Alert icon size: %dpx"
    L.alphabackdrop             = "Bar backdrop Alpha: %d%%"
    L.alphazeroooc             	= "Hors combat aucun focus Alpha: %d%%"
    L.alphamaxooc             	= "Hors combat pleine Alpha: %d%%"
    L.alphanormooc             	= "Hors combat gagnant du focus Alpha: %d%%"
    L.alphazero                 = "En combat aucun focus Alpha: %d%%"
    L.alphamax                 	= "En combat pleine Alpha: %d%%"
    L.alphanorm                 = "En combat focus Alpha: %d%%"
    L.alphaicontimersfaded 		= "Icon timers faded Alpha: %d%%"

    -- Options - fonts & textures
    L.namefontstextures         = "Polices et Textures"
    L.barfont                 	= "Police :"
    L.timerfont                 = "Police des timers:"
    L.bartexture                = "Texture de la barre:"
    L.fontoutlined             	= "Contour des chiffres de la barre de focalisation"
    L.fontsize                 	= "Taille de la police de la barre de focalisation: %dpx"
    L.fontsizetimers            = "Taille de la police des timers des icones: %dpx"

    -- Options - Colors
    L.namecolors                	= "Couleur"
    L.barcolor                		= "Barre de focalisation normale"
    L.barcolorwarninglow            = "Signal de focalisation basse"
    L.barcolorwarninghigh         	= "Signal de focalisation haute"
    L.autoshotbarcolor             	= "Barre de tir automatique"
    L.predictionbarcolor            = "Barre de prévision"
    L.predictionbarcolorwarninghigh	= "Signal de la barre de prévision"
	
	-- Options - Indicator Bar
	L.nameindicator					= "Indicator Bar"
	L.enableindicator				= "Enable the indicator bar"
	L.indicatoriconsize				= "Indicator bar's icons size: %dpx"

    -- Options - specs
    L.namebm 				= "Maîtrise des bêtes"
    L.namemm 				= "Précision"
    L.namesv 				= "Survie"

	-- Options - Misdirection
	L.namemd				= "Misdirection"
	L.mdoptiontext1			= "NOTE: With Blizzard default frames unit frames, you need to use a modifier with Right click to use the default menu.\n\nFor example: SHIFT or CTRL or ALT + Right Click"
	L.enablerightclickmd	= "Enable right click misdirection on specified unit frames"
	L.enablemdonpet			= "Enable for Player's pet frame"
	L.enablemdonparty		= "Enable for Party frames"
	L.enablemdonraid		= "Enable for Raid frames"
	L.enablemdcastannounce	= "Misdirection cast notification to chat"
	L.enablemdoverannounce	= "Misdirection expire/used notification to chat"
	L.enablemdtargetwhisper	= "Whisper Misdirection target when aggro is transferring and finished"
	L.mdannouncechannel		= "Chat channel"
	
	-- Options - Custom Spells
	L.namecustomspell		= "Custom Spells"
	
	-- Options - Custom Tranqs
	L.namecustomtranq		= "Custom Tranqs"

	-- Options - Custom Auras
	L.namecustomaura		= "Custom Auras"

end
