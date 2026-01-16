<i>This project has been created as part of the 42 curriculum by ddo-carm </i>

# Inception

## Description

This project aims to expand knowledge in system administration through the use of Docker and Docker Compose.

The goal is to virtualize multiple services by creating Docker images in a personal virtual machine, and to deploy a small web server running NGINX, hosting a WordPress website connected to a MariaDB database.

## Instructions

1. Install

```bash
git clone https://github.com/Daniela-Padilha/42_inception.git && cd 42_inception
```

2. Compile and execute

```bash
make
```

## Project description

### What is Docker?

Docker is a tool that works as an alternative to virtual machines. It allows us to create containers, which are small isolated environments where applications can run. Each container has everything it needs to work properly, so the app behaves the same on any computer.

A container is like a very fast, lightweight micro-computer. It has its own operating system, CPU, memory, and network. Most importantly, containers are isolated from each other and from the host machine’s operating system, which makes them more secure and prevents conflicts between applications.

Each container also includes the settings, prerequisites, dependencies, and services defined by the user. This means you don’t need to install everything manually on your computer.

One big advantage of Docker is portability, if something works on your machine, it will also work on someone else’s. This makes it very useful for developers who want to share projects or deploy applications easily.

<hr>

### What is Dockerfile?

A Dockerfile is a text file that contains the instructions for building a Docker image. It specifies the base image to use, the dependencies and software to install, and any other configurations or scripts that are needed to set up the environment for the application to run. Using the Dockerfile we can use the command ```docker build``` to build the docker image.

<hr>

### What is Docker Image?

A Docker image is an executable file used to create and run containers. It contains everything the container needs to work properly, such as libraries, dependencies, configurations, and application files.

Docker images are immutable, which means they cannot be changed once they are created. If you need to make changes, you must create a new image or add another layer on top of the existing one.

Container images are built using layers. Each layer represents changes made to the file system, such as adding, removing, or modifying files. This layered structure makes images efficient and easy to update.

We can use the command ```docker run``` to run the image as a container.

<hr>

### What is Docker Compose?

A best practice when using containers is that each container should do one thing and do it well. However, many applications need multiple services to work together. This raises some questions. Should everything be installed in a single container? Or should we run multiple containers? And if we use multiple containers, how do we connect them?

You can start several containers using multiple docker run commands. But this quickly becomes complicated. You need to manage networks, add many flags to connect containers, and remember all the commands. Cleaning everything up later can also be messy.

Docker Compose solves this problem. It is a declarative tool that lets you define all your containers and their configurations in one single file, called a YAML file. With one command, you can start, stop, and manage all your services easily.

<hr>


### What is a Daemon?

A daemon is a computer program that runs as a background process, independently of direct user interaction. It performs tasks without requiring manual input, often listening for requests or events and responding as needed.

The Docker Daemon (dockerd) is the core background service running on the host operating system. It is responsible for managing all Docker operations, including creating, running, and stopping containers, handling images, managing networks, and maintaining volumes. Essentially, the Docker Daemon is the “brain” of the Docker ecosystem, coordinating all container activities.

Daemons can also communicate with each other or with clients (like the Docker CLI or API) to manage Docker services across multiple hosts, enabling complex setups such as multi-container applications and orchestration.

<hr>

### Design choices

For this project, I chose the penultimate stable version of Debian, Bookworm. I opted for Debian over Alpine because of its stability, predictability, and extensive package repository accessible via apt. Additionally, Debian comes with many pre-installed packages, which reduces the time spent installing dependencies. My prior experience with Debian also made it a more comfortable choice.

While Alpine is popular for containers due to its small image size, fast download/build times, and security features, I felt that Debian was better suited for this project, providing a more familiar and convenient development environment.

<hr>

### Virtual Machines vs Docker

Virtual machines allow us to divide a physical machine’s resources (CPU, memory, storage, etc.) and assign each portion to a different operating system. This means we can run several “virtual computers,” each with its own OS, inside a single physical machine. This removes the need to buy separate hardware for each operating system. This process is called virtualization.

