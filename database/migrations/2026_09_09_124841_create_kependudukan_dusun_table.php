<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('kependudukan_dusun', function (Blueprint $table) {
            $table->id();
            $table->string('nama_rt', 50);        // cth: RT 01, RT 02
            $table->string('nama_dusun', 100)->nullable(); // cth: Ngemplak, Kalangan
            $table->integer('laki_laki')->default(0);
            $table->integer('perempuan')->default(0);
            $table->integer('jumlah_kk')->default(0);
            $table->text('keterangan')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('kependudukan_dusun');
    }
};
