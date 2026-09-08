<?php

namespace App\Http\Controllers\Api;

use App\Models\DokumenPublik;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DokumenPublikController extends BaseController
{
    public function index()
    {
        $data = DokumenPublik::all();
        return $this->sendResponse($data, 'DokumenPublik retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'judul' => 'required|max:255', 'kategori' => 'required|max:100', 'tanggal_unggah' => 'required|date', 'format_file' => 'required|max:10', 'ukuran_file' => 'required|max:20', 'file_path' => 'required|max:255'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = DokumenPublik::create($input);
        return $this->sendResponse($data, 'DokumenPublik created successfully.');
    } 

    public function show($id)
    {
        $data = DokumenPublik::find($id);
        if (is_null($data)) {
            return $this->sendError('DokumenPublik not found.');
        }
        return $this->sendResponse($data, 'DokumenPublik retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'judul' => 'required|max:255', 'kategori' => 'required|max:100', 'tanggal_unggah' => 'required|date', 'format_file' => 'required|max:10', 'ukuran_file' => 'required|max:20', 'file_path' => 'required|max:255'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = DokumenPublik::find($id);
        if (is_null($data)) {
            return $this->sendError('DokumenPublik not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'DokumenPublik updated successfully.');
    }

    public function destroy($id)
    {
        $data = DokumenPublik::find($id);
        if (is_null($data)) {
            return $this->sendError('DokumenPublik not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'DokumenPublik deleted successfully.');
    }
}
