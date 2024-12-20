# https://github.com/tiangolo/uwsgi-nginx-flask-docker/blob/master/docker-images/python3.12.dockerfile / debian 11 bullseye
FROM python:3.11-bookworm

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app
ENV UWSGI_INI /app/uwsgi.ini
ENV STATIC_URL /static
ENV STATIC_PATH /app/static
ENV STATIC_INDEX 0
ENV LISTEN_PORT 80

COPY uwsgi.ini /etc/uwsgi/

COPY install-nginx.sh /
RUN bash /install-nginx.sh
RUN rm /etc/nginx/conf.d/default.conf

RUN apt-get update &&\
    apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY stop-supervisor.sh /etc/supervisor/stop-supervisor.sh
RUN chmod +x /etc/supervisor/stop-supervisor.sh

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY app /app
WORKDIR /app

COPY uwsgi-nginx-entrypoint.sh /uwsgi-nginx-entrypoint.sh
RUN chmod +x /uwsgi-nginx-entrypoint.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
