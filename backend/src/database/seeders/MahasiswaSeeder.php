<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Mahasiswa;
use App\Models\ProgramStudi;
use App\Models\User;
use Illuminate\Database\Seeder;

final class MahasiswaSeeder extends Seeder
{
    public function run(): void
    {
        $teknikInformatika = ProgramStudi::query()
            ->where('kode', 'TI')
            ->firstOrFail();

        $mahasiswas = [

            [
                'email' => 'budi@student.ac.id',
                'nim' => '202200001',
                'angkatan' => '2022',
            ],

            [
                'email' => 'edward@student.ac.id',
                'nim' => '202200002',
                'angkatan' => '2022',
            ],

            [
                'email' => 'yunus@student.ac.id',
                'nim' => '202200003',
                'angkatan' => '2022',
            ],

            [
                'email' => 'ariqa@student.ac.id',
                'nim' => '202200004',
                'angkatan' => '2022',
            ],

            [
                'email' => 'joel@student.ac.id',
                'nim' => '202200005',
                'angkatan' => '2022',
            ],

        ];

        foreach ($mahasiswas as $item) {

            $user = User::query()
                ->where('email', $item['email'])
                ->firstOrFail();

            Mahasiswa::query()->updateOrCreate(
                [
                    'nim' => $item['nim'],
                ],
                [
                    'user_id' => $user->id,
                    'program_studi_id' => $teknikInformatika->id,
                    'nim' => $item['nim'],
                    'angkatan' => $item['angkatan'],
                ],
            );
        }
    }
}
