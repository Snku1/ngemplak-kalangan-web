<template>
  <div class="min-h-screen bg-[#F8FAFC] text-[#1E293B] font-sans selection:bg-[#0D6847] selection:text-white antialiased">

    <!-- HEADER / NAVIGATION (Hidden when on Admin Page) -->
    <header
      v-if="!isAdminPage"
      :class="[
        isScrolled || isMobileMenuOpen
          ? 'bg-white/95 backdrop-blur-md border-b border-gray-100 shadow-sm'
          : 'bg-transparent border-b border-transparent'
      ]"
      class="fixed top-0 left-0 right-0 z-50 transition-all duration-300"
    >
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">

          <!-- Logo & Brand -->
          <div @click="navigateTo('beranda')" class="flex items-center gap-3 cursor-pointer group">
            <div
              :class="isScrolled || isMobileMenuOpen
                ? 'bg-white border-gray-100'
                : 'bg-white/95 border-white/40'"
              class="w-11 h-11 rounded-full flex items-center justify-center border shadow-sm group-hover:scale-105 transition-transform duration-300 overflow-hidden"
            >
              <img
                src="/images/logo1.png"
                alt="Logo Ngemplak Kalangan"
                class="w-9 h-9 object-contain"
              />
            </div>
            <div>
              <h1
                :class="isScrolled || isMobileMenuOpen ? 'text-gray-900' : 'text-white'"
                class="text-base font-bold leading-tight tracking-tight transition-colors"
              >
                Ngemplak Kalangan
              </h1>
              <p
                :class="isScrolled || isMobileMenuOpen ? 'text-gray-500' : 'text-white/70'"
                class="text-[10px] font-medium uppercase tracking-widest transition-colors"
              >
                INDONESIA
              </p>
            </div>
          </div>

          <!-- Desktop Navigation Links -->
          <nav class="hidden md:flex items-center gap-1">
            <a
              v-for="link in navLinks"
              :key="link.page"
              href="#"
              @click.prevent="navigateTo(link.page)"
              :class="[
                currentPage === link.page
                  ? (isScrolled
                      ? 'bg-gray-100 text-gray-900'
                      : 'bg-white/15 text-white')
                  : (isScrolled
                      ? 'text-gray-600 hover:text-[#0D6847] hover:bg-gray-50'
                      : 'text-white/85 hover:text-white hover:bg-white/10')
              ]"
              class="px-4 py-2 rounded-lg text-sm font-semibold transition-all duration-200"
            >
              {{ link.label }}
            </a>

            <!-- Ecolife.walk Button (Desktop only) — diletakkan setelah Kontak -->
            <a
              href="https://ecolifewalk.com/"
              target="_blank"
              rel="noopener"
              class="ml-3 flex items-center gap-2 px-6 py-3 bg-[#0A4A34] hover:bg-[#083828] text-white border border-[#0A4A34] hover:border-[#083828] text-sm font-extrabold rounded-full transition-all duration-200 active:scale-95 cursor-pointer shadow-md hover:shadow-lg tracking-wide"
              title="Kunjungi Ecolife.walk"
            >
              <LeafIcon class="w-4 h-4" />
              <span>ecolife.walk</span>
            </a>
          </nav>

          <!-- Action Buttons -->
          <div class="flex items-center gap-3">
            <!-- Hamburger Menu Button (Mobile only) -->
            <button
              @click="toggleMobileMenu"
              :class="isScrolled || isMobileMenuOpen
                ? 'text-gray-700 hover:bg-gray-100'
                : 'text-white hover:bg-white/10'"
              class="md:hidden p-2.5 rounded-lg transition-colors cursor-pointer"
              aria-label="Menu"
            >
              <MenuIcon v-if="!isMobileMenuOpen" class="w-6 h-6" />
              <XIcon v-else class="w-6 h-6" />
            </button>
          </div>
        </div>
      </div>
    </header>

    <!-- MOBILE MENU OVERLAY -->
    <transition name="overlay">
      <div
        v-if="isMobileMenuOpen && !isAdminPage"
        @click="closeMobileMenu"
        class="md:hidden fixed inset-0 top-20 bg-black/40 z-30"
      ></div>
    </transition>

    <!-- MOBILE MENU DRAWER (slide-in dari kanan) -->
    <transition name="drawer">
      <aside
        v-if="isMobileMenuOpen && !isAdminPage"
        class="md:hidden fixed top-20 right-0 bottom-0 w-80 max-w-[85vw] bg-white shadow-2xl z-40 flex flex-col overflow-hidden"
      >
        <!-- Drawer Header -->
        <div class="px-5 pt-5 pb-3 border-b border-gray-100">
          <p class="text-[10px] font-bold uppercase tracking-widest text-[#0D6847]">Menu Navigasi</p>
          <h2 class="text-lg font-extrabold text-gray-900 leading-tight">Jelajahi Dusun</h2>
        </div>

        <!-- Drawer Nav Links -->
        <nav class="flex-1 overflow-y-auto px-3 py-4 flex flex-col gap-1">
          <a
            v-for="link in navLinks"
            :key="link.page"
            href="#"
            @click.prevent="navigateTo(link.page); closeMobileMenu()"
            :class="[
              currentPage === link.page
                ? 'bg-emerald-50 text-[#0D6847] font-bold'
                : 'text-gray-600 hover:bg-gray-50 hover:text-[#0D6847] font-semibold'
            ]"
            class="px-4 py-3 rounded-xl text-sm transition-all duration-200 flex items-center justify-between group"
          >
            <span>{{ link.label }}</span>
            <svg
              v-if="currentPage === link.page"
              xmlns="http://www.w3.org/2000/svg"
              class="w-4 h-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              stroke-width="2.5"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
            </svg>
          </a>

          <!-- Ecolife.walk Button (Mobile) -->
          <a
            href="https://ecolifewalk.com/"
            target="_blank"
            rel="noopener"
            class="mt-3 flex items-center justify-center gap-2 px-4 py-3 bg-[#0A4A34] hover:bg-[#083828] text-white text-xs font-extrabold rounded-xl transition-all active:scale-95"
          >
            <LeafIcon class="w-4 h-4" />
            <span>Kunjungi ecolife.walk</span>
          </a>
        </nav>

        <!-- Drawer Footer -->
        <div class="px-5 py-4 border-t border-gray-100 bg-gray-50">
          <p class="text-[11px] text-gray-500 leading-relaxed">
            Padukuhan Ngemplak Kalangan<br>
            Trimulyo, Sleman, D.I. Yogyakarta
          </p>
        </div>
      </aside>
    </transition>

    <!-- DYNAMIC ROUTED VIEW -->
    <transition name="fade" mode="out-in">
      <component :is="activeComponent" @navigate="navigateTo" />
    </transition>

    <!-- FOOTER (Hidden when on Admin Page) -->
    <footer v-if="!isAdminPage" class="bg-[#1D4533] text-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-16 pb-8">

        <!-- Top: 3 Kolom -->
        <div class="grid grid-cols-1 md:grid-cols-12 gap-10 md:gap-8 mb-12">

          <!-- Kolom 1: Logo & Deskripsi -->
          <div class="md:col-span-5 space-y-5">
            <div @click="navigateTo('beranda')" class="flex items-center gap-3 cursor-pointer group">
              <div class="w-10 h-10 rounded-full bg-white flex items-center justify-center border shadow-sm overflow-hidden">
                <img src="/images/logo1.png" alt="Logo" class="w-full h-full object-cover" />
              </div>
              <h2 class="text-lg font-extrabold text-white leading-tight tracking-tight">
                {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}
              </h2>
            </div>

            <p class="text-sm text-emerald-50/90 leading-relaxed max-w-sm">
              Situs resmi Padukuhan {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }},
              Kecamatan {{ store.padukuhanProfile?.kecamatan || 'Kalasan' }},
              Kabupaten {{ store.padukuhanProfile?.kabupaten || 'Sleman' }},
              {{ store.padukuhanProfile?.provinsi || 'D.I. Yogyakarta' }}.
            </p>
          </div>

          <!-- Kolom 2: Jelajahi -->
          <div class="md:col-span-3 space-y-4">
            <h3 class="text-base font-extrabold text-white">Jelajahi</h3>
            <ul class="space-y-2.5">
              <li><a href="#" @click.prevent="navigateTo('profil')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">Profil Dusun</a></li>
              <li><a href="#" @click.prevent="navigateTo('potensi')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">Potensi & Wisata</a></li>
              <li><a href="#" @click.prevent="navigateTo('produk')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">Direktori UMKM</a></li>
              <li><a href="#" @click.prevent="navigateTo('galeri')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">Galeri</a></li>
              <li><a href="#" @click.prevent="navigateTo('informasi')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">Berita</a></li>
              <li><a href="#" @click.prevent="navigateTo('kontak')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">Kontak</a></li>
            </ul>
          </div>

          <!-- Kolom 3: Kontak -->
          <div class="md:col-span-4 space-y-4">
            <h3 class="text-base font-extrabold text-white">Kontak</h3>
            <ul class="space-y-3.5">
              <li class="flex items-start gap-3 text-sm text-emerald-50/90">
                <MapPinIcon class="w-4 h-4 text-emerald-200 shrink-0 mt-1" />
                <span class="leading-relaxed">
                  {{ store.padukuhanProfile?.alamat_kantor || 'Kantor Padukuhan Ngemplak Kalangan, Kecamatan Kalasan, Kabupaten Sleman, D.I. Yogyakarta' }}
                </span>
              </li>
              <li class="flex items-center gap-3 text-sm text-emerald-50/90">
                <PhoneIcon class="w-4 h-4 text-emerald-200 shrink-0" />
                <a :href="`tel:${(store.padukuhanProfile?.telepon || '').replace(/[^0-9]/g, '')}`" class="hover:text-white transition-colors">
                  {{ store.padukuhanProfile?.telepon || '(0274) 555-8123' }}
                </a>
              </li>
              <li class="flex items-center gap-3 text-sm text-emerald-50/90">
                <MailIcon class="w-4 h-4 text-emerald-200 shrink-0" />
                <a :href="`mailto:${store.padukuhanProfile?.email || 'admin@ngempakkan.id'}`" class="hover:text-white transition-colors">
                  {{ store.padukuhanProfile?.email || 'admin@ngempakkan.id' }}
                </a>
              </li>
            </ul>
          </div>
        </div>

        <!-- Divider -->
        <div class="border-t border-white/15"></div>

        <!-- Bottom Bar -->
        <div class="pt-6 flex flex-col md:flex-row items-center justify-between gap-3">
          <p class="text-xs text-emerald-50/80 text-center md:text-left">
            © {{ new Date().getFullYear() }} Pemerintah Padukuhan {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}. Seluruh aset terdaftar atas nama padukuhan.
          </p>
          <p class="text-xs text-emerald-50/80 text-center md:text-right">
            Dibuat oleh <span class="text-white font-semibold">Tim IT KKN-M KALANGAN KARSA UNY 2026</span>
          </p>
        </div>

      </div>
    </footer>

    <!-- AUTO LOGOUT WARNING MODAL -->
    <transition name="fade">
      <div
        v-if="showWarning"
        class="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm"
      >
        <div class="bg-white rounded-3xl max-w-sm w-full p-6 text-center shadow-2xl border border-gray-100 space-y-4">
          <div class="w-14 h-14 rounded-2xl bg-amber-50 text-amber-600 flex items-center justify-center mx-auto">
            <AlertTriangleIcon class="w-7 h-7" />
          </div>
          <div>
            <h3 class="text-base font-extrabold text-gray-900">Sesi Akan Berakhir</h3>
            <p class="text-xs text-gray-500 mt-1 leading-relaxed">
              Tidak ada aktivitas terdeteksi. Anda akan keluar otomatis dalam
              <strong class="text-amber-600 font-mono text-base">{{ countdown }}</strong>
              detik.
            </p>
          </div>
          <div class="flex gap-2">
            <button
              @click="stayLoggedIn"
              class="flex-1 py-3 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl cursor-pointer transition-colors"
            >
              Tetap Masuk
            </button>
            <button
              @click="() => { store.logout(); showWarning = false; navigateTo('beranda'); }"
              class="flex-1 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl cursor-pointer transition-colors"
            >
              Logout Sekarang
            </button>
          </div>
        </div>
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import {
  MapPin as MapPinIcon,
  Mail as MailIcon,
  Phone as PhoneIcon,
  Leaf as LeafIcon,
  Menu as MenuIcon,
  X as XIcon,
  AlertTriangle as AlertTriangleIcon   // ← TAMBAH
} from 'lucide-vue-next';

