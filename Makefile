@PHONY: build-prod run-prod stop-prod run-dev stop-dev

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
	# Stopping the preprod stack first because it depends on the prod stack
	docker compose -f docker-compose-preprod.yml down
	docker compose -f docker-compose.yml down

run-dev:
	@echo "Building and running the development stack"
	docker compose -f docker-compose-dev.yml up --build -d

stop-dev:
	@echo "Stopping"
	docker compose -f docker-compose-dev.yml down
