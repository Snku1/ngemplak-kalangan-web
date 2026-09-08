<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PadukuhanProfile extends Model
{
    protected $table = 'padukuhan_profiles';

    protected $fillable = ['nama_padukuhan', 'kecamatan', 'kabupaten', 'provinsi', 'kode_pos', 'luas_wilayah', 'jumlah_penduduk', 'jumlah_dusun', 'jumlah_rt', 'jumlah_rw', 'jumlah_kk', 'sejarah', 'batas_utara', 'batas_selatan', 'batas_timur', 'batas_barat', 'cita_cita', 'alamat_kantor', 'telepon', 'email', 'nama_dukuh', 'foto_dukuh', 'sambutan_dukuh', 'maps_embed'];

}