import BerandaView from './components/BerandaView.vue';
import ProfilView from './components/ProfilView.vue';
import InformasiView from './components/InformasiView.vue';
import GaleriView from './components/GaleriView.vue';
import ProdukView from './components/ProdukView.vue';
import PotensiView from './components/PotensiView.vue';
import KontakView from './components/KontakView.vue';
import AdminLoginView from './components/admin/AdminLoginView.vue';
import AdminDashboardView from './components/admin/AdminDashboardView.vue';

import { store } from './store';
import { useAutoLogout } from './composables/useAutoLogout';   // ← TAMBAH

// ============================================
// NAVIGATION STATE
// ============================================
const currentPage = ref('beranda');
const isMobileMenuOpen = ref(false);

// Nav links (TIDAK ADA tombol "Admin" atau "Search")
const navLinks = [
  { page: 'beranda', label: 'Beranda' },
  { page: 'profil', label: 'Profil' },
  { page: 'potensi', label: 'Potensi' },
  { page: 'informasi', label: 'Informasi' },
  { page: 'galeri', label: 'Galeri' },
  { page: 'produk', label: 'UMKM' },
  { page: 'kontak', label: 'Kontak' }
];

// Cek apakah di halaman admin
const isAdminPage = computed(() => {
  return currentPage.value === 'admin-login' || currentPage.value === 'admin-dashboard';
});

