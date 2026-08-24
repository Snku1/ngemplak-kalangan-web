<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative min-h-[360px] md:min-h-[400px] flex items-center justify-center overflow-hidden bg-gray-900 text-white">
      <!-- Background Image with Overlay -->
      <div class="absolute inset-0 z-0">
        <img 
          src="/images/hero-bg.png" 
          alt="Latar Belakang Informasi" 
          class="w-full h-full object-cover object-center opacity-60 scale-105"
          @error="handleImageError($event, 'hero-bg')"
        />
        <!-- Greenish Gradient Overlay matching Visly mockup -->
        <div class="absolute inset-0 bg-gradient-to-b from-[#0D6847]/85 via-[#0D6847]/75 to-gray-950/80"></div>
      </div>

      <!-- Hero Content -->
      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center py-16">
        <h2 class="text-3xl md:text-5xl font-extrabold tracking-tight leading-tight mb-4 text-white">
          Informasi Padukuhan Ngemplak Kalangan
        </h2>
        <p class="text-sm md:text-base text-emerald-100 max-w-2xl mx-auto leading-relaxed font-medium">
          Pusat informasi terpadu padukuhan Digital Indonesia. Dapatkan update terbaru mengenai berita, agenda kegiatan, dan pengumuman resmi pemerintah padukuhan.
        </p>
      </div>
    </section>

    <!-- SEARCH & FILTER BAR SECTION -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-8 relative z-20">
      <div class="bg-white rounded-2xl p-6 shadow-xl shadow-gray-200/50 border border-gray-100">
        
        <!-- Search Input and Buttons -->
        <div class="flex flex-col md:flex-row items-stretch gap-4 mb-4">
          <div class="flex-1 relative">
            <SearchIcon class="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input 
              v-model="searchQuery"
              type="text" 
              placeholder="Cari berita atau kegiatan..." 
              class="w-full pl-12 pr-10 py-3.5 bg-gray-50 border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-[#0D6847] focus:ring-1 focus:ring-[#0D6847] transition-all font-semibold"
              @keyup.enter="handleSearch"
            />
            <!-- Clear Search Button -->
            <button 
              v-if="searchQuery"
              @click="clearSearch"
              class="absolute right-4 top-1/2 -translate-y-1/2 p-1 text-gray-400 hover:text-gray-600 rounded-full hover:bg-gray-200/60 transition-all cursor-pointer"
              title="Bersihkan Pencarian"
            >
              <XIcon class="w-4.5 h-4.5" />
            </button>
          </div>
          <div class="flex gap-3">
            <button 
              @click="toggleCategoryDropdown"
              :class="[
                showCategoryDropdown 
                  ? 'border-[#0D6847] text-[#0D6847] bg-emerald-50/40 shadow-inner' 
                  : 'border-gray-200 text-gray-600 hover:text-gray-900 bg-white'
              ]"
              class="flex items-center justify-center gap-2 px-5 py-3.5 border rounded-xl text-sm font-bold transition-all cursor-pointer"
            >
              <SlidersIcon class="w-4.5 h-4.5" />
              <span>Filter Kategori</span>
            </button>
            <button 
              @click="handleSearch"
              class="px-7 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-sm font-bold rounded-xl transition-all hover:shadow-md cursor-pointer active:scale-95"
            >
              Cari
            </button>
          </div>
        </div>

        <!-- Inline Category Dropdown -->
        <transition name="slide-down">
          <div v-if="showCategoryDropdown" class="mb-4 p-4.5 bg-gray-50 border border-gray-150 rounded-xl space-y-3">
            <div class="flex items-center justify-between">
              <span class="text-xs font-bold text-gray-400 uppercase tracking-widest">Saring Kategori Berita:</span>
              <button 
                v-if="selectedCategory" 
                @click="clearCategoryFilter"
                class="text-[10px] font-bold text-red-500 hover:text-red-700 underline cursor-pointer"
              >
                Hapus Filter Kategori
              </button>
            </div>
            <div class="flex flex-wrap gap-2">
              <button 
                v-for="cat in popularCategories" 
                :key="cat"
                @click="filterByCategory(cat)"
                :class="[
                  selectedCategory === cat 
                    ? 'bg-[#0D6847] border-[#0D6847] text-white shadow-xs font-bold' 
                    : 'bg-white border-gray-250 text-gray-500 hover:bg-gray-100 hover:text-gray-700 font-semibold'
                ]"
                class="px-3.5 py-2 text-[11px] border rounded-lg transition-all cursor-pointer"
              >
                {{ cat }}
              </button>
            </div>
          </div>
        </transition>

        <!-- Filter Tabs Pills (Semua, Berita, Agenda, Pengumuman) -->
        <div class="flex flex-wrap items-center justify-center gap-2 pt-4 border-t border-gray-100">
          <button 
            v-for="tab in filterTabs" 
            :key="tab.value"
            @click="setTab(tab.value)"
            :class="[
              activeTab === tab.value 
                ? 'bg-emerald-50 text-[#0D6847] font-extrabold border-[#0D6847]/40 shadow-xs scale-[1.02]' 
                : 'bg-white hover:bg-gray-50 text-gray-500 font-bold border-gray-200/80'
            ]"
            class="px-6 py-2.5 text-xs border rounded-xl transition-all cursor-pointer active:scale-95"
          >
            {{ tab.label }}
          </button>
        </div>

      </div>
    </section>

    <!-- MAIN GRID SECTION -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        <!-- LEFT COLUMN: CONTENT (Takes 2 cols on lg) -->
        <div class="lg:col-span-2 space-y-12">
          
          <!-- BERITA TERBARU SECTION -->
          <div v-if="activeTab === 'semua' || activeTab === 'berita'" class="space-y-6">
            <div class="flex items-center justify-between border-b border-gray-100 pb-4">
              <div class="flex items-center gap-2">
                <FileTextIcon class="w-5.5 h-5.5 text-[#0D6847]" />
                <h3 class="text-xl font-extrabold text-gray-950">Berita Terbaru</h3>
              </div>
              <button 
                @click="resetFilters" 
                class="text-xs font-bold text-[#0D6847] hover:underline"
              >
                Lihat Semua
              </button>
            </div>

            <!-- News Grid with smooth card-transitions -->
            <div v-if="paginatedNews.length > 0" class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <transition-group name="list">
                <article 
                  v-for="news in paginatedNews" 
                  :key="news.id" 
                  class="bg-white rounded-2xl overflow-hidden border border-gray-150 shadow-sm hover:shadow-lg transition-all duration-300 group flex flex-col h-full hover:-translate-y-1"
                >
                  <!-- Thumbnail -->
                  <div class="relative overflow-hidden aspect-video bg-gray-100">
                    <img 
                      :src="news.image" 
                      :alt="news.title" 
                      class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                      @error="handleImageError($event, 'placeholder')"
                    />
                    <span class="absolute top-4 left-4 bg-[#0D6847] text-white text-[10px] font-bold uppercase tracking-wider px-3 py-1 rounded-full shadow-md">
                      {{ news.category }}
                    </span>
                  </div>
                  <!-- Content -->
                  <div class="p-6 flex-1 flex flex-col justify-between">
                    <div class="space-y-3">
                      <div class="flex items-center gap-4 text-[10px] text-gray-400 font-extrabold uppercase tracking-wider">
                        <span class="flex items-center gap-1">
                          <CalendarIcon class="w-3.5 h-3.5" />
                          {{ news.date }}
                        </span>
                        <span>•</span>
                        <span>{{ news.author }}</span>
                      </div>
                      <h4 class="text-base font-extrabold text-gray-900 group-hover:text-[#0D6847] transition-colors line-clamp-2 leading-snug">
                        {{ news.title }}
                      </h4>
                      <p class="text-xs text-gray-500 leading-relaxed line-clamp-3 font-semibold">
                        {{ news.excerpt }}
                      </p>
                    </div>
                    <!-- Link -->
                    <button 
                      @click="openNewsDetail(news)"
                      class="inline-flex items-center gap-1.5 text-xs font-bold text-[#0D6847] hover:underline mt-6 cursor-pointer"
                    >
                      <span>Baca Selengkapnya</span>
                      <ArrowRightIcon class="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
                    </button>
                  </div>
                </article>
              </transition-group>
            </div>
            
            <!-- News Empty State -->
            <div v-else class="text-center py-12 bg-white rounded-2xl border border-gray-100">
              <p class="text-sm text-gray-400 font-bold">Tidak ada berita yang cocok dengan kriteria pencarian.</p>
            </div>
          </div>

          <!-- PENGUMUMAN PENTING SECTION -->
          <div v-if="activeTab === 'semua' || activeTab === 'pengumuman'" class="space-y-6">
            <div class="flex items-center gap-2 border-b border-gray-100 pb-4">
              <BellIcon class="w-5.5 h-5.5 text-[#0D6847]" />
              <h3 class="text-xl font-extrabold text-gray-950">Pengumuman Penting</h3>
            </div>

            <!-- Announcement List -->
            <div v-if="filteredAnnouncements.length > 0" class="space-y-4">
              <div 
                v-for="ann in filteredAnnouncements" 
                :key="ann.id"
                :class="[
                  ann.isImportant 
                    ? 'border-red-200 bg-red-50/20 hover:border-red-300 shadow-xs shadow-red-50' 
                    : 'border-blue-150 bg-blue-50/10 hover:border-blue-200 shadow-xs shadow-blue-50'
                ]"
                class="p-5.5 rounded-2xl border transition-all duration-300 flex gap-4 hover:-translate-y-0.5"
              >
                <!-- Icon container -->
                <div 
                  :class="[
                    ann.isImportant 
                      ? 'bg-red-50 text-red-500 border-red-100' 
                      : 'bg-blue-50 text-blue-500 border-blue-100'
                  ]"
                  class="w-11 h-11 rounded-full border flex items-center justify-center shrink-0 shadow-xs"
                >
                  <AlertCircleIcon class="w-5 h-5" />
                </div>
                <!-- Content -->
                <div class="flex-1 space-y-2">
                  <div class="flex flex-wrap items-center justify-between gap-2">
                    <h4 class="text-sm font-extrabold text-gray-900">{{ ann.title }}</h4>
                    <span class="text-[10px] font-bold text-gray-400">{{ ann.date }}</span>
                  </div>
                  <p class="text-xs text-gray-500 leading-relaxed font-semibold">{{ ann.description }}</p>
                  
                  <div class="flex items-center justify-between pt-2">
                    <span 
                      v-if="ann.isImportant"
                      class="inline-block px-2.5 py-0.5 rounded text-[8px] font-bold tracking-widest bg-red-500 text-white uppercase"
                    >
                      Penting
                    </span>
                    <span v-else class="inline-block px-2.5 py-0.5 rounded text-[8px] font-bold tracking-widest bg-blue-500 text-white uppercase">
                      Info
                    </span>
                    
                    <button 
                      @click="openAnnDetail(ann)"
                      class="text-[10px] font-extrabold text-[#0D6847] hover:underline cursor-pointer"
                    >
                      Lihat Rincian
                    </button>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Announcement Empty State -->
            <div v-else class="text-center py-12 bg-white rounded-2xl border border-gray-100">
              <p class="text-sm text-gray-400 font-bold">Tidak ada pengumuman yang ditemukan.</p>
            </div>
          </div>

          <!-- AGENDA DESA (WHEN TAB FILTER IS AGENDA) -->
          <div v-if="activeTab === 'agenda'" class="space-y-6">
            <div class="flex items-center gap-2 border-b border-gray-100 pb-4">
              <CalendarIcon class="w-5.5 h-5.5 text-[#0D6847]" />
              <h3 class="text-xl font-extrabold text-gray-950">Agenda Kegiatan Desa</h3>
            </div>

            <!-- List of events -->
            <div class="space-y-4">
              <div 
                v-for="event in events" 
                :key="event.id"
                class="bg-white rounded-2xl p-6 border border-gray-150 hover:shadow-md transition-all flex flex-col md:flex-row items-start md:items-center gap-6 hover:-translate-y-0.5"
              >
                <!-- Date Box -->
                <div class="flex md:flex-col items-center justify-center shrink-0 w-16 h-16 bg-[#F0FAF5] text-[#0D6847] rounded-2xl border border-[#E0F2E9] text-center shadow-xs">
                  <span class="text-xs font-bold uppercase">{{ event.month }}</span>
                  <span class="text-2xl font-extrabold leading-none">{{ event.day }}</span>
                </div>
                <!-- Details -->
                <div class="flex-1 space-y-2">
                  <div class="flex items-center gap-2">
                    <span class="px-2 py-0.5 rounded bg-emerald-50 text-emerald-700 text-[9px] font-bold border border-emerald-100 uppercase">
                      {{ event.status }}
                    </span>
                  </div>
                  <h4 class="text-base font-extrabold text-gray-950 leading-snug">{{ event.title }}</h4>
                  <div class="flex flex-wrap items-center gap-x-6 gap-y-1.5 text-xs text-gray-500 font-semibold">
                    <span class="flex items-center gap-1.5">
                      <ClockIcon class="w-4 h-4 text-gray-400" />
                      {{ event.time }}
                    </span>
                    <span class="flex items-center gap-1.5">
                      <MapPinIcon class="w-4 h-4 text-gray-400" />
                      {{ event.location }}
                    </span>
                  </div>
                </div>
                <!-- Action -->
                <button 
                  @click="openEventDetail(event)"
                  class="mt-2 md:mt-0 px-4 py-2 border border-gray-200 hover:border-[#0D6847] text-xs font-bold text-gray-600 hover:text-[#0D6847] rounded-xl transition-all active:scale-95 cursor-pointer bg-white"
                >
                  Detail Agenda
                </button>
              </div>
            </div>
          </div>

          <!-- PAGINATION -->
          <div v-if="totalPages > 1 || activeTab === 'agenda' || activeTab === 'pengumuman'" class="pt-6 border-t border-gray-150 flex flex-col sm:flex-row items-center justify-between gap-4">
            <p class="text-xs text-gray-400 font-bold">
              Menampilkan {{ pageStartItem }} - {{ pageEndItem }} dari {{ totalFilteredCount }} informasi desa
            </p>
            <div class="flex items-center gap-1.5">
              <!-- Previous Button -->
              <button 
                @click="prevPage"
                :disabled="currentPageNum === 1"
                class="p-2.5 rounded-lg border border-gray-200 hover:border-[#0D6847] hover:text-[#0D6847] transition-all disabled:opacity-40 disabled:cursor-not-allowed cursor-pointer bg-white"
                aria-label="Halaman Sebelumnya"
              >
                <ArrowLeftIcon class="w-4 h-4" />
              </button>
              
              <!-- Numbered Buttons -->
              <button 
                v-for="page in totalPages" 
                :key="page"
                @click="setPage(page)"
                :class="[
                  currentPageNum === page 
                    ? 'bg-[#0D6847] border-[#0D6847] text-white font-extrabold shadow-sm scale-102' 
                    : 'bg-white border-gray-200 text-gray-600 hover:border-gray-300 font-semibold'
                ]"
                class="w-9 h-9 text-xs border rounded-lg transition-all cursor-pointer active:scale-95"
              >
                {{ page }}
              </button>

              <!-- Next Button -->
              <button 
                @click="nextPage"
                :disabled="currentPageNum === totalPages || totalPages === 0"
                class="p-2.5 rounded-lg border border-gray-200 hover:border-[#0D6847] hover:text-[#0D6847] transition-all disabled:opacity-40 disabled:cursor-not-allowed cursor-pointer bg-white"
                aria-label="Halaman Selanjutnya"
              >
                <ArrowRightIcon class="w-4 h-4" />
              </button>
            </div>
          </div>

        </div>

        <!-- RIGHT COLUMN: SIDEBAR -->
        <div class="space-y-8">
          
          <!-- AGENDA DESA WIDGET (ONLY ON NON-AGENDA TAB) -->
          <div v-if="activeTab !== 'agenda'" class="bg-white rounded-2xl p-6 border border-gray-150 shadow-sm space-y-6">
            <div class="flex items-center gap-2 pb-4 border-b border-gray-100">
              <div class="w-8 h-8 rounded-lg bg-[#0D6847]/10 flex items-center justify-center text-[#0D6847]">
                <CalendarIcon class="w-4.5 h-4.5" />
              </div>
              <h3 class="font-extrabold text-gray-900 text-base">Agenda Desa</h3>
            </div>
            
            <div class="space-y-4">
              <!-- Event Items -->
              <div 
                v-for="event in events.slice(0, 3)" 
                :key="event.id"
                @click="openEventDetail(event)"
                class="flex items-center gap-4 bg-gray-50/50 hover:bg-gray-50 p-3 rounded-xl border border-gray-100 hover:shadow-xs transition-all cursor-pointer group"
              >
                <!-- Date Box -->
                <div class="flex flex-col items-center justify-center shrink-0 w-11 h-11 bg-white text-[#0D6847] rounded-lg border border-gray-150 text-center shadow-xs">
                  <span class="text-[8px] font-extrabold uppercase tracking-wider leading-none mb-0.5">{{ event.month }}</span>
                  <span class="text-base font-extrabold leading-none">{{ event.day }}</span>
                </div>
                <!-- Details -->
                <div class="flex-1 min-w-0">
                  <h4 class="text-xs font-bold text-gray-900 group-hover:text-[#0D6847] transition-colors truncate">
                    {{ event.title }}
                  </h4>
                  <div class="flex items-center gap-3 text-[10px] text-gray-400 mt-1 font-semibold">
                    <span class="flex items-center gap-1 shrink-0">
                      <ClockIcon class="w-3 h-3" />
                      {{ event.time.split(' ')[0] }}
                    </span>
                    <span class="flex items-center gap-1 truncate">
                      <MapPinIcon class="w-3 h-3 shrink-0" />
                      {{ event.location.split(',')[0] }}
                    </span>
                  </div>
                </div>
                <!-- Badge -->
                <span class="text-[8px] font-bold text-emerald-600 bg-emerald-50 px-1.5 py-0.5 rounded border border-emerald-100 uppercase shrink-0">
                  {{ event.status }}
                </span>
              </div>
            </div>

            <!-- Action -->
            <button 
              @click="setTab('agenda')"
              class="w-full flex items-center justify-center gap-2 py-3 border border-gray-200 hover:border-[#0D6847] text-xs font-bold text-gray-600 hover:text-[#0D6847] rounded-xl transition-all cursor-pointer bg-white"
            >
              <CalendarIcon class="w-4 h-4" />
              <span>Semua Jadwal</span>
            </button>
          </div>

          <!-- BERLANGGANAN INFO WIDGET -->
          <div class="bg-[#0D6847] rounded-2xl p-6.5 text-white shadow-lg relative overflow-hidden group">
            <!-- Background glow -->
            <div class="absolute -right-10 -bottom-10 w-40 h-40 bg-emerald-500/20 rounded-full blur-2xl group-hover:scale-110 transition-transform duration-700"></div>
            
            <div class="relative z-10 space-y-4">
              <div class="w-9 h-9 rounded-xl bg-white/10 flex items-center justify-center border border-white/20">
                <BellIcon class="w-5 h-5 text-emerald-300" />
              </div>
              <div class="space-y-1">
                <h3 class="font-extrabold text-lg">Berlangganan Info</h3>
                <p class="text-xs text-emerald-100 leading-relaxed font-semibold">
                  Dapatkan berita terbaru langsung ke WhatsApp atau Email Anda.
                </p>
              </div>

              <!-- Input & Action -->
              <div v-if="!isSubscribed" class="space-y-3 pt-2">
                <div>
                  <input 
                    v-model="subscribeInput"
                    type="text" 
                    placeholder="Nomor WA (contoh: 0812345678) / Email" 
                    :class="[subscribeError ? 'border-red-400 bg-red-500/10 placeholder:text-red-200' : 'border-white/20 bg-white/10 placeholder:text-emerald-250 focus:border-white focus:bg-white/15']"
                    class="w-full px-4 py-3 border rounded-xl text-xs text-white focus:outline-none transition-all font-semibold"
                    @keyup.enter="handleSubscribe"
                    @input="subscribeError = false"
                  />
                  <p v-if="subscribeError" class="text-[9px] font-extrabold text-red-200 mt-1.5 flex items-center gap-1">
                    <AlertCircleIcon class="w-3.5 h-3.5" />
                    <span>Format Email/WA tidak valid!</span>
                  </p>
                </div>
                <button 
                  @click="handleSubscribe"
                  class="w-full py-3 bg-white text-[#0D6847] hover:bg-emerald-50 text-xs font-bold rounded-xl transition-all active:scale-97 cursor-pointer"
                >
                  Daftar Sekarang
                </button>
              </div>

              <!-- Subscribed Success State -->
              <div v-else class="pt-4 flex flex-col items-center text-center space-y-3 bg-white/5 border border-white/10 p-4 rounded-xl">
                <CheckCircleIcon class="w-8 h-8 text-emerald-300 animate-bounce" />
                <div>
                  <p class="text-xs font-bold text-white">Pendaftaran Berhasil</p>
                  <p class="text-[10px] text-emerald-200 mt-1">Kami akan mengirimkan pembaruan ke {{ subscribeInput }}.</p>
                </div>
                <button 
                  @click="resetSubscribe" 
                  class="text-[10px] font-bold text-emerald-300 hover:text-white underline mt-2 cursor-pointer"
                >
                  Ubah Email/WA
                </button>
              </div>
            </div>
          </div>

          <!-- KATEGORI TERPOPULER WIDGET -->
          <div class="bg-white rounded-2xl p-6 border border-gray-150 shadow-sm space-y-5">
            <div class="flex items-center gap-2 pb-4 border-b border-gray-100">
              <div class="w-8 h-8 rounded-lg bg-[#0D6847]/10 flex items-center justify-center text-[#0D6847]">
                <HeartIcon class="w-4.5 h-4.5" />
              </div>
              <h3 class="font-extrabold text-gray-900 text-base">Kategori Terpopuler</h3>
            </div>
            
            <div class="flex flex-wrap gap-2">
              <button 
                v-for="cat in popularCategories" 
                :key="cat"
                @click="filterByCategory(cat)"
                :class="[
                  selectedCategory === cat 
                    ? 'bg-[#0D6847] border-[#0D6847] text-white shadow-xs font-bold' 
                    : 'bg-gray-50 border-gray-150 text-gray-500 hover:bg-gray-100 hover:text-gray-700 font-semibold'
                ]"
                class="px-3.5 py-2 text-[10px] border rounded-lg transition-all cursor-pointer uppercase tracking-wider"
              >
                {{ cat }}
              </button>
            </div>
          </div>

          <!-- BUTUH SURAT KETERANGAN? WIDGET -->
          <div class="bg-gradient-to-br from-[#F0FAF5] to-white rounded-2xl p-6.5 border border-[#E0F2E9] shadow-sm relative overflow-hidden group">
            <div class="absolute right-0 bottom-0 w-24 h-24 bg-[#0D6847]/5 rounded-tl-full shrink-0"></div>
            <div class="space-y-4 relative z-10">
              <div class="w-10 h-10 rounded-xl bg-white border border-[#E0F2E9] text-[#0D6847] flex items-center justify-center shadow-xs">
                <FileTextIcon class="w-5.5 h-5.5" />
              </div>
              <div class="space-y-1.5">
                <h3 class="font-extrabold text-gray-900 text-base">Butuh Surat Keterangan?</h3>
                <p class="text-xs text-gray-500 leading-relaxed font-semibold">
                  Ajukan berbagai jenis surat administrasi secara online tanpa harus antre di kantor desa.
                </p>
              </div>
              
              <button 
                @click="showLetterServiceInfo"
                class="w-full flex items-center justify-center gap-2 py-3 bg-white hover:bg-gray-50 text-xs font-bold text-[#0D6847] border border-[#E0F2E9] rounded-xl transition-all shadow-xs active:scale-97 cursor-pointer"
              >
                <span>Ajukan Sekarang</span>
                <ArrowRightIcon class="w-4 h-4" />
              </button>
            </div>
          </div>

        </div>

      </div>
    </main>

    <!-- ARTICLE DETAIL MODAL -->
    <transition name="fade">
      <div 
        v-if="selectedNews" 
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs"
        @click.self="closeNewsDetail"
      >
        <div class="bg-white rounded-3xl max-w-2xl w-full max-h-[85vh] overflow-y-auto shadow-2xl border border-gray-100 flex flex-col">
          
          <!-- Image -->
          <div class="relative h-64 md:h-80 bg-gray-100 shrink-0">
            <img 
              :src="selectedNews.image" 
              :alt="selectedNews.title" 
              class="w-full h-full object-cover"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-75"></div>
            <button 
              @click="closeNewsDetail"
              class="absolute top-4 right-4 p-2 bg-black/55 hover:bg-black/75 text-white rounded-full transition-colors cursor-pointer"
              aria-label="Tutup"
            >
              <XIcon class="w-5 h-5" />
            </button>
            <span class="absolute bottom-6 left-6 bg-[#0D6847] text-white text-[10px] font-bold uppercase tracking-wider px-3.5 py-1.5 rounded-full">
              {{ selectedNews.category }}
            </span>
          </div>

          <!-- Content -->
          <div class="p-6 md:p-8 space-y-6">
            <div class="flex items-center gap-4 text-xs text-gray-400 font-bold uppercase tracking-wider">
              <span class="flex items-center gap-1">
                <CalendarIcon class="w-4 h-4" />
                {{ selectedNews.date }}
              </span>
              <span>•</span>
              <span class="flex items-center gap-1">
                <UserIcon class="w-4 h-4" />
                {{ selectedNews.author }}
              </span>
            </div>
            
            <h3 class="text-xl md:text-2xl font-extrabold text-gray-900 leading-snug">
              {{ selectedNews.title }}
            </h3>
            
            <div class="text-sm text-gray-600 leading-relaxed space-y-4 font-semibold">
              <p>{{ selectedNews.content }}</p>
              <p v-if="selectedNews.id === 1">
                Musyawarah ini dihadiri oleh jajaran perangkat desa, BPD, tokoh adat, serta perwakilan karang taruna dan ibu-ibu PKK. Fokus pembahasan meliputi pembenahan infrastruktur jalan irigasi, peningkatan fasilitas posyandu, serta pemberian dana stimulan bagi pelaku UMKM lokal guna mempercepat kemandirian ekonomi pascapandemi. Keputusan ini akan diajukan ke APBDes tahun anggaran mendatang.
              </p>
              <p v-if="selectedNews.id === 2">
                Pengerjaan aspal jalan sepanjang 1.2 kilometer ini didanai melalui program dana desa tahun 2026. Pemerintah desa mengapresiasi gotong royong warga dalam membantu kelancaran proyek ini. Kini, kendaraan roda empat pembawa hasil bumi dapat melintas dengan lancar, menghemat biaya transportasi tani hingga 30%.
              </p>
              <p v-if="selectedNews.id === 3">
                Para pengrajin anyaman bambu dibekali pelatihan teknik anyaman kontemporer agar menghasilkan produk bernilai seni tinggi seperti tas jinjing, hiasan dinding, dan wadah saji modern. Selain itu, pendampingan pemasaran digital di marketplace nasional juga diberikan untuk mendongkrak omzet penjualan produk khas Ngemplak Kalangan.
              </p>
              <p v-if="selectedNews.id === 4">
                Program ini dilaksanakan untuk menjangkau keluarga muda dan lansia agar mendapatkan nutrisi berimbang dan deteksi penyakit degeneratif lebih cepat. Pembagian Paket PMT diprioritaskan untuk pemenuhan gizi telur, susu, dan kacang-kacangan.
              </p>
              <p v-if="selectedNews.id === 5">
                Penerapan pupuk kandang hasil fermentasi mandiri peternak padukuhan berhasil meningkatkan kesuburan tanah sawah tanpa merusak ekosistem air tanah. Pada musim berikutnya, kelompok tani merencanakan perluasan area tanam padi organik sebesar 5 hektar lagi.
              </p>
              <p v-if="selectedNews.id === 6">
                Macapatan diselenggarakan secara berskala untuk memancing kepedulian remaja terhadap pelestarian tradisi leluhur. Selain Macapat, disajikan pula pelatihan gamelan karawitan dasar bagi anak-anak usia SD.
              </p>
            </div>
            
            <div class="pt-6 border-t border-gray-150 flex justify-end">
              <button 
                @click="closeNewsDetail"
                class="px-6 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-800 text-xs font-bold rounded-xl transition-all cursor-pointer"
              >
                Tutup Halaman
              </button>
            </div>
          </div>

        </div>
      </div>
    </transition>

    <!-- GENERAL MODAL DETAIL (AGENDA / ANNOUNCEMENT / SYSTEM INFO) -->
    <transition name="fade">
      <div 
        v-if="activeModalDetail" 
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs"
        @click.self="closeActiveModal"
      >
        <div class="bg-white rounded-3xl max-w-md w-full p-6.5 shadow-2xl border border-gray-100 space-y-5">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
              <div 
                :class="[
                  activeModalDetail.type === 'agenda' 
                    ? 'bg-[#F0FAF5] text-[#0D6847]' 
                    : activeModalDetail.isImportant 
                      ? 'bg-red-50 text-red-500' 
                      : 'bg-blue-50 text-blue-500'
                ]"
                class="w-9 h-9 rounded-lg flex items-center justify-center shrink-0 border border-current/10"
              >
                <CalendarIcon v-if="activeModalDetail.type === 'agenda'" class="w-5 h-5" />
                <AlertCircleIcon v-else class="w-5 h-5" />
              </div>
              <span class="text-xs font-bold uppercase tracking-widest text-gray-400">
                {{ activeModalDetail.type === 'agenda' ? 'Agenda Padukuhan' : 'Pengumuman Resmi' }}
              </span>
            </div>
            <button 
              @click="closeActiveModal"
              class="p-1.5 hover:bg-gray-100 rounded-full transition-colors cursor-pointer text-gray-400 hover:text-gray-600"
            >
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <div class="space-y-3">
            <h3 class="text-lg font-extrabold text-gray-950 leading-snug">
              {{ activeModalDetail.title }}
            </h3>
            
            <div v-if="activeModalDetail.type === 'agenda'" class="bg-gray-50 rounded-2xl p-4 space-y-2 border border-gray-100">
              <div class="flex items-center gap-2.5 text-xs text-gray-600 font-semibold">
                <CalendarIcon class="w-4 h-4 text-gray-400" />
                <span>Hari/Tanggal: <strong>{{ activeModalDetail.day }} {{ activeModalDetail.month }} 2026</strong></span>
              </div>
              <div class="flex items-center gap-2.5 text-xs text-gray-600 font-semibold">
                <ClockIcon class="w-4 h-4 text-gray-400" />
                <span>Waktu: <strong>{{ activeModalDetail.time }}</strong></span>
              </div>
              <div class="flex items-center gap-2.5 text-xs text-gray-600 font-semibold">
                <MapPinIcon class="w-4 h-4 text-gray-400" />
                <span>Tempat: <strong>{{ activeModalDetail.location }}</strong></span>
              </div>
            </div>

            <p class="text-xs text-gray-600 leading-relaxed font-semibold">
              {{ activeModalDetail.description || activeModalDetail.details }}
            </p>
            
            <p v-if="activeModalDetail.type === 'agenda'" class="text-xs text-gray-500 leading-relaxed pt-2 font-medium">
              Diharapkan kehadirannya tepat waktu bagi seluruh perwakilan atau warga yang bersangkutan. Kegiatan ini merupakan bagian penting dalam mempererat kebersamaan dan memajukan padukuhan kita.
            </p>
            <p v-else-if="activeModalDetail.isImportant" class="text-[10px] text-red-500 font-bold leading-relaxed pt-2 flex items-center gap-1 bg-red-50/50 p-2 rounded-lg border border-red-100/50">
              <AlertCircleIcon class="w-4 h-4 shrink-0" />
              <span>* Harap perhatikan batas pengumpulan berkas di RT masing-masing.</span>
            </p>
          </div>

          <div class="flex justify-end pt-2">
            <button 
              @click="closeActiveModal"
              class="px-5 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl transition-all cursor-pointer active:scale-95"
            >
              Mengerti
            </button>
          </div>
        </div>
      </div>
    </transition>

    <!-- TOAST NOTIFICATION -->
    <transition name="fade">
      <div 
        v-if="toastMessage" 
        class="fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-3.5 bg-gray-900 text-white rounded-2xl shadow-xl border border-gray-800"
      >
        <CheckCircleIcon class="w-5 h-5 text-emerald-400 shrink-0" />
        <span class="text-xs font-bold">{{ toastMessage }}</span>
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import { 
  Search as SearchIcon, 
  Sliders as SlidersIcon,
  FileText as FileTextIcon,
  Calendar as CalendarIcon,
  Bell as BellIcon,
  Clock as ClockIcon,
  MapPin as MapPinIcon,
  Heart as HeartIcon,
  ArrowRight as ArrowRightIcon,
  ArrowLeft as ArrowLeftIcon,
  X as XIcon,
  User as UserIcon,
  CheckCircle as CheckCircleIcon,
  AlertCircle as AlertCircleIcon
} from 'lucide-vue-next';

