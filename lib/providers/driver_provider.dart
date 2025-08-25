// lib/providers/driver_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/driver_model.dart';
import '../services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final driversByEmpresaProvider = FutureProvider.family<List<DriverModel>, String>((ref, empresaId) {
  return ref.watch(firestoreServiceProvider).getDriversByEmpresa(empresaId);
});

class DriverNotifier extends StateNotifier<AsyncValue<List<DriverModel>>> {
  final FirestoreService _firestoreService;
  final String _empresaId;

  DriverNotifier(this._firestoreService, this._empresaId)
      : super(const AsyncValue.loading()) {
    loadDrivers();
  }

  Future<void> loadDrivers() async {
    try {
      state = const AsyncValue.loading();
      final drivers = await _firestoreService.getDriversByEmpresa(_empresaId);
      state = AsyncValue.data(drivers);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createDriver(DriverModel driver) async {
    try {
      await _firestoreService.createDriver(driver);
      await loadDrivers();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateDriver(String driverId, Map<String, dynamic> data) async {
    try {
      await _firestoreService.updateDriver(driverId, data);
      await loadDrivers();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final driverNotifierProvider = StateNotifierProvider.family<DriverNotifier, AsyncValue<List<DriverModel>>, String>((ref, empresaId) {
  return DriverNotifier(ref.watch(firestoreServiceProvider), empresaId);
});