// ============================================
// URL ROUTING (/admin)
// ============================================
const getAdminRoute = () => {
  const path = window.location.pathname.toLowerCase().replace(/\/$/, '');
  if (path === '/admin') {
    if (store.isAuthenticated) {
      currentPage.value = 'admin-dashboard';
    } else {
      currentPage.value = 'admin-login';
    }
    return true;
  }
  return false;
};

// Update URL saat pindah ke / keluar dari admin
const syncUrl = (page) => {
  const isAdmin = page === 'admin-login' || page === 'admin-dashboard';
  const currentPath = window.location.pathname.replace(/\/$/, '');

  if (isAdmin) {
    if (currentPath !== '/admin') {
      window.history.pushState({}, '', '/admin');
    }
  } else {
    if (currentPath === '/admin') {
      window.history.pushState({}, '', '/');
    }
  }
};

// Handle browser back/forward
const handlePopState = () => {
  const path = window.location.pathname.toLowerCase().replace(/\/$/, '');
  if (path === '/admin') {
    if (store.isAuthenticated) {
      currentPage.value = 'admin-dashboard';
    } else {
      currentPage.value = 'admin-login';
    }
  } else {
    currentPage.value = 'beranda';
  }
};

// ============================================
// MOBILE MENU
// ============================================
const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
  // Lock scroll body ketika drawer terbuka
  document.body.style.overflow = isMobileMenuOpen.value ? 'hidden' : '';
};

