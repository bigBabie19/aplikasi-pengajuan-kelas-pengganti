<?php

declare(strict_types=1);

namespace App\Support;

use Carbon\Carbon;

final class Hari
{
  public static function namaDariTanggal(Carbon $tanggal): string
  {
    return match ($tanggal->dayOfWeekIso) {
      1 => 'Senin',
      2 => 'Selasa',
      3 => 'Rabu',
      4 => 'Kamis',
      5 => 'Jumat',
      6 => 'Sabtu',
      7 => 'Minggu',
    };
  }
}
