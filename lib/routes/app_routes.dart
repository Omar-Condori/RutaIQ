// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/auth/pages/login_page.dart';
import '../ui/auth/pages/register_page.dart';
import '../ui/shared/pages/home_page.dart';
import '../ui/splash/splash_page.dart';
import '../ui/admin/pages/manage_drivers_page.dart';
import '../ui/admin/pages/manage_vehicles_page.dart';
import '../ui/admin/pages/manage_lines_page.dart';
import '../ui/admin/pages/complaints_admin_page.dart';
import '../ui/admin/pages/create_empresa_page.dart';
import '../ui/driver/pages/driver_profile_page.dart';
import '../ui/driver/pages/driver_complaints_page.dart';
import '../ui/passenger/pages/complaint_form_page.dart';
import '../ui/passenger/pages/map_page.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    // Rutas de Admin
    GoRoute(
      path: '/admin/drivers',
      builder: (context, state) {
        final empresaId = state.uri.queryParameters['empresaId'];
        return ManageDriversPage(empresaId: empresaId ?? '');
      },
    ),
    GoRoute(
      path: '/admin/vehicles',
      builder: (context, state) {
        final empresaId = state.uri.queryParameters['empresaId'];
        return ManageVehiclesPage(empresaId: empresaId ?? '');
      },
    ),
    GoRoute(
      path: '/admin/lines',
      builder: (context, state) {
        final empresaId = state.uri.queryParameters['empresaId'];
        return ManageLinesPage(empresaId: empresaId ?? '');
      },
    ),
    GoRoute(
      path: '/admin/complaints',
      builder: (context, state) {
        final empresaId = state.uri.queryParameters['empresaId'];
        return ComplaintsAdminPage(empresaId: empresaId ?? '');
      },
    ),
    GoRoute(
      path: '/admin/create-empresa',
      builder: (context, state) => const CreateEmpresaPage(),
    ),
    // Rutas de Conductor
    GoRoute(
      path: '/driver/profile',
      builder: (context, state) => const DriverProfilePage(),
    ),
    GoRoute(
      path: '/driver/complaints',
      builder: (context, state) => const DriverComplaintsPage(),
    ),
    // Rutas de Pasajero
    GoRoute(
      path: '/passenger/complaint',
      builder: (context, state) => const ComplaintFormPage(),
    ),
    GoRoute(
      path: '/passenger/map',
      builder: (context, state) => const MapPage(),
    ),
  ],
);