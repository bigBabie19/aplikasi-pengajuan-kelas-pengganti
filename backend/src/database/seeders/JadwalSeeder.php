<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Dosen;
use App\Models\Jadwal;
use App\Models\MataKuliah;
use App\Models\Ruangan;
use Illuminate\Database\Seeder;

final class JadwalSeeder extends Seeder
{
    public function run(): void
    {
        $mataKuliahs = MataKuliah::query()
            ->get()
            ->keyBy('kode');

        $dosens = Dosen::query()
            ->get()
            ->keyBy('nidn');

        $ruangans = Ruangan::query()
            ->get()
            ->keyBy('kode');

        $configurations = require database_path(
            'seeders/Data/JadwalData.php'
        );

        foreach ($configurations as $configuration) {

            Jadwal::query()->updateOrCreate(

                [
                    'kode_kelas' => $configuration['kode_kelas'],
                ],

                [
                    'mata_kuliah_id' => $mataKuliahs[$configuration['mata_kuliah']]->id,
                    'dosen_id' => $dosens[$configuration['dosen']]->id,
                    'ruangan_id' => $ruangans[$configuration['ruangan']]->id,
                    'kode_kelas' => $configuration['kode_kelas'],
                    'jumlah_peserta' => $configuration['jumlah_peserta'],
                    'hari' => $configuration['hari'],
                    'jam_mulai' => $configuration['jam_mulai'],
                    'jam_selesai' => $configuration['jam_selesai'],
                    'tahun_ajaran' => $configuration['tahun_ajaran'],
                    'semester' => $configuration['semester'],
                ]
            );
        }
    }
}
