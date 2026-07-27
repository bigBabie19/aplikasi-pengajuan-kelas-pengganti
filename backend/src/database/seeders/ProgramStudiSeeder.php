<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\ProgramStudi;
use Illuminate\Database\Seeder;

final class ProgramStudiSeeder extends Seeder
{
    public function run(): void
    {
        $programStudis = [
            [
                'kode' => 'TI',
                'nama' => 'Teknik Informatika',
                'fakultas' => 'Fakultas Ilmu Komputer',
            ],
            [
                'kode' => 'SI',
                'nama' => 'Sistem Informasi',
                'fakultas' => 'Fakultas Ilmu Komputer',
            ],
        ];

        foreach ($programStudis as $programStudi) {
            ProgramStudi::query()->updateOrCreate(
                [
                    'kode' => $programStudi['kode'],
                ],
                $programStudi,
            );
        }
    }
}
