
CREATE OR REPLACE VIEW dataviz_accidents_2024.vue_usagers_2024 AS

SELECT
    u.*,
    v.catv,
    v.senc,
    v.manv,
    v.motor

FROM dataviz_accidents_2024.`usagers-2024` u

LEFT JOIN dataviz_accidents_2024.`vehicules-2024` v
    ON u.Num_Acc = v.Num_Acc
    AND u.id_vehicule = v.id_vehicule;





SELECT
    COUNT(*) AS total_usagers,
    COUNT(DISTINCT id_usager) AS usagers_distincts,
    SUM(catv IS NULL) AS usagers_sans_categorie_vehicule,
    COUNT(DISTINCT Num_Acc) AS accidents_concernes
FROM dataviz_accidents_2024.vue_usagers_2024;




SELECT
    c.Num_Acc
FROM dataviz_accidents_2024.caracteristiques c
WHERE NOT EXISTS (
    SELECT 1
    FROM dataviz_accidents_2024.`usagers-2024` u
    WHERE u.Num_Acc = c.Num_Acc
);




SELECT *
FROM dataviz_accidents_2024.caracteristiques
WHERE Num_Acc = 0;





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
    ON c.Num_Acc = l.Num_Acc

WHERE c.Num_Acc <> 0;





SELECT
    COUNT(*) AS total_accidents,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts,
    SUM(nb_lieux) AS total_lieux,
    MAX(nb_lieux) AS maximum_lieux
FROM dataviz_accidents_2024.vue_accidents_2024;




SELECT *
FROM dataviz_accidents_2024.lieux
WHERE Num_Acc = 0;


