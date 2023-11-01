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

re: down all

.PHONY: all re build up down