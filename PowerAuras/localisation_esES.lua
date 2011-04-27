if (GetLocale() == "esES") then

PowaAuras.Anim[0] = "[Invisible]";
PowaAuras.Anim[1] = "Estático";
PowaAuras.Anim[2] = "Brillante";
PowaAuras.Anim[3] = "Aumento";
PowaAuras.Anim[4] = "Pulsación";
PowaAuras.Anim[5] = "Burbujeo";
PowaAuras.Anim[6] = "Gota";
PowaAuras.Anim[7] = "Electrico";
PowaAuras.Anim[8] = "Contracción";
PowaAuras.Anim[9] = "Llama";
PowaAuras.Anim[10] = "Orbita";
PowaAuras.Anim[11] = "Giro horario";
PowaAuras.Anim[12] = "Giro antihorario";

PowaAuras.BeginAnimDisplay[0] = "[Nada]";
PowaAuras.BeginAnimDisplay[1] = "Zoom";
PowaAuras.BeginAnimDisplay[2] = "Zoom fuera";
PowaAuras.BeginAnimDisplay[3] = "Desaparecer";
PowaAuras.BeginAnimDisplay[4] = "Izquierda";
PowaAuras.BeginAnimDisplay[5] = "Arriba-izquierda";
PowaAuras.BeginAnimDisplay[6] = "Arriba";
PowaAuras.BeginAnimDisplay[7] = "Arriba-derecha";
PowaAuras.BeginAnimDisplay[8] = "Derecha";
PowaAuras.BeginAnimDisplay[9] = "Abajo-derecha";
PowaAuras.BeginAnimDisplay[10] = "Abajo";
PowaAuras.BeginAnimDisplay[11] = "Abajo-Izquierda";
PowaAuras.BeginAnimDisplay[12] = "Rebote";

PowaAuras.EndAnimDisplay[0] = "[Nada]";
PowaAuras.EndAnimDisplay[1] = "Aumentar";
PowaAuras.EndAnimDisplay[2] = "Encoger";
PowaAuras.EndAnimDisplay[3] = "Desaparecer";
PowaAuras.EndAnimDisplay[4] = "Girar";
PowaAuras.EndAnimDisplay[5] = "Girar adentro";

