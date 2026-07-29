<?php

namespace App\Filament\Admin\Resources\ProgramStudis\Schemas;

use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class ProgramStudiForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('kode')
                    ->label('Kode Program Studi')
                    ->required()
                    ->maxLength(20)
                    ->unique(ignoreRecord: true),
                TextInput::make('nama')
                    ->label('Nama Program Studi')
                    ->required()
                    ->maxLength(100),
                TextInput::make('fakultas')
                    ->label('Fakultas')
                    ->required()
                    ->maxLength(100),
            ])
            ->columns(2);
    }
}
