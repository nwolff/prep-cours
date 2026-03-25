#!/usr/bin/env python3

import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# Configuration Constants
REPO_ROOT: Path = Path(__file__).parent.resolve()
EXERCISES_DIR: Path = REPO_ROOT / "exercices"
OUTPUT_DIR: Path = REPO_ROOT / "output"
FONT_DIR: Path = REPO_ROOT / "fonts"
TEMPLATE_NAME: str = "template.typ"


def get_typ_files(directory: Path, recursive: bool = False) -> List[Path]:
    """Finds .typ files in a directory, excluding templates and private files."""
    pattern: str = "**/*.typ" if recursive else "*.typ"
    return [
        f
        for f in directory.glob(pattern)
        if f.name != TEMPLATE_NAME and not f.name.startswith("_")
    ]


def run_typst(
    input_path: Path, output_path: Path, inputs: Optional[Dict[str, str]] = None
) -> bool:
    """
    Executes the Typst CLI.
    Returns True if compilation succeeded, False otherwise.
    """
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

    # run() returns a CompletedProcess object; we check the returncode
    result = subprocess.run(cmd)

    if result.returncode == 0:
        print(f"✅ Success")
        return True
    else:
        print(f"❌ Failed: {input_path.name}")
        return False


def compile_exercises() -> List[bool]:
    """Handles nested /exercises. Returns a list of success booleans."""
    results = []
    target_dir: Path = OUTPUT_DIR / "exercices"
    typ_files: List[Path] = get_typ_files(EXERCISES_DIR, recursive=True)

    for typ_file in typ_files:
        versions = [
            (target_dir / f"{typ_file.parent.name}.pdf", {"show-answers": "false"}),
            (
                target_dir / f"{typ_file.parent.name}-solutions.pdf",
                {"show-answers": "true"},
            ),
        ]

        for out_path, vars_dict in versions:
            success = run_typst(typ_file, out_path, inputs=vars_dict)
            results.append(success)
    return results


def compile_standalone_docs() -> List[bool]:
    """Handles root .typ files. Returns a list of success booleans."""
    results = []
    root_files: List[Path] = get_typ_files(REPO_ROOT, recursive=False)

    for typ_file in root_files:
        output_path: Path = OUTPUT_DIR / f"{typ_file.stem}.pdf"
        success = run_typst(typ_file, output_path)
        results.append(success)
    return results


if __name__ == "__main__":
    print("🚀 Starting build...")
    OUTPUT_DIR.mkdir(exist_ok=True)

    # Collect all results into one list
    all_results = []
    all_results.extend(compile_exercises())
    all_results.extend(compile_standalone_docs())

    # Check if any False exists in our result list
    if all(all_results):
        print("\n✨ Build complete. All files compiled successfully.")
        sys.exit(0)
    else:
        failed_count = all_results.count(False)
        print(f"\n⚠️  Build finished with {failed_count} error(s).")
        sys.exit(1)  # Exit with error code for CI/CD or shell scripts
