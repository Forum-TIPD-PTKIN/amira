# 🚀 AMIRA

**AMIRA (Aplikasi Manajemen Informasi & Registrasi Acara)** adalah aplikasi berbasis web yang dibangun menggunakan **Laravel 12**, **Inertia.js**, dan **Vue 3** untuk membantu organisasi, komunitas, kampus, maupun perusahaan dalam mengelola acara secara terintegrasi.

---

## ✨ Fitur Utama

### 📅 Manajemen Event

- Membuat event baru
- Mengedit dan menghapus event
- Mengelola lokasi acara (venue maupun custom location)
- Upload banner event
- Menampilkan daftar event terbaru

### 📝 Registrasi Peserta

- Pendaftaran peserta secara online
- Pengelolaan data peserta event
- Monitoring jumlah peserta

### 📋 Rundown Event

- Menyusun jadwal kegiatan
- Mengatur sesi acara secara terstruktur
- Monitoring pelaksanaan event

### 📊 Dashboard & Analytics

- Statistik event
- Monitoring jumlah peserta
- Insight performa event secara real-time

---

## 🔐 Authentication

AMIRA menggunakan **Laravel Socialite** untuk autentikasi menggunakan akun Google.

### Google Login

- Login menggunakan akun Google
- Integrasi OAuth 2.0
- Proses autentikasi yang aman dan cepat

---

## 🛠️ Tech Stack

### Backend

- Laravel 12
- PHP 8.2+

### Frontend

- Vue 3
- Inertia.js
- Tailwind CSS
- Shadcn Vue
- Lucide Icons

### Database

- MySQL

---

## 🚀 Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/USERNAME/amira.git
cd amira
```

### 2. Install Dependency PHP

```bash
composer install
```

### 3. Install Dependency JavaScript

```bash
npm install
```

### 4. Salin File Environment

```bash
cp .env.example .env
```

### 5. Generate Application Key

```bash
php artisan key:generate
```

### 6. Konfigurasi Database

Sesuaikan konfigurasi database pada file `.env`.

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=amira
DB_USERNAME=root
DB_PASSWORD=
```

### 7. Jalankan Migrasi Database

```bash
php artisan migrate
```

---

## ▶️ Menjalankan Project

### Jalankan Backend Laravel

```bash
php artisan serve
```

### Jalankan Frontend Vite

```bash
npm run build
```

### Akses Aplikasi

```text
http://127.0.0.1:8000
```

---

## 🔑 Konfigurasi Google Login (Laravel Socialite)

Tambahkan konfigurasi berikut ke file `.env`:

```env
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
GOOGLE_REDIRECT_URI=http://localhost/auth/google/callback
```

### Cara Mendapatkan Google Client ID

1. Buka Google Cloud Console.
2. Buat project baru atau gunakan project yang sudah ada.
3. Aktifkan **OAuth Consent Screen**.
4. Buat **OAuth Client ID** dengan tipe **Web Application**.
5. Tambahkan Redirect URI berikut:

```text
http://localhost/auth/google/callback
```

---

## 📂 Struktur Teknologi

| Layer | Teknologi |
|---------|------------|
| Backend | Laravel 12 |
| Frontend | Vue 3 + Inertia.js |
| Styling | Tailwind CSS + Shadcn Vue |
| Authentication | Laravel Socialite |
| Database | MySQL |
| Build Tool | Vite |

---

## 🤝 Kontribusi

Kontribusi, saran, maupun pelaporan bug sangat terbuka untuk membantu pengembangan AMIRA menjadi lebih baik.

---

## 📄 Lisensi

Project ini dikembangkan untuk kebutuhan manajemen event dan dapat disesuaikan sesuai kebutuhan organisasi atau institusi.
