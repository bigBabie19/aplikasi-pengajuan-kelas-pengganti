<?php

namespace App\Filament\Admin\Resources\Mahasiswas\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class MahasiswaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('user_id')
                    ->label('User')
                    ->relationship('user', 'name')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('nim')
                    ->label('NIM')
                    ->required()
                    ->maxLength(20)
                    ->unique(ignoreRecord: true),
                Select::make('program_studi_id')
                    ->label('Program Studi')
                    ->relationship('programStudi', 'nama')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('angkatan')
                    ->label('Angkatan')
                    ->numeric()
                    ->minValue(2000)
                    ->maxValue(date('Y') + 1)
                    ->required(),
            ])
            ->columns(2);
    }
}
