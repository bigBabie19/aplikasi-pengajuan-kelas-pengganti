<?php

namespace App\Filament\Admin\Resources\Pengajuans\Pages;

use App\Filament\Admin\Resources\Pengajuans\PengajuanResource;
use App\Models\Pengajuan;
use App\Services\PengajuanService;
use Filament\Resources\Pages\Concerns\InteractsWithRecord;
use Filament\Resources\Pages\Page;
use Filament\Actions\Action;
use Filament\Notifications\Notification;
use Filament\Forms\Components\Textarea;
use App\Enums\PengajuanStatus;
use App\Models\User;
use Filament\Facades\Filament;

class DetailPengajuan extends Page
{
    use InteractsWithRecord;

    public Pengajuan $pengajuan;

    public array $mongodb = [];

    protected static string $resource = PengajuanResource::class;

    protected string $view = 'filament.admin.resources.pengajuans.pages.detail-pengajuan';

    protected function loadData(): void
    {
        $result = app(PengajuanService::class)
            ->findForAdmin($this->record->id);

        $this->pengajuan = $result['record'];
        $this->mongodb = $result['mongodb'];
    }

    public function mount(int|string $record): void
    {
        $this->record = $this->resolveRecord($record);

        $this->loadData();
    }

    protected function getViewData(): array
    {
        return [
            'pengajuan' => $this->pengajuan,
            'mongodb' => $this->mongodb,
        ];
    }

    protected function admin(): User
    {
        /** @var User $user */
        $user = Filament::auth()->user();

        return $user;
    }

    protected function getHeaderActions(): array
    {
        return [
            Action::make('approve')
                ->label('Approve')
                ->icon(PengajuanStatus::Approved->icon())
                ->color(PengajuanStatus::Approved->color())
                ->hidden(fn() => $this->pengajuan->status !== PengajuanStatus::Pending->value)
                ->requiresConfirmation()
                ->modalHeading('Setujui Pengajuan')
                ->modalDescription('Apakah Anda yakin ingin menyetujui pengajuan ini?')
                ->action(function () {

                    app(PengajuanService::class)
                        ->approve(
                            $this->pengajuan,
                            $this->admin(),
                        );

                    $this->loadData();

                    Notification::make()
                        ->title('Pengajuan berhasil disetujui.')
                        ->success()
                        ->send();
                }),
            Action::make('reject')
                ->label('Reject')
                ->icon(PengajuanStatus::Rejected->icon())
                ->color(PengajuanStatus::Rejected->color())
                ->hidden(fn() => $this->pengajuan->status !== PengajuanStatus::Pending->value)
                ->form([
                    Textarea::make('catatan')
                        ->label('Catatan Penolakan')
                        ->required()
                        ->rows(4),
                ])
                ->action(function (array $data) {

                    app(PengajuanService::class)
                        ->reject(
                            $this->pengajuan,
                            $this->admin(),
                            $data['catatan'],
                        );

                    $this->loadData();

                    Notification::make()
                        ->title('Pengajuan berhasil ditolak.')
                        ->danger()
                        ->send();
                }),
        ];
    }
}
