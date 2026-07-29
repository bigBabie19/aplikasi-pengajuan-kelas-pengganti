<?php

declare(strict_types=1);

namespace App\Services;

use App\Enums\PengajuanStatus;
use App\Models\Jadwal;
use App\Models\Mahasiswa;
use App\Models\Pengajuan;
use App\Models\PengajuanDetail;
use App\Models\Ruangan;
use App\Models\User;
use App\Support\Hari;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Throwable;

final class PengajuanService
{
  /**
   * Submit pengajuan kelas pengganti.
   *
   * Menyimpan pengajuan baru, menghitung jam selesai otomatis, memeriksa bentrok ruangan,
   * menyimpan lampiran, lalu membuat dokumen detail di MongoDB.
   */
  public function submit(array $validatedData, Mahasiswa $mahasiswa): Pengajuan
  {
    $lampiranPath = null;

    /** @var UploadedFile|null */
    $lampiran = null;

    try {
      $jadwal = $this->findJadwalOrFail($validatedData['jadwal_id']);
      $ruangan = $this->findRuanganOrFail($validatedData['ruangan_id']);

      $tanggalKelasAsal = Carbon::parse($validatedData['tanggal_kelas_asal'])->startOfDay();
      $tanggalKelasPengganti = Carbon::parse($validatedData['tanggal_kelas_pengganti'])->startOfDay();

      $this->validateOriginalClassDate(
        $jadwal,
        $tanggalKelasAsal
      );

      $jamMulai = Carbon::createFromFormat('H:i', $validatedData['jam_mulai']);
      $jamSelesai = $this->calculateEndTime($jadwal, $jamMulai);

      $durasiMenit = (int) round(
        $jadwal->jam_mulai->diffInMinutes($jadwal->jam_selesai)
      );

      $this->validateRoomAvailability(
        jadwal: $jadwal,
        ruangan: $ruangan,
        tanggalKelasPengganti: $tanggalKelasPengganti,
        jamMulai: $jamMulai,
        jamSelesai: $jamSelesai
      );

      $lampiran = $validatedData['lampiran'] ?? null;

      if ($lampiran instanceof UploadedFile) {
        $lampiranPath = $this->simpanLampiran($lampiran, $mahasiswa, $jadwal);
      }

      return $this->withinTransaction(function () use (
        $validatedData,
        $mahasiswa,
        $jadwal,
        $ruangan,
        $lampiran,
        $lampiranPath,
        $tanggalKelasAsal,
        $tanggalKelasPengganti,
        $jamMulai,
        $jamSelesai,
        $durasiMenit
      ) {
        $pengajuan = new Pengajuan([
          'mahasiswa_id' => $mahasiswa->id,
          'jadwal_id' => $jadwal->id,
          'ruangan_id' => $ruangan->id,
          'tanggal_kelas_asal' => $tanggalKelasAsal->toDateString(),
          'tanggal_kelas_pengganti' => $tanggalKelasPengganti->toDateString(),
          'jam_mulai' => $jamMulai->format('H:i:s'),
          'jam_selesai' => $jamSelesai->format('H:i:s'),
          'alasan' => $validatedData['alasan'],
          'status' => PengajuanStatus::Pending->value,
        ]);

        $pengajuan->save();

        $this->createMongoDocument(
          pengajuan: $pengajuan,
          jadwal: $jadwal,
          ruangan: $ruangan,
          lampiran: $lampiran,
          lampiranPath: $lampiranPath,
          durasiMenit: $durasiMenit,
          tanggalKelasPengganti: $tanggalKelasPengganti,
          jamSelesai: $jamSelesai
        );

        return $pengajuan->load([
          'jadwal',
          'ruangan',
          'mahasiswa',
        ]);
      });
    } catch (Throwable $throwable) {
      if ($lampiranPath !== null) {
        Storage::disk('public')->delete($lampiranPath);
      }

      throw $throwable;
    }
  }

  /**
   * Validasi bahwa tanggal kelas asal sesuai dengan hari jadwal reguler.
   *
   * Jika tidak sesuai, akan dilemparkan ValidationException.
   */
  private function validateOriginalClassDate(
    Jadwal $jadwal,
    Carbon $tanggalKelasAsal
  ): void {
    $hari = Hari::namaDariTanggal($tanggalKelasAsal);

    if ($hari !== $jadwal->hari->value) {
      throw ValidationException::withMessages([
        'tanggal_kelas_asal' =>
        'Tanggal kelas asal tidak sesuai dengan hari jadwal reguler.',
      ]);
    }
  }

