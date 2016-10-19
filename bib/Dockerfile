FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
    && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

# apt update and install vim, git, wget, gcc, g++, make, bzip2, sudo, curl
RUN set -ex \
    && apt-get update -y \
    && apt-get install -y vim \
    && apt-get install -y git \
    && apt-get install -y wget \
    && apt-get install -y gcc g++ make \
    && apt-get install -y bzip2 \
    && apt-get install -y sudo \
    && apt-get install -y curl

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

# install python2.7 (installed in /usr/bin/), java 1.7+ (required for google cloud SDK)
RUN set -ex \
    && apt-get install -y python2.7 \ 
    && apt-get install -y default-jdk 

# install google cloud sdk
ENV CLOUD_SDK_REPO "cloud-sdk-$(lsb_release -c -s)"

RUN set -ex \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
    sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && apt-get update && apt-get install google-cloud-sdk

# install sudo (installed above); mandatory to install nodejs v6.x.x
RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && npm install --global webpack \
    && npm install --global angular-cli

EXPOSE 8000


