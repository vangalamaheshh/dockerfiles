FROM ubuntu:16.04 

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

RUN set -ex \
  && apt-get install -y python2.7 \
  && ln -s /usr/bin/python2.7 /usr/bin/python

COPY ./annovar.latest.tar.gz /usr/local/bin/annovar.latest.tar.gz

RUN set -ex \
  && tar -zxvf /usr/local/bin/annovar.latest.tar.gz

RUN set -ex \
  && git clone https://github.com/vangalamaheshh/Intervar.git \
  && chmod 755 /usr/local/bin/Intervar/Intervar.py

COPY ./mim2gene.txt /usr/local/bin/Intervar/intervardb/mim2gene.txt


