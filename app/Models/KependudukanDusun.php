<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class KependudukanDusun extends Model
{
    protected $table = 'kependudukan_dusun';
    
    protected $fillable = [
        'nama_rt', 'nama_dusun', 'laki_laki', 'perempuan', 'jumlah_kk', 'keterangan'
    ];

    public function getTotalAttribute(): int
    {
        return $this->laki_laki + $this->perempuan;
    }
}
