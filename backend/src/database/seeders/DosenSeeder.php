<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Dosen;
use App\Models\ProgramStudi;
use App\Models\User;
use Illuminate\Database\Seeder;

final class DosenSeeder extends Seeder
{
    public function run(): void
    {
        $programStudi = ProgramStudi::query()
            ->where('kode', 'TI')
            ->firstOrFail();

        $dosens = [
            [
                'email' => 'ahmad@kampus.ac.id',
                'nidn' => '031001001',
            ],
            [
                'email' => 'rina@kampus.ac.id',
                'nidn' => '031001002',
            ],
            [
                'email' => 'bambang@kampus.ac.id',
                'nidn' => '031001003',
            ],
            [
                'email' => 'dian@kampus.ac.id',
                'nidn' => '031001004',
            ],
            [
                'email' => 'hendra@kampus.ac.id',
                'nidn' => '031001005',
            ],
        ];

        foreach ($dosens as $item) {

            $user = User::query()
                ->where('email', $item['email'])
                ->firstOrFail();

            Dosen::query()->updateOrCreate(
                [
                    'nidn' => $item['nidn'],
                ],
                [
                    'user_id' => $user->id,
                    'program_studi_id' => $programStudi->id,
                    'nidn' => $item['nidn'],
                ],
            );
        }
    }
}
