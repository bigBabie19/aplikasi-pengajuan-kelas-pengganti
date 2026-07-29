<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Jadwal;
use App\Models\Pengajuan;
use App\Models\PengajuanDetail;
use Illuminate\Database\Seeder;

final class PengajuanDetailSeeder extends Seeder
{
  public function run(): void
  {
    $pengajuans = Pengajuan::query()
      ->with('jadwal')
      ->get()
      ->keyBy(fn(Pengajuan $pengajuan) => $pengajuan->jadwal->kode_kelas);

    $configurations = require database_path(
      'seeders/Data/PengajuanData.php'
    );

    foreach ($configurations as $configuration) {

      $key = $configuration['kode_kelas'];

      if (! $pengajuans->has($key)) {
        continue;
      }

      $pengajuan = $pengajuans[$key];

      PengajuanDetail::query()->updateOrCreate(

        [
          'pengajuan_id' => $pengajuan->id,
        ],

        [
          'lampiran' => $configuration['lampiran'],

          'riwayat_status' => $this->history(
            $configuration['status']
          ),

          'activity_log' => $this->activity(
            $configuration['status']
          ),

          'metadata' => array_merge(
            $configuration['metadata'],
            [
              'status_terakhir' => $configuration['status'],

              'processed_at' => in_array(
                $configuration['status'],
                ['approved', 'rejected'],
                true
              )
                ? now()->toIso8601String()
                : null,

              'processed_by' => in_array(
                $configuration['status'],
                ['approved', 'rejected'],
                true
              )
                ? $pengajuan->processed_by
                : null,
            ]
          ),
        ]

      );
    }
  }

  private function history(string $status): array
  {
    $history = [
      [
        'status' => 'pending',
        'waktu' => now()->subHour()->toIso8601String(),
        'catatan' => 'Pengajuan dibuat oleh mahasiswa.',
      ],
    ];

    if ($status !== 'pending') {

      $history[] = [
        'status' => $status,
        'waktu' => now()->toIso8601String(),
        'catatan' => match ($status) {
          'approved' => 'Pengajuan disetujui oleh admin.',
          'rejected' => 'Ruangan tidak tersedia.',
        },
      ];
    }

    return $history;
  }

  private function activity(string $status): array
  {
    $activity = [

      [
        'step' => 'validate_room',
        'message' => 'Ruangan diverifikasi terhadap jadwal reguler dan pengajuan lain.',
      ],

      [
        'step' => 'submit',
        'message' => 'Pengajuan kelas pengganti berhasil disimpan.',
      ],
    ];

    if ($status === 'approved') {

      $activity[] = [
        'step' => 'approve',
        'message' => 'Pengajuan disetujui oleh admin.',
      ];
    }

    if ($status === 'rejected') {

      $activity[] = [
        'step' => 'reject',
        'message' => 'Ruangan tidak tersedia.',
      ];
    }

    return $activity;
  }
}
