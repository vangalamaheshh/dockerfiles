FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
    && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

# apt update and install vim, git, wget, gcc, g++, make, bzip2
RUN set -ex \
    && apt-get update -y \
    && apt-get install -y vim \
    && apt-get install -y git \
    && apt-get install -y wget \
    && apt-get install -y gcc g++ make \
    && apt-get install -y bzip2

# install python
RUN set -ex \
    && wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz \
    && tar -zxvf Python-3.5.2.tgz \
    && cd ./Python-3.5.2 \
    && ./configure \
    && make \
    && make install

# install miniconda3
RUN set -ex \
    && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/bin/miniconda3


ENV PATH /usr/local/bin/miniconda3/bin:$PATH

# install sudo; mandatory to install nodejs v6.x.x
RUN set -ex \
    && apt-get install -y sudo \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && npm install --global webpack \
    && npm install --global angular-cli

EXPOSE 8000


