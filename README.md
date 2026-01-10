<i>This project has been created as part of the 42 curriculum by ddo-carm </i>

# Inception

## Description

This project aims to broaden the knowledge of system administration by using Docker and Docker-Compose.

The goal was to virtualize several Docker images, creating them in a new personal virtual machine, to deploy a small web server that use the NGINX server with a Wordpress website and a MariaDB database.

## Instructions

1. Install

```git clone https://github.com/Daniela-Padilha/42_inception.git && cd 42_inception```

2. Compile and execute

```make```

## Project description

### What is Docker?

Docker is a tool that works as an alternative to virtual machines. It allows us to create containers, which are small isolated environments where applications can run. Each container has everything it needs to work properly, so the app behaves the same on any computer.

A container is like a very fast, lightweight micro-computer. It has its own operating system, CPU, memory, and network. Most importantly, containers are isolated from each other and from the host machine’s operating system, which makes them more secure and prevents conflicts between applications.

Each container also includes the settings, prerequisites, dependencies, and services defined by the user. This means you don’t need to install everything manually on your computer.

One big advantage of Docker is portability, if something works on your machine, it will also work on someone else’s. This makes it very useful for developers who want to share projects or deploy applications easily.

### What is Docker Image?

A Docker image is an executable file used to create and run containers. It contains everything the container needs to work properly, such as libraries, dependencies, configurations, and application files.

Docker images are immutable, which means they cannot be changed once they are created. If you need to make changes, you must create a new image or add another layer on top of the existing one.

Container images are built using layers. Each layer represents changes made to the file system, such as adding, removing, or modifying files. This layered structure makes images efficient and easy to update.

### What is Docker Compose?

A best practice when using containers is that each container should do one thing and do it well. However, many applications need multiple services to work together. This raises some questions. Should everything be installed in a single container? Or should we run multiple containers? And if we use multiple containers, how do we connect them?

You can start several containers using multiple docker run commands. But this quickly becomes complicated. You need to manage networks, add many flags to connect containers, and remember all the commands. Cleaning everything up later can also be messy.

Docker Compose solves this problem. It is a declarative tool that lets you define all your containers and their configurations in one single file, called a YAML file. With one command, you can start, stop, and manage all your services easily.

### Design choices

### Virtual Machines vs Docker

Virtual machines allow us to divide a physical machine’s resources (CPU, memory, storage, etc.) and assign each portion to a different operating system. This means we can run several “virtual computers,” each with its own OS, inside a single physical machine. This removes the need to buy separate hardware for each operating system. This process is called virtualization.

With Docker, instead of virtualizing the hardware, we virtualize the operating system. This means we only have one OS installed on the physical machine, and multiple containers running on top of it. Each container works in a similar way to a virtual machine, but in a lighter and faster way.

In summary, both Virtual Machines and Docker are used for the same purpose: running multiple environments on one machine. However, Docker is much easier and faster to deploy, more lightweight, and more portable between systems.

One important difference is that each virtual machine has its own kernel, while Docker containers share the kernel of the host machine. This sharing makes Docker much faster and more efficient.

This also brings a limitation:

- Windows containers can only run on Windows systems

- Linux containers can only run on Linux systems

This happens because containers depend on the host machine’s kernel.


Virtual Machine:                                   Docker:

VMs: W, U, C, D                                    Containers: U, C, D
 ___   ___   ___   ___                                 ___   ___   ___ 
|   | |   | |   | |   |                               |   | |   | |   |
| W | | U | | C | | D |                               | U | | C | | D |
|___| |___| |___| |___|                               |___| |___| |___|
                                                
  🡹     🡹    🡹     🡹                                   🡹     🡹     🡹   
 _____________________                              _____________________
|       Virtual       |                            |       Ubuntu +      |
|   Machine Software  |                            |    Docker Engine    |
|_____________________|                            |_____________________|
                                                          
           🡱                                                  🡱
 _____________________                              _____________________
|                     |                            |                     |
|       Hardware      |                            |       Hardware      |
|_____________________|                            |_____________________|

Each letter represents an operating system:
w - Windows
U - Ubuntu
C - Centos
D - Debian

### Secrets vs Environment Variables

### Docker Network vs Host Network

### Docker Volumes vs Bind Mounts


## Resources

References used in this project:

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

https://docs.docker.com/get-started/get-docker/

https://www.youtube.com/watch?v=eGz9DS-aIeY

### AI Usage

AI was used to help better understand the concepts covered in this project and to improve the project documentation.