CMD=$(filter-out $@,$(MAKECMDGOALS))

getIP: ; @docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CMD}

bower: ; @docker run --rm -it \
    -v ~/.ssh/:/home/nodejs/.ssh \
    -v ~/.docker-bower/:/home/nodejs/.bower \
    -v $$(pwd)/:/opt \
    kastinpl/nodejs bower ${CMD}

composer: ; @docker run --rm -it \
    -v ~/.ssh:/home/php/.ssh \
    -v $$(pwd)/:/opt \
    -v ~/.docker-composer/:/home/php/.composer \
    kastinpl/composer composer --ignore-platform-reqs --working-dir=/opt ${CMD}

%: ; @: