<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative bg-[#0D6847] text-white py-16 md:py-24 overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#fff_1px,transparent_1px)] [background-size:16px_16px]"></div>

      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center">
        <h1 class="text-3xl md:text-5xl font-extrabold tracking-tight mb-4">
          Galeri Padukuhan Ngemplak Kalangan
        </h1>
        <p class="text-sm md:text-base text-emerald-100 max-w-2xl mx-auto leading-relaxed mb-8 font-medium">
          Menelusuri jejak kegiatan, keindahan alam, dan semangat gotong royong warga Padukuhan Ngemplak Kalangan dalam format visual yang memukau.
        </p>

        <div class="max-w-xl mx-auto relative">
          <SearchIcon class="absolute left-5 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Cari dokumentasi kegiatan..."
            class="w-full pl-13 pr-10 py-3.5 bg-white text-gray-900 placeholder:text-gray-400 rounded-full text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-emerald-300 shadow-lg transition-all"
          />
          <button
            v-if="searchQuery"
            @click="searchQuery = ''"
            class="absolute right-4 top-1/2 -translate-y-1/2 p-1 text-gray-400 hover:text-gray-600 rounded-full"
          >
            <XIcon class="w-4 h-4" />
          </button>
        </div>
      </div>
    </section>

    <!-- DOKUMENTASI TERBARU SECTION -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">

      <div class="text-center max-w-2xl mx-auto mb-10 space-y-2">
        <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Dokumentasi Terbaru</h2>
        <p class="text-sm text-gray-500 font-medium">
          Koleksi foto dan video dari berbagai momen penting yang telah dilalui bersama.
        </p>
        <div class="w-12 h-1 bg-[#0D6847] mx-auto rounded-full mt-3"></div>
      </div>

      <!-- Controls & Filter Bar -->
      <div class="flex flex-col sm:flex-row items-center justify-between gap-4 mb-8">
        <div class="flex items-center bg-gray-100 p-1.5 rounded-2xl border border-gray-200/80">
          <button
            v-for="type in typeFilters"
            :key="type.value"
            @click="activeType = type.value"
            :class="[
              activeType === type.value
                ? 'bg-white text-gray-900 font-bold shadow-xs'
                : 'text-gray-500 font-semibold hover:text-gray-800'
            ]"
            class="px-5 py-2 text-xs rounded-xl transition-all cursor-pointer"
          >
            {{ type.label }}
          </button>
        </div>

        <div class="flex items-center gap-3">
          <button
            @click="showCategoryDropdown = !showCategoryDropdown"
            :class="[
              showCategoryDropdown || selectedCategory
                ? 'border-[#0D6847] text-[#0D6847] bg-emerald-50/40'
                : 'border-gray-200 text-gray-600 hover:text-gray-900 bg-white'
            ]"
            class="flex items-center gap-2 px-4 py-2.5 border rounded-xl text-xs font-bold transition-all cursor-pointer"
          >
            <SlidersIcon class="w-4 h-4" />
            <span>{{ selectedCategory || 'Filter Kategori' }}</span>
          </button>

          <div class="flex items-center bg-gray-100 p-1 rounded-xl border border-gray-200">
            <button
              @click="isGridView = true"
              :class="[isGridView ? 'bg-white text-[#0D6847] shadow-xs' : 'text-gray-400 hover:text-gray-600']"
              class="p-2 rounded-lg transition-colors cursor-pointer"
            >
              <LayoutGridIcon class="w-4 h-4" />
            </button>
            <button
              @click="isGridView = false"
              :class="[!isGridView ? 'bg-white text-[#0D6847] shadow-xs' : 'text-gray-400 hover:text-gray-600']"
              class="p-2 rounded-lg transition-colors cursor-pointer"
            >
              <ListIcon class="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      <!-- Inline Category Dropdown -->
      <transition name="slide-down">
        <div v-if="showCategoryDropdown" class="mb-8 p-4 bg-gray-50 border border-gray-200 rounded-2xl flex flex-wrap items-center gap-2">
          <span class="text-xs font-bold text-gray-400 uppercase tracking-wider mr-2">Pilih Kategori:</span>
          <button
            v-for="cat in categories"
            :key="cat"
            @click="selectCategory(cat)"
            :class="[
              selectedCategory === cat
                ? 'bg-[#0D6847] text-white font-bold'
                : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-100 font-semibold'
            ]"
            class="px-3.5 py-1.5 text-xs rounded-lg transition-all cursor-pointer"
          >
            {{ cat }}
          </button>
          <button v-if="selectedCategory" @click="selectedCategory = ''" class="text-xs font-bold text-red-500 hover:underline ml-auto cursor-pointer">
            Reset Filter
          </button>
        </div>
      </transition>

      <!-- GALLERY CARDS -->
      <div v-if="filteredItems.length > 0">
        <!-- Grid Layout -->
        <div v-if="isGridView" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <div
            v-for="item in filteredItems"
            :key="item.id"
            @click="openLightbox(item)"
            class="group relative rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 cursor-pointer bg-gray-900 aspect-[4/3] border border-gray-200/60 hover:-translate-y-1"
          >
            <!-- Foto -->
            <img
              v-if="item.type !== 'video'"
              :src="item.image"
              :alt="item.title"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              @error="handleImageError"
            />

            <!-- Video: pakai 4 prioritas -->
            <template v-else>
              <!-- 1. YouTube thumbnail -->
              <img
                v-if="getYouTubeThumb(item.youtube_url)"
                :src="getYouTubeThumb(item.youtube_url)"
                :alt="item.title"
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError"
              />
              <!-- 2. Video file (.mp4 dll) → pakai <video> preload -->
              <video
                v-else-if="isVideoFile(item.image)"
                :src="item.image"
                preload="metadata"
                muted
                playsinline
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              ></video>
              <!-- 3. Fallback gambar -->
              <img
                v-else
                :src="item.image"
                :alt="item.title"
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError"
              />
            </template>

            <!-- Type Badge -->
            <div class="absolute top-4 left-4 z-10">
              <span
                :class="[item.type === 'video' ? 'bg-red-600 text-white' : 'bg-black/50 text-white backdrop-blur-md border border-white/20']"
                class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider shadow-md"
              >
                <PlayIcon v-if="item.type === 'video'" class="w-3 h-3 fill-current" />
                <CameraIcon v-else class="w-3 h-3" />
                <span>{{ item.type }}</span>
              </span>
            </div>

            <!-- Overlay -->
            <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/30 to-transparent opacity-90 group-hover:opacity-95 transition-opacity flex flex-col justify-end p-5">
              <span class="text-[10px] font-bold text-emerald-300 uppercase tracking-widest mb-1">{{ item.category }}</span>
              <h3 class="text-base font-extrabold text-white leading-snug group-hover:text-emerald-200 transition-colors">
                {{ item.title }}
              </h3>
              <p class="text-[11px] text-gray-300 mt-1 line-clamp-2 opacity-80 group-hover:opacity-100">
                {{ item.deskripsi || item.description || item.title }}
              </p>
            </div>

            <!-- Play overlay -->
            <div v-if="item.type === 'video'" class="absolute inset-0 flex items-center justify-center pointer-events-none">
              <div class="w-12 h-12 rounded-full bg-[#0D6847]/90 text-white flex items-center justify-center shadow-xl group-hover:scale-110 transition-transform">
                <PlayIcon class="w-5 h-5 fill-current ml-0.5" />
              </div>
            </div>
          </div>
        </div>

        <!-- List Layout -->
        <div v-else class="space-y-4">
          <div
            v-for="item in filteredItems"
            :key="item.id"
            @click="openLightbox(item)"
            class="bg-white rounded-2xl p-4 border border-gray-200 hover:shadow-md transition-all flex flex-col sm:flex-row items-center gap-5 cursor-pointer group hover:-translate-y-0.5"
          >
            <div class="relative w-full sm:w-48 aspect-video rounded-xl overflow-hidden bg-gray-100 shrink-0">
              <img
                v-if="item.type !== 'video'"
                :src="item.image"
                :alt="item.title"
                class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                @error="handleImageError"
              />
              <template v-else>
                <img
                  v-if="getYouTubeThumb(item.youtube_url)"
                  :src="getYouTubeThumb(item.youtube_url)"
                  :alt="item.title"
                  class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                  @error="handleImageError"
                />
                <video
                  v-else-if="isVideoFile(item.image)"
                  :src="item.image"
                  preload="metadata"
                  muted
                  playsinline
                  class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                ></video>
                <img v-else :src="item.image" :alt="item.title" class="w-full h-full object-cover" @error="handleImageError" />
              </template>
              <span :class="[item.type === 'video' ? 'bg-red-600' : 'bg-black/60']" class="absolute top-2 left-2 px-2 py-0.5 text-white text-[9px] font-bold uppercase rounded-md">
                {{ item.type }}
              </span>
            </div>
            <div class="flex-1 space-y-1 text-center sm:text-left">
              <span class="text-[10px] font-bold text-[#0D6847] uppercase tracking-wider">{{ item.category }}</span>
              <h3 class="text-base font-extrabold text-gray-900 group-hover:text-[#0D6847] transition-colors">{{ item.title }}</h3>
              <p class="text-xs text-gray-500 font-medium line-clamp-2">{{ item.deskripsi || item.description }}</p>
              <div class="flex items-center justify-center sm:justify-start gap-3 text-[11px] text-gray-400 font-semibold pt-1">
                <span>{{ item.date }}</span>
              </div>
            </div>
            <button class="px-4 py-2 bg-emerald-50 text-[#0D6847] text-xs font-bold rounded-xl group-hover:bg-[#0D6847] group-hover:text-white transition-colors cursor-pointer shrink-0">
              Lihat
            </button>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-else class="text-center py-16 bg-gray-50 rounded-2xl border border-gray-200">
        <CameraIcon class="w-10 h-10 text-gray-300 mx-auto mb-3" />
        <h3 class="text-base font-bold text-gray-700">Tidak ada dokumentasi ditemukan</h3>
        <p class="text-xs text-gray-400 mt-1">Coba gunakan kata kunci lain atau reset filter pencarian.</p>
        <button @click="resetAllFilters" class="mt-4 px-4 py-2 bg-[#0D6847] text-white text-xs font-bold rounded-xl cursor-pointer">
          Reset Filter
        </button>
      </div>

    </section>

    <!-- LIGHTBOX MODAL dengan FULLSCREEN SUPPORT -->
    <transition name="fade">
      <div
        v-if="selectedItem"
        id="gallery-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="selectedItem = null"
      >

        <!-- ============================================ -->
        <!-- FULLSCREEN MODE                              -->
        <!-- ============================================ -->
        <div v-if="isFullscreen" class="relative w-full h-full flex items-center justify-center">

          <!-- Counter (top-left) -->
          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentMediaIndex + 1 }} / {{ mediaList.length }}
          </div>

          <!-- Action Buttons (top-right) -->
          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button
              @click.stop="toggleFullscreen"
              class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center transition-colors cursor-pointer"
              title="Keluar Fullscreen"
            >
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button
              @click.stop="selectedItem = null"
              class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center transition-colors cursor-pointer"
              title="Tutup"
            >
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <!-- Media Fullscreen -->
          <template v-if="selectedItem.type === 'video'">
            <iframe
              v-if="getYouTubeEmbed(selectedItem.youtube_url)"
              :src="getYouTubeEmbed(selectedItem.youtube_url)"
              class="w-full h-full"
              frameborder="0"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowfullscreen
            ></iframe>
            <video
              v-else-if="isVideoFile(activeMedia)"
              :src="activeMedia"
              controls
              autoplay
              class="max-w-full max-h-full object-contain"
            ></video>
          </template>
          <img
            v-else
            :src="activeMedia"
            :alt="selectedItem.title"
            class="max-w-full max-h-full object-contain"
          />

          <!-- Navigasi Prev/Next -->
          <template v-if="mediaList.length > 1">
            <button
              @click.stop="prevMedia"
              class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-20"
            >
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button
              @click.stop="nextMedia"
              class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-20"
            >
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>

          <!-- Thumbnail strip (bottom) -->
          <div
            v-if="mediaList.length > 1 && selectedItem.type !== 'video'"
            class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20"
          >
            <button
              v-for="(img, idx) in mediaList"
              :key="idx"
              @click.stop="currentMediaIndex = idx"
              :class="currentMediaIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer"
            >
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>

          <!-- Caption (below photo) -->
          <div class="absolute bottom-4 left-1/2 -translate-x-1/2 text-center text-white max-w-2xl px-4 z-10 pointer-events-none" style="display: none;">
            {{ selectedItem.title }}
          </div>

        </div>

        <!-- ============================================ -->
        <!-- NORMAL MODE                                  -->
        <!-- ============================================ -->
        <div v-else class="bg-white rounded-3xl max-w-3xl w-full overflow-hidden shadow-2xl flex flex-col max-h-[90vh]">

          <!-- Media Container -->
          <div class="relative bg-black flex items-center justify-center" :class="selectedItem.type === 'video' ? 'aspect-video' : 'max-h-[60vh]'">

            <template v-if="selectedItem.type === 'video'">
              <iframe
                v-if="getYouTubeEmbed(selectedItem.youtube_url)"
                :src="getYouTubeEmbed(selectedItem.youtube_url)"
                class="w-full h-full"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen
              ></iframe>
              <video
                v-else-if="isVideoFile(activeMedia)"
                :src="activeMedia"
                controls
                autoplay
                class="w-full h-full object-contain max-h-[60vh]"
              ></video>
              <div v-else class="w-full aspect-video bg-gray-900 flex items-center justify-center text-white text-xs text-center p-4">
                <div>
                  <PlayIcon class="w-10 h-10 mx-auto mb-2 opacity-50" />
                  <p>Video tidak tersedia.</p>
                </div>
              </div>
            </template>

            <img
              v-else
              :src="activeMedia"
              :alt="selectedItem.title"
              class="w-full h-full object-contain max-h-[60vh]"
            />

            <!-- Navigasi Prev/Next -->
            <template v-if="mediaList.length > 1">
              <button
                @click.stop="prevMedia"
                class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-10"
              >
                <ChevronLeftIcon class="w-5 h-5" />
              </button>
              <button
                @click.stop="nextMedia"
                class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-10"
              >
                <ChevronRightIcon class="w-5 h-5" />
              </button>
              <span class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10">
                {{ currentMediaIndex + 1 }} / {{ mediaList.length }}
              </span>
            </template>

            <!-- Tombol Fullscreen (BARU) -->
            <button
              @click.stop="toggleFullscreen"
              class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer z-10"
              title="Tampilkan Fullscreen"
            >
              <MaximizeIcon class="w-4 h-4" />
            </button>

            <button
              @click="selectedItem = null"
              class="absolute top-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer z-20"
            >
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <!-- Thumbnail Strip -->
          <div v-if="mediaList.length > 1 && selectedItem.type !== 'video'" class="flex items-center gap-2 p-3 bg-gray-900 overflow-x-auto">
            <button
              v-for="(img, idx) in mediaList"
              :key="idx"
              @click="currentMediaIndex = idx"
              :class="currentMediaIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-16 h-12 shrink-0 rounded-lg overflow-hidden transition-all cursor-pointer"
            >
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>

          <!-- Description -->
          <div class="p-6 space-y-3 bg-white">
            <div class="flex items-center justify-between gap-2">
              <span class="text-xs font-extrabold text-[#0D6847] uppercase tracking-wider">{{ selectedItem.category }}</span>
              <span class="text-xs text-gray-400 font-semibold">{{ selectedItem.date }}</span>
            </div>
            <h3 class="text-lg font-extrabold text-gray-900 leading-snug">{{ selectedItem.title }}</h3>
            <p class="text-xs text-gray-600 leading-relaxed font-medium whitespace-pre-line">
              {{ selectedItem.deskripsi || selectedItem.description || 'Tidak ada deskripsi.' }}
            </p>
            <div class="flex justify-end pt-2">
              <button @click="selectedItem = null" class="px-5 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl cursor-pointer">
                Tutup
              </button>
            </div>
          </div>
        </div>

      </div>
    </transition>

    <!-- TOAST -->
    <transition name="fade">
      <div v-if="toastMsg" class="fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-3.5 bg-gray-900 text-white rounded-2xl shadow-xl">
        <CheckCircleIcon class="w-5 h-5 text-emerald-400 shrink-0" />
        <span class="text-xs font-bold">{{ toastMsg }}</span>
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted} from 'vue';
import {
  Search as SearchIcon,
  Sliders as SlidersIcon,
  LayoutGrid as LayoutGridIcon,
  List as ListIcon,
  Play as PlayIcon,
  Camera as CameraIcon,
  ChevronRight as ChevronRightIcon,
  ChevronLeft as ChevronLeftIcon,
  X as XIcon,
  CheckCircle as CheckCircleIcon,
  Maximize as MaximizeIcon,
  Minimize as MinimizeIcon
} from 'lucide-vue-next';

