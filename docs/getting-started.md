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

## Stop The Webshop

```bash
docker compose -f webshop_app/docker-compose.yml down --remove-orphans
```
