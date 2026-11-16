# Provenance des données — Accidents routiers 2024

## 1. Source officielle

- **Producteur :** Ministère de l'Intérieur
- **Gestionnaire du fichier BAAC :** Observatoire national interministériel de la sécurité routière (ONISR)
- **Plateforme :** data.gouv.fr
- **Jeu de données :** Bases de données annuelles des accidents corporels de la circulation routière
- **Année analysée :** 2024
- **Licence :** Licence Ouverte / Open Licence
- **URL :** https://www.data.gouv.fr/datasets/bases-de-donnees-annuelles-des-accidents-corporels-de-la-circulation-routiere-annees-de-2005-a-2025

## 2. Fichiers sources

Quatre fichiers CSV ont été utilisés :

- `caract-2024.csv` : caractéristiques des accidents.
- `lieux-2024.csv` : caractéristiques des lieux.
- `vehicules-2024.csv` : véhicules impliqués.
- `usagers-2024.csv` : usagers impliqués.

Documentation associée : `description-des-bases-de-donnees-annuelles.pdf`.

## 3. Préparation et importation

Les données ont été importées dans MySQL et exploitées avec Navicat Premium Lite.

Les opérations documentées comprennent :

- L'importation des quatre fichiers CSV.
- La vérification des enregistrements importés.
- Le contrôle des identifiants et des relations entre tables.
- La vérification et la correction des conversions des coordonnées GPS.
- La création de cinq vues SQL destinées à Tableau Desktop.

Pour le fichier des caractéristiques, le séparateur CSV utilisé est le point-virgule (`;`).

## 4. Volumes enregistrés dans MySQL

| Table | Enregistrements |
|---|---:|
| caracteristiques | 54 403 |
| lieux | 70 249 |
| usagers-2024 | 125 187 |
| vehicules-2024 | 92 678 |

Ces valeurs correspondent aux volumes documentés dans la base MySQL après importation. Elles ne constituent pas une vérification indépendante des dimensions des fichiers CSV bruts.

## 5. Informations restant à vérifier

- Date exacte du téléchargement initial.
- Nombre de colonnes de chacun des quatre fichiers sources.
- Encodage et délimiteur exacts de chaque fichier.
- Dimensions initiales des fichiers CSV, avant importation.

## 6. Reproductibilité

La reconstruction de la base est documentée dans le dossier `sql/base_complete/` du dépôt GitHub.

Le classeur Tableau Desktop utilise une connexion directe à MySQL. Les données ne sont pas embarquées sous forme d'extrait dans le classeur fourni.