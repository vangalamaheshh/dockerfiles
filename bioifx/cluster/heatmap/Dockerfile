FROM r-base

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

# gcloud sdk installation (gsutil is needed for folder copy)
RUN set -ex \
  && apt-get update -y \
  && apt-get install -y vim \
  && apt-get install -y git \
  && apt-get install -y wget \
  && apt-get install -y gcc g++ make \
  && apt-get install -y bzip2 \
  && apt-get install -y sudo \
  && apt-get install -y curl

RUN set -ex \
  && apt-get install -y python2.7 \
  && apt-get install -y default-jdk 

ENV CLOUD_SDK_REPO "cloud-sdk-xenial"

RUN set -ex \
  && apt-get install -y gnupg2 \
  && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
  sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
  && apt-get update -y && apt-get install -y google-cloud-sdk
#End

RUN set -ex \
  && apt-get update -y \
  && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev git \
  && echo 'install.packages(c("gplots", "circlize", "viridis", "dplyr"), \
    repos="http://cran.us.r-project.org", dependencies=TRUE)\n\
    source("https://bioconductor.org/biocLite.R")\n\
    biocLite(pkgs = c("ComplexHeatmap"), ask = FALSE)' > /usr/local/bin/packages.R \
  && Rscript /usr/local/bin/packages.R 

COPY scripts /usr/local/bin/scripts

