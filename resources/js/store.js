import { reactive, watch } from 'vue';

// Initial Mock Data
const initialNews = [
  {
    id: 1,
    title: 'Semarak Lomba Kemerdekaan RI ke-81 di Lapangan Polowidi',
    category: 'Kegiatan Warga',
    date: '18 Agustus 2026',
    image: '/images/lomba-polowidi.png',
    excerpt: 'Ratusan warga dari dusun Ngemplak dan Kalangan berkumpul memeriahkan berbagai perlombaan tradisional untuk mempererat persaudaraan.',
    content: 'Ratusan warga dari dusun Ngemplak dan Kalangan berkumpul memeriahkan berbagai perlombaan tradisional untuk mempererat persaudaraan dan kebersamaan antarwarga desa. Acara berlangsung meriah sejak pagi hingga sore hari dengan beragam perlombaan anak-anak, ibu-ibu PKK, serta bapak-bapak.'
  },
  {
    id: 2,
    title: 'Keceriaan Anak-Anak Kalangan dalam Pawai Budaya dan Kostum Unik',
    category: 'Generasi Muda',
    date: '17 Agustus 2026',
    image: '/images/lomba-kalangan.png',
    excerpt: 'Anak-anak dan remaja dusun menampilkan kreasi busana adat nusantara dan daur ulang ramah lingkungan sebagai wujud kecintaan pada budaya.',
    content: 'Anak-anak dan remaja dusun menampilkan kreasi busana adat nusantara dan daur ulang ramah lingkungan sebagai wujud kreativitas dan kecintaan pada budaya tanah air. Kegiatan karnaval ini menyusuri jalan utama dusun diiringi tabuhan musik gamelan.'
  },
  {
    id: 3,
    title: 'Malam Tirakatan dan Doa Bersama: Merawat Kerukunan dan Kebersamaan Warga',
    category: 'Tradisi Luhur',
    date: '16 Agustus 2026',
    image: '/images/tirakatan.png',
    excerpt: 'Malam tirakatan merupakan tradisi refleksi dan doa bersama warga Padukuhan Ngemplak Kalangan dalam rangka mensyukuri kemerdekaan.',
    content: 'Malam tirakatan merupakan tradisi refleksi dan doa bersama warga Padukuhan Ngemplak Kalangan dalam rangka mensyukuri kemerdekaan bangsa. Acara ini dihadiri oleh tokoh masyarakat, sesepuh, dan seluruh warga dari dua dusun secara khidmat dan penuh persaudaraan.'
  },
  {
    id: 4,
    title: 'Pelatihan Anyaman Bambu Kontemporer untuk Pemberdayaan Ekonomi',
    category: 'Pemberdayaan UMKM',
    date: '10 Agustus 2026',
    image: '/images/anyaman-bambu.png',
    excerpt: 'Meningkatkan nilai jual produk lokal melalui teknik anyaman modern dan strategi pemasaran digital bagi pengrajin desa.',
    content: 'Kelompok usaha mikro Padukuhan menyelenggarakan pelatihan anyaman bambu inovatif bagi ibu-ibu rumah tangga dan pemuda. Mengundang instruktur ahli dari Yogyakarta, pelatihan ini memfokuskan pada desain kemasan produk anyaman modern yang memiliki nilai jual ekspor serta optimalisasi promosi digital.'
  }
];

