<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative min-h-[500px] md:min-h-[580px] flex items-center justify-center overflow-hidden bg-gray-900 text-white">
      <!-- Background Image with Overlay -->
      <div class="absolute inset-0 z-0">
        <img 
          src="/images/hero-bg.png" 
          alt="Latar Belakang Profil" 
          class="w-full h-full object-cover object-center opacity-65 scale-105"
          @error="handleImageError($event, 'hero-bg')"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-900/60 to-gray-950/40"></div>
      </div>

      <!-- Hero Content -->
      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center py-20">
        <h2 class="text-4xl md:text-5xl font-extrabold tracking-tight leading-tight mb-6">
          Profil Padukuhan <br/>
          <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-200">Ngemplak Kalangan</span>
        </h2>
        <p class="text-sm md:text-base text-gray-200 max-w-2xl mx-auto leading-relaxed mb-8">
          Selamat datang di halaman resmi Padukuhan Ngemplak Kalangan. Kami berkomitmen memberikan transparansi informasi dan pelayanan prima bagi seluruh masyarakat.
        </p>

        <!-- CTA Button -->
        <button 
          @click="scrollToSection('sambutan')" 
          class="inline-flex items-center gap-2 px-7 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white font-bold rounded-xl shadow-lg hover:shadow-emerald-900/30 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 cursor-pointer"
        >
          <span>Lebih Dekat Dengan Kami</span>
          <ArrowRightIcon class="w-4 h-4" />
        </button>
      </div>
    </section>

    <!-- SAMBUTAN DUKUH SECTION -->
    <section id="sambutan" class="py-16 md:py-24 bg-white scroll-mt-20">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
          
          <!-- Image Column (5 cols) -->
          <div class="lg:col-span-5 flex justify-center">
            <div class="w-full max-w-sm bg-white rounded-3xl p-4 shadow-xl shadow-gray-200/50 border border-gray-100/80 group hover:-translate-y-1 transition-all duration-300">
              <div class="relative overflow-hidden aspect-[4/5] rounded-2xl bg-gray-50 border border-gray-100">
                <img 
                  :src="store.padukuhanProfile?.foto_dukuh || '/images/kepala-desa.png'" 
                  :alt="store.padukuhanProfile?.nama_dukuh || 'Bapak Supriyanto'" 
                  class="w-full h-full object-cover object-top group-hover:scale-103 transition-transform duration-500"
                  @error="handleImageError($event, 'kepala-desa')"
                />
              </div>
              <div class="pt-5 pb-2 text-center">
                <h3 class="text-xl font-extrabold text-gray-900 leading-tight">{{ store.padukuhanProfile?.nama_dukuh || 'Kepala Dukuh' }}</h3>
                <p class="text-xs font-bold text-gray-400 uppercase tracking-widest mt-1">Kepala Dukuh {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}</p>
              </div>
            </div>
          </div>

          <!-- Text Column (7 cols) -->
          <div class="lg:col-span-7 space-y-6">
            <div class="inline-flex items-center gap-2 text-xs font-bold text-[#0D6847] uppercase tracking-wider bg-emerald-50 px-3.5 py-1.5 rounded-full border border-emerald-100">
              <MapPinIcon class="w-3.5 h-3.5" />
              <span>Sekilas Wilayah</span>
            </div>
            
            <h2 class="text-3xl md:text-4xl font-extrabold text-gray-950 leading-tight">
              Sejarah & Profil Padukuhan
            </h2>
            
            <div class="space-y-4 text-sm text-gray-600 leading-relaxed font-medium">
              <p v-if="store.padukuhanProfile?.sejarah" class="whitespace-pre-line">{{ store.padukuhanProfile.sejarah }}</p>
              <p v-else>
                Padukuhan Ngemplak Kalangan merupakan wilayah administratif yang kaya akan nilai historis, kebudayaan luhur, dan kebersamaan warga yang erat. Terletak di kawasan strategis Sleman, Yogyakarta, padukuhan kami terus berkembang dengan memadukan kearifan lokal pertanian dan kemajuan teknologi modern.
              </p>
            </div>

            <!-- Quote Box -->
            <div class="relative bg-emerald-50/70 border-l-4 border-[#0D6847] p-6 rounded-r-2xl">
              <span class="absolute top-2 left-2 text-6xl text-emerald-200/50 font-serif leading-none select-none pointer-events-none">“</span>
              <p class="text-sm italic font-semibold text-gray-700 leading-relaxed pl-6 relative z-10 whitespace-pre-line">
                {{ store.padukuhanProfile?.sambutan_dukuh || 'Kita harus berjalan bersama, mengawinkan tradisi leluhur dengan pemanfaatan teknologi digital untuk kesejahteraan dan kemandirian warga Ngemplak Kalangan.' }}
              </p>
            </div>
          </div>

        </div>
      </div>
    </section>

    <!-- ============================================================ -->
    <!-- INFORMASI GEOGRAFIS & ADMINISTRATIF                          -->
    <!-- ============================================================ -->
    <section class="py-16 md:py-20 bg-white border-t border-gray-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Kondisi Geografis (Alamat & Email masuk di sini) -->
        <div class="mb-12">
          <h2 class="text-3xl md:text-4xl font-extrabold text-[#0D6847] mb-6">Kondisi Geografis</h2>
          <div class="space-y-4 text-sm md:text-base text-gray-600 leading-relaxed">
            <p>{{ kondisiGeografis }}</p>
            <p>
              Padukuhan {{ store.padukuhanProfile?.nama_padukuhan || 'Ngemplak Kalangan' }}
              memiliki luas wilayah
              <strong class="font-bold text-gray-900">{{ store.padukuhanProfile?.luas_wilayah || '-' }}</strong>
              dengan iklim kemarau dan penghujan. Wilayahnya terbagi dalam
              <strong class="font-bold text-gray-900">{{ store.padukuhanProfile?.jumlah_dusun || '-' }}</strong> dusun.
            </p>
            <!-- Alamat & Email jadi bagian dari Kondisi Geografis -->
            <p>
              <strong class="font-bold text-gray-900">Alamat:</strong>
              {{ store.padukuhanProfile?.alamat_kantor || '-' }}
            </p>
          </div>
        </div>

        <!-- Grid: Kecamatan, Kabupaten, Provinsi, Kode Pos -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-12 gap-y-0 mb-14">
          <div class="flex items-center justify-between py-4 border-b border-gray-200">
            <span class="text-sm font-bold text-gray-900">Kecamatan</span>
            <span class="text-sm text-gray-500">{{ store.padukuhanProfile?.kecamatan || '-' }}</span>
          </div>
          <div class="flex items-center justify-between py-4 border-b border-gray-200">
            <span class="text-sm font-bold text-gray-900">Kabupaten</span>
            <span class="text-sm text-gray-500">{{ store.padukuhanProfile?.kabupaten || '-' }}</span>
          </div>
          <div class="flex items-center justify-between py-4 border-b border-gray-200">
            <span class="text-sm font-bold text-gray-900">Provinsi</span>
            <span class="text-sm text-gray-500">{{ store.padukuhanProfile?.provinsi || '-' }}</span>
          </div>
          <div class="flex items-center justify-between py-4 border-b border-gray-200">
            <span class="text-sm font-bold text-gray-900">Kode Pos</span>
            <span class="text-sm text-gray-500">{{ store.padukuhanProfile?.kode_pos || '-' }}</span>
          </div>
        </div>

        <!-- Batas Wilayah -->
        <div>
          <h3 class="text-2xl md:text-3xl font-extrabold text-[#0D6847] mb-6">Batas Wilayah</h3>
          <ul class="space-y-3">
            <li class="flex items-start gap-3 text-sm md:text-base text-gray-700">
              <span class="text-gray-400 shrink-0 mt-1.5">•</span>
              <span><strong class="font-bold text-gray-900">Utara:</strong> {{ store.padukuhanProfile?.batas_utara || '-' }}</span>
            </li>
            <li class="flex items-start gap-3 text-sm md:text-base text-gray-700">
              <span class="text-gray-400 shrink-0 mt-1.5">•</span>
              <span><strong class="font-bold text-gray-900">Selatan:</strong> {{ store.padukuhanProfile?.batas_selatan || '-' }}</span>
            </li>
            <li class="flex items-start gap-3 text-sm md:text-base text-gray-700">
              <span class="text-gray-400 shrink-0 mt-1.5">•</span>
              <span><strong class="font-bold text-gray-900">Timur:</strong> {{ store.padukuhanProfile?.batas_timur || '-' }}</span>
            </li>
            <li class="flex items-start gap-3 text-sm md:text-base text-gray-700">
              <span class="text-gray-400 shrink-0 mt-1.5">•</span>
              <span><strong class="font-bold text-gray-900">Barat:</strong> {{ store.padukuhanProfile?.batas_barat || '-' }}</span>
            </li>
          </ul>
        </div>

      </div>
    </section>

    <!-- CITA-CITA PADUKUHAN (VISION & MISSION) -->
    <section class="py-16 bg-[#F8FAFC] border-t border-b border-gray-100">
      <div class="max-w-4xl mx-auto px-4 text-center">
        <div class="inline-flex items-center justify-center w-12 h-12 rounded-2xl bg-emerald-50 border border-emerald-100 text-[#0D6847] mb-6">
          <AwardIcon class="w-6 h-6 animate-pulse" />
        </div>
        <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950 mb-3">Cita-Cita Padukuhan</h2>

        <!-- Vision Card Box -->
        <div class="bg-white rounded-3xl p-8 md:p-10 shadow-xl shadow-gray-200/40 border border-gray-100 relative overflow-hidden group hover:shadow-2xl transition-all duration-300">
          <div class="absolute -right-16 -top-16 w-36 h-36 bg-[#0D6847]/5 rounded-full group-hover:scale-110 transition-transform duration-500"></div>
          <div class="absolute -left-16 -bottom-16 w-36 h-36 bg-[#0D6847]/5 rounded-full group-hover:scale-110 transition-transform duration-500"></div>
          
          <div class="relative z-10 flex flex-col items-center">
            <span class="inline-block text-[10px] font-extrabold text-[#0D6847] bg-[#0D6847]/10 px-4 py-1.5 rounded-full uppercase tracking-wider mb-5">
              Padukuhan Ngemplak Kalangan
            </span>
            <p class="text-lg md:text-2xl font-bold text-gray-800 leading-relaxed max-w-2xl whitespace-pre-line text-center">
              "{{ store.padukuhanProfile?.cita_cita || 'Mewujudkan Padukuhan yang mandiri, aman, dan berbudaya dengan pelayanan prima berbasis teknologi untuk kesejahteraan masyarakat.' }}"
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- STATISTIK KEPENDUDUKAN SECTION -->
    <section class="pt-16 md:pt-24 pb-4 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center max-w-2xl mx-auto mb-16">
          <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Statistik Kependudukan</h2>
          <p class="text-sm text-gray-500 mt-2 leading-relaxed">
            Data kependudukan Padukuhan Ngemplak Kalangan yang diperbarui secara berkala dan transparan.
          </p>
        </div>

        <!-- Population Table -->
        <!-- PENDUDUK PER DUSUN -->
        <section class="pt-4 pb-16 md:pb-24 bg-white">
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

            <div class="mb-10">
              <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Penduduk per Dusun</h2>
              <p class="text-sm text-gray-500 mt-2">
                Data kependudukan terbaru per dusun di Padukuhan Ngemplak Kalangan.
              </p>
            </div>

            <!-- Legend -->
            <div class="flex items-center gap-6 mb-8">
              <div class="flex items-center gap-2">
                <span class="w-3 h-3 rounded-full bg-cyan-700"></span>
                <span class="text-xs font-bold text-gray-700">Laki-laki</span>
              </div>
              <div class="flex items-center gap-2">
                <span class="w-3 h-3 rounded-full bg-green-700"></span>
                <span class="text-xs font-bold text-gray-700">Perempuan</span>
              </div>
            </div>

            <!-- List per Dusun -->
            <div class="space-y-10">
              <div v-for="dusun in store.kependudukanDusun" :key="dusun.id" class="space-y-4">

                <!-- Header dusun -->
                <div class="flex flex-col sm:flex-row sm:items-baseline sm:justify-between gap-1">
                  <h3 class="text-base sm:text-lg font-extrabold text-gray-900">
                    {{ dusun.nama_dusun }}
                  </h3>
                  <p class="text-xs sm:text-sm font-bold text-gray-500">
                    {{ formatAngka(dusun.total) }} jiwa • {{ formatAngka(dusun.jumlah_kk) }} KK
                  </p>
                </div>

                <!-- Bar Laki-laki -->
                <div class="flex items-center gap-3">
                  <div class="flex-1 h-7 bg-gray-100 rounded-md overflow-hidden">
                    <div
                      class="h-full bg-cyan-700 rounded-md flex items-center justify-end pr-3 transition-all duration-700"
                      :style="{ width: getBarWidth(dusun.laki_laki) }"
                    >
                      <span class="text-xs font-extrabold text-white whitespace-nowrap">
                        {{ formatAngka(dusun.laki_laki) }}
                      </span>
                    </div>
                  </div>
                </div>

                <!-- Bar Perempuan -->
                <div class="flex items-center gap-3">
                  <div class="flex-1 h-7 bg-gray-100 rounded-md overflow-hidden">
                    <div
                      class="h-full bg-green-700 rounded-md flex items-center justify-end pr-3 transition-all duration-700"
                      :style="{ width: getBarWidth(dusun.perempuan) }"
                    >
                      <span class="text-xs font-extrabold text-white whitespace-nowrap">
                        {{ formatAngka(dusun.perempuan) }}
                      </span>
                    </div>
                  </div>
                </div>

              </div>

              <!-- Empty state -->
              <div v-if="store.kependudukanDusun.length === 0" class="text-center py-12 bg-gray-50 rounded-2xl border border-gray-200">
                <p class="text-sm text-gray-400">Belum ada data kependudukan per dusun.</p>
              </div>
            </div>

          </div>
        </section>

        <!-- GOLONGAN UMUR -->
        <div v-if="golonganUmur.length > 0" class="mb-16 bg-[#F8FAFC] rounded-3xl p-6 sm:p-8 border border-gray-200">
          <h3 class="text-xl sm:text-2xl font-extrabold text-[#0F4C5C] mb-8">Golongan Umur</h3>

          <div class="space-y-5">
            <div v-for="item in golonganUmur" :key="item.id" class="grid grid-cols-12 gap-4 items-center">
              <!-- Label -->
              <div class="col-span-12 sm:col-span-3 md:col-span-2 text-sm font-semibold text-gray-700">
                {{ item.label }}
              </div>

              <!-- Bar -->
              <div class="col-span-9 sm:col-span-7 md:col-span-8">
                <div class="w-full h-6 bg-gray-200/70 rounded-lg overflow-hidden">
                  <div
                    class="h-full bg-[#1B8A9C] rounded-lg transition-all duration-700"
                    :style="{ width: getBarWidths(item.jumlah_jiwa) }"
                  ></div>
                </div>
              </div>

              <!-- Nilai -->
              <div class="col-span-3 sm:col-span-2 md:col-span-2 text-right text-sm font-extrabold text-gray-900">
                {{ formatAngka(item.jumlah_jiwa) }}
              </div>
            </div>
          </div>
        </div>

        <!-- JENIS KELAMIN -->
        <div v-if="jenisKelamin.length > 0" class="mb-16 bg-[#F8FAFC] rounded-3xl p-6 sm:p-8 border border-gray-200">
          <h3 class="text-xl sm:text-2xl font-extrabold text-[#0F4C5C] mb-8">Jenis Kelamin</h3>
          <div class="space-y-5">
            <div v-for="item in jenisKelamin" :key="item.id" class="grid grid-cols-12 gap-4 items-center">
              <div class="col-span-12 sm:col-span-3 md:col-span-2 text-sm font-semibold text-gray-700">{{ item.label }}</div>
              <div class="col-span-9 sm:col-span-7 md:col-span-8">
                <div class="w-full h-6 bg-gray-200/70 rounded-lg overflow-hidden">
                  <div class="h-full bg-[#1B8A9C] rounded-lg transition-all duration-700" :style="{ width: getBarWidths(item.jumlah_jiwa) }"></div>
                </div>
              </div>
              <div class="col-span-3 sm:col-span-2 md:col-span-2 text-right text-sm font-extrabold text-gray-900">
                {{ formatAngka(item.jumlah_jiwa) }}
              </div>
            </div>
          </div>
        </div>

        <!-- PENDIDIKAN -->
        <div v-if="pendidikan.length > 0" class="mb-16 bg-[#F8FAFC] rounded-3xl p-6 sm:p-8 border border-gray-200">
          <h3 class="text-xl sm:text-2xl font-extrabold text-[#0F4C5C] mb-8">Tingkat Pendidikan</h3>
          <div class="space-y-5">
            <div v-for="item in pendidikan" :key="item.id" class="grid grid-cols-12 gap-4 items-center">
              <div class="col-span-12 sm:col-span-3 md:col-span-2 text-sm font-semibold text-gray-700">{{ item.label }}</div>
              <div class="col-span-9 sm:col-span-7 md:col-span-8">
                <div class="w-full h-6 bg-gray-200/70 rounded-lg overflow-hidden">
                  <div class="h-full bg-[#1B8A9C] rounded-lg transition-all duration-700" :style="{ width: getBarWidths(item.jumlah_jiwa) }"></div>
                </div>
              </div>
              <div class="col-span-3 sm:col-span-2 md:col-span-2 text-right text-sm font-extrabold text-gray-900">
                {{ formatAngka(item.jumlah_jiwa) }}
              </div>
            </div>
          </div>
        </div>

        <!-- PEKERJAAN -->
        <div v-if="pekerjaan.length > 0" class="mb-16 bg-[#F8FAFC] rounded-3xl p-6 sm:p-8 border border-gray-200">
          <h3 class="text-xl sm:text-2xl font-extrabold text-[#0F4C5C] mb-8">Mata Pencaharian</h3>
          <div class="space-y-5">
            <div v-for="item in pekerjaan" :key="item.id" class="grid grid-cols-12 gap-4 items-center">
              <div class="col-span-12 sm:col-span-3 md:col-span-2 text-sm font-semibold text-gray-700">{{ item.label }}</div>
              <div class="col-span-9 sm:col-span-7 md:col-span-8">
                <div class="w-full h-6 bg-gray-200/70 rounded-lg overflow-hidden">
                  <div class="h-full bg-[#1B8A9C] rounded-lg transition-all duration-700" :style="{ width: getBarWidths(item.jumlah_jiwa) }"></div>
                </div>
              </div>
              <div class="col-span-3 sm:col-span-2 md:col-span-2 text-right text-sm font-extrabold text-gray-900">
                {{ formatAngka(item.jumlah_jiwa) }}
              </div>
            </div>
          </div>
        </div>

        <!-- Empty state -->
        <div v-if="store.demographics.length === 0" class="text-center py-12 bg-gray-50 rounded-2xl border border-gray-200">
          <p class="text-sm text-gray-400">Belum ada data statistik kependudukan.</p>
        </div>

      </div>
    </section>

