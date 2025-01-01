all: start

start:
	mkdir -p ~/Users/ramzerk/data/mariadb
	mkdir -p ~/Users/ramzerk/data/wordpress
	mkdir -p ~/Users/ramzerk/data/adminer
	mkdir -p ~/Users/ramzerk/data/minecraft
	docker compose --project-directory srcs up --build -d

stop:
	docker compose --project-directory srcs down

delete:
	 sudo rm -rf ~/Users/ramzerk/data/*

supp:
	docker container rm -f mariadb
	docker container rm -f wordpress
	docker container rm -f nginx
	docker container rm -f ftp
	docker container rm -f redis
	docker container rm -f minecraft
	docker container rm -f adminer
	docker container rm -f static_web
	docker volume rm srcs_db
	docker volume rm srcs_wp
	docker volume rm srcs_adm
	docker volume rm srcs_mc
	docker system prune -af


clean : stop delete supp

logs:
	docker compose --project-directory srcs logs

.PHONY: start all logs delete supp
