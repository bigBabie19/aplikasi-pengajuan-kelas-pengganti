<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Enums\HariEnum;
use App\Enums\SemesterEnum;

final class Jadwal extends Model
{
    protected $fillable = [
        'mata_kuliah_id',
        'dosen_id',
        'ruangan_id',
        'kode_kelas',
        'jumlah_peserta',
        'hari',
        'jam_mulai',
        'jam_selesai',
        'tahun_ajaran',
        'semester',
    ];

    protected $casts = [
        'jumlah_peserta' => 'integer',
        'jam_mulai' => 'datetime:H:i',
        'jam_selesai' => 'datetime:H:i',
        'semester' => SemesterEnum::class,
        'hari' => HariEnum::class,
    ];

    /**
     * Relasi dengan model MataKuliah.
     */
    public function mataKuliah(): BelongsTo
    {
        return $this->belongsTo(MataKuliah::class);
    }

    /**
     * Relasi dengan model Dosen.
     */
    public function dosen(): BelongsTo
    {
        return $this->belongsTo(Dosen::class);
    }

    /**
     * Relasi dengan model Ruangan.
     */
    public function ruangan(): BelongsTo
    {
        return $this->belongsTo(Ruangan::class);
    }

    /**
     * Relasi dengan model Pengajuan.
     */
    public function pengajuans(): HasMany
    {
        return $this->hasMany(Pengajuan::class);
    }
}
