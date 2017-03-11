FROM r-base

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

RUN set -ex \
  && apt-get update -y \
  && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev libproj-dev git \
  && echo 'install.packages(c("ggplot2", "stringr", "proj4", "ggalt"), \
    repos="http://cran.us.r-project.org", dependencies=TRUE)\n\
    source("https://bioconductor.org/biocLite.R")\n\
    biocLite(pkgs = c("AnnotationDbi", "org.Hs.eg.db", "org.Mm.eg.db", "GOstats", "edgeR", \
    "multtest", "mutoss"), ask = FALSE)' > /usr/local/bin/packages.R \
  && Rscript /usr/local/bin/packages.R 

COPY scripts /usr/local/bin/scripts

