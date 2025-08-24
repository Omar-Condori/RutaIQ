// lib/ui/driver/pages/driver_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DriverHomePage extends ConsumerWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del Conductor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Implementar logout
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Página de inicio del conductor - En desarrollo'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Quejas',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              context.go('/driver/profile');
              break;
            case 2:
              context.go('/driver/complaints');
              break;
          }
        },
      ),
    );
  }
}

