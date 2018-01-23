FROM php:7.2-fpm-alpine3.7
LABEL maintainer="jeffrey@vandenborne.co"

ARG UID=1000
ARG GID=1000

# Sources: https://github.com/docker-library/wordpress

# docker-entrypoint.sh dependencies
RUN set -xe \
    && apk add --no-cache sed su-exec

# Install PHP extensions
RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
        libjpeg-turbo-dev \
		libpng-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysqli opcache \
    && runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .wordpress-phpexts-rundeps $runDeps \
	&& apk del .build-deps

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN set -xe \
    && { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && sed -E -i 's/www\-data:x:82:82/www-data:x:'$UID':'$GID'/g' /etc/passwd

ENV APP_ROOT="/usr/src/app"
WORKDIR ${APP_ROOT}

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
ENTRYPOINT [ "docker-entrypoint" ]

CMD [ "php-fpm" ]