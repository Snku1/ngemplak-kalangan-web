<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DokumenPublik extends Model
{
    protected $table = 'dokumen_publik';

    protected $fillable = ['judul', 'kategori', 'tanggal_unggah', 'format_file', 'ukuran_file', 'file_path', 'deskripsi', 'is_publik'];

}
