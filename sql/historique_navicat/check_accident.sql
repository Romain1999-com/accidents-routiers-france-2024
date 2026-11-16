
USE dataviz_accidents_2024;

SELECT DATABASE();




USE dataviz_accidents_2024;

CREATE TABLE caracteristiques (
    Num_Acc BIGINT PRIMARY KEY,
    jour TINYINT,
    mois TINYINT,
    an SMALLINT,
    hrmn VARCHAR(5),
    lum TINYINT,
    dep VARCHAR(3),
    com VARCHAR(5),
    agg TINYINT,
    `int` TINYINT,
    atm TINYINT,
    col TINYINT,
    adr VARCHAR(255),
    lat VARCHAR(30),
    `long` VARCHAR(30)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4;



SHOW TABLES;



SELECT COUNT(*) AS nombre_accidents
FROM dataviz_accidents_2024.caracteristiques;

