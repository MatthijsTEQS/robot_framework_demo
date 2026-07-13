# Getting Started

## Prerequisites

- Python 3.11+
- Docker Desktop or another Docker installation with `docker` available on PATH
- Node.js available for Browser library initialization

## Install Dependencies

```bash
python -m pip install -e .
rfbrowser init
```

## Start The Webshop

Start the container:

```bash
docker compose -f webshop_app/docker-compose.yml up -d
```

Check if the webshop is reachable:

```bash
python scripts/wait_for_url.py http://127.0.0.1:3000
```

## Run The UI Tests

Run the tests normally:

```bash
python -m robot --outputdir results tests/robot
```

Record a video of the tests:

```bash
python -m robot --outputdir results --variable RECORD_VIDEO:True --variable HEADLESS:False tests/robot
```

## Login Flow

The login suite creates a fresh account with a name like `testaccountHHMMSS@example.com` and then logs in with that same account in the next test.

## GitHub Pages Report

On pushes to `main`, GitHub Actions also publishes the latest Robot outputs to GitHub Pages.
The Pages site links to the native `report.html`, `log.html`, and `output.xml` files from the most recent `main` branch run.

To enable this in GitHub, set Pages to build from `GitHub Actions` in the repository settings.

## Stop The Webshop

```bash
docker compose -f webshop_app/docker-compose.yml down --remove-orphans
```
