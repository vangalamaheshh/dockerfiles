FROM r-base

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

COPY scripts /usr/local/bin/scripts

RUN set -ex \
  && echo 'install.packages(c("ggplot2", "reshape2", "scales"), \
    repos="http://cran.us.r-project.org", dependencies=TRUE)' > /usr/local/bin/packages.R \
  && Rscript /usr/local/bin/packages.R
