// lib/ui/admin/pages/manage_vehicles_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageVehiclesPage extends ConsumerWidget {
  const ManageVehiclesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Vehículos'),
      ),
      body: const Center(
        child: Text('Página de gestión de vehículos - En desarrollo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar agregar vehículo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