import { store } from '../store';

// States
const searchQuery = ref('');
const activeType = ref('semua');
const selectedCategory = ref('');
const showCategoryDropdown = ref(false);
const isGridView = ref(true);

const selectedItem = ref(null);
const currentMediaIndex = ref(0);
const toastMsg = ref('');

const typeFilters = [
  { label: 'Semua', value: 'semua' },
  { label: 'Foto', value: 'foto' },
  { label: 'Video', value: 'video' }
];

const categories = computed(() =>
  store.categoriesByTipe('galeri').map(c => c.nama)
);

// Filtered List
const filteredItems = computed(() => {
  let list = [...store.gallery];

  if (activeType.value !== 'semua') {
    list = list.filter(item => item.type.toLowerCase() === activeType.value);
  }

  if (selectedCategory.value) {
    list = list.filter(item => item.category === selectedCategory.value);
  }

  if (searchQuery.value.trim()) {
    const q = searchQuery.value.toLowerCase();
    list = list.filter(item =>
      item.title.toLowerCase().includes(q) ||
      (item.category || '').toLowerCase().includes(q) ||
      (item.deskripsi || item.description || '').toLowerCase().includes(q)
    );
  }

  return list;
});

// Daftar media (untuk multi-foto di lightbox)
const mediaList = computed(() => {
  if (!selectedItem.value) return [];

  // Untuk video, hanya tampilkan video itu sendiri
  if (selectedItem.value.type === 'video') {
    return [selectedItem.value.image];
  }

  // Untuk foto, gabung file_url + images
  const list = [];
  if (selectedItem.value.image) list.push(selectedItem.value.image);
  if (Array.isArray(selectedItem.value.images)) {
    selectedItem.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

const activeMedia = computed(() => mediaList.value[currentMediaIndex.value] || '');

// Helpers
const isVideoFile = (url) => {
  if (!url) return false;
  return /\.(mp4|webm|mov|ogg|m4v)$/i.test(url);
};

const getYouTubeId = (url) => {
  if (!url) return null;
  const m = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&?/]+)/);
  return m ? m[1] : null;
};

