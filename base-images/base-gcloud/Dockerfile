FROM ubuntu:16.04

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

# install python2.7 (installed in /usr/bin/), java 1.7+ (required for google cloud SDK)
RUN set -ex \
  && apt-get update -y \
  && apt-get install -y sudo \
  && apt-get install -y curl \
  && apt-get install -y python2.7 \
  && apt-get install -y default-jdk

# install google cloud sdk
ENV CLOUD_SDK_REPO "cloud-sdk-xenial"

RUN set -ex \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
    sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && apt-get update -y && apt-get install -y google-cloud-sdk
