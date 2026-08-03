<?php

declare(strict_types=1);

namespace App\Http\Resources\Mobile;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Jadwal
 */
final class ScheduleDropdownResource extends JsonResource
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
      'course_id' => $this->mata_kuliah_id,
      'course_name' => $this->mataKuliah?->nama,
      'lecturer_id' => $this->dosen_id,
      'lecturer_name' => $this->dosen?->user?->name,
      'class_name' => $this->kode_kelas,
      'participants' => $this->jumlah_peserta,
      'start_time' => $this->jam_mulai?->format('H:i'),
      'end_time' => $this->jam_selesai?->format('H:i'),
    ];
  }
}