const getYouTubeThumb = (url) => {
  const id = getYouTubeId(url);
  return id ? `https://img.youtube.com/vi/${id}/hqdefault.jpg` : '';
};

const getYouTubeEmbed = (url) => {
  const id = getYouTubeId(url);
  return id ? `https://www.youtube.com/embed/${id}` : '';
};

// Methods
const selectCategory = (cat) => {
  selectedCategory.value = selectedCategory.value === cat ? '' : cat;
};

const resetAllFilters = () => {
  searchQuery.value = '';
  activeType.value = 'semua';
  selectedCategory.value = '';
  showCategoryDropdown.value = false;
};

const openLightbox = (item) => {
  selectedItem.value = item;
  currentMediaIndex.value = 0;
  isFullscreen.value = false; // reset fullscreen saat buka baru
};

// Handler close yang exit fullscreen dulu
const closeLightbox = async () => {
  if (document.fullscreenElement) {
    try {
      await document.exitFullscreen();
    } catch (e) { /* ignore */ }
  }
  isFullscreen.value = false;
  selectedItem.value = null;
};

const prevMedia = () => {
  if (currentMediaIndex.value > 0) currentMediaIndex.value--;
  else currentMediaIndex.value = mediaList.value.length - 1;
};

const nextMedia = () => {
  if (currentMediaIndex.value < mediaList.value.length - 1) currentMediaIndex.value++;
  else currentMediaIndex.value = 0;
};

