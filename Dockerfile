FROM uwsgi-nginx-flask-docker-bookworm
MAINTAINER Ivan Muratov <binakot@gmail.com>

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

RUN apt-get update &&\
    apt-get install -y \
            wget unar \
            gdal-bin libgdal-dev

COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

ENV LISTEN_PORT=8080
EXPOSE 8080

COPY ./app /app
