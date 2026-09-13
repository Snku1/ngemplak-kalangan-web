<template>
  <div>
    <!-- ============================================================ -->
    <!-- HERO SECTION — dengan badge lokasi + 4 nav cards              -->
    <!-- ============================================================ -->
    <section class="relative min-h-[560px] md:min-h-[670px] flex items-center overflow-hidden bg-gray-900 text-white">
      <!-- Background (TIDAK DIUBAH) -->
      <div class="absolute inset-0 z-0">
        <img
          src="/images/hero-bg.png"
          alt="Latar Belakang Padukuhan"
          class="w-full h-full object-cover object-center opacity-70 scale-105 animate-pulse-slow"
          @error="handleImageError($event, 'hero-bg')"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-900/60 to-gray-950/40"></div>
      </div>

      <!-- Konten Hero (Left-aligned) -->
      <div class="relative z-10 w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 md:py-28">
        <div class="max-w-3xl">
          <!-- Badge Lokasi -->
          <span class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/15 backdrop-blur-md border border-white/25 text-xs font-semibold tracking-wide text-white mb-6">
            <MapPinIcon class="w-3.5 h-3.5 text-emerald-300" />
            {{ store.padukuhanProfile?.kecamatan || 'Kecamatan' }}, {{ store.padukuhanProfile?.kabupaten || 'Kabupaten' }}
          </span>

          <!-- Judul -->
          <h1 class="text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-extrabold tracking-tight leading-[1.05] mb-5 text-white">
            Selamat Datang <br class="hidden sm:block" />
            di Padukuhan <br class="hidden sm:block" />
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-200">
              {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}
            </span>
          </h1>

          <!-- Subtitle -->
          <p class="text-base md:text-lg text-gray-200 max-w-xl leading-relaxed mb-10">
            {{ store.padukuhanProfile?.cita_cita.substring(0, 120) + '...' || 'Padukuhan yang asri, berbudaya, dan berdaya mandiri dengan semangat gotong royong.' }}
          </p>

          <!-- Buttons -->
          <div class="flex flex-wrap items-center gap-4">
            <button
              @click="$emit('navigate', 'profil')"
              class="inline-flex items-center gap-2.5 px-6 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white font-bold rounded-xl shadow-lg hover:shadow-emerald-900/30 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer"
            >
              <CompassIcon class="w-4 h-4" />
              <span>Mulai Jelajahi</span>
            </button>
            <button
              @click="$emit('navigate', 'profil')"
              class="inline-flex items-center gap-2.5 px-6 py-3.5 bg-white/10 hover:bg-white/20 text-white font-bold rounded-xl border border-white/30 backdrop-blur-sm transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer"
            >
              <MapIcon class="w-4 h-4" />
              <span>Lihat Peta</span>
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- 4 NAV CARDS — menumpuk di bawah hero                          -->
    <!-- ============================================================ -->
    <section class="relative z-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-10 md:-mt-14">
      <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6">

        <!-- Card: Wisata -->
        <div
          @click="$emit('navigate', 'profil')"
          class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1"
        >
          <img
            :src="store.potensiWisata?.[0]?.foto_url || store.potensiWisata?.[0]?.image || '/images/hero-bg.png'"
            alt="Wisata"
            class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
            @error="handleImageError($event, 'potensi')"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-5 text-white">
            <h3 class="text-lg md:text-xl font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>Wisata</span>
              <ArrowRightIcon class="w-5 h-5 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

        <!-- Card: UMKM -->
        <div
          @click="$emit('navigate', 'produk')"
          class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1"
        >
          <img
            :src="store.products?.[0]?.image || '/images/anyaman-bambu.png'"
            alt="UMKM"
            class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
            @error="handleImageError($event, 'anyaman-bambu')"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-5 text-white">
            <h3 class="text-lg md:text-xl font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>UMKM</span>
              <ArrowRightIcon class="w-5 h-5 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

        <!-- Card: Galeri -->
        <div
          @click="$emit('navigate', 'galeri')"
          class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1"
        >
          <img
            :src="store.gallery?.[0]?.image || '/images/hero-bg.png'"
            alt="Galeri"
            class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
            @error="handleImageError($event, 'galeri-1')"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-3.5 md:p-4 text-white">
            <h3 class="text-sm md:text-base font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>Galeri</span>
              <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

        <!-- Card: Berita -->
        <div
          @click="$emit('navigate', 'informasi')"
          class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1"
        >
          <img
            :src="store.news?.[0]?.image || '/images/hero-bg.png'"
            alt="Berita"
            class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
            @error="handleImageError($event, 'news-0')"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-5 text-white">
            <h3 class="text-lg md:text-xl font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>Berita</span>
              <ArrowRightIcon class="w-5 h-5 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

      </div>
    </section>

    <!-- ============================================================ -->
    <!-- SECTION: SAMBUTAN + DATA DESA                                 -->
    <!-- ============================================================ -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-20">
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-12 items-start">

        <!-- KIRI: Sambutan -->
        <div class="lg:col-span-7 space-y-5">
          <span class="text-xs font-extrabold text-[#12544F] uppercase tracking-widest">
            Selamat Datang di Padukuhan
          </span>

          <h2 class="text-3xl sm:text-4xl md:text-[35px] font-extrabold text-[#165823] leading-tight tracking-tight">
            {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}
          </h2>

          <p class="text-sm md:text-base text-gray-600 leading-relaxed whitespace-pre-line">
            {{ store.padukuhanProfile?.sejarah }}
          </p>
        </div>

        <!-- KANAN: Kartu Data Desa -->
        <div class="lg:col-span-5 lg:pl-4">
          <div class="bg-white rounded-2xl overflow-hidden border border-gray-200 shadow-sm">

            <!-- Header -->
            <div class="bg-[#0D6847] px-6 py-3.5">
              <h3 class="text-white font-extrabold text-base tracking-wide">Data Padukuhan</h3>
            </div>

            <!-- Rows -->
            <div class="divide-y divide-gray-200">
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">Penduduk</span>
                <span class="text-base font-extrabold text-[#0D6847]">
                  {{ store.padukuhanProfile?.jumlah_penduduk ? store.padukuhanProfile.jumlah_penduduk.toLocaleString('id-ID') + ' jiwa' : '-' }}
                </span>
              </div>
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">Luas wilayah</span>
                <span class="text-base font-extrabold text-[#0D6847]">
                  {{ store.padukuhanProfile?.luas_wilayah || '-' }}
                </span>
              </div>
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">Dusun</span>
                <span class="text-base font-extrabold text-[#0D6847]">
                  {{ store.padukuhanProfile?.jumlah_dusun || '-' }}
                </span>
              </div>
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">RW / RT</span>
                <span class="text-base font-extrabold text-[#0D6847]">
                  {{ store.padukuhanProfile?.jumlah_rw || '-' }} / {{ store.padukuhanProfile?.jumlah_rt || '-' }}
                </span>
              </div>
            </div>

          </div>
        </div>

      </div>
    </section>

    <!-- ============================================================ -->
    <!-- SECTION 1: BERITA & PENGUMUMAN                                -->
    <!-- ============================================================ -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">

      <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
        <div>
          <span class="text-xs font-bold text-[#12544F] uppercase tracking-widest">Informasi</span>
          <h2 class="text-3xl md:text-4xl font-extrabold text-[#165823] mt-1">Berita &amp; Pengumuman</h2>
        </div>
        <button
          @click="$emit('navigate', 'informasi')"
          class="self-start md:self-auto flex items-center gap-1.5 text-sm font-bold text-[#0D6847] hover:text-[#0A5238] transition-colors group cursor-pointer"
        >
          <span>Semua Berita</span>
          <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
        </button>
      </div>

      <div v-if="store.news.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
        <article
          v-for="item in store.news.slice(0, 3)"
          :key="item.id"
          @click="$emit('navigate', 'informasi')"
          class="bg-white rounded-2xl overflow-hidden border border-gray-200 hover:shadow-xl transition-all duration-300 group cursor-pointer hover:-translate-y-1"
        >
          <div class="relative aspect-[16/10] bg-gray-100 overflow-hidden">
            <img
              :src="item.image"
              :alt="item.title"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              @error="handleImageError($event, 'news-' + item.id)"
            />
          </div>

          <div class="p-5 md:p-6 flex flex-col">
            <div class="flex items-center gap-1.5 text-[11px] font-bold text-[#0D6847] mb-2">
              <CalendarIcon class="w-3.5 h-3.5" />
              <span>{{ item.date }}</span>
            </div>
            <h3 class="text-lg font-extrabold text-[#0D6847] leading-snug group-hover:text-[#0A5238] transition-colors mb-2.5 line-clamp-2">
              {{ item.title }}
            </h3>
            <p class="text-sm text-gray-500 leading-relaxed line-clamp-3">
              {{ item.excerpt || item.content }}
            </p>
          </div>
        </article>
      </div>

      <div v-else class="text-center py-16 bg-gray-50 rounded-2xl border border-gray-200">
        <p class="text-sm text-gray-400 font-semibold">Belum ada berita yang dipublikasikan.</p>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- SECTION 2: HAL YANG BISA DILAKUKAN                            -->
    <!-- ============================================================ -->
    <section class="bg-white py-16 md:py-24 border-t border-gray-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <h2 class="text-3xl md:text-4xl font-extrabold text-[#165823]">Hal yang Bisa Dilakukan</h2>
          </div>
          <button
            @click="$emit('navigate', 'profil')"
            class="self-start md:self-auto flex items-center gap-1.5 text-sm font-bold text-[#0D6847] hover:text-[#0A5238] transition-colors group cursor-pointer"
          >
            <span>Semua Potensi</span>
            <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
          </button>
        </div>

        <div v-if="store.potensiWisata.length > 0" class="grid grid-cols-1 lg:grid-cols-2 gap-6 md:gap-8">

          <!-- Kartu Besar -->
          <div
            @click="$emit('navigate', 'profil')"
            class="relative rounded-2xl overflow-hidden min-h-[320px] md:min-h-[420px] group cursor-pointer shadow-sm hover:shadow-xl transition-all duration-300"
          >
            <img
              :src="store.potensiWisata[0].foto_url || store.potensiWisata[0].image || '/images/hero-bg.png'"
              :alt="store.potensiWisata[0].nama"
              class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
              @error="handleImageError($event, 'potensi')"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-[#0D6847] via-[#0D6847]/60 to-transparent"></div>

            <div class="relative h-full flex flex-col justify-end p-6 md:p-10 text-white">
              <h3 class="text-2xl md:text-3xl font-extrabold leading-tight mb-3">
                {{ store.potensiWisata[0].nama }}
              </h3>
              <p class="text-sm md:text-base text-white/85 leading-relaxed max-w-lg line-clamp-3">
                {{ store.potensiWisata[0].deskripsi }}
              </p>
            </div>
          </div>

          <!-- 2 Kartu Kecil -->
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-6 md:gap-8">
            <template v-for="(item, idx) in store.potensiWisata.slice(1, 3)" :key="item.id">
              <div
                @click="$emit('navigate', 'profil')"
                class="bg-white rounded-2xl overflow-hidden border border-gray-200 group cursor-pointer hover:shadow-lg transition-all duration-300 flex flex-col sm:flex-row lg:flex-col"
              >
                <div class="relative sm:w-2/5 lg:w-full aspect-[16/10] lg:aspect-[16/9] bg-gray-100 overflow-hidden shrink-0">
                  <img
                    :src="item.foto_url || item.image || '/images/hero-bg.png'"
                    :alt="item.nama"
                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                    @error="handleImageError($event, 'potensi')"
                  />
                </div>
                <div class="p-5 flex-1 flex flex-col">
                  <h3 class="text-base md:text-lg font-extrabold text-[#0D6847] group-hover:text-[#0A5238] transition-colors leading-snug mb-2">
                    {{ item.nama }}
                  </h3>
                  <p class="text-xs md:text-sm text-gray-500 leading-relaxed line-clamp-2">
                    {{ item.deskripsi }}
                  </p>
                </div>
              </div>
            </template>

            <div v-if="store.potensiWisata.length < 2" class="bg-gray-50 rounded-2xl border border-dashed border-gray-300 flex items-center justify-center p-8 text-center min-h-[180px]">
              <p class="text-xs text-gray-400 font-semibold">Belum ada potensi wisata lain.</p>
            </div>
          </div>

        </div>

        <div v-else class="text-center py-16 bg-gray-50 rounded-2xl border border-gray-200">
          <p class="text-sm text-gray-400 font-semibold">Belum ada data potensi desa.</p>
        </div>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- SECTION 3: UMKM UNGGULAN (BACKGROUND HIJAU)                  -->
    <!-- ============================================================ -->
    <section class="bg-[#0D6847] py-16 md:py-24">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <span class="text-xs font-bold text-[#86EFAC] uppercase tracking-widest">Produk Lokal</span>
            <h2 class="text-3xl md:text-4xl font-extrabold text-white mt-1">UMKM Unggulan</h2>
          </div>
          <button
            @click="$emit('navigate', 'produk')"
            class="self-start md:self-auto flex items-center gap-1.5 text-sm font-bold text-[#86EFAC] hover:text-white transition-colors group cursor-pointer"
          >
            <span>Lihat Semua</span>
            <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
          </button>
        </div>

        <div v-if="store.products.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 md:gap-6">
          <article
            v-for="product in store.products.slice(0, 4)"
            :key="product.id"
            class="bg-transparent flex flex-col group"
          >
            <div class="relative aspect-[4/3] rounded-2xl bg-emerald-900/40 overflow-hidden mb-4 cursor-pointer shadow-md group-hover:shadow-xl transition-shadow"
              @click="$emit('navigate', 'produk')">
              <img
                :src="product.image"
                :alt="product.name"
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError($event, 'product')"
              />
            </div>

            <div class="flex flex-col flex-1">
              <span class="text-[10px] font-bold text-[#86EFAC] uppercase tracking-widest mb-1">
                {{ product.category || 'Produk Lokal' }}
              </span>
              <h3 class="text-base font-extrabold text-white leading-snug mb-2 line-clamp-2">
                {{ product.name }}
              </h3>
              <p class="text-xs text-emerald-100/80 leading-relaxed line-clamp-2 mb-4 flex-1">
                {{ product.description || 'Produk asli warga Padukuhan Ngemplak Kalangan.' }}
              </p>

              <a
                :href="getWhatsAppUrl(product)"
                target="_blank"
                @click.stop
                class="w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-[#25D366] hover:bg-[#1EBE5A] text-white text-xs font-bold rounded-xl shadow-sm transition-all duration-200 active:scale-95 cursor-pointer"
              >
                <MessageCircleIcon class="w-4 h-4" />
                <span>WhatsApp</span>
              </a>
            </div>
          </article>
        </div>

        <div v-else class="text-center py-16 bg-white/5 rounded-2xl border border-white/10">
          <p class="text-sm text-gray-400 font-semibold">Belum ada produk UMKM yang ditambahkan.</p>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import {
  Search as SearchIcon,
  ArrowRight as ArrowRightIcon,
  Users as UsersIcon,
  ShoppingBag as ShoppingBagIcon,
  MapPin as MapPinIcon,
  Calendar as CalendarIcon,
  ChevronRight as ChevronRightIcon,
  Sparkles as SparklesIcon,
  Heart as HeartIcon,
  ShoppingCart as ShoppingCartIcon,
  MessageCircle as MessageCircleIcon,
  Compass as CompassIcon,
  Map as MapIcon
} from 'lucide-vue-next';

import { store } from '../store';

defineEmits(['navigate']);

// WhatsApp URL
const getWhatsAppUrl = (product) => {
  const phone = product.sellerPhone
    ? product.sellerPhone.replace(/[^0-9]/g, '')
    : '6281234567890';
  const text = encodeURIComponent(
    `Halo, saya berminat untuk memesan produk "${product.name}" (Rp ${(product.price || 0).toLocaleString('id-ID')}) yang ada di Website Padukuhan Ngemplak Kalangan. Mohon informasi pemesanan & ketersediaannya. Terima kasih!`
  );
  return `https://wa.me/${phone}?text=${text}`;
};

// Fallback logic for images
const handleImageError = (event, type) => {
  const fallbacks = {
    'hero-bg': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',
    'kepala-desa': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=400&q=80',
    'anyaman-bambu': 'https://images.unsplash.com/photo-1595475244128-90a36b67241a?auto=format&fit=crop&w=600&q=80',
    'potensi': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=800&q=80',
    'product': 'https://images.unsplash.com/photo-1595475244128-90a36b67241a?auto=format&fit=crop&w=600&q=80'
  };
  event.target.src = fallbacks[type] || 'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=600';
};
</script>