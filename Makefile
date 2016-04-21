SHELL := /bin/bash

########################################

composer:
	@docker run --rm -it \
     -v ~/.ssh:/home/php/.ssh \
     -v $$(pwd)/:/opt \
     -v ~/.docker-composer/:/home/php/.composer \
     kastinpl/composer composer --ignore-platform-reqs --working-dir=/opt $(cmd)