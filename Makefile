@PHONY: build-prod run-prod stop-prod run-dev stop-dev clean-all clean-custom destroy-volumes logs-prod logs-preprod logs-dev sweep

build-prod:
	@echo "Building production images"
	docker compose -f docker-compose.yml build
	docker compose -f docker-compose-preprod.yml build

run-prod:
	@echo "Running the production stack"
	docker compose -f docker-compose.yml up -d
	docker compose -f docker-compose-preprod.yml up -d

stop-prod:
	@echo "Stopping"
	@# Stopping the preprod stack first because it depends on the prod stack
	docker compose -f docker-compose-preprod.yml down
	docker compose -f docker-compose.yml down

run-dev:
	@echo "Building and running the development stack"
	docker compose -f docker-compose-dev.yml up --build -d

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

destroy-volumes:
	@echo "Destroying all preprod and dev volumes"
	@echo "WARNING: This will destroy all data stored in the volumes"
	docker compose -f docker-compose-preprod.yml down --volumes
	docker compose -f docker-compose-dev.yml down --volumes

logs-prod:
	@echo "Showing logs for the production stack"
	docker compose -f docker-compose.yml logs -f

logs-preprod:
	@echo "Showing logs for the preprod stack"
	docker compose -f docker-compose-preprod.yml logs -f

logs-dev:
	@echo "Showing logs for the development stack"
	docker compose -f docker-compose-dev.yml logs -f

sweep:
	@echo "Removing all unused images"
	#docker rmi $(docker images -f "dangling=true" -q)
