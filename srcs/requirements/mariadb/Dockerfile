# This is the base image
FROM debian:bookworm

# Listen on this port
EXPOSE 3306

# Execute this cmd on the terminal
RUN apt update && \
	apt upgrade -y && \
	apt install -y --no-install-recommends mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Copy a file to the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir /run/mysqld

COPY tools/init.sh /bin/
RUN chmod +x /bin/init.sh

# When started run this cmd
ENTRYPOINT ["/bin/init.sh"]