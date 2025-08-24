// lib/ui/admin/pages/complaints_admin_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplaintsAdminPage extends ConsumerWidget {
  const ComplaintsAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quejas y Reclamos'),
      ),
      body: const Center(
        child: Text('Página de quejas para administradores - En desarrollo'),
      ),
    );
  }
}

