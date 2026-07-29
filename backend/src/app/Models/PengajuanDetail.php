<?php

declare(strict_types=1);

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

final class PengajuanDetail extends Model
{
    protected $connection = 'mongodb';

    protected $collection = 'pengajuan_details';

    protected $fillable = [
        'pengajuan_id',
        'lampiran',
        'riwayat_status',
        'activity_log',
        'metadata',
    ];

    protected $casts = [
        'lampiran' => 'array',
        'riwayat_status' => 'array',
        'activity_log' => 'array',
        'metadata' => 'array',
    ];
}