const closeMobileMenu = () => {
  isMobileMenuOpen.value = false;
  document.body.style.overflow = '';
};

// ============================================
// SCROLL DETECTION
// ============================================
const isScrolled = ref(false);

const handleScroll = () => {
  isScrolled.value = window.scrollY > 40;
};

// ============================================
// ACTIVE VIEW MAPPING
// ============================================
const activeComponent = computed(() => {
  if (currentPage.value === 'admin-login') return AdminLoginView;
  if (currentPage.value === 'admin-dashboard') return AdminDashboardView;
  if (currentPage.value === 'profil') return ProfilView;
  if (currentPage.value === 'informasi') return InformasiView;
  if (currentPage.value === 'galeri') return GaleriView;
  if (currentPage.value === 'produk') return ProdukView;
  if (currentPage.value === 'potensi') return PotensiView;
  if (currentPage.value === 'kontak') return KontakView;
  return BerandaView;
});

// ============================================
// NAVIGATE HELPER
// ============================================
const navigateTo = (page) => {
  let targetPage = page;

  // Kalau diarahkan ke admin → cek auth dulu
  if (page === 'admin') {
    targetPage = store.isAuthenticated ? 'admin-dashboard' : 'admin-login';
  }

  currentPage.value = targetPage;
  syncUrl(targetPage);
  closeMobileMenu();

  window.scrollTo({ top: 0, behavior: 'smooth' });
};

// ============================================
// AUTO LOGOUT (Idle Timeout)
// ============================================
const { showWarning, countdown, stayLoggedIn } = useAutoLogout({
  idleMinutes: 30,       // logout total setelah 30 menit idle
  warningMinutes: 2      // muncul warning 2 menit sebelum logout
});

// Validasi token saat pertama load (deteksi server mati / token expired)
onMounted(async () => {
  if (store.isAuthenticated) {
    const valid = await store.validateSession();
    if (!valid) {
      console.warn('[App] Token invalid → force logout');
      store.logout();
      currentPage.value = 'beranda';
      syncUrl('beranda');
    }
  }
});

// ============================================
// LIFECYCLE
// ============================================
onMounted(() => {
  // Cek apakah halaman dibuka di /admin
  getAdminRoute();

  window.addEventListener('scroll', handleScroll, { passive: true });
  window.addEventListener('popstate', handlePopState);

  handleScroll();
  store.initData();
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
  window.removeEventListener('popstate', handlePopState);
  document.body.style.overflow = '';
});
</script>

<style>
/* Page transition */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Mobile drawer slide-in from right */
.drawer-enter-active,
.drawer-leave-active {
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.drawer-enter-from,
.drawer-leave-to {
  transform: translateX(100%);
}
.drawer-enter-to,
.drawer-leave-from {
  transform: translateX(0);
}

/* Overlay fade */
.overlay-enter-active,
.overlay-leave-active {
  transition: opacity 0.25s ease;
}
.overlay-enter-from,
.overlay-leave-to {
  opacity: 0;
}

@keyframes pulse-slow {
  0%, 100% { opacity: 0.7; transform: scale(1.05); }
  50% { opacity: 0.78; transform: scale(1.07); }
}
.animate-pulse-slow {
  animation: pulse-slow 8s ease-in-out infinite;
}
</style>