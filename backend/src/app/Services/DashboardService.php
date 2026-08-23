<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Pengajuan;
use App\Models\User;

final class DashboardService
{
  public function getDashboardData(User $user): array
  {
    $summary = [
      'total' => 0,
      'pending' => 0,
      'approved' => 0,
      'rejected' => 0,
    ];

    $query = Pengajuan::query();

    if ($user->hasRole('mahasiswa')) {
      $query->where('user_id', $user->id);
    } elseif ($user->hasRole('dosen')) {

      $dosen = $user->dosen;

      if (! $dosen) {
        return [
          'user' => [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'avatar_url' => $user->avatar_url,
          ],
          'summary' => [
            'total' => 0,
            'pending' => 0,
            'approved' => 0,
            'rejected' => 0,
          ],
          'recent_submissions' => [],
        ];
      }

      $query->whereHas('jadwal', function ($query) use ($dosen): void {
        $query->where('dosen_id', $dosen->id);
      });
    } else {
      $query->whereRaw('1 = 0');
    }

    $summary = [
      'total' => (clone $query)->count(),

      'pending' => (clone $query)
        ->where('status', 'pending')
        ->count(),

      'approved' => (clone $query)
        ->where('status', 'approved')
        ->count(),

      'rejected' => (clone $query)
        ->where('status', 'rejected')
        ->count(),
    ];

    $recentSubmissions = (clone $query)
      ->with([
        'jadwal.mataKuliah',
        'jadwal.dosen',
        'ruangan',
        'user',
      ])
      ->latest()
      ->take(5)
      ->get()
      ->map(function (Pengajuan $pengajuan) {
        return [
          'id' => $pengajuan->id,
          'course_name' => $pengajuan->jadwal?->mataKuliah?->nama ?? '-',
          'lecturer' => $pengajuan->jadwal?->dosen?->user?->name ?? '-',
          'submitter' => $pengajuan->user?->name ?? '-',
          'room' => $pengajuan->ruangan?->nama ?? '-',
          'day' => $pengajuan->tanggal_kelas_pengganti?->translatedFormat('l') ?? '-',
          'date' => $pengajuan->tanggal_kelas_pengganti?->format('d M Y') ?? '-',
          'time' => sprintf(
            '%s - %s',
            $pengajuan->jam_mulai?->format('H:i'),
            $pengajuan->jam_selesai?->format('H:i'),
          ),
          'status' => $pengajuan->status,
          'approval_reason' => $pengajuan->catatan_admin,
        ];
      })
      ->values();

    return [
      'user' => [
        'id' => $user->id,
        'name' => $user->name,
        'email' => $user->email,
        'avatar_url' => $user->avatar_url,
      ],

      'summary' => $summary,

      'recent_submissions' => $recentSubmissions,
    ];
  }
}
