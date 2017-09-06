FROM mvangala/base-conda:latest

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

WORKDIR /usr/local/bin/mamba

RUN set -ex \
  && apt-get install -y libjemalloc-dev libxrender-dev \
  && git clone https://github.com/dst-umms/MAMBA.git

RUN set -ex \
  && conda env create -f MAMBA/envs/MAMBA.env.yaml \
  && conda env create -f MAMBA/envs/MAMBA_PY2.env.yaml \
  && conda env create -f MAMBA/envs/MAMBA_R.env.yaml 

