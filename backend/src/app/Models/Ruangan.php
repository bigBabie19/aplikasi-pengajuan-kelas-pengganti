<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

final class Ruangan extends Model
{
    protected $fillable = [
        'kode',
        'nama',
        'kapasitas',
        'gedung',
        'lantai',
        'status',
    ];

    protected $casts = [
        'kapasitas' => 'integer',
        'lantai' => 'integer',
    ];

    /**
     * Relasi dengan model Jadwal.
     */
    public function jadwals(): HasMany
    {
        return $this->hasMany(Jadwal::class);
    }

    /**
     * Relasi dengan model Pengajuan.
     */
    public function pengajuans(): HasMany
    {
        return $this->hasMany(Pengajuan::class);
    }
}
