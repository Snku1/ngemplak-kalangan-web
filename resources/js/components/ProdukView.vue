<template>
  <div class="bg-[#F8FAFC]">
    <!-- HERO SECTION -->
    <section class="relative bg-gradient-to-b from-[#0B5439] via-[#0D6847] to-[#09472F] text-white py-16 md:py-24 overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#fff_1px,transparent_1px)] [background-size:24px_24px] pointer-events-none"></div>

      <div class="absolute -right-16 -top-16 opacity-15 pointer-events-none hidden lg:block">
        <svg width="480" height="480" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="0.8">
          <path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/>
          <path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/>
        </svg>
      </div>

      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div class="max-w-3xl">

          <h1 class="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight leading-tight mb-5">
            UMKM Unggulan <br class="hidden sm:inline" />
            <span class="text-emerald-200">Padukuhan Ngemplak Kalangan</span>
          </h1>

          <p class="text-sm md:text-base text-emerald-100/90 leading-relaxed mb-8 max-w-2xl">
            Dukung pertumbuhan ekonomi lokal dengan memborong produk-produk terbaik karya warga Padukuhan. Mulai dari kerajinan tangan tradisional hingga hasil bumi organik berkualitas tinggi.
          </p>

        </div>
      </div>
    </section>

    <!-- KATALOG PRODUK MAIN SECTION -->
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
              <p class="text-xs text-gray-500 font-medium">Menampilkan {{ filteredProducts.length }} produk UMKM unggulan warga</p>
            </div>
          </div>

          <div class="flex flex-wrap items-center gap-3">
            <div class="relative min-w-[240px] sm:min-w-[280px] flex-1 sm:flex-initial">
              <SearchIcon class="w-4 h-4 text-gray-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
              <input
                v-model="searchQuery"
                type="text"
                placeholder="Cari produk desa atau penjual..."
                class="w-full pl-10 pr-4 py-2.5 bg-white border border-gray-200 rounded-xl text-xs sm:text-sm text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:ring-2 focus:ring-[#0D6847]/20 transition-all shadow-sm"
              />
              <button
                v-if="searchQuery"
                @click="searchQuery = ''"
                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
              >
                <XIcon class="w-3.5 h-3.5" />
              </button>
            </div>

            <div class="relative">
              <select
                v-model="sortBy"
                class="appearance-none bg-white border border-gray-200 rounded-xl px-4 py-2.5 pr-8 text-xs font-semibold text-gray-700 hover:border-gray-300 focus:outline-none focus:border-[#0D6847] cursor-pointer shadow-sm"
              >
                <option value="terpopuler">Terpopuler</option>
                <option value="rating">Rating Tertinggi</option>
                <option value="termurah">Harga: Terendah</option>
                <option value="termahal">Harga: Tertinggi</option>
              </select>
              <ChevronDownIcon class="w-4 h-4 text-gray-400 absolute right-2.5 top-1/2 -translate-y-1/2 pointer-events-none" />
            </div>
          </div>
        </div>

        <!-- Filter Category Tabs (dari master_kategori) -->
        <div class="flex items-center gap-2 overflow-x-auto pb-4 scrollbar-none mb-8">
          <button
            v-for="cat in categories"
            :key="cat.id"
            @click="activeCategory = cat.id"
            :class="[
              activeCategory === cat.id
                ? 'bg-[#0D6847] text-white shadow-md shadow-[#0D6847]/20'
                : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-50 hover:text-gray-900'
            ]"
            class="px-5 py-2.5 rounded-xl text-xs font-semibold whitespace-nowrap transition-all duration-200 active:scale-95 cursor-pointer flex items-center gap-2"
          >
            <span>{{ cat.name }}</span>
            <span
              :class="activeCategory === cat.id ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-500'"
              class="px-1.5 py-0.5 rounded-md text-[10px] font-bold"
            >
              {{ getCategoryCount(cat.id) }}
            </span>
          </button>
        </div>

        <!-- PRODUCT CARDS GRID -->
        <div v-if="filteredProducts.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8">
          <div
            v-for="product in filteredProducts"
            :key="product.id"
            class="bg-white rounded-2xl border border-gray-150 overflow-hidden shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 flex flex-col group"
          >
            <div class="relative aspect-[4/3] bg-gray-100 overflow-hidden cursor-pointer" @click="openDetailModal(product)">
              <img
                :src="product.image"
                :alt="product.name"
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageFallback($event)"
              />

              <span class="absolute top-3.5 left-3.5 px-3 py-1 bg-[#0D6847]/90 backdrop-blur-md text-white text-[11px] font-semibold rounded-lg shadow-sm">
                {{ product.category }}
              </span>

              <div class="absolute top-3.5 right-3.5 px-2.5 py-1 bg-white/90 backdrop-blur-md rounded-lg shadow-sm flex items-center gap-1 text-xs font-bold text-gray-800">
                <StarIcon class="w-3.5 h-3.5 fill-amber-400 text-amber-400" />
                <span>{{ product.rating }}</span>
              </div>

              <!-- Best Seller Badge -->
              <div v-if="product.isBestSeller" class="absolute bottom-3.5 left-3.5 px-2.5 py-1 bg-amber-500 text-white text-[10px] font-bold uppercase rounded-lg shadow-sm">
                Terlaris
              </div>
            </div>

            <div class="p-5 flex-1 flex flex-col justify-between space-y-4">
              <div>
                <div class="flex items-start justify-between gap-2 mb-1.5">
                  <h3
                    @click="openDetailModal(product)"
                    class="text-base font-bold text-gray-900 group-hover:text-[#0D6847] transition-colors cursor-pointer line-clamp-1"
                  >
                    {{ product.name }}
                  </h3>
                </div>

                <p class="text-lg font-extrabold text-[#D97706] mb-2">
                  {{ formatRupiah(product.price) }}
                  <span class="text-xs font-normal text-gray-400" v-if="product.unit"> / {{ product.unit }}</span>
                </p>

                <p class="text-xs text-gray-600 line-clamp-2 leading-relaxed mb-4">
                  {{ product.description }}
                </p>

                <div class="bg-gray-50 rounded-xl p-3 border border-gray-100 flex items-center gap-3">
                  <div class="w-8 h-8 rounded-lg bg-white border border-gray-200 flex items-center justify-center text-[#0D6847] shrink-0 font-bold text-xs shadow-2xs">
                    <StoreIcon class="w-4 h-4" />
                  </div>
                  <div class="min-w-0 flex-1">
                    <p class="text-[10px] text-gray-400 font-bold uppercase tracking-wider">Penyedia</p>
                    <p class="text-xs font-bold text-gray-800 truncate">{{ product.seller }}</p>
                  </div>
                  <span v-if="product.sellerMaps" class="text-[#0D6847]" title="Lokasi tersedia">
                    <MapPinIcon class="w-4 h-4" />
                  </span>
                </div>
              </div>

              <div class="pt-2 space-y-2">
                <a
                  :href="getWhatsAppUrl(product)"
                  target="_blank"
                  class="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-[#25D366] hover:bg-[#1EBE5A] text-white text-xs font-bold rounded-xl shadow-sm transition-all duration-200 active:scale-95 cursor-pointer"
                >
                  <MessageSquareIcon class="w-4 h-4" />
                  <span>Hubungi via WhatsApp</span>
                </a>

                <button
                  @click="openDetailModal(product)"
                  class="w-full text-center text-xs font-bold text-gray-500 hover:text-[#0D6847] py-1 transition-colors flex items-center justify-center gap-1 cursor-pointer"
                >
                  <span>Lihat Detail Produk</span>
                  <ChevronDownIcon class="w-3.5 h-3.5 -rotate-90 group-hover:translate-x-0.5 transition-transform" />
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Empty State -->
        <div v-else class="bg-white rounded-2xl border border-gray-200 p-12 text-center max-w-lg mx-auto my-8">
          <div class="w-16 h-16 rounded-full bg-gray-100 text-gray-400 flex items-center justify-center mx-auto mb-4">
            <SearchIcon class="w-8 h-8" />
          </div>
          <h3 class="text-lg font-bold text-gray-800 mb-1">Produk Tidak Ditemukan</h3>
          <p class="text-xs text-gray-500 mb-6">Tidak ada produk yang sesuai dengan pencarian atau filter yang Anda pilih.</p>
          <button
            @click="resetFilters"
            class="px-5 py-2.5 bg-[#0D6847] text-white text-xs font-bold rounded-xl hover:bg-[#0A5238] transition-colors"
          >
            Reset Filter &amp; Pencarian
          </button>
        </div>

      </div>
    </section>

    <!-- CTA BANNER -->
    <section class="py-6 mb-12">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="relative bg-emerald-50/80 border border-emerald-200/80 rounded-3xl p-8 sm:p-10 md:p-12 overflow-hidden shadow-sm">
          <div class="absolute -right-12 -bottom-12 w-64 h-64 bg-emerald-200/40 rounded-full blur-2xl pointer-events-none"></div>
          <div class="absolute right-24 top-0 w-32 h-32 bg-[#0D6847]/10 rounded-full blur-xl pointer-events-none"></div>

          <div class="relative z-10 flex flex-col lg:flex-row lg:items-center justify-between gap-8">
            <div class="max-w-2xl">
              <h2 class="text-2xl sm:text-3xl font-extrabold text-[#064E3B] tracking-tight mb-3">
                Punya Produk Padukuhan Berkualitas?
              </h2>
              <p class="text-xs sm:text-sm text-emerald-800/90 leading-relaxed">
                Mari bergabung dengan ratusan UMKM warga lainnya untuk memperluas jangkauan pasar dan meningkatkan penjualan produk lokal Padukuhan kita.
              </p>
            </div>

            <div class="flex flex-wrap items-center gap-3.5 shrink-0">
              <button
                @click="openRegisterModal"
                class="px-6 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-all duration-200 active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <PlusCircleIcon class="w-4 h-4" />
                <span>Daftar Jadi Penjual</span>
              </button>

              <button
                @click="showGuideToast"
                class="px-6 py-3.5 bg-white text-[#0D6847] border border-emerald-300 hover:bg-emerald-100/50 text-xs font-bold rounded-xl transition-all duration-200 active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <InfoIcon class="w-4 h-4" />
                <span>Petunjuk Pendaftaran</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- MENGAPA BERBELANJA -->
    <section class="py-16 bg-white border-t border-b border-gray-150">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center max-w-xl mx-auto mb-14">
          <h2 class="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight mb-3">
            Mengapa Berbelanja di Sini?
          </h2>
          <p class="text-xs sm:text-sm text-gray-500">
            Setiap transaksi Anda berdampak nyata dalam memajukan perekonomian warga desa kami.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="text-center p-6 rounded-2xl bg-gray-50/50 border border-gray-100 hover:bg-white hover:shadow-lg transition-all duration-300 group">
            <div class="w-14 h-14 rounded-2xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center mx-auto mb-5 group-hover:scale-110 transition-transform">
              <ShieldCheckIcon class="w-7 h-7" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">Kualitas Terjamin</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Semua produk disortir dan diproduksi langsung oleh warga padukuhan demi menjaga standar mutu terbaik.
            </p>
          </div>

          <div class="text-center p-6 rounded-2xl bg-gray-50/50 border border-gray-100 hover:bg-white hover:shadow-lg transition-all duration-300 group">
            <div class="w-14 h-14 rounded-2xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center mx-auto mb-5 group-hover:scale-110 transition-transform">
              <PhoneCallIcon class="w-7 h-7" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">Kontak Langsung</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Anda bertransaksi langsung dengan pembuat/petani lokal tanpa perantara, memperkuat ekonomi basis warga.
            </p>
          </div>

          <div class="text-center p-6 rounded-2xl bg-gray-50/50 border border-gray-100 hover:bg-white hover:shadow-lg transition-all duration-300 group">
            <div class="w-14 h-14 rounded-2xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center mx-auto mb-5 group-hover:scale-110 transition-transform">
              <HeartIcon class="w-7 h-7" />
            </div>
            <h3 class="text-base font-bold text-gray-900 mb-2">Dukungan Lokal</h3>
            <p class="text-xs text-gray-600 leading-relaxed">
              Setiap pembelian Anda memberikan dampak langsung bagi peningkatan kesejahteraan keluarga warga desa.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- BUTUH BANTUAN -->
    <section class="py-16 bg-[#F8FAFC]">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">

          <div class="lg:col-span-5 space-y-6">
            <div>
              <span class="text-xs font-bold text-[#0D6847] uppercase tracking-widest">Bantuan &amp; Informasi</span>
              <h2 class="text-3xl font-extrabold text-gray-900 tracking-tight mt-1 mb-4">Butuh Bantuan?</h2>
              <p class="text-xs sm:text-sm text-gray-600 leading-relaxed mb-6">
                Jika Anda memiliki pertanyaan mengenai produk, sistem pemesanan, atau ingin mendaftarkan usaha Anda, jangan ragu untuk menghubungi tim pengelola informasi kami.
              </p>
            </div>

            <div class="space-y-4">
              <div class="bg-white rounded-2xl p-4.5 border border-gray-200/80 shadow-xs flex items-center gap-4">
                <div class="w-11 h-11 rounded-xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center shrink-0">
                  <PhoneCallIcon class="w-5 h-5" />
                </div>
                <div>
                  <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Hotline Layanan UMKM</p>
                  <p class="text-sm font-extrabold text-gray-900">+62 812-3456-7890</p>
                </div>
              </div>

              <div class="bg-white rounded-2xl p-4.5 border border-gray-200/80 shadow-xs flex items-center gap-4">
                <div class="w-11 h-11 rounded-xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center shrink-0">
                  <MailIcon class="w-5 h-5" />
                </div>
                <div>
                  <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Email Resmi Pengelola</p>
                  <p class="text-sm font-extrabold text-gray-900">produk@ngempakkan.id</p>
                </div>
              </div>
            </div>
          </div>

          <div class="lg:col-span-7">
            <div class="bg-white rounded-3xl p-6 sm:p-8 border border-gray-200/90 shadow-lg">
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
                  <textarea v-model="contactForm.message" rows="4" required placeholder="Tuliskan pesan, pertanyaan, atau permohonan informasi Anda di sini..." class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all"></textarea>
                </div>

                <button type="submit" :disabled="isSubmittingForm" class="w-full py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-all duration-200 active:scale-98 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50">
                  <SendIcon v-if="!isSubmittingForm" class="w-4 h-4" />
                  <span v-if="isSubmittingForm">Mengirim Pesan...</span>
                  <span v-else>Kirim Pesan</span>
                </button>
              </form>
            </div>
          </div>

        </div>
      </div>
    </section>

    <!-- PRODUCT DETAIL MODAL -->
    <div v-if="selectedProduct" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-fade-in">
      <div class="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl border border-gray-100 relative">

        <button
          @click="selectedProduct = null"
          class="absolute top-4 right-4 z-10 w-9 h-9 rounded-full bg-black/40 hover:bg-black/60 text-white flex items-center justify-center transition-colors cursor-pointer"
        >
          <XIcon class="w-5 h-5" />
        </button>

        <!-- Modal Header Image -->
        <div class="relative aspect-[16/9] bg-gray-100">
          <img
            :src="selectedProduct.image"
            :alt="selectedProduct.name"
            class="w-full h-full object-cover"
            @error="handleImageFallback($event)"
          />
          <span class="absolute bottom-3 left-4 px-3 py-1 bg-[#0D6847] text-white text-xs font-bold rounded-lg shadow-sm">
            {{ selectedProduct.category }}
          </span>
        </div>

        <!-- Modal Content Body -->
        <div class="p-6 sm:p-8 space-y-6">
          <div class="flex items-start justify-between gap-4">
            <div>
              <h3 class="text-2xl font-extrabold text-gray-900">{{ selectedProduct.name }}</h3>
              <div class="flex items-center gap-2 mt-1">
                <div class="flex items-center text-amber-400 text-xs font-bold">
                  <StarIcon class="w-4 h-4 fill-amber-400 mr-1" />
                  <span>{{ selectedProduct.rating }}</span>
                </div>
                <span class="text-gray-300">•</span>
                <span class="text-xs text-gray-500 font-medium">Stok Tersedia</span>
              </div>
            </div>

            <p class="text-2xl font-black text-[#D97706]">
              {{ formatRupiah(selectedProduct.price) }}
            </p>
          </div>

          <!-- Description -->
          <div>
            <h4 class="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Deskripsi Produk</h4>
            <p class="text-xs sm:text-sm text-gray-700 leading-relaxed bg-gray-50 p-4 rounded-xl border border-gray-100 whitespace-pre-line">
              {{ selectedProduct.fullDescription || selectedProduct.description }}
            </p>
          </div>

          <!-- Seller Detail Card -->
          <div class="bg-emerald-50/60 rounded-2xl p-4 border border-emerald-100 flex items-center justify-between gap-4">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-xl bg-[#0D6847] text-white flex items-center justify-center font-bold text-sm">
                <StoreIcon class="w-5 h-5" />
              </div>
              <div>
                <p class="text-[10px] font-bold text-emerald-800/80 uppercase">Penjual / Pembuat</p>
                <p class="text-sm font-bold text-gray-900">{{ selectedProduct.seller }}</p>
                <p class="text-[11px] text-gray-500">Padukuhan Ngemplak Kalangan</p>
              </div>
            </div>

            <span class="px-3 py-1 bg-white text-[#0D6847] text-[11px] font-bold rounded-lg border border-emerald-200">
              Terverifikasi
            </span>
          </div>

          <!-- MAPS LOKASI PENJUAL (OSM) -->
          <div v-if="selectedProduct.sellerMaps" class="space-y-3">
            <div class="flex items-center justify-between">
              <h4 class="text-xs font-bold text-gray-400 uppercase tracking-wider flex items-center gap-1.5">
                <MapPinIcon class="w-3.5 h-3.5" />
                <span>Lokasi Penjual</span>
              </h4>
              <a
                :href="selectedProduct.sellerMaps"
                target="_blank"
                class="inline-flex items-center gap-1 px-2.5 py-1 bg-emerald-50 hover:bg-[#0D6847] text-[#0D6847] hover:text-white text-[10px] font-bold rounded-lg transition-colors"
              >
                <ExternalLinkIcon class="w-3 h-3" />
                <span>Buka di Google Maps</span>
              </a>
            </div>
          </div>

          <!-- Modal Action Buttons -->
          <div class="flex items-center gap-3 pt-2">
            <a
              :href="getWhatsAppUrl(selectedProduct)"
              target="_blank"
              class="flex-1 flex items-center justify-center gap-2 px-6 py-3.5 bg-[#25D366] hover:bg-[#1EBE5A] text-white text-xs sm:text-sm font-bold rounded-xl shadow-md transition-all cursor-pointer"
            >
              <MessageSquareIcon class="w-4.5 h-4.5" />
              <span>Pesan via WhatsApp</span>
            </a>

            <button
              @click="copyShareLink(selectedProduct)"
              class="p-3.5 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-xl transition-colors cursor-pointer"
              title="Bagikan Tautan Produk"
            >
              <Share2Icon class="w-5 h-5" />
            </button>
          </div>

        </div>
      </div>
    </div>

    <!-- SELLER REGISTRATION MODAL -->
    <div v-if="showRegisterModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div class="bg-white rounded-3xl max-w-lg w-full p-6 sm:p-8 shadow-2xl border border-gray-100 relative">
        <button
          @click="showRegisterModal = false"
          class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 p-1"
        >
          <XIcon class="w-5 h-5" />
        </button>

        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 rounded-xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center">
            <PlusCircleIcon class="w-6 h-6" />
          </div>
          <div>
            <h3 class="text-xl font-bold text-gray-900">Pendaftaran Penjual UMKM</h3>
            <p class="text-xs text-gray-500">Khusus warga Padukuhan Ngemplak Kalangan</p>
          </div>
        </div>

        <form @submit.prevent="submitVendorRegistration" class="space-y-4">
          <div>
            <label class="block text-xs font-bold text-gray-700 mb-1">Nama Pemilik / Usaha</label>
            <input v-model="vendorForm.name" type="text" required placeholder="Contoh: Ibu Suminah / Kerajinan Bambu" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#0D6847]" />
          </div>

          <div>
            <label class="block text-xs font-bold text-gray-700 mb-1">Kategori Produk</label>
            <select v-model="vendorForm.category" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#0D6847]">
              <option v-for="cat in store.categoriesByTipe('produk')" :key="cat.id" :value="cat.nama">{{ cat.nama }}</option>
            </select>
          </div>

          <div>
            <label class="block text-xs font-bold text-gray-700 mb-1">No. WhatsApp Aktif</label>
            <input v-model="vendorForm.phone" type="text" required placeholder="08xxxxxxxxxx" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#0D6847]" />
          </div>

          <div>
            <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi Singkat Produk</label>
            <textarea v-model="vendorForm.description" rows="3" required placeholder="Jelaskan produk unggulan yang ingin Anda tampilkan di katalog web desa..." class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#0D6847]"></textarea>
          </div>

          <button type="submit" class="w-full py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-colors cursor-pointer mt-2">
            Kirim Permohonan Pendaftaran
          </button>
        </form>
      </div>
    </div>

    <!-- TOAST -->
    <div
      v-if="toastMessage"
      class="fixed bottom-6 right-6 z-50 bg-gray-900 text-white px-5 py-3.5 rounded-2xl shadow-2xl border border-gray-800 flex items-center gap-3 animate-bounce-subtle"
    >
      <CheckCircle2Icon class="w-5 h-5 text-emerald-400 shrink-0" />
      <span class="text-xs font-semibold">{{ toastMessage }}</span>
    </div>

  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import {
  ShoppingBag as ShoppingBagIcon,
  Search as SearchIcon,
  X as XIcon,
  ChevronDown as ChevronDownIcon,
  Star as StarIcon,
  MessageSquare as MessageSquareIcon,
  Leaf as LeafIcon,
  ShieldCheck as ShieldCheckIcon,
  PhoneCall as PhoneCallIcon,
  Heart as HeartIcon,
  Mail as MailIcon,
  Send as SendIcon,
  CheckCircle2 as CheckCircle2Icon,
  Share2 as Share2Icon,
  Store as StoreIcon,
  Info as InfoIcon,
  PlusCircle as PlusCircleIcon,
  MapPin as MapPinIcon,
  ExternalLink as ExternalLinkIcon
} from 'lucide-vue-next';

import { store } from '../store';

// ============================================
// KATEGORI DARI MASTER_KATEGORI
// ============================================
const categories = computed(() => {
  const cats = store.categoriesByTipe('produk').map(c => ({
    id: c.nama, name: c.nama
  }));
  return [
    { id: 'semua', name: 'Semua' },
    ...cats,
    { id: 'terlaris', name: 'Terlaris' }
  ];
});

const activeCategory = ref('semua');
const searchQuery = ref('');
const sortBy = ref('terpopuler');

// States
const selectedProduct = ref(null);
const showRegisterModal = ref(false);
const toastMessage = ref('');
const isSubmittingForm = ref(false);

const contactForm = ref({
  name: '',
  phone: '',
  email: '',
  message: ''
});

const vendorForm = ref({
  name: '',
  category: '',
  phone: '',
  description: ''
});

// Category count
const getCategoryCount = (catId) => {
  if (catId === 'semua') return store.products.length;
  if (catId === 'terlaris') return store.products.filter(p => p.isBestSeller).length;
  return store.products.filter(p => p.category === catId).length;
};

// Filtered Products
const filteredProducts = computed(() => {
  return store.products.filter(product => {
    if (activeCategory.value === 'terlaris' && !product.isBestSeller) return false;
    if (activeCategory.value !== 'semua' && activeCategory.value !== 'terlaris' && product.category !== activeCategory.value) {
      return false;
    }

    if (searchQuery.value.trim() !== '') {
      const q = searchQuery.value.toLowerCase();
      const matchName = product.name.toLowerCase().includes(q);
      const matchSeller = (product.seller || '').toLowerCase().includes(q);
      const matchCategory = (product.category || '').toLowerCase().includes(q);
      const matchDesc = (product.description || '').toLowerCase().includes(q);
      if (!matchName && !matchSeller && !matchCategory && !matchDesc) return false;
    }

    return true;
  }).sort((a, b) => {
    if (sortBy.value === 'rating') return (b.rating || 5) - (a.rating || 5);
    if (sortBy.value === 'termurah') return a.price - b.price;
    if (sortBy.value === 'termahal') return b.price - a.price;
    return a.id - b.id;
  });
});

// Formatters
const formatRupiah = (val) => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0
  }).format(val || 0);
};

