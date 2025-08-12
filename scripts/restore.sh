#!/usr/bin/env bash
set -euo pipefail
REPO_URL="${REPO_URL:-https://github.com/Caba21766/vete.git}"
PROJECT_DIR="${PROJECT_DIR:-/opt/vete}"
BACKUP_DIR="${BACKUP_DIR:-/opt/backups}"
PYTHON_PKG="python3-venv python3-pip"
GUNICORN_PORT="${GUNICORN_PORT:-8001}"
SERVER_NAME="${SERVER_NAME:-_}"

sudo apt update
sudo apt install -y nginx git ${PYTHON_PKG} mysql-client || true

sudo rm -rf "${PROJECT_DIR}"
sudo git clone "${REPO_URL}" "${PROJECT_DIR}"
sudo chown -R $USER:$USER "${PROJECT_DIR}"
cd "${PROJECT_DIR}"

python3 -m venv env
source env/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

ENV_BKP="$(ls -1t ${BACKUP_DIR}/.env_* 2>/dev/null | head -n1 || true)"
MEDIA_TAR="$(ls -1t ${BACKUP_DIR}/media_*.tar.gz 2>/dev/null | head -n1 || true)"
[ -n "${ENV_BKP}" ] && cp "${ENV_BKP}" .env && chmod 600 .env || echo "⚠️ Pegá tus variables en .env"

python manage.py migrate
python manage.py collectstatic --noinput || true
[ -n "${MEDIA_TAR}" ] && tar -xzf "${MEDIA_TAR}" -C "${PROJECT_DIR}" || echo "ℹ️  Sin backup de media"

sudo tee /etc/systemd/system/gunicorn.service >/dev/null <<EOT
[Unit]
Description=Gunicorn for Django (vete)
After=network.target
[Service]
User=${USER}
WorkingDirectory=${PROJECT_DIR}
Environment=PATH=${PROJECT_DIR}/env/bin
ExecStart=${PROJECT_DIR}/env/bin/gunicorn prueba1.wsgi:application --bind 127.0.0.1:${GUNICORN_PORT}
Restart=always
[Install]
WantedBy=multi-user.target
EOT
sudo systemctl daemon-reload
sudo systemctl enable --now gunicorn

sudo tee /etc/nginx/sites-available/vete >/dev/null <<EOT
server {
    listen 80;
    server_name ${SERVER_NAME};
    client_max_body_size 50M;
    location /static/ { alias ${PROJECT_DIR}/staticfiles/; }
    location /media/  { alias ${PROJECT_DIR}/media/; }
    location / {
        proxy_pass http://127.0.0.1:${GUNICORN_PORT};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOT
sudo ln -sf /etc/nginx/sites-available/vete /etc/nginx/sites-enabled/vete
sudo nginx -t && sudo systemctl reload nginx
echo "🎉 Restore completo."
