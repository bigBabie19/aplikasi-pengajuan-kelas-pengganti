<?php

namespace App\Filament\Admin\Resources\Ruangans\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class RuanganForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('kode')
                    ->required()
                    ->unique(ignoreRecord: true),
                TextInput::make('nama')
                    ->required(),
                TextInput::make('kapasitas')
                    ->required()
                    ->numeric(),
                TextInput::make('gedung')
                    ->required(),
                TextInput::make('lantai')
                    ->required()
                    ->numeric(),
                Select::make('status')
                    ->options(['aktif' => 'Aktif', 'maintenance' => 'Maintenance'])
                    ->default('aktif')
                    ->required(),
            ])
            ->columns(2);
    }
}
