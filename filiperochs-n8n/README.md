# n8n no Umbrel

Instalação do [n8n](https://n8n.io/) na sua Custom App Store do Umbrel, com PostgreSQL incluído.

Baseado na [documentação oficial de instalação Docker](https://docs.n8n.io/hosting/installation/docker/) e no [repositório n8n-hosting](https://github.com/n8n-io/n8n-hosting).

## O que está incluído

- **n8n** – plataforma de automação de workflows (porta 5678)
- **PostgreSQL 16** – banco para workflows, credenciais e execuções

O proxy do Umbrel (`app_proxy`) encaminha o tráfego para o container do n8n na porta 5678.

## Primeiro acesso

Ao acessar pela primeira vez, crie sua conta. O primeiro usuário registrado vira **owner** da instância.

## Configuração e segurança

| Item | Padrão | Como alterar |
|------|--------|---------------|
| **N8N_ENCRYPTION_KEY** | `n8n_umbrel_encryption_key_change_in_prod` | **Importante:** em produção use uma chave forte (32+ caracteres). Gere com `openssl rand -base64 32`. Defina no ambiente onde o Umbrel executa o compose ou edite o `docker-compose.yml`. Credenciais salvas no n8n dependem desta chave. |
| **Senha do PostgreSQL** | `n8n_umbrel_db` | Altere `N8N_DB_PASSWORD` no ambiente ou em `docker-compose.yml` (em `postgres` e no serviço `n8n`). |
| **Fuso horário** | `UTC` | Defina `TZ` e `GENERIC_TIMEZONE` (ex.: `America/Sao_Paulo`) no ambiente ou no compose. |

## Webhooks e URL base

Para webhooks de triggers (GitHub, etc.) funcionarem, o n8n precisa ser acessível por uma URL pública. Configure no n8n (Settings > General):

- **Webhook URL** – URL base onde o Umbrel expõe o app (ex.: `https://seu-dominio.com/filiperochs-n8n`).

Documentação: [Webhook URLs with reverse proxy](https://docs.n8n.io/hosting/configuration/configuration-examples/webhook-urls-reverse-proxy/)

## Documentação oficial

- [Instalação Docker](https://docs.n8n.io/hosting/installation/docker/)
- [Variáveis de ambiente](https://docs.n8n.io/hosting/configuration/environment-variables/)
- [Chave de criptografia](https://docs.n8n.io/hosting/configuration/configuration-examples/encryption-key/)
- [n8n-hosting (docker-compose com Postgres)](https://github.com/n8n-io/n8n-hosting)

## Dados persistentes

Os dados ficam em `${APP_DATA_DIR}/data/`:

- `postgres/` – banco PostgreSQL do n8n
- `n8n/` – dados locais do n8n (chaves, configurações, etc.)

`APP_DATA_DIR` é definido pelo Umbrel.