// ----------------------------------------------------
// STATE DEFINITIONS
// ----------------------------------------------------
const searchQuery = ref('');
const activeTab = ref('semua');
const selectedCategory = ref('');
const subscribeInput = ref('');
const isSubscribed = ref(false);
const subscribeError = ref(false);
const toastMessage = ref('');
const showCategoryDropdown = ref(false);

// Details Modals State
const selectedNews = ref(null);
const activeModalDetail = ref(null);

// Pagination State
const currentPageNum = ref(1);
const itemsPerPage = 3;

// Static Data lists
const filterTabs = [
  { label: 'Semua', value: 'semua' },
  { label: 'Berita', value: 'berita' },
  { label: 'Agenda', value: 'agenda' },
  { label: 'Pengumuman', value: 'pengumuman' }
];

const popularCategories = [
  'Infrastruktur',
  'Kesehatan',
  'Bantuan Sosial',
  'Event Desa',
  'UMKM',
  'Pendidikan',
  'Pertanian',
  'Wisata'
];

const newsData = [
  {
    id: 1,
    category: 'Pembangunan',
    image: '/images/musyawarah-desa.png',
    date: '24 MEI 2024',
    author: 'ADMIN DESA',
    title: 'Musyawarah Perencanaan Pembangunan Desa',
    excerpt: 'Warga berkumpul untuk merumuskan prioritas pembangunan infrastruktur dan pemberdayaan ekonomi untuk tahun...',
    content: 'Pemerintah Padukuhan Ngemplak Kalangan menyelenggarakan Musyawarah Perencanaan Pembangunan Desa (Musrenbangdes) di balai desa. Musyawarah ini bertujuan untuk menghimpun masukan dan usulan dari warga tingkat RT/RW terkait rencana pembangunan fisik maupun non-fisik untuk periode tahun anggaran 2026/2027.'
  },
  {
    id: 2,
    category: 'Pembangunan',
    image: '/images/jalan-dusun.png',
    date: '20 MEI 2024',
    author: 'SEKRETARIS DESA',
    title: 'Perbaikan Jalan Lingkungan Dusun II Selesai Tepat Waktu',
    excerpt: 'Akses jalan menuju area persawahan kini sudah lebih baik guna mendukung kelancaran distribusi hasil tani warga.',
    content: 'Proyek rehabilitasi dan pengaspalan jalan lingkungan di wilayah Dusun II Padukuhan Ngemplak Kalangan telah rampung 100% tepat waktu. Perbaikan akses transportasi ini diharapkan mempermudah mobilitas harian warga serta memperlancar jalur distribusi hasil pertanian setempat.'
  },
  {
    id: 3,
    category: 'UMKM',
    image: '/images/anyaman-bambu.png',
    date: '15 MEI 2024',
    author: 'KAUR EKONOMI',
    title: 'Program Pemberdayaan UMKM: Pelatihan Anyaman Bambu',
    excerpt: 'Meningkatkan nilai jual produk lokal melalui teknik anyaman modern dan strategi pemasaran digital bagi pengrajin desa.',
    content: 'Kelompok usaha mikro Padukuhan menyelenggarakan pelatihan anyaman bambu inovatif bagi ibu-ibu rumah tangga dan pemuda. Mengundang instruktur ahli dari Yogyakarta, pelatihan ini memfokuskan pada desain kemasan produk anyaman modern yang memiliki nilai jual ekspor serta optimalisasi promosi digital.'
  },
  {
    id: 4,
    category: 'Kesehatan',
    image: '/images/lomba-polowidi.png',
    date: '10 MEI 2024',
    author: 'BIDAN DESA',
    title: 'Posyandu Serentak dan Pembagian PMT Balita',
    excerpt: 'Pemeriksaan kesehatan rutin balita untuk memantau tumbuh kembang anak serta pembagian paket Makanan Pendamping ASI.',
    content: 'Kegiatan rutin Pos Pelayanan Terpadu (Posyandu) dilaksanakan serentak di dua dusun, Ngemplak dan Kalangan. Selain timbang berat badan dan imunisasi rutin, kader posyandu juga membagikan Paket Makanan Tambahan (PMT) kaya protein hewani untuk mencegah stunting sejak dini.'
  },
  {
    id: 5,
    category: 'Pertanian',
    image: '/images/tirakatan.png',
    date: '05 MEI 2024',
    author: 'KETUA KELOMPOK TANI',
    title: 'Sukses Panen Raya Padi Organik Kelompok Tani',
    excerpt: 'Petani Ngemplak Kalangan berhasil meningkatkan hasil panen sebesar 20% dengan beralih ke pupuk organik ramah lingkungan.',
    content: 'Kelompok Tani Makmur Padukuhan Ngemplak Kalangan merayakan panen raya padi varietas unggulan yang dibudidayakan secara organik penuh. Hasil panen kali ini mengalami kenaikan signifikan berkat pendampingan dinas pertanian Sleman dalam pemanfaatan pupuk kompos lokal buatan warga.'
  },
  {
    id: 6,
    category: 'Wisata',
    image: '/images/lomba-kalangan.png',
    date: '01 MEI 2024',
    author: 'PENGELOLA DESA WISATA',
    title: 'Gelar Macapat & Pentas Seni Tradisional Dusun Kalangan',
    excerpt: 'Melestarikan sastra Jawa kuno melalui seni melantunkan tembang macapat yang diikuti pemuda dan sesepuh dusun.',
    content: 'Warga dusun Kalangan menyelenggarakan malam kebudayaan Macapatan bertajuk "Rumeksa Budaya". Acara ini bertujuan mengenalkan sastra dan tembang klasik Jawa kepada generasi muda agar nilai-nilai budi pekerti luhur warisan leluhur tidak punah tergerus arus modernisasi.'
  }
];

