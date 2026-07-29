<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RejectPengajuanRequest;
use App\Http\Requests\ApprovePengajuanRequest;
use App\Http\Requests\SubmitPengajuanRequest;
use App\Http\Resources\PengajuanResource;
use App\Models\User;
use App\Models\Pengajuan;
use App\Services\PengajuanService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Symfony\Component\HttpFoundation\Response;

final class PengajuanController extends Controller
{
    private const RELATIONS = [
        'jadwal',
        'ruangan',
        'mahasiswa',
        'processedBy',
    ];

    public function __construct(
        private readonly PengajuanService $pengajuanService,
    ) {}

    public function store(
        SubmitPengajuanRequest $request
    ): JsonResponse {
        /** @var \App\Models\Mahasiswa $mahasiswa */
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
        ApprovePengajuanRequest $request
    ): JsonResponse {
        /** @var User $admin */
        $admin = $request->user();

        $pengajuan = $this->pengajuanService->approve(
            pengajuan: $pengajuan,
            admin: $admin,
            catatan: $request->input('catatan_admin')
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
        /** @var User $admin */
        $admin = $request->user();

        $pengajuan = $this->pengajuanService->reject(
            pengajuan: $pengajuan,
            admin: $admin,
            catatan: $request->validated('catatan_admin')
        );

        return response()->json([
            'message' => 'Pengajuan kelas pengganti berhasil ditolak.',
            'data' => new PengajuanResource($pengajuan),
        ]);
    }

    public function show(
        Request $request,
        Pengajuan $pengajuan
    ): PengajuanResource {

        /** @var User $user */
        $user = $request->user();

        if (
            $user->hasRole('mahasiswa')
            && $pengajuan->mahasiswa_id !== $user->mahasiswa->id
        ) {
            abort(Response::HTTP_FORBIDDEN);
        }

        return new PengajuanResource(
            $pengajuan->load(self::RELATIONS)
        );
    }

    public function index(
        Request $request
    ): AnonymousResourceCollection {

        /** @var \App\Models\User $user */
        $user = $request->user();

        $query = Pengajuan::query()
            ->with(self::RELATIONS)
            ->when(
                $user->hasRole('mahasiswa'),
                fn($query) => $query->where(
                    'mahasiswa_id',
                    $user->mahasiswa->id
                )
            );

        $pengajuans = $query
            ->latest()
            ->paginate(10);

        return PengajuanResource::collection($pengajuans);
    }
}
