@php
use Illuminate\Support\Str;
use Carbon\Carbon;

$metadata = $mongodb['metadata'] ?? [];

$statusTerakhir = $metadata['status_terakhir'] ?? $pengajuan->status;

$statusColor = match($statusTerakhir) {
'approved' => 'bg-green-100 text-green-700 dark:bg-green-900 dark:text-green-300',
'pending' => 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900 dark:text-yellow-300',
'rejected' => 'bg-red-100 text-red-700 dark:bg-red-900 dark:text-red-300',
default => 'bg-gray-100 text-gray-700 dark:bg-gray-900 dark:text-gray-300',
};
@endphp

<x-filament-panels::page>

    <x-filament::section>
        <x-slot name="heading">
            Informasi Mahasiswa
        </x-slot>

        <div class="grid grid-cols-1 gap-6 md:grid-cols-2">

            <div>
                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    Nama
                </p>

                <p class="mt-1 text-base font-semibold">
                    {{ $pengajuan->mahasiswa->user->name }}
                </p>
            </div>

            <div>
                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    NIM
                </p>

                <p class="mt-1 text-base font-semibold">
                    {{ $pengajuan->mahasiswa->nim }}
                </p>
            </div>

            <div>
                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    Program Studi
                </p>

                <p class="mt-1 text-base font-semibold">
                    {{ $pengajuan->mahasiswa->programStudi->nama }}
                </p>
            </div>

            <div>
                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    Status Mahasiswa
                </p>

                <p class="mt-1">
                    <x-filament::badge color="success">
                        Aktif
                    </x-filament::badge>
                </p>
            </div>

        </div>
    </x-filament::section>

    <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <x-filament::section>
            <x-slot name="heading">
                Informasi Pengajuan
            </x-slot>

            @php
            $statusBadgeColor = match($pengajuan->status) {
            'approved' => 'success',
            'pending' => 'warning',
            'rejected' => 'danger',
            default => 'gray',
            };
            @endphp

            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Mata Kuliah
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ $pengajuan->jadwal->mataKuliah->nama }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Dosen
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ $pengajuan->jadwal->dosen->user->name }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Kelas
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ $pengajuan->jadwal->kode_kelas }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Ruangan
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ $pengajuan->ruangan->nama }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Tanggal Kelas Asal
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ \Carbon\Carbon::parse($pengajuan->tanggal_kelas_asal)->format('d M Y') }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Tanggal Pengganti
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ \Carbon\Carbon::parse($pengajuan->tanggal_kelas_pengganti)->format('d M Y') }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Jam Mulai
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ \Carbon\Carbon::parse($pengajuan->jam_mulai)->format('H:i') }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Jam Selesai
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ \Carbon\Carbon::parse($pengajuan->jam_selesai)->format('H:i') }}
                    </p>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Status Pengajuan
                    </p>

                    <x-filament::badge :color="$statusBadgeColor">
                        {{ ucfirst($pengajuan->status) }}
                    </x-filament::badge>
                </div>

                <div>
                    <p class="text-sm font-medium text-gray-500">
                        Tanggal Pengajuan
                    </p>

                    <p class="mt-1 font-semibold">
                        {{ $pengajuan->created_at->format('d M Y H:i') }}
                    </p>
                </div>

            </div>
        </x-filament::section>

        <x-filament::section>
            <x-slot name="heading">
                Informasi MongoDB
            </x-slot>

            @php
            $metadataBadgeColor = match($statusTerakhir) {
            'approved' => 'success',
            'pending' => 'warning',
            'rejected' => 'danger',
            default => 'gray',
            };
            @endphp

            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <p class="text-sm text-gray-500">Status Terakhir</p>

                    <x-filament::badge :color="$metadataBadgeColor">
                        {{ ucfirst($statusTerakhir) }}
                    </x-filament::badge>
                </div>

                <div>
                    <p class="text-sm text-gray-500">Diproses Pada</p>

                    <p class="mt-1 font-semibold">
                        {{ isset($metadata['processed_at'])
                    ? Carbon::parse($metadata['processed_at'])->format('d M Y H:i')
                    : '-' }}
                    </p>
                </div>

                <div>
                    <p class="text-sm text-gray-500">Diproses Oleh</p>

                    <p class="mt-1 font-semibold">
                        {{ $pengajuan->processedBy?->name ?? '-' }}
                    </p>
                </div>

                <div class="md:col-span-2">
                    <p class="text-sm text-gray-500">
                        Lampiran
                    </p>

                    @php
                    $lampiran = $mongodb['lampiran'][0] ?? null;
                    @endphp

                    @if($lampiran)


                    <div class="mt-2">

                        <div class="font-medium">
                            {{ $lampiran['nama_asli'] }}
                        </div>

                        <div class="text-sm text-gray-500">
                            {{ strtoupper($lampiran['mime_type']) }}
                        </div>

                        <x-filament::button
                            tag="a"
                            href="{{ asset('storage/'.$lampiran['path']) }}"
                            target="_blank"
                            icon="heroicon-o-paper-clip"
                            class="mt-3">
                            Lihat Lampiran
                        </x-filament::button>

                    </div>

                    @else

                    <span class="text-gray-500">
                        Tidak ada lampiran
                    </span>

                    @endif
                </div>

            </div>
        </x-filament::section>
    </div>

    <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <x-filament::section>
            <x-slot name="heading">
                Riwayat Status
            </x-slot>

            <div class="space-y-6">

                @foreach($mongodb['riwayat_status'] as $history)

                @php
                $dotColor = match($history['status']) {
                'approved' => 'bg-success-500',
                'pending' => 'bg-warning-500',
                'rejected' => 'bg-danger-500',
                default => 'bg-gray-400',
                };

                $badgeColor = match($history['status']) {
                'approved' => 'success',
                'pending' => 'warning',
                'rejected' => 'danger',
                default => 'gray',
                };
                @endphp

                <div class="flex gap-4">

                    {{-- Timeline --}}
                    <div class="flex flex-col items-center">
                        <div class="h-3 w-3 rounded-full {{ $dotColor }}"></div>

                        @unless($loop->last)
                        <div class="mt-2 h-full w-px bg-gray-300 dark:bg-gray-700"></div>
                        @endunless
                    </div>

                    {{-- Content --}}
                    <div class="flex-1 rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-700 dark:bg-gray-900">

                        <div class="flex items-center justify-between">

                            <x-filament::badge :color="$badgeColor">
                                {{ ucfirst($history['status']) }}
                            </x-filament::badge>

                            <span class="text-sm text-gray-500">
                                {{ isset($history['waktu']) ? Carbon::parse($history['waktu'])->format('d M Y H:i') : '-' }}
                            </span>

                        </div>

                        <p class="mt-3 text-sm text-gray-600 dark:text-gray-400">
                            {{ $history['catatan'] ?? '-' }}
                        </p>

                    </div>

                </div>

                @endforeach

            </div>
        </x-filament::section>

        <x-filament::section>
            <x-slot name="heading">
                Activity Log
            </x-slot>

            <div class="space-y-3">

                @foreach($mongodb['activity_log'] as $activity)

                <div class="flex items-start gap-3 rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-700 dark:bg-gray-900">

                    <x-heroicon-o-cog-6-tooth
                        class="mt-1 h-5 w-5 text-primary-500" />

                    <div class="flex-1 ml-2">

                        <div class="font-medium">
                            {{ Str::headline($activity['step'] ?? '-') }}
                        </div>

                        <div class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                            {{ $activity['message'] ?? '-' }}
                        </div>

                    </div>

                </div>

                @endforeach

            </div>
        </x-filament::section>
    </div>

</x-filament-panels::page>