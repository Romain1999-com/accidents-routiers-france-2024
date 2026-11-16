-- DATAVIZ ACCIDENTS ROUTIERS 2024 | Export nettoye pour archivage et GitHub
-- Source : export Navicat Premium Lite du 16 novembre 2026.
-- Contenu : 4 tables metier avec donnees + 5 vues SQL originales.
-- Exclu : 8 tables de filtrage temporaires creees par Tableau.
-- ATTENTION : l'execution supprime et recree les 4 tables et 5 vues nommees.
-- Importer dans une base vide ou sauvegarder la base avant execution.
-- Cible : MySQL 8.0 (export d'origine : 8.0.46).

CREATE DATABASE IF NOT EXISTS `dataviz_accidents_2024`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `dataviz_accidents_2024`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Supprimer les vues existantes avant de recreer les tables source.
DROP VIEW IF EXISTS `vue_luminosite_2024`;
DROP VIEW IF EXISTS `vue_cartographie_2024`;
DROP VIEW IF EXISTS `vue_usagers_2024`;
DROP VIEW IF EXISTS `vue_vehicules_2024`;
DROP VIEW IF EXISTS `vue_accidents_2024`;

-- Structure de caracteristiques
DROP TABLE IF EXISTS `caracteristiques`;
CREATE TABLE `caracteristiques`  (
  `Num_Acc` bigint NOT NULL,
  `jour` tinyint NULL DEFAULT NULL,
  `mois` tinyint NULL DEFAULT NULL,
  `an` smallint NULL DEFAULT NULL,
  `hrmn` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lum` tinyint NULL DEFAULT NULL,
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `com` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `agg` tinyint NULL DEFAULT NULL,
  `int` tinyint NULL DEFAULT NULL,
  `atm` tinyint NULL DEFAULT NULL,
  `col` tinyint NULL DEFAULT NULL,
  `adr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `long` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Num_Acc`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- Structure de lieux
DROP TABLE IF EXISTS `lieux`;
CREATE TABLE `lieux`  (
  `id_lieu` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Num_Acc` bigint NOT NULL,
  `catr` tinyint NULL DEFAULT NULL,
  `voie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `v1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `v2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `circ` tinyint NULL DEFAULT NULL,
  `nbv` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `vosp` tinyint NULL DEFAULT NULL,
  `prof` tinyint NULL DEFAULT NULL,
  `pr` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pr1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan` tinyint NULL DEFAULT NULL,
  `lartpc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `larrout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `surf` tinyint NULL DEFAULT NULL,
  `infra` tinyint NULL DEFAULT NULL,
  `situ` tinyint NULL DEFAULT NULL,
  `vma` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id_lieu`) USING BTREE,
  INDEX `idx_lieux_num_acc`(`Num_Acc` ASC) USING BTREE,
  CONSTRAINT `fk_lieux_caracteristiques` FOREIGN KEY (`Num_Acc`) REFERENCES `caracteristiques` (`Num_Acc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 70250 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- Structure de usagers-2024
DROP TABLE IF EXISTS `usagers-2024`;
CREATE TABLE `usagers-2024`  (
  `Num_Acc` bigint NULL DEFAULT NULL,
  `id_usager` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_vehicule` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `num_veh` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `place` int NULL DEFAULT NULL,
  `catu` int NULL DEFAULT NULL,
  `grav` int NULL DEFAULT NULL,
  `sexe` int NULL DEFAULT NULL,
  `an_nais` smallint NULL DEFAULT NULL,
  `trajet` int NULL DEFAULT NULL,
  `secu1` int NULL DEFAULT NULL,
  `secu2` int NULL DEFAULT NULL,
  `secu3` int NULL DEFAULT NULL,
  `locp` int NULL DEFAULT NULL,
  `actp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `etatp` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_usager`) USING BTREE,
  INDEX `fk_usagers_caracteristiques`(`Num_Acc` ASC) USING BTREE,
  INDEX `fk_usagers_vehicules`(`id_vehicule` ASC) USING BTREE,
  CONSTRAINT `fk_usagers_caracteristiques` FOREIGN KEY (`Num_Acc`) REFERENCES `caracteristiques` (`Num_Acc`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usagers_vehicules` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules-2024` (`id_vehicule`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- Structure de vehicules-2024
DROP TABLE IF EXISTS `vehicules-2024`;
CREATE TABLE `vehicules-2024`  (
  `Num_Acc` bigint NULL DEFAULT NULL,
  `id_vehicule` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_veh` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `senc` int NULL DEFAULT NULL,
  `catv` int NULL DEFAULT NULL,
  `obs` int NULL DEFAULT NULL,
  `obsm` int NULL DEFAULT NULL,
  `choc` int NULL DEFAULT NULL,
  `manv` int NULL DEFAULT NULL,
  `motor` int NULL DEFAULT NULL,
  `occutc` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_vehicule`) USING BTREE,
  INDEX `fk_vehicules_caracteristiques`(`Num_Acc` ASC) USING BTREE,
  CONSTRAINT `fk_vehicules_caracteristiques` FOREIGN KEY (`Num_Acc`) REFERENCES `caracteristiques` (`Num_Acc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for vue_accidents_2024
-- ----------------------------
DROP VIEW IF EXISTS `vue_accidents_2024`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vue_accidents_2024` AS select `c`.`Num_Acc` AS `Num_Acc`,`c`.`jour` AS `jour`,`c`.`mois` AS `mois`,`c`.`an` AS `an`,`c`.`hrmn` AS `hrmn`,`c`.`lum` AS `lum`,`c`.`dep` AS `dep`,`c`.`com` AS `com`,`c`.`agg` AS `agg`,`c`.`int` AS `int`,`c`.`atm` AS `atm`,`c`.`col` AS `col`,`c`.`adr` AS `adr`,`c`.`lat` AS `lat`,`c`.`long` AS `long`,coalesce(`l`.`nb_lieux`,0) AS `nb_lieux` from (`caracteristiques` `c` left join (select `lieux`.`Num_Acc` AS `Num_Acc`,count(0) AS `nb_lieux` from `lieux` group by `lieux`.`Num_Acc`) `l` on((`c`.`Num_Acc` = `l`.`Num_Acc`))) where (`c`.`Num_Acc` <> 0);

-- ----------------------------
-- View structure for vue_cartographie_2024
-- ----------------------------
DROP VIEW IF EXISTS `vue_cartographie_2024`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vue_cartographie_2024` AS select `c`.`Num_Acc` AS `Num_Acc`,`c`.`jour` AS `jour`,`c`.`mois` AS `mois`,`c`.`an` AS `an`,`c`.`hrmn` AS `hrmn`,`c`.`lum` AS `lum`,`c`.`dep` AS `dep`,`c`.`com` AS `com`,`c`.`agg` AS `agg`,`c`.`int` AS `int`,`c`.`atm` AS `atm`,`c`.`col` AS `col`,`c`.`adr` AS `adr`,`c`.`lat` AS `lat`,`c`.`long` AS `long`,`c`.`nb_lieux` AS `nb_lieux`,(case when ((`c`.`lat` is not null) and (`c`.`long` is not null) and regexp_like(trim(`c`.`lat`),'^-?[0-9]+([.,][0-9]+)?$') and regexp_like(trim(`c`.`long`),'^-?[0-9]+([.,][0-9]+)?$') and (cast(replace(`c`.`lat`,',','.') as decimal(12,8)) <> 0) and (cast(replace(`c`.`long`,',','.') as decimal(12,8)) <> 0) and (cast(replace(`c`.`lat`,',','.') as decimal(12,8)) between -(90) and 90) and (cast(replace(`c`.`long`,',','.') as decimal(12,8)) between -(180) and 180)) then cast(replace(`c`.`lat`,',','.') as decimal(12,8)) else NULL end) AS `latitude_carte`,(case when ((`c`.`lat` is not null) and (`c`.`long` is not null) and regexp_like(trim(`c`.`lat`),'^-?[0-9]+([.,][0-9]+)?$') and regexp_like(trim(`c`.`long`),'^-?[0-9]+([.,][0-9]+)?$') and (cast(replace(`c`.`lat`,',','.') as decimal(12,8)) <> 0) and (cast(replace(`c`.`long`,',','.') as decimal(12,8)) <> 0) and (cast(replace(`c`.`lat`,',','.') as decimal(12,8)) between -(90) and 90) and (cast(replace(`c`.`long`,',','.') as decimal(12,8)) between -(180) and 180)) then cast(replace(`c`.`long`,',','.') as decimal(12,8)) else NULL end) AS `longitude_carte` from `vue_accidents_2024` `c`;

-- ----------------------------
-- View structure for vue_luminosite_2024
-- ----------------------------
DROP VIEW IF EXISTS `vue_luminosite_2024`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vue_luminosite_2024` AS select `vue_accidents_2024`.`lum` AS `lum`,(case `vue_accidents_2024`.`lum` when 1 then 'Plein jour' when 2 then 'Crépuscule ou aube' when 3 then 'Nuit sans éclairage public' when 4 then 'Nuit - éclairage non allumé' when 5 then 'Nuit - éclairage allumé' else 'Non renseigné' end) AS `luminosite`,count(0) AS `nombre_accidents` from `vue_accidents_2024` group by `vue_accidents_2024`.`lum`;

-- ----------------------------
-- View structure for vue_usagers_2024
-- ----------------------------
DROP VIEW IF EXISTS `vue_usagers_2024`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vue_usagers_2024` AS select `u`.`Num_Acc` AS `Num_Acc`,`u`.`id_usager` AS `id_usager`,`u`.`id_vehicule` AS `id_vehicule`,`u`.`num_veh` AS `num_veh`,`u`.`place` AS `place`,`u`.`catu` AS `catu`,`u`.`grav` AS `grav`,`u`.`sexe` AS `sexe`,`u`.`an_nais` AS `an_nais`,`u`.`trajet` AS `trajet`,`u`.`secu1` AS `secu1`,`u`.`secu2` AS `secu2`,`u`.`secu3` AS `secu3`,`u`.`locp` AS `locp`,`u`.`actp` AS `actp`,`u`.`etatp` AS `etatp`,`v`.`catv` AS `catv`,`v`.`senc` AS `senc`,`v`.`manv` AS `manv`,`v`.`motor` AS `motor` from (`usagers-2024` `u` left join `vehicules-2024` `v` on(((`u`.`Num_Acc` = `v`.`Num_Acc`) and (`u`.`id_vehicule` = `v`.`id_vehicule`))));

-- ----------------------------
-- View structure for vue_vehicules_2024
-- ----------------------------
DROP VIEW IF EXISTS `vue_vehicules_2024`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vue_vehicules_2024` AS select `v`.`Num_Acc` AS `Num_Acc`,`v`.`id_vehicule` AS `id_vehicule`,`v`.`num_veh` AS `num_veh`,`v`.`senc` AS `senc`,`v`.`catv` AS `catv`,`v`.`obs` AS `obs`,`v`.`obsm` AS `obsm`,`v`.`choc` AS `choc`,`v`.`manv` AS `manv`,`v`.`motor` AS `motor`,`v`.`occutc` AS `occutc`,coalesce(`u`.`nb_usagers`,0) AS `nb_usagers` from (`vehicules-2024` `v` left join (select `usagers-2024`.`Num_Acc` AS `Num_Acc`,`usagers-2024`.`id_vehicule` AS `id_vehicule`,count(0) AS `nb_usagers` from `usagers-2024` group by `usagers-2024`.`Num_Acc`,`usagers-2024`.`id_vehicule`) `u` on(((`v`.`Num_Acc` = `u`.`Num_Acc`) and (`v`.`id_vehicule` = `u`.`id_vehicule`))));

SET FOREIGN_KEY_CHECKS = 1;
