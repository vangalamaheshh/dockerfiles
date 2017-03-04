FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
    && apt-get update -y \
    && apt-get install -y wget

RUN set -ex \
    && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin/

RUN set -ex \
    && wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz \
    && tar -zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz

ENV PATH /usr/local/bin/cufflinks-2.2.1.Linux_x86_64:$PATH

