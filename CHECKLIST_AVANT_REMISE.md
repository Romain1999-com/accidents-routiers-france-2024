# Checklist de remise — TP Data Visualisation Open Data

## Déjà inclus dans le dossier

- [x] 6 tableaux de bord (minimum demandé : 4)
- [x] Captures des 6 dashboards
- [x] Classeur Tableau Desktop `.twbx`
- [x] Export SQL complet (4 tables métier + données + 5 vues)
- [x] 13 scripts SQL historiques Navicat
- [x] Requêtes de contrôle d'import
- [x] Rapport technique final Word/PDF
- [x] Présentation PowerPoint (12 diapositives)
- [x] README et arborescence du dépôt

## Vérifications indispensables avant dépôt GitHub

- [x] Documenter l'URL officielle, le producteur et la licence dans data/README.md.
- [ ] Renseigner la date exacte du téléchargement initial des données.
- [ ] Documenter le format et la procédure réelle d'import des fichiers sources.
- [ ] Tester la restauration sur une base MySQL vide et exécuter `sql/controle/verification_import_2024.sql`.
- [ ] Tester la connexion et les six dashboards dans Tableau Desktop après réimport.
- [ ] Vérifier le pilote MySQL utilisé et noter sa version sans exposer d'identifiants sensibles.
- [ ] Confirmer l'acceptation de Navicat Premium Lite si exigée par le formateur.
- [ ] Vérifier les licences, la présence éventuelle de données sensibles et les métadonnées avant publication.
- [ ] Publier sur GitHub et tester les liens du README.
- [ ] Répéter la soutenance (10–15 min), captures de secours disponibles.

**Avertissement :** l'export SQL contient des instructions de suppression/recréation de tables et vues. Ne pas l'exécuter dans une base de production ou une base contenant du travail non sauvegardé.
