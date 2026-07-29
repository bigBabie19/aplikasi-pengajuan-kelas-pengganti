<?php

namespace App\Filament\Admin\Resources\Jadwals\Schemas;

use App\Enums\HariEnum;
use App\Enums\SemesterEnum;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\TimePicker;
use Filament\Schemas\Schema;

class JadwalForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('mata_kuliah_id')
                    ->relationship('mataKuliah', 'nama')
                    ->searchable()
                    ->preload()
                    ->required(),
                Select::make('dosen_id')
                    ->relationship('dosen.user', 'name')
                    ->searchable()
                    ->preload()
                    ->required(),
                Select::make('ruangan_id')
                    ->relationship('ruangan', 'nama')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('kode_kelas')
                    ->required(),
                TextInput::make('jumlah_peserta')
                    ->required()
                    ->numeric(),
                Select::make('hari')
                    ->options(HariEnum::class)
                    ->required(),
                TimePicker::make('jam_mulai')
                    ->seconds(false)
                    ->required(),
                TimePicker::make('jam_selesai')
                    ->seconds(false)
                    ->required(),
                TextInput::make('tahun_ajaran')
                    ->required(),
                Select::make('semester')
                    ->options(SemesterEnum::class)
                    ->required(),
            ])
            ->columns(2);
    }
}