const showToast = (msg) => {
  toastMsg.value = msg;
  setTimeout(() => { toastMsg.value = ''; }, 3500);
};

// State fullscreen
const isFullscreen = ref(false);

// Toggle fullscreen
const toggleFullscreen = async () => {
  const el = document.getElementById('gallery-lightbox');
  if (!el) return;
  try {
    if (!document.fullscreenElement) {
      await el.requestFullscreen();
      isFullscreen.value = true;
    } else {
      await document.exitFullscreen();
      isFullscreen.value = false;
    }
  } catch (err) {
    console.warn('Fullscreen tidak didukung:', err);
  }
};

// Sinkronkan state jika user tekan ESC
const handleFullscreenChange = () => {
  isFullscreen.value = !!document.fullscreenElement;
};

onMounted(() => {
  document.addEventListener('fullscreenchange', handleFullscreenChange);
});

onUnmounted(() => {
  document.removeEventListener('fullscreenchange', handleFullscreenChange);
});

const handleImageError = (e) => {
  e.target.src = '/images/hero-bg.png';
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

.slide-down-enter-active, .slide-down-leave-active { transition: all 0.25s ease-out; max-height: 150px; opacity: 1; overflow: hidden; }
.slide-down-enter-from, .slide-down-leave-to { max-height: 0; opacity: 0; padding-top: 0; padding-bottom: 0; margin-top: 0; margin-bottom: 0; }
</style>