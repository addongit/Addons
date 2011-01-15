﻿local L = LibStub("AceLocale-3.0"):NewLocale("AuctionLite", "frFR");
if not L then return end

L["%dh"] = "%dh"
L["(none set)"] = "(rien appliqué)" -- Needs review
L["Accept"] = "Accepter"
L["Add a new item to a favorites list by entering the name here."] = "Permet d'ajout un nouvel objet dans la liste des favoris actuelle en entrant son nom ici."
L["Add an Item"] = "Ajouter un objet"
L["Advanced"] = "Avancé"
L["Always"] = "Toujours"
L["Amount to multiply by vendor price to get default sell price."] = "Le nombre de fois qu'il faut multiplier le prix du marchand pour obtenir le prix de vente par défaut."
L["Approve"] = "Approuver"
L["Auction"] = "Enchère"
L["Auction creation is already in progress."] = "La création d'enchères est déjà en cours."
L["Auction house data cleared."] = "Données de l'hôtel des ventes effacées."
L["Auction scan skipped (control key is down)"] = "Analyse des ventes annulée (Touche Contrôle enfoncée)"
L["AuctionLite"] = "AuctionLite"
L["AuctionLite - Buy"] = "AuctionLite - Achat"
L["AuctionLite - Sell"] = "AuctionLite - Vente"
L["AuctionLite Buy"] = "Achat AuctionLite"
L["AuctionLite Sell"] = "Vente AuctionLite"
L["AuctionLite v%s loaded!"] = "AuctionLite v%s chargé !"
L["Batch %d: %d at %s"] = "Lot %d : %d à %s"
L["Bid Per Item"] = "Enchère par objet"
L["Bid Price"] = "Prix d'enchère"
L["Bid Total"] = "Total de l'enchère"
L["Bid Undercut"] = "Cassage de prix (enchères)"
L["Bid cost for %d:"] = "Coût d'enchère pour %d :"
L["Bid on %dx %s (%d |4listing:listings; at %s)."] = "Enchère sur %dx %s (%d |4listing:listings; à %s)."
L["Bought %dx %s (%d |4listing:listings; at %s)."] = "Achat de %dx %s (%d |4listing:listings; à %s)."
L["Buy Tab"] = "Onglet d'achat"
L["Buyout Per Item"] = "Achat par objet"
L["Buyout Price"] = "Prix d'achat"
L["Buyout Total"] = "Total de l'achat"
L["Buyout Undercut"] = "Cassage de prix (achats)"
L["Buyout cannot be less than starting bid."] = "Le prix d'achat ne peut être inférieur au prix de départ."
L["Buyout cost for %d:"] = "Coût d'achat pour %d :"
L["CANCEL_CONFIRM_TEXT"] = "Certaines de vos enchères ont reçus des offres. Souhaitez-vous annuler toutes vos enchères, seulement celles sans offres, ou ne rien faire ?"
L["CANCEL_NOTE"] = [=[AuctionLite peut uniquement annuler un objet par clic suite à une restriction imposée par Blizzard. De ce fait, seule une de vos enchères a été annulée.

Pour contourner ce problème, vous pouvez continuer à cliquer sur le bouton "Annuler" jusqu'à ce que toutes les enchères désirées soient annulées.]=]
L["CANCEL_TOOLTIP"] = [=[|cffffffffClic gauche :|r Annuler toutes le enchères
|cffffffffCtrl-Clic gauche :|r Annuler les enchères concurrencées]=]
L["CLEAR_DATA_WARNING"] = "Êtes-vous sûr de vouloir supprimer toutes les données des prix de l'hôtel des ventes récoltées par AuctionLite ?"
L["Cancel"] = "Annuler"
L["Cancel All"] = "Tout annuler"
L["Cancel All Auctions"] = "Annuler toutes le enchères"
L["Cancel Unbid"] = "Annuler celles sans offres"
L["Cancel Undercut Auctions"] = "Annuler les enchères concurrencées"
L["Cancelled %d listings of %s"] = "%d listings |2 %s ont été annulés."
L["Cancelled %d |4listing:listings; of %s."] = "%d |4listing:listings; de %s annulé(s)."
L["Choose a favorites list to edit."] = "Choisissez la liste des favoris à éditer."
L["Choose which tab is selected when opening the auction house."] = "Choississez l'onglet à afficher lors de l'ouverture de la fenêtre de l'hôtel des ventes."
L["Clear All"] = "Tout effacer"
L["Clear All Data"] = "Effacer les données"
L["Clear all auction house price data."] = "Efface toutes les données des prix de l'hôtel des ventes."
L["Competing Auctions"] = "Enchères concurrentes"
L["Configure"] = "Configurer"
L["Configure AuctionLite"] = "Configurer AuctionLite"
L["Consider Resale Value When Buying"] = "Considérer la valeur de revente lors de l'achat"
L["Consider resale value of excess items when filling an order on the \"Buy\" tab."] = "Considère la valeur de revente des objets en excès lors d'une commande dans l'onglet \"Achat\"."
L["Create a new favorites list."] = "Créée une nouvelle liste des favoris"
L["Created %d |4auction:auctions; of %s x%d (%s total)."] = "%d |4enchère crée:enchères créées; |2 %s x%d (%s au total)."
L["Created %d |4auction:auctions; of %s x%d."] = "%d |4enchère:enchères; |2 %s x%d créée(s)."
L["Current: %s (%.2fx historical)"] = "Actuel : %s (%.2fx l'historique)"
L["Current: %s (%.2fx historical, %.2fx vendor)"] = "Actuel : %s (%.2fx l'historique, %.2fx le prix marchand)"
L["Current: %s (%.2fx vendor)"] = "Actuel : %s (%.2fx le prix marchand)"
L["Deals must be below the historical price by this much gold."] = "Les bonnes affaires doivent être en dessous des prix historiques d'au moins ce montant d'or."
L["Deals must be below the historical price by this percentage."] = "Les bonnes affaires doivent être en dessous des prix historiques d'au moins ce pourcentage."
L["Default"] = "Défaut"
L["Default Number of Stacks"] = "Nombre de piles par défaut"
L["Default Stack Size"] = "Taille par défaut de la pile"
L["Delete"] = "Suppr."
L["Delete the selected favorites list."] = "Supprime la liste des favoris actuelle."
L["Disable"] = "Désactiver"
L["Disenchant"] = "Désenchanter"
L["Do Nothing"] = "Ne rien faire"
L["Do it!"] = "Le faire !"
L["Enable"] = "Activer"
L["Enter item name and click \"Search\""] = "Entrez le nom de l'objet et cliquez sur \"Recherche\"."
L["Enter the name of the new favorites list:"] = "Entrez le nom de la nouvelle liste des favoris :"
L["Error locating item in bags.  Please try again!"] = "Erreur lors de la localisation de l'objet dans les sacs. Veuillez réessayer !"
L["Error when creating auctions."] = "Erreur lors de la création des enchères."
L["FAST_SCAN_AD"] = [=[L'analyse rapide des enchères d'AuctionLite est capable d'analyser tout l'hôtel des ventes en quelques secondes.

Cependant, selon votre connexion, une analyse rapide peut vous déconnecter du serveur. Si cela arrive, vous pouvez désactiver l'analyse rapide dans la fenêtre des options d'AuctionLite.

Activer l'analyse rapide des enchères ?]=]
L["Fast Auction Scan"] = "Analyse rapide des enchères"
L["Fast auction scan disabled."] = "Analyse rapide des enchères désactivée."
L["Fast auction scan enabled."] = "Analyse rapide des enchères activée."
L["Favorites"] = "Favoris"
L["Full Scan"] = "Analyser"
L["Full Stack"] = "Pile complète"
L["Historical Price"] = "Historique des prix"
L["Historical price for %d:"] = "Prix historique pour %d :"
L["Historical: %s (%d |4listing:listings;/scan, %d |4item:items;/scan)"] = "Historique : %s (%d |4listing:listings;/analyse, %d |4objet:objets;/analyse)"
L["If Applicable"] = "Si applicable"
L["Invalid starting bid."] = "Prix de départ invalide."
L["Item"] = "Objet"
L["Item Summary"] = "Résumé de l'objet"
L["Items"] = "Objets"
L["Last Used Tab"] = "Dernier onglet utilisé"
L["Listings"] = "Listings"
L["Market Price"] = "Prix du marché"
L["Max Stacks"] = "Le plus de piles"
L["Max Stacks + Excess"] = "Le plus de piles + excès"
L["Member Of"] = "Membre de"
L["Minimum Profit (Gold)"] = "Profit minimal (Or)"
L["Minimum Profit (Pct)"] = "Profit minimal (Pct)"
L["Name"] = "Nom"
L["Net cost for %d:"] = "Coût net pour %d :"
L["Never"] = "Jamais"
L["New..."] = "Nouveau"
L["No current auctions"] = "Aucune enchère pour le moment"
L["No deals found"] = "Aucune bonne affaire trouvée"
L["No items found"] = "Aucun objet trouvé"
L["Not enough cash for deposit."] = "Pas assez d'argent pour le dépôt."
L["Not enough items available."] = "Pas assez d'objets disponibles."
L["Note: %d |4listing:listings; of %d |4item was:items were; not purchased."] = "Note : %d |4listing:listings; de %d |4objet n'a pas été acheté:objets n'ont pas été achetés;."
L["Number of Items"] = "Nombre d'objets"
L["Number of Items |cff808080(max %d)|r"] = "Nombre d'objets |cff808080(max %d)|r"
L["Number of stacks suggested when an item is first placed in the \"Sell\" tab."] = "Le nombre de piles suggéré quand un objet est placé en premier dans l'onglet \"Vente\"."
L["On the summary view, show how many listings/items are yours."] = "Affiche sur la  vue récapitulative combien de listings/objets sont à vous."
L["One Item"] = "Un objet"
L["One Stack"] = "Une pile"
L["Open All Bags at AH"] = "Ouvrir tous les sacs à l'HV"
L["Open all your bags when you visit the auction house."] = "Ouvre tous vos sacs quand vous visitez l'hôtel des ventes."
L["Open configuration dialog"] = "Ouvre la fenêtre de configuration."
L["Percent to undercut market value for bid prices (0-100)."] = "Le pourcentage du cassage des prix du marché pour les prix des enchères (0-100)."
L["Percent to undercut market value for buyout prices (0-100)."] = "Le pourcentage du cassage des prix du marché pour les prix des achats (0-100)."
L["Potential Profit"] = "Profit potentiel"
L["Pricing Method"] = "Méthode d'évaluation"
L["Print Detailed Price Data"] = "Afficher les données détaillées des prix"
L["Print detailed price data when selling an item."] = "Affiche le détails des données des prix lors de la vente d'un objet."
L["Profiles"] = "Profils"
L["Qty"] = "Qté"
L["Remove Items"] = "Enlever les objets"
L["Remove the selected items from the current favorites list."] = "Supprime les objets sélectionnés de la liste des favoris actuelle."
L["Resell %d:"] = "Revente %d :"
L["Round Prices"] = "Prix arrondis"
L["Round all prices to this granularity, or zero to disable (0-1)."] = "Arrondit tous les prix selon cette granularité, ou zéro pour désactiver (0-1)."
L["Save All"] = "Tout sauver"
L["Saved Item Settings"] = "Paramètres d'objet sauvegardés"
L["Scan complete.  Try again later to find deals!"] = "Analyse terminée. Essayez à nouveau plus tard pour trouver de bonnes  affaires !"
L["Scanning..."] = "Analyse..."
L["Scanning:"] = "Analyse :"
L["Search"] = "Recherche"
L["Searching:"] = "Recherche :"
L["Select a Favorites List"] = "Sélectionnez une liste de favoris"
L["Selected Stack Size"] = "Taille de la pile choisie"
L["Sell Tab"] = "Onglet de vente"
L["Show Auction Value"] = "Afficher la valeur aux enchères"
L["Show Deals"] = "Afficher les bonnes affaires"
L["Show Disenchant Value"] = "Afficher la valeur désenchantée"
L["Show Favorites"] = "Afficher les favoris"
L["Show Full Stack Price"] = "Afficher le prix de la pile"
L["Show How Many Listings are Mine"] = "Afficher combien de listings sont à moi"
L["Show My Auctions"] = "Afficher mes enchères"
L["Show Vendor Price"] = "Afficher le prix des marchands"
L["Show auction house value in tooltips."] = "Affiche la valeur de l'hôtel des ventes dans les bulles d'aide."
L["Show expected disenchant value in tooltips."] = "Affiche la valeur attendue si désenchanté(e) dans les bulles d'aide."
L["Show full stack prices in tooltips (shift toggles on the fly)."] = "Affiche les prix des piles dans les bulles d'aide (shift pour le faire à la volée)"
L["Show vendor sell price in tooltips."] = "Affiche le prix d'achat des marchands dans les bulles d'aide."
L["Stack Count"] = "Nombre de piles" -- Needs review
L["Stack Size"] = "Taille de la pile"
L["Stack size suggested when an item is first placed in the \"Sell\" tab."] = "La taille de la pile suggérée quand un objet est placé en premier dans l'onglet \"Vente\"."
L["Stack size too large."] = "Taille de la pile trop grande."
L["Start Tab"] = "Onglet de départ"
L["Store Price Data"] = "Enregistrer les données des prix"
L["Store price data for all items seen (disable to save memory)."] = "Enregistre les données des prix de tous les objets vus (désactiver pour économiser la mémoire)."
L["Time Elapsed:"] = "Temps écoulé :"
L["Time Remaining:"] = "Temps restant :"
L["Tooltips"] = "Bulles d'aide"
L["Use Coin Icons in Tooltips"] = "Utiliser les icônes des pièces"
L["Use fast method for full scans (may cause disconnects)."] = "Utilise une méthode rapide pour les analyses complètes (peut causer des déconnexions)."
L["Uses the standard gold/silver/copper icons in tooltips."] = "Utilise les icônes standards de l'or/l'argent/le bronze dans les bulles d'aide."
L["VENDOR_WARNING"] = "Votre prix d'achat immédiat est inférieur au prix du marchand. Voulez-vous tout de même créer cette enchère ?"
L["Vendor"] = "Marchand"
L["Vendor Multiplier"] = "Multiplicateur marchand"
L["Vendor: %s"] = "Marchand : %s"
L["per item"] = "par objet"
L["per stack"] = "par pile"
L["stacks of"] = "piles de"
L["|cff00ff00Scanned %d listings.|r"] = "|cff00ff00%d |4listing analysé:listings analysés;.|r"
L["|cff00ff00Using previous price.|r"] = "|cff00ff00Utilisation du prix précédent.|r"
L["|cff808080(per item)|r"] = "|cff808080(par objet)|r"
L["|cff808080(per stack)|r"] = "|cff808080(par pile)|r"
L["|cff8080ffData for %s x%d|r"] = "|cff8080ffDonnées pour %s x%d|r"
L["|cffff0000Buyout less than bid.|r"] = "|cffff0000Achat inférieur à l'enchère.|r"
L["|cffff0000Buyout less than vendor price.|r"] = "|cffff0000Achat inférieur au prix marchand.|r"
L["|cffff0000Invalid stack size/count.|r"] = "|cffff0000Nbre/Pile invalide.|r"
L["|cffff0000No bid price set.|r"] = "|cffff0000Aucun prix de départ définit.|r"
L["|cffff0000Not enough cash for deposit.|r"] = "|cffff0000Pas assez d'argent pour le dépôt.|r"
L["|cffff0000Not enough items available.|r"] = "|cffff0000Pas assez d'objets disponibles.|r"
L["|cffff0000Stack size too large.|r"] = "|cffff0000Taille de la pile trop grande.|r"
L["|cffff0000Using %.3gx vendor price.|r"] = "|cffff0000Utilisation de %.3gx le prix marchand.|r"
L["|cffff0000[Error]|r Insufficient funds."] = "|cffff0000[Erreur]|r Fonds insuffisants."
L["|cffff0000[Warning]|r Skipping your own auctions.  You might want to cancel them instead."] = "|cffff0000[Attention]|r Vos propres enchères ont été ignorées. Vous devriez plutôt les annuler."
L["|cffff7030Buyout less than vendor price.|r"] = "|cffff7030Achat immédiat inférieur au prix du marchand.|r"
L["|cffff7030Stack %d will have %d |4item:items;.|r"] = "|cffff7030La %dème pile aura %d |4objet:objets;.|r"
L["|cffffd000Using historical data.|r"] = "|cffffd000Utilisation des données historiques.|r"
L["|cffffff00Scanning: %d%%|r"] = "|cffffff00Analyse : %d%%|r"

