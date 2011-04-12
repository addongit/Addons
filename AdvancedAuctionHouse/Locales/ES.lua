AAHLocale = {}
AAHLocale.Commands = {
	BARGAIN = "$ganga,$bargain", -- Needs review
	DURA = "$dura,$durabilidad", -- Needs review
	EGGAPTITUDE = "$apthuevo,$aptituddehuevo,$eggapt", -- Needs review
	EGGLEVEL = "$nivelhuevo,$niveldehuevo,$egglvl", -- Needs review
	FIVE = "$cinco,$quintuple,$five", -- Needs review
	FOUR = "$cuatro,$cuadruple,$four", -- Needs review
	GREEN = "$verde,$green", -- Needs review
	ONE = "$uno,$una,$sencillo,$single", -- Needs review
	ORANGE = "$naranja,$orange", -- Needs review
	PLUS = "$mas", -- Needs review
	SIX = "$seis,$sextuple,$six", -- Needs review
	THREE = "$tres,$triple,$three", -- Needs review
	TIER = "$nivel,$tier", -- Needs review
	TWO = "$dos,$doble,$two", -- Needs review
	VENDOR = "$proveedor,$vendor", -- Needs review
	YELLOW = "$amarillo,$yellow", -- Needs review
	ZERO = "$cero,$limpio,$clean,$zero", -- Needs review
}
AAHLocale.Messages = {
	ADDON_MANAGER_DESCRIPTION = [=[Advanced AuctionHouse modifica la casa de subastas por defecto. Añade algunas nuevas funciones útiles para hacer la búsqueda y sabasta más fácil y más cómoda.

Toda la funcionalidad está incluida directamente en la ventana de subastas así que no tienes que hacer nada más que abrir la casa de subastas para poder usar las nuevas funciones.]=],
	AUCTION_EXCHANGE_RATE = "Tipo de Cambio",
	AUCTION_FORUMS_BUTTON = "AAH Foros",
	AUCTION_FORUMS_BUTTON_TOOLTIP_HEADER = "Enlace a los Foros de Advanced AuctionHouse",
	AUCTION_FORUMS_BUTTON_TOOLTIP_TEXT = "Advanced AuctionHouse en Curse.com se abrirá en tu navegador. Considera hacer una donación para ayudar a continuar con este proyecto.",
	AUCTION_FRAME_TITLE = "Advanced AuctionHouse <VERSION> creado por Mavoc (ES) - Traducido por Darwen.", -- Needs review
	AUCTION_LOADED_MESSAGE = "Addon cargado: Advanced AuctionHouse <VERSION> por Mavoc (ES) - Traducido por Darwen.", -- Needs review
	BROWSE_CANCELLING = "Cancelando búsqueda anterior",
	BROWSE_CLEAR_BUTTON = "Borrar",
	BROWSE_CLEAR_BUTTON_TOOLTIP_HEADER = "Borrar Búsqueda y Filtros",
	BROWSE_CLEAR_BUTTON_TOOLTIP_TEXT = "Pulsa este botón para reiniciar todos los términos y filtros aplicados a tu búsqueda. No reiniciará el resultado de la búsqueda en sí.",
	BROWSE_CREATE_FOLDER_POPUP = "Crear una Carpeta",
	BROWSE_FILTER = "Filtros",
	BROWSE_FILTER_OR_TOOLTIP_HEADER = "Enlaza palabras clave con OR",
	BROWSE_FILTER_OR_TOOLTIP_TEXT = [=[Marca esto para enlazar múltiples palabras clave con OR en vez de AND.
(Filtro#1 y/o Filtro#2) y/o Filtro#3]=],
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_HEADER = "Filtrado de Precio de Puja",
	BROWSE_FILTER_PRICERANGE_BID_TOOLTIP_TEXT = "Marca esto para filtrado de artículos basado en el Precio de Puja en vez del Precio de Compra.",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_HEADER = "Filtrado de precio máximo",
	BROWSE_FILTER_PRICERANGE_MAX_TOOLTIP_TEXT = "Introduce un precio máximo para filtrar artículos.",
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_HEADER = "Filtrado de precio mínimo",
	BROWSE_FILTER_PRICERANGE_MIN_TOOLTIP_TEXT = "Introduce un precio mínimo para filtrar artículos.",
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_HEADER = "Filtrado Precio/Unidad",
	BROWSE_FILTER_PRICERANGE_PPU_TOOLTIP_TEXT = "Marca esto para búsqueda de artículos basada en Precio Por Unidad en vez de por el precio total.",
	BROWSE_FILTER_TOOLTIP_HEADER = "Palabra clave de filtrado #",
	BROWSE_FILTER_TOOLTIP_TEXT1 = [=[Pon una palabra aquí para filtrar tus resultados de búsqueda. Para invertir el filtro escribe ! frente a la palabra clave. Usar palabras clave en múltiples cajas de palabra clave las enlazará con AND por defecto.

Pueden usarse los siguientes filtros especiales:]=],
	BROWSE_FILTER_TOOLTIP_TEXT2 = [=[|cffffd200$verde|r - encontrar artículos con estadísticas verdes.
|cffffd200$amarillo|r - encontrar artículos con estadísticas amarillas.
|cffffd200$naranja|r - encontrar artículos con estadísticas naranjas.
|cffffd200$limpio|r - encontrar artículos sin estadísticas.
|cffffd200$una|r - encontrar artículos con una estadística.
|cffffd200$dos|r - encontrar artículos con dos estadísticas.
|cffffd200$tres|r - encontrar artículos con tres estadísticas.
|cffffd200$cuatro|r - encontrar artículos con cuatro estadísticas.
|cffffd200$cinco|r - encontrar artículos con cinco estadísticas.
|cffffd200$seis|r - encontrar artículos con seis estadísticas.]=],
	BROWSE_FILTER_TOOLTIP_TEXT3 = [=[|cffffd200$dura|r - artículos con durabilidad >= 101
--($dura/110 busca con durabilidad mínima de 110)
|cffffd200$nivel|r - artículos con nivel >= 1
--($nivel/3 busca con nivel mínimo de 3)
|cffffd200$mas|r - artículos con un más >= 1
--($mas/6 busca con más mínimo de 6)
|cffffd200$nivelhuevo|r - huevo de mascota con nivel >= 1
--($nivelhuevo/30 busca con nivel mínimo de 30)
|cffffd200$apthuevo|r - huevo de mascota con aptitud >= 1
--($apthuevo/80 busca con aptitud mínima de 80)
|cffffd200$proveedor|r - vender al proveedor para sacar provecho.
--(mira en curse.com como usarlo)
|cffffd200$ganga|r - revender en AH para sacar provecho
--(mira en curse.com como usarlo)]=],
	BROWSE_HEADER_CUSTOM_TITLE = "Select Auction Data Type:", -- Requires localization
	BROWSE_INFO_LABEL = "Encontrados: <MAXITEMS>. Cargado: <SCANPERCENT>%. Coincidencias: <FILTEREDITEMS>. Filtrado: <FILTERPERCENT>%.",
	BROWSE_INFO_LABEL_TOOLTIP_HEADER = "Progreso de copia Caché y Filtrado",
	BROWSE_INFO_LABEL_TOOLTIP_TEXT = [=[Muestra la siguiente información:

- los resultados totales de búsqueda (máx 500)
- el progreso de la búsqueda en sí
- número de artículos coincidentes con tus palabras clave
- el progreso del proceso de filtrado]=],
	BROWSE_MAX = "Max",
	BROWSE_MIN = "Min",
	BROWSE_NAME_SEARCH_POPUP = "Nombre para tu Búsqueda Guardada",
	BROWSE_NO_RESULTS = "No hay resultados para tu búsqueda",
	BROWSE_OR = "o",
	BROWSE_PPU = "PPU",
	BROWSE_RENAME = "Renombrar",
	BROWSE_RENAME_SAVED_SEARCH_POPUP = "Renombrar tu Búsqueda Guardada",
	BROWSE_SAVED_SEARCH_TITLE = "Búsquedas Guardadas",
	BROWSE_SEARCHING = "Búsqueda en progreso... por favor espera.",
	BROWSE_SEARCH_PARAMETERS = "Parámetros de Búsqueda",
	BROWSE_USABLE = "Usable",
	GENERAL_ATTRIBUTES = "Attributes", -- Requires localization
	GENERAL_AVERAGE = "Media",
	GENERAL_AVERAGE_PRICE_PER_UNIT = "Precio Medio por Unidad:",
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
	GENERAL_MEDIAN_PRICE_PER_UNIT = "Mediana de precio por unidad:",
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
	GENERAL_PRICE_PER_UNIT_HEADER = "Precio/Unidad",
	GENERAL_SPEED_HEADER = "Speed", -- Requires localization
	GENERAL_STAM_HEADER = "Stam", -- Requires localization
	GENERAL_STATS = "Stats", -- Requires localization
	GENERAL_STR_HEADER = "Str", -- Requires localization
	GENERAL_TIER_HEADER = "Tier", -- Requires localization
	GENERAL_WIS_HEADER = "Wis", -- Requires localization
	GENERAL_WORTH_HEADER = "Worth", -- Requires localization
	HISTORY_NO_DATA = "¡Este artículo no tiene historial de precios!",
	HISTORY_SUMMARY_AVERAGE = [=[Mediana de Precios: <MEDIAN>
Precio Medio: <AVERAGE>]=],
	HISTORY_SUMMARY_MINMAX = [=[Precio Mínimo: <MINIMUM>
Precio Máximo: <MAXIMUM>]=],
	HISTORY_SUMMARY_NUMHISTORY = "(<NUMHISTORY> subastas)",
	LUNA_NEW_VERSION_FOUND = "Existe una versión más reciente de Advanced AuctionHouse en rom.curse.com",
	LUNA_NOT_FOUND = "Luna es necesario para que funcione esta característica.  Luna puede encontrarse en Curse.",
	SELL_AUTO_BID_PRICE_TOOLTIP_HEADER = "Modo Autocompletar Precio de Puja",
	SELL_AUTO_BID_PRICE_TOOLTIP_TEXT = [=[El modo para autocompletar el valor de la puja puede ser seleccionado aquí. Los modos son:

|cffffd200Ninguno|r no introduce ningún precio

mismo precio que la |cffffd200Última|r vez que el artículo fue subastado (si existe)

precio |cffffd200Medio|r al que el artículo se vende

definir una |cffffd200Fórmula|r de autocompletar personalizada]=],
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_HEADER = "Modo Autocompletar Precio de Compra",
	SELL_AUTO_BUYOUT_PRICE_TOOLTIP_TEXT = [=[El modo para autocompletar el valor de la compra puede ser seleccionado aquí. Los modos son:

|cffffd200Ninguno|r no introduce ningún precio

mismo precio que la |cffffd200Última|r vez que el artículo fue subastado (si existe)

precio |cffffd200Medio|r al que el artículo se vende

definir una |cffffd200Fórmula|r de autocompletar personalizada]=],
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_HEADER = "Fórmula Personalizada de Precio",
	SELL_AUTO_PRICE_FORMULA_TOOLTIP_TEXT = [=[Define una fórmula personalizada que será usada para calcular el autoprecio. Los siguientes marcadores pueden usarse

AVG - precio medio
MEDIAN - mediana de precios
MIN - Precio Mínimo
MAX - Precio Máximo

Ejemplo: AVG - ((AVG - MIN) / 3)]=],
	SELL_AUTO_PRICE_HEADER = "Opciones de Precio Automático",
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_HEADER = "Porcentaje de Promedio",
	SELL_AUTO_PRICE_PERCENT_TOOLTIP_TEXT = "Autoprecio del artículo basado en un % promedio del historial",
	SELL_FORMULA = "Fórmula",
	SELL_LAST = "Último",
	SELL_NONE = "Ninguno",
	SELL_NUM_AUCTION = "Número de subastas:",
	SELL_PERCENT = "% de media",
	SELL_PER_UNIT = "por unidad",
	SETTINGS_BROWSE = "Configuración de Exploración",
	SETTINGS_CLEAR_ALL_SUCCESS = "Limpiados correctamente todos los datos del historial de precios.",
	SETTINGS_CLEAR_SUCCESS = "Limpiado correctamente el historial de precio para: |cffffffff",
	SETTINGS_FILTER_SPEED = "Velodidad de Filtrado",
	SETTINGS_FILTER_SPEED_HEADER = "Velodidad de Filtrado",
	SETTINGS_FILTER_SPEED_TEXT = [=[Ajusta la cantidad de artículos filtrados cada actualización. A mayor valor mayor velocidad pero provoca más lag causado por el filtrado.
Soporta la rueda del ratón.]=],
	SETTINGS_GENERAL = "Configuración General",
	SETTINGS_HISTORY = "Configuración de Historial",
	SETTINGS_MAX_SAVED_HISTORY = "Máximo Historial Guardado",
	SETTINGS_MAX_SAVED_HISTORY_HEADER = "Máximo Historial Guardado",
	SETTINGS_MAX_SAVED_HISTORY_TEXT = [=[Máxima cantidad de historial guardado por artículo.
Soporta la rueda del ratón.]=],
	SETTINGS_MISSING_PARAMETER = "Faltan parámetros para limpiar el historial de datos.",
	SETTINGS_PRICE_HISTORY_TOOLTIP = "Mostrar Siempre Información de Historial de Precios",
	SETTINGS_PRICE_HISTORY_TOOLTIP_HEADER = "Mostrar Información de Historial de Precios",
	SETTINGS_PRICE_HISTORY_TOOLTIP_TEXT = [=[Marcado: Mostrar Información por Defecto. Manten ALT para ocultar
Desmarcado: Mostrar Información Sólo si mantienes pulsado ALT]=],
	SETTINGS_PRICE_PER_UNIT_PER_WHITE = "Precio/Unidad/Blanco Para Materiales",
	SETTINGS_PRICE_PER_UNIT_PER_WHITE_HEADER = "Precio/Unidad/Blanco",
	SETTINGS_PRICE_PER_UNIT_PER_WHITE_TEXT = [=[Activar esto hará que todos los Materiales usen Precio Por Unidad Por Material Blanco. Esto te permitirá comparar más fácilmente los precios de Materiales a diferentes niveles de refinamiento. Se aplicará en todas la áreas que usen Precio/Unidad incluyendo los precios de venta.
Verde = 2x Mat. Blanco
Azul = 12x Mat. Blanco
Morado = 72x Mat. Blanco
Ejemplo:
100x |cff0072bc[Lingote de Zinc]|r a 120,000 por paquete.
Precio/Unidad = 1,200
Precio/Unidad/Blanco = 100]=],
	TOOLS_DAY_ABV = "d",
	TOOLS_GOLD_BASED = "(Basado en <SCANNED> subastas escaneadas vendidas por oro)",
	TOOLS_HOUR_ABV = "h",
	TOOLS_ITEM_NOT_FOUND = "No encontrado historial de datos para: |cffffffff",
	TOOLS_MIN_ABV = "m",
	TOOLS_NO_HISTORY_DATA = "No hay datos disponibles.",
	TOOLS_POWERED_BY = "(mejorado con Advanced AuctionHouse)",
	TOOLS_PRICE_HISTORY = "Historial de Precios",
	TOOLS_UNKNOWN_COMMAND = [=[Comando desconocido. Los comando son:
|cffffffff/aah numhistory <entradas de historial máximas a guardar por artículo>|r
|cffffffff/aah clear <artículo>|r
|cffffffff/aah clearall|r
|cffffffff/aah pricehistory|r]=],
}
