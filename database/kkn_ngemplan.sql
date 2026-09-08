-- =============================================================
-- DATABASE PADUKUHAN NGEMPLAK KALANGAN (Versi Final)
-- Tanpa login warga, tanpa pendaftaran penjual, tanpa pengajuan surat
-- Admin hanya di tabel users
-- Pemilik UMKM memiliki kolom maps_lokasi
-- =============================================================
-- =============================================================
-- 1. Tabel Users (Admin)
-- =============================================================
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin') NOT NULL DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 2. Tabel Master Kategori (Terpusat)
-- =============================================================
CREATE TABLE master_kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipe ENUM('berita', 'produk', 'galeri', 'pengumuman') NOT NULL,
    nama VARCHAR(50) NOT NULL,
    slug VARCHAR(60) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 3. Tabel Profil Padukuhan (dengan tambahan kolom)
-- =============================================================
CREATE TABLE padukuhan_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_padukuhan VARCHAR(100) NOT NULL,
    kecamatan VARCHAR(100) NULL,
    kabupaten VARCHAR(100) NULL,
    provinsi VARCHAR(100) NULL,
    kode_pos VARCHAR(10) NULL,
    luas_wilayah VARCHAR(50) NULL,
    jumlah_penduduk INT DEFAULT 0,
    jumlah_dusun INT DEFAULT 0,
    jumlah_rt INT DEFAULT 0,
    jumlah_rw INT DEFAULT 0,
    jumlah_kk INT DEFAULT 0,
    sejarah TEXT NULL,
    batas_utara VARCHAR(150) NULL,
    batas_selatan VARCHAR(150) NULL,
    batas_timur VARCHAR(150) NULL,
    batas_barat VARCHAR(150) NULL,
    cita_cita TEXT NULL,
    alamat_kantor TEXT NULL,
    telepon VARCHAR(20) NULL,
    email VARCHAR(100) NULL,
    nama_dukuh VARCHAR(100) NULL,
    foto_dukuh VARCHAR(255) NULL,
    sambutan_dukuh TEXT NULL,
    maps_embed TEXT NULL
) ENGINE=InnoDB;

-- =============================================================
-- 4. Tabel Demografi
-- =============================================================
CREATE TABLE demographics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kategori ENUM('usia', 'jenis_kelamin', 'pendidikan', 'pekerjaan') NOT NULL,
    label VARCHAR(100) NOT NULL,
    jumlah_jiwa INT DEFAULT 0,
    persentase DECIMAL(5,2) DEFAULT 0.00
) ENGINE=InnoDB;

-- =============================================================
-- 5. Tabel Struktur Organisasi
-- =============================================================
CREATE TABLE organizational_structure (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jabatan VARCHAR(100) NOT NULL,
    foto VARCHAR(255) NULL,
    urutan INT DEFAULT 0
) ENGINE=InnoDB;

-- =============================================================
-- 6. Tabel Berita (News)
-- =============================================================
CREATE TABLE news (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    author_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    content LONGTEXT NOT NULL,
    thumbnail VARCHAR(255) NULL,
    tags VARCHAR(255) NULL,
    status ENUM('draft', 'published') DEFAULT 'draft',
    view_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES master_kategori(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 7. Tabel Agenda (dengan deskripsi)
-- =============================================================
CREATE TABLE agenda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kegiatan VARCHAR(150) NOT NULL,
    tanggal_kegiatan DATE NOT NULL,
    waktu VARCHAR(50) NOT NULL,
    lokasi VARCHAR(150) NOT NULL,
    deskripsi TEXT NULL,
    status ENUM('mendatang', 'selesai') DEFAULT 'mendatang',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 8. Tabel Pengumuman
-- =============================================================
CREATE TABLE pengumuman (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    judul VARCHAR(200) NOT NULL,
    isi_ringkas TEXT NOT NULL,
    tanggal_posting DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES master_kategori(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 9. Tabel Galeri
-- =============================================================
CREATE TABLE galeri (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    judul VARCHAR(150) NOT NULL,
    tipe ENUM('foto', 'video') DEFAULT 'foto',
    file_url VARCHAR(255) NULL,
    youtube_url VARCHAR(255) NULL,
    is_highlight BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES master_kategori(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 10. Tabel Pemilik UMKM (Penjual Aktif) - dengan maps_lokasi
-- =============================================================
CREATE TABLE umkm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_penjual VARCHAR(100) NOT NULL,
    nama_usaha VARCHAR(100) NOT NULL,
    nomor_whatsapp VARCHAR(20) NOT NULL,
    alamat_lokasi TEXT NULL,
    maps_lokasi VARCHAR(255) NULL, -- URL Google Maps atau embed link
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 11. Tabel Produk
-- =============================================================
CREATE TABLE produk (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    penjual_id INT NOT NULL,
    category_id INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(12,2) NOT NULL,
    deskripsi TEXT NULL,
    foto_produk VARCHAR(255) NULL,
    is_unggulan BOOLEAN DEFAULT FALSE,
    status_tersedia BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (penjual_id) REFERENCES umkm(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES master_kategori(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
-- 12. Tabel Potensi Desa & Wisata
-- =============================================================
CREATE TABLE potensi_dan_wisata (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(150) NOT NULL,
    kategori ENUM('potensi_desa', 'wisata') DEFAULT 'potensi_desa',
    deskripsi TEXT NULL,
    foto_url VARCHAR(255) NULL,
    link_gmaps VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 13. Tabel Pesan Bantuan (dengan tipe)
-- =============================================================
CREATE TABLE pesan_bantuan (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    pesan TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 14. Tabel Dokumen Publik (Arsip Digital)
-- =============================================================
CREATE TABLE dokumen_publik (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    kategori VARCHAR(100) NOT NULL,
    tanggal_unggah DATE NOT NULL,
    format_file VARCHAR(10) NOT NULL,
    ukuran_file VARCHAR(20) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    deskripsi TEXT NULL,
    is_publik BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =============================================================
-- 15. Tabel FAQ
-- =============================================================
CREATE TABLE faq (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pertanyaan TEXT NOT NULL,
    jawaban TEXT NOT NULL,
    kategori VARCHAR(50) DEFAULT 'umum',
    urutan INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;