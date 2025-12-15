#!/bin/bash

set -e

echo "============================================"
echo "Building Microservices Project"
echo "============================================"

echo
echo "[1/6] Building events-contract..."
cd events-contract
./mvnw clean install -DskipTests
cd ..

echo
echo "[2/6] Building books-api-contract..."
cd books-api-contract
./mvnw clean install -DskipTests
cd ..

echo
echo "[3/6] Building demo-rest..."
cd demo-rest
./mvnw clean package -DskipTests
cd ..

echo
echo "[4/6] Building analytics-service..."
cd analytics-service
./mvnw clean package -DskipTests
cd ..

echo
echo "[5/6] Building audit-service..."
cd audit-service
./mvnw clean package -DskipTests
cd ..

echo
echo "[6/6] Building ws..."
cd ws
./mvnw clean package -DskipTests
cd ..

echo
echo "[7/7] Building Docker images..."
docker-compose build

echo
echo "============================================"
echo "Build completed successfully!"
echo "============================================"
echo
echo "To start all services, run: ./start.sh"
echo
echo "Access points:"
echo "  - Demo REST API:     http://localhost:8080"
echo "  - Swagger UI:        http://localhost:8080/swagger-ui.html"
echo "  - RabbitMQ Console:  http://localhost:15672"
echo "  - Zipkin:            http://localhost:9411"
echo "  - Prometheus:        http://localhost:9090"
echo "  - Grafana:           http://localhost:3000 (admin/admin)"
echo "  - Jenkins:           http://localhost:8085"
