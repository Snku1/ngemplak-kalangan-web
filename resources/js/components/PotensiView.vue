<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative min-h-[400px] md:min-h-[480px] flex items-center justify-center overflow-hidden bg-gray-900 text-white">
      <div class="absolute inset-0 z-0">
        <img src="/images/hero-bg.png" alt="Latar Belakang Potensi" class="w-full h-full object-cover object-center opacity-60 scale-105" @error="handleImageError($event, 'hero-bg')" />
        <div class="absolute inset-0 bg-gradient-to-b from-[#0D6847]/90 via-[#0D6847]/75 to-gray-950/85"></div>
      </div>
      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center py-20">
        <h1 class="text-3xl md:text-5xl font-extrabold tracking-tight leading-tight mb-4 text-white">
          Potensi &amp; Keunggulan Padukuhan
        </h1>
        <p class="text-sm md:text-base text-emerald-100 max-w-2xl mx-auto leading-relaxed font-medium">
          Menjelajahi kekayaan alam, budaya, dan potensi ekonomi yang dimiliki Padukuhan Ngemplak Kalangan untuk kesejahteraan bersama.
        </p>
      </div>
    </section>

    <!-- FILTER KATEGORI -->
    <section class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 pt-12">
      <div class="flex flex-wrap items-center justify-center gap-2 mb-10">
        <button v-for="cat in filterOptions" :key="cat.value" @click="activeFilter = cat.value"
          :class="activeFilter === cat.value ? 'bg-[#0D6847] text-white shadow-md' : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-50 hover:text-gray-900'"
          class="px-5 py-2.5 rounded-xl text-xs font-bold transition-all cursor-pointer">
          {{ cat.label }}
        </button>
      </div>
    </section>

    <!-- LIST POTENSI -->
    <section class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 pb-16">
      <div v-if="filteredPotensi.length > 0" class="space-y-6 md:space-y-8">
        <div v-for="potensi in filteredPotensi" :key="potensi.id" @click="openDetail(potensi)"
          class="bg-white rounded-3xl overflow-hidden shadow-sm hover:shadow-xl border border-gray-100 hover:border-emerald-200 transition-all duration-300 group cursor-pointer flex flex-col md:flex-row">
          <div class="relative md:w-2/5 lg:w-1/2 aspect-[4/3] md:aspect-auto md:min-h-[300px] bg-gray-100 overflow-hidden shrink-0">
            <img :src="potensi.foto_url || '/images/hero-bg.png'" :alt="potensi.nama" class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" @error="handleImageError($event, 'potensi')" />
            <!-- Badge jumlah foto -->
            <div v-if="potensi.images && potensi.images.length > 1" class="absolute bottom-3 right-3 px-2.5 py-1 bg-black/60 backdrop-blur-sm text-white text-[10px] font-bold rounded-full flex items-center gap-1">
              <CameraIcon class="w-3 h-3" />
              <span>{{ potensi.images.length }}</span>
            </div>
          </div>

          <div class="md:w-3/5 lg:w-1/2 p-6 md:p-8 flex flex-col justify-center">
            <span class="inline-block w-fit px-3 py-1 bg-emerald-50 text-[#0D6847] text-[11px] font-extrabold uppercase tracking-wider rounded-full mb-4">
              {{ potensi.kategori === 'wisata' ? 'Wisata' : 'Potensi Desa' }}
            </span>
            <h3 class="text-2xl md:text-3xl font-extrabold text-[#0F2D3F] leading-tight mb-4 group-hover:text-[#0D6847] transition-colors">
              {{ potensi.nama }}
            </h3>
            <p class="text-sm md:text-base text-gray-600 leading-relaxed mb-6 line-clamp-4">{{ potensi.deskripsi }}</p>
            <span class="inline-flex items-center gap-1.5 text-sm font-extrabold text-[#0D6847] group-hover:underline w-fit">
              <span>Selengkapnya</span>
            </span>
          </div>
        </div>
      </div>

      <div v-else class="text-center py-16 bg-gray-50 rounded-2xl border border-gray-200">
        <CompassIcon class="w-12 h-12 text-gray-300 mx-auto mb-3" />
        <p class="text-sm text-gray-400 font-semibold">Belum ada potensi untuk kategori ini.</p>
      </div>
    </section>

    <!-- CTA -->
    <section class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 pb-16">
      <div class="bg-gradient-to-r from-[#0D6847] to-[#0A5238] rounded-3xl p-8 md:p-12 text-white text-center shadow-xl">
        <h2 class="text-2xl md:text-3xl font-extrabold mb-3">Punya Ide untuk Kembangkan Potensi Padukuhan?</h2>
        <p class="text-xs md:text-sm text-emerald-100/90 max-w-2xl mx-auto leading-relaxed mb-6">
          Sampaikan ide, saran, atau kolaborasi Anda untuk memajukan potensi desa kami.
        </p>
        <button @click="$emit('navigate', 'kontak')" class="px-6 py-3.5 bg-white hover:bg-emerald-50 text-[#0D6847] font-bold text-xs rounded-xl shadow-md transition-all active:scale-95 cursor-pointer inline-flex items-center gap-2">
          <SendIcon class="w-4 h-4" />
          <span>Hubungi Kami</span>
        </button>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- MODAL DETAIL POTENSI — dengan Fullscreen + Multi-foto         -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="selected"
        id="potensi-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="closeDetail"
      >

        <!-- ============================================ -->
        <!-- FULLSCREEN MODE                              -->
        <!-- ============================================ -->
        <div v-if="isFullscreen" class="relative w-full h-full flex items-center justify-center">

          <!-- Counter kiri atas -->
          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentImageIndex + 1 }} / {{ potensiImages.length }}
          </div>

          <!-- Tombol Minimize + Close kanan atas -->
          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button @click.stop="toggleFullscreen" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center transition-colors cursor-pointer" title="Keluar Fullscreen">
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button @click.stop="closeDetail" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center transition-colors cursor-pointer" title="Tutup">
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <!-- Foto Fullscreen -->
          <img :src="activePotensiImage" :alt="selected.nama" class="max-w-full max-h-full object-contain" />

          <!-- Navigasi Prev/Next -->
          <template v-if="potensiImages.length > 1">
            <button @click.stop="prevImage" class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center z-20 cursor-pointer">
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button @click.stop="nextImage" class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center z-20 cursor-pointer">
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>

          <!-- Thumbnail strip -->
          <div v-if="potensiImages.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20">
            <button v-for="(img, idx) in potensiImages" :key="idx" @click.stop="currentImageIndex = idx"
              :class="currentImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer">
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>

        </div>

        <!-- ============================================ -->
        <!-- NORMAL MODE                                  -->
        <!-- ============================================ -->
        <div v-else class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl flex flex-col">

          <!-- Galeri Foto (Multiple) -->
          <div class="relative bg-gray-900 shrink-0">
            <div class="relative aspect-[16/10] overflow-hidden">
              <img :src="activePotensiImage" :alt="selected.nama" class="w-full h-full object-cover" />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-75"></div>

              <!-- Close kanan atas -->
              <button @click="closeDetail" class="absolute top-4 right-4 p-2 bg-black/55 hover:bg-black/75 text-white rounded-full cursor-pointer z-20">
                <XIcon class="w-5 h-5" />
              </button>

              <!-- Prev/Next -->
              <template v-if="potensiImages.length > 1">
                <button @click.stop="prevImage" class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronLeftIcon class="w-5 h-5" />
                </button>
                <button @click.stop="nextImage" class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronRightIcon class="w-5 h-5" />
                </button>
              </template>

              <!-- Counter kiri bawah -->
              <span v-if="potensiImages.length > 1" class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10">
                {{ currentImageIndex + 1 }} / {{ potensiImages.length }}
              </span>

              <!-- Fullscreen kanan bawah -->
              <button @click.stop="toggleFullscreen" class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer z-10" title="Tampilkan Fullscreen">
                <MaximizeIcon class="w-4 h-4" />
              </button>

              <!-- Badge kategori -->
              <span class="absolute top-4 left-4 bg-[#0D6847] text-white text-[10px] font-bold uppercase tracking-wider px-3 py-1 rounded-full z-10">
                {{ selected.kategori === 'wisata' ? 'Wisata' : 'Potensi Desa' }}
              </span>
            </div>

            <!-- Thumbnails -->
            <div v-if="potensiImages.length > 1" class="flex items-center gap-2 p-3 bg-black/30 overflow-x-auto">
              <button v-for="(img, idx) in potensiImages" :key="idx" @click="currentImageIndex = idx"
                :class="currentImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
                class="relative w-16 h-12 shrink-0 rounded-lg overflow-hidden transition-all cursor-pointer">
                <img :src="img" class="w-full h-full object-cover" />
              </button>
            </div>
          </div>

          <!-- Content -->
          <div class="p-6 md:p-8 space-y-5">
            <h3 class="text-2xl font-extrabold text-[#0F2D3F] leading-snug">{{ selected.nama }}</h3>
            <p class="text-sm md:text-base text-gray-600 leading-relaxed whitespace-pre-line">{{ selected.deskripsi }}</p>

            <div v-if="selected.lokasi && selected.lokasi !== '-'" class="space-y-3 pt-2 border-t border-gray-100">
              <a :href="selected.lokasi" target="_blank" class="inline-flex items-center gap-2 px-4 py-2.5 bg-emerald-50 hover:bg-[#0D6847] text-[#0D6847] hover:text-white text-xs font-bold rounded-xl transition-colors">
                <MapPinIcon class="w-4 h-4" />
                <span>Buka di Google Maps</span>
              </a>
              <div class="rounded-xl overflow-hidden border border-gray-200 h-56">
                <iframe :src="getOSMEmbedUrl(selected.lokasi)" width="100%" height="224" style="border:0" loading="lazy"></iframe>
              </div>
            </div>

            <div class="pt-4 flex justify-end">
              <button @click="closeDetail" class="px-6 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-800 text-xs font-bold rounded-xl cursor-pointer">
                Tutup
              </button>
            </div>
          </div>
        </div>

      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import {
  Compass as CompassIcon,
  MapPin as MapPinIcon,
  X as XIcon,
  Send as SendIcon,
  Camera as CameraIcon,
  ChevronLeft as ChevronLeftIcon,
  ChevronRight as ChevronRightIcon,
  Maximize as MaximizeIcon,
  Minimize as MinimizeIcon
} from 'lucide-vue-next';
import { store } from '../store';

