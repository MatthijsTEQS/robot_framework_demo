# Coding Standards

## General

- Keep version 1 simple and readable
- Prefer explicit code over clever abstractions
- Keep docs and automation aligned

## Robot Framework

- Use business-oriented test names
- Put locators and reusable UI actions in resource files
- Avoid giant keywords that hide too much flow detail
- Prefer robust waits over sleeps
- Capture screenshots on failures

## Python Scripts

- Keep helper scripts small and cross-platform
- Use the standard library unless a dependency is clearly justified
- Prefer clear exit codes and simple console output

## CI

- Keep the workflow understandable in one pass
- Preserve native Robot artifacts
- Match CI commands to local commands as closely as possible
