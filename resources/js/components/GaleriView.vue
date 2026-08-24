<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative bg-[#0D6847] text-white py-16 md:py-24 overflow-hidden">
      <!-- Background Subtle Pattern overlay -->
      <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#fff_1px,transparent_1px)] [background-size:16px_16px]"></div>
      
      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center">
        <h1 class="text-3xl md:text-5xl font-extrabold tracking-tight mb-4">
          Galeri Padukuhan Ngemplak Kalangan
        </h1>
        <p class="text-sm md:text-base text-emerald-100 max-w-2xl mx-auto leading-relaxed mb-8 font-medium">
          Menelusuri jejak kegiatan, keindahan alam, dan semangat gotong royong warga Padukuhan Digital dalam format visual yang memikat.
        </p>

        <!-- Search Bar in Hero -->
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
      
      <!-- Section Header -->
      <div class="text-center max-w-2xl mx-auto mb-10 space-y-2">
        <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Dokumentasi Terbaru</h2>
        <p class="text-sm text-gray-500 font-medium">
          Koleksi foto dan video dari berbagai momen penting yang telah dilalui bersama.
        </p>
        <div class="w-12 h-1 bg-[#0D6847] mx-auto rounded-full mt-3"></div>
      </div>

      <!-- Controls & Filter Bar -->
      <div class="flex flex-col sm:flex-row items-center justify-between gap-4 mb-8">
        
        <!-- Tabs: Semua, Foto, Video -->
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

        <!-- Filter Category & Layout Toggle -->
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
              title="Tampilan Grid"
            >
              <LayoutGridIcon class="w-4 h-4" />
            </button>
            <button 
              @click="isGridView = false" 
              :class="[!isGridView ? 'bg-white text-[#0D6847] shadow-xs' : 'text-gray-400 hover:text-gray-600']"
              class="p-2 rounded-lg transition-colors cursor-pointer"
              title="Tampilan List"
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
          <button 
            v-if="selectedCategory"
            @click="selectedCategory = ''"
            class="text-xs font-bold text-red-500 hover:underline ml-auto cursor-pointer"
          >
            Reset Filter
          </button>
        </div>
      </transition>

      <!-- GALLERY CARDS GRID / LIST -->
      <div v-if="filteredItems.length > 0">
        <!-- Grid Layout -->
        <div 
          v-if="isGridView"
          class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6"
        >
          <div 
            v-for="item in filteredItems" 
            :key="item.id"
            @click="openLightbox(item)"
            class="group relative rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 cursor-pointer bg-gray-900 aspect-[4/3] border border-gray-200/60 hover:-translate-y-1"
          >
            <!-- Thumbnail Image -->
            <img 
              :src="item.image" 
              :alt="item.title" 
              class="w-full h-full object-cover group-hover:scale-108 transition-transform duration-500 opacity-90 group-hover:opacity-100"
              @error="handleImageError"
            />
            
            <!-- Type Badge (Top-left) -->
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

            <!-- Gradient Overlay & Title (Bottom) -->
            <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/30 to-transparent opacity-90 group-hover:opacity-95 transition-opacity flex flex-col justify-end p-5">
              <span class="text-[10px] font-bold text-emerald-300 uppercase tracking-widest mb-1">{{ item.category }}</span>
              <h3 class="text-base font-extrabold text-white leading-snug group-hover:text-emerald-200 transition-colors">
                {{ item.title }}
              </h3>
              <p class="text-[11px] text-gray-300 mt-1 line-clamp-1 opacity-80 group-hover:opacity-100">
                {{ item.date }} • {{ item.location }}
              </p>
            </div>

            <!-- Hover Play Overlay for Video -->
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
              <img :src="item.image" :alt="item.title" class="w-full h-full object-cover group-hover:scale-105 transition-transform" />
              <span 
                :class="[item.type === 'video' ? 'bg-red-600' : 'bg-black/60']"
                class="absolute top-2 left-2 px-2 py-0.5 text-white text-[9px] font-bold uppercase rounded-md backdrop-blur-xs"
              >
                {{ item.type }}
              </span>
            </div>
            <div class="flex-1 space-y-1 text-center sm:text-left">
              <span class="text-[10px] font-bold text-[#0D6847] uppercase tracking-wider">{{ item.category }}</span>
              <h3 class="text-base font-extrabold text-gray-900 group-hover:text-[#0D6847] transition-colors">{{ item.title }}</h3>
              <p class="text-xs text-gray-500 font-medium line-clamp-2">{{ item.description }}</p>
              <div class="flex items-center justify-center sm:justify-start gap-3 text-[11px] text-gray-400 font-semibold pt-1">
                <span>{{ item.date }}</span>
                <span>•</span>
                <span>{{ item.location }}</span>
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

    <!-- SECTION: LIHAT PADUKUHAN DARI PERSPEKTIF BERBEDA -->
    <section class="bg-gray-100/70 border-t border-b border-gray-200 py-16 md:py-24">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
          
          <!-- Video Thumbnail Card (5 cols) -->
          <div class="lg:col-span-5 flex justify-center">
            <div 
              @click="openVideoModal"
              class="relative w-full max-w-md aspect-[4/3] rounded-3xl overflow-hidden shadow-2xl border-4 border-white group cursor-pointer"
            >
              <img 
                src="/images/hero-bg.png" 
                alt="Video Profil Padukuhan" 
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
              
              <!-- Center Play Button -->
              <div class="absolute inset-0 flex items-center justify-center">
                <div class="w-16 h-16 rounded-full bg-[#0D6847] text-white flex items-center justify-center shadow-2xl border-2 border-white/30 group-hover:scale-115 transition-transform duration-300">
                  <PlayIcon class="w-7 h-7 fill-current ml-1" />
                </div>
              </div>

              <!-- Bottom Overlay -->
              <div class="absolute bottom-6 left-6 right-6">
                <span class="px-3 py-1 bg-emerald-500 text-white text-[10px] font-extrabold uppercase tracking-wider rounded-md shadow-md">
                  Video Pilihan
                </span>
                <h3 class="text-lg font-extrabold text-white mt-2 leading-snug">
                  Profile Singkat Padukuhan Digital 2024
                </h3>
              </div>
            </div>
          </div>

          <!-- Text & Highlights (7 cols) -->
          <div class="lg:col-span-7 space-y-6">
            <h2 class="text-3xl md:text-4xl font-extrabold text-gray-950 leading-tight">
              Lihat Padukuhan Dari Perspektif Berbeda
            </h2>
            <p class="text-sm text-gray-600 leading-relaxed font-medium">
              Video profil ini merangkum seluruh potensi desa, mulai dari keasrian alam, kerajinan tangan lokal, hingga kehangatan kebersamaan masyarakat yang guyub rukun. Saksikan bagaimana tradisi dan nilai luhur desa hidup berdampingan.
            </p>

            <!-- Bullet List with Icons -->
            <ul class="space-y-3.5 pt-2">
              <li 
                v-for="(item, idx) in highlights" 
                :key="idx"
                class="flex items-center gap-3 text-xs md:text-sm text-gray-700 font-bold"
              >
                <div class="w-6 h-6 rounded-full bg-emerald-100 text-[#0D6847] flex items-center justify-center shrink-0">
                  <ChevronRightIcon class="w-4 h-4" />
                </div>
                <span>{{ item }}</span>
              </li>
            </ul>

            <!-- YouTube CTA Button -->
            <div class="pt-4">
              <button 
                @click="openVideoModal"
                class="inline-flex items-center gap-2.5 px-6 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md hover:shadow-lg transition-all active:scale-95 cursor-pointer"
              >
                <span>Tonton di Youtube Padukuhan</span>
                <ChevronRightIcon class="w-4 h-4" />
              </button>
            </div>
          </div>

        </div>
      </div>
    </section>

    <!-- SECTION: PUNYA DOKUMENTASI KEGIATAN PADUKUHAN? (CTA) -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
      <div class="bg-[#0D6847] rounded-3xl p-8 md:p-14 text-white text-center shadow-xl relative overflow-hidden">
        <!-- Background Decorative circles -->
        <div class="absolute -right-16 -top-16 w-64 h-64 bg-emerald-500/20 rounded-full blur-3xl pointer-events-none"></div>
        <div class="absolute -left-16 -bottom-16 w-64 h-64 bg-emerald-500/20 rounded-full blur-3xl pointer-events-none"></div>

        <div class="relative z-10 max-w-2xl mx-auto space-y-4">
          <h2 class="text-2xl md:text-4xl font-extrabold tracking-tight">
            Punya Dokumentasi Kegiatan Padukuhan?
          </h2>
          <p class="text-xs md:text-sm text-emerald-100 leading-relaxed font-medium">
            Kami mengundang seluruh warga untuk berkontribusi mengabadikan momen berharga di Padukuhan kita. Kirimkan foto atau videomu untuk ditampilkan di galeri resmi Padukuhan.
          </p>
          
          <div class="flex flex-col sm:flex-row items-center justify-center gap-4 pt-4">
            <button 
              @click="openUploadModal"
              class="w-full sm:w-auto px-7 py-3.5 bg-white text-[#0D6847] hover:bg-emerald-50 text-xs font-extrabold rounded-xl shadow-md transition-all active:scale-95 cursor-pointer"
            >
              Kirim Dokumentasi
            </button>
            <button 
              @click="openTermsModal"
              class="w-full sm:w-auto px-7 py-3.5 bg-transparent border border-white/40 hover:bg-white/10 text-white text-xs font-bold rounded-xl transition-all cursor-pointer"
            >
              Pelajari Syarat & Ketentuan
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- LIGHTBOX MODAL (FOR PHOTO/VIDEO PREVIEW) -->
    <transition name="fade">
      <div 
        v-if="selectedItem" 
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-xs"
        @click.self="selectedItem = null"
      >
        <div class="bg-white rounded-3xl max-w-3xl w-full overflow-hidden shadow-2xl border border-gray-100 flex flex-col max-h-[90vh]">
          <!-- Media Container -->
          <div class="relative bg-black flex items-center justify-center max-h-[60vh] overflow-hidden">
            <img 
              :src="selectedItem.image" 
              :alt="selectedItem.title" 
              class="w-full h-full object-contain max-h-[60vh]"
            />
            <button 
              @click="selectedItem = null"
              class="absolute top-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer"
            >
              <XIcon class="w-5 h-5" />
            </button>

            <!-- Video Play Overlay if Video -->
            <div v-if="selectedItem.type === 'video'" class="absolute inset-0 flex items-center justify-center bg-black/30">
              <div class="text-center space-y-2">
                <div class="w-16 h-16 rounded-full bg-red-600 text-white flex items-center justify-center mx-auto shadow-2xl animate-pulse">
                  <PlayIcon class="w-8 h-8 fill-current ml-1" />
                </div>
                <p class="text-xs text-white font-bold bg-black/60 px-3 py-1 rounded-full backdrop-blur-xs">
                  Memutar Simulasi Video HD
                </p>
              </div>
            </div>
          </div>

          <!-- Description Footer -->
          <div class="p-6 space-y-3 bg-white">
            <div class="flex items-center justify-between gap-2">
              <span class="text-xs font-extrabold text-[#0D6847] uppercase tracking-wider">{{ selectedItem.category }}</span>
              <span class="text-xs text-gray-400 font-semibold">{{ selectedItem.date }}</span>
            </div>
            <h3 class="text-lg font-extrabold text-gray-900 leading-snug">{{ selectedItem.title }}</h3>
            <p class="text-xs text-gray-600 leading-relaxed font-medium">{{ selectedItem.description }}</p>
            <div class="flex justify-end pt-2">
              <button 
                @click="selectedItem = null" 
                class="px-5 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl cursor-pointer"
              >
                Tutup
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- UPLOAD DOCUMENTATION MODAL -->
    <transition name="fade">
      <div 
        v-if="showUploadModal" 
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs"
        @click.self="showUploadModal = false"
      >
        <div class="bg-white rounded-3xl max-w-lg w-full p-6 md:p-8 shadow-2xl border border-gray-100 space-y-5">
          <div class="flex items-center justify-between border-b border-gray-100 pb-3">
            <h3 class="text-lg font-extrabold text-gray-900">Kirim Dokumentasi Warga</h3>
            <button @click="showUploadModal = false" class="p-1 text-gray-400 hover:text-gray-600 rounded-full">
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <form @submit.prevent="submitUpload" class="space-y-4">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Lengkap</label>
              <input v-model="uploadForm.name" required type="text" placeholder="Nama Anda" class="w-full px-3.5 py-2.5 border border-gray-200 rounded-xl text-xs font-semibold focus:outline-none focus:border-[#0D6847]" />
            </div>

            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Judul Dokumentasi</label>
              <input v-model="uploadForm.title" required type="text" placeholder="Contoh: Lomba Balap Karung RT 03" class="w-full px-3.5 py-2.5 border border-gray-200 rounded-xl text-xs font-semibold focus:outline-none focus:border-[#0D6847]" />
            </div>

            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Kategori</label>
              <select v-model="uploadForm.category" class="w-full px-3.5 py-2.5 border border-gray-200 rounded-xl text-xs font-semibold focus:outline-none focus:border-[#0D6847] bg-white">
                <option v-for="cat in categories" :key="cat" :value="cat">{{ cat }}</option>
              </select>
            </div>

            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Pilih Berkas Foto / Video</label>
              <div class="border-2 border-dashed border-gray-200 rounded-xl p-6 text-center hover:border-[#0D6847] transition-colors cursor-pointer bg-gray-50">
                <CameraIcon class="w-8 h-8 text-gray-400 mx-auto mb-2" />
                <p class="text-xs font-bold text-gray-600">Klik untuk mengunggah atau seret berkas ke sini</p>
                <p class="text-[10px] text-gray-400 mt-1">PNG, JPG, MP4 hingga 50MB</p>
              </div>
            </div>

            <div class="flex justify-end gap-3 pt-2">
              <button type="button" @click="showUploadModal = false" class="px-4 py-2 text-xs font-bold text-gray-500 hover:text-gray-700">
                Batal
              </button>
              <button type="submit" class="px-6 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md cursor-pointer">
                Kirimkan
              </button>
            </div>
          </form>
        </div>
      </div>
    </transition>

    <!-- TERMS MODAL -->
    <transition name="fade">
      <div 
        v-if="showTermsModal" 
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs"
        @click.self="showTermsModal = false"
      >
        <div class="bg-white rounded-3xl max-w-md w-full p-6 shadow-2xl border border-gray-100 space-y-4">
          <div class="flex items-center justify-between border-b border-gray-100 pb-3">
            <h3 class="text-base font-extrabold text-gray-900">Syarat & Ketentuan Dokumentasi</h3>
            <button @click="showTermsModal = false" class="p-1 text-gray-400 hover:text-gray-600">
              <XIcon class="w-5 h-5" />
            </button>
          </div>
          <ul class="text-xs text-gray-600 space-y-2.5 font-medium list-disc pl-4 leading-relaxed">
            <li>Dokumentasi merupakan hasil karya sendiri atau milik warga padukuhan.</li>
            <li>Foto/video tidak mengandung unsur kekerasan, SARA, atau informasi palsu.</li>
            <li>Format foto minimal resolusi 1280x720 piksel (HD).</li>
            <li>Tim redaksi padukuhan berhak mengkurasi dokumentasi sebelum dipublikasikan.</li>
          </ul>
          <div class="flex justify-end pt-2">
            <button @click="showTermsModal = false" class="px-5 py-2 bg-[#0D6847] text-white text-xs font-bold rounded-xl cursor-pointer">
              Saya Mengerti
            </button>
          </div>
        </div>
      </div>
    </transition>

    <!-- TOAST -->
    <transition name="fade">
      <div v-if="toastMsg" class="fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-3.5 bg-gray-900 text-white rounded-2xl shadow-xl border border-gray-800">
        <CheckCircleIcon class="w-5 h-5 text-emerald-400 shrink-0" />
        <span class="text-xs font-bold">{{ toastMsg }}</span>
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { 
  Search as SearchIcon, 
  Sliders as SlidersIcon, 
  LayoutGrid as LayoutGridIcon, 
  List as ListIcon, 
  Play as PlayIcon, 
  Camera as CameraIcon, 
  ChevronRight as ChevronRightIcon, 
  X as XIcon,
  CheckCircle as CheckCircleIcon
} from 'lucide-vue-next';

// States
const searchQuery = ref('');
const activeType = ref('semua');
const selectedCategory = ref('');
const showCategoryDropdown = ref(false);
const isGridView = ref(true);

const selectedItem = ref(null);
const showUploadModal = ref(false);
const showTermsModal = ref(false);
const toastMsg = ref('');

const uploadForm = ref({
  name: '',
  title: '',
  category: 'Kebudayaan'
});

const typeFilters = [
  { label: 'Semua', value: 'semua' },
  { label: 'Foto', value: 'foto' },
  { label: 'Video', value: 'video' }
];

const categories = [
  'Kebudayaan',
  'Keagamaan',
  'Olahraga',
  'Pembangunan',
  'Pariwisata'
];

const highlights = [
  'Cita-Cita pembangunan Padukuhan masa depan',
  'Keharmonisan dan kerukunan warga lintas generasi',
  'Highlight produk unggulan UMKM & pengrajin',
  'Pesona alam, persawahan, dan agrowisata'
];

import { store } from '../store';

// Computed Filtered List
const filteredItems = computed(() => {
  let list = [...store.gallery];

  // Type filter
  if (activeType.value !== 'semua') {
    list = list.filter(item => item.type.toLowerCase() === activeType.value);
  }

  // Category filter
  if (selectedCategory.value) {
    list = list.filter(item => item.category === selectedCategory.value);
  }

  // Search filter
  if (searchQuery.value.trim()) {
    const q = searchQuery.value.toLowerCase();
    list = list.filter(item => 
      item.title.toLowerCase().includes(q) || 
      item.category.toLowerCase().includes(q) ||
      item.description.toLowerCase().includes(q)
    );
  }

  return list;
});

// Methods
const selectCategory = (cat) => {
  if (selectedCategory.value === cat) {
    selectedCategory.value = '';
  } else {
    selectedCategory.value = cat;
  }
};

const resetAllFilters = () => {
  searchQuery.value = '';
  activeType.value = 'semua';
  selectedCategory.value = '';
  showCategoryDropdown.value = false;
};

const openLightbox = (item) => {
  selectedItem.value = item;
};

const openVideoModal = () => {
  selectedItem.value = {
    id: 99,
    title: 'Profil Keindahan & Budaya Padukuhan 2026',
    type: 'video',
    category: 'Profil',
    image: '/images/hero-bg.png',
    date: '2026',
    location: 'Ngemplak Kalangan',
    description: 'Rangkuman potensi keasrian alam, UMKM unggulan, dan kebudayaan luhur Padukuhan Ngemplak Kalangan.'
  };
};

const openUploadModal = () => {
  showUploadModal.value = true;
};

const openTermsModal = () => {
  showTermsModal.value = true;
};

const submitUpload = () => {
  showUploadModal.value = false;
  showToast('Terima kasih! Dokumentasi Anda telah berhasil dikirim untuk dikurasi.');
  uploadForm.value = { name: '', title: '', category: 'Kebudayaan' };
};

const showToast = (msg) => {
  toastMsg.value = msg;
  setTimeout(() => { toastMsg.value = ''; }, 3500);
};

const handleImageError = (e) => {
  e.target.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=800&q=80';
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

.slide-down-enter-active, .slide-down-leave-active { transition: all 0.25s ease-out; max-height: 150px; opacity: 1; overflow: hidden; }
.slide-down-enter-from, .slide-down-leave-to { max-height: 0; opacity: 0; padding-top: 0; padding-bottom: 0; margin-top: 0; margin-bottom: 0; }
</style>
