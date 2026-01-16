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

## Build & Launch

## Relevant Commands

## Project Data

The project stores persistent data on the host machine in the following directories:

- WordPress files:

```/home/<your_user>/data/wordpress```

- MariaDB database: 

```/home/<your_user>/data/mariadb```

Replace <your_user> with your username (run ```whoami``` in the terminal).

### How data persists

The data persists because these directories are mounted as Docker volumes in the containers.

- For WordPress: the container’s /var/www/html directory is mapped to /home/<your_user>/data/wordpress

- For MariaDB: the container’s /var/lib/mysql directory is mapped to /home/<your_user>/data/mariadb

This means:

- Any changes made inside the container (new WordPress posts, database updates) are written to the host filesystem

- Even if you stop or remove the containers, the data remains on your host
 
- When you restart or rebuild the containers, they automatically use the same data