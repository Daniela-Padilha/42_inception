# Developer Documentation

This file describes how a developer can set up the environment from scratch, build and launch the project and use relevant commands to manage the containers and volumes.

## Prerequisites

For this project you will need the following prerequisites installed:

- Docker

- Docker Compose

- Clang

- Make

- Git

## Configuration files & secrets

This project does not use Docker Secrets, so it requires a .env file to provide necessary environment variables.

Setup steps:

1. Navigate to the ```./srcs/``` directory.

2. Create a file named ```.env```.

3. Add the following required variables to the file:

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

> Make sure to replace placeholder values with your own credentials and domain name.

## Build & Launch

This project uses Docker and Docker Compose to build and run all services (WordPress, MariaDB, NGINX). The provided Makefile simplifies the process.

### Using the Makefile

| Command       | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| `make`        | Build all Docker images and create the containers.                         |
| `make up`     | Start the containers and network in the background.                        |
| `make down`   | Stop the containers and remove the network.                                |
| `make clean`  | Remove project containers, networks, and images created by Docker Compose. |
| `make fclean` | Remove everything, including volumes and host data.                        |
| `make re`     | Fully rebuild the project from scratch (`fclean` followed by `make`).      |

Example workflow:

- Build and start the project
```bash
make
```

- Stop the containers
```bash
make down
```

- Start everything again
```bash
make up
```

- Remove containers, images, and volumes
```bash
make fclean
```

- Rebuild the project from scratch
```bash
make re
```

## Relevant Commands

You can interact with and manage the Docker containers, images, networks, and volumes using both the Makefile and Docker CLI commands.

### Using the Makefile

| Command          | Description                                                                |
| ---------------- | -------------------------------------------------------------------------- |
| `make ps`        | List all running containers in the project.                                |
| `make image`     | List all Docker Images.                                                    |
| `make clean`     | Remove project containers, networks, and images created by Docker Compose. |
| `make fclean`    | Remove everything, including volumes and host data.                        |
| `make re`        | Rebuild the project from scratch.                                          |

### Using Docker CLI

| Command                                   | Description                                  |
| ----------------------------------------- | -------------------------------------------- |
| `docker ps`                               | List currently running containers.           |
| `docker ps -a`                            | List all containers, including stopped ones. |
| `docker stop <container_name>`            | Stop a running container.                    |
| `docker start <container_name>`           | Start a stopped container.                   |
| `docker rm <container_name>`              | Remove a container.                          |
| `docker images`                           | List all Docker images.                      |
| `docker rmi <image_name>`                 | Remove a Docker image.                       |
| `docker volume ls`                        | List all Docker volumes.                     |
| `docker volume rm <volume_name>`          | Remove a Docker volume.                      |
| `docker network ls`                       | List Docker networks.                        |
| `docker network prune`                    | Remove unused networks.                      |
| `docker compose down -v`                  | Remove all containers and volumes.           |
| `docker exec -it <container_name> bash`   | Access container shell.                      |


## Project Data

The project stores persistent data on the host machine in the following directories:

- WordPress files:

```bash
/home/<your_user>/data/wordpress
```

- MariaDB database: 

```bash
/home/<your_user>/data/mariadb
```

> Replace <your_user> with your username (run ```whoami``` in the terminal).

### How data persists

The data persists because these directories are mounted as Docker volumes in the containers.

- For WordPress: the container’s /var/www/html directory is mapped to /home/<your_user>/data/wordpress

- For MariaDB: the container’s /var/lib/mysql directory is mapped to /home/<your_user>/data/mariadb

This means:

- Any changes made inside the container (new WordPress posts, database updates) are written to the host filesystem

- Even if you stop or remove the containers, the data remains on your host
 
- When you restart or rebuild the containers, they automatically use the same data