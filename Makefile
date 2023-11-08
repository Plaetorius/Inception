all: build up

build:
	mkdir -p /home/tgernez/data/mariadb
	mkdir -p /home/tgernez/data/wordpress
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	@sudo rm -rf /home/tgernez/data/mariadb/*
	@sudo rm -rf /home/tgernez/data/wordpress/*
	docker compose -f srcs/docker-compose.yml down

logs:
	docker compose -f srcs/docker-compose.yml  logs

# sudo docker stop $(sudo docker ps -qa); sudo docker rm $(sudo docker ps -qa); sudo docker rmi -f $(sudo docker images -qa); sudo docker volume rm $(sudo docker volume ls -q); sudo docker network rm $(sudo docker network ls -q) 2>/dev/null

re: down all

.PHONY: all re build up down