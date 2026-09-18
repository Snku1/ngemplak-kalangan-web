-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2026 at 06:14 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kkn_ngemplan`
--

-- --------------------------------------------------------

--
-- Table structure for table `agenda`
--

CREATE TABLE `agenda` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kegiatan` varchar(150) NOT NULL,
  `tanggal_kegiatan` date NOT NULL,
  `waktu` varchar(50) NOT NULL,
  `lokasi` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `status` enum('mendatang','selesai') NOT NULL DEFAULT 'mendatang',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agenda`
--

INSERT INTO `agenda` (`id`, `nama_kegiatan`, `tanggal_kegiatan`, `waktu`, `lokasi`, `deskripsi`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Lomba 17 Agustus', '2026-09-11', '12:00 - 13:00', 'JOGLO HARDJOSUBRATAN', 'lomba lomba agustusan pokoknya', 'selesai', '2026-09-11 08:53:37', '2026-09-18 02:17:59'),
(2, 'Pengajian Rabu Wage', '2026-09-10', '08:23 - 10:29', 'MASJID AL MUNIR', 'PENGAJIAN RUTIN', 'selesai', '2026-09-11 08:55:03', '2026-09-15 01:34:49'),
(3, 'After Movie Penutupan KKN UNY', '2026-09-19', '19:30 - 21:10', 'RUMAH PAK DUKUH', 'Penutupan KKN UNY di Trimulyo Ngemplak Kalangan', 'mendatang', '2026-09-18 02:08:51', '2026-09-18 02:11:12');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demographics`
--

