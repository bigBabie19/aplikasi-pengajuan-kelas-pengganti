<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Jadwal
 */
final class JadwalResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'kode_kelas' => $this->kode_kelas,
            'jumlah_peserta' => $this->jumlah_peserta,
            'hari' => $this->hari,
            'jam_mulai' => $this->jam_mulai?->format('H:i'),
            'jam_selesai' => $this->jam_selesai?->format('H:i'),
            'tahun_ajaran' => $this->tahun_ajaran,
            'semester' => $this->semester,
            'mata_kuliah' => new MataKuliahResource(
                $this->whenLoaded('mataKuliah')
            ),
            'dosen' => new DosenResource(
                $this->whenLoaded('dosen')
            ),
            'ruangan' => new RuanganResource(
                $this->whenLoaded('ruangan')
            ),
        ];
    }
}
