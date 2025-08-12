#!/usr/bin/env bash
set -euo pipefail

# === CONFIG ===
PROJECT_DIR="${PROJECT_DIR:-/opt/vete}"   # usa var de entorno si existe, sino /opt/vete
BACKUP_DIR="${BACKUP_DIR:-/opt/backups}"
DATE="$(date +%F_%H%M%S)"
DB_DUMP_NAME="db_${DATE}.sql"
MEDIA_TAR_NAME="media_${DATE}.tar.gz"
ENV_BACKUP_NAME=".env_${DATE}"
# ==============

mkdir -p "$BACKUP_DIR"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "❌ No existe $PROJECT_DIR"; exit 1
fi

cd "$PROJECT_DIR"

# 1) .env
if [ -f ".env" ]; then
  cp .env "${BACKUP_DIR}/${ENV_BACKUP_NAME}"
  chmod 600 "${BACKUP_DIR}/${ENV_BACKUP_NAME}"
  echo "✅ .env respaldado en ${BACKUP_DIR}/${ENV_BACKUP_NAME}"
else
  echo "⚠️  No encontré .env en ${PROJECT_DIR}"
fi

# 2) media/
if [ -d "media" ]; then
  tar -czf "${BACKUP_DIR}/${MEDIA_TAR_NAME}" -C "$PROJECT_DIR" media
  echo "✅ media/ respaldado en ${BACKUP_DIR}/${MEDIA_TAR_NAME}"
else
  echo "ℹ️  No existe carpeta media/ (nada que respaldar)"
fi

# 3) DB (usa variables clásicas si existen)
DB_HOST="$(grep -E '^DB_HOST=' .env | cut -d= -f2- || true)"
DB_NAME="$(grep -E '^DB_NAME=' .env | cut -d= -f2- || true)"
DB_USER="$(grep -E '^DB_USER=' .env | cut -d= -f2- || true)"
DB_PASSWORD="$(grep -E '^DB_PASSWORD=' .env | cut -d= -f2- || true)"

if [[ -n "$DB_HOST" && -n "$DB_NAME" && -n "$DB_USER" ]]; then
  echo "⏳ Respaldando DB MySQL ${DB_NAME} en ${BACKUP_DIR}/${DB_DUMP_NAME}"
  mysqldump -h "$DB_HOST" -u "$DB_USER" -p"${DB_PASSWORD:-}" --databases "$DB_NAME" > "${BACKUP_DIR}/${DB_DUMP_NAME}"
  echo "✅ DB respaldada en ${BACKUP_DIR}/${DB_DUMP_NAME}"
else
  echo "ℹ️  No encontré credenciales de DB en .env (salteo backup de DB)"
fi

ls -lh "${BACKUP_DIR}" | tail -n +1
echo "🎉 Backup terminado en ${BACKUP_DIR} (fecha: ${DATE})"
