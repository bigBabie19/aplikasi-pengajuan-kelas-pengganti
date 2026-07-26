<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\RejectPengajuanRequest;
use App\Http\Requests\SubmitPengajuanRequest;
use App\Http\Resources\PengajuanResource;
use App\Models\Pengajuan;
use App\Services\PengajuanService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Symfony\Component\HttpFoundation\Response;
use App\Http\Controllers\Controller;

class PengajuanController extends Controller
{
    public function __construct(
        private readonly PengajuanService $pengajuanService,
    ) {}

    public function store(
        SubmitPengajuanRequest $request
    ): JsonResponse {
        $mahasiswa = $request->user()->mahasiswa;

        $pengajuan = $this->pengajuanService->submit(
            validatedData: $request->validated(),
            mahasiswa: $mahasiswa,
        );

        return response()->json([
            'message' => 'Pengajuan kelas pengganti berhasil dibuat.',
            'data' => new PengajuanResource($pengajuan),
        ], Response::HTTP_CREATED);
    }

    public function approve(
        Pengajuan $pengajuan,
        Request $request
    ): JsonResponse {
        $pengajuan = $this->pengajuanService->approve(
            pengajuan: $pengajuan,
            admin: $request->user(),
        );

        return response()->json([
            'message' => 'Pengajuan kelas pengganti berhasil disetujui.',
            'data' => new PengajuanResource($pengajuan),
        ]);
    }

    public function reject(
        RejectPengajuanRequest $request,
        Pengajuan $pengajuan
    ): JsonResponse {
        $pengajuan = $this->pengajuanService->reject(
            pengajuan: $pengajuan,
            admin: $request->user(),
            catatan: $request->validated('catatan'),
        );

        return response()->json([
            'message' => 'Pengajuan kelas pengganti berhasil ditolak.',
            'data' => new PengajuanResource($pengajuan),
        ]);
    }

    public function show(
        Pengajuan $pengajuan
    ): PengajuanResource {
        return new PengajuanResource(
            $pengajuan->load([
                'jadwal',
                'ruangan',
                'mahasiswa',
                'processedBy',
            ])
        );
    }

    public function index(
        Request $request
    ): AnonymousResourceCollection {

        $pengajuans = Pengajuan::query()
            ->with([
                'jadwal',
                'ruangan',
                'mahasiswa',
                'processedBy',
            ])
            ->where('mahasiswa_id', $request->user()->mahasiswa->id)
            ->latest()
            ->paginate();

        return PengajuanResource::collection($pengajuans);
    }
}
