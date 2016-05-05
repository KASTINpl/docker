CMD=$(filter-out $@,$(MAKECMDGOALS))

getIP: ; @docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CMD}

bower: ; @docker run --rm -it \
    -v ~/.ssh/:/home/nodejs/.ssh \
    -v ~/.docker-bower/:/home/nodejs/.bower \
    -v $$(pwd)/:/opt \
    kastinpl/nodejs bower ${CMD}

%: ; @: