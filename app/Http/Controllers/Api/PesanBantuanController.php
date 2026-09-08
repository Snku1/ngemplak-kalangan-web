<?php

namespace App\Http\Controllers\Api;

use App\Models\PesanBantuan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PesanBantuanController extends BaseController
{
    public function index()
    {
        $data = PesanBantuan::all();
        return $this->sendResponse($data, 'PesanBantuan retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_lengkap' => 'required|max:100', 'email' => 'required|email|max:100', 'pesan' => 'required'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = PesanBantuan::create($input);
        return $this->sendResponse($data, 'PesanBantuan created successfully.');
    } 

    public function show($id)
    {
        $data = PesanBantuan::find($id);
        if (is_null($data)) {
            return $this->sendError('PesanBantuan not found.');
        }
        return $this->sendResponse($data, 'PesanBantuan retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_lengkap' => 'required|max:100', 'email' => 'required|email|max:100', 'pesan' => 'required'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = PesanBantuan::find($id);
        if (is_null($data)) {
            return $this->sendError('PesanBantuan not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'PesanBantuan updated successfully.');
    }

    public function destroy($id)
    {
        $data = PesanBantuan::find($id);
        if (is_null($data)) {
            return $this->sendError('PesanBantuan not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'PesanBantuan deleted successfully.');
    }
}
