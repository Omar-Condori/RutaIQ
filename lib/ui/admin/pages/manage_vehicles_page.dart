// lib/ui/admin/pages/manage_vehicles_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/vehicle_provider.dart';

class ManageVehiclesPage extends ConsumerWidget {
  final String empresaId;
  
  const ManageVehiclesPage({Key? key, required this.empresaId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesByEmpresaProvider(empresaId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Vehículos'),
      ),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return const Center(
              child: Text('No hay vehículos registrados'),
            );
          }
          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return ListTile(
                leading: const Icon(Icons.directions_car),
                title: Text(vehicle.placa),
                subtitle: Text('Interno: ${vehicle.numeroInterno}'),
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
          // TODO: Implementar agregar vehículo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

