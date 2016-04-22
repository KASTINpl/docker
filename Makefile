SHELL := /bin/bash

########################################

composer:
	@docker run --rm -it \
             -v ~/.ssh/:/home/php/.ssh \
             -v ~/.docker-composer/:/home/php/.composer \
             -v $$(pwd)/:/opt \
             kastinpl/composer composer --ignore-platform-reqs --working-dir=/opt $(cmd)