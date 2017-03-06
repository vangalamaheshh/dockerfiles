FROM r-base

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

RUN set -ex \
  && apt-get update -y \
  && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev git \
  && echo 'install.packages(c("argparse", "devtools", "ggrepel"), \
    repos="http://cran.us.r-project.org", dependencies=TRUE)' > /usr/local/bin/packages.R \
  && Rscript /usr/local/bin/packages.R \
  && Rscript -e 'require(devtools); install_github("vangalamaheshh/ggbiplot");'

COPY scripts /usr/local/bin/scripts

