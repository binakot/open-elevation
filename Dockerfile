FROM uwsgi-nginx-flask-docker-bookworm:python-3.11
MAINTAINER Ivan Muratov <binakot@gmail.com>

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH
ENV C_INCLUDE_PATH=/usr/local/include:$C_INCLUDE_PATH

RUN apt-get update &&\
    apt-get install -y \
            wget unar bc \
            gdal-bin libgdal-dev python3-gdal

COPY ./requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

RUN pip3 uninstall -y gdal &&\
    pip3 install numpy &&\
    pip3 install GDAL==$(gdal-config --version) --global-option=build_ext --global-option="-I/usr/include/gdal"

RUN gdalinfo --version &&\
    python3 -c "from osgeo import gdal; print(gdal.__version__)"

ENV LISTEN_PORT=8080
EXPOSE 8080

COPY ./app /app
COPY ./scripts /scripts
