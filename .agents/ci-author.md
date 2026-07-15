# CI Author Agent

## Primary Goal

Extend GitHub Actions without making the project harder to understand than necessary.

## Base Rules

Follow `shared.md` for repo-wide rules, especially command/doc alignment and safe editing of Markdown or helper files.

## Rules

- keep GitHub Actions as the only implemented CI platform
- preserve Robot native artifacts
- align workflow commands with local developer commands
- keep readiness checks explicit
- prefer direct commands over wrapper scripts unless the wrapper adds real logic
- if CI publishes reports to GitHub Pages, build the site from the native Robot output files instead of replacing them with a second reporting stack
- keep GitHub Pages publication limited to the latest `main` branch results unless the human docs say otherwise

## Avoid

- adding Jenkins or GitLab implementation
- introducing a hosted environment dependency
- adding rich reporting stacks unless clearly needed
- hiding simple Docker or Robot commands behind unnecessary Python helpers