defineEmits(['navigate']);

const activeFilter = ref('semua');
const selected = ref(null);
const currentImageIndex = ref(0);
const isFullscreen = ref(false);

const filterOptions = [
  { label: 'Semua Potensi', value: 'semua' },
  { label: 'Potensi Dusun', value: 'potensi_desa' },
  { label: 'Fasilitas & Wisata', value: 'wisata' }
];

const filteredPotensi = computed(() => {
  if (activeFilter.value === 'semua') return store.potensiWisata;
  return store.potensiWisata.filter(p => p.kategori === activeFilter.value);
});

// Daftar foto potensi
const potensiImages = computed(() => {
  if (!selected.value) return [];
  const list = [];
  if (selected.value.foto_url) list.push(selected.value.foto_url);
  if (Array.isArray(selected.value.images)) {
    selected.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

const activePotensiImage = computed(() => potensiImages.value[currentImageIndex.value] || '/images/hero-bg.png');

const openDetail = (potensi) => {
  selected.value = potensi;
  currentImageIndex.value = 0;
  isFullscreen.value = false;
};

const closeDetail = async () => {
  if (document.fullscreenElement) {
    try { await document.exitFullscreen(); } catch (e) {}
  }
  isFullscreen.value = false;
  selected.value = null;
};

const prevImage = () => {
  if (currentImageIndex.value > 0) currentImageIndex.value--;
  else currentImageIndex.value = potensiImages.value.length - 1;
};

const nextImage = () => {
  if (currentImageIndex.value < potensiImages.value.length - 1) currentImageIndex.value++;
  else currentImageIndex.value = 0;
};

const toggleFullscreen = async () => {
  const el = document.getElementById('potensi-lightbox');
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

const handleImageError = (event) => {
  event.target.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1200&q=80';
};

const getOSMEmbedUrl = (url) => {
  if (!url) return 'https://www.openstreetmap.org/export/embed.html?layer=mapnik';
  let lat = null, lon = null;
  const m1 = url.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/);
  if (m1) { lat = parseFloat(m1[1]); lon = parseFloat(m1[2]); }
  if (!lat) {
    const m2 = url.match(/[?&]q=(?:loc:)?(-?\d+\.\d+),(-?\d+\.\d+)/);
    if (m2) { lat = parseFloat(m2[1]); lon = parseFloat(m2[2]); }
  }
  if (!lat) {
    const m3d = url.match(/!3d(-?\d+\.\d+)/);
    const m4d = url.match(/!4d(-?\d+\.\d+)/);
    if (m3d && m4d) { lat = parseFloat(m3d[1]); lon = parseFloat(m4d[1]); }
  }
  if (!lat) {
    const m4 = url.match(/(-?\d{1,3}\.\d{4,}),(-?\d{1,3}\.\d{4,})/);
    if (m4) { lat = parseFloat(m4[1]); lon = parseFloat(m4[2]); }
  }
  if (lat !== null && lon !== null) {
    const d = 0.003;
    return `https://www.openstreetmap.org/export/embed.html?bbox=${lon-d},${lat-d},${lon+d},${lat+d}&layer=mapnik&marker=${lat},${lon}`;
  }
  return 'https://www.openstreetmap.org/export/embed.html?layer=mapnik';
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>