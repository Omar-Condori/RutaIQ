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
      builder: (context, state) => const ManageDriversPage(),
    ),
    GoRoute(
      path: '/admin/vehicles',
      builder: (context, state) => const ManageVehiclesPage(),
    ),
    GoRoute(
      path: '/admin/lines',
      builder: (context, state) => const ManageLinesPage(),
    ),
    GoRoute(
      path: '/admin/complaints',
      builder: (context, state) => const ComplaintsAdminPage(),
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