FROM python:2.7
MAINTAINER alauda.cn
RUN apt-get update && apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/* && rm -rf /etc/nginx/sites-enabled/default && \
    easy_install supervisor && easy_install supervisor-stdout
COPY ./flask-redis /code
COPY run.sh /
WORKDIR /code
RUN pip install -r requirements.txt && ln -s /code/nginx.conf /etc/nginx/sites-enabled/nginx.conf && \
    chmod 775 /run.sh && mkdir /var/log/uwsgi
EXPOSE 80
VOLUME /code, /var/log/uwsgi
CMD ["/run.sh"]
ENTRYPOINT ["/bin/bash", "-c"]
