-- Verification apres import dans MySQL 8.0 / Navicat
USE `dataviz_accidents_2024`;

-- Nombre de lignes dans les quatre tables brutes
SELECT 'caracteristiques' AS objet, COUNT(*) AS lignes FROM `caracteristiques`
UNION ALL SELECT 'lieux', COUNT(*) FROM `lieux`
UNION ALL SELECT 'usagers-2024', COUNT(*) FROM `usagers-2024`
UNION ALL SELECT 'vehicules-2024', COUNT(*) FROM `vehicules-2024`;

-- KPI attendu : 54 402 accidents (la ligne Num_Acc=0 est exclue par la vue)
SELECT COUNT(*) AS accidents_2024 FROM `vue_accidents_2024`;

-- Controle des vues presentes
SELECT TABLE_NAME AS vue FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'dataviz_accidents_2024' ORDER BY TABLE_NAME;

-- Controle de la ligne technique Num_Acc=0 dans la source brute
SELECT COUNT(*) AS lignes_num_acc_zero FROM `caracteristiques` WHERE `Num_Acc` = 0;

-- Controle de l'absence des tables de filtrage Tableau
SELECT TABLE_NAME AS table_temporaire FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'dataviz_accidents_2024' AND TABLE_NAME REGEXP '^#tableau_';
