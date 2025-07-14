#!/bin/bash

# Script para testar o pipeline CI localmente

echo "Testando Pipeline CI Localmente"
echo "=================================="

# Função para executar comando e verificar resultado
run_test() {
    echo "Executando: $1"
    eval $1
    if [ $? -eq 0 ]; then
        echo "$1 - SUCESSO"
    else
        echo "$1 - FALHOU"
        exit 1
    fi
    echo ""
}

# 1. Build Backend
echo "1. Testando Build do Backend"
run_test "docker run --rm -v $(pwd):/app -w /app python:3.8-slim bash -c 'apt-get update && apt-get install -y gcc postgresql-client libpq-dev && pip install -r requirements.txt && python manage.py check'"

# 2. Build Frontend
echo "2. Testando Build do Frontend"
run_test "docker run --rm -v $(pwd)/www:/app -w /app node:16-alpine sh -c 'npm ci && npm run build'"

# 3. Testes Backend
echo "3. Testando Backend"
run_test "docker run --rm -v $(pwd):/app -w /app python:3.8-slim bash -c 'apt-get update && apt-get install -y gcc postgresql-client libpq-dev && pip install -r requirements.txt && python manage.py test api.tests.test_auth api.tests.test_models --verbosity=2'"

# 4. Testes Frontend
echo "4. Testando Frontend"
run_test "docker run --rm -v $(pwd)/www:/app -w /app node:16-alpine sh -c 'npm ci && npm test'"

# 5. Lint Backend
echo "5. Testando Lint do Backend"
run_test "docker run --rm -v $(pwd):/app -w /app python:3.8-slim bash -c 'apt-get update && apt-get install -y gcc && pip install flake8 black isort && flake8 api/ app/ --max-line-length=88 --extend-ignore=E203,W503 && black --check --diff api/ app/ && isort --check-only --diff api/ app/'"

# 6. Lint Frontend
echo "6. Testando Lint do Frontend"
run_test "docker run --rm -v $(pwd)/www:/app -w /app node:16-alpine sh -c 'npm ci && npm run lint'"

echo "Todos os testes passaram com sucesso!"
echo "O pipeline CI está funcionando corretamente." 