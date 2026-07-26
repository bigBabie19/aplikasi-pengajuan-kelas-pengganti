<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Pengajuan;

class Mahasiswa extends Model
{
    protected $fillable = [
        'user_id',
        'nim',
        'program_studi_id',
        'angkatan',
    ];

    protected $casts = [
        'angkatan' => 'integer',
    ];

    /**
     * Relasi dengan model User.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Relasi dengan model Pengajuan.
     */
    public function pengajuans(): HasMany
    {
        return $this->hasMany(Pengajuan::class);
    }

    /**
     * Relasi dengan model ProgramStudi.
     */
    public function programStudi(): BelongsTo
    {
        return $this->belongsTo(ProgramStudi::class);
    }
}