const announcements = [
  {
    id: 1,
    title: 'Pembaruan Data Kartu Keluarga (KK)',
    date: '25 MEI 2024',
    description: 'Diharapkan seluruh Ketua RT untuk mengumpulkan fotokopi KK terbaru guna sinkronisasi data bantuan sosial pemerintah.',
    isImportant: true
  },
  {
    id: 2,
    title: 'Himbauan Waspada Perubahan Cuaca Ekstrem',
    date: '22 MEI 2024',
    description: 'Warga diminta waspada terhadap potensi hujan deras disertai angin kencang. Pastikan saluran air di sekitar rumah bersih.',
    isImportant: false
  }
];

const events = [
  {
    id: 1,
    month: 'Jun',
    day: '15',
    title: 'Festival Budaya dan Panen Raya',
    time: '08:00 - 17:00 WIB',
    location: 'Lapangan Utama Desa',
    status: 'Mendatang',
    details: 'Festival kebudayaan tahunan yang menyajikan kirab gunungan hasil bumi, pertunjukan seni tari tradisional, pasar kuliner lokal, serta upacara adat sebagai ungkapan syukur atas panen raya padi di Padukuhan.'
  },
  {
    id: 2,
    month: 'Jun',
    day: '10',
    title: 'Posyandu Balita dan Lansia Serentak',
    time: '08:00 - 12:00 WIB',
    location: 'Aula Kantor Desa',
    status: 'Mendatang',
    details: 'Pemeriksaan kesehatan rutin untuk balita meliputi timbang berat badan, imunisasi, pemberian PMT, serta cek tekanan darah dan konsultasi gizi gratis untuk warga usia lanjut.'
  },
  {
    id: 3,
    month: 'Jun',
    day: '02',
    title: 'Kerja Bakti Massal (Gotong Royong)',
    time: '07:30 - Selesai',
    location: 'Seluruh Lingkungan Dusun',
    status: 'Mendatang',
    details: 'Gerakan kebersihan lingkungan secara serempak guna membersihkan saluran air, memotong dahan pohon yang membahayakan jalan raya, serta merapikan taman-taman di sudut padukuhan.'
  }
];

