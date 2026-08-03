<?php

declare(strict_types=1);

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PengajuanController;
use App\Http\Controllers\Api\DashboardController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Public Routes
|--------------------------------------------------------------------------
*/

Route::post('/login', [
  AuthController::class,
  'login',
]);

/*
|--------------------------------------------------------------------------
| Protected Routes
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->group(function (): void {

  Route::get('/me', [
    AuthController::class,
    'me',
  ]);

  Route::post('/logout', [
    AuthController::class,
    'logout',
  ]);

  Route::get('/dashboard', DashboardController::class);

  /*
    |--------------------------------------------------------------------------
    | Pengajuan
    |--------------------------------------------------------------------------
    */

  Route::controller(PengajuanController::class)
    ->prefix('pengajuan')
    ->group(function (): void {

      // Data Form Pengajuan
      Route::get('/courses', 'courses');
      Route::get('/schedules', 'schedules');
      Route::get('/available-rooms', 'availableRooms');

      // Mahasiswa & Admin
      Route::get('/', 'index');
      Route::get('/{pengajuan}', 'show');

      // Mahasiswa
      Route::middleware('role:mahasiswa')->group(function (): void {
        Route::post('/', 'store');
      });

      // Admin
      Route::middleware('role:admin')->group(function (): void {
        Route::patch('/{pengajuan}/approve', 'approve');
        Route::patch('/{pengajuan}/reject', 'reject');
      });
    });
});
