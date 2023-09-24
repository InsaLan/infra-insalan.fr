@PHONY: build-prod run-prod stop-prod run-dev stop-dev clean-all clean-custom sweep

build-prod:
	@echo "Building production images"
	docker compose -f docker-compose.yml build

run-prod:
	@echo "Running the production stack"
	docker compose -f docker-compose.yml up -d

stop-prod:
	@echo "Stopping"
	@# Stopping the preprod stack first because it depends on the prod stack
	docker compose -f docker-compose-preprod.yml down
	docker compose -f docker-compose.yml down

run-preprod:
	docker compose -f docker-compose-preprod.yml up -d

stop-preprod:
	docker compose -f docker-compose-preprod.yml down

run-dev:
	@echo "Building and running the development stack"
	docker compose -f docker-compose-dev.yml up --build -d

run-dev-attached:
	@echo "Building and running the development stack in attached mode"
	docker compose -f docker-compose-dev.yml up --build

stop-dev:
	@echo "Stopping"
	docker compose -f docker-compose-dev.yml down

clean-all:
	@echo "Removing all images related to the project"
	docker compose -f docker-compose.yml down --rmi all
	docker compose -f docker-compose-preprod.yml down --rmi all
	docker compose -f docker-compose-dev.yml down --rmi all

clean-custom:
	@echo "Removing all custom images"
	docker compose -f docker-compose.yml down --rmi local
	docker compose -f docker-compose-preprod.yml down --rmi local
	docker compose -f docker-compose-dev.yml down --rmi local

sweep:
	@echo "Removing all unused images"
	#docker rmi $(docker images -f "dangling=true" -q)
