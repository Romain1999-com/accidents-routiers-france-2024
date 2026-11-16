
SELECT
    COUNT(*) AS nombre_lignes,
    COUNT(DISTINCT id_vehicule) AS vehicules_distincts,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts
FROM dataviz_accidents_2024.`vehicules-2024`;




SELECT
    COUNT(*) AS vehicules_sans_accident
FROM dataviz_accidents_2024.`vehicules-2024` v
LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON v.Num_Acc = c.Num_Acc
WHERE c.Num_Acc IS NULL;




ALTER TABLE dataviz_accidents_2024.`vehicules-2024`
ADD CONSTRAINT fk_vehicules_caracteristiques
FOREIGN KEY (Num_Acc)
REFERENCES dataviz_accidents_2024.caracteristiques(Num_Acc);




SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'dataviz_accidents_2024'
  AND TABLE_NAME = 'vehicules-2024'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
