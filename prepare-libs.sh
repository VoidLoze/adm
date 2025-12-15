#!/bin/bash

set -e

echo "============================================"
echo "Preparing Local Libraries for Docker Build"
echo "============================================"

echo
echo "[1/2] Building and installing events-contract..."
cd events-contract
./mvnw clean install -DskipTests
cd ..

echo
echo "[2/2] Building and installing books-api-contract..."
cd books-api-contract
./mvnw clean install -DskipTests
cd ..

echo
echo "============================================"
echo "Libraries prepared successfully!"
echo "============================================"
echo
echo "Now run: ./build.sh"
