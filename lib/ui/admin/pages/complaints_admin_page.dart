// lib/ui/admin/pages/complaints_admin_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/complaint_provider.dart';

class ComplaintsAdminPage extends ConsumerWidget {
  final String empresaId;
  
  const ComplaintsAdminPage({Key? key, required this.empresaId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complaintsAsync = ref.watch(complaintsByEmpresaProvider(empresaId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quejas y Reclamos'),
      ),
      body: complaintsAsync.when(
        data: (complaints) {
          if (complaints.isEmpty) {
            return const Center(
              child: Text('No hay quejas registradas'),
            );
          }
          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return ListTile(
                leading: const Icon(Icons.feedback),
                title: Text(complaint.userName),
                subtitle: Text(complaint.description),
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
    );
  }
}

