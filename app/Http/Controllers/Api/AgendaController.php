<?php

namespace App\Http\Controllers\Api;

use App\Models\Agenda;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AgendaController extends BaseController
{
    public function index()
    {
        $data = Agenda::all();
        return $this->sendResponse($data, 'Agenda retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_kegiatan' => 'required|max:150',
            'tanggal_kegiatan' => 'required|date',
            'waktu' => 'required|max:50',
            'lokasi' => 'required|max:150',
            'deskripsi' => 'nullable|string',
            'status' => 'nullable|in:mendatang,selesai'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Agenda::create($input);
        return $this->sendResponse($data, 'Agenda created successfully.');
    } 

    public function show($id)
    {
        $data = Agenda::find($id);
        if (is_null($data)) {
            return $this->sendError('Agenda not found.');
        }
        return $this->sendResponse($data, 'Agenda retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_kegiatan' => 'required|max:150', 'tanggal_kegiatan' => 'required|date', 'waktu' => 'required|max:50', 'lokasi' => 'required|max:150', 'status' => 'nullable|in:mendatang,selesai'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Agenda::find($id);
        if (is_null($data)) {
            return $this->sendError('Agenda not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Agenda updated successfully.');
    }

    public function destroy($id)
    {
        $data = Agenda::find($id);
        if (is_null($data)) {
            return $this->sendError('Agenda not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Agenda deleted successfully.');
    }
}
