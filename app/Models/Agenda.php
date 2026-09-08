<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Agenda extends Model
{
    protected $table = 'agenda';

    protected $fillable = ['nama_kegiatan', 'tanggal_kegiatan', 'waktu', 'lokasi', 'deskripsi', 'status'];

}
