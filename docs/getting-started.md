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

```bash
python -m robot --outputdir results tests/robot
```

## Login Test Data

The login suite reads credentials from `tests/data/login_credentials.csv`.

- each CSV row becomes its own Robot test result
- add more rows to expand coverage without editing the suite
- the first CSV column is the DataDriver test title field
- the remaining columns define the credential values and expected outcome

## Stop The Webshop

```bash
docker compose -f webshop_app/docker-compose.yml down --remove-orphans
```
