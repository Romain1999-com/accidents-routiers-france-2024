
import pandas as pd

# Chargement des données d'origine et des résultats ML
df = pd.read_csv(
    "accidents_2024_ml.csv",
    dtype={"Num_Acc": str}
)

clusters = pd.read_csv(
    "accidents_2024_clusters.csv",
    dtype={"Num_Acc": str}
)

# Association des accidents avec leur cluster
df = df.merge(
    clusters,
    on="Num_Acc",
    how="inner",
    validate="one_to_one"
)

if len(df) != 54402:
    raise ValueError("Nombre d'accidents incoherent.")

# Transformation de l'heure en tranches horaires
heures = pd.to_datetime(
    df["hrmn"],
    format="%H:%M",
    errors="raise"
)

df["tranche_horaire"] = pd.cut(
    heures.dt.hour,
    bins=[-1, 5, 11, 17, 23],
    labels=[
        "00h-05h",
        "06h-11h",
        "12h-17h",
        "18h-23h"
    ]
)

variables = [
    "tranche_horaire",
    "lum",
    "atm",
    "intersection_type",
    "agg",
    "col"
]

profils = []

print("\nANALYSE DES PROFILS K-MEANS")
print("=" * 45)

for cluster, groupe in df.groupby("cluster"):

    print(f"\nCLUSTER {cluster}")
    print(f"Nombre d'accidents : {len(groupe)}")

    for variable in variables:

        repartition = groupe[variable].value_counts(
            normalize=True,
            dropna=False
        )

        effectifs = groupe[variable].value_counts(
            dropna=False
        )

        modalite = repartition.index[0]
        pourcentage = repartition.iloc[0] * 100

        print(
            f"{variable} : {modalite} "
            f"({pourcentage:.1f} %)"
        )

        for code, proportion in repartition.items():
            profils.append({
                "cluster": cluster,
                "variable": variable,
                "modalite": str(code),
                "effectif": int(effectifs[code]),
                "pourcentage": round(
                    proportion * 100, 2
                )
            })

# Export des profils complets
resultats = pd.DataFrame(profils)

resultats.to_csv(
    "profils_clusters.csv",
    index=False,
    encoding="utf-8-sig"
)

print("\nAnalyse terminee avec succes !")
print("Fichier cree : profils_clusters.csv")
