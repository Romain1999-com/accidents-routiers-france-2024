
USE dataviz_accidents_2024;

SELECT
    Num_Acc,
    lat,
    `long`,
    CAST(REPLACE(lat, ',', '.') AS DECIMAL(12,8))
        AS latitude_numerique,
    CAST(REPLACE(`long`, ',', '.') AS DECIMAL(12,8))
        AS longitude_numerique
FROM caracteristiques
WHERE lat IS NOT NULL
  AND `long` IS NOT NULL
  AND TRIM(lat) NOT IN ('', '0')
  AND TRIM(`long`) NOT IN ('', '0')
LIMIT 20;
