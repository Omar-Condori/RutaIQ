// lib/ui/admin/pages/manage_drivers_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageDriversPage extends ConsumerWidget {
  const ManageDriversPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Conductores'),
      ),
      body: const Center(
        child: Text('Página de gestión de conductores - En desarrollo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar agregar conductor
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

