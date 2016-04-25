FROM dockerfile/nodejs-bower-grunt

# create local user to map in as UID of /opt
RUN adduser --disabled-password --home /home/nodejs nodejs

# storing composer cache locally instead of docker
VOLUME /home/nodejs

WORKDIR /opt

# run php user as local
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]