  /**
   * Menyetujui pengajuan.
   *
   * Memperbarui status pengajuan menjadi approved dan menambahkan riwayat proses di MongoDB.
   */
  public function approve(Pengajuan $pengajuan, User $admin, ?string $catatan = null): Pengajuan
  {
    return $this->withinTransaction(function () use ($pengajuan, $admin, $catatan) {
      $pengajuan = $this->ensureProcessable($pengajuan);

      $pengajuan->forceFill([
        'status' => PengajuanStatus::Approved->value,
        'processed_at' => now(),
        'processed_by' => $admin->id,
        'catatan_admin' => $catatan,
      ])->save();

      $this->appendStatusHistory(
        pengajuan: $pengajuan,
        status: PengajuanStatus::Approved,
        admin: $admin,
        catatan: $catatan ?? 'Pengajuan disetujui oleh admin.'
      );

      return $pengajuan->fresh(['jadwal', 'ruangan', 'mahasiswa', 'processedBy']);
    });
  }

  /**
   * Menolak pengajuan.
   *
   * Memperbarui status pengajuan menjadi rejected dan menyimpan catatan penolakan.
   */
  public function reject(Pengajuan $pengajuan, User $admin, ?string $catatan = null): Pengajuan
  {
    return $this->withinTransaction(function () use ($pengajuan, $admin, $catatan) {
      $pengajuan = $this->ensureProcessable($pengajuan);

      $pengajuan->forceFill([
        'status' => PengajuanStatus::Rejected->value,
        'processed_at' => now(),
        'processed_by' => $admin->id,
        'catatan_admin' => $catatan,
      ])->save();

      $this->appendStatusHistory(
        pengajuan: $pengajuan,
        status: PengajuanStatus::Rejected,
        admin: $admin,
        catatan: $catatan ?? 'Pengajuan ditolak oleh admin.'
      );

      return $pengajuan->fresh(['jadwal', 'ruangan', 'mahasiswa', 'processedBy']);
    });
  }

  /**
   * Mengambil daftar ruangan yang tersedia.
   *
   * Digunakan untuk dependent dropdown ruangan berdasarkan tanggal dan jam mulai yang dipilih mahasiswa.
   */
  public function getAvailableRooms(array $data): Collection
  {
    $jadwal = $this->findJadwalOrFail($data['jadwal_id'] ?? null);

    $tanggalKelasPengganti = Carbon::parse($data['tanggal_kelas_pengganti'] ?? null)->startOfDay();
    $jamMulai = Carbon::createFromFormat('H:i', $data['jam_mulai'] ?? '00:00');
    $jamSelesai = $this->calculateEndTime($jadwal, $jamMulai);
    $hariKelasPengganti = Hari::namaDariTanggal($tanggalKelasPengganti);

    return Ruangan::query()
      ->where('status', 'aktif')
      ->where('kapasitas', '>=', $jadwal->jumlah_peserta)
      ->whereDoesntHave('jadwals', function ($query) use ($jadwal, $hariKelasPengganti, $jamMulai, $jamSelesai): void {
        $query->where('id', '!=', $jadwal->id)
          ->where('hari', $hariKelasPengganti)
          ->where('jam_mulai', '<', $jamSelesai->format('H:i:s'))
          ->where('jam_selesai', '>', $jamMulai->format('H:i:s'));
      })
      ->whereDoesntHave('pengajuans', function ($query) use ($tanggalKelasPengganti, $jamMulai, $jamSelesai): void {
        $query->whereDate('tanggal_kelas_pengganti', $tanggalKelasPengganti->toDateString())
          ->whereIn('status', [
            PengajuanStatus::Pending->value,
            PengajuanStatus::Approved->value,
          ])
          ->where('jam_mulai', '<', $jamSelesai->format('H:i:s'))
          ->where('jam_selesai', '>', $jamMulai->format('H:i:s'));
      })
      ->orderBy('nama')
      ->get();
  }

  /**
   * Menghitung jam selesai berdasarkan durasi jadwal asli.
   *
   * Dipakai agar kelas pengganti selalu memiliki durasi yang sama dengan kelas reguler.
   */
  private function calculateEndTime(Jadwal $jadwal, Carbon|string $jamMulai): Carbon
  {
    $jamMulaiCarbon = $jamMulai instanceof Carbon
      ? $jamMulai->copy()
      : Carbon::createFromFormat('H:i', $jamMulai);

    $jamMulaiJadwal = Carbon::createFromFormat('H:i:s', $jadwal->jam_mulai->format('H:i:s'));
    $jamSelesaiJadwal = Carbon::createFromFormat('H:i:s', $jadwal->jam_selesai->format('H:i:s'));

    if ($jamSelesaiJadwal->lessThanOrEqualTo($jamMulaiJadwal)) {
      throw ValidationException::withMessages([
        'jadwal_id' => 'Durasi jadwal reguler tidak valid.',
      ]);
    }

    $jamSelesai = $jamMulaiCarbon->copy()->addMinutes(
      $jamMulaiJadwal->diffInMinutes($jamSelesaiJadwal)
    );

    if ($jamSelesai->isNextDay()) {
      throw ValidationException::withMessages([
        'jam_mulai' => 'Jam mulai menghasilkan jam selesai yang melewati hari berikutnya.',
      ]);
    }

    return $jamSelesai;
  }