const initialProducts = [
  {
    id: 1,
    name: 'Anyaman Bambu Premium',
    category: 'Kerajinan',
    price: 75000,
    unit: 'pcs',
    rating: 4.9,
    isBestSeller: true,
    seller: 'Ibu Suminah (RT 02)',
    image: '/images/anyaman-bambu.png',
    description: 'Kerajinan tempat serbaguna dari bambu pilihan yang dianyam rapi secara tradisional oleh warga lokal.',
    fullDescription: 'Kerajinan tangan tempat serbaguna dari bambu asli lereng Sleman. Dianyam secara cermat dengan daya tahan tinggi, cocok sebagai wadah bumbu, buah-buahan, wadah hantaran, maupun dekorasi interior bernuansa etnik.'
  },
  {
    id: 2,
    name: 'Kopi Organik Arabika',
    category: 'Hasil Bumi',
    price: 45000,
    unit: '250g',
    rating: 4.8,
    isBestSeller: true,
    seller: 'Kelompok Tani Kalangan',
    image: '/images/kopi-arabika.jpg',
    description: 'Biji kopi pilihan yang ditanam secara organik tanpa pestisida. Aroma khas dengan citarasa asam manis seimbang.',
    fullDescription: 'Kopi Arabika organik yang dipetik dari kebun perbukitan warga Ngemplak Kalangan. Diproses secara natural (full wash) dan sangrai tingkat medium untuk memunculkan aroma nutty serta floral yang lembut.'
  },
  {
    id: 3,
    name: 'Kain Batik Tulis Motif',
    category: 'Kerajinan',
    price: 350000,
    unit: 'lembar',
    rating: 5.0,
    isBestSeller: true,
    seller: 'Sanggar Batik Warga',
    image: '/images/batik-tulis.jpg',
    description: 'Kain batik handmade motif khas Padukuhan Ngemplak Kalangan dengan bahan katun primisima halus.',
    fullDescription: 'Kain Batik Tulis asli karya pengrajin batik padukuhan. Menggunakan bahan katun super halus dan pewarnaan rempah alami yang ramah lingkungan. Setiap potongan motif memiliki keunikan filosofi lokal.'
  },
  {
    id: 4,
    name: 'Madu Hutan Murni',
    category: 'Hasil Bumi',
    price: 120000,
    unit: '500ml',
    rating: 4.9,
    isBestSeller: false,
    seller: 'Pak Hadi (Peternak Lebah)',
    image: '/images/hero-bg.png',
    description: 'Madu murni 100% dipanen langsung dari sarang lebah hutan liar tanpa bahan pengawet atau gula tambahan.',
    fullDescription: 'Madu murni alami berkualitas super dari lebah liar yang menghisap nektar bunga liar padukuhan. Kaya akan antioksidan, zat besi, dan vitamin alami untuk menjaga daya tahan tubuh keluarga.'
  },
  {
    id: 5,
    name: 'Teh Herbal Celup Alami',
    category: 'Olahan Makanan',
    price: 25000,
    unit: 'kotak (20 bag)',
    rating: 4.7,
    isBestSeller: false,
    seller: 'KWT Ngemplak Asri',
    image: '/images/senam-sore.png',
    description: 'Teh racikan rempah jahe, serai, dan mint organik dari pekarangan rumah warga untuk menyegarkan badan.',
    fullDescription: 'Teh celup herbal kombinasi jahe merah, serai wangi, dan daun mint segar yang dikeringkan secara higienis oleh Kelompok Wanita Tani (KWT). Memberikan rasa hangat dan relaksasi pada tubuh.'
  },
  {
    id: 6,
    name: 'Keripik Tempe Renyah',
    category: 'Olahan Makanan',
    price: 15000,
    unit: 'pack (250g)',
    rating: 4.8,
    isBestSeller: true,
    seller: 'Ibu Sri Wahyuni',
    image: '/images/lomba-kalangan.png',
    description: 'Olahan tempe kedelai segar dibalut tepung gurih berbumbu rempah rahasia Padukuhan. Renyah & lezat.',
    fullDescription: 'Camilan keripik tempe tipis renyah dengan racikan bumbu bawang dan daun jeruk alami. Tanpa bahan pengawet kimia, sangat cocok menemani santai sore atau oleh-oleh khas desa.'
  }
];

