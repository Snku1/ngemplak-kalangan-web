<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class FileUploadController extends BaseController
{
    /**
     * Upload file (gambar/video) ke public/uploads
     * Returns URL publik file yang bisa diakses browser
     */
    public function upload(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:jpg,jpeg,png,gif,webp,mp4,mov|max:10240',
        ]);

        $file = $request->file('file');
        $folder = $request->input('folder', 'uploads');
        $filename = time() . '_' . preg_replace('/[^a-zA-Z0-9._-]/', '', $file->getClientOriginalName());
        
        // Simpan ke public/uploads/[folder]
        $path = $file->move(public_path($folder), $filename);
        
        $url = '/' . $folder . '/' . $filename;

        return $this->sendResponse(['url' => $url], 'File uploaded successfully.');
    }
}
