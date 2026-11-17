# Machine Learning — Accidents routiers en France 2024



## 1. Objectif



Ce module complète le projet de Data Visualisation consacré aux accidents corporels de la circulation en France en 2024.



L'objectif est d'identifier des profils d'accidents similaires à l'aide d'un algorithme de clustering K-means.



Il s'agit d'une analyse exploratoire non supervisée et non d'un modèle de prédiction des accidents.



## 2. Données utilisées



- Source : données d'accidents routiers 2024 exploitées dans le projet MySQL.

- Vue SQL : `vue_accidents_2024`.

- Nombre d'accidents : **54 402**.

- Nombre de variables initiales : **7**, dont l'identifiant de l'accident.

- Valeurs manquantes détectées dans le CSV : **0**.



Variables utilisées pour l'apprentissage :



- Heure de l'accident

- Luminosité

- Conditions atmosphériques

- Type d'intersection

- Localisation en ou hors agglomération

- Type de collision



L'identifiant `Num_Acc` est exclu de l'entraînement.



## 3. Méthodologie



Le projet utilise Python, pandas, NumPy, scikit-learn et Matplotlib.



Les étapes sont les suivantes :



1. Importation des données CSV.

2. Transformation cyclique de l'heure à l'aide du sinus et du cosinus.

3. Encodage One-Hot des variables catégorielles.

4. Préparation de **35 variables numériques**.

5. Pondération des groupes de variables.

6. Comparaison de K-means pour k allant de 2 à 6.

7. Sélection selon le score de silhouette.

8. Entraînement final sur les 54 402 accidents.

9. Analyse descriptive des clusters et création de graphiques.



La comparaison des modèles utilise un échantillon de 10 000 accidents et une évaluation de silhouette sur 2 000 observations. La graine aléatoire est fixée à 42 pour faciliter la reproductibilité.



## 4. Résultats



| Clusters | Score de silhouette |

|---|---|

| 2 | 0,1713 |

| 3 | **0,1769** |

| 4 | 0,1344 |

| 5 | 0,1514 |

| 6 | 0,1659 |



Le modèle à **3 clusters** obtient le meilleur score parmi les configurations testées.



### Profils identifiés



| Cluster | Profil descriptif | Accidents | Part |

|---|---|---:|---:|

| 0 | Urbain, principalement nocturne | 11 496 | 21,1 % |

| 1 | Hors agglomération, majoritairement diurne | 20 286 | 37,3 % |

| 2 | Urbain, de jour | 22 620 | 41,6 % |

| **Total** | | **54 402** | **100 %** |



Ces intitulés ont été attribués après l'analyse des caractéristiques dominantes de chaque groupe.



## 5. Limites



Le score de silhouette de **0,1769** indique une séparation relativement faible des groupes.



Les résultats doivent être considérés comme une segmentation exploratoire. Ils ne démontrent pas l'existence de catégories naturelles parfaitement distinctes.



Les caractéristiques utilisées sont principalement catégorielles. Le résultat dépend donc des choix d'encodage, de pondération et de l'algorithme K-means.



Le modèle ne permet pas de prédire la survenue d'un accident, sa gravité ou le niveau de risque routier.



## 6. Fichiers du module



**Scripts Python :**



- `preparer_donnees.py` : préparation et encodage.

- `entrainer_kmeans.py` : comparaison et entraînement.

- `analyser_clusters.py` : caractérisation des groupes.

- `graphiques_clusters.py` : visualisation des résultats.



**Données et résultats :**



- `accidents_2024_ml.csv`

- `accidents_2024_prepares.csv`

- `accidents_2024_clusters.csv`

- `profils_clusters.csv`



**Visualisations :**



- `graphique_repartition_clusters.png`

- `graphique_luminosite_clusters.png`



## 7. Reproduction



Utiliser une version de Python compatible avec les bibliothèques du projet.



Installer les dépendances :



`python -m pip install numpy pandas scikit-learn matplotlib`



Depuis le dossier `machine_learning`, exécuter dans cet ordre :



1. `python preparer_donnees.py`

2. `python entrainer_kmeans.py`

3. `python analyser_clusters.py`

4. `python graphiques_clusters.py`



Les scripts utilisent des chemins relatifs : ils doivent être exécutés depuis le dossier contenant les fichiers CSV.



## 8. Conclusion



Ce module apporte une dimension Machine Learning au projet de visualisation des accidents routiers en France.



Le clustering K-means permet de distinguer trois profils descriptifs principalement différenciés par l'environnement routier et les conditions de luminosité.



Il complète les six tableaux de bord Tableau Desktop en proposant une approche exploratoire fondée sur l'apprentissage non supervisé.
