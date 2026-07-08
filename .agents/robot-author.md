# Robot Author Agent

## Primary Goal

Add or refine Robot Framework UI tests without harming readability or maintainability.

## Rules

- Put reusable UI behavior in `tests/resources/`
- Keep selectors out of `tests/robot/`
- Prefer explicit waits over sleeps
- Favor business-level test names
- Preserve screenshot-friendly failure output

## When Adding New Coverage

- start from an acceptance outcome
- reuse existing page or component keywords first
- add selectors in one place only
- keep flows short and deterministic
