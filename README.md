
# Trabalho individual de GCES 2025-1

Os conhecimentos de Gerência de Configuração de Software são fundamentais no ciclo de vida de um produto de software. As técnicas para a gestão vão desde o controle de versão, automação de build e de configuração de ambiente, testes automatizados, isolamento do ambiente até o deploy do sistema. Todos estes itens do ciclo, nos dias de hoje, são integradas em um pipeline de DevOps com as etapas de Integração Contínua (CI) e Deploy Contínuo (CD) implementadas e automatizadas.

Para exercitar estes conhecimentos, neste trabalho, você deverá aplicar os conceitos estudados ao longo da disciplina no produto de software contido neste repositório.

A aplicação em estudo está implementada com o Backend em **Django + Django Rest Framework + JWT Authentication** e o Frontend em **Next.js + Tailwind**.

O repositório da aplicação está disponível em:

https://github.com/jeffroche/nextjs-django-auth-example

# Etapas deste Trabalho

O trabalho deve ser elaborado em etapas. **Cada uma das etapas deve ser realizada em um commit separado** com o resultado funcional desta etapa.

Antes de iniciar as etapas, faça uma uma cópia do repositório original e copie os arquivos do projeto de base para seu repositório privado, disponibilizado dentro da Organização de GCES no Gitlab.

As etapas de 1 e 2 são relacionadas ao isolamento do ambiente utilizando a ferramenta Docker e Docker Compose. Neste sentido, o tutorial abaixo cobre os conceitos fundamentais para o uso destas tecnologias.

