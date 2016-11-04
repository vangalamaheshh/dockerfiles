FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
    && apt-get update -y \
    && apt-get install -y vim \
    && apt-get install -y git \
    && apt-get install -y wget \
    && apt-get install -y gcc g++ make \
    && apt-get install -y bzip2

RUN set -ex \
    && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin/

RUN set -ex \
    && git clone https://github.com/alexdobin/STAR.git

ENV PATH /usr/local/bin/STAR/bin/Linux_x86_64_static:$PATH

