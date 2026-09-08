<template>
  <div class="min-h-screen bg-[#F8FAFC] text-[#1E293B] font-sans selection:bg-[#0D6847] selection:text-white antialiased">
    
    <!-- HEADER / NAVIGATION (Hidden when on Admin Page) -->
    <header v-if="!isAdminPage" class="sticky top-0 z-50 bg-white/95 backdrop-blur-md border-b border-gray-100 shadow-sm transition-all duration-300">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
          <!-- Logo & Brand -->
          <div @click="navigateTo('beranda')" class="flex items-center gap-3 cursor-pointer group">
            <div class="w-10 h-10 rounded-full bg-[#0D6847]/10 flex items-center justify-center border border-[#0D6847]/20 group-hover:scale-105 transition-transform duration-300">
              <!-- Simple custom SVG icon representing leaf/hill -->
              <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-[#0D6847]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m0-12.728l.707.707m12.728 12.728l-.707.707M12 8a4 4 0 100 8 4 4 0 000-8z" />
              </svg>
            </div>
            <div>
              <h1 class="text-base font-bold text-gray-900 leading-tight tracking-tight">Ngemplak Kalangan</h1>
              <p class="text-[10px] font-medium text-gray-500 uppercase tracking-widest tracking-widest">INDONESIA</p>
            </div>
          </div>

          <!-- Navigation Links -->
          <nav class="hidden md:flex items-center gap-8">
            <a 
              href="#" 
              @click.prevent="navigateTo('beranda')" 
              :class="currentPage === 'beranda' ? 'text-[#0D6847]' : 'text-gray-600 hover:text-[#0D6847]'"
              class="text-sm font-semibold transition-colors"
            >Beranda</a>
            <a 
              href="#" 
              @click.prevent="navigateTo('profil')" 
              :class="currentPage === 'profil' ? 'text-[#0D6847]' : 'text-gray-600 hover:text-[#0D6847]'"
              class="text-sm font-semibold transition-colors"
            >Profil</a>
            <a 
              href="#" 
              @click.prevent="navigateTo('informasi')" 
              :class="currentPage === 'informasi' ? 'text-[#0D6847]' : 'text-gray-600 hover:text-[#0D6847]'"
              class="text-sm font-semibold transition-colors"
            >Informasi</a>
            <a 
              href="#" 
              @click.prevent="navigateTo('galeri')" 
              :class="currentPage === 'galeri' ? 'text-[#0D6847]' : 'text-gray-600 hover:text-[#0D6847]'"
              class="text-sm font-semibold transition-colors"
            >Galeri</a>
            <a 
              href="#" 
              @click.prevent="navigateTo('produk')" 
              :class="currentPage === 'produk' ? 'text-[#0D6847]' : 'text-gray-600 hover:text-[#0D6847]'"
              class="text-sm font-semibold transition-colors"
            >Produk Padukuhan</a>
            <a 
              href="#" 
              @click.prevent="navigateTo('tentang-kami')" 
              :class="currentPage === 'tentang-kami' ? 'text-[#0D6847]' : 'text-gray-600 hover:text-[#0D6847]'"
              class="text-sm font-semibold transition-colors"
            >Tentang Kami</a>
          </nav>

          <!-- Search & Action Buttons -->
          <div class="flex items-center gap-3">
            <button class="p-2.5 text-gray-500 hover:text-[#0D6847] rounded-full hover:bg-gray-50 transition-colors" aria-label="Cari">
              <SearchIcon class="w-5 h-5" />
            </button>

            <!-- Separate Admin Login Button -->
            <button 
              @click="navigateTo('admin')" 
              class="flex items-center gap-1.5 px-3.5 py-2 bg-emerald-50 hover:bg-emerald-100 text-[#0D6847] border border-emerald-200 text-xs font-bold rounded-full transition-all duration-200 active:scale-95 cursor-pointer shadow-2xs"
              title="Panel Pengelolaan Website Desa"
            >
              <ShieldLockIcon class="w-4 h-4 text-[#0D6847]" />
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
    <footer v-if="!isAdminPage" class="bg-white border-t border-gray-150 pt-16 pb-8">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-10 mb-12">
          <!-- Logo & Address (4 cols) -->
          <div class="lg:col-span-4 space-y-5">
            <div @click="navigateTo('beranda')" class="flex items-center gap-3 cursor-pointer group">
              <div class="w-9 h-9 rounded-full bg-[#0D6847]/10 flex items-center justify-center border border-[#0D6847]/20 group-hover:scale-105 transition-transform duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-[#0D6847]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m0-12.728l.707.707m12.728 12.728l-.707.707M12 8a4 4 0 100 8 4 4 0 000-8z" />
                </svg>
              </div>
              <h2 class="text-base font-bold text-gray-900 leading-tight">Ngemplak Kalangan</h2>
            </div>
            
            <div class="space-y-3.5 text-xs text-gray-500 font-medium">
              <p class="flex items-start gap-2.5 leading-relaxed">
                <MapPinIcon class="w-4 h-4 text-gray-400 shrink-0 mt-0.5" />
                <span>Jl. Utama Desa No. 123, Kec. Kalasan, Kab. Sleman, D.I. Yogyakarta 55571, Indonesia</span>
              </p>
              <p class="flex items-center gap-2.5">
                <PhoneIcon class="w-4 h-4 text-gray-400 shrink-0" />
                <span>(0274) 555-8123</span>
              </p>
              <p class="flex items-center gap-2.5">
                <MailIcon class="w-4 h-4 text-gray-400 shrink-0" />
                <span>admin@ngemplakkalangan.id</span>
              </p>
            </div>
          </div>

          <!-- Tautan Cepat (2 cols) -->
          <div class="lg:col-span-2 space-y-4">
            <h3 class="text-xs font-bold text-gray-950 uppercase tracking-widest">Tautan Cepat</h3>
            <ul class="space-y-2 text-xs text-gray-500 font-semibold">
              <li><a href="#" @click.prevent="navigateTo('beranda')" class="hover:text-[#0D6847] transition-colors">Beranda</a></li>
              <li><a href="#" @click.prevent="navigateTo('profil')" class="hover:text-[#0D6847] transition-colors">Profil Dusun</a></li>
              <li><a href="#" @click.prevent="navigateTo('informasi')" class="hover:text-[#0D6847] transition-colors">Berita & Informasi</a></li>
              <li><a href="#" @click.prevent="navigateTo('produk')" class="hover:text-[#0D6847] transition-colors">Produk Unggulan</a></li>
              <li><a href="#" @click.prevent="navigateTo('galeri')" class="hover:text-[#0D6847] transition-colors">Galeri Dokumentasi</a></li>
              <li><a href="#" @click.prevent="navigateTo('tentang-kami')" class="hover:text-[#0D6847] transition-colors">Tentang Kami</a></li>
            </ul>
          </div>

          <!-- Potensi Dusun (2 cols) -->
          <div class="lg:col-span-2 space-y-4">
            <h3 class="text-xs font-bold text-gray-950 uppercase tracking-widest">Potensi Dusun</h3>
            <ul class="space-y-2 text-xs text-gray-500 font-semibold">
              <li><a href="#" @click.prevent="navigateTo('produk')" class="hover:text-[#0D6847] transition-colors">Kerajinan Anyaman</a></li>
              <li><a href="#" @click.prevent="navigateTo('produk')" class="hover:text-[#0D6847] transition-colors">Batik Tulis Warga</a></li>
              <li><a href="#" @click.prevent="navigateTo('produk')" class="hover:text-[#0D6847] transition-colors">Hasil Pertanian Organik</a></li>
              <li><a href="#" @click.prevent="navigateTo('galeri')" class="hover:text-[#0D6847] transition-colors">Seni Rodat Tradisional</a></li>
              <li><a href="#" @click.prevent="navigateTo('admin')" class="text-[#0D6847] hover:underline font-bold">Panel Admin Desa</a></li>
            </ul>
          </div>

          <!-- Ikuti Kami & Socials (4 cols) -->
          <div class="lg:col-span-4 space-y-4">
            <h3 class="text-xs font-bold text-gray-950 uppercase tracking-widest">Ikuti Kami</h3>
            <div class="flex items-center gap-3">
              <a href="#" class="p-2.5 rounded-lg bg-gray-50 hover:bg-[#0D6847]/10 text-gray-400 hover:text-[#0D6847] border border-gray-150 transition-all active:scale-95" aria-label="Website">
                <GlobeIcon class="w-4 h-4" />
              </a>
              <a href="#" class="p-2.5 rounded-lg bg-gray-50 hover:bg-[#0D6847]/10 text-gray-400 hover:text-[#0D6847] border border-gray-150 transition-all active:scale-95" aria-label="Facebook">
                <FacebookIcon class="w-4 h-4" />
              </a>
              <a href="#" class="p-2.5 rounded-lg bg-gray-50 hover:bg-[#0D6847]/10 text-gray-400 hover:text-[#0D6847] border border-gray-150 transition-all active:scale-95" aria-label="Instagram">
                <InstagramIcon class="w-4 h-4" />
              </a>
              <a href="#" class="p-2.5 rounded-lg bg-gray-50 hover:bg-[#0D6847]/10 text-gray-400 hover:text-[#0D6847] border border-gray-150 transition-all active:scale-95" aria-label="Youtube">
                <YoutubeIcon class="w-4 h-4" />
              </a>
            </div>
            <div class="pt-2">
              <p class="text-[10px] text-gray-400 font-bold uppercase tracking-wider">Domain Resmi</p>
              <a href="https://www.ngemplakkalangan.id" target="_blank" class="text-xs font-bold text-[#0D6847] hover:underline mt-1 inline-flex items-center gap-1.5">
                <span>www.ngemplakkalangan.id</span>
                <ExternalLinkIcon class="w-3.5 h-3.5" />
              </a>
            </div>
          </div>
        </div>

        <!-- Divider & Copyright -->
        <div class="pt-8 border-t border-gray-150 flex flex-col md:flex-row items-center justify-between gap-4">
          <p class="text-[10px] font-bold text-gray-400 uppercase tracking-widest text-center md:text-left">
            © 2026 Padukuhan Digital Indonesia. Seluruh hak cipta dilindungi undang-undang.
          </p>
          <div class="flex items-center gap-6 text-[10px] font-bold text-gray-400 uppercase tracking-widest">
            <a href="#" @click.prevent="navigateTo('admin')" class="text-[#0D6847] hover:underline">Panel Admin</a>
            <a href="#" class="hover:text-gray-600 transition-colors">Kebijakan Privasi</a>
            <a href="#" class="hover:text-gray-600 transition-colors">Syarat & Ketentuan</a>
          </div>
        </div>

      </div>
    </footer>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
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

onMounted(() => {
  store.initData();
});
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