CREATE TABLE `demographics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kategori` enum('usia','jenis_kelamin','pendidikan','pekerjaan') NOT NULL,
  `label` varchar(100) NOT NULL,
  `urutan` int(11) DEFAULT 0,
  `jumlah_jiwa` int(11) NOT NULL DEFAULT 0,
  `persentase` decimal(5,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `demographics`
--

INSERT INTO `demographics` (`id`, `kategori`, `label`, `urutan`, `jumlah_jiwa`, `persentase`, `created_at`, `updated_at`) VALUES
(1, 'usia', '0-1 TAHUN', 1, 157, 10.00, '2026-09-11 08:19:01', '2026-09-17 04:29:17'),
(2, 'usia', '2-5 tahun', 2, 815, 90.00, '2026-09-11 08:21:22', '2026-09-11 08:21:22'),
(3, 'usia', '0-1 tahun', 1, 156, 2.99, NULL, NULL),
(4, 'usia', '2-5 tahun', 2, 815, 15.61, NULL, NULL),
(5, 'usia', '6-15 tahun', 3, 2250, 43.10, NULL, NULL),
(6, 'usia', '16-30 tahun', 4, 2844, 54.48, NULL, NULL),
(7, 'usia', '31-40 tahun', 5, 1743, 33.39, NULL, NULL),
(8, 'usia', '41-50 tahun', 6, 1716, 32.87, NULL, NULL),
(9, 'usia', '50-60 tahun', 7, 1490, 28.54, NULL, NULL),
(10, 'usia', '60-65 tahun', 8, 555, 10.63, NULL, NULL),
(11, 'jenis_kelamin', 'Laki-laki', 1, 218, 17.72, NULL, '2026-09-18 02:43:29'),
(12, 'usia', '66 tahun ke atas', 9, 1000, 0.00, '2026-09-18 02:42:41', '2026-09-18 02:42:41'),
(13, 'jenis_kelamin', 'Perempuan', 2, 240, 20.00, '2026-09-18 02:43:53', '2026-09-18 02:43:53'),
(14, 'pendidikan', 'Tidak/Belum Sekolah', 1, 10, 2.00, '2026-09-18 02:45:06', '2026-09-18 02:45:06'),
(15, 'pendidikan', 'SD/Sederajat', 2, 55, 15.00, '2026-09-18 02:45:57', '2026-09-18 02:45:57'),
(16, 'pendidikan', 'SMP/Sederajat', 3, 14, 5.00, '2026-09-18 02:46:29', '2026-09-18 02:46:29'),
(17, 'pendidikan', 'SMA/SMK/Sederajat', 4, 25, 10.00, '2026-09-18 02:46:48', '2026-09-18 02:46:48'),
(18, 'pendidikan', 'D3/D4/S1/S2/S3', 5, 20, 16.00, '2026-09-18 02:47:23', '2026-09-18 02:47:23'),
(19, 'pekerjaan', 'Petani/Pekebun', 1, 30, 20.00, '2026-09-18 02:47:47', '2026-09-18 02:47:47'),
(20, 'pekerjaan', 'Buruh/Tani', 2, 18, 20.00, '2026-09-18 02:48:12', '2026-09-18 02:48:12'),
(21, 'pekerjaan', 'Wiraswasta/Pedagang', 3, 14, 5.00, '2026-09-18 02:48:31', '2026-09-18 02:48:31'),
(22, 'pekerjaan', 'Karyawan Swasta', 4, 10, 6.00, '2026-09-18 02:48:51', '2026-09-18 02:48:51'),
(23, 'pekerjaan', 'PNS/TNI/Polri', 5, 7, 1.00, '2026-09-18 02:49:22', '2026-09-18 02:49:22'),
(24, 'pekerjaan', 'Pelajar/Mahasiswa', 6, 40, 20.00, '2026-09-18 02:49:52', '2026-09-18 02:49:52'),
(25, 'pekerjaan', 'Ibu Rumah Tangga', 7, 30, 15.00, '2026-09-18 02:50:15', '2026-09-18 02:50:15'),
(26, 'pekerjaan', 'Tidak Bekerja', 8, 5, 1.00, '2026-09-18 02:50:37', '2026-09-18 02:50:37'),
(27, 'pekerjaan', 'Lainnya', 9, 23, 11.00, '2026-09-18 02:51:08', '2026-09-18 02:51:08');

-- --------------------------------------------------------

--
-- Table structure for table `dokumen_publik`
--

CREATE TABLE `dokumen_publik` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `kategori` varchar(100) NOT NULL,
  `tanggal_unggah` date NOT NULL,
  `format_file` varchar(10) NOT NULL,
  `ukuran_file` varchar(20) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `is_publik` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` varchar(255) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faq`
--

CREATE TABLE `faq` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pertanyaan` text NOT NULL,
  `jawaban` text NOT NULL,
  `kategori` varchar(50) NOT NULL DEFAULT 'umum',
  `urutan` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faq`
--

INSERT INTO `faq` (`id`, `pertanyaan`, `jawaban`, `kategori`, `urutan`, `created_at`, `updated_at`) VALUES
(1, 'Gimana Cara Mendaftar IKD?', 'Harus membawa ktp dan kk untuk scan data diri di dalam aplikasi IKD', 'umum', 0, '2026-09-17 05:09:08', '2026-09-18 02:52:20');

-- --------------------------------------------------------

--
-- Table structure for table `galeri`
--

CREATE TABLE `galeri` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tipe` enum('foto','video') NOT NULL DEFAULT 'foto',
  `file_url` varchar(255) DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `youtube_url` varchar(255) DEFAULT NULL,
  `is_highlight` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `galeri`
--

INSERT INTO `galeri` (`id`, `category_id`, `judul`, `deskripsi`, `tipe`, `file_url`, `images`, `youtube_url`, `is_highlight`, `created_at`, `updated_at`) VALUES
(18, 6, 'Lomba Agustusan Ngemplak', 'Lomba Hari Raya 17 Agustus Ngemplak', 'foto', '/galeri/1789725232_anakanak17.jpeg', '[\"\\/galeri\\/1789725232_anakanak17.jpeg\"]', NULL, 0, '2026-09-16 06:16:06', '2026-09-18 02:53:53'),
(19, 6, 'Lomba Agustusan Kalangan', 'Lomba Hari Raya 17 Agustus Ngemplak', 'foto', '/galeri/1789725274_lombangemplak2.jpeg', '[\"\\/galeri\\/1789725274_lombangemplak2.jpeg\"]', NULL, 0, '2026-09-18 02:54:34', '2026-09-18 02:54:34'),
(20, 6, 'Malam TIrakatan 17 Agustus', 'Malam tirakatan ngemplak kalangan', 'foto', '/galeri/1789725346_tirakatan3.jpeg', '[\"\\/galeri\\/1789725346_tirakatan3.jpeg\",\"\\/galeri\\/1789725346_tirakatan2.jpeg\",\"\\/galeri\\/1789725346_tirakatan1.jpeg\"]', NULL, 0, '2026-09-18 02:55:47', '2026-09-18 02:56:08'),
(21, 6, 'Lomba Voli Bapak-Bapak', 'lomba agustusan voli bapak-bapak', 'foto', '/galeri/1789725447_17ngemplak.jpeg', '[\"\\/galeri\\/1789725447_17ngemplak.jpeg\"]', NULL, 0, '2026-09-18 02:57:27', '2026-09-18 02:57:27'),
(22, 12, 'Temu Perdana Pemuda & Mahasiswa KKN UNY', 'kumpul pemuda dan mahasiswa kkn uny', 'foto', '/galeri/1789725528_pemuda.jpeg', '[\"\\/galeri\\/1789725528_pemuda.jpeg\"]', NULL, 0, '2026-09-18 02:58:48', '2026-09-18 02:58:48'),
(23, 12, 'Pengajian Ranting Trimulyo Selatan', 'pengajian trimulyo selatan', 'foto', '/galeri/1789725586_pengajianranting.jpeg', '[\"\\/galeri\\/1789725586_pengajianranting.jpeg\"]', NULL, 0, '2026-09-18 02:59:46', '2026-09-18 02:59:46'),
(24, 12, 'Latihan Pensi Jaranan', 'latihan pensi jaranan', 'foto', '/galeri/1789725699_jaranan.jpeg', '[\"\\/galeri\\/1789725699_jaranan.jpeg\"]', NULL, 0, '2026-09-18 03:01:40', '2026-09-18 03:01:40'),
(25, 6, 'Lomba Anak Kalangan', 'lomba anak di kalangan', 'foto', '/galeri/1789725899_WhatsAppImage2026-09-18at17.04.38.jpeg', '[\"\\/galeri\\/1789725899_WhatsAppImage2026-09-18at17.04.38.jpeg\"]', NULL, 0, '2026-09-18 03:04:59', '2026-09-18 03:06:56'),
(26, 6, 'Lomba Ibu-Ibu kalangan', 'lomba ibu-ibu di kalangan', 'foto', '/galeri/1789726002_WhatsAppImage2026-09-18at17.04.381.jpeg', '[\"\\/galeri\\/1789726002_WhatsAppImage2026-09-18at17.04.381.jpeg\"]', NULL, 0, '2026-09-18 03:06:43', '2026-09-18 03:06:43'),
(27, 12, 'Manen Tomat', 'Memanen Tomat', 'foto', '/galeri/1789726092_tani.jpeg', '[\"\\/galeri\\/1789726092_tani.jpeg\"]', NULL, 0, '2026-09-18 03:08:13', '2026-09-18 03:08:13'),
(28, 11, 'Mewarnai', NULL, 'foto', '/galeri/1789726236_744a1c4b-cf90-4855-a667-a2c9a1f0e4ec.jpg', '[\"\\/galeri\\/1789726236_744a1c4b-cf90-4855-a667-a2c9a1f0e4ec.jpg\"]', NULL, 0, '2026-09-18 03:10:37', '2026-09-18 03:10:37'),
(29, 12, 'Anak-anak', NULL, 'foto', '/galeri/1789726283_WhatsAppImage2026-09-18at17.09.51.jpeg', '[\"\\/galeri\\/1789726283_WhatsAppImage2026-09-18at17.09.51.jpeg\"]', NULL, 0, '2026-09-18 03:11:23', '2026-09-18 03:11:23'),
(30, 12, 'Arisan Kelompok Tani', NULL, 'foto', '/galeri/1789726414_kelompoktani.jpeg', '[\"\\/galeri\\/1789726414_kelompoktani.jpeg\"]', NULL, 0, '2026-09-18 03:13:35', '2026-09-18 03:13:35'),
(31, 11, 'Senam Kalangan', NULL, 'foto', '/galeri/1789726471_senamkalangan.jpeg', '[\"\\/galeri\\/1789726471_senamkalangan.jpeg\"]', NULL, 0, '2026-09-18 03:14:32', '2026-09-18 03:14:32'),
(32, 11, 'Senam Ngemplak', NULL, 'foto', '/galeri/1789726495_senamsehhat.jpeg', '[\"\\/galeri\\/1789726495_senamsehhat.jpeg\"]', NULL, 0, '2026-09-18 03:14:55', '2026-09-18 03:14:55'),
(33, 12, 'Pengajian Malam Jumat Wage', NULL, 'foto', '/galeri/1789726695_pengajianmalamjumatwage.jpeg', '[\"\\/galeri\\/1789726695_pengajianmalamjumatwage.jpeg\"]', NULL, 0, '2026-09-18 03:18:16', '2026-09-18 03:18:16'),
(34, 12, 'Posyandu Balita & Lansia', NULL, 'foto', '/galeri/1789726762_posyandu.jpeg', '[\"\\/galeri\\/1789726762_posyandu.jpeg\"]', NULL, 0, '2026-09-18 03:19:23', '2026-09-18 03:19:23'),
(35, 6, 'Persiapan Pensi', 'Persiapan Pensi', 'foto', '/galeri/1789726835_jajanjajan.jpeg', '[\"\\/galeri\\/1789726835_jajanjajan.jpeg\"]', NULL, 0, '2026-09-18 03:20:36', '2026-09-18 03:21:21'),
(36, 6, 'Pentas Seni', NULL, 'foto', '/galeri/1789726863_PensiDusunNgemplak.jpeg', '[\"\\/galeri\\/1789726863_PensiDusunNgemplak.jpeg\"]', NULL, 0, '2026-09-18 03:21:03', '2026-09-18 03:21:03'),
(37, 12, 'Arisan Karang Taruna', NULL, 'foto', '/galeri/1789726990_akusingiki.jpeg', '[\"\\/galeri\\/1789726990_akusingiki.jpeg\"]', NULL, 0, '2026-09-18 03:23:10', '2026-09-18 03:23:10'),
(38, 11, 'Budidaya Jamur Tiram', NULL, 'foto', '/galeri/1789727055_budidayajamurtiram.jpeg', '[\"\\/galeri\\/1789727055_budidayajamurtiram.jpeg\"]', NULL, 0, '2026-09-18 03:24:15', '2026-09-18 03:24:15'),
(39, 11, 'Karsa Recycle', NULL, 'foto', '/galeri/1789727083_karsarecycle.jpeg', '[\"\\/galeri\\/1789727083_karsarecycle.jpeg\"]', NULL, 0, '2026-09-18 03:24:44', '2026-09-18 03:24:44'),
(40, 11, 'Plang RT & RW', NULL, 'foto', '/galeri/1789727144_masangplangkalangan.jpeg', '[\"\\/galeri\\/1789727144_masangplangkalangan.jpeg\"]', NULL, 0, '2026-09-18 03:25:44', '2026-09-18 03:25:44'),
(41, 11, 'Karsa Cendekia', NULL, 'foto', '/galeri/1789727212_karsacendekia.jpeg', '[\"\\/galeri\\/1789727212_karsacendekia.jpeg\"]', NULL, 0, '2026-09-18 03:26:53', '2026-09-18 03:26:53'),
(42, 11, 'Fun English Class', NULL, 'foto', '/galeri/1789727251_fun.jpeg', '[\"\\/galeri\\/1789727251_fun.jpeg\"]', NULL, 0, '2026-09-18 03:27:31', '2026-09-18 03:27:31'),
(43, 11, 'Let\'s Play English', NULL, 'foto', '/galeri/1789727357_1789719803_lestplayenglish.jpeg', '[\"\\/galeri\\/1789727357_1789719803_lestplayenglish.jpeg\"]', NULL, 0, '2026-09-18 03:29:17', '2026-09-18 03:29:17'),
(44, 11, 'Fun Coloring Day', NULL, 'foto', '/galeri/1789727415_1789719889_warnawarni.jpeg', '[\"\\/galeri\\/1789727415_1789719889_warnawarni.jpeg\"]', NULL, 0, '2026-09-18 03:30:15', '2026-09-18 03:30:15'),
(45, 11, 'Pojok Baca Karsa', NULL, 'foto', '/galeri/1789727451_1789720242_WhatsAppImage2026-09-18at15.29.19.jpeg', '[\"\\/galeri\\/1789727451_1789720242_WhatsAppImage2026-09-18at15.29.19.jpeg\"]', NULL, 0, '2026-09-18 03:30:52', '2026-09-18 03:30:52'),
(46, 11, 'Storytelling Picture Book', NULL, 'foto', '/galeri/1789727498_1789720295_storytelling.jpeg', '[\"\\/galeri\\/1789727498_1789720295_storytelling.jpeg\"]', NULL, 0, '2026-09-18 03:31:39', '2026-09-18 03:31:39'),
(47, 11, 'Kenali Emosi, Warnai Duniamu', NULL, 'foto', '/galeri/1789727551_1789720527_prokeralya.jpeg', '[\"\\/galeri\\/1789727551_1789720527_prokeralya.jpeg\"]', NULL, 0, '2026-09-18 03:32:32', '2026-09-18 03:32:32'),
(48, 11, 'Misteri Kata Rahasia, Pengenalan Pola, Etika Bermedia Sosial', NULL, 'foto', '/galeri/1789727590_1789720799_WhatsAppImage2026-09-18at15.39.16.jpeg', '[\"\\/galeri\\/1789727590_1789720799_WhatsAppImage2026-09-18at15.39.16.jpeg\"]', NULL, 0, '2026-09-18 03:33:11', '2026-09-18 03:33:11'),
(49, 11, 'FanArt Kids', NULL, 'foto', '/galeri/1789727627_1789720964_tgl8.jpeg', '[\"\\/galeri\\/1789727627_1789720964_tgl8.jpeg\"]', NULL, 0, '2026-09-18 03:33:47', '2026-09-18 03:33:47'),
(50, 11, 'Time Hero', NULL, 'foto', '/galeri/1789727663_1789721026_timehero.jpeg', '[\"\\/galeri\\/1789727663_1789721026_timehero.jpeg\"]', NULL, 0, '2026-09-18 03:34:23', '2026-09-18 03:34:23'),
(51, 11, 'Pembuatan QRIS Kepada Ibu-Ibu PKK Ngemplak Kalangan', NULL, 'foto', '/galeri/1789727701_1789721226_WhatsAppImage2026-09-18at15.46.38.jpeg', '[\"\\/galeri\\/1789727701_1789721226_WhatsAppImage2026-09-18at15.46.38.jpeg\"]', NULL, 0, '2026-09-18 03:35:01', '2026-09-18 03:35:01'),
(52, 11, 'Ikut Mewarnai dan Imajinasi Tanpa Batas', NULL, 'foto', '/galeri/1789727732_1789721442_WhatsAppImage2026-09-18at15.50.09.jpeg', '[\"\\/galeri\\/1789727732_1789721442_WhatsAppImage2026-09-18at15.50.09.jpeg\"]', NULL, 0, '2026-09-18 03:35:32', '2026-09-18 03:35:32'),
(53, 11, 'Website Ngemplak Kalangan', NULL, 'foto', '/galeri/1789727772_1789721539_hasilwebsite.jpeg', '[\"\\/galeri\\/1789727772_1789721539_hasilwebsite.jpeg\"]', NULL, 0, '2026-09-18 03:36:13', '2026-09-18 03:36:13'),
(54, 11, 'Karsa Berkarya: Meronce Gelang', NULL, 'foto', '/galeri/1789727806_1789721751_WhatsAppImage2026-09-18at15.54.24.jpeg', '[\"\\/galeri\\/1789727806_1789721751_WhatsAppImage2026-09-18at15.54.24.jpeg\"]', NULL, 0, '2026-09-18 03:36:47', '2026-09-18 03:36:47'),
(55, 11, 'Karsa Berkarya: Bunga Kawat', NULL, 'foto', '/galeri/1789727837_1789721835_WhatsAppImage2026-09-18at15.54.241.jpeg', '[\"\\/galeri\\/1789727837_1789721835_WhatsAppImage2026-09-18at15.54.241.jpeg\"]', NULL, 0, '2026-09-18 03:37:17', '2026-09-18 03:37:17'),
(56, 11, 'Karsa Pedia', NULL, 'foto', '/galeri/1789727873_1789721965_WhatsAppImage2026-09-18at15.59.09.jpeg', '[\"\\/galeri\\/1789727873_1789721965_WhatsAppImage2026-09-18at15.59.09.jpeg\"]', NULL, 0, '2026-09-18 03:37:54', '2026-09-18 03:37:54'),
(57, 6, 'Jalan Sehat', NULL, 'foto', '/galeri/1789728035_WhatsAppImage2026-09-18at17.40.20.jpeg', '[\"\\/galeri\\/1789728035_WhatsAppImage2026-09-18at17.40.20.jpeg\"]', NULL, 0, '2026-09-18 03:40:35', '2026-09-18 03:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint(5) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kependudukan_dusun`
--

CREATE TABLE `kependudukan_dusun` (
  `id` int(11) NOT NULL,
  `nama_dusun` varchar(100) NOT NULL,
  `urutan` int(11) DEFAULT 0,
  `laki_laki` int(11) DEFAULT 0,
  `perempuan` int(11) DEFAULT 0,
  `jumlah_kk` int(11) DEFAULT 0,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kependudukan_dusun`
--

INSERT INTO `kependudukan_dusun` (`id`, `nama_dusun`, `urutan`, `laki_laki`, `perempuan`, `jumlah_kk`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 'Dusun Ngemplak (I)', 1, 108, 120, 78, 'Data Dusun Ngemplak', '2026-09-12 11:42:20', '2026-09-18 02:41:05'),
(2, 'Dusun Kalangan (II)', 2, 108, 120, 79, 'Data Dusun Kalangan', '2026-09-12 11:42:20', '2026-09-18 02:40:56');

-- --------------------------------------------------------

--
-- Table structure for table `master_kategori`
--

CREATE TABLE `master_kategori` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tipe` enum('berita','umkm','galeri') NOT NULL,
  `nama` varchar(50) NOT NULL,
  `slug` varchar(60) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_kategori`
--

INSERT INTO `master_kategori` (`id`, `tipe`, `nama`, `slug`, `created_at`, `updated_at`) VALUES
(6, 'galeri', 'Agustusan', 'agustusan-1789718574770', '2026-09-16 06:06:55', '2026-09-18 01:02:55'),
(7, 'umkm', 'Warung', 'warung-1789718610051', '2026-09-16 06:13:07', '2026-09-18 01:03:30'),
(9, 'berita', 'Proker', 'proker-1789570159893', '2026-09-16 07:49:21', '2026-09-16 07:49:21'),
(11, 'galeri', 'Proker', 'proker-1789718590345', '2026-09-18 01:03:10', '2026-09-18 01:03:10'),
(12, 'galeri', 'Kegiatan Masyarakat', 'kegiatan-masyarakat-1789718654657', '2026-09-18 01:04:15', '2026-09-18 01:04:15'),
(13, 'berita', 'KKN UNY', 'kkn-uny-1789728276607', '2026-09-18 03:44:37', '2026-09-18 03:44:37');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_08_21_105344_create_master_kategori_table', 1),
(5, '2026_08_21_105345_create_padukuhan_profiles_table', 1),
(6, '2026_08_21_105346_create_demographics_table', 1),
(7, '2026_08_21_105347_create_organizational_structure_table', 1),
(8, '2026_08_21_105348_create_news_table', 1),
(9, '2026_08_21_105349_create_agenda_table', 1),
(10, '2026_08_21_105350_create_pengumuman_table', 1),
(11, '2026_08_21_105351_create_galeri_table', 1),
(12, '2026_08_21_105352_create_umkm_table', 1),
(13, '2026_08_21_105353_create_produk_table', 1),
(14, '2026_08_21_105354_create_potensi_dan_wisata_table', 1),
(15, '2026_08_21_105355_create_pesan_bantuan_table', 1),
(16, '2026_08_21_105356_create_dokumen_publik_table', 1),
(17, '2026_08_21_105357_create_faq_table', 1),
(18, '2026_08_24_103418_create_personal_access_tokens_table', 1),
(19, '2026_09_09_124841_create_kependudukan_dusun_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `excerpt` text DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `view_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `category_id`, `author_id`, `title`, `slug`, `content`, `excerpt`, `thumbnail`, `images`, `status`, `view_count`, `created_at`, `updated_at`) VALUES
(2, 9, 1, 'Sosialisasi Budidaya Jamur Tiram di Ngemplak', '-sosialisasi-budidaya-jamur-tiram-di-ngemplak-1789718811546', 'Program Kerja Budidaya Jamur TIram kepada ibu-ibu kwt', 'Mahasiswa KKN UNY Sosialisasi Budidaya Jamur Tiram', '/news/1789718809_sosialisasibudidayajamurtiram.jpeg', '[\"\\/news\\/1789718809_sosialisasibudidayajamurtiram.jpeg\",\"\\/news\\/1789718810_budidayajamurtiram.jpeg\",\"\\/news\\/1789718810_pembersihanlahanjamur.jpeg\",\"\\/news\\/1789718811_jamur1.jpeg\"]', 'published', 0, '2026-09-16 07:50:57', '2026-09-18 01:06:52'),
(3, 9, 1, 'Bangun Plang RT, RW dan TPA di Ngemplak Kalangan', 'bangun-plang-rt-rw-dan-tpa-di-ngemplak-kalangan-1789719231031', 'Memasang plang penanda arah RT, RW dan TPA', 'Mahasiswa KKN UNY memasang plang guna penanda arah RT, RW dan TPA', '/news/1789719228_masangplangkalangan.jpeg', '[\"\\/news\\/1789719228_masangplangkalangan.jpeg\",\"\\/news\\/1789719229_ngecatwae.jpeg\",\"\\/news\\/1789719229_pemasanganplang.jpeg\",\"\\/news\\/1789719230_pemotongan.jpeg\",\"\\/news\\/1789719230_plang2.jpeg\"]', 'published', 0, '2026-09-18 01:13:51', '2026-09-18 01:13:51'),
(4, 9, 1, 'Karsa Recycle: Memanfaatkan Botol Plastik Bekas Menjadi Gantungan Kunci', '-karsa-recycle-memanfaatkan-botol-plastik-bekas-menjadi-gantungan-kunci-1789719357967', 'Membuat gantungan kunci', 'Mahasiswa KKN UNY memanfaatkan botol plastik Bekas Menjadi Gantungan Kunci', '/news/1789719357_karsarecycle.jpeg', '[\"\\/news\\/1789719357_karsarecycle.jpeg\"]', 'published', 0, '2026-09-18 01:15:58', '2026-09-18 01:15:58'),
(5, 9, 1, 'Karsa Cendekia', 'karsa-cendekia-1789719462063', 'Mahasiswa KKN UNY membantu anak-anak mengerjakan tugas dari sekolah', 'Mahasiswa KKN UNY membantu anak-anak mengerjakan tugas dari sekolah', '/news/1789719462_karsacendekia.jpeg', '[\"\\/news\\/1789719462_karsacendekia.jpeg\"]', 'published', 0, '2026-09-18 01:17:42', '2026-09-18 01:17:42'),
(6, 9, 1, 'Fun English Class', 'fun-english-class-1789719678154', 'Mahasiswa KKN UNY memberikan materi bahasa inggris ke anak-anak', 'Mahasiswa KKN UNY memberikan materi bahasa inggris ke anak-anak', '/news/1789719678_fun.jpeg', '[\"\\/news\\/1789719678_fun.jpeg\"]', 'published', 0, '2026-09-18 01:21:18', '2026-09-18 01:21:18'),
(7, 9, 1, 'Let\'s Play English', 'lets-play-english-1789719803801', 'Mahasiswa KKN UNY memberikan materi bahasa inggris ke anak-anak', 'Mahasiswa KKN UNY memberikan materi bahasa inggris ke anak-anak', '/news/1789719803_lestplayenglish.jpeg', '[\"\\/news\\/1789719803_lestplayenglish.jpeg\"]', 'published', 0, '2026-09-18 01:23:24', '2026-09-18 01:23:24'),
(8, 9, 1, 'Fun Coloring Day', 'fun-coloring-day-1789719889790', 'Mahasiswa KKN UNY mewarnai bersama anak-anak', 'Mahasiswa KKN UNY mewarnai bersama anak-anak', '/news/1789719889_warnawarni.jpeg', '[\"\\/news\\/1789719889_warnawarni.jpeg\"]', 'published', 0, '2026-09-18 01:24:50', '2026-09-18 01:24:50'),
(9, 9, 1, 'Pojok Baca Karsa', 'pojok-baca-karsa-1789720242846', 'Mahasiswa KKN UNY membaca buku bersama anak-anak', 'Mahasiswa KKN UNY membaca buku bersama anak-anak', '/news/1789720242_WhatsAppImage2026-09-18at15.29.19.jpeg', '[\"\\/news\\/1789720242_WhatsAppImage2026-09-18at15.29.19.jpeg\"]', 'published', 0, '2026-09-18 01:30:43', '2026-09-18 01:30:43'),
(10, 9, 1, 'Storytelling Picture Book', 'storytelling-picture-book-1789720295162', 'Mahasiswa KKN UNY membaca buku bahsa inggris bersama anak-anak', 'Mahasiswa KKN UNY membaca buku bahsa inggris bersama anak-anak', '/news/1789720295_storytelling.jpeg', '[\"\\/news\\/1789720295_storytelling.jpeg\"]', 'published', 0, '2026-09-18 01:31:35', '2026-09-18 01:31:35'),
(11, 9, 1, 'Kenali Emosimu, Warnai Duniamu', 'kenali-emosimu-warnai-duniamu-1789720528011', 'Mahasiswa KKN UNY memberikan materi mengenali emosi diri kepada anak-anak', 'Mahasiswa KKN UNY memberikan materi mengenali emosi diri kepada anak-anak', '/news/1789720527_prokeralya.jpeg', '[\"\\/news\\/1789720527_prokeralya.jpeg\"]', 'published', 0, '2026-09-18 01:35:28', '2026-09-18 01:35:28'),
(12, 9, 1, 'Misteri Kata Rahasia, Pengenalan Pola, Etika Bermedia Sosial', 'misteri-kata-rahasia-pengenalan-pola-etika-bermedia-sosial-1789720799559', 'Mahasiswa KKN UNY memberikan materi berpikir kepada anak-anak', 'Mahasiswa KKN UNY memberikan materi berpikir kepada anak-anak', '/news/1789720799_WhatsAppImage2026-09-18at15.39.16.jpeg', '[\"\\/news\\/1789720799_WhatsAppImage2026-09-18at15.39.16.jpeg\"]', 'published', 0, '2026-09-18 01:40:00', '2026-09-18 01:40:00'),
(13, 9, 1, 'FanArt Kids', 'fanart-kids-1789720964654', 'Mahasiswa KKN UNY mewarnai kipas bersama anak-anak', 'Mahasiswa KKN UNY mewarnai kipas bersama anak-anak', '/news/1789720964_tgl8.jpeg', '[\"\\/news\\/1789720964_tgl8.jpeg\"]', 'published', 0, '2026-09-18 01:42:45', '2026-09-18 01:42:45'),
(14, 9, 1, 'Time Hero', 'time-hero-1789721026544', 'Mahasiswa KKN UNY mengajarkan anak-anak untuk memanajemen waktu dengan baik', 'Mahasiswa KKN UNY mengajarkan anak-anak untuk memanajemen waktu dengan baik', '/news/1789721026_timehero.jpeg', '[\"\\/news\\/1789721026_timehero.jpeg\"]', 'published', 0, '2026-09-18 01:43:47', '2026-09-18 01:43:47'),
(15, 9, 1, 'Pembuatan QRIS Kepada Ibu-Ibu PKK Ngemplak Kalangan', 'pembuatan-qris-kepada-ibu-ibu-pkk-ngemplak-kalangan-1789721226342', 'Mahasiswa KKN UNY memberikan pengarahan pembuatan qris untuk membantu usaha ibu-ibu PKK', 'Mahasiswa KKN UNY memberikan pengarahan pembuatan qris untuk membantu usaha ibu-ibu PKK', '/news/1789721226_WhatsAppImage2026-09-18at15.46.38.jpeg', '[\"\\/news\\/1789721226_WhatsAppImage2026-09-18at15.46.38.jpeg\"]', 'published', 0, '2026-09-18 01:47:06', '2026-09-18 01:47:06'),
(16, 9, 1, 'Ikut Mewarnai dan Imajinasi Tanpa Batas', 'ikut-mewarnai-dan-imajinasi-tanpa-batas-1789721442491', 'Mahasiswa KKN UNY mewarnai dan mengimajinasi karakter menjadi gambar karakter', 'Mahasiswa KKN UNY mewarnai dan mengimajinasi karakter menjadi gambar karakter', '/news/1789721442_WhatsAppImage2026-09-18at15.50.09.jpeg', '[\"\\/news\\/1789721442_WhatsAppImage2026-09-18at15.50.09.jpeg\"]', 'published', 0, '2026-09-18 01:50:15', '2026-09-18 01:50:43'),
(17, 9, 1, 'Dorong Digitalisasi, Mahasiswa KKN UNY Kembangkan Website Ngemplak Kalangan', 'dorong-digitalisasi-mahasiswa-kkn-uny-kembangkan-website-ngemplak-kalangan-1789721539388', 'Mahasiswa KKN UNY kembangkan website ngemplak kalangan untuk digitalisasi potensi padukuhan secara digital', 'Mahasiswa KKN UNY kembangkan website ngemplak kalangan', '/news/1789721539_hasilwebsite.jpeg', '[\"\\/news\\/1789721539_hasilwebsite.jpeg\"]', 'published', 0, '2026-09-18 01:52:19', '2026-09-18 01:52:19'),
(18, 9, 1, 'Karsa Berkarya: Meronce Gelang', 'karsa-berkarya-meronce-gelang-1789721751433', 'Mahasiswa KKN UNY memberikan cara memanfaatkan manik-manik sebagai gelang kepada anak-anak', 'Mahasiswa KKN UNY memberikan cara memanfaatkan manik-manik sebagai gelang kepada anak-anak', '/news/1789721751_WhatsAppImage2026-09-18at15.54.24.jpeg', '[\"\\/news\\/1789721751_WhatsAppImage2026-09-18at15.54.24.jpeg\"]', 'published', 0, '2026-09-18 01:54:03', '2026-09-18 01:55:52'),
(19, 9, 1, 'Karsa Berkarya: Bunga Kawat', 'karsa-berkarya-bunga-kawat-1789721835864', 'Mahasiswa KKN UNY memberikan cara memanfaatkan kawat menjadi bunga kepada anak-anak', 'Mahasiswa KKN UNY memberikan cara memanfaatkan kawat menjadi bunga', '/news/1789721835_WhatsAppImage2026-09-18at15.54.241.jpeg', '[\"\\/news\\/1789721835_WhatsAppImage2026-09-18at15.54.241.jpeg\"]', 'published', 0, '2026-09-18 01:57:16', '2026-09-18 01:57:16'),
(20, 9, 1, 'Karsa Pedia', 'karsa-pedia-1789721965851', 'Mahasiswa KKN UNY memberikan informasi struktur kelembagaan & potensi padukuhan ngemplak kalangan', 'Mahasiswa KKN UNY memberikan informasi struktur kelembagaan & potensi ngemplak kalangan', '/news/1789721965_WhatsAppImage2026-09-18at15.59.09.jpeg', '[\"\\/news\\/1789721965_WhatsAppImage2026-09-18at15.59.09.jpeg\"]', 'published', 0, '2026-09-18 01:59:26', '2026-09-18 01:59:26'),
(21, 13, 1, 'Penerjunan Mahasiswa KKN UNY di Kalurahan Trimulyo', 'penerjunan-mahasiswa-kkn-uny-di-kalurahan-trimulyo-1789728290769', 'penerjunan mahasiswa kkn uny di kalurahan trimulyo', 'penerjunan mahasiswa kkn uny di kalurahan trimulyo', '/news/1789728227_penerjunan.jpeg', '[\"\\/news\\/1789728227_penerjunan.jpeg\"]', 'published', 0, '2026-09-18 03:43:48', '2026-09-18 03:44:51'),
(22, 13, 1, 'Pemaparan Program Kerja Mahasiswa KKN UNY kepada Masyarakat', 'pemaparan-program-kerja-mahasiswa-kkn-uny-kepada-masyarakat-1789728364954', 'sosialisasi program kerja mahasiswa uny kepada masyarakat ngemplak kalangan', 'sosialisasi program kerja mahasiswa uny kepada masyarakat ngemplak kalangan', '/news/1789728364_pemaparan.jpeg', '[\"\\/news\\/1789728364_pemaparan.jpeg\"]', 'published', 0, '2026-09-18 03:46:05', '2026-09-18 03:46:05');

-- --------------------------------------------------------

--
-- Table structure for table `padukuhan_profiles`
--

CREATE TABLE `padukuhan_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_padukuhan` varchar(100) NOT NULL,
  `kecamatan` varchar(100) DEFAULT NULL,
  `kabupaten` varchar(100) DEFAULT NULL,
  `provinsi` varchar(100) DEFAULT NULL,
  `kode_pos` varchar(10) DEFAULT NULL,
  `luas_wilayah` varchar(50) DEFAULT NULL,
  `jumlah_penduduk` int(11) NOT NULL DEFAULT 0,
  `jumlah_dusun` int(11) NOT NULL DEFAULT 0,
  `jumlah_rt` int(11) NOT NULL DEFAULT 0,
  `jumlah_rw` int(11) NOT NULL DEFAULT 0,
  `jumlah_kk` int(11) NOT NULL DEFAULT 0,
  `sejarah` text DEFAULT NULL,
  `batas_utara` varchar(150) DEFAULT NULL,
  `batas_selatan` varchar(150) DEFAULT NULL,
  `batas_timur` varchar(150) DEFAULT NULL,
  `batas_barat` varchar(150) DEFAULT NULL,
  `cita_cita` text DEFAULT NULL,
  `alamat_kantor` text DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `nama_dukuh` varchar(100) DEFAULT NULL,
  `foto_dukuh` varchar(255) DEFAULT NULL,
  `sambutan_dukuh` text DEFAULT NULL,
  `maps_embed` text DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `video_thumbnail` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `padukuhan_profiles`
--

INSERT INTO `padukuhan_profiles` (`id`, `nama_padukuhan`, `kecamatan`, `kabupaten`, `provinsi`, `kode_pos`, `luas_wilayah`, `jumlah_penduduk`, `jumlah_dusun`, `jumlah_rt`, `jumlah_rw`, `jumlah_kk`, `sejarah`, `batas_utara`, `batas_selatan`, `batas_timur`, `batas_barat`, `cita_cita`, `alamat_kantor`, `telepon`, `email`, `nama_dukuh`, `foto_dukuh`, `sambutan_dukuh`, `maps_embed`, `video_url`, `video_thumbnail`, `created_at`, `updated_at`) VALUES
(1, 'Ngemplak Kalangan', 'Trimulyo', 'Sleman', 'D.I.Y', '55513', '140201.23 m²', 458, 2, 4, 2, 157, 'Secara etimologis, nama Padukuhan Ngemplak Kalangan berakar dari gabungan dua suku kata bahasa Jawa yang sarat makna kebudayaan dan ruang pemukiman masyarakat Mataram. Kata \"Ngemplak\" diturunkan dari istilah Jawa yang merujuk pada bentangan lahan subur, pekarangan terbuka (mblak-mblakan), atau wilayah pemukiman baru (mbubak desa) yang tumbuh meluas di sepanjang kawasan pertanian. Sementara itu, kata \"Kalangan\" secara historis memaknai sebuah pusat pertemuan, arena interaksi, atau wadah berkumpulnya para tokoh masyarakat dan warga (kalangan) dalam melangsungkan musyawarah, tradisi kemasyarakatan, maupun kegiatan sosial-ekonomi lokal pada masa lalu. Penggabungan kedua kata tersebut membentuk identitas historis Ngemplak Kalangan sebagai wilayah pemukiman subur yang sejak awal berdiri menjadi pusat interaksi guyub rukun bagi warganya.\n\nDalam perkembangannya, tata kelola wilayah Padukuhan Ngemplak Kalangan tidak terlepas dari dinamika geopolitik Daerah Istimewa Yogyakarta. Pasca-reorganisasi pemerintahan tingkat desa seiring berdirinya Negara Kesatuan Republik Indonesia dan Kasultanan Ngayogyakarta Hadiningrat, wilayah ini secara resmi terintegrasi menjadi bagian dari Kalurahan Trimulyo, Kapanewon Sleman, Kabupaten Sleman. Berada di lingkungan agraris yang asri, masyarakat Padukuhan Ngemplak Kalangan mempertahankan warisan kearifan lokal berupa tradisi gotong royong, kebersamaan, dan keharmonisan sosial yang diwariskan secara turun-temurun dari para leluhur perintis kampung.\n\nHingga kini, Padukuhan Ngemplak Kalangan terus bertransformasi menjadi kawasan pemukiman yang dinamis tanpa meninggalkan akar budayanya. Perpaduan antara potensi lokal, semangat kepemudaan, serta penerapan inovasi dan kebudayaan menjadikan Padukuhan Ngemplak Kalangan sebagai bagian penting dari ketahanan sosial dan ekonomi Kalurahan Trimulyo, berdiri kokoh menjunjung tinggi falsafah memayu hayuning bawana.', 'JOGLO KALANGAN', 'RUMAH SAKIT', 'SEKOLAH', 'HOTEL', 'Padukuhan Ngemplak Kalangan bercita-cita untuk menjadi wilayah pemukiman yang mandiri, sejahtera, dan berdaya saing tinggi dengan tetap berpijak kokoh pada akar kearifan lokal serta kelestarian lingkungan. Ke depan, Ngemplak Kalangan bertekad mewujudkan masyarakat yang harmonis dan berpendidikan, di mana potensi ekonomi lokal—seperti UMKM, inovasi pertanian, dan kreativitas warga—dapat berkembang secara optimal demi kemakmuran bersama. Melalui penguatan semangat gotong royong, keterbukaan informasi digital, serta partisipasi aktif generasi muda, Padukuhan Ngemplak Kalangan berkomitmen menciptakan lingkungan yang asri, aman, dan berbudaya yang mampu beradaptasi dengan kemajuan zaman tanpa kehilangan identitas kejati-diriannya.Cita-Cita Padukuhan Ngemplak Kalangan\nPadukuhan Ngemplak Kalangan bercita-cita untuk menjadi wilayah pemukiman yang mandiri, sejahtera, dan berdaya saing tinggi dengan tetap berpijak kokoh pada akar kearifan lokal serta kelestarian lingkungan. Ke depan, Ngemplak Kalangan bertekad mewujudkan masyarakat yang harmonis dan berpendidikan, di mana potensi ekonomi lokal—seperti UMKM, inovasi pertanian, dan kreativitas warga—dapat berkembang secara optimal demi kemakmuran bersama. Melalui penguatan semangat gotong royong, keterbukaan informasi digital, serta partisipasi aktif generasi muda, Padukuhan Ngemplak Kalangan berkomitmen menciptakan lingkungan yang asri, aman, dan berbudaya yang mampu beradaptasi dengan kemajuan zaman tanpa kehilangan identitas kejati-diriannya.', 'Ngemplak Kolangan, Trimulyo, Kec. Sleman, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55513', '082328030131', 'ngemplakkalangan@gmail.com', 'Supriyanto', '/profil/1789710913_Screenshot2026-09-18103402.png', 'Assalamu’alaikum Warahmatullahi Wabarakatuh,\n\nSalam Sejahtera, Sugeng Rawuh.\n\nPuji dan syukur kita panjatkan ke hadirat Allah SWT atas rahmat dan karunia-Nya, website resmi Padukuhan Ngemplak Kalangan ini dapat hadir di tengah-tengah kita.\n\nKehadiran platform digital ini merupakan langkah nyata kami dalam mendorong transparansi informasi, mengenalkan potensi wilayah, serta mempererat tali silaturahmi antara pemerintah padukuhan, warga masyarakat, dan khalayak luas. Di sini, Anda dapat mengakses berbagai informasi mengenai sejarah, profil, potensi ekonomi lokal, hingga kegiatan kemasyarakatan yang ada di padukuhan kami.\n\nKami berharap media ini tidak hanya menjadi jendela informasi, tetapi juga menjadi sarana kolaborasi untuk mewujudkan Padukuhan Ngemplak Kalangan yang mandiri, sejahtera, berbudaya, dan bernilai gotong royong. Terima kasih atas kunjungan Anda, mari bersama-sama kita bangun Ngemplak Kalangan yang lebih maju dan berdaya.\n\nWassalamu’alaikum Warahmatullahi Wabarakatuh.', 'https://www.google.com/maps/@-7.67345093881866,110.36707388003661', 'https://youtu.be/gd8-mELj3FQ', '/videos/1789706733_thumbnailvideoprofil.png', '2026-09-11 00:34:09', '2026-09-17 22:55:14');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengumuman`
--

CREATE TABLE `pengumuman` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi_ringkas` text NOT NULL,
  `tanggal_posting` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_important` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengumuman`
--

INSERT INTO `pengumuman` (`id`, `judul`, `isi_ringkas`, `tanggal_posting`, `created_at`, `updated_at`, `is_important`) VALUES
(4, 'PENDAFTARAN IKD', 'TEMPAT DI RUMAH PAK DUKUH', '2026-09-12', '2026-09-12 04:29:56', '2026-09-18 02:11:42', 1);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(23, 'App\\Models\\User', 1, 'KknNgemplakApp', 'f75e3ec47f5875def49a56671e67be5c81983a8811db52c75198b1e2cac5e290', '[\"*\"]', '2026-09-16 23:16:20', NULL, '2026-09-16 23:16:19', '2026-09-16 23:16:20'),
(32, 'App\\Models\\User', 1, 'KknNgemplakApp', '9dfffe3670dc5db44c15d3e90b36d0c1912b0ddbd7fca41369872592731ad9ee', '[\"*\"]', '2026-09-17 21:41:30', NULL, '2026-09-17 21:41:25', '2026-09-17 21:41:30'),
(34, 'App\\Models\\User', 1, 'KknNgemplakApp', 'f99f1bc2fe071fec3211e833a9b19d73b133cedbffb045d3d3e83890f97d3f23', '[\"*\"]', '2026-09-17 22:55:22', NULL, '2026-09-17 22:54:42', '2026-09-17 22:55:22');

-- --------------------------------------------------------

--
-- Table structure for table `pesan_bantuan`
--

CREATE TABLE `pesan_bantuan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pesan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `potensi_dan_wisata`
--

CREATE TABLE `potensi_dan_wisata` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL,
  `kategori` enum('potensi_desa','wisata') NOT NULL DEFAULT 'potensi_desa',
  `deskripsi` text DEFAULT NULL,
  `foto_url` varchar(255) DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `link_gmaps` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `potensi_dan_wisata`
--

INSERT INTO `potensi_dan_wisata` (`id`, `nama`, `kategori`, `deskripsi`, `foto_url`, `images`, `link_gmaps`, `created_at`, `updated_at`) VALUES
(1, 'Joglo Kalangan', 'wisata', 'ecolife.walk adalah event jalan kaki rekreasi dan healing yang mengajak peserta menikmati suasana pedesaan yang sejuk dan asri, sekaligus memperkenalkan serta mempelajari gaya hidup ekologi melalui konsep kembali ke alam.', '/potensi/1789723788_WhatsAppImage2026-09-18at16.16.082.jpeg', '[\"\\/potensi\\/1789723788_WhatsAppImage2026-09-18at16.16.082.jpeg\",\"\\/potensi\\/1789723788_WhatsAppImage2026-09-18at16.16.081.jpeg\",\"\\/potensi\\/1789723789_WhatsAppImage2026-09-18at16.16.08.jpeg\",\"\\/potensi\\/1789723790_WhatsAppImage2026-09-18at16.16.07.jpeg\"]', 'https://www.google.com/maps/@-7.673021892754033,110.3652587450281', '2026-09-11 07:58:34', '2026-09-18 02:29:50'),
(2, 'Joglo HardjoSubratan', 'wisata', 'Warisan Budaya Nenek Moyang, Tonggak Sejarah TEMPO DOELOE', '/potensi/1789723906_WhatsAppImage2026-09-18at16.16.04.jpeg', '[\"\\/potensi\\/1789723906_WhatsAppImage2026-09-18at16.16.04.jpeg\",\"\\/potensi\\/1789723907_WhatsAppImage2026-09-18at16.15.59.jpeg\"]', NULL, '2026-09-18 02:17:27', '2026-09-18 02:31:47');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('cqBIYrb1qSgrqW154abQmbTTVqdBXiA2t2bbNiCZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJHT1FvYnpIcFlDZlVjYUJWVU90WnpSU1MwOXU5TmZzaFFWdXJTQWVpIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9hZG1pbiIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1789710873),
('PPFOU99lwYNsP73ldECQbIPYbav9RZzUTSnD37E4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.136.2 Chrome/148.0.7778.280 Electron/42.10.0 Safari/537.36', 'eyJfdG9rZW4iOiJ5cUhWamVJN25GdEFOT2VCRDMwall3UjZhSkZGZ25jZk5yMThwVm1UIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1789713580),
('quroBzbhlQjAugmLs1w1ffa9GWVxcZw8PUMVxt63', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJZaU9GWVZaV0JiMzVid1hVWU8yUGlDZ0kySzlrQzd6Z2tMR3JXWjV2IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1789730055);

-- --------------------------------------------------------

--
-- Table structure for table `umkm`
--

CREATE TABLE `umkm` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_penjual` varchar(100) NOT NULL,
  `nama_usaha` varchar(100) NOT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `daftar_produk` text DEFAULT NULL,
  `foto_usaha` varchar(255) DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `nomor_whatsapp` varchar(20) NOT NULL,
  `alamat_lokasi` text DEFAULT NULL,
  `maps_lokasi` varchar(255) DEFAULT NULL,
  `jam_buka` varchar(100) DEFAULT NULL,
  `cara_bayar` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `umkm`
--

INSERT INTO `umkm` (`id`, `nama_penjual`, `nama_usaha`, `kategori`, `deskripsi`, `daftar_produk`, `foto_usaha`, `images`, `nomor_whatsapp`, `alamat_lokasi`, `maps_lokasi`, `jam_buka`, `cara_bayar`, `created_at`, `updated_at`) VALUES
(1, 'Mbak Ferry', 'Warung Mbak Ferry', 'Warung', 'Warung usaha yang menyediakan aneka jajanan anak-anak seperti tempura, pop ice, ice cream, dll.', 'Tempura\nPop Ice\nAneka Ice Cream\nJajanan anak-anak, dll.', NULL, '[]', '082328030131', 'Deket Rumah Pak Dukuh, Ngemplak Kalangan', 'https://maps.app.goo.gl/XL3TMFDp7qjjsoAa8', '08.00-17.00', 'Tunai, QRIS', '2026-09-11 09:12:42', '2026-09-18 02:05:37'),
(2, 'SUMINAH', 'SUMINAH', 'Makanan', NULL, NULL, NULL, '[]', '082328030131', 'Ngemplak Kalangan', 'https://maps.app.goo.gl/XL3TMFDp7qjjsoAa8', NULL, NULL, '2026-09-11 12:26:45', '2026-09-16 07:47:53'),
(3, 'Ibu nya Rizki', 'Warung Rizky', 'Warung', 'burjo', 'tempura\napa\naja', '/umkm/1789546439_belajarmaterijamur10agus.jpeg', '[\"\\/umkm\\/1789546439_belajarmaterijamur10agus.jpeg\",\"\\/umkm\\/1789546441_bersih-bersihkkn.jpeg\"]', '082328030131', 'Ngemplak Kalangan', NULL, '09.00 - 17.00', 'TUNAI, QRIS', '2026-09-15 05:44:44', '2026-09-18 02:06:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin') NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama_lengkap`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', '$2y$12$CsKfjwciaSPHUcZhDEEliOES3WqxReIZoOk5YrNBsmStva9GZpd96', 'admin', '2026-09-09 04:53:49', '2026-09-09 04:53:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `demographics`
--
ALTER TABLE `demographics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dokumen_publik`
--
ALTER TABLE `dokumen_publik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `faq`
--
ALTER TABLE `faq`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `galeri`
--
ALTER TABLE `galeri`
  ADD PRIMARY KEY (`id`),
  ADD KEY `galeri_category_id_foreign` (`category_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kependudukan_dusun`
--
ALTER TABLE `kependudukan_dusun`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_kategori`
--
ALTER TABLE `master_kategori`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_kategori_slug_unique` (`slug`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `news_slug_unique` (`slug`),
  ADD KEY `news_category_id_foreign` (`category_id`),
  ADD KEY `news_author_id_foreign` (`author_id`);

--
-- Indexes for table `padukuhan_profiles`
--
ALTER TABLE `padukuhan_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `pesan_bantuan`
--
ALTER TABLE `pesan_bantuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `potensi_dan_wisata`
--
ALTER TABLE `potensi_dan_wisata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `umkm`
--
ALTER TABLE `umkm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `demographics`
--
ALTER TABLE `demographics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `dokumen_publik`
--
ALTER TABLE `dokumen_publik`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faq`
--
ALTER TABLE `faq`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `galeri`
--
ALTER TABLE `galeri`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kependudukan_dusun`
--
ALTER TABLE `kependudukan_dusun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_kategori`
--
ALTER TABLE `master_kategori`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `padukuhan_profiles`
--
ALTER TABLE `padukuhan_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `pesan_bantuan`
--
ALTER TABLE `pesan_bantuan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `potensi_dan_wisata`
--
ALTER TABLE `potensi_dan_wisata`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `umkm`
--
ALTER TABLE `umkm`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `galeri`
--
ALTER TABLE `galeri`
  ADD CONSTRAINT `galeri_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `master_kategori` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `news_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `master_kategori` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