<!-- STRUKTUR ORGANISASI PADUKUHAN -->
<section v-if="store.leaders.length > 0" class="space-y-8 pt-12 border-t border-gray-100">
  <div class="text-center max-w-2xl mx-auto space-y-2">
    <h3 class="text-2xl md:text-3xl font-extrabold text-gray-950">Struktur Organisasi Padukuhan</h3>
    <p class="text-sm text-gray-500 font-medium">
      Perangkat Padukuhan Ngemplak Kalangan yang siap melayani masyarakat.
    </p>
    <div class="w-12 h-1 bg-[#0D6847] mx-auto rounded-full mt-3"></div>
  </div>

  <!-- Hierarki Struktur -->
  <div class="flex flex-col items-center gap-0">

    <!-- LEVEL 1: Kepala Desa (Kartu Besar) -->
    <div v-if="topLeader" class="relative bg-white rounded-3xl p-8 border border-gray-200 shadow-sm w-full max-w-sm text-center flex flex-col items-center hover:shadow-lg transition-shadow">
      <!-- Avatar -->
      <div class="w-28 h-28 rounded-full overflow-hidden border-4 border-white shadow-md bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center mb-5">
        <img v-if="topLeader.image" :src="topLeader.image" :alt="topLeader.name" class="w-full h-full object-cover" @error="handleImageError($event, 'leaders')" />
        <span v-else class="text-3xl font-extrabold text-[#1B8A9C]">{{ topLeader.initials }}</span>
      </div>
      <!-- Badge Jabatan -->
      <span class="inline-block px-4 py-1 bg-[#1B4E5F] text-white text-[10px] font-bold uppercase tracking-widest rounded-full mb-3">
        {{ topLeader.role }}
      </span>
      <!-- Nama -->
      <h4 class="text-2xl font-extrabold text-gray-950 leading-tight">{{ topLeader.name }}</h4>
      <p class="text-xs text-gray-500 font-semibold mt-1">Pemimpin penyelenggaraan pemerintahan desa</p>
    </div>

    <!-- Garis vertikal 1 -->
    <div class="w-px h-10 bg-gray-300"></div>

    <!-- LEVEL 2: Sekretaris Desa (Kartu Sedang) -->
    <div v-if="middleLeader" class="relative bg-white rounded-3xl p-6 border border-gray-200 shadow-sm w-full max-w-xs text-center flex flex-col items-center hover:shadow-lg transition-shadow">
      <div class="w-24 h-24 rounded-full overflow-hidden border-4 border-white shadow-md bg-[#1B8A9C] flex items-center justify-center mb-4">
        <img v-if="middleLeader.image" :src="middleLeader.image" :alt="middleLeader.name" class="w-full h-full object-cover" @error="handleImageError($event, 'leaders')" />
        <span v-else class="text-3xl font-extrabold text-white">{{ middleLeader.initials.charAt(0) }}</span>
      </div>
      <span class="inline-block px-3.5 py-1 bg-[#1B8A9C] text-white text-[10px] font-bold uppercase tracking-widest rounded-full mb-2">
        {{ middleLeader.role }}
      </span>
      <h4 class="text-lg font-extrabold text-gray-950 leading-tight">{{ middleLeader.name }}</h4>
    </div>

    <!-- Garis vertikal 2 + percabangan ke bawah -->
    <div v-if="bottomLeaders.length > 0" class="relative w-full flex justify-center" style="height: 40px;">
      <div class="absolute top-0 left-1/2 -translate-x-1/2 w-px h-full bg-gray-300"></div>
    </div>

    <!-- LEVEL 3: Kepala Seksi (Grid Kartu Kecil) -->
    <div v-if="bottomLeaders.length > 0" class="relative w-full">
      <!-- Garis horizontal -->
      <div class="absolute top-0 left-1/2 -translate-x-1/2 h-px bg-gray-300" 
        :style="{ width: bottomLeaders.length > 1 ? `${(bottomLeaders.length - 1) * (100 / bottomLeaders.length)}%` : '0' }">
      </div>

      <div class="grid gap-4 sm:gap-6 pt-8" 
        :class="{
          'grid-cols-1 max-w-xs mx-auto': bottomLeaders.length === 1,
          'grid-cols-1 sm:grid-cols-2 max-w-2xl mx-auto': bottomLeaders.length === 2,
          'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 max-w-5xl mx-auto': bottomLeaders.length === 3,
          'grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 max-w-6xl mx-auto': bottomLeaders.length >= 4
        }">
        <div v-for="kasi in bottomLeaders" :key="kasi.id"
          class="relative bg-white rounded-2xl p-5 border border-gray-200 shadow-sm text-center flex flex-col items-center hover:shadow-lg transition-shadow">
          <!-- Garis vertikal kecil ke atas -->
          <div class="absolute -top-8 left-1/2 -translate-x-1/2 w-px h-8 bg-gray-300 hidden sm:block"></div>

          <div class="w-16 h-16 rounded-full overflow-hidden border-2 border-white shadow-md bg-[#1B8A9C] flex items-center justify-center mb-3">
            <img v-if="kasi.image" :src="kasi.image" :alt="kasi.name" class="w-full h-full object-cover" @error="handleImageError($event, 'leaders')" />
            <span v-else class="text-xl font-extrabold text-white">{{ kasi.initials.charAt(0) }}</span>
          </div>
          <span class="inline-block px-2.5 py-0.5 bg-amber-50 text-amber-800 text-[9px] font-bold uppercase tracking-widest rounded-full mb-2 border border-amber-200">
            {{ kasi.role }}
          </span>
          <h4 class="text-sm font-extrabold text-gray-950 leading-tight">{{ kasi.name }}</h4>
        </div>
      </div>
    </div>

  </div>
