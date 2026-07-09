# Shared Agent Guidance

## Purpose

This file contains the repo-wide rules that apply across authoring, reviewing, and CI work.
Role-specific agent files should build on this file instead of repeating it.

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
- Preserve Markdown formatting when editing docs and agent files
- Keep literal paths, filenames, commands, and code identifiers wrapped in backticks when they are meant to stay literal
- After rewriting a text file, re-read it and verify that no path, backtick, or control-character corruption was introduced

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
