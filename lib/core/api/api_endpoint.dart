class ApiEndpoint {
  ApiEndpoint._();

  // IP backend local
  static const String baseUrl = 'http://192.168.1.3/api';

  static const String login = '/login';

  static const String logout = '/logout';

  static const String me = '/me';

  static const String dashboard = '/dashboard';

  static const String jadwal = '/jadwal';

  static const String availableRooms = '/available-rooms';

  static const String pengajuan = '/pengajuan';
}
