// lib/ui/passenger/pages/map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapPage extends ConsumerWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Rutas'),
      ),
      body: const Center(
        child: Text('Página del mapa - En desarrollo'),
      ),
    );
  }
}

