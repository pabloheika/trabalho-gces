# Etapa 3: Integração Contínua (CI)

Esta etapa implementa o pipeline de Integração Contínua usando GitLab CI/CD com build, testes unitários e lint.

## Estrutura Criada

### Pipeline GitLab CI
- `.gitlab-ci.yml` - Pipeline principal
- `test-ci.sh` - Script para testar localmente

### Testes Backend (Django)
- `api/tests/test_auth.py` - Testes de autenticação (existente)
- `api/tests/test_models.py` - Testes de modelos (novo)

### Testes Frontend (Next.js)
- `www/__tests__/components/Layout.test.js` - Teste do componente Layout
- `www/__tests__/pages/index.test.js` - Teste da página inicial
- `www/jest.config.js` - Configuração do Jest
- `www/jest.setup.js` - Setup do Jest

### Lint e Qualidade de Código
- `www/.eslintrc.js` - Configuração do ESLint
- Dependências de teste e lint adicionadas ao `package.json`

## Pipeline GitLab CI

### Estágios
1. **Build** - Compilação dos projetos
2. **Test** - Execução de testes unitários
3. **Lint** - Verificação de qualidade de código

### Jobs Configurados

#### Build Stage
- **build-backend**: Verifica configuração Django e coleta arquivos estáticos
- **build-frontend**: Compila o projeto Next.js

#### Test Stage
- **test-backend**: Executa testes Django com cobertura
- **test-frontend**: Executa testes Jest com cobertura

#### Lint Stage
- **lint-backend**: Verifica código Python com flake8, black e isort
- **lint-frontend**: Verifica código JavaScript/TypeScript com ESLint

## Testes Implementados

### Backend (Django)
```python
# Testes de Autenticação
- test_token_success: Verifica login bem-sucedido
- test_token_error: Verifica login com credenciais inválidas

# Testes de Modelos
- test_create_user: Verifica criação de usuário normal
- test_create_superuser: Verifica criação de superusuário
- test_user_str_representation: Verifica representação string
```

### Frontend (Next.js)
```javascript
# Testes de Componentes
- Layout: Verifica renderização e navegação
- Home Page: Verifica conteúdo e links
```

## Como Usar

### 1. Testar Pipeline Localmente
```bash
./test-ci.sh
```

### 2. Executar Testes Individualmente

#### Backend
```bash
# Testes Django
python manage.py test api.tests.test_auth api.tests.test_models

# Lint Python
flake8 api/ app/
black --check api/ app/
isort --check-only api/ app/
```

#### Frontend
```bash
cd www

# Testes Jest
npm test

# Lint JavaScript
npm run lint

# Build
npm run build
```

### 3. Pipeline GitLab
O pipeline será executado automaticamente em:
- Push para qualquer branch
- Merge requests
- Tags

## Configurações

### Cache
- Cache de dependências Python (`.cache/pip/`)
- Cache de node_modules (`www/node_modules/`)

### Artefatos
- Arquivos estáticos do Django
- Build do Next.js
- Relatórios de cobertura

### Variáveis de Ambiente
- Configurações de banco de teste
- Configurações de debug
- Configurações de CORS

## Demonstração de Erros

Para demonstrar que o pipeline captura erros, você pode:

### 1. Introduzir erro de sintaxe no backend
```python
# Em qualquer arquivo Python
def broken_function(
    # Falta fechar parênteses
```

### 2. Introduzir erro de sintaxe no frontend
```javascript
// Em qualquer arquivo JavaScript
function brokenFunction() {
    // Falta fechar chaves
```

### 3. Quebrar testes
```python
# Em test_models.py
def test_always_fail(self):
    self.assertTrue(False)  # Sempre falha
```

## Próxima Etapa

A Etapa 4 consistirá na **Containerização da Aplicação (Produção)** com:
- Dockerfiles otimizados para produção
- Build de arquivos estáticos
- Configurações de segurança

---

**Etapa 3: NÃO CONCLUÍDA** 