<script setup>
import { ref, onMounted } from 'vue'
import { Button } from '@/Components/ui/button'
import { Input } from '@/Components/ui/input'
import { Label } from '@/Components/ui/label'
import InputError from '@/Components/InputError.vue'
import { Head, useForm, usePage } from '@inertiajs/vue3'
import LoadingOverlay from '@/Components/LoadingOverlay.vue'
import axios from 'axios'

const page = usePage()

const form = useForm({
  email: '',
  password: '',
  captcha: '',
})

const captchaQuestion = ref('Memuat...')
const loadingCaptcha = ref(false)

const fetchCaptcha = async () => {
  loadingCaptcha.value = true
  try {
    const res = await axios.get(route('captcha.generate'))
    captchaQuestion.value = res.data.question
    form.captcha = ''
  } catch (err) {
    captchaQuestion.value = '5 + 3 = ?'
  } finally {
    loadingCaptcha.value = false
  }
}

const fillDemo = (email, password) => {
  form.email = email
  form.password = password
}

onMounted(() => {
  fetchCaptcha()
})

const submitNormal = () => {
  document.dispatchEvent(new Event('loading:start'))
  form.post(route('login'), {
    onFinish: () => {
      document.dispatchEvent(new Event('loading:finish'))
      form.reset('password')
      fetchCaptcha()
    },
    onError: () => {
      document.dispatchEvent(new Event('loading:finish'))
    },
  })
}

const redirectGoogle = () => {
  document.dispatchEvent(new Event('loading:start'))
  setTimeout(() => {
    window.location.href = route('auth.google')
  }, 100)
}
</script>

