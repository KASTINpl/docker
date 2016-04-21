SHELL := /bin/bash

########################################

getIP:
	@docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(name)

bower:
	@docker run -it --rm -v $$(pwd):/data -v ~/.ssh:/root/.ssh -w /data -u `id -u` --entrypoint \
		bower sebp/ember --config.interactive=false -f -q $(cmd)

composer:
	@docker run --rm -it \
	 -v ~/.ssh:/root/.ssh \
	 -v $$(pwd)/:/opt \
	 -v ~/.docker-composer/:/home/php/.composer
	 kastinpl/composer composer --ignore-platform-reqs --working-dir=/opt $(cmd)