</section>

    <!-- POTENSI DESA KAMI SECTION -->
    <section class="py-16 md:py-24 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="max-w-2xl mb-12">
          <div class="inline-flex items-center gap-2 text-xs font-bold text-[#0D6847] uppercase tracking-wider bg-emerald-50 px-3.5 py-1.5 rounded-full border border-emerald-100 mb-4">
            <TrendingUpIcon class="w-3.5 h-3.5 animate-bounce" />
            <span>Potensi</span>
          </div>
          <h2 class="text-3xl font-extrabold text-gray-950 leading-tight">Potensi Padukuhan</h2>
          <p class="text-sm text-gray-500 mt-2 leading-relaxed">
            Mengenal potensi yang ada di wilayah Padukuhan Ngemplak Kalangan untuk mendorong ekonomi berkelanjutan.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 items-stretch mb-12">
          
          <div v-for="potensi in store.facilities" :key="potensi.id" class="bg-white border border-gray-150 rounded-2xl overflow-hidden flex flex-col group hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
            <!-- Image Section -->
            <div class="relative h-48 overflow-hidden bg-gray-100">
              <img 
                :src="potensi.foto_url || '/images/hero-bg.png'" 
                :alt="potensi.nama" 
                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                @error="handleImageError($event, 'hero-bg')"
              />
              <div class="absolute top-3 left-3 flex items-center gap-2">
                <span class="px-2.5 py-1 bg-white/90 backdrop-blur-sm text-[#0D6847] text-[10px] font-extrabold uppercase tracking-wider rounded-lg shadow-sm">
                  {{ potensi.kategori === 'wisata' ? 'Fasilitas / Wisata' : 'Potensi Desa' }}
                </span>
              </div>
            </div>
            
            <!-- Content Section -->
            <div class="p-6 flex flex-col flex-1">
              <h3 class="text-xl font-extrabold text-gray-950 leading-snug mb-2">{{ potensi.nama }}</h3>
              <p class="text-sm text-gray-600 leading-relaxed flex-1 mb-4 line-clamp-3">
                {{ potensi.deskripsi }}
              </p>
              
              <!-- Action Button / Link -->
              <div class="mt-auto pt-4 border-t border-gray-100">
                <a 
                  v-if="potensi.lokasi && potensi.lokasi !== '-'" 
                  :href="potensi.lokasi" 
                  target="_blank" 
                  class="inline-flex items-center gap-2 px-4 py-2 bg-emerald-50 hover:bg-[#0D6847] text-[#0D6847] hover:text-white text-xs font-bold rounded-xl transition-colors w-fit"
                >
                  <MapPinIcon class="w-4 h-4" />
                  <span>Lihat di Google Maps</span>
                </a>
                <!-- Preview Embed -->
                <div class="rounded-xl overflow-hidden border border-gray-200 h-40">
                  <iframe
                    :src="getOSMEmbedUrl(potensi.lokasi)"
                    width="100%" height="160" style="border:0" loading="lazy">
                  </iframe>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div class="text-center">
          <button class="px-6 py-3 border-2 border-gray-200 hover:border-[#0D6847] hover:text-[#0D6847] font-bold text-xs rounded-xl transition-all duration-300 active:scale-95 cursor-pointer">
            Jelajahi Potensi Desa Selengkapnya
          </button>
        </div>

      </div>
    </section>
  </div>
