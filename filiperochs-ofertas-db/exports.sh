# Segredos derivados do APP_SEED do Umbrel (estaveis entre reinicios, unicos por instalacao,
# nada hardcoded no git). As chaves anon/service_role sao JWTs HS256 assinados com JWT_SECRET.
if [ -z "${APP_SEED:-}" ]; then echo "APP_SEED ausente" >&2; fi

_derive() { printf '%s' "${APP_SEED}:ofertas-db:$1" | openssl dgst -sha256 | awk '{print $NF}'; }
_b64url() { openssl base64 -A | tr '+/' '-_' | tr -d '='; }
_jwt() {
  local h p s
  h=$(printf '%s' '{"alg":"HS256","typ":"JWT"}' | _b64url)
  p=$(printf '%s' "{\"role\":\"$1\",\"iss\":\"supabase\",\"iat\":1700000000,\"exp\":2300000000}" | _b64url)
  s=$(printf '%s' "$h.$p" | openssl dgst -binary -sha256 -hmac "$JWT_SECRET" | _b64url)
  printf '%s' "$h.$p.$s"
}

export POSTGRES_PASSWORD="$(_derive postgres)"
export JWT_SECRET="$(_derive jwt)$(_derive jwt2)"
export ANON_KEY="$(_jwt anon)"
export SERVICE_ROLE_KEY="$(_jwt service_role)"
export JWT_EXPIRY=3600
export S3_ACCESS_KEY_ID="$(_derive s3id | cut -c1-32)"
export S3_ACCESS_KEY_SECRET="$(_derive s3secret)"
