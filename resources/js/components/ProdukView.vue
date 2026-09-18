<template>
  <div class="bg-[#F8FAFC]">
    <!-- HERO SECTION -->
    <section class="relative bg-gradient-to-b from-[#0B5439] via-[#0D6847] to-[#09472F] text-white py-16 md:py-24 overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#fff_1px,transparent_1px)] [background-size:24px_24px] pointer-events-none"></div>

      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div class="max-w-3xl">
          <h1 class="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight leading-tight mb-5">
            UMKM Unggulan <br class="hidden sm:inline" />
            <span class="text-emerald-200">Padukuhan Ngemplak Kalangan</span>
          </h1>
          <p class="text-sm md:text-base text-emerald-100/90 leading-relaxed mb-8 max-w-2xl">
            Dukung pertumbuhan ekonomi lokal dengan mendukung UMKM warga Padukuhan. Mulai dari kuliner, kerajinan tangan, hingga jasa kreatif warga kami.
          </p>
        </div>
      </div>
    </section>

    <!-- KATALOG UMKM -->
    <section class="py-12 md:py-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header Controls -->
        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-[#0D6847]/10 flex items-center justify-center text-[#0D6847]">
              <ShoppingBagIcon class="w-5 h-5" />
            </div>
            <div>
              <h2 class="text-2xl font-bold text-gray-900 leading-tight">Direktori UMKM</h2>
              <p class="text-xs text-gray-500 font-medium">Menampilkan {{ filteredUmkm.length }} UMKM warga</p>
            </div>
          </div>

          <div class="flex flex-wrap items-center gap-3">
            <div class="relative min-w-[240px] sm:min-w-[280px] flex-1 sm:flex-initial">
              <SearchIcon class="w-4 h-4 text-gray-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
              <input
                v-model="searchQuery"
                type="text"
                placeholder="Cari UMKM atau penjual..."
                class="w-full pl-10 pr-4 py-2.5 bg-white border border-gray-200 rounded-xl text-xs sm:text-sm text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:ring-2 focus:ring-[#0D6847]/20 transition-all shadow-sm"
              />
              <button v-if="searchQuery" @click="searchQuery = ''" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                <XIcon class="w-3.5 h-3.5" />
              </button>
            </div>
          </div>
        </div>

        <!-- Filter Kategori (dari master_kategori tipe 'umkm') -->
        <div class="flex items-center gap-2 overflow-x-auto pb-4 scrollbar-none mb-8">
          <button
            @click="activeKategori = 'Semua'"
            :class="[
              activeKategori === 'Semua'
                ? 'bg-[#0D6847] text-white shadow-md shadow-[#0D6847]/20'
                : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-50 hover:text-gray-900'
            ]"
            class="px-5 py-2.5 rounded-xl text-xs font-semibold whitespace-nowrap transition-all duration-200 active:scale-95 cursor-pointer"
          >
            Semua
          </button>
          <button
            v-for="cat in kategoriFilters"
            :key="cat.id"
            @click="activeKategori = cat.nama"
            :class="[
              activeKategori === cat.nama
                ? 'bg-[#0D6847] text-white shadow-md shadow-[#0D6847]/20'
                : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-50 hover:text-gray-900'
            ]"
            class="px-5 py-2.5 rounded-xl text-xs font-semibold whitespace-nowrap transition-all duration-200 active:scale-95 cursor-pointer"
          >
            {{ cat.nama }}
          </button>
        </div>

        <!-- UMKM CARDS GRID -->
        <div v-if="filteredUmkm.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div
            v-for="item in filteredUmkm"
            :key="item.id"
            @click="openDetailModal(item)"
            class="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 flex flex-col group cursor-pointer border border-transparent hover:border-emerald-200"
          >
            <div class="relative aspect-[4/3] bg-gray-100 overflow-hidden">
              <img :src="item.image" :alt="item.name" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" @error="handleImageFallback($event)" />
            </div>

            <div class="p-5 flex-1 flex flex-col">
              <span :class="getKategoriClass()" class="inline-block w-fit px-4 py-1.5 text-[11px] font-extrabold rounded-full uppercase tracking-widest mb-3">
                {{ item.kategori }}
              </span>

              <h3 class="text-base font-extrabold text-[#0F2D3F] leading-snug mb-1.5 group-hover:text-[#0D6847] transition-colors line-clamp-1">
                {{ item.name }}
              </h3>

              <p class="text-xs text-gray-500 leading-relaxed line-clamp-2 mb-4 flex-1">
                {{ item.alamat_lokasi || 'Padukuhan Ngemplak Kalangan' }}
              </p>

              <button class="text-xs font-extrabold text-[#0D6847] hover:underline text-left mb-3 flex items-center gap-1 cursor-pointer">
                <span>Lihat Detail</span>
              </button>

              <a
                :href="getWhatsAppUrl(item)"
                target="_blank"
                @click.stop
                class="w-full flex items-center justify-center gap-2 px-4 py-3 bg-[#1F7A3F] hover:bg-[#186030] text-white text-xs font-bold rounded-xl shadow-sm transition-all duration-200 active:scale-95 cursor-pointer"
              >
                <MessageSquareIcon class="w-4 h-4" />
                <span>WhatsApp</span>
              </a>
            </div>
          </div>
        </div>

        <!-- Empty State -->
        <div v-else class="bg-white rounded-2xl p-12 text-center max-w-lg mx-auto my-8 shadow-sm">
          <div class="w-16 h-16 rounded-full bg-gray-100 text-gray-400 flex items-center justify-center mx-auto mb-4">
            <SearchIcon class="w-8 h-8" />
          </div>
          <h3 class="text-lg font-bold text-gray-800 mb-1">UMKM Tidak Ditemukan</h3>
          <p class="text-xs text-gray-500 mb-6">Tidak ada UMKM yang sesuai dengan pencarian atau filter yang Anda pilih.</p>
          <button @click="resetFilters" class="px-5 py-2.5 bg-[#0D6847] text-white text-xs font-bold rounded-xl hover:bg-[#0A5238] transition-colors">
            Reset Filter
          </button>
        </div>

      </div>
    </section>

    <!-- BUTUH BANTUAN -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
          <div class="lg:col-span-5 space-y-6">
            <div>
              <span class="text-xs font-bold text-[#0D6847] uppercase tracking-widest">Bantuan &amp; Informasi</span>
              <h2 class="text-3xl font-extrabold text-gray-900 tracking-tight mt-1 mb-4">Butuh Bantuan?</h2>
              <p class="text-xs sm:text-sm text-gray-600 leading-relaxed mb-6">
                Jika Anda memiliki pertanyaan mengenai UMKM, sistem pemesanan, atau ingin mendaftarkan usaha Anda, jangan ragu untuk menghubungi tim pengelola informasi kami.
              </p>
            </div>
          </div>

          <div class="lg:col-span-7">
            <div class="bg-white rounded-3xl p-6 sm:p-8 shadow-lg">
              <h3 class="text-xl font-bold text-gray-900 mb-6 pb-3 border-b border-gray-100 flex items-center gap-2">
                <MessageSquareIcon class="w-5 h-5 text-[#0D6847]" />
                <span>Hubungi Kami</span>
              </h3>

              <form @submit.prevent="submitContactForm" class="space-y-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1.5">Nama Lengkap</label>
                    <input v-model="contactForm.name" type="text" required placeholder="Masukkan nama Anda" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all" />
                  </div>
                  <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1.5">No. WhatsApp / HP</label>
                    <input v-model="contactForm.phone" type="text" required placeholder="08xxxxxxxxxx" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all" />
                  </div>
                </div>

                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1.5">Email (Opsional)</label>
                  <input v-model="contactForm.email" type="email" placeholder="nama@email.com" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all" />
                </div>

                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1.5">Pesan atau Pertanyaan</label>
                  <textarea v-model="contactForm.message" rows="4" required placeholder="Tuliskan pesan..." class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all"></textarea>
                </div>

                <button type="submit" :disabled="isSubmittingForm" class="w-full py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-all duration-200 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50">
                  <SendIcon v-if="!isSubmittingForm" class="w-4 h-4" />
                  <span>{{ isSubmittingForm ? 'Mengirim Pesan...' : 'Kirim Pesan' }}</span>
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- UMKM DETAIL MODAL — dengan FULLSCREEN + Warna Hijau Gelap     -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="selectedUmkm"
        id="umkm-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="closeDetail"
      >

        <!-- ============================================ -->
        <!-- FULLSCREEN MODE                              -->
        <!-- ============================================ -->
        <div v-if="isFullscreen" class="relative w-full h-full flex items-center justify-center">

          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentUmkmImageIndex + 1 }} / {{ umkmImages.length }}
          </div>

          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button @click.stop="toggleFullscreen" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button @click.stop="closeDetail" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <img :src="activeUmkmImage" :alt="selectedUmkm.name" class="max-w-full max-h-full object-contain" />

          <template v-if="umkmImages.length > 1">
            <button @click.stop="prevUmkmImage" class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center z-20 cursor-pointer">
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button @click.stop="nextUmkmImage" class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center z-20 cursor-pointer">
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>

          <div v-if="umkmImages.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20">
            <button v-for="(img, idx) in umkmImages" :key="idx" @click.stop="currentUmkmImageIndex = idx"
              :class="currentUmkmImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer">
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>

        </div>

        <!-- ============================================ -->
        <!-- NORMAL MODE                                  -->
        <!-- ============================================ -->
        <div v-else class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl flex flex-col">

          <!-- Foto -->
          <div class="relative bg-gray-900 shrink-0">
            <div class="relative aspect-[16/10] overflow-hidden">
              <img :src="activeUmkmImage" :alt="selectedUmkm.name" class="w-full h-full object-cover" @error="handleImageFallback($event)" />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-60"></div>

              <button @click="closeDetail" class="absolute top-4 right-4 z-20 w-9 h-9 rounded-full bg-black/55 hover:bg-black/75 text-white flex items-center justify-center cursor-pointer">
                <XIcon class="w-5 h-5" />
              </button>

              <template v-if="umkmImages.length > 1">
                <button @click.stop="prevUmkmImage" class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronLeftIcon class="w-5 h-5" />
                </button>
                <button @click.stop="nextUmkmImage" class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronRightIcon class="w-5 h-5" />
                </button>
              </template>

              <!-- Counter kiri bawah -->
              <span v-if="umkmImages.length > 1" class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10">
                {{ currentUmkmImageIndex + 1 }} / {{ umkmImages.length }}
              </span>

              <!-- Fullscreen kanan bawah -->
              <button @click.stop="toggleFullscreen" class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer z-10" title="Tampilkan Fullscreen">
                <MaximizeIcon class="w-4 h-4" />
              </button>

              <span :class="getKategoriClass()" class="absolute top-4 left-4 text-[11px] font-extrabold px-4 py-1.5 rounded-full uppercase tracking-widest z-10">
                {{ selectedUmkm.kategori }}
              </span>
            </div>

            <div v-if="umkmImages.length > 1" class="flex items-center gap-2 p-3 bg-black/30 overflow-x-auto">
              <button v-for="(img, idx) in umkmImages" :key="idx" @click="currentUmkmImageIndex = idx"
                :class="currentUmkmImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
                class="relative w-16 h-12 shrink-0 rounded-lg overflow-hidden transition-all cursor-pointer">
                <img :src="img" class="w-full h-full object-cover" />
              </button>
            </div>
          </div>

          <!-- Content -->
          <div class="p-6 sm:p-8 space-y-6">
            <!-- Deskripsi -->
            <div>
              <p class="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
                {{ selectedUmkm.description || 'Tidak ada deskripsi.' }}
              </p>
            </div>

            <!-- Produk — hijau gelap -->
            <div v-if="selectedUmkm.daftar_produk">
              <h4 class="text-base font-extrabold text-[#0A4A34] mb-3 flex items-center gap-2 border-l-4 border-[#0A4A34] pl-3">
                Produk
              </h4>
              <ul class="space-y-1.5">
                <li v-for="(prod, idx) in produkList" :key="idx" class="flex items-start gap-2 text-sm text-gray-700">
                  <span class="text-gray-400 mt-1">•</span>
                  <span>{{ prod }}</span>
                </li>
              </ul>
            </div>

            <!-- Jam Buka — hijau gelap -->
            <div v-if="selectedUmkm.jam_buka">
              <h4 class="text-base font-extrabold text-[#0A4A34] mb-3 flex items-center gap-2 border-l-4 border-[#0A4A34] pl-3">
                Jam Buka
              </h4>
              <p class="text-sm text-gray-700">{{ selectedUmkm.jam_buka }}</p>
            </div>

            <!-- Cara Pesan & Pembayaran — hijau gelap -->
            <div v-if="selectedUmkm.cara_bayar">
              <h4 class="text-base font-extrabold text-[#0A4A34] mb-3 flex items-center gap-2 border-l-4 border-[#0A4A34] pl-3">
                Cara Pesan &amp; Pembayaran
              </h4>
              <p class="text-sm text-gray-700 mb-2">Hubungi melalui WhatsApp</p>
              <p class="text-sm text-gray-700">Menerima pembayaran {{ selectedUmkm.cara_bayar }}.</p>
            </div>

            <!-- Lokasi -->
            <div v-if="selectedUmkm.alamat_lokasi || selectedUmkm.maps_lokasi" class="border border-gray-200 rounded-2xl p-4">
              <div class="flex items-start gap-3">
                <div class="w-6 h-6 rounded-full bg-emerald-50 text-[#0D6847] flex items-center justify-center shrink-0 mt-0.5">
                  <MapPinIcon class="w-3.5 h-3.5" />
                </div>
                <div class="flex-1">
                  <h5 class="text-sm font-extrabold text-gray-900 mb-1">Lokasi</h5>
                  <p class="text-xs text-gray-500 mb-1">{{ selectedUmkm.alamat_lokasi || '-' }}</p>
                  <a v-if="selectedUmkm.maps_lokasi" :href="selectedUmkm.maps_lokasi" target="_blank" class="text-xs font-bold text-[#1B8A9C] hover:underline inline-flex items-center gap-1">
                    <span>Buka di Google Maps</span>
                    <ArrowRightIcon class="w-3 h-3" />
                  </a>
                </div>
              </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex items-center gap-3 pt-2">
              <a :href="getWhatsAppUrl(selectedUmkm)" target="_blank" class="flex-1 flex items-center justify-center gap-2 px-6 py-3.5 bg-[#1F7A3F] hover:bg-[#186030] text-white text-xs sm:text-sm font-bold rounded-xl shadow-md transition-all cursor-pointer">
                <MessageSquareIcon class="w-4 h-4" />
                <span>Hubungi via WhatsApp</span>
              </a>
              <button @click="copyShareLink(selectedUmkm)" class="p-3.5 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-xl transition-colors cursor-pointer" title="Bagikan">
                <Share2Icon class="w-5 h-5" />
              </button>
            </div>
          </div>
        </div>

      </div>
    </transition>

    <!-- TOAST -->
    <div v-if="toastMessage" class="fixed bottom-6 right-6 z-50 bg-gray-900 text-white px-5 py-3.5 rounded-2xl shadow-2xl flex items-center gap-3">
      <CheckCircle2Icon class="w-5 h-5 text-emerald-400 shrink-0" />
      <span class="text-xs font-semibold">{{ toastMessage }}</span>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import {
  ShoppingBag as ShoppingBagIcon,
  Search as SearchIcon,
  X as XIcon,
  ChevronLeft as ChevronLeftIcon,
  ChevronRight as ChevronRightIcon,
  MessageSquare as MessageSquareIcon,
  Send as SendIcon,
  CheckCircle2 as CheckCircle2Icon,
  Share2 as Share2Icon,
  MapPin as MapPinIcon,
  ArrowRight as ArrowRightIcon,
  Maximize as MaximizeIcon,
  Minimize as MinimizeIcon
} from 'lucide-vue-next';

