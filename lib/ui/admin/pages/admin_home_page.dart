// lib/ui/admin/pages/admin_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/empresa_provider.dart';
import '../widgets/admin_stats_widget.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({Key? key}) : super(key: key);

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

        final empresaAsync = ref.watch(empresaByAdminProvider(user.id));

        return empresaAsync.when(
          data: (empresa) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Panel Administrador - ${empresa?.nombre ?? "Sin empresa"}'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
                  ),
                ],
              ),
              body: empresa == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.business,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No tienes una empresa asignada',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Necesitas crear una empresa para continuar',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => context.push('/admin/create-empresa'),
                            child: const Text('Crear Empresa'),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdminStatsWidget(empresaId: empresa.id),
                          const SizedBox(height: 20),
                          _AdminMenuGrid(empresaId: empresa.id),
                          const SizedBox(height: 20),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.business, color: Colors.blue),
                              title: const Text('Gestionar Empresa'),
                              subtitle: const Text('Editar información de la empresa'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // TODO: Implementar página de gestión de empresa
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Scaffold(
            body: Center(
              child: Text('Error: $error'),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Error de autenticación: $error'),
        ),
      ),
    );
  }
}

class _AdminMenuGrid extends StatelessWidget {
  final String empresaId;
  
  const _AdminMenuGrid({required this.empresaId});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      _MenuItem(
        title: 'Conductores',
        icon: Icons.person,
        color: Colors.blue,
        route: '/admin/drivers',
        empresaId: empresaId,
      ),
      _MenuItem(
        title: 'Vehículos',
        icon: Icons.directions_car,
        color: Colors.green,
        route: '/admin/vehicles',
        empresaId: empresaId,
      ),
      _MenuItem(
        title: 'Líneas',
        icon: Icons.route,
        color: Colors.orange,
        route: '/admin/lines',
        empresaId: empresaId,
      ),
      _MenuItem(
        title: 'Quejas',
        icon: Icons.feedback,
        color: Colors.red,
        route: '/admin/complaints',
        empresaId: empresaId,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Card(
          elevation: 2,
          child: InkWell(
            onTap: () => context.push('${item.route}?empresaId=${item.empresaId}'),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 48,
                    color: item.color,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;
  final String empresaId;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
    required this.empresaId,
  });
}