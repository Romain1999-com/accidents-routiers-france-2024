
CREATE OR REPLACE VIEW dataviz_accidents_2024.vue_vehicules_2024 AS

SELECT
    v.*,
    COALESCE(u.nb_usagers, 0) AS nb_usagers

FROM dataviz_accidents_2024.`vehicules-2024` v

LEFT JOIN (
    SELECT
        Num_Acc,
        id_vehicule,
        COUNT(*) AS nb_usagers
    FROM dataviz_accidents_2024.`usagers-2024`
    GROUP BY Num_Acc, id_vehicule
) u
    ON v.Num_Acc = u.Num_Acc
    AND v.id_vehicule = u.id_vehicule;




SELECT
    COUNT(*) AS total_vehicules,
    COUNT(DISTINCT Num_Acc, id_vehicule)
        AS vehicules_distincts,
    SUM(nb_usagers) AS total_usagers,
    SUM(nb_usagers = 0)
        AS vehicules_sans_usager,
    MAX(nb_usagers) AS maximum_usagers
FROM dataviz_accidents_2024.vue_vehicules_2024;
