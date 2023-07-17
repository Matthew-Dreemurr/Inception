FROM alpine:3.17.4

RUN apk add --no-cache   php81 \
  php81-ctype \
  php81-curl \
  php81-dom \
  php81-fpm \
  php81-gd \
  php81-intl \
  php81-mbstring \
  php81-mysqli \
  php81-opcache \
  php81-openssl \
  php81-phar \
  php81-session \
  php81-xml \
  php81-xmlreader \
  rm -rf /var/cache/apk/*

RUN addgroup -S wordpress && adduser -S wordpress -G wordpress

RUN mkdir /app
WORKDIR /app

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz
RUN tar -zxvf wordpress-6.2.2.tar.gz && mv wordpress/* . && rm -rf wordpress wordpress-6.2.2.tar.gz
RUN chown -R wordpress:wordpress /app && chmod -R 755 /app

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp-cli

ADD tools/php-fpm.conf /etc/php81/
ADD tools/run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]