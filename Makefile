@PHONY: build-prod run-prod stop-prod run-beta run-beta-sync stop-beta clean-all clean-custom test-back lint-back lint-front

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

run-beta-sync:
	docker compose -f docker-compose-beta.yml up --build

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

test-back:
	@echo "Running test for the backend"
	docker exec infra-insalanfr-beta-backend-1 python manage.py test --parallel auto

lint-back:
	@echo "Running linter for the backend"
	docker exec infra-insalanfr-beta-backend-1 pylint ./insalan

lint-front:
	@echo "Running linter for the backend"
	docker exec infra-insalanfr-beta-frontend-1 npm run lint
