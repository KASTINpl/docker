SHELL := /bin/bash

########################################

build:
	@export BACKEND_PORT=$(BACKEND_PORT) && export USER_ID=`id -u` && \
	docker-compose build && \
	docker-compose up -d && \
	docker exec -it goodfood-backend-fpm usermod -u `id -u` www-data && \
	docker exec -it goodfood-backend-nginx usermod -u `id -u` www-data && \
	echo -e "\nAdd to Your /etc/hosts new line: \n" \
	`docker inspect --format '{{ .NetworkSettings.IPAddress }}' goodfood-backend-nginx` \
	"\tbackend.goodfood.local\n"

bower:
	docker run -it --rm -v $$(pwd):/data -v ~/.ssh:/root/.ssh -w /data -u `id -u` --entrypoint \
		bower sebp/ember --config.interactive=false -f -q $(cmd)

composer:
	@docker run --rm -it \
	 -v ~/.ssh:/root/.ssh \
	 -v $$(pwd)/:/opt \
	 -v ~/.docker-composer/:/home/php/.composer
	 kastinpl/composer composer --ignore-platform-reqs --working-dir=/opt $(cmd)

deploy:
	git pull && \
	rm -rf ./cache/* && \
	if [[ "$(type)" == "full" ]]; then \
		make bower cmd=update; \
		make composer cmd=update; \
	fi

encrypt_vault:
	tar -cf vault.tar vault && \
	openssl aes-128-cbc -in vault.tar -out vault.aes -k $(pass)  && \
	rm vault.tar

decrypt_vault:
	openssl aes-128-cbc -d -in vault.aes -out vault.tar -k $(pass) && \
	tar -xf vault.tar && \
	rm vault.tar