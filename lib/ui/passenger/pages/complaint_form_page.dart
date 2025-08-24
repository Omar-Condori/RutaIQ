// lib/ui/passenger/pages/complaint_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplaintFormPage extends ConsumerWidget {
  const ComplaintFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Problema'),
      ),
      body: const Center(
        child: Text('Formulario de quejas para pasajeros - En desarrollo'),
      ),
    );
  }
}

