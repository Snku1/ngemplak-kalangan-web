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
        Schema::create('produk', function (Blueprint $table) {
            $table->id();
            $table->foreignId('penjual_id')->constrained('umkm')->cascadeOnDelete();
            $table->foreignId('category_id')->constrained('master_kategori')->cascadeOnDelete();
            $table->string('nama_produk', 150);
            $table->decimal('harga', 12, 2);
            $table->text('deskripsi')->nullable();
            $table->string('foto_produk', 255)->nullable();
            $table->boolean('is_unggulan')->default(false);
            $table->boolean('status_tersedia')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('produk');
    }
};
