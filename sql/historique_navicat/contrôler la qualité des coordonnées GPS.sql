
SELECT
    grav,
    COUNT(*) AS nombre_usagers
FROM dataviz_accidents_2024.vue_usagers_2024
GROUP BY grav
ORDER BY grav;



SELECT
    mois,
    COUNT(*) AS nombre_accidents
FROM dataviz_accidents_2024.vue_accidents_2024
GROUP BY mois
ORDER BY mois;




SELECT
    lum,
    COUNT(*) AS nombre_accidents
FROM dataviz_accidents_2024.vue_accidents_2024
GROUP BY lum
ORDER BY lum;




CREATE OR REPLACE VIEW
dataviz_accidents_2024.vue_luminosite_2024 AS

SELECT
    lum,

    CASE lum
        WHEN 1 THEN 'Plein jour'
        WHEN 2 THEN 'Crépuscule ou aube'
        WHEN 3 THEN 'Nuit sans éclairage public'
        WHEN 4 THEN 'Nuit - éclairage non allumé'
        WHEN 5 THEN 'Nuit - éclairage allumé'
        ELSE 'Non renseigné'
    END AS luminosite,

    COUNT(*) AS nombre_accidents

FROM dataviz_accidents_2024.vue_accidents_2024

GROUP BY lum;




SELECT *
FROM dataviz_accidents_2024.vue_luminosite_2024
ORDER BY lum;



SELECT
    dep,
    COUNT(*) AS nombre_accidents
FROM dataviz_accidents_2024.vue_accidents_2024
GROUP BY dep
ORDER BY nombre_accidents DESC
LIMIT 15;




SELECT
    Num_Acc,
    dep,
    lat,
    `long`
FROM dataviz_accidents_2024.vue_accidents_2024
WHERE lat IS NOT NULL
  AND `long` IS NOT NULL
LIMIT 20;



SELECT
    COUNT(*) AS total_accidents,

    SUM(
        lat IS NULL OR `long` IS NULL
    ) AS coordonnees_manquantes,

    SUM(
        lat = 0 OR `long` = 0
    ) AS coordonnees_zero,

    SUM(
        lat NOT BETWEEN -90 AND 90
        OR `long` NOT BETWEEN -180 AND 180
    ) AS coordonnees_invalides

FROM dataviz_accidents_2024.vue_accidents_2024;






SELECT
    COUNT(*) AS total_accidents,

    SUM(lat = 0 AND `long` = 0)
        AS latitude_et_longitude_zero,

    SUM(lat = 0 AND `long` <> 0)
        AS latitude_zero_uniquement,

    SUM(lat <> 0 AND `long` = 0)
        AS longitude_zero_uniquement,

    SUM(lat <> 0 AND `long` <> 0)
        AS coordonnees_sans_zero

FROM dataviz_accidents_2024.vue_accidents_2024;





SELECT
    dep,
    COUNT(*) AS accidents_longitude_zero,
    MIN(lat) AS latitude_min,
    MAX(lat) AS latitude_max
FROM dataviz_accidents_2024.vue_accidents_2024
WHERE `long` = 0
GROUP BY dep
ORDER BY accidents_longitude_zero DESC
LIMIT 20;
