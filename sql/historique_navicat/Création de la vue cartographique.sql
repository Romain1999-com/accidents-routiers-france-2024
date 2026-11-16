
CREATE OR REPLACE VIEW
dataviz_accidents_2024.vue_cartographie_2024 AS

SELECT
    c.*,

    CASE
        WHEN c.lat <> 0
         AND c.`long` <> 0
         AND c.lat BETWEEN -90 AND 90
         AND c.`long` BETWEEN -180 AND 180
        THEN c.lat
        ELSE NULL
    END AS latitude_carte,

    CASE
        WHEN c.lat <> 0
         AND c.`long` <> 0
         AND c.lat BETWEEN -90 AND 90
         AND c.`long` BETWEEN -180 AND 180
        THEN c.`long`
        ELSE NULL
    END AS longitude_carte

FROM dataviz_accidents_2024.vue_accidents_2024 c;




SELECT
    COUNT(*) AS total_accidents,

    SUM(
        latitude_carte IS NOT NULL
        AND longitude_carte IS NOT NULL
    ) AS accidents_cartographiables,

    SUM(
        latitude_carte IS NULL
        OR longitude_carte IS NULL
    ) AS accidents_sans_gps_exploitable

FROM dataviz_accidents_2024.vue_cartographie_2024;
