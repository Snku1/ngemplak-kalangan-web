import { reactive } from 'vue';
import { api } from './api';

export const store = reactive({
  isAuthenticated: localStorage.getItem('ngemplak_admin_auth') === 'true',
  adminUser: { username: 'admin', name: 'Administrator Padukuhan', role: 'Super Admin' },

  // Data collections
  news: [], gallery: [], faqs: [], inbox: [],
  categories: [], umkms: [], agenda: [], pengumuman: [],
  potensiWisata: [], demographics: [], kependudukanDusun: [],
  padukuhanProfile: null,

  get facilities() { return this.potensiWisata; },

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
        beritaRes, galeriRes, faqRes, kategoriRes, umkmRes,
        agendaRes, pengumumanRes, potensiRes, demografiRes, profilRes, kependudukanRes
      ] = await Promise.all([
        api.get('/berita'), api.get('/galeri'),
        api.get('/faq'), api.get('/kategori'), api.get('/umkm'),
        api.get('/agenda'), api.get('/pengumuman'), api.get('/potensi-wisata'),
        api.get('/demografi'), api.get('/profil'), api.get('/kependudukan-dusun')
      ]);

      this.categories = kategoriRes.data;

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
          images: Array.isArray(item.images) ? item.images : [],
          excerpt: item.excerpt || (item.content || '').substring(0, 150) + '...',
          content: item.content || '',
          author: item.author?.nama_lengkap || 'Admin'
        }));

      // ==========================================
      // MAPPING UMKM (menggantikan products)
      // ==========================================
      this.umkms = umkmRes.data.map(item => ({
        id: item.id,
        name: item.nama_usaha,
        nama_usaha: item.nama_usaha,
        nama_penjual: item.nama_penjual,
        seller: item.nama_usaha,
        category: item.kategori || 'UMKM',
        kategori: item.kategori || 'UMKM',
        description: item.deskripsi || '',
        deskripsi: item.deskripsi || '',
        image: item.foto_usaha || '/images/hero-bg.png',
        foto_usaha: item.foto_usaha || '',
        foto_url: item.foto_usaha || '',
        images: Array.isArray(item.images) ? item.images : [],
        daftar_produk: item.daftar_produk || '',
        sellerPhone: item.nomor_whatsapp || '',
        nomor_whatsapp: item.nomor_whatsapp || '',
        alamat_lokasi: item.alamat_lokasi || '',
        sellerMaps: item.maps_lokasi || '',
        maps_lokasi: item.maps_lokasi || '',
        jam_buka: item.jam_buka || '',
        cara_bayar: item.cara_bayar || ''
      }));

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
        images: Array.isArray(item.images) ? item.images : [],
        deskripsi: item.deskripsi || '',
        date: new Date(item.created_at).toLocaleDateString('id-ID'),
        location: item.is_highlight ? 'Highlight' : 'Ngemplak Kalangan',
        description: item.deskripsi || item.judul
      }));

      // FAQ
      this.faqs = faqRes.data.map(item => ({
        id: item.id, question: item.pertanyaan, answer: item.jawaban
      }));

      // Agenda
      this.agenda = agendaRes.data.map(item => ({
        id: item.id,
        month: new Date(item.tanggal_kegiatan).toLocaleString('id-ID', { month: 'short' }),
        day: new Date(item.tanggal_kegiatan).getDate(),
        date: item.tanggal_kegiatan,
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
        date: new Date(item.tanggal_posting).toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' }),
        tanggal_posting: item.tanggal_posting,
        description: item.isi_ringkas,
        isImportant: item.is_important === 1 || item.is_important === true
      }));

      // Potensi Wisata
      this.potensiWisata = potensiRes.data.map(item => ({
        id: item.id,
        nama: item.nama,
        kategori: item.kategori || 'potensi_desa',
        deskripsi: item.deskripsi || '',
        foto_url: item.foto_url || '',
        image: item.foto_url || '/images/hero-bg.png',
        images: Array.isArray(item.images) ? item.images : [],
        lokasi: item.link_gmaps || ''
      }));

      // Demografi
      this.demographics = demografiRes.data.map(item => ({
        id: item.id, kategori: item.kategori, label: item.label, urutan: item.urutan || 0,
        jumlah_jiwa: item.jumlah_jiwa || 0, persentase: item.persentase || 0
      }));

      // Kependudukan
      this.kependudukanDusun = kependudukanRes.data
        .sort((a, b) => (a.urutan || 0) - (b.urutan || 0))
        .map(item => ({
          id: item.id,
          nama_dusun: item.nama_dusun,
          urutan: item.urutan || 0,
          laki_laki: item.laki_laki || 0,
          perempuan: item.perempuan || 0,
          total: item.total || ((item.laki_laki || 0) + (item.perempuan || 0)),
          jumlah_kk: item.jumlah_kk || 0,
          keterangan: item.keterangan || ''
        }));

      // Profil
      if (profilRes.data && profilRes.data.length > 0) {
        const p = profilRes.data[0];
        this.padukuhanProfile = {
          id: p.id,
          nama_padukuhan: p.nama_padukuhan || '',
          kecamatan: p.kecamatan || '',
          kabupaten: p.kabupaten || '',
          provinsi: p.provinsi || '',
          kode_pos: p.kode_pos || '',
          luas_wilayah: p.luas_wilayah || '',
          jumlah_penduduk: p.jumlah_penduduk || 0,
          jumlah_kk: p.jumlah_kk || 0,
          jumlah_rt: p.jumlah_rt || 0,
          jumlah_rw: p.jumlah_rw || 0,
          jumlah_dusun: p.jumlah_dusun || 0,
          batas_utara: p.batas_utara || '',
          batas_selatan: p.batas_selatan || '',
          batas_timur: p.batas_timur || '',
          batas_barat: p.batas_barat || '',
          sejarah: p.sejarah || '',
          cita_cita: p.cita_cita || '',
          nama_dukuh: p.nama_dukuh || '',
          sambutan_dukuh: p.sambutan_dukuh || '',
          foto_dukuh: p.foto_dukuh || '',
          alamat_kantor: p.alamat_kantor || '',
          telepon: p.telepon || '',
          email: p.email || '',
          maps_embed: p.maps_embed || '',
          video_url: p.video_url || '',
          video_thumbnail: p.video_thumbnail || ''
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

  // Di dalam export const store = reactive({ ... })

  async validateSession() {
    if (!this.token) return false;
    try {
      const res = await fetch('/api/me', {
        headers: {
          'Authorization': `Bearer ${this.token}`,
          'Accept': 'application/json',
        },
      });
      if (res.status === 401 || res.status === 403) {
        return false;
      }
      return res.ok;
    } catch (err) {
      // Server mati / tidak bisa dijangkau → anggap invalid
      console.warn('[store] validateSession failed:', err);
      return false;
    }
  },

  // ==========================================
  // CRUD — NEWS
  // ==========================================
  async addNews(item, files = []) {
    try {
      let thumbnail = item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const uploadedUrls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'news');
          if (url) uploadedUrls.push(url);
        }
        if (uploadedUrls.length > 0) {
          thumbnail = uploadedUrls[0];
          images = [...uploadedUrls];
        }
      }

      await api.post('/berita', {
        title: item.title,
        slug: item.title.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '') + '-' + Date.now(),
        content: item.content || '',
        excerpt: item.excerpt || '',
        thumbnail, images,
        category_id: item.category_id || 1,
        author_id: 1,
        status: 'published'
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },

  async updateNews(id, item, files = []) {
    try {
      let thumbnail = item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const uploadedUrls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'news');
          if (url) uploadedUrls.push(url);
        }
        if (uploadedUrls.length > 0) {
          thumbnail = uploadedUrls[0];
          images = [...uploadedUrls];
        }
      }

      await api.put(`/berita/${id}`, {
        title: item.title,
        slug: item.title.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '') + '-' + Date.now(),
        content: item.content || '',
        excerpt: item.excerpt || '',
        thumbnail, images,
        category_id: item.category_id || 1,
        author_id: 1,
        status: 'published'
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async deleteNews(id) { try { await api.delete(`/berita/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  // ==========================================
  // CRUD — UMKM (menggantikan products)
  // ==========================================
  async addUmkm(item, files = []) {
    try {
      let foto_usaha = item.foto_usaha || item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const uploadedUrls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'umkm');
          if (url) uploadedUrls.push(url);
        }
        if (uploadedUrls.length > 0) {
          foto_usaha = uploadedUrls[0];
          images = [...uploadedUrls];
        }
      }

      await api.post('/umkm', {
        nama_penjual: item.nama_penjual || 'Warga Desa',
        nama_usaha: item.name || item.nama_usaha || 'Usaha Desa',
        kategori: item.kategori || item.category || 'UMKM',
        deskripsi: item.deskripsi || item.description || '',
        foto_usaha,
        images,
        daftar_produk: item.daftar_produk || '',
        nomor_whatsapp: item.nomor_whatsapp || '',
        alamat_lokasi: item.alamat_lokasi || '',
        maps_lokasi: item.maps_lokasi || '',
        jam_buka: item.jam_buka || '',
        cara_bayar: item.cara_bayar || ''
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },

  async updateUmkm(id, item, files = []) {
    try {
      let foto_usaha = item.foto_usaha || item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const uploadedUrls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'umkm');
          if (url) uploadedUrls.push(url);
        }
        if (uploadedUrls.length > 0) {
          foto_usaha = uploadedUrls[0];
          images = [...uploadedUrls];
        }
      }

      await api.put(`/umkm/${id}`, {
        nama_penjual: item.nama_penjual || 'Warga Desa',
        nama_usaha: item.name || item.nama_usaha,
        kategori: item.kategori || item.category,
        deskripsi: item.deskripsi || item.description,
        foto_usaha,
        images,
        daftar_produk: item.daftar_produk || '',
        nomor_whatsapp: item.nomor_whatsapp || '',
        alamat_lokasi: item.alamat_lokasi || '',
        maps_lokasi: item.maps_lokasi || '',
        jam_buka: item.jam_buka || '',
        cara_bayar: item.cara_bayar || ''
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },

  async deleteUmkm(id) {
    try { await api.delete(`/umkm/${id}`); await this.initData(); }
    catch (e) { alert(e.message); }
  },

  // ==========================================
  // CRUD — GALLERY
  // ==========================================
  async addGallery(item, files = []) {
    try {
      let file_url = item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const uploadedUrls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'galeri');
          if (url) uploadedUrls.push(url);
        }
        if (uploadedUrls.length > 0) {
          file_url = uploadedUrls[0];
          images = [...uploadedUrls];
        }
      }

      await api.post('/galeri', {
        judul: item.title,
        deskripsi: item.deskripsi || item.description || '',
        tipe: item.type || 'foto',
        category_id: item.category_id || null,
        file_url,
        youtube_url: item.youtube_url || '',
        images
      });
      await this.initData();
    } catch (error) { console.error(error); alert(error.message); }
  },
  async updateGallery(id, item, files = []) {
    try {
      let file_url = item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const uploadedUrls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'galeri');
          if (url) uploadedUrls.push(url);
        }
        if (uploadedUrls.length > 0) {
          file_url = uploadedUrls[0];
          images = [...uploadedUrls];
        }
      }

      await api.put(`/galeri/${id}`, {
        judul: item.title,
        deskripsi: item.deskripsi || item.description || '',
        tipe: item.type || 'foto',
        category_id: item.category_id || null,
        file_url,
        youtube_url: item.youtube_url || '',
        images
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
        judul: item.title,
        isi_ringkas: item.description,
        tanggal_posting: item.tanggal_posting || new Date().toISOString().split('T')[0],
        is_important: item.isImportant ? 1 : 0
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async updatePengumuman(id, item) {
    try {
      await api.put(`/pengumuman/${id}`, {
        judul: item.title,
        isi_ringkas: item.description,
        tanggal_posting: item.tanggal_posting,
        is_important: item.isImportant ? 1 : 0
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deletePengumuman(id) { try { await api.delete(`/pengumuman/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

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
    try { await api.delete(`/kategori/${id}`); await this.initData(); }
    catch (e) { console.error(e); alert(e.message); }
  },

  // ==========================================
  // CRUD — POTENSI WISATA
  // ==========================================
  async addPotensi(item, files = []) {
    try {
      let foto_url = item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const urls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'potensi');
          if (url) urls.push(url);
        }
        if (urls.length > 0) { foto_url = urls[0]; images = [...urls]; }
      }

      await api.post('/potensi-wisata', {
        nama: item.nama,
        kategori: item.kategori === 'Fasilitas / Wisata' ? 'wisata' : (item.kategori || 'potensi_desa'),
        deskripsi: item.deskripsi || '',
        foto_url,
        images,
        link_gmaps: item.lokasi || ''
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },

  async updatePotensi(id, item, files = []) {
    try {
      let foto_url = item.foto_url || '';
      let images = item.images || [];

      if (files && files.length > 0) {
        const urls = [];
        for (const file of files) {
          const url = await this.uploadFile(file, 'potensi');
          if (url) urls.push(url);
        }
        if (urls.length > 0) { foto_url = urls[0]; images = [...urls]; }
      }

      await api.put(`/potensi-wisata/${id}`, {
        nama: item.nama,
        kategori: item.kategori === 'Fasilitas / Wisata' ? 'wisata' : (item.kategori || 'potensi_desa'),
        deskripsi: item.deskripsi,
        foto_url,
        images,
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
        urutan: Number(item.urutan) || 0,
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
        urutan: Number(item.urutan) || 0,
        jumlah_jiwa: Number(item.jumlah_jiwa) || 0,
        persentase: Number(item.persentase) || 0
      });
      await this.initData();
    } catch (e) { console.error(e); alert(e.message); }
  },
  async deleteDemographic(id) { try { await api.delete(`/demografi/${id}`); await this.initData(); } catch (e) { alert(e.message); } },

  demographicsByKategori(kategori) {
    return this.demographics
      .filter(d => d.kategori === kategori)
      .sort((a, b) => (a.urutan || 0) - (b.urutan || 0));
  },

  // ==========================================
  // CRUD — KEPENDUDUKAN DUSUN
  // ==========================================
  async addKependudukan(item) {
    try {
      await api.post('/kependudukan-dusun', {
        nama_dusun: item.nama_dusun,
        urutan: Number(item.urutan) || 0,
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
        nama_dusun: item.nama_dusun,
        urutan: Number(item.urutan) || 0,
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
      // Upload foto kepala dukuh (jika ada file baru)
      if (fotoFile) {
        data.foto_dukuh = await this.uploadFile(fotoFile, 'profil');
      }

      // video_url sudah berupa link YouTube dari form (string)
      // video_thumbnail tidak dipakai lagi — YouTube auto-generate thumbnail

      if (this.padukuhanProfile?.id) {
        await api.put(`/profil/${this.padukuhanProfile.id}`, data);
      } else {
        await api.post('/profil', data);
      }
      await this.initData();
    } catch (e) {
      console.error(e);
      alert(e.message);
    }
  }
});
