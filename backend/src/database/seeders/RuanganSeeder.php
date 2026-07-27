<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Ruangan;
use Illuminate\Database\Seeder;

final class RuanganSeeder extends Seeder
{
    public function run(): void
    {
        $ruangans = [

            [
                'kode' => 'A301',
                'nama' => 'Ruang A301',
                'kapasitas' => 40,
                'gedung' => 'Gedung A',
                'lantai' => 3,
                'status' => 'aktif',
            ],

            [
                'kode' => 'A302',
                'nama' => 'Ruang A302',
                'kapasitas' => 40,
                'gedung' => 'Gedung A',
                'lantai' => 3,
                'status' => 'aktif',
            ],

            [
                'kode' => 'B201',
                'nama' => 'Ruang B201',
                'kapasitas' => 35,
                'gedung' => 'Gedung B',
                'lantai' => 2,
                'status' => 'aktif',
            ],

            [
                'kode' => 'LAB1',
                'nama' => 'Laboratorium Komputer 1',
                'kapasitas' => 30,
                'gedung' => 'Gedung C',
                'lantai' => 1,
                'status' => 'aktif',
            ],

            [
                'kode' => 'LAB2',
                'nama' => 'Laboratorium Komputer 2',
                'kapasitas' => 30,
                'gedung' => 'Gedung C',
                'lantai' => 1,
                'status' => 'aktif',
            ],

        ];

        foreach ($ruangans as $ruangan) {

            Ruangan::query()->updateOrCreate(
                [
                    'kode' => $ruangan['kode'],
                ],
                $ruangan,
            );
        }
    }
}
