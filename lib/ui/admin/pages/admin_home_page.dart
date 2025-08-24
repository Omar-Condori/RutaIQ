// lib/ui/admin/pages/admin_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';
import '../widgets/admin_stats_widget.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Administrador'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminStatsWidget(),
            SizedBox(height: 20),
            _AdminMenuGrid(),
          ],
        ),
      ),
    );
  }
}

class _AdminMenuGrid extends StatelessWidget {
  const _AdminMenuGrid();

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      _MenuItem(
        title: 'Conductores',
        icon: Icons.person,
        color: Colors.blue,
        route: '/admin/drivers',
      ),
      _MenuItem(
        title: 'Vehículos',
        icon: Icons.directions_car,
        color: Colors.green,
        route: '/admin/vehicles',
      ),
      _MenuItem(
        title: 'Líneas',
        icon: Icons.route,
        color: Colors.orange,
        route: '/admin/lines',
      ),
      _MenuItem(
        title: 'Quejas',
        icon: Icons.feedback,
        color: Colors.red,
        route: '/admin/complaints',
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
            onTap: () => context.push(item.route),
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

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}