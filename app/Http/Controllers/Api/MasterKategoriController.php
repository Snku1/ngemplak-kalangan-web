<?php

namespace App\Http\Controllers\Api;

use App\Models\MasterKategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MasterKategoriController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $kategoris = MasterKategori::all();
    
        return $this->sendResponse($kategoris, 'Kategori retrieved successfully.');
    }
    
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'tipe' => 'required|in:berita,produk,galeri,pengumuman',
            'nama' => 'required|max:50',
            'slug' => 'required|max:60|unique:master_kategori,slug'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $kategori = MasterKategori::create($input);
   
        return $this->sendResponse($kategori, 'Kategori created successfully.');
    } 
   
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $kategori = MasterKategori::find($id);
  
        if (is_null($kategori)) {
            return $this->sendError('Kategori not found.');
        }
   
        return $this->sendResponse($kategori, 'Kategori retrieved successfully.');
    }
    
    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'tipe' => 'required|in:berita,produk,galeri',
            'nama' => 'required|max:50',
            'slug' => 'required|max:60|unique:master_kategori,slug,'.$id
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $kategori = MasterKategori::find($id);
        
        if (is_null($kategori)) {
            return $this->sendError('Kategori not found.');
        }

        $kategori->tipe = $input['tipe'];
        $kategori->nama = $input['nama'];
        $kategori->slug = $input['slug'];
        $kategori->save();
   
        return $this->sendResponse($kategori, 'Kategori updated successfully.');
    }
   
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        $kategori = MasterKategori::find($id);
        
        if (is_null($kategori)) {
            return $this->sendError('Kategori not found.');
        }

        $kategori->delete();
   
        return $this->sendResponse([], 'Kategori deleted successfully.');
    }
}
