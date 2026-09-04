FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        apache2 \
        php \
        php-mysql \
        php-curl \
        php-gd \
        php-mbstring \
        php-xml \
        php-zip \
        php-intl \
        php-bcmath \
        php-soap \
        libapache2-mod-php \
        ca-certificates \
    && a2enmod rewrite headers setenvif \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

COPY xforwardedproto.conf /etc/apache2/conf-available/xforwardedproto.conf
RUN a2enconf xforwardedproto

COPY short-open-tag.ini /etc/php/8.1/apache2/conf.d/99-short-open-tag.ini
COPY short-open-tag.ini /etc/php/8.1/cli/conf.d/99-short-open-tag.ini

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
