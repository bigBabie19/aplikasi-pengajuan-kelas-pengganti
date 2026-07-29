<?php

namespace App\Filament\Admin\Resources\MataKuliahs;

use App\Filament\Admin\Resources\MataKuliahs\Pages\CreateMataKuliah;
use App\Filament\Admin\Resources\MataKuliahs\Pages\EditMataKuliah;
use App\Filament\Admin\Resources\MataKuliahs\Pages\ListMataKuliahs;
use App\Filament\Admin\Resources\MataKuliahs\Schemas\MataKuliahForm;
use App\Filament\Admin\Resources\MataKuliahs\Tables\MataKuliahsTable;
use App\Models\MataKuliah;
use BackedEnum;
use UnitEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class MataKuliahResource extends Resource
{
    protected static ?string $model = MataKuliah::class;

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-book-open';

    protected static ?string $recordTitleAttribute = 'nama';

    protected static string|UnitEnum|null $navigationGroup = 'Data Akademik';

    protected static ?int $navigationSort = 4;

    protected static ?string $modelLabel = 'Mata Kuliah';

    protected static ?string $pluralModelLabel = 'Mata Kuliah';

    public static function form(Schema $schema): Schema
    {
        return MataKuliahForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return MataKuliahsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListMataKuliahs::route('/'),
            'create' => CreateMataKuliah::route('/create'),
            'edit' => EditMataKuliah::route('/{record}/edit'),
        ];
    }
}
