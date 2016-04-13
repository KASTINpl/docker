FROM php:5-cli

# install
RUN apt-get update && apt-get -y install sudo zip git

# cleanup
RUN apt-get -y clean && apt-get -y purge && rm -rf /var/lib/apt/lists/*

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --filename=composer --install-dir=/bin && \
    rm -f composer-setup.php

RUN adduser --disabled-password --home /home/php php
RUN ls -lahtr /home/php
VOLUME /home/php

WORKDIR /opt

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]