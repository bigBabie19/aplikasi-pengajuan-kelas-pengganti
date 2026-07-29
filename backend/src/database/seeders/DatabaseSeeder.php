<?php

declare(strict_types=1);

namespace Database\Seeders;

use Illuminate\Database\Seeder;

final class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            RoleSeeder::class,
            ProgramStudiSeeder::class,
            UserSeeder::class,
            MahasiswaSeeder::class,
            DosenSeeder::class,
            RuanganSeeder::class,
            MataKuliahSeeder::class,
            JadwalSeeder::class,
            PengajuanSeeder::class,
            PengajuanDetailSeeder::class,
        ]);
    }
}
