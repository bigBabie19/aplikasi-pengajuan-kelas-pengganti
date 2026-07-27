<?php

declare(strict_types=1);

return [

  // =========================
  // PENDING
  // =========================

  [
    'mahasiswa' => '202200001',
    'kode_kelas' => 'TI401A',
    'ruangan' => 'A302', // A301 dipakai jadwal asal
    'tanggal_kelas_asal' => '2026-08-03',
    'tanggal_kelas_pengganti' => '2026-08-06',
    'jam_mulai' => '08:00',
    'jam_selesai' => '10:00',
    'alasan' => 'Dosen menghadiri seminar nasional.',
    'status' => 'pending',

    'lampiran' => [
      [
        'nama' => 'surat_tugas.pdf',
        'path' => 'lampiran/surat_tugas.pdf',
        'mime' => 'application/pdf',
      ],
    ],

    'metadata' => [
      'platform' => 'android',
      'app_version' => '1.0.0',
    ],
  ],

  [
    'mahasiswa' => '202200002',
    'kode_kelas' => 'TI402A',
    'ruangan' => 'LAB2',
    'tanggal_kelas_asal' => '2026-08-03',
    'tanggal_kelas_pengganti' => '2026-08-07',
    'jam_mulai' => '13:00',
    'jam_selesai' => '15:00',
    'alasan' => 'Dosen menghadiri workshop.',
    'status' => 'pending',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  [
    'mahasiswa' => '202200003',
    'kode_kelas' => 'TI403A',
    'ruangan' => 'A301',
    'tanggal_kelas_asal' => '2026-08-03',
    'tanggal_kelas_pengganti' => '2026-08-10',
    'jam_mulai' => '10:00',
    'jam_selesai' => '12:00',
    'alasan' => 'Dosen menjadi narasumber kegiatan kampus.',
    'status' => 'pending',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  [
    'mahasiswa' => '202200004',
    'kode_kelas' => 'TI404A',
    'ruangan' => 'LAB1',
    'tanggal_kelas_asal' => '2026-08-04',
    'tanggal_kelas_pengganti' => '2026-08-11',
    'jam_mulai' => '08:00',
    'jam_selesai' => '10:00',
    'alasan' => 'Dosen mengikuti rapat fakultas.',
    'status' => 'pending',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  // =========================
  // APPROVED
  // =========================

  [
    'mahasiswa' => '202200005',
    'kode_kelas' => 'TI405A',
    'ruangan' => 'A301',
    'tanggal_kelas_asal' => '2026-08-04',
    'tanggal_kelas_pengganti' => '2026-08-08',
    'jam_mulai' => '13:00',
    'jam_selesai' => '15:00',
    'alasan' => 'Dosen menghadiri kegiatan pengabdian.',
    'status' => 'approved',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  [
    'mahasiswa' => '202200001',
    'kode_kelas' => 'TI401B',
    'ruangan' => 'LAB2',
    'tanggal_kelas_asal' => '2026-08-04',
    'tanggal_kelas_pengganti' => '2026-08-09',
    'jam_mulai' => '10:00',
    'jam_selesai' => '12:00',
    'alasan' => 'Dosen mengikuti pelatihan.',
    'status' => 'approved',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  [
    'mahasiswa' => '202200002',
    'kode_kelas' => 'TI402B',
    'ruangan' => 'B201',
    'tanggal_kelas_asal' => '2026-08-05',
    'tanggal_kelas_pengganti' => '2026-08-12',
    'jam_mulai' => '08:00',
    'jam_selesai' => '10:00',
    'alasan' => 'Dosen mengikuti konferensi.',
    'status' => 'approved',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  [
    'mahasiswa' => '202200003',
    'kode_kelas' => 'TI403B',
    'ruangan' => 'A302',
    'tanggal_kelas_asal' => '2026-08-05',
    'tanggal_kelas_pengganti' => '2026-08-13',
    'jam_mulai' => '13:00',
    'jam_selesai' => '15:00',
    'alasan' => 'Dosen memiliki agenda dinas.',
    'status' => 'approved',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  // =========================
  // REJECTED
  // =========================

  [
    'mahasiswa' => '202200004',
    'kode_kelas' => 'TI404B',
    'ruangan' => 'A301',
    'tanggal_kelas_asal' => '2026-08-05',
    'tanggal_kelas_pengganti' => '2026-08-06',
    'jam_mulai' => '10:00',
    'jam_selesai' => '12:00',
    'alasan' => 'Dosen menghadiri kegiatan luar kampus.',
    'status' => 'rejected',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],

  [
    'mahasiswa' => '202200005',
    'kode_kelas' => 'TI405B',
    'ruangan' => 'LAB1',
    'tanggal_kelas_asal' => '2026-08-06',
    'tanggal_kelas_pengganti' => '2026-08-07',
    'jam_mulai' => '08:00',
    'jam_selesai' => '10:00',
    'alasan' => 'Dosen menjadi pembicara seminar.',
    'status' => 'rejected',

    'lampiran' => [],
    'metadata' => [
      'platform' => 'android',
    ],
  ],
];
