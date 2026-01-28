# Evolution API no Umbrel

Instalação da [Evolution API v2](https://doc.evolution-api.com/v2/pt/get-started/introduction) na sua Custom App Store do Umbrel, com PostgreSQL e Redis incluídos.

## O que está incluído

- **Evolution API** – API de WhatsApp e integrações (Typebot, Chatwoot, Dify, etc.)
- **PostgreSQL 16** – Banco de dados exigido pela Evolution API v2
- **Redis 7** – Cache exigido pela Evolution API v2

O proxy do Umbrel (`app_proxy`) encaminha o tráfego para o container da Evolution API na porta 4502.

## Credenciais e segurança

| Item | Padrão | Como alterar |
|------|--------|---------------|
| **API Key** | `evolution_umbrel_api_key` | Edite o `docker-compose.yml` do app e altere o valor em `AUTHENTICATION_API_KEY`, ou defina a variável `EVOLUTION_API_KEY` no ambiente onde o Umbrel executa o compose. A API Key também aparece em "Senha padrão" na página do app na loja. |
| **Senha do PostgreSQL** | `evolution_umbrel_db` | Edite o `docker-compose.yml`: altere `POSTGRES_PASSWORD` no serviço `postgres` e o valor correspondente em `DATABASE_CONNECTION_URI` no serviço `evolution-api`. Ou use a variável de ambiente `EVOLUTION_DB_PASSWORD` (se o Umbrel injetar variáveis no compose). |

**Em produção**, use sempre uma API Key forte e, se possível, senha de banco diferente da padrão.

## Webhooks

Para usar webhooks com serviços externos, configure a variável **SERVER_URL** com a URL pública do seu Umbrel + path do app, por exemplo:

```bash
SERVER_URL=https://seu-dominio.com/filiperochs-evolution-api
```

Isso pode ser definido no `.env` ou adicionado em `environment` do serviço `evolution-api` no `docker-compose.yml`.

Documentação de webhooks: https://doc.evolution-api.com/v2/pt/configuration/webhooks

## Documentação oficial

- [Introdução e instalação](https://doc.evolution-api.com/v2/pt/get-started/introduction)
- [Instalação com Docker](https://doc.evolution-api.com/v2/en/install/docker)
- [Variáveis de ambiente](https://doc.evolution-api.com/v2/en/env)
- [Definições da API](https://doc.evolution-api.com/v2/pt/definitions/connections)
- [Coleção Postman](https://www.postman.com/agenciadgcode/evolution-api/collection/gqr041s/evolution-api-v2-0)

## Dados persistentes

Os dados ficam em `${APP_DATA_DIR}/data/`:

- `postgres/` – dados do PostgreSQL
- `redis/` – dados do Redis
- `evolution/` – instâncias da Evolution API

`APP_DATA_DIR` é definido pelo Umbrel (geralmente em um volume persistente).
