<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    protected $table = 'news';

    protected $fillable = ['category_id', 'author_id', 'title', 'slug', 'content', 'thumbnail', 'tags', 'status', 'view_count'];

    public function category()
    {
        return $this->belongsTo(MasterKategori::class, 'category_id');
    }

    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }

}
