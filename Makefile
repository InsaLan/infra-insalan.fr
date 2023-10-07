@PHONY: build-prod run-prod stop-prod clean-all clean-custom

build-prod:
	@echo "Building production images"
	docker compose -f docker-compose.yml build

run-prod:
	@echo "Running the production stack"
	docker compose -f docker-compose.yml up -d

stop-prod:
	@echo "Stopping the production stack"
	docker compose -f docker-compose.yml down

run-beta:
	@echo "Running the pre-production stack"
	docker compose -f docker-compose-beta.yml up --build -d

stop-beta:
	@echo "Stopping the pre-production stack" 
	docker compose -f docker-compose-beta.yml down

clean-all:
	@echo "Removing all images related to the project"
	docker compose -f docker-compose.yml down --rmi all
	docker compose -f docker-compose-beta.yml down --rmi all

clean-custom:
	@echo "Removing all custom images"
	docker compose -f docker-compose.yml down --rmi local
	docker compose -f docker-compose-beta.yml down --rmi local
