FROM nginx:stable
MAINTAINER Kastin "kastin@kastin.pl"

WORKDIR /opt

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]