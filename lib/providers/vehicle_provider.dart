// lib/providers/vehicle_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vehicle_model.dart';
import '../services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

final vehiclesByEmpresaProvider = FutureProvider.family<List<VehicleModel>, String>((ref, empresaId) {
  return ref.watch(firestoreServiceProvider).getVehiclesByEmpresa(empresaId);
});

class VehicleNotifier extends StateNotifier<AsyncValue<List<VehicleModel>>> {
  final FirestoreService _firestoreService;
  final String _empresaId;

  VehicleNotifier(this._firestoreService, this._empresaId)
      : super(const AsyncValue.loading()) {
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    try {
      state = const AsyncValue.loading();
      final vehicles = await _firestoreService.getVehiclesByEmpresa(_empresaId);
      state = AsyncValue.data(vehicles);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createVehicle(VehicleModel vehicle) async {
    try {
      await _firestoreService.createVehicle(vehicle);
      await loadVehicles(); // Recargar lista
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final vehicleNotifierProvider = StateNotifierProvider.family<VehicleNotifier, AsyncValue<List<VehicleModel>>, String>((ref, empresaId) {
  return VehicleNotifier(ref.watch(firestoreServiceProvider), empresaId);
});