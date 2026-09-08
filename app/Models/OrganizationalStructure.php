<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrganizationalStructure extends Model
{
    protected $table = 'organizational_structure';

    protected $fillable = ['nama', 'jabatan', 'foto', 'urutan'];

}
