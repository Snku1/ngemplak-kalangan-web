<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative min-h-[360px] md:min-h-[400px] flex items-center justify-center overflow-hidden bg-gray-900 text-white">
      <div class="absolute inset-0 z-0">
        <img
          src="/images/hero-bg.png"
          alt="Latar Belakang Informasi"
          class="w-full h-full object-cover object-center opacity-60 scale-105"
          @error="handleImageError($event, 'hero-bg')"
        />
        <div class="absolute inset-0 bg-gradient-to-b from-[#0D6847]/85 via-[#0D6847]/75 to-gray-950/80"></div>
      </div>

      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center py-16">
        <h2 class="text-3xl md:text-5xl font-extrabold tracking-tight leading-tight mb-4 text-white">
          Informasi Padukuhan Ngemplak Kalangan
        </h2>
        <p class="text-sm md:text-base text-emerald-100 max-w-2xl mx-auto leading-relaxed font-medium">
          Pusat informasi terpadu Padukuhan Ngemplak Kalangan. Dapatkan update terbaru mengenai berita, agenda kegiatan, dan pengumuman resmi Padukuhan.
        </p>
      </div>
    </section>

    <!-- SEARCH & FILTER BAR -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-8 relative z-20">
      <div class="bg-white rounded-2xl p-6 shadow-xl shadow-gray-200/50">
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

        <!-- Category Dropdown -->
        <transition name="slide-down">
          <div v-if="showCategoryDropdown" class="mb-4 p-4.5 bg-gray-50 rounded-xl space-y-3">
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
                    : 'bg-white border-gray-200 text-gray-500 hover:bg-gray-100 hover:text-gray-700 font-semibold'
                ]"
                class="px-3.5 py-2 text-[11px] border rounded-lg transition-all cursor-pointer"
              >
                {{ cat }}
              </button>
            </div>
          </div>
        </transition>

        <!-- Filter Tabs -->
        <div class="flex flex-wrap items-center justify-center gap-2 pt-4 border-t border-gray-100">
          <button
            v-for="tab in filterTabs"
            :key="tab.value"
            @click="setTab(tab.value)"
            :class="[
              activeTab === tab.value
                ? 'bg-emerald-50 text-[#0D6847] font-extrabold border-[#0D6847]/40 shadow-xs scale-[1.02]'
                : 'bg-white hover:bg-gray-50 text-gray-500 font-bold border-gray-200'
            ]"
            class="px-6 py-2.5 text-xs border rounded-xl transition-all cursor-pointer active:scale-95"
          >
            {{ tab.label }}
          </button>
        </div>
      </div>
    </section>

    <!-- MAIN GRID -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

        <!-- LEFT COLUMN — full width saat tab berita/agenda/pengumuman -->
        <div :class="activeTab === 'semua' ? 'lg:col-span-2' : 'lg:col-span-3'" class="space-y-12">

          <!-- BERITA TERBARU -->
          <div v-if="activeTab === 'semua' || activeTab === 'berita'" class="space-y-6">
            <div class="flex items-center justify-between border-b border-gray-100 pb-4">
              <div class="flex items-center gap-2">
                <FileTextIcon class="w-5.5 h-5.5 text-[#0D6847]" />
                <h3 class="text-xl font-extrabold text-gray-950">Berita Terbaru</h3>
              </div>
              <button @click="resetFilters" class="text-xs font-bold text-[#0D6847] hover:underline">
                Lihat Semua
              </button>
            </div>

              <div
                v-if="paginatedNews.length > 0"
                :class="activeTab === 'berita' ? 'grid-cols-1 md:grid-cols-2 lg:grid-cols-3' : 'grid-cols-1 md:grid-cols-2'"
                class="grid gap-6"
              >
              <transition-group name="list">
                <article
                  v-for="news in paginatedNews"
                  :key="news.id"
                  @click="openNewsDetail(news)"
                  class="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-xl hover:bg-emerald-50/30 border border-transparent hover:border-emerald-200 transition-all duration-300 group flex flex-col h-full hover:-translate-y-1 cursor-pointer"
                >
                  <div class="relative overflow-hidden aspect-video bg-gray-100">
                    <img
                      :src="news.image"
                      :alt="news.title"
                      class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                      @error="handleImageError($event, 'placeholder')"
                    />
                    <span class="absolute top-4 left-4 bg-[#0A4A34] text-white text-[10px] font-bold uppercase tracking-wider px-3 py-1 rounded-full shadow-md">
                      {{ news.category }}
                    </span>
                  </div>
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

            <div v-else class="text-center py-12 bg-white rounded-2xl shadow-sm">
              <p class="text-sm text-gray-400 font-bold">Tidak ada berita yang cocok dengan kriteria pencarian.</p>
            </div>
          </div>

          <!-- PENGUMUMAN -->
          <div v-if="activeTab === 'semua' || activeTab === 'pengumuman'" class="space-y-6">
            <div class="flex items-center gap-2 border-b border-gray-100 pb-4">
              <BellIcon class="w-5.5 h-5.5 text-[#0D6847]" />
              <h3 class="text-xl font-extrabold text-gray-950">Pengumuman Penting</h3>
            </div>

            <div v-if="filteredAnnouncements.length > 0" class="space-y-4">
              <div
                v-for="ann in filteredAnnouncements"
                :key="ann.id"
                @click="openAnnDetail(ann)"
                :class="[
                  ann.isImportant
                    ? 'bg-red-50/40 hover:bg-red-50 hover:border-red-200'
                    : 'bg-blue-50/30 hover:bg-blue-50 hover:border-blue-200'
                ]"
                class="p-5.5 rounded-2xl border border-transparent transition-all duration-300 flex gap-4 hover:-translate-y-0.5 hover:shadow-lg cursor-pointer group"
              >
                <div
                  :class="[
                    ann.isImportant
                      ? 'bg-red-100 text-red-500'
                      : 'bg-blue-100 text-blue-500'
                  ]"
                  class="w-11 h-11 rounded-full flex items-center justify-center shrink-0"
                >
                  <AlertCircleIcon class="w-5 h-5" />
                </div>
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

            <div v-else class="text-center py-12 bg-white rounded-2xl shadow-sm">
              <p class="text-sm text-gray-400 font-bold">Tidak ada pengumuman yang ditemukan.</p>
            </div>
          </div>

          <!-- AGENDA DESA -->
          <div v-if="activeTab === 'agenda'" class="space-y-6">
            <div class="flex items-center gap-2 border-b border-gray-100 pb-4">
              <CalendarIcon class="w-5.5 h-5.5 text-[#0D6847]" />
              <h3 class="text-xl font-extrabold text-gray-950">Agenda Kegiatan Desa</h3>
            </div>

            <div class="space-y-4">
              <div
                v-for="event in events"
                :key="event.id"
                class="bg-white rounded-2xl p-6 shadow-sm hover:shadow-md transition-all flex flex-col md:flex-row items-start md:items-center gap-6 hover:-translate-y-0.5"
              >
                <div class="flex md:flex-col items-center justify-center shrink-0 w-16 h-16 bg-[#F0FAF5] text-[#0D6847] rounded-2xl text-center">
                  <span class="text-xs font-bold uppercase">{{ event.month }}</span>
                  <span class="text-2xl font-extrabold leading-none">{{ event.day }}</span>
                </div>
                <div class="flex-1 space-y-2">
                  <div class="flex items-center gap-2">
                    <span
                      :class="[
                        event.status === 'selesai'
                          ? 'bg-emerald-100 text-emerald-700'
                          : 'bg-amber-100 text-amber-700'
                      ]"
                      class="px-2.5 py-0.5 rounded text-[10px] font-bold uppercase"
                    >
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
          <div v-if="totalPages > 1 || activeTab === 'agenda' || activeTab === 'pengumuman'" class="pt-6 border-t border-gray-100 flex flex-col sm:flex-row items-center justify-between gap-4">
            <p class="text-xs text-gray-400 font-bold">
              Menampilkan {{ pageStartItem }} - {{ pageEndItem }} dari {{ totalFilteredCount }} informasi desa
            </p>
            <div class="flex items-center gap-1.5">
              <button
                @click="prevPage"
                :disabled="currentPageNum === 1"
                class="p-2.5 rounded-lg border border-gray-200 hover:border-[#0D6847] hover:text-[#0D6847] transition-all disabled:opacity-40 disabled:cursor-not-allowed cursor-pointer bg-white"
                aria-label="Halaman Sebelumnya"
              >
                <ArrowLeftIcon class="w-4 h-4" />
              </button>

              <button
                v-for="page in totalPages"
                :key="page"
                @click="setPage(page)"
                :class="[
                  currentPageNum === page
                    ? 'bg-[#0D6847] border-[#0D6847] text-white font-extrabold shadow-sm'
                    : 'bg-white border-gray-200 text-gray-600 hover:border-gray-300 font-semibold'
                ]"
                class="w-9 h-9 text-xs border rounded-lg transition-all cursor-pointer active:scale-95"
              >
                {{ page }}
              </button>

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

        <!-- RIGHT COLUMN: SIDEBAR — hanya tampil di tab "Semua" -->
        <div v-if="activeTab === 'semua'" class="space-y-8">

          <!-- AGENDA WIDGET -->
          <div class="bg-white rounded-2xl p-6 shadow-sm space-y-6">
            <div class="flex items-center gap-2 pb-4 border-b border-gray-100">
              <div class="w-8 h-8 rounded-lg bg-[#0D6847]/10 flex items-center justify-center text-[#0D6847]">
                <CalendarIcon class="w-4.5 h-4.5" />
              </div>
              <h3 class="font-extrabold text-gray-900 text-base">Agenda Padukuhan</h3>
            </div>

            <div class="space-y-4">
              <div
                v-for="event in events.slice(0, 3)"
                :key="event.id"
                @click="openEventDetail(event)"
                class="flex items-center gap-4 bg-gray-100 hover:bg-gray-200/80 p-3 rounded-xl border border-gray-200/60 transition-all cursor-pointer group"
              >
                <div class="flex flex-col items-center justify-center shrink-0 w-11 h-11 bg-white text-[#0D6847] rounded-lg text-center shadow-xs">
                  <span class="text-[8px] font-extrabold uppercase tracking-wider leading-none mb-0.5">{{ event.month }}</span>
                  <span class="text-base font-extrabold leading-none">{{ event.day }}</span>
                </div>
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
                <span
                  :class="[
                    event.status === 'selesai'
                      ? 'text-emerald-700 bg-emerald-50'
                      : 'text-amber-700 bg-amber-50'
                  ]"
                  class="text-[8px] font-bold px-1.5 py-0.5 rounded uppercase shrink-0"
                >
                  {{ event.status }}
                </span>
              </div>
            </div>

            <button
              @click="setTab('agenda')"
              class="w-full flex items-center justify-center gap-2 py-3 border border-gray-200 hover:border-[#0D6847] text-xs font-bold text-gray-600 hover:text-[#0D6847] rounded-xl transition-all cursor-pointer bg-white"
            >
              <CalendarIcon class="w-4 h-4" />
              <span>Semua Jadwal</span>
            </button>
          </div>

        </div>

      </div>
    </main>

    <!-- ============================================================ -->
    <!-- ARTICLE DETAIL MODAL — dengan Fullscreen                      -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="selectedNews"
        id="info-news-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="closeNewsDetail"
      >

        <!-- ============================================ -->
        <!-- FULLSCREEN MODE                              -->
        <!-- ============================================ -->
        <div v-if="isNewsFullscreen" class="relative w-full h-full flex items-center justify-center">

          <!-- Counter kiri atas -->
          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentImageIndex + 1 }} / {{ newsImages.length }}
          </div>

          <!-- Tombol Minimize + Close kanan atas -->
          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button
              @click.stop="toggleNewsFullscreen"
              class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center transition-colors cursor-pointer"
              title="Keluar Fullscreen"
            >
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button
              @click.stop="closeNewsDetail"
              class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center transition-colors cursor-pointer"
              title="Tutup"
            >
              <XIcon class="w-5 h-5" />
            </button>
          </div>

          <!-- Foto Fullscreen -->
          <img
            :src="activeNewsImage"
            :alt="selectedNews.title"
            class="max-w-full max-h-full object-contain"
          />

          <!-- Navigasi Prev/Next -->
          <template v-if="newsImages.length > 1">
            <button
              @click.stop="prevImage"
              class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-20"
            >
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button
              @click.stop="nextImage"
              class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-20"
            >
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>

          <!-- Thumbnail strip -->
          <div
            v-if="newsImages.length > 1"
            class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20"
          >
            <button
              v-for="(img, idx) in newsImages"
              :key="idx"
              @click.stop="currentImageIndex = idx"
              :class="currentImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer"
            >
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>

        </div>

        <!-- ============================================ -->
        <!-- NORMAL MODE                                  -->
        <!-- ============================================ -->
        <div v-else class="bg-white rounded-3xl max-w-2xl w-full max-h-[85vh] overflow-y-auto shadow-2xl flex flex-col">

          <!-- Galeri Foto (Multiple) -->
          <div class="relative bg-gray-900 shrink-0">

            <!-- Foto Utama -->
            <div class="relative h-64 md:h-80">
              <img
                :src="activeNewsImage"
                :alt="selectedNews.title"
                class="w-full h-full object-cover"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-75"></div>

              <!-- Tombol Close (kanan atas) -->
              <button
                @click="closeNewsDetail"
                class="absolute top-4 right-4 p-2 bg-black/55 hover:bg-black/75 text-white rounded-full transition-colors cursor-pointer z-10"
                aria-label="Tutup"
              >
                <XIcon class="w-5 h-5" />
              </button>

              <!-- Tombol Prev/Next -->
              <template v-if="newsImages.length > 1">
                <button
                  @click.stop="prevImage"
                  class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-10"
                  aria-label="Foto sebelumnya"
                >
                  <ChevronLeftIcon class="w-5 h-5" />
                </button>
                <button
                  @click.stop="nextImage"
                  class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center transition-colors cursor-pointer z-10"
                  aria-label="Foto berikutnya"
                >
                  <ChevronRightIcon class="w-5 h-5" />
                </button>
              </template>

              <!-- Counter Foto (KIRI BAWAH) -->
              <span
                v-if="newsImages.length > 1"
                class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10"
              >
                {{ currentImageIndex + 1 }} / {{ newsImages.length }}
              </span>

              <!-- Tombol Fullscreen (KANAN BAWAH) -->
              <button
                @click.stop="toggleNewsFullscreen"
                class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer z-10"
                title="Tampilkan Fullscreen"
              >
                <MaximizeIcon class="w-4 h-4" />
              </button>
            </div>

            <!-- Thumbnails -->
            <div v-if="newsImages.length > 1" class="flex items-center gap-2 p-3 bg-black/30 overflow-x-auto">
              <button
                v-for="(img, idx) in newsImages"
                :key="idx"
                @click="currentImageIndex = idx"
                :class="currentImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
                class="relative w-16 h-12 shrink-0 rounded-lg overflow-hidden transition-all cursor-pointer"
              >
                <img :src="img" class="w-full h-full object-cover" />
              </button>
            </div>
          </div>

          <!-- Content -->
          <div class="p-6 md:p-8 space-y-6">
            <div class="flex flex-wrap items-center gap-3 text-xs text-gray-400 font-bold uppercase tracking-wider">
              <span class="flex items-center gap-1">
                <CalendarIcon class="w-4 h-4" />
                {{ selectedNews.date }}
              </span>
              <span>•</span>
              <span class="flex items-center gap-1">
                <UserIcon class="w-4 h-4" />
                {{ selectedNews.author }}
              </span>
              <span>•</span>
              <span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 bg-emerald-50 text-[#0D6847] border border-emerald-200 rounded-full">
                <span class="w-1.5 h-1.5 rounded-full bg-[#0D6847]"></span>
                <span>{{ selectedNews.category }}</span>
              </span>
            </div>

            <h3 class="text-xl md:text-2xl font-extrabold text-gray-900 leading-snug">
              {{ selectedNews.title }}
            </h3>

            <div class="text-sm text-gray-600 leading-relaxed space-y-4 font-semibold">
              <p class="whitespace-pre-line">{{ selectedNews.content }}</p>
            </div>

            <div class="pt-6 border-t border-gray-100 flex justify-end">
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

    <!-- GENERAL MODAL -->
    <transition name="fade">
      <div
        v-if="activeModalDetail"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs"
        @click.self="closeActiveModal"
      >
        <div class="bg-white rounded-3xl max-w-md w-full p-6.5 shadow-2xl space-y-5">
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
                class="w-9 h-9 rounded-lg flex items-center justify-center shrink-0"
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

            <div v-if="activeModalDetail.type === 'agenda'" class="flex justify-start">
              <span
                :class="[
                  activeModalDetail.status === 'selesai'
                    ? 'bg-emerald-100 text-emerald-700'
                    : 'bg-amber-100 text-amber-700'
                ]"
                class="px-2.5 py-0.5 rounded text-[10px] font-bold uppercase"
              >
                {{ activeModalDetail.status }}
              </span>
            </div>

            <div v-if="activeModalDetail.type === 'agenda'" class="bg-gray-50 rounded-2xl p-4 space-y-2">
              <div class="flex items-center gap-2.5 text-xs text-gray-600 font-semibold">
                <CalendarIcon class="w-4 h-4 text-gray-400" />
                <span>Hari/Tanggal: <strong>{{ activeModalDetail.date || (activeModalDetail.day + ' ' + activeModalDetail.month) }}</strong></span>
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
            <p v-else-if="activeModalDetail.isImportant" class="text-[10px] text-red-500 font-bold leading-relaxed pt-2 flex items-center gap-1 bg-red-50/50 p-2 rounded-lg">
              <AlertCircleIcon class="w-4 h-4 shrink-0" />
              <span>* Harap perhatikan himbauan/informasi penting ini.</span>
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

    <!-- TOAST -->
    <transition name="fade">
      <div
        v-if="toastMessage"
        class="fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-3.5 bg-gray-900 text-white rounded-2xl shadow-xl"
      >
        <CheckCircleIcon class="w-5 h-5 text-emerald-400 shrink-0" />
        <span class="text-xs font-bold">{{ toastMessage }}</span>
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted } from 'vue';
import {
  Search as SearchIcon, Sliders as SlidersIcon, FileText as FileTextIcon,
  Calendar as CalendarIcon, Bell as BellIcon, Clock as ClockIcon,
  MapPin as MapPinIcon, ArrowRight as ArrowRightIcon,
  ArrowLeft as ArrowLeftIcon, X as XIcon, User as UserIcon,
  CheckCircle as CheckCircleIcon, AlertCircle as AlertCircleIcon,
  ChevronLeft as ChevronLeftIcon, ChevronRight as ChevronRightIcon,
  Maximize as MaximizeIcon, Minimize as MinimizeIcon
} from 'lucide-vue-next';
import { store } from '../store';

