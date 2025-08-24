// lib/ui/driver/pages/driver_complaints_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverComplaintsPage extends ConsumerWidget {
  const DriverComplaintsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Quejas'),
      ),
      body: const Center(
        child: Text('Página de quejas del conductor - En desarrollo'),
      ),
    );
  }
}

