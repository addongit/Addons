--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "esES")
if not L then return end

L[" days"] = " days" -- Requires localization
L["ABOUTDESC"] = "Imprime información acerca de Skillet"
L["APPEARANCEDESC"] = "Opciones que controlan como Skillet es mostrado"
L["About"] = "Acerca de"
L["Appearance"] = "Apariencia"
L["Blizzard"] = "Blizzard" -- Requires localization
L["Buy Reagents"] = "Comprar Reactivos"
L["By Difficulty"] = "Por Dificultad"
L["By Item Level"] = "By Item Level" -- Requires localization
L["By Level"] = "Por Nivel"
L["By Name"] = "Por Nombre"
L["By Quality"] = "Por Calidad"
L["By Skill Level"] = "By Skill Level" -- Requires localization
L["CONFIGDESC"] = "Abre una ventana de configuración para Skillet"
L["Clear"] = "Limpiar"
L["Config"] = "Configuración"
L["Could not find bag space for"] = "No puedo encontrar un espacio en la bolsa para"
L["Crafted By"] = "Crafted by" -- Needs review
L["Create"] = "Crear"
L["Create All"] = "Crear Todo"
L["DISPLAYREQUIREDLEVELDESC"] = "Si el elemento fabricado requiere un nivel mínimo para utilizar, este nivel será mostrado con la receta"
L["DISPLAYREQUIREDLEVELNAME"] = "Mostrar nivel necesario"
L["DISPLAYSGOPPINGLISTATAUCTIONDESC"] = "Mostrar una Lista de la Compra de los elementos que son necesarios para fabricar recetas encoladas pero que no están en tus bolsas"
L["DISPLAYSGOPPINGLISTATAUCTIONNAME"] = "Mostrar Lista de la Compra en la Subasta"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Mostrar una Lista de la Compra de los elementos que son necesarios para fabricar recetas encoladas pero que no están en tus bolsas"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Mostrar Lista de la Compra en los Bancos"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags" -- Requires localization
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Display shopping list at guild banks" -- Requires localization
L["Delete"] = "Delete" -- Requires localization
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Cuando activo, nombres de las recetas tendrán uno o más caracteres '+' añadido a su nombre para indicar la dificultad de la receta."
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Mostrar la dificultad de la receta como texto"
L["Enabled"] = "Enabled" -- Requires localization
L["Enchant"] = "Encantar"
L["FEATURESDESC"] = "Comportamiento opcional que puede activarse y desactivarse"
L["Features"] = "Características"
L["Filter"] = "Filtro"
L["Glyph "] = "Glifo "
L["Gold earned"] = "Gold earned" -- Requires localization
L["Grouping"] = "Grouping" -- Needs review
L["Hide trivial"] = "Ocultar Triviales"
L["Hide uncraftable"] = "Ocultar Imposibles de Crear"
L["INVENTORYDESC"] = "Información del Inventario"
L["Include alts"] = "Incluir Alts"
L["Inventory"] = "Inventario"
L["LINKCRAFTABLEREAGENTSDESC"] = "Si puedes crear un reactivo necesario para la receta actual, clickenado el reactivo le llevará a su receta."
L["LINKCRAFTABLEREAGENTSNAME"] = "Hacer reactivos clickeables"
L["Library"] = "Librería"
L["Load"] = "Load" -- Requires localization
L["Move Down"] = "Move Down" -- Requires localization
L["Move Up"] = "Move Up" -- Requires localization
L["Move to Bottom"] = "Move to Bottom" -- Requires localization
L["Move to Top"] = "Move to Top" -- Requires localization
L["No Data"] = "No Data" -- Requires localization
L["No such queue saved"] = "No such queue saved" -- Requires localization
L["None"] = "Ninguno"
L["Notes"] = "Notas"
L["Number of items to queue/create"] = "Número de elementos a encolar/crear"
L["Options"] = "Opciones"
L["Pause"] = "Pausar"
L["Process"] = "Process" -- Requires localization
L["Purchased"] = "Comprado"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Si puedes crear un reactivo necesario para la receta actual, y no tienes suficientes, entonces estos reactivos serán añadidos a la cola"
L["QUEUECRAFTABLEREAGENTSNAME"] = "Encolar reactivos fabricables"
L["QUEUEGLYPHREAGENTSDESC"] = "If you can create a reagent needed for the current recipe, and don't have enough, then that reagent will be added to the queue. This option is separate for Glyphs only." -- Needs review
L["QUEUEGLYPHREAGENTSNAME"] = "Queue reagents for Glyphs" -- Needs review
L["Queue"] = "Encolar"
L["Queue All"] = "Encolar Todo"
L["Queue is empty"] = "Queue is empty" -- Requires localization
L["Queue is not empty. Overwrite?"] = "Queue is not empty. Overwrite?" -- Requires localization
L["Queue with this name already exsists. Overwrite?"] = "Queue with this name already exsists. Overwrite?" -- Requires localization
L["Queues"] = "Queues" -- Requires localization
L["Really delete this queue?"] = "Really delete this queue?" -- Requires localization
L["Rescan"] = "Rescanear"
L["Retrieve"] = "Recuperar"
L["SCALEDESC"] = "Escala de la venta de Habilidades de Comercio (predeterminado 1.0)"
L["SHOPPINGLISTDESC"] = "Mostrar la Lista de la Compra"
L["SHOWBANKALTCOUNTSDESC"] = "Cuando se calcula y se muestra contador de elementos fabricables, incluir elementos de tu banco y de tus otros caracteres."
L["SHOWBANKALTCOUNTSNAME"] = "Incluir contenido del banco y caracter alt"
L["SHOWCRAFTCOUNTSDESC"] = "Mostrar el número de veces que se puede elaborar una receta, no el número total de elementos elaborables"
L["SHOWCRAFTCOUNTSNAME"] = "Mostrar Contador Fabricación"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Display the alternate characters that can craft an item in the item's tooltip" -- Needs review
L["SHOWCRAFTERSTOOLTIPNAME"] = "Show crafters in tooltips" -- Needs review
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Mostrar un tooltip detallado cuando se cierne sobre recetas en el panel izquierdo"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Mostrar tooltip detallado para recipientes"
L["SHOWFULLTOOLTIPDESC"] = "Display all informations about an item to be crafted. If you turn it off you will only see compressed tooltip (hold Ctrl to show full tooltip)" -- Needs review
L["SHOWFULLTOOLTIPNAME"] = "Use standard tooltips" -- Needs review
L["SHOWITEMNOTESTOOLTIPDESC"] = "Añadir notas proporcionadas para un elemento al tooltip para ese elemento"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Añadir notas usuario especificadas al tooltip"
L["SHOWITEMTOOLTIPDESC"] = "Display craftable item tooltip, instead of a recipe tooltip." -- Requires localization
L["SHOWITEMTOOLTIPNAME"] = "Display item tooltip when possible" -- Requires localization
L["SORTASC"] = "Ordenar la lista de recetas del mayor (arriba) al menor (abajo)"
L["SORTDESC"] = "Ordenar la lista de recetas del menor (arriba) al mayor (abajo)"
L["STANDBYDESC"] = "Toggle standby mode on/off" -- Requires localization
L["STANDBYNAME"] = "standby" -- Requires localization
L["SUPPORTEDADDONSDESC"] = "Addons soportados que pueden o son usados para rastrear el inventario"
L["Save"] = "Save" -- Requires localization
L["Scale"] = "Escala"
L["Scan completed"] = "Escaneo completado"
L["Scanning tradeskill"] = "Escaneando Habilidades de Comercio"
L["Select skill difficulty threshold"] = "Select skill difficulty threshold" -- Needs review
L["Selected Addon"] = "Addon Seleccionado"
L["Sells for "] = "Sells for " -- Requires localization
L["Shopping List"] = "Lista Compra"
L["Skillet Trade Skills"] = "Skillet - Habilidades de Comercio"
L["Sold amount"] = "Sold amount" -- Requires localization
L["Sorting"] = "Sorting"
L["Source:"] = "Source:" -- Requires localization
L["Start"] = "Iniciar"
L["Supported Addons"] = "Addons Soportados"
L["TRANSPARAENCYDESC"] = "Transparencia de la ventana principal de las Habilidades de Comercio"
L["This merchant sells reagents you need!"] = "¡Este mercader vende los reactivos que necesitas!"
L["Total Cost:"] = "Total Cost:" -- Requires localization
L["Total spent"] = "Total gastado"
L["Trained"] = "Trained" -- Requires localization
L["Transparency"] = "Transparencia"
L["Unknown"] = "Unknown" -- Requires localization
L["VENDORAUTOBUYDESC"] = "Si tiene recetas en cola y habla con un vendedor que vende algo necesario para las recetas, se adquiere automáticamente."
L["VENDORAUTOBUYNAME"] = "Automáticamente comprar los reactivos"
L["VENDORBUYBUTTONDESC"] = "Muestra un botón cuando hable con los vendedores que le permitirá ver los reactivos necesarios para todas las recetas en cola."
L["VENDORBUYBUTTONNAME"] = "Mostrar botón comprar reactivos en proveedores"
L["alts"] = "alts"
L["bank"] = "banco"
L["buyable"] = "vendible"
L["can be created from reagents in your inventory"] = "puede ser creado con los reactivos de tu inventario"
L["can be created from reagents in your inventory and bank"] = "puede ser creado con los reactivos de tu inventario y banco"
L["can be created from reagents on all characters"] = "puede ser creado con los reactivos de todos tus caracteres"
L["click here to add a note"] = "Click aquí para añadir una nota"
L["craftable"] = "craftable" -- Requires localization
L["is now disabled"] = "is now disabled" -- Requires localization
L["is now enabled"] = "is now enabled" -- Requires localization
L["not yet cached"] = "aún no en caché"
L["reagents in inventory"] = "reactivos en el inventario"

