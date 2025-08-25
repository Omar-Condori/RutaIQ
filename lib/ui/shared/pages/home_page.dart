// lib/ui/shared/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../admin/pages/admin_home_page.dart';
import '../../driver/pages/driver_home_page.dart';
import '../../passenger/pages/passenger_home_page.dart';
import '../widgets/loading_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('Usuario no autenticado')),
          );
        }

        final userRoleAsync = ref.watch(userRoleProvider(user.id));

        return userRoleAsync.when(
          data: (role) {
            switch (role) {
              case AppConstants.ROLE_ADMIN:
                return const AdminHomePage();
              case AppConstants.ROLE_DRIVER:
                return const DriverHomePage();
              case AppConstants.ROLE_PASSENGER:
              default:
                return const PassengerHomePage();
            }
          },
          loading: () => const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando perfil...'),
                ],
              ),
            ),
          ),
          error: (error, stack) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error al cargar perfil: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Refrescar el provider
                      ref.invalidate(userRoleProvider(user.id));
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Iniciando sesión...'),
            ],
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error de autenticación: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Refrescar el provider
                  ref.invalidate(authStateProvider);
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}