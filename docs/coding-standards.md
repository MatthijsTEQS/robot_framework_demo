# Coding Standards

## General

- Keep the project simple and readable
- Prefer explicit code over clever abstractions
- Keep docs and automation aligned

## Robot Framework

- Use business-oriented test names
- Put locators and reusable UI actions in resource files
- Avoid giant keywords that hide too much flow detail
- Prefer robust waits over sleeps
- Capture screenshots on failures
- Follow the [Robot Framework Style Guide](https://docs.robotframework.org/docs/style_guide)
- Use four spaces between tokens, keep lines at or below 120 characters, and avoid explanatory comments
- Run `python -m robocop format tests` and the configured Robocop lint check before submitting changes

## Python Scripts

- Keep helper scripts small and cross-platform
- Use the standard library unless a dependency is clearly justified
- Prefer clear exit codes and simple console output

## CI

- Keep the workflow understandable in one pass
- Preserve native Robot artifacts
- Match CI commands to local commands as closely as possible