</template>

<script setup>
import { store } from '../store';
import { 
  ArrowRight as ArrowRightIcon,
  MapPin as MapPinIcon,
  Award as AwardIcon,
  Users as UsersIcon,
  Home as HomeIcon,
  ShoppingBag as ShoppingBagIcon,
  TrendingUp as TrendingUpIcon
} from 'lucide-vue-next';

import { computed } from 'vue';

// Define custom simple icon components inline using simple SVGs for genders and leaf to avoid missing lucide icon definitions
import { defineComponent, h } from 'vue';

const MaleIcon = defineComponent({
  render() {
    return h('svg', { xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', 'stroke-linecap': 'round', 'stroke-linejoin': 'round', class: 'lucide lucide-mars w-5 h-5' }, [
      h('path', { d: 'M16 3h5v5' }),
      h('path', { d: 'm21 3-7.5 7.5' }),
      h('circle', { cx: '10', cy: '14', r: '5' })
    ]);
  }
});

const FemaleIcon = defineComponent({
  render() {
    return h('svg', { xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', 'stroke-linecap': 'round', 'stroke-linejoin': 'round', class: 'lucide lucide-venus w-5 h-5' }, [
      h('circle', { cx: '12', cy: '9', r: '5' }),
      h('path', { d: 'M12 14v7' }),
      h('path', { d: 'M9 18h6' })
    ]);
  }
});

