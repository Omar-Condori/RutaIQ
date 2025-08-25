// lib/ui/admin/pages/manage_lines_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/line_provider.dart';

class ManageLinesPage extends ConsumerWidget {
  final String empresaId;
  
  const ManageLinesPage({Key? key, required this.empresaId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linesAsync = ref.watch(linesByEmpresaProvider(empresaId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Líneas'),
      ),
      body: linesAsync.when(
        data: (lines) {
          if (lines.isEmpty) {
            return const Center(
              child: Text('No hay líneas registradas'),
            );
          }
          return ListView.builder(
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];
              return ListTile(
                leading: const Icon(Icons.route),
                title: Text(line.nombre),
                subtitle: Text('Tarifa: \$${line.tarifa}'),
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
          // TODO: Implementar agregar línea
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

