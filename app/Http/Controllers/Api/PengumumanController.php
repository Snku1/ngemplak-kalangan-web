<?php

namespace App\Http\Controllers\Api;

use App\Models\Pengumuman;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PengumumanController extends BaseController
{
    public function index()
    {
        $data = Pengumuman::all();
        return $this->sendResponse($data, 'Pengumuman retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'judul' => 'required|max:200', 'isi_ringkas' => 'required', 'tanggal_posting' => 'required|date'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Pengumuman::create($input);
        return $this->sendResponse($data, 'Pengumuman created successfully.');
    } 

    public function show($id)
    {
        $data = Pengumuman::find($id);
        if (is_null($data)) {
            return $this->sendError('Pengumuman not found.');
        }
        return $this->sendResponse($data, 'Pengumuman retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'judul' => 'required|max:200', 'isi_ringkas' => 'required', 'tanggal_posting' => 'required|date', 'is_important' => 'nullable|boolean'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Pengumuman::find($id);
        if (is_null($data)) {
            return $this->sendError('Pengumuman not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Pengumuman updated successfully.');
    }

    public function destroy($id)
    {
        $data = Pengumuman::find($id);
        if (is_null($data)) {
            return $this->sendError('Pengumuman not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Pengumuman deleted successfully.');
    }
}
