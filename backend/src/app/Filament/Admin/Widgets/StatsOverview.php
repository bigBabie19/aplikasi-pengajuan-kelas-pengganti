<?php

namespace App\Filament\Admin\Widgets;

use App\Models\Pengajuan;
use App\Enums\PengajuanStatus;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends StatsOverviewWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make(
                'Total Pengajuan',
                Pengajuan::count()
            )
                ->icon('heroicon-o-document-text')
                ->color('primary')
                ->description('Jumlah seluruh pengajuan'),

            Stat::make(
                'Pending',
                Pengajuan::where('status', PengajuanStatus::Pending)->count()
            )
                ->icon('heroicon-o-clock')
                ->color('warning')
                ->description('Menunggu verifikasi'),

            Stat::make(
                'Approved',
                Pengajuan::where('status', PengajuanStatus::Approved)->count()
            )
                ->icon('heroicon-o-check-circle')
                ->color('success')
                ->description('Telah disetujui'),

            Stat::make(
                'Rejected',
                Pengajuan::where('status', PengajuanStatus::Rejected)->count()
            )
                ->icon('heroicon-o-x-circle')
                ->color('danger')
                ->description('Ditolak'),
        ];
    }
}
