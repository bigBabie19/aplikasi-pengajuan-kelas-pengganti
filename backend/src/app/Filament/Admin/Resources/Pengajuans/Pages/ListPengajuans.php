<?php

namespace App\Filament\Admin\Resources\Pengajuans\Pages;

use App\Filament\Admin\Resources\Pengajuans\PengajuanResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListPengajuans extends ListRecords
{
    protected static string $resource = PengajuanResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
