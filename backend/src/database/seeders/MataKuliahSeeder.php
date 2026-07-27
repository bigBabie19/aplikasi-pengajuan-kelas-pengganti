<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\MataKuliah;
use App\Models\ProgramStudi;
use Illuminate\Database\Seeder;

final class MataKuliahSeeder extends Seeder
{
    public function run(): void
    {
        $programStudi = ProgramStudi::query()
            ->where('kode', 'TI')
            ->firstOrFail();

        $mataKuliahs = [

            [
                'kode' => 'IF401',
                'nama' => 'Basis Data',
                'sks' => 3,
                'semester' => 4,
            ],

            [
                'kode' => 'IF402',
                'nama' => 'Rekayasa Perangkat Lunak',
                'sks' => 3,
                'semester' => 4,
            ],

            [
                'kode' => 'IF403',
                'nama' => 'Pemrograman Mobile',
                'sks' => 3,
                'semester' => 5,
            ],

            [
                'kode' => 'IF404',
                'nama' => 'Jaringan Komputer',
                'sks' => 3,
                'semester' => 5,
            ],

            [
                'kode' => 'IF405',
                'nama' => 'Interaksi Manusia dan Komputer',
                'sks' => 3,
                'semester' => 5,
            ],

        ];

        foreach ($mataKuliahs as $mataKuliah) {

            MataKuliah::query()->updateOrCreate(
                [
                    'kode' => $mataKuliah['kode'],
                ],
                [
                    ...$mataKuliah,
                    'program_studi_id' => $programStudi->id,
                ],
            );
        }
    }
}
