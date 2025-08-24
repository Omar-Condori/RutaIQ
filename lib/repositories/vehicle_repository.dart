// lib/repositories/vehicle_repository.dart
import '../models/vehicle_model.dart';
import '../services/firestore_service.dart';
import 'base_repository.dart';

class VehicleRepository implements BaseRepository<VehicleModel> {
  final FirestoreService _firestoreService;

  VehicleRepository(this._firestoreService);

  @override
  Future<List<VehicleModel>> getAll() async {
    throw UnimplementedError('Use getByEmpresa instead');
  }

  Future<List<VehicleModel>> getByEmpresa(String empresaId) async {
    return await _firestoreService.getVehiclesByEmpresa(empresaId);
  }

  @override
  Future<VehicleModel?> getById(String id) async {
    // Implementar según necesidades
    throw UnimplementedError();
  }

  @override
  Future<void> create(VehicleModel vehicle) async {
    await _firestoreService.createVehicle(vehicle);
  }

  @override
  Future<void> update(String id, VehicleModel vehicle) async {
    // Implementar actualización
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    // Implementar eliminación
    throw UnimplementedError();
  }

  Future<List<VehicleModel>> getActiveVehiclesByLine(String lineId) async {
    // Implementar consulta específica
    throw UnimplementedError();
  }
}