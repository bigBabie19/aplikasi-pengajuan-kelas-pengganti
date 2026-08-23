<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Pengajuan
 */
final class PengajuanResource extends JsonResource
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
            'status' => $this->status,
            'tanggal_kelas_asal' => $this->tanggal_kelas_asal?->toDateString(),
            'tanggal_kelas_pengganti' => $this->tanggal_kelas_pengganti?->toDateString(),
            'jam_mulai' => $this->jam_mulai?->format('H:i'),
            'jam_selesai' => $this->jam_selesai?->format('H:i'),
            'alasan' => $this->alasan,
            'catatan_admin' => $this->catatan_admin,
            'processed_at' => $this->processed_at?->toDateTimeString(),
            'user' => new UserResource(
                $this->whenLoaded('user')
            ),
            'jadwal' => new JadwalResource(
                $this->whenLoaded('jadwal')
            ),
            'ruangan' => new RuanganResource(
                $this->whenLoaded('ruangan')
            ),
            'processed_by' => new UserResource(
                $this->whenLoaded('processedBy')
            ),
            'created_at' => $this->created_at?->toDateTimeString(),
            'updated_at' => $this->updated_at?->toDateTimeString(),
        ];
    }
}
