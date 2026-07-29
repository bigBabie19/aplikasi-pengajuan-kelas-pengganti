<?php

namespace App\Filament\Admin\Resources\Jadwals\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\DeleteAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Filament\Tables\Filters\SelectFilter;
use App\Enums\HariEnum;
use App\Enums\SemesterEnum;

class JadwalsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('mataKuliah.nama')
                    ->label('Mata Kuliah')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('dosen.user.name')
                    ->label('Dosen')
                    ->searchable(),
                TextColumn::make('ruangan.nama')
                    ->label('Ruangan')
                    ->searchable(),
                TextColumn::make('kode_kelas')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('jumlah_peserta')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('hari')
                    ->badge(),
                TextColumn::make('jam_mulai')
                    ->time('H:i')
                    ->sortable(),
                TextColumn::make('jam_selesai')
                    ->time('H:i')
                    ->sortable(),
                TextColumn::make('tahun_ajaran')
                    ->searchable(),
                TextColumn::make('semester')
                    ->badge(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                SelectFilter::make('hari')
                    ->options(HariEnum::class),

                SelectFilter::make('semester')
                    ->options(SemesterEnum::class),

                SelectFilter::make('ruangan_id')
                    ->relationship('ruangan', 'nama'),
            ])
            ->recordActions([
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
