# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ddo-carm <ddo-carm@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/01/06 17:05:46 by ddo-carm          #+#    #+#              #
#    Updated: 2026/01/16 17:46:50 by ddo-carm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#		   ________________________________________________        
#  _______|                                               |_______
# \       |                 NAMES & PATHS                 |      /
#  \      |                                               |     /
#  /      |_______________________________________________|     \ 
# /__________)                                        (__________\ 


NAME = inception

DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yaml

DATA_D = $(HOME)/data
MARIADB_D = $(DATA_D)/mariadb
WP_D = $(DATA_D)/wordpress

#          ________________________________________________
# ________|                                               |_______
# \       |                    TARGETS                    |      /
#  \      |                                               |     /
#  /      |_______________________________________________|     \ 
# /__________)                                        (__________\ 

all: up

data:
	mkdir -p $(MARIADB_D) $(WP_D)
	@echo $(BMAG)"Volumes folders were created"$(RES)

build: data
	$(DOCKER_COMPOSE) build
	@echo $(BGRN)"✅Build complete✅"$(RES)

up: build
	$(DOCKER_COMPOSE) up -d
	@echo $(BGRN)"✨Containers Running✨"$(RES)

image:
	docker image ls

stop:
	$(DOCKER_COMPOSE) down
	@echo $(BRED)"Containers are now stopped"$(RES)

ps:
	$(DOCKER_COMPOSE) ps

mariadb:
	docker exec -it mariadb mysql -u root -p
	@echo $(BMAG)"✨MariaDB is now running✨"$(RES)


#          ________________________________________________
# ________|                                               |_______
# \       |                  CLEAN RULES                  |      /
#  \      |                                               |     /
#  /      |_______________________________________________|     \ 
# /__________)                                        (__________\ 

#remove containers
clean:
	$(DOCKER_COMPOSE) down --remove-orphans
	@echo $(BMAG)"✨Containers removed" $(BGRN)"successfully✨"$(RES)

#clean and remove
fclean: clean
	$(DOCKER_COMPOSE) down -v --rmi all --remove-orphans && \
	sudo rm -rf $(HOME)/data/*
	@echo $(BMAG)"✨Images and volumes removed" $(BGRN)"successfully✨"$(RES)

#remake
re: fclean all
	@echo $(BMAG)"✨Re-build was" $(BGRN)"successfull✨"$(RES)

#          ________________________________________________
# ________|                                               |_______
# \       |                  HELP RULES                   |      /
#  \      |                                               |     /
#  /      |_______________________________________________|     \ 
# /__________)                                        (__________\ 

#help
help:
	@echo $(BMAG)"make"$(RES) "	 - start full project"
	@echo $(BMAG)"data"$(RES) " 	 - create volumes"
	@echo $(BMAG)"build"$(RES) " 	 - build containers"
	@echo $(BMAG)"image"$(RES) " 	 - list docker images"
	@echo $(BMAG)"stop"$(RES) "	 - stop all containers"
	@echo $(BMAG)"ps"$(RES) " 	 - show running containers"
	@echo $(BMAG)"mariadb"$(RES) " - open MySQL"

#Phony targets to avoid clashes
.PHONY: all data build up image stop ps mariadb clean fclean re help

#          ________________________________________________
# ________|                                               |_______
# \       |                    COLORS                     |      /
#  \      |                                               |     /
#  /      |_______________________________________________|     \ 
# /__________)                                        (__________\ 

#color list for foreground
#bash -c 'for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done'

RED		= "\033[0;31m"
GRN		= "\033[0;32m"  
YEL		= "\033[0;33m"
BLU		= "\033[0;34m"
BLA		= "\033[0;30m"
CYA		= "\033[0;36m"
GREY	= "\033[0;90m"
BBLA	= "\033[30;1m"
BRED 	= "\033[31;1m"
BGRN	= "\033[32;1m"
BYEL	= "\033[33;1m"
BBLU	= "\033[34;1m"
BMAG	= "\033[35;1m"
BCYA	= "\033[36;1m"
BWHI	= "\033[37;1m"
RES		= "\033[0m"

# Background colors
BGRED	= "\033[41m"
BGGRN	= "\033[42m"
BGYEL	= "\033[43m"
BGBLU	= "\033[44m"
BGMAG	= "\033[45m"
BGCYA	= "\033[46m"
BGWHI	= "\033[47m"
BGBLA	= "\033[40m"

# Bright (bold/high intensity) background colors
BGBRED	= "\033[101m"
BGBGRN	= "\033[102m"
BGBYEL	= "\033[103m"
BGBBLU	= "\033[104m"
BGBMAG	= "\033[105m"
BGBCYA	= "\033[106m"
BGBWHI	= "\033[107m"