<template>
  <LoadingOverlay />
  <Head title="Login - AMIRA" />

  <div class="min-h-screen grid md:grid-cols-2">

    <!-- LEFT (LANDING STYLE) -->
    <div class="relative flex items-center justify-center overflow-hidden">
      <!-- gradient AMIRA -->
      <div class="absolute inset-0 bg-gradient-animate"></div>
      <div class="absolute inset-0 bg-black/10"></div>

      <!-- floating orbs -->
      <div class="absolute -top-32 -left-32 w-96 h-96 bg-emerald-400/30 rounded-full blur-3xl animate-pulse"></div>
      <div class="absolute top-20 -right-32 w-96 h-96 bg-blue-400/30 rounded-full blur-3xl animate-pulse"></div>

      <!-- content -->
      <div class="relative text-white text-center px-8">
        <p class="text-white/80 text-sm tracking-wide">
          AMIRA Platform
        </p>

        <h1 class="text-4xl md:text-5xl font-bold leading-tight mt-3">
          Aplikasi Manajemen  <br />
          Informasi & Registrasi Acara
        </h1>

        <p class="mt-5 text-white/80 text-lg max-w-md mx-auto">
          Kelola event, panitia, dan registrasi dalam satu sistem terintegrasi, ayo gunakan sekarang.
        </p>

        <div class="mt-8">
          <img src="/images/hero-2.png" class="w-full max-w-md mx-auto rounded-2xl shadow-2xl" />
        </div>
      </div>
    </div>

    <!-- RIGHT (LOGIN OPTIONS) -->
    <div class="relative flex items-center justify-center bg-white px-6 sm:px-10 py-10">
      <div class="absolute inset-0 bg-[radial-gradient(circle_at_top,rgba(16,185,129,0.08),transparent_60%)]"></div>

      <div class="relative w-full max-w-md">
        <div class="flex flex-col items-center mb-3 text-center">
          <img
            src="/images/logo-amira.png"
            alt="AMIRA"
            class="object-contain mb-1"
            style="filter: drop-shadow(0 4px 10px rgba(0,0,0,0.1)); width: 120px; height: 120px;"
          />
        </div>

        <div class="w-14 h-1 bg-emerald-500 rounded-full mb-3 mx-auto md:mx-0"></div>

        <!-- ERROR FLASH / GENERAL -->
        <div
          v-if="page.props.errors?.email || page.props.flash?.error"
          class="mb-4 rounded-xl bg-red-50 p-3 text-sm text-red-700 border border-red-200"
        >
          {{ page.props.errors?.email || page.props.flash?.error }}
        </div>

        <h2 class="text-2xl font-bold text-gray-900">
          Selamat Datang 👋
        </h2>

        <p class="text-sm text-gray-500 mt-1 mb-5">
          Masuk ke sistem AMIRA dengan akun Anda atau login Google.
        </p>

        <!-- KARTU AKSES CEPAT AKUN DEMO -->
        <div class="mb-5 p-3 rounded-2xl bg-gradient-to-br from-emerald-50 via-teal-50/40 to-slate-50 border border-emerald-200/80 shadow-sm">
          <div class="flex items-center gap-2 mb-2">
            <span class="inline-flex items-center justify-center w-5 h-5 rounded-full bg-emerald-600 text-white text-[10px] font-black shadow-sm">
              <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
            </span>
            <span class="text-xs font-black uppercase tracking-wider text-emerald-950">Akses Cepat Akun Demo</span>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs">
            <!-- Super Admin Card -->
            <div
              @click="fillDemo('adminsuper@example.com', 'password123')"
              class="p-2.5 rounded-xl bg-white border border-emerald-100 hover:border-emerald-500 hover:shadow-md cursor-pointer transition-all duration-200 active:scale-[0.98]"
            >
              <div class="flex items-center gap-1.5 mb-0.5">
                <span class="w-2 h-2 rounded-full bg-emerald-500"></span>
                <span class="font-bold text-slate-800 text-[11px]">Super Admin</span>
              </div>
              <div class="text-[10px] text-slate-600 font-mono truncate">
                adminsuper@example.com
              </div>
            </div>

            <!-- Admin Event Card -->
            <div
              @click="fillDemo('admin@example.com', 'password123')"
              class="p-2.5 rounded-xl bg-white border border-emerald-100 hover:border-emerald-500 hover:shadow-md cursor-pointer transition-all duration-200 active:scale-[0.98]"
            >
              <div class="flex items-center gap-1.5 mb-0.5">
                <span class="w-2 h-2 rounded-full bg-blue-500"></span>
                <span class="font-bold text-slate-800 text-[11px]">Admin Event</span>
              </div>
              <div class="text-[10px] text-slate-600 font-mono truncate">
                admin@example.com
              </div>
            </div>

            <!-- User Demo Card -->
            <div
              @click="fillDemo('user@example.com', 'password123')"
              class="p-2.5 rounded-xl bg-white border border-emerald-100 hover:border-emerald-500 hover:shadow-md cursor-pointer transition-all duration-200 active:scale-[0.98] sm:col-span-2"
            >
              <div class="flex items-center gap-1.5 mb-0.5">
                <span class="w-2 h-2 rounded-full bg-amber-500"></span>
                <span class="font-bold text-slate-800 text-[11px]">User / Peserta</span>
              </div>
              <div class="text-[10px] text-slate-600 font-mono truncate">
                user@example.com
              </div>
            </div>
          </div>
          <p class="text-[10px] text-emerald-800/80 mt-2 text-center">
            💡 <em>Klik salah satu kartu di atas untuk mengisi otomatis form login.</em>
          </p>
        </div>

        <!-- FORM LOGIN WITH CAPTCHA (DI ATAS) -->
        <form @submit.prevent="submitNormal" class="p-5 rounded-2xl border border-gray-200 bg-white shadow-sm space-y-4">
          
          <!-- EMAIL / USERNAME -->
          <div>
            <Label for="email" class="text-xs font-semibold text-gray-700">Email atau Akun</Label>
            <Input
              id="email"
              type="text"
              v-model="form.email"
              required
              placeholder="nama@email.com atau username"
              class="mt-1"
            />
            <InputError :message="form.errors.email" />
          </div>

          <!-- PASSWORD -->
          <div>
            <Label for="password" class="text-xs font-semibold text-gray-700">Password</Label>
            <Input
              id="password"
              type="password"
              v-model="form.password"
              required
              placeholder="••••••••"
              class="mt-1"
            />
            <InputError :message="form.errors.password" />
          </div>

          <!-- CAPTCHA -->
          <div class="bg-emerald-50/70 p-3 rounded-xl border border-emerald-100">
            <div class="flex items-center justify-between mb-2">
              <Label for="captcha" class="text-xs font-semibold text-emerald-900">
                Verifikasi Keamanan (Captcha)
              </Label>
              <button
                type="button"
                @click="fetchCaptcha"
                class="text-xs text-emerald-700 hover:underline flex items-center gap-1"
                title="Ganti Soal Captcha"
              >
                🔄 Acak Soal
              </button>
            </div>

            <div class="flex items-center gap-3">
              <div class="px-3 py-2 bg-emerald-600 text-white font-mono font-bold rounded-lg text-sm tracking-wide select-none">
                {{ captchaQuestion }}
              </div>
              <Input
                id="captcha"
                type="text"
                v-model="form.captcha"
                required
                placeholder="Hasil"
                class="w-full bg-white font-mono"
                autocomplete="off"
              />
            </div>
            <InputError :message="form.errors.captcha" />
          </div>

          <!-- SUBMIT BUTTON -->
          <Button
            type="submit"
            class="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-semibold py-4 rounded-xl"
            :disabled="form.processing"
          >
            <span v-if="form.processing">Memproses...</span>
            <span v-else>Masuk ke Akun</span>
          </Button>

        </form>

        <!-- DIVIDER -->
        <div class="relative my-6 flex items-center justify-center">
          <div class="border-t border-gray-200 w-full"></div>
          <span class="bg-white px-3 text-xs text-gray-400 uppercase tracking-wider">atau</span>
        </div>

        <!-- GOOGLE LOGIN BUTTON (DI BAWAH) -->
        <div class="p-1 rounded-2xl border border-gray-100 bg-slate-50 shadow-sm">
          <Button
            type="button"
            variant="outline"
            class="w-full flex items-center justify-center gap-3 text-base py-4 rounded-xl border-gray-200 bg-white hover:bg-gray-50 text-gray-700 font-medium shadow-sm"
            @click="redirectGoogle"
          >
            <svg class="h-5 w-5" viewBox="0 0 533.5 544.3">
              <path fill="#4285f4" d="M533.5 278.4c0-17.4-1.6-34.1-4.6-50.4H272.1v95.4h147c-6.3 34.3-25 63.4-53.4 83v68h86.4c50.6-46.6 81.4-115.3 81.4-196z"/>
              <path fill="#34a853" d="M272.1 544.3c72.4 0 133.1-23.9 177.5-64.9l-86.4-68c-24 16.1-54.7 25.6-91.1 25.6-69.9 0-129.1-47.2-150.4-110.7h-89.5v69.5c44.2 87.3 135.6 148.5 239.9 148.5z"/>
              <path fill="#fbbc04" d="M121.7 326.3c-10.9-32.8-10.9-68.2 0-101l-89.5-69.5c-39.1 77.9-39.1 162.6 0 240.5z"/>
              <path fill="#ea4335" d="M272.1 107.7c38.6 0 73.2 13.3 100.5 39.5l75.4-75.4C405.2 24.6 344.5 0 272.1 0 167.8 0 76.3 61.2 32.1 148.5l89.6 69.5c21.3-63.5 80.5-110.7 150.4-110.7z"/>
            </svg>
            Masuk dengan Akun Google
          </Button>
        </div>

        <!-- FOOTER NOTE -->
        <p class="text-xs text-gray-400 mt-6 text-center">
        <!-- GITHUB SOURCE CODE LINK -->
        <div class="mt-4 text-center">
          <a
            href="https://github.com/Forum-TIPD-PTKIN/amira"
            target="_blank"
            rel="noopener noreferrer"
            class="inline-flex items-center justify-center gap-2 px-4 py-2.5 text-xs font-semibold text-slate-700 bg-slate-100 hover:bg-slate-200 border border-slate-300 rounded-xl transition-all shadow-sm w-full"
          >
            <svg height="16" width="16" viewBox="0 0 16 16" fill="currentColor"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path></svg>
            Download Source Code di GitHub
          </a>
        </div>
          AMIRA © 2026 • PUSTIPADA UIN Sumatera Utara
        </p>

      </div>
    </div>

  </div>
</template>

<style>
@keyframes gradientMove {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.bg-gradient-animate {
  background: linear-gradient(
    -45deg,
    #059669,
    #10b981,
    #34d399,
    #14b8a6,
    #0ea5e9,
    #6366f1
  );

  background-size: 400% 400%;
  animation: gradientMove 16s ease infinite;
}
</style>
