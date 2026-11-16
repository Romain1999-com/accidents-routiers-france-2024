#!/usr/bin/env python3
"""Verifier les fichiers du depot avant sa publication et generer un manifeste SHA256.

Utilisation depuis la racine du projet :
    python scripts/preparer_publication.py --scan
    python scripts/preparer_publication.py --write
    python scripts/preparer_publication.py --check

Le manifeste n'inclut pas sa propre empreinte. Ce script ne publie rien sur GitHub.
"""
from __future__ import annotations

import argparse
import hashlib
import re
import subprocess
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "MANIFEST_SHA256.tsv"
HEADER = "Fichier\tTaille_octets\tSHA256"
EXCLUDED_DIRS = {".git", ".venv", "venv", "__pycache__", ".idea", ".vscode"}
TEXT_SUFFIXES = {".md", ".txt", ".csv", ".tsv", ".sql", ".py", ".json", ".yml", ".yaml", ".xml", ".ini", ".cfg", ".toml", ".sh", ".ps1"}
ARCHIVE_SUFFIXES = {".twbx", ".docx", ".pptx"}
ASSIGNMENT = re.compile(
    rb"(?i)\b(?:password|passwd|pwd|api[_-]?key|client[_-]?secret|access[_-]?token)\b\s*[:=]\s*['\"]?([^\s'\";,]+)"
)
SQL_PASSWORD = re.compile(rb"(?i)\bIDENTIFIED\s+BY\s+['\"][^'\"]+")
TOKEN = re.compile(
    rb"(?:gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|sk-[A-Za-z0-9]{24,})"
)


def file_paths() -> list[Path]:
    """Preferer les fichiers suivis par Git, sinon les fichiers du dossier local."""
    try:
        p = subprocess.run(
            ["git", "-C", str(ROOT), "ls-files", "-z", "--cached"],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True
        )
        paths = [ROOT / x.decode("utf-8", "surrogateescape") for x in p.stdout.split(b"\0") if x]
    except (OSError, subprocess.CalledProcessError):
        paths = [p for p in ROOT.rglob("*") if p.is_file()
                 and not any(part in EXCLUDED_DIRS for part in p.relative_to(ROOT).parts)]
    return sorted((p for p in paths if p.is_file() and p.resolve() != MANIFEST.resolve()),
                  key=lambda p: p.relative_to(ROOT).as_posix())


def digest(path: Path) -> tuple[int, str]:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(1024 * 1024), b""):
            h.update(block)
    return path.stat().st_size, h.hexdigest()


def manifest_text(paths: list[Path]) -> str:
    lines = [HEADER]
    for p in paths:
        size, sha = digest(p)
        lines.append(f"{p.relative_to(ROOT).as_posix()}\t{size}\t{sha}")
    return "\n".join(lines) + "\n"


def write_manifest(paths: list[Path]) -> int:
    MANIFEST.write_text(manifest_text(paths), encoding="utf-8", newline="\n")
    print(f"Manifeste genere : {len(paths)} fichiers, {MANIFEST.name}")
    return 0


def check_manifest(paths: list[Path]) -> int:
    if not MANIFEST.is_file():
        print("ERREUR : manifeste absent.", file=sys.stderr)
        return 1
    expected = MANIFEST.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    actual = manifest_text(paths)
    if expected == actual:
        print(f"OK : empreintes et tailles conformes pour {len(paths)} fichiers.")
        return 0
    print("ECHEC : le manifeste ne correspond pas aux fichiers actuels.")
    old = {line.split("\t", 1)[0]: line for line in expected.splitlines()[1:] if "\t" in line}
    new = {line.split("\t", 1)[0]: line for line in actual.splitlines()[1:] if "\t" in line}
    for name in sorted(old.keys() | new.keys()):
        if old.get(name) != new.get(name):
            reason = "ajoute" if name not in old else "absent" if name not in new else "modifie"
            print(f"  {reason} : {name}")
    return 1


def scan_bytes(label: str, data: bytes) -> int:
    hits = 0
    for line_no, line in enumerate(data.splitlines(), 1):
        if ASSIGNMENT.search(line) or SQL_PASSWORD.search(line) or TOKEN.search(line):
            print(f"  A EXAMINER : {label}, ligne {line_no} (contenu masque)")
            hits += 1
    return hits


def scan(paths: list[Path]) -> int:
    print("Recherche indicative de secrets dans les fichiers suivis.")
    hits = 0
    for p in paths:
        name = p.relative_to(ROOT).as_posix()
        if p.suffix.lower() in TEXT_SUFFIXES or p.name.startswith(".env"):
            with p.open("rb") as f:
                # Traiter ligne par ligne, y compris pour l'export SQL de grande taille.
                for line_no, line in enumerate(f, 1):
                    if ASSIGNMENT.search(line) or SQL_PASSWORD.search(line) or TOKEN.search(line):
                        print(f"  A EXAMINER : {name}, ligne {line_no} (contenu masque)")
                        hits += 1
        elif p.suffix.lower() in ARCHIVE_SUFFIXES:
            try:
                with zipfile.ZipFile(p) as z:
                    for entry in z.infolist():
                        if (entry.filename.lower().endswith((".xml", ".twb", ".rels"))
                                and entry.file_size <= 20_000_000):
                            hits += scan_bytes(f"{name}!{entry.filename}", z.read(entry))
            except (zipfile.BadZipFile, OSError):
                print(f"  AVERTISSEMENT : archive non inspectable : {name}")
    if hits:
        print(f"{hits} alerte(s) potentielles. Verifier manuellement avant publication.")
        return 1
    print("Aucun motif de secret detecte par ce controle automatique.")
    print("ATTENTION : inspecter aussi les donnees, les metadonnees des documents et l'historique Git.")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--scan", action="store_true", help="Rechercher des motifs de secrets")
    mode.add_argument("--write", action="store_true", help="Recalculer le manifeste SHA256")
    mode.add_argument("--check", action="store_true", help="Comparer les fichiers au manifeste")
    args = parser.parse_args()
    paths = file_paths()
    if args.scan:
        return scan(paths)
    if args.write:
        return write_manifest(paths)
    return check_manifest(paths)


if __name__ == "__main__":
    sys.exit(main())
