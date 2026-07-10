"""Load CSV-driven search expectations for Robot suites that use a Python variable file."""

from __future__ import annotations

import csv
from pathlib import Path


def _load_search_cases() -> list[dict[str, int | str]]:
    """Return search cases with normalized keywords and integer result counts."""
    data_path = Path(__file__).resolve().parents[2] / "tests" / "data" / "search_keywords.csv"
    with data_path.open(encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle)
        cases = []
        for row in reader:
            cases.append(
                {
                    "keyword": row["keyword"].strip(),
                    "amount_of_results": int(row["amount_of_results"]),
                }
            )
    return cases


SEARCH_CASES = _load_search_cases()
