
USE dataviz_accidents_2024;

CREATE OR REPLACE VIEW vue_cartographie_2024 AS
SELECT
    c.*,

    CASE
        WHEN c.lat IS NOT NULL
         AND c.`long` IS NOT NULL
         AND TRIM(c.lat) NOT IN ('', '0')
         AND TRIM(c.`long`) NOT IN ('', '0')
         AND CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8))
             BETWEEN -90 AND 90
         AND CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8))
             BETWEEN -180 AND 180
        THEN CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8))
        ELSE NULL
    END AS latitude_carte,

    CASE
        WHEN c.lat IS NOT NULL
         AND c.`long` IS NOT NULL
         AND TRIM(c.lat) NOT IN ('', '0')
         AND TRIM(c.`long`) NOT IN ('', '0')
         AND CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8))
             BETWEEN -90 AND 90
         AND CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8))
             BETWEEN -180 AND 180
        THEN CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8))
        ELSE NULL
    END AS longitude_carte

FROM vue_accidents_2024 c;






SELECT
    COUNT(*) AS total_accidents,
    SUM(
        latitude_carte IS NOT NULL
        AND longitude_carte IS NOT NULL
    ) AS accidents_cartographiables,
    SUM(
        latitude_carte IS NULL
        OR longitude_carte IS NULL
    ) AS accidents_sans_gps
FROM dataviz_accidents_2024.vue_cartographie_2024;





USE dataviz_accidents_2024;

CREATE OR REPLACE VIEW vue_cartographie_2024 AS
SELECT
    c.*,

    CASE
        WHEN c.lat IS NOT NULL
         AND c.`long` IS NOT NULL
         AND TRIM(c.lat) REGEXP '^-?[0-9]+([.,][0-9]+)?$'
         AND TRIM(c.`long`) REGEXP '^-?[0-9]+([.,][0-9]+)?$'
         AND CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8)) <> 0
         AND CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8)) <> 0
         AND CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8))
             BETWEEN -90 AND 90
         AND CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8))
             BETWEEN -180 AND 180
        THEN CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8))
        ELSE NULL
    END AS latitude_carte,

    CASE
        WHEN c.lat IS NOT NULL
         AND c.`long` IS NOT NULL
         AND TRIM(c.lat) REGEXP '^-?[0-9]+([.,][0-9]+)?$'
         AND TRIM(c.`long`) REGEXP '^-?[0-9]+([.,][0-9]+)?$'
         AND CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8)) <> 0
         AND CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8)) <> 0
         AND CAST(REPLACE(c.lat, ',', '.') AS DECIMAL(12,8))
             BETWEEN -90 AND 90
         AND CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8))
             BETWEEN -180 AND 180
        THEN CAST(REPLACE(c.`long`, ',', '.') AS DECIMAL(12,8))
        ELSE NULL
    END AS longitude_carte

FROM vue_accidents_2024 c;




SELECT
    COUNT(*) AS total_accidents,

    SUM(
        latitude_carte IS NOT NULL
        AND longitude_carte IS NOT NULL
    ) AS accidents_cartographiables,

    SUM(
        latitude_carte IS NULL
        OR longitude_carte IS NULL
    ) AS accidents_sans_gps

FROM dataviz_accidents_2024.vue_cartographie_2024;





USE dataviz_accidents_2024;

SELECT
    COUNT(*) AS total_accidents,

    SUM(`long` = 0)
        AS zeros_ancienne_methode,

    SUM(
        CAST(REPLACE(`long`, ',', '.')
        AS DECIMAL(12,8)) = 0
    ) AS zeros_reels,

    SUM(
        `long` LIKE '0,%'
        OR `long` LIKE '-0,%'
    ) AS longitudes_proches_zero

FROM vue_accidents_2024;





SELECT
    COUNT(*) AS total_accidents_2A,
    SUM(
        latitude_carte NOT BETWEEN 41 AND 43.1
        OR longitude_carte NOT BETWEEN 8.5 AND 9.7
    ) AS coordonnees_hors_corse
FROM dataviz_accidents_2024.vue_cartographie_2024
WHERE dep = '2A';
