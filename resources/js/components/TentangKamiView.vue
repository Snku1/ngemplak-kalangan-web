<template>
  <div class="bg-[#F8FAFC]">
    <!-- HERO SECTION -->
    <section class="relative bg-gradient-to-b from-[#0B5439] via-[#0D6847] to-[#09472F] text-white py-16 md:py-24 overflow-hidden">
      <!-- Decorative Background Elements -->
      <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#fff_1px,transparent_1px)] [background-size:24px_24px] pointer-events-none"></div>
      
      <!-- Big Decorative Leaf Outline SVG on Top Right -->
      <div class="absolute -right-16 -top-16 opacity-15 pointer-events-none hidden lg:block">
        <svg width="480" height="480" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="0.8">
          <path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/>
          <path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/>
        </svg>
      </div>

      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div class="max-w-3xl">
          <!-- Top Tag Badge -->
          <span class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/20 text-xs font-semibold tracking-wider text-emerald-200 uppercase mb-5">
            <HeartIcon class="w-3.5 h-3.5 text-emerald-300" />
            <span>Mengenal Lebih Dekat</span>
          </span>

          <!-- Main Title -->
          <h1 class="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight leading-tight mb-5">
            Tentang Kami — <br class="hidden sm:inline" />
            <span class="text-emerald-200">Padukuhan Ngemplak Kalangan</span>
          </h1>

          <!-- Subtitle -->
          <p class="text-sm md:text-base text-emerald-100/90 leading-relaxed mb-8 max-w-2xl">
            Mengenal jati diri, sejarah luhur, dedikasi pengurus, serta kehangatan nilai gotong royong dalam membangun padukuhan yang asri, rukun, berbudaya, dan berdaya mandiri.
          </p>

          <!-- Highlights Chips -->
          <div class="flex flex-wrap items-center gap-3 pt-2">
            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-white/10 backdrop-blur-md border border-white/15 text-xs font-medium text-white shadow-sm">
              <div class="w-5 h-5 rounded-full bg-emerald-400/20 flex items-center justify-center text-emerald-300 shrink-0">
                <LeafIcon class="w-3 h-3" />
              </div>
              <span><strong>Lingkungan Asri</strong> & Harmonis</span>
            </div>

            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-white/10 backdrop-blur-md border border-white/15 text-xs font-medium text-white shadow-sm">
              <div class="w-5 h-5 rounded-full bg-emerald-400/20 flex items-center justify-center text-emerald-300 shrink-0">
                <UsersIcon class="w-3 h-3" />
              </div>
              <span><strong>Guyub Rukun</strong> & Gotong Royong</span>
            </div>

            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-white/10 backdrop-blur-md border border-white/15 text-xs font-medium text-white shadow-sm">
              <div class="w-5 h-5 rounded-full bg-emerald-400/20 flex items-center justify-center text-emerald-300 shrink-0">
                <SparklesIcon class="w-3 h-3" />
              </div>
              <span><strong>Kearifan Budaya</strong> Lestari</span>
            </div>
          </div>

        </div>
      </div>
    </section>

    <!-- STATS OVERVIEW SECTION -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-8 relative z-20">
      <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
        <div class="bg-white rounded-2xl p-5 sm:p-6 shadow-lg shadow-gray-200/50 border border-gray-100 flex items-center gap-4">
          <div class="w-12 h-12 rounded-xl bg-emerald-50 text-[#0D6847] flex items-center justify-center shrink-0">
            <UsersIcon class="w-6 h-6" />
          </div>
          <div>
            <h3 class="text-2xl font-extrabold text-gray-900">4.829+</h3>
            <p class="text-xs font-medium text-gray-500">Jiwa Warga</p>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-5 sm:p-6 shadow-lg shadow-gray-200/50 border border-gray-100 flex items-center gap-4">
          <div class="w-12 h-12 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center shrink-0">
            <MapPinIcon class="w-6 h-6" />
          </div>
          <div>
            <h3 class="text-2xl font-extrabold text-gray-900">2 Dusun</h3>
            <p class="text-xs font-medium text-gray-500">Ngemplak & Kalangan</p>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-5 sm:p-6 shadow-lg shadow-gray-200/50 border border-gray-100 flex items-center gap-4">
          <div class="w-12 h-12 rounded-xl bg-amber-50 text-amber-600 flex items-center justify-center shrink-0">
            <ShoppingBagIcon class="w-6 h-6" />
          </div>
          <div>
            <h3 class="text-2xl font-extrabold text-gray-900">50+</h3>
            <p class="text-xs font-medium text-gray-500">UMKM & Pengrajin</p>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-5 sm:p-6 shadow-lg shadow-gray-200/50 border border-gray-100 flex items-center gap-4">
          <div class="w-12 h-12 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center shrink-0">
            <HeartIcon class="w-6 h-6" />
          </div>
          <div>
            <h3 class="text-2xl font-extrabold text-gray-900">100%</h3>
            <p class="text-xs font-medium text-gray-500">Semangat Guyub</p>
          </div>
        </div>
      </div>
    </section>

    <!-- SEJARAH & PERJALANAN DUSUN -->
    <section class="py-16 md:py-24">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
          <!-- Text & Story Column (7 cols) -->
          <div class="lg:col-span-7 space-y-6">
            <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-50 text-[#0D6847] border border-emerald-100 text-xs font-bold uppercase tracking-wider">
              <HistoryIcon class="w-3.5 h-3.5" />
              <span>Sejarah &amp; Asal Usul</span>
            </div>
            
            <h2 class="text-2xl sm:text-3xl md:text-4xl font-extrabold text-gray-900 tracking-tight leading-snug">
              Warisan Luhur Dua Dusun yang Menjadi Satu Kebanggaan
            </h2>

            <p class="text-xs sm:text-sm text-gray-600 leading-relaxed">
              Padukuhan Ngemplak Kalangan lahir dari perpaduan dua komunitas pemukiman bersejarah di kawasan Kalasan, Sleman: <strong>Dusun Ngemplak</strong> yang dikenal dengan kesuburan tanah pertanian serta persawahannya, dan <strong>Dusun Kalangan</strong> yang sarat dengan aktivitas kebudayaan, seni tradisi, dan kerajinan rakyat.
            </p>

            <p class="text-xs sm:text-sm text-gray-600 leading-relaxed">
              Sejak dahulu kala, masyarakat kedua dusun senantiasa menjunjung tinggi tradisi musyawarah mufakat, malam tirakatan kebangsaan, serta kesenian <em>Seni Rodat</em>. Harmoni antargenerasi ini terus terpelihara hingga saat ini menjadi pilar utama kemajuan padukuhan yang mandiri dan berdaya saing.
            </p>

            <!-- Key Milestones -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-4">
              <div class="bg-white p-4 rounded-2xl border border-gray-150 shadow-2xs">
                <div class="text-[#0D6847] font-extrabold text-base mb-1">Tradisi Guyub Rukun</div>
                <p class="text-xs text-gray-500 leading-relaxed">Kegiatan sambatan, gotong royong siskamling, dan arisan warga berjalan aktif setiap pekannya.</p>
              </div>

              <div class="bg-white p-4 rounded-2xl border border-gray-150 shadow-2xs">
                <div class="text-[#0D6847] font-extrabold text-base mb-1">Sentra Pengrajin & Tani</div>
                <p class="text-xs text-gray-500 leading-relaxed">Melahirkan karya anyaman bambu bernilai seni tinggi, batik tulis khas, dan hasil bumi organik segar.</p>
              </div>
            </div>
          </div>

          <!-- Visual Gallery Box (5 cols) -->
          <div class="lg:col-span-5">
            <div class="relative">
              <div class="relative z-10 rounded-3xl overflow-hidden shadow-2xl border-4 border-white bg-gray-100 aspect-[4/3]">
                <img 
                  src="/images/jalan-dusun.png" 
                  alt="Suasana Pedusunan Ngemplak Kalangan" 
                  class="w-full h-full object-cover"
                  @error="handleImageFallback($event)"
                />
              </div>

              <!-- Decorative Badge Overlay -->
              <div class="absolute -bottom-6 -left-6 z-20 bg-white p-4.5 rounded-2xl shadow-xl border border-gray-150 flex items-center gap-3.5 max-w-xs">
                <div class="w-11 h-11 rounded-xl bg-[#0D6847] text-white flex items-center justify-center shrink-0">
                  <SparklesIcon class="w-5 h-5" />
                </div>
                <div>
                  <h4 class="text-xs font-bold text-gray-900">Padukuhan Asri & Lestari</h4>
                  <p class="text-[10px] text-gray-500">Kalasan, Sleman, D.I. Yogyakarta</p>
                </div>
              </div>
            </div>
          </div>

        </div>

      </div>
    </section>

    <!-- VISI, MISI & 4 PILAR NILAI UTAMA -->
    <section class="py-16 bg-white border-t border-b border-gray-150">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center max-w-2xl mx-auto mb-14">
          <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-50 text-[#0D6847] border border-emerald-100 text-xs font-bold uppercase tracking-wider mb-3">
            <TargetIcon class="w-3.5 h-3.5" />
            <span>Arah &amp; Nilai Dasar</span>
          </div>
          <h2 class="text-2xl sm:text-3xl md:text-4xl font-extrabold text-gray-900 tracking-tight">
            Visi, Misi &amp; Nilai Kebersamaan
          </h2>
          <p class="text-xs sm:text-sm text-gray-500 mt-2">
            Pedoman bersama dalam mewujudkan kesejahteraan seluruh warga padukuhan.
          </p>
        </div>

        <!-- Visi Banner -->
        <div class="bg-gradient-to-br from-[#0D6847] to-[#08442E] rounded-3xl p-8 sm:p-10 text-white mb-12 shadow-lg relative overflow-hidden">
          <div class="relative z-10 max-w-3xl">
            <span class="text-xs font-bold text-emerald-300 uppercase tracking-widest block mb-2">Visi Padukuhan</span>
            <blockquote class="text-xl sm:text-2xl md:text-3xl font-extrabold leading-snug tracking-tight mb-4">
              “Terwujudnya Padukuhan Ngemplak Kalangan yang Mandiri, Asri, Rukun, dan Berbudaya Berlandaskan Semangat Gotong Royong.”
            </blockquote>
            <p class="text-xs sm:text-sm text-emerald-100/80 leading-relaxed">
              Komitmen bersama untuk membangun masa depan padukuhan yang berkeadilan, lestari lingkungannya, dan berdaya saing dalam meningkatkan martabat warga.
            </p>
          </div>
          <!-- Watermark Leaf -->
          <div class="absolute -right-8 -bottom-8 opacity-10 pointer-events-none">
            <svg width="240" height="240" viewBox="0 0 24 24" fill="currentColor">
              <path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/>
            </svg>
          </div>
        </div>

        <!-- 4 Nilai Utama Dusun -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div class="bg-gray-50 rounded-2xl p-6 border border-gray-150 hover:bg-white hover:shadow-xl hover:-translate-y-1 transition-all duration-300 group">
            <div class="w-12 h-12 rounded-xl bg-emerald-100 text-[#0D6847] flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
              <UsersIcon class="w-6 h-6" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">1. Guyub Rukun</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Menjaga tali silaturahmi, toleransi, dan persaudaraan erat antarwarga dari semua kalangan dan usia.
            </p>
          </div>

          <div class="bg-gray-50 rounded-2xl p-6 border border-gray-150 hover:bg-white hover:shadow-xl hover:-translate-y-1 transition-all duration-300 group">
            <div class="w-12 h-12 rounded-xl bg-blue-100 text-blue-600 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
              <HandshakeIcon class="w-6 h-6" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">2. Gotong Royong</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Kerja bersama dalam merawat fasilitas umum, membersihkan lingkungan, dan saling membantu dalam kesulitan.
            </p>
          </div>

          <div class="bg-gray-50 rounded-2xl p-6 border border-gray-150 hover:bg-white hover:shadow-xl hover:-translate-y-1 transition-all duration-300 group">
            <div class="w-12 h-12 rounded-xl bg-amber-100 text-amber-600 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
              <LeafIcon class="w-6 h-6" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">3. Asri &amp; Lestari</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Menjaga kelestarian alam, pekarangan pangan hijau, serta kebersihan selokan dan jalan dusun yang asri.
            </p>
          </div>

          <div class="bg-gray-50 rounded-2xl p-6 border border-gray-150 hover:bg-white hover:shadow-xl hover:-translate-y-1 transition-all duration-300 group">
            <div class="w-12 h-12 rounded-xl bg-purple-100 text-purple-600 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
              <SparklesIcon class="w-6 h-6" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">4. Berdaya Mandiri</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Mendorong ekonomi kreatif warga lewat kerajinan anyaman bambu, batik tulis, dan produk pertanian lokal.
            </p>
          </div>
        </div>

      </div>
    </section>

    <!-- TOKOH & PENGGERAK MASYARAKAT SECTION -->
    <section class="py-16 md:py-24 bg-[#F8FAFC]">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-4">
          <div>
            <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-50 text-[#0D6847] border border-emerald-100 text-xs font-bold uppercase tracking-wider mb-3">
              <AwardIcon class="w-3.5 h-3.5" />
              <span>Penggerak Dusun</span>
            </div>
            <h2 class="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight">
              Tokoh &amp; Lembaga Padukuhan
            </h2>
            <p class="text-xs sm:text-sm text-gray-500 mt-1">
              Bersinergi bersama masyarakat mewujudkan Padukuhan Ngemplak Kalangan yang harmonis.
            </p>
          </div>

          <button 
            @click="$emit('navigate', 'profil')"
            class="px-5 py-2.5 bg-white border border-gray-200 hover:border-[#0D6847] hover:text-[#0D6847] text-xs font-bold rounded-xl transition-all shadow-xs cursor-pointer"
          >
            Lihat Struktur Lengkap Dusun
          </button>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="leader in store.leaders" :key="leader.id" class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm hover:shadow-lg transition-all text-center group">
            <div class="w-24 h-24 mx-auto rounded-2xl overflow-hidden mb-4 bg-gray-100 border border-gray-200 flex items-center justify-center text-3xl font-bold text-gray-400">
              {{ leader.name.charAt(0) }}
            </div>
            <h3 class="font-bold text-sm text-gray-900">{{ leader.name }}</h3>
            <p class="text-[11px] font-bold text-[#0D6847] mt-0.5">{{ leader.role }}</p>
            <p class="text-[11px] text-gray-500 mt-2 leading-relaxed">{{ leader.description || leader.focus }}</p>
          </div>
        </div>

      </div>
    </section>

    <!-- FASILITAS & SARANA DUSUN SECTION -->
    <section class="py-16 bg-white border-t border-b border-gray-150">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center max-w-2xl mx-auto mb-14">
          <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-50 text-[#0D6847] border border-emerald-100 text-xs font-bold uppercase tracking-wider mb-3">
            <BuildingIcon class="w-3.5 h-3.5" />
            <span>Fasilitas Dusun</span>
          </div>
          <h2 class="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight">
            Sarana &amp; Fasilitas Bersama Warga
          </h2>
          <p class="text-xs sm:text-sm text-gray-500 mt-1">
            Fasilitas umum penunjang aktivitas sosial, peribadatan, dan kebersamaan warga.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          
          <div v-for="facility in store.facilities" :key="facility.id" class="bg-gray-50 rounded-2xl p-6 border border-gray-100">
            <div class="w-12 h-12 rounded-xl bg-emerald-100 text-[#0D6847] flex items-center justify-center mb-4">
              <BuildingIcon v-if="facility.kategori === 'wisata'" class="w-6 h-6" />
              <ShieldCheckIcon v-else class="w-6 h-6" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">{{ facility.nama }}</h3>
            <p class="text-xs text-gray-600 leading-relaxed mb-3">
              {{ facility.deskripsi }}
            </p>
            <span v-if="facility.lokasi" class="inline-block text-[10px] font-bold text-[#0D6847] bg-emerald-100/60 px-2.5 py-1 rounded-md">{{ facility.lokasi }}</span>
          </div>

        </div>

      </div>
    </section>

    <!-- FAQ SECTION -->
    <section class="py-16 bg-[#F8FAFC]">
      <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-50 text-[#0D6847] border border-emerald-100 text-xs font-bold uppercase tracking-wider mb-3">
            <HelpCircleIcon class="w-3.5 h-3.5" />
            <span>Pertanyaan Umum</span>
          </div>
          <h2 class="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight">
            Tanya Jawab Seputar Padukuhan
          </h2>
          <p class="text-xs sm:text-sm text-gray-500 mt-1">
            Informasi praktis yang sering ditanyakan oleh tamu dan warga.
          </p>
        </div>

        <div class="space-y-4">
          <div 
            v-for="(faq, index) in store.faqs" 
            :key="faq.id || index"
            class="bg-white rounded-2xl border border-gray-200/80 overflow-hidden shadow-2xs transition-all duration-200"
          >
            <button 
              @click="toggleFaq(index)"
              class="w-full p-5 text-left flex items-center justify-between gap-4 font-bold text-sm text-gray-800 hover:text-[#0D6847] transition-colors cursor-pointer"
            >
              <span>{{ faq.question }}</span>
              <ChevronDownIcon 
                :class="openFaqIndex === index ? 'rotate-180 text-[#0D6847]' : 'text-gray-400'"
                class="w-5 h-5 shrink-0 transition-transform duration-200"
              />
            </button>
            
            <div 
              v-if="openFaqIndex === index" 
              class="px-5 pb-5 pt-1 text-xs sm:text-sm text-gray-600 leading-relaxed border-t border-gray-100 bg-gray-50/50"
            >
              {{ faq.answer }}
            </div>
          </div>
        </div>

      </div>
    </section>

    <!-- CALL TO ACTION BANNER (EXPLORE MORE) -->
    <section class="py-12 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-gradient-to-r from-[#0D6847] to-[#0A5238] rounded-3xl p-8 sm:p-12 text-white flex flex-col md:flex-row items-center justify-between gap-8 shadow-xl">
          <div class="max-w-2xl">
            <h3 class="text-2xl sm:text-3xl font-extrabold tracking-tight mb-3">
              Dukung Produk Karya Warga Padukuhan Kami
            </h3>
            <p class="text-xs sm:text-sm text-emerald-100/90 leading-relaxed">
              Jelajahi berbagai produk kerajinan tangan, batik tulis, kopi organik, dan olahan makanan khas karya pengrajin asli Dusun Ngemplak Kalangan.
            </p>
          </div>

          <div class="flex flex-wrap items-center gap-3 shrink-0">
            <button 
              @click="$emit('navigate', 'produk')"
              class="px-6 py-3.5 bg-white hover:bg-emerald-50 text-[#0D6847] font-bold text-xs rounded-xl shadow-md transition-all active:scale-95 cursor-pointer flex items-center gap-2"
            >
              <ShoppingBagIcon class="w-4 h-4" />
              <span>Lihat Produk Desa</span>
            </button>

            <button 
              @click="$emit('navigate', 'galeri')"
              class="px-6 py-3.5 bg-white/15 hover:bg-white/25 text-white font-bold text-xs rounded-xl border border-white/20 transition-all active:scale-95 cursor-pointer flex items-center gap-2"
            >
              <SparklesIcon class="w-4 h-4" />
              <span>Galeri Foto &amp; Video</span>
            </button>
          </div>
        </div>
      </div>
    </section>

  </div>
</template>

<script setup>
import { ref } from 'vue';
import { 
  Heart as HeartIcon,
  Leaf as LeafIcon,
  Users as UsersIcon,
  Sparkles as SparklesIcon,
  MapPin as MapPinIcon,
  ShoppingBag as ShoppingBagIcon,
  History as HistoryIcon,
  Target as TargetIcon,
  Award as AwardIcon,
  Building as BuildingIcon,
  BookOpen as BookOpenIcon,
  ShieldCheck as ShieldCheckIcon,
  Handshake as HandshakeIcon,
  HelpCircle as HelpCircleIcon,
  ChevronDown as ChevronDownIcon
} from 'lucide-vue-next';
import { store } from '../store';

const openFaqIndex = ref(0);

const toggleFaq = (index) => {
  openFaqIndex.value = openFaqIndex.value === index ? null : index;
};

const handleImageFallback = (event) => {
  event.target.src = '/images/hero-bg.png';
};
</script>
