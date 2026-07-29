<?php

namespace App\Filament\Admin\Resources\Dosens;

use App\Filament\Admin\Resources\Dosens\Pages\CreateDosen;
use App\Filament\Admin\Resources\Dosens\Pages\EditDosen;
use App\Filament\Admin\Resources\Dosens\Pages\ListDosens;
use App\Filament\Admin\Resources\Dosens\Schemas\DosenForm;
use App\Filament\Admin\Resources\Dosens\Tables\DosensTable;
use App\Models\Dosen;
use BackedEnum;
use UnitEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class DosenResource extends Resource
{
    protected static ?string $model = Dosen::class;

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-user';

    protected static ?string $recordTitleAttribute = 'nidn';

    protected static string|UnitEnum|null $navigationGroup = 'Data Akademik';

    protected static ?int $navigationSort = 2;

    protected static ?string $modelLabel = 'Dosen';

    protected static ?string $pluralModelLabel = 'Dosen';

    public static function form(Schema $schema): Schema
    {
        return DosenForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return DosensTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getRecordTitleAttribute(): ?string
    {
        return 'user.name';
    }

    public static function getPages(): array
    {
        return [
            'index' => ListDosens::route('/'),
            'create' => CreateDosen::route('/create'),
            'edit' => EditDosen::route('/{record}/edit'),
        ];
    }
}