const LeafIcon = defineComponent({
  render() {
    return h('svg', { xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', 'stroke-linecap': 'round', 'stroke-linejoin': 'round', class: 'lucide lucide-leaf w-6 h-6' }, [
      h('path', { d: 'M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 3.5 1 9.8a7 7 0 0 1-9 8.2Z' }),
      h('path', { d: 'M19 2c-2.26 4.33-5.27 7.14-8 10' })
    ]);
  }
});

const handleImageError = (event, type) => {
  if (type === 'hero-bg') {
    event.target.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1200&q=80';
  } else if (type === 'leaders') {
    // Sembunyikan img, biarkan inisial muncul
    event.target.style.display = 'none';
  } else {
    event.target.src = 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=800&q=80';
  }
};

const scrollToSection = (id) => {
  const element = document.getElementById(id);
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' });
  }
};

// Max penduduk untuk skala bar
const maxPendudukDusun = computed(() => {
  let max = 1;
  store.kependudukanDusun.forEach(d => {
    max = Math.max(max, d.laki_laki || 0, d.perempuan || 0);
  });
  return max;
});

// Hitung % lebar bar
const getBarWidth = (val) => {
  const pct = Math.min(100, ((val || 0) / maxPendudukDusun.value) * 100);
  return pct + '%';
};

