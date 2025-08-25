// lib/ui/admin/pages/create_empresa_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/empresa_provider.dart';
import '../../../models/empresa_model.dart';
import '../../../providers/auth_provider.dart';

class CreateEmpresaPage extends ConsumerStatefulWidget {
  const CreateEmpresaPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateEmpresaPage> createState() => _CreateEmpresaPageState();
}

class _CreateEmpresaPageState extends ConsumerState<CreateEmpresaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _rucController = TextEditingController();
  final _contactoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _rucController.dispose();
    _contactoController.dispose();
    super.dispose();
  }

  Future<void> _createEmpresa() async {
    if (!_formKey.currentState!.validate()) return;

    final authState = ref.read(authStateProvider);
    final user = authState.value;
    
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario no autenticado')),
      );
      return;
    }

    try {
      final empresa = EmpresaModel(
        id: '',
        nombre: _nombreController.text.trim(),
        ruc: _rucController.text.trim(),
        contacto: _contactoController.text.trim(),
        adminId: user.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdEmpresa = await ref.read(empresaNotifierProvider.notifier).createEmpresa(empresa);
      
      // Asociar la empresa al usuario
      await ref.read(authServiceProvider).associateUserWithEmpresa(user.id, createdEmpresa.id);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empresa creada exitosamente')),
        );
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Empresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Empresa',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el nombre de la empresa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rucController,
                decoration: const InputDecoration(
                  labelText: 'RUC',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el RUC';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactoController,
                decoration: const InputDecoration(
                  labelText: 'Contacto (Email)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el contacto';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor ingresa un email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _createEmpresa,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Crear Empresa',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
