# Development commands
.PHONY: dev build test clean install update-proto

# Development environment
dev:
	docker-compose up -d

# Production environment
prod:
	docker-compose -f docker-compose.prod.yml up -d

# Build all services
build:
	docker-compose build

# Build production images
build-prod:
	docker-compose -f docker-compose.prod.yml build

# Run tests
test: test-frontend test-backend

test-frontend:
	cd all-ride-interview-fe && yarn test

test-backend:
	cd allride && ./gradlew test

# Clean up
clean:
	docker-compose down -v
	docker-compose -f docker-compose.prod.yml down -v
	rm -rf all-ride-interview-fe/node_modules
	rm -rf allride/build
	rm -rf .gradle

# Install dependencies
install:
	cd all-ride-interview-fe && yarn install
	cd allride && ./gradlew build

# Update proto files
update-proto:
	cd all-ride-interview-fe && ./generate-proto.sh
	cd allride && ./gradlew generateProto

# Start services individually
frontend:
	docker-compose up -d frontend envoy

backend:
	docker-compose up -d backend localstack memcached

# Logs
logs:
	docker-compose logs -f

# Health check
health:
	curl -f http://localhost:3000/health
	curl -f http://localhost:50051/health
	curl -f http://localhost:8090/healthz

# Clean Docker
clean-docker:
	docker-compose down -v --remove-orphans
	docker-compose -f docker-compose.prod.yml down -v --remove-orphans
