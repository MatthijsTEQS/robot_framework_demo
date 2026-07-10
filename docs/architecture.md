# Architecture

## Runtime Shape

This project demonstrates a maintainable Robot Framework UI automation setup for a containerized webshop.
It uses the `OWASP Juice Shop` as the System under Test. The app runs from the official upstream container image through Docker Compose.
Robot Framework runs locally and on the GitHub Actions runner in CI.

## Test Architecture

The UI automation stack is:

- `Python`
- `Robot Framework`
- `Robot Framework Browser`
- `Playwright` through the Browser library

The test design stays lightweight:

- Robot suites describe business flows and acceptance outcomes
- resource files hold reusable UI actions and locators
- selectors stay out of suite files
- tests stay readable and business-oriented

## Repository Structure

The repository is organized like this:

- `webshop_app/` contains Docker Compose assets for the webshop runtime
- `tests/robot/` contains Robot suites
- `tests/resources/` contains reusable UI keywords and locators
- `tests/data/` contains CSV scenario input for data-driven coverage
- `tests/variables/` contains environment values and shared Robot settings
- `scripts/` contains helper scripts
- `scripts/test_support/` contains Python-backed test helpers such as CSV readers
- `.github/workflows/` contains GitHub Actions workflows
- `docs/` contains human-first project documentation
- `.agents/` contains AI operating instructions

## Search Coverage Variants

The repository demonstrates two ways to drive the same search assertions from CSV data:

- `search_method_1.robot` loads `search_keywords.csv` through a small Python variable file in `scripts/test_support/`
- `search_method_2.robot` loads `search_keywords_datadriver.csv` through `robotframework-datadriver`

This keeps the acceptance logic shared while showing two different data-loading approaches.

## CI Shape

The CI pipeline is intentionally simple:

- start Juice Shop with Docker Compose
- wait for readiness
- run Robot suites
- upload Robot artifacts
- tear down the container

There is no hosted environment in version 1.
