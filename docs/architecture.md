# Architecture

## Purpose

This project demonstrates a maintainable Robot Framework UI automation setup for a containerized webshop.

## Version 1 Architecture

Version 1 has two runtime parts:

1. `OWASP Juice Shop` running in Docker
2. `Robot Framework + Browser` running from Python on the host or GitHub runner

The app under test is ephemeral:

- local developers start it with Docker Compose
- GitHub Actions starts it inside the workflow
- there is no always-on hosted environment in version 1

## Key Design Rules

- Keep the app startup reproducible
- Keep Robot test execution simple
- Keep selectors centralized in resource files
- Keep business flows readable in the test suites
- Keep version 1 GitHub-only for CI implementation

## Repository Areas

- `webshop_app/` contains Docker Compose and runtime assets
- `tests/robot/` contains Robot suites
- `tests/resources/` contains reusable UI keywords and locators
- `tests/variables/` contains environment and test data variables
- `scripts/` contains helper scripts
- `docs/` contains human-first project truth
- `.agents/` contains AI operating instructions

## What Is Deliberately Not In Version 1

- hosted test environments
- a containerized Robot runner
- API testing
- Jenkins or GitLab CI implementation
- mandatory BDD or Screenplay patterns
