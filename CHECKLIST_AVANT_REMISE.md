# Checklist de remise — TP Data Visualisation Open Data

## Livrables présents dans le dépôt

- [x] 6 tableaux de bord (minimum demandé : 4) et leurs captures.
- [x] Classeur Tableau Desktop `.twbx` (connexion MySQL directe, sans extrait embarqué).
- [x] Export SQL complet : données, 4 tables métier et 5 vues.
- [x] 13 scripts SQL historiques Navicat (non destinés à une exécution en bloc).
- [x] Requêtes de contrôle d'import et résultats d'intégrité.
- [x] Rapport technique Word et PDF.
- [x] Présentation PowerPoint et PDF (12 diapositives).
- [x] README, provenance des données et structure du dépôt.

## Vérifications réalisées et documentées

- [x] URL officielle du jeu de données, producteur et licence renseignés dans `data/README.md`.
- [x] Restauration SQL testée le 16 novembre 2026 dans `dataviz_accidents_2024_test` : 342 545 requêtes sans erreur, 4 tables et 5 vues.
- [x] Contrôle des volumes de la base restaurée.
- [x] Quatre vérifications de relations : 0 référence orpheline détectée sur les relations contrôlées, pour les clés non nulles.
- [x] Captures et fichiers de résultats enregistrés dans `captures/` et `sql/controle/`.

## À terminer avant publication et remise

- [ ] Renseigner la date exacte du téléchargement initial des données.
- [ ] Documenter les dimensions, l'encodage, les séparateurs et la procédure réelle d'import des quatre CSV.
- [ ] Tester la reconnexion Tableau Desktop et les six dashboards après restauration MySQL, puis les interactions.
- [ ] Relever le nom et la version du pilote MySQL effectivement utilisé.
- [ ] Confirmer l'acceptation de Navicat Premium Lite par le formateur si nécessaire.
- [ ] Contrôler les licences, les métadonnées, les secrets et l'historique Git avant publication publique.
- [x] Régénérer `MANIFEST_SHA256.tsv` :42 fichiers contrôlés avec succès.
- [ ] Passer le dépôt GitHub en **Public** et tester l'accès en navigation privée.
- [ ] Vérifier tous les liens du README.
- [ ] Répéter la soutenance (10–15 minutes) et prévoir les captures de secours.

**Attention :** l'export SQL contient des instructions de suppression / recréation. Ne pas l'exécuter dans une base de production ou contenant du travail non sauvegardé.

**Note :** les résultats de restauration documentés ne constituent pas un test indépendant du classeur Tableau sur un autre poste.
