<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Umkm extends Model
{
    protected $table = 'umkm';

    protected $fillable = ['nama_penjual', 'nama_usaha', 'nomor_whatsapp', 'alamat_lokasi', 'maps_lokasi'];

    public function produk()
    {
        return $this->hasMany(Produk::class, 'penjual_id');
    }

}
