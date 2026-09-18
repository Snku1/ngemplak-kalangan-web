<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Import Controllers
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\MasterKategoriController;
use App\Http\Controllers\Api\PadukuhanProfileController;
use App\Http\Controllers\Api\DemographicController;
use App\Http\Controllers\Api\NewsController;
use App\Http\Controllers\Api\AgendaController;
use App\Http\Controllers\Api\PengumumanController;
use App\Http\Controllers\Api\GaleriController;
use App\Http\Controllers\Api\UmkmController;
use App\Http\Controllers\Api\PotensiDanWisataController;
use App\Http\Controllers\Api\PesanBantuanController;
use App\Http\Controllers\Api\DokumenPublikController;
use App\Http\Controllers\Api\FaqController;
use App\Http\Controllers\Api\KependudukanDusunController;
use App\Http\Controllers\Api\FileUploadController;

// Auth Routes
Route::post('login', [AuthController::class, 'login']);

// ==========================================
// PUBLIC ROUTES (Bisa diakses tanpa login)
// ==========================================

// Kategori
Route::get('kategori', [MasterKategoriController::class, 'index']);
Route::get('kategori/{id}', [MasterKategoriController::class, 'show']);

// Padukuhan Profile
Route::get('profil', [PadukuhanProfileController::class, 'index']);
Route::get('profil/{id}', [PadukuhanProfileController::class, 'show']);

// Demografi
Route::get('demografi', [DemographicController::class, 'index']);
Route::get('demografi/{id}', [DemographicController::class, 'show']);

// Berita (News)
Route::get('berita', [NewsController::class, 'index']);
Route::get('berita/{id}', [NewsController::class, 'show']);

// Agenda
Route::get('agenda', [AgendaController::class, 'index']);
Route::get('agenda/{id}', [AgendaController::class, 'show']);

// Pengumuman
Route::get('pengumuman', [PengumumanController::class, 'index']);
Route::get('pengumuman/{id}', [PengumumanController::class, 'show']);

// Galeri
Route::get('galeri', [GaleriController::class, 'index']);
Route::get('galeri/{id}', [GaleriController::class, 'show']);

// UMKM & Produk
Route::get('umkm', [UmkmController::class, 'index']);
Route::get('umkm/{id}', [UmkmController::class, 'show']);

// Potensi & Wisata
Route::get('potensi-wisata', [PotensiDanWisataController::class, 'index']);
Route::get('potensi-wisata/{id}', [PotensiDanWisataController::class, 'show']);

// Dokumen Publik
Route::get('dokumen-publik', [DokumenPublikController::class, 'index']);
Route::get('dokumen-publik/{id}', [DokumenPublikController::class, 'show']);

// FAQ
Route::get('faq', [FaqController::class, 'index']);
Route::get('faq/{id}', [FaqController::class, 'show']);

// Pesan Bantuan (Publik HANYA bisa mengirim POST)
Route::post('pesan-bantuan', [PesanBantuanController::class, 'store']);

// Kependudukan Dusun (Publik GET)
Route::get('kependudukan-dusun', [KependudukanDusunController::class, 'index']);
Route::get('kependudukan-dusun/{id}', [KependudukanDusunController::class, 'show']);


// ==========================================
// PROTECTED ROUTES (Harus Login / Pakai Token)
// ==========================================
Route::middleware('auth:sanctum')->group(function () {
    Route::get('me', [AuthController::class, 'me']);   // ← TAMBAH
    Route::post('logout', [AuthController::class, 'logout']);

    // Kategori
    Route::post('kategori', [MasterKategoriController::class, 'store']);
    Route::put('kategori/{id}', [MasterKategoriController::class, 'update']);
    Route::delete('kategori/{id}', [MasterKategoriController::class, 'destroy']);

    // Padukuhan Profile
    Route::post('profil', [PadukuhanProfileController::class, 'store']);
    Route::put('profil/{id}', [PadukuhanProfileController::class, 'update']);
    Route::delete('profil/{id}', [PadukuhanProfileController::class, 'destroy']);

    // Demografi
    Route::post('demografi', [DemographicController::class, 'store']);
    Route::put('demografi/{id}', [DemographicController::class, 'update']);
    Route::delete('demografi/{id}', [DemographicController::class, 'destroy']);

    // Berita
    Route::post('berita', [NewsController::class, 'store']);
    Route::put('berita/{id}', [NewsController::class, 'update']);
    Route::delete('berita/{id}', [NewsController::class, 'destroy']);

    // Agenda
    Route::post('agenda', [AgendaController::class, 'store']);
    Route::put('agenda/{id}', [AgendaController::class, 'update']);
    Route::delete('agenda/{id}', [AgendaController::class, 'destroy']);

    // Pengumuman
    Route::post('pengumuman', [PengumumanController::class, 'store']);
    Route::put('pengumuman/{id}', [PengumumanController::class, 'update']);
    Route::delete('pengumuman/{id}', [PengumumanController::class, 'destroy']);

    // Galeri
    Route::post('galeri', [GaleriController::class, 'store']);
    Route::put('galeri/{id}', [GaleriController::class, 'update']);
    Route::delete('galeri/{id}', [GaleriController::class, 'destroy']);

    // UMKM & Produk
    Route::post('umkm', [UmkmController::class, 'store']);
    Route::put('umkm/{id}', [UmkmController::class, 'update']);
    Route::delete('umkm/{id}', [UmkmController::class, 'destroy']);

    // Potensi & Wisata
    Route::post('potensi-wisata', [PotensiDanWisataController::class, 'store']);
    Route::put('potensi-wisata/{id}', [PotensiDanWisataController::class, 'update']);
    Route::delete('potensi-wisata/{id}', [PotensiDanWisataController::class, 'destroy']);

    // Dokumen Publik
    Route::post('dokumen-publik', [DokumenPublikController::class, 'store']);
    Route::put('dokumen-publik/{id}', [DokumenPublikController::class, 'update']);
    Route::delete('dokumen-publik/{id}', [DokumenPublikController::class, 'destroy']);

    // FAQ
    Route::post('faq', [FaqController::class, 'store']);
    Route::put('faq/{id}', [FaqController::class, 'update']);
    Route::delete('faq/{id}', [FaqController::class, 'destroy']);

    // Pesan Bantuan (Admin HANYA bisa GET dan DELETE)
    Route::get('pesan-bantuan', [PesanBantuanController::class, 'index']);
    Route::get('pesan-bantuan/{id}', [PesanBantuanController::class, 'show']);
    Route::delete('pesan-bantuan/{id}', [PesanBantuanController::class, 'destroy']);

    // Kependudukan Dusun
    Route::post('kependudukan-dusun', [KependudukanDusunController::class, 'store']);
    Route::put('kependudukan-dusun/{id}', [KependudukanDusunController::class, 'update']);
    Route::delete('kependudukan-dusun/{id}', [KependudukanDusunController::class, 'destroy']);

    // File Upload
    Route::post('upload', [FileUploadController::class, 'upload']);
});
