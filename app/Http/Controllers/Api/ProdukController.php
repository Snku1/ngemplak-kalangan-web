<?php

namespace App\Http\Controllers\Api;

use App\Models\Produk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProdukController extends BaseController
{
    public function index()
    {
        $data = Produk::all();
        return $this->sendResponse($data, 'Produk retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'penjual_id' => 'required|exists:umkm,id', 'category_id' => 'required|exists:master_kategori,id', 'nama_produk' => 'required|max:150', 'harga' => 'required|numeric'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Produk::create($input);
        return $this->sendResponse($data, 'Produk created successfully.');
    } 

    public function show($id)
    {
        $data = Produk::find($id);
        if (is_null($data)) {
            return $this->sendError('Produk not found.');
        }
        return $this->sendResponse($data, 'Produk retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'penjual_id' => 'required|exists:umkm,id', 'category_id' => 'required|exists:master_kategori,id', 'nama_produk' => 'required|max:150', 'harga' => 'required|numeric'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Produk::find($id);
        if (is_null($data)) {
            return $this->sendError('Produk not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Produk updated successfully.');
    }

    public function destroy($id)
    {
        $data = Produk::find($id);
        if (is_null($data)) {
            return $this->sendError('Produk not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Produk deleted successfully.');
    }
}
