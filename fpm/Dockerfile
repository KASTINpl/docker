FROM php:5-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
	libicu-dev \
	libz-dev libmemcached-dev \
	libffi-dev libssl-dev \
	zip 

RUN curl -fsSL 'http://www.imagemagick.org/download/ImageMagick.tar.gz' -o ImageMagick.tar.gz && tar xvzf ImageMagick.tar.gz && \
	 cd ImageMagick-* && ./configure && make && make install && /sbin/ldconfig /usr/local/lib && \
	cd .. && rm -rf ImageMagick.tar.gz ImageMagick-*

RUN docker-php-ext-configure mbstring
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 

RUN docker-php-ext-install -j$(nproc) gd iconv mcrypt bcmath fileinfo iconv intl zip

RUN pecl install memcache mongo imagick
RUN docker-php-ext-enable memcache mongo imagick

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
RUN php composer-setup.php --filename=composer --install-dir=/bin

