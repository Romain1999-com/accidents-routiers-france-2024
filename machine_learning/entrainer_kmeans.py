
import numpy as np
import pandas as pd

from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score

# 1. Chargement des données
X = pd.read_csv("accidents_2024_prepares.csv")
df = pd.read_csv("accidents_2024_ml.csv", dtype={"Num_Acc": str})

print("Accidents :", len(X))
print("Variables :", X.shape[1])

if len(X) != len(df):
    raise ValueError("Nombre de lignes incoherent.")

if X.isna().any().any():
    raise ValueError("Valeurs manquantes detectees.")

# 2. Equilibrage des groupes de variables
# Chaque groupe a une distance maximale comparable.
X = X.astype(float)

X[["heure_sin", "heure_cos"]] *= 0.5

groupes = [
    "lum",
    "atm",
    "intersection_type",
    "agg",
    "col"
]

for groupe in groupes:
    colonnes = [
        c for c in X.columns
        if c.startswith(groupe + "_")
    ]

    if not colonnes:
        raise ValueError(f"Groupe absent : {groupe}")

    X[colonnes] *= 1 / np.sqrt(2)

# 3. Echantillon pour comparer les modeles
echantillon = X.sample(
    n=min(10000, len(X)),
    random_state=42
)

# 4. Recherche du nombre de clusters
resultats = []

print("\nComparaison des modeles K-means")

for k in range(2, 7):
    modele = KMeans(
        n_clusters=k,
        random_state=42,
        n_init=10
    )

    labels = modele.fit_predict(echantillon)

    score = silhouette_score(
        echantillon,
        labels,
        sample_size=2000,
        random_state=42
    )

    resultats.append((k, score))

    print(f"k={k} | Silhouette={score:.4f}")

# 5. Selection du meilleur score
meilleur_k, meilleur_score = max(
    resultats,
    key=lambda resultat: resultat[1]
)

print("\nNombre de clusters retenu :", meilleur_k)
print("Score de silhouette :", round(meilleur_score, 4))

# 6. Entrainement sur les 54 402 accidents
modele_final = KMeans(
    n_clusters=meilleur_k,
    random_state=42,
    n_init=10
)

clusters = modele_final.fit_predict(X)

# 7. Export des resultats
resultat = pd.DataFrame({
    "Num_Acc": df["Num_Acc"],
    "cluster": clusters
})

resultat.to_csv(
    "accidents_2024_clusters.csv",
    index=False
)

print("\nRepartition des accidents :")
print(resultat["cluster"].value_counts().sort_index())

print("\nMachine Learning termine avec succes !")
print("Fichier cree : accidents_2024_clusters.csv")