const initialGallery = [
  {
    id: 1,
    title: 'Lomba 17 Agustus Di Ngemplak Polowidi',
    type: 'foto',
    category: 'Kebudayaan',
    image: '/images/lomba-polowidi.png',
    date: '19 AGUSTUS 2026',
    location: 'Dusun Ngemplak Polowidi',
    description: 'Kemeriahan berbagai macam perlombaan anak-anak dan pemuda dalam memperingati HUT Kemerdekaan RI di dusun Ngemplak Polowidi.'
  },
  {
    id: 2,
    title: 'Lomba 17 Agustus Di Kalangan',
    type: 'foto',
    category: 'Kebudayaan',
    image: '/images/lomba-kalangan.png',
    date: '19 AGUSTUS 2026',
    location: 'Dusun Kalangan',
    description: 'Semangat gotong royong dan keceriaan warga Kalangan dalam menyukseskan rangkaian lomba 17-an.'
  },
  {
    id: 3,
    title: 'Kegiatan Tirakatan Warga',
    type: 'foto',
    category: 'Keagamaan',
    image: '/images/tirakatan.png',
    date: '16 AGUSTUS 2026',
    location: 'Balai Padukuhan',
    description: 'Malam refleksi dan doa bersama tokoh masyarakat serta warga menjelang hari ulang tahun kemerdekaan Indonesia.'
  },
  {
    id: 4,
    title: 'Kegiatan TPA Supit Urang',
    type: 'foto',
    category: 'Keagamaan',
    image: '/images/tpa-supit-urang.png',
    date: '12 AGUSTUS 2026',
    location: 'Masjid Supit Urang',
    description: 'Anak-anak antusias mengikuti pembelajaran baca tulis Al-Quran di Taman Pendidikan Al-Quran Supit Urang.'
  },
  {
    id: 5,
    title: 'Kegiatan TPA El-Mutaqi',
    type: 'foto',
    category: 'Keagamaan',
    image: '/images/tpa-el-mutaqi.png',
    date: '10 AGUSTUS 2026',
    location: 'Masjid El-Mutaqi',
    description: 'Pendidikan karakter spiritual sejak dini bagi generasi muda di lingkungan masjid El-Mutaqi.'
  },
  {
    id: 6,
    title: 'Seni Rodat Classic',
    type: 'video',
    category: 'Kebudayaan',
    image: '/images/seni-rodat.png',
    date: '05 AGUSTUS 2026',
    location: 'Halaman Balai Desa',
    description: 'Pertunjukan seni tradisional Rodat / Hadroh gabungan generasi muda dan sesepuh kesenian dusun.'
  },
  {
    id: 7,
    title: 'Kegiatan Senam Di Sore Hari',
    type: 'foto',
    category: 'Olahraga',
    image: '/images/senam-sore.png',
    date: '02 AGUSTUS 2026',
    location: 'Lapangan Padukuhan',
    description: 'Olahraga rutin senam kebugaran jasmani ibu-ibu PKK dan warga untuk menjaga kesehatan bersama.'
  }
];

const initialLeaders = [
  {
    id: 1,
    name: 'Bapak Supriyanto',
    role: 'Kepala Dukuh',
    level: 'Pimpinan',
    image: '/images/kepala-desa.png',
    focus: 'Penanggung Jawab Utama Tata Kelola & Warga',
    description: 'Memimpin jalannya tata kelola padukuhan dan pelayanan kemasyarakatan dengan penuh integritas.'
  },
  {
    id: 2,
    name: 'Bapak Bambang Wijaya',
    role: 'Sekretaris Dusun',
    level: 'Perangkat',
    initials: 'BW',
    focus: 'Administrasi & Pembukuan Dokumen Warga',
    description: 'Mengelola ketatausahaan dan dokumentasi kependudukan serta informasi publik dusun.'
  },
  {
    id: 3,
    name: 'Ibu Siti Rahmawati',
    role: 'Bendahara & Ketua PKK/KWT',
    level: 'Perangkat',
    initials: 'SR',
    focus: 'Keuangan, Kas Dusun & Pemberdayaan Wanita Tani',
    description: 'Mengelola kas kebersamaan warga dan menggerakkan program pekarangan pangan lestari.'
  },
  {
    id: 4,
    name: 'Bapak Hendro S.',
    role: 'Seksi Kesejahteraan',
    level: 'Seksi',
    initials: 'HS',
    focus: 'Kegiatan Sosial & Keagamaan Warga',
    description: 'Mengkoordinir kegiatan santunan sosial, keagamaan, dan gotong royong antarwarga.'
  },
  {
    id: 5,
    name: 'Ibu Ratna Dewi',
    role: 'Seksi Pemberdayaan & UMKM',
    level: 'Seksi',
    initials: 'RD',
    focus: 'Pendampingan UMKM & Posyandu Dusun',
    description: 'Mendampingi kemajuan usaha mikro kerajinan bambu dan layanan gizi posyandu balita-lansia.'
  },
  {
    id: 6,
    name: 'Bapak Wardoyo',
    role: 'Seksi Keamanan & Ketertiban',
    level: 'Seksi',
    initials: 'W',
    focus: 'Linmas, Siskamling & Ketertiban Lingkungan',
    description: 'Mengatur ronda malam dan keamanan swadaya di seluruh RT Padukuhan.'
  }
];

