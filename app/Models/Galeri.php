<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Galeri extends Model
{
    protected $table = 'galeri';

    protected $fillable = ['category_id', 'judul', 'tipe', 'file_url', 'youtube_url', 'is_highlight'];

    public function category()
    {
        return $this->belongsTo(MasterKategori::class, 'category_id');
    }

}
