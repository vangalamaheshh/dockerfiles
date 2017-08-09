FROM php:5.6-apache

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

WORKDIR /var/www/html

RUN set -ex \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y git php5-curl \
  && git clone http://github.com/i2b2/i2b2-webclient.git admin

COPY i2b2_config_data.js /var/www/html/admin/i2b2_config_data.js
COPY i2b2_loader.js /var/www/html/admin/js-i2b2/i2b2_loader.js

EXPOSE 80

CMD ["apache2-foreground"]
