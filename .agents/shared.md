# Shared Agent Guidance

## Project Intent

This repository demonstrates a maintainable Robot Framework UI automation setup against OWASP Juice Shop.

## Scope Boundaries

- UI tests only
- GitHub Actions only in version 1
- no hosted environment
- no API suite
- no checkout flow

## Architecture Rules

- Treat `docs/` as human-first project truth
- Use `.agents/` for AI operating behavior
- Keep selectors centralized in resource files
- Keep business flows readable in Robot suites

## Selector Rules

- prefer role, label, text, or test ids
- use short CSS selectors when needed
- use XPath only as fallback
- never scatter repeated selectors across suite files

## Testing Philosophy

- optimize for acceptance value
- keep version 1 stable and teachable
- avoid clever abstraction for its own sake
