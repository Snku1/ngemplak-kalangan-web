<template>
  <div>
    <!-- ============================================================ -->
    <!-- HERO SECTION                                                  -->
    <!-- ============================================================ -->
    <section class="relative min-h-[560px] md:min-h-[670px] flex items-center overflow-hidden bg-gray-900 text-white">
      <div class="absolute inset-0 z-0">
        <!-- Video Background -->
        <video
          autoplay
          muted
          loop
          playsinline
          preload="auto"
          :poster="heroPoster"
          class="w-full h-full object-cover object-center opacity-70"
          @error="handleVideoError"
        >
          <source src="/videos/hero-bg.mp4" type="video/mp4" />
          <source src="/videos/hero-bg.webm" type="video/webm" />
        </video>

        <!-- Fallback image (muncul kalau video tidak support / error) -->
        <img
          v-if="videoFailed"
          src="/images/hero-bg.png"
          alt="Latar Belakang Padukuhan"
          class="absolute inset-0 w-full h-full object-cover object-center opacity-70"
          @error="handleImageError($event, 'hero-bg')"
        />

        <!-- Overlay gradient (tetap) -->
        <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-900/60 to-gray-950/40"></div>
      </div>

      <div class="relative z-10 w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 md:py-28">
        <div class="max-w-3xl">
          <span class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/15 backdrop-blur-md border border-white/25 text-xs font-semibold tracking-wide text-white mb-6">
            <MapPinIcon class="w-3.5 h-3.5 text-emerald-300" />
            {{ store.padukuhanProfile?.kecamatan || 'Kecamatan' }}, {{ store.padukuhanProfile?.kabupaten || 'Kabupaten' }}
          </span>

          <h1 class="text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-extrabold tracking-tight leading-[1.05] mb-5 text-white">
            Selamat Datang <br class="hidden sm:block" />
            di Padukuhan <br class="hidden sm:block" />
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-200">
              {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}
            </span>
          </h1>

          <p class="text-base md:text-lg text-gray-200 max-w-xl leading-relaxed mb-10">
            {{ store.padukuhanProfile?.cita_cita?.substring(0, 120) + '...' || 'Padukuhan yang asri, berbudaya, dan berdaya mandiri dengan semangat gotong royong.' }}
          </p>

          <div class="flex flex-wrap items-center gap-4">
            <button
              @click="$emit('navigate', 'profil')"
              class="inline-flex items-center gap-2.5 px-6 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white font-bold rounded-xl shadow-lg hover:shadow-emerald-900/30 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer"
            >
              <CompassIcon class="w-4 h-4" />
              <span>Mulai Jelajahi</span>
            </button>
            <button
              @click="$emit('navigate', 'kontak')"
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
    <!-- 4 NAV CARDS                                                   -->
    <!-- ============================================================ -->
    <section class="relative z-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-10 md:-mt-14">
      <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6">

        <div @click="$emit('navigate', 'potensi')" class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
          <img :src="store.potensiWisata?.[0]?.foto_url || store.potensiWisata?.[0]?.image || '/images/hero-bg.png'" alt="Wisata" class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" @error="handleImageError($event, 'potensi')" />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-5 text-white">
            <h3 class="text-lg md:text-xl font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>Wisata</span>
              <ArrowRightIcon class="w-5 h-5 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

        <div @click="$emit('navigate', 'produk')" class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
          <img :src="store.umkms?.[0]?.image || '/images/anyaman-bambu.png'" alt="UMKM" class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" @error="handleImageError($event, 'anyaman-bambu')" />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-5 text-white">
            <h3 class="text-lg md:text-xl font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>UMKM</span>
              <ArrowRightIcon class="w-5 h-5 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

        <div @click="$emit('navigate', 'galeri')" class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
          <img :src="store.gallery?.[0]?.image || '/images/hero-bg.png'" alt="Galeri" class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" @error="handleImageError($event, 'galeri-1')" />
          <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
          <div class="relative h-full flex flex-col justify-end p-3.5 md:p-4 text-white">
            <h3 class="text-sm md:text-base font-extrabold leading-tight flex items-center justify-between gap-2">
              <span>Galeri</span>
              <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform shrink-0" />
            </h3>
          </div>
        </div>

        <div @click="$emit('navigate', 'informasi')" class="relative aspect-[3/2] sm:aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
          <img :src="store.news?.[0]?.image || '/images/hero-bg.png'" alt="Berita" class="absolute inset-0 w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" @error="handleImageError($event, 'news-0')" />
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
    <!-- SAMBUTAN + DATA DESA                                          -->
    <!-- ============================================================ -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-20">
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-12 items-start">

        <div class="lg:col-span-7 space-y-5">
          <span class="text-xs font-extrabold text-[#12544F] uppercase tracking-widest">
            Selamat Datang di Padukuhan
          </span>
          <h2 class="text-3xl sm:text-4xl md:text-[35px] font-extrabold text-[#0F2D3F] leading-tight tracking-tight">
            {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}
          </h2>
          <p class="text-sm md:text-base text-gray-600 leading-relaxed whitespace-pre-line">
            {{ store.padukuhanProfile?.sejarah }}
          </p>
        </div>

        <div class="lg:col-span-5 lg:pl-4">
          <div class="bg-white rounded-2xl overflow-hidden border border-gray-200 shadow-sm">
            <div class="bg-[#0D6847] px-6 py-3.5">
              <h3 class="text-white font-extrabold text-base tracking-wide">Data Padukuhan</h3>
            </div>
            <div class="divide-y divide-gray-200">
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">Penduduk</span>
                <span class="text-base font-extrabold text-[#0D6847]">
                  {{ store.padukuhanProfile?.jumlah_penduduk ? store.padukuhanProfile.jumlah_penduduk.toLocaleString('id-ID') + ' jiwa' : '-' }}
                </span>
              </div>
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">Luas wilayah</span>
                <span class="text-base font-extrabold text-[#0D6847]">{{ store.padukuhanProfile?.luas_wilayah || '-' }}</span>
              </div>
              <div class="flex items-center justify-between px-6 py-4">
                <span class="text-sm text-gray-600 font-medium">Dusun</span>
                <span class="text-base font-extrabold text-[#0D6847]">{{ store.padukuhanProfile?.jumlah_dusun || '-' }}</span>
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
    <!-- LIHAT PADUKUHAN DARI PERSPEKTIF BERBEDA                       -->
    <!-- ============================================================ -->
    <section v-if="highlightVideo" class="bg-gray-100/70 border-t border-b border-gray-200 py-16 md:py-24">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">

          <div class="lg:col-span-5 flex justify-center">
            <div @click="openHighlightVideo" class="relative w-full max-w-md aspect-[4/3] rounded-3xl overflow-hidden shadow-2xl border-4 border-white group cursor-pointer">
              <img
                :src="highlightVideo.thumbnail"
                alt="Video Profil Padukuhan"
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError($event, 'hero-bg')"
              />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-950/40 to-transparent"></div>
              <div class="absolute inset-0 flex items-center justify-center">
                <div class="w-16 h-16 rounded-full bg-[#0D6847] text-white flex items-center justify-center shadow-2xl border-2 border-white/30 group-hover:scale-115 transition-transform duration-300">
                  <PlayIcon class="w-7 h-7 fill-current ml-1" />
                </div>
              </div>
              <div class="absolute bottom-6 left-6 right-6">
                <h3 class="text-lg font-extrabold text-white mt-2 leading-snug">{{ highlightVideoTitle }}</h3>
              </div>
            </div>
          </div>

          <div class="lg:col-span-7 space-y-6">
            <h2 class="text-3xl md:text-4xl font-extrabold text-[#0F2D3F] leading-tight">Lihat Padukuhan Dari Perspektif Berbeda</h2>
            <p class="text-sm text-gray-600 leading-relaxed font-medium">
              Video profil ini merangkum seluruh potensi desa, mulai dari keasrian alam, kerajinan tangan lokal, hingga kehangatan kebersamaan masyarakat yang guyub rukun.
            </p>
            <ul class="space-y-3.5 pt-2">
              <li v-for="(item, idx) in highlights" :key="idx" class="flex items-center gap-3 text-xs md:text-sm text-gray-700 font-bold">
                <div class="w-6 h-6 rounded-full bg-emerald-100 text-[#0D6847] flex items-center justify-center shrink-0">
                  <ChevronRightIcon class="w-4 h-4" />
                </div>
                <span>{{ item }}</span>
              </li>
            </ul>
            <div class="pt-4">
              <button @click="openHighlightVideo" class="inline-flex items-center gap-2.5 px-6 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md hover:shadow-lg transition-all active:scale-95 cursor-pointer">
                <span>Tonton Video Padukuhan</span>
                <ChevronRightIcon class="w-4 h-4" />
              </button>
            </div>
          </div>

        </div>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- VIDEO MODAL                                                   -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="showVideoModal"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="showVideoModal = false"
      >
        <div class="relative w-full max-w-4xl">

          <button
            @click="showVideoModal = false"
            class="absolute -top-12 right-0 w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 text-white flex items-center justify-center backdrop-blur-md cursor-pointer z-10"
          >
            <XIcon class="w-5 h-5" />
          </button>

          <div class="aspect-video bg-black rounded-2xl overflow-hidden shadow-2xl">
            <!-- YouTube Embed -->
            <iframe
              v-if="highlightVideo?.isYouTube && highlightVideo.embedUrl"
              :src="highlightVideo.embedUrl"
              class="w-full h-full"
              frameborder="0"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
              allowfullscreen
            ></iframe>

            <!-- File Video Lokal (fallback) -->
            <video
              v-else-if="highlightVideo?.url"
              :src="highlightVideo.url"
              controls
              autoplay
              class="w-full h-full object-contain"
            ></video>
          </div>

          <h3 class="text-white text-center font-extrabold text-lg mt-4">{{ highlightVideoTitle }}</h3>
        </div>
      </div>
    </transition>

    <!-- ============================================================ -->
    <!-- BERITA & PENGUMUMAN — AUTO-SLIDE CAROUSEL                    -->
    <!-- ============================================================ -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">

      <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
        <div>
          <span class="text-xs font-bold text-[#12544F] uppercase tracking-widest">Informasi</span>
          <h2 class="text-3xl md:text-4xl font-extrabold text-[#0F2D3F] mt-1">Berita &amp; Pengumuman</h2>
        </div>
        <button @click="$emit('navigate', 'informasi')" class="self-start md:self-auto flex items-center gap-1.5 text-sm font-bold text-[#0D6847] hover:text-[#0A5238] transition-colors group cursor-pointer">
          <span>Semua Berita</span>
          <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
        </button>
      </div>

      <!-- CAROUSEL WRAPPER -->
      <div v-if="store.news.length > 0" class="relative">
        <!-- Viewport -->
        <div class="overflow-hidden rounded-2xl">
          <div
            class="flex transition-transform duration-700 ease-out"
            :style="{ transform: `translateX(-${carouselIndex * 100}%)` }"
          >
            <!-- Setiap slide = 3 kartu berita -->
            <div
              v-for="(slide, sIdx) in newsSlides"
              :key="sIdx"
              class="w-full shrink-0 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8"
            >
              <article
                v-for="item in slide"
                :key="item.id"
                @click="openNewsDetail(item)"
                class="bg-white rounded-2xl overflow-hidden border border-gray-200 hover:shadow-xl transition-all duration-300 group cursor-pointer hover:-translate-y-1"
              >
                <div class="relative aspect-[16/10] bg-gray-100 overflow-hidden">
                  <img :src="item.image" :alt="item.title" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" @error="handleImageError($event, 'news-' + item.id)" />
                </div>
                <div class="p-5 md:p-6 flex flex-col">
                  <div class="flex items-center gap-1.5 text-[11px] font-bold text-[#0F2D3F] mb-2">
                    <CalendarIcon class="w-3.5 h-3.5" />
                    <span>{{ item.date }}</span>
                  </div>
                  <h3 class="text-lg font-extrabold text-[#1B5E20] leading-snug group-hover:text-[#0A5238] transition-colors mb-2.5 line-clamp-2">
                    {{ item.title }}
                  </h3>
                  <p class="text-sm text-gray-500 leading-relaxed line-clamp-3">
                    {{ item.excerpt || item.content }}
                  </p>
                </div>
              </article>
            </div>
          </div>
        </div>

        <!-- Navigation Arrows -->
        <button
          v-if="newsSlides.length > 1"
          @click="prevSlide"
          class="absolute left-0 top-1/2 -translate-y-1/2 -translate-x-3 md:-translate-x-6 w-11 h-11 rounded-full bg-white shadow-lg border border-gray-200 hover:bg-[#0D6847] hover:text-white text-gray-700 flex items-center justify-center transition-all cursor-pointer z-10"
          aria-label="Sebelumnya"
        >
          <ChevronLeftIcon class="w-5 h-5" />
        </button>
        <button
          v-if="newsSlides.length > 1"
          @click="nextSlide"
          class="absolute right-0 top-1/2 -translate-y-1/2 translate-x-3 md:translate-x-6 w-11 h-11 rounded-full bg-white shadow-lg border border-gray-200 hover:bg-[#0D6847] hover:text-white text-gray-700 flex items-center justify-center transition-all cursor-pointer z-10"
          aria-label="Selanjutnya"
        >
          <ChevronRightIcon class="w-5 h-5" />
        </button>

        <!-- Dots Indicator -->
        <div v-if="newsSlides.length > 1" class="flex items-center justify-center gap-2 mt-8">
          <button
            v-for="(_, idx) in newsSlides"
            :key="idx"
            @click="carouselIndex = idx"
            :class="carouselIndex === idx ? 'bg-[#0D6847] w-8' : 'bg-gray-300 hover:bg-gray-400 w-2.5'"
            class="h-2.5 rounded-full transition-all cursor-pointer"
            :aria-label="`Slide ${idx + 1}`"
          ></button>
        </div>
      </div>

      <div v-else class="text-center py-16 bg-gray-50 rounded-2xl border border-gray-200">
        <p class="text-sm text-gray-400 font-semibold">Belum ada berita yang dipublikasikan.</p>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- DOKUMENTASI GALERI (AUTO-SLIDE GRID)                          -->
    <!-- ============================================================ -->
    <section v-if="store.gallery.length > 0" class="bg-white py-16 md:py-24 border-t border-gray-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-5xl font-extrabold text-[#0F2D3F] tracking-tight uppercase">
            Dokumentasi
          </h2>
        </div>

        <!-- GRID GALERI dengan AUTO-SLIDE -->
        <div v-if="currentGallerySlide.length > 0" class="relative">
          <div class="relative">

            <!-- Navigation Arrows -->
            <button
              v-if="gallerySlides.length > 1"
              @click="prevGallerySlide"
              class="absolute left-0 md:left-2 top-1/2 -translate-y-1/2 -translate-x-3 md:-translate-x-6 z-20 w-11 h-11 rounded-full bg-white shadow-lg border border-gray-200 hover:bg-[#0D6847] hover:text-white text-gray-700 flex items-center justify-center transition-all cursor-pointer"
              aria-label="Galeri sebelumnya"
            >
              <ChevronLeftIcon class="w-5 h-5" />
            </button>
            <button
              v-if="gallerySlides.length > 1"
              @click="nextGallerySlide"
              class="absolute right-0 md:right-2 top-1/2 -translate-y-1/2 translate-x-3 md:translate-x-6 z-20 w-11 h-11 rounded-full bg-white shadow-lg border border-gray-200 hover:bg-[#0D6847] hover:text-white text-gray-700 flex items-center justify-center transition-all cursor-pointer"
              aria-label="Galeri selanjutnya"
            >
              <ChevronRightIcon class="w-5 h-5" />
            </button>

            <!-- Transition Group -->
            <transition name="gallery-fade" mode="out-in">
              <div
                :key="gallerySlideIndex"
                class="grid grid-cols-1 md:grid-cols-3 md:grid-rows-2 gap-4 md:gap-6"
              >
                <!-- Foto BESAR -->
                <div
                  v-if="galleryBig"
                  @click="openGalleryDetail(galleryBig)"
                  class="md:col-span-1 md:row-span-2 relative aspect-[3/4] md:aspect-auto md:h-full min-h-[300px] md:min-h-[500px] rounded-2xl overflow-hidden cursor-pointer group shadow-sm hover:shadow-2xl transition-all duration-300"
                >
                  <img
                    :src="galleryBig.image"
                    :alt="galleryBig.title"
                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
                    @error="handleImageError($event, 'galeri-1')"
                  />
                  <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
                    <div>
                      <span class="text-[10px] font-bold text-emerald-300 uppercase tracking-widest block mb-1">{{ galleryBig.category }}</span>
                      <h3 class="text-white font-extrabold text-lg leading-snug line-clamp-2">{{ galleryBig.title }}</h3>
                    </div>
                  </div>
                </div>

                <!-- 4 Foto KECIL -->
                <template v-for="item in gallerySmall" :key="item.id">
                  <div
                    @click="openGalleryDetail(item)"
                    class="relative aspect-[16/10] rounded-2xl overflow-hidden cursor-pointer group shadow-sm hover:shadow-2xl transition-all duration-300"
                  >
                    <img
                      :src="item.image"
                      :alt="item.title"
                      class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
                      @error="handleImageError($event, 'galeri-1')"
                    />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-5">
                      <div>
                        <span class="text-[10px] font-bold text-emerald-300 uppercase tracking-widest block mb-1">{{ item.category }}</span>
                        <h3 class="text-white font-extrabold text-sm leading-snug line-clamp-1">{{ item.title }}</h3>
                      </div>
                    </div>
                  </div>
                </template>

                <!-- Placeholder -->
                <div
                  v-for="n in Math.max(0, 4 - gallerySmall.length)"
                  :key="'placeholder-' + n"
                  class="relative aspect-[16/10] rounded-2xl bg-gray-100 border border-dashed border-gray-300 flex items-center justify-center"
                >
                  <p class="text-xs text-gray-400 font-semibold">Foto belum tersedia</p>
                </div>
              </div>
            </transition>

          </div>

          <!-- Dots -->
          <div v-if="gallerySlides.length > 1" class="flex items-center justify-center gap-2 mt-8">
            <button
              v-for="(_, idx) in gallerySlides"
              :key="idx"
              @click="gallerySlideIndex = idx"
              :class="gallerySlideIndex === idx ? 'bg-[#0D6847] w-8' : 'bg-gray-300 hover:bg-gray-400 w-2.5'"
              class="h-2.5 rounded-full transition-all cursor-pointer"
              :aria-label="`Grup ${idx + 1}`"
            ></button>
          </div>

        </div>

        <div v-else class="text-center py-16 bg-gray-50 rounded-2xl border border-gray-200">
          <p class="text-sm text-gray-400 font-semibold">Belum ada dokumentasi foto.</p>
        </div>

        <!-- CTA Section -->
        <div class="flex flex-col md:flex-row items-center justify-between gap-6 pt-8 border-t border-gray-100">
          <h3 class="text-2xl md:text-4xl font-extrabold text-[#0F2D3F] tracking-tight text-center md:text-left leading-tight">
            NEED SEE MORE<br />OUR MOMENT?
          </h3>
          <a
            href="https://www.instagram.com/kalangankarsa"
            target="_blank"
            rel="noopener"
            class="inline-flex items-center gap-3 px-8 py-4 bg-black hover:bg-gray-800 text-white text-sm font-bold rounded-full shadow-lg transition-all active:scale-95 cursor-pointer"
          >
            <InstagramIcon class="w-5 h-5" />
            <span>FOLLOW OUR INSTAGRAM</span>
          </a>
        </div>

      </div>
    </section>

    <!-- ============================================================ -->
    <!-- HAL YANG BISA DILAKUKAN                                       -->
    <!-- ============================================================ -->
    <section class="bg-white py-16 md:py-24 border-t border-gray-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <h2 class="text-3xl md:text-4xl font-extrabold text-[#0F2D3F]">Hal yang Bisa Dilakukan</h2>
          </div>
          <button @click="$emit('navigate', 'potensi')" class="self-start md:self-auto flex items-center gap-1.5 text-sm font-bold text-[#0D6847] hover:text-[#0A5238] transition-colors group cursor-pointer">
            <span>Semua Potensi</span>
            <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
          </button>
        </div>

        <div v-if="store.potensiWisata.length > 0" class="grid grid-cols-1 lg:grid-cols-2 gap-6 md:gap-8">
          <!-- Kartu BESAR -->
          <div
            @click="openPotensiDetail(store.potensiWisata[0])"
            class="relative rounded-2xl overflow-hidden min-h-[320px] md:min-h-[420px] group cursor-pointer shadow-sm hover:shadow-xl transition-all duration-300"
          >
            <img :src="store.potensiWisata[0].foto_url || store.potensiWisata[0].image || '/images/hero-bg.png'" :alt="store.potensiWisata[0].nama" class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" @error="handleImageError($event, 'potensi')" />
            <div class="absolute inset-0 bg-gradient-to-t from-[#0D6847] via-[#0D6847]/10 to-transparent"></div>
            <div class="relative h-full flex flex-col justify-end p-6 md:p-10 text-white">
              <h3 class="text-2xl md:text-3xl font-extrabold leading-tight mb-3">{{ store.potensiWisata[0].nama }}</h3>
              <p class="text-sm md:text-base text-white/85 leading-relaxed max-w-lg line-clamp-3">{{ store.potensiWisata[0].deskripsi }}</p>
            </div>
          </div>

          <!-- 2 Kartu KECIL -->
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-6 md:gap-8">
            <template v-for="item in store.potensiWisata.slice(1, 3)" :key="item.id">
              <div
                @click="openPotensiDetail(item)"
                class="bg-white rounded-2xl overflow-hidden border border-gray-200 group cursor-pointer hover:shadow-lg transition-all duration-300 flex flex-col sm:flex-row lg:flex-col"
              >
                <div class="relative sm:w-2/5 lg:w-full aspect-[16/10] lg:aspect-[16/9] bg-gray-100 overflow-hidden shrink-0">
                  <img :src="item.foto_url || item.image || '/images/hero-bg.png'" :alt="item.nama" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" @error="handleImageError($event, 'potensi')" />
                </div>
                <div class="p-5 flex-1 flex flex-col">
                  <h3 class="text-base md:text-lg font-extrabold text-[#0D6847] group-hover:text-[#0A5238] transition-colors leading-snug mb-2">{{ item.nama }}</h3>
                  <p class="text-xs md:text-sm text-gray-500 leading-relaxed line-clamp-2">{{ item.deskripsi }}</p>
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
    <!-- UMKM UNGGULAN                                                 -->
    <!-- ============================================================ -->
    <section class="bg-[#092328] py-16 md:py-24">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <span class="text-xs font-bold text-[#86EFAC] uppercase tracking-widest">Produk Lokal</span>
            <h2 class="text-3xl md:text-4xl font-extrabold text-white mt-1">UMKM Unggulan</h2>
          </div>
          <button @click="$emit('navigate', 'produk')" class="self-start md:self-auto flex items-center gap-1.5 text-sm font-bold text-[#86EFAC] hover:text-white transition-colors group cursor-pointer">
            <span>Lihat Semua</span>
            <ArrowRightIcon class="w-4 h-4 group-hover:translate-x-1 transition-transform" />
          </button>
        </div>

        <div v-if="store.umkms.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 md:gap-6">
          <article
            v-for="item in store.umkms.slice(0, 4)"
            :key="item.id"
            class="bg-[#1F6F5F] rounded-2xl flex flex-col group shadow-md hover:shadow-xl transition-all duration-300 overflow-hidden"
          >
            <!-- Foto full width tanpa padding -->
            <div class="relative aspect-[4/3] bg-emerald-900/40 overflow-hidden cursor-pointer"
              @click="openProductDetail(item)">
              <img :src="item.image" :alt="item.name" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" @error="handleImageError($event, 'product')" />
            </div>

            <!-- Konten dengan padding -->
            <div class="p-4 flex flex-col flex-1">
              <span class="text-[10px] font-bold text-[#86EFAC] uppercase tracking-widest mb-1">{{ item.kategori || 'UMKM' }}</span>
              <h3 class="text-base font-extrabold text-white leading-snug mb-2 line-clamp-2">{{ item.name }}</h3>
              <p class="text-xs text-emerald-100/80 leading-relaxed line-clamp-2 mb-4 flex-1">{{ item.description }}</p>
              <a :href="getWhatsAppUrl(item)" target="_blank" @click.stop class="w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-[#25D366] hover:bg-[#1EBE5A] text-white text-xs font-bold rounded-xl shadow-sm transition-all duration-200 active:scale-95 cursor-pointer">
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

    <!-- ============================================================ -->
    <!-- PETA LOKASI PADUKUHAN                                         -->
    <!-- ============================================================ -->
    <section class="bg-[#F8FAFC] py-16 md:py-24 border-t border-gray-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <span class="text-xs font-bold text-[#12544F] uppercase tracking-widest">Lokasi</span>
            <h2 class="text-3xl md:text-4xl font-extrabold text-[#0F2D3F] mt-1">Peta Padukuhan</h2>
            <p class="text-sm md:text-base text-gray-500 mt-2 max-w-2xl leading-relaxed">
              Temukan lokasi Padukuhan {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }} pada peta di bawah ini.
            </p>
          </div>
          <a v-if="store.padukuhanProfile?.maps_embed" :href="store.padukuhanProfile.maps_embed" target="_blank" class="self-start md:self-auto inline-flex items-center gap-2 px-5 py-3 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-all duration-300 active:scale-95 cursor-pointer">
            <MapPinIcon class="w-4 h-4" />
            <span>Buka di Google Maps</span>
            <ArrowRightIcon class="w-4 h-4" />
          </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
          <div class="bg-white rounded-xl p-4 border border-gray-200 shadow-sm flex items-center gap-3">
            <div class="w-10 h-10 rounded-lg bg-emerald-50 text-[#0D6847] flex items-center justify-center shrink-0"><MapPinIcon class="w-5 h-5" /></div>
            <div class="min-w-0">
              <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Kapanewon</p>
              <p class="text-sm font-extrabold text-gray-900 truncate">{{ store.padukuhanProfile?.kecamatan || '-' }}</p>
            </div>
          </div>
          <div class="bg-white rounded-xl p-4 border border-gray-200 shadow-sm flex items-center gap-3">
            <div class="w-10 h-10 rounded-lg bg-emerald-50 text-[#0D6847] flex items-center justify-center shrink-0"><HomeIcon class="w-5 h-5" /></div>
            <div class="min-w-0">
              <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Kabupaten</p>
              <p class="text-sm font-extrabold text-gray-900 truncate">{{ store.padukuhanProfile?.kabupaten || '-' }}</p>
            </div>
          </div>
          <div class="bg-white rounded-xl p-4 border border-gray-200 shadow-sm flex items-center gap-3">
            <div class="w-10 h-10 rounded-lg bg-emerald-50 text-[#0D6847] flex items-center justify-center shrink-0"><CompassIcon class="w-5 h-5" /></div>
            <div class="min-w-0">
              <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Provinsi</p>
              <p class="text-sm font-extrabold text-gray-900 truncate">{{ store.padukuhanProfile?.provinsi || '-' }}</p>
            </div>
          </div>
        </div>

        <div class="rounded-3xl overflow-hidden border border-gray-200 shadow-lg bg-white">
          <iframe
            v-if="store.padukuhanProfile?.maps_embed"
            :src="getOSMEmbedUrl(store.padukuhanProfile.maps_embed)"
            width="100%" height="480" style="border:0" loading="lazy"
            referrerpolicy="no-referrer-when-downgrade" allowfullscreen
          ></iframe>
          <div v-else class="aspect-[16/9] flex flex-col items-center justify-center bg-gray-50 text-center p-12">
            <div class="w-16 h-16 rounded-full bg-emerald-50 text-[#0D6847] flex items-center justify-center mb-4"><MapPinIcon class="w-8 h-8" /></div>
            <h3 class="text-base font-extrabold text-gray-700 mb-1">Peta Belum Tersedia</h3>
            <p class="text-xs text-gray-400 max-w-md">Admin dapat menambahkan link Google Maps di menu <strong>Panel Admin → Profil Padukuhan → URL Google Maps</strong>.</p>
          </div>
        </div>

      </div>
    </section>

    <!-- ============================================================ -->
    <!-- NEWS DETAIL MODAL                                             -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="selectedNews"
        id="news-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="closeNewsDetail"
      >
        <div v-if="isNewsFullscreen" class="relative w-full h-full flex items-center justify-center">
          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentNewsImageIndex + 1 }} / {{ newsImages.length }}
          </div>
          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button @click.stop="toggleNewsFullscreen" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button @click.stop="closeNewsDetail" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <XIcon class="w-5 h-5" />
            </button>
          </div>
          <img :src="activeNewsImage" :alt="selectedNews.title" class="max-w-full max-h-full object-contain" />
          <template v-if="newsImages.length > 1">
            <button @click.stop="prevNewsImage" class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center cursor-pointer z-20">
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button @click.stop="nextNewsImage" class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center cursor-pointer z-20">
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>
          <div v-if="newsImages.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20">
            <button v-for="(img, idx) in newsImages" :key="idx" @click.stop="currentNewsImageIndex = idx"
              :class="currentNewsImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer">
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>
        </div>

        <div v-else class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl flex flex-col">
          <div class="relative bg-gray-900 shrink-0">
            <div class="relative aspect-video overflow-hidden">
              <img :src="activeNewsImage" :alt="selectedNews.title" class="w-full h-full object-cover" />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-60"></div>
              <button @click="closeNewsDetail" class="absolute top-4 right-4 z-20 w-10 h-10 rounded-full bg-black/55 hover:bg-black/80 text-white flex items-center justify-center cursor-pointer">
                <XIcon class="w-5 h-5" />
              </button>
              <template v-if="newsImages.length > 1">
                <button @click.stop="prevNewsImage" class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronLeftIcon class="w-5 h-5" />
                </button>
                <button @click.stop="nextNewsImage" class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronRightIcon class="w-5 h-5" />
                </button>
              </template>
              <span v-if="newsImages.length > 1" class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10">
                {{ currentNewsImageIndex + 1 }} / {{ newsImages.length }}
              </span>
              <button @click.stop="toggleNewsFullscreen" class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full cursor-pointer z-10" title="Fullscreen">
                <MaximizeIcon class="w-4 h-4" />
              </button>
            </div>
            <div v-if="newsImages.length > 1" class="flex items-center gap-2 p-3 bg-black/40 overflow-x-auto">
              <button v-for="(img, idx) in newsImages" :key="idx" @click="currentNewsImageIndex = idx"
                :class="currentNewsImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
                class="relative w-16 h-12 shrink-0 rounded-lg overflow-hidden transition-all cursor-pointer">
                <img :src="img" class="w-full h-full object-cover" />
              </button>
            </div>
          </div>

          <div class="p-6 md:p-8 space-y-5">
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
                {{ selectedNews.category }}
              </span>
            </div>
            <h3 class="text-2xl font-extrabold text-gray-900 leading-snug">{{ selectedNews.title }}</h3>
            <div class="text-sm text-gray-600 leading-relaxed space-y-4 font-medium">
              <p class="whitespace-pre-line">{{ selectedNews.content }}</p>
            </div>
            <div class="pt-6 border-t border-gray-100 flex justify-end">
              <button @click="closeNewsDetail" class="px-6 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-800 text-xs font-bold rounded-xl transition-all cursor-pointer">
                Tutup Halaman
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- ============================================================ -->
    <!-- GALLERY DETAIL MODAL                                         -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div v-if="selectedGallery" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/85 backdrop-blur-xs" @click.self="selectedGallery = null">
        <button @click="selectedGallery = null" class="absolute top-4 right-4 z-30 w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 text-white flex items-center justify-center backdrop-blur-md cursor-pointer">
          <XIcon class="w-5 h-5" />
        </button>
        <div v-if="galleryImages.length > 1" class="absolute top-6 left-6 z-30 text-white text-xs font-bold bg-black/40 backdrop-blur-md px-3 py-1.5 rounded-full">
          {{ currentGalleryImageIndex + 1 }} / {{ galleryImages.length }}
        </div>
        <button v-if="galleryImages.length > 1" @click.stop="prevGalleryImage"
          class="absolute left-4 md:left-8 top-1/2 -translate-y-1/2 w-12 h-12 bg-white/10 hover:bg-white/20 text-white rounded-full flex items-center justify-center backdrop-blur-md z-30 cursor-pointer">
          <ChevronLeftIcon class="w-6 h-6" />
        </button>
        <button v-if="galleryImages.length > 1" @click.stop="nextGalleryImage"
          class="absolute right-4 md:right-8 top-1/2 -translate-y-1/2 w-12 h-12 bg-white/10 hover:bg-white/20 text-white rounded-full flex items-center justify-center backdrop-blur-md z-30 cursor-pointer">
          <ChevronRightIcon class="w-6 h-6" />
        </button>
        <div class="max-w-5xl w-full max-h-[85vh] flex flex-col items-center" @click.stop>
          <img :src="activeGalleryImage" :alt="selectedGallery.title"
            class="max-w-full max-h-[75vh] object-contain rounded-lg shadow-2xl" />
          <div class="mt-4 text-center text-white max-w-2xl">
            <h3 class="text-base font-extrabold mb-1">{{ selectedGallery.title }}</h3>
            <p v-if="selectedGallery.deskripsi" class="text-xs text-gray-300 line-clamp-2">{{ selectedGallery.deskripsi }}</p>
          </div>
        </div>
        <div v-if="galleryImages.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-3 bg-black/50 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20">
          <button v-for="(img, idx) in galleryImages" :key="idx" @click.stop="currentGalleryImageIndex = idx"
            :class="currentGalleryImageIndex === idx ? 'ring-2 ring-white opacity-100' : 'opacity-50 hover:opacity-80'"
            class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer">
            <img :src="img" class="w-full h-full object-cover" />
          </button>
        </div>
      </div>
    </transition>

    <!-- ============================================================ -->
    <!-- POTENSI DETAIL MODAL                                          -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="selectedPotensi"
        id="potensi-beranda-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="closePotensiDetail"
      >
        <div v-if="isPotensiFullscreen" class="relative w-full h-full flex items-center justify-center">
          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentPotensiImageIndex + 1 }} / {{ potensiImages.length }}
          </div>
          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button @click.stop="togglePotensiFullscreen" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button @click.stop="closePotensiDetail" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <XIcon class="w-5 h-5" />
            </button>
          </div>
          <img :src="activePotensiImage" :alt="selectedPotensi.nama" class="max-w-full max-h-full object-contain" />
          <template v-if="potensiImages.length > 1">
            <button @click.stop="prevPotensiImage" class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center cursor-pointer z-20">
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button @click.stop="nextPotensiImage" class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center cursor-pointer z-20">
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>
          <div v-if="potensiImages.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20">
            <button v-for="(img, idx) in potensiImages" :key="idx" @click.stop="currentPotensiImageIndex = idx"
              :class="currentPotensiImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer">
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>
        </div>

        <div v-else class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl flex flex-col">
          <div class="relative bg-gray-900 shrink-0">
            <div class="relative aspect-[16/10] overflow-hidden">
              <img :src="activePotensiImage" :alt="selectedPotensi.nama" class="w-full h-full object-cover" />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-60"></div>
              <button @click="closePotensiDetail" class="absolute top-4 right-4 z-20 w-10 h-10 rounded-full bg-black/55 hover:bg-black/80 text-white flex items-center justify-center cursor-pointer">
                <XIcon class="w-5 h-5" />
              </button>
              <template v-if="potensiImages.length > 1">
                <button @click.stop="prevPotensiImage" class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronLeftIcon class="w-5 h-5" />
                </button>
                <button @click.stop="nextPotensiImage" class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronRightIcon class="w-5 h-5" />
                </button>
              </template>
              <span v-if="potensiImages.length > 1" class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10">
                {{ currentPotensiImageIndex + 1 }} / {{ potensiImages.length }}
              </span>
              <button @click.stop="togglePotensiFullscreen" class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full cursor-pointer z-10" title="Fullscreen">
                <MaximizeIcon class="w-4 h-4" />
              </button>
              <span class="absolute top-4 left-4 bg-[#0D6847] text-white text-[10px] font-bold uppercase tracking-wider px-3 py-1 rounded-full z-10">
                {{ selectedPotensi.kategori === 'wisata' ? 'Wisata' : 'Potensi Desa' }}
              </span>
            </div>
            <div v-if="potensiImages.length > 1" class="flex items-center gap-2 p-3 bg-black/30 overflow-x-auto">
              <button v-for="(img, idx) in potensiImages" :key="idx" @click="currentPotensiImageIndex = idx"
                :class="currentPotensiImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
                class="relative w-16 h-12 shrink-0 rounded-lg overflow-hidden transition-all cursor-pointer">
                <img :src="img" class="w-full h-full object-cover" />
              </button>
            </div>
          </div>

          <div class="p-6 md:p-8 space-y-5">
            <h3 class="text-2xl font-extrabold text-[#0F2D3F] leading-snug">{{ selectedPotensi.nama }}</h3>
            <p class="text-sm md:text-base text-gray-600 leading-relaxed whitespace-pre-line">{{ selectedPotensi.deskripsi }}</p>

            <div v-if="selectedPotensi.lokasi && selectedPotensi.lokasi !== '-'" class="space-y-3 pt-2 border-t border-gray-100">
              <a :href="selectedPotensi.lokasi" target="_blank" class="inline-flex items-center gap-2 px-4 py-2.5 bg-emerald-50 hover:bg-[#0D6847] text-[#0D6847] hover:text-white text-xs font-bold rounded-xl transition-colors">
                <MapPinIcon class="w-4 h-4" />
                <span>Buka di Google Maps</span>
              </a>
              <div class="rounded-xl overflow-hidden border border-gray-200 h-56">
                <iframe :src="getOSMEmbedUrl(selectedPotensi.lokasi)" width="100%" height="224" style="border:0" loading="lazy"></iframe>
              </div>
            </div>

            <div class="pt-4 flex justify-end">
              <button @click="closePotensiDetail" class="px-6 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-800 text-xs font-bold rounded-xl cursor-pointer">
                Tutup
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- ============================================================ -->
    <!-- UMKM DETAIL MODAL (sama seperti halaman Produk)               -->
    <!-- ============================================================ -->
    <transition name="fade">
      <div
        v-if="selectedProduct"
        id="product-beranda-lightbox"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90 backdrop-blur-xs"
        @click.self="closeProductDetail"
      >
        <!-- FULLSCREEN MODE -->
        <div v-if="isProductFullscreen" class="relative w-full h-full flex items-center justify-center">
          <div class="absolute top-4 left-4 z-30 text-white text-sm font-bold">
            {{ currentProductImageIndex + 1 }} / {{ productImages.length }}
          </div>
          <div class="absolute top-4 right-4 z-30 flex items-center gap-2">
            <button @click.stop="toggleProductFullscreen" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <MinimizeIcon class="w-5 h-5" />
            </button>
            <button @click.stop="closeProductDetail" class="w-10 h-10 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center cursor-pointer">
              <XIcon class="w-5 h-5" />
            </button>
          </div>
          <img :src="activeProductImage" :alt="selectedProduct.name" class="max-w-full max-h-full object-contain" />
          <template v-if="productImages.length > 1">
            <button @click.stop="prevProductImage" class="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center cursor-pointer z-20">
              <ChevronLeftIcon class="w-6 h-6" />
            </button>
            <button @click.stop="nextProductImage" class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black/50 hover:bg-black/70 text-white rounded-full flex items-center justify-center cursor-pointer z-20">
              <ChevronRightIcon class="w-6 h-6" />
            </button>
          </template>
          <div v-if="productImages.length > 1" class="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 p-2 bg-black/60 rounded-2xl backdrop-blur-md max-w-[90vw] overflow-x-auto z-20">
            <button v-for="(img, idx) in productImages" :key="idx" @click.stop="currentProductImageIndex = idx"
              :class="currentProductImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
              class="relative w-14 h-10 shrink-0 rounded-md overflow-hidden transition-all cursor-pointer">
              <img :src="img" class="w-full h-full object-cover" />
            </button>
          </div>
        </div>

        <!-- NORMAL MODE -->
        <div v-else class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl flex flex-col">

          <!-- Foto -->
          <div class="relative bg-gray-900 shrink-0">
            <div class="relative aspect-[16/10] overflow-hidden">
              <img :src="activeProductImage" :alt="selectedProduct.name" class="w-full h-full object-cover" @error="handleImageError($event, 'product')" />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-transparent to-transparent opacity-60"></div>

              <button @click="closeProductDetail" class="absolute top-4 right-4 z-20 w-9 h-9 rounded-full bg-black/55 hover:bg-black/75 text-white flex items-center justify-center cursor-pointer">
                <XIcon class="w-5 h-5" />
              </button>

              <template v-if="productImages.length > 1">
                <button @click.stop="prevProductImage" class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronLeftIcon class="w-5 h-5" />
                </button>
                <button @click.stop="nextProductImage" class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 bg-black/50 hover:bg-black/75 text-white rounded-full flex items-center justify-center z-10 cursor-pointer">
                  <ChevronRightIcon class="w-5 h-5" />
                </button>
              </template>

              <!-- Counter kiri bawah -->
              <span v-if="productImages.length > 1" class="absolute bottom-4 left-4 bg-black/60 text-white text-[10px] font-bold px-2.5 py-1 rounded-full z-10">
                {{ currentProductImageIndex + 1 }} / {{ productImages.length }}
              </span>

              <!-- Fullscreen kanan bawah -->
              <button @click.stop="toggleProductFullscreen" class="absolute bottom-4 right-4 p-2 bg-black/60 hover:bg-black/80 text-white rounded-full transition-colors cursor-pointer z-10" title="Tampilkan Fullscreen">
                <MaximizeIcon class="w-4 h-4" />
              </button>

              <!-- Badge Kategori (hijau gelap) -->
              <span class="absolute top-4 left-4 bg-[#0A4A34] text-white text-[11px] font-extrabold uppercase tracking-widest px-4 py-1.5 rounded-full shadow-md shadow-emerald-900/20 z-10">
                {{ selectedProduct.kategori }}
              </span>
            </div>

            <div v-if="productImages.length > 1" class="flex items-center gap-2 p-3 bg-black/30 overflow-x-auto">
              <button v-for="(img, idx) in productImages" :key="idx" @click="currentProductImageIndex = idx"
                :class="currentProductImageIndex === idx ? 'ring-2 ring-[#0D6847] opacity-100' : 'opacity-50 hover:opacity-80'"
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
                {{ selectedProduct.description || 'Tidak ada deskripsi.' }}
              </p>
            </div>

            <!-- Produk -->
            <div v-if="selectedProduct.daftar_produk">
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

            <!-- Jam Buka -->
            <div v-if="selectedProduct.jam_buka">
              <h4 class="text-base font-extrabold text-[#0A4A34] mb-3 flex items-center gap-2 border-l-4 border-[#0A4A34] pl-3">
                Jam Buka
              </h4>
              <p class="text-sm text-gray-700">{{ selectedProduct.jam_buka }}</p>
            </div>

            <!-- Cara Pesan & Pembayaran -->
            <div v-if="selectedProduct.cara_bayar">
              <h4 class="text-base font-extrabold text-[#0A4A34] mb-3 flex items-center gap-2 border-l-4 border-[#0A4A34] pl-3">
                Cara Pesan &amp; Pembayaran
              </h4>
              <p class="text-sm text-gray-700 mb-2">Hubungi melalui WhatsApp</p>
              <p class="text-sm text-gray-700">Menerima pembayaran {{ selectedProduct.cara_bayar }}.</p>
            </div>

            <!-- Lokasi -->
            <div v-if="selectedProduct.alamat_lokasi || selectedProduct.maps_lokasi" class="border border-gray-200 rounded-2xl p-4">
              <div class="flex items-start gap-3">
                <div class="w-6 h-6 rounded-full bg-emerald-50 text-[#0D6847] flex items-center justify-center shrink-0 mt-0.5">
                  <MapPinIcon class="w-3.5 h-3.5" />
                </div>
                <div class="flex-1">
                  <h5 class="text-sm font-extrabold text-gray-900 mb-1">Lokasi</h5>
                  <p class="text-xs text-gray-500 mb-1">{{ selectedProduct.alamat_lokasi || '-' }}</p>
                  <a v-if="selectedProduct.maps_lokasi" :href="selectedProduct.maps_lokasi" target="_blank" class="text-xs font-bold text-[#1B8A9C] hover:underline inline-flex items-center gap-1">
                    <span>Buka di Google Maps</span>
                    <ArrowRightIcon class="w-3 h-3" />
                  </a>
                </div>
              </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex items-center gap-3 pt-2">
              <a :href="getWhatsAppUrl(selectedProduct)" target="_blank" class="flex-1 flex items-center justify-center gap-2 px-6 py-3.5 bg-[#1F7A3F] hover:bg-[#186030] text-white text-xs sm:text-sm font-bold rounded-xl shadow-md transition-all cursor-pointer">
                <MessageCircleIcon class="w-4 h-4" />
                <span>Hubungi via WhatsApp</span>
              </a>
              <button @click="shareProduct(selectedProduct)" class="p-3.5 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-xl transition-colors cursor-pointer" title="Bagikan">
                <Share2Icon class="w-5 h-5" />
              </button>
            </div>

            <div class="pt-4 border-t border-gray-100 flex justify-end">
              <button @click="closeProductDetail" class="px-6 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-800 text-xs font-bold rounded-xl cursor-pointer">
                Tutup
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!-- TOAST -->
    <transition name="fade">
      <div v-if="triggerToast" class="fixed bottom-6 right-6 z-[60] bg-gray-900 text-white px-5 py-3.5 rounded-2xl shadow-2xl flex items-center gap-3">
        <CheckCircle2Icon class="w-5 h-5 text-emerald-400 shrink-0" />
        <span class="text-xs font-semibold">{{ triggerToast }}</span>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import {
  ArrowRight as ArrowRightIcon,
  Users as UsersIcon,
  ShoppingBag as ShoppingBagIcon,
  MapPin as MapPinIcon,
  Calendar as CalendarIcon,
  ChevronRight as ChevronRightIcon,
  ChevronLeft as ChevronLeftIcon,
  Sparkles as SparklesIcon,
  Heart as HeartIcon,
  ShoppingCart as ShoppingCartIcon,
  MessageCircle as MessageCircleIcon,
  Compass as CompassIcon,
  Map as MapIcon,
  Play as PlayIcon,
  X as XIcon,
  User as UserIcon,
  Home as HomeIcon,
  Instagram as InstagramIcon,
  Maximize as MaximizeIcon,
  Minimize as MinimizeIcon,
  Store as StoreIcon,
  Star as StarIcon,
  Share2 as Share2Icon,
  CheckCircle2 as CheckCircle2Icon
} from 'lucide-vue-next';

