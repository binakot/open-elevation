# Open-Elevation

[https://open-elevation.com](https://open-elevation.com).

**Open-Elevation** is a free and open-source alternative
to the [Google Elevation API](https://developers.google.com/maps/documentation/elevation/start) and similar offerings.

## Getting Started

### Run without docker

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

### Run via docker with image building

```bash
$ docker build --progress=plain -t uwsgi-nginx-flask-docker-bookworm ./base-docker-image
$ docker build --progress=plain -t open-elevation .
$ docker run --name open-elevation -p 8080:8080 open-elevation
$ docker exec -it open-elevation < TODO
```

### Run via docker with Docker Hub image

```bash
$ docker run --name open-elevation -p 8080:8080 binakot/open-elevation
$ docker exec -it open-elevation bash < TODO
```
