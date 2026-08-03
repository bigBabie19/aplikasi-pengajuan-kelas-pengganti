<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Pengajuan;
use App\Models\User;

final class DashboardService
{
  public function getDashboardData(User $user): array
  {
    $mahasiswa = $user->mahasiswa;

    if (! $mahasiswa) {
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
        'today_schedules' => [],
      ];
    }

    $summary = [
      'total' => Pengajuan::where('mahasiswa_id', $mahasiswa->id)->count(),

      'pending' => Pengajuan::where('mahasiswa_id', $mahasiswa->id)
        ->where('status', 'pending')
        ->count(),

      'approved' => Pengajuan::where('mahasiswa_id', $mahasiswa->id)
        ->where('status', 'approved')
        ->count(),

      'rejected' => Pengajuan::where('mahasiswa_id', $mahasiswa->id)
        ->where('status', 'rejected')
        ->count(),
    ];

    $recentSubmissions = Pengajuan::query()
      ->with([
        'jadwal.mataKuliah',
        'jadwal.dosen',
        'ruangan',
      ])
      ->where('mahasiswa_id', $mahasiswa->id)
      ->latest()
      ->take(5)
      ->get()
      ->map(function (Pengajuan $pengajuan) {
        return [
          'id' => $pengajuan->id,
          'course_name' => $pengajuan->jadwal?->mataKuliah?->nama ?? '-',
          'lecturer' => $pengajuan->jadwal?->dosen?->user->name ?? '-',
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
