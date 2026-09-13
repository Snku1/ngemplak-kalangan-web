<template>
  <div class="min-h-screen bg-[#F8FAFC] text-[#1E293B] font-sans selection:bg-[#0D6847] selection:text-white antialiased">

    <!-- HEADER / NAVIGATION (Hidden when on Admin Page) -->
    <header
      v-if="!isAdminPage"
      :class="[
        isScrolled
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
              :class="isScrolled
                ? 'bg-[#0D6847]/10 border-[#0D6847]/20'
                : 'bg-white/15 border-white/25'"
              class="w-10 h-10 rounded-full flex items-center justify-center border group-hover:scale-105 transition-transform duration-300"
            >
              <svg
                :class="isScrolled ? 'text-[#0D6847]' : 'text-white'"
                xmlns="http://www.w3.org/2000/svg"
                class="w-6 h-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                stroke-width="2"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m0-12.728l.707.707m12.728 12.728l-.707.707M12 8a4 4 0 100 8 4 4 0 000-8z" />
              </svg>
            </div>
            <div>
              <h1
                :class="isScrolled ? 'text-gray-900' : 'text-white'"
                class="text-base font-bold leading-tight tracking-tight transition-colors"
              >
                Ngemplak Kalangan
              </h1>
              <p
                :class="isScrolled ? 'text-gray-500' : 'text-white/70'"
                class="text-[10px] font-medium uppercase tracking-widest transition-colors"
              >
                INDONESIA
              </p>
            </div>
          </div>

          <!-- Navigation Links -->
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
          </nav>

          <!-- Action Buttons -->
          <div class="flex items-center gap-3">
            <!-- Search -->
            <button
              :class="isScrolled
                ? 'text-gray-500 hover:text-[#0D6847] hover:bg-gray-50'
                : 'text-white/80 hover:text-white hover:bg-white/10'"
              class="p-2.5 rounded-full transition-colors"
              aria-label="Cari"
            >
              <SearchIcon class="w-5 h-5" />
            </button>

            <!-- Panel Admin Button -->
            <button
              @click="navigateTo('admin')"
              :class="isScrolled
                ? 'bg-emerald-50 hover:bg-emerald-100 text-[#0D6847] border-emerald-200'
                : 'bg-white/15 hover:bg-white/25 text-white border-white/25'"
              class="flex items-center gap-1.5 px-3.5 py-2 border text-xs font-bold rounded-full transition-all duration-200 active:scale-95 cursor-pointer"
              title="Panel Pengelolaan Website Desa"
            >
              <ShieldLockIcon class="w-4 h-4" />
              <span>Panel Admin</span>
            </button>
          </div>
        </div>
      </div>
    </header>

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
              <div class="w-11 h-11 rounded-full bg-white/15 border border-white/25 flex items-center justify-center font-extrabold text-white text-sm group-hover:scale-105 transition-transform">
                NK
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
              <li>
                <a href="#" @click.prevent="navigateTo('profil')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">
                  Profil Dusun
                </a>
              </li>
              <li>
                <a href="#" @click.prevent="navigateTo('profil')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">
                  Potensi & Wisata
                </a>
              </li>
              <li>
                <a href="#" @click.prevent="navigateTo('produk')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">
                  Direktori UMKM
                </a>
              </li>
              <li>
                <a href="#" @click.prevent="navigateTo('galeri')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">
                  Galeri
                </a>
              </li>
              <li>
                <a href="#" @click.prevent="navigateTo('informasi')" class="text-sm text-emerald-50/90 hover:text-white transition-colors">
                  Berita
                </a>
              </li>
            </ul>
          </div>

          <!-- Kolom 3: Kontak -->
          <div class="md:col-span-4 space-y-4">
            <h3 class="text-base font-extrabold text-white">Kontak</h3>
            <ul class="space-y-3.5">
              <!-- Alamat -->
              <li class="flex items-start gap-3 text-sm text-emerald-50/90">
                <MapPinIcon class="w-4 h-4 text-emerald-200 shrink-0 mt-1" />
                <span class="leading-relaxed">
                  {{ store.padukuhanProfile?.alamat_kantor || 'Kantor Padukuhan Ngemplak Kalangan, Kecamatan Kalasan, Kabupaten Sleman, D.I. Yogyakarta' }}
                </span>
              </li>
              <!-- Telepon -->
              <li class="flex items-center gap-3 text-sm text-emerald-50/90">
                <PhoneIcon class="w-4 h-4 text-emerald-200 shrink-0" />
                <a :href="`tel:${(store.padukuhanProfile?.telepon || '').replace(/[^0-9]/g, '')}`" class="hover:text-white transition-colors">
                  {{ store.padukuhanProfile?.telepon || '(0274) 555-8123' }}
                </a>
              </li>
              <!-- Email -->
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

        <!-- Bottom Bar: Copyright & Credit -->
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

  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import {
  Search as SearchIcon,
  LogIn as LogInIcon,
  MapPin as MapPinIcon,
  Globe as GlobeIcon,
  Facebook as FacebookIcon,
  Instagram as InstagramIcon,
  Youtube as YoutubeIcon,
  Mail as MailIcon,
  Phone as PhoneIcon,
  ExternalLink as ExternalLinkIcon,
  ShieldCheck as ShieldLockIcon
} from 'lucide-vue-next';

