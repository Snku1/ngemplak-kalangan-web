<?php

namespace App\Http\Controllers\Api;

use App\Models\Demographic;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DemographicController extends BaseController
{
    public function index()
    {
        $data = Demographic::all();
        return $this->sendResponse($data, 'Demographic retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'kategori' => 'required|in:usia,jenis_kelamin,pendidikan,pekerjaan', 'label' => 'required|max:100', 'jumlah_jiwa' => 'nullable|integer', 'persentase' => 'nullable|numeric'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Demographic::create($input);
        return $this->sendResponse($data, 'Demographic created successfully.');
    } 

    public function show($id)
    {
        $data = Demographic::find($id);
        if (is_null($data)) {
            return $this->sendError('Demographic not found.');
        }
        return $this->sendResponse($data, 'Demographic retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'kategori' => 'required|in:usia,jenis_kelamin,pendidikan,pekerjaan', 'label' => 'required|max:100', 'jumlah_jiwa' => 'nullable|integer', 'persentase' => 'nullable|numeric'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Demographic::find($id);
        if (is_null($data)) {
            return $this->sendError('Demographic not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Demographic updated successfully.');
    }

    public function destroy($id)
    {
        $data = Demographic::find($id);
        if (is_null($data)) {
            return $this->sendError('Demographic not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Demographic deleted successfully.');
    }
}
