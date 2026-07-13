# Architecture

## Runtime Shape

Version 1 uses `OWASP Juice Shop` as the single system under test.
The app runs from the official upstream container image through Docker Compose.
Robot Framework runs directly on the developer machine locally and directly on the GitHub Actions runner in CI.

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
- `tests/data/` contains CSV and Excel scenario input for search coverage
- `tests/variables/` contains environment values and shared Robot settings
- `scripts/` contains helper scripts
- `scripts/test_support/` contains Python-backed test helpers such as CSV readers
- `.github/workflows/` contains GitHub Actions workflows
- `docs/` contains human-first project documentation
- `.agents/` contains AI operating instructions

## Search Coverage Variants

The repository demonstrates three ways to drive the same search assertions from external test data:

- `search_method_1_Python_Reader.robot` loads `search_keywords.csv` through a small Python helper in `scripts/test_support/`
- `search_method_2_DataDriver.robot` loads `search_keywords_datadriver.csv` directly through `robotframework-datadriver`
- `search_method_3_RPA_Excel_Files.robot` reads `search_keywords.xlsx`

This keeps the acceptance logic shared while showing different data-loading approaches.

## CI Shape

The CI pipeline is intentionally simple:

- start Juice Shop with Docker Compose
- wait for readiness
- run Robot suites
- upload Robot artifacts
- tear down the container

There is no hosted environment in version 1.