// WhatsApp URL
const getWhatsAppUrl = (product) => {
  const phone = product.sellerPhone
    ? product.sellerPhone.replace(/[^0-9]/g, '')
    : '6281234567890';
  const text = encodeURIComponent(
    `Halo, saya berminat untuk memesan produk "${product.name}" (${formatRupiah(product.price)}) yang ada di Website Padukuhan Ngemplak Kalangan. Mohon informasi pemesanan & ketersediaannya. Terima kasih!`
  );
  return `https://wa.me/${phone}?text=${text}`;
};

// ============================================
// OPENSTREETMAP EMBED URL
// Mengubah link Google Maps apapun menjadi embed OSM
// ============================================
const getOSMEmbedUrl = (url) => {
  if (!url) return 'https://www.openstreetmap.org/export/embed.html?layer=mapnik';

  // Format 1: https://www.google.com/maps/@-7.123,110.123,15z
  const m1 = url.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/);
  if (m1) {
    const lat = parseFloat(m1[1]);
    const lon = parseFloat(m1[2]);
    const d = 0.005;
    return `https://www.openstreetmap.org/export/embed.html?bbox=${lon - d},${lat - d},${lon + d},${lat + d}&layer=mapnik&marker=${lat},${lon}`;
  }

  // Format 2: https://maps.google.com/?q=-7.123,110.123
  const m2 = url.match(/[?&]q=(-?\d+\.\d+),(-?\d+\.\d+)/);
  if (m2) {
    const lat = parseFloat(m2[1]);
    const lon = parseFloat(m2[2]);
    const d = 0.005;
    return `https://www.openstreetmap.org/export/embed.html?bbox=${lon - d},${lat - d},${lon + d},${lat + d}&layer=mapnik&marker=${lat},${lon}`;
  }

  // Format 3: https://maps.app.goo.gl/xxx atau short link (tidak bisa parse koordinat)
  // → fallback ke pencarian dengan query string
  return `https://www.openstreetmap.org/export/embed.html?layer=mapnik`;
};