const initialFaqs = [
  {
    id: 1,
    question: 'Di mana letak Padukuhan Ngemplak Kalangan?',
    answer: 'Padukuhan Ngemplak Kalangan berada di Kapanewon (Kecamatan) Kalasan, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55571. Lokasinya sangat strategis, asri, dan mudah dijangkau dari jalan utama Yogya-Solo.'
  },
  {
    question: 'Bagaimana cara berkunjung atau studi potensi desa ke Ngemplak Kalangan?',
    id: 2,
    answer: 'Kunjungan warga luar, pelajar, instansi, maupun rombongan studi banding dapat dikonfirmasikan terlebih dahulu melalui kontak pengurus padukuhan atau berkunjung langsung ke Balai Pertemuan Warga pada hari kerja.'
  },
  {
    id: 3,
    question: 'Apakah produk kerajinan anyaman bambu & batik bisa dipesan custom / jumlah banyak?',
    answer: 'Tentu bisa! Pengrajin kami melayani pesanan suvenir pernikahan, hantaran, dekorasi hotel/resto, serta cinderamata instansi dengan desain dan motif khusus.'
  },
  {
    id: 4,
    question: 'Kapan jadwal latihan kesenian Seni Rodat dan kegiatan pemuda?',
    answer: 'Latihan Seni Rodat rutin diadakan setiap akhir pekan di Sanggar Seni Warga, sedangkan perkumpulan Karang Taruna dan senam bersama warga dilaksanakan secara berkala.'
  }
];

const initialFacilities = [
  {
    id: 1,
    name: 'Balai Pertemuan Warga',
    location: 'Dusun Kalangan',
    description: 'Tempat musyawarah dusun, rapat RT/RW, pelatihan UMKM, dan perayaan hari besar kemerdekaan warga.'
  },
  {
    id: 2,
    name: 'Masjid & TPA Warga',
    location: 'Ngemplak & Kalangan',
    description: 'TPA El Mutaqi dan TPA Supit Urang sebagai sarana pembinaan keagamaan, akhlak, dan hafalan Al-Qur\'an anak-anak.'
  },
  {
    id: 3,
    name: 'Pos Ronda & Kamling',
    location: 'Tersebar di Tiap RT',
    description: 'Pos keamanan lingkungan swadaya warga yang aktif bergiliran menjaga ketertiban serta keamanan lingkungan.'
  }
];

const initialInbox = [
  {
    id: 1,
    name: 'Budi Santoso',
    phone: '081234567890',
    email: 'budi.santoso@gmail.com',
    message: 'Halo, saya tertarik memesan anyaman bambu sebanyak 50 pcs untuk suvenir pernikahan. Apakah bisa custom ukuran?',
    date: '23 Agustus 2026, 14:30'
  },
  {
    id: 2,
    name: 'Dian Permata',
    phone: '085712345678',
    email: 'dian.p@yahoo.com',
    message: 'Mohon info apakah kopi arabika organik bisa dikirim ke Jakarta? Terima kasih.',
    date: '22 Agustus 2026, 09:15'
  }
];

// Helper to load or set LocalStorage
const loadStorage = (key, defaultData) => {
  try {
    const saved = localStorage.getItem(`ngemplak_${key}`);
    return saved ? JSON.parse(saved) : defaultData;
  } catch (e) {
    return defaultData;
  }
};

