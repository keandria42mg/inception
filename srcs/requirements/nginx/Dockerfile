FROM debian:bookworm

RUN	apt-get update -y && apt-get install -y nginx openssl

COPY	./conf/nginx.conf	/etc/nginx/conf.d

COPY ./tools/entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log

CMD  ["nginx", "-g", "daemon off;"]