  /**
   * Memastikan ruangan masih tersedia.
   *
   * Method ini dipakai saat submit dan saat menghitung ruangan yang muncul di dropdown.
   */
  private function validateRoomAvailability(
    Jadwal $jadwal,
    Ruangan $ruangan,
    Carbon $tanggalKelasPengganti,
    Carbon $jamMulai,
    Carbon $jamSelesai
  ): void {
    if ($ruangan->status !== 'aktif') {
      throw ValidationException::withMessages([
        'ruangan_id' => 'Ruangan yang dipilih sedang tidak aktif.',
      ]);
    }

    if ($ruangan->kapasitas < $jadwal->jumlah_peserta) {
      throw ValidationException::withMessages([
        'ruangan_id' => 'Kapasitas ruangan tidak mencukupi jumlah peserta kelas.',
      ]);
    }

    $hariPengganti = Hari::namaDariTanggal($tanggalKelasPengganti);
    $jamMulaiValue = $jamMulai->format('H:i:s');
    $jamSelesaiValue = $jamSelesai->format('H:i:s');

    $bentrokJadwalReguler = Jadwal::query()
      ->where('ruangan_id', $ruangan->id)
      ->where('id', '!=', $jadwal->id)
      ->where('hari', $hariPengganti)
      ->where('jam_mulai', '<', $jamSelesaiValue)
      ->where('jam_selesai', '>', $jamMulaiValue)
      ->exists();

    if ($bentrokJadwalReguler) {
      throw ValidationException::withMessages([
        'ruangan_id' => 'Ruangan sudah dipakai oleh jadwal reguler pada tanggal dan jam tersebut.',
      ]);
    }

    $bentrokPengajuan = Pengajuan::query()
      ->where('ruangan_id', $ruangan->id)
      ->whereDate('tanggal_kelas_pengganti', $tanggalKelasPengganti->toDateString())
      ->whereIn('status', [
        PengajuanStatus::Pending->value,
        PengajuanStatus::Approved->value,
      ])
      ->where('jam_mulai', '<', $jamSelesaiValue)
      ->where('jam_selesai', '>', $jamMulaiValue)
      ->exists();

    if ($bentrokPengajuan) {
      throw ValidationException::withMessages([
        'ruangan_id' => 'Ruangan sudah dipilih oleh pengajuan lain pada tanggal dan jam tersebut.',
      ]);
    }
  }

  /**
   * Menyimpan detail pengajuan ke MongoDB.
   *
   * Dokumen ini menyimpan lampiran, riwayat status, aktivitas, dan metadata tambahan pengajuan.
   */
  private function createMongoDocument(
    Pengajuan $pengajuan,
    Jadwal $jadwal,
    Ruangan $ruangan,
    ?UploadedFile $lampiran,
    ?string $lampiranPath,
    int $durasiMenit,
    Carbon $tanggalKelasPengganti,
    Carbon $jamSelesai
  ): void {
    PengajuanDetail::query()->create([
      'pengajuan_id' => $pengajuan->id,
      'lampiran' => $lampiranPath ? [
        'path' => $lampiranPath,
        'nama_asli' => $lampiran?->getClientOriginalName(),
        'mime_type' => $lampiran?->getClientMimeType(),
        'ukuran' => $lampiran?->getSize(),
      ] : null,
      'riwayat_status' => [
        [
          'status' => PengajuanStatus::Pending->value,
          'waktu' => now()->toIso8601String(),
          'catatan' => 'Pengajuan dibuat oleh mahasiswa.',
        ],
      ],
      'activity_log' => [
        [
          'step' => 'validate-room',
          'message' => 'Ruangan diverifikasi terhadap jadwal reguler dan pengajuan lain.',
        ],
        [
          'step' => 'submit',
          'message' => 'Pengajuan kelas pengganti berhasil disimpan.',
        ],
      ],
      'metadata' => [
        'durasi_menit' => $durasiMenit,
        'jam_selesai' => $jamSelesai->format('H:i:s'),
        'hari_pengganti' => Hari::namaDariTanggal($tanggalKelasPengganti),
        'lampiran_ada' => $lampiranPath !== null,
      ],
    ]);
  }

