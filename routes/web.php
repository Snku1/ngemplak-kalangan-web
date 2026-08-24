<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    // Self-healing asset copy logic
    $sourceDir = 'C:/Users/LENOVO/.gemini/antigravity-ide/brain/bfedeae5-7f40-4b49-9e1f-55a749f0a6c2';
    $destDir = public_path('images');
    
    if (!is_dir($destDir)) {
        mkdir($destDir, 0755, true);
    }
    
    $mapping = [
        'hero_background_1786553913270.png' => 'hero-bg.png',
        'lomba_polowidi_1786554007926.png' => 'lomba-polowidi.png',
        'lomba_kalangan_1786554028214.png' => 'lomba-kalangan.png',
        'tirakatan_1786554042437.png' => 'tirakatan.png',
        'kepala_desa_1786554264969.png' => 'kepala-desa.png',
        'anyaman_bambu_1786554661460.png' => 'anyaman-bambu.png',
    ];
    
    foreach ($mapping as $srcName => $destName) {
        $srcPath = $sourceDir . '/' . $srcName;
        $destPath = $destDir . '/' . $destName;
        if (file_exists($srcPath) && !file_exists($destPath)) {
            copy($srcPath, $destPath);
        }
    }

    $currentSourceDir = 'C:/Users/LENOVO/.gemini/antigravity-ide/brain/d68a635b-8fbc-443a-b0d8-a9f62385e262';
    $mappingCurrent = [
        'musyawarah_desa_1787294229653.png' => 'musyawarah-desa.png',
        'jalan_dusun_1787294242560.png' => 'jalan-dusun.png',
        'tpa_supit_urang_1787295497970.png' => 'tpa-supit-urang.png',
        'tpa_el_mutaqi_1787295517569.png' => 'tpa-el-mutaqi.png',
        'seni_rodat_1787295536177.png' => 'seni-rodat.png',
        'senam_sore_1787295552827.png' => 'senam-sore.png',
    ];
    
    foreach ($mappingCurrent as $srcName => $destName) {
        $srcPath = $currentSourceDir . '/' . $srcName;
        $destPath = $destDir . '/' . $destName;
        if (file_exists($srcPath) && !file_exists($destPath)) {
            copy($srcPath, $destPath);
        }
    }
    
    // Also copy duplicates for galeri
    $galeri1 = $destDir . '/galeri-1.png';
    $galeri2 = $destDir . '/galeri-2.png';
    if (file_exists($destDir . '/lomba-polowidi.png') && !file_exists($galeri1)) {
        copy($destDir . '/lomba-polowidi.png', $galeri1);
    }
    if (file_exists($destDir . '/hero-bg.png') && !file_exists($galeri2)) {
        copy($destDir . '/hero-bg.png', $galeri2);
    }

    return view('welcome');
});
