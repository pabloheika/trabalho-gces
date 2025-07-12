#!/bin/bash

# Script para gerenciar o ambiente de desenvolvimento

case "$1" in
  "up")
    echo "Iniciando ambiente de desenvolvimento..."
    docker compose up --build
    ;;
  "down")
    echo "Parando ambiente de desenvolvimento..."
    docker compose down
    ;;
  "restart")
    echo "Reiniciando ambiente de desenvolvimento..."
    docker compose down
    docker compose up --build
    ;;
  "logs")
    echo "Mostrando logs..."
    docker compose logs -f
    ;;
  "clean")
    echo "Limpando containers e volumes..."
    docker compose down -v
    docker system prune -f
    ;;
  "shell-backend")
    echo "Abrindo shell do backend..."
    docker compose exec backend bash
    ;;
  "shell-frontend")
    echo "Abrindo shell do frontend..."
    docker compose exec frontend sh
    ;;
  "shell-db")
    echo "Abrindo shell do banco de dados..."
    docker compose exec db psql -U postgres -d django_auth_db
    ;;
  *)
    echo "Script de gerenciamento do ambiente de desenvolvimento"
    echo ""
    echo "Uso: ./dev.sh [comando]"
    echo ""
    echo "Comandos disponíveis:"
    echo "  up              - Inicia todos os serviços"
    echo "  down            - Para todos os serviços"
    echo "  restart         - Reinicia todos os serviços"
    echo "  logs            - Mostra logs em tempo real"
    echo "  clean           - Limpa containers e volumes"
    echo "  shell-backend   - Abre shell do backend"
    echo "  shell-frontend  - Abre shell do frontend"
    echo "  shell-db        - Abre shell do banco de dados"
    echo ""
    echo "Exemplo: ./dev.sh up"
    ;;
esac 