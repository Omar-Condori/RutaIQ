// lib/providers/empresa_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/empresa_repository.dart';
import '../models/empresa_model.dart';

final empresaRepositoryProvider = Provider<EmpresaRepository>((ref) {
  return EmpresaRepository();
});

final empresaProvider = FutureProvider.family<EmpresaModel?, String>((ref, empresaId) {
  return ref.watch(empresaRepositoryProvider).getEmpresaById(empresaId);
});

final empresaByAdminProvider = FutureProvider.family<EmpresaModel?, String>((ref, adminId) {
  return ref.watch(empresaRepositoryProvider).getEmpresaByAdminId(adminId);
});

final allEmpresasProvider = FutureProvider<List<EmpresaModel>>((ref) {
  return ref.watch(empresaRepositoryProvider).getAllEmpresas();
});

class EmpresaNotifier extends StateNotifier<AsyncValue<List<EmpresaModel>>> {
  final EmpresaRepository _repository;

  EmpresaNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadEmpresas() async {
    state = const AsyncValue.loading();
    try {
      final empresas = await _repository.getAllEmpresas();
      state = AsyncValue.data(empresas);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<EmpresaModel> createEmpresa(EmpresaModel empresa) async {
    try {
      final createdEmpresa = await _repository.createEmpresa(empresa);
      await loadEmpresas();
      return createdEmpresa;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateEmpresa(EmpresaModel empresa) async {
    try {
      await _repository.updateEmpresa(empresa);
      await loadEmpresas();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteEmpresa(String empresaId) async {
    try {
      await _repository.deleteEmpresa(empresaId);
      await loadEmpresas();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final empresaNotifierProvider = StateNotifierProvider<EmpresaNotifier, AsyncValue<List<EmpresaModel>>>((ref) {
  return EmpresaNotifier(ref.watch(empresaRepositoryProvider));
});
