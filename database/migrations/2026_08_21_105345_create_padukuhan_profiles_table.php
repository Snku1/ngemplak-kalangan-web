<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('padukuhan_profiles', function (Blueprint $table) {
            $table->id();
            $table->string('nama_padukuhan', 100);
            $table->string('kecamatan', 100)->nullable();
            $table->string('kabupaten', 100)->nullable();
            $table->string('provinsi', 100)->nullable();
            $table->string('kode_pos', 10)->nullable();
            $table->string('luas_wilayah', 50)->nullable();
            $table->integer('jumlah_penduduk')->default(0);
            $table->integer('jumlah_dusun')->default(0);
            $table->integer('jumlah_rt')->default(0);
            $table->integer('jumlah_rw')->default(0);
            $table->integer('jumlah_kk')->default(0);
            $table->text('sejarah')->nullable();
            $table->string('batas_utara', 150)->nullable();
            $table->string('batas_selatan', 150)->nullable();
            $table->string('batas_timur', 150)->nullable();
            $table->string('batas_barat', 150)->nullable();
            $table->text('cita_cita')->nullable();
            $table->text('alamat_kantor')->nullable();
            $table->string('telepon', 20)->nullable();
            $table->string('email', 100)->nullable();
            $table->string('nama_dukuh', 100)->nullable();
            $table->string('foto_dukuh', 255)->nullable();
            $table->text('sambutan_dukuh')->nullable();
            $table->text('maps_embed')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('padukuhan_profiles');
    }
};
