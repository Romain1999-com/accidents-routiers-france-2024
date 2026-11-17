
import pandas as pd
import matplotlib.pyplot as plt

# Chargement des donnees
accidents = pd.read_csv(
    "accidents_2024_ml.csv",
    dtype={"Num_Acc": str}
)

clusters = pd.read_csv(
    "accidents_2024_clusters.csv",
    dtype={"Num_Acc": str}
)

df = accidents.merge(
    clusters,
    on="Num_Acc",
    validate="one_to_one"
)

if len(df) != 54402:
    raise ValueError("Nombre d'accidents incorrect.")

noms = {
    0: "Urbain - nuit",
    1: "Hors agglomeration",
    2: "Urbain - jour"
}

# GRAPHIQUE 1 : repartition des clusters
effectifs = df["cluster"].value_counts().sort_index()
labels = [noms[i] for i in effectifs.index]

fig, ax = plt.subplots(figsize=(10, 6))
barres = ax.bar(labels, effectifs.values)

ax.bar_label(
    barres,
    labels=[
        f"{n:,} ({n / len(df) * 100:.1f} %)"
        for n in effectifs.values
    ],
    padding=5
)

ax.set_title(
    "Accidents routiers 2024 - Repartition des clusters"
)
ax.set_ylabel("Nombre d'accidents")
ax.set_ylim(0, effectifs.max() * 1.17)
ax.spines[["top", "right"]].set_visible(False)

plt.tight_layout()
plt.savefig(
    "graphique_repartition_clusters.png",
    dpi=200
)
plt.close()

# GRAPHIQUE 2 : luminosite par cluster
luminosite = {
    1: "Plein jour",
    2: "Crepuscule / aube",
    3: "Nuit sans eclairage",
    4: "Nuit, eclairage eteint",
    5: "Nuit, eclairage allume"
}

df["luminosite"] = (
    df["lum"]
    .map(luminosite)
    .fillna("Non renseigne")
)

tableau = pd.crosstab(
    df["cluster"],
    df["luminosite"],
    normalize="index"
) * 100

tableau.index = [
    noms[i] for i in tableau.index
]

ax = tableau.plot(
    kind="bar",
    stacked=True,
    figsize=(11, 7),
    width=0.7
)

ax.set_title(
    "Conditions de luminosite selon le cluster"
)
ax.set_xlabel("")
ax.set_ylabel("Part des accidents (%)")
ax.set_ylim(0, 100)
ax.tick_params(axis="x", rotation=0)

ax.legend(
    title="Luminosite",
    bbox_to_anchor=(1.02, 1),
    loc="upper left"
)

plt.tight_layout()
plt.savefig(
    "graphique_luminosite_clusters.png",
    dpi=200,
    bbox_inches="tight"
)
plt.close()

print("Graphiques generes avec succes !")
print("1. graphique_repartition_clusters.png")
print("2. graphique_luminosite_clusters.png")
