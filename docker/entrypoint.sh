#!/bin/bash
set -e

# Buat direktori runtime laravel & pastikan permission
mkdir -p /var/www/html/storage/framework/{sessions,views,cache} /var/www/html/storage/logs /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Tunggu database siap
echo "Menunggu koneksi MariaDB..."
until mariadb-admin ping -h"$DB_HOST" -u"$DB_USERNAME" -p"$DB_PASSWORD" --silent; do
    echo "MariaDB belum siap, menunggu..."
    sleep 2
done
echo "MariaDB siap!"

# Generate APP_KEY jika belum ada
if [ -z "$(grep -E '^APP_KEY=base64:' /var/www/html/.env 2>/dev/null)" ]; then
    echo "Menghasilkan Application Key..."
    php artisan key:generate --force
fi

# Migrasi & Seeding awal
echo "Menjalankan migrasi database..."
php artisan migrate --force

echo "Memeriksa seeding data default..."
php artisan db:seed --force 2>/dev/null || true

# Storage symbolic link
php artisan storage:link 2>/dev/null || true

# Optimasi cache
php artisan optimize:clear

exec "$@"
