### nodeJS, bower, grunt

# info
see http://dockerfile.github.io/#/nodejs-bower-grunt

# features
+ using Your local SSH key
+ storing node's cache locally
+ node works as Your local user (thanks to "UID mapping")

# UID mapping

Docker's node works as "nodejs" user. After mapping Your local directory with project into docker's `/opt`, entrypoint load UID of `/opt` and replace UID of "nodejs" user to new value. The result is working as Your local user (no "permission denied" errors)

# build

1) Create `Makefile` in Your project

5) Add `composer` rule as following:
```
bower:
	@docker run --rm -it \
        -v ~/.ssh/:/home/nodejs/.ssh \
        -v ~/.docker-bower/:/home/nodejs/.bower \
        -v $$(pwd)/:/opt \
        kastinpl/nodejs bower --config.interactive=false -f -q $(cmd)
```

* in 1st command line, before `@docker run ` has to be TAB "\t" char
* set up `/home/nodejs/.ssh` docker's location to use Your local SSH keys
* set up `/opt` docker's location as main project directory (with composer.json)
* set up `/home/nodejs/.bower` bower's location to store composer temporary files

# run

```
make bower cmd=install
make bower cmd=update
make bower cmd=require jquery --save
```