// lib/ui/admin/pages/manage_lines_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageLinesPage extends ConsumerWidget {
  const ManageLinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Líneas'),
      ),
      body: const Center(
        child: Text('Página de gestión de líneas - En desarrollo'),
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

