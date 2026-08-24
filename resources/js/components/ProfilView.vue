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
        <span class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/20 text-xs font-semibold tracking-wider uppercase mb-6 text-emerald-200">
          Profil Padukuhan
        </span>
        <h2 class="text-4xl md:text-5xl font-extrabold tracking-tight leading-tight mb-6">
          Membangun Padukuhan, <br/>
          <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-200">Mensejahterakan Warga</span>
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
                  src="/images/kepala-desa.png" 
                  alt="Bapak Supriyanto" 
                  class="w-full h-full object-cover object-top group-hover:scale-103 transition-transform duration-500"
                  @error="handleImageError($event, 'kepala-desa')"
                />
              </div>
              <div class="pt-5 pb-2 text-center">
                <h3 class="text-xl font-extrabold text-gray-900 leading-tight">Bapak Supriyanto</h3>
                <p class="text-xs font-bold text-gray-400 uppercase tracking-widest mt-1">Kepala Dukuh Ngemplak Kalangan</p>
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
              Warisan Budaya & Masa Depan Digital
            </h2>
            
            <div class="space-y-4 text-sm text-gray-600 leading-relaxed font-medium">
              <p>
                Padukuhan Ngemplak Kalangan merupakan wilayah administratif yang kaya akan nilai historis, kebudayaan luhur, dan kebersamaan warga yang erat. Terletak di kawasan strategis Sleman, Yogyakarta, padukuhan kami terus berkembang dengan memadukan kearifan lokal pertanian dan kemajuan teknologi modern.
              </p>
              <p>
                Kami menyadari pentingnya keterbukaan informasi di era modern. Oleh karena itu, melalui website padukuhan ini, kami berkomitmen menyajikan akses informasi yang cepat, profil potensi desa yang transparan, serta wadah interaksi kebersamaan warga yang guyub dan andal.
              </p>
            </div>

            <!-- Quote Box -->
            <div class="relative bg-emerald-50/70 border-l-4 border-[#0D6847] p-6 rounded-r-2xl">
              <span class="absolute top-2 left-2 text-6xl text-emerald-200/50 font-serif leading-none select-none pointer-events-none">“</span>
              <p class="text-sm italic font-semibold text-gray-700 leading-relaxed pl-6 relative z-10">
                Kita harus berjalan bersama, mengawinkan tradisi leluhur dengan pemanfaatan teknologi digital untuk kesejahteraan dan kemandirian warga Ngemplak Kalangan.
              </p>
            </div>
          </div>

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
        <p class="text-xs text-gray-500 uppercase tracking-widest font-bold mb-8">Visi Utama Kami</p>

        <!-- Vision Card Box -->
        <div class="bg-white rounded-3xl p-8 md:p-10 shadow-xl shadow-gray-200/40 border border-gray-100 relative overflow-hidden group hover:shadow-2xl transition-all duration-300">
          <div class="absolute -right-16 -top-16 w-36 h-36 bg-[#0D6847]/5 rounded-full group-hover:scale-110 transition-transform duration-500"></div>
          <div class="absolute -left-16 -bottom-16 w-36 h-36 bg-[#0D6847]/5 rounded-full group-hover:scale-110 transition-transform duration-500"></div>
          
          <div class="relative z-10 flex flex-col items-center">
            <span class="inline-block text-[10px] font-extrabold text-[#0D6847] bg-[#0D6847]/10 px-4 py-1.5 rounded-full uppercase tracking-wider mb-5">
              Cita-Cita Padukuhan
            </span>
            <p class="text-lg md:text-2xl font-bold text-gray-800 leading-relaxed max-w-2xl">
              "Mewujudkan Padukuhan yang mandiri, aman, dan berbudaya dengan pelayanan prima berbasis teknologi untuk kesejahteraan masyarakat."
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- STATISTIK KEPENDUDUKAN SECTION -->
    <section class="py-16 md:py-24 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center max-w-2xl mx-auto mb-16">
          <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Statistik Kependudukan</h2>
          <p class="text-sm text-gray-500 mt-2 leading-relaxed">
            Data kependudukan Padukuhan Ngemplak Kalangan yang diperbarui secara berkala dan transparan.
          </p>
        </div>

        <!-- 4 Numeric Cards Grid -->
        <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6 mb-12">
          <!-- Card 1 -->
          <div class="bg-[#F8FAFC] rounded-2xl p-5 border border-gray-100 flex items-center gap-4 hover:shadow-md transition-shadow">
            <div class="p-3.5 rounded-xl bg-blue-50 text-blue-600">
              <UsersIcon class="w-5 h-5" />
            </div>
            <div>
              <span class="text-[10px] font-bold text-gray-400 uppercase tracking-wider block">Jumlah Penduduk</span>
              <span class="text-lg md:text-xl font-extrabold text-gray-900">4,829 Jiwa</span>
            </div>
          </div>
          <!-- Card 2 -->
          <div class="bg-[#F8FAFC] rounded-2xl p-5 border border-gray-100 flex items-center gap-4 hover:shadow-md transition-shadow">
            <div class="p-3.5 rounded-xl bg-purple-50 text-purple-600">
              <HomeIcon class="w-5 h-5" />
            </div>
            <div>
              <span class="text-[10px] font-bold text-gray-400 uppercase tracking-wider block">Kepala Keluarga</span>
              <span class="text-lg md:text-xl font-extrabold text-gray-900">897 KK</span>
            </div>
          </div>
          <!-- Card 3 -->
          <div class="bg-[#F8FAFC] rounded-2xl p-5 border border-gray-100 flex items-center gap-4 hover:shadow-md transition-shadow">
            <div class="p-3.5 rounded-xl bg-emerald-50 text-[#0D6847]">
              <MaleIcon class="w-5 h-5" />
            </div>
            <div>
              <span class="text-[10px] font-bold text-gray-400 uppercase tracking-wider block">Laki-laki</span>
              <span class="text-lg md:text-xl font-extrabold text-gray-900">49% <span class="text-[10px] text-gray-400 font-medium">dari total</span></span>
            </div>
          </div>
          <!-- Card 4 -->
          <div class="bg-[#F8FAFC] rounded-2xl p-5 border border-gray-100 flex items-center gap-4 hover:shadow-md transition-shadow">
            <div class="p-3.5 rounded-xl bg-pink-50 text-pink-600">
              <FemaleIcon class="w-5 h-5" />
            </div>
            <div>
              <span class="text-[10px] font-bold text-gray-400 uppercase tracking-wider block">Perempuan</span>
              <span class="text-lg md:text-xl font-extrabold text-gray-900">51% <span class="text-[10px] text-gray-400 font-medium">dari total</span></span>
            </div>
          </div>
        </div>

        <!-- Charts Grid (2 columns on large screen) -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 items-stretch mb-16">
          
          <!-- Gender Bar Chart Card -->
          <div class="bg-white rounded-3xl p-6.5 border border-gray-100 shadow-sm flex flex-col justify-between">
            <div>
              <h3 class="font-extrabold text-gray-950 text-base mb-1">Jenis Kelamin Penduduk</h3>
              <p class="text-xs text-gray-400 font-medium mb-6">Persentase perbandingan kependudukan laki-laki dan perempuan.</p>
            </div>
            
            <div class="space-y-6">
              <!-- Laki-laki Bar -->
              <div class="space-y-2">
                <div class="flex items-center justify-between text-xs font-bold text-gray-700">
                  <span class="flex items-center gap-1.5">
                    <span class="w-3 h-3 rounded-full bg-emerald-600"></span>
                    Laki-Laki
                  </span>
                  <span>49% (2,366 Jiwa)</span>
                </div>
                <div class="w-full h-4 bg-gray-100 rounded-full overflow-hidden">
                  <div class="h-full bg-emerald-600 rounded-full" style="width: 49%"></div>
                </div>
              </div>
              
              <!-- Perempuan Bar -->
              <div class="space-y-2">
                <div class="flex items-center justify-between text-xs font-bold text-gray-700">
                  <span class="flex items-center gap-1.5">
                    <span class="w-3 h-3 rounded-full bg-teal-500"></span>
                    Perempuan
                  </span>
                  <span>51% (2,463 Jiwa)</span>
                </div>
                <div class="w-full h-4 bg-gray-100 rounded-full overflow-hidden">
                  <div class="h-full bg-teal-500 rounded-full" style="width: 51%"></div>
                </div>
              </div>
            </div>
            
            <div class="mt-8 flex justify-center gap-6 border-t border-gray-50 pt-4.5 text-[10px] font-bold text-gray-400 uppercase tracking-wider">
              <span class="flex items-center gap-1.5">
                <span class="w-2.5 h-2.5 rounded-full bg-[#0D6847]"></span> Laki-laki
              </span>
              <span class="flex items-center gap-1.5">
                <span class="w-2.5 h-2.5 rounded-full bg-teal-400"></span> Perempuan
              </span>
            </div>
          </div>

          <!-- Age Donut Chart Card -->
          <div class="bg-white rounded-3xl p-6.5 border border-gray-100 shadow-sm flex flex-col justify-between">
            <div>
              <h3 class="font-extrabold text-gray-950 text-base mb-1">Profil Rentang Usia</h3>
              <p class="text-xs text-gray-400 font-medium mb-6">Distribusi penduduk berdasarkan rentang usia produktif & non-produktif.</p>
            </div>
            
            <div class="flex flex-col sm:flex-row items-center justify-around gap-6">
              <!-- Custom Interactive SVG Donut Chart -->
              <div class="relative w-36 h-36 flex items-center justify-center">
                <svg class="w-full h-full transform -rotate-90" viewBox="0 0 36 36">
                  <!-- Donut background circle -->
                  <circle cx="18" cy="18" r="15.915" fill="transparent" stroke="#E2E8F0" stroke-width="3"></circle>
                  
                  <!-- Segment 1: Anak-anak 15% (stroke-dasharray: "15 85") -->
                  <circle cx="18" cy="18" r="15.915" fill="transparent" stroke="#3B82F6" stroke-width="4.2" stroke-dasharray="15 85" stroke-dashoffset="0"></circle>
                  
                  <!-- Segment 2: Produktif 65% (stroke-dasharray: "65 35", offset = -15) -->
                  <circle cx="18" cy="18" r="15.915" fill="transparent" stroke="#0D6847" stroke-width="4.2" stroke-dasharray="65 35" stroke-dashoffset="-15"></circle>
                  
                  <!-- Segment 3: Lansia 20% (stroke-dasharray: "20 80", offset = -80) -->
                  <circle cx="18" cy="18" r="15.915" fill="transparent" stroke="#94A3B8" stroke-width="4.2" stroke-dasharray="20 80" stroke-dashoffset="-80"></circle>
                </svg>
                
                <div class="absolute flex flex-col items-center justify-center text-center">
                  <span class="text-xs font-extrabold text-gray-400 uppercase tracking-widest leading-none">Usia</span>
                  <span class="text-lg font-black text-gray-800 mt-0.5">Donut</span>
                </div>
              </div>

              <!-- Legend / Details List -->
              <div class="space-y-3.5 w-full sm:w-auto">
                <div class="flex items-center justify-between gap-6 text-xs">
                  <span class="flex items-center gap-2 font-bold text-gray-600">
                    <span class="w-3 h-3 rounded bg-blue-500"></span>
                    Anak-anak (0-14 th)
                  </span>
                  <span class="font-extrabold text-gray-800 text-right">15%</span>
                </div>
                <div class="flex items-center justify-between gap-6 text-xs">
                  <span class="flex items-center gap-2 font-bold text-gray-600">
                    <span class="w-3 h-3 rounded bg-[#0D6847]"></span>
                    Produktif (15-64 th)
                  </span>
                  <span class="font-extrabold text-gray-800 text-right">65%</span>
                </div>
                <div class="flex items-center justify-between gap-6 text-xs">
                  <span class="flex items-center gap-2 font-bold text-gray-600">
                    <span class="w-3 h-3 rounded bg-slate-400"></span>
                    Lansia (>65 th)
                  </span>
                  <span class="font-extrabold text-gray-800 text-right">20%</span>
                </div>
              </div>
            </div>
            
            <div class="mt-8 border-t border-gray-50 pt-4.5 text-[10px] font-bold text-gray-400 uppercase tracking-wider text-center">
              Total Data Populasi Teranalisis
            </div>
          </div>

        </div>

        <!-- Population Table -->
        <div class="bg-white border border-gray-150 rounded-2xl overflow-hidden shadow-sm">
          <div class="px-6 py-5 border-b border-gray-150 bg-gray-50/50 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div>
              <h3 class="font-extrabold text-gray-900 text-base">Detail Kependudukan Per RT</h3>
              <p class="text-xs text-gray-400 font-semibold mt-0.5">Distribusi rincian jumlah warga per rukun tetangga.</p>
            </div>
            <span class="self-start sm:self-auto px-3.5 py-1 bg-emerald-50 text-[#0D6847] border border-emerald-100 rounded-full text-[10px] font-extrabold uppercase tracking-wider">
              3 Wilayah RT Terintegrasi
            </span>
          </div>

          <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse text-xs">
              <thead>
                <tr class="border-b border-gray-150 text-gray-400 font-bold uppercase tracking-wider bg-gray-50/20">
                  <th class="py-4.5 px-6 font-bold">Rukun Tetangga (RT)</th>
                  <th class="py-4.5 px-6 font-bold text-right">Laki-Laki</th>
                  <th class="py-4.5 px-6 font-bold text-right">Perempuan</th>
                  <th class="py-4.5 px-6 font-bold text-right">Total Warga</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-150 text-gray-700 font-medium">
                <tr class="hover:bg-gray-50/50 transition-colors">
                  <td class="py-4.5 px-6 font-bold text-gray-900">RT 01</td>
                  <td class="py-4.5 px-6 text-right">200 Jiwa</td>
                  <td class="py-4.5 px-6 text-right">210 Jiwa</td>
                  <td class="py-4.5 px-6 text-right font-bold text-emerald-600">410 Jiwa</td>
                </tr>
                <tr class="hover:bg-gray-50/50 transition-colors">
                  <td class="py-4.5 px-6 font-bold text-gray-900">RT 02</td>
                  <td class="py-4.5 px-6 text-right">195 Jiwa</td>
                  <td class="py-4.5 px-6 text-right">205 Jiwa</td>
                  <td class="py-4.5 px-6 text-right font-bold text-emerald-600">400 Jiwa</td>
                </tr>
                <tr class="hover:bg-gray-50/50 transition-colors">
                  <td class="py-4.5 px-6 font-bold text-gray-900">RT 03</td>
                  <td class="py-4.5 px-6 text-right">180 Jiwa</td>
                  <td class="py-4.5 px-6 text-right">190 Jiwa</td>
                  <td class="py-4.5 px-6 text-right font-bold text-emerald-600">370 Jiwa</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div class="mt-12 bg-white p-6 rounded-2xl border border-gray-150 shadow-sm flex flex-col md:flex-row gap-8 items-center">
          <p class="text-sm text-gray-600 leading-relaxed flex-1">
            Kami menyadari pentingnya keterbukaan informasi di era modern. Oleh karena itu, melalui website padukuhan ini, kami berkomitmen menyajikan akses informasi yang cepat, profil potensi padukuhan yang transparan, serta wadah kebersamaan warga yang guyub dan berdaya.
          </p>

          <div class="relative bg-emerald-50/70 border-l-4 border-[#0D6847] p-6 rounded-r-2xl w-full md:w-auto">
            <span class="absolute top-2 left-2 text-6xl text-emerald-200/50 font-serif leading-none select-none pointer-events-none">“</span>
            <p class="text-sm italic font-semibold text-gray-700 leading-relaxed pl-6 relative z-10 max-w-sm">
              Kita harus berjalan bersama, mengawinkan tradisi leluhur dengan pemanfaatan teknologi digital untuk kesejahteraan dan kemandirian warga Ngemplak Kalangan.
            </p>
          </div>
        </div>

      </div>
    </section>

    <!-- STRUKTUR ORGANISASI SECTION -->
    <section class="py-16 md:py-24 bg-[#F8FAFC] border-t border-b border-gray-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center max-w-2xl mx-auto mb-16">
          <h2 class="text-2xl md:text-3xl font-extrabold text-gray-950">Struktur Organisasi</h2>
          <p class="text-sm text-gray-500 mt-2 leading-relaxed">
            Perangkat Padukuhan Ngemplak Kalangan yang berdedikasi tinggi untuk melayani masyarakat.
          </p>
        </div>

        <div class="space-y-12">
          
          <!-- Level 1: Dukuh (Leader) -->
          <div class="flex justify-center">
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm max-w-xs w-full text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-[#0D6847] w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full overflow-hidden mx-auto mb-4 border border-gray-100 bg-gray-50">
                <img 
                  src="/images/kepala-desa.png" 
                  alt="Bapak Supriyanto" 
                  class="w-full h-full object-cover object-top"
                  @error="handleImageError($event, 'kepala-desa')"
                />
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Bapak Supriyanto</h3>
              <p class="text-[10px] font-bold text-[#0D6847] uppercase tracking-wider mt-1.5">Dukuh / Kepala Padukuhan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Masa Bakti: 2021 - 2027</div>
            </div>
          </div>

          <!-- Connecting Arrow/Line (Desktop Decorative) -->
          <div class="hidden md:flex justify-center">
            <div class="h-8 w-0.5 bg-gray-250"></div>
          </div>

          <!-- Level 2: Core Officers (3 Columns: Sekretaris, Pembangunan, Bendahara) -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
            
            <!-- Sekretaris -->
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-blue-500 w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full bg-blue-50 text-blue-600 font-extrabold text-lg flex items-center justify-center mx-auto mb-4 border border-blue-100">
                SR
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Ibu Sitti Rahma</h3>
              <p class="text-[10px] font-bold text-blue-500 uppercase tracking-wider mt-1.5">Sekretaris Padukuhan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Melayani Administrasi & Surat</div>
            </div>

            <!-- Seksi Pembangunan -->
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-[#0D6847] w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full bg-emerald-50 text-[#0D6847] font-extrabold text-lg flex items-center justify-center mx-auto mb-4 border border-emerald-100">
                S
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Bapak Supari</h3>
              <p class="text-[10px] font-bold text-[#0D6847] uppercase tracking-wider mt-1.5">Seksi Pembangunan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Fokus Infrastruktur & Jalan</div>
            </div>

            <!-- Bendahara -->
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-purple-500 w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full bg-purple-50 text-purple-600 font-extrabold text-lg flex items-center justify-center mx-auto mb-4 border border-purple-100">
                BH
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Bapak Bambang Heru</h3>
              <p class="text-[10px] font-bold text-purple-600 uppercase tracking-wider mt-1.5">Bendahara Padukuhan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Manajemen Anggaran & Kas</div>
            </div>

          </div>

          <!-- Connecting Arrow/Line (Desktop Decorative) -->
          <div class="hidden md:flex justify-center">
            <div class="h-8 w-0.5 bg-gray-250"></div>
          </div>

          <!-- Level 3: Auxiliary Officers (3 Columns: Kesejahteraan, Pelayanan, Keamanan) -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
            
            <!-- Seksi Kesejahteraan -->
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-amber-500 w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full bg-amber-50 text-amber-600 font-extrabold text-lg flex items-center justify-center mx-auto mb-4 border border-amber-100">
                JP
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Bapak Joko Pranoto</h3>
              <p class="text-[10px] font-bold text-amber-500 uppercase tracking-wider mt-1.5">Seksi Kesejahteraan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Fokus Sosial & UMKM Desa</div>
            </div>

            <!-- Seksi Pelayanan -->
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-pink-500 w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full bg-pink-50 text-pink-600 font-extrabold text-lg flex items-center justify-center mx-auto mb-4 border border-pink-100">
                L
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Ibu Lestari</h3>
              <p class="text-[10px] font-bold text-pink-600 uppercase tracking-wider mt-1.5">Seksi Pelayanan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Fokus Pelayanan & Posyandu</div>
            </div>

            <!-- Seksi Keamanan -->
            <div class="bg-white rounded-2xl p-5 border border-gray-150 shadow-sm text-center group hover:shadow-md transition-shadow relative">
              <div class="absolute -top-1.5 left-1/2 -translate-x-1/2 h-1 bg-red-500 w-12 rounded-full"></div>
              <div class="w-16 h-16 rounded-full bg-red-50 text-red-600 font-extrabold text-lg flex items-center justify-center mx-auto mb-4 border border-red-100">
                W
              </div>
              <h3 class="font-extrabold text-gray-950 text-base leading-tight">Bapak Wardoyo</h3>
              <p class="text-[10px] font-bold text-red-600 uppercase tracking-wider mt-1.5">Seksi Keamanan</p>
              <div class="text-[10px] text-gray-400 font-semibold mt-1">Fokus Linmas & Siskamling</div>
            </div>

          </div>

        </div>

        <!-- Call to Action for Admin services inside structure -->
        <div class="max-w-4xl mx-auto mt-16 bg-gradient-to-r from-[#0D6847] to-[#0A5238] rounded-2xl p-6.5 text-white flex flex-col sm:flex-row justify-between items-center gap-6 shadow-md shadow-emerald-900/10">
          <div>
            <h4 class="font-extrabold text-lg leading-tight">Ingin Mengenal Struktur Organisasi Lebih Lanjut?</h4>
            <p class="text-xs text-emerald-100 mt-1">Lihat detail profil dan tanggung jawab masing-masing perangkat dusun kami.</p>
          </div>
          <button 
            @click="$emit('navigate', 'tentang-kami')"
            class="px-6 py-3 bg-white hover:bg-emerald-50 text-[#0D6847] font-bold text-xs rounded-xl shadow-md transition-all active:scale-95 cursor-pointer whitespace-nowrap"
          >
            Kenali Lebih Dekat
          </button>
        </div>

      </div>
    </section>

    <!-- POTENSI DESA KAMI SECTION -->
    <section class="py-16 md:py-24 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="max-w-2xl mb-12">
          <div class="inline-flex items-center gap-2 text-xs font-bold text-[#0D6847] uppercase tracking-wider bg-emerald-50 px-3.5 py-1.5 rounded-full border border-emerald-100 mb-4">
            <TrendingUpIcon class="w-3.5 h-3.5 animate-bounce" />
            <span>Potensi Desa</span>
          </div>
          <h2 class="text-3xl font-extrabold text-gray-950 leading-tight">Potensi Desa Kami</h2>
          <p class="text-sm text-gray-500 mt-2 leading-relaxed">
            Mengenal potensi yang ada di wilayah Padukuhan Ngemplak Kalangan untuk mendorong ekonomi berkelanjutan.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-stretch mb-12">
          
          <!-- Potensi 1: Pertanian Organik -->
          <div class="bg-[#F0FAF5] border border-[#E0F2E9] rounded-2xl p-8 flex flex-col justify-between group hover:shadow-md transition-shadow">
            <div>
              <div class="w-12 h-12 rounded-xl bg-emerald-500 text-white flex items-center justify-center mb-6 shadow-md shadow-emerald-500/10 group-hover:scale-105 transition-transform">
                <LeafIcon class="w-6 h-6" />
              </div>
              <h3 class="text-xl font-extrabold text-gray-900 leading-snug">Pertanian Organik</h3>
              <p class="text-xs text-gray-500 leading-relaxed mt-3">
                Dengan lahan sawah yang subur di area Ngemplak Kalangan, petani kami memprioritaskan padi organik bebas bahan kimia buatan, menghasilkan beras sehat bernilai tinggi yang melestarikan tanah warisan leluhur.
              </p>
            </div>
            <div class="mt-8 pt-4 border-t border-[#E0F2E9] flex items-center justify-between text-xs font-bold text-[#0D6847]">
              <span>Komoditas Unggulan</span>
              <span>Beras Organik Sehat</span>
            </div>
          </div>

          <!-- Potensi 2: UMKM Kreatif -->
          <div class="bg-blue-50/50 border border-blue-100 rounded-2xl p-8 flex flex-col justify-between group hover:shadow-md transition-shadow">
            <div>
              <div class="w-12 h-12 rounded-xl bg-blue-500 text-white flex items-center justify-center mb-6 shadow-md shadow-blue-500/10 group-hover:scale-105 transition-transform">
                <ShoppingBagIcon class="w-6 h-6" />
              </div>
              <h3 class="text-xl font-extrabold text-gray-900 leading-snug">UMKM Kreatif</h3>
              <p class="text-xs text-gray-500 leading-relaxed mt-3">
                Kami mendukung pengrajin lokal di Dusun Kalangan yang membuat anyaman bambu premium untuk kebutuhan rumah tangga ramah lingkungan. Produk kuliner tradisional khas desa juga aktif dikembangkan oleh ibu-ibu PKK.
              </p>
            </div>
            <div class="mt-8 pt-4 border-t border-blue-100 flex items-center justify-between text-xs font-bold text-blue-600">
              <span>Sektor Perekonomian</span>
              <span>Kerajinan Bambu & Kuliner</span>
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
import { 
  ArrowRight as ArrowRightIcon,
  MapPin as MapPinIcon,
  Award as AwardIcon,
  Users as UsersIcon,
  Home as HomeIcon,
  ShoppingBag as ShoppingBagIcon,
  TrendingUp as TrendingUpIcon
} from 'lucide-vue-next';

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
  const fallbacks = {
    'hero-bg': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80',
    'kepala-desa': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=400&q=80'
  };
  event.target.src = fallbacks[type] || 'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=600';
};

const scrollToSection = (id) => {
  const element = document.getElementById(id);
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' });
  }
};
</script>

<style scoped>
/* Optional scoped styling for SVG animations or custom bar charts */
</style>
