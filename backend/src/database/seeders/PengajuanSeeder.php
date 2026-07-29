<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Mahasiswa;
use App\Models\Pengajuan;
use App\Models\Ruangan;
use App\Models\Jadwal;
use App\Models\User;
use Illuminate\Database\Seeder;

final class PengajuanSeeder extends Seeder
{
  public function run(): void
  {
    $mahasiswas = Mahasiswa::query()
      ->get()
      ->keyBy('nim');

    $jadwals = Jadwal::query()
      ->with([
        'mataKuliah',
        'ruangan',
        'dosen',
      ])
      ->get()
      ->keyBy('kode_kelas');

    $ruangans = Ruangan::query()
      ->get()
      ->keyBy('kode');

    $admin = User::query()->firstOrFail();

    $configurations = require database_path(
      'seeders/Data/PengajuanData.php'
    );

    foreach ($configurations as $configuration) {

      Pengajuan::query()->updateOrCreate(

        [
          'mahasiswa_id' => $mahasiswas[$configuration['mahasiswa']]->id,
          'jadwal_id' => $jadwals[$configuration['kode_kelas']]->id,
        ],

        [
          'ruangan_id' => $ruangans[$configuration['ruangan']]->id,
          'tanggal_kelas_asal' => $configuration['tanggal_kelas_asal'],
          'tanggal_kelas_pengganti' => $configuration['tanggal_kelas_pengganti'],
          'jam_mulai' => $configuration['jam_mulai'],
          'jam_selesai' => $configuration['jam_selesai'],
          'alasan' => $configuration['alasan'],
          'status' => $configuration['status'],
          'processed_at' => in_array(
            $configuration['status'],
            ['approved', 'rejected'],
            true
          ) ? now() : null,
          'processed_by' => in_array(
            $configuration['status'],
            ['approved', 'rejected'],
            true
          ) ? $admin->id : null,
          'catatan_admin' => match ($configuration['status']) {
            'approved' => 'Pengajuan disetujui.',
            'rejected' => 'Ruangan tidak tersedia.',
            default => null,
          },
        ]
      );
    }
  }
}
