// lib/ui/admin/widgets/admin_stats_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/vehicle_provider.dart';
import '../../../providers/line_provider.dart';
import '../../../providers/driver_provider.dart';
import '../../../providers/auth_provider.dart';

class AdminStatsWidget extends ConsumerWidget {
  final String empresaId;
  
  const AdminStatsWidget({Key? key, required this.empresaId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesByEmpresaProvider(empresaId));
    final linesAsync = ref.watch(linesByEmpresaProvider(empresaId));
    final driversAsync = ref.watch(driversByEmpresaProvider(empresaId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estadísticas de la Empresa',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.person,
                  label: 'Conductores',
                  value: driversAsync.when(
                    data: (drivers) => drivers.length.toString(),
                    loading: () => '...',
                    error: (_, __) => '0',
                  ),
                  color: Colors.blue,
                ),
                _StatItem(
                  icon: Icons.directions_car,
                  label: 'Vehículos',
                  value: vehiclesAsync.when(
                    data: (vehicles) => vehicles.length.toString(),
                    loading: () => '...',
                    error: (_, __) => '0',
                  ),
                  color: Colors.green,
                ),
                _StatItem(
                  icon: Icons.route,
                  label: 'Líneas',
                  value: linesAsync.when(
                    data: (lines) => lines.length.toString(),
                    loading: () => '...',
                    error: (_, __) => '0',
                  ),
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

