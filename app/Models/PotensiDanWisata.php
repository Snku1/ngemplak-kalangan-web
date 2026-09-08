<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PotensiDanWisata extends Model
{
    protected $table = 'potensi_dan_wisata';

    protected $fillable = ['nama', 'kategori', 'deskripsi', 'foto_url', 'link_gmaps'];

}