[Tutorial de Docker](https://github.com/FGA-GCES/Workshop-Docker-Entrega-01/tree/main/tutorial_docker)

As etapas de 3 e 4 são relacionadas à configuração do pipeline de CI e CD.

[Tutorial CI - Gitlab](https://github.com/FGA-GCES/Workshop-CI-Entrega-02/tree/main/gitlab-ci_tutorial)

## 1. Containerização da Aplicação (Em ambinete de Desenvolvimento - DEV)

A aplicação consiste em uma camada de api (*backend*) em Django e uma camada web (*frontend*) em React. O banco de dados padrão do Django é o SQLite, porém será necessário configurar o banco  Postgres para rodar a aplicação.

A **Etapa 1** consiste na elaboração de um `Dockerfile` que seja capaz de criar um container para rodar cada camada da aplicação (api e web) em modo de desenvolvimento (DEV). Neste sentido, a configuração deve ser feita com variáveis em modo dev, com debug habilitado e também com `hot reload`, ou seja, mudanças no código fonte na pasta da aplicação são imediatamente replicadas no ambiente que esteja sendo executado.

## 2. Docker Compose (Em ambinete de Desenvolvimento - DEV)

A **Etapa 2** consiste em cirar o arquivo `docker-compose.yml` combinando os dois containers da aplicação criados nos arquivos Dockerfile (`frontend` e `backend`) da Etapa 1 com o banco de dados `Postgres`.

O resultado final desta etapa consiste em poder subir a aplicação completa com o comando `docker compose up`.

## 3. Integração Contínua (CI)

Para a realização desta etapa, a aplicação já deverá ter seu ambiente completamente containerizado.

Esta etapa do trabalho deverá utilizar o ambiente de CI do Gitlab.

Requisitos da configuração da Integração Contínua (Gitlab-CI) incluem:

3.1 Build  
3.2 Teste - unitários  
3.3 Lint   

Para a etapa de testes, deve ser criado um teste unitário simples para cada camada da aplicação (`frontend` e `backend`). 

Cada etapa deve ser demonstrada com o pipeline capturando erros de build, teste e lint e passando em todas as etapas. Estes estados da aplicação devem estar representados em commits sequenciais.

## 4. Containerização da Aplicação (Em ambinete de Produção - PROD)

A **Etapa 4** consiste na elaboração de um `Dockerfile` na versão para Produção baseado na imagem do Linux `Alpine`. Toda a configuração da aplicação deve ser feita em modo `produção` e sem debug. Os arquivos estáticos do `frontend` devem ser gerados através de uma etapa de build e todos os códigos fonte da aplicação devem estar autocontidos dentro dos respectivos containers do `frontend` e `backend`.

## 5. Docker Compose (Em ambinete de Produção - PROD)

A **Etapa 5** consiste em criar o arquivo `docker-compose-prod.yml` combinando a aplicação criada nos arquivos Dockerfile criados na Etapa 4. No modo produção, após fazer a build dos arquivos estáticos e serví-los à partir do `Nginx` que deve rodar em um container separado. Os serviço do banco de dados `Postgres` segue conforme a o deploy de desenvolvimento, porém, deve conter credenciais próprias de produção (usuarios, senhas, etc).

O resultado final desta etapa consiste em poder subir a aplicação interia com o comando `docker compose up` exclusivamente sendo servida via SSL pela porta 443, e pela porta 80 com redirecionamento para a porta 443,  não havendo outras portas expostas para fora da rede de containers.

## 6. Deploy Contínuo (CD)

A etapa final do trabalho deverá ser realizada à partir do deploy automático da aplicação que deve ser realizado após passar sem erros em todas as etapas de CI. O deploy pode ser simulado à partir da publicação das imagens dos containers de `fronend` e `backend` de produção no `container registry` do Gitlab.

# Avaliação

A avaliação do trabalho será feita à partir da correta implementação de cada etapa. A avaliação será feita de maneira **quantitativa** (se foi realizado a implementação + documentação), e **qualitativa** (como foi implementado, entendimento dos conceitos na prática, complexidade da solução). Para isso, faça os **commits atômicos, bem documentados, completos** a fim de facilitar o entendimento e avaliação do seu trabalho. 

> **Obs: Lembramos que o trabalho é individual e cópias de soluções terão notas zeradas.**


**Observações**: 
1. A data final de entrega do trabalho é o dia **13/07/2025**;
2. O trabalho deve ser desenvolvido em um **repositório PESSOAL e PRIVADO** no ambiente do `Gitlab`;
3. Cada etapa do trabalho deverá ser entregue em commits progressivos (pondendo ser mais de um commit por etapa);
4. Os **commits devem estar espaçados em dias ao longo do desenvolvimento do trabalho**. Commits feitos todos juntos na data de entrega serão descontados da nota final.

| Item | Peso |
|---|---|
| 1. Containerização da Aplicação (DEV)                         | 1.0 |
| 2. Containerização da Aplicação + Banco (DEV)         | 1.0 |
| 3. Integração Contínua (Build, Test, Lint)                    |     |
| - 3.1 Build                                                    | 1.5 |
| - 3.2 Testes                                                    | 1.5 |
| - 3.3 Lint                                                    | 1.0 |
| 4. Containerização da Aplicação (PROD)                        | 1.5 |
| 5. Containerização da Aplicação + Banco + Nginx (PROD) | 1.0 |
| 6. Deploy Contínuo                                            | 1.5 |

# nextjs-django-boilerplate

A barebones example of a Next.js SPA backed by a Django API.

Includes the following:

Backend:

- Django
- Django REST Framework
- JWT Authentication

Frontend:

- Next.js
- Tailwind

## Setting up the backend API

Create and activate a virtualenv:

```
$ python3 -m venv .venv
$ source .venv/bin/activate
```

Install Python requirements:

```
$ pip install -r requirements/base.txt
```

Configure the Django environment:

- Rename the sample environment file to `.env`:
    ```
    $ mv .env.sample .env
    ```
- Edit the `.env` file and provide a value for `SECRET_KEY`

Set up the DB (uses sqlite by default):

```
$ python manage.py makemigrations api
$ python manage.py migrate
```

### Running the API locally

```
$ python manage.py runserver 4001
```

The API is now running at http://localhost:4001

## Setting up the frontend UI

In a new shell instance, switch to the `www` folder and install JavaScript dependencies:

```
$ cd www
$ npm install
```

### Running the UI locally

```
$ npm run dev
```

The UI is now running. Visit http://localhost:4000 in your browser.

## Running tests

```
$ python manage.py test
```

## Deployment

Below is a quick overview on deploying the app to Heroku and Vercel.

### Notes on securing cookies

This project is configured so that the Next.js app and Django API are deployed separately. Whether they are deployed to different subdomains on the same second level domain (so something like Next.js -> www.example.com, Django -> api.example.com) or completely separate domains will affect how the refresh token cookie settings should be configured. This is because the former configuration results in [requests that are considered same-site](https://security.stackexchange.com/questions/223473/for-samesite-cookie-with-subdomains-what-are-considered-the-same-site) which allows us to set the SameSite attribute in the cookie to Lax. Otherwise, we need to set the SameSite to None.

### Backend

To deploy the backend on Heroku:

1. Create a new app on Heroku
2. Add Heroku Postgres
3. Connect the app to your github repo
4. Update the config variables (see below)
5. On the Deploy tab in Heroku, trigger a deploy manually from Github (or switch on automatic deploys if you want).

#### Backend config vars

- `SECRET_KEY`: see Django docs
- `DATABASE_URL`: set automatically when Postgres is added
- `CORS_ORIGIN_REGEX_WHITELIST`: A comma-separated list of origins ([ref](https://github.com/adamchainz/django-cors-headers#cors_origin_whitelist)). This should include the URL that the Next.js app gets deployed to (see below).
- `IGNORE_DOT_ENV_FILE=on`

### Frontend

To deploy the frontend on Vercel:

1. Click "Import Project"
2. Enter the URL of your github repo
3. Select the `www` subdirectory.
4. Add the `NEXT_PUBLIC_API_HOST` env var with the value set to the URL the Django API gets deployed to
5. Complete the build
