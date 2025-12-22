@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo ============================================
echo Stopping Microservices
echo ============================================

echo.
echo Stopping all containers...
docker-compose down --remove-orphans

echo.
echo ============================================
echo All services stopped.
echo ============================================

pause

