<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Umkm extends Model
{
    protected $table = 'umkm';
    protected $fillable = [
        'nama_penjual', 'nama_usaha', 'kategori', 'deskripsi',
        'foto_usaha', 'images', 'daftar_produk', 'nomor_whatsapp',
        'alamat_lokasi', 'maps_lokasi', 'jam_buka', 'cara_bayar'
    ];

    protected $casts = [
        'images' => 'array',
    ];
}