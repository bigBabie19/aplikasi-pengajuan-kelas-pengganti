<?php

namespace App\Filament\Admin\Resources\Pengajuans;

use App\Filament\Admin\Resources\Pengajuans\Pages\ListPengajuans;
use App\Filament\Admin\Resources\Pengajuans\Tables\PengajuansTable;
use App\Filament\Admin\Resources\Pengajuans\Pages\DetailPengajuan;
use App\Models\Pengajuan;
use BackedEnum;
use UnitEnum;
use Illuminate\Database\Eloquent\Builder;
use Filament\Resources\Resource;
use Filament\Tables\Table;

class PengajuanResource extends Resource
{
    protected static ?string $model = Pengajuan::class;

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-document-text';

    protected static ?string $recordTitleAttribute = 'id';

    protected static string|UnitEnum|null $navigationGroup = 'Kelas Pengganti';

    protected static ?int $navigationSort = 1;

    protected static ?string $modelLabel = 'Pengajuan';

    protected static ?string $pluralModelLabel = 'Pengajuan';

    public static function table(Table $table): Table
    {
        return PengajuansTable::configure($table);
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with([
                'user.mahasiswa.programStudi',
                'jadwal.mataKuliah',
                'jadwal.dosen.user',
                'ruangan',
                'processedBy',
            ]);
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
            'index' => ListPengajuans::route('/'),
            'detail' => DetailPengajuan::route('/{record}'),
        ];
    }
}
