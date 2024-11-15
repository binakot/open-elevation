# https://github.com/tiangolo/uwsgi-nginx-flask-docker/blob/master/docker-images/python3.12.dockerfile
FROM tiangolo/uwsgi-nginx-flask:python3.12
MAINTAINER Ivan Muratov <binakot@gmail.com>

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV CINCLUDE_PATH=/usr/include/gdal

RUN apt-get update && \
    apt-get install -y \
            gdal-bin libgdal-dev \
            unar

COPY ./requirements.txt /opt/app/requirements.txt
RUN pip install --no-cache-dir -r /opt/app/requirements.txt

COPY ./app/nginx.conf /etc/nginx/nginx.conf

ENV LISTEN_PORT=8080
EXPOSE 8080

COPY ./app /app
