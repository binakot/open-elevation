# Open-Elevation

[https://open-elevation.com](https://open-elevation.com).

**Open-Elevation** is a free and open-source alternative
to the [Google Elevation API](https://developers.google.com/maps/documentation/elevation/start) and similar offerings.

## Getting Started

### Run without Docker

```bash
# Build elevation dataset
$ apt-get install -y \
          gdal-bin libgdal-dev \
          wget unar
$ ./scripts/create-dataset.sh

# Run API service
$ pip3 install -r requirements.txt
$ python3 app/main.py

# Example request
$ curl -X GET "http://localhost:8080/api/v1/lookup?locations=51.507351,-0.127696|48.856663,2.351556"
```

### Run via Docker with image building

```bash
$ docker build -t uwsgi-nginx-flask-docker-bookworm:python-3.11 ./base-docker-image
$ docker build -t open-elevation .
$ docker run --rm -v $(pwd)/data:/data open-elevation bash -c 'cd / && ./scripts/create-dataset.sh'
$ docker run --name open-elevation -v $(pwd)/data:/app/data -p 8080:8080 open-elevation
```

### Run via Docker with Docker Hub image

```bash
$ docker run --rm -v $(pwd)/data:/data binakot/open-elevation bash -c 'cd / && ./scripts/create-dataset.sh'
$ docker run --name open-elevation -v $(pwd)/data:/app/data -p 8080:8080 binakot/open-elevation
```

### Run via Docker Compose with Docker Hub image

```bash
$ docker run --rm -v $(pwd)/data:/data binakot/open-elevation bash -c 'cd / && ./scripts/create-dataset.sh'
$ docker compose up -d
```
