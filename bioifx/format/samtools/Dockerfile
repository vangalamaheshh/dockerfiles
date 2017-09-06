FROM mvangala/base-conda:latest 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && conda install -c bioconda htslib \
  && conda install -c bioconda samtools

WORKDIR /mnt/data
