<?php

namespace App\Http\Controllers\Api;

use App\Models\KependudukanDusun;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class KependudukanDusunController extends BaseController
{
    public function index()
    {
        $data = KependudukanDusun::orderBy('urutan')
            ->orderBy('nama_dusun')
            ->get()
            ->map(function ($item) {
                return [
                    'id'          => $item->id,
                    'nama_dusun'  => $item->nama_dusun,
                    'urutan'      => $item->urutan,
                    'laki_laki'   => $item->laki_laki,
                    'perempuan'   => $item->perempuan,
                    'total'       => $item->laki_laki + $item->perempuan,
                    'jumlah_kk'   => $item->jumlah_kk,
                    'keterangan'  => $item->keterangan,
                ];
            });
        return $this->sendResponse($data, 'Data retrieved successfully.');
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_dusun' => 'required|string|max:100',
            'urutan'     => 'nullable|integer|min:0',
            'laki_laki'  => 'required|integer|min:0',
            'perempuan'  => 'required|integer|min:0',
            'jumlah_kk'  => 'nullable|integer|min:0',
        ]);
        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors());
        }
        $data = KependudukanDusun::create($request->all());
        return $this->sendResponse($data, 'Data created successfully.');
    }

    public function show($id)
    {
        $data = KependudukanDusun::find($id);
        if (!$data) return $this->sendError('Not found.');
        return $this->sendResponse($data, 'Data retrieved successfully.');
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'nama_dusun' => 'required|string|max:100',
            'urutan'     => 'nullable|integer|min:0',
            'laki_laki'  => 'required|integer|min:0',
            'perempuan'  => 'required|integer|min:0',
            'jumlah_kk'  => 'nullable|integer|min:0',
        ]);
        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors());
        }
        $data = KependudukanDusun::find($id);
        if (!$data) return $this->sendError('Not found.');
        $data->update($request->all());
        return $this->sendResponse($data, 'Data updated successfully.');
    }

    public function destroy($id)
    {
        $data = KependudukanDusun::find($id);
        if (!$data) return $this->sendError('Not found.');
        $data->delete();
        return $this->sendResponse([], 'Data deleted successfully.');
    }
}