all: start

start:
	mkdir -p srcs/my_volume
	docker compose --project-directory srcs up --build -d

stop:
	docker compose --project-directory srcs down

logs:
	docker compose --project-directory srcs logs

.PHONY: start all logs
