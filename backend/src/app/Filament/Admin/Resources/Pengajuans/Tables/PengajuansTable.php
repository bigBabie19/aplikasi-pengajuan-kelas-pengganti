<?php

namespace App\Filament\Admin\Resources\Pengajuans\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\Action;
use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;

class PengajuansTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->defaultSort('created_at', 'desc')
            ->recordUrl(fn($record) => \App\Filament\Admin\Resources\Pengajuans\PengajuanResource::getUrl(
                'detail',
                ['record' => $record],
            ))
            ->columns([
                TextColumn::make('user.name')
                    ->label('Pemohon')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('jadwal.mataKuliah.nama')
                    ->label('Mata Kuliah')
                    ->searchable(),
                TextColumn::make('jadwal.dosen.user.name')
                    ->label('Dosen')
                    ->searchable(),
                TextColumn::make('jadwal.kode_kelas')
                    ->label('Kelas'),
                TextColumn::make('ruangan.nama')
                    ->label('Ruangan'),
                TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'pending' => 'warning',
                        'approved' => 'success',
                        'rejected' => 'danger',
                        default => 'gray',
                    })
                    ->sortable(),
                TextColumn::make('created_at')
                    ->label('Tanggal Pengajuan')
                    ->dateTime('d M Y H:i')
                    ->sortable(),
            ])
            ->emptyStateHeading('Belum ada data pengajuan')
            ->emptyStateDescription('Data pengajuan kelas pengganti akan muncul di sini.')
            ->filters([
                //
            ])
            ->recordActions([
                Action::make('detail')
                    ->label('Detail')
                    ->icon('heroicon-o-eye')
                    ->url(
                        fn($record) =>
                        \App\Filament\Admin\Resources\Pengajuans\PengajuanResource::getUrl(
                            'detail',
                            ['record' => $record],
                        )
                    ),

                DeleteAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
