<?php

namespace App\Filament\Admin\Resources\MataKuliahs\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class MataKuliahForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('program_studi_id')
                    ->label('Program Studi')
                    ->relationship('programStudi', 'nama')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('kode')
                    ->label('Kode Mata Kuliah')
                    ->required()
                    ->unique(ignoreRecord: true)
                    ->maxLength(20),
                TextInput::make('nama')
                    ->label('Nama Mata Kuliah')
                    ->required()
                    ->maxLength(150),
                TextInput::make('sks')
                    ->numeric()
                    ->required()
                    ->minValue(1)
                    ->maxValue(6),
                TextInput::make('semester')
                    ->numeric()
                    ->required()
                    ->minValue(1)
                    ->maxValue(14),
            ])
            ->columns(2);
    }
}
