<?php

declare(strict_types=1);

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

final class SubmitPengajuanRequest extends FormRequest
{
    /**
     * Otorisasi request ini.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Aturan validasi untuk request ini.
     */
    public function rules(): array
    {
        return [
            'jadwal_id' => [
                'required',
                'integer',
                'exists:jadwals,id',
            ],
            'tanggal_kelas_asal' => [
                'required',
                'date',
                'before:tanggal_kelas_pengganti',
            ],
            'tanggal_kelas_pengganti' => [
                'required',
                'date',
                'after:tanggal_kelas_asal',
            ],
            'jam_mulai' => [
                'required',
                'date_format:H:i',
            ],
            'ruangan_id' => [
                'required',
                'integer',
                Rule::exists('ruangans', 'id')->where('status', 'aktif'),
            ],
            'alasan' => [
                'required',
                'string',
                'max:500',
            ],
            'lampiran' => [
                'nullable',
                'file',
                'mimes:pdf,jpg,jpeg,png',
                'max:5120', // Maksimal 5MB
            ],
        ];
    }

    /**
     * Pesan error kustom untuk validasi.
     */
    public function messages(): array
    {
        return [
            'jadwal_id.required' => 'Jadwal harus dipilih.',
            'jadwal_id.integer' => 'Jadwal tidak valid.',
            'jadwal_id.exists' => 'Jadwal tidak ditemukan.',
            'tanggal_kelas_asal.required' => 'Tanggal kelas asal harus diisi.',
            'tanggal_kelas_asal.date' => 'Tanggal kelas asal tidak valid.',
            'tanggal_kelas_asal.before' => 'Tanggal kelas asal harus lebih awal dari tanggal kelas pengganti.',
            'tanggal_kelas_pengganti.required' => 'Tanggal kelas pengganti harus diisi.',
            'tanggal_kelas_pengganti.date' => 'Tanggal kelas pengganti tidak valid.',
            'tanggal_kelas_pengganti.after_or_equal' => 'Tanggal kelas pengganti harus hari ini atau setelahnya.',
            'jam_mulai.required' => 'Jam mulai harus diisi.',
            'jam_mulai.date_format' => 'Format jam mulai tidak valid. Gunakan format HH:MM.',
            'ruangan_id.required' => 'Ruangan harus dipilih.',
            'ruangan_id.integer' => 'Ruangan tidak valid.',
            'ruangan_id.exists' => 'Ruangan tidak ditemukan atau sedang tidak aktif.',
            'alasan.required' => 'Alasan harus diisi.',
            'alasan.string' => 'Alasan harus berupa teks.',
            'alasan.max' => 'Alasan maksimal 500 karakter.',
            'lampiran.file' => 'Lampiran harus berupa file.',
            'lampiran.mimes' => 'Lampiran harus berupa file PDF, JPG, JPEG, atau PNG.',
            'lampiran.max' => 'Ukuran lampiran maksimal 5MB.',
        ];
    }
}
