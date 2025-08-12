FROM registry.access.redhat.com/ubi8/ubi:latest

LABEL maintainer="labuser@example.com"

EXPOSE 8080

ENV MSG="Containerfile"

RUN yum install -y httpd php-fpm; \
    yum clean all; \
    sed -i 's/^Listen 80 *$/Listen 8080/' /etc/httpd/conf/httpd.conf; \
    sed -i 's/^;clear_env/clear_env/' /etc/php-fpm.d/www.conf; \
    mkdir /run/php-fpm; \
    chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm; \
    chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm

ADD src/* /var/www/html/

USER root

ENTRYPOINT php-fpm & httpd -DFOREGROUND
