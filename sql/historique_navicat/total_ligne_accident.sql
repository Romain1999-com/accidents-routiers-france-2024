
CREATE OR REPLACE VIEW dataviz_accidents_2024.vue_accidents_2024 AS

SELECT
    c.*,
    COALESCE(l.nb_lieux, 0) AS nb_lieux

FROM dataviz_accidents_2024.caracteristiques c

LEFT JOIN (
    SELECT
        Num_Acc,
        COUNT(*) AS nb_lieux
    FROM dataviz_accidents_2024.lieux
    GROUP BY Num_Acc
) l
    ON c.Num_Acc = l.Num_Acc;




SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts,
    SUM(nb_lieux) AS total_lieux,
    MAX(nb_lieux) AS maximum_lieux
FROM dataviz_accidents_2024.vue_accidents_2024;
