import { reactive } from 'vue';
import { api } from './api';

export const store = reactive({
  isAuthenticated: localStorage.getItem('ngemplak_admin_auth') === 'true',
  adminUser: { username: 'admin', name: 'Administrator Padukuhan', role: 'Super Admin' },

  // Data collections
  news: [], products: [], gallery: [], leaders: [], faqs: [], inbox: [],
  categories: [], umkms: [], agenda: [], pengumuman: [],
  potensiWisata: [], demographics: [], kependudukanDusun: [],
  padukuhanProfile: null,

  get facilities() { return this.potensiWisata; },

  // Helper untuk filter kategori berdasarkan tipe
  categoriesByTipe(tipe) {
    return this.categories.filter(c => c.tipe === tipe);
  },

  // ==========================================
  // UPLOAD FILE
  // ==========================================
  async uploadFile(file, folder = 'uploads') {
    if (!file) return '';
    const formData = new FormData();
    formData.append('file', file);
    formData.append('folder', folder);
    const res = await api.post('/upload', formData, true);
    return res.data.url;
  },

  // ==========================================
  // INIT DATA
  // ==========================================
  async initData() {
    try {
      const [
        beritaRes, produkRes, galeriRes, strukturRes, faqRes, kategoriRes, umkmRes,
        agendaRes, pengumumanRes, potensiRes, demografiRes, profilRes, kependudukanRes
      ] = await Promise.all([
        api.get('/berita'), api.get('/produk'), api.get('/galeri'),
        api.get('/struktur-organisasi'), api.get('/faq'), api.get('/kategori'), api.get('/umkm'),
        api.get('/agenda'), api.get('/pengumuman'), api.get('/potensi-wisata'),
        api.get('/demografi'), api.get('/profil'), api.get('/kependudukan-dusun')
      ]);

      this.categories = kategoriRes.data;
      this.umkms = umkmRes.data;

      // Berita
      this.news = beritaRes.data
        .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
        .map(item => ({
          id: item.id,
          title: item.title,
          category: this.categories.find(c => c.id === item.category_id)?.nama || 'Kegiatan',
          category_id: item.category_id,
          date: new Date(item.created_at).toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' }),
          created_at: item.created_at,
          image: item.thumbnail || '/images/hero-bg.png',
          foto_url: item.thumbnail || '',
          excerpt: (item.content || '').substring(0, 150) + '...',
          content: item.content || '',
          author: item.author?.nama_lengkap || 'Admin'
        }));

      // Produk
      this.products = produkRes.data.map(item => {
        const umkm = this.umkms.find(u => u.id === item.penjual_id);
        return {
          id: item.id,
          name: item.nama_produk,
          category: this.categories.find(c => c.id === item.category_id)?.nama || 'Produk',
          category_id: item.category_id,
          price: item.harga || 0,
          unit: 'pcs', rating: 5.0,
          isBestSeller: item.is_unggulan || false,
          seller: umkm?.nama_usaha || 'Warga',
          sellerPhone: umkm?.nomor_whatsapp || '',
          penjual_id: item.penjual_id,
          image: item.foto_produk || '/images/anyaman-bambu.png',
          foto_url: item.foto_produk || '',
          description: item.deskripsi || 'Produk asli warga Ngemplak Kalangan.',
          fullDescription: item.deskripsi || 'Produk asli warga Ngemplak Kalangan.'
        };
      });

      // Galeri
      this.gallery = galeriRes.data.map(item => ({
        id: item.id,
        title: item.judul,
        type: item.tipe || 'foto',
        category: this.categories.find(c => c.id === item.category_id)?.nama || 'Dokumentasi',
        category_id: item.category_id,
        image: item.file_url || '/images/galeri-1.png',
        foto_url: item.file_url || '',
        youtube_url: item.youtube_url || '',
        date: new Date(item.created_at).toLocaleDateString('id-ID'),
        location: item.is_highlight ? 'Highlight' : 'Ngemplak Kalangan',
        description: item.judul
      }));

      // Leaders
      this.leaders = strukturRes.data.map(item => ({
        id: item.id,
        name: item.nama,
        role: item.jabatan,
        level: item.urutan === 1 ? 'Pimpinan' : 'Seksi',
        image: item.foto || '/images/hero-bg.png',
        foto_url: item.foto || '',
        focus: '-', description: '-'
      }));

      // FAQ
      this.faqs = faqRes.data.map(item => ({
        id: item.id, question: item.pertanyaan, answer: item.jawaban
      }));

      // Agenda — format tanggal agar terisi di form edit
      this.agenda = agendaRes.data.map(item => ({
        id: item.id,
        month: new Date(item.tanggal_kegiatan).toLocaleString('id-ID', { month: 'short' }),
        day: new Date(item.tanggal_kegiatan).getDate(),
        date: item.tanggal_kegiatan, // format YYYY-MM-DD untuk <input type="date">
        title: item.nama_kegiatan,
        time: item.waktu,
        location: item.lokasi,
        status: item.status || 'mendatang',
        details: item.deskripsi || '',
        deskripsi: item.deskripsi || ''
      }));

      // Pengumuman
      this.pengumuman = pengumumanRes.data.map(item => ({
        id: item.id,
        title: item.judul,
        category_id: item.category_id,
        date: new Date(item.tanggal_posting).toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' }),
        tanggal_posting: item.tanggal_posting,
        description: item.isi_ringkas,
        isImportant: item.category_id === 16
      }));

      // Potensi Wisata
      this.potensiWisata = potensiRes.data.map(item => ({
        id: item.id,
        nama: item.nama,
        kategori: item.kategori || 'potensi_desa',
        deskripsi: item.deskripsi || '',
        foto_url: item.foto_url || '',
        image: item.foto_url || '/images/hero-bg.png',
        lokasi: item.link_gmaps || ''
      }));

      // Demografi
      this.demographics = demografiRes.data.map(item => ({
        id: item.id, kategori: item.kategori, label: item.label,
        jumlah_jiwa: item.jumlah_jiwa || 0, persentase: item.persentase || 0
      }));

      // Kependudukan Dusun
      this.kependudukanDusun = kependudukanRes.data.map(item => ({
        id: item.id,
        nama_rt: item.nama_rt,
        nama_dusun: item.nama_dusun || '',
        laki_laki: item.laki_laki || 0,
        perempuan: item.perempuan || 0,
        total: item.total || ((item.laki_laki || 0) + (item.perempuan || 0)),
        jumlah_kk: item.jumlah_kk || 0,
        keterangan: item.keterangan || ''
      }));

      // Profil Padukuhan
      if (profilRes.data && profilRes.data.length > 0) {
        const p = profilRes.data[0];
        this.padukuhanProfile = {
          id: p.id,
          nama_padukuhan: p.nama_padukuhan || 'Ngemplak Kalangan',
          kecamatan: p.kecamatan || '', kabupaten: p.kabupaten || '', provinsi: p.provinsi || '',
          jumlah_penduduk: p.jumlah_penduduk || 0,
          jumlah_kk: p.jumlah_kk || 0,
          jumlah_rt: p.jumlah_rt || 0,
          jumlah_rw: p.jumlah_rw || 0,
          luas_wilayah: p.luas_wilayah || '',
          sejarah: p.sejarah || '',
          cita_cita: p.cita_cita || '',
          nama_dukuh: p.nama_dukuh || '',
          sambutan_dukuh: p.sambutan_dukuh || '',
          foto_dukuh: p.foto_dukuh || '',
          alamat_kantor: p.alamat_kantor || '',
          telepon: p.telepon || '',
          email: p.email || ''
        };
      }

      if (this.isAuthenticated) this.fetchInbox();
    } catch (error) {
      console.error("Gagal memuat data dari API:", error);
    }
  },

  async fetchInbox() {
    try {
      const res = await api.get('/pesan-bantuan');
      this.inbox = res.data.map(item => ({
        id: item.id, name: item.nama_lengkap, phone: '-', email: item.email,
        message: item.pesan,
        date: new Date(item.created_at).toLocaleDateString('id-ID')
      }));
    } catch (error) { console.error("Gagal mengambil pesan", error); }
  },

  // ==========================================
  // AUTH
  // ==========================================
  async login(email, password) {
    try {
      const res = await api.post('/login', { email, password });
      if (res.success) {
        this.isAuthenticated = true;
        localStorage.setItem('ngemplak_admin_auth', 'true');
        localStorage.setItem('ngemplak_admin_token', res.data.token);
        this.fetchInbox();
        return { success: true };
      }
    } catch (error) {
      return { success: false, message: error.message || 'Email atau Password salah!' };
    }
  },
  async logout() {
    try { await api.post('/logout'); } catch (e) { }
    this.isAuthenticated = false;
    localStorage.removeItem('ngemplak_admin_auth');
    localStorage.removeItem('ngemplak_admin_token');
  },

  // ==========================================
  // CRUD — NEWS
  // ==========================================
  async addNews(item, file = null) {
    try {
      let thumbnail = item.foto_url || '';
      if (file) thumbnail = await this.uploadFile(file, 'news');
      await api.post('/berita', {
        title: item.title,
        slug: item.title.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '') + '-' + Date.now(),
        content: item.content || item.excerpt || '',
        thumbnail,
        category_id: item.category_id || 1,
        author_id: 1,
        status: 'published'
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async updateNews(id, item, file = null) {
    try {
      let thumbnail = item.foto_url || '';
      if (file) thumbnail = await this.uploadFile(file, 'news');
      await api.put(`/berita/${id}`, {
        title: item.title,
        slug: item.title.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '') + '-' + Date.now(),
        content: item.content || item.excerpt,
        thumbnail,
        category_id: item.category_id || 1,
        author_id: 1,
        status: 'published'
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async deleteNews(id) { try { await api.delete(`/berita/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — PRODUCTS
  // ==========================================
  async addProduct(item, file = null) {
    try {
      let foto_produk = item.foto_url || '';
      if (file) foto_produk = await this.uploadFile(file, 'produk');

      let penjualId = this.umkms.find(u => u.nama_usaha === item.seller)?.id;
      if (!penjualId) {
        const umkmRes = await api.post('/umkm', {
          nama_penjual: item.seller || 'Warga Desa',
          nama_usaha: item.seller || 'Usaha Desa',
          nomor_whatsapp: item.sellerPhone || '',
          alamat_lokasi: 'Ngemplak Kalangan'
        });
        penjualId = umkmRes.data?.id || 1;
      } else if (item.sellerPhone) {
        await api.put(`/umkm/${penjualId}`, { nomor_whatsapp: item.sellerPhone });
      }

      await api.post('/produk', {
        nama_produk: item.name,
        harga: Number(item.price) || 0,
        category_id: item.category_id || 2,
        penjual_id: penjualId || 1,
        deskripsi: item.description || '',
        foto_produk,
        is_unggulan: item.isBestSeller ? 1 : 0
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async updateProduct(id, item, file = null) {
    try {
      let foto_produk = item.foto_url || '';
      if (file) foto_produk = await this.uploadFile(file, 'produk');
      if (item.sellerPhone && item.penjual_id) {
        await api.put(`/umkm/${item.penjual_id}`, { nomor_whatsapp: item.sellerPhone }).catch(() => { });
      }
      await api.put(`/produk/${id}`, {
        nama_produk: item.name,
        harga: Number(item.price) || 0,
        category_id: item.category_id || 2,
        deskripsi: item.description || '',
        foto_produk,
        is_unggulan: item.isBestSeller ? 1 : 0
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async deleteProduct(id) { try { await api.delete(`/produk/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — GALLERY
  // ==========================================
  async addGallery(item, file = null) {
    try {
      let file_url = item.foto_url || '';
      if (file) file_url = await this.uploadFile(file, 'galeri');
      await api.post('/galeri', {
        judul: item.title,
        tipe: item.type || 'foto',
        category_id: item.category_id || 3,
        file_url,
        youtube_url: item.youtube_url || ''
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async updateGallery(id, item, file = null) {
    try {
      let file_url = item.foto_url || '';
      if (file) file_url = await this.uploadFile(file, 'galeri');
      await api.put(`/galeri/${id}`, {
        judul: item.title,
        tipe: item.type || 'foto',
        category_id: item.category_id || 3,
        file_url,
        youtube_url: item.youtube_url || ''
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async deleteGallery(id) { try { await api.delete(`/galeri/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — AGENDA
  // ==========================================
  async addAgenda(item) {
    try {
      await api.post('/agenda', {
        nama_kegiatan: item.title,
        tanggal_kegiatan: item.date || new Date().toISOString().split('T')[0],
        waktu: item.time || '08:00 - selesai',
        lokasi: item.location || '-',
        deskripsi: item.details || item.deskripsi || '',
        status: item.status || 'mendatang'
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updateAgenda(id, item) {
    try {
      await api.put(`/agenda/${id}`, {
        nama_kegiatan: item.title,
        tanggal_kegiatan: item.date,
        waktu: item.time,
        lokasi: item.location,
        deskripsi: item.details || item.deskripsi || '',
        status: item.status || 'mendatang'
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deleteAgenda(id) { try { await api.delete(`/agenda/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — PENGUMUMAN
  // ==========================================
  async addPengumuman(item) {
    try {
      await api.post('/pengumuman', {
        category_id: item.category_id || (item.isImportant ? 16 : 17),
        judul: item.title,
        isi_ringkas: item.description,
        tanggal_posting: item.tanggal_posting || new Date().toISOString().split('T')[0]
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updatePengumuman(id, item) {
    try {
      await api.put(`/pengumuman/${id}`, {
        category_id: item.category_id || (item.isImportant ? 16 : 17),
        judul: item.title,
        isi_ringkas: item.description,
        tanggal_posting: item.tanggal_posting
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deletePengumuman(id) { try { await api.delete(`/pengumuman/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — LEADERS
  // ==========================================
  async addLeader(item, file = null) {
    try {
      let foto = item.foto_url || '';
      if (file) foto = await this.uploadFile(file, 'leaders');
      await api.post('/struktur-organisasi', {
        nama: item.name, jabatan: item.role, foto,
        urutan: item.level === 'Pimpinan' ? 1 : 2
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async updateLeader(id, item, file = null) {
    try {
      let foto = item.foto_url || '';
      if (file) foto = await this.uploadFile(file, 'leaders');
      await api.put(`/struktur-organisasi/${id}`, {
        nama: item.name, jabatan: item.role, foto,
        urutan: item.level === 'Pimpinan' ? 1 : 2
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async deleteLeader(id) { try { await api.delete(`/struktur-organisasi/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — FAQS
  // ==========================================
  async addFaq(item) { try { await api.post('/faq', { pertanyaan: item.question, jawaban: item.answer }); await this.initData(); } catch (e) { alert(e.message); } },
  async updateFaq(id, item) { try { await api.put(`/faq/${id}`, { pertanyaan: item.question, jawaban: item.answer }); await this.initData(); } catch (e) { alert(e.message); } },
  async deleteFaq(id) { try { await api.delete(`/faq/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — INBOX
  // ==========================================
  async addInbox(item) {
    try {
      await api.post('/pesan-bantuan', {
        nama_lengkap: item.name,
        email: item.email || 'tanpa-email@gmail.com',
        pesan: item.message
      });
    } catch (error) { console.error(error); alert(error.message); }
  },
  async deleteInbox(id) { try { await api.delete(`/pesan-bantuan/${id}`); this.fetchInbox(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — MASTER KATEGORI
  // ==========================================
  async addKategori(item) {
    try {
      const slug = item.nama.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');
      await api.post('/kategori', {
        tipe: item.tipe,
        nama: item.nama,
        slug: slug + '-' + Date.now()
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updateKategori(id, item) {
    try {
      const slug = item.nama.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');
      await api.put(`/kategori/${id}`, {
        tipe: item.tipe,
        nama: item.nama,
        slug: slug + '-' + Date.now()
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deleteKategori(id) {
    try {
      await api.delete(`/kategori/${id}`);
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  // ==========================================
  // CRUD — POTENSI WISATA
  // ==========================================
  async addPotensi(item, file = null) {
    try {
      let foto_url = item.foto_url || '';
      if (file) foto_url = await this.uploadFile(file, 'potensi');
      await api.post('/potensi-wisata', {
        nama: item.nama,
        kategori: item.kategori === 'Fasilitas / Wisata' ? 'wisata' : (item.kategori || 'potensi_desa'),
        deskripsi: item.deskripsi || '',
        foto_url,
        link_gmaps: item.lokasi || ''
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updatePotensi(id, item, file = null) {
    try {
      let foto_url = item.foto_url || '';
      if (file) foto_url = await this.uploadFile(file, 'potensi');
      await api.put(`/potensi-wisata/${id}`, {
        nama: item.nama,
        kategori: item.kategori === 'Fasilitas / Wisata' ? 'wisata' : (item.kategori || 'potensi_desa'),
        deskripsi: item.deskripsi,
        foto_url,
        link_gmaps: item.lokasi || ''
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deletePotensi(id) { try { await api.delete(`/potensi-wisata/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — DEMOGRAFI
  // ==========================================
  async addDemographic(item) {
    try {
      await api.post('/demografi', {
        kategori: item.kategori, label: item.label,
        jumlah_jiwa: Number(item.jumlah_jiwa) || 0,
        persentase: Number(item.persentase) || 0
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updateDemographic(id, item) {
    try {
      await api.put(`/demografi/${id}`, {
        kategori: item.kategori, label: item.label,
        jumlah_jiwa: Number(item.jumlah_jiwa) || 0,
        persentase: Number(item.persentase) || 0
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deleteDemographic(id) { try { await api.delete(`/demografi/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — KEPENDUDUKAN DUSUN
  // ==========================================
  async addKependudukan(item) {
    try {
      await api.post('/kependudukan-dusun', {
        nama_rt: item.nama_rt,
        nama_dusun: item.nama_dusun || '',
        laki_laki: Number(item.laki_laki) || 0,
        perempuan: Number(item.perempuan) || 0,
        jumlah_kk: Number(item.jumlah_kk) || 0,
        keterangan: item.keterangan || ''
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updateKependudukan(id, item) {
    try {
      await api.put(`/kependudukan-dusun/${id}`, {
        nama_rt: item.nama_rt,
        nama_dusun: item.nama_dusun || '',
        laki_laki: Number(item.laki_laki) || 0,
        perempuan: Number(item.perempuan) || 0,
        jumlah_kk: Number(item.jumlah_kk) || 0,
        keterangan: item.keterangan || ''
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deleteKependudukan(id) { try { await api.delete(`/kependudukan-dusun/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // PROFIL PADUKUHAN
  // ==========================================
  async updatePadukuhanProfile(data, fotoFile = null) {
    try {
      if (fotoFile) {
        data.foto_dukuh = await this.uploadFile(fotoFile, 'profil');
      }
      if (this.padukuhanProfile?.id) {
        await api.put(`/profil/${this.padukuhanProfile.id}`, data);
      } else {
        await api.post('/profil', data);
      }
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  }
});