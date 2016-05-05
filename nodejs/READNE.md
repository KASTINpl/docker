### nodeJS, bower, grunt

# info
see
http://dockerfile.github.io/#/nodejs-bower-grunt
https://hub.docker.com/r/digitallyseamless/nodejs-bower-grunt/

# features
+ using Your local SSH key
+ storing node's cache locally
+ node works as Your local user (thanks to "UID mapping")

# UID mapping

Docker's node works as "nodejs" user. After mapping Your local directory with project into docker's `/opt`, entrypoint load UID of `/opt` and replace UID of "nodejs" user to new value. The result is working as Your local user (no "permission denied" errors)

# build

* Create `Makefile` in Your project
```
CMD=$(filter-out $@,$(MAKECMDGOALS))

getIP: ; @docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CMD}

bower: ; @docker run --rm -it \
    -v ~/.ssh/:/home/nodejs/.ssh \
    -v ~/.docker-bower/:/home/nodejs/.bower \
    -v $$(pwd)/:/opt \
    kastinpl/nodejs bower ${CMD}

%: ; @:
```

* in 1st command line, before `@docker run ` has to be TAB "\t" char
* set up `/home/nodejs/.ssh` docker's location to use Your local SSH keys
* set up `/opt` docker's location as main project directory (with composer.json)
* set up `/home/nodejs/.bower` bower's location to store composer temporary files

# run

```
make bower update
make bower install jquery --save
```