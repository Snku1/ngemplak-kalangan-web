<?php

namespace App\Http\Controllers\Api;

use App\Models\Umkm;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UmkmController extends BaseController
{
    public function index()
    {
        $data = Umkm::all();
        return $this->sendResponse($data, 'Umkm retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_penjual' => 'required|max:100', 'nama_usaha' => 'required|max:100', 'nomor_whatsapp' => 'required|max:20'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Umkm::create($input);
        return $this->sendResponse($data, 'Umkm created successfully.');
    } 

    public function show($id)
    {
        $data = Umkm::find($id);
        if (is_null($data)) {
            return $this->sendError('Umkm not found.');
        }
        return $this->sendResponse($data, 'Umkm retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_penjual' => 'required|max:100', 'nama_usaha' => 'required|max:100', 'nomor_whatsapp' => 'required|max:20'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Umkm::find($id);
        if (is_null($data)) {
            return $this->sendError('Umkm not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Umkm updated successfully.');
    }

    public function destroy($id)
    {
        $data = Umkm::find($id);
        if (is_null($data)) {
            return $this->sendError('Umkm not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Umkm deleted successfully.');
    }
}
