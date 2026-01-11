# This is the base image
FROM debian:bookworm

# Listen on this port
EXPOSE 3306

# Execute this cmd on the terminal
RUN apt update && apt install -y --no-install-recomends \
	mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Copy a file to the container
COPY conf/50-server.cnf etc/mysql/mariadb.conf.d/

COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

# When started run this cmd
CMD ["setup.sh", "mysql_safe"]