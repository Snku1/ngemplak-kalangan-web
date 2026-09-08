<?php

namespace App\Http\Controllers\Api;

use App\Models\OrganizationalStructure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrganizationalStructureController extends BaseController
{
    public function index()
    {
        $data = OrganizationalStructure::all();
        return $this->sendResponse($data, 'OrganizationalStructure retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama' => 'required|max:100', 'jabatan' => 'required|max:100', 'urutan' => 'nullable|integer'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = OrganizationalStructure::create($input);
        return $this->sendResponse($data, 'OrganizationalStructure created successfully.');
    } 

    public function show($id)
    {
        $data = OrganizationalStructure::find($id);
        if (is_null($data)) {
            return $this->sendError('OrganizationalStructure not found.');
        }
        return $this->sendResponse($data, 'OrganizationalStructure retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'nama' => 'required|max:100', 'jabatan' => 'required|max:100', 'urutan' => 'nullable|integer'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = OrganizationalStructure::find($id);
        if (is_null($data)) {
            return $this->sendError('OrganizationalStructure not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'OrganizationalStructure updated successfully.');
    }

    public function destroy($id)
    {
        $data = OrganizationalStructure::find($id);
        if (is_null($data)) {
            return $this->sendError('OrganizationalStructure not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'OrganizationalStructure deleted successfully.');
    }
}
