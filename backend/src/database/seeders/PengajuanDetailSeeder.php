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

          'metadata' => $configuration['metadata'],
        ]

      );
    }
  }

  private function history(string $status): array
  {
    $history = [
      [
        'status' => 'pending',
        'timestamp' => now()->subHour()->toISOString(),
      ],
    ];

    if ($status !== 'pending') {

      $history[] = [
        'status' => $status,
        'timestamp' => now()->toISOString(),
      ];
    }

    return $history;
  }

  private function activity(string $status): array
  {
    $activity = [
      [
        'actor' => 'mahasiswa',
        'activity' => 'Mengajukan kelas pengganti.',
        'timestamp' => now()->subHour()->toISOString(),
      ],
    ];

    if ($status === 'approved') {

      $activity[] = [
        'actor' => 'admin',
        'activity' => 'Menyetujui pengajuan.',
        'timestamp' => now()->toISOString(),
      ];
    }

    if ($status === 'rejected') {

      $activity[] = [
        'actor' => 'admin',
        'activity' => 'Menolak pengajuan.',
        'timestamp' => now()->toISOString(),
      ];
    }

    return $activity;
  }
}
