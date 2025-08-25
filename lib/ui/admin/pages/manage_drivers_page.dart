// lib/ui/admin/pages/manage_drivers_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/driver_provider.dart';

class ManageDriversPage extends ConsumerWidget {
  final String empresaId;
  
  const ManageDriversPage({Key? key, required this.empresaId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driversAsync = ref.watch(driversByEmpresaProvider(empresaId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Conductores'),
      ),
      body: driversAsync.when(
        data: (drivers) {
          if (drivers.isEmpty) {
            return const Center(
              child: Text('No hay conductores registrados'),
            );
          }
          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(driver.nombre),
                subtitle: Text(driver.telefono),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
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

