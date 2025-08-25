// lib/ui/passenger/pages/passenger_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/position_provider.dart';
import '../widgets/line_card_widget.dart';
import '../../shared/widgets/map_widget.dart';

class PassengerHomePage extends ConsumerStatefulWidget {
  const PassengerHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<PassengerHomePage> createState() => _PassengerHomePageState();
}

class _PassengerHomePageState extends ConsumerState<PassengerHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _MapTab(),
          _LinesTab(),
          _ComplaintsTab(),
          _ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Líneas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Quejas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _MapTab extends ConsumerWidget {
  const _MapTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: MapWidget(),
      ),
    );
  }
}

class _LinesTab extends StatelessWidget {
  const _LinesTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Líneas de Transporte'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Lista de líneas
            Expanded(
              child: LineCardWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComplaintsTab extends StatelessWidget {
  const _ComplaintsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Quejas'),
      ),
      body: const Center(
        child: Text('Lista de quejas del usuario'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/passenger/complaint'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ProfileTab extends ConsumerWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
          ),
        ],
      ),
      body: const Center(
        child: Text('Perfil del usuario'),
      ),
    );
  }
}