import { store } from '../store';

defineEmits(['navigate']);

// ============================================
// HERO VIDEO BACKGROUND
// ============================================
const videoFailed = ref(false);

const heroPoster = computed(() => {
  // Pakai thumbnail YouTube kalau ada, kalau tidak pakai gambar hero statis
  const p = store.padukuhanProfile;
  if (p?.video_url) {
    const thumb = getYouTubeThumbnail(p.video_url);
    if (thumb) return thumb;
  }
  return '/images/hero-bg.png';
});

const handleVideoError = () => {
  console.warn('[Hero] Video gagal dimuat, fallback ke gambar.');
  videoFailed.value = true;
};

// ============================================
// CAROUSEL BERITA — auto-slide @5 detik
// ============================================
const carouselIndex = ref(0);
let carouselTimer = null;

const newsSlides = computed(() => {
  const news = store.news.slice(0, 9);
  const slides = [];
  for (let i = 0; i < news.length; i += 3) {
    slides.push(news.slice(i, i + 3));
  }
  return slides;
});

const nextSlide = () => {
  if (newsSlides.value.length === 0) return;
  carouselIndex.value = (carouselIndex.value + 1) % newsSlides.value.length;
};

const prevSlide = () => {
  if (newsSlides.value.length === 0) return;
  carouselIndex.value = (carouselIndex.value - 1 + newsSlides.value.length) % newsSlides.value.length;
};

