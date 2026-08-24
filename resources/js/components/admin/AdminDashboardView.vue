<template>
  <div class="min-h-screen bg-[#F1F5F9] text-gray-900 flex flex-col font-sans antialiased">
    
    <!-- TOP ADMIN NAVBAR -->
    <header class="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-xs">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-18">
          
          <!-- Logo & Brand with Admin Badge -->
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-[#0D6847] text-white flex items-center justify-center font-bold shadow-md shadow-emerald-900/20">
              <ShieldCheckIcon class="w-6 h-6" />
            </div>
            <div>
              <div class="flex items-center gap-2">
                <h1 class="text-base font-extrabold text-gray-950 leading-tight">Panel Admin Desa</h1>
                <span class="px-2 py-0.5 bg-emerald-100 text-[#0D6847] font-bold text-[10px] uppercase rounded-md tracking-wider">
                  Super Admin
                </span>
              </div>
              <p class="text-[11px] text-gray-400 font-medium">Padukuhan Ngemplak Kalangan</p>
            </div>
          </div>

          <!-- Top Navigation Actions -->
          <div class="flex items-center gap-3">
            <!-- Back to Public Site Button -->
            <button 
              @click="$emit('navigate', 'beranda')"
              class="hidden sm:inline-flex items-center gap-2 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl transition-all active:scale-95 cursor-pointer"
            >
              <ExternalLinkIcon class="w-4 h-4 text-gray-500" />
              <span>Lihat Website Utama</span>
            </button>

            <!-- Admin Profile Indicator -->
            <div class="hidden md:flex items-center gap-2.5 px-3 py-1.5 bg-emerald-50 rounded-xl border border-emerald-100">
              <div class="w-7 h-7 rounded-lg bg-[#0D6847] text-white font-bold text-xs flex items-center justify-center">
                A
              </div>
              <span class="text-xs font-bold text-emerald-950">{{ store.adminUser.name }}</span>
            </div>

            <!-- Logout Button -->
            <button 
              @click="handleLogout"
              class="flex items-center gap-1.5 px-4 py-2 bg-red-50 hover:bg-red-100 text-red-600 border border-red-200 text-xs font-bold rounded-xl transition-all active:scale-95 cursor-pointer"
            >
              <LogOutIcon class="w-4 h-4" />
              <span>Keluar</span>
            </button>
          </div>

        </div>
      </div>
    </header>

    <!-- ADMIN CONTENT WRAPPER -->
    <div class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        <!-- SIDEBAR MENU (3 Cols) -->
        <aside class="lg:col-span-3 bg-white rounded-3xl p-4 border border-gray-200 shadow-sm space-y-1.5">
          <div class="px-3.5 py-2 mb-2">
            <span class="text-[10px] font-extrabold text-gray-400 uppercase tracking-widest">Menu Navigasi Data</span>
          </div>

          <button 
            v-for="menu in menuItems" 
            :key="menu.id"
            @click="activeTab = menu.id"
            :class="[
              activeTab === menu.id 
                ? 'bg-[#0D6847] text-white shadow-md shadow-emerald-900/15' 
                : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
            ]"
            class="w-full flex items-center justify-between px-4 py-3 rounded-2xl text-xs font-bold transition-all duration-200 cursor-pointer"
          >
            <div class="flex items-center gap-3">
              <component :is="menu.icon" class="w-4.5 h-4.5" />
              <span>{{ menu.label }}</span>
            </div>
            <span 
              v-if="menu.count !== undefined" 
              :class="activeTab === menu.id ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-600'"
              class="px-2 py-0.5 rounded-full text-[10px] font-bold"
            >
              {{ menu.count }}
            </span>
          </button>

          <!-- Divider -->
          <div class="pt-4 border-t border-gray-100 my-2">
            <button 
              @click="confirmResetData"
              class="w-full flex items-center gap-2.5 px-4 py-2.5 text-xs font-bold text-gray-400 hover:text-red-600 rounded-xl hover:bg-red-50/50 transition-colors cursor-pointer"
            >
              <RotateCcwIcon class="w-4 h-4" />
              <span>Reset Data ke Awal</span>
            </button>
          </div>
        </aside>

        <!-- MAIN WORKSPACE / CRUD AREA (9 Cols) -->
        <main class="lg:col-span-9 space-y-6">

          <!-- 1. TAB: RINGKASAN / OVERVIEW -->
          <div v-if="activeTab === 'overview'" class="space-y-6 animate-fade-in">
            <!-- Welcome Banner -->
            <div class="bg-gradient-to-r from-[#0D6847] to-[#0A5238] rounded-3xl p-8 text-white shadow-lg relative overflow-hidden">
              <div class="relative z-10 max-w-xl">
                <span class="px-3 py-1 bg-white/15 backdrop-blur-md rounded-full text-[11px] font-bold uppercase tracking-wider text-emerald-200">
                  Selamat Datang, Admin!
                </span>
                <h2 class="text-2xl sm:text-3xl font-extrabold mt-3 mb-2">Pusat Kelola Website Padukuhan</h2>
                <p class="text-xs sm:text-sm text-emerald-100/80 leading-relaxed">
                  Kelola konten publik mulai dari berita, produk UMKM, galeri foto &amp; video, struktur pengurus, dan data pertanyaan umum secara real-time.
                </p>
              </div>
            </div>

            <!-- Stats Metric Cards -->
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-4">
              <div 
                @click="activeTab = 'news'" 
                class="bg-white p-5 rounded-2xl border border-gray-200 shadow-xs hover:border-[#0D6847] transition-all cursor-pointer group"
              >
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-gray-400 uppercase">Berita</span>
                  <NewspaperIcon class="w-5 h-5 text-emerald-600 group-hover:scale-110 transition-transform" />
                </div>
                <div class="text-2xl font-black text-gray-900">{{ store.news.length }}</div>
                <p class="text-[10px] text-gray-500 mt-1">Artikel Terbit</p>
              </div>

              <div 
                @click="activeTab = 'products'" 
                class="bg-white p-5 rounded-2xl border border-gray-200 shadow-xs hover:border-[#0D6847] transition-all cursor-pointer group"
              >
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-gray-400 uppercase">Produk</span>
                  <ShoppingBagIcon class="w-5 h-5 text-blue-600 group-hover:scale-110 transition-transform" />
                </div>
                <div class="text-2xl font-black text-gray-900">{{ store.products.length }}</div>
                <p class="text-[10px] text-gray-500 mt-1">UMKM Terdaftar</p>
              </div>

              <div 
                @click="activeTab = 'gallery'" 
                class="bg-white p-5 rounded-2xl border border-gray-200 shadow-xs hover:border-[#0D6847] transition-all cursor-pointer group"
              >
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-gray-400 uppercase">Galeri</span>
                  <ImageIcon class="w-5 h-5 text-purple-600 group-hover:scale-110 transition-transform" />
                </div>
                <div class="text-2xl font-black text-gray-900">{{ store.gallery.length }}</div>
                <p class="text-[10px] text-gray-500 mt-1">Foto &amp; Video</p>
              </div>

              <div 
                @click="activeTab = 'inbox'" 
                class="bg-white p-5 rounded-2xl border border-gray-200 shadow-xs hover:border-[#0D6847] transition-all cursor-pointer group"
              >
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-gray-400 uppercase">Pesan</span>
                  <MailIcon class="w-5 h-5 text-amber-600 group-hover:scale-110 transition-transform" />
                </div>
                <div class="text-2xl font-black text-gray-900">{{ store.inbox.length }}</div>
                <p class="text-[10px] text-gray-500 mt-1">Pesan Masuk</p>
              </div>
            </div>

            <!-- Quick Action Shortcuts -->
            <div class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm">
              <h3 class="font-extrabold text-sm text-gray-900 mb-4 flex items-center gap-2">
                <SparklesIcon class="w-4 h-4 text-[#0D6847]" />
                <span>Aksi Cepat Tambah Data</span>
              </h3>

              <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                <button 
                  @click="openAddModal('news')"
                  class="p-4 rounded-2xl bg-emerald-50/70 hover:bg-emerald-100/70 border border-emerald-100 text-left transition-all cursor-pointer group"
                >
                  <NewspaperIcon class="w-6 h-6 text-[#0D6847] mb-2 group-hover:scale-105 transition-transform" />
                  <div class="font-bold text-xs text-gray-900">+ Tambah Berita Baru</div>
                  <p class="text-[11px] text-gray-500 mt-0.5">Publikasi kabar atau agenda desa</p>
                </button>

                <button 
                  @click="openAddModal('products')"
                  class="p-4 rounded-2xl bg-blue-50/70 hover:bg-blue-100/70 border border-blue-100 text-left transition-all cursor-pointer group"
                >
                  <ShoppingBagIcon class="w-6 h-6 text-blue-600 mb-2 group-hover:scale-105 transition-transform" />
                  <div class="font-bold text-xs text-gray-900">+ Tambah Produk UMKM</div>
                  <p class="text-[11px] text-gray-500 mt-0.5">Daftarkan produk karya warga</p>
                </button>

                <button 
                  @click="openAddModal('gallery')"
                  class="p-4 rounded-2xl bg-purple-50/70 hover:bg-purple-100/70 border border-purple-100 text-left transition-all cursor-pointer group"
                >
                  <ImageIcon class="w-6 h-6 text-purple-600 mb-2 group-hover:scale-105 transition-transform" />
                  <div class="font-bold text-xs text-gray-900">+ Unggah Dokumentasi</div>
                  <p class="text-[11px] text-gray-500 mt-0.5">Tambah foto kegiatan atau kesenian</p>
                </button>
              </div>
            </div>
          </div>

          <!-- 2. TAB: KELOLA BERITA & INFORMASI (CRUD) -->
          <div v-else-if="activeTab === 'news'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-6 animate-fade-in">
            <!-- Header Bar -->
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-150">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Berita &amp; Informasi</h2>
                <p class="text-xs text-gray-500">Total {{ store.news.length }} artikel dipublikasikan di halaman Beranda &amp; Informasi</p>
              </div>

              <button 
                @click="openAddModal('news')"
                class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <PlusIcon class="w-4 h-4" />
                <span>Tambah Berita Baru</span>
              </button>
            </div>

            <!-- News List Table -->
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Gambar</th>
                    <th class="py-3 px-4">Judul &amp; Kategori</th>
                    <th class="py-3 px-4">Tanggal</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.news" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-20">
                      <img :src="item.image" :alt="item.title" class="w-14 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" />
                    </td>
                    <td class="py-3 px-4 max-w-xs">
                      <div class="font-bold text-gray-900 line-clamp-1">{{ item.title }}</div>
                      <span class="inline-block mt-1 px-2 py-0.5 bg-emerald-50 text-[#0D6847] text-[10px] font-bold rounded-md">
                        {{ item.category }}
                      </span>
                    </td>
                    <td class="py-3 px-4 text-gray-500 whitespace-nowrap">{{ item.date }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-2">
                      <button 
                        @click="openEditModal('news', item)"
                        class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer" 
                        title="Edit Berita"
                      >
                        <PencilIcon class="w-3.5 h-3.5" />
                      </button>
                      <button 
                        @click="confirmDelete('news', item.id, item.title)"
                        class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer" 
                        title="Hapus Berita"
                      >
                        <Trash2Icon class="w-3.5 h-3.5" />
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 3. TAB: KELOLA PRODUK UMKM (CRUD) -->
          <div v-else-if="activeTab === 'products'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-6 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-150">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Produk UMKM Desa</h2>
                <p class="text-xs text-gray-500">Total {{ store.products.length }} produk terdaftar di Katalog Produk</p>
              </div>

              <button 
                @click="openAddModal('products')"
                class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <PlusIcon class="w-4 h-4" />
                <span>Tambah Produk Baru</span>
              </button>
            </div>

            <!-- Products Table -->
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Foto</th>
                    <th class="py-3 px-4">Nama &amp; Kategori</th>
                    <th class="py-3 px-4">Harga</th>
                    <th class="py-3 px-4">Penjual / Pembuat</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.products" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-20">
                      <img :src="item.image" :alt="item.name" class="w-14 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" />
                    </td>
                    <td class="py-3 px-4">
                      <div class="font-bold text-gray-900 line-clamp-1">{{ item.name }}</div>
                      <div class="flex items-center gap-2 mt-1">
                        <span class="px-2 py-0.5 bg-emerald-50 text-[#0D6847] text-[10px] font-bold rounded-md">{{ item.category }}</span>
                        <span v-if="item.isBestSeller" class="px-1.5 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">Terlaris</span>
                      </div>
                    </td>
                    <td class="py-3 px-4 font-bold text-amber-600 whitespace-nowrap">{{ formatRupiah(item.price) }}</td>
                    <td class="py-3 px-4 text-gray-600">{{ item.seller }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-2">
                      <button 
                        @click="openEditModal('products', item)"
                        class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer" 
                        title="Edit Produk"
                      >
                        <PencilIcon class="w-3.5 h-3.5" />
                      </button>
                      <button 
                        @click="confirmDelete('products', item.id, item.name)"
                        class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer" 
                        title="Hapus Produk"
                      >
                        <Trash2Icon class="w-3.5 h-3.5" />
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 4. TAB: KELOLA GALERI (CRUD) -->
          <div v-else-if="activeTab === 'gallery'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-6 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-150">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Galeri &amp; Dokumentasi</h2>
                <p class="text-xs text-gray-500">Total {{ store.gallery.length }} media foto &amp; video</p>
              </div>

              <button 
                @click="openAddModal('gallery')"
                class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <PlusIcon class="w-4 h-4" />
                <span>Tambah Dokumentasi</span>
              </button>
            </div>

            <!-- Gallery Table -->
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Thumbnail</th>
                    <th class="py-3 px-4">Judul Media</th>
                    <th class="py-3 px-4">Tipe &amp; Kategori</th>
                    <th class="py-3 px-4">Lokasi</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.gallery" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-20">
                      <img :src="item.image" :alt="item.title" class="w-14 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" />
                    </td>
                    <td class="py-3 px-4 font-bold text-gray-900 max-w-xs">{{ item.title }}</td>
                    <td class="py-3 px-4">
                      <span :class="item.type === 'video' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'" class="px-2 py-0.5 rounded text-[10px] font-bold uppercase mr-1.5">
                        {{ item.type }}
                      </span>
                      <span class="text-gray-500">{{ item.category }}</span>
                    </td>
                    <td class="py-3 px-4 text-gray-500">{{ item.location }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-2">
                      <button 
                        @click="openEditModal('gallery', item)"
                        class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer" 
                        title="Edit Media"
                      >
                        <PencilIcon class="w-3.5 h-3.5" />
                      </button>
                      <button 
                        @click="confirmDelete('gallery', item.id, item.title)"
                        class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer" 
                        title="Hapus Media"
                      >
                        <Trash2Icon class="w-3.5 h-3.5" />
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 5. TAB: KELOLA TOKOH & PERANGKAT DUSUN (CRUD) -->
          <div v-else-if="activeTab === 'leaders'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-6 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-150">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Tokoh &amp; Perangkat Dusun</h2>
                <p class="text-xs text-gray-500">Struktur kepengurusan di halaman Profil &amp; Tentang Kami</p>
              </div>

              <button 
                @click="openAddModal('leaders')"
                class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <PlusIcon class="w-4 h-4" />
                <span>Tambah Tokoh/Perangkat</span>
              </button>
            </div>

            <!-- Leaders Table -->
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Nama Lengkap</th>
                    <th class="py-3 px-4">Jabatan</th>
                    <th class="py-3 px-4">Fokus Tugas</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.leaders" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 font-bold text-gray-900">{{ item.name }}</td>
                    <td class="py-3 px-4 font-semibold text-[#0D6847]">{{ item.role }}</td>
                    <td class="py-3 px-4 text-gray-500">{{ item.focus }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-2">
                      <button 
                        @click="openEditModal('leaders', item)"
                        class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"
                      >
                        <PencilIcon class="w-3.5 h-3.5" />
                      </button>
                      <button 
                        @click="confirmDelete('leaders', item.id, item.name)"
                        class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"
                      >
                        <Trash2Icon class="w-3.5 h-3.5" />
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 6. TAB: KELOLA TANYA JAWAB / FAQ (CRUD) -->
          <div v-else-if="activeTab === 'faqs'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-6 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-150">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Tanya Jawab (FAQ)</h2>
                <p class="text-xs text-gray-500">Daftar pertanyaan yang tampil di halaman Tentang Kami</p>
              </div>

              <button 
                @click="openAddModal('faqs')"
                class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2"
              >
                <PlusIcon class="w-4 h-4" />
                <span>Tambah Pertanyaan</span>
              </button>
            </div>

            <!-- FAQs Table -->
            <div class="space-y-3">
              <div v-for="item in store.faqs" :key="item.id" class="p-4 rounded-2xl bg-gray-50 border border-gray-200 flex items-start justify-between gap-4">
                <div class="space-y-1 text-xs">
                  <h4 class="font-bold text-gray-900">{{ item.question }}</h4>
                  <p class="text-gray-600 leading-relaxed">{{ item.answer }}</p>
                </div>
                <div class="flex items-center gap-1.5 shrink-0">
                  <button 
                    @click="openEditModal('faqs', item)"
                    class="p-2 bg-white hover:bg-blue-50 text-blue-600 rounded-lg border border-gray-200 transition-colors cursor-pointer"
                  >
                    <PencilIcon class="w-3.5 h-3.5" />
                  </button>
                  <button 
                    @click="confirmDelete('faqs', item.id, item.question)"
                    class="p-2 bg-white hover:bg-red-50 text-red-600 rounded-lg border border-gray-200 transition-colors cursor-pointer"
                  >
                    <Trash2Icon class="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- 7. TAB: PESAN MASUK & KONTAK WARGA -->
          <div v-else-if="activeTab === 'inbox'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-6 animate-fade-in">
            <div class="flex items-center justify-between pb-4 border-b border-gray-150">
              <div>
                <h2 class="text-xl font-black text-gray-900">Pesan Masuk &amp; Kontak Pengunjung</h2>
                <p class="text-xs text-gray-500">Pesan yang dikirim melalui formulir "Hubungi Kami"</p>
              </div>
            </div>

            <div v-if="store.inbox.length > 0" class="space-y-4">
              <div 
                v-for="msg in store.inbox" 
                :key="msg.id"
                class="bg-gray-50 rounded-2xl p-5 border border-gray-200 space-y-3"
              >
                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-2 border-b border-gray-200/80 pb-3">
                  <div>
                    <h3 class="font-extrabold text-sm text-gray-900">{{ msg.name }}</h3>
                    <div class="flex items-center gap-3 text-xs text-gray-500 mt-0.5">
                      <span>📱 {{ msg.phone }}</span>
                      <span v-if="msg.email">• ✉️ {{ msg.email }}</span>
                    </div>
                  </div>
                  <div class="flex items-center gap-2">
                    <span class="text-[11px] font-medium text-gray-400">{{ msg.date }}</span>
                    <button 
                      @click="confirmDelete('inbox', msg.id, msg.name)"
                      class="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors cursor-pointer"
                      title="Hapus Pesan"
                    >
                      <Trash2Icon class="w-4 h-4" />
                    </button>
                  </div>
                </div>

                <p class="text-xs text-gray-700 leading-relaxed bg-white p-3.5 rounded-xl border border-gray-100">
                  {{ msg.message }}
                </p>

                <div class="flex items-center gap-2 pt-1">
                  <a 
                    :href="`https://wa.me/${msg.phone.replace(/[^0-9]/g, '')}`" 
                    target="_blank"
                    class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-[#25D366] hover:bg-[#1EBE5A] text-white text-[11px] font-bold rounded-lg transition-colors"
                  >
                    <MessageSquareIcon class="w-3.5 h-3.5" />
                    <span>Balas via WhatsApp</span>
                  </a>
                </div>
              </div>
            </div>

            <div v-else class="text-center py-12 text-gray-400 text-xs">
              Belum ada pesan masuk baru dari warga/pengunjung.
            </div>
          </div>

        </main>

      </div>
    </div>

    <!-- ADD / EDIT MODAL -->
    <div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div class="bg-white rounded-3xl max-w-lg w-full p-6 sm:p-8 shadow-2xl border border-gray-100 relative max-h-[90vh] overflow-y-auto">
        
        <!-- Close Button -->
        <button 
          @click="showModal = false"
          class="absolute top-5 right-5 text-gray-400 hover:text-gray-600 p-1 cursor-pointer"
        >
          <XIcon class="w-5 h-5" />
        </button>

        <div class="flex items-center gap-3 mb-6 pb-3 border-b border-gray-100">
          <div class="w-10 h-10 rounded-xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center font-bold">
            <PlusIcon v-if="!isEditMode" class="w-5 h-5" />
            <PencilIcon v-else class="w-5 h-5" />
          </div>
          <div>
            <h3 class="text-lg font-bold text-gray-900">
              {{ isEditMode ? 'Edit Data' : 'Tambah Data Baru' }}
            </h3>
            <p class="text-xs text-gray-500 uppercase tracking-wider font-semibold">{{ currentModalType }}</p>
          </div>
        </div>

        <form @submit.prevent="saveModalData" class="space-y-4">
          
          <!-- FORM FIELDS: NEWS -->
          <template v-if="currentModalType === 'news'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Judul Artikel</label>
              <input v-model="formData.title" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Kategori</label>
              <select v-model="formData.category" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                <option value="Kegiatan Warga">Kegiatan Warga</option>
                <option value="Generasi Muda">Generasi Muda</option>
                <option value="Tradisi Luhur">Tradisi Luhur</option>
                <option value="Pemberdayaan UMKM">Pemberdayaan UMKM</option>
                <option value="Pengumuman">Pengumuman</option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Ringkasan (Excerpt)</label>
              <textarea v-model="formData.excerpt" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Isi Lengkap</label>
              <textarea v-model="formData.content" rows="4" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM FIELDS: PRODUCTS -->
          <template v-else-if="currentModalType === 'products'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Produk</label>
              <input v-model="formData.name" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Kategori</label>
                <select v-model="formData.category" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                  <option value="Kerajinan">Kerajinan</option>
                  <option value="Hasil Bumi">Hasil Bumi</option>
                  <option value="Olahan Makanan">Olahan Makanan</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Harga (Rp)</label>
                <input v-model="formData.price" type="number" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Satuan (Unit)</label>
                <input v-model="formData.unit" type="text" placeholder="pcs / 250g / pack" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Penyedia / Pembuat</label>
                <input v-model="formData.seller" type="text" placeholder="Ibu Suminah (RT 02)" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
            </div>
            <div class="flex items-center gap-2 pt-1">
              <input v-model="formData.isBestSeller" type="checkbox" id="bestSeller" class="w-4 h-4 text-[#0D6847] rounded cursor-pointer" />
              <label for="bestSeller" class="text-xs font-bold text-gray-700 cursor-pointer">Tandai sebagai Produk Terlaris</label>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi Singkat</label>
              <textarea v-model="formData.description" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM FIELDS: GALLERY -->
          <template v-else-if="currentModalType === 'gallery'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Judul Foto / Video</label>
              <input v-model="formData.title" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Tipe Media</label>
                <select v-model="formData.type" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                  <option value="foto">Foto</option>
                  <option value="video">Video</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Kategori</label>
                <select v-model="formData.category" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                  <option value="Kebudayaan">Kebudayaan</option>
                  <option value="Keagamaan">Keagamaan</option>
                  <option value="Olahraga">Olahraga</option>
                  <option value="Profil">Profil</option>
                </select>
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Lokasi</label>
              <input v-model="formData.location" type="text" placeholder="Lapangan Padukuhan" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi</label>
              <textarea v-model="formData.description" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM FIELDS: LEADERS -->
          <template v-else-if="currentModalType === 'leaders'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Lengkap</label>
              <input v-model="formData.name" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Jabatan</label>
              <input v-model="formData.role" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Fokus Tugas</label>
              <input v-model="formData.focus" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi / Peran</label>
              <textarea v-model="formData.description" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM FIELDS: FAQS -->
          <template v-else-if="currentModalType === 'faqs'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Pertanyaan</label>
              <input v-model="formData.question" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Jawaban Lengkap</label>
              <textarea v-model="formData.answer" rows="3" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- Modal Action Buttons -->
          <div class="flex items-center gap-3 pt-4 border-t border-gray-150">
            <button 
              type="button" 
              @click="showModal = false"
              class="flex-1 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl transition-colors cursor-pointer"
            >
              Batal
            </button>
            <button 
              type="submit" 
              class="flex-1 py-3 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-colors cursor-pointer"
            >
              {{ isEditMode ? 'Simpan Perubahan' : 'Tambahkan' }}
            </button>
          </div>

        </form>

      </div>
    </div>

    <!-- DELETE CONFIRMATION DIALOG -->
    <div v-if="deleteTarget" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div class="bg-white rounded-3xl max-w-sm w-full p-6 text-center shadow-2xl border border-gray-100 space-y-4">
        <div class="w-12 h-12 rounded-2xl bg-red-50 text-red-600 flex items-center justify-center mx-auto">
          <AlertCircleIcon class="w-6 h-6" />
        </div>
        <div>
          <h3 class="text-base font-extrabold text-gray-900">Konfirmasi Hapus Data</h3>
          <p class="text-xs text-gray-500 mt-1">
            Apakah Anda yakin ingin menghapus data <strong>"{{ deleteTarget.name }}"</strong>? Tindakan ini tidak dapat dibatalkan.
          </p>
        </div>
        <div class="flex items-center gap-3 pt-2">
          <button 
            @click="deleteTarget = null" 
            class="flex-1 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl transition-colors cursor-pointer"
          >
            Batal
          </button>
          <button 
            @click="executeDelete" 
            class="flex-1 py-2.5 bg-red-600 hover:bg-red-700 text-white text-xs font-bold rounded-xl shadow-sm transition-colors cursor-pointer"
          >
            Hapus
          </button>
        </div>
      </div>
    </div>

    <!-- TOAST NOTIFICATION -->
    <div 
      v-if="toastMessage" 
      class="fixed bottom-6 right-6 z-50 bg-gray-900 text-white px-5 py-3 rounded-2xl shadow-2xl border border-gray-800 flex items-center gap-3 animate-fade-in text-xs font-bold"
    >
      <CheckCircle2Icon class="w-5 h-5 text-emerald-400" />
      <span>{{ toastMessage }}</span>
    </div>

  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { 
  ShieldCheck as ShieldCheckIcon,
  ExternalLink as ExternalLinkIcon,
  LogOut as LogOutIcon,
  LayoutDashboard as LayoutDashboardIcon,
  Newspaper as NewspaperIcon,
  ShoppingBag as ShoppingBagIcon,
  Image as ImageIcon,
  Users as UsersIcon,
  HelpCircle as HelpCircleIcon,
  Mail as MailIcon,
  RotateCcw as RotateCcwIcon,
  Plus as PlusIcon,
  Pencil as PencilIcon,
  Trash2 as Trash2Icon,
  X as XIcon,
  AlertCircle as AlertCircleIcon,
  CheckCircle2 as CheckCircle2Icon,
  Sparkles as SparklesIcon,
  MessageSquare as MessageSquareIcon
} from 'lucide-vue-next';
import { store } from '../../store';

const emit = defineEmits(['navigate']);

const activeTab = ref('overview');

const menuItems = computed(() => [
  { id: 'overview', label: 'Ringkasan Dashboard', icon: LayoutDashboardIcon },
  { id: 'news', label: 'Berita & Informasi', icon: NewspaperIcon, count: store.news.length },
  { id: 'products', label: 'Produk UMKM', icon: ShoppingBagIcon, count: store.products.length },
  { id: 'gallery', label: 'Galeri Foto & Video', icon: ImageIcon, count: store.gallery.length },
  { id: 'leaders', label: 'Tokoh & Perangkat', icon: UsersIcon, count: store.leaders.length },
  { id: 'faqs', label: 'Tanya Jawab (FAQ)', icon: HelpCircleIcon, count: store.faqs.length },
  { id: 'inbox', label: 'Pesan Masuk', icon: MailIcon, count: store.inbox.length }
]);

// Modal State
const showModal = ref(false);
const isEditMode = ref(false);
const currentModalType = ref('news');
const formData = ref({});
const toastMessage = ref('');
const deleteTarget = ref(null);

const triggerToast = (msg) => {
  toastMessage.value = msg;
  setTimeout(() => {
    toastMessage.value = '';
  }, 3000);
};

const formatRupiah = (val) => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0
  }).format(val || 0);
};

const handleFallbackImg = (e) => {
  e.target.src = '/images/hero-bg.png';
};

const handleLogout = () => {
  store.logout();
  triggerToast('Berhasil keluar dari Panel Admin');
  emit('navigate', 'beranda');
};

const confirmResetData = () => {
  if (confirm('Apakah Anda yakin ingin mengembalikan semua data ke data default bawaan?')) {
    store.resetToDefaults();
    triggerToast('Seluruh data berhasil di-reset ke pengaturan awal.');
  }
};

// Open Modals
const openAddModal = (type) => {
  isEditMode.value = false;
  currentModalType.value = type;
  formData.value = {};
  showModal.value = true;
};

const openEditModal = (type, item) => {
  isEditMode.value = true;
  currentModalType.value = type;
  formData.value = { ...item };
  showModal.value = true;
};

const saveModalData = () => {
  const type = currentModalType.value;
  if (isEditMode.value) {
    if (type === 'news') store.updateNews(formData.value.id, formData.value);
    else if (type === 'products') store.updateProduct(formData.value.id, formData.value);
    else if (type === 'gallery') store.updateGallery(formData.value.id, formData.value);
    else if (type === 'leaders') store.updateLeader(formData.value.id, formData.value);
    else if (type === 'faqs') store.updateFaq(formData.value.id, formData.value);
    triggerToast(`Data ${type} berhasil diperbarui!`);
  } else {
    if (type === 'news') store.addNews(formData.value);
    else if (type === 'products') store.addProduct(formData.value);
    else if (type === 'gallery') store.addGallery(formData.value);
    else if (type === 'leaders') store.addLeader(formData.value);
    else if (type === 'faqs') store.addFaq(formData.value);
    triggerToast(`Data ${type} baru berhasil ditambahkan!`);
  }
  showModal.value = false;
};

const confirmDelete = (type, id, name) => {
  deleteTarget.value = { type, id, name };
};

const executeDelete = () => {
  if (!deleteTarget.value) return;
  const { type, id, name } = deleteTarget.value;
  if (type === 'news') store.deleteNews(id);
  else if (type === 'products') store.deleteProduct(id);
  else if (type === 'gallery') store.deleteGallery(id);
  else if (type === 'leaders') store.deleteLeader(id);
  else if (type === 'faqs') store.deleteFaq(id);
  else if (type === 'inbox') store.deleteInbox(id);
  triggerToast(`Data "${name}" berhasil dihapus.`);
  deleteTarget.value = null;
};
</script>

<style scoped>
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(4px); }
  to { opacity: 1; transform: translateY(0); }
}

.animate-fade-in {
  animation: fadeIn 0.2s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}
</style>
