<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Produk extends Model
{
    protected $table = 'produk';

    protected $fillable = ['penjual_id', 'category_id', 'nama_produk', 'harga', 'deskripsi', 'foto_produk', 'is_unggulan', 'status_tersedia'];

    public function umkm()
    {
        return $this->belongsTo(Umkm::class, 'penjual_id');
    }

    public function category()
    {
        return $this->belongsTo(MasterKategori::class, 'category_id');
    }

}
