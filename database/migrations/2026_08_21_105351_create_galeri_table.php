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
        Schema::create('galeri', function (Blueprint $table) {
            $table->id();
            $table->foreignId('category_id')->constrained('master_kategori')->cascadeOnDelete();
            $table->string('judul', 150);
            $table->enum('tipe', ['foto', 'video'])->default('foto');
            $table->string('file_url', 255)->nullable();
            $table->string('youtube_url', 255)->nullable();
            $table->boolean('is_highlight')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('galeri');
    }
};
