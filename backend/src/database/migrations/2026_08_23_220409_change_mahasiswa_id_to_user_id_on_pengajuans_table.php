<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('pengajuans', function (Blueprint $table): void {
            $table->foreignId('user_id')
                ->nullable()
                ->after('id')
                ->constrained('users')
                ->cascadeOnUpdate()
                ->restrictOnDelete();
        });

        DB::statement('
            UPDATE pengajuans p
            INNER JOIN mahasiswas m ON m.id = p.mahasiswa_id
            SET p.user_id = m.user_id
        ');

        Schema::table('pengajuans', function (Blueprint $table): void {
            $table->foreignId('user_id')
                ->nullable(false)
                ->change();

            $table->dropForeign(['mahasiswa_id']);
            $table->dropColumn('mahasiswa_id');
        });
    }

    public function down(): void
    {
        Schema::table('pengajuans', function (Blueprint $table): void {
            $table->foreignId('mahasiswa_id')
                ->nullable()
                ->after('id')
                ->constrained()
                ->cascadeOnUpdate()
                ->restrictOnDelete();
        });

        DB::statement('
            UPDATE pengajuans p
            INNER JOIN mahasiswas m ON m.user_id = p.user_id
            SET p.mahasiswa_id = m.id
        ');

        Schema::table('pengajuans', function (Blueprint $table): void {
            $table->foreignId('mahasiswa_id')
                ->nullable(false)
                ->change();

            $table->dropForeign(['user_id']);
            $table->dropColumn('user_id');
        });
    }
};
