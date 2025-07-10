#!/bin/bash

# Script para build dos containers de desenvolvimento

echo "Construindo containers de desenvolvimento..."

# Build do container do backend
echo "Construindo container do backend (Django)..."
docker build -f Dockerfile.backend -t gces-backend-dev .

# Build do container do frontend
echo "Construindo container do frontend (Next.js)..."
docker build -f Dockerfile.frontend -t gces-frontend-dev .

echo "Containers construídos com sucesso!"
echo ""
echo "Para executar os containers:"
echo "  Backend:  docker run -p 4001:4001 -v \$(pwd):/app gces-backend-dev"
echo "  Frontend: docker run -p 4000:4000 -v \$(pwd)/www:/app gces-frontend-dev"
echo ""
echo "Ou use o docker-compose (próxima etapa):"
echo "  docker-compose up" 