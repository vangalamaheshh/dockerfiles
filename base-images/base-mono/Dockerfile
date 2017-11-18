FROM ubuntu:16.04 

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN set -ex \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get update -y \
  && apt-get install -y mono-complete

RUN set -ex \
  && apt-get install -y vim
