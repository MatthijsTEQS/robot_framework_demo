# Robot Framework Webshop Demo

This repository contains a version-1 demo project for UI-only webshop testing with `Python + Robot Framework + Browser` against `OWASP Juice Shop`.

Version 1 goals:

- run Juice Shop locally with Docker Compose
- run Robot Framework UI tests locally
- run the same tests in GitHub Actions
- publish the latest `main` branch Robot results to GitHub Pages
- keep the test structure maintainable and readable
- provide human docs in `docs/` and AI operating files in `.agents/`

Start with `docs/getting-started.md`.

## File Structure

- `.agents/` contains AI instructions to help AI tools behave consistently in the repo.
    - `ci-author.md` tells an AI how to extend GitHub Actions, preserve native Robot artifacts, and keep CI commands aligned with the local developer flow.
    - `reviewer.md` tells an AI what to review for, with emphasis on maintainability, flaky waits, stale docs, and scope control.
    - `robot-author.md` tells an AI how to add or refactor Robot suites, resources, locators, and test-support helpers without leaking selectors into suite files.
    - `shared.md` defines common project rules, scope boundaries, selector rules, and helper-code placement rules.

- `.github/workflows/ui-tests.yml` is the version-1 GitHub Actions pipeline. It installs the project, starts Juice Shop, runs the Robot suites, uploads the raw `results/` artifact, builds a small static site from those same files, and deploys the latest `main` branch results to GitHub Pages.

- `docs/` contains human-first project documentation.
    - `acceptance-criteria.md` captures the business-facing outcomes the project should prove.
    - `architecture.md` explains the runtime shape, repo structure, and CI design.
    - `coding-standards.md` explains coding conventions.
    - `getting-started.md` contains local setup and run commands plus the GitHub Pages reporting note.
    - `testing-strategy.md` explains what we test and how the suites are structured.

- `scripts/` contains helper scripts grouped by purpose.
    - `wait_for_url.py` performs the shared readiness polling used by CI and local runs.
    - `reporting/build_pages_site.py` copies the latest native Robot outputs into a static site folder and writes a landing page for GitHub Pages.
    - `test_support/search_cases.py` contains Python-backed helpers used by tests, such as CSV readers.

- `tests/`
    - `data/` contains CSV- and Excel-based scenario input for search coverage.
    - `robot/` contains business-readable Robot suites.
    - `resources/` contains reusable keywords and centralized locators.
    - `variables/` contains Robot variable resources for environment values, browser, and timeouts.

- `webshop_app/docker-compose.yml` contains runtime assets for the upstream `OWASP Juice Shop` container.
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
8. uploads `results/` as the raw build artifact
9. builds a static site from the same Robot outputs
10. deploys that site to GitHub Pages on pushes to `main`
11. stops the webshop container
