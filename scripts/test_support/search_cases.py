"""Load search rows from the CSV file."""

from __future__ import annotations

import csv
from pathlib import Path

__all__ = ["ROWS"]


def _load_rows() -> list[dict[str, int | str]]:
    """Return normalized rows from the CSV file."""
    data_path = (
        Path(__file__).resolve().parents[2]
        / "tests"
        / "data"
        / "search_keywords.csv"
    )
    with data_path.open(encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle)
        return [
            {
                "input": row["Input"].strip(),
                "expectation": int(row["Expectation"]),
            }
            for row in reader
        ]


ROWS = _load_rows()
