<?php

namespace App\Filament\Admin\Resources\Ruangans\Pages;

use App\Filament\Admin\Resources\Ruangans\RuanganResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditRuangan extends EditRecord
{
    protected static string $resource = RuanganResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
