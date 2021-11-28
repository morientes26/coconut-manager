<?php
namespace App\Model;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Constant extends Eloquent {
   protected $table = 'constants';
   protected $fillable = ['name','val'];
   protected $primaryKey = 'name';
   protected $keyType = 'string';

   public $timestamps = false;
}
