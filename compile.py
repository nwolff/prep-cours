#!/usr/bin/env python3

import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Optional

REPO_ROOT: Path = Path(__file__).parent.resolve()
PROGRAMMATION_DIR: Path = REPO_ROOT / "programmation"
PROGRAMMATION_EXERCISES_DIR: Path = PROGRAMMATION_DIR / "exercices"
DONNEES_DIR: Path = REPO_ROOT / "donnees"
OUTPUT_DIR: Path = REPO_ROOT / "output"
FONT_DIR: Path = REPO_ROOT / "fonts"
TEMPLATE_NAME: str = "template-exercices.typ"


def get_source_date(typ_file: Path) -> Optional[str]:
    # Returns the date of the most recent commit touching any file in the same
    # directory as typ_file (covers the .typ source and co-located images).
    # Returns None if the directory has never been committed; the template then
    # falls back to its own default (today's date).
    result = subprocess.run(
        ["git", "log", "--format=%as", "-1", "--", str(typ_file.parent)],
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
    )
    date_str = result.stdout.strip()
    return date_str if date_str else None


def get_typ_files(directory: Path, recursive: bool = False) -> List[Path]:
    pattern: str = "**/*.typ" if recursive else "*.typ"
    return [
        f
        for f in directory.glob(pattern)
        if f.name != TEMPLATE_NAME and not f.name.startswith("_")
    ]


def run_typst(
    input_path: Path, output_path: Path, inputs: Optional[Dict[str, str]] = None
) -> bool:
    output_path.parent.mkdir(parents=True, exist_ok=True)

    cmd: List[str] = [
        "typst",
        "compile",
        "--root",
        str(REPO_ROOT),
    ]

    if inputs:
        for key, value in inputs.items():
            cmd.extend(["--input", f"{key}={value}"])

    cmd.extend(["--font-path", str(FONT_DIR)])
    cmd.extend([str(input_path), str(output_path)])

    print(f"🔨 Compiling: {input_path.name} -> {output_path.relative_to(REPO_ROOT)}")

    result = subprocess.run(cmd)

    if result.returncode == 0:
        print(f"✅ Success")
        return True
    else:
        print(f"❌ Failed: {input_path.name}")
        return False


def compile_programmation_exercises() -> List[bool]:
    results = []
    target_dir: Path = OUTPUT_DIR / "exercices"
    typ_files: List[Path] = get_typ_files(PROGRAMMATION_EXERCISES_DIR, recursive=True)

    for typ_file in typ_files:
        source_date = get_source_date(typ_file)
        extra = {"date": source_date} if source_date else {}
        versions = [
            (
                target_dir / f"{typ_file.parent.name}.pdf",
                {"show-answers": "false", **extra},
            ),
            (
                target_dir / f"{typ_file.parent.name}-solutions.pdf",
                {"show-answers": "true", **extra},
            ),
        ]

        for out_path, inputs in versions:
            results.append(run_typst(typ_file, out_path, inputs=inputs))
    return results


def compile_programmation_docs() -> List[bool]:
    results = []
    for typ_file in get_typ_files(PROGRAMMATION_DIR, recursive=False):
        output_path: Path = OUTPUT_DIR / f"{typ_file.stem}.pdf"
        source_date = get_source_date(typ_file)
        results.append(
            run_typst(
                typ_file,
                output_path,
                inputs={"date": source_date} if source_date else None,
            )
        )
    return results


SQL_SELECTION_BASE_TAGS = ",".join(
    [
        "select",
        "commentaires",
        "distinct",
        "where",
        "operateurs",
        "and-or",
        "between",
        "like",
        "agregation",
        "group-by",
        "having",
        "order-by",
        "jointures",
        "join",
        "left-join",
        "right-join",
        "notation-table-colonne",
        "jointure-trois-tables",
    ]
)


def compile_donnees() -> List[bool]:
    results = []
    for typ_file in get_typ_files(DONNEES_DIR, recursive=True):
        source_date = get_source_date(typ_file)
        extra = {"date": source_date} if source_date else {}
        is_cours = typ_file.stem.startswith("cours-")
        versions = [
            (
                OUTPUT_DIR / "donnees" / f"donnees-{typ_file.stem}.pdf",
                {"show-answers": "false", **extra},
            ),
        ]
        if typ_file.stem == "cours-sql-selection":
            versions.append(
                (
                    OUTPUT_DIR / "donnees" / f"donnees-{typ_file.stem}_base.pdf",
                    {"tags": SQL_SELECTION_BASE_TAGS, **extra},
                )
            )
        if not is_cours:
            versions.append(
                (
                    OUTPUT_DIR / "donnees" / f"donnees-{typ_file.stem}-solutions.pdf",
                    {"show-answers": "true", **extra},
                )
            )
        for out_path, inputs in versions:
            results.append(run_typst(typ_file, out_path, inputs=inputs))
    return results


if __name__ == "__main__":
    print("🚀 Starting build...")
    OUTPUT_DIR.mkdir(exist_ok=True)

    all_results = []
    all_results.extend(compile_programmation_exercises())
    all_results.extend(compile_programmation_docs())
    all_results.extend(compile_donnees())

    if all(all_results):
        print("\n✨ Build complete. All files compiled successfully.")
        sys.exit(0)
    else:
        failed_count = all_results.count(False)
        print(f"\n⚠️  Build finished with {failed_count} error(s).")
        sys.exit(1)
