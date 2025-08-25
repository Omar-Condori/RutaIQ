// lib/providers/line_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/line_model.dart';
import '../services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final linesByEmpresaProvider = FutureProvider.family<List<LineModel>, String>((ref, empresaId) {
  return ref.watch(firestoreServiceProvider).getLinesByEmpresa(empresaId);
});

class LineNotifier extends StateNotifier<AsyncValue<List<LineModel>>> {
  final FirestoreService _firestoreService;
  final String _empresaId;

  LineNotifier(this._firestoreService, this._empresaId)
      : super(const AsyncValue.loading()) {
    loadLines();
  }

  Future<void> loadLines() async {
    try {
      state = const AsyncValue.loading();
      final lines = await _firestoreService.getLinesByEmpresa(_empresaId);
      state = AsyncValue.data(lines);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createLine(LineModel line) async {
    try {
      await _firestoreService.createLine(line);
      await loadLines();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateLine(LineModel line) async {
    try {
      await _firestoreService.updateLine(line);
      await loadLines();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteLine(String lineId) async {
    try {
      await _firestoreService.deleteLine(lineId);
      await loadLines();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final lineNotifierProvider = StateNotifierProvider.family<LineNotifier, AsyncValue<List<LineModel>>, String>((ref, empresaId) {
  return LineNotifier(ref.watch(firestoreServiceProvider), empresaId);
});