import { store } from '../store';

// States
const activeKategori = ref('Semua');
const searchQuery = ref('');
const selectedUmkm = ref(null);
const currentUmkmImageIndex = ref(0);
const toastMessage = ref('');
const isSubmittingForm = ref(false);
const isFullscreen = ref(false);

const contactForm = ref({ name: '', phone: '', email: '', message: '' });

// Kategori dari master_kategori (tipe 'umkm')
const kategoriFilters = computed(() => store.categoriesByTipe('umkm'));

// Daftar produk (dari daftar_produk, dipisah per baris)
const produkList = computed(() => {
  if (!selectedUmkm.value?.daftar_produk) return [];
  return selectedUmkm.value.daftar_produk
    .split('\n')
    .map(s => s.trim())
    .filter(Boolean);
});

// Daftar foto UMKM
const umkmImages = computed(() => {
  if (!selectedUmkm.value) return [];
  const list = [];
  if (selectedUmkm.value.image) list.push(selectedUmkm.value.image);
  if (Array.isArray(selectedUmkm.value.images)) {
    selectedUmkm.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

const activeUmkmImage = computed(() => umkmImages.value[currentUmkmImageIndex.value] || '/images/hero-bg.png');

// Filtered UMKM
const filteredUmkm = computed(() => {
  return store.umkms.filter(item => {
    if (activeKategori.value !== 'Semua' && item.kategori !== activeKategori.value) return false;
    if (searchQuery.value.trim()) {
      const q = searchQuery.value.toLowerCase();
      return (item.name || '').toLowerCase().includes(q) ||
             (item.nama_penjual || '').toLowerCase().includes(q) ||
             (item.kategori || '').toLowerCase().includes(q) ||
             (item.description || '').toLowerCase().includes(q);
    }
    return true;
  });
});

// Helpers
const getKategoriClass = () => {
  // Semua kategori pakai style seragam: hijau gelap elegan
  return 'bg-[#0A4A34] text-white shadow-md shadow-emerald-900/20';
};

const getWhatsAppUrl = (item) => {
  const phone = (item.nomor_whatsapp || item.sellerPhone || '').replace(/[^0-9]/g, '') || '6281234567890';
  const text = encodeURIComponent(
    `Halo, saya tertarik dengan UMKM "${item.name}". Mohon informasi lebih lanjut. Terima kasih!`
  );
  return `https://wa.me/${phone}?text=${text}`;
};

const openDetailModal = (item) => {
  selectedUmkm.value = item;
  currentUmkmImageIndex.value = 0;
  isFullscreen.value = false;
};

const closeDetail = async () => {
  if (document.fullscreenElement) {
    try { await document.exitFullscreen(); } catch (e) {}
  }
  isFullscreen.value = false;
  selectedUmkm.value = null;
};

const prevUmkmImage = () => {
  if (currentUmkmImageIndex.value > 0) currentUmkmImageIndex.value--;
  else currentUmkmImageIndex.value = umkmImages.value.length - 1;
};

const nextUmkmImage = () => {
  if (currentUmkmImageIndex.value < umkmImages.value.length - 1) currentUmkmImageIndex.value++;
  else currentUmkmImageIndex.value = 0;
};

const toggleFullscreen = async () => {
  const el = document.getElementById('umkm-lightbox');
  if (!el) return;
  try {
    if (!document.fullscreenElement) {
      await el.requestFullscreen();
      isFullscreen.value = true;
    } else {
      await document.exitFullscreen();
      isFullscreen.value = false;
    }
  } catch (err) { console.warn(err); }
};

const handleFullscreenChange = () => {
  isFullscreen.value = !!document.fullscreenElement;
};

onMounted(() => {
  document.addEventListener('fullscreenchange', handleFullscreenChange);
});

onUnmounted(() => {
  document.removeEventListener('fullscreenchange', handleFullscreenChange);
});

const resetFilters = () => {
  activeKategori.value = 'Semua';
  searchQuery.value = '';
};

const handleImageFallback = (event) => {
  event.target.src = '/images/hero-bg.png';
};

const triggerToast = (msg) => {
  toastMessage.value = msg;
  setTimeout(() => { toastMessage.value = ''; }, 3500);
};

const copyShareLink = (item) => {
  navigator.clipboard.writeText(window.location.href);
  triggerToast(`Tautan UMKM "${item.name}" berhasil disalin!`);
};

const submitContactForm = () => {
  isSubmittingForm.value = true;
  store.addInbox({
    name: contactForm.value.name,
    phone: contactForm.value.phone,
    email: contactForm.value.email,
    message: contactForm.value.message
  });
  setTimeout(() => {
    isSubmittingForm.value = false;
    triggerToast('Pesan Anda berhasil dikirim! Tim pengelola akan segera membalas.');
    contactForm.value = { name: '', phone: '', email: '', message: '' };
  }, 600);
};
</script>

<style scoped>
.scrollbar-none::-webkit-scrollbar { display: none; }
.scrollbar-none { -ms-overflow-style: none; scrollbar-width: none; }

.fade-enter-active, .fade-leave-active { transition: opacity 0.25s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>