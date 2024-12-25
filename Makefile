all: start

start:
	mkdir -p /Users/ramzerk/data/wordpress
	mkdir -p /Users/ramzerk/data/mariadb
	mkdir -p /Users/ramzerk/data/minecraft
	mkdir -p /Users/ramzerk/data/adminer
	docker compose --project-directory srcs up --build -d

stop:
	docker compose --project-directory srcs down

delete:
	sudo rm -rf /Users/ramzerk/data/wordpress
	sudo rm -rf /Users/ramzerk/data/mariadb
	sudo rm -rf /Users/ramzerk/data/minecraft
	sudo rm -rf	/Users/ramzerk/data/adminer

supp:
	docker volume rm srcs_db
	docker volume rm srcs_wp
	docker volume rm srcs_adm
	docker volume rm srcs_mc
	docker system prune -af


logs:
	docker compose --project-directory srcs logs

.PHONY: start all logs delete supp
