#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="/home/apps/app-amira"
LOG_FILE="/var/log/amira-demo-reset.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] === Memulai reset demo AMIRA ===" >> "${LOG_FILE}"

# 1. Pastikan kontainer amira_db berjalan
if ! docker ps --format '{{.Names}}' | grep -q "^amira_db$"; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Menyalakan container amira_db..." >> "${LOG_FILE}"
    cd "${PROJECT_DIR}" && docker compose up -d amira_db
    sleep 5
fi

# 2. Restore database
if [ -f "${PROJECT_DIR}/demo-pristine.sql" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Memulihkan database amira_db..." >> "${LOG_FILE}"
    docker exec -i amira_db mariadb -u amira_user -pamira_password_secure_2026 amira_db < "${PROJECT_DIR}/demo-pristine.sql"
fi

# 3. Clear cache Laravel
docker exec amira_app php artisan optimize:clear >> "${LOG_FILE}" 2>&1 || true

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Reset demo AMIRA selesai." >> "${LOG_FILE}"
