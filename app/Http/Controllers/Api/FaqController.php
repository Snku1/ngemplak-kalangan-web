<?php

namespace App\Http\Controllers\Api;

use App\Models\Faq;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FaqController extends BaseController
{
    public function index()
    {
        $data = Faq::all();
        return $this->sendResponse($data, 'Faq retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'pertanyaan' => 'required', 'jawaban' => 'required'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Faq::create($input);
        return $this->sendResponse($data, 'Faq created successfully.');
    } 

    public function show($id)
    {
        $data = Faq::find($id);
        if (is_null($data)) {
            return $this->sendError('Faq not found.');
        }
        return $this->sendResponse($data, 'Faq retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'pertanyaan' => 'required', 'jawaban' => 'required'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = Faq::find($id);
        if (is_null($data)) {
            return $this->sendError('Faq not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'Faq updated successfully.');
    }

    public function destroy($id)
    {
        $data = Faq::find($id);
        if (is_null($data)) {
            return $this->sendError('Faq not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'Faq deleted successfully.');
    }
}
