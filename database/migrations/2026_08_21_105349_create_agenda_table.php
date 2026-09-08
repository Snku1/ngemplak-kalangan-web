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
        Schema::create('agenda', function (Blueprint $table) {
            $table->id();
            $table->string('nama_kegiatan', 150);
            $table->date('tanggal_kegiatan');
            $table->string('waktu', 50);
            $table->string('lokasi', 150);
            $table->text('deskripsi')->nullable();
            $table->enum('status', ['mendatang', 'selesai'])->default('mendatang');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('agenda');
    }
};
