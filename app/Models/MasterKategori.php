<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MasterKategori extends Model
{
    protected $table = 'master_kategori';

    protected $fillable = ['tipe', 'nama', 'slug'];

    public function news()
    {
        return $this->hasMany(News::class, 'category_id');
    }

    public function pengumuman()
    {
        return $this->hasMany(Pengumuman::class, 'category_id');
    }

    public function galeri()
    {
        return $this->hasMany(Galeri::class, 'category_id');
    }

    public function produk()
    {
        return $this->hasMany(Produk::class, 'category_id');
    }

}
