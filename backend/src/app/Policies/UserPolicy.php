<?php

declare(strict_types=1);

namespace App\Policies;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Foundation\Auth\User as AuthUser;
use App\Models\User;

final class UserPolicy
{
    use HandlesAuthorization;

    public function before(User $user): ?bool
    {
        return $user->hasRole('admin') ? true : null;
    }

    public function viewAny(User $user): bool
    {
        return false;
    }

    public function create(AuthUser $user): bool
    {
        return false;
    }

    public function update(AuthUser $user): bool
    {
        return false;
    }

    public function delete(AuthUser $user): bool
    {
        return false;
    }
}