// ============================================
// GALERI SLIDES — auto-slide @5 detik
// ============================================
const gallerySlideIndex = ref(0);
let galleryTimer = null;

const gallerySlides = computed(() => {
  const fotos = store.gallery.filter(g => g.type !== 'video');
  const slides = [];
  for (let i = 0; i < fotos.length; i += 5) {
    slides.push(fotos.slice(i, i + 5));
  }
  return slides;
});

const currentGallerySlide = computed(() => {
  if (gallerySlides.value.length === 0) return [];
  return gallerySlides.value[gallerySlideIndex.value] || [];
});

const galleryBig = computed(() => currentGallerySlide.value[0] || null);
const gallerySmall = computed(() => currentGallerySlide.value.slice(1, 5));

const nextGallerySlide = () => {
  if (gallerySlides.value.length === 0) return;
  gallerySlideIndex.value = (gallerySlideIndex.value + 1) % gallerySlides.value.length;
};

const prevGallerySlide = () => {
  if (gallerySlides.value.length === 0) return;
  gallerySlideIndex.value = (gallerySlideIndex.value - 1 + gallerySlides.value.length) % gallerySlides.value.length;
};

// ============================================
// FULLSCREEN STATE — gabungan semua modal
// ============================================
const isNewsFullscreen = ref(false);
const isPotensiFullscreen = ref(false);
const isProductFullscreen = ref(false);

