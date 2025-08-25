// lib/core/constants/app_constants.dart

class AppConstants {
  // Roles de usuario
  static const String ROLE_PASSENGER = 'passenger';
  static const String ROLE_DRIVER = 'driver';
  static const String ROLE_ADMIN = 'admin';

  // Rutas de navegación según rol
  static const String ROUTE_PASSENGER_HOME = '/passenger/home';
  static const String ROUTE_DRIVER_HOME = '/driver/home';
  static const String ROUTE_ADMIN_HOME = '/admin/home';

  // Títulos de páginas
  static const String TITLE_PASSENGER = 'Pasajero';
  static const String TITLE_DRIVER = 'Conductor';
  static const String TITLE_ADMIN = 'Administrador';

  // Otros
  static const String APP_NAME = 'RutaIQ';
  static const String APP_DESCRIPTION = 'Sistema de Transporte Público';
}