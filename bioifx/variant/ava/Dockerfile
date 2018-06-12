FROM mvangala/base-nginx:python3.6-a6bbf7331186 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

RUN set -ex \
  && apt-get update -y \
  && apt-get install -y unzip \
  && apt-get install -y vim \
  && apt-get install -y git \
  && apt-get install -y wget \
  && apt-get install -y bzip2 \
  && apt-get install -y curl

# install miniconda3
RUN set -ex \
  && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/bin/miniconda3

ENV PATH /usr/local/bin/miniconda3/bin:$PATH

COPY ./annovar.latest.tar.gz /usr/local/bin/annovar.latest.tar.gz

RUN set -ex \
  && tar -zxvf /usr/local/bin/annovar.latest.tar.gz

RUN set -ex \
  && git clone https://github.com/vangalamaheshh/Intervar.git \
  && chmod 755 /usr/local/bin/Intervar/Intervar.py \
  && git clone https://github.com/dst-umms/AVA.git \
  && conda env update -f /usr/local/bin/AVA/env/requirements.yaml

COPY ./mim2gene.txt /usr/local/bin/Intervar/intervardb/mim2gene.txt

# set up flask with nginx
# By default, allow unlimited file sizes, modify it to limit the file sizes
# To have a maximum of 1 MB (Nginx's default) change the line to:
# ENV NGINX_MAX_UPLOAD 1m
ENV NGINX_MAX_UPLOAD 0

# Which uWSGI .ini file should be used, to make it customizable
ENV UWSGI_INI /usr/local/bin/AVA/uwsgi.ini
# URL under which static (not modified by Python) files will be requested
# They will be served by Nginx directly, without being handled by uWSGI
ENV STATIC_URL /static
# Absolute path in where the static files wil be
ENV STATIC_PATH /usr/local/bin/AVA
# If STATIC_INDEX is 1, serve / with /static/index.html directly (or the static URL configured)
# ENV STATIC_INDEX 1
ENV STATIC_INDEX 0
# Copy the entrypoint that will generate Nginx additional configs
COPY uwsgi.ini /usr/local/bin/AVA/uwsgi.ini
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /usr/local/bin/AVA
CMD ["/usr/bin/supervisord"]


