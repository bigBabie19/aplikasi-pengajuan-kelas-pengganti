<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Dosen
 */
final class DosenResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'nidn' => $this->nidn,
            'user' => new UserResource(
                $this->whenLoaded('user')
            ),
            'program_studi' => new ProgramStudiResource(
                $this->whenLoaded('programStudi')
            ),
        ];
    }
}
