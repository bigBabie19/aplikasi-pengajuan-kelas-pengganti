<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

final class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            // ==========================
            // Admin Akademik
            // ==========================
            [
                'name' => 'Admin Akademik',
                'email' => 'admin@kampus.ac.id',
                'role' => 'admin',
            ],

            // ==========================
            // Mahasiswa
            // ==========================
            [
                'name' => 'Budi Santoso',
                'email' => 'budi@student.ac.id',
                'role' => 'mahasiswa',
            ],

            [
                'name' => 'Edward Wijaya',
                'email' => 'edward@student.ac.id',
                'role' => 'mahasiswa',
            ],

            [
                'name' => 'Yunus Cornelis',
                'email' => 'yunus@student.ac.id',
                'role' => 'mahasiswa',
            ],

            [
                'name' => 'Ariqa Hinta',
                'email' => 'ariqa@student.ac.id',
                'role' => 'mahasiswa',
            ],

            [
                'name' => 'Joel Simanjuntak',
                'email' => 'joel@student.ac.id',
                'role' => 'mahasiswa',
            ],

            // ==========================
            // Dosen
            // ==========================
            [
                'name' => 'Dr. Ahmad Wijaya, S.Kom., M.Kom.',
                'email' => 'ahmad@kampus.ac.id',
                'role' => null,
            ],
            [
                'name' => 'Dr. Rina Kusuma, S.Kom., M.Kom.',
                'email' => 'rina@kampus.ac.id',
                'role' => null,
            ],
            [
                'name' => 'Dr. Bambang Setiawan, S.T., M.T.',
                'email' => 'bambang@kampus.ac.id',
                'role' => null,
            ],
            [
                'name' => 'Dr. Dian Pratiwi, S.Kom., M.Kom.',
                'email' => 'dian@kampus.ac.id',
                'role' => null,
            ],
            [
                'name' => 'Dr. Hendra Gunawan, S.Kom., M.Kom.',
                'email' => 'hendra@kampus.ac.id',
                'role' => null,
            ],
        ];

        foreach ($users as $item) {

            $role = $item['role'];

            unset($item['role']);

            $user = User::query()->updateOrCreate(
                [
                    'email' => $item['email'],
                ],
                [
                    ...$item,
                    'password' => Hash::make('password'), // Password default untuk semua user
                ],
            );

            if ($role !== null) {
                $user->syncRoles($role);
            }
        }
    }
}
