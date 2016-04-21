### COMPOSER

# info
FROM php:cli
+ installed `zip` and `git`
+ installed composer globally to `composer` command
+ working as docker's `php` user (see "UID mapping")

# features
+ no additional php dependencies (use composer with `--ignore-platform-reqs`)
+ using Your local SSH key
+ storing composer's cache locally
+ composer works as Your local user (thanks to "UID mapping")

# UID mapping

Docker's composer works as "php" user. After mapping Your local directory with project into docker's `/opt`, entrypoint load UID of `/opt` and replace UID of "php" user to new value. The result is working as Your local user (no "permission denied" errors)

# build

1) Create `Makefile` in Your project

5) Add `composer` rule as following:
```
composer:
	@docker run --rm -it \
     -v ~/.ssh:/home/php/.ssh \
     -v $$(pwd)/:/opt \
     -v ~/.docker-composer/:/home/php/.composer \
     kastinpl/composer composer --ignore-platform-reqs --working-dir=/opt $(cmd)
```

* in 1st command line, before `@docker run ` has to be TAB "\t" char
* set up `/home/php/.ssh` docker's location to use Your local SSH keys
* set up `/opt` docker's location as main project directory (with composer.json)
* set up `/home/php/.composer` docker's location to store composer temporary files
* `--ignore-platform-reqs` allows You to skip php-extensions, not installed in docker

# run

```
make composer cmd=install
make composer cmd=update
make composer cmd=require doctrine/mongodb-odm
```