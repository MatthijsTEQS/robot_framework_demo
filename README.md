# Robot Framework Webshop Demo

This repository contains a version-1 demo project for UI-only webshop testing with `Python + Robot Framework + Browser` against `OWASP Juice Shop`.

Version 1 goals:

- run Juice Shop locally with Docker Compose
- run Robot Framework UI tests locally
- run the same tests in GitHub Actions
- keep the test structure maintainable and readable
- provide human docs in `docs/` and AI operating files in `.agents/`

Start with `docs/getting-started.md`.

## File Structure

- `.agents/` AI instructions. These are meant to help AI tools behave consistently in the repo
  - `shared.md`: common project rules for AI tasks. Explains scope boundaries, architecture rules, selector rules, and the general testing philosophy
  - `robot-author.md`: instructions for creating Robot UI tests. Explains where selectors belong, how keywords should be written, and what patterns to avoid
  - `ci-author.md`: instructions for GitHub workflow and related CI behavior
  - `reviewer.md`: instructions for review-style AI work

- `.github/workflows/ui-tests.yml` The Github workflow file

- `app/` Runtime assets for the system under test
  - `docker-compose.yml` starts the upstream `OWASP Juice Shop` container

- `docs/` Human-first project documentation
  - `acceptance-criteria.md`: captures the business-facing outcomes the project should prove
  - `architecture.md`: explains the runtime shape and repo structure
  - `coding-standards.md`: explains coding conventions
  - `getting-started.md`: local setup and run commands
  - `testing-strategy.md`: explains what we test and the suite structure

- `scripts/` Helper scripts grouped by purpose
  - `scripts/runtime/`: scripts for starting and stopping the webshop runtime
  - `scripts/testing/`: scripts used to prepare or execute tests

- `tests/` Robot Framework automation assets
  - `robot/`: test suites written in business language
  - `resources/`: reusable keywords and centralized locators
  - `variables/`: environment and test data values

- `pyproject.toml` The Python project configuration file. Defines package metadata, dependency installation, and setup

## GitHub Actions Workflow
The workflow:
- runs on pull requests
- runs on pushes to `main`
- keeps reporting native to Robot
- avoids extra CI platforms or hosted environments in version 1

It is the version-1 CI pipeline and does the following:
1. checks out the repository
2. sets up Python
3. installs the project dependencies
4. initializes the Browser library and Playwright side
5. starts Juice Shop
6. waits until the app is reachable
7. runs the Robot UI suite
8. uploads Robot results as build artifacts
9. stops the webshop container