const syncFullscreenStates = () => {
  const isFs = !!document.fullscreenElement;
  isNewsFullscreen.value = isFs;
  isPotensiFullscreen.value = isFs;
  isProductFullscreen.value = isFs;
};

// ============================================
// NEWS DETAIL MODAL
// ============================================
const selectedNews = ref(null);
const currentNewsImageIndex = ref(0);

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

const activeNewsImage = computed(() => newsImages.value[currentNewsImageIndex.value] || '/images/hero-bg.png');

const openNewsDetail = (item) => {
  selectedNews.value = item;
  currentNewsImageIndex.value = 0;
  isNewsFullscreen.value = false;
};

const closeNewsDetail = async () => {
  if (document.fullscreenElement) {
    try { await document.exitFullscreen(); } catch (e) {}
  }
  isNewsFullscreen.value = false;
  selectedNews.value = null;
};

const prevNewsImage = () => {
  if (currentNewsImageIndex.value > 0) currentNewsImageIndex.value--;
  else currentNewsImageIndex.value = newsImages.value.length - 1;
};

const nextNewsImage = () => {
  if (currentNewsImageIndex.value < newsImages.value.length - 1) currentNewsImageIndex.value++;
  else currentNewsImageIndex.value = 0;
};

const toggleNewsFullscreen = async () => {
  const el = document.getElementById('news-lightbox');
  if (!el) return;
  try {
    if (!document.fullscreenElement) {
      await el.requestFullscreen();
      isNewsFullscreen.value = true;
    } else {
      await document.exitFullscreen();
      isNewsFullscreen.value = false;
    }
  } catch (err) { console.warn(err); }
};

