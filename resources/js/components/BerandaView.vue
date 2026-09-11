<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative min-h-[560px] md:min-h-[640px] flex items-center justify-center overflow-hidden bg-gray-900 text-white">
      <!-- Background Image with Overlay -->
      <div class="absolute inset-0 z-0">
        <img 
          src="/images/hero-bg.png" 
          alt="Latar Belakang Padukuhan" 
          class="w-full h-full object-cover object-center opacity-70 scale-105 animate-pulse-slow"
          @error="handleImageError($event, 'hero-bg')"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-900/60 to-gray-950/40"></div>
      </div>

      <!-- Hero Content -->
      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center py-20 md:py-28">
        <span class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/20 text-xs font-semibold tracking-wider uppercase mb-6 text-emerald-200">
          <span class="w-2 h-2 rounded-full bg-emerald-400 animate-ping"></span>
          Selamat Datang di Website Resmi
        </span>
        <h2 class="text-4xl md:text-6xl font-extrabold tracking-tight leading-tight md:leading-tight mb-6">
          Membangun Masa Depan <br/>
          <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-200">Padukuhan Ngemplak Kalangan</span>
        </h2>
        <p class="text-base md:text-lg text-gray-200 max-w-2xl mx-auto leading-relaxed mb-10">
          Harmoni kehidupan masyarakat yang asri, berbudaya, dan berdaya mandiri dengan semangat gotong royong di Padukuhan Ngemplak Kalangan.
        </p>

        <!-- CTA Buttons -->
        <div class="flex flex-col sm:flex-row justify-center items-center gap-4 sm:gap-6">
          <button 
            @click="$emit('navigate', 'produk')"
            class="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-7 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white font-bold rounded-xl shadow-lg hover:shadow-emerald-900/30 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer"
          >
            <span>Jelajahi Produk Desa</span>
            <ArrowRightIcon class="w-4 h-4" />
          </button>
          <button 
            @click="$emit('navigate', 'tentang-kami')" 
            class="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-7 py-3.5 bg-white/10 hover:bg-white/20 text-white font-bold rounded-xl border border-white/30 backdrop-blur-sm transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer"
          >
            <span>Tentang Dusun Kami</span>
          </button>
        </div>
      </div>
    </section>

    <!-- STATS CARD SECTION (CENTERED & OVERLAPPING) -->
    <section class="relative z-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex flex-col md:flex-row items-stretch justify-center gap-6 -mt-16 md:-mt-24">
        
        <!-- Stat Card 1: Penduduk -->
        <div class="flex-1 max-w-xs bg-white rounded-2xl p-6.5 shadow-xl shadow-gray-200/50 border border-gray-100 hover:shadow-2xl transition-all duration-300 group hover:-translate-y-1">
          <div class="flex items-start justify-between mb-4">
            <div>
              <p class="text-xs font-bold text-gray-500 uppercase tracking-wider">Total Penduduk</p>
              <h3 class="text-3xl font-extrabold text-gray-900 mt-1">
                {{ store.padukuhanProfile?.jumlah_penduduk ? store.padukuhanProfile.jumlah_penduduk.toLocaleString('id-ID') + ' Jiwa' : '4,829 Jiwa' }}
              </h3>
            </div>
            <div class="p-3.5 rounded-xl bg-blue-50 text-blue-600 group-hover:scale-110 transition-transform duration-300">
              <UsersIcon class="w-6 h-6" />
            </div>
          </div>
          <p class="text-xs text-gray-400 font-medium">{{ store.padukuhanProfile?.kecamatan ? store.padukuhanProfile.kecamatan + ', ' + store.padukuhanProfile.kabupaten : 'Berdasarkan data kependudukan terbaru.' }}</p>
        </div>

        <!-- Stat Card 2 -->
        <div class="flex-1 max-w-xs bg-white rounded-2xl p-6.5 shadow-xl shadow-gray-200/50 border border-gray-100 hover:shadow-2xl transition-all duration-300 group hover:-translate-y-1">
          <div class="flex items-start justify-between mb-4">
            <div>
              <p class="text-xs font-bold text-gray-500 uppercase tracking-wider">Potensi UMKM</p>
              <h3 class="text-3xl font-extrabold text-gray-900 mt-1">{{ store.products.length }}+ Produk</h3>
            </div>
            <div class="p-3.5 rounded-xl bg-emerald-50 text-[#0D6847] group-hover:scale-110 transition-transform duration-300">
              <ShoppingBagIcon class="w-6 h-6" />
            </div>
          </div>
          <p class="text-xs text-gray-400 font-medium">Pengrajin Anyaman, Batik Tulis, & Hasil Bumi.</p>
        </div>

        <!-- Stat Card 3: Wilayah RT/RW -->
        <div class="flex-1 max-w-xs bg-white rounded-2xl p-6.5 shadow-xl shadow-gray-200/50 border border-gray-100 hover:shadow-2xl transition-all duration-300 group hover:-translate-y-1">
          <div class="flex items-start justify-between mb-4">
            <div>
              <p class="text-xs font-bold text-gray-500 uppercase tracking-wider">Wilayah RT / RW</p>
              <h3 class="text-3xl font-extrabold text-gray-900 mt-1">
                {{ store.padukuhanProfile?.jumlah_rt ? store.padukuhanProfile.jumlah_rt + ' RT / ' + store.padukuhanProfile.jumlah_rw + ' RW' : '12 RT / 4 RW' }}
              </h3>
            </div>
            <div class="p-3.5 rounded-xl bg-amber-50 text-amber-600 group-hover:scale-110 transition-transform duration-300">
              <MapPinIcon class="w-6 h-6" />
            </div>
          </div>
          <p class="text-xs text-gray-400 font-medium">{{ store.padukuhanProfile?.jumlah_kk ? store.padukuhanProfile.jumlah_kk + ' KK terdaftar' : 'Tersebar di Dusun Ngemplak & Kalangan.' }}</p>
        </div>

      </div>
    </section>

    <!-- MAIN CONTENT: BERITA & INFO SECTION -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
      
      <!-- Section Header -->
      <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
        <div>
          <span class="text-xs font-bold text-[#0D6847] uppercase tracking-widest">Kabar Terkini</span>
          <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950 mt-1">Berita & Informasi Padukuhan</h2>
        </div>
        <button 
          @click="$emit('navigate', 'informasi')"
          class="self-start md:self-auto flex items-center gap-1.5 text-xs font-bold text-[#0D6847] hover:text-[#0A5238] transition-colors group cursor-pointer"
        >
          <span>Lihat Semua Berita</span>
          <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
        </button>
      </div>

      <!-- Content Grid: News (8 cols) & Sidebar (4 cols) -->
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        <!-- LEFT COLUMN: NEWS ARTICLES (8 cols) -->
        <div class="lg:col-span-8 space-y-8">
          
          <!-- Dynamic News Article Cards -->
          <article 
            v-for="(item, idx) in store.news.slice(0, 3)" 
            :key="item.id"
            :class="idx === 2 ? 'bg-white rounded-3xl border border-gray-150 overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300 group' : 'bg-white rounded-3xl border border-gray-150 overflow-hidden shadow-sm hover:shadow-lg transition-all duration-300 flex flex-col md:flex-row group'"
          >
            <!-- Image for 1st & 2nd articles -->
            <div v-if="idx < 2" class="md:w-5/12 relative overflow-hidden aspect-[16/10] md:aspect-auto bg-gray-100 min-h-[200px]">
              <img 
                :src="item.image" 
                :alt="item.title" 
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError($event, 'news-' + item.id)"
              />
              <span class="absolute top-3.5 left-3.5 px-3 py-1 bg-white/90 backdrop-blur-md text-[#0D6847] text-[10px] font-bold uppercase rounded-md shadow-sm">
                {{ item.category }}
              </span>
            </div>

            <div v-if="idx < 2" class="p-6 md:w-7/12 flex flex-col justify-between">
              <div>
                <div class="flex items-center gap-2 text-xs text-gray-400 font-semibold mb-2">
                  <CalendarIcon class="w-3.5 h-3.5" />
                  <span>{{ item.date }}</span>
                </div>
                <h3 class="text-lg font-bold text-gray-900 leading-snug group-hover:text-[#0D6847] transition-colors mb-2.5">
                  {{ item.title }}
                </h3>
                <p class="text-xs text-gray-500 leading-relaxed mb-4 line-clamp-3">
                  {{ item.excerpt || item.content }}
                </p>
              </div>
              <button 
                @click="$emit('navigate', 'informasi')" 
                class="inline-flex items-center gap-1.5 text-xs font-bold text-[#0D6847] group-hover:underline cursor-pointer self-start"
              >
                <span>Baca Selengkapnya</span>
                <ChevronRightIcon class="w-4 h-4" />
              </button>
            </div>

            <!-- Full Width Highlight for 3rd article -->
            <template v-else>
              <div class="relative overflow-hidden aspect-[21/9] bg-gray-100">
                <img 
                  :src="item.image" 
                  :alt="item.title" 
                  class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  @error="handleImageError($event, 'news-' + item.id)"
                />
                <span class="absolute top-4 left-4 px-3 py-1 bg-[#0D6847] text-white text-[10px] font-bold uppercase rounded-md shadow-sm">
                  {{ item.category }}
                </span>
              </div>
              <div class="p-6 sm:p-8">
                <div class="flex items-center gap-2 text-xs text-gray-400 font-semibold mb-2">
                  <CalendarIcon class="w-3.5 h-3.5" />
                  <span>{{ item.date }}</span>
                </div>
                <h3 class="text-xl font-bold text-gray-900 leading-snug group-hover:text-[#0D6847] transition-colors mb-3">
                  {{ item.title }}
                </h3>
                <p class="text-sm text-gray-500 leading-relaxed mb-6">
                  {{ item.excerpt || item.content }}
                </p>
                <button 
                  @click="$emit('navigate', 'informasi')" 
                  class="inline-flex items-center gap-1.5 text-sm font-bold text-[#0D6847] group-hover:underline cursor-pointer"
                >
                  <span>Baca Selengkapnya</span>
                  <ChevronRightIcon class="w-4 h-4" />
                </button>
              </div>
            </template>
          </article>
        </div>

        <!-- RIGHT COLUMN: SIDEBAR (4 cols) -->
        <div class="lg:col-span-4 space-y-8">
          
          <!-- Quick Access / Potensi Dusun List -->
          <div class="bg-[#F0FAF5] rounded-3xl p-6.5 border border-[#D1EEDB] shadow-sm">
            <div class="flex items-center gap-3 pb-4 border-b border-[#D1EEDB]/80 mb-5">
              <div class="w-9 h-9 rounded-xl bg-[#0D6847]/10 flex items-center justify-center text-[#0D6847] shrink-0">
                <SparklesIcon class="w-5 h-5" />
              </div>
              <div>
                <h3 class="font-extrabold text-[#0A5238] text-base leading-tight">Akses Cepat Padukuhan</h3>
                <p class="text-[11px] text-emerald-800/70 font-medium">Navigasi informasi desa</p>
              </div>
            </div>
            
            <div class="space-y-3.5 mb-6">
              <!-- Item 1 -->
              <div 
                @click="$emit('navigate', 'tentang-kami')" 
                class="flex items-center gap-3.5 bg-white p-3.5 rounded-2xl border border-gray-150 hover:border-[#0D6847]/40 hover:shadow-md transition-all cursor-pointer group"
              >
                <div class="w-10 h-10 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center shrink-0 group-hover:scale-105 transition-transform">
                  <HeartIcon class="w-5 h-5" />
                </div>
                <div class="min-w-0">
                  <h4 class="text-xs font-bold text-gray-900 leading-tight group-hover:text-[#0D6847] transition-colors">Tentang Dusun Kami</h4>
                  <p class="text-[11px] text-gray-500 mt-0.5 leading-snug line-clamp-1">Sejarah, visi misi, &amp; nilai gotong royong.</p>
                </div>
              </div>

              <!-- Item 2 -->
              <div 
                @click="$emit('navigate', 'produk')" 
                class="flex items-center gap-3.5 bg-white p-3.5 rounded-2xl border border-gray-150 hover:border-[#0D6847]/40 hover:shadow-md transition-all cursor-pointer group"
              >
                <div class="w-10 h-10 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center shrink-0 group-hover:scale-105 transition-transform">
                  <ShoppingBagIcon class="w-5 h-5" />
                </div>
                <div class="min-w-0">
                  <h4 class="text-xs font-bold text-gray-900 leading-tight group-hover:text-[#0D6847] transition-colors">Produk Unggulan UMKM</h4>
                  <p class="text-[11px] text-gray-500 mt-0.5 leading-snug line-clamp-1">Anyaman bambu, batik, &amp; hasil bumi.</p>
                </div>
              </div>

              <!-- Item 3 -->
              <div 
                @click="$emit('navigate', 'galeri')" 
                class="flex items-center gap-3.5 bg-white p-3.5 rounded-2xl border border-gray-150 hover:border-[#0D6847]/40 hover:shadow-md transition-all cursor-pointer group"
              >
                <div class="w-10 h-10 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center shrink-0 group-hover:scale-105 transition-transform">
                  <SparklesIcon class="w-5 h-5" />
                </div>
                <div class="min-w-0">
                  <h4 class="text-xs font-bold text-gray-900 leading-tight group-hover:text-[#0D6847] transition-colors">Galeri &amp; Seni Budaya</h4>
                  <p class="text-[11px] text-gray-500 mt-0.5 leading-snug line-clamp-1">Dokumentasi tradisi &amp; seni rodat.</p>
                </div>
              </div>
            </div>

            <button 
              @click="$emit('navigate', 'tentang-kami')"
              class="w-full py-3 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl transition-all duration-300 flex items-center justify-center gap-2 shadow-sm hover:shadow-md cursor-pointer active:scale-98"
            >
              <span>Kenali Lebih Dekat</span>
              <ArrowRightIcon class="w-3.5 h-3.5" />
            </button>
          </div>

          <!-- Kepala Desa / Quote -->
          <div class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm">
            <div class="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
              <span class="w-2 h-2 rounded-full bg-[#0D6847]"></span>
              <h3 class="font-extrabold text-gray-900 text-sm tracking-tight">Kepala Padukuhan Kami</h3>
            </div>
            
            <div class="flex flex-col items-center text-center">
              <div class="w-full max-w-[200px] aspect-[4/5] rounded-2xl overflow-hidden mb-4 bg-gray-100 border border-gray-200 shadow-xs group">
                <img 
                  :src="store.padukuhanProfile?.foto_dukuh || '/images/kepala-desa.png'" 
                  :alt="store.padukuhanProfile?.nama_dukuh || 'Bapak Supriyanto'" 
                  class="w-full h-full object-cover object-top group-hover:scale-105 transition-transform duration-300"
                  @error="handleImageError($event, 'kepala-desa')"
                />
              </div>
              <h4 class="font-extrabold text-gray-950 text-base leading-tight">{{ store.padukuhanProfile?.nama_dukuh || 'Bapak Supriyanto' }}</h4>
              <p class="text-[10px] font-bold text-[#0D6847] uppercase tracking-widest mt-1">Kepala Dukuh {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}</p>
              
              <div class="bg-gray-50 rounded-2xl p-4 mt-4 border border-gray-100 text-left w-full">
                <p class="text-xs italic text-gray-600 leading-relaxed whitespace-pre-line">
                  “{{ store.padukuhanProfile?.sambutan_dukuh || 'Kesejahteraan dan kemajuan padukuhan terwujud saat seluruh warga bergandengan tangan, rukun, dan saling menjaga.' }}”
                </p>
              </div>
            </div>
          </div>

          <!-- Galeri Mini Card -->
          <div class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm">
            <div class="flex items-center justify-between mb-4 pb-3 border-b border-gray-100">
              <div class="flex items-center gap-2">
                <span class="w-2 h-2 rounded-full bg-[#0D6847]"></span>
                <h3 class="font-extrabold text-gray-900 text-sm tracking-tight">Galeri Kegiatan</h3>
              </div>
              <button 
                @click="$emit('navigate', 'galeri')" 
                class="text-xs font-bold text-[#0D6847] hover:underline cursor-pointer"
              >
                Lihat Semua
              </button>
            </div>
            
            <div class="grid grid-cols-2 gap-3">
              <div 
                v-for="img in store.gallery.slice(0, 2)" 
                :key="img.id"
                class="aspect-square rounded-2xl overflow-hidden bg-gray-100 relative group cursor-pointer border border-gray-100" 
                @click="$emit('navigate', 'galeri')"
              >
                <img 
                  :src="img.image" 
                  :alt="img.title" 
                  class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                  @error="handleImageError($event, 'galeri-1')"
                />
                <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col items-center justify-center">
                  <SearchIcon class="w-5 h-5 text-white mb-1" />
                  <span class="text-[8px] text-white font-bold uppercase tracking-wider px-2 text-center">{{ img.title }}</span>
                </div>
              </div>
              <div v-if="store.gallery.length === 0" class="col-span-2 text-center text-xs text-gray-400 py-4">Belum ada galeri.</div>
            </div>
          </div>

        </div>
      </div>
    </main>

    <!-- PRODUK UNGGULAN PADUKUHAN -->
    <section class="bg-white border-t border-b border-gray-150 py-16 md:py-24">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Produk Unggulan Padukuhan</h2>
            <p class="text-sm text-gray-500 mt-2 max-w-2xl leading-relaxed">
              Mendukung ekonomi lokal melalui pemasaran produk-produk kerajinan dan hasil tani berkualitas tinggi langsung dari warga kami.
            </p>
          </div>
          <button 
            @click="$emit('navigate', 'produk')"
            class="self-start md:self-auto px-6 py-3 border-2 border-gray-200 hover:border-[#0D6847] hover:text-[#0D6847] font-bold text-xs rounded-xl transition-all duration-300 active:scale-95 cursor-pointer"
          >
            Jelajahi Katalog UMKM
          </button>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-stretch">
          
          <!-- Left: Product Card (Takes 5 cols on lg) -->
          <div v-if="store.products.length > 0" class="lg:col-span-5 bg-white rounded-2xl border border-gray-150 shadow-sm hover:shadow-lg transition-all duration-300 flex flex-col overflow-hidden group">
            <div class="relative overflow-hidden aspect-[4/3] bg-gray-50 border-b border-gray-100">
              <img 
                :src="store.products[0].image" 
                :alt="store.products[0].name" 
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError($event, 'anyaman-bambu')"
              />
            </div>
            <div class="p-6.5 flex-1 flex flex-col justify-between">
              <div>
                <span class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">{{ store.products[0].category }}</span>
                <h3 class="text-lg font-bold text-gray-950 mt-1 leading-snug">{{ store.products[0].name }}</h3>
                <p class="text-xs text-gray-500 leading-relaxed mt-2.5 line-clamp-3">
                  {{ store.products[0].description || 'Produk unggulan dari UMKM Padukuhan Ngemplak Kalangan. Kualitas terjamin langsung dari warga kami.' }}
                </p>
              </div>
              <div class="flex items-center justify-between mt-6.5 pt-4 border-t border-gray-100">
                <div>
                  <span class="text-[10px] text-gray-400 font-bold uppercase tracking-wider block">Harga</span>
                  <span class="text-base font-extrabold text-[#0D6847]">Rp {{ store.products[0].price.toLocaleString('id-ID') }} <span class="text-xs font-normal text-gray-400">/ unit</span></span>
                </div>
                <button 
                  @click="$emit('navigate', 'produk')"
                  class="p-3 bg-[#0D6847] hover:bg-[#0A5238] text-white rounded-xl shadow-md transition-all duration-300 hover:scale-105 active:scale-95 cursor-pointer" 
                  aria-label="Beli"
                >
                  <ShoppingCartIcon class="w-5 h-5" />
                </button>
              </div>
            </div>
          </div>
          <div v-else class="lg:col-span-5 bg-white rounded-2xl border border-gray-150 shadow-sm flex items-center justify-center p-8 text-center text-gray-400 text-sm">
            Belum ada produk yang ditambahkan.
          </div>

          <!-- Right: Banner Promo UMKM (Takes 7 cols on lg) -->
          <div class="lg:col-span-7 bg-gradient-to-br from-[#0D6847] to-[#08442E] rounded-2xl p-8 md:p-12 text-white flex flex-col justify-between relative overflow-hidden shadow-md group">
            <!-- Background pattern decorative SVG -->
            <div class="absolute right-0 bottom-0 opacity-10 translate-x-12 translate-y-12 select-none pointer-events-none group-hover:scale-105 transition-transform duration-500">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-96 h-96" fill="currentColor" viewBox="0 0 24 24">
                <path d="M16 6V4c0-1.11-.89-2-2-2h-4c-1.11 0-2 .89-2 2v2H5c-1.1 0-2 .9-2 2v11c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2h-3zm-6-2h4v2h-4V4zm9 15H5v-9h14v9z" />
              </svg>
            </div>

            <div class="relative z-10 max-w-lg">
              <h3 class="text-2xl md:text-3xl font-extrabold leading-tight mb-4">
                Bantu Ekonomi Desa dengan Membeli Produk Lokal
              </h3>
              <p class="text-sm text-emerald-100/90 leading-relaxed mb-8">
                Setiap pembelian Anda berkontribusi langsung pada peningkatan pendapatan warga dan pelestarian seni budaya tradisional di desa kami.
              </p>
            </div>

            <div class="relative z-10 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-6 pt-6 border-t border-white/10">
              <button 
                @click="$emit('navigate', 'produk')"
                class="px-6 py-3.5 bg-white hover:bg-emerald-50 text-[#0D6847] font-bold text-xs rounded-xl shadow-md transition-all duration-300 active:scale-95 cursor-pointer"
              >
                Lihat Katalog UMKM
              </button>
              <div class="flex items-center gap-3">
                <div class="text-3xl font-extrabold text-white">{{ store.products.length }}+</div>
                <div class="text-[10px] font-bold text-emerald-200 uppercase tracking-widest leading-tight">
                  Produk <br/> Tersedia
                </div>
              </div>
            </div>
          </div>

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
  ShoppingCart as ShoppingCartIcon
} from 'lucide-vue-next';

import { store } from '../store';

defineEmits(['navigate']);

// Fallback logic for images if they haven't been copied yet
const handleImageError = (event, type) => {
  const fallbacks = {
    'hero-bg': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',
    'lomba-polowidi': 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=600&q=80',
    'lomba-kalangan': 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?auto=format&fit=crop&w=600&q=80',
    'tirakatan': 'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=800&q=80',
    'kepala-desa': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=400&q=80',
    'anyaman-bambu': 'https://images.unsplash.com/photo-1595475244128-90a36b67241a?auto=format&fit=crop&w=600&q=80',
    'galeri-1': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=400&q=80',
    'galeri-2': 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=400&q=80'
  };
  event.target.src = fallbacks[type] || 'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=600';
};
</script>
