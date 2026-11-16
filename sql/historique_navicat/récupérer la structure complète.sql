
SELECT
    TABLE_NAME AS nom_table,
    ORDINAL_POSITION AS position_colonne,
    COLUMN_NAME AS nom_colonne,
    COLUMN_TYPE AS type_donnee,
    IS_NULLABLE AS accepte_null,
    COLUMN_KEY AS type_cle,
    EXTRA AS informations_supplementaires
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'dataviz_accidents_2024'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
