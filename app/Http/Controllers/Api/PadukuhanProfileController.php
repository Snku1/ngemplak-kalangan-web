<?php

namespace App\Http\Controllers\Api;

use App\Models\PadukuhanProfile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PadukuhanProfileController extends BaseController
{
    public function index()
    {
        $data = PadukuhanProfile::all();
        return $this->sendResponse($data, 'PadukuhanProfile retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_padukuhan' => 'required|max:100'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = PadukuhanProfile::create($input);
        return $this->sendResponse($data, 'PadukuhanProfile created successfully.');
    } 

    public function show($id)
    {
        $data = PadukuhanProfile::find($id);
        if (is_null($data)) {
            return $this->sendError('PadukuhanProfile not found.');
        }
        return $this->sendResponse($data, 'PadukuhanProfile retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama_padukuhan' => 'required|max:100'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = PadukuhanProfile::find($id);
        if (is_null($data)) {
            return $this->sendError('PadukuhanProfile not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'PadukuhanProfile updated successfully.');
    }

    public function destroy($id)
    {
        $data = PadukuhanProfile::find($id);
        if (is_null($data)) {
            return $this->sendError('PadukuhanProfile not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'PadukuhanProfile deleted successfully.');
    }
}
