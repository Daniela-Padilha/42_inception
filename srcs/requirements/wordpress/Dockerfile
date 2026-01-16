FROM debian:bookworm

EXPOSE 9000

RUN apt update && \
	apt upgrade -y && \
	apt install -y --no-install-recomends \
	php8.2-fpm \
	php8.2-mysqli \
	curl \
	mariadb-client \
	rm -rf /var/lib/apt/lists/*

#Change owner to run socket
RUN mkdir -p /run/php && \
	chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY tools/wp-init.sh /bin/

RUN chmod +x /bin/wp-init.sh

ENTRYPOINT ["/bin/wp-init.sh"]


