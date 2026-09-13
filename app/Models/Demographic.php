<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Demographic extends Model
{
    protected $table = 'demographics';
    protected $fillable = [
        'kategori', 'label', 'urutan', 'jumlah_jiwa', 'persentase'
    ];
}