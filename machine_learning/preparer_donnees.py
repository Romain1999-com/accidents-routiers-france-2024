
import pandas as pd
import numpy as np

# 1. Chargement des données
df = pd.read_csv("accidents_2024_ml.csv")

print("Accidents chargés :", len(df))

# 2. Conversion des heures
heures = pd.to_datetime(
    df["hrmn"],
    format="%H:%M",
    errors="coerce"
)

if heures.isna().any():
    raise ValueError("Certaines heures sont invalides.")

minutes = heures.dt.hour * 60 + heures.dt.minute

# Encodage cyclique : 23h59 est proche de 00h00
df["heure_sin"] = np.sin(2 * np.pi * minutes / 1440)
df["heure_cos"] = np.cos(2 * np.pi * minutes / 1440)

# 3. Préparation des catégories
colonnes_cat = [
    "lum",
    "atm",
    "intersection_type",
    "agg",
    "col"
]

categories = df[colonnes_cat].copy()

# Les codes sont des catégories, pas des quantités.
# Les codes négatifs sont conservés comme catégories distinctes.
for colonne in colonnes_cat:
    categories[colonne] = categories[colonne].astype(str)

# 4. Encodage One-Hot
categories_encodees = pd.get_dummies(
    categories,
    columns=colonnes_cat,
    dtype=int
)

# 5. Construction des variables du modèle
X = pd.concat(
    [
        df[["heure_sin", "heure_cos"]],
        categories_encodees
    ],
    axis=1
)

# 6. Contrôles
print("Dimensions des données préparées :", X.shape)
print("Valeurs manquantes :", int(X.isna().sum().sum()))
print("Nombre de variables :", X.shape[1])

# 7. Exportation
X.to_csv("accidents_2024_prepares.csv", index=False)

print("Préparation terminée avec succès !")
print("Fichier créé : accidents_2024_prepares.csv")
