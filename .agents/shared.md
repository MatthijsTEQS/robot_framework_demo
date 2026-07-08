# Shared Agent Guidance

## Project Intent

This repository demonstrates a maintainable Robot Framework UI automation setup against OWASP Juice Shop.

## Scope Boundaries

- UI tests only
- GitHub Actions only in version 1
- no hosted environment
- no API suite
- no checkout flow

## Repo Guardrails

- Treat `docs/` as human-first project truth
- Use `.agents/` for AI operating behavior
- Treat generated folders like `*.egg-info/` and `results/` as non-source artifacts
- Prefer direct shell commands over thin wrapper scripts when the wrapper adds no real behavior

## Architecture Rules

- Keep selectors centralized in resource files
- Keep business flows readable in Robot suites
- Keep CI commands aligned with the documented local commands
- Keep version-1 structure simple and explicit

## Selector Rules

- prefer role, label, text, or test ids
- use short CSS selectors when needed
- use XPath only as fallback
- never scatter repeated selectors across suite files

## Testing Philosophy

- optimize for acceptance value
- keep version 1 stable and teachable
- avoid clever abstraction for its own sake
- tighten live locators based on real test feedback, not speculation
