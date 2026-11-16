
SELECT
    COUNT(*) AS nombre_usagers,
    COUNT(DISTINCT id_usager) AS usagers_distincts,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts,
    SUM(an_nais IS NULL) AS annees_naissance_nulles,
    SUM(an_nais = 0) AS annees_naissance_zero
FROM dataviz_accidents_2024.`usagers-2024`;








SELECT COUNT(*) AS usagers_sans_accident
FROM dataviz_accidents_2024.`usagers-2024` u
LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON u.Num_Acc = c.Num_Acc
WHERE c.Num_Acc IS NULL;




SELECT COUNT(*) AS usagers_sans_vehicule
FROM dataviz_accidents_2024.`usagers-2024` u
LEFT JOIN dataviz_accidents_2024.`vehicules-2024` v
    ON u.Num_Acc = v.Num_Acc
    AND u.id_vehicule = v.id_vehicule
WHERE v.id_vehicule IS NULL;




SELECT
    u.id_usager,
    u.Num_Acc,
    u.id_vehicule,
    u.num_veh,
    CASE
        WHEN c.Num_Acc IS NULL
        THEN 'Accident introuvable'
        ELSE 'OK'
    END AS verification_accident,
    CASE
        WHEN v.id_vehicule IS NULL
        THEN 'Vehicule introuvable'
        ELSE 'OK'
    END AS verification_vehicule
FROM dataviz_accidents_2024.`usagers-2024` u

LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON u.Num_Acc = c.Num_Acc

LEFT JOIN dataviz_accidents_2024.`vehicules-2024` v
    ON u.Num_Acc = v.Num_Acc
    AND u.id_vehicule = v.id_vehicule

WHERE c.Num_Acc IS NULL
   OR v.id_vehicule IS NULL;




SELECT *
FROM dataviz_accidents_2024.`usagers-2024`
WHERE Num_Acc IS NULL;


DELETE FROM dataviz_accidents_2024.`usagers-2024`
WHERE Num_Acc IS NULL
  AND (id_usager = '' OR id_usager IS NULL)
  AND (id_vehicule = '' OR id_vehicule IS NULL);
  
  
  
SELECT
    COUNT(*) AS nombre_usagers,
    COUNT(DISTINCT id_usager) AS usagers_distincts,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts
FROM dataviz_accidents_2024.`usagers-2024`;

  
  

SHOW COLUMNS
FROM dataviz_accidents_2024.`usagers-2024`
WHERE Field IN ('Num_Acc', 'id_vehicule');

SHOW INDEX
FROM dataviz_accidents_2024.`vehicules-2024`;



SHOW COLUMNS
FROM dataviz_accidents_2024.`vehicules-2024`
LIKE 'id_vehicule';





ALTER TABLE dataviz_accidents_2024.`usagers-2024`
ADD CONSTRAINT fk_usagers_caracteristiques
FOREIGN KEY (Num_Acc)
REFERENCES dataviz_accidents_2024.caracteristiques(Num_Acc);




ALTER TABLE dataviz_accidents_2024.`usagers-2024`
ADD CONSTRAINT fk_usagers_vehicules
FOREIGN KEY (id_vehicule)
REFERENCES dataviz_accidents_2024.`vehicules-2024`(id_vehicule);




SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'dataviz_accidents_2024'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;




SELECT 'caracteristiques' AS table_nom,
       COUNT(*) AS nombre_lignes
FROM dataviz_accidents_2024.caracteristiques

UNION ALL

SELECT 'lieux',
       COUNT(*)
FROM dataviz_accidents_2024.lieux

UNION ALL

SELECT 'vehicules-2024',
       COUNT(*)
FROM dataviz_accidents_2024.`vehicules-2024`

UNION ALL

SELECT 'usagers-2024',
       COUNT(*)
FROM dataviz_accidents_2024.`usagers-2024`;




SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts,
    SUM(Num_Acc IS NULL) AS num_acc_null,
    COUNT(Num_Acc) - COUNT(DISTINCT Num_Acc)
        AS lignes_supplementaires
FROM dataviz_accidents_2024.lieux;





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
WHERE Num_Acc = 202400050330;