export const store = reactive({
  // Auth state
  isAuthenticated: localStorage.getItem('ngemplak_admin_auth') === 'true',
  adminUser: {
    username: 'admin',
    name: 'Administrator Padukuhan',
    role: 'Super Admin'
  },

  // Main collections
  news: loadStorage('news', initialNews),
  products: loadStorage('products', initialProducts),
  gallery: loadStorage('gallery', initialGallery),
  leaders: loadStorage('leaders', initialLeaders),
  faqs: loadStorage('faqs', initialFaqs),
  facilities: loadStorage('facilities', initialFacilities),
  inbox: loadStorage('inbox', initialInbox),

  // Auth Methods
  login(username, password) {
    if (username === 'admin' && password === 'admin12345') {
      this.isAuthenticated = true;
      localStorage.setItem('ngemplak_admin_auth', 'true');
      return { success: true };
    }
    return { success: false, message: 'Username atau Password salah! Gunakan user: admin dan password: admin12345' };
  },

  logout() {
    this.isAuthenticated = false;
    localStorage.removeItem('ngemplak_admin_auth');
  },

  // NEWS CRUD
  addNews(item) {
    const newItem = {
      id: Date.now(),
      title: item.title || 'Berita Baru',
      category: item.category || 'Kegiatan Warga',
      date: item.date || new Date().toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' }),
      image: item.image || '/images/hero-bg.png',
      excerpt: item.excerpt || '',
      content: item.content || ''
    };
    this.news.unshift(newItem);
    this.save('news');
  },
  updateNews(id, updated) {
    const idx = this.news.findIndex(n => n.id === id);
    if (idx !== -1) {
      this.news[idx] = { ...this.news[idx], ...updated };
      this.save('news');
    }
  },
  deleteNews(id) {
    this.news = this.news.filter(n => n.id !== id);
    this.save('news');
  },

  // PRODUCTS CRUD
  addProduct(item) {
    const newItem = {
      id: Date.now(),
      name: item.name || 'Produk Baru',
      category: item.category || 'Kerajinan',
      price: Number(item.price) || 0,
      unit: item.unit || 'pcs',
      rating: Number(item.rating) || 5.0,
      isBestSeller: Boolean(item.isBestSeller),
      seller: item.seller || 'Warga Padukuhan',
      image: item.image || '/images/anyaman-bambu.png',
      description: item.description || '',
      fullDescription: item.fullDescription || item.description || ''
    };
    this.products.unshift(newItem);
    this.save('products');
  },
  updateProduct(id, updated) {
    const idx = this.products.findIndex(p => p.id === id);
    if (idx !== -1) {
      this.products[idx] = { ...this.products[idx], ...updated, price: Number(updated.price) || this.products[idx].price };
      this.save('products');
    }
  },
  deleteProduct(id) {
    this.products = this.products.filter(p => p.id !== id);
    this.save('products');
  },

  // GALLERY CRUD
  addGallery(item) {
    const newItem = {
      id: Date.now(),
      title: item.title || 'Foto Baru',
      type: item.type || 'foto',
      category: item.category || 'Kebudayaan',
      image: item.image || '/images/galeri-1.png',
      date: item.date || new Date().toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' }),
      location: item.location || 'Padukuhan Ngemplak Kalangan',
      description: item.description || ''
    };
    this.gallery.unshift(newItem);
    this.save('gallery');
  },
  updateGallery(id, updated) {
    const idx = this.gallery.findIndex(g => g.id === id);
    if (idx !== -1) {
      this.gallery[idx] = { ...this.gallery[idx], ...updated };
      this.save('gallery');
    }
  },
  deleteGallery(id) {
    this.gallery = this.gallery.filter(g => g.id !== id);
    this.save('gallery');
  },

  // LEADERS CRUD
  addLeader(item) {
    const newItem = {
      id: Date.now(),
      name: item.name || '',
      role: item.role || '',
      level: item.level || 'Seksi',
      image: item.image || '',
      initials: item.initials || item.name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase(),
      focus: item.focus || '',
      description: item.description || ''
    };
    this.leaders.push(newItem);
    this.save('leaders');
  },
  updateLeader(id, updated) {
    const idx = this.leaders.findIndex(l => l.id === id);
    if (idx !== -1) {
      this.leaders[idx] = { ...this.leaders[idx], ...updated };
      this.save('leaders');
    }
  },
  deleteLeader(id) {
    this.leaders = this.leaders.filter(l => l.id !== id);
    this.save('leaders');
  },

  // FAQS CRUD
  addFaq(item) {
    const newItem = {
      id: Date.now(),
      question: item.question || '',
      answer: item.answer || ''
    };
    this.faqs.push(newItem);
    this.save('faqs');
  },
  updateFaq(id, updated) {
    const idx = this.faqs.findIndex(f => f.id === id);
    if (idx !== -1) {
      this.faqs[idx] = { ...this.faqs[idx], ...updated };
      this.save('faqs');
    }
  },
  deleteFaq(id) {
    this.faqs = this.faqs.filter(f => f.id !== id);
    this.save('faqs');
  },

  // INBOX
  addInbox(item) {
    const newItem = {
      id: Date.now(),
      name: item.name,
      phone: item.phone,
      email: item.email || '-',
      message: item.message,
      date: new Date().toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric', hour: '2-digit', minute: '2-digit' })
    };
    this.inbox.unshift(newItem);
    this.save('inbox');
  },
  deleteInbox(id) {
    this.inbox = this.inbox.filter(i => i.id !== id);
    this.save('inbox');
  },

  // Save to localStorage helper
  save(key) {
    try {
      localStorage.setItem(`ngemplak_${key}`, JSON.stringify(this[key]));
    } catch (e) {
      console.error('Storage save error:', e);
    }
  },

  // Reset to default
  resetToDefaults() {
    this.news = [...initialNews];
    this.products = [...initialProducts];
    this.gallery = [...initialGallery];
    this.leaders = [...initialLeaders];
    this.faqs = [...initialFaqs];
    this.facilities = [...initialFacilities];
    this.inbox = [...initialInbox];
    this.save('news');
    this.save('products');
    this.save('gallery');
    this.save('leaders');
    this.save('faqs');
    this.save('facilities');
    this.save('inbox');
  }
});
