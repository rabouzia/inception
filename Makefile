all: start

start:
	mkdir -p srcs/my_volume/wordpress
	mkdir -p srcs/my_volume/mariadb
	mkdir -p srcs/my_volume/adminer
	docker compose --project-directory srcs up --build -d

stop:
	docker compose --project-directory srcs down

delete:
	sudo rm -rf srcs/my_volume/wordpress
	sudo rm -rf srcs/my_volume/mariadb
supp:
	docker volume rm srcs_db
	docker volume rm srcs_wp
	docker volume rm srcs_adm


logs:
	docker compose --project-directory srcs logs

.PHONY: start all logs delete
