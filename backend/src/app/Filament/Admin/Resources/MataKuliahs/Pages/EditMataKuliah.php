<?php

namespace App\Filament\Admin\Resources\MataKuliahs\Pages;

use App\Filament\Admin\Resources\MataKuliahs\MataKuliahResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditMataKuliah extends EditRecord
{
    protected static string $resource = MataKuliahResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
