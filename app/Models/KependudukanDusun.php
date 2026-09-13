<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class KependudukanDusun extends Model
{
    protected $table = 'kependudukan_dusun';
    
    protected $fillable = [
        'nama_dusun', 'urutan', 'laki_laki', 'perempuan', 'jumlah_kk', 'keterangan'
    ];
}