// Ambil demografi per kategori (sudah diurutkan)
const golonganUmur = computed(() =>
  store.demographics
    .filter(d => d.kategori === 'usia')
    .sort((a, b) => (a.urutan || 0) - (b.urutan || 0))
);

const jenisKelamin = computed(() =>
  store.demographics
    .filter(d => d.kategori === 'jenis_kelamin')
    .sort((a, b) => (a.urutan || 0) - (b.urutan || 0))
);

const pendidikan = computed(() =>
  store.demographics
    .filter(d => d.kategori === 'pendidikan')
    .sort((a, b) => (a.urutan || 0) - (b.urutan || 0))
);

const pekerjaan = computed(() =>
  store.demographics
    .filter(d => d.kategori === 'pekerjaan')
    .sort((a, b) => (a.urutan || 0) - (b.urutan || 0))
);

// Max nilai untuk skala bar
const maxDemografi = computed(() => {
  let max = 1;
  store.demographics.forEach(d => {
    max = Math.max(max, d.jumlah_jiwa || 0);
  });
  return max;
});

// Hitung % lebar bar (minimum 5% agar bar kecil tetap kelihatan)
const getBarWidths = (val) => {
  const pct = ((val || 0) / maxDemografi.value) * 100;
  return Math.max(pct, 3) + '%';
};

