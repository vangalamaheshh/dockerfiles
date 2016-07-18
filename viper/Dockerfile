FROM rocker/rstudio:latest

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
    && mkdir -p /mnt/viper_root \
    && mkdir -p /mnt/software \


WORKDIR /mnt/software

RUN set -ex \
    && wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz \
    && tar -zxvf Python-3.5.2.tgz \
    && cd ./Python-3.5.2 \
    && ./configure \
    && make \
    && make install

RUN set -ex \
    && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /mnt/software/miniconda3

ENV PATH /mnt/software/miniconda3/bin:$PATH

RUN set -ex \
    && cd /mnt/viper_root \
    && git clone https://bitbucket.org/cfce/viper.git

RUN set -ex \
    && conda env update -n root -f /mnt/viper_root/viper/environment.yml \
    && conda env create -f /mnt/viper_root/viper/python2_environment.yml

RUN set -ex \
    && echo 'rsession-which-r=/mnt/software/miniconda3/bin/R' >>/etc/rstudio/rserver.conf

