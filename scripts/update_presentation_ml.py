"""Actualise la soutenance existante avec 3 diapositives K-means.
Exécuter depuis la racine du dépôt : python scripts/update_presentation_ml.py
"""
from pathlib import Path
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE
from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
DECK = ROOT / "presentation" / "Soutenance_Accidents_Routiers_2024.pptx"
ML = ROOT / "machine_learning"
prs = Presentation(str(DECK))
if any("Machine Learning — méthode" in sh.text for s in prs.slides for sh in s.shapes if sh.has_text_frame):
    print("Déjà actualisé : aucun changement.")
    raise SystemExit(0)

TEAL = RGBColor(31, 126, 140)
DARK = RGBColor(20, 37, 60)
INK = RGBColor(29, 48, 70)
PALE = RGBColor(235, 242, 246)
MUTED = RGBColor(84, 105, 123)

def text(s, x, y, w, h, value, size=16, bold=False, color=INK):
    sh = s.shapes.add_textbox(Inches(x), Inches(y), Inches(w), Inches(h))
    tf = sh.text_frame
    tf.clear()
    tf.word_wrap = True
    tf.margin_left = Inches(.04)
    tf.margin_right = Inches(.04)
    tf.margin_top = Inches(.03)
    for i, line in enumerate(value.split("\n")):
        p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
        p.text = line
        p.space_after = Pt(9)
        for r in p.runs:
            r.font.name = "Aptos"
            r.font.size = Pt(size)
            r.font.bold = bold
            r.font.color.rgb = color
    return sh

def block(s, x, y, w, h):
    sh = s.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(x), Inches(y), Inches(w), Inches(h))
    sh.fill.solid()
    sh.fill.fore_color.rgb = PALE
    sh.line.fill.background()

def slide(title, subtitle):
    s = prs.slides.add_slide(prs.slide_layouts[6])
    bar = s.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, Inches(.12))
    bar.fill.solid()
    bar.fill.fore_color.rgb = TEAL
    bar.line.fill.background()
    text(s, .55, .34, 12.25, .54, title, 25, True, DARK)
    text(s, .57, .96, 12.1, .48, subtitle, 15, False, MUTED)
    line = s.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(.55), Inches(7.12), Inches(12.2), Inches(.012))
    line.fill.solid()
    line.fill.fore_color.rgb = PALE
    line.line.fill.background()
    return s

def image(s, path, x, y, w, h):
    with Image.open(path) as im:
        iw, ih = im.size
    scale = min(w / iw, h / ih)
    pw, ph = iw * scale, ih * scale
    s.shapes.add_picture(str(path), Inches(x+(w-pw)/2), Inches(y+(h-ph)/2), width=Inches(pw), height=Inches(ph))

def replace(sh, value):
    pars = sh.text_frame.paragraphs
    if pars and pars[0].runs:
        first = pars[0].runs[0]
        for p in pars:
            for r in p.runs:
                if r._r is not first._r:
                    r.text = ""
        first.text = value
    else:
        sh.text = value

for sh in prs.slides[0].shapes:
    if sh.has_text_frame and "Projet Open Data" in sh.text:
        replace(sh, "Projet Open Data  •  MySQL / Navicat  •  Tableau Desktop  •  Python / scikit-learn")

s = slide("Machine Learning — méthode", "Segmentation exploratoire des accidents par K-means")
block(s, .72, 1.65, 5.86, 4.75)
block(s, 6.77, 1.65, 5.86, 4.75)
text(s, 1.02, 1.91, 5.1, .55, "Préparation des données", 20, True, TEAL)
text(s, 1.02, 2.60, 5.1, 3.5, "54 402 accidents en 2024\n35 variables numériques\nHeure encodée de manière cyclique\nCatégories transformées en One-Hot\nPondération des groupes de variables", 17)
text(s, 7.07, 1.91, 5.1, .55, "Apprentissage non supervisé", 20, True, TEAL)
text(s, 7.07, 2.60, 5.15, 3.6, "Algorithme K-means (scikit-learn)\nk de 2 à 6 comparés\nÉchantillon : 10 000 accidents\nSilhouette sur 2 000 observations\nModèle final sur 54 402 accidents", 17)
text(s, .92, 6.53, 11.9, .34, "Meilleur k testé : 3    |    Silhouette : 0,1769    |    Modèle descriptif, non prédictif", 14, True, TEAL)

s = slide("Machine Learning — trois profils identifiés", "Répartition des 54 402 accidents entre les groupes")
block(s, .68, 1.62, 8.38, 4.95)
image(s, ML / "graphique_repartition_clusters.png", .83, 1.77, 8.08, 4.62)
block(s, 9.25, 1.62, 3.38, 4.95)
text(s, 9.52, 1.86, 2.95, .5, "Répartition", 20, True, TEAL)
text(s, 9.52, 2.54, 2.93, 3.72, "Cluster 0\n11 496 · 21,1 %\nUrbain — nuit\n\nCluster 1\n20 286 · 37,3 %\nHors agglomération\n\nCluster 2\n22 620 · 41,6 %\nUrbain — jour", 14)

s = slide("Machine Learning — lecture des profils", "Les groupes se distinguent notamment par la luminosité et l’environnement routier")
block(s, .68, 1.62, 8.66, 4.95)
image(s, ML / "graphique_luminosite_clusters.png", .83, 1.75, 8.36, 4.65)
block(s, 9.52, 1.62, 3.11, 4.95)
text(s, 9.77, 1.88, 2.65, .48, "Interprétation", 18, True, TEAL)
text(s, 9.77, 2.5, 2.62, 3.8, "Cluster 0 : nuit, en agglomération.\n\nCluster 1 : hors agglomération, profil mixte.\n\nCluster 2 : jour, en agglomération.\n\nSilhouette faible : groupes peu séparés.", 14)

# La conclusion d'origine est replacée à la fin.
ids = prs.slides._sldIdLst
last_id = ids[11]
ids.remove(last_id)
ids.append(last_id)
for sh in prs.slides[-1].shapes:
    if not sh.has_text_frame:
        continue
    t = sh.text
    if t.startswith("Résultats, limites et suite"):
        replace(sh, "Résultats, limites et conclusion")
    elif t.startswith("Une analyse descriptive et un dossier"):
        replace(sh, "Six dashboards Tableau et une segmentation K-means exploratoire")
    elif t.startswith("Six tableaux de bord ;"):
        replace(sh, "Six dashboards ; 54 402 accidents ; trois profils K-means ; code et résultats documentés.")
    elif t.startswith("Volumes observés"):
        replace(sh, "Volumes ≠ risque ; une seule année ; silhouette 0,1769 : séparation limitée entre groupes.")
    elif t.startswith("Compléter la source officielle"):
        replace(sh, "Tester MySQL et Tableau ; vérifier les fichiers GitHub et préparer la démonstration.")

for i, s in enumerate(prs.slides, 1):
    for sh in s.shapes:
        if sh.has_text_frame and "Dataviz accidents routiers 2024" in sh.text and "•" in sh.text:
            replace(sh, f"Dataviz accidents routiers 2024   •   {i:02d}")

prs.save(str(DECK))
print("Présentation actualisée :", len(prs.slides), "diapositives")
