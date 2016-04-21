### Nginx stable

# info
FROM nginx:stable

# features
+ works as Your local user (thanks to "UID mapping")

# UID mapping

Docker's nginx works as "www-data" user. After mapping Your local directory with project into docker's `/opt`, entrypoint load UID of `/opt` and replace UID of "www-data" user to new value. The result is working as Your local user (no "permission denied" errors)

# build

1) Create `docker-compose.yml` in Your project

5) Add `nginx` rule as following:
```
nginx:
    image: kastinpl/nginx
    container_name: nginx
    environment:
      - TERM=xterm-256color
    volumes:
      - ~/Projects/PROJECT-NAME/docker/demo.conf:/etc/nginx/conf.d/default.conf
      - ~/Projects/PROJECT-NAME/:/opt
    links:
      - fpm
```

* set up `/opt` docker's location as main project directory
* set up `/etc/nginx/conf.d/default.conf` docker's file as Your host configuration (see below)
* link `fpm` to Your php fpm service (see https://hub.docker.com/r/kastinpl/php56-fpm/)
* configure host configuration (see below)

# run

```
docker-compose up -d
```

# host configuration
```
server {
    listen       80;
    server_name  localhost;
    root   /opt;
    index  index.php;

    location / {

    }

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;

        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }

        include /etc/nginx/fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass php56-fpm:9000;
        fastcgi_index index.php;
    }
}
```

* replace `fastcgi_pass php56-fpm:9000;` "php56-fpm" to Your php's docker name with correct port
* insert Your rules into "server" section
* example of wordpress rules
```
    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location / {
        try_files $uri $uri/ /index.php?$args;
    }
    
    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max;
        log_not_found off;
    }
```