import { store } from '../store';

// ----------------------------------------------------
// COMPUTED FILTER LOGIC
// ----------------------------------------------------
const filteredNews = computed(() => {
  let result = store.news.map(item => ({
    ...item,
    author: item.author || 'ADMIN DESA'
  }));

  // Search query filter
  if (searchQuery.value.trim() !== '') {
    const q = searchQuery.value.toLowerCase();
    result = result.filter(item => 
      item.title.toLowerCase().includes(q) || 
      (item.excerpt || '').toLowerCase().includes(q) || 
      (item.content || '').toLowerCase().includes(q)
    );
  }

  // Category filter
  if (selectedCategory.value !== '') {
    const activeCat = selectedCategory.value.toLowerCase();
    result = result.filter(item => item.category.toLowerCase().includes(activeCat) || activeCat.includes(item.category.toLowerCase()));
  }

  return result;
});

const filteredAnnouncements = computed(() => {
  let result = [...announcements];

  if (searchQuery.value.trim() !== '') {
    const q = searchQuery.value.toLowerCase();
    result = result.filter(item => 
      item.title.toLowerCase().includes(q) || 
      item.description.toLowerCase().includes(q)
    );
  }

  return result;
});

// Dynamic pagination logic
const totalFilteredCount = computed(() => {
  if (activeTab.value === 'berita') return filteredNews.value.length;
  if (activeTab.value === 'pengumuman') return filteredAnnouncements.value.length;
  if (activeTab.value === 'agenda') return events.length;
  // 'semua' counts news items primarily for main list pagination
  return filteredNews.value.length;
});

