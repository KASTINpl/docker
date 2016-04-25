SHELL := /bin/bash

########################################

composer:
	@docker run --rm -it \
             -v ~/.ssh/:/home/nodejs/.ssh \
             -v ~/.docker-bower/:/home/nodejs/.bower \
             -v $$(pwd)/:/opt \
             kastinpl/nodejs bower --config.interactive=true -f -q $(cmd)