// ============================================
// GALLERY DETAIL MODAL
// ============================================
const selectedGallery = ref(null);
const currentGalleryImageIndex = ref(0);

const galleryImages = computed(() => {
  if (!selectedGallery.value) return [];
  const list = [];
  if (selectedGallery.value.image) list.push(selectedGallery.value.image);
  if (Array.isArray(selectedGallery.value.images)) {
    selectedGallery.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

const activeGalleryImage = computed(() => galleryImages.value[currentGalleryImageIndex.value] || '/images/hero-bg.png');

const openGalleryDetail = (item) => {
  selectedGallery.value = item;
  currentGalleryImageIndex.value = 0;
};

const prevGalleryImage = () => {
  if (currentGalleryImageIndex.value > 0) currentGalleryImageIndex.value--;
  else currentGalleryImageIndex.value = galleryImages.value.length - 1;
};

const nextGalleryImage = () => {
  if (currentGalleryImageIndex.value < galleryImages.value.length - 1) currentGalleryImageIndex.value++;
  else currentGalleryImageIndex.value = 0;
};

// ============================================
// POTENSI DETAIL MODAL
// ============================================
const selectedPotensi = ref(null);
const currentPotensiImageIndex = ref(0);

const potensiImages = computed(() => {
  if (!selectedPotensi.value) return [];
  const list = [];
  if (selectedPotensi.value.foto_url) list.push(selectedPotensi.value.foto_url);
  if (Array.isArray(selectedPotensi.value.images)) {
    selectedPotensi.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

const activePotensiImage = computed(() => potensiImages.value[currentPotensiImageIndex.value] || '/images/hero-bg.png');

const openPotensiDetail = (item) => {
  selectedPotensi.value = item;
  currentPotensiImageIndex.value = 0;
  isPotensiFullscreen.value = false;
};

const closePotensiDetail = async () => {
  if (document.fullscreenElement) {
    try { await document.exitFullscreen(); } catch (e) {}
  }
  isPotensiFullscreen.value = false;
  selectedPotensi.value = null;
};

const prevPotensiImage = () => {
  if (currentPotensiImageIndex.value > 0) currentPotensiImageIndex.value--;
  else currentPotensiImageIndex.value = potensiImages.value.length - 1;
};

const nextPotensiImage = () => {
  if (currentPotensiImageIndex.value < potensiImages.value.length - 1) currentPotensiImageIndex.value++;
  else currentPotensiImageIndex.value = 0;
};

const togglePotensiFullscreen = async () => {
  const el = document.getElementById('potensi-beranda-lightbox');
  if (!el) return;
  try {
    if (!document.fullscreenElement) {
      await el.requestFullscreen();
      isPotensiFullscreen.value = true;
    } else {
      await document.exitFullscreen();
      isPotensiFullscreen.value = false;
    }
  } catch (err) { console.warn(err); }
};

// ============================================
// PRODUK DETAIL MODAL
// ============================================
const selectedProduct = ref(null);
const currentProductImageIndex = ref(0);

const productImages = computed(() => {
  if (!selectedProduct.value) return [];
  const list = [];
  if (selectedProduct.value.image) list.push(selectedProduct.value.image);
  if (Array.isArray(selectedProduct.value.images)) {
    selectedProduct.value.images.forEach(img => {
      if (img && !list.includes(img)) list.push(img);
    });
  }
  return list.length > 0 ? list : ['/images/hero-bg.png'];
});

// Daftar produk UMKM (dipisah per baris)
const produkList = computed(() => {
  if (!selectedProduct.value?.daftar_produk) return [];
  return selectedProduct.value.daftar_produk
    .split('\n')
    .map(s => s.trim())
    .filter(Boolean);
});

const activeProductImage = computed(() => productImages.value[currentProductImageIndex.value] || '/images/hero-bg.png');

const openProductDetail = (item) => {
  selectedProduct.value = item;
  currentProductImageIndex.value = 0;
  isProductFullscreen.value = false;
};

const closeProductDetail = async () => {
  if (document.fullscreenElement) {
    try { await document.exitFullscreen(); } catch (e) {}
  }
  isProductFullscreen.value = false;
  selectedProduct.value = null;
};

const prevProductImage = () => {
  if (currentProductImageIndex.value > 0) currentProductImageIndex.value--;
  else currentProductImageIndex.value = productImages.value.length - 1;
};

const nextProductImage = () => {
  if (currentProductImageIndex.value < productImages.value.length - 1) currentProductImageIndex.value++;
  else currentProductImageIndex.value = 0;
};

const toggleProductFullscreen = async () => {
  const el = document.getElementById('product-beranda-lightbox');
  if (!el) return;
  try {
    if (!document.fullscreenElement) {
      await el.requestFullscreen();
      isProductFullscreen.value = true;
    } else {
      await document.exitFullscreen();
      isProductFullscreen.value = false;
    }
  } catch (err) { console.warn(err); }
};

// ============================================
// HIGHLIGHT VIDEO (dari Profil Padukuhan)
// ============================================
const highlights = [
  'Cita-Cita pembangunan Padukuhan masa depan',
  'Keharmonisan dan kerukunan warga lintas generasi',
  'Highlight produk unggulan UMKM & pengrajin',
  'Pesona alam, persawahan, dan agrowisata'
];

const highlightVideo = computed(() => {
  const p = store.padukuhanProfile;
  if (!p?.video_url) return null;

  return {
    url: p.video_url,
    embedUrl: getYouTubeEmbedUrl(p.video_url),        // ← TAMBAH
    thumbnail: getYouTubeThumbnail(p.video_url)        // ← TAMBAH: auto-thumbnail
      || p.video_thumbnail
      || '/images/hero-bg.png',
    title: `Profil ${p.nama_padukuhan || 'Padukuhan'}`,
    isYouTube: isYouTubeUrl(p.video_url)               // ← TAMBAH flag
  };
});

const highlightVideoTitle = computed(() => {
  return highlightVideo.value?.title || 'Profil Padukuhan';
});

const showVideoModal = ref(false);

const openHighlightVideo = () => {
  if (!highlightVideo.value) return;
  // Selalu buka modal — biar iframe embed muncul di dalam
  showVideoModal.value = true;
};

// ============================================
// HELPERS
// ============================================
const getWhatsAppUrl = (item) => {
  const phone = (item.nomor_whatsapp || item.sellerPhone || '').replace(/[^0-9]/g, '') || '6281234567890';
  const text = encodeURIComponent(`Halo, saya tertarik dengan UMKM "${item.name}".`);
  return `https://wa.me/${phone}?text=${text}`;
};

// ============================================
// YOUTUBE HELPER
// ============================================
const getYouTubeEmbedUrl = (url) => {
  if (!url) return '';
  const patterns = [
    /(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/shorts\/)([a-zA-Z0-9_-]{11})/,
  ];
  for (const pattern of patterns) {
    const match = url.match(pattern);
    if (match && match[1]) {
      return `https://www.youtube.com/embed/${match[1]}?autoplay=1&rel=0`;
    }
  }
  return '';
};

const getYouTubeThumbnail = (url) => {
  if (!url) return '';
  const match = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/shorts\/)([a-zA-Z0-9_-]{11})/);
  if (match && match[1]) {
    return `https://img.youtube.com/vi/${match[1]}/maxresdefault.jpg`;
  }
  return '';
};

const isYouTubeUrl = (url) => /(?:youtube\.com|youtu\.be)/i.test(url || '');

const formatRupiah = (val) => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency', currency: 'IDR', maximumFractionDigits: 0
  }).format(val || 0);
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
    const d = 0.005;
    return `https://www.openstreetmap.org/export/embed.html?bbox=${lon - d},${lat - d},${lon + d},${lat + d}&layer=mapnik&marker=${lat},${lon}`;
  }
  return 'https://www.openstreetmap.org/export/embed.html?layer=mapnik';
};