  /**
   * Memastikan pengajuan masih bisa diproses admin.
   *
   * Hanya pengajuan pending yang boleh di-approve atau di-reject.
   */
  private function ensureProcessable(Pengajuan $pengajuan): Pengajuan
  {
    if ($pengajuan->status !== PengajuanStatus::Pending->value) {
      throw ValidationException::withMessages([
        'status' => 'Pengajuan sudah diproses sebelumnya.',
      ]);
    }

    return $pengajuan;
  }

  /**
   * Menyimpan lampiran pengajuan ke storage publik.
   *
   * Nama file dibuat unik agar tidak saling menimpa antar pengajuan.
   */
  private function simpanLampiran(UploadedFile $lampiran, Mahasiswa $mahasiswa, Jadwal $jadwal): string
  {
    if (! $lampiran->isValid()) {
      throw ValidationException::withMessages([
        'lampiran' => 'Lampiran tidak valid atau gagal diunggah.',
      ]);
    }

    $ekstensi = $lampiran->getClientOriginalExtension();
    $namaFile = Str::uuid()->toString() . ($ekstensi !== '' ? '.' . $ekstensi : '');

    return $lampiran->storeAs(
      'pengajuan-lampiran/' . $mahasiswa->id . '/' . $jadwal->id,
      $namaFile,
      'public'
    );
  }

  /**
   * Menambahkan riwayat status ke dokumen MongoDB.
   *
   * Dipakai oleh proses approve dan reject untuk menjaga audit trail tetap lengkap.
   */
  private function appendStatusHistory(Pengajuan $pengajuan, PengajuanStatus $status, User $admin, ?string $catatan = null): void
  {
    $detail = PengajuanDetail::query()->where('pengajuan_id', $pengajuan->id)->first();

    if (! $detail) {
      return;
    }

    $riwayatStatus = $detail->riwayat_status ?? [];
    $riwayatStatus[] = [
      'status' => $status->value,
      'waktu' => now()->toIso8601String(),
      'catatan' => $catatan,
    ];

    $activityLog = $detail->activity_log ?? [];
    $activityLog[] = [
      'step' => $status === PengajuanStatus::Approved ? 'approve' : 'reject',
      'message' => $catatan ?? ($status === PengajuanStatus::Approved
        ? 'Pengajuan disetujui oleh admin.'
        : 'Pengajuan ditolak oleh admin.'),
    ];

    $detail->forceFill([
      'riwayat_status' => $riwayatStatus,
      'activity_log' => $activityLog,
      'metadata' => array_merge($detail->metadata ?? [], [
        'status_terakhir' => $status->value,
        'processed_at' => now()->toIso8601String(),
        'processed_by' => $admin->id,
      ]),
    ])->save();
  }

  /**
   * Jalankan callback dalam transaksi database.
   *
   * @template T
   *
   * @param  callable():T  $callback
   * @return T
   *
   * @throws Throwable
   */
  private function withinTransaction(callable $callback): mixed
  {
    DB::beginTransaction();

    try {
      $result = $callback();
      DB::commit();

      return $result;
    } catch (Throwable $throwable) {
      DB::rollBack();

      throw $throwable;
    }
  }

  /**
   * @throws ValidationException
   */
  private function findJadwalOrFail(int|string|null $jadwalId): Jadwal
  {
    try {
      return Jadwal::query()->findOrFail($jadwalId);
    } catch (ModelNotFoundException $exception) {
      throw ValidationException::withMessages([
        'jadwal_id' => 'Jadwal tidak ditemukan.',
      ]);
    }
  }

  /**
   * @throws ValidationException
   */
  private function findRuanganOrFail(int|string|null $ruanganId): Ruangan
  {
    try {
      return Ruangan::query()->findOrFail($ruanganId);
    } catch (ModelNotFoundException $exception) {
      throw ValidationException::withMessages([
        'ruangan_id' => 'Ruangan tidak ditemukan.',
      ]);
    }
  }

  public function findForAdmin(int $id): array
  {
    $pengajuan = Pengajuan::query()
      ->with([
        'mahasiswa.user',
        'mahasiswa.programStudi',
        'jadwal.mataKuliah',
        'jadwal.dosen.user',
        'ruangan',
        'processedBy',
      ])
      ->findOrFail($id);

    $detail = PengajuanDetail::query()
      ->where('pengajuan_id', $pengajuan->id)
      ->first();

    return [
      'record' => $pengajuan,

      'mongodb' => [
        'lampiran' => $detail?->lampiran ?? [],
        'metadata' => $detail?->metadata ?? [],
        'riwayat_status' => $detail?->riwayat_status ?? [],
        'activity_log' => $detail?->activity_log ?? [],
      ],
    ];
  }
}
