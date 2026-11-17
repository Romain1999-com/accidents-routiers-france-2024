# Checklist de remise — TP Data Visualisation Open Data

## Livrables présents dans le dépôt

- [x] 6 tableaux de bord (minimum demandé : 4) et leurs captures.
- [x] Classeur Tableau Desktop `.twbx` (connexion MySQL directe, sans extrait embarqué).
- [x] Export SQL complet : données, 4 tables métier et 5 vues.
- [x] 13 scripts SQL historiques Navicat (non destinés à une exécution en bloc).
- [x] Requêtes de contrôle d'import et résultats d'intégrité.
- [x] Rapport technique Word et PDF.
- [x] Présentation PowerPoint et PDF.
- [x] README, provenance des données et structure du dépôt.

## Vérifications réalisées et documentées

- [x] URL officielle du jeu de données, producteur et licence renseignés dans `data/README.md`.
- [x] Restauration SQL testée le 16 novembre 2026 dans `dataviz_accidents_2024_test` : 342 545 requêtes sans erreur, 4 tables et 5 vues.
- [x] Contrôle des volumes de la base restaurée.
- [x] Quatre vérifications de relations : 0 référence orpheline détectée sur les relations contrôlées, pour les clés non nulles.
- [x] Captures et fichiers de résultats enregistrés dans `captures/` et `sql/controle/`.

## Suivi documentaire après la soutenance

- [ ] Renseigner la date exacte du téléchargement initial des données.
- [ ] Documenter les dimensions, l'encodage, les séparateurs et la procédure réelle d'import des quatre CSV.
- [ ] Tester la reconnexion Tableau Desktop et les six dashboards après restauration MySQL, puis les interactions.
- [ ] Relever le nom et la version du pilote MySQL effectivement utilisé.
- [ ] Confirmer l'acceptation de Navicat Premium Lite par le formateur si nécessaire.
- [ ] Recontrôler les licences, les métadonnées, les secrets et l'historique Git après les dernières modifications (dépôt déjà public).
- [x] Générer et contrôler localement `MANIFEST_SHA256.tsv` pour 54 fichiers (`--write`, puis `--check`), avant les dernières corrections documentaires.
- [ ] Après correction du README et de cette checklist, régénérer et republier le manifeste pour qu'il reflète les empreintes actuelles.
- [x] Dépôt GitHub en **Public** (visibilité confirmée le 17 novembre 2026).
- [ ] Tester l'accès anonyme au dépôt en navigation privée.
- [ ] Vérifier tous les liens du README.
- [x] Soutenance orale effectuée (confirmation de l'auteur).
- [x] Exécuter une première recherche indicative de secrets (`--scan`) : aucun motif détecté lors du contrôle local antérieur.
- [ ] Après synchronisation de ces corrections GitHub vers la copie locale, relancer `python scripts/preparer_publication.py --scan`, `--write`, puis `--check`, puis publier le manifeste mis à jour.

**Attention :** l'export SQL contient des instructions de suppression / recréation. Ne pas l'exécuter dans une base de production ou contenant du travail non sauvegardé.

**Note :** les résultats de restauration documentés ne constituent pas un test indépendant du classeur Tableau sur un autre poste.
