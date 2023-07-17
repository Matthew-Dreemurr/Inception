FROM alpine:3.17.4

RUN apk add --no-cache nginx

RUN adduser -D -g www www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

RUN nginx -t

ENTRYPOINT ["nginx", "-g", "daemon off;"]