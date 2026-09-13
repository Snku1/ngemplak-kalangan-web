<template>
  <div class="min-h-screen bg-[#F1F5F9] text-gray-900 flex flex-col font-sans antialiased">

    <!-- TOP ADMIN NAVBAR -->
    <header class="sticky top-0 z-40 bg-white border-b border-gray-200 shadow-xs">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-18">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-[#0D6847] text-white flex items-center justify-center font-bold shadow-md shadow-emerald-900/20">
              <ShieldCheckIcon class="w-6 h-6" />
            </div>
            <div>
              <div class="flex items-center gap-2">
                <h1 class="text-base font-extrabold text-gray-950 leading-tight">Panel Admin Desa</h1>
                <span class="px-2 py-0.5 bg-emerald-100 text-[#0D6847] font-bold text-[10px] uppercase rounded-md tracking-wider">Super Admin</span>
              </div>
              <p class="text-[11px] text-gray-400 font-medium">Padukuhan Ngemplak Kalangan</p>
            </div>
          </div>
          <div class="flex items-center gap-3">
            <button @click="$emit('navigate', 'beranda')" class="hidden sm:inline-flex items-center gap-2 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl transition-all active:scale-95 cursor-pointer">
              <ExternalLinkIcon class="w-4 h-4 text-gray-500" />
              <span>Lihat Website Utama</span>
            </button>
            <div class="hidden md:flex items-center gap-2.5 px-3 py-1.5 bg-emerald-50 rounded-xl border border-emerald-100">
              <div class="w-7 h-7 rounded-lg bg-[#0D6847] text-white font-bold text-xs flex items-center justify-center">A</div>
              <span class="text-xs font-bold text-emerald-950">{{ store.adminUser?.name || 'Admin' }}</span>
            </div>
            <button @click="handleLogout" class="flex items-center gap-1.5 px-4 py-2 bg-red-50 hover:bg-red-100 text-red-600 border border-red-200 text-xs font-bold rounded-xl transition-all active:scale-95 cursor-pointer">
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

        <!-- SIDEBAR MENU -->
        <aside class="lg:col-span-3 bg-white rounded-3xl p-4 border border-gray-200 shadow-sm space-y-1">
          <div class="px-3.5 py-2 mb-2">
            <span class="text-[10px] font-extrabold text-gray-400 uppercase tracking-widest">Menu Kelola Data</span>
          </div>
          <button v-for="menu in menuItems" :key="menu.id" @click="activeTab = menu.id"
            :class="activeTab === menu.id ? 'bg-[#0D6847] text-white shadow-md shadow-emerald-900/15' : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'"
            class="w-full flex items-center justify-between px-4 py-3 rounded-2xl text-xs font-bold transition-all duration-200 cursor-pointer">
            <div class="flex items-center gap-3">
              <component :is="menu.icon" class="w-4 h-4 shrink-0" />
              <span>{{ menu.label }}</span>
            </div>
            <span v-if="menu.count !== undefined"
              :class="activeTab === menu.id ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-600'"
              class="px-2 py-0.5 rounded-full text-[10px] font-bold">{{ menu.count }}</span>
          </button>
        </aside>

        <!-- MAIN WORKSPACE -->
        <main class="lg:col-span-9 space-y-6">

          <!-- 1. OVERVIEW -->
          <div v-if="activeTab === 'overview'" class="space-y-6 animate-fade-in">
            <div class="bg-gradient-to-r from-[#0D6847] to-[#0A5238] rounded-3xl p-8 text-white shadow-lg">
              <span class="px-3 py-1 bg-white/15 rounded-full text-[11px] font-bold uppercase tracking-wider text-emerald-200">Selamat Datang, Admin!</span>
              <h2 class="text-2xl sm:text-3xl font-extrabold mt-3 mb-2">Pusat Kelola Website Padukuhan</h2>
              <p class="text-xs sm:text-sm text-emerald-100/80 leading-relaxed">Kelola konten publik mulai dari berita, produk UMKM, galeri, agenda, pengumuman, dan profil padukuhan secara real-time.</p>
            </div>
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-4">
              <div v-for="card in overviewCards" :key="card.tab" @click="activeTab = card.tab"
                class="bg-white p-5 rounded-2xl border border-gray-200 shadow-xs hover:border-[#0D6847] transition-all cursor-pointer group">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-gray-400 uppercase">{{ card.label }}</span>
                  <component :is="card.icon" :class="card.color" class="w-5 h-5 group-hover:scale-110 transition-transform" />
                </div>
                <div class="text-2xl font-black text-gray-900">{{ card.count }}</div>
                <p class="text-[10px] text-gray-500 mt-1">{{ card.sub }}</p>
              </div>
            </div>
            <div class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm">
              <h3 class="font-extrabold text-sm text-gray-900 mb-4 flex items-center gap-2">
                <SparklesIcon class="w-4 h-4 text-[#0D6847]" />
                <span>Aksi Cepat</span>
              </h3>
              <div class="grid grid-cols-2 sm:grid-cols-3 gap-3">
                <button v-for="qa in quickActions" :key="qa.type" @click="openAddModal(qa.type)"
                  class="p-4 rounded-2xl border text-left transition-all cursor-pointer group" :class="qa.bg">
                  <component :is="qa.icon" class="w-6 h-6 mb-2 group-hover:scale-105 transition-transform" :class="qa.iconColor" />
                  <div class="font-bold text-xs text-gray-900">+ {{ qa.label }}</div>
                  <p class="text-[11px] text-gray-500 mt-0.5">{{ qa.sub }}</p>
                </button>
              </div>
            </div>
          </div>

          <!-- 2. BERITA -->
          <div v-else-if="activeTab === 'news'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Berita &amp; Informasi</h2>
                <p class="text-xs text-gray-500">{{ store.news.length }} artikel · diurutkan dari terbaru</p>
              </div>
              <button @click="openAddModal('news')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Berita</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Gambar</th>
                    <th class="py-3 px-4">Judul, Kategori &amp; Ringkasan</th>
                    <th class="py-3 px-4">Tanggal</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in sortedNews" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-20">
                      <img :src="item.image || item.foto_url || '/images/hero-bg.png'" :alt="item.title" class="w-14 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" />
                    </td>
                    <td class="py-3 px-4 max-w-md">
                      <div class="font-bold text-gray-900 line-clamp-1">{{ item.title }}</div>
                      <span class="inline-block mt-1 px-2 py-0.5 bg-emerald-50 text-[#0D6847] text-[10px] font-bold rounded-md">{{ item.category }}</span>
                      <p class="text-gray-500 text-[11px] mt-1 line-clamp-2 leading-relaxed">{{ item.excerpt }}</p>
                    </td>
                    <td class="py-3 px-4 text-gray-500 whitespace-nowrap">{{ item.date }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('news', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('news', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer" title="Edit"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('news', item.id, item.title)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer" title="Hapus"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 3. PRODUK UMKM -->
          <div v-else-if="activeTab === 'products'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Produk UMKM Desa</h2>
                <p class="text-xs text-gray-500">{{ store.products.length }} produk terdaftar di Katalog Produk</p>
              </div>
              <button @click="openAddModal('products')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Produk</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead><tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                  <th class="py-3 px-4">Foto</th>
                  <th class="py-3 px-4">Nama &amp; Kategori</th>
                  <th class="py-3 px-4">Harga</th>
                  <th class="py-3 px-4">Penjual</th>
                  <th class="py-3 px-4 text-right">Aksi</th>
                </tr></thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.products" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-20"><img :src="item.image" :alt="item.name" class="w-14 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" /></td>
                    <td class="py-3 px-4">
                      <div class="font-bold text-gray-900 line-clamp-1">{{ item.name }}</div>
                      <div class="flex items-center gap-1.5 mt-1">
                        <span class="px-2 py-0.5 bg-emerald-50 text-[#0D6847] text-[10px] font-bold rounded-md">{{ item.category }}</span>
                        <span v-if="item.isBestSeller" class="px-1.5 py-0.5 bg-amber-100 text-amber-800 text-[10px] font-bold rounded">Terlaris</span>
                      </div>
                    </td>
                    <td class="py-3 px-4 font-bold text-amber-600 whitespace-nowrap">{{ formatRupiah(item.price) }}</td>
                    <td class="py-3 px-4 text-gray-600">{{ item.seller }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('products', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('products', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('products', item.id, item.name)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 4. GALERI -->
          <div v-else-if="activeTab === 'gallery'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Galeri &amp; Dokumentasi</h2>
                <p class="text-xs text-gray-500">{{ store.gallery.length }} media foto &amp; video</p>
              </div>
              <button @click="openAddModal('gallery')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Media</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead><tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                  <th class="py-3 px-4">Thumbnail</th>
                  <th class="py-3 px-4">Judul Media</th>
                  <th class="py-3 px-4">Tipe &amp; Kategori</th>
                  <th class="py-3 px-4 text-right">Aksi</th>
                </tr></thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.gallery" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-20"><img :src="item.image" :alt="item.title" class="w-14 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" /></td>
                    <td class="py-3 px-4 font-bold text-gray-900 max-w-xs">{{ item.title }}</td>
                    <td class="py-3 px-4">
                      <span :class="item.type === 'video' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'" class="px-2 py-0.5 rounded text-[10px] font-bold uppercase mr-1.5">{{ item.type }}</span>
                      <span class="text-gray-500">{{ item.category }}</span>
                    </td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('gallery', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('gallery', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('gallery', item.id, item.title)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 5. AGENDA -->
          <div v-else-if="activeTab === 'agenda'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Agenda Kegiatan</h2>
                <p class="text-xs text-gray-500">{{ store.agenda.length }} kegiatan terjadwal di halaman Informasi</p>
              </div>
              <button @click="openAddModal('agenda')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Agenda</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead><tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                  <th class="py-3 px-4">Nama Kegiatan</th>
                  <th class="py-3 px-4">Tanggal</th>
                  <th class="py-3 px-4">Waktu</th>
                  <th class="py-3 px-4">Lokasi</th>
                  <th class="py-3 px-4">Status</th>
                  <th class="py-3 px-4 text-right">Aksi</th>
                </tr></thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.agenda" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 font-bold text-gray-900 max-w-xs">{{ item.title }}</td>
                    <td class="py-3 px-4 text-gray-600 whitespace-nowrap">{{ item.date }}</td>
                    <td class="py-3 px-4 text-gray-600 whitespace-nowrap">{{ item.time }}</td>
                    <td class="py-3 px-4 text-gray-500">{{ item.location }}</td>
                    <td class="py-3 px-4">
                      <span :class="{
                        'bg-amber-100 text-amber-700': item.status === 'mendatang',
                        'bg-emerald-100 text-emerald-700': item.status === 'selesai'
                      }" class="px-2 py-0.5 rounded text-[10px] font-bold capitalize">{{ item.status }}</span>
                    </td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('agenda', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('agenda', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('agenda', item.id, item.title)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 6. PENGUMUMAN -->
          <div v-else-if="activeTab === 'pengumuman'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Pengumuman</h2>
                <p class="text-xs text-gray-500">{{ store.pengumuman.length }} pengumuman aktif di halaman Informasi</p>
              </div>
              <button @click="openAddModal('pengumuman')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Pengumuman</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead><tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                  <th class="py-3 px-4">Judul</th>
                  <th class="py-3 px-4">Tanggal Posting</th>
                  <th class="py-3 px-4 text-right">Aksi</th>
                </tr></thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.pengumuman" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 font-bold text-gray-900 max-w-md">
                      {{ item.title }}
                      <p class="text-gray-500 font-normal text-[11px] mt-0.5 line-clamp-1">{{ item.description }}</p>
                    </td>
                    <td class="py-3 px-4">
                      <span :class="item.isImportant ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700'" class="px-2 py-0.5 rounded text-[10px] font-bold uppercase">
                        {{ item.isImportant ? 'Penting' : 'Info' }}
                      </span>
                    </td>
                    <td class="py-3 px-4 text-gray-500 whitespace-nowrap">{{ item.date }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('pengumuman', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('pengumuman', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('pengumuman', item.id, item.title)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 7. TOKOH & PERANGKAT -->
          <div v-else-if="activeTab === 'leaders'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Tokoh &amp; Perangkat Dusun</h2>
                <p class="text-xs text-gray-500">{{ store.leaders.length }} tokoh · tampil di halaman Informasi</p>
              </div>
              <button @click="openAddModal('leaders')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Tokoh</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Foto</th>
                    <th class="py-3 px-4">Nama Lengkap</th>
                    <th class="py-3 px-4">Jabatan</th>
                    <th class="py-3 px-4 text-center">Urutan</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.leaders" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-16">
                      <img v-if="item.image" :src="item.image" :alt="item.name" class="w-10 h-10 rounded-full object-cover bg-gray-100" @error="handleFallbackImg" />
                      <div v-else class="w-10 h-10 rounded-full bg-[#1B8A9C] text-white flex items-center justify-center font-bold text-sm">
                        {{ item.initials }}
                      </div>
                    </td>
                    <td class="py-3 px-4 font-bold text-gray-900">{{ item.name }}</td>
                    <td class="py-3 px-4 font-semibold text-[#0D6847]">{{ item.role }}</td>
                    <td class="py-3 px-4 text-center text-gray-500 font-mono">{{ item.urutan }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('leaders', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('leaders', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('leaders', item.id, item.name)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                  <tr v-if="store.leaders.length === 0">
                    <td colspan="5" class="py-6 text-center text-gray-400">Belum ada data tokoh &amp; perangkat.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 8. DEMOGRAFI -->
          <div v-else-if="activeTab === 'demographics'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Statistik Kependudukan</h2>
                <p class="text-xs text-gray-500">Statistik demografi di halaman Profil ({{ store.demographics.length }} data)</p>
              </div>
              <button @click="openAddModal('demographics')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Statistik</span>
              </button>
            </div>

            <!-- Filter Kategori -->
            <div class="flex flex-wrap items-center gap-2">
              <span class="text-xs font-bold text-gray-400 uppercase tracking-wider mr-1">Filter Kategori:</span>
              <button v-for="t in ['semua', 'usia', 'jenis_kelamin', 'pendidikan', 'pekerjaan']" :key="t"
                @click="demografiFilter = t"
                :class="demografiFilter === t ? 'bg-[#0D6847] text-white shadow-xs' : 'bg-gray-50 text-gray-600 hover:bg-gray-100 border border-gray-200'"
                class="px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all cursor-pointer capitalize">
                {{ t === 'jenis_kelamin' ? 'jenis kelamin' : t }}
              </button>
            </div>

            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Kategori</th>
                    <th class="py-3 px-4">Label</th>
                    <th class="py-3 px-4 text-center">Urutan</th>
                    <th class="py-3 px-4 text-right">Jumlah Jiwa</th>
                    <th class="py-3 px-4 text-right">Persen (%)</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in filteredDemografi" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 font-bold text-gray-900 uppercase">{{ item.kategori?.replace('_', ' ') }}</td>
                    <td class="py-3 px-4 font-semibold text-[#0D6847]">{{ item.label }}</td>
                    <td class="py-3 px-4 text-center text-gray-500 font-mono">{{ item.urutan }}</td>
                    <td class="py-3 px-4 text-right">{{ item.jumlah_jiwa }} Jiwa</td>
                    <td class="py-3 px-4 text-right">{{ item.persentase }}%</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('demographics', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('demographics', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('demographics', item.id, item.label)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                  <tr v-if="filteredDemografi.length === 0">
                    <td colspan="6" class="py-6 text-center text-gray-400">Belum ada data untuk kategori ini.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 9. KEPENDUDUKAN PER DUSUN -->
          <div v-else-if="activeTab === 'kependudukan'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Kependudukan per Dusun</h2>
                <p class="text-xs text-gray-500">{{ store.kependudukanDusun.length }} dusun terdaftar · tampil di halaman Profil</p>
              </div>
              <button @click="openAddModal('kependudukan')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Dusun</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Urutan</th>
                    <th class="py-3 px-4">Nama Dusun</th>
                    <th class="py-3 px-4 text-right">Laki-laki</th>
                    <th class="py-3 px-4 text-right">Perempuan</th>
                    <th class="py-3 px-4 text-right">Total</th>
                    <th class="py-3 px-4 text-right">KK</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.kependudukanDusun" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 text-gray-400 font-mono text-[11px]">{{ item.urutan }}</td>
                    <td class="py-3 px-4 font-bold text-gray-900">{{ item.nama_dusun }}</td>
                    <td class="py-3 px-4 text-right text-cyan-700 font-bold">{{ item.laki_laki }}</td>
                    <td class="py-3 px-4 text-right text-green-700 font-bold">{{ item.perempuan }}</td>
                    <td class="py-3 px-4 text-right font-extrabold text-emerald-700">{{ item.total }}</td>
                    <td class="py-3 px-4 text-right text-gray-500">{{ item.jumlah_kk }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('kependudukan', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('kependudukan', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('kependudukan', item.id, item.nama_dusun)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                  <tr v-if="store.kependudukanDusun.length === 0">
                    <td colspan="7" class="py-6 text-center text-gray-400">Belum ada data kependudukan per dusun.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 10. POTENSI & FASILITAS -->
          <div v-else-if="activeTab === 'facilities'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Potensi &amp; Fasilitas Desa</h2>
                <p class="text-xs text-gray-500">Sarana prasarana dan potensi dusun</p>
              </div>
              <button @click="openAddModal('facilities')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Potensi</span>
              </button>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead><tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                  <th class="py-3 px-4">Foto</th>
                  <th class="py-3 px-4">Nama</th>
                  <th class="py-3 px-4">Kategori</th>
                  <th class="py-3 px-4">Link Maps</th>
                  <th class="py-3 px-4 text-right">Aksi</th>
                </tr></thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in store.facilities" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 w-16">
                      <img :src="item.foto_url || '/images/hero-bg.png'" :alt="item.nama" class="w-10 h-10 rounded-lg object-cover bg-gray-100" @error="handleFallbackImg" />
                    </td>
                    <td class="py-3 px-4 font-bold text-gray-900">{{ item.nama }}</td>
                    <td class="py-3 px-4 font-semibold text-[#0D6847]">{{ item.kategori === 'wisata' ? 'Fasilitas / Wisata' : 'Potensi Desa' }}</td>
                    <td class="py-3 px-4 text-gray-500 max-w-xs truncate">
                      <a v-if="item.lokasi" :href="item.lokasi" target="_blank" class="text-blue-600 hover:underline">{{ item.lokasi }}</a>
                      <span v-else>-</span>
                    </td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('facilities', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('facilities', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('facilities', item.id, item.nama)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 11. FAQ -->
          <div v-else-if="activeTab === 'faqs'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Tanya Jawab (FAQ)</h2>
                <p class="text-xs text-gray-500">Tampil di halaman Tentang Kami</p>
              </div>
              <button @click="openAddModal('faqs')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah FAQ</span>
              </button>
            </div>
            <div class="space-y-3">
              <div v-for="item in store.faqs" :key="item.id" class="p-4 rounded-2xl bg-gray-50 border border-gray-200 flex items-start justify-between gap-4">
                <div class="space-y-1 text-xs">
                  <h4 class="font-bold text-gray-900">{{ item.question }}</h4>
                  <p class="text-gray-600 leading-relaxed">{{ item.answer }}</p>
                </div>
                <div class="flex items-center gap-1.5 shrink-0">
                  <button @click="openDetailView('faqs', item)" class="p-2 bg-white hover:bg-emerald-50 text-emerald-600 rounded-lg border border-gray-200 transition-colors cursor-pointer"><EyeIcon class="w-3.5 h-3.5" /></button>
                  <button @click="openEditModal('faqs', item)" class="p-2 bg-white hover:bg-blue-50 text-blue-600 rounded-lg border border-gray-200 transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                  <button @click="confirmDelete('faqs', item.id, item.question)" class="p-2 bg-white hover:bg-red-50 text-red-600 rounded-lg border border-gray-200 transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                </div>
              </div>
            </div>
          </div>

          <!-- 11. MASTER KATEGORI -->
          <div v-else-if="activeTab === 'kategori'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-gray-100">
              <div>
                <h2 class="text-xl font-black text-gray-900">Kelola Master Kategori</h2>
                <p class="text-xs text-gray-500">Kategori untuk Berita, Produk, Galeri, dan Pengumuman ({{ store.categories.length }} total)</p>
              </div>
              <button @click="openAddModal('kategori')" class="px-4 py-2.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-sm transition-all active:scale-95 cursor-pointer flex items-center gap-2">
                <PlusIcon class="w-4 h-4" /><span>Tambah Kategori</span>
              </button>
            </div>

            <!-- Filter Tipe -->
            <div class="flex flex-wrap items-center gap-2">
              <span class="text-xs font-bold text-gray-400 uppercase tracking-wider mr-1">Filter Tipe:</span>
              <button v-for="t in ['semua', 'berita', 'produk', 'galeri']" :key="t"
                @click="kategoriFilter = t"
                :class="kategoriFilter === t ? 'bg-[#0D6847] text-white shadow-xs' : 'bg-gray-50 text-gray-600 hover:bg-gray-100 border border-gray-200'"
                class="px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all cursor-pointer capitalize">
                {{ t }}
              </button>
            </div>

            <div class="overflow-x-auto">
              <table class="w-full text-left text-xs">
                <thead>
                  <tr class="bg-gray-50 border-b border-gray-200 text-gray-500 font-bold uppercase tracking-wider">
                    <th class="py-3 px-4">Nama Kategori</th>
                    <th class="py-3 px-4">Tipe</th>
                    <th class="py-3 px-4">Slug</th>
                    <th class="py-3 px-4 text-right">Aksi</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <tr v-for="item in filteredKategori" :key="item.id" class="hover:bg-gray-50/80 transition-colors">
                    <td class="py-3 px-4 font-bold text-gray-900">{{ item.nama }}</td>
                    <td class="py-3 px-4">
                      <span :class="{
                        'bg-emerald-100 text-emerald-700': item.tipe === 'berita',
                        'bg-blue-100 text-blue-700': item.tipe === 'produk',
                        'bg-purple-100 text-purple-700': item.tipe === 'galeri',
                        'bg-amber-100 text-amber-700': item.tipe === 'pengumuman'
                      }" class="px-2 py-0.5 rounded text-[10px] font-bold uppercase">{{ item.tipe }}</span>
                    </td>
                    <td class="py-3 px-4 text-gray-500 font-mono text-[11px]">{{ item.slug }}</td>
                    <td class="py-3 px-4 text-right whitespace-nowrap space-x-1">
                      <button @click="openDetailView('kategori', item)" class="p-2 bg-gray-100 hover:bg-emerald-50 text-emerald-600 rounded-lg transition-colors cursor-pointer" title="Lihat Detail"><EyeIcon class="w-3.5 h-3.5" /></button>
                      <button @click="openEditModal('kategori', item)" class="p-2 bg-gray-100 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors cursor-pointer"><PencilIcon class="w-3.5 h-3.5" /></button>
                      <button @click="confirmDelete('kategori', item.id, item.nama)" class="p-2 bg-gray-100 hover:bg-red-50 text-red-600 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-3.5 h-3.5" /></button>
                    </td>
                  </tr>
                  <tr v-if="filteredKategori.length === 0">
                    <td colspan="4" class="py-6 text-center text-gray-400">Belum ada kategori untuk tipe ini.</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- 12. PROFIL PADUKUHAN -->
          <div v-else-if="activeTab === 'profile'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="pb-4 border-b border-gray-100">
              <h2 class="text-xl font-black text-gray-900">Kelola Profil Padukuhan</h2>
              <p class="text-xs text-gray-500">Data profil ditampilkan di halaman Beranda &amp; Profil</p>
            </div>
            <form @submit.prevent="savePadukuhanProfile" class="space-y-4">
              <!-- Identitas -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Nama Padukuhan <span class="text-red-500">*</span></label>
                  <input v-model="profileForm.nama_padukuhan" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Nama Kepala Dukuh</label>
                  <input v-model="profileForm.nama_dukuh" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Kecamatan</label>
                  <input v-model="profileForm.kecamatan" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Kabupaten</label>
                  <input v-model="profileForm.kabupaten" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Provinsi</label>
                  <input v-model="profileForm.provinsi" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Kode Pos</label>
                  <input v-model="profileForm.kode_pos" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Luas Wilayah</label>
                  <input v-model="profileForm.luas_wilayah" type="text" placeholder="cth: 1.2 km²" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah Dusun</label>
                  <input v-model="profileForm.jumlah_dusun" type="number" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah RT</label>
                  <input v-model="profileForm.jumlah_rt" type="number" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah RW</label>
                  <input v-model="profileForm.jumlah_rw" type="number" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah Penduduk (Jiwa)</label>
                  <input v-model="profileForm.jumlah_penduduk" type="number" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah KK</label>
                  <input v-model="profileForm.jumlah_kk" type="number" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Telepon Kantor</label>
                  <input v-model="profileForm.telepon" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-700 mb-1">Email Resmi</label>
                  <input v-model="profileForm.email" type="email" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                </div>
              </div>

              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Alamat Kantor</label>
                <input v-model="profileForm.alamat_kantor" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>

              <!-- Batas Wilayah -->
              <div class="border-t border-gray-100 pt-4">
                <h4 class="text-xs font-bold text-gray-700 uppercase tracking-wider mb-3">Batas Wilayah</h4>
                <div class="grid grid-cols-2 gap-3">
                  <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1">Batas Utara</label>
                    <input v-model="profileForm.batas_utara" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                  </div>
                  <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1">Batas Selatan</label>
                    <input v-model="profileForm.batas_selatan" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                  </div>
                  <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1">Batas Timur</label>
                    <input v-model="profileForm.batas_timur" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                  </div>
                  <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1">Batas Barat</label>
                    <input v-model="profileForm.batas_barat" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                  </div>
                </div>
              </div>

              <!-- Maps Embed -->
              <div class="border-t border-gray-100 pt-4">
                <label class="block text-xs font-bold text-gray-700 mb-1">URL Google Maps (untuk Beranda)</label>
                <input v-model="profileForm.maps_embed" type="text" placeholder="https://maps.app.goo.gl/..." class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                <p class="text-[10px] text-gray-400 mt-1">Salin link dari Google Maps → Share → Copy Link.</p>
              </div>

              <!-- Foto -->
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Foto Kepala Dukuh</label>
                <input type="file" accept="image/*" @change="e => profileFileUpload = e.target.files[0]"
                  class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
                <p v-if="profileFileUpload" class="text-[10px] text-emerald-600 font-bold mt-1">✓ {{ profileFileUpload.name }}</p>
                <div v-if="profileForm.foto_dukuh && !profileFileUpload" class="mt-2">
                  <img :src="profileForm.foto_dukuh" class="h-20 rounded-lg object-cover border" @error="e => e.target.style.display='none'" />
                </div>
              </div>

              <!-- Teks -->
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Sambutan Kepala Dukuh</label>
                <textarea v-model="profileForm.sambutan_dukuh" rows="3" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Cita-Cita Padukuhan</label>
                <textarea v-model="profileForm.cita_cita" rows="3" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Sejarah Padukuhan</label>
                <textarea v-model="profileForm.sejarah" rows="4" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
              </div>

              <button type="submit" class="px-6 py-3 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md flex items-center gap-2">
                <CheckCircle2Icon class="w-4 h-4" />
                <span>Simpan Profil Padukuhan</span>
              </button>
            </form>
          </div>

          <!-- 13. PESAN MASUK -->
          <div v-else-if="activeTab === 'inbox'" class="bg-white rounded-3xl p-6 border border-gray-200 shadow-sm space-y-5 animate-fade-in">
            <div class="pb-4 border-b border-gray-100">
              <h2 class="text-xl font-black text-gray-900">Pesan Masuk &amp; Kontak Pengunjung</h2>
              <p class="text-xs text-gray-500">Pesan dikirim melalui formulir "Hubungi Kami"</p>
            </div>
            <div v-if="store.inbox.length > 0" class="space-y-4">
              <div v-for="msg in store.inbox" :key="msg.id" class="bg-gray-50 rounded-2xl p-5 border border-gray-200 space-y-3">
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
                    <button @click="confirmDelete('inbox', msg.id, msg.name)" class="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors cursor-pointer"><Trash2Icon class="w-4 h-4" /></button>
                  </div>
                </div>
                <p class="text-xs text-gray-700 leading-relaxed bg-white p-3.5 rounded-xl border border-gray-100">{{ msg.message }}</p>
                <a :href="`https://wa.me/${(msg.phone || '').replace(/[^0-9]/g,'')}`" target="_blank" class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-[#25D366] hover:bg-[#1EBE5A] text-white text-[11px] font-bold rounded-lg transition-colors">
                  <MessageSquareIcon class="w-3.5 h-3.5" /><span>Balas via WhatsApp</span>
                </a>
              </div>
            </div>
            <div v-else class="text-center py-12 text-gray-400 text-xs">Belum ada pesan masuk dari warga/pengunjung.</div>
          </div>

        </main>
      </div>
    </div>

    <!-- ADD / EDIT MODAL -->
    <div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div class="bg-white rounded-3xl max-w-lg w-full p-6 sm:p-8 shadow-2xl border border-gray-100 relative max-h-[90vh] overflow-y-auto">
        <button @click="showModal = false" class="absolute top-5 right-5 text-gray-400 hover:text-gray-600 p-1 cursor-pointer"><XIcon class="w-5 h-5" /></button>
        <div class="flex items-center gap-3 mb-6 pb-3 border-b border-gray-100">
          <div class="w-10 h-10 rounded-xl bg-[#0D6847]/10 text-[#0D6847] flex items-center justify-center">
            <PlusIcon v-if="!isEditMode" class="w-5 h-5" /><PencilIcon v-else class="w-5 h-5" />
          </div>
          <div>
            <h3 class="text-lg font-bold text-gray-900">{{ isEditMode ? 'Edit Data' : 'Tambah Data Baru' }}</h3>
            <p class="text-xs text-gray-500 uppercase tracking-wider font-semibold">{{ modalTypeLabel }}</p>
          </div>
        </div>

        <form @submit.prevent="saveModalData" class="space-y-4">

          <!-- FORM: BERITA -->
          <template v-if="currentModalType === 'news'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Judul Artikel <span class="text-red-500">*</span></label>
              <input v-model="formData.title" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" placeholder="Masukkan judul berita..." />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Kategori <span class="text-red-500">*</span></label>
              <select v-model="formData.category_id" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                <option value="">-- Pilih Kategori --</option>
                <option v-for="cat in store.categoriesByTipe('berita')" :key="cat.id" :value="cat.id">{{ cat.nama }}</option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Upload Foto (JPG/PNG, maks 5MB)</label>
              <input type="file" accept="image/*" @change="e => fileUpload = e.target.files[0]"
                class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p v-if="fileUpload" class="text-[10px] text-emerald-600 font-bold mt-1">✓ {{ fileUpload.name }}</p>
              <div v-if="formData.foto_url && !fileUpload" class="mt-2">
                <img :src="formData.foto_url" class="h-20 rounded-lg object-cover border border-gray-200" @error="e => e.target.style.display='none'" />
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Ringkasan (Excerpt)</label>
              <textarea v-model="formData.excerpt" rows="2" placeholder="Ringkasan singkat berita yang tampil di kartu..." class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
              <p class="text-[10px] text-gray-400 mt-1">Ringkasan ini tampil di halaman Informasi sebagai preview berita.</p>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Isi Lengkap</label>
              <textarea v-model="formData.content" rows="4" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM: PRODUK -->
          <template v-else-if="currentModalType === 'products'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Produk <span class="text-red-500">*</span></label>
              <input v-model="formData.name" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" placeholder="Masukkan nama produk..." />
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Kategori <span class="text-red-500">*</span></label>
                <select v-model="formData.category_id" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                  <option value="">-- Pilih Kategori --</option>
                  <option v-for="cat in store.categoriesByTipe('produk')" :key="cat.id" :value="cat.id">{{ cat.nama }}</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Harga (Rp) <span class="text-red-500">*</span></label>
                <input v-model="formData.price" type="number" required min="0" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" placeholder="0" />
              </div>
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Nama Penjual / UMKM</label>
                <input v-model="formData.seller" type="text" placeholder="cth: Ibu Suminah" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">No. WhatsApp Penjual</label>
                <input v-model="formData.sellerPhone" type="text" placeholder="628xxx" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Link Google Maps Lokasi Penjual</label>
              <input v-model="formData.sellerMaps" type="text" placeholder="https://maps.app.goo.gl/..." class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p class="text-[10px] text-gray-400 mt-1">Buka Google Maps → Share → Copy Link.</p>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Upload Foto Produk (JPG/PNG)</label>
              <input type="file" accept="image/*" @change="e => fileUpload = e.target.files[0]"
                class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p v-if="fileUpload" class="text-[10px] text-emerald-600 font-bold mt-1">✓ {{ fileUpload.name }}</p>
              <div v-if="formData.foto_url && !fileUpload" class="mt-2">
                <img :src="formData.foto_url" class="h-20 rounded-lg object-cover border border-gray-200" @error="e => e.target.style.display='none'" />
              </div>
            </div>
            <div class="flex items-center gap-2">
              <input v-model="formData.isBestSeller" type="checkbox" id="bestSeller" class="w-4 h-4 text-[#0D6847] rounded cursor-pointer" />
              <label for="bestSeller" class="text-xs font-bold text-gray-700 cursor-pointer">Tandai sebagai Produk Terlaris</label>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi Produk</label>
              <textarea v-model="formData.description" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM: GALERI -->
          <template v-else-if="currentModalType === 'gallery'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Judul Foto / Video <span class="text-red-500">*</span></label>
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
                <select v-model="formData.category_id" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                  <option value="">-- Pilih Kategori --</option>
                  <option v-for="cat in store.categoriesByTipe('galeri')" :key="cat.id" :value="cat.id">{{ cat.nama }}</option>
                </select>
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Upload File (JPG/PNG/MP4, maks 10MB)</label>
              <input type="file" accept="image/*,video/*" @change="e => fileUpload = e.target.files[0]"
                class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p v-if="fileUpload" class="text-[10px] text-emerald-600 font-bold mt-1">✓ {{ fileUpload.name }}</p>
              <div v-if="formData.foto_url && !fileUpload" class="mt-2">
                <img :src="formData.foto_url" class="h-20 rounded-lg object-cover border border-gray-200" @error="e => e.target.style.display='none'" />
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">URL YouTube (opsional, untuk video)</label>
              <input v-model="formData.youtube_url" type="url" placeholder="https://youtube.com/..." class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Lokasi</label>
              <input v-model="formData.location" type="text" placeholder="Lapangan Padukuhan" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi</label>
              <textarea v-model="formData.deskripsi" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM: AGENDA -->
          <template v-else-if="currentModalType === 'agenda'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Kegiatan <span class="text-red-500">*</span></label>
              <input v-model="formData.title" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Tanggal <span class="text-red-500">*</span></label>
                <input v-model="formData.date" type="date" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Waktu Mulai</label>
                <input v-model="formData.time_start" type="time" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Waktu Selesai</label>
              <input v-model="formData.time_end" type="time" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Lokasi</label>
              <input v-model="formData.location" type="text" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Status</label>
              <select v-model="formData.status" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                <option value="mendatang">Mendatang</option>
                <option value="selesai">Selesai</option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi</label>
              <textarea v-model="formData.details" rows="3" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM: PENGUMUMAN -->
          <template v-else-if="currentModalType === 'pengumuman'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Judul Pengumuman <span class="text-red-500">*</span></label>
              <input v-model="formData.title" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Tanggal Posting <span class="text-red-500">*</span></label>
              <input v-model="formData.tanggal_posting" type="date" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Isi Ringkas <span class="text-red-500">*</span></label>
              <textarea v-model="formData.description" rows="4" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
            <div class="flex items-center gap-2">
              <input v-model="formData.isImportant" type="checkbox" id="isImportant" class="w-4 h-4 text-[#0D6847] rounded cursor-pointer" />
              <label for="isImportant" class="text-xs font-bold text-gray-700 cursor-pointer">Tandai sebagai Pengumuman Penting</label>
            </div>
          </template>

          <!-- FORM: TOKOH & PERANGKAT -->
          <template v-else-if="currentModalType === 'leaders'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Lengkap <span class="text-red-500">*</span></label>
              <input v-model="formData.name" type="text" required
                placeholder="cth: Papang Suherlan"
                class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Jabatan <span class="text-red-500">*</span></label>
              <input v-model="formData.role" type="text" required
                placeholder="cth: Kepala Desa / Sekretaris Desa / Kepala Seksi Pemerintahan"
                class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Urutan <span class="text-red-500">*</span></label>
              <input v-model.number="formData.urutan" type="number" required min="1"
                placeholder="cth: 1"
                class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p class="text-[10px] text-gray-400 mt-1">
                <strong>1</strong> = Kepala Desa · <strong>2</strong> = Sekretaris · <strong>3+</strong> = Kepala Seksi
              </p>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Upload Foto (opsional)</label>
              <input type="file" accept="image/*" @change="e => fileUpload = e.target.files[0]"
                class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p v-if="fileUpload" class="text-[10px] text-emerald-600 font-bold mt-1">✓ {{ fileUpload.name }}</p>
              <div v-if="formData.foto_url && !fileUpload" class="mt-2">
                <img :src="formData.foto_url" class="h-16 w-16 rounded-full object-cover border border-gray-200" @error="e => e.target.style.display='none'" />
              </div>
              <p class="text-[10px] text-gray-400 mt-1">Jika tidak upload foto, akan tampil inisial nama secara otomatis.</p>
            </div>
          </template>

          <!-- FORM: DEMOGRAPHICS -->
          <template v-else-if="currentModalType === 'demographics'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Kategori Statistik <span class="text-red-500">*</span></label>
              <select v-model="formData.kategori" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                <option value="usia">Golongan Umur</option>
                <option value="jenis_kelamin">Jenis Kelamin</option>
                <option value="pendidikan">Tingkat Pendidikan</option>
                <option value="pekerjaan">Profesi / Pekerjaan</option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Label <span class="text-red-500">*</span></label>
              <input v-model="formData.label" type="text" required
                placeholder="cth: 0-1 tahun / Laki-laki / SD"
                class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Urutan Tampil</label>
              <input v-model="formData.urutan" type="number" min="0"
                placeholder="1, 2, 3, ..."
                class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p class="text-[10px] text-gray-400 mt-1">Angka lebih kecil tampil lebih dulu di chart.</p>
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah Jiwa <span class="text-red-500">*</span></label>
                <input v-model="formData.jumlah_jiwa" type="number" required
                  class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Persentase (%)</label>
                <input v-model="formData.persentase" type="number" step="0.01"
                  class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
            </div>
          </template>

          <!-- FORM: KEPENDUDUKAN PER DUSUN -->
          <template v-else-if="currentModalType === 'kependudukan'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Dusun <span class="text-red-500">*</span></label>
              <input v-model="formData.nama_dusun" type="text" required placeholder="cth: Dusun Bojongkopo (I)" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Urutan Tampil</label>
              <input v-model="formData.urutan" type="number" min="0" placeholder="1, 2, 3, ..." class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p class="text-[10px] text-gray-400 mt-1">Angka kecil tampil lebih dulu.</p>
            </div>
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Laki-laki <span class="text-red-500">*</span></label>
                <input v-model="formData.laki_laki" type="number" required min="0" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1">Perempuan <span class="text-red-500">*</span></label>
                <input v-model="formData.perempuan" type="number" required min="0" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Jumlah KK</label>
              <input v-model="formData.jumlah_kk" type="number" min="0" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Keterangan</label>
              <textarea v-model="formData.keterangan" rows="2" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM: FACILITIES -->
          <template v-else-if="currentModalType === 'facilities'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Potensi / Fasilitas <span class="text-red-500">*</span></label>
              <input v-model="formData.nama" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Kategori <span class="text-red-500">*</span></label>
              <select v-model="formData.kategori" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                <option value="potensi_desa">Potensi Ekonomi &amp; Dusun</option>
                <option value="wisata">Sarana Umum &amp; Wisata</option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Upload Foto</label>
              <input type="file" accept="image/*" @change="e => fileUpload = e.target.files[0]"
                class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p v-if="fileUpload" class="text-[10px] text-emerald-600 font-bold mt-1">✓ {{ fileUpload.name }}</p>
              <div v-if="formData.foto_url && !fileUpload" class="mt-2">
                <img :src="formData.foto_url" class="h-20 rounded-lg object-cover border border-gray-200" @error="e => e.target.style.display='none'" />
              </div>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Link Google Maps</label>
              <input v-model="formData.lokasi" type="text" placeholder="https://maps.app.goo.gl/..." class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
              <p class="text-[10px] text-gray-400 mt-1">Salin link dari Google Maps (Share → Copy Link).</p>
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Deskripsi Singkat</label>
              <textarea v-model="formData.deskripsi" rows="3" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- FORM: KATEGORI -->
          <template v-else-if="currentModalType === 'kategori'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Nama Kategori <span class="text-red-500">*</span></label>
              <input v-model="formData.nama" type="text" required placeholder="cth: Infrastruktur" class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Tipe Kategori <span class="text-red-500">*</span></label>
              <select v-model="formData.tipe" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs">
                <option value="">-- Pilih Tipe --</option>
                <option value="berita">Berita</option>
                <option value="produk">Produk</option>
                <option value="galeri">Galeri</option>
                <option value="pengumuman">Pengumuman</option>
              </select>
              <p class="text-[10px] text-gray-400 mt-1">Slug akan dibuat otomatis dari nama kategori.</p>
            </div>
          </template>

          <!-- FORM: FAQS -->
          <template v-else-if="currentModalType === 'faqs'">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Pertanyaan <span class="text-red-500">*</span></label>
              <input v-model="formData.question" type="text" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs" />
            </div>
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1">Jawaban Lengkap <span class="text-red-500">*</span></label>
              <textarea v-model="formData.answer" rows="3" required class="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs"></textarea>
            </div>
          </template>

          <!-- Modal Actions -->
          <div class="flex items-center gap-3 pt-4 border-t border-gray-100">
            <button type="button" @click="showModal = false" class="flex-1 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl transition-colors cursor-pointer">Batal</button>
            <button type="submit" class="flex-1 py-3 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-colors cursor-pointer">
              {{ isEditMode ? 'Simpan Perubahan' : 'Tambahkan' }}
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- GENERIC DETAIL MODAL -->
    <div v-if="detailItem" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div class="bg-white rounded-3xl max-w-lg w-full p-6 shadow-2xl border border-gray-100 relative max-h-[85vh] overflow-y-auto">
        <button @click="detailItem = null" class="absolute top-5 right-5 text-gray-400 hover:text-gray-600 cursor-pointer"><XIcon class="w-5 h-5" /></button>

        <img v-if="detailItem.image || detailItem.foto_url" :src="detailItem.image || detailItem.foto_url"
          class="w-full h-40 object-cover rounded-2xl mb-4 border border-gray-100" @error="handleFallbackImg" />

        <span class="inline-block px-2.5 py-1 bg-emerald-50 text-[#0D6847] text-[10px] font-bold rounded-lg mb-3 uppercase">
          {{ detailItem._type }}
        </span>

        <h3 class="text-lg font-black text-gray-900 mb-2">
          {{ detailItem.title || detailItem.name || detailItem.nama || detailItem.label || detailItem.nama_rt || detailItem.question }}
        </h3>

        <p class="text-xs text-gray-500 mb-3">
          {{ detailItem.date || detailItem.location || detailItem.tanggal_posting || '-' }}
        </p>

        <p class="text-xs text-gray-700 leading-relaxed whitespace-pre-line mb-3">
          {{ detailItem.content || detailItem.description || detailItem.deskripsi || detailItem.excerpt || detailItem.details || detailItem.answer || detailItem.keterangan || 'Tidak ada konten.' }}
        </p>

        <!-- Info tambahan produk -->
        <div v-if="detailItem._type === 'products'" class="mt-3 space-y-1 text-xs bg-gray-50 p-3 rounded-xl">
          <p><strong>Harga:</strong> {{ formatRupiah(detailItem.price) }}</p>
          <p><strong>Penjual:</strong> {{ detailItem.seller }}</p>
          <p><strong>WA:</strong> {{ detailItem.sellerPhone || '-' }}</p>
        </div>

        <!-- Info tambahan agenda -->
        <div v-if="detailItem._type === 'agenda'" class="mt-3 space-y-1 text-xs bg-gray-50 p-3 rounded-xl">
          <p><strong>Tanggal:</strong> {{ detailItem.date }}</p>
          <p><strong>Waktu:</strong> {{ detailItem.time }}</p>
          <p><strong>Lokasi:</strong> {{ detailItem.location }}</p>
          <p><strong>Status:</strong> <span class="capitalize">{{ detailItem.status }}</span></p>
        </div>

        <!-- Info tambahan kependudukan -->
        <div v-if="detailItem._type === 'kependudukan'" class="mt-3 grid grid-cols-2 gap-2 text-xs bg-gray-50 p-3 rounded-xl">
          <p><strong>Dusun:</strong> {{ detailItem.nama_dusun }}</p>
          <p><strong>Urutan:</strong> {{ detailItem.urutan }}</p>
          <p><strong>Laki-laki:</strong> {{ detailItem.laki_laki }}</p>
          <p><strong>Perempuan:</strong> {{ detailItem.perempuan }}</p>
          <p><strong>Total:</strong> {{ detailItem.total }}</p>
          <p><strong>KK:</strong> {{ detailItem.jumlah_kk }}</p>
        </div>

        <!-- Info tambahan potensi -->
        <div v-if="detailItem._type === 'facilities' && detailItem.lokasi" class="mt-3">
          <a :href="detailItem.lokasi" target="_blank" class="inline-flex items-center gap-2 px-3 py-2 bg-emerald-50 hover:bg-[#0D6847] text-[#0D6847] hover:text-white text-[11px] font-bold rounded-lg transition-colors">
            <MapPinIcon class="w-3.5 h-3.5" /><span>Buka di Google Maps</span>
          </a>
        </div>

        <!-- Info tambahan kategori -->
        <div v-if="detailItem._type === 'kategori'" class="mt-3 space-y-1 text-xs bg-gray-50 p-3 rounded-xl">
          <p><strong>Tipe:</strong> <span class="uppercase">{{ detailItem.tipe }}</span></p>
          <p><strong>Slug:</strong> <span class="font-mono">{{ detailItem.slug }}</span></p>
        </div>

        <div class="flex gap-3 mt-5 pt-4 border-t border-gray-100">
          <button @click="openEditModal(detailItem._type, detailItem); detailItem = null" class="flex-1 py-2.5 bg-blue-50 text-blue-600 text-xs font-bold rounded-xl cursor-pointer flex items-center justify-center gap-2">
            <PencilIcon class="w-3.5 h-3.5" /> Edit
          </button>
          <button @click="confirmDelete(detailItem._type, detailItem.id, detailItem.title || detailItem.name || detailItem.nama); detailItem = null" class="flex-1 py-2.5 bg-red-50 text-red-600 text-xs font-bold rounded-xl cursor-pointer flex items-center justify-center gap-2">
            <Trash2Icon class="w-3.5 h-3.5" /> Hapus
          </button>
        </div>
      </div>
    </div>

    <!-- DELETE CONFIRMATION -->
    <div v-if="deleteTarget" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
      <div class="bg-white rounded-3xl max-w-sm w-full p-6 text-center shadow-2xl border border-gray-100 space-y-4">
        <div class="w-12 h-12 rounded-2xl bg-red-50 text-red-600 flex items-center justify-center mx-auto"><AlertCircleIcon class="w-6 h-6" /></div>
        <div>
          <h3 class="text-base font-extrabold text-gray-900">Konfirmasi Hapus Data</h3>
          <p class="text-xs text-gray-500 mt-1">Hapus <strong>"{{ deleteTarget.name }}"</strong>? Tindakan ini tidak dapat dibatalkan.</p>
        </div>
        <div class="flex items-center gap-3">
          <button @click="deleteTarget = null" class="flex-1 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl cursor-pointer">Batal</button>
          <button @click="executeDelete" class="flex-1 py-2.5 bg-red-600 hover:bg-red-700 text-white text-xs font-bold rounded-xl cursor-pointer">Hapus</button>
        </div>
      </div>
    </div>

    <!-- TOAST -->
    <div v-if="toastMessage" class="fixed bottom-6 right-6 z-50 bg-gray-900 text-white px-5 py-3 rounded-2xl shadow-2xl border border-gray-800 flex items-center gap-3 animate-fade-in text-xs font-bold">
      <CheckCircle2Icon class="w-5 h-5 text-emerald-400" />
      <span>{{ toastMessage }}</span>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import {
  ShieldCheck as ShieldCheckIcon, ExternalLink as ExternalLinkIcon,
  LogOut as LogOutIcon, LayoutDashboard as LayoutDashboardIcon,
  Newspaper as NewspaperIcon, ShoppingBag as ShoppingBagIcon,
  Image as ImageIcon, Users as UsersIcon, HelpCircle as HelpCircleIcon,
  Mail as MailIcon, Plus as PlusIcon, Pencil as PencilIcon,
  Trash2 as Trash2Icon, X as XIcon, AlertCircle as AlertCircleIcon,
  CheckCircle2 as CheckCircle2Icon, Sparkles as SparklesIcon,
  MessageSquare as MessageSquareIcon, PieChart as PieChartIcon,
  MapPin as MapPinIcon, Calendar as CalendarIcon, Bell as BellIcon, Tags as TagsIcon,
  Building2 as Building2Icon, Eye as EyeIcon
} from 'lucide-vue-next';
import { store } from '../../store';

const emit = defineEmits(['navigate']);

const activeTab = ref('overview');

const menuItems = computed(() => [
  { id: 'overview', label: 'Ringkasan Dashboard', icon: LayoutDashboardIcon },
  { id: 'news', label: 'Berita & Informasi', icon: NewspaperIcon, count: store.news.length },
  { id: 'products', label: 'Produk UMKM', icon: ShoppingBagIcon, count: store.products.length },
  { id: 'gallery', label: 'Galeri Foto & Video', icon: ImageIcon, count: store.gallery.length },
  { id: 'agenda', label: 'Agenda Kegiatan', icon: CalendarIcon, count: store.agenda.length },
  { id: 'pengumuman', label: 'Pengumuman', icon: BellIcon, count: store.pengumuman.length },
  { id: 'leaders', label: 'Tokoh & Perangkat', icon: UsersIcon, count: store.leaders.length },
  { id: 'demographics', label: 'Statistik Kependudukan', icon: PieChartIcon, count: store.demographics.length },
  { id: 'kependudukan', label: 'Kependudukan per Dusun', icon: UsersIcon, count: store.kependudukanDusun.length },
  { id: 'facilities', label: 'Potensi & Fasilitas', icon: MapPinIcon, count: store.facilities.length },
  { id: 'faqs', label: 'Tanya Jawab (FAQ)', icon: HelpCircleIcon, count: store.faqs.length },
  { id: 'kategori', label: 'Master Kategori', icon: TagsIcon, count: store.categories.length }, // <-- TAMBAH
  { id: 'profile', label: 'Profil Padukuhan', icon: Building2Icon },
  { id: 'inbox', label: 'Pesan Masuk', icon: MailIcon, count: store.inbox.length },
]);

const kategoriFilter = ref('semua');

const filteredKategori = computed(() => {
  if (kategoriFilter.value === 'semua') return store.categories;
  return store.categories.filter(c => c.tipe === kategoriFilter.value);
});

const demografiFilter = ref('semua');

const filteredDemografi = computed(() => {
  let list = [...store.demographics];
  if (demografiFilter.value !== 'semua') {
    list = list.filter(d => d.kategori === demografiFilter.value);
  }
  return list.sort((a, b) => (a.urutan || 0) - (b.urutan || 0));
});

const overviewCards = computed(() => [
  { tab: 'news', label: 'Berita', icon: NewspaperIcon, color: 'text-emerald-600', count: store.news.length, sub: 'Artikel Terbit' },
  { tab: 'products', label: 'Produk', icon: ShoppingBagIcon, color: 'text-blue-600', count: store.products.length, sub: 'UMKM Terdaftar' },
  { tab: 'gallery', label: 'Galeri', icon: ImageIcon, color: 'text-purple-600', count: store.gallery.length, sub: 'Foto & Video' },
  { tab: 'inbox', label: 'Pesan', icon: MailIcon, color: 'text-amber-600', count: store.inbox.length, sub: 'Pesan Masuk' },
]);

const quickActions = [
  { type: 'kategori', label: 'Tambah Kategori', sub: 'Kelola master kategori', icon: TagsIcon, bg: 'bg-indigo-50/70 hover:bg-indigo-100/70 border-indigo-100', iconColor: 'text-indigo-600' },
  { type: 'news', label: 'Tambah Berita', sub: 'Publikasi kabar desa', icon: NewspaperIcon, bg: 'bg-emerald-50/70 hover:bg-emerald-100/70 border-emerald-100', iconColor: 'text-[#0D6847]' },
  { type: 'products', label: 'Tambah Produk', sub: 'Daftarkan produk warga', icon: ShoppingBagIcon, bg: 'bg-blue-50/70 hover:bg-blue-100/70 border-blue-100', iconColor: 'text-blue-600' },
  { type: 'agenda', label: 'Tambah Agenda', sub: 'Jadwalkan kegiatan', icon: CalendarIcon, bg: 'bg-amber-50/70 hover:bg-amber-100/70 border-amber-100', iconColor: 'text-amber-600' },
  { type: 'pengumuman', label: 'Tambah Pengumuman', sub: 'Info penting desa', icon: BellIcon, bg: 'bg-red-50/70 hover:bg-red-100/70 border-red-100', iconColor: 'text-red-600' },
  { type: 'gallery', label: 'Tambah Galeri', sub: 'Upload foto dokumentasi', icon: ImageIcon, bg: 'bg-purple-50/70 hover:bg-purple-100/70 border-purple-100', iconColor: 'text-purple-600' },
  { type: 'kependudukan', label: 'Tambah Data RT', sub: 'Kependudukan per Dusun', icon: UsersIcon, bg: 'bg-teal-50/70 hover:bg-teal-100/70 border-teal-100', iconColor: 'text-teal-600' },
];

const sortedNews = computed(() =>
  [...store.news].sort((a, b) => new Date(b.created_at || b.date) - new Date(a.created_at || a.date))
);

// Modal State
const showModal = ref(false);
const isEditMode = ref(false);
const currentModalType = ref('news');
const formData = ref({});
const fileUpload = ref(null);
const profileFileUpload = ref(null);
const editingId = ref(null);  // <-- TAMBAH INI
const toastMessage = ref('');
const deleteTarget = ref(null);
const detailItem = ref(null);

const modalTypeLabel = computed(() => {
  const labels = {
    news: 'Berita & Informasi', products: 'Produk UMKM', gallery: 'Galeri Foto',
    agenda: 'Agenda Kegiatan', pengumuman: 'Pengumuman', leaders: 'Tokoh & Perangkat',
    demographics: 'Statistik Demografi', kependudukan: 'Kependudukan per Dusun',
    facilities: 'Potensi & Fasilitas', faqs: 'FAQ', kategori: 'Master Kategori'
  };
  return labels[currentModalType.value] || currentModalType.value;
});

const triggerToast = (msg) => {
  toastMessage.value = msg;
  setTimeout(() => { toastMessage.value = ''; }, 3000);
};

const formatRupiah = (val) => new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR', maximumFractionDigits: 0 }).format(val || 0);

const handleFallbackImg = (e) => { e.target.src = '/images/hero-bg.png'; };

const handleLogout = () => {
  store.logout();
  emit('navigate', 'beranda');
};

// Profile Form
const profileForm = ref({
  nama_padukuhan: '', kecamatan: '', kabupaten: '', provinsi: '', kode_pos: '',
  luas_wilayah: '', jumlah_penduduk: '', jumlah_kk: '', jumlah_rt: '', jumlah_rw: '', jumlah_dusun: '',
  batas_utara: '', batas_selatan: '', batas_timur: '', batas_barat: '',
  nama_dukuh: '', sambutan_dukuh: '', cita_cita: '',
  foto_dukuh: '', sejarah: '', telepon: '', email: '', alamat_kantor: '', maps_embed: ''
});

watch(() => store.padukuhanProfile, (profile) => {
  if (profile) Object.assign(profileForm.value, profile);
}, { immediate: true });

const savePadukuhanProfile = async () => {
  await store.updatePadukuhanProfile(profileForm.value, profileFileUpload.value);
  profileFileUpload.value = null;
  triggerToast('Profil padukuhan berhasil disimpan!');
};

// Open modal helpers
const openAddModal = (type) => {
  isEditMode.value = false;
  currentModalType.value = type;
  fileUpload.value = null;
  editingId.value = null; // <-- RESET ID
  const base = { status: 'mendatang', type: 'foto', kategori: 'potensi_desa' };
  if (type === 'agenda') base.date = new Date().toISOString().split('T')[0];
  if (type === 'pengumuman') base.tanggal_posting = new Date().toISOString().split('T')[0];
  if (type === 'leaders') base.urutan = 1;
  formData.value = base;
  showModal.value = true;
  if (type !== 'overview') activeTab.value = type;
};

const openEditModal = (type, item) => {
  // Validasi: harus ada id
  if (!item || item.id === undefined || item.id === null) {
    console.error('[openEditModal] Item tidak memiliki id:', item);
    alert('Error: Data tidak memiliki ID. Silakan refresh halaman.');
    return;
  }

  isEditMode.value = true;
  currentModalType.value = type;
  fileUpload.value = null;
  editingId.value = item.id; // <-- SIMPAN ID DI VARIABEL TERPISAH
  const copy = { ...item };

  // Khusus agenda: pastikan date format YYYY-MM-DD dan pecah time
  if (type === 'agenda') {
    const rawDate = item.date || item.tanggal_kegiatan;
    if (rawDate) {
      const d = new Date(rawDate);
      if (!isNaN(d.getTime())) {
        copy.date = d.toISOString().split('T')[0];
      }
    }
    if (item.time && item.time.includes('-')) {
      const parts = item.time.split('-').map(s => s.trim().split(' ')[0]);
      copy.time_start = parts[0] || '';
      copy.time_end = parts[1] || '';
    }
  }

  // Khusus pengumuman
  if (type === 'pengumuman') {
    const rawDate = item.tanggal_posting || item.date;
    if (rawDate) {
      const d = new Date(rawDate);
      if (!isNaN(d.getTime())) {
        copy.tanggal_posting = d.toISOString().split('T')[0];
      }
    }
  }

  formData.value = copy;
  showModal.value = true;
};

const openDetailView = (type, item) => {
  detailItem.value = { ...item, _type: type };
};

const saveModalData = async () => {
  const type = currentModalType.value;
  const editMode = isEditMode.value;
  const id = editingId.value; // <-- AMBIL DARI editingId, BUKAN formData.value.id

  try {
    // Khusus agenda: gabungkan time_start & time_end
    if (type === 'agenda') {
      formData.value.time = `${formData.value.time_start || '08:00'} - ${formData.value.time_end || 'selesai'}`;
    }

    // Validasi: jika edit mode, id harus ada
    if (editMode && !id) {
      alert('Error: ID data tidak ditemukan. Silakan tutup modal dan klik Edit ulang.');
      return;
    }

    // Log untuk debugging
    console.log(`[saveModalData] mode=${editMode ? 'EDIT' : 'ADD'}, type=${type}, id=${id}`);

    if (editMode) {
      // ==================== UPDATE ====================
      switch (type) {
        case 'news':
          await store.updateNews(id, formData.value, fileUpload.value);
          break;
        case 'products':
          await store.updateProduct(id, formData.value, fileUpload.value);
          break;
        case 'gallery':
          await store.updateGallery(id, formData.value, fileUpload.value);
          break;
        case 'agenda':
          await store.updateAgenda(id, formData.value);
          break;
        case 'pengumuman':
          await store.updatePengumuman(id, formData.value);
          break;
        case 'leaders':
          await store.updateLeader(id, formData.value, fileUpload.value);
          break;
        case 'faqs':
          await store.updateFaq(id, formData.value);
          break;
        case 'demographics':
          await store.updateDemographic(id, formData.value);
          break;
        case 'kependudukan':
          await store.updateKependudukan(id, formData.value);
          break;
        case 'facilities':
          await store.updatePotensi(id, formData.value, fileUpload.value);
          break;
        case 'kategori':
          await store.updateKategori(id, formData.value);
          break;
        default:
          console.warn('Unknown edit type:', type);
          return;
      }
      triggerToast('Data berhasil diperbarui!');
    } else {
      // ==================== ADD ====================
      switch (type) {
        case 'news':
          await store.addNews(formData.value, fileUpload.value);
          break;
        case 'products':
          await store.addProduct(formData.value, fileUpload.value);
          break;
        case 'gallery':
          await store.addGallery(formData.value, fileUpload.value);
          break;
        case 'agenda':
          await store.addAgenda(formData.value);
          break;
        case 'pengumuman':
          await store.addPengumuman(formData.value);
          break;
        case 'leaders':
          await store.addLeader(formData.value, fileUpload.value);
          break;
        case 'faqs':
          await store.addFaq(formData.value);
          break;
        case 'demographics':
          await store.addDemographic(formData.value);
          break;
        case 'kependudukan':
          await store.addKependudukan(formData.value);
          break;
        case 'facilities':
          await store.addPotensi(formData.value, fileUpload.value);
          break;
        case 'kategori':
          await store.addKategori(formData.value);
          break;
        default:
          console.warn('Unknown add type:', type);
          return;
      }
      triggerToast('Data baru berhasil ditambahkan!');
    }

    // Reset state
    fileUpload.value = null;
    editingId.value = null;
    showModal.value = false;
  } catch (e) {
    console.error('[saveModalData] Error:', e);
    alert('Gagal menyimpan data: ' + e.message);
  }
};

const confirmDelete = (type, id, name) => {
  deleteTarget.value = { type, id, name };
};

const executeDelete = async () => {
  if (!deleteTarget.value) return;
  const { type, id, name } = deleteTarget.value;
  try {
    if (type === 'news') await store.deleteNews(id);
    else if (type === 'products') await store.deleteProduct(id);
    else if (type === 'gallery') await store.deleteGallery(id);
    else if (type === 'agenda') await store.deleteAgenda(id);
    else if (type === 'pengumuman') await store.deletePengumuman(id);
    else if (type === 'leaders') await store.deleteLeader(id);
    else if (type === 'kategori') await store.deleteKategori(id);
    else if (type === 'faqs') await store.deleteFaq(id);
    else if (type === 'inbox') await store.deleteInbox(id);
    else if (type === 'demographics') await store.deleteDemographic(id);
    else if (type === 'kependudukan') await store.deleteKependudukan(id);
    else if (type === 'facilities') await store.deletePotensi(id);
    triggerToast(`Data "${name || 'terpilih'}" berhasil dihapus.`);
  } catch (e) { console.error(e); }
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