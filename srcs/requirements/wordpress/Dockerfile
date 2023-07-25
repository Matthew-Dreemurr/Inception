FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
  wget \
  php7.4-fpm \
  php7.4 \
  php7.4-mysql \
  php7.4-fpm \
  php7.4-curl \
  php7.4-gd \
  php7.4-intl \
  php7.4-mbstring \
  php7.4-soap \
  php7.4-xml \
  php7.4-xmlrpc \
  php7.4-zip \
  mariadb-server \
  mariadb-client \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

RUN groupadd wordpress && useradd -g wordpress wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /bin/wp

ADD tools/run.sh /
RUN chmod +x /run.sh

COPY tools/php-fpm.conf /etc/php/7.4/fpm/
RUN ln -s $(which php-fpm7.4) /bin/php-fpm \
  && mkdir -p /run/php/ \
  && chown -R wordpress:wordpress /run/php/ \
  && mkdir -p /usr/logs/php-fpm \
  && chown -R wordpress:wordpress /usr/logs/php-fpm \
  && chmod -R 755 /usr/logs/php-fpm

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz \
  && tar -zxvf wordpress-6.2.2.tar.gz \
  && mv wordpress/* . \
  && rm -rf wordpress wordpress-6.2.2.tar.gz \
  && chown -R wordpress:wordpress /app \
  && chmod -R 755 /app

USER wordpress:wordpress
ENTRYPOINT ["/run.sh"]