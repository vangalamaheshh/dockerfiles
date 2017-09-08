FROM docker.io/mvangala/base-conda:latest 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

# install python2.7 (installed in /usr/bin/), java 1.7+ (required for google cloud SDK)
# and maven (required for dockerflow)
RUN set -ex \
    && apt-get install -y python2.7 \ 
    && apt-get install -y default-jdk \
    && apt-get install -y maven 

# install google cloud sdk
ENV CLOUD_SDK_REPO "cloud-sdk-xenial"

RUN set -ex \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
    sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && apt-get update -y && apt-get install -y google-cloud-sdk

# install dockerflow
WORKDIR /usr/local/bin
RUN set -ex \
    && git clone https://github.com/googlegenomics/dockerflow \
    && cd dockerflow \
    && mvn package -DskipTests 
    
ENV DOCKERFLOW_HOME /usr/local/bin/dockerflow
ENV PATH "${PATH}:${DOCKERFLOW_HOME}/bin"
RUN set -ex && chmod +x /usr/local/bin/dockerflow/bin/*

# install sudo (installed above); mandatory to install nodejs v6.x.x
RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && npm install --global webpack \
    && npm install --global @angular/cli@1.1.0

# BiB app uses python flask and nodejs express servers
# install flask
RUN set -ex \
    && echo y | conda install flask
ENV LC_ALL "C.UTF-8"
ENV LANG "C.UTF-8"

# clone bib git repo
RUN set -ex \
    && git clone https://github.com/vangalamaheshh/bib.git

WORKDIR /usr/local/bin/bib

# Run npm install client dependencies
RUN set -ex \
    && npm install

WORKDIR /usr/local/bin/bib/server/express

# Run npm install server (express) dependencies
RUN set -ex \
    && npm install

ENV FLASK_APP /usr/local/bin/bib/server/flask/server.py

EXPOSE 8000 7999 7998 

WORKDIR /usr/local/bin/bib
RUN set -ex \
    && apt-get update \
    && git pull 
CMD ["/bin/bash", "./run_servers.bash"]

