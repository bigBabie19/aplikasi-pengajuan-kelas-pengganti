<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Jadwal;

class MataKuliah extends Model
{
    protected $fillable = [
        'program_studi_id',
        'kode',
        'nama',
        'sks',
        'semester',
    ];

    protected $casts = [
        'sks' => 'integer',
        'semester' => 'integer',
    ];

    /**
     * Relasi dengan model ProgramStudi.
     */
    public function programStudi(): BelongsTo
    {
        return $this->belongsTo(ProgramStudi::class);
    }

    /**
     * Relasi dengan model Jadwal.
     */
    public function jadwals(): HasMany
    {
        return $this->hasMany(Jadwal::class);
    }
}
