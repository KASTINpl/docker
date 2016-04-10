FROM php:7-fpm-alpine

WORKDIR /var/www

RUN apk add --no-cache --virtual .build-deps \
        freetype-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
	icu-dev \
	zlib-dev libmemcached-dev \
	libffi-dev openssl-dev \
	zip 

RUN curl -fsSL 'http://www.imagemagick.org/download/ImageMagick.tar.gz' -o ImageMagick.tar.gz && tar xvzf ImageMagick.tar.gz && \
	 cd ImageMagick-* && ./configure && make && make install && /sbin/ldconfig /usr/local/lib && \
	cd .. && rm -rf ImageMagick.tar.gz ImageMagick-*

RUN docker-php-ext-configure mbstring
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 

RUN docker-php-ext-install gd iconv mcrypt bcmath fileinfo iconv intl zip

RUN pecl install memcache mongodb imagick
RUN docker-php-ext-enable memcache mongodb imagick

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
RUN php composer-setup.php --filename=composer --install-dir=/bin
