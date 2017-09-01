FROM mvangala/base-ubuntu:latest 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && apt-get update -y \
  && apt-get install -y picard-tools

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA /usr/lib/jvm/java-8-openjdk-amd64/bin
