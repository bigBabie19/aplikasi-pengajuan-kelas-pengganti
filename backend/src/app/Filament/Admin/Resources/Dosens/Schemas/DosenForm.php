<?php

namespace App\Filament\Admin\Resources\Dosens\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class DosenForm
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
                Select::make('program_studi_id')
                    ->label('Program Studi')
                    ->relationship('programStudi', 'nama')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('nidn')
                    ->label('NIDN')
                    ->required()
                    ->maxLength(20)
                    ->unique(ignoreRecord: true),
            ])
            ->columns(2);
    }
}
