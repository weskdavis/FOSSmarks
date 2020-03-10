FROM php:7-apache

ENV HUGO_VERSION 0.66.0
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

COPY . /tmp/fossmarks-website

RUN hugo -s /tmp/fossmarks-website -d /var/www/html

COPY 000-default.conf /etc/apache2/sites-enabled/

RUN a2enmod rewrite headers expires

CMD apache2-foreground