With Docker, instead of virtualizing the hardware, we virtualize the operating system. This means we only have one OS installed on the physical machine, and multiple containers running on top of it. Each container works in a similar way to a virtual machine, but in a lighter and faster way.

In summary, both Virtual Machines and Docker are used for the same purpose: running multiple environments on one machine. However, Docker is much easier and faster to deploy, more lightweight, and more portable between systems.

One important difference is that each virtual machine has its own kernel, while Docker containers share the kernel of the host machine. This sharing makes Docker much faster and more efficient.

This also brings a limitation:

- Windows containers can only run on Windows systems

- Linux containers can only run on Linux systems

This happens because containers depend on the host machine’s kernel.

Visual Representation:

```text

Virtual Machine:                                   Docker:

VMs: W, U, C, D                                    Containers: U, C, D
 ___   ___   ___   ___                                 ___   ___   ___ 
|   | |   | |   | |   |                               |   | |   | |   |
| W | | U | | C | | D |                               | U | | C | | D |
|___| |___| |___| |___|                               |___| |___| |___|
                                                
  🡹     🡹    🡹     🡹                               🡹     🡹     🡹   
 _____________________                              _____________________
|       Virtual       |                            |       Ubuntu +      |
|   Machine Software  |                            |    Docker Engine    |
|_____________________|                            |_____________________|
                                                          
           🡱                                                  🡱
 _____________________                              _____________________
|                     |                            |                     |
|       Hardware      |                            |       Hardware      |
|_____________________|                            |_____________________|

```                          

Each letter represents an operating system:

w - Windows

U - Ubuntu

C - Centos

D - Debian

<hr>

### Secrets vs Environment Variables

Environment Variables are key-value pairs passed to a container at runtime. They are usually used to configure the container and are easy to set up. They work well for simple, non-sensitive configuration, such as database host or port. However, they are not secure, anyone with access to the container can see them, and they may appear in logs or command history.

Docker Secrets, on the other hand, provide a more secure way to store sensitive information, such as passwords or admin keys. Secrets are encrypted and only accessible to containers that are explicitly granted access. They are slightly more complex to set up but are recommended for sensitive data in production.

<hr>

### Docker Network vs Host Network

Docker Network (also called a bridge network) is created and used by default. Containers connected to this network get their own internal IP addresses, allowing multiple containers to communicate with each other safely. These IPs are isolated from the host network, which makes the setup more secure.

Host Network means the container uses the host machine’s network directly, without IP isolation. The container shares the same IP addresses as the host. This can provide slightly better network performance, but it is less secure because the container is not isolated from the host.

<hr>

### Docker Volumes vs Bind Mounts

Docker provides different ways to store and persist data created or used by containers.

Bind mounts have been part of Docker from the early versions. They allow you to link a file or directory from your host machine directly into a container using its absolute path. Any changes made on the host are immediately visible inside the container. Some downsides of bind mounts are: containers using bind mounts are tied to the host's directory structure, which can make them less portable, and processes in the container can modify or delete crucial host files if not restricted.

Docker volumes, on the other hand, are fully managed by Docker and do not depend on the host filesystem. Volumes are still on the host machine, but Docker decides where. Data in volumes persists across container restarts, and volumes can be managed using the Docker CLI or API.

Volumes are generally recommended over bind mounts because they are more portable, safer, and make it easier to share data between multiple containers. Compared to volumes, bind mounts are less isolated and less suitable for production environments.

<hr>

## Resources

References used in this project:

Intro to Dockers: https://www.youtube.com/watch?v=eGz9DS-aIeY

Docker Documentation: https://docs.docker.com/get-started/get-docker/

How to install Docker: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

Dockerfile Best Practices: https://docs.docker.com/build/building/best-practices/

<hr>

### AI Usage

AI was used to help better understand the concepts covered in this project and to improve the project documentation.