// Modals
const openDetailModal = (product) => {
  selectedProduct.value = product;
};

const openRegisterModal = () => {
  vendorForm.value.category = store.categoriesByTipe('produk')[0]?.nama || '';
  showRegisterModal.value = true;
};

const resetFilters = () => {
  activeCategory.value = 'semua';
  searchQuery.value = '';
  sortBy.value = 'terpopuler';
};

const handleImageFallback = (event) => {
  event.target.src = '/images/hero-bg.png';
};

const triggerToast = (msg) => {
  toastMessage.value = msg;
  setTimeout(() => { toastMessage.value = ''; }, 3500);
};

const showGuideToast = () => {
  triggerToast('Petunjuk: Pendaftaran terbuka gratis untuk seluruh warga Padukuhan. Klik "Daftar Jadi Penjual" untuk mulai!');
};

const copyShareLink = (product) => {
  navigator.clipboard.writeText(window.location.href);
  triggerToast(`Tautan produk "${product.name}" berhasil disalin!`);
};

// Form Submissions
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

const submitVendorRegistration = () => {
  store.addInbox({
    name: vendorForm.value.name,
    phone: vendorForm.value.phone,
    email: '-',
    message: `[PENDAFTARAN PENJUAL UMKM]\nKategori: ${vendorForm.value.category}\nDeskripsi: ${vendorForm.value.description}`
  });
  showRegisterModal.value = false;
  triggerToast(`Permohonan UMKM atas nama "${vendorForm.value.name}" telah diterima! Kami akan mengontak Anda via WhatsApp.`);
  vendorForm.value = { name: '', category: '', phone: '', description: '' };
};
</script>

<style scoped>
.scrollbar-none::-webkit-scrollbar { display: none; }
.scrollbar-none { -ms-overflow-style: none; scrollbar-width: none; }

@keyframes fadeIn {
  from { opacity: 0; transform: scale(0.98); }
  to { opacity: 1; transform: scale(1); }
}
.animate-fade-in {
  animation: fadeIn 0.2s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

@keyframes bounceSubtle {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}
.animate-bounce-subtle {
  animation: bounceSubtle 2s ease-in-out infinite;
}
</style>