<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

final class Pengajuan extends Model
{
    protected $fillable = [
        'mahasiswa_id',
        'jadwal_id',
        'ruangan_id',
        'tanggal_kelas_asal',
        'tanggal_kelas_pengganti',
        'jam_mulai',
        'jam_selesai',
        'alasan',
        'status',
        'processed_at',
        'processed_by',
        'catatan_admin',
    ];

    protected $casts = [
        'tanggal_kelas_asal' => 'date',
        'tanggal_kelas_pengganti' => 'date',
        'jam_mulai' => 'datetime:H:i',
        'jam_selesai' => 'datetime:H:i',
        'processed_at' => 'datetime',
    ];

    /**
     * Relasi dengan model Mahasiswa.
     */
    public function mahasiswa(): BelongsTo
    {
        return $this->belongsTo(Mahasiswa::class);
    }

    /**
     * Relasi dengan model Jadwal.
     */
    public function jadwal(): BelongsTo
    {
        return $this->belongsTo(Jadwal::class);
    }

    /**
     * Relasi dengan model Ruangan.
     */
    public function ruangan(): BelongsTo
    {
        return $this->belongsTo(Ruangan::class);
    }

    /**
     * Relasi dengan model User (admin yang memproses pengajuan).
     */
    public function processedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'processed_by');
    }
}
