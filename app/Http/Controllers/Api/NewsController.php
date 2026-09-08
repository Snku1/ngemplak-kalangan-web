<?php

namespace App\Http\Controllers\Api;

use App\Models\News;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NewsController extends BaseController
{
    public function index()
    {
        $data = News::all();
        return $this->sendResponse($data, 'News retrieved successfully.');
    }

    public function store(Request $request)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'category_id' => 'required|exists:master_kategori,id', 'author_id' => 'required|exists:users,id', 'title' => 'required|max:255', 'slug' => 'required|max:255|unique:news,slug', 'content' => 'required', 'status' => 'nullable|in:draft,published'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = News::create($input);
        return $this->sendResponse($data, 'News created successfully.');
    } 

    public function show($id)
    {
        $data = News::find($id);
        if (is_null($data)) {
            return $this->sendError('News not found.');
        }
        return $this->sendResponse($data, 'News retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
   
        $validator = Validator::make($input, [
            'category_id' => 'required|exists:master_kategori,id', 'author_id' => 'required|exists:users,id', 'title' => 'required|max:255', 'slug' => 'required|max:255|unique:news,slug,'.$id, 'content' => 'required', 'status' => 'nullable|in:draft,published'
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $data = News::find($id);
        if (is_null($data)) {
            return $this->sendError('News not found.');
        }

        $data->update($input);
        return $this->sendResponse($data, 'News updated successfully.');
    }

    public function destroy($id)
    {
        $data = News::find($id);
        if (is_null($data)) {
            return $this->sendError('News not found.');
        }
        $data->delete();
        return $this->sendResponse([], 'News deleted successfully.');
    }
}
