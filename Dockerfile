# base this image on the PHP image that comes with Apache https://hub.docker.com/_/php/
FROM php:8.0-apache

# install mysql-client and curl for our data init script
# install the PHP extension pdo_mysql for our connection script
# clean up
RUN apt-get update \
  && apt-get install -y default-mysql-client \
  && docker-php-ext-install pdo_mysql \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives

# take the contents of the local html/ folder, and mount to /var/www/html/ inside the container
# this is the expected web root of the default website for this server, so put your index.php here
COPY web /var/www/html/
COPY docker-config.inc.php /var/www/html/config.inc.php
