// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/empresa_model.dart';
import '../models/driver_model.dart';
import '../models/vehicle_model.dart';
import '../models/line_model.dart';
import '../models/complaint_model.dart';
import '../models/position_model.dart';
import '../core/errors/exceptions.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CRUD Empresas
  Future<List<EmpresaModel>> getEmpresas() async {
    try {
      final snapshot = await _firestore.collection('empresas').get();
      return snapshot.docs
          .map((doc) => EmpresaModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw FirestoreException('Error obteniendo empresas: ${e.toString()}');
    }
  }

  Future<EmpresaModel?> getEmpresaById(String id) async {
    try {
      final doc = await _firestore.collection('empresas').doc(id).get();
      return doc.exists ? EmpresaModel.fromFirestore(doc) : null;
    } catch (e) {
      throw FirestoreException('Error obteniendo empresa: ${e.toString()}');
    }
  }

  Future<void> createEmpresa(EmpresaModel empresa) async {
    try {
      await _firestore.collection('empresas').add(empresa.toJson());
    } catch (e) {
      throw FirestoreException('Error creando empresa: ${e.toString()}');
    }
  }

  // CRUD Conductores
  Future<List<DriverModel>> getDriversByEmpresa(String empresaId) async {
    try {
      final snapshot = await _firestore
          .collection('drivers')
          .where('empresaId', isEqualTo: empresaId)
          .get();
      return snapshot.docs
          .map((doc) => DriverModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw FirestoreException('Error obteniendo conductores: ${e.toString()}');
    }
  }

  Future<DriverModel?> getDriverByUid(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('drivers')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty
          ? DriverModel.fromFirestore(snapshot.docs.first)
          : null;
    } catch (e) {
      throw FirestoreException('Error obteniendo conductor: ${e.toString()}');
    }
  }

  Future<void> createDriver(DriverModel driver) async {
    try {
      await _firestore.collection('drivers').add(driver.toJson());
    } catch (e) {
      throw FirestoreException('Error creando conductor: ${e.toString()}');
    }
  }

  Future<void> updateDriver(String driverId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('drivers').doc(driverId).update(data);
    } catch (e) {
      throw FirestoreException('Error actualizando conductor: ${e.toString()}');
    }
  }

  // CRUD Vehículos
  Future<List<VehicleModel>> getVehiclesByEmpresa(String empresaId) async {
    try {
      final snapshot = await _firestore
          .collection('vehicles')
          .where('empresaId', isEqualTo: empresaId)
          .get();
      return snapshot.docs
          .map((doc) => VehicleModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw FirestoreException('Error obteniendo vehículos: ${e.toString()}');
    }
  }

  Future<void> createVehicle(VehicleModel vehicle) async {
    try {
      await _firestore.collection('vehicles').add(vehicle.toJson());
    } catch (e) {
      throw FirestoreException('Error creando vehículo: ${e.toString()}');
    }
  }

  // CRUD Líneas
  Future<List<LineModel>> getLinesByEmpresa(String empresaId) async {
    try {
      final snapshot = await _firestore
          .collection('lines')
          .where('empresaId', isEqualTo: empresaId)
          .get();
      return snapshot.docs
          .map((doc) => LineModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw FirestoreException('Error obteniendo líneas: ${e.toString()}');
    }
  }

  Future<void> createLine(LineModel line) async {
    try {
      await _firestore.collection('lines').add(line.toJson());
    } catch (e) {
      throw FirestoreException('Error creando línea: ${e.toString()}');
    }
  }

  // CRUD Quejas
  Future<List<ComplaintModel>> getComplaintsByEmpresa(String empresaId) async {
    try {
      final snapshot = await _firestore
          .collection('complaints')
          .where('companyId', isEqualTo: empresaId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => ComplaintModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw FirestoreException('Error obteniendo quejas: ${e.toString()}');
    }
  }

  Future<void> createComplaint(ComplaintModel complaint) async {
    try {
      await _firestore.collection('complaints').add(complaint.toJson());
    } catch (e) {
      throw FirestoreException('Error creando queja: ${e.toString()}');
    }
  }

  Future<void> updateComplaint(String complaintId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('complaints').doc(complaintId).update(data);
    } catch (e) {
      throw FirestoreException('Error actualizando queja: ${e.toString()}');
    }
  }

  // Posiciones en tiempo real
  Stream<List<PositionModel>> getVehiclePositionsStream(String vehicleId) {
    return _firestore
        .collection('positions')
        .doc('${vehicleId}_positions')
        .collection('positions')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => PositionModel.fromFirestore(doc))
        .toList());
  }

  Future<void> updateVehiclePosition(PositionModel position) async {
    try {
      await _firestore
          .collection('positions')
          .doc('${position.vehicleId}_positions')
          .collection('positions')
          .add(position.toJson());
    } catch (e) {
      throw FirestoreException('Error actualizando posición: ${e.toString()}');
    }
  }

  // Stream para todas las posiciones de una línea
  Stream<List<PositionModel>> getLineVehiclesPositionsStream(String lineId) {
    return _firestore
        .collectionGroup('positions')
        .where('lineId', isEqualTo: lineId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      final Map<String, PositionModel> latestPositions = {};

      for (final doc in snapshot.docs) {
        final position = PositionModel.fromFirestore(doc);
        final vehicleId = position.vehicleId;

        if (!latestPositions.containsKey(vehicleId) ||
            position.timestamp.isAfter(latestPositions[vehicleId]!.timestamp)) {
          latestPositions[vehicleId] = position;
        }
      }

      return latestPositions.values.toList();
    });
  }
}