import BerandaView from './components/BerandaView.vue';
import ProfilView from './components/ProfilView.vue';
import InformasiView from './components/InformasiView.vue';
import GaleriView from './components/GaleriView.vue';
import ProdukView from './components/ProdukView.vue';
import TentangKamiView from './components/TentangKamiView.vue';
import AdminLoginView from './components/admin/AdminLoginView.vue';
import AdminDashboardView from './components/admin/AdminDashboardView.vue';

import { store } from './store';

// Navigation State
const currentPage = ref('beranda');

const isAdminPage = computed(() => {
  return currentPage.value === 'admin-login' || currentPage.value === 'admin-dashboard';
});

// Nav links (dengan active pill)
const navLinks = [
  { page: 'beranda', label: 'Beranda' },
  { page: 'profil', label: 'Profil' },
  { page: 'informasi', label: 'Informasi' },
  { page: 'galeri', label: 'Galeri' },
  { page: 'produk', label: 'UMKM Padukuhan' },
  { page: 'tentang-kami', label: 'Tentang Kami' }
];

// Scroll detection — navbar jadi solid saat di-scroll
const isScrolled = ref(false);

const handleScroll = () => {
  isScrolled.value = window.scrollY > 40;
};

onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true });
  handleScroll();
  store.initData();
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});

// Active view mapping
const activeComponent = computed(() => {
  if (currentPage.value === 'admin-login') return AdminLoginView;
  if (currentPage.value === 'admin-dashboard') return AdminDashboardView;
  if (currentPage.value === 'profil') return ProfilView;
  if (currentPage.value === 'informasi') return InformasiView;
  if (currentPage.value === 'galeri') return GaleriView;
  if (currentPage.value === 'produk') return ProdukView;
  if (currentPage.value === 'tentang-kami') return TentangKamiView;
  return BerandaView;
});

// Navigate helper
const navigateTo = (page) => {
  if (page === 'admin') {
    if (store.isAuthenticated) {
      currentPage.value = 'admin-dashboard';
    } else {
      currentPage.value = 'admin-login';
    }
  } else {
    currentPage.value = page;
  }
  window.scrollTo({ top: 0, behavior: 'smooth' });
};
</script>

<style>
/* Page transition styles */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

@keyframes pulse-slow {
  0%, 100% {
    opacity: 0.7;
    transform: scale(1.05);
  }
  50% {
    opacity: 0.78;
    transform: scale(1.07);
  }
}

.animate-pulse-slow {
  animation: pulse-slow 8s ease-in-out infinite;
}
</style>