const totalPages = computed(() => {
  return Math.ceil(totalFilteredCount.value / itemsPerPage);
});

const paginatedNews = computed(() => {
  const start = (currentPageNum.value - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  return filteredNews.value.slice(start, end);
});

// Item range display logic
const pageStartItem = computed(() => {
  if (totalFilteredCount.value === 0) return 0;
  return (currentPageNum.value - 1) * itemsPerPage + 1;
});

const pageEndItem = computed(() => {
  return Math.min(currentPageNum.value * itemsPerPage, totalFilteredCount.value);
});

// Tab changes resets pagination page
watch([activeTab, selectedCategory, searchQuery], () => {
  currentPageNum.value = 1;
});

// ----------------------------------------------------
// METHODS & HANDLERS
// ----------------------------------------------------
const handleSearch = () => {
  showToast(`Pencarian untuk "${searchQuery.value}" diterapkan.`);
};

const clearSearch = () => {
  searchQuery.value = '';
  showToast('Pencarian dibersihkan.');
};

const toggleCategoryDropdown = () => {
  showCategoryDropdown.value = !showCategoryDropdown.value;
};

const filterByCategory = (category) => {
  if (selectedCategory.value === category) {
    selectedCategory.value = ''; // Toggle off
    showToast(`Filter kategori dibatalkan.`);
  } else {
    selectedCategory.value = category;
    if (activeTab.value !== 'berita' && activeTab.value !== 'semua') {
      activeTab.value = 'berita'; // switch to news tab to see filtered cards
    }
    showToast(`Menampilkan kategori: ${category}`);
  }
};

const clearCategoryFilter = () => {
  selectedCategory.value = '';
  showToast('Filter kategori dihapus.');
};

const setTab = (tabValue) => {
  activeTab.value = tabValue;
  selectedCategory.value = '';
};

const resetFilters = () => {
  searchQuery.value = '';
  selectedCategory.value = '';
  activeTab.value = 'semua';
  showCategoryDropdown.value = false;
  showToast('Menampilkan semua informasi.');
};

const handleSubscribe = () => {
  const input = subscribeInput.value.trim();
  if (input === '') {
    alert('Masukkan email atau nomor WA terlebih dahulu!');
    return;
  }
  
  // Validation regex
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const waRegex = /^[0-9+]{8,15}$/;
  
  if (!emailRegex.test(input) && !waRegex.test(input)) {
    subscribeError.value = true;
    return;
  }
  
  subscribeError.value = false;
  isSubscribed.value = true;
  showToast('Terima kasih! Langganan info berhasil didaftarkan.');
};

const resetSubscribe = () => {
  isSubscribed.value = false;
  subscribeInput.value = '';
  subscribeError.value = false;
};

const showToast = (msg) => {
  toastMessage.value = msg;
  setTimeout(() => {
    toastMessage.value = '';
  }, 3000);
};

// Modal helpers
const openNewsDetail = (news) => {
  selectedNews.value = news;
};

const closeNewsDetail = () => {
  selectedNews.value = null;
};

const openAnnDetail = (ann) => {
  activeModalDetail.value = {
    ...ann,
    type: 'pengumuman'
  };
};

const openEventDetail = (event) => {
  activeModalDetail.value = {
    ...event,
    type: 'agenda'
  };
};

const closeActiveModal = () => {
  activeModalDetail.value = null;
};

// Pagination controls
const setPage = (pageNum) => {
  currentPageNum.value = pageNum;
  window.scrollTo({ top: 380, behavior: 'smooth' });
  showToast(`Halaman ${pageNum} dimuat.`);
};

const prevPage = () => {
  if (currentPageNum.value > 1) {
    setPage(currentPageNum.value - 1);
  }
};

const nextPage = () => {
  if (currentPageNum.value < totalPages.value) {
    setPage(currentPageNum.value + 1);
  }
};

// Fallback images
const handleImageError = (event, type) => {
  if (type === 'hero-bg') {
    event.target.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1200&q=80';
  } else {
    event.target.src = 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=800&q=80';
  }
};
</script>

<style scoped>
/* Page & Modal Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.25s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Category Dropdown Slide Down transition */
.slide-down-enter-active,
.slide-down-leave-active {
  transition: all 0.25s ease-out;
  max-height: 250px;
  opacity: 1;
  overflow: hidden;
}
.slide-down-enter-from,
.slide-down-leave-to {
  max-height: 0;
  opacity: 0;
  padding-top: 0;
  padding-bottom: 0;
  margin-top: 0;
  margin-bottom: 0;
}

/* News List Transition */
.list-enter-active,
.list-leave-active {
  transition: all 0.3s ease;
}
.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: scale(0.96);
}
</style>