const searchQuery = ref('');
const activeTab = ref('semua');
const selectedCategory = ref('');
const toastMessage = ref('');
const showCategoryDropdown = ref(false);
const selectedNews = ref(null);
const activeModalDetail = ref(null);
const currentPageNum = ref(1);
const itemsPerPage = 3;

const filterTabs = [
  { label: 'Semua', value: 'semua' },
  { label: 'Berita', value: 'berita' },
  { label: 'Agenda', value: 'agenda' },
  { label: 'Pengumuman', value: 'pengumuman' }
];

// DATA DARI STORE
const newsData = computed(() => store.news);
const announcements = computed(() => store.pengumuman);
const events = computed(() => store.agenda);

const popularCategories = computed(() => {
  const cats = store.categoriesByTipe('berita').map(c => c.nama);
  return cats.length ? cats : ['Infrastruktur', 'Kesehatan', 'Pendidikan', 'UMKM'];
});

const currentImageIndex = ref(0);

// State fullscreen untuk berita
const isNewsFullscreen = ref(false);

const toggleNewsFullscreen = async () => {
  const el = document.getElementById('info-news-lightbox');
  if (!el) return;
  try {
    if (!document.fullscreenElement) {
      await el.requestFullscreen();
      isNewsFullscreen.value = true;
    } else {
      await document.exitFullscreen();
      isNewsFullscreen.value = false;
    }
  } catch (err) {
    console.warn('Fullscreen tidak didukung:', err);
  }
};

