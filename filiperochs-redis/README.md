# filiperochs-redis 🔧

Este app instala um servidor **Redis 7** com armazenamento persistente e expõe a porta 6379.

## Recursos

- Imagem: `redis:8.4-alpine`
- Porta exposta: `6379`
- Volume de dados: `${APP_DATA_DIR}/data/redis`
- Suporte a senha opcional via variável `REDIS_PASSWORD`

## Uso

1. Coloque dados persistentes em `${APP_DATA_DIR}/data/redis` (o Umbrel monta `${APP_DATA_DIR}` automaticamente).
2. Para habilitar senha: crie um arquivo `.env` dentro da pasta do app (no armazenamento do Umbrel) com:

```
REDIS_PASSWORD=senha_forte_aqui
```

3. Reinicie o app pelo painel do Umbrel ou com `docker compose up -d` na pasta do app.

## Conexão a partir de outros containers

- Host/serviço Docker: `redis` (ex.: `redis://redis:6379`)
- Conexão local (porta mapeada): `redis://localhost:6379`
- Se tiver senha: `redis://:SUA_SENHA@localhost:6379/0`

## Notas

- Incluí um `healthcheck` que valida com `redis-cli ping`.
- O container inicia com `appendonly yes` para maior durabilidade. Se desejar outras configurações, substitua o `command` no `docker-compose.yml`.

---

Se quiser, posso também adicionar um `docker-compose.override.yml` para habilitar mais parâmetros ou um exemplo de `.env` de exemplo no repositório. 😊
