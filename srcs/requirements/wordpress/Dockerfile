FROM debian:bookworm

EXPOSE 9000

# Declare local arg
ARG PHPPATH=/etc/php/7.4/fpm

RUN apt update && apt install -y --no-install-recomends \
	ca-certificates \
	php7.4-fpm \
	php7.4-mysql \
	tar \
	wget && \
	rm -rf /var/lib/apt/lists/*

RUN service php7.4-fpm stop


