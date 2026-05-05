#!/usr/bin/env python3

import shutil
import subprocess
import sys
from collections.abc import Callable
from concurrent.futures import ThreadPoolExecutor
from functools import partial
from pathlib import Path
from typing import Dict, List, Optional

REPO_ROOT = Path(__file__).parent.resolve()

PROG_DIR = REPO_ROOT / "prog"

DONNEES_DIR = REPO_ROOT / "donnees"

OUTPUT_DIR = REPO_ROOT / ".output"
FONT_DIR = REPO_ROOT / "_fonts"
TEMPLATE_NAME = "template-exercices.typ"

Job = Callable[[], bool]


def get_source_date(typ_file: Path) -> Optional[str]:
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
        "--font-path",
        str(FONT_DIR),
    ]

    if inputs:
        for key, value in inputs.items():
            cmd.extend(["--input", f"{key}={value}"])

    cmd.extend([str(input_path), str(output_path)])

    result = subprocess.run(cmd, capture_output=True, text=True)

    rel_out = output_path.relative_to(REPO_ROOT)
    if result.returncode == 0:
        print(f"✓ {rel_out}")
        return True
    else:
        print(f"✗ {rel_out}\n{result.stderr.strip()}", file=sys.stderr)
        return False


def compile_exercises(root: Path) -> List[Job]:
    jobs = []
    for exercises_dir in sorted(root.glob("*/exercices")):
        category = exercises_dir.parent.name
        target_dir: Path = OUTPUT_DIR / category / "exercices"
        for typ_file in get_typ_files(exercises_dir, recursive=True):
            source_date = get_source_date(typ_file)
            extra = {"date": source_date} if source_date else {}
            versions = [
                (
                    target_dir / f"{category}-{typ_file.parent.name}.pdf",
                    {"show-answers": "false", **extra},
                ),
                (
                    target_dir / f"{category}-{typ_file.parent.name}-solution.pdf",
                    {"show-answers": "true", **extra},
                ),
            ]
            for out_path, inputs in versions:
                jobs.append(partial(run_typst, typ_file, out_path, inputs=inputs))
    return jobs


def compile_prog_docs() -> List[Job]:
    jobs = []
    for typ_file in get_typ_files(PROG_DIR, recursive=False):
        output_path: Path = OUTPUT_DIR / "prog" / f"{typ_file.stem}.pdf"
        source_date = get_source_date(typ_file)
        jobs.append(
            partial(
                run_typst,
                typ_file,
                output_path,
                inputs={"date": source_date} if source_date else None,
            )
        )
    return jobs


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


def compile_donnees_docs() -> List[Job]:
    jobs = []
    for typ_file in get_typ_files(DONNEES_DIR / "cours", recursive=False):
        source_date = get_source_date(typ_file)
        extra = {"date": source_date} if source_date else {}
        out_path = OUTPUT_DIR / "donnees" / "cours" / f"{typ_file.stem}_base.pdf"
        jobs.append(
            partial(
                run_typst,
                typ_file,
                out_path,
                inputs={"tags": SQL_SELECTION_BASE_TAGS, **extra},
            )
        )
    return jobs


if __name__ == "__main__":
    print("🚀 Starting build...")
    OUTPUT_DIR.mkdir(exist_ok=True)

    for f in OUTPUT_DIR.iterdir():
        if f.is_dir():
            shutil.rmtree(f)
        else:
            f.unlink()

    jobs: List[Job] = []
    jobs.extend(compile_exercises(REPO_ROOT))
    jobs.extend(compile_prog_docs())
    jobs.extend(compile_donnees_docs())

    with ThreadPoolExecutor() as executor:
        futures = [executor.submit(job) for job in jobs]

    results = [f.result() for f in futures]

    if all(results):
        print("\n✨ Build complete. All files compiled successfully.")
        sys.exit(0)
    else:
        failed_count = results.count(False)
        print(f"\n⚠️  Build finished with {failed_count} error(s).")
        sys.exit(1)
