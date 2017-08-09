FROM php:5.6-apache

MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

WORKDIR /var/www/html

RUN set -ex \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y git php5-curl \
  && git clone http://github.com/i2b2/i2b2-webclient.git admin

# web-server installation
COPY i2b2_config_data.admin.js /var/www/html/admin/i2b2_config_data.js
COPY i2b2_loader.admin.js /var/www/html/admin/js-i2b2/i2b2_loader.js
COPY index.admin.php /var/www/html/admin/index.php


# web-client installation
RUN set -ex \
  && git clone http://github.com/i2b2/i2b2-webclient.git webclient

COPY i2b2_config_data.client.js /var/www/html/webclient/i2b2_config_data.js
COPY index.client.php /var/www/html/webclient/index.php


EXPOSE 80

CMD ["apache2-foreground"]
