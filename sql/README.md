# Scripts SQL

- `base_complete/dataviz_accidents_2024_propre.sql` : export intégral MySQL, avec données, 4 tables et 5 vues. **Attention : DROP TABLE / DROP VIEW**.
- `base_complete/schema_et_vues_2024.sql` : structure et définitions des vues, sans données.
- `controle/verification_import_2024.sql` : requêtes de contrôle après import / restauration.
- `controle/verification technique.csv` et `controle/verification_restauration.txt` : résultats de quatre contrôles d'intégrité (0 anomalie pour les relations testées).
- `historique_navicat/` : 13 scripts de travail archivés pour la traçabilité ; certains modifient les données et ne doivent pas être exécutés automatiquement.

L'export propre exclut huit tables techniques `#tableau_..._filter` générées par Tableau. Les quatre tables métier et les cinq vues sont conservées.

**Mise à jour du 16 novembre 2026 :** une restauration a ensuite été réalisée dans `dataviz_accidents_2024_test` ; les contrôles consignés font état de 342 545 requêtes exécutées sans erreur, de quatre tables et cinq vues restaurées, et de quatre vérifications de relations sans référence orpheline détectée (pour les clés non nulles). Voir `../data/README.md` et les captures techniques. Le rafraîchissement du classeur Tableau sur une base réimportée reste à valider.
