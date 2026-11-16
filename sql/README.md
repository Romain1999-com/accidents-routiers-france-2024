# Scripts SQL

- `base_complete/dataviz_accidents_2024_propre.sql` : export intégral MySQL, données + tables + vues. **Attention : DROP TABLE / DROP VIEW**.
- `base_complete/schema_et_vues_2024.sql` : structure et définitions des vues sans données ; pour documentation.
- `controle/verification_import_2024.sql` : requêtes de contrôle à exécuter après restauration.
- `historique_navicat/` : 13 scripts de travail, archivés à titre de preuve et de traçabilité. Certains modifient des objets : ne pas les exécuter automatiquement.

L'export propre exclut huit tables techniques `#tableau_..._filter` générées lors de l'utilisation de Tableau. Les quatre tables métier et les cinq vues sont conservées. La restauration n'a pas été testée sur un serveur MySQL dans l'environnement d'assemblage.
