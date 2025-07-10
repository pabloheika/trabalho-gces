# Etapa 1: Containerização da Aplicação (Desenvolvimento)

Esta etapa implementa a containerização da aplicação em modo de desenvolvimento com hot reload habilitado.

## Estrutura Criada

- `Dockerfile.backend` - Container para o backend Django
- `Dockerfile.frontend` - Container para o frontend Next.js
- `.dockerignore` - Arquivos ignorados no build
- `env.example` - Exemplo de configurações de ambiente
- `build-dev.sh` - Script para facilitar o build

## Configurações de Desenvolvimento

### Backend (Django)
- **Imagem base**: `python:3.8-slim`
- **Porta**: 4001
- **Debug**: Habilitado (`DEBUG=True`)
- **Hot reload**: Sim (Django development server)
- **Variáveis de ambiente**:
  - `PYTHONDONTWRITEBYTECODE=1` - Não gera arquivos .pyc
  - `PYTHONUNBUFFERED=1` - Output não bufferizado
  - `DEBUG=True` - Modo debug
  - `ON_SERVER=False` - Modo desenvolvimento

### Frontend (Next.js)
- **Imagem base**: `node:16-alpine`
- **Porta**: 4000
- **Hot reload**: Sim (Next.js development server)
- **Variáveis de ambiente**:
  - `NODE_ENV=development` - Modo desenvolvimento
  - `NEXT_TELEMETRY_DISABLED=1` - Desabilita telemetria

## Como Usar

### 1. Preparar arquivo de ambiente
```bash
# Copiar arquivo de exemplo
cp env.example .env

# Editar as configurações conforme necessário
nano .env
```

### 2. Build dos containers
```bash
# Usar o script automatizado
./build-dev.sh

# Ou build manual
docker build -f Dockerfile.backend -t gces-backend-dev .
docker build -f Dockerfile.frontend -t gces-frontend-dev .
```

### 3. Executar containers individualmente

#### Backend
```bash
docker run -p 4001:4001 \
  -v $(pwd):/app \
  --env-file .env \
  gces-backend-dev
```

#### Frontend
```bash
docker run -p 4000:4000 \
  -v $(pwd)/www:/app \
  gces-frontend-dev
```

### 4. Verificar funcionamento
- Backend: http://localhost:4001
- Frontend: http://localhost:4000

## Hot Reload

Ambos os containers suportam hot reload:

- **Backend**: O Django development server detecta mudanças automaticamente
- **Frontend**: O Next.js development server recarrega automaticamente

## Próximos Passos

Na Etapa 2, será criado o `docker-compose.yml` para orquestrar todos os serviços (backend, frontend e banco PostgreSQL) em conjunto.

## Troubleshooting

### Problemas comuns:

1. **Porta já em uso**: Verifique se as portas 4000 e 4001 estão livres
2. **Permissões**: Certifique-se de que o script `build-dev.sh` tem permissão de execução
3. **Dependências**: Se houver problemas com dependências, tente rebuildar os containers
4. **Banco de dados**: Na Etapa 2 será configurado o PostgreSQL

### Logs dos containers:
```bash
# Ver logs do backend
docker logs <container_id_backend>

# Ver logs do frontend
docker logs <container_id_frontend>
``` 