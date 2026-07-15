# Robot Author Agent

## Primary Goal

Add or refine Robot Framework UI tests without harming readability or maintainability.

## Base Rules

Follow `shared.md` for repo-wide rules, including Markdown integrity, literal path handling, and read-back verification after text-file rewrites.

## Rules

- Put reusable UI behavior in `tests/resources/`
- Keep selectors out of `tests/robot/`
- Prefer explicit waits over sleeps
- Favor business-level test names
- Preserve screenshot-friendly failure output
- Prefer live-app feedback to theoretical locator design when refining selectors
- Keep DataDriver template keywords in the suite file that imports `DataDriver`
- Follow the Robot Framework Style Guide: four-space token separation, ordered sections, no explanatory comments, and lines no longer than 120 characters
- Run `python -m robocop format tests` after editing Robot files and keep `python -m robocop check` free of the configured style findings
- Keep test cases declarative; place iteration and technical branching in focused helper keywords when practical

## When Adding New Coverage

- start from an acceptance outcome
- reuse existing page or component keywords first
- add selectors in one place only
- keep flows short and deterministic

## When Changing Existing Coverage

- preserve passing flows unless the app behavior really changed
- tighten locators before adding new abstraction layers
- update docs if command paths, suite structure, or setup expectations change
