<?php

namespace App\Filament\Admin\Resources\Jadwals;

use App\Filament\Admin\Resources\Jadwals\Pages\CreateJadwal;
use App\Filament\Admin\Resources\Jadwals\Pages\EditJadwal;
use App\Filament\Admin\Resources\Jadwals\Pages\ListJadwals;
use App\Filament\Admin\Resources\Jadwals\Schemas\JadwalForm;
use App\Filament\Admin\Resources\Jadwals\Tables\JadwalsTable;
use App\Models\Jadwal;
use BackedEnum;
use UnitEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class JadwalResource extends Resource
{
    protected static ?string $model = Jadwal::class;

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-calendar-days';

    protected static ?string $recordTitleAttribute = 'kode_kelas';

    protected static string|UnitEnum|null $navigationGroup = 'Data Akademik';

    protected static ?int $navigationSort = 6;

    protected static ?string $modelLabel = 'Jadwal';

    protected static ?string $pluralModelLabel = 'Jadwal';

    public static function form(Schema $schema): Schema
    {
        return JadwalForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return JadwalsTable::configure($table);
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
            'index' => ListJadwals::route('/'),
            'create' => CreateJadwal::route('/create'),
            'edit' => EditJadwal::route('/{record}/edit'),
        ];
    }
}
