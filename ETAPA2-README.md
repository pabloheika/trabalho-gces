# Etapa 2: Docker Compose (Desenvolvimento)

Esta etapa implementa a orquestração completa da aplicação usando Docker Compose, incluindo backend, frontend e banco de dados PostgreSQL.

## Estrutura Criada

- `docker-compose.yml` - Orquestração dos serviços
- `dev.sh` - Script para gerenciar o ambiente
- `env.docker` - Configurações de ambiente para Docker

## Serviços Configurados

### 1. Banco de Dados (PostgreSQL)
- **Imagem**: `postgres:13-alpine`
- **Porta**: 5432
- **Banco**: `django_auth_db`
- **Usuário**: `postgres`
- **Senha**: `postgres`
- **Volume**: `postgres_data` (persistência dos dados)
- **Healthcheck**: Verifica se o banco está pronto

### 2. Backend (Django)
- **Build**: `Dockerfile.backend`
- **Porta**: 4001
- **Dependências**: Aguarda o banco estar saudável
- **Volumes**: Código fonte mapeado para hot reload
- **Comando**: Executa migrações e inicia servidor de desenvolvimento

### 3. Frontend (Next.js)
- **Build**: `Dockerfile.frontend`
- **Porta**: 4000
- **Dependências**: Aguarda o backend estar pronto
- **Volumes**: Código fonte mapeado + node_modules isolado
- **Comando**: Instala dependências e inicia servidor de desenvolvimento

## Como Usar

### 1. Iniciar todos os serviços
```bash
# Usar o script automatizado
./dev.sh up

# Ou usar docker-compose diretamente
docker-compose up --build
```

### 2. Parar todos os serviços
```bash
./dev.sh down
# ou
docker-compose down
```

### 3. Ver logs em tempo real
```bash
./dev.sh logs
# ou
docker-compose logs -f
```

### 4. Acessar shells dos containers
```bash
# Backend
./dev.sh shell-backend

# Frontend
./dev.sh shell-frontend

# Banco de dados
./dev.sh shell-db
```

## Acessos

- **Frontend**: http://localhost:4000
- **Backend API**: http://localhost:4001
- **Banco PostgreSQL**: localhost:5432

## Funcionalidades

### Hot Reload
- **Backend**: Mudanças no código Python são detectadas automaticamente
- **Frontend**: Mudanças no código React/Next.js recarregam automaticamente

### Persistência de Dados
- Banco PostgreSQL com volume persistente
- Dados mantidos entre reinicializações

### Dependências entre Serviços
- Backend aguarda banco estar pronto
- Frontend aguarda backend estar pronto

### Rede Isolada
- Todos os serviços na rede `gces-network`
- Comunicação interna via nomes dos containers

## Comandos Úteis

```bash
# Ver status dos serviços
docker-compose ps

# Rebuild e reiniciar
./dev.sh restart

# Limpar tudo (cuidado: remove dados do banco)
./dev.sh clean

# Ver logs de um serviço específico
docker-compose logs backend
docker-compose logs frontend
docker-compose logs db
```

## Troubleshooting

### Problemas comuns:

1. **Porta já em uso**: Verifique se as portas 4000, 4001 e 5432 estão livres
2. **Banco não conecta**: Aguarde o healthcheck do PostgreSQL (pode demorar alguns segundos)
3. **Dependências não encontradas**: Use `./dev.sh restart` para rebuildar
4. **Permissões**: Certifique-se de que o script `dev.sh` tem permissão de execução

### Logs de erro:
```bash
# Ver logs de erro específicos
docker-compose logs --tail=50 backend
docker-compose logs --tail=50 frontend
docker-compose logs --tail=50 db
```

## Próxima Etapa

A Etapa 3 consistirá na implementação da Integração Contínua (CI) com GitLab CI/CD, incluindo:
- Build automatizado
- Testes unitários
- Lint/Code quality

---

**Etapa 2: CONCLUÍDA** 