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

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "frFR")
if not L then return end

L[" days"] = " jours"
L["ABOUTDESC"] = "Affiche des informations sur l'addon"
L["APPEARANCEDESC"] = "Réglage de l'apparence de la fenètre Skillet"
L["About"] = "A propos"
L["Appearance"] = "Apparence"
L["Blizzard"] = "Blizzard"
L["Buy Reagents"] = "Acheter des réactifs"
L["By Difficulty"] = "Par difficulté"
L["By Item Level"] = "Par niveau d'objet"
L["By Level"] = "Par niveau"
L["By Name"] = "Par nom"
L["By Quality"] = "Par qualité"
L["By Skill Level"] = "Par niveau de compétence"
L["CONFIGDESC"] = "Ouvre la fenêtre de configuration de l'addon"
L["Clear"] = "Nettoyer"
L["Config"] = "Configuration"
L["Could not find bag space for"] = "Il n'y a plusde place dans vos sacs pour"
L["Crafted By"] = "Crafted by"
L["Create"] = "Créer"
L["Create All"] = "Créer tous"
L["DISPLAYREQUIREDLEVELDESC"] = "Si l'objet à créer a un niveau minimum requis, ce niveau sera affiché a gauche de la recette"
L["DISPLAYREQUIREDLEVELNAME"] = "Afficher le niveau requis"
L["DISPLAYSGOPPINGLISTATAUCTIONDESC"] = "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags"
L["DISPLAYSGOPPINGLISTATAUCTIONNAME"] = "Display shopping list at auctions"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Display shopping list at banks"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Afficher une liste de courses des objets qui sont nécessaires pour fabriquer les recettes das files d'attente mais qui ne sont pas dans vos sacs"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Afficher la liste de courses à la banque de guilde"
L["Delete"] = "Supprimer"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Si activé, les noms de recettes auront un ou plusieurs '+' derrière leur nom pour indiquer la difficulté de la recette."
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Montrer la difficulté des recettes en texte"
L["Enabled"] = "Activé"
L["Enchant"] = "Enchanter"
L["FEATURESDESC"] = "Réglage des options"
L["Features"] = "Fonctionalités"
L["Filter"] = "Filtrer"
L["Glyph "] = "Glyphe "
L["Gold earned"] = "Or gagné"
L["Grouping"] = "Grouping" -- Needs review
L["Hide trivial"] = "Cacher les triviaux"
L["Hide uncraftable"] = "Cacher les infaisables"
L["INVENTORYDESC"] = "Informations sur l'inventaire"
L["Include alts"] = "Inclure les alts"
L["Inventory"] = "Inventaire"
L["LINKCRAFTABLEREAGENTSDESC"] = "If you can create a reagent needed for the current recipe, clicking the reagent will take you to its recipe."
L["LINKCRAFTABLEREAGENTSNAME"] = "Make reagents clickable"
L["Library"] = "Librairie"
L["Load"] = "Charger"
L["Move Down"] = "Descendre"
L["Move Up"] = "Monter"
L["Move to Bottom"] = "Descendre à la fin"
L["Move to Top"] = "Monter au début"
L["No Data"] = "Aucune donnée"
L["No such queue saved"] = "Aucune file d'attente correspondante n'a été sauvée"
L["None"] = "Aucun"
L["Notes"] = "Notes"
L["Number of items to queue/create"] = "Nombre d'objets à créer/mettre en file d'attente"
L["Options"] = "Options"
L["Pause"] = "Pause"
L["Process"] = "Avancement" -- Needs review
L["Purchased"] = "Achetés"
L["QUEUECRAFTABLEREAGENTSDESC"] = "If you can create a reagent needed for the current recipe, and don't have enough, then that reagent will be added to the queue" -- Needs review
L["QUEUECRAFTABLEREAGENTSNAME"] = "Queue craftable reagents" -- Needs review
L["QUEUEGLYPHREAGENTSDESC"] = "If you can create a reagent needed for the current recipe, and don't have enough, then that reagent will be added to the queue. This option is separate for Glyphs only." -- Needs review
L["QUEUEGLYPHREAGENTSNAME"] = "Mettre en file d'attente des composants pour des glyphes" -- Needs review
L["Queue"] = "Queue"
L["Queue All"] = "Queue tous"
L["Queue is empty"] = "La file d'attente est vide"
L["Queue is not empty. Overwrite?"] = "La file d'attente n'est pas vide. La remplacer ?"
L["Queue with this name already exsists. Overwrite?"] = "Une file d'attente avec ce nom existe déjà. La remplacer ?"
L["Queues"] = "Files d'attentes"
L["Really delete this queue?"] = "Voulez-vous vraiment supprimer cette file d'attente ?"
L["Rescan"] = "Actualiser"
L["Retrieve"] = "Récupérer"
L["SCALEDESC"] = "Echelle de la fenêtre (1.0 par défaut)"
L["SHOPPINGLISTDESC"] = "Affiche la liste des courses à faire"
L["SHOWBANKALTCOUNTSDESC"] = "Lors du calcul et de l'affichage du nombre d'objets possibles à fabriquer, inclure les objets de votre banque et de vos autres personnages"
L["SHOWBANKALTCOUNTSNAME"] = "Inclure le contenu de votre banque et des autres personnages"
L["SHOWCRAFTCOUNTSDESC"] = "Montrer le nombre de fois que vous pouvez fabriquer une recette, et pas le nombre total d'objets possibles à fabriquer"
L["SHOWCRAFTCOUNTSNAME"] = "Afficher le nombre de fabrications possibles"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Afficher dans la bulle d'aide les autres personnages qui peuvent fabriquer un objet"
L["SHOWCRAFTERSTOOLTIPNAME"] = "Afficher les artisans dans les bulles d'aide"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Affiche une bulle d'aide quand la souris passe sur les recettes dans le panneau de gauche"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Afficher une bulle d'aide pour les recettes"
L["SHOWFULLTOOLTIPDESC"] = "Display all informations about an item to be crafted. If you turn it off you will only see compressed tooltip (hold Ctrl to show full tooltip)"
L["SHOWFULLTOOLTIPNAME"] = "Use standard tooltips"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Adds notes you provide for an item to the tool tip for that item"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Add user specified notes to tooltip"
L["SHOWITEMTOOLTIPDESC"] = "Afficher le tooltip de l'objet fabriqué au lieu de celui de la recette."
L["SHOWITEMTOOLTIPNAME"] = "Afficher les tooltip des objets quand c'est possible"
L["SORTASC"] = "Sort the recipe list from highest (top) to lowest (bottom)"
L["SORTDESC"] = "Sort the recipe list from lowest (top) to highest (bottom)"
L["STANDBYDESC"] = "Activer/désactiver le mode pause"
L["STANDBYNAME"] = "pause"
L["SUPPORTEDADDONSDESC"] = "Addons reconnus pouvant ou étant utilisés pour surveiller le contenu de l'inventaire"
L["Save"] = "Sauvegarder"
L["Scale"] = "Echelle"
L["Scan completed"] = "Balayage terminé"
L["Scanning tradeskill"] = "Balayage en cours"
L["Select skill difficulty threshold"] = "Select skill difficulty threshold"
L["Selected Addon"] = "Addon selectionné"
L["Sells for "] = "Se vend pour"
L["Shopping List"] = "Liste des courses"
L["Skillet Trade Skills"] = "Métiers Skillet" -- Needs review
L["Sold amount"] = "Montant vendu"
L["Sorting"] = "Sorting"
L["Source:"] = "origine de la recette de l'objet"
L["Start"] = "Commencer"
L["Supported Addons"] = "Addons compatibles"
L["TRANSPARAENCYDESC"] = "Transparence de la fenêtre principale"
L["This merchant sells reagents you need!"] = "Ce marchand vend des réactifs dont vous avez besoin!"
L["Total Cost:"] = "Coût total :"
L["Total spent"] = "Total dépensé"
L["Trained"] = "Entraineur"
L["Transparency"] = "Transparence"
L["Unknown"] = "Inconnue"
L["VENDORAUTOBUYDESC"] = "Permet d'acheter automatiquement les réactifs nécessaires a vos crafts en attente si le marchand les propose."
L["VENDORAUTOBUYNAME"] = "Acheter les réactifs automatiquement"
L["VENDORBUYBUTTONDESC"] = "Afficher un bouton en parlant aux vendeurs qui vous permettent d'acheter les composants nécessaires pour toutes les recettes en file d'attente."
L["VENDORBUYBUTTONNAME"] = "Montrer le bouton d'achat de composants chez les vendeurs"
L["alts"] = "alts (rerolls)"
L["bank"] = "banque"
L["buyable"] = "Achetable"
L["can be created from reagents in your inventory"] = "Peut être créé à partir de réactifs dans votre inventaire"
L["can be created from reagents in your inventory and bank"] = "Peut être créé à partir de réactifs dans votre inventaire et votre banque"
L["can be created from reagents on all characters"] = "Peut être créé à partir de réactifs sur tous vos personnages"
L["click here to add a note"] = "Cliquez pour ajouter une note"
L["craftable"] = "pouvant être fabriqué"
L["is now disabled"] = "est maintenant désactivé"
L["is now enabled"] = "est maintenant activé"
L["not yet cached"] = "Pas encore en cache"
L["reagents in inventory"] = "Réactifs dans l'inventaire"

