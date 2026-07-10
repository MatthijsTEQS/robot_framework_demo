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

- `.agents/` contains AI instructions to help AI tools behave consistently in the repo.
- `shared.md` defines common project rules, scope boundaries, selector rules, and helper-code placement rules.
- `robot-author.md` explains how to create or refine Robot UI tests, where selectors belong, where Python test helpers belong, and what patterns to avoid.
- `ci-author.md` explains how to work on GitHub workflow and CI behavior.
- `reviewer.md` explains what AI review work should focus on.
- `.github/workflows/ui-tests.yml` is the GitHub Actions workflow file.
- `docs/` contains human-first project documentation.
- `acceptance-criteria.md` captures the business-facing outcomes the project should prove.
- `architecture.md` explains the runtime shape and repo structure.
- `coding-standards.md` explains coding conventions.
- `getting-started.md` contains local setup and run commands.
- `testing-strategy.md` explains what we test and how the suites are structured.
- `scripts/` contains helper scripts.
- `scripts/test_support/` contains Python-backed helpers for tests, such as CSV readers.
- `wait_for_url.py` waits until the webshop is reachable before continuing with tests.
- `tests/data/` contains CSV- and Excel-based scenario input for search coverage.
- `tests/robot/` contains business-readable Robot suites.
- `tests/resources/` contains reusable keywords and centralized locators.
- `tests/variables/` contains Robot variable resources for environment values, browser, and timeouts.
- `webshop_app/` contains runtime assets for the system under test.
- `docker-compose.yml` starts the upstream `OWASP Juice Shop` container.
- `pyproject.toml` defines the Python project metadata and dependencies, including `robotframework-browser`, `robotframework-datadriver`, and `rpaframework`.

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
5. starts Juice Shop with Docker Compose
6. waits until the app is reachable
7. runs the Robot UI suite directly
8. uploads Robot results as build artifacts
9. stops the webshop container
