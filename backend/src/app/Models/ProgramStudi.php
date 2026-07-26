<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Mahasiswa;
use App\Models\Dosen;
use App\Models\MataKuliah;

class ProgramStudi extends Model
{
    protected $fillable = [
        'kode',
        'nama',
        'fakultas',
    ];

    /**
     * Relasi dengan model Mahasiswa.
     */
    public function mahasiswas(): HasMany
    {
        return $this->hasMany(Mahasiswa::class);
    }

    /**
     * Relasi dengan model Dosen.
     */
    public function dosens(): HasMany
    {
        return $this->hasMany(Dosen::class);
    }

    /**
     * Relasi dengan model MataKuliah.
     */
    public function mataKuliahs(): HasMany
    {
        return $this->hasMany(MataKuliah::class);
    }
}
