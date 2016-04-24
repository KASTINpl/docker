### PHP-FPM 7.x

# info
FROM php:7-fpm
+ imagemagick installed
+ mbstring, gd + freetype, gd, iconv, mcrypt, bcmath, fileinfo, intl, gettext, zip, mongodb, imagick installed

# features
+ works as Your local user (thanks to "UID mapping")

# UID mapping

Docker's php works as "www-data" user. After mapping Your local directory with project into docker's `/opt`, entrypoint load UID of `/opt` and replace UID of "www-data" user to new value. The result is working as Your local user (no "permission denied" errors)

# build

1) Create `docker-compose.yml` in Your project

7) Add `fpm` rule as following:
```
fpm:
    image: kastinpl/php7-fpm
    container_name: php7-fpm
    environment:
      - TERM=xterm-256color
    volumes:
      - ~/Projects/MY_PROJECT/:/opt
```

* set up `/opt` docker's location as main project directory

# run

```
docker-compose up -d
```