PowaAuras.Sound[0] = NONE;
PowaAuras.Sound[30] = NONE;

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "Teclea /powa para ver las opciones",

	aucune = "Nada",
	aucun = "Nada",
	largeur = "Ancho",
	hauteur = "Alto",
	mainHand = "Principal",
	offHand = "Secundaria",
	bothHands = "Ambas",

	Unknown	 = "Desconocido",

	DebuffType =
	{
		Magic   = "Magia",
		Disease = "Enfermedad",
		Curse   = "Maldición",
		Poison  = "Veneno",
		-- Non standard types below here.
		Enrage  = "Enrage",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC]      = "CC",
		[PowaAuras.DebuffCatType.Silence] = "Silenciado",
		[PowaAuras.DebuffCatType.Snare]   = "Dormido",
		[PowaAuras.DebuffCatType.Stun]    = "Aturdido",
		[PowaAuras.DebuffCatType.Root]    = "Enraizado",
		[PowaAuras.DebuffCatType.Disarm]  = "Desarmado",
		[PowaAuras.DebuffCatType.PvE]     = "PvE",
	},
	
	Role =
	{
		RoleTank     = "Tanque",
		RoleHealer   = "Curador",
		RoleMeleDps  = "DPS cuerpo a cuerpo",
		RoleRangeDps = "DPS a distancia",
	},
	
	nomReasonRole =
	{
		RoleTank     = "Es tanque",
		RoleHealer   = "Es curador",
		RoleMeleDps  = "Es DPS cuerpo a cuerpo",
		RoleRangeDps = "Es DPS a distancia",
	},

	nomReasonNotRole =
	{
		RoleTank     = "No es tanque",
		RoleHealer   = "No es curador",
		RoleMeleDps  = "No es DPS cuerpo a cuerpo",
		RoleRangeDps = "No es DPS a distancia",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "Bufo",
		[PowaAuras.BuffTypes.Debuff] = "Debufo",
		[PowaAuras.BuffTypes.AoE] = "Debufo en AoE",
		[PowaAuras.BuffTypes.TypeDebuff] = "Debufo (tipo)",
		[PowaAuras.BuffTypes.Enchant] = "Encantamiento de arma",
		[PowaAuras.BuffTypes.Combo] = "Puntos de combo",
		[PowaAuras.BuffTypes.ActionReady] = "Acción disponible",
		[PowaAuras.BuffTypes.Health] = "Vida",
		[PowaAuras.BuffTypes.Mana] = "Maná",
		[PowaAuras.BuffTypes.EnergyRagePower] = "Ira/Energía/Poder",
		[PowaAuras.BuffTypes.Aggro] = "Aggro",
		[PowaAuras.BuffTypes.PvP] = "PvP",
		[PowaAuras.BuffTypes.Stance] = "Actitud",
		[PowaAuras.BuffTypes.SpellAlert] = "Alerta de hechizo", 
		[PowaAuras.BuffTypes.SpellCooldown] = "CD de hechizo", 
		[PowaAuras.BuffTypes.StealableSpell] = "Hechizo para robar",
		[PowaAuras.BuffTypes.PurgeableSpell] = "Hechizo purgable",
		[PowaAuras.BuffTypes.Static] = "Aura estática",
		[PowaAuras.BuffTypes.Totems] = "Tótems",
		[PowaAuras.BuffTypes.Pet] = "Mascota",
		[PowaAuras.BuffTypes.Runes] = "Runas",
		[PowaAuras.BuffTypes.Slots] = "Ranuras de equipamiento",
		[PowaAuras.BuffTypes.Items] = "Nombre de objetos",
		[PowaAuras.BuffTypes.Tracking] = "Rastreo",
		[PowaAuras.BuffTypes.TypeBuff] = "Bufo (tipo)",
		[PowaAuras.BuffTypes.UnitMatch] = "Unit Match",
		[PowaAuras.BuffTypes.GTFO] = "Alerta ¡Muévete!",
	},
	
	PowerType =
	{
		[-1] = "Por defecto",
		[SPELL_POWER_RAGE] = "Ira",
		[SPELL_POWER_FOCUS] = "Enfoque",
		[SPELL_POWER_ENERGY] = "Energía",
		[SPELL_POWER_RUNIC_POWER] = "Poder rúnico",
		[SPELL_POWER_SOUL_SHARDS] = "Fragmentos de alma",
		[SPELL_POWER_LUNAR_ECLIPSE] = "Eclipse lunar",
		[SPELL_POWER_SOLAR_ECLIPSE] = "Eclipse solar",
		[SPELL_POWER_HOLY_POWER] = "Poder sagrado",
	},
	
	Relative = 
	{
		NONE        = "Libre", 
		TOPLEFT     = "Arriba-Izquierda", 
		TOP         = "Arriba", 
		TOPRIGHT    = "Arriba-Derecha", 
		RIGHT       = "Derecha", 
		BOTTOMRIGHT = "Abajo-Derecha", 
		BOTTOM      = "Abajo", 
		BOTTOMLEFT  = "Abajo-Izquierda", 
		LEFT        = "Izquierda", 
		CENTER      = "Centro",
	},
	
	Slots =
	{
		Ammo = "Munición",
		Back = "Espalda",
		Chest = "Pecho",
		Feet = "Pies",
		Finger0 = "Dedo1",
		Finger1 = "Dedo2",
		Hands = "Manos",
		Head = "Cabeza",
		Legs = "Piernas",
		MainHand = "Mano derecha",
		Neck = "Cuello",
		Ranged = "A distancia",
		SecondaryHand = "Mano izquierda",
		Shirt = "Camisa",
		Shoulder = "Hombros",
		Tabard = "Tabardo",
		Trinket0 = "Abalorio1",
		Trinket1 = "Abalorio2",
		Waist = "Cintura",
		Wrist = "Muñeca",	
	},

	-- Main
	nomEnable = "Activar Power Auras",
	aideEnable = "Permitir todos los efectos de Power Auras",

	nomDebug = "Activar mensajes de depuración",
	aideDebug = "Permitir mensajes de depuración",
	nomTextureCount = "Texturas máximas",
	aideTextureCount = "Cambia esto si añades tus propias texturas",

	aideOverrideTextureCount = "Sobrepasa número de texturas",
	nomOverrideTextureCount= "Activa esto si vas a añadir tus propias texturas",

	ListePlayer = "Página",
	ListeGlobal = "Global",
	aideMove = "Mover el aura aquí",
	aideCopy = "Copiar el aura aquí.",
	nomRename = "Renombrar",
	aideRename = "Renombrar la página de efectos seleccionada",

	nomTest = "Mostrar",
	nomTestAll = "Mostrar todos",
	nomHide = "Esconder todos",
	nomEdit = "Editar",
	nomNew = "Nuevo",
	nomDel = "Borrar",
	nomImport = "Importar", 
	nomExport = "Exportar", 
	nomImportSet = "Importar bloque", 
	nomExportSet = "Exportar bloque", 
	nomUnlock = "Desbloquear",
	nomLock = "Bloquear",

	aideImport = "Presiona Ctrl-V para pegar el código de aura y presiona \'Aceptar\'",
	aideExport = "Presiona Ctrl-C para copiar el código de aura para compartir",
	aideImportSet = "Presiona Ctrl-V para pegar el código de aura y presiona \'Aceptar\' esto borrará todas las auras en esta página",
	aideExportSet = "Presiona Ctrl-C para copiar todas las auras de esta página para compartir",
	aideDel = "Borra el aura seleccionada (mantén CTRL presionado para que el botón funcione)",

	nomMove = "Mover",
	nomCopy = "Copiar",
	nomPlayerEffects = "Auras del personaje",
	nomGlobalEffects = "Auras globales",

	aideEffectTooltip = "(Shift-Click para activar/desactivar un aura)",
	aideEffectTooltip2 = "(CTRL-Click para comprobación de funcionamiento)",

	aideItems = "Introduce el nombre completo del objeto o [xxx] para su ID",
	aideSlots = "Introduce el nombre de la ranura a rastrear: Munición, Espalda, Pecho, Pies, Dedo1, Dedo2, Manos, Cabeza, Piernas, Mano derecha, Collar, A distancia, Mano izquierda, Camisa, Hombros, Tabardo, Abalorio1, Abalorio2, Cintura, Muñeca",
	aideTracking = "Introduce el nombre del tipo de rastreo ej. pescado",

	-- editor
	aideCustomText = "Introduce texto para mostrar (%t=nombre del objetivo, %f=nombre del foco, %v=valor de visualización, %u=nombre de la unidad, %str=fuerza, agl=agilidad, %sta=aguante, %int=intelecto, %sp1=espíritu, %sp=poder con hechizos, %ap=poder de ataque, %df=defensa)",

	nomSoundStarting = "Sonido inicial",
	nomSound = "Sonido para reproducir",
	nomSound2 = "Más sonidos para reproducir",
	aideSound = "Reproduce un sonido al inicio",
	aideSound2 = "Reproduce un sonido al inicio",
	nomCustomSound = "O archivo de sonido",
	aideCustomSound = "Introduce un archivo de sonido que esté en la carpeta de sonidos, ANTES de iniciar el juego. Mp3 y wav son compatibles. Ej: 'cookie.mp3'; o introduce la ruta completa para reproducir cualquier sonido del WoW ej: Sound\\Events\\GuldanCheers.wav",

	nomCustomSoundPath = "Ruta sonidos personalizados:",
	aideCustomSoundPath = "Publica tu propia ruta (within the WoW install) para evitar sobreescribirlos al actualizar Power Auras",

	nomCustomAuraPath = "Ruta texturas personalizados:",
	aideCustomAuraPath = "Publica tu propia ruta (within the WoW install) para evitar sobreescribirlas al actualizar Power Auras",

	nomSoundEnding = "Sonido final:",
	nomSoundEnd = "Sonido para reproducir",
	nomSound2End = "Más sonidos para reproducir",
	aideSoundEnd = "Reproduce un sonido al final",
	aideSound2End = "Reproduce un sonido al final",
	nomCustomSoundEnd = "O archivo de sonido",
	aideCustomSoundEnd = "Introduce un archivo de sonido que esté en la carpeta de sonidos, ANTES de iniciar el juego. Mp3 y wav son compatibles. Ej: 'cookie.mp3'; o introduce la ruta completa para reproducir cualquier sonido del WoW ej: Sound\\Events\\GuldanCheers.wav",
	nomTexture = "Textura",
	aideTexture = "Textura para mostrar. Puedes cambiar las texturas facilmente cambiando el archivo Aura#.tga en la carpeta Addons",

	nomAnim1 = "Animación principal",
	nomAnim2 = "Animación secundaria",
	aideAnim1 = "Anima la textura o no, con varios efectos",
	aideAnim2 = "Esta animación se mostrará con menos opacidad que la principal. Cuidado con no sobrecargar la pantalla",

	nomDeform = "Deformación",
	aideDeform = "Estira la textura a lo alto o largo",

	aideColor = "Click aquí para cambiar el color de la textura",
	aideTimerColor = "Click aquí para cambiar el color del reloj",
	aideStacksColor = "Click aquí para cambiar el color de las acumulaciones",
	aideFont = "Click aquí para elegir la fuente. Presiona OK para aplicar",
	aideMultiID = "Introduce aquí IDs de otras auras para combinar comprobaciones. Varias IDs deben separarse con '/'. El ID del aura puede verse como [#] en la primera línea de la descripción del aura", 
	aideTooltipCheck = "Comprueba también que la descripción contiene este texto",

	aideBuff = "Introduce aquí el nombre del bufo, o una parte del nombre, que debe activar/desactivar el aura. Puedes introducir varios nombres (ej: Super Bufo/Poder)",
	aideBuff2 = "Introduce aquí el nombre del debufo, o una parte del nombre, que debe activar/desactivar el aura. Puedes introducir varios nombres (ex: Dark Disease/Plague)",
	aideBuff3 = "Introduce aquí el tipo de debufoque debe activar o desactivar el aura (Veneno, Enfermedad, Maldición, Magia, CC, Silenciado, Aturdido, Dormido, Enraizado o nada). Puedes introducir varios tipos (ej: enfermedad/veneno)",
	aideBuff4 = "Introduce aquí el nombre del AoE que debe activar el aura (lluvia de fuego por ejemplo, el nombre del AOE puede verse en el registro de combate)",
	aideBuff5 = "Introduce aquí el encantamiento temporal que debe activar el aura: como opción precédelo con 'main/' o 'off/ para designar ranura de mano derecha o izquierda (ej: main/mangosta)",
	aideBuff6 = "Introduce aquí el número de puntos de combo que deben activar el aura (ej: 1 o 1/2/3 o 0/4/5 etc...) ",
	aideBuff7 = "Introduce aquí el nombre, o una parte del nombre, de una habilidad en tus barras de acción. Este aura estará activa cuando esa habilidad se pueda utilizar",
	aideBuff8 = "Introduce aquí el nombre, o una parte del nombre, de una habilidad de tu libro de hechizos. Puedes introducir una ID de habilidad [12345]",
	
	aideSpells = "Introduce aquí el nombre de la habilidad que activará un aura de alerta de hechizo",
	aideStacks = "Introduce aquí el símbolo y la cantidad de acumulaciones requiridas para activar/desactivar el aura. Requerido símbolo ej: '<5' '>3' '=11' '!5' '>=0' '<=6' '2-8'",

	aideStealableSpells = "Introduce aquí el nombre del hechizo para robar que activará el aura (usa * para cualquier hechizo para robar)", 
	aidePurgeableSpells = "Introduce aquí el nombre del hechizo purgable que activará el aura (usa * para cualquier hechizo purgable)", 

	aideTotems = "Introduce aquí el nombre del tótem que activará el aura o su número 1=fuego, 2=tierra, 3=agua, 4=aire (usa * para cualquier tótem)", 

	aideRunes = "Introduce aquí las runas que activarán el aura B/b=sangre, F/f=escarcha, U/u=profana, D/d=muerte (las runas de muerte contarán como las de otro tipo si usas las casillas de ignorar mayúsculas/minúsculas) ex: 'BF' 'BfU' 'DDD'", 

	aideUnitn = "Introduce aquí el nombre de la unidad, que debe activar/desactivar el aura. Puedes introducir sólo nombres, si están en tu banda/grupo",
	aideUnitn2 = "Sólo para banda/grupo",

	aideMaxTex = "Define el número máximo de texturas en el editor. Si añades texturas en la carpeta Mod (con los nombres AURA1.tga a AURA50.tga), debes indicar el número correcto aquí",
	aideWowTextures = "Activa esto para usar texturas de WoW en lugar de las texturas en la carpeta de Power Auras para este aura",
	aideTextAura = "Activa esto para poner texto en lugar de textura",
	aideRealaura = "Aura auténtica",
	aideCustomTextures = "Activa esto para usar texturas de  la subcarpeta 'Custom'. Introduce el nombre de la textura debajo (ej: miTextura.tga). Puedes usar un nombre de habilidad (ej: lluvia de fuego) o ID de habilidad (ej: 5384)",
	aideRandomColor = "Activa esto para que este aura use color aleatorio cada vez que se active",

	aideTexMode = "Desactiva esto para usar la opacidad de la textura. Por defecto, los colores más oscuros serán más transparentes",

	nomActivationBy = "Activado por",

	nomOwnTex = "Usar textura propia",
	aideOwnTex = "Usar la textura del bufo/debufo o habilidad",
	nomStacks = "Acumulaciones",

	nomUpdateSpeed = "Velocidad de actualización",
	nomSpeed = "Velocidad de animación",
	nomTimerUpdate = "Velocidad de actualización del reloj",
	nomBegin = "Iniciar animación",
	nomEnd = "Finalizar animación",
	nomSymetrie = "Simetría",
	nomAlpha = "Opacidad",
	nomPos = "Posición",
	nomTaille = "Tamaño",

	nomExact = "Nombre exacto",
	nomThreshold = "Umbral",
	aideThreshInv = "Activa esto para invertir la lógica del umbral. Desactivado = poca alerta / Activado = mucha alerta.",
	nomThreshInv = "</>",
	nomStance = "Actitud",
	nomGTFO = "Tipo de alerta",
	nomPowerType = "Tipo de poder",

	nomMine = "Lanzado por mí",
	aideMine = "Activa esto para mostrar sólo bufos/debufos lanzados por el jugador",
	nomDispellable = "Puedo disipar",
	aideDispellable = "Activa esto para mostrar sólo bufos que son disipables",
	nomCanInterrupt = "Puede interrumpirse",
	aideCanInterrupt = "Activa esto para mostrar sólo hechizos que pueden interrumpirse",
	nomIgnoreUseable = "Reutilización sólo",
	aideIgnoreUseable = "Ignora si la habilidad se puede usar (sólo usa el CD)",
	nomIgnoreItemUseable = "Sólo si equipado",
	aideIgnoreItemUseable = "Ignora si el objeto se puede utilizar (sólo si está equipado)",
	nomCheckPet = "Mascota",
	aideCheckPet = "Marca para monitorizar sólo habilidades de mascota",

	nomOnMe = "Lanzado en mí",
	aideOnMe = "Mostrar sólo si se lanza en mí",

	nomPlayerSpell = "Jugador lanzando",
	aidePlayerSpell = "Comprobar si el jugador esta lanzando un hechizo",

	nomCheckTarget = "Objetivo enemigo",
	nomCheckFriend = "Objetivo amistoso",
	nomCheckParty = "Miembro de grupo",
	nomCheckFocus = "Foco",
	nomCheckRaid = "Miembro de banda",
	nomCheckGroupOrSelf = "Banda/grupo o yo",
	nomCheckGroupAny = "Cualquiera", 
	nomCheckOptunitn = "Nombre de unidad",

	aideTarget = "Activa esto para comprobar sólo al objetivo enemigo",
	aideTargetFriend = "Activa esto para comprobar sólo al objetivo amistoso.",
	aideParty = "Activa esto para comprobar sólo a miembros del grupo",
	aideGroupOrSelf = "Activa esto para comprobar a miembros del grupo/banda o a tí mismo",
	aideFocus = "Activa esto para comprobar sólo al foco",
	aideRaid = "Activa esto para comprobar sólo a miembros de banda",
	aideGroupAny = "Activa esto para comprobar bufos en 'Cualquier' miembro del grupo/banda. Desactivado: comprueba que 'Todos' estén bufados",
	aideOptunitn = "Activa esto para comprobar sólo a un personaje miembro del grupo/banda",	
	aideExact = "Activa esto para comprobar el nombre exacto del bufo/debufo/acción",
	aideStance = "Selecciona qué actitud, aura o forma activa el aura",
	aideGTFO = "Selecciona qué alerta ¡muévete! cativa el aura",
	aidePowerType = "Selecciona qué tipo de recurso monitorizar",

	aideShowSpinAtBeginning= "Al final del inicio de la animación, ejecuta un giro de 360 grados",
	nomCheckShowSpinAtBeginning = "Ejecuta un giro después del inicio de la animación",

	nomCheckShowTimer = "Mostrar",
	nomTimerDuration = "Duración",
	aideTimerDuration = "Muestra un reloj para simular la duración del bufo/debufo en el objetivo (0 para desactivar)",
	aideShowTimer = "Activa esto para mostrar el reloj de este efecto",
	aideSelectTimer = "Selecciona qué reloj mostrará la duración",
	aideSelectTimerBuff = "Selecciona qué reloj mostrará la duración (reservado para los bufos de jugadores)",
	aideSelectTimerDebuff = "Selecciona qué reloj mostrará la duración (reservado para los debufos de jugadores)",

	nomCheckShowStacks = "Mostrar",
	aideShowStacks = "Activa esto para mostrar las acumulaciones de este efecto",

	nomCheckInverse = "Invertir",
	aideInverse = "Invierte la lógica para mostrar este aura sólo cuando el bufo/debufo no está activo",	

	nomCheckIgnoreMaj = "Ignorar tipografía",	
	aideIgnoreMaj = "Activa esto para ignorar mayúsculas/minúsculas del nombre de bufos/debufos",

	nomAuraDebug= "Depurar",
	aideAuraDebug = "Depurar este aura",

	nomDuration = "Duración de la animación",
	aideDuration = "Después de este tiempo, el aura desaparecerá (0 para desactivar)",

	nomOldAnimations = "Animaciones antiguas";
	aideOldAnimations = "Usar animaciones antiguas";

	nomCentiemes = "Mostrar centésimas",
	nomDual = "Mostrar dos relojes",
	nomHideLeadingZeros = "Ocultar ceros a la izquierda",
	nomTransparent = "Usar texturas transparantes",
	nomActivationTime = "Mostrar tiempo desde la activación",
	nomTimer99 = "Mostrar segundos por debajo de 100",	
	nomUseOwnColor = "Usar color personalizado",
	nomUpdatePing = "Animar al renovar",
	nomLegacySizing = "Dígitos más anchos",
	nomRelative = "Relación con el aura",
	nomClose = "Cerrar",
	nomEffectEditor = "Editor de efectos",
	nomAdvOptions = "Opciones",
	nomMaxTex = "Máximo de texturas disponibles",
	nomTabAnim = "Animación",
	nomTabActiv = "Activación",
	nomTabSound = "Sonido",
	nomTabTimer = "Reloj",
	nomTabStacks = "Acumulaciones",
	nomWowTextures = "Texturas WoW",
	nomCustomTextures = "Texturas personalizadas",
	nomTextAura = "Aura de texto",
	nomRealaura = "Aura auténtica",
	nomRandomColor = "Color aleatorio",
	nomTexMode = "Resplandor",

	nomTalentGroup1 = "Talentos 1",
	aideTalentGroup1 = "Muestra este efecto sólo cuando usas tus talentos principales",
	nomTalentGroup2 = "Talentos 2",
	aideTalentGroup2 = "Muestra este efecto sólo cuando usas tus talentos secundarios",

	nomReset = "Reiniciar posiciones del editor",	
	nomPowaShowAuraBrowser = "Mostrar buscador de auras",
	
	nomDefaultTimerTexture = "Textura del reloj por defecto",
	nomTimerTexture = "Textura del reloj",
	nomDefaultStacksTexture = "Textura de las acumulaciones por defecto",
	nomStacksTexture = "Textura de las acumulaciones",
	
	Enabled = "Habilitado",
	Default = "Por defecto",

	Ternary = {
		combat = "En combate",
		inRaid = "En banda",
		inParty = "En grupo",
		isResting = "Descansando",
		ismounted = "Sobre montura",
		inVehicle = "En vehículo",
		isAlive= "Vivo",
		PvP= "PvP activado",
		Instance5Man= "5-Normal",
		Instance5ManHeroic= "5-Heróico",
		Instance10Man= "10-Normal",
		Instance10ManHeroic= "10-Heróico",
		Instance25Man= "25-Normal",
		Instance25ManHeroic= "25-Heróico",
		InstanceBg= "Campo de batalla",
		InstanceArena= "Arena",
	},

	nomWhatever = "Ignorado",
	aideTernary = "Establece cuando este aura se muestra.",
	TernaryYes = {
		combat = "Sólo en combate",
		inRaid = "Sólo en banda",
		inParty = "Sólo en grupo",
		isResting = "Sólo descansando",
		ismounted = "Sólo sobre montura",
		inVehicle = "Sólo en vehículos",
		isAlive= "Sólo vivo",
		PvP= "Sólo con PvP activado",
		Instance5Man= "Sólo en mazmorras 5-Normal",
		Instance5ManHeroic= "Sólo en mazmorras 5-Heróico",
		Instance10Man= "Sólo en bandas 10-Normal",
		Instance10ManHeroic= "Sólo en bandas 10-Heróico",
		Instance25Man= "Sólo en bandas 25-Normal",
		Instance25ManHeroic= "Sólo en bandas 25-Heróico",
		InstanceBg= "Sólo en campos de batalla",
		InstanceArena= "Sólo en Arenas",
		RoleTank     = "Sólo cuando tanque",
		RoleHealer   = "Sólo cuando curador",
		RoleMeleDps  = "Sólo cuando DPS cuerpo a cuerpo",
		RoleRangeDps = "Sólo cuando DPS a distancia",
	},
	TernaryNo = {
		combat = "Sólo cuando no en combate",
		inRaid = "Sólo cuando no en banda",
		inParty = "Sólo cuando no en grupo",
		isResting = "Sólo cuando no descansando",
		ismounted = "Sólo cuando no sobre montura",
		inVehicle = "Sólo cuando no en vehículos",
		isAlive= "Sólo muerto",
		PvP= "Sólo cuando PvP desactivado",
		Instance5Man= "Sólo cuando no en mazmorras 5-Normal",
		Instance5ManHeroic= "Sólo cuando no en mazmorras 5-Heróico",
		Instance10Man= "Sólo cuando no en bandas 10-Normal",
		Instance10ManHeroic= "Sólo cuando no en bandas 10-Heróico",
		Instance25Man= "Sólo cuando no en bandas 25-Normal",
		Instance25ManHeroic= "Sólo cuando no en bandas 25-Heróico",
		InstanceBg= "Sólo cuando no en campos de batalla",
		InstanceArena= "Sólo cuando no en arena",
		RoleTank     = "Sólo cuando no tanque",
		RoleHealer   = "Sólo cuando no curador",
		RoleMeleDps  = "Sólo cuando no DPS cuerpo a cuerpo",
		RoleRangeDps = "Sólo cuando no DPS a distancia",
	},
	TernaryAide = {
		combat = "Efecto modificado por estado de combate",
		inRaid = "Efecto modificado por estado de banda",
		inParty = "Efecto modificado por estado de grupo",
		isResting = "Efecto modificado por descansado",
		ismounted = "Efecto modificado por montura",
		inVehicle = "Efecto modificado por vehículos",
		isAlive= "Efecto modificado por vida",
		PvP= "Efecto modificado por estado de PvP",
		Instance5Man= "Efecto modificado por estar en mazmorra 5-Normal",
		Instance5ManHeroic= "Efecto modificado por estar en mazmorra 5-Heróico",
		Instance10Man= "Efecto modificado por estar en banda 10-Normal",
		Instance10ManHeroic= "Efecto modificado por estar en banda 10-Heróico",
		Instance25Man= "Efecto modificado por estar en banda 25-Normal",
		Instance25ManHeroic= "Efecto modificado por estar en banda 25-Heróico",
		InstanceBg= "Efecto modificado por estar en campo de batalla",
		InstanceArena= "Efecto modificado por estar en arena",
		RoleTank     = "Efecto modificado por ser tanque",
		RoleHealer   = "Efecto modificado por ser curador",
		RoleMeleDps  = "Efecto modificado por ser DPS cuerpo a cuerpo",
		RoleRangeDps = "Efecto modificado por ser DPS a distancia",
	},

	nomTimerInvertAura = "Invertir aura cuando tiempo inferior a",
	aidePowaTimerInvertAuraSlider = "Invertir aura cuando cuando la duración sea menos que el límite (0 para desactivar)",
	nomTimerHideAura = "Ocultar aura y reloj hasta",
	aidePowaTimerHideAuraSlider = "Ocultar aura y reloj cuando la duracion sea mayor que el límite (0 para desactivar)",

	aideTimerRounding = "Al comprobar, se redondeará el tiempo",
	nomTimerRounding = "Redondear",
	
	aideAllowInspections = "Permitir a Power Auras inspeccionar a los jugadores para determinar roles, desactivando esto se sacrifica precisión por rapidez",
	nomAllowInspections = "Permitir inspeccionar",
	
	nomCarried = "Sólo si en bolsas",
	aideCarried = "Ignora si el objeto se puede utilizar (sólo si está en las bolsas)",

	-- Diagnostic reason text, these have substitutions (using $1, $2 etc) to allow for different sententance constructions
	nomReasonShouldShow = "Debería mostrarse porque $1",
	nomReasonWontShow   = "No debería mostrarse porque $1",
	
	nomReasonMulti = "Todos los múltiples concuerdan con $1", --$1=Multiple match ID list
	
	nomReasonDisabled = "Power Auras desactivado",
	nomReasonGlobalCooldown = "Ignora el tiempo de reutilización global",
	
	nomReasonBuffPresent = "$1 tiene $2 $3", --$1=Target $2=BuffType, $3=BuffName (ej: "unidad4 tiene el debufo miseria")
	nomReasonBuffMissing = "$1 no tiene $2 $3", --$1=Target $2=BuffType, $3=BuffName (ej: "unidad4 no tiene el debufo miseria")
	nomReasonBuffFoundButIncomplete = "$2 $3 found for $1 but\n$4", --$1=Target $2=BuffType, $3=BuffName, $4=IncompleteReason (ej: "Debufo hender armadura encontrado en objetivo pero \nStacks<=2")
	
	nomReasonOneInGroupHasBuff     = "$1 tiene $2 $3",            --$1=GroupId   $2=BuffType, $3=BuffName (ej: "Raid23 tiene bufo Blessing of Kings")
	nomReasonNotAllInGroupHaveBuff = "No todos en $1 tienen $2 $3", --$1=GroupType $2=BuffType, $3=BuffName (ej: "No todos en banda tienen bufo Blessing of Kings")
	nomReasonAllInGroupHaveBuff    = "Todos en $1 tienen $2 $3",     --$1=GroupType $2=BuffType, $3=BuffName (ej: "Todos en banda tienen bufo Blessing of Kings")
	nomReasonNoOneInGroupHasBuff   = "Nadie en $1 has $2 $3",  --$1=GroupType $2=BuffType, $3=BuffName (ej: "Nadie en banda tiene bufo Blessing of Kings")

	nomReasonBuffPresentTimerInvert = "Bufo encontrado, reloj invertido",
	nomReasonBuffPresentNotMine     = "No lanzado por mí",
	nomReasonBuffFound               = "Bufo encontrado",
	nomReasonStacksMismatch         = "Acumulaciones = $1 , se esperaban $2", --$1=Actual Stack count, $2=Expected Stack logic match (ej: ">=0")

	nomReasonAuraMissing = "Falta aura",
	nomReasonAuraOff     = "Aura desactivada",
	nomReasonAuraBad     = "Aura falsa",
	
	nomReasonNotForTalentSpec = "Aura no activa para esta especialización de talentos",
	
	nomReasonPlayerDead     = "El jugador está muerto",
	nomReasonPlayerAlive    = "El jugador está vivo",
	nomReasonNoTarget       = "No hay objetivo",
	nomReasonTargetPlayer   = "El objetivo eres tú",
	nomReasonTargetDead     = "El objetivo está muerto",
	nomReasonTargetAlive    = "El objetivo está vivo",
	nomReasonTargetFriendly = "El objetivo es amistoso",
	nomReasonTargetNotFriendly = "El objetivo no es amistoso",

	nomReasonNoPet = "El jugador no tiene mascota",

	nomReasonNotInCombat = "No en combate",
	nomReasonInCombat = "En combate",
	
	nomReasonInParty = "En grupo",
	nomReasonInRaid = "En banda",
	nomReasonNotInParty = "No en grupo",
	nomReasonNotInRaid = "No en banda",
	nomReasonNotInGroup = "No en grupo/banda",
	nomReasonNoFocus = "No hay foco",	
	nomReasonNoCustomUnit = "No se encuentra la unidad en grupo, banda o con mascota=$1",
	nomReasonPvPFlagNotSet = "PvP no activado",
	nomReasonPvPFlagSet = "PvP activado",
	
	nomReasonNotMounted = "No sobre montura",
	nomReasonMounted = "Sobre montura",		
	nomReasonNotInVehicle = "No en vehículo",
	nomReasonInVehicle = "En vehículo",		
	nomReasonNotResting = "No descansando",
	nomReasonResting = "Descansando",		
	nomReasonStateOK = "Estado OK",
	
	nomReasonNotIn5ManInstance = "No en mazmorra 5-Normal",
	nomReasonIn5ManInstance = "En mazmorra 5-Normal",		
	nomReasonNotIn5ManHeroicInstance = "No en mazmorra 5-Heróico",
	nomReasonIn5ManHeroicInstance = "En mazmorra 5-Heróico",		
	
	nomReasonNotIn10ManInstance = "No en banda 10-Normal",
	nomReasonIn10ManInstance = "En banda 10-Normal",		
	nomReasonNotIn10ManHeroicInstance = "No en banda 10-Heróico",
	nomReasonIn10ManHeroicInstance = "En banda 10-Heróico",		
	
	nomReasonNotIn25ManInstance = "No en banda 25-Normal",
	nomReasonIn25ManInstance = "En banda 25-Normal",		
	nomReasonNotIn25ManHeroicInstance = "No en banda 25-Heróico",
	nomReasonIn25ManHeroicInstance = "En banda 25-Heróico",		
	
	nomReasonNotInBgInstance = "No en campo de batalla",
	nomReasonInBgInstance = "En campo de batalla",		
	nomReasonNotInArenaInstance = "No en arena",
	nomReasonInArenaInstance = "En arena",

	nomReasonInverted        = "$1 (invertido)", -- $1 es la razón, pero la casilla invertido está marcada, así que la lógica está invertida
	
	nomReasonSpellUsable     = "Habilidad $1 se puede usar",
	nomReasonSpellNotUsable  = "Habilidad $1 no se puede usar",
	nomReasonSpellNotReady   = "Habilidad $1 no preparada, en reutilización, reloj invertido",
	nomReasonSpellNotEnabled = "Habilidad $1 no habilitada ",
	nomReasonSpellNotFound   = "Habilidad $1 no encontrada",
	nomReasonSpellOnCooldown = "Habilidad $1 en reutilización",
	
	nomReasonCastingOnMe	 = "$1 lanzando $2 en mí", --$1=CasterName $2=SpellName (ej: "Rotface is casting Slime Spray on me")
	nomReasonNotCastingOnMe	 = "Habilidad desconocida lanzándose en mí",
	
	nomReasonCastingByMe	 = "Estoy lanzando $1 en $2", --$1=SpellName $2=TargetName (e.g. "I am casting Holy Light on Fred")
	nomReasonNotCastingByMe	 = "No se encuentra el hechizo lanzado por mí",

	nomReasonAnimationDuration  = "Aún dentro de la duración personalizada",

	nomReasonItemUsable     = "Objeto $1 se puede usar",
	nomReasonItemNotUsable  = "Objeto $1 no se puede usar",
	nomReasonItemNotReady   = "Objeto $1 no preparado, en reutilización, reloj invertido",
	nomReasonItemNotEnabled = "Objeto $1 no habilitado",
	nomReasonItemNotFound   = "Objeto $1 no encontrado",
	nomReasonItemOnCooldown = "Objeto $1 en reutilización",
	
	nomReasonItemEquipped    = "Objeto $1 equipado",
	nomReasonItemNotEquipped = "Objeto $1 no equipado",
						
	nomReasonItemInBags      = "Objeto $1 en bolsas",
	nomReasonItemNotInBags   = "Objeto $1 no en bolsas",
	nomReasonItemNotOnPlayer = "Objeto $1 no transportado",

	nomReasonSlotUsable     = "$1 ranura se puede usar",
	nomReasonSlotNotUsable  = "$1 ranura no se puede usar",
	nomReasonSlotNotReady   = "$1 ranura no preparada, en reutilización, reloj invertido",
	nomReasonSlotNotEnabled = "$1 ranura no tiene reutilización",
	nomReasonSlotNotFound   = "$1 ranura no encontrada",
	nomReasonSlotOnCooldown = "$1 ranura en reutilización",
	nomReasonSlotNone       = "$1 ranura está vacía",
	
	nomReasonStealablePresent = "$1 tiene hechizo para robar $2", --$1=Target $2=SpellName (e.g. "Focus has Stealable spell Blessing of Wisdom")
	nomReasonNoStealablePresent = "Nadie tiene hechizo para robar $1", --$1=SpellName (e.g. "Nobody has Stealable spell Blessing of Wisdom")
	nomReasonRaidTargetStealablePresent = "Raid$1Target tiene hechizo para robar $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Stealable spell Blessing of Wisdom")
	nomReasonPartyTargetStealablePresent = "Party$1Target tiene hechizo para robar $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Stealable spell Blessing of Wisdom")
	
	nomReasonPurgeablePresent = "$1 tiene hechizo purgable $2", --$1=Target $2=SpellName (e.g. "Focus has Purgeable spell Blessing of Wisdom")
	nomReasonNoPurgeablePresent = "Nadie tiene hechizo purgable $1", --$1=SpellName (e.g. "Nobody has Purgeable spell Blessing of Wisdom")
	nomReasonRaidTargetPurgeablePresent = "Raid$1Target tiene hechizo purgable $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Purgeable spell Blessing of Wisdom")
	nomReasonPartyTargetPurgeablePresent = "Party$1Target tiene hechizo purgable $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Purgeable spell Blessing of Wisdom")

	nomReasonAoETrigger = "AoE $1 activado", -- $1=AoE spell name
	nomReasonAoENoTrigger = "AoE no activada $1", -- $1=AoE spell match
	
	nomReasonEnchantMainInvert = "Mano derecha $1 encantamiento encontrado, reloj invertido", -- $1=Enchant match
	nomReasonEnchantMain = "Mano derecha $1 encantamiento encontrado", -- $1=Enchant match
	nomReasonEnchantOffInvert = "Mano izquierda $1 encantamiento encontrado, reloj invertido"; -- $1=Enchant match
	nomReasonEnchantOff = "Mano izquierda $1 encantamiento encontrado", -- $1=Enchant match
	nomReasonNoEnchant = "Encantamiento no encontrado en armas $1", -- $1=Enchant match

	nomReasonNoUseCombo = "No usas puntos de combo",
	nomReasonNoUseComboInForm = "No usas puntos de combo bajo esta forma",
	nomReasonComboMatch = "Puntos de combo $1 concuerdan con $2",-- $1=Combo Points, $2=Combo Match
	nomReasonNoComboMatch = "Puntos de combo $1 no concuerdan con $2",-- $1=Combo Points, $2=Combo Match

	nomReasonActionNotFound = "No encontrado en barras de acción",
	nomReasonActionReady = "Habilidad preparada",
	nomReasonActionNotReadyInvert = "Habilidad no preparada (reutilización), reloj invertido",
	nomReasonActionNotReady = "Habilidad no preparada (reutilización)",
	nomReasonActionlNotEnabled = "Habilidad deshabilitada",
	nomReasonActionNotUsable = "No se puede usar la habilidad",

	nomReasonYouAreCasting = "Estás lanzando $1", -- $1=Casting match
	nomReasonYouAreNotCasting = "No estás lanzando $1", -- $1=Casting match
	nomReasonTargetCasting = "Objetivo lanzando $1", -- $1=Casting match
	nomReasonFocusCasting = "Foco lanzando $1", -- $1=Casting match
	nomReasonRaidTargetCasting = "Raid$1Target lanzando $2", --$1=RaidId $2=Casting match
	nomReasonPartyTargetCasting = "Party$1Target lanzando $2", --$1=PartyId $2=Casting match
	nomReasonNoCasting = "Objetivo de nadie lanzando $1", -- $1=Casting match
	
	nomReasonStance = "Actitud actual $1, concuerda con $2", -- $1=Current Stance, $2=Match Stance
	nomReasonNoStance = "Actitud actual $1, no concuerda con $2", -- $1=Current Stance, $2=Match Stance
	
	nomReasonRunesNotReady = "Runas no preparadas",
	nomReasonRunesReady = "Runas preparadas",
	
	nomReasonPetExists= "El jugador tiene mascota",
	nomReasonPetMissing = "Falta mascota del jugador",
	
	nomReasonTrackingMissing = "Rastreo no fijado en $1",
	nomTrackingSet = "Rastreo fijado en $1",

	nomNotInInstance = "Actitud no adecuada",

	nomReasonStatic = "Aura estática",
	
	nomReasonUnknownName = "Nombre de la unidad desconocido",
	nomReasonRoleUnknown = "Rol desconocido",
	nomReasonRoleNoMatch = "Rol no coincidente",

	nomUnknownSpellId = "PowerAuras: Aura $1 hace referencia a un ID desconocido", -- $1=SpellID	

	nomReasonGTFOAlerts = "Las alertas ¡muévete! no siempre están activadas",

	ReasonStat = {
		Health     = {MatchReason="$1 poca vida",          NoMatchReason="$1 demasiada vida"},
		Mana       = {MatchReason="$1 poco maná",            NoMatchReason="$1 demasiado maná"},
		Power	   = {MatchReason="$1 poco poder", 			NoMatchReason="$1 demasiado poder", NilReason = "$1 tiene un tipo de poder distinto"},
		Aggro      = {MatchReason="$1 tiene aggro",           NoMatchReason="$1 no tiene aggro"},
		PvP        = {MatchReason="$1 PvP activado",        NoMatchReason="$1 PvP no activado"},
		SpellAlert = {MatchReason="$1 lanzando $2",        	NoMatchReason="$1 no está lanzando $2"},
	},
	
	-- Export dialog
	ExportDialogTopTitle      = "Exportar Auras",
	ExportDialogCopyTitle     = "Presiona Ctrl-C para copiar el código de aura inferior",
	ExportDialogMidTitle      = "Enviar a jugador",
	ExportDialogSendTitle1    = "Introduce el nombre de un jugador y pulsa el botón 'Enviar'",
	ExportDialogSendTitle2    = "Conectando %s (%d segundos restantes)...",      -- The 1/2/3/4 suffix denotes the internal status of the frame.
	ExportDialogSendTitle3a   = "%s está en combate y no puede aceptar",
	ExportDialogSendTitle3b   = "%s no acepta peticiones",
	ExportDialogSendTitle3c   = "%s no ha respondido, puede que esté ausente",
	ExportDialogSendTitle3d   = "%s está recibiendo otra petición",
	ExportDialogSendTitle3e   = "%s ha rechazado la petición",
	ExportDialogSendTitle4    = "Enviando auras...",
	ExportDialogSendTitle5    = "¡Envío realizado!",
	ExportDialogSendButton1   = "Enviar",
	ExportDialogSendButton2   = "Atrás",
	ExportDialogCancelButton  = "Cerrar",
	-- Cross-client import dialog
	PlayerImportDialogTopTitle       = "¡Tienes auras!",
	PlayerImportDialogDescTitle1     = "%s quiere enviarte auras",
	PlayerImportDialogDescTitle2     = "Recibiendo auras...",
	PlayerImportDialogDescTitle3     = "La petición ha caducado",
	PlayerImportDialogDescTitle4     = "Selecciona una página para guardar las auras",
	PlayerImportDialogWarningTitle   = "|cFFFF0000Note: |rTe están enviando un bloque de auras, esto sobreescribirá todas las auras de esta página",
	PlayerImportDialogDescTitle5     = "¡Auras guardadas!",
	PlayerImportDialogDescTitle6     = "No hay ranuras para auras disponibles",
	PlayerImportDialogAcceptButton1  = "Aceptar",
	PlayerImportDialogAcceptButton2  = "Guardar",
	PlayerImportDialogCancelButton1  = "Rechazar",

	aideCommsRegisterFailure = "There was an error when setting up addon communications.",
	aideBlockIncomingAuras = "Evita que otros te envíen sus auras",
	nomBlockIncomingAuras = "Bloque de auras entrante",

});

end