const handleImageError = (event, type) => {
  const fallbacks = {
    'hero-bg': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',
    'anyaman-bambu': 'https://images.unsplash.com/photo-1595475244128-90a36b67241a?auto=format&fit=crop&w=600&q=80',
    'potensi': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=800&q=80',
    'product': 'https://images.unsplash.com/photo-1595475244128-90a36b67241a?auto=format&fit=crop&w=600&q=80',
    'galeri-1': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=800&q=80'
  };
  event.target.src = fallbacks[type] || 'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=600';
};

const triggerToast = ref('');
const shareProduct = (item) => {
  navigator.clipboard.writeText(window.location.href);
  triggerToast.value = `Tautan UMKM "${item.name}" berhasil disalin!`;
  setTimeout(() => { triggerToast.value = ''; }, 3500);
};

// ============================================
// LIFECYCLE
// ============================================
onMounted(() => {
  document.addEventListener('fullscreenchange', syncFullscreenStates);

  // Timer carousel berita
  carouselTimer = setInterval(() => {
    if (newsSlides.value.length > 1) nextSlide();
  }, 5000);

  // Timer galeri slide
  galleryTimer = setInterval(() => {
    if (gallerySlides.value.length > 1) nextGallerySlide();
  }, 5000);
});

onUnmounted(() => {
  document.removeEventListener('fullscreenchange', syncFullscreenStates);
  if (carouselTimer) clearInterval(carouselTimer);
  if (galleryTimer) clearInterval(galleryTimer);
});
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

.gallery-fade-enter-active,
.gallery-fade-leave-active {
  transition: opacity 0.4s ease, transform 0.4s ease;
}
.gallery-fade-enter-from {
  opacity: 0;
  transform: translateX(20px);
}
.gallery-fade-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}
</style>
