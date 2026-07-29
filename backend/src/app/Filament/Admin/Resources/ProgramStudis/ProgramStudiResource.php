<?php

namespace App\Filament\Admin\Resources\ProgramStudis;

use App\Filament\Admin\Resources\ProgramStudis\Pages\CreateProgramStudi;
use App\Filament\Admin\Resources\ProgramStudis\Pages\EditProgramStudi;
use App\Filament\Admin\Resources\ProgramStudis\Pages\ListProgramStudis;
use App\Filament\Admin\Resources\ProgramStudis\Schemas\ProgramStudiForm;
use App\Filament\Admin\Resources\ProgramStudis\Tables\ProgramStudisTable;
use App\Models\ProgramStudi;
use BackedEnum;
use UnitEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class ProgramStudiResource extends Resource
{
    protected static ?string $model = ProgramStudi::class;

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-academic-cap';

    protected static ?string $recordTitleAttribute = 'nama';

    protected static string|UnitEnum|null $navigationGroup = 'Data Akademik';

    protected static ?int $navigationSort = 1;

    protected static ?string $modelLabel = 'Program Studi';

    protected static ?string $pluralModelLabel = 'Program Studi';

    public static function form(Schema $schema): Schema
    {
        return ProgramStudiForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return ProgramStudisTable::configure($table);
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
            'index' => ListProgramStudis::route('/'),
            'create' => CreateProgramStudi::route('/create'),
            'edit' => EditProgramStudi::route('/{record}/edit'),
        ];
    }
}
