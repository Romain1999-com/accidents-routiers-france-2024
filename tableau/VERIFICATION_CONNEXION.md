# Contrôle du classeur Tableau — Accidents 2024

## Vérifications réalisées sur le fichier transmis

- Archive `.twbx` lisible et contenant un fichier `.twb` valide.
- 18 feuilles de calcul.
- 6 tableaux de bord : DB01 Cartographie, DB02 Analyse temporelle, DB03 Conditions, DB04 Usagers, DB05 Véhicules, DB06 Synthèse générale.
- 3 actions de filtre sur sélection : 1 dans DB01 (carte), 2 dans DB06 (graphique âge et carte).
- Connexion : MySQL, `localhost`, port `3306`, base `dataviz_accidents_2024`, utilisateur `root`.
- Quatre vues utilisées : `vue_accidents_2024`, `vue_cartographie_2024`, `vue_usagers_2024`, `vue_vehicules_2024`.
- Aucun extrait Tableau `.hyper`/`.tde` embarqué ; aucune valeur de mot de passe trouvée dans le fichier XML inspecté.

## Points non vérifiés

- Connexion effective à un serveur MySQL en fonctionnement.
- Validité des vues sur une base réimportée.
- Correspondance des KPI après rafraîchissement.
- Rendu graphique et interactions dans Tableau Desktop sur un autre poste.

## Pour rouvrir le classeur sur un autre poste

1. Installer MySQL et recréer la base `dataviz_accidents_2024` avec les tables, données et vues attendues.
2. Installer Tableau Desktop et le pilote MySQL compatible si nécessaire.
3. Ouvrir le `.twbx` dans Tableau Desktop.
4. Si la connexion échoue, dans **Données**, ouvrir la source MySQL et modifier le serveur, le port et les identifiants selon l'installation locale. Ne pas publier de mot de passe.
5. Rafraîchir les données, vérifier les 6 dashboards et comparer les KPI attendus : 54 402 accidents, 125 187 usagers, 92 678 véhicules, 3 432 décès (pour les filtres de référence).
6. Tester les filtres département/date et les actions interactives sur DB01 et DB06.

## Pour partager un classeur utilisable sans MySQL

Dans Tableau Desktop, si la source et les droits le permettent, créer un **extrait de données**, puis enregistrer de nouveau le classeur empaqueté `.twbx`. Vérifier que l'archive inclut alors un fichier `.hyper` et que le classeur fonctionne sans connexion MySQL. Attention à la taille du fichier et aux conditions de redistribution des données.

## Précaution de publication

Le fichier Tableau contient des métadonnées techniques de création et un nom d'utilisateur de base de données (`root`). Aucun mot de passe n'a été repéré. Vérifier les informations à diffuser avant de rendre le dépôt public.
