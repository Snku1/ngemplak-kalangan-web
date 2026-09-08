<?php

namespace App\Http\Controllers\Api;

use App\Models\PotensiDanWisata;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PotensiDanWisataController extends BaseController
{
    public function index()
    {
        $data = PotensiDanWisata::all();
        return $this->sendResponse($data, 'PotensiDanWisata retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama' => 'required|max:150', 'kategori' => 'nullable|in:potensi_desa,wisata'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = PotensiDanWisata::create($input);
        return $this->sendResponse($data, 'PotensiDanWisata created successfully.');
    } 

    public function show($id)
    {
        $data = PotensiDanWisata::find($id);
        if (is_null($data)) {
            return $this->sendError('PotensiDanWisata not found.');
        }
        return $this->sendResponse($data, 'PotensiDanWisata retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama' => 'required|max:150', 'kategori' => 'nullable|in:potensi_desa,wisata'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = PotensiDanWisata::find($id);
        if (is_null($data)) {
            return $this->sendError('PotensiDanWisata not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'PotensiDanWisata updated successfully.');
    }

    public function destroy($id)
    {
        $data = PotensiDanWisata::find($id);
        if (is_null($data)) {
            return $this->sendError('PotensiDanWisata not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'PotensiDanWisata deleted successfully.');
    }
}