SELECT
    COUNT(*) AS total_accidents,
    SUM(nb_lieux = 1) AS accidents_un_seul_lieu,
    SUM(nb_lieux > 1) AS accidents_plusieurs_lieux,
    MAX(nb_lieux) AS maximum_lieux,
    SUM(nb_lieux - 1) AS lignes_supplementaires
FROM (
    SELECT
        Num_Acc,
        COUNT(*) AS nb_lieux
    FROM dataviz_accidents_2024.lieux
    GROUP BY Num_Acc
) AS analyse_lieux;





SELECT
    nb_lieux AS nombre_lieux_par_accident,
    COUNT(*) AS nombre_accidents
FROM (
    SELECT
        Num_Acc,
        COUNT(*) AS nb_lieux
    FROM dataviz_accidents_2024.lieux
    GROUP BY Num_Acc
) AS analyse
GROUP BY nb_lieux
ORDER BY nb_lieux;



SELECT
    Num_Acc,
    COUNT(*) AS nombre_lignes,
    COUNT(DISTINCT voie) AS nombre_voies_distinctes,
    GROUP_CONCAT(
        DISTINCT voie
        ORDER BY voie
        SEPARATOR ' | '
    ) AS voies
FROM dataviz_accidents_2024.lieux
GROUP BY Num_Acc
HAVING COUNT(*) > 1
ORDER BY nombre_lignes DESC, Num_Acc
LIMIT 20;





SELECT
    COUNT(*) AS total_accidents,
    SUM(nb_lignes > 1) AS accidents_plusieurs_lignes,
    SUM(nb_lignes > 1 AND nb_voies = 1)
        AS accidents_meme_voie,
    SUM(nb_voies > 1)
        AS accidents_voies_differentes,
    SUM(nb_lignes > 1 AND nb_voies = 0)
        AS accidents_sans_voie_renseignee
FROM (
    SELECT
        Num_Acc,
        COUNT(*) AS nb_lignes,
        COUNT(DISTINCT
            CASE
                WHEN voie IS NULL
                  OR TRIM(voie) = ''
                  OR UPPER(TRIM(voie)) = 'N/A'
                THEN NULL
                ELSE TRIM(voie)
            END
        ) AS nb_voies
    FROM dataviz_accidents_2024.lieux
    GROUP BY Num_Acc
) AS analyse;





SELECT *
FROM dataviz_accidents_2024.lieux
WHERE Num_Acc IN (
    202400050330,
    202400017969,
    202400018846
)
ORDER BY Num_Acc, id_lieu;






SELECT
    c.Num_Acc
FROM dataviz_accidents_2024.caracteristiques c
LEFT JOIN dataviz_accidents_2024.lieux l
    ON c.Num_Acc = l.Num_Acc
WHERE l.Num_Acc IS NULL;




SELECT l.Num_Acc
FROM dataviz_accidents_2024.lieux l
LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON l.Num_Acc = c.Num_Acc
WHERE c.Num_Acc IS NULL;






SELECT
    v.Num_Acc,
    v.id_vehicule
FROM dataviz_accidents_2024.`vehicules-2024` v
LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON v.Num_Acc = c.Num_Acc
WHERE c.Num_Acc IS NULL;



SELECT
    u.Num_Acc,
    u.id_usager,
    u.id_vehicule
FROM dataviz_accidents_2024.`usagers-2024` u
LEFT JOIN dataviz_accidents_2024.`vehicules-2024` v
    ON u.Num_Acc = v.Num_Acc
    AND u.id_vehicule = v.id_vehicule
WHERE v.id_vehicule IS NULL;




SELECT
    v.Num_Acc,
    v.id_vehicule
FROM dataviz_accidents_2024.`vehicules-2024` v
LEFT JOIN dataviz_accidents_2024.`usagers-2024` u
    ON v.Num_Acc = u.Num_Acc
    AND v.id_vehicule = u.id_vehicule
WHERE u.id_vehicule IS NULL;





SELECT
    v.*
FROM dataviz_accidents_2024.`vehicules-2024` v
LEFT JOIN dataviz_accidents_2024.`usagers-2024` u
    ON v.Num_Acc = u.Num_Acc
    AND v.id_vehicule = u.id_vehicule
WHERE u.id_vehicule IS NULL
ORDER BY v.Num_Acc;






