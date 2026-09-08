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
        Schema::create('dokumen_publik', function (Blueprint $table) {
            $table->id();
            $table->string('judul', 255);
            $table->string('kategori', 100);
            $table->date('tanggal_unggah');
            $table->string('format_file', 10);
            $table->string('ukuran_file', 20);
            $table->string('file_path', 255);
            $table->text('deskripsi')->nullable();
            $table->boolean('is_publik')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dokumen_publik');
    }
};
