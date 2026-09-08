<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pengumuman extends Model
{
    protected $table = 'pengumuman';

    protected $fillable = ['category_id', 'judul', 'isi_ringkas', 'tanggal_posting'];

    public function category()
    {
        return $this->belongsTo(MasterKategori::class, 'category_id');
    }

}
