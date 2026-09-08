<?php

namespace App\Http\Controllers\Api;

use App\Models\Galeri;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class GaleriController extends BaseController
{
    public function index()
    {
        $data = Galeri::all();
        return $this->sendResponse($data, 'Galeri retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'category_id' => 'required|exists:master_kategori,id', 'judul' => 'required|max:150', 'tipe' => 'nullable|in:foto,video'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Galeri::create($input);
        return $this->sendResponse($data, 'Galeri created successfully.');
    } 

    public function show($id)
    {
        $data = Galeri::find($id);
        if (is_null($data)) {
            return $this->sendError('Galeri not found.');
        }
        return $this->sendResponse($data, 'Galeri retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'category_id' => 'required|exists:master_kategori,id', 'judul' => 'required|max:150', 'tipe' => 'nullable|in:foto,video'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Galeri::find($id);
        if (is_null($data)) {
            return $this->sendError('Galeri not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Galeri updated successfully.');
    }

    public function destroy($id)
    {
        $data = Galeri::find($id);
        if (is_null($data)) {
            return $this->sendError('Galeri not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Galeri deleted successfully.');
    }
}
