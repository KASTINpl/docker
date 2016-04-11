### COMPOSER

# build

1) Create `Makefile` in Your project

5) Add `composer` rule as following:
```
composer:
	docker run --rm -it -v $PWD:/opt kastinpl/composer "composer --working-dir=/opt $(cmd)"
```

# run

```
make composer cmd=install
make composer cmd=update
```