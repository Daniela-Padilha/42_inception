# This is the base image
FROM debian:bookworm

# Listen on this port
EXPOSE 3306

# Execute this cmd on the terminal
RUN apt update && \
	apt upgrade -y && \
	apt install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Copy a file to the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir /run/mysqld

COPY tools/db-init.sh /bin/
RUN chmod +x /bin/db-init.sh

# When started run this cmd
ENTRYPOINT ["/bin/db-init.sh"]