const handleFullscreenChange = () => {
  isNewsFullscreen.value = !!document.fullscreenElement;
};

onMounted(() => {
  document.addEventListener('fullscreenchange', handleFullscreenChange);
});

onUnmounted(() => {
  document.removeEventListener('fullscreenchange', handleFullscreenChange);
});

// Ambil daftar foto berita (gabungan thumbnail + images, unik)
const newsImages = computed(() => {
  if (!selectedNews.value) return [];
  const list = [];
  if (selectedNews.value.image) list.push(selectedNews.value.image);
  if (Array.isArray(selectedNews.value.images)) {
    selectedNews.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

const activeNewsImage = computed(() => newsImages.value[currentImageIndex.value] || '/images/hero-bg.png');

const prevImage = () => {
  if (currentImageIndex.value > 0) currentImageIndex.value--;
  else currentImageIndex.value = newsImages.value.length - 1;
};

const nextImage = () => {
  if (currentImageIndex.value < newsImages.value.length - 1) currentImageIndex.value++;
  else currentImageIndex.value = 0;
};

const filteredNews = computed(() => {
  let result = [...newsData.value];
  if (searchQuery.value.trim()) {
    const q = searchQuery.value.toLowerCase();
    result = result.filter(item =>
      item.title.toLowerCase().includes(q) ||
      (item.excerpt || '').toLowerCase().includes(q) ||
      (item.content || '').toLowerCase().includes(q)
    );
  }
  if (selectedCategory.value) {
    result = result.filter(item => item.category === selectedCategory.value);
  }
  return result;
});

const filteredAnnouncements = computed(() => {
  let result = [...announcements.value];
  if (searchQuery.value.trim()) {
    const q = searchQuery.value.toLowerCase();
    result = result.filter(item =>
      item.title.toLowerCase().includes(q) ||
      item.description.toLowerCase().includes(q)
    );
  }
  return result;
});

const totalFilteredCount = computed(() => {
  if (activeTab.value === 'berita') return filteredNews.value.length;
  if (activeTab.value === 'pengumuman') return filteredAnnouncements.value.length;
  if (activeTab.value === 'agenda') return events.value.length;
  return filteredNews.value.length;
});

const totalPages = computed(() => Math.ceil(totalFilteredCount.value / itemsPerPage));

const paginatedNews = computed(() => {
  const start = (currentPageNum.value - 1) * itemsPerPage;
  return filteredNews.value.slice(start, start + itemsPerPage);
});

const pageStartItem = computed(() => totalFilteredCount.value === 0 ? 0 : (currentPageNum.value - 1) * itemsPerPage + 1);
const pageEndItem = computed(() => Math.min(currentPageNum.value * itemsPerPage, totalFilteredCount.value));

watch([activeTab, selectedCategory, searchQuery], () => { currentPageNum.value = 1; });

// Methods
const handleSearch = () => showToast(`Pencarian "${searchQuery.value}" diterapkan.`);
const clearSearch = () => { searchQuery.value = ''; };
const toggleCategoryDropdown = () => { showCategoryDropdown.value = !showCategoryDropdown.value; };

const filterByCategory = (category) => {
  selectedCategory.value = selectedCategory.value === category ? '' : category;
  if (activeTab.value !== 'berita' && activeTab.value !== 'semua') activeTab.value = 'berita';
};
const clearCategoryFilter = () => { selectedCategory.value = ''; };
const setTab = (tabValue) => { activeTab.value = tabValue; selectedCategory.value = ''; };
const resetFilters = () => { searchQuery.value = ''; selectedCategory.value = ''; activeTab.value = 'semua'; };

const showToast = (msg) => { toastMessage.value = msg; setTimeout(() => toastMessage.value = '', 3000); };
const openNewsDetail = (news) => {
  selectedNews.value = news;
  currentImageIndex.value = 0;
  isNewsFullscreen.value = false; // reset
};

const closeNewsDetail = async () => {
  if (document.fullscreenElement) {
    try { await document.exitFullscreen(); } catch (e) {}
  }
  isNewsFullscreen.value = false;
  selectedNews.value = null;
};
const openAnnDetail = (ann) => { activeModalDetail.value = { ...ann, type: 'pengumuman' }; };
const openEventDetail = (event) => { activeModalDetail.value = { ...event, type: 'agenda' }; };
const closeActiveModal = () => { activeModalDetail.value = null; };
const setPage = (n) => { currentPageNum.value = n; window.scrollTo({ top: 380, behavior: 'smooth' }); };
const prevPage = () => { if (currentPageNum.value > 1) setPage(currentPageNum.value - 1); };
const nextPage = () => { if (currentPageNum.value < totalPages.value) setPage(currentPageNum.value + 1); };

const handleImageError = (event, type) => {
  event.target.src = type === 'hero-bg'
    ? 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1200&q=80'
    : 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=800&q=80';
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.25s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

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