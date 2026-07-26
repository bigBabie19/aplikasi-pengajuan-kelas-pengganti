<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Jadwal;

class Dosen extends Model
{
    protected $fillable = [
        'user_id',
        'program_studi_id',
        'nidn',
    ];

    /**
     * Relasi dengan model User.
     */
    public function user() : BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Relasi dengan model ProgramStudi.
     */
    public function programStudi() : BelongsTo
    {
        return $this->belongsTo(ProgramStudi::class);
    }

    /**
     * Relasi dengan model Jadwal.
     */
    public function jadwals() : HasMany
    {
        return $this->hasMany(Jadwal::class);
    }
}
