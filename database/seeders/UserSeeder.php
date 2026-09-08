<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Admin default
        User::create([
            'nama_lengkap' => 'admin',
            'email' => 'admin@gmail.com',
            'password' => Hash::make('admin123'), // password: admin123
            'role' => 'admin',
        ]);

        // (Opsional) tambahkan admin lain jika diperlukan
        // User::create([
        //     'nama_lengkap' => 'Admin Desa',
        //     'email' => 'desa@padukuhan.id',
        //     'password' => Hash::make('desa123'),
        //     'role' => 'admin',
        // ]);
    }
}