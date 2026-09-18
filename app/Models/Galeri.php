<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Galeri extends Model
{
    protected $table = 'galeri';
    protected $fillable = [
        'category_id', 'judul', 'deskripsi',
        'tipe', 'file_url', 'youtube_url', 'images', 'is_highlight'
    ];

    protected $casts = [
        'images' => 'array',
    ];
}