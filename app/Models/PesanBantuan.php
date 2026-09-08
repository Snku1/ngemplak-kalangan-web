<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PesanBantuan extends Model
{
    protected $table = 'pesan_bantuan';

    protected $fillable = ['nama_lengkap', 'email', 'pesan'];

}