SELECT
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM dataviz_accidents_2024.`usagers-2024` u
            WHERE u.Num_Acc = v.Num_Acc
        )
        THEN 'Accident present, vehicule non associe'
        ELSE 'Accident absent des usagers'
    END AS diagnostic,
    COUNT(*) AS nombre_vehicules
FROM dataviz_accidents_2024.`vehicules-2024` v
WHERE NOT EXISTS (
    SELECT 1
    FROM dataviz_accidents_2024.`usagers-2024` u
    WHERE u.Num_Acc = v.Num_Acc
      AND u.id_vehicule = v.id_vehicule
)
GROUP BY diagnostic;





SELECT
    v.Num_Acc,
    v.id_vehicule,

    (SELECT COUNT(*)
     FROM dataviz_accidents_2024.`vehicules-2024` v2
     WHERE v2.Num_Acc = v.Num_Acc
    ) AS total_vehicules_accident,

    (SELECT COUNT(*)
     FROM dataviz_accidents_2024.`usagers-2024` u
     WHERE u.Num_Acc = v.Num_Acc
    ) AS total_usagers_accident,

    (SELECT COUNT(DISTINCT u.id_vehicule)
     FROM dataviz_accidents_2024.`usagers-2024` u
     WHERE u.Num_Acc = v.Num_Acc
    ) AS vehicules_avec_usagers

FROM dataviz_accidents_2024.`vehicules-2024` v

WHERE NOT EXISTS (
    SELECT 1
    FROM dataviz_accidents_2024.`usagers-2024` u
    WHERE u.Num_Acc = v.Num_Acc
      AND u.id_vehicule = v.id_vehicule
)

ORDER BY v.Num_Acc;



SELECT
    v.Num_Acc,
    v.id_vehicule,
    v.num_veh,
    v.catv,
    v.senc,
    v.obs,
    v.obsm,
    v.choc,
    v.manv,
    v.motor
FROM dataviz_accidents_2024.`vehicules-2024` v
WHERE NOT EXISTS (
    SELECT 1
    FROM dataviz_accidents_2024.`usagers-2024` u
    WHERE u.Num_Acc = v.Num_Acc
      AND u.id_vehicule = v.id_vehicule
)
ORDER BY v.catv, v.Num_Acc;




SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT Num_Acc) AS accidents_distincts,
    COUNT(*) - COUNT(DISTINCT Num_Acc)
        AS lignes_supplementaires,
    SUM(Num_Acc IS NULL) AS identifiants_null
FROM dataviz_accidents_2024.caracteristiques;




SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT Num_Acc, id_vehicule)
        AS vehicules_distincts,
    COUNT(*) - COUNT(DISTINCT Num_Acc, id_vehicule)
        AS lignes_supplementaires,
    SUM(Num_Acc IS NULL) AS accidents_null,
    SUM(id_vehicule IS NULL) AS vehicules_null
FROM dataviz_accidents_2024.`vehicules-2024`;




SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT id_usager) AS usagers_distincts,
    COUNT(*) - COUNT(DISTINCT id_usager)
        AS lignes_supplementaires,
    SUM(id_usager IS NULL) AS usagers_null,
    SUM(Num_Acc IS NULL) AS accidents_null,
    SUM(id_vehicule IS NULL) AS vehicules_null
FROM dataviz_accidents_2024.`usagers-2024`;





SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT id_lieu) AS lieux_distincts,
    COUNT(*) - COUNT(DISTINCT id_lieu)
        AS lignes_supplementaires,
    SUM(id_lieu IS NULL) AS lieux_null,
    SUM(Num_Acc IS NULL) AS accidents_null
FROM dataviz_accidents_2024.lieux;




SELECT
    COUNT(*) AS usagers_sans_accident
FROM dataviz_accidents_2024.`usagers-2024` u
LEFT JOIN dataviz_accidents_2024.caracteristiques c
    ON u.Num_Acc = c.Num_Acc
WHERE c.Num_Acc IS NULL;





SELECT
    COUNT(*) AS usagers_sans_vehicule
FROM dataviz_accidents_2024.`usagers-2024` u
LEFT JOIN dataviz_accidents_2024.`vehicules-2024` v
    ON u.Num_Acc = v.Num_Acc
    AND u.id_vehicule = v.id_vehicule
WHERE v.id_vehicule IS NULL;

