# User Documentation

This guide explains how to use and manage the Inception project, including WordPress, MariaDB, and NGINX services.

## Services provided

The stack includes the following services:

| Service       | Description                                | Port                                                   |
| ------------- | ------------------------------------------ | ------------------------------------------------------ |
| **WordPress** | Hosts the website and administration panel | Internal container port 9000                           |
| **MariaDB**   | Database service for WordPress             | Internal container port 3306                           |
| **NGINX**     | Web server reverse proxy                   | Internal container port 9000 (forwarded to 443 on host)|

> WordPress communicates with MariaDB through the internal Docker network. NGINX serves the WordPress site.

## Start and Stop the Project

The project can be managed using the Makefile or Docker Compose commands.

### Using Makefile:

- Start and build the project

```bash
make
```

- Stop containers and network

```bash
make down
```

- Rebuild the project from scratch

```bash
make re
```

### Using Docker Compose directly:

- Start

```bash
docker compose -f srcs/docker-compose.yaml up -d
```

- Stop

```bash
docker compose -f srcs/docker-compose.yaml down
```

> The Makefile is recommended for simplicity.

## Access website and administration panel

1. Website URL: http://<your_user>.42.fr (replace <your_user> with your username)

2. WordPress Admin Panel: http://<your_user>.42.fr/wp-admin

3. Log in using credentials defined in your .env file.

## Credentials

All credentials are stored in the .env file in the ```./srcs/``` directory:

| Variable            | Description                                                 |
| ------------------- | ------------------------------------------------------------|
| `SQL_DATABASE`      | Name of the MariaDB database.                               |
| `SQL_USER`          | MariaDB user.                                               |
| `SQL_PASSWORD`      | MariaDB user password.                                      |
| `SQL_ROOT_PASSWORD` | MariaDB root password.                                      |
| `WP_ADMIN_USER`     | WordPress admin username.                                   |
| `WP_ADMIN_PASSWORD` | WordPress admin password.                                   |
| `WP_USER`           | WordPress regular user.                                     |
| `WP_PASSWORD`       | WordPress regular user password.                            |
| `DOMAIN_NAME`       | Domain for WordPress (e.g., <your_user>.42.fr).             |

> Update this file to change usernames, passwords, or domain name.

## Check services

1. check all running containers:

- Using Makefile: ```make ps```

- Using Docker CLI: ```docker ps```

2. Verify that the output shows something similar to:

```bash
nginx       Up
wordpress   Up
mariadb     Up
```

3. Check logs for a container:

```bash
docker logs <name>
```

4. Access conatiner shell:

```bash
docker exec -it <container> bash
```

- Verify WordPress is reachable in the browser.

- Check MariaDB container logs for errors.

- Ensure the NGINX container is serving pages.
