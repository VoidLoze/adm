@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo ============================================
echo Building Microservices Project
echo ============================================

echo.
echo [1/6] Building events-contract...
cd events-contract
call mvnw clean install -DskipTests
cd ..

echo.
echo [2/6] Building books-api-contract...
cd books-api-contract
call mvnw clean install -DskipTests
cd ..

echo.
echo [3/6] Building demo-rest...
cd demo-rest
call mvnw clean package -DskipTests
cd ..

echo.
echo [4/6] Building analytics-service...
cd analytics-service
call mvnw clean package -DskipTests
cd ..

echo.
echo [5/6] Building audit-service...
cd audit-service
call mvnw clean package -DskipTests
cd ..

echo.
echo [6/6] Building ws...
cd ws
call mvnw clean package -DskipTests
cd ..

echo.
echo [7/7] Building Docker images...
docker-compose build

echo.
echo ============================================
echo Build completed successfully!
echo ============================================

echo.
echo To start all services, run: start.bat
echo.
echo Access points:
echo   - Demo REST API:     http://localhost:8084
echo   - Swagger UI:        http://localhost:8084/swagger-ui.html
echo   - Analytics Service: http://localhost:8081
echo   - Audit Service:     http://localhost:8082
echo   - Notification WS:    http://localhost:8083
echo   - RabbitMQ Console:  http://localhost:15672 (guest/guest)
echo   - Zipkin Tracing:     http://localhost:9411
echo   - Prometheus:        http://localhost:9090
echo   - Grafana:           http://localhost:3000 (admin/admin)
echo   - Jenkins:           http://localhost:8085

pause
