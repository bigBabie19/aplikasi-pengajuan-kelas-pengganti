<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RejectPengajuanRequest;
use App\Http\Requests\ApprovePengajuanRequest;
use App\Http\Requests\SubmitPengajuanRequest;
use App\Http\Resources\PengajuanResource;
use App\Http\Resources\Mobile\CourseDropdownResource;
use App\Http\Resources\Mobile\ScheduleDropdownResource;
use App\Http\Resources\Mobile\RoomDropdownResource;
use App\Models\User;
use App\Models\Pengajuan;
use App\Services\PengajuanService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

final class PengajuanController extends Controller
{
    private const RELATIONS = [
        'user',
        'jadwal',
        'ruangan',
        'processedBy',
    ];

    public function __construct(
        private readonly PengajuanService $pengajuanService,
    ) {}

    public function store(
        SubmitPengajuanRequest $request
    ): JsonResponse {
        /** @var User $user */
        $user = $request->user();

        $pengajuan = $this->pengajuanService->submit(
            validatedData: $request->validated(),
            user: $user,
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
        /** @var \App\Models\User $user */
        $user = $request->user();

        if ($user->hasRole('mahasiswa')) {
            if ($pengajuan->user_id !== $user->id) {
                abort(Response::HTTP_FORBIDDEN);
            }
        }

        if ($user->hasRole('dosen')) {
            $pengajuan->loadMissing('jadwal');

            if ($pengajuan->jadwal?->dosen_id !== $user->dosen?->id) {
                abort(Response::HTTP_FORBIDDEN);
            }
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
            ->with(self::RELATIONS);

        if ($user->hasRole('mahasiswa')) {
            $query->where('user_id', $user->id);
        }

        if ($user->hasRole('dosen')) {
            $query->whereHas('jadwal', function ($query) use ($user): void {
                $query->where('dosen_id', $user->dosen->id);
            });
        }

        $pengajuans = $query
            ->latest()
            ->paginate(10);

        return PengajuanResource::collection($pengajuans);
    }

    public function courses(Request $request): JsonResponse
    {
        $courses = $this->pengajuanService->searchCourses(
            $request->query('search')
        );

        return response()->json([
            'message' => 'Daftar mata kuliah berhasil diambil.',
            'data' => CourseDropdownResource::collection($courses),
        ]);
    }

    public function schedules(Request $request): JsonResponse
    {
        $validated = Validator::make(
            $request->all(),
            [
                'course_id' => ['required', 'integer', 'exists:mata_kuliahs,id'],
            ]
        )->validate();

        $schedules = $this->pengajuanService->getSchedules(
            $validated['course_id']
        );

        return response()->json([
            'message' => 'Daftar jadwal berhasil diambil.',
            'data' => ScheduleDropdownResource::collection($schedules),
        ]);
    }

    public function availableRooms(Request $request): JsonResponse
    {
        $validated = Validator::make(
            $request->all(),
            [
                'jadwal_id' => ['required', 'integer', 'exists:jadwals,id'],
                'tanggal_kelas_pengganti' => ['required', 'date'],
                'jam_mulai' => ['required', 'date_format:H:i'],
            ]
        )->validate();

        $rooms = $this->pengajuanService->getAvailableRooms(
            $validated
        );

        return response()->json([
            'message' => 'Daftar ruangan tersedia berhasil diambil.',
            'data' => RoomDropdownResource::collection($rooms),
        ]);
    }
}
