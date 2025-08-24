// lib/ui/driver/pages/driver_profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverProfilePage extends ConsumerWidget {
  const DriverProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: const Center(
        child: Text('Página de perfil del conductor - En desarrollo'),
      ),
    );
  }
}