// Format angka dengan pemisah ribuan (Indonesia)
const formatAngka = (val) => {
  return (val || 0).toLocaleString('id-ID');
};

// Struktur organisasi — grouping berdasarkan urutan
const topLeader = computed(() => store.leaders.find(l => l.urutan === 1));
const middleLeader = computed(() => store.leaders.find(l => l.urutan === 2));
const bottomLeaders = computed(() =>
  store.leaders
    .filter(l => l.urutan >= 3)
    .sort((a, b) => a.urutan - b.urutan)
);

// Konversi berbagai format link Maps menjadi URL embed
// ============================================
// OPENSTREETMAP EMBED URL DENGAN MARKER/PIN
// Mengekstrak koordinat dari berbagai format link Google Maps
// lalu menampilkan pin di lokasi tersebut
// ============================================
const getOSMEmbedUrl = (url) => {
  if (!url) return 'https://www.openstreetmap.org/export/embed.html?layer=mapnik';

  let lat = null;
  let lon = null;

  // Format 1: https://www.google.com/maps/@-7.123456,110.123456,15z
  const m1 = url.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/);
  if (m1) {
    lat = parseFloat(m1[1]);
    lon = parseFloat(m1[2]);
  }

  // Format 2: https://maps.google.com/?q=-7.123456,110.123456
  //           https://www.google.com/maps?q=loc:-7.123456,110.123456
  if (!lat) {
    const m2 = url.match(/[?&]q=(?:loc:)?(-?\d+\.\d+),(-?\d+\.\d+)/);
    if (m2) {
      lat = parseFloat(m2[1]);
      lon = parseFloat(m2[2]);
    }
  }

  // Format 3: https://www.google.com/maps/place/.../data=...!3d-7.123!4d110.123
  // Format ini punya !3d (latitude) dan !4d (longitude)
  if (!lat) {
    const m3d = url.match(/!3d(-?\d+\.\d+)/);
    const m4d = url.match(/!4d(-?\d+\.\d+)/);
    if (m3d && m4d) {
      lat = parseFloat(m3d[1]);
      lon = parseFloat(m4d[1]);
    }
  }

  // Format 4: https://www.google.com/maps/place/.../...?  (fallback dari /dir/)
  // Mencari pola umum "latitude,longitude" tanpa format khusus
  if (!lat) {
    const m4 = url.match(/(-?\d{1,3}\.\d{4,}),(-?\d{1,3}\.\d{4,})/);
    if (m4) {
      lat = parseFloat(m4[1]);
      lon = parseFloat(m4[2]);
    }
  }

  // Jika koordinat ditemukan → tampilkan dengan MARKER/PIN
  if (lat !== null && lon !== null) {
    const d = 0.003; // delta untuk bounding box (semakin kecil, semakin zoom in)
    const bbox = `${lon - d},${lat - d},${lon + d},${lat + d}`;
    return `https://www.openstreetmap.org/export/embed.html?bbox=${bbox}&layer=mapnik&marker=${lat},${lon}`;
  }

  // Fallback: tidak ada koordinat → peta default tanpa marker
  return 'https://www.openstreetmap.org/export/embed.html?layer=mapnik';
};
</script>

<style scoped>
/* Optional scoped styling for SVG animations or custom bar charts */
</style>
