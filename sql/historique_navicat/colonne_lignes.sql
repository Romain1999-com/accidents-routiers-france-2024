USE dataviz_accidents_2024;

CREATE TABLE lieux (
    Num_Acc BIGINT PRIMARY KEY,
    catr TINYINT,
    voie VARCHAR(100),
    v1 VARCHAR(20),
    v2 VARCHAR(20),
    circ TINYINT,
    nbv VARCHAR(10),
    vosp TINYINT,
    prof TINYINT,
    pr VARCHAR(20),
    pr1 VARCHAR(20),
    plan TINYINT,
    lartpc VARCHAR(20),
    larrout VARCHAR(20),
    surf TINYINT,
    infra TINYINT,
    situ TINYINT,
    vma SMALLINT
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4;



SHOW TABLES;


SELECT COUNT(*) AS nombre_lieux
FROM dataviz_accidents_2024.lieux;



USE dataviz_accidents_2024;

ALTER TABLE lieux
    DROP PRIMARY KEY,
    ADD COLUMN id_lieu BIGINT UNSIGNED
        NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
    ADD INDEX idx_lieux_num_acc (Num_Acc);
    
    
    DESCRIBE lieux;
    
    
    
    SELECT
    COUNT(*) AS nombre_lignes,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts
FROM lieux;
    
    
    
    
SELECT *
FROM dataviz_accidents_2024.lieux
LIMIT 20;


ALTER TABLE dataviz_accidents_2024.lieux
MODIFY COLUMN nbv VARCHAR(20);


--TRUNCATE TABLE dataviz_accidents_2024.lieux;


SELECT COUNT(*) AS nombre_lieux
FROM dataviz_accidents_2024.lieux;



--TRUNCATE TABLE dataviz_accidents_2024.lieux;



SELECT COUNT(*) AS nombre_lieux
FROM dataviz_accidents_2024.lieux;


SELECT
    COUNT(*) AS nombre_lignes,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts
FROM dataviz_accidents_2024.lieux;



SELECT
    COUNT(*) AS nombre_lignes,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts
FROM dataviz_accidents_2024.caracteristiques;


SELECT
    COUNT(*) AS accidents_sans_lieu
FROM dataviz_accidents_2024.caracteristiques c
LEFT JOIN (
    SELECT DISTINCT Num_Acc
    FROM dataviz_accidents_2024.lieux
) l
    ON c.Num_Acc = l.Num_Acc
WHERE l.Num_Acc IS NULL;




SELECT
    Num_Acc,
    COUNT(*) AS nombre_occurrences
FROM dataviz_accidents_2024.lieux
GROUP BY Num_Acc
HAVING COUNT(*) > 1
ORDER BY nombre_occurrences DESC
LIMIT 20;





SELECT *
FROM dataviz_accidents_2024.lieux
WHERE Num_Acc = 202400050330
ORDER BY id_lieu;






SELECT
    COUNT(*) AS accidents_avec_plusieurs_lieux,
    SUM(nombre_lieux) AS lignes_concernees,
    MAX(nombre_lieux) AS maximum_lieux
FROM (
    SELECT
        Num_Acc,
        COUNT(*) AS nombre_lieux
    FROM dataviz_accidents_2024.lieux
    GROUP BY Num_Acc
    HAVING COUNT(*) > 1
) AS t;





SELECT
    nombre_lieux,
    COUNT(*) AS nombre_accidents
FROM (
    SELECT
        Num_Acc,
        COUNT(*) AS nombre_lieux
    FROM dataviz_accidents_2024.lieux
    GROUP BY Num_Acc
) AS t
GROUP BY nombre_lieux
ORDER BY nombre_lieux;




SELECT
    COUNT(*) AS lieux_sans_accident
FROM dataviz_accidents_2024.lieux l
LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON l.Num_Acc = c.Num_Acc
WHERE c.Num_Acc IS NULL;





SHOW INDEX
FROM dataviz_accidents_2024.caracteristiques;

SHOW INDEX
FROM dataviz_accidents_2024.lieux;




SHOW COLUMNS
FROM dataviz_accidents_2024.caracteristiques
LIKE 'Num_Acc';

SHOW COLUMNS
FROM dataviz_accidents_2024.lieux
LIKE 'Num_Acc';





ALTER TABLE dataviz_accidents_2024.lieux
ADD CONSTRAINT fk_lieux_caracteristiques
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
  AND TABLE_NAME